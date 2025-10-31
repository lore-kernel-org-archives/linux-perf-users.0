Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6F0280A58;
	Fri, 31 Oct 2025 08:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761898882; cv=fail; b=Bz2iyWz0s0FUnWE1WJlHaZJ+Z8iBSK/Nk8B5NAmLMf3R9p31duhu259Ptq/xv598SROucLUoZrALF5oDRWgxv5jVtXn9sGq3g9mxNQsnX3BiOcJsZIbyyEYxwNev/UktV0Pla4ZlJlallJLU97+H/DqIkN6qO/74PmaTfbaK/Yo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761898882; c=relaxed/simple;
	bh=nu8I253TTGTaDJ3xZXgrSCw1f6w3NjZukWfuzSstoPs=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Gsg5zQJ0h1uSSgtEXt9k27J3mQPU2nxwuo4G55DZCXeDrVCP7DLoa9vRV+Ggk+cnvZnl49p+jK2ITWaVvFF8MR3/phwtmJLaKkFF8w456g6pqQGIFQV+So2qg8btGUjtRbDCxpsxfAxOnheNeszazYiGf0Jp5lY52SCtrC0Bo78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ASbzIGIr; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ASbzIGIr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761898880; x=1793434880;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nu8I253TTGTaDJ3xZXgrSCw1f6w3NjZukWfuzSstoPs=;
  b=ASbzIGIr09+5ursdL64gAkY7ldetMWV6sBpZQNmqIHAFmBGqKxDzYbQQ
   BZKcvpHAX+QXTfNAL+ExYYXCdq0+kXX3ox+X3VBTJjulZV0/1oZV3Boid
   YkYGkyR/mkPXCeEB7dTbksAo4Jafjy5lS0HAtLvTfJMDxXME6HeZgScTT
   shEM1IOyX1nyBxlMxgk4AlPUXf3m/WcQA6p/yX0SlmCR/xz1ImhKH1qmZ
   3hANI13bCs8s1HqpRT7cqL2YOM7zWEa3hOk1fy5bqLBD8rgOd9FeGMTVJ
   kOsiWpJOtC/jq7/B0mfa73YXNidPzz7oyxUHKyTs/Z6qhGkNI0qaBx9Hs
   Q==;
X-CSE-ConnectionGUID: +tegiQLATUinTQmdQ6o9nA==
X-CSE-MsgGUID: tBhqYEuvR8Gy554Axu4VYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="75403047"
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="75403047"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 01:21:19 -0700
X-CSE-ConnectionGUID: QNW+Y2tCQZGlfHrfObebAQ==
X-CSE-MsgGUID: f83GuEWcSQasfgWK0wHljw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="185836769"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 01:21:19 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 01:21:19 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 31 Oct 2025 01:21:19 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.46) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 01:21:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nfw+KgGY59ILP84ebtcI32uAgYKLSSlE7u9yKfOz4gQfwiyF2aukJJY8sK9BpqLEGqoCSHKIjqjIqJXMEGx1Fuw2WoAxDtdRDxsB4ysNUMSEEgAqBiziNAJbwcKKbSj92gS5xMIwRvZ4dqrMDko2r/2wrcl7E4q8o6rcF8fQm/AQSKoV6d+hClB/2Fm3RvpBht73pacvVYzEps3F2qWX1N9jU57hrHB1JrxLp4ooGZyTvsgaIkAZePaMIdKkjr4X7IDqAH+F1ZNilxAcQHSPzEJ98/PiSR3Ek2k4i1sricVC9MgTa0abCZt5BoCPJ70/CpIPmNrAoJ4TbYxIHtYE7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9Pnqv5Vtmpu8fFmqVP18gZKRhJNnCs9jCOYC4zeRmM=;
 b=nLf0EC1DOjkUYZxpW0KHOocfM92bPQgkRs08gvM0oNgmhRLdsPOfgbF0z4WMonB2q/Dn/pIgC+0nPPZ67towqbti5k9EnM/HoKbPNBAZdhQMwxS2Mn0w/VxjVVglAqpyFDMPemotcm4PIoYE/mb5r3jW8KSP4uSVop8dYpfjS2BBA4SE2gK1Xjw8Yj9shsXTH1SGNIWlZy9gsJhNZyoN7j8kqrpMbOfs/tPqn250tWnwqh/nmgJi4C5C4UZHM99EaUPeSph6BtvO66F2amB7uzU7meync5tba8FCXs4vR/iMFOy7/wBZt8dlxm0Rzh/r3zqI86eqk4sE1cR4rrz5hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH3PPF4E874A00C.namprd11.prod.outlook.com (2603:10b6:518:1::d1e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Fri, 31 Oct
 2025 08:21:17 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 08:21:17 +0000
Date: Fri, 31 Oct 2025 16:21:08 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Lorenzo Stoakes
	<lorenzo.stoakes@oracle.com>, <linux-perf-users@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [perf]  448f97fba9: addition_on#;use-after-free
Message-ID: <202510311606.76b65d2b-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR06CA0216.apcprd06.prod.outlook.com
 (2603:1096:4:68::24) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH3PPF4E874A00C:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dd64ae8-3df5-4620-fd8f-08de18567676
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y7kD3bwyqqwBpsLHhlFeMt5a2f5OQ7C09ChknZY8GeZMvnWpQoX6kpsC/crH?=
 =?us-ascii?Q?EhTrYzJBoZRtE7yORjcOItR4v+utElJmcGPqEWoAus53HV9JcJm/I3SZaBk9?=
 =?us-ascii?Q?ZYc5SkGm9PjfbW2EZkk/EQKSeUNJoKVerRuoc/JYXiZvLb6G7xAt0pmZgmya?=
 =?us-ascii?Q?PVY1b31YcdXPtdJqH105AEq97TaLup5zh4x/e3indJWv87AfoEBAlocuJrxE?=
 =?us-ascii?Q?YbFlzjpN+0YR5nkZKj62ujENc43St5klAp0dri8M3LSd2B9UmoICaqmCYU6J?=
 =?us-ascii?Q?WaRELCBFwPWhowCmlAQnQCF2YaYFMQPIZp3pejLEY283cQ1oKIfsau/Pbfy4?=
 =?us-ascii?Q?ChF9KYyuJ8QjZJa/s1J45CH6923rnV0QYmoRDBxbHhsRuXL4SLhewzVgV7dt?=
 =?us-ascii?Q?LF2eljvDzCvhaKdl7IuLD/pbOz2z5KClSyceJTlsK5qyMa0uSWl1SJzgUkis?=
 =?us-ascii?Q?5NWHvtbWHK58Oh1uUXAs4vuLNa/72eXMLZZDQi/N6I3ktH2s2fZ9Fg5dDtSj?=
 =?us-ascii?Q?bqn4NqRhilFUr5uEGU2S5TsKTN7gDNd+RTj4mMXqdwIeih67gncIwtGFxAp9?=
 =?us-ascii?Q?Q2EUcv0jPQ0FDCTVfPkqcDacSBLv5Y90Az+V62mbgmXhy+bp4aMRm3oujHqx?=
 =?us-ascii?Q?NO0Yr6auVRlNgm4rIdMcvidLI7ltT5XbwFjEKGmxMLk9McDH2RqYwDWyTgtj?=
 =?us-ascii?Q?0IRL3LdGXQ39OrSvNMDPdb97/tz5n9sVXUu2qBKYppeCUy/+DLyzU677X9KM?=
 =?us-ascii?Q?SDYCcZsd1D5hZW7vn/3QvYWRCKK+Xl/PxT1M9T24S/MdfPHOIqrh6S8V7ICB?=
 =?us-ascii?Q?dJddF+OkwWL9bHKn7DvQ4/eZ475kGKTet49IGKfmddU9YfC1f2b+W9qq0KvT?=
 =?us-ascii?Q?bar5M6hM7G0x86F27Xx6R/KiuZjSBttJxgDk/EaAoHLqmwF/h29RVISE9Il5?=
 =?us-ascii?Q?Y3j49WDfJ9/xU9N7hs9J5cK6QQKXoK3vwIuAQOClaKBrlaRgO1elVxvmM5eQ?=
 =?us-ascii?Q?IagJWOHbPLIbSZRLcwxkKqYC/WTfdhWlYDUlYRJVxn5g98Dkw/xEODBeyK0G?=
 =?us-ascii?Q?8do5BVo/J5OsKkfEitD349rAWY18ZaTyBjdoPYurPJj4g7uy02CriWQsW6Tn?=
 =?us-ascii?Q?drleEzbz89GfXznxOL1USjPa8jAbttXkswd1t6yvbHKZ5H3v+BKNSrdia+E5?=
 =?us-ascii?Q?j4PqAxHW+qlVjeHuF8X3qc1HkiwTdmmt9PcE1AJfHQbKor/GXs6BLcWfND1/?=
 =?us-ascii?Q?cZR+Dl8uTE1dLxeTS59/6STBbOLL11RMZ8G7r71orwF+K31gd9OP2UUZqBON?=
 =?us-ascii?Q?ZN6ua7gLqY1qLmVvadwv8r9qpKhsFK3TjCrccf43bXz6kW2COHAotO/a61V/?=
 =?us-ascii?Q?wVs62eK34O6biP2EZU+2yEkS7kmak4I+fdXR9EmgeOYxL3UmMbIttuoxBbJ5?=
 =?us-ascii?Q?zoUEeFGgjLCmAhFKWTGwY43nTFFCEZp9uDYGkyobiHN1hVQS++d7qw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dvk349EQs8Kr48DGK4BQNa1uQ+Iv0p/yTrklx4qkRNUSN193htkCX9qgMz5D?=
 =?us-ascii?Q?8dLHsiSUzCYfwM+nNzgnDDDYmTlnL1zdu4+8VGB46+auJ4k+4qVi58S0FAU+?=
 =?us-ascii?Q?0pv07x19d1PVKYVgPLeVNJZcs10/Y/7yh62PahUxyKKR1L2EH5Fjp0OXyyEv?=
 =?us-ascii?Q?wNYnGBXH8M2aJevrOg1P+LMmRJpnXauT7Qbu5luUd/aKWBc0G5rCvu6tSnYb?=
 =?us-ascii?Q?upyyZhMi4IuGuxa6n1IJ3q9U4SM1OmI/TJbvQnZLuQhdDG2UaCoB32ERQaIC?=
 =?us-ascii?Q?Bff/zYNwEaaDd42K6v8fw9dErqiyVTwUxviIIcorUzmntUmL/+OE6qj0SLBv?=
 =?us-ascii?Q?3qIF0xq9WiFk/vN82HYMw+iq772g4x2xw85ejsGoj/9zEJKe3prJBNP40xyw?=
 =?us-ascii?Q?oChQxu0YMMNaSs2PRPDO0FfMqzcBuWBziyRKeth4Gyh2RyV87wRMSQel7WBT?=
 =?us-ascii?Q?zdp25rlPLaS+S9g4to2VEhFYvk4ly44n+lBfX55QqXTFcJYBrQiIYak/+0Fk?=
 =?us-ascii?Q?KwiW1hCAQhYUo6PlOLD5zzxBSJFkIDBqrFphqksWou/TP5Jcn+pPnxkyalNG?=
 =?us-ascii?Q?rK3pgICh86p76CGM1BaZhq1rsvkzkQkIHNr5tRUpP3SsRg4b66y5csmUhPaU?=
 =?us-ascii?Q?qz/AQzUYPdFk8c/fahwkIv//GRruH1RYORJ0ZNV1wtWuuCCOzSrnYRWATGSi?=
 =?us-ascii?Q?IyV/I2TjhcMOyat7/0x4Ln1D4o/nI/zmn/DAGqg7owONoTwOv9SV0Tjio1Kv?=
 =?us-ascii?Q?7SRRxY9uhm5NxMdoYSS+oadgoEdocozffTKLe3Pej1i8TgOHrD2nXICNVCJy?=
 =?us-ascii?Q?4mChQ7I6ZEMtki4g5e4CCPR6tbMGK9O+wtuse+KBHIOS2FB/8Swbu1PZQGqE?=
 =?us-ascii?Q?rBwgm4cuJVHoMzi13phU0osRodmDrkq5w9BgNAqfEQMXe+/bILBbSX0ecK7e?=
 =?us-ascii?Q?g/QVTQnnhlL1hy++3lGFTnL697h12aEETY2k6oCvd83ZU3m280WGjy3r3RPt?=
 =?us-ascii?Q?4gzEAbrPH1QMBH2CFNFxv0tY+1jx1XB8edD09Zw26yPh/l/W6uqmxQ++DBtm?=
 =?us-ascii?Q?tG9XDx1Lh3rU9dwH2yulJCPrNCFbmviQDdKs4ZhN61U61N3SihGuhtSVTlvd?=
 =?us-ascii?Q?+ZWtlnStsUHVmXDpuHMWkofbQ/Q3H7TS/E29Bgucf1CYy2NzgP0oXWeYHOYY?=
 =?us-ascii?Q?RLLNCQNXXhIXIZE2ojBxlYCBLGFttb432n+7JsQ2b0vHt4JZyZVHoyvwiljZ?=
 =?us-ascii?Q?vY8+fDJuy6xks01Ftw/UotYlRHHdJ11zOAncgaP3b+91sfkp+UuPnZ5SFHbn?=
 =?us-ascii?Q?ZtJQMSmiScfB2YMmBRRSxYA2aEZc8fEAEuVhCRxl8s9tH0CyQPEdbdblTI2k?=
 =?us-ascii?Q?BQkhOSX6lMO065apt3eR2rR2QVKn0A52n/V1w0fdfqqrPWkHLlJPNNn4mw5r?=
 =?us-ascii?Q?KBGfbXw0VyM7SW3xYgvjb4Ov+QjZ0T3ROnrfXe3sf9jrvC+sty2dczZRz5nk?=
 =?us-ascii?Q?zsHyGyBIQeOfvHdFLRgMnPj/WxYwb7chXnrsrlwwJ7SctezQ62Q+TX/ZxQdR?=
 =?us-ascii?Q?CUguDU9K2tKAj1f7mUkWUva4bCLAYgW7W0Pyo30weE5XCKBYJYhRypZbmjP8?=
 =?us-ascii?Q?6A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd64ae8-3df5-4620-fd8f-08de18567676
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 08:21:17.0274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ahnR19saQSLvUgdhZ9pknKQFWwPtTPBh0VI/TrKvaDnzaRseAldujqphz78fJmvqCUh2FIkimt3lEmjbVmQUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF4E874A00C
X-OriginatorOrg: intel.com


Hello,

kernel test robot noticed "addition_on#;use-after-free" on:

commit: 448f97fba9013ffa13f5dd82febd18836b189499 ("perf: Convert mmap() refcounts to refcount_t")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on      linus/master e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6]
[test failed on linux-next/master 131f3d9446a6075192cdd91f197989d98302faa6]

in testcase: perf-fuzzer
version: perf-fuzzer-x86_64-54251c2-1_20251010
with following parameters:

	runtime: 1h



config: x86_64-rhel-9.4-bpf
compiler: gcc-14
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4790T CPU @ 2.70GHz (Haswell) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202510311606.76b65d2b-lkp@intel.com


kern  :warn  : [  316.770155] [    T746] ------------[ cut here ]------------
kern  :warn  : [  316.776217] [    T746] refcount_t: addition on 0; use-after-free.
kern  :warn  : [  316.782957] [    T746] WARNING: CPU: 6 PID: 746 at lib/refcount.c:25 refcount_warn_saturate (lib/refcount.c:25 (discriminator 1))
kern  :warn  : [  316.792896] [    T746] Modules linked in: binfmt_misc snd_hda_codec_intelhdmi snd_hda_codec_hdmi btrfs blake2b_generic intel_rapl_msr xor intel_rapl_common zstd_compress x86_pkg_temp_thermal intel_powerclamp raid6_pq coretemp i915 sd_mod sg kvm_intel snd_hda_codec_alc882 snd_hda_codec_realtek_lib snd_hda_codec_generic kvm snd_hda_intel drm_buddy irqbypass ttm snd_soc_rt5640 ghash_clmulni_intel snd_soc_rl6231 snd_hda_codec regmap_i2c rapl mxm_wmi drm_display_helper snd_hda_core snd_soc_core snd_intel_dspcfg cec intel_cstate snd_intel_sdw_acpi snd_compress snd_hwdep drm_client_lib ahci libahci i2c_i801 intel_uncore drm_kms_helper pcspkr mei_me i2c_smbus snd_pcm alx libata intel_gtt snd_timer agpgart lpc_ich mei mdio snd video soundcore joydev wmi acpi_pad drm nfnetlink ip_tables x_tables sch_fq_codel
kern  :warn  : [  316.869646] [    T746] CPU: 6 UID: 0 PID: 746 Comm: perf_fuzzer Tainted: G S                  6.17.0-rc1-00015-g448f97fba901 #1 PREEMPT(full)
kern  :warn  : [  316.884174] [    T746] Tainted: [S]=CPU_OUT_OF_SPEC
kern  :warn  : [  316.889845] [    T746] Hardware name: Gigabyte Technology Co., Ltd. Z97X-UD5H/Z97X-UD5H, BIOS F9 04/21/2015
kern  :warn  : [  316.900399] [    T746] RIP: 0010:refcount_warn_saturate (lib/refcount.c:25 (discriminator 1))
kern  :warn  : [  316.907362] [    T746] Code: ed 48 ff 0f 0b e9 72 ff ff ff 80 3d 2d 28 78 03 00 0f 85 65 ff ff ff 48 c7 c7 e0 6d 18 83 c6 05 19 28 78 03 01 e8 d1 ed 48 ff <0f> 0b e9 4b ff ff ff 48 c7 c7 a0 6e 18 83 c6 05 fd 27 78 03 01 e8
All code
========
   0:	ed                   	in     (%dx),%eax
   1:	48 ff 0f             	decq   (%rdi)
   4:	0b e9                	or     %ecx,%ebp
   6:	72 ff                	jb     0x7
   8:	ff                   	(bad)
   9:	ff 80 3d 2d 28 78    	incl   0x78282d3d(%rax)
   f:	03 00                	add    (%rax),%eax
  11:	0f 85 65 ff ff ff    	jne    0xffffffffffffff7c
  17:	48 c7 c7 e0 6d 18 83 	mov    $0xffffffff83186de0,%rdi
  1e:	c6 05 19 28 78 03 01 	movb   $0x1,0x3782819(%rip)        # 0x378283e
  25:	e8 d1 ed 48 ff       	call   0xffffffffff48edfb
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	e9 4b ff ff ff       	jmp    0xffffffffffffff7c
  31:	48 c7 c7 a0 6e 18 83 	mov    $0xffffffff83186ea0,%rdi
  38:	c6 05 fd 27 78 03 01 	movb   $0x1,0x37827fd(%rip)        # 0x378283c
  3f:	e8                   	.byte 0xe8

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	e9 4b ff ff ff       	jmp    0xffffffffffffff52
   7:	48 c7 c7 a0 6e 18 83 	mov    $0xffffffff83186ea0,%rdi
   e:	c6 05 fd 27 78 03 01 	movb   $0x1,0x37827fd(%rip)        # 0x3782812
  15:	e8                   	.byte 0xe8
kern  :warn  : [  316.928851] [    T746] RSP: 0018:ffff8883fe0b7670 EFLAGS: 00010282
kern  :warn  : [  316.935833] [    T746] RAX: 0000000000000000 RBX: ffff8881dfe99ba0 RCX: ffffffff815808ea
kern  :warn  : [  316.944745] [    T746] RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000000000001
kern  :warn  : [  316.953661] [    T746] RBP: 0000000000000002 R08: 0000000000000001 R09: ffffed107fc16e88
kern  :warn  : [  316.962585] [    T746] R10: ffff8883fe0b7447 R11: 0000000000000001 R12: ffff8881dfe99ba0
kern  :warn  : [  316.971497] [    T746] R13: ffff8883e42f3b80 R14: ffffffff8452af00 R15: 0000000000000002
kern  :warn  : [  316.980445] [    T746] FS:  00007f0cc151f740(0000) GS:ffff8883e1814000(0000) knlGS:0000000000000000
kern  :warn  : [  316.990282] [    T746] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kern  :warn  : [  316.997804] [    T746] CR2: 000055d13d833000 CR3: 00000003fec60005 CR4: 00000000001727f0
kern  :warn  : [  317.006694] [    T746] DR0: ffffffff81000000 DR1: 0000000000000000 DR2: 0000000000000000
kern  :warn  : [  317.015594] [    T746] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
kern  :warn  : [  317.024478] [    T746] Call Trace:
kern  :warn  : [  317.028657] [    T746]  <TASK>
kern  :warn  : [  317.032479] [    T746]  perf_mmap_rb (include/linux/refcount.h:289 include/linux/refcount.h:366 include/linux/refcount.h:383 kernel/events/core.c:7001)
kern  :warn  : [  317.037867] [    T746]  ? __pfx_perf_mmap_rb (kernel/events/core.c:6975)
kern  :warn  : [  317.043770] [    T746]  ? __rcu_read_lock (kernel/rcu/tree_plugin.h:391 (discriminator 1) kernel/rcu/tree_plugin.h:414 (discriminator 1))
kern  :warn  : [  317.049419] [    T746]  ? __pfx_mas_preallocate (lib/maple_tree.c:5525)
kern  :warn  : [  317.055590] [    T746]  perf_mmap (kernel/events/core.c:7159)
kern  :warn  : [  317.060631] [    T746]  __mmap_new_vma (include/linux/fs.h:2289 mm/internal.h:167 mm/vma.c:2413 mm/vma.c:2476)
kern  :warn  : [  317.066168] [    T746]  __mmap_region (mm/vma.c:2669)
kern  :warn  : [  317.071635] [    T746]  ? __pfx___mmap_region (mm/vma.c:2641)
kern  :warn  : [  317.077624] [    T746]  ? mas_prev_node (lib/maple_tree.c:4493)
kern  :warn  : [  317.083239] [    T746]  ? mas_prev_slot (lib/maple_tree.c:575 lib/maple_tree.c:4415 lib/maple_tree.c:4566)
kern  :warn  : [  317.088885] [    T746]  ? mas_prev (lib/maple_tree.c:5884 lib/maple_tree.c:5877)
kern  :warn  : [  317.093923] [    T746]  ? mm_get_unmapped_area_vmflags (mm/mmap.c:806)
kern  :warn  : [  317.100703] [    T746]  mmap_region (mm/vma.c:2743)
kern  :warn  : [  317.105999] [    T746]  do_mmap (mm/mmap.c:558)
kern  :warn  : [  317.110943] [    T746]  ? __pfx_perf_mmap (kernel/events/core.c:7119)
kern  :warn  : [  317.116588] [    T746]  ? __pfx_do_mmap (mm/mmap.c:339)
kern  :warn  : [  317.122045] [    T746]  ? down_write_killable (kernel/locking/rwsem.c:1320 (discriminator 3) kernel/locking/rwsem.c:1331 (discriminator 3) kernel/locking/rwsem.c:1603 (discriminator 3))
kern  :warn  : [  317.128164] [    T746]  ? preempt_count_sub (kernel/sched/core.c:5845 kernel/sched/core.c:5841 kernel/sched/core.c:5863)
kern  :warn  : [  317.133953] [    T746]  ? down_write_killable (kernel/locking/rwsem.c:1320 (discriminator 3) kernel/locking/rwsem.c:1331 (discriminator 3) kernel/locking/rwsem.c:1603 (discriminator 3))
kern  :warn  : [  317.140084] [    T746]  ? __pfx_down_write_killable (kernel/locking/rwsem.c:1599)
kern  :warn  : [  317.146549] [    T746]  vm_mmap_pgoff (mm/util.c:580)
kern  :warn  : [  317.151956] [    T746]  ? __pfx_vm_mmap_pgoff (mm/util.c:568)
kern  :warn  : [  317.157859] [    T746]  ? lock_acquire (include/trace/events/lock.h:24 (discriminator 2) kernel/locking/lockdep.c:5831 (discriminator 2))
kern  :warn  : [  317.163208] [    T746]  ? rcu_is_watching (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/context_tracking.h:128 kernel/rcu/tree.c:751)
kern  :warn  : [  317.168713] [    T746]  ? __fget_files (include/linux/rcupdate.h:341 include/linux/rcupdate.h:871 fs/file.c:1072)
kern  :warn  : [  317.174075] [    T746]  ? __fget_files (fs/file.c:1075)
kern  :warn  : [  317.179445] [    T746]  ksys_mmap_pgoff (mm/mmap.c:604)
kern  :warn  : [  317.184883] [    T746]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1))
kern  :warn  : [  317.190002] [    T746]  ? do_syscall_64 (arch/x86/entry/syscall_64.c:113)
kern  :warn  : [  317.195394] [    T746]  ? do_syscall_64 (arch/x86/entry/syscall_64.c:113)
kern  :warn  : [  317.200773] [    T746]  ? do_syscall_64 (arch/x86/entry/syscall_64.c:113)
kern  :warn  : [  317.206098] [    T746]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
kern  :warn  : [  317.212575] [    T746] RIP: 0033:0x7f0cc162ede2
kern  :warn  : [  317.217550] [    T746] Code: 00 00 00 0f 1f 44 00 00 41 f7 c1 ff 0f 00 00 75 27 55 89 cd 53 48 89 fb 48 85 ff 74 3b 41 89 ea 48 89 df b8 09 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 76 5b 5d c3 0f 1f 00 48 8b 05 e1 9f 0d 00 64
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 0f                	add    %cl,(%rdi)
   4:	1f                   	(bad)
   5:	44 00 00             	add    %r8b,(%rax)
   8:	41 f7 c1 ff 0f 00 00 	test   $0xfff,%r9d
   f:	75 27                	jne    0x38
  11:	55                   	push   %rbp
  12:	89 cd                	mov    %ecx,%ebp
  14:	53                   	push   %rbx
  15:	48 89 fb             	mov    %rdi,%rbx
  18:	48 85 ff             	test   %rdi,%rdi
  1b:	74 3b                	je     0x58
  1d:	41 89 ea             	mov    %ebp,%r10d
  20:	48 89 df             	mov    %rbx,%rdi
  23:	b8 09 00 00 00       	mov    $0x9,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 76                	ja     0xa8
  32:	5b                   	pop    %rbx
  33:	5d                   	pop    %rbp
  34:	c3                   	ret
  35:	0f 1f 00             	nopl   (%rax)
  38:	48 8b 05 e1 9f 0d 00 	mov    0xd9fe1(%rip),%rax        # 0xda020
  3f:	64                   	fs

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 76                	ja     0x7e
   8:	5b                   	pop    %rbx
   9:	5d                   	pop    %rbp
   a:	c3                   	ret
   b:	0f 1f 00             	nopl   (%rax)
   e:	48 8b 05 e1 9f 0d 00 	mov    0xd9fe1(%rip),%rax        # 0xd9ff6
  15:	64                   	fs


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251031/202510311606.76b65d2b-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

