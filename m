Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9C03AC39;
	Mon, 22 Sep 2025 05:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758518633; cv=fail; b=Yzr991iFOQBvHwoDOUDV/oVh5FFnmXaCMFwBqajwU2U31Jwh5zvYtB9nYRiI1mhYgcRZNN833mQaaLKSlTbIOmrmHalGWAgn/vElqWHcuQf+5fvIbzCYNSDvabURSG+lvNCpKifio2DS1c8t7jxqRsAs+lfwzguse8ZqLJiCw2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758518633; c=relaxed/simple;
	bh=MQlBWDpYfhroT8MMUeK0hUiaGDWYcfsXWTbSeRBCIeU=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uVWcTlbdKwhohfL7aLkAjlxfvizGTp/4ibsP2PviJZ/W3xI8kYNDM2KBsb9eC0/rpDiUotp1lXOQX46roP7texetnOszmAfPt5Q/oObyltTvLwWxisuVXfwP4c9hnEn+shMS31X1s5HeFPv7eXXHcDNVsMGUJI+2V/Q+76461Rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HpTCBevL; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HpTCBevL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758518632; x=1790054632;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MQlBWDpYfhroT8MMUeK0hUiaGDWYcfsXWTbSeRBCIeU=;
  b=HpTCBevL5TbaLzia34gGd3/zOZUORr5xyb83wkGWV4Ol58r/6QRjL3s4
   8wo6Bbaku8fjYRnEfOa6fhPyf9gvkkb/VZCA11tt5AIjtjgeDaGH4YckQ
   9qlBTVxk5DHmQgYc9Y3XQpJKclrGAGTF6vI4OAtn5SibehOehCAKDqNyd
   CUmCanTi8yJ7UwR9PACodeY7uK0J7yWX3UF3AaDne9p7ilks3gQ4+j268
   xmZtcZ1niz2OvaIBwmRD+/5l2WxFPmXek3OVUehYYbi50ibKaz8ore21l
   meLA6+gAJLrLSPkQ319/RqotI7PKg/UGIBSHu0ztuSxVlZWqN0E+M7xkZ
   g==;
X-CSE-ConnectionGUID: jX/S7TTGSU+FnzK7GJPlaw==
X-CSE-MsgGUID: rrKmzgjPS6ahfU1+l6LY1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11560"; a="60832560"
X-IronPort-AV: E=Sophos;i="6.18,284,1751266800"; 
   d="scan'208";a="60832560"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2025 22:23:51 -0700
X-CSE-ConnectionGUID: 6yICHZSFS/yk50NVG4LEVQ==
X-CSE-MsgGUID: iHdoYyxLR8Ko9pU2vmJcTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,284,1751266800"; 
   d="scan'208";a="177176538"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2025 22:23:51 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 21 Sep 2025 22:23:50 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 21 Sep 2025 22:23:50 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.38) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 21 Sep 2025 22:23:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mkECeMclYLPgsYQTf5r5bUlD8LWpVta8a+4lXFUO8CCdy2KInGyaxA0zn2+4jV5/JiktOAjk1ODIA5B8NA7CLoYM0IDOa24L/MXurFyzm5szZtWLgmcE+srSrIQQdle+QM+IEJS+ab1jUhtXLwRx0gSN/6Tfxp5cRXXjxm6JOqQ6KuQurqefyxKo8sj3QpF89/C3NE3JiXS+cflkrrK+7D2BuUnABelLkMIyiki+R0WKQy7H0bOsO7smBzXIMqv0YEl/OFjhMC3maHahpkmXnFBrGEDHXtQeAlKANyAZcp2Wa8Pi7JSPbIeu0z5LVQotrNC8czY1EaeIguKZ2F2AkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kvIiVCHNrv7HPgYlYzp9IoxapI50uklsxZjxbkjwa+8=;
 b=gHTmJPHicLc39/Xup2I0SUB3ldENUo3uphBOS5b24r1+OXXkVtrwaMKktPUiZaTddGquRhVZxToiNZ8PZoqYfhOeP9YMa51JhjgNSXrsE2hhgrryl4qoyzfeWe6zU32HYjIJ2j7WlKRUQSWQFgXVoJPdZlD3w2YMSfDGCspMjau+zv+KX5oAkiDK2U1cIgk9gr1v41wGJ38knJhepEtrlo6aQf3QzyJLr386jfcneWsxXU8GtWUvhq39OkbSpou/Gp4HazC5sNMf4i0NMo2GBCLGd54c2xgaRK91cn2a9vcRtNix98kKstZeVf9AgHkXAkNd5VWYFyISFqFfH0tfHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SA2PR11MB5084.namprd11.prod.outlook.com (2603:10b6:806:116::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 05:23:48 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%5]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 05:23:48 +0000
Message-ID: <be5624f8-c28d-4bd1-bc31-af8c5efd1f90@intel.com>
Date: Mon, 22 Sep 2025 08:23:42 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] perf/core: Fix address filter match with backing
 files
From: Adrian Hunter <adrian.hunter@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: Ingo Molnar <mingo@redhat.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ian Rogers
	<irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, Mathieu Poirier
	<mathieu.poirier@linaro.org>, Miklos Szeredi <miklos@szeredi.hu>, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>
References: <20250909124222.222945-1-adrian.hunter@intel.com>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20250909124222.222945-1-adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2P251CA0008.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::10) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SA2PR11MB5084:EE_
X-MS-Office365-Filtering-Correlation-Id: abef14c9-9579-41a4-d055-08ddf9983545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OTNqZkdzakc3ZklsbjR1REZrblN2SlRYcGdJRnY0WnFZMG5BOXpxOW5BcnNy?=
 =?utf-8?B?amF0YUZjNlArdVhDekszQ0owM0ZvcWtsdFpROFFhdG5iNzlIQm9jeVd0MUZX?=
 =?utf-8?B?QUZJM1ZyWGNwNWY4Njh3cHFBZ1ZILzJDMEdkblBBUFFJNEJTV2VDUUtVaGtP?=
 =?utf-8?B?WjJCZFRpZzN0V2dqWjFnUTJhM0ljSDNMa2lhODdWZXNMOGsxVFN4ZjRlNGdm?=
 =?utf-8?B?SkFkNHlZbEp6VTJDZ2R5VlBzcHQxTFIvWWlKamJ3NkV3MThoMXl2SDlsU1Bl?=
 =?utf-8?B?cnZ0UWxhTVBabzQ1QnhKd3FHb1hLN2NMRkhvSS9sT3pDeng2bHpySXc1TFlm?=
 =?utf-8?B?bEhzYTB2ZmVRSzN4Z2pVVWZqcVB3bDBZRHFKbVViTGhXV3RwNExwcFZuK1Br?=
 =?utf-8?B?U1ZZK1JPbXNKZ0VaNGNITkZzNXlVWkptOHZNbmlTOVFidU1BYStHbGVXTWk3?=
 =?utf-8?B?MzZWZ2c0bXNwU2pEbFU3Y0d0ZzA3anY0TFZuUHc0ZHFxQmRleGd2ZlkvMmE3?=
 =?utf-8?B?bkdzYVpBSWtaNUpRb0syWHRBVnZyVC93djZFNUJIVVdSSWFEWDB5MC9ZOE8x?=
 =?utf-8?B?cFhDbzN1UUhiRE1tREZ5d3BGbG9WQjl2bnROL1h4NHBtV0o5MWVQaUVTY2hD?=
 =?utf-8?B?T1UxcFdCRStNZTZ2Q3lJSmV6cVNVQ1dCR0pCa0lDOEJwbFZKbFNnd24zN3lv?=
 =?utf-8?B?c3FvOU5RRU5QMUh3STZJRVkrNUllcVlsOXRtYVdLeUwzK253ZS8xSzVGVnJn?=
 =?utf-8?B?UkNLalFrdXljb0hkeTVNWXJUM2JwUEh4T3F2N1pmVndITEpyeDNSa3dCSWM1?=
 =?utf-8?B?aVNCdmdpcVV6WWNSTENicHBQclY4M3JwTnlJY2trSmp5cTN5b0UvVmgyZ25U?=
 =?utf-8?B?OTBlWFVKdVY3enNpRXMxcCsrVlh5dWVVbjRqMzlpNzNZRzJXNEs3ejc2b3I3?=
 =?utf-8?B?bXU2VnhMTDR3VjliOVIzVWNNRFVWemI3M3hGY251NHR2V1kwZkpwdHRpa2xl?=
 =?utf-8?B?N3o1UjBQQzliekVCN3NIbkhaTXovZW9Sd0ZyM2NxR1NXMTluL2R0V0thbmti?=
 =?utf-8?B?R0F3UXFSUnpMQkdTQVRnQytKOG5GY0xoRGJob2l0SWYwS3VZajQzNHhQUG9J?=
 =?utf-8?B?RVNZUkFmc2RSU1N0cXdIZWxKazBYa0krZUY3Tjgwd0dSTlpUa0drMEhXYTZZ?=
 =?utf-8?B?cU8vdUUwOXNPZUhZbWNmalNJdGlRR3VQR2hUZ3JManJZZTFNN2MrRXlYcFlm?=
 =?utf-8?B?dGNOWHUveFpwb2VIbkdIc1IrMlFwUFA4STV1REdSZnUrcklobEs3Vm5PUkdm?=
 =?utf-8?B?TDAxTHdsUUVrL2d1ZmZPYmhobmJkRmZJdHpMY1JZV2RoT0diNXora1kycHU0?=
 =?utf-8?B?MUE3WGNveGhkK2tlbkJsRnlPaVkrTi8vVmIra2VVbGdxYmhjTnJsVkNKczhD?=
 =?utf-8?B?N1AvWXV1aEpLVTZqeUJnVHpPazg4dTdzUFBFRTYwQm1zdUZkTUZvREc2ZXZB?=
 =?utf-8?B?WTZ6dWxrTUVocFdCeFVKeG5uZWxqbUJGYTc5SmdtMGo2cWV0K25IRnlzRC9Y?=
 =?utf-8?B?RUlpZFdYenU5eVV2V3B5VGhBbERWdXA5WWtNaEovbFl0M3pGZnJDM25QcStZ?=
 =?utf-8?B?WkpvTlRqRjZvWE5iOFJ5Vy9SWDhtZ2NzdEFENklMQWQrWTNqRmtJakRHQUV0?=
 =?utf-8?B?a0cxb2lFTWRJYjdtV3BvbWpmU1A2RTdKUHo4MjVyZnFnTEV1ZitLVnl5MnlQ?=
 =?utf-8?B?Q0IrcXdlKzZFR2xFS05zQTg4c1pEVVZNc1o1bXdGZlU4Nmw1dWlFbUFyUHVh?=
 =?utf-8?B?ZDFjTzYrYkZZQlRWUURIcGZRcHhpMXZ1Y2tKSmlJUXBDUDZUNll4dGVMZzlU?=
 =?utf-8?B?Q0k0ODN1NE5tV1ZxYTc5NFd1UXUxcXA4azJ4a2FMb0w1bWdBSktjVWkxQzI4?=
 =?utf-8?Q?ieAw9dAcuJ8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjFyRkVuMjNDMkRvS2JobUFPL3NRSkNhekhhRW9JQVJuZnAwWDRkWkFXSkdu?=
 =?utf-8?B?aEFRNEIrM3FsSWQ0QTVQSnpmeUNzMHEzcmpQcjBYc005clBoL1M1eEY2UlZH?=
 =?utf-8?B?UTNmMnVMRitvYlRZV0N2QU02b2I1emVFU1dmNW5qc2ZQU0F1NVk5c2RZTlN4?=
 =?utf-8?B?QnlqSnY5citSU3FmWEZEYmdOeHNjbWQ2bksyV3JWN3oyRFFGNzZ2cGFoa1lz?=
 =?utf-8?B?ei9wbytuMDBSVnQ2cCtpZml3N1NCcWRicVhsTjBHNHRJYklhMWpqbUhxTnJJ?=
 =?utf-8?B?SVNlWnZybDdkUGgyZjBqSVlHc1RwYnB4VUNtWGwrYnhUUUxPM0s3UjBHVC9H?=
 =?utf-8?B?OXRScDE5MVcyL0tBMGVDVjhIMEJFcjBMS1RzWVgvZUhtMVNqK1l1MzkzK2xt?=
 =?utf-8?B?dzZ5OCtJc2s2K2lnbDV0eTM1SGRIR0NzckpodFdjdU52QzNPUXlJTjhheCtx?=
 =?utf-8?B?ZDB0d1oybkw0bUVueGFJTjl1Y0t3S3NGWWFPRzIyZFdKc05CZ0FheDFkaWJZ?=
 =?utf-8?B?QXNsL280ZWpldHRVVFJXRGVSOEl4cFUxQkZDaG5TditzelV4OUJXSmpvU1Bh?=
 =?utf-8?B?SVBPUVhxUXpTZUhTVzgzSTZYSVJ4VG1WVHN6cWhNUlkvTGVZNXBNWmJQSzVE?=
 =?utf-8?B?T09JbFl0eE5UWDJFVXNGNHNVS0F6UVdqSVBINVhKc0ZkWm9BTjY5NXRSWFNq?=
 =?utf-8?B?K2s5NXdmYjdtRksya1NFM0pyYmlRZXVSMWxpSWd1Nm5nVkRQdk5TWDVRS1Ev?=
 =?utf-8?B?QzdKN2RlamVwUExlWlBUcXlFc2tWaXdlYmt2WWpsVmNVTmswM25jQmN2SGRa?=
 =?utf-8?B?TE9VM2tuQW5Melg0OURDQnA3T3VRMlUxODFaaUFzZXZhbnRMK1JIYzduQ2k3?=
 =?utf-8?B?d0VrWWp4RHhPWGV2bTVhRVJhU0ZwTWlBNmU4NjJ3M04vSktTYlNmYjdCWUp6?=
 =?utf-8?B?cktmRmhmOEp5RVBjQnYxS1N3TjUwQ2ZEYWVRdysrSURONGs1djI2OXlSWjRT?=
 =?utf-8?B?cnl5ZElVNmhrcEJWbjNqRW4vcVhuS2VCYkt1M0VQYzk4bjlwbTAvRzJta0Rs?=
 =?utf-8?B?QjVrT3gyNERXM09yMUMxalZQVGEzZ09sOWwrYWZ6eWt1ZTJHWUFvOUJIMHZD?=
 =?utf-8?B?YTBOTnBNeEI5Rkc5UUdITUhXN3l2WDZ3UXd1d1Y3KzdZUkR0VkFxZ1E4Yjla?=
 =?utf-8?B?U29tQ25ENExjei9wa3daa041bHhMbTUwSEZVM0xvNUNsbHhCWXpHVmdrNGZF?=
 =?utf-8?B?em5jMFFET0MvdTR2YTF3dU1RQWdaK29YWnNVSGNoSHQzUStlWHdtaTVkdmpy?=
 =?utf-8?B?WEc5Z2pZclZ5UnhJclY5a1ZDeDY4b29Ub2V1MFYwOGhrOW9LUE5kUDRDVHZ2?=
 =?utf-8?B?dmFkNW5WVC9jbGl2Z0xjaWI1Mmc1QTA1UE50NmlLSTRwOEtkbFJFRjRFV2lQ?=
 =?utf-8?B?RWEzK1ErdWYxUEFSZlR5QmxFYXhydFEyU3pzQnhTUDlKMzk0NTlvZUY0RUpv?=
 =?utf-8?B?ZW9jWDlVUG5zOENwZmQzOUNXNzdpamlZNGhZV3dZVGpGcXBUZkJYR1R4TDJy?=
 =?utf-8?B?NHFxSHJGQUt0WEN2THJqbTJKNUhGNEdpcEhJMFE3dXVYRU53WXJRQXl4eFpB?=
 =?utf-8?B?RjhDb2JiY0tjVU5Sd29tYXhPQUJpQlF3NXp0Tk1UVnVYdG5ZcGFmNlgwcHpX?=
 =?utf-8?B?cTFLMUtZUUxydktpWEpnQzhOeWZ2ang2bzcvMVBER1NUNkl5N1Roeloyd0Vv?=
 =?utf-8?B?WExxQ3paSE5Wb09HZVo4UnQyYTFlb0tveHFXNFFhQ210V01HRWU2OHp5L2RC?=
 =?utf-8?B?VDkySzhlVGxReUd1d2JvMXprcVhNbDJyelBKL3pDQUNrdk1JaWZyT01xWVRL?=
 =?utf-8?B?enh5YWxrTFpWZ0FXc2lRNmdjYVc5eE1JMXowRmsyanNZWXhOeVVTNlRrN0Iv?=
 =?utf-8?B?ZTh3bnptTnVlWG1xK3Y2YlQwdHBVakhISDBxZzhNU0xiRnNDMkdpQXpiWEV5?=
 =?utf-8?B?Uk5wakc1VHFIakZmSFNqU01JZngxc3h5TzNjR056L0hTcmh0RVdOQmsydk10?=
 =?utf-8?B?aXFLTFhxT1RoY1NaUkhWNlJ1cHBINmlJSjdPa3lGc1U3bVE3RXl2N0tneW1G?=
 =?utf-8?B?OThQbVovVS83M0dDU2FWV2NwcFNHWmJQWTlDdkVqek9PSHdOR1Z6cHVxZG1Z?=
 =?utf-8?B?bFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: abef14c9-9579-41a4-d055-08ddf9983545
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 05:23:48.3847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UaiLU5NWkuwzmOFrSJzbMXxkHFnvGaNoh+9ynCbjBewfxYvSvKbtOqWMJHyFimxCbQtPt6AbRwKpB5+eT8Q7ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5084
X-OriginatorOrg: intel.com

On 09/09/2025 15:42, Adrian Hunter wrote:
> Here are 3 small fixes stemming from a report that Intel PT address filters
> did not work in Docker containers:
> 
>   https://lore.kernel.org/linux-perf-users/aBCwoq7w8ohBRQCh@fremen.lan
> 
> 
> Adrian Hunter (3):
>       perf/core: Fix address filter match with backing files
>       perf/core: Fix MMAP event path names with backing files
>       perf/core: Fix MMAP2 event device with backing files
> 
>  kernel/events/core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Any comments on these?

