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


function copyToClipboard(text) {
  var e = document.createElement('textarea');
  e.textContent = text;
  document.body.appendChild(e);

  var selection = document.getSelection();
  selection.removeAllRanges();

  e.select();
  document.execCommand('copy');

  selection.removeAllRanges();
  e.remove();
}

document.getElementById('copycamera-copy').addEventListener('click', function () {
  const text = copyCameraInput.value;

  copyToClipboard(text);

  copyCameraStatus.textContent = 'Coordinates copied.';
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
