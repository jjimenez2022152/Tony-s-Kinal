/*
Nombres: José Alejandro Jiménez de la Cruz
Carnet: 2022152
código Técnico: IN5BV
Fecha de creación: 14/04/2023
Fecha de modificación: 14/04/2023 a las 9:30 pm
                        18/04/2023 de 7:30 a 10:33 pm
                        20/04/2023 
                        21/04/2023
                        28/04/2023 de 12:50 a 2:11 am
                        29/04/2023 de 12:50 a 10:44 pm
                      
Hora Finalización: 10:45 pm
 */
package org.josejimenez.main;

import java.io.IOException;
import java.io.InputStream;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.fxml.JavaFXBuilderFactory;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.image.Image;
import javafx.scene.layout.AnchorPane;
import javafx.stage.Stage;
import org.josejimenez.controller.EmpresaController;
import org.josejimenez.controller.MenuPrincipalController;
import org.josejimenez.controller.PresupuestoController;
import org.josejimenez.controller.ProductoController;
import org.josejimenez.controller.ProgramadorController;
import org.josejimenez.controller.TipoEmpleadoController;
import org.josejimenez.controller.TipoPlatoController;


public class Principal extends Application {
    private final String PAQUETE_VISTA = "/org/josejimenez/view/";
    private Stage escenarioPrincipal;
    private Scene escena;
    
    @Override
    public void start(Stage escenarioPrincipal) throws Exception {
        this.escenarioPrincipal = escenarioPrincipal;
        this.escenarioPrincipal.setTitle("Tony's Kinal 2023");
        this.escenarioPrincipal.getIcons().add(new Image("/org/josejimenez/image/LogoDosSecundario.PNG"));
//        Parent root = FXMLLoader.load(getClass().getResource("/org/josejimenez/view/MenuPrincipalView.fxml"));
//        Parent root = FXMLLoader.load(getClass().getResource("/org/josejimenez/view/ProgramadorView.fxml"));
//        Parent root = FXMLLoader.load(getClass().getResource("/org/josejimenez/view/EmpresaView.fxml"));
//        Scene escena = new Scene(root);
//        escenarioPrincipal.setScene(escena);
        menuPrincipal();
        escenarioPrincipal.show();
    }
    public void menuPrincipal(){
        try{
            MenuPrincipalController menu = (MenuPrincipalController)cambiarEscena("MenuPrincipalView.fxml", 820, 590);
            menu.setEscenarioPrincipal(this);
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public void ventanaProgramador(){
        try{
            ProgramadorController ventanaP = (ProgramadorController)cambiarEscena("ProgramadorView.fxml", 600, 400);
            ventanaP.setEscenarioPrincipal(this);
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public void ventanaEmpresa(){
        try{
            EmpresaController ventanaP = (EmpresaController)cambiarEscena("EmpresasView.fxml", 829, 504);
            ventanaP.setEscenarioPrincipal(this);
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public void ventanaPresupuesto(){
        try {
            PresupuestoController presupuestoController = (PresupuestoController)cambiarEscena("PresupuestosView.fxml", 904, 504);
            presupuestoController.setEscenarioPrincipal(this);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    
    public void ventanaTipoPlato(){
        try{
            TipoPlatoController ventanaP = (TipoPlatoController)cambiarEscena("TipoPlatoView.fxml", 829, 504);
            ventanaP.setEscenarioPrincipal(this);
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public void ventanaProducto(){
        try{
            ProductoController ventanaP = (ProductoController)cambiarEscena("ProductosView.fxml", 829, 504);
            ventanaP.setEscenarioPrincipal(this);
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public void ventanaTipoEmpleado(){
        try{
            TipoEmpleadoController ventanaP = (TipoEmpleadoController)cambiarEscena("TipoEmpleadoView.fxml", 829, 504);
            ventanaP.setEscenarioPrincipal(this);
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    
    
    public static void main(String[] args) {
        launch(args);
    }
    public Initializable cambiarEscena(String fxml, int ancho, int alto) throws Exception{
        Initializable resultado = null;
        FXMLLoader cargadorFXML = new FXMLLoader();
        InputStream archivo = Principal.class.getResourceAsStream(PAQUETE_VISTA+fxml);
        cargadorFXML.setBuilderFactory(new JavaFXBuilderFactory());
        cargadorFXML.setLocation(Principal.class.getResource(PAQUETE_VISTA+fxml));
        escena = new Scene((AnchorPane)cargadorFXML.load(archivo),ancho,alto);
        escenarioPrincipal.setScene(escena);
        escenarioPrincipal.sizeToScene();
        resultado = (Initializable)cargadorFXML.getController();
        return resultado;
    }
    
}
