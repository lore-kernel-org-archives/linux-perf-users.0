Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F573211293
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Jan 2025 13:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737640518; cv=fail; b=gDopzur9rASIS8N4Zk+yPVxPb6eVEqVWNOa0d7m1mk5HntgZZtIxNhitOv0ngRtUhTLz9VjrRhHq4UMHgwLHZ/HYTm1U679WT+Ote2VSK/jdmi/5W2A9MWRANhsb8/dkYR28FWs/4BjMo2uUB2H/pmuiLErGX7VMFv4UVm/t39w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737640518; c=relaxed/simple;
	bh=o4n80zMlahaI8M8+v6Md98iQG0I6XVBxTX7Xh22odXY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=si6XWUw6oFk43YHfV2uR2cl1BQ6v8p9Lf9NBf5u5tHTGnAxTziw8RKg17+oi9ZR2yxUSlJy+9b2NtjVuxZ6YLQG5ZRehnnNMWiyl2MXZ/JGN3rK6gqzH19kCGYmEu1PEUOKEM/3+mwjm8FRBK7QrWAaEWC4duJX5qsrzavi7r8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dq3wDxTZ; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dq3wDxTZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737640517; x=1769176517;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o4n80zMlahaI8M8+v6Md98iQG0I6XVBxTX7Xh22odXY=;
  b=dq3wDxTZQ6IgFTolMrC+xOdOwp9xi0sBNQAFT51xwRh0VrfdowTg96aU
   TbR0jbQA6Y8guQH0OVpvOD7Al53XSkVDayNQcesavS2KcaClmnPZ1g1jH
   S4zJoWQaIz5NDBP3sghCpkuLtq7CpeJg4YXah9S8UAd/gEy9qyQG/vVXA
   ZliPtOKkILaGK9iR3A9/I7B7ThsOb1QYXxRITlsyVQ2BHjql5DSHcGzJk
   JnX9Z+UjMaWShW025/zpUbThVoY6ulfjEzDcl9BHkgbuzvIFzH1w1JyVI
   MFYs6r44Gj5Cso7Xz4XcMyB06VatpqWPbweMekRF1hlXhQyLHxZR1iKxU
   g==;
X-CSE-ConnectionGUID: s/iERqfORSWq3C6T7Af+0g==
X-CSE-MsgGUID: VyeBPIAuTvWMfN55eAE+Yg==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="38303680"
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; 
   d="scan'208";a="38303680"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 05:55:13 -0800
X-CSE-ConnectionGUID: s4bO3ylxT+Gxx8rBp3Smsw==
X-CSE-MsgGUID: URq42m6yRzWgAH5uks15tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="138339895"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jan 2025 05:55:13 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 23 Jan 2025 05:55:12 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 23 Jan 2025 05:55:12 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 23 Jan 2025 05:55:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uGNVCh2Lz4/hZSX4LB0LUlxaYH4IwnUSBOOnmDnG/d9+OEcFTYe0u7SuAqPrIfbGqAJtp4uFqgFr8g5JLL38Vouosp4VYlLkZLCuCiLcRmR5DWM3saqjM5qkeCSCQR/IxB+eJDv4ucU1C2MJNNz/O/6E2yiK4ZZx2rsgTxZkTc8+ENkbejRZk8p/8ccHlQ4H4hi8A1+xNExhfHaVGhqd3x/pSbXgdcMOAHSJhQ9wKXlsSjkw4rL6u/wYulskHqXJG8hsF2loOygitt6wpXiDSknkfh9s5FUJVi1eODJV/dSTb9AmyaH8MN8Ly1oJ0UHMg85MCLY/jpQ/G73FHDg5ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+U44bS78sKQ/WAbb3CSQIIVrb6uRYQDYSuYFNna64Bo=;
 b=k9Lt33xYLR8k+qbz5hgnNH9uA9gr6DZOBFbKVjHFH3BfUNHiuRmLFzMVX98ZIfPXAFCeF2+r6i8k63iEVC5pCVw8ZAbYimF6sDFCnQ57WVHkmML8sixytWej8uHrKBDyOQ5RrdeozRIHGoXwbhq5xXgB97cixEW0Fjes8dpujt+iVDvQfNZepfoEgtAoL9asuAGOGZA7HrIwLFmA4yxP0najnAaDackYKuatGhI8GTXRboV8rtSwsARV0H2CJZCn7eSaWogRjri3NMLj8De7jaXFfyWi2+xE1dIcdD9SGU+AthYUnxuq6cXyKZOZLrpBZZn+IE6heJ+cZmcKLy3jUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 PH7PR11MB7452.namprd11.prod.outlook.com (2603:10b6:510:27d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 23 Jan
 2025 13:54:29 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::d3ba:63fc:10be:dfca]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::d3ba:63fc:10be:dfca%3]) with mapi id 15.20.8356.020; Thu, 23 Jan 2025
 13:54:29 +0000
Message-ID: <c0f2047a-9c6e-4a31-a8f8-0f287c09e242@intel.com>
Date: Thu, 23 Jan 2025 19:24:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 4/6] drm/xe/pmu: Add attribute skeleton
To: Lucas De Marchi <lucas.demarchi@intel.com>,
	<intel-xe@lists.freedesktop.org>
CC: Vinay Belgaumkar <vinay.belgaumkar@intel.com>, Peter Zijlstra
	<peterz@infradead.org>, <linux-perf-users@vger.kernel.org>, Rodrigo Vivi
	<rodrigo.vivi@intel.com>
References: <20250123041923.1892837-1-lucas.demarchi@intel.com>
 <20250123041923.1892837-5-lucas.demarchi@intel.com>
Content-Language: en-US
From: Riana Tauro <riana.tauro@intel.com>
In-Reply-To: <20250123041923.1892837-5-lucas.demarchi@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0215.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::8) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|PH7PR11MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: a39a49a2-0e82-4592-23ca-08dd3bb574e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VTdqNTlUdzRsV1lIVU15aE5CdmdTWlhxcXZMdDlmaFN6d3g0cmVqSCtaaDhP?=
 =?utf-8?B?REFOZUQ2T0k0RDU4Z2p1a0FIL2s0emxyMGtTczF4VmFIbEUvRHpoejZ6NHl2?=
 =?utf-8?B?M0lLTzBWMWpaOHpWRitDcXp1U2VxMnQxL2RJdTllakg0amhITCtUMHRYdjlV?=
 =?utf-8?B?OEIzbklnNU84dkJNM3AzQytMRFZSWDh1WXdMem1sUU9PclRORThpMWZkbWxJ?=
 =?utf-8?B?V1RjdDFkMkJ0dmVaUGsydUp2dkcwM1lyWFRNQkYzdUx4dG4wODJaaHhqd1Y1?=
 =?utf-8?B?T1FDWDdNNERhd2JVVFFIMGMrMnBzZmNrTzdBcXpScXhSSFV1aGNqRzZML0g4?=
 =?utf-8?B?R1ppNlZqTUxLVnd0L3AyNWFLUWtQMzd2bzhsVzZTcVU5ZjJZcnorQXk0d1pS?=
 =?utf-8?B?TmlkZnZjYkZSdEpsVXB6RTArQmNGZjN3ZmJTbTdJK0wxSEFHdWlSa0tQeU4x?=
 =?utf-8?B?VG55dC9qS3VMcmtlSVdGTG5oL3pETXQvUmNsVEhtajNDK0NWSTlMRHdSeml2?=
 =?utf-8?B?Vk9sTG5CWllHd0VnbGJpaFYySW9UMStZRkMzSEp1c3dvY2cxZ3ZKeGQ0ZGNn?=
 =?utf-8?B?TlVpdHZVa1hkZ1Y0aHBpbXpyRWovU3ZSYWdtUENIOW1PWW1vQVd3UDNYdUNl?=
 =?utf-8?B?aUNaYnBBNTFtMlJYS0lvOW5Eb1FhejJuNHgyWE9uMjFPTGR4MHArbVUrckVr?=
 =?utf-8?B?ZFNvcnQ0QzMzMkdMbXBlbnNiSUxjeGNxNUJCWjBUa3JRUEY1ak1ob3ZJbG9h?=
 =?utf-8?B?RE9aOWZGT1dDZkNxNlY0UW93N3ZQblRpOTRPUWZYa2RndWE4Q2hQeDlIRnJ3?=
 =?utf-8?B?U0JaMjFSNHgrUmZ5aWljamtxUmJ0T2ROMi9QUTNIbGFvWXkxTDVGMWhYZ29o?=
 =?utf-8?B?cVVHUmV4cjFDVGZEd2NTSVFaL1U0S3dlWXhmQ0xBekhDaUtnQ2RSdEF3cTJT?=
 =?utf-8?B?UUp6Wm1BdVNrWGtvdFh5OEJFNnI4YWJibEZEbnZUbzMrN1d1ak1xZkl6d1A5?=
 =?utf-8?B?SEFZd0VsU28zMlZUbXJ5ekVhOE02ajZKNkNZZHVNWGdXYUZ4UHA1VmFJWndq?=
 =?utf-8?B?VDVkdkJ1M2ZQUE5wV3RzSXgrMXVyTnFlbEZEbVI4Qkt0R2tsMWJLVXQ0QTlK?=
 =?utf-8?B?MzhFc3ZWbUF2bzdmeFNJVURjWjJpVy9KV2tPWmRDcnEyTlhiM05QR3F2Z0Vv?=
 =?utf-8?B?Q3VsN1Awd3pWaWt1UXpReWFSUTBUY1BoNzlPcmtkL3hYMjVDOVZMWUJ1MGhi?=
 =?utf-8?B?emkvQ1ZQQ2RQTjNvcFlyOUNKUmhmTkYwVUNZREVTVWMzWmdKQStiNTBBT09D?=
 =?utf-8?B?eGRibkJ2UWRZU2VuaUovZTZ6Wi9SSk1CaHRXbGE0OTYzVnd2dzdVQlg2Z2hZ?=
 =?utf-8?B?cUdxOHl6MXE0Ly9CQlI5U051UUNSbDYyejhPMzdnRHBsd2pYdUZkT3ZIcFFx?=
 =?utf-8?B?S1ZQeHl4akNrR0RoWjA4RjJKU0xjNWJxMFh0NXNwVWNBR1o0NFE4RWtLUk90?=
 =?utf-8?B?ZUhMSnFwSlg3bzcvRXYrb3VyZkVJcVJsWnlGeTVaL1ZUQk1lSUgvZytmaGQ2?=
 =?utf-8?B?Q0JETDZkczQ5RmRJc1dieEhEWEYyZW9icE9XOWZIYXZkcHZpaG9GZ0VpQ0ha?=
 =?utf-8?B?T1RFTkZsVnpoYUZtVFVuTll3TUlNWkcrb3JOaVNzUXNJVFB4Y1AzWVpJeWpY?=
 =?utf-8?B?V2MyUnJkeS9tRWhuMS9PODJnMGZ6TWcvd1I5dCtJbHMvUEp1ODJ4NEdMTDhW?=
 =?utf-8?B?cWVocGR5Sm1DUGFDMVhDbmZoYng4UWYzd0xjY1MwSGZtMXo3MFBSc2xsWHIy?=
 =?utf-8?B?VFJ5cnMrWHBxVmxGOHFWYmY1ZzlKRUxQUlcxUjYvV0YrK29wVU5yY3RvbllT?=
 =?utf-8?Q?UcgVub7rg/YUt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qm5Hb1BQaUJQc2dkbk85L1EvaTNONFpmbkx3ZXgrK0dkYWZsUzFiVGZOZmFH?=
 =?utf-8?B?VmE1blNJaEg4UDRVWUFsVU1WMXlZYnlhcVhpeksxdjAyWmxzWXNwL01qU0FZ?=
 =?utf-8?B?M0xtekZKNkV6cFMvMnk3a0FmdFZkTUorSzRPNW9xNUlnOCtZb1lJd3kxTGRU?=
 =?utf-8?B?U3kwMnNuQklwY1gzYlVwd0xFVWhWVWtBSjFJZEdSaC94SmVqWDlMb0VicmNZ?=
 =?utf-8?B?WUdlOWFjai9FTXZ6dWtjQU5kUlpGWllKWGJERWhFZXNoMmR6N0lCVXFVdnAr?=
 =?utf-8?B?NGErMHcwZStLSVYvYWZNVWQrWkhHMkFoODFuRmpORHNSejR2alc2bmhFamhQ?=
 =?utf-8?B?Z0JQTUhyUTJlME4rL0s3SVdEbU9LanBjcHY3TEd6eXptYVNlSlNCcTI2cEJD?=
 =?utf-8?B?eXdobVhWN1pTQlJwc0xTd3dQclQ0S3J1TU14WkpQSjJDRitVVmhpWTlWUmJt?=
 =?utf-8?B?MkRoRWJZeVZMOVVvVGdDdE42Rmpqd1c2TU91NjcxV3FlTXRJWVR4a1VtdDZu?=
 =?utf-8?B?N1dCSDUvQzBnTGpBUnpCUHp2eXF5QmRZM3hjWkNidFZ0WlZNYmh1ZGxJVnVw?=
 =?utf-8?B?TGpXTXZlWlV2STBOaExkVkp2dVlpMGNSQis2dGJIWE1QQjBTcEtQYXh3Vkpp?=
 =?utf-8?B?djRFaWZFY0dSdzNENlEyMFkzRHNVWnpzamlicVJ0cVhibHUvQlJBeFA5Ni9u?=
 =?utf-8?B?Q2krTTRpL2FrZVBha3hKVm94NEp2a3lkUC9RenNJaVpieVR0TEZoWTI4a0tn?=
 =?utf-8?B?Yi80M1hjTGF2dHBMRDFmUFdYOU9NUEJubnYzUEFVL2hBVG5qNzhlKzB5SXRr?=
 =?utf-8?B?dnE2a0duR0NpK1o3Q1VRS0t3VSt6ZURMS01lbEdySWhyYlhBdlhCQkI4ZGdl?=
 =?utf-8?B?S215UmJMR24zV1lXZmVFVGN2MEk1T0FmcDljbERodWZpMityVVhxYnRHQWhR?=
 =?utf-8?B?aDVMSCtaZkR4cTJ5dXlHWGxzTkpna3NIQjdUZ2xOWFk1elNGYlNSUGJNajlO?=
 =?utf-8?B?MzJCSHBaTW83MWErRVlxRFl3QUc1Q1YwMGhBZVBpWkZlYTRSVFNxUXlvblVw?=
 =?utf-8?B?MHpGeENIcHdtaU1tdkQ3MzZYMUN3R0ZpQzE0QUkzWDNiaTlwTEdLN2xvdWZH?=
 =?utf-8?B?bG9tUlBTWXk0YTRYTGI4RStud2RvbWxJdWFzektlOWVLRHNKb2dMbm03OTg5?=
 =?utf-8?B?aUtXNGg3WjJZc0VhT2wzcFBVSXcwMWFad1I3SzBTMzdkR1FOZ1VTblM3VHVx?=
 =?utf-8?B?cEVJRzZoVVNBMStGNUdwR0lkaHNjRG8ra2U3ZTVjTjVZbnAyWDJvV21Editv?=
 =?utf-8?B?YS8xUFpmS2ZXSUlSb29xRDZrSUtJUFVJdXNRREMzbythaVVJV2NaKzFOQ051?=
 =?utf-8?B?MzV2dG5uUGdCSldzTFB6SGw1d0NSMkRUTEhQQjRsUzB5TkcrSGJESW8zS25u?=
 =?utf-8?B?bkRsbHBxQ25DcmptWU5wQk9qY1R6SmYrY2RlbHNrSkxLUU1WVmxvSzUyVTNr?=
 =?utf-8?B?bk5EeXVoeUFBNmdRNjArakV4b2NES3J5WVcrNWtLc2gvUWtHWGw0NHRJalcr?=
 =?utf-8?B?NUl4WGlxakl6ZU9xZnRURkU1Y3dKYVk4Y25ZcHp2NFRWUDNUK2tXaG0yeTcv?=
 =?utf-8?B?T2tBMWF5VkhvWWJBMGhFdm1vaXFYNWN6WUVuRlhxbEx4RVhLL2J1U0ZJWGtt?=
 =?utf-8?B?VkpkLzNKSWM2bWExRm84TTBabnJIdkNkc0JUYkgzVFZjWk9vTGJjMkd0dzdX?=
 =?utf-8?B?eFdvS1JKVDRHSW83ZHlidlM0dnEveTZtL3BpaSs3RWZCRXd4WjI1VjRoNWRk?=
 =?utf-8?B?MXpFRUhDanBVTTZuWE1LZVp6cTF2em5iZDNZa3Q4VmVCOXBHTzhDRGNJY2Na?=
 =?utf-8?B?RUNYMXhnelFZTkdMMnFMbkx6anlLbXFIcWN3VHUxbngvcVovbEpud00vRTF1?=
 =?utf-8?B?Mkpqemk5OEF2L003aFhDRER2NWMvYTJhOC91VmxFUkRpNTVNSmZGN2JRMWRU?=
 =?utf-8?B?YUl1TUl4TC9TZElMN0pJQyt6QmQ0bXU4WG5XRVVtTjNqZm91NldIZXJOeURj?=
 =?utf-8?B?WTFUQXliT3dUUXkzSFJvN3dLUkFWeWptNk54OE1Ld0E1ajZyYXhveUg0SE1L?=
 =?utf-8?Q?edmV4PnqzawPySUncBEWaBKxT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a39a49a2-0e82-4592-23ca-08dd3bb574e1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 13:54:29.4022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SXqvQKAjf1LMNrRONvtj4gMSsL34nbRDNVT86Fp4hw8Pg9SEWdXCEW9c5ReAZqfiy/YHzACntaoULb87cbzaYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7452
X-OriginatorOrg: intel.com

Hi Lucas

On 1/23/2025 9:49 AM, Lucas De Marchi wrote:
> Add the generic support for defining new attributes. This uses
> gt-c6-residency as first attribute to bootstrap it, but its
> implementation will be added by a follow up commit: until proper support
> is added, it will always be invisible in sysfs since the corresponding
> bit is not set in the supported_events bitmap.
> 
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_pmu.c       | 60 ++++++++++++++++++++++++++++---
>   drivers/gpu/drm/xe/xe_pmu_types.h |  4 +++
>   2 files changed, 60 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_pmu.c b/drivers/gpu/drm/xe/xe_pmu.c
> index 33598272db6aa..5e5a9fcf30ace 100644
> --- a/drivers/gpu/drm/xe/xe_pmu.c
> +++ b/drivers/gpu/drm/xe/xe_pmu.c
> @@ -46,6 +46,8 @@ static unsigned int config_to_gt_id(u64 config)
>   	return FIELD_GET(XE_PMU_EVENT_GT_MASK, config);
>   }
>   
> +#define XE_PMU_EVENT_GT_C6_RESIDENCY	0x01
> +
>   static struct xe_gt *event_to_gt(struct perf_event *event)
>   {
>   	struct xe_device *xe = container_of(event->pmu, typeof(*xe), pmu.base);
> @@ -60,7 +62,8 @@ static bool event_supported(struct xe_pmu *pmu, unsigned int gt,
>   	if (gt >= XE_MAX_GT_PER_TILE)
>   		return false;
>   
> -	return false;
> +	return id < sizeof(pmu->supported_events) * BITS_PER_BYTE &&
> +		pmu->supported_events & BIT_ULL(id);
>   }
>   
>   static void xe_pmu_event_destroy(struct perf_event *event)
> @@ -210,16 +213,62 @@ static const struct attribute_group pmu_format_attr_group = {
>   	.attrs = pmu_format_attrs,
>   };
>   
> -static struct attribute *pmu_event_attrs[] = {
> -	/* No events yet */
> +static ssize_t event_attr_show(struct device *dev,
> +			       struct device_attribute *attr, char *buf)
> +{
> +	struct perf_pmu_events_attr *pmu_attr =
> +		container_of(attr, struct perf_pmu_events_attr, attr);
> +
> +	return sprintf(buf, "event=%#04llx\n", pmu_attr->id);
> +}
> +
> +#define XE_EVENT_ATTR(name_, v_, id_, unit_)				\
> +	PMU_EVENT_ATTR(name_, pmu_event_ ## v_, id_, event_attr_show)	\
> +	PMU_EVENT_ATTR_STRING(name_.unit, pmu_event_unit_ ## v_, unit_)	\
> +	static struct attribute *pmu_attr_ ##v_[] = {			\
> +		&pmu_event_ ##v_.attr.attr,				\
> +		&pmu_event_unit_ ##v_.attr.attr,			\
> +		NULL							\
> +	};								\
> +	static umode_t is_visible_##v_(struct kobject *kobj,		\
> +				       struct attribute *attr, int idx) \
> +	{								\
> +		struct perf_pmu_events_attr *pmu_attr;			\
> +		struct xe_pmu *pmu;					\
> +									\
> +		pmu_attr = container_of(attr, typeof(*pmu_attr), attr.attr); \
> +		pmu = container_of(dev_get_drvdata(kobj_to_dev(kobj)),	\
> +				   typeof(*pmu), base);			\
> +									\
> +		return event_supported(pmu, 0, id_) ? attr->mode : 0;	\
> +	}								\
> +	static const struct attribute_group pmu_group_ ##v_ = {		\
> +		.name = "events",					\
> +		.attrs = pmu_attr_ ## v_,				\
> +		.is_visible = is_visible_ ## v_,			\
> +	}
> +
There will be some events that do not have the unit. The previous rev 
was simpler to handle such events

Can the previous revision be retained?

Thanks
Riana
> +XE_EVENT_ATTR(gt-c6-residency, gt_c6_residency, XE_PMU_EVENT_GT_C6_RESIDENCY, "ms");
> +
> +static struct attribute *pmu_empty_event_attrs[] = {
> +	/* Empty - all events are added as groups with .attr_update() */
>   	NULL,
>   };
>   
>   static const struct attribute_group pmu_events_attr_group = {
>   	.name = "events",
> -	.attrs = pmu_event_attrs,
> +	.attrs = pmu_empty_event_attrs,
>   };
>   
> +static const struct attribute_group *pmu_events_attr_update[] = {
> +	&pmu_group_gt_c6_residency,
> +	NULL,
> +};
> +
> +static void set_supported_events(struct xe_pmu *pmu)
> +{
> +}
> +
>   /**
>    * xe_pmu_unregister() - Remove/cleanup PMU registration
>    * @arg: Ptr to pmu
> @@ -270,6 +319,7 @@ int xe_pmu_register(struct xe_pmu *pmu)
>   
>   	pmu->name		= name;
>   	pmu->base.attr_groups	= attr_groups;
> +	pmu->base.attr_update	= pmu_events_attr_update;
>   	pmu->base.scope		= PERF_PMU_SCOPE_SYS_WIDE;
>   	pmu->base.module	= THIS_MODULE;
>   	pmu->base.task_ctx_nr	= perf_invalid_context;
> @@ -280,6 +330,8 @@ int xe_pmu_register(struct xe_pmu *pmu)
>   	pmu->base.stop		= xe_pmu_event_stop;
>   	pmu->base.read		= xe_pmu_event_read;
>   
> +	set_supported_events(pmu);
> +
>   	ret = perf_pmu_register(&pmu->base, pmu->name, -1);
>   	if (ret)
>   		goto err_name;
> diff --git a/drivers/gpu/drm/xe/xe_pmu_types.h b/drivers/gpu/drm/xe/xe_pmu_types.h
> index 0e8faae6bc1b3..f5ba4d56622cb 100644
> --- a/drivers/gpu/drm/xe/xe_pmu_types.h
> +++ b/drivers/gpu/drm/xe/xe_pmu_types.h
> @@ -30,6 +30,10 @@ struct xe_pmu {
>   	 * @name: Name as registered with perf core.
>   	 */
>   	const char *name;
> +	/**
> +	 * @supported_events: Bitmap of supported events, indexed by event id
> +	 */
> +	u64 supported_events;
>   };
>   
>   #endif

