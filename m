Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B961714CD;
	Fri, 13 Sep 2024 08:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726217506; cv=fail; b=i8Hp9FnxkNTAnteisie+kR99+XQ4l+3U1QQKH5vWP3fY4WKps5MGiu8Y16wvX2l02Bv3Do+dAVUX2dlwsfBzmU9me9zf1UrPmnpcOM5rOXT6LYrC2p/lJYy4XjVaadySnJKu5pRMrEYsH4CEEAjrrRLf6W1IjqkobLfajhNUeYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726217506; c=relaxed/simple;
	bh=sMJBrjLZ4GuIHh9hl5Tvlu6ZGl1G98MRSe7v4re3BoU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=ZUzXc0lbWZe0Rsj8eXefD2mO7k3yJhDXIujLGP0zNOUUAPQDWZyij1tTg+NVk1ErwiTyx/QYgGODefKpiGhSbefqZtiJsqC73kuEWF1xkvXHJyP0Vm66gcjbY9Pd/TYJ1PPS2jEJ4xFSlnG7NbdPntYd745X6cAwb/03GZ4XX2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uj70HLmC; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uj70HLmC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726217504; x=1757753504;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sMJBrjLZ4GuIHh9hl5Tvlu6ZGl1G98MRSe7v4re3BoU=;
  b=Uj70HLmCmUDqBHR6D4ONBBbmSuSKEZPyDxDk/jJb0We5rjil1YFRMFTA
   rx7bc1n89oiLXfRTGAU5cjD2NwLMYRF+lbaCKDsmrwwLIebBzRh2HmWE5
   kvQrDYM+knwZytR1cBUmGU+CxENJJ13G53uBoKmwPoKAq2stR6+7lMfEG
   PxXSbAu3m6tjZHb6fudYHtedzUEzVjLwLQXu8JIhfUVJDR8q2xTd6wq3r
   MGWlSm6lP08uycwbjScoXkwuQuUfLRUa5deXACI6biiaX2RZTjGElv8+x
   /D4gjsFlT+OJKO9YCk2jIgTI5obRZcTSvC0HwY9IEBWzfeY1+LbsSTzuv
   w==;
X-CSE-ConnectionGUID: pRTqbYo1TTCPLS7JSFSx9A==
X-CSE-MsgGUID: wh3EDoc8RwWVhI0Lpc1ReQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="35695166"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="35695166"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 01:51:44 -0700
X-CSE-ConnectionGUID: 3vCt5NIURJGtJKGOE8EaGQ==
X-CSE-MsgGUID: vcNsdCU1QlKbhg9zKdtXNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="72092486"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2024 01:51:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 01:51:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 01:51:43 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 13 Sep 2024 01:51:43 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Sep 2024 01:51:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AIiBiCzV+tORMUivjUIdnlTZQWwO5eOMW6whX6ntGxyqG0XphGZKWTMNt4zpYOnfRCmNNawpYvIxXc00UbHDwMjzhacguXok1sotRqAB50DD9CgrT9l8XimfvIyqa03hK5daJJVDhXJey1ailT4aCoezAaktbmzmVGStDjqiGSFc+lCMHPO754h4h6sbdyrO1lyEe227TmEZtHIlrrZ4RzKMJZsZ0NNqhNwkck6puW7DE4LgyK5x8Hm5SoPJYMZifgOvXP41Pb/Bs07hIe3qC0C9/6yTSaLaVVV3El1E6PTpF/1Dhn+B/VqbwuR0vAroeZu4+4DFuHkPBqHqiRrD0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lqdjw1CbVJDZRxT0MHUukTENWNoJ67w6VHD398xe1vI=;
 b=TDgBKKHbR2wTBIU+ulNkbrtVEp75wSuEbxSH5v7rKlhDLxLfCEX67vqlZlrd+CW+LNxX1FxiFeNvsUHwaERRM+kWKoO68RN4w+06tZhuyi911cNW7Tzr6PuF3/HjAftPpQviScpFGDFpQFN5AgalHKBYdavgMecSMmFlY2zgvHRK1wpBFsH1epHPPnoOzCkpUQMVdy7SF5GILvzsf+OSZ11KEJ3bpY1jYmCiXhxeKjed3zQW5b+6uCZwHHJZmC41awd25yYXH4ZegYKvNDqmgxJdubaBO8aXqLlsntGz3nwGSITWrCX1H3oUOROhYm5E2WncEiIMBYvkd6/g8Aol1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ2PR11MB7620.namprd11.prod.outlook.com (2603:10b6:a03:4d1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.20; Fri, 13 Sep
 2024 08:51:41 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7962.017; Fri, 13 Sep 2024
 08:51:40 +0000
Date: Fri, 13 Sep 2024 16:51:29 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Kan Liang <kan.liang@linux.intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Peter Zijlstra <peterz@infradead.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [perf]  4ba4f1afb6: WARNING:suspicious_RCU_usage
Message-ID: <202409131559.545634cc-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:194::21) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ2PR11MB7620:EE_
X-MS-Office365-Filtering-Correlation-Id: 76e5cfc4-19c0-4829-5beb-08dcd3d1491b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2dEBsN+7Pz8OSfzn9tgo2zUIG0jO0Ogb3G+kWOUbh3DfBW/TUczIJo5WBui4?=
 =?us-ascii?Q?zBoZty15zWVxY3LX4YYOLjjiKWgO/aBmpaONekGfsl2guMFUb92dRMFJzaGM?=
 =?us-ascii?Q?mOpSrYVUPn3I+yGXsOaQc5Nkm8jhfCN0XZXGOpwJC1bf//kpj8iuRpWRBC5C?=
 =?us-ascii?Q?G5uaHoMOfnBh94cHGkYQBcVUEwwNPIMZBCrph4YXGxD6jiH3AxLhdPqd2VPH?=
 =?us-ascii?Q?mzi9zWiXl9a/hkBGK6MZxgRyouRoO6PbAoQdxUPTzxD7zzGYx0Zxu9lEpHep?=
 =?us-ascii?Q?eznvZpYDwLqX35FAHiKbgvmXPG17eTdc3yk7be3p1/gJNN5t2tGJae0x362w?=
 =?us-ascii?Q?/oNuXb9CF1RMlTHn/id2TRjxwludE5I04N2mziOaopwzJT8L8Uu+gKoUFM9j?=
 =?us-ascii?Q?YqUqnMNNTROypJvJpF+L2o9/rLnfSS4A6jlhq2x3Cq3dV+EfjVz8eEw5+TsM?=
 =?us-ascii?Q?tWct1lW3m2p/hmZbeSJLZJQ8j6s1UnU+krtL0qaNsK/1dp081lOrAnVhfrAC?=
 =?us-ascii?Q?RH556Bamex+kbq4qTNxe9yro8qYfOJ6qadXIFIlOVWJGfVcLw+CSArcGrcGt?=
 =?us-ascii?Q?v3Oo30YqhCtAsq9SX85Jua+mWvj/3jtCiLtDvr/P3GQnXgrQnqGL1QOUfqvE?=
 =?us-ascii?Q?tTJL/tm7AlrRkChLanZigOdTfJ2xVPpJi2IXT2vB6M3DWrgA21mJGOP8mWy8?=
 =?us-ascii?Q?lHLk09c2ASC5ZjeHI39TDbzHyNbVgHjR2r/LiFCljlFIOEeGwLj5XgnQmr9H?=
 =?us-ascii?Q?NalbM7+Woa8WUTYrAYrn9jWpYtlPXZq07TCtp9PoE3pAFEzZp3d4Ktwxgthf?=
 =?us-ascii?Q?hl1mVreEZs76/yq3U2KpW5kUoC+zfDDHw68exF07oy4lpIkWp67JKMgWoNVG?=
 =?us-ascii?Q?iaaufssvCM4fmlAWpXdwDMiTeSZZERSrgVRuFR06Iiw2lPHw+DjqtkDblIhO?=
 =?us-ascii?Q?E1emeQjewqXeK3k8+jqTcEqZsyIdGYxbQGFKKto5PE9pL6DEqv15BLEaftDc?=
 =?us-ascii?Q?9SazMvDIJStpSyk3c69AgE2bbPIcykjImIL2atIzp/Mh3KZYxvnA8ly6OV1i?=
 =?us-ascii?Q?WZz1blw3ItZIFknZdawHVV1klR2dVW/PnrVcN2UMGINpfBvtZ6ZCCozUrIEv?=
 =?us-ascii?Q?2VLn8hJk3b600FHMMRE+3Lt1etAxGA2/G0GdNUowP2sVnyeYwuln9wPHwoo8?=
 =?us-ascii?Q?Xzqk/UZdmc+CjmdQ1YR1BTvyFijwn4QuI3cFgmcuTQFkn5d0zKXY79bN9fn0?=
 =?us-ascii?Q?PeYJr5VJa0COF2PM02pMXvslA0ohns/3zUAadCpScqibvwQXl6HT2TGQLE/B?=
 =?us-ascii?Q?RXMv53vP6qzwRKdZpkU1iUSKMY2GpzoFsdCyAvXtjrSVswX2f80CC6OMIBYG?=
 =?us-ascii?Q?K716bpc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZvSRMJweNpsxzQxJKatC7zBmScs4n8d1RmtrR7tpG0F2/ADElptFpHOd/9eq?=
 =?us-ascii?Q?7w/dYBrYHHARF0miNqVdZ39nMuIbFwEv2niritB55ZHLqi38sMmN5ZaHtecI?=
 =?us-ascii?Q?YjyRCsf2G1a0dWw1Nh/lG+noSpJwA5/fwRXVxiyQ/3vigJZrwCoA0SpM2JU6?=
 =?us-ascii?Q?SundOn3meu+e5MUutV2OgSJMtTeg5n4UpiNAlTA7kUh+wl7DOPX3odivHuO5?=
 =?us-ascii?Q?P2wOsiHjXvLV46sV0yFwPsoxFqbJXV07EtwV84+2hxXjK/wXoKP9gXArv+FZ?=
 =?us-ascii?Q?fG1SyI3sNINBWjJrOGdTJBNpgHOL+XiuGXG04AxWwHmKdvPZlWBxHBaFL4Rz?=
 =?us-ascii?Q?qUtWrmKi76UZDK/RoPQWomTzWOGt8PXdEBfy7lSyMOvQPC+4t1XbG/Lt//aY?=
 =?us-ascii?Q?rg6Xpx73TBj6iz7hYF5NJJttdowFoIchepo5cYwlVAOAKqSzwTmZ2gRriDd6?=
 =?us-ascii?Q?CNYdtDFHbe/XS1B6gIk+AooUktFXcVkHdtcCOuIpz+btq5qt9CrWO/m9GiK8?=
 =?us-ascii?Q?0rJi8X5gRTwia+ECMuj569TNyO+ZaCHc2PIS9tigUm4x3n2KPN+9mGRC8nfd?=
 =?us-ascii?Q?JKjhfQrR4NW9S904KTQJwN5i84oJdHZ78IZgo+aJdVw5uiLa6bN/aqZcfzB6?=
 =?us-ascii?Q?gJEpfmBBgXJl3QlQDl6+MEJyQe3SW55Jr5gd1Yh7hxtff94nR4J2dplOb2D6?=
 =?us-ascii?Q?SF11UDcnWGzpOPFTh+CdKg2Ue0auZ1P270XRqhBZeDlFlXqoz9ofecfb3a8R?=
 =?us-ascii?Q?gDidugkOnNRD3y/hSwDcwF2fWK1HvIDmAH41LS9f9CRXw49jv2HdQi8k5jVe?=
 =?us-ascii?Q?V1rLWQnqiKbJr4PSSGej+MtiA5Yb4sWJfJvSmFIGQjJFyLqs6X4Cn3fgtZoe?=
 =?us-ascii?Q?TWVnT6CKDL7pszjiu5AdfSI+fEAl8q+GqcYBh7T6mbw6KamajprEuK0Sc9ce?=
 =?us-ascii?Q?q6amBEm3GgmZCEFKD1+Dgu0WxfGUNqA5+zwhXUYj7eKxkkZLED8n5PAf5FuY?=
 =?us-ascii?Q?/N38Oag8tfZD1ra6b/EYOcxP7OFzncOrQCCpz5sgv9SVjJEzlfUED2lYIuvS?=
 =?us-ascii?Q?6QoqqhzhzuU0Ylnxj/6a19X8fySzMB+LUADRokmKHxlG0hk7bRNWUcrS4E6X?=
 =?us-ascii?Q?DQfNYFUUAOBxPk+HBd4oedZXmhqALYdBJljWvWb0MLYA7ogF1qkQDj6M13tJ?=
 =?us-ascii?Q?d1vk8qCAcQVgXuDx1RV1O9Y4e8q5ZkbpjeLUem1GRT7mcR+sqVGYgF9rdHCa?=
 =?us-ascii?Q?E+qWMcuVAOUdeZC28kkK09JAPGeBSn9N9XdZqlzJK4Aal2txLt8imHD2vyOB?=
 =?us-ascii?Q?35ZTgsRx03sYetTJPGvo/Y57FMrz5bzurtkyBwjN3pYHoomjRdR8vMJZMn9Q?=
 =?us-ascii?Q?r/9T0NKxGwqcG2jip4D0AUXsxr6nPnZ91OziDDghYoDqesK2NyFEPlQQY1Y9?=
 =?us-ascii?Q?4P/dum8qrWAq6t0XMtQukOTCyHHMVfvKiin7u6ESURXy85rDlUehdnsznSfA?=
 =?us-ascii?Q?WgYVUa/9DvTGTkMS1dpHxSzUkU0VoAeLocOW536LJpGtw8mGroPgVj5YLxr2?=
 =?us-ascii?Q?PGAE2SBpDhm4cbKWzu8hygVFwEf5Pu5pDKujIUldtNVplut7Jkb/4lXy37ed?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e5cfc4-19c0-4829-5beb-08dcd3d1491b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 08:51:40.8886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oeyavcodiuMRE8Hn32tbdyTbUMc8Ibm3Yx6JfVcKYhmX21O2gRKy8uW2U8f2k2Hf9hGQTbTtDqdiEQkLjE/3Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7620
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:suspicious_RCU_usage" on:

commit: 4ba4f1afb6a9fed8ef896c2363076e36572f71da ("perf: Generic hotplug support for a PMU with a scope")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 57f962b956f1d116cd64d5c406776c4975de549d]

in testcase: rcutorture
version: 
with following parameters:

	runtime: 300s
	test: cpuhotplug
	torture_type: tasks-tracing



compiler: clang-18
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202409131559.545634cc-oliver.sang@intel.com


[  125.180122][   T21] WARNING: suspicious RCU usage
[  125.180886][   T21] 6.11.0-rc5-00040-g4ba4f1afb6a9 #1 Not tainted
[  125.181734][   T21] -----------------------------
[  125.182393][   T21] kernel/events/core.c:13946 RCU-list traversed in non-reader section!!
[  125.183478][   T21]
[  125.183478][   T21] other info that might help us debug this:
[  125.183478][   T21]
[  125.184868][   T21]
[  125.184868][   T21] rcu_scheduler_active = 2, debug_locks = 1
[  125.208754][   T21] 3 locks held by cpuhp/1/21:
[ 125.209326][ T21] #0: c306b6cc (cpu_hotplug_lock){++++}-{0:0}, at: lockdep_acquire_cpus_lock (kernel/cpu.c:538) 
[ 125.210479][ T21] #1: c306b7d0 (cpuhp_state-down){+.+.}-{0:0}, at: cpuhp_lock_acquire (kernel/cpu.c:102) 
[ 125.211538][ T21] #2: c33ac828 (pmus_lock){+.+.}-{3:3}, at: perf_event_exit_cpu (kernel/events/core.c:13962 include/asm-generic/bitops/instrumented-atomic.h:42 include/linux/cpumask.h:529 kernel/events/core.c:13928 kernel/events/core.c:13967 kernel/events/core.c:14041) 
[  125.212625][   T21]
[  125.212625][   T21] stack backtrace:
[  125.213367][   T21] CPU: 1 UID: 0 PID: 21 Comm: cpuhp/1 Not tainted 6.11.0-rc5-00040-g4ba4f1afb6a9 #1
[  125.216087][   T21] Call Trace:
[ 125.216541][ T21] dump_stack_lvl (lib/dump_stack.c:121) 
[ 125.217219][ T21] dump_stack (lib/dump_stack.c:128) 
[ 125.217785][ T21] lockdep_rcu_suspicious (include/linux/context_tracking.h:122 include/linux/context_tracking.h:143 kernel/locking/lockdep.c:6684) 
[ 125.218515][ T21] perf_event_exit_cpu (kernel/events/core.c:? kernel/events/core.c:13967 kernel/events/core.c:14041) 
[ 125.219211][ T21] cpuhp_invoke_callback (kernel/cpu.c:194) 
[ 125.219935][ T21] ? perf_event_init_cpu (kernel/events/core.c:14040) 
[ 125.220755][ T21] cpuhp_thread_fun (kernel/cpu.c:1102) 
[ 125.221431][ T21] smpboot_thread_fn (kernel/smpboot.c:?) 
[ 125.222120][ T21] kthread (kernel/kthread.c:391) 
[ 125.222888][ T21] ? smpboot_unregister_percpu_thread (kernel/smpboot.c:107) 
[ 125.223731][ T21] ? kthread_unuse_mm (kernel/kthread.c:342) 
[ 125.224312][ T21] ? kthread_unuse_mm (kernel/kthread.c:342) 
[ 125.224906][ T21] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 125.225425][ T21] ret_from_fork_asm (??:?) 
[ 125.226044][ T21] entry_INT80_32 (init_task.c:?) 



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240913/202409131559.545634cc-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

