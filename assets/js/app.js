import Elm from './elm/main';

const formContainer = document.querySelector('#form_container');

if (formContainer) {
  const app = Elm.Main.embed(formContainer);
}
