Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A51F1849;
	Tue, 20 Aug 2024 05:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724130122; cv=fail; b=OP4dieke73RbrHcfp3UXP5kmmzAI6O1Od8aJ2cbNM2xzPbI1dTeErF3PPDAGFUO5RkDKnmQOZcBrcaCHPvSEXJ6A5eNHcKGOEhc7PwkURmP7APW1saceoRHLcVaa3UvqOxSsrSKQXeh+6zmBtjDddN3IVgk1mPvy7J2pgJ+l1h4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724130122; c=relaxed/simple;
	bh=H+afbCzkt8nHeLLrdfIq2gpOCJH8UwwMHc6LAP5n+lQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d5mwZADx7fDApG4dMBvNrfX4tJbnSZ7mOiVGLucPkl5CwG7cChHo1zbYNlZUW1+xeuL4fyJpJJgdL3TEBdxiStpvWZoM1OFrnhJS7vCWdTiPFLkov0os4HZFvxEBxjJEHk/aOHJbXHwi2nff1XbvXsxwrx/iH+FAt3AnpRR9mD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EyQLTLVT; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EyQLTLVT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724130119; x=1755666119;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=H+afbCzkt8nHeLLrdfIq2gpOCJH8UwwMHc6LAP5n+lQ=;
  b=EyQLTLVT+WzWdmZc+BdDpVpdu6YxPAEfPrvIc10bbYXYMpHPjYqjPqZz
   G8UHbxsuZk4Z43E0EE8DBlUwbK2FSNjEXftehNs1b7qad4w0vcjP8j15c
   GBdyMfXEac+n9Nqe5pvmkhpYgJYoXDggxjYBpaVSPbqRwHpdgDybP9QtS
   3MjBVh/I1clwVh816br1cx7s1rRituSiaB/DlrU99wSI37DXH1OONDgJ8
   GG3esBpEaa6KQHc7sWFkVuZIeGnNLzJdfNlbkcSb9XTW9iuefv27KjYPc
   5FegYcpZqTsn1iYZTJF9acXIouTQJpNY1DxSwrRNIZqi5CMacShHyAcFX
   A==;
X-CSE-ConnectionGUID: JfQwYrC+TimpPzv9JpkRCw==
X-CSE-MsgGUID: asNzz2prQLeAZ2D8mNvKYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="33827026"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="33827026"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 22:01:58 -0700
X-CSE-ConnectionGUID: KeFXAsVYRyizvMJExc7lgw==
X-CSE-MsgGUID: VUAog6mhSwqM646JpVIutA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="91325490"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Aug 2024 22:01:59 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 22:01:57 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 22:01:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 19 Aug 2024 22:01:57 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 22:01:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=phAc7Ij//NEBXQUCGpodGgDMiQGV7jVs7jJmhQUPwC6jgYVajR8NmCuQuNkXykWZPy2/BbuplZ9A2m6gbiQCMf7nyd1ayrTXDHp9AVZe/rlI0oLeOcW7qb9MwDc8NbGDWv4ySC1efTd3a6xLAs4uMC1u78jMfmWmN5whDPbRSwzrlHyVwXKxkcy4Ku5vrT5UDv+HsYM9HgOBTNyydTopdC+tpeQQ4PD3qNsIDO8vSYFbkVVLoniPCy1N18axQ1GIEaWrT7EmI8rXHmdwPz6IWvx0CL+6vZaZ+RwIJKcCOxoIX5fsvk7il6zCIc8mxMWwwp3u2c4rb0OKT9sEzHZa8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4DZQnUoIoP0FwYh9BoGCxDFFYKSj1gPLROFp3LOmfQ=;
 b=Sei7k+CCBbaVWxCEIpsBFirkSxKy0Fg7+jCJmmazKp9mC8LRKYgmJ405u7AhtVD+UnUiyxKXZZpnpLGib8uWmgesJC+hFNTv69AuoDtgwErp+pSlvDKaPUJ1YUk6UwPM00HXIL9hBfgajxOzntEwXaDe1+G20DDDkVCGYQrQljJbeP//csL5BSSdkY/1IXO9RBj/n0FXtYyivH+MPACtqK52AFMJgdY6oIvYWziUKzYdRmaER/4x5+dFrb+U9GKi4n7eJ4ETTcljPcmT02LeQb6o+kXeJfqgifMx9u5In4t8f0SmoCOmdvTQr+2cB387hmji7MBE+2BdF0gAgNZr0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SN7PR11MB7068.namprd11.prod.outlook.com (2603:10b6:806:29b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 05:01:53 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 05:01:53 +0000
Date: Tue, 20 Aug 2024 13:01:40 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Matthew Wilcox <willy@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH] perf: Remove setting of page->index and ->mapping
Message-ID: <ZsQjNARfe5caN7Rp@xsang-OptiPlex-9020>
References: <20240809201038.2648058-1-willy@infradead.org>
 <202408161305.a3a5158a-oliver.sang@intel.com>
 <Zr-Rm14B5AHZ4_UB@casper.infradead.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zr-Rm14B5AHZ4_UB@casper.infradead.org>
X-ClientProxiedBy: SG2PR06CA0186.apcprd06.prod.outlook.com (2603:1096:4:1::18)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SN7PR11MB7068:EE_
X-MS-Office365-Filtering-Correlation-Id: e7c40743-dea7-4793-b126-08dcc0d534f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?+56n4w28Ky3UqRovtohSOiXy+PCdwPfXyjs5RE7CpjTEx0wAwJmvQb9ADm?=
 =?iso-8859-1?Q?//6wvmd8r5v0HGffuz1k6yGjpDrAkls73MbsgPXcR5ozEAWjZN9hGbl9Ss?=
 =?iso-8859-1?Q?JEyMLQcWVhCmm+9Z2cbR6jTd4eiHc04PC441fx8hqYgWBNbCrABLVljlXA?=
 =?iso-8859-1?Q?2Co6keBgW6c890Lc4yGgb/IcVCxjJovA8jCeD4szlgqu86S57qb7FPKm4E?=
 =?iso-8859-1?Q?lPDptNdZm1lvmg/bE0jyfXoZPkOSMSFImLDmN24lNUfCkDR8NAVnDMHqnP?=
 =?iso-8859-1?Q?4RneKYU3c+UBPIsiA6MyMXI7avd6z8QtwTgc07i9hvb2d3r+hCK7x7TM1r?=
 =?iso-8859-1?Q?UmRZY74xUr/qL5b1BANslHOh37egcGUrf+Q8A8qGiw2Ws3hYNw9Okm+92v?=
 =?iso-8859-1?Q?m80m1HhvfSe1lhH+c08mCfiSFP2mSGxXeO+Ct3h/12hCxSrIXyGuErTrr1?=
 =?iso-8859-1?Q?kEVdTVFdCZfLMCH5Ljpuu5ITWygN/S+uU4MePgfkO9Ri0utfAmwVes5OSA?=
 =?iso-8859-1?Q?5CCJYN0yadvGiq/fSVj4SUwdKwPcCdPXsJ+WnsfT9XYCbqaoHp51uis+iM?=
 =?iso-8859-1?Q?35OiAsOtXl907dtm2YPne37PhbOQ3sp03qPy49CUE8yB2UVeSm9TsMvlBn?=
 =?iso-8859-1?Q?YVgqzbnK/bi/+TJshZcITSymM3lfWKIcH8YN1KoI1tZDE4+MCzs9qM4DAV?=
 =?iso-8859-1?Q?NCVOC6B8CDOlUh+dQmhihMTv8Ng0ltKb0Aif2wFMFNXJ7RYIp3GreLoDiC?=
 =?iso-8859-1?Q?vaLhaA+qkgTDDiuOh9AIIwCmMCTq3UCo1Mymi6D0y5BfFtFieaNSO0JesE?=
 =?iso-8859-1?Q?vG31+QLI8j2pamW5aCAbVWWOqw6Yaf3ZjBBheSds8++g6HG9EIqGoTx4Ly?=
 =?iso-8859-1?Q?UhsfJP4Zv4JpmkkgGvYmTkqeL252zArMsxFffNyipkMEkabvyh45qxOVxH?=
 =?iso-8859-1?Q?yEev4hZ/QJTdNkbu/QMybRoqu4/xg+n1EnSVCFflPqrcIlF4lJ0hpVTv5G?=
 =?iso-8859-1?Q?IE1662UoAT9Gr1Uwcla5Izuk5xuBtlZYLn4c7zYh60eGiYX1FxEGF6ot6T?=
 =?iso-8859-1?Q?KeeWBcCX9CKWzSaPvJhpHd8i2hJh6M5R3qD6zqvhrFSJgJDj+ucPwSGTaI?=
 =?iso-8859-1?Q?pvrgRlpt0I/G2eM+RFD2IslY6KdxKKBjlI5ry9XS4y6KioK2PBy8Dqv4qt?=
 =?iso-8859-1?Q?79LahJX0W/8Y7yJCyY2PM5I4ARI8W4Aqp0P/yZ+3Anqf1lmFT8lkjOuz+Q?=
 =?iso-8859-1?Q?nXUJmPPtesVFSAalNK0odvuJFV59+Xn8egh9ITkTnTj0jc4Wbje3A11nfS?=
 =?iso-8859-1?Q?CiWDtIB1/Q53DZZazFJXbGrNiBIMfrNx0oR1JhdyoSKIo4UEuZTdG9Lj8C?=
 =?iso-8859-1?Q?Hu/COTxpRXFWTPaMNdmRrAZf4lGbRufA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ZUMyvVvqNkljbGDPYgmFVjVuAXJVj7c/ChYUMTgKWsrg1RpIIZrvqEyWr1?=
 =?iso-8859-1?Q?fNgMeRECZ/nIawATOKQMPKvZefl+kCeRoOEYBSYFYzEdjXBlw3xlZHu7G/?=
 =?iso-8859-1?Q?6M35UJMWR25DzEZvC724uVTpCYYEGZ5ujxhaTj9f1baVDgdZC/1MuStMis?=
 =?iso-8859-1?Q?kUr/ADNLbMzLM/7kB3KP6DoXkxVY3AbAwYny8WAjK3n3zN0cJSnL4i7PoX?=
 =?iso-8859-1?Q?3bsghtRT0CY2Piaosg6eyIiMSTgTl36HRHIa9Vy1bTu++qG0hdOoCMXMgj?=
 =?iso-8859-1?Q?pcZSwzlYfZjz40Zei/yCzFH6gSSLhXTae81OzFwJtHlDKQ4vDgdYTLh99w?=
 =?iso-8859-1?Q?dtERZ5CwW9wBKc14kfkXV6am5CMymqbTE97/AeXwE988C3zSh6Oser8/aj?=
 =?iso-8859-1?Q?eZ6Y80C6MyirdWJV1fyUMdkRa8vlXAq5Kt431KKKQelEU35lZiL6q+72An?=
 =?iso-8859-1?Q?eirGG7utqlnv0K9HzQsADhvKu8kB/RyIaZdFPzrl2MFcQxm6Qh6iEJH8Yx?=
 =?iso-8859-1?Q?PN+sC+cG9sdY4jP/bns8qQW9Gs1H6HumqVcXbuXUZB42wVclNlKlkDDLwt?=
 =?iso-8859-1?Q?5oW7UT+nx1poL3L3NJJU4WFTEfmmYOTrWM25P71+FgAdNAZ7XK1QvJfdf6?=
 =?iso-8859-1?Q?FaIW8fV0rh0pOMXW2ZxyWY4dsXnGTJgww8OpVsnZvNhmqfXr0FWQvP5i+J?=
 =?iso-8859-1?Q?2MBU8jrZPZzJlbwDoj/9pL6TpuTBaETUR0edrh0J9bEmxZMVpvtLcg/R6A?=
 =?iso-8859-1?Q?Ejitkib3dpucqCYDi48xM4QSHiZErxvpa+ZG1Y+kJbh1RVI051btym5wwW?=
 =?iso-8859-1?Q?lMCJdvxOAeZQ5MNOtVIRRhDvbgM2tVdti7dCG0uL5es06qsTRuOjJTc+9i?=
 =?iso-8859-1?Q?VD5xKy3rzFXCyJ9RviXGJlBksmwssCjsXDmckm3XJEFQ0jZMWyu7iaO2z4?=
 =?iso-8859-1?Q?lzD08SyJ1fa9VD69/q6d+sWzOLfmwIMdnZZnV+vVyB5IfKjhati8qJbv40?=
 =?iso-8859-1?Q?7Af3L76Cc3/zV6aPO8m6LOldmOl0mBzmvzcofDFrrha0qWaR34VXJBJnEP?=
 =?iso-8859-1?Q?ldd+ZWYvU8kttvXV1RU5lZuoHZPytvBgO2ys5RI3PkHL9yrRcJYdl4cR0P?=
 =?iso-8859-1?Q?Qsw+BXbuKmopBpFb1J+BkeOFvjxGL3JoeaCtxtiNcHI0opuJIlKKxDG+qu?=
 =?iso-8859-1?Q?qHM+Mi8qlA1ExcC43KQpJ3byP/n17swVdJzYfRn1hhK+8f6O/d1o4V8wcA?=
 =?iso-8859-1?Q?iaJmsQJl5WzjXZl5lnno/hJnI7+uEcq3QkVdwsIA8uewjGwd2bBzB7+C6A?=
 =?iso-8859-1?Q?d4wLwxhwgqMePkBioYoFypTtOlfBhVsenn6vUNyiUXMW2qCDaSw2C0iicI?=
 =?iso-8859-1?Q?9ZunqNr2eXUqNmRFaF5KabfqF6590CDiXdtdyZfzcP4v0lCQ+bmd6wDQUb?=
 =?iso-8859-1?Q?Xpx/3zHazJ7H0sh5lMmjB7KkFU1zFE/klzQTXE+0S5wgBWD509ztxvMVc4?=
 =?iso-8859-1?Q?r0/y/GzDtGEjrNmETNo/tekl5wiMgqvwdQ6jVn4rJE3OVm5T+KtaAT66wL?=
 =?iso-8859-1?Q?G3xATnPdX8r61guYcv0jWBiaTT1bFuwmNUt13XP1Tsuwj2tZx1BiaDFFNK?=
 =?iso-8859-1?Q?/pMP62RSHNpw/lzmXcCvODb7jA6pTgCunEPPihzMdsyj5bCPI5CfLluQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e7c40743-dea7-4793-b126-08dcc0d534f4
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 05:01:53.4336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MVkE5EyMw0BoxuIE3ALjlb1LZe4jOs5btf6dkhW+bCoD757TeoVKgO1fpBXfxFnVFdm2p53E6VDX5xku8hJXXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7068
X-OriginatorOrg: intel.com

hi, Matthew Wilcox,

On Fri, Aug 16, 2024 at 06:51:23PM +0100, Matthew Wilcox wrote:
> On Fri, Aug 16, 2024 at 02:35:39PM +0800, kernel test robot wrote:
> > from commit message, it seems just some useless setting have been removed.
> > but quite some performance regression bisect by our bot finally point to this
> > change (already removed some not so significant changes to avoid this report
> > mail is too long).
> > 
> > we don't have enough knowledge to explain these, so just report FYI.
> > if you have any suggestion for our tests or need us run more tests, please
> > just let us know. thanks a lot!
> 
> Can you try this replacement patch?
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index c973e3c11e03..bc12f4fb7fa9 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6221,10 +6221,9 @@ static vm_fault_t perf_mmap_fault(struct vm_fault *vmf)
>  		goto unlock;
>  
>  	get_page(vmf->page);
> -	vmf->page->mapping = vmf->vma->vm_file->f_mapping;
> -	vmf->page->index   = vmf->pgoff;
> +	lock_page(vmf->page);
>  
> -	ret = 0;
> +	ret = VM_FAULT_LOCKED;
>  unlock:
>  	rcu_read_unlock();
>  
> 

still similar regression.

I applied your replacement patch as 0c365693d5482c855ba9acd45a9cffa4e12fc4c1 [1]
still upon cb1898f58e ("perf annotate-data: Support --skip-empty option") as [2]

I picked 2 regression to check.

for first one,

before replacement:

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/1HDD/btrfs/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/dirmany/stress-ng/60s

commit: 
  cb1898f58e ("perf annotate-data: Support --skip-empty option")
  a9ac22fb7a ("perf: Remove setting of page->index and ->mapping")

cb1898f58e0f175d a9ac22fb7ac3486a5bd89c25a2f 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    703.32           -28.3%     504.06 ±  3%  stress-ng.dirmany.files_removed_per_sec

after replacement (full comparison is as [3]):

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/1HDD/btrfs/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/dirmany/stress-ng/60s

commit:
  cb1898f58e ("perf annotate-data: Support --skip-empty option")
  0c365693d5 <-- replacement patch

cb1898f58e0f175d 0c365693d5482c855ba9acd45a9
---------------- ---------------------------
         %stddev     %change         %stddev
             \          |                \
    703.32           -28.9%     499.74        stress-ng.dirmany.files_removed_per_sec


for second one,

before replacement:

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/process/100%/debian-12-x86_64-20240206.cgz/lkp-skl-fpga01/context_switch1/will-it-scale

commit: 
  cb1898f58e ("perf annotate-data: Support --skip-empty option")
  a9ac22fb7a ("perf: Remove setting of page->index and ->mapping")

cb1898f58e0f175d a9ac22fb7ac3486a5bd89c25a2f 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    178341           -61.9%      67890 ±  4%  will-it-scale.per_process_ops

after replacement (full comparison is as [4]):

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/process/100%/debian-12-x86_64-20240206.cgz/lkp-skl-fpga01/context_switch1/will-it-scale

commit:
  cb1898f58e ("perf annotate-data: Support --skip-empty option")
  0c365693d5 <-- replacement patch

cb1898f58e0f175d 0c365693d5482c855ba9acd45a9
---------------- ---------------------------
         %stddev     %change         %stddev
             \          |                \
    178341           -61.2%      69248 ±  5%  will-it-scale.per_process_ops


[1]
commit 0c365693d5482c855ba9acd45a9cffa4e12fc4c1
Author: 0day robot <lkp@intel.com>
Date:   Sun Aug 18 16:18:03 2024 +0800

    replacement for a9ac22fb7a from Matthew Wilcox <willy@infradead.org>

diff --git a/kernel/events/core.c b/kernel/events/core.c
index aa3450bdc2276..b102c404526e9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6221,10 +6221,9 @@ static vm_fault_t perf_mmap_fault(struct vm_fault *vmf)
                goto unlock;

        get_page(vmf->page);
-       vmf->page->mapping = vmf->vma->vm_file->f_mapping;
-       vmf->page->index   = vmf->pgoff;
+       lock_page(vmf->page);

-       ret = 0;
+       ret = VM_FAULT_LOCKED;
 unlock:
        rcu_read_unlock();

[2]
$ git log --oneline --graph 0c365693d5482
* 0c365693d5482 replacement for a9ac22fb7a from Matthew Wilcox <willy@infradead.org>
* cb1898f58e0f1 perf annotate-data: Support --skip-empty option
...


[3]
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/1HDD/btrfs/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/dirmany/stress-ng/60s

commit:
  cb1898f58e ("perf annotate-data: Support --skip-empty option")
  0c365693d5 <-- replacement patch

cb1898f58e0f175d 0c365693d5482c855ba9acd45a9
---------------- ---------------------------
         %stddev     %change         %stddev
             \          |                \
   8914265 ±  4%     -14.0%    7667270 ±  3%  cpuidle..usage
      1.03 ±  3%     -11.3%       0.91 ±  4%  iostat.cpu.iowait
    530992 ±  2%     -10.8%     473754 ±  5%  numa-numastat.node0.numa_hit
     37575 ± 10%     -87.6%       4642 ± 11%  meminfo.Active(anon)
    121149 ±  3%     -28.8%      86296        meminfo.Shmem
      1.04 ±  3%      -0.1        0.92 ±  4%  mpstat.cpu.all.iowait%
      0.71 ±  4%      +0.2        0.90 ±  6%  mpstat.cpu.all.usr%
    422.17 ±  4%     -37.7%     263.12 ±  7%  time.percent_of_cpu_this_job_got
    267.72 ±  5%     -31.5%     183.32 ±  4%  time.system_time
   6952736 ±  4%     -17.3%    5749237 ±  4%  time.voluntary_context_switches
      0.68 ±  3%      -9.7%       0.62 ±  4%  vmstat.procs.b
    238142 ±  6%     -24.9%     178933 ±  3%  vmstat.system.cs
    157186 ±  7%     +51.5%     238200 ±  3%  vmstat.system.in
     16677 ± 10%     -88.3%       1957 ± 43%  numa-meminfo.node0.Active(anon)
      5262 ± 33%     +59.2%       8375 ±  7%  numa-meminfo.node0.PageTables
     20916 ± 15%     -87.2%       2687 ± 39%  numa-meminfo.node1.Active(anon)
      6573 ± 26%     -43.9%       3690 ± 15%  numa-meminfo.node1.PageTables
     69830 ± 47%     -95.7%       3023 ± 41%  numa-meminfo.node1.Shmem
      1586 ± 12%    -100.0%       0.00        perf-c2c.DRAM.local
     13101 ± 15%    -100.0%       0.00        perf-c2c.DRAM.remote
     12067 ± 15%    -100.0%       0.00        perf-c2c.HITM.local
      8050 ± 16%    -100.0%       0.00        perf-c2c.HITM.remote
     20118 ± 15%    -100.0%       0.00        perf-c2c.HITM.total
     67.43 ±  3%     -11.9%      59.40 ±  2%  stress-ng.dirmany.%_of_time_creating_files
     32.57 ±  6%     +24.7%      40.60 ±  4%  stress-ng.dirmany.%_of_time_removing_file
    703.32           -28.9%     499.74        stress-ng.dirmany.files_removed_per_sec
     14642 ±  5%     -11.3%      12984 ±  5%  stress-ng.dirmany.ops_per_sec
    422.17 ±  4%     -37.7%     263.12 ±  7%  stress-ng.time.percent_of_cpu_this_job_got
    267.72 ±  5%     -31.5%     183.32 ±  4%  stress-ng.time.system_time
   6952736 ±  4%     -17.3%    5749237 ±  4%  stress-ng.time.voluntary_context_switches
      4177 ± 10%     -88.3%     489.29 ± 43%  numa-vmstat.node0.nr_active_anon
      1313 ± 33%     +59.6%       2096 ±  7%  numa-vmstat.node0.nr_page_table_pages
      4177 ± 10%     -88.3%     489.29 ± 43%  numa-vmstat.node0.nr_zone_active_anon
    530566 ±  2%     -10.8%     473184 ±  5%  numa-vmstat.node0.numa_hit
      5236 ± 15%     -87.2%     672.21 ± 39%  numa-vmstat.node1.nr_active_anon
      1640 ± 26%     -43.6%     924.79 ± 15%  numa-vmstat.node1.nr_page_table_pages
     17423 ± 47%     -95.7%     755.96 ± 41%  numa-vmstat.node1.nr_shmem
      5236 ± 15%     -87.2%     672.21 ± 39%  numa-vmstat.node1.nr_zone_active_anon
      9403 ± 10%     -87.7%       1161 ± 10%  proc-vmstat.nr_active_anon
     27583            -2.1%      27001        proc-vmstat.nr_mapped
     30307 ±  3%     -28.7%      21607        proc-vmstat.nr_shmem
    340687            -2.8%     331094        proc-vmstat.nr_slab_reclaimable
      9403 ± 10%     -87.7%       1161 ± 10%  proc-vmstat.nr_zone_active_anon
    278.50 ± 16%    +269.3%       1028 ±128%  proc-vmstat.numa_hint_faults_local
   1037475            -5.2%     983767 ±  2%  proc-vmstat.numa_hit
    971211            -4.3%     929901 ±  2%  proc-vmstat.numa_local
     66223           -18.7%      53867        proc-vmstat.numa_other
   1392679            -4.5%    1330429        proc-vmstat.pgalloc_normal
    263934 ±  3%  +91013.5%  2.405e+08 ±  6%  proc-vmstat.pgfault
    840859 ±  2%     -21.1%     663807 ±  9%  proc-vmstat.pgfree
     76822 ± 10%     +69.3%     130087 ± 16%  sched_debug.cfs_rq:/.avg_vruntime.max
      8327 ± 16%    +127.9%      18977 ± 12%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      2.25 ± 27%    -100.0%       0.00        sched_debug.cfs_rq:/.load_avg.min
     76822 ± 10%     +69.3%     130087 ± 16%  sched_debug.cfs_rq:/.min_vruntime.max
      8327 ± 16%    +127.9%      18978 ± 12%  sched_debug.cfs_rq:/.min_vruntime.stddev
    217.83 ± 45%     +67.1%     364.00 ± 31%  sched_debug.cfs_rq:/.removed.runnable_avg.max
    217.83 ± 45%     +67.1%     364.00 ± 31%  sched_debug.cfs_rq:/.removed.util_avg.max
      1018 ±  9%     +24.0%       1262 ±  9%  sched_debug.cfs_rq:/.runnable_avg.max
     19.67 ± 57%    -100.0%       0.00        sched_debug.cfs_rq:/.runnable_avg.min
    217.81 ±  3%     +31.7%     286.94 ±  7%  sched_debug.cfs_rq:/.runnable_avg.stddev
      1006 ±  7%     +23.3%       1240 ±  8%  sched_debug.cfs_rq:/.util_avg.max
     19.75 ± 57%    -100.0%       0.00        sched_debug.cfs_rq:/.util_avg.min
    216.49 ±  3%     +31.9%     285.45 ±  7%  sched_debug.cfs_rq:/.util_avg.stddev
     28.42 ± 11%     +71.2%      48.67 ± 10%  sched_debug.cfs_rq:/.util_est.avg
    447.25 ± 12%     +72.5%     771.44 ±  2%  sched_debug.cfs_rq:/.util_est.max
     90.88 ±  9%     +90.2%     172.82 ±  4%  sched_debug.cfs_rq:/.util_est.stddev
    415102 ±  6%     +23.8%     513771 ±  2%  sched_debug.cpu.avg_idle.avg
     38570 ± 20%     +63.8%      63180 ± 11%  sched_debug.cpu.avg_idle.min
    154552 ±  6%     +44.4%     223103 ±  3%  sched_debug.cpu.avg_idle.stddev
    101993 ± 13%     -30.4%      70952 ± 11%  sched_debug.cpu.nr_switches.avg
    113676 ± 14%     -24.1%      86266 ± 10%  sched_debug.cpu.nr_switches.max
     93486 ± 14%     -83.6%      15356 ± 41%  sched_debug.cpu.nr_switches.min
      3929 ± 34%    +261.7%      14212 ± 19%  sched_debug.cpu.nr_switches.stddev
      2.27 ±  2%     -64.8%       0.80 ±  4%  perf-stat.i.MPKI
 1.604e+09 ±  2%    +131.1%  3.705e+09 ±  2%  perf-stat.i.branch-instructions
      2.33 ±  2%      -1.6        0.74 ± 10%  perf-stat.i.branch-miss-rate%
  36868744 ±  3%     -27.5%   26723115 ±  9%  perf-stat.i.branch-misses
  23122994 ±  4%     -14.7%   19730202 ±  4%  perf-stat.i.cache-misses
  64086754 ±  3%     -16.2%   53705975 ±  4%  perf-stat.i.cache-references
    244416 ±  6%     -24.8%     183752 ±  3%  perf-stat.i.context-switches
      1.90 ±  3%     -39.1%       1.16        perf-stat.i.cpi
 2.112e+10 ±  2%      +7.6%  2.272e+10 ±  3%  perf-stat.i.cpu-cycles
     10537 ±  6%     -72.8%       2868 ± 48%  perf-stat.i.cpu-migrations
      1308 ± 11%    +395.6%       6487 ± 11%  perf-stat.i.cycles-between-cache-misses
 8.205e+09 ±  2%    +118.7%  1.795e+10 ±  2%  perf-stat.i.instructions
      0.88 ±  3%     +12.0%       0.99        perf-stat.i.ipc
      3.78 ±  6%   +2738.0%     107.39        perf-stat.i.metric.K/sec
      3035 ±  2%  +1.1e+05%    3345880        perf-stat.i.minor-faults
      3035 ±  2%  +1.1e+05%    3345880        perf-stat.i.page-faults
      2.82 ±  2%     -60.9%       1.10 ±  3%  perf-stat.overall.MPKI
      2.30 ±  2%      -1.6        0.72 ±  8%  perf-stat.overall.branch-miss-rate%
      2.58 ±  2%     -50.8%       1.27        perf-stat.overall.cpi
    915.45 ±  4%     +25.9%       1152 ±  3%  perf-stat.overall.cycles-between-cache-misses
      0.39 ±  2%    +103.2%       0.79        perf-stat.overall.ipc
 1.579e+09 ±  2%    +131.3%  3.652e+09 ±  2%  perf-stat.ps.branch-instructions
  36312783 ±  3%     -27.5%   26326319 ±  9%  perf-stat.ps.branch-misses
  22753189 ±  4%     -14.4%   19465477 ±  4%  perf-stat.ps.cache-misses
  63076730 ±  3%     -16.0%   53010328 ±  4%  perf-stat.ps.cache-references
    240154 ±  6%     -24.5%     181197 ±  3%  perf-stat.ps.context-switches
  2.08e+10 ±  2%      +7.8%  2.242e+10 ±  3%  perf-stat.ps.cpu-cycles
     10351 ±  6%     -72.6%       2838 ± 48%  perf-stat.ps.cpu-migrations
 8.078e+09 ±  2%    +119.0%  1.769e+10 ±  2%  perf-stat.ps.instructions
      2990 ±  2%  +1.1e+05%    3296800        perf-stat.ps.minor-faults
      2990 ±  2%  +1.1e+05%    3296800        perf-stat.ps.page-faults
 5.224e+11 ±  2%    +141.6%  1.262e+12 ±  3%  perf-stat.total.instructions
     24.93 ± 18%     -24.9        0.00        perf-profile.calltrace.cycles-pp.common_startup_64
     24.55 ± 56%     -24.5        0.00        perf-profile.calltrace.cycles-pp.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.btrfs_write_marked_extents.btrfs_write_and_wait_transaction
     24.55 ± 56%     -24.5        0.00        perf-profile.calltrace.cycles-pp.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.btrfs_write_marked_extents.btrfs_write_and_wait_transaction.btrfs_commit_transaction
     24.54 ± 56%     -24.5        0.00        perf-profile.calltrace.cycles-pp.btree_write_cache_pages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.btrfs_write_marked_extents
     24.51 ± 56%     -24.5        0.00        perf-profile.calltrace.cycles-pp.fsync
     24.50 ± 56%     -24.5        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.fsync
     24.50 ± 56%     -24.5        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fsync
     24.49 ± 56%     -24.5        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_fsync.do_syscall_64.entry_SYSCALL_64_after_hwframe.fsync
     24.49 ± 56%     -24.5        0.00        perf-profile.calltrace.cycles-pp.btrfs_sync_file.__x64_sys_fsync.do_syscall_64.entry_SYSCALL_64_after_hwframe.fsync
     24.48 ± 56%     -24.5        0.00        perf-profile.calltrace.cycles-pp.btrfs_commit_transaction.btrfs_sync_file.__x64_sys_fsync.do_syscall_64.entry_SYSCALL_64_after_hwframe
     24.43 ± 57%     -24.4        0.00        perf-profile.calltrace.cycles-pp.btrfs_write_and_wait_transaction.btrfs_commit_transaction.btrfs_sync_file.__x64_sys_fsync.do_syscall_64
     24.43 ± 57%     -24.4        0.00        perf-profile.calltrace.cycles-pp.btrfs_write_marked_extents.btrfs_write_and_wait_transaction.btrfs_commit_transaction.btrfs_sync_file.__x64_sys_fsync
     24.41 ± 57%     -24.4        0.00        perf-profile.calltrace.cycles-pp.__filemap_fdatawrite_range.btrfs_write_marked_extents.btrfs_write_and_wait_transaction.btrfs_commit_transaction.btrfs_sync_file
     23.94 ± 56%     -23.9        0.00        perf-profile.calltrace.cycles-pp.submit_eb_page.btree_write_cache_pages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range
     23.50 ± 16%     -23.5        0.00        perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
     23.49 ± 16%     -23.5        0.00        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
     23.48 ± 16%     -23.5        0.00        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     22.12 ± 17%     -22.1        0.00        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     21.95 ± 19%     -22.0        0.00        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     21.61 ± 20%     -21.6        0.00        perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     20.64 ± 17%     -20.6        0.00        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     20.29 ± 57%     -20.3        0.00        perf-profile.calltrace.cycles-pp.btrfs_submit_bio.submit_eb_page.btree_write_cache_pages.do_writepages.filemap_fdatawrite_wbc
     20.29 ± 57%     -20.3        0.00        perf-profile.calltrace.cycles-pp.btrfs_submit_chunk.btrfs_submit_bio.submit_eb_page.btree_write_cache_pages.do_writepages
     17.17 ± 57%     -17.2        0.00        perf-profile.calltrace.cycles-pp.btree_csum_one_bio.btrfs_submit_chunk.btrfs_submit_bio.submit_eb_page.btree_write_cache_pages
     14.62 ± 31%     -14.6        0.00        perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
     14.62 ± 31%     -14.6        0.00        perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
     14.62 ± 31%     -14.6        0.00        perf-profile.calltrace.cycles-pp.ret_from_fork_asm
     13.30 ± 27%     -13.3        0.00        perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
     12.54 ± 58%     -12.5        0.00        perf-profile.calltrace.cycles-pp.btrfs_check_leaf.btree_csum_one_bio.btrfs_submit_chunk.btrfs_submit_bio.submit_eb_page
     12.31 ± 58%     -12.3        0.00        perf-profile.calltrace.cycles-pp.__btrfs_check_leaf.btrfs_check_leaf.btree_csum_one_bio.btrfs_submit_chunk.btrfs_submit_bio
     11.98 ± 32%     -12.0        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
     10.42 ± 37%     -10.4        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      8.48 ± 57%      -8.5        0.00        perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      7.77 ± 62%      -7.8        0.00        perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      7.46 ± 58%      -7.5        0.00        perf-profile.calltrace.cycles-pp.check_leaf_item.__btrfs_check_leaf.btrfs_check_leaf.btree_csum_one_bio.btrfs_submit_chunk
      5.40 ± 69%      -5.4        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_posted_msi_notification.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      4.81 ± 57%      -4.8        0.00        perf-profile.calltrace.cycles-pp.check_dir_item.check_leaf_item.__btrfs_check_leaf.btrfs_check_leaf.btree_csum_one_bio
      4.62 ± 36%      -4.6        0.00        perf-profile.calltrace.cycles-pp.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
      4.52 ± 55%      -4.5        0.00        perf-profile.calltrace.cycles-pp.csum_tree_block.btree_csum_one_bio.btrfs_submit_chunk.btrfs_submit_bio.submit_eb_page
      4.51 ± 56%      -4.5        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      4.49 ± 56%      -4.5        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.46 ± 55%      -4.5        0.00        perf-profile.calltrace.cycles-pp.crc32c_pcl_intel_update.csum_tree_block.btree_csum_one_bio.btrfs_submit_chunk.btrfs_submit_bio
      4.46 ± 55%      -4.5        0.00        perf-profile.calltrace.cycles-pp.crc_pcl.crc32c_pcl_intel_update.csum_tree_block.btree_csum_one_bio.btrfs_submit_chunk
     55.50 ± 15%     -55.5        0.00        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     55.46 ± 15%     -55.5        0.00        perf-profile.children.cycles-pp.do_syscall_64
     28.46 ± 53%     -28.5        0.00        perf-profile.children.cycles-pp.btrfs_commit_transaction
     24.93 ± 18%     -24.9        0.00        perf-profile.children.cycles-pp.common_startup_64
     24.93 ± 18%     -24.9        0.00        perf-profile.children.cycles-pp.cpu_startup_entry
     24.92 ± 18%     -24.9        0.00        perf-profile.children.cycles-pp.do_idle
     24.61 ± 55%     -24.6        0.00        perf-profile.children.cycles-pp.btrfs_write_and_wait_transaction
     24.61 ± 55%     -24.6        0.00        perf-profile.children.cycles-pp.btrfs_write_marked_extents
     24.60 ± 55%     -24.6        0.00        perf-profile.children.cycles-pp.__filemap_fdatawrite_range
     24.60 ± 55%     -24.6        0.00        perf-profile.children.cycles-pp.btree_write_cache_pages
     24.60 ± 55%     -24.6        0.00        perf-profile.children.cycles-pp.do_writepages
     24.60 ± 55%     -24.6        0.00        perf-profile.children.cycles-pp.filemap_fdatawrite_wbc
     24.51 ± 56%     -24.5        0.00        perf-profile.children.cycles-pp.fsync
     24.49 ± 56%     -24.5        0.00        perf-profile.children.cycles-pp.__x64_sys_fsync
     24.49 ± 56%     -24.5        0.00        perf-profile.children.cycles-pp.btrfs_sync_file
     24.00 ± 55%     -24.0        0.00        perf-profile.children.cycles-pp.submit_eb_page
     23.53 ± 19%     -23.5        0.00        perf-profile.children.cycles-pp.cpuidle_idle_call
     23.50 ± 16%     -23.5        0.00        perf-profile.children.cycles-pp.start_secondary
     22.05 ± 19%     -22.1        0.00        perf-profile.children.cycles-pp.cpuidle_enter
     22.00 ± 19%     -22.0        0.00        perf-profile.children.cycles-pp.cpuidle_enter_state
     21.66 ± 20%     -21.7        0.00        perf-profile.children.cycles-pp.acpi_idle_enter
     21.63 ± 20%     -21.6        0.00        perf-profile.children.cycles-pp.acpi_safe_halt
     20.41 ± 55%     -20.4        0.00        perf-profile.children.cycles-pp.btrfs_submit_bio
     20.41 ± 55%     -20.4        0.00        perf-profile.children.cycles-pp.btrfs_submit_chunk
     17.35 ± 55%     -17.4        0.00        perf-profile.children.cycles-pp.btree_csum_one_bio
     14.74 ± 31%     -14.7        0.00        perf-profile.children.cycles-pp.ret_from_fork_asm
     14.71 ± 31%     -14.7        0.00        perf-profile.children.cycles-pp.ret_from_fork
     14.62 ± 31%     -14.6        0.00        perf-profile.children.cycles-pp.kthread
     12.66 ± 56%     -12.7        0.00        perf-profile.children.cycles-pp.__btrfs_check_leaf
     12.66 ± 56%     -12.7        0.00        perf-profile.children.cycles-pp.btrfs_check_leaf
      8.52 ± 29%      -8.5        0.00        perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      8.48 ± 57%      -8.5        0.00        perf-profile.children.cycles-pp.worker_thread
      7.78 ± 62%      -7.8        0.00        perf-profile.children.cycles-pp.process_one_work
      7.62 ± 56%      -7.6        0.00        perf-profile.children.cycles-pp.check_leaf_item
      7.50 ± 34%      -7.5        0.00        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      5.58 ± 53%      -5.6        0.00        perf-profile.children.cycles-pp.crc32c_pcl_intel_update
      5.20 ± 46%      -5.2        0.00        perf-profile.children.cycles-pp.__irq_exit_rcu
      5.11 ± 47%      -5.1        0.00        perf-profile.children.cycles-pp.handle_softirqs
      5.09 ± 54%      -5.1        0.00        perf-profile.children.cycles-pp.check_dir_item
      4.74 ± 34%      -4.7        0.00        perf-profile.children.cycles-pp.sysvec_call_function_single
      4.57 ± 53%      -4.6        0.00        perf-profile.children.cycles-pp.csum_tree_block
      4.54 ± 70%      -4.5        0.00        perf-profile.children.cycles-pp.asm_sysvec_posted_msi_notification
      4.49 ± 53%      -4.5        0.00        perf-profile.children.cycles-pp.crc_pcl
      4.45 ± 56%      -4.5        0.00        perf-profile.children.cycles-pp.btrfs_get_32
      4.06 ± 34%      -4.1        0.00        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      8.89 ± 14%      -8.9        0.00        perf-profile.self.cycles-pp.acpi_safe_halt
      4.47 ± 53%      -4.5        0.00        perf-profile.self.cycles-pp.crc_pcl


[4]
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/process/100%/debian-12-x86_64-20240206.cgz/lkp-skl-fpga01/context_switch1/will-it-scale

commit:
  cb1898f58e ("perf annotate-data: Support --skip-empty option")
  0c365693d5 <-- replacement patch

cb1898f58e0f175d 0c365693d5482c855ba9acd45a9
---------------- ---------------------------
         %stddev     %change         %stddev
             \          |                \
     64399 ±  2%    +258.9%     231157 ± 11%  cpuidle..usage
   1317337 ±  5%     -77.3%     299607 ± 52%  numa-numastat.node1.local_node
   1363498 ±  5%     -76.6%     319125 ± 46%  numa-numastat.node1.numa_hit
     27.91           -59.1%      11.42 ±  4%  vmstat.cpu.us
  18301349           -59.9%    7340407 ±  4%  vmstat.system.cs
    129807          +448.8%     712411        vmstat.system.in
  18547591           -61.2%    7201865 ±  5%  will-it-scale.104.processes
    178341           -61.2%      69248 ±  5%  will-it-scale.per_process_ops
  18547591           -61.2%    7201865 ±  5%  will-it-scale.workload
      0.41 ±  4%      +0.9        1.33        mpstat.cpu.all.irq%
      0.01 ±  3%      -0.0        0.01 ±  4%  mpstat.cpu.all.soft%
     70.70           +15.8       86.54        mpstat.cpu.all.sys%
     28.09           -16.7       11.37 ±  4%  mpstat.cpu.all.usr%
    197.00 ± 65%    -100.0%       0.00        perf-c2c.DRAM.local
    345.00 ± 13%    -100.0%       0.00        perf-c2c.DRAM.remote
      6145 ± 30%    -100.0%       0.00        perf-c2c.HITM.local
    207.50 ±  9%    -100.0%       0.00        perf-c2c.HITM.remote
      6353 ± 29%    -100.0%       0.00        perf-c2c.HITM.total
     75677 ± 11%     -75.1%      18806 ± 77%  numa-meminfo.node0.Mapped
   2716604 ±  3%     -99.9%       1820 ± 47%  numa-meminfo.node1.Active
   2716596 ±  3%     -99.9%       1812 ± 47%  numa-meminfo.node1.Active(anon)
   4505110 ± 29%     -65.6%    1549919 ± 89%  numa-meminfo.node1.FilePages
   1211376 ± 16%     -60.6%     477658 ± 43%  numa-meminfo.node1.Inactive
   1211335 ± 16%     -60.6%     477589 ± 43%  numa-meminfo.node1.Inactive(anon)
    451272 ± 15%     -96.0%      18078 ± 79%  numa-meminfo.node1.Mapped
   5431186 ± 24%     -48.9%    2777179 ± 46%  numa-meminfo.node1.MemUsed
   3537633 ±  4%     -99.9%       4987 ± 37%  numa-meminfo.node1.Shmem
     19126 ± 11%     -74.9%       4809 ± 77%  numa-vmstat.node0.nr_mapped
    679371 ±  3%     -99.9%     453.29 ± 47%  numa-vmstat.node1.nr_active_anon
   1126311 ± 29%     -65.6%     387479 ± 89%  numa-vmstat.node1.nr_file_pages
    302619 ± 16%     -60.5%     119398 ± 43%  numa-vmstat.node1.nr_inactive_anon
    113050 ± 15%     -95.9%       4645 ± 79%  numa-vmstat.node1.nr_mapped
    884442 ±  4%     -99.9%       1247 ± 37%  numa-vmstat.node1.nr_shmem
    679371 ±  3%     -99.9%     453.29 ± 47%  numa-vmstat.node1.nr_zone_active_anon
    302620 ± 16%     -60.5%     119398 ± 43%  numa-vmstat.node1.nr_zone_inactive_anon
   1362527 ±  5%     -76.6%     318783 ± 46%  numa-vmstat.node1.numa_hit
   1316366 ±  5%     -77.3%     299265 ± 52%  numa-vmstat.node1.numa_local
   2719746 ±  3%     -99.9%       3460 ±  2%  meminfo.Active
   2719698 ±  3%     -99.9%       3428 ±  2%  meminfo.Active(anon)
   6617563 ±  2%     -53.4%    3084531        meminfo.Cached
   6890243 ±  2%     -51.3%    3357677        meminfo.Committed_AS
   1534356 ±  7%     -54.6%     697259        meminfo.Inactive
   1534138 ±  7%     -54.6%     697031        meminfo.Inactive(anon)
    107936           -12.1%      94833        meminfo.KReclaimable
    528224 ± 12%     -93.0%      36860        meminfo.Mapped
   8481255 ±  2%     -36.8%    5356536        meminfo.Memused
    107936           -12.1%      94833        meminfo.SReclaimable
   3544842 ±  4%     -99.7%      11867        meminfo.Shmem
   9043642 ±  2%     -38.3%    5581530        meminfo.max_used_kB
    120076 ± 10%     +43.6%     172392 ± 11%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      1.29           -14.6%       1.10 ±  3%  sched_debug.cfs_rq:/.h_nr_running.avg
      1093 ±141%    +306.5%       4446 ± 50%  sched_debug.cfs_rq:/.load.min
    120076 ± 10%     +43.6%     172392 ± 11%  sched_debug.cfs_rq:/.min_vruntime.stddev
      1815 ±  4%     +13.8%       2066 ±  4%  sched_debug.cfs_rq:/.runnable_avg.max
      1209           -14.1%       1038 ±  2%  sched_debug.cfs_rq:/.runnable_avg.min
     97.73 ± 12%     +69.5%     165.67 ±  7%  sched_debug.cfs_rq:/.runnable_avg.stddev
    804.36 ±  3%     -14.8%     685.33 ±  4%  sched_debug.cfs_rq:/.util_avg.min
     63.65 ±  6%     +21.3%      77.20 ±  6%  sched_debug.cfs_rq:/.util_avg.stddev
    618.13           +18.0%     729.46 ±  2%  sched_debug.cfs_rq:/.util_est.avg
      1100 ±  5%     +41.5%       1556 ±  7%  sched_debug.cfs_rq:/.util_est.max
    793984 ±  2%     -32.0%     539895 ±  3%  sched_debug.cpu.avg_idle.avg
      2817 ±  7%     -21.9%       2200 ±  5%  sched_debug.cpu.curr->pid.min
      2.39 ±  3%     +12.5%       2.69 ±  3%  sched_debug.cpu.nr_running.max
  26222425           -55.0%   11804141 ±  4%  sched_debug.cpu.nr_switches.avg
  27158282           -54.5%   12358425 ±  4%  sched_debug.cpu.nr_switches.max
  24464466 ±  2%     -56.0%   10752464 ±  5%  sched_debug.cpu.nr_switches.min
    605107 ± 12%     -47.2%     319551 ± 15%  sched_debug.cpu.nr_switches.stddev
    679317 ±  3%     -99.9%     856.63 ±  2%  proc-vmstat.nr_active_anon
    178194            -2.9%     173071        proc-vmstat.nr_anon_pages
   4677129            +1.7%    4755105        proc-vmstat.nr_dirty_background_threshold
   9365694            +1.7%    9521838        proc-vmstat.nr_dirty_threshold
   1654099 ±  2%     -53.4%     771132        proc-vmstat.nr_file_pages
  47057782            +1.7%   47838697        proc-vmstat.nr_free_pages
    383856 ±  7%     -54.6%     174258        proc-vmstat.nr_inactive_anon
    132404 ± 12%     -92.9%       9449        proc-vmstat.nr_mapped
      4649            -1.8%       4564        proc-vmstat.nr_page_table_pages
    885917 ±  4%     -99.7%       2965        proc-vmstat.nr_shmem
     26984           -12.1%      23708        proc-vmstat.nr_slab_reclaimable
    679317 ±  3%     -99.9%     856.63 ±  2%  proc-vmstat.nr_zone_active_anon
    383856 ±  7%     -54.6%     174258        proc-vmstat.nr_zone_inactive_anon
    201323 ± 11%     -98.7%       2700 ±111%  proc-vmstat.numa_hint_faults
     98999 ± 21%     -98.5%       1473 ±161%  proc-vmstat.numa_hint_faults_local
   1907797 ±  2%     -59.0%     781318        proc-vmstat.numa_hit
   1805585 ±  2%     -61.6%     693715        proc-vmstat.numa_local
    107648           -18.6%      87591        proc-vmstat.numa_other
     23053 ± 70%     -82.8%       3957 ±249%  proc-vmstat.numa_pages_migrated
    399248 ± 16%     -86.2%      55155 ±122%  proc-vmstat.numa_pte_updates
    958792 ±  5%    -100.0%     225.75 ±  6%  proc-vmstat.pgactivate
   2040912 ±  2%     -55.0%     919056        proc-vmstat.pgalloc_normal
   1329369 ±  2%  +15435.5%  2.065e+08 ±  2%  proc-vmstat.pgfault
   1004379           -27.6%     727209 ±  2%  proc-vmstat.pgfree
     23053 ± 70%     -82.8%       3957 ±249%  proc-vmstat.pgmigrate_success
     49086 ± 20%     -20.5%      39045        proc-vmstat.pgreuse
      0.03           -38.8%       0.02 ±  6%  perf-stat.i.MPKI
 2.522e+10           +72.3%  4.344e+10 ±  3%  perf-stat.i.branch-instructions
      1.55            -0.7        0.88 ± 20%  perf-stat.i.branch-miss-rate%
   3289507 ±  2%     -15.8%    2769952 ±  5%  perf-stat.i.cache-misses
  18477740           -59.9%    7405320 ±  4%  perf-stat.i.context-switches
      2.20           -38.0%       1.37 ±  3%  perf-stat.i.cpi
 2.835e+11            -2.0%  2.777e+11        perf-stat.i.cpu-cycles
    189.99            +3.0%     195.65        perf-stat.i.cpu-migrations
    154844 ±  2%     -32.0%     105248 ±  6%  perf-stat.i.cycles-between-cache-misses
 1.292e+11           +61.4%  2.085e+11 ±  3%  perf-stat.i.instructions
      0.46           +64.4%       0.75 ±  3%  perf-stat.i.ipc
    177.68           -52.6%      84.26 ±  3%  perf-stat.i.metric.K/sec
      4186 ±  2%  +16117.8%     678906 ±  2%  perf-stat.i.minor-faults
      4186 ±  2%  +16117.3%     678906 ±  2%  perf-stat.i.page-faults
      0.03 ±  2%     -47.8%       0.01 ±  7%  perf-stat.overall.MPKI
      1.54            -0.7        0.84 ± 22%  perf-stat.overall.branch-miss-rate%
      2.19           -39.2%       1.33 ±  3%  perf-stat.overall.cpi
     86165 ±  2%     +16.8%     100667 ±  6%  perf-stat.overall.cycles-between-cache-misses
      0.46           +64.8%       0.75 ±  3%  perf-stat.overall.ipc
   2105030          +316.7%    8772170        perf-stat.overall.path-length
 2.513e+10           +72.3%  4.331e+10 ±  3%  perf-stat.ps.branch-instructions
   3280483 ±  2%     -15.9%    2760114 ±  5%  perf-stat.ps.cache-misses
  18416035           -60.0%    7375563 ±  4%  perf-stat.ps.context-switches
 2.825e+11            -2.0%  2.768e+11        perf-stat.ps.cpu-cycles
    189.25            +3.0%     194.99        perf-stat.ps.cpu-migrations
 1.288e+11           +61.4%  2.079e+11 ±  3%  perf-stat.ps.instructions
      4169 ±  2%  +16132.3%     676851 ±  2%  perf-stat.ps.minor-faults
      4169 ±  2%  +16131.8%     676851 ±  2%  perf-stat.ps.page-faults
 3.904e+13           +61.7%  6.313e+13 ±  3%  perf-stat.total.instructions
     53.50           -53.5        0.00        perf-profile.calltrace.cycles-pp.read
     45.69           -45.7        0.00        perf-profile.calltrace.cycles-pp.write
     35.13           -35.1        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
     31.89           -31.9        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     29.98           -30.0        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     26.86           -26.9        0.00        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     26.74           -26.7        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     25.88           -25.9        0.00        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     23.71           -23.7        0.00        perf-profile.calltrace.cycles-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     21.52           -21.5        0.00        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     20.61           -20.6        0.00        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     18.62 ±  2%     -18.6        0.00        perf-profile.calltrace.cycles-pp.pipe_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     16.92           -16.9        0.00        perf-profile.calltrace.cycles-pp.schedule.pipe_read.vfs_read.ksys_read.do_syscall_64
     16.55           -16.6        0.00        perf-profile.calltrace.cycles-pp.__schedule.schedule.pipe_read.vfs_read.ksys_read
     14.74 ±  2%     -14.7        0.00        perf-profile.calltrace.cycles-pp.__wake_up_sync_key.pipe_write.vfs_write.ksys_write.do_syscall_64
     14.31 ±  2%     -14.3        0.00        perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_sync_key.pipe_write.vfs_write.ksys_write
     14.10 ±  2%     -14.1        0.00        perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_sync_key.pipe_write.vfs_write
     13.74 ±  2%     -13.7        0.00        perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_sync_key.pipe_write
      9.02            -9.0        0.00        perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_sync_key
      7.16            -7.2        0.00        perf-profile.calltrace.cycles-pp.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common
      6.93            -6.9        0.00        perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.pipe_read.vfs_read
      6.62            -6.6        0.00        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.read
      6.14 ±  2%      -6.1        0.00        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.write
     65.61           -65.6        0.00        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     58.74           -58.7        0.00        perf-profile.children.cycles-pp.do_syscall_64
     53.92           -53.9        0.00        perf-profile.children.cycles-pp.read
     46.12           -46.1        0.00        perf-profile.children.cycles-pp.write
     26.87           -26.9        0.00        perf-profile.children.cycles-pp.ksys_read
     25.90           -25.9        0.00        perf-profile.children.cycles-pp.vfs_read
     23.87           -23.9        0.00        perf-profile.children.cycles-pp.pipe_read
     21.55           -21.5        0.00        perf-profile.children.cycles-pp.ksys_write
     20.65           -20.7        0.00        perf-profile.children.cycles-pp.vfs_write
     19.74           -19.7        0.00        perf-profile.children.cycles-pp.schedule
     19.36           -19.4        0.00        perf-profile.children.cycles-pp.__schedule
     18.67 ±  2%     -18.7        0.00        perf-profile.children.cycles-pp.pipe_write
     14.75 ±  2%     -14.8        0.00        perf-profile.children.cycles-pp.__wake_up_sync_key
     14.32 ±  2%     -14.3        0.00        perf-profile.children.cycles-pp.__wake_up_common
     14.10 ±  2%     -14.1        0.00        perf-profile.children.cycles-pp.autoremove_wake_function
     13.79 ±  2%     -13.8        0.00        perf-profile.children.cycles-pp.try_to_wake_up
     12.86           -12.9        0.00        perf-profile.children.cycles-pp.syscall_return_via_sysret
     10.00           -10.0        0.00        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      9.04            -9.0        0.00        perf-profile.children.cycles-pp.ttwu_do_activate
      8.44            -8.4        0.00        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      7.17            -7.2        0.00        perf-profile.children.cycles-pp.enqueue_task_fair
      6.95            -6.9        0.00        perf-profile.children.cycles-pp.dequeue_task_fair
      6.09            -6.1        0.00        perf-profile.children.cycles-pp.entry_SYSCALL_64
     12.54           -12.5        0.00        perf-profile.self.cycles-pp.syscall_return_via_sysret
      9.91            -9.9        0.00        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      6.97            -7.0        0.00        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      5.47            -5.5        0.00        perf-profile.self.cycles-pp.entry_SYSCALL_64
