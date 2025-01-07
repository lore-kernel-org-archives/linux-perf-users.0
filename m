Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09E91F471A;
	Tue,  7 Jan 2025 17:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736269985; cv=fail; b=EcXnylSBxeBbcCkqoDKSIiyV0aYUFuT3ta0ZCL5gTiDg8KcO1eluV4N/mqKbGgCffa29KizYSdj16G4hRc7pof4v+i1BdXv/MWjVoIyTli0yKPKXJLrzdPzGVX1PtXFKXpfsrRClHXALqlqZ+OVrHSiYf4zqUjq2x8D+iJ7K3I8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736269985; c=relaxed/simple;
	bh=G427pVzIW9PsQ0WQLLCN699P+vtmCvYR8eAIyytyyHE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U68mesUc+yVXvKOb5KkBoUP504CYnKg8VR9fmyufcxmQRA25JyANwV/y1ZyKe7xiJsUF9f6ttUcyCM2aTNdWYq9Aro9iZ8mGZ27a0wUtluh//RRi5+2dseTJGgblY8DoMwf0Tul3rtN/3AuzLMTHD20fhTxwTqHNlcY0hSMyY/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kpeTP1tY; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kpeTP1tY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736269984; x=1767805984;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=G427pVzIW9PsQ0WQLLCN699P+vtmCvYR8eAIyytyyHE=;
  b=kpeTP1tYyH7CM7jlDIgf+J/hhyYr1+RaRtj8W5+RC/dX4agU+/0nX10n
   SXCpiGXSWmPeD0kVRyfD1ibp9xkId+D9FWAVKpIanCibEp2/xn6GXEX92
   W57PEV3PoZCKPrFMqQy5p+bIsvq5uRsZH+DjXLPVyw6dqb9AsWcp+6cOX
   JiTiE5XdGi18nl8NPZgfsKtAyqRTIdAzpKyklXCR1oHPP6pFGVuEP7UUU
   JkUPCrgS5w/h97vKpBxQxkE2LCrkX/0YNkpxM7bFhklaZXVCqTkb7Eqg2
   CxeL1zYyE2+rRrxNGB4c6HwjAp136FQMcVi0qIUTS+eGGUSY7uWdY6fCS
   A==;
X-CSE-ConnectionGUID: EZNmqxd5SMaYVqMcKvFR7g==
X-CSE-MsgGUID: dkT/b0bGRf+DXB9lkRc6+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="58931336"
X-IronPort-AV: E=Sophos;i="6.12,296,1728975600"; 
   d="scan'208";a="58931336"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 09:12:45 -0800
X-CSE-ConnectionGUID: ZhCTGujcTTaVsy0Xa10zyg==
X-CSE-MsgGUID: yv/ieDiKTxC7tn0GqJk8+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,296,1728975600"; 
   d="scan'208";a="102893852"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jan 2025 09:12:44 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 7 Jan 2025 09:12:43 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 7 Jan 2025 09:12:43 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 7 Jan 2025 09:12:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GGfJzCC5Y26lNYzQG6U+vg6SeYGUWGSK+AE4vjBO/fTDQ6mMWaxT0CjMO9QzJY2lSjiJ6BBQgP6uTpoACuFRfSItlkmtIu6lGqni7OGZSQadQ39Su6K1CDMh23AkserRNhdWe3hKg3b0B9tbMQ0avVFDFURIQGrdqHdhkgZF4Tv/bDV8umUhDSBP7edYq9AzoBl579DkaB9YhiTHffpYaJCYZRGVtKX9lC8Mz3APG50v/8CDHfK17mxXQpU5OpPgFN58B41r9+vC92SxYM8jy9jYYn538Fs9UQhK7fRudS81FA7RMeBAgRJw6Vn9UemAOu1nEsVo2Ag1l+ba+CPOSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G427pVzIW9PsQ0WQLLCN699P+vtmCvYR8eAIyytyyHE=;
 b=T2mkR75TC1K6+5rLnpmfbsQQ0q0eRbwqMX/9YgVhq8o1NTSiwLu9FcndIIDpP8pjqe6WrnJqPEc1mbdaYG3hZPZU0t8tjE2vOORT7Y+BrTHXaqHc+1iLtOLOwB32wVYg3U7gGgKzsFrUrYzU9SblUxjeglmCHoQjUGR3vw95lJhVzLLyKDIIztmkv59g3U9a6K2RIkEz5A20W6qJFt4KTI1hMRtuLcXFEwanYPYlaV727767ORVarDjTsHv8zoiCGFfo2rz4NDhg1pmrOlkHUlnWebkPCkx50Fh7CZ+iu9jl7UzAy0r+B1NctekCvJ90jbvaZsQckflBlotCwa39eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by SA2PR11MB5067.namprd11.prod.outlook.com (2603:10b6:806:111::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Tue, 7 Jan
 2025 17:12:41 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b%6]) with mapi id 15.20.8335.010; Tue, 7 Jan 2025
 17:12:41 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "peterz@infradead.org" <peterz@infradead.org>, "acme@kernel.org"
	<acme@kernel.org>, "renyu.zj@linux.alibaba.com" <renyu.zj@linux.alibaba.com>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>, "irogers@google.com"
	<irogers@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH] perf/x86/intel/uncore: Fix the lack of ch_mask format for
 SPR
Thread-Topic: [PATCH] perf/x86/intel/uncore: Fix the lack of ch_mask format
 for SPR
Thread-Index: AQHbWooUInISgENm1EWQbyEtE4WperMD3IYAgAUwaQCAAMAxgIAAzCwAgAEAVgA=
Date: Tue, 7 Jan 2025 17:12:41 +0000
Message-ID: <4f1b0d01deaaf0a2cb3930679868453c3be1ed5f.camel@intel.com>
References: <1735542672-113067-1-git-send-email-renyu.zj@linux.alibaba.com>
	 <7e5376f1-ee87-458b-b55e-759125d251a2@linux.intel.com>
	 <9f233d6e-ee4b-4ea3-96ee-397bba1b73b0@linux.alibaba.com>
	 <a6218176-965e-4d69-992b-15d7cc5482ec@linux.intel.com>
	 <bff44127-73ec-469a-b82b-e8aa9062fe8e@linux.alibaba.com>
In-Reply-To: <bff44127-73ec-469a-b82b-e8aa9062fe8e@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|SA2PR11MB5067:EE_
x-ms-office365-filtering-correlation-id: 3daa1c4a-2b2e-41b9-bab2-08dd2f3e7ea5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZyszZUlxUzFCbUZwMWRJZm9USGw5MW51SEsvV0QvVGRIcDY4SDRBRGlYUGJz?=
 =?utf-8?B?QzBuZTNrd1l1cE5sSGJkY0xaYzJsTlJKSEgzOXRNL2t3bG9TdUVvcmNiWk5I?=
 =?utf-8?B?OTYxUytieVYyMEViakhMUzNpZDNSTUhlYnlnNjF3U3hvYUIzRGZ5WG9XYU15?=
 =?utf-8?B?dm54ZVhhc2FTUHpBaGNia2RyS0lpalVJVDNUdWFvQ1dNYVN6akxtQk13V254?=
 =?utf-8?B?TmRDYWh2MkZUUTBSQU1hRjNWRTJNR29MUW9QY250UVJFVElSSlcrUk1qZFlu?=
 =?utf-8?B?VjQ2MGpZMkFrZ3R3RW1wUVRsTEZYV1JmSUk5bHZaUE5ZbndCdzM4VUw1NDlT?=
 =?utf-8?B?WlM0WU13NjRXL3QyaHlWcGdmSGlNNDNTcnE1SEZJcTJkRng0RjlPakZZNXJz?=
 =?utf-8?B?N0FhQXdPL1BZcncycmxyTWZ3R2l6TnhtY0FlalhHd2RhdXd0Qy9HTGVMQ3lv?=
 =?utf-8?B?Nk5jSEVpWi9YbkR2bHp2UzloQnJKMjkranJvb012aGxaQi9aMnZlL3YxZkth?=
 =?utf-8?B?RXhJY3VObEc3bjVraWcwSmtpSDNlUGZ1aVJWYXZoUWIxRXVvUi85aS9DRjA4?=
 =?utf-8?B?Vjc5YncxNUJpNEtpYktZejl4M1gxNVZ3UHBuZlh3ZE8yNGJ0TFNWWHNTT3hC?=
 =?utf-8?B?RGxhM2lVa1VEb2RHUTRvN2dVeHYyME9KdG9yR3IvYmREb2t0bm9NK0ovTllJ?=
 =?utf-8?B?aUQ1MFVJTmZoOGtDN1RES3A4MlhxM0RIN01pTG1Scmw5UGhaM2V2YnVKMGhy?=
 =?utf-8?B?UTNYOTBRZElNcnM5aUZTa3hRRCtaR0QzaFV2RExBZUxubWpnVE1VbEFrcHh0?=
 =?utf-8?B?dnREeXUxbC9FeElSRUwvWGp5aHhwTGRrTTUzdnBuVUExQlJSTFJtZXRMSWhx?=
 =?utf-8?B?cTV5YzdITEIzTFd1dDBQUEpqYkh4ZVpTcHdIcDdLSGdEeG1nSnFGWEw3MldJ?=
 =?utf-8?B?b0lJN0RCbTZLTVM1Q0FBdHRTWGFpRkN0MFliUzRobDdnTllGdm8yekRDK2x4?=
 =?utf-8?B?Mk1ydkY2YnZOa3JCRWJLLzlKdENpbG1XTVFPK2h4S2lKcUtIV1dNaGx4MUJq?=
 =?utf-8?B?d0NWR00vZGFURi9VUXZvdTQ4Tzk5RjJaVHJVbnkzUzY0aTJ2NFdVWmpNYXZ4?=
 =?utf-8?B?MlBvMXZSUVMvbW9XYkFrWWtMRGJoLzYzSDQvUkJsNzlUUllSY2liWlBKK2px?=
 =?utf-8?B?NDIvVVFZbGNvZDZMekh3MmtxL1BWdEZ3blJDUVFUU3pWUktQUEx1dGpZeXAv?=
 =?utf-8?B?NDc1UVllOVFUdVNUcGthdkp6T0xoR1ZlQjFWLzhVcmRWUjVaS0pRcjFZUjJs?=
 =?utf-8?B?RnBlNm5RakEzTm5HOTBydy93aS9WanlacDNmRHB4NXBOZklCM1lyMEhOblZZ?=
 =?utf-8?B?T1AzZy9WRnFVekd1R25oYW1jc0lDK0syTzVZUC9qcVNacVJvVno4KzIxSWh5?=
 =?utf-8?B?OUljUWFybXdmWlZMNCt3Njd4clk0WWVldHIwN0Q2ZXphWlRBd1RHbTFuazND?=
 =?utf-8?B?TzA4bFg4TFlYNjlpbTlHS2YweDRRYUdEVE1vQlkraW9VWXlMSkhDTXcrcDdx?=
 =?utf-8?B?MFYvS25sc0xsOEdLUkZ6ZjhWeC8yUmdXRW90enNvRGprbWEwUEV2WUYwQnBX?=
 =?utf-8?B?QlFvQzl3TXlOMjlrZWxiNXdxMDgwT0dxVW53dUIrdjNmcnU3Sm1BZnJ5Y2Vq?=
 =?utf-8?B?bWtJeUZIMTgrRExlQXltV0xRdDdVWlVIR0RDSisyckh6cXcvM2hoWGRSTzdl?=
 =?utf-8?B?WHEwU2J1cnFhK1lDT3JWQys4UENtdmJoNlAxTWN1VW5vRnhocG93KzdXdm5n?=
 =?utf-8?B?RVZmRHN2ZVhIazlmcndTc1ZvNUh4eVlnK2Z3cDRpV3Jxd2M2Z1lSaU5tOUR2?=
 =?utf-8?B?dG9VQ2tqY29zZkU0cURVaXk5aHN6Z01vZzk3SEQ0WFJwd3hmQ05uSHM3QVp0?=
 =?utf-8?B?c04xMzkya2JsK2xjMFlzS3BDVjlmc0E3UU4zSHhpUWdSL1c1ZzVnTzVtaGFL?=
 =?utf-8?B?WWpOTmVla1ZBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGhMVE5PVVgyTlA0K21YT1BxdWV4RjNpQ3A1NE9idksvUDB5R3dxeUl6Q3dR?=
 =?utf-8?B?UE5GOXdFLzBVR3I5QXNseTA1ZWpOS0NyeGRQOEJ5RlF5eHZHQUE5MnhMMWM2?=
 =?utf-8?B?aW5Db2hudkg3MmxSb1FNSFc0aWxMNXpxeVpSbm5Jdmk3SHM4YTAxZk1jMytl?=
 =?utf-8?B?ZVZkV1ZjUnRKU3l3dE9ScWNtWVhkOFB1NGV5KzZsRVhNR2JIRVRPRXhTd1l5?=
 =?utf-8?B?ZXd1MlFHbStuLzdEVW53Z3VCeFVVNUU5WVFGOGhhd1hGdVA2aDRxVFZ6UlBE?=
 =?utf-8?B?SDIwSjM0Y01JTVVVS0kwNlppNlh5eFNCY0M1WS9WOHZHZW1Yc3ErbXFCTFVu?=
 =?utf-8?B?ZG1UK0VwZFZFdU8wWHpMLzFGMWhVenZsV1UwT0cxRmtoTWVlalVJQ0dHaDNh?=
 =?utf-8?B?UGZLbld3aC9MLzRQS1JtakNRQjZqb09Mc1Q3bGZCcmtiR2dVeVhZdkIrV2k3?=
 =?utf-8?B?cnFzaXNlTkdBaGgwRXRYNG9NdlBjZEIyUlRsWEo2ZkJSSFNYMjlrZWtUbWJI?=
 =?utf-8?B?VmNOZldnaFZQNVZWZi9GbWxUUzA0Q3pwTXpwdnJwZXpSMm52VjRkM2xSVGho?=
 =?utf-8?B?OGhYaFFNUTV4dXY2aGxkeURlcnhraHNqOFBGQXhsZ1hzOHhzY3NISitwN05C?=
 =?utf-8?B?VEs2VmJINU9LVTBiejdtQlROR1h3cEdRS2U3MGtXbEd6NXY0SGR3UlpscWtY?=
 =?utf-8?B?R3pjUkpTRVplaERudU9OU1IxUGlhdGg4dUNIcVFJM2kwVnU2TmhMb2RVN250?=
 =?utf-8?B?bUJaMzBCWVZjYmVWcS9PYnVGSjVBMkhUQXMyb0VzOHdlVXNOVG0vV1IySUds?=
 =?utf-8?B?YkdQaE1QWHVlV2NqT2NWaDl5RWlnNW1yTlVtNHJMc3crY1pOQ0tiU3F0S3V3?=
 =?utf-8?B?WVpBQjJrbExkRUZWTEQzeWdvWXpaMUlkQmgxUmVobWFxaHFQOEVCOU14Tlcy?=
 =?utf-8?B?SnA0T0hTcVZObUJSZ01zbVhidklXOVpPa2FpNE5Ocmw1eDE2MnIrY0xPcjFY?=
 =?utf-8?B?MVJQa282eDRpdlFZdWtDRndGei83aUJGUjJVVDFzNlB5ajE2WU5NQnZHSnN5?=
 =?utf-8?B?ekVRdU1OWXBnUEc2YnVYaFZrazFKOGVKZGNHZm41TllGSUs3MUhKS3dyY25h?=
 =?utf-8?B?dTd4SlZOZXdDSHJOb3BoZHBjWHdXdFlYd1ZiSUFSei82SG9oMnVwck9NdndQ?=
 =?utf-8?B?Vm1wTFdSc2FUQUpaRjYyeEhZYUo1ajIyVzhMdXg4TTh0WmlUa0dUbXdvNVda?=
 =?utf-8?B?TUcrenZSNm5rTFBCWFc0RzF3NmNVSXRwaTBISEgwTjR5OElheWd1T1RpWTVj?=
 =?utf-8?B?NG5PdjdJakIxSy9vZWlYcUFFYUZlNDRwSjdob1dvQWpRYURFTGJsdzhCSjdp?=
 =?utf-8?B?Q3VzMEZkcmVjOUxuRVVmM294T05KQUcrcFI2YXRtYndNbnJqelJrSlMyWjR5?=
 =?utf-8?B?Vjl6dnhLeXhCOU13NExoUjlaV1VMak9iRFprakR3MWlYUlJBTnNPelFqdGpQ?=
 =?utf-8?B?R1ZaZGRMSDd0VXVBMlRma2x0NXRrUmI1a0RHU1JBVU4rQ3NXeDhsRnlkZk9y?=
 =?utf-8?B?UUpNSVlTdGszOVpFMTJBS1drelRyU1BpZ1FTRUprMnpNUG4wUUpXTEt0L0ZS?=
 =?utf-8?B?ZExKMDZLQU02NG1oTForaXJuNkRIR0FOTmMvL3NIaXdqSDRvY1FxMkluWFNq?=
 =?utf-8?B?RnR1ekhPVkJrbG5wV2ZrU05yZGNuK0Zvc0U1ZUlNNndFWUc2VEJMRWZxdWFm?=
 =?utf-8?B?VDBtNlplaytoVXpNV2hDV24wL1B4dEdmT0o3WGpUZnVCZG8wU084aEtYVXdH?=
 =?utf-8?B?SVpkelJWL21lYlE5RUJhVnZrNnBlMDAyT3AxYVZuQ1Mwdk9ORTh4RzFPOVFH?=
 =?utf-8?B?cXlYZWFaMmNDQWN0VFB6VDZUQXN3VlZSMFN3WVhaOGpoMit6aXFpUWJTYVpm?=
 =?utf-8?B?MGhlMTgvcWdidHczaHJnU0pQNmJ3cVVWbXhkZTdnTVVDUWxtbmFOZUNMcHV0?=
 =?utf-8?B?S2NKcXJoRWh3dldONDg5T2ZvZWtoUlJLUVRiNWNjYmUzU1ZMYVQrWVJyaWxi?=
 =?utf-8?B?VTd5cVpuRFMyY1N2UEQ2NTR0VUIxWHpmMUtWUENUSmwybHRzb2o2R3RoSTdR?=
 =?utf-8?B?S2doV1JpQ3NhSXRIVDlOTW9vS21xYTVIRkx2VnJmYzg0eTF2ejNYZEFjcWVD?=
 =?utf-8?Q?2uYArQBxvndu9pXrbMMib9U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD5F0D6E0E3601489010B4FD06E23EFB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3daa1c4a-2b2e-41b9-bab2-08dd2f3e7ea5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2025 17:12:41.5442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kiX036tBTmkDkLnZtHTa1r7GfqztGv1v3vt92WTzandWgg6/s/PcqHmUOu/+nXAPLTvVN7A8gIXioh75B6ychg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5067
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI1LTAxLTA3IGF0IDA5OjU1ICswODAwLCBKaW5nIFpoYW5nIHdyb3RlOg0KPiAN
Cj4gDQo+IOWcqCAyMDI1LzEvNiDkuIvljYg5OjQ0LCBMaWFuZywgS2FuIOWGmemBkzoNCj4gPiAN
Cj4gPiANCj4gPiBPbiAyMDI1LTAxLTA1IDk6MTYgcC5tLiwgSmluZyBaaGFuZyB3cm90ZToNCj4g
PiA+IA0KPiA+ID4gDQo+ID4gPiDlnKggMjAyNS8xLzMg5LiK5Y2IMzowMiwgTGlhbmcsIEthbiDl
hpnpgZM6DQo+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gT24gMjAyNC0xMi0zMCAyOjExIGEu
bS4sIEppbmcgWmhhbmcgd3JvdGU6DQo+ID4gPiA+ID4gcGVyZiBzdGF0IGVycm9ycyBvdXQgd2l0
aA0KPiA+ID4gPiA+IFVOQ19DSEFfVE9SX0lOU0VSVFMuSUFfSElUX0NYTF9BQ0NfTE9DQUwgZXZl
bnQNCj4gPiA+ID4gPiBiZWNhdXNlIG9mIGxhY2sgb2YgY2hfbWFzayBmb3JtYXQgaW4gZHJpdmVy
cywgYW5kIHBlcmYgdGVzdA0KPiA+ID4gPiA+ICIxMDQ6IHBlcmYNCj4gPiA+ID4gPiBhbGwgUE1V
IHRlc3QgKGV4Y2x1c2l2ZSkiIGZhaWxlZC4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiAkcGVyZiBz
dGF0IC1lIHBlcmYgc3RhdCAtZQ0KPiA+ID4gPiA+IFVOQ19DSEFfVE9SX0lOU0VSVFMuSUFfSElU
X0NYTF9BQ0NfTE9DQUwNCj4gPiA+ID4gPiBzbGVlcCAxDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
SW5pdGlhbCBlcnJvcjoNCj4gPiA+ID4gPiBldmVudCBzeW50YXggZXJyb3I6DQo+ID4gPiA+ID4g
J1VOQ19DSEFfVE9SX0lOU0VSVFMuSUFfSElUX0NYTF9BQ0NfTE9DQUwnDQo+ID4gPiA+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgXF9fXyB1bmtub3duIHRlcm0gJ2NoX21hc2snDQo+ID4gPiA+ID4gZm9yIHBtdSAndW5jb3Jl
X2NoYV8wJw0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IDEwNDogcGVyZiBhbGwgUE1VIHRlc3QNCj4g
PiA+ID4gPiAoZXhjbHVzaXZlKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDogRkFJTEVEIQ0KPiA+ID4gPiA+IA0KPiA+
ID4gPiA+IEFkZCBjaF9tYXNrIGZvcm1hdCBmb3IgU1BSIHRvIGZpeCBpdC4NCj4gPiA+ID4gPiAN
Cj4gPiA+ID4gDQo+ID4gPiA+IEkgZG9uJ3QgdGhpbmsgdGhlcmUgaXMgYSBjaF9tYXNrLiBJdCBz
aG91bGQgYmUgZXh0ZW5kZWQgdW1hc2suDQo+ID4gPiA+IFRoZSBpc3N1ZSBvZiB0aGUgQ0hBIGV4
dGVuZGVkIHVtYXNrIHNob3VsZCBoYXMgYmVlbiBmaXhlZCBieQ0KPiA+ID4gPiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9sa21sLzE3MjA1MjUzMTY3OS4yMjE1LjE2MTQwMjg4NTk1NDI4MzM3NDUz
LnRpcC1ib3QyQHRpcC1ib3QyLw0KPiA+ID4gPiANCj4gPiA+IA0KPiA+ID4gSSB0aGluayBpdCBp
cyBub3QgdGhlIHNhbWUgaXNzdWUuIEkgaGF2ZSB0aGlzIHBhdGNoIGJ1dCBzdGlsbA0KPiA+ID4g
ZXJyb3IuDQo+ID4gPiANCj4gPiA+IGluICJ0b29scy9wZXJmL3BtdS1ldmVudHMvYXJjaC94ODYv
c2FwcGhpcmVyYXBpZHMvdW5jb3JlLQ0KPiA+ID4gY2FjaGUuanNvbiIsDQo+ID4gPiB0aGUgZXZl
bnQgIlVOQ19DSEFfVE9SX0lOU0VSVFMuSUFfSElUX0NYTF9BQ0NfTE9DQUwiIGlzIGRlc2NyaWJl
ZA0KPiA+ID4gYXM6DQo+ID4gPiB7DQo+ID4gPiDCoMKgwqDCoMKgwqDCoCAiQnJpZWZEZXNjcmlw
dGlvbiI6DQo+ID4gPiAiVU5DX0NIQV9UT1JfSU5TRVJUUy5JQV9ISVRfQ1hMX0FDQ19MT0NBTCIs
DQo+ID4gPiDCoMKgwqDCoMKgwqDCoCAiQ291bnRlciI6ICIwLDEsMiwzIiwNCj4gPiA+IMKgwqDC
oMKgwqDCoMKgICJFdmVudENvZGUiOiAiMHgzNSIsDQo+ID4gPiDCoMKgwqDCoMKgwqDCoCAiRXZl
bnROYW1lIjogIlVOQ19DSEFfVE9SX0lOU0VSVFMuSUFfSElUX0NYTF9BQ0NfTE9DQUwiLA0KPiA+
ID4gwqDCoMKgwqDCoMKgwqAgIkV4cGVyaW1lbnRhbCI6ICIxIiwNCj4gPiA+IMKgwqDCoMKgwqDC
oMKgICJQZXJQa2ciOiAiMSIsDQo+ID4gPiDCoMKgwqDCoMKgwqDCoCAiUG9ydE1hc2siOiAiMHgw
MDAiLA0KPiA+ID4gwqDCoMKgwqDCoMKgwqAgIlVNYXNrIjogIjB4MTBjMDAwODEwMSIsDQo+ID4g
PiDCoMKgwqDCoMKgwqDCoCAiVW5pdCI6ICJDSEEiDQo+ID4gPiB9LA0KPiA+ID4gDQo+ID4gPiB0
aGUgUG9ydE1hc2sgaXMgY2hfbWFzaywgYnV0IGRyaXZlciBub3Qgb3V0cHV0IGNoX21hc2sgb24g
U1BSLCBpdA0KPiA+ID4gY2F1c2VzIGVycm9yLg0KPiA+IA0KPiA+IFRoZXJlIGlzIG5vIGNoX21h
c2sgb24gU1BSLiBJdCBzaG91bGQgYmUgRXh0ZW5kZWQgVW1hc2suDQo+ID4gVGhlIGNvbnZlcnRv
ciB0b29sIHNob3VsZCBhdm9pZCBnZW5lcmF0aW5nIHRoZSBQb3J0TWFzayBhbmQgRkNNYXNrDQo+
ID4gZm9yDQo+ID4gU1BSL0VNUi9HTlIuDQo+IA0KPiBPaCwgSSBzZWUuIE1heWJlIHRoZSBldmVu
dCBkZXNjcmlwdGlvbiBpcyBpbmFjY3VyYXRlLg0KPiANCj4gVGhhbmtzLA0KPiBKaW5nDQo+IA0K
PiA+IA0KPiA+ICsgVGhvbWFzDQo+ID4gDQo+ID4gQ291bGQgeW91IHBsZWFzZSB0YWtlIGEgbG9v
az8gV2UgbWF5IGhhdmUgdG8gcmUtZ2VuZXJhdGUgdGhlIGV2ZW50DQo+ID4gbGlzdC4NCg0KSmlu
ZywgY291bGQgeW91IHBsZWFzZSByZXRlc3Qgd2l0aCB0aGUgbGF0ZXN0IHBlcmYtdG9vbHMtbmV4
dDoNCg0KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvcGVy
Zi9wZXJmLXRvb2xzLW5leHQuZ2l0Lz9oPXBlcmYtdG9vbHMtbmV4dA0KDQphbmQgd2l0aCB0aGlz
IHBhdGNoIHNlcmllcyBhcHBsaWVkOg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDI0
MTIwOTIyMjgwMC4yOTYwMDAtMS1pcm9nZXJzQGdvb2dsZS5jb20vDQoNClBsZWFzZSBsZXQgdXMg
a25vdyBpZiB0aGF0IHJlc29sdmVzIHRoZSBpc3N1ZSBmb3IgeW91Lg0KDQpUaGFua3MsDQpUb20N
Cg0KPiA+IA0KPiA+IFRoYW5rcywNCj4gPiBLYW4NCj4gPiANCj4gPiA+IA0KPiA+ID4gVGhhbmtz
LA0KPiA+ID4gSmluZw0KPiA+ID4gDQo+ID4gPiA+IFRoYW5rcywNCj4gPiA+ID4gS2FuDQo+ID4g
PiANCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiANCj4gPiA+ID4gPiBGaXhlczogOTQ5YjExMzgxZjgx
ICgicGVyZi94ODYvaW50ZWwvdW5jb3JlOiBBZGQgU2FwcGhpcmUNCj4gPiA+ID4gPiBSYXBpZHMg
c2VydmVyIENIQSBzdXBwb3J0IikNCj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBKaW5nIFpoYW5n
IDxyZW55dS56akBsaW51eC5hbGliYWJhLmNvbT4NCj4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiDC
oGFyY2gveDg2L2V2ZW50cy9pbnRlbC91bmNvcmVfc25iZXAuYyB8IDEgKw0KPiA+ID4gPiA+IMKg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gZGlm
ZiAtLWdpdCBhL2FyY2gveDg2L2V2ZW50cy9pbnRlbC91bmNvcmVfc25iZXAuYw0KPiA+ID4gPiA+
IGIvYXJjaC94ODYvZXZlbnRzL2ludGVsL3VuY29yZV9zbmJlcC5jDQo+ID4gPiA+ID4gaW5kZXgg
Y2E5ODc0NC4uZTUzNzYyMyAxMDA2NDQNCj4gPiA+ID4gPiAtLS0gYS9hcmNoL3g4Ni9ldmVudHMv
aW50ZWwvdW5jb3JlX3NuYmVwLmMNCj4gPiA+ID4gPiArKysgYi9hcmNoL3g4Ni9ldmVudHMvaW50
ZWwvdW5jb3JlX3NuYmVwLmMNCj4gPiA+ID4gPiBAQCAtNTk2Nyw2ICs1OTY3LDcgQEAgc3RhdGlj
IGludCBzcHJfY2hhX2h3X2NvbmZpZyhzdHJ1Y3QNCj4gPiA+ID4gPiBpbnRlbF91bmNvcmVfYm94
ICpib3gsIHN0cnVjdCBwZXJmX2V2ZW50ICpldg0KPiA+ID4gPiA+IMKgCSZmb3JtYXRfYXR0cl9p
bnYuYXR0ciwNCj4gPiA+ID4gPiDCoAkmZm9ybWF0X2F0dHJfdGhyZXNoOC5hdHRyLA0KPiA+ID4g
PiA+IMKgCSZmb3JtYXRfYXR0cl9maWx0ZXJfdGlkNS5hdHRyLA0KPiA+ID4gPiA+ICsJJmZvcm1h
dF9hdHRyX2NoX21hc2suYXR0ciwNCj4gPiA+ID4gPiDCoAlOVUxMLA0KPiA+ID4gPiA+IMKgfTsN
Cj4gPiA+ID4gPiDCoHN0YXRpYyBjb25zdCBzdHJ1Y3QgYXR0cmlidXRlX2dyb3VwDQo+ID4gPiA+
ID4gc3ByX3VuY29yZV9jaGFib3hfZm9ybWF0X2dyb3VwID0gew0KPiA+ID4gDQo+ID4gDQoNCg==
