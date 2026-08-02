Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023079.outbound.protection.outlook.com [52.101.127.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B0D390C85;
	Sun,  2 Aug 2026 13:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785677339; cv=fail; b=cA1TrXxSC/LBI4Ecb0H2YIj0+i+CNgBrVOveu1dDC2saMegjMuIGE66yOl6wUJH3UcXk9iBc463hCJWi597XIk90VD/H6DTacdyYA2GJ/bc9/NyfR/8A1QLclAQ1QSBYQ4nQ/DZyre2aM/uuz8zPwMZk699GV4SsAoTXvLR0Hek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785677339; c=relaxed/simple;
	bh=DzXeRWV8LQGWcLbzFXGx8Daxb97U6E+x3zM/+5yJcUk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g2IGq9Mh8zJsEUWD9+PIND8OObclTRd18qT837sWdaPLA8EDx314GzZBd4rnrXHft6h20FoESitUxuo9nY2zw1GKJDDsqyxiu8E3Q2HNy8YSJLvQCO0aT2j7LA36pnXfVseLnCD3E9Qn6gp46JKHStNakGQVUwQOQfxlbt23vx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=Yqw3KWjy; arc=fail smtp.client-ip=52.101.127.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="Yqw3KWjy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JByyKH0PjeX1dx+ch9ZQ7+lh0sTwTOgd+JpD+bK9VmDUPi/out9dqrwS+Qp5d9ooNrVm0jzCJRWLcJnGHY60GmXJLRI2uJZjMEwbo/zzK38W4cj5PFdEFIYjsju45mtYYIyRqfE/lm4xBTZRWP+zAW5JRMx7BYFT2n4EYM7nsLPDp1twfPxT7pX919pA1s0OwuhrUS8uCHIcG7O40Be4WA4LpqnUlDZi3ByfpHUQ4OiHflj99+YsH1AhpDNeSZYNAcmQ8a29FPSDce+58Mcs2zfeQowK58oxxhCiRGW3PDhtK1BlN9i9HrRI8av8NK1FNx1OQiE0mPvdhFrLVxUrYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DzXeRWV8LQGWcLbzFXGx8Daxb97U6E+x3zM/+5yJcUk=;
 b=tphxOg7lwWriTpBs1ataZcIrUAhIXXh5muHxgkpxibtCtpK8Nx8VuCSUz8b4rDb9lEtnU8zfBdhMk/HebnAsxgmTWxwsd048Gfk2osK9mdJvvyZRY+NO0EMv+dRKV0vEu/Mli1THie5ShTPHPeC1/Ln9fXXQlEhXjUIneuww+N5Fv7xLjBSo9iaXz0Rz/JeEk6QWeqDBN2h9k3IcKiRz94b+DWA2UUpNl3vowAJPlu4kUHXadPyT6Yuy6xRDRvK+QaNs2qs0qbrgRcTbgKx3Z2n1uHrupIExBnpxzWq9J/XeRJVJP+gNtskIdyedj/96jPzDbDPbs8MVIBWvOMEMNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DzXeRWV8LQGWcLbzFXGx8Daxb97U6E+x3zM/+5yJcUk=;
 b=Yqw3KWjyvu1o6qMakCvxBQMWy6SYEioO7nRv24D4jccVKNJfbkNBUKclYirGt1Wbo65bnPbbpkPP8M8k15ufKRV95maGU6UM0EqBTGHS/VmYGQRfStnuiOg453d+PclkE85G2I9j96Wib2y/sb9LGhSBg+zrkFG0eTr96u4iFWU=
Received: from SEZPR04MB5651.apcprd04.prod.outlook.com (2603:1096:101:48::7)
 by KU4PR04MB9320.apcprd04.prod.outlook.com (2603:1096:d10:7b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.13; Sun, 2 Aug
 2026 13:28:55 +0000
Received: from SEZPR04MB5651.apcprd04.prod.outlook.com
 ([fe80::b864:dca8:c2ed:e5cc]) by SEZPR04MB5651.apcprd04.prod.outlook.com
 ([fe80::b864:dca8:c2ed:e5cc%2]) with mapi id 15.21.0292.012; Sun, 2 Aug 2026
 13:28:55 +0000
From: Pu Hu <hupu@transsion.com>
To: "peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "acme@kernel.org" <acme@kernel.org>,
	"namhyung@kernel.org" <namhyung@kernel.org>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "alexander.shishkin@linux.intel.com"
	<alexander.shishkin@linux.intel.com>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"irogers@google.com" <irogers@google.com>, "adrian.hunter@intel.com"
	<adrian.hunter@intel.com>, "james.clark@linaro.org" <james.clark@linaro.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jiazi Li
	<jiazi.li@transsion.com>
Subject: Re: [RFC] perf pmu-events: Fix typo in idle-cycles-frontend
 description
Thread-Topic: [RFC] perf pmu-events: Fix typo in idle-cycles-frontend
 description
Thread-Index: AQHdIoJqRUODVN/Z6kS8V68nAzHvPLaKwH4A
Date: Sun, 2 Aug 2026 13:28:55 +0000
Message-ID: <ca99c06e-a291-4c01-9b52-1308c6e33e64@transsion.com>
References: <20260802132536.4635-1-hupu@transsion.com>
In-Reply-To: <20260802132536.4635-1-hupu@transsion.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR04MB5651:EE_|KU4PR04MB9320:EE_
x-ms-office365-filtering-correlation-id: bb529dd3-4f39-4212-686b-08def09a0050
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|22082099003|18002099003|11063799006|3023799007|38070700021|10067099003|56012099006|921020;
x-microsoft-antispam-message-info:
 9kp6lyuqK458+2pGklk8A7itBV6r4fvUr9RAUGMHRZaGuz8W5Y8kDFNumA7qeD8P3AdOX0JXixufjyDRTuepl54loYzBi7gfZf4nU5HfZLTtj6qlyomBfjsOFH9YTwIAF8WjIGWnkwGR62L9jod//L/7hV8Gxp3gO3Tcc6y/SJpl1rTC+pPqN6Z+RHLiiifRAqik8FSsZ0PPnhuF0QnpaMSR1c+k45TytskFzDusOOJ60mUBnd2u/8LZSsPpO/KyttNOi7jNmIb5FdPX3QtrVL91lGJ2XLwzdjQhbzVuQi79Mkb3qI65o9ZYHMclmpxpDoryL34Qt2XU8E3o4Wxh1WdMO3zNZ5QPiwboyrRXL0gRk0UYEjpUk832PHKoqJDl4GyavLscSYVxnGGvmrgDFnFu7POajKQ9fEUYEXPq8f2MDPAd7Im/3j6bB3UG0jbokyCLOzkj1vnwhe99rj3eOcKTblEocrvVp6XmKcxX5ID3oekoy3NXAr3IPnN98KVHpN7zQLdzeM09K8MSemdIAFMOCRoD/AC6fNG6MVyJYsKvjYFqHFLTlBHUPkf/MwVOvocmyZ/UJuP1nfVVk6V4zlJNXf2WzrUZuhvDWa+hTT53VZPJqikzwU4dbQk6ml4QjmE+u5vQtiCxoSqc+RGnav0kgIwv44fBDWT8MLuseBYjbP4FdFOc3E7S51Ewr0SRARLSJ/jFurPuCxcEWrtAHhL7Z2PTJ7FDzpeO3VHkN5bG1w08tAe24P8AgX1x17o1
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR04MB5651.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(22082099003)(18002099003)(11063799006)(3023799007)(38070700021)(10067099003)(56012099006)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aHRmb0tRdE5kdGlRU0tJZlZjdUV2RE5LN2czQWlQVFZiaGh3d1M4ekZTdm96?=
 =?utf-8?B?UUltbGN5dWRwekRhbnhqeU52b1VRU01Ua2ZlWi8vTFc2eEhoU1ZPU0pxaGJB?=
 =?utf-8?B?SkNWTWhRVGdFRUZvRzdkNHNsaGhpakE4YXBRNzRBYTVEYjdseVdXZEJUazB0?=
 =?utf-8?B?WUFIYVdBRkh5ZDRKQklWZmhyWnpBTVcrdnUxR2tkdmd6MTlPZFZORS9sbmtt?=
 =?utf-8?B?bVdqdXp4SE9mUmt0MlU2c2xTWDBjdmtSNjNvbXZpMTdqZkQrS1RsVmQ4aXQz?=
 =?utf-8?B?YlFtNDVtbTZBMlc5OXJSY25MbnhIOTNVNmhid1c3ZFZSZ1QwUExhOXdDa21o?=
 =?utf-8?B?QzZTbHZVaVRIc3A2MzhtazliYjBQeHN0ZGoraFU0T3VabEdUY0hENlNuZ2Zk?=
 =?utf-8?B?T3dsSHpDSm5jU1F3ZkgybU1BR1hURVZZS0wrREpUbWNKcklTVFRJbm90bUFl?=
 =?utf-8?B?aDY1VjBJRTNqeWxSMWJEWWxaQUZ1bi9tREt5c2VoeTZ4K3dIcDVoci81dzlS?=
 =?utf-8?B?UzhONGl1bGlqQzNETWtjbGhPNkhkVmFKdWlxNVJDVFdTTGVKRnhxRGF6T2VK?=
 =?utf-8?B?dVNDano3N1pYTnZtSkNZNmdzekliWGRLSGdyc1NOU0dEYWthM2RBWGVZYm5T?=
 =?utf-8?B?MlBVbGhTNjliYkhRM1FOWFJtUXlpQmYxZ2g2cWp3aDRCSFEwWjU5QUdOQnZU?=
 =?utf-8?B?WEJ6K0NPYUhwcDNRKzZDNVA1c0FZNUtvcnM5UzlocksxVS94aXFNNTlQWkVT?=
 =?utf-8?B?ckNQSDd3b0I2NkE2dUZqbmx0QnNwTlM4bGE1MUFEeHdGaEZQMWVneTNRcnR2?=
 =?utf-8?B?ZFBDMkFTZ3p6U2pjWEw1cDFvck10dWhkS2NyWFh6dnptaHJQL2NGN2JuRVR3?=
 =?utf-8?B?aWdxakpXalo0SXMxTHJ4WUdISVdtamNvTGFveExiSC9aVEsxMEdLREJYL3FD?=
 =?utf-8?B?Ui9ZckJCbXdISjJmQnhXbmFadHhubUhWNG80WXo2MlpmcDd1NjNlQ3FNaDNx?=
 =?utf-8?B?ZGN1Rld5U0NXNzdzNFNudk5CYWxVQWtmTkFzZnhBcWQvcko4eWljUGtaQVNi?=
 =?utf-8?B?VHloVkpPSTdtMjc2S0xRWThvekpZZlNTT3IwRFUwaUorYXpJWHVoWXNPUW0z?=
 =?utf-8?B?OVZ1VnhvNnJhbU8xOXRlNzdPRTNYeVdnMnY4dGpmRmxOcnVtTm5lQ2NDUnNa?=
 =?utf-8?B?SDN4OVJoUElxUTFuRFhxcHFJTHdHSnY5djdtUG1lNWdldkx1N1E1K2s2TE54?=
 =?utf-8?B?c0FDZHN0RGVoNHBHSkNnTFFJcmUvby9IVXBjbjROKzVMdlJYZTIrVVlraHZr?=
 =?utf-8?B?Mk95aWVTY3hITnVyMkJvTVAxR2ZydEJRZWJuWXpwR2FGZ3NUNXJSUE0rSDBV?=
 =?utf-8?B?dlhibjE5eVRCMWJGSWJxWmVZR1pubEp6UDZNRDNvUHVqak1Tei9sS0pEcGZp?=
 =?utf-8?B?QklnbHNrOFpnM0xsL2UzYS9FTmlmRTVXak5lTTNUT3JFb1RKU0w5NWMvTzhZ?=
 =?utf-8?B?VXlyYlVXZTMybmtFb1BJcEI0VGtQcm5DTURmNzBFL3g4Zk1XRGY5WFVHaGFq?=
 =?utf-8?B?NXpyYmFxWDBVSEhuUkFvS0VNMG8yeUZGWWxOd2xvS0Y1S2hydVU3anNjaWFM?=
 =?utf-8?B?aHowOGc5dXlMdEE4aVJtdGY4NlRuYW4zcnVjdXlQVmhCRy9XU01sL25VU2lM?=
 =?utf-8?B?NXBMWkwyeWMxRmF2dUwxRXBLeW52aTQxeWxsUkw0eE1oa1pDUkVNT1JlZEVU?=
 =?utf-8?B?bkxOYXVaVGw0bm5vWGlzdzVtU2xmN3d3Z0ZsVnBCWGRkVzlzdStMdS85TGZZ?=
 =?utf-8?B?NUhJdzUyeXNOdCtNYU1tcGdIZEdzZkJtUFptK1YrdSt6NlI5T3dDalhqU2tF?=
 =?utf-8?B?S2NBRTNpNkxNN3J0OFVlZDVtVDVQeUxIbEh1ZGxDNllGZ1VGYUJPR0ZEREc5?=
 =?utf-8?B?anRDNWNxWGV5TDNmV0prUFVpTVlsN09wbWVwMzRZY1hvc3lKREt3dGg3d3Jn?=
 =?utf-8?B?L0V2cU0wa1VqUm1kK0RFUEdsdW0xVjVIZzh0UGt4bHEvOHJCM2kxTHFNSTZL?=
 =?utf-8?B?bnZFN1ZqZEZNSm1OSWVic2ozQ2M0eWxMbGU4cHFGd3cxSk1GYXF6emJLRUp1?=
 =?utf-8?B?TWRwaURwWGNmRU5ZMUdjQ2V6TFd0RU1qbGprTnNpWk5QMTc5VFAycDdzdkkx?=
 =?utf-8?B?ZEFQMXJTRnVtUWNTUkhZMm93TkYvMldoOUVidlhMYWlLM0cxOGY5SXovRnZO?=
 =?utf-8?B?OFpaWGNCcFdHa1poK1lVV0s0VXNvSFBnYWxsRXpSK1pndmVzdkpVR3NIWVBH?=
 =?utf-8?B?RWwyRFVBa3ZUUlRJZUNJdlBRZS9iK1BUQ1VMaC9rUVEzaCthdUhjZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6EFCB9B7F572F44D8121AAA36D8B66E5@apcprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: transsion.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR04MB5651.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb529dd3-4f39-4212-686b-08def09a0050
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2026 13:28:55.3610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a/T2BqQQuOSAyzKaODBmZ5ITeO7fk6XC1HrvM//OOyhTZtDftWvJApThOBBOt2joCve4FaawBBeA5FbHNp+DHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU4PR04MB9320

T24gOC8yLzIwMjYgOToyNSBQTSwgUHUgSHUgd3JvdGU6DQo+IEZyb206IFB1IEh1IDxodXB1QHRy
YW5zc2lvbi5jb20+DQo+IA0KPiBUaGUgYnJpZWYgZGVzY3JpcHRpb24gb2YgdGhlIGlkbGUtY3lj
bGVzLWZyb250ZW5kIGxlZ2FjeSBoYXJkd2FyZSBldmVudA0KPiByZWZlcnMgdG8gaXRzIGFsaWFz
IGFzICJzdGFsbGVkLWN5Y2xlcy1mcm9udGVkIiwgYnV0IHRoZXJlIGlzIG5vIHN1Y2gNCj4gZXZl
bnQuIFRoZSBjb3JyZWN0IGV2ZW50IG5hbWUgaXMgInN0YWxsZWQtY3ljbGVzLWZyb250ZW5kIi4N
Cj4gDQo+IFRoaXMgdHlwbyBpcyB2aXNpYmxlIGluIHRoZSBvdXRwdXQgb2YgInBlcmYgbGlzdCIs
IGZvciBleGFtcGxlOg0KPiANCj4gICAgaWRsZS1jeWNsZXMtZnJvbnRlbmQNCj4gICAgICAgICBb
U3RhbGxlZCBjeWNsZXMgZHVyaW5nIGlzc3VlIFtUaGlzIGV2ZW50IGlzIGFuIGFsaWFzIG9mDQo+
ICAgICAgICAgIHN0YWxsZWQtY3ljbGVzLWZyb250ZWRdLiBVbml0OiBhcm12OF9wbXV2M10NCj4g
DQo+IEZpeCB0aGUgc3BlbGxpbmcgc28gdGhhdCB0aGUgZGVzY3JpcHRpb24gcG9pbnRzIHRvIHRo
ZSB2YWxpZCBldmVudCBuYW1lLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUHUgSHUgPGh1cHVAdHJh
bnNzaW9uLmNvbT4NCg0KDQpIaSBtYWludGFpbmVycywNCg0KSnVzdCB0byBhZGQgc29tZSBjb250
ZXh0LCBJIHJlcHJvZHVjZWQgdGhpcyBpc3N1ZSBvbiBhbiBhcm02NCBwbGF0Zm9ybS4NCg0KV2l0
aG91dCB0aGlzIHBhdGNoLCAicGVyZiBsaXN0IiByZXBvcnRzOg0KDQogICBpZGxlLWN5Y2xlcy1m
cm9udGVuZA0KICAgICAgICBbU3RhbGxlZCBjeWNsZXMgZHVyaW5nIGlzc3VlIFtUaGlzIGV2ZW50
IGlzIGFuIGFsaWFzIG9mDQogICAgICAgICBzdGFsbGVkLWN5Y2xlcy1mcm9udGVkXS4gVW5pdDog
YXJtdjhfcG11djNdDQoNCkJ1dCB0aGVyZSBpcyBubyAic3RhbGxlZC1jeWNsZXMtZnJvbnRlZCIg
ZXZlbnQuIFRoZSBpbnRlbmRlZCBldmVudCBuYW1lIA0KaXMgInN0YWxsZWQtY3ljbGVzLWZyb250
ZW5kIi4NCg0KQWZ0ZXIgdGhlIGZpeCwgdGhlIGRlc2NyaXB0aW9uIHBvaW50cyB0byB0aGUgY29y
cmVjdCBldmVudCBuYW1lLg0KDQpUaGFua3MsDQpQdSBIdQ0KDQo=
