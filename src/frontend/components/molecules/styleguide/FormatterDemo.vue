<template>
  <v-container fluid>
    <Heading variant="h5">Yen Helper</Heading>
    <BodyText>
      To display standard Yen values format in the app, make use of the <strong>Yen</strong>
      helper component. The formatter also automatically adds comma every 3 digits.
    </BodyText>
    <BodyText>
      Do not use the decimal unless specified. The smallest unit is 1 yen. The default yen symbol is
      used.
    </BodyText>

    <ClientOnly>
      <highlightjs
        language="javascript"
        :code="yenCode"
        class="my-4"
      />
    </ClientOnly>

    <BodyText>Below are the examples on how it would be displayed:</BodyText>

    <JapanYen
      v-for="amount in amounts"
      :key="amount"
      :amount="amount"
    />

    <BodyText>
      If you want to use the <strong>kanji</strong> symbol for Yen, just set the props
      <strong>isKanji={`{true}`}</strong>.
    </BodyText>

    <ClientOnly>
      <highlightjs
        language="javascript"
        :code="yenCodeIsKanji"
        class="my-4"
      />
    </ClientOnly>

    <JapanYen
      v-for="amount in amounts"
      :key="amount"
      :amount="amount"
      :is-kanji="true"
    />

    <v-divider></v-divider>

    <Heading
      variant="h5"
      class="mt-8"
      >Japan Address Helper</Heading
    >
    <BodyText>
      To display standard Japan address format in the app, make use of the
      <strong>JapanAddress</strong> helper component. Make sure to provide the following
      <strong>Postal Code, Prefecture, City,</strong> and <strong>Building Name</strong>.
    </BodyText>

    <ClientOnly>
      <highlightjs
        language="javascript"
        :code="sampleAddress"
        class="my-4"
      />
    </ClientOnly>

    <BodyText>Below are the examples on how it would be displayed:</BodyText>

    <div
      v-for="(address, index) in addresses"
      :key="index"
      class="mb-4"
    >
      <JapanAddress
        :building-name="address.buildingName"
        :city="address.city"
        :prefecture="address.prefecture"
        :postal-code="address.postalCode"
      />
    </div>

    <v-divider></v-divider>

    <Heading
      variant="h5"
      class="mt-8"
      >Japan Phone Number Helper</Heading
    >
    <BodyText>
      To display standard Japan Phone Number format in the app, make use of the
      <strong>JapanPhoneNumber</strong> helper component. Make sure to provide the
      <strong>number</strong> prop.
    </BodyText>

    <ClientOnly>
      <highlightjs
        language="javascript"
        :code="samplePhone"
        class="my-4"
      />
    </ClientOnly>

    <BodyText>Below are the examples on how it would be displayed:</BodyText>

    <JapanPhoneNumber
      v-for="phone in phones"
      :key="phone"
      :number="phone"
    />

    <v-divider></v-divider>

    <Heading
      variant="h5"
      class="mt-8"
      >Japan Date Helper</Heading
    >
    <BodyText>
      To display standard Japan Date format in the app, make use of the
      <strong>JapanDate</strong> helper component. Make sure to provide the
      <strong>date</strong> prop. It will always display the 24-Hour time format.
    </BodyText>

    <ClientOnly>
      <highlightjs
        language="javascript"
        :code="sampleDate"
        class="my-4"
      />
    </ClientOnly>

    <BodyText>Below is the example on how it would be displayed:</BodyText>

    <JapanDate
      date="2022-07-25 18:45:02"
      :has-time="false"
    />

    <BodyText>
      If you want to display both date and time, make sure to set the
      <strong>:has-time="true"</strong>.
    </BodyText>

    <ClientOnly>
      <highlightjs
        language="javascript"
        :code="sampleDateTime"
        class="my-4"
      />
    </ClientOnly>

    <BodyText>Below is the example on how it would be displayed:</BodyText>

    <JapanDate
      date="2022-07-25 18:45:02"
      :has-time="true"
    />

    <BodyText>
      If not provided, the default value of <strong>separator</strong> prop is
      <strong>kanji</strong>. Other acceptable values for <strong>separator</strong> are
      <strong>(forward slash) /</strong> or <strong>(dash) - </strong>.
    </BodyText>

    <ClientOnly>
      <highlightjs
        language="javascript"
        :code="sampleDateSeparator"
        class="my-4"
      />
    </ClientOnly>

    <div
      v-for="separator in separators"
      :key="separator"
    >
      <BodyText>separator: {{ separator }}</BodyText>
      <JapanDate
        date="2022-07-25 18:45:02"
        :has-time="true"
        :separator="separator"
      />
    </div>
  </v-container>
</template>

<script setup>
import Heading from '~/components/atoms/Heading.vue';
import BodyText from '~/components/atoms/BodyText.vue';
import JapanYen from '~/components/atoms/Formatter/JapanYen.vue';
import JapanAddress from '~/components/atoms/Formatter/JapanAddress.vue';
import JapanPhoneNumber from '~/components/atoms/Formatter/JapanPhoneNumber.vue';
import JapanDate from '~/components/atoms/Formatter/JapanDate.vue';

const amounts = [1, 100, 1000, 10000, 100000, 1000000, 10000000, 100000000, 1000000000];
const addresses = [
  {
    buildingName: '丁目7-29',
    city: '横浜市鶴見区末広町1',
    prefecture: '神奈川県',
    postalCode: '2300045',
  },
  {
    buildingName: '丁目1-2',
    city: '都墨田区押上1',
    prefecture: '東京',
    postalCode: '1310045',
  },
  {
    buildingName: '丁目33-1',
    city: '千葉市若葉区桜木8',
    prefecture: '千葉県',
    postalCode: '2640028',
  },
];

const phones = ['09012345678', '080-5467-9837', '05089301928'];
const separators = ['kanji', '/', '-'];

const yenCode = `import JapanYen from 'components/atoms/Formatter/JapanYen';\n\n<JapanYen :amount="5500" />`;
const yenCodeIsKanji = `import JapanYen from 'components/atoms/Formatter/JapanYen';\n\n<JapanYen :amount="5500" :is-kanji="true" />`;
const sampleAddress = `import JapanAddress from 'components/atoms/Formatter/JapanAddress';\n
<JapanAddress
  buildingName="丁目1-2"
  city="都墨田区押上1"
  prefecture="東京"
  postalCode="1310045"
/>
`;
const samplePhone = `import JapanPhoneNumber from '~/components/atoms/Formatter/JapanPhoneNumber.vue';\n\n<JapanPhoneNumber number="09012345678" />`;
const sampleDate = `import JapanDate from '~/components/atoms/Formatter/JapanDate.vue';\n\n<JapanDate date="2022-07-25 18:45:02" />`;
const sampleDateTime = `import JapanDate from '~/components/atoms/Formatter/JapanDate.vue';\n\n<JapanDate date="2022-07-25 18:45:02" :has-time="true" />`;
const sampleDateSeparator = `import JapanDate from '~/components/atoms/Formatter/JapanDate.vue';\n\n<JapanDate date="2022-07-25 18:45:02" separator="/" />`;
</script>
