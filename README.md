<h1>Price Tracker App</h1>

<p><em>A real-time price tracker built using Flutter, BLoC (Business Logic Component) architecture, and WebSocket connection to monitor prices in Deriv markets.</em></p>

<h2>Features</h2>
<ul>
  <li>Select from a variety of markets available in Deriv.</li>
  <li>Based on market selection, choose from a list of available symbols.</li>
  <li>Display the current price of the selected symbol with color-coded text:</li>
  <ul>
    <li>Grey: Default color, indicating an unchanged price.</li>
    <li>Red: Indicates a price decrease.</li>
    <li>Green: Indicates a price increase.</li>
  </ul>
  <li>Real-time updates through WebSocket connection for accurate and timely price information.</li>
  <li>Efficiently manage state and business logic using BLoC architecture.</li>
  <li>Smooth user experience with loading indicators during symbol fetching and price updates.</li>
</ul>

<h2>App Flow</h2>
<ul>
  <li>The application starts with a loading indicator in the center while fetching active symbols using WebSocket connection.</li>
  <li>After selecting a market and a symbol, a loading indicator is shown in place of the symbol price while the new price stream is fetching through the WebSocket connection.</li>
  <li>The price text color dynamically changes to reflect price fluctuations in real-time, providing immediate insights to users.</li>
  <li>Users can easily switch symbols, and the app will repeat the process mentioned in the previous step to display updated prices with loading indicators.</li>
</ul>

<h2>Instructions</h2>
<h3>Prerequisites</h3>
<p>Ensure you have Flutter installed on your machine. Follow the Flutter installation guide <a href="https://flutter.dev/docs/get-started/install">here</a>.</p>

<h3>Running the App</h3>
<ol>
  <li>Clone this repository to your local machine.</li>
  <li>Navigate to the project directory in your terminal.</li>
  <li>Connect your mobile device or start an emulator.</li>
  <li>Run the following command to install dependencies:</li>
  <pre><code>flutter pub get</code></pre>
  <li>Run the app on your device/emulator:</li>
  <pre><code>flutter run</code></pre>
</ol>

<h2>Deriv WebSocket API Documentation</h2>
<p>For more information about the Deriv WebSocket API, please refer to the official documentation <a href="https://developers.deriv.com/docs/websockets">here</a>.</p>

<p><em>Enhance your trading experience with this user-friendly Price Tracker app that leverages Flutter, BLoC architecture, and WebSocket connection for real-time price monitoring.</em></p>
