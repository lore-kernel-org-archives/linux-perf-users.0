Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8809010E4;
	Mon, 24 Feb 2025 18:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740423489; cv=fail; b=hlPVuzdXgImDbXfqSQRdq5LCPYigmpDjrSJ0iMbkmbWdZx69aQ7mR8q/nB+dQ4BcBgSJplswdpaRe6Er6n40QhXNdlKEINfJeb6yW2I01PELB1Iz5I9UqjXmIMM853IvkVDllxhZviGeb3jyGG2LaswkYhzUnICjqfNxZiZK7DU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740423489; c=relaxed/simple;
	bh=cz0eez/HLoZb0MZThGnnh0GVdYtMVAO71cDLgVA2598=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FSl3bfpeov87TdZ0nvGdrRyzlEAsr7Rwsm78AFxCiwBVfAOiDMGx8nkxVGuSky+DZbKvWZXlWcx7VtBDrjVsuT1UMYBQ1hSKKe2LpTaMA3UcPRaT8uACC5UpdJuvU0HvRMsuNTJeDXqcyvW8ECcjnMOn5XPGojGK0JfiAUf5bvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ffuk0GWe; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ffuk0GWe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740423488; x=1771959488;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cz0eez/HLoZb0MZThGnnh0GVdYtMVAO71cDLgVA2598=;
  b=ffuk0GWem1OOnNRAaEQ47C5t3b7lB5OqJi35EN+M8gwOtxlj1NLdqzTl
   H38t+scUJVWTg+rY1paLyuLWO3bP9hOsWeIfdmMWuR5vSXjnXXvAcTZo0
   /CLhmW+j/LDwjCP0cYdVfRwbGLvEBTdjB3vcEhWy2EeprWccotl7MC7ju
   B/lb2yptODgQRjmL1vb+BpMt1Q1wRAtxHaDsYR0KwlD3GNewkd0H4Yph/
   cHWalIC6/2qQ5hrFpNrnx/QGX1i2xxpQgwTASSu4XHmSi/eOT6AT7OMga
   K3Hi5RRhOwksmLY0CH+Y7EwTF2jG55FOBcmJr/PdNPwWTZIjvUQav+S+H
   w==;
X-CSE-ConnectionGUID: PkjywkJcT1+K58vbCkA8ZA==
X-CSE-MsgGUID: 5Vl+t4/RTryph8cd0s69MA==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="41107525"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="41107525"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 10:58:06 -0800
X-CSE-ConnectionGUID: Z4X9Fr5XRsak62j2+jy9xg==
X-CSE-MsgGUID: DNcMEjM1RkSpqTGZM5B2Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117056796"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Feb 2025 10:58:06 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 24 Feb 2025 10:58:05 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 24 Feb 2025 10:58:05 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 24 Feb 2025 10:57:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h0gWtqIuW7mOdyjPlU/e1CEAwzx8Jx82AqNDetmu4X8c/8reSQDEkCq9+f5w80GDa568iKo4pnuvpsYlqpvVOINDP48iGOk63PdyZU6RGgZaBE1efFmTZnTa8mm1TxmZ12apfCD2u7jScxfup55UCqkTAZ2P16WlNZOUf3kZhoE7/hM95W+AFgSYj4pXJK82UTn5/KSa9zW5McRpuwhmWSk/3sn2DuYHhxs6LMCLSOocFCyq9f9cVJvMMvJhBEpNDbEAai3l2IFt3habeqqp/Xz9EbWvfmYUiQfQpLHLjpoWjSDBnZhNvMph9GD59dwZ6IVoGcKbrDo8gWpWdI2+Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cz0eez/HLoZb0MZThGnnh0GVdYtMVAO71cDLgVA2598=;
 b=lYVzZgfA7vMXVj5rphuseiQvNfgOvk6I8RBtsG4J9fc4o85gxE1enh6ndscAXk0jNtBx8BThKeBh4lku9EWmYvSxArqu78kWGyaboNn+lyF72VGlNe2z1DJ32vjBVkXElRk8eL936I2v/0vQqeV79Jx0WWFOO6YesurmbHWiMAibPFm4ctfVf/dgbmoOCR3c7Y9pnRdmSdfFYLtPk/yr82st4N6ulzUdT4bY76oZE9VZMoR9R/+59CiChkmTvyTokH80PvorUCt+ZL9hvn0y7uxvRvab76tgR8V9OhaU9r6tCnNPrc6HwUFqkjhF6r1rCTrt1UwBwU0TO4y0vKYHuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by IA0PR11MB8301.namprd11.prod.outlook.com (2603:10b6:208:48d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 18:57:53 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 18:57:53 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "acme@kernel.org" <acme@kernel.org>
CC: "ravi.bangoria@amd.com" <ravi.bangoria@amd.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>, "irogers@google.com"
	<irogers@google.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"namhyung@kernel.org" <namhyung@kernel.org>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] perf script: Fix output type for dynamically allocated
 core PMU's
Thread-Topic: [PATCH v3] perf script: Fix output type for dynamically
 allocated core PMU's
Thread-Index: AQHbTamZDze70UJ9NUmcmPhnQ12s07LvjAKAgAAUmACAAAIHgIBnng4A
Date: Mon, 24 Feb 2025 18:57:53 +0000
Message-ID: <361703990c1518ec6dbe81d9e140dd4edf32e951.camel@intel.com>
References: <20241213215421.661139-1-thomas.falcon@intel.com>
	 <Z2XCi3PgstSrV0SE@x1>
	 <d730cfe63cdd46c137630d27de32e3b9c0ab6268.camel@intel.com>
	 <Z2XVhey0Xg5yYoQa@x1>
In-Reply-To: <Z2XVhey0Xg5yYoQa@x1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|IA0PR11MB8301:EE_
x-ms-office365-filtering-correlation-id: ff25f79b-3631-40cb-ce70-08dd550524a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SmtQbGdvOWV6WUJMSCtMWDlvcHIrYlRyK1JtSC83MzIxMmVnT2tCWFpicnJh?=
 =?utf-8?B?bVROdkJYSGlVaHlvL05RMlJpSFhGVE45SVZqaFB4WmNCc2lRT0FXUkp2UUpz?=
 =?utf-8?B?VXdBWWFSOTV1MkNsS2RsNkJXVDNwQ3NKcDJFYnFJeEhFZnNqaVpETG1uMndP?=
 =?utf-8?B?U2R5amhwK0ZxQllYSWEzTU1peVhsdy95aFdpeGFzSEhHcmFNRXZvRnpzbGhx?=
 =?utf-8?B?RytQcWh1R3hDeTBHTWRZdWlnRUVPRWY2QTFkcUdxYnY3a3ZNU1F4OWNaa090?=
 =?utf-8?B?dTJPbmVmbzAxcjkrbG9pb1hrWWdseVMvdFFTMDc2WkVVeUt1UHY3NkgzTU1J?=
 =?utf-8?B?NDRpTmUvQnFZL21YT3NabWxhNVlyOXFseVI2QU9sd1JwVkJSc3F2Q2VmSnFx?=
 =?utf-8?B?TkZQTkZoeGt3Yk9DYk9oQmp5ZnBaNUNRQ1Y5bzJuUGZuMVRORUtWcHJOekI3?=
 =?utf-8?B?N2lySHVKdkRXUnBHTHV3aVBTMXZ5ZHBMQThCVVlSRXc4WWpZTktObjVFNVRi?=
 =?utf-8?B?N1pvYjBtbVA3eWN2L0g2SlFVYmdZSEVsS0EvbmtoR09TZGZvV1grSU4vWkRU?=
 =?utf-8?B?S2d3aVU1Qldac1hkdVZoTDR0QXlmRlR2QTE4ZFdoY3FJSjN0bDJpV24vRnlR?=
 =?utf-8?B?dCtLZHRta0Vjemg2M2J3M0RNQTl2ZVBkRGd5ZjVxeitIQWZ6bFlWVHRJeHNV?=
 =?utf-8?B?R3VKUDYvS2wvYnQ3Mm9Td1pCWkpKaGd6WXBIbmE0djBjNG1SNHY1bW1sVE9N?=
 =?utf-8?B?d0tJTE5Kd21pSmpRYS9YVG1jTFBWZE9uMjVrV0VlZ1MyRTdCdzZNajh1ZUZk?=
 =?utf-8?B?TmhSOVA3ZnZ2ZXVmU3VKRk9XRFFKRm1wQmNteGhrNFRVZ2JTcTNTK2FWSGJw?=
 =?utf-8?B?YUlJVHNaNzJFa1l2R0QrWGFsWHJuMzU1QWhRZDVidHNBeG5rT1BFUE5XdHBY?=
 =?utf-8?B?akMzN2ZjSy9DcU1FVXdBVmZTS0NNTXhKVjlWaHQrejAvWWhLdENSVDFXVDJk?=
 =?utf-8?B?TWdhZGluOVZiUkg4REJzbE5nUVNuVWpmdmxOQkkvRjRxTlQ1ejhlR0oyWGg0?=
 =?utf-8?B?ODh2anFld2Nwb2hrdmFXY1NqVnJjVk5MTWtjT09KWGpNRlprSTQ1WEJRU3ll?=
 =?utf-8?B?ZUZZd2FHQkx0N284bWRISG5kdzlwb2lNa0N5VnExNUx1YkF1V21Gd0tPVW1D?=
 =?utf-8?B?L2NNSzYwUStsOW5ITEowNDFqR0V3eEhuOTlIQjNXR2tXbFgyV1lGRTZDSGJM?=
 =?utf-8?B?Uk9oYnFZNXE4aWZwNWQwT3VUMUFhOWYydkFVZWhaakgyRmNNSUs0OGFCR1ZJ?=
 =?utf-8?B?d1Q4enFyRFRTTkhZVnpOV3hvSkQwUmYrWjV4U3RNa1djcEo4dnNuK3Z3UUZZ?=
 =?utf-8?B?VzRnTENLQ290QmtHcG9qeHllQzdTKzZ6RFNJM2srWkZYTllFTTkyeEpLRThJ?=
 =?utf-8?B?ZkhDdE1GeTF0bDRVdTN3OVZqK2xBSUxGcGs4US94QlcyUW5uMU9ySmQ5aHB5?=
 =?utf-8?B?MUNGWThEVkV5cDIrUjlqUURuVkY0NWVURnhsbUhOK2tpL2NDU3c5cVYvRTFt?=
 =?utf-8?B?VTRUd0J3S1o5Z1dTYStDaGFXSDB2OGtMVUFOSlRGUnJLMWJ1WlZxMDB5bVp1?=
 =?utf-8?B?V0V2RllyUGF0Nkd5a296Q1Roa2tjNTFTVWxuZXJjaThpTm5vdDc2UVZoL1d4?=
 =?utf-8?B?UE5tT2F5Vm9WQ0pKbVhMVEM2Wmw1ZFRWRmQrd0RUNW8waTUwWDczaHJnN2Zz?=
 =?utf-8?B?VHU5eC8yWTNyVVFTVHJpTHFhS0lMSlM5WFV4UUZYRVhycFFFaEY0bzhmLzZa?=
 =?utf-8?B?NmRmam9WQTNLUEpqNE9LUGdUTEt4dzhTQm5LZXYxQWJUdjZWNFRranJQY1BG?=
 =?utf-8?B?THorWGxQY0Z5ZzZYZ2VnK2p6Tmg5ODRjNTZUNmxHa0FJWUtyWW1XMTMydFl3?=
 =?utf-8?Q?p2GDYIzo3BUYtpDduhRl1x4Ys5n86SlU?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVNxM2QvWmU5ZVlTVk1xVFZOYVZiRFNXR2hLejd1bStBTUFhb3pIQ0dkU2c0?=
 =?utf-8?B?MkJMSE9CaVpuUHpjdVRicDRuK2d0VmR3RDA2eWFMVDFhOFgrMS9NOHBJRFFk?=
 =?utf-8?B?b1RjblpsMzEzWndvTUVKWXowbWM0K1BHa0RLUFBqNU5ndktvbWpTVmpJZnJG?=
 =?utf-8?B?c3lHNWY0R2htNXRycitrM0xSY0t6dzlMdytIdlQyaDEwd05FQmZjVUI4ckcx?=
 =?utf-8?B?TjQ3WTU5YncycmU3VjdSQzlCRmdnaWt1bVFvb1RHaDhSVVFlMGFVS0FmcGVt?=
 =?utf-8?B?amR2RFBQamQrUkdUQnc3bG5Rb3RJWEEwNHdTU1VVcUFoQ1ZiVmxWNk1BRFhV?=
 =?utf-8?B?UGpYT1RjWUlDSDhSdVYxSGlvOEFGa01FZk1rZVJsSTFSdzBNTUFXTEpRb3A2?=
 =?utf-8?B?SlIza1ZaekJORWI5N2hCakdRRjVvcUFVY0FmM0s4OUR3cDBpZmI2eENCQWZp?=
 =?utf-8?B?SkFLRWUyUGd0VU1LVmtVZkxBeE1IZVB1UUxQMXNzN00xRVVVcHlBQzNjZHJO?=
 =?utf-8?B?ZEtkd0o0L0xHdnFQQnk3UVJUT3F4WHBMMnczbC9UMlZKOHpTZ1BGQXhyTnJB?=
 =?utf-8?B?ZUd6MERXRHJTT0pTSnRyU2JpdXVjSDJJckhoOFRnNW9YTzNiODdQKzlNaWlk?=
 =?utf-8?B?RWt1NSt2WWh3VURKbHZrQlJYNEt4MGZEQitPVXMxV1hBMlBzOXh1TzBTM2Ji?=
 =?utf-8?B?bFNYUjZ5S1kybG9kUkd0WHpzbFc1bkJpTXJnRW5jT0tHTlE0N0NHN2thNHZl?=
 =?utf-8?B?SEV1a2JXZ1JOWXlWVlp4Y0ZRVXQzMUxsSC9seWU2QWsvTG5RWmRrT3h1WXl3?=
 =?utf-8?B?UFNWMmVsaHpPaUl6U1ZpUnNXd1g3ZUM4dGlYSHplS2o2Q0ZtR2dyaitkTG10?=
 =?utf-8?B?VFR2anYxdFZuWUpSanBHMEMzdEhkdXpHcXk3MnlNTERraWlsemJwZWVxUHlk?=
 =?utf-8?B?TkRJREVtQ2VVS3puYnhzSWErbVFGSmhocllFK3NhN0xLOUFNMm9oWmN6Nkh3?=
 =?utf-8?B?M2J5VlFQSEp6WVdRQWJtS3g1NW9HdGUveFl6a3liNjFqV0VJRTcrdVB3VFFv?=
 =?utf-8?B?eEh2S0ZRUUdMUWFvM1FlTGNXWE05emVwOVBNdFVyclo2S0MyeENuKzg4SjVp?=
 =?utf-8?B?d1BSdWN1Q0hCMFVadG0vdTNXeEUwSFFTYUcvck1SaVEzOWFlYTBwSitOdWhM?=
 =?utf-8?B?VUhtVGorZ2NMWTRwbDBSSVJJUzFKSzdEWFJtS3pnWnBOTnoxeEg5UFV2THB5?=
 =?utf-8?B?THpwaHF5RUd1c3BzRXVVNWRKc3VmUTVMbmtWNEVBaHpKOHdFRm9UbkxQeXds?=
 =?utf-8?B?djFRZ2xSYWFnUFVPa1FWTG82YTd2YUtPMTFCZVZWRThmS2xtRXJJeG9hZGp5?=
 =?utf-8?B?QituZmg5anc4dFZBTFBPdWVzeFhJTzUvVUdJY3RwNmMvUysyYWdBYkZiWWxo?=
 =?utf-8?B?TU13Tk9HNU9ESTRyMmppL1dzeCtkT1pUKzMxMG01ZmR4VWtPTVlKZU0rNmxW?=
 =?utf-8?B?M24vNE1jUE1mUTlEaVJDdis3UXdoK2tMOVljNE1DK3JHdWEwV1Y1bE9SSGlO?=
 =?utf-8?B?WE4ycGczL1pULy9TdFFnaXowK1VYVmoxcDM0SUh4NndkU2dUZlZJNlB5cis1?=
 =?utf-8?B?ckFWVEFjS3FIMkg2WHBZRS91ZE5jd1RHLzYvN2dxUFJqZUhSVWpJQy94VjBZ?=
 =?utf-8?B?T0NyTjBMVDdHZXlYM29OZGY4emdLN1YxQjJsZzVLVExKVE55cWxic3h2VHRX?=
 =?utf-8?B?L0RlSTFTU2dMaVBvOFdPNVRVZTJtaHg4R0JNZnR1T1lOQjBLT25sMytIZnpn?=
 =?utf-8?B?YmhrcmVzYVd6Q1FleHlmSzJpMVJTWkxVWTNzbDVubWNPUlNoNnVrelpYMWV2?=
 =?utf-8?B?T1ZudnVQb1lTSW10d0F3M1I0Q2ovQnFWL25FT1JuNTRWY25tRWxsMyttczFh?=
 =?utf-8?B?MkYvSEJHRnRuTFpFTTdIbkx3NzBVQWVHM2p4Z2hzVjdNbVlsV2ZUKytGZmN6?=
 =?utf-8?B?Q3hhL20yek9xc0o4RGMvS1hicjNwWjVHSjIwS2RqdkE5WVd1dzBnSXRmcE9n?=
 =?utf-8?B?dElkRDg1UDcvVGlaTnJHUjlTZXFjYk02TUhRaW9XZk5Xd3NLclJiNEg3UFh6?=
 =?utf-8?B?YUNXbnhFN2ZiY2tsS3NqaDRzeG01OHNtc3lYMmhMbW95aVE2RnN6RE9MeVhK?=
 =?utf-8?Q?Sxm8hx4txvdFqtY1VNeh2WM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C8F24180C962C47A4D88970110D0565@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff25f79b-3631-40cb-ce70-08dd550524a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 18:57:53.4258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rOX7bVNjfUS/PENGKpA+ixeY38GzcY92/ZnT7SxQzcKieumUzMitDxErBsKIgdbgpmdK5POlYHTm9ScvC8yvlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8301
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTEyLTIwIGF0IDE3OjM3IC0wMzAwLCBBcm5hbGRvIENhcnZhbGhvIGRlIE1l
bG8gd3JvdGU6DQo+IE9uIEZyaSwgRGVjIDIwLCAyMDI0IGF0IDA4OjMwOjExUE0gKzAwMDAsIEZh
bGNvbiwgVGhvbWFzIHdyb3RlOg0KPiA+IE9uIEZyaSwgMjAyNC0xMi0yMCBhdCAxNjoxNiAtMDMw
MCwgQXJuYWxkbyBDYXJ2YWxobyBkZSBNZWxvIHdyb3RlOg0KPiA+ID4gT24gRnJpLCBEZWMgMTMs
IDIwMjQgYXQgMDM6NTQ6MjFQTSAtMDYwMCwgVGhvbWFzIEZhbGNvbiB3cm90ZToNCj4gPiA+ID4g
cGVyZiBzY3JpcHQgb3V0cHV0IG1heSBzaG93IGRpZmZlcmVudCBmaWVsZHMgb24gZGlmZmVyZW50
IGNvcmUNCj4gPiA+ID4gUE1VJ3MNCj4gPiA+ID4gdGhhdCBleGlzdCBvbiBoZXRlcm9nZW5lb3Vz
IHBsYXRmb3Jtcy4gRm9yIGV4YW1wbGUsDQo+ID4gPiA+IA0KPiA+ID4gPiBwZXJmIHJlY29yZCAt
ZSAie2NwdV9jb3JlL21lbS1sb2Fkcy1hdXgvLGNwdV9jb3JlL2V2ZW50PTB4Y2QsXA0KPiA+ID4g
PiB1bWFzaz0weDAxLGxkbGF0PTMsbmFtZT1NRU1fVU9QU19SRVRJUkVELkxPQURfTEFURU5DWS99
OnVwcCJcDQo+ID4gPiA+IC1jMTAwMDAgLVcgLWQgLWEgLS0gc2xlZXAgMQ0KPiA+ID4gPiANCj4g
PiA+ID4gcGVyZiBzY3JpcHQ6DQo+ID4gPiA+IA0KPiA+ID4gPiBjaHJvbWl1bS1icm93c2XCoMKg
IDQ2NTcyIFswMDJdIDU0NDk2Ni44ODIzODQ6wqDCoMKgwqDCoA0KPiA+ID4gPiAxMDAwMMKgCWNw
dV9jb3JlL01FTV9VT1BTX1JFVElSRUQuTE9BRF9MQVRFTkNZLzoNCj4gPiA+ID4gN2ZmZGYxMzkx
YjBjwqDCoMKgwqAgMTAyNjgxMDAxNDJcDQo+ID4gPiA+IMKgfE9QIExPQUR8TFZMIEwxIGhpdHxT
TlAgTm9uZXxUTEIgTDEgb3IgTDIgaGl0fExDSyBOb3xCTEvCoMKgwqANCj4gPiA+ID4gTi9BwqDC
oMKgDQo+ID4gPiA+IDXCoMKgIDfCoMKgwqAgMMKgwqAgN2ZhZDdjNDc0MjVkIFt1bmtub3duXSAo
L3Vzci9saWI2NC9saWJnbGliLQ0KPiA+ID4gPiAyLjAuc28uMC44MDAwLjMpDQo+ID4gPiA+IA0K
PiA+ID4gPiBwZXJmIHJlY29yZCAtZSBjcHVfYXRvbS9ldmVudD0weGQwLHVtYXNrPTB4MDUsbGRs
YXQ9MyxcDQo+ID4gPiA+IG5hbWU9TUVNX1VPUFNfUkVUSVJFRC5MT0FEX0xBVEVOQ1kvdXBwIC1j
MTAwMDAgLVcgLWQgLWEgLS0NCj4gPiA+ID4gc2xlZXAgMQ0KPiA+ID4gPiANCj4gPiA+ID4gcGVy
ZiBzY3JpcHQ6DQo+ID4gPiA+IA0KPiA+ID4gPiBnbm9tZS1jb250cm9sLWPCoCA1MzQyMjQgWzAy
M10gNTQ0OTUxLjgxNjIyNzrCoMKgwqDCoMKgIDEwMDAwDQo+ID4gPiA+IGNwdV9hdG9tL01FTV9V
T1BTX1JFVElSRUQuTE9BRF9MQVRFTkNZLzrCoMKgIDdmMGFhYWEwYWFlMMKgDQo+ID4gPiA+IFt1
bmtub3duXQ0KPiA+ID4gPiAoL3Vzci9saWI2NC9saWJnbGliLTIuMC5zby4wLjgwMDAuMykNCj4g
PiA+ID4gDQo+ID4gPiA+IFNvbWUgZmllbGRzLCBzdWNoIGFzIGRhdGFfc3JjLCBhcmUgbm90IGlu
Y2x1ZGVkIGJ5IGRlZmF1bHQuDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGUgY2F1c2UgaXMgdGhhdCB3
aGlsZSBvbmUgUE1VIG1heSBiZSBhc3NpZ25lZCBhIHR5cGUgc3VjaCBhcw0KPiA+ID4gPiBQRVJG
X1RZUEVfUkFXLCBvdGhlciBjb3JlIFBNVSdzIGFyZSBkeW5hbWljYWxseSBhbGxvY2F0ZWQgYXQN
Cj4gPiA+ID4gYm9vdA0KPiA+ID4gPiB0aW1lLg0KPiA+ID4gPiBJZiB0aGlzIHZhbHVlIGRvZXMg
bm90IG1hdGNoIGFuIGV4aXN0aW5nIFBFUkZfVFlQRV9YIHZhbHVlLA0KPiA+ID4gPiBvdXRwdXRf
dHlwZShwZXJmX2V2ZW50X2F0dHIudHlwZSkgd2lsbCByZXR1cm4NCj4gPiA+ID4gT1VUUFVUX1RZ
UEVfT1RIRVIuDQo+ID4gPiA+IA0KPiA+ID4gPiBJbnN0ZWFkIHNlYXJjaCBmb3IgYSBjb3JlIFBN
VSB3aXRoIGEgbWF0Y2hpbmcgcGVyZl9ldmVudF9hdHRyDQo+ID4gPiA+IHR5cGUNCj4gPiA+ID4g
YW5kLCBpZiBvbmUgaXMgZm91bmQsIHJldHVybiBQRVJGX1RZUEVfUkFXIHRvIG1hdGNoIG91dHB1
dCBvZg0KPiA+ID4gPiBvdGhlcg0KPiA+ID4gPiBjb3JlIFBNVSdzLg0KPiA+ID4gPiANCj4gPiA+
ID4gU3VnZ2VzdGVkLWJ5OiBLYW4gTGlhbmcgPGthbi5saWFuZ0BpbnRlbC5jb20+DQo+ID4gPiA+
IFNpZ25lZC1vZmYtYnk6IFRob21hcyBGYWxjb24gPHRob21hcy5mYWxjb25AaW50ZWwuY29tPg0K
PiA+ID4gPiAtLS0NCj4gPiA+ID4gdjI6IHJlc3RyaWN0IHBtdSBsb29rdXAgdG8gcGxhdGZvcm1z
IHdpdGggbW9yZSB0aGFuIG9uZSBjb3JlDQo+ID4gPiA+IHBtdQ0KPiA+ID4gPiB2Mzogb25seSBz
Y2FuIGNvcmUgcG11IGxpc3QNCj4gPiA+ID4gLS0tDQo+ID4gPiA+IMKgdG9vbHMvcGVyZi9idWls
dGluLXNjcmlwdC5jIHwgMTYgKysrKysrKysrKysrKysrKw0KPiA+ID4gPiDCoDEgZmlsZSBjaGFu
Z2VkLCAxNiBpbnNlcnRpb25zKCspDQo+ID4gPiA+IA0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvdG9v
bHMvcGVyZi9idWlsdGluLXNjcmlwdC5jIGIvdG9vbHMvcGVyZi9idWlsdGluLQ0KPiA+ID4gPiBz
Y3JpcHQuYw0KPiA+ID4gPiBpbmRleCA5ZTQ3OTA1Zjc1YTYuLjY4NTIzMjg4M2Y5YyAxMDA2NDQN
Cj4gPiA+ID4gLS0tIGEvdG9vbHMvcGVyZi9idWlsdGluLXNjcmlwdC5jDQo+ID4gPiA+ICsrKyBi
L3Rvb2xzL3BlcmYvYnVpbHRpbi1zY3JpcHQuYw0KPiA+ID4gPiBAQCAtMzg0LDYgKzM4NCwxOSBA
QCBzdGF0aWMgaW50IGV2c2VsX3NjcmlwdF9fZnByaW50ZihzdHJ1Y3QNCj4gPiA+ID4gZXZzZWxf
c2NyaXB0ICplcywgRklMRSAqZnApDQo+ID4gPiA+IMKgCQnCoMKgwqDCoMKgwqAgc3Quc3Rfc2l6
ZSAvIDEwMjQuMCAvIDEwMjQuMCwgZXMtDQo+ID4gPiA+ID5maWxlbmFtZSwNCj4gPiA+ID4gZXMt
PnNhbXBsZXMpOw0KPiA+ID4gPiDCoH0NCj4gPiA+ID4gwqANCj4gPiA+ID4gK3N0YXRpYyBib29s
IG91dHB1dF90eXBlX21hbnlfY29yZV9wbXVzKHVuc2lnbmVkIGludCB0eXBlKQ0KPiA+ID4gPiAr
ew0KPiA+ID4gPiArCXN0cnVjdCBwZXJmX3BtdSAqcG11ID0gTlVMTDsNCj4gPiA+ID4gKw0KPiA+
ID4gPiArCWlmIChwZXJmX3BtdXNfX251bV9jb3JlX3BtdXMoKSA+IDEpIHsNCj4gPiA+ID4gKwkJ
d2hpbGUgKChwbXUgPSBwZXJmX3BtdXNfX3NjYW5fY29yZShwbXUpKSAhPQ0KPiA+ID4gPiBOVUxM
KQ0KPiA+ID4gPiB7DQo+ID4gPiA+ICsJCQlpZiAocG11LT50eXBlID09IHR5cGUpDQo+ID4gPiA+
ICsJCQkJcmV0dXJuIHRydWU7DQo+ID4gPiA+ICsJCX0NCj4gPiA+ID4gKwl9DQo+ID4gPiA+ICsJ
cmV0dXJuIGZhbHNlOw0KPiA+ID4gPiArfQ0KPiA+ID4gPiArDQo+ID4gPiA+IMKgc3RhdGljIGlu
bGluZSBpbnQgb3V0cHV0X3R5cGUodW5zaWduZWQgaW50IHR5cGUpDQo+ID4gPiA+IMKgew0KPiA+
ID4gPiDCoAlzd2l0Y2ggKHR5cGUpIHsNCj4gPiA+ID4gQEAgLTM5NCw2ICs0MDcsOSBAQCBzdGF0
aWMgaW5saW5lIGludCBvdXRwdXRfdHlwZSh1bnNpZ25lZCBpbnQNCj4gPiA+ID4gdHlwZSkNCj4g
PiA+ID4gwqAJCQlyZXR1cm4gdHlwZTsNCj4gPiA+ID4gwqAJfQ0KPiA+ID4gPiDCoA0KPiA+ID4g
PiArCWlmIChvdXRwdXRfdHlwZV9tYW55X2NvcmVfcG11cyh0eXBlKSkNCj4gPiA+ID4gKwkJcmV0
dXJuIFBFUkZfVFlQRV9SQVc7DQo+ID4gPiA+ICsNCj4gPiA+ID4gwqAJcmV0dXJuIE9VVFBVVF9U
WVBFX09USEVSOw0KPiA+ID4gPiDCoH0NCj4gPiA+IA0KPiA+ID4gQ2FuIHlvdSBwbGVhc2UgdGVz
dCB0aGUgcGF0Y2ggYmVsb3cgc28gdGhhdCB3ZSBkb24ndCBkbyB0aGlzDQo+ID4gPiB3aGlsZQ0K
PiA+ID4gbG9vcA0KPiA+ID4gaW4gYWxsIGNhbGxzIHRvIG91dHB1dF90eXBlIHdoZW4gd2UgaGF2
ZSBtb3JlIHRoYW4gb25lIGNvcmUgcG11Pw0KPiA+ID4gDQo+ID4gPiBJIGhhdmVuJ3QgdGVzdGVk
IHRoaXMgcGF0Y2gsIHNvIHBsZWFzZSBzZWUgaWYgeW91ciBwYXRjaCBvbiB0b3ANCj4gPiA+IG9m
IGl0DQo+ID4gPiBwcm9kdWNlcyB0aGUgZGVzaXJlZCByZXN1bHQuDQo+ID4gDQo+ID4gSGkgQXJu
YWxkbywgaXQgbG9va3MgZ29vZCB0byBtZS4NCj4gDQo+IFRoYW5rcywgYWRkZWQgYW4NCj4gDQo+
IEFja2VkLWJ5OiBUaG9tYXMgRmFsY29uIDx0aG9tYXMuZmFsY29uQGludGVsLmNvbT4NCj4gDQo+
IFRvIHRoYXQgY3NldCwNCj4gDQo+IERvaW5nIHNvbWUgdGVzdCBidWlsZCB0ZXN0IGFjY3Jvc3Mg
YSBudW1iZXIgb2YgZGlzdHJvcyBub3csIHdpbGwgcHVzaA0KPiB0aGF0IG91dCBhbmQgdGhlbiB0
cnkgdG8gc2VlIGlmIHlvdXIgcGF0Y2ggYXBwbGllcyBjbGVhbmx5IG9yIGRvIHRoZQ0KPiBhZGp1
c3RtZW50IHRvIGFwcGx5IGl0Lg0KPiANCj4gLSBBcm5hbGRvDQoNCkhpIEFybmFsZG8sIHdlcmUg
eW91IGFibGUgdG8gYXBwbHkgdGhpcyBwYXRjaD8gSXMgdGhlcmUgYW55dGhpbmcgeW91DQpuZWVk
IGZyb20gbWU/DQoNClRoYW5rcywNClRvbQ0KDQo=
