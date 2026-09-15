console.log('[COPYCAMERA] JS LOADED');

const copyCamera = document.getElementById('copycamera');
const copyCameraInput = document.getElementById('copycamera-input');
const copyCameraStatus = document.getElementById('copycamera-status');

window.addEventListener('message', function (event) {
  console.log('[COPYCAMERA] MESSAGE:', event.data);

  const data = event.data;

  if (!data) {
    return;
  }

  if (data.action === 'open_copycamera') {
    console.log('[COPYCAMERA] OPENING');

    copyCameraInput.value = data.cameraData || '';
    copyCameraStatus.textContent = '';

    copyCamera.style.display = 'flex';
  }
});

document.getElementById('copycamera-copy').addEventListener('click', function () {
  const text = copyCameraInput.value;

  navigator.clipboard.writeText(text).then(function () {
    copyCameraStatus.textContent = 'Coordinates copied.';
  }).catch(function () {
    copyCameraInput.focus();
    copyCameraInput.select();
    document.execCommand('copy');

    copyCameraStatus.textContent = 'Coordinates copied.';
  });
});

document.getElementById('copycamera-close').addEventListener('click', function () {
  copyCamera.style.display = 'none';

  fetch(`https://${GetParentResourceName()}/copycamera_close`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({})
  });
});

document.addEventListener('keydown', function (event) {
  if (event.key === 'Escape') {
    copyCamera.style.display = 'none';

    fetch(`https://${GetParentResourceName()}/copycamera_close`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({})
    });
  }
});