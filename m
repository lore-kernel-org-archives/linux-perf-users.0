Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B067111A8;
	Mon, 18 Aug 2025 02:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755485499; cv=fail; b=EUpFkvGTT+Ng4N0Bcrjc+fV29MI+nGAKzOdD/2SAUxoqoqnQ/cIVc0SeI5R/woltpN13mkhuUHfiZUYk3SPS/fmjZVlFU2f20m88WHQUbbaRuSgm+CKzoa/937tWHiuCpASrSEm3RU8HI2vFrBfO1r/tHQH/IQ9WUbn8aDZkVqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755485499; c=relaxed/simple;
	bh=X1fcA0FSwkThteH6Cxgz4S4HJNgIYJjntUwPVwy3gzk=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=ZFD9xYdF8dhTRV7TT9Z3Ww4cznVuZVd2H5+FUBfIRjxNAzK4rppnt33dW7YnAj4TRpt0fwfDuOtTqWsPBLD76dCl+DMwMeYLEFMv5+EczUEqo/ac+/OdYYKgwgtdWFGZ2kddQ6ghk4COVSBgnFAO2W0fVfe/5q23gbPWaMXclQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tyy7lDhf; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tyy7lDhf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755485498; x=1787021498;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=X1fcA0FSwkThteH6Cxgz4S4HJNgIYJjntUwPVwy3gzk=;
  b=Tyy7lDhfBz6yT39ddJcYAZu6ceu60BwZERxbWLAJw1Zmv9IK8jLunIEw
   +4HYXiPNmMe/zc8F/tqyJiIUoVCgeQZ8OCG534N9zAp0XY9FogcZ/Bvyv
   vZuziyqe/TLVur5irhZ0hVZ4+JBocLnWyzeB/PU4r7aRnbRSqAp0Hg2bL
   8RxiNDAjBQQZA6qHHur1gbxxsgPAlk9fBrIFkOg/E+slE5A8puG3VDaxg
   m4Z+S8ZwA0bqMjE8yE5aFTYtzLrHo7DPvqwRQ7u3HApMftXx5LOxPXnLi
   tTQzAXNFsSaztwJPdubrhMZrRQma3urtiN/pleWFx2SQXzjZRI0Gmg3Hz
   A==;
X-CSE-ConnectionGUID: GvO/8OURQxuVJmDtCIX1WQ==
X-CSE-MsgGUID: dhTP3dSvSi26k2AxLzzw+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="68415402"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="68415402"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2025 19:51:37 -0700
X-CSE-ConnectionGUID: chJ7LwI3QaKISclWvusVGA==
X-CSE-MsgGUID: ErMFo2pnQ0KmDE4sHtityg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="171682970"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2025 19:51:37 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 17 Aug 2025 19:51:36 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 17 Aug 2025 19:51:36 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.88)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 17 Aug 2025 19:51:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r9KxlHqJ0xXWmIA7y/xz4INgSTLbpxavIPYJMnZ52fhndQrQcYmKmWIbFFSVbSlJXAGmjNHcLuu3I80n79GLZSvrgS8Nu6VDBhGUoGFG03DptW9ZkGRxbv7vTLcL3/3811zNNrYlVNQ6t/l1kFVzb43ZAEeUq/4OcSW8pvQbXzhaWl+ukPOpDTud8BAZD2fE63iZYmU38iBeWoatc1EOk2qGI8WFQ47f2C9Kt/x2qJdTeBXDFi75Ll8WWAb359dkQQcwZMb6MffC38+gMoAobBD6IcgY6r6rvH7a4xDaEV+rfLVy/CUcv4U2R3iPobUsp/kggg01D08YZs0M2hgFfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NkZmM6EZFS5Cnk1cspklEDiSai9gRK7JXz/bXWXGCYk=;
 b=dTiBR4lnN0XuTiJRO1LX4vEzsPj0rzaAFHEUNJ6w0KyhHqZo7VvvAdg0M4ZuMHUuHSLLNZKJqWLngxj75GJfw4laY3ojyIAh4ZSjnAC7rhDp0yYdapXVOqskrU/K6QfnEsRjq1Y9VBC7nT934bfrgTlBNLAYTe98OtZ1n+ahGfaUl/CsTPzJIVu3Ov3Ahy4k22dAocqvja9RZgHLSB4pqtNhAL5s6ji+2jmRQahDafOqSDYKWGZzZ3oNlLW6YJzjN/CKKq6rgxJckR9eMhn6CnbXV0bFRzZtpcBTylMoY9l1mY5DmZTntaUghasHtlPUtHIYLSZNQ7Thx9uXgNChzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ2PR11MB8401.namprd11.prod.outlook.com (2603:10b6:a03:539::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 02:51:34 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9031.021; Mon, 18 Aug 2025
 02:51:34 +0000
Date: Mon, 18 Aug 2025 10:51:25 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Ian Rogers <irogers@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [perf stat]  faebee18d7:
 perf-sanity-tests.perf_stat_CSV_output_linter.fail
Message-ID: <202508180436.51c7951a-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SGAP274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::23)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ2PR11MB8401:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cdd7b9e-b608-4f30-b234-08ddde022455
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KcnPc1VlykT8l1Ns4+YPLw12DyYZRnKVvufP6bYQ48zOJcqR73MtGWHeTD4S?=
 =?us-ascii?Q?toMmYy4/j0fWUof80ULT0D+ozmTCnpyWG78bBwjl1oFq31TW3nurr0MtvUlz?=
 =?us-ascii?Q?HOdR0yW8/wEagt3C2LsaX4MpeWZ4NHUO3pdSLGuMcky4CsBIMO4W5jEGaj/k?=
 =?us-ascii?Q?UDfq2vICm1gwPA7F9ADIAz2zh1QeDU8ltTEosz/o4gj61JIFWJhGpPGAen42?=
 =?us-ascii?Q?JzimC4Xy+EwZgbqyniLTUAHgfaZ2Eynz6d1wsSH+KVWj10ROueuYqxkqvSJw?=
 =?us-ascii?Q?/XgWrobgSxWMjvP34sM9/4zt9+6OL5kRRVbUKCKyHeCbGAJN5++7bB/dIq4Q?=
 =?us-ascii?Q?78QN/2WOjE9CaRb6iDOZJyDwZNY3vVHtL472zksiMA/WrOTDFdZ77VMFMR0l?=
 =?us-ascii?Q?QJVcE31B5FkvlrOXy/DmlnoHQtKgcHZZUQ21S4YoBVonZuLm5wOH9G9yc+B4?=
 =?us-ascii?Q?hbQ+xA6jPV9He5Pu9SxcoGIu8mLpWN8NcYEunFUwZjlev2of//rhqiC8Kg/Z?=
 =?us-ascii?Q?9huG3IPNvQBPHa2qf9oQ3zcl9h7Jt3/0UXknuzeVzzKB0ZZY135B0vzf3lR1?=
 =?us-ascii?Q?3T6031iu2tw55FBKnv1cUSvBUbdXJIbvpXO0Sd45ldzr+9poWaDaEt5/sJNk?=
 =?us-ascii?Q?LYpekGAOMGAgYiCjRM45wb5KRYZXVFZA0OEEXB5/dxy2/fim77Makgcf5L5F?=
 =?us-ascii?Q?5mwKQZPRPSZlo7va+SpjdsxdxBzoRznQuFd2G0ou4nORac+t5TO/lZe+Tirp?=
 =?us-ascii?Q?uzpwkDp3jFddYLuWIXYDsxH4mPiGOM0AIL0U698h7VQCFqaF9+Yo8GDzMcUQ?=
 =?us-ascii?Q?Mlpsk7iNqaxWNSCoM74ZHTkTWBEetw0agbFiDptu7LOsRgXmWJbJGBgP8iT0?=
 =?us-ascii?Q?6qLt5nVuVKuJNcKRGMuOfGVpkrkVc9iqxJocGoloA/DGpKptvp9eFZt+91yu?=
 =?us-ascii?Q?dmRSd+5tdVJWWpoULZsAvfQ47aamFgrNc2Ng8ecDwYI3yMGzTxXIhJgKAaBs?=
 =?us-ascii?Q?VcduNF0QAF8Sux+7MF+InyDxP2QfxDM3by3V5pkMfdLt+9mm6dYoQhldtY4Y?=
 =?us-ascii?Q?KcIqCVqL9KWzdkQdy4z2dpk2jeP3sbZZ+R4cTJVPtX1GTATOlgoC63KRMjzo?=
 =?us-ascii?Q?0VDJPUmIylUZ7jFVHA85GOhTLUciLIjFv1iAlgNShFJuJ86wEFcQ/shKhci8?=
 =?us-ascii?Q?+uyjUCncvELJIpcVwvcDDLdaIQIninAJGP7Q0nrVYKv1r09PpguBFwZ5dedr?=
 =?us-ascii?Q?Pbg3O7Xf1mQt6H8XJfb1MaYgV5FwWuAA050ABc3o5Qv43wHdJS7r1VSa4bTt?=
 =?us-ascii?Q?oIdBl4bqFf2YtN3XumWMqqzGttt9TpYT3YHJnzohbgGKEC5t2I3CMHQeghsz?=
 =?us-ascii?Q?414b2B1Ihe8Mj0ooQ+75DN0b2HCY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cWktxmVsAr6AbA7GSdvfP8uvbfJbxHqobQ+TDR/cqMdhMqcBFgStuyqfp5++?=
 =?us-ascii?Q?XJy+3HG/z9FH8R38quMWncAVuQV3wPNjMPTzT09lN0Km9/aHxX5F+oa7Zs2s?=
 =?us-ascii?Q?f/twu4s4akNk7W9MOTYZcoh5jOxrSLkfpTWfAqQdsPQp8nt//ne9wTerpLjJ?=
 =?us-ascii?Q?dpQMECDv9T3mXKlOBKd8mG7Ff+XZzxZxdfJUmQCALjhAidDagY1Kdlge2VZQ?=
 =?us-ascii?Q?LpjX7Cbg3gAjCRxUu9Xf9cH56mMdkkQ9CYhA3Uegk6taPQ+6hScbaDtNG+RJ?=
 =?us-ascii?Q?s6WNa4Y6mpvhEdgbJw7yHu4YLFbDNSsoWttYSTnTL8S4AVPEEZYBjL+XODL0?=
 =?us-ascii?Q?R7zU+7NeW2QYZA9rkC6bJEykDQlICa4VTSHZqPu+Jgj6zWffxLYJ2nxsfeKT?=
 =?us-ascii?Q?b4GxceTOuuCwCkfnZl4EESjUYFsWGD5NARRBuroeC85jUR/kLtRMNKzrIXDC?=
 =?us-ascii?Q?ndHmr+YJvCSlE0JFyYE1zq425wwdG9DP+EqeAejnOUSURDY9x7FwihbxQSTv?=
 =?us-ascii?Q?5X6DYMl2/IVLwDPIL/4yh3oaCdY4sILGeuQoNG/z1tW8JZxABc9uuJeBC0LM?=
 =?us-ascii?Q?4yDmlG8UuDFcTi4uclyiy/VWwoxlFwHQw5oDVsDQIURSxiA9RXmXETGaDY2I?=
 =?us-ascii?Q?ikW8fFGZa71KiSBU3feHCLmawYd73bsWYHpI0CIArJdfp62g6aBBkrHfb29F?=
 =?us-ascii?Q?Erpb1pvQSRhGFy+8ePNecgFHWLoFBfpgveNpooJBKLle2WuWa4jldLArXGyv?=
 =?us-ascii?Q?LnnZJZk2H6PRMbuXk+bbrf0jVYAoCiPsKGurh0uKsepkkvoZI9O9a9UBKYm4?=
 =?us-ascii?Q?BMQg42QbjM3ezGF/h23QeXf9nezkzbn6Y+AYtDUFxrUSrbJEe7/kONA6W9B+?=
 =?us-ascii?Q?N9wtWrbws1xepE3RHd8S1YHsNcXSIuBFvnABQ2m/1+uWl5dI8kI4crT+/fel?=
 =?us-ascii?Q?klreYUNYE9hwogqXGqoa+tfutBA+HQh/8VC6B5WunB0LSCA6N2uEe8Jy1d4p?=
 =?us-ascii?Q?bPQIahaZghLFQ6NRcQKCWjDNK0M5M1h8Gzy62tMGaU+W9hY7A8E/M6rVyXd4?=
 =?us-ascii?Q?IkUT0ij94mKNfypiU3B9YjGaFyPrxvCVgOZxQOPZV7QxdkFyYsOK7RtgKqB7?=
 =?us-ascii?Q?0RFoVEk7v3iaEZs1kjDg4UW6LVFlahSJJtaNFjvfn99KQdsGtNUmjcESMS3q?=
 =?us-ascii?Q?ZhDXSfqYTsvRyIud0A8iWWwNca37njAkCQWo88Yi8QWwmxDaIcOCkdLdCQLN?=
 =?us-ascii?Q?J/VTY68f8PUDz2xkmTkZccgvNwRAl37dXcMUsq5Kt4tUMw6fDu0GM7YXhCmm?=
 =?us-ascii?Q?srpvqG/4kLWKQmvAA0plQmAA6z/E2jQNaN6GVYTiq4spGTUj+MCtqSRA2c1m?=
 =?us-ascii?Q?dLajzNx/vG53LSh1tbOIVCFJvzS4TaV7A9s+9CPm3V0XyQoCaZiDZerFz0Ir?=
 =?us-ascii?Q?qh/t4ryzeO0AxoSenqqONZ0OnlduDgJ1vChCTx0FDca1yG4uSrfw8JnHzSgs?=
 =?us-ascii?Q?TPArP9coiBNP8sHD81doLlJoVsynv3yJs12BiBHy+2w8nfVnhvL7JhIPFxMi?=
 =?us-ascii?Q?wU7gmV6XkfeV3h6RU0S0xLdxQh/hWU5mTX9Go/XGzUSGwTBQK6kk91JYcWVx?=
 =?us-ascii?Q?EA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cdd7b9e-b608-4f30-b234-08ddde022455
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 02:51:34.0320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pKjoDY1y723ZWJvh5PI2dnG9F6j9cVsLTT9b9/0UC8G0+r810sVL0Tn/hKT4CYkRDnIVg/+YpKKSmRcZFHXxjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8401
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "perf-sanity-tests.perf_stat_CSV_output_linter.fail" on:

commit: faebee18d720d9e209946ece3e468c06cf13f5ec ("perf stat: Move metric list from config to evlist")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on      linus/master d0efc9e4276cda07c2f76652d240b165c30b05b8]
[test failed on linux-next/master 1357b2649c026b51353c84ddd32bc963e8999603]

in testcase: perf-sanity-tests
version: 
with following parameters:

	perf_compiler: clang
	group: group-01


config: x86_64-rhel-9.4-bpf
compiler: gcc-12
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480+ (Sapphire Rapids) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202508180436.51c7951a-lkp@intel.com



2025-07-29 17:16:45 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-faebee18d720d9e209946ece3e468c06cf13f5ec/tools/perf/perf test 94 -v
 94: perf stat CSV output linter                                     : Running (1 active)
--- start ---
test child forked, pid 13116
Checking CSV output: no args wrong number of fields. expected 6 in @1269590@100.00@10.6@%  tma_backend_bound
---- end(-1) ----
 94: perf stat CSV output linter                                     : FAILED!



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250818/202508180436.51c7951a-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

