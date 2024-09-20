Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F2D17C9E;
	Fri, 20 Sep 2024 07:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726818673; cv=fail; b=lP7K4Q9dwHKs+ACa6uyeMGJ+J7ougrVM3/HQj9c/nLq1JcW1lzb2HjZj7xYWSy9qlsmESKo16HZvpxBQEoWkJGwJjU54EpxhyO4ryvsHAd63fcGJgxFpb2PHPo6wChd1ja1SaXtN2BTBo4p0vQApgy+/WXY+9Ota1St700jhnok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726818673; c=relaxed/simple;
	bh=01tPPmaXX2tGNwZ6VPi5fts5lJ0OiHZe7P1WqIidleY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=tOFF6AYfOv4MsYy1HbvMSJNSpMbsXMf6x4BYu6BnZc0zVTff6prb/8sltfyW91KgvY5sUFYqRYpL9KjFtE2fCj6WD8RWZ/8WN9UpP66NoWgZRg7MexMX4v2d2jjQNdy1HZ1TYquDN2GHJVy6T0aIVgTOCCrIQDioC+mvKGl3ecs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sk1UThW+; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sk1UThW+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726818672; x=1758354672;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=01tPPmaXX2tGNwZ6VPi5fts5lJ0OiHZe7P1WqIidleY=;
  b=Sk1UThW+Tx13kVzASPHTfQNdXqwHnHBqfjXjdj2cdca58WAQXg5g89rb
   YlfTlfPo8l64azpKX8MhuU50XCvhK73MGDQPX8NtO3t33t1jlQ5+vv2gq
   SBsBmepzAV51fEus5kUiR2F8SWNNdYHJwKs4B7bNK86o5KLObDFVPR06f
   fg6RI+CZXD/0CwOVrEz7UC5uxeX6TOEynEaS8jcW2waXgtFSQqKbu3p09
   ph2kQVeykuE9Sbom9vyU5e//aSLq5Gavp4Hj337oFBwtfjKwzafioLr71
   SHJ9PS0BoA5ccM4AN2vIaqNvK2VOgAIoO3MNenhfyx8i6Zm93mgspGsey
   Q==;
X-CSE-ConnectionGUID: sB8LMJ0NSkSx28yWAO+N+w==
X-CSE-MsgGUID: wdrC1oO9SHykOUbt8X+ifw==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="48346084"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="48346084"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 00:51:11 -0700
X-CSE-ConnectionGUID: /PLS8wOhQ0SlBEVUbz6Xtw==
X-CSE-MsgGUID: IZZO/aHlTcyiveDHDv07Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="107676288"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Sep 2024 00:51:12 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 20 Sep 2024 00:51:11 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 20 Sep 2024 00:51:10 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 20 Sep 2024 00:51:10 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 20 Sep 2024 00:51:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TKjEvjOxx5wZ5Ie2+2j8xA/xa6/TKzvrBpOF8EOsA1rGREaCQcx2GcVm4l+XyGeJnsUxfpE5vRxG5Qo7xHW7yH598o9IQSAj9oloaa37H6OMdxAHL9WQCvQK9UsEXobHWWWTyAUkAN4HjSsJROGSwFMdI7qfkpAHL0/AXmLHYMFM46h0/1BAcRN3KyOkO3JnHfyar8Z92c5GS+CEZF0gd4dlxnrOcTohcvw2uGOkXMm0nwW59+KKFVTz24D7Gl2nC3wc+IA9kVVEHG1s1nBaVLDf89WzoFZF5pRsMDzmPs57oTh4VITbEVBMG9sBIwSV+Umkqub9T7WYbifDC8G4WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBcOcX48UiA/A/MIHr1CQmLs6R1D7d0FQBqUn8ofPG4=;
 b=n5ZTSwkgNQlqBk6bXJnjkwJzprJF4wfMdgz8RhTX/Uatrlzk5Y6qZC3TZvWf39c7a0hYQqIsOVV5IgI2lTLB8x22fG9UaiVGoJ52G/F0CijRZZntXpukLiHOpKKQEbLl7ccWMO3/kQMHgz6+Sz4EJ+DYl0YScKkf5DXwjaiBjUFsUsWeUz3Ddvl48icJkHozw69EkWjFveNwLe85v+MaVCIsnmOzQMSXgWCCdU9QXWgrStBlxRsQRz8fSNb2xCHQfnSts8/xR7E7r4+0+k2sHBvxS7GkP2OqMCi7qT+2u+dHQFbVhZQupK4GmkTYxgEX7sX/oaqILziqYBwjpOUSbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW5PR11MB5931.namprd11.prod.outlook.com (2603:10b6:303:198::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Fri, 20 Sep
 2024 07:51:08 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 07:51:08 +0000
Date: Fri, 20 Sep 2024 15:50:57 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Kan Liang <kan.liang@linux.intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Li Huafei <lihuafei1@huawei.com>,
	<linux-perf-users@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [perf/x86/intel]  25dfc9e357:
 kvm-unit-tests-qemu.pmu.fail
Message-ID: <202409201525.4877023e-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SI2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:4:197::14) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW5PR11MB5931:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fa9ecf6-d6bf-4653-4aae-08dcd948fccd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2OK4++MxnayS8mqg4atPiAer5hbOdjQPIg+Yr5MIvEXZ5ODa8o8HqQ+PPYwg?=
 =?us-ascii?Q?n2cjde3XrpFbiFWdR8wcBS/JQ5klFLzv3UpJfyKo0Z5dw1FfE0/fpbbeu4gg?=
 =?us-ascii?Q?FTcw9kNh8R5gY6cMf1xdEAG7DjcvgJiqtTO1IHZtae2g5P0BwLELSOZ9ss4+?=
 =?us-ascii?Q?YApHb0RQilTJoL/+QB9CurrmyXmQMjfghvVFrBrV4+TH3Z2vexy7KgO/uqrY?=
 =?us-ascii?Q?WLx4W58CDxMJdNkuNz/l6aVWZ7Ug5TuYPF/ihNdhKRxUtOuLmbUmETs/zTcn?=
 =?us-ascii?Q?JwYLDgBU0WlVv479MyvE81ZygIHKjmbIrM0fXh+/MBmfA3PtAG5SNMXUfQEQ?=
 =?us-ascii?Q?nE4c7ep928BiJJqX+G2FzZnszjQgm8GtlrgGCnR6gfF/ylWbqtap8lC7rNBb?=
 =?us-ascii?Q?rZBQ37NzrGiSXpVdpAHP0aZp3zxQ44PDmDfI82qPXW5HZyuXtxZq0PYcoRmI?=
 =?us-ascii?Q?EWzi/E3CzPCnwy4GrKbXNcge+NWwSK2LIs5lbNbPKf5Mb4sgzvxhDGLluO+O?=
 =?us-ascii?Q?QsmkOgCSra3D+3pW2IEtD9Ot2bFgiy1+lnGg+GMKPoX1bBxQwQMFGhjpyYpy?=
 =?us-ascii?Q?EiGNLNicF8Wuii9Ivp0E2AkfGpMK97I7JHXwkhl6ryFtclDgXwU59CNxATjJ?=
 =?us-ascii?Q?MBJTUdzDJCeqZweD8xFGsoaOp279bmscKGDiLYGff7a4Tyyah6vzNdL/hVm3?=
 =?us-ascii?Q?zRpKyczeYZCBXzVAfGx4zHFe63TBXJTS09FOFyEZM0gE8bXJ9lUgoozZDeVs?=
 =?us-ascii?Q?E2iyd1JYUPYXR8AnwsJZiIkoohJ4lFyT6W/4vZxwzcOIgGug3ZtnaFRJdECy?=
 =?us-ascii?Q?RaJYLttrCoV0GVI2lwgjEJtyC/y20IujfvFZZhJSqH/aWITO642+qbYTgeTP?=
 =?us-ascii?Q?3vXyg1arbqwh6IWnJfqRY3ZHDIpXvpJjwd6Gooe+rZWYl92OcXJeSncHW/Ea?=
 =?us-ascii?Q?cDAX+uxc8ut5a2kaJJ0HUfDL5cxuAvO5Xcde+uXoIjvkcII5hcdkt3ueh/CA?=
 =?us-ascii?Q?+OBTvWhSg15gQy0wHq6wFvqhcISB8kk6qq4CSEhBKse5F6/pFEL9V6mpaQ95?=
 =?us-ascii?Q?MEWlc/PTm/7V5zhu9dPYvn0j9OwaJbzJKaqtEb8dySpLlGJ0T34zBMcWUQdn?=
 =?us-ascii?Q?HbLTdlGJfko64mlaT4oIqBYIPlsn1iAyw8pUVm3h1Qdx3NhBLmRIsthbH8cc?=
 =?us-ascii?Q?s/7CqILrakL3r1DSlG5s/Q75tV7+Pzdl45qVIr2V14KrVrw27cjZtr5BhU/G?=
 =?us-ascii?Q?VbwFIwOMpLuwc/FFXL1B50ghuZZETOWwngq5mFHe/7G6JAPKrLMGs0XvB4k/?=
 =?us-ascii?Q?zn7U9ZC6zM3X8mFSw1GL4OH+zUAELFDwyq5Ywqb3wcOABQ3l0RUp4rO6TS00?=
 =?us-ascii?Q?QIeVPUk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TuS8P7/4gvjgCbdPlNDAuEC0Tu6DwQhHVy7hSg1zOUdIQO0kzKwheo1CxH+M?=
 =?us-ascii?Q?9Xzbc4hVmOLAtxcw0SclKPXpWcx474gHENi3xR7qxWa8ldilNQj96ht1glCk?=
 =?us-ascii?Q?GeWxZHGUUgeAHA7Mx1v7uzumbZz+zwPmHJKAcKusVwkN7f2kjpKI3dkx8igr?=
 =?us-ascii?Q?AyXL9rq4Z8sOsuPIIIU1UVGxTP2NOx01UuxsQZUCa+NZ6R1/9ZR5jAzsMV27?=
 =?us-ascii?Q?QFeUxQBzrx0awkoEoLW25Ee4PHf3Ua2aMYirZ2E3Pxa940+uSJoK1lmSifDW?=
 =?us-ascii?Q?NnCQKlI8hu00ryztuGl2zUQUSvbeODiF4R4283cS6JN1INPY1kxjPV7WSiix?=
 =?us-ascii?Q?jD6th2fx7nzGgvLx5uQb5khM0PY8kjs5WCJ90BwcF6YYKyUYGZy2GHwrTu43?=
 =?us-ascii?Q?7+7CjQ6zLDDn/T7wL1b5KwkxwLWNE8RTZBHKanT1X/4DT1hEeM6R912wOA6/?=
 =?us-ascii?Q?h5cUZtYYXoPBJ/aALbGo5jOhVqVGDeXsPxCifOip6MIM0TpahAZq0ciod0Jd?=
 =?us-ascii?Q?0GKHKK696ZiP6mNX4aKgwU6f2p3JKTMqUPDajC9IXXapVvK9ZK4VbR8WqrVK?=
 =?us-ascii?Q?H5l2ZcG1rrVFmx6f6QxqflfseytILsPEESV14j4ha823xeVncMP1xYQ98qoe?=
 =?us-ascii?Q?3KtY70dAsI7Gq1hC+orSatbaC8aTVGdugBMpvSNJopuaGHwx9zjLg12vjxWJ?=
 =?us-ascii?Q?2gS8c7ZXs27yohy2oaTJKonAokHH7uBZFJEnGyJFhPCN8xe/LNQQTpl4BUyq?=
 =?us-ascii?Q?nsCX6jCFdzemSa518LPWOjkK4C89LY8EdvuElXnn+w5HWNYGZYhZvdkQYaDf?=
 =?us-ascii?Q?GkAvOYlGb2qXdVw5stjqfNOp2jT9ApjGrR1D7AvY6tbXD2V9zaY68hjvmUeT?=
 =?us-ascii?Q?m12hDe2FpEDGlgA+9fXtG6hjv3ALjGZENHl4JJccngwiCwVy5Va5F9j0pOla?=
 =?us-ascii?Q?kEnNoxbOOi4HiUqkqJS/f2VUrB7ZMVrjyGdLxlege1iaqqu+IzHn2Kbxeicb?=
 =?us-ascii?Q?3Gb+FJg8WnjHLE45DFv1OAcTBo1cmQ2g1H1ST+QFEIf1ZG7hCWorIfbD50N/?=
 =?us-ascii?Q?hZNRIrJT0znBgk17CQdsaiu6Y006CMF+vbim0myZmqUtnYFcOCR6pVIZK3W8?=
 =?us-ascii?Q?KWMI53797kQ45paMrv1KyYk6mJTurhqBmd0SqNCzD6jSz2gss32CW5AZE2hO?=
 =?us-ascii?Q?pdyzJHx9yBxU5+1OTGxIIooqrVcwp3T69zlfRUngo3ATY9e5/YbyBWuyGDjI?=
 =?us-ascii?Q?/42RW6XdnFbdGrDhznIDz04Ga5am05e1tids3WDxMeruA1GTqzlgXsuMtuHk?=
 =?us-ascii?Q?u+Yl6z3YsL3RgrAso8i29x4wZJAxY3+j7Wk3u10da6q4PXUw93Or+Y3tdG9M?=
 =?us-ascii?Q?MvNlaMqskWN//We0miW9Dr/mp/os/3ldSUv0j80mvtY7lv5GlzI/g6YQsXwr?=
 =?us-ascii?Q?t3vNqU/itH+6Ku2eDWr8+sar6SpQ+RZorZv7NOglhPzAs8o5wQ7H5Ry9A+WT?=
 =?us-ascii?Q?ugatFEeM0T7DAESe93KHk5SPAqKsRY4DUKdb3+EC4ZEf8qyirkYjbQTUR+9E?=
 =?us-ascii?Q?MnkXCPgLOfypo7LLU/8WetqTTXcAYxug0Wgq+oTp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa9ecf6-d6bf-4653-4aae-08dcd948fccd
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 07:51:08.2605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vIN1pt+Kmj5sCF4aVSlshKpr90qN6rLWstMy+EAk6dAppAi9vqfKcZf/qJgs2oVlC8DFNdMXm0rTYLTFF3m/6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5931
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kvm-unit-tests-qemu.pmu.fail" on:

commit: 25dfc9e357af8aed1ca79b318a73f2c59c1f0b2b ("perf/x86/intel: Limit th=
e period on Haswell")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      3352633ce6b221d64bf40644d412d9670e7d56e3]
[test failed on linux-next/master 5acd9952f95fb4b7da6d09a3be39195a80845eb6]

in testcase: kvm-unit-tests-qemu
version:=20
with following parameters:




compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz (=
Haswell) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202409201525.4877023e-oliver.sang@=
intel.com


...
=1B[32mPASS=1B[0m msr (1836 tests)
=1B[31mFAIL=1B[0m pmu (143 tests, 24 unexpected failures, 14 skipped)  <---
=1B[32mPASS=1B[0m pmu_lbr (3 tests)
=1B[33mSKIP=1B[0m pmu_pebs (1 tests, 1 skipped)
...



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240920/202409201525.4877023e-oliv=
er.sang@intel.com



--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

