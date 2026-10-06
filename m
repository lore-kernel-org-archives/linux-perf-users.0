Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011031.outbound.protection.outlook.com [40.107.74.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0F53ABDA8;
	Tue,  6 Oct 2026 09:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791280164; cv=fail; b=I8eNR6UV4wqBwb/gDt5CHLwrEVg8tKAh9omIAwd73mV7OEujaL7KzC8WriWxC2jZYy+oRnegBUuImNk7Cn1gmCbHOF2MsOXlTrE7F/co/W9CR5zp4EjfpLTfoXFKqOiZo9zt8kh3wBfuZS9av4wL5NuIJ+DXz4/z4r4KDwC2rtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791280164; c=relaxed/simple;
	bh=zrtPoorkCY+phgQpcsRCF19rffQCjMIrhzHNtEuZf/I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q7H4c8jO+BRu7lJDllFxaHutis51eyALtKenq9s1Wg3RO2dkWm9Um64HPbawXBJLqI6jxghDZNYvCXukuk3dRIt08s3tXo0izwPSkXGVEPgKEsy6GB4dXrrrKbJi2KVnRQYng1KlcCjKX+n+1Dal2MwLtjgG+udmPD1o5CcWOGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=FVsFSfyj; arc=fail smtp.client-ip=40.107.74.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="FVsFSfyj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=POzsiXn+niJNvGAC+yRIJ1OhvPEP4AJYQHk28Az7uTJkZ9tWC/LlzIfhqaOG7gGsMluI0s6GMVLJimdDc/x9iJWu0553FXbVPe2pjPTXjrfwqxmYvEXuQFwfHReqT5iLu1KFX9/LMEOgixHKnMOk4YH5E6NTvgYLLCq4V89yIIq0CGbgosBCcILIx+9DatTm1IyDXJ//J9J6SwYsYfZ3LdnvfVOBKkF5JPTBQFmir/9O5JrKjlkAR+0CCGcQ5XBaHrotda2xgEIAzSPzStrLmlmWZLSg03RaO1ecFDItenCCjrn6Npt8Cp/9Ws/lBxIBmzgP4w79DkJT2Ocm1k+ihg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvd0LMwnw+V/bTgbhunX8Rc7voLlfcSL/ZfYU1aSD2g=;
 b=B96r54v+Y1hscoO4TJ/iDkmF80FGK7iDIUKETlOK2EMkHWmVSFcv2/EYxDPny3l2U37enbvEe6E36/pZp4PGVJgbMwKrspVt4LvHbePXHreU/O+pxPOg3yzXLOsF4FS9UyKaVJuQtWfshDQFOc3/J8/qUi0qA9TasodDUflOblBIIXQL6HHokrP1wAwxW19EsnxEyeusQJnOadaY8L0zkTWkH25YyyopmeAZQwQNos7cvIX8qSEk9E2MChMlRoFeSYiEdfQ5Zs5WFcGD3fWSuupgQqt1e1RRcz0SNyS2POxvujCPdCSFNoRknqfq4mpp87kMYo8MihAneatZNeJzRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvd0LMwnw+V/bTgbhunX8Rc7voLlfcSL/ZfYU1aSD2g=;
 b=FVsFSfyjaKumCoqJ7otnysxOapZ2H8GqhK7yzeqCV3Hjy6P/tZbIMGyF2ZT327TfEYZKGVhv7YQmu0GwCr1r2ny/mLCOdDfnbUk+SFvIqR977oyopjjr6cq44OLomhjKe1zIv3OOI3mImEzbbjZfSSaDByJdME5ppuGWf9rbKCVsDVcCZ7aM8ABnUuwj6cM7EH65XAE8Eok/r2KmXP+k5JBvxjW3WsI4uAIoKcbWYUkQgSXimitlMXK5WSwEifDEekv2MsT4posRaCHuiSZc6tWbRfCXLSMS5YpSuiVSQV7GddmEOcRd8X4cbWfQna3nmBqP/vRwPwg6NNsSgan4jw==
Received: from TY7PR01MB15746.jpnprd01.prod.outlook.com (2603:1096:405:290::6)
 by TYCPR01MB8455.jpnprd01.prod.outlook.com (2603:1096:400:15d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 09:49:20 +0000
Received: from TY7PR01MB15746.jpnprd01.prod.outlook.com
 ([fe80::bc79:d427:b0a9:a793]) by TY7PR01MB15746.jpnprd01.prod.outlook.com
 ([fe80::bc79:d427:b0a9:a793%5]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 09:49:20 +0000
From: "Tomohiro Misono (Fujitsu)" <misono.tomohiro@fujitsu.com>
To: 'Will Deacon' <will@kernel.org>
CC: Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland
	<mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Marc
 Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Radu Rendec
	<radu@rendec.net>, "Kohei Enju (Fujitsu)" <enju.kohei@fujitsu.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>
Subject: RE: [PATCH 2/4] arm64: tlb: Add tlbi workaround for FUJITSU-MONAKA
 Erratum E#030001
Thread-Topic: [PATCH 2/4] arm64: tlb: Add tlbi workaround for FUJITSU-MONAKA
 Erratum E#030001
Thread-Index: AQHdUli6CS8L1/ubT06LulaRj+FfqbbqMogAgAYXhKA=
Date: Tue, 6 Oct 2026 09:48:50 +0000
Deferred-Delivery: Tue, 6 Oct 2026 09:48:50 +0000
Message-ID:
 <TY7PR01MB15746A2EBB844A9E4E83CE849E5952@TY7PR01MB15746.jpnprd01.prod.outlook.com>
References: <20261002-monaka-fix-for-upstream-v1-0-4aec0b0cbe34@fujitsu.com>
 <20261002-monaka-fix-for-upstream-v1-2-4aec0b0cbe34@fujitsu.com>
 <ar-m7DUSMhe0euXC@willie-the-truck>
In-Reply-To: <ar-m7DUSMhe0euXC@willie-the-truck>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=44936c83-f8de-497d-b8f2-5abf81ecd2b8;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2026-10-06T09:45:07Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB15746:EE_|TYCPR01MB8455:EE_
x-ms-office365-filtering-correlation-id: 30de4444-ccec-4afd-5a9d-08df238f1850
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|38070700021|11063799006|56012099006|4143699003|22082099003|10067099003|18002099003|3023799007|1580799027;
x-microsoft-antispam-message-info:
 J0GKuNyNlbGk+xSgMn1c9U2i6nLtOfFbsPBDdQvGpJyQOuo0Vfals0fJNdtSo5wWyOkvoe4HWrNjfe1asz3GkVE6olm2n5c6taleEEUq6dlmAwW6ozSyAlCNrJwVkO052Y+jAiA9nr+wUTA7NU59Osk10hDgHylr7CBCzDFa6/iG9RRZoj+jsJh/VrowGZ3cOj4/z4YDVSqShIhoqXb5AoYOzqnZfCNjb2dhD1GD3OyObjmnrq9YU3bL0sFMkvCtXLxbXWcyZ+agPDUcpdxHZDGH7/K45bCODWm04pGLoxYeDXbUKbWOssxLzfE8Ap+ryTsJ3jVhq3wY78yNOYDhHpWfX/2Oy7lSo50eqtZ8od0CcJnGIOguS4KYOi+cMyGIBcgHZFW42My8GN3t6CNxnFscYR1n27Pzj75ioEyyhl7Dp+4c+5e1Nak3VUgYaPTxKc360n8cGTv8hGeIjJ9iK/CNJIP/Pbw+Pe73y5Y21+dbtvYggq9e5kfkoPFMolV12UoaemQNfRYtbA0UPuFPhkE49diHmZaVhi1+VkIeWmgVoBTMxyRqfblivMKS0qqKwPWymkEN58kUvq1/H1P504KRSp1qirSo77siY/4JbxLXuzaFwh22LQCYCVMPdWalZDj6bB2rPJwZDhlUlchhe5byHEFz0JxChX2bEXaU33Hs34GlmFUUI5urizysIWD2Q3eqIopnyAFai2z1l4Qw/5S8LvEuMctLPRxTCEhmnJ3AHy+rp6QOJNqsW0tgQ9XJ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB15746.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(38070700021)(11063799006)(56012099006)(4143699003)(22082099003)(10067099003)(18002099003)(3023799007)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?RE1uQjBQNWdVUWJQekdueDhBZlZQLzlZYTdqUmx0N1pmZEZZcUYyanA3?=
 =?iso-2022-jp?B?OVdXUEVwdXRmOHVOcDVBR09PUWEzcE85dWRnWUZoOVhqZ20vWFhrYW9O?=
 =?iso-2022-jp?B?V0RrYSsvRjFYaGtpNVVpTDRKYXBTM2pVWlk4V1U1ZWtFODdudEh2Y0NE?=
 =?iso-2022-jp?B?dHZZUk42SE53b1EyVnNhSElRQXVOMlhKcDFycW4zbzQ0VnA2Q2VsOXdh?=
 =?iso-2022-jp?B?b1dLN0dmbnhyT1M0UVpRalB2VEh2ZHFNRUhRSHNZVG1UcVRvWmpCRTlX?=
 =?iso-2022-jp?B?SGVYVjJpMzRNRkllbGVuSlBKVXQzNyswU2doNytINXFvQWxjbGU5Z3h1?=
 =?iso-2022-jp?B?NmY5TUEvc0ZUQXdlZ1N1RGR4V3dSQ1VIWUN5R2xqRXM5eHEycEhpNDZD?=
 =?iso-2022-jp?B?Nkh2YmVvbVRQc0t2T1gzdU5TWmlaQkFqMW5QVm1BNmU4VnhIaWNtWit3?=
 =?iso-2022-jp?B?VUM5dWM3ck9nbXJXOXdRTFd2ZkR6YTh2c201WnZqWklBVmtjV0p0K0g0?=
 =?iso-2022-jp?B?UVFBenEyMXJTZlBSUUx4R2JDNjNaVGlIbERoVWdwUEI1czJBaVV6aGVT?=
 =?iso-2022-jp?B?eG5BNzVzaTFNRlJQN2V3RUdtNHpkUjJHQU93bDFqMVFpYStMbzl1SUI2?=
 =?iso-2022-jp?B?ZHE5bWJXRldlWjlJclk4YzNSZ1MzVjd2dm5tOXF2MnRyZWk0TEVtWnJm?=
 =?iso-2022-jp?B?YVh4QUVoWEg4bmRHS3lYV3FCVnV0bjZ3WTMvTVJIL0w4bDlMMlJaWjhh?=
 =?iso-2022-jp?B?bll6NUgxdnJobmZKeW9jWUVtejRuemhiS2RkelB4MWRreE9UTUllN1Vo?=
 =?iso-2022-jp?B?VGRxRUxLT3N0NTNpN1NVL29iQldiMzBvSXBzYUlLcWRPVmNZNXErc3o1?=
 =?iso-2022-jp?B?RFVrWSs2NWhONytFWTRCMENBaE0xWnJ0RnRLamhhV2VGY1NXYkF5OUw5?=
 =?iso-2022-jp?B?TzlFR0Y5ZE1nL01ZL3JSYk9scG15NE5aQUVWY3RXOWQzZCtUY1ZFRjU3?=
 =?iso-2022-jp?B?aEE5Q2NvRExRM0xpSSt4RkcvaFhaSnVBd3RGcCtaQ0ZJSUROZm4vM2Zk?=
 =?iso-2022-jp?B?aUs0ZXVkejNpbnlKV09JTlpldFpXZ0Y0WU50bXo5eTI0UEEzSmJWcGxH?=
 =?iso-2022-jp?B?cElLV2NKWDVHVmgwb1hBZ3FMcWhVZWVDVEFSdmt5eWVFUDNSMk83RXdO?=
 =?iso-2022-jp?B?ODNWcGdIMktjbUVwRktPVE5wMTVJQkZ3WGFoR2R2WGptR2M5MW8rbWlp?=
 =?iso-2022-jp?B?L2cwSWFoei9qbjhyT0pMcmwxUmNvSjBjb1F6US9QbDFWYXMrd0VPVm1o?=
 =?iso-2022-jp?B?UlVUWEhQckJTLzVKRWZTVDhabmtRZ1pNclV6UlF5aGNyVHAycWZzNWdF?=
 =?iso-2022-jp?B?UmpHY0lydUV1bXNURVJ0L285U0Z4TFc2QXdaeTFsTDZ5bkZ0MFpxRXlW?=
 =?iso-2022-jp?B?dCsrN1RYdlBHTmo1d1c4ekNnWEhRcWFhOXQ1OTFWcUY1aEZjYkMwdTBo?=
 =?iso-2022-jp?B?S0VCYUVMT0NOZVpqR1J5NHZFZWZUYzF0b0x4eGUwRTVYRUkxUVNnd240?=
 =?iso-2022-jp?B?K2pTNHNJR3BhTThpTm5tNlVxQXFic3NCV2x3NXAwaXBNM2dCSk1nTTlQ?=
 =?iso-2022-jp?B?SDA2cHJSbzg5emtEZkNwVWZxN3UrR0FTKzVMcFI1T24wRGkyVWh0RVhC?=
 =?iso-2022-jp?B?OHFCekE4TTBObUFoTms0MkxtWFJ3M2JkNUhsMEFsRzIvRU13TWtQbmtq?=
 =?iso-2022-jp?B?QnVySEp2bURIYUx6UjhpZGRabGdDK0M1bkFjZ3hwL0Z0dkM3b2hDcTZm?=
 =?iso-2022-jp?B?blRZVVZJRkJxQktFckx0dy9OZDEwdnNwWnRaS2c5QVFiNDRzbEV1VXhY?=
 =?iso-2022-jp?B?cW9YWG9oeVI2Z2JUVXVEdm8vMG1mT1ZvYTFpRkhYcnVlNEFDb3FIUmw1?=
 =?iso-2022-jp?B?cUlKWmkxU2RYR3I4YTdJcEJaeHZ1b0x1MTRqY2JLVHp4YTBGZjJCaUY4?=
 =?iso-2022-jp?B?bmFPd3A5cVgxcEZTV09KMEhGTlN2aURkTUZwbEo0dG9GNlg2VXpYQkR6?=
 =?iso-2022-jp?B?NjdnekVuVmxrRkxxU3NOQU1sOTZ6QStRTzJNNk8xWG4yQ0s3T1BSNWow?=
 =?iso-2022-jp?B?MHNrY0lXYXRNT1RoWG9sU2lLd0xub1VOZm9XV1UzM01PbGFjaHFVSmtm?=
 =?iso-2022-jp?B?eVlPb2o3bUdKV3hiNjh4eDljMDZRNktPLzdNSnFoOG9lNXVvMkFSc1ZW?=
 =?iso-2022-jp?B?TmVMWjF5ODZvNm8zdXdxUTQ4Sk5jbnhCZmVFR1NDK2ptakJLejdLOTh3?=
 =?iso-2022-jp?B?TFJFdEsyaEt1cFdlcnlGcWJMUnFWa3JDWi9BVE1KRVZ0MXFTZ3FlRzlB?=
 =?iso-2022-jp?B?bjBMMGZjaVJLWTdoVlNSUzFocFdJTHFxbzJWbmVrWHpTKy9uM3UxWXVG?=
 =?iso-2022-jp?B?MU5RTTV1eFl3TlMzVS9pTGY1ZUFjczYwNW5CN1poc0JTTndwdkY4b3ZC?=
 =?iso-2022-jp?B?WmErSTBXN0ljVzhEaGxPUWs0RHhUd0V6b1dFS0ZkRXdRNzE1QmFDNmEz?=
 =?iso-2022-jp?B?UFpjNWl5ND0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	G6ZxeSJuZ9a9ScS5+MfBTqepQ9sH6P87eZrMN2bFtmf5w/Bh2O9U8lc2oU7vp3Gg6w1XYxLvW4aaoJE+Ws9LVAGZMlq9lQgjFxqlQ0Kfc8J4sCl6fIasFaY+IrawSpyztEpfno2bIWdvF4I+va87NIckpweJbL5VPpFvJnPwTV5XABpUS2tpRUB+zWPc/vxR3iXO/lbjDjJ2sSzyrtHXbKoXlp9nvrqTFiLIuhzAZpeOVXvd75LfKTEHAEy2wiZno5vS6AwnAn4dYdmsNjTWnus8c8ZfxHc4jL+k7k1uLjAFq+PTr3mJwwF+h6axOEg4bYgogFJ83+TDS3MFl6Clug==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB15746.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30de4444-ccec-4afd-5a9d-08df238f1850
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 09:49:20.4843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P6MJXoOteBhkfXbWYVrKQdi2A9aDwAWPE9+FYjI9/JoZjIrSCLHrbItozIT7O/k0SwoR3PVYoTFdKnKMJnGpqkqJwgQmW4ChlfXFWUHPc3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8455

Hi Will,

> Subject: Re: [PATCH 2/4] arm64: tlb: Add tlbi workaround for FUJITSU-MONA=
KA Erratum E#030001
>=20
> On Fri, Oct 02, 2026 at 07:26:50PM +0900, Tomohiro Misono wrote:
> > FUJITSU-MONAKA Erratum E#030001 affects FUJITSU-MONAKA CPU
> > when using 64k page size.
> >
> > On affected FUJITSU-MONAKA CPUs, range-based TLBI operations
> > targeting a VA or IPA may fail to invalidate TLB entries when
> > addr[34:29] =3D=3D all 1 && addr[28:0] =3D=3D 0 for 512MB mappings.
> > The affected instructions are:
> >   RVA[L]E{1,2,3}*, RVAA[L]E1*, and RIPAS2[L]E1*.
> >
> > Work around the erratum by issuing additional non-range
> > TLBI instructions corresponding to the affected VA or IPA
> > range-based TLBI operations.
>=20
> Why don't we just avoid using range invalidation on these parts instead?

As I replied in Mark's comment, disabling range operations on MONAKA CPUs w=
ould be another solution.=20
We'd like to select the option that minimizes the performance impact.

Thanks for the review.
Best Regards,
Tomohiro Misono

>=20
> Will
