Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8660B376496;
	Mon, 30 Mar 2026 07:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774854987; cv=fail; b=nIar58HNyio2Dy2Vc0Wz62HkqeJmQS0Kuv+ztOCdtDY4z6N4FeNuA/txg7dh3EHtJ/nG1tfzeBbSnzUvDR7mDPOuoM5/uneut8/xDT33tx3UY4NPDZmoCcLMMKur59p3eJqnlZVN5LFErmb6Xcyv5XDuGluGIAKelN6qKEpKUMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774854987; c=relaxed/simple;
	bh=178IFtLfUetEsqjIdGNfETA6b8HzNB8WR6ymUYshaxw=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XUqVYQxOMDR+jHE1Ee8ITcJr5k/g5tMvt5I/A0n/54jKugUm76fLhBrsT5R35XFNVwOn4v3QIt9ly0Xpn914kbS0XKJfXlAVTXS+bK8XMmNRhpu8a4tgKW6EMOH3ODzTrCvV09RdgX0Tny9vAL96SwjuEgvy0efTPeHhVK0yN30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YCA/Zfi3; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YCA/Zfi3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774854985; x=1806390985;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=178IFtLfUetEsqjIdGNfETA6b8HzNB8WR6ymUYshaxw=;
  b=YCA/Zfi30nE4BLIYBeBzOhAmarK01Roi8QbCaCklTtP7MG12r7n/PCLh
   MJUkKpV41sCr5vVAbM0Gfl5xCNHwEJ94vyjifemHnCNCskrOXrRBpqP1q
   ljOvL6EhfjaVJc/gjVYhFcQlJ/i89ZP3nnBvv+5ZcKSCNfGp6SAVV1+Rv
   jitgkdEth3V3sILcIn2akaNVG/ZqXIblZwc/DfJYq8RTsGIcSLyJPBuEA
   AakIxW9IFidE7Falgc4l0dA0qDJoUEcMx/EqfRblMURto9wgBxJzgZIvS
   OEzXiSfCLu/Hva60a75gjx5gDNdG3Oi9+r8AzicoekSwvnlbVh1+TMI/g
   A==;
X-CSE-ConnectionGUID: 3ETVEPYpSa21y5C7uve1Mg==
X-CSE-MsgGUID: zlKEz2sbQzOkN6LuB14vbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="75726238"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="75726238"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 00:16:24 -0700
X-CSE-ConnectionGUID: it06Aj++TayBvkvYH+OSBw==
X-CSE-MsgGUID: kOtm2zc4QY6ZezPHH0sOQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="249014890"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 00:16:23 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 00:16:22 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 30 Mar 2026 00:16:22 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.10)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 00:16:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MlU5Lfxp7JNI//+guEBneX6gIYIsynulrGuRNvmw99N6SzfD3FkYM6fsRXBkM3CiguMjZBQOU5NPSNKVxaQPuc1b9Q//d348wJh8mYWdXGV62W5I+VVGYEbZf4qG4/GVSpVMiP8P305DWq+oJXcp+gHTtPEL3+qN82RHX0h3ChVPoODvlYFTrMyhEscDhNj1t/h/qpqy95hTiRd/6kVDYU9XHY5tzNeOpAvyxVLCTZXcMjvfsa6/XmJJ0AR1HKndgdqAKZQm8yDemViTuePRct8lwEut7H8H9NBL0SRwqwOUqbCwGusJX2nOxqSVQY/IdHKthbK3cyhSsTlSekS+sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zsyd9yVwQ2yxPpxW+/BmUBjldo/ysWMiX4wE1BiL0h8=;
 b=Ru75Ujx2eazCTAM28/Z+i/jNyxed3vc04hCT9YsF9QYrvEDpK4OAnYjeHPod3BvaaDvhMuKouHbTaE6kajT6OjkzFiXqO8vp/4aBJHjbrdkKDYjNfa9CEg16yX1FvwiQtIwDzTgiWBxTgSwn1JSMXuQDLTg9sf6IvpNID0y3bEb/cC+QV4/lZCPXbeWgQ32d1R1HgNE4vT1AiYbEecr2QUqfY+/yDOHH+ZciPb2MGSE54a+5Zo1yrXs3ClGuC9pLCc8oq8DueNHCBqWIRwqkbq6+L6wATrrgnqSkQQQyiYzbwk0KbsPHJEy7OQ7DbOuWXSy4EdcWBKQmOPKbiwlJEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB2808.namprd11.prod.outlook.com (2603:10b6:a02:c8::26)
 by MN2PR11MB4616.namprd11.prod.outlook.com (2603:10b6:208:26f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 07:16:18 +0000
Received: from BYAPR11MB2808.namprd11.prod.outlook.com
 ([fe80::defa:788:da96:2f9a]) by BYAPR11MB2808.namprd11.prod.outlook.com
 ([fe80::defa:788:da96:2f9a%4]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 07:16:18 +0000
Date: Mon, 30 Mar 2026 15:16:08 +0800
From: kernel test robot <lkp@intel.com>
To: Ricky Ringler <ricky.ringler@proton.me>, <namhyung@kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>, <irogers@google.com>, <mingo@redhat.com>,
	<acme@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, Ricky Ringler <ricky.ringler@proton.me>
Subject: Re: [PATCH v5] perf utilities: cln_size header
Message-ID: <acojOAMD70Gwd3gf@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260328200442.134489-1-ricky.ringler@proton.me>
X-ClientProxiedBy: SG2PR04CA0168.apcprd04.prod.outlook.com (2603:1096:4::30)
 To BYAPR11MB2808.namprd11.prod.outlook.com (2603:10b6:a02:c8::26)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB2808:EE_|MN2PR11MB4616:EE_
X-MS-Office365-Filtering-Correlation-Id: b0956d38-da5f-4cf8-f070-08de8e2c3cd4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: ef2Myachk5fRFZLikHO+knIW9GensgCada7lxk4QMlpYvyz/nOcxIX8CYr2Jrsek/32SnyFZatYl68WKUce1ZSl0inuDXmkvO1EAyRP9WB54an02c9XnvqL+l+3z3s6FqM7DBhP/kcIJwDzWvTl2v4q6PRggLS01B8f3RR2NFnUAKzZyt02kKKQFdXk6JtnIDxfoRs6F15YmFA6EXWoVzbylKtI/bDRRPToB18IVmzxN0YHb8zlZSy6SvVtoySouiColCOxPNWj4KN8qgdZNc+ZxI4TuXlIbuqAvfPTekESDcEQF3Z1Tt7Yh/37IXUjOXCsIO9qGlhq4Uqqy6ymg0nBqXy8qitslwA4qOz4nBEfg2D5uvAOCzeSRmjciddP/BgECxT6hBwmBLnQz2k8FyyjhdWlIfdHVIO9MUFZPzHCmLS5MptJycy7BpWBeonHCU+X3+V51VeCnxXtOkgwI8/4Ar52wyYBFA0Op9ffw6fDg/VsKs/2HvgHspTKieN10FEDmmdaC21uwdksm013V4c0fcdYieZMY7txIejz0o6yvJ/l/LkkTkF4Cfu6dUNmG0F0pB1jXmEQCVEJys/Zgsf0HEA05v+bybG7bPCDZsbB2vrlLGmgYocrqhGqduLDOOVhQEloPsXxTDRDCwcNyV3msnHWuel5GtocmgHq89+kkp3+M8ckE5DsZJaIJIO4+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2808.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b2vD4vJ2r+Rkek48b7fKIchx3PCBYokAgbvgMrHdzCKJqAKmIQY2k+nuuZ+h?=
 =?us-ascii?Q?7Luxh1G9C7dpB4gPYerhMGPFa1sYiGRtdQEQpGkcY43ihHI6xd12MII/fxba?=
 =?us-ascii?Q?EZWhy+fZ/cdrVhm7wx5gr633mxvtnWDfatOCaraM1ilGvjctPAhPRN5zofT+?=
 =?us-ascii?Q?YfaZilZqcOgk97GDcGfFCluXTwmdm6T2wiRZouaC1O30/B5naeeTI0aBIRHc?=
 =?us-ascii?Q?PKx8DB+8n6UrclQP6tM1YLZojEyhF2KDbzo4V1z/mJJtE4/owJGs/1UDYO+D?=
 =?us-ascii?Q?TxJqGh4zkEwYfC3CKBmsg8LaNc53ZwuFwD9VP2xvum6QdA2/ucZxf20hrJSY?=
 =?us-ascii?Q?6pOHnyOppk0cqcM+IBGJbL4bNy6OJm2jouQ0D3YLcgb6TvlpPIy2F6BAPDnQ?=
 =?us-ascii?Q?qoqfq8zeZEpebBIeeLwqN/MnnjHKe16qUbwRPV89p2QbACPxKTI60zRVYMbQ?=
 =?us-ascii?Q?JtIoCzzBoKbuYL1bRsjHEpjYBIEfYqZnDASmGroLH+5PBTg3u1BspudAydUB?=
 =?us-ascii?Q?cYmu64VQSOwqdDPuX+4hdm+mEjrgQaRS/NYO7Gx15Y7yLLC7LXnks6rw2qX+?=
 =?us-ascii?Q?xkoWOJWRPmkKmZElwLmg5x2ygdEWtcJbDfuzsH2DTD7sIdJ/vuLZHv76Wwx4?=
 =?us-ascii?Q?yIGa8W+NA73+0dE2O1NLCdAGyfdyqTaMUWdW4GCg04TwNJVwuso/ohFBgCv9?=
 =?us-ascii?Q?PD7vRO2nGEoeJposGY6lWKawQeiChG5OuoflIzJdUdA6b99H+gY4oI4YjHAn?=
 =?us-ascii?Q?PMMivVG8imgOWU42mOdt1oD4JGS6Raq1xK9x4od1KyTlLC1pF/q6KsDHhN+i?=
 =?us-ascii?Q?o/dXn55sD4tiyPoKnfFcVoJeMj38K+cPaK+xV86hG476ABwws7zHF3HwIyi8?=
 =?us-ascii?Q?E3UC3tGYIpdry8oqo6FATZkcz4hMDk9AvhhbSWNS8Bur9X2v+CcbkjKIqtfP?=
 =?us-ascii?Q?72/xcLocjlCzG1WlIv343MWwWlYUF9kl8HYuk7Wq9A4VhX/WZfL36woKZwmI?=
 =?us-ascii?Q?XufhBC0VBWq/S0dC/QdT0zMtF7mdCPrQCYzDqLe0NEFpNF2/GWJQyaX76Ji/?=
 =?us-ascii?Q?1+t5FcesH7+CNhLygnxJeKdJKoEfTCD2wuVri6HoxLQ6+YlTqtZ5EXcUGc3G?=
 =?us-ascii?Q?Xb+TYOyRktQuIc/XokveX51hDdmBYvpRtPgYStesQEdMk49kRKLaUTXZtAj7?=
 =?us-ascii?Q?lOBZu9f/pLNrcQJ7suzeTI1yyy391IckdTYOHKMG/8yyaJ7YpH6qIFKbjH1P?=
 =?us-ascii?Q?2+iLR2bTmWxwyZ0Xp1FObIx0JbDXeGKtT+FEb8sbpmOn7P2a6C98XXlYlOca?=
 =?us-ascii?Q?1i99ZdR5IUwtq4tynimfBneGJk7U5mmkY9KojidiFIBq2ckvMAdZFwwYBJZw?=
 =?us-ascii?Q?dX/zm4+nKbwDDe8iMsG+IjbR3NODny6cO/PJk+B1ACRGs1D99drOaJmYV5EZ?=
 =?us-ascii?Q?9dxxFKJvvFGISGzQkU74lwhZujnN/z4ER04/4WApov8FdDhm2QWWV+wjw31D?=
 =?us-ascii?Q?J6UvEeXnqwXiWfpEV1Nwh4i2lOVzkWl0zwYvBjvYhpwPBVJ70sckucm5sLyV?=
 =?us-ascii?Q?7RWkWx2OmzaP0Taq4LllSEx3L+zoxuzUoF0mCFY8bgvL7+EUTthgdaOm4ds0?=
 =?us-ascii?Q?mrCUvYFxA2uPbQ8MYfk088EjadBgKbtXD0GaWEF+f6wJwmJczu6OavlfscmD?=
 =?us-ascii?Q?Xo3ps9jn9fQIuy3tDydfafK/8Q3Ukf23pNWgPNFR35MEuuug9WVS4X/rGBA5?=
 =?us-ascii?Q?x2lyguL6eg=3D=3D?=
X-Exchange-RoutingPolicyChecked: JsvF1UvEtsH6AWrZPFyc3gqTjF5ZgqmHhxhVR9zC5acSpAmbpHh4fCg01m8NpCxh1BMtWMv6vZuhESOEsxkWE+hsSciSmcPZANnW44kCWoJO5XCWPw0GiGsw6s1KrycFFJBTL/lxQ4SjcsmTegIl3T4ZMBUJ88UnIaaCWI7hpNjF4QtOvZQ+ZgwniWF1EpJfWhi2koc/fI2ngJB2oMN8bYtwoXmxEGOJcHMSYTbY4stTYO6pkvbFJ7oTve3359p1pQjCuxeOS0+7iu6mOIAxwctGOMTgucqz45Wd/Pc6DRb8xfZ/CQ+2bmwRYqE272Rw5r5+NVpRYCBv6K1HrdF6tA==
X-MS-Exchange-CrossTenant-Network-Message-Id: b0956d38-da5f-4cf8-f070-08de8e2c3cd4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2808.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 07:16:18.6948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1p23K/V3Ci1wBXsEHlcrjEQgFunLtObVaQiAvptyCOzgXxkBfAYswYzr6rTlOaV7k3AUepqNHBe7gBtxxRyusA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4616
X-OriginatorOrg: intel.com

Hi Ricky,

kernel test robot noticed the following build errors:

[auto build test ERROR on perf-tools-next/perf-tools-next]
[also build test ERROR on tip/perf/core perf-tools/perf-tools next-20260327]
[cannot apply to acme/perf/core linus/master v6.16-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ricky-Ringler/perf-utilities-cln_size-header/20260329-205729
base:   https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
patch link:    https://lore.kernel.org/r/20260328200442.134489-1-ricky.ringler%40proton.me
patch subject: [PATCH v5] perf utilities: cln_size header
config: arm64-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20260329/202603291618.3giyFism-lkp@intel.com/config)
compiler: aarch64-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260329/202603291618.3giyFism-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202603291618.3giyFism-lkp@intel.com/

All errors (new ones prefixed by >>):

   Makefile.config:576: No elfutils/debuginfod.h found, no debuginfo server support, please install libdebuginfod-dev/elfutils-debuginfod-client-devel or equivalent
   Makefile.config:963: No libllvm 13+ found, slower source file resolution, please install llvm-devel/llvm-dev
   Makefile.config:1159: Rust is not found. Test workloads with rust are disabled.
     PERF_VERSION = 7.0.rc4.ga971d40d4a8d
   util/header.c: In function 'write_cln_size':
>> util/header.c:1308:32: error: expected expression before '=' token
    1308 | #define DEFAULT_CACHELINE_SIZE = 64
         |                                ^
   util/header.c:1317:28: note: in expansion of macro 'DEFAULT_CACHELINE_SIZE'
    1317 |                 cln_size = DEFAULT_CACHELINE_SIZE;
         |                            ^~~~~~~~~~~~~~~~~~~~~~
   make[4]: *** [tools/build/Makefile.build:95: util/header.o] Error 1
   make[4]: *** Waiting for unfinished jobs....
   make[3]: *** [tools/build/Makefile.build:158: util] Error 2
   make[2]: *** [Makefile.perf:797: perf-util-in.o] Error 2
   make[2]: *** Waiting for unfinished jobs....
   make[1]: *** [Makefile.perf:289: sub-make] Error 2

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

