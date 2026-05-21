const API_BASE_URL = 'http://localhost:3000';

async function request(path, options = {}) {
  const response = await fetch(`${API_BASE_URL}${path}`, {
    headers: {
      'Content-Type': 'application/json',
      ...(options.headers || {}),
    },
    ...options,
  });

  if (!response.ok) {
    throw new Error(`Request failed with status ${response.status}`);
  }

  const contentType = response.headers.get('content-type') || '';
  if (contentType.includes('application/json')) {
    return response.json();
  }

  return response.text();
}

function renderResponse(message) {
  const responseBox = document.getElementById('responseBox');
  responseBox.textContent = typeof message === 'string' ? message : JSON.stringify(message, null, 2);
}

async function handleTestRequest() {
  try {
    renderResponse('Enviando requisição...');
    const data = await request('/', { method: 'GET' });
    renderResponse(data);
  } catch (error) {
    renderResponse(`Erro no AJAX: ${error.message}`);
  }
}

document.getElementById('loadDataBtn').addEventListener('click', handleTestRequest);