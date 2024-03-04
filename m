Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5588B6117;
	Mon,  4 Mar 2024 02:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709520016; cv=fail; b=PNBtXlRiUGJ2qn+aocyZ+oxMWOiHXbe0q2Jm6KscTedk0ObGdJ+o/9JFKuaUSAlNqQXm0JWiB+2FeZGkhZbY2SDJHsRE0IjW7zgwmTPA/OKDCnNYhQt/Qag80PhL8laVJC1SYArHHuIirDtcM4rR3UGPNaKwOMMYZAcwhNaj6/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709520016; c=relaxed/simple;
	bh=gqiMR/WvnbRRBbL0lpXvov4t26VDCV2DqGSQ8QDWfOs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gq06WBkCIFeZYwaOfhM82hqglVyUEoW/gdPM8H/xrZrNmiSRBSFh1D3OH0yrVFmBja0H7sXRu0fw1Cv0eHRi0kCY1VUb49wkRsGgZThcybUQsVBnEwTbzjCIM8gjcBIvODWzH4QLzSRUnbebwtICCh0JUqmLLc9/1ywOCrZbAXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=oG9j4Oud; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=KFcaTJmy; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="oG9j4Oud";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="KFcaTJmy"
X-UUID: 84983824d9d011eeb8927bc1f75efef4-20240304
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=gqiMR/WvnbRRBbL0lpXvov4t26VDCV2DqGSQ8QDWfOs=;
	b=oG9j4OudTKRV+oPkjR7XQftNS9cs8cEfM9Ln+PEVAaUleYf/S9keQl+zwcSegOoxRhUZfeCsTY2er8YRzFtqWOZI+X/VgqA8kUUozUfehF4P7p3WcrCXCXrC5/iPjZad/N9jfAdYQbcMp6MWiZkaBbrHwuNtnUyMbd0BbdLvAjA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:31c5debc-15fe-430e-aa1e-fd6def7bce27,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6f543d0,CLOUDID:45e91081-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 84983824d9d011eeb8927bc1f75efef4-20240304
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <zack.tsai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1501338462; Mon, 04 Mar 2024 10:40:09 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 4 Mar 2024 10:40:08 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 4 Mar 2024 10:40:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hp06mUcV2E7J+TSrJl9m674DpS1Hg0NlYh2NrMlUxvKoWiK7VT16EdFbdIDbT0t6u7fOPh5suNPlT4V5QNyYhGaib2u/Qi6GS1XOxRC8uNcP83TAyRVmZKzMnPOW7EOL6cAPjj24PFKZTUa+s9wgC+S7OAnOFfsZiMscQF81HA3a9uUStQws4YP/mTsNSLlEdjFVk7kSdRET6XH0wRLLoADFy9uppWgHz2OGXfO1/cFEbs7y7FPn/mqDNi/Ng4AHJvIJwnFttxiWONhK1/UH7OPC2ofDFuOjNXS81KdKw1+8dWhne8tMA3iwTO2oALXcK2dlW99VzArgK/ZD9r0sew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqiMR/WvnbRRBbL0lpXvov4t26VDCV2DqGSQ8QDWfOs=;
 b=FoRp85ngUnb1I/BCszX+tzIJh8qIBKSKYF0UfR9h7c6QGW1Ha4sTT4bPueUtzvLwaj9IitwlZ7/qD/R/YIuxo7JyyB2CDNH6DF29XmG7TURf7Tal3jP5G1iXJH+O7Y092QFTYWQ+mG0/6KShLk8PL82YWckVU44Of9zvWpJIuvqs1jhK/Lk2xRAYfutQrL/l5Rq1F83zwbPSokdiJDwqj+ySAzFL2tXngIEarkXZVq+Nvx/I+3uB7/hfaJfj2beK+k0hsKfohaOn7yGoH9ehluA003WRuaafrydCujVXlFr2TQFfeqRdVfMrMuN7EPEx9NXomYPKRGzc2hEOucz/Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqiMR/WvnbRRBbL0lpXvov4t26VDCV2DqGSQ8QDWfOs=;
 b=KFcaTJmy03CCcjTpauZV/SAOUyUUQnZfi9y2FuYf2qLpoCyxwkLJuW2n4Nc0Qzwxouwi1Ay8Hwk9YnzScXlF3SV7La+LX16NEoXRO7fKcrLA38MK7vWah8aPi3QsfuJs2WoLSPyDbXI8IdVMUkiND1BHrAGyC6NVeHnzDTHzv7E=
Received: from SEZPR03MB6713.apcprd03.prod.outlook.com (2603:1096:101:7d::14)
 by JH0PR03MB8254.apcprd03.prod.outlook.com (2603:1096:990:4b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 02:40:06 +0000
Received: from SEZPR03MB6713.apcprd03.prod.outlook.com
 ([fe80::63af:2367:3676:9aa0]) by SEZPR03MB6713.apcprd03.prod.outlook.com
 ([fe80::63af:2367:3676:9aa0%3]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 02:40:06 +0000
From: =?utf-8?B?WmFjayBUc2FpICjolKHmsoXkv6Ep?= <Zack.Tsai@mediatek.com>
To: "linux-perf-users+owner@vger.kernel.org"
	<linux-perf-users+owner@vger.kernel.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>
CC: "will.deacon@arm.com" <will.deacon@arm.com>,
	=?utf-8?B?TWljaGFlbCBKaWFuZyAo5rGf5bu66LGqKQ==?= <Michael.Jiang@mediatek.com>
Subject: RE: HTML message rejected: The ARM SPE software driver caused a
 failure in converting VA to IPA.
Thread-Topic: HTML message rejected: The ARM SPE software driver caused a
 failure in converting VA to IPA.
Thread-Index: AQHabdzV3yurX5Nc2U+6cmONStFztLEm3k8w
Date: Mon, 4 Mar 2024 02:40:06 +0000
Message-ID: <SEZPR03MB67130EAB70F36912C9BF78EF99232@SEZPR03MB6713.apcprd03.prod.outlook.com>
References: <1709519800-1808-mlmmj-256f7c2d@vger.kernel.org>
In-Reply-To: <1709519800-1808-mlmmj-256f7c2d@vger.kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbXRrMzA4MjRcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy04MTI1YjJiYy1kOWQwLTExZWUtYjc1Yi0yOGRmZWIwZjlhNzNcYW1lLXRlc3RcODEyNWIyYmUtZDlkMC0xMWVlLWI3NWItMjhkZmViMGY5YTczYm9keS50eHQiIHN6PSIzMzU0IiB0PSIxMzM1Mzk5MzYwNDgzOTE5MjkiIGg9IldiNk8xQkpBamRBYWZiK1hoOTJVV1ViTDY0UT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6713:EE_|JH0PR03MB8254:EE_
x-ms-office365-filtering-correlation-id: aa417ed6-92b6-43f3-745d-08dc3bf466d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aZKClUXgUnoDXrzfSOqzmYFwRdwxgVYwrDmQZ3d6hTFh7bO2tM+D5pUDJBgCM+f3lXTZ7s6Bsj+wxKt/bbI9v61syxc0McJk6+UP4zHBl1nRhpUcNVXMWVMa/9O9hdxx5RRGXIEjT9feNMNjHnR03Eu9Kuj/2YT4PVq1GG3xmrUtflHogDUhDEqeUrQmX1cookodsvcsgbydM9s83CxLYwqChnNfdJmhoMP0Wj2s0Q19+Omg6W9ppu5oZyy2BMxezZt+m0lyuS/xHToXSDsevbQUPG0ZjxDI3zxYB+YeE5A6kjAVcOq1EF+MVhNGJi/TQXfGsb/ENcTBtCSSd1fzR1XpRpb81OuUULH3XQCjEAUUmtkzbHJo667uL2bYPFs06e7BD2zbo6dQDE0CaCoMGkNOXvoe5XnVZKFZFydDm1xuQ7P4EXlfmUcuRzvq9VvXsqvmkxjMna2ZkRSj0HuAM91zQXPtaX4MFWIj+E1pe58RHd0eNVw2MVES0W0zywdCsOCza+3APSkqGEfiqt+KuEmXcvE0zYJIvGts5rhj1WXNOBnoVd+waAl75Bcw7yHIk7nwEbXU3nACEYvArZB0BF/K2gjf3IwbMdA/hqzg4dvrZDoYA1SIzUP8IHctCqDFTIb4dFmxhLS2GoXjuxqINkanbFIbp8s7KMhYpK0bIWP5BEBHOOvluhUVsDbMSzQmrtK6JphN3TotSJTLw/Rx2Q6apFuFsqlMMByrRQPnzG0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6713.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHdHOC9ycU56a3FiamlaRFFOcy9GSWtJOVZMcXZ1UFZ5cEVONk50VnlMUVpk?=
 =?utf-8?B?bG1jU1hhTDdyekFSbksvdkZUZ2lWRmVmS3ZGRmEwK2FxZFdFMXd5Yks2RGF1?=
 =?utf-8?B?a1lWdFduYkFyMkgzdm5wTXpLV290VVJtcVI0ejRTSmxqVWdLcDh3Mld5dWRi?=
 =?utf-8?B?SjdINjVlRzQ5MTRDNTQ5UUJXSWZFa2xrRHdVY0dmS0pybHcxbWlTc3JHL3ZS?=
 =?utf-8?B?Q21icldGellEZHhtRXhUMzZPNGl3OVpQbVRWcW83S3MwbVhKQXBiUEFKbWlP?=
 =?utf-8?B?QitncHFSaThPekxMNlVxUlFsQkkvQk4xRDMycTNpUDdpemNjZDJOM01sK1Fk?=
 =?utf-8?B?ZUwySnAyeDE3dllES1VVV0pQOWQ1UGFyclRieHBEaVB3enQ2NDViWVZrVXNl?=
 =?utf-8?B?TVhpYlJsYnlQazhYblRwUFBlRW4rbUx3YVU1SitkbkZzbVg2dHJoVFdqMDBK?=
 =?utf-8?B?NlY4YlM4eE93T2h1SVlzbHJqN2RxZTFmRVN4NjR5d0gxNXdldDVxVkg1UUxU?=
 =?utf-8?B?V095N3hRZXR2V3lVeTI2ckdiR3NXejQrdjVEbWk3YW5QeVRjVElxdmU0NEtQ?=
 =?utf-8?B?N0V4VDFLY1JITHhaZWE4d1ZnNWxpVW5weW9ZTi9ML1ZBWnU3N1c2a1pZU3Zm?=
 =?utf-8?B?ZUVoa1UrZjdwMi9pclNSZHlMc08xaFJ5UVlxdUgyVHhXQXVqTnpmbkJ0WFRW?=
 =?utf-8?B?VzZQL05kUGtlMXBISkZWVU1mSzZyZGVoQWhFUmU5V3hnK0w1Z3NYSGxDWUhw?=
 =?utf-8?B?U3Z6YTgwL0Y3OFdiNlpSUFgzMlQzZ05peU9kcm9HY0NGaksrUzlNUE9aSUVm?=
 =?utf-8?B?WkxxeGtrOE85WFBvT3JsaWJTREs3Qk9vNEw3UW1zZzhvSTdUTUd3QTV2WUdr?=
 =?utf-8?B?ZVB6ZkRZbTZ6UXpGL01mbDh1NHphUUp1b3JMekZoNkx0ZzMyQzBwODRGQWNK?=
 =?utf-8?B?ZFlub28rZFQ1SmJHaHJpK3FvTVRoOXhBb1B4VEFFM1VnZlNyQmtWSG8xdzc5?=
 =?utf-8?B?S1FaYXZ6cysrWUZrWk9DNHUrVjdFblpEWHNzODR0aC9rNFprWlFTcndZU3FP?=
 =?utf-8?B?dWFUUVU5OUpZeUl4ZVpNSzhHMjFaY0U4SXA4b2pKVW8wRW14QzNNQ1dSc2FW?=
 =?utf-8?B?bmNtTlNoeXF1M25KTWh6YXJlVVkzbi9wRittSmNQRDdJUkx4WHVaTFpvMzFY?=
 =?utf-8?B?ODAzSlh4RWQ2cE53SWdjQ25ueHVMVCtqNCsvcGFsbWRNMTRTWnF3Q0pUa0Z3?=
 =?utf-8?B?Q0VGL3l6bnVIYkVmb05VeW92RnBMbTJybVBtbHhqemZSMkx3M3RoUjNXOUZW?=
 =?utf-8?B?dFdiSDhkUWVDVFFwVzRDVUNMazlVbzRya2V1NXQrd2xOOTNscCs0QkZrdGcx?=
 =?utf-8?B?Y3VDUjV2QVdLUThHTWRVdlluRjFKZm5yWFkxeHJiVy9tMGRWYUI0emZYd2xl?=
 =?utf-8?B?NzZMWlhzV2greHVjc2N4bUtGa2VFYTJ2cEVlczVpVkErLzY0aDJSV2ZCSmtT?=
 =?utf-8?B?U2U5YndxYmVuT21KWUNaOUJoZGxGSnJIYlBROUZnZFczN2Z2Q1oyb3VUa0tx?=
 =?utf-8?B?aE5LTXJOMU1nbENNRWExU3ZoWmlGVWllWE00YTIzdmliSE5EcUFBaWNtYS9i?=
 =?utf-8?B?MmNOV24xZXJESjF2OEZBQjZqaFZROVRudm5pUE5BbEdVWnYzMHl5OE9YdnIw?=
 =?utf-8?B?RVpYNk9YSGN1b2JZd25WRnZqclFKSjloeXdvby9HbEZMU3B3S3pHUyt4ckk4?=
 =?utf-8?B?UjlZU1EwajA5aldsR3ZGKzFUTGVFSVIrNGF3Sit5bHNMMVRpMGRURENXUkxB?=
 =?utf-8?B?aU9wbzYzaUR6Z3JUQVlzeUtzeVFFOGd5SUlBWTNOV2d2YVl2TlVJa3NJeW5U?=
 =?utf-8?B?TUZJdHRPK2lHMWVvSUZZekZNWm4zVkNFRXhXZVRISWdIY1RyWE9qQlp4TExn?=
 =?utf-8?B?TzRoWWtpMHFJeHREYUJRV3oreVVjOTluWkUrTnNCNjMwb3hZM1QyY2ZtT0pD?=
 =?utf-8?B?aTcxOWpZUktXZmRzeWZKdVgrQ1ZEVHRlZEFCS2J3R0J5ZzFJNjQ5aGpLem5S?=
 =?utf-8?B?RVF4emJDck1YZTREOGZHRjZuUWV0cWtZVlIva216LzIxS1ZTckhndXcvUFJD?=
 =?utf-8?Q?lxqJ16HMgnptLajsFI7WHvFqW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6713.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa417ed6-92b6-43f3-745d-08dc3bf466d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 02:40:06.2574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vKtwM9gxeeqTVumfAI9Nrf1Y3n9fop2ktMNCPxGVVVRBOH9CFswtrFXLMDUPPPOEaz76cKOrUE6ve+bPS3VmZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8254
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--21.191700-8.000000
X-TMASE-MatchedRID: xIhOSkOSohXUL3YCMmnG4mGYAPMKo6+z2aYdnwn7qHcY0A95tjAn+xCZ
	sXCzrM+MfsdcCPHHPMvtEYWE++G8VtOlZ6Jznao804Rmz/agfdxAq6/y5AEOOrv408/GP5HqyU7
	XgTs6W4IbFIcjfKUHKiItTFGzkWdFbYSeyF0SKjZ1xmrOfPsZljoSfZud5+GgL5n82Fx06bFx8g
	6eH7voKjfXuOc9HGEQpr7q57rz1KFml+pT8u2pu8tfHufnayoGm2cPfRN9orJhiSZwXOHnXZHb9
	21VhO8EwpcJm2NYlPAF6GY0Fb6yCtR7NgM6nlt/qbg9uWhLYLfWSrKtwxqWpVvo8FSqar5SaojV
	1IMErmeZcPi3LGFGQDLaKLaWub4PQv21zJNl0CyDGx/OQ1GV8klXctromFFi+gtHj7OwNO0Q+z8
	69mqTMxZ5+8y352uC
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--21.191700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	83071EEF0F5E8E5DBB28396825967FCFA0791F17BFEF66B97F1DB4A8C0999F0C2000:8

U29ycnksIGNoYW5nZSB0byB0ZXh0IG1haWwNCg0KSGkgd2lsbC5kZWFjb24gJiBwZXJmIG1haW50
YWluZXIgDQoNCkkgYW0gdXNpbmcgcGVyZiBhbmQgS2VybmVsIHZlcnNpb24gNi42LCANCndoaWNo
IGhhdmUgYmVlbiBjcm9zcy1jb21waWxlZCBvbiB0aGUgQW5kcm9pZCBzeXN0ZW0gdG8gcmVjb3Jk
IEFSTSBTUEUuDQpidXQgd2UgYXJlIGV4cGVyaWVuY2luZyBhIHZhLT5pcGEgZmFpbCBvbiBvdXIg
cGxhdGZvcm0uDQpBZnRlciBkZWJ1Z2dpbmcsIEkgZm91bmQgdGhhdCB0aGVyZSBtaWdodCBiZSBh
biBpc3N1ZSB3aXRoIHRoZSBmdW5jdGlvbiwNCmFybV9zcGVfZXZlbnRfdG9fcG1zZXZmcigpLCBJ
biB0aGUgZmlsZSBhcm1fc3BlX3BtdS5jLCBhcm91bmQgbGluZXMgNzY3IHRvIDc5MS4NCndoaWNo
IGlzIHNldHRpbmcgcG1zZXZlcmZfZWwxbC4NCg0KcmVjb3JkIGNvbW1hbmQ6IA0KLi9wZXJmIHJl
Y29yZCAtYSAtZSBhcm1fc3BlXzAvYnJhbmNoX2ZpbHRlcj0xLGxvYWRfZmlsdGVyPTEsc3RvcmVf
ZmlsdGVyPTEsdHNfZW5hYmxlPTEscGN0X2VuYWJsZT0xLHBhX2VuYWJsZT0xLG1pbl9sYXRlbmN5
PTEwLGppdHRlcj0xLw0KQnkgdGhlIHdheSwgdGhpcyBpc3N1ZSBkaWQgbm90IG9jY3VyIGluIHRo
ZSBwcmV2aW91cyBrZXJuZWwgdmVyc2lvbiA2LjEuDQoNCkNvdWxkIHlvdSBwbGVhc2UgYXNzaXN0
IG1lIGluIHJlc29sdmluZyB0aGlzIGlzc3VlPyANCg0KVGhhbmtzLA0KQmVzdCBSZWdhcmRzLA0K
WmFjaw0KDQpGcm9tOiBsaW51eC1wZXJmLXVzZXJzK293bmVyQHZnZXIua2VybmVsLm9yZyA8bGlu
dXgtcGVyZi11c2Vycytvd25lckB2Z2VyLmtlcm5lbC5vcmc+IA0KU2VudDogTW9uZGF5LCBNYXJj
aCA0LCAyMDI0IDEwOjM3IEFNDQpUbzogWmFjayBUc2FpICjolKHmsoXkv6EpIDxaYWNrLlRzYWlA
bWVkaWF0ZWsuY29tPg0KU3ViamVjdDogSFRNTCBtZXNzYWdlIHJlamVjdGVkOiBUaGUgQVJNIFNQ
RSBzb2Z0d2FyZSBkcml2ZXIgY2F1c2VkIGEgZmFpbHVyZSBpbiBjb252ZXJ0aW5nIFZBIHRvIElQ
QS4NCg0KDQpFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbCB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBj
b250ZW50Lg0KDQpHcmVldGluZ3MhDQoNClRoaXMgaXMgdGhlIG1sbW1qIHByb2dyYW0gbWFuYWdp
bmcgdGhlIDxsaW51eC1wZXJmLXVzZXJzQHZnZXIua2VybmVsLm9yZz4NCm1haWxpbmcgbGlzdC4N
Cg0KWW91ciBtZXNzYWdlIHRvIDxsaW51eC1wZXJmLXVzZXJzQHZnZXIua2VybmVsLm9yZz4gd2Fz
IG5vdCBkZWxpdmVyZWQgdG8gdGhlDQpsaXN0IGJlY2F1c2UgaXQgY29udGFpbmVkIGEgSFRNTCBw
YXJ0LiBPbmx5IHRleHQvcGxhaW4gbWVzc2FnZXMgYXJlIGFsbG93ZWQNCm9uIHRoaXMgbGlzdC4N
Cg0KUGxlYXNlIGNvbmZpZ3VyZSB5b3VyIG1haWwgY2xpZW50IHRvIG9ubHkgc2VuZCBwbGFpbiB0
ZXh0IG1haWwuDQoNCkZvciB5b3VyIHJlZmVyZW5jZSwgdGhlIHJlamVjdGVkIG1lc3NhZ2UgZm9s
bG93cyBiZWxvdy4NCg0K
