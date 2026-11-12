Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794500801;
	b=2e8sbe1qlGXDEO2UEo/D2RpS1r0PJ3QxLjcNrUJlyBFrS4aUr/BDwgUrUNxjlto8i7O1
	 b1/WG6U+gr9fAPye+zPWL/wztxDfDcUbpuF0K2sSY9hOQadaOHE6InbYW0dw7y7F7TsSX
	 Wx4GrUhSl5iMOYM3LeGbxSitwUMo4/Onpx1s9JDw3SgT8rrhCwQbS583IpPvI7xIkCR1S
	 WleZxMNlGGQeDE+s7ZTH+baKj3cpt7o4E1boRVShTdu64TncOW6VVxo7TeGYVJyy0fEH+
	 2zQtBjDlGwPkI/iFZAqmdhw9PD2dfEESIQru27P5RG63xq/GDmjEefosD+UpRte6okQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794500801;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=r1u0JGgg6XpGFAwtdNl9P9wPnSBoZSZ2+Wn66VGAtHg=;
	b=oQAdJ5TDn20Uour+X7A+M4rJvjzkO93sSjiX+kSvJWRoTKrFUUwrqFUwT1/IBs3r2QnQ
	 BVpyXSIdU3Zf/osWjChboWgyVnVg+BUBqtVGW6qhIp9/4sH8Bnxalu32uq2XNgsI+Ia5S
	 +hh+yWeAwANhgbpqr6Qnp+8hCXCNi0HuP2MIHsbs1/6NufypQlxt5QrwI7SsU/p3pEr5P
	 cso3XF6dgFNR92EToftXeWUoYJlsfqZK3Iu/6gL4PHhVf8hXuPzV7DrMm7e6ruFQNezd1
	 FfGJLlu+2NkMW6xmttqL4dZe9ogxXU1kjD+TGQnRGyyqO2IvUvc83lqMtjcDAUaStTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="RoQ+/+SE";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.28
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010028.outbound.protection.outlook.com [52.101.193.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41201606A323;
	Thu, 12 Nov 2026 16:26:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41201606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RoQ+/+SE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vo4+4b+32g9MNI8xviifYfyCSTDydQ2mo94GwxoMDUfsN5t2a15vQtJiw6E8V3YqMa6a3E5IfIvnsIK3OKW+vB4JfHYqiubmi17eJ05mRCoL4C+FCxG5c3neTkdY+M6vwtlncHK44jNXqEJ6GrOj0xO5cHBa5Gx0KgEJI5E4xuCPsckMqPFq5VEiNpWioiMgS7cP1HV4eN0KBVK8+6Gppl6NtCSV/DUfTJ+r7fAesn78JMpAmvalzweNSZr7/qhYMhfW1vUcIr4xwv/haX3d/moDb+zc53LbepNHuhy7a9whX0AfjX4MO87dlhnwuaJGLWoWWjY/RwkE1SccVE6Nwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1u0JGgg6XpGFAwtdNl9P9wPnSBoZSZ2+Wn66VGAtHg=;
 b=LQ8KjRVOw6iCyYAjetqz7Vs/wDdBCzyB5rsE6VBLQWfh4ISG6/ZMQDqptcHQO+/tBVmCwyOipsPh2lr2EDDpYztdr12Vs3k9x4jlROJDHneSAvex9coIqtOMOgSyZ77h7wn3eQHHsA5zPPMgXTvMWpZ14dYMnl6mQZY0ndTvWHkMmtK5EjXuYi0XeQEm16koAJM4E6gXsvLWXY60czuYSA3Z8U9aV+TN6PAtD48zHWTTGeTR5m37o0l6PpzI55QCZXLbbIqq9Q2BgbAeR5CC9kYRwum7wKfwhN+BT1mkfTbNuffRNQu3bVXo9b7mAVlgOQZGyMlYFWx4UaMg+S234Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1u0JGgg6XpGFAwtdNl9P9wPnSBoZSZ2+Wn66VGAtHg=;
 b=RoQ+/+SEZSoH2TGXnc55fX44nd4RS+HFu9oCmE83m6ZrKRsmO4uHB8tBUx52tNL8aMiO+dA9QPTk9W51KWukc51BjirhgifBJqy+GsG1WLjljUWmYwl1p8FZ0i6QTIWx5tXSkssd7Jf6x9YX2PzzlJQEjpLPTAcB2NFwrSrPJ7UUHyvioJJZIzloZUYWMMi7rjzKS5KOIBdLgnPAZwMM+9OOXJUAUwbbKBXhxgDFm/Q2Sz/6cjfJCZvQ086CYqPvoKzoo7Hi2IwroKdHy3fm4WTzz5g1ZKnB+YFb3om3qEua/UpSXjOEn9BSxHmiA17y0hn34qi/SSpcrBIQX+83Wg==
Received: from SA1PR12MB6773.namprd12.prod.outlook.com (2603:10b6:806:258::16)
 by DS0PR12MB8269.namprd12.prod.outlook.com (2603:10b6:8:fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Thu, 12 Nov
 2026 16:26:31 +0000
Received: from SA1PR12MB6773.namprd12.prod.outlook.com
 ([fe80::ba62:69e8:261f:1cdf]) by SA1PR12MB6773.namprd12.prod.outlook.com
 ([fe80::ba62:69e8:261f:1cdf%5]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 16:26:31 +0000
From: Besar Wicaksono <bwicaksono@nvidia.com>
To: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>
CC: "acme@kernel.org" <acme@kernel.org>, "namhyung@kernel.org"
	<namhyung@kernel.org>, "ctshao@google.com" <ctshao@google.com>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Vikram Sethi <vsethi@nvidia.com>, Rich Wiley
	<rwiley@nvidia.com>, Sean Kelley <skelley@nvidia.com>, Matt Ochs
	<mochs@nvidia.com>, Raj Joshi <rajjoshi@nvidia.com>, Thierry Reding
	<treding@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>,
	"john.garry@linux.dev" <john.garry@linux.dev>, "will@kernel.org"
	<will@kernel.org>, "james.clark@linaro.org" <james.clark@linaro.org>,
	"mike.leach@arm.com" <mike.leach@arm.com>, "leo.yan@linux.dev"
	<leo.yan@linux.dev>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "adrian.hunter@intel.com"
	<adrian.hunter@intel.com>
Subject: RE: [PATCH v3 0/7] perf: Add NVIDIA Tegra410 uncore PMU events and
 metrics
Thread-Topic: [PATCH v3 0/7] perf: Add NVIDIA Tegra410 uncore PMU events and
 metrics
Thread-Index: AQHdbHay5kpgh9CBkESuDE7Emx2/frceGWmAgAySfcA=
Date: Thu, 12 Nov 2026 16:26:31 +0000
Message-ID:
 <SA1PR12MB67732420C07903B83DF30D7AA0702@SA1PR12MB6773.namprd12.prod.outlook.com>
References: <20261104160716.2910873-1-bwicaksono@nvidia.com>
 <CAP-5=fXriq3akwKxsxSuBZ0M=1OMuCe8ig_j-r6ehfCeCVAYcQ@mail.gmail.com>
In-Reply-To:
 <CAP-5=fXriq3akwKxsxSuBZ0M=1OMuCe8ig_j-r6ehfCeCVAYcQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB6773:EE_|DS0PR12MB8269:EE_
x-ms-office365-filtering-correlation-id: 4451ae66-8103-4de5-857d-08df40d9b5e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|23010399003|376014|366016|1800799024|38070700021|4143699003|261026121527099003|261009223027099003|261021123027099003|261021121427099003|261028144727099003|5023799004|11063799006|261026140227099003|261022105027099003|261102123227099003|56012099006|22082099003|18002099003|6133799003|10067099003;
x-microsoft-antispam-message-info:
 ERpU4m5QxAzxXVvn/ijxq5t2dq1TTLjbkdYZImy+XKDKQJzUq3A0rzds3BvTCsVCX7Sa0b4D2BmhTadZCxGgzIQ+s5QmLN0D6LZPb4jtbM2pWD0b0QFVnhJOWfJm4ELTn4aZnW9RLrpHbSKVtGzSu+xBeNBl+uG//0xwI7TC8EQl6tW8TEDQMR2SHRiNvfCKrqTKYO+kT1VNxmmqYu7npoX863kcGMkZ6uGAazXMUAnLJKOCilLnLZWQSy7T71f9LulI7chBu43HvgoecE91qkUD01bOVs5gF5b9U9y+9GJTcqDTZUWduuAdQFY/BYHR0abgzcxOQL9nYKpIV5Ip0qlYnwSlC5/7a1Ih0MvZCtoiHvFKvQ0x/RNoEGYi8zsUQGv+mSxNbS8u0C/yjLrkXz28nQcoGbEVvG/dy0qwf2ItAbLCd8HSM4A3KG45KELPeK0Nd5uNJpHj6ZlV/+Wx/+/x960GLrrkWm2lLUBbpGekpiGF/JCw3ojFUbYbl4vSNWDGIEkW6Gbz5eulKz/Cf+BA/z2NJm9NvOg7w6VZTvU1nZNBF93qp9y9sIAlGOiSUnTwqyQqpwaxm3w4ZOCZ7/wq2P0d73NdS3AmMz2LBE5a3cPNKOON6Hm3brZmhndOZyRlfIE6oUSYC0Ip2+3PRFDEMHS+QQlymaXclHYfwF0ZFWtFFYCH8ZWBceazG3kPfyzbZRo4T6ZqQXYiAzc/Vg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB6773.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(38070700021)(4143699003)(261026121527099003)(261009223027099003)(261021123027099003)(261021121427099003)(261028144727099003)(5023799004)(11063799006)(261026140227099003)(261022105027099003)(261102123227099003)(56012099006)(22082099003)(18002099003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZWZJRUFVU1VFUzRQNktyUXoyYXUrbXNUTDFwN2pySENUT1ZjQ1gwZjhuS1B2?=
 =?utf-8?B?c3M5MzQ0d0dld2EyQjdTOS9tczI2aXgvemJrSU1xdFBlVWdLZlBGY28yd3Zm?=
 =?utf-8?B?K2hxYm82RC9ZeVpxcTRyQTlqejlyMmxZMnd3ZkdIUEtGVmNxblVQRU1FUktN?=
 =?utf-8?B?ekRKTHludGJpRlM3QXNPVFNsOGhYUjRETER6QVhDY3FRR2d0SGQ3SER6bUFn?=
 =?utf-8?B?ZVRzaUdsbVdXYXJyaGRBd0V3cUZjVVpkaWJITXVzdDEzOVpobStYWnVIL3Jr?=
 =?utf-8?B?Rlh5ZndHT1haenZOU25RODM1WEtLMGhjS3VBZXc4aWU3NDNQeWcyYzd0NmxJ?=
 =?utf-8?B?K21yTlJLWjYwdWRCbCtyeXlkYXlrTkdDdlhBckcwaG8ra2VSN0RPdTlTR3Er?=
 =?utf-8?B?VC9jYTd0UWVYZ3hhL3lOcURhSEl5MWQrdmROQW1ZRjArOHMybGRsLzBXOG5G?=
 =?utf-8?B?aHRDbkdvNjhLajJ0V09kTk1tVytBeTdkdkp4ZkMwVmQyRG9IT003Tk9XbFpj?=
 =?utf-8?B?UVFBbW1qdFgrbERlS1lqOUxLR01zQ081L0wyRmRyWXArSEQ5OG80cjQrZnNl?=
 =?utf-8?B?S1J3SFpiQ1N5bkcrREtwdi9PVDY4TStPc2JRalFUZ3hSOFVVRnFCL09YZkxH?=
 =?utf-8?B?YkhVS3FDREdmMjBucXcvNyt1L0V2NHd5QmpvL0cvZmdsSUhRLzF2azFzczNW?=
 =?utf-8?B?VDJQWXc1aTRLZVM2YW44ODUyQnpUNFhsUnVvNEZCKzNaSTBmUWNlZVgzUGJq?=
 =?utf-8?B?WVhYQVRFTG1XcEk5bmdld01NM25US05zNUJXMVFWR1N1d240QWw1K3dXZmFs?=
 =?utf-8?B?UExrTy9kVFhEbFJlYnM0amJIMlp4UGp4dUx1ZzNRQWE5YUw2MEwwU2lnVlZ4?=
 =?utf-8?B?OEZoRFN3S3RmdjAyU0ZERE5UbnFVcDAzUCtaR2ZDNGNxVlhQYWNYWHlWWDJZ?=
 =?utf-8?B?cDJSRUc3Y1A2d09NcXNGRmhsNjR0VEUrNTJqc01xR2ZISm5YNTNDajkwM1Rk?=
 =?utf-8?B?V2grcVd1WHFZRzg1akdIQ3dvandBWCttTlRaM1ZnaGdyZlVpclpkdWZUb3Rr?=
 =?utf-8?B?OFBnRXB2UUNKdkhCVUtVT3Z0cTZEUlBTc25MdmNUSGxaMlpoakI4TWxqZDAv?=
 =?utf-8?B?NVFCWkg1dUFZc0EyVFYvL29mV3dRU1FyckhqTW5SL0VlWTlhNWlkZFIwYyt6?=
 =?utf-8?B?MjhseXYza2lCT2x1WERsZitpL0RXU1RieU5ac2dhWE5SdHRRd0JKNVBGNjF1?=
 =?utf-8?B?a0pLVFg2L1o2bUZUQnNJNVBJT3RnVFJZYVFMb3ZsOSsvNUN1d0c2VitrZ3JN?=
 =?utf-8?B?ZXN2SFVIdVAwMXphQVJ0UUNnMUZWSjhidmxYTjB5bmg3K2lidlBkN0FHYVRh?=
 =?utf-8?B?S1JOYnp4M2Z5cnBIb0JIRjFnbXoxdWpFYjRFdExLK05IZmYyRHp4aTlMZThN?=
 =?utf-8?B?TGlwQjFVSjBaMFNhekxBaEk1VXpKTW9NVlVhKzJEVlZLZ2hxdXNpdU1tNkVr?=
 =?utf-8?B?YUswVXRSK1hyU2VlNHFaV2VkV0k1VSt2NHozbWNVWTR3ZlBDajlkRXE3UGs5?=
 =?utf-8?B?YzJQeVJEaUUwT0VaTGRyRXUva29CSEFOMFJ4MzNjQmY4RUNsV3FHODVvMjkr?=
 =?utf-8?B?MWxORDF3SUhBQ0tQZjBaMWZnd3JSeStsbGdDRkVrSXdYdUF2REEyNFVwVjlF?=
 =?utf-8?B?aFJOZVhiNFNZWS9UMldaUlh2YXhLYzh3eEV4QWgycVcvZVZFUUVFUnpUL1hZ?=
 =?utf-8?B?dFAzK1F0MlhKR1FidzlnYldxYmlRTzE1VnJQb2V4TEJLNmdUNy9zUnY3blhR?=
 =?utf-8?B?S0hYaU1JT2pKQ0k3WGNVZVhualhVa21KMWFLQW1mVkQ5dHFNRUJRc0RBZWZh?=
 =?utf-8?B?Q29tWDRxa2NPelJ2UWdtc0dGRGNyMzdLNDNFMDFGbjhBeUJleVFManFWalV1?=
 =?utf-8?B?OGdkYjBGQ3lJWnpNU3RXc2ZxMlZyOGxKbzJVZHZUd1BjTTBzKzdiaFVFOGxS?=
 =?utf-8?B?N2pPcjc0TFlZeXRHdWUxYmg0T3hERzlISWs1RWxJeEw1bk9vNGovd0tQU0NW?=
 =?utf-8?B?QzNzOGt6VHJKUzdUaDErbVNQU09GM0EzbWNkbmIxcXQxNVE5L05Ja1VGMEFR?=
 =?utf-8?B?TnNtVmtYc09ScmZoVkVqOHFvY2J2aGRQdC9uNm9QNGpJTThPbVNZRUZFcHBq?=
 =?utf-8?B?SkVVZzc3ek43V0pZS0NCZzdCb3YrWWVWRUpmZHZCVUJ4QTZqK3J4N2RtYk5l?=
 =?utf-8?B?NmdmOW14UGJqdEpiVEUwaGtmckg5ZW1RcUNjdmRydjhYa2Q0M0xYVVlFbkZn?=
 =?utf-8?Q?cZrCtOLQP1JbfWFwG5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6773.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4451ae66-8103-4de5-857d-08df40d9b5e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2026 16:26:31.3206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DINRiYyuVJsrdraj/9QxI114YYY82CGVBf4d8Oen4QekpHDARFpTILw1DxCr7WqMSMmsLU6dGRPPtTZVa64L7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8269

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSWFuIFJvZ2VycyA8aXJv
Z2Vyc0Bnb29nbGUuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDQsIDIwMjYgNDoy
NiBQTQ0KPiBUbzogQmVzYXIgV2ljYWtzb25vIDxid2ljYWtzb25vQG52aWRpYS5jb20+DQo+IENj
OiBhY21lQGtlcm5lbC5vcmc7IG5hbWh5dW5nQGtlcm5lbC5vcmc7IGN0c2hhb0Bnb29nbGUuY29t
OyBsaW51eC0NCj4gdGVncmFAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmc7IGxpbnV4LXBlcmYtDQo+IHVzZXJzQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgVmlrcmFtIFNldGhpDQo+IDx2c2V0aGlAbnZpZGlh
LmNvbT47IFJpY2ggV2lsZXkgPHJ3aWxleUBudmlkaWEuY29tPjsgU2VhbiBLZWxsZXkNCj4gPHNr
ZWxsZXlAbnZpZGlhLmNvbT47IE1hdHQgT2NocyA8bW9jaHNAbnZpZGlhLmNvbT47IFJhaiBKb3No
aQ0KPiA8cmFqam9zaGlAbnZpZGlhLmNvbT47IFRoaWVycnkgUmVkaW5nIDx0cmVkaW5nQG52aWRp
YS5jb20+OyBKb24gSHVudGVyDQo+IDxqb25hdGhhbmhAbnZpZGlhLmNvbT47IGpvaG4uZ2FycnlA
bGludXguZGV2OyB3aWxsQGtlcm5lbC5vcmc7DQo+IGphbWVzLmNsYXJrQGxpbmFyby5vcmc7IG1p
a2UubGVhY2hAYXJtLmNvbTsgbGVvLnlhbkBsaW51eC5kZXY7DQo+IG1hcmsucnV0bGFuZEBhcm0u
Y29tOyBhbGV4YW5kZXIuc2hpc2hraW5AbGludXguaW50ZWwuY29tOw0KPiBqb2xzYUBrZXJuZWwu
b3JnOyBhZHJpYW4uaHVudGVyQGludGVsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDAv
N10gcGVyZjogQWRkIE5WSURJQSBUZWdyYTQxMCB1bmNvcmUgUE1VIGV2ZW50cw0KPiBhbmQgbWV0
cmljcw0KPiANCj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3Ig
YXR0YWNobWVudHMNCj4gDQo+IA0KPiBPbiBXZWQsIE5vdiA0LCAyMDI2IGF0IDg6MDjigK9BTSBC
ZXNhciBXaWNha3Nvbm8NCj4gPGJ3aWNha3Nvbm9AbnZpZGlhLmNvbT4gd3JvdGU6DQo+ID4NCj4g
PiBBZGQgZXZlbnQgYWxpYXNlcyBhbmQgZGVyaXZlZCBtZXRyaWNzIGZvciB0aGUgTlZJRElBIFRl
Z3JhNDEwIHVuY29yZQ0KPiA+IFBNVXMsIGFuZCBmaXggcGVyZidzIGFnZ3JlZ2F0aW9uIG9mIHRo
ZSBUZWdyYTQxMCBQQ0llIFBNVSBpbnN0YW5jZXMuDQo+ID4NCj4gPiBUaGUgc2VyaWVzIGNvdmVy
cyB0aGUgVUNGLCBQQ0llLCBQQ0llIHRhcmdldCwgQ1BVIG1lbW9yeSBsYXRlbmN5LCBhbmQNCj4g
PiBjaGlwLXRvLWNoaXAgaW50ZXJjb25uZWN0IFBNVXMuIEl0IHByb3ZpZGVzIHN5bWJvbGljIG5h
bWVzIGZvciB0aGUgcmF3DQo+ID4gZXZlbnQgZW5jb2RpbmdzIGFuZCBtZXRyaWNzIGZvciBiYW5k
d2lkdGgsIGZyZXF1ZW5jeSwgYW5kIGF2ZXJhZ2UgcmVhZA0KPiA+IGxhdGVuY3kuDQo+ID4NCj4g
PiBUaGUgUENJZSBhbmQgUENJZSB0YXJnZXQgUE1VcyBhcmUgbmFtZWQNCj4gbnZpZGlhX3BjaWVf
cG11Xzxzb2NrZXQ+X3JjXzxyYz4NCj4gPiBhbmQgbnZpZGlhX3BjaWVfdGd0X3BtdV88c29ja2V0
Pl9yY188cmM+LiBwZXJmIG9ubHkgc3RyaXBzIHRoZSBudW1iZXIgYXQNCj4gPiB0aGUgZW5kIG9m
IGEgUE1VIG5hbWUsIHNvIHRoZSBpbnN0YW5jZXMgb2YgZWFjaCBzb2NrZXQgd2VyZSB0cmVhdGVk
IGFzIGENCj4gPiBkaWZmZXJlbnQgUE1VLCBhbmQgdGhlc2UgZXZlbnRzIGFuZCBtZXRyaWNzIGdh
dmUgb25lIHJlc3VsdCBwZXIgc29ja2V0DQo+ID4gYW5kIHdlcmUgcmVwb3J0ZWQgaW5jb3JyZWN0
bHkgKGUuZy4gd2l0aCAtLW1ldHJpYy1vbmx5KSwgYXMgZGlzY3Vzc2VkIGluDQo+ID4gdjEgYW5k
IHYyLiBQYXRjaGVzIDYgYW5kIDcgZml4IHRoaXM6DQo+ID4NCj4gPiAtIFBhdGNoIDYgYWRkcyBh
IGNoZWNrIG9mIHRoZSBjcHVtYXNrcyBvZiBhbGwgbWVyZ2VkIFBNVSBpbnN0YW5jZXMgdG8gdGhl
DQo+ID4gICB6ZXJvLWNvdW50IHNraXAgaW4gcGVyZiBzdGF0LCBzbyBhIHNvY2tldCB0aGF0IGNv
dW50cyBub3RoaW5nIHNob3dzIDANCj4gPiAgIGluc3RlYWQgb2YgaGF2aW5nIGl0cyByb3cgaGlk
ZGVuLg0KPiA+IC0gUGF0Y2ggNyB0cmVhdHMgYm90aCBudW1iZXJzIG9mIHRoZSBOVklESUEgUENJ
ZSBQTVUgbmFtZXMgYXMgdGhlDQo+ID4gICBzdWZmaXgsIHNvIHRoZSBpbnN0YW5jZXMgb24gYWxs
IHNvY2tldHMgYXJlIG1lcmdlZCBhcyBudmlkaWFfcGNpZV9wbXUNCj4gPiAgIG9yIG52aWRpYV9w
Y2llX3RndF9wbXUuIFBlci1SQyByZXN1bHRzIGFyZSBzdGlsbCBhdmFpbGFibGUgd2l0aA0KPiA+
ICAgLS1uby1hZ2dyIG9yIC1BLg0KPiA+DQo+ID4gQ2hhbmdlcyBpbiB2MzoNCj4gPiAtIFJlcGxh
Y2UgdjIgcGF0Y2hlcyA3LTkgKG1lcmdpbmcgUE1VIGluc3RhbmNlcyB0aGF0IG1hdGNoIHRoZSBz
YW1lDQo+ID4gICBjb21tYS1zZXBhcmF0ZWQganNvbiBVbml0LCBuYW1pbmcgYSBtZXJnZWQgY291
bnRlciBhZnRlciBhbGwgb2YgaXRzDQo+ID4gICBQTVVzLCBhbmQgdGhlIEFCSSBkb2N1bWVudCkg
d2l0aCBhIHNwZWNpYWwgY2FzZSBmb3IgdGhlIE5WSURJQSBQQ0llDQo+ID4gICBQTVUgbmFtZXMg
aW4gcG11X25hbWVfbGVuX25vX3N1ZmZpeCgpLA0KPiBwZXJmX3BtdV9fbWF0Y2hfd2lsZGNhcmQo
KSBhbmQNCj4gPiAgIHBtdV9uYW1lX2NtcCgpLiBUaGFua3MgdG8gSWFuIFJvZ2VycyBmb3IgdGhl
IHN1Z2dlc3Rpb24uDQo+ID4NCj4gPiBDaGFuZ2VzIGluIHYyOg0KPiA+IC0gTW92ZSB0aGUgdW5j
b3JlIEpTT04gb3V0IG9mIHRoZSBzeXMgZGlyZWN0b3J5IGFuZCByZW1vdmUgdGhlDQo+ID4gICAi
Q29tcGF0IiBmaWVsZHMuIFRoYW5rcyB0byBJYW4gUm9nZXJzIGZvciB0aGUgZmVlZGJhY2suDQo+
ID4gLSBEcm9wICJwZXJmIGpldmVudHM6IFByb2Nlc3MgbW9kZWwgZmlsZXMgYmVmb3JlIHN5cyBz
dWJkaXJlY3RvcmllcyIsDQo+ID4gICB3aGljaCB0aGlzIHNlcmllcyBubyBsb25nZXIgbmVlZHMu
DQo+ID4gLSBBZGQgVUNGIFNMQyBhbmQgbWVtb3J5IGJhbmR3aWR0aCBtZXRyaWNzIGZyb20gYWxs
IHNvdXJjZXMgdG8gbG9jYWwNCj4gPiAgIENNRU0gKHJlYWQsIHdyaXRlIGFuZCByZWFkK3dyaXRl
KSBhbmQgZnJvbSBsb2NhbCBzb3VyY2VzIHRvIGxvY2FsDQo+ID4gICBDTUVNIGFuZCB0byByZW1v
dGUgbWVtb3J5LCBQQ0llIGJhbmR3aWR0aCBtZXRyaWNzIHRvIGxvY2FsDQo+ID4gICBkZXN0aW5h
dGlvbnMsIGFuZCByZWFkK3dyaXRlIGJhbmR3aWR0aCBtZXRyaWNzIGZvciBVQ0YgU0xDLCBVQ0YN
Cj4gPiAgIG1lbW9yeSBhbmQgUENJZS4gVGhhbmtzIHRvIENodW4tVHNlIFNoYW8gZm9yIHRoZSBz
dWdnZXN0aW9uLg0KPiA+IC0gQWRkIHBhdGNoZXMgNi05IHRvIGZpeCB0aGUgUENJZSBpbnN0YW5j
ZSBhZ2dyZWdhdGlvbi4gVGhhbmtzIHRvIElhbg0KPiA+ICAgUm9nZXJzIGFuZCBDaHVuLVRzZSBT
aGFvIGZvciB0aGUgcG9pbnRlcnMuDQo+ID4NCj4gPiB2MjogaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvYWxsLzIwMjYxMDMwMTc0ODE2LjE1NDQ0NzEtMS0NCj4gYndpY2Frc29ub0BudmlkaWEuY29t
Lw0KPiA+IHYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNjEwMTkxNjQyNDEuNDAz
NjQ0LTEtDQo+IGJ3aWNha3Nvbm9AbnZpZGlhLmNvbS8NCj4gPg0KPiA+IEJlc2FyIFdpY2Frc29u
byAoNyk6DQo+ID4gICBwZXJmIGpldmVudHM6IEFkZCBzdXBwb3J0IGZvciBOVklESUEgVGVncmE0
MTAgVUNGIFBNVSBhbGlhc2luZw0KPiA+ICAgcGVyZiBqZXZlbnRzOiBBZGQgc3VwcG9ydCBmb3Ig
TlZJRElBIFRlZ3JhNDEwIFBDSUUgUE1VIGFsaWFzaW5nDQo+ID4gICBwZXJmIGpldmVudHM6IEFk
ZCBzdXBwb3J0IGZvciBOVklESUEgVGVncmE0MTAgUENJRS1UR1QgUE1VIGFsaWFzaW5nDQo+ID4g
ICBwZXJmIGpldmVudHM6IEFkZCBzdXBwb3J0IGZvciBOVklESUEgVGVncmE0MTAgQ1BVIE1lbW9y
eSBMYXRlbmN5DQo+IFBNVQ0KPiA+ICAgICBhbGlhc2luZw0KPiA+ICAgcGVyZiBqZXZlbnRzOiBB
ZGQgc3VwcG9ydCBmb3IgTlZJRElBIFRlZ3JhNDEwIEMyQyBQTVUgYWxpYXNpbmcNCj4gPiAgIHBl
cmYgc3RhdDogQ2hlY2sgbWVyZ2VkIFBNVSBpbnN0YW5jZSdzIGNwdW1hc2tzIHdoZW4gc2tpcHBp
bmcgemVybw0KPiA+ICAgICBjb3VudHMNCj4gPiAgIHBlcmYgcG11czogVHJlYXQgYm90aCBudW1i
ZXJzIG9mIE5WSURJQSBQQ0llIFBNVSBuYW1lcyBhcyBzdWZmaXgNCj4gDQo+IE90aGVyIHRoYW4g
dGhlIG5pdCB0aGUgdGhhdCBjb21taXQgbWVzc2FnZXMgYWRkaW5nIGV2ZW50cyByZWZlciB0byBp
dA0KPiBhcyAiUE1VIGFsaWFzaW5nIjoNCj4gDQo+IFJldmlld2VkLWJ5OiBJYW4gUm9nZXJzIDxp
cm9nZXJzQGdvb2dsZS5jb20+DQo+IA0KDQpUaGFua3MgSWFuLg0KDQpIaSBBcm5hbGRvLA0KDQpD
YW4gd2UgdGFrZSB0aGVzZSBzZXJpZXM/DQoNClJlZ2FyZHMsDQpCZXNhcg0KDQo+IFRoYW5rcywN
Cj4gSWFuDQo+IA0KPiA+ICAuLi4vYXJtNjQvbnZpZGlhL3Q0MTAvdW5jb3JlLWNwdV9tZW0uanNv
biAgICAgfCAgNDMgKw0KPiA+ICAuLi4vYXJtNjQvbnZpZGlhL3Q0MTAvdW5jb3JlLW52Y2xpbmsu
anNvbiAgICAgfCAgNjcgKysNCj4gPiAgLi4uL2FybTY0L252aWRpYS90NDEwL3VuY29yZS1udmRs
aW5rLmpzb24gICAgIHwgIDQzICsNCj4gPiAgLi4uL2FybTY0L252aWRpYS90NDEwL3VuY29yZS1u
dmxpbmtfYzJjLmpzb24gIHwgMTE1ICsrKw0KPiA+ICAuLi4vYXJjaC9hcm02NC9udmlkaWEvdDQx
MC91bmNvcmUtcGNpZS5qc29uICAgfCAyNDkgKysrKysrDQo+ID4gIC4uLi9hcm02NC9udmlkaWEv
dDQxMC91bmNvcmUtcGNpZV90Z3QuanNvbiAgICB8ICA4MyArKw0KPiA+ICAuLi4vYXJjaC9hcm02
NC9udmlkaWEvdDQxMC91bmNvcmUtdWNmLmpzb24gICAgfCA3NjQNCj4gKysrKysrKysrKysrKysr
KysrDQo+ID4gIHRvb2xzL3BlcmYvdXRpbC9wbXUuYyAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAgOSArDQo+ID4gIHRvb2xzL3BlcmYvdXRpbC9wbXVzLmMgICAgICAgICAgICAgICAgICAgICAg
ICB8ICAyMyArDQo+ID4gIHRvb2xzL3BlcmYvdXRpbC9zdGF0LWRpc3BsYXkuYyAgICAgICAgICAg
ICAgICB8ICAyMCArDQo+ID4gIDEwIGZpbGVzIGNoYW5nZWQsIDE0MTYgaW5zZXJ0aW9ucygrKQ0K
PiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgdG9vbHMvcGVyZi9wbXUtDQo+IGV2ZW50cy9hcmNoL2Fy
bTY0L252aWRpYS90NDEwL3VuY29yZS1jcHVfbWVtLmpzb24NCj4gPiAgY3JlYXRlIG1vZGUgMTAw
NjQ0IHRvb2xzL3BlcmYvcG11LQ0KPiBldmVudHMvYXJjaC9hcm02NC9udmlkaWEvdDQxMC91bmNv
cmUtbnZjbGluay5qc29uDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCB0b29scy9wZXJmL3BtdS0N
Cj4gZXZlbnRzL2FyY2gvYXJtNjQvbnZpZGlhL3Q0MTAvdW5jb3JlLW52ZGxpbmsuanNvbg0KPiA+
ICBjcmVhdGUgbW9kZSAxMDA2NDQgdG9vbHMvcGVyZi9wbXUtDQo+IGV2ZW50cy9hcmNoL2FybTY0
L252aWRpYS90NDEwL3VuY29yZS1udmxpbmtfYzJjLmpzb24NCj4gPiAgY3JlYXRlIG1vZGUgMTAw
NjQ0IHRvb2xzL3BlcmYvcG11LQ0KPiBldmVudHMvYXJjaC9hcm02NC9udmlkaWEvdDQxMC91bmNv
cmUtcGNpZS5qc29uDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCB0b29scy9wZXJmL3BtdS0NCj4g
ZXZlbnRzL2FyY2gvYXJtNjQvbnZpZGlhL3Q0MTAvdW5jb3JlLXBjaWVfdGd0Lmpzb24NCj4gPiAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IHRvb2xzL3BlcmYvcG11LQ0KPiBldmVudHMvYXJjaC9hcm02NC9u
dmlkaWEvdDQxMC91bmNvcmUtdWNmLmpzb24NCj4gPg0KPiA+IC0tDQo+ID4gMi40My4wDQo+ID4N
Cg==
