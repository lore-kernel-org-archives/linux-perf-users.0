Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0351BD9CB;
	Wed, 19 Feb 2025 05:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739944792; cv=fail; b=lyiXhFhV1TlUsNO5nZoofh31gNKAjN/PPtzvJK+G4VRFlG9FNpbc5y1MRhCvZ0T0VlEQWDHjZU6XEURYUpynIAhSFlZUVpnh0yWgJRAhdzK4hbWyO/JfDC/7lHl8C9MdfFeT2yIF8Pnya8Rldqt5ST1mChMHk9097HSR45q71oI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739944792; c=relaxed/simple;
	bh=Bxq7DX6O9ErAaHrKA/dpNs82XYAd1upXDBCCcDAyTBE=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=aGmKF9ZObH17N3NdGMc+VGg2xOEbDJpMWKQJZimmYMU5WuMMZI2MvNXD+nQuqtyuDoyV8HWcgCL9y6iPwJj2z/eBxP6wjt6d4PGtWbdLUe0tygHaG+RMt3wE5cI7/yObgiY9sfoxV5nlkAr0uedIm1QzIJDOJlEVxcdtl5VAXDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N1Izf1Ey; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N1Izf1Ey"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739944791; x=1771480791;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Bxq7DX6O9ErAaHrKA/dpNs82XYAd1upXDBCCcDAyTBE=;
  b=N1Izf1Ey87oJkmYhs9FQqJCANa/omPNLFF/9Wo/OodUthtYPS6K5hrgn
   DCZNNzHUB6hVRVt5/nk0SMkk+uk38lrrSTIsvI/XJXVCOrlSOsYO3t7Yl
   kTi+Iv+lB3vlvBpA7rfE2EcIhkUqq9M1quF92EiyXWkNNDu42jATgY2J8
   mUgrux6WRKxALhA+ngd/xQPo0fGh9HSPKX9enqvf4hT7Kd9ky51QcETME
   roTPx1NhQ6hqPXiVXVHwil4Dn4rov9L6PBw0JeIOy/8RxNLTkRZ5Bji3u
   DVIBeQ9OxCG5U/w8eZw9MmU17urM8md43a0fsL8suEe7RfhIKeB6S2SPi
   Q==;
X-CSE-ConnectionGUID: tbFyM1yEQ5GlEjIEWkZoPA==
X-CSE-MsgGUID: RqM5Hr6TTWaNJe2Hwb94pA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40925240"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; 
   d="scan'208";a="40925240"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 21:59:50 -0800
X-CSE-ConnectionGUID: VMIh5i6ZR9Kcrw0BEZd+uA==
X-CSE-MsgGUID: DNPTyJDSQGiHLJsbPR1t9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; 
   d="scan'208";a="119728570"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 21:59:50 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Feb 2025 21:59:49 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Feb 2025 21:59:49 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 21:59:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=daeXXObgvTzAJ4tG8FxadsmBKXluE+80+YpK58dMMygxGTMoNylUqPlAjQ77k7hDAaEvHAHqrsgSzeX6Z3ymiOH+2aEhAlhJsQuDkxRmrD5EuOPYAJilIasRJ4wFOu6QcR503lLXZgF1ssCh63zdWhTLBUAHzezT3YR2TcAihcw1gaSLhJxh/ngU+K54CFBQ1+KFT/+y7BdWQc9l4Fy0VnzopGQIskH7E/htFMC/FoJh0Mfieti9BFtEebyhNPF5Whf3B07wXHUcA0HlHe6qV+QcrBp3uTIvtP/xIe6X/0+Fy9fpb83RZhINXmxciOLOGwywBE4bfGOBGaIS+fkf5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsaB2nTy1jkCDPf65Auur+Q3VR0EehE2KAqzR9n1Md8=;
 b=Xw/9zPtsT7PNR+AbhVG0i1vIuHAFQNk1yt8fmXvQW5UK611gJ+urjfb20o1g3Nbn3ZnA7lUsBuriM40bgBKVVUFY/GquzDqQygm+BIharziZ8ZHLeDICXVjsHyO+rkptMOkNKdqn2Rwvfqjxmaj9oSPyjWssIp/ySBOevLFq93+yH9E3dX8c4q1NxK/GH/9yb5yBfamljfwyVdbbedHn7BkxGKKUT0EmRI5BttFvPPljT+wlvQXuevboGyMVZnL1yNbPqpXPGmBoIeDahonRO6ccmLeFlhQQdYE9muNKyx3Ft3nLSI1xS7xZ9l6+0wf+4B7MyQGCJshYGY8cPWFEVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH8PR11MB6778.namprd11.prod.outlook.com (2603:10b6:510:1c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Wed, 19 Feb
 2025 05:59:41 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8445.019; Wed, 19 Feb 2025
 05:59:41 +0000
Date: Wed, 19 Feb 2025 13:59:30 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <devel@driverdev.osuosl.org>,
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [driver-core:pmu_bus] [perf/core]  8c8ac498a0:
 sysfs:cannot_create_duplicate_filename
Message-ID: <202502191352.b65c904c-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0207.apcprd04.prod.outlook.com
 (2603:1096:4:187::9) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH8PR11MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bd618e2-ecf9-4bd4-13d4-08dd50aa99f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IXBJdM8JoJssb7Um7fdOyhrYw3nZeNXjFxlI9wMCAozok8gp5zFN8ZjYolwd?=
 =?us-ascii?Q?m4aHfgLH6Ggzq2jzJTD+KrZoh8i8Nx84Buvny1JcZKwQOJTaBgOOhNjJPLdA?=
 =?us-ascii?Q?wZeqtSlzRu6wP0yokak8wZk6H73BnyeyPMJwS4VBsTOS9VREN3p2UOF3ZDAf?=
 =?us-ascii?Q?jE4TxPPKI9WIf+y8RQBsUWaF1me6W/exsyod58bu8Cbd3C7WtL7uRjfcoNSn?=
 =?us-ascii?Q?v63gyLSd0Oqjrb7pI/+tsvCLiwpHs9rWZ8oDS78wiCkx/SiVywglC+b2waJa?=
 =?us-ascii?Q?Cuoz3VX1N3mZYrtvmKY+xBUTdFJ98eXgH+WSThEMLev1P+2n6NY0zBscfIOJ?=
 =?us-ascii?Q?2gZqJW+bd9/6If3eg1Yl9JselCYpztv7phYcwYtwLJdNQbQd40E8EK/frek/?=
 =?us-ascii?Q?XuZZyH+s4a+3tvqHriDGDlR9DjRdQtJ6gVjdT7bvto9mUbKgeaA2BXSe2k4V?=
 =?us-ascii?Q?C1UrMiVIoeA+Vxc5Ur7GnKNfijC6x6xG0AdhnUjmHB5hlHIVD6v4OOUDSZT9?=
 =?us-ascii?Q?EYAX7KzRoBAw8xHiU1bUnTwIUI6FvMRZ1nBz8pHf7ZIDoZALIdnRlxJE84IF?=
 =?us-ascii?Q?cGBI045fr17pQDwRUTC4bcArFz50sst6eIwP5ZxLf/9LeTe4TLalJ7Blez8w?=
 =?us-ascii?Q?/IFpbkQ5Bdy4Y/D/6ua0N+rjLlDeAeJKRKzOts6vBABXid6RB7Bsm0ZpaPao?=
 =?us-ascii?Q?hbFqbHfVOUHEUQZokw2azg1MCp+7sHXXB/PR5ptci+jbHvNtz5ffMvw408/S?=
 =?us-ascii?Q?2WprqXGCJEp8fc5K12yec6RTNx//XBD4xnZbTwr4zl4C+KosSpaMZLPst/GS?=
 =?us-ascii?Q?i7t2dc5ssnUB9QwlG+4SvRZBNxYJHPoXjAFDkWniudp3ICAfLOoT0wN8WWR0?=
 =?us-ascii?Q?gQG/qMDQTHfzbQLtTFeo0mzldbQjHrN5DUbLPcfvSxy8d35TpDotwIwaXUMX?=
 =?us-ascii?Q?bS9zR98EVlBGXmclueiQm/IeMuGNvYqYoFHkc0vgjF0bxyZaUz8QtkA8oGLP?=
 =?us-ascii?Q?BKegDVC4clOCyoWNgpXKuuZs2SjcMfaaWF/rmnTBR4M3jwFK0+mGlw1z0g7/?=
 =?us-ascii?Q?aTz5wu2iVHSSFxJuEgbNC4W/L2BMHrvDf2AOxlW8+Q9qi7o4vp4KcARxafxw?=
 =?us-ascii?Q?/bl82rA6ooGfbzeClPjWKeVPiY44M5xSQROKNp70hVFtZCyAV3iLr/h1Thz3?=
 =?us-ascii?Q?Wa2EaJPPLIl7plWNFZobj0G6Qb8xZL8X+fiTArVH/f5N1YX4tsn0GafYRDH8?=
 =?us-ascii?Q?4HWelixvUBjZyk4yrekgz3vV/+kJniPfcyQDhrtoHP0PNSN7Qjj6zc7Dt6xj?=
 =?us-ascii?Q?jFKeMrIz5qoQDdMPrF+Ys0SOIc/M4Z6TZXY5ITXiRwt5YA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l3q+EH+KzT3vPrlFuDfd9iFu1JCmK6NTtdg0bVyaynlcJLQT/tlou+xAJ1+8?=
 =?us-ascii?Q?NmctHM65Vqh98Lr4QzMhd8cXysPswsRyKgHhivEM6F2qGK2qcxiMPrhUTbRR?=
 =?us-ascii?Q?vO+PDejlV/VSXrzwqKemyUnOfgbbWrCHIt685qpdw5OASY2XE99eZhilQvMd?=
 =?us-ascii?Q?6GlM25X01r89fZppV5jdsGM4Msvf2Ym22ViDduRK4LBqhhyISHn3kbP+8qT9?=
 =?us-ascii?Q?R35APpMlK2jv8wQIq4m5LvfTayxHesQEgkqJEFWnnvSSzzS65uO00+wj4Ldw?=
 =?us-ascii?Q?ilq0mW9HGIlJqEzjZTlrh8eIuMOxEUHS81TwA44tSl0vJjfG/pvogF71QLjK?=
 =?us-ascii?Q?BuYCalbzLAgMvL/cdLQGJ7EMSbAn5+e2Atbc6xOd3xQ/V0qyisopF43P2i2R?=
 =?us-ascii?Q?8A4y5Nuvh93/kiNq5YuuwK5SX9rERFRa2hamtTXQQbEXQfuNGU3RAHcOxAIP?=
 =?us-ascii?Q?41jBAtawvx/2AyvLMY7UJxUH4PMJcIzqGaB5FRQ3e+NLKdVqY7L24b+5ve1J?=
 =?us-ascii?Q?qFIirc6H4ok5GZ0dgYmbLo5/6URj2VpNxZgHxNn2yyA3EXoP3/WPeAXzYFHk?=
 =?us-ascii?Q?Tr6hk9YlBpNc/YEMGY0U4ai1b6l3LmXVXdket93kibOpvV9zDUWSwiU7AdJR?=
 =?us-ascii?Q?v0W/irFYdxgLkQR7cltHOWJd0MvZB21hwVnEIuvUp0ED/lHwglTOs4CXHIrL?=
 =?us-ascii?Q?X7ebDUwrozP7mX0q7YIOUbVLdRWmv0uwRta3AzUHfMVbv0DFqepW1nNhn278?=
 =?us-ascii?Q?R8LZD+2HJ/D+x8c8rGYuS8+zynAvJldBct6hmXpS2rYtZ9NzsFZf4Jy/dK4D?=
 =?us-ascii?Q?k8Lmto7zky2AlmO1EoVqxtSCIthVUvAJh3VRfbjvlWiSMVidjhj5gEI9Kr0B?=
 =?us-ascii?Q?j85XKTtHoQJsCl08QgA5K/IDdZIclgmIka/SHM+5gOExFaKSstsylTa0bnzw?=
 =?us-ascii?Q?E4gnArX3tBKw97vjkGm1RG7m4AMf47xIuTC3z1sj3W/Qi+1z9j9ck1clr5jP?=
 =?us-ascii?Q?RrkLN6wsNoLwU5+VzE1yuCTTuFEg7wEzSaP8CtWcY4SbXGXzuui6SVXlhJ29?=
 =?us-ascii?Q?vVJvXmCw2KzERjbcB+hLx9SY5tWT5etJLGzjuYUJ+OcQQNJUyCBOmoTnbu1H?=
 =?us-ascii?Q?nfkSKfRNmbMLwBpW8Mly0W3mMAgFrkJg+TU05i+QdwzAgoYLhBbmXzkHWnR6?=
 =?us-ascii?Q?WagsuVYNLc56YPsCTnwLY36wzWESui39Jly127gXH/dxPk1u3Y6vV5aZRyhu?=
 =?us-ascii?Q?uiZGLcLNTfn7hMM5Rfxr6hcruK5XOocQhMrCkzpfRHEYGJWweUzeO5wIMtou?=
 =?us-ascii?Q?LcKAtISNax+94sqxUxLGC9Wj5i7qzPKG5sZPY+60i9K5hl6GQb/jTYGDpi6q?=
 =?us-ascii?Q?DaJHauDO441oeF2U/vEVKx5e/5Iz8uL4/feDVFvEBZKzX6TuIi+NmfXLFn3h?=
 =?us-ascii?Q?YVb7nqNyLVavm1cVi9olQBXSbaXVcgsIzRyMAcWlT4BZqYBkObyDn7HKTVci?=
 =?us-ascii?Q?A9XJiSuFQdrs9ILeQy6V9d3GxzPo8pbvQ64T/kYBr6xAMJMAJGDLJ18xODSX?=
 =?us-ascii?Q?1RwHaeX7sDaim9jO99kyyJXd+iUAFty0u5N+ARGIQAG6NbZIAAz+dv3/E9vl?=
 =?us-ascii?Q?+A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd618e2-ecf9-4bd4-13d4-08dd50aa99f9
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 05:59:41.5229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qMudu1hnRtzI487i9UYlM3Q6Yf9zVETBagFZMOXhzdE47s+vhXe2LhewJUDb/IL4G60QdrigrbJ6lTLnWUUWHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6778
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "sysfs:cannot_create_duplicate_filename" on:

commit: 8c8ac498a0c5d8e68247800639bfb554bb65c782 ("perf/core: move all of the pmu devices into their own location")
https://git.kernel.org/cgit/linux/kernel/git/gregkh/driver-core.git pmu_bus

in testcase: boot

config: x86_64-randconfig-071-20250217
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+--------------------------------------------------------+------------+------------+
|                                                        | 5c96041392 | 8c8ac498a0 |
+--------------------------------------------------------+------------+------------+
| sysfs:cannot_create_duplicate_filename                 | 0          | 6          |
| WARNING:at_kernel/events/core.c:#perf_event_sysfs_init | 0          | 6          |
| RIP:perf_event_sysfs_init                              | 0          | 6          |
+--------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202502191352.b65c904c-lkp@intel.com


[    9.537939][    T1] RAPL PMU: API unit is 2^-32 Joules, 0 fixed counters, 10737418240 ms ovfl timer
[    9.539489][    T1] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2c9477ac655, max_idle_ns: 440795235027 ns
[    9.555343][    T1] AVX2 or AES-NI instructions are not detected.
[    9.557309][    T1] AES CTR mode by8 optimization enabled
[    9.558531][    T1] sm3_avx_x86_64: BMI2 instruction are not detected.
[    9.574389][    T1] sysfs: cannot create duplicate filename '/devices/pmu_bus/power'
[    9.575589][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-rc1-00002-g8c8ac498a0c5 #1 95963aaeb84018cf4204d4190168e0e20d73ea75
[    9.575599][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    9.575602][    T1] Call Trace:
[    9.575604][    T1]  <TASK>
[ 9.575608][ T1] dump_stack_lvl (kbuild/src/consumer/lib/dump_stack.c:123) 
[ 9.575629][ T1] sysfs_warn_dup (kbuild/src/consumer/fs/sysfs/dir.c:32) 
[ 9.575636][ T1] sysfs_create_dir_ns (kbuild/src/consumer/fs/sysfs/dir.c:63) 
[ 9.575641][ T1] ? __pfx_sysfs_create_dir_ns (kbuild/src/consumer/fs/sysfs/dir.c:41) 


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250219/202502191352.b65c904c-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

