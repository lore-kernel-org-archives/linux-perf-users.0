Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82305246BB2;
	Mon, 17 Nov 2025 08:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763366653; cv=fail; b=S27dC05pJh33lyo0s93NsSWCVZNzvSyHg1Db3w0BffsjVA1vHTIUmsBUCocvJMXlcKZ77onwxVHiU3v9IOIgQSZBftSs18ZPjGxcJNfceEKVopDyglp/zDxoZQY4U/4sa1v6t1DAoNtcZ0XHs1983Lviz0Ms3wzjwGyRq4NMslU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763366653; c=relaxed/simple;
	bh=dH+acp5AvKfFVsAeaiWAT9YoktvudTbcg3VBQDtJ1fM=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=YyYu+9o+YDeb2pvza7kTyTz5nOpbRfTBIO9NtJvCT0hlXo6K+EpSWTmjulIRO8lh3YSczgDy7LWa8xlaAghxI4iYZzMWIEfHa5wkQvfGU3QzdcXhmJwuZ2ZC84leizyovNAMCatia3zEa5iybRJYDI479xqKL8gLzgx4x1AqQnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c1jrdoVZ; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c1jrdoVZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763366650; x=1794902650;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dH+acp5AvKfFVsAeaiWAT9YoktvudTbcg3VBQDtJ1fM=;
  b=c1jrdoVZv+xXDAGaDbMMu9w0DQGnoQgblCNQ0FTpWWy10S2+hqwpBWvb
   wPCHzg3U75bufOEJa8K8RqpMPRTlW7VIc1xdUFY4Q8Oa7AalLbB/3WGRV
   kCmJpAe7t6tPxgKmZUXnfEEKBqfizuVEUsfQ+3zzpEx9cWk7vx1I5h1Dp
   d/JQrvy42xByK2QsAVN6hRambgViwJD1GKOpyUxUO9AgoaKw3yTblnRii
   kOupzEimHlGsDIw0Col8dWvRs4XdS6zl48Y84sUAYkiWLB8GgQeS6Hygv
   4lFPC31LYBTn7Gnw4cDV4ND7n2JWNDkQEN1Q/TQBAqQI33QV/vNrltfSa
   Q==;
X-CSE-ConnectionGUID: KiEpQeeDQLuSaImpIkJZvA==
X-CSE-MsgGUID: ujV+ICr9RFeb4mwIFtatQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11615"; a="65294611"
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; 
   d="scan'208";a="65294611"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 00:04:03 -0800
X-CSE-ConnectionGUID: sXRtr9y1RgGtdg97o7aqug==
X-CSE-MsgGUID: rAdeTicvSwa2S2p2XlXecA==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 00:04:02 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 00:04:02 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 17 Nov 2025 00:04:02 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.23) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 00:04:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hDXH4MC7sYmkT5frMKWMZe2Z2tkaDwDsHralNS/oBn+JAuHqnpKhTkYlJYHOnKqrAkwD7ag4G2dC/hopOXo+AV2uro3w8CXyZ8psPeaF7K9Og57OjAfDbZbKbIBuLXM9qqTF/vdEQBEoAENveb5QQFJEMEyCtfuEHnvc8kYwpVFmMsxH1PguDXc7aCVylcE2yM2MqDmiqZTaPVCGOj7hjv1i7snc46CgHx4SFKFk8nOwLJAyk4EhuB16A9zABkjDO3YYAr2RQJfLZ3QM/VhAqieX9MAR8ZveUxrDaCFL6pVSuc1Vjtj3RYM34STM48Y19MCiwaIHpS6GPHHOjly/7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32JLVcamIHt8mv6ZocwR+kqIKJOeWG5VXS6LjRar7N4=;
 b=jvSb/yplb8FG9VsVMRCKeKmkVoaINZvAaxbCm1VBW5bOhR7cXTVsicfuA2gCzMq7p0vmWh8Hld9O+1+4azNwnUxqVQz85nldb5vJlh+BXWO2OzSCzGNsTywCZBT8yhMm3uf14lPVhapE+pFGUZ3DsupSlNnB08GSqZCmlvtr6nee7Ao5wXFcf5RyEuVA5BEfIvbcIBUhbOttvYvHwB7NDZEUI3Ldv1RvbdEwmP8E2TVgNAWZRqOovamGzJhLxRHvIgQg04vWE+7KFrbrLChJaeHEcmFvHbe90Et5Y2ZMadLKqQlR9mjx5dJYVZjZiVvyd7mgBNMxOGxwIEjCHPEXiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA2PR11MB5003.namprd11.prod.outlook.com (2603:10b6:806:11e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 08:03:59 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 08:03:59 +0000
Date: Mon, 17 Nov 2025 16:03:50 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, <linux-perf-users@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [perf]  90942f9fac:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <202511171515.226076ea-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:196::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA2PR11MB5003:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bb2504d-a6d5-4493-0c96-08de25afdcc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Pp827QP+bV8IHBzpdJd1XLhtup96NEcNyX42vrpBKHBjcFYlqAJ7bYAqMad/?=
 =?us-ascii?Q?J25a0rOA0tdOpRJMas3JajJW8ySL7wPC0dlKPKnPVGZ7Y4ydwjBJN2UA8XoN?=
 =?us-ascii?Q?Px4Uq7LmO+dikELkIOaZ+3eQ47FfPwANKzwYGRuiDwqBLAQ0qZ7K84ia16Yx?=
 =?us-ascii?Q?74/E25rlxOnRZG/E3HKFpOUgwQ9zM6It+o9GMfnkRToAP2D/rN1iBXUasbS3?=
 =?us-ascii?Q?mAhyXpOyAg09ZFjdD0WN2FnAGBrRQjAfIYyTO5DkuqbTLbJ2TyBDUKPjV+CE?=
 =?us-ascii?Q?ugIb+cKntuv6CWFCOBz5fGyFPsKDYvpOFeqsDj22U4GZKjLqX7z7ORFXnL9G?=
 =?us-ascii?Q?xbm0/wgU/x9YHsx2ZFoVStsG3ZIC2yCuvlhkAQvKY2ZQ3nlP/cSpSoYVKxsB?=
 =?us-ascii?Q?5RhYlTsuz1VMeQYuk28QlVFK0Wjb9OJH7QI3TgczrtUE7agf2jXBgZ0882x7?=
 =?us-ascii?Q?pqjMXSYA2P4phuZbRBlvMt5a+s3EshPZg9FHmdqcr0EO+8QzSR5Zq/+teqfI?=
 =?us-ascii?Q?sm/m+XUN77PcZAYWSKlscliKGTJDguAQB186xds8YWHFo1K6K7yvfpBgLWFZ?=
 =?us-ascii?Q?UrtMLAcw99SDhaPsiZMZX/nhGhPKinNBYiWrjsbjmjxLfFV0Fv0ZTgpWiaFB?=
 =?us-ascii?Q?2E69u1ewclL5QZg3cEk3eh6xsA5CtrTmIlFwiNIeBCJqzdV66F2IUhdEQrmA?=
 =?us-ascii?Q?MqF/HGTZGzBbHkwfdFN595FwolJ/QSdV60j3O5d+v7sXwQcFvapm60T5GMvo?=
 =?us-ascii?Q?cynMhP3hqbMjetJAF9xJQLGHlwxA6n9O2LWnS2hvwzQgt0EaCcLOwWHyuJ4i?=
 =?us-ascii?Q?v8VA+zfsO93ZK9kcRqydTzV4+mgv9+TVHwQDzU+jP1oS6oY2q46mAbgvaPWn?=
 =?us-ascii?Q?ygdHC/2/DsTrR4Whje5ujW+rgTPIhSAkDm9Lh7DoO8mIZ1twcEb0/HlDgxh+?=
 =?us-ascii?Q?0RzDNuXofYF5wXd/xS0Rx0dmYzIm2it3kiAm71V9PmwMtrGBk/tprhf4hw0A?=
 =?us-ascii?Q?e8zSlrgEi94DlJ4KXWPt947ld8flkvBXJtoWME3dJfrxmyptwKS5EiByIEyq?=
 =?us-ascii?Q?TOe/GnRIKbmF1zeVy3HbAlHRfhIDqx4Ct/1hy6AjzvRZZdOGGfaqzIpTSwes?=
 =?us-ascii?Q?TOfcjykw9ExjTzjB4ah3L7mGHcgJn4dvb+UxewH3eDZYIFpdnVB3709fGlFg?=
 =?us-ascii?Q?OsyrsrZ5Ndkqy79jVW4ziCKfwr+8StL39z48K0Pz1WuUen56o4vi4OG67eVr?=
 =?us-ascii?Q?RQ7pWcncEjztFLhjosfzihzZamPTZuJokgbsFL4G/f6H6Yx0p01ZDztKahjK?=
 =?us-ascii?Q?JAuZKFLxhtVoyilRkR1U6MJZkv5MfrsxcYLvzn0Im0KISz7jmc+X8Jf7KccN?=
 =?us-ascii?Q?cPkPRlGFxa5KJ7xVXXHMID9wpXBzTQOBldHs2zxrnoOtrhQb2NCgoctI9Rnf?=
 =?us-ascii?Q?wbh9LDu6tn0PX58/rkSYy7y7rziV/PKHbrQWiVRUf08MpdLs4xSzwQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wLeXJgyYdSkQ5df/xaN+Qhoapm8nBBWNRRkvki55glTotrPWQ1zG5Mzk3cY1?=
 =?us-ascii?Q?ChijSRv0zdsp41hpUW8mDFXxftNfxE9VoXqfP/tPBpKeIm8cJ+XTIAeX54W0?=
 =?us-ascii?Q?nXBhB8Inmz5K2Y8Zy8MgfWyC4uqKTSllpU7bC7HcIB5I+d/XRJtnvXQ8Xc/y?=
 =?us-ascii?Q?KhcOa7RWqNBl9NTs7Jo7nILUNeo/wpImgHcvD11AvXM8+fIRSFDD7eLTQnqv?=
 =?us-ascii?Q?qKPTTPl6sKe17YbcxrhOQligN3iRkPTO5d9lrG0GeBYp3+SkTXx9v43GRmbF?=
 =?us-ascii?Q?Byc2H0xH19ffpo8rRxSyUi/fNu6vJeFBTP1iicuVGsnRx+KL9DSoKbm5Agbs?=
 =?us-ascii?Q?4u8C8FzSs+Po8tWgxhconzBs8BnkwaRPNUN7lBxhzqoQ+7gN1MxTM48Yovsd?=
 =?us-ascii?Q?ioM3NPtoFix24Qq91xNHToBtOkAe5ztrbHOFV4JEpjY9Tg2gM7pSyAldkxGS?=
 =?us-ascii?Q?jcQ+pMlXIfoan2WHmM94mdJck7gwDyLTZWIK9XXpcMX4pvv8gq3MK5uTSdHM?=
 =?us-ascii?Q?F0ndDc8yeEQ6S2Lj3ghGxneymkf6XDspUJuiwHHKFbn9Q8HTvy5XdnnNLANZ?=
 =?us-ascii?Q?p+Gr2ncZEFi1Sw78wsb0qyl0owE9gf9WJwuEUN0Rx8RA/5vOk6448iNuDquy?=
 =?us-ascii?Q?ITiFeh+WNKCL5rJafxqSTdih117ETFbsa/NRZF5chI8BBimeSQmRwO7o9O1R?=
 =?us-ascii?Q?Nh9j2lxkQcKIjA10lFZGkn4TrpXwSVCmwwbnz/9K0ShiwiJHDvyYrlVSXjRd?=
 =?us-ascii?Q?nt0wjqKbgrrwEkGrEjYHLZkt7QjMqB+pEcqmuVzS7fg2n1UkABdIlbPaW0MP?=
 =?us-ascii?Q?cHZh2XutOS7GVIBbLuBaJf0TO/4DmGRoe88syP2dU/nfurgZfIs/xY+BI93H?=
 =?us-ascii?Q?kMLSATp9kX02nKxS5nX4swUzPuQvADUQ9L4WQdnJ6vwl/iJklj01s9bxQXpY?=
 =?us-ascii?Q?6oFhwhVak8G5h/9N0ExBHPin5S8EQIoBIbRRzwan1nVssUrwdutI+N1lFDX3?=
 =?us-ascii?Q?7jX+vfGxjehwWAaa/vrHZoo++deMYrx6qVjQ1V+HoYAAwptw5XNZvNzBwtWg?=
 =?us-ascii?Q?wTMBKUR0fVvPHtsKL5RSVZqS60+9SviY8v19fHI7Fs/RBP3daRlIw9erCI2j?=
 =?us-ascii?Q?YAmuevwUgvOTR15416GsiiWRzu2O5qETn3DDcCZ9WWKV2v6Jn1HD0soYASnK?=
 =?us-ascii?Q?CVzWNYwpRtVNzehFAYwVusEuQRl/V8iSk1OmyvMoKRP3Slf7/FzjQA55Kgxq?=
 =?us-ascii?Q?BivGz/0zBoFXkNpLZ5y46GpNlkBw+CEppGwZCO4NIoL21+Ra3OLld9FzDRMp?=
 =?us-ascii?Q?CUvxqC6M+uU0ixiMiDy1AgncyJImRFB1TGgrf+uzBQsYqmfMViLE7chbNG5t?=
 =?us-ascii?Q?/pgkfcKtaxHWqQ4ZGhHqK6Epiwex1Y1alYQGhMkpqulbc/FdCkdzP04MO0g7?=
 =?us-ascii?Q?zT7z+IgcGXRLzvSjZIZa0WQfeqegv0+iuoRB8lZsy/uZH3kQcbzgalwah9Qp?=
 =?us-ascii?Q?x2HDxGMDa6VkK3HMkqNo+pn452FYeCsrI+/xU5t8XOCq6DcETJG7yV6B0nNE?=
 =?us-ascii?Q?Jrv5hiSpTIuJ/3y/Q8qKo4ghGmK0MzTraBhQLmCBFITbwq69IOpbWz+Wuvfe?=
 =?us-ascii?Q?CA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bb2504d-a6d5-4493-0c96-08de25afdcc2
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 08:03:58.9670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s9HPHvRaxcJIwj0ukl4EsyzwjviAiJI5/Py0DtKRXxknv/BDZQMDY7wVu+Q1nNPJZ9ir2qjsYm2AmbCAv+gTiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5003
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:

commit: 90942f9fac05702065ff82ed0bade0d08168d4ea ("perf: Use current->flags & PF_KTHREAD|PF_USER_WORKER instead of current->mm == NULL")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on      linus/master 24172e0d79900908cf5ebf366600616d29c9b417]
[test failed on linux-next/master b179ce312bafcb8c68dc718e015aee79b7939ff0]

in testcase: stress-ng
version: stress-ng-x86_64-f38a0b09a-1_20251013
with following parameters:

	nr_threads: 100%
	testtime: 60s
	test: schedmix
	cpufreq_governor: performance



config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 256 threads 2 sockets Intel(R) Xeon(R) 6767P  CPU @ 2.4GHz (Granite Rapids) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


we noticed various issues happen randomly as below, however, parent keeps clean.

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/nr_threads/testtime/test/cpufreq_governor:
  lkp-gnr-2sp3/stress-ng/debian-13-x86_64-20250902.cgz/x86_64-rhel-9.4/gcc-14/100%/60s/schedmix/performance

153f9e74dec230f2 90942f9fac05702065ff82ed0ba
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :50          28%          14:50    dmesg.BUG:kernel_NULL_pointer_dereference,address
           :50          32%          16:50    dmesg.Kernel_panic-not_syncing:Fatal_exception_in_interrupt
           :50          32%          16:50    dmesg.Oops
           :50           2%           1:50    dmesg.RIP:__slab_free
           :50           2%           1:50    dmesg.RIP:__update_load_avg_se
           :50           4%           2:50    dmesg.RIP:asm_sysvec_apic_timer_interrupt
           :50          12%           6:50    dmesg.RIP:finish_task_switch
           :50          32%          16:50    dmesg.RIP:gup_fast_pgd_range
           :50          16%           8:50    dmesg.RIP:osq_lock
           :50           2%           1:50    dmesg.RIP:rwsem_spin_on_owner



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202511171515.226076ea-lkp@intel.com


[  296.249434][  C134] BUG: kernel NULL pointer dereference, address: 0000000000000068
[  296.249437][  C134] #PF: supervisor read access in kernel mode
[  296.249439][  C134] #PF: error_code(0x0000) - not-present page
[  296.249447][  C134] PGD 0
[  296.249449][  C134] Oops: Oops: 0000 [#1] SMP NOPTI
[  296.249452][  C134] CPU: 134 UID: 0 PID: 79798 Comm: stress-ng-sched Not tainted 6.17.0-rc1-00053-g90942f9fac05 #1 VOLUNTARY
[  296.249457][  C134] Hardware name: IEIT SYSTEMS NF5180-M8-A0-R0-00/NF5180-M8-A0-R0-00, BIOS 02.03.00 03/03/2025
[  296.249458][  C134] RIP: 0010:gup_fast_pgd_range (include/linux/pgtable.h:161 mm/gup.c:3121)
[  296.249471][  C134] Code: 22 7e 02 89 54 24 04 48 8b 90 f0 08 00 00 48 89 f8 65 4c 8b 2d b5 22 7e 02 4c 89 ac 24 80 00 00 00 49 89 cd 8b 0d 00 67 59 01 <48> 8b 52 68 48 d3 e8 25 ff 01 00 00 4c 8d 24 c2 89 f2 89 f0 83 e2
All code
========
   0:	22 7e 02             	and    0x2(%rsi),%bh
   3:	89 54 24 04          	mov    %edx,0x4(%rsp)
   7:	48 8b 90 f0 08 00 00 	mov    0x8f0(%rax),%rdx
   e:	48 89 f8             	mov    %rdi,%rax
  11:	65 4c 8b 2d b5 22 7e 	mov    %gs:0x27e22b5(%rip),%r13        # 0x27e22ce
  18:	02 
  19:	4c 89 ac 24 80 00 00 	mov    %r13,0x80(%rsp)
  20:	00 
  21:	49 89 cd             	mov    %rcx,%r13
  24:	8b 0d 00 67 59 01    	mov    0x1596700(%rip),%ecx        # 0x159672a
  2a:*	48 8b 52 68          	mov    0x68(%rdx),%rdx		<-- trapping instruction
  2e:	48 d3 e8             	shr    %cl,%rax
  31:	25 ff 01 00 00       	and    $0x1ff,%eax
  36:	4c 8d 24 c2          	lea    (%rdx,%rax,8),%r12
  3a:	89 f2                	mov    %esi,%edx
  3c:	89 f0                	mov    %esi,%eax
  3e:	83                   	.byte 0x83
  3f:	e2                   	.byte 0xe2

Code starting with the faulting instruction
===========================================
   0:	48 8b 52 68          	mov    0x68(%rdx),%rdx
   4:	48 d3 e8             	shr    %cl,%rax
   7:	25 ff 01 00 00       	and    $0x1ff,%eax
   c:	4c 8d 24 c2          	lea    (%rdx,%rax,8),%r12
  10:	89 f2                	mov    %esi,%edx
  12:	89 f0                	mov    %esi,%eax
  14:	83                   	.byte 0x83
  15:	e2                   	.byte 0xe2
[  296.249473][  C134] RSP: 0018:fffffe0001eef6d8 EFLAGS: 00010096
[  296.249498][  C134] RAX: 0000000000000000 RBX: 0000000000001000 RCX: 0000000000000030
[  296.249499][  C134] RDX: 0000000000000000 RSI: 0000000000100002 RDI: 0000000000000000
[  296.249499][  C134] RBP: 0000000000000000 R08: fffffe0001eef79c R09: 0000000000000012
[  296.249500][  C134] R10: 0000000000000005 R11: 0000000000000000 R12: fffffe0001eef820
[  296.249501][  C134] R13: fffffe0001eef820 R14: 0000000000000fff R15: 0000000000000fff
[  296.249506][  C134] FS:  0000000000000000(0000) GS:ff1100207a57e000(0000) knlGS:0000000000000000
[  296.249507][  C134] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  296.249507][  C134] CR2: 0000000000000068 CR3: 0000062d81424001 CR4: 0000000000f73ef0
[  296.249508][  C134] PKRU: 55555554
[  296.249509][  C134] Call Trace:
[  296.249510][  C134]  <NMI>
[  296.249521][  C134]  ? search_extable (lib/extable.c:118)
[  296.249526][  C134]  ? __get_user_nocheck_8 (arch/x86/lib/getuser.S:153)
[  296.249530][  C134]  ? search_exception_tables (kernel/extable.c:59)
[  296.249533][  C134]  ? fixup_exception (arch/x86/mm/extable.c:216 arch/x86/mm/extable.c:364)
[  296.249537][  C134]  gup_fast (arch/x86/include/asm/irqflags.h:158 (discriminator 1) mm/gup.c:3181 (discriminator 1))
[  296.249542][  C134]  gup_fast_fallback (mm/gup.c:3225)
[  296.249544][  C134]  perf_virt_to_phys (include/linux/mm.h:2582 kernel/events/core.c:8093)
[  296.249552][  C134]  ? __perf_event_header__init_id (kernel/events/core.c:1433 kernel/events/core.c:1445 kernel/events/core.c:7698)
[  296.249553][  C134]  perf_prepare_sample (kernel/events/core.c:8357)
[  296.249558][  C134]  perf_event_output_forward (kernel/events/core.c:8489 kernel/events/core.c:8509)
[  296.249559][  C134]  ? get_perf_callchain (kernel/events/callchain.c:247)
[  296.249561][  C134]  ? local_clock_noinstr (kernel/sched/clock.c:304 (discriminator 1))
[  296.249564][  C134]  __perf_event_overflow (kernel/events/core.c:10384 (discriminator 2))
[  296.249565][  C134]  ? setup_pebs_adaptive_sample_data (arch/x86/events/intel/ds.c:2159)
[  296.249568][  C134]  intel_pmu_drain_pebs_icl (arch/x86/events/intel/../perf_event.h:128 arch/x86/events/intel/ds.c:2367 arch/x86/events/intel/ds.c:2667)
[  296.249570][  C134]  ? exit_mmap (include/linux/sched.h:2086 mm/mmap.c:1307)
[  296.249572][  C134]  ? exit_mmap (include/linux/sched.h:2086 mm/mmap.c:1307)
[  296.249573][  C134]  ? nmi_restore (arch/x86/entry/entry_64.S:1467)
[  296.249583][  C134]  handle_pmi_common (arch/x86/events/intel/core.c:3205)
[  296.249598][  C134]  ? nmi_restore (arch/x86/entry/entry_64.S:1467)
[  296.249600][  C134]  ? flush_tlb_one_kernel (arch/x86/include/asm/paravirt.h:85 arch/x86/mm/tlb.c:1630 arch/x86/mm/tlb.c:1585)
[  296.249602][  C134]  ? native_set_fixmap (arch/x86/mm/pgtable.c:582 arch/x86/mm/pgtable.c:591)
[  296.249604][  C134]  ? ghes_copy_tofrom_phys (drivers/acpi/apei/ghes.c:345)
[  296.249607][  C134]  intel_pmu_handle_irq (arch/x86/include/asm/msr.h:70 arch/x86/include/asm/msr.h:108 arch/x86/events/intel/core.c:2505 arch/x86/events/intel/core.c:3349)
[  296.249609][  C134]  perf_event_nmi_handler (arch/x86/events/core.c:1767 arch/x86/events/core.c:1753)
[  296.249614][  C134]  nmi_handle (arch/x86/kernel/nmi.c:162 arch/x86/kernel/nmi.c:130)
[  296.249618][  C134]  default_do_nmi (arch/x86/kernel/nmi.c:393 (discriminator 61))
[  296.249627][  C134]  exc_nmi (arch/x86/kernel/nmi.c:588)
[  296.249629][  C134]  end_repeat_nmi (arch/x86/entry/entry_64.S:1409)
[  296.249634][  C134] RIP: 0010:__slab_free (mm/slub.c:495 (discriminator 1) mm/slub.c:567 (discriminator 1) mm/slub.c:4509 (discriminator 1))
[  296.249637][  C134] Code: 0f 84 62 01 00 00 49 8b 95 b8 00 00 00 48 89 c1 41 89 da 48 89 5c 24 58 48 0f c9 66 44 2b 54 24 2c 4c 31 f2 66 44 89 54 24 58 <48> 31 ca 48 89 10 89 d8 c1 e8 1f 4d 85 f6 41 89 c1 41 0f 94 c0 66
All code
========
   0:	0f 84 62 01 00 00    	je     0x168
   6:	49 8b 95 b8 00 00 00 	mov    0xb8(%r13),%rdx
   d:	48 89 c1             	mov    %rax,%rcx
  10:	41 89 da             	mov    %ebx,%r10d
  13:	48 89 5c 24 58       	mov    %rbx,0x58(%rsp)
  18:	48 0f c9             	bswap  %rcx
  1b:	66 44 2b 54 24 2c    	sub    0x2c(%rsp),%r10w
  21:	4c 31 f2             	xor    %r14,%rdx
  24:	66 44 89 54 24 58    	mov    %r10w,0x58(%rsp)
  2a:*	48 31 ca             	xor    %rcx,%rdx		<-- trapping instruction
  2d:	48 89 10             	mov    %rdx,(%rax)
  30:	89 d8                	mov    %ebx,%eax
  32:	c1 e8 1f             	shr    $0x1f,%eax
  35:	4d 85 f6             	test   %r14,%r14
  38:	41 89 c1             	mov    %eax,%r9d
  3b:	41 0f 94 c0          	sete   %r8b
  3f:	66                   	data16

Code starting with the faulting instruction
===========================================
   0:	48 31 ca             	xor    %rcx,%rdx
   3:	48 89 10             	mov    %rdx,(%rax)
   6:	89 d8                	mov    %ebx,%eax
   8:	c1 e8 1f             	shr    $0x1f,%eax
   b:	4d 85 f6             	test   %r14,%r14
   e:	41 89 c1             	mov    %eax,%r9d
  11:	41 0f 94 c0          	sete   %r8b
  15:	66                   	data16


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251117/202511171515.226076ea-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

