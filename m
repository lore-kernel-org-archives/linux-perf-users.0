Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F02C4332F
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 Oct 2022 12:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbiJSMkR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 19 Oct 2022 08:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbiJSMjv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 Oct 2022 08:39:51 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn20800.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::800])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702D41D3A40
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Oct 2022 05:20:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFCqNrNmncXhSZvSkNu/t20N6oIMmDLUahJg2HQVXOBYMXjUZfAPK0vepOx8ZMnx4yDsbKGtE8aO3tSLc9wx8cM7S+Ruu4b51TenNxPhuG9CYwWJFdiRE1U2vjZ1VrAbWyQHhqmmRymwH0mXPJUckx20s3zIVMLv2eL84EbmwY1U7MtR/98Sn7Z07atI+dj+NpcJ9xZ6se/nCzhbzq4vDzglq/ZJHc+2dihBaqRNdxIaXuxAYUGb8MbGoxdcr5R0leG1VBowviqBqZ7PvcCC4fRMAeBX/Eer2KNcQ7HyHCBdRCbmCneqkhggmmsxessjRWxhAKsfupujyQ0tmLUi6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SPP+kfM8s5yxLMTH1E5vQX6e5A96bMBsNohGQRtehw=;
 b=XtgcVHXJUvpvH7MgDlG2qXkmlX+qbaB/vbXMBdvN1rLIg/7QAD73PzvgpsVyK+CuhIoHcvpNNpcQIXqnKAk1d4TsjFS+jecZ07slIF0kCOj6wqP5yVTR0jfCgnsVbyWkrLTsQyympMlDCBhkUik0MB7ltvltZ8zskC4xT4dI5nms1oUSlWvc8vk517Hyl8I+Tz6VMTiswNaiHpBUzaNjRpETMFNGYTquPY751hslM12mF7AvE2hX726NrHwZSSYchQA1sIje7uOMiBNf1VX//H0LMSToajWdoSkXSO8yfhx/MQOQKXLWbwVdTxl1NG9ktWi89t53yvACY7jeK9cO9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SPP+kfM8s5yxLMTH1E5vQX6e5A96bMBsNohGQRtehw=;
 b=oKAzv00zVJZE9CXcDDeqFML378djxYyV8pzwvL5hegV41MbP/YiQRpqd9a91roXImc06a3qAKbdUWrr+sChr7xIORKnpnKKIN0cn0v53rgEIFWjGm4Qbt2DPtfczekhEvdENV9laIjYL7r+hEXITz7IGBYEM/VWXNlJpaqL1z73784mzUz9cSqSDnDmMg7xAXaR14I9uGgHQYr+Hlt4XJhfxic2jsduKdqSP5E4LES4r/PwNYLwJOgO3RofORm5b695IDYOFTKehYsh1Yle0HLT8Z2Mj5DDsdsxFIbV06bGVKbX4y5WpDj+9LericogcwLkNN90m/1nX3wzAMWBrBg==
Received: from BY5PR04MB7090.namprd04.prod.outlook.com (2603:10b6:a03:223::22)
 by BN8PR04MB5474.namprd04.prod.outlook.com (2603:10b6:408:5a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Wed, 19 Oct
 2022 12:17:47 +0000
Received: from BY5PR04MB7090.namprd04.prod.outlook.com
 ([fe80::664:9bea:2b81:5576]) by BY5PR04MB7090.namprd04.prod.outlook.com
 ([fe80::664:9bea:2b81:5576%3]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 12:17:47 +0000
From:   =?utf-8?B?5qKBIOeroOeoiw==?= <lzckira@hotmail.com>
To:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: About intel 12th gen
Thread-Topic: About intel 12th gen
Thread-Index: AQHY4s5rr1hW7/jXo0uLNRFgj8Vw5K4VmFO7gAALZMk=
Date:   Wed, 19 Oct 2022 12:17:47 +0000
Message-ID: <BY5PR04MB7090550B685DABE7BA634E05AB2B9@BY5PR04MB7090.namprd04.prod.outlook.com>
References: <BY5PR04MB70901839C7E0FE36134A39A8AB289@BY5PR04MB7090.namprd04.prod.outlook.com>
 <BY5PR04MB709008588108986143E33AA2AB2B9@BY5PR04MB7090.namprd04.prod.outlook.com>
In-Reply-To: <BY5PR04MB709008588108986143E33AA2AB2B9@BY5PR04MB7090.namprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [HWhHVsaUYusViecpyi+JIhOy1pBJafX5]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB7090:EE_|BN8PR04MB5474:EE_
x-ms-office365-filtering-correlation-id: a8217d9d-ace7-455e-a87f-08dab1cbef1d
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VNWYfFF6fprdChg0vNFtbyI12z7s8cq6g/yZ4L8WptbgirHW5b6nAIN9NdFpxTew3UMOMLsYoJ8gdYuGWZtGvCYcN2JBaM1dfHPTUj1kzMBW1sic0kw7/uWMFmCkN6Q6HD2IqvSuANjvoXIfd0E02hSr7CzWc6sd03aFMfmzVpD9ohVdg278f6Sj9YsujJ36EbwmXoL9fmBEpykAg/nUvjNKCfLRBCWNFF5ZgqsIGr7V8kXcDHnK+gg5NHmfwrEv5pHgXNtOItFGezdWgDL7x1YwOGk6/UH/f83DtT47C0TN7ijC8kyF9ErBZqMLk50sV1ht5SuA1YaQhC+78flp4dFxjgDlavMf01nYd1d6MU8xbNINZXxLd04Lj171AiJCxP5hbMj7tp1zZWvoOGfdX1IEWVVSXLz0NqGDvBAYl09mJLppxcx0SXlF8D6MaIGsgXp2DUelnVyuJNwKtaPUv7N9IkId7jx0SonizVzkiyTzOu4DqgmFk3phrMbQSPlDwLeR2BCCGJ9JB4BxIugjFnMc97eEEzsth+ufUxDjYLJ2QBo5IlGQmKUPwqCzUl6Y3hbEEa5rozc9c4/OhMT7TRloUJb55hIrc+adnA0pgF3NS6UnCGBxWMru+dZXrrWkELcTkUxu2JbL4LJPZj3BmQ==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UW5KQ3cwUXNJZDR4TXMrWWNWa1M5Y2xaTFJxNjdOOTg3aFBzbjBPMitCekgv?=
 =?utf-8?B?Wmo3cmlxVXZEbFIwK1h3N1kxUVdiV0NZckdBT1BIaDhWM0JUcWZtSFpFWThk?=
 =?utf-8?B?bWRjalJaZ2ZOd2IxZlJhMFZnTEpUbmk5aEljdG9CTGZ6TXM1d21rOXhZQkZW?=
 =?utf-8?B?R2JSdWI4STVXMkZkcjlsYUt1KzlEV1V5RlZsVjhFL0VTcDNIZ3pSZ2xoTmZK?=
 =?utf-8?B?WU1jOTBJMzNXNGFtV3FPY0ZDeW9Rbm12SU1Ua2VJaURqODBJMENFd0UvZFRv?=
 =?utf-8?B?eVhTZXd5cWJGTFRZcXhvOTU4b0lEdzdPVTdrSzYvcUlJVTJvMG5GTDl2bEdv?=
 =?utf-8?B?K1RUbWZ3RFRkT3d4UzBWTDdGa0h6WHRsdGEzb0RvQnI3NndjNWI1RUExYXlJ?=
 =?utf-8?B?aVFSdGZ2SjA4NTVTU21xdUU0clR0SXBDaVhKSzRjMll6MVpSYjZYeUczbDVB?=
 =?utf-8?B?a3lKdW1hOC9RS21FT0lDaStBV0loK3diOUNYdjViMzF4Yms0dGZOSzdGdDlV?=
 =?utf-8?B?dFFzZytCVlpMQWk5aHdlOHFXb2hTeDU5YmxGQkxZN0F3bDU5d1BYZG5lL2N5?=
 =?utf-8?B?NHNlYmR1TWhYdlZoa1BYMEJHS2lLQXlhNG1lclF1dzJybmlvajYzTzJINndO?=
 =?utf-8?B?a24yMCs0R2U4Q3ZPOGNBSldNeWpnaWs4YUdINDN5dFRKazY4blNoM2R0NGNj?=
 =?utf-8?B?NyswNnZzN0ZBNGVIUGp0M0s1ZXlzZEpEayswbFVnbnh2emtUdTZGME9tVDJL?=
 =?utf-8?B?aWtpajBBTzE5UHNWQ0JZdWlVcW51QWFuZ3NPVFBGNktiOHMrVk9TdGUxbFQ5?=
 =?utf-8?B?d0FkWm1vTjgvanJLMDVqYnZDam45NXI4MThvRm12WDJVWEtBU3dHcFVWNytR?=
 =?utf-8?B?QnBwdGdKZVZUS21PWExzVFczZWNSMW0xSTR6cEdkNTJwVDVUYUJYQWJnclQw?=
 =?utf-8?B?eU5hcjZid2NmcURXMnQ3cHpSTDVDbEsrRWI5UmZ2MVJQZHpla0UwQm9CLzZa?=
 =?utf-8?B?b054Y201R0dMbURrUGQ5MnA1ZjNLZGV6a0grdXlHWjdBdEdDbzAwQkNUNHYy?=
 =?utf-8?B?T0R5L2xDbjJrR1IzMmxqTm1mSGc0dTlsZE0xeE5yU0orai9DTHZmM0l4czBG?=
 =?utf-8?B?UWplTDF3TGJac3IwMUFWem1hTm4zVVJsZVA4NkJhdU0reW8yei9sTkswNnVD?=
 =?utf-8?B?dCtGOEFSYUM3NlJkRWdGdGhjM0hubGtqNnNiZDc4TnBNbmxXTUVHMjhPd1hB?=
 =?utf-8?B?azZBVXNyR3lGam9tL2h5RFh5OWNXSUhCc1pjaUhYSHN2UkxkT2FWSjJUdTRp?=
 =?utf-8?B?L25hOFh0bS9ScklMQzRTTlp3YTEzMUFrMHVqeVpRa0R3emJsU0ljUGNYa00v?=
 =?utf-8?B?RGZQSElMMEpTcG43dHNpVE5XSDZzcUVIdXN4Vk9TNUhGcU5EMk1lejM1cUlz?=
 =?utf-8?B?SkN3a21ydmtKRjdiZmRpTFlqbHI5NzUwTFZMOTJ3bmdPU1NFN3R0YUg5Tis5?=
 =?utf-8?B?TkVhcEg3V0JpUDBiSndkR29nNGJTRkp2MlJOSWZsK0lhd2w1dy9qSEpsTllp?=
 =?utf-8?B?bEhaTlcwSFptdXpXVUEzdko1NS8zVFpMZnh1MlNoVG5kMk55bDhEbHgzdE5i?=
 =?utf-8?B?ajlqSS9vN2dUSStoY1JSbml0OXE5bkpOYUFaajZxQXNOR0FYcmFqUy9kSWl0?=
 =?utf-8?Q?WR2Nul+Mq/f47LJ53ozV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-edb50.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB7090.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: a8217d9d-ace7-455e-a87f-08dab1cbef1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2022 12:17:47.4204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5474
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

VG8gd2hvbSBpdCBtYXkgY29uY2VybiwKCkhlbGxvLCBJIHJlY2VudGx5IHN0YXJ0IHRvIHVzaW5n
IHRoaXMgcHVuLXRvb2xzIG9uIGludGVsIDEydGggZ2VuIHBsYXRmb3JtLiBTZXZlcmFsIGlzc3Vl
cyBoYXBwZW4sIGZpcnN0IHdoZW4gSSB3YXMgdHJ5aW5nIHRvIHVzZSBpdCBvbiBHdWVzdE9TIGNy
ZWF0ZWQgYnkgUWVtdS1rdm0gd2hpY2ggYmluZCBzb21lIHZpcnR1YWwgY29yZXMgb24gcGh5c2lj
YWwgY29yZXMuIEJ1dCBpdCB3b24ndCB3b3JrIHNpbmNlIHRob3NlIHZpcnR1YWwgY29yZXMgYXJl
IGNvbnN0YW50bHkgY2hhbmdpbmcgd2hpY2ggcGh5c2ljYWwgY29yZXMgdGhleSBiaW5kIG9uLiBT
bywgSSB0cmllZCBvbiBIb3N0T1MgdXNpbmcgR3Vlc3RPUydzIHRocmVhZCBwb2Qgd2hpY2ggSSB0
aGluayB3b3JrcyBqdXN0IGZpbmUuIFRoZW4gc2luY2UgdGhlIHdvcmtsb2FkIEkgd2FzIHJ1bm5p
bmcgb24gR3Vlc3RPUyBpcyBhIGNvbXBsZXggd29ya2xvYWQsIEkgdHJ5aW5nIHRvIHVzZSAtSSBv
cHRpb24gdG8gZ2V0IG1vcmUgYWNjdXJhdGUgZGF0YSBhbmQgc2V0IG91dHB1dCB0byBjc3YgZmls
ZS4gQnV0IHRoZXJlIHdhcyB3YXkgdG9vIG11Y2ggZGF0YSB0byBhbmFseXplLCBJIHRoaW5rIHVz
aW5nIHRoYXQgdGwtYmFycGxvdC5weSB0byBnZW5lcmF0ZSBhIGdyYXBoIG1pZ2h0IHVzZWZ1bC4g
QnV0IHNpbmNlIHRoZXJlIHdlcmUgdHdvIHR5cGVzIG9mIGNwdSBhcmNoaXRlY3R1cmVzLCB3aGVu
IEkgYmluZCBib3RoIHR5cGVzIGNwdXMsIGl0IGdpdmVzICJjb3JlIiBhbmQgImF0b20iIHR3byB0
eXBlcyBpbiBDUFVzIGNvbHVtbi4gSXQgY2F1c2VzIGxvdHMgZXJyb3Igc2luY2UgdGhlIHJlZ3Vs
YXIgZXhwcmVzc2lvbiBpcyBub3QgZGVzaWduZWQgZm9yLCBJIGhhZCB0byBtb2RpZnkgdGxkYXRh
LnB5IHRvIG1ha2UgdGwtYmFycGxvdC5weSB3b3Jrcy4gV2hpY2ggY2F1c2UgcHJvYmxlbXMgc2lu
Y2UgaGFsZiBvZiByZXN1bHQgaXMgb24gZWl0aGVyICJjb3JlIiB0eXBlIG9yICJhdG9tIiB0eXBl
IGFuZCB0aGUgb3RoZXIgb25lIHdpbGwgaGF2ZSAxMDAlIEJhZF9TcGVjdWxhdGlvbi4gVGhlIGdy
YXBoIGxvc3QgaGFsZiBvZiBkYXRhLiDCoEkgd2FzIHdvbmRlcmluZyBpcyB0aGVyZSBhbnkgd2F5
IEkgY2FuIGdlbmVyYXRlIHRoYXQgZ3JhcGggd2l0aCBib3RoIHR5cGUgY3B1cz8gQW5kIHdpbGwg
cGF5LXRvb2xzIGJlIG9wdGltaXplZCBmb3IgY3B1cyBoYXZlIHR3byB0eXBlcyBvZiBhcmNoaXRl
Y3R1cmVzIGxpa2UgaW50ZWwgaTkgMTI5MDBrPyBUaGFuayB5b3UhCgpTaW5jZXJlbHksClpoYW5n
Y2hlbmcgTGlhbmc=
