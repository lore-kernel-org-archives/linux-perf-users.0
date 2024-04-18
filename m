Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38E6495CB
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Apr 2024 07:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713425948; cv=fail; b=iJlmhlmUMv5qKWGtb00Q/NAsz2GEtKSd02t2c36Ge9C+S70mcDhUaoKJEdkxaCAAzetCDYhwJUcX4NhGbjYzuDfMwNKy3Petc0RXBRO747K1vs6PxWGwqXSeItc9yqN9yeo9NOnFjZOki/4fl9r2T7LYBTXDjXZu4ljCIdBsBGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713425948; c=relaxed/simple;
	bh=34D1x5Z4AKtS19HRApocpgpV/kL3KBpRzg05bJMumDk=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ibTBoCCOGF4Eg7czGnV7AsEVlY7a7DFkfGIAITlFc2CXDQ0tFbPH8j9xeJidKjmzGJVBJN0amIKuKhysvw5P1iP1eQr46Q3SskFMWJ6o0/P0eLMRREhCX/cZh36Uj7zKhYqwlLRQQHGKqbX+KTwwXOlBwn6LvqyvTswP9l8HNaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TLIwwGhe; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TLIwwGhe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713425947; x=1744961947;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=34D1x5Z4AKtS19HRApocpgpV/kL3KBpRzg05bJMumDk=;
  b=TLIwwGhev4L79Lqus+i/iqPRhOsKp+De/L5En69pdm+2SeRcOlrA61ez
   z0tIhiX4WXPO5ar4yY5mzXsdOFyO0rFNPhEg7CN+A3BbKckbdyDTYbui8
   86yjSwCwfDB3j3RQctl8nm1YiWc6qkb3YB00Se6SBcTxf6SrKLhReM/z3
   SUmO2Br09E+7IYSOCQlXKFVg+24wvi/ibAS+69R6yS/D+Yc/+clZL+oyV
   W1EKPjC7FzFmesde2IN9wZmztAQ119VY27iOhUmUb7K6NbpNlrunzzoT2
   hj4jhJPK/B/XDpN3OUyaydVrYIJ6Geq4qRhC440/+nft0dEZYJUx8tOdP
   g==;
X-CSE-ConnectionGUID: wM4ZVvbKRP648xLfYhka/g==
X-CSE-MsgGUID: be9nipf+QV2RGltyZA1RNw==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="9504459"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="9504459"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 00:39:06 -0700
X-CSE-ConnectionGUID: 6iNqXiJqSym5T7qupCP9eg==
X-CSE-MsgGUID: FWyxYhupQP+QXYtzD5NmEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="27318583"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Apr 2024 00:39:06 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 00:39:06 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 00:39:05 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Apr 2024 00:39:05 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 00:39:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGSGGCelDtAQK9Mh0kcgEPSSeesGznqsIYzlBjVVENTE78U23Ajknc9xKGo8UXe9Wb2G7UhfSSAAS0YpnIiPvUg2uqT2b6v+ojF5SJoCd2rwoAtXUwsPEgDqpIEr3wZIn3vmBqNFCYsW5uO7LniBbqRE6RyOln+u/r6Y4qSQUGmEvInzVGihyNEH1oBcxF8cu12OzY3QkC+Omrep0i7rkQ7EHILL8l+Pl+s1YWhdJN3tMV3Ph6cchTCLVyCLRZ19VhmzNnMxAAVyl4ftESsTNfvDa8tDoH3GmI8MN2eGxBe90VpDULJF+PbmNu1VDyFKMN6nf/rjM3SMDu48cu0QaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGIvvVnir+6LsOY/T/YebQTT4uWX9beteD/rfrxDFIA=;
 b=l/yqtaYQlVR9Rd70NXQfbnBeOgnoVBuE/yJZ5CJoXnowcLFLcbF5wJSCj0kD7NNn6v1Wdy7higcFTj4kSfn12aHi1rNCQHkrslx7P3+S06ttdbbnHS28njzpMmTJk4gXzNoQvZgGo63TjAFhknL2mSg9AnG2uaH4SEJmcJybZxpwjZHBHjqfpch3K9mrvzBIF8G8ZVwJDWz8G5Yc4Q2HNzU8QMYviYZRMPuShhXgddDY+aXcP8HJ5L9x2EIpaWJ7lLQwc5WXlsla+M7vwNqDKZaTLSis8w0olB4Gg5glE/DAxK502uMyEl/hDeamwCiopWfFCG9U7witfK2d/ANGZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8393.namprd11.prod.outlook.com (2603:10b6:806:373::21)
 by IA1PR11MB7367.namprd11.prod.outlook.com (2603:10b6:208:421::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.28; Thu, 18 Apr
 2024 07:39:02 +0000
Received: from SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::c0cf:689c:129c:4bcd]) by SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::c0cf:689c:129c:4bcd%6]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 07:39:02 +0000
Date: Thu, 18 Apr 2024 15:32:27 +0800
From: kernel test robot <yujie.liu@intel.com>
To: Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>,
	<linux-perf-users@vger.kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>, <anshuman.khandual@arm.com>,
	<james.clark@arm.com>, Chaitanya S Prakash <chaitanyas.prakash@arm.com>
Subject: Re: [PATCH V2 5/8] tools: Delete strstarts() and replace its usage
 with str_has_prefix()
Message-ID: <202404171224.IlskYwJw-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240408062230.1949882-6-ChaitanyaS.Prakash@arm.com>
X-ClientProxiedBy: SG3P274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::15)
 To SA1PR11MB8393.namprd11.prod.outlook.com (2603:10b6:806:373::21)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8393:EE_|IA1PR11MB7367:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a6476e2-3672-4965-7434-08dc5f7a9e34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r1dljdHZl+mjVI+Kffa4nHEoVCDXFBEi0237Uq1AOt7slOMT0CrYD4FiERU27cfHGL3z57gaiTKIi0PSfaxOyddwUTgD0FSvVxM8sbtOqi3lrr3ct0g5UKSjH9fW8Q0L82cy5cGvNJMwQs40PaONPoRPMhtS1Sk4XY61Q6zdW8W9M0uj7+P3TKZzy04vWwX7xMRq/bo4xllB5may05T/NpYDbEjMrKbfwPIIdX0+D5hOCZghUHwaF4fdG2wMLunhIqgyymSTPSLqoAozx4/V3RSlsr0KsvI0HzTokp2uJDQqqgyiLW+pYPTbeepS4acNUkIWbid2uFm2hal8Wo4BlT1H7G94E2DRXCWt4TE46nalFLtSIQOOvpS8Z6JbRh6q6OdB3/VOIRgbpkhITtXlgK+rID4kbB3G+X0CGpMgf2BK8WJkc0/8jGa67qpQES62ax4kZPmb/kup3vB9M9LZMmLdGymhX/bW88VLMNfx2nEigDgMl2yT2B7ruXSqNGyhRvVFp4Yp4Fhm9Btasa+2dmqgUwhM+683FwX7dxRitN6L4uyqcFETMz8sjGXo7ZxjkVn33bkSTm17lk14dashS3qLjDt90ehekWJJl0SPaGyn7xnMrvx+RlSPWB+L1yLo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8393.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hsPSOrWUez5Xo75+RMDX5R8Ww6G71ygIW29bYV3ZdKMr4FhD5o/7PtKmyt15?=
 =?us-ascii?Q?QiNlnPX2ostOs21g7g4sckmxxIYlFeopiGB8sPWh2iHwZHYzu96sx+ww04uR?=
 =?us-ascii?Q?I1jG+wRF4RE5M/pZ5d+rhkU0l/WiTuu48J8GjJot69teSseOVm1i1b+9iLsy?=
 =?us-ascii?Q?Hu9bRGowUKBgUUlo7p7OcHUo+pLrGwDYFTz7Eg88arSWKJmqtl+LS57MHyj4?=
 =?us-ascii?Q?RqJz7sMQgYWWXAEWWPdg748ok8u1ZUgz1DATheA6hA4EPi9H9tNZQLfvXHAz?=
 =?us-ascii?Q?hxT76wMpJO2EvkaOYmksEIX8UyL9e+rbowdSJKUwRohZRbW4hvksBhVmXLEo?=
 =?us-ascii?Q?tOeGLWR7vxgZPTIG4i+kSjCYzWNblP/sVn36idIU9f/FX5QQO2tsRXyXZSLY?=
 =?us-ascii?Q?yCzBCFSHhHlW2AoGJDSJCJusNTrag6/wRwcZFqlbGaU665CuIPeZtV25B+cf?=
 =?us-ascii?Q?zZ7kGhaRo2xN+Cn6fQuRVCAnHsajnoN08uwZZDAgHzHxWTyq/NrHUAr3NBja?=
 =?us-ascii?Q?kHqS3bvpZ/J1QIoTmlsHNr5R3DiSynRJrWIuV7nZrlzIeAiT/X6saPcStM0c?=
 =?us-ascii?Q?HJaMj3aHtrjQC6Qb1eEVpVeVwAaMPlgv99XOzxTeF1WnGXAMxUfYWz/A/N/p?=
 =?us-ascii?Q?+ieI1x7eBLkeT7G65bg9Tmv1sWJYMDPejHFHY7HcjPHf8gmSoIrav8jFbLho?=
 =?us-ascii?Q?lndIzi0PEKd8B8DTFqfqesCfIEsEA7gayyFokHjUhWT5zxESs1aCDlZAo1yr?=
 =?us-ascii?Q?WbfgHuR6lm8YEjjWWvnM79x9FyvmCrvo9NN/E8H2WhZO0UDD9kNIc4b1WikA?=
 =?us-ascii?Q?+UlzqAChXJ1jaftjdyrjcgaodKuXzhvnEZ59doe4f2S8sdQ6BZffZYD//K3T?=
 =?us-ascii?Q?J62yLC2WygK5xO4bSlGKx787ne+IhffmlAU6R45Z+iMPGcGW4crYlu9g75vP?=
 =?us-ascii?Q?286ZzhPIXMbWBMcXL1ezibBCuBx38Olx7qvZ3RkPDo0S4ZCC7HuuSIP0abvX?=
 =?us-ascii?Q?F0BmdOPMEW1dGtGamvGFbkX+hET34wGlUvqDmOApRfaQQfIk3h/wZGww2dIr?=
 =?us-ascii?Q?f5PeK51UXQNMlWCquAHMDJucKgpMpc8wojBuw9mo7hszDxy8a+GHKgBTCYuC?=
 =?us-ascii?Q?7xyxOhu5bW3DAb4yGqk3ERAhFFzysyK57Qf5y7vrB1NQcVbnVufUjglsN2F1?=
 =?us-ascii?Q?055EiZcFSkn5cFfrc87DNo3gJuM8UHyxBHeuTCpKBCxshzOLSv+ClVfxWehh?=
 =?us-ascii?Q?OnYetBpekqL9u3NHibVS0xXc833kQ5Gnr1tTqUk0SE/+8Ls9uFeHjV4AQzt8?=
 =?us-ascii?Q?QIos/UtpUj0C+BJuF+EPugpIoEpz3HS+QmNg9kVl6ZjfooL5iFqloiT4IJyz?=
 =?us-ascii?Q?6esxcato+IR/s2JPW490SHKwsX0fhtbwVRHueWCB7s7Q0Q4EMXEUkAYuqMx6?=
 =?us-ascii?Q?8TZ0hoE/HA7MGfkVtYaJjR4G71ai5h0xvYMXEwhzUz5NVAuPN8uNqXr4Vpph?=
 =?us-ascii?Q?5FxOZGxfv9FmRyYr+p+8SjezZCS1WW2lT/Z7p+qtC5lCDMbyytAXY+PqkNSG?=
 =?us-ascii?Q?mkGPqWa4MEVT/2yxUZVBy2ODBGaGglv1VnvkTTZF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a6476e2-3672-4965-7434-08dc5f7a9e34
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8393.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 07:39:02.7792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Df0VO/luDSS5/LYhfVNbV+a6W3yLYoFuQblsJbrXrDLAeIfLrCASyMlwp+pWrUnhQJXOKJEolBsfXCN2zTfHgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7367
X-OriginatorOrg: intel.com

Hi Chaitanya,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/perf/core]
[also build test ERROR on perf-tools/perf-tools linus/master v6.9-rc4 next-20240416]
[cannot apply to perf-tools-next/perf-tools-next acme/perf/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chaitanya-S-Prakash/tools-lib-adopt-str_has_suffix-from-bpftool-gen-c/20240408-182552
base:   tip/perf/core
patch link:    https://lore.kernel.org/r/20240408062230.1949882-6-ChaitanyaS.Prakash%40arm.com
patch subject: [PATCH V2 5/8] tools: Delete strstarts() and replace its usage with str_has_prefix()
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202404171224.IlskYwJw-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ui/browser.c:580:6: error: logical not is only applied to the left hand side of this comparison [-Werror,-Wlogical-not-parentheses]
     580 |         if (!str_has_prefix(var, "colors.") != 0)
         |             ^                               ~~
>> ui/browser.c:580:6: note: add parentheses after the '!' to evaluate the comparison first
     580 |         if (!str_has_prefix(var, "colors.") != 0)
         |             ^                                   
         |              (                                  )
>> ui/browser.c:580:6: note: add parentheses around left hand side expression to silence this warning
     580 |         if (!str_has_prefix(var, "colors.") != 0)
         |             ^
         |             (                              )
   1 error generated.
   make[7]: *** [tools/build/Makefile.build:105: tools/perf/ui/browser.o] Error 1
   make[6]: *** [tools/build/Makefile.build:158: ui] Error 2
   make[5]: *** [Makefile.perf:706: tools/perf/perf-in.o] Error 2
   make[4]: *** [Makefile.perf:264: sub-make] Error 2
   make[3]: *** [Makefile:70: all] Error 2

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

