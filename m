Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A53928FFE5;
	Tue, 17 Jun 2025 08:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750148493; cv=fail; b=uLzRktS548F2CzZTJECdA2TCRg4RXb2Zd6T7Ksw7ZxQ5vIxHngzzPWOPYHVV5m4EI7GgXrTEU1BBGq5KYNuwN5YonQZKfz9slHbguu4cmtxgrSi3Cadby1AoTVYi25jjpY4gF5DElJHUl7BATIQJ+NQVWMTZfmi2OsZDef3Zbw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750148493; c=relaxed/simple;
	bh=HN+JoYDgSv92m3cXoF1WiKhKoKMIzk2Kp9gUxiSpqcE=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=b+m+v0E3v/2cttIhNdrBOQ0Bh+hMyAWi+zH+0rSYrT1G6XIra0lq5eM/70NAShggSRfWdPe3mfn7ZmvbT/gGLneuKVqJ3qudmpl37uSlDqcr8X6STGAaBO/Jf7NMh3T6M+5pcXpV3rx9AruqLUAAuK0L3YlQy47HE0E+I8tnUZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Erqvu2RA; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Erqvu2RA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750148486; x=1781684486;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HN+JoYDgSv92m3cXoF1WiKhKoKMIzk2Kp9gUxiSpqcE=;
  b=Erqvu2RA6iYZKE5dWZ+27vGFLvDEKnJmVcfjT48D6XCsNpAPNgt1uQJs
   NtcLJDks6+8L06wcbQ6c60reLNfZqlw7hOjezhImlROH+DaMsPHmUdGXN
   6OQswceE5EgEyVaQ6rOImGwkx1+04onZJUTEZx5p/Xqi3aEePfOh1TmN8
   y+7UK5y5kXzbGQRYVVgXVCEvDJThZDXkgHQ3B7sVuMVqDHZe5KmG71VHR
   WqaTnTTU/3ROUoz4wA0u8AVf8HcUFHu0c61lbgl/TR07ELpJUTL0taUL4
   VmgBHOtff+i0Vx+aWS+Qi7M2vWv/tWTIwzdF3NtctK45F5NXELxiCwMty
   g==;
X-CSE-ConnectionGUID: JrWdPXCQQ5qHQwdrHwdmug==
X-CSE-MsgGUID: TKtvkn6tRSe9RE3pPcCsXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="77710559"
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; 
   d="scan'208";a="77710559"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 01:21:22 -0700
X-CSE-ConnectionGUID: msaqeHm4T4qV+bsDrb0ObA==
X-CSE-MsgGUID: QYd4zOHqR+avXaoDxYG3vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; 
   d="scan'208";a="154007073"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 01:21:22 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 01:21:21 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 17 Jun 2025 01:21:21 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.69)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 01:21:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cYaa7zKKad0tsCk0Yh6fUGHGv2XVVran/9UEtl/YJSizMzCATT/Ou26RG/Lwcc3nDxwuLcP14cwKobJcl6wAzLDw+U3+WPSNK/Nk4EHjKFX9x7vBRHffWqEIpObFr2bjU+10Ucyo6ApvIsqkOaFBFNKmNVH9twAQOyg672vSUXbh4SVNxLIlzkVtS1aujNaNZWr53t500efqoC12lws5V/YlgKBWQLZ7rXrpxMRGwm5lsWGni3EgGh6fjbiQTDliu8aDYQjY6IY7xAa0XlDZERQo8/s3+07dfORds5MqtKHrLZZDktpj/kUP5fIn5V6xYKHBdf7L72k7aTnupnYd4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTHAI0eFd1PhKyYvUnUDN2LkkRjXVCmVoO0Pb6O3R2E=;
 b=c/KF8LtMBsTHvoyPHlDK7LgZzB2oRejaqgXyDK21kuT4mowkNku7HhLdWZMVjMyJgkUNFtmBxvsYhlYPcVsGf7qVhZD1dyXsqDm1jcDGKlviff+BCoZ9UPYSgDHWUlTdFdzleUI9kYmv5mh23xIGBUdibO3Zx7OK/1YfF8WipFGc2Ff6bOaS0qsU5MDLjbEydcevffb1LL6dQ9B/iYCjTYdqisqFnqJFfzlIrlffMOlFDWJ0z9uIX03lPX2RZjsJfhXgMm2jUN+9KFgqhZw2sYhh0/ln1/XTnuJaYmzwPgW/DT7miqd3RdWukinEgNG8MiFmwl+hz8S0qj42vWjjcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 08:21:03 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8792.034; Tue, 17 Jun 2025
 08:21:03 +0000
Date: Tue, 17 Jun 2025 16:20:47 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Ian Rogers <irogers@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter
	<adrian.hunter@intel.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, "Anne
 Macedo" <retpolanne@posteo.net>, Dmitriy Vyukov <dvyukov@google.com>, "Dr.
 David Alan Gilbert" <linux@treblig.org>, Howard Chu <howardchu95@gmail.com>,
	Ingo Molnar <mingo@redhat.com>, James Clark <james.clark@linaro.org>, "Jiri
 Olsa" <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, Mark Rutland
	<mark.rutland@arm.com>, Michael Petlan <mpetlan@redhat.com>, Namhyung Kim
	<namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Yicong Yang
	<yangyicong@hisilicon.com>, <linux-perf-users@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [perf machine]  4c04654455:
 kmsg.sanitizer.indirect_leak/__interceptor_malloc/__machine__new_host/machine__new_host/do_test_code_reading/test__code_reading/run_test_child
Message-ID: <202506171537.d7e7e621-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: KL1PR01CA0112.apcprd01.prod.exchangelabs.com
 (2603:1096:820:3::28) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH0PR11MB5013:EE_
X-MS-Office365-Filtering-Correlation-Id: 7710cab6-d3dd-42b9-ff51-08ddad77e59b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q3WT6fWDXixnRusAJAvlLRo83RO4ZnLmhVY3mTuV3W2cEU42UH8SOVkGtax1?=
 =?us-ascii?Q?tecoTW9uLHrzFan+tZJoHEeMNogh6lL7RcH05j/UAfMgPt1KzQS2oJs0y83w?=
 =?us-ascii?Q?Joeoa3redQgAQjRxVUH7iWK5zXHBEWU3tdM4FznIPhIT7tkGF+dptn6IX5sp?=
 =?us-ascii?Q?Lk8zHBtfoqBrdMDYTdDvjCpZ9ixRAGh/UtuYvcfne4E31fs/CDm3fhOQOg1a?=
 =?us-ascii?Q?3nUA6GmhvnaGbKi+7WHHOGszePKijGgoHkTg4ZYK29ChMKAxFtvonF3z7vMP?=
 =?us-ascii?Q?A0sWfTMG9RiioX/QxBSYbx1yx+mBEvawRVRb8n60IgTS8XEIb3rBI85eMuhf?=
 =?us-ascii?Q?aG/Y78P/hWL9svVSwSWodpWt8rtr2vKVzeBw9X/RJNiSDdQ7YZvBPsUQOjFI?=
 =?us-ascii?Q?Aluq01NouuAa+9SH5G2RN3roJ6EnArnsSJvnsorYuN4b8RbBBhGtseGzpjdB?=
 =?us-ascii?Q?jYCq+6NRXyBUPNOGsX0lC3uYbTirvLNKS0F+fhTUwG9Hf8zDSYJvGTpZN4Ys?=
 =?us-ascii?Q?TMILMYnn3Pvx+4LImcWmrw63euXJqvy6AbJOUTGMGhQyD4nGAtQziDVMilG0?=
 =?us-ascii?Q?7IfML7SZc2Rsu4I5dLp5/2X6dy2ooLyAgzvVSYa+NlazlT+Nv0cbOhSPRRk0?=
 =?us-ascii?Q?Y+t7xUthtsrpPVPSPBEbfIGnoQjuAD2pJRBH8PpRK7Dow1S3UTJH/5/00BxH?=
 =?us-ascii?Q?epOyeH+WdJWAos/mmnAfI+AATu9rzxFGa3+sVAxeC/POkdnJNi847YJQWUu/?=
 =?us-ascii?Q?kh1p8gVvXnoq+MLSfRnqynn+IsvN1o/ZB/YzWYTmcjlfd4Z2lVYZu5D0vjSJ?=
 =?us-ascii?Q?x0Z9mOm1fUlIG2Ail8kfgmJc+HkQ3e5iPxUQYh7ZFPZd7k0J1UANyJnMtfYN?=
 =?us-ascii?Q?YOeAu+HIHAPK5HvHnnLpWRr08Lx3zybIF1FfKFAqOk1J5EDjSUKVFd5GbQCI?=
 =?us-ascii?Q?wMzONQ4Vu7VxsF2kMFX1mze3uoc937/jwuLq99f1L/3FiCXCW1oRvbqEjdl2?=
 =?us-ascii?Q?QUeovKAGzbTeYa+0GtdWJWRalGEpl7emuhqppGmplZYnbDnxnJlZe54PK9+0?=
 =?us-ascii?Q?rtJBV9rOW7AXgLOn4hoigf7v1pMzTe/+IA0ttpy8eWWHLUCf5VP5N71GgGvS?=
 =?us-ascii?Q?WU5LtDJ2fp62XmAEiSH2/Yg5PGIXthTPNXAD147wk+rqYCvK2dG/aPLduPo7?=
 =?us-ascii?Q?QLOdrXfP31QfTJAdNJsjCnPuV0o52V2R4RtdfDEccDwdq0sGZIQjeQJ8125Y?=
 =?us-ascii?Q?SgJwyPvuqCht1au6O1Qqhx1DtftoScHZpKt1g5RltC5z/bN0aHvdQIC2tuF8?=
 =?us-ascii?Q?eJEmZHHd0b0cpYyD5hV09mzgq5Kt5LtkvaFA1RC1y0xsV6B1BDeDLnPpk1mv?=
 =?us-ascii?Q?6xdQfN9R5ct0m0qkPF8m+LVhKLFK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tovhcWc3CkaP3TPImX9+t+JbDLNt1Lx/fkBC7jJ1uerjjGAOGYnfvk4HiqAb?=
 =?us-ascii?Q?7wX6Xzcn2Woq8TLIalzJrjaUMeWc9r1thrMDIseqDG0pBD/jhgvTjsRFuzuO?=
 =?us-ascii?Q?482NxVhqC84BFF98YDQGIKeth/OEx8QWLXYVp5dgOpT+jopesx6hmyXdfeMj?=
 =?us-ascii?Q?/0gQKpcauAKd2CFzlOs6/Q5aBhKZVq35NNGVUMNWtShYTE/yEK+yf/Kyi6Wh?=
 =?us-ascii?Q?pT7taIsLxwHhxKLAG1/tXgbQ3WGbiuHT3Cf42997EgMyUxSmfeNxYRKWh6Uv?=
 =?us-ascii?Q?8b7iScSkENWJwHG9AzNTGm1MMs5po8s+Lf0HffdZ+n1S7aCWHC28YrgRPG+Y?=
 =?us-ascii?Q?QMWzeMzCEvZNXrUuQ8q6MzPvHFlwXpJgyQThgsyMCtSt4Uxr43O07TBbvU7W?=
 =?us-ascii?Q?MbKAyWlpRE8p+8FSwfZ3iVl8i3zAAK4JZ4Sd31quWmELkMRJ3ranKLeZvbh1?=
 =?us-ascii?Q?Z51+Y5qxx+fFZBNkYjvHOASKanxMc2iKFmNpUJpmE3HF3/J+OHm3gGSo4pSf?=
 =?us-ascii?Q?93aOynf5Gllwm1hUKgWaVYQ5HkdDgWWLtKs/kgEdSkRn9GUQbrCe8+gdFrmf?=
 =?us-ascii?Q?4BcbpKjDFvvvjxXWLXjYFh0a/K1ePQw8CtsNhKkOUa9pC4bud2rBFblKNG5i?=
 =?us-ascii?Q?LO8/jNDtiUqv0XAQPicz9pOQDBKrgxduovXdldaiysGMzZ+CLBnoB2pFDzHk?=
 =?us-ascii?Q?3ryJynkFjWnMOquZ+8w25bBo3lMp+7/hykqBs/MY0W4IJ/mcd3/ovWGrA1sw?=
 =?us-ascii?Q?rTHcRks/kLR7wBalT81Rg1yLtCM+1W9nRpBv0s4Nrkb0023GzStVrih0DGml?=
 =?us-ascii?Q?zphJpGPuDzFsT22kDwQsG2mYuzm7sXVTJpGQp0EusnmZhCBRDzNYPNsFGQ/h?=
 =?us-ascii?Q?9Mi3X5SZntZ6ZAlYhz3kcV2AXyRMqRE8MqdS5P4sY2xuVEgy5xElHB3jP6xY?=
 =?us-ascii?Q?hcL02suYeISpKFkYDart1b/kdEuU6++I/QiI72GNVLSHt4oUdPnvedk4jQxY?=
 =?us-ascii?Q?r0Ypiw+xwjIMffFXGl+HOPQukEHZljXtSrQuG4bdOP0v6yUE5XButS6WtZ9X?=
 =?us-ascii?Q?V10srNREm0DdDX1GXlNkLcpLNIScLf3CLg3Vl0ZGdqvJNYBMiH0fjvgDTfsa?=
 =?us-ascii?Q?S88zwjDvG1DINs/GapOMvHOf6YjdB8gCFI3RpShBdBDkOkHKn3n+qyBNlF6E?=
 =?us-ascii?Q?f5MqP+EOC+N+NO5gku8rSQ9ZeXQ57NkO2MkCQf5qwDbVKU3d/uu98NsKruP7?=
 =?us-ascii?Q?htvUzXnjD0uXmnFuJPQOgnGfxKiKR2hDlreRwW9MyQ7EUP/zYgI/ySgiJ2qk?=
 =?us-ascii?Q?udc66jmCi9xUi5QOzrN7SDcfiw1nizcYF+XVgYm3MQH0DCptzmesfsdhMtNL?=
 =?us-ascii?Q?ky1updIMbPt0BI/Uv66uV8L+W8c8LLlIMtR7r3OmBwGf4tF++UOa6SEmlkcm?=
 =?us-ascii?Q?GyhQKEw7wPsSSjMzgl5A6+5lKug/H16lIUIqqcEEX73S2EaVP0IoyuMgDUJO?=
 =?us-ascii?Q?ovhv3VkqxkN3ORSgEMzVZT9A19aBOzA8YdWZToYTd/XhFE0xECRNCDov4GB7?=
 =?us-ascii?Q?e30PT6GWLrdOXSN+rY+GnWn7r2cq+5idaTDJDl/SNXWNwBqEYLwmbRPhaceR?=
 =?us-ascii?Q?Jw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7710cab6-d3dd-42b9-ff51-08ddad77e59b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 08:21:02.9816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tuwmzZXY32Gkdd+RL2aEivQQPB8liRRBT1vSD1+SVHQZfSSaxj/BTpB95P9x4zK70H210amb1Z9909Bw4Fcj/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5013
X-OriginatorOrg: intel.com



Hello,


as we understand, commit 4c04654455 is not the root cause of below issues,
but changes the issue stats.

0e71bcdcf1f0b10b 4c04654455c09b4905b84c350d8
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :6          100%           6:6     kmsg.sanitizer.indirect_leak/__interceptor_calloc/zalloc/maps__new/machine__init/__machine__new_host/machine__new_host
          6:6         -100%            :6     kmsg.sanitizer.indirect_leak/__interceptor_calloc/zalloc/maps__new/machine__init/machine__new_host/do_test_code_reading
           :6          100%           6:6     kmsg.sanitizer.indirect_leak/__interceptor_malloc/__machine__new_host/machine__new_host/do_test_code_reading/test__code_reading/run_test_child
          6:6         -100%            :6     kmsg.sanitizer.indirect_leak/__interceptor_malloc/machine__new_host/do_test_code_reading/test__code_reading/run_test_child/start_command
           :6          100%           6:6     kmsg.sanitizer.indirect_leak/__interceptor_strdup/machine__set_mmap_name/machine__init/__machine__new_host/machine__new_host/do_test_code_reading
          6:6         -100%            :6     kmsg.sanitizer.indirect_leak/__interceptor_strdup/machine__set_mmap_name/machine__init/machine__new_host/do_test_code_reading/test__code_reading


but we cannot bisect to the real first bad commit. we just make out this report
FYI what we observed in our tests.

below is full report.


kernel test robot noticed "kmsg.sanitizer.indirect_leak/__interceptor_malloc/__machine__new_host/machine__new_host/do_test_code_reading/test__code_reading/run_test_child" on:

commit: 4c04654455c09b4905b84c350d88f718260a4cd4 ("perf machine: Factor creating a "live" machine out of dwarf-unwind")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      27605c8c0f69e319df156b471974e4e223035378]
[test failed on linux-next/master bc6e0ba6c9bafa6241b05524b9829808056ac4ad]

in testcase: perf-sanity-tests
version: 
with following parameters:

	perf_compiler: clang
	group: group-00



config: x86_64-rhel-9.4-bpf
compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz (Kaby Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202506171537.d7e7e621-lkp@intel.com

gcc march setting is skylake
valid
make PERF passed
2025-06-12 19:29:01 cd /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf
2025-06-12 19:29:01 mkdir -p /pkg
2025-06-12 19:29:01 mkdir -p /kbuild/obj/consumer/x86_64-rhel-9.4-bpf
2025-06-12 19:29:02 cp /pkg/linux/x86_64-rhel-9.4-bpf/gcc-12/4c04654455c09b4905b84c350d88f718260a4cd4/vmlinux.xz /tmp
2025-06-12 19:29:05 unxz -k /tmp/vmlinux.xz
2025-06-12 19:29:14 cp /tmp/vmlinux /kbuild/obj/consumer/x86_64-rhel-9.4-bpf
2025-06-12 19:29:16 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 1 -v
  1: vmlinux symtab matches kallsyms                                 : Running (1 active)
  1: vmlinux symtab matches kallsyms                                 : Ok
2025-06-12 19:29:23 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 2 -v
  2: Detect openat syscall event                                     : Running (1 active)
  2: Detect openat syscall event                                     : Ok
2025-06-12 19:29:24 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 3 -v
  3: Detect openat syscall event on all cpus                         : Running (1 active)
  3: Detect openat syscall event on all cpus                         : Ok
2025-06-12 19:29:25 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 4 -v
  4: mmap interface tests                                            :
  4.1: Read samples using the mmap interface                         : Running (3 active)
  4.1: Read samples using the mmap interface                         : Ok
  4.2: User space counter reading of instructions                    : Ok
  4.3: User space counter reading of cycles                          : Ok
2025-06-12 19:29:25 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 5 -v
  5: Test data source output                                         : Running (1 active)
  5: Test data source output                                         : Ok
2025-06-12 19:29:26 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 6 -v
  6: Parse event definition strings                                  :
  6.1: Test event parsing                                            : Running (6 active)
  6.1: Test event parsing                                            : Ok
  6.2: Parsing of all PMU events from sysfs                          : Ok
  6.3: Parsing of given PMU events from sysfs                        : Ok
  6.4: Parsing of aliased events from sysfs                          : Skip (no aliases in sysfs)
  6.5: Parsing of aliased events                                     : Ok
  6.6: Parsing of terms (event modifiers)                            : Ok
2025-06-12 19:29:27 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 7 -v
  7: Simple expression parser                                        : Running (1 active)
  7: Simple expression parser                                        : Ok
2025-06-12 19:29:27 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 8 -v
  8: PERF_RECORD_* events & perf_sample fields                       : Running (1 active)
  8: PERF_RECORD_* events & perf_sample fields                       : Ok
2025-06-12 19:29:30 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 9 -v
  9: Sysfs PMU tests                                                 :
  9.1: Parsing with PMU format directory                             : Running (6 active)
  9.1: Parsing with PMU format directory                             : Ok
  9.2: Parsing with PMU event                                        : Ok
  9.3: PMU event names                                               : Ok
  9.4: PMU name combining                                            : Ok
  9.5: PMU name comparison                                           : Ok
  9.6: PMU cmdline match                                             : Ok
2025-06-12 19:29:30 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 10 -v
 10: PMU JSON event tests                                            :
 10.1: PMU event table sanity                                        : Running (5 active)
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
 10.5: Parsing of metric thresholds with fake PMUs                   : Ok
2025-06-12 19:29:49 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 11 -v
 11: Hwmon PMU                                                       :
 11.1: Basic parsing test                                            : Running (3 active)
 11.1: Basic parsing test                                            : Ok
 11.2: Parsing without PMU name                                      : Ok
 11.3: Parsing with PMU name                                         : Ok
2025-06-12 19:29:50 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 12 -v
 12: Tool PMU                                                        :
 12.1: Parsing without PMU name                                      : Running (2 active)
 12.1: Parsing without PMU name                                      : Ok
 12.2: Parsing with PMU name                                         : Ok
2025-06-12 19:29:50 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 13 -v
 13: DSO data tests                                                  :
 13.1: read                                                          : Running (3 active)
 13.1: read                                                          : Ok
 13.2: cache                                                         : Ok
 13.3: reopen                                                        : Ok
2025-06-12 19:29:51 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 14 -v
 14: Roundtrip evsel->name                                           : Running (1 active)
 14: Roundtrip evsel->name                                           : Ok
2025-06-12 19:29:51 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 15 -v
 15: Parse sched tracepoints fields                                  : Running (1 active)
 15: Parse sched tracepoints fields                                  : Ok
2025-06-12 19:29:52 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 16 -v
 16: syscalls:sys_enter_openat event fields                          : Running (1 active)
 16: syscalls:sys_enter_openat event fields                          : Ok
2025-06-12 19:29:53 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 17 -v
 17: Match and link multiple hists                                   : Running (1 active)
 17: Match and link multiple hists                                   : Ok
2025-06-12 19:29:53 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 18 -v
 18: 'import perf' in python                                         : Running (1 active)
--- start ---
test child forked, pid 7611
python usage test: "echo "import sys ; sys.path.insert(0, 'python'); import perf" | '/usr/bin/python3' "
==7614==ASan runtime does not come first in initial library list; you should either link runtime to your application or manually preload it with LD_PRELOAD.
---- end(-1) ----
 18: 'import perf' in python                                         : FAILED!
2025-06-12 19:29:54 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 19 -v
 19: Breakpoint overflow signal handler                              : Running (1 active)
 19: Breakpoint overflow signal handler                              : Ok
2025-06-12 19:29:54 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 20 -v
 20: Breakpoint overflow sampling                                    : Running (1 active)
 20: Breakpoint overflow sampling                                    : Ok
2025-06-12 19:29:55 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 21 -v
 21: Breakpoint accounting                                           : Running (1 active)
 21: Breakpoint accounting                                           : Ok
2025-06-12 19:29:55 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 22 -v
 22: Watchpoint                                                      :
 22.1: Read Only Watchpoint                                          : Running (4 active)
 22.1: Read Only Watchpoint                                          : Skip (missing hardware support)
 22.2: Write Only Watchpoint                                         : Ok
 22.3: Read / Write Watchpoint                                       : Ok
 22.4: Modify Watchpoint                                             : Ok
2025-06-12 19:29:56 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 23 -v
 23: Software clock events period values                             : Running (1 active)
 23: Software clock events period values                             : Ok
2025-06-12 19:29:56 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 24 -v
 24: Object code reading                                             : Running (1 active)
--- start ---
test child forked, pid 7665
Looking at the vmlinux_path (8 entries long)
Using /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux for symbols
Parsing event 'cycles'
Using CPUID GenuineIntel-6-9E-9
mmap size 528384B
Reading object code for memory address: 0xffffffff81446cf9
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x646cf9
Objdump command is: objdump -z -d --start-address=0xffffffff81446cf9 --stop-address=0xffffffff81446d79 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff812e0cbf
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x4e0cbf
Objdump command is: objdump -z -d --start-address=0xffffffff812e0cbf --stop-address=0xffffffff812e0d3f /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81960bd5
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xb60bd5
Objdump command is: objdump -z -d --start-address=0xffffffff81960bd5 --stop-address=0xffffffff81960c55 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff812e0c50
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x4e0c50
Objdump command is: objdump -z -d --start-address=0xffffffff812e0c50 --stop-address=0xffffffff812e0cd0 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff8144720b
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x64720b
Objdump command is: objdump -z -d --start-address=0xffffffff8144720b --stop-address=0xffffffff8144728b /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff8188104f
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xa8104f
Objdump command is: objdump -z -d --start-address=0xffffffff8188104f --stop-address=0xffffffff818810cf /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81f29366
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x1129366
Objdump command is: objdump -z -d --start-address=0xffffffff81f29366 --stop-address=0xffffffff81f293e6 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc6ac
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc6ac
Objdump command is: objdump -z -d --start-address=0xffffffff818dc6ac --stop-address=0xffffffff818dc72c /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff8157e233
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x77e233
Objdump command is: objdump -z -d --start-address=0xffffffff8157e233 --stop-address=0xffffffff8157e2b3 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81445e8d
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x645e8d
Objdump command is: objdump -z -d --start-address=0xffffffff81445e8d --stop-address=0xffffffff81445f0d /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff82c73700
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x1e73700
Objdump command is: objdump -z -d --start-address=0xffffffff82c73700 --stop-address=0xffffffff82c73780 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff8195e450
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xb5e450
Objdump command is: objdump -z -d --start-address=0xffffffff8195e450 --stop-address=0xffffffff8195e4d0 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc691
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc691
Objdump command is: objdump -z -d --start-address=0xffffffff818dc691 --stop-address=0xffffffff818dc711 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc660
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc660
Objdump command is: objdump -z -d --start-address=0xffffffff818dc660 --stop-address=0xffffffff818dc6e0 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff8144466b
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x64466b
Objdump command is: objdump -z -d --start-address=0xffffffff8144466b --stop-address=0xffffffff814446eb /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc6ac
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc6ac
Objdump command is: objdump -z -d --start-address=0xffffffff818dc6ac --stop-address=0xffffffff818dc72c /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff8144720b
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x64720b
Objdump command is: objdump -z -d --start-address=0xffffffff8144720b --stop-address=0xffffffff8144728b /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff816508db
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x8508db
Objdump command is: objdump -z -d --start-address=0xffffffff816508db --stop-address=0xffffffff8165095b /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc874
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc874
Objdump command is: objdump -z -d --start-address=0xffffffff818dc874 --stop-address=0xffffffff818dc8f4 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dcd24
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadcd24
Objdump command is: objdump -z -d --start-address=0xffffffff818dcd24 --stop-address=0xffffffff818dcda4 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc7ea
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc7ea
Objdump command is: objdump -z -d --start-address=0xffffffff818dc7ea --stop-address=0xffffffff818dc86a /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff812e0cdf
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x4e0cdf
Objdump command is: objdump -z -d --start-address=0xffffffff812e0cdf --stop-address=0xffffffff812e0d5f /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81883fd3
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xa83fd3
Objdump command is: objdump -z -d --start-address=0xffffffff81883fd3 --stop-address=0xffffffff81884053 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dcb71
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadcb71
Objdump command is: objdump -z -d --start-address=0xffffffff818dcb71 --stop-address=0xffffffff818dcbf1 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81446cf9
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x646cf9
Objdump command is: objdump -z -d --start-address=0xffffffff81446cf9 --stop-address=0xffffffff81446d79 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc8bc
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc8bc
Objdump command is: objdump -z -d --start-address=0xffffffff818dc8bc --stop-address=0xffffffff818dc93c /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81493c38
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x693c38
Objdump command is: objdump -z -d --start-address=0xffffffff81493c38 --stop-address=0xffffffff81493cb8 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff82c73520
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x1e73520
Objdump command is: objdump -z -d --start-address=0xffffffff82c73520 --stop-address=0xffffffff82c735a0 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dcb81
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadcb81
Objdump command is: objdump -z -d --start-address=0xffffffff818dcb81 --stop-address=0xffffffff818dcc01 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff814d3549
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x6d3549
Objdump command is: objdump -z -d --start-address=0xffffffff814d3549 --stop-address=0xffffffff814d35c9 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81446ba5
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x646ba5
Objdump command is: objdump -z -d --start-address=0xffffffff81446ba5 --stop-address=0xffffffff81446c25 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc483
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc483
Objdump command is: objdump -z -d --start-address=0xffffffff818dc483 --stop-address=0xffffffff818dc503 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc870
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc870
Objdump command is: objdump -z -d --start-address=0xffffffff818dc870 --stop-address=0xffffffff818dc8f0 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81445e49
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x645e49
Objdump command is: objdump -z -d --start-address=0xffffffff81445e49 --stop-address=0xffffffff81445ec9 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc7c4
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc7c4
Objdump command is: objdump -z -d --start-address=0xffffffff818dc7c4 --stop-address=0xffffffff818dc844 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc7c0
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc7c0
Objdump command is: objdump -z -d --start-address=0xffffffff818dc7c0 --stop-address=0xffffffff818dc840 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81446cfd
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x646cfd
Objdump command is: objdump -z -d --start-address=0xffffffff81446cfd --stop-address=0xffffffff81446d7d /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc6ac
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc6ac
Objdump command is: objdump -z -d --start-address=0xffffffff818dc6ac --stop-address=0xffffffff818dc72c /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc7c0
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc7c0
Objdump command is: objdump -z -d --start-address=0xffffffff818dc7c0 --stop-address=0xffffffff818dc840 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff812e0ce7
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x4e0ce7
Objdump command is: objdump -z -d --start-address=0xffffffff812e0ce7 --stop-address=0xffffffff812e0d67 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818da9c0
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xada9c0
Objdump command is: objdump -z -d --start-address=0xffffffff818da9c0 --stop-address=0xffffffff818daa40 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff8149422d
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x69422d
Objdump command is: objdump -z -d --start-address=0xffffffff8149422d --stop-address=0xffffffff814942ad /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff814d3480
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x6d3480
Objdump command is: objdump -z -d --start-address=0xffffffff814d3480 --stop-address=0xffffffff814d3500 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc7c4
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc7c4
Objdump command is: objdump -z -d --start-address=0xffffffff818dc7c4 --stop-address=0xffffffff818dc844 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff812e1984
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x4e1984
Objdump command is: objdump -z -d --start-address=0xffffffff812e1984 --stop-address=0xffffffff812e1a04 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff814dbd06
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x6dbd06
Objdump command is: objdump -z -d --start-address=0xffffffff814dbd06 --stop-address=0xffffffff814dbd86 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff812e15fd
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x4e15fd
Objdump command is: objdump -z -d --start-address=0xffffffff812e15fd --stop-address=0xffffffff812e167d /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff82c73700
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x1e73700
Objdump command is: objdump -z -d --start-address=0xffffffff82c73700 --stop-address=0xffffffff82c73780 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff812e0f11
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x4e0f11
Objdump command is: objdump -z -d --start-address=0xffffffff812e0f11 --stop-address=0xffffffff812e0f91 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81446cd0
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x646cd0
Objdump command is: objdump -z -d --start-address=0xffffffff81446cd0 --stop-address=0xffffffff81446d50 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff819a1dff
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xba1dff
Objdump command is: objdump -z -d --start-address=0xffffffff819a1dff --stop-address=0xffffffff819a1e7f /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81493c5f
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x693c5f
Objdump command is: objdump -z -d --start-address=0xffffffff81493c5f --stop-address=0xffffffff81493cdf /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc870
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc870
Objdump command is: objdump -z -d --start-address=0xffffffff818dc870 --stop-address=0xffffffff818dc8f0 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc7fa
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc7fa
Objdump command is: objdump -z -d --start-address=0xffffffff818dc7fa --stop-address=0xffffffff818dc87a /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff8199fec4
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xb9fec4
Objdump command is: objdump -z -d --start-address=0xffffffff8199fec4 --stop-address=0xffffffff8199ff44 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc80c
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc80c
Objdump command is: objdump -z -d --start-address=0xffffffff818dc80c --stop-address=0xffffffff818dc88c /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81446bb8
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x646bb8
Objdump command is: objdump -z -d --start-address=0xffffffff81446bb8 --stop-address=0xffffffff81446c38 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff812e0ceb
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x4e0ceb
Objdump command is: objdump -z -d --start-address=0xffffffff812e0ceb --stop-address=0xffffffff812e0d6b /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff812e150e
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x4e150e
Objdump command is: objdump -z -d --start-address=0xffffffff812e150e --stop-address=0xffffffff812e158e /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81446d0a
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x646d0a
Objdump command is: objdump -z -d --start-address=0xffffffff81446d0a --stop-address=0xffffffff81446d8a /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc89a
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc89a
Objdump command is: objdump -z -d --start-address=0xffffffff818dc89a --stop-address=0xffffffff818dc91a /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81445a4e
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x645a4e
Objdump command is: objdump -z -d --start-address=0xffffffff81445a4e --stop-address=0xffffffff81445ace /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81494241
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x694241
Objdump command is: objdump -z -d --start-address=0xffffffff81494241 --stop-address=0xffffffff814942c1 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff812e150e
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x4e150e
Objdump command is: objdump -z -d --start-address=0xffffffff812e150e --stop-address=0xffffffff812e158e /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81446cd0
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x646cd0
Objdump command is: objdump -z -d --start-address=0xffffffff81446cd0 --stop-address=0xffffffff81446d50 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff8144720b
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x64720b
Objdump command is: objdump -z -d --start-address=0xffffffff8144720b --stop-address=0xffffffff8144728b /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff812f116a
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x4f116a
Objdump command is: objdump -z -d --start-address=0xffffffff812f116a --stop-address=0xffffffff812f11ea /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dcc70
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadcc70
Objdump command is: objdump -z -d --start-address=0xffffffff818dcc70 --stop-address=0xffffffff818dccf0 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff82c68bc7
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x1e68bc7
Objdump command is: objdump -z -d --start-address=0xffffffff82c68bc7 --stop-address=0xffffffff82c68c47 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc7c0
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc7c0
Objdump command is: objdump -z -d --start-address=0xffffffff818dc7c0 --stop-address=0xffffffff818dc840 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc69a
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc69a
Objdump command is: objdump -z -d --start-address=0xffffffff818dc69a --stop-address=0xffffffff818dc71a /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc7fa
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc7fa
Objdump command is: objdump -z -d --start-address=0xffffffff818dc7fa --stop-address=0xffffffff818dc87a /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81493c55
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x693c55
Objdump command is: objdump -z -d --start-address=0xffffffff81493c55 --stop-address=0xffffffff81493cd5 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff812e16e9
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x4e16e9
Objdump command is: objdump -z -d --start-address=0xffffffff812e16e9 --stop-address=0xffffffff812e1769 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81445562
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x645562
Objdump command is: objdump -z -d --start-address=0xffffffff81445562 --stop-address=0xffffffff814455e2 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc8bc
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc8bc
Objdump command is: objdump -z -d --start-address=0xffffffff818dc8bc --stop-address=0xffffffff818dc93c /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff814a5c7a
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x6a5c7a
Objdump command is: objdump -z -d --start-address=0xffffffff814a5c7a --stop-address=0xffffffff814a5cfa /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81445555
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x645555
Objdump command is: objdump -z -d --start-address=0xffffffff81445555 --stop-address=0xffffffff814455d5 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff812e159b
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x4e159b
Objdump command is: objdump -z -d --start-address=0xffffffff812e159b --stop-address=0xffffffff812e161b /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc664
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc664
Objdump command is: objdump -z -d --start-address=0xffffffff818dc664 --stop-address=0xffffffff818dc6e4 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81445502
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x645502
Objdump command is: objdump -z -d --start-address=0xffffffff81445502 --stop-address=0xffffffff81445582 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc7c0
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc7c0
Objdump command is: objdump -z -d --start-address=0xffffffff818dc7c0 --stop-address=0xffffffff818dc840 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff82c736a7
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x1e736a7
Objdump command is: objdump -z -d --start-address=0xffffffff82c736a7 --stop-address=0xffffffff82c73727 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc874
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc874
Objdump command is: objdump -z -d --start-address=0xffffffff818dc874 --stop-address=0xffffffff818dc8f4 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81493c38
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x693c38
Objdump command is: objdump -z -d --start-address=0xffffffff81493c38 --stop-address=0xffffffff81493cb8 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81445dd5
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x645dd5
Objdump command is: objdump -z -d --start-address=0xffffffff81445dd5 --stop-address=0xffffffff81445e55 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc74a
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc74a
Objdump command is: objdump -z -d --start-address=0xffffffff818dc74a --stop-address=0xffffffff818dc7ca /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81447147
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x647147
Objdump command is: objdump -z -d --start-address=0xffffffff81447147 --stop-address=0xffffffff814471c7 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc75c
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc75c
Objdump command is: objdump -z -d --start-address=0xffffffff818dc75c --stop-address=0xffffffff818dc7dc /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dcb81
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadcb81
Objdump command is: objdump -z -d --start-address=0xffffffff818dcb81 --stop-address=0xffffffff818dcc01 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff8144722a
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x64722a
Objdump command is: objdump -z -d --start-address=0xffffffff8144722a --stop-address=0xffffffff814472aa /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff812e1984
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x4e1984
Objdump command is: objdump -z -d --start-address=0xffffffff812e1984 --stop-address=0xffffffff812e1a04 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81447141
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x647141
Objdump command is: objdump -z -d --start-address=0xffffffff81447141 --stop-address=0xffffffff814471c1 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc7c4
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc7c4
Objdump command is: objdump -z -d --start-address=0xffffffff818dc7c4 --stop-address=0xffffffff818dc844 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81494238
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x694238
Objdump command is: objdump -z -d --start-address=0xffffffff81494238 --stop-address=0xffffffff814942b8 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81446d07
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x646d07
Objdump command is: objdump -z -d --start-address=0xffffffff81446d07 --stop-address=0xffffffff81446d87 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff82c74ec2
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x1e74ec2
Objdump command is: objdump -z -d --start-address=0xffffffff82c74ec2 --stop-address=0xffffffff82c74f42 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc89a
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc89a
Objdump command is: objdump -z -d --start-address=0xffffffff818dc89a --stop-address=0xffffffff818dc91a /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81911bb7
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xb11bb7
Objdump command is: objdump -z -d --start-address=0xffffffff81911bb7 --stop-address=0xffffffff81911c37 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc7c4
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc7c4
Objdump command is: objdump -z -d --start-address=0xffffffff818dc7c4 --stop-address=0xffffffff818dc844 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff812e2459
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x4e2459
Objdump command is: objdump -z -d --start-address=0xffffffff812e2459 --stop-address=0xffffffff812e24d9 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dcb1c
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadcb1c
Objdump command is: objdump -z -d --start-address=0xffffffff818dcb1c --stop-address=0xffffffff818dcb9c /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc6b0
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc6b0
Objdump command is: objdump -z -d --start-address=0xffffffff818dc6b0 --stop-address=0xffffffff818dc730 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff819d3370
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xbd3370
Objdump command is: objdump -z -d --start-address=0xffffffff819d3370 --stop-address=0xffffffff819d33f0 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff812e15a7
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x4e15a7
Objdump command is: objdump -z -d --start-address=0xffffffff812e15a7 --stop-address=0xffffffff812e1627 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff814466ab
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x6466ab
Objdump command is: objdump -z -d --start-address=0xffffffff814466ab --stop-address=0xffffffff8144672b /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff812e155a
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x4e155a
Objdump command is: objdump -z -d --start-address=0xffffffff812e155a --stop-address=0xffffffff812e15da /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc67b
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc67b
Objdump command is: objdump -z -d --start-address=0xffffffff818dc67b --stop-address=0xffffffff818dc6fb /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81445e8d
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x645e8d
Objdump command is: objdump -z -d --start-address=0xffffffff81445e8d --stop-address=0xffffffff81445f0d /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff812e0cd7
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x4e0cd7
Objdump command is: objdump -z -d --start-address=0xffffffff812e0cd7 --stop-address=0xffffffff812e0d57 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff813da5a2
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x5da5a2
Objdump command is: objdump -z -d --start-address=0xffffffff813da5a2 --stop-address=0xffffffff813da622 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81a13ee4
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xc13ee4
Objdump command is: objdump -z -d --start-address=0xffffffff81a13ee4 --stop-address=0xffffffff81a13f64 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc8bc
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc8bc
Objdump command is: objdump -z -d --start-address=0xffffffff818dc8bc --stop-address=0xffffffff818dc93c /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81446d29
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x646d29
Objdump command is: objdump -z -d --start-address=0xffffffff81446d29 --stop-address=0xffffffff81446da9 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81446041
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x646041
Objdump command is: objdump -z -d --start-address=0xffffffff81446041 --stop-address=0xffffffff814460c1 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff814a1c10
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x6a1c10
Objdump command is: objdump -z -d --start-address=0xffffffff814a1c10 --stop-address=0xffffffff814a1c90 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81991421
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xb91421
Objdump command is: objdump -z -d --start-address=0xffffffff81991421 --stop-address=0xffffffff819914a1 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff82c73343
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x1e73343
Objdump command is: objdump -z -d --start-address=0xffffffff82c73343 --stop-address=0xffffffff82c733c3 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81446ba5
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x646ba5
Objdump command is: objdump -z -d --start-address=0xffffffff81446ba5 --stop-address=0xffffffff81446c25 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81446beb
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x646beb
Objdump command is: objdump -z -d --start-address=0xffffffff81446beb --stop-address=0xffffffff81446c6b /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff812e0cdf
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x4e0cdf
Objdump command is: objdump -z -d --start-address=0xffffffff812e0cdf --stop-address=0xffffffff812e0d5f /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff812e1a1c
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x4e1a1c
Objdump command is: objdump -z -d --start-address=0xffffffff812e1a1c --stop-address=0xffffffff812e1a9c /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dcb26
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadcb26
Objdump command is: objdump -z -d --start-address=0xffffffff818dcb26 --stop-address=0xffffffff818dcba6 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc7c4
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc7c4
Objdump command is: objdump -z -d --start-address=0xffffffff818dc7c4 --stop-address=0xffffffff818dc844 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff814471ea
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x6471ea
Objdump command is: objdump -z -d --start-address=0xffffffff814471ea --stop-address=0xffffffff8144726a /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff812e14c7
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x4e14c7
Objdump command is: objdump -z -d --start-address=0xffffffff812e14c7 --stop-address=0xffffffff812e1547 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff82c35666
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x1e35666
Objdump command is: objdump -z -d --start-address=0xffffffff82c35666 --stop-address=0xffffffff82c356e6 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0x7fb03bb9bbf2
File is: /lib/x86_64-linux-gnu/libc.so.6
On file address is: 0x3fbf2
Objdump command is: objdump -z -d --start-address=0x3fbf2 --stop-address=0x3fc72 /lib/x86_64-linux-gnu/libc.so.6
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dcb1e
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadcb1e
Objdump command is: objdump -z -d --start-address=0xffffffff818dcb1e --stop-address=0xffffffff818dcb9e /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818de39c
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xade39c
Objdump command is: objdump -z -d --start-address=0xffffffff818de39c --stop-address=0xffffffff818de41c /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0x55f073444dd6
File is: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf
On file address is: 0x1366dd6
Objdump command is: objdump -z -d --start-address=0x1366dd6 --stop-address=0x1366e56 /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf
Bytes read match those read by objdump
Reading object code for memory address: 0x55f073444d43
File is: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf
On file address is: 0x1366d43
Objdump command is: objdump -z -d --start-address=0x1366d43 --stop-address=0x1366dc3 /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf
Bytes read match those read by objdump
Reading object code for memory address: 0x55f073444daa
File is: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf
On file address is: 0x1366daa
Objdump command is: objdump -z -d --start-address=0x1366daa --stop-address=0x1366e2a /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf
Bytes read match those read by objdump
Reading object code for memory address: 0x55f073444da8
File is: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf
On file address is: 0x1366da8
Objdump command is: objdump -z -d --start-address=0x1366da8 --stop-address=0x1366e28 /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf
Bytes read match those read by objdump
Reading object code for memory address: 0x55f073445236
File is: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf
On file address is: 0x1367236
Objdump command is: objdump -z -d --start-address=0x1367236 --stop-address=0x13672b6 /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf
Bytes read match those read by objdump
Reading object code for memory address: 0x7fb03bb9bbcd
File is: /lib/x86_64-linux-gnu/libc.so.6
On file address is: 0x3fbcd
Objdump command is: objdump -z -d --start-address=0x3fbcd --stop-address=0x3fc4d /lib/x86_64-linux-gnu/libc.so.6
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff82c736a7
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x1e736a7
Objdump command is: objdump -z -d --start-address=0xffffffff82c736a7 --stop-address=0xffffffff82c73727 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0x55f073444db4
File is: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf
On file address is: 0x1366db4
Objdump command is: objdump -z -d --start-address=0x1366db4 --stop-address=0x1366e34 /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf
Bytes read match those read by objdump
Reading object code for memory address: 0x55f073444dbe
File is: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf
On file address is: 0x1366dbe
Objdump command is: objdump -z -d --start-address=0x1366dbe --stop-address=0x1366e3e /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf
Bytes read match those read by objdump
Reading object code for memory address: 0x55f073444db4
File is: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf
On file address is: 0x1366db4
Objdump command is: objdump -z -d --start-address=0x1366db4 --stop-address=0x1366e34 /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf
Bytes read match those read by objdump
Reading object code for memory address: 0x7fb03bb9bbc0
File is: /lib/x86_64-linux-gnu/libc.so.6
On file address is: 0x3fbc0
Objdump command is: objdump -z -d --start-address=0x3fbc0 --stop-address=0x3fc40 /lib/x86_64-linux-gnu/libc.so.6
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81445530
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x645530
Objdump command is: objdump -z -d --start-address=0xffffffff81445530 --stop-address=0xffffffff814455b0 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0x55f073444dd6
File is: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf
On file address is: 0x1366dd6
Objdump command is: objdump -z -d --start-address=0x1366dd6 --stop-address=0x1366e56 /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf
Bytes read match those read by objdump
Reading object code for memory address: 0x55f073444d39
File is: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf
On file address is: 0x1366d39
Objdump command is: objdump -z -d --start-address=0x1366d39 --stop-address=0x1366db9 /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf
Bytes read match those read by objdump
Reading object code for memory address: 0x7fb03bb9b9d9
File is: /lib/x86_64-linux-gnu/libc.so.6
On file address is: 0x3f9d9
Objdump command is: objdump -z -d --start-address=0x3f9d9 --stop-address=0x3fa59 /lib/x86_64-linux-gnu/libc.so.6
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc6ac
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc6ac
Objdump command is: objdump -z -d --start-address=0xffffffff818dc6ac --stop-address=0xffffffff818dc72c /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff8144618e
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x64618e
Objdump command is: objdump -z -d --start-address=0xffffffff8144618e --stop-address=0xffffffff8144620e /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc7ca
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc7ca
Objdump command is: objdump -z -d --start-address=0xffffffff818dc7ca --stop-address=0xffffffff818dc84a /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff82c7e000
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x1e7e000
Objdump command is: objdump -z -d --start-address=0xffffffff82c7e000 --stop-address=0xffffffff82c7e080 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff814461b0
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x6461b0
Objdump command is: objdump -z -d --start-address=0xffffffff814461b0 --stop-address=0xffffffff81446230 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff82c7372a
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x1e7372a
Objdump command is: objdump -z -d --start-address=0xffffffff82c7372a --stop-address=0xffffffff82c737aa /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc89a
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc89a
Objdump command is: objdump -z -d --start-address=0xffffffff818dc89a --stop-address=0xffffffff818dc91a /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81493c55
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x693c55
Objdump command is: objdump -z -d --start-address=0xffffffff81493c55 --stop-address=0xffffffff81493cd5 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81447210
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x647210
Objdump command is: objdump -z -d --start-address=0xffffffff81447210 --stop-address=0xffffffff81447290 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff8144725d
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x64725d
Objdump command is: objdump -z -d --start-address=0xffffffff8144725d --stop-address=0xffffffff814472dd /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81445558
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x645558
Objdump command is: objdump -z -d --start-address=0xffffffff81445558 --stop-address=0xffffffff814455d8 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff812e15a7
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x4e15a7
Objdump command is: objdump -z -d --start-address=0xffffffff812e15a7 --stop-address=0xffffffff812e1627 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc6ac
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc6ac
Objdump command is: objdump -z -d --start-address=0xffffffff818dc6ac --stop-address=0xffffffff818dc72c /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff8144725d
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x64725d
Objdump command is: objdump -z -d --start-address=0xffffffff8144725d --stop-address=0xffffffff814472dd /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc870
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc870
Objdump command is: objdump -z -d --start-address=0xffffffff818dc870 --stop-address=0xffffffff818dc8f0 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff812e1159
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x4e1159
Objdump command is: objdump -z -d --start-address=0xffffffff812e1159 --stop-address=0xffffffff812e11d9 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81445e8d
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x645e8d
Objdump command is: objdump -z -d --start-address=0xffffffff81445e8d --stop-address=0xffffffff81445f0d /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81446ce7
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x646ce7
Objdump command is: objdump -z -d --start-address=0xffffffff81446ce7 --stop-address=0xffffffff81446d67 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc7c4
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc7c4
Objdump command is: objdump -z -d --start-address=0xffffffff818dc7c4 --stop-address=0xffffffff818dc844 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc8aa
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc8aa
Objdump command is: objdump -z -d --start-address=0xffffffff818dc8aa --stop-address=0xffffffff818dc92a /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff814d34b7
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x6d34b7
Objdump command is: objdump -z -d --start-address=0xffffffff814d34b7 --stop-address=0xffffffff814d3537 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81595c32
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x795c32
Objdump command is: objdump -z -d --start-address=0xffffffff81595c32 --stop-address=0xffffffff81595cb2 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81446290
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x646290
Objdump command is: objdump -z -d --start-address=0xffffffff81446290 --stop-address=0xffffffff81446310 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff812e159b
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x4e159b
Objdump command is: objdump -z -d --start-address=0xffffffff812e159b --stop-address=0xffffffff812e161b /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81f2a9a1
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x112a9a1
Objdump command is: objdump -z -d --start-address=0xffffffff81f2a9a1 --stop-address=0xffffffff81f2aa21 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff812780cf
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x4780cf
Objdump command is: objdump -z -d --start-address=0xffffffff812780cf --stop-address=0xffffffff8127814f /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc7c4
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc7c4
Objdump command is: objdump -z -d --start-address=0xffffffff818dc7c4 --stop-address=0xffffffff818dc844 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81493c55
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x693c55
Objdump command is: objdump -z -d --start-address=0xffffffff81493c55 --stop-address=0xffffffff81493cd5 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff812e1411
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x4e1411
Objdump command is: objdump -z -d --start-address=0xffffffff812e1411 --stop-address=0xffffffff812e1491 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff812e1919
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x4e1919
Objdump command is: objdump -z -d --start-address=0xffffffff812e1919 --stop-address=0xffffffff812e1999 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff812e11a1
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x4e11a1
Objdump command is: objdump -z -d --start-address=0xffffffff812e11a1 --stop-address=0xffffffff812e1221 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81915be4
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xb15be4
Objdump command is: objdump -z -d --start-address=0xffffffff81915be4 --stop-address=0xffffffff81915c64 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc660
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc660
Objdump command is: objdump -z -d --start-address=0xffffffff818dc660 --stop-address=0xffffffff818dc6e0 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff812e1a41
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x4e1a41
Objdump command is: objdump -z -d --start-address=0xffffffff812e1a41 --stop-address=0xffffffff812e1ac1 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc664
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc664
Objdump command is: objdump -z -d --start-address=0xffffffff818dc664 --stop-address=0xffffffff818dc6e4 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff812e11b9
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x4e11b9
Objdump command is: objdump -z -d --start-address=0xffffffff812e11b9 --stop-address=0xffffffff812e1239 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff814a1c7b
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x6a1c7b
Objdump command is: objdump -z -d --start-address=0xffffffff814a1c7b --stop-address=0xffffffff814a1cfb /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81445d54
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x645d54
Objdump command is: objdump -z -d --start-address=0xffffffff81445d54 --stop-address=0xffffffff81445dd4 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc660
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc660
Objdump command is: objdump -z -d --start-address=0xffffffff818dc660 --stop-address=0xffffffff818dc6e0 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff812e1a41
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x4e1a41
Objdump command is: objdump -z -d --start-address=0xffffffff812e1a41 --stop-address=0xffffffff812e1ac1 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff812e199a
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x4e199a
Objdump command is: objdump -z -d --start-address=0xffffffff812e199a --stop-address=0xffffffff812e1a1a /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff82c73520
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x1e73520
Objdump command is: objdump -z -d --start-address=0xffffffff82c73520 --stop-address=0xffffffff82c735a0 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81493c5f
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x693c5f
Objdump command is: objdump -z -d --start-address=0xffffffff81493c5f --stop-address=0xffffffff81493cdf /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc68a
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc68a
Objdump command is: objdump -z -d --start-address=0xffffffff818dc68a --stop-address=0xffffffff818dc70a /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc810
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc810
Objdump command is: objdump -z -d --start-address=0xffffffff818dc810 --stop-address=0xffffffff818dc890 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0x7fb03d1b66f4
File is: /lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
On file address is: 0x236f4
Objdump command is: objdump -z -d --start-address=0x236f4 --stop-address=0x23774 /lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc660
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc660
Objdump command is: objdump -z -d --start-address=0xffffffff818dc660 --stop-address=0xffffffff818dc6e0 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc870
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc870
Objdump command is: objdump -z -d --start-address=0xffffffff818dc870 --stop-address=0xffffffff818dc8f0 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dcbca
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadcbca
Objdump command is: objdump -z -d --start-address=0xffffffff818dcbca --stop-address=0xffffffff818dcc4a /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff813ba55b
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x5ba55b
Objdump command is: objdump -z -d --start-address=0xffffffff813ba55b --stop-address=0xffffffff813ba5db /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81447141
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x647141
Objdump command is: objdump -z -d --start-address=0xffffffff81447141 --stop-address=0xffffffff814471c1 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc80c
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc80c
Objdump command is: objdump -z -d --start-address=0xffffffff818dc80c --stop-address=0xffffffff818dc88c /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dccd0
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadccd0
Objdump command is: objdump -z -d --start-address=0xffffffff818dccd0 --stop-address=0xffffffff818dcd50 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81446182
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x646182
Objdump command is: objdump -z -d --start-address=0xffffffff81446182 --stop-address=0xffffffff81446202 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc7c4
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc7c4
Objdump command is: objdump -z -d --start-address=0xffffffff818dc7c4 --stop-address=0xffffffff818dc844 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81493c30
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x693c30
Objdump command is: objdump -z -d --start-address=0xffffffff81493c30 --stop-address=0xffffffff81493cb0 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff8148fbd0
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x68fbd0
Objdump command is: objdump -z -d --start-address=0xffffffff8148fbd0 --stop-address=0xffffffff8148fc50 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81445e29
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x645e29
Objdump command is: objdump -z -d --start-address=0xffffffff81445e29 --stop-address=0xffffffff81445ea9 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff812e0cf0
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x4e0cf0
Objdump command is: objdump -z -d --start-address=0xffffffff812e0cf0 --stop-address=0xffffffff812e0d70 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc440
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc440
Objdump command is: objdump -z -d --start-address=0xffffffff818dc440 --stop-address=0xffffffff818dc4c0 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81445f08
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x645f08
Objdump command is: objdump -z -d --start-address=0xffffffff81445f08 --stop-address=0xffffffff81445f88 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff82c73599
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x1e73599
Objdump command is: objdump -z -d --start-address=0xffffffff82c73599 --stop-address=0xffffffff82c73619 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff810013e6
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x2013e6
Objdump command is: objdump -z -d --start-address=0xffffffff810013e6 --stop-address=0xffffffff81001466 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff82c73722
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x1e73722
Objdump command is: objdump -z -d --start-address=0xffffffff82c73722 --stop-address=0xffffffff82c737a2 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc73a
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc73a
Objdump command is: objdump -z -d --start-address=0xffffffff818dc73a --stop-address=0xffffffff818dc7ba /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff812e14c0
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x4e14c0
Objdump command is: objdump -z -d --start-address=0xffffffff812e14c0 --stop-address=0xffffffff812e1540 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc664
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc664
Objdump command is: objdump -z -d --start-address=0xffffffff818dc664 --stop-address=0xffffffff818dc6e4 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff812e0f43
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x4e0f43
Objdump command is: objdump -z -d --start-address=0xffffffff812e0f43 --stop-address=0xffffffff812e0fc3 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81493c5f
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x693c5f
Objdump command is: objdump -z -d --start-address=0xffffffff81493c5f --stop-address=0xffffffff81493cdf /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc6a4
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc6a4
Objdump command is: objdump -z -d --start-address=0xffffffff818dc6a4 --stop-address=0xffffffff818dc724 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff8144714d
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x64714d
Objdump command is: objdump -z -d --start-address=0xffffffff8144714d --stop-address=0xffffffff814471cd /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81446cdc
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x646cdc
Objdump command is: objdump -z -d --start-address=0xffffffff81446cdc --stop-address=0xffffffff81446d5c /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff812e1a4c
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x4e1a4c
Objdump command is: objdump -z -d --start-address=0xffffffff812e1a4c --stop-address=0xffffffff812e1acc /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81445517
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x645517
Objdump command is: objdump -z -d --start-address=0xffffffff81445517 --stop-address=0xffffffff81445597 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dcb6a
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadcb6a
Objdump command is: objdump -z -d --start-address=0xffffffff818dcb6a --stop-address=0xffffffff818dcbea /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81445500
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x645500
Objdump command is: objdump -z -d --start-address=0xffffffff81445500 --stop-address=0xffffffff81445580 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc7c0
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc7c0
Objdump command is: objdump -z -d --start-address=0xffffffff818dc7c0 --stop-address=0xffffffff818dc840 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818dc6a4
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0xadc6a4
Objdump command is: objdump -z -d --start-address=0xffffffff818dc6a4 --stop-address=0xffffffff818dc724 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81493c62
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x693c62
Objdump command is: objdump -z -d --start-address=0xffffffff81493c62 --stop-address=0xffffffff81493ce2 /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81445e3e
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x645e3e
Objdump command is: objdump -z -d --start-address=0xffffffff81445e3e --stop-address=0xffffffff81445ebe /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff813965ae
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x5965ae
Objdump command is: objdump -z -d --start-address=0xffffffff813965ae --stop-address=0xffffffff8139662e /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff812e0c8e
File is: /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
On file address is: 0x4e0c8e
Objdump command is: objdump -z -d --start-address=0xffffffff812e0c8e --stop-address=0xffffffff812e0d0e /lib/modules/6.15.0-rc7-00192-g4c04654455c0/build/vmlinux
Bytes read match those read by objdump
/proc/{kallsyms,modules} inconsistency while looking for "[bpf]" module!
/proc/{kallsyms,modules} inconsistency while looking for "[bpf]" module!
/proc/{kallsyms,modules} inconsistency while looking for "[bpf]" module!
/proc/{kallsyms,modules} inconsistency while looking for "[bpf]" module!
/proc/{kallsyms,modules} inconsistency while looking for "[bpf]" module!
/proc/{kallsyms,modules} inconsistency while looking for "[bpf]" module!
/proc/{kallsyms,modules} inconsistency while looking for "[bpf]" module!
/proc/{kallsyms,modules} inconsistency while looking for "[bpf]" module!
/proc/{kallsyms,modules} inconsistency while looking for "[bpf]" module!
/proc/{kallsyms,modules} inconsistency while looking for "[bpf]" module!
Using /proc/kallsyms for symbols
no kcore
---- end(0) ----

=================================================================
==7665==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 28248 byte(s) in 3 object(s) allocated from:
    #0 0x7fb03cb983b7 in __interceptor_calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x7fb03c9ca743  (/lib/x86_64-linux-gnu/libelf.so.1+0x3743)

Indirect leak of 24548124 byte(s) in 302598 object(s) allocated from:
    #0 0x7fb03cb983b7 in __interceptor_calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x55f07368ddbe in symbol__new util/symbol.c:305
    #2 0x55f073691996 in map__process_kallsym_symbol util/symbol.c:777
    #3 0x55f0733105df in kallsyms__parse /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/lib/symbol/kallsyms.c:71
    #4 0x55f073691a43 in dso__load_all_kallsyms util/symbol.c:796
    #5 0x55f073697239 in __dso__load_kallsyms util/symbol.c:1497
    #6 0x55f073697523 in dso__load_kallsyms util/symbol.c:1520
    #7 0x55f073699fe2 in dso__load_kernel_sym util/symbol.c:2234
    #8 0x55f073698303 in dso__load util/symbol.c:1837
    #9 0x55f07372c4a7 in map__load util/map.c:352
    #10 0x55f073445cb8 in do_test_code_reading tests/code-reading.c:672
    #11 0x55f073446f29 in test__code_reading tests/code-reading.c:811
    #12 0x55f0733af9f0 in run_test_child tests/builtin-test.c:257
    #13 0x55f07330b8f1 in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/lib/subcmd/run-command.c:127
    #14 0x55f0733b1eda in start_test tests/builtin-test.c:461
    #15 0x55f0733b2e46 in __cmd_test tests/builtin-test.c:561
    #16 0x55f0733b5814 in cmd_test tests/builtin-test.c:763
    #17 0x55f0732c6211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:351
    #18 0x55f0732c6acf in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:404
    #19 0x55f0732c7025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:448
    #20 0x55f0732c77cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:556
    #21 0x7fb03bb83249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 36275 byte(s) in 93 object(s) allocated from:
    #0 0x7fb03cb983b7 in __interceptor_calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x55f0732f1fde in zalloc ../../lib/zalloc.c:8
    #2 0x55f07367e36e in dso__new_id util/dso.c:1515
    #3 0x55f073686e28 in dsos__findnew_module_dso util/dsos.c:449
    #4 0x55f07370e53d in machine__addnew_module_map util/machine.c:881
    #5 0x55f07371334a in machine__create_module util/machine.c:1476
    #6 0x55f073690ed2 in modules__parse util/symbol.c:705
    #7 0x55f0737136ed in machine__create_modules util/machine.c:1501
    #8 0x55f073713d96 in machine__create_kernel_maps util/machine.c:1557
    #9 0x55f073709051 in __machine__new_host util/machine.c:141
    #10 0x55f073709130 in machine__new_host util/machine.c:151
    #11 0x55f073445aff in do_test_code_reading tests/code-reading.c:657
    #12 0x55f073446f29 in test__code_reading tests/code-reading.c:811
    #13 0x55f0733af9f0 in run_test_child tests/builtin-test.c:257
    #14 0x55f07330b8f1 in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/lib/subcmd/run-command.c:127
    #15 0x55f0733b1eda in start_test tests/builtin-test.c:461
    #16 0x55f0733b2e46 in __cmd_test tests/builtin-test.c:561
    #17 0x55f0733b5814 in cmd_test tests/builtin-test.c:763
    #18 0x55f0732c6211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:351
    #19 0x55f0732c6acf in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:404
    #20 0x55f0732c7025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:448
    #21 0x55f0732c77cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:556
    #22 0x7fb03bb83249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 30504 byte(s) in 93 object(s) allocated from:
    #0 0x7fb03cb983b7 in __interceptor_calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x55f07372ba62 in map__new2 util/map.c:227
    #2 0x55f07370e567 in machine__addnew_module_map util/machine.c:885
    #3 0x55f07371334a in machine__create_module util/machine.c:1476
    #4 0x55f073690ed2 in modules__parse util/symbol.c:705
    #5 0x55f0737136ed in machine__create_modules util/machine.c:1501
    #6 0x55f073713d96 in machine__create_kernel_maps util/machine.c:1557
    #7 0x55f073709051 in __machine__new_host util/machine.c:141
    #8 0x55f073709130 in machine__new_host util/machine.c:151
    #9 0x55f073445aff in do_test_code_reading tests/code-reading.c:657
    #10 0x55f073446f29 in test__code_reading tests/code-reading.c:811
    #11 0x55f0733af9f0 in run_test_child tests/builtin-test.c:257
    #12 0x55f07330b8f1 in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/lib/subcmd/run-command.c:127
    #13 0x55f0733b1eda in start_test tests/builtin-test.c:461
    #14 0x55f0733b2e46 in __cmd_test tests/builtin-test.c:561
    #15 0x55f0733b5814 in cmd_test tests/builtin-test.c:763
    #16 0x55f0732c6211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:351
    #17 0x55f0732c6acf in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:404
    #18 0x55f0732c7025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:448
    #19 0x55f0732c77cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:556
    #20 0x7fb03bb83249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 30504 byte(s) in 93 object(s) allocated from:
    #0 0x7fb03cb983b7 in __interceptor_calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x55f07372ba62 in map__new2 util/map.c:227
    #2 0x55f07370e567 in machine__addnew_module_map util/machine.c:885
    #3 0x55f07371334a in machine__create_module util/machine.c:1476
    #4 0x55f073690ed2 in modules__parse util/symbol.c:705
    #5 0x55f0737136ed in machine__create_modules util/machine.c:1501
    #6 0x55f073713d96 in machine__create_kernel_maps util/machine.c:1557
    #7 0x55f073445bb1 in do_test_code_reading tests/code-reading.c:660
    #8 0x55f073446f29 in test__code_reading tests/code-reading.c:811
    #9 0x55f0733af9f0 in run_test_child tests/builtin-test.c:257
    #10 0x55f07330b8f1 in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/lib/subcmd/run-command.c:127
    #11 0x55f0733b1eda in start_test tests/builtin-test.c:461
    #12 0x55f0733b2e46 in __cmd_test tests/builtin-test.c:561
    #13 0x55f0733b5814 in cmd_test tests/builtin-test.c:763
    #14 0x55f0732c6211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:351
    #15 0x55f0732c6acf in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:404
    #16 0x55f0732c7025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:448
    #17 0x55f0732c77cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:556
    #18 0x7fb03bb83249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 8448 byte(s) in 3 object(s) allocated from:
    #0 0x7fb03cb989cf in __interceptor_malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x7fb03c9d19f0  (/lib/x86_64-linux-gnu/libelf.so.1+0xa9f0)

Indirect leak of 2797 byte(s) in 33 object(s) allocated from:
    #0 0x7fb03cb5077b in __interceptor_strdup ../../../../src/libsanitizer/asan/asan_interceptors.cpp:439
    #1 0x55f07371220e in maps__set_module_path util/machine.c:1358
    #2 0x55f073712df2 in maps__set_modules_path_dir util/machine.c:1428
    #3 0x55f073712b1b in maps__set_modules_path_dir util/machine.c:1414
    #4 0x55f073712b1b in maps__set_modules_path_dir util/machine.c:1414
    #5 0x55f073712b1b in maps__set_modules_path_dir util/machine.c:1414
    #6 0x55f073712b1b in maps__set_modules_path_dir util/machine.c:1414
    #7 0x55f07371318b in machine__set_modules_path util/machine.c:1457
    #8 0x55f073713707 in machine__create_modules util/machine.c:1504
    #9 0x55f073713d96 in machine__create_kernel_maps util/machine.c:1557
    #10 0x55f073445bb1 in do_test_code_reading tests/code-reading.c:660
    #11 0x55f073446f29 in test__code_reading tests/code-reading.c:811
    #12 0x55f0733af9f0 in run_test_child tests/builtin-test.c:257
    #13 0x55f07330b8f1 in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/lib/subcmd/run-command.c:127
    #14 0x55f0733b1eda in start_test tests/builtin-test.c:461
    #15 0x55f0733b2e46 in __cmd_test tests/builtin-test.c:561
    #16 0x55f0733b5814 in cmd_test tests/builtin-test.c:763
    #17 0x55f0732c6211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:351
    #18 0x55f0732c6acf in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:404
    #19 0x55f0732c7025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:448
    #20 0x55f0732c77cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:556
    #21 0x7fb03bb83249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 2749 byte(s) in 36 object(s) allocated from:
    #0 0x7fb03cb5077b in __interceptor_strdup ../../../../src/libsanitizer/asan/asan_interceptors.cpp:439
    #1 0x55f07371220e in maps__set_module_path util/machine.c:1358
    #2 0x55f073712df2 in maps__set_modules_path_dir util/machine.c:1428
    #3 0x55f073712b1b in maps__set_modules_path_dir util/machine.c:1414
    #4 0x55f073712b1b in maps__set_modules_path_dir util/machine.c:1414
    #5 0x55f073712b1b in maps__set_modules_path_dir util/machine.c:1414
    #6 0x55f07371318b in machine__set_modules_path util/machine.c:1457
    #7 0x55f073713707 in machine__create_modules util/machine.c:1504
    #8 0x55f073713d96 in machine__create_kernel_maps util/machine.c:1557
    #9 0x55f073445bb1 in do_test_code_reading tests/code-reading.c:660
    #10 0x55f073446f29 in test__code_reading tests/code-reading.c:811
    #11 0x55f0733af9f0 in run_test_child tests/builtin-test.c:257
    #12 0x55f07330b8f1 in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/lib/subcmd/run-command.c:127
    #13 0x55f0733b1eda in start_test tests/builtin-test.c:461
    #14 0x55f0733b2e46 in __cmd_test tests/builtin-test.c:561
    #15 0x55f0733b5814 in cmd_test tests/builtin-test.c:763
    #16 0x55f0732c6211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:351
    #17 0x55f0732c6acf in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:404
    #18 0x55f0732c7025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:448
    #19 0x55f0732c77cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:556
    #20 0x7fb03bb83249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 2048 byte(s) in 1 object(s) allocated from:
    #0 0x7fb03cb978d5 in __interceptor_realloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:85
    #1 0x55f073733851 in __maps__insert util/maps.c:460
    #2 0x55f073733e59 in maps__insert util/maps.c:515
    #3 0x55f07370e59c in machine__addnew_module_map util/machine.c:889
    #4 0x55f07371334a in machine__create_module util/machine.c:1476
    #5 0x55f073690ed2 in modules__parse util/symbol.c:705
    #6 0x55f0737136ed in machine__create_modules util/machine.c:1501
    #7 0x55f073713d96 in machine__create_kernel_maps util/machine.c:1557
    #8 0x55f073445bb1 in do_test_code_reading tests/code-reading.c:660
    #9 0x55f073446f29 in test__code_reading tests/code-reading.c:811
    #10 0x55f0733af9f0 in run_test_child tests/builtin-test.c:257
    #11 0x55f07330b8f1 in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/lib/subcmd/run-command.c:127
    #12 0x55f0733b1eda in start_test tests/builtin-test.c:461
    #13 0x55f0733b2e46 in __cmd_test tests/builtin-test.c:561
    #14 0x55f0733b5814 in cmd_test tests/builtin-test.c:763
    #15 0x55f0732c6211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:351
    #16 0x55f0732c6acf in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:404
    #17 0x55f0732c7025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:448
    #18 0x55f0732c77cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:556
    #19 0x7fb03bb83249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 2048 byte(s) in 1 object(s) allocated from:
    #0 0x7fb03cb978d5 in __interceptor_realloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:85
    #1 0x55f07373389a in __maps__insert util/maps.c:466
    #2 0x55f073733e59 in maps__insert util/maps.c:515
    #3 0x55f07370e59c in machine__addnew_module_map util/machine.c:889
    #4 0x55f07371334a in machine__create_module util/machine.c:1476
    #5 0x55f073690ed2 in modules__parse util/symbol.c:705
    #6 0x55f0737136ed in machine__create_modules util/machine.c:1501
    #7 0x55f073713d96 in machine__create_kernel_maps util/machine.c:1557
    #8 0x55f073445bb1 in do_test_code_reading tests/code-reading.c:660
    #9 0x55f073446f29 in test__code_reading tests/code-reading.c:811
    #10 0x55f0733af9f0 in run_test_child tests/builtin-test.c:257
    #11 0x55f07330b8f1 in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/lib/subcmd/run-command.c:127
    #12 0x55f0733b1eda in start_test tests/builtin-test.c:461
    #13 0x55f0733b2e46 in __cmd_test tests/builtin-test.c:561
    #14 0x55f0733b5814 in cmd_test tests/builtin-test.c:763
    #15 0x55f0732c6211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:351
    #16 0x55f0732c6acf in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:404
    #17 0x55f0732c7025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:448
    #18 0x55f0732c77cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:556
    #19 0x7fb03bb83249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 1735 byte(s) in 3 object(s) allocated from:
    #0 0x7fb03cb989cf in __interceptor_malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x7fb03c9d2812  (/lib/x86_64-linux-gnu/libelf.so.1+0xb812)

Indirect leak of 1334 byte(s) in 15 object(s) allocated from:
    #0 0x7fb03cb5077b in __interceptor_strdup ../../../../src/libsanitizer/asan/asan_interceptors.cpp:439
    #1 0x55f07371220e in maps__set_module_path util/machine.c:1358
    #2 0x55f073712df2 in maps__set_modules_path_dir util/machine.c:1428
    #3 0x55f073712b1b in maps__set_modules_path_dir util/machine.c:1414
    #4 0x55f073712b1b in maps__set_modules_path_dir util/machine.c:1414
    #5 0x55f073712b1b in maps__set_modules_path_dir util/machine.c:1414
    #6 0x55f073712b1b in maps__set_modules_path_dir util/machine.c:1414
    #7 0x55f073712b1b in maps__set_modules_path_dir util/machine.c:1414
    #8 0x55f07371318b in machine__set_modules_path util/machine.c:1457
    #9 0x55f073713707 in machine__create_modules util/machine.c:1504
    #10 0x55f073713d96 in machine__create_kernel_maps util/machine.c:1557
    #11 0x55f073445bb1 in do_test_code_reading tests/code-reading.c:660
    #12 0x55f073446f29 in test__code_reading tests/code-reading.c:811
    #13 0x55f0733af9f0 in run_test_child tests/builtin-test.c:257
    #14 0x55f07330b8f1 in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/lib/subcmd/run-command.c:127
    #15 0x55f0733b1eda in start_test tests/builtin-test.c:461
    #16 0x55f0733b2e46 in __cmd_test tests/builtin-test.c:561
    #17 0x55f0733b5814 in cmd_test tests/builtin-test.c:763
    #18 0x55f0732c6211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:351
    #19 0x55f0732c6acf in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:404
    #20 0x55f0732c7025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:448
    #21 0x55f0732c77cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:556
    #22 0x7fb03bb83249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 1307 byte(s) in 93 object(s) allocated from:
    #0 0x7fb03cb5077b in __interceptor_strdup ../../../../src/libsanitizer/asan/asan_interceptors.cpp:439
    #1 0x55f073676f0a in dso__set_module_info util/dso.c:490
    #2 0x55f073686e94 in dsos__findnew_module_dso util/dsos.c:455
    #3 0x55f07370e53d in machine__addnew_module_map util/machine.c:881
    #4 0x55f07371334a in machine__create_module util/machine.c:1476
    #5 0x55f073690ed2 in modules__parse util/symbol.c:705
    #6 0x55f0737136ed in machine__create_modules util/machine.c:1501
    #7 0x55f073713d96 in machine__create_kernel_maps util/machine.c:1557
    #8 0x55f073709051 in __machine__new_host util/machine.c:141
    #9 0x55f073709130 in machine__new_host util/machine.c:151
    #10 0x55f073445aff in do_test_code_reading tests/code-reading.c:657
    #11 0x55f073446f29 in test__code_reading tests/code-reading.c:811
    #12 0x55f0733af9f0 in run_test_child tests/builtin-test.c:257
    #13 0x55f07330b8f1 in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/lib/subcmd/run-command.c:127
    #14 0x55f0733b1eda in start_test tests/builtin-test.c:461
    #15 0x55f0733b2e46 in __cmd_test tests/builtin-test.c:561
    #16 0x55f0733b5814 in cmd_test tests/builtin-test.c:763
    #17 0x55f0732c6211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:351
    #18 0x55f0732c6acf in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:404
    #19 0x55f0732c7025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:448
    #20 0x55f0732c77cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:556
    #21 0x7fb03bb83249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 1256 byte(s) in 1 object(s) allocated from:
    #0 0x7fb03cb989cf in __interceptor_malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x55f07370900f in __machine__new_host util/machine.c:134
    #2 0x55f073709130 in machine__new_host util/machine.c:151
    #3 0x55f073445aff in do_test_code_reading tests/code-reading.c:657
    #4 0x55f073446f29 in test__code_reading tests/code-reading.c:811
    #5 0x55f0733af9f0 in run_test_child tests/builtin-test.c:257
    #6 0x55f07330b8f1 in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/lib/subcmd/run-command.c:127
    #7 0x55f0733b1eda in start_test tests/builtin-test.c:461
    #8 0x55f0733b2e46 in __cmd_test tests/builtin-test.c:561
    #9 0x55f0733b5814 in cmd_test tests/builtin-test.c:763
    #10 0x55f0732c6211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:351
    #11 0x55f0732c6acf in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:404
    #12 0x55f0732c7025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:448
    #13 0x55f0732c77cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:556
    #14 0x7fb03bb83249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 1024 byte(s) in 1 object(s) allocated from:
    #0 0x7fb03cb978d5 in __interceptor_realloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:85
    #1 0x55f073684bcd in __dsos__add util/dsos.c:204
    #2 0x55f073686ef1 in dsos__findnew_module_dso util/dsos.c:458
    #3 0x55f07370e53d in machine__addnew_module_map util/machine.c:881
    #4 0x55f07371334a in machine__create_module util/machine.c:1476
    #5 0x55f073690ed2 in modules__parse util/symbol.c:705
    #6 0x55f0737136ed in machine__create_modules util/machine.c:1501
    #7 0x55f073713d96 in machine__create_kernel_maps util/machine.c:1557
    #8 0x55f073709051 in __machine__new_host util/machine.c:141
    #9 0x55f073709130 in machine__new_host util/machine.c:151
    #10 0x55f073445aff in do_test_code_reading tests/code-reading.c:657
    #11 0x55f073446f29 in test__code_reading tests/code-reading.c:811
    #12 0x55f0733af9f0 in run_test_child tests/builtin-test.c:257
    #13 0x55f07330b8f1 in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/lib/subcmd/run-command.c:127
    #14 0x55f0733b1eda in start_test tests/builtin-test.c:461
    #15 0x55f0733b2e46 in __cmd_test tests/builtin-test.c:561
    #16 0x55f0733b5814 in cmd_test tests/builtin-test.c:763
    #17 0x55f0732c6211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:351
    #18 0x55f0732c6acf in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:404
    #19 0x55f0732c7025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:448
    #20 0x55f0732c77cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:556
    #21 0x7fb03bb83249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 744 byte(s) in 93 object(s) allocated from:
    #0 0x7fb03cb989cf in __interceptor_malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x55f07372f51a in map__get util/map.h:189
    #2 0x55f0737339e9 in __maps__insert util/maps.c:479
    #3 0x55f073733e59 in maps__insert util/maps.c:515
    #4 0x55f07370e59c in machine__addnew_module_map util/machine.c:889
    #5 0x55f07371334a in machine__create_module util/machine.c:1476
    #6 0x55f073690ed2 in modules__parse util/symbol.c:705
    #7 0x55f0737136ed in machine__create_modules util/machine.c:1501
    #8 0x55f073713d96 in machine__create_kernel_maps util/machine.c:1557
    #9 0x55f073709051 in __machine__new_host util/machine.c:141
    #10 0x55f073709130 in machine__new_host util/machine.c:151
    #11 0x55f073445aff in do_test_code_reading tests/code-reading.c:657
    #12 0x55f073446f29 in test__code_reading tests/code-reading.c:811
    #13 0x55f0733af9f0 in run_test_child tests/builtin-test.c:257
    #14 0x55f07330b8f1 in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/lib/subcmd/run-command.c:127
    #15 0x55f0733b1eda in start_test tests/builtin-test.c:461
    #16 0x55f0733b2e46 in __cmd_test tests/builtin-test.c:561
    #17 0x55f0733b5814 in cmd_test tests/builtin-test.c:763
    #18 0x55f0732c6211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:351
    #19 0x55f0732c6acf in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:404
    #20 0x55f0732c7025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:448
    #21 0x55f0732c77cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:556
    #22 0x7fb03bb83249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 744 byte(s) in 93 object(s) allocated from:
    #0 0x7fb03cb989cf in __interceptor_malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x55f07372f51a in map__get util/map.h:189
    #2 0x55f073733a98 in __maps__insert util/maps.c:481
    #3 0x55f073733e59 in maps__insert util/maps.c:515
    #4 0x55f07370e59c in machine__addnew_module_map util/machine.c:889
    #5 0x55f07371334a in machine__create_module util/machine.c:1476
    #6 0x55f073690ed2 in modules__parse util/symbol.c:705
    #7 0x55f0737136ed in machine__create_modules util/machine.c:1501
    #8 0x55f073713d96 in machine__create_kernel_maps util/machine.c:1557
    #9 0x55f073445bb1 in do_test_code_reading tests/code-reading.c:660
    #10 0x55f073446f29 in test__code_reading tests/code-reading.c:811
    #11 0x55f0733af9f0 in run_test_child tests/builtin-test.c:257
    #12 0x55f07330b8f1 in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/lib/subcmd/run-command.c:127
    #13 0x55f0733b1eda in start_test tests/builtin-test.c:461
    #14 0x55f0733b2e46 in __cmd_test tests/builtin-test.c:561
    #15 0x55f0733b5814 in cmd_test tests/builtin-test.c:763
    #16 0x55f0732c6211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:351
    #17 0x55f0732c6acf in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:404
    #18 0x55f0732c7025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:448
    #19 0x55f0732c77cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:556
    #20 0x7fb03bb83249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 744 byte(s) in 93 object(s) allocated from:
    #0 0x7fb03cb989cf in __interceptor_malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x55f07372f51a in map__get util/map.h:189
    #2 0x55f0737339e9 in __maps__insert util/maps.c:479
    #3 0x55f073733e59 in maps__insert util/maps.c:515
    #4 0x55f07370e59c in machine__addnew_module_map util/machine.c:889
    #5 0x55f07371334a in machine__create_module util/machine.c:1476
    #6 0x55f073690ed2 in modules__parse util/symbol.c:705
    #7 0x55f0737136ed in machine__create_modules util/machine.c:1501
    #8 0x55f073713d96 in machine__create_kernel_maps util/machine.c:1557
    #9 0x55f073445bb1 in do_test_code_reading tests/code-reading.c:660
    #10 0x55f073446f29 in test__code_reading tests/code-reading.c:811
    #11 0x55f0733af9f0 in run_test_child tests/builtin-test.c:257
    #12 0x55f07330b8f1 in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/lib/subcmd/run-command.c:127
    #13 0x55f0733b1eda in start_test tests/builtin-test.c:461
    #14 0x55f0733b2e46 in __cmd_test tests/builtin-test.c:561
    #15 0x55f0733b5814 in cmd_test tests/builtin-test.c:763
    #16 0x55f0732c6211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:351
    #17 0x55f0732c6acf in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:404
    #18 0x55f0732c7025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:448
    #19 0x55f0732c77cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:556
    #20 0x7fb03bb83249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 744 byte(s) in 93 object(s) allocated from:
    #0 0x7fb03cb989cf in __interceptor_malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x55f07368024a in dso__get util/dso.c:1607
    #2 0x55f07372afc1 in map__init util/map.c:112
    #3 0x55f07372bb31 in map__new2 util/map.c:230
    #4 0x55f07370e567 in machine__addnew_module_map util/machine.c:885
    #5 0x55f07371334a in machine__create_module util/machine.c:1476
    #6 0x55f073690ed2 in modules__parse util/symbol.c:705
    #7 0x55f0737136ed in machine__create_modules util/machine.c:1501
    #8 0x55f073713d96 in machine__create_kernel_maps util/machine.c:1557
    #9 0x55f073445bb1 in do_test_code_reading tests/code-reading.c:660
    #10 0x55f073446f29 in test__code_reading tests/code-reading.c:811
    #11 0x55f0733af9f0 in run_test_child tests/builtin-test.c:257
    #12 0x55f07330b8f1 in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/lib/subcmd/run-command.c:127
    #13 0x55f0733b1eda in start_test tests/builtin-test.c:461
    #14 0x55f0733b2e46 in __cmd_test tests/builtin-test.c:561
    #15 0x55f0733b5814 in cmd_test tests/builtin-test.c:763
    #16 0x55f0732c6211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:351
    #17 0x55f0732c6acf in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:404
    #18 0x55f0732c7025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:448
    #19 0x55f0732c77cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:556
    #20 0x7fb03bb83249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 744 byte(s) in 93 object(s) allocated from:
    #0 0x7fb03cb989cf in __interceptor_malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x55f07368024a in dso__get util/dso.c:1607
    #2 0x55f07372afc1 in map__init util/map.c:112
    #3 0x55f07372bb31 in map__new2 util/map.c:230
    #4 0x55f07370e567 in machine__addnew_module_map util/machine.c:885
    #5 0x55f07371334a in machine__create_module util/machine.c:1476
    #6 0x55f073690ed2 in modules__parse util/symbol.c:705
    #7 0x55f0737136ed in machine__create_modules util/machine.c:1501
    #8 0x55f073713d96 in machine__create_kernel_maps util/machine.c:1557
    #9 0x55f073709051 in __machine__new_host util/machine.c:141
    #10 0x55f073709130 in machine__new_host util/machine.c:151
    #11 0x55f073445aff in do_test_code_reading tests/code-reading.c:657
    #12 0x55f073446f29 in test__code_reading tests/code-reading.c:811
    #13 0x55f0733af9f0 in run_test_child tests/builtin-test.c:257
    #14 0x55f07330b8f1 in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/lib/subcmd/run-command.c:127
    #15 0x55f0733b1eda in start_test tests/builtin-test.c:461
    #16 0x55f0733b2e46 in __cmd_test tests/builtin-test.c:561
    #17 0x55f0733b5814 in cmd_test tests/builtin-test.c:763
    #18 0x55f0732c6211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:351
    #19 0x55f0732c6acf in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:404
    #20 0x55f0732c7025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:448
    #21 0x55f0732c77cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:556
    #22 0x7fb03bb83249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 744 byte(s) in 93 object(s) allocated from:
    #0 0x7fb03cb989cf in __interceptor_malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x55f07368024a in dso__get util/dso.c:1607
    #2 0x55f073684fb0 in __dsos__add util/dsos.c:211
    #3 0x55f073686ef1 in dsos__findnew_module_dso util/dsos.c:458
    #4 0x55f07370e53d in machine__addnew_module_map util/machine.c:881
    #5 0x55f07371334a in machine__create_module util/machine.c:1476
    #6 0x55f073690ed2 in modules__parse util/symbol.c:705
    #7 0x55f0737136ed in machine__create_modules util/machine.c:1501
    #8 0x55f073713d96 in machine__create_kernel_maps util/machine.c:1557
    #9 0x55f073709051 in __machine__new_host util/machine.c:141
    #10 0x55f073709130 in machine__new_host util/machine.c:151
    #11 0x55f073445aff in do_test_code_reading tests/code-reading.c:657
    #12 0x55f073446f29 in test__code_reading tests/code-reading.c:811
    #13 0x55f0733af9f0 in run_test_child tests/builtin-test.c:257
    #14 0x55f07330b8f1 in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/lib/subcmd/run-command.c:127
    #15 0x55f0733b1eda in start_test tests/builtin-test.c:461
    #16 0x55f0733b2e46 in __cmd_test tests/builtin-test.c:561
    #17 0x55f0733b5814 in cmd_test tests/builtin-test.c:763
    #18 0x55f0732c6211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:351
    #19 0x55f0732c6acf in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:404
    #20 0x55f0732c7025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:448
    #21 0x55f0732c77cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:556
    #22 0x7fb03bb83249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 744 byte(s) in 93 object(s) allocated from:
    #0 0x7fb03cb989cf in __interceptor_malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x55f07372f51a in map__get util/map.h:189
    #2 0x55f073732d84 in maps__sort_by_name util/maps.c:373
    #3 0x55f07373936d in maps__find_by_name util/maps.c:1148
    #4 0x55f0737121d7 in maps__set_module_path util/machine.c:1353
    #5 0x55f073712df2 in maps__set_modules_path_dir util/machine.c:1428
    #6 0x55f073712b1b in maps__set_modules_path_dir util/machine.c:1414
    #7 0x55f073712b1b in maps__set_modules_path_dir util/machine.c:1414
    #8 0x55f073712b1b in maps__set_modules_path_dir util/machine.c:1414
    #9 0x55f07371318b in machine__set_modules_path util/machine.c:1457
    #10 0x55f073713707 in machine__create_modules util/machine.c:1504
    #11 0x55f073713d96 in machine__create_kernel_maps util/machine.c:1557
    #12 0x55f073709051 in __machine__new_host util/machine.c:141
    #13 0x55f073709130 in machine__new_host util/machine.c:151
    #14 0x55f073445aff in do_test_code_reading tests/code-reading.c:657
    #15 0x55f073446f29 in test__code_reading tests/code-reading.c:811
    #16 0x55f0733af9f0 in run_test_child tests/builtin-test.c:257
    #17 0x55f07330b8f1 in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/lib/subcmd/run-command.c:127
    #18 0x55f0733b1eda in start_test tests/builtin-test.c:461
    #19 0x55f0733b2e46 in __cmd_test tests/builtin-test.c:561
    #20 0x55f0733b5814 in cmd_test tests/builtin-test.c:763
    #21 0x55f0732c6211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:351
    #22 0x55f0732c6acf in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:404
    #23 0x55f0732c7025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:448
    #24 0x55f0732c77cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:556
    #25 0x7fb03bb83249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 543 byte(s) in 5 object(s) allocated from:
    #0 0x7fb03cb5077b in __interceptor_strdup ../../../../src/libsanitizer/asan/asan_interceptors.cpp:439
    #1 0x55f07371220e in maps__set_module_path util/machine.c:1358
    #2 0x55f073712df2 in maps__set_modules_path_dir util/machine.c:1428
    #3 0x55f073712b1b in maps__set_modules_path_dir util/machine.c:1414
    #4 0x55f073712b1b in maps__set_modules_path_dir util/machine.c:1414
    #5 0x55f073712b1b in maps__set_modules_path_dir util/machine.c:1414
    #6 0x55f073712b1b in maps__set_modules_path_dir util/machine.c:1414
    #7 0x55f073712b1b in maps__set_modules_path_dir util/machine.c:1414
    #8 0x55f073712b1b in maps__set_modules_path_dir util/machine.c:1414
    #9 0x55f07371318b in machine__set_modules_path util/machine.c:1457
    #10 0x55f073713707 in machine__create_modules util/machine.c:1504
    #11 0x55f073713d96 in machine__create_kernel_maps util/machine.c:1557
    #12 0x55f073445bb1 in do_test_code_reading tests/code-reading.c:660
    #13 0x55f073446f29 in test__code_reading tests/code-reading.c:811
    #14 0x55f0733af9f0 in run_test_child tests/builtin-test.c:257
    #15 0x55f07330b8f1 in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/lib/subcmd/run-command.c:127
    #16 0x55f0733b1eda in start_test tests/builtin-test.c:461
    #17 0x55f0733b2e46 in __cmd_test tests/builtin-test.c:561
    #18 0x55f0733b5814 in cmd_test tests/builtin-test.c:763
    #19 0x55f0732c6211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:351
    #20 0x55f0732c6acf in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:404
    #21 0x55f0732c7025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:448
    #22 0x55f0732c77cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:556
    #23 0x7fb03bb83249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 394 byte(s) in 1 object(s) allocated from:
    #0 0x7fb03cb983b7 in __interceptor_calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x55f0732f1fde in zalloc ../../lib/zalloc.c:8
    #2 0x55f07367e36e in dso__new_id util/dso.c:1515
    #3 0x55f073686097 in __dsos__addnew_id util/dsos.c:328
    #4 0x55f073686184 in __dsos__findnew_id util/dsos.c:350
    #5 0x55f07368620e in dsos__findnew_id util/dsos.c:357
    #6 0x55f0737256ba in machine__findnew_dso_id util/machine.c:3188
    #7 0x55f073725707 in machine__findnew_dso util/machine.c:3193
    #8 0x55f07367c689 in machine__findnew_kernel util/dso.c:1338
    #9 0x55f07370ef54 in machine__get_kernel util/machine.c:969
    #10 0x55f073713c58 in machine__create_kernel_maps util/machine.c:1545
    #11 0x55f073709051 in __machine__new_host util/machine.c:141
    #12 0x55f073709130 in machine__new_host util/machine.c:151
    #13 0x55f073445aff in do_test_code_reading tests/code-reading.c:657
    #14 0x55f073446f29 in test__code_reading tests/code-reading.c:811
    #15 0x55f0733af9f0 in run_test_child tests/builtin-test.c:257
    #16 0x55f07330b8f1 in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/lib/subcmd/run-command.c:127
    #17 0x55f0733b1eda in start_test tests/builtin-test.c:461
    #18 0x55f0733b2e46 in __cmd_test tests/builtin-test.c:561
    #19 0x55f0733b5814 in cmd_test tests/builtin-test.c:763
    #20 0x55f0732c6211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:351
    #21 0x55f0732c6acf in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:404
    #22 0x55f0732c7025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:448
    #23 0x55f0732c77cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:556
    #24 0x7fb03bb83249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 328 byte(s) in 1 object(s) allocated from:
    #0 0x7fb03cb983b7 in __interceptor_calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x55f07372ba62 in map__new2 util/map.c:227
    #2 0x55f0737109d0 in __machine__create_kernel_maps util/machine.c:1184
    #3 0x55f073713d07 in machine__create_kernel_maps util/machine.c:1553
    #4 0x55f073445bb1 in do_test_code_reading tests/code-reading.c:660
    #5 0x55f073446f29 in test__code_reading tests/code-reading.c:811
    #6 0x55f0733af9f0 in run_test_child tests/builtin-test.c:257
    #7 0x55f07330b8f1 in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/lib/subcmd/run-command.c:127
    #8 0x55f0733b1eda in start_test tests/builtin-test.c:461
    #9 0x55f0733b2e46 in __cmd_test tests/builtin-test.c:561
    #10 0x55f0733b5814 in cmd_test tests/builtin-test.c:763
    #11 0x55f0732c6211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:351
    #12 0x55f0732c6acf in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:404
    #13 0x55f0732c7025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:448
    #14 0x55f0732c77cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:556
    #15 0x7fb03bb83249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 281 byte(s) in 4 object(s) allocated from:
    #0 0x7fb03cb5077b in __interceptor_strdup ../../../../src/libsanitizer/asan/asan_interceptors.cpp:439
    #1 0x55f07371220e in maps__set_module_path util/machine.c:1358
    #2 0x55f073712df2 in maps__set_modules_path_dir util/machine.c:1428
    #3 0x55f073712b1b in maps__set_modules_path_dir util/machine.c:1414
    #4 0x55f073712b1b in maps__set_modules_path_dir util/machine.c:1414
    #5 0x55f07371318b in machine__set_modules_path util/machine.c:1457
    #6 0x55f073713707 in machine__create_modules util/machine.c:1504
    #7 0x55f073713d96 in machine__create_kernel_maps util/machine.c:1557
    #8 0x55f073445bb1 in do_test_code_reading tests/code-reading.c:660
    #9 0x55f073446f29 in test__code_reading tests/code-reading.c:811
    #10 0x55f0733af9f0 in run_test_child tests/builtin-test.c:257
    #11 0x55f07330b8f1 in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/lib/subcmd/run-command.c:127
    #12 0x55f0733b1eda in start_test tests/builtin-test.c:461
    #13 0x55f0733b2e46 in __cmd_test tests/builtin-test.c:561
    #14 0x55f0733b5814 in cmd_test tests/builtin-test.c:763
    #15 0x55f0732c6211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:351
    #16 0x55f0732c6acf in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:404
    #17 0x55f0732c7025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:448
    #18 0x55f0732c77cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:556
    #19 0x7fb03bb83249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 104 byte(s) in 1 object(s) allocated from:
    #0 0x7fb03cb983b7 in __interceptor_calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x55f0732f1fde in zalloc ../../lib/zalloc.c:8
    #2 0x55f073731f9b in maps__new util/maps.c:248
    #3 0x55f0737085a8 in machine__init util/machine.c:80
    #4 0x55f07370903f in __machine__new_host util/machine.c:139
    #5 0x55f073709130 in machine__new_host util/machine.c:151
    #6 0x55f073445aff in do_test_code_reading tests/code-reading.c:657
    #7 0x55f073446f29 in test__code_reading tests/code-reading.c:811
    #8 0x55f0733af9f0 in run_test_child tests/builtin-test.c:257
    #9 0x55f07330b8f1 in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/lib/subcmd/run-command.c:127
    #10 0x55f0733b1eda in start_test tests/builtin-test.c:461
    #11 0x55f0733b2e46 in __cmd_test tests/builtin-test.c:561
    #12 0x55f0733b5814 in cmd_test tests/builtin-test.c:763
    #13 0x55f0732c6211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:351
    #14 0x55f0732c6acf in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:404
    #15 0x55f0732c7025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:448
    #16 0x55f0732c77cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:556
    #17 0x7fb03bb83249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 24 byte(s) in 1 object(s) allocated from:
    #0 0x7fb03cb983b7 in __interceptor_calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x55f0732f1fde in zalloc ../../lib/zalloc.c:8
    #2 0x55f07375e83b in map__set_kallsyms_ref_reloc_sym util/session.c:2472
    #3 0x55f073714022 in machine__create_kernel_maps util/machine.c:1568
    #4 0x55f073445bb1 in do_test_code_reading tests/code-reading.c:660
    #5 0x55f073446f29 in test__code_reading tests/code-reading.c:811
    #6 0x55f0733af9f0 in run_test_child tests/builtin-test.c:257
    #7 0x55f07330b8f1 in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/lib/subcmd/run-command.c:127
    #8 0x55f0733b1eda in start_test tests/builtin-test.c:461
    #9 0x55f0733b2e46 in __cmd_test tests/builtin-test.c:561
    #10 0x55f0733b5814 in cmd_test tests/builtin-test.c:763
    #11 0x55f0732c6211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:351
    #12 0x55f0732c6acf in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:404
    #13 0x55f0732c7025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:448
    #14 0x55f0732c77cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:556
    #15 0x7fb03bb83249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 18 byte(s) in 1 object(s) allocated from:
    #0 0x7fb03cb5077b in __interceptor_strdup ../../../../src/libsanitizer/asan/asan_interceptors.cpp:439
    #1 0x55f0737080ca in machine__set_mmap_name util/machine.c:57
    #2 0x55f073708dc0 in machine__init util/machine.c:106
    #3 0x55f07370903f in __machine__new_host util/machine.c:139
    #4 0x55f073709130 in machine__new_host util/machine.c:151
    #5 0x55f073445aff in do_test_code_reading tests/code-reading.c:657
    #6 0x55f073446f29 in test__code_reading tests/code-reading.c:811
    #7 0x55f0733af9f0 in run_test_child tests/builtin-test.c:257
    #8 0x55f07330b8f1 in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/lib/subcmd/run-command.c:127
    #9 0x55f0733b1eda in start_test tests/builtin-test.c:461
    #10 0x55f0733b2e46 in __cmd_test tests/builtin-test.c:561
    #11 0x55f0733b5814 in cmd_test tests/builtin-test.c:763
    #12 0x55f0732c6211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:351
    #13 0x55f0732c6acf in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:404
    #14 0x55f0732c7025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:448
    #15 0x55f0732c77cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:556
    #16 0x7fb03bb83249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 8 byte(s) in 1 object(s) allocated from:
    #0 0x7fb03cb989cf in __interceptor_malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x55f07372f51a in map__get util/map.h:189
    #2 0x55f0737339e9 in __maps__insert util/maps.c:479
    #3 0x55f073733e59 in maps__insert util/maps.c:515
    #4 0x55f073713b6d in machine__update_kernel_mmap util/machine.c:1537
    #5 0x55f0737140a0 in machine__create_kernel_maps util/machine.c:1578
    #6 0x55f073445bb1 in do_test_code_reading tests/code-reading.c:660
    #7 0x55f073446f29 in test__code_reading tests/code-reading.c:811
    #8 0x55f0733af9f0 in run_test_child tests/builtin-test.c:257
    #9 0x55f07330b8f1 in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/lib/subcmd/run-command.c:127
    #10 0x55f0733b1eda in start_test tests/builtin-test.c:461
    #11 0x55f0733b2e46 in __cmd_test tests/builtin-test.c:561
    #12 0x55f0733b5814 in cmd_test tests/builtin-test.c:763
    #13 0x55f0732c6211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:351
    #14 0x55f0732c6acf in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:404
    #15 0x55f0732c7025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:448
    #16 0x55f0732c77cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:556
    #17 0x7fb03bb83249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 8 byte(s) in 1 object(s) allocated from:
    #0 0x7fb03cb989cf in __interceptor_malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x55f073705dcc in map__get util/map.h:189
    #2 0x55f073713a8f in machine__update_kernel_mmap util/machine.c:1532
    #3 0x55f0737140a0 in machine__create_kernel_maps util/machine.c:1578
    #4 0x55f073445bb1 in do_test_code_reading tests/code-reading.c:660
    #5 0x55f073446f29 in test__code_reading tests/code-reading.c:811
    #6 0x55f0733af9f0 in run_test_child tests/builtin-test.c:257
    #7 0x55f07330b8f1 in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/lib/subcmd/run-command.c:127
    #8 0x55f0733b1eda in start_test tests/builtin-test.c:461
    #9 0x55f0733b2e46 in __cmd_test tests/builtin-test.c:561
    #10 0x55f0733b5814 in cmd_test tests/builtin-test.c:763
    #11 0x55f0732c6211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:351
    #12 0x55f0732c6acf in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:404
    #13 0x55f0732c7025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:448
    #14 0x55f0732c77cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:556
    #15 0x7fb03bb83249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 8 byte(s) in 1 object(s) allocated from:
    #0 0x7fb03cb989cf in __interceptor_malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x55f07368024a in dso__get util/dso.c:1607
    #2 0x55f07368576e in __dsos__add util/dsos.c:230
    #3 0x55f0736860c1 in __dsos__addnew_id util/dsos.c:337
    #4 0x55f073686184 in __dsos__findnew_id util/dsos.c:350
    #5 0x55f07368620e in dsos__findnew_id util/dsos.c:357
    #6 0x55f0737256ba in machine__findnew_dso_id util/machine.c:3188
    #7 0x55f073725707 in machine__findnew_dso util/machine.c:3193
    #8 0x55f07367c689 in machine__findnew_kernel util/dso.c:1338
    #9 0x55f07370ef54 in machine__get_kernel util/machine.c:969
    #10 0x55f073713c58 in machine__create_kernel_maps util/machine.c:1545
    #11 0x55f073709051 in __machine__new_host util/machine.c:141
    #12 0x55f073709130 in machine__new_host util/machine.c:151
    #13 0x55f073445aff in do_test_code_reading tests/code-reading.c:657
    #14 0x55f073446f29 in test__code_reading tests/code-reading.c:811
    #15 0x55f0733af9f0 in run_test_child tests/builtin-test.c:257
    #16 0x55f07330b8f1 in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/lib/subcmd/run-command.c:127
    #17 0x55f0733b1eda in start_test tests/builtin-test.c:461
    #18 0x55f0733b2e46 in __cmd_test tests/builtin-test.c:561
    #19 0x55f0733b5814 in cmd_test tests/builtin-test.c:763
    #20 0x55f0732c6211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:351
    #21 0x55f0732c6acf in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:404
    #22 0x55f0732c7025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:448
    #23 0x55f0732c77cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:556
    #24 0x7fb03bb83249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 8 byte(s) in 1 object(s) allocated from:
    #0 0x7fb03cb989cf in __interceptor_malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x55f07372f51a in map__get util/map.h:189
    #2 0x55f073733a98 in __maps__insert util/maps.c:481
    #3 0x55f073733e59 in maps__insert util/maps.c:515
    #4 0x55f073713b6d in machine__update_kernel_mmap util/machine.c:1537
    #5 0x55f0737140a0 in machine__create_kernel_maps util/machine.c:1578
    #6 0x55f073445bb1 in do_test_code_reading tests/code-reading.c:660
    #7 0x55f073446f29 in test__code_reading tests/code-reading.c:811
    #8 0x55f0733af9f0 in run_test_child tests/builtin-test.c:257
    #9 0x55f07330b8f1 in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/lib/subcmd/run-command.c:127
    #10 0x55f0733b1eda in start_test tests/builtin-test.c:461
    #11 0x55f0733b2e46 in __cmd_test tests/builtin-test.c:561
    #12 0x55f0733b5814 in cmd_test tests/builtin-test.c:763
    #13 0x55f0732c6211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:351
    #14 0x55f0732c6acf in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:404
    #15 0x55f0732c7025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:448
    #16 0x55f0732c77cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:556
    #17 0x7fb03bb83249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 8 byte(s) in 1 object(s) allocated from:
    #0 0x7fb03cb989cf in __interceptor_malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x55f07368024a in dso__get util/dso.c:1607
    #2 0x55f07372afc1 in map__init util/map.c:112
    #3 0x55f07372bb31 in map__new2 util/map.c:230
    #4 0x55f0737109d0 in __machine__create_kernel_maps util/machine.c:1184
    #5 0x55f073713d07 in machine__create_kernel_maps util/machine.c:1553
    #6 0x55f073445bb1 in do_test_code_reading tests/code-reading.c:660
    #7 0x55f073446f29 in test__code_reading tests/code-reading.c:811
    #8 0x55f0733af9f0 in run_test_child tests/builtin-test.c:257
    #9 0x55f07330b8f1 in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/lib/subcmd/run-command.c:127
    #10 0x55f0733b1eda in start_test tests/builtin-test.c:461
    #11 0x55f0733b2e46 in __cmd_test tests/builtin-test.c:561
    #12 0x55f0733b5814 in cmd_test tests/builtin-test.c:763
    #13 0x55f0732c6211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:351
    #14 0x55f0732c6acf in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:404
    #15 0x55f0732c7025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:448
    #16 0x55f0732c77cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:556
    #17 0x7fb03bb83249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 8 byte(s) in 1 object(s) allocated from:
    #0 0x7fb03cb989cf in __interceptor_malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x55f073731fb4 in maps__new util/maps.c:250
    #2 0x55f0737085a8 in machine__init util/machine.c:80
    #3 0x55f07370903f in __machine__new_host util/machine.c:139
    #4 0x55f073709130 in machine__new_host util/machine.c:151
    #5 0x55f073445aff in do_test_code_reading tests/code-reading.c:657
    #6 0x55f073446f29 in test__code_reading tests/code-reading.c:811
    #7 0x55f0733af9f0 in run_test_child tests/builtin-test.c:257
    #8 0x55f07330b8f1 in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/lib/subcmd/run-command.c:127
    #9 0x55f0733b1eda in start_test tests/builtin-test.c:461
    #10 0x55f0733b2e46 in __cmd_test tests/builtin-test.c:561
    #11 0x55f0733b5814 in cmd_test tests/builtin-test.c:763
    #12 0x55f0732c6211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:351
    #13 0x55f0732c6acf in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:404
    #14 0x55f0732c7025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:448
    #15 0x55f0732c77cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:556
    #16 0x7fb03bb83249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 6 byte(s) in 1 object(s) allocated from:
    #0 0x7fb03cb5077b in __interceptor_strdup ../../../../src/libsanitizer/asan/asan_interceptors.cpp:439
    #1 0x55f07375e872 in map__set_kallsyms_ref_reloc_sym util/session.c:2476
    #2 0x55f073714022 in machine__create_kernel_maps util/machine.c:1568
    #3 0x55f073445bb1 in do_test_code_reading tests/code-reading.c:660
    #4 0x55f073446f29 in test__code_reading tests/code-reading.c:811
    #5 0x55f0733af9f0 in run_test_child tests/builtin-test.c:257
    #6 0x55f07330b8f1 in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/lib/subcmd/run-command.c:127
    #7 0x55f0733b1eda in start_test tests/builtin-test.c:461
    #8 0x55f0733b2e46 in __cmd_test tests/builtin-test.c:561
    #9 0x55f0733b5814 in cmd_test tests/builtin-test.c:763
    #10 0x55f0732c6211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:351
    #11 0x55f0732c6acf in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:404
    #12 0x55f0732c7025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:448
    #13 0x55f0732c77cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:556
    #14 0x7fb03bb83249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 1 byte(s) in 1 object(s) allocated from:
    #0 0x7fb03cb5077b in __interceptor_strdup ../../../../src/libsanitizer/asan/asan_interceptors.cpp:439
    #1 0x55f073708cdb in machine__init util/machine.c:102
    #2 0x55f07370903f in __machine__new_host util/machine.c:139
    #3 0x55f073709130 in machine__new_host util/machine.c:151
    #4 0x55f073445aff in do_test_code_reading tests/code-reading.c:657
    #5 0x55f073446f29 in test__code_reading tests/code-reading.c:811
    #6 0x55f0733af9f0 in run_test_child tests/builtin-test.c:257
    #7 0x55f07330b8f1 in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/lib/subcmd/run-command.c:127
    #8 0x55f0733b1eda in start_test tests/builtin-test.c:461
    #9 0x55f0733b2e46 in __cmd_test tests/builtin-test.c:561
    #10 0x55f0733b5814 in cmd_test tests/builtin-test.c:763
    #11 0x55f0732c6211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:351
    #12 0x55f0732c6acf in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:404
    #13 0x55f0732c7025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:448
    #14 0x55f0732c77cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf.c:556
    #15 0x7fb03bb83249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

SUMMARY: AddressSanitizer: 24705356 byte(s) leaked in 303740 allocation(s).
 24: Object code reading                                             : FAILED!
2025-06-12 19:31:12 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 25 -v
 25: Sample parsing                                                  : Running (1 active)
 25: Sample parsing                                                  : Ok
2025-06-12 19:31:12 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 26 -v
 26: Use a dummy software event to keep tracking                     : Running (1 active)
 26: Use a dummy software event to keep tracking                     : Ok
2025-06-12 19:31:13 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 27 -v
 27: Parse with no sample_id_all bit set                             : Running (1 active)
 27: Parse with no sample_id_all bit set                             : Ok
2025-06-12 19:31:13 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 28 -v
 28: Filter hist entries                                             : Running (1 active)
 28: Filter hist entries                                             : Ok
2025-06-12 19:31:14 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 29 -v
 29: Lookup mmap thread                                              : Running (1 active)
 29: Lookup mmap thread                                              : Ok
2025-06-12 19:31:18 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 30 -v
 30: Share thread maps                                               : Running (1 active)
 30: Share thread maps                                               : Ok
2025-06-12 19:31:19 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 31 -v
 31: Sort output of hist entries                                     : Running (1 active)
 31: Sort output of hist entries                                     : Ok
2025-06-12 19:31:19 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 32 -v
 32: Cumulate child hist entries                                     : Running (1 active)
 32: Cumulate child hist entries                                     : Ok
2025-06-12 19:31:20 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 33 -v
 33: Filter fds with revents mask in a fdarray                       : Running (1 active)
 33: Filter fds with revents mask in a fdarray                       : Ok
2025-06-12 19:31:20 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 34 -v
 34: Add fd to a fdarray, making it autogrow                         : Running (1 active)
 34: Add fd to a fdarray, making it autogrow                         : Ok
2025-06-12 19:31:21 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 35 -v
 35: kmod_path__parse                                                : Running (1 active)
 35: kmod_path__parse                                                : Ok
2025-06-12 19:31:22 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 36 -v
 36: Thread map                                                      : Running (1 active)
 36: Thread map                                                      : Ok
2025-06-12 19:31:22 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 37 -v
 37: Session topology                                                : Running (1 active)
 37: Session topology                                                : Ok
2025-06-12 19:31:24 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 38 -v
 38: Synthesize thread map                                           : Running (1 active)
 38: Synthesize thread map                                           : Ok
2025-06-12 19:31:25 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 39 -v
 39: Remove thread map                                               : Running (1 active)
 39: Remove thread map                                               : Ok
2025-06-12 19:31:25 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 40 -v
 40: CPU map                                                         :
 40.1: Synthesize cpu map                                            : Running (5 active)
 40.1: Synthesize cpu map                                            : Ok
 40.2: Print cpu map                                                 : Ok
 40.3: Merge cpu map                                                 : Ok
 40.4: Intersect cpu map                                             : Ok
 40.5: Equal cpu map                                                 : Ok
2025-06-12 19:31:26 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 41 -v
 41: Synthesize stat config                                          : Running (1 active)
 41: Synthesize stat config                                          : Ok
2025-06-12 19:31:26 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 42 -v
 42: Synthesize stat                                                 : Running (1 active)
 42: Synthesize stat                                                 : Ok
2025-06-12 19:31:27 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 43 -v
 43: Synthesize stat round                                           : Running (1 active)
 43: Synthesize stat round                                           : Ok
2025-06-12 19:31:27 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 44 -v
 44: Synthesize attr update                                          : Running (1 active)
 44: Synthesize attr update                                          : Ok
2025-06-12 19:31:28 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 45 -v
 45: Event times                                                     : Running (1 active)
 45: Event times                                                     : Ok
2025-06-12 19:31:29 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 46 -v
 46: Read backward ring buffer                                       : Running (1 active)
 46: Read backward ring buffer                                       : Ok
2025-06-12 19:31:30 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 47 -v
 47: Probe SDT events                                                : Running (1 active)
 47: Probe SDT events                                                : Ok
2025-06-12 19:31:30 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 48 -v
 48: is_printable_array                                              : Running (1 active)
 48: is_printable_array                                              : Ok
2025-06-12 19:31:31 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 49 -v
 49: Print bitmap                                                    : Running (1 active)
 49: Print bitmap                                                    : Ok
2025-06-12 19:31:31 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-4c04654455c09b4905b84c350d88f718260a4cd4/tools/perf/perf test 50 -v
 50: perf hooks                                                      : Running (1 active)
 50: perf hooks                                                      : Ok



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250617/202506171537.d7e7e621-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

