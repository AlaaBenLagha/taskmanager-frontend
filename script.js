/**
 * Vanilla JavaScript client for managing tasks.  This script fetches
 * the list of tasks from the backend API and renders them in a table.
 * Users can create, edit and delete tasks without reloading the page.
 */

// Helper to fetch and render tasks
async function loadTasks() {
  try {
    const response = await fetch('/api/tasks');
    if (!response.ok) throw new Error('Failed to load tasks');
    const tasks = await response.json();
    const tbody = document.querySelector('#tasks-table tbody');
    tbody.innerHTML = '';
    tasks.forEach(task => {
      const row = document.createElement('tr');
      row.innerHTML = `
        <td>${task.title}</td>
        <td>${task.description || ''}</td>
        <td>
          <button data-id="${task.id}" class="edit-btn">Edit</button>
          <button data-id="${task.id}" class="delete-btn">Delete</button>
        </td>`;
      tbody.appendChild(row);
    });
  } catch (err) {
    console.error(err);
    alert('Error loading tasks');
  }
}

// Handle form submission
document.getElementById('task-form').addEventListener('submit', async event => {
  event.preventDefault();
  const title = document.getElementById('title').value.trim();
  const description = document.getElementById('description').value.trim();
  if (!title) return;
  try {
    const response = await fetch('/api/tasks', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ title, description })
    });
    if (!response.ok) throw new Error('Failed to create task');
    document.getElementById('title').value = '';
    document.getElementById('description').value = '';
    loadTasks();
  } catch (err) {
    console.error(err);
    alert('Error creating task');
  }
});

// Delegate edit and delete buttons
document.querySelector('#tasks-table tbody').addEventListener('click', async event => {
  const id = event.target.dataset.id;
  if (!id) return;
  if (event.target.classList.contains('delete-btn')) {
    // Delete task
    if (!confirm('Delete this task?')) return;
    try {
      const response = await fetch(`/api/tasks/${id}`, { method: 'DELETE' });
      if (!response.ok) throw new Error('Failed to delete task');
      loadTasks();
    } catch (err) {
      console.error(err);
      alert('Error deleting task');
    }
  } else if (event.target.classList.contains('edit-btn')) {
    // Edit task
    const titleCell = event.target.parentElement.parentElement.children[0];
    const descCell = event.target.parentElement.parentElement.children[1];
    const newTitle = prompt('Enter new title', titleCell.textContent.trim());
    if (newTitle === null) return; // Cancelled
    const newDesc = prompt('Enter new description', descCell.textContent.trim());
    try {
      const response = await fetch(`/api/tasks/${id}`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ title: newTitle, description: newDesc })
      });
      if (!response.ok) throw new Error('Failed to update task');
      loadTasks();
    } catch (err) {
      console.error(err);
      alert('Error updating task');
    }
  }
});

// Initial load
document.addEventListener('DOMContentLoaded', loadTasks);