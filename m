Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E989F2EA480;
	Wed, 19 Nov 2025 08:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763541423; cv=fail; b=Z9VP8698j/7pPuXR00GUycshJTUIU0WvXh9jfgKN5QNo0i5mIpw2At8WONIFFiOinhKNRrftSm44Z2N8RAGVVUMvYPoR4vfFsFECxxjhp/71vLuy78xqRQLwOi/6aqzopfWkf6cEnGfp1m1YyT6sNyKt52k/08aXjOBBuYjz7PQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763541423; c=relaxed/simple;
	bh=UhKbRdfPUFyzBINb0y8fXcgSDUYN7V5z/3B11T7ZtH4=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=B96qC38aiQuhSbxiK7VhaUI5ooGQiNjPogJDNSZrMCGRZvgs4mdVM1eXkeC7YIrmm0UlrtKYLI7ErrjEGsPfZEWjfsMspvrtT25G4ArOkhiIwwdZEfWAwPFNckDNQDup5kmx9M8DqdLW1IFLcWevZ8ZLlmoFC6Ry0gYZ2aHCMi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fNSFCCMZ; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fNSFCCMZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763541421; x=1795077421;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UhKbRdfPUFyzBINb0y8fXcgSDUYN7V5z/3B11T7ZtH4=;
  b=fNSFCCMZiTaKkZyrktDMQLkVSpsyTAH8M01TpTMKnHc9B7V7vfPM6Lmu
   FOPQ6zjc7mB2hMr+pQnhPT0cEEQHriA0nCYMrgTnIfTinSVeqNQP5PEZb
   RVXX/1XBftDtRTKri5oxG8qlINvo8gfDTDs9mn1HDC7fU8zv/fI8Fwcdn
   OXUVy6s/ntCb1jFMlzkoioehowgZDnJGktWNamA6oU0f4v8OINLEcaIEE
   mqVV1AfJ3h+cbdrbLJyMvrpVDGGjYuxHrJdHXsSAM4NbBUCWUYq704Gce
   im83IT5GpEqymJsesazO3OOyixuvOi+Xmqa95fBswm4ITJ3ZLwpaP0ESL
   A==;
X-CSE-ConnectionGUID: RAkZvxqVSmWC2xpTLp9AgA==
X-CSE-MsgGUID: jed1YTxVTN+LwkmsS76YhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="65473285"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="65473285"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 00:36:59 -0800
X-CSE-ConnectionGUID: 6WMeZdLZT1Ky9ucQnoHLOA==
X-CSE-MsgGUID: yWrsL53JTvCNkFV4hvrxng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="195113710"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 00:36:59 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 00:36:58 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 19 Nov 2025 00:36:58 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.68) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 00:36:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/UUaYuyKqORvBXTiRYBjNfj3K7eCkhik11mEMkgfKnSQjT3Q8gQSRpl05mQjLuPMHj7ixeKl+gmwp+xamD0YyPN1OKIRhi3FuSKM700tGkO6jTqjz6CeAKMaUJOppPFR9mpqte815jSeG14JQedULDTEglScLgEOoLvnlBN3tVqnYQKr/xbcrFXMTHc3cM94jTTNXL6gymGekTyL3PIJpHfR5x4gOD9r0DtHqStGdKTrN7J8MjV6RWDQUA3scaqwjzlZMHK22K35G5N2WUlUFSG89bGmDemwwlZ5ynSgPwWOe1UBfth82O19J5vKBewHrvzFQNMrOINgi4ifAtpaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oe5VcZHfyyuZtfBjMNW0/BMdR8E+hJNtmsANg4p0HI4=;
 b=x+8JGoMumsTludEBY3u8ZTF4AzVOD71kV1+kytNt/fHNF2H3PA9vTnxtBNm5h71w+pPo9NWBqHUqU0H62i00JIVH+pKsPUmzpKbGpnmHgcG4JHLFQdblV7XQi9YbmIlsbFdI9zlffu+i3AfkOgfPVh7qKlFvhOkPniuuPyjnmk7hYfny/yQyimUiFpYnpo/4Tw/2cilN6WdvSSezYGB3M6sdratGcQdN42JFJ9EhtprvCTNo2reSWIDnQknSnO5B/rgA/Nr1AHCUKe1QAuZdxiLyWqWB4UTfep0zTR6Ix70YQne47OWXa5Qxby/q0Uj+KaWSiPcmiGPXbJvl9sY1sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS4PPFEE549A404.namprd11.prod.outlook.com (2603:10b6:f:fc02::60) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 08:36:49 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 08:36:49 +0000
Date: Wed, 19 Nov 2025 16:36:42 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Namhyung Kim <namhyung@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [namhyung-perf:perf/defer-callchain-v4] [perf record]  d430e742d0:
 perf-sanity-tests.syscalls_sys_enter_openat_event_fields.fail
Message-ID: <202511191644.294eaf97-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: TPYP295CA0054.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:8::6)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS4PPFEE549A404:EE_
X-MS-Office365-Filtering-Correlation-Id: 96725a4f-82c3-4a2e-59d6-08de2746c834
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YSxCG0Lyxf8q4curhfpN5HN0SKjS1i2NPfMOqijBCDfVrN+BB/Jxp8IbKgv5?=
 =?us-ascii?Q?EpKukepC1n70PdLsOKBvP5XTpH/FLS5a/jxaJ3Zx/LycrNEuMMdOLgj0S5iG?=
 =?us-ascii?Q?0MtCYjMnxWwRN8e9mQ5ckamMh4gZ24yUJf9xYMav37YhFyxbQ9++UtLIN9KE?=
 =?us-ascii?Q?Zy8dN6drfAJkxIvfa78iY3cO8bN3EDUbYcfuQttWmzekdby/bp/sbkE/3rpV?=
 =?us-ascii?Q?fq3rW4jI3PYtlsTV9gfA719mZFdnDu4ddm/idDo/6FN1Fmjm2AghtJIY9+OG?=
 =?us-ascii?Q?KQbPtkuwLYECMsGBYlF2Kg2c1lk/zL1TuLJzLfu/JZRZkwWIY/KRwohI2Wt0?=
 =?us-ascii?Q?dNhtogVqqqIlkyGn+GKM5brbenFRCL9qdW0DL8+WUiUcCCQVbCCL81yUs4Ae?=
 =?us-ascii?Q?vyfoZDk+uuU8gtGl9AUNiDZAASl6KIY1tQt++fv/QQ5IhqNVfsH9rdBmqRaS?=
 =?us-ascii?Q?TQIJwVzesD0OM0TYJjgq44EocMNa7qPsZuTgzXj4ebfjRycnd2pCD3EcBct2?=
 =?us-ascii?Q?nsVEsd0D842PhjLIIpFwyQcgJAmftWBF0ECK0jO077fZWwPy58+I4mGEG4c0?=
 =?us-ascii?Q?7ycQmTcFgQtFSEpqNRrvhD2G7m6hyfxP86LILt6igwjmMKkD/uv1igrpe8+F?=
 =?us-ascii?Q?MJPRsSkEz+p1iPZ/ENFE3ADji6Z6pPrqJ4Kuc7hkZzQSZM9yLtRX+Gayst7+?=
 =?us-ascii?Q?YI8dZnerOl4yQczy0Vbq2o9XukyQuvWPVooO1PZdsUbjVqDJ2+a/tM2NLaLi?=
 =?us-ascii?Q?Tdm9POVMUui8nj3p6nbei80q5SWmLx7OpQfDNRb+xryRjRKdd7jvRjTicft8?=
 =?us-ascii?Q?lKevvoUtQ0fosOekS1qi9rM5jSZCwPY2nA/ehxbzlGenxdoLu7ISr4juTGKU?=
 =?us-ascii?Q?Svu4DZtHYKBnPb++JC/+k1Fxv5W3f7hy9q9usotX17YuevVIX5oSkMytNwoH?=
 =?us-ascii?Q?xc0rrjSL+YtWcwDtu/vThO0ujpw0ivNN4Ob/d8WPAuYJMdbhjcY8+C3+sPY0?=
 =?us-ascii?Q?fbBRUC7w9AhVbQ31Fv213E5F5l0w9kunUuRq1EcuHrFnXL9RVLOv/1fXZ0lr?=
 =?us-ascii?Q?q9JuxKLzjE7XFQnuOJpByp4ey4s/jFha7iYbAPCqwwCwH4NQ6boi9Wp6WIeF?=
 =?us-ascii?Q?dtXab6sK7Rb8lpAAYh0bvRdbgDyxmZSNMqIIxbQlWdO6lF4FXoF0GCQlEg77?=
 =?us-ascii?Q?mqQq0d+MThA+f3g4vRSQ+O9O4MkZ32mtcq6YMklstVqk4Giejrh2HW2hxwnT?=
 =?us-ascii?Q?g9dOI8EkTGAClP1knJDwVBkdFX4VQGNxG0NPacn+gEG5G6bFchcdosvSn3Zt?=
 =?us-ascii?Q?3JCY+/zDjh7Hqo0LB5Qk1eF3ac7tf8iK6e2LD1/escIOBIp01wIWy823h8z7?=
 =?us-ascii?Q?ckjmi/QUtEwM2gxYGAQVNdNEIOZCMmlyDyj8tJGJUAJUrj9ShRY0j56bDx97?=
 =?us-ascii?Q?oRyjCOiI7No9NEU0rISv9u8Urno1+jNilQpGgVY4+HUFzMlK94UYtw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q6fjKFKf4fi1VL6Ctiixbt4kkjUigQQcHnhW8gyCrZjZjEKsSGuRb/klWb8Q?=
 =?us-ascii?Q?GiW6FUsw97kIE47P7yC0jE2Ac4bABRtriWQxU4kmPGtsFO7WUXe2GIyOnBFW?=
 =?us-ascii?Q?zim9cf1lgBpY7gZdkedO0sztMYQ812jcn3czW9pUXLSVi+vwcWDh32Z4EIfX?=
 =?us-ascii?Q?Gt10riqBQsfLyx0tlorfLpzf2pB5geldxJPOl6wxQKXHHwvQmIHcC5W3mKi4?=
 =?us-ascii?Q?OKCg0Xk1cd8uNBtPSZb94NxesnsUkHFfF1Ht9LlSxz50ghtnazjr0EBaNWSe?=
 =?us-ascii?Q?wC0kLYpc4UGKDdnhN7wGyde6yKY313DJ+H2LE9YKHr4ZW+4250wGxtLjpe3j?=
 =?us-ascii?Q?SE6S4y3yy+c+n1CJwjsCZ4nIXGKAD0ClHONQ2Dh/6PG7Qj5IuBHpbugMdTuE?=
 =?us-ascii?Q?wXKEWygu2/XWYmHPEWCsBlO0R0lKl55HT+eAUr0nJUUeEoF1FTtMCxYs0CLE?=
 =?us-ascii?Q?qEe53Ffyn/HDzt3iNHUuTmr84/BUZljvMvqrR7NP015wbpvilVklQQcMGBim?=
 =?us-ascii?Q?wtWwjzT7vRkHN8gxCeK+mfRGPANQl6lbDBi70nbao/aTRawMBf26ERtcnIrB?=
 =?us-ascii?Q?X9OFz0CzqCAaPXduVBJqmS9iEAJVNSM8zx/qPbGyCagyjGYptVX8K3l7dnwM?=
 =?us-ascii?Q?ID6KuTlgpGL0aHwRpLeDcUO+ERiyn4qCSHwOdThUq2xK85VvEjdKCNpsiYAt?=
 =?us-ascii?Q?cQuQKlp4CIMLLkQ51DBIEwvNRnSA5a7jp9ozdIdFR3kIYhKnYdRGSH4cuOfs?=
 =?us-ascii?Q?bf09N6kZsSvp+BX+Ta4BEP8cWBnNa0u/HaOKlX2/Vsf4tw7n0M6syxdnfDSf?=
 =?us-ascii?Q?rY7h0wJhpmF8zufklwM4/SvpJ32JzpM/bdYpL+XyTNPRpYsUGC8QtjAJ6Vtv?=
 =?us-ascii?Q?hi7aLGrPXf5Namvaun3MVfGem/IO6s3+KMQyTyJ42MRkDpvydrBY/1pHIrg3?=
 =?us-ascii?Q?Yi3b5DXkUIubq9jiEUobVQHk2AoSZ3n+3BTPVp0P+/RRpmxMup+b5Yef5+eR?=
 =?us-ascii?Q?zKPNzwnqsv+VCfAxuj3y7JLrn03tfwVHoH7hMmnkw2YHNgXQrkaEz5C2elmm?=
 =?us-ascii?Q?pC2/vcd8lNlG5CcDSr3qpA4rqUYOv5o/oxgyGnBheOHGb52dvElNfk6Fnj7B?=
 =?us-ascii?Q?IZKdKwQgoJU0yJQOzyoiCwNDMsgOMR5PHrDsY26y/MhuoJPgMxXyE1CV7tv7?=
 =?us-ascii?Q?OrB4VjpAIEHfErhqdlveBe4Vz02Wmz9Dcjj2H1QJBIkynCP+b528MW1VRtDi?=
 =?us-ascii?Q?Mp5Z0zaTGXr+97iiM0HJDMKZTsXNR5O5lQ+NQqQYd+7N7jcw0cyulUfdr6Ex?=
 =?us-ascii?Q?SPLB8djzddMngn0FSPMM5QMjgUVSQXyaXu9D7JIHRKYiqVfLg8idCbkyS4Kt?=
 =?us-ascii?Q?CZJDJZ9Tzy1iuI0BA7ToD4N9Q6RQOgW7rJXbXldZra/k3c0h2w/A8Su9IbC8?=
 =?us-ascii?Q?Vk8n5oB/scW6LF+DmVoBcxGKD9RqOX9I43mLdTP9dDEolDY4ZcxOf6k7iX5d?=
 =?us-ascii?Q?HVgMuxJwPmUc9Hwe/Gg/T3cEWthii9qtTbchwBLfpJF7M+QoSLtvCqgwjIoK?=
 =?us-ascii?Q?SCOJF/9uupN9c78JaQcMuDomi1FfYZNnMfKn42pOhPVhuLLl07F3sXg4u0E2?=
 =?us-ascii?Q?Bg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 96725a4f-82c3-4a2e-59d6-08de2746c834
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 08:36:49.6403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LPADFgwHotPxy/0ooiZBOJHkkSYDPE3CeFZTF6uhvnPxeXKfEC1+nnI/Xpk48oQ7NTx+ni3CPAwR3BYxYkJ/OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFEE549A404
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "perf-sanity-tests.syscalls_sys_enter_openat_event_fields.fail" on:

commit: d430e742d054657591e1a95a80507afb758b499a ("perf record: Add --call-graph fp,defer option for deferred callchains")
https://git.kernel.org/cgit/linux/kernel/git/namhyung/linux-perf.git perf/defer-callchain-v4

in testcase: perf-sanity-tests
version: 
with following parameters:

	perf_compiler: clang
	group: group-00



config: x86_64-rhel-9.4-bpf
compiler: gcc-14
test machine: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202511191644.294eaf97-lkp@intel.com


2025-11-18 10:33:43 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/perf test 15 -v
 15: syscalls:sys_enter_openat event fields                          : Running (1 active)
--- start ---
test child forked, pid 13804
util/evsel.c:1517:41: runtime error: member access within null pointer of type 'struct callchain_param'

---- unexpected signal (11) ----
    #0 0x7f50c5ebe403 in ___interceptor_backtrace.part.0 sanitizer_common_interceptors.inc:4358
    #1 0x55c85d8951dc in child_test_sig_handler builtin-test.c:311
    #2 0x7f50bbc72df0 libc.so.6[3fdf0]
    #3 0x55c85dae44d0 in evsel__config evsel.c:1517
    #4 0x55c85d8cd595 in test__syscall_openat_tp_fields openat-syscall-tp-fields.c:67
    #5 0x55c85d895a6d in run_test_child builtin-test.c:339
    #6 0x55c85d7e7e1f in start_command run-command.c:128
    #7 0x55c85d897f49 in start_test builtin-test.c:545
    #8 0x55c85d898eb5 in __cmd_test builtin-test.c:647
    #9 0x55c85d89b868 in cmd_test builtin-test.c:849
    #10 0x55c85d7a19ca in run_builtin perf.c:349
    #11 0x55c85d7a22bb in handle_internal_command perf.c:401
    #12 0x55c85d7a2811 in run_argv perf.c:448
    #13 0x55c85d7a2fb8 in main perf.c:555
    #14 0x7f50bbc5cca8 libc.so.6[29ca8]
    #15 0x7f50bbc5cd65 in __libc_start_main libc.so.6[29d65]
    #16 0x55c85d50b251 in _start perf[101c251]

=================================================================
==13804==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 30952 byte(s) in 3 object(s) allocated from:
    #0 0x7f50c5f34610 in calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x7f50c5d15808  (/lib/x86_64-linux-gnu/libelf.so.1+0x3808) (BuildId: d6a40be9eadcbcb0562b7bb13bbe81166e82cc40)

Indirect leak of 9280 byte(s) in 3 object(s) allocated from:
    #0 0x7f50c5f34c57 in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x7f50c5d1d550  (/lib/x86_64-linux-gnu/libelf.so.1+0xb550) (BuildId: d6a40be9eadcbcb0562b7bb13bbe81166e82cc40)

Indirect leak of 2792 byte(s) in 1 object(s) allocated from:
    #0 0x7f50c5f34610 in calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x55c85d7ce63b in zalloc ../../lib/zalloc.c:8
    #2 0x55c85dab5ab7 in evlist__new util/evlist.c:92
    #3 0x55c85d8cd36a in test__syscall_openat_tp_fields tests/openat-syscall-tp-fields.c:40
    #4 0x55c85d895a6c in run_test_child tests/builtin-test.c:339
    #5 0x55c85d7e7e1e in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/lib/subcmd/run-command.c:128
    #6 0x55c85d897f48 in start_test tests/builtin-test.c:544
    #7 0x55c85d898eb4 in __cmd_test tests/builtin-test.c:647
    #8 0x55c85d89b867 in cmd_test tests/builtin-test.c:849
    #9 0x55c85d7a19c9 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/perf.c:349
    #10 0x55c85d7a22ba in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/perf.c:401
    #11 0x55c85d7a2810 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/perf.c:445
    #12 0x55c85d7a2fb7 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/perf.c:553
    #13 0x7f50bbc5cca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)

Indirect leak of 1873 byte(s) in 3 object(s) allocated from:
    #0 0x7f50c5f34c57 in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x7f50c5d1e3fa  (/lib/x86_64-linux-gnu/libelf.so.1+0xc3fa) (BuildId: d6a40be9eadcbcb0562b7bb13bbe81166e82cc40)

Indirect leak of 1128 byte(s) in 1 object(s) allocated from:
    #0 0x7f50c5f34610 in calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x55c85d7ce63b in zalloc ../../lib/zalloc.c:8
    #2 0x55c85dad9751 in evsel__newtp_idx util/evsel.c:586
    #3 0x55c85d8cd08c in evsel__newtp /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/util/evsel.h:273
    #4 0x55c85d8cd41c in test__syscall_openat_tp_fields tests/openat-syscall-tp-fields.c:50
    #5 0x55c85d895a6c in run_test_child tests/builtin-test.c:339
    #6 0x55c85d7e7e1e in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/lib/subcmd/run-command.c:128
    #7 0x55c85d897f48 in start_test tests/builtin-test.c:544
    #8 0x55c85d898eb4 in __cmd_test tests/builtin-test.c:647
    #9 0x55c85d89b867 in cmd_test tests/builtin-test.c:849
    #10 0x55c85d7a19c9 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/perf.c:349
    #11 0x55c85d7a22ba in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/perf.c:401
    #12 0x55c85d7a2810 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/perf.c:445
    #13 0x55c85d7a2fb7 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/perf.c:553
    #14 0x7f50bbc5cca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)

Indirect leak of 456 byte(s) in 1 object(s) allocated from:
    #0 0x7f50c5f34c57 in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x55c85d7acd75 in perf_cpu_map__alloc /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/lib/perf/cpumap.c:31
    #2 0x55c85d7ada73 in cpu_map__trim_new /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/lib/perf/cpumap.c:143
    #3 0x55c85d7aebd4 in perf_cpu_map__new /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/lib/perf/cpumap.c:231
    #4 0x55c85d7ad6cc in cpu_map__new_sysfs_online /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/lib/perf/cpumap.c:111
    #5 0x55c85d7ad796 in perf_cpu_map__new_online_cpus /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/lib/perf/cpumap.c:119
    #6 0x55c85d7adf8e in perf_cpu_map__new /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/lib/perf/cpumap.c:175
    #7 0x55c85dabe6e0 in evlist__create_maps util/evlist.c:1028
    #8 0x55c85d8cd4fd in test__syscall_openat_tp_fields tests/openat-syscall-tp-fields.c:59
    #9 0x55c85d895a6c in run_test_child tests/builtin-test.c:339
    #10 0x55c85d7e7e1e in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/lib/subcmd/run-command.c:128
    #11 0x55c85d897f48 in start_test tests/builtin-test.c:544
    #12 0x55c85d898eb4 in __cmd_test tests/builtin-test.c:647
    #13 0x55c85d89b867 in cmd_test tests/builtin-test.c:849
    #14 0x55c85d7a19c9 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/perf.c:349
    #15 0x55c85d7a22ba in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/perf.c:401
    #16 0x55c85d7a2810 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/perf.c:445
    #17 0x55c85d7a2fb7 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/perf.c:553
    #18 0x7f50bbc5cca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)

Indirect leak of 456 byte(s) in 1 object(s) allocated from:
    #0 0x7f50c5f34c57 in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x55c85d7acd75 in perf_cpu_map__alloc /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/lib/perf/cpumap.c:31
    #2 0x55c85d7ada73 in cpu_map__trim_new /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/lib/perf/cpumap.c:143
    #3 0x55c85d7aebd4 in perf_cpu_map__new /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/lib/perf/cpumap.c:231
    #4 0x55c85d7ad6cc in cpu_map__new_sysfs_online /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/lib/perf/cpumap.c:111
    #5 0x55c85d7ad796 in perf_cpu_map__new_online_cpus /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/lib/perf/cpumap.c:119
    #6 0x55c85d7bbf9d in __perf_evlist__propagate_maps /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/lib/perf/evlist.c:45
    #7 0x55c85d7be0d3 in perf_evlist__add /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/lib/perf/evlist.c:156
    #8 0x55c85dab6970 in evlist__add util/evlist.c:208
    #9 0x55c85d8cd4e4 in test__syscall_openat_tp_fields tests/openat-syscall-tp-fields.c:57
    #10 0x55c85d895a6c in run_test_child tests/builtin-test.c:339
    #11 0x55c85d7e7e1e in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/lib/subcmd/run-command.c:128
    #12 0x55c85d897f48 in start_test tests/builtin-test.c:544
    #13 0x55c85d898eb4 in __cmd_test tests/builtin-test.c:647
    #14 0x55c85d89b867 in cmd_test tests/builtin-test.c:849
    #15 0x55c85d7a19c9 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/perf.c:349
    #16 0x55c85d7a22ba in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/perf.c:401
    #17 0x55c85d7a2810 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/perf.c:445
    #18 0x55c85d7a2fb7 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/perf.c:553
    #19 0x7f50bbc5cca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)

Indirect leak of 32 byte(s) in 1 object(s) allocated from:
    #0 0x7f50c5f33b58 in realloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:85
    #1 0x55c85d7b1897 in perf_thread_map__realloc /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/lib/perf/threadmap.c:23
    #2 0x55c85d7b1aeb in perf_thread_map__new_array /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/lib/perf/threadmap.c:47
    #3 0x55c85d7b1d18 in perf_thread_map__new_dummy /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/lib/perf/threadmap.c:64
    #4 0x55c85dc911ad in thread_map__new_by_tid_str util/thread_map.c:233
    #5 0x55c85dc916e6 in thread_map__new_str util/thread_map.c:278
    #6 0x55c85dabe619 in evlist__create_maps util/evlist.c:1020
    #7 0x55c85d8cd4fd in test__syscall_openat_tp_fields tests/openat-syscall-tp-fields.c:59
    #8 0x55c85d895a6c in run_test_child tests/builtin-test.c:339
    #9 0x55c85d7e7e1e in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/lib/subcmd/run-command.c:128
    #10 0x55c85d897f48 in start_test tests/builtin-test.c:544
    #11 0x55c85d898eb4 in __cmd_test tests/builtin-test.c:647
    #12 0x55c85d89b867 in cmd_test tests/builtin-test.c:849
    #13 0x55c85d7a19c9 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/perf.c:349
    #14 0x55c85d7a22ba in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/perf.c:401
    #15 0x55c85d7a2810 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/perf.c:445
    #16 0x55c85d7a2fb7 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/perf.c:553
    #17 0x7f50bbc5cca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)

Indirect leak of 26 byte(s) in 1 object(s) allocated from:
    #0 0x7f50c5f34c57 in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x7f50bbcbaaf7  (/lib/x86_64-linux-gnu/libc.so.6+0x87af7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)

Indirect leak of 17 byte(s) in 1 object(s) allocated from:
    #0 0x7f50c5f2ed60 in strdup ../../../../src/libsanitizer/asan/asan_interceptors.cpp:578
    #1 0x55c85dad9971 in evsel__newtp_idx util/evsel.c:601
    #2 0x55c85d8cd08c in evsel__newtp /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/util/evsel.h:273
    #3 0x55c85d8cd41c in test__syscall_openat_tp_fields tests/openat-syscall-tp-fields.c:50
    #4 0x55c85d895a6c in run_test_child tests/builtin-test.c:339
    #5 0x55c85d7e7e1e in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/lib/subcmd/run-command.c:128
    #6 0x55c85d897f48 in start_test tests/builtin-test.c:544
    #7 0x55c85d898eb4 in __cmd_test tests/builtin-test.c:647
    #8 0x55c85d89b867 in cmd_test tests/builtin-test.c:849
    #9 0x55c85d7a19c9 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/perf.c:349
    #10 0x55c85d7a22ba in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/perf.c:401
    #11 0x55c85d7a2810 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/perf.c:445
    #12 0x55c85d7a2fb7 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/perf.c:553
    #13 0x7f50bbc5cca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)

Indirect leak of 9 byte(s) in 1 object(s) allocated from:
    #0 0x7f50c5f2ed60 in strdup ../../../../src/libsanitizer/asan/asan_interceptors.cpp:578
    #1 0x55c85dad983d in evsel__newtp_idx util/evsel.c:597
    #2 0x55c85d8cd08c in evsel__newtp /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/util/evsel.h:273
    #3 0x55c85d8cd41c in test__syscall_openat_tp_fields tests/openat-syscall-tp-fields.c:50
    #4 0x55c85d895a6c in run_test_child tests/builtin-test.c:339
    #5 0x55c85d7e7e1e in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/lib/subcmd/run-command.c:128
    #6 0x55c85d897f48 in start_test tests/builtin-test.c:544
    #7 0x55c85d898eb4 in __cmd_test tests/builtin-test.c:647
    #8 0x55c85d89b867 in cmd_test tests/builtin-test.c:849
    #9 0x55c85d7a19c9 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/perf.c:349
    #10 0x55c85d7a22ba in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/perf.c:401
    #11 0x55c85d7a2810 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/perf.c:445
    #12 0x55c85d7a2fb7 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/perf.c:553
    #13 0x7f50bbc5cca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)

Indirect leak of 8 byte(s) in 1 object(s) allocated from:
    #0 0x7f50c5f34c57 in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x55c85d7ad1fb in perf_cpu_map__get /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/lib/perf/cpumap.c:62
    #2 0x55c85d7afc3d in perf_cpu_map__merge /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/lib/perf/cpumap.c:419
    #3 0x55c85d7bda8c in __perf_evlist__propagate_maps /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/lib/perf/evlist.c:131
    #4 0x55c85d7bdd1b in perf_evlist__propagate_maps /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/lib/perf/evlist.c:145
    #5 0x55c85d7becdb in perf_evlist__set_maps /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/lib/perf/evlist.c:252
    #6 0x55c85dabe838 in evlist__create_maps util/evlist.c:1035
    #7 0x55c85d8cd4fd in test__syscall_openat_tp_fields tests/openat-syscall-tp-fields.c:59
    #8 0x55c85d895a6c in run_test_child tests/builtin-test.c:339
    #9 0x55c85d7e7e1e in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/lib/subcmd/run-command.c:128
    #10 0x55c85d897f48 in start_test tests/builtin-test.c:544
    #11 0x55c85d898eb4 in __cmd_test tests/builtin-test.c:647
    #12 0x55c85d89b867 in cmd_test tests/builtin-test.c:849
    #13 0x55c85d7a19c9 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/perf.c:349
    #14 0x55c85d7a22ba in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/perf.c:401
    #15 0x55c85d7a2810 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/perf.c:445
    #16 0x55c85d7a2fb7 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/perf.c:553
    #17 0x7f50bbc5cca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)

Indirect leak of 8 byte(s) in 1 object(s) allocated from:
    #0 0x7f50c5f34c57 in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x55c85d7acd8e in perf_cpu_map__alloc /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/lib/perf/cpumap.c:32
    #2 0x55c85d7ada73 in cpu_map__trim_new /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/lib/perf/cpumap.c:143
    #3 0x55c85d7aebd4 in perf_cpu_map__new /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/lib/perf/cpumap.c:231
    #4 0x55c85d7ad6cc in cpu_map__new_sysfs_online /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/lib/perf/cpumap.c:111
    #5 0x55c85d7ad796 in perf_cpu_map__new_online_cpus /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/lib/perf/cpumap.c:119
    #6 0x55c85d7bbf9d in __perf_evlist__propagate_maps /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/lib/perf/evlist.c:45
    #7 0x55c85d7be0d3 in perf_evlist__add /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/lib/perf/evlist.c:156
    #8 0x55c85dab6970 in evlist__add util/evlist.c:208
    #9 0x55c85d8cd4e4 in test__syscall_openat_tp_fields tests/openat-syscall-tp-fields.c:57
    #10 0x55c85d895a6c in run_test_child tests/builtin-test.c:339
    #11 0x55c85d7e7e1e in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/lib/subcmd/run-command.c:128
    #12 0x55c85d897f48 in start_test tests/builtin-test.c:544
    #13 0x55c85d898eb4 in __cmd_test tests/builtin-test.c:647
    #14 0x55c85d89b867 in cmd_test tests/builtin-test.c:849
    #15 0x55c85d7a19c9 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/perf.c:349
    #16 0x55c85d7a22ba in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/perf.c:401
    #17 0x55c85d7a2810 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/perf.c:445
    #18 0x55c85d7a2fb7 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/perf.c:553
    #19 0x7f50bbc5cca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)

Indirect leak of 8 byte(s) in 1 object(s) allocated from:
    #0 0x7f50c5f34c57 in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x55c85d7ad1fb in perf_cpu_map__get /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/lib/perf/cpumap.c:62
    #2 0x55c85d7beaec in perf_evlist__set_maps /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/lib/perf/evlist.c:244
    #3 0x55c85dabe838 in evlist__create_maps util/evlist.c:1035
    #4 0x55c85d8cd4fd in test__syscall_openat_tp_fields tests/openat-syscall-tp-fields.c:59
    #5 0x55c85d895a6c in run_test_child tests/builtin-test.c:339
    #6 0x55c85d7e7e1e in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/lib/subcmd/run-command.c:128
    #7 0x55c85d897f48 in start_test tests/builtin-test.c:544
    #8 0x55c85d898eb4 in __cmd_test tests/builtin-test.c:647
    #9 0x55c85d89b867 in cmd_test tests/builtin-test.c:849
    #10 0x55c85d7a19c9 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/perf.c:349
    #11 0x55c85d7a22ba in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/perf.c:401
    #12 0x55c85d7a2810 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/perf.c:445
    #13 0x55c85d7a2fb7 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/perf.c:553
    #14 0x7f50bbc5cca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)

Indirect leak of 8 byte(s) in 1 object(s) allocated from:
    #0 0x7f50c5f34c57 in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x55c85d7ad1fb in perf_cpu_map__get /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/lib/perf/cpumap.c:62
    #2 0x55c85d7bc2dc in __perf_evlist__propagate_maps /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/lib/perf/evlist.c:58
    #3 0x55c85d7be0d3 in perf_evlist__add /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/lib/perf/evlist.c:156
    #4 0x55c85dab6970 in evlist__add util/evlist.c:208
    #5 0x55c85d8cd4e4 in test__syscall_openat_tp_fields tests/openat-syscall-tp-fields.c:57
    #6 0x55c85d895a6c in run_test_child tests/builtin-test.c:339
    #7 0x55c85d7e7e1e in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/lib/subcmd/run-command.c:128
    #8 0x55c85d897f48 in start_test tests/builtin-test.c:544
    #9 0x55c85d898eb4 in __cmd_test tests/builtin-test.c:647
    #10 0x55c85d89b867 in cmd_test tests/builtin-test.c:849
    #11 0x55c85d7a19c9 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/perf.c:349
    #12 0x55c85d7a22ba in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/perf.c:401
    #13 0x55c85d7a2810 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/perf.c:445
    #14 0x55c85d7a2fb7 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/perf.c:553
    #15 0x7f50bbc5cca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)

Indirect leak of 1 byte(s) in 1 object(s) allocated from:
    #0 0x7f50c5f2ed60 in strdup ../../../../src/libsanitizer/asan/asan_interceptors.cpp:578
    #1 0x55c85dad513f in evsel__init util/evsel.c:392
    #2 0x55c85dad9b58 in evsel__newtp_idx util/evsel.c:617
    #3 0x55c85d8cd08c in evsel__newtp /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/util/evsel.h:273
    #4 0x55c85d8cd41c in test__syscall_openat_tp_fields tests/openat-syscall-tp-fields.c:50
    #5 0x55c85d895a6c in run_test_child tests/builtin-test.c:339
    #6 0x55c85d7e7e1e in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/lib/subcmd/run-command.c:128
    #7 0x55c85d897f48 in start_test tests/builtin-test.c:544
    #8 0x55c85d898eb4 in __cmd_test tests/builtin-test.c:647
    #9 0x55c85d89b867 in cmd_test tests/builtin-test.c:849
    #10 0x55c85d7a19c9 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/perf.c:349
    #11 0x55c85d7a22ba in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/perf.c:401
    #12 0x55c85d7a2810 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/perf.c:445
    #13 0x55c85d7a2fb7 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-d430e742d054657591e1a95a80507afb758b499a/tools/perf/perf.c:553
    #14 0x7f50bbc5cca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)

SUMMARY: AddressSanitizer: 47054 byte(s) leaked in 22 allocation(s).
 15: syscalls:sys_enter_openat event fields                          : FAILED!



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251119/202511191644.294eaf97-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

