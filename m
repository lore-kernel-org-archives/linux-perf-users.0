Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EB3C48BE6
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Jun 2021 07:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55DB3613C5
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Jun 2021 07:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbhFNH1K (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 14 Jun 2021 03:27:10 -0400
Received: from esa8.fujitsucc.c3s2.iphmx.com ([68.232.159.88]:25341 "EHLO
        esa8.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232454AbhFNH1K (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Jun 2021 03:27:10 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Jun 2021 03:27:09 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1623655509; x=1655191509;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=XtSJEKW5nV82EUP66Fi4KT99XmZoGWXhsLjx1W6G0/M=;
  b=WJ1UWs3UooITNloS8s6sDnDa2vQSk2BfQZtZlZ+tf4iuXuzgYiPcQHO3
   imgHBWR7wsxXXMyZkPN6QV0OMfoDi3B7UYwtppGi/ojm9OWow+ULoQqPO
   RMsEKS/fYhOoXbm9vuOGjoCe6hNYX4WJGuQP7i9KhfDs3Extiqc3eQC1Z
   xTnoakfd0GIGA5xPrPjwk8dcWINQBWUbvcz6wmRSf8cv39owThndysmVB
   cGiVI+WcQGtgCNR5Ufex4NAGxm3ejzf7kd8wtz7dkdswx19whHceGJGqr
   LG7rSrDJA39C/5vRtqNeIrhgwft4jCI6034GeHvzROSo1/PtYhKq6CxTH
   Q==;
IronPort-SDR: Sly8PQ1cJqrKjVUv2k9huOwu7GGFqMVSRZjsYszf/3PMSYmZI2aGPe5qHfpNw6kE0q3hmUoYp7
 BrQPOMtsCRXaD/fo38AVXqxdeNzvmTTrpPdnogTWas5uAQ8L1jTxFP66kQWRQ4IMaUpmXmYWaH
 ugxjJzmtqqaKbHgJ73CYxdTV/TiS5OMnkxY1HXbGOuWcTbJTpaq0psr7DwfeDwOdlnWTc4hSVp
 3ws8rKf8MQWoYSg8gzdktM96fcKWCF+zm2vXcM9j/0kU5VWRKx9wep9z/jGzZeHzeCH2WtSXTq
 VIc=
X-IronPort-AV: E=McAfee;i="6200,9189,10014"; a="33029602"
X-IronPort-AV: E=Sophos;i="5.83,272,1616425200"; 
   d="scan'208";a="33029602"
Received: from mail-ty1jpn01lp2051.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.51])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 16:17:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPLIzhAyXJLhEdMh5D0myMGcX5Q/ZXHFLL0PCBoxtwZ+oDGqVKlGwTZ3iVBAbMYhjCPEtJwuG/M8c6KAkQJkTzCRccyzqMoltIPVS2TSCBCB24T40llqJwbfrhE4VvIm0Wa53GpjyyQpAxTuEWZQ+DipSr1EXqt02ssiAur7awYqYz8nRad0FWZShrA9iFWYddNUOI/fuj/6y0esDCC0BCV6tUcA7H/2HIqnN3Ps8/QMXkwaWPu1sHfFOe476eZUQKmSuOxHIdGSm9oEKlrmkfzg48Ch7Wt4Jg1g9Fa0/FyHyL5zv+ufZlk28Fckk6fv8fnXackJIX6BQ4jsjLrcYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XtSJEKW5nV82EUP66Fi4KT99XmZoGWXhsLjx1W6G0/M=;
 b=D5WhEUQe/UUnN7TZmx6mnjMWMHqI5K7eDle2kpXlP3Yo6DOpUfVywlQ7MB3/8yA7Cz8ThrZ2VnyKvnE+nSFJE/eCYu2As+qUuKxQ4Lf6KIt71boPzop6PJULNGQqbvoPSHquxSY5WRC8RPsIDYBG/Z98uGaurqCttqDZCU8JLDfV6Q0pCyQatSFCg9k86FsOz82Cw/k3EJYrHh+zBkCsijRhEj4flJcvEYFD4vL+E5OMcZq30P6BJQ5lGPuJ5x4QevpPkmzxxEcb7/C9ls6o7qfVJO5EiObqv+ug15kcvZAmeveEQ7AOLBASFp0Jo1+Oyay2GWkavIaebGTdv2hbvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XtSJEKW5nV82EUP66Fi4KT99XmZoGWXhsLjx1W6G0/M=;
 b=ZMPNUlTztahfcpIpfqCzf9uucgpL8ttStW2PubB/qNUK6JKXwDT8vojbzXLx1Y/RzvubyOnhEBrLDVSnRlOAhLCKI0YAVOoCp/fVNlcvtfEwMWYWUv31F+YNQhZBKr+p9bOTYBwkYHpvOD2xHqKhXOu83lx8iCQtFcsJP/jOjCg=
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12)
 by OSBPR01MB4197.jpnprd01.prod.outlook.com (2603:1096:604:4e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Mon, 14 Jun
 2021 07:17:53 +0000
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::8cd6:d0ec:739d:5284]) by OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::8cd6:d0ec:739d:5284%6]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 07:17:53 +0000
From:   "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
To:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>
CC:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: libperf : Can not create event group
Thread-Topic: libperf : Can not create event group
Thread-Index: AQHXYOz1byLB4GfrUUijoG/ejweJRA==
Date:   Mon, 14 Jun 2021 07:17:53 +0000
Message-ID: <OSBPR01MB46005B38568E90509946ECA9F7319@OSBPR01MB4600.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2021-06-14T07:17:52.801Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [218.44.52.178]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 26d5ccf4-5be4-441a-6f0b-08d92f04867c
x-ms-traffictypediagnostic: OSBPR01MB4197:
x-microsoft-antispam-prvs: <OSBPR01MB41973D25D6D69870E1608438F7319@OSBPR01MB4197.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yvzd2ra0b40FoCEViUbjuwIZbMTGfHhV6MJ7NCq4AfTrW4PoQfEai3tBln8lB95eFNOVoE7dIzjAcj+3DKL6kfHPpQUdgGlIwEHtPgnIfNWXMvcQl1U8OBorM3fzvyJqtQKnL5VjfUMmlFXMyMcTyP2rqKYs26VWcwNa+H+uQy8WEgFClNn3eXGmv6MCD2SSJvTpXZpf2GUDDlXB/ZuVO2zYOVyamL/AM1V0HS6H0rRl8f4a1olOcjR1v4BGj+fQ3Ldc8A6n5JKKC52H/07zuGXEJyQNJrrKxSBCzgPmDXDeTboVqo3hFWS0by6LNnBqFizvni50u3/IB83EO6eCJ4iFjeQKkwVzj8jR9rRJh9YXifIshwdhxMTz751PCYW/fo3NdSRRsk9rUXVKVVoxlXJOoN1bVoyVA+xX3YD84xnXjsKyuMUegu6YjNM1LKqc7gIAWaXTzj4Oi5OZsw68wlOmB9HBnJZHkAykIcYlRmWxW4J9f5F+lV41qK+vktNcVpDWLbKruOUEiwK28BmGNWaJMljo5tIx8nnwspVwFeHUtyUC7U2knOCsJfnu9g/xrwi9jGHk2AZUJS7oOyAWTUB00HgZs49VVXYe3TIqckE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4600.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(71200400001)(9686003)(66946007)(66446008)(66556008)(33656002)(8676002)(85182001)(55016002)(76116006)(558084003)(478600001)(64756008)(66476007)(2906002)(4326008)(8936002)(26005)(7696005)(86362001)(5660300002)(52536014)(110136005)(122000001)(54906003)(38100700002)(316002)(6506007)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?TW8xYnQ0VGRjcmo4UzlGSlZRR1ZRS09sTy93OGNGYVByK3J6UnBscmw1?=
 =?iso-2022-jp?B?ajQ2ejlKdy84NjF6YS92WWtISHk1S0wvclFGZENFWkU3YlY5UjZiaGxZ?=
 =?iso-2022-jp?B?Rno1TXlFd05XVk9MTVF6M1FXV0JxNkN2TWIrUHBKUDF4RVUyRmNBM2ps?=
 =?iso-2022-jp?B?eDNFc0dzZnF0alBVVk5CMGlnbHFlSnFFRFpja01LQklscE5vYTE3VDdT?=
 =?iso-2022-jp?B?OG1idDVETWdybTZsNnVMOXltR1U1NFVuT2Z5aEcxaG9raGFCTTFIWUt0?=
 =?iso-2022-jp?B?TXdZVEE2VUpIRzdIQUFrVlpTa0tDM0NZTnhxTkhsRGRudE5EMzNVSERK?=
 =?iso-2022-jp?B?VVlNRjRCNlozR0p4OFBPeE1NZlRpdHYwVnRoVGdsS1c4Rlo4cGxEbkZL?=
 =?iso-2022-jp?B?bnd0V3ZnZEFVUHF2dm4rZlJyNUFCeXhab0lUSU5raVBrZnkwUVFmbk5W?=
 =?iso-2022-jp?B?amJRRmpkVnRpYjJoeCs3Q0tHY2RqY0tkRVRxVXM2bndrdklFa09SRGlz?=
 =?iso-2022-jp?B?YS9acnd6TEUzaUF5ZXpFdUNhK2gxUUxIVW0wbkRUczNmajFnQjlFRzI0?=
 =?iso-2022-jp?B?ejBSRmZHU0tCMVYwNHhqNDZHejVXTFA4djFucEdpdldtNkZleFFSZkVY?=
 =?iso-2022-jp?B?UTZYaW9XTEhxVkw3NlRXNjh3Mk5Gekd0L0JUWHJSTEpIcG01QmtYVE9Y?=
 =?iso-2022-jp?B?Z3Q1bmRrdE1YeStVdVVmVlczelVyOG1ROTBCYzdnQUIrZlYrekVXNDRG?=
 =?iso-2022-jp?B?bWZ5MHp0RjNNS3lrakFETFlkNWd2NFpVaDFPcitoblZVc1VXWCtBWEk3?=
 =?iso-2022-jp?B?UDU5bUN5aFFTdHA2OW5WQ01ON0liK1F2QWl3Ky9McXNrRThRUkFjNjY4?=
 =?iso-2022-jp?B?MUNvc0F0QkZ4SHJ5NldKR3ZaWmwzeTZKYlZhNXdBQTd5cXlEKzJZQ0gz?=
 =?iso-2022-jp?B?d2U2eTU4SkE4Ujd0MkJsVEREbHlLOFR1MXlRZXc4bi9Jb2kvWWZDSTRu?=
 =?iso-2022-jp?B?VTZOY1pqZTltdnJISjZlbzJhMzJOVEJUSVU3NEpoclQ3WFBBblRFdTZB?=
 =?iso-2022-jp?B?b0oxRzBiNE0xbUtKTHc5UFZvMXV1Zkhkb2VqZWNHZUNsZitsemE2UEVQ?=
 =?iso-2022-jp?B?Y3UySVJVSmNIVnAza0VMMlFYV0tsOXJ3VnBaQVpuL3ZGUS9YbEcxOGZq?=
 =?iso-2022-jp?B?QnB2c1JpbDZzcDdDWG9hZCtIWEFjeU5Pc0xmb3RHOFdNN3NmMW1ZdUdY?=
 =?iso-2022-jp?B?b3lQUmRZTTZSLzVsL0w1SkFwNTdtaG1qZkhPOFg2WFNGN3RjWkpvM2N5?=
 =?iso-2022-jp?B?cmR0MHd4S1QxaUpjdVVxT0pOcTFBZkJqRWMzSUdYc0V0ZFhwYUw3SDNG?=
 =?iso-2022-jp?B?L2dLN1FsWEpKemJ0bE00Y2NKVzVTQldmckVxaFV5SklzcjZXYTlpS0Zp?=
 =?iso-2022-jp?B?aEJoNEZyUnFFTXVpOVpWaWtsQ2xCYi9vdUtpK0JCZVBuNzlkQ01zUldU?=
 =?iso-2022-jp?B?dFVsSUxObHlhZG5zbDltQnV1N040ZWhVRkpzWUxDcEg5dVhzQVVwUm4y?=
 =?iso-2022-jp?B?UlA1WU5aTm9sQU5LMkx2d3YzUnIxWHB1NDdGUnBoeFBVczdjeDNSdVd5?=
 =?iso-2022-jp?B?RXhJV2M5d2RrdmtMUTZ0Sm5yOWdTb2JWcXdKUWtHTnQ1VmNtTisxME0x?=
 =?iso-2022-jp?B?YnZUdlFKRnpGWm45TTMvSVlGcXd4d1k3S3N1eVc1cERxT09EK2Nha0Iv?=
 =?iso-2022-jp?B?SXhFYUFCeUM4TTJlYS9sSXFVSFdoc01WcE1zL1RUUC9GUzBNQlk5Qmt2?=
 =?iso-2022-jp?B?RHg2aVI2QnhUdTF4ajNNcnNsVzFjdC9qMktvS3ZTUkg2aFlhc1hHWVRY?=
 =?iso-2022-jp?B?SmZGSDU3clJ2OWE1RjFwaTdVSG5zPQ==?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4600.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d5ccf4-5be4-441a-6f0b-08d92f04867c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2021 07:17:53.1732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BGx6LNOfKfDsq+vVjzeIsOk6fEPpKBpU0v4TEy3LfgSeOEM2M7Izx4ipDnz5am2/QlFEyXccXcSmEv0nB6JpRzvArolqKspvTO/IRVHRYNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4197
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello.=0A=
=0A=
perf_evsel__open cannot create an event group because it set group_fd=0A=
to -1 when it ran perf_event_open.=0A=
Is there any reason why group_fd is fixed at -1?=0A=
=0A=
Best Regards=0A=
Shunsuke=0A=
