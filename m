Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360A616A938;
	Sun,  1 Sep 2024 12:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725194877; cv=fail; b=iosDfdtQ7E3rFNtX7MKzhmk4v4LoJdASN6gFDFn2A+N5/XJLRuSCArlxsNKHa2Ykts+niYWZtMEunhtDsHw5NHphX9Q3mwvzjr212wyrZYlzIPhzDaAzixSRLodpvIAHdclWbCO3A/qhtOl18lGGL4wV5xwTxHpyb51Wuzux/Ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725194877; c=relaxed/simple;
	bh=WevnNqJ8fjv2kL9T0ljfcwDPHOYpx/sojm6BBKXJtYU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gy3JY2Hdp2WFCJ+uIssm2+ahrRqGf8SoqDwZ6fG+qoagcAHqkieYsmnVuRFOmSBByqVXX7PtS4dc72jhx2HwngCtQ4qu362WskDICv0dvBOvaLT6exBKjnkcLfn/INBm7OiylCmr3DDVS8JmkF3ypW0X+DTvdCDV3SfLaz3AMv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IXn3AZWt; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IXn3AZWt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725194875; x=1756730875;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=WevnNqJ8fjv2kL9T0ljfcwDPHOYpx/sojm6BBKXJtYU=;
  b=IXn3AZWttETxdLebXea7ZgaQofpAtvjRnfd4V196Nc+rfY35ZjLRHQzK
   H6JnU7WNblD0dPbCQN6hH5h+6xNbt+MgLsHVjGN6Kar40PQB4YO2GA+xj
   o/yz3TrKAJI8mjWiyN+UwhgBXID9/T+s424ryadyBoaUUNGeKWEek2u3U
   cYDCjmxEiq5cSk0qSrDDeNGCFese2AYfbIZzrsj+xMgmQvUGsW1mWAex2
   nsyXczh7G2EPLlS16Lq3Ur3m2BlWaXLpRmRPx0KTP7S4bghPEUgvcwVer
   5Rq+vA0TrVyuXQuuMBBrs13nGSG5YwtULOJ5UZXDlhNqJSrWwshJIVKu8
   Q==;
X-CSE-ConnectionGUID: +HpUt49eTvCsFNi2SPj9gQ==
X-CSE-MsgGUID: AKcsbs2BToGLc8pthJohmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11181"; a="23917106"
X-IronPort-AV: E=Sophos;i="6.10,194,1719903600"; 
   d="scan'208";a="23917106"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 05:47:55 -0700
X-CSE-ConnectionGUID: ivQXgyuIRnK/Ccqbr1UGLg==
X-CSE-MsgGUID: KPHyTXonSWGo/d1SL8XzCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,194,1719903600"; 
   d="scan'208";a="101811251"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Sep 2024 05:47:53 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 1 Sep 2024 05:47:52 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 1 Sep 2024 05:47:52 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 1 Sep 2024 05:47:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q7xEFv5roFivlIXFKZq1VYgdcDza8kgMUTddMKcLM3lIcxq+6RdYkgtDXsHLd7hPADkFN7p/tGPmvXKx7/rkvGfaBewQD25Ghukvtzsl+twebJH1OAQih9RqHKdTjw6FwH/G37ntdH+gPNQgok77xAWcHnfdpwr/zChuLgxZorKquISjeAB8tL7or/Xj+PaRVW2p15y08bE5kj3xuF4RPTzanf+ruCnPC27AYmCitJue9154oVWAC7psIed75K3T3U6tDJHakhKjJEOAE1t9WEpito9Rm1LIx+nR/6n71xkgWSm02x8BJP3tNNVcHJ0LsiSqVI5rvgirjdDOGrSmXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6MP+VlcKY/koZ6WJhPYnbd+R8iS3SMC2Ttgic3LeR0=;
 b=tPOncTG4TEo+f7Uc5g0xqhhjwfU90iB6QU0zdSMqf1RO6CApZqK023//VAtzJwSn9PWvgaG3IB0e89EpEKc02MBHSSC06MP7m3go799FI4zJwqujQUogaqNMKNxqI7wWmiSfoiMosqPpedoJbbPDvrKm72Pc7Ca1aDgAg4t2r5IPY0MOjRcyjJ7eww3z0nTFLEygu33rUFoSLNqnmpJKF8S0c0cOekXZZvd5MCkdDabSh1a+9FaUrWK5ksbApVQmVmTx76/J3wbUJsRW7PA7nldQun1kKvGvk3vE75DihVMtm/gemYYVToDZqDyTHtEcfFry7YAj6HB8rHzyq4BEvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by SJ2PR11MB8471.namprd11.prod.outlook.com (2603:10b6:a03:578::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Sun, 1 Sep
 2024 12:47:50 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%5]) with mapi id 15.20.7918.020; Sun, 1 Sep 2024
 12:47:49 +0000
Date: Sun, 1 Sep 2024 20:47:35 +0800
From: kernel test robot <lkp@intel.com>
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
	<jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Kan Liang
	<kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Dominique Martinet <asmadeus@codewreck.org>, Yang Jihong
	<yangjihong@bytedance.com>, Colin Ian King <colin.i.king@gmail.com>,
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, "Masami Hiramatsu (Google)"
	<mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, John Garry
	<john.g.garry@oracle.com>, Junhao He <hejunhao3@huawei.com>, David Ahern
	<dsa@cumulusnetworks.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>
Subject: Re: [PATCH v1 4/6] perf parse-events: Add default_breakpoint_len
 helper
Message-ID: <ZtRiZ5rxwBJsJZlC@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240831070415.506194-5-irogers@google.com>
X-ClientProxiedBy: SG2PR04CA0153.apcprd04.prod.outlook.com (2603:1096:4::15)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|SJ2PR11MB8471:EE_
X-MS-Office365-Filtering-Correlation-Id: e786960c-61c8-4b44-4ed3-08dcca844914
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BmfMkpH0qa5rFVhUDzlZs1SHVy4iakyGL60ElfRqjj2ME6151ATvFt1XeCRG?=
 =?us-ascii?Q?Q5zok3yEaOz46TDOgDDCu2Och7f0Oyg5Jr7u7RkSrCoC6uc/bIHksz9q2N2O?=
 =?us-ascii?Q?YraV+/kCLexMGyFKCfYqrFa4Wx0Etk5SGzFu3F4aRvNfDLcOCAo/t8GynvhS?=
 =?us-ascii?Q?/F+fsovyT+fvs+pzGG0XnhZu8gp73QxlcBEzomfzqNVRqw/6bs/LHj9ZGNAO?=
 =?us-ascii?Q?W9YZDhQHM1KOhdtsPi3CiE9LFKLVI4LdaO4t4KbRcxu4cS9+0QlqjyrNPDxy?=
 =?us-ascii?Q?w5Ayi2NGfYefuVydL6MD7xpgvRN0Enrm1q63bVvJgOVZ2uLn4ZqZjL8sQ8KG?=
 =?us-ascii?Q?/h/cqIj5225bJZJjw6BfwhB2KvTqlBEGi7HVc174mkqJ71NFj+E+D9rk1vPp?=
 =?us-ascii?Q?tsG30dC3b5tK8CEUBiKbuYXD5ez3TGu0PqW+xtyeYFgFA8WHSM7zVBiEQq1L?=
 =?us-ascii?Q?OyBlDNPAXtuKo4SAqPUhS+JSdsEpplBRKLEMHRbvZXRvLYeUrHSuJRI9GlxX?=
 =?us-ascii?Q?o7TyxeCWlDrsbs0dKM0KpCWcUtJfvMBmwTKW6FH7ZtlJaKbR2UvKsf+H9vG4?=
 =?us-ascii?Q?8n8frJbuZgPJiXWVcFoocTn8bdagLhokOwDNDpfyU4PBMPfNvBdgkT/q46b8?=
 =?us-ascii?Q?tB/d/Cp9Q/Xbp+7sVqf7X6v5gasnm3cqp+UtEk+IgxnHTKXfZY07K5ZIcPDp?=
 =?us-ascii?Q?sbhu63zS4a/2i0XGIBKTHU+rE0cRjse0Z4E27wFLl9S3SSZHJQDkUV/9whz8?=
 =?us-ascii?Q?jD1wmHGG1SXim1b3LJMAdZNTkX+Mba536e4Dne5Jmhsx6rfsroIh9a8YYjRl?=
 =?us-ascii?Q?arSmX7hHO7mQDLzlvJ3Rh58zD35sol+6WlKyvqE8h0Kw/PpNXOjFwzo5OUw0?=
 =?us-ascii?Q?Cqc8yFkL0KWEvDwbia4oRFPx8lcgzRKWt3gdjQQcLxsCaGHhQn8C+n0PKjVr?=
 =?us-ascii?Q?9bko1WydsVw2p7zFerk4RrPGI5tAF11eQd5THr5FDQdiZLjyydbeuNe3n799?=
 =?us-ascii?Q?IhaDfW/3wmI/zQMjdXrONR7anqHq8qwn+u/hJULi8mmEt/pdCfPWJ3XQFBwd?=
 =?us-ascii?Q?Sl+/LXu2NpLaHRs8Yx+F3M4uaz6XLrPRx3KoW1MN/u1Z61Sv7bjLv2qhmIC/?=
 =?us-ascii?Q?wRhuQ7RYyWm0k8eWFCPYq3f/WDN1iD3QYzqpN+2ajv0YzcXFuaul7DMd29vX?=
 =?us-ascii?Q?BhuqrxUvV+7g71h8nzf0R5+pTQwBceo9ohEojpCR/HljC54zuCYfPkaGozgK?=
 =?us-ascii?Q?nZ86tNzgUasXUEse/mOO1bWkOBEjUxTHQ4Pfr6G9hRlyQhMVI91MYqfuN6ym?=
 =?us-ascii?Q?mYA3pwVbCFFED9uS6EEokBmJhkZT5HoaMfqGdCZRCvXTdQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u+kAs4oyqQL0SvVqxZHRo5j3yTq8enU2WyYer0AHs6TL/6OSjeAIqjOqTDlY?=
 =?us-ascii?Q?kkijyK9ZNuMK9fbfY+k3GS1kAbVSM82Ipa3Ma7OKcTj8Ur/tldjBiYj//iRv?=
 =?us-ascii?Q?Dtz8TuErfuXJEr9Pd9iBaySBMREAkeVhEeHI+AarLOyfcgMk76sjh7lyuXdE?=
 =?us-ascii?Q?e+H547BhIJDHPoYER1rxGdZQyRVIwVwKbjHVX7YAoVWeCCE5u2kw3PhzU/Df?=
 =?us-ascii?Q?C2R25bL3pw0NQXlStY+PVvugt4VaRJyuk25whAnnifx/OWQm7ssY0gpHBeM+?=
 =?us-ascii?Q?AVE38onIMdH9RjpzqO4oqRzhbk2wCEif3urdfmemWXXJQIr8SV/pAnq2k9Nx?=
 =?us-ascii?Q?ZYAFoDuiQy0Q/Y4z0Hwz+Ct0S4FoHjLDTGzLNlusxQ9ndZPUlYOWIu8JySez?=
 =?us-ascii?Q?CNO2VnD05ny2KjBXe7StTrX/s7R6zP2VeiwmysTAILKW2medkj1RFYp2OWvD?=
 =?us-ascii?Q?v+MhBsgouw35Z6XBGhPkbZzD+qzPIx8E+7K9PC+5M18V1lGKqhAyEO2sFeKQ?=
 =?us-ascii?Q?AY4zHI8KPyIyORSoIKSlHM3xa1U+03TpDfvb3kG8Z1LKfrw09UN9Ppc3mio3?=
 =?us-ascii?Q?FhB52pmFb6VIyhSJOBd+87xON4Ldu0sfAAm13U/W+LCzO9gcPOTuXS34XO0t?=
 =?us-ascii?Q?hWQuoruQnXK8r7b/85/ry94wZPt3JK1byqsdSaNeZt9H+LnCWeZEQ2jhnWKs?=
 =?us-ascii?Q?N7jPqAT1bEX7WrO/gB+oot9YMke2CosLlyIwZL4GP0u3l5jcc5LiqyH645cq?=
 =?us-ascii?Q?NAtlGFZtmVsi7wzPPGf8Psgu3ken1tIf1/fnhZtoQHnb/lv3GYPMptVS+L/y?=
 =?us-ascii?Q?gpPQh3aYbtgyV3CMWhFHjGGoX2tlTc3AbG/qNMBe2gkzLzjLvrzoFX+B7HFD?=
 =?us-ascii?Q?IFdLz80bHf8k2GUs/xA8ftDHlTiAsTFwFfYsIIEZSYdjqM9FLW6FzBUajiBa?=
 =?us-ascii?Q?0tMKefS3GopXgEIy44EItg6IhkWAYlfJAZc3SttJYTnLrIunNHm+sVmwazio?=
 =?us-ascii?Q?iHiga4z0kzJQQU+oGD99M5l0hxXa/SCvIDp71g9jcx9vPWH5oMvrjMdgd42Y?=
 =?us-ascii?Q?gHOMxPShVe51EuOvpiOR446wUTXT6Z4bnUeDZ7jqw+0hojwpouhJN405qLxz?=
 =?us-ascii?Q?3k2mp+mP+BPrtjt90PaffvkooNkwpHjq/9xR1Xi5B2+yiwnY6F59TrmV8Dph?=
 =?us-ascii?Q?16tzdlgiWn3+5iJmYKrzN24b5OxTMW4bbEIvazIoi4eoFam343bXYutO/iBj?=
 =?us-ascii?Q?OR7YpYgGzZkBc0VGwUwf1lqKa36lQkhHJk3j4BkhmyzM22uNw/k8ZxE9ezjz?=
 =?us-ascii?Q?iJLSZR3+dHD6z4KVE3OCgOAqllept7xSUye61/clzEHkFAfgJncJiMM+Cgzw?=
 =?us-ascii?Q?+uPO5nI6RpMPF4AIM3TdB6/n5cgWs91hMXa1ukFhKP9577/FMKd6kaF8pEzQ?=
 =?us-ascii?Q?HtBxf2SSF+m9o8GkcPZ5vmIh3nUPqtEMAGNKQPvJINeHNtnePD+uPZ9Tug63?=
 =?us-ascii?Q?Gback+/lhhFANyUt8VYScf4fcWWFbYk9KVbFaJrKmltl59oUrHVGDKHhW52x?=
 =?us-ascii?Q?Kx0pA4jl6YX7ML/S+hcqe1rRWDB09ARUYPB55BIO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e786960c-61c8-4b44-4ed3-08dcca844914
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2024 12:47:49.6247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OXkqQSM0nvRBtVHrqxMLB7QkfLBEwEKHWMzE3aZVUjaJPmGLhhVYSXgMWFWk9VxPJXxY4jQF4WfH/NPoLCrfzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8471
X-OriginatorOrg: intel.com

Hi Ian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on perf-tools-next/perf-tools-next]
[also build test WARNING on tip/perf/core perf-tools/perf-tools linus/master v6.11-rc5 next-20240830]
[cannot apply to acme/perf/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ian-Rogers/perf-pmus-Fix-name-comparisons-on-32-bit-systems/20240831-150738
base:   https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
patch link:    https://lore.kernel.org/r/20240831070415.506194-5-irogers%40google.com
patch subject: [PATCH v1 4/6] perf parse-events: Add default_breakpoint_len helper
:::::: branch date: 26 hours ago
:::::: commit date: 26 hours ago
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202409011605.G583kE4G-lkp@intel.com/

includecheck warnings: (new ones prefixed by >>)
>> tools/perf/tests/parse-events.c: parse-events.h is included more than once.

vim +2 tools/perf/tests/parse-events.c

   > 2	#include "parse-events.h"
     3	#include "evsel.h"
     4	#include "evlist.h"
     5	#include <api/fs/fs.h>
     6	#include "tests.h"
     7	#include "debug.h"
   > 8	#include "parse-events.h"
     9	#include "pmu.h"
    10	#include "pmus.h"
    11	#include <dirent.h>
    12	#include <errno.h>
    13	#include "fncache.h"
    14	#include <sys/types.h>
    15	#include <sys/stat.h>
    16	#include <unistd.h>
    17	#include <linux/kernel.h>
    18	#include <linux/hw_breakpoint.h>
    19	#include <api/fs/tracing_path.h>
    20	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

