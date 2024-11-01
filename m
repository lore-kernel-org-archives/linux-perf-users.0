Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550FC14883C;
	Fri,  1 Nov 2024 07:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730446163; cv=fail; b=pBbDRxduHuOTogkhTYNXWmdqFJOXrSke5/3ewIDESpOfFAaiwF6VhRcpwwCN8igJV7fyy2AAVvHTOv2uEsC8jH0yYx6gWV2yONCbteo3MSTpdYDV8JkCh/23q2G3XiUYYenukO7vg9oXAM83ijN+4Gfm8I+62gYtcpldXvv04I8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730446163; c=relaxed/simple;
	bh=4vwVr7p1vPcGMIxbrYlZoUz+y6yhONm6cqYi+MXUZSs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pK3KDEDPT330FFma5BqQWjiBME1tjUwgQHImX3M5tUo1tk1c17/zBME3+1D3WH12gjueJYNgc4g73EP/SPZWpIuJKCVndL84NWwIv+iVs91vU3QhVCutzx3iIg/PPymVYYJln7x8rtc91BCHANCV60O6+/zVxiLfSr7mtBF7vl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Acd0rpC4; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Acd0rpC4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730446162; x=1761982162;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4vwVr7p1vPcGMIxbrYlZoUz+y6yhONm6cqYi+MXUZSs=;
  b=Acd0rpC4Tp+GUmrkdI95EtHmRa51Ynk9sc61TSjuP1SOX6xIPbfk0Z9n
   9nBKL4RkNGJLXxS+qex02RAa1gBVHaQ4JCPCqlapSNlBVojCtJvmiCgtk
   Oz8DxTe3ygVqOZdSqup/RzjmHddvEtoW8fuAGgYbeOsiKC8vDaoOLHZ8j
   DTxHqBs+e1fkFNDV16FlBLLZWDwZKRMUJADgiRqvqDSRQ05mkryaYJ08n
   GWE7V2JRW+Obvjp4AVvfQHPgrvJVTHhNsplkLbLl1v9uGSxX+n+eA7iNd
   nxtw4y4tv29w/MfY3CWaghmdXKd5SE+mzuQL0iVzFflRN94BpjPtZNOy+
   w==;
X-CSE-ConnectionGUID: jE1IR9v2Qq22amKpdIwP2Q==
X-CSE-MsgGUID: KddvWplURXaObDWZ7lfgHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="41605723"
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="41605723"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 00:29:21 -0700
X-CSE-ConnectionGUID: KPMw9RBTSJCYznME7SnUsQ==
X-CSE-MsgGUID: WLwGdYXCTLWiFgskmc8M5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="82565520"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Nov 2024 00:29:20 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 1 Nov 2024 00:29:19 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 1 Nov 2024 00:29:19 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 00:29:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VlxJnLzKJW9A67MpGYw5Y/NLypkIJsR0SwjhI0qL157zUQyD1ia8/UMw0m3gAVa4WztkZ73GjVGLh3Aso6is2JGkAdo1z6WVijgzrayy64pgDyckJj9uPGEGDUewJ02rwpFRnenLLFm2AsVxZhbxhreiojDKTClea1diBv7Dz5XqKwqa/wgIQGjrkcB+/0+ULc9hc5XLY6TJpgw6QjyDVAznDAm53PXXzh94OeLgmGCzgfCmCE6g4vd9Mix9FjBrJkqlN+Cnd1s9f0BENXD+LNwnp1v0LUUUoIjhmRxGSARJAqrGSRCfQpRKfRq7waUtmZfkmsffibr1p8pqfVIwlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vwVr7p1vPcGMIxbrYlZoUz+y6yhONm6cqYi+MXUZSs=;
 b=hQP7pwXeqz2riIL3MJ5unQmndWlvKQ+1vonzsiyAdy/TaAmmTD9cKfumG0snDZML4eWCmlL2z8kaJylLL8VLr5E1F0bSKjPFzvZMddsGXlY8AXbNse6PboH/1psmf44J3luUx4woQIwe2WGCzl01hrX5PXjCgCHIol8DlUsSmH2iH8+h7Wx8hZA6jVbtO9S/s+oOtl/x1Nc9oyXsr7cv5Q2gH93r+OpLfHsCoM/V9QKY0NYUy4fB0L708FwpLf+x6+cSlqdTWe8znVAkvohjrkmAhdeamdFM0thK/c++76bRfqjGUjUtzLjhg0N06CqyfivNtG9FHwCV17vyhtKmVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SA1PR11MB6848.namprd11.prod.outlook.com (2603:10b6:806:29c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Fri, 1 Nov
 2024 07:29:11 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%5]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 07:29:11 +0000
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
Subject: Re: [PATCH v6 05/10] perf/x86/rapl: Make rapl_model struct global
Thread-Topic: [PATCH v6 05/10] perf/x86/rapl: Make rapl_model struct global
Thread-Index: AQHbJs9KalYRZ3Nmok6IqK/p2YWAv7KiEdyA
Date: Fri, 1 Nov 2024 07:29:10 +0000
Message-ID: <4d0455229b6f5ddad851daf54557844a4a9a1071.camel@intel.com>
References: <20241025111348.3810-1-Dhananjay.Ugwekar@amd.com>
	 <20241025111348.3810-6-Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20241025111348.3810-6-Dhananjay.Ugwekar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|SA1PR11MB6848:EE_
x-ms-office365-filtering-correlation-id: c2b04723-9d59-4276-58dc-08dcfa46e113
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bDJuOE5LeG5tWUxIKzF4ZHovQXZVcHdPZk9uM2l5SWRLY1hSbVJiUUw1NU9P?=
 =?utf-8?B?SlBxYjd2RE9ITGsyYU5mQ2NnQ1RTWWYrdnpwVnR5Wk8xOEYyWXR2eWsrU0do?=
 =?utf-8?B?T0gvblJLUXE4V0hBaVhZemRqaWQzZElKa0Y4dDZrNVJ2ZWtnaXFSVjg3OGVi?=
 =?utf-8?B?YlNkY1ljT2FGQzRuMFRJVUlyK096cko1cU00WHRjR0YxcW1aUVZJTlEzSS94?=
 =?utf-8?B?MjkxOUpWS3VFdit0S1I2MEZLbVNRNjNndTFueDJmczMrY3JlZ1dZdGU1dzYr?=
 =?utf-8?B?R0tWcnRJclR1em85eXNjNkhIZDRaWGhlZ3RGWmEwOGozWjRka2U3WURHbjhC?=
 =?utf-8?B?ZGUwMTJDOVhFVTMrNjdkc1JLaU9xK0J1bFlpdFVZM0JCY3JINjNEbDZ4KzJh?=
 =?utf-8?B?TmVjYlNNeU5GRUNwMDVNUlI4NzhIV3gvRm42SG90SEd5VlVNN3hQZzl2T1cz?=
 =?utf-8?B?TjVYZmNTUldLakY0V29YZzBiZzAwTHdZViswMzh0dWg0UkFidDdvdVFyRXBW?=
 =?utf-8?B?R2JNQk42N2U5VUs4Vm04TFRBSU1CeU9Jem50cDdMTURyK1hDMytudHIxbk5U?=
 =?utf-8?B?U0lWRFE0K01wdG1ub3RZOUgrUjRCdnl5WVhrOHdXWGsrUDNjRUZZRkNpdVFs?=
 =?utf-8?B?em4rUHliZllDVy9rSllMaWl2N2VMSzZVYTRRU0VKZDVIZS9NekhBc2hxc0Fs?=
 =?utf-8?B?VkwvanlORUw2dFY2cnIwMVNIQUtNMFRpeVZ2L1BLVi9FT2dyd0dxWnVqN1o0?=
 =?utf-8?B?MW9hRFl4V04zL0hKaTV1N3pvKzM2bGFhSWlqTnk5WS9PUTdnM1ErN2FNNGhX?=
 =?utf-8?B?SVd5cnlFNkdkcUJET1ZNTUhhcnk1MzV4K2xGVTV3ZGxHQWloTEJYUE1sMTdl?=
 =?utf-8?B?VWRDTTdRNS8xZkR3M3dGM3NEc2k1bDZrS1p6MWcwV25sUml4Z2NuaXYzZ3JD?=
 =?utf-8?B?RUUxWmc1TUNjVVQ2NUlSMzBReHFpb3o3QUNlYkxvQjVsaEtQZStnZTZvN3ZT?=
 =?utf-8?B?NEdiMUYxcERjQ3hFZDZISzUwUWxudGpBZnJucFphNU52Z0NLNXI3WmJnV01E?=
 =?utf-8?B?NEt1VDRyWUdXUWQwemQ4akNCZ1ZDZGFTTjZNVG1GazJRdi9jOFRmY0FlbXRq?=
 =?utf-8?B?SWNwTVMrOWJ3cUJEaWRyV1AxQ3hyT1A2VXQveEtiMElxR01xMjl1NWRiK01X?=
 =?utf-8?B?SXJRazk2ZXIzb0R6c0pCWHNLcFQvL3phMWV4ODFkS1BpV2FYNzZOd1RJSnUz?=
 =?utf-8?B?aE05b1gxUE1YRDlqb0ZaRWlzVCtMbjZtNFBCZEc0ek5ldW12czY2bWhQN2J3?=
 =?utf-8?B?dERnOXdLMkVyRVVCb2wrUUhVQjdWdCtmaTE0ekZuOENkNlJ0cGRTYmxEVUlm?=
 =?utf-8?B?UmV2eGI5TGEwUXc0ZEozNXZGdWxtOTNwRHR1aXh3MDlsUmlqVlBuNEw5S1gy?=
 =?utf-8?B?b0xneGRoVDY3Q1FkbmI0cGcxRUp1dG11elpiS3FOM3BTSXdReHFTbGoxQkoy?=
 =?utf-8?B?c1FkWk1NTEZOT3ZCUmMxeVRDNVNhbmsyTDdRNTR4T0kveUlsaVR1WU5JaVpS?=
 =?utf-8?B?Rlk5Sk9lcmY4UE5iRUhOUnVoOWxRTnlNMzVPQ21wRXFyelM0TnJEdGZKZ0xk?=
 =?utf-8?B?OXlxWCtKejJubkNrT01wWG5BdS9TTzdlbEFNQkxxNFdQZ3E1VFBGNTR6TS9y?=
 =?utf-8?B?TGhuOUlEREw1YmVIbHVWZXFOVEdPRHEwdFlOejBBUXlJSHZvN2lvMkZTVWR6?=
 =?utf-8?B?K0FQZkVYcjVjSkNlYXJUZFRZMTVMckIwVnFOdXdhQWF5V0pCcFJKeDl6Nncx?=
 =?utf-8?B?MTJOdVJ5SzJXbEFZeEQ1Y0tMR2lpcWtRYkVNZENpbmhQRjd0QjZsMVFJdExD?=
 =?utf-8?Q?UemJ0sI3bld2/?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cW4rRnhjMUlPWUM5eUxaQ3NkaUZhRGRmdFQrSGtkNjIzMlI4bGxXUEFKRnEx?=
 =?utf-8?B?RkwyUGl6aHd0VWtUM20xQ3cyUzRyZjhaSHBNTWNaZU5mNWtQaTVGTDJDUHp1?=
 =?utf-8?B?SjdUTWFKTWNzK1ZWUEMzRFN2dGFBWVZjamx3bUM4emZyOE1HRFFiWVlmOG0v?=
 =?utf-8?B?emF1eUlHaE9DTm5yRk9LMisxVWRnWUQxc0VObmtkenlaLzFwd3I0WEkwaG1F?=
 =?utf-8?B?UmtEdnBWQVZvd0s4Uko1ZnpOL29Oa1hzY0Z0MGgzcXFRMjhpRWMrZkUyN1F5?=
 =?utf-8?B?cTVwcUJtU1NDQW9CeE9qakR4T2F2Zm9HME5sUTF3M2U0RXFOc08rMWRGMFRX?=
 =?utf-8?B?MVJ1aTE2L0hSZnk1V1hSbXdPZHRwSGRXRUo1bHh2dGdvSnFWTEV1WUdielJI?=
 =?utf-8?B?ZlMyNXNSeWkwRllsMTBNbXl5OWJJTVI5aThYcGhFaW1LVnczeDVIM2grQm1Y?=
 =?utf-8?B?SkxpVjlGWHljS0NBL3kvZEpXdGpPcWw4bE1yQjlNeHUwa0NBWC9obnd0OCtq?=
 =?utf-8?B?ckpXYmVieWFhamFRMTRUOWMrZmpwVE5jeTFtOG9EWWNGMFhPY3pZeHNxYlBw?=
 =?utf-8?B?ck9SY04yZ2pKV2psdEVkZmNNRDF4VEZOdExlWUtHdW5LK1ZLNW91RjMyZGJ3?=
 =?utf-8?B?cVZ3dWxxTU1SOVJadXJPT29RTW5NNE5qWFNoZWRwQlVRU1NCalpQVWhKNk9i?=
 =?utf-8?B?MmlUQ1BkcGRPU1ZLQi9hYU1wcXB1S3ZoNkNlbUlkdGFnUlIvd0VlOVV6cnNq?=
 =?utf-8?B?cThLRFY5TmhMOVBLMERTZzlxUktxRUxHbTNxZVpoZ1BnYnhuakZweTFtVHFy?=
 =?utf-8?B?TGRJRGFBZDRaRFN3SDh3dzlqa2tsR2dhZncyYlVxcFpEOUZTbUppbFV5WU5o?=
 =?utf-8?B?OFlQRE1iOFZUNVIwY2tXcVZmcytMNkY3SkRhSUlJRGh1WVcreUlpQ0RkS0Z3?=
 =?utf-8?B?aEVQemhXZ3JMM2xEZUVSSFRTTXdpTW9yZ1FSVHd6UCs1ajUyNjhza2xRRlhO?=
 =?utf-8?B?Z2dSd1h4am9US0loRkR3Q2JBb2JybGY4SXdIMEtUb0hKcmgxaWt2YmZEdVRL?=
 =?utf-8?B?WlZtNHdTTGkrclFTclQ4SVVwK2ZPOVR6WElqK0dYM09mZ2xnY0c2NkMvd2xF?=
 =?utf-8?B?N1VxMTVLK1pGa1l6M1ZvSUJXRHlvSUNjeGN4SndMVGpQMG0zdmVWQlQxZitO?=
 =?utf-8?B?d2JUWXYrUGNnYlNYNkI3anpLSFdRSjFpZGk5SW9pSGdyQzNTeDFMNnZmU3F2?=
 =?utf-8?B?WVpKa21MZ08ydXVMR2RLSGlpbzRSdHpKcm9hZGpoRWRwLzZJeVhOQ3hmdE9Q?=
 =?utf-8?B?MHh4c1Q1RlFGQ2dnM1pJRkpKSXp0S2t3Q3hYc014Q3B2U0dYU2lRR3k4VjAv?=
 =?utf-8?B?UHhERkFmL2xhdGNpUDlnVTZxN2F0N0dlK0l2L1lQdGpzN3FqbGswOUExWitN?=
 =?utf-8?B?MGpzN1JjdkJJaVU3ZlhFczJJNUlSMUN0ekViZmJUMTZQMVM4U3pIbXNRTmpB?=
 =?utf-8?B?T1pjSlZXam9wMHU3WU5NRGdVcWpjVEZoSjREb0xaWXljRndUckxxWEd0MHpu?=
 =?utf-8?B?S0kyZ21iTk80bk1KeDdZNDEwaXdXV1lPSkZteXlXVW9sWmJzQ2hDNmJFaHg0?=
 =?utf-8?B?dmRqeUhtSGlUYUI4WkovTE01Zi9LWXpCT0VkaHppVkRzSmdldDI1K2tjMUtK?=
 =?utf-8?B?V1R1ZzZONGMzeU8zNWhJUENEbHlrdEpNaFRDZWxmWVM3bmNHTDljNnBzRHdn?=
 =?utf-8?B?UkRSK1FkQjJPczN4bHhKdFZZT2tjdW14aXRHN0sxR1NqdzVQWWpnTXdZbXpG?=
 =?utf-8?B?SURUWmgrWDJEMGNPUFVaVkVKUTYrRDBNUmNYV24rb1RFU0I3SjhPNE9ZTUJK?=
 =?utf-8?B?V1NKN1FieXF6a2xtQ1FMK1puN0p2azdWbVpRWnNhM00rdngxV3ByWFpEWVYx?=
 =?utf-8?B?UlJwN2llajBrVlEwb0ZoVVA5ay9JZktKNHo5a01ibzgzNUpaUlMwOUdDL0xE?=
 =?utf-8?B?T1R5TDNCVmd5QnErc1pXOXA4UTYzRi9PZWV5UWFTYmNiQW9zTzJTTWN3VmlG?=
 =?utf-8?B?MHNXTlZrYXpxbWUrOGc0QVFOSVMvdWd2d3lEaldIQk1XR0Q0aFFyOW5MZkgw?=
 =?utf-8?Q?O9frcoGFSYdQvPRpDp4kkAI3W?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <674E24DCC3FD3446BC6482C8713F4389@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b04723-9d59-4276-58dc-08dcfa46e113
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2024 07:29:11.0162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JvW6ZkT66bC8Lr3s12h/ZMETUL49CDyJ9l3xprhR0JOC2s+CyGjAuTBODOygt+LyF9MPPkX5fzdRSWFnEWUfLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6848
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTEwLTI1IGF0IDExOjEzICswMDAwLCBEaGFuYW5qYXkgVWd3ZWthciB3cm90
ZToKPiBQcmVwYXJlIGZvciB0aGUgYWRkaXRpb24gb2YgUkFQTCBjb3JlIGVuZXJneSBjb3VudGVy
IHN1cHBvcnQuCj4gCj4gQXMgdGhlcmUgd2lsbCBhbHdheXMgYmUganVzdCBvbmUgcmFwbF9tb2Rl
bCB2YXJpYWJsZSBvbiBhIHN5c3RlbSwKPiBtYWtlIGl0Cj4gZ2xvYmFsLCB0byBtYWtlIGl0IGVh
c2llciB0byBhY2Nlc3MgaXQgZnJvbSBhbnkgZnVuY3Rpb24uCj4gCj4gTm8gZnVuY3Rpb25hbCBj
aGFuZ2UuCj4gCj4gU2lnbmVkLW9mZi1ieTogRGhhbmFuamF5IFVnd2VrYXIgPERoYW5hbmpheS5V
Z3dla2FyQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogWmhhbmcgUnVpIDxydWkuemhhbmdAaW50ZWwu
Y29tPgpUZXN0ZWQtYnk6IFpoYW5nIFJ1aSA8cnVpLnpoYW5nQGludGVsLmNvbT4KCnRoYW5rcywK
cnVpCgo+IC0tLQo+IMKgYXJjaC94ODYvZXZlbnRzL3JhcGwuYyB8IDE2ICsrKysrKysrLS0tLS0t
LS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCj4g
Cj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2V2ZW50cy9yYXBsLmMgYi9hcmNoL3g4Ni9ldmVudHMv
cmFwbC5jCj4gaW5kZXggNzM4N2JjYTk1MDE4Li40NDdmNjJjYWE1ZjkgMTAwNjQ0Cj4gLS0tIGEv
YXJjaC94ODYvZXZlbnRzL3JhcGwuYwo+ICsrKyBiL2FyY2gveDg2L2V2ZW50cy9yYXBsLmMKPiBA
QCAtMTUxLDYgKzE1MSw3IEBAIHN0YXRpYyBzdHJ1Y3QgcmFwbF9wbXVzICpyYXBsX3BtdXM7Cj4g
wqBzdGF0aWMgdW5zaWduZWQgaW50IHJhcGxfY250cl9tYXNrOwo+IMKgc3RhdGljIHU2NCByYXBs
X3RpbWVyX21zOwo+IMKgc3RhdGljIHN0cnVjdCBwZXJmX21zciAqcmFwbF9tc3JzOwo+ICtzdGF0
aWMgc3RydWN0IHJhcGxfbW9kZWwgKnJhcGxfbW9kZWw7Cj4gwqAKPiDCoC8qCj4gwqAgKiBIZWxw
ZXIgZnVuY3Rpb24gdG8gZ2V0IHRoZSBjb3JyZWN0IHRvcG9sb2d5IGlkIGFjY29yZGluZyB0byB0
aGUKPiBAQCAtNTM2LDE4ICs1MzcsMTggQEAgc3RhdGljIHN0cnVjdCBwZXJmX21zciBhbWRfcmFw
bF9tc3JzW10gPSB7Cj4gwqDCoMKgwqDCoMKgwqDCoFtQRVJGX1JBUExfUFNZU10gPSB7IDAsICZy
YXBsX2V2ZW50c19wc3lzX2dyb3VwLMKgIE5VTEwsCj4gZmFsc2UsIDAgfSwKPiDCoH07Cj4gwqAK
PiAtc3RhdGljIGludCByYXBsX2NoZWNrX2h3X3VuaXQoc3RydWN0IHJhcGxfbW9kZWwgKnJtKQo+
ICtzdGF0aWMgaW50IHJhcGxfY2hlY2tfaHdfdW5pdCh2b2lkKQo+IMKgewo+IMKgwqDCoMKgwqDC
oMKgwqB1NjQgbXNyX3JhcGxfcG93ZXJfdW5pdF9iaXRzOwo+IMKgwqDCoMKgwqDCoMKgwqBpbnQg
aTsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqAvKiBwcm90ZWN0IHJkbXNybCgpIHRvIGhhbmRsZSB2
aXJ0dWFsaXphdGlvbiAqLwo+IC3CoMKgwqDCoMKgwqDCoGlmIChyZG1zcmxfc2FmZShybS0+bXNy
X3Bvd2VyX3VuaXQsCj4gJm1zcl9yYXBsX3Bvd2VyX3VuaXRfYml0cykpCj4gK8KgwqDCoMKgwqDC
oMKgaWYgKHJkbXNybF9zYWZlKHJhcGxfbW9kZWwtPm1zcl9wb3dlcl91bml0LAo+ICZtc3JfcmFw
bF9wb3dlcl91bml0X2JpdHMpKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0
dXJuIC0xOwo+IMKgwqDCoMKgwqDCoMKgwqBmb3IgKGkgPSAwOyBpIDwgTlJfUkFQTF9ET01BSU5T
OyBpKyspCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByYXBsX2h3X3VuaXRbaV0g
PSAobXNyX3JhcGxfcG93ZXJfdW5pdF9iaXRzID4+IDgpICYKPiAweDFGVUxMOwo+IMKgCj4gLcKg
wqDCoMKgwqDCoMKgc3dpdGNoIChybS0+dW5pdF9xdWlyaykgewo+ICvCoMKgwqDCoMKgwqDCoHN3
aXRjaCAocmFwbF9tb2RlbC0+dW5pdF9xdWlyaykgewo+IMKgwqDCoMKgwqDCoMKgwqAvKgo+IMKg
wqDCoMKgwqDCoMKgwqAgKiBEUkFNIGRvbWFpbiBvbiBIU1cgc2VydmVyIGFuZCBLTkwgaGFzIGZp
eGVkIGVuZXJneSB1bml0Cj4gd2hpY2ggY2FuIGJlCj4gwqDCoMKgwqDCoMKgwqDCoCAqIGRpZmZl
cmVudCB0aGFuIHRoZSB1bml0IGZyb20gcG93ZXIgdW5pdCBNU1IuIFNlZQo+IEBAIC03OTIsMjEg
Kzc5MywyMCBAQCBNT0RVTEVfREVWSUNFX1RBQkxFKHg4NmNwdSwgcmFwbF9tb2RlbF9tYXRjaCk7
Cj4gwqBzdGF0aWMgaW50IF9faW5pdCByYXBsX3BtdV9pbml0KHZvaWQpCj4gwqB7Cj4gwqDCoMKg
wqDCoMKgwqDCoGNvbnN0IHN0cnVjdCB4ODZfY3B1X2lkICppZDsKPiAtwqDCoMKgwqDCoMKgwqBz
dHJ1Y3QgcmFwbF9tb2RlbCAqcm07Cj4gwqDCoMKgwqDCoMKgwqDCoGludCByZXQ7Cj4gwqAKPiDC
oMKgwqDCoMKgwqDCoMKgaWQgPSB4ODZfbWF0Y2hfY3B1KHJhcGxfbW9kZWxfbWF0Y2gpOwo+IMKg
wqDCoMKgwqDCoMKgwqBpZiAoIWlkKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
cmV0dXJuIC1FTk9ERVY7Cj4gwqAKPiAtwqDCoMKgwqDCoMKgwqBybSA9IChzdHJ1Y3QgcmFwbF9t
b2RlbCAqKSBpZC0+ZHJpdmVyX2RhdGE7Cj4gK8KgwqDCoMKgwqDCoMKgcmFwbF9tb2RlbCA9IChz
dHJ1Y3QgcmFwbF9tb2RlbCAqKSBpZC0+ZHJpdmVyX2RhdGE7Cj4gwqAKPiAtwqDCoMKgwqDCoMKg
wqByYXBsX21zcnMgPSBybS0+cmFwbF9tc3JzOwo+ICvCoMKgwqDCoMKgwqDCoHJhcGxfbXNycyA9
IHJhcGxfbW9kZWwtPnJhcGxfbXNyczsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqByYXBsX2NudHJf
bWFzayA9IHBlcmZfbXNyX3Byb2JlKHJhcGxfbXNycywgUEVSRl9SQVBMX01BWCwKPiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgZmFsc2UsICh2b2lkICopICZybS0+ZXZlbnRzKTsKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgZmFsc2UsICh2b2lkICopICZyYXBsX21vZGVsLQo+ID5ldmVudHMpOwo+IMKg
Cj4gLcKgwqDCoMKgwqDCoMKgcmV0ID0gcmFwbF9jaGVja19od191bml0KHJtKTsKPiArwqDCoMKg
wqDCoMKgwqByZXQgPSByYXBsX2NoZWNrX2h3X3VuaXQoKTsKPiDCoMKgwqDCoMKgwqDCoMKgaWYg
KHJldCkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiByZXQ7Cj4gwqAK
Cg==
