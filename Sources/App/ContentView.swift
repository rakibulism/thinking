import SwiftUI

struct ContentView: View {
    @State private var isHoveringButton = false
    
    var body: some View {
        ZStack {
            // Background
            Color(red: 0.04, green: 0.04, blue: 0.04)
                .ignoresSafeArea()
            
            // Gradient Sphere
            Circle()
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: [Color(red: 0.42, green: 0.36, blue: 0.91).opacity(0.6), .clear]),
                        center: .center,
                        startRadius: 0,
                        endRadius: 300
                    )
                )
                .frame(width: 600, height: 600)
                .offset(x: 200, y: -100)
                .blur(radius: 60)
            
            VStack(spacing: 0) {
                // Navbar
                HStack {
                    Text("Vision.")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    HStack(spacing: 30) {
                        Text("Home").foregroundColor(.white)
                        Text("Features").foregroundColor(.gray)
                        Text("About").foregroundColor(.gray)
                        
                        Button(action: {}) {
                            Text("Get Started")
                                .fontWeight(.semibold)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(Color(red: 0.42, green: 0.36, blue: 0.91))
                                .foregroundColor(.white)
                                .cornerRadius(25)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 40)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 60) {
                        // Hero Section
                        HStack {
                            VStack(alignment: .leading, spacing: 20) {
                                Text("Welcome to the Future")
                                    .foregroundColor(Color(red: 0.64, green: 0.61, blue: 1.0))
                                    .fontWeight(.semibold)
                                
                                Text("Innovate Today")
                                    .font(.system(size: 64, weight: .bold))
                                    .foregroundColor(.white)
                                
                                Text("We deliver excellence.")
                                    .font(.title2)
                                    .foregroundColor(.gray)
                                
                                HStack(spacing: 20) {
                                    Button(action: {}) {
                                        Text("Explore Features")
                                            .fontWeight(.semibold)
                                            .padding(.horizontal, 25)
                                            .padding(.vertical, 12)
                                            .background(Color(red: 0.42, green: 0.36, blue: 0.91))
                                            .foregroundColor(.white)
                                            .cornerRadius(30)
                                    }
                                    .buttonStyle(.plain)
                                    
                                    Button(action: {}) {
                                        Text("Contact Us")
                                            .fontWeight(.semibold)
                                            .padding(.horizontal, 25)
                                            .padding(.vertical, 12)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 30)
                                                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                            )
                                            .foregroundColor(.white)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.top, 60)
                            
                            Spacer()
                            
                            // Glass Card Visual
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(.ultraThinMaterial)
                                    .frame(width: 300, height: 200)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.white.opacity(0.1), lineWidth: 1)
                                    )
                                    .rotationEffect(.degrees(-5))
                                
                                Text("🚀 Success")
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.horizontal, 60)
                        
                        // Features Section
                        VStack(alignment: .leading) {
                            Text("Our Features")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.bottom, 40)
                            
                            HStack(spacing: 30) {
                                FeatureCard(title: "High Performance", description: "Optimized for speed and efficiency.", color1: Color(red: 1.0, green: 0.42, blue: 0.42), color2: Color(red: 1.0, green: 0.79, blue: 0.34))
                                FeatureCard(title: "Secure Design", description: "Built with security first principles.", color1: Color(red: 0.33, green: 0.63, blue: 1.0), color2: Color(red: 0.37, green: 0.15, blue: 0.8))
                                FeatureCard(title: "Scalable", description: "Grow your business without limits.", color1: Color(red: 0.28, green: 0.86, blue: 0.98), color2: Color(red: 0.11, green: 0.82, blue: 0.63))
                            }
                        }
                        .padding(.horizontal, 60)
                        
                        Spacer().frame(height: 50)
                    }
                }
            }
        }
    }
}

struct FeatureCard: View {
    let title: String
    let description: String
    let color1: Color
    let color2: Color
    
    var body: some View {
        VStack(alignment: .leading) {
            LinearGradient(gradient: Gradient(colors: [color1, color2]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(height: 120)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Text("Learn More →")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(red: 0.64, green: 0.61, blue: 1.0))
                    .padding(.top, 10)
            }
            .padding(20)
        }
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white.opacity(0.1), lineWidth: 1)
        )
    }
}
