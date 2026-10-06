Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011011.outbound.protection.outlook.com [40.107.74.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA313AD503;
	Tue,  6 Oct 2026 09:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791279956; cv=fail; b=LHns+oh/vxQYGFiBDnoUFl+XvW7bMJQ+LrKXXVmVRoHAC9ztUPBrCkw4eR9+11p1MGwM14Iud7Eg7UEuZEDuoR2CVjuC9ztCK3eTK6QEUL1jcaDPzDaNqXnU+FvvlL26ZkAYliKWUdM/Krw0tVfP1cbH7sgaNTi6htIKfUtnNzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791279956; c=relaxed/simple;
	bh=/vIhX/593NggoUVlw25lNOHDj6/yLpAyIU/ReJ1SV2A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aP+WIR1Uw41U73ac7jFUOS7CmSexNZ+a7ySt7Mk2mkFaNqLjtuAiU0xhxFNxdFgZrzOZlLqVayoUhIQPQXO4qMCUTW0h0bT0lkpwWUfUnsTHbRAIHTQFEqsFr/bLcSqaWd+oPPW0fhyMNQXi0s9Zwk3im/6yWqCDhGAmaGfluvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=fnjRLcVw; arc=fail smtp.client-ip=40.107.74.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="fnjRLcVw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sILRUJKOQe3WRhhZyBjJp7LgDqb7w2O+kXc+kxavCfCokYIn+OL8e+bAkHvKq6hkhPajJ9p+kwoCOz1DhMAlhvtpZbKD9MpYEMkfIHhMsyErFrMZnFv0YAwxgMqKRsJhswF8WveCrYUFBYdutyyH/jSKSEsQ4SNlNaPvSpP+ZXcdMfOnypNnOtTLtPp+TJm6pdtpLthfBo8QfhRBRX+xZWWKYZOG9720cuvB7E3QOAfKbCsNYmaPINFtRmfiE6QkRLHsEPrURxs6k17xHySs/SXzOZRl9mcsenMbRNB7gFGaTtxHSnKLCYGJ9tYGVdsg5b+8RMuvTPqZR4SZIJzJuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6lZUkpVR2embVnE4gj43/nQGZnGE5UdHFQRo7taqeo=;
 b=eewA/9RVODE1X5L1UhHElgxo3HS4inTGt1+43U1G0eZD+IGftUhvtYtbFMHbLefVYO70VD2JGTs3CGqwEv5OnmTY9PyK28jpclP2bkkGjEIVb7MokWpP4ByYSoD5D1b1MI9cU2QHyiXMrPUEJ6Q7glaBT+G7bOs8XkBUBnXO0AyvyIfmQbqXe3u5wIXKxUKDFFYlGr42AZhcnuR1PiMMZzFbKhMTP/6+v7i5S67uvN3VjPGd4KuphGYKoJ1IZFg6k3aKnP4IZL/7kLx9U8X2g9ZpIOCWJpVPjZV3+0Bf1xakmImZIvAmOy6Gd7GkDolRfK3I9Oy4FtN8Mv8/cuJp4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6lZUkpVR2embVnE4gj43/nQGZnGE5UdHFQRo7taqeo=;
 b=fnjRLcVwkjM/eiNXZbNg8QeX6hR7Hfgf8QNF4eDNzEBbVEAoEVrwZdZGpe2QRd6p+H21eiPfG+rYmuQv8jU/QzxpTnMlZCPnoa9xxidEWW8ZNJgbGNaqq6PIXMHJwuMCYHiYAO5yrZWZtoZP+684JIUt4QeYM4zEaoz08fi6miZqe/ArhPAv1YE9KNKsIT6sG6WCPGwBREOUaOU8gCSKNaC+xtXLwN5ZoHK8mXN03Ij/9XKjmGyMCrnlPD1X0R1ZD6/14iNXZjQNZfJTap7X7ieJbUGT9IxN/jQyBublFaOCEAPbiBHEjLEbYxv2x05gHfh48tuXuWuIj4ujomAloQ==
Received: from TY7PR01MB15746.jpnprd01.prod.outlook.com (2603:1096:405:290::6)
 by TYCPR01MB8455.jpnprd01.prod.outlook.com (2603:1096:400:15d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 09:45:50 +0000
Received: from TY7PR01MB15746.jpnprd01.prod.outlook.com
 ([fe80::bc79:d427:b0a9:a793]) by TY7PR01MB15746.jpnprd01.prod.outlook.com
 ([fe80::bc79:d427:b0a9:a793%5]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 09:45:50 +0000
From: "Tomohiro Misono (Fujitsu)" <misono.tomohiro@fujitsu.com>
To: 'Mark Rutland' <mark.rutland@arm.com>
CC: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, Marc Zyngier <maz@kernel.org>, Thomas
 Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, "Kohei Enju
 (Fujitsu)" <enju.kohei@fujitsu.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>
Subject: RE: [PATCH 2/4] arm64: tlb: Add tlbi workaround for FUJITSU-MONAKA
 Erratum E#030001
Thread-Topic: [PATCH 2/4] arm64: tlb: Add tlbi workaround for FUJITSU-MONAKA
 Erratum E#030001
Thread-Index: AQHdUli6CS8L1/ubT06LulaRj+FfqbbqN4QAgAYQ06A=
Date: Tue, 6 Oct 2026 09:45:46 +0000
Deferred-Delivery: Tue, 6 Oct 2026 09:45:46 +0000
Message-ID:
 <TY7PR01MB15746E4CA4B8681290E6E59E9E5952@TY7PR01MB15746.jpnprd01.prod.outlook.com>
References: <20261002-monaka-fix-for-upstream-v1-0-4aec0b0cbe34@fujitsu.com>
 <20261002-monaka-fix-for-upstream-v1-2-4aec0b0cbe34@fujitsu.com>
 <ar-rGjVKB0vqB-Jx@J2N7QTR9R3.cambridge.arm.com>
In-Reply-To: <ar-rGjVKB0vqB-Jx@J2N7QTR9R3.cambridge.arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=8d2c5c2c-bcdd-47e4-939b-ee5d29ff1bf0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2026-10-06T09:44:12Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Tag=10,
 0, 1, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB15746:EE_|TYCPR01MB8455:EE_
x-ms-office365-filtering-correlation-id: 662f0004-32a8-4176-aa7d-08df238e9b28
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|6133799003|10067099003|22082099003|18002099003|1580799027|3023799007|38070700021|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 v27I0o2VJljXpLa46oIhgpGPMoiv/7aMNfNkUIA2vWr82Vzlt08hMd0/t/0JxXpQwoyTGKzF/YcRpABs1t4KAeYca3PETwb7+ETCRgfsbrQoQGi/m2EtdeRuXPp92jSv2w3JJ7ZgFDiOi6prQ2Mz+pUUlGipnXKMe8/Q/4vpDIn0b1ZnqupToMKVd0f+gsMEI02CAtC1mbqC8ZgEZjG3D77pI5u+V8i/Xic0eu8qeVvpc1YojDrvuAoA6I1i5HRIRqn3bo9T4NZTiMN/W+2h3VXQyaSUpLaZc1biPKYbFbFInTzrPiZ2yXW373WK9oQIT2/a3GfsXfolre/fZ50n8MvzCl5BF4NoyPYa9XwHLHvVnVQw/YnDF4huthC9PcZgBASmSxe4u0dVBfkXp0IUWEUUnZtJackJbcP98lmQf4Ygw2HPKRzUOHUUzeRoiXhYu3ZOrrIN1NtOIl4NdVe6deIEp/aSX/8HhAR86iTLbLYwcAu+Y8M1M/yHC8+YjmkLaYI+0vUP0QbedkIxXB0Dx48mGCejnzGf0M+GMTrypqQrGlvWanpYva27bXSFnKDfNCZ6MO/G8SkZFDLERvMkyyP6kJC2/bsFYOTfuIufYHUCMj6kFKsp1OJ8/bGlPOA8fVJAQQ1A0lIG+1267ta0LmTIFVO31yByzsJHrfVOExEcLOL5auaxLz0tnepVrHxS7++2d0N2Nk9Jf6USLBxVlroH3+S8hkSEs0C62n0TpjJGooRiJ8v+tJAcUaN8rF33
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB15746.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(6133799003)(10067099003)(22082099003)(18002099003)(1580799027)(3023799007)(38070700021)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?Zi9jVFpudFo3aStOdHN5aVNNOHBoeTFsaG13bE5VM0ZGZkFaLzdueHdD?=
 =?iso-2022-jp?B?cFVsMVlYN3hoZ2t4c1IwdFpmY1laMjNmbzliazRvVUhXWE1SUlZSaGNz?=
 =?iso-2022-jp?B?TnNoRUUxdG15czFVUkovR3Rja0xndHNxUUNRai9OaHBETTM5U2lMZWpQ?=
 =?iso-2022-jp?B?Yk1ZNW03cGRKelBJenBWdEQwK2xBL3FxenRqa0tNcWxwdUVNUGRZQ2dw?=
 =?iso-2022-jp?B?ajFJcWt1M0o5UEQxeUM3UWJyZWtJM1pOZHVkSHhQTzBUTWUvVGUrTEVB?=
 =?iso-2022-jp?B?eG5WSEV5eTNUQVV2K3Z4cW0yRVNjdmNmMlh6c2ova1RlMmhCY0xIT0NV?=
 =?iso-2022-jp?B?b0RSQVp2OThJcGtvTmRrVi8vcHRhWGdZTGVaWUpYR1pDcGRvSkdrbFVa?=
 =?iso-2022-jp?B?TlJicjQvWHlrYkZmY0FwN0E4bGtac3phMk1QWWYzQXJVdFpvSjREdFVS?=
 =?iso-2022-jp?B?Q0o2UHB5ZG0vdVh0bktDSU9UeVZRelhpR3BCVjJ5RUM1YWZ3cG5HVEZr?=
 =?iso-2022-jp?B?N2NnSmhEM2U4clVoeGl0bWpuUXBORllWQjNSU1d2b0NlU1lRbGNLZXNW?=
 =?iso-2022-jp?B?M0V3R3NHWkJmaVJ5N05JREo2WnZyN1RSemI3WDd5ZlhlWVJwU3BDWE5i?=
 =?iso-2022-jp?B?ZFI1d3lqNEVScnR5T3hNVlZPTkpvdUxLNklmZzZNVis2ZzhkSzVPVC9m?=
 =?iso-2022-jp?B?TVh0RVFKa0RydmRXVEJXNkZaQS9NNkM5djRsa1RNYXorT1NRbG41RlVL?=
 =?iso-2022-jp?B?S0h4VzVOZXhtZEFRU1NzTmR5Y1p2SUVFUnF4Uk5qejB3T1B2OW5jUXFz?=
 =?iso-2022-jp?B?ZnhmWlVMdjA4VkthT0p5ZU9NbGp5a3RuRXZGR0dib20vWXNuanNYSWMx?=
 =?iso-2022-jp?B?OXZzcXMydjJpZlZDL1YxV0ZlNndiUUJmSjJOMzZnbHpoU25GWXpxcHF6?=
 =?iso-2022-jp?B?a0dwWEQ4MW01VHVzemlOODFwaTZjTlVicVNIeFgxalJPdXhpSDl4M1lm?=
 =?iso-2022-jp?B?QWFkQ0MvSTZrTVVqYVE1ei82ZUo4Q1ozNGNvM1krNFk0MUlRc2lpVG1E?=
 =?iso-2022-jp?B?cXdYeVRuU0lMa1kxVDRrUzZBTWkwYUd1bWdxa1BTVGk4MFBoOHpLd1hm?=
 =?iso-2022-jp?B?MzVReU5VMFczUGU0c2ZzZERUM2psQUFURFJabFdOeDdHdW9kN0MvWU5C?=
 =?iso-2022-jp?B?dGhuWXdkd0pKb1BTMWFReVRqVnRwM2lwQkN4Z3Q3UHJ6d0EzU2FjeWxx?=
 =?iso-2022-jp?B?S0pRY0xXSGJvSklnTGZNWDZwYzZVVEpkRkkzdUhDK3JwTWsxQ2tVOC9Y?=
 =?iso-2022-jp?B?ZVBRU3prRkpYV0pQTUp1bG1jZjBSRHB4MW45MCtXYVVzNU9HTXU2bjhv?=
 =?iso-2022-jp?B?WmNlOHBVaDZuSXhyeHRuSWZ0WWpuVDU1a3RyVkYrSkVXUlZBcGFFa2NR?=
 =?iso-2022-jp?B?TjlNK0dBSXdiZ0FiTm1JcnVOTHpkc25KSXZNSUdQVVVpckIwTE1uZC8w?=
 =?iso-2022-jp?B?clg2TlBZVDVYMk5TUkY3WXNkWHpoRTQ3QnNyTGVUZjQyTHFQdzlSNlRL?=
 =?iso-2022-jp?B?MldGWXl3UWQzNHpIQ2FlSmlPOHVvNy9iekQvalBDUm0ySlFQSERwVmpu?=
 =?iso-2022-jp?B?c3JCcWdnNU1ZN1lNYUVLMVBjZkJJZFBDRWh6WkxjSWVHb09nRlRWTnNp?=
 =?iso-2022-jp?B?cklCZkJ6OE1IMFBBZHVOMHJvMmNRNXh1Q0Ntb3pUV1U2ZC9uZ1RVYjk0?=
 =?iso-2022-jp?B?QjBwcFgvUVk1NmxyaWtlYVRDMEFScGIvSzMyOXEzbzBwWmMyYVExcklt?=
 =?iso-2022-jp?B?eUswWTQ4MlhwbzdTY0VNRExHcmtnSGxNUUFsT1FhVEFXdXppSmZCM3RH?=
 =?iso-2022-jp?B?a3d3ZEpSaTBmc3REbzVmdG43cGtYS1Vwb2pQcTlpUlZOWXdMVDBEVmVY?=
 =?iso-2022-jp?B?WnBsbERJWTRJZTJIeDEydEhzb2lwWktpZE1id3hzc21PdXduN2FLYnIr?=
 =?iso-2022-jp?B?TWFVTFQyQVdNZWVlMEJVcndMVi9Qa2lacGc0WHU4WkYyZFZIc1pyM3FJ?=
 =?iso-2022-jp?B?MGs3eW5TS1BJQXhPcHkyMGo0bGJUaUlHaVpwMUZuazREWng3MkMzenZp?=
 =?iso-2022-jp?B?NjhwbkthZTlPWTZCaEVtTVFZbVFjZHBrV0RyazV3QzI0THROb2c5V1RS?=
 =?iso-2022-jp?B?TVZFbnRsUmdCUGpRTWp1eW4wTWNYdW9JOGN4VjhpVnkzWHBQZDdlU3dt?=
 =?iso-2022-jp?B?WlhYWkk3dFl0alowRW13cTZjVnBVcW9OL0YyOWExajhxYUxSVEU4NkdN?=
 =?iso-2022-jp?B?RzFzS0RsTG5scHdMdmkrSVJkYWVJcC9GRmZFNTlZeERKZVM3U3NYejJm?=
 =?iso-2022-jp?B?eEFEOEtZUUlMV0cxTTM3RWdBVlQ0N3QrWFpJYVlFOGd1ZTBUeXpBaHF1?=
 =?iso-2022-jp?B?ZU52OGhDWVpDdUFVcHE0dGQyU2xJbHZvb3g5Z0gvZ0lBeFVLalhwTjlP?=
 =?iso-2022-jp?B?VGYzZ2hUaDIvSGNTOWFQTGxsaEN0QkFFUFV0RUZ0a3BDVHIzUExKTDVS?=
 =?iso-2022-jp?B?UytPd1pEST0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	1arnFq+tkO1fNrdEysCFR6TMUqLFd8edjjSFm9YA9ItBVbQnQu5qR15D+zZHF2W2jO7nC9hAlJJwGScrX25eWwMn/PjZma4yOIkbLnjRmKBy41BaHwa02PMLVqgfK2EMKh3ufcNYJg+2n7mcYZhfYCkDPNS1VrS0eOJsiLqgOkCMjQLoEfy+n1UcmCkazqkzx2eKrA6TDdAFfcUsED+TWHSWCEtPBmxNNYiU4NuqWI917Qh8EC/AOHD3bmmcyFX9/8OpTzWxxmOfUlr0FKW1jDAZ0Y7Ju6pt9QD6ekkin6cs4/ycEr2G87HQlpYxGNexcpoKdPI/Cl+J0CxQsxA/Ug==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB15746.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 662f0004-32a8-4176-aa7d-08df238e9b28
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 09:45:50.4733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T3PCXBeZfjx7L1abmdLcv134zqxdz0A9Ghy8l03jj9MJPfNPTLF06Hc4CaX0pSoFXzhwFRphAuAG9c3xo8e9axpgACTQeXS7DJ2VkKyj534=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8455

Hi Mark,

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
>=20
> How does this work when all of the following are true:
>=20
> * The S1 translation granule is 4K.
> * The S2 translation granule is 64K.
> * S1 has a 1G block translating VA x to IPA y.
> * S2 has a 512M block translating IPA y to PA z.
>=20
> In that case, can a "512MB mapping" exist for VA x? I would expect so.
>=20
> Assuming that is the case, the S1 translation granule doesn't matter,
> and the S1 workaround cannot depend on PAGE_SIZE_64KB.

Your expectation is correct. I confirmed that this erratum could occur in=20
that case as well (S1 1G block & S2 512M block). This is also affected by
GPT size. Therefore, the PAGE_SIZE condition needs to be removed.

> > Work around the erratum by issuing additional non-range
> > TLBI instructions corresponding to the affected VA or IPA
> > range-based TLBI operations.
> >
> > Signed-off-by: Tomohiro Misono <misono.tomohiro@fujitsu.com>
> > ---
> >  Documentation/arch/arm64/silicon-errata.rst |  2 ++
> >  arch/arm64/Kconfig                          | 19 +++++++++++++++++
> >  arch/arm64/include/asm/cpucaps.h            |  2 ++
> >  arch/arm64/include/asm/tlbflush.h           | 33 +++++++++++++++++++++=
++++++++
> >  arch/arm64/kernel/cpu_errata.c              | 10 +++++++++
> >  arch/arm64/tools/cpucaps                    |  1 +
> >  6 files changed, 67 insertions(+)
> >
> > diff --git a/Documentation/arch/arm64/silicon-errata.rst
> b/Documentation/arch/arm64/silicon-errata.rst
> > index ac3248b9f2f3..8ab6284e3d10 100644
> > --- a/Documentation/arch/arm64/silicon-errata.rst
> > +++ b/Documentation/arch/arm64/silicon-errata.rst
> > @@ -373,6 +373,8 @@ stable kernels.
> >  +----------------+-----------------+-----------------+----------------=
-------------+
> >  | Fujitsu        | A64FX           | E#010001        | FUJITSU_ERRATUM=
_010001      |
> >  +----------------+-----------------+-----------------+----------------=
-------------+
> > +| Fujitsu        | MONAKA          | E#030001        | FUJITSU_ERRATUM=
_030001      |
> > ++----------------+-----------------+-----------------+----------------=
-------------+
> >  +----------------+-----------------+-----------------+----------------=
-------------+
> >  | ASR            | ASR8601         | #8601001        | N/A            =
             |
> >  +----------------+-----------------+-----------------+----------------=
-------------+
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index b5a51b0ef944..38248a31d5f1 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -1312,6 +1312,25 @@ config FUJITSU_ERRATUM_010001
> >
> >  	  If unsure, say Y.
> >
> > +config FUJITSU_ERRATUM_030001
> > +	bool "FUJITSU-MONAKA erratum E#030001: Range TLBI may fail to invalid=
ate some entries"
> > +	depends on PAGE_SIZE_64KB
>=20
> As above, I strongly suspect this depends on the conbiation of S1 and S2
> sizes, and could happen regardless of whether S1 uses 64K.
>=20
> > +	default y
> > +	help
> > +	  This option adds a workaround for FUJITSU-MONAKA erratum E#030001.
> > +	  On affected FUJITSU-MONAKA CPUs, range-based TLBI operation
> > +	  targeting a VA or IPA may fail to invalidate some TLB entries
> > +	  for 512MB mappings. The affected instructions are RVA[L]E{1,2,3}*,
> > +	  RVAA[L]E1*, and RIPAS2[L]E1*.
> > +
> > +	  Work around the erratum by issuing additional non-range TLBI
> > +	  instructions corresponding to the affected VA or IPA range-based
> > +	  TLBI operations.
> > +
> > +	  The erratum only affects the FUJITSU-MONAKA on 64k pagesize.
> > +
> > +	  If unsure, say Y.
> > +
> >  config HISILICON_ERRATUM_161600802
> >  	bool "Hip07 161600802: Erroneous redistributor VLPI base"
> >  	default y
> > diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/=
cpucaps.h
> > index 76350b38f0d7..9220b917ec20 100644
> > --- a/arch/arm64/include/asm/cpucaps.h
> > +++ b/arch/arm64/include/asm/cpucaps.h
> > @@ -66,6 +66,8 @@ cpucap_is_possible(const unsigned int cap)
> >  		return IS_ENABLED(CONFIG_ARM64_ERRATUM_3194386);
> >  	case ARM64_WORKAROUND_4193714:
> >  		return IS_ENABLED(CONFIG_ARM64_ERRATUM_4193714);
> > +	case ARM64_WORKAROUND_FUJITSU_030001:
> > +		return IS_ENABLED(CONFIG_FUJITSU_ERRATUM_030001);
> >  	case ARM64_MPAM:
> >  		/*
> >  		 * KVM MPAM support doesn't rely on the host kernel supporting MPAM.
> > diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm=
/tlbflush.h
> > index 14a78ac0f800..0487daec1652 100644
> > --- a/arch/arm64/include/asm/tlbflush.h
> > +++ b/arch/arm64/include/asm/tlbflush.h
> > @@ -487,6 +487,37 @@ static __always_inline void __tlbi_range(tlbi_op o=
p, u64 addr,
> >  	op(arg);
> >  }
> >
> > +#ifdef CONFIG_FUJITSU_ERRATUM_030001
> > +static inline void fujitsu_erratum_wa(tlbi_op lop, u64 start, u64 end,=
 u16 asid)
> > +{
> > +	u64 addr;
> > +
> > +	if (!alternative_has_cap_unlikely(ARM64_WORKAROUND_FUJITSU_030001))
> > +		return;
> > +
> > +	/*
> > +	 * The erratum fails to invalidate TLBI entries in the range when
> > +	 * addr[34:29] =3D=3D all 1 && addr[28:0] =3D=3D all 0 for 512M hugep=
age.
> > +	 * However, since it cannot be determined reliably if the target
> > +	 * entry is hugepage or not here, always assume hugepage is used.
> > +	 * The workaround is to issue extra non-range TLBI ops corresponding
> > +	 * to the affected VA or IPA range-based ops in the range.
> > +	 */
> > +	addr =3D (start & GENMASK_ULL(63, 35)) | GENMASK_ULL(34, 29);
> > +	while (addr < end) {
> > +		__tlbi_level_asid(lop, addr, TLBI_TTL_UNKNOWN, asid);
> > +		if (addr + BIT_ULL(35) < addr)
> > +			/* overflow */
> > +			break;
> > +		addr +=3D BIT_ULL(35);
> > +	}
> > +}
> > +#else
> > +static inline void fujitsu_erratum_wa(tlbi_op lop, u64 start, u64 end,=
 u16 asid)
> > +{
> > +}
> > +#endif /* CONFIG_FUJITSU_ERRATUM_030001 */
> > +
> >  static __always_inline void __flush_tlb_range_op(tlbi_op lop, tlbi_op =
rop,
> >  						 u64 start, size_t pages,
> >  						 u64 stride, u16 asid,
> > @@ -518,6 +549,8 @@ static __always_inline void __flush_tlb_range_op(tl=
bi_op lop, tlbi_op rop,
> >  		__tlbi_level_asid(lop, addr, level, asid);
> >  		addr +=3D stride;
> >  	}
> > +
> > +	fujitsu_erratum_wa(lop, start, end, asid);
> >  }
>=20
> It would be much simpler to say range invalidation doesn't work on this
> part.

Disabling range operations on MONAKA CPUs would be another solution.=20
We'd like to select the option that minimizes the performance impact.
Since the PAGE_SIZE condition has changed, I will check the performance
impact of this erratum (including on a 4k kernel).

>=20
> >
> >  #define __flush_s1_tlb_range_op(op, start, pages, stride, asid, tlb_le=
vel) \
> > diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_err=
ata.c
> > index 8ec47d89b45b..5b9dea3c761d 100644
> > --- a/arch/arm64/kernel/cpu_errata.c
> > +++ b/arch/arm64/kernel/cpu_errata.c
> > @@ -1027,6 +1027,16 @@ const struct arm64_cpu_capabilities arm64_errata=
[] =3D {
> >  		.matches =3D has_impdef_pmuv3,
> >  		.cpu_enable =3D cpu_enable_impdef_pmuv3_traps,
> >  	},
> > +#ifdef CONFIG_FUJITSU_ERRATUM_030001
> > +	{
> > +		.desc =3D "FUJITSU-MONAKA Erratum E#030001",
> > +		.capability =3D ARM64_WORKAROUND_FUJITSU_030001,
> > +		ERRATA_MIDR_RANGE_LIST(((const struct midr_range[]) {
> > +					MIDR_ALL_VERSIONS(MIDR_FUJITSU_MONAKA),
> > +					{}
> > +				})),
> > +	},
>=20
> Are you expecting to add other parts here?
>=20
> Is there a (future?) revision of MONAKA with this fixed?

There is currently no plan of fix for this part.

Thanks for the review.
Best Regards,
Tomohiro Misono

>=20
> Mark.
>=20
> > +#endif
> >  	{
> >  		.desc =3D "Known broken GICv3 SEIS implementation",
> >  		.capability =3D ARM64_WORKAROUND_GICv3_BROKEN_SEIS,
> > diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
> > index 2775ba3359cf..50a9aa0e2bf0 100644
> > --- a/arch/arm64/tools/cpucaps
> > +++ b/arch/arm64/tools/cpucaps
> > @@ -132,3 +132,4 @@ WORKAROUND_REPEAT_TLBI_SYNC
> >  WORKAROUND_SPECULATIVE_AT
> >  WORKAROUND_SPECULATIVE_SSBS
> >  WORKAROUND_SPECULATIVE_UNPRIV_LOAD
> > +WORKAROUND_FUJITSU_030001
> >
> > --
> > 2.43.0
> >
