Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240EF301715;
	Wed, 10 Dec 2025 08:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765354163; cv=fail; b=udclSRtSxkcIxrpS0QmSnVS+vr0KUF7tOrXX6E+5kYHYW2b50EFIRHiAKDNwYLrS2dpmaOBtW/PWGx31eqCHtPfOdhIJEpvxq03MTu/pEG2G88bK8R+ZO3/nnbU9o6tzpvGzcVhYM5DHB/xuPR/R0uhwuy9sqCURshIQbjepdR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765354163; c=relaxed/simple;
	bh=ROF7yHPFypPmfAPSeTPz/Ts7PYS9FQRWK/XCHcciBlM=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=uGCz8hTpTk5eLMJ3WVZwTEWtbAsw5IaSYmg6OL3Aqy0bR94yicxS/eEi7abiSsMX8QKBfoO3VOG8Y7pMKDB1IXvfhZMhrocXt/CIZ5fQ1M2R9LHKWDjK62W64+pnGmIrq+D9eLXSFtR20V5YNURsHvfLGPkR+IBxBdQCn6iqgWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JfN8By9C; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JfN8By9C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765354162; x=1796890162;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ROF7yHPFypPmfAPSeTPz/Ts7PYS9FQRWK/XCHcciBlM=;
  b=JfN8By9C8r/FljBMILhM8bOjqJJ/ALFkkPF25SuSP5Q+p5/R9m1ROkwo
   JWPZztWToNRXpTgzKJ7xXIaURlixSCD4eQyK0xpQksgyE/8m9l3LX8gUR
   0P+RQ88/4FFXlPS2ksoGDXD8tfg4VuTJQzmimLXj0A4T1K6x/vpSxdrqb
   Prv6W+5uMq5t66AlieE0CKaGF+eRQNGn6vxQBoFTOrayAss7S3YKIboYS
   LFhOq8MY2j8ZQiKzvPEhb4QArSVVFdFMj8XS3EBFYD+jebVsJwllkgEm/
   Sr3N8p+MvWIo1wlCgmb6d92NmQAsKS9+/MMfKNeVLew7az0/TXFTU51+m
   A==;
X-CSE-ConnectionGUID: xxNdfIhhS9qfk/+akEozoA==
X-CSE-MsgGUID: elC+OFaxTN6A40PmQeXhyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11637"; a="71186187"
X-IronPort-AV: E=Sophos;i="6.20,263,1758610800"; 
   d="scan'208";a="71186187"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 00:09:22 -0800
X-CSE-ConnectionGUID: gD2iNMk9RNiZH9tnwkOENg==
X-CSE-MsgGUID: I+IDf73CTemFU0qvMGssLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,263,1758610800"; 
   d="scan'208";a="196509276"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 00:09:21 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 10 Dec 2025 00:09:21 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 10 Dec 2025 00:09:21 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.3) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 10 Dec 2025 00:09:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mbpy9otHteFKrneOkU4cxHmJJVqjImpKlvGdfloPhPG0UfCTdNgWBoEbR79ggszjgjJdpeKVY0zNh7ih08X4NmFumr8HoKDFFl0fG8yViQnDn75UCzdYOo+yNDZsP0XzrLLIs3RVpNDpeZNAdd8Q7WZK0Cqh2Q6DzHz+7mouDQU+P/1KyKHj2SD/atOTsfwZ/RO/HfI/91SIc9f3YAAZ+IWwfg56qC5E/eW65FFpNWE/CSNF90JsBwe8G5KpEUA75vnaqFNscuXvlkFNgHWDblyLw17eT7UWwbdrX7wIpvwRYhQbm82RUnIiPUNt/SXor3wM2o+TQ0C1/lPY5PUzQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5BVWQjvwEcb6x3VerihG91iUEQ5JLkq0eWDHPSRzrZE=;
 b=b4b3yeqAxCxZfnMHlozTtu86fUtfY09oAuqX+Ho6e/GZuRoZWPC+lB7Iz09VvINy9fY5wIK+A/0a53eINCPhVXb87R/8QBjGpTFBctZLO41c8jppMJCgt1CG7eGSziCa4oaBE0PwEj0OV961hyrPBKmerJokKLPm7+64lyodZzGb1seq9pqGNXiScvYhf2p5ZWmSDt/g0vHMLkwbpM053jvpyHuyMvjqEKxKtz5xjA8HBGyTtO1+m9n5c3LjOD75kLgMDtV/fZJHBQb5c53MF/CcPr+OYoRIHvx0Tzxtp9cvXyc9di/eRTDjP97WgxrsVElrcMUAdnesOoOrLKdnGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ5PPF7CF5FEA5F.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::838) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Wed, 10 Dec
 2025 08:09:18 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 08:09:17 +0000
Date: Wed, 10 Dec 2025 16:09:10 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Namhyung Kim <namhyung@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Ian Rogers <irogers@google.com>, <linux-perf-users@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [perf test]  34e271ae55:
 kmsg.sanitizer.indirect_leak/calloc/zalloc/dso__new_id/__dsos__addnew_id/__dsos__findnew_id/dsos__findnew_id
Message-ID: <202512101502.f3819cd3-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: TPYP295CA0052.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ5PPF7CF5FEA5F:EE_
X-MS-Office365-Filtering-Correlation-Id: d57431be-af89-4d9c-92d5-08de37c36a7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yzhUNoq23C4lpr97A2N1eiPKCLcBRvc4wqksPJIJKFNKF40XXyq4iK8DDQML?=
 =?us-ascii?Q?0zxo1D0n4Mjhd/5WcJR2D853UOteMe1JtJY5exEwAu67FflN00vjVPtSwwO3?=
 =?us-ascii?Q?cs8w8/0im7hsKmLiDxI4hXFTUfP88W7w5XHGBxOGXx25hrdC8pyLCBfsAiYH?=
 =?us-ascii?Q?N700lcD7SyRKh7jHHHBbHJ+OCbsqjR51769pB57Fhn3mByvfkjaKJDEeK0oW?=
 =?us-ascii?Q?gJrBgiruNX/sf1fj/jvdxckjuyQ61umfeqC1gCYlmGKSVXrKEqlARqWE+KhU?=
 =?us-ascii?Q?e7Zfl8TgTfl5impgrb34B7dYCuT6OWpDN9SfrPbfmbd9imqa5a24ySB7Sg5n?=
 =?us-ascii?Q?kNXT+cmsVT0I61uTm8xaNiXko+OerptRUMISfp1Endq1adTAI3zZk21UyjfR?=
 =?us-ascii?Q?KHzP5q7v3FNY+j8L6uqbL2sHSz7BlNao7DpQBDoczbSLglBxf6WYLPLzHphx?=
 =?us-ascii?Q?G1DdoJaTkKzxTV3cYBO6FrHOBqySTEi+16RbdIYFaQ5wTgzkv5sET1Js9hVh?=
 =?us-ascii?Q?jt0Y1haZqXh9v48R0K3WuvQp6zgC2DQgX6kHaAxyVem0YRxp2HrAvts2H8fe?=
 =?us-ascii?Q?jlUmvRyxxbT988iL44IqLYWyQPdkwD63G3fr515aZH4pDXtDi3WOz87mxNw/?=
 =?us-ascii?Q?aaSVR4ddOqZnrgsSspBFdQnHBut4rbh0f3HIHwaIVy3kFJxsC7dKfn5LeVhc?=
 =?us-ascii?Q?bW+4gLHJ/dR4NWd58f4+HezB+R4A+woqG1eBsQmdMWeQ35zBdfU0BdU6m331?=
 =?us-ascii?Q?8Y99EEdq+tN6rlusQgSCxXRoJadHn4vN4PuWf1tBipy5KazhJZMpLrOh2DzN?=
 =?us-ascii?Q?/z1d2X/f5GNPYq96i9HSTWjUqMvX6J3TJVYqqzwcZQEKldIfJXi3TncXuluP?=
 =?us-ascii?Q?wKtXDjhqHHzsROiMi4navJZDMS3WVAmIksd6sF/a5W5IARxvs67P1hVQzmQn?=
 =?us-ascii?Q?R7/aTek+bIhp7Lou9wGWHNyaOttgNPzGXc85rZHmWWjRP2vDnBdDSnurFbt2?=
 =?us-ascii?Q?YklwG4aYfrHtIJv6p7XdD2JaPdv+NwsfTcuwIhemqR/ALtsWITbCeo7k/r6M?=
 =?us-ascii?Q?GIkwkK49aXo/CH3P1caIPA5qyUy5Ev0tfwVP5/sL3daddDTmbr5HoOgB+FGV?=
 =?us-ascii?Q?xcLllDdPy0ikI6MOyj3TeNBy7Axj6jJhy/MsjztaV3YvttGbLBbEspjaiXCK?=
 =?us-ascii?Q?5GjxqCaC232yqsIj63irBfc4/N8T5vCkyURFFNs1OWrK4BFClT75pFukrGSR?=
 =?us-ascii?Q?OnubsxaQ4/0OI5rte0K77WbMaE+wNRpv+QyJ/cRGGFhIzHJ7jHI9L6VsRX3Q?=
 =?us-ascii?Q?bQ0JVeMh0FOLia1f/CNMCBMb5BWxdsASR3doWt4AtDzaRd0yigQxjFdMzkPG?=
 =?us-ascii?Q?FJjca4H1LmTTSAtaW+2BpSpmnWnZb38K5/SzheCYNKiRdDwuyCxhkRixaFWN?=
 =?us-ascii?Q?8L2Hmr4OnJg7zSOxHPeu4vnS7jHPnnw/rWFfcS5KCrN7pUQOUQU5pQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dnEr2I5bXecaIbdrbVzHOoeNWRUpn2if0bi5Ks4qeO9wbz9WNujJ7FXIKnAf?=
 =?us-ascii?Q?v7HhK5u4kOrIuWvCeRUFamA+01/8EANo8AIblOgBU8ezZJ/1yLPPuybtZspQ?=
 =?us-ascii?Q?9UsW7MqINItS49mn8b8TiQZ3VpcFmSI+WDms9VZps7fAtYu+PJk/6G1OSqrG?=
 =?us-ascii?Q?ipfXqgVUpcEHzvr+lIgYC7m0sbc1Udq/QrrmCoA0vhMCObbS9YAYmfRL4knE?=
 =?us-ascii?Q?MiykGLrLnhrgrhOcND7V1LdAlR/8tbcbcM+b+H9VpPSC2yHnzKHh/uE8Z8Cn?=
 =?us-ascii?Q?wp9ZktSbJ0Ge+FouXW86qSk2OFqK3+jVmhzbluM7fsSCpZo3WB1AXOw+77bP?=
 =?us-ascii?Q?paCiI0bDhVbt7NKGZi3mY7NQI9rQhUORtyW42YztyGUutkyjFqWcbmHWhBbn?=
 =?us-ascii?Q?jCPEdCrUUvUU9Vv1YnvtHoDXqNFGUtRj6XOMsV/otKaGDxxSG3RMrnf6vI33?=
 =?us-ascii?Q?9LVRYHlF3ZRbo2D4EMXxzTebXmRp3gEu2Ms2h1WzZY5gxPVaXL1FJH121a1C?=
 =?us-ascii?Q?WJlXIuSVjrqdQWClQBwNotC8avjR8tNkTSmkMfKKCawQeulwGPTmKinN5Jhy?=
 =?us-ascii?Q?AzQzIm4Irgh+aEAADcuRpuWIGak5Mj911H6rp7fJy7p8LG4QCF9Woop9WW21?=
 =?us-ascii?Q?4MFIUDvQJMj8sxyAgCpYi+ZtC4Jyzdm7+08FrEnr5kdFAsmT8dmEbwg1WwY6?=
 =?us-ascii?Q?evdfdb3wFBAXv8Rdq8ZxS64obpGkdCWqz0wJgJm5iT5e343S4sfDccaRYhLu?=
 =?us-ascii?Q?ZSnXzjukiB2bXWgJxGWybe1b/UlYUGUFBxpIhCadZ+ehIXMM94KlwqgTFpHM?=
 =?us-ascii?Q?CepQXiaA2BsGZXeO1aWZ9SWHbH9vZNYUQpBSzQmnIRxTLLRUXjdqve2qRmfs?=
 =?us-ascii?Q?EICOGRSgTTCVZhQg/ICoPP8vBU9fuM0czq30cZr83S7Ag4QVFYT1jTP8ABxN?=
 =?us-ascii?Q?vmel6lQeK5HUGbrhlsPs80iPhW2jaSO3xA9ENMWwez4jHMJVEItgpNGm25b4?=
 =?us-ascii?Q?Ohesj4Ko6tEA1pA4JFocm8gPYo0s9QFDgq51CwrfcHPpck0VXU9rB1tfh60i?=
 =?us-ascii?Q?D4m0dFbs5zYJas8Y6v8P4djYVS87YzScTdM6CPwXzR9rrUM8oC591MNBBUOt?=
 =?us-ascii?Q?cs3AOVINL/FQaa2ZJwsabHbc/L0fwPL2nelPIXv2J5AoTkGOPtVAS89CKtlM?=
 =?us-ascii?Q?l3gSJ70e/G5drajgKZE+JxYxwz7+q9Dl7F7c6hKHA4yt5BLKM7aPsyoxfaOK?=
 =?us-ascii?Q?O3vovECGI8QS9FSIf85KxXZOSa6H65/LtmJKHpg2DtXemY8e0RtvOjB1pQmC?=
 =?us-ascii?Q?QwX5LM8UANyBCJyJeJQ/SX26DDuQ/dNHR7Sx0sFz9MKurlRMUpnnO7QSfOpT?=
 =?us-ascii?Q?Pv0wDX9sVkQKnTY0mQVHiQoB9Jva0kNJSmqLCXGhbac/chxQkyMg6d6bvWF2?=
 =?us-ascii?Q?manrJn2/RJ0ZPWFxmW4TvS2byZPWjW430NP9ZQMTPS1il7N3EJPhtG2S8uUF?=
 =?us-ascii?Q?FXVW/r91/blnT9GuM+k1cdOBISEqO/QMVRupimGfhalO5Uk+yvnn3gqD83Sl?=
 =?us-ascii?Q?urYlcr1dtzt55tLb4OatKObTBuDgSlvAS9CeoEIjmFAbSr4AMMReaz7VJj84?=
 =?us-ascii?Q?4Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d57431be-af89-4d9c-92d5-08de37c36a7e
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 08:09:17.8857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BGk5xkiRWUS7ZJFeLG26BV2yMVkmP4LYU/Y71crveC7ZmiYlKLD/YrwiwBmPIkrMikJOTDORhAkjdooBOBG36Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF7CF5FEA5F
X-OriginatorOrg: intel.com



Hello,


besides the indirect_leak mentioned in title, we also observe below difference
if comparing to parent commit.


4fba95fc383f9231 34e271ae55382fbdb04f3e13e85
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :8           75%           6:6     kmsg.sanitizer.direct_leak/malloc/map__get/maps__find_symbol_by_name_cb/maps__for_each_map/maps__find_symbol_by_name/machine__find_kernel_symbol_by_name
           :8           75%           6:6     kmsg.sanitizer.indirect_leak/calloc/map__new2/__machine__create_kernel_maps/machine__create_kernel_maps/test__kallsyms_split/run_test_child
           :8           75%           6:6     kmsg.sanitizer.indirect_leak/calloc/symbol__new/map__process_kallsym_symbol/kallsyms__parse/dso__load_all_kallsyms/__dso__load_kallsyms
           :8           75%           6:6     kmsg.sanitizer.indirect_leak/calloc/zalloc/dso__new_id/__dsos__addnew_id/__dsos__findnew_id/dsos__findnew_id
           :8           75%           6:6     kmsg.sanitizer.indirect_leak/malloc/dso__get/map__init/map__new2/__machine__create_kernel_maps/machine__create_kernel_maps
           :8           75%           6:6     kmsg.sanitizer.indirect_leak/malloc/symbols__sort_by_name/dso__sort_by_name/map__find_symbol_by_name_idx/map__find_symbol_by_name/maps__find_symbol_by_name_cb


but we don't have enough knowledge to understand if they are expected by the
change is 34e271ae55, so just make out below report FYI.


kernel test robot noticed "kmsg.sanitizer.indirect_leak/calloc/zalloc/dso__new_id/__dsos__addnew_id/__dsos__findnew_id/dsos__findnew_id" on:

commit: 34e271ae55382fbdb04f3e13e856457d8e0dee45 ("perf test: Add kallsyms split test")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linux-next/master 6987d58a9cbc5bd57c983baa514474a86c945d56]

in testcase: perf-sanity-tests
version: 
with following parameters:

	perf_compiler: clang
	group: group-02



config: x86_64-rhel-9.4-bpf
compiler: gcc-14
test machine: 16 threads 1 sockets Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz (Coffee Lake-E) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202512101502.f3819cd3-lkp@intel.com


Indirect leak of 386 byte(s) in 1 object(s) allocated from:
    #0 0x7f0248972610 in calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x561eb21740b6 in zalloc ../../lib/zalloc.c:8
    #2 0x561eb2529d8f in dso__new_id util/dso.c:1527
    #3 0x561eb25327bb in __dsos__addnew_id util/dsos.c:329
    #4 0x561eb253287d in __dsos__findnew_id util/dsos.c:351
    #5 0x561eb2532907 in dsos__findnew_id util/dsos.c:358
    #6 0x561eb25d267f in machine__findnew_dso_id util/machine.c:3191
    #7 0x561eb25d26ce in machine__findnew_dso util/machine.c:3196
    #8 0x561eb252778e in machine__findnew_kernel util/dso.c:1338
    #9 0x561eb25bbfe0 in machine__get_kernel util/machine.c:969
    #10 0x561eb25c0d10 in machine__create_kernel_maps util/machine.c:1545
    #11 0x561eb231f3be in test__kallsyms_split tests/kallsyms-split.c:117
    #12 0x561eb223b4d8 in run_test_child tests/builtin-test.c:340
    #13 0x561eb218d899 in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-34e271ae55382fbdb04f3e13e856457d8e0dee45/tools/lib/subcmd/run-command.c:128
    #14 0x561eb223d9b4 in start_test tests/builtin-test.c:545
    #15 0x561eb223e920 in __cmd_test tests/builtin-test.c:648
    #16 0x561eb22412d3 in cmd_test tests/builtin-test.c:850
    #17 0x561eb214751d in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-34e271ae55382fbdb04f3e13e856457d8e0dee45/tools/perf/perf.c:349
    #18 0x561eb2147e0e in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-34e271ae55382fbdb04f3e13e856457d8e0dee45/tools/perf/perf.c:401
    #19 0x561eb2148364 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-34e271ae55382fbdb04f3e13e856457d8e0dee45/tools/perf/perf.c:445
    #20 0x561eb2148b0b in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-34e271ae55382fbdb04f3e13e856457d8e0dee45/tools/perf/perf.c:553
    #21 0x7f023e69aca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)


more details are in below link.


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251210/202512101502.f3819cd3-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

