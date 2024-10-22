// Sample data for leaderboard
let leaderboard = [];

// Sample data for weekly steps and streak (initialize to zero)
let weeklySteps = 0;
let workoutStreak = 0;

// Function to calculate points based on steps
function calculatePoints(steps) {
    return steps * 0.1; // Example: 0.1 points for each step walked
}

// Function to render leaderboard
function renderLeaderboard() {
    const leaderboardBody = document.getElementById("leaderboard-body");
    leaderboardBody.innerHTML = ""; // Clear existing rows

    leaderboard.sort((a, b) => b.points - a.points).forEach((user, index) => {
        const row = document.createElement("tr");
        row.innerHTML = `<td>${index + 1}</td><td>${user.name}</td><td>${user.points.toFixed(2)}</td>`;
        leaderboardBody.appendChild(row);
    });
}

// Function to update progress bars
function updateProgressBars() {
    document.getElementById("steps-progress").innerText = weeklySteps;
    document.getElementById("streak-progress").innerText = workoutStreak;

    const maxSteps = 10000; // Example max steps for 100%
    const stepsPercentage = Math.min((weeklySteps / maxSteps) * 100, 100);
    const streakPercentage = Math.min((workoutStreak / 30) * 100, 100); // Assuming 30 days max streak

    document.querySelector(".progress-bar:nth-child(1) .progress").style.width = stepsPercentage + "%";
    document.querySelector(".progress-bar:nth-child(2) .progress").style.width = streakPercentage + "%";
}

// Event listener for activity logging
document.getElementById("activity-form").addEventListener("submit", function (e) {
    e.preventDefault(); // Prevent default form submission

    const userName = document.getElementById("name").value;
    const activityName = document.getElementById("activity").value;
    const stepsWalked = parseInt(document.getElementById("steps").value, 10);
    
    // Validate steps input
    if (isNaN(stepsWalked) || stepsWalked <= 0) {
        alert("Please enter a valid number of steps.");
        return;
    }

    // Calculate points based on steps
    const activityPoints = calculatePoints(stepsWalked);

    // Update user points and leaderboard
    const user = leaderboard.find(user => user.name === userName);

    if (user) {
        user.points += activityPoints; // Update user's points
    } else {
        leaderboard.push({ name: userName, points: activityPoints }); // Add new user
    }

    // Update user's weekly steps and workout streak
    weeklySteps += stepsWalked; // Add walked steps to weekly steps
    workoutStreak += 1; // Increment streak for each activity logged

    // Update progress bars
    updateProgressBars();

    // Reset form fields
    document.getElementById("name").value = '';
    document.getElementById("activity").value = '';
    document.getElementById("steps").value = '';

    // Render updated leaderboard
    renderLeaderboard();

    // Provide feedback to the user
    alert(`Great job! You earned ${activityPoints.toFixed(2)} points for your ${activityName} activity!`);
});

// Initial rendering of the leaderboard
renderLeaderboard();
