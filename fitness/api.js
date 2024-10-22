// Simulated API for activity logging and leaderboard
const api = {
    logActivity: function (name, points) {
        // Here you could make an AJAX request to a real server
        return Promise.resolve({ success: true, name, points });
    },

    getLeaderboard: function () {
        // Return a promise that resolves with the leaderboard data
        return Promise.resolve(leaderboard);
    }
};
