Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F2A207A18;
	Sat, 25 Jan 2025 13:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737811659; cv=fail; b=hAOFzJCoLRc2yGHQF2fgzcYJe8DF6uTQzJ8J3CqmaAyEO7NLytnvoIGffCuI6BJaa2lrgyzWkBZY1QnwLUdpCwlWTRLBNU501V76Han4+pxRY7/TTY5xKJ9o6ewaHWgbh6hGSn7V6TLs2ru2Z3Up7DFV582oOarBlXs85i4gvhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737811659; c=relaxed/simple;
	bh=Zn8wVdggEwjJZQ9f5DbloJCRM0qtInQj0d+jInRYTmA=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=GnkP/WHlkodSqypdqk8bFZ+Hm42iT9wzqGOqoTUiNXO4QvyfgmKrC4k0SWBEFCnvAVgZej5uVqIBX0ZQumeOZgyL2deZdi8y2X75FICIYA38PviyuBHKJ/8sP6QNt/Bf8fF65oXfsqhPDX8f69qXXExjwtJFQ2KBqSWkqJ4DGRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UsOGIcEU; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UsOGIcEU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737811657; x=1769347657;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Zn8wVdggEwjJZQ9f5DbloJCRM0qtInQj0d+jInRYTmA=;
  b=UsOGIcEUHwxAAXBZaI3c97ZRahDeGlW7nBSuDg7GKQfJxtCHYnFEfMCy
   XzpJRRcUg9qjVQsyc2R50fP8d/NvjKH/ruhGNYJ0ln6NCt5gKT2RE/LP3
   Zi5Te6Tv3xwtiqOYQPh2XDihUUIzapooctke2Cir24VDNvt5L9o+OuERp
   Yo5XIZdedbYTPXm/SkU/sIX7qDkR9jtMIV3GpK/KQ8wdZWUQTmiIZxX8h
   9r08ZkupjJi7Dh4J+630++NsZLCQEiz0kUKddi481pmDO9pkguaS6MjlZ
   MEKGi+51LEjs06CsqnWXdph2Vo3oEpRToLkRI6Zq6alMmQyVVpLS5gJj3
   Q==;
X-CSE-ConnectionGUID: ftB4sDBLTaG/2uOjrthC1A==
X-CSE-MsgGUID: AxAxd3b+SaikUynv9U7PuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11326"; a="48923852"
X-IronPort-AV: E=Sophos;i="6.13,234,1732608000"; 
   d="scan'208";a="48923852"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2025 05:27:36 -0800
X-CSE-ConnectionGUID: HEzISmxWQVK6+bWPA2QOIg==
X-CSE-MsgGUID: aq3kGEMARqijeHBnJwXkfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,234,1732608000"; 
   d="scan'208";a="108604160"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jan 2025 05:27:36 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sat, 25 Jan 2025 05:27:35 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Sat, 25 Jan 2025 05:27:35 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sat, 25 Jan 2025 05:27:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OtN4f6oqOBvCsEnUu5KnKBZnli0FGf13xcd85c8rj8LKXWqzYOWAzTWycXVufiCTOau0vCAHGUCndUdDuCV+gGD10NwagRml7O+bjPG61s8480cbaElw5Jds7Jpr8rZYgDxQkRV74YPauHRqd3bSJ7NYe8uAlb0lD0OZ8G42e3lwXqjwg2VWOQ1ETHMgjjlHFXh60QXM1pLm4bPCHH29gHrGhI1zOywV+cqz/IueyC5oWtH9GjODvI5kJn4brAvwRFYdynTDMzqcUQ4aHS/kMYPs/eAd/1cfwZX5MYULQVHhzKaLU+gWh1AfI/+RQlk2ReB/1NT+RIBjLvV1m9n5Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3jVsdDWHUyUIJBcXw3+oqduD/vImxVlxcoc2SaUEx8=;
 b=FEoE5H0EC03hmfVd1vIj2zSgMSV7A/A2FvdctUZkuI8ZEnf1s8JDOn6FRTYtLRbCFCPuAijT63SifKTqF+LyeDCfLd5IArXsuZn/ejEB1+XzTqtiQLWB3zHspn9RG37GT5w47zWxv9slvQKHO1A97A/Bwjd1OWwIImW0KQbImt0blcoiGGn6WH2LX9btCQhnUg3B/3dq/EoJddApESt5aVrwdbP8XP+9KGry2mda3aVU8l7PLgY02oMa2rHcaVC8JJroWBJ09QT+kRMdFY8DWnAyUU36NgrXvABBpZ+PIhbWMmcMhUtEwfnyWcHZtgsnBOZCoHywiS5ZrTs+4FX0TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by BL4PR11MB8800.namprd11.prod.outlook.com (2603:10b6:208:5a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Sat, 25 Jan
 2025 13:27:18 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8377.009; Sat, 25 Jan 2025
 13:27:18 +0000
Date: Sat, 25 Jan 2025 21:27:08 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [peterz-queue:perf/pmu-unregister] [perf] 957245e139:
 WARNING:at_kernel/tracepoint.c:#tracepoint_remove_func
Message-ID: <202501252026.e14cafc1-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2P153CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|BL4PR11MB8800:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ec6d6b6-ad79-435f-aa02-08dd3d43fd5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?80e83QjY229cJpWTqCWYPSdzG59Py0zUXqSI/7JANFp+08A+/mTuAS4VgatG?=
 =?us-ascii?Q?wQTJs/5cfpRtRSnVwGiFXfI2mco+k+Rei9ofxOKDEkkH+hiB0+pFmWm/D+Jt?=
 =?us-ascii?Q?mcXCsnRm8e9C0FyOCCOm8Z1PyzNSfb8PdvUwDIgwLU6TtUU+0Eis+2/EHRMW?=
 =?us-ascii?Q?HgeZK413+7/KQ/Nass2fLRlYVx4PPoPCNLymzcFuDvXWmZ4DADJdHW1cpTV/?=
 =?us-ascii?Q?NsniVdZ+kFna60JvMHFxo51isSAXPQP/ATXcqtotclN8wy3qBK5oBSsmqCbm?=
 =?us-ascii?Q?BtmvZldCG8gfyTjD4/Nzz8ejYI9f+TwM81L5d2i5svjQxnU1yKvupR8EoAfS?=
 =?us-ascii?Q?YHv4Z1KQhhkhKsEo0jWWwZKUJ7TWlwhCHAwNpvG24JN1jizV6QXbY2BiCwcd?=
 =?us-ascii?Q?nqki2GUXh1IWJjpO+EvH8ZAtzYC68nYRXKp2o6tvSPbpvW/aLkhdtiC9PGqw?=
 =?us-ascii?Q?DWq7qDBqT2g0/cFiTtVlrgxvBxZhxU8yJPALA7IkVEJYBTjWBxpinc7yCbSk?=
 =?us-ascii?Q?4+pi0ZkSdaxTR3AtjOQoBiPPBlTS33fSFo2LL8qQnFHs7+o1TD8iBhftTmpA?=
 =?us-ascii?Q?cEVJY/Qd0RCdU2n5jYrfeysxQeycrbPiuzjh3/d+hw/9ZvvjfloOaRz9gzBd?=
 =?us-ascii?Q?09x2mxgHaRAJCPR3KhteVDP0TFzTyHYLX0bmqoDx6S2cCgs/L86ff/G+78RY?=
 =?us-ascii?Q?IYPQ0FQSm0npcPuzbzJemIl2cGs6omwicgFc3rCUySI+SViRq5sEIczdsPb+?=
 =?us-ascii?Q?G4EAtV7RP2vTrHTxSZO4HR/e3iDeIk1eCKH249xJlna92P7HiT1qR69lFRzW?=
 =?us-ascii?Q?u0TbtSnzzcCgrFOVcxF58OeKtmhhBmt38C2vHxTX76Q+PCTKVfQuy3ZHMI6L?=
 =?us-ascii?Q?3RaKHZyBk8ElyAdUDx2ufHooflyTNApKQrmPJ2jNT/NBZgPxQ2hioxa2BCVX?=
 =?us-ascii?Q?T1LdPGyE4ZB5Jj4fMryfmSd0igiqlro+8QBf7qkQpZRQ4csOAqHAERsdJyVV?=
 =?us-ascii?Q?1TJHcFjYLcfc31HiUrvoJInI2e5ztBNYdMxBGt3yK6PKJ6JxdVsZRdgDw/k+?=
 =?us-ascii?Q?k23HKsM3oNRRDFz3+Hby/lDn0RJT6/lBrTXsSlYxIq83MoJgdSncK4DcZ35g?=
 =?us-ascii?Q?499iw2f9a2zeJD0r/r686k9YdF88OeDOXT1WV4WwJ2ODJUo07g67mCPfrELO?=
 =?us-ascii?Q?TyZmNiUD/VZHocEgH9qXslvOLC9+nrXn87un/lRtTrQEKJcXebHNowXaDZLD?=
 =?us-ascii?Q?F/TwRgHUJcmmjJeDeB1BQncerxWuROB2nQ10WQNB+yRoVgJbtYDrtqg2bv+p?=
 =?us-ascii?Q?ERVzCDyfDzo4iej2CEYiDvlU72jQQyOJcQeuLi70JbcblQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gDX4Jl6WnK5bGOoEDVgf1H1p2vd5GPGU037/XNGQ6OT3STIsTShfbQn0dVOA?=
 =?us-ascii?Q?JFRj+0rfDbgrWxS7Y3xEi+QkO/BsJoPYZeiTznMEhtTU9IENXotxzBWbPbgM?=
 =?us-ascii?Q?JHitRq+SULaPKESdj+Mwy7g+3Nk5GU2VxiR7uB5cRdD6A9Yum5thvmg/9BfY?=
 =?us-ascii?Q?cDWuFjzanfMZJMJxMHLoCPDYb3OUjkMrpTE+aHri38mUxiAIzjW25zu6j6vx?=
 =?us-ascii?Q?MGXeVNwt5hyfVN9X4zxUZWPn2xMD0kGZJXcdiB2JHDBw7VN3ay0iadIhzaEM?=
 =?us-ascii?Q?TiruMTwT8QVFgzaFQFNF3gQwjumJgy9NdDjnvxtT4uao/9vhgbdjz3jW0NDf?=
 =?us-ascii?Q?+L14DFze8/JeOtXeRn2SDJ2lxFW6jJUlN80A09P5U0l3POray5Y/HxQ8I7rq?=
 =?us-ascii?Q?JMEOf8EGW9qCScLG0qjasHph++7GSPc2g8dojfnbuutkVqIHwKgBomVJv15m?=
 =?us-ascii?Q?vQOAXdr7Vv4Qf31Z/NSwDPQdu+aqZw3iHxo02IOnT6OmXOWLoYfzbu0yvANL?=
 =?us-ascii?Q?SF6sSF2k5IMlkQSaS9cI/Uvf6MWIFuKsCxHHyzfQadO2A5zvTNwoHbA9ZFiu?=
 =?us-ascii?Q?E1/BCxpeHmpX+4F1yya7ewRuUyQXGw7mCDBAf/Cc0BR3xoQQiO7c9pP31Lz1?=
 =?us-ascii?Q?ht7xltQ9TL0gZJRoxGioowSAQVwSqeqapKAnw4kd3VUQ/FNuksqRBnMFy+Wm?=
 =?us-ascii?Q?loyxGqFKGxz/z+eG8kfdY3+rm7dgoU3bibGvnY87TDPBmmyfXlMJR1dta/kl?=
 =?us-ascii?Q?hSuAVTpxtVjhupTj3SWzJ9iNsX+DzPY+YO3a+MhiR5ZqQtq+XlGB3M47kqz3?=
 =?us-ascii?Q?pKuxEIxOtEYEnOAVgekKhi15WzGR2dTMPrXfbCrLeCCOyUfhnXFHzINCjILa?=
 =?us-ascii?Q?15xMs5nln/LcR3A6Luy40QOCtdYMFzMaNw8a/p2Hcr4EEOfbKUG1ZzHCy9Kx?=
 =?us-ascii?Q?N3YmGXZV8XpHaE0hCSo0W+4UxCzA4F/E/UQicCLxX8d8GnbCzwi05KuCx5Dp?=
 =?us-ascii?Q?Gci2aOotmk/dPHjvv3zkYjmsjXNVp0ff1P8CG4f2loHwRVB6bzfAkAWKYqGe?=
 =?us-ascii?Q?coe+5pL9Co/pIYSxJsRZ4e/9/fFRkwsVFOaC4x1+RBGwvv5dIlM4LfmFXZRp?=
 =?us-ascii?Q?wc5xhHguvRmj5b6gmp9D/yTrRx06MO0O5H/a0ZT/wDYqCHcscjhTzx8kQOzY?=
 =?us-ascii?Q?SWShyFkt2XmN3SxOJ4CX8FYpLKH2NVi7Wnf6+AwXUqLX9z3sFOhs9Qbt64i0?=
 =?us-ascii?Q?P9pZC5dc5MAEjAAejzSVEV+QiquzXbjspWyZjqrc6BN0datld9KSvDPJB7Yb?=
 =?us-ascii?Q?YQYGP79YB0hhaemdxQpKJMXSR8Re9ZIMKuEcfDm7/eh/o4SzDho0+7iVaVaQ?=
 =?us-ascii?Q?4/rUszWyKAGJixndoxfpAHs3HgQsJKtEuNCfz3zRTNPnkhh2A6Wm0JoWM1yp?=
 =?us-ascii?Q?R/p1MatxdAUB5wr3ZP3MztokF6TIkYEdNCDtrVWMLsU7VudTo8nJqhj8WTmn?=
 =?us-ascii?Q?U8OygRXzagglENkiqbBVwMo2XKoSdR8yQB7G/FZRRltTMfcNniq+R+h6+9gf?=
 =?us-ascii?Q?7eWeSM7laaGa5ziGKdKnVNMG+o1267MKA9Bb2uRwUawdou23xXyVr3LeG8X/?=
 =?us-ascii?Q?wQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec6d6b6-ad79-435f-aa02-08dd3d43fd5c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2025 13:27:18.0203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J2yAdmIgO0Zrnttpt6xP3l29Jwlhlj8X6YfMd/QXDU8SOSbHC5S2kFMkPmmx4idarGOuvoiQJikTeMrG3NxL9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8800
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_kernel/tracepoint.c:#tracepoint_remove_func" on:

commit: 957245e139f2cc743fe0e922292d532695bc7446 ("perf: Simplify perf_event_alloc() error path")
https://git.kernel.org/cgit/linux/kernel/git/peterz/queue.git perf/pmu-unregister

in testcase: trinity
version: 
with following parameters:

	runtime: 300s
	group: group-02
	nr_groups: 5



config: i386-randconfig-006-20250122
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+--------------------------------------------------------+------------+------------+
|                                                        | b132a6f899 | 957245e139 |
+--------------------------------------------------------+------------+------------+
| WARNING:at_kernel/tracepoint.c:#tracepoint_remove_func | 0          | 12         |
| EIP:tracepoint_remove_func                             | 0          | 12         |
+--------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202501252026.e14cafc1-lkp@intel.com


[   28.022186][ T3556] ------------[ cut here ]------------
[ 28.023066][ T3556] WARNING: CPU: 0 PID: 3556 at kernel/tracepoint.c:358 tracepoint_remove_func (kernel/tracepoint.c:358 (discriminator 1)) 
[   28.024406][ T3556] Modules linked in:
[   28.024976][ T3556] CPU: 0 UID: 0 PID: 3556 Comm: trinity-main Not tainted 6.13.0-rc1-00045-g957245e139f2 #1 5b670c1516a7ab6a07963dcfb7871776d6e3b5df
[   28.026633][ T3556] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 28.027890][ T3556] EIP: tracepoint_remove_func (kernel/tracepoint.c:358 (discriminator 1)) 
[ 28.028405][ T3556] Code: e8 39 16 74 0e 83 c0 0c 8b 10 85 d2 75 f0 e9 2f 01 00 00 8b 4e 04 39 48 04 75 ea c7 00 95 38 0e 41 eb e2 c7 45 f0 fe ff ff ff <0f> 0b 8b 45 f0 e9 1c 01 00 00 39 5d f0 0f 84 01 01 00 00 89 d8 e8
All code
========
   0:	e8 39 16 74 0e       	call   0xe74163e
   5:	83 c0 0c             	add    $0xc,%eax
   8:	8b 10                	mov    (%rax),%edx
   a:	85 d2                	test   %edx,%edx
   c:	75 f0                	jne    0xfffffffffffffffe
   e:	e9 2f 01 00 00       	jmp    0x142
  13:	8b 4e 04             	mov    0x4(%rsi),%ecx
  16:	39 48 04             	cmp    %ecx,0x4(%rax)
  19:	75 ea                	jne    0x5
  1b:	c7 00 95 38 0e 41    	movl   $0x410e3895,(%rax)
  21:	eb e2                	jmp    0x5
  23:	c7 45 f0 fe ff ff ff 	movl   $0xfffffffe,-0x10(%rbp)
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	8b 45 f0             	mov    -0x10(%rbp),%eax
  2f:	e9 1c 01 00 00       	jmp    0x150
  34:	39 5d f0             	cmp    %ebx,-0x10(%rbp)
  37:	0f 84 01 01 00 00    	je     0x13e
  3d:	89 d8                	mov    %ebx,%eax
  3f:	e8                   	.byte 0xe8

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	8b 45 f0             	mov    -0x10(%rbp),%eax
   5:	e9 1c 01 00 00       	jmp    0x126
   a:	39 5d f0             	cmp    %ebx,-0x10(%rbp)
   d:	0f 84 01 01 00 00    	je     0x114
  13:	89 d8                	mov    %ebx,%eax
  15:	e8                   	.byte 0xe8
[   28.029967][ T3556] EAX: 00000000 EBX: 4333d300 ECX: 00000000 EDX: 00000000
[   28.030565][ T3556] ESI: 432d4924 EDI: 41c64038 EBP: 46975c10 ESP: 46975bf0
[   28.031162][ T3556] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068 EFLAGS: 00010246
[   28.031857][ T3556] CR0: 80050033 CR2: 093fc02c CR3: 070576a0 CR4: 000406b0
[   28.032493][ T3556] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[   28.033089][ T3556] DR6: fffe0ff0 DR7: 00000400
[   28.033518][ T3556] Call Trace:
[ 28.033848][ T3556] ? show_regs (arch/x86/kernel/dumpstack.c:479 arch/x86/kernel/dumpstack.c:465) 
[ 28.034249][ T3556] ? tracepoint_remove_func (kernel/tracepoint.c:358 (discriminator 1)) 
[ 28.034739][ T3556] ? __warn (kernel/panic.c:748) 
[ 28.035122][ T3556] ? report_bug (lib/bug.c:201 lib/bug.c:219) 
[ 28.035534][ T3556] ? tracepoint_remove_func (kernel/tracepoint.c:358 (discriminator 1)) 
[ 28.036034][ T3556] ? exc_overflow (arch/x86/kernel/traps.c:301) 
[ 28.036454][ T3556] ? handle_bug (arch/x86/kernel/traps.c:285) 
[ 28.036854][ T3556] ? exc_invalid_op (arch/x86/kernel/traps.c:309 (discriminator 1)) 
[ 28.037283][ T3556] ? handle_exception (arch/x86/entry/entry_32.S:1048) 
[ 28.037737][ T3556] ? perf_trace_binder_update_page_range (drivers/android/./binder_trace.h:339) 
[ 28.038295][ T3556] ? atomic64_inc_return_cx8 (arch/x86/lib/atomic64_cx8_32.S:105) 
[ 28.038771][ T3556] ? exc_overflow (arch/x86/kernel/traps.c:301) 
[ 28.039186][ T3556] ? tracepoint_remove_func (kernel/tracepoint.c:358 (discriminator 1)) 
[ 28.039673][ T3556] ? exc_overflow (arch/x86/kernel/traps.c:301) 
[ 28.040113][ T3556] ? tracepoint_remove_func (kernel/tracepoint.c:358 (discriminator 1)) 
[ 28.040605][ T3556] ? __mutex_lock (kernel/locking/mutex.c:588 kernel/locking/mutex.c:735) 
[ 28.041030][ T3556] ? perf_trace_binder_update_page_range (drivers/android/./binder_trace.h:339) 
[ 28.041588][ T3556] ? tracepoint_probe_unregister (kernel/tracepoint.c:504) 
[ 28.042115][ T3556] ? perf_trace_binder_update_page_range (drivers/android/./binder_trace.h:339) 
[ 28.042678][ T3556] ? trace_event_reg (kernel/trace/trace_events.c:542) 
[ 28.043125][ T3556] ? perf_trace_event_unreg (include/linux/tracepoint.h:117 kernel/trace/trace_event_perf.c:168) 
[ 28.043608][ T3556] ? perf_trace_destroy (kernel/trace/trace_event_perf.c:242) 
[ 28.044072][ T3556] ? tp_perf_event_destroy (kernel/events/core.c:10437) 
[ 28.044531][ T3556] ? __free_event (kernel/events/core.c:5343) 
[ 28.044948][ T3556] ? perf_event_alloc (include/linux/err.h:41 kernel/events/core.c:12497) 
[ 28.045404][ T3556] ? __do_sys_perf_event_open (kernel/events/core.c:12907) 
[ 28.045909][ T3556] ? perf_prepare_header (kernel/events/core.c:8145) 
[ 28.046379][ T3556] ? __ia32_sys_perf_event_open (kernel/events/core.c:12797) 
[ 28.046878][ T3556] ? ia32_sys_call (kbuild/obj/consumer/i386-randconfig-006-20250122/./arch/x86/include/generated/asm/syscalls_32.h:337) 
[ 28.047317][ T3556] ? do_int80_syscall_32 (arch/x86/entry/common.c:165 arch/x86/entry/common.c:339) 
[ 28.047789][ T3556] ? __might_fault (mm/memory.c:6750 mm/memory.c:6744) 
[ 28.048218][ T3556] ? lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5851 kernel/locking/lockdep.c:5814) 
[ 28.048643][ T3556] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4653) 
[ 28.049209][ T3556] ? syscall_exit_to_user_mode (kernel/entry/common.c:221) 
[ 28.049706][ T3556] ? do_int80_syscall_32 (arch/x86/entry/common.c:343) 
[ 28.050168][ T3556] ? __might_fault (mm/memory.c:6750 mm/memory.c:6744) 
[ 28.050593][ T3556] ? lock_release (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5872) 
[ 28.051011][ T3556] ? _copy_from_user (arch/x86/include/asm/uaccess_32.h:26 include/linux/uaccess.h:178 lib/usercopy.c:18) 
[ 28.051447][ T3556] ? perf_copy_attr (include/linux/uaccess.h:212 include/linux/uaccess.h:401 kernel/events/core.c:12519) 
[ 28.052019][ T3556] ? __do_sys_perf_event_open (kernel/events/core.c:12819) 
[ 28.052519][ T3556] ? perfmon_capable (include/linux/capability.h:197) 
[ 28.052948][ T3556] ? perf_allow_kernel (kernel/events/core.c:13687) 
[ 28.053395][ T3556] ? __do_sys_perf_event_open (kernel/events/core.c:12829) 
[ 28.053898][ T3556] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4653) 
[ 28.054465][ T3556] ? syscall_exit_to_user_mode (kernel/entry/common.c:221) 
[ 28.054963][ T3556] ? do_int80_syscall_32 (arch/x86/entry/common.c:343) 
[ 28.055427][ T3556] ? syscall_exit_to_user_mode (kernel/entry/common.c:221) 
[ 28.055944][ T3556] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4653) 
[ 28.056506][ T3556] ? syscall_exit_to_user_mode (kernel/entry/common.c:221) 
[ 28.056999][ T3556] ? do_int80_syscall_32 (arch/x86/entry/common.c:343) 
[ 28.057460][ T3556] ? exc_page_fault (arch/x86/mm/fault.c:1543) 
[ 28.057903][ T3556] ? entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[   28.058348][ T3556] irq event stamp: 2189241
[ 28.058756][ T3556] hardirqs last enabled at (2189251): __up_console_sem (arch/x86/include/asm/irqflags.h:42 (discriminator 1) arch/x86/include/asm/irqflags.h:97 (discriminator 1) arch/x86/include/asm/irqflags.h:155 (discriminator 1) kernel/printk/printk.c:344 (discriminator 1)) 
[ 28.059530][ T3556] hardirqs last disabled at (2189260): __up_console_sem (kernel/printk/printk.c:342 (discriminator 1)) 
[ 28.060302][ T3556] softirqs last enabled at (2189108): handle_softirqs (kernel/softirq.c:401 kernel/softirq.c:582) 
[ 28.061076][ T3556] softirqs last disabled at (2189095): __do_softirq (kernel/softirq.c:589) 
[   28.061812][ T3556] ---[ end trace 0000000000000000 ]---
[   28.193713][ T3556] UDPLite: UDP-Lite is deprecated and scheduled to be removed in 2025, please contact the netdev mailing list
[   28.195493][ T3556] trinity-main uses obsolete (PF_INET,SOCK_PACKET)
[   28.231307][ T3556] UDPLite6: UDP-Lite is deprecated and scheduled to be removed in 2025, please contact the netdev mailing list
[  317.381340][  T306] sh: can't kill pid 3553: No such process
LKP: ttyS0: 273: LKP: rebooting forcely
[  324.872695][  T273] sysrq: Emergency Sync
[  324.874299][    T7] Emergency Sync complete
[  324.875652][  T273] sysrq: Resetting



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250125/202501252026.e14cafc1-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

