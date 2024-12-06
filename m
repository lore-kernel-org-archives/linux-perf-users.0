Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7644E196C6C;
	Fri,  6 Dec 2024 06:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733467122; cv=fail; b=Vagj9wccERCY4ncqpXw78lgv69BR7IYRuL5eHE7Y+W510C97f/bVm0NGW8AoKIBRGul8ECOAJcE9oSK9PvMc1tZrvPAawuJXhzLGGJowT6JU2Ipt7d0aMAVHaUby8+TdQ8DlNX0ELvdP7dv2EBqQD8tclVdn93ohVIDW7uXlUb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733467122; c=relaxed/simple;
	bh=bn6nXfvaXqmirN7f54YdnRX6xn9qIy065KTNJ9OsygU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=dcvuEBQQsD9fSros5JPwjja1OmG+QqP/IXmFCVy8pXSB7m7tJ4ZCnNnF5yo8Y9ChY9OKxrK8vBFeLXQkJLVA9u9Ub2SbnvKWlpmxt/dSXjUCmPplfutsyI8Iint+QFiy6E54qqQyYKbyf2CJKaRjOc5RfB90nW7wXgHVmd52v+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=APrBI8bz; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="APrBI8bz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733467120; x=1765003120;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bn6nXfvaXqmirN7f54YdnRX6xn9qIy065KTNJ9OsygU=;
  b=APrBI8bzEBRAXQrZ4wOVGNPAMhQqIxl3SW3hy0lDqvKczOLeyP2aReU4
   5gneTFAR15uGLrWSGGLzi3UIME8tXlIEFmTPIUwccpIcTzFWoNJjkTdok
   /fryoWGbv9R3/+kCp831KmYs6fcRDr3TX+15Lc94iWwvd8mYdASIdoJz/
   6++K0zH67regHD7MnMrbHm17w8wtdc0bvYk8F60uj0loTStYXeFcXQ9Px
   HzYjHq9Tzz/UET4MMKEGRkKMeleHS6ReyEn7GmKpNTGCzyCoMJwmN3OAx
   Hi0vlQPmim3uFG33k8OfNaYHD2xsbfZMZl0+mR1qQ6lkaJj26bvr0sFu/
   A==;
X-CSE-ConnectionGUID: hANUOHqTTHqH8VTrhf2RXg==
X-CSE-MsgGUID: jesI/ZJRSXKgFMc/f8RuNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="51225726"
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="51225726"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 22:38:40 -0800
X-CSE-ConnectionGUID: JM4xdJvZSwuHt9ah/ZARoQ==
X-CSE-MsgGUID: bCSpxeKRTh6QnAfFrmw6ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="94126289"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2024 22:38:40 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Dec 2024 22:38:39 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 5 Dec 2024 22:38:39 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Dec 2024 22:38:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GdTXIhd4lWkKjAI/4ByWqWnWZt3+WFdI7uNRLPBnnKtB6Xw0a9gZZ2SqDDYa9mBlCtK9s3/p/a6WvlwEFbc2DubqViQHUeRkml+ciHbCO+HmDwsBuU2mif0iEYki2cmFZqL5CqyWXVQ50M5SNXlkg0jSYmOn729HiEULMVUacAC3enCxNqhpIJEry+3ixTVUkuT/xGXnnFgXbl9elZMGH/hpPmFGdN48cHf3Sgn7+P/+5KBV/nNnll1qYh0GauHopOnfy2R8PF5rw2d9Jq6osPhtTKIFiZbbNpYJUQ8hboVPx00EsunXn2HB+tMd+NqBQRDMdjPS+0fZ1H/c4z5NuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lGlX3NZSVTI1Or5ZCyL7ZRMj05WFkNOzE5ZnAcAgM9U=;
 b=L68prWqzmxD5Ae0YLKzpC1b4LUAe4IKN3SOtGkIvR813a+mzsDyzwGFBcKbnSF2YNjQ/E8L3I6xWCh4sTi2FsctnoCBM2FPj1WHrd8xVWV5LYCJpPGHNaFTkGOuDR4bcFsP9kGgO5kHY7kOd6LVIpwEPuzF9AU3n3CzNWVAIZNq95Fo9A9dQ64RpaaD1eariXh+PgFHPpdjY6DHcAovhRuy5cLv0WEH4LfsIps69OYxsdE/5J1T7P1tZ+cT3LwGaRbWdkL/xU+cv3UgpADFiVkd819NyepJQBdKQ5njGlfqQIWhT86VcHNkDMd0sC2TJVS3M734i5Qy9xVkkNqb7WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA1PR11MB8785.namprd11.prod.outlook.com (2603:10b6:208:599::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Fri, 6 Dec
 2024 06:38:36 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 06:38:35 +0000
Date: Fri, 6 Dec 2024 14:38:27 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Namhyung Kim <namhyung@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Ian Rogers <irogers@google.com>, <linux-perf-users@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [perf test]  e2cb1db7da:
  perf-sanity-tests.perf_all_metrics_test.fail
Message-ID: <202412061343.42b071db-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0110.apcprd02.prod.outlook.com
 (2603:1096:4:92::26) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA1PR11MB8785:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fd7174b-74eb-4337-f81e-08dd15c09c32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vYe8V0lJGSn7ZVjHvxdDjn2VN6q/HUy9hnpeSWZZb474qYAVbGBgnZw90LVO?=
 =?us-ascii?Q?Ut1tesvOBDvn40BfAuwCN7+KX01OG15j6DhaCSkJktYl0hzINNwVkxh3z/PL?=
 =?us-ascii?Q?5KWxd0onX3taCwVUBnyGH+0lvuvoepEFKF7VFP4Q1yWwz5+IANkGvm4z9GBr?=
 =?us-ascii?Q?8U3GVQ43J2L1LSucsC5Dkiz5Admn29rcT+8u8OguCSD/b0DIKhjHJxZcxvkr?=
 =?us-ascii?Q?PacXJfOGZjcqVNhwHQ+czfZP4kUzjxJjKS3ABUR+43MMJ6wSf6MR0LfuRKP1?=
 =?us-ascii?Q?e0Zq/eH4MD5Lo7e8ppHRG2878za3ykKKHOpmLISGQLGdZhkXZ9RZ6+oQVb6G?=
 =?us-ascii?Q?Tpe/jUgVuOGOv3tiu+SHvumGdu1FTq07AX04uNcEEdROcBpbfJXqUjCOg8KP?=
 =?us-ascii?Q?Y7Zlzhr8slYnmIZzWqkT1W5iJZvNEH31CcIO48jwfdq1ED2rP8s+PyEk7JC3?=
 =?us-ascii?Q?/eDwulfiabh9Xpi+nwDDJh2A1dBitlXX2JE/eGcvwKHimdG2qiZJSiMTM3nC?=
 =?us-ascii?Q?rXDe/mGgaM+WkiexQOI2vKTd9SOGCS0CfR0+Ln2ei+RTurGfzCS27/qqNRhz?=
 =?us-ascii?Q?QClF7v6EJvGBe2lwsuAiKZOT+2IXPLQuVpAvTxBVgtlUaGwFAv4UOycYLw6Y?=
 =?us-ascii?Q?ORYcuNJ6jqi8mC8H9NXiywsVvafEoz/HzTifVbFlL7LfUKikOcRBvy/5xO7B?=
 =?us-ascii?Q?w0bJQRjClFujMaZ1YAwwPyIxHKC0vpXvM+f9tyhdd3lbRK2YHPpiFCy1L99G?=
 =?us-ascii?Q?Df9uhZmgC4XiCLxPFdjF0JRSffxVv1jJvMzFGlSKzMIjuZyYiw26dfDRsYHm?=
 =?us-ascii?Q?N/lODQsUuyDDPjRdAMIR/mDdvSlfkS1iux/0wudoLqUCvKQAX9eigVDnXbyv?=
 =?us-ascii?Q?EzFRj4V+QDAtTMJ2VFTe0+kfCkBSYWhZrRgjYjldl1Yb2zA5X+76PQCxJA8g?=
 =?us-ascii?Q?Fa0pW21IGboe00trfud+jTy3cNK749ArJNktQFuFfZ+bdNg1SjnlcwztwgRc?=
 =?us-ascii?Q?1GQEIissyfU0qR0rML41wCxJVuT780noSnTrCYhYTTCk+3mFj5JZfp0Jgd9f?=
 =?us-ascii?Q?WqoVNAAKhbdma+xd8YbY8E1jc7wXEZ9ZOTH2o9h5TXW3Vhg/xKv9QpGGSs6y?=
 =?us-ascii?Q?8exRK74sk3FdpFW4shyunUGeBVLS7okpMogPjgLYDmDI7VgbpoVgaFdEd5nD?=
 =?us-ascii?Q?vkBc2JwwXSpUPsOzVefaumPFQ3w9bLx5jGisJ76KOqn/WJir8WLh04qrauu4?=
 =?us-ascii?Q?UavKsAbhFnTo+X9eWUyHG73+u5Fw+HWOdMIQJ3GIhrBO/QXE/MtnfgzE6Qyw?=
 =?us-ascii?Q?4/E0IVuQtCVf63171SRWkWbI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fDr97SEp69tkp9zE0AdEUUKb9+gSJxn9XSx5Z0YnZ+yoH9qYoDV2My94rr28?=
 =?us-ascii?Q?7PdnVOEL3+E9QzsJl7e6UQOc3Jo50iNbXOYwByEKkWEP3NHNaooxmnlO2LJK?=
 =?us-ascii?Q?4G/XBqrS8eKX7uJ4i3P5I/VmeB0LLXmwmLFy2JcpZ9cnP6DXQhNeT4xMoA0T?=
 =?us-ascii?Q?DjCbKl6IaaY2s1WPV79sl0Af2VhIruF9valJnR1N9/bPpDbm6P/P9gJ4phOR?=
 =?us-ascii?Q?Bmtym5ybQR4dHDCYN7iYJ73VrZ/oIu7NIYM9pZNsS+fLx/67Vj/65IZn8PNi?=
 =?us-ascii?Q?lffQ+deCTFPdJ+ilXfSlG0eHxN7XYUK1dlSFKyXukuExZ9Qq1sswzJ1DFz5U?=
 =?us-ascii?Q?7JvAFLmQNtxMZtgNIaXNpIcEj6owSXpqxbLmtdL0MAFQ3IrFdp8OXqWJA+t9?=
 =?us-ascii?Q?OKNDDHTAhy9eCxsrS5KAKXhtdT2fv2Y2PnaRv2g3mkbL+clP/e3X4Dw5noN0?=
 =?us-ascii?Q?qu91BUuP2FrwyKS1ZQSYRHpZNonl6V/GMEhg2Cfr+LyYHIrXKud3ixBctDXJ?=
 =?us-ascii?Q?w0pxMn7/9//km+X0EUJnEkY1WQaNMHvgGju8ejjuozV0GHHkE2LaTGAIio7E?=
 =?us-ascii?Q?HW0N0T/Nk3Gx+w4QiQhMZepcaBNEc/lT3GQjG9d3yg1XkufzgCvwOhtHuVCJ?=
 =?us-ascii?Q?SKPRmA4PgKDEyRqVDvxU8WF7cee8WBERfZU141k3rc4RAxylwGz2CYJKHuL1?=
 =?us-ascii?Q?I0xIMOBgnmaG2ol8oCrgCvLJxS9dZx0SkvV5itsCLuVnt612iuFIRz1Zh6ip?=
 =?us-ascii?Q?6Bhw79QbyBqIW56uwt3NQWnY2TKb/QqZNXEh6xOqorMZ8k4KurOPYkCWn5Up?=
 =?us-ascii?Q?b8kuxkIvDZxNXzX/JzR1jWG4D2ktdfodRlD3Ot/7O9jD3fG0PBsFquos5sbs?=
 =?us-ascii?Q?8YrH14SclO2NhXm3GTZ+EisG05WAiFtCghO4FuuOiNyokDb3TX46QHrqMK4a?=
 =?us-ascii?Q?nldRmr7GauQKQYqF/1BvCFzXvWjZLRJNRjwioQcUz3fEPV2Zlj39tnm8pOYl?=
 =?us-ascii?Q?0tV0tDGnx79/0QaHq3maOz0qcr4xq8l16/5ikp1v17YRnt03Jq3RoDthBrQk?=
 =?us-ascii?Q?ZMA8sTbQjWXHbgjMP75cXu/rHYhJdNeBV5mDjzIRY7/ZZPLusKbRGzP5+O95?=
 =?us-ascii?Q?aalpG+UHO/Rs0FvFW1PPxkfDEjDRGO29jWcr4JnyrAI2V7QD4zlWAMVgBbQa?=
 =?us-ascii?Q?rmCUsQRpHn+kM2jj1434a5ZfkBUzFynwM7qa7Gq5H8t7iXnqFs3F+L70Gbeu?=
 =?us-ascii?Q?iVf/BQl4lOR32EyCraJwK23b2ev/Db+R9q0ziRI1tLK2VYnvmrvP0iONR/UU?=
 =?us-ascii?Q?3Lzzktg0XxXcWHpIC7rs3m6rDHhfmpECs3JF/kA7rIveEJwZnosZusNqKW8n?=
 =?us-ascii?Q?o+G1L6J/1+4xeWRPQg1keS3q3ctnBXCA+9ipqAIMRs8xxFbxXSVVRLdaKTjW?=
 =?us-ascii?Q?BkcDQ2zr0RGTOVeZroKzUNghIIdXlMLIgsZfoqCCsx/N13cXSP9U5NGLwM6Q?=
 =?us-ascii?Q?cjvwi+b2OWyJ2PKCqvY51pAMsJHRtIWlqPPBFReFDWt7FBFePuF3nX0q+mix?=
 =?us-ascii?Q?0eVFgBmAZ1dmGshyqwJaNTvAo3c9RH0q+7ioccDOkdRumAoBiiYtLsBKJf/D?=
 =?us-ascii?Q?Qg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd7174b-74eb-4337-f81e-08dd15c09c32
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 06:38:35.8689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jCF4hFFtfWwFfejj8B0pG4n7exoYRfhchWeeEYk5cWB7xa5G3/icZJbwC1v+DyEnSDWqAAngQunUiOGUX1+m3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8785
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "perf-sanity-tests.perf_all_metrics_test.fail" on:

commit: e2cb1db7daf8b7863aeec07bb574d3fae54518e6 ("perf test: Update all metrics test like metricgroups test")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      bcc8eda6d34934d80b96adb8dc4ff5dfc632a53a]
[test failed on linux-next/master f486c8aa16b8172f63bddc70116a0c897a7f3f02]

in testcase: perf-sanity-tests
version: 
with following parameters:

	perf_compiler: clang



config: x86_64-rhel-9.4-bpf
compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz (Kaby Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202412061343.42b071db-lkp@intel.com



2024-12-06 05:35:29 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-e2cb1db7daf8b7863aeec07bb574d3fae54518e6/tools/perf/perf test 109 -v
109: perf all metrics test:
--- start ---
test child forked, pid 14671
Testing tma_core_bound
Testing tma_info_core_ilp
Testing tma_info_memory_l2mpki
Testing tma_memory_bound
Testing tma_info_bad_spec_branch_misprediction_cost
Testing tma_info_bad_spec_ipmisp_indirect
Testing tma_info_bad_spec_ipmispredict
Testing tma_info_bottleneck_irregular_overhead
Testing tma_info_bottleneck_mispredictions
Testing tma_info_branches_callret
Testing tma_info_branches_cond_nt
Testing tma_info_branches_cond_tk
Testing tma_info_branches_jump
Testing tma_branch_mispredicts
Testing tma_clears_resteers
Testing tma_machine_clears
Testing tma_mispredicts_resteers
Testing tma_icache_misses
Testing tma_info_bottleneck_big_code
Testing tma_itlb_misses
Metric 'tma_itlb_misses' not printed in:
# Running 'internals/synthesize' benchmark:
Computing performance of single threaded perf event synthesis by
synthesizing events on the perf process itself:
  Average synthesis took: 664.527 usec (+- 0.249 usec)
  Average num. events: 45.000 (+- 0.000)
  Average time per event 14.767 usec
  Average data synthesis took: 712.865 usec (+- 0.236 usec)
  Average num. events: 330.000 (+- 0.000)
  Average time per event 2.160 usec

 Performance counter stats for 'system wide':

     <not counted>      CPU_CLK_UNHALTED.THREAD_ANY                                             (0.00%)
     <not counted>      IDQ_UOPS_NOT_DELIVERED.CORE                                             (0.00%)
     <not counted>      CPU_CLK_UNHALTED.THREAD                                                 (0.00%)
     <not counted>      IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE                                        (0.00%)
     <not counted>      ICACHE_TAG.STALLS                                                       (0.00%)

      14.342315124 seconds time elapsed

Some events weren't counted. Try disabling the NMI watchdog:
	echo 0 > /proc/sys/kernel/nmi_watchdog
	perf stat ...
	echo 1 > /proc/sys/kernel/nmi_watchdog
Testing tma_unknown_branches
Testing tma_info_bad_spec_spec_clears_ratio
Testing tma_other_mispredicts
Testing tma_fused_instructions
Testing tma_info_inst_mix_bptkbranch
Testing tma_info_inst_mix_ipbranch
Testing tma_info_inst_mix_ipcall
Testing tma_info_inst_mix_iptb
Testing tma_info_system_ipfarbranch
Testing tma_info_thread_uptb
Testing tma_non_fused_branches
Testing tma_info_bottleneck_branching_overhead
Testing tma_nop_instructions
Testing tma_divider
Testing tma_info_bottleneck_compute_bound_est
Testing tma_ports_utilized_3m
Testing tma_frontend_bound
Testing tma_info_bottleneck_instruction_fetch_bw
Testing tma_assists
Testing tma_other_nukes
Testing tma_serializing_operation
Testing tma_info_bottleneck_cache_memory_bandwidth
Testing tma_info_bottleneck_cache_memory_latency
Testing tma_l1_hit_latency
Testing tma_l2_bound
Testing tma_l3_hit_latency
Testing tma_mem_latency
Testing tma_store_latency
Testing tma_contested_accesses
Testing tma_data_sharing
Testing tma_false_sharing
Testing tma_fb_full
Testing tma_info_bottleneck_memory_synchronization
Testing tma_mem_bandwidth
Testing tma_sq_full
Testing tma_dtlb_load
Testing tma_dtlb_store
Testing tma_info_bottleneck_memory_data_tlbs
Testing tma_backend_bound
Testing tma_info_bottleneck_other_bottlenecks
Testing tma_info_bottleneck_useful_work
Testing tma_retiring
Testing tma_info_memory_fb_hpki
Testing tma_info_memory_l1mpki
Testing tma_info_memory_l1mpki_load
Testing tma_info_memory_l2hpki_all
Testing tma_info_memory_l2hpki_load
Testing tma_info_memory_l2mpki_all
Testing tma_info_memory_l2mpki_load
Testing tma_l1_bound
Testing tma_l3_bound
Testing tma_info_memory_l2mpki_rfo
Testing tma_fp_scalar
Testing tma_fp_vector
Testing tma_fp_vector_128b
Testing tma_fp_vector_256b
Testing tma_port_0
Testing tma_x87_use
Testing tma_info_botlnk_l0_core_bound_likely
Testing tma_info_core_fp_arith_utilization
Testing tma_info_pipeline_execute
Testing tma_info_system_gflops
Testing tma_info_thread_execute_per_issue
Testing tma_dsb
Metric 'tma_dsb' not printed in:
# Running 'internals/synthesize' benchmark:
Computing performance of single threaded perf event synthesis by
synthesizing events on the perf process itself:
  Average synthesis took: 661.175 usec (+- 0.249 usec)
  Average num. events: 45.000 (+- 0.000)
  Average time per event 14.693 usec
  Average data synthesis took: 709.301 usec (+- 0.237 usec)
  Average num. events: 329.000 (+- 0.000)
  Average time per event 2.156 usec

 Performance counter stats for 'system wide':

     <not counted>      CPU_CLK_UNHALTED.THREAD_ANY                                             (0.00%)
     <not counted>      IDQ.DSB_CYCLES_OK                                                       (0.00%)
     <not counted>      IDQ_UOPS_NOT_DELIVERED.CORE                                             (0.00%)
     <not counted>      IDQ.DSB_CYCLES_ANY                                                      (0.00%)
     <not counted>      IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE                                        (0.00%)

      14.272249202 seconds time elapsed

Some events weren't counted. Try disabling the NMI watchdog:
	echo 0 > /proc/sys/kernel/nmi_watchdog
	perf stat ...
	echo 1 > /proc/sys/kernel/nmi_watchdog
Testing tma_info_botlnk_l2_dsb_bandwidth
Testing tma_info_frontend_dsb_coverage
Testing tma_decoder0_alone
Testing tma_dsb_switches
Metric 'tma_dsb_switches' not printed in:
# Running 'internals/synthesize' benchmark:
Computing performance of single threaded perf event synthesis by
synthesizing events on the perf process itself:
  Average synthesis took: 666.217 usec (+- 0.248 usec)
  Average num. events: 45.000 (+- 0.000)
  Average time per event 14.805 usec
  Average data synthesis took: 715.290 usec (+- 0.235 usec)
  Average num. events: 329.000 (+- 0.000)
  Average time per event 2.174 usec

 Performance counter stats for 'system wide':

     <not counted>      DSB2MITE_SWITCHES.PENALTY_CYCLES                                        (0.00%)
     <not counted>      CPU_CLK_UNHALTED.THREAD_ANY                                             (0.00%)
     <not counted>      IDQ_UOPS_NOT_DELIVERED.CORE                                             (0.00%)
     <not counted>      CPU_CLK_UNHALTED.THREAD                                                 (0.00%)
     <not counted>      IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE                                        (0.00%)

      14.383362279 seconds time elapsed

Some events weren't counted. Try disabling the NMI watchdog:
	echo 0 > /proc/sys/kernel/nmi_watchdog
	perf stat ...
	echo 1 > /proc/sys/kernel/nmi_watchdog
Testing tma_info_botlnk_l2_dsb_misses
Testing tma_info_frontend_dsb_switch_cost
Testing tma_info_frontend_ipdsb_miss_ret
Testing tma_mite
Metric 'tma_mite' not printed in:
# Running 'internals/synthesize' benchmark:
Computing performance of single threaded perf event synthesis by
synthesizing events on the perf process itself:
  Average synthesis took: 664.894 usec (+- 0.246 usec)
  Average num. events: 45.000 (+- 0.000)
  Average time per event 14.775 usec
  Average data synthesis took: 713.947 usec (+- 0.237 usec)
  Average num. events: 329.000 (+- 0.000)
  Average time per event 2.170 usec

 Performance counter stats for 'system wide':

     <not counted>      CPU_CLK_UNHALTED.THREAD_ANY                                             (0.00%)
     <not counted>      IDQ.ALL_MITE_CYCLES_ANY_UOPS                                            (0.00%)
     <not counted>      IDQ_UOPS_NOT_DELIVERED.CORE                                             (0.00%)
     <not counted>      IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE                                        (0.00%)
     <not counted>      IDQ.ALL_MITE_CYCLES_4_UOPS                                              (0.00%)

      14.357059784 seconds time elapsed

Some events weren't counted. Try disabling the NMI watchdog:
	echo 0 > /proc/sys/kernel/nmi_watchdog
	perf stat ...
	echo 1 > /proc/sys/kernel/nmi_watchdog
Testing tma_info_botlnk_l2_ic_misses
Testing tma_info_frontend_fetch_upc
Testing tma_info_frontend_icache_miss_latency
Testing tma_info_frontend_ipunknown_branch
Testing tma_info_memory_tlb_code_stlb_mpki
Testing tma_info_pipeline_fetch_dsb
Testing tma_info_pipeline_fetch_mite
Testing tma_fetch_bandwidth
Testing tma_branch_resteers
Testing tma_lcp
Metric 'tma_lcp' not printed in:
# Running 'internals/synthesize' benchmark:
Computing performance of single threaded perf event synthesis by
synthesizing events on the perf process itself:
  Average synthesis took: 660.287 usec (+- 0.244 usec)
  Average num. events: 45.000 (+- 0.000)
  Average time per event 14.673 usec
  Average data synthesis took: 708.815 usec (+- 0.234 usec)
  Average num. events: 329.000 (+- 0.000)
  Average time per event 2.154 usec

 Performance counter stats for 'system wide':

     <not counted>      CPU_CLK_UNHALTED.THREAD_ANY                                             (0.00%)
     <not counted>      DECODE.LCP                                                              (0.00%)
     <not counted>      IDQ_UOPS_NOT_DELIVERED.CORE                                             (0.00%)
     <not counted>      CPU_CLK_UNHALTED.THREAD                                                 (0.00%)
     <not counted>      IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE                                        (0.00%)

      14.258487831 seconds time elapsed

Some events weren't counted. Try disabling the NMI watchdog:
	echo 0 > /proc/sys/kernel/nmi_watchdog
	perf stat ...
	echo 1 > /proc/sys/kernel/nmi_watchdog
Testing tma_ms_switches
Metric 'tma_ms_switches' not printed in:
# Running 'internals/synthesize' benchmark:
Computing performance of single threaded perf event synthesis by
synthesizing events on the perf process itself:
  Average synthesis took: 667.896 usec (+- 0.249 usec)
  Average num. events: 45.000 (+- 0.000)
  Average time per event 14.842 usec
  Average data synthesis took: 717.140 usec (+- 0.240 usec)
  Average num. events: 329.000 (+- 0.000)
  Average time per event 2.180 usec

 Performance counter stats for 'system wide':

     <not counted>      CPU_CLK_UNHALTED.THREAD_ANY                                             (0.00%)
     <not counted>      IDQ_UOPS_NOT_DELIVERED.CORE                                             (0.00%)
     <not counted>      CPU_CLK_UNHALTED.THREAD                                                 (0.00%)
     <not counted>      IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE                                        (0.00%)
     <not counted>      IDQ.MS_SWITCHES                                                         (0.00%)

      14.420115976 seconds time elapsed

Some events weren't counted. Try disabling the NMI watchdog:
	echo 0 > /proc/sys/kernel/nmi_watchdog
	perf stat ...
	echo 1 > /proc/sys/kernel/nmi_watchdog
Testing tma_info_core_flopc
Testing tma_info_inst_mix_iparith
Testing tma_info_inst_mix_iparith_avx128
Testing tma_info_inst_mix_iparith_avx256
Testing tma_info_inst_mix_iparith_scalar_dp
Testing tma_info_inst_mix_iparith_scalar_sp
Testing tma_info_inst_mix_ipflop
Testing tma_fetch_latency
Testing tma_fp_arith
Testing tma_fp_assists
Testing tma_info_system_cpu_utilization
Testing tma_info_system_dram_bw_use
Testing tma_info_frontend_l2mpki_code
Testing tma_info_frontend_l2mpki_code_all
Testing tma_info_inst_mix_ipload
Testing tma_info_inst_mix_ipstore
Testing tma_info_memory_core_l1d_cache_fill_bw_2t
Testing tma_info_memory_core_l2_cache_fill_bw_2t
Testing tma_info_memory_core_l3_cache_access_bw_2t
Testing tma_info_memory_core_l3_cache_fill_bw_2t
Testing tma_info_memory_l1d_cache_fill_bw
Testing tma_info_memory_l2_cache_fill_bw
Testing tma_info_memory_l3_cache_access_bw
Testing tma_info_memory_l3_cache_fill_bw
Testing tma_info_memory_l3mpki
Testing tma_info_memory_load_miss_real_latency
Testing tma_info_memory_mix_uc_load_pki
Testing tma_info_memory_mlp
Testing tma_info_memory_tlb_load_stlb_mpki
Testing tma_info_memory_tlb_page_walks_utilization
Testing tma_info_memory_tlb_store_stlb_mpki
Testing tma_info_system_mem_parallel_reads
Testing tma_info_system_mem_read_latency
Testing tma_info_thread_cpi
Testing tma_dram_bound
Testing tma_store_bound
Testing tma_load_stlb_hit
Testing tma_load_stlb_miss
Testing tma_store_stlb_hit
Testing tma_store_stlb_miss
Testing tma_info_memory_latency_data_l2_mlp
Testing tma_info_memory_latency_load_l2_mlp
Testing tma_info_memory_latency_load_l2_miss_latency
Testing tma_info_pipeline_ipassist
Testing tma_microcode_sequencer
Testing tma_info_system_kernel_cpi
Testing tma_info_system_kernel_utilization
Testing tma_lock_latency
Testing tma_info_pipeline_retire
Testing tma_info_thread_clks
Testing tma_info_thread_uoppi
Testing tma_memory_operations
Testing tma_other_light_ops
Testing tma_ports_utilization
Testing tma_ports_utilized_0
Testing tma_ports_utilized_1
Testing tma_ports_utilized_2
Testing C2_Pkg_Residency
Testing C3_Core_Residency
Testing C3_Pkg_Residency
Testing C6_Core_Residency
Testing C6_Pkg_Residency
Testing C7_Core_Residency
Testing C7_Pkg_Residency
Testing tma_info_core_epc
Testing tma_info_system_core_frequency
Testing tma_info_system_turbo_utilization
Testing tma_info_inst_mix_ipswpf
Testing tma_info_core_coreipc
Testing tma_info_thread_ipc
Testing tma_heavy_operations
Testing tma_light_operations
Testing tma_info_core_core_clks
Testing tma_info_system_smt_2t_utilization
Testing UNCORE_FREQ
Testing tma_info_system_socket_clks
Testing tma_info_inst_mix_instructions
Testing tma_info_system_cpus_utilized
Testing tma_bad_speculation
Testing tma_info_thread_slots
Testing tma_few_uops_instructions
Testing tma_4k_aliasing
Testing tma_cisc
Testing tma_split_loads
Testing tma_split_stores
Testing tma_store_fwd_blk
Testing tma_alu_op_utilization
Metric 'tma_alu_op_utilization' not printed in:
# Running 'internals/synthesize' benchmark:
Computing performance of single threaded perf event synthesis by
synthesizing events on the perf process itself:
  Average synthesis took: 665.830 usec (+- 0.241 usec)
  Average num. events: 45.000 (+- 0.000)
  Average time per event 14.796 usec
  Average data synthesis took: 713.746 usec (+- 0.234 usec)
  Average num. events: 328.000 (+- 0.000)
  Average time per event 2.176 usec

 Performance counter stats for 'system wide':

     <not counted>      CPU_CLK_UNHALTED.THREAD_ANY                                             (0.00%)
     <not counted>      UOPS_DISPATCHED_PORT.PORT_6                                             (0.00%)
     <not counted>      UOPS_DISPATCHED_PORT.PORT_0                                             (0.00%)
     <not counted>      UOPS_DISPATCHED_PORT.PORT_5                                             (0.00%)
     <not counted>      UOPS_DISPATCHED_PORT.PORT_1                                             (0.00%)

      14.364344905 seconds time elapsed

Some events weren't counted. Try disabling the NMI watchdog:
	echo 0 > /proc/sys/kernel/nmi_watchdog
	perf stat ...
	echo 1 > /proc/sys/kernel/nmi_watchdog
Testing tma_load_op_utilization
Metric 'tma_load_op_utilization' not printed in:
# Running 'internals/synthesize' benchmark:
Computing performance of single threaded perf event synthesis by
synthesizing events on the perf process itself:
  Average synthesis took: 667.283 usec (+- 0.248 usec)
  Average num. events: 45.000 (+- 0.000)
  Average time per event 14.829 usec
  Average data synthesis took: 714.417 usec (+- 0.231 usec)
  Average num. events: 328.000 (+- 0.000)
  Average time per event 2.178 usec

 Performance counter stats for 'system wide':

     <not counted>      CPU_CLK_UNHALTED.THREAD_ANY                                             (0.00%)
     <not counted>      UOPS_DISPATCHED_PORT.PORT_3                                             (0.00%)
     <not counted>      UOPS_DISPATCHED_PORT.PORT_2                                             (0.00%)
     <not counted>      UOPS_DISPATCHED_PORT.PORT_7                                             (0.00%)
     <not counted>      UOPS_DISPATCHED_PORT.PORT_4                                             (0.00%)

      14.385195742 seconds time elapsed

Some events weren't counted. Try disabling the NMI watchdog:
	echo 0 > /proc/sys/kernel/nmi_watchdog
	perf stat ...
	echo 1 > /proc/sys/kernel/nmi_watchdog
Testing tma_mixing_vectors
Testing tma_store_op_utilization
Testing tma_port_1
Testing tma_port_2
Testing tma_port_3
Testing tma_port_4
Testing tma_port_5
Testing tma_port_6
Testing tma_port_7
Testing smi_cycles
Testing smi_num
Testing tsx_aborted_cycles
Testing tsx_cycles_per_elision
Testing tsx_cycles_per_transaction
Testing tsx_transactional_cycles
---- end(-1) ----
109: perf all metrics test                                           : FAILED!



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241206/202412061343.42b071db-lkp@intel.com


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

