Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BB1153BFC;
	Fri,  1 Nov 2024 07:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730446173; cv=fail; b=LhsYkMxr6HC3iCgk2XT1f5GI8W6UuFK1fdDukMayWX8snS2KIK9kAUUK7mcoq1nlsM0esuB12RHXI4ALLMZSPe3Qm1eUIYKzpuBFqIwjdKdHpLeP/QI8bH6ZpPWXxIbUp5jkTwuxc1kS5y1OXGP8iB05lABwIEjoom7rJgFLWdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730446173; c=relaxed/simple;
	bh=P9ujyf/aClrZtPEWNmmWQ5U/5v1Ex/tz8nppmRPxE48=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KCjs7scQvyMHBCP9xQVd6MuhL6z9Xi6wNgbbkgnWCrNyxtMHBHCqVKdfggyieam9kZeAHhIWTAi2uKOJAK+t0QF+i+kMaYhr9rTBipVO1++Q+D/jZnay0IwHsxFiWFcrTXzPM8pafnQ4DMrTqfP2imQnia7F61Eg/p0QBPBbGag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k7eCUSBI; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k7eCUSBI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730446171; x=1761982171;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=P9ujyf/aClrZtPEWNmmWQ5U/5v1Ex/tz8nppmRPxE48=;
  b=k7eCUSBIqhBMsJO5G69SoezDx8I8MwqpG2c5IjQ/7RkSUuq9b1uz8KzP
   UGVB4FRaBNxkgyKkE9fM0a2vcccrJAykPVNqkdGNMHut4H3ckXQc/CzuS
   2fuzfTN92kxG6VWSQLhU3siXzBJkIOoVuYdhIy834qt2m9wWWHeZWOebx
   h/9S0KzQlB+ob61B0Zu97HNdAc7q7iN/crrTJRyGBUnzo7VCb2t5vvda+
   dJYGYdBufXY/kAndxs23gZHjw/tCQ2bv8DL3Bs6LKOTIOlfdNEnBqm0Ak
   a/LTedvwp6lXeu4hdu4RaYmklquUFJpl0ckJwEibdJOMMD/kr/Ww3KoyQ
   w==;
X-CSE-ConnectionGUID: earJsaxmR5ewKltWQqaYbw==
X-CSE-MsgGUID: q8S78gtKQFKSCP+K92RFdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30376370"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30376370"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 00:29:23 -0700
X-CSE-ConnectionGUID: AJQLJiIxRke7LPG/JDWFdg==
X-CSE-MsgGUID: ia9ebVOTSF2HabZZgRiu0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="83036602"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Nov 2024 00:29:24 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 1 Nov 2024 00:29:22 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 1 Nov 2024 00:29:22 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 00:29:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFXtBz2MlCiuS077a2K4ttq9Mp6U9jaG1mbPvUgoYozJgfizP+xZiw6NVK8pp0jLTQJM9BcLWQVTFQTtXXZSDu+zIfmbzMKjeNtqEHAW0JZqbMxksnr28w/MrjSsDy5KpBEZXhCQK9UNqlZ/4VQoeuNX/u+ryzj1RGYDmg6w1D3kfXIonR9/LHuI5rTEec9KWFHs1yICaLnkx8SadyPpaGv1WU2YeOfAKiaoocTVujW7Ed6NshWHu3IBsq1mZ1oozooIT/v1sOkZm3qM7kZdUn4G632AtsHRXNXWm01/ux3HMaNx3jzle8LqCtbPUDIrovbNGYR2lUtEqIP9c7yb8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9ujyf/aClrZtPEWNmmWQ5U/5v1Ex/tz8nppmRPxE48=;
 b=iosa4h3TOOgfWKq/qMiE2ONGWni24o368sjUXfXiUE87Ti+/5fYPBQRiOHYmPpA2It0Wxgu/dXlyhlcRv6wacXNuEi3N9aa87hHV3kc/wfklmHJWbfJ97kJ4RqTv0vOsS3our0Rx9b/xOmT6efu9nm1SI9kmSALTHlQSwDwW6oM/KLbYQbu1H0QP2iNDVeBwSguU8rrkSxvVNNvRI5N/WNCBhc8CfujHbf2Ajj5yWRv3UDAGNVG4ASzReyugydlSPL3s19M1tWkz/lByaNQYQ329R43ywEIEFcBl4cnrtQkNVvTsm/vk9+4BW69n5nTP1dzNuMIfoJHLBvfvl4NEAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SA1PR11MB6848.namprd11.prod.outlook.com (2603:10b6:806:29c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Fri, 1 Nov
 2024 07:29:20 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%5]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 07:29:20 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"Dhananjay.Ugwekar@amd.com" <Dhananjay.Ugwekar@amd.com>, "acme@kernel.org"
	<acme@kernel.org>, "namhyung@kernel.org" <namhyung@kernel.org>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>, "irogers@google.com" <irogers@google.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>
CC: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"ravi.bangoria@amd.com" <ravi.bangoria@amd.com>, "ananth.narayan@amd.com"
	<ananth.narayan@amd.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "gautham.shenoy@amd.com"
	<gautham.shenoy@amd.com>, "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v6 06/10] perf/x86/rapl: Add arguments to the init and
 cleanup functions
Thread-Topic: [PATCH v6 06/10] perf/x86/rapl: Add arguments to the init and
 cleanup functions
Thread-Index: AQHbJs9XmqKpnzKsS0u0QwMrwW4TPLKiEeiA
Date: Fri, 1 Nov 2024 07:29:20 +0000
Message-ID: <cddb56a940b90da8f11ff73bbbbf196770d3ecad.camel@intel.com>
References: <20241025111348.3810-1-Dhananjay.Ugwekar@amd.com>
	 <20241025111348.3810-7-Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20241025111348.3810-7-Dhananjay.Ugwekar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|SA1PR11MB6848:EE_
x-ms-office365-filtering-correlation-id: f1933d3f-e002-440c-12be-08dcfa46e6d0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MkFFZEVoSW9qQ3psa0ZVS1JtOVJ5Q3BubVR5OVVUMXdGOTZ1MjBJWG9lRnc1?=
 =?utf-8?B?c0F3UGxZMU1CNHVwVWtUNUt1RzZPdUREM25jZElweXVuOUVTdHk5NUg3bzdW?=
 =?utf-8?B?MGc4bTlmZUtrUjMxVUVmUmNodCtyQUJCelJNY3l5WS9sY3o1UjE1bnRxUnJ2?=
 =?utf-8?B?MHhnZjA0MHBUYmYvUVpqZXdTelhxR3Nxb3NUWjVYTG5xOXVSc1dNaEVIRVp2?=
 =?utf-8?B?c1hnaWtGSEtYWE5iM2N5bDJtUjVOME82NHJiOFRSakZkMmM5WWZQRWVoSmgy?=
 =?utf-8?B?MDJPMFErZ1dpQUlPNmp3TytmbUtoS1FmNW93bGlhb3V6UGlPeHhDQ2tQQ0Rk?=
 =?utf-8?B?ekRDVjlJWHlGNU5ZdUdPU3FwOWVOS2R5RE9Xa29xZlR5Q0pDTzdBYjBhY2ZJ?=
 =?utf-8?B?QnJ0ejlxU2J0M0duQVg3OEEzVDM4V25yVFJ2Z2M2dXBBektya3Q0U1lCK2hy?=
 =?utf-8?B?V2NybVVqMEhqWTY2WUxLOUFad1JHbW9tZ21DT3VYV1lBNEREVVRueENiWHNP?=
 =?utf-8?B?cjBmK0U0dlI1aUtBQzFJN0M2dEZlaXVWa3R1akFCRG1PM2FTTTdCV1BmeEJN?=
 =?utf-8?B?aGVLeVpyMXh4ZUFvb0JZL05mYjdKNXJrQ2hxVDZIS21XV1F4OCsyL016Qm5l?=
 =?utf-8?B?WEQ3cFRTNG5nL040VVlaRjNTWjkxNzFNaXg1aFRLaTQyOEJMaytEdW4rdlpK?=
 =?utf-8?B?T1RqanhZbDFqb0ZQZ3Z1bEwwM0p4N0V0R1pHV2FTQkFNZVVDSTd1U0hXTSt1?=
 =?utf-8?B?SWM5bWxHNzllcWZsSWtZNHA3WVZMUjNQVVE3UkhyeDhmVEhUV0FUWDVhK055?=
 =?utf-8?B?NDNTcGI2KzEzbzJkZUE3Z1hKaW04MXVvWmRlNkc0VVBKYUU1MTZKTEI2SzBs?=
 =?utf-8?B?UWdBelAxRWVwV3hQNWRMZWVyLzZkSTF1OVZnaTEvZWx1QWUrdjlpajRLc1hH?=
 =?utf-8?B?MktmVVdoaFhqYStnaDJVQXpIZkJVaVJudEJ2VDNjMXJzYmhBQUcrbHFseWhp?=
 =?utf-8?B?OU5sVjBFNURETUFsT1AzZXJlN0pxY21FVlo0eUF6QXFLUVJWWjhSRmd0MXVu?=
 =?utf-8?B?c0VJa243eDNyL2tOeW9GdHdCRkU4UFVlOGhzT3VEeXFEdmk1MjM2Q1UxNGJn?=
 =?utf-8?B?TzhYbVMzUEhZdnh5bTN3WU1OcmM2Sm9TSmxPSjRCejNSV2NPVldOZG9CVFN2?=
 =?utf-8?B?Wi85Q3RDWkw5djZxN0NyeG9KdTlFU211UkJpSTBDeFFIb1hINUY0RDBQZDUv?=
 =?utf-8?B?Mkt2cFRJNHh1Zk9QMWpCelpMZldrS1lBVHZpT2hOeEZib3Bid0NXYURyU3Fl?=
 =?utf-8?B?WFh5M09lOHVKQTM3cCtTeTA4UkJkelhPOXpaYzZ0YldaalZFckNxNkdDdVpm?=
 =?utf-8?B?SDh1eHBKQWVmQXJobzFEVitQWU5kNmdyeDNXUUE0QkFZa1FOVU80K3FFSk1m?=
 =?utf-8?B?Y3d6N3ZTOXJPQ0NadDFNbUZLQTkzby91US9rSHZwRDNaMHVZTDRzdFVRanlF?=
 =?utf-8?B?dStJVHlzS1ZqRlpBb01oZm5oOEQzUVF4RS8zV2pzcFVGUFp4UXA5SXFiU3pD?=
 =?utf-8?B?N3k2Y3lNa0hua0J5cTJ1bUtyTlllMmhrTDhpeHVadS9OeVUwa1RleTIxdHlk?=
 =?utf-8?B?MHdiK1VhV0lieHA1NHUyVHRMV3g1RWpzYVRkYzVDd1pWdFkyd3V2NWEvN2px?=
 =?utf-8?B?TEk5Q1d4dGVjanhLUUhsa0hCRWdLRzdFUnFDZmY2QnZtdUhlSGU0OFE3bEJ2?=
 =?utf-8?B?ekpSeExsMGczTTdnRW9JOVB2QjBpZnV2dXk1dkRMclNuckdaRmNqNVE5VDZj?=
 =?utf-8?B?SjhJd2RkTStBbTI5TFoxYU1EQ1AyWm5PMTk4SjNpVEJwOG9vdmdHbElTTnVC?=
 =?utf-8?Q?2yXmRBdtJn1Wz?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0VsMUNrUW9yWmFUUXJBTE02cE0vOEowY0xZbnk5NmNjcXFxVTdWSFZZZG41?=
 =?utf-8?B?NlRKdWRML0J6cm5zTHR4eG9MOHZvYTY5c0RIVU9jelphZ0s5T1c1VlpJNzNF?=
 =?utf-8?B?Vm5GRmpKV0Z1bFE4TzhvMERSMmltTERBVU82NXRZWnNjZWFYdVI1Y0RONmYy?=
 =?utf-8?B?bWJOcndNL0Y0WXFqS2UzdXJnM2ZSaG5RSjljcENGRHlnUWJseUMxSjhFanRw?=
 =?utf-8?B?TW9TYTJMSVVxdnMxUGdUOEMzQU9XZk94ODdRZDRkRkJyRC80NzZ1RlBOTTll?=
 =?utf-8?B?UDFXTHdHdXp6bFlBMWlDTjdFeEUrNnROYzBsRDJTT084Ty9rbnpWMEJCUTJN?=
 =?utf-8?B?WkZMQTArVTAxRnozazJCMkkyU0tqL0N5aUtFRmdvU1lybVJFY0Jzek1ZN3U5?=
 =?utf-8?B?K3hoZFBUV0ZYUnpyZTQzZlhrSHBpckIvZ1F3eW1rbUwrc1dOcDhGNmdIa0JI?=
 =?utf-8?B?dTUyZnhMRUhaUDBYSUpmTFFKME5jaTZIeFVuN1QvbmNMbnpWa1dDL0lWcGhU?=
 =?utf-8?B?WUFKM2hTeG5IRXd0SHdKdDFDMS9WNFlaUzZ1b2l4QVM0c1cyRFZsNk5RdUlu?=
 =?utf-8?B?U0JNbkl6b0Y4eUh3VHU4a1NzK0p1dHM5RDRHN3E2bDdVWUZEaEFJRjJ5Z0lJ?=
 =?utf-8?B?akN4OGo0SjExUmxkNUxRbWtWRzNPaERYZ2MwaHYvQWpEeDdoa2VwL0Nyc1cz?=
 =?utf-8?B?MzBuNG5JRDdRMjAvRnJQSGppdTRFRTFyNExpbzFCTE0xM1FMMzBaTXZTMEFs?=
 =?utf-8?B?S0pZS01Sc1BPT2tqVys2dkYwZHhCcmhqRjZJN0xPYzhwYk9OL1ZpNmtnZldw?=
 =?utf-8?B?aHdLbVN4UHE2eEcxZGRNK3VLeEJsV2c1R2JzeHd2WG84ZCtuZjJtM3J1NXQz?=
 =?utf-8?B?MnR3cWRMa2twL2IrVGNUNW9mQUtTM3ZyU2VLMEtkQzd6SVplbWVqOENiOHlO?=
 =?utf-8?B?RG1wRERBQmRqVklxaVV2WjJoVlFXcmRPSExhZ1VPbFZHUG1TeFNodmdiQUsw?=
 =?utf-8?B?UXpnNUFtc2tyMkNxUkVZRTVQaEE4cTdVWHBHdysrV0tTOEpKUmF2NGFIVEdQ?=
 =?utf-8?B?bXJNQmdkNlZKVWxjYjR4Mzd5S3dtUFJhL2Zhd0NmMEtNUnIxdTBkWjZSRGNL?=
 =?utf-8?B?TFI5RVpuUzlIVnFVQ0pnZWZqVTl3cTlSS3pHcnZsOTVYVENUVUVKbXFOY1Bp?=
 =?utf-8?B?TWg4TGdncmVqL0xOSlV1NC9NOG1oMXcwcW1kdG0rVnlVM2JzYTRLSXdUbnVh?=
 =?utf-8?B?N1A1MGFJNXVxanU0SitFb3Z6bFN2aHZvMWk0dGVEOXBnOXpmWlJiT3BBU042?=
 =?utf-8?B?U2NVOXVXZTBSU2NwRTE0SjFRL1pBYjJDbEpDZTBtL2U2bUg0emR6RkdtMGJ4?=
 =?utf-8?B?d3dXSms4YUt1eStidisyUjdOUDVFTzRSK0xrZXVqWHdVajFTalA2OUI0QVNq?=
 =?utf-8?B?U3FsdEFHazdPeU9OU1hSUm9GNGN4YTZHZGhqUXU1bitVT1Blcy9sMC9kaEc2?=
 =?utf-8?B?Uk9uNzF5T2JVT3NGWTRpVmp6U0hDNFhxQjY4ZjE0RjZtbS9WVFVHZUFUL053?=
 =?utf-8?B?TkxFOUppL2NHNm9DT1NpZnhwak1RTEw4aVlZcENhUGU2amJYN2JHdk5nYlhI?=
 =?utf-8?B?VHdzcGVudlNxS25HeXdzNG1WQzA1Z1puRXZLWEZ2b1N1bk4rREMrejJqQTR6?=
 =?utf-8?B?NU9UNG9EeDVkNEhxL0dPeitaTXdtZU5OdzNyeDBiMWdJZ2RRUWlsTUhheUxt?=
 =?utf-8?B?UXJDUDFVenIzNkN1SEMyMHhNc3hCYTdiczM4K0lrQ3BzSFJaZ05QSit4QTUz?=
 =?utf-8?B?anFjb2dmbFd2em04RDRMamhEYVNQT0VtcGNmVyswcmdqSkxSbUwySDl3Umgx?=
 =?utf-8?B?YTZmUXVLWnhjTldyK3pubnB4Mjkzdy9sVDMwTXFIdlh3SDFKN0IyQmo3ZEUy?=
 =?utf-8?B?dmFNMG90ektRcCswT01DY0VoNkdscHF0cGY2ajdldFBzV2VjMFZxaUtOMit2?=
 =?utf-8?B?RC9rb05yRkticHcxWWRwQTVxZ1pHdmoxTUF5V2tlZUlhVTdVRDRyWGZCWTZW?=
 =?utf-8?B?MkpoczJFY1FDTkZHbWlkbENaUlljaHJVMWZCNmpOZXB5RWw5UHd4Rzd2TUcv?=
 =?utf-8?Q?mHfKt8+OxiuosY8Sr6TLkhep7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3BDB7F3274AF84F89BB9BF57A0577E7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1933d3f-e002-440c-12be-08dcfa46e6d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2024 07:29:20.6567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SDJaiqX6LnnFTzElZx+dZayHaOjiZqTUqNzzhW8N97o3NILu/qrdHeSPCUNaKQ73tpCj3qBiUE7P4X0a3thvCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6848
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTEwLTI1IGF0IDExOjEzICswMDAwLCBEaGFuYW5qYXkgVWd3ZWthciB3cm90
ZToKPiBQcmVwYXJlIGZvciB0aGUgYWRkaXRpb24gb2YgUkFQTCBjb3JlIGVuZXJneSBjb3VudGVy
IHN1cHBvcnQuCj4gCj4gQWRkIGFyZ3VtZW50cyB0byB0aGUgaW5pdCBhbmQgY2xlYW51cCBmdW5j
dGlvbnMsIHdoaWNoIHdpbGwgaGVscCBpbgo+IGluaXRpYWxpemF0aW9uIGFuZCBjbGVhbmluZyB1
cCBvZiB0d28gc2VwYXJhdGUgUE1Vcy4KPiAKPiBObyBmdW5jdGlvbmFsIGNoYW5nZS4KPiAKPiBT
aWduZWQtb2ZmLWJ5OiBEaGFuYW5qYXkgVWd3ZWthciA8RGhhbmFuamF5LlVnd2VrYXJAYW1kLmNv
bT4KClJldmlld2VkLWJ5OiBaaGFuZyBSdWkgPHJ1aS56aGFuZ0BpbnRlbC5jb20+ClRlc3RlZC1i
eTogWmhhbmcgUnVpIDxydWkuemhhbmdAaW50ZWwuY29tPgoKdGhhbmtzLApydWkKCgo+IC0tLQo+
IMKgYXJjaC94ODYvZXZlbnRzL3JhcGwuYyB8IDI4ICsrKysrKysrKysrKysrKystLS0tLS0tLS0t
LS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkK
PiAKPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvZXZlbnRzL3JhcGwuYyBiL2FyY2gveDg2L2V2ZW50
cy9yYXBsLmMKPiBpbmRleCA0NDdmNjJjYWE1ZjkuLmJmNmZlZTExNDI5NCAxMDA2NDQKPiAtLS0g
YS9hcmNoL3g4Ni9ldmVudHMvcmFwbC5jCj4gKysrIGIvYXJjaC94ODYvZXZlbnRzL3JhcGwuYwo+
IEBAIC01OTcsNyArNTk3LDcgQEAgc3RhdGljIHZvaWQgX19pbml0IHJhcGxfYWR2ZXJ0aXNlKHZv
aWQpCj4gwqDCoMKgwqDCoMKgwqDCoH0KPiDCoH0KPiDCoAo+IC1zdGF0aWMgdm9pZCBjbGVhbnVw
X3JhcGxfcG11cyh2b2lkKQo+ICtzdGF0aWMgdm9pZCBjbGVhbnVwX3JhcGxfcG11cyhzdHJ1Y3Qg
cmFwbF9wbXVzICpyYXBsX3BtdXMpCj4gwqB7Cj4gwqDCoMKgwqDCoMKgwqDCoGludCBpOwo+IMKg
Cj4gQEAgLTYxNSw3ICs2MTUsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGF0dHJpYnV0ZV9ncm91
cAo+ICpyYXBsX2F0dHJfdXBkYXRlW10gPSB7Cj4gwqDCoMKgwqDCoMKgwqDCoE5VTEwsCj4gwqB9
Owo+IMKgCj4gLXN0YXRpYyBpbnQgX19pbml0IGluaXRfcmFwbF9wbXUodm9pZCkKPiArc3RhdGlj
IGludCBfX2luaXQgaW5pdF9yYXBsX3BtdShzdHJ1Y3QgcmFwbF9wbXVzICpyYXBsX3BtdXMpCj4g
wqB7Cj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCByYXBsX3BtdSAqcmFwbF9wbXU7Cj4gwqDCoMKg
wqDCoMKgwqDCoGludCBpZHg7Cj4gQEAgLTY0MSwyMCArNjQxLDIwIEBAIHN0YXRpYyBpbnQgX19p
bml0IGluaXRfcmFwbF9wbXUodm9pZCkKPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FTk9NRU07
Cj4gwqB9Cj4gwqAKPiAtc3RhdGljIGludCBfX2luaXQgaW5pdF9yYXBsX3BtdXModm9pZCkKPiAr
c3RhdGljIGludCBfX2luaXQgaW5pdF9yYXBsX3BtdXMoc3RydWN0IHJhcGxfcG11cyAqKnJhcGxf
cG11c19wdHIsCj4gaW50IHJhcGxfcG11X3Njb3BlKQo+IMKgewo+IMKgwqDCoMKgwqDCoMKgwqBp
bnQgbnJfcmFwbF9wbXUgPSB0b3BvbG9neV9tYXhfcGFja2FnZXMoKTsKPiAtwqDCoMKgwqDCoMKg
wqBpbnQgcmFwbF9wbXVfc2NvcGUgPSBQRVJGX1BNVV9TQ09QRV9QS0c7Cj4gK8KgwqDCoMKgwqDC
oMKgc3RydWN0IHJhcGxfcG11cyAqcmFwbF9wbXVzOwo+IMKgCj4gLcKgwqDCoMKgwqDCoMKgaWYg
KCFyYXBsX3BtdV9pc19wa2dfc2NvcGUoKSkgewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBucl9yYXBsX3BtdSAqPSB0b3BvbG9neV9tYXhfZGllc19wZXJfcGFja2FnZSgpOwo+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByYXBsX3BtdV9zY29wZSA9IFBFUkZfUE1VX1ND
T1BFX0RJRTsKPiAtwqDCoMKgwqDCoMKgwqB9Cj4gK8KgwqDCoMKgwqDCoMKgaWYgKHJhcGxfcG11
X3Njb3BlID09IFBFUkZfUE1VX1NDT1BFX0RJRSkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgbnJfcmFwbF9wbXXCoMKgwqDCoMKgKj0gdG9wb2xvZ3lfbWF4X2RpZXNfcGVyX3BhY2th
Z2UoKTsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqByYXBsX3BtdXMgPSBremFsbG9jKHN0cnVjdF9z
aXplKHJhcGxfcG11cywgcmFwbF9wbXUsCj4gbnJfcmFwbF9wbXUpLCBHRlBfS0VSTkVMKTsKPiDC
oMKgwqDCoMKgwqDCoMKgaWYgKCFyYXBsX3BtdXMpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqByZXR1cm4gLUVOT01FTTsKPiDCoAo+ICvCoMKgwqDCoMKgwqDCoCpyYXBsX3BtdXNf
cHRyID0gcmFwbF9wbXVzOwo+ICsKPiDCoMKgwqDCoMKgwqDCoMKgcmFwbF9wbXVzLT5ucl9yYXBs
X3BtdcKgwqDCoMKgwqDCoMKgwqDCoMKgPSBucl9yYXBsX3BtdTsKPiDCoMKgwqDCoMKgwqDCoMKg
cmFwbF9wbXVzLT5wbXUuYXR0cl9ncm91cHPCoMKgwqDCoMKgwqA9IHJhcGxfYXR0cl9ncm91cHM7
Cj4gwqDCoMKgwqDCoMKgwqDCoHJhcGxfcG11cy0+cG11LmF0dHJfdXBkYXRlwqDCoMKgwqDCoMKg
PSByYXBsX2F0dHJfdXBkYXRlOwo+IEBAIC02NjksNyArNjY5LDcgQEAgc3RhdGljIGludCBfX2lu
aXQgaW5pdF9yYXBsX3BtdXModm9pZCkKPiDCoMKgwqDCoMKgwqDCoMKgcmFwbF9wbXVzLT5wbXUu
bW9kdWxlwqDCoMKgwqDCoMKgwqDCoMKgwqDCoD0gVEhJU19NT0RVTEU7Cj4gwqDCoMKgwqDCoMKg
wqDCoHJhcGxfcG11cy0+cG11LmNhcGFiaWxpdGllc8KgwqDCoMKgwqA9IFBFUkZfUE1VX0NBUF9O
T19FWENMVURFOwo+IMKgCj4gLcKgwqDCoMKgwqDCoMKgcmV0dXJuIGluaXRfcmFwbF9wbXUoKTsK
PiArwqDCoMKgwqDCoMKgwqByZXR1cm4gaW5pdF9yYXBsX3BtdShyYXBsX3BtdXMpOwo+IMKgfQo+
IMKgCj4gwqBzdGF0aWMgc3RydWN0IHJhcGxfbW9kZWwgbW9kZWxfc25iID0gewo+IEBAIC03OTMs
OCArNzkzLDEyIEBAIE1PRFVMRV9ERVZJQ0VfVEFCTEUoeDg2Y3B1LCByYXBsX21vZGVsX21hdGNo
KTsKPiDCoHN0YXRpYyBpbnQgX19pbml0IHJhcGxfcG11X2luaXQodm9pZCkKPiDCoHsKPiDCoMKg
wqDCoMKgwqDCoMKgY29uc3Qgc3RydWN0IHg4Nl9jcHVfaWQgKmlkOwo+ICvCoMKgwqDCoMKgwqDC
oGludCByYXBsX3BtdV9zY29wZSA9IFBFUkZfUE1VX1NDT1BFX0RJRTsKPiDCoMKgwqDCoMKgwqDC
oMKgaW50IHJldDsKPiDCoAo+ICvCoMKgwqDCoMKgwqDCoGlmIChyYXBsX3BtdV9pc19wa2dfc2Nv
cGUoKSkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmFwbF9wbXVfc2NvcGUgPSBQ
RVJGX1BNVV9TQ09QRV9QS0c7Cj4gKwo+IMKgwqDCoMKgwqDCoMKgwqBpZCA9IHg4Nl9tYXRjaF9j
cHUocmFwbF9tb2RlbF9tYXRjaCk7Cj4gwqDCoMKgwqDCoMKgwqDCoGlmICghaWQpCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVOT0RFVjsKPiBAQCAtODEwLDcgKzgx
NCw3IEBAIHN0YXRpYyBpbnQgX19pbml0IHJhcGxfcG11X2luaXQodm9pZCkKPiDCoMKgwqDCoMKg
wqDCoMKgaWYgKHJldCkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBy
ZXQ7Cj4gwqAKPiAtwqDCoMKgwqDCoMKgwqByZXQgPSBpbml0X3JhcGxfcG11cygpOwo+ICvCoMKg
wqDCoMKgwqDCoHJldCA9IGluaXRfcmFwbF9wbXVzKCZyYXBsX3BtdXMsIHJhcGxfcG11X3Njb3Bl
KTsKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKHJldCkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHJldHVybiByZXQ7Cj4gwqAKPiBAQCAtODIzLDcgKzgyNyw3IEBAIHN0YXRpYyBpbnQg
X19pbml0IHJhcGxfcG11X2luaXQodm9pZCkKPiDCoAo+IMKgb3V0Ogo+IMKgwqDCoMKgwqDCoMKg
wqBwcl93YXJuKCJJbml0aWFsaXphdGlvbiBmYWlsZWQgKCVkKSwgZGlzYWJsZWRcbiIsIHJldCk7
Cj4gLcKgwqDCoMKgwqDCoMKgY2xlYW51cF9yYXBsX3BtdXMoKTsKPiArwqDCoMKgwqDCoMKgwqBj
bGVhbnVwX3JhcGxfcG11cyhyYXBsX3BtdXMpOwo+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcmV0
Owo+IMKgfQo+IMKgbW9kdWxlX2luaXQocmFwbF9wbXVfaW5pdCk7Cj4gQEAgLTgzMSw2ICs4MzUs
NiBAQCBtb2R1bGVfaW5pdChyYXBsX3BtdV9pbml0KTsKPiDCoHN0YXRpYyB2b2lkIF9fZXhpdCBp
bnRlbF9yYXBsX2V4aXQodm9pZCkKPiDCoHsKPiDCoMKgwqDCoMKgwqDCoMKgcGVyZl9wbXVfdW5y
ZWdpc3RlcigmcmFwbF9wbXVzLT5wbXUpOwo+IC3CoMKgwqDCoMKgwqDCoGNsZWFudXBfcmFwbF9w
bXVzKCk7Cj4gK8KgwqDCoMKgwqDCoMKgY2xlYW51cF9yYXBsX3BtdXMocmFwbF9wbXVzKTsKPiDC
oH0KPiDCoG1vZHVsZV9leGl0KGludGVsX3JhcGxfZXhpdCk7Cgo=
