from dash import Dash, html

"""
Examples of different methods of adding local images to your Dash App
Note - Recommended to keep image files inside assets folder
- app.py
- assets/
    |-- my-image.png
"""

#Using direct image file path
image_path = 'assets/moscow.jpg'

app = Dash(__name__)

app.layout = html.Div([
    html.H1('Dash Puppies'),

    html.Img(src=image_path)])                          # passing the direct file path

if __name__ == "__main__":
    app.run_server(port=8053)