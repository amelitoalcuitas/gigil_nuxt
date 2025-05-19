<script setup lang="ts">
import draggable from 'vuedraggable'

interface Task {
  id: number
  title: string
  description: string
  status: 'todo' | 'in-progress' | 'done'
  priority: 'low' | 'medium' | 'high'
  assignee?: string
  dueDate?: string
}

interface Column {
  id: string
  title: string
  tasks: Task[]
}

const columns = ref<Column[]>([
  {
    id: 'todo',
    title: 'To Do',
    tasks: []
  },
  {
    id: 'in-progress',
    title: 'In Progress',
    tasks: []
  },
  {
    id: 'done',
    title: 'Done',
    tasks: []
  }
])

const newTask = ref({
  title: '',
  description: '',
  status: 'todo' as const,
  priority: 'medium' as const,
  assignee: '',
  dueDate: ''
})

const showNewTaskModal = ref(false)

const addTask = () => {
  if (!newTask.value.title.trim()) return

  const task: Task = {
    id: Date.now(),
    title: newTask.value.title.trim(),
    description: newTask.value.description,
    status: newTask.value.status,
    priority: newTask.value.priority,
    assignee: newTask.value.assignee,
    dueDate: newTask.value.dueDate
  }

  const column = columns.value.find((col) => col.id === task.status)
  if (column) {
    column.tasks.push(task)
  }

  newTask.value = {
    title: '',
    description: '',
    status: 'todo',
    priority: 'medium',
    assignee: '',
    dueDate: ''
  }
  showNewTaskModal.value = false
}

const onDragEnd = (evt: {
  from: HTMLElement
  to: HTMLElement
  item: HTMLElement
  newIndex?: number
  oldIndex?: number
}) => {
  const { from, to, item, newIndex, oldIndex } = evt

  if (newIndex === undefined || oldIndex === undefined) return

  // 'from' and 'to' are the DOM elements of the lists themselves
  const fromColumnId = from.dataset.columnId
  const toColumnId = to.dataset.columnId
  const taskId = parseInt(item.dataset.taskId || '0')

  if (!fromColumnId || !toColumnId || !taskId) return

  const fromColumn = columns.value.find((col) => col.id === fromColumnId)
  const toColumn = columns.value.find((col) => col.id === toColumnId)

  if (!fromColumn || !toColumn) return

  // Find the task in the source column based on its ID
  const taskIndexInFromColumn = fromColumn.tasks.findIndex((t) => t.id === taskId)
  if (taskIndexInFromColumn === -1) return

  const taskToMove = fromColumn.tasks[taskIndexInFromColumn]

  if (taskToMove && fromColumnId !== toColumnId) {
    taskToMove.status = toColumn.id as 'todo' | 'in-progress' | 'done'
  }
  // If just reordering within the same column, vuedraggable's v-model handles it automatically.
}

const getPriorityIcon = (priority: Task['priority']) => {
  switch (priority) {
    case 'high':
      return 'i-lucide-arrow-up'
    case 'medium':
      return 'i-lucide-minus'
    case 'low':
      return 'i-lucide-arrow-down'
  }
}
</script>

<template>
  <div class="h-[calc(100vh-64px)] flex flex-col p-4 md:p-6 w-full">
    <div class="flex flex-col sm:flex-row justify-between sm:items-center mb-6">
      <div>
        <h1 class="text-2xl font-bold text-gray-900 dark:text-white">Project Tracker</h1>
        <p class="text-gray-500 dark:text-gray-400 mt-1">
          Manage your project tasks and track progress effectively.
        </p>
      </div>

      <UModal
        v-model:open="showNewTaskModal"
        title="Add New Task"
        @close="showNewTaskModal = false"
      >
        <UButton
          icon="i-lucide-plus"
          color="primary"
          class="mt-4 sm:mt-0"
        >
          Add Task
        </UButton>

        <template #body>
          <div class="space-y-4 w-full">
            <UFormField
              label="Title"
              required
              name="title"
            >
              <UInput
                v-model="newTask.title"
                class="w-full"
                placeholder="Enter task title"
                autofocus
              />
            </UFormField>

            <UFormField
              label="Description"
              name="description"
            >
              <UTextarea
                v-model="newTask.description"
                class="w-full"
                placeholder="Enter task description"
                :rows="3"
              />
            </UFormField>

            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
              <UFormField
                label="Status"
                name="status"
              >
                <USelect
                  v-model="newTask.status"
                  :items="[
                    { label: 'To Do', value: 'todo' },
                    { label: 'In Progress', value: 'in-progress' },
                    { label: 'Done', value: 'done' }
                  ]"
                />
              </UFormField>

              <UFormField
                label="Priority"
                name="priority"
              >
                <USelect
                  v-model="newTask.priority"
                  :items="[
                    { label: 'Low', value: 'low' },
                    { label: 'Medium', value: 'medium' },
                    { label: 'High', value: 'high' }
                  ]"
                />
              </UFormField>
            </div>

            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
              <UFormField
                label="Assignee"
                name="assignee"
              >
                <UInput
                  v-model="newTask.assignee"
                  placeholder="Assignee name"
                  icon="i-lucide-user"
                />
              </UFormField>

              <UFormField
                label="Due Date"
                name="dueDate"
              >
                <UInput
                  v-model="newTask.dueDate"
                  type="date"
                  icon="i-lucide-calendar"
                />
              </UFormField>
            </div>
          </div>
        </template>

        <template #footer>
          <div class="flex justify-end gap-3 w-full">
            <UButton
              color="neutral"
              variant="ghost"
              @click="showNewTaskModal = false"
            >
              Cancel
            </UButton>
            <UButton
              color="primary"
              :disabled="!newTask.title.trim()"
              @click="addTask"
            >
              Add Task
            </UButton>
          </div>
        </template>
      </UModal>
    </div>

    <div class="grid grid-cols-1 md:grid-cols-3 gap-4 flex-1 min-h-0">
      <div
        v-for="column in columns"
        :key="column.id"
        class="bg-gray-100 dark:bg-gray-800/50 rounded-lg p-4 border border-gray-200 dark:border-gray-700 flex flex-col"
      >
        <div class="flex items-center justify-between mb-4">
          <h2 class="text-lg font-semibold text-gray-900 dark:text-white">{{ column.title }}</h2>
          <UBadge
            :color="
              column.id === 'todo' ? 'neutral' : column.id === 'in-progress' ? 'warning' : 'success'
            "
            variant="subtle"
          >
            {{ column.tasks.length }}
          </UBadge>
        </div>
        <draggable
          v-model="column.tasks"
          :group="{ name: 'tasks' }"
          item-key="id"
          :data-column-id="column.id"
          class="space-y-3 flex-1 overflow-y-auto"
          @end="onDragEnd"
        >
          <template #item="{ element }">
            <div
              :data-task-id="element.id"
              class="bg-white dark:bg-gray-800 p-4 rounded-lg shadow-sm border border-gray-200 dark:border-gray-700 hover:shadow-md transition-shadow cursor-grab"
            >
              <div class="flex justify-between items-start gap-2">
                <h3 class="font-medium text-gray-900 dark:text-gray-100 flex-1 break-words">
                  {{ element.title }}
                </h3>
                <UBadge
                  :color="
                    element.priority === 'high'
                      ? 'error'
                      : element.priority === 'medium'
                      ? 'warning'
                      : 'success'
                  "
                  variant="soft"
                  size="sm"
                >
                  <UIcon
                    :name="getPriorityIcon(element.priority)"
                    class="mr-1"
                  />
                  {{ element.priority }}
                </UBadge>
              </div>
              <p class="text-sm text-gray-600 dark:text-gray-400 mt-2 line-clamp-3 break-words">
                {{ element.description }}
              </p>
              <div
                class="mt-3 flex flex-col sm:flex-row sm:items-center sm:justify-between text-xs space-y-1 sm:space-y-0"
              >
                <div
                  v-if="element.assignee"
                  class="flex items-center gap-1 text-gray-500 dark:text-gray-400"
                >
                  <UIcon
                    name="i-lucide-user-circle"
                    class="w-3.5 h-3.5"
                  />
                  <span>{{ element.assignee }}</span>
                </div>
                <div
                  v-if="element.dueDate"
                  class="flex items-center gap-1 text-gray-500 dark:text-gray-400"
                >
                  <UIcon
                    name="i-lucide-calendar-days"
                    class="w-3.5 h-3.5"
                  />
                  <span>{{ new Date(element.dueDate).toLocaleDateString() }}</span>
                </div>
              </div>
            </div>
          </template>
        </draggable>
      </div>
    </div>
  </div>
</template>
