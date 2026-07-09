Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0E12D781B;
	Thu,  9 Jul 2026 04:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783571833; cv=fail; b=WowKK2OlSMVmE4k/epxLa7gctKmhiyuM/8hm7VRXtmvzRXDUFhLcJF6OAbFzdOyocyWCYvgSchk04vyDWV9e1MfcqWPL+rIQaexSaKeRUi8j8BvLHjZ9OiIKdoBhiUUjRurO1opH5ZHYGr7uo2EUu3hApagHNjx50DTIDE2eE2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783571833; c=relaxed/simple;
	bh=fOKYU+X1yMVCmiNMbKREeNzoMzAL8G5bEswWbM93xFQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=qiTQkldemPrCmWmfApCSJVqJtuNFcA55abWPxMf/uhGfN2xrQVrP8N5i1WrsG3Nu1xyui19p+sF0Qh96IYE0VH2dFVU2CNdJuan1YUTtl7TU/PE9wWnkTAU3Qs20hQxM3xNSUKDIgCmOQ2gIHdRV2ML/t8qg6zRvJYqssQGe4Us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nHP/DPB+; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nHP/DPB+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783571832; x=1815107832;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fOKYU+X1yMVCmiNMbKREeNzoMzAL8G5bEswWbM93xFQ=;
  b=nHP/DPB+lzrqUi2C+/vf+/aVwh7Oa4H/LAs3+zh0VXXgRtKSa231RCsj
   S4f2HreheLgS8uMh3lI58dH2yE2xSS9tWGn4sOEbNJM8XNdcXsWf0KoxD
   8C3vYWC1jVfD5ZEfVhwEmfwZStTSSuJ7O/iCUsWVrFjsqmuzR3uXQuFo9
   7UTsWYIdM/23qjZfYxxxaJgwvq8B8Z98yE0Uszco0bbxdgG3C7JGwxA2y
   dxKMLOhsCjxDhx92ogWyfpk/PQ2ArJMc4ZTqpuph3ymSzTrLSgKTtHmFO
   xdiEt16vYTcoXmUETbbKIm12SzYIBHfDfnjtab3EucEhocD4RrIbx7AXR
   g==;
X-CSE-ConnectionGUID: kB6K6pECQGuMQprzmX3WvA==
X-CSE-MsgGUID: yH9aTL0qRZqIvYydbV+t+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="83218536"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="83218536"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 21:37:11 -0700
X-CSE-ConnectionGUID: moUPo8UJQOGp3rv/tZ9TMQ==
X-CSE-MsgGUID: PYEbElEPQ5+tGnM9izzcOg==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 21:37:11 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 21:37:11 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 8 Jul 2026 21:37:11 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.60)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 21:37:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hxB3fWD6R9stoDzkgjwOGIgL29E1/9qpo785cz7wmf7eok4ZOuXsJxR/NqPmFo53uLeRx7g615aPPBr2/Xr9eErAvuImlA7rpnXb8wtHgAibFieSDuDCm+CVtcWm/i18VnaYoE9WIwTxm1kgdfkAPbQbEHWnVKvnAxFQ960IVNGqpOj+75DfYg+OUqHrKCwRjDG52KyXSJxVoiF1N/e6A6+PMWguAshUEB4imnaenadmafB0zGb+gwbrUo8UV1WOiwgUuvovMFUHXpMC+YFne50zaOKhAO3JMUtYE/KNRg8XZocftk7WB1UH4gEQwkOHV9ZKzVZSHnoTtqJ5A0EFGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IT/lUBaBmQ5V+YOsq1v45DRZGNWRCb0fjXLZTyFAtqY=;
 b=NWStMlJMRLB30aLVVDUiCrNZgu3e/IHWffj9wgRPktBOaCS5kAGkqHxpnJA7jXpijzeLdl4YtiOvVMVxLc1ViHeMfyzafRY/gJFd/EQdmvKt+9xZGC0ArMq16lhHSSoAvPB8pdVhQAJ4QOjRBhI3Oj4xFeK6EsYRA/lJsK3FntLPtvOaHLad+il9zIaBMhG2RptyZSMioINfA5L7WLSKRoBjstiYSQEVFS/GpzG9Fx/lgEbJ4m2EmmJ2AqaOXkNEThdPuGRsDaxjjZIjFXac3zSXU0wMLdvcPGLsqpS3yF1KXYYe18UIt6SNokFjPVq8mF/B75/gu7pxq731/ZRkKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by PH3PPFAB4263235.namprd11.prod.outlook.com (2603:10b6:518:1::d41) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Thu, 9 Jul
 2026 04:37:08 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%5]) with mapi id 15.21.0181.008; Thu, 9 Jul 2026
 04:37:08 +0000
Date: Thu, 9 Jul 2026 12:36:57 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	<linux-perf-users@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [tip:perf/core] [perf/core]  166f10836a:
 perf-sanity-tests.Object_code_reading.fail
Message-ID: <202607091054.7c96d6c6-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: KU2P306CA0005.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:14::15) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|PH3PPFAB4263235:EE_
X-MS-Office365-Filtering-Correlation-Id: 875368c4-f8a8-4d46-dff7-08dedd73baeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|18002099003|11063799006|56012099006|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info: fdtVRU/qzJNUaggF82qJL/O4dYEkZ27liaBgOIedQhF0PVt3pCrpv+OyzvLaNSY/nC1l5qdUrpAvsh1ZuIYDv4YSsu3l8l9+bvKbct9kRgAD1utNkihD9PeyxiuaNuNHrlWswoqT94LB+tTfmbP0P4bSQc1qIuJsY02Yx9SIsag8wpkMLAecLvKr/98fMeggHH2+8Tn4Sfv5DodG1qhl16V5PuUSMte9bs3prA/SqIO4nF6cjQIcrNxb7PTFzsk+5FF+tWbc2zsaaCUDpSoUF7Bz5VdHM8D3y2fX7N1akArwog/EjxNW8r2lL4v3WcLON2XQq+8BKf32dDzF+hW7ZgixgTWr1DJMO71LmjsnAKgfNtFO1Q6d2cOn9JXGtmypY7IYlFSFNEQT7zx21xAuoVLsj4Wc9f3S56IWx7VtI9hPouEZzpFyqXHvx3i184h4tr+nCRkmMdpBNe9mikCXVUib3GHIifvflCFVIueaVmHfBuFnw8bPs61145cSIg/oVhoMZ5V9zOqoM9MAiIxAPfJR+VlTAIkS/iyltbQx/3Zdx2tLmlC9RTKahGhs8DLlNIt7j0twIIJ6iS4ZXqOAJnk9X8yIZNBRkOZ5exKGPLFjKfcboXO3xiSWhZv2/c/f
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(11063799006)(56012099006)(3023799007)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WaOU1dnHPkeWAqBHhqGZ6xKa6MtnFkQT7fTS/evKSP6PoYuuN/z0YxaXzBHu?=
 =?us-ascii?Q?3oZeKkn5CYRP4ZH1F2jHLQMZCW78TlB4IxpMI/ZE4QI46FO2tYTtEmk0tmum?=
 =?us-ascii?Q?ZzsSiRb8EIs/NmagFuR3rQRafxxiy2N5Vl39umc+svjs4Q2hW2O9zPzKB54L?=
 =?us-ascii?Q?17iQkeTlmwSWW3pUeC/3CVCZq4w/+BVsjpNzmSPNoSwBrUTsfKxgGVdsubUC?=
 =?us-ascii?Q?CQFMPsgc02Hrqn8vXVgXEry0gROf42s0FEfW6wb8blXpXuGm7qENMbgkQ0gu?=
 =?us-ascii?Q?XB58ICsZnA/vDfYSeb+Vb7Nj84n0iFdLoHahl7iRWezcrvnsYlV0wUiFe0Ld?=
 =?us-ascii?Q?Rxexad7UL8QTwHDyL6BiTX522mouE3iJR37VYCRu1QaG+MvPFq24GVDvBLX+?=
 =?us-ascii?Q?01WYzeGJqW9MDloVNbOit42lEtCFz3lwbd7+m3FK7w3UO3VL9cOTpJG2WUXO?=
 =?us-ascii?Q?PXw30XqmpYPXNHGsAuSG2VduOeKKORd/B79k+n3MnKHqj8dYCGyCDMdWtXAl?=
 =?us-ascii?Q?pCOc/0lFF6ZJoIu486TD4H+QhkI2BW3saap+RvQCepd91JKvubJf3/5ru8Ph?=
 =?us-ascii?Q?LYthcC/Lhw27MjZuB9munNUTdbiOUPqXhQBFo6jl5Hsa0r6Nq6uKQdvLbcGm?=
 =?us-ascii?Q?qbkYOn3EMaFbJMadBNGzgTmT3Y3SoTo9jPA4QDBYycQHEDUBuhcoCn3ou0C/?=
 =?us-ascii?Q?JUibh6/S4xpn1Fq3pu4Lfne0cxOWqqE86IqjnvAlAH6gDdwrTYyScLVAxnmX?=
 =?us-ascii?Q?j/Teu2Z3c16bl/EiRXulohu7iVuVrc3JX4fVEEuJ+Nn9B+uTJpB51RSpIoaM?=
 =?us-ascii?Q?J9aLT/Za2na3zVbz0EBPBgoADAI8YAOB14b1fvxPWujOxBPVoAkVAvrEDlkH?=
 =?us-ascii?Q?lVVmHadqlcdzdpu37x9pc5Xm5ldzi0R4Ti5RN1McBF1PDL51q7KSICrwlmxn?=
 =?us-ascii?Q?DfYA1xoZVdNLaLxUImDoT6VhHO9EUp5BxCANINp+xjZXTc3A3Wjjdb0eTz95?=
 =?us-ascii?Q?xVa1h5XufE8yi9WywCnOwcQTiyeVvSDDGFqCiZwGdheqTZUmAJDP3sGOLRNp?=
 =?us-ascii?Q?nFKNP+Rs/3f5ABlWFGzR+RD53L2cCZITiZudbKrLuht2Vzgu5/60rk2nsBGR?=
 =?us-ascii?Q?feghzwQFC5KLs2ofKSCl0lE40KzMbQMtRXu+wKnUrjCzZslmQ8QK7pW2yL5v?=
 =?us-ascii?Q?5Kg66axUqx5YKXA1hbVOrsqqv6q8P1s7gBCTVUi9jiQMpca9Vyoh5CXR0jL9?=
 =?us-ascii?Q?sI4YueYOUFkt8+x3a2Im+43Gp/GVgDG0c0xhtD8duBW/mgi7EgDf/kj9rND+?=
 =?us-ascii?Q?pnmWJgWOzHTHoXLfha69DEIMSWowFasYb+XGiogfM7b1rSDlP18KJACy3m1i?=
 =?us-ascii?Q?rzfLAWYKTCctPRi0ebvMpwwRYSGO1Bbgf3wk5X7jOuJ28D2C4+/0+jOm16T8?=
 =?us-ascii?Q?55riUdEVtY9ph2iExp0GvTNFl8b66x1nSERo+YJs0RwNUji9KqIGsiMFdTwF?=
 =?us-ascii?Q?T2Dzy8thE7LxtZi0ygVc0Ba/65mrSYOUUshfsPSpFZ6Vi2m++ikUM93i/uKy?=
 =?us-ascii?Q?pNMbgFt3WykGQebLRtO5O6kboAT3d4RdHHUitN5fDQzQTcM6VyM43HAPzXbU?=
 =?us-ascii?Q?LAUBoXx/8qX+uD667+7NCAHegMJCOtoXRvnJ4lEcxhtpISvqaR30eDdkNgHV?=
 =?us-ascii?Q?TXLBBr+3B3bSttA5sJKJ2unfJzxM16CR6OJxzHkzzu5oA5ZUByw/k2Hw1bVj?=
 =?us-ascii?Q?qlbcHYLqpQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: a2LJUrY1iXH9QI9UhtyrTEI29xS6mM8WN3NnTfJHxNh5DMmiFbR6lNK1IjuvkgezK8Hd7LtBuSlcvWHAd2CGk98BpSafOkwatb/LeWvIVLS9rV0rB+e45A/9L4J6b8sDj0nb0sOYr7NOnfFBrtcfJSMZgNWvqxQxhkJ1yd45d5vdifKL337gm+TjzmQiZa91kSlGG0nseTBKLeGPi7jAnxvk76MirZvrNTBbfUyljqE+tQCPZQsCeLacHJ+5Bwj40tGQsHLKnfF7T0l2apHFtYEsBsEDcj24Qqa7FAPA2iWI364hkSwDM7fbRql5CIsD5M15dAxL395PdpwNVVd3Dw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 875368c4-f8a8-4d46-dff7-08dedd73baeb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 04:37:07.5111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BojHEgQmf847doN+eo6X0/cx5WKhnE4nmdTWG4LJsyj843hP/Ote0G3v0yQNKgRTGEd/xkBmg5jW2kFugtYYDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFAB4263235
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "perf-sanity-tests.Object_code_reading.fail" on:

commit: 166f10836a653dfa280d4335603b52f685b8b1ef ("perf/core: Fix kernel register info leak via hardware skid")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git perf/core


in testcase: perf-sanity-tests
version: 
with following parameters:

	perf_compiler: clang
	group: group-00



config: x86_64-rhel-9.4-bpf
compiler: gcc-14
test machine: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202607091054.7c96d6c6-lkp@intel.com


2026-07-07 00:10:32 sudo ASAN_OPTIONS=fast_unwind_on_malloc=0 /usr/src/linux-perf-x86_64-rhel-9.4-bpf-166f10836a653dfa280d4335603b52f685b8b1ef/tools/perf/perf test 23 -v
 23: Object code reading                                 : Running (1 active)
---- start ----
...
Bytes read match those read by objdump
Reading object code for memory address: 0x7feb8f2134fa
File is: /usr/lib/x86_64-linux-gnu/libgcc_s.so.1
On file address is: 0x204fa
Objdump command is: objdump -z -d --start-address=0x204fa --stop-address=0x2057a /usr/lib/x86_64-linux-gnu/libgcc_s.so.1
Bytes read match those read by objdump
Reading object code for memory address: 0
thread__find_map failed
---- end(-1) ----
 23: Object code reading                                 : FAILED!

=== Test Summary ===
Passed main tests : 0
Passed subtests   : 0
Skipped tests     : 0
Failed tests      : 1
List of failed tests:
   23: Object code reading



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260709/202607091054.7c96d6c6-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

