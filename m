Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77514C433DB
	for <linux-perf-users@archiver.kernel.org>; Thu, 21 Jan 2021 18:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1523023A5E
	for <linux-perf-users@archiver.kernel.org>; Thu, 21 Jan 2021 18:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbhAUK2l (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 21 Jan 2021 05:28:41 -0500
Received: from mail-eopbgr10076.outbound.protection.outlook.com ([40.107.1.76]:49390
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729151AbhAUKZe (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 21 Jan 2021 05:25:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAzOV22/MD4/51r8nwZBHcW78pIT47g5Y/yCBsYCuotzQumlpJOAaOk0M9HEbONw+cO4PIooGjtDXBVUQvWV6nDeH2D6AA2NZ4KwAcv2hY6VlCWUMd1nZJCRmaH9ALWeox7UPWkl7/D7gHBKWwZB6CXmA3ULr2FXHMt8fgWiCtCO7kG8wXhMZWwijn/qP/ooZbXqaHd+wTyDcYpHxqoEOe7jZB7C2xIdKZPLkRPNmKa2EY+I7SakfWSUdrABaiUHTdHUibP9c+G0ndx6lPL+29BbiJAaNBO+GyhvPR4DscEDD7TZVS8q0hP2T8sgoGU5M9j+9ibtUSi/DflbQLeAOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFkDK3JE5V66g8hsGLf8wiNSO2vpEQTMLCURRmWgpYo=;
 b=OrcDS6yubz7YGj8wd0VGlvm5mQO7ksdYeeCco7qV3evBfgNIzUckCv3dUlf4syWSTpX8AaBvYjwBsNAgQooX8fBdW/4ofkhLHtPm4dSTzELYFjexDCFlVZCKUAvBDElrcX4slP9LstkeE9pb4A8TXZJo/8jbhfzQljvoE1Eig1Z0q1uLTxWxSqJzawGKbcJCwMedUN8DajTHaA0WCbLahedOhJQCIEKoSV1o4Ys9zXL2j6qGrFo0LBuzplLcva36AzFODfjn0Obt4hCdNV9rOrZGtRajBsnY8/3HuDSxNUOgmdbbLdZL0/hWBkduUPc32JPrnXS4FE0fV5oU3eOVOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFkDK3JE5V66g8hsGLf8wiNSO2vpEQTMLCURRmWgpYo=;
 b=KuMuKB7D8DoP5GRTvqma/BjlzfKHdJaxb6jZxITuWOee3GQq58mSgQlyu730MLekpGhG8+509k7bFKeTQbf13c4x3Sf4dbBH3u0k4PMyWCKgo98vp88K6azoKU2+tkJ2pBIRUbZ1ndK25yCrxcIOGFPQBKJDcEtXTMevXqUQshU=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB8PR04MB7100.eurprd04.prod.outlook.com (2603:10a6:10:127::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Thu, 21 Jan
 2021 10:24:43 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::b83c:2edc:17e8:2666]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::b83c:2edc:17e8:2666%4]) with mapi id 15.20.3763.014; Thu, 21 Jan 2021
 10:24:43 +0000
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
Thread-Index: AQHW7g7uaO/NwgWkPU2zY0Lz58OHbKouwtGAgAAEwLCAABktAIABGafggABF+oCAAaGlIA==
Date:   Thu, 21 Jan 2021 10:24:43 +0000
Message-ID: <DB8PR04MB6795DB4D042DF5326FE7DAAEE6A10@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <20210119025647.12569-1-qiangqing.zhang@nxp.com>
 <20210119025647.12569-4-qiangqing.zhang@nxp.com>
 <20a74eda-ae1b-249e-06f1-4ab70e20f684@huawei.com>
 <DB8PR04MB6795A3ED474456F17F52680AE6A30@DB8PR04MB6795.eurprd04.prod.outlook.com>
 <65bb44fa-a75a-4425-5289-7ac6374b9285@huawei.com>
 <DB8PR04MB6795DB8ACE469B28A8A6F0ECE6A20@DB8PR04MB6795.eurprd04.prod.outlook.com>
 <d3e18e10-dbab-db24-02a9-19fcd53c4bb5@huawei.com>
In-Reply-To: <d3e18e10-dbab-db24-02a9-19fcd53c4bb5@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 679d02db-5d19-4870-532c-08d8bdf6c4dc
x-ms-traffictypediagnostic: DB8PR04MB7100:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB7100767393E38826D0517336E6A10@DB8PR04MB7100.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DfFKYbfxz8coPg6egcnwy+m3bel9L2tTmcRT9y6mJQGTNzbhcMxs8vTX8uDHZ7Nz9uBAwlRMZ50lYIebN4EUPPwUzRAN+4ANcQrdAokarg1Ki3BcnX3wwcrFgOAFCxkaik9ZVxdp/BxRHX2Yy35C9KvOIp4/woQvqxgiMg4CpWqD0OcDI+9PTsqYNHBDtzY8JAGXOLEVfG93Jcb4yEb3SZeDBQzJSVdDhcdBphttYz2n1fuUT5vsKl31CaLyFDJvHTgQcNLcwvvmpNlQEFSTF+o6QlgwnwmAETFWTkKEKlRSx3ZzYdgxQCds+nKG++vKYBTvDq1zRQR7KZzUp8NmF+J5cPCbrTkj9wXN+at8BD817tWaJcwcqfqfVvIzFNQ1j/sjXaESn0Oer8e7Yk7O8We5oKL3DZYo/ATrweF1eYCCvPuosZbWvi7qOHP9lVKTSkBdTgKFr0KcAHdCjmgioi7u7/SqioYHA3adsML6PHOOQYYcgpMkWn4WP8e0Q/Iz4d7gRjfF3DxPT0ApqbQw5XOlKk7tLz2Sr0/2Fk0siAaKmXkwUgldG82HyQTzd47e
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(2906002)(86362001)(8676002)(316002)(9686003)(52536014)(6506007)(33656002)(71200400001)(76116006)(26005)(54906003)(110136005)(478600001)(83380400001)(5660300002)(53546011)(186003)(55016002)(7696005)(66476007)(66946007)(66446008)(4326008)(64756008)(8936002)(66556008)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: cjuJ56j8hb7VTRlPQ08k6a2BrwwCJUP7qq35TWRqNFgEBBY8gCwdC5iV/aA/6XC7oU5zYqTdZJF0/C/yAB/vZxn6mapRzPaGmO+UkJ8VN0aImoyjY4RHO1HY6tkrPLbN87yctENKCoc14jMrEybt6LRA+dlDTXQiR0/XwOxqHsdcpHky8YKhEqLO8KGtX/HbBSzcfHu+Yg0H58YdATkzD8mgsuqLZ6tAOf2MzM//EybB2IcNhbg2ATahDkjflpRkhYOx7mxfsOeoaOh+uAk9kyfYU/qKxjij0bY9wWkOkb2oqqaf7SG8vSGENZiBAk9TPUqpnTP12n9+X0XAHNMSAAikG0rLaTfiNwF9TGPj015W5kSyPiITKeuEeZ6NMXX4mkjf8j4mpuUTBtm0z2K4h6x/3rMtaA6PJnlpoK83neXJ6Su/5zrNWn8AbMkmxrofXMbaZ9CoYP3qKobDogbgeU4DQXXEU5+Lytun1apMqC1XJRPtfzn8ufw1fxIkuZRXhP0m6u3CLiFRLyc8loPs7CaokqcEqlVjaYbmdj89pX2hjWhJOHDU0nkHMT4ZY9e9ShxwRxWqVIG1iahc8EvUpCsy62BCtHKnVQ8+86X7dC/6qZsgWT++mMge4XFpWmh2yHoMYQqCVKJ61bWvOKLf3+B0vxkTn40hqvx1lfY2GCaSa1Jc+d/xVzACpmqd8n37zVJfLEe6RpIdhOfAPidkiz0afX/65Ds9f48mh4eQ5is=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 679d02db-5d19-4870-532c-08d8bdf6c4dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2021 10:24:43.4675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V5ehx8dmee+2+XC7vHrTdRYK24GO3Nu3YH2MbzgQrHkl+A8jv1D2N7M7pyD1oGpAEig0KOon30gNEn1ObDLMOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7100
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpvaG4gR2FycnkgPGpvaG4u
Z2FycnlAaHVhd2VpLmNvbT4NCj4gU2VudDogMjAyMeW5tDHmnIgyMOaXpSAxNzoyNg0KPiBUbzog
Sm9ha2ltIFpoYW5nIDxxaWFuZ3FpbmcuemhhbmdAbnhwLmNvbT47IGFjbWVAa2VybmVsLm9yZzsN
Cj4gam9sc2FAcmVkaGF0LmNvbQ0KPiBDYzogd2lsbEBrZXJuZWwub3JnOyBsaW51eC1wZXJmLXVz
ZXJzQHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14DQo+IDxsaW51eC1pbXhAbnhwLmNvbT47
IG1hcmsucnV0bGFuZEBhcm0uY29tOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWMSAzLzRdIHBlcmYgdmVuZG9yIGV2ZW50czog
QWRkIEpTT04gbWV0cmljcyBmb3IgaW14OG1xDQo+IEREUiBQZXJmDQo+IA0KPiBPbiAyMC8wMS8y
MDIxIDA1OjQ2LCBKb2FraW0gWmhhbmcgd3JvdGU6DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+ID4+IEZyb206IEpvaG4gR2Fycnk8am9obi5nYXJyeUBodWF3ZWkuY29tPg0KPiA+
PiBTZW50OiAyMDIx5bm0MeaciDE55pelIDIwOjI3DQo+ID4+IFRvOiBKb2FraW0gWmhhbmc8cWlh
bmdxaW5nLnpoYW5nQG54cC5jb20+O2FjbWVAa2VybmVsLm9yZzsNCj4gPj4gam9sc2FAcmVkaGF0
LmNvbQ0KPiA+PiBDYzp3aWxsQGtlcm5lbC5vcmc7bGludXgtcGVyZi11c2Vyc0B2Z2VyLmtlcm5l
bC5vcmc7IGRsLWxpbnV4LWlteA0KPiA+PiA8bGludXgtaW14QG54cC5jb20+O21hcmsucnV0bGFu
ZEBhcm0uY29tOw0KPiA+PiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4g
Pj4gU3ViamVjdDogUmU6IFtQQVRDSCBWMSAzLzRdIHBlcmYgdmVuZG9yIGV2ZW50czogQWRkIEpT
T04gbWV0cmljcyBmb3INCj4gPj4gaW14OG1xIEREUiBQZXJmDQo+ID4+DQo+ID4+IE9uIDE5LzAx
LzIwMjEgMTE6MDAsIEpvYWtpbSBaaGFuZyB3cm90ZToNCj4gPj4+PiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiA+Pj4+IEZyb206IEpvaG4gR2Fycnk8am9obi5nYXJyeUBodWF3ZWkuY29t
Pg0KPiA+Pj4+IFNlbnQ6IDIwMjHlubQx5pyIMTnml6UgMTg6NDANCj4gPj4+PiBUbzogSm9ha2lt
IFpoYW5nPHFpYW5ncWluZy56aGFuZ0BueHAuY29tPjthY21lQGtlcm5lbC5vcmc7DQo+ID4+Pj4g
am9sc2FAcmVkaGF0LmNvbQ0KPiA+Pj4+IENjOndpbGxAa2VybmVsLm9yZztsaW51eC1wZXJmLXVz
ZXJzQHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14DQo+ID4+Pj4gPGxpbnV4LWlteEBueHAu
Y29tPjttYXJrLnJ1dGxhbmRAYXJtLmNvbTsNCj4gPj4+PiBsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmcNCj4gPj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIFYxIDMvNF0gcGVyZiB2
ZW5kb3IgZXZlbnRzOiBBZGQgSlNPTiBtZXRyaWNzDQo+ID4+Pj4gZm9yIGlteDhtcSBERFIgUGVy
Zg0KPiA+Pj4+DQo+ID4+Pj4gT24gMTkvMDEvMjAyMSAwMjo1NiwgSm9ha2ltIFpoYW5nIHdyb3Rl
Og0KPiA+Pj4+PiBpbmRleCAwMDAwMDAwMDAwMDAuLmMzZTlmODlhNGE0ZA0KPiA+Pj4+PiAtLS0g
L2Rldi9udWxsDQo+ID4+Pj4+ICsrKw0KPiBiL3Rvb2xzL3BlcmYvcG11LWV2ZW50cy9hcmNoL2Fy
bTY0L2ZyZWVzY2FsZS9pbXg4bXEvc3lzL21ldHJpY3MuDQo+ID4+Pj4+ICsrKyBqcw0KPiA+Pj4+
PiArKysgb24NCj4gPj4+Pj4gQEAgLTAsMCArMSwyNiBAQA0KPiA+Pj4+PiArWw0KPiA+Pj4+PiAr
ICAgew0KPiA+Pj4+PiArCSAgICAiQnJpZWZEZXNjcmlwdGlvbiI6ICJiYW5kd2lkdGggdXNhZ2Ug
Zm9yIGxwZGRyNCBldmsgYm9hcmQiLA0KPiA+Pj4+IFdoeSBtZW50aW9uIHRoZSBldmsgYm9hcmQg
c3BlY2lmaWNhbGx5PyBJcyB0aGlzIG1ldHJpYyBvbmx5DQo+ID4+Pj4gc3BlY2lmaWMgdG8gdGhh
dCBib2FyZCwgYW5kIG5vdCBhbGwgaS5NWDhNUSBwbGF0Zm9ybXM/DQo+ID4+PiBZZXMsIEpvaG4s
IHdlIGhhdmUgbHBkZHI0IGV2ayBib2FyZCBhbmQgZGRyNCBldmsgYm9yYWQuLi4uLi4NCj4gPj4+
DQo+ID4+IEhvdyBpcyB0aGlzIHN1cHBvc2VkIHRvIHdvcms/DQo+ID4+DQo+ID4+IFNvIHBlcmYg
bWF0Y2hlcyBvbiB0aGUgaWRlbnRpZmllciBmaWxlIGZvciBzeXN0ZW0gUE1VczsgaG93ZXZlciB0
aGUNCj4gPj4gY29udGVudHMgb2YgdGhpcyBmaWxlIGFyZSBiYXNlZCBvbiB0aGUgSFcgaW1wbGVt
ZW50YXRpb24gZm9yIGlteCBERFIgUE1VLA0KPiBub3QgdGhlIGJvYXJkLg0KPiA+IFllcywgSSBr
bm93IHRoaXMgZmVhdHVyZSBpcyBmb3Igc3lzdGVtIFBNVSwgbm90IGJvYXJkLiBZb3Uga25vdyBE
RFINCj4gYmFuZHdpZHRoIGNhbGN1bGF0aW9uIGlzIGJhc2VkIG9uIEREUiBjbG9jayBmcmVxdWVu
Y3ksIHdoaWNoIGlzIHZhcnkgZm9ybQ0KPiBib2FyZHMuDQo+ID4NCj4gPiBlLmcuDQo+ID4gbHBk
ZHI0IGJvYXJkLCBERFIgY2xvY2sgZnJlcXVlbmN5IGlzIDc1ME1IWjoNCj4gPiAiTWV0cmljRXhw
ciI6ICIoKCBpbXg4X2RkcjBAcmVhZFxcLWN5Y2xlc0AgKyBpbXg4X2RkcjBAd3JpdGVcXC1jeWNs
ZXNAICkNCj4gKiA0ICogNCAvIGR1cmF0aW9uX3RpbWUpIC8gKDc1MCAqIDEwMDAwMDAgKiA0ICog
NCkiDQo+ID4NCj4gPiBkZHI0IGJvYXJkLCBERFIgY2xvY2sgZnJlcXVlbmN5IGlzIDYwME1IWi4N
Cj4gPiAiTWV0cmljRXhwciI6ICIoKCBpbXg4X2RkcjBAcmVhZFxcLWN5Y2xlc0AgKyBpbXg4X2Rk
cjBAd3JpdGVcXC1jeWNsZXNAICkNCj4gKiA0ICogNCAvIGR1cmF0aW9uX3RpbWUpIC8gKDYwMCAq
IDEwMDAwMDAgKiA0ICogNCkiDQo+ID4NCj4gPiBJIGdpdmUgZGlmZmVyZW50IG1ldHJpYyBuYW1l
cywNCj4gPiAiTWV0cmljTmFtZSI6ICJpbXg4bW1fYmFuZHdpZHRoX3VzYWdlLmxwZGRyNCINCj4g
PiAiTWV0cmljTmFtZSI6ICJpbXg4bW1fYmFuZHdpZHRoX3VzYWdlLmRkcjQiDQo+ID4NCj4gDQo+
IEJ1dCB0aGF0IGlzIGp1c3Qgbm90IGhvdyB0aGluZ3MgYXJlIGRvbmUuIFdlIC0gb3IgSSAtIHdv
dWxkIGV4cGVjdCB0aGF0IHBlcmYgdG9vbA0KPiB3b3VsZCBoYXZlIHRoZSBpbnRlbGxpZ2VuY2Ug
dG8ga25vdyB0aGUgYXBwcm9wcmlhdGUgbWV0cmljIGZvciB0aGF0IHNwZWNpZmljDQo+IHBsYXRm
b3JtLiBPciwgbW9yZSBzcGVjaWZpY2FsbHksIHdlIHNob3VsZCBub3QgcHJlc2VudCB0aGUgdXNl
ciB3aXRoIG1hbnkNCj4gbWV0cmljcyBhbmQgZXhwZWN0IGhpbS9oZXIgdG8ga25vdyB0aGUgYXBw
cm9wcmlhdGUgbWV0cmljIGZvciB0aGUgc3BlY2lmaWMNCj4gYm9hcmQuDQo+IA0KPiBBcmUgdGhl
cmUgb3RoZXIgY2FzZXMgZm9yIG90aGVyIGFyY2hpdGVjdHVyZXMgd2hlcmUgdGhpbmdzIGFyZSBk
b25lIGxpa2UgdGhpcz8NCg0KDQpJIGRvbid0IGtub3cgaWYgZXhpc3Qgb3RoZXIgY2FzZXMuIElm
IHlvdSBjYW7igJl0IGFjY2VwdCBpdCwgSSBjYW4gb25seSBwdXNoIHBhcnQgb2YgaXQgZmlyc3Qs
IGFuZCBsZXQgYmFuZHdpZHRoIG1ldHJpYyBsb2NhbGx5Lg0KDQoNCkJlc3QgUmVnYXJkcywNCkpv
YWtpbSBaaGFuZw0KPiBUaGFua3MsDQo+IEpvaG4NCj4gDQo+ID4gU28gdXNlcnMgY2FuIHNlbGVj
dCBjb3JyZWN0IGJhbmR3aWR0aCBtZXRyaWMgYWNjb3JkaW5nIHRvIHRoZWlyIG93biBib2FyZA0K
PiB0eXBlcy4gVG8gYSBjZXJ0YWluIGV4dGVudCwgaXQgY2FuIGFsc28gc3VwcG9ydCBzb21lIGJv
YXJkLWxldmVsIG1ldHJpY3MuDQo+ID4NCj4gPiBJZiBpdCBpcyBva2F5IGZvciB5b3UsIEkgd2ls
bCBzZW5kIGEgVjIgdG8gcmVwbGFjZSAoIGlteDhfZGRyMEByZWFkXFwtY3ljbGVzQCArDQo+IGlt
eDhfZGRyMEB3cml0ZVxcLWN5Y2xlc0AgKSB3aXRoICggaW14OG1tX2Rkci5yZWFkX2N5Y2xlcyAr
DQo+IGlteDhtbV9kZHIud3JpdGVfY3ljbGVzICkuDQo+ID4NCj4gPj4+IEpvaG4sIGNoYW5nZSB0
byB5b3VyIG5ldyBmcmFtZXdvcmssIEkgZm91bmQgaXQgY2FuJ3Qgc3VwcG9ydCBhbGwNCj4gPj4+
IGZlYXR1cmVzDQo+ID4+IHdoaWNoIGlzIHN1cHBvcnRlZCBpbiA1LjEwIGtlcm5lbC4NCj4gPj4N
Cj4gPj4gWWVzLCBzbyBsZXQgbWUga25vdyBhYm91dCBhbGwgdGhlIHByb2JsZW1zLg0KPiA+IEl0
IHNob3VsZCBoYXZlIHdvcmtlZCBhcyA1LjEwIGtlcm5lbCBhdCBteSBzaWRlLiBUaGFua3MuDQoN
Cg==
