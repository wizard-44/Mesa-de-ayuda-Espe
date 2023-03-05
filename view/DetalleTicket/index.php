<?php
    require_once("../../config/conexion.php"); 
    if(isset($_SESSION["usu_id"])){
?>
<!DOCTYPE html>
<html>
    <?php
        require_once("../MainHead/head.php");
    ?>
	<title>Detalle Ticket</title>
</head>
<body class="with-side-menu">

    <?php
        require_once("../MainHeader/header.php");
    ?>

	<div class="mobile-menu-left-overlay"></div>

	<?php
        require_once("../MainNav/nav.php");
    ?>

	<div class="page-content">
		<div class="container-fluid">

            <header class="section-header">
                <div class="tbl">
                    <div class="tbl-row">
                        <div class="tbl-cell">
                            <h3 id="lblnomidticket"></h3>
                            <div id="lblestado"></div>
                            <span class="label label-pill label-primary" id="lblnomusuario"></span>
                            <span class="label label-pill label-default" id="lblfechcrea"></span>
                            <ol class="breadcrumb breadcrumb-simple">
                                <li><a href="#">Home</a></li>
                                <li class="active">Detalle Ticket</li>
                            </ol>
                        </div>
                    </div>
                </div>
            </header>

            <div class="box-typical box-typical-padding">
                <div class="row">
                                        
                    <div class="col-lg-12">
                        <fieldset class="form-group">
                            <label class="form-label semibold" for="tick_titulo">Titulo</label>
                            <input type="text" class="form-control" id="tick_titulo" name="tick_titulo" readonly>
                        </fieldset>
                    </div>

                    <div class="col-lg-4">
                        <fieldset class="form-group">
                            <label class="form-label semibold" for="exampleInput">Categoria</label>
                            <input type="text" class="form-control" id="cat_nom" name="cat_nom" readonly>
                        </fieldset>
                    </div>

                    <div class="col-lg-4">
                        <fieldset class="form-group">
                        <label class="form-label semibold" for="cat_nom">SubCategoria</label>
                        <input type="text" class="form-control" id="cats_nom" name="cats_nom" readonly>
                        </fieldset>
                    </div>

                    <div class="col-lg-4">
                        <fieldset class="form-group">
                        <label class="form-label semibold" for="cat_nom">Prioridad</label>
                        <input type="text" class="form-control" id="prio_nom" name="prio_nom" readonly>
                        </fieldset>
                    </div>

                    <div class="col-lg-12">
                        <fieldset class="form-group">
                            <label class="form-label semibold" for="tick_titulo">Documentos Adicionales</label>
                            <table id="documentos_data" class="table table-bordered table-striped table-vcenter">
                                <thead>
                                <tr>
                                    <th style="width: 90%;">Nombre</th>
                                    <th class="text-center" style="width: 10%;"></th>
                                </tr>
                                </thead>
                                <tbody>

                                </tbody>
                            </table>
                        </fieldset>    
                    </div>  

                    <div class="col-lg-12">
                        <fieldset class="form-group">
                            <label class="form-label semibold" for="tickd_descripusu">Descripción</label>
                            <div class="summernote-theme-1">
                                <textarea id="tickd_descripusu" name="tickd_descripusu" class="summernote" name="name"></textarea>
                            </div>
                        </fieldset>
                    </div>

                </div>
            </div>

            <section class="activity-line" id="lbldetalle">

			</section>

            <div class="box-typical box-typical-padding" id="pnldetalle">
				<p>Ingrese su duda o consulta</p>

                <div class="row">  

                    <div class="col-lg-12">
                        <fieldset class="form-group">
                            <label class="form-label semibold" for="tickd_descrip">Descripción</label>
                            <div class="summernote-theme-1">
                                <textarea id="tickd_descrip" name="tickd_descrip" class="summernote" name="name"></textarea>
                            </div>
                        </fieldset>
                    </div>

                    <!--  Agregar archivos adjuntos -->
                    <div class="col-lg-12">
                        <fieldset class="form-group">
                        <label class="form-label semibold" for="fileElem">Documentos Adicionales</label>
                        <input type="file" name="fileElem" id="fileElem" class="form-control" multiple>
                        </fieldset>
                    </div>

                    <div class="col-lg-12">
                        <button type="button" id="btnenviar" class="btn btn-inline btn-success">Enviar</button>
                        
                        <?php
                            if($_SESSION["rol_id"]==2){
                                ?>
                                <button type="button" id="btnchatgpt" class="btn btn-rounded btn-inline btn-secondary">ChatGpt</button>
                                <?php
                            }
                        ?>

                        <button type="button" id="btncerrarticket" class="btn btn-inline btn-info">Cerrar Ticket</button>
                    </div>
                </div>
            </div>

		</div>
	</div>
    <?php
        require_once("../MainJS/js.php");
    ?>
    <script type="text/javascript" src="detalleticket.js"></script>

    <script type="text/javascript" src="../notificacion.js"></script>
	
</body>
</html>
<?php
  } else {
    header("Location:".Conectar::ruta()."index.php");
  }
?>