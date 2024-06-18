Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10B113A3E8;
	Tue, 18 Jun 2024 13:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718718757; cv=fail; b=PFA4FF6owIZVz/KizL7nHGZ6KPfdnsTfe4Ok9erJVYdn3VNVvaIGKxXIdPAsM3AMBFIvp84AoEoIILHv2CFNGVurMNy6fxaGeReUOV+fDi2Im1Q7bkWgP0fnTakEh75tDweXuHZwd46KwhR4NX9No8ywq0yEN6flAmhGkdAIA6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718718757; c=relaxed/simple;
	bh=QMCvn+4ifbzhaFlLPxMJmT5kQMDt3M+9tddSNZmoLmo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JIsOiGDnsegKd8NdlMHEq0SDhFRfLC7ad0V4nJJhGYWWkI/1fdRy05c8YFp/aiiv6LCEQu8K9XL51n+FfOzL+JqAAlKv2NJKBWvBpl0wOGvCtE8mjKbC9sC5H4eHyrve09GpYF1IUGeCfXtt7sWmKVD0ItV5aOv8VZEXRApgtA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fE6ZMgje; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fE6ZMgje"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718718756; x=1750254756;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QMCvn+4ifbzhaFlLPxMJmT5kQMDt3M+9tddSNZmoLmo=;
  b=fE6ZMgjepnQTAtx7+W2G3L/4Sc49kZVjpf+LZh+p8DPO+V5IFTPb1dbb
   tNitW+MzTw2W5r8gfujfhF89ESauxH563Itewhd+rUaKHir+V7sLqlTKU
   YLJFuLCUxMLJBS80wJlWqPSaNH+4GjrFEJ5I6vUjaMs+V5hY43vc10GfS
   sRriN7k6I531xI0jOragKOcAwQW0Jg/+5whP3NECostGZcmEzg3/3uxLS
   9qr6zzVTMuBzV534t9aiv3czYBmp0QEa+PRR3ocYMlOxU+RcgLU60YxtT
   ovj2hTkDDTr8Omk5YS6B58Yvvwwg6Ae/PDJM30mYuP2Z32vixvNq7eKQV
   A==;
X-CSE-ConnectionGUID: GmfvxyjYQcqRhnZOPvQkIw==
X-CSE-MsgGUID: S6vcM4YWTGS/SITdmSzawA==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="15359823"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="15359823"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 06:52:35 -0700
X-CSE-ConnectionGUID: Iu2Vv1VpT6+Kwy+zso7Ndw==
X-CSE-MsgGUID: dRvhgs2YQqWJbNsJmHz4dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="41669985"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Jun 2024 06:52:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 18 Jun 2024 06:52:34 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 18 Jun 2024 06:52:34 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 18 Jun 2024 06:52:34 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 18 Jun 2024 06:52:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8OQAFXtlTjX8vLc76mD60/HzadOXhitBkRClVqvmpRyjshu2sfrgbMptA1KqD7pR7C/bYecUx0l9a1gaV9uwHNidSZtNGyCYxBX0MJgvz8RIoJrO6y3btXc+AiSNWssBGV/BOBZvd1Rqw+pxHqLKJOSLbM9jkJ0CHTJ2h2bUC6nEQ77ulhtM0109ooWsEF3smQd6d+5wHjwGQXOyiWDDNSqx2+H+NYQOTpaVeZD+/7AjMfI3fwjdOxE0UTeboEO07X+eC8n5GO+da/x8K5I1hnJgwfwJ15nTmzC0njYyLeqnMxK3A1VMNmPqUihhOwKfDTsKYuCGIYyeiSga5Yulw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ZisSaP8mG+DosHojVXFLtY1J7MUJZyYyye1VbKuqIo=;
 b=BtIXzIb9WjF264hrQxYMBiTTP1Mu+tn04OblGjX3AhczNMQqRena9jnIoZrTj6EXLB5K5WEMeD4Sn3BKB7v9OIVdsAnKFkLn4AnNBaAVeCtdkmcGOjVUXtMFQuFsaR46nGxVVOhThoq46n4akYPQvSHyl5axJBpJthgbshP/rJb+pUEv3m8uxnLu1tQQkSJCLktMalBBUEOjlfMAPYJCPDyHgYUa4zeUUH/lf7BsMegffpOamJX5tmH8VpQNqhw7ZKdCPUo+6SXAk2a5bTMOZORHlB7los/i0kXcm42TfPjqwrhKt8Vdx5xJgsYqm3VdQfcepSRpFaO8G8KefKNHoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 PH8PR11MB8064.namprd11.prod.outlook.com (2603:10b6:510:253::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.27; Tue, 18 Jun 2024 13:52:27 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%7]) with mapi id 15.20.7633.036; Tue, 18 Jun 2024
 13:52:27 +0000
Date: Tue, 18 Jun 2024 21:52:15 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
CC: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Athira Rajeev
	<atrajeev@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang
	<kan.liang@linux.intel.com>, <acme@redhat.com>, linux-perf-users
	<linux-perf-users@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] perf sched map: Add command-name, fuzzy-name options
 to filter the output map
Message-ID: <ZnGRDyWrAUHnghtb@chenyu5-mobl2>
References: <20240617125006.31654-1-vineethr@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240617125006.31654-1-vineethr@linux.ibm.com>
X-ClientProxiedBy: TYCP301CA0060.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::9) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|PH8PR11MB8064:EE_
X-MS-Office365-Filtering-Correlation-Id: a9346b1a-0549-434f-add8-08dc8f9de2d5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|7416011|376011|366013;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rK4jLHIpK1oGH7XHFdmX4AJLRoYi75hS98upLORQZOmytihdqcLrgNVcZp4w?=
 =?us-ascii?Q?YDqsDUFFpXihoS0W7OZElJ9UKDRPceqfkrjW9DPBoml7z8ePgnJkL8gC2V30?=
 =?us-ascii?Q?YKGu72VOvpGyk/bcQ8IzFUt2ceit1cixVaW5FccXu6HZE/+B5jxEgq3Sjut7?=
 =?us-ascii?Q?nhN3rapmpRYfUOLbzvYhvGkeytadtEQDbYgQSFkySr+eYt8Q5CgzMOVasLs8?=
 =?us-ascii?Q?FMEFHAEa9nijVuQodkWE3qaY4gygx2JazrPjUqhiRcG1/DodjUHYGJo+f2WJ?=
 =?us-ascii?Q?Rhu2cUXOZMTAlnhDwdRPgqmZ4n3sX82lVMfkdIzSCBekSmk/3e0KKcDm9ZnS?=
 =?us-ascii?Q?jv6CgvueBzdDwsFoUoQ4mR0lH+CX4SERj+PgeVyBBrM4j6zWyehxeim2EdwK?=
 =?us-ascii?Q?Av+ls4f7Tx6h1RSypHcdi+4GTytVL7McqYd2PlaRmJFMUvsWMb9hhUkLy03J?=
 =?us-ascii?Q?zEvAiG3/HIQKNpxrRMP/AUiSd2ko8ZBMU/2vMe/t3tYvsV+32g9icgpPRylV?=
 =?us-ascii?Q?QYte78auGK/BLkxsanQBlKu5HEyHHi2q1R+Au10ZUwzJoOtiSMlD+GA+LZ8J?=
 =?us-ascii?Q?sZzMIBzI1I5P9vVFYhEZlNbhZTlcpH5HYO5qYBpT86daADI1mVO8NcDyaLTH?=
 =?us-ascii?Q?obKNCXm1/0cV/KMGu4pLRAxem7uZrE31/HjOhR9mFMZ33tT55PQuFS/vWehY?=
 =?us-ascii?Q?rB0V4tBstZ2USCT5FMMs0QmnGmrYDcMv0hkphg094ipVpbpW6Q5nP3GtdciT?=
 =?us-ascii?Q?ikvV6AM/+Qu7rGRKViqv7VfCzJ9FE1sKaFgfF5HKfubjguLFAAEuCdforZ5n?=
 =?us-ascii?Q?sTvvQ2NW4yFmPYX3dO5e2sbmDLDVZNRqnoGDzeUWzzmdlkjLmbU/qCJVx8IB?=
 =?us-ascii?Q?ihGpOyojYa7eDBZkFP3rtZ500zxeCAASLXm1Aa05fT1rK8ZlcO/2hEwqQ/So?=
 =?us-ascii?Q?dGiv0fN8gPW2sIGYYVn7vSE9o90GpWSvb/XQjA9ltJQML9zhfdY3J9Qz1kiF?=
 =?us-ascii?Q?uieMMjOHFymhLGkzEQtyajzCSDwxM3VBMfgLVrrn/p3PsCEgKaWwsCb8f2/a?=
 =?us-ascii?Q?L2jUWwLCMmvp0WcnL+xjPSSNsCE0oSWMGZUP4ekuiTuK2vJnWLr83RM1WTTN?=
 =?us-ascii?Q?Cgev0eaVBjHvsVuldmGOaKf+5NNO7kencHMXmhJDU4Wtnqmak8ToQ8jUPvZG?=
 =?us-ascii?Q?pX/l8vYhc50pZbZc3UNjWXj2pyzP/iaSYIEGvabEzhAZkmrzrgK45qV7nXDc?=
 =?us-ascii?Q?ZT6bVoueMbdXTopK+P2Dn/Vwvj4YrnyAjHkL3quj0vDVGuffTGBepwn4fQeF?=
 =?us-ascii?Q?aOk8yS71+0z8hFxjVEU29zsI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(7416011)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2ULFQPRlJLc2S4QK9XM/JNprC0GYfS4er1MgD4uRAqoxjHUTjXENuDBqbrkp?=
 =?us-ascii?Q?jMy+l2pUifMlg+8jL7eaIDfau0d9Kb3CVtUX5Emf0ESWYpfpIjmQb8LPF2Zd?=
 =?us-ascii?Q?Ws6AA1J0gTia7FWfyPNF5WIjPSTwRkhhRXZGzuzaEDTuvGGeOI9DJCGGt5if?=
 =?us-ascii?Q?CTcce+G53ptz+QH6jI1Z2RcIev20QwTc0HMw9uqFBndK2OT6YaXdHVwo09uq?=
 =?us-ascii?Q?ENTDdXfsK3t8fYMM/hFOt6zUlTBcQuAjORVYrKaIOt25fWSgp1VB8x+ENmhn?=
 =?us-ascii?Q?qnrvie2svpfX/ABUl19kyDtEILKkM9FwhxND2XawSbcsTIosMfKSIc70iw3W?=
 =?us-ascii?Q?urFQM6elb3RFD2dm+c+rN/VMl2GDIlLsn2YNgh+5uRZTx7fFCoA9i/dxRfjW?=
 =?us-ascii?Q?k0SZv7L3gU/Cx3N/nqwHtQxGBUPt7pSp3+7vQ5wF4ZxNmU5WLXfnLllPXyMf?=
 =?us-ascii?Q?mxu5YPzMSZIFbVKJJOQcAwbJzojxbBbeMroaCbhly6MJFwfeaEV4u+Z7zfKA?=
 =?us-ascii?Q?8+zNxA+gaRoluuKhWxst/+1D1jWK3AZchj9oe/hGeSVVa68x1ptS048/q8eu?=
 =?us-ascii?Q?7pdI2IJQQgmjbiF2TNoHRSBLWVhICgrwOHP6DcpL9XEQjS0QYlnzD8mpjcjd?=
 =?us-ascii?Q?RAJ8OD7wvkpM03FPsCNaVbMhDFglXdxoMHjRND8S528XqytTMuMbKB/42hHP?=
 =?us-ascii?Q?aK5VJtsu0DLM0Whn6NrbWkeZ6hY1BSpKXxMD+YHDN2jSndfHvoh7jLoTfaTz?=
 =?us-ascii?Q?HdKxLS81vXr83tRhcesh8YJhEpxsSRUnUw66rg01aWds4Cdtqk9p6vylwsH9?=
 =?us-ascii?Q?NmBwxL3LLpFK3qk01/h+ctpdVMuCauFCt8lfSprdf0bh2NXh64ZVG5OCqLba?=
 =?us-ascii?Q?6LYy8ljXUKUP9qqISTesrnnyDgBMg9eNNaOjzp841CMzCo+mZALj/a1n8I/G?=
 =?us-ascii?Q?SYizU1zKIbcBWu4migw9JjoD94Ahtabn0TJkl3lWaWG73/43kipE16NE5o2n?=
 =?us-ascii?Q?CGEBVf3R/EfwNrRldEDZDGn0pTmkTBp2BDYarALaC79pTGlrx0XnZe3LBKRi?=
 =?us-ascii?Q?Z4vtip2C2we457GxiDWXe9WwtP0eJBZby9gACyDPS7GwQEKET2fcAO4Lo4Z3?=
 =?us-ascii?Q?tdxQ3cYLr9QV2ntAmq3KAFMFov4s1DnLf3SD1p8YA2LJ2V3Jov4XJA37kCIh?=
 =?us-ascii?Q?mogwY4vwHWnwdZqweAjsGlNvX3SqsiuBCh0GEQKe0Q0BFWcc50taD8wnULg+?=
 =?us-ascii?Q?7dI8NIvqQ9owWbdtObPq2amE6w5UWdoqJxkovpFMQZxKgNhOY67AqZbeoc1I?=
 =?us-ascii?Q?rFrqirJGXvEBdbamdiedXWKqDpC6Zugcw0Mg8kADTACUrrV73+RRmaQGEFLh?=
 =?us-ascii?Q?f50q4dOn1yW/4KH26WrR2gcluih7Ig6zYg/joLnLx0fbuSFE2dqctoUiH3n/?=
 =?us-ascii?Q?KtfQWPMBU37eRBBrI9MqGtmWYAumTppkg4OjyNkV0XJ7zNKULPBZZgHmlAMv?=
 =?us-ascii?Q?m2KL1H+Jav+pWZfVWzqKjF4Hw5dmlxIdFow7yg7vQx25rIRFwgZVkPEP75n8?=
 =?us-ascii?Q?/LpF88aDOkzUdDPApreEiPmg1KUZfxd6WN+MFDQG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a9346b1a-0549-434f-add8-08dc8f9de2d5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 13:52:27.5136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7oh09/371yVKlNWz18q6mLyWEuVVmQWXrQnvHcv5YVMvq3Q3NPYKZstXbWNx9nRvogJl5z6H/cjKtAegf697qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8064
X-OriginatorOrg: intel.com

On 2024-06-17 at 18:19:30 +0530, Madadi Vineeth Reddy wrote:

> +static struct CommandList *parse_commands(const char *commands)
> +{
> +	char *commands_copy = strdup(commands);

Should we check if commands_copy is NULL in case of allocation failure?

> +	char *token = strtok(commands_copy, ",");
> +	struct CommandList *cmd_list = malloc(sizeof(struct CommandList));
> +
> +	if (cmd_list == NULL)
> +		return NULL;
> +
> +	cmd_list->command_count = 0;
> +	cmd_list->command_list = NULL;
> +
> +	while (token != NULL) {
> +		cmd_list->command_list = realloc(cmd_list->command_list, sizeof(char *)
> +							*(cmd_list->command_count + 1));
> +		cmd_list->command_list[cmd_list->command_count] = strdup(token);

ditto.

thanks,
Chenyu
