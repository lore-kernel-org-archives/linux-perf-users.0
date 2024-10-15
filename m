Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902B71AF0B7;
	Tue, 15 Oct 2024 16:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729011193; cv=fail; b=FQ+B1GZnsqdwlBOENw9HURR70I6PjEQpHFQuwCtyr13bbxOJNW95GYlybD78BkZXFGreXsi07lDmYO0VmLkY//iN4xuYkaqFqK4ZOpV2Z2RmjOtMyyjCvoF6sPUWPwA+xWrTkMBtBO5ptEdYtg3L7LYLx2EUvMmZEtFznKNJciA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729011193; c=relaxed/simple;
	bh=fzvKKngIgK3Co7tUiR8sETpRAm/5OMAW1vnH/lJ/mkQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sYhvN2Saowtgmk7Bbsxc21owdXruEmTKo7tMgqPCxNoYJbFoX63i46l91l+0B168jceLTtOEhU5FXaEMBH+rdZl6OfQeXCkDQZ2rvu9xWEr6F86BYftSTZPjOqgjJUb7zRIqmPx+qVv/tywlFCkBiwUa/Z9KhkiRCMeEJOWnZig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G47VXbE+; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G47VXbE+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729011192; x=1760547192;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fzvKKngIgK3Co7tUiR8sETpRAm/5OMAW1vnH/lJ/mkQ=;
  b=G47VXbE+RgvY2obPjOcKAUGIlNlAR81rwV9GJQaeIduiWIzR/kqoh1Xf
   eZ+WkcefkUbcjorzKG6LWsiH2nocVLar4PYcNbwqdfSOJ1zge5bxexcE/
   fqii4yudBY0Xa+Wi4CpKmFRhM4WwWbKksPMzdP+QHt/JMrzzjkowtIpE5
   il5LAe5wNj5fOXinVxG+Ikh0u49845YL+edSxab3yxplB5sS3vaQOuqxJ
   moNy6X5MI7sbtMBdPh9nPn4nyl5duJGKyqobHj7Ong3vDPkHMaCXncrl0
   BECt2Yb2ujl5BAiqSdCEcZuP07G8/aQLteNYGA/eda20depsbxJi/IcgF
   g==;
X-CSE-ConnectionGUID: mfVFd5zLSi2IBu6BBOC5cA==
X-CSE-MsgGUID: kvx9R2CIT8y11OiLzPAS4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28374346"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28374346"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 09:53:11 -0700
X-CSE-ConnectionGUID: DuxuXOutQZOmlaz6fF4Wuw==
X-CSE-MsgGUID: MMVYp5ZATHSiOI0qhZmGyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,205,1725346800"; 
   d="scan'208";a="77906573"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 09:53:11 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 09:53:10 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 09:53:10 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 09:53:10 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 09:53:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RkyjpBTve2opvT1UJwaPT1ZyxTk/kuMrWMy3T27Ycyp+2ETe4OJFYZnlgY3KJ0oIMKOfLudnVOr61DX+7wGieQTf621l9b3Y/mLX4HvXFso4sHGsh85Lof7T2VPCGOwGGeHGTl+1gMHxHLOivGaZ4Ifr/ehJHJDyYObzo+m+7qX0vPk2WHhFaFLmnq0dd4kt3kS1eyUtEHYOGx2ff1T1iPpD/YrFZ+w4iYwJwp55XCuOMBn2Ziw2ZTTRl3dGQnd66cA018bn5f0JpIPr30Pm74f7+aXiG4uEugq1FanDvFlXtefXecQr9OiBnLtcilynEjAf+iv4Wj9RE7FzI5sqqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fzvKKngIgK3Co7tUiR8sETpRAm/5OMAW1vnH/lJ/mkQ=;
 b=JAOBNDNAWdVBtcdv3r4KrcRh5EOCDYoY3MJmh1Z2aVOPMczRToFd+90RnGZ+6ODhY0S9/pLL8Ov0+olRmawxf5+ru4zyDGdFTg2N888jnghGnfRixHVaipCUPjY2aMf3kJLpAOpLQIqFBv6qXwUgrJnVENqZkYjUShOJMS4NavSp903H5UYZP46Gi2W1+SdtQQYKxj9ubvEd9ku6x92DXl+MEK9k6006cAT3QcbXuUzAxhmtcqTEdzFEIoS2LoCXG64jmoEZVk5JpIDdNuEOPk+V1gZxJLqnIq14i98PZpx3vXVb6t6dgPIR5D64Rxc7I/TYya26DBbBwqDucklshg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by SA0PR11MB4621.namprd11.prod.outlook.com (2603:10b6:806:72::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 16:53:07 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b%6]) with mapi id 15.20.8048.017; Tue, 15 Oct 2024
 16:53:07 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "namhyung@kernel.org" <namhyung@kernel.org>, "acme@kernel.org"
	<acme@kernel.org>, "james.clark@linaro.org" <james.clark@linaro.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"irogers@google.com" <irogers@google.com>
CC: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Hunter,
 Adrian" <adrian.hunter@intel.com>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>, "jolsa@kernel.org" <jolsa@kernel.org>
Subject: Re: [RFC PATCH 1/1] libperf: evlist: Fix --cpu argument on hybrid
 platform
Thread-Topic: [RFC PATCH 1/1] libperf: evlist: Fix --cpu argument on hybrid
 platform
Thread-Index: AQHbHxKnTtEPylLsSUK9TrfdQLACjbKIB0QA
Date: Tue, 15 Oct 2024 16:53:07 +0000
Message-ID: <9a35e6b66b3d106860945962faf1a6858c8ccf17.camel@intel.com>
References: <20241015145416.583690-1-james.clark@linaro.org>
	 <20241015145416.583690-2-james.clark@linaro.org>
In-Reply-To: <20241015145416.583690-2-james.clark@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|SA0PR11MB4621:EE_
x-ms-office365-filtering-correlation-id: 706588c2-c7fe-4955-d5f4-08dced39d7fc
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cmFreVNJTEJsRnVwdEJYY1pQTytkeHI3ZDl4bzJkd3AwcXFabVlWa2R2MzJX?=
 =?utf-8?B?MkxOZm4zUk1rTk1pRExkMHNadUhqai95dWVud3lKbERnSVRSUnJiMzIvTyth?=
 =?utf-8?B?Y2RXbTdpRnRPTFkzTFJDclNVWDVxNUxzc0d1cktrZlE1TFQ0bXJhazBETmFO?=
 =?utf-8?B?b2x1VDlueFRVZjR0T29UTC9vWjJLb3NmSmFkMnZBL0Z4UjVDejdBTUhmdkVI?=
 =?utf-8?B?Sjd0cUtVM3VLbk4wK3IyUU1BRC95Q1o4dmlpSFA4UjFVa1V1aXFvNkpOMkFl?=
 =?utf-8?B?MmdDSEhWZGFNcmF0dVRLazVCcERPT0hoT084MjBsMU1yeWxMRTl6cGxaRmd4?=
 =?utf-8?B?TFlQRmtldzRqTVZ3cDhtbFpzYVd5ZmNMV3JRRW0zeVZLUW5BL1A1UjFxdjdm?=
 =?utf-8?B?R2hiRUdUZG9BMldERk1DZjdlOW52TXJHL0FJMnZmZ2I4UjNVUG5IdktidFVD?=
 =?utf-8?B?MWhEWnlZTEtVdDAxOFBkYXNYZHB4elh4OEZwWjRKRUlFNTdQOTcwR0FFaG9a?=
 =?utf-8?B?ZHhyWDBsc0cyaC9ZZjladnJvZVZyL0VOMFlKSmtPeEhPM0JaWExuckRaTFhv?=
 =?utf-8?B?RmwyTGUwazkvdDFXamk5cDFkVStlWkt4bDg0c2t2ZXdaWlhuTWpuQVhRY1hu?=
 =?utf-8?B?TTREaWdqY0JKRzkwQ0g3U3l3L2tkNklML25IMTNMdzdjWm5xckJJWjhHVjly?=
 =?utf-8?B?SXA0TllZMDJwSS9lME9qQ0R2bE5jNkVWOUFjcVhuN3RoQWcwazFOZXNrbVFk?=
 =?utf-8?B?OHh5Rko4YUpmTUx2MWdWRWVuQzhKTWt0UFdoQjF5T3NpWEFRaXNCckxWanha?=
 =?utf-8?B?c3FhSXEvQThYeVBlTHhjaDBlaGxEc3pnQzNMS2Eza2tVYS9IWm9YZE5YczQ2?=
 =?utf-8?B?RUViNkZaQi9nazBHTHF1Q256Vlo3WHRWYSt5Rms0YWloZFV3MzNNcTlnU0xN?=
 =?utf-8?B?OXdFam0xMlB4UzNBKzhmVnk4eWNCSFd1OUMrcXQ5OGlYYm9leFJuMW1ZLytk?=
 =?utf-8?B?UlNPL2VnRnNjcHp6QmRvSmFpaWlKcElqUjJXK0VyVFNSWXg4aG11bG1TK0dX?=
 =?utf-8?B?Q3ppeHd0NkU3YVdxRmdwa3VTbSs5VkdwOTJhWnlodEliNWoxVnJXS3QrRklu?=
 =?utf-8?B?YzBDN1RDZW9mQXpJWHVKZFUvS2RYcGppeW0reldSWEdhL29ING5QRXhWUVBV?=
 =?utf-8?B?WjJKWGdrL0QveGRtaFJyRHROcGd0SER4V2sxMzdhaU9keTg1Mlk4NUplbFRW?=
 =?utf-8?B?MHJDWG9BWTlIeFVvUStSK0hMOEJrNXE3b3pVTHhlTjNHcnhKTGhCSUxIWkFy?=
 =?utf-8?B?Qml1eVE3L3NVQWRQUFBZQ0hsOFhkU1hIOXJWclArWlZ1ckJEb1dZN1Z0aUNK?=
 =?utf-8?B?c3JzeEUrZGJMT3ZZQjE0dHpMNmVGSXY1UkhQekxzK2VzblVRY0xXTk85MkI1?=
 =?utf-8?B?RkttODhnRng0bnZkQmpJL1VVcW9UamtlL1NqUnQ5YzJCMnlzdUMyZEtmN2JC?=
 =?utf-8?B?RVhGS3ArTWNpYUVicFg5NCtURTJjSlFzWFIrRlFzSjV5S3Rzd3ZYYUpFWmE0?=
 =?utf-8?B?ZGhORkVjdHZIT3RJaEhjR3k2azVwa2drMit5dGRyV3pPdnFnNllZNWx3dk1n?=
 =?utf-8?B?REhCaHozOXY1ZkNOTFVidmw5MkRpUng5czJIVzd4L3hSR3kzcUJyT2RZS2dI?=
 =?utf-8?B?MVZIYXc5Z0JCbXJUakYyWVoxaTF5TVBvdDFTc2pZUGFTNDBVb3FpSDk5dmtk?=
 =?utf-8?B?TWE1d2JFUUNKTEUwOElBUHlYYkN1cFJ0WmJ4V0F5TGVsNVJROEpMYzg5WTAr?=
 =?utf-8?B?bHR2cmtrMHRoSlkwVTNnUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eU1RR0szcDZXWGZ5bUhoVmxjRmU3dFVCRTRLQngvdHJqMjRJanhDUUE1dUxs?=
 =?utf-8?B?emhkWldsVUlUUjVDanhZdHhuRWdCUEVSMVhjTUtMMzZHTSt6cjJYZ1RKOW1O?=
 =?utf-8?B?SGNBazd6SDhiUnYzVGVXb3YyU0tYem1GRklCY3p6ejlSRHNEVldTTDNkRHpZ?=
 =?utf-8?B?WjV0b2dFU05ITEZwa2RPTXRsS1FjUi9nU21OMnpWZ0ZmeUQ5M1hoeVRGaEhV?=
 =?utf-8?B?Q01ZV01meUozU1dwTVVVS1puTTk4dlBqaFJpQ0pQUkJ5bUtFMURIOGhUU2xC?=
 =?utf-8?B?clNzdlNnVVdsZDNSOFdJMEo0VjJEdUlZbTk5Um42T1lIR0cwZTBJdCtrT3Ns?=
 =?utf-8?B?NEF1RUhYd0Y2MC9PclUvWUJvM1dHcEhjaVllQ0x0bEV3UnYrTHd6NGxHWDM4?=
 =?utf-8?B?U2t1d0x5S0NSMzF4aDJYUmlacTJ0U2RaRFZZTm9QQ0tnUnZ1QjZTclB6WFBy?=
 =?utf-8?B?cUl6T3lFcXFQS1hRS2lnaU9nemVkTE52allSeExHWFEvL2lraEYwRnBNZEQr?=
 =?utf-8?B?MlNUYnJxNEtTYUVMR2RTL3ltNVEycm9raUxmZ0dTeUhxeUxZaHhvRlFIbUlv?=
 =?utf-8?B?MXhGSk14ME80WDRMUnRNUkdrVHRXQ3JDbU5lYTVRZmw0YXNwSkVvV3pRZXhX?=
 =?utf-8?B?TXA5UnNnU2laMjJxdzNSdjZRMk0zMDFDVFFRcHhzMXBwNWxyTE5IVzdTaTJD?=
 =?utf-8?B?a21qdXRPUGtOUEZwSldqVFI2bGRFcnBkM0pJK3ZzUVJIWmtIOW5OR0R0NFln?=
 =?utf-8?B?L0FXRmdVTDZ3M0xLZ1pBSG91cExZT1czQWk1Q1M0YUhVVFg0Vzl1WERjQTh0?=
 =?utf-8?B?N1ZwOWoxTy9xVXNKZzJTS1QxZEM3OWxIYm5MSU5oV2VJeDFYOE1jSDBGZGd2?=
 =?utf-8?B?YTU3bGtIV2ZGdytoMzJIcVpqcUdWSkpiMFA4cUNoYXIxWmw3TC9NazNsRG5Q?=
 =?utf-8?B?cGp1OVQ5U3hhVHF3aCs4OHNCRkkxQmk5VXhMQkJJanpia3R2ZXZwR0QvaEZ6?=
 =?utf-8?B?MzVYMWNKdk03Yy9FSTlycDRMTzlpVlhLNERSOVVhNUNXQzFwUkZsNW8xc0xo?=
 =?utf-8?B?TStYa3JISUVscEFnYkJxWjU4Wk9RNnBWdkxmcVMyVkZQUDhJVStJT1dxZ2JD?=
 =?utf-8?B?N0tKM0I2ck5kZzJMaVRwb1ZjV2R0ZTVjUGs2b0ZqZ1VocWR1ejU4blExVzRm?=
 =?utf-8?B?VWhXY0w2ZDcxYXBVeXoxRDUvaXh5N1FTb1BmWUovelh5Z2J3Mitkak1iS1hu?=
 =?utf-8?B?WGVDWFpLYmZwSU5EU0xrQU9JM20zRmsxa2tRem52andJdlZzSzJIZmVESlJz?=
 =?utf-8?B?VzNqSi8vTjAzVWsvTkVwYUErMnlFcGlaLzVyRmk3akxtRm95N3R4VmNWaVZx?=
 =?utf-8?B?Y1VEaU1aTUlQWE9RMkY0ZHE0MVdXSW44SUVRNGFVYkU1c0FhbUlPTlpFeGRU?=
 =?utf-8?B?WDF6aHR2bWtTT1J4UjlLRVNXdVArRVZVWXpnTUVVZytqS2dBc283OGNubGpN?=
 =?utf-8?B?QUVPZWNrNVY0Ykg4S0N2MDg2N0tkYUFyRTlKMklKS2R5SlpCc3FvZENXV2Zq?=
 =?utf-8?B?cDJudms2VjNScDVQV1V6cnNRcDZZL0tCZ3JQbUFoRXEzTkxYVFc5OGg4dldt?=
 =?utf-8?B?cTJ1M2lwWGRmU2tFeTBlRWlmbCtmUmZ0NzBmUXpLL1Fic2o2VGQvVEtJelNL?=
 =?utf-8?B?d2FCaVVMdnV3MTFSTTVmK1VHZHNldGRCdDZTSzA3bWxtUVBtQXN4UlgvOHZa?=
 =?utf-8?B?YVlpSlRPcVhyVXJoMmVRcWZmMk5QUUJoK1ZXTnhzZGdmMnFZcjZrbzlzVFNE?=
 =?utf-8?B?MkVuZWZXcjc2dXZPQTlqNXVxNW52eDV6STVDWnhqMGd1UVIvVVFIN0JUZy9Q?=
 =?utf-8?B?blQ3VnBnZVZFQ2E2WG0yeTNxVEcxY3ZDRENBZDM1NXNBNndoS0J3MVNMOUZS?=
 =?utf-8?B?NDNoQloxSmFmbTdVZ3dXN2RiK2xDUzFJamtSRFdzNHBHZ3E0aXNWZ3hDSmFt?=
 =?utf-8?B?SkttbjBsSEhtWVRkK0ZoU0NLeWxuU0JXTFQ5YjZLR1l0Mkk2V0FYQmduZEFI?=
 =?utf-8?B?YmNudWJNUnFwK01haFkvWmFpbnBnNlZydzZldk5XWnhQOXE4WlR1MjFES0xB?=
 =?utf-8?B?TVFtU2JXaFppdXd1MDlkcWhVbkRic05ZUVRHZHFkeUhSZGNwWWJabFVLL2Z0?=
 =?utf-8?B?V0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E1C2211A3994E49A33BBE6312DD9653@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 706588c2-c7fe-4955-d5f4-08dced39d7fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2024 16:53:07.1931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +y4aLg1a3ID3vV3oIqG8HyDyqmSZ21sBJUL9ijjuefVOzDtQ6wNr0GiQ9qDpHBrkdsE+nM2ozY+pIWVcxk2o5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4621
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTEwLTE1IGF0IDE1OjU0ICswMTAwLCBKYW1lcyBDbGFyayB3cm90ZToNCj4g
U2luY2UgdGhlIGxpbmtlZCBmaXhlczogY29tbWl0LCBzcGVjaWZ5aW5nIGEgQ1BVIG9uIGh5YnJp
ZCBwbGF0Zm9ybXMNCj4gcmVzdWx0cyBpbiBhbiBlcnJvciBiZWNhdXNlIFBlcmYgdHJpZXMgdG8g
b3BlbiBhbiBleHRlbmRlZCB0eXBlIGV2ZW50DQo+IG9uICJhbnkiIENQVSB3aGljaCBpc24ndCB2
YWxpZC4gRXh0ZW5kZWQgdHlwZSBldmVudHMgY2FuIG9ubHkgYmUNCj4gb3BlbmVkDQo+IG9uIENQ
VXMgdGhhdCBtYXRjaCB0aGUgdHlwZS4NCj4gDQo+IEJlZm9yZSAod29ya2luZyk6DQo+IA0KPiDC
oCAkIHBlcmYgcmVjb3JkIC0tY3B1IDEgLS0gdHJ1ZQ0KPiDCoCBbIHBlcmYgcmVjb3JkOiBXb2tl
biB1cCAxIHRpbWVzIHRvIHdyaXRlIGRhdGEgXQ0KPiDCoCBbIHBlcmYgcmVjb3JkOiBDYXB0dXJl
ZCBhbmQgd3JvdGUgMi4zODUgTUIgcGVyZi5kYXRhICg3IHNhbXBsZXMpIF0NCj4gDQo+IEFmdGVy
IChub3Qgd29ya2luZyk6DQo+IA0KPiDCoCAkIHBlcmYgcmVjb3JkIC1DIDEgLS0gdHJ1ZQ0KPiDC
oCBXQVJOSU5HOiBBIHJlcXVlc3RlZCBDUFUgaW4gJzEnIGlzIG5vdCBzdXBwb3J0ZWQgYnkgUE1V
ICdjcHVfYXRvbScNCj4gKENQVXMgMTYtMjcpIGZvciBldmVudCAnY3ljbGVzOlAnDQo+IMKgIEVy
cm9yOg0KPiDCoCBUaGUgc3lzX3BlcmZfZXZlbnRfb3BlbigpIHN5c2NhbGwgcmV0dXJuZWQgd2l0
aCAyMiAoSW52YWxpZA0KPiBhcmd1bWVudCkgZm9yIGV2ZW50IChjcHVfYXRvbS9jeWNsZXM6UC8p
Lg0KPiDCoCAvYmluL2RtZXNnIHwgZ3JlcCAtaSBwZXJmIG1heSBwcm92aWRlIGFkZGl0aW9uYWwg
aW5mb3JtYXRpb24uDQo+IA0KPiAoSWdub3JlIHRoZSB3YXJuaW5nIG1lc3NhZ2UsIHRoYXQncyBl
eHBlY3RlZCBhbmQgbm90IHBhcnRpY3VsYXJseQ0KPiByZWxldmFudCB0byB0aGlzIGlzc3VlKS4N
Cj4gDQo+IFRoaXMgaXMgYmVjYXVzZSBwZXJmX2NwdV9tYXBfX2ludGVyc2VjdCgpIG9mIHRoZSB1
c2VyIHNwZWNpZmllZCBDUFUNCj4gKDEpDQo+IGFuZCBvbmUgb2YgdGhlIFBNVSdzIENQVXMgKDE2
LTI3KSBjb3JyZWN0bHkgcmVzdWx0cyBpbiBhbiBlbXB0eQ0KPiAoTlVMTCkNCj4gQ1BVIG1hcC4g
SG93ZXZlciBmb3IgdGhlIHB1cnBvc2VzIG9mIG9wZW5pbmcgYW4gZXZlbnQsIGxpYnBlcmYNCj4g
Y29udmVydHMNCj4gZW1wdHkgQ1BVIG1hcHMgaW50byBhbiBhbnkgQ1BVICgtMSkgd2hpY2ggdGhl
IGtlcm5lbCByZWplY3RzLg0KPiANCj4gRml4IGl0IGJ5IGRlbGV0aW5nIGV2c2VscyB3aXRoIGVt
cHR5IENQVSBtYXBzIGluIHRoZSBzcGVjaWZpYyBjYXNlDQo+IHdoZXJlDQo+IHVzZXIgcmVxdWVz
dGVkIENQVSBtYXBzIGFyZSBldmFsdWF0ZWQuDQo+IA0KPiBGaXhlczogMjUxYWEwNDAyNDRhICgi
cGVyZiBwYXJzZS1ldmVudHM6IFdpbGRjYXJkIG1vc3QgIm51bWVyaWMiDQo+IGV2ZW50cyIpDQo+
IFNpZ25lZC1vZmYtYnk6IEphbWVzIENsYXJrIDxqYW1lcy5jbGFya0BsaW5hcm8ub3JnPg0KDQpX
b3JrcyBmb3IgbWUgb24gYW4gaTktMTI5MDAuDQoNClRlc3RlZC1ieTogVGhvbWFzIEZhbGNvbiA8
dGhvbWFzLmZhbGNvbkBpbnRlbC5jb20+DQoNClRoYW5rcw0KPiAtLS0NCj4gwqB0b29scy9saWIv
cGVyZi9ldmxpc3QuYyB8IDExICsrKysrKysrKy0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDkgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90b29scy9saWIv
cGVyZi9ldmxpc3QuYyBiL3Rvb2xzL2xpYi9wZXJmL2V2bGlzdC5jDQo+IGluZGV4IGM2ZDY3ZmM5
ZTU3ZS4uOGZhZTlhMTU3YTkxIDEwMDY0NA0KPiAtLS0gYS90b29scy9saWIvcGVyZi9ldmxpc3Qu
Yw0KPiArKysgYi90b29scy9saWIvcGVyZi9ldmxpc3QuYw0KPiBAQCAtNDcsNiArNDcsMTMgQEAg
c3RhdGljIHZvaWQgX19wZXJmX2V2bGlzdF9fcHJvcGFnYXRlX21hcHMoc3RydWN0DQo+IHBlcmZf
ZXZsaXN0ICpldmxpc3QsDQo+IMKgCQkgKi8NCj4gwqAJCXBlcmZfY3B1X21hcF9fcHV0KGV2c2Vs
LT5jcHVzKTsNCj4gwqAJCWV2c2VsLT5jcHVzID0gcGVyZl9jcHVfbWFwX19pbnRlcnNlY3QoZXZs
aXN0LQ0KPiA+dXNlcl9yZXF1ZXN0ZWRfY3B1cywgZXZzZWwtPm93bl9jcHVzKTsNCj4gKw0KPiAr
CQkvKg0KPiArCQkgKiBFbXB0eSBjcHUgbGlzdHMgd291bGQgZXZlbnR1YWxseSBnZXQgb3BlbmVk
IGFzDQo+ICJhbnkiIHNvIHJlbW92ZQ0KPiArCQkgKiBnZW51aW5lbHkgZW1wdHkgb25lcyBiZWZv
cmUgdGhleSdyZSBvcGVuZWQgaW4gdGhlDQo+IHdyb25nIHBsYWNlLg0KPiArCQkgKi8NCj4gKwkJ
aWYgKHBlcmZfY3B1X21hcF9faXNfZW1wdHkoZXZzZWwtPmNwdXMpKQ0KPiArCQkJcGVyZl9ldmxp
c3RfX3JlbW92ZShldmxpc3QsIGV2c2VsKTsNCj4gwqAJfSBlbHNlIGlmICghZXZzZWwtPm93bl9j
cHVzIHx8IGV2bGlzdC0+aGFzX3VzZXJfY3B1cyB8fA0KPiDCoAkJKCFldnNlbC0+cmVxdWlyZXNf
Y3B1ICYmDQo+IHBlcmZfY3B1X21hcF9faGFzX2FueV9jcHUoZXZsaXN0LT51c2VyX3JlcXVlc3Rl
ZF9jcHVzKSkpIHsNCj4gwqAJCS8qDQo+IEBAIC04MCwxMSArODcsMTEgQEAgc3RhdGljIHZvaWQg
X19wZXJmX2V2bGlzdF9fcHJvcGFnYXRlX21hcHMoc3RydWN0DQo+IHBlcmZfZXZsaXN0ICpldmxp
c3QsDQo+IMKgDQo+IMKgc3RhdGljIHZvaWQgcGVyZl9ldmxpc3RfX3Byb3BhZ2F0ZV9tYXBzKHN0
cnVjdCBwZXJmX2V2bGlzdCAqZXZsaXN0KQ0KPiDCoHsNCj4gLQlzdHJ1Y3QgcGVyZl9ldnNlbCAq
ZXZzZWw7DQo+ICsJc3RydWN0IHBlcmZfZXZzZWwgKmV2c2VsLCAqbjsNCj4gwqANCj4gwqAJZXZs
aXN0LT5uZWVkc19tYXBfcHJvcGFnYXRpb24gPSB0cnVlOw0KPiDCoA0KPiAtCXBlcmZfZXZsaXN0
X19mb3JfZWFjaF9ldnNlbChldmxpc3QsIGV2c2VsKQ0KPiArCWxpc3RfZm9yX2VhY2hfZW50cnlf
c2FmZShldnNlbCwgbiwgJmV2bGlzdC0+ZW50cmllcywgbm9kZSkNCj4gwqAJCV9fcGVyZl9ldmxp
c3RfX3Byb3BhZ2F0ZV9tYXBzKGV2bGlzdCwgZXZzZWwpOw0KPiDCoH0NCj4gwqANCg0K
