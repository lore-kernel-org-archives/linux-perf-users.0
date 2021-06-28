Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDAFC2B9F4
	for <linux-perf-users@archiver.kernel.org>; Mon, 28 Jun 2021 08:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D28E761C2F
	for <linux-perf-users@archiver.kernel.org>; Mon, 28 Jun 2021 08:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbhF1Iys (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 28 Jun 2021 04:54:48 -0400
Received: from esa1.fujitsucc.c3s2.iphmx.com ([68.232.152.245]:64337 "EHLO
        esa1.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232282AbhF1Iys (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 28 Jun 2021 04:54:48 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Jun 2021 04:54:47 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1624870344; x=1656406344;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5Pb5ph1xsOCkl8sgY5rnnVAM6ntrS3G6BC91RmR6QQE=;
  b=t8cK/D4LNrn/z9m9t6OC0xV1edsshXoYtcqVavBTFkf13bDxVj6o6Prh
   LGbox2j9x7XLMQpqSp2UgakFlWLwq3oYLkUujZNLcHwBGZ6Aw3q5vGAp2
   DAVzVEPLkWfQQ2ndiDM1yYpKPhYjuiE8Fk4qEIc+9ebMvesZbIMwgNA7e
   zqGmjQtXA6ck4RNjlq6B/rZJQsnpJ/zuc/DjBL1hAAJa3yk6vbTmobtI2
   tvDIra5wmKHaQM1oLjN+eNje070r3Fsi+e7Z7874tbcwmGPXIXv5yqm+Q
   JBP/ah68T/0PPBTmwz0xyhvkImxT+s72VF6M6vkFiTgikuJL7Cs1Kr422
   Q==;
IronPort-SDR: e4sYbtf6w2YhKfWclTC08HwUuT72pSck0uOR+DbsaVoMGXRTU0FOuu721E11HgjgWevk3Gz3oO
 PoxYv8vMdtLcAdQ+8yjs4ddw5U+q0fnpTqGbZjBl3NuSsANPWarXLC9Fg9jx6Tx5qO/i9t9TH6
 gNGeUbZXlciCLV6ZXfSyPdDw3dN8aq40NigB7R3dQ8a6wHd0IVfe+vun8uHTMJ9XX3UK5sk3z6
 W1dVQbNbIdLab74RnL/+2L+S/6+JNSDau5eSGrdv2Gbl16ZjcuF3Rs6eOf3Qy1jQ0Pz6qtQ8f1
 zg0=
X-IronPort-AV: E=McAfee;i="6200,9189,10028"; a="42108607"
X-IronPort-AV: E=Sophos;i="5.83,305,1616425200"; 
   d="scan'208";a="42108607"
Received: from mail-ty1jpn01lp2052.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.52])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2021 17:44:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETv85iFad3o4WZfQdTze4tndj52BVPDL7HrxpYO24bBe3FzpK+TeFkJPI5hOZ41Pg00PxO1Bqz6OxaEWmsxUN5LCZDxSGar9Bqr0mrJv2lbwr+I3AaRleoIK52wtNUD7j6YJ3nSQ9Jn52ApzVfoLb3Y1qGMkc0KLYsHH9jylcWbp3ZkAWS9q1pmsKAB87cGCUr8TyLOTEgsn6NIbVkO4JrkHjkWxYV2Bf4zWcNpF1BKm9Pj1ebaCt5SXhUGBWhAjx9Z4oLjgjXkY4A9lW1k4StYO7GEPAkl57U72YSeNUOhUKN12l+eyzXEwB09nIP3Cv/1wnDOcijlZ20cS4PhNCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Pb5ph1xsOCkl8sgY5rnnVAM6ntrS3G6BC91RmR6QQE=;
 b=kqfzDpw2vnbh4QiOQAVP/cUUuh0HYkOiKfpKvcxQytkQTZOv0AKhEcLW5pUafsPmn1usXVw5i0CJGw6mCNMRtUo6qZffj24T6CF18NPrgriiZk4gub3SQ++dRkLnRXQfTjmFpQL8rgRwnHARgUnzocF/vHk9Ii6p+WN6uY0X7ZSBJWpvuV7RESEmH8hcd+P+QSpOJFfVwnoSpzd38NfEz3NM/38D5uN8UVc98Dvbu7q8EbVIEPLOQtSJ2s/ErB+8X1+HyqDNINvBD2hbH/enc9lJ64Q8I+3Cfy6ltrJATj2B+XRpKDU9VGcXJepQ7PwBLLGLqVVZVRK3UIK/mh+kug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Pb5ph1xsOCkl8sgY5rnnVAM6ntrS3G6BC91RmR6QQE=;
 b=O1OzyVzJaDc7qfXDexfJKtU7/rYPrlQQy5GuukaS0qazFPNxwvO+yPfVyU6Y860v/OV62XMwmtQAJS0Wf3j9maMGa1yWlw7LPQiX/lqRx/HVM8R66yaQcHOgtDnp29eFxJeMlGguyGRScfptt7HAeWVAeRaIzOfbXDrAgILIu0U=
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12)
 by OSAPR01MB2643.jpnprd01.prod.outlook.com (2603:1096:603:3c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Mon, 28 Jun
 2021 08:44:52 +0000
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::8cd6:d0ec:739d:5284]) by OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::8cd6:d0ec:739d:5284%6]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 08:44:52 +0000
From:   "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: libperf : Can not create event group
Thread-Topic: libperf : Can not create event group
Thread-Index: AQHXYOz1byLB4GfrUUijoG/ejweJRKsTW8YAgAxaN1OAAN0rAIAInH1O
Date:   Mon, 28 Jun 2021 08:44:52 +0000
Message-ID: <OSBPR01MB46001F16CB31046C42947ACBF7039@OSBPR01MB4600.jpnprd01.prod.outlook.com>
References: <OSBPR01MB46005B38568E90509946ECA9F7319@OSBPR01MB4600.jpnprd01.prod.outlook.com>
 <YMc6tBoIQiUQkRbq@krava>
 <OSBPR01MB4600B6FCE4D95F6B84E7E17CF7099@OSBPR01MB4600.jpnprd01.prod.outlook.com>,<YNJQ5P3jgOcL7sMD@krava>
In-Reply-To: <YNJQ5P3jgOcL7sMD@krava>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2021-06-28T08:44:52.096Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [218.44.52.175]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 332acde9-439d-4ff1-f849-08d93a10ff43
x-ms-traffictypediagnostic: OSAPR01MB2643:
x-microsoft-antispam-prvs: <OSAPR01MB26433F8B884A2E0C2016397FF7039@OSAPR01MB2643.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IgRX9eFt9OYvpfVXqOWAX8yFdsno4bbi2uW9fB5mR5/qKzZ66GU3jn962U4fG6wk+RMxdfvZhjthAU0JIMfSuhgfErgD44BC6UQSzxC/6V4+E0yfhZapDjIyWDLlDblKN1GDZYh3RdgGeOVqGAXU0pkS+8GiT+/hNdyE/uD9m5FD7WBkhEqkxrO5m+iucqT7Ublsu5Uun68fUHB4S3q5RqvrOtjghrHSS/VVfhFb9LZ1NLP55rOgQHyuc2/6wriDfbteU/pIDjAgU9FVyDRSoIlcrN1OjpEYrCplpd1MQAwa/oUj08qBguM4HjuZ59Adu+ED/fvSmNmvRzOnKklHUEaFGe2u+nSC+zQaz/zd2dbktBjoR/uoWEL6CPqOtXtY4QtAZs6Xfb5STKiEBkgcP+OwsqhD8xNI1eRFzOWquEQ4lKRRSx0OdlBByfH9ibokZEuUIQyXxfeSo1L8bjOGNg/xeDVIFUa7fXWUNduaRLT1+p3Db/aIynbpBvvo+n3Y95p4+9JzyfiTMJ0SY8BSNGiAUS2BgskneoB6QSGyq9FcW+1T18dL/FIU1cRc4p6vYZjhgfhc2FVGyfQ+kMbiEBu+Ourp5RQNhFs8oIpQNDDOu/xBAwilHOQeL5tarQSluYWav2pHbYLUNiH8bE7RRA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4600.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(2906002)(7696005)(86362001)(66476007)(64756008)(66946007)(316002)(66556008)(5660300002)(76116006)(478600001)(122000001)(85182001)(38100700002)(91956017)(8936002)(66446008)(55016002)(186003)(54906003)(6916009)(71200400001)(33656002)(83380400001)(9686003)(4744005)(6506007)(8676002)(4326008)(26005)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?cFRqTHFac3RJRGxWSWZLS25rNGtQWktYYUR0eG5GaGpObHBCWkxPV0hz?=
 =?iso-2022-jp?B?YjMrcFg5dXdrSFVSdWV5bS9LQTVzRUhMRHFqU1ZEbG8wSTNxdjYrZVU4?=
 =?iso-2022-jp?B?QWo5T1RaZDZMZmFyUUk0S3VkbCtYUmRPTVFwckZxelIxbkxmUkdQOXFS?=
 =?iso-2022-jp?B?ZXVhOGx4MEFSYVowWnkwN05TUkxnc2p6LzFoZzNyZDVEWnFWUUU5Z3Ry?=
 =?iso-2022-jp?B?YkxyMmEwdk5OckFLSHZsWVR2Ny9iQWdTL29KYm9vM1RGQS9mYnFlMEpo?=
 =?iso-2022-jp?B?anBEODIyektLVWdtMWtIeEZHVmhsWXlEZVRkRmpmWUdIdW1iSnNGMHdO?=
 =?iso-2022-jp?B?UUtpQ09GVXV0NXcvMWNkTSsxVCt0emVvM080ZXI5aU45bitPQmpHSVVU?=
 =?iso-2022-jp?B?T1FXWGNETk1vVTJGVGpmMjlHdldFcFlrKzBXRlNoMWM4aGQyTjVCYk1w?=
 =?iso-2022-jp?B?eWQ3UGc4TjQySmx4RnVlSERhYStzbnVFNXJvL0NUdGcxVDBVb3Y5em14?=
 =?iso-2022-jp?B?KzM3ZmdpODR2VWQ2cTcvbDl5akp1VFhmYXZ1WW4wcmg4am9EWkxpallY?=
 =?iso-2022-jp?B?Nk5yZjJjdEJPb1IzL3pnbzgydEY3UnFxN1JaSkpSY0lEMHI1dHJMVlBv?=
 =?iso-2022-jp?B?enU5Vm1IV3NXaWFwZnh3LzBqamNYaXRMajRBYXNGSDl0K3hLbGdsOWJ5?=
 =?iso-2022-jp?B?LytnVTROUUh4bHpXdlFLNUZocjVBbG9tbUJUbWpsaGxHZWwyVnlJY0g1?=
 =?iso-2022-jp?B?cmVDMUl5NEtnOUJkSDk0bjU1SXVOMzh3cVRwczlCTFZaUHc3cUp0U0Jq?=
 =?iso-2022-jp?B?ZkpRRWlqckpTV0VQSHhrQU44M21ZYytXd1dNcC9NZVdnSVg2V0VyUE9T?=
 =?iso-2022-jp?B?SU8rSVg5TkI4MStQNTlZYm5xNlo3RnplM3RlWFVrcWRmZGhkUnNWc1Ni?=
 =?iso-2022-jp?B?YytHbkd6ZksrcktrSkRoZGEzY3BkYmx0aysrU2RVMVRRTkRHczNaek81?=
 =?iso-2022-jp?B?dHd4TEQ1VlhteERGTTlTdGh1aC9GaThzMFk4c0lLR0NlRUdHdU9odHoz?=
 =?iso-2022-jp?B?Ulh6UE9HU3ppSkF2RjhxcTNOK00zdzJQaGFFWTVCN2RWSGl6aitQZ3hr?=
 =?iso-2022-jp?B?Yll1LzlXcVpHakxwaGxYTTNCU2JxbVBVci80dnZkK1YvK3FWUDhrRVVS?=
 =?iso-2022-jp?B?a2hZbGlsQlZHd1l2dUNNejZSWXEyUkNmbXlNZUNjK0Z4NUphRTZFd3cw?=
 =?iso-2022-jp?B?eEp2WmNiM1UreThoVERMMEo2eFgrNzRXcER1a2w5MFZoMjNwUS8yOG14?=
 =?iso-2022-jp?B?L0lTWGNOVHdpNUFReWcxZGU2SnpXMlZrZkdtS2RaYXU5YVN1LzZCZUNr?=
 =?iso-2022-jp?B?OHZHdkFiTjV5dGFCTU5WM0VxS2ZOK1l6MFhIY01kVzhlZnhJaFd6TTlW?=
 =?iso-2022-jp?B?Z2IwVjRzOW10cEFWVXdQV2RIelpCV0IyZTd0Z0UrQThrVG1OY1FuYWhY?=
 =?iso-2022-jp?B?YkJCQWg0SUE4Ri9IUGJGdytOd2N2TGo0UDV1eU9RVEtwNlBlK2lFeCt6?=
 =?iso-2022-jp?B?YzFNMk5uWkNzNG1VaUVPNHhXU1lVcWluS2x0TlNYeDFtN3J2bzFFSW9h?=
 =?iso-2022-jp?B?aHJuVVl2M2FhNDU5V282eDN5clB6akVCOTFuVk9QTkRvaUhUeTNFS05n?=
 =?iso-2022-jp?B?UmdaUER4MUtrSFBCZ3BwMHVMcXhYUHR5ckVFSEZ1eVpMSW1GY0tvbnhN?=
 =?iso-2022-jp?B?S3VpU1FIYXdGSnFMMzhsYVArWFJpb2xkOWZ1WDVHR1lHUFEvL0tES0px?=
 =?iso-2022-jp?B?dU1vRGFTYm5BeTVETk9RY243QllmVGNJUGc0enN1dW5XRDQxcS9sVk9E?=
 =?iso-2022-jp?B?Nys3eisvZ0FPY0FUOHZmaUhIZ0VrPQ==?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4600.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 332acde9-439d-4ff1-f849-08d93a10ff43
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2021 08:44:52.5528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zo/zWF3jx4ufQKawZZJq7BI/xpSR+GQiK211NjmDQyCbuT/Sz3F6ErN3kZfR6Tj3qHWgz2QRDi/akgXx5wsI1ZJmU0spwkmVPaUYuU2Cgbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2643
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi, jirka=0A=
=0A=
> > Do you have any plans to support the event group in libperf?=0A=
> =0A=
> hi,=0A=
> not until now I guess ;-) what's your use case?=0A=
=0A=
PAPI uses event group to measure multiple events.=0A=
libperf uses multiplexing regardless of the user's intent.=0A=
=0A=
I thought it would be nice if users could choose to use multiplexing or eve=
nt groups.=0A=
=0A=
=0A=
Best Regards=0A=
Shunsuke=0A=
=0A=
jirka=
