import Elm from './elm/main';
import Recaptcha from './components/recaptcha';

window.customElements.define('g-recaptcha', Recaptcha);

window.onloadCallback = () => {
  const formContainer = document.querySelector('#form_container');
  if (formContainer) {
    Elm.Main.embed(formContainer);
  }
};

