Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D609C433E6
	for <linux-perf-users@archiver.kernel.org>; Tue, 26 Jan 2021 10:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 329AB21744
	for <linux-perf-users@archiver.kernel.org>; Tue, 26 Jan 2021 10:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391867AbhAZKWt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 26 Jan 2021 05:22:49 -0500
Received: from mail-eopbgr80053.outbound.protection.outlook.com ([40.107.8.53]:32683
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390794AbhAZKUs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 26 Jan 2021 05:20:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ywg+4J2XXJ0vZMm5rlYtG8ZFS8p+LsNYaq1bpuXnwVkH4YD6ZIbXAW5xHBsYvxToB/3hGUs4SqHWZ7b/YvKOz3Hjasu1Bkk1/zRQpEYuAlurGjATH4DwrS82/PNeWffjAHVUIdCwm9XI/nZeiWzrf0M4ShLKErPkDOl7hczMYn/mLjFtznWde3U7jTqZT+B6/UyujpMO0fjrvCWGHV2xhz2eIOERykRpEMUhRBTBAa/rV6K/I3wO5zyiapNlVdQ/p6q5liLruXAUwqVvxCqX9YC6lte5bwPqM4jDeZyZHahvLT//UyI0X2PmkvSFr6eMHZR/eYBb/Mo+CxKMU6Lfzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SYWfDJsKwAWBAdoqMjNselM3kR5T/5G7vsI5lciX/A=;
 b=e3iEqYt0Z2SDWTzAFGhoOCL5LQsTlAGRwiIicWSVohD1Cue5ZevONGNMpP7y0gzfMRvCV+li6KsnrPMASCW28X2d9d4KbspWb2oZn9X9nokkq2vZKtlWhPhlakoKlEQY19qMaehKFgnZBg/AHnoaZFyO8Tyl6mk5MxpWc0tP52DoBSxTJkU8IhF326ZJXaFw05kGYyyypNoOMcu+aZGVv3Z3cydDeDL0UXVU9qnzdmE4lfS4Kd+x4crCLqU6+83m2AUqrrxp2K71K7ZjY08z/KNneHUJJNasViEVvqRvAWkhFTnSMZ9aS5RZSqv5RhsLRMms4iq2JAD9fm89OstCsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SYWfDJsKwAWBAdoqMjNselM3kR5T/5G7vsI5lciX/A=;
 b=jGIyx5kU3fskSom4MOKIM5OGHoQR8/L/D8yg2mAF0wBMBaYFVcQnWaHXfc0yrznwQG8yaxP1Ab1HT7JmhsAqN2DhYRemYuw53DPBY0YS7meQFsRQO9s9W0KuEOF/hodMlZOc8SE60zphy7O4oWZqz3GxH9er455ZMlvYZ12GpBg=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB6PR0402MB2726.eurprd04.prod.outlook.com (2603:10a6:4:94::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Tue, 26 Jan
 2021 10:19:58 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::9d2b:182e:ba3b:5920]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::9d2b:182e:ba3b:5920%4]) with mapi id 15.20.3784.019; Tue, 26 Jan 2021
 10:19:58 +0000
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
Subject: RE: [PATCH V2 4/4] perf vendor events: Add JSON metrics for imx8mp
 DDR Perf
Thread-Topic: [PATCH V2 4/4] perf vendor events: Add JSON metrics for imx8mp
 DDR Perf
Thread-Index: AQHW8viCFYT3K4FDlkyDPQovOsJGIqo4WqwAgAFVqeA=
Date:   Tue, 26 Jan 2021 10:19:58 +0000
Message-ID: <DB8PR04MB679545815769E27D3A17CE6DE6BC0@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <20210125085927.27322-1-qiangqing.zhang@nxp.com>
 <20210125085927.27322-5-qiangqing.zhang@nxp.com>
 <d3035793-d348-7343-a7a5-38b1d0d93852@huawei.com>
In-Reply-To: <d3035793-d348-7343-a7a5-38b1d0d93852@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fd95fa8b-8ba2-4ea0-f60f-08d8c1e3ef16
x-ms-traffictypediagnostic: DB6PR0402MB2726:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0402MB2726D2E458FD4B5BC121CED3E6BC0@DB6PR0402MB2726.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /BNuGeBaclhoEBIuGbz7GPfi4ZqnzdcA7jpTGKk30TXPPbupMjNnCNxVD60lnoOUR+qBLKCCVAKHLkdZYrNzwu3y0AhfwmPRkjpMWLMaA/B0o2U1MewCsNhtsXYTHh8EZgmpnM7nfDhzJu0ETyia7dHuy2aNNw4b39ia8qWOf+3DB3lYuB/v22PR4JlqX5m4+1cRlFBLQOta+Vmm1QinBYzd74SYeJoMI8virlzmM8ukqxseyu2R9hjs+hmTmuW4nZsAZWICxFTXa250WS0XQo59pTTeVD12+VCtEHk6JqLQSKEhxMQglCrMO9FIXrPbQnL34LaYWKgryt7eK3QBpuBZ93ypFrHD8eeGGBzQQuCPQwu5IATs/omdjrlgzyDOunXR9us523VMtHzxNXgo4j1XlcEQvEOQgbs1PyHXqqhNgoz+akbQxGcfTvyOsyQI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(71200400001)(86362001)(33656002)(7696005)(54906003)(4326008)(64756008)(186003)(110136005)(478600001)(55016002)(52536014)(83380400001)(8936002)(5660300002)(66556008)(66446008)(66476007)(66946007)(9686003)(2906002)(53546011)(6506007)(26005)(8676002)(316002)(76116006)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ck5RT29uM1J3dkVtU3ViOFd4Sy9YU25PRkpUZHVtakREQnVSLzgzSTZab3FX?=
 =?utf-8?B?ZnZJdWdWbTVNZFRUZC91aEdlZW5UUWxOSmdoTEEyUFZkM2hzUXlvSVdGOHVC?=
 =?utf-8?B?cmNPOGN4MGVNTnNSeWZveUdRa1JNQjhoVm1zVGlpY2RQNlh2dGZDbzhRU3li?=
 =?utf-8?B?ekZSenV1cUx5Z3RRZ2crUEdDMjNJa3RTbzFnaisxZkhqeUZDUFl1NGE4VXdG?=
 =?utf-8?B?aXhkVmpkUit1dGZMMkZvSUNoTWRVODl4TTk5dkZKemM3WGNkc1FFQi8wTFJ1?=
 =?utf-8?B?YnVNdXp2b245eWhsYnUzektaTDZvT1Nld093d2lReDFjaG96ZzdZS3pZcFFp?=
 =?utf-8?B?TkFkenlqRDE5SDlmVzhXalNFQ3NLckgvZUpiMzY2OUpBR3ZiV3MySGlTbTU0?=
 =?utf-8?B?d0ZRaUJNNi9CMC8xaVpldG1lbTBzeTNrUFdGalFoZ0swUE9UdkZzUEVnYW0r?=
 =?utf-8?B?WEczU3JLTWYveTVJUGljWlRxaUlXdzZOSDlENFVoSFAydTNnUnBuN2FhaDRO?=
 =?utf-8?B?WEUvY0tRdVNpM1hGcjhURmNXYzEwQWJVeUZkOUZJeGJMNDJ1elkxWm9LeWNy?=
 =?utf-8?B?cVdMV1VnbCswci9SRC9CMzJSK3hibGtOdWJ3SUVGU3cvbjhNQ05pZm12VzBw?=
 =?utf-8?B?YUVwQWwrcGZDKzQ5em9pY1dzR3hDNU91WHFIZG8yN082MmlIdnIySlFXc2xa?=
 =?utf-8?B?cnpVV1cyS2VlSDI0NThpdnJGbTRZL25yWnVXR3dhMmNMUTdBNjU1WkVjL3BP?=
 =?utf-8?B?MTFpMUxJY0p3bjdkRkluZER3UXByWXE5SGlEVnFnWGw5cXJHK3pMS1lubXM5?=
 =?utf-8?B?dGt4Z09VNHorQVVzNldaSmtwU1l3TDJvZmtVeUlNelJiMDhvNm9WSnZJdkhq?=
 =?utf-8?B?TGFIVlJscHZSc1lhNktETzZuZGFpMGU5Zm1xYW92bktwckFoWVVmakpwR1h0?=
 =?utf-8?B?MzlhbDlUbUpGckRqQWxvSzJSRmc2RkdLTjUrSUpydVFUaWxZdFpHR3J1Y1Iv?=
 =?utf-8?B?TjM3Z0RXSExpTjlWQ00vY096b2JLczYyN211aldZek5nVmVsVFZoQzM5QWk5?=
 =?utf-8?B?UGdrUW95QkF2WWdGWU5HNDNhZ05SMmxvMWhxdk1tUW9rOTlMRXlqMjB5SHpi?=
 =?utf-8?B?cGRHYXlrU3o2dWFxcGFLZkR0T2Njb0pXU1VaQUYweFZtS2dBU25wMEFIelFq?=
 =?utf-8?B?THBjU3hpTFFXckNpekd5UG1KNWlxdnk3TmFNZEE0RDRpNVFDR1p1enJ4UkVh?=
 =?utf-8?B?VFp6THVJZE9vMkxuWVJKbE93Y0lzWEhEeEhFRldHeTdnL2J2ZGxJTWRCTFVU?=
 =?utf-8?B?eDQ3NWx4aDVjdFlkVEFSOE9CQUpveENTQmVNcEpTMjAyVFZ2SjR6T3dtVEFW?=
 =?utf-8?B?dXpKSmRvOTc5K0JRRFpuaDZtMFNsT1FuS1Z3Qml6L3lIbjlyd0lNWk1pdE0z?=
 =?utf-8?Q?dLsa/1xu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd95fa8b-8ba2-4ea0-f60f-08d8c1e3ef16
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 10:19:58.4955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g/xXQBmDsoI5bC1KJF6Kin4IDy2hkXtMIUCiuY9JLazqY3zzV2+3XFCatgYkecCKbceTnrXcMYsWwakbLJOyUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2726
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

DQpIaSBKb2huLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpvaG4g
R2FycnkgPGpvaG4uZ2FycnlAaHVhd2VpLmNvbT4NCj4gU2VudDogMjAyMeW5tDHmnIgyNeaXpSAy
MTo0NQ0KPiBUbzogSm9ha2ltIFpoYW5nIDxxaWFuZ3FpbmcuemhhbmdAbnhwLmNvbT47IGFjbWVA
a2VybmVsLm9yZzsNCj4gam9sc2FAcmVkaGF0LmNvbQ0KPiBDYzogd2lsbEBrZXJuZWwub3JnOyBs
aW51eC1wZXJmLXVzZXJzQHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14DQo+IDxsaW51eC1p
bXhAbnhwLmNvbT47IG1hcmsucnV0bGFuZEBhcm0uY29tOw0KPiBsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWMiA0LzRdIHBlcmYgdmVu
ZG9yIGV2ZW50czogQWRkIEpTT04gbWV0cmljcyBmb3IgaW14OG1wDQo+IEREUiBQZXJmDQo+IA0K
PiBPbiAyNS8wMS8yMDIxIDA4OjU5LCBKb2FraW0gWmhhbmcgd3JvdGU6DQo+ID4gKyAgIH0sDQo+
ID4gKyAgIHsNCj4gPiArCSAgICJCcmllZkRlc2NyaXB0aW9uIjogImJ5dGVzIG9mIGRpc3BsYXkg
aXNwMSByZWFkIGZyb20gZGRyIiwNCj4gDQo+IGlzIGl0IHByb3BlciB0byBoYXZlICJieXRlcyIs
IHdoaWxlIHNjYWxlIHVuaXQgaGFzIEtCPw0KDQoiS0IiIHdvdWxkIHNob3duIGluIG1ldHJpYyBy
ZXN1bHQsIEkgdGhpbmsgdXNlcnMgc2hvdWxkIHVuZGVyc3RhbmQgaXQgd2VsbC4NCg0KDQo+ID4g
KwkgICAiTWV0cmljTmFtZSI6ICJpbXg4bXBfZGRyX3JlYWQuaXNwMSIsDQo+ID4gKwkgICAiTWV0
cmljRXhwciI6DQo+ID4gKyJpbXg4X2RkcjBAYXhpZFxcLXJlYWRcXCxheGlfbWFza1xcPTB4MDAw
MFxcLGF4aV9pZFxcPTB4MDA2ZEAiLA0KPiANCj4gZWgsIGRvZXMgdGhpcyByZWFsbHkgZXZlbiBx
dWFsaWZ5IGFzIGEgIm1ldHJpYyI/IFNlZW1zIG9ubHkgYSBzaW5nbGUgZXZlbnQuLi4NCg0KWWVz
LCBhY3R1YWxseSBpdCBuZWVkcyBhIHNpbmdsZSBtZXRyaWMuIEkgY29uc3VsdCB0byBXaWxsIGJl
Zm9yZSwgdGhlcmUgaXMgbm8gd2F5IHRvIHByb2dyYW0gaXQgaW4gdGhlIGtlcm5lbC4gSSBhbHNv
IGRvbid0IHdhbnQgdXNlcnMgdG8gZW50ZXIgYSBsb25nDQpjb21tYW5kIGxpbmUsIHdoYXQgd29y
c3QgaXMgdGhhdCB1c2VycyBuZWVkIGZpbmQgb3V0IHRoZSBBWEkgSUQgZm9yIGVhY2ggbWFzdGVy
LiBJZiB3ZSBwdXQgaXQgaW4gdGhlIG1ldHJpYywgaXQgaXMgbW9yZSBmcmllbmRseS4gSXMgaXQg
cmVhc29uYWJsZSB0aGF0DQphIHNpbmdsZSBtZXRyaWMgY291bGQgYmUgcmVnYXJkZWQgYXMgYSBz
cGVjaWFsIG1ldHJpYz8gU3VjaCBhcyAiKCBpbXg4X2RkcjBAYXhpZFxcLXJlYWRcXCxheGlfbWFz
a1xcPTB4MDAwMFxcLGF4aV9pZFxcPTB4MDA2ZEAgKSAqIDEgKiAxIi4NCg0KDQo+ID4gKwkgICAi
U2NhbGVVbml0IjogIjkuNzY1NjI1ZS00S0IiLA0KPiA+ICsJICAgIlVuaXQiOiAiaW14OF9kZHIi
LA0KPiA+ICsJICAgIkNvbXBhdCI6ICJpLk1YOE1QIg0KPiA+ICsgICB9LA0KPiA+ICsgICB7DQo+
ID4gKwkgICAiQnJpZWZEZXNjcmlwdGlvbiI6ICJieXRlcyBvZiBkaXNwbGF5IGlzcDEgd3JpdGUg
dG8gZGRyIiwNCj4gPiArCSAgICJNZXRyaWNOYW1lIjogImlteDhtcF9kZHJfd3JpdGUuaXNwMSIs
DQo+ID4gKwkgICAiTWV0cmljRXhwciI6DQo+ICJpbXg4X2RkcjBAYXhpZFxcLXdyaXRlXFwsYXhp
X21hc2tcXD0weDAwMDBcXCxheGlfaWRcXD0weDAwNmRAIiwNCj4gPiArCSAgICJNZXRyaWNHcm91
cCI6ICJpbXg4X2Rkcl9ERFJfTU9OIiwNCj4gPiArCSAgICJVbml0IjogImlteDhfZGRyIiwNCj4g
DQo+IHdoeSBubyBzY2FsZSB1bml0IGhlcmU/DQoNCkkgd2lsbCBhZGQgaXQuIFRoYW5rcy4NCg0K
DQo+ID4gKwkgICAiQ29tcGF0IjogImkuTVg4TVAiDQo+IA0KPiBidHcsIG5vdCBzdXJlIGlmIEFy
bmFsZG8gaXMgb2sgd2l0aCB5b3Ugbm90IGNjJ2luZyBvdGhlciBndXlzIG1lbnRpb25lZCBpbg0K
PiAicGVyZm9ybWFuY2UgZXZlbnRzIHN1YnN5c3RlbSIgb3IgInBlcmZvcm1hbmNlIGV2ZW50cyB0
b29saW5nIGFybTY0Ii4uDQoNCk9LLCBJIHdpbGwgY2MgdGhlbSBuZXh0IHZlcnNpb24uIFRoYW5r
cyBmb3IgeW91ciBraW5kbHkgcmV2aWV3Lg0KDQoNCkJlc3QgUmVnYXJkcywNCkpvYWtpbSBaaGFu
Zw0KPiBUaGFua3MsDQo+IGpvaG4NCg==
