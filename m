Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5897F7CA;
	Fri, 28 Jun 2024 06:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719556653; cv=fail; b=E0jjkQxl8dxqVZUnigUCq/3kziyCgERp8xS7m8I8EI4fZfWPnoI3mChR7XQe2t8zEuuL8gJrsXmsEwdao2147UfAjk1wrlo/n9GHIB8iVWIqlIwA2YVLXB/UdduxZLC3hdpBegNBAgo7EeVpzoA3TNGC5cudPQgPtNhek/BBrlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719556653; c=relaxed/simple;
	bh=sZ6/4zb8Iw7iRyhoSmtltxVT2Zexby8FmglE4BXS6Ao=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Km7cTOwkw0n4TAEqLWMo6z41vckvCUPb7eocFzaqmX/MLnYWCpBthzfFL1nuQ/xwNpN2nhX855pjyWiP5PDQdBfvwIamcAXapCtRWb9rQ+kGqnqPYXWRPdS3SZ/D6XangXdvuKba0TZ6QsacW3m7Wu9KElqVjLRYkNV+FILe5K8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P7VSlaCn; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P7VSlaCn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719556652; x=1751092652;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=sZ6/4zb8Iw7iRyhoSmtltxVT2Zexby8FmglE4BXS6Ao=;
  b=P7VSlaCnKg0dMSA5ZwjtEGHzJwCaMF0bADIWhzDuA9HxI+KmuO+zoW8Q
   Jr58EiA8NPCvteHeYD9YE8/mVrAJ0jD5b4U//aPXjAke3hGhsl9YCWKYD
   PpNOqKxMl98D2LhpJeoIuieQV5NzPZhLr38aBtbSKmGtwudLtZZTlEtj7
   aemPy/+w1Oup2VNv/qbG1Fcbuy/H43Ikv+0JxKLFzg8nk+0zBGUALsrt0
   FW2pN5+JtL2cQdMgDqjQ8D3h0TuRUFCx9PK5r9orxjp2PxcgIUzenCfsP
   RNnYl9+5XQ0ecH5j/DHSYxmOfRbuKu+AxNFZNfNoma4MdM56ZwH0MIoKw
   g==;
X-CSE-ConnectionGUID: L2uIJzZDRUG/qdkzk+SR2g==
X-CSE-MsgGUID: Bb2Re5epQrKzCIfB/iaqhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16856352"
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="16856352"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 23:37:31 -0700
X-CSE-ConnectionGUID: mONsmQAHR9GLFa5rl8lcgw==
X-CSE-MsgGUID: m4srZj+MSHi7iKRj34XVsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="44526319"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Jun 2024 23:37:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 27 Jun 2024 23:37:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 27 Jun 2024 23:37:30 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Jun 2024 23:37:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKhI6Ph6gfwWi9ItjKysTclGXsfiu5uI6BAug8qdIvC2q2EVkbeaoSYZkgaf7MoXJWif6ZwMULmAPGwx/ROKvmJAfsJX/O84aAP7Z6qtD+b1MCDsGUHO2KvMuP4Qom8G5GzGucUmkhUIvHhFgpIQ8+tr60/g0cOIw3iS+2IeDBhGy6q38ahZ4Z2lsI3s6zNf4foGmLFkeko/IqJC/pK4fPB//MoOTBd2IHaRDFjdgLX5wJYAXc0H+TQTlX8iSm7m0DShOJjLgQLPbJSh2RwnNW37yohwtYFZb8vTCSI1HJ0hiTtS9X//pj6BxVaK/jZ9fD7dFBUhZB6+ECYBPo8Udw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/LAz9+AlI8/f9ixB1sNzFvbRNtUjR1yGzh3WLe5sYo=;
 b=IeAadKkWXMU5b51vappySlr7G5/ycp0+M7XLBR4+sTNL/nESMe7X2M5tDyCBByN8HQSdo90o3bWT55YjLHR/9RSSY04SxlfI69OfsIyYCclKiUgEo8HwZCOe/P29+02gawNX0raNMpysCmK2QnDe59ATqz22FyT51JiYjy4vNAgiQC6I9W6g8Ixpe2G0ErsSSW83CRBsR/1UEzMCBEcN4ZVnbk6EbSx/RddhSYl7n1mzH32SI6D0aqDXtQpbAG3pVsmU0u06kTX92M08fau3Fp4QahKjSrYNE5VaPiyz+6edmqaDfbYSV5ZIjQEs4xa/iMputNg78+sHKR+kk8T5jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6) by
 SA1PR11MB6687.namprd11.prod.outlook.com (2603:10b6:806:25a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 06:37:28 +0000
Received: from DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9]) by DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9%3]) with mapi id 15.20.7698.033; Fri, 28 Jun 2024
 06:37:28 +0000
Date: Fri, 28 Jun 2024 14:37:14 +0800
From: kernel test robot <lkp@intel.com>
To: Howard Chu <howardchu95@gmail.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>, Jiri Olsa <jolsa@kernel.org>, "Namhyung
 Kim" <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
	<adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] perf trace: Add test for enum augmentation
Message-ID: <Zn5aGnyjyCqAX+66@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240619082042.4173621-6-howardchu95@gmail.com>
X-ClientProxiedBy: SG2PR04CA0167.apcprd04.prod.outlook.com (2603:1096:4::29)
 To DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6039:EE_|SA1PR11MB6687:EE_
X-MS-Office365-Filtering-Correlation-Id: 4afa6539-042c-49ce-03dc-08dc973cc72a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ukKE9FtGCxbaTiDWq21WvFYMZu63OXEkLv3pI0AV785rdItQ2/qQ3g7Ls+Yw?=
 =?us-ascii?Q?efCjJIQz0aBiA+Rrr0pA5pJ0qOq06syQPUnJig1xlQV/O90hAKa/TR6dMyWC?=
 =?us-ascii?Q?4Tiuk/Qm7i3iz5eSX8ySWCN4TXZd09ElmkREfPg5s4MnyobM0sulMnUcO2XA?=
 =?us-ascii?Q?8jocTX1NrxEYJiDFXuNFZI+m2U2CVG8EgBypPbY0ByXFhLO8nYpaNAvtQNlW?=
 =?us-ascii?Q?cNbIXx59v3oCQd26GsAAZsEJXAqWfRLwzIUH4EAHcMrpo0MMbHvc1dfb1IRR?=
 =?us-ascii?Q?ZyDNm55sL5zJ+Xz42qbkN55bcEYXM4xhcfHD55pMLNKwVrQq8s09OI8J+PUN?=
 =?us-ascii?Q?9D6Bj6+vS0cj5+lALzrWGdCyYNXrKWa2qNgJGYMRkCYUtaSTXGzxzR8yvnZ5?=
 =?us-ascii?Q?tGrvkjSjN5dRjdslO2tldmHyk/Ij7pEy5KjY6swXYEaMGMp98DyqklJgvrKS?=
 =?us-ascii?Q?rb8XftYQtBGA/af6sM82kL9p6PhDxB6LeMBWCSY70AKqAQLEvvisxi8Gmvvi?=
 =?us-ascii?Q?NEGmK5PWxtmQlHE5Rz/aOyCQ4A5wmJoqtlUITXL9Cy3uhzXmRjtu90DErxPa?=
 =?us-ascii?Q?Oc3tcE5k5mKL62zmAMj8GFN1FZkK0G4dZhaV8vE+iGwwzNxZq77Y7qtrXVCp?=
 =?us-ascii?Q?UabjxlvauhmYga3SJkACR5rfmEG0IAT8x9h0bxqZqOx/HGWaZuigJEo8v15u?=
 =?us-ascii?Q?GubAQ0PGAt0++O0mHfx/loIgPs+bT83gzND7onAWL5iUP9N0LA/oqYCp12ax?=
 =?us-ascii?Q?ZLb+sCDq9Oga3ljWohfKGhngW3uAAEfcnC8n5UK88VN5vGQ+mJysCSyl89b4?=
 =?us-ascii?Q?lNlDPO1mDsNwNcA+uWmW2f4sfPHxr3kiyyCPoCSwmEO27JpEYCvbyFQP9at2?=
 =?us-ascii?Q?wJ3M3SSxp6CNCJgfNevK5f11nHWKukAqViAY7KE1jihM003CB1n3YWE1leRu?=
 =?us-ascii?Q?MVIksr84NB1dYVtoBFZ5+tyM2JqsHfDp19D1c75MWiABpv0PfyG9F+L1v+Q+?=
 =?us-ascii?Q?JpHTjzCeCPx0inSNMOSgIhKMBWHcz7SQLFBdHfDvSyYCiMzIojNLsbFGW5+r?=
 =?us-ascii?Q?SIG411qMCUCYcSo96W4+a97Qfu5rDMpodicUVGhezoqwdIO7+Ilykcs4pUjD?=
 =?us-ascii?Q?rw4pRTG3Ng4ojW9KfNn5AElBkGvCTmFj9RdwiN98ItG0PxlvcRRXqtio0qme?=
 =?us-ascii?Q?nkFQGQpR5iFsOYweMVxmeOvpqE+tcyWnq7KZS2hrrWz1ijPuylIlmxKBXSOr?=
 =?us-ascii?Q?7cCTXbRHLayrZgoW0zEfy40oP67YDCwEzjZgSlnUAsf0VD1Jez9abjz8fE/c?=
 =?us-ascii?Q?Tks=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6039.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Uzkwi8/aS/xftAT3CPGBqavObPzCaNU7gEBiCngrR4uh0OVEX0BZS+X9nlmn?=
 =?us-ascii?Q?Cyemh3nmmoee60rvpvey60HNuodkczkvVPLcypWrjej5RWoa35asAtiMIFHv?=
 =?us-ascii?Q?3sY4TrK5SK36OSlcot17ODtxcr/N1nWHwBZ+kLMEzKpJUpOstKmjI8L4m/5y?=
 =?us-ascii?Q?GXhSsb9vhRO8bcGMtKP14UmY92ImEDnGARypI54bIpo1KSH0pZuLX38XiDJB?=
 =?us-ascii?Q?7A7t2TyRT0Xc2hKBDp3kQ4v3iRXjV4hpCIjnjhAUfeAmEKoZl0y7h1oTsSDT?=
 =?us-ascii?Q?wQkwlcld8KK3RF8+LJvw1DjtPTPX92l6mFeEmYObm2IQdCOu3ws0u0yyeuFk?=
 =?us-ascii?Q?o0NP62PKVUFudBy0vj/9dXkeFdD921abGi3WYw/C5nSSWhgcQKTaMap7ySXm?=
 =?us-ascii?Q?Ll1gk4v1nYsgDmyMqKDoQmHdn0OEByY5pao2BjW9nTYB217nBLUu0v3LzOxA?=
 =?us-ascii?Q?ahhP/LA7N2CNpcAHDsB1BbVW28RJzDoXl1H9iY3t08bz4mak+gFyqNS5VswZ?=
 =?us-ascii?Q?Jg169d6Q8va9mQbUqUwzdkdPC/5wgD7kzHTxQG9PVv7hMtUjlybMPOJG021L?=
 =?us-ascii?Q?AthwQzB9XVVu7380p1qNFQ15Jt/Z6Du1A7C3CINBAV6VOjZKkqFiG33ftbqX?=
 =?us-ascii?Q?qq82C0HbcAATS0wmwEY4aL+rcrfRoyFOWS6DiFtYewbzmcc7Myi8gpQBBGqV?=
 =?us-ascii?Q?8eDCKbi98IxgQRJ53Qb+xnVooGbkdzR3nXNxa1Rvs8tPwMzhgtOJI1ROWkWp?=
 =?us-ascii?Q?0dFVl17PUBgMZCpLTHbbRjDyh/YxM5TysOrunOC899dZbz/JNe/sBqJ/oCg4?=
 =?us-ascii?Q?DFJo0ji3eWSbd4rI3kQgKzrRsUJoRNJRSZYBCx1yzOSIH3hzvRxK3i/+h0sd?=
 =?us-ascii?Q?mhXF+1cWp02Rrt8TsBteFzLG6i5ONrt+hi3EYsboCc3tk4Y7hddci2SgFCoD?=
 =?us-ascii?Q?TC0Qb5y2R8Aog/m3YgvvYEgqDnD8gGKl2DVIFnD5ZKcOq4nb9geQQdeY6mXf?=
 =?us-ascii?Q?0tWpShOCa4YDOfmVxfdzy0org7U1GBUw//yKzNpbJTckj2sTLC+WTLW+0t4c?=
 =?us-ascii?Q?e90KU2ul40iIMq/IVzvWpMs1AULAtx32f3C3Zp3dmRCav4mk5rbGAPJFrjGJ?=
 =?us-ascii?Q?ZUpJXcYRx/gMR8oWle5thghdUoYOkEMLfLXFovm7f5vRWpPCgx9ali1szbaW?=
 =?us-ascii?Q?G0HkRxARLi6197sxxc33mcp3uYHZ6s40oCdNVKwe8AcMS5BWjL5uzHY2J3ZJ?=
 =?us-ascii?Q?taHNdi4YuUf0AXQSFuEe6a8pGl9ecJkKXX+h9eD0nvSvcskXTn48nMN4USuT?=
 =?us-ascii?Q?Z9yn3qeQWroRviOZMLDLlXweuLLTqxPg7fSlPocbnpRnG34CGaLVOa5LGsTL?=
 =?us-ascii?Q?44+uyZM9Wod2HypKBKYFy/IeSJJ0fCWeinKv72/hMefHgHrj9HIpw1xBPydk?=
 =?us-ascii?Q?9QJBzkjOVYCkX8dW6aj4+hEDjBOrGe8ErHgRA9bp5WuG5xPpc+LncfPXEeoH?=
 =?us-ascii?Q?+AGaiAa4ARSZu3ZNGvliJwE/2sliqWviRHY3dJrw2C0GiJ1I1uHbgYlVCieC?=
 =?us-ascii?Q?GCeDfj6EtgFZd3Xvlyn1bsMAGWkvXMMzfaqwKIC2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4afa6539-042c-49ce-03dc-08dc973cc72a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6039.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 06:37:28.4233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2QWew6Jk9OEjhEFiFB5AmzFoWha/O9NQesKYN4E7FrJ2Eb4RcwzrdScXbSJbV0ngkOse65FdOLVhTgVRxrDd1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6687
X-OriginatorOrg: intel.com

Hi Howard,

kernel test robot noticed the following build errors:

[auto build test ERROR on perf-tools-next/perf-tools-next]
[also build test ERROR on next-20240621]
[cannot apply to tip/perf/core perf-tools/perf-tools acme/perf/core linus/master v6.10-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Howard-Chu/perf-trace-Fix-iteration-of-syscall-ids-in-syscalltbl-entries/20240619-162417
base:   https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
patch link:    https://lore.kernel.org/r/20240619082042.4173621-6-howardchu95%40gmail.com
patch subject: [PATCH v2 5/5] perf trace: Add test for enum augmentation
:::::: branch date: 5 days ago
:::::: commit date: 5 days ago
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240625/202406250302.E4WaX9Ud-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202406250302.E4WaX9Ud-lkp@intel.com/

All errors (new ones prefixed by >>):

   Makefile.config:663: No libunwind found. Please install libunwind-dev[el] >= 1.1 and/or set LIBUNWIND_DIR
     PERF_VERSION = 6.10.rc1.gf6ac54426465
>> tests/workloads/landlock_add_rule.c:20:24: error: use of undeclared identifier 'LANDLOCK_ACCESS_NET_CONNECT_TCP'
      20 |             .allowed_access = LANDLOCK_ACCESS_NET_CONNECT_TCP,
         |                               ^
>> tests/workloads/landlock_add_rule.c:18:32: error: variable has incomplete type 'struct landlock_net_port_attr'
      18 |         struct landlock_net_port_attr net_port_attr = {
         |                                       ^
   tests/workloads/landlock_add_rule.c:18:9: note: forward declaration of 'struct landlock_net_port_attr'
      18 |         struct landlock_net_port_attr net_port_attr = {
         |                ^
>> tests/workloads/landlock_add_rule.c:26:38: error: use of undeclared identifier 'LANDLOCK_RULE_NET_PORT'
      26 |         syscall(__NR_landlock_add_rule, fd, LANDLOCK_RULE_NET_PORT,
         |                                             ^
   3 errors generated.
   make[8]: *** [tools/build/Makefile.build:105: tools/perf/tests/workloads/landlock_add_rule.o] Error 1
   make[8]: *** Waiting for unfinished jobs....
   make[7]: *** [tools/build/Makefile.build:158: workloads] Error 2
   make[7]: *** Waiting for unfinished jobs....
   make[6]: *** [tools/build/Makefile.build:158: tests] Error 2
   make[6]: *** Waiting for unfinished jobs....
   make[5]: *** [Makefile.perf:727: tools/perf/perf-in.o] Error 2
   make[5]: *** Waiting for unfinished jobs....
   make[4]: *** [Makefile.perf:264: sub-make] Error 2
   make[3]: *** [Makefile:70: all] Error 2


vim +/LANDLOCK_ACCESS_NET_CONNECT_TCP +20 tools/perf/tests/workloads/landlock_add_rule.c

f6ac54426465a5 Howard Chu 2024-06-19   7  
f6ac54426465a5 Howard Chu 2024-06-19   8  static int landlock_add_rule(int argc __maybe_unused, const char **argv __maybe_unused)
f6ac54426465a5 Howard Chu 2024-06-19   9  {
f6ac54426465a5 Howard Chu 2024-06-19  10  	int fd = 11;
f6ac54426465a5 Howard Chu 2024-06-19  11  	int flags = 45;
f6ac54426465a5 Howard Chu 2024-06-19  12  
f6ac54426465a5 Howard Chu 2024-06-19  13  	struct landlock_path_beneath_attr path_beneath_attr = {
f6ac54426465a5 Howard Chu 2024-06-19  14  	    .allowed_access = LANDLOCK_ACCESS_FS_READ_FILE,
f6ac54426465a5 Howard Chu 2024-06-19  15  	    .parent_fd = 14,
f6ac54426465a5 Howard Chu 2024-06-19  16  	};
f6ac54426465a5 Howard Chu 2024-06-19  17  
f6ac54426465a5 Howard Chu 2024-06-19  18  	struct landlock_net_port_attr net_port_attr = {
f6ac54426465a5 Howard Chu 2024-06-19  19  	    .port = 19,
f6ac54426465a5 Howard Chu 2024-06-19 @20  	    .allowed_access = LANDLOCK_ACCESS_NET_CONNECT_TCP,
f6ac54426465a5 Howard Chu 2024-06-19  21  	};
f6ac54426465a5 Howard Chu 2024-06-19  22  
f6ac54426465a5 Howard Chu 2024-06-19  23  	syscall(__NR_landlock_add_rule, fd, LANDLOCK_RULE_PATH_BENEATH,
f6ac54426465a5 Howard Chu 2024-06-19  24  		&path_beneath_attr, flags);
f6ac54426465a5 Howard Chu 2024-06-19  25  
f6ac54426465a5 Howard Chu 2024-06-19  26  	syscall(__NR_landlock_add_rule, fd, LANDLOCK_RULE_NET_PORT,
f6ac54426465a5 Howard Chu 2024-06-19  27  		&net_port_attr, flags);
f6ac54426465a5 Howard Chu 2024-06-19  28  
f6ac54426465a5 Howard Chu 2024-06-19  29  	return 0;
f6ac54426465a5 Howard Chu 2024-06-19  30  }
f6ac54426465a5 Howard Chu 2024-06-19  31  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

