Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988F9C433E0
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Jan 2021 14:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CB88206E5
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Jan 2021 14:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387645AbhASOi3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 19 Jan 2021 09:38:29 -0500
Received: from mail-eopbgr130088.outbound.protection.outlook.com ([40.107.13.88]:2910
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404943AbhASLBX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 19 Jan 2021 06:01:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+kRB0l8A9QqntRhMHdPYdMRUZdB6LdPZliLkav/FEtHN3Hgqosd+zIx8N0lvDD0mSXqhC2v1l7+N0kTriCB8UF2C/wb6a3FDHkGzPbNu/1PPTTsFgXZcGSs5znW0tEEFo5AkUU+TrESV2hEsaaVWoVYnq5uw0xVOD3ElQRqghWyRmsUjPO+lvVyyz8jhH95Cco5BncVO8HFvZ2j3FlCy+EqjyOf1AkUGKo0YRmnOG/ZzkFfylBHYojZ15WpLNO/tv9UdvFJUD47aD5/DIarYFrRBf/q7Ihg8J1Q4XsXpuMmeM04M/dupI7sHUPRw8PIQCO2wRGwGvwePGplzodmyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBlnsWsBB6ZNL3AS8tvQUfJKfZ/hqa4Ybli/XBqlC0c=;
 b=Ex+WVqwm8Oc9g0fTiBECC+9F3mH+34sLxJh5sA+BdFGNzG7vHtu34db+9mlufI+ROH0VVQYiywKt5heoLl2RHYJJvdt0l7MbhcdRe2FvslcFsZziHRDFoAlNlQwwigShyVf3E4uG070nl7kJ1U04TNSjiK27bYc0UwFbp2HNXC41o7zJZ1YbZ/MAz+jjlODommuSpmHTgW3nLjPZMyPkFTg/mkAVQtC2CgQuFLUDaFqxsZDNv/tSI1Ssgw4P21MjT+nYXD1/72pgUs32NtA4eRpEXEu5LllEu/XrVeLlnZNpLhFRPABYtbfL6x3wBTZ+38SLoo3M1pL+mXNwTpsThA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBlnsWsBB6ZNL3AS8tvQUfJKfZ/hqa4Ybli/XBqlC0c=;
 b=dTXc1ngMWr69BPycQsOvbmIaowZ/1+WWhwpOQw/mTCjVO4hhytbc5tUh7zGLuKUfjUZWYo488P+byQy0f9NmjxBdY1UivappagJ9Pk2CqXtdZ+f9DPZC6LrZeboypabCdO0wBDdjH/GDggNMO9hU2i4+RnzFORSFtJsGRAz4yvY=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB7PR04MB4522.eurprd04.prod.outlook.com (2603:10a6:5:35::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.12; Tue, 19 Jan
 2021 11:00:30 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::b83c:2edc:17e8:2666]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::b83c:2edc:17e8:2666%4]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 11:00:30 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     John Garry <john.garry@huawei.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "jolsa@redhat.com" <jolsa@redhat.com>
CC:     "will@kernel.org" <will@kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH V1 3/4] perf vendor events: Add JSON metrics for imx8mq
 DDR Perf
Thread-Topic: [PATCH V1 3/4] perf vendor events: Add JSON metrics for imx8mq
 DDR Perf
Thread-Index: AQHW7g7uaO/NwgWkPU2zY0Lz58OHbKouwtGAgAAEwLA=
Date:   Tue, 19 Jan 2021 11:00:30 +0000
Message-ID: <DB8PR04MB6795A3ED474456F17F52680AE6A30@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <20210119025647.12569-1-qiangqing.zhang@nxp.com>
 <20210119025647.12569-4-qiangqing.zhang@nxp.com>
 <20a74eda-ae1b-249e-06f1-4ab70e20f684@huawei.com>
In-Reply-To: <20a74eda-ae1b-249e-06f1-4ab70e20f684@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 61bd7630-237e-4783-ae7a-08d8bc696fc7
x-ms-traffictypediagnostic: DB7PR04MB4522:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB45222AB485B9DF8F440AF002E6A30@DB7PR04MB4522.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZadcJ14VY1/uOLFuPiD1LuklS6SKNK9psRTPQKn5jOylVYKnkI/Em90D8Omo1D8+CcGtz4WBfConPP4Q6ZpypqM02+i+XuZFlIEY6ORAVLcn51wbgTZbYMnqSsBG7W+ktRZ2g3frFH24AV4YyI1W/hPEnUGUCV2rYlM+z/ObhWNeB4p6nZoJWCEsbFJ2RzcjGU7C1d/qDKKgfZ3KFjAwTgkrVhkUKcnKoFkNsDGgFfpnoiSUhf0O6OYYWkRZPAgmrSKKsF92shIk+KaZI5h3/qTxhuFyCUAm3ngD2AG9my48gwWh4OnDgPCdMp8mU2PPzyTyDM8bGW0mW6HV3rNfsFKbOm0uFxyCXmd/h6kBx54PVfYmojuuOTCgR94OYsEGzSm8Oi0TledT6Psnj7iEDKJYBxiSjAdxER5N/F2fvBK6IUJH4ZCn+Z3fAaZeKrZ0PgQTxYntfpmQ6uueI4ThOTZd7mY9UBMt4Lm7SSdhnCB8TYX4xMK9vIiKpb0SYEfuOWxjCVOdrH+EX5ExVPSS/iXkts/co7BC0dt6D44h1lS/g3lmY+7prHWt5m6ecG/4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(346002)(39850400004)(376002)(6506007)(8936002)(316002)(64756008)(4326008)(7696005)(8676002)(9686003)(53546011)(55016002)(478600001)(5660300002)(110136005)(54906003)(66946007)(186003)(52536014)(26005)(2906002)(66476007)(66556008)(66446008)(33656002)(76116006)(86362001)(71200400001)(83380400001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?anBXalFqL0RzM0ticWw2M0NDNUxNQ1NmUm85RmVpY1RaNWZ2MnZsMEF6KzZj?=
 =?utf-8?B?a0JnYUhseW4zR05TVDVvcW9ZaWUxcll4SVJPYWswQWcrNGI4OWVmN0NaSzUy?=
 =?utf-8?B?dmNnRkgxelRUc1BaZVREZ3l0UWlFdlhDczlGdU9qa1R1YVZTaVI5SUNkWG4v?=
 =?utf-8?B?bkt6MUprRi9LVEUvRnNEbHlSRE4vZitSWFdkWjgxaSt4Y0ROTkZtUXhFTUNM?=
 =?utf-8?B?NmVRUDVsa0FYWVp5Q3VtUUV5UG5NeDRoZm1RM2JOVU1zSm1xOVBWWGVITWFv?=
 =?utf-8?B?MlBuYVl2QzJhQ1lVZWNna2hIVVpJTm11NVkxdnVhRTMzU1hUYmE5MjB1Vm1E?=
 =?utf-8?B?elNGanBHMXFMMTdXK0pNUndGMnVUOU1UTUxydnFVeEtzbzJaRFF0cXV6dFpM?=
 =?utf-8?B?UUdiM1YxSnR1aVVhMGhCRGgzMkFJS2xjUUFEd0pXTkVGenI0MnRwRWRURkNo?=
 =?utf-8?B?Yk1VZ3E3cGJLMnZrT1BPNGtlVTZaM2craDlXcWV4R0ZoOTUvd1BmWXdvTEFL?=
 =?utf-8?B?ZElFNm5nbHlNN09kS0t3TWlJV1htS21DcUlCUndxVmtQakplOTY4SDBHMGFj?=
 =?utf-8?B?L3B0OFJHZ3JYQTdVU3RhS1VJaFlHTTFMdXhXNnhmUkZhaHZqK29BdEpDNFgr?=
 =?utf-8?B?YkZCUGJEMzVBalpyMnJhMnlyajM3V1QxTFppTjlreHVJT201YzhGNHBQQzVL?=
 =?utf-8?B?NjBlRXJvRzQyd2JtWCt1NnFMTkZubGFtaEZHVXNudnRNMzRUWjFCZCtJKzNv?=
 =?utf-8?B?d25DOWszRGFMb1BIM3ZLVzQ0bmVqd05ndHVDYVhwYXFvZEN1ZXdOdUR0MURR?=
 =?utf-8?B?YjhTdjZJM2tadVZKbkZkSThPRFY0VGpQTk53akVFOFg5d0gxTllQK1RYZGI1?=
 =?utf-8?B?S1FQWnRHVStvd2J6elVPNnp6Z2hQSXp1M0NPeEZoeGN4amdFREhpczhsaXdl?=
 =?utf-8?B?NXRMOXdEbVlzdTBNcTRSb2ZkenR1OG1IN05LWHVVTVU2RFFWVDMxZisyN2lQ?=
 =?utf-8?B?ak14RzJQOEJ5K29vbFhCTkNhVlRQcWIyYkE3M0pjdGxPaS84elJXSXZhaGU4?=
 =?utf-8?B?bUxORmNBRXR1Um5MSEgvN3UweUdvN3hIamFCWTVPUEovOHB5SFEvQ21Kekxu?=
 =?utf-8?B?NEl6cXZFcDlvOGh5MnZMUVV0aFFkdjM3NGgwNkpFbTVZYUFUc2hUS2JQdUQ1?=
 =?utf-8?B?enNnT3lVMTZlaWQ4SjdvTDJFKzFPeERCc3FkSWE3cENGQk5xN1hFdVZhdkty?=
 =?utf-8?B?L3FWdjIyRm1qcEtOdlB2YVZSaWlBUHZsSFR3T0tMN0RDWGYwYTBxZkVEOU0r?=
 =?utf-8?Q?6CVD5VcQ3fWG8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61bd7630-237e-4783-ae7a-08d8bc696fc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2021 11:00:30.5342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HApq/l9fyPObVphQTEVhpuCCLwl67BpFjteB33o2xdcFWtNAOJnW9HyhFQWOSYu6K0rknpRnWQS4aRNt7HsJ2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4522
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpvaG4gR2FycnkgPGpvaG4u
Z2FycnlAaHVhd2VpLmNvbT4NCj4gU2VudDogMjAyMeW5tDHmnIgxOeaXpSAxODo0MA0KPiBUbzog
Sm9ha2ltIFpoYW5nIDxxaWFuZ3FpbmcuemhhbmdAbnhwLmNvbT47IGFjbWVAa2VybmVsLm9yZzsN
Cj4gam9sc2FAcmVkaGF0LmNvbQ0KPiBDYzogd2lsbEBrZXJuZWwub3JnOyBsaW51eC1wZXJmLXVz
ZXJzQHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14DQo+IDxsaW51eC1pbXhAbnhwLmNvbT47
IG1hcmsucnV0bGFuZEBhcm0uY29tOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWMSAzLzRdIHBlcmYgdmVuZG9yIGV2ZW50czog
QWRkIEpTT04gbWV0cmljcyBmb3IgaW14OG1xDQo+IEREUiBQZXJmDQo+IA0KPiBPbiAxOS8wMS8y
MDIxIDAyOjU2LCBKb2FraW0gWmhhbmcgd3JvdGU6DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi5j
M2U5Zjg5YTRhNGQNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvdG9vbHMvcGVyZi9wbXUt
ZXZlbnRzL2FyY2gvYXJtNjQvZnJlZXNjYWxlL2lteDhtcS9zeXMvbWV0cmljcy5qcw0KPiA+ICsr
KyBvbg0KPiA+IEBAIC0wLDAgKzEsMjYgQEANCj4gPiArWw0KPiA+ICsgICB7DQo+ID4gKwkgICAg
IkJyaWVmRGVzY3JpcHRpb24iOiAiYmFuZHdpZHRoIHVzYWdlIGZvciBscGRkcjQgZXZrIGJvYXJk
IiwNCj4gDQo+IFdoeSBtZW50aW9uIHRoZSBldmsgYm9hcmQgc3BlY2lmaWNhbGx5PyBJcyB0aGlz
IG1ldHJpYyBvbmx5IHNwZWNpZmljIHRvIHRoYXQNCj4gYm9hcmQsIGFuZCBub3QgYWxsIGkuTVg4
TVEgcGxhdGZvcm1zPw0KDQpZZXMsIEpvaG4sIHdlIGhhdmUgbHBkZHI0IGV2ayBib2FyZCBhbmQg
ZGRyNCBldmsgYm9yYWQuLi4uLi4NCg0KSm9obiwgY2hhbmdlIHRvIHlvdXIgbmV3IGZyYW1ld29y
aywgSSBmb3VuZCBpdCBjYW4ndCBzdXBwb3J0IGFsbCBmZWF0dXJlcyB3aGljaCBpcyBzdXBwb3J0
ZWQgaW4gNS4xMCBrZXJuZWwuDQoNCkJlc3QgUmVnYXJkcywNCkpvYWtpbSBaaGFuZw0KPiBUaGFu
a3MsDQo+IEpvaG4NCj4gDQo+ID4gKwkgICAgIk1ldHJpY05hbWUiOiAiaW14OG1xX2JhbmR3aWR0
aF91c2FnZS5scGRkcjQiLA0KPiA+ICsJICAgICJNZXRyaWNFeHByIjogIigoIGlteDhfZGRyMEBy
ZWFkXFwtY3ljbGVzQCArDQo+IGlteDhfZGRyMEB3cml0ZVxcLWN5Y2xlc0AgKSAqIDQgKiA0IC8g
ZHVyYXRpb25fdGltZSkgLyAoODAwICogMTAwMDAwMCAqIDQgKg0KPiA0KSIsDQo+ID4gKwkgICAg
IlNjYWxlVW5pdCI6ICIxZTIlIiwNCj4gPiArCSAgICAiVW5pdCI6ICJpbXg4X2RkciIsDQo+ID4g
KwkgICAgIkNvbXBhdCI6ICJpLk1YOE1RIg0KPiA+ICsgICB9LA0KDQo=
