import SwiftUI
import FloatingButton

struct FloatingButtonView: View {
    @Binding var isOpen: Bool

    var body: some View {
        let mainButton = AnyView(
            Button(action: {
                self.isOpen.toggle()
            }) {
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .clipShape(Circle())
                    .shadow(radius: 10)
            }
        )

        let buttons = [
            AnyView(Button(action: { print("Action 1") }) {
                Image(systemName: "pencil")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .clipShape(Circle())
            }),
            AnyView(Button(action: { print("Action 2") }) {
                Image(systemName: "trash")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .clipShape(Circle())
            }),
            AnyView(Button(action: { print("Action 3") }) {
                Image(systemName: "square.and.arrow.up")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.orange)
                    .clipShape(Circle())
            })
        ]

        return FloatingButton(mainButtonView: mainButton, buttons: buttons, isOpen: $isOpen)
            .straight()
            .direction(.top)
            .alignment(.right)
            .spacing(20)
            .initialOffset(x: 1000)
            .animation(.spring())
            .padding(.trailing, 20) // Adiciona um espaçamento à direita
            .padding(.bottom, 20) // Adiciona um espaçamento na parte inferior
    }
}

// Previews
struct FloatingButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            // Simula a tela principal para contexto
            Color.white.edgesIgnoringSafeArea(.all)

            // Posiciona o FloatingButtonView no canto inferior direito
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    FloatingButtonView(isOpen: .constant(false))
                }
            }
        }
    }
}
