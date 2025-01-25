Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F285B1CAA4;
	Sat, 25 Jan 2025 14:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737816674; cv=fail; b=XTQNaB9WHnxyhiros6Pj/TSYIWVDw6lHcB1SHtaZMFthzNtsfbKXj32yeTPREI3ONJOYMpNldQB6r4EZZAqkLrwjggi3gZ2uiPBlQDuEc79jCDZ8SnEQukCBg2BwSLJ1kPZvtaPKUcqp+z1IjkYJjK5s/jaKloJToXWrpbbYjsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737816674; c=relaxed/simple;
	bh=JC+UkClSGMFC/bTMABLBMVSTzL2VH3clOJJ4Tx7+5cg=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=d3CgLOoEgm5SYhAJcRVxeBQ563RUdzO82wBOtcj5ugWDZgZ+9J7gtwAbxYyGsKk/N4r1aX7hbvKizzdl0OWnyfBcgCYYED5VYuAbFemxcZzm/O44TSWlVorNrpGUcffXPet5IofrvEgzWsH7yEDtt038ewcGOBjH5lW7SONjRjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MucrXFOu; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MucrXFOu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737816673; x=1769352673;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JC+UkClSGMFC/bTMABLBMVSTzL2VH3clOJJ4Tx7+5cg=;
  b=MucrXFOuEMS+u/1YwmG1ES6WFa7eD95D2Fv4xpdjZSfW1DK5qf+t2rmG
   Y4SYLWWgAGcimudMeKVD1JnhJAsK2A7JHzCw5uFOiR2+ky6W4KcXVmDZO
   Sy5Qq2mrNz1gDm91uGQ7sr+Cc30nkSIxB9jWPMC09icuUSpJesV/97dhZ
   mBRwD7c0CpkVJEGKM6KB0n7Q0v0C/wlgpjFho4a4cM74rcTmmrth752y6
   3SxTw7kGI9KcoHOw1/+LNrmAdPq/6TrzMr/AHdaENp+uy7zBUAZ2Zq4AX
   I6P7ySUjZaD7ZFIOooEDTRlj0Y5CiOUPySpTQqCoSaAp893Sy38/z8WQv
   w==;
X-CSE-ConnectionGUID: S+aCXpt8Sc2hS2fUd93W+g==
X-CSE-MsgGUID: OiK61OYGRkiYsswjqeMiYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11326"; a="41998935"
X-IronPort-AV: E=Sophos;i="6.13,234,1732608000"; 
   d="scan'208";a="41998935"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2025 06:51:12 -0800
X-CSE-ConnectionGUID: c6n667evRfmTOzDtIlxbcA==
X-CSE-MsgGUID: PAX+r542R7qO8Dm3kG3aoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,234,1732608000"; 
   d="scan'208";a="108613141"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jan 2025 06:51:11 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sat, 25 Jan 2025 06:51:05 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Sat, 25 Jan 2025 06:51:05 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sat, 25 Jan 2025 06:51:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJXLmrMwCaREKTmpds0JswWbvkEOgsP+sSkaQzl5OwBWsyxWuo7eEpPeV3bQafjzpv7UA6KyMHHFd6zsjSnjfj7goj6KnWyUwOyrVRbk3x5Me38qYhPnHpCnRcHiBs4vidGGM7ZlH5wr34NsYRfXeBE87UJZheHk971cOZw/O/sBRpgWj0o7fE60YFVRyfWWzCJY0tCWLI5wRSHQH13UM9Ruc+5yl+vBdlTNQ8qfXXMY/9pq9wQch8uUsYs3foDgzMbPkRg6W7pXqVK1AzjkbR/NxDYdzE0EBuuCQ1mUSS/3kJuQydrN6pryMxVuivbzC0ojOhYUjnL6aI+yjVyyVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRkIWqd754qPX1E199stJt3RJ2su+krxU2fhdAxaT6o=;
 b=SMlHlXOWgVM5Yj1xJjQANzCKC4/d0hEXXSjYKVNra0nqyB/Ce1lOidstQHHvnmkVbDg/dD2tmzitc0AYzen8zCY/vKIjP9LdWW4xf9Nblw+dVaF17xVmKKm76l+YmUzZv060e4X1qR+40tgzcCuz3K0ZJZnz10V8jtCWOWi8htIG/0IqZbq0AOXD58R8Os2i8oXUA3ciaj1A07q14FYcGAu9YCli3nlADplv9OkDVGs5d0fTGF6d7p2xJrnCz0TasqPNGBTvV+VNQ/0BzS2PMMX11drgF1BXOgxbfTBxdOYuz+TsBQ0H56C4UAs8xEcaVeql3i90rcEXKFedR+waLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CYYPR11MB8388.namprd11.prod.outlook.com (2603:10b6:930:c2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.20; Sat, 25 Jan
 2025 14:51:01 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8377.009; Sat, 25 Jan 2025
 14:51:01 +0000
Date: Sat, 25 Jan 2025 22:50:53 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [peterz-queue:perf/pmu-unregister] [perf] 6eab6eb61b:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <202501252228.adc2a908-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SGXP274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::29)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CYYPR11MB8388:EE_
X-MS-Office365-Filtering-Correlation-Id: 90cf62b6-f36d-4a4e-05a2-08dd3d4faf63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bNN6TB9k5K0scMpH95H/6SHUjobDAa8RwIroUPgvS3X2YUOddNlkcaLMzgg+?=
 =?us-ascii?Q?gd6l4PXsv+y8jz053lKGXtsLNkuk5XHBJaAkb5E6rRKh/TQjV8GWr6z+XYPP?=
 =?us-ascii?Q?vdgrh3cshvLTKTA05IlXYGRV7YMZwAVC3vitspFJO8/v1P41mSkr7QwYXT9p?=
 =?us-ascii?Q?JZS7DIAtWCwYswcM5w7fitT6lWx7IqtYJIE4NCVF0GM42DCGBah1F/pydH+c?=
 =?us-ascii?Q?w/zb15/W4bNHUzkADujrUDOYPF2ItwC6RJfsyqsokbf0jGM1GdsEQEb78ScU?=
 =?us-ascii?Q?hr0sUaOdY9FajQvaZj2jF3YOF+MISP4F5jvhurvl0B1BqKFOLHRQW+Pkro+M?=
 =?us-ascii?Q?mI5SfvXroL/0a5AvLmIRxMnGE6TbZCDkTCnl+fk4C6L7HZt/8i1V8v5qr9/3?=
 =?us-ascii?Q?XFm1EHE0sis4dzim9thW6SUA8UpKwRAnW5qlgqwY+rUoRdtBZ+WoSw+x0yo6?=
 =?us-ascii?Q?aEDl+N7i3tn4x5auKCshD10js9mPPgahtPSvN/v7/RX5qMrk7bd9QLkqf2+Y?=
 =?us-ascii?Q?TTt/8TinQy4nKfdbLrZp+q29k+Zm4j2zGelck10FzzbsOxNQlG4DMn+dgx3T?=
 =?us-ascii?Q?vGwkUi6qKDmAYSXVJreCIWNIn/toPQ8PKAgDBUoR6e12hw4e6r/vrYPW9fnw?=
 =?us-ascii?Q?e6mHKPy5Ch3zAmGuhWkqQMi2f4+XucG8JG0OJta+CCY1UYqtfuaddD98fYgW?=
 =?us-ascii?Q?6d/uQbN0AeIUL0/u/XZNePxIxYyjwcYS84r4rK7or592c9OxqAiqhE+biJ98?=
 =?us-ascii?Q?nqr/KzoXBrJiI1Jrcak6Ineq0Xec9HVHPrVu7h9wZAaYHAuZ8uYmP/f2lEVA?=
 =?us-ascii?Q?9thYKYEvv9nuMtlWQD7CdOTdcY4H10T2BfMVwR3cL7H3u5hj6utXIlvIql5n?=
 =?us-ascii?Q?INrfLcKWnNlCtHEAV07C2VVdwADdeDss5dVeXR9khwtigYQhX2aqnmN8BokR?=
 =?us-ascii?Q?0zH+EZ26DftpAMYRrxRkeAisFFsBSHeD0V1gqkgoWsfBOO6DTSAQUqEcIDHW?=
 =?us-ascii?Q?Hnqr9iy1ysEHMIGsl0hJt1+xOs+SCEubsHtN1xpTHNOASQlPfJrs3uisZqWe?=
 =?us-ascii?Q?EtN6mF+Wu/TSEUAWELrBHgSOTnADyXaYiBB9JGKOju8tPFWoK27EAIp66AD2?=
 =?us-ascii?Q?py55ej4xqJPdBX813sQPfJYY2gRYLfD2XI4V0J+cVmhquJ9EwoVcRH2ZVrVE?=
 =?us-ascii?Q?YyvSEUZdwA00vDUfHBZWzVPHdFmnM1z0x1wBgSoTYMVLMGO8/sf1BcAFZuZa?=
 =?us-ascii?Q?r7uTMgVhhYBMk3QgAZk59kaAyyMaxu8aI5twJJDt1u8W4+JQj7VuY+fn0LJ7?=
 =?us-ascii?Q?KRw079fQ2/tXtYI+NnJAQv4FFU1XA3bX7P24dyuDR7zCWg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lh6Y2PlPCyeHhkrZNbILdwFYvP0cgCQR7HiAvZjvUyFD8rRa6jcda722wA+N?=
 =?us-ascii?Q?B2hVzszEqGVjclrakDXys6eKUReALNeCd/7G3p2rLEXTqAj4+APQOiVjFIZj?=
 =?us-ascii?Q?H4FKpoEQSNP0IikF5dgUm90E8UVbpS4vEv/O2241AIniav/e6xwD4eV+4mSL?=
 =?us-ascii?Q?xKzw+MEfH+4CketTPN9TGclkpv00Vp9ddcewWZxp7ksJbfCJ1LzVerc5UFfK?=
 =?us-ascii?Q?ew7C4PnDXM1JXR4IllVeWBs54t0juMWwwUd21iQaaVgyJHJBYsDNhk3zDUx/?=
 =?us-ascii?Q?orJVNviTynpEq83jmCwLFUGIizlaFw+5qHLr1Y6V2XiPWcnB6mDqW6PAzIhT?=
 =?us-ascii?Q?iq+ulMrJxlEep9O56cFZRxbrPWDFBBKnwsy2oAdZYdr8PBoI2vufJ8C1Nyk/?=
 =?us-ascii?Q?1Y/UIl+eXNfzp6vhYaFp1dEECkf2GOLjrzKkck4/utEzznsizqfqcW+12oIx?=
 =?us-ascii?Q?7KJiLIwRle7+5CJfj4BLSXEDSZpMNzfZEBrJ6v9F1QaG0kVGRNl+EEXGRjAW?=
 =?us-ascii?Q?g92/zsIrEly9uhsYnfyPnHY4K14K52SloUYwbPVxmXzDvarvRnSQGeGMxXuM?=
 =?us-ascii?Q?Paj8IC62D+8w4lPMdWvxWLCZo2moGUGqSBJavjx6loJD0cqbwJ8fTuAdzMAX?=
 =?us-ascii?Q?F/AQ/j7TvboBY+U/LLn1MrEyrsh2qk/y0K1eA0GL16i/DLRHHDKOfxx4XCP/?=
 =?us-ascii?Q?EeuAljlwmu9Tx1OP4EplNHMBG25a3wRCUGIq/op7ts10hoD5KPDXjPVNHhgA?=
 =?us-ascii?Q?LTJI1cTHi4M23jBwQDBYGh5e1ZB67nmZtZpfy3w5b/oPhAUhu9LgZFnpC/Tk?=
 =?us-ascii?Q?n7WSEUERPMsB0cOPfRwqkGm9OM+WoBGxJzOaIsWy+ArVsCJyFyfdbUUnTDtN?=
 =?us-ascii?Q?+PqoQrAGB96SiWo7ylHCEZtRRrXy2qJ1UvRSqBS8MKGKBvITNZJOU9kvqSsh?=
 =?us-ascii?Q?ZjhL2MXy5sfK++RwkASY6Ei7PIdA9M3rTna+GdLi0wsHxDtJXL5zktM38wCk?=
 =?us-ascii?Q?66sHZ0yAFggzp6FQg3Eq1gS+9BE5PfIYrxJONpXLzzg51BwPO21Dg5PRWd8t?=
 =?us-ascii?Q?nAXBvnpERWGOzNbDrIde1vtcujydf+Jf0YdB1MTzceqhRlQZSqY96/TJbXdP?=
 =?us-ascii?Q?ohNyYKyRT7b39Ed8VyfRKhnw0EPeH7e3+d5gSuFkvRGAMvRVqARUKa9OiNLs?=
 =?us-ascii?Q?BMWIrJNU9K0YWS4SFjIg0jGaZgXrJdBrGrSewClzfFdvkX/IxutHkeFe9rjL?=
 =?us-ascii?Q?Q+qvqM5lvgsbq9Eea7fqxEvcnMFAgwiL42APbGC7U2JySnkIvRfknN4rPgCW?=
 =?us-ascii?Q?OYQFwhg+RP9hLIepyC5vpL9nWHi/GyVYYzS93v8OLr8hf5HomM95ZMI7Yv60?=
 =?us-ascii?Q?inl9UqqiLY5cNLzfE72v1bERX8kRyhrAv/N2RFdsYTFAaVwFTRjED/TPREBv?=
 =?us-ascii?Q?yrgNoQuBKlMPZCMLG1PSLDA2jbjVIacqZoYy2blQuqdD4CN1KTfrRl4ebyV0?=
 =?us-ascii?Q?d9pmcbWT0FvT5U8JcMmbTNcMk2Dx6DxgyHjPBMFnBwiGhou1sZ3AHeT91POz?=
 =?us-ascii?Q?5AYfazM/+Ii9VTO+O5XDYzjUmh49tq0xrCEFK9b+9qIAXkG0MQ5z73IxTlMA?=
 =?us-ascii?Q?5A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 90cf62b6-f36d-4a4e-05a2-08dd3d4faf63
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2025 14:51:01.3777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YD5Iu7mCFgWreO26FxtOg+2qRy7eTKlcH4iOiF+7nJQGyucftQ4mAyGFcrxsXUVYwiEiS6PeC6Te0guxrusLxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8388
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:

commit: 6eab6eb61b0cef86bc2e35a427458eb9e584d3e0 ("perf: Remove retry loop from perf_mmap()")
https://git.kernel.org/cgit/linux/kernel/git/peterz/queue.git perf/pmu-unregister

in testcase: trinity
version: 
with following parameters:

	runtime: 300s
	group: group-04
	nr_groups: 5



config: i386-randconfig-016-20250123
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+---------------------------------------------+------------+------------+
|                                             | d06f4f3d99 | 6eab6eb61b |
+---------------------------------------------+------------+------------+
| boot_successes                              | 12         | 0          |
| boot_failures                               | 0          | 12         |
| BUG:kernel_NULL_pointer_dereference,address | 0          | 12         |
| Oops:Oops:#[##]                             | 0          | 12         |
| EIP:perf_mmap_to_page                       | 0          | 12         |
| Kernel_panic-not_syncing:Fatal_exception    | 0          | 12         |
+---------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202501252228.adc2a908-lkp@intel.com


[   54.550060][ T3705] BUG: kernel NULL pointer dereference, address: 00000110
[   54.550634][ T3705] #PF: supervisor read access in kernel mode
[   54.551060][ T3705] #PF: error_code(0x0000) - not-present page
[   54.551482][ T3705] *pde = 00000000
[   54.551762][ T3705] Oops: Oops: 0000 [#1]
[   54.552057][ T3705] CPU: 0 UID: 65534 PID: 3705 Comm: trinity-c2 Not tainted 6.13.0-rc1-00058-g6eab6eb61b0c #1
[ 54.552785][ T3705] EIP: perf_mmap_to_page (kernel/events/ring_buffer.c:950) 
[ 54.553155][ T3705] Code: 00 b9 18 cf 8f cc ba 59 04 a3 cb e8 a9 4b f0 ff 8d 65 f4 89 d8 5b 5e 5f 5d c3 3e 8d 74 26 00 55 89 e5 57 56 89 c6 53 89 d3 51 <8b> 90 10 01 00 00 85 d2 74 46 8b 80 0c 01 00 00 8d 0c 10 39 d9 73
All code
========
   0:	00 b9 18 cf 8f cc    	add    %bh,-0x337030e8(%rcx)
   6:	ba 59 04 a3 cb       	mov    $0xcba30459,%edx
   b:	e8 a9 4b f0 ff       	call   0xfffffffffff04bb9
  10:	8d 65 f4             	lea    -0xc(%rbp),%esp
  13:	89 d8                	mov    %ebx,%eax
  15:	5b                   	pop    %rbx
  16:	5e                   	pop    %rsi
  17:	5f                   	pop    %rdi
  18:	5d                   	pop    %rbp
  19:	c3                   	ret
  1a:	3e 8d 74 26 00       	ds lea 0x0(%rsi,%riz,1),%esi
  1f:	55                   	push   %rbp
  20:	89 e5                	mov    %esp,%ebp
  22:	57                   	push   %rdi
  23:	56                   	push   %rsi
  24:	89 c6                	mov    %eax,%esi
  26:	53                   	push   %rbx
  27:	89 d3                	mov    %edx,%ebx
  29:	51                   	push   %rcx
  2a:*	8b 90 10 01 00 00    	mov    0x110(%rax),%edx		<-- trapping instruction
  30:	85 d2                	test   %edx,%edx
  32:	74 46                	je     0x7a
  34:	8b 80 0c 01 00 00    	mov    0x10c(%rax),%eax
  3a:	8d 0c 10             	lea    (%rax,%rdx,1),%ecx
  3d:	39 d9                	cmp    %ebx,%ecx
  3f:	73                   	.byte 0x73

Code starting with the faulting instruction
===========================================
   0:	8b 90 10 01 00 00    	mov    0x110(%rax),%edx
   6:	85 d2                	test   %edx,%edx
   8:	74 46                	je     0x50
   a:	8b 80 0c 01 00 00    	mov    0x10c(%rax),%eax
  10:	8d 0c 10             	lea    (%rax,%rdx,1),%ecx
  13:	39 d9                	cmp    %ebx,%ecx
  15:	73                   	.byte 0x73
[   54.554483][ T3705] EAX: 00000000 EBX: 00000000 ECX: 00000001 EDX: 00000000
[   54.554938][ T3705] ESI: 00000000 EDI: b4cda000 EBP: c4d51be0 ESP: c4d51bd0
[   54.555416][ T3705] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068 EFLAGS: 00010286
[   54.555931][ T3705] CR0: 80050033 CR2: 00000110 CR3: 04f6c000 CR4: 00040690
[   54.556417][ T3705] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[   54.556930][ T3705] DR6: fffe0ff0 DR7: 00000400
[   54.557261][ T3705] Call Trace:
[ 54.557500][ T3705] ? show_regs (arch/x86/kernel/dumpstack.c:479 arch/x86/kernel/dumpstack.c:465) 
[ 54.557807][ T3705] ? __die_body (arch/x86/kernel/dumpstack.c:421) 
[ 54.558116][ T3705] ? __die (arch/x86/kernel/dumpstack.c:435) 
[ 54.558390][ T3705] ? page_fault_oops (arch/x86/mm/fault.c:710) 
[ 54.558732][ T3705] ? kernelmode_fixup_or_oops+0x55/0x5d 
[ 54.559212][ T3705] ? __bad_area_nosemaphore+0x31/0x17b 
[ 54.559683][ T3705] ? bad_area_nosemaphore (arch/x86/mm/fault.c:835) 
[ 54.560068][ T3705] ? do_user_addr_fault (arch/x86/mm/fault.c:1280 (discriminator 1)) 
[ 54.560428][ T3705] ? exc_page_fault (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:87 arch/x86/include/asm/irqflags.h:147 arch/x86/mm/fault.c:1489 arch/x86/mm/fault.c:1539) 
[ 54.560791][ T3705] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1494) 
[ 54.561249][ T3705] ? handle_exception (arch/x86/entry/entry_32.S:1048) 
[ 54.561627][ T3705] ? is_mmconf_reserved (arch/x86/pci/mmconfig-shared.c:485) 
[ 54.562006][ T3705] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1494) 
[ 54.562451][ T3705] ? perf_mmap_to_page (kernel/events/ring_buffer.c:950) 
[ 54.562804][ T3705] ? is_mmconf_reserved (arch/x86/pci/mmconfig-shared.c:485) 
[ 54.563168][ T3705] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1494) 
[ 54.563605][ T3705] ? perf_mmap_to_page (kernel/events/ring_buffer.c:950) 
[ 54.563961][ T3705] perf_mmap (kernel/events/core.c:6599 kernel/events/core.c:6842) 
[ 54.564268][ T3705] __mmap_new_vma (include/linux/fs.h:2183 mm/internal.h:124 mm/vma.c:2291 mm/vma.c:2355) 
[ 54.564613][ T3705] __mmap_region (mm/vma.c:2456) 
[ 54.564945][ T3705] mmap_region (mm/mmap.c:1350) 
[ 54.565255][ T3705] do_mmap (mm/mmap.c:497) 
[ 54.565556][ T3705] vm_mmap_pgoff (mm/util.c:580) 
[ 54.565878][ T3705] ksys_mmap_pgoff (mm/mmap.c:544) 
[ 54.566215][ T3705] ? local_clock_noinstr (kernel/sched/clock.c:301) 
[ 54.566596][ T3705] __ia32_sys_mmap_pgoff (mm/mmap.c:549) 
[ 54.566871][ T3705] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-016-20250123/./arch/x86/include/generated/asm/syscalls_32.h:193) 
[ 54.567101][ T3705] do_int80_syscall_32 (arch/x86/entry/common.c:165 arch/x86/entry/common.c:339) 
[ 54.567335][ T3705] ? tracer_hardirqs_off (kernel/trace/trace_irqsoff.c:620) 
[ 54.567571][ T3705] ? trace_hardirqs_off (kernel/trace/trace_preemptirq.c:80) 
[ 54.567807][ T3705] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4658) 
[ 54.568115][ T3705] ? syscall_exit_to_user_mode (kernel/entry/common.c:221) 
[ 54.568447][ T3705] ? do_int80_syscall_32 (arch/x86/entry/common.c:343) 
[ 54.568759][ T3705] ? __lock_release+0xb0/0x14a 
[ 54.569073][ T3705] ? find_ge_pid (include/linux/rcupdate.h:877) 
[ 54.569330][ T3705] ? tracer_hardirqs_off (kernel/trace/trace_irqsoff.c:620) 
[ 54.569618][ T3705] ? trace_hardirqs_off (kernel/trace/trace_preemptirq.c:80) 
[ 54.569925][ T3705] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4658) 
[ 54.570299][ T3705] ? syscall_exit_to_user_mode (kernel/entry/common.c:221) 
[ 54.570632][ T3705] ? do_int80_syscall_32 (arch/x86/entry/common.c:343) 
[ 54.570949][ T3705] ? syscall_exit_to_user_mode (kernel/entry/common.c:221) 
[ 54.571326][ T3705] ? do_int80_syscall_32 (arch/x86/entry/common.c:343) 
[ 54.571644][ T3705] ? do_int80_syscall_32 (arch/x86/entry/common.c:343) 
[ 54.571976][ T3705] ? common_interrupt (arch/x86/kernel/irq.c:278) 
[ 54.572295][ T3705] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[   54.572617][ T3705] EIP: 0x8097522
[ 54.572846][ T3705] Code: 89 c8 c3 90 8d 74 26 00 85 c0 c7 01 01 00 00 00 75 d8 a1 cc 3c ad 08 eb d1 66 90 66 90 66 90 66 90 66 90 66 90 66 90 90 cd 80 <c3> 8d b6 00 00 00 00 8d bc 27 00 00 00 00 8b 10 a3 f4 3c ad 08 85
All code
========
   0:	89 c8                	mov    %ecx,%eax
   2:	c3                   	ret
   3:	90                   	nop
   4:	8d 74 26 00          	lea    0x0(%rsi,%riz,1),%esi
   8:	85 c0                	test   %eax,%eax
   a:	c7 01 01 00 00 00    	movl   $0x1,(%rcx)
  10:	75 d8                	jne    0xffffffffffffffea
  12:	a1 cc 3c ad 08 eb d1 	movabs 0x9066d1eb08ad3ccc,%eax
  19:	66 90 
  1b:	66 90                	xchg   %ax,%ax
  1d:	66 90                	xchg   %ax,%ax
  1f:	66 90                	xchg   %ax,%ax
  21:	66 90                	xchg   %ax,%ax
  23:	66 90                	xchg   %ax,%ax
  25:	66 90                	xchg   %ax,%ax
  27:	90                   	nop
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  31:	8d bc 27 00 00 00 00 	lea    0x0(%rdi,%riz,1),%edi
  38:	8b 10                	mov    (%rax),%edx
  3a:	a3                   	.byte 0xa3
  3b:	f4                   	hlt
  3c:	3c ad                	cmp    $0xad,%al
  3e:	08                   	.byte 0x8
  3f:	85                   	.byte 0x85

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   7:	8d bc 27 00 00 00 00 	lea    0x0(%rdi,%riz,1),%edi
   e:	8b 10                	mov    (%rax),%edx
  10:	a3                   	.byte 0xa3
  11:	f4                   	hlt
  12:	3c ad                	cmp    $0xad,%al
  14:	08                   	.byte 0x8
  15:	85                   	.byte 0x85


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250125/202501252228.adc2a908-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

