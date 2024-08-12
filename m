Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A504954724;
	Mon, 12 Aug 2024 14:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474344; cv=fail; b=RJmu6zv5tdBRYZubPZb/+IAN/8EASglJfiBVBWsGZ7h6tj/G7GbkVsl2dZoapCPE7vQJuuofSe/Z7OpNSzfS2NlBM5FOD03iLPhSMB6rWrTsxL/7dVvKmC6xBPa5JeGJZlwNNGN6av+LovPqOkEtXonVP3SNvbsPC8WU8hPmcEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474344; c=relaxed/simple;
	bh=qq+2YwLhKwfXlYIEYbpUnQS0IviABCMNBn2rKxjPV+o=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e1pfjuQJPBVJWILpRbp4vQ/dn0Lj+JWsa/UKJhy65g16/NN08+9B61iZgCuQSj59YBG4nJ8Ll2WYfHTMyXpPMZg5ioSHY4KBNqZRhOqubVhSVJceUXLyJBngMzs6vJkjIbGXQADRn09DneZkvA9/z9RNXhTN26ikvyEVjmMiqGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GuQuZ9H7; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GuQuZ9H7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723474343; x=1755010343;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=qq+2YwLhKwfXlYIEYbpUnQS0IviABCMNBn2rKxjPV+o=;
  b=GuQuZ9H7mWG04/sRlMbST2X5F59Ho9rXNhfCj28VG3c+giMEMf00mmvs
   xkgBKqqdHyG1OZXEKNZ0YwKisjh/IVkm116IXXXNJqMzSHBEZInvywU2v
   epVLo9sNUm0WUpwL8VYxHOFNUfCB8P1fwqT7u/GfFpqbN0TxStqLrQB6U
   U/l9v7Ac49tZYXPFmP5SlxRaQ84DqcMdakRnbXnDoG2bO/XoiSg5gS+R/
   UB80xk8pyWhTog53u79Iw/K7tUabECeM+FXChK5yo3138bQBnUvU33oD9
   w57ic8X0fkcTauSW8Qn4iAlO4D/G1FtBip1WeF+LlQXtHtnvvbjVBze9h
   w==;
X-CSE-ConnectionGUID: yVXkXRYgTEuMOfz7S/kXFA==
X-CSE-MsgGUID: AilOeDCqSUmeXqrfNrHcmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21396182"
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="21396182"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 07:52:22 -0700
X-CSE-ConnectionGUID: 3VSERUq9Q/et9RZUeYV2rg==
X-CSE-MsgGUID: NIPSPJYLTviBouq0xjENDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="88923295"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Aug 2024 07:52:22 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 12 Aug 2024 07:52:21 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 12 Aug 2024 07:52:21 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 12 Aug 2024 07:52:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uWa1eg9uQW9sNcxB5HV0V0h61Ajw6P8kbrn/G8SWN5MvFyCTBIki9xXWEAVJCtB6CqYN/su+701USn9v0eEP2wF3nDw1RtLReKom01MwipfMVV0FyRoIA6mMSAuKN90KLhA+UmkcImM4yErLRte0tluduleQOP8bz7MxOIMyJD/4FafPEQURNN3CO0/8Cl3HHdw6rgoidMCMF0E8K9hUAl/yjt7CrJl+TJ6+wa143Pfru8hbDeqLFi6Vqs7E4pjvI9PGLZ5NvJZdSCHEjCfgigmKeEy86kJGd1LI2QZkrsf+CzKKqCNvMcEtmHW4fR1Nw2cEOZM62IFyfpYALMIZ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FVPXLA2TEq+/hcYyWJoGC8J1ACejgjHU+0ts0JXStc=;
 b=DRnTu2kVLxCCs0uFnFFmjzDjLQfqwSd0b55ymFcU1DC7yAM3mVx3M2iFVviwyJ41wGcECZN6jHel25bGAPvvpR/QER9ntp5Grf+UwtV+UiTSxyD1kreh4N7hlBbVrh66eaJgPAVtiskh3lAPUYybwWJdDPM5m+90fT1m8YTtSO5JNDaRK0EiVYMKOW4pmkouj17M5tegRSRmQqkgbSazruvs7ay0vJOV71wUklex89YglW0UuSNivGzQfouHXzp9UVVgEO/bRf34ZF/IdZqU2zMiFbKF8fJDe4aTshfvwL928xoWhw5YraSfORxkxugSpLuR74hSKTIL8sMcSGPlgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by SA1PR11MB5803.namprd11.prod.outlook.com (2603:10b6:806:23e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.31; Mon, 12 Aug
 2024 14:52:18 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%5]) with mapi id 15.20.7828.031; Mon, 12 Aug 2024
 14:52:18 +0000
Date: Mon, 12 Aug 2024 22:52:07 +0800
From: kernel test robot <lkp@intel.com>
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Ian Rogers <irogers@google.com>, Kan Liang
	<kan.liang@linux.intel.com>
CC: <oe-kbuild-all@lists.linux.dev>, Jiri Olsa <jolsa@kernel.org>, "Adrian
 Hunter" <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>,
	"Ingo Molnar" <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH] perf lock contention: Change stack_id type to s32
Message-ID: <Zrohl0lm+/QnxjiN@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240810191704.1948365-1-namhyung@kernel.org>
X-ClientProxiedBy: SG2PR04CA0161.apcprd04.prod.outlook.com (2603:1096:4::23)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|SA1PR11MB5803:EE_
X-MS-Office365-Filtering-Correlation-Id: 115d2621-12d1-4ff5-b06a-08dcbade5ca6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0owtRepmP9ImS7pgviwoVaWePKM/StNjhaWoIOnRpQzMrOdrleVdqGDSKB3U?=
 =?us-ascii?Q?x/dX90qOmeWhFweyr8lQlzcG5M0pRNkRCd8QzrEwEp1aI9PyqUn9VGC6vIwO?=
 =?us-ascii?Q?td89r8msNqQBbYHD+XU7AN/+zsAPzpWhrZaW+P9BQ0MsFRKP/322pcfiUFhU?=
 =?us-ascii?Q?SRl2M7R0zuEFLMap3A5Bsnyj9ifeOoCHz+nWhKLP+JedVxI2uzN4K4e5oSms?=
 =?us-ascii?Q?/5NHQUn/8THLTJmV8UkiyEZ1+5uW/ZEV/7qKlwnh1jkkCMHzw4a83JeKSDZt?=
 =?us-ascii?Q?iXm6aQHXYmLHm/hyB9Ev/eHhnSs13MYNGwmBLmo+YXmjeoA7W9qH2Xpo/Qb2?=
 =?us-ascii?Q?n66PT07427msgIX/FOqbc6zMRDKnErudvu8iAEi42umTuPr36DaV3E6aMzUE?=
 =?us-ascii?Q?Ch1uysVbZVXEUQEfLVDiYWrdk6/+rRY6ymU5eB8MG6SjPTCcNs/F7Pzp4iwa?=
 =?us-ascii?Q?zPnmswZeyG1qkrjX9HrDZpeRxM+lC4FU0zGen35cTLEfXikuH+SrPkM7JYwy?=
 =?us-ascii?Q?yrnqmE4Ptytquxc7EzJlMcB4lA3vWn7M5vGXhxgG1ipvn6D/YhxOtcS1xU7v?=
 =?us-ascii?Q?AXAypZ+d4X8XblmZBTJq/z9Jguy78x1LbnUJUbBqmCYLeExkphAMCO/GHWZy?=
 =?us-ascii?Q?M5CvApzzAqzwRdDrxANHYT+etiuiaNszUZ6d0EHQc1RMig41CUSEdrd1ZH/r?=
 =?us-ascii?Q?3OmRtQsH+J5SIuGmaUjA6P2MpWL0EThX+Mq/hvRiKxh1QXLl8cCmg8v+YeKD?=
 =?us-ascii?Q?uU4tv1pTdFwHvO5ndSK4RFO3/Hbsm0+Rt/9ptQHVibwEodqxvzoBQMx4Xd+d?=
 =?us-ascii?Q?GLV76jFZto9BFz1Xlj+/S0My0TQ9AnAIm67e7nHXiU4a+y1W4FToJwA6C1Wm?=
 =?us-ascii?Q?0TZS9Paa9bARBdh60EoRfMvszeCeR9Uj7jswnVOLTGfZKU+BRoi6ci5atcQr?=
 =?us-ascii?Q?DaIwmAQJknHvyFqAFZi1BkXoki7WLJeRJ3Oj0UFufa3WJqr6PM9hM32BNwBk?=
 =?us-ascii?Q?TGA9sItsVyqUZscoGfEOLzhDGpkGCwat/T7tMd73YP4kj6AZYYf7S8yosXhg?=
 =?us-ascii?Q?C1O1hfyJWzAfo/JTjZ5eR9KHYCavmMd7lOVUT5Ygg3w9VRVaSAa6AzWII+zg?=
 =?us-ascii?Q?lwiIkndJBiwgBXhWtBV6DYRI26O26ik3+jkgk6yEZw9l84QH4Vkljm71TMiL?=
 =?us-ascii?Q?Vs/JfavS9IQl2Tpg7ApXvDxHIaqrzIPX6JfXCmzbLWmviJ3I7EfCvUQ0vos7?=
 =?us-ascii?Q?sAKjSHeiqFLd/TC2KCemHEFgw35EKUsBsl2D3DSnOSpmNuQZkXoymgNmCgqX?=
 =?us-ascii?Q?L5gt7F9dWiP8rbl1XKgOqh8G?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m+l7Mc9U1jhc98BJ50WlJIcE90WQYLhRm3nBgBffNc3vL0GIynTwEileLmCG?=
 =?us-ascii?Q?wcUL38ay0oJ+W6YBtTXEujEIp6W+aNfxJ936e2R3FwFtxrzgsXfVOKhovJ3L?=
 =?us-ascii?Q?khBWhfdKFGCbrG0ADBqQC1r/+aK/rv84232CuZmsEIVSpXs5ma84rTsIwewf?=
 =?us-ascii?Q?mNqzyqwLeKLpmZeyNStu/Irjw7EAjDImCE+VJpxe+KDOUAw13iMaXmMRsEO0?=
 =?us-ascii?Q?nZGaB23pHW/NlPxhKXe7ZO6Islz6+r0Xeyg7YDvh3FIBibGVn4Fl3f0Kx152?=
 =?us-ascii?Q?+qApUIgK0QoLYOf05mTPb/330dxiEjEEihQOL2fj8dohzi24b5bkbFtfPkfy?=
 =?us-ascii?Q?dQ8a4DbPZlXtSwVZGc7Nb1HrwHNIRKTp9XTuPdkqKRSPdplyI+/e62FNTg9v?=
 =?us-ascii?Q?raRNqflgkBMzWvMmOoBJVq+wrUqvyWHTjfmkIx6U+A5b61HiFjjHV6nacDyv?=
 =?us-ascii?Q?OB5IThdKSmVdB7wGcS5QtEyzX3Y0+qnvv7rxZifFavsaiaSjo2jQqT7GJu9D?=
 =?us-ascii?Q?MrMNADcQviyOF0FI4sETnjwt28s8l0llUbDvuKacFnLBbPeCadNzONY8Mwk+?=
 =?us-ascii?Q?3crP0UnPTlQZoOhD9fsudHpxM6izDsE9CG/bBFl7CxAnEQrhXnXPpDU3jmNn?=
 =?us-ascii?Q?XE2TpDVycJ/CYWQFS/vTmcSfTxvcSzP9yIMXntaxMSXaQoE6Q8lrAkJaRTSP?=
 =?us-ascii?Q?z+3T4eszEc76kmYyaTdKGaoyh1HgDbIlyj7/FxbI6RilopJGIJI8XowKeQEK?=
 =?us-ascii?Q?Oq8az8/UieuVPIq4wjEVzuKI2InKPrawL2+OXXqKYth9gnn0YFzBLbxQ3WO5?=
 =?us-ascii?Q?65XcLTQWmtltnDFapUqkLuDUTGavjdpLKEnVf0FIGrw5T4ylaI03rD72pcQ/?=
 =?us-ascii?Q?Zb4ebB5MwaXdeIfa738Mayyb2X7Dc4jpyfGtbipg47+XEFG9UX1ZuAR3t/gP?=
 =?us-ascii?Q?UjYcw4NNtQyp5pYvXpSziJOr/w/gB3+H5ljVXekwqHl4WJ6frxeXgWr6xCF+?=
 =?us-ascii?Q?zBO4bZpAjAub0Z4/CsL54plA1WwGuIAX5+/tiOBkZ21173h89aq8xc+FwStg?=
 =?us-ascii?Q?riEhWWxPQ7CDY99eCdvPgj7Cr3xGrxC+eQ8JxtN3Ki2eSx5UyKku8OJEF8jv?=
 =?us-ascii?Q?Cd/H6oO32kNaKD2WSIm3pOCT8MyJO4VfXP54aPotFZEbJisKRCpQYRrBgKHC?=
 =?us-ascii?Q?GqZ822sj2iABk5mNMvEsexbVGLrQj2A2pSES/o5R+jhCR/EnthChgAHaNcli?=
 =?us-ascii?Q?LN2+01rcArpq7zjapkdpDzDLrfK6OkBB9ltP/4yJYunMoZj8/AcR8qDoYCgy?=
 =?us-ascii?Q?RrJf0tIlLYt503HLgXT1nRpX4LngFYlyxk3GV5t4MCJEWeq57fd0eeZASRNi?=
 =?us-ascii?Q?LBUOhWMFIguxvGbmhkmmrYuvEzwUcv2Gy9lBt6+cZEIGFNUZf0Y5bc6rAniJ?=
 =?us-ascii?Q?m4FXzUqFwcmwRUmkGQBT7aLTulV2qcIZG15Ii4/qFqH7pu9pH10RcCvR/IKa?=
 =?us-ascii?Q?zv1Hxrffpqf9q6DxQ1/XltzcNJXIs6zCiTqtHfsXAfi2QOd8sPmvYts0wMzr?=
 =?us-ascii?Q?AJ2ZbztaeY3VYgP02Pe/lGOiGDDJj5DJIIWJC0r1EO+f5105uz+IXT5miQng?=
 =?us-ascii?Q?Eg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 115d2621-12d1-4ff5-b06a-08dcbade5ca6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 14:52:18.2514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z93b7FE+QFHYI0ACk6RQQ1Q2baxyX64cL4GsMcwVAyPeY1hLXV8tqH4AISDJ8ah0LV6sjlCvZ+oH4m68OPWTFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5803
X-OriginatorOrg: intel.com

Hi Namhyung,

kernel test robot noticed the following build errors:

[auto build test ERROR on perf-tools-next/perf-tools-next]
[also build test ERROR on tip/perf/core perf-tools/perf-tools linus/master v6.11-rc2 next-20240809]
[cannot apply to acme/perf/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Namhyung-Kim/perf-lock-contention-Change-stack_id-type-to-s32/20240811-031933
base:   https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
patch link:    https://lore.kernel.org/r/20240810191704.1948365-1-namhyung%40kernel.org
patch subject: [PATCH] perf lock contention: Change stack_id type to s32
:::::: branch date: 23 hours ago
:::::: commit date: 23 hours ago
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240812/202408120233.2JuKgpj9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202408120233.2JuKgpj9-lkp@intel.com/

All errors (new ones prefixed by >>):

   Makefile.config:671: No libunwind found. Please install libunwind-dev[el] >= 1.1 and/or set LIBUNWIND_DIR
     PERF_VERSION = 6.11.rc2.gcbe444bb08ed
   In file included from util/bpf_skel/lock_contention.bpf.c:9:
>> util/bpf_skel/lock_data.h:10:2: error: unknown type name 's32'; did you mean 'u32'?
      10 |         s32 stack_id;
         |         ^~~
         |         u32
   util/bpf_skel/vmlinux.h:17:15: note: 'u32' declared here
      17 | typedef __u32 u32;
         |               ^
   In file included from util/bpf_skel/lock_contention.bpf.c:9:
   util/bpf_skel/lock_data.h:14:2: error: unknown type name 's32'; did you mean 'u32'?
      14 |         s32 stack_id;
         |         ^~~
         |         u32
   util/bpf_skel/vmlinux.h:17:15: note: 'u32' declared here
      17 | typedef __u32 u32;
         |               ^
   2 errors generated.
   make[5]: *** [Makefile.perf:1247: tools/perf/util/bpf_skel/.tmp/lock_contention.bpf.o] Error 1
   make[5]: *** Waiting for unfinished jobs....
   make[4]: *** [Makefile.perf:292: sub-make] Error 2
   make[3]: *** [Makefile:76: all] Error 2


vim +10 tools/perf/util/bpf_skel/lock_data.h

fd507d3e359c7e Namhyung Kim 2022-12-09   5  
b44d6653685939 Namhyung Kim 2024-02-27   6  struct tstamp_data {
b44d6653685939 Namhyung Kim 2024-02-27   7  	u64 timestamp;
b44d6653685939 Namhyung Kim 2024-02-27   8  	u64 lock;
b44d6653685939 Namhyung Kim 2024-02-27   9  	u32 flags;
cbe444bb08ed25 Namhyung Kim 2024-08-10 @10  	s32 stack_id;
b44d6653685939 Namhyung Kim 2024-02-27  11  };
b44d6653685939 Namhyung Kim 2024-02-27  12  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

