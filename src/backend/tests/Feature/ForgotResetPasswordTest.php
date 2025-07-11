<?php

namespace Tests\Feature;

use Tests\TestCase;
use App\Models\User;
use App\Models\UserStatus;
use App\Services\API\UserService;
use App\Exceptions\UserNotFoundException;
use App\Exceptions\InvalidPasswordResetTokenException;

class ForgotResetPasswordTest extends TestCase
{
    /** @var Array */
    private static $DATA = [
        'first_name' => 'John',
        'last_name' => 'Doe',
        'email' => 'john_base@nuxt-base.local',
        'password' => '!p4ssW0rd',
    ];

    /** @var string */
    protected static $PASSWORD = 'P@ssw0rd2020';

    /** @var String */
    private static $TOKEN;

    /** @var App\Models\User */
    private static $USER;

    /**
     * ForgotResetPasswordTest constructor.
     */
    public function __construct($name = 'ForgotResetPasswordTest')
    {
        parent::__construct($name);
        $this->createApplication();
    }

    public static function setUpBeforeClass(): void
    {
        parent::setUpBeforeClass();

        $userService = new UserService(new User());
        $status = UserStatus::where('name', 'Active')->first();
        self::$DATA['user_status_id'] = $status->id;
        // create user
        self::$USER = $userService->create(self::$DATA);
    }

    public static function tearDownAfterClass(): void
    {
        parent::tearDownAfterClass();
        // delete test account
        self::$USER->delete();
    }

    public function testForgotPasswordMissingParams()
    {
        $response = $this->json('POST', '/' . config('app.api_version') . '/password/forgot', []);
        $response->assertStatus(422)
            ->assertJson([
                'error' => [
                    'email' => ['The email field is required.']
                ]
            ]);
    }

    public function testForgotPasswordInvalidEmail()
    {
        $response = $this->json('POST', '/' . config('app.api_version') . '/password/forgot', ['email' => 'notAnEmail@']);
        $response->assertStatus(422)
            ->assertJson([
                'error' => [
                    'email' => ['Invalid email address.']
                ]
            ]);
    }

    public function testForgotPasswordUserNotFound()
    {
        $response = $this->json('POST', '/' . config('app.api_version') . '/password/forgot', ['email' => 'test@mail.com']);
        $response->assertStatus(500)
            ->assertJson([
                'error' => (new UserNotFoundException())->getMessage()
            ]);
    }

    public function testForgotPassword()
    {
        $response = $this->json('POST', '/' . config('app.api_version') . '/password/forgot', ['email' => self::$USER['email']]);
        $result = $response->getData();
        self::$TOKEN = $result->token;
        $response->assertStatus(200)
            ->assertJson([
                'token' => self::$TOKEN,
            ]);

        // $this->assertEquals(200, $response->getStatusCode());
        // $this->assertGreaterThan(0, strlen(self::$TOKEN));
    }

    public function testResetPasswordMissingParams()
    {
        $response = $this->json('POST', '/' . config('app.api_version') . '/password/reset', []);
        $response->assertStatus(422)
            ->assertJson([
                'error' => [
                    'token' => ['The token field is required.']
                ]
            ]);
    }

    public function testResetPasswordInvalidExpiredToken()
    {
        $response = $this->json(
            'POST',
            '/' . config('app.api_version') . '/password/reset',
            [
                'token' => 'RandomString',
                'password' => 'Password2022!',
                'password_confirmation' => 'Password2022!',
            ]
        );

        $response->assertStatus(500)
            ->assertJson([
                'error' => (new InvalidPasswordResetTokenException())->getMessage()
            ]);
    }

    public function testResetPasswordInvalidPasswordFormat()
    {
        $response = $this->json(
            'POST',
            '/' . config('app.api_version') . '/password/reset',
            [
                'token' => self::$TOKEN,
                'password' => 'notvalidpassword!',
                'password_confirmation' => 'notvalidpassword!',
            ]
        );

        $response->assertStatus(422)
            ->assertJson([
                'error' => [
                    'password' => ['Password must contain the following: 1 uppercase, 1 special character and a minimum of 8 characters.'],
                ]
            ]);
    }

    public function testResetPassword()
    {
        $response = $this->json(
            'POST',
            '/' . config('app.api_version') . '/password/reset',
            [
                'token' => self::$TOKEN,
                'password' => self::$PASSWORD,
                'password_confirmation' => self::$PASSWORD,
            ]
        );
        $response->assertStatus(200)
            ->assertJson([
                'reset' => true,
            ]);
    }
}
