/**
 * Created by virus on 01.04.2020.
 */

public with sharing class VFPageController {
    public String PDFData {get; set;}

    public PageReference downloadPDF(){
        System.PageReference pageRef = new System.PageReference('/apex/PDFPage');

        //ensure pdf downloads and is assigned with defined name
        pageRef.getHeaders().put('content-disposition',
                'attachment; filename=TestPDF.pdf');

        return pageRef;
    }
}
