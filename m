Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3067DA9F;
	Mon, 16 Sep 2024 06:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726469343; cv=fail; b=id5qaKbxUKvOX5SZaJyugB4rrDSmdm1exSzQL6zLOrDSrdoxlvz1qpyeWEQqgxmpd7mvhzBRb9VIiGrTGG5VckcgLm7fdRCTku4hACoAMg9l4qzaoOYTVPgVr3MWES8N0+n/F7kRsWm3OLYawJ4nOl3/pTgQW+zBfUItPetb6F4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726469343; c=relaxed/simple;
	bh=YrqY9xFctRz87CwwNJAVbMBWCfMe4boStXDl7sACIUw=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gjqOCx4Qvg0XF+VhSlVTYtFCVXLFlpdQWouH2rrsTC3uFy2TP7QgL66SJpd2uj6IECYHPg0nQtBc6FXBhplpmIPOI+iDJpv1f3TRR1Wgp+v7/LtQG/J0odgmrP9tG1b2Q7pgI7j/Jr4WqYLvy4OjJ+Bht29UnHs7R8vlWXJhLr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lNNDzynV; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lNNDzynV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726469342; x=1758005342;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=YrqY9xFctRz87CwwNJAVbMBWCfMe4boStXDl7sACIUw=;
  b=lNNDzynV4a4weklaJYac4DFiyaR/lQkrAAPj68n5ixCCrbJeuD8RU4Q8
   fCyaQ/szJ4Ev/ZG/gHeQqfhRg3kehDvsMMP7FdlNGB5qBcGztHxKR6EKP
   UkKDjXx/JbTls0JhSIsK+PRX0sHcaEUGdefiHT5OHJNzfSg6l9s5OhB0w
   9tU94FwJ88cC04Cu7SfvbrNJ07kXFMnjN1es3Xo31BBYZBl5PVL001Kak
   iSKhWkpQxqEQ6o6slSz1yeJWSLVFVO498YGxWk94MBuWFpUzOhO7rSlzT
   v4IK8RpqEZWKCTsCwYKKP4O0YqEBMKRPSmBy76WsQmxn56YreWTr04fFx
   Q==;
X-CSE-ConnectionGUID: KfUB4bCYT4a6fEAL/kMcKg==
X-CSE-MsgGUID: 3aaus3UsQiK5KBrgWXpuJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11196"; a="28198727"
X-IronPort-AV: E=Sophos;i="6.10,232,1719903600"; 
   d="scan'208";a="28198727"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2024 23:48:56 -0700
X-CSE-ConnectionGUID: n3uMK245S5KNN3EQx2yjBg==
X-CSE-MsgGUID: BWaeJIjCQymmPlGI3yXk5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,232,1719903600"; 
   d="scan'208";a="69286155"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Sep 2024 23:48:54 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 15 Sep 2024 23:48:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 15 Sep 2024 23:48:52 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 15 Sep 2024 23:48:52 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 15 Sep 2024 23:48:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FcCP+dFlWj9tLjHKzTz7PSDJskDnHnErjHBl8HMKF6egu0+rMPviistwLcFgjyvJtON5JSc61hI3fEVFexpc4F95h2bH4R9RVZoNXDm4g1GsXNW7IQkUJnwSuiC6L/GcGrCWiL8a0IZGOLIbieES+u4eHiyNMhZ5CgUMa51O/zM6e5vDO35TlGZeJFBjbOKwNQJg7ZOwlB8kgvvRvLGZRKJWFFKwM6L9mELfwFfaNop5RckeMMsg77gdB2zMm0YnfZFrl990x3ZRey74nhXRHZBzXp68ZUSVO4OT7xJOgWpTneiPwLdWD6ORN9nFNKVGZQpxitN04HfAkAGZRVIkng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Yj8tetX0Bl2xYsGbbw2wz7Z1ODsrC3q5tChrDGss6A=;
 b=vo9nDC4456J8gzg9dvh9LyfheS+aI2ikAEaE57nPNS1TYTtnLl7ZEYbKseAUjPFyCn10MVEI2g21scHd4qyO0RF+X2j0jU6CDCTHOoKKZKZxNY93wM8VrywQH4jT+qFRbXIdja2Ods4PHlHwn7lmdVHO2awAET/FvlQoxxjcdfsCw6PDICNbmWEQ7PrB+1LpgtuYHedZspgX0p/V6lF3oB+xMy+UZBu/3zQGqtZCowMGjpK1jv1+8VzPF+iI/4gFhXvEKzpS35GvMmv5nmXMqM/NJXQZEvQOK/NcLooMPTEd2mrSmC9N6Dyhe3EBN6EM2orcut95Gm860iDSmQ5NtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA2PR11MB5180.namprd11.prod.outlook.com (2603:10b6:806:fb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 06:48:48 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 06:48:48 +0000
Date: Mon, 16 Sep 2024 14:48:35 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt
	<rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, "Arnaldo Carvalho de
 Melo" <acme@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, Mark Rutland
	<mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Namhyung
 Kim" <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
	<adrian.hunter@intel.com>, Mark Brown <broonie@kernel.org>,
	<linux-toolchains@vger.kernel.org>, Jordan Rome <jordalgo@meta.com>, "Sam
 James" <sam@gentoo.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH v2 05/11] perf/x86: Use user_unwind interface
Message-ID: <202409161428.3cc6c1e1-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <daf3f59e0d14ee11b45ad6735b8a211a3c7534dc.1726268190.git.jpoimboe@kernel.org>
X-ClientProxiedBy: SG2PR04CA0155.apcprd04.prod.outlook.com (2603:1096:4::17)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA2PR11MB5180:EE_
X-MS-Office365-Filtering-Correlation-Id: 51b98527-a863-45e8-31e0-08dcd61b9e37
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NivRL4YfJF1JMRdaT3ROugmJIQVRRJxBvgB7zvVHooT5wU7NgssFg5NlACgD?=
 =?us-ascii?Q?1te0ideCBCYIEduiPgneD3lBlClsDEBrjrsbBwHXKFUfvzUJ8zwlAMSbZyty?=
 =?us-ascii?Q?sXV3WeQAVMwmwe+lCH1+eAvoK8D1kWDM8w9iec1blVkeLa+341wi/6P7HT82?=
 =?us-ascii?Q?fwGOUTCvLvbFsZOySQcSb/5g4o1CKU+1OlX7bKZBqcuOM9D/lyuFTNNlDrLW?=
 =?us-ascii?Q?MJ+xP+G21fg3jzlXuaFQykA4g6m+004C8AtewW+cJ1FBe9dkZMequGdoT4/P?=
 =?us-ascii?Q?UAGeIfu82ZwT/IB+S6JcQOUhrOt3L63tGS0qR/p4vePVHt6o50HBRFjnYoI9?=
 =?us-ascii?Q?X5uxFY0oxFjmtPAsNAkyz2RcPbkLFYhSvcWyjQ4DN2EYLrvirJHNejeu6hGM?=
 =?us-ascii?Q?YE1zKTSSeP+N4TiS8lmKAY9naJ8RYserNS6YgJziYyiXgiLLFfGiRCVf1K5f?=
 =?us-ascii?Q?yA5rr/2Qu+wIRa5c/dtRWlpqwzOQH8TkO6pfiou46CTY1/23dmVFzaaxlh8X?=
 =?us-ascii?Q?ULW9+Y1bFTs8fCva2noMAPy/wWQSXgLrw74NEc/g3orSbk351b9qgo1De6P4?=
 =?us-ascii?Q?ULSu+XN389rW0iTktGgxmvwXkujBW7uqeJgjWrvBx1jxRj3aKjPpiB8cWXzF?=
 =?us-ascii?Q?XTh12oLpxv9sWeSduqaSpfIX3vCiiv49GgOPEv+Opvnu+QAZ+5nYftvm1+gY?=
 =?us-ascii?Q?CfC46CuWUgrK5mITC6cUT0XorRPgVtk1o3CD+JjOsp8hvGsWUeFfpV6mHz64?=
 =?us-ascii?Q?zRHCo5c69ucFkDZXaz8UA/XKEuLgzO6pJ0Vw3akR6GkMqKNlUoigDHJHHEaC?=
 =?us-ascii?Q?coMlKORI+aRsn661vMPqH60tNjURcyHoB5sulmZUCw8uL3XRw2lEJ/r8Y3JD?=
 =?us-ascii?Q?vPIAOybI7upBSIQpVA6y+Xm5lM7r6AQkHAyg1Of7fuXK7OfdejSidIAbK4wT?=
 =?us-ascii?Q?KrkeyBU/A/A28VaGp/lDVMC7eoJNKR8dZ1mDZWiOg+Ap/xfKrC3oAPiwWtwq?=
 =?us-ascii?Q?Ro4Qn9A0DA66nCHf93iIYLSbO9A5rKk6mORgKDeoSerBmjOigJ15ifCJM88c?=
 =?us-ascii?Q?i5ASrp2aRfAJ4pAxT9PcDcKscKClPAt9VtHo6NjUxtCzMD5qe7aZfoYUKPE0?=
 =?us-ascii?Q?Ab5dw7qN4Nag8Qi7A2aILprHrROQseqzYxRS0HOxAp44ENjJWTkSGXbI0y5y?=
 =?us-ascii?Q?c21slu90DF0WiDlqBjwRw9X9UgR2o7m2TVnCaPxBG+xNvDzaac+vf8nwH/7D?=
 =?us-ascii?Q?pZDv5+OIhVQC29JzPQUwssrs7q2530icS+Ne5mIJIxyuNaWKjY7VtIq7ZKcI?=
 =?us-ascii?Q?rplNDyCc6VVFKkxzLSKD2cPE0+ItDRcKdE12mDWiX91b08d8TaOL0Y2U5TiF?=
 =?us-ascii?Q?Zvoy8kI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/jmUzG9wI0kHF/RwfgMBiGoP42vme9jEDWxQAI8dKPIh3+U/ETID2NJ5tfM2?=
 =?us-ascii?Q?aiRq41X9sfnxPvf7dH7jHp1S2u7sP2kBfiZ5ReNgG8S/UB+AgAQ6RWrxKDC1?=
 =?us-ascii?Q?KE2ELahagCFizY/Y6WUiz+xYl6Q2L8WzgEKE5aR9Ql0PcMPE8xgMU2+bwwuZ?=
 =?us-ascii?Q?/1ACgm99nCDZs2o3WNOn9A4+S1f7rKYh1Ld9ML7eokvb2JH6hPRCobFiCHpU?=
 =?us-ascii?Q?e4FyBwRsPLQbA65ov226Nu+hpehbQgJT4xsboG9kJKiSkyOR+pp3Z0q/074P?=
 =?us-ascii?Q?CTXfA6qzZ21BfKJRO4/RMvMGGr/+LdX5E/5j4E6sL8V3kIdKTG9AhTom1iCZ?=
 =?us-ascii?Q?A3Jp/sx1zA98akb/gCPdXdmo6xNSWoM5UBc7u0FVWs2vX/KOdezVhcHR6VU1?=
 =?us-ascii?Q?oBQAAoIandXewwvkUrg9GSjzf6F6DnZexGyAA4JePBgdPlEvXefXhYUMRG2G?=
 =?us-ascii?Q?8mFuabz1wzmmx/1D5KdL/VWHdU01DXiDDJwWjO5cmYBp2Ai15p0nMcbXujNV?=
 =?us-ascii?Q?Dl0oou+s/kRNjdI6FUN3GA0LPTW5yh7DBj5JyjW3KEpg4RZCzkwAa46s5Vp5?=
 =?us-ascii?Q?/dCQ0kIsuOBzq2ZZRWB4sBgjkgkDK45/YQ+kvP/qXXev0lshZvdWF6hPeLA5?=
 =?us-ascii?Q?NYKi8WZeTb49vbuFEkIkicub2VUtOQdfiPHsevt0kZX1y7g9IdR1WQGFmpiL?=
 =?us-ascii?Q?dAPuG4TcvERnzJKGFdyXm9qJiGvugMQmYK84DANoScPBTMcKzgmbzOoJEtvY?=
 =?us-ascii?Q?0i5jFNvQYf9T3VaKH07Rb0J7itQTmjeGi21znSdAq4fJ9HNaO3aqxu4NMjE0?=
 =?us-ascii?Q?LF+Rt9SM/b2JaOdBq1Jq0jdryE5XZu5lPa8FVGpF7fXs3pLuCSJS2PcEqmnP?=
 =?us-ascii?Q?uXPpyVMfnGn/pcVi5YMFvlJ7AKPaKp+qhjQ90jMawVQMDlPpaCPsuZPvCLGv?=
 =?us-ascii?Q?g3cZ8FYXdKgZiOc/qGu2ecZCVFT2z9mo1I9PxLZfaIGA9wPYWFZQDbbLkYaj?=
 =?us-ascii?Q?114X5ezQttADGLI3ZSdFMVGzMnu0uIge3f1ZjSGFpuCHXfkXASGk4ezCFKwH?=
 =?us-ascii?Q?zyBe2bIRDVIMGzO+HKWbcDgOsdSccvtwqFtpbYP1ermuQ8i9bgPGdACVJtN6?=
 =?us-ascii?Q?WB7o9NtlZhrwPXga2SKgShWX1+xrhbOpr9NORl7dECxxgvfbfXPVkaPStciV?=
 =?us-ascii?Q?4BgLxhQjMBxuZSn6wuK4KAtXvalm/JJCFcqr7NF8yiAYlgRGrYNSoGFcVhLY?=
 =?us-ascii?Q?jRj08u3UD8Ia8EmI4OlrBBKbgzQMQeWHvxiDozyd42WI2QrpPYnnqF/PEuBz?=
 =?us-ascii?Q?3AwuXIiql3f43x9HuQ4MHtKAbfmuRQIuQp7liB9mQhs7aZTkY6ecPlsP+tmD?=
 =?us-ascii?Q?QN5NFedMB40H8Ti5pEsQ38Lcnpf0YnWiyk7XZDm5K7AgvpfMb0wPErWzgfjt?=
 =?us-ascii?Q?jlT1O92lfp0Eg8UQ7J41+8qazZqjsmki8ZeFTHFlPgSUwXi8UaSyr8/qNeTJ?=
 =?us-ascii?Q?xnS0GYQ8Td7IPC6sOaRlee81MR72mtrzYxkfCCWAgbtwdNyjmORzOpS/Tlis?=
 =?us-ascii?Q?dNU/GPAeEKFUcj1T5WiMd14JAx/jOTWgW7ttDorP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 51b98527-a863-45e8-31e0-08dcd61b9e37
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 06:48:48.8225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bHb8Y2u5Wfjk7M4tbTpZn8FRp+a0tuNzceA1hO1dymGu5DGm80vdqnqcnXBW6x+FfPEevK6jAYqsEmDpBEE4mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5180
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel_BUG_at_kernel/unwind/user.c" on:

commit: 164c5ae4072303c9eb4e263115a5e70d5a3cc052 ("[PATCH v2 05/11] perf/x86: Use user_unwind interface")
url: https://github.com/intel-lab-lkp/linux/commits/Josh-Poimboeuf/unwind-Introduce-generic-user-space-unwinding-interface/20240914-070619
base: https://git.kernel.org/cgit/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
patch link: https://lore.kernel.org/all/daf3f59e0d14ee11b45ad6735b8a211a3c7534dc.1726268190.git.jpoimboe@kernel.org/
patch subject: [PATCH v2 05/11] perf/x86: Use user_unwind interface

in testcase: fsmark
version: fsmark-x86_64-2628be5-1_20240224
with following parameters:

	iterations: 1x
	nr_threads: 64t
	disk: 1BRD_48G
	fs: xfs
	filesize: 4M
	test_size: 24G
	sync_method: NoSync
	cpufreq_governor: performance



compiler: gcc-12
test machine: 96 threads 2 sockets Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz (Cascade Lake) with 128G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202409161428.3cc6c1e1-oliver.sang@intel.com


[   53.036370][    C3] ------------[ cut here ]------------
[   53.036374][    C3] kernel BUG at kernel/unwind/user.c:39!
[   53.036381][    C3] Oops: invalid opcode: 0000 [#1] SMP NOPTI
[   53.036385][    C3] CPU: 3 UID: 0 PID: 1317 Comm: sed Tainted: G S                 6.11.0-rc6-00501-g164c5ae40723 #1
[   53.036388][    C3] Tainted: [S]=CPU_OUT_OF_SPEC
[   53.036389][    C3] Hardware name: Intel Corporation S2600WFD/S2600WFD, BIOS SE5C620.86B.0D.01.0286.011120190816 01/11/2019
[ 53.036390][ C3] RIP: 0010:user_unwind_next (kernel/unwind/user.c:39) 
[ 53.036400][ C3] Code: 01 eb c1 48 01 f0 e8 a0 15 ea 00 85 c0 75 ee 48 89 73 08 4c 89 03 8b 41 08 85 c0 74 a5 48 89 53 10 eb 9f bf ea ff ff ff eb 9a <0f> 0b e8 ba b9 ea 00 66 66 2e 0f 1f 84 00 00 00 00 00 66 66 2e 0f
All code
========
   0:	01 eb                	add    %ebp,%ebx
   2:	c1 48 01 f0          	rorl   $0xf0,0x1(%rax)
   6:	e8 a0 15 ea 00       	callq  0xea15ab
   b:	85 c0                	test   %eax,%eax
   d:	75 ee                	jne    0xfffffffffffffffd
   f:	48 89 73 08          	mov    %rsi,0x8(%rbx)
  13:	4c 89 03             	mov    %r8,(%rbx)
  16:	8b 41 08             	mov    0x8(%rcx),%eax
  19:	85 c0                	test   %eax,%eax
  1b:	74 a5                	je     0xffffffffffffffc2
  1d:	48 89 53 10          	mov    %rdx,0x10(%rbx)
  21:	eb 9f                	jmp    0xffffffffffffffc2
  23:	bf ea ff ff ff       	mov    $0xffffffea,%edi
  28:	eb 9a                	jmp    0xffffffffffffffc4
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	e8 ba b9 ea 00       	callq  0xeab9eb
  31:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
  38:	00 00 00 00 
  3c:	66                   	data16
  3d:	66                   	data16
  3e:	2e                   	cs
  3f:	0f                   	.byte 0xf

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	e8 ba b9 ea 00       	callq  0xeab9c1
   7:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
   e:	00 00 00 00 
  12:	66                   	data16
  13:	66                   	data16
  14:	2e                   	cs
  15:	0f                   	.byte 0xf
[   53.036402][    C3] RSP: 0000:ffffc9000b38b938 EFLAGS: 00010093
[   53.036404][    C3] RAX: 0000000000000000 RBX: ffffc9000b38b960 RCX: ffff888230156880
[   53.036405][    C3] RDX: 000055b666c6ef3c RSI: 0000000000000001 RDI: ffffc9000b38b960
[   53.036407][    C3] RBP: ffffc9000b38bf58 R08: 0000000000000000 R09: 0000000000000000
[   53.036408][    C3] R10: ffffc9000b38bf58 R11: 0000000000000000 R12: ffff8881fcc88000
[   53.036409][    C3] R13: 000000000000007f R14: ffffc9000b38bf58 R15: 0000000000000000
[   53.036411][    C3] FS:  00007f9da3761800(0000) GS:ffff88903eb80000(0000) knlGS:0000000000000000
[   53.036412][    C3] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   53.036413][    C3] CR2: 00007f4a5dbb53d8 CR3: 0000000216b96005 CR4: 00000000007706f0
[   53.036414][    C3] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   53.036415][    C3] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   53.036416][    C3] PKRU: 55555554
[   53.036417][    C3] Call Trace:
[   53.036419][    C3]  <TASK>
[ 53.036422][ C3] ? die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434 arch/x86/kernel/dumpstack.c:447) 
[ 53.036429][ C3] ? do_trap (arch/x86/kernel/traps.c:114 arch/x86/kernel/traps.c:155) 
[ 53.036433][ C3] ? user_unwind_next (kernel/unwind/user.c:39) 
[ 53.036435][ C3] ? do_error_trap (arch/x86/include/asm/traps.h:58 arch/x86/kernel/traps.c:176) 
[ 53.036437][ C3] ? user_unwind_next (kernel/unwind/user.c:39) 
[ 53.036439][ C3] ? exc_invalid_op (arch/x86/kernel/traps.c:267) 
[ 53.036446][ C3] ? user_unwind_next (kernel/unwind/user.c:39) 
[ 53.036448][ C3] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
[ 53.036455][ C3] ? user_unwind_next (kernel/unwind/user.c:39) 
[ 53.036457][ C3] perf_callchain_user (include/linux/uaccess.h:233 include/linux/uaccess.h:260 arch/x86/events/core.c:2894) 
[ 53.036460][ C3] get_perf_callchain (kernel/events/callchain.c:184 kernel/events/callchain.c:259) 
[ 53.036465][ C3] perf_callchain (kernel/events/core.c:7693) 
[ 53.036469][ C3] setup_pebs_fixed_sample_data (include/linux/perf_event.h:1237 arch/x86/events/intel/ds.c:1772) 
[ 53.036473][ C3] intel_pmu_drain_pebs_nhm (arch/x86/events/intel/ds.c:2201 arch/x86/events/intel/ds.c:2378) 
[ 53.036477][ C3] handle_pmi_common (arch/x86/events/intel/core.c:3066) 
[ 53.036480][ C3] ? __intel_pmu_enable_all+0x28/0xf0 
[ 53.036484][ C3] ? perf_rotate_context (kernel/events/core.c:1154 kernel/events/core.c:1150 kernel/events/core.c:4322) 
[ 53.036486][ C3] ? __pfx_perf_mux_hrtimer_handler (kernel/events/core.c:1082) 
[ 53.036488][ C3] ? ktime_get (kernel/time/timekeeping.c:195 (discriminator 4) kernel/time/timekeeping.c:395 (discriminator 4) kernel/time/timekeeping.c:403 (discriminator 4) kernel/time/timekeeping.c:850 (discriminator 4)) 
[ 53.036492][ C3] intel_pmu_handle_irq (arch/x86/include/asm/msr.h:86 arch/x86/include/asm/msr.h:133 arch/x86/events/intel/core.c:2488 arch/x86/events/intel/core.c:3186) 
[ 53.036493][ C3] perf_event_nmi_handler (arch/x86/events/core.c:1748 arch/x86/events/core.c:1734) 
[ 53.036499][ C3] nmi_handle (arch/x86/kernel/nmi.c:151 (discriminator 7)) 
[ 53.036500][ C3] default_do_nmi (arch/x86/kernel/nmi.c:352) 
[ 53.036503][ C3] exc_nmi (arch/x86/kernel/nmi.c:546) 
[ 53.036504][ C3] asm_exc_nmi (arch/x86/entry/entry_64.S:1198) 
[   53.036507][    C3] RIP: 0033:0x55b666c6ef3c
[ 53.036509][ C3] Code: 75 10 48 c7 c1 ff ff ff ff 41 b8 10 00 00 00 ba 01 00 00 00 e8 75 91 00 00 49 8b 4d 08 48 89 c7 eb 89 0f 1f 40 00 44 09 71 08 <48> 83 c4 18 5b 5d 41 5c 41 5d 41 5e 41 5f c3 4c 3b 62 10 7d 08 4c
All code
========
   0:	75 10                	jne    0x12
   2:	48 c7 c1 ff ff ff ff 	mov    $0xffffffffffffffff,%rcx
   9:	41 b8 10 00 00 00    	mov    $0x10,%r8d
   f:	ba 01 00 00 00       	mov    $0x1,%edx
  14:	e8 75 91 00 00       	callq  0x918e
  19:	49 8b 4d 08          	mov    0x8(%r13),%rcx
  1d:	48 89 c7             	mov    %rax,%rdi
  20:	eb 89                	jmp    0xffffffffffffffab
  22:	0f 1f 40 00          	nopl   0x0(%rax)
  26:	44 09 71 08          	or     %r14d,0x8(%rcx)
  2a:*	48 83 c4 18          	add    $0x18,%rsp		<-- trapping instruction
  2e:	5b                   	pop    %rbx
  2f:	5d                   	pop    %rbp
  30:	41 5c                	pop    %r12
  32:	41 5d                	pop    %r13
  34:	41 5e                	pop    %r14
  36:	41 5f                	pop    %r15
  38:	c3                   	retq   
  39:	4c 3b 62 10          	cmp    0x10(%rdx),%r12
  3d:	7d 08                	jge    0x47
  3f:	4c                   	rex.WR

Code starting with the faulting instruction
===========================================
   0:	48 83 c4 18          	add    $0x18,%rsp
   4:	5b                   	pop    %rbx
   5:	5d                   	pop    %rbp
   6:	41 5c                	pop    %r12
   8:	41 5d                	pop    %r13
   a:	41 5e                	pop    %r14
   c:	41 5f                	pop    %r15
   e:	c3                   	retq   
   f:	4c 3b 62 10          	cmp    0x10(%rdx),%r12
  13:	7d 08                	jge    0x1d
  15:	4c                   	rex.WR


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240916/202409161428.3cc6c1e1-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

