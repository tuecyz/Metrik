<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.FileReader.*" %>
<%@ page import="java.io.FileWriter.*" %>
<%@ page import="java.io.IOException.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.mycompany.staj1.VT_Islemler"%>
<!DOCTYPE html>
<html>
<head>
    <title>Etkimetric</title>
    <!-- Favicon -->
    <link rel="icon" href="img/core-img/favicon.ico">

    <!-- Core Stylesheet -->
    <link rel="stylesheet" href="css/style.css">

    <!-- Responsive Stylesheet -->
    <link rel="stylesheet" href="css/responsive.css">

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.7.1.min.js"></script>
    <script type="text/javascript" src="staj.js"></script>
    <script src="https://code.jscharting.com/latest/jscharting.js"></script>
    <meta name="description" content="">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <script type="text/javascript">
        function getData1() {
            console.log(data);
        }
    </script>
    <link rel="stylesheet" type="text/css" href="css/default.css" />

</head>
<body class="light-version">
    <!-- Preloader -->
    <div id="preloader">
        <div class="preload-content">
            <div id="dream-load"></div>
        </div>
    </div>

    <!-- ##### Header Area Start ##### -->
    <header class="header-area fadeInDown" data-wow-delay="0.2s">
        <div class="classy-nav-container light breakpoint-off">
            <div class="container">
                <!-- Classy Menu -->
                <nav class="classy-navbar light justify-content-between" id="dreamNav">

                    <!-- Logo -->
                    <a class="nav-brand light" href="#"><img src="img/core-img/logo.png" alt="logo"> Montrix </a>

                    <!-- Navbar Toggler -->
                    <div class="classy-navbar-toggler demo">
                        <span class="navbarToggler"><span></span><span></span><span></span></span>
                    </div>

                    <!-- Menu -->
                    <div class="classy-menu">

                        <!-- close btn -->
                        <div class="classycloseIcon">
                            <div class="cross-wrap"><span class="top"></span><span class="bottom"></span></div>
                        </div>

                        <!-- Nav Start -->
                        <div class="classynav">
                            <ul id="nav">
                                <li><a href="#home">Home</a>
                                    <ul class="dropdown">
                                        <li><a href="index-demo-1.html">Home style 1</a></li>
                                        <li><a href="index-demo-2.html">Home style 2</a></li>
                                        <li><a href="index-demo-3.html">Home style 3</a></li>
                                        <li><a href="index-demo-4.html">Home style 4</a></li>
                                        <li><a href="index-demo-5.html">Home style 5</a></li>
                                        <li><a href="index-demo-6.html">Home style 6</a></li>
                                    </ul>
                                </li>
                                <li><a href="about-us.html">About Us</a></li>
                                <li><a href="services.html">Services</a></li>
                                <li><a href="faq.html">FAQ</a></li>
                                <li><a href="#blog">Blog</a>
                                    <ul class="dropdown">
                                        <li><a href="index-blog.html">Blog Posts</a></li>
                                        <li><a href="index-blog-with-sidebar.html">Sidebar Blog </a></li>
                                        <li><a href="index-single-blog.html">Blog Details</a></li>
                                    </ul>
                                </li>
                                <li><a href="contact-us.html">Contact</a></li>
                            </ul>

                            <!-- Button -->
                            <a href="#" class="btn login-btn ml-50">Log in</a>
                        </div>
                        <!-- Nav End -->
                    </div>
                </nav>
            </div>
        </div>
    </header>
    <div class="breadcumb-area clearfix dzsparallaxer auto-init" data-options='{direction: "normal"}'>
        <div class="divimage dzsparallaxer--target" style="width: 101%; height: 130%; background-image: url(img/bg-img/bg-2.jpg)"></div>
        <!-- breadcumb content -->
        <div class="breadcumb-content">
            <div class="container h-100">
                <div class="row h-100 align-items-center">
                    <div class="col-12">
                        <nav aria-label="breadcrumb" class="breadcumb--con text-center">
                            <h2 class="w-text title wow fadeInUp" data-wow-delay="0.2s">SideBar Blog</h2>
                            <ol class="breadcrumb justify-content-center wow fadeInUp" data-wow-delay="0.4s">
                                <li class="breadcrumb-item"><a href="#">Home</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Blog</li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%
        VT_Islemler sq = new VT_Islemler();
        String doi = request.getParameter("DOI");

        JSONObject sonuc = sq.getJSONviaDOI(doi);
        //out.println(sonuc);
        JSONObject Sobiad = (JSONObject) sonuc.get("sobiad");
        JSONObject Dergipark = (JSONObject) sonuc.get("dergipark");
        JSONObject trdizin = (JSONObject) sonuc.get("trdizin");
        JSONObject Kesifaraci = (JSONObject) sonuc.get("kesifaraci");
        JSONObject Asosindeks = (JSONObject) sonuc.get("asosindeks");

        String sobiadGoruntulenme = Sobiad.get("goruntulenme_sayisi").toString();
        String DergiparkGoruntulenme = Dergipark.get("goruntulenme_sayisi").toString();
        String trdizinGoruntulenme = trdizin.get("goruntulenme_sayisi").toString();
        String KesifaraciGoruntulenme = Kesifaraci.get("goruntulenme_sayisi").toString();
        String AsosindeksGoruntulenme = Asosindeks.get("goruntulenme_sayisi").toString();

        String sobiadAtif = Sobiad.get("atif_sayisi").toString();
        String DergiparkAtif = Dergipark.get("atif_sayisi").toString();
        String trdizinAtif = trdizin.get("atif_sayisi").toString();
        String KesifaracikAtif = Kesifaraci.get("atif_sayisi").toString();
        String AsosindeksAtif = Asosindeks.get("atif_sayisi").toString();

        String sobiadIndirme = Sobiad.get("indirme").toString();
        String DergiparkIndirme = Dergipark.get("indirme").toString();
        String trdizinIndirme = trdizin.get("indirme").toString();
        String KesifaraciIndirme = Kesifaraci.get("indirme").toString();
        String AsosindeksIndirme = Asosindeks.get("indirme").toString();

    %>

<div style="margin: 0px auto;">
    <div id="senateChartDiv" style="width: 620px;height: 620px;margin: 0px auto;"></div>
</div>

<script type="text/javascript">
    var veri = fetch("staj.json").then(response => response.json())
            .then(veri => {
            console.log(staj);
                    var veri = JSON.stringify(staj);
                    console.log(veri);
                    )   })
            document.querySelector("#button1").addEventListener("click", getTextFile);
            document.querySelector("#button2").addEventListener("click", getJSON);
            var data = fetch("staj.json").then(response => response.json()).then(staj => {console.log(data);
            var veri = JSON.stringify(staj); console.log(veri);
            function getTextFile() {

            fetch("text.txt").then(function(response){
            return response.text();
            }).then(function(data){
            document.getElementById("output").innerHTML += data;
            });
            }


    function functionName() {

    fetch("staj.json").then(function(response){
    return response.json();
    }).then(function(articles){
    console.log(articles);
    });
    }
</script>
<script type="text/javascript">
    // JS
    var tabs = ['Görüntüleme', 'Atıf', 'İndirilme'];
            var defaultTab = 'Görüntüleme';
            var senateData = [
            {
            type: 'Atıf',
                    categories: ['Dergipark', 'TRDizin', 'Sobiad', 'Kesifaraci', 'Asosindex'],
                    values: [<% out.print(DergiparkAtif + "," + trdizinAtif + "," + sobiadAtif + "," + KesifaracikAtif + "," + AsosindeksAtif); %>, 25],
                    colors: ['#D32F2F', '#1976D2', '#8BC34A']
            },
            {
            type: 'Görüntüleme',
                    categories: ['Dergipark', 'TRDizin', 'Sobiad', 'Kesifaraci', 'Asosindex'],
                    values: [<% out.print(DergiparkGoruntulenme + "," + trdizinGoruntulenme + "," + sobiadGoruntulenme + "," + KesifaraciGoruntulenme + "," + AsosindeksGoruntulenme); %>],
                    colors: ['#EF5350', '#42A5F5', '#8BC34A']},
            {
            type: 'İndirilme',
                    categories: ['Dergipark', 'TRDizin', 'Sobiad', 'Kesifaraci', 'Asosindex'],
                    values: [<% out.print(DergiparkIndirme + "," + trdizinIndirme + "," + sobiadIndirme + "," + KesifaraciIndirme + "," + AsosindeksIndirme);%>],
                    colors: ['#FFA000', '#FFEE58', '#8BC34A']
            }
            ];
            var config = {
            type: 'radar marker',
                    legend: {
                    template: '%icon %name: (<b>%pointCount</b>)',
                            defaultEntry: {
                            cursor: 'default',
                                    events_click: function () {
                                    return false;
                                    }
                            }
                    },
                    defaultAxis_visible: false,
                    defaultPoint_marker: {outline_width: 0}
            };
            var senateChart = JSC.chart(
                    'senateChartDiv',
                    JSC.merge(
                    {
                    title_label: {
                    text: 'Yayının İstatistikleri',
                            style_fontSize: 20,
                            margin_bottom: 40
                    },
                            defaultSeries: {
                            mouseTracking_enabled: false,
                                    shape_size: 390,
                                    angle: {sweep: 270, start: 135}
                            },
                            annotations: [
                            {
                            label: {
                            text: 'İstatistik',
                                    style_fontSize: 26,
                                    margin_bottom: 20
                            },
                                    position: 'inside bottom'
                            }
                            ],
                            legend_position: 'inside top',
                            yAxis: {scale_range: [ - 6, 5]},
                            defaultPoint: {
                            marker: {type: 'circle', size: 16}
                            },
                            series: makeSeries(senateData, defaultTab, 5),
                            toolbar_items: {
                            export_visible: true,
                                    caseTypes: {
                                    items: generateTabs(),
                                            value: defaultTab, //'Atıf',
                                            position: 'inside top left',
                                            boxVisible: false,
                                            label_text: '',
                                            width: 280,
                                            offset: '0,-48',
                                            margin: 5,
                                            itemsBox: {
                                            layout: 'horizontal',
                                                    visible: true,
                                                    margin_top: 5
                                            },
                                            defaultItem: {
                                            type: 'radio',
                                                    position: 'top',
                                                    icon_visible: false,
                                                    padding: [6, 12, 6, - 8],
                                                    margin: 0,
                                                    outline_width: 0,
                                                    fill: '#F5F5F5',
                                                    label: {color: '#BDBDBD', style_fontSize: '20px'},
                                                    states_select: {label_color: '#424242'},
                                                    states_hover: {label_color: '#424242'}
                                            },
                                            events: {
                                            change: function (val) {
                                            senateChart.options({series: makeSeries(senateData, val, 5)});
                                            }
                                            }
                                    }
                            }
                    },
                            config
                            )
                    );
            function makeSeries(data, type, chartHeight) {
            var typeData = data.filter(function (item) {
            return item.type === type;
            })[0];
                    var series = [];
                    var sum = 0;
                    var ranges = [];
                    typeData.categories.forEach(function (category, i) {
                    var result = {
                    name: category,
                            color: typeData.colors[i],
                            points: []
                    };
                            if (category === 'Vacant') {
                    result.defaultPoint_marker_outline = {width: 2, color: '#E0E0E0'};
                    }
                    series.push(result);
                            ranges.push([sum + 1, (sum += typeData.values[i])]);
                    });
                    for (var i = 0; i < Math.ceil(sum / chartHeight); i++) {
            for (var j = 0; j < chartHeight; j++) {
            var index = i + j + (chartHeight - 1) * i,
                    seriesIndex = mapValue(ranges, index + 1);
                    if (index <= sum - 1) {
            series[seriesIndex].points.push({x: i, y: j});
            } else
                    break;
            }
            }
            return series;
                    function mapValue(ranges, value) {
                    return ranges.indexOf(
                            ranges.find(function (item) {
                            return value >= item[0] && value <= item[1];
                            })
                            );
                    }
            }

    function generateTabs() {
    var buttons = {};
            tabs.forEach(function (item, i) {
            buttons[item] = {label_text: item};
            });
            return buttons;
    };
</script>
 <section class="blog-area section-padding-100-0">
        <div class="container">

            <div class="row">
                
                <div class="col-12 col-sm-6">
                            <div class="single-blog-area wow fadeInUp" data-wow-delay="0.3s">
                                <!-- Post Thumbnail -->
                                <div class="blog_thumbnail">
                                    <img src="img/blog-img/1.jpg" alt="">
                                </div>
                                <!-- Post Content -->
                                <div class="blog-content">
                                    <!-- Dream Dots -->
                                    <div class="dream-dots mt-30">
                                        <span></span><span></span><span></span><span></span><span></span><span></span><span></span>
                                    </div>
                                    <a href="index-single-blog.html" class="post-title">
                                        <h4>ASOS EĞİTİM BİLİŞİM DANIŞMANLIK</h4>
                                    </a>
                                    <p>Asos Eğitim Bilişim Danışmanlık şirketi temelini 2013 yılında 3 akademisyen tarafından atılmış olsa da ticarileşmesi 2016 yılının başında gerçekleştirilmiştir. 
                                        Asos Eğitim Bilişim Yayıncılık olarak ünvanı tescil edilen firmamız bilişim, yayıncılık ve danışmanlık sektöründe hizmet vermektedir.</p>
                                    <a href="index-single-blog.html" class="btn dream-btn mt-15">Read Details</a>
                                </div>
                            </div>
                        </div>
                
                <div class="col-12 col-md-9">
                    <div class="row">
                        <!-- Single Blog Post -->
                        <div class="col-12 col-sm-6">
                            <div class="single-blog-area wow fadeInUp" data-wow-delay="0.2s">
                                <!-- Post Thumbnail -->
                                <div class="blog_thumbnail">
                                    <img src="img/blog-img/1.jpg" alt="">
                                </div>
                                <!-- Post Content -->
                                <div class="blog-content">
                                    <!-- Dream Dots -->
                                    <div class="dream-dots mt-30">
                                        <span></span><span></span><span></span><span></span><span></span><span></span><span></span>
                                    </div>
                                    <a href="index-single-blog.html" class="post-title">
                                        <h4>Etkimetric Nedir?</h4>
                                    </a>
                                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Accusamus fugiat at vitae, ratione sapiente repellat.</p>
                                    <a href="index-single-blog.html" class="btn dream-btn mt-15">Read Details</a>
                                </div>
                            </div>
                        </div>

                        <!-- Single Blog Post -->
                        <div class="col-12 col-sm-6">
                            <div class="single-blog-area wow fadeInUp" data-wow-delay="0.3s">
                                <!-- Post Thumbnail -->
                                <div class="blog_thumbnail">
                                    <img src="img/blog-img/2.jpg" alt="">
                                </div>
                                <!-- Post Content -->
                                <div class="blog-content">
                                    <!-- Dream Dots -->
                                    <div class="dream-dots mt-30">
                                        <span></span><span></span><span></span><span></span><span></span><span></span><span></span>
                                    </div>
                                    <a href="index-single-blog.html" class="post-title">
                                        <h4>Etkimetric Nasıl Çalışır?</h4>
                                    </a>
                                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Accusamus fugiat at vitae, ratione sapiente repellat.</p>
                                    <a href="index-single-blog.html" class="btn dream-btn mt-15">Read Details</a>
                                </div>
                            </div>
                        </div>

                        <!-- Single Blog Post -->
                        <div class="col-12 col-sm-6">
                            <div class="single-blog-area wow fadeInUp" data-wow-delay="0.2s">
                                <!-- Post Thumbnail -->
                                <div class="blog_thumbnail">
                                    <img src="img/blog-img/3.jpg" alt="">
                                </div>
                                <!-- Post Content -->
                                <div class="blog-content">
                                    <!-- Dream Dots -->
                                    <div class="dream-dots mt-30">
                                        <span></span><span></span><span></span><span></span><span></span><span></span><span></span>
                                    </div>
                                    <a href="index-single-blog.html" class="post-title">
                                        <h4>Etkimetric Nasıl Çalışır?</h4>
                                    </a>
                                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Accusamus fugiat at vitae, ratione sapiente repellat.</p>
                                    <a href="index-single-blog.html" class="btn dream-btn mt-15">Read Details</a>
                                </div>
                            </div>
                        </div>

                        <!-- Single Blog Post -->
                        <div class="col-12 col-sm-6">
                            <div class="single-blog-area wow fadeInUp" data-wow-delay="0.2s">
                                <!-- Post Thumbnail -->
                                <div class="blog_thumbnail">
                                    <img src="img/blog-img/2.jpg" alt="">
                                </div>
                                <!-- Post Content -->
                                <div class="blog-content">
                                    <!-- Dream Dots -->
                                    <div class="dream-dots mt-30">
                                        <span></span><span></span><span></span><span></span><span></span><span></span><span></span>
                                    </div>
                                    <a href="index-single-blog.html" class="post-title">
                                        <h4>How to become a successful businessman.</h4>
                                    </a>
                                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Accusamus fugiat at vitae, ratione sapiente repellat.</p>
                                    <a href="index-single-blog.html" class="btn dream-btn mt-15">Read Details</a>
                                </div>
                            </div>
                        </div>

                        <!-- Single Blog Post -->
                        <div class="col-12 col-sm-6">
                            <div class="single-blog-area wow fadeInUp" data-wow-delay="0.3s">
                                <!-- Post Thumbnail -->
                                <div class="blog_thumbnail">
                                    <img src="img/blog-img/3.jpg" alt="">
                                </div>
                                <!-- Post Content -->
                                <div class="blog-content">
                                    <!-- Dream Dots -->
                                    <div class="dream-dots mt-30">
                                        <span></span><span></span><span></span><span></span><span></span><span></span><span></span>
                                    </div>
                                    <a href="index-single-blog.html" class="post-title">
                                        <h4>How to become a successful businessman.</h4>
                                    </a>
                                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Accusamus fugiat at vitae, ratione sapiente repellat.</p>
                                    <a href="index-single-blog.html" class="btn dream-btn mt-15">Read Details</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-12 col-md-3">
                    <div class="sidebar-area">

                        <!-- Search Widget -->
                        <div class="search-widget-area mb-50 wow fadeInUp" data-wow-delay="0.2s">
                            <form action="#" method="post">
                                <input type="search" name="search" id="search" placeholder="Search...">
                                <button type="submit" class="btn"><i class="fa fa-search"></i></button>
                            </form>
                        </div>

                        <!-- Don't Miss Widget -->
                        <div class="donnot-miss-widget mb-50">
                            <div class="widget-title wow fadeInUp" data-wow-delay="0.3s">
                                <h5>Don't miss</h5>
                            </div>
                            <!-- Single Don't Miss Post -->
                            <div class="single-dont-miss-post mb-30 wow fadeInUp" data-wow-delay="0.4s">
                                <div class="dont-miss-post-thumb">
                                    <img src="img/blog-img/1.jpg" alt="">
                                </div>
                                <div class="dont-miss-post-content">
                                    <a href="#">EU council reunites</a>
                                    <span>Nov 29, 2020</span>
                                </div>
                            </div>
                            <!-- Single Don't Miss Post -->
                            <div class="single-dont-miss-post mb-30 wow fadeInUp" data-wow-delay="0.5s">
                                <div class="dont-miss-post-thumb">
                                    <img src="img/blog-img/2.jpg" alt="">
                                </div>
                                <div class="dont-miss-post-content">
                                    <a href="#">A new way to travel the world</a>
                                    <span>March 29, 2020</span>
                                </div>
                            </div>
                            <!-- Single Don't Miss Post -->
                            <div class="single-dont-miss-post wow fadeInUp" data-wow-delay="0.6s">
                                <div class="dont-miss-post-thumb">
                                    <img src="img/blog-img/3.jpg" alt="">
                                </div>
                                <div class="dont-miss-post-content">
                                    <a href="#">Why choose a bank?</a>
                                    <span>March 29, 2020</span>
                                </div>
                            </div>
                        </div>

                        <!-- Advert Widget -->
                        <div class="advert-widget mb-50">
                            <div class="widget-title wow fadeInUp" data-wow-delay="0.7s">
                                <h5>Sponsored Add</h5>
                            </div>
                            <div class="advert-thumb mb-30 wow fadeInUp" data-wow-delay="0.8s">
                                <a href="#"><img src="img/bg-img/bg-4.jpg" alt=""></a>
                            </div>
                        </div>

                        <!-- Subscribe Widget -->
                        <div class="subscribe-widget mb-50">
                            <div class="widget-title wow fadeInUp" data-wow-delay="0.9s">
                                <h5>subscribe</h5>
                            </div>
                            <div class="subscribe-form wow fadeInUp" data-wow-delay="1s">
                                <form action="#">
                                    <input type="email" name="email" id="subs_email" placeholder="Your Email">
                                    <button type="submit" class="btn dream-btn">subscribe</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row section-padding-0-100">
                <div class="col-12 col-md-9">
                    <div class="dream-pagination wow fadeInUp" data-wow-delay="0.8s">
                        <nav>
                            <ul class="pagination justify-content-center">
                                <li class="page-item"><a class="page-link" href="#">1</a></li>
                                <li class="page-item"><a class="page-link" href="#">2</a></li>
                                <li class="page-item"><a class="page-link" href="#">3</a></li>
                                <li class="page-item"><a class="page-link" href="#">4</a></li>
                                <li class="page-item"><a class="page-link" href="#">5</a></li>
                                <li class="page-item"><a class="page-link" href="#">6</a></li>
                                <li class="page-item"><a class="page-link" href="#">7</a></li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- ##### Blog Area End ##### -->

    <!-- ##### Footer Area Start ##### -->
    <footer class="footer-area bg-img">
        <div class="footer-content-area ">
            <div class="container">
                <div class="row align-items-end">
                    <div class="col-12 col-md-5">
                        <div class="footer-copywrite-info">
                            <!-- Copywrite -->
                            <div class="copywrite_text wow fadeInUp" data-wow-delay="0.2s">
                                <div class="footer-logo">
                                    <a href="#"><img src="img/core-img/logo.png" alt="logo"> Montrix.</a>
                                </div>
                                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Velit ducimus voluptatibus neque illo id repellat quisquam? Autem expedita earum quae laborum ipsum ad, a eaque officiis eligendi blanditiis odio necessitatibus.</p>
                            </div>
                            <!-- Social Icon -->
                            <div class="footer-social-info wow fadeInUp" data-wow-delay="0.4s">
                                <a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a>
                                <a href="#"> <i class="fa fa-twitter" aria-hidden="true"></i></a>
                                <a href="#"><i class="fa fa-google-plus" aria-hidden="true"></i></a>
                                <a href="#"><i class="fa fa-instagram" aria-hidden="true"></i></a>
                                <a href="#"><i class="fa fa-linkedin" aria-hidden="true"></i></a>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-md-7">
                        <!-- Content Info -->
                        <div class="contact_info_area d-sm-flex justify-content-between">
                            <div class="contact_info text-center wow fadeInUp" data-wow-delay="0.2s">
                                <h5>NAVIGATE</h5>
                                <a href=""><p>Advertisers</p></a>
                                <a href=""><p>Developers</p></a>
                                <a href=""><p>Resources</p></a>
                                <a href=""><p>Company</p></a>
                                <a href=""><p>Connect</p></a>
                            </div>
                            <!-- Content Info -->
                            <div class="contact_info text-center wow fadeInUp" data-wow-delay="0.3s">
                                <h5>PRIVACY & TOS</h5>
                                <a href=""><p>Advertiser Agreement</p></a>
                                <a href=""><p>Acceptable Use Policy</p></a>
                                <a href=""><p>Privacy Policy</p></a>
                                <a href=""><p>Technology Privacy</p></a>
                                <a href=""><p>Developer Agreement</p></a>
                            </div>
                            <!-- Content Info -->
                            <div class="contact_info text-center wow fadeInUp" data-wow-delay="0.4s">
                                <h5>CONTACT US</h5>
                                <p>Mailing Address:xx00 E. Union Ave</p>
                                <p>Suite 1100. Denver, CO 80237</p>
                                <p>+999 90932 627</p>
                                <p>support@yourdomain.com</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    <!-- ##### Footer Area End ##### -->

    <!-- ########## All JS ########## -->
    <!-- jQuery js -->
    <script src="js/jquery.min.js"></script>
    <!-- Popper js -->
    <script src="js/popper.min.js"></script>
    <!-- Bootstrap js -->
    <script src="js/bootstrap.min.js"></script>
    <!-- All Plugins js -->
    <script src="js/plugins.js"></script>
    <!-- Parallax js -->
    <script src="js/dzsparallaxer.js"></script>
    <!-- Active js -->
    <script src="js/script.js"></script>                   
</body>
</html>
