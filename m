Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C37D14A4E9;
	Fri,  1 Nov 2024 07:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730446127; cv=fail; b=E8TNlUfe796uKW4VQMelf7g660u8Q/KBBlCNOTmRbTAHzo8HP7cexgx/027Hs7qalREvJGCgAYAEVrj86Q4T5Iwr9AKD92vtXfMm5OadeTEwRG62LO7WAp01kwQ3RBVbsNgC/9EoKJlVmhFRyMqvOpYq0/2TgU7Q3bAtbDWlPns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730446127; c=relaxed/simple;
	bh=KgzDWhJGLZzZJk+jNfK9YPwVYwnVDoeit4c0LPb8cmI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lCS06YOW0zZx4ye9gMs9z48/699FHUHus98Y3R9GbRmfHWvCSpEeruWhiNu9ZtnIAW8IF76sEtJCgurIzctGMtvmpCNcHayu7LXNYRJBKrHh1lfePmgXUYCHA6qxjQ8Wi8pEwSdw0XDfmKuheW3JzzA+tgKepIjSIbGJV+R/cZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D87AtZt5; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D87AtZt5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730446124; x=1761982124;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KgzDWhJGLZzZJk+jNfK9YPwVYwnVDoeit4c0LPb8cmI=;
  b=D87AtZt5oKjIXghiolEQdEg3V6RSau6FaIBzRyzFbyMytBh9GZwoSvUF
   ZZV7TQYYF9k1MhCSCcXDTLb65AgVpW/A6efPAEWwK4tMAXg5JpCozBNr9
   yOwC0x0094+e/CMjrVZQzXgb3OVCk5zZcuIIWC8SOYfI0pKAbC+3ZV4CB
   PwrOFTD0yJOBjVmAhpQSfqIP7cNlqmFoFe/VKyEHYbKLF/irdLpIYmoN8
   yiz68HwzWUD4j3oE3ZG6KM6suHxcTOIMC2KsWCal8UyOGOHYYjiIIT10E
   J/sF7uSETA2f6gygeNU8OxtDZzaJE30ydGq11idaE4cRt4bZI6UvX6LNn
   Q==;
X-CSE-ConnectionGUID: ss60VMrnRmip+h7Boh1DYA==
X-CSE-MsgGUID: Eqm9j3HuRly9as5AoBHWuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="40789399"
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="40789399"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 00:28:44 -0700
X-CSE-ConnectionGUID: A/CxgbOWSNeiUhlrvYB1ag==
X-CSE-MsgGUID: 4c/w3NWCR+emRAZqQqoRNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="83007151"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Nov 2024 00:28:43 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 1 Nov 2024 00:28:43 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 1 Nov 2024 00:28:43 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 00:28:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YigLS/MBdy94XDMChYgdj3CjLUZQSU78P8e5OAJ7nJs+j/2Jdv1cjRdGdYW3lhApWNzxRgMgrySxBKEEKft530oC999mn+sk/GwoyjgUhG8ZeQ3lX0ZiKvfWxCeySGfgwMia/bzuJMIv+K724VXh+soavUq5OhKBDfRZbEgX6KKsBIH0HP+OTYXPhnI95WMJHJ/RgczTkk0ixpzrSi4yMT8k0Kk6Dmb/Cea4B4k7G87ciKmdit8YfpPmrSOIkCAIxq69e+0ik0NztHjlLd4K1Aed8fGLN4AEM5pH4c3E1hjJAOyuowMFflNrILX2KfmX/Qx6gZa0CmPSG+QbqbYDww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgzDWhJGLZzZJk+jNfK9YPwVYwnVDoeit4c0LPb8cmI=;
 b=bZTXH3RoFdYvQBB33CJ2UYpjKPoFNBCZNAi6GmQk/raSgvczAGgaFL/q8msvCGXQH9gSSQ1gcEWhGC5IFvIdjN5+Y+MeQol/BB+rTLVe0LOi0DNRm9uRg6zG77xPm+ksTeCEOGWJdAglsJikY+KoJ5EeGAgjnDlw1lyREKi/JRW6CI1ecXm2BgCbUIYJWG0duGBiP+YXJZ8HT/iPz9pdCq9ogrCOeXJSzFBQo2WUT653dqe1dRwmHV2ox7jiaEgmGVmRmD+8zZcHSo2a3duPkKsnQko7bM2N2LH11NGgo5h9nGq/jMLGHzUlR5cm0uh1lkjv4Av0YVBYFRKZcTRN8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SA1PR11MB6848.namprd11.prod.outlook.com (2603:10b6:806:29c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Fri, 1 Nov
 2024 07:28:40 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%5]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 07:28:40 +0000
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
Subject: Re: [PATCH v6 03/10] perf/x86/rapl: Remove the cpu_to_rapl_pmu()
 function
Thread-Topic: [PATCH v6 03/10] perf/x86/rapl: Remove the cpu_to_rapl_pmu()
 function
Thread-Index: AQHbJs8wlyvPvXT1VEWmwWZENYr1XrKiEbcA
Date: Fri, 1 Nov 2024 07:28:40 +0000
Message-ID: <da8e731480d0f4b8284c6fc69e68f2aab2b23292.camel@intel.com>
References: <20241025111348.3810-1-Dhananjay.Ugwekar@amd.com>
	 <20241025111348.3810-4-Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20241025111348.3810-4-Dhananjay.Ugwekar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|SA1PR11MB6848:EE_
x-ms-office365-filtering-correlation-id: 337f97a9-9fc0-4a77-514f-08dcfa46ced2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?L0dnTTB4L1VmUHRRNlNJNVFPVmt0TUE1VldpZFZ0Q1AwVmhyb2xNSExvYWp6?=
 =?utf-8?B?NFM1SlFVdFRtelJ2a081eGNBaHI5aFRxakY1Mm9MdklVODd3RDlXcE9SMWZa?=
 =?utf-8?B?SkNVVVZQMUhqTFUrWGxZc1F2YlB4ZGtXNDZwc0VoREpnQVhBa1lLdzhFbTdM?=
 =?utf-8?B?WWpzV2ZXazdpMVc3RE15azAvUU9MUE9kbWRyYnBtc0NPRmUveWtsQnB3Z1B6?=
 =?utf-8?B?UmNxOWNzaU1MWVZQbWdZdElleXJsNWNuZjNIMm8zL291d1NQY0R2MDBEYm5t?=
 =?utf-8?B?VGNEQ200T205NEZSTnpQZFZqTmUvUmJmYURiNk4ya0FYek5Xc1JZL2Z6NHkr?=
 =?utf-8?B?dW96SmpGeFVvUmZQNEdEOFNzK09oUTZzTVl5K0trRVdJQ01XbWJNbUtmeW1E?=
 =?utf-8?B?eW9YMnFlN005ak11TW9zMlIxbG5Xa2RObjl6eWlBc0I2a0h3ZGpHNHJ2QS9y?=
 =?utf-8?B?Wk9rS1RDNlFVaVY5Qk1IL1pabEdDbXFMUGlRUXBITWNMeVhiMGZ2SDlCSzlY?=
 =?utf-8?B?dGMxRUpmeWdBNHRpUHRqOGp2RlNScmE2U3VoMmtmWFZiN2t5MmFhQThNWFVI?=
 =?utf-8?B?OXJsTktldWgvUlFlNTd3WW5vQm9xdkJEK1F1eUFpdjVyTVc5c2t5YitJbkpu?=
 =?utf-8?B?U2hSbW15RVUwRkh1YWhYRDFKMUE4a2gzT1pFbDBVS0IxUnRLWjRkYW00ZTNu?=
 =?utf-8?B?WGFkTDB2L21pak81SHgvVlJlNGhOdThyYXo5RnYwUUwrVW55VFl2ZGl2WHJx?=
 =?utf-8?B?aUxUdWpBNERER3U2VWlmZW1rWjZEUXFXaGNkNEt2eXNnRU1pb0tCVDV1VTFL?=
 =?utf-8?B?TWh5MHk3eFdSMDl6bVA2aDhuWHMyYlUxcWVkdVRxRlhxUHVNamNoTkhNcXFS?=
 =?utf-8?B?QnNjZU5KRU1NNjBkNEs4MjJmQjcxeElnRjhRbXBlbE1vc1h3YWtIWFM0YTBm?=
 =?utf-8?B?enp3ZFRJTFNDWkNxeW1jdzVLU1h6Zi91KzlPbWRrdFM2ZFhmclkrenZNTVJp?=
 =?utf-8?B?S3BiVHBIa1Z2MWJUSU54S09pcklhQ3NtQlYyZlVDbHQvK0w4V1E1UTVxOUVo?=
 =?utf-8?B?TkhwdXZQWWRRVFN5K0QvaHB1YjQrS3Ntd1pEWUExcmxTQUhWV3RKUk5LbEcr?=
 =?utf-8?B?VElzeXlwYVNRekJYL1hWa1NZVXFSaHh4L3FjQUFDbGE3OEl1R2ZXemNnbGFs?=
 =?utf-8?B?SUVmZ2piNWQzcGdsb0NVUXdoS2lVMlRpd0p2STI2SlZ1WXpOYUZTWk91RllH?=
 =?utf-8?B?Ynp1UkRSdmMxSk1OWnBGSDZySHRvNU5EWmc2RVhYcFFHTExQZElmY2o3S0pj?=
 =?utf-8?B?bFFHY0VEd0ptSXJsbHIwT3dCclMzRDVDbzRESWlvVWNzR3hsWlRleHplMGg5?=
 =?utf-8?B?UUtIWlo5VFJMY0dmWE9ydldHa20wWW8weHZkamZuTEIxc0F5ZzMzV0VIRkxI?=
 =?utf-8?B?ZCs5dnBUQ3VqUlVmVEg1WmdUeldDZHFjV1RsUkYweHdFd3ZaQXN3M3liNVBY?=
 =?utf-8?B?REs2M3lPZ0hrYVdENmdlc3JrVGFnZGwrMXV4MlQ2TWJVYzhDMGR6ZEsxUmw5?=
 =?utf-8?B?bTBWcStLd3YvS1hBVVVpN3JiOTVnWEh0WkN2SlNqYkdheDZTQ0NHYXRaZHFk?=
 =?utf-8?B?VGdOTkNRaTF6RVJJYWwrTGlIMHdEUnM3aVlVK3dFcTVkU3M4bGNyNDhGcEsw?=
 =?utf-8?B?MXdwVUtUYlVOeThxZDhlUXJna0VjOHBISmRlanAvdXFxWnFwQktHOWtmVE1O?=
 =?utf-8?B?dkFhOVZPOE90VjQ2K1N4U3l5bSsvK2paTmxMMmNiUGVrclN4MmpWZzZMNEM2?=
 =?utf-8?B?d1cxbGZ0c0pGdU5uRVBWb3FQWTh1enRsaVd5R28wWDlUOG5ZZDlpSEFvYTZW?=
 =?utf-8?Q?7OzZ+eL7dyJf5?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHJ0RmNhcFF5TnhobTl6STA2SVUvR0hHOGs5c2tPS1U5Vk1XSzVzTEZtem1U?=
 =?utf-8?B?RDQzNGlxdFFnUXBNd0d5TFZQdU1YQ252ejNmMllLZlBkd01tNURmanF0TjBp?=
 =?utf-8?B?Rk1pZ2hWMUJ0OGNQQkduWHROQ2w2dTZxWXFKMlY2cWRsYlJhRGllTllXdXRI?=
 =?utf-8?B?aSsvQzRRejBXaEgwSEoxUHI0UGVkalpCMUZLbngrNldCbDRFbXErY3NkUlRJ?=
 =?utf-8?B?UDh2R3djU09icU81eTZlQzdSMGJJSjZzSkJTU1RMU2RYOFNoRVdKUndscHhl?=
 =?utf-8?B?U0tLNk4vMjlUM1hVeUhVTjlUT285YmR4OEo5QkRIZFFnSFBSV0NBYTN0alRa?=
 =?utf-8?B?Z2RMeHFRK2paeW9GZ254Q0UzWFZpQ0R2Uy84RG5hdlZ2WGwybUhoRm1rQnYy?=
 =?utf-8?B?N1BHYVEwZ3JrVjNsTnprNzBNTHRXK0RTK0lrUHpVOEZRd3oxb2dUM1RUR2Z0?=
 =?utf-8?B?RitrV0NZaSs5QitSUWlpTVlyM3N5V05sNkdIRjZEK2ZlWkVlK0pIOEo1aE5L?=
 =?utf-8?B?ZytZVWY4S1VVSXQ2MGV0V2pRT3gxVzlIMnV5SittZG5CVitzZDRnR3pEclc1?=
 =?utf-8?B?TktSNXdvTVZLVExnUE0rUnltSnF2c0tHVi9uMkMyc0FiMUd0dUttOXlES3hi?=
 =?utf-8?B?YTFoMVBSSEpQczhFakttQmdJbDRUY0ovRXFGSW5YV2ZxNzVpekpHTW9CdGhN?=
 =?utf-8?B?Mm5tMmE2NTBOVTlKMWtyMlFqdngzOTV4cnpRSmdxdmU5QzhXVjZQZDlNWFFh?=
 =?utf-8?B?eXdvcHByelZFZ1A0Nkk2NVNpRm54WVdUZTN0ZkJ4aXllYi9xY2dkN3hCd3JI?=
 =?utf-8?B?dEhOTzYxNCtLaWxocUovcUsxR3dlbWNDMktVc3lIckIwNHI2R0xTeEJLaFln?=
 =?utf-8?B?cnA1UzY3TnRveHRqMENQdktteWt1SVpwMC84eWFOZHBLRmhTT0I0cU90b01h?=
 =?utf-8?B?M3JuUTBFbGlwck53NVBjRUJCTmFyY0JxNDRBZ2V0eHhndXJJYSs3UXN4T0Rq?=
 =?utf-8?B?S1IrazhpYktBSEUrYjQyTytId3Jra2l0S25UWTRCbHlZVkl6Q0Jldk05cnVv?=
 =?utf-8?B?d1F2eURUT0NMR3oxaWtzWlBkU2ZJRW8vSVgxOG1UTmJoeHNaelRSeHVRaVcx?=
 =?utf-8?B?cDNmL3Nza2V4M3RDNnZnWVZ6dzJ0ZEo2dmJ3dWpoL3c5N0lwaVppL3FzK0Jz?=
 =?utf-8?B?cW16a01nRXhvSEdmMDdWUi91ZWFZTVBhaktpYnVGWm5WU3dlSE5tNWZMQ3p3?=
 =?utf-8?B?T2JHdUZiRmNEekltakVzSS9SeDlBWnJkOEpObkNQT0hxLzFjVzZ6R2d6MmRW?=
 =?utf-8?B?U0V5cDNSOTh0UHoxWlpiWndhODdYQjQ0MGkyNHhsMUcwQWFuMHBLWnlXREtC?=
 =?utf-8?B?dnNVWElqT3loQXJQUGFIeUhKdG5nMlNXU3pFc0NrekR6MU5FQUQ2YTV4NmNT?=
 =?utf-8?B?Wk4wUUk3VHY5YWdrOFlzbHFNMHA3ekVMQ0thVHkreVRYWi95VCswQWp5UDFh?=
 =?utf-8?B?dTNpekQwM01DalBqTnl4ZnRIbVFROTdXQ0xJU0U5QmJFSzB4TWMxSkEvY2dB?=
 =?utf-8?B?MGt6dnNxRkFzYlBMZnJXM0ExQnNYYzhITFphN0VYWU1pS1NpdWpQMlc1dnFu?=
 =?utf-8?B?Q0tVV0hZdnhWRUhwRzdXZXgyUVBuNm5DYWpYWTVQZlZwUWIrT1NVSU9HZVVJ?=
 =?utf-8?B?YUcwbDRDQ2tNOGVyS21KeHlvK2NiaGhjU2ltWktGTDFHOWR6RXNvcXUxWkVs?=
 =?utf-8?B?YkVORUZuZ0NadHBrZjdhQWxmeWpsRCtTSFJuVkdvQXk3aEQzVGN1RVJvSDA2?=
 =?utf-8?B?ZjMvMmhYa29pYUdGcTZKZFQzQUxmazJvd2MrUUNlNXZ4bENacGU4MFlKRldI?=
 =?utf-8?B?MmQvM3B1VTVyWGZselk5V01MdmFUclZQZzF1a2lQY2VsZWVCQWUvTVc1WCta?=
 =?utf-8?B?RUY3UVE1WjVkQlFNdzFlOER2TE80VlpUQjNXTVM2YmIrY2gwV1N6THpUT2t3?=
 =?utf-8?B?R0I0MWQ5SzJwRDE4SzAzakt6N3A1TlY4RTFpeGJqaW9kY25DUVFrRGJTM1JV?=
 =?utf-8?B?bFAwb1FOaEc2NXh1K2JRWDVYUUgvdVVXSXF0RU05ODIyYlJRbStsV2NGY0Vv?=
 =?utf-8?B?MjN2NlpMdjBmQ1dYYkxPbVFIWlVCSm40RjRHOUZpTVBtSEpJYzdLR2YvMDlw?=
 =?utf-8?B?WUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F22C347ADFC3724C9FD2F47A000B4A61@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 337f97a9-9fc0-4a77-514f-08dcfa46ced2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2024 07:28:40.3719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jVnFcYR3jCgcf/eY6YQMvTuVrBtwESLlH9Q+9b49PwJ8iPoKrhPbrQlNk8Y3McsWsNqt/AwyR170RtNRd9SRAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6848
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTEwLTI1IGF0IDExOjEzICswMDAwLCBEaGFuYW5qYXkgVWd3ZWthciB3cm90
ZToKPiBQcmVwYXJlIGZvciB0aGUgYWRkaXRpb24gb2YgUkFQTCBjb3JlIGVuZXJneSBjb3VudGVy
IHN1cHBvcnQuCj4gUG9zdCB3aGljaCwgb25lIENQVSBtaWdodCBiZSBtYXBwZWQgdG8gbW9yZSB0
aGFuIG9uZSByYXBsX3BtdQo+IChwYWNrYWdlL2RpZSBvbmUgYW5kIGEgY29yZSBvbmUpLiBTbywg
cmVtb3ZlIHRoZSBjcHVfdG9fcmFwbF9wbXUoKQo+IGZ1bmN0aW9uLgo+IAo+IFNpZ25lZC1vZmYt
Ynk6IERoYW5hbmpheSBVZ3dla2FyIDxEaGFuYW5qYXkuVWd3ZWthckBhbWQuY29tPgoKUmV2aWV3
ZWQtYnk6IFpoYW5nIFJ1aSA8cnVpLnpoYW5nQGludGVsLmNvbT4KVGVzdGVkLWJ5OiBaaGFuZyBS
dWkgPHJ1aS56aGFuZ0BpbnRlbC5jb20+Cgp0aGFua3MsCnJ1aQoKPiAtLS0KPiDCoGFyY2gveDg2
L2V2ZW50cy9yYXBsLmMgfCAxOSArKysrKystLS0tLS0tLS0tLS0tCj4gwqAxIGZpbGUgY2hhbmdl
ZCwgNiBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvYXJj
aC94ODYvZXZlbnRzL3JhcGwuYyBiL2FyY2gveDg2L2V2ZW50cy9yYXBsLmMKPiBpbmRleCBmNzBj
NDljYTBlZjMuLmQyMGM1YjFkZDBhZCAxMDA2NDQKPiAtLS0gYS9hcmNoL3g4Ni9ldmVudHMvcmFw
bC5jCj4gKysrIGIvYXJjaC94ODYvZXZlbnRzL3JhcGwuYwo+IEBAIC0xNjIsMTcgKzE2Miw2IEBA
IHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgaW50IGdldF9yYXBsX3BtdV9pZHgoaW50Cj4gY3B1KQo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgCj4gdG9wb2xvZ3lfbG9naWNhbF9kaWVfaWQoY3B1KTsK
PiDCoH0KPiDCoAo+IC1zdGF0aWMgaW5saW5lIHN0cnVjdCByYXBsX3BtdSAqY3B1X3RvX3JhcGxf
cG11KHVuc2lnbmVkIGludCBjcHUpCj4gLXsKPiAtwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBpbnQg
cmFwbF9wbXVfaWR4ID0gZ2V0X3JhcGxfcG11X2lkeChjcHUpOwo+IC0KPiAtwqDCoMKgwqDCoMKg
wqAvKgo+IC3CoMKgwqDCoMKgwqDCoCAqIFRoZSB1bnNpZ25lZCBjaGVjayBhbHNvIGNhdGNoZXMg
dGhlICctMScgcmV0dXJuIHZhbHVlIGZvcgo+IG5vbgo+IC3CoMKgwqDCoMKgwqDCoCAqIGV4aXN0
ZW50IG1hcHBpbmdzIGluIHRoZSB0b3BvbG9neSBtYXAuCj4gLcKgwqDCoMKgwqDCoMKgICovCj4g
LcKgwqDCoMKgwqDCoMKgcmV0dXJuIHJhcGxfcG11X2lkeCA8IHJhcGxfcG11cy0+bnJfcmFwbF9w
bXUgPyByYXBsX3BtdXMtCj4gPnBtdXNbcmFwbF9wbXVfaWR4XSA6IE5VTEw7Cj4gLX0KPiAtCj4g
wqBzdGF0aWMgaW5saW5lIHU2NCByYXBsX3JlYWRfY291bnRlcihzdHJ1Y3QgcGVyZl9ldmVudCAq
ZXZlbnQpCj4gwqB7Cj4gwqDCoMKgwqDCoMKgwqDCoHU2NCByYXc7Cj4gQEAgLTM0OCw3ICszMzcs
NyBAQCBzdGF0aWMgdm9pZCByYXBsX3BtdV9ldmVudF9kZWwoc3RydWN0IHBlcmZfZXZlbnQKPiAq
ZXZlbnQsIGludCBmbGFncykKPiDCoHN0YXRpYyBpbnQgcmFwbF9wbXVfZXZlbnRfaW5pdChzdHJ1
Y3QgcGVyZl9ldmVudCAqZXZlbnQpCj4gwqB7Cj4gwqDCoMKgwqDCoMKgwqDCoHU2NCBjZmcgPSBl
dmVudC0+YXR0ci5jb25maWcgJiBSQVBMX0VWRU5UX01BU0s7Cj4gLcKgwqDCoMKgwqDCoMKgaW50
IGJpdCwgcmV0ID0gMDsKPiArwqDCoMKgwqDCoMKgwqBpbnQgYml0LCByYXBsX3BtdV9pZHgsIHJl
dCA9IDA7Cj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCByYXBsX3BtdSAqcG11Owo+IMKgCj4gwqDC
oMKgwqDCoMKgwqDCoC8qIG9ubHkgbG9vayBhdCBSQVBMIGV2ZW50cyAqLwo+IEBAIC0zNzYsOCAr
MzY1LDEyIEBAIHN0YXRpYyBpbnQgcmFwbF9wbXVfZXZlbnRfaW5pdChzdHJ1Y3QgcGVyZl9ldmVu
dAo+ICpldmVudCkKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKGV2ZW50LT5hdHRyLnNhbXBsZV9wZXJp
b2QpIC8qIG5vIHNhbXBsaW5nICovCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBy
ZXR1cm4gLUVJTlZBTDsKPiDCoAo+ICvCoMKgwqDCoMKgwqDCoHJhcGxfcG11X2lkeCA9IGdldF9y
YXBsX3BtdV9pZHgoZXZlbnQtPmNwdSk7Cj4gK8KgwqDCoMKgwqDCoMKgaWYgKHJhcGxfcG11X2lk
eCA+PSByYXBsX3BtdXMtPm5yX3JhcGxfcG11KQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqByZXR1cm4gLUVJTlZBTDsKPiArCj4gwqDCoMKgwqDCoMKgwqDCoC8qIG11c3QgYmUgZG9u
ZSBiZWZvcmUgdmFsaWRhdGVfZ3JvdXAgKi8KPiAtwqDCoMKgwqDCoMKgwqBwbXUgPSBjcHVfdG9f
cmFwbF9wbXUoZXZlbnQtPmNwdSk7Cj4gK8KgwqDCoMKgwqDCoMKgcG11ID0gcmFwbF9wbXVzLT5w
bXVzW3JhcGxfcG11X2lkeF07Cj4gwqDCoMKgwqDCoMKgwqDCoGlmICghcG11KQo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FSU5WQUw7Cj4gwqDCoMKgwqDCoMKgwqDC
oGV2ZW50LT5wbXVfcHJpdmF0ZSA9IHBtdTsKCg==
