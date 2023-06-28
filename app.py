from flask import Flask, render_template, send_from_directory

# Create a Flask application
app = Flask(__name__)

# Define a route for the home page
@app.route('/')
def home():
    # Render the HTML template
    return render_template('index.html')

# Define a route for serving static files (CSS, JavaScript, etc.)
@app.route('/static/<path:path>')
def serve_static(path):
    # Serve the file from the "static" directory
    return send_from_directory('static', path)

# Define a route for serving the MP4 file
@app.route('/videos/<path:path>')
def serve_video(path):
    # Serve the video file from the "videos" directory
    return send_from_directory('videos', path)

# Run the Flask application
if __name__ == '__main__':
    app.run()
