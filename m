Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C772153E4;
	Mon,  3 Mar 2025 17:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741022054; cv=fail; b=LIu+sxVTaYJW7Fzb4+ELtHTvG2/9yUuCrXAYxaoXOD8bbocGXsjTrdfASv6JxYL9shapA/0Cd2MnvcpX8gXaKdw8QcuhI5jTLKvkOOTmvJWhGeAG1tYU21DTSahQvdqeq8hY8x0E3MEMWY/waaIh/dFSRizGlRXKoogWhTXzn+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741022054; c=relaxed/simple;
	bh=hcaUgBEfC+BiIJ7ri7/zJ0tzM9ZTNHGrRsZOZuavPEY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i/DfTn784YNtA6CLYXYm41Z43BrI15ET7DJqwIPKKuEf/gdasyOyu82rxjY27v0oDhAdfgYAZ0MTjY221oNCH+xlW21nyCbJoH5sz4doOOV+urg7XrB9umEkPhGg1B67obR+4pGIN5LiRwD75VniUU/HhfXSOJq4e0i0zuILmrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J2rRNvCI; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J2rRNvCI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741022053; x=1772558053;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hcaUgBEfC+BiIJ7ri7/zJ0tzM9ZTNHGrRsZOZuavPEY=;
  b=J2rRNvCIg/lNCoFSDpmcM8vnjR5XeMT82X1KBpXKkF7EHL5dMTI2tcFA
   QdgZSWNj0swfDChLRfQIb0H2bgNpIr5fEMu963oxNphK5Dn95IzxMQuoo
   7Yq4nN6U8Kaod1mSsT1HMSmF8VKJM6OavkIXYLM1+C8xBWBtj2eJ/5UFI
   vHqbMC7RO87vurT5dF4L/VRUfthhKGegjgDjssA7V8XUDRtXXD9e1uQnr
   I2Gpk4M+KOW9l/ErsI0e8U3f06L0RIuy76e+I+x6X2ZBIyiaexVkMp054
   M88paG4wAafMNM4Smc9T+COLvmHJ6+WH42Dr31bxDaFyrz782Q6xRoVAQ
   Q==;
X-CSE-ConnectionGUID: rWvczdFiSNuPdh8K/+umzg==
X-CSE-MsgGUID: UfUIqtnSQc+rnxyW2Opkqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="59457301"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="59457301"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 09:14:12 -0800
X-CSE-ConnectionGUID: GxW4Ud1VS1WfIYb9ZvyQog==
X-CSE-MsgGUID: k3szYH7eSfirQI56XtEZxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="117838534"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 09:14:11 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 3 Mar 2025 09:14:11 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 09:14:11 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 3 Mar 2025 09:14:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hberib0UnHPIKMURB3yAFteZIrOE91tiz28qwuFV5NoParzFmUPcCuYmYiJ8LLqgDmUXl1+4hKR3JtfbO3GjSoG32bKezpH7k/MNChP5VrYroBwKwlKnZHTYoEH5DLYDyGWLSDKYaWSjFi8gCzBLpxZ1CKv2nHWUXZ8SFVkFgU0pTDHV4GF1E+Jn7FLLE8oUSj3SE8V67WG7HeGBXH5akiR9RCEtQrRdT+wBEfGfCIKIkgiSHNJF7X3oVyuTbunK2uT4VIvW9sYNzHNKkIknJcffWRtGy2o0gdlTRBeNLi/Kqvd3pPbl6OuDXnVat2xbOgeUKWU5VxFnbOx2K385VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcaUgBEfC+BiIJ7ri7/zJ0tzM9ZTNHGrRsZOZuavPEY=;
 b=HReVg+k7G2yaNpEAjelwXlj0E66FQEBVaxqI2hCIyarfg/tAkbfNa40zEjwLtpaXHxaSz6QPrd3fGdNOnoTKrMq/FTrjvv0/1YneMJryihz45rYvFoWtDofheNBRVuZ+6sT+XRYSPyDf5dHGVyTeYb5VkxdEqZL/fAm59wyOT8QkN+YWNOKPJTfyP1p82ZuDgw0H/ECFy99QQ1eqmGbvYMQyvwj//C8urUBc+9NxLErYNjhxtH38kM1/6Q4UjbjFR20ENIk4fmLRy5v4R/4SRlsC6UZazudw3sA9dODQX6ta+4UNkuHfsFxEppmSVWWx4WlMfgN/JGSmsmErkG4LGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 17:14:00 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 17:14:00 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "namhyung@kernel.org" <namhyung@kernel.org>
CC: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "acme@kernel.org"
	<acme@kernel.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>, "irogers@google.com"
	<irogers@google.com>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: Re: [PATCH] perf stat: Fix uniquify for hybrid systems
Thread-Topic: [PATCH] perf stat: Fix uniquify for hybrid systems
Thread-Index: AQHbihqFTRJn5Ut5k02+AX0kNwRa87NdaD+AgARC2AA=
Date: Mon, 3 Mar 2025 17:14:00 +0000
Message-ID: <9518fabeb6a2bb206cd9219f2e18af86e19663c5.camel@intel.com>
References: <20250228195351.1160071-1-thomas.falcon@intel.com>
	 <Z8JQRbjuhILt7-B4@google.com>
In-Reply-To: <Z8JQRbjuhILt7-B4@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|MW5PR11MB5810:EE_
x-ms-office365-filtering-correlation-id: 57f10aa3-7ded-4705-5949-08dd5a76ca64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QjFvTVR6VWtPNFk4ZzJHNmhFNm1vTEhkSEtSRWtDR2dlS1NURTVkMU1LdllK?=
 =?utf-8?B?ZDVicGFEdkp6YWdCa0JSNnpXSlFBV1RiYkljcnBXQjFZYW5nY2dZRmJtMlNk?=
 =?utf-8?B?UGtacHBXc1lNdVNSL1lVQnRaaTJxUUptaVhOSUpyVmtnczd2UzVSTzU3ak5w?=
 =?utf-8?B?RVVyanorZ3V6NTdoRUtCQ29BRXM4UVBNRDZzVWUxQkpXT0RhUkh6alltcncy?=
 =?utf-8?B?RjZSc1ZiTkd0Y3diNm1sVXU1alZWVGFSVThHaXZ6cTNUclNzMzhtTklWQnZF?=
 =?utf-8?B?dXhjQlQ0dmJ0R3FrczBaMk5pUHVucC9FcmJhZkF3MUxJeTBkUjJLTEhmVUF3?=
 =?utf-8?B?dlk1VnF5WlYxaUxlOXpvYWI3NHZoOUdmM2FaTnpoelJIbitocTJEeFZzY2sv?=
 =?utf-8?B?SkptV1ZNOEpzK3pOa0dwZFRrR3E4QlZXcnZBUEsvcnpkNEJ6ZFIveTlWRWdi?=
 =?utf-8?B?Wk1QeEZ4MGljMnd1K0R6M1RMcTlocUhzdUdsd3l6Sk41NTJsdTJ1M2kyaVND?=
 =?utf-8?B?cHh1OHdCRXlTUUpycVJrQWNUWkgwaFpyVURNL1Fnc0RvaVowbTQzekVaeDhl?=
 =?utf-8?B?NDc0L1ZuKzV2WG9aVlFCVFEyUERnL2ZJYWNDeThOeHNJTTE4VHREejB5LzFt?=
 =?utf-8?B?Z3NoQWVTTWFCckRLRlh5ZWNsLzl5NjBzWUVTd0tRRm5FaHZ0bXB1S3laSHVy?=
 =?utf-8?B?b3NTVit5YTVicWw3NThBZlBsK2Jod2dJeHExblVpQ0Fkc1lmSndpRU8raWY3?=
 =?utf-8?B?K0RYblFxd0tCWVJXbkg3dVZ1bGFhYmVOOERCdXA5dDl3d1E2SmVXR2RETXE5?=
 =?utf-8?B?NXpUN0RVSEVHeE1LVkNhdnNBNm1kTW10WE9KNGhVa04zOUVTMmhLbSszN0xz?=
 =?utf-8?B?ejk5WUI1ZGFHSThOdSsrSUk3RlN1T0Z5Z0tUTGRzL1BNamNqWXJuMDlvMW0v?=
 =?utf-8?B?YWcvSE5HMW96QzgxUzgxRklTUlVrbFRnbHRtbnRqMFlhcFgwdzZiVEhKU3dN?=
 =?utf-8?B?cE5hbmZ3T250U1E4bCs5eko4YkFIaCtSWXdJN3Nrd1FvWTVwU1pNMi9NZHIx?=
 =?utf-8?B?ejNIMlJLdW16N000SDVQbC9DUnI2d2EzaU9MR3JmeUlGVXNiZlgwa3JXeTZ0?=
 =?utf-8?B?cUlzcmVVcGhEQTR5a3pqdUd4R29nVGVOWnR1Slc3cWNlQUJMVnFsUmJDOTVx?=
 =?utf-8?B?ZGZiS3djRzVYRDIrMENqVDQzK2Nid25zTzZNYUFsUnF0TUsybFc5cXVzekRN?=
 =?utf-8?B?T2kxdHpFNE16bFlOd1FWVTR5VmZBMVQyMkRkVWpsaThqbzR1N0pFMER3cUFu?=
 =?utf-8?B?MnpZaFlhbGJGUHpkMDlEQlRtakkvZmt3VWQ5NDYzemN1a2ZIVlIrK2dOUk1Q?=
 =?utf-8?B?d0lCSzMyd3pTWmgwUzN6MzF2UzZzUlRJSDd5WXpKc0MxY0lYdHo1SWJIMGZX?=
 =?utf-8?B?RS9zYk5ZallNN1kzcm1sOE90RGF5NVVoN0FtdkZMZ0diTHk5L1N1aHBhY2dy?=
 =?utf-8?B?bVNBSjE1b0swU29lcW8vZlF3eFQ2QzJjTzdqbjlhSDhteklvY2I3dlIyRzkr?=
 =?utf-8?B?T2s1S3QrRUgzWmtPY2p4YXUyOVJRd0ZrM2JWb1c5SU8rZE0rSGlUWTZ4Z3JS?=
 =?utf-8?B?L2ZvVVROWm13d2xteUV5Q0R0Q1FtNGZocUpXbyttOURUdEIwUjhRWVgvUnJx?=
 =?utf-8?B?bUxENWlBdkVDZXo0WnAyNkhWa2lGZzFlYnlZV0hhYk9xQ0s4VDRWdjh6WEs5?=
 =?utf-8?B?VUEybW4zYmhPWUl2MlQwL05jd1JLdVQ3anpXUEdqbVpqLzhSVG1wWmYxaFVN?=
 =?utf-8?B?UFhCUzUvWUJvRURmWXo5SWRtYlFwQk5YTU9WUXRVUTZWMVVWSk1NbmFvb0s4?=
 =?utf-8?B?OWhBdjdzOHFMc3ExaWpNRUJFb3J0VHR6MEZnRjkwQW1QQThYbDJpcWNlcWZS?=
 =?utf-8?Q?W/jm5iO72cinOjwtwYeqECI+JCMensLL?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dE5qZ2J6NTlmK3JvRCtCY3dOUUhhYURTT09oV3p4cm16N1RVYjJQdCt5ZVhs?=
 =?utf-8?B?OVg1ZTJlVDI4aHdLbVFna1kzYWJzM0k1MEtmZnpLc3FEKzBJQnpwM0FEaDha?=
 =?utf-8?B?NFdmVS8ycHNVQmZJZjZHMGQ2eVVyZ3VDQ0tyaG9sN2xWdWl3YzYrQ3FZMlB1?=
 =?utf-8?B?NkIvSWU2YUhwa1h4cWJuN2lSWTFabUVzVm9xcVBYaFBxOWUzNTZldkxiNnpl?=
 =?utf-8?B?RUdRS3o5akFsV2JBelNHMzVHdEFTZEJaY1JMbUxCdkkwN2wwR1piRitOTkpJ?=
 =?utf-8?B?ekQ0L3BTTHVnbjdTS3g5WitWRURxMVdZa0U2S0NVNFcrRjNEVXYydmVmdGZk?=
 =?utf-8?B?Yk5sYUZtTUVCdU1JcGN0ZEdWbVFGS2g4M0lwVUFWbm12WmI5Vkx3VVdRT2hu?=
 =?utf-8?B?NDJYVnRFZldVanZZWGhLNWZwV1NvWkxuY1ZSSjhMZlk0bXdOWkZ6eXlQV09J?=
 =?utf-8?B?aEY1TWdFMHhuMTVCWDJFQW5VV3ljM1p1Tm0zTjRFZndwVUxGL2d3S0wrYUtk?=
 =?utf-8?B?SFFNVy9pWU5Ib0hPZ3FPRFVyOGE0MkZtdHNQSTdlbWRvNUczUytrT2RkWmxk?=
 =?utf-8?B?dGhTb1FXQi8xeGVyL3J5TXNIODBsS1orUHhmZVRCdWxTd0wrOCtUSm10YWtt?=
 =?utf-8?B?VHFsSW1NOUdCZmJnT2ZXZ0R0M1RzRzRKRzhpaFlGSXhwRkNvdHhYZ3BJQVZs?=
 =?utf-8?B?TnlDVE1Vcm5LMFBXK1I4NTBNR01ReHFsdGZyVEJCMUlJK1hTdFd6WHRMelJq?=
 =?utf-8?B?Ymd6R2hOVFowcFhhYnRVbURNa0hTQUVhR0pSTDdZSGcySjdhWEp5aVNhWXpj?=
 =?utf-8?B?SDNxTDAxTEhqb0o5eXFKSUV2YkdZaHB2bGc1UUt4dmJTSDhyZDI0N2lhckxo?=
 =?utf-8?B?YkZtTDZQa2tsc28zUlZ5aWhUTW5aOWJBZUhCWHVGUmlvWnU5ZFQ1L3NsbTFX?=
 =?utf-8?B?OXFIY1NvVVV3VFBmRzhUMXV4c0M0dVh0YStjcU5OSmlzTWhicXg2ckxJR2w2?=
 =?utf-8?B?bEZOTWtDZ2o5dVU4cC9lY1JiM215dEJWVWJMMEV5QUVzRmFuSW5NOFZENlJ1?=
 =?utf-8?B?a0p3K2ZsRWptampZYUZ4MUh2UmdDdVNROG0yTVBBQWdwU2tJWkZKbFBydDll?=
 =?utf-8?B?amdjZzB3MU8veTJaNGVBMjM0UzNIaGhhaEF1aGN6Z1pOMjVNd1hSM3g0OGoy?=
 =?utf-8?B?eGcyb0hqR2xSVlUyMVMxTVpjMjNBcVFDengwK2E2Y3BVYmlnODNHMFFwMjVs?=
 =?utf-8?B?SXNWQWhkTFJzUUNPcXVhd2pvT1pHTmNhdUpNeUNDVFgwYnBVb1hsSGpwbGd0?=
 =?utf-8?B?ZUI5UUNpVHM3RzFFYjRjSi9KMzRkamJFaVQycFNsY2tqcHFEOVc5a1YvZUlU?=
 =?utf-8?B?aktqS1FTSEZjUmV2NW90MWptMkZyUEMvOGIrUFRmczhjNWVlc2RyUlhBMGZJ?=
 =?utf-8?B?cUU1R2tTTEp6eE0xaDJOVkQ5cmlUbnZHM1c5ZW1yWndxVVJoVzlyRWFJZ2Rq?=
 =?utf-8?B?VXVuSjZxVzBxT0wvbjFpai9oQlZnZWUwdFlLYzZ6cTIwTmRoRGtTLzFBWVha?=
 =?utf-8?B?ZjZOUVdKdy9aTllpYURBT1RILzdTOGcxY2R1K24wakR5UzlhcE5BQlhocTRK?=
 =?utf-8?B?aEVPK0U0eEVCa2NNSVduS01ROXIyU0poeVVqUG9KN1llWTVzcXRlV2Z6YU04?=
 =?utf-8?B?ZFdDRmIvQ1k5Nmw5SEl1WnRodC9XekphZGRhTWJiVHc5Mm4rUEhURi9FQmN4?=
 =?utf-8?B?c3lzL1hIazNSL3MyS0RZK25xY09IdDVLSTdxMGZNMmw1dU1OYUFadXhkWEtI?=
 =?utf-8?B?S3lvd0VlcDlPbFNCZU9SeFZlK0JTbHg2SG1FajdjKzBQTVNabFp6WjUydGE4?=
 =?utf-8?B?c3RDdjdGSjFUSXJjSWVWbm9xZk1tVHV4alVYMXpMdUpibjZoMW5VeVNPM2lE?=
 =?utf-8?B?WUZJMmRMcnN2bFJGRmlXSzF5cU9TYnFrN1RQWThla1ZxMVdhRXBJUmx3NWsw?=
 =?utf-8?B?YTBubGNDTElrQWtLMnFpSkVhQzFEejN4NDlkOGVGbEx4Y1kxd1ZVV1pEK0N0?=
 =?utf-8?B?ek9FZXV1NDJSekZOVi9XYTJWb1RCU3YxZmxJVEI3bXRGck9JY0J1aG5Kejg5?=
 =?utf-8?B?c3pmcm5BVDJ5djJlamVsdGgzdXRzbExaODJmTE5yWEt1ZXpDRENERkdJLzdR?=
 =?utf-8?Q?uIVydVCFPnZjhcBCHmFTHkE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6ECAEA412FAE174B8449CEC265C0E4E6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57f10aa3-7ded-4705-5949-08dd5a76ca64
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 17:14:00.4328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4f4YcAJwia5JSJyHqtCMRAsAux4ZAMvWm5HidSu/C35muW4RCQkjD40PvfFIZijs7L/cqXffR2PBuCWLL6Vegg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5810
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI1LTAyLTI4IGF0IDE2OjA5IC0wODAwLCBOYW1oeXVuZyBLaW0gd3JvdGU6DQo+
IEhlbGxvLA0KPiANCj4gT24gRnJpLCBGZWIgMjgsIDIwMjUgYXQgMDE6NTM6NTFQTSAtMDYwMCwg
VGhvbWFzIEZhbGNvbiB3cm90ZToNCj4gPiBDdXJyZW50bHksIHBlcmYgc3RhdCBpcyBvbWl0dGlu
ZyB0aGUgcG11IG5hbWUgZm9yIGxlZ2FjeSBldmVudHMNCj4gPiBvbiBoeWJyaWQgc3lzdGVtcy4g
Z2l0IGJpc2VjdCBpbmRpY2F0ZWQgY29tbWl0IDM1N2I5NjVkZWJhOSBhcyB0aGUNCj4gPiBjYXVz
ZToNCj4gPiANCj4gPiBCaXNlY3Rpbmc6IDAgcmV2aXNpb25zIGxlZnQgdG8gdGVzdCBhZnRlciB0
aGlzIChyb3VnaGx5IDAgc3RlcHMpDQo+ID4gWzM1N2I5NjVkZWJhOWZiNzE0Njc0MTNlNDczNzY0
ZWM0ZTE2OTRkOGRdIHBlcmYgc3RhdDogQ2hhbmdlcyB0bw0KPiA+IGV2ZW50DQo+ID4gbmFtZSB1
bmlxdWlmaWNhdGlvbg0KPiA+IA0KPiA+IEluY2x1ZGUgYW4gYWRkaXRpb25hbCBjaGVjayBmb3Ig
aHlicmlkIGFyY2hpdGVjdHVyZXMgd2hlbg0KPiA+IGRldGVybWluaW5nDQo+ID4gd2hldGhlciB0
byB1bmlxdWlmeSBsZWdhY3kgZXZlbnRzLg0KPiA+IA0KPiA+IEJlZm9yZToNCj4gPiANCj4gPiAk
IHN1ZG8gLi9wZXJmIHN0YXQgLWUgY3ljbGVzIC1hIHNsZWVwIDENCj4gPiANCj4gPiDCoFBlcmZv
cm1hbmNlIGNvdW50ZXIgc3RhdHMgZm9yICdzeXN0ZW0gd2lkZSc6DQo+ID4gDQo+ID4gwqDCoMKg
wqDCoMKgIDE3Myw5MDMsNzUxwqDCoMKgwqDCoCBjeWNsZXMNCj4gPiDCoMKgwqDCoMKgwqAgNjY2
LDQyMyw5NTDCoMKgwqDCoMKgIGN5Y2xlcw0KPiA+IA0KPiA+IMKgwqDCoMKgwqDCoCAxLjAwNjYx
NTA0OCBzZWNvbmRzIHRpbWUgZWxhcHNlZA0KPiA+IA0KPiA+IEFmdGVyOg0KPiA+IA0KPiA+ICQg
c3VkbyAuL3BlcmYgc3RhdCAtZSBjeWNsZXMgLWEgc2xlZXAgMQ0KPiA+IA0KPiA+IMKgUGVyZm9y
bWFuY2UgY291bnRlciBzdGF0cyBmb3IgJ3N5c3RlbSB3aWRlJzoNCj4gPiANCj4gPiDCoMKgwqDC
oMKgwqAgODQxLDQ5Niw2MDPCoMKgwqDCoMKgIGNwdV9hdG9tL2N5Y2xlcy8NCj4gPiDCoMKgwqDC
oCAzLDMwOCw5MjksNDEywqDCoMKgwqDCoCBjcHVfY29yZS9jeWNsZXMvDQo+ID4gDQo+ID4gwqDC
oMKgwqDCoMKgIDEuMDAyNDgzMjgzIHNlY29uZHMgdGltZSBlbGFwc2VkDQo+ID4gDQo+ID4gRml4
ZXM6IDM1N2I5NjVkZWJhOSAoInBlcmYgc3RhdDogQ2hhbmdlcyB0byBldmVudCBuYW1lDQo+ID4g
dW5pcXVpZmljYXRpb24iKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFRob21hcyBGYWxjb24gPHRob21h
cy5mYWxjb25AaW50ZWwuY29tPg0KPiANCj4gVGhhbmtzIGZvciB0aGUgZml4LCBidXQgdGhlcmUn
cyBhIHNpbWlsYXIgcGF0Y2ggaW4gdGhlIGxpc3QuDQo+IFBsZWFzZSB0YWtlIGEgbG9vay4NCj4g
DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTAyMjYxNDU1MjYuNjMyMzgwLTEtamFt
ZXMuY2xhcmtAbGluYXJvLm9yZw0KPiANCg0KV2lsbCBkbywgdGhhbmtzIQ0KDQpUb20NCj4gVGhh
bmtzLA0KPiBOYW1oeXVuZw0KPiANCj4gPiAtLS0NCj4gPiDCoHRvb2xzL3BlcmYvdXRpbC9zdGF0
LWRpc3BsYXkuYyB8IDYgKysrKy0tDQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS90b29scy9wZXJmL3V0
aWwvc3RhdC1kaXNwbGF5LmMgYi90b29scy9wZXJmL3V0aWwvc3RhdC0NCj4gPiBkaXNwbGF5LmMN
Cj4gPiBpbmRleCBlNjVjN2U5ZjE1ZDEuLmRmOWY2ODA4MGVjOSAxMDA2NDQNCj4gPiAtLS0gYS90
b29scy9wZXJmL3V0aWwvc3RhdC1kaXNwbGF5LmMNCj4gPiArKysgYi90b29scy9wZXJmL3V0aWwv
c3RhdC1kaXNwbGF5LmMNCj4gPiBAQCAtMTY3Niw2ICsxNjc2LDcgQEAgc3RhdGljIGJvb2wgZXZs
aXN0X19kaXNhYmxlX3VuaXF1aWZ5KGNvbnN0DQo+ID4gc3RydWN0IGV2bGlzdCAqZXZsaXN0KQ0K
PiA+IMKgDQo+ID4gwqBzdGF0aWMgdm9pZCBldnNlbF9fc2V0X25lZWRzX3VuaXF1aWZ5KHN0cnVj
dCBldnNlbCAqY291bnRlciwgY29uc3QNCj4gPiBzdHJ1Y3QgcGVyZl9zdGF0X2NvbmZpZyAqY29u
ZmlnKQ0KPiA+IMKgew0KPiA+ICsJYm9vbCBoeWJyaWQgPSAoIWNvbmZpZy0+aHlicmlkX21lcmdl
ICYmDQo+ID4gZXZzZWxfX2lzX2h5YnJpZChjb3VudGVyKSk7DQo+ID4gwqAJc3RydWN0IGV2c2Vs
ICpldnNlbDsNCj4gPiDCoA0KPiA+IMKgCWlmIChjb3VudGVyLT5tZXJnZWRfc3RhdCkgew0KPiA+
IEBAIC0xNjg4LDcgKzE2ODksOCBAQCBzdGF0aWMgdm9pZCBldnNlbF9fc2V0X25lZWRzX3VuaXF1
aWZ5KHN0cnVjdA0KPiA+IGV2c2VsICpjb3VudGVyLCBjb25zdCBzdHJ1Y3QgcGVyZl9zDQo+ID4g
wqAJCXJldHVybjsNCj4gPiDCoAl9DQo+ID4gwqANCj4gPiAtCWlmwqAgKGNvdW50ZXItPmNvcmUu
YXR0ci50eXBlIDwgUEVSRl9UWVBFX01BWCAmJiBjb3VudGVyLQ0KPiA+ID5jb3JlLmF0dHIudHlw
ZSAhPSBQRVJGX1RZUEVfUkFXKSB7DQo+ID4gKwlpZiAoIWh5YnJpZCAmJiBjb3VudGVyLT5jb3Jl
LmF0dHIudHlwZSA8IFBFUkZfVFlQRV9NQVggJiYNCj4gPiArCQljb3VudGVyLT5jb3JlLmF0dHIu
dHlwZSAhPSBQRVJGX1RZUEVfUkFXKSB7DQo+ID4gwqAJCS8qIExlZ2FjeSBldmVudCwgZG9uJ3Qg
dW5pcXVpZnkuICovDQo+ID4gwqAJCXJldHVybjsNCj4gPiDCoAl9DQo+ID4gQEAgLTE3MDUsNyAr
MTcwNyw3IEBAIHN0YXRpYyB2b2lkIGV2c2VsX19zZXRfbmVlZHNfdW5pcXVpZnkoc3RydWN0DQo+
ID4gZXZzZWwgKmNvdW50ZXIsIGNvbnN0IHN0cnVjdCBwZXJmX3MNCj4gPiDCoAkJcmV0dXJuOw0K
PiA+IMKgCX0NCj4gPiDCoA0KPiA+IC0JaWYgKCFjb25maWctPmh5YnJpZF9tZXJnZSAmJiBldnNl
bF9faXNfaHlicmlkKGNvdW50ZXIpKSB7DQo+ID4gKwlpZiAoaHlicmlkKSB7DQo+ID4gwqAJCS8q
IFVuaXF1ZSBoeWJyaWQgY291bnRlcnMgbmVjZXNzYXJ5LiAqLw0KPiA+IMKgCQljb3VudGVyLT5u
ZWVkc191bmlxdWlmeSA9IHRydWU7DQo+ID4gwqAJCXJldHVybjsNCj4gPiAtLSANCj4gPiAyLjQ4
LjENCj4gPiANCg0K
