Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C4A13BAC6;
	Fri,  6 Dec 2024 02:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733451024; cv=fail; b=fbLoOJlFcvBtitGxAYFKVu/16MFnkrvRo+kYzNCsngDfu7Dep1T32zgmSWdPo4GWmcGwXOSropmMCEjBIVPU3i8y+XH+Mi3km8fTXKzDyGV9bWfKGBsqNg+LI01AuIyycaI/TYfUnJOYHTo9mkbztfadgVZ++HlR2AY42bu3f5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733451024; c=relaxed/simple;
	bh=fj6tILbkFmiKrIvKcZIgTSG0ArTKcGpu1sU9Uc8f/aw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZX2Xrgw9gmLSeIARyg1TPOo/Y10HEnioyLAc9HGYmD7t6j7v1wq/mfzUXjzMC77pouWwekqzsu5mvQ1AU2v7K11EGrvbr3nTosAlK6sI5z02SL4q4DxZ+pjDBAKERcA7zf729QLKHN/fKeEdr2MlGa7bGEn/ozEoDTp+kJSn0qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YTJhMeeR; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YTJhMeeR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733451023; x=1764987023;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fj6tILbkFmiKrIvKcZIgTSG0ArTKcGpu1sU9Uc8f/aw=;
  b=YTJhMeeRZPDYXhgf8ORS9+Z4GT5VL9KoP4m969Fn9FoAy97Jbo1nr8GE
   4G1xtA6ACgAZUToKDo2+RQSocc1833xJgVfg5CJA6eu6ULVhMg1sMQ3ke
   GcxTc+DDtU7OFh1VjmFegF9l3aEHlkxUNPUc3rkMfbV8XQAD975GSGbhv
   LqxWpJEAv9yxH0wD55E3IARbl4hCK4GKe3zBGPd/lQKD46IMeHb3GvHcU
   KyA0lj4o2ZNv36TbnmzAh2o9SBwSFdbqOZGG7en823d2N3yOI3xMLDg6i
   XR1Yr4bgVzhV8RvpUxBqYa/D5CYXOIrLnDvkdnPYbbFwvTRckJwMIMhu5
   g==;
X-CSE-ConnectionGUID: qEvLJ//yQWWjeWdKVKk5TQ==
X-CSE-MsgGUID: MJS6uqNRRLeguzYUpJQHOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="33847598"
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="33847598"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 18:10:22 -0800
X-CSE-ConnectionGUID: wYyKwrhKQXqG3X8qI+1L3Q==
X-CSE-MsgGUID: JX+LNutUSemXj/N7hFjjBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="99310290"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2024 18:10:23 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Dec 2024 18:10:21 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 5 Dec 2024 18:10:21 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Dec 2024 18:10:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nU19Tndw255qiDf1euqQ23oVd46bh+VCrImS/aLz0sEMpVi1kTuxCE5Vk0OHk5qA3hKkr/g0HzSUEJAYxxQ7HbnkqdboqbdeiXuxWV8MDJkadDmL5rhTUzlaOOCqBfgvgRpxKmbs7FQG3trf8vD9TGOLJvRrLGtZ8foiUU+i0pazWFrqmgaUs1PVKPnkFfs/r9ZqssIdzeEdtfD0BPjl66faPaxhCH57gZcKzgL4EA62dvFpXgIl3WqK+MyhG96xuN+I4/TqMXGntQvmJi0l/BfjOToRcWWG+DCoXamNslcewACAazUQn7BGKFQVDZLMoY/s+uQUv8SwxktWn3Woew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJjnPewc4wAoDqkEUXKa0kymKmqd5w50X2yWVybtEN8=;
 b=hJWa79LOlMJ5xuUaO21ybuWvfXh8rpto/G3o60oyCSvWSjN81SBn45qU/LFZLrQHXleqwgSpQoPErF29P+lXN97q/O0nMVbwmQM+NWFyFDAcqFvm1/XzOUPB6Yt+uu9UIgUZkgkVu4nB2Rh+p6IQlhK/IBK74PgzqIliFDGwZvaVYD5EST885dTElKhx2WUQJCIdu6xrlEd0r2M8tacpuU6tQ/z2SM8PQciAi8ivW+2yS22QLyoWPaP/WhfuDc80wW1ZK0kqvedc9+hVmVyMq4SL1KJiDAasIGdEN1+DyuTOWXi75a9pKE79KO2j4et9XZqOFhQ4xeU5Xpw9nEitjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SN7PR11MB7604.namprd11.prod.outlook.com (2603:10b6:806:343::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 02:10:18 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 02:10:18 +0000
Date: Fri, 6 Dec 2024 10:10:07 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Namhyung Kim <namhyung@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark
	<james.clark@linaro.org>, Ravi Bangoria <ravi.bangoria@amd.com>, Kan Liang
	<kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, Atish Patra
	<atishp@atishpatra.org>, Mingwei Zhang <mizhang@google.com>, Kajol Jain
	<kjain@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>, Palmer Dabbelt
	<palmer@rivosinc.com>, <linux-perf-users@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [linus:master] [perf tools]  af954f76ee:
 perf-sanity-tests.Test_data_symbol.fail
Message-ID: <Z1Jc/wZk5kSd+2Qc@xsang-OptiPlex-9020>
References: <202411301431.799e5531-lkp@intel.com>
 <Z04ZUHaGdsBapIEL@google.com>
 <Z1BhfpYWpUQ0p+qR@xsang-OptiPlex-9020>
 <Z1DNJpDzCIBFrIZT@google.com>
 <Z1DV0lN8qHSysX7f@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z1DV0lN8qHSysX7f@google.com>
X-ClientProxiedBy: SG2PR01CA0185.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SN7PR11MB7604:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fc2aa16-1513-4ac6-3b42-08dd159b2195
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7Sm9KA10VNHsPRIhqqXoSrtZV4Qq7F9nBrjGqfgKBQJp7X3YhAZo7qES39V5?=
 =?us-ascii?Q?Cn/RD5AkhkKMFvTPI4UjKh2wEA601ybe1aZheXm2Nmd1xslHkgQp3V2H4AXS?=
 =?us-ascii?Q?wjpCULrMQbzqMkz/JK/8mSJHgDQUb8jToB9huVmc0LlG7Nh9DHAid1CavN0N?=
 =?us-ascii?Q?hdHHb40Gea1Vi8GTxSh2oyJH7z/VDcid/BTSSBq+41MFK7dhE6Ne2ssIyqVp?=
 =?us-ascii?Q?eB0rxOIBD23vOMqyErGrXmfwd0r6mIxzEdmfCL4bpkkLsLauOJu3P5cmOWb4?=
 =?us-ascii?Q?rcaTkWw7ySQm2HQXt7ScrlbKGmT3W35rMVk5a2eQ7xJAD8GcL6BQZD34qPLC?=
 =?us-ascii?Q?82DO6IugvyLXC21ce4K/Zmva2DhY8sP9KN479Hhmrxn7FY0o5/cQ2SMDO5zI?=
 =?us-ascii?Q?xRBx/TBCXxqdSoBhhStay8//QHpS21cipNMAft7CNwndajj+MFXGWfQld5Nw?=
 =?us-ascii?Q?7RZDmgGNgPSsvNUiXxrTtGiiMB0+vL5gdeZc3JjPTceWxS2B4tO3otmqEOY4?=
 =?us-ascii?Q?Z0jC6uTNfXZJWIGJOQhGu55dV+plLq72i8+J/BD5gKf8ivPVcxPHBMqrql6L?=
 =?us-ascii?Q?028L3Crt+OJe7OoC1Op/v7tAEO2688lcYkt9gtXwRhBENPfa1K+5SrtKNFoL?=
 =?us-ascii?Q?SZ7gHi7a7jrCxwts5afw5eEmJLB/8cjlwy2o3tLVCxDgBvbGjTdWOLm74VW3?=
 =?us-ascii?Q?+FhdczOZvLo6m+pLE+pbli+mijjL0QA8YO9XxC8JztRjmTzVmYJkY/ndP2Uh?=
 =?us-ascii?Q?lNSgrSqiTW6PG/FCHi4KzUbYFql9PZ8G4olEI8UXil1mWiiz6gHQEIRIE0lI?=
 =?us-ascii?Q?B1J3yr05P9nTQg6vnzWn7xPV3+uZd7+NeVmoKumtwMYp2Rra+dUZYE9QTzcF?=
 =?us-ascii?Q?80axKN1ZRkA2aHZrcVx2Xq2UJ5TupHYHkJeWqVDCXTZE99XtUqtte8G2aCSa?=
 =?us-ascii?Q?xBn9uZBe6N5rS1Hkbi0HueXe8aklf6KyUexOzA7L4+r0XrtIW7Q4FEp5PZT/?=
 =?us-ascii?Q?Z/pguZTUHSx2tIe3cKJIOZoMDZZqYp9A5vCjzhLJ/VYVvKIUOtM9c4by4SKl?=
 =?us-ascii?Q?SZdHEiiAtVm9/B7GmI217nmuCexuJQCyw7Nmm6OcpQbWM4gVs1r970FYeZ1x?=
 =?us-ascii?Q?68702lG38IY3bqLfqLJXq0jUJRv013h4ow7dczNyBT9rZ7SZSwlBTpzthRlu?=
 =?us-ascii?Q?2X3dlIPy7BdtKGNObSZjXRZjZbktE0DF10VANpsbzlCQwIntuMqj536M2hve?=
 =?us-ascii?Q?V/xf1ovMoJ3Zb0c6JlX8kpOoaaDD8ueQsZfejpT+yEOnCXc9DKvfLOgwbf/C?=
 =?us-ascii?Q?nPaBBdTPYnQnRVzsFZbOt7Q6DDblG45GbnxxG7x1szDzAw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cmmTT4C84gTwWuwa7OtYtTimi/q4HWndnmW/FFr1MSDmPc1J26y+m1K0mKp5?=
 =?us-ascii?Q?pBE+nhgxZTd4Esi1lawQF7B6BNWGN4jlb/32HB6uxyFRNeW38kZmcKf/d4tR?=
 =?us-ascii?Q?5GyYOhN6LO3gGUcnrFQT7k4DZiOUpeRxrFCpm32jXYq8BwQCeakIPpnFWea+?=
 =?us-ascii?Q?YAiAyct9ykHSckXGnP1rDZI6tBVvuYms1/uSa9cPPqdaoXQKRsAulGhQED0t?=
 =?us-ascii?Q?YsfQxWDLoz+WWlOsOyZkrVt0hZ36gGGcrCliKPC5OUyNbguIIUv6RQcr3bcp?=
 =?us-ascii?Q?NDxNDDZ5xEmHa+Jx3zx44N+4lNvJAoDhj1OCNdBaKflvrwd5utBwvJ2XlbVG?=
 =?us-ascii?Q?YVhj/B3NG+HsMkWqih4rVSaacsc2heRkO4/clQepH456Ib27NEO/FYYAvV9P?=
 =?us-ascii?Q?ewxinTe00KTXQBLoWYpuvqyaNxDBLo4D1P+gyEvWQ8HNk7Vr5j29IewWKJX1?=
 =?us-ascii?Q?XgyGIhJQLsOc+tyM5/m8ylyBJXPEeLA4H9HygmP/UCStmcphD6s/UaU/Rxt6?=
 =?us-ascii?Q?k0/QTd3En7EXBxdJ5rpJ2YFk3EeTcICwrGB1zqdYm06di1d/3EZWUcCDjyhA?=
 =?us-ascii?Q?E1nwZC0X21nFhzk8WcXy+0cLr9ziz5S6idLmGx8rWMFcHmECxXlHDEM8891f?=
 =?us-ascii?Q?3t/o98euo7j2gboH+4dSF0BNlDY9wIvV4x6mtYqs6UdDZ9hXVO5NfektePc4?=
 =?us-ascii?Q?5D/CCqAXXceThJHmxrzed3ZedZkAt9TJPkYNUL+NS8/kmTJCeimEbQakkp44?=
 =?us-ascii?Q?8WAoF0ZYdZ+732d2TF9W/rL0zeCUFYuwx12DwXnPN//PVevJ4WIRf+QG1+SF?=
 =?us-ascii?Q?in3CtcaiYVx7GOlf4hqL5CxWR5pL77yNK02XERvP5cJDArMGvhlLRzcRS3v5?=
 =?us-ascii?Q?F9ekMqkGEE8tK0wbZ3ev0agHjOUUTucYQUzeg/HhPOhOk2+haK3NrmQn8Ago?=
 =?us-ascii?Q?269wkpDYrwyuJAn8JDf6/B72nvBcv/NU10FDhlWQveD2V4791Y9VBtj1wuba?=
 =?us-ascii?Q?HNSCBUj1ByaM4crhXn4MAgTHbyIGNPwNWnGYlgYpHjxok+XD0QgurZ7pB28/?=
 =?us-ascii?Q?owXAQkqRhtL6T56i/LSuagQX3t81HhxN8hN837GNAyx/P1XO78SnI5Drsso2?=
 =?us-ascii?Q?ZPJIObWcLToUgLRaELp6zqW3dO9kFyr/V5yICtN+trug7/Tp0N09ATq3Ep/f?=
 =?us-ascii?Q?4hCjOJvzTVsIvNFpOMT4TdHHkSslHGnCUugNxDhXT0hQu0K2icOVIPJqwzru?=
 =?us-ascii?Q?znCsYaFgBTiDvkl7Fq6K7WJYlg9lAzEbv4gkzSvn9PnL6nHETlg7bZPUNORC?=
 =?us-ascii?Q?9ehUqv6rGVGa93SrKq/E6OjGkwzAtOYb4S3yvkeILu89iv/34W2/22TwPYcE?=
 =?us-ascii?Q?aCbT2w1NNcZG3uXa+Wut3m6EGwbiBr6qfakZzttj7aDSCMSN+b0oRjfXTqb9?=
 =?us-ascii?Q?bLakh35V3zh+TgUnWQb55jVfR/Jom8SVY8kMevtPfATAly0W4KbB5eFaG9/a?=
 =?us-ascii?Q?oxuH/5nyXJ9VmFVVpBROQ2O8ksQsfPUSGnTnCL5lyc67tCzOVfS+brL6AasT?=
 =?us-ascii?Q?xHh70kLBSI4u2wRkhEtUAQzzUVstx58YrkU57IgoYdX7VkEsfSIQ46xWEgGy?=
 =?us-ascii?Q?jQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc2aa16-1513-4ac6-3b42-08dd159b2195
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 02:10:18.5082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sSKkM/Rg/XyY0Ljpx4vFk4Ue2CmmUR1OaM8a9obBAoc5r613zTiq/IQ/DDkBJgAxYbkIXmOcVkszbb/Saa33BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7604
X-OriginatorOrg: intel.com

hi, Namhyung Kim,

On Wed, Dec 04, 2024 at 02:21:06PM -0800, Namhyung Kim wrote:
> On Wed, Dec 04, 2024 at 01:44:06PM -0800, Namhyung Kim wrote:
> [SNIP]
> >   perf_event_attr:
> >     type                             4 (cpu)
> >     size                             136
> >     config                           0x1cd (mem-loads)
> >     { sample_period, sample_freq }   4000
> >     sample_type                      IP|TID|TIME|ADDR|CPU|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT
> >     read_format                      ID|LOST
> >     freq                             1
> >     precise_ip                       3
> >     sample_id_all                    1
> >     { bp_addr, config1 }             0x1f
> >   ------------------------------------------------------------
> >   sys_perf_event_open: pid -1  cpu 0  group_fd 5  flags 0x8
> >   sys_perf_event_open failed, error -22
> >   Using PERF_SAMPLE_READ / :S modifier is not compatible with inherit, falling back to no-inherit.
> >   Error:
> >   The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (cpu/mem-loads,ldlat=30/).
> >   "dmesg | grep -i perf" may provide additional information.
> > 
> > There's an issue with fallback on the inherit bit with the sample read.
> > I'll take a look.
> 
> Hmm, no.  It doesn't have neight SAMPLE_READ nor inherit.  So the error
> message was misleading.  Maybe it should be printed when it actually
> clears the bits.
> 
> Anyway, I've tested with the old code and realzed that it might be due
> to precise_ip being 3.  I expected it'd return EOPNOTSUPP for the case
> but it seems to return EINVAL sometimes.  Then it should check it after
> the missing features like below.  Can you please test?

sorry that we are refining our config these days, then broke the test for this
case for now. we will fix it but it will delay the test for your patch.

fortunately, we saw Arnaldo tested patch. hope our delay won't cause too much
inconvenience.

> 
> Thanks,
> Namhyung
> 
> 
> ---8<---
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index f745723d486ba962..d22c5df1701eccc5 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2571,12 +2571,12 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  	if (err == -EMFILE && rlimit__increase_nofile(&set_rlimit))
>  		goto retry_open;
>  
> -	if (err == -EOPNOTSUPP && evsel__precise_ip_fallback(evsel))
> -		goto retry_open;
> -
>  	if (err == -EINVAL && evsel__detect_missing_features(evsel))
>  		goto fallback_missing_features;
>  
> +	if (evsel__precise_ip_fallback(evsel))
> +		goto retry_open;
> +
>  	if (evsel__handle_error_quirks(evsel, err))
>  		goto retry_open;
>  
> 
