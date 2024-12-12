Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09583259490;
	Thu, 12 Dec 2024 02:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733968860; cv=fail; b=Sk1I9hextdNOtrM9VAK5P8q75+NssHbdGd7sZEDMgTOn5TM4mcG9IER10SN34X3tMNzb4hJMP6iSxenWnsZ/eJzTrOn1C8ck0XfdUMOpafe92GXJUtutwMJz+ffO+Rw3N8C0abkyskRUL0ONb9MyVIwP+aI4QLrzjFwekbkrlCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733968860; c=relaxed/simple;
	bh=AE/i/g5rImCEXJ3Aagt5xwWm6J28PF1GsWgPLxMJCts=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kb2x2/e9Gv2llVJm3EknG99yRqzI0AauauMUzkUk2aIY7v0QCWc7ckLn8aIFFN5wuBhkyQDq3UtdPWMSTUwnwEaMqxoOJmYfG0W0kiO/qkhhVUaf4e/eaNp/kb8dtw4CdwFdNNxaEZ0l+qsoc7Fj+7SfYEl74/Xv1G1TQj0k5GA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KJuiza55; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KJuiza55"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733968858; x=1765504858;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AE/i/g5rImCEXJ3Aagt5xwWm6J28PF1GsWgPLxMJCts=;
  b=KJuiza55fQY2WK48uwl+Q/JXC3er0RueCv+mJzbMscVrolXAZU9NYJHj
   +a8HcczWlMnJJtcjY2CzJBP4sZUs+ftDURh8QwSYkRtP2mKidtq+kEZGv
   dRrcDEyvaSmqEYXXscWuGrAjH6tN8XUkvxN9iO77lRJKJBiPy3WWX5HVf
   PsENUocu4pBsE7Bfn8QRXEaGc+D0PsXG95zxSP5RPgTppUyxewcZpR1CV
   c7V1sYh7f3WYf8ulVWSxWyv2aMRM1yzA1l0DDK2ZYlOzTPpviSs1jcusD
   9aILq7HMzlzl5OYC6pCjw3aRlVCvkvmThovWMdTqVcHlLni1zbaqP2+UG
   w==;
X-CSE-ConnectionGUID: AG39X+lfQ7WtglUZSuS9hA==
X-CSE-MsgGUID: NkfmfThDRcmPUmWGtQXw4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="37212098"
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="37212098"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 18:00:57 -0800
X-CSE-ConnectionGUID: U1c00bT+RPSEHkj/dEN1rQ==
X-CSE-MsgGUID: V8LcmZpvQ+C+AH6Hc+zkoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="101127793"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2024 18:00:56 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Dec 2024 18:00:55 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 11 Dec 2024 18:00:55 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Dec 2024 18:00:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qg+CoHw7ytN0lPxmD04Cx8AQfcc8AathjgI0124H+txTtqIgcc5cgXepbs5TbnVPOXhrv6Npu2N9ThpjsbyQcL5CFqlw7UUzRS5eK2C+TKOFILrLLU8srgvY1VZI/Th57kJlhA/VdSmS1uCCPabtKfKxC+UnbjYLq9hcbWs3ZcAMWAIxObg2q66UVmIye5p5dYe60722L2oEfFG07Z31vu0r9+5h0p+Fx0fHxQZyDp5knFQojhZ+mCLTYJrJFncW5nFMFI83nbO+AfzhsPS+VUDrNAIiclS/EbFcqHUBtQ6RW/02Oz9vCXeHNO6kaAsTV2hgyrEXOGeBZrqdf8bT3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/x/1fO1jSEAl9qk33ZFFuCTjS/CM1JProwfb3ZtTpdA=;
 b=ysFrD12e1w3L7gZr1PQxE9H5lvRG6dDoFmLJZSI1y3yTqHHhyI1MhWCVveBHHO+G4HOruteMBLvKndMfMk5mFg+Txc/PLc6JBqn9YQ65554bdJUTAgFXmgdRf0rSqm7QpiEpZGs7NPysiYgCdImEtiHv9TCq2UOLvCIamkHt2QVo++UlikIqfe+yedpdedUBMU+uqmUVdlRTRCfzB9AJprjg707D5K3d0P3zaf4eWEbwL5yeoqHyBBiwF0V63Nd7BjDdxNfQnzaRdLbx5rFJNti2Msek+G9r1nxvEGK7iRHcWbznv+1CPPnIWe0xE9E2w/Up69ZKa6dsRcpNfvrMhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW3PR11MB4553.namprd11.prod.outlook.com (2603:10b6:303:2c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Thu, 12 Dec
 2024 02:00:51 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 02:00:51 +0000
Date: Thu, 12 Dec 2024 10:00:39 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Namhyung Kim <namhyung@kernel.org>
CC: Arnaldo Carvalho de Melo <acme@kernel.org>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, <linux-kernel@vger.kernel.org>, James Clark
	<james.clark@linaro.org>, Ravi Bangoria <ravi.bangoria@amd.com>, Kan Liang
	<kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, Atish Patra
	<atishp@atishpatra.org>, Mingwei Zhang <mizhang@google.com>, Kajol Jain
	<kjain@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>, Palmer Dabbelt
	<palmer@rivosinc.com>, <linux-perf-users@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [linus:master] [perf tools]  af954f76ee:
 perf-sanity-tests.Test_data_symbol.fail
Message-ID: <Z1pDx0TFKsYZvGCl@xsang-OptiPlex-9020>
References: <202411301431.799e5531-lkp@intel.com>
 <Z04ZUHaGdsBapIEL@google.com>
 <Z1BhfpYWpUQ0p+qR@xsang-OptiPlex-9020>
 <Z1DNJpDzCIBFrIZT@google.com>
 <Z1DV0lN8qHSysX7f@google.com>
 <Z1HHClaOwjJnR5gr@x1>
 <Z1nLcMDTFAFuX809@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z1nLcMDTFAFuX809@google.com>
X-ClientProxiedBy: SG2PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:3:18::36) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW3PR11MB4553:EE_
X-MS-Office365-Filtering-Correlation-Id: 33f34bd1-35bd-4f27-eb49-08dd1a50cde1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?G3Y+ZaiZAIA42/QwWPK2Q9g4efkZuo/wMlf7xW5QpDyo1UV+i31V0yZnY+tE?=
 =?us-ascii?Q?z3FIsmPJOqYPO3wR5yVO9pihCb+kr9aMObnFtGhxb2FAHaNmq/iTNzbtu7W6?=
 =?us-ascii?Q?gzZvhPrukiWnfrP2A96XSMYOhkJLfY17UsaSVQGMRTUPI8MbmxWU21rTzRTg?=
 =?us-ascii?Q?wufTo1nH7IKHRdnFVuNhUQ0b6q1Wvjt2uJXbkCPreIzH4SylT+CcUN/KjmFa?=
 =?us-ascii?Q?hvk30zXxR7ArM1DgV8CizLuAPMmcyJ+ArRQ8B0V7TsHaPmziZ0zf7AJOZLm/?=
 =?us-ascii?Q?hfXxeLhDx4qJpPti/b0v92ACq/wPJL1L4uyLoyJlghzfcwqcjes9tBSDw2L7?=
 =?us-ascii?Q?Xm5QrhENqc5CYrX1FbCV0nhiRlxspJX2xnxXxpVGON4M0ZXlIg4qySSe6K7D?=
 =?us-ascii?Q?ui1tGswhFu5nBKotGTBzjhFuSsK+6d0b3zkOW03+YIaFfDjwtPcBnxYOoTcd?=
 =?us-ascii?Q?SFSoYQoehxod6f2phMae4LfQYNYCD5yXwI2yHr3qf4eaCGTJFqDWw3myjIhI?=
 =?us-ascii?Q?QFEbgeO/neuIb9JNP5xWALrwGIpwdrLjtwk+nhxmKK59I7SyUVGWoiPxP8hj?=
 =?us-ascii?Q?ctEHlr2zWCiaYZ/xB9h+Qv6XyPCkFQdPO50yldowa8qcoGnB9EWBecRttX1j?=
 =?us-ascii?Q?3HY7f6+WRAflXxOQlmhqc51eWpSddvUrKWv2BMBycmKpp1h6NUjWxKaGLWaP?=
 =?us-ascii?Q?Qpts5pJXRksXeYdEKrY7EDvu946sFGcfdoVc61ioq3UKPc3crp5QvRSfdcvh?=
 =?us-ascii?Q?wEu1vDBylAztaGJBeUGE6TY4ouVqviffm7YbhvdPTkNkXMfw7fzK2V6KJAP+?=
 =?us-ascii?Q?cdRlhFd/goBfv9caGsyognG/7gcVTPB6R7doLMgdBpH8YjcVIt9Yb8xOdgi4?=
 =?us-ascii?Q?wfpxfmkvU95dsNQyMnGkkFp8d//ckFeHpEj6wm4uPkUu6pMC0hQtXe5EH/Zl?=
 =?us-ascii?Q?T/9Hxj7AXRzSjCOmZEvzjwrp1xfKXiA3USOd021XmIwGG30dtSV3UtcR5x+5?=
 =?us-ascii?Q?mCiFTLefmeLNgy4caHtDcG7LNaw8eYa/SfmfcLeHlqTvDRN0vFAajyjdhRtZ?=
 =?us-ascii?Q?uRmNATrkeRlO3gb61lWK+Ey4AiwszKe4KVcc9y1PPwa6wGmLqrii41f/TzU/?=
 =?us-ascii?Q?JE1x0g1vWr6Ej1W8jjPHMXqw0QvsON43Te0bJlNl/Ej9NpiyTFfZy27i5/We?=
 =?us-ascii?Q?cEks0ezst9k7CkeuFux8cg9noU7FaffPPrjzQJyys3W019DrLrfEr107Cl3q?=
 =?us-ascii?Q?BCcdf/hCGAjxuOmN8ppyA3upUBOrk0hTpQFJG8Aih7wcbM6TROd5Otvbq03W?=
 =?us-ascii?Q?A0ktvHpcLmPjlFYbyOTyd+v8/nBpf2nFSfY8O5sjGpYTug=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pvvr4mILdBsveelCTNhZJZrx9ToSH67HEW9Cqn8sC7uzcjjrOhqpNRMypTAf?=
 =?us-ascii?Q?3+3zjNKjOmIql2UAZeSzqj51q/HYHqs0CiQcFt3SMA5YsqqcjOrQac66Xdkb?=
 =?us-ascii?Q?iS8GpvvLZLZkNJQw+T5bATkM0FI90yTC5tzWV7Wn+yG0DruEZW0UMpAKZw2X?=
 =?us-ascii?Q?HN38BsSNFEaAVD38fRU0CDIUZrT4prMxE4FuGXz/S/+6UBKT0fFgj9IztTAP?=
 =?us-ascii?Q?GeL7zB8x1uTZYEA6W0Atgp1AE3djFOFxDWnxausa4QqTzl7+Bq7VGtGrUk5P?=
 =?us-ascii?Q?vtHa7PzOLZ1Dxs5bagqjRm6DKyHf8ZBwOlu9ySCrXxwj+o+QLSfA+bjMVZL+?=
 =?us-ascii?Q?esVQDB2vtFWdLUSR54Qvkh0xBUM+RSB29gA4vWB44zv3DyuNoQGY/zQDEdJD?=
 =?us-ascii?Q?lO31IGGqmcDwiQ4gAHQcFkaRAqVXXwn0OlWdTipLq/tXLAW8d1IWMFywJ1oZ?=
 =?us-ascii?Q?R4Pn0RXGrc/mixfyZBiCh5FROY19kacmAwd4glFMYxzV+8uIGoZYmbmCSvt7?=
 =?us-ascii?Q?0i+alFzjCaU6M9t5vQ9b+adtYovn4ns2G+MT+VNnbcFNwUR6+80Pk9FHu7s2?=
 =?us-ascii?Q?DnIa+ZepmyNvj5QJ2rortyR7s91PpnuF8VPXrC+MILRvYi7bDD/EgUDka4gF?=
 =?us-ascii?Q?9EYWZ50CBSxQ3n9/1/G7rmG9gdfU0XU4pQpLHwrDuAtqNFvQ7TlnAkLUhIqr?=
 =?us-ascii?Q?KYrcvt/OxRNE42oUhWFoBHP1Uv9VotQxrpVXC1KG78dIKjgiK7P6/lGxy5QS?=
 =?us-ascii?Q?00v0dmvVoqCFYBxelR5fjc60l02ZM/GcQvapDE4DZU0A6qdtRxynOYrKRP8p?=
 =?us-ascii?Q?tMZ2Qg6C8AIW39GOnWpxIV7j4Ewknf0zH8PAAwcj6k7SJESsx5DoQIYMH8hQ?=
 =?us-ascii?Q?GpRQ3PlElJSDIQSP/eeRJBLnkbzTyXUV6WbL1zIzAYKuUhqMhKpeK4ERf7Ci?=
 =?us-ascii?Q?D4iv8IN6sBce5WChZ3uN7GS/3OUoK5NInBZGvD72gOsBG4UbMiH0tBaJ24wD?=
 =?us-ascii?Q?ThK9t/Q6Z391zuhkEhSz4+QTBmix5mOHbkUXNd6OExDFrlW2ETpt2ePcE40y?=
 =?us-ascii?Q?6EJxgmDGA+MurlROZ4l7j/Hp2fB+K3SwWYS2j6wLXOcBS1GdfUgSbmo8CeJ4?=
 =?us-ascii?Q?uKsCADmaV15Iuq/eCW7odZ7Th+kqcpjVJi5BXva1n7A7IZCcFfGswU4BmABQ?=
 =?us-ascii?Q?BAxv0r9C30GPym3NlNpxFGOAyf9IOr1SH0pH9aOPE+nLbUIzlP+32zLfcUv4?=
 =?us-ascii?Q?zPsOqykmIeSCfoZb3nwlLHRSS6IWZlNx9on5FrepwpuokPm2s11dIGu2JZcL?=
 =?us-ascii?Q?oHt9KvVz0h7w8gXvNcuniTc2B0BaohYLsnrQu8s9qry53FVnZPnNHv2iwOm/?=
 =?us-ascii?Q?/CsDnOEl+cfbLvVsdXc3D5hLOZZV2WNzrnr0hPQ3+FqrWEoJvdSTcvBz5eQO?=
 =?us-ascii?Q?2mF6DFEEoE77XgVFiSWO5sgJWw3uPnga2RZD5Ip8CLhjCkAm5Wy9QW2+aldu?=
 =?us-ascii?Q?dMU32Gfh43gUBJra85oGpDZT7LvkRN7Td6mtN2ve+oWk4IFCy71WeFH/aGuv?=
 =?us-ascii?Q?fB6ZPsf2RNyzkJugHcv5sBDLco0HMXdRmO1zAjKSALmq130Wfk3MZ+e0iysG?=
 =?us-ascii?Q?pA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f34bd1-35bd-4f27-eb49-08dd1a50cde1
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 02:00:51.2257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nzNpAV6AdkIrlVazv4kFAVNR5iVZRXo9VmQpoYoSt4nDV20xA2qHzMI9uJ9RtIcGDq+IqSZFOOY1SQt6YmUkFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4553
X-OriginatorOrg: intel.com

hi,  Namhyung,

On Wed, Dec 11, 2024 at 09:27:12AM -0800, Namhyung Kim wrote:

[...]

> > It should have that precise level reflected in the evsel name :-\
> > 
> > Ran out of time, hope the above helps.
> > 
> > Apart from that, from a purely regression fix, your patch gets the
> > previous behaviour, from this isolated test I made, so:
> > 
> > Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Applied to perf-tools, thanks!

sorry for late. just FYI.

we finally finished the test with your patch, and confirmed
perf-sanity-tests.Test_data_symbol can pass now.

Tested-by: kernel test robot <oliver.sang@intel.com>

> 
> Best regards,
> Namhyung
> 
> 
