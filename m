Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE8213D504;
	Tue,  4 Jun 2024 01:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717466254; cv=fail; b=h8aIv3R3AodyfoAF0bBFMkwrhaie6RNF+sRsis2Ra/cguMzBfoTtbxcpTeZdUcR2W4trBdO/w0UPopZyTYZ+ElG59V667EXzCHi9x4Lras9oBAVtkA/2ZncDClXD1f6Uc/dLlZGaxwM2uiGD2zxEG/ENPEYBR9ksKsaKfrQMdqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717466254; c=relaxed/simple;
	bh=ZNibBsH33APzqhcrrtHkPQOWmbksV/pgAL/8i1J14Nk=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qW9pAbql14xiecDtbFWJ2jUwJ4B/4AoEl09KOSrBx738XxmsvQ0WWleaem/wcYSuCWYANpVqcZuKF8Q1gKnoyAWpz+kUKylS/HXwzeD57vGjjrMaHxf1F9nPfIfU8jKNzIFeBw10u4DRC54K2gAv2F0uxiIRkIF+TJeSXvU/4iM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XZ2hJiVH; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XZ2hJiVH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717466251; x=1749002251;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=ZNibBsH33APzqhcrrtHkPQOWmbksV/pgAL/8i1J14Nk=;
  b=XZ2hJiVHHyAbJWEd5OHPid3zEeSHAB/eXY6Zpt890yGJ2ok5Y2bQBf1o
   pj03xeiTTOdjdReKHoKgD4OagM+d09E6gW2OhQ4j4mkTHxWxL5LhynILn
   xuW18jYLwFMmR9SpiWjDIjaDueiVU9pua+T6HlN0tpmLzM+vWGyqWT/ic
   tP5ktiUMxgwNbDUGvRbI5Vxm7PjyA0Qc38sikPhUDvu+EAEgRAmyK5Tih
   7vJmM+Vwdp4PK4Ob4jwH6DYRICVxmFim6pe1UlLb/Wh7ssK0fCPKNnEQF
   hDjGvSq9YMLu4w7n1lD8hLAQmtpJL4p9SprdFBK2V1SP3DFBP0p4mwbxM
   g==;
X-CSE-ConnectionGUID: 61Sv9fKpRUSgQH22mpfjzw==
X-CSE-MsgGUID: c3VPGT2ORv+sOUM3NnRSnQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="17820515"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="17820515"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 18:57:16 -0700
X-CSE-ConnectionGUID: Za3FKz0tR+Ox+KxIjdlgOA==
X-CSE-MsgGUID: 3BjCJgIER2eEi3rKXsr/1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="37018830"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jun 2024 18:57:16 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 18:57:15 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 18:57:14 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 3 Jun 2024 18:57:14 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 18:57:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZP9vMYuz7Wjw0gXIhplsPEaS+SiytaZ4iyS/0qS/dox07vDWelZqOALYN81wT8WdCMED3iFRwg005mCax8Rqfx6/IbUq/hqqQNNxhIN8WSpeGDSF6G0jfAUEcWuqw8Ic/xRt3M9E78wscivZKepj8QlcCoJW4aoGDQJkbPCxvEW8/SPrgshbRaEdD277roMtvxo6TuK+nweCECl/2rMqreA76903zqA6jCON0ZowZWMwHpuQdnpWZ6UaBU081V2Qq5JxpJU8lrUbee1774/+KMG8oVmmlvsXqlobDCDrbrZE+Pmk0Bq9xNAU8shjcjZ5CgkYC0Ctf2Uoyxj75DvCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtUkDJLE7NbXyadRkTfwn24XRccomvI6VaFcRbipn2o=;
 b=WLXiOmrsUgMkbMERDC/pHQ1i88u0+Es2mrIk4/KPrRhDqyhsc0jqlGhpEDcdhU3nBmj6nrMo7smr/g6TtORcIXXpvGWx3vpco4GBWGEO1rwd/QkntVCFHf3C0qL71bPmaYZY3hK1qYGaHwiZZJkpPjvMC9wShAwdRPZr6d66AVtm+xzpwdLouQHJzxaGOi28YepBB7sauyaNBWEKjsm/1oMa69joKRWojO9RB0d9tHamy0JhqsCEKDIho86bzx98Dq0arYUTz0++hKxjOTaTrgF+fZn+FtsYeB1ruCAj1mQrHaomBySIYYCTj4v9v6RZXJjph5+hk/4uXEiXJxSldA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8393.namprd11.prod.outlook.com (2603:10b6:806:373::21)
 by DS0PR11MB6544.namprd11.prod.outlook.com (2603:10b6:8:d0::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.21; Tue, 4 Jun 2024 01:57:12 +0000
Received: from SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::1835:328e:6bb5:3a45]) by SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::1835:328e:6bb5:3a45%6]) with mapi id 15.20.7611.034; Tue, 4 Jun 2024
 01:57:11 +0000
Date: Tue, 4 Jun 2024 09:48:50 +0800
From: kernel test robot <yujie.liu@intel.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra
	<peterz@infradead.org>
CC: <oe-kbuild-all@lists.linux.dev>, Ingo Molnar <mingo@redhat.com>, "Mark
 Rutland" <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Heiko Carstens <hca@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>, Hendrik Brueckner
	<brueckner@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, "Mike
 Leach" <mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
	<coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>, "Yicong
 Yang" <yangyicong@hisilicon.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Will Deacon <will@kernel.org>, "Arnaldo
 Carvalho de Melo" <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, "Namhyung
 Kim" <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Andi Kleen
	<ak@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <llvm@lists.linux.dev>
Subject: Re: [PATCH V7 08/12] perf tools: Parse aux-action
Message-ID: <202406022020.WJ2gdPJF-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240531055731.12541-9-adrian.hunter@intel.com>
X-ClientProxiedBy: SG2PR01CA0163.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::19) To SA1PR11MB8393.namprd11.prod.outlook.com
 (2603:10b6:806:373::21)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8393:EE_|DS0PR11MB6544:EE_
X-MS-Office365-Filtering-Correlation-Id: e55d9e72-df1c-4a3b-9ec7-08dc8439a644
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lCa/YQnNU6v8YeZe/r65ONubP1Dq3I3mU7AE/p4bkInJ4PWtXNZNHFSUQMTf?=
 =?us-ascii?Q?lxTwmpfbqnKgKPgYipoNFjZtWyl9TiyZUGcvUpxZiLQn/Q5EIfbbjN2vw3sr?=
 =?us-ascii?Q?Oz44uoFNLFFb7RJsbPj5lzadHKPBCrXXndZUUQr4lolN8L04aekoH92h0HWR?=
 =?us-ascii?Q?zzpVFIjWhoKAD75OQguLHhEBC4VNhGKENABEUXiIX80400gGA3q6vAREkYRd?=
 =?us-ascii?Q?9u1MCNEuip+oJwrbWjclSnvXd0sjxL7R+QbH/yQXJHk9eTI0OvCoPu9Z9O1q?=
 =?us-ascii?Q?orubSKxAAt3+Sey6LtgbyNRbNYKdAV/1M3I2utNcoeeWIo2FU9+bYfrS6lPJ?=
 =?us-ascii?Q?PYl2ds5MOrXE4aWv2jdNm7Ozwk4s9MQWFW5DjZN4WiRvZIArZ0qbbPDX+Yyu?=
 =?us-ascii?Q?e+ZOyL4uMdPzu2m5SG5E1Nyl8waDGBKZAztluAeSd81EIYXL4AgtoWcHk7f5?=
 =?us-ascii?Q?oOGOKobaaFB9fR6I6uEv9ELXW6nL4QA1T1/wM0+wqCSR2SXvHerJ19ZkUfJ9?=
 =?us-ascii?Q?D2bLkl5N5P+Sk9+IRLeNvnGNNDXu8rrze6j1keHRZIyxXSjOv29x8PtSKvCE?=
 =?us-ascii?Q?gsiiLNX4eA1bLFZe+y0V2I4nG6HaQWAssLYMlN+0MsvY5iqlMfyqqGkgEIoe?=
 =?us-ascii?Q?vpvOx3khQuVbKb4JI4hixEHLhZBlH5DWx9KpXhPeETPLvyA6DPSUrmLrc77F?=
 =?us-ascii?Q?rtE4OBs2hWoq38ATk+iDZoO1Srj1dvlZfhJIM3mSZeUVpm4CC0sXHnNAM5FD?=
 =?us-ascii?Q?8ugBzl8MWhfTObqSIuTpW1oYYQVfnz2wNceS9zjco3fN+j8wtGSTPVfBX+lj?=
 =?us-ascii?Q?wk9ENg6qR2qt38nOxLsdW8jEbC5+L/i9PCMLb3IxItp8bfV5esA/cR/mucRG?=
 =?us-ascii?Q?PEoOkX39A2XdtOLvPfMkSAIioBdvPgjp86NOC2Xes4R/u7lzFCwFiapeGDED?=
 =?us-ascii?Q?/HO1lWmhAduOLx2nmVozwsrNDVZ0FsUoNDu1x8baHn4N0cHUuZL6GSOuqtxB?=
 =?us-ascii?Q?DNkAzgRSidsVo+4luPZPNFopyf1SUFG2JAm0taoZYDt+UaaVT9wcsd7ev2fM?=
 =?us-ascii?Q?kGNXrDPMySp/I5uCzMBfb7BzziaGSlXuOQP5pk+KoNyyS6e7JrkyHnQ0oPFx?=
 =?us-ascii?Q?FtLQuUrNYG+Krq4HoKdvC3rNZ448/GT1BZPgVa9mIOmP//zbsIQbf5xIQyx6?=
 =?us-ascii?Q?JnfwvblIv3BSiVWJiJQbaSNKnFcE2UTJKORVeO3UisUP77jB8hdxDoumqPI?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8393.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4t5ZDNfSTbwl822hbKUU5Vv0GZzAvQQ1USbA/jUuC8Z5clEyPjS+bnSE6NDO?=
 =?us-ascii?Q?Iz59lYpRTeQcf9XEk3JqEhlQRTJOmjw5ZwLQ2wdYyyfWjyIkRm+1aZG3O0tn?=
 =?us-ascii?Q?+ptYIKZwjsle1uD7KdkO3OfovZO8tgBY8TyOC/c5SOdkH/AqjYcKEzGE8SW6?=
 =?us-ascii?Q?5FYHh/aIEWfTMUf569yicO6MT9VcQVKgEgy0qpGOEdRijqHo+BvBhnaMADB4?=
 =?us-ascii?Q?O9aKye4pIiClespwqc1Jg0EhSPq1QYHi7NNH4ujtOHeU/OFsntI12B1EbH1w?=
 =?us-ascii?Q?mzuCPvydzezgKoHAMgTaiBakQm/WUfMGSDgBa8RxxPpAY5lFzAulq/rp0R9V?=
 =?us-ascii?Q?3L/atZZqqykfLN6zcgNgxb8nDgslqo9xc1Sc8Gxu1+V8XqngNQ/5SOWA3u6g?=
 =?us-ascii?Q?awMaMpWGT/lZ+UHpF/TIgagt6z9Xvb63CnQxP5L9zWKhvkJYS8rSLJJye84j?=
 =?us-ascii?Q?rfv/wBsUSK98aqhvCwT0X59Lvhwg0PkyYetVbr5M0uEj0vtRhiIfIH5tRJlK?=
 =?us-ascii?Q?PY1k0OSZTd3fYdKdbonDA4rTiQju5+T2HOQt4qhQO2OmpwtsS0FerNAyurVH?=
 =?us-ascii?Q?y1U+rDHokl+tJ0mdEBpIjEXE+gSXXAinPhlbDH1kxUNrZxN43dv7cFSogO/C?=
 =?us-ascii?Q?6PClBJXUrIEwlcmmJNylqgTnSF8rYT0ku5DpMVHBUd8ucaOmIM1pnpM6t6O+?=
 =?us-ascii?Q?aDYMkE24+L8samepg0ru5KqsI/mBy59cMsPlVJDD0U1/xaJZ0Qjua9ElrTiP?=
 =?us-ascii?Q?VoIrmSFE16LqzXiSCvXqk4h1gOocUQvzqxmaV4aIkT8FmeVu5JnqLDyiXBz+?=
 =?us-ascii?Q?ARvhMzFbJjcfXPe0lYK2Fxo649U35ULdm63T3IC5+PhTYXwlyxxHuDPYirqL?=
 =?us-ascii?Q?kF6OT9X/bYU5AH97f+pqxzqG+RK1/tbsJOly6wSCANr/SdpQiiswDGgKGCZ1?=
 =?us-ascii?Q?qEoJs+FjCjRPUrRG9PmuLO2lA5tSYa0mp9j2JQcDZBhL1DQ4BuhrZ3FONOUz?=
 =?us-ascii?Q?byuCVlWp9ZTqux0JmZs/QiCimFQfS0rp6+qDYeYFCTUpx18CvMbWwiv3Qyqk?=
 =?us-ascii?Q?bZAzMB1QuYeYJrvhbDvyA0XP/LBM+vLHYKgfiMjKPRivHNFB3ngByj7T4qdB?=
 =?us-ascii?Q?ZIMHb5nI6cmXDhiG5L+ocgu5cMUu8AHq8XgQAVLMtxpMJB0ORPk2HKKqNukZ?=
 =?us-ascii?Q?3A7fy4N1f0jSfMa6lLPLTCvQD285+AOayT7sM6waG4EzOXJftxfvN7bJXsQg?=
 =?us-ascii?Q?dmyewnDcxxV+Za08Rn38m2N16fjQhZuJ/P0zL6jxW2pYiad/YI9jU4WKyCXp?=
 =?us-ascii?Q?bFNPWf9TSynKB4+Iqs4wt4dopUz4aInjHN894YXHnQFe2WPkeNEOU0lQYnFJ?=
 =?us-ascii?Q?1FwwnuMIlfyXlRxVuCWR8cSY/dHWITxcakQ9HWD+UWnyiPE+orw3mfjqVp7s?=
 =?us-ascii?Q?EenHsmYB6WEHTF77+H7i+fJuNr9YUsmLF75V4BIKRet+2lV1wlustfkQNWv9?=
 =?us-ascii?Q?Ew5It5vAlClRhxTC9tatwMKDqNaQtg7hYlTa9RZSzj2ASeRMJ9j9Y9/zkB1p?=
 =?us-ascii?Q?lEAfKlyxX6AFUvD+R1fYeWO/s564OgM+LE2yZg1M?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e55d9e72-df1c-4a3b-9ec7-08dc8439a644
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8393.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 01:57:11.8499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WI9G+LmFW+93ors7Rfls5wrWG+n4KFJdMO5pDTsHJCxigI8EZLPWlTcGsBWQCy4KN/rH6nE+s7HDqjiFSbPzKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6544
X-OriginatorOrg: intel.com

Hi Adrian,

kernel test robot noticed the following build errors:

[auto build test ERROR on perf-tools-next/perf-tools-next]
[also build test ERROR on perf-tools/perf-tools linus/master v6.10-rc1 next-20240531]
[cannot apply to tip/perf/core acme/perf/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Adrian-Hunter/perf-core-Add-aux_pause-aux_resume-aux_start_paused/20240531-140321
base:   https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
patch link:    https://lore.kernel.org/r/20240531055731.12541-9-adrian.hunter%40intel.com
patch subject: [PATCH V7 08/12] perf tools: Parse aux-action
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce: cd tools/perf; make LLVM=1

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202406022020.WJ2gdPJF-lkp@intel.com/

All errors (new ones prefixed by >>):

>> util/auxtrace.c:821:7: error: missing field 'aux_action' initializer [-Werror,-Wmissing-field-initializers]
     821 |         {NULL},
         |              ^
   1 error generated.
   make[7]: *** [tools/build/Makefile.build:106: tools/perf/util/auxtrace.o] Error 1
   make[7]: *** Waiting for unfinished jobs....
   make[6]: *** [tools/build/Makefile.build:158: util] Error 2
   make[5]: *** [Makefile.perf:727: tools/perf/perf-in.o] Error 2
   make[5]: *** Waiting for unfinished jobs....
   make[4]: *** [Makefile.perf:264: sub-make] Error 2
   make[3]: *** [Makefile:70: all] Error 2

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

