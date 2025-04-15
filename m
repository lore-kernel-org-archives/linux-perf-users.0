Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4F923F410;
	Tue, 15 Apr 2025 08:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744704129; cv=fail; b=rapqT5IxCZmP4Ne6kMUxoAPAUBHChBoncamV6W5VM082O/tYwGAMTQucbaf3xD0AnHp6Wc/BttjZwHhCVgfA9p44ewvoIAFrHlT2BUepG75eycZxXktsp7XR/CaBIKlfIzCqw5k1yFsk7fRrrrf9TIvj35P7/YkIzBZ//iE2E4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744704129; c=relaxed/simple;
	bh=Ga1FFNtEmK6HthJPRxrAqOrg7vequmuKq9bdFRAFfms=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=OJOaf21TJ4UwH5w0ZYeeUqg+FUAwxjU/TRQCzqxIjI7VnAxtwY6xTQ71lCm0ykv2u9+sTaRvfnASvz4Al4QN6NVns2dvSzBG2zNazJpeDfvf+58E5U14B9vTILZDWT1FYt8z6ahuIVrPYveRzVbQrCM0sPSaCHqm7Sm9T0Cn/jE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=me+QYl0B; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="me+QYl0B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744704127; x=1776240127;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ga1FFNtEmK6HthJPRxrAqOrg7vequmuKq9bdFRAFfms=;
  b=me+QYl0Bgj/h8ATQO2pMcPvQ/ISXgLlxkxD6sRh4E6FaSJuhsqwJyldw
   +nfm0w1k5xRm9c/jxlwHH/LJaaXpNHm7FswjHIsUg/U/ARPUReNVGu8Y1
   lNQi3p1YUQC2YDD7gVuh4JaCr6nQGgxD9Fx4EKj26qsqtLvte9zsb96Rm
   M8lC5UZswuNP9VtiMK5H/gHAl6Tk8ocmg0lRgYYKMeD47FcD3dqz62Cut
   rvX/mK9U8bJIx9zzpU9oCd968LS0WbD2aEDSkBRsObpbOXj6kAl8C2ZG+
   olue3qaLYRn6Vl/ja9VnJpDyGiPrK1d54VwNR2nnjlXV2QLvwTrRUGZ8L
   A==;
X-CSE-ConnectionGUID: BZDyfJP5RoOXG9h+dggxdg==
X-CSE-MsgGUID: CxanoGH5T/Ws1QY3/W2u7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="46332578"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="46332578"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 01:02:00 -0700
X-CSE-ConnectionGUID: P5M5OGHaRVC0keEv9mYvDQ==
X-CSE-MsgGUID: x4fZAAMrTSC+Mn6KTD2bkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="161093860"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 01:01:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 15 Apr 2025 01:01:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 15 Apr 2025 01:01:59 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 15 Apr 2025 01:01:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZtHBz+tyQqEyw1zhrHNl8Iem0/tFEWlsXDUx/CNwFj0eBldYlUFIzMtVo0A72tOMx0qEoiQac0+dewtxVaCAgJvQQPJtjvDgo4uVNLto2uv+CZEhCwfsDhBJZ8VLgTkEg4zoTEF81MRRKgnGDYwiYkqbUMnal4dJ8UAQ959k/pXrpjAW9ZkcFPb51xadW0cnlzHBpFBcEKeySIq7BQSUIRGEHyba6yCgdLw6Y0FwMzGfcxdFQtu34UYTVWSPwpZNjPrRvlpAoRe9cPv/uwqgxFVGwisi3wkBDFIzz77P+wVH9UeItd9UURO52Bem4ZnngxK0a/mKQzfkXoWMP+3xow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XOaDvFZzv5YlrFIopfkqi0R+M0UMS209w28VgDuG60=;
 b=AJOJ4IBzpKJ30rOV39Nn6zoCywJMz3xuHZQvWEiGU+Y1n9gfYPEL1q87v7fDZvhtI5GpWpOdxzNAXGbWPbIw0IlRPDcqYSBoUXwB1HQea2tk+hfl220LHBNbklsbnRa9ND2kJhvDrlz1kaSxx0cVAYtdXF/niMsXAJtn+EZ5GnBn1JfIG4IibyaxT6ZkzN5MSwZDon17s7wnDYHoK8tNzx/zGFg1FnZzYtq5YuUJH4t0zFFBI/+cZyfke1BRWB0QCyow2j9iafSWasonxwBvLcq9+jDZHkXEQPx+Afq+kjqixbTejGYUpOOHdYuDNNQsGdZfTKkmppAb3rNaJxFZnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CYYPR11MB8408.namprd11.prod.outlook.com (2603:10b6:930:b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 08:01:42 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8632.035; Tue, 15 Apr 2025
 08:01:42 +0000
Date: Tue, 15 Apr 2025 16:01:33 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Stephen Brennan <stephen.s.brennan@oracle.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo
	<acme@redhat.com>, <linux-perf-users@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [perf symbol]  b10f74308e:
 perf-sanity-tests.perf_annotate_basic_tests.fail
Message-ID: <202504151510.3bb1707c-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR01CA0144.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::24) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CYYPR11MB8408:EE_
X-MS-Office365-Filtering-Correlation-Id: fd36f281-cbc2-4508-9b4e-08dd7bf3c24b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?31hNBraDaldfEzi+zA26qfoXKEex8mtqu9AH4p+a3f0fxrEI6Fj1l4WvS3Gl?=
 =?us-ascii?Q?7n9uou0T7shYXpzh1s1mZVMLFPeVVlAtNmPy9FRPfNPI9dx16ndmJ3xvDWWG?=
 =?us-ascii?Q?sySHoHq8cJOoTW5pYRhrnUftTwO4qEx/vksjld/yav1z+dqtVLbUUhmB9RXC?=
 =?us-ascii?Q?BJuEiWDSxA5ADjD3h0/yw1PDtC2gdDzopOO9c1LrOTWsl1M++G70jajb313K?=
 =?us-ascii?Q?xc27LLHwWWb0xC9Qu8STwhsuQUDvMOYQAzLQNQvnuSNWwXs+b4Fz9MpSmFo5?=
 =?us-ascii?Q?GsgSyLVhc/G3fdKG7USVP8rCcCVNBt23Qy7iMaiFtNfP6FObbF4whL7xZ3Nw?=
 =?us-ascii?Q?5zC57rdaxtvQSsBPwDHrxybqVMO/KRyDL8jUXYTz9RNtN58TDiX06g+BFzCv?=
 =?us-ascii?Q?NS3TDlibB0nFfUaaob8YvEzMTB3ieA9MgmsOdBtAnM2A4A49+vTcyrJRe6iq?=
 =?us-ascii?Q?VLmZhU/msvkFC+m/5ffH0Brx4JbXBDs5n7AXnwC1fpz3EGVM/iJnObNdvTH8?=
 =?us-ascii?Q?h/VJXKUecTuaidCs7TVUpGnyzA503GSzM/bmMGHJQnTWMLbHX0VHQSvIzpdK?=
 =?us-ascii?Q?i2GKpe3VvdoSij0AYUqz+36RHIsfOjI4NHwLZv09doVi7FyFsfybVFaogxbm?=
 =?us-ascii?Q?ngHOOYxsGvacMQQblguDyj94UJJ/59MrgWn5LbhyGPlshaS2iJ83xdSybYqz?=
 =?us-ascii?Q?wzzWXK0qgNM0wwd6kovTTM4jAic7hXn0Ha7auPpkXKgMW++dff5n+VCBdUo0?=
 =?us-ascii?Q?c4KRGRfTBlhCqRmJOCwjSXK844V97A21TQ4AAMG7HMSyFYRiHQOHotGpgjT/?=
 =?us-ascii?Q?QA6pqEnJ/41wiHOBrYOYc6tJDGSAy3GbSEjaHXIQ6Ini9Y7QIMWcp/dw7wdd?=
 =?us-ascii?Q?3+b2O8NuYF/A75q6A8mxyjRKurSSUGdp1cpnqECyDlN3GKZ3TD1itAECLH/I?=
 =?us-ascii?Q?sMrK72PfQbp1QIxWS5Ki40hxVzJTUTaUfL/SGb48wTUIauf3WUrpcnFgj6rB?=
 =?us-ascii?Q?jExEPTv8lZ/sokZ3N69tJMf7QRKC6lINLRVv+VOkNaDc3fs3UIWcIkugSs4K?=
 =?us-ascii?Q?QIc8MGHAEOzEdJFQ3X/p8rQxUYNgjn3TLXWQoKLLwcgBjg5dakGSUTann0Ef?=
 =?us-ascii?Q?oWnH1b+eNpIjZD6hKlLyHN+To8sW0zsDVpCM3uTs4Kq8THRBnLt/ZWVheCP1?=
 =?us-ascii?Q?t9L04KdtWkOJCu2YjbF+RzqztBKdjAgjCexIsjKzMnmwowcGxrisUv7IWhLS?=
 =?us-ascii?Q?yVbK6GkU2+loeFcl4o6OXnLF60n+RqA0ONCphmnfZXnssx1cTunohL+xOt4G?=
 =?us-ascii?Q?wOBckrvVF2Z7mNpBQuf1L/54ytonaSORaYZJ90n8SxojP0ivV87ZRUnnNuN6?=
 =?us-ascii?Q?llPzxMXT6fFf9ba5sHRKCA2+tAap?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R97M/olA9vmv+L0j6azYzjtsMaNK4tpl25z7/jXrKutiCT2fBC/I+1tM8sGL?=
 =?us-ascii?Q?ClksTK7gVdA9XvwSocAAJ9mpMtj6Kd5Q4DlFCeTqlVp+3NmeBoYHTjMMCJNR?=
 =?us-ascii?Q?ZE8QdMq06onfJeRz4hG7uewgQtyxQmNhcKa67GeJ64+p86vqkgatgeZSKHVd?=
 =?us-ascii?Q?MntwyPjxB3FsVstB0sBafzjN/VG4F9p5mKCgLCYXBZ28T/E1ky3eQeMEzWAM?=
 =?us-ascii?Q?j++t+ug6aF2IKJK4TtqjiBVjjjYwOpMrgJgKXaK4BkxDh4+GzEBpNY0o88B4?=
 =?us-ascii?Q?Wydxn4SPLuZ3uiyZxhufHoLkpzADJtdbsqf5UgJZHtLjlvoR0VehGDaxvGbS?=
 =?us-ascii?Q?0XxyNho5QGZRtcLxoaloJAnVLrXYOx7i3jNM/fYg7gMKAM6EXuMSKh9LA81u?=
 =?us-ascii?Q?uZprFpneoMENDujSeigh9VRuSN9yXcZRMZAmdCuI63nwxcR5mFIGzriZIfR1?=
 =?us-ascii?Q?c8yQ7DHmUTUoStn3ovbUh2b1o/VQyRbLRRJm8zHPd0F/ZpeKSdFxkkeT6wnk?=
 =?us-ascii?Q?Y3G5ssPpQa1UIOJ306ozD+MgvgyjZZgAkAwVDmFkwqfnPfx+V6KVkkQYqGPe?=
 =?us-ascii?Q?KhYVnRg57jtRc2a8JBjsCAMEv04GCXx9PxGD63drEspUmPcjl4lKZ/eHKey1?=
 =?us-ascii?Q?odeKR+XFGPq7pYn8IUy6pmVm+ikGVV/ttE6sa+zaoL7yAalv4wPNcuCyoHcv?=
 =?us-ascii?Q?F1iMNarGt8cWGyr7Zm9EiiMAwf9lUrMYxVCwzd2TWI3XUXWWxBO+eQTUQ1RD?=
 =?us-ascii?Q?+5MX/x3SzSIKK7aiLOTj0EjFynN3cWpWHqkKLTEkaFXdeNC8CXqY1+kXJ2js?=
 =?us-ascii?Q?3SfJONagpp92T11OjtZCQnRgqtvb6LE9UYMsY68rogesEdsgxp4CJtH2FbLh?=
 =?us-ascii?Q?Li5rQTzIczyFlLL/fsFD69Fdj69wRM3/zKPsHv9LKbPCjdQ1VGHZbMerP4VY?=
 =?us-ascii?Q?hyzgofK2SWIqahoeozULer9OdVhKexrZy8BfAiWbkf7/VMeZuK4Yff1edKUE?=
 =?us-ascii?Q?5TFR8rS3rP9I6+SuiMvJwiVLaZCuTV6vvbO4bYYmPy7qr/eEFOavQba5+3JF?=
 =?us-ascii?Q?pHZ6NCj4ztrUqCaqhyplBMZ1LxEMd10C873T68VQB0UZVP5ftQIn1no4EvaO?=
 =?us-ascii?Q?IxubxBuicBnBi1y4E70aFAnXKi7qSQ4E74kyVjgmz9oYM0XhhKM0ZsajRYij?=
 =?us-ascii?Q?m6/iB7fXPGPXuA3SQPpBBH7PFb+JeFTIIXMnq4QN00gMJY8v4HX38f8Zs7mU?=
 =?us-ascii?Q?eKRzQKsnPPpUKOMXbTEM+CmR+E4bKEnFK/ShIl1c48zuELTzZ+MxQ+PLSodD?=
 =?us-ascii?Q?0XMfaXSIEAfox+R6coyxbWdvQNb1y9LsFfZTY1OVj8Yqu4FbxW8nkwQQiv6l?=
 =?us-ascii?Q?wnHx8P8msAHlxaIYXx8MlCKnWljDhiPQRY9SHq5qcR41j6KbxSUdFH2z8WQF?=
 =?us-ascii?Q?pQ3UJn8Ng5ps3z+3YeQ+vZp0nyHQnbHokteenx+aHb4hc6OUrzK+fFPzsDys?=
 =?us-ascii?Q?Lj4dMYWBoylVHA+OQqmyx+1VyCakTKouLG7ErShHSHn6YWH2MYj9ySf9HMJO?=
 =?us-ascii?Q?UBLvsMlNT9GiNHnq5+KiwVMGb2G6juk8XbEpVrJdMnxj0h2seRXL/o3tLNrq?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd36f281-cbc2-4508-9b4e-08dd7bf3c24b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 08:01:42.5189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K+ul38rW1OF3YI31SEUYbkx9WCnHfglgfhtVYOuISkfObnudanrT/U/WADAQJQQ9SGsy3qU0fGMJ/hNqd3fIkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8408
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "perf-sanity-tests.perf_annotate_basic_tests.fail" on:

commit: b10f74308e1305275e69ddde711ec817cc69e306 ("perf symbol: Support .gnu_debugdata for symbols")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

in testcase: perf-sanity-tests
version: 
with following parameters:

	perf_compiler: clang



config: x86_64-rhel-9.4-bpf
compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4790T CPU @ 2.70GHz (Haswell) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202504151510.3bb1707c-lkp@intel.com



2025-04-14 05:26:15 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-b10f74308e1305275e69ddde711ec817cc69e306/tools/perf/perf test 75 -v
 75: perf annotate basic tests                                       : Running (1 active)
--- start ---
test child forked, pid 8660
 136f720-136f819 l noploop
perf does have symbol 'noploop'
Basic perf annotate test
         : 0       0x136f720 <noploop>:
    0.00 :   136f74a:        jle     0x136f7bb <noploop+0x9b>
    0.00 :   136f755:        je      0x136f762 <noploop+0x42>
    0.00 :   136f760:        je      0x136f774 <noploop+0x54>
    0.00 :   136f78b:        je      0x136f795 <noploop+0x75>
    0.00 :   136f79f:        jne     0x136f7b0 <noploop+0x90>
    0.00 :   136f7ed:        jmp     0x136f7f0 <noploop+0xd0>
   94.98 :   136f7f8:        je      0x136f7ef <noploop+0xcf>
    0.00 :   136f80c:        je      0x136f813 <noploop+0xf3>
    0.00 :   136f720:        pushq   %rbp
    0.00 :   136f721:        movq    %rsp, %rbp
    0.00 :   136f724:        pushq   %rbx
    0.00 :   136f725:        subq    $0x28, %rsp
    0.00 :   136f729:        movl    %edi, -0x24(%rbp)
    0.00 :   136f72c:        movq    %rsi, -0x30(%rbp)
    0.00 :   136f730:        movq    %fs:0x28, %rax
    0.00 :   136f739:        movq    %rax, -0x18(%rbp)
    0.00 :   136f73d:        xorl    %eax, %eax
    0.00 :   136f73f:        movl    $0x1, -0x1c(%rbp)
    0.00 :   136f746:        cmpl    $0x0, -0x24(%rbp)
    0.00 :   136f74a:        jle     0x136f7bb <noploop+0x9b>
    0.00 :   136f74c:        movq    -0x30(%rbp), %rax
    0.00 :   136f750:        cmpq    $0x0, -0x30(%rbp)
    0.00 :   136f755:        je      0x136f762 <noploop+0x42>
    0.00 :   136f757:        movq    %rax, %rdx
    0.00 :   136f75a:        andl    $0x7, %edx
    0.00 :   136f75d:        testq   %rdx, %rdx
    0.00 :   136f760:        je      0x136f774 <noploop+0x54>
    0.00 :   136f762:        movq    %rax, %rsi
    0.00 :   136f765:        leaq    0x1727c14(%rip), %rax  # 0x2a97380
    0.00 :   136f76c:        movq    %rax, %rdi
    0.00 :   136f76f:        callq   0xf1bc70 <_init+0x1c70>
    0.00 :   136f774:        movq    -0x30(%rbp), %rax
    0.00 :   136f778:        movq    %rax, %rdx
    0.00 :   136f77b:        shrq    $0x3, %rdx
    0.00 :   136f77f:        addq    $0x7fff8000, %rdx
    0.00 :   136f786:        movzbl  (%rdx), %edx
    0.00 :   136f789:        testb   %dl, %dl
    0.00 :   136f78b:        je      0x136f795 <noploop+0x75>
    0.00 :   136f78d:        movq    %rax, %rdi
    0.00 :   136f790:        callq   0xf1c540 <_init+0x2540>
    0.00 :   136f795:        movq    -0x30(%rbp), %rax
    0.00 :   136f799:        movq    (%rax), %rbx
    0.00 :   136f79c:        testq   %rbx, %rbx
    0.00 :   136f79f:        jne     0x136f7b0 <noploop+0x90>
    0.00 :   136f7a1:        leaq    0x1727c58(%rip), %rax  # 0x2a97400
    0.00 :   136f7a8:        movq    %rax, %rdi
    0.00 :   136f7ab:        callq   0xf1a060 <_init+0x60>
    0.00 :   136f7b0:        movq    %rbx, %rdi
    0.00 :   136f7b3:        callq   0xf1cdd0 <_init+0x2dd0>
    0.00 :   136f7b8:        movl    %eax, -0x1c(%rbp)
    0.00 :   136f7bb:        leaq    -0xdd(%rip), %rax  # 0x136f6e5 <sighandler>
    0.00 :   136f7c2:        movq    %rax, %rsi
    0.00 :   136f7c5:        movl    $0x2, %edi
    0.00 :   136f7ca:        callq   0xf1ba60 <_init+0x1a60>
    0.00 :   136f7cf:        leaq    -0xf1(%rip), %rax  # 0x136f6e5 <sighandler>
    0.00 :   136f7d6:        movq    %rax, %rsi
    0.00 :   136f7d9:        movl    $0xe, %edi
    0.00 :   136f7de:        callq   0xf1ba60 <_init+0x1a60>
    0.00 :   136f7e3:        movl    -0x1c(%rbp), %eax
    0.00 :   136f7e6:        movl    %eax, %edi
    0.00 :   136f7e8:        callq   0xf1ca50 <_init+0x2a50>
    0.00 :   136f7ed:        jmp     0x136f7f0 <noploop+0xd0>
    5.02 :   136f7ef:        nop
    0.00 :   136f7f0:        movl    0x232804a(%rip), %eax  # 0x3697840 <done>
    0.00 :   136f7f6:        testl   %eax, %eax
   94.98 :   136f7f8:        je      0x136f7ef <noploop+0xcf>
    0.00 :   136f7fa:        movl    $0x0, %eax
    0.00 :   136f7ff:        movq    -0x18(%rbp), %rdx
    0.00 :   136f803:        subq    %fs:0x28, %rdx
    0.00 :   136f80c:        je      0x136f813 <noploop+0xf3>
    0.00 :   136f80e:        callq   0xf1a2c0 <_init+0x2c0>
    0.00 :   136f813:        movq    -0x8(%rbp), %rbx
    0.00 :   136f817:        leave
    0.00 :   136f818:        retq
    6.67 :   ffffffff818c8b80:        cmpq    $-0x4, %rdi
   15.52 :   ffffffff818c8b84:        movq    (%rsp), %rsi
    3.32 :   ffffffff818c8b88:        jae     0xffffffff818c8bed <__asan_load4_noabort+0x6d>
    1.87 :   ffffffff818c8b8a:        jmp     0xffffffff86116749 <_einittext+0x3258>
    0.00 :   ffffffff818c8b8f:        movabsq $-0x100000000000000, %rax
    0.00 :   ffffffff818c8b99:        jmp     0xffffffff818c8ba5 <__asan_load4_noabort+0x25>
    1.64 :   ffffffff818c8b9b:        movabsq $-0x800000000000, %rax
    3.62 :   ffffffff818c8ba5:        cmpq    %rax, %rdi
    0.00 :   ffffffff818c8ba8:        jb      0xffffffff818c8bed <__asan_load4_noabort+0x6d>
    3.85 :   ffffffff818c8baa:        leaq    0x3(%rdi), %rax
    1.67 :   ffffffff818c8bae:        movq    %rax, %rdx
    4.95 :   ffffffff818c8bb1:        andl    $0x7, %edx
   10.06 :   ffffffff818c8bb4:        cmpq    $0x2, %rdx
    0.00 :   ffffffff818c8bb8:        jbe     0xffffffff818c8bd5 <__asan_load4_noabort+0x55>
    7.71 :   ffffffff818c8bba:        movabsq $-0x2000040000000000, %rcx
    3.72 :   ffffffff818c8bc4:        shrq    $0x3, %rax
   26.53 :   ffffffff818c8bc8:        movzbl  (%rax,%rcx), %eax
    4.43 :   ffffffff818c8bcc:        testb   %al, %al
    0.00 :   ffffffff818c8bce:        jne     0xffffffff818c8c08 <__asan_load4_noabort+0x88>
    3.88 :   ffffffff818c8bd0:        jmp     0xffffffff82c66560 <__x86_return_thunk>
    0.00 :   ffffffff818c8bd5:        movabsq $-0x2000040000000000, %rcx
    0.00 :   ffffffff818c8bdf:        movq    %rdi, %r8
    0.00 :   ffffffff818c8be2:        shrq    $0x3, %r8
    0.00 :   ffffffff818c8be6:        cmpb    $0x0, (%r8,%rcx)
    0.00 :   ffffffff818c8beb:        je      0xffffffff818c8bfc <__asan_load4_noabort+0x7c>
    0.00 :   ffffffff818c8bed:        movq    %rsi, %rcx
    0.00 :   ffffffff818c8bf0:        xorl    %edx, %edx
    0.00 :   ffffffff818c8bf2:        movl    $0x4, %esi
    0.00 :   ffffffff818c8bf7:        jmp     0xffffffff818c7930 <kasan_report>
    0.00 :   ffffffff818c8bfc:        shrq    $0x3, %rax
    0.00 :   ffffffff818c8c00:        movzbl  (%rax,%rcx), %eax
    0.00 :   ffffffff818c8c04:        testb   %al, %al
    0.00 :   ffffffff818c8c06:        je      0xffffffff818c8bd0 <__asan_load4_noabort+0x50>
    0.00 :   ffffffff818c8c08:        cmpb    %dl, %al
    0.00 :   ffffffff818c8c0a:        jle     0xffffffff818c8bed <__asan_load4_noabort+0x6d>
    0.56 :   ffffffff818c8c0c:        jmp     0xffffffff82c66560 <__x86_return_thunk>
    4.91 :   ffffffff818c8ce0:        cmpq    $-0x8, %rdi
   13.43 :   ffffffff818c8ce4:        movq    (%rsp), %rcx
    4.19 :   ffffffff818c8ce8:        jae     0xffffffff818c8d4d <__asan_load8+0x6d>
    0.96 :   ffffffff818c8cea:        jmp     0xffffffff8611676d <_einittext+0x327c>
    0.00 :   ffffffff818c8cef:        movabsq $-0x100000000000000, %rax
    0.00 :   ffffffff818c8cf9:        jmp     0xffffffff818c8d05 <__asan_load8+0x25>
    1.39 :   ffffffff818c8cfb:        movabsq $-0x800000000000, %rax
    4.60 :   ffffffff818c8d05:        cmpq    %rax, %rdi
    0.00 :   ffffffff818c8d08:        jb      0xffffffff818c8d4d <__asan_load8+0x6d>
    2.09 :   ffffffff818c8d0a:        leaq    0x7(%rdi), %rax
    0.86 :   ffffffff818c8d0e:        movq    %rax, %rdx
    3.46 :   ffffffff818c8d11:        andl    $0x7, %edx
   18.62 :   ffffffff818c8d14:        cmpq    $0x7, %rdx
    0.00 :   ffffffff818c8d18:        jne     0xffffffff818c8d35 <__asan_load8+0x55>
    1.40 :   ffffffff818c8d1a:        movabsq $-0x2000040000000000, %rdx
    3.31 :   ffffffff818c8d24:        shrq    $0x3, %rax
   26.75 :   ffffffff818c8d28:        movzbl  (%rax,%rdx), %eax
   10.53 :   ffffffff818c8d2c:        testb   %al, %al
    0.00 :   ffffffff818c8d2e:        jne     0xffffffff818c8d59 <__asan_load8+0x79>
    3.51 :   ffffffff818c8d30:        jmp     0xffffffff82c66560 <__x86_return_thunk>
    0.00 :   ffffffff818c8d35:        movabsq $-0x2000040000000000, %rsi
    0.00 :   ffffffff818c8d3f:        movq    %rdi, %r8
    0.00 :   ffffffff818c8d42:        shrq    $0x3, %r8
    0.00 :   ffffffff818c8d46:        cmpb    $0x0, (%r8,%rsi)
    0.00 :   ffffffff818c8d4b:        je      0xffffffff818c8d62 <__asan_load8+0x82>
    0.00 :   ffffffff818c8d4d:        xorl    %edx, %edx
    0.00 :   ffffffff818c8d4f:        movl    $0x8, %esi
    0.00 :   ffffffff818c8d54:        jmp     0xffffffff818c7930 <kasan_report>
    0.00 :   ffffffff818c8d59:        cmpb    $0x7, %al
    0.00 :   ffffffff818c8d5b:        jle     0xffffffff818c8d4d <__asan_load8+0x6d>
    0.00 :   ffffffff818c8d5d:        jmp     0xffffffff82c66560 <__x86_return_thunk>
    0.00 :   ffffffff818c8d62:        shrq    $0x3, %rax
    0.00 :   ffffffff818c8d66:        movzbl  (%rax,%rsi), %eax
    0.00 :   ffffffff818c8d6a:        testb   %al, %al
    0.00 :   ffffffff818c8d6c:        je      0xffffffff818c8d30 <__asan_load8+0x50>
    0.00 :   ffffffff818c8d6e:        cmpb    %dl, %al
    0.00 :   ffffffff818c8d70:        jle     0xffffffff818c8d4d <__asan_load8+0x6d>
    0.00 :   ffffffff818c8d72:        jmp     0xffffffff82c66560 <__x86_return_thunk>
    3.65 :   ffffffff818c9030:        testq   %rsi, %rsi
    0.00 :   ffffffff818c9033:        je      0xffffffff818c919d <kasan_check_range+0x16d>
    3.61 :   ffffffff818c9039:        movq    %rdi, %rax
    2.71 :   ffffffff818c903c:        pushq   %r12
    0.00 :   ffffffff818c903e:        movzbl  %dl, %r8d
    6.34 :   ffffffff818c9042:        addq    %rsi, %rax
    4.37 :   ffffffff818c9045:        pushq   %rbp
    4.61 :   ffffffff818c9046:        pushq   %rbx
    0.88 :   ffffffff818c9047:        jb      0xffffffff818c9124 <kasan_check_range+0xf4>
    0.92 :   ffffffff818c904d:        jmp     0xffffffff861167b5 <_einittext+0x32c4>
    0.00 :   ffffffff818c9052:        movabsq $-0x100000000000000, %rax
    0.00 :   ffffffff818c905c:        jmp     0xffffffff818c9068 <kasan_check_range+0x38>
    0.00 :   ffffffff818c905e:        movabsq $-0x800000000000, %rax
    2.73 :   ffffffff818c9068:        cmpq    %rax, %rdi
    0.00 :   ffffffff818c906b:        jb      0xffffffff818c9124 <kasan_check_range+0xf4>
    0.90 :   ffffffff818c9071:        leaq    -0x1(%rdi,%rsi), %r10
    0.82 :   ffffffff818c9076:        movq    %rdi, %rbp
    4.56 :   ffffffff818c9079:        movabsq $-0x2000040000000000, %rax
    2.70 :   ffffffff818c9083:        movq    %r10, %r9
    0.90 :   ffffffff818c9086:        shrq    $0x3, %rbp
    3.55 :   ffffffff818c908a:        shrq    $0x3, %r9
    5.96 :   ffffffff818c908e:        addq    %rax, %rbp
    2.60 :   ffffffff818c9091:        addq    %rax, %r9
    0.00 :   ffffffff818c9094:        movq    %rbp, %rax
    1.83 :   ffffffff818c9097:        leaq    0x1(%r9), %rbx
    3.38 :   ffffffff818c909b:        movq    %rbx, %rdx
    1.82 :   ffffffff818c909e:        subq    %rbp, %rdx
    0.00 :   ffffffff818c90a1:        cmpq    $0x10, %rdx
    3.58 :   ffffffff818c90a5:        jle     0xffffffff818c9172 <kasan_check_range+0x142>
    0.00 :   ffffffff818c90ab:        movl    %ebp, %r11d
    0.00 :   ffffffff818c90ae:        andl    $0x7, %r11d
    0.00 :   ffffffff818c90b2:        jne     0xffffffff818c9138 <kasan_check_range+0x108>
    0.00 :   ffffffff818c90b8:        leaq    0x7(%rdx), %r11
    0.00 :   ffffffff818c90bc:        testq   %rdx, %rdx
    0.85 :   ffffffff818c90bf:        cmovnsq %rdx, %r11
    0.00 :   ffffffff818c90c3:        sarq    $0x3, %r11
    0.00 :   ffffffff818c90c7:        testl   %r11d, %r11d
    0.00 :   ffffffff818c90ca:        je      0xffffffff818c91ad <kasan_check_range+0x17d>
    0.00 :   ffffffff818c90d0:        movl    %r11d, %r11d
    0.00 :   ffffffff818c90d3:        leaq    (%rax,%r11,8), %rdx
    0.00 :   ffffffff818c90d7:        jmp     0xffffffff818c90e6 <kasan_check_range+0xb6>
    0.00 :   ffffffff818c90d9:        addq    $0x8, %rax
    0.00 :   ffffffff818c90dd:        cmpq    %rax, %rdx
    0.00 :   ffffffff818c90e0:        je      0xffffffff818c91a7 <kasan_check_range+0x177>
    0.89 :   ffffffff818c90e6:        cmpq    $0x0, (%rax)
    0.00 :   ffffffff818c90ea:        je      0xffffffff818c90d9 <kasan_check_range+0xa9>
    0.00 :   ffffffff818c90ec:        leaq    0x8(%rax), %rdx
    0.00 :   ffffffff818c90f0:        jmp     0xffffffff818c90ff <kasan_check_range+0xcf>
    0.00 :   ffffffff818c90f2:        addq    $0x1, %rax
    0.00 :   ffffffff818c90f6:        cmpq    %rdx, %rax
    0.00 :   ffffffff818c90f9:        je      0xffffffff818c918f <kasan_check_range+0x15f>
    0.00 :   ffffffff818c90ff:        cmpb    $0x0, (%rax)
    0.00 :   ffffffff818c9102:        je      0xffffffff818c90f2 <kasan_check_range+0xc2>
    0.00 :   ffffffff818c9104:        movq    %rax, %rdx
    0.00 :   ffffffff818c9107:        movl    $0x1, %eax
    0.00 :   ffffffff818c910c:        testq   %rdx, %rdx
    0.00 :   ffffffff818c910f:        je      0xffffffff818c912f <kasan_check_range+0xff>
    0.00 :   ffffffff818c9111:        andl    $0x7, %r10d
    0.00 :   ffffffff818c9115:        cmpq    %rdx, %r9
    0.00 :   ffffffff818c9118:        jne     0xffffffff818c9124 <kasan_check_range+0xf4>
    0.00 :   ffffffff818c911a:        cmpb    (%r9), %r10b
    0.00 :   ffffffff818c911d:        movl    $0x1, %eax
    0.00 :   ffffffff818c9122:        jl      0xffffffff818c912f <kasan_check_range+0xff>
    0.00 :   ffffffff818c9124:        movl    %r8d, %edx
    0.00 :   ffffffff818c9127:        callq   0xffffffff818c7930 <kasan_report>
    0.00 :   ffffffff818c912c:        xorl    $0x1, %eax
    0.00 :   ffffffff818c912f:        popq    %rbx
    0.00 :   ffffffff818c9130:        popq    %rbp
    0.00 :   ffffffff818c9131:        popq    %r12
    0.00 :   ffffffff818c9133:        jmp     0xffffffff82c66560 <__x86_return_thunk>
    0.00 :   ffffffff818c9138:        movl    $0x8, %r12d
    0.00 :   ffffffff818c913e:        subl    %r11d, %r12d
    0.00 :   ffffffff818c9141:        leaq    (%r12,%rbp), %rdx
    0.00 :   ffffffff818c9145:        jmp     0xffffffff818c9153 <kasan_check_range+0x123>
    0.00 :   ffffffff818c9147:        addq    $0x1, %rax
    0.00 :   ffffffff818c914b:        movq    %rdx, %r11
    0.00 :   ffffffff818c914e:        cmpq    %rdx, %rax
    0.00 :   ffffffff818c9151:        je      0xffffffff818c9164 <kasan_check_range+0x134>
    0.00 :   ffffffff818c9153:        cmpb    $0x0, (%rax)
    0.00 :   ffffffff818c9156:        je      0xffffffff818c9147 <kasan_check_range+0x117>
    0.00 :   ffffffff818c9158:        leaq    (%r12,%rbp), %r11
    0.00 :   ffffffff818c915c:        testq   %rax, %rax
    0.00 :   ffffffff818c915f:        movq    %rax, %rdx
    0.00 :   ffffffff818c9162:        jne     0xffffffff818c9111 <kasan_check_range+0xe1>
    0.00 :   ffffffff818c9164:        movq    %rbx, %rdx
    0.00 :   ffffffff818c9167:        movq    %r11, %rax
    0.00 :   ffffffff818c916a:        subq    %r11, %rdx
    0.00 :   ffffffff818c916d:        jmp     0xffffffff818c90b8 <kasan_check_range+0x88>
    1.79 :   ffffffff818c9172:        testq   %rdx, %rdx
    0.00 :   ffffffff818c9175:        je      0xffffffff818c918f <kasan_check_range+0x15f>
    0.92 :   ffffffff818c9177:        addq    %rbp, %rdx
    3.52 :   ffffffff818c917a:        jmp     0xffffffff818c9185 <kasan_check_range+0x155>
    1.81 :   ffffffff818c917c:        addq    $0x1, %rax
    0.00 :   ffffffff818c9180:        cmpq    %rdx, %rax
    7.15 :   ffffffff818c9183:        je      0xffffffff818c918f <kasan_check_range+0x15f>
    2.73 :   ffffffff818c9185:        cmpb    $0x0, (%rax)
    9.86 :   ffffffff818c9188:        je      0xffffffff818c917c <kasan_check_range+0x14c>
    0.89 :   ffffffff818c918a:        jmp     0xffffffff818c9104 <kasan_check_range+0xd4>
Basic annotate [Failed: missing disasm output when specifying the target symbol]
---- end(-1) ----
 75: perf annotate basic tests                                       : FAILED!



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250415/202504151510.3bb1707c-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

