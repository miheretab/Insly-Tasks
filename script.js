function getUserTime() {
    var userTime = document.getElementById('user-time');
    var now = new Date().toLocaleString();
    userTime.value = now;
    return true;
}
