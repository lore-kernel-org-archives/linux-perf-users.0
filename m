Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7CEC433DB
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Jan 2021 05:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 074C423142
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Jan 2021 05:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbhATFsD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 20 Jan 2021 00:48:03 -0500
Received: from mail-eopbgr50060.outbound.protection.outlook.com ([40.107.5.60]:31623
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727088AbhATFrf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 20 Jan 2021 00:47:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2C4sZi0FDHQ4M1rQ7z1FffrUZhX93ATq8QblQBU9tKEdDLC1AZMcpvwdQXt4TJg8yc1KTufq83ljoiA99kf3XGgRrNQbvdUh2DvTpwuU7G9Iy8vICwEZzVfpWbiJs/kBd9po7bTDfDL6/w21zr+nHh/iv2T+S5rSmX+DAj0AAUC/xPlfbyNfanbeQcQ49uvETDQxCur4zxEy4EV6zX35osrgnB1G04/8rChtAwprP+yGk1gVeyiL5QBEuFSjoot2bkqdiR483+421qzRhU5swyGVDT+dIoDy2hhixQIJXZK+vGUFlFQ22eosWPQ7ir2N0flcfjFx3nK8GMQ12v8Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwG0b5q1WmOFyzNBzXfnOY7rUtmkxThLJXeMpKzc92w=;
 b=Zdb8jC5k5FMInPluaSZtCP98ppNWZ8M3TRfrkuTEF172HRCduXKdEIYNFUqg18gtRVQ2p4SqIpm4aZMVraprzqV+4r8iQGrMUVuyuxrjJGxMFCr5sW3M/pTbqOROo9zDLhf4dYihdyPNm1m+LIvt4PyuDWztAU7RxnomoHbYilHp+K65Rfial4/uWAQ/ew8XVrMQFuZKm7zJOOE5YzVrWyBEKk/0WLZOAnhYhbudxxJwQA/cjqZjbSo25mhhJSvcUBCbHUbnyvTxDYTssAMcedKfRSzklETqmBNPznRzbgoM/lryaapWCc5xMLpdkmKDkt82cdFQMG0EcGCFCqyzXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwG0b5q1WmOFyzNBzXfnOY7rUtmkxThLJXeMpKzc92w=;
 b=OQCMCPsEREf0HRCusgHYSBz2JPEH4AUZ+4POikqruqDri7WVUe+9wY56wfIABKXcNnwTGIzJgTwNkdAIy5lAPUPLn5Bv6iN31fEipQTe3zATg5S1nsHaiTWZNsqsGa45HS/aShaAfg/+D8qPiHomqylWkMS0KsmTV/k0IQpDraw=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DBBPR04MB6140.eurprd04.prod.outlook.com (2603:10a6:10:c7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Wed, 20 Jan
 2021 05:46:45 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::b83c:2edc:17e8:2666]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::b83c:2edc:17e8:2666%4]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 05:46:45 +0000
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
Thread-Index: AQHW7g7uaO/NwgWkPU2zY0Lz58OHbKouwtGAgAAEwLCAABktAIABGafg
Date:   Wed, 20 Jan 2021 05:46:45 +0000
Message-ID: <DB8PR04MB6795DB8ACE469B28A8A6F0ECE6A20@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <20210119025647.12569-1-qiangqing.zhang@nxp.com>
 <20210119025647.12569-4-qiangqing.zhang@nxp.com>
 <20a74eda-ae1b-249e-06f1-4ab70e20f684@huawei.com>
 <DB8PR04MB6795A3ED474456F17F52680AE6A30@DB8PR04MB6795.eurprd04.prod.outlook.com>
 <65bb44fa-a75a-4425-5289-7ac6374b9285@huawei.com>
In-Reply-To: <65bb44fa-a75a-4425-5289-7ac6374b9285@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 523523fd-d22b-4cba-a641-08d8bd06c583
x-ms-traffictypediagnostic: DBBPR04MB6140:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DBBPR04MB6140B259F2614573723530B2E6A20@DBBPR04MB6140.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d2eI84bsuXHdeBBASWRDo/GcXE6kpqF4Ae7x5AVZrjoZxp5Gq6uX8T2MmHYF/CgegKP4eYcGHekEyksGjSdE3WpKlxWcDkjEwOWE+QG8xgkYQbmesxCrbuy3liAOmh84bVJKkGelJEv9BWaDot2SUGydNDwKydcdJPSZwaSnaFJxOtv0gbR1oPfHSyTEfP0npIOqA0Uc6pwblJSEt+1r9bzzZfhKlI3lrOEF2lXoBA2e/ULMypkKI9FYjhFAXY/2rCgp6/FA3Ys5w62iem5AIhC63BtYadd6DAZAHonomDXDLvA9qtKq0s5Lc820wEJ5G8fmBnHa3EP0UsmXe0k31CluoEqr7rORFzYEjYCPyU2eYObgmgulbdw/9z5Lh7Stj1tbOsItgSn0uDG1ifWT/+hSYXhaG+8T/Zi65dEVItPheLRY6WNTYo0QOyBgaDLX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(366004)(136003)(376002)(53546011)(316002)(6506007)(52536014)(110136005)(54906003)(186003)(66446008)(26005)(4326008)(76116006)(66476007)(64756008)(66556008)(66946007)(8936002)(9686003)(5660300002)(478600001)(55016002)(7696005)(86362001)(33656002)(2906002)(8676002)(71200400001)(83380400001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UnZpTTVDdFZaYW5aQzB3eUV4RndhS01pcWttM3lDNFpSTHU4NXUreHZzWEMr?=
 =?utf-8?B?RzA5ZitRdm45T04xN3NrM2NoZHN2aVpyVjhMTjdvQ1JSVHAvQXJEYXQreWJl?=
 =?utf-8?B?dzBjSHFReTk5UEpTOEQrRHBiZWpZU0FyWTFJUFpjOUt0OTgybzI4TFRKZVF4?=
 =?utf-8?B?RjhWd2NXZWQ5aWJEam4vY29HRVJqd1loU1doUGFkelhRSkplbmo4Z0xYRGhU?=
 =?utf-8?B?SXhPREtKOFVhNklBMWZQbWtCWldiTHhDd21CWHIrTmZUTk8reU1nZm0zeTl3?=
 =?utf-8?B?dFJXUDYxbjJtQmVITW1GQlpvaWYzTTIyMWpsenlKYUQyNnR5TERqbjM3RVdp?=
 =?utf-8?B?UFNBYzRiYWdZSTBMTjFEaGxUYWJScnh4SGlpWWxaL0RqMGZnWXNmanVYVGZQ?=
 =?utf-8?B?TWtLMi9sQ09kRTk5WEN5ZThLclRPdWIxckRPZkdxY0NBSnNyN2tkVTRrQUdr?=
 =?utf-8?B?MWpFei9CQnB6R2dUUUUrSU03V1ZuVExoWStpRzBXVktMVzRGODFhcWJpRHFT?=
 =?utf-8?B?WGwyQms3b1I5QXRJRmlYOWplS3BsQzFXd0NSRmdtbGRCT0dScTM1QUpLVFRU?=
 =?utf-8?B?OG4rRVVoYTh6c2pTSTRiQ0toM01BNnhyQk12OUlWMjRDaElTS1BiRTZhV3Aw?=
 =?utf-8?B?QkVHNEJHVkM1NWhJKzNxc0x6ZVpyajF6cGlJb1BHMjlSVG8rTnFBM3hPazcw?=
 =?utf-8?B?eEkvb2hOU3J6Q3Nmc3ZWQmJpYmtBV21jenJlN01XTHdkK3g2L1RGU213WTNI?=
 =?utf-8?B?Mkw4c01rRjZrZFgrY05raThpZDZ5eFpGbHZkejlldVM4RitUeDcrUEZyRG01?=
 =?utf-8?B?Ulg0MFNIRjBkRFd4V3Uwb3M1RXh5TjFJMmpsNDE5TWpoSllaMUpidXYrbU8x?=
 =?utf-8?B?bGpLSENnVkk3aWN1YitGa09SN3FQVTEyYURnL2dxdHMxN2dzSG9VditFazdM?=
 =?utf-8?B?enFWR0QzU0dNTVczdnkyQzZYdXJkY3ZKeXVNZ0FqNkI4OXBTL0tBVFVTRnZD?=
 =?utf-8?B?Z0NJSytyQnZTY1dqd1RmWkpETnhoN2xPcUN6dHhiZko4SkNxNWhuRHY1bDFy?=
 =?utf-8?B?YUgzb2syVlRQeU1DTkxVWEh4S0U2VE1LRlFIM1FTOWVTMmpwYXFBanZBT3Rz?=
 =?utf-8?B?cjJCbHczQmZhby9WS2NwNDI2NlVZbEZLU09Uc3hTRTlodDZvLzZHMzdjTzlv?=
 =?utf-8?B?TXJoZkwwYldJaU51VHFadVRZN1JhbUYwbU4rWHlwaEFnR1gwUW1wTHJaejU1?=
 =?utf-8?B?bDg1UExtUG1nOXNwUThRK0tZa3dEYXFJTEQ2NGxIay9zS3Y1Ti9KTk12U1pX?=
 =?utf-8?Q?9lPdcyqy36LxY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 523523fd-d22b-4cba-a641-08d8bd06c583
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2021 05:46:45.3092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 08avdDLRJjaLlL871vMOPqwTpHH6nEBc5wo7hyPDfI0XmUhl7eV/XAXoM1eL3IHf1ryABaKUiZpZi2Bw8UwadQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6140
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpvaG4gR2FycnkgPGpvaG4u
Z2FycnlAaHVhd2VpLmNvbT4NCj4gU2VudDogMjAyMeW5tDHmnIgxOeaXpSAyMDoyNw0KPiBUbzog
Sm9ha2ltIFpoYW5nIDxxaWFuZ3FpbmcuemhhbmdAbnhwLmNvbT47IGFjbWVAa2VybmVsLm9yZzsN
Cj4gam9sc2FAcmVkaGF0LmNvbQ0KPiBDYzogd2lsbEBrZXJuZWwub3JnOyBsaW51eC1wZXJmLXVz
ZXJzQHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14DQo+IDxsaW51eC1pbXhAbnhwLmNvbT47
IG1hcmsucnV0bGFuZEBhcm0uY29tOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWMSAzLzRdIHBlcmYgdmVuZG9yIGV2ZW50czog
QWRkIEpTT04gbWV0cmljcyBmb3IgaW14OG1xDQo+IEREUiBQZXJmDQo+IA0KPiBPbiAxOS8wMS8y
MDIxIDExOjAwLCBKb2FraW0gWmhhbmcgd3JvdGU6DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+ID4+IEZyb206IEpvaG4gR2Fycnk8am9obi5nYXJyeUBodWF3ZWkuY29tPg0KPiA+
PiBTZW50OiAyMDIx5bm0MeaciDE55pelIDE4OjQwDQo+ID4+IFRvOiBKb2FraW0gWmhhbmc8cWlh
bmdxaW5nLnpoYW5nQG54cC5jb20+O2FjbWVAa2VybmVsLm9yZzsNCj4gPj4gam9sc2FAcmVkaGF0
LmNvbQ0KPiA+PiBDYzp3aWxsQGtlcm5lbC5vcmc7bGludXgtcGVyZi11c2Vyc0B2Z2VyLmtlcm5l
bC5vcmc7IGRsLWxpbnV4LWlteA0KPiA+PiA8bGludXgtaW14QG54cC5jb20+O21hcmsucnV0bGFu
ZEBhcm0uY29tOw0KPiA+PiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4g
Pj4gU3ViamVjdDogUmU6IFtQQVRDSCBWMSAzLzRdIHBlcmYgdmVuZG9yIGV2ZW50czogQWRkIEpT
T04gbWV0cmljcyBmb3INCj4gPj4gaW14OG1xIEREUiBQZXJmDQo+ID4+DQo+ID4+IE9uIDE5LzAx
LzIwMjEgMDI6NTYsIEpvYWtpbSBaaGFuZyB3cm90ZToNCj4gPj4+IGluZGV4IDAwMDAwMDAwMDAw
MC4uYzNlOWY4OWE0YTRkDQo+ID4+PiAtLS0gL2Rldi9udWxsDQo+ID4+PiArKysgYi90b29scy9w
ZXJmL3BtdS1ldmVudHMvYXJjaC9hcm02NC9mcmVlc2NhbGUvaW14OG1xL3N5cy9tZXRyaWNzLg0K
PiA+Pj4gKysrIGpzDQo+ID4+PiArKysgb24NCj4gPj4+IEBAIC0wLDAgKzEsMjYgQEANCj4gPj4+
ICtbDQo+ID4+PiArICAgew0KPiA+Pj4gKwkgICAgIkJyaWVmRGVzY3JpcHRpb24iOiAiYmFuZHdp
ZHRoIHVzYWdlIGZvciBscGRkcjQgZXZrIGJvYXJkIiwNCj4gPj4gV2h5IG1lbnRpb24gdGhlIGV2
ayBib2FyZCBzcGVjaWZpY2FsbHk/IElzIHRoaXMgbWV0cmljIG9ubHkgc3BlY2lmaWMNCj4gPj4g
dG8gdGhhdCBib2FyZCwgYW5kIG5vdCBhbGwgaS5NWDhNUSBwbGF0Zm9ybXM/DQo+ID4gWWVzLCBK
b2huLCB3ZSBoYXZlIGxwZGRyNCBldmsgYm9hcmQgYW5kIGRkcjQgZXZrIGJvcmFkLi4uLi4uDQo+
ID4NCj4gDQo+IEhvdyBpcyB0aGlzIHN1cHBvc2VkIHRvIHdvcms/DQo+IA0KPiBTbyBwZXJmIG1h
dGNoZXMgb24gdGhlIGlkZW50aWZpZXIgZmlsZSBmb3Igc3lzdGVtIFBNVXM7IGhvd2V2ZXIgdGhl
IGNvbnRlbnRzIG9mDQo+IHRoaXMgZmlsZSBhcmUgYmFzZWQgb24gdGhlIEhXIGltcGxlbWVudGF0
aW9uIGZvciBpbXggRERSIFBNVSwgbm90IHRoZSBib2FyZC4NCg0KWWVzLCBJIGtub3cgdGhpcyBm
ZWF0dXJlIGlzIGZvciBzeXN0ZW0gUE1VLCBub3QgYm9hcmQuIFlvdSBrbm93IEREUiBiYW5kd2lk
dGggY2FsY3VsYXRpb24gaXMgYmFzZWQgb24gRERSIGNsb2NrIGZyZXF1ZW5jeSwgd2hpY2ggaXMg
dmFyeSBmb3JtIGJvYXJkcy4NCg0KZS5nLg0KbHBkZHI0IGJvYXJkLCBERFIgY2xvY2sgZnJlcXVl
bmN5IGlzIDc1ME1IWjoNCiJNZXRyaWNFeHByIjogIigoIGlteDhfZGRyMEByZWFkXFwtY3ljbGVz
QCArIGlteDhfZGRyMEB3cml0ZVxcLWN5Y2xlc0AgKSAqIDQgKiA0IC8gZHVyYXRpb25fdGltZSkg
LyAoNzUwICogMTAwMDAwMCAqIDQgKiA0KSIgICAgDQoNCmRkcjQgYm9hcmQsIEREUiBjbG9jayBm
cmVxdWVuY3kgaXMgNjAwTUhaLg0KIk1ldHJpY0V4cHIiOiAiKCggaW14OF9kZHIwQHJlYWRcXC1j
eWNsZXNAICsgaW14OF9kZHIwQHdyaXRlXFwtY3ljbGVzQCApICogNCAqIDQgLyBkdXJhdGlvbl90
aW1lKSAvICg2MDAgKiAxMDAwMDAwICogNCAqIDQpIg0KDQpJIGdpdmUgZGlmZmVyZW50IG1ldHJp
YyBuYW1lcywgDQoiTWV0cmljTmFtZSI6ICJpbXg4bW1fYmFuZHdpZHRoX3VzYWdlLmxwZGRyNCIN
CiJNZXRyaWNOYW1lIjogImlteDhtbV9iYW5kd2lkdGhfdXNhZ2UuZGRyNCINCg0KU28gdXNlcnMg
Y2FuIHNlbGVjdCBjb3JyZWN0IGJhbmR3aWR0aCBtZXRyaWMgYWNjb3JkaW5nIHRvIHRoZWlyIG93
biBib2FyZCB0eXBlcy4gVG8gYSBjZXJ0YWluIGV4dGVudCwgaXQgY2FuIGFsc28gc3VwcG9ydCBz
b21lIGJvYXJkLWxldmVsIG1ldHJpY3MuDQoNCklmIGl0IGlzIG9rYXkgZm9yIHlvdSwgSSB3aWxs
IHNlbmQgYSBWMiB0byByZXBsYWNlICggaW14OF9kZHIwQHJlYWRcXC1jeWNsZXNAICsgaW14OF9k
ZHIwQHdyaXRlXFwtY3ljbGVzQCApIHdpdGggKCBpbXg4bW1fZGRyLnJlYWRfY3ljbGVzICsgaW14
OG1tX2Rkci53cml0ZV9jeWNsZXMgKS4NCg0KPiA+IEpvaG4sIGNoYW5nZSB0byB5b3VyIG5ldyBm
cmFtZXdvcmssIEkgZm91bmQgaXQgY2FuJ3Qgc3VwcG9ydCBhbGwgZmVhdHVyZXMNCj4gd2hpY2gg
aXMgc3VwcG9ydGVkIGluIDUuMTAga2VybmVsLg0KPiANCj4gWWVzLCBzbyBsZXQgbWUga25vdyBh
Ym91dCBhbGwgdGhlIHByb2JsZW1zLg0KDQpJdCBzaG91bGQgaGF2ZSB3b3JrZWQgYXMgNS4xMCBr
ZXJuZWwgYXQgbXkgc2lkZS4gVGhhbmtzLg0KDQpCZXN0IFJlZ2FyZHMsDQpKb2FraW0gWmhhbmcN
Cj4gVGhhbmtzLA0KPiBqb2huDQo+IA0KDQo=
