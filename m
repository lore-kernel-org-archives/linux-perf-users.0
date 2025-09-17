Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B302F39D0;
	Wed, 17 Sep 2025 18:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758132172; cv=fail; b=M0P3WsE/HtkJjgmwIhNQy8/aQbn+8lBexetEOWOBpIAxOOfJ4WAnidNXQnH71oMVO2RXCsLU8EdlUKeAFDlj5UBSB1gOjkL1BCQJpH0ywpL9haskL5ed4+ymTHqi45JD7lM1ZFDpqy3Yx1nj9XVBPywvC6GuRxZHjwV5X9Qk8OI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758132172; c=relaxed/simple;
	bh=nVot5jynkGF9gTDsEnSLrGw1fB5K9eswMSgH4zWgzQU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bFsAQXnKlg8BwNpvuTbKCeaQySiyOQk1B0TQqUvWI9zfsEVeA3SPGF5gIvI4PijQg0uQ20QuuvDeCsOQLJk6Fvo6Vrn8vruWHngoOAtskanqTpB3ejEw1LXKBsb3l6rZxa/G6FPLw8ZFfWd8dSuQjH92OIhaEwqONJICvC+vBFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UxdojAWJ; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UxdojAWJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758132170; x=1789668170;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=nVot5jynkGF9gTDsEnSLrGw1fB5K9eswMSgH4zWgzQU=;
  b=UxdojAWJJQkZt7y8MVZHX+LjhGd/6W0NdX2NOjOZQXYr6dLsUr9zcLdM
   +fAZXv5XHgxM25J9Rwlr3GZzHSjrz0Lm0ebC5SRvU2kqM5orL8gyTyfql
   JrY/upRVKOSiEIyWBzvLOreiEV6OkRTrcgwEsZDoHsE7ovxlN7uyPyi6t
   CPoXAriiiH1croHD0qKAcnd4QbUhPx8N3W9HMvGYqFietYz8lbB25VAga
   G4l01OAQoOdIdUJstldUM0plvtp10K9QRN/b/p4iYyPSYarKcY7zX+44h
   K9ZBPJYyeKtxzURSq3KwSBcaRk6pDFVmbMkUroBZWdBeIzT1PdXJ5BPqc
   w==;
X-CSE-ConnectionGUID: sGWEGUhSSdKYBcwbwb/lrQ==
X-CSE-MsgGUID: RZ6ItfskSqeYDeaO/w29yA==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="71131488"
X-IronPort-AV: E=Sophos;i="6.18,272,1751266800"; 
   d="scan'208";a="71131488"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 11:02:49 -0700
X-CSE-ConnectionGUID: OADrT0SBS5GYrRYAtvBduQ==
X-CSE-MsgGUID: gJWMTuDjRt+5Gf8K1vXNBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,272,1751266800"; 
   d="scan'208";a="175231076"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 11:02:49 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Sep 2025 11:02:48 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 17 Sep 2025 11:02:48 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.27) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Sep 2025 11:02:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E20hmq/63p2rEm89n9yLM4FfxBAxTD6een9ijDVasT9//Ku1CruPifyON93debHKb6iOeNNhuJuMmlD6sBqfYp0Ig8OAb/B8V8Tpbx7ZGLMgiHb+Tn5SMat4iQdExo05gceJFfHoCGO1XiUk4FSZamjJsiCvcf43IEevx3PaVUWQmGIqnW/c/9JAkTFb9cnhpyu2Q6WZOpr/l8h7/ip6ZAtDNIAvyKKTigTg6uS44XpzYHsyrfnmSggaVBs1+tmByxwK9rI5egwcRWy1+0X4g9i6Yqu4bvrzqAdRF9C/lnt4u8ngGFGeWw3GoJFiMqAQWza8ANFFSGoMe/aV8gMQ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVot5jynkGF9gTDsEnSLrGw1fB5K9eswMSgH4zWgzQU=;
 b=LjF1Ia+K10jKqg6I2pHFcZlDrWJqrQeLbAjxQgSH2M5AT/lOOHBiQ2HYqvjLneOfHkvPNjPGcGx7ZnefJhi5sKn2VX15Ejey5rKanmW0ONyOKr9csi5b1NGXEgwadPzTMEn5fqEwVf+MuI+u3ET0vFczjzXsEt5qsGPWXA1covJkE0xKotI77dHLaKnOeAt9/EPrvge9/5mWntrlPV75/ciVN+Z1rLfHsm+8+yXu604kmH+nPSVkNM5i+kHRj9QJm46jXZM+BDHH/mHp1J+DC+Upecp7oSAZZJaRZccwm1Riyo3GEpUSoZ75zgVRqH+T+Oco2FNFp+tc1lFbjyycbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by SJ0PR11MB5007.namprd11.prod.outlook.com (2603:10b6:a03:2d2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 18:02:45 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b%3]) with mapi id 15.20.9115.017; Wed, 17 Sep 2025
 18:02:45 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "Baker, Edward" <edward.baker@intel.com>, "Wang, Weilin"
	<weilin.wang@intel.com>, "alexander.shishkin@linux.intel.com"
	<alexander.shishkin@linux.intel.com>, "xu.yang_2@nxp.com"
	<xu.yang_2@nxp.com>, "Biggers, Caleb" <caleb.biggers@intel.com>, "Hunter,
 Adrian" <adrian.hunter@intel.com>, "Taylor, Perry" <perry.taylor@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "irogers@google.com"
	<irogers@google.com>, "sandipan.das@amd.com" <sandipan.das@amd.com>,
	"james.clark@linaro.org" <james.clark@linaro.org>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "john.g.garry@oracle.com" <john.g.garry@oracle.com>,
	"bgray@linux.ibm.com" <bgray@linux.ibm.com>, "Alt, Samantha"
	<samantha.alt@intel.com>, "renyu.zj@linux.alibaba.com"
	<renyu.zj@linux.alibaba.com>, "acme@kernel.org" <acme@kernel.org>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "namhyung@kernel.org"
	<namhyung@kernel.org>
Subject: Re: [PATCH v6 05/22] perf jevents: Mark metrics with experimental
 events as experimental
Thread-Topic: [PATCH v6 05/22] perf jevents: Mark metrics with experimental
 events as experimental
Thread-Index: AQHcHVb+P9O8JTPAbU21wdcOrgi33rSXv9mA
Date: Wed, 17 Sep 2025 18:02:45 +0000
Message-ID: <ef20fc6501c57d932024ad31323f90165caeae28.camel@intel.com>
References: <20250904044653.1002362-1-irogers@google.com>
	 <20250904044653.1002362-6-irogers@google.com>
In-Reply-To: <20250904044653.1002362-6-irogers@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|SJ0PR11MB5007:EE_
x-ms-office365-filtering-correlation-id: 9f12d303-4519-41a6-e46f-08ddf6146771
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003|921020|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?WTU2Q0hoWFNmN002WGJZNDhKdSszcCtRV3A0QzFWNHJZVGRjQjJLUHVKcTBU?=
 =?utf-8?B?TWNHbWgyRkdaS0ZIc2Y0WUoyeDVXZFY3MEorY2J4ZlpmaUNhS09scXVzU3lH?=
 =?utf-8?B?bzZTOFovN2FVaWFvV1AzQVhjdUhHZUw2czFPeTFpaW9EOG5nUnp4YzdyNmo5?=
 =?utf-8?B?Zm15eFMwWXk1d0g4MGZMZGt5WXNBLy9lSCt1cTRkVER0V29uY1UzVDFScnFK?=
 =?utf-8?B?c212cnhJUGxwelNOM1pKc2xGS3BJOEdzcFA4VlpzaklJUUFYc3VueEZEaWIx?=
 =?utf-8?B?c25sUERTZEQxNy9vSU9hdTFPWTV4QU9GZ0kyM0h1cVlFQm5FdDZscVA1OEFl?=
 =?utf-8?B?RjdJZmRKMVBzYWhHVW45elVhdE9PRlpMTzVoRVdFUWVpL09IdWJ6RVdzNVQ1?=
 =?utf-8?B?UEhOV2ZxTXgxWEVSM29xVnhoUkh2RlJwT0YzaDVrKzNtV08zK3Y1TjR4NTQy?=
 =?utf-8?B?bGJqaEorWXVJeTVDNE0rcUtTYnlGTlFtcXJESURkN3Z0QWhVUXROVUoxNkdq?=
 =?utf-8?B?b0tzaWRlSkViNjVLb1RsVGNiYjJRV2s1S1JpSG95TkVwR3JSZG54TU5DeHlX?=
 =?utf-8?B?OEJJN2w3OEJPZTh4MG5nRjVMZVROQzVSRjIwZnVmVzA2UGRiZFpOV2VJV1Uw?=
 =?utf-8?B?dngzZ1dhSWwwY215WXpDSGlTaGF1am55K3lSY1VoRWs5WGFDajJWMWw2bVFK?=
 =?utf-8?B?OW9UUjFDZ2x0T2VmeXdhL0JhZytRY2xJUUdiSFFiT0FiMGplcXBmWlczR3lv?=
 =?utf-8?B?MFcvNHhsYzVFQU83ckE1LzlNdmJNNFhhVWZ0a2VkejFRZG9qYjJNR2Z6eklX?=
 =?utf-8?B?SXVFbEhNdFBEQU11RHNTRFg5czRRUDlpQ0R2bUZITXZlVnhYRHZMWG5mOVVu?=
 =?utf-8?B?YUZTbmpONlZJNkdvVWgwc0dCWk9LR3QvblZpcFAzREw2YjhHQnAzTTVpbTFq?=
 =?utf-8?B?KzVKVkc4QmQ5K3VDSlovZVpVRGZMSitoZG83RGhWUjZiU0ptajJWOEgwNSsw?=
 =?utf-8?B?WmdRcldQeWovL3BiYTIvdnVPbFh6UURnbUh3a05xZFI0TUJDdllhTFZEMmNJ?=
 =?utf-8?B?QUNpMksrVGFJTll1NmRaZ1NuenllU0x0UnorWDlTS0pwS0xVdXhnZndiYTJx?=
 =?utf-8?B?Z3lTZW5JRHlmZU5SQmxxOTMvNGNXTDRXL2NpaDZvWkpGMVVzZmdWald0YS91?=
 =?utf-8?B?RTFLUms4cHJERk5FdS9uOFBqWEdWc0hCTTg3NWsrOFZpeXVZUnVMeW5XWTk4?=
 =?utf-8?B?VjlrN2hqQlB6NkZvdEZCRXZOend2eWpsanNkM1Yyc3VDYlZ2NFJIWFJ3TE1v?=
 =?utf-8?B?L3NnTkpqRVdNOFlYTTlSeE13OUUyOFVnWjRPdytueWRVZTAzZ0pGRnl4L2Zo?=
 =?utf-8?B?cTlTU2lKNVAwck1qWVhscWRTam1kTmhIQ1ZJU01rK0RRRnpUQlJSOG1ROFlF?=
 =?utf-8?B?aCs3a2xQSnd4TDBOTDBmYWltblVrSnRqZWh5eCt4T1JsUWlGbXc0MHRPMUhF?=
 =?utf-8?B?MTdzeW44Zjc3R1V6Z2kyMk55d2owMnRNTStVK2NBK0RrdW84OXhwTTZNcTlR?=
 =?utf-8?B?LzZPbVZBQzFOTE9kdHQySkJUSmIzQ1pPWjhTVkpkcFJObEVyNUhtS1FMYzY5?=
 =?utf-8?B?b3ZzblN1QUxZeG9XSEgrNDJqdHJQUzNjL2N0TmgxVm0yejJyWTIrZ1plVFVq?=
 =?utf-8?B?SmhHU0FuV2ZMcWw2c0cxUFBseU5oTzFwbCtzaXBsVWdXblU2S2dCYVlKenkw?=
 =?utf-8?B?TXMrVTNWWDcvMlo5ZDIyVEx6VWtReDlhVzFaUW95QmJmUjNHRHlwS1hFV2pl?=
 =?utf-8?B?OWNXVTMvM284d0k0VmU1RXdCT1drZmN0Mm1YcTYrMEptdTU4endSMHVwbHJq?=
 =?utf-8?B?TzBZY2lzc0JvTXRtZGwvajVxV3VZY0JmM3loekl1VTNJTUxVMkNjNEh6bG4w?=
 =?utf-8?B?cHpISW1mQWVJQXNETmQ5K0NZZ0xyeG81NVBuVDhKWDg0aHpzSjZZbmlPb0h4?=
 =?utf-8?Q?mGfzTE5TFJheQ+akZ171VwQYspqHVs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a00wL0pPSWxreWJqWERjWmlzdnNoSVAweENIeVp3Q1hPWWVYT2dZNngyekp0?=
 =?utf-8?B?eVVlNkNpTE1UMUZJbGoxTm9IMkRHZ1I0c2ExUzYvUEcrejNBMVBwMHJwZnlw?=
 =?utf-8?B?clVHb3JZSnRIVzBZMDh5ZUJTdXF2bEtwZ1Jhc1hVQ2puYTQzazlnL0VEYmli?=
 =?utf-8?B?WmtjZnp6aHhHR0U2R0xOTjhnb0hJSjRpUUxmdmFRVkp0WHB4NUc3dG5YVFJV?=
 =?utf-8?B?S0hVdUorcFBYNFZxQURXSElKcHhLdDFTanBkWll5UE0wVHBObXRxNnFoSlov?=
 =?utf-8?B?Vm5nK25WaUVFYXgyWjZZaDlFT2dXT2QvbFdtdnEvSEN3T21WeGxsSUpzazBz?=
 =?utf-8?B?OXpRaVRnTldtU2l1UnVtdzA5SmxUUUtsdkREUTNGajYxOWhKQVQzb0FUOCtY?=
 =?utf-8?B?b1h6NHp2aXN4TGhDS0dFdFZ1SnliZUVoUFRHZEh1ZE0xMUF0bWdNMGZ4cHJI?=
 =?utf-8?B?dlVwNHpBY1BkbkJQSVpNMHM4L1BaUVR6T3lWREV1dkl6YTd0UFVtdzRvNHVk?=
 =?utf-8?B?UVZiS01xZzJ6OHdMdm1oYlg4aU90blFhNVdXUGxGZVNOMTVQRkJxSm1CeDJV?=
 =?utf-8?B?Sk8zbGZtTlVUM1pkSGtxem4yZUdmWDA4S21vSnczVlRJL2x5YVBFMGVqMEo0?=
 =?utf-8?B?bTVWUURkSHVmdHlUYlFXWlEvZUIvNlpoelVocGoyNHRoMUs2WG1wQ094TFI3?=
 =?utf-8?B?MVZ4b0xxQ1V2bWNEaTY4K2NvMG5reWs0WHZhay9LelFMWUJaUEE5SXN4eEJ1?=
 =?utf-8?B?K1ZJZU5XT0gvbXNsY3hIM1B2TndlVnhVR2gyQjA4WktMSWVjKy9Zcm8wT0tN?=
 =?utf-8?B?TWJMZ0JEcit1OC8zVWdCWFpWOUdVSURnb2NsNWZoNHNyM2tuNitvQUZrT04y?=
 =?utf-8?B?VVNoQVl6UEYrUUF4N25zalNUaXhvZ0VZSURRbHdVeC9OeU85dkQ1ZFhkYTdt?=
 =?utf-8?B?VVA4TzZlZEhlc0VrK0hTUG5zWkt1NXkvTlI1QjlMTkdXNlVzdDFLRjVza3dK?=
 =?utf-8?B?YTNMYk1QeWUvUjlhNXBZcWRwbnErTndiYWxqZDVnY3l3dlZMaTUzSjBJUzUz?=
 =?utf-8?B?WS8wUUNsU1dRU3A1cjhBeXNrSHFGZEk4YVBua2U1ZVlHNlRrZVZwY3kzbjF5?=
 =?utf-8?B?bnM0ellML0IxRG9RZXNGU01HcE9rSzc1RUVzdUsrdjc1WHdLQTFkN3dwZkpW?=
 =?utf-8?B?UFB3c2xKZU4rSGc4VmtQM1N1Q1BaZTBqMFI4Tm1qREpNbUUyWmlldFZ5c2d3?=
 =?utf-8?B?bHJLL3c1VlVHU3c3bmQwNGJiMUYrT1AzWmJleWIzZEdvbmwwQ0xwWHVrcnNQ?=
 =?utf-8?B?WlpDbXFwTFZvMDRjVXZsTUFDRXJlTGVzNDlUVzRTd1c4MCtXMXloYUxOQUpj?=
 =?utf-8?B?RVNEeUpDZUsxZlJHTUlQY2E3U2xvOStGT2YvS2JzRllhTnFtbDF4U3RCTDBM?=
 =?utf-8?B?S3pJay9TbHk1TVZ3MjVueEdia21yZmpxbmpoaGY4VU11dEMwVlJ2eDQ2VGNq?=
 =?utf-8?B?RnJsVkNRN0tWL0twS1JXaXlKdGhUU0tURUdJK2VMOU1lVHJHU3d1dS85TGFR?=
 =?utf-8?B?aU1LOE83bUx2NWNBRlNYQTZJeHN1QWZDQTdaaFAyM29xSG0zSVF3RGFWVVUx?=
 =?utf-8?B?NVFlTU1HV09OZThrRytXNC9sdVJ1UlR0SkZPR09OVVVSQURpblZKLzhqQ3By?=
 =?utf-8?B?V0NyNDU0ZXNxNUtNYytkOGxFZGJHeHMvSkJXMkk1Ui9TTFlMVTd2YlltblFr?=
 =?utf-8?B?V0NzMzJpNEZUdFpBVFV0Q0dWc0lWak9HYURiUFhEZjl4ZVZMa1hDNjBQeEsr?=
 =?utf-8?B?Q2ozN0Fid3J5M0hFNkhoQVdnK3dmbnJRMENpMFc1c1JUMVlMcFQyRmU1K1cy?=
 =?utf-8?B?NGJEVVFBUXd1UHZHQlVtYzYybzdSQzUxUEhXK2RVUlFMSHU1eXVLOGtoS3p1?=
 =?utf-8?B?czZiZWcvM2tpMEFpR2RoUTZya29BeVVtMzkyUi8rYTN5MEpwUTNIU0h1Nktl?=
 =?utf-8?B?dUNrYlEvdDVFOVIvZmpLZ2VsS2ltY1diQ2JxQWJ0Z1dlZjNmTjZGdERLek01?=
 =?utf-8?B?TWo4OURrUzc5TzRDTERWUVdIeUlrUkxtcHFyNklsM2JINVlPQ05XNE1ZRmd6?=
 =?utf-8?B?T2QwQ0MzMlBhcEw1eWRMQ0xxd2tvWWZNOHFQM3o2c0FvYy9IOXhVanQ3UGNI?=
 =?utf-8?Q?SDGPCi7BzI3gL2SuuZzU7aY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ABFD37D8F60B5742ADD76D2E40178E74@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f12d303-4519-41a6-e46f-08ddf6146771
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2025 18:02:45.1681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pAaF0iHt6WgWP3XUr+nSyRZPV5mwL3OEMYrf7ja9NrVVr+zu1xfQpquJDo9FCApoVAcXCGgjwi0dSGx2qhQdWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5007
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI1LTA5LTAzIGF0IDIxOjQ2IC0wNzAwLCBJYW4gUm9nZXJzIHdyb3RlOg0KPiBX
aGVuIG1ldHJpY3MgYXJlIG1hZGUgd2l0aCBleHBlcmltZW50YWwgZXZlbnRzIGl0IGlzIGRlc2ly
YWJsZSB0aGUNCj4gbWV0cmljIGRlc2NyaXB0aW9uIGFsc28gY2FycmllcyB0aGlzIGluZm9ybWF0
aW9uIGluIGNhc2Ugb2YgbWV0cmljDQo+IGluYWNjdXJhY2llcy4NCj4gDQo+IFN1Z2dlc3RlZC1i
eTogUGVycnkgVGF5bG9yIDxwZXJyeS50YXlsb3JAaW50ZWwuY29tPg0KDQpEb2VzIHRoaXMgbmVl
ZCBhIFNpZ25lZC1vZmYtYnk/DQoNClRoYW5rcywNClRvbQ0KDQo+IC0tLQ0KPiAgdG9vbHMvcGVy
Zi9wbXUtZXZlbnRzL21ldHJpYy5weSB8IDQ0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDQ0IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1n
aXQgYS90b29scy9wZXJmL3BtdS1ldmVudHMvbWV0cmljLnB5IGIvdG9vbHMvcGVyZi9wbXUtZXZl
bnRzL21ldHJpYy5weQ0KPiBpbmRleCA2MmQxYTFlMWQ0NTguLjIwMjliNmUyODM2NSAxMDA2NDQN
Cj4gLS0tIGEvdG9vbHMvcGVyZi9wbXUtZXZlbnRzL21ldHJpYy5weQ0KPiArKysgYi90b29scy9w
ZXJmL3BtdS1ldmVudHMvbWV0cmljLnB5DQo+IEBAIC0xMCwxMSArMTAsMTMgQEAgZnJvbSB0eXBp
bmcgaW1wb3J0IERpY3QsIExpc3QsIE9wdGlvbmFsLCBTZXQsIFR1cGxlLCBVbmlvbg0KPiAgDQo+
ICBhbGxfcG11cyA9IHNldCgpDQo+ICBhbGxfZXZlbnRzID0gc2V0KCkNCj4gK2V4cGVyaW1lbnRh
bF9ldmVudHMgPSBzZXQoKQ0KPiAgDQo+ICBkZWYgTG9hZEV2ZW50cyhkaXJlY3Rvcnk6IHN0cikg
LT4gTm9uZToNCj4gICAgIiIiUG9wdWxhdGUgYSBnbG9iYWwgc2V0IG9mIGFsbCBrbm93biBldmVu
dHMgZm9yIHRoZSBwdXJwb3NlIG9mIHZhbGlkYXRpbmcgRXZlbnQgbmFtZXMiIiINCj4gICAgZ2xv
YmFsIGFsbF9wbXVzDQo+ICAgIGdsb2JhbCBhbGxfZXZlbnRzDQo+ICsgIGdsb2JhbCBleHBlcmlt
ZW50YWxfZXZlbnRzDQo+ICAgIGFsbF9ldmVudHMgPSB7DQo+ICAgICAgICAiY29udGV4dFxcLXN3
aXRjaGVzIiwNCj4gICAgICAgICJjcHVcXC1jeWNsZXMiLA0KPiBAQCAtMzIsNiArMzQsOCBAQCBk
ZWYgTG9hZEV2ZW50cyhkaXJlY3Rvcnk6IHN0cikgLT4gTm9uZToNCj4gICAgICAgICAgICAgIGFs
bF9wbXVzLmFkZCh4WyJVbml0Il0pDQo+ICAgICAgICAgICAgaWYgIkV2ZW50TmFtZSIgaW4geDoN
Cj4gICAgICAgICAgICAgIGFsbF9ldmVudHMuYWRkKHhbIkV2ZW50TmFtZSJdKQ0KPiArICAgICAg
ICAgICAgaWYgIkV4cGVyaW1lbnRhbCIgaW4geCBhbmQgeFsiRXhwZXJpbWVudGFsIl0gPT0gIjEi
Og0KPiArICAgICAgICAgICAgICBleHBlcmltZW50YWxfZXZlbnRzLmFkZCh4WyJFdmVudE5hbWUi
XSkNCj4gICAgICAgICAgICBlbGlmICJBcmNoU3RkRXZlbnQiIGluIHg6DQo+ICAgICAgICAgICAg
ICBhbGxfZXZlbnRzLmFkZCh4WyJBcmNoU3RkRXZlbnQiXSkNCj4gICAgICAgIGV4Y2VwdCBqc29u
LmRlY29kZXIuSlNPTkRlY29kZUVycm9yOg0KPiBAQCAtNjEsNiArNjUsMTggQEAgZGVmIENoZWNr
RXZlbnQobmFtZTogc3RyKSAtPiBib29sOg0KPiAgICByZXR1cm4gbmFtZSBpbiBhbGxfZXZlbnRz
DQo+ICANCj4gIA0KPiArZGVmIElzRXhwZXJpbWVudGFsRXZlbnQobmFtZTogc3RyKSAtPiBib29s
Og0KPiArICBnbG9iYWwgZXhwZXJpbWVudGFsX2V2ZW50cw0KPiArICBpZiAnOicgaW4gbmFtZToN
Cj4gKyAgICAjIFJlbW92ZSB0cmFpbGluZyBtb2RpZmllci4NCj4gKyAgICBuYW1lID0gbmFtZVs6
bmFtZS5maW5kKCc6JyldDQo+ICsgIGVsaWYgJy8nIGluIG5hbWU6DQo+ICsgICAgIyBOYW1lIGNv
dWxkIGJlZ2luIHdpdGggYSBQTVUgb3IgYW4gZXZlbnQsIGZvciBub3cgYXNzdW1lIGl0IGlzIG5v
dCBleHBlcmltZW50YWwuDQo+ICsgICAgcmV0dXJuIEZhbHNlDQo+ICsNCj4gKyAgcmV0dXJuIG5h
bWUgaW4gZXhwZXJpbWVudGFsX2V2ZW50cw0KPiArDQo+ICsNCj4gIGNsYXNzIE1ldHJpY0NvbnN0
cmFpbnQoRW51bSk6DQo+ICAgIEdST1VQRURfRVZFTlRTID0gMA0KPiAgICBOT19HUk9VUF9FVkVO
VFMgPSAxDQo+IEBAIC04Miw2ICs5OCwxMCBAQCBjbGFzcyBFeHByZXNzaW9uOg0KPiAgICAgICIi
IlJldHVybnMgYSBzaW1wbGlmaWVkIHZlcnNpb24gb2Ygc2VsZi4iIiINCj4gICAgICByYWlzZSBO
b3RJbXBsZW1lbnRlZEVycm9yKCkNCj4gIA0KPiArICBkZWYgSGFzRXhwZXJpbWVudGFsRXZlbnRz
KHNlbGYpIC0+IGJvb2w6DQo+ICsgICAgIiIiQXJlIGV4cGVyaW1lbnRhbCBldmVudHMgdXNlZCBp
biB0aGUgZXhwcmVzc2lvbj8iIiINCj4gKyAgICByYWlzZSBOb3RJbXBsZW1lbnRlZEVycm9yKCkN
Cj4gKw0KPiAgICBkZWYgRXF1YWxzKHNlbGYsIG90aGVyKSAtPiBib29sOg0KPiAgICAgICIiIlJl
dHVybnMgdHJ1ZSB3aGVuIHR3byBleHByZXNzaW9ucyBhcmUgdGhlIHNhbWUuIiIiDQo+ICAgICAg
cmFpc2UgTm90SW1wbGVtZW50ZWRFcnJvcigpDQo+IEBAIC0yNDksNiArMjY5LDkgQEAgY2xhc3Mg
T3BlcmF0b3IoRXhwcmVzc2lvbik6DQo+ICANCj4gICAgICByZXR1cm4gT3BlcmF0b3Ioc2VsZi5v
cGVyYXRvciwgbGhzLCByaHMpDQo+ICANCj4gKyAgZGVmIEhhc0V4cGVyaW1lbnRhbEV2ZW50cyhz
ZWxmKSAtPiBib29sOg0KPiArICAgIHJldHVybiBzZWxmLmxocy5IYXNFeHBlcmltZW50YWxFdmVu
dHMoKSBvciBzZWxmLnJocy5IYXNFeHBlcmltZW50YWxFdmVudHMoKQ0KPiArDQo+ICAgIGRlZiBF
cXVhbHMoc2VsZiwgb3RoZXI6IEV4cHJlc3Npb24pIC0+IGJvb2w6DQo+ICAgICAgaWYgaXNpbnN0
YW5jZShvdGhlciwgT3BlcmF0b3IpOg0KPiAgICAgICAgcmV0dXJuIHNlbGYub3BlcmF0b3IgPT0g
b3RoZXIub3BlcmF0b3IgYW5kIHNlbGYubGhzLkVxdWFscygNCj4gQEAgLTI5Nyw2ICszMjAsMTAg
QEAgY2xhc3MgU2VsZWN0KEV4cHJlc3Npb24pOg0KPiAgDQo+ICAgICAgcmV0dXJuIFNlbGVjdCh0
cnVlX3ZhbCwgY29uZCwgZmFsc2VfdmFsKQ0KPiAgDQo+ICsgIGRlZiBIYXNFeHBlcmltZW50YWxF
dmVudHMoc2VsZikgLT4gYm9vbDoNCj4gKyAgICByZXR1cm4gKHNlbGYuY29uZC5IYXNFeHBlcmlt
ZW50YWxFdmVudHMoKSBvciBzZWxmLnRydWVfdmFsLkhhc0V4cGVyaW1lbnRhbEV2ZW50cygpIG9y
DQo+ICsgICAgICAgICAgICBzZWxmLmZhbHNlX3ZhbC5IYXNFeHBlcmltZW50YWxFdmVudHMoKSkN
Cj4gKw0KPiAgICBkZWYgRXF1YWxzKHNlbGYsIG90aGVyOiBFeHByZXNzaW9uKSAtPiBib29sOg0K
PiAgICAgIGlmIGlzaW5zdGFuY2Uob3RoZXIsIFNlbGVjdCk6DQo+ICAgICAgICByZXR1cm4gc2Vs
Zi5jb25kLkVxdWFscyhvdGhlci5jb25kKSBhbmQgc2VsZi5mYWxzZV92YWwuRXF1YWxzKA0KPiBA
QCAtMzQ1LDYgKzM3Miw5IEBAIGNsYXNzIEZ1bmN0aW9uKEV4cHJlc3Npb24pOg0KPiAgDQo+ICAg
ICAgcmV0dXJuIEZ1bmN0aW9uKHNlbGYuZm4sIGxocywgcmhzKQ0KPiAgDQo+ICsgIGRlZiBIYXNF
eHBlcmltZW50YWxFdmVudHMoc2VsZikgLT4gYm9vbDoNCj4gKyAgICByZXR1cm4gc2VsZi5saHMu
SGFzRXhwZXJpbWVudGFsRXZlbnRzKCkgb3IgKHNlbGYucmhzIGFuZCBzZWxmLnJocy5IYXNFeHBl
cmltZW50YWxFdmVudHMoKSkNCj4gKw0KPiAgICBkZWYgRXF1YWxzKHNlbGYsIG90aGVyOiBFeHBy
ZXNzaW9uKSAtPiBib29sOg0KPiAgICAgIGlmIGlzaW5zdGFuY2Uob3RoZXIsIEZ1bmN0aW9uKToN
Cj4gICAgICAgIHJlc3VsdCA9IHNlbGYuZm4gPT0gb3RoZXIuZm4gYW5kIHNlbGYubGhzLkVxdWFs
cyhvdGhlci5saHMpDQo+IEBAIC0zODQsNiArNDE0LDkgQEAgY2xhc3MgRXZlbnQoRXhwcmVzc2lv
bik6DQo+ICAgICAgZ2xvYmFsIGFsbF9ldmVudHMNCj4gICAgICByYWlzZSBFeGNlcHRpb24oZiJO
byBldmVudCB7ZXJyb3J9IGluOlxue2FsbF9ldmVudHN9IikNCj4gIA0KPiArICBkZWYgSGFzRXhw
ZXJpbWVudGFsRXZlbnRzKHNlbGYpIC0+IGJvb2w6DQo+ICsgICAgcmV0dXJuIElzRXhwZXJpbWVu
dGFsRXZlbnQoc2VsZi5uYW1lKQ0KPiArDQo+ICAgIGRlZiBUb1BlcmZKc29uKHNlbGYpOg0KPiAg
ICAgIHJlc3VsdCA9IHJlLnN1YignLycsICdAJywgc2VsZi5uYW1lKQ0KPiAgICAgIHJldHVybiBy
ZXN1bHQNCj4gQEAgLTQxNiw2ICs0NDksOSBAQCBjbGFzcyBNZXRyaWNSZWYoRXhwcmVzc2lvbik6
DQo+ICAgIGRlZiBTaW1wbGlmeShzZWxmKSAtPiBFeHByZXNzaW9uOg0KPiAgICAgIHJldHVybiBz
ZWxmDQo+ICANCj4gKyAgZGVmIEhhc0V4cGVyaW1lbnRhbEV2ZW50cyhzZWxmKSAtPiBib29sOg0K
PiArICAgIHJldHVybiBGYWxzZQ0KPiArDQo+ICAgIGRlZiBFcXVhbHMoc2VsZiwgb3RoZXI6IEV4
cHJlc3Npb24pIC0+IGJvb2w6DQo+ICAgICAgcmV0dXJuIGlzaW5zdGFuY2Uob3RoZXIsIE1ldHJp
Y1JlZikgYW5kIHNlbGYubmFtZSA9PSBvdGhlci5uYW1lDQo+ICANCj4gQEAgLTQ0Myw2ICs0Nzks
OSBAQCBjbGFzcyBDb25zdGFudChFeHByZXNzaW9uKToNCj4gICAgZGVmIFNpbXBsaWZ5KHNlbGYp
IC0+IEV4cHJlc3Npb246DQo+ICAgICAgcmV0dXJuIHNlbGYNCj4gIA0KPiArICBkZWYgSGFzRXhw
ZXJpbWVudGFsRXZlbnRzKHNlbGYpIC0+IGJvb2w6DQo+ICsgICAgcmV0dXJuIEZhbHNlDQo+ICsN
Cj4gICAgZGVmIEVxdWFscyhzZWxmLCBvdGhlcjogRXhwcmVzc2lvbikgLT4gYm9vbDoNCj4gICAg
ICByZXR1cm4gaXNpbnN0YW5jZShvdGhlciwgQ29uc3RhbnQpIGFuZCBzZWxmLnZhbHVlID09IG90
aGVyLnZhbHVlDQo+ICANCj4gQEAgLTQ2NSw2ICs1MDQsOSBAQCBjbGFzcyBMaXRlcmFsKEV4cHJl
c3Npb24pOg0KPiAgICBkZWYgU2ltcGxpZnkoc2VsZikgLT4gRXhwcmVzc2lvbjoNCj4gICAgICBy
ZXR1cm4gc2VsZg0KPiAgDQo+ICsgIGRlZiBIYXNFeHBlcmltZW50YWxFdmVudHMoc2VsZikgLT4g
Ym9vbDoNCj4gKyAgICByZXR1cm4gRmFsc2UNCj4gKw0KPiAgICBkZWYgRXF1YWxzKHNlbGYsIG90
aGVyOiBFeHByZXNzaW9uKSAtPiBib29sOg0KPiAgICAgIHJldHVybiBpc2luc3RhbmNlKG90aGVy
LCBMaXRlcmFsKSBhbmQgc2VsZi52YWx1ZSA9PSBvdGhlci52YWx1ZQ0KPiAgDQo+IEBAIC01Mjcs
NiArNTY5LDggQEAgY2xhc3MgTWV0cmljOg0KPiAgICAgIHNlbGYubmFtZSA9IG5hbWUNCj4gICAg
ICBzZWxmLmRlc2NyaXB0aW9uID0gZGVzY3JpcHRpb24NCj4gICAgICBzZWxmLmV4cHIgPSBleHBy
LlNpbXBsaWZ5KCkNCj4gKyAgICBpZiBzZWxmLmV4cHIuSGFzRXhwZXJpbWVudGFsRXZlbnRzKCk6
DQo+ICsgICAgICBzZWxmLmRlc2NyaXB0aW9uICs9ICIgKG1ldHJpYyBzaG91bGQgYmUgY29uc2lk
ZXJlZCBleHBlcmltZW50YWwgYXMgaXQgY29udGFpbnMgZXhwZXJpbWVudGFsIGV2ZW50cykuIg0K
PiAgICAgICMgV29ya3Jhb3VuZCB2YWxpZF9vbmx5X21ldHJpYyBoaWRpbmcgY2VydGFpbiBtZXRy
aWNzIGJhc2VkIG9uIHVuaXQuDQo+ICAgICAgc2NhbGVfdW5pdCA9IHNjYWxlX3VuaXQucmVwbGFj
ZSgnL3NlYycsICcgcGVyIHNlYycpDQo+ICAgICAgaWYgc2NhbGVfdW5pdFswXS5pc2RpZ2l0KCk6
DQo=
