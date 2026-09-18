Received: from fra-out-010.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-010.esa.eu-central-1.outbound.mail-perimeter.amazon.com [63.178.143.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2F42C11F3;
	Fri, 18 Sep 2026 20:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=63.178.143.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789762921; cv=fail; b=NxTPO+CrLoekpk5EzBWjreyj1Mwh3JVg09zRpx9gwOGGwBK7Lv4dM1KNWGYoTzdJc01C190+5byag6WcGJN6i4fjLwf2/Qo8HOOgGLmls2o5MXPCqtQLdLhpP8JwZkJphq6t8+JF4vGqIQ69DMZN9i8DbvSp+pFKroh6YYIgpqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789762921; c=relaxed/simple;
	bh=tE/yXCoh/zaujm8eUzqAbq4eGuT363zrKKAVsgN9wfo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qPZhxHPoqDMFmDgG9ZzWLRsgB4p7ffppMFCiaD6lUVEl62ubbUyNZpgzAqP0iHZs1W/RAp0CH1eDgpxi2VK7RAGKqEUA6s+Sqk9J8/yRGPXBl8ESdIdWpO1NqrXxhbw2eSVAHvUtC3LhW9FiCUJ89GLH/ifudKYGPNJ4gnRE0MM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=D0UK+mP4; arc=fail smtp.client-ip=63.178.143.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="D0UK+mP4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1789762920; x=1821298920;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tE/yXCoh/zaujm8eUzqAbq4eGuT363zrKKAVsgN9wfo=;
  b=D0UK+mP4YK+/OIzgrQlRtaZxgn6j2+1En5Nr5OaUaoMDMxbc3FAcN7rJ
   AgSSojLVnkwHCxS3USd3yFOs1vhkhXarF3o9+APW/UXAc0nGoLvPllGBN
   EJAZJLdJl0j+KoIkTgR5TiJ98EJIqnbkLeGewZhp/cHZoNYv1psCSmbw3
   kHm9aujIC7oB/bK5rK1A+NdO2it155ms1O9miK2q9M4qQGJNDx14PO9w2
   IWRJOlykRmx8jGvpENMBgSqSK8w6duHvaSlOEExcZKTEbcis5G/ENRXgU
   SE/quw4udGqj2l8XxTY9CMcXqjAT9qHxsLk9+EFUETgc6TQK9vxgegxGa
   w==;
X-CSE-ConnectionGUID: iCs5qX+5TdqZC/+95p598g==
X-CSE-MsgGUID: Yc1OogGsQUeWhfXV9EscbQ==
X-IronPort-AV: E=Sophos;i="6.27,109,1787011200"; 
   d="scan'208";a="19664337"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-010.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 20:21:55 +0000
Received: from EX19MTAEUA001.ant.amazon.com [54.240.197.233:11535]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.26.217:2525] with esmtp (Farcaster)
 id 407b07f4-1a0b-492d-9ce8-fbf3203844cf; Fri, 18 Sep 2026 20:21:55 +0000 (UTC)
X-Farcaster-Flow-ID: 407b07f4-1a0b-492d-9ce8-fbf3203844cf
Received: from EX19EXOEUB002.ant.amazon.com (10.252.51.83) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46;
 Fri, 18 Sep 2026 20:21:54 +0000
Received: from FR6P281CU001.outbound.protection.outlook.com (10.252.51.199) by
 EX19EXOEUB002.ant.amazon.com (10.252.51.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46
 via Frontend Transport; Fri, 18 Sep 2026 20:21:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VWGWiA9iQOvDAPLMyCa/KL+rb+D9sxG4oBS3zCNcDPtg5Jkdzw0bj2M5rC99yEm6/u/SAh/LMW+4ojS7pZP9qB7T5C8gjJwwBlmzSy9BMc/z7knAzqdQiYJ+u6x0dLo7JAJwxIGEN8m127cz4FjZHz4+sW9hcMgSNM0SB8nevM4x6RrPxql3ghg1IjNNkCRQTQxgw33HlSotZrhbvQzaNfnCCDMByHRGGRhI5j3neuAqqdUf7HZ+yhyDAYiB9svlh5/XHwpCwL9BooreRdniNmsxSYvgzIgrVMhKgLxGKkzqjB8Yz8QWpN1CYIV48DmymJhAEs2/Bfc6Zg1x7BpOug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tE/yXCoh/zaujm8eUzqAbq4eGuT363zrKKAVsgN9wfo=;
 b=QnBrKjTdqBW0n1EALJiwg5a/lsX4FUN+Vg5ybt8LyNEznxfzcql6QMt5H34AcxhtUf+Sc04U3WoNCxgjG/gJtUTyx1U4q5oRB7wziGl4o51o1Vq9cNimME9rhVfZb2MfCOb7bqoT4vldranD4rLdbYRed5uVE7hBAyvEonD4jGOMa6NkbVNqerTmA72VkeQ0UQesCZvy2bbXhRI4cEFE3vyc2cAt1W/N02R1aFess76ciMPqjze5NZdoO2hHqAk7hypJMWlm589RbMF+wnpozZgut3NI2dv9NqOEP7s8mb2zwfl0BUMHcmNsz4h/QkvOxQ1z1G6Fz+GK4fK0lI1+uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.de; dmarc=pass action=none header.from=amazon.de;
 dkim=pass header.d=amazon.de; arc=none
Received: from FR6P281MB5787.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1bf::23)
 by FR3PPF317299CA9.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::125) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.14; Fri, 18 Sep
 2026 20:21:47 +0000
Received: from FR6P281MB5787.DEUP281.PROD.OUTLOOK.COM
 ([fe80::1c27:e30e:1c73:ccd8]) by FR6P281MB5787.DEUP281.PROD.OUTLOOK.COM
 ([fe80::1c27:e30e:1c73:ccd8%4]) with mapi id 15.21.0428.014; Fri, 18 Sep 2026
 20:21:47 +0000
From: "Absandze, Luka" <absandze@amazon.de>
To: Sean Christopherson <seanjc@google.com>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "sandipan.das@amd.com"
	<sandipan.das@amd.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KVM: x86/pmu: Don't retry a counter whose config was
 rejected
Thread-Topic: [PATCH] KVM: x86/pmu: Don't retry a counter whose config was
 rejected
Thread-Index: AQHdR6tUBNYIl8ZKWEWX6otKvFBcwA==
Date: Fri, 18 Sep 2026 20:21:47 +0000
Message-ID: <aq2ZCFXMDnUWwCuY@dev-dsk-absandze-1c-663c31a8.eu-west-1.amazon.com>
References: <20260918160006.61816-1-absandze@amazon.de>
 <aq1j0aUKpr15AiqS@google.com>
In-Reply-To: <aq1j0aUKpr15AiqS@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR6P281MB5787:EE_|FR3PPF317299CA9:EE_
x-ms-office365-filtering-correlation-id: 8ae06ed2-8fd4-42b5-3b6e-08df15c2771a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|38070700021|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: IYMhmtZO/EtgXQtjt2Mm0r5bjTHgyBF1PTdn9i79zMkuSOk5kFizKUcPJyr5SMjph+wL1jc2ovJY8pyT9Kfzud06i87MNdtx3KEws6z7mehEgSwFE9tPpmb8eIoJ1mVR4WRQKKm822WaHn1b4Bs4gCahbIMm7LrQpL5aVMss+WkkrosPMrE7l23XEDfLflynXIOQxRgOkzPl/80hV1MPVwEPKuK4cTVCfAOUO5d94KvJmDKjT5VsRd3rGbdCpu2yQGBAXEW1Oxbn5fKTUnTdRI3LA6J6DeGKgMe4KMasZ+e1ktOi7B9WrJeFVWo8jZ/03ppwFuS47z1gj1ZTKCJNHoKvkDLHjH3d+Y8jgP+WSyUBdcU8pnkIcnYmSCjuh9beDpO6IKNouV7LW6fj8OmSMFgsPxMw+jFrmVBonzj1yuEICd737H7sNZerLfkYTYlluAZTpBD2HTS1EJBKJcb2bTweveeW7+9NuAKlTTn7Ur2nhKA+bllXJIabOUSy2QoLAsnVT9b8RWF8rMEtKeBQ9B17cipDNjijFibGTCmdD1QtvPhrc6+VJZfQkL/hxccEaPtKZbhq3s/B6fdW3sxvmmj6KiMsPNakfHCH71bQ0uzQZME13cCPPr5iiBC7CqTnnw/wAvgJLZZuZM2LiuItWSS4s3XtSljMti4NRH/TkGIGl5mq//x0pQJzQxnRgh7DFORimPDUJKe8o5ey//0O2HAr71ZPz7D+OHL1pkoJBm8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR6P281MB5787.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWM2UTNUOVdqNjNLb0I5RFk2VWs5WUFpdmN6R2JKdzNFeGVWYkZ6ZWcvUjBw?=
 =?utf-8?B?NlMzVHB3bWREc3hvUm1oZFkzbFhzRndDYlNTa3FxQkRKUURudGEzRk9GZzUr?=
 =?utf-8?B?aWF3QWNoQkkyYkpraERpd1BKdlgvQmUxOVdVUVY5a1RFQysrRC9CSTRnN2NL?=
 =?utf-8?B?MUQvSWwvT3g1bVM4c1YxdURnSE9oNjBmaWN6eDgvR1FRQ1U0RVNhRkp3c3dW?=
 =?utf-8?B?ckdZVVpQMFhVbXVhZUlwUkhCcXZFdjN2Ym1Yc2x3YnUrZHFtaCt0eUxYSGYx?=
 =?utf-8?B?b2FmMzh4VzA2Q0x4Z3ZMYW5rMjdsUUNHdXBJSXdvUW1aOFJvb0V4aHI5LzFE?=
 =?utf-8?B?Z3prQVQ4M2V5ZHQrbHgzSHowaDdYU3ZPK1M4MWJwcmV4NVdrUHFGMU0rTDRk?=
 =?utf-8?B?Nis3aFUzUDFzVGt5YXlza1JBVGxWb3J6UzA5UlE5REZUNkp4WXI3NUg5dXZD?=
 =?utf-8?B?SkZWTjYzZ1UyT0lUV1pFYzU2Z2piZFdhZUgwbnl4NzVsSFlOL0hrcTNUNFRa?=
 =?utf-8?B?TCtDSjNIdWoyb2VLQWx6RERpaTFLOTlrNDhHT0NJTytycVZJMDZkeUJTZ2hG?=
 =?utf-8?B?cjZSZ0tiUitmazBvbi9oNksvc2d6NlkwWEU2Nm42QStHS1dmMEkvYjNWUEEy?=
 =?utf-8?B?Ylc5STR3WFdOalh0cEZrSlp2R0RzQXEyaFdYSTBxdzdTZkU0cE1ZdzZIN2NW?=
 =?utf-8?B?ek5FT0RaY0lMcmdDbk43ZlA1L0RVWGM2Z215QzRQYUltTXFNQnFBa3BYVWhs?=
 =?utf-8?B?S29JenhyRzlIRVV3M1lBR3cwblovUmJqbzd6QkVXUnVIWlV1LzI3endNUEI3?=
 =?utf-8?B?UU84UmppMFNIZnNJU2NLTkMwT2lhbEtnbG9LblFjSzIzQXdGc2FvK2VFUkQ4?=
 =?utf-8?B?Z0Q3UWdVckwrb1JBOEtDZExLQ1paam85ZHI1Q0FKbldjclh6ejA3alYyR0tB?=
 =?utf-8?B?SXVnSHFLT3BTM2NnTVk4bEFqKzlzQkg5dDQvM1I2Z1V4ek1UMGY2SkhUYnlx?=
 =?utf-8?B?VWcwRWtqMlVBTHNOMUhPRGRTeG5SZUxhWHpiekpIcUIvcW5lZCtRc1dUQ1FD?=
 =?utf-8?B?UHZYMzEweWQvQWJCTmVURjRpNy9CdmFNODJBdXlTRXQvbkdJWjhuQkZhVjNa?=
 =?utf-8?B?QW5PTlVJbGtCY0NzOHlYYTByTEVORmdaZkhHZ0YzaEJuRGMvTktENVFPcWFM?=
 =?utf-8?B?dVBTdkRHenhmaVJSWTlLVUVHR0xOekwreTlqWXVTZjdma2d4NkoxWmxVL2g4?=
 =?utf-8?B?M2N0bnBqMGNvazdaY2xBbjc1RVYrRURMVldzRzlsdXFIcy9vdHE4dWlLY2xE?=
 =?utf-8?B?MmhiVzBMZmhLMFJ0TTJmS1ducFF6WGVJamNrT2ZCYWhsRTNwQXFrN1M5QTRO?=
 =?utf-8?B?bXFQNjBueHl6cmh2SGQ5WCtsWTdCSVZ0R0RuTXpaSlFjQlBPdzlUY1dacWw0?=
 =?utf-8?B?aXFJeGYrcXpseEQ1L2ozaWdQY1RlcXJjdkVlbkROaVJXNTJRRzF2a2RNMUZM?=
 =?utf-8?B?VjFHWGF2dWs4bFVURnM3WlJJVWtXNnlJeTZXWndXTDlkc3Z2eHZiWU9uNk1p?=
 =?utf-8?B?V21YZFpZRWkyUENzWURTTWcycDhraC9ISGY1eXpSNTllTDMreVdXUkxKdnZx?=
 =?utf-8?B?bjFFYkdqQ1hEcnhVYnhtdmoxU3RLOCttVFFRaVhtZDZSTEJ6OHhpK0RFNFkr?=
 =?utf-8?B?RHJpVWFad0FySzE4eCtlQnlScC9OUmNkc3dNZHBVSHBoVkE3Z3hkSjlNbHcw?=
 =?utf-8?B?RXZETmhmMWxRZzdCd3VDdzViWGJvKzlPWmJTV0lGa3pxdGhDU0VxWGwxTkRU?=
 =?utf-8?B?c2w2ZWlBWnpyL3JSNjBJSHkrZUU0VzlXeXhDWjlDemlObmtPUE5SazBIQWl5?=
 =?utf-8?B?Ukxuc1dtUTRKaTNZSVNwT0txZFZ4VWdENm1hZzZIc0dCUFBpSzNnMDg4LzlY?=
 =?utf-8?B?bVltS2xkWWtsUXlvOVh6d0l4MmxWZXM1ZnpkMU9rQWNvNS9EaUpFam8vRFJL?=
 =?utf-8?B?QWJZa0xEeXJ4K3lyQ2FCRFlCQkJtS1VWci80T1crV0FsYVIwOHFPSTNhS3Fz?=
 =?utf-8?B?bHFVYk9SY2pmN2cydGpIbndLblRSQVU1RStNaVFkWEV4T1VVTVN1Q1VUeWpZ?=
 =?utf-8?B?Z2RSNnNLaGxwb01HMmJkRmNOMnduYjhlYkVzV1ZNditQbGJXWDl3K0hOcEN1?=
 =?utf-8?B?REZvR0pIK2JPaER5V21ZVGhZeXFUUnZLclo5UFhHeFE1VXhTWGtQUWdpeFB3?=
 =?utf-8?B?VmJsbGl0ZWlhYnNiK2oyOGU2K1A4Yzg4U0FSVEwyYWVJRWQ3MlVWQTM5emhC?=
 =?utf-8?Q?/lVB9HoYjVf1aJdy2y?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74EFD1A209E4504EB23361488CD95134@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Gv23XfqIXNsQWwDnwxdTH36rpLk+BAdChlo7I3IBX5DeSlsT8pdFpIzlIdfCp6Aw2mtNyaAi9LWHuy1D7mZZhZhctNC7GI0yk6dxUsXmfmRBMJPTnLrdXl7JnAknl6zLim9qTxzDEe5I7IwvWKaG1zdJdMIQiWfVtsx9OPmf9xUreM0VR/qnMfp+2N+EfxIL6YzewYZceJjB6XhvBtGgl8wF1AVZPX8qoVwhPTUeS1+yPUdqMwkTire72fyiTymw0agkI2hOHtJjuk8+F1mANyibuycBckI6mqRFX6kC9PNXtvXaPq+fkddIkp0UG07HegjSvsYXMT39kUUbvYSk3Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR6P281MB5787.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae06ed2-8fd4-42b5-3b6e-08df15c2771a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 20:21:47.5455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6ePzYQYWjwD1O2nf42VzEKm+Mc68Bc6AJxsnmOz7t4EH6UHXaxAqt36AOekqWkQXWjXW2Ykg1Eozr678+Gvdeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3PPF317299CA9
X-OriginatorOrg: amazon.de

T24gMjAyNi0wOS0xOCAwOToxNiwgU2VhbiBDaHJpc3RvcGhlcnNvbiB3cm90ZToNCj4gSG1tLCB3
b3VsZCBpdCBpbnN0ZWFkIG1ha2UgbW9yZSBzZW5zZSB0byBleHBsaWNpdGx5IGNoZWNrIGZvciAt
RUJVU1k/ICAtRUlOVkFMDQo+IGlzbid0IHRoZSBvbmx5IGZhdGFsIGVycm9yIGNvZGUuDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva3ZtL3BtdS5jIGIvYXJjaC94ODYva3ZtL3BtdS5jDQo+
IGluZGV4IGE3ZDYwYzg3ODVjZC4uNTI5NmVlOGYzMmFmIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4
Ni9rdm0vcG11LmMNCj4gKysrIGIvYXJjaC94ODYva3ZtL3BtdS5jDQo+IEBAIC02ODEsNyArNjgx
LDcgQEAgdm9pZCBrdm1fcG11X2hhbmRsZV9ldmVudChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpDQo+
ICAgICAgICAgICAgICAgICAgKiBQTVUgcmVmcmVzaC4gIERvbid0IG1ha2UgYSBuZXcgcmVxdWVz
dCBhcyBkb2luZyBzbyBjYW4gc3RhbGwNCj4gICAgICAgICAgICAgICAgICAqIHRoZSBndWVzdCBp
ZiByZXByb2dyYW1taW5nIHJlcGVhdGVkbHkgZmFpbHMuDQo+ICAgICAgICAgICAgICAgICAgKi8N
Cj4gLSAgICAgICAgICAgICAgIGlmIChyZXByb2dyYW1fY291bnRlcihwbWMpKQ0KPiArICAgICAg
ICAgICAgICAgaWYgKHJlcHJvZ3JhbV9jb3VudGVyKHBtYykgPT0gLUVCVVNZKQ0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICBzZXRfYml0KHBtYy0+aWR4LCBwbXUtPnJlcHJvZ3JhbV9wbWkpOw0K
PiAgICAgICAgIH0NCj4gDQo+IFRob3VnaCBJIGd1ZXNzIG9uZSBjb3VsZCBhcmd1ZSAtRU5PTUVN
IGlzIGFsc28gdHJhbnNpZW50Pw0KDQpJIGhhZCBjb250ZW1wbGF0ZWQgdGhpcywgYnV0IGNvdWxk
IG5vdCBjb252aW5jZSBteXNlbGYgYXQgYSBnbGFuY2UgdGhhdA0KcGVyZiBhbmQgS1ZNIGFncmVl
ZCBvbiB3aGF0IGNvbnN0aXR1dGVkIGEgdHJhbnNpZW50IGVycm9yLg0KSSBoYXZlIG5vdyBjb25j
bHVkZWQgSSB3YXMgc2VlaW5nIGdob3N0cyA6KQ0KDQo+IEUuZy4gdGhpcz8gKGNvbXBsZXRlbHkg
dW50ZXN0ZWQpDQo+IFtkaWZmXQ0KDQpUZXN0ZWQgYWdhaW5zdCB0aGUgZmF1bHQgZGVzY3JpYmVk
IGluIHRoZSBsaW5rZWQgcGF0Y2ggYW5kIHNlbGZ0ZXN0cyBvbg0KQU1EIFplbiAzIChhbHRob3Vn
aCBJIGRvbid0IHRoaW5rIHRoZXJlJ3MgbXVjaCBjb3ZlcmFnZSBpbiB0aGlzIHJlZ2FyZCkuDQoN
CklmIG5vIG90aGVyIG9iamVjdGlvbnMsIHdvdWxkIHlvdSBiZSBmaW5lIHdpdGggdGFraW5nIHRo
ZSBkaWZmIHlvdQ0KcHJvdmlkZWQgaW50byB0aGUgdHJlZSBvciB3b3VsZCB5b3UgcHJlZmVyIGEg
djI/
