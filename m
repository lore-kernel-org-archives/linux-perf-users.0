Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12196155759;
	Sun,  8 Dec 2024 15:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733671803; cv=fail; b=ZTrybqcsoK9zhxX3umW+q0qD0Iqjh09P6Wut6oq6+nVu2yolrqcqwPleH8zudEZnCvdKaXJghDG6mTUCUb2S0EWHYIKkRPTJszHgTpTVe+QZRJcpt+mk+TCrxkbsl73L9TKNv0wvHqTWDpLH121TlkJ6U8n07Ow9WGsATFHgKCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733671803; c=relaxed/simple;
	bh=13CEAtuSMvcDoDfXjOGmvFH5+l3lFm/h07ra7pZIARA=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=SwmLx7wZDhGIQTEkB4zvkdoEGgfpXoULURql/2VmhxDGtQi4mBO4smZlMTppALGYmhDc+upNOqwSqcZTtncR0fvw2hlKiM6Y0WlRhbXLa7EHke/OdAJ3stVIWOnJTq9z2mHNQeLMkX6EdQs3sQp4msRiZPSXkKgs9W7ufaz7FBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ntRW3Cm/; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ntRW3Cm/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733671789; x=1765207789;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=13CEAtuSMvcDoDfXjOGmvFH5+l3lFm/h07ra7pZIARA=;
  b=ntRW3Cm/myETDQbSZFn8aHLRo4pc/uN/eirIqpLGZnwLLPFpy97/wC6H
   kYUpt7vPPhOyW7gv6Q04B4bG2TsYK7KhWVgSCkBJGu8ZGoeVJB2HbODYa
   28N8dLg7fpU3/oI1vIGlWxWxUy7r08mzBEjAb3urJjXPn2krwP22cvIwU
   jgcAWy9jonb88ayeuEJeoWgi8yXvhtAXzzLu/qOD4/C4JLuAzdC8eFt+L
   AfT24fi05L3mjXyJe3oSjk3dxSQQa+dM9iYGNkrFBUd366srEZM1Az305
   S7ze1LvXWIzzdVOj6i2AO88L19jBtLDWt13XQuWDYGG+iBsbmk1X2NGls
   A==;
X-CSE-ConnectionGUID: 7c/yNEBQQXeqaLCXHdFGEA==
X-CSE-MsgGUID: Eegzn+NIRHWEvQ89lDGxmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="33898888"
X-IronPort-AV: E=Sophos;i="6.12,217,1728975600"; 
   d="xz'341?yaml'341?scan'341,208,341";a="33898888"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 07:29:47 -0800
X-CSE-ConnectionGUID: fVlHSMz+TFK6iKrrdliydA==
X-CSE-MsgGUID: jG4EPYtlRvyblVnuNcmEBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,217,1728975600"; 
   d="xz'341?yaml'341?scan'341,208,341";a="95329454"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Dec 2024 07:29:46 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 8 Dec 2024 07:29:45 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 8 Dec 2024 07:29:45 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 8 Dec 2024 07:29:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e4TH1AXr2sqN8okSd7fcJXWzrD2ygnGHbvftwbN69HJ+Sk2W/SQATUQk3+wbsUfUV6e402FbFOeOF9dlzNukI6zJdFEZI17LncK+trB7fjM8K1G7Efwvyuf2XUb0VFGt2MuoO29W7Lmxqf2pDjWvSN6mWl1f7iRefbE3dvop3ZhdziJSOAvnCigpwTMuAflRLNxi12X6Qgs783GYGP51CThvasNu2hGDLsrT4TLSHVqNvhYbl43HW/otP7pXjhbYA3oz2tLtNRZMdzuzeEtkZ0tQ9yk1AjPYHdNjbWAGwvAJ3K7GczPz/dMhs4ZuB3XEJ36am3B/j2gjG50vGmnLeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8h+aKAAtCeBEf1Bq6uaCsl+I8ZfaVLjlIUvlf4bNcPk=;
 b=pnYsWc86I9jwKwFABi/pGDWEL05NqAYDzvK3BwwkjfaqdlHLts4AGADK3Q9bcAlxo6z5pSw0CfOnQMPhF2CPLl2GjGaggXB4dkAFSnmZix4L+jNZjTncI6waaRZ/lyXBvmF1HzUw9UiZnBvyL6MSQBsBCpJYZPuIpjaaUhPB/KU8bwbqNvF4IUFlFv2qQ7eVAo8M1FgPMeaVhLoVNx4pk+/1fMGYMyMIGoJCgb+OmzgqJ0r83h20YDWuv+OnNBqsE8Q7QnGTJtarDi7vLpDVKmg9mOJerH1FTTllTXl4vn/ooe0Rnc5Tf3cU713zkngP/R9JxexkM9LxMXG3Ixx9Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS7PR11MB7906.namprd11.prod.outlook.com (2603:10b6:8:ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Sun, 8 Dec
 2024 15:29:35 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8230.010; Sun, 8 Dec 2024
 15:29:35 +0000
Date: Sun, 8 Dec 2024 23:29:25 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	<linux-perf-users@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [tip:perf/core] [perf]  eca51ce01d:
 BUG:KASAN:null-ptr-deref_in_perf_mmap_to_page
Message-ID: <202412082200.aefeb02-lkp@intel.com>
Content-Type: multipart/mixed; boundary="cPUXwabp04B8QD1l"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS7PR11MB7906:EE_
X-MS-Office365-Filtering-Correlation-Id: 09664537-6d61-452b-3d06-08dd179d1e2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nN36Ja6726/ZlWNZemmW3Om3L9qjJFOT80iiLU6jkDHAHe9WeLxOvIFyf6YJ?=
 =?us-ascii?Q?sCW0nbLyA2oQUolui0q9iJVYge3XbcNHhpAhx2k+EvRjvU9WfUJAKGI5y8Re?=
 =?us-ascii?Q?XXuXaWsLMWMiNDEUC4U5gbzPN7ltCh1SRmBSmTCXbCw8gB3whaC1IQVWGhOK?=
 =?us-ascii?Q?BZSpdjlFywdooI53L/oT9xehe5Z7B12WnCs9lTNfXh7AJ6mvGTwFrpziTClk?=
 =?us-ascii?Q?493eB+/wMlYbxNp8BwtQyy+vreerJdMx7bSGOMKkLik+hbz+Vbyk5rERaFOx?=
 =?us-ascii?Q?PtBB5HL2IIHChN1SCHgD1yasyOJBxjDeTMxZHCza/71x00uTt9jcYhw3R8I8?=
 =?us-ascii?Q?SrVYIQpZPLSvgBHCm1e8RFx9KKcRd9NTrgpUL+5YHgiuvUoQnDiTD+Z7L6cb?=
 =?us-ascii?Q?DxSx7JPQXzB5P+5tDuhnNOq9EAcKZwoJbzNjT0gC4EUghQzaKkQ2tsQnp9fU?=
 =?us-ascii?Q?FcKCXYEV9C8ep+YyHx0Z97NK+yiCNnnYtHdHhBUc7F2AXQ1Usy5tG9FNzepk?=
 =?us-ascii?Q?8HcCzIOn8sobcHFAaiDHHA3GEo3HkoGyeTm+6ays+L0ACuy7WPFnsQVQyAaA?=
 =?us-ascii?Q?phfHlZHwhh/SpDooEkLWalPGlxwwOXw06YQgZHKACVtqQQR1kMUPRfIrusMo?=
 =?us-ascii?Q?mY0CqGWoBsI9jJmkDa1zwb5uQI9jEAGNe3Jz2FuaZtwNLq7HYfbsYNQv21UL?=
 =?us-ascii?Q?pI2OR1jvjW8DQYmols5g2zcteWLCxmxuy9Zif0AjIZHS6i2bxC4ruj8vDq1I?=
 =?us-ascii?Q?G1qDSX3WG6/8LgNajat1kykDXUkCPoeUcbCh7H8edG8Y48m9hC7pcBUQ+0WC?=
 =?us-ascii?Q?gQGEBxbYfQdWf6Sz/iyuPRCH3w7czCUF7pxozJS1oEcp+fQ9qYeX+6sB5tXm?=
 =?us-ascii?Q?Yg4GyYkV3cAu/D9fo4lfs7DvwjOaAZVzd4uIyJ9Vqd2GehoVVFL+wlguPs7C?=
 =?us-ascii?Q?6qXbUT2hDnO70zCMldSOxR6EhzIuOSNLdwbajzcgWLBZhoLKiRuOPU5QOD2s?=
 =?us-ascii?Q?UHn2rxT/kufR+Vc2ugroQh65h+OPCwrNdXL01xwIT0idM1KHRCnSTQgZeA8H?=
 =?us-ascii?Q?3T5deh+6ZRLwSSs5bQ69DvHwEaAzist4JUcLvgdPAuMfV4XiF+XSOQwlYNiA?=
 =?us-ascii?Q?v7uUubdB4wxhyVZxBwOyoBBoPrGKUbAoTXcaCPSZeDvq9ixNXMfHanpV9inH?=
 =?us-ascii?Q?prDFEi7mXzjw+uQqd1E6EpQE6Me2Q6IkELrCf8bzMbRoRG9u3+U+G84PA0TC?=
 =?us-ascii?Q?uHAFqikdpx16QHXwtDnXvw3vsbNLU2mmH1C2oD+JFWJS7/ZWBuyGBIiSWfRj?=
 =?us-ascii?Q?HU/CvsdL+2qLBUaumxQcU5cuV5Mno1Be2a/16kQarErio6hhHGfXanIqVfT0?=
 =?us-ascii?Q?wVuAtOk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hySn4E7So74iRkmxERWt9V71W0F5nz07MbG9rEq7ry5Kgea4/hCvQyOLHsQG?=
 =?us-ascii?Q?Y6ULiy5apnjxRu+jNHOtl6XPrPoH716zm+Dxcq/aXwScqasQ1GCyStjBSliG?=
 =?us-ascii?Q?DXKIF+ufXjSyBLqQuBogZi+/eKN7e/sM2LmYqKOpkK5FR2Y+emDkiUX5dRKa?=
 =?us-ascii?Q?luoUpsePgbcCYVatN+X7Ma40IA5KiFv/XKU5PoNwSkmXYq+dHWVjtklNVwm9?=
 =?us-ascii?Q?NgjaXA4WI4beCac+Nn3XqBJYb8v5hbfxDgc/MZGPqBhCdJ67Wz72wXaFY5E3?=
 =?us-ascii?Q?fYAP2YZBMjrSauP7RXq3lbyn+0ESoglrWBppoowLM042ZE3b+VsYsvAaXTYg?=
 =?us-ascii?Q?0b5UEc9ABx0PD+j2VcZZuzHsU0Q6fkcQzZYsgkwhDY05tHkDWN1ZbKH/i1Ox?=
 =?us-ascii?Q?CKyDqpNdrWNLaWgaeHvBmiwww48ZuqsKtNB6yBjnsAdC5/CQzJZ+q5crD9dx?=
 =?us-ascii?Q?JtmLcED9bxd9JFQPIwRwF4mdHTieAdJI50ByDts1bEcbyc7b1EPRm31z8W/W?=
 =?us-ascii?Q?TgmvONrNveFrI9GPLayi7tM6CroFJ0D/YHiWReoWbEijvRg1z1gb6rxuGra1?=
 =?us-ascii?Q?KH3rUZLPZlHAf39PDQnTOs9EE2wIpF6F5IzLW5Y2RDSGzWeysAmTfcwlhA1c?=
 =?us-ascii?Q?HwI9CCy8UQaPb0G5TmQIPik9jqv/LsNCDM1LIslB8S1B5T0J7eurlSeudoq+?=
 =?us-ascii?Q?qGhx/wI3JWKFS+HFkT3PKHm3eHJrdB6O5XBDwaYhMn1oKmxJxqmC6bpcFx6F?=
 =?us-ascii?Q?RiHzvnR79ujibaM5rED/jiS+VgroqW48Aa+8yuPvC1N066KHYxDjTxXnDA3s?=
 =?us-ascii?Q?TosYOmxhG4UPf2KasOwH8STOUwS6jCLN7DvcpGIteaOXjYSRVmPgWbj89Wcu?=
 =?us-ascii?Q?12xbHayJ0e53NFjg2GlSaOeJSoNagjC7R6x/e285CUzTKCqeOt5tuFbirm0o?=
 =?us-ascii?Q?iO7S5VjJLJIty8VFRy0CO81bsqeNOFO3veW6JBx5Yi5arVp37yLTqnBonwEW?=
 =?us-ascii?Q?THJuDHMnzDQ4UVxMyL88zEPtt0gRM9Q07BR/s4Pf6WfB+RJn9kyKeDliX5O9?=
 =?us-ascii?Q?Yws3HPsrBkJqwSQRQMm9qxefWJhkPCeDve1JV/UIpotbFOxSzk2YYc+KXshg?=
 =?us-ascii?Q?1H7CPSqDJeCLIQI9Wvkz7a3FtAENKiqoV3WTvhwgHQ0EE/6LpWdPtmgk65kL?=
 =?us-ascii?Q?Ry1HlCITbGfXwGnDvoxlerpMDNW/YurQOewEjPu5ERpf5tp1AtaRqOv7qwSL?=
 =?us-ascii?Q?oiggrpgmIrRI7rasXc8GxSQG3E8FMit0+UiQ0yANt2codG9bH4zupizYAzuL?=
 =?us-ascii?Q?reluCILioMqitpgvEduN8alFOEH+dEASO27Zse82hj5Q9cUNBNT7FfYWCQb4?=
 =?us-ascii?Q?ELu0ZqrzQDPbjVVGejTuiexIqE/t3rbAwSs4MNcGpms5UPBGnkfGY5hxFCmq?=
 =?us-ascii?Q?rlS2WXht+QAUJw57T7bjInzFTJe1/LLvfEMIrYUu74QiB/Gyz1P+rIz4BbrP?=
 =?us-ascii?Q?ZkIj5ORL+Dt9v2TUpaHg9+gaGZ/plL02xAAbwLOwwJkU/zgxYIRIRW6PDvpg?=
 =?us-ascii?Q?bppeoL+dWwuepNTPYj6EiDcurwTYjVIQeDapNKTN0Cw+SBwo29xJ1aRSSz8e?=
 =?us-ascii?Q?dg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09664537-6d61-452b-3d06-08dd179d1e2d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 15:29:35.1411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EOp9VboMWF9BM+lPbMXcH5oAb+6a6+QcKXP08a6YwqNubh93wJu0dwG18/cOrz59CySTZ7UbRdVEZzwknJre0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7906
X-OriginatorOrg: intel.com

--cPUXwabp04B8QD1l
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline



Hello,

kernel test robot noticed "BUG:KASAN:null-ptr-deref_in_perf_mmap_to_page" on:

commit: eca51ce01d4956ab4b8f06bb55c031f4913fffcb ("perf: Map pages in advance")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git perf/core

[test failed on linux-next/master ebe1b11614e079c5e366ce9bd3c8f44ca0fbcc1b]

in testcase: perf-event-tests
version: perf-event-tests-x86_64-a052241-1_20241102
with following parameters:

	paranoid: not_paranoid_at_all



config: x86_64-rhel-9.4-bpf
compiler: gcc-12
test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202412082200.aefeb02-lkp@intel.com


[ 307.127855][ T2618] BUG: KASAN: null-ptr-deref in perf_mmap_to_page (kernel/events/ring_buffer.c:950)
[  307.127867][ T2618] Read of size 4 at addr 0000000000000178 by task record_mmap/2618
[  307.127872][ T2618]
[  307.133120][  T298]
[  307.140280][ T2618] CPU: 0 UID: 0 PID: 2618 Comm: record_mmap Not tainted 6.13.0-rc1-00027-geca51ce01d49 #1
[  307.140287][ T2618] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.8.1 12/05/2017
[  307.140291][ T2618] Call Trace:
[  307.140294][ T2618]  <TASK>
[ 307.140297][ T2618] dump_stack_lvl (lib/dump_stack.c:124)
[  307.149632][  T298]     Testing PERF_RECORD_FORK...                                PASSED
[ 307.150214][ T2618] kasan_report (mm/kasan/report.c:604)
[ 307.150226][ T2618] ? perf_mmap_to_page (kernel/events/ring_buffer.c:950)
[  307.152429][  T298]
[ 307.162112][ T2618] perf_mmap_to_page (kernel/events/ring_buffer.c:950)
[ 307.162122][ T2618] perf_mmap (kernel/events/core.c:6579 kernel/events/core.c:6819)
[ 307.162135][ T2618] ? __init_rwsem (arch/x86/include/asm/atomic.h:28 include/linux/atomic/atomic-arch-fallback.h:503 include/linux/atomic/atomic-instrumented.h:68 include/linux/osq_lock.h:25 kernel/locking/rwsem.c:326)
[  307.171025][  T298]   + tests/record_sample/record_mmap
[ 307.173349][ T2618] __mmap_new_vma (include/linux/fs.h:2183 mm/internal.h:124 mm/vma.c:2291 mm/vma.c:2355)
[ 307.173364][ T2618] __mmap_region (mm/vma.c:2457)
[  307.176222][  T298]
[ 307.180519][ T2618] ? __pfx___mmap_region (mm/vma.c:2436)
[ 307.180526][ T2618] ? lock_is_held_type (kernel/locking/lockdep.c:5590 kernel/locking/lockdep.c:5921)
[ 307.180582][ T2618] ? vm_unmapped_area (mm/mmap.c:711)
[ 307.244366][ T2618] ? lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5851 kernel/locking/lockdep.c:5814)
[ 307.248898][ T2618] ? mm_get_unmapped_area_vmflags (mm/mmap.c:853)
[ 307.254645][ T2618] mmap_region (mm/mmap.c:1351)
[ 307.258921][ T2618] do_mmap (mm/mmap.c:497)
[ 307.262848][ T2618] ? __pfx_do_mmap (mm/mmap.c:288)
[ 307.267292][ T2618] ? down_write_killable (arch/x86/include/asm/current.h:49 kernel/locking/rwsem.c:143 kernel/locking/rwsem.c:268 kernel/locking/rwsem.c:1303 kernel/locking/rwsem.c:1318 kernel/locking/rwsem.c:1590)
[ 307.272426][ T2618] ? __pfx_down_write_killable (kernel/locking/rwsem.c:1586)
[ 307.277912][ T2618] ? __fget_files (include/linux/rcupdate.h:347 include/linux/rcupdate.h:880 fs/file.c:1050)
[ 307.282455][ T2618] vm_mmap_pgoff (mm/util.c:580)
[ 307.286907][ T2618] ? __pfx_vm_mmap_pgoff (mm/util.c:570)
[ 307.291882][ T2618] ? __fget_files (fs/file.c:1053)
[ 307.296422][ T2618] ksys_mmap_pgoff (mm/mmap.c:542)
[ 307.301050][ T2618] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
[ 307.305415][ T2618] ? __up_write (arch/x86/include/asm/atomic64_64.h:87 include/linux/atomic/atomic-arch-fallback.h:2852 include/linux/atomic/atomic-long.h:268 include/linux/atomic/atomic-instrumented.h:3391 kernel/locking/rwsem.c:1372)
[ 307.309689][ T2618] ? vm_mmap_pgoff (mm/util.c:584)
[ 307.314306][ T2618] ? __pfx_vm_mmap_pgoff (mm/util.c:570)
[ 307.319269][ T2618] ? put_ctx (arch/x86/include/asm/atomic.h:93 include/linux/atomic/atomic-arch-fallback.h:949 include/linux/atomic/atomic-instrumented.h:401 include/linux/refcount.h:264 include/linux/refcount.h:307 include/linux/refcount.h:325 kernel/events/core.c:1223)
[ 307.323279][ T2618] ? mark_held_locks (kernel/locking/lockdep.c:4309)
[ 307.327901][ T2618] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4347 kernel/locking/lockdep.c:4406)
[ 307.333732][ T2618] ? syscall_exit_to_user_mode (arch/x86/include/asm/jump_label.h:36 include/linux/context_tracking_state.h:108 include/linux/context_tracking.h:41 include/linux/entry-common.h:364 kernel/entry/common.c:220)
[ 307.339303][ T2618] ? do_syscall_64 (arch/x86/entry/common.c:102)
[ 307.343834][ T2618] ? __kasan_slab_alloc (mm/kasan/common.c:318 mm/kasan/common.c:345)
[ 307.348711][ T2618] ? rcu_is_watching (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/context_tracking.h:128 kernel/rcu/tree.c:737)
[ 307.353326][ T2618] ? lockdep_init_map_type (kernel/locking/lockdep.c:4980)
[ 307.358551][ T2618] ? __rwlock_init (kernel/locking/spinlock_debug.c:49)
[ 307.362995][ T2618] ? file_f_owner_allocate (fs/fcntl.c:110)
[ 307.368150][ T2618] ? do_fcntl (fs/fcntl.c:440 fs/fcntl.c:530)
[ 307.372347][ T2618] ? __pfx_do_fcntl (fs/fcntl.c:448)
[ 307.376880][ T2618] ? mark_held_locks (kernel/locking/lockdep.c:4309)
[ 307.381499][ T2618] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4347 kernel/locking/lockdep.c:4406)
[ 307.387330][ T2618] ? syscall_exit_to_user_mode (arch/x86/include/asm/jump_label.h:36 include/linux/context_tracking_state.h:108 include/linux/context_tracking.h:41 include/linux/entry-common.h:364 kernel/entry/common.c:220)
[ 307.392898][ T2618] ? do_syscall_64 (arch/x86/entry/common.c:102)
[ 307.397430][ T2618] ? mark_held_locks (kernel/locking/lockdep.c:4309)
[ 307.402050][ T2618] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4347 kernel/locking/lockdep.c:4406)
[ 307.407881][ T2618] ? syscall_exit_to_user_mode (arch/x86/include/asm/jump_label.h:36 include/linux/context_tracking_state.h:108 include/linux/context_tracking.h:41 include/linux/entry-common.h:364 kernel/entry/common.c:220)
[ 307.413451][ T2618] ? do_syscall_64 (arch/x86/entry/common.c:102)
[ 307.417985][ T2618] ? do_user_addr_fault (include/linux/rcupdate.h:347 include/linux/rcupdate.h:880 include/linux/mm.h:741 arch/x86/mm/fault.c:1340)
[ 307.423037][ T2618] ? __rcu_read_unlock (kernel/rcu/tree_plugin.h:440 (discriminator 2))
[ 307.427828][ T2618] ? do_user_addr_fault (include/linux/rcupdate.h:883 include/linux/mm.h:741 arch/x86/mm/fault.c:1340)
[ 307.432877][ T2618] ? mark_held_locks (kernel/locking/lockdep.c:4309)
[ 307.437499][ T2618] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4347 kernel/locking/lockdep.c:4406)
[ 307.443331][ T2618] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
[  307.449076][ T2618] RIP: 0033:0x7f9dbc1c88a3
[ 307.453360][ T2618] Code: ef e8 d1 b4 ff ff eb e7 e8 3a 68 01 00 66 2e 0f 1f 84 00 00 00 00 00 41 89 ca 41 f7 c1 ff 0f 00 00 75 14 b8 09 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 25 c3 0f 1f 40 00 48 8b 05 29 05 0d 00 64 c7
All code
========
   0:	ef                   	out    %eax,(%dx)
   1:	e8 d1 b4 ff ff       	call   0xffffffffffffb4d7
   6:	eb e7                	jmp    0xffffffffffffffef
   8:	e8 3a 68 01 00       	call   0x16847
   d:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  14:	00 00 00 
  17:	41 89 ca             	mov    %ecx,%r10d
  1a:	41 f7 c1 ff 0f 00 00 	test   $0xfff,%r9d
  21:	75 14                	jne    0x37
  23:	b8 09 00 00 00       	mov    $0x9,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 25                	ja     0x57
  32:	c3                   	ret
  33:	0f 1f 40 00          	nopl   0x0(%rax)
  37:	48 8b 05 29 05 0d 00 	mov    0xd0529(%rip),%rax        # 0xd0567
  3e:	64                   	fs
  3f:	c7                   	.byte 0xc7

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 25                	ja     0x2d
   8:	c3                   	ret
   9:	0f 1f 40 00          	nopl   0x0(%rax)
   d:	48 8b 05 29 05 0d 00 	mov    0xd0529(%rip),%rax        # 0xd053d
  14:	64                   	fs
  15:	c7                   	.byte 0xc7
[  307.472788][ T2618] RSP: 002b:00007ffd7c31e008 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
[  307.481042][ T2618] RAX: ffffffffffffffda RBX: 00007ffd7c31e318 RCX: 00007f9dbc1c88a3
[  307.488860][ T2618] RDX: 0000000000000003 RSI: 0000000000009000 RDI: 0000000000000000
[  307.496678][ T2618] RBP: 00007ffd7c31e070 R08: 0000000000000004 R09: 0000000000000000
[  307.504497][ T2618] R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
[  307.512326][ T2618] R13: 00007ffd7c31e328 R14: 000055886087cdd8 R15: 00007f9dbc2e7020
[  307.520166][ T2618]  </TASK>
[  307.523050][ T2618] ==================================================================
[  307.532190][ T2618] Disabling lock debugging due to kernel taint



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



--cPUXwabp04B8QD1l
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.13.0-rc1-00027-geca51ce01d49"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.13.0-rc1 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-12 (Debian 12.2.0-14) 12.2.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=120200
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=24000
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=24000
CONFIG_LLD_VERSION=0
CONFIG_RUSTC_VERSION=0
CONFIG_RUSTC_LLVM_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_GCC_ASM_GOTO_OUTPUT_BROKEN=y
CONFIG_TOOLS_SUPPORT_RELR=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=127
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
CONFIG_UAPI_HEADER_TEST=y
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT="5.14.0-427.20.1.el9_4.x86_64"
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_WATCH_QUEUE=y
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST_IDLE=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_IDLE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING_USER=y
# CONFIG_CONTEXT_TRACKING_USER_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=125
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
# CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
CONFIG_USERMODE_DRIVER=y
CONFIG_BPF_PRELOAD=y
CONFIG_BPF_PRELOAD_UMD=y
CONFIG_BPF_LSM=y
# end of BPF subsystem

CONFIG_PREEMPT_BUILD=y
CONFIG_ARCH_HAS_PREEMPT_LAZY=y
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
# CONFIG_PREEMPT_LAZY is not set
# CONFIG_PREEMPT_RT is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y
CONFIG_PREEMPT_DYNAMIC=y
CONFIG_SCHED_CORE=y
# CONFIG_SCHED_CLASS_EXT is not set

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
CONFIG_PSI=y
CONFIG_PSI_DEFAULT_DISABLED=y
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_NEED_TASKS_RCU=y
CONFIG_TASKS_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# CONFIG_RCU_NOCB_CPU_DEFAULT_ALL is not set
# CONFIG_RCU_LAZY is not set
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_IKHEADERS=m
CONFIG_LOG_BUF_SHIFT=21
CONFIG_LOG_CPU_MAX_BUF_SHIFT=0
CONFIG_PRINTK_INDEX=y
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC10_NO_ARRAY_BOUNDS=y
CONFIG_CC_NO_ARRAY_BOUNDS=y
CONFIG_GCC_NO_STRINGOP_OVERFLOW=y
CONFIG_CC_NO_STRINGOP_OVERFLOW=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_SLAB_OBJ_EXT=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
CONFIG_MEMCG=y
# CONFIG_MEMCG_V1 is not set
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_GROUP_SCHED_WEIGHT=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_SCHED_MM_CID=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
# CONFIG_CPUSETS_V1 is not set
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
CONFIG_CGROUP_MISC=y
CONFIG_CGROUP_DEBUG=y
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
CONFIG_BOOT_CONFIG=y
# CONFIG_BOOT_CONFIG_FORCE is not set
# CONFIG_BOOT_CONFIG_EMBED is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_LD_ORPHAN_WARN_LEVEL="warn"
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
# CONFIG_BASE_SMALL is not set
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_CACHESTAT_SYSCALL=y
# CONFIG_PC104 is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_SELFTEST is not set
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_GUEST_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y

#
# Kexec and crash features
#
CONFIG_CRASH_RESERVE=y
CONFIG_VMCORE_INFO=y
CONFIG_KEXEC_CORE=y
CONFIG_HAVE_IMA_KEXEC=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_KEXEC_SIG=y
# CONFIG_KEXEC_SIG_FORCE is not set
CONFIG_KEXEC_BZIMAGE_VERIFY_SIG=y
CONFIG_KEXEC_JUMP=y
CONFIG_CRASH_DUMP=y
CONFIG_CRASH_HOTPLUG=y
CONFIG_CRASH_MAX_MEMORY_RANGES=8192
# end of Kexec and crash features
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_CSUM=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_X2APIC=y
CONFIG_X86_POSTED_MSI=y
CONFIG_X86_MPPARSE=y
CONFIG_X86_CPU_RESCTRL=y
# CONFIG_X86_FRED is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
CONFIG_X86_AMD_PLATFORM_DEVICE=y
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_XEN=y
# CONFIG_XEN_PV is not set
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
CONFIG_XEN_PVHVM_GUEST=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
# CONFIG_XEN_PVH is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
CONFIG_PVH=y
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
CONFIG_INTEL_TDX_GUEST=y
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
CONFIG_MCORE2=y
# CONFIG_MATOM is not set
# CONFIG_GENERIC_CPU is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_P6_NOP=y
CONFIG_X86_TSC=y
CONFIG_X86_HAVE_PAE=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_GART_IOMMU=y
CONFIG_BOOT_VESA_SUPPORT=y
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_CLUSTER=y
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_ACPI_MADT_WAKEUP=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
CONFIG_PERF_EVENTS_AMD_POWER=m
CONFIG_PERF_EVENTS_AMD_UNCORE=y
CONFIG_PERF_EVENTS_AMD_BRS=y
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_LATE_LOADING=y
# CONFIG_MICROCODE_LATE_FORCE_MINREV is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
CONFIG_X86_CPA_STATISTICS=y
CONFIG_X86_MEM_ENCRYPT=y
CONFIG_AMD_MEM_ENCRYPT=y
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
# CONFIG_X86_KERNEL_IBT is not set
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_ARCH_PKEY_BITS=4
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_X86_SGX=y
# CONFIG_X86_USER_SHADOW_STACK is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_HANDOVER_PROTOCOL=y
CONFIG_EFI_MIXED=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_ARCH_SUPPORTS_KEXEC=y
CONFIG_ARCH_SUPPORTS_KEXEC_FILE=y
CONFIG_ARCH_SELECTS_KEXEC_FILE=y
CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY=y
CONFIG_ARCH_SUPPORTS_KEXEC_SIG=y
CONFIG_ARCH_SUPPORTS_KEXEC_SIG_FORCE=y
CONFIG_ARCH_SUPPORTS_KEXEC_BZIMAGE_VERIFY_SIG=y
CONFIG_ARCH_SUPPORTS_KEXEC_JUMP=y
CONFIG_ARCH_SUPPORTS_CRASH_DUMP=y
CONFIG_ARCH_DEFAULT_CRASH_DUMP=y
CONFIG_ARCH_SUPPORTS_CRASH_HOTPLUG=y
CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x1000000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
CONFIG_HOTPLUG_CPU=y
# CONFIG_COMPAT_VDSO is not set
# CONFIG_LEGACY_VSYSCALL_XONLY is not set
CONFIG_LEGACY_VSYSCALL_NONE=y
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
CONFIG_X86_BUS_LOCK_DETECT=y
# end of Processor type and features

CONFIG_CC_HAS_NAMED_AS=y
CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
CONFIG_CC_HAS_ENTRY_PADDING=y
CONFIG_FUNCTION_PADDING_CFI=11
CONFIG_FUNCTION_PADDING_BYTES=16
CONFIG_CALL_PADDING=y
CONFIG_HAVE_CALL_THUNKS=y
CONFIG_CALL_THUNKS=y
CONFIG_PREFIX_SYMBOLS=y
CONFIG_CPU_MITIGATIONS=y
CONFIG_MITIGATION_PAGE_TABLE_ISOLATION=y
CONFIG_MITIGATION_RETPOLINE=y
CONFIG_MITIGATION_RETHUNK=y
CONFIG_MITIGATION_UNRET_ENTRY=y
CONFIG_MITIGATION_CALL_DEPTH_TRACKING=y
# CONFIG_CALL_THUNKS_DEBUG is not set
CONFIG_MITIGATION_IBPB_ENTRY=y
CONFIG_MITIGATION_IBRS_ENTRY=y
CONFIG_MITIGATION_SRSO=y
# CONFIG_MITIGATION_SLS is not set
CONFIG_MITIGATION_GDS=y
CONFIG_MITIGATION_RFDS=y
CONFIG_MITIGATION_SPECTRE_BHI=y
CONFIG_MITIGATION_MDS=y
CONFIG_MITIGATION_TAA=y
CONFIG_MITIGATION_MMIO_STALE_DATA=y
CONFIG_MITIGATION_L1TF=y
CONFIG_MITIGATION_RETBLEED=y
CONFIG_MITIGATION_SPECTRE_V1=y
CONFIG_MITIGATION_SPECTRE_V2=y
CONFIG_MITIGATION_SRBDS=y
CONFIG_MITIGATION_SSB=y
CONFIG_ARCH_HAS_ADD_PAGES=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_HIBERNATION_COMP_LZO=y
CONFIG_HIBERNATION_DEF_COMP="lzo"
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_USERSPACE_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
CONFIG_PM_GENERIC_DOMAINS=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_PM_GENERIC_DOMAINS_SLEEP=y
CONFIG_ENERGY_MODEL=y
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
CONFIG_ACPI_TABLE_LIB=y
CONFIG_ACPI_THERMAL_LIB=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_PLATFORM_PROFILE=m
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NHLT=y
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
CONFIG_ACPI_HMAT=y
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
CONFIG_ACPI_APEI_EINJ_CXL=y
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
CONFIG_ACPI_DPTF=y
CONFIG_DPTF_POWER=m
CONFIG_DPTF_PCH_FIVR=m
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_ACPI_PFRUT=m
CONFIG_ACPI_PCC=y
CONFIG_ACPI_FFH=y
CONFIG_PMIC_OPREGION=y
CONFIG_ACPI_VIOT=y
CONFIG_ACPI_PRMT=y
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
CONFIG_X86_AMD_PSTATE=y
CONFIG_X86_AMD_PSTATE_DEFAULT_MODE=3
CONFIG_X86_AMD_PSTATE_UT=m
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
CONFIG_CPU_IDLE_GOV_HALTPOLL=y
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_IA32_EMULATION_DEFAULT_DISABLED is not set
# CONFIG_X86_X32_ABI is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
# end of Binary Emulations

CONFIG_KVM_COMMON=y
CONFIG_HAVE_KVM_PFNCACHE=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_DIRTY_RING=y
CONFIG_HAVE_KVM_DIRTY_RING_TSO=y
CONFIG_HAVE_KVM_DIRTY_RING_ACQ_REL=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_READONLY_MEM=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_GENERIC_PRE_FAULT_MEMORY=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_HAVE_KVM_PM_NOTIFIER=y
CONFIG_KVM_GENERIC_HARDWARE_ENABLING=y
CONFIG_KVM_GENERIC_MMU_NOTIFIER=y
CONFIG_KVM_ELIDE_TLB_FLUSH_IF_YOUNG=y
CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES=y
CONFIG_KVM_PRIVATE_MEM=y
CONFIG_KVM_GENERIC_PRIVATE_MEM=y
CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE=y
CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM_X86=m
CONFIG_KVM=m
# CONFIG_KVM_SW_PROTECTED_VM is not set
CONFIG_KVM_INTEL=m
# CONFIG_KVM_INTEL_PROVE_VE is not set
CONFIG_X86_SGX_KVM=y
CONFIG_KVM_AMD=m
CONFIG_KVM_AMD_SEV=y
CONFIG_KVM_SMM=y
CONFIG_KVM_HYPERV=y
# CONFIG_KVM_XEN is not set
# CONFIG_KVM_PROVE_MMU is not set
CONFIG_KVM_MAX_NR_VCPUS=4096
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y
CONFIG_AS_GFNI=y
CONFIG_AS_VAES=y
CONFIG_AS_VPCLMULQDQ=y
CONFIG_AS_WRUSS=y
CONFIG_ARCH_CONFIGURES_CPU_MITIGATIONS=y
CONFIG_ARCH_HAS_DMA_OPS=y

#
# General architecture-dependent options
#
CONFIG_HOTPLUG_SMT=y
CONFIG_HOTPLUG_CORE_SYNC=y
CONFIG_HOTPLUG_CORE_SYNC_DEAD=y
CONFIG_HOTPLUG_CORE_SYNC_FULL=y
CONFIG_HOTPLUG_SPLIT_STARTUP=y
CONFIG_HOTPLUG_PARALLEL=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_KRETPROBE_ON_RETHOOK=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_ARCH_HAS_CPU_FINALIZE_INIT=y
CONFIG_ARCH_HAS_CPU_PASID=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_RUST=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_MMU_GATHER_MERGE_VMAS=y
CONFIG_MMU_LAZY_TLB_REFCOUNT=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_ARCH_HAVE_EXTRA_ELF_NOTES=y
CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_ARCH_SUPPORTS_AUTOFDO_CLANG=y
CONFIG_ARCH_SUPPORTS_PROPELLER_CLANG=y
CONFIG_ARCH_SUPPORTS_CFI_CLANG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING_USER=y
CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_HUGE_VMALLOC=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_PMD_MKWRITE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_ARCH_HAS_EXECMEM_ROX=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_PAGE_SIZE_4KB=y
CONFIG_PAGE_SIZE_4KB=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_PAGE_SHIFT=12
CONFIG_HAVE_OBJTOOL=y
CONFIG_HAVE_JUMP_LABEL_HACK=y
CONFIG_HAVE_NOINSTR_HACK=y
CONFIG_HAVE_NOINSTR_VALIDATION=y
CONFIG_HAVE_UACCESS_VALIDATION=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_ARCH_SUPPORTS_RT=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_ARCH_HAS_CC_PLATFORM=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y
CONFIG_HAVE_ARCH_NODE_DEV_GROUP=y
CONFIG_ARCH_HAS_HW_PTE_YOUNG=y
CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG=y
CONFIG_ARCH_HAS_KERNEL_FPU_SUPPORT=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
CONFIG_FUNCTION_ALIGNMENT_4B=y
CONFIG_FUNCTION_ALIGNMENT_16B=y
CONFIG_FUNCTION_ALIGNMENT=16
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
# CONFIG_MODULE_DEBUG is not set
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
CONFIG_MODVERSIONS=y
CONFIG_ASM_MODVERSIONS=y
CONFIG_MODULE_SRCVERSION_ALL=y
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA256 is not set
# CONFIG_MODULE_SIG_SHA384 is not set
CONFIG_MODULE_SIG_SHA512=y
# CONFIG_MODULE_SIG_SHA3_256 is not set
# CONFIG_MODULE_SIG_SHA3_384 is not set
# CONFIG_MODULE_SIG_SHA3_512 is not set
CONFIG_MODULE_SIG_HASH="sha512"
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/usr/sbin/modprobe"
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_CGROUP_PUNT_BIO=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_WRITE_MOUNTED=y
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_MQ=y
CONFIG_BLK_CGROUP_IOLATENCY=y
CONFIG_BLK_CGROUP_FC_APPID=y
# CONFIG_BLK_CGROUP_IOCOST is not set
# CONFIG_BLK_CGROUP_IOPRIO is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y
CONFIG_BLK_MQ_STACKING=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_ZPOOL=y
CONFIG_SWAP=y
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_DEFAULT_ON is not set
# CONFIG_ZSWAP_SHRINKER_DEFAULT_ON is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD_DEPRECATED is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
CONFIG_ZBUD=y
# CONFIG_Z3FOLD_DEPRECATED is not set
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y
CONFIG_ZSMALLOC_CHAIN_SIZE=8

#
# Slab allocator options
#
CONFIG_SLUB=y
# CONFIG_SLUB_TINY is not set
# CONFIG_SLAB_MERGE_DEFAULT is not set
CONFIG_SLAB_FREELIST_RANDOM=y
CONFIG_SLAB_FREELIST_HARDENED=y
CONFIG_SLAB_BUCKETS=y
# CONFIG_SLUB_STATS is not set
CONFIG_SLUB_CPU_PARTIAL=y
# CONFIG_RANDOM_KMALLOC_CACHES is not set
# end of Slab allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_ARCH_WANT_OPTIMIZE_DAX_VMEMMAP=y
CONFIG_ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP=y
CONFIG_HAVE_GUP_FAST=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y
CONFIG_SPLIT_PTE_PTLOCKS=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_SPLIT_PMD_PTLOCKS=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_DEVICE_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PCP_BATCH_SCALE_MAX=5
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=65536
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
# CONFIG_TRANSPARENT_HUGEPAGE_NEVER is not set
CONFIG_THP_SWAP=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_PGTABLE_HAS_HUGE_LEAVES=y
CONFIG_ARCH_SUPPORTS_HUGE_PFNMAP=y
CONFIG_ARCH_SUPPORTS_PMD_PFNMAP=y
CONFIG_ARCH_SUPPORTS_PUD_PFNMAP=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_SYSFS=y
CONFIG_CMA_AREAS=7
CONFIG_MEM_SOFT_DIRTY=y
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_ZONE_DEVICE=y
CONFIG_HMM_MIRROR=y
CONFIG_GET_FREE_REGION=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
CONFIG_ARCH_USES_PG_ARCH_2=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
# CONFIG_DMAPOOL_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_MAPPING_DIRTY_HELPERS=y
CONFIG_MEMFD_CREATE=y
CONFIG_SECRETMEM=y
# CONFIG_ANON_VMA_NAME is not set
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_USERFAULTFD=y
# CONFIG_PTE_MARKER_UFFD_WP is not set
CONFIG_LRU_GEN=y
CONFIG_LRU_GEN_ENABLED=y
# CONFIG_LRU_GEN_STATS is not set
CONFIG_LRU_GEN_WALKS_MMU=y
CONFIG_ARCH_SUPPORTS_PER_VMA_LOCK=y
CONFIG_PER_VMA_LOCK=y
CONFIG_LOCK_MM_AND_FIND_VMA=y
CONFIG_IOMMU_MM_DATA=y
CONFIG_EXECMEM=y
CONFIG_NUMA_MEMBLKS=y
CONFIG_NUMA_EMU=y

#
# Data Access Monitoring
#
CONFIG_DAMON=y
CONFIG_DAMON_VADDR=y
CONFIG_DAMON_PADDR=y
CONFIG_DAMON_SYSFS=y
# CONFIG_DAMON_DBGFS_DEPRECATED is not set
CONFIG_DAMON_RECLAIM=y
# CONFIG_DAMON_LRU_SORT is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_NET_XGRESS=y
CONFIG_NET_REDIRECT=y
CONFIG_SKB_DECRYPTED=y
CONFIG_SKB_EXTENSIONS=y
CONFIG_NET_DEVMEM=y
CONFIG_NET_SHAPER=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=y
CONFIG_UNIX=y
CONFIG_AF_UNIX_OOB=y
CONFIG_UNIX_DIAG=y
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
CONFIG_XFRM_INTERFACE=m
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
CONFIG_XFRM_ESPINTCP=y
# CONFIG_SMC is not set
CONFIG_XDP_SOCKETS=y
CONFIG_XDP_SOCKETS_DIAG=y
CONFIG_NET_HANDSHAKE=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
CONFIG_NET_FOU=m
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
CONFIG_INET_ESPINTCP=y
CONFIG_INET_IPCOMP=m
CONFIG_INET_TABLE_PERTURB_ORDER=16
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
CONFIG_INET_DIAG_DESTROY=y
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
# CONFIG_TCP_CONG_HSTCP is not set
# CONFIG_TCP_CONG_HYBLA is not set
# CONFIG_TCP_CONG_VEGAS is not set
CONFIG_TCP_CONG_NV=m
# CONFIG_TCP_CONG_SCALABLE is not set
# CONFIG_TCP_CONG_LP is not set
# CONFIG_TCP_CONG_VENO is not set
# CONFIG_TCP_CONG_YEAH is not set
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
CONFIG_TCP_CONG_BBR=m
# CONFIG_DEFAULT_CUBIC is not set
CONFIG_DEFAULT_RENO=y
CONFIG_DEFAULT_TCP_CONG="reno"
CONFIG_TCP_SIGPOOL=y
# CONFIG_TCP_AO is not set
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
CONFIG_INET6_ESPINTCP=y
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=y
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=y
CONFIG_IPV6_GRE=m
CONFIG_IPV6_FOU=m
CONFIG_IPV6_FOU_TUNNEL=m
CONFIG_IPV6_MULTIPLE_TABLES=y
CONFIG_IPV6_SUBTREES=y
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
CONFIG_IPV6_SEG6_HMAC=y
CONFIG_IPV6_SEG6_BPF=y
# CONFIG_IPV6_RPL_LWTUNNEL is not set
CONFIG_IPV6_IOAM6_LWTUNNEL=y
CONFIG_NETLABEL=y
CONFIG_MPTCP=y
CONFIG_INET_MPTCP_DIAG=m
CONFIG_MPTCP_IPV6=y
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_EGRESS=y
CONFIG_NETFILTER_SKIP_EGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
CONFIG_NETFILTER_BPF_LINK=y
CONFIG_NETFILTER_NETLINK_HOOK=m
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_SYSLOG=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CONNTRACK_OVS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NF_NAT_OVS=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_FLOW_OFFLOAD=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
CONFIG_NFT_TUNNEL=m
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
CONFIG_NFT_XFRM=m
CONFIG_NFT_SOCKET=m
CONFIG_NFT_OSF=m
CONFIG_NFT_TPROXY=m
CONFIG_NFT_SYNPROXY=m
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
CONFIG_NFT_REJECT_NETDEV=m
CONFIG_NF_FLOW_TABLE_INET=m
CONFIG_NF_FLOW_TABLE=m
CONFIG_NF_FLOW_TABLE_PROCFS=y
CONFIG_NETFILTER_XTABLES=m
# CONFIG_NETFILTER_XTABLES_COMPAT is not set

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
CONFIG_IP_VS_MH=m
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m
# CONFIG_IP_VS_TWOS is not set

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_IP_NF_IPTABLES_LEGACY=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_NFT_COMPAT_ARP=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_IP6_NF_IPTABLES_LEGACY=m
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
# CONFIG_IP6_NF_TARGET_HL is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_TABLES_BRIDGE=m
CONFIG_NFT_BRIDGE_META=m
CONFIG_NFT_BRIDGE_REJECT=m
CONFIG_NF_CONNTRACK_BRIDGE=m
CONFIG_BRIDGE_NF_EBTABLES_LEGACY=m
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
CONFIG_IP_DCCP=m
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=y
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=y
# end of DCCP CCIDs Configuration

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
# end of DCCP Kernel Hacking

CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
CONFIG_TIPC=m
CONFIG_TIPC_MEDIA_IB=y
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_CRYPTO=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
# CONFIG_6LOWPAN_NHC is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_IEEE802154_6LOWPAN=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
# CONFIG_NET_SCH_SFB is not set
CONFIG_NET_SCH_SFQ=m
# CONFIG_NET_SCH_TEQL is not set
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_CBS=m
CONFIG_NET_SCH_ETF=m
CONFIG_NET_SCH_MQPRIO_LIB=m
CONFIG_NET_SCH_TAPRIO=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_NETEM=m
# CONFIG_NET_SCH_DRR is not set
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
# CONFIG_NET_SCH_CHOKE is not set
# CONFIG_NET_SCH_QFQ is not set
# CONFIG_NET_SCH_CODEL is not set
CONFIG_NET_SCH_FQ_CODEL=m
CONFIG_NET_SCH_CAKE=m
CONFIG_NET_SCH_FQ=m
# CONFIG_NET_SCH_HHF is not set
# CONFIG_NET_SCH_PIE is not set
CONFIG_NET_SCH_INGRESS=m
# CONFIG_NET_SCH_PLUG is not set
CONFIG_NET_SCH_ETS=m
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="fq_codel"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
# CONFIG_NET_CLS_ROUTE4 is not set
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
# CONFIG_NET_EMATCH_CMP is not set
# CONFIG_NET_EMATCH_NBYTE is not set
# CONFIG_NET_EMATCH_U32 is not set
# CONFIG_NET_EMATCH_META is not set
# CONFIG_NET_EMATCH_TEXT is not set
# CONFIG_NET_EMATCH_CANID is not set
# CONFIG_NET_EMATCH_IPSET is not set
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
# CONFIG_NET_ACT_NAT is not set
CONFIG_NET_ACT_PEDIT=m
# CONFIG_NET_ACT_SIMP is not set
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
CONFIG_NET_ACT_MPLS=m
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=y
# CONFIG_NET_ACT_CONNMARK is not set
CONFIG_NET_ACT_CTINFO=m
# CONFIG_NET_ACT_SKBMOD is not set
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
CONFIG_NET_ACT_CT=m
# CONFIG_NET_ACT_GATE is not set
CONFIG_NET_TC_SKB_EXT=y
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_OPENVSWITCH_VXLAN=m
CONFIG_OPENVSWITCH_GENEVE=m
CONFIG_VSOCKETS=y
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=y
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
CONFIG_HSR=m
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
CONFIG_QRTR=m
# CONFIG_QRTR_TUN is not set
CONFIG_QRTR_MHI=m
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_MAX_SKB_FRAGS=17
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
CONFIG_CAN_J1939=m
CONFIG_CAN_ISOTP=m
CONFIG_BT=m
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_HIDP=m
CONFIG_BT_LE=y
CONFIG_BT_LE_L2CAP_ECRED=y
# CONFIG_BT_6LOWPAN is not set
# CONFIG_BT_LEDS is not set
# CONFIG_BT_MSFTEXT is not set
# CONFIG_BT_AOSPEXT is not set
CONFIG_BT_DEBUGFS=y
# CONFIG_BT_SELFTEST is not set

#
# Bluetooth device drivers
#
CONFIG_BT_INTEL=m
CONFIG_BT_BCM=m
CONFIG_BT_RTL=m
CONFIG_BT_MTK=m
CONFIG_BT_HCIBTUSB=m
CONFIG_BT_HCIBTUSB_AUTOSUSPEND=y
CONFIG_BT_HCIBTUSB_POLL_SYNC=y
CONFIG_BT_HCIBTUSB_BCM=y
CONFIG_BT_HCIBTUSB_MTK=y
CONFIG_BT_HCIBTUSB_RTL=y
CONFIG_BT_HCIBTSDIO=m
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_ATH3K=y
# CONFIG_BT_HCIUART_INTEL is not set
# CONFIG_BT_HCIUART_AG6XX is not set
CONFIG_BT_HCIBCM203X=m
# CONFIG_BT_HCIBCM4377 is not set
CONFIG_BT_HCIBPA10X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
CONFIG_BT_MRVL_SDIO=m
CONFIG_BT_ATH3K=m
# CONFIG_BT_MTKSDIO is not set
# CONFIG_BT_VIRTIO is not set
# CONFIG_BT_INTEL_PCIE is not set
# end of Bluetooth device drivers

CONFIG_AF_RXRPC=m
CONFIG_AF_RXRPC_IPV6=y
# CONFIG_AF_RXRPC_INJECT_LOSS is not set
# CONFIG_AF_RXRPC_INJECT_RX_DELAY is not set
CONFIG_AF_RXRPC_DEBUG=y
CONFIG_RXKAD=y
CONFIG_RXPERF=m
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
# CONFIG_MCTP is not set
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
# CONFIG_CFG80211_WEXT is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
# CONFIG_MAC80211_MESH is not set
CONFIG_MAC80211_LEDS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_XEN is not set
# CONFIG_NET_9P_RDMA is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
CONFIG_PAGE_POOL_STATS=y
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIEAER_CXL=y
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
CONFIG_PCIE_PTM=y
CONFIG_PCIE_EDR=y
CONFIG_PCI_MSI=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=m
CONFIG_PCI_ATS=y
CONFIG_PCI_DOE=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
# CONFIG_PCI_NPEM is not set
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCIE_TPH is not set
CONFIG_PCI_P2PDMA=y
CONFIG_PCI_LABEL=y
CONFIG_PCI_HYPERV=m
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
# CONFIG_HOTPLUG_PCI_OCTEONEP is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y
CONFIG_PCI_HYPERV_INTERFACE=m

#
# Cadence-based PCIe controllers
#
# end of Cadence-based PCIe controllers

#
# DesignWare-based PCIe controllers
#
# CONFIG_PCI_MESON is not set
# CONFIG_PCIE_DW_PLAT_HOST is not set
# end of DesignWare-based PCIe controllers

#
# Mobiveil-based PCIe controllers
#
# end of Mobiveil-based PCIe controllers

#
# PLDA-based PCIe controllers
#
# end of PLDA-based PCIe controllers
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

CONFIG_CXL_BUS=m
CONFIG_CXL_PCI=m
# CONFIG_CXL_MEM_RAW_COMMANDS is not set
CONFIG_CXL_ACPI=m
CONFIG_CXL_PMEM=m
CONFIG_CXL_MEM=m
CONFIG_CXL_PORT=m
CONFIG_CXL_SUSPEND=y
CONFIG_CXL_REGION=y
# CONFIG_CXL_REGION_INVALIDATION_TEST is not set
CONFIG_PCCARD=y
# CONFIG_PCMCIA is not set
# CONFIG_CARDBUS is not set

#
# PC-card bridges
#
# CONFIG_YENTA is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_DEVTMPFS_SAFE=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_DEBUG=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
CONFIG_FW_LOADER_COMPRESS=y
CONFIG_FW_LOADER_COMPRESS_XZ=y
CONFIG_FW_LOADER_COMPRESS_ZSTD=y
# CONFIG_FW_CACHE is not set
CONFIG_FW_UPLOAD=y
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_HMEM_REPORTING=y
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_DEVICES=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_SOUNDWIRE=m
CONFIG_REGMAP_SOUNDWIRE_MBQ=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT is not set
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_MHI_BUS=m
# CONFIG_MHI_BUS_DEBUG is not set
CONFIG_MHI_BUS_PCI_GENERIC=m
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

#
# Cache Drivers
#
# end of Cache Drivers

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_ISCSI_IBFT_FIND=y
CONFIG_ISCSI_IBFT=m
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_SYSFB=y
# CONFIG_SYSFB_SIMPLEFB is not set
CONFIG_FW_CS_DSP=m
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_SOFT_RESERVE=y
CONFIG_EFI_DXE_MEM_ATTRIBUTES=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
CONFIG_EFI_DEV_PATH_PARSER=y
CONFIG_APPLE_PROPERTIES=y
# CONFIG_RESET_ATTACK_MITIGATION is not set
CONFIG_EFI_RCI2_TABLE=y
# CONFIG_EFI_DISABLE_PCI_DMA is not set
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y
# CONFIG_EFI_DISABLE_RUNTIME is not set
CONFIG_EFI_COCO_SECRET=y
CONFIG_UNACCEPTED_MEMORY=y
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y

#
# Qualcomm firmware drivers
#
# end of Qualcomm firmware drivers

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_GNSS=m
# CONFIG_GNSS_USB is not set
CONFIG_MTD=m
# CONFIG_MTD_TESTS is not set

#
# Partition parsers
#
# CONFIG_MTD_CMDLINE_PARTS is not set
# CONFIG_MTD_REDBOOT_PARTS is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=m
CONFIG_MTD_BLOCK=m
# CONFIG_MTD_BLOCK_RO is not set

#
# Note that in some cases UBI block is preferred. See MTD_UBI_BLOCK.
#
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set
# CONFIG_SM_FTL is not set
# CONFIG_MTD_OOPS is not set
# CONFIG_MTD_SWAP is not set
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
# CONFIG_MTD_CFI is not set
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_PLATRAM is not set
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_DATAFLASH is not set
# CONFIG_MTD_MCHP23K256 is not set
# CONFIG_MTD_MCHP48L640 is not set
# CONFIG_MTD_SST25L is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# end of Self-contained MTD device drivers

#
# NAND
#
# CONFIG_MTD_ONENAND is not set
# CONFIG_MTD_RAW_NAND is not set
# CONFIG_MTD_SPI_NAND is not set

#
# ECC engine support
#
# CONFIG_MTD_NAND_ECC_SW_HAMMING is not set
# CONFIG_MTD_NAND_ECC_SW_BCH is not set
# CONFIG_MTD_NAND_ECC_MXIC is not set
# end of ECC engine support
# end of NAND

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
# end of LPDDR & LPDDR2 PCM memory drivers

# CONFIG_MTD_SPI_NOR is not set
CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
# CONFIG_MTD_UBI_GLUEBI is not set
# CONFIG_MTD_UBI_BLOCK is not set
# CONFIG_MTD_UBI_FAULT_INJECTION is not set
# CONFIG_MTD_UBI_NVMEM is not set
# CONFIG_MTD_HYPERBUS is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
CONFIG_ZRAM=m
# CONFIG_ZRAM_BACKEND_LZ4 is not set
# CONFIG_ZRAM_BACKEND_LZ4HC is not set
# CONFIG_ZRAM_BACKEND_ZSTD is not set
# CONFIG_ZRAM_BACKEND_DEFLATE is not set
# CONFIG_ZRAM_BACKEND_842 is not set
CONFIG_ZRAM_BACKEND_FORCE_LZO=y
CONFIG_ZRAM_BACKEND_LZO=y
CONFIG_ZRAM_DEF_COMP_LZORLE=y
# CONFIG_ZRAM_DEF_COMP_LZO is not set
CONFIG_ZRAM_DEF_COMP="lzo-rle"
CONFIG_ZRAM_WRITEBACK=y
# CONFIG_ZRAM_TRACK_ENTRY_ACTIME is not set
# CONFIG_ZRAM_MEMORY_TRACKING is not set
# CONFIG_ZRAM_MULTI_COMP is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_XEN_BLKDEV_FRONTEND=m
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_UBLK is not set

#
# NVME Support
#
CONFIG_NVME_AUTH=m
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_VERBOSE_ERRORS=y
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
CONFIG_NVME_RDMA=m
CONFIG_NVME_FC=m
CONFIG_NVME_TCP=m
# CONFIG_NVME_TCP_TLS is not set
# CONFIG_NVME_HOST_AUTH is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_DEBUGFS is not set
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_RDMA=m
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
CONFIG_NVME_TARGET_TCP=m
# CONFIG_NVME_TARGET_TCP_TLS is not set
CONFIG_NVME_TARGET_AUTH=y
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_RPMB is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=m
# CONFIG_NSM is not set
# CONFIG_MCHP_LAN966X_PCI is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=y
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y
CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
CONFIG_INTEL_MEI_GSC=m
# CONFIG_INTEL_MEI_VSC_HW is not set
# CONFIG_INTEL_MEI_HDCP is not set
# CONFIG_INTEL_MEI_PXP is not set
CONFIG_INTEL_MEI_GSC_PROXY=m
CONFIG_VMWARE_VMCI=m
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=m
CONFIG_MISC_RTSX_USB=m
# CONFIG_UACCE is not set
CONFIG_PVPANIC=y
CONFIG_PVPANIC_MMIO=m
# CONFIG_PVPANIC_PCI is not set
# CONFIG_GP_PCI1XXXX is not set
# CONFIG_KEBA_CP500 is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_BLK_DEV_BSG=y
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
CONFIG_ISCSI_TCP=m
CONFIG_ISCSI_BOOT_SYSFS=m
# CONFIG_SCSI_CXGB3_ISCSI is not set
CONFIG_SCSI_CXGB4_ISCSI=m
CONFIG_SCSI_BNX2_ISCSI=m
CONFIG_SCSI_BNX2X_FCOE=m
CONFIG_BE2ISCSI=m
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
CONFIG_SCSI_HPSA=m
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
CONFIG_SCSI_AACRAID=m
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
CONFIG_MEGARAID_NEWGEN=y
CONFIG_MEGARAID_MM=m
CONFIG_MEGARAID_MAILBOX=m
CONFIG_MEGARAID_LEGACY=m
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=m
CONFIG_SCSI_MPI3MR=m
CONFIG_SCSI_SMARTPQI=m
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
CONFIG_VMWARE_PVSCSI=m
# CONFIG_XEN_SCSI_FRONTEND is not set
CONFIG_HYPERV_STORAGE=m
CONFIG_LIBFC=m
CONFIG_LIBFCOE=m
# CONFIG_FCOE is not set
CONFIG_FCOE_FNIC=m
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA_FC=m
# CONFIG_TCM_QLA2XXX is not set
CONFIG_SCSI_QLA_ISCSI=m
CONFIG_QEDI=m
CONFIG_QEDF=m
CONFIG_SCSI_LPFC=m
# CONFIG_SCSI_LPFC_DEBUG_FS is not set
# CONFIG_SCSI_EFCT is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
CONFIG_SCSI_VIRTIO=m
CONFIG_SCSI_CHELSIO_FCOE=m
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_AHCI_DWC is not set
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_RZ1000 is not set
# CONFIG_PATA_PARPORT is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_BITMAP_FILE=y
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
# CONFIG_MD_CLUSTER is not set
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
CONFIG_DM_MULTIPATH_HST=m
CONFIG_DM_MULTIPATH_IOA=m
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG=y
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG_SECONDARY_KEYRING is not set
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG_PLATFORM_KEYRING is not set
CONFIG_DM_VERITY_FEC=y
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
# CONFIG_DM_ZONED is not set
CONFIG_DM_AUDIT=y
# CONFIG_DM_VDO is not set
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_TCM_FC=m
CONFIG_ISCSI_TARGET=m
CONFIG_ISCSI_TARGET_CXGB4=m
# CONFIG_REMOTE_TARGET is not set
CONFIG_FUSION=y
CONFIG_FUSION_SPI=m
# CONFIG_FUSION_FC is not set
CONFIG_FUSION_SAS=m
CONFIG_FUSION_MAX_SGE=128
# CONFIG_FUSION_CTL is not set
CONFIG_FUSION_LOGGING=y

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
CONFIG_BONDING=m
CONFIG_DUMMY=m
CONFIG_WIREGUARD=m
# CONFIG_WIREGUARD_DEBUG is not set
# CONFIG_EQUALIZER is not set
CONFIG_NET_FC=y
CONFIG_IFB=m
CONFIG_NET_TEAM=m
CONFIG_NET_TEAM_MODE_BROADCAST=m
CONFIG_NET_TEAM_MODE_ROUNDROBIN=m
CONFIG_NET_TEAM_MODE_RANDOM=m
CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=m
CONFIG_NET_TEAM_MODE_LOADBALANCE=m
CONFIG_MACVLAN=m
CONFIG_MACVTAP=m
CONFIG_IPVLAN_L3S=y
CONFIG_IPVLAN=m
CONFIG_IPVTAP=m
CONFIG_VXLAN=m
CONFIG_GENEVE=m
CONFIG_BAREUDP=m
# CONFIG_GTP is not set
# CONFIG_PFCP is not set
CONFIG_AMT=m
CONFIG_MACSEC=m
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
# CONFIG_NETCONSOLE_EXTENDED_LOG is not set
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_NTB_NETDEV=m
CONFIG_TUN=m
CONFIG_TAP=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=m
CONFIG_NLMON=m
CONFIG_NETKIT=y
CONFIG_NET_VRF=m
CONFIG_VSOCKMON=m
CONFIG_MHI_NET=m
# CONFIG_ARCNET is not set
# CONFIG_ATM_DRIVERS is not set
CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
# CONFIG_NET_VENDOR_AGERE is not set
# CONFIG_NET_VENDOR_ALACRITECH is not set
# CONFIG_NET_VENDOR_ALTEON is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
CONFIG_ENA_ETHERNET=m
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
CONFIG_AMD_XGBE=m
# CONFIG_AMD_XGBE_DCB is not set
CONFIG_AMD_XGBE_HAVE_ECC=y
# CONFIG_PDS_CORE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_AQTION=m
# CONFIG_NET_VENDOR_ARC is not set
CONFIG_NET_VENDOR_ASIX=y
# CONFIG_SPI_AX88796C is not set
CONFIG_NET_VENDOR_ATHEROS=y
CONFIG_ATL2=m
CONFIG_ATL1=m
CONFIG_ATL1E=m
CONFIG_ATL1C=m
CONFIG_ALX=m
# CONFIG_CX_ECAT is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
CONFIG_BCMGENET=m
CONFIG_BNX2=m
CONFIG_CNIC=m
CONFIG_TIGON3=m
CONFIG_TIGON3_HWMON=y
CONFIG_BNX2X=m
CONFIG_BNX2X_SRIOV=y
# CONFIG_SYSTEMPORT is not set
CONFIG_BNXT=m
CONFIG_BNXT_SRIOV=y
CONFIG_BNXT_FLOWER_OFFLOAD=y
CONFIG_BNXT_DCB=y
# CONFIG_BNXT_HWMON is not set
# CONFIG_NET_VENDOR_CADENCE is not set
# CONFIG_NET_VENDOR_CAVIUM is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
CONFIG_CHELSIO_T4=m
# CONFIG_CHELSIO_T4_DCB is not set
CONFIG_CHELSIO_T4VF=m
CONFIG_CHELSIO_LIB=m
CONFIG_CHELSIO_INLINE_CRYPTO=y
CONFIG_CHELSIO_IPSEC_INLINE=m
CONFIG_CHELSIO_TLS_DEVICE=m
CONFIG_NET_VENDOR_CISCO=y
CONFIG_ENIC=m
# CONFIG_NET_VENDOR_CORTINA is not set
CONFIG_NET_VENDOR_DAVICOM=y
# CONFIG_DM9051 is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
CONFIG_DL2K=m
CONFIG_NET_VENDOR_EMULEX=y
CONFIG_BE2NET=m
CONFIG_BE2NET_HWMON=y
# CONFIG_BE2NET_BE2 is not set
# CONFIG_BE2NET_BE3 is not set
CONFIG_BE2NET_LANCER=y
CONFIG_BE2NET_SKYHAWK=y
CONFIG_NET_VENDOR_ENGLEDER=y
# CONFIG_TSNEP is not set
# CONFIG_NET_VENDOR_EZCHIP is not set
CONFIG_NET_VENDOR_FUNGIBLE=y
# CONFIG_FUN_ETH is not set
CONFIG_NET_VENDOR_GOOGLE=y
CONFIG_GVE=m
CONFIG_NET_VENDOR_HISILICON=y
# CONFIG_HIBMCGE is not set
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_HINIC=m
# CONFIG_NET_VENDOR_I825XX is not set
CONFIG_NET_VENDOR_INTEL=y
CONFIG_LIBETH=y
CONFIG_LIBIE=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
CONFIG_IGBVF=m
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
CONFIG_IXGBE_DCB=y
CONFIG_IXGBE_IPSEC=y
CONFIG_IXGBEVF=m
CONFIG_IXGBEVF_IPSEC=y
CONFIG_I40E=y
CONFIG_I40E_DCB=y
CONFIG_IAVF=m
CONFIG_I40EVF=m
CONFIG_ICE=m
CONFIG_ICE_HWMON=y
CONFIG_ICE_SWITCHDEV=y
CONFIG_ICE_HWTS=y
CONFIG_FM10K=m
CONFIG_IGC=y
CONFIG_IDPF=m
# CONFIG_IDPF_SINGLEQ is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_ADI=y
# CONFIG_ADIN1110 is not set
CONFIG_NET_VENDOR_LITEX=y
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_OCTEON_EP=m
# CONFIG_OCTEON_EP_VF is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
CONFIG_MLX4_EN=m
CONFIG_MLX4_EN_DCB=y
CONFIG_MLX4_CORE=m
CONFIG_MLX4_DEBUG=y
# CONFIG_MLX4_CORE_GEN2 is not set
CONFIG_MLX5_CORE=m
CONFIG_MLX5_FPGA=y
CONFIG_MLX5_CORE_EN=y
CONFIG_MLX5_EN_ARFS=y
CONFIG_MLX5_EN_RXNFC=y
CONFIG_MLX5_MPFS=y
CONFIG_MLX5_ESWITCH=y
CONFIG_MLX5_BRIDGE=y
CONFIG_MLX5_CLS_ACT=y
CONFIG_MLX5_TC_CT=y
CONFIG_MLX5_TC_SAMPLE=y
CONFIG_MLX5_CORE_EN_DCB=y
CONFIG_MLX5_CORE_IPOIB=y
# CONFIG_MLX5_MACSEC is not set
CONFIG_MLX5_EN_IPSEC=y
CONFIG_MLX5_EN_TLS=y
CONFIG_MLX5_SW_STEERING=y
CONFIG_MLX5_HW_STEERING=y
CONFIG_MLX5_SF=y
CONFIG_MLX5_SF_MANAGER=y
# CONFIG_MLX5_DPLL is not set
CONFIG_MLXSW_CORE=m
CONFIG_MLXSW_CORE_HWMON=y
CONFIG_MLXSW_CORE_THERMAL=y
CONFIG_MLXSW_PCI=m
CONFIG_MLXSW_I2C=m
CONFIG_MLXSW_SPECTRUM=m
CONFIG_MLXSW_SPECTRUM_DCB=y
CONFIG_MLXSW_MINIMAL=m
CONFIG_MLXFW=m
CONFIG_NET_VENDOR_META=y
# CONFIG_FBNIC is not set
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MICROCHIP is not set
# CONFIG_NET_VENDOR_MICROSEMI is not set
CONFIG_NET_VENDOR_MICROSOFT=y
CONFIG_MICROSOFT_MANA=m
CONFIG_NET_VENDOR_MYRI=y
CONFIG_MYRI10GE=m
CONFIG_MYRI10GE_DCA=y
# CONFIG_FEALNX is not set
# CONFIG_NET_VENDOR_NI is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
# CONFIG_NET_VENDOR_NETERION is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NFP=m
CONFIG_NFP_APP_FLOWER=y
CONFIG_NFP_APP_ABM_NIC=y
CONFIG_NFP_NET_IPSEC=y
# CONFIG_NFP_DEBUG is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
# CONFIG_OA_TC6 is not set
# CONFIG_NET_VENDOR_PACKET_ENGINES is not set
CONFIG_NET_VENDOR_PENSANDO=y
CONFIG_IONIC=m
CONFIG_NET_VENDOR_QLOGIC=y
CONFIG_QLA3XXX=m
# CONFIG_QLCNIC is not set
CONFIG_NETXEN_NIC=m
CONFIG_QED=m
CONFIG_QED_LL2=y
CONFIG_QED_SRIOV=y
CONFIG_QEDE=m
CONFIG_QED_RDMA=y
CONFIG_QED_ISCSI=y
CONFIG_QED_FCOE=y
CONFIG_QED_OOO=y
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
# CONFIG_NET_VENDOR_QUALCOMM is not set
# CONFIG_NET_VENDOR_RDC is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
CONFIG_8139CP=m
CONFIG_8139TOO=m
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
CONFIG_8139TOO_8129=y
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_R8169=y
# CONFIG_RTASE is not set
# CONFIG_NET_VENDOR_RENESAS is not set
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_ROCKER=m
# CONFIG_NET_VENDOR_SAMSUNG is not set
# CONFIG_NET_VENDOR_SEEQ is not set
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
CONFIG_SFC=m
CONFIG_SFC_MTD=y
CONFIG_SFC_MCDI_MON=y
CONFIG_SFC_SRIOV=y
CONFIG_SFC_MCDI_LOGGING=y
# CONFIG_SFC_FALCON is not set
CONFIG_SFC_SIENA=m
CONFIG_SFC_SIENA_MTD=y
CONFIG_SFC_SIENA_MCDI_MON=y
CONFIG_SFC_SIENA_SRIOV=y
CONFIG_SFC_SIENA_MCDI_LOGGING=y
# CONFIG_NET_VENDOR_SMSC is not set
# CONFIG_NET_VENDOR_SOCIONEXT is not set
CONFIG_NET_VENDOR_STMICRO=y
CONFIG_STMMAC_ETH=m
# CONFIG_STMMAC_SELFTESTS is not set
# CONFIG_STMMAC_PLATFORM is not set
CONFIG_DWMAC_INTEL=m
# CONFIG_STMMAC_PCI is not set
# CONFIG_NET_VENDOR_SUN is not set
# CONFIG_NET_VENDOR_SYNOPSYS is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
# CONFIG_NET_VENDOR_TI is not set
CONFIG_NET_VENDOR_VERTEXCOM=y
# CONFIG_MSE102X is not set
# CONFIG_NET_VENDOR_VIA is not set
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_NGBE is not set
# CONFIG_TXGBE is not set
# CONFIG_NET_VENDOR_WIZNET is not set
# CONFIG_NET_VENDOR_XILINX is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
CONFIG_PHYLINK=y
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
CONFIG_LED_TRIGGER_PHY=y
CONFIG_FIXED_PHY=y
# CONFIG_SFP is not set

#
# MII PHY device drivers
#
# CONFIG_AIR_EN8811H_PHY is not set
CONFIG_AMD_PHY=m
# CONFIG_ADIN_PHY is not set
# CONFIG_ADIN1100_PHY is not set
CONFIG_AQUANTIA_PHY=m
CONFIG_AX88796B_PHY=y
CONFIG_BROADCOM_PHY=m
# CONFIG_BCM54140_PHY is not set
CONFIG_BCM7XXX_PHY=m
# CONFIG_BCM84881_PHY is not set
CONFIG_BCM87XX_PHY=m
CONFIG_BCM_NET_PHYLIB=m
CONFIG_BCM_NET_PHYPTP=m
CONFIG_CICADA_PHY=m
CONFIG_CORTINA_PHY=m
CONFIG_DAVICOM_PHY=m
CONFIG_ICPLUS_PHY=m
CONFIG_LXT_PHY=m
CONFIG_INTEL_XWAY_PHY=m
CONFIG_LSI_ET1011C_PHY=m
CONFIG_MARVELL_PHY=m
CONFIG_MARVELL_10G_PHY=m
CONFIG_MARVELL_88Q2XXX_PHY=m
# CONFIG_MARVELL_88X2222_PHY is not set
CONFIG_MAXLINEAR_GPHY=m
# CONFIG_MEDIATEK_GE_PHY is not set
CONFIG_MICREL_PHY=m
# CONFIG_MICROCHIP_T1S_PHY is not set
CONFIG_MICROCHIP_PHY=m
CONFIG_MICROCHIP_T1_PHY=m
CONFIG_MICROSEMI_PHY=m
# CONFIG_MOTORCOMM_PHY is not set
CONFIG_NATIONAL_PHY=m
# CONFIG_NXP_CBTX_PHY is not set
# CONFIG_NXP_C45_TJA11XX_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_NCN26000_PHY is not set
# CONFIG_QCA83XX_PHY is not set
# CONFIG_QCA808X_PHY is not set
CONFIG_QSEMI_PHY=m
CONFIG_REALTEK_PHY=y
CONFIG_RENESAS_PHY=m
CONFIG_ROCKCHIP_PHY=m
CONFIG_SMSC_PHY=m
CONFIG_STE10XP=m
CONFIG_TERANETICS_PHY=m
CONFIG_DP83822_PHY=m
CONFIG_DP83TC811_PHY=m
CONFIG_DP83848_PHY=m
CONFIG_DP83867_PHY=m
# CONFIG_DP83869_PHY is not set
# CONFIG_DP83TD510_PHY is not set
# CONFIG_DP83TG720_PHY is not set
CONFIG_VITESSE_PHY=m
CONFIG_XILINX_GMII2RGMII=m
CONFIG_MICREL_KS8995MA=m
CONFIG_CAN_DEV=m
CONFIG_CAN_VCAN=m
CONFIG_CAN_VXCAN=m
CONFIG_CAN_NETLINK=y
CONFIG_CAN_CALC_BITTIMING=y
CONFIG_CAN_RX_OFFLOAD=y
# CONFIG_CAN_CAN327 is not set
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_SLCAN=m
# CONFIG_CAN_C_CAN is not set
# CONFIG_CAN_CC770 is not set
# CONFIG_CAN_CTUCANFD_PCI is not set
# CONFIG_CAN_ESD_402_PCI is not set
# CONFIG_CAN_IFI_CANFD is not set
CONFIG_CAN_M_CAN=m
CONFIG_CAN_M_CAN_PCI=m
# CONFIG_CAN_M_CAN_PLATFORM is not set
# CONFIG_CAN_M_CAN_TCAN4X5X is not set
CONFIG_CAN_PEAK_PCIEFD=m
# CONFIG_CAN_SJA1000 is not set
# CONFIG_CAN_SOFTING is not set

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
CONFIG_CAN_MCP251X=m
CONFIG_CAN_MCP251XFD=m
# CONFIG_CAN_MCP251XFD_SANITY is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
CONFIG_CAN_8DEV_USB=m
CONFIG_CAN_EMS_USB=m
# CONFIG_CAN_ESD_USB is not set
# CONFIG_CAN_ETAS_ES58X is not set
# CONFIG_CAN_F81604 is not set
# CONFIG_CAN_GS_USB is not set
CONFIG_CAN_KVASER_USB=m
# CONFIG_CAN_MCBA_USB is not set
CONFIG_CAN_PEAK_USB=m
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_ACPI_MDIO=y
CONFIG_MDIO_DEVRES=y
CONFIG_MDIO_BITBANG=m
CONFIG_MDIO_BCM_UNIMAC=m
CONFIG_MDIO_CAVIUM=m
# CONFIG_MDIO_GPIO is not set
# CONFIG_MDIO_MVUSB is not set
CONFIG_MDIO_THUNDER=m

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
CONFIG_PCS_XPCS=m
# end of PCS device drivers

# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_FILTER=y
CONFIG_PPP_MPPE=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPPOATM=m
CONFIG_PPPOE=m
# CONFIG_PPPOE_HASH_BITS_1 is not set
# CONFIG_PPPOE_HASH_BITS_2 is not set
CONFIG_PPPOE_HASH_BITS_4=y
# CONFIG_PPPOE_HASH_BITS_8 is not set
CONFIG_PPPOE_HASH_BITS=4
CONFIG_PPTP=m
CONFIG_PPPOL2TP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_SLIP=m
CONFIG_SLHC=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
# CONFIG_SLIP_MODE_SLIP6 is not set
CONFIG_USB_NET_DRIVERS=y
CONFIG_USB_CATC=m
CONFIG_USB_KAWETH=m
CONFIG_USB_PEGASUS=m
CONFIG_USB_RTL8150=m
CONFIG_USB_RTL8152=y
CONFIG_USB_LAN78XX=m
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
CONFIG_USB_NET_CDCETHER=m
CONFIG_USB_NET_CDC_EEM=m
CONFIG_USB_NET_CDC_NCM=m
CONFIG_USB_NET_HUAWEI_CDC_NCM=m
CONFIG_USB_NET_CDC_MBIM=m
CONFIG_USB_NET_DM9601=m
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
CONFIG_USB_NET_SMSC75XX=m
CONFIG_USB_NET_SMSC95XX=m
CONFIG_USB_NET_GL620A=m
CONFIG_USB_NET_NET1080=m
CONFIG_USB_NET_PLUSB=m
CONFIG_USB_NET_MCS7830=m
CONFIG_USB_NET_RNDIS_HOST=m
CONFIG_USB_NET_CDC_SUBSET_ENABLE=m
CONFIG_USB_NET_CDC_SUBSET=m
CONFIG_USB_ALI_M5632=y
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_ARMLINUX=y
CONFIG_USB_EPSON2888=y
CONFIG_USB_KC2190=y
CONFIG_USB_NET_ZAURUS=m
CONFIG_USB_NET_CX82310_ETH=m
CONFIG_USB_NET_KALMIA=m
CONFIG_USB_NET_QMI_WWAN=m
CONFIG_USB_HSO=m
CONFIG_USB_NET_INT51X1=m
CONFIG_USB_IPHETH=m
CONFIG_USB_SIERRA_NET=m
CONFIG_USB_VL600=m
CONFIG_USB_NET_CH9200=m
# CONFIG_USB_NET_AQC111 is not set
CONFIG_USB_RTL8153_ECM=m
CONFIG_WLAN=y
# CONFIG_WLAN_VENDOR_ADMTEK is not set
CONFIG_ATH_COMMON=m
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_ATH9K_HW=m
CONFIG_ATH9K_COMMON=m
CONFIG_ATH9K_BTCOEX_SUPPORT=y
CONFIG_ATH9K=m
CONFIG_ATH9K_PCI=y
CONFIG_ATH9K_AHB=y
# CONFIG_ATH9K_DYNACK is not set
CONFIG_ATH9K_WOW=y
CONFIG_ATH9K_RFKILL=y
# CONFIG_ATH9K_CHANNEL_CONTEXT is not set
CONFIG_ATH9K_PCOEM=y
# CONFIG_ATH9K_PCI_NO_EEPROM is not set
CONFIG_ATH9K_HTC=m
# CONFIG_ATH9K_HTC_DEBUGFS is not set
# CONFIG_ATH9K_HWRNG is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
CONFIG_ATH10K=m
CONFIG_ATH10K_CE=y
CONFIG_ATH10K_PCI=m
# CONFIG_ATH10K_SDIO is not set
# CONFIG_ATH10K_USB is not set
# CONFIG_ATH10K_DEBUG is not set
CONFIG_ATH10K_DEBUGFS=y
CONFIG_ATH10K_LEDS=y
# CONFIG_ATH10K_SPECTRAL is not set
# CONFIG_ATH10K_TRACING is not set
# CONFIG_WCN36XX is not set
CONFIG_ATH11K=m
CONFIG_ATH11K_PCI=m
# CONFIG_ATH11K_DEBUG is not set
# CONFIG_ATH11K_TRACING is not set
# CONFIG_ATH12K is not set
# CONFIG_WLAN_VENDOR_ATMEL is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
CONFIG_BRCMUTIL=m
CONFIG_BRCMSMAC=m
CONFIG_BRCMSMAC_LEDS=y
CONFIG_BRCMFMAC=m
CONFIG_BRCMFMAC_PROTO_BCDC=y
CONFIG_BRCMFMAC_PROTO_MSGBUF=y
CONFIG_BRCMFMAC_SDIO=y
CONFIG_BRCMFMAC_USB=y
CONFIG_BRCMFMAC_PCIE=y
# CONFIG_BRCM_TRACING is not set
# CONFIG_BRCMDBG is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
CONFIG_IWLWIFI=m
CONFIG_IWLWIFI_LEDS=y
CONFIG_IWLDVM=m
CONFIG_IWLMVM=m
CONFIG_IWLWIFI_OPMODE_MODULAR=y

#
# Debugging Options
#
# CONFIG_IWLWIFI_DEBUG is not set
# CONFIG_IWLWIFI_DEVICE_TRACING is not set
# end of Debugging Options

# CONFIG_WLAN_VENDOR_INTERSIL is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
CONFIG_MWIFIEX=m
CONFIG_MWIFIEX_SDIO=m
CONFIG_MWIFIEX_PCIE=m
CONFIG_MWIFIEX_USB=m
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_MT7601U=m
CONFIG_MT76_CORE=m
CONFIG_MT76_LEDS=y
CONFIG_MT76_USB=m
CONFIG_MT76x02_LIB=m
CONFIG_MT76x02_USB=m
CONFIG_MT76_CONNAC_LIB=m
CONFIG_MT792x_LIB=m
CONFIG_MT76x0_COMMON=m
CONFIG_MT76x0U=m
CONFIG_MT76x0E=m
CONFIG_MT76x2_COMMON=m
CONFIG_MT76x2E=m
CONFIG_MT76x2U=m
# CONFIG_MT7603E is not set
# CONFIG_MT7615E is not set
# CONFIG_MT7663U is not set
# CONFIG_MT7663S is not set
# CONFIG_MT7915E is not set
CONFIG_MT7921_COMMON=m
CONFIG_MT7921E=m
# CONFIG_MT7921S is not set
# CONFIG_MT7921U is not set
# CONFIG_MT7996E is not set
CONFIG_MT7925_COMMON=m
CONFIG_MT7925E=m
# CONFIG_MT7925U is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
CONFIG_WLAN_VENDOR_PURELIFI=y
# CONFIG_PLFXLC is not set
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_RT2X00=m
# CONFIG_RT2400PCI is not set
# CONFIG_RT2500PCI is not set
# CONFIG_RT61PCI is not set
CONFIG_RT2800PCI=m
CONFIG_RT2800PCI_RT33XX=y
CONFIG_RT2800PCI_RT35XX=y
CONFIG_RT2800PCI_RT53XX=y
CONFIG_RT2800PCI_RT3290=y
# CONFIG_RT2500USB is not set
# CONFIG_RT73USB is not set
CONFIG_RT2800USB=m
CONFIG_RT2800USB_RT33XX=y
CONFIG_RT2800USB_RT35XX=y
CONFIG_RT2800USB_RT3573=y
CONFIG_RT2800USB_RT53XX=y
CONFIG_RT2800USB_RT55XX=y
CONFIG_RT2800USB_UNKNOWN=y
CONFIG_RT2800_LIB=m
CONFIG_RT2800_LIB_MMIO=m
CONFIG_RT2X00_LIB_MMIO=m
CONFIG_RT2X00_LIB_PCI=m
CONFIG_RT2X00_LIB_USB=m
CONFIG_RT2X00_LIB=m
CONFIG_RT2X00_LIB_FIRMWARE=y
CONFIG_RT2X00_LIB_CRYPTO=y
CONFIG_RT2X00_LIB_LEDS=y
# CONFIG_RT2X00_DEBUG is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
CONFIG_RTL8192CE=m
CONFIG_RTL8192SE=m
CONFIG_RTL8192DE=m
CONFIG_RTL8723AE=m
CONFIG_RTL8723BE=m
CONFIG_RTL8188EE=m
CONFIG_RTL8192EE=m
CONFIG_RTL8821AE=m
CONFIG_RTL8192CU=m
# CONFIG_RTL8192DU is not set
CONFIG_RTLWIFI=m
CONFIG_RTLWIFI_PCI=m
CONFIG_RTLWIFI_USB=m
# CONFIG_RTLWIFI_DEBUG is not set
CONFIG_RTL8192C_COMMON=m
CONFIG_RTL8192D_COMMON=m
CONFIG_RTL8723_COMMON=m
CONFIG_RTLBTCOEXIST=m
CONFIG_RTL8XXXU=m
# CONFIG_RTL8XXXU_UNTESTED is not set
CONFIG_RTW88=m
CONFIG_RTW88_CORE=m
CONFIG_RTW88_PCI=m
CONFIG_RTW88_8822B=m
CONFIG_RTW88_8822C=m
CONFIG_RTW88_8723X=m
CONFIG_RTW88_8723D=m
CONFIG_RTW88_8821C=m
CONFIG_RTW88_8822BE=m
# CONFIG_RTW88_8822BS is not set
# CONFIG_RTW88_8822BU is not set
CONFIG_RTW88_8822CE=m
# CONFIG_RTW88_8822CS is not set
# CONFIG_RTW88_8822CU is not set
CONFIG_RTW88_8723DE=m
# CONFIG_RTW88_8723DS is not set
# CONFIG_RTW88_8723CS is not set
# CONFIG_RTW88_8723DU is not set
CONFIG_RTW88_8821CE=m
# CONFIG_RTW88_8821CS is not set
# CONFIG_RTW88_8821CU is not set
# CONFIG_RTW88_8821AU is not set
# CONFIG_RTW88_8812AU is not set
# CONFIG_RTW88_DEBUG is not set
# CONFIG_RTW88_DEBUGFS is not set
CONFIG_RTW89=m
CONFIG_RTW89_CORE=m
CONFIG_RTW89_PCI=m
CONFIG_RTW89_8852A=m
CONFIG_RTW89_8852B_COMMON=m
CONFIG_RTW89_8852B=m
CONFIG_RTW89_8852C=m
# CONFIG_RTW89_8851BE is not set
CONFIG_RTW89_8852AE=m
CONFIG_RTW89_8852BE=m
# CONFIG_RTW89_8852BTE is not set
CONFIG_RTW89_8852CE=m
# CONFIG_RTW89_8922AE is not set
# CONFIG_RTW89_DEBUGMSG is not set
# CONFIG_RTW89_DEBUGFS is not set
# CONFIG_WLAN_VENDOR_RSI is not set
CONFIG_WLAN_VENDOR_SILABS=y
# CONFIG_WFX is not set
# CONFIG_WLAN_VENDOR_ST is not set
# CONFIG_WLAN_VENDOR_TI is not set
# CONFIG_WLAN_VENDOR_ZYDAS is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
CONFIG_MAC80211_HWSIM=m
# CONFIG_VIRT_WIFI is not set
CONFIG_WAN=y
CONFIG_HDLC=m
CONFIG_HDLC_RAW=m
# CONFIG_HDLC_RAW_ETH is not set
CONFIG_HDLC_CISCO=m
CONFIG_HDLC_FR=m
CONFIG_HDLC_PPP=m

#
# X.25/LAPB support is disabled
#
# CONFIG_FRAMER is not set
# CONFIG_PCI200SYN is not set
# CONFIG_WANXL is not set
# CONFIG_PC300TOO is not set
# CONFIG_FARSYNC is not set
CONFIG_IEEE802154_DRIVERS=m
CONFIG_IEEE802154_FAKELB=m
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set

#
# Wireless WAN
#
CONFIG_WWAN=y
CONFIG_WWAN_DEBUGFS=y
CONFIG_WWAN_HWSIM=m
CONFIG_MHI_WWAN_CTRL=m
CONFIG_MHI_WWAN_MBIM=m
CONFIG_IOSM=m
CONFIG_MTK_T7XX=m
# end of Wireless WAN

CONFIG_XEN_NETDEV_FRONTEND=m
CONFIG_VMXNET3=m
CONFIG_FUJITSU_ES=m
CONFIG_USB4_NET=m
CONFIG_HYPERV_NET=m
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
CONFIG_MOUSE_APPLETOUCH=m
CONFIG_MOUSE_BCM5974=m
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
CONFIG_MOUSE_SYNAPTICS_USB=m
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_USB_ACECAD=m
CONFIG_TABLET_USB_AIPTEK=m
# CONFIG_TABLET_USB_HANWANG is not set
CONFIG_TABLET_USB_KBTAB=m
# CONFIG_TABLET_USB_PEGASUS is not set
CONFIG_TABLET_SERIAL_WACOM4=m
CONFIG_INPUT_TOUCHSCREEN=y
# CONFIG_TOUCHSCREEN_ADS7846 is not set
# CONFIG_TOUCHSCREEN_AD7877 is not set
# CONFIG_TOUCHSCREEN_AD7879 is not set
# CONFIG_TOUCHSCREEN_ADC is not set
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
# CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
# CONFIG_TOUCHSCREEN_BU21013 is not set
# CONFIG_TOUCHSCREEN_BU21029 is not set
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
# CONFIG_TOUCHSCREEN_CY8CTMA140 is not set
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
# CONFIG_TOUCHSCREEN_CYTTSP5 is not set
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
# CONFIG_TOUCHSCREEN_EETI is not set
# CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
# CONFIG_TOUCHSCREEN_EXC3000 is not set
# CONFIG_TOUCHSCREEN_FUJITSU is not set
# CONFIG_TOUCHSCREEN_GOODIX is not set
# CONFIG_TOUCHSCREEN_GOODIX_BERLIN_I2C is not set
# CONFIG_TOUCHSCREEN_GOODIX_BERLIN_SPI is not set
# CONFIG_TOUCHSCREEN_HIDEEP is not set
# CONFIG_TOUCHSCREEN_HYCON_HY46XX is not set
# CONFIG_TOUCHSCREEN_HYNITRON_CSTXXX is not set
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_ILITEK is not set
# CONFIG_TOUCHSCREEN_S6SY761 is not set
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
# CONFIG_TOUCHSCREEN_ELAN is not set
CONFIG_TOUCHSCREEN_ELO=m
CONFIG_TOUCHSCREEN_WACOM_W8001=m
CONFIG_TOUCHSCREEN_WACOM_I2C=m
# CONFIG_TOUCHSCREEN_MAX11801 is not set
# CONFIG_TOUCHSCREEN_MMS114 is not set
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
# CONFIG_TOUCHSCREEN_MSG2638 is not set
# CONFIG_TOUCHSCREEN_MTOUCH is not set
# CONFIG_TOUCHSCREEN_NOVATEK_NVT_TS is not set
# CONFIG_TOUCHSCREEN_IMAGIS is not set
# CONFIG_TOUCHSCREEN_INEXIO is not set
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
# CONFIG_TOUCHSCREEN_PIXCIR is not set
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
# CONFIG_TOUCHSCREEN_WM97XX is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
# CONFIG_TOUCHSCREEN_TSC2004 is not set
# CONFIG_TOUCHSCREEN_TSC2005 is not set
# CONFIG_TOUCHSCREEN_TSC2007 is not set
# CONFIG_TOUCHSCREEN_RM_TS is not set
# CONFIG_TOUCHSCREEN_SILEAD is not set
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
# CONFIG_TOUCHSCREEN_ST1232 is not set
# CONFIG_TOUCHSCREEN_STMFTS is not set
# CONFIG_TOUCHSCREEN_SUR40 is not set
# CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
# CONFIG_TOUCHSCREEN_SX8654 is not set
# CONFIG_TOUCHSCREEN_TPS6507X is not set
# CONFIG_TOUCHSCREEN_ZET6223 is not set
# CONFIG_TOUCHSCREEN_ZFORCE is not set
# CONFIG_TOUCHSCREEN_COLIBRI_VF50 is not set
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
# CONFIG_TOUCHSCREEN_IQS5XX is not set
# CONFIG_TOUCHSCREEN_IQS7211 is not set
# CONFIG_TOUCHSCREEN_ZINITIX is not set
# CONFIG_TOUCHSCREEN_HIMAX_HX83112B is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
CONFIG_INPUT_PCSPKR=m
# CONFIG_INPUT_MMA8450 is not set
CONFIG_INPUT_APANEL=m
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_DECODER is not set
# CONFIG_INPUT_GPIO_VIBRA is not set
CONFIG_INPUT_ATLAS_BTNS=m
CONFIG_INPUT_ATI_REMOTE2=m
CONFIG_INPUT_KEYSPAN_REMOTE=m
# CONFIG_INPUT_KXTJ9 is not set
CONFIG_INPUT_POWERMATE=m
CONFIG_INPUT_YEALINK=m
CONFIG_INPUT_CM109=m
CONFIG_INPUT_UINPUT=m
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_PWM_BEEPER is not set
# CONFIG_INPUT_PWM_VIBRA is not set
CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
# CONFIG_INPUT_DA7280_HAPTICS is not set
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_IQS269A is not set
# CONFIG_INPUT_IQS626A is not set
# CONFIG_INPUT_IQS7222 is not set
# CONFIG_INPUT_CMA3000 is not set
CONFIG_INPUT_XEN_KBDDEV_FRONTEND=m
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
CONFIG_RMI4_F3A=y
# CONFIG_RMI4_F54 is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LEGACY_TIOCSTI=y
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCILIB=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=32
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
# CONFIG_SERIAL_8250_PCI1XXXX is not set
CONFIG_SERIAL_8250_SHARE_IRQ=y
CONFIG_SERIAL_8250_DETECT_IRQ=y
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=m
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_TCG_TPM2_HMAC=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
CONFIG_TCG_TIS_SPI=y
# CONFIG_TCG_TIS_SPI_CR50 is not set
# CONFIG_TCG_TIS_I2C is not set
# CONFIG_TCG_TIS_I2C_CR50 is not set
# CONFIG_TCG_TIS_I2C_ATMEL is not set
# CONFIG_TCG_TIS_I2C_INFINEON is not set
CONFIG_TCG_TIS_I2C_NUVOTON=m
# CONFIG_TCG_NSC is not set
# CONFIG_TCG_ATMEL is not set
# CONFIG_TCG_INFINEON is not set
# CONFIG_TCG_XEN is not set
CONFIG_TCG_CRB=y
CONFIG_TCG_VTPM_PROXY=m
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# CONFIG_XILLYUSB is not set
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD8111=m
# CONFIG_I2C_AMD_MP2 is not set
# CONFIG_I2C_AMD_ASF is not set
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m
# CONFIG_I2C_ZHAOXIN is not set

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_AMDPSP is not set
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
# CONFIG_I2C_CP2615 is not set
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_PCI1XXXX is not set
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=m

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_CH341 is not set
CONFIG_SPI_CS42L43=m
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_MICROCHIP_CORE is not set
# CONFIG_SPI_MICROCHIP_CORE_QSPI is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PCI1XXXX is not set
CONFIG_SPI_PXA2XX=m
CONFIG_SPI_PXA2XX_PCI=m
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
CONFIG_SPI_AMD=y

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y
CONFIG_DP83640_PHY=m
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
CONFIG_PTP_1588_CLOCK_VMCLOCK=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_FC3W is not set
# CONFIG_PTP_1588_CLOCK_MOCK is not set
CONFIG_PTP_1588_CLOCK_VMW=m
# CONFIG_PTP_1588_CLOCK_OCP is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=y
# CONFIG_PINCTRL_CY8C95X0 is not set
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_CS42L43=m

#
# Intel pinctrl drivers
#
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
CONFIG_PINCTRL_INTEL=y
# CONFIG_PINCTRL_INTEL_PLATFORM is not set
CONFIG_PINCTRL_ALDERLAKE=m
CONFIG_PINCTRL_BROXTON=m
CONFIG_PINCTRL_CANNONLAKE=m
CONFIG_PINCTRL_CEDARFORK=m
CONFIG_PINCTRL_DENVERTON=m
CONFIG_PINCTRL_ELKHARTLAKE=m
CONFIG_PINCTRL_EMMITSBURG=m
CONFIG_PINCTRL_GEMINILAKE=m
CONFIG_PINCTRL_ICELAKE=m
CONFIG_PINCTRL_JASPERLAKE=m
CONFIG_PINCTRL_LAKEFIELD=m
CONFIG_PINCTRL_LEWISBURG=m
CONFIG_PINCTRL_METEORLAKE=m
# CONFIG_PINCTRL_METEORPOINT is not set
CONFIG_PINCTRL_SUNRISEPOINT=m
CONFIG_PINCTRL_TIGERLAKE=m
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
# CONFIG_GPIO_SYSFS is not set
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=m
CONFIG_GPIO_SWNODE_UNDEFINED=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_ALTERA is not set
CONFIG_GPIO_AMDPT=m
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
# CONFIG_GPIO_GRANITERAPIDS is not set
# CONFIG_GPIO_GRGPIO is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_POLARFIRE_SOC is not set
# CONFIG_GPIO_XILINX is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_FXL6408 is not set
# CONFIG_GPIO_DS4520 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# CONFIG_GPIO_ELKHARTLAKE is not set
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# CONFIG_GPIO_MPSSE is not set
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_LATCH is not set
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_GPIO_VIRTIO is not set
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

#
# GPIO Debugging utilities
#
# CONFIG_GPIO_SLOPPY_LOGIC_ANALYZER is not set
# CONFIG_GPIO_VIRTUSER is not set
# end of GPIO Debugging utilities

# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
# CONFIG_POWER_SEQUENCING is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_GENERIC_ADC_BATTERY is not set
# CONFIG_IP5XXX_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SAMSUNG_SDI is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_BATTERY_MAX1720X is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_MAX77976 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
# CONFIG_BATTERY_UG3105 is not set
# CONFIG_FUEL_GAUGE_MM8013 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_ASUS_ROG_RYUJIN is not set
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CHIPCAP2 is not set
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
# CONFIG_I8K is not set
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
# CONFIG_SENSORS_GIGABYTE_WATERFORCE is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
# CONFIG_SENSORS_HS3001 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
# CONFIG_SENSORS_IIO_HWMON is not set
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
# CONFIG_SENSORS_ISL28022 is not set
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWERZ is not set
# CONFIG_SENSORS_POWR1220 is not set
# CONFIG_SENSORS_LENOVO_EC is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2991 is not set
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_LTC4282 is not set
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX31760 is not set
# CONFIG_MAX31827 is not set
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
# CONFIG_SENSORS_MC34VR500 is not set
CONFIG_SENSORS_MCP3021=m
CONFIG_SENSORS_MLXREG_FAN=m
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775_CORE=m
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT6775_I2C is not set
# CONFIG_SENSORS_NCT7363 is not set
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
# CONFIG_SENSORS_NZXT_KRAKEN3 is not set
# CONFIG_SENSORS_NZXT_SMART2 is not set
# CONFIG_SENSORS_OCC_P8_I2C is not set
# CONFIG_SENSORS_OXP is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ACBEL_FSG032 is not set
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_ADP1050 is not set
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_BPA_RS600 is not set
# CONFIG_SENSORS_DELTA_AHE50DC_FAN is not set
# CONFIG_SENSORS_FSP_3Y is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_DPS920AB is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR36021 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
# CONFIG_SENSORS_LT7182S is not set
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
# CONFIG_SENSORS_LTC4286 is not set
# CONFIG_SENSORS_MAX15301 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
# CONFIG_SENSORS_MAX20730 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_MP2856 is not set
# CONFIG_SENSORS_MP2888 is not set
# CONFIG_SENSORS_MP2891 is not set
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_MP2993 is not set
# CONFIG_SENSORS_MP5023 is not set
# CONFIG_SENSORS_MP5920 is not set
# CONFIG_SENSORS_MP5990 is not set
# CONFIG_SENSORS_MP9941 is not set
# CONFIG_SENSORS_MPQ7932 is not set
# CONFIG_SENSORS_MPQ8785 is not set
# CONFIG_SENSORS_PIM4328 is not set
# CONFIG_SENSORS_PLI1209BC is not set
# CONFIG_SENSORS_PM6764TR is not set
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_Q54SJ108A2 is not set
# CONFIG_SENSORS_STPDDC60 is not set
# CONFIG_SENSORS_TDA38640 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
# CONFIG_SENSORS_TPS546D24 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDP710 is not set
# CONFIG_SENSORS_XDPE152 is not set
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
# CONFIG_SENSORS_PT5161L is not set
# CONFIG_SENSORS_PWM_FAN is not set
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHT4x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC2305 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_SPD5118 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP464 is not set
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
# CONFIG_SENSORS_ASUS_WMI is not set
# CONFIG_SENSORS_ASUS_EC is not set
# CONFIG_SENSORS_HP_WMI is not set
CONFIG_THERMAL=y
CONFIG_THERMAL_NETLINK=y
# CONFIG_THERMAL_STATISTICS is not set
# CONFIG_THERMAL_DEBUGFS is not set
# CONFIG_THERMAL_CORE_TESTING is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_PCIE_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_INTEL_TCC=y
CONFIG_X86_PKG_TEMP_THERMAL=m
CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=m
CONFIG_ACPI_THERMAL_REL=m
# CONFIG_INT3406_THERMAL is not set
CONFIG_PROC_THERMAL_MMIO_RAPL=m
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# CONFIG_INTEL_TCC_COOLING is not set
CONFIG_INTEL_HFI_THERMAL=y
# end of Intel thermal drivers

# CONFIG_GENERIC_ADC_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
# CONFIG_LENOVO_SE10_WDT is not set
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
CONFIG_MLX_WDT=m
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ADVANTECH_EC_WDT is not set
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_EBC_C384_WDT is not set
# CONFIG_EXAR_WDT is not set
# CONFIG_F71808E_WDT is not set
CONFIG_SP5100_TCO=m
# CONFIG_SBC_FITPC2_WATCHDOG is not set
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
# CONFIG_IE6XX_WDT is not set
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
# CONFIG_IT8712F_WDT is not set
# CONFIG_IT87_WDT is not set
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
# CONFIG_NV_TCO is not set
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
# CONFIG_SMSC_SCH311X_WDT is not set
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
# CONFIG_VIA_WDT is not set
# CONFIG_W83627HF_WDT is not set
# CONFIG_W83877F_WDT is not set
# CONFIG_W83977F_WDT is not set
# CONFIG_MACHZ_WDT is not set
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set
# CONFIG_XEN_WDT is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_MFD_SMPRO is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_CGBC is not set
CONFIG_MFD_CS42L43=m
# CONFIG_MFD_CS42L43_I2C is not set
CONFIG_MFD_CS42L43_SDW=m
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=m
CONFIG_MFD_INTEL_LPSS=m
CONFIG_MFD_INTEL_LPSS_ACPI=m
CONFIG_MFD_INTEL_LPSS_PCI=m
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77541 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6370 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_MFD_OCELOT is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_SY7636A is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT4831 is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RT5120 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS6594_I2C is not set
# CONFIG_MFD_TPS6594_SPI is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_ATC260X_I2C is not set
# CONFIG_MFD_CS40L50_I2C is not set
# CONFIG_MFD_CS40L50_SPI is not set
# CONFIG_MFD_INTEL_M10_BMC_SPI is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=y
CONFIG_BPF_LIRC_MODE2=y
CONFIG_LIRC=y
CONFIG_RC_MAP=y
# CONFIG_RC_DECODERS is not set
CONFIG_RC_DEVICES=y
# CONFIG_IR_ENE is not set
# CONFIG_IR_FINTEK is not set
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
# CONFIG_IR_ITE_CIR is not set
# CONFIG_IR_MCEUSB is not set
# CONFIG_IR_NUVOTON is not set
# CONFIG_IR_REDRAT3 is not set
# CONFIG_IR_SERIAL is not set
# CONFIG_IR_STREAMZAP is not set
# CONFIG_IR_TOY is not set
# CONFIG_IR_TTUSBIR is not set
# CONFIG_IR_WINBOND_CIR is not set
# CONFIG_RC_ATI_REMOTE is not set
CONFIG_RC_LOOPBACK=m
# CONFIG_RC_XBOX_DVD is not set
CONFIG_CEC_CORE=m

#
# CEC support
#
# CONFIG_MEDIA_CEC_RC is not set
CONFIG_MEDIA_CEC_SUPPORT=y
# CONFIG_CEC_CH7322 is not set
# CONFIG_CEC_GPIO is not set
# CONFIG_CEC_SECO is not set
# CONFIG_USB_EXTRON_DA_HD_4K_PLUS_CEC is not set
CONFIG_USB_PULSE8_CEC=m
CONFIG_USB_RAINSHADOW_CEC=m
# end of CEC support

CONFIG_MEDIA_SUPPORT=m
CONFIG_MEDIA_SUPPORT_FILTER=y
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
# CONFIG_MEDIA_RADIO_SUPPORT is not set
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_PLATFORM_SUPPORT is not set
# CONFIG_MEDIA_TEST_SUPPORT is not set
# end of Media device types

CONFIG_VIDEO_DEV=m
CONFIG_MEDIA_CONTROLLER=y

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_V4L2_FWNODE=m
CONFIG_V4L2_ASYNC=m
# end of Video4Linux options

#
# Media controller options
#
# end of Media controller options

#
# Media drivers
#

#
# Drivers filtered as selected at 'Filter media drivers'
#

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
CONFIG_USB_GSPCA=m
CONFIG_USB_GSPCA_BENQ=m
CONFIG_USB_GSPCA_CONEX=m
CONFIG_USB_GSPCA_CPIA1=m
# CONFIG_USB_GSPCA_DTCS033 is not set
CONFIG_USB_GSPCA_ETOMS=m
CONFIG_USB_GSPCA_FINEPIX=m
CONFIG_USB_GSPCA_JEILINJ=m
CONFIG_USB_GSPCA_JL2005BCD=m
# CONFIG_USB_GSPCA_KINECT is not set
CONFIG_USB_GSPCA_KONICA=m
CONFIG_USB_GSPCA_MARS=m
CONFIG_USB_GSPCA_MR97310A=m
CONFIG_USB_GSPCA_NW80X=m
CONFIG_USB_GSPCA_OV519=m
CONFIG_USB_GSPCA_OV534=m
CONFIG_USB_GSPCA_OV534_9=m
CONFIG_USB_GSPCA_PAC207=m
CONFIG_USB_GSPCA_PAC7302=m
CONFIG_USB_GSPCA_PAC7311=m
CONFIG_USB_GSPCA_SE401=m
CONFIG_USB_GSPCA_SN9C2028=m
CONFIG_USB_GSPCA_SN9C20X=m
CONFIG_USB_GSPCA_SONIXB=m
CONFIG_USB_GSPCA_SONIXJ=m
CONFIG_USB_GSPCA_SPCA1528=m
CONFIG_USB_GSPCA_SPCA500=m
CONFIG_USB_GSPCA_SPCA501=m
CONFIG_USB_GSPCA_SPCA505=m
CONFIG_USB_GSPCA_SPCA506=m
CONFIG_USB_GSPCA_SPCA508=m
CONFIG_USB_GSPCA_SPCA561=m
CONFIG_USB_GSPCA_SQ905=m
CONFIG_USB_GSPCA_SQ905C=m
CONFIG_USB_GSPCA_SQ930X=m
CONFIG_USB_GSPCA_STK014=m
# CONFIG_USB_GSPCA_STK1135 is not set
CONFIG_USB_GSPCA_STV0680=m
CONFIG_USB_GSPCA_SUNPLUS=m
CONFIG_USB_GSPCA_T613=m
CONFIG_USB_GSPCA_TOPRO=m
# CONFIG_USB_GSPCA_TOUPTEK is not set
CONFIG_USB_GSPCA_TV8532=m
CONFIG_USB_GSPCA_VC032X=m
CONFIG_USB_GSPCA_VICAM=m
CONFIG_USB_GSPCA_XIRLINK_CIT=m
CONFIG_USB_GSPCA_ZC3XX=m
CONFIG_USB_GL860=m
CONFIG_USB_M5602=m
CONFIG_USB_STV06XX=m
CONFIG_USB_PWC=m
# CONFIG_USB_PWC_DEBUG is not set
CONFIG_USB_PWC_INPUT_EVDEV=y
CONFIG_USB_S2255=m
# CONFIG_VIDEO_USBTV is not set
CONFIG_USB_VIDEO_CLASS=m
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y

#
# Webcam, TV (analog/digital) USB devices
#
# CONFIG_VIDEO_EM28XX is not set
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
# CONFIG_VIDEO_MGB4 is not set
# CONFIG_VIDEO_SOLO6X10 is not set
# CONFIG_VIDEO_TW5864 is not set
# CONFIG_VIDEO_TW68 is not set
# CONFIG_VIDEO_TW686X is not set
# CONFIG_VIDEO_ZORAN is not set
# CONFIG_VIDEO_IPU3_CIO2 is not set
# CONFIG_VIDEO_INTEL_IPU6 is not set
# CONFIG_INTEL_VSC is not set
# CONFIG_IPU_BRIDGE is not set
CONFIG_UVC_COMMON=m
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
# end of Media drivers

#
# Media ancillary drivers
#

#
# IR I2C driver auto-selected by 'Autoselect ancillary drivers'
#
CONFIG_VIDEO_IR_I2C=m
CONFIG_VIDEO_CAMERA_SENSOR=y
# CONFIG_VIDEO_ALVIUM_CSI2 is not set
# CONFIG_VIDEO_AR0521 is not set
# CONFIG_VIDEO_GC0308 is not set
# CONFIG_VIDEO_GC05A2 is not set
# CONFIG_VIDEO_GC08A3 is not set
# CONFIG_VIDEO_GC2145 is not set
# CONFIG_VIDEO_HI556 is not set
# CONFIG_VIDEO_HI846 is not set
# CONFIG_VIDEO_HI847 is not set
# CONFIG_VIDEO_IMX208 is not set
# CONFIG_VIDEO_IMX214 is not set
# CONFIG_VIDEO_IMX219 is not set
# CONFIG_VIDEO_IMX258 is not set
# CONFIG_VIDEO_IMX274 is not set
# CONFIG_VIDEO_IMX283 is not set
# CONFIG_VIDEO_IMX290 is not set
# CONFIG_VIDEO_IMX296 is not set
# CONFIG_VIDEO_IMX319 is not set
# CONFIG_VIDEO_IMX355 is not set
# CONFIG_VIDEO_MT9M001 is not set
# CONFIG_VIDEO_MT9M111 is not set
# CONFIG_VIDEO_MT9M114 is not set
# CONFIG_VIDEO_MT9P031 is not set
# CONFIG_VIDEO_MT9T112 is not set
# CONFIG_VIDEO_MT9V011 is not set
# CONFIG_VIDEO_MT9V032 is not set
# CONFIG_VIDEO_MT9V111 is not set
# CONFIG_VIDEO_OG01A1B is not set
# CONFIG_VIDEO_OV01A10 is not set
# CONFIG_VIDEO_OV02A10 is not set
# CONFIG_VIDEO_OV08D10 is not set
# CONFIG_VIDEO_OV08X40 is not set
# CONFIG_VIDEO_OV13858 is not set
# CONFIG_VIDEO_OV13B10 is not set
# CONFIG_VIDEO_OV2640 is not set
# CONFIG_VIDEO_OV2659 is not set
# CONFIG_VIDEO_OV2680 is not set
# CONFIG_VIDEO_OV2685 is not set
# CONFIG_VIDEO_OV2740 is not set
# CONFIG_VIDEO_OV4689 is not set
# CONFIG_VIDEO_OV5647 is not set
# CONFIG_VIDEO_OV5648 is not set
# CONFIG_VIDEO_OV5670 is not set
# CONFIG_VIDEO_OV5675 is not set
# CONFIG_VIDEO_OV5693 is not set
# CONFIG_VIDEO_OV5695 is not set
# CONFIG_VIDEO_OV64A40 is not set
# CONFIG_VIDEO_OV6650 is not set
# CONFIG_VIDEO_OV7251 is not set
# CONFIG_VIDEO_OV7640 is not set
# CONFIG_VIDEO_OV7670 is not set
# CONFIG_VIDEO_OV772X is not set
# CONFIG_VIDEO_OV7740 is not set
# CONFIG_VIDEO_OV8856 is not set
# CONFIG_VIDEO_OV8858 is not set
# CONFIG_VIDEO_OV8865 is not set
# CONFIG_VIDEO_OV9640 is not set
# CONFIG_VIDEO_OV9650 is not set
# CONFIG_VIDEO_OV9734 is not set
# CONFIG_VIDEO_RDACM20 is not set
# CONFIG_VIDEO_RDACM21 is not set
# CONFIG_VIDEO_RJ54N1 is not set
# CONFIG_VIDEO_S5C73M3 is not set
# CONFIG_VIDEO_S5K5BAF is not set
# CONFIG_VIDEO_S5K6A3 is not set
# CONFIG_VIDEO_CCS is not set
# CONFIG_VIDEO_ET8EK8 is not set

#
# Camera ISPs
#
# CONFIG_VIDEO_THP7312 is not set
# end of Camera ISPs

#
# Lens drivers
#
# CONFIG_VIDEO_AD5820 is not set
# CONFIG_VIDEO_AK7375 is not set
# CONFIG_VIDEO_DW9714 is not set
# CONFIG_VIDEO_DW9719 is not set
# CONFIG_VIDEO_DW9768 is not set
# CONFIG_VIDEO_DW9807_VCM is not set
# end of Lens drivers

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
# CONFIG_VIDEO_LM3560 is not set
# CONFIG_VIDEO_LM3646 is not set
# end of Flash devices

#
# Audio decoders, processors and mixers
#
# CONFIG_VIDEO_CS3308 is not set
# CONFIG_VIDEO_CS5345 is not set
# CONFIG_VIDEO_CS53L32A is not set
# CONFIG_VIDEO_MSP3400 is not set
# CONFIG_VIDEO_SONY_BTF_MPX is not set
# CONFIG_VIDEO_TDA1997X is not set
# CONFIG_VIDEO_TDA7432 is not set
# CONFIG_VIDEO_TDA9840 is not set
# CONFIG_VIDEO_TEA6415C is not set
# CONFIG_VIDEO_TEA6420 is not set
# CONFIG_VIDEO_TLV320AIC23B is not set
# CONFIG_VIDEO_TVAUDIO is not set
# CONFIG_VIDEO_UDA1342 is not set
# CONFIG_VIDEO_VP27SMPX is not set
# CONFIG_VIDEO_WM8739 is not set
# CONFIG_VIDEO_WM8775 is not set
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
# CONFIG_VIDEO_SAA6588 is not set
# end of RDS decoders

#
# Video decoders
#
# CONFIG_VIDEO_ADV7180 is not set
# CONFIG_VIDEO_ADV7183 is not set
# CONFIG_VIDEO_ADV7604 is not set
# CONFIG_VIDEO_ADV7842 is not set
# CONFIG_VIDEO_BT819 is not set
# CONFIG_VIDEO_BT856 is not set
# CONFIG_VIDEO_BT866 is not set
# CONFIG_VIDEO_KS0127 is not set
# CONFIG_VIDEO_ML86V7667 is not set
# CONFIG_VIDEO_SAA7110 is not set
# CONFIG_VIDEO_SAA711X is not set
# CONFIG_VIDEO_TC358743 is not set
# CONFIG_VIDEO_TC358746 is not set
# CONFIG_VIDEO_TVP514X is not set
# CONFIG_VIDEO_TVP5150 is not set
# CONFIG_VIDEO_TVP7002 is not set
# CONFIG_VIDEO_TW2804 is not set
# CONFIG_VIDEO_TW9900 is not set
# CONFIG_VIDEO_TW9903 is not set
# CONFIG_VIDEO_TW9906 is not set
# CONFIG_VIDEO_TW9910 is not set
# CONFIG_VIDEO_VPX3220 is not set

#
# Video and audio decoders
#
# CONFIG_VIDEO_SAA717X is not set
# CONFIG_VIDEO_CX25840 is not set
# end of Video decoders

#
# Video encoders
#
# CONFIG_VIDEO_ADV7170 is not set
# CONFIG_VIDEO_ADV7175 is not set
# CONFIG_VIDEO_ADV7343 is not set
# CONFIG_VIDEO_ADV7393 is not set
# CONFIG_VIDEO_ADV7511 is not set
# CONFIG_VIDEO_AK881X is not set
# CONFIG_VIDEO_SAA7127 is not set
# CONFIG_VIDEO_SAA7185 is not set
# CONFIG_VIDEO_THS8200 is not set
# end of Video encoders

#
# Video improvement chips
#
# CONFIG_VIDEO_UPD64031A is not set
# CONFIG_VIDEO_UPD64083 is not set
# end of Video improvement chips

#
# Audio/Video compression chips
#
# CONFIG_VIDEO_SAA6752HS is not set
# end of Audio/Video compression chips

#
# SDR tuner chips
#
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_I2C is not set
# CONFIG_VIDEO_M52790 is not set
# CONFIG_VIDEO_ST_MIPID02 is not set
# CONFIG_VIDEO_THS7303 is not set
# end of Miscellaneous helper chips

#
# Video serializers and deserializers
#
# end of Video serializers and deserializers

#
# Media SPI Adapters
#
# CONFIG_VIDEO_GS1662 is not set
# end of Media SPI Adapters
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
CONFIG_SCREEN_INFO=y
CONFIG_VIDEO=y
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_AGP=m
# CONFIG_AGP_AMD64 is not set
CONFIG_AGP_INTEL=m
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_VIA is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DEBUG_MM is not set
CONFIG_DRM_KMS_HELPER=m
# CONFIG_DRM_PANIC is not set
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
CONFIG_DRM_DEBUG_MODESET_LOCK=y
CONFIG_DRM_CLIENT=y
CONFIG_DRM_CLIENT_LIB=m
CONFIG_DRM_CLIENT_SELECTION=m
CONFIG_DRM_CLIENT_SETUP=y

#
# Supported DRM clients
#
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
# end of Supported DRM clients

CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DISPLAY_HELPER=m
# CONFIG_DRM_DISPLAY_DP_AUX_CEC is not set
# CONFIG_DRM_DISPLAY_DP_AUX_CHARDEV is not set
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_DP_TUNNEL=y
CONFIG_DRM_DISPLAY_DSC_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
CONFIG_DRM_TTM=m
CONFIG_DRM_EXEC=m
CONFIG_DRM_GPUVM=m
CONFIG_DRM_BUDDY=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=m
CONFIG_DRM_SUBALLOC_HELPER=m
CONFIG_DRM_SCHED=m

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

CONFIG_DRM_RADEON=m
CONFIG_DRM_RADEON_USERPTR=y
CONFIG_DRM_AMDGPU=m
# CONFIG_DRM_AMDGPU_SI is not set
# CONFIG_DRM_AMDGPU_CIK is not set
CONFIG_DRM_AMDGPU_USERPTR=y
# CONFIG_DRM_AMD_ISP is not set
# CONFIG_DRM_AMDGPU_WERROR is not set

#
# ACP (Audio CoProcessor) Configuration
#
CONFIG_DRM_AMD_ACP=y
# end of ACP (Audio CoProcessor) Configuration

#
# Display Engine Configuration
#
CONFIG_DRM_AMD_DC=y
CONFIG_DRM_AMD_DC_FP=y
# CONFIG_DRM_AMD_SECURE_DISPLAY is not set
# end of Display Engine Configuration

CONFIG_HSA_AMD=y
CONFIG_HSA_AMD_SVM=y
# CONFIG_HSA_AMD_P2P is not set
CONFIG_DRM_NOUVEAU=m
CONFIG_NOUVEAU_DEBUG=5
CONFIG_NOUVEAU_DEBUG_DEFAULT=3
# CONFIG_NOUVEAU_DEBUG_MMU is not set
# CONFIG_NOUVEAU_DEBUG_PUSH is not set
CONFIG_DRM_NOUVEAU_BACKLIGHT=y
# CONFIG_DRM_NOUVEAU_GSP_DEFAULT is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
# CONFIG_DRM_I915_GVT_KVMGT is not set
CONFIG_DRM_I915_DP_TUNNEL=y

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_REPLAY_GPU_HANGS_API is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_DEBUG_MMIO is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
# CONFIG_DRM_I915_DEBUG_WAKEREF is not set
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_PREEMPT_TIMEOUT_COMPUTE=7500
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

# CONFIG_DRM_XE is not set
# CONFIG_DRM_VGEM is not set
CONFIG_DRM_VKMS=m
CONFIG_DRM_VMWGFX=m
# CONFIG_DRM_VMWGFX_MKSSTATS is not set
# CONFIG_DRM_GMA500 is not set
CONFIG_DRM_UDL=m
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_QXL=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_VIRTIO_GPU_KMS=y
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_AUO_A030JTN01 is not set
# CONFIG_DRM_PANEL_ILITEK_ILI9341 is not set
# CONFIG_DRM_PANEL_ORISETECH_OTA5601A is not set
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_BOCHS=m
CONFIG_DRM_CIRRUS_QEMU=m
CONFIG_DRM_GM12U320=m
# CONFIG_DRM_PANEL_MIPI_DBI is not set
# CONFIG_DRM_SIMPLEDRM is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9163 is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_SHARP_MEMORY is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_XEN_FRONTEND is not set
# CONFIG_DRM_VBOXVIDEO is not set
CONFIG_DRM_GUD=m
# CONFIG_DRM_SSD130X is not set
CONFIG_DRM_HYPERV=m
CONFIG_DRM_PRIVACY_SCREEN=y
# CONFIG_DRM_WERROR is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
CONFIG_FB=y
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_XEN_FBDEV_FRONTEND is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_HYPERV is not set
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
CONFIG_FB_CORE=y
CONFIG_FB_NOTIFY=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_DEVICE=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYSMEM_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_IOMEM_FOPS=y
CONFIG_FB_IOMEM_HELPERS=y
CONFIG_FB_SYSMEM_HELPERS=y
CONFIG_FB_SYSMEM_HELPERS_DEFERRED=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_KTD2801 is not set
# CONFIG_BACKLIGHT_KTZ8866 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3509 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_MP3309C is not set
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_DRM_ACCEL is not set
CONFIG_SOUND=m
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_SEQ_DEVICE=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_UMP=m
CONFIG_SND_UMP_LEGACY_RAWMIDI=y
CONFIG_SND_COMPRESS_OFFLOAD=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
# CONFIG_SND_MIXER_OSS is not set
# CONFIG_SND_PCM_OSS is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=m
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
CONFIG_SND_CTL_FAST_LOOKUP=y
# CONFIG_SND_DEBUG is not set
# CONFIG_SND_CTL_INPUT_VALIDATION is not set
# CONFIG_SND_UTIMER is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_CTL_LED=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
# CONFIG_SND_SEQUENCER_OSS is not set
CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
CONFIG_SND_SEQ_MIDI_EVENT=m
CONFIG_SND_SEQ_MIDI=m
CONFIG_SND_SEQ_MIDI_EMUL=m
CONFIG_SND_SEQ_VIRMIDI=m
CONFIG_SND_SEQ_UMP=y
CONFIG_SND_SEQ_UMP_CLIENT=m
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_OPL3_LIB_SEQ=m
CONFIG_SND_VX_LIB=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_DRIVERS=y
CONFIG_SND_PCSP=m
CONFIG_SND_DUMMY=m
CONFIG_SND_ALOOP=m
# CONFIG_SND_PCMTEST is not set
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
# CONFIG_SND_MTS64 is not set
# CONFIG_SND_SERIAL_U16550 is not set
CONFIG_SND_MPU401=m
# CONFIG_SND_PORTMAN2X4 is not set
CONFIG_SND_AC97_POWER_SAVE=y
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=0
CONFIG_SND_PCI=y
CONFIG_SND_AD1889=m
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
CONFIG_SND_ALI5451=m
CONFIG_SND_ASIHPI=m
CONFIG_SND_ATIIXP=m
CONFIG_SND_ATIIXP_MODEM=m
CONFIG_SND_AU8810=m
CONFIG_SND_AU8820=m
CONFIG_SND_AU8830=m
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
CONFIG_SND_BT87X=m
# CONFIG_SND_BT87X_OVERCLOCK is not set
CONFIG_SND_CA0106=m
CONFIG_SND_CMIPCI=m
CONFIG_SND_OXYGEN_LIB=m
CONFIG_SND_OXYGEN=m
# CONFIG_SND_CS4281 is not set
CONFIG_SND_CS46XX=m
CONFIG_SND_CS46XX_NEW_DSP=y
CONFIG_SND_CTXFI=m
CONFIG_SND_DARLA20=m
CONFIG_SND_GINA20=m
CONFIG_SND_LAYLA20=m
CONFIG_SND_DARLA24=m
CONFIG_SND_GINA24=m
CONFIG_SND_LAYLA24=m
CONFIG_SND_MONA=m
CONFIG_SND_MIA=m
CONFIG_SND_ECHO3G=m
CONFIG_SND_INDIGO=m
CONFIG_SND_INDIGOIO=m
CONFIG_SND_INDIGODJ=m
CONFIG_SND_INDIGOIOX=m
CONFIG_SND_INDIGODJX=m
CONFIG_SND_EMU10K1=m
CONFIG_SND_EMU10K1_SEQ=m
CONFIG_SND_EMU10K1X=m
CONFIG_SND_ENS1370=m
CONFIG_SND_ENS1371=m
# CONFIG_SND_ES1938 is not set
CONFIG_SND_ES1968=m
CONFIG_SND_ES1968_INPUT=y
# CONFIG_SND_FM801 is not set
CONFIG_SND_HDSP=m
CONFIG_SND_HDSPM=m
CONFIG_SND_ICE1712=m
CONFIG_SND_ICE1724=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
CONFIG_SND_KORG1212=m
CONFIG_SND_LOLA=m
CONFIG_SND_LX6464ES=m
CONFIG_SND_MAESTRO3=m
CONFIG_SND_MAESTRO3_INPUT=y
CONFIG_SND_MIXART=m
# CONFIG_SND_NM256 is not set
CONFIG_SND_PCXHR=m
# CONFIG_SND_RIPTIDE is not set
CONFIG_SND_RME32=m
CONFIG_SND_RME96=m
CONFIG_SND_RME9652=m
# CONFIG_SND_SONICVIBES is not set
CONFIG_SND_TRIDENT=m
CONFIG_SND_VIA82XX=m
CONFIG_SND_VIA82XX_MODEM=m
CONFIG_SND_VIRTUOSO=m
CONFIG_SND_VX222=m
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=m
CONFIG_SND_HDA_GENERIC_LEDS=y
CONFIG_SND_HDA_INTEL=m
CONFIG_SND_HDA_HWDEP=y
CONFIG_SND_HDA_RECONFIG=y
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=0
CONFIG_SND_HDA_PATCH_LOADER=y
CONFIG_SND_HDA_CIRRUS_SCODEC=m
CONFIG_SND_HDA_SCODEC_CS35L41=m
CONFIG_SND_HDA_CS_DSP_CONTROLS=m
CONFIG_SND_HDA_SCODEC_COMPONENT=m
CONFIG_SND_HDA_SCODEC_CS35L41_I2C=m
CONFIG_SND_HDA_SCODEC_CS35L41_SPI=m
CONFIG_SND_HDA_SCODEC_CS35L56=m
CONFIG_SND_HDA_SCODEC_CS35L56_I2C=m
CONFIG_SND_HDA_SCODEC_CS35L56_SPI=m
CONFIG_SND_HDA_SCODEC_TAS2781_I2C=m
CONFIG_SND_HDA_CODEC_REALTEK=m
CONFIG_SND_HDA_CODEC_ANALOG=m
CONFIG_SND_HDA_CODEC_SIGMATEL=m
CONFIG_SND_HDA_CODEC_VIA=m
CONFIG_SND_HDA_CODEC_HDMI=m
CONFIG_SND_HDA_CODEC_CIRRUS=m
CONFIG_SND_HDA_CODEC_CS8409=m
CONFIG_SND_HDA_CODEC_CONEXANT=m
# CONFIG_SND_HDA_CODEC_SENARYTECH is not set
CONFIG_SND_HDA_CODEC_CA0110=m
CONFIG_SND_HDA_CODEC_CA0132=m
CONFIG_SND_HDA_CODEC_CA0132_DSP=y
CONFIG_SND_HDA_CODEC_CMEDIA=m
CONFIG_SND_HDA_CODEC_SI3054=m
CONFIG_SND_HDA_GENERIC=m
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=1
CONFIG_SND_HDA_INTEL_HDMI_SILENT_STREAM=y
# CONFIG_SND_HDA_CTL_DEV_ID is not set
# end of HD-Audio

CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_COMPONENT=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_EXT_CORE=m
CONFIG_SND_HDA_PREALLOC_SIZE=0
CONFIG_SND_INTEL_NHLT=y
CONFIG_SND_INTEL_DSP_CONFIG=m
CONFIG_SND_INTEL_SOUNDWIRE_ACPI=m
# CONFIG_SND_INTEL_BYT_PREFER_SOF is not set
# CONFIG_SND_SPI is not set
CONFIG_SND_USB=y
CONFIG_SND_USB_AUDIO=m
CONFIG_SND_USB_AUDIO_MIDI_V2=y
CONFIG_SND_USB_AUDIO_USE_MEDIA_CONTROLLER=y
CONFIG_SND_USB_UA101=m
CONFIG_SND_USB_USX2Y=m
CONFIG_SND_USB_CAIAQ=m
CONFIG_SND_USB_CAIAQ_INPUT=y
CONFIG_SND_USB_US122L=m
CONFIG_SND_USB_6FIRE=m
CONFIG_SND_USB_HIFACE=m
CONFIG_SND_BCD2000=m
CONFIG_SND_USB_LINE6=m
CONFIG_SND_USB_POD=m
CONFIG_SND_USB_PODHD=m
CONFIG_SND_USB_TONEPORT=m
CONFIG_SND_USB_VARIAX=m
CONFIG_SND_SOC=m
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_TOPOLOGY=y
CONFIG_SND_SOC_ACPI=m
# CONFIG_SND_SOC_ADI is not set
# CONFIG_SND_SOC_AMD_ACP is not set
# CONFIG_SND_SOC_AMD_ACP3x is not set
CONFIG_SND_SOC_AMD_RENOIR=m
CONFIG_SND_SOC_AMD_RENOIR_MACH=m
CONFIG_SND_SOC_AMD_ACP5x=m
CONFIG_SND_SOC_AMD_VANGOGH_MACH=m
CONFIG_SND_SOC_AMD_ACP6x=m
CONFIG_SND_SOC_AMD_YC_MACH=m
CONFIG_SND_AMD_ACP_CONFIG=m
# CONFIG_SND_SOC_AMD_ACP_COMMON is not set
CONFIG_SND_SOC_ACPI_AMD_MATCH=m
CONFIG_SND_AMD_SOUNDWIRE_ACPI=m
# CONFIG_SND_SOC_AMD_RPL_ACP6x is not set
CONFIG_SND_SOC_AMD_ACP63_TOPLEVEL=m
CONFIG_SND_SOC_AMD_SOUNDWIRE_LINK_BASELINE=m
CONFIG_SND_SOC_AMD_SOUNDWIRE=m
CONFIG_SND_SOC_AMD_PS=m
CONFIG_SND_SOC_AMD_PS_MACH=m
# CONFIG_SND_ATMEL_SOC is not set
# CONFIG_SND_BCM63XX_I2S_WHISTLER is not set
# CONFIG_SND_DESIGNWARE_I2S is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
# CONFIG_SND_SOC_FSL_ASRC is not set
# CONFIG_SND_SOC_FSL_SAI is not set
# CONFIG_SND_SOC_FSL_AUDMIX is not set
# CONFIG_SND_SOC_FSL_SSI is not set
# CONFIG_SND_SOC_FSL_SPDIF is not set
# CONFIG_SND_SOC_FSL_ESAI is not set
# CONFIG_SND_SOC_FSL_MICFIL is not set
# CONFIG_SND_SOC_FSL_XCVR is not set
# CONFIG_SND_SOC_IMX_AUDMUX is not set
# end of SoC Audio for Freescale CPUs

# CONFIG_SND_SOC_CHV3_I2S is not set
# CONFIG_SND_I2S_HI6210_I2S is not set

#
# SoC Audio for Loongson CPUs
#
# end of SoC Audio for Loongson CPUs

# CONFIG_SND_SOC_IMG is not set
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
CONFIG_SND_SOC_INTEL_CATPT=m
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=m
# CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=m
CONFIG_SND_SOC_ACPI_INTEL_MATCH=m
CONFIG_SND_SOC_ACPI_INTEL_SDCA_QUIRKS=m
CONFIG_SND_SOC_INTEL_AVS=m

#
# Intel AVS Machine drivers
#

#
# Available DSP configurations
#
# CONFIG_SND_SOC_INTEL_AVS_MACH_DA7219 is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_DMIC is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_ES8336 is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_HDAUDIO is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_I2S_TEST is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_MAX98927 is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_MAX98357A is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_MAX98373 is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_NAU8825 is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_PROBE is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_RT274 is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_RT286 is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_RT298 is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_RT5514 is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_RT5663 is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_RT5682 is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_SSM4567 is not set
# end of Intel AVS Machine drivers

CONFIG_SND_SOC_INTEL_MACH=y
CONFIG_SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES=y
CONFIG_SND_SOC_INTEL_HDA_DSP_COMMON=m
CONFIG_SND_SOC_INTEL_SOF_MAXIM_COMMON=m
CONFIG_SND_SOC_INTEL_SOF_REALTEK_COMMON=m
CONFIG_SND_SOC_INTEL_SOF_CIRRUS_COMMON=m
CONFIG_SND_SOC_INTEL_SOF_NUVOTON_COMMON=m
CONFIG_SND_SOC_INTEL_SOF_BOARD_HELPERS=m
CONFIG_SND_SOC_INTEL_HASWELL_MACH=m
CONFIG_SND_SOC_INTEL_BDW_RT5650_MACH=m
CONFIG_SND_SOC_INTEL_BDW_RT5677_MACH=m
CONFIG_SND_SOC_INTEL_BROADWELL_MACH=m
CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH=m
CONFIG_SND_SOC_INTEL_BYTCR_RT5651_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_NAU8824_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_CX2072X_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_DA7213_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_ES8316_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH=m
CONFIG_SND_SOC_INTEL_SOF_WM8804_MACH=m
CONFIG_SND_SOC_INTEL_GLK_DA7219_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_GLK_RT5682_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH=m
CONFIG_SND_SOC_INTEL_SOF_RT5682_MACH=m
CONFIG_SND_SOC_INTEL_SOF_CS42L42_MACH=m
CONFIG_SND_SOC_INTEL_SOF_PCM512x_MACH=m
CONFIG_SND_SOC_INTEL_SOF_ES8336_MACH=m
CONFIG_SND_SOC_INTEL_SOF_NAU8825_MACH=m
CONFIG_SND_SOC_INTEL_CML_LP_DA7219_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_SOF_CML_RT1011_RT5682_MACH=m
CONFIG_SND_SOC_INTEL_SOF_DA7219_MACH=m
CONFIG_SND_SOC_INTEL_SOF_SSP_AMP_MACH=m
CONFIG_SND_SOC_INTEL_EHL_RT5660_MACH=m
CONFIG_SND_SOC_INTEL_SOUNDWIRE_SOF_MACH=m
# CONFIG_SND_SOC_MTK_BTCVSD is not set
CONFIG_SND_SOC_SDCA=m
CONFIG_SND_SOC_SDCA_OPTIONAL=m
CONFIG_SND_SOC_SOF_TOPLEVEL=y
CONFIG_SND_SOC_SOF_PCI_DEV=m
CONFIG_SND_SOC_SOF_PCI=m
CONFIG_SND_SOC_SOF_ACPI=m
CONFIG_SND_SOC_SOF_ACPI_DEV=m
CONFIG_SND_SOC_SOF_DEBUG_PROBES=m
CONFIG_SND_SOC_SOF_CLIENT=m
# CONFIG_SND_SOC_SOF_DEVELOPER_SUPPORT is not set
CONFIG_SND_SOC_SOF=m
CONFIG_SND_SOC_SOF_PROBE_WORK_QUEUE=y
CONFIG_SND_SOC_SOF_IPC3=y
CONFIG_SND_SOC_SOF_IPC4=y
CONFIG_SND_SOC_SOF_AMD_TOPLEVEL=m
CONFIG_SND_SOC_SOF_AMD_COMMON=m
CONFIG_SND_SOC_SOF_AMD_RENOIR=m
CONFIG_SND_SOC_SOF_AMD_VANGOGH=m
CONFIG_SND_SOC_SOF_AMD_REMBRANDT=m
CONFIG_SND_SOC_SOF_ACP_PROBES=m
# CONFIG_SND_SOC_SOF_AMD_ACP63 is not set
# CONFIG_SND_SOC_SOF_AMD_ACP70 is not set
CONFIG_SND_SOC_SOF_INTEL_TOPLEVEL=y
CONFIG_SND_SOC_SOF_INTEL_HIFI_EP_IPC=m
CONFIG_SND_SOC_SOF_INTEL_ATOM_HIFI_EP=m
CONFIG_SND_SOC_SOF_INTEL_COMMON=m
CONFIG_SND_SOC_SOF_BAYTRAIL=m
CONFIG_SND_SOC_SOF_BROADWELL=m
CONFIG_SND_SOC_SOF_MERRIFIELD=m
# CONFIG_SND_SOC_SOF_SKYLAKE is not set
# CONFIG_SND_SOC_SOF_KABYLAKE is not set
CONFIG_SND_SOC_SOF_INTEL_APL=m
CONFIG_SND_SOC_SOF_APOLLOLAKE=m
CONFIG_SND_SOC_SOF_GEMINILAKE=m
CONFIG_SND_SOC_SOF_INTEL_CNL=m
CONFIG_SND_SOC_SOF_CANNONLAKE=m
CONFIG_SND_SOC_SOF_COFFEELAKE=m
CONFIG_SND_SOC_SOF_COMETLAKE=m
CONFIG_SND_SOC_SOF_INTEL_ICL=m
CONFIG_SND_SOC_SOF_ICELAKE=m
CONFIG_SND_SOC_SOF_JASPERLAKE=m
CONFIG_SND_SOC_SOF_INTEL_TGL=m
CONFIG_SND_SOC_SOF_TIGERLAKE=m
CONFIG_SND_SOC_SOF_ELKHARTLAKE=m
CONFIG_SND_SOC_SOF_ALDERLAKE=m
CONFIG_SND_SOC_SOF_INTEL_MTL=m
CONFIG_SND_SOC_SOF_METEORLAKE=m
CONFIG_SND_SOC_SOF_INTEL_LNL=m
CONFIG_SND_SOC_SOF_LUNARLAKE=m
CONFIG_SND_SOC_SOF_INTEL_PTL=m
CONFIG_SND_SOC_SOF_PANTHERLAKE=m
CONFIG_SND_SOC_SOF_HDA_COMMON=m
CONFIG_SND_SOC_SOF_HDA_GENERIC=m
CONFIG_SND_SOC_SOF_HDA_MLINK=m
CONFIG_SND_SOC_SOF_HDA_LINK=y
CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC=y
CONFIG_SND_SOC_SOF_HDA_LINK_BASELINE=m
CONFIG_SND_SOC_SOF_HDA=m
CONFIG_SND_SOC_SOF_HDA_PROBES=m
CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE=m
CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE=m
CONFIG_SND_SOC_SOF_XTENSA=m

#
# STMicroelectronics STM32 SOC audio support
#
# end of STMicroelectronics STM32 SOC audio support

# CONFIG_SND_SOC_XILINX_I2S is not set
# CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set
# CONFIG_SND_SOC_XILINX_SPDIF is not set
# CONFIG_SND_SOC_XTFPGA_I2S is not set
CONFIG_SND_SOC_I2C_AND_SPI=m

#
# CODEC drivers
#
CONFIG_SND_SOC_WM_ADSP=m
# CONFIG_SND_SOC_AC97_CODEC is not set
# CONFIG_SND_SOC_ADAU1372_I2C is not set
# CONFIG_SND_SOC_ADAU1372_SPI is not set
# CONFIG_SND_SOC_ADAU1373 is not set
# CONFIG_SND_SOC_ADAU1701 is not set
# CONFIG_SND_SOC_ADAU1761_I2C is not set
# CONFIG_SND_SOC_ADAU1761_SPI is not set
# CONFIG_SND_SOC_ADAU7002 is not set
# CONFIG_SND_SOC_ADAU7118_HW is not set
# CONFIG_SND_SOC_ADAU7118_I2C is not set
# CONFIG_SND_SOC_AK4104 is not set
# CONFIG_SND_SOC_AK4118 is not set
# CONFIG_SND_SOC_AK4375 is not set
# CONFIG_SND_SOC_AK4458 is not set
# CONFIG_SND_SOC_AK4554 is not set
# CONFIG_SND_SOC_AK4613 is not set
# CONFIG_SND_SOC_AK4619 is not set
# CONFIG_SND_SOC_AK4642 is not set
# CONFIG_SND_SOC_AK5386 is not set
# CONFIG_SND_SOC_AK5558 is not set
# CONFIG_SND_SOC_ALC5623 is not set
# CONFIG_SND_SOC_AUDIO_IIO_AUX is not set
# CONFIG_SND_SOC_AW8738 is not set
# CONFIG_SND_SOC_AW88395 is not set
# CONFIG_SND_SOC_AW88261 is not set
# CONFIG_SND_SOC_AW88081 is not set
# CONFIG_SND_SOC_AW87390 is not set
# CONFIG_SND_SOC_AW88399 is not set
# CONFIG_SND_SOC_BD28623 is not set
# CONFIG_SND_SOC_BT_SCO is not set
# CONFIG_SND_SOC_CHV3_CODEC is not set
CONFIG_SND_SOC_CS_AMP_LIB=m
# CONFIG_SND_SOC_CS35L32 is not set
# CONFIG_SND_SOC_CS35L33 is not set
# CONFIG_SND_SOC_CS35L34 is not set
# CONFIG_SND_SOC_CS35L35 is not set
# CONFIG_SND_SOC_CS35L36 is not set
CONFIG_SND_SOC_CS35L41_LIB=m
CONFIG_SND_SOC_CS35L41=m
CONFIG_SND_SOC_CS35L41_SPI=m
CONFIG_SND_SOC_CS35L41_I2C=m
# CONFIG_SND_SOC_CS35L45_SPI is not set
# CONFIG_SND_SOC_CS35L45_I2C is not set
CONFIG_SND_SOC_CS35L56=m
CONFIG_SND_SOC_CS35L56_SHARED=m
# CONFIG_SND_SOC_CS35L56_I2C is not set
CONFIG_SND_SOC_CS35L56_SPI=m
CONFIG_SND_SOC_CS35L56_SDW=m
CONFIG_SND_SOC_CS42L42_CORE=m
CONFIG_SND_SOC_CS42L42=m
CONFIG_SND_SOC_CS42L42_SDW=m
CONFIG_SND_SOC_CS42L43=m
CONFIG_SND_SOC_CS42L43_SDW=m
# CONFIG_SND_SOC_CS42L51_I2C is not set
# CONFIG_SND_SOC_CS42L52 is not set
# CONFIG_SND_SOC_CS42L56 is not set
# CONFIG_SND_SOC_CS42L73 is not set
# CONFIG_SND_SOC_CS42L83 is not set
# CONFIG_SND_SOC_CS42L84 is not set
# CONFIG_SND_SOC_CS4234 is not set
# CONFIG_SND_SOC_CS4265 is not set
# CONFIG_SND_SOC_CS4270 is not set
# CONFIG_SND_SOC_CS4271_I2C is not set
# CONFIG_SND_SOC_CS4271_SPI is not set
# CONFIG_SND_SOC_CS42XX8_I2C is not set
# CONFIG_SND_SOC_CS43130 is not set
# CONFIG_SND_SOC_CS4341 is not set
# CONFIG_SND_SOC_CS4349 is not set
# CONFIG_SND_SOC_CS53L30 is not set
# CONFIG_SND_SOC_CS530X_I2C is not set
CONFIG_SND_SOC_CX2072X=m
CONFIG_SND_SOC_DA7213=m
CONFIG_SND_SOC_DA7219=m
CONFIG_SND_SOC_DMIC=m
# CONFIG_SND_SOC_ES7134 is not set
# CONFIG_SND_SOC_ES7241 is not set
CONFIG_SND_SOC_ES83XX_DSM_COMMON=m
# CONFIG_SND_SOC_ES8311 is not set
CONFIG_SND_SOC_ES8316=m
# CONFIG_SND_SOC_ES8323 is not set
CONFIG_SND_SOC_ES8326=m
# CONFIG_SND_SOC_ES8328_I2C is not set
# CONFIG_SND_SOC_ES8328_SPI is not set
# CONFIG_SND_SOC_GTM601 is not set
CONFIG_SND_SOC_HDAC_HDA=m
CONFIG_SND_SOC_HDA=m
# CONFIG_SND_SOC_ICS43432 is not set
# CONFIG_SND_SOC_IDT821034 is not set
# CONFIG_SND_SOC_MAX98088 is not set
CONFIG_SND_SOC_MAX98090=m
CONFIG_SND_SOC_MAX98357A=m
# CONFIG_SND_SOC_MAX98504 is not set
# CONFIG_SND_SOC_MAX9867 is not set
CONFIG_SND_SOC_MAX98927=m
# CONFIG_SND_SOC_MAX98520 is not set
CONFIG_SND_SOC_MAX98363=m
CONFIG_SND_SOC_MAX98373=m
CONFIG_SND_SOC_MAX98373_I2C=m
CONFIG_SND_SOC_MAX98373_SDW=m
CONFIG_SND_SOC_MAX98388=m
CONFIG_SND_SOC_MAX98390=m
# CONFIG_SND_SOC_MAX98396 is not set
# CONFIG_SND_SOC_MAX9860 is not set
# CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
# CONFIG_SND_SOC_PCM1681 is not set
# CONFIG_SND_SOC_PCM1789_I2C is not set
# CONFIG_SND_SOC_PCM179X_I2C is not set
# CONFIG_SND_SOC_PCM179X_SPI is not set
# CONFIG_SND_SOC_PCM186X_I2C is not set
# CONFIG_SND_SOC_PCM186X_SPI is not set
# CONFIG_SND_SOC_PCM3060_I2C is not set
# CONFIG_SND_SOC_PCM3060_SPI is not set
# CONFIG_SND_SOC_PCM3168A_I2C is not set
# CONFIG_SND_SOC_PCM3168A_SPI is not set
# CONFIG_SND_SOC_PCM5102A is not set
CONFIG_SND_SOC_PCM512x=m
CONFIG_SND_SOC_PCM512x_I2C=m
# CONFIG_SND_SOC_PCM512x_SPI is not set
# CONFIG_SND_SOC_PCM6240 is not set
# CONFIG_SND_SOC_PEB2466 is not set
CONFIG_SND_SOC_RL6231=m
CONFIG_SND_SOC_RT_SDW_COMMON=m
CONFIG_SND_SOC_RL6347A=m
CONFIG_SND_SOC_RT286=m
CONFIG_SND_SOC_RT1011=m
CONFIG_SND_SOC_RT1015=m
CONFIG_SND_SOC_RT1015P=m
# CONFIG_SND_SOC_RT1017_SDCA_SDW is not set
CONFIG_SND_SOC_RT1308=m
CONFIG_SND_SOC_RT1308_SDW=m
CONFIG_SND_SOC_RT1316_SDW=m
CONFIG_SND_SOC_RT1318_SDW=m
CONFIG_SND_SOC_RT1320_SDW=m
# CONFIG_SND_SOC_RT5616 is not set
# CONFIG_SND_SOC_RT5631 is not set
CONFIG_SND_SOC_RT5640=m
CONFIG_SND_SOC_RT5645=m
CONFIG_SND_SOC_RT5651=m
# CONFIG_SND_SOC_RT5659 is not set
CONFIG_SND_SOC_RT5660=m
CONFIG_SND_SOC_RT5670=m
CONFIG_SND_SOC_RT5677=m
CONFIG_SND_SOC_RT5677_SPI=m
CONFIG_SND_SOC_RT5682=m
CONFIG_SND_SOC_RT5682_I2C=m
CONFIG_SND_SOC_RT5682_SDW=m
CONFIG_SND_SOC_RT5682S=m
CONFIG_SND_SOC_RT700=m
CONFIG_SND_SOC_RT700_SDW=m
CONFIG_SND_SOC_RT711=m
CONFIG_SND_SOC_RT711_SDW=m
CONFIG_SND_SOC_RT711_SDCA_SDW=m
CONFIG_SND_SOC_RT712_SDCA_SDW=m
CONFIG_SND_SOC_RT712_SDCA_DMIC_SDW=m
CONFIG_SND_SOC_RT721_SDCA_SDW=m
CONFIG_SND_SOC_RT722_SDCA_SDW=m
CONFIG_SND_SOC_RT715=m
CONFIG_SND_SOC_RT715_SDW=m
CONFIG_SND_SOC_RT715_SDCA_SDW=m
# CONFIG_SND_SOC_RT9120 is not set
# CONFIG_SND_SOC_RTQ9128 is not set
# CONFIG_SND_SOC_SDW_MOCKUP is not set
# CONFIG_SND_SOC_SGTL5000 is not set
# CONFIG_SND_SOC_SIMPLE_AMPLIFIER is not set
# CONFIG_SND_SOC_SIMPLE_MUX is not set
# CONFIG_SND_SOC_SMA1303 is not set
# CONFIG_SND_SOC_SMA1307 is not set
# CONFIG_SND_SOC_SPDIF is not set
# CONFIG_SND_SOC_SRC4XXX_I2C is not set
# CONFIG_SND_SOC_SSM2305 is not set
# CONFIG_SND_SOC_SSM2518 is not set
# CONFIG_SND_SOC_SSM2602_SPI is not set
# CONFIG_SND_SOC_SSM2602_I2C is not set
CONFIG_SND_SOC_SSM4567=m
# CONFIG_SND_SOC_STA32X is not set
# CONFIG_SND_SOC_STA350 is not set
# CONFIG_SND_SOC_STI_SAS is not set
# CONFIG_SND_SOC_TAS2552 is not set
# CONFIG_SND_SOC_TAS2562 is not set
# CONFIG_SND_SOC_TAS2764 is not set
# CONFIG_SND_SOC_TAS2770 is not set
# CONFIG_SND_SOC_TAS2780 is not set
CONFIG_SND_SOC_TAS2781_COMLIB=m
CONFIG_SND_SOC_TAS2781_FMWLIB=m
# CONFIG_SND_SOC_TAS2781_I2C is not set
# CONFIG_SND_SOC_TAS5086 is not set
# CONFIG_SND_SOC_TAS571X is not set
# CONFIG_SND_SOC_TAS5720 is not set
# CONFIG_SND_SOC_TAS5805M is not set
# CONFIG_SND_SOC_TAS6424 is not set
# CONFIG_SND_SOC_TDA7419 is not set
# CONFIG_SND_SOC_TFA9879 is not set
# CONFIG_SND_SOC_TFA989X is not set
# CONFIG_SND_SOC_TLV320ADC3XXX is not set
# CONFIG_SND_SOC_TLV320AIC23_I2C is not set
# CONFIG_SND_SOC_TLV320AIC23_SPI is not set
# CONFIG_SND_SOC_TLV320AIC31XX is not set
# CONFIG_SND_SOC_TLV320AIC32X4_I2C is not set
# CONFIG_SND_SOC_TLV320AIC32X4_SPI is not set
# CONFIG_SND_SOC_TLV320AIC3X_I2C is not set
# CONFIG_SND_SOC_TLV320AIC3X_SPI is not set
# CONFIG_SND_SOC_TLV320ADCX140 is not set
CONFIG_SND_SOC_TS3A227E=m
# CONFIG_SND_SOC_TSCS42XX is not set
# CONFIG_SND_SOC_TSCS454 is not set
# CONFIG_SND_SOC_UDA1334 is not set
# CONFIG_SND_SOC_UDA1342 is not set
# CONFIG_SND_SOC_WCD937X_SDW is not set
# CONFIG_SND_SOC_WCD938X_SDW is not set
# CONFIG_SND_SOC_WCD939X_SDW is not set
# CONFIG_SND_SOC_WM8510 is not set
# CONFIG_SND_SOC_WM8523 is not set
# CONFIG_SND_SOC_WM8524 is not set
# CONFIG_SND_SOC_WM8580 is not set
# CONFIG_SND_SOC_WM8711 is not set
# CONFIG_SND_SOC_WM8728 is not set
# CONFIG_SND_SOC_WM8731_I2C is not set
# CONFIG_SND_SOC_WM8731_SPI is not set
# CONFIG_SND_SOC_WM8737 is not set
# CONFIG_SND_SOC_WM8741 is not set
# CONFIG_SND_SOC_WM8750 is not set
# CONFIG_SND_SOC_WM8753 is not set
# CONFIG_SND_SOC_WM8770 is not set
# CONFIG_SND_SOC_WM8776 is not set
# CONFIG_SND_SOC_WM8782 is not set
CONFIG_SND_SOC_WM8804=m
CONFIG_SND_SOC_WM8804_I2C=m
# CONFIG_SND_SOC_WM8804_SPI is not set
# CONFIG_SND_SOC_WM8903 is not set
# CONFIG_SND_SOC_WM8904 is not set
# CONFIG_SND_SOC_WM8940 is not set
# CONFIG_SND_SOC_WM8960 is not set
# CONFIG_SND_SOC_WM8961 is not set
# CONFIG_SND_SOC_WM8962 is not set
# CONFIG_SND_SOC_WM8974 is not set
# CONFIG_SND_SOC_WM8978 is not set
# CONFIG_SND_SOC_WM8985 is not set
# CONFIG_SND_SOC_WSA881X is not set
# CONFIG_SND_SOC_WSA883X is not set
# CONFIG_SND_SOC_WSA884X is not set
# CONFIG_SND_SOC_ZL38060 is not set
# CONFIG_SND_SOC_MAX9759 is not set
# CONFIG_SND_SOC_MT6351 is not set
# CONFIG_SND_SOC_MT6357 is not set
# CONFIG_SND_SOC_MT6358 is not set
# CONFIG_SND_SOC_MT6660 is not set
CONFIG_SND_SOC_NAU8315=m
# CONFIG_SND_SOC_NAU8540 is not set
# CONFIG_SND_SOC_NAU8810 is not set
CONFIG_SND_SOC_NAU8821=m
# CONFIG_SND_SOC_NAU8822 is not set
CONFIG_SND_SOC_NAU8824=m
CONFIG_SND_SOC_NAU8825=m
# CONFIG_SND_SOC_NTP8918 is not set
# CONFIG_SND_SOC_NTP8835 is not set
# CONFIG_SND_SOC_TPA6130A2 is not set
# CONFIG_SND_SOC_LPASS_WSA_MACRO is not set
# CONFIG_SND_SOC_LPASS_VA_MACRO is not set
# CONFIG_SND_SOC_LPASS_RX_MACRO is not set
# CONFIG_SND_SOC_LPASS_TX_MACRO is not set
# end of CODEC drivers

CONFIG_SND_SOC_SDW_UTILS=m
# CONFIG_SND_SIMPLE_CARD is not set
CONFIG_SND_X86=y
CONFIG_HDMI_LPE_AUDIO=m
CONFIG_SND_SYNTH_EMUX=m
CONFIG_SND_XEN_FRONTEND=m
CONFIG_SND_VIRTIO=m
CONFIG_AC97_BUS=m
CONFIG_HID_SUPPORT=y
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=y
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=y
CONFIG_HID_APPLEIR=m
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
CONFIG_HID_BETOP_FF=m
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=m
CONFIG_HID_CHICONY=m
CONFIG_HID_CORSAIR=m
CONFIG_HID_COUGAR=m
# CONFIG_HID_MACALLY is not set
CONFIG_HID_PRODIKEYS=m
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
CONFIG_HID_ELAN=m
CONFIG_HID_ELECOM=m
CONFIG_HID_ELO=m
CONFIG_HID_EVISION=m
CONFIG_HID_EZKEY=m
# CONFIG_HID_FT260 is not set
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
CONFIG_HID_HOLTEK=m
# CONFIG_HOLTEK_FF is not set
# CONFIG_HID_GOODIX_SPI is not set
# CONFIG_HID_GOOGLE_STADIA_FF is not set
# CONFIG_HID_VIVALDI is not set
CONFIG_HID_GT683R=m
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
# CONFIG_HID_KYSONA is not set
CONFIG_HID_UCLOGIC=m
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_VRC2 is not set
CONFIG_HID_XIAOMI=m
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=y
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
CONFIG_HID_LETSKETCH=m
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
CONFIG_LOGITECH_FF=y
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_MEGAWORLD_FF is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=y
# CONFIG_HID_NINTENDO is not set
CONFIG_HID_NTI=m
CONFIG_HID_NTRIG=y
# CONFIG_HID_NVIDIA_SHIELD is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
CONFIG_HID_PENMOUNT=m
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
# CONFIG_HID_PICOLCD_CIR is not set
CONFIG_HID_PLANTRONICS=m
CONFIG_HID_PLAYSTATION=y
CONFIG_PLAYSTATION_FF=y
# CONFIG_HID_PXRC is not set
# CONFIG_HID_RAZER is not set
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
CONFIG_HID_ROCCAT=m
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
CONFIG_HID_SEMITEK=m
CONFIG_HID_SIGMAMICRO=m
CONFIG_HID_SONY=y
CONFIG_SONY_FF=y
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
# CONFIG_HID_TOPRE is not set
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
CONFIG_HID_WACOM=y
CONFIG_HID_WIIMOTE=m
# CONFIG_HID_WINWING is not set
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
CONFIG_ZEROPLUS_FF=y
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2200 is not set
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# HID-BPF support
#
CONFIG_HID_BPF=y
# end of HID-BPF support

#
# USB HID support
#
CONFIG_USB_HID=y
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y
# end of USB HID support

CONFIG_I2C_HID=y
CONFIG_I2C_HID_ACPI=m
# CONFIG_I2C_HID_OF is not set
CONFIG_I2C_HID_CORE=m

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=m
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
CONFIG_AMD_SFH_HID=m
# end of AMD SFH HID Support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_PCI_AMD=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=m
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_DEFAULT_AUTHORIZATION_MODE=1
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
CONFIG_USB_XHCI_DBGCAP=y
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
CONFIG_USB_XHCI_PLATFORM=m
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_TEST_MODE is not set
# CONFIG_USB_XEN_HCD is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_WDM=m
CONFIG_USB_TMC=m

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=m
CONFIG_REALTEK_AUTOPM=y
CONFIG_USB_STORAGE_DATAFAB=m
CONFIG_USB_STORAGE_FREECOM=m
CONFIG_USB_STORAGE_ISD200=m
CONFIG_USB_STORAGE_USBAT=m
CONFIG_USB_STORAGE_SDDR09=m
CONFIG_USB_STORAGE_SDDR55=m
CONFIG_USB_STORAGE_JUMPSHOT=m
CONFIG_USB_STORAGE_ALAUDA=m
CONFIG_USB_STORAGE_ONETOUCH=m
CONFIG_USB_STORAGE_KARMA=m
CONFIG_USB_STORAGE_CYPRESS_ATACB=m
CONFIG_USB_STORAGE_ENE_UB6250=m
CONFIG_USB_UAS=m

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m
# CONFIG_USBIP_CORE is not set

#
# USB dual-mode controller drivers
#
# CONFIG_USB_CDNS_SUPPORT is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_SERIAL=y
CONFIG_USB_SERIAL_CONSOLE=y
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
CONFIG_USB_SERIAL_AIRCABLE=m
CONFIG_USB_SERIAL_ARK3116=m
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_CH341=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_CP210X=m
CONFIG_USB_SERIAL_CYPRESS_M8=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
# CONFIG_USB_SERIAL_F81232 is not set
CONFIG_USB_SERIAL_F8153X=m
CONFIG_USB_SERIAL_GARMIN=m
CONFIG_USB_SERIAL_IPW=m
CONFIG_USB_SERIAL_IUU=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
# CONFIG_USB_SERIAL_METRO is not set
CONFIG_USB_SERIAL_MOS7720=m
CONFIG_USB_SERIAL_MOS7715_PARPORT=y
CONFIG_USB_SERIAL_MOS7840=m
CONFIG_USB_SERIAL_MXUPORT=m
CONFIG_USB_SERIAL_NAVMAN=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_OTI6858=m
CONFIG_USB_SERIAL_QCAUX=m
CONFIG_USB_SERIAL_QUALCOMM=m
CONFIG_USB_SERIAL_SPCP8X5=m
CONFIG_USB_SERIAL_SAFE=m
CONFIG_USB_SERIAL_SAFE_PADDED=y
CONFIG_USB_SERIAL_SIERRAWIRELESS=m
CONFIG_USB_SERIAL_SYMBOL=m
# CONFIG_USB_SERIAL_TI is not set
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_WWAN=m
CONFIG_USB_SERIAL_OPTION=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_SERIAL_OPTICON=m
CONFIG_USB_SERIAL_XSENS_MT=m
# CONFIG_USB_SERIAL_WISHBONE is not set
CONFIG_USB_SERIAL_SSU100=m
CONFIG_USB_SERIAL_QT2=m
CONFIG_USB_SERIAL_UPD78F0730=m
# CONFIG_USB_SERIAL_XR is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
CONFIG_USB_USS720=m
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
CONFIG_USB_ADUTUX=m
CONFIG_USB_SEVSEG=m
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
CONFIG_USB_IDMOUSE=m
CONFIG_USB_APPLEDISPLAY=m
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_LJCA is not set
CONFIG_USB_SISUSBVGA=m
CONFIG_USB_LD=m
# CONFIG_USB_TRANCEVIBRATOR is not set
CONFIG_USB_IOWARRIOR=m
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
CONFIG_USB_ISIGHTFW=m
# CONFIG_USB_YUREX is not set
CONFIG_USB_EZUSB_FX2=m
# CONFIG_USB_HUB_USB251XB is not set
CONFIG_USB_HSIC_USB3503=m
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
CONFIG_USB_ATM=m
CONFIG_USB_SPEEDTOUCH=m
CONFIG_USB_CXACRU=m
CONFIG_USB_UEAGLEATM=m
CONFIG_USB_XUSBATM=m

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
CONFIG_TYPEC_TCPM=m
CONFIG_TYPEC_TCPCI=m
# CONFIG_TYPEC_RT1711H is not set
# CONFIG_TYPEC_TCPCI_MAXIM is not set
CONFIG_TYPEC_FUSB302=m
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_UCSI_STM32G0 is not set
CONFIG_TYPEC_TPS6598X=m
# CONFIG_TYPEC_ANX7411 is not set
CONFIG_TYPEC_RT1719=m
# CONFIG_TYPEC_HD3SS3220 is not set
# CONFIG_TYPEC_STUSB160X is not set
CONFIG_TYPEC_WUSB3801=m

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
CONFIG_TYPEC_MUX_FSA4480=m
# CONFIG_TYPEC_MUX_GPIO_SBU is not set
CONFIG_TYPEC_MUX_PI3USB30532=m
# CONFIG_TYPEC_MUX_IT5205 is not set
# CONFIG_TYPEC_MUX_NB7VPQ904M is not set
# CONFIG_TYPEC_MUX_PTN36502 is not set
# CONFIG_TYPEC_MUX_TUSB1046 is not set
# CONFIG_TYPEC_MUX_WCD939X_USBSS is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
CONFIG_TYPEC_DP_ALTMODE=m
# CONFIG_TYPEC_NVIDIA_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

CONFIG_USB_ROLE_SWITCH=y
CONFIG_USB_ROLES_INTEL_XHCI=m
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_UHS2=m
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
CONFIG_MMC_TIFM_SD=m
# CONFIG_MMC_SPI is not set
CONFIG_MMC_CB710=m
CONFIG_MMC_VIA_SDMMC=m
CONFIG_MMC_VUB300=m
CONFIG_MMC_USHC=m
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_REALTEK_PCI=m
CONFIG_MMC_REALTEK_USB=m
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_SCSI_UFSHCD is not set
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=m
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=m
CONFIG_MEMSTICK_JMICRON_38X=m
CONFIG_MEMSTICK_R592=m
CONFIG_MEMSTICK_REALTEK_USB=m
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
CONFIG_LEDS_CLASS_MULTICOLOR=y
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
# CONFIG_LEDS_AW200XX is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_PCA995X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2606MVV is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
CONFIG_LEDS_LT3593=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set
# CONFIG_LEDS_IS31FL319X is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
# CONFIG_LEDS_BLINKM_MULTICOLOR is not set
CONFIG_LEDS_MLXCPLD=m
CONFIG_LEDS_MLXREG=m
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_SPI_BYTE is not set

#
# Flash and Torch LED drivers
#

#
# RGB LED drivers
#
# CONFIG_LEDS_KTD202X is not set
# CONFIG_LEDS_PWM_MULTICOLOR is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
CONFIG_LEDS_TRIGGER_DISK=y
# CONFIG_LEDS_TRIGGER_MTD is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
# CONFIG_LEDS_TRIGGER_TTY is not set
# CONFIG_LEDS_TRIGGER_INPUT_EVENTS is not set

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
CONFIG_INFINIBAND=m
CONFIG_INFINIBAND_USER_MAD=m
CONFIG_INFINIBAND_USER_ACCESS=m
CONFIG_INFINIBAND_USER_MEM=y
CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
CONFIG_INFINIBAND_ADDR_TRANS=y
CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=y
CONFIG_INFINIBAND_VIRT_DMA=y
CONFIG_INFINIBAND_BNXT_RE=m
CONFIG_INFINIBAND_CXGB4=m
CONFIG_INFINIBAND_EFA=m
# CONFIG_INFINIBAND_ERDMA is not set
CONFIG_INFINIBAND_HFI1=m
# CONFIG_HFI1_DEBUG_SDMA_ORDER is not set
# CONFIG_SDMA_VERBOSITY is not set
CONFIG_INFINIBAND_IRDMA=m
CONFIG_MANA_INFINIBAND=m
CONFIG_MLX4_INFINIBAND=m
CONFIG_MLX5_INFINIBAND=m
# CONFIG_INFINIBAND_MTHCA is not set
# CONFIG_INFINIBAND_OCRDMA is not set
CONFIG_INFINIBAND_QEDR=m
# CONFIG_INFINIBAND_QIB is not set
CONFIG_INFINIBAND_USNIC=m
CONFIG_INFINIBAND_VMWARE_PVRDMA=m
CONFIG_INFINIBAND_RDMAVT=m
CONFIG_RDMA_RXE=m
CONFIG_RDMA_SIW=m
CONFIG_INFINIBAND_IPOIB=m
CONFIG_INFINIBAND_IPOIB_CM=y
CONFIG_INFINIBAND_IPOIB_DEBUG=y
# CONFIG_INFINIBAND_IPOIB_DEBUG_DATA is not set
CONFIG_INFINIBAND_SRP=m
CONFIG_INFINIBAND_SRPT=m
CONFIG_INFINIBAND_ISER=m
CONFIG_INFINIBAND_ISERT=m
# CONFIG_INFINIBAND_RTRS_CLIENT is not set
# CONFIG_INFINIBAND_RTRS_SERVER is not set
CONFIG_INFINIBAND_OPA_VNIC=m
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=m
CONFIG_EDAC_GHES=y
CONFIG_EDAC_AMD64=m
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
CONFIG_EDAC_I10NM=m
CONFIG_EDAC_PND2=m
CONFIG_EDAC_IGEN6=m
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
# CONFIG_RTC_DRV_MAX31335 is not set
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
# CONFIG_RTC_DRV_RX8111 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
CONFIG_RTC_DRV_RV8803=m
# CONFIG_RTC_DRV_SD2405AL is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
# CONFIG_RTC_DRV_RV3029_HWMON is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_RP5C01=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
# CONFIG_RTC_DRV_GOLDFISH is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=m
CONFIG_INTEL_IDXD_BUS=m
CONFIG_INTEL_IDXD=m
# CONFIG_INTEL_IDXD_COMPAT is not set
CONFIG_INTEL_IDXD_SVM=y
CONFIG_INTEL_IDXD_PERFMON=y
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_XILINX_DMA is not set
# CONFIG_XILINX_XDMA is not set
# CONFIG_AMD_QDMA is not set
CONFIG_AMD_PTDMA=m
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
CONFIG_UDMABUF=y
CONFIG_DMABUF_MOVE_NOTIFY=y
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
CONFIG_DMABUF_HEAPS=y
# CONFIG_DMABUF_SYSFS_STATS is not set
CONFIG_DMABUF_HEAPS_SYSTEM=y
# CONFIG_DMABUF_HEAPS_CMA is not set
# end of DMABUF options

CONFIG_DCA=m
CONFIG_UIO=m
# CONFIG_UIO_CIF is not set
# CONFIG_UIO_PDRV_GENIRQ is not set
# CONFIG_UIO_DMEM_GENIRQ is not set
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_MF624 is not set
CONFIG_UIO_HV_GENERIC=m
CONFIG_VFIO=m
CONFIG_VFIO_DEVICE_CDEV=y
CONFIG_VFIO_GROUP=y
CONFIG_VFIO_CONTAINER=y
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_VIRQFD=y
# CONFIG_VFIO_DEBUGFS is not set

#
# VFIO support for PCI devices
#
CONFIG_VFIO_PCI_CORE=m
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_MLX5_VFIO_PCI=m
# CONFIG_VIRTIO_VFIO_PCI is not set
# CONFIG_QAT_VFIO_PCI is not set
# end of VFIO support for PCI devices

CONFIG_VFIO_MDEV=m
CONFIG_IRQ_BYPASS_MANAGER=y
CONFIG_VIRT_DRIVERS=y
CONFIG_VMGENID=y
# CONFIG_VBOXGUEST is not set
CONFIG_NITRO_ENCLAVES=m
CONFIG_TSM_REPORTS=m
CONFIG_EFI_SECRET=m
CONFIG_SEV_GUEST=m
CONFIG_TDX_GUEST_DRIVER=m
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_PCI_LIB_LEGACY=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_ADMIN_LEGACY=y
CONFIG_VIRTIO_PCI_LEGACY=y
CONFIG_VIRTIO_VDPA=m
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=m
CONFIG_VIRTIO_MEM=m
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VIRTIO_DEBUG is not set
CONFIG_VDPA=m
CONFIG_VDPA_SIM=m
CONFIG_VDPA_SIM_NET=m
CONFIG_VDPA_SIM_BLOCK=m
# CONFIG_VDPA_USER is not set
CONFIG_IFCVF=m
CONFIG_MLX5_VDPA=y
CONFIG_MLX5_VDPA_NET=m
# CONFIG_MLX5_VDPA_STEERING_DEBUG is not set
CONFIG_VP_VDPA=m
# CONFIG_ALIBABA_ENI_VDPA is not set
# CONFIG_SNET_VDPA is not set
# CONFIG_OCTEONEP_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST_RING=m
CONFIG_VHOST_TASK=y
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
CONFIG_VHOST_VDPA=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
# CONFIG_HYPERV_VTL_MODE is not set
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

#
# Xen driver support
#
# CONFIG_XEN_BALLOON is not set
CONFIG_XEN_DEV_EVTCHN=m
# CONFIG_XEN_BACKEND is not set
CONFIG_XENFS=m
CONFIG_XEN_COMPAT_XENFS=y
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
# CONFIG_XEN_GNTDEV is not set
# CONFIG_XEN_GRANT_DEV_ALLOC is not set
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
# CONFIG_XEN_PVCALLS_FRONTEND is not set
CONFIG_XEN_PRIVCMD=m
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
CONFIG_XEN_FRONT_PGDIR_SHBUF=m
# CONFIG_XEN_UNPOPULATED_ALLOC is not set
# CONFIG_XEN_VIRTIO is not set
# end of Xen driver support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
# CONFIG_STAGING is not set
# CONFIG_GOLDFISH is not set
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_CZNIC_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
CONFIG_MLXREG_IO=m
CONFIG_MLXREG_LC=m
CONFIG_NVSW_SN2201=m
# CONFIG_SURFACE_PLATFORMS is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_HUAWEI_WMI is not set
CONFIG_UV_SYSFS=m
CONFIG_MXM_WMI=m
CONFIG_NVIDIA_WMI_EC_BACKLIGHT=m
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
# CONFIG_YOGABOOK is not set
# CONFIG_ACERHDF is not set
CONFIG_ACER_WIRELESS=m
CONFIG_ACER_WMI=m

#
# AMD HSMP Driver
#
# CONFIG_AMD_HSMP_ACPI is not set
# CONFIG_AMD_HSMP_PLAT is not set
# end of AMD HSMP Driver

CONFIG_AMD_PMC=m
CONFIG_AMD_MP2_STB=y
# CONFIG_AMD_3D_VCACHE is not set
# CONFIG_AMD_WBRF is not set
# CONFIG_ADV_SWBUTTON is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
# CONFIG_ASUS_TF103C_DOCK is not set
# CONFIG_MERAKI_MX100 is not set
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
CONFIG_X86_PLATFORM_DRIVERS_DELL=y
# CONFIG_ALIENWARE_WMI is not set
CONFIG_DCDBAS=m
CONFIG_DELL_LAPTOP=m
CONFIG_DELL_RBU=m
CONFIG_DELL_RBTN=m
CONFIG_DELL_PC=m
CONFIG_DELL_SMBIOS=m
CONFIG_DELL_SMBIOS_WMI=y
# CONFIG_DELL_SMBIOS_SMM is not set
CONFIG_DELL_SMO8800=m
CONFIG_DELL_WMI=m
CONFIG_DELL_WMI_PRIVACY=y
CONFIG_DELL_WMI_AIO=m
CONFIG_DELL_WMI_DESCRIPTOR=m
CONFIG_DELL_WMI_DDV=m
CONFIG_DELL_WMI_LED=m
CONFIG_DELL_WMI_SYSMAN=m
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_X86_PLATFORM_DRIVERS_HP is not set
CONFIG_WIRELESS_HOTKEY=m
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
# CONFIG_LENOVO_YMC is not set
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
CONFIG_THINKPAD_ACPI_ALSA_SUPPORT=y
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
CONFIG_THINKPAD_LMI=m
# CONFIG_INTEL_ATOMISP2_PM is not set
CONFIG_INTEL_IFS=m
# CONFIG_INTEL_SAR_INT1092 is not set
CONFIG_INTEL_PMC_CORE=m
CONFIG_INTEL_PMT_CLASS=m
CONFIG_INTEL_PMT_TELEMETRY=m
CONFIG_INTEL_PMT_CRASHLOG=m

#
# Intel Speed Select Technology interface support
#
CONFIG_INTEL_SPEED_SELECT_TPMI=m
CONFIG_INTEL_SPEED_SELECT_INTERFACE=m
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_WMI=y
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m

#
# Intel Uncore Frequency Control
#
CONFIG_INTEL_UNCORE_FREQ_CONTROL_TPMI=m
CONFIG_INTEL_UNCORE_FREQ_CONTROL=m
# end of Intel Uncore Frequency Control

CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_OAKTRAIL=m
CONFIG_INTEL_ISHTP_ECLITE=m
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_INTEL_RST=m
CONFIG_INTEL_SDSI=m
# CONFIG_INTEL_SMARTCONNECT is not set
CONFIG_INTEL_TPMI_POWER_DOMAINS=m
CONFIG_INTEL_TPMI=m
# CONFIG_INTEL_PLR_TPMI is not set
CONFIG_INTEL_TURBO_MAX_3=y
CONFIG_INTEL_VSEC=m
# CONFIG_ACPI_QUICKSTART is not set
# CONFIG_MEEGOPAD_ANX7428 is not set
# CONFIG_MSI_EC is not set
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_MSI_WMI_PLATFORM is not set
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_BARCO_P50_GPIO is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
# CONFIG_ACPI_CMPC is not set
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
CONFIG_SERIAL_MULTI_INSTANTIATE=m
CONFIG_MLX_PLATFORM=m
# CONFIG_INSPUR_PLATFORM_PROFILE is not set
# CONFIG_LENOVO_WMI_CAMERA is not set
CONFIG_FW_ATTR_CLASS=m
CONFIG_INTEL_IPS=m
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
# CONFIG_SIEMENS_SIMATIC_IPC is not set
# CONFIG_SILICOM_PLATFORM is not set
# CONFIG_WINMATE_FM07_KEYS is not set
# CONFIG_SEL3350_PLATFORM is not set
CONFIG_P2SB=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_LMK04832 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_XILINX_VCU is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOMMU_API=y
CONFIG_IOMMUFD_DRIVER=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
CONFIG_IOMMU_IO_PGTABLE=y
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
CONFIG_IOMMU_SVA=y
CONFIG_IOMMU_IOPF=y
CONFIG_AMD_IOMMU=y
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
CONFIG_INTEL_IOMMU_SVM=y
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
# CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_PERF_EVENTS=y
CONFIG_IOMMUFD_DRIVER_CORE=y
CONFIG_IOMMUFD=m
# CONFIG_IOMMUFD_TEST is not set
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y
CONFIG_VIRTIO_IOMMU=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

CONFIG_SOUNDWIRE=m

#
# SoundWire Devices
#
CONFIG_SOUNDWIRE_AMD=m
CONFIG_SOUNDWIRE_CADENCE=m
CONFIG_SOUNDWIRE_INTEL=m
# CONFIG_SOUNDWIRE_QCOM is not set
CONFIG_SOUNDWIRE_GENERIC_ALLOCATION=m

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# fujitsu SoC drivers
#
# end of fujitsu SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

# CONFIG_WPCM450_SOC is not set

#
# Qualcomm SoC drivers
#
CONFIG_QCOM_QMI_HELPERS=m
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

#
# PM Domains
#

#
# Amlogic PM Domains
#
# end of Amlogic PM Domains

#
# Broadcom PM Domains
#
# end of Broadcom PM Domains

#
# i.MX PM Domains
#
# end of i.MX PM Domains

#
# Qualcomm PM Domains
#
# end of Qualcomm PM Domains
# end of PM Domains

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
CONFIG_IIO=m
CONFIG_IIO_BUFFER=y
# CONFIG_IIO_BUFFER_CB is not set
# CONFIG_IIO_BUFFER_DMA is not set
# CONFIG_IIO_BUFFER_DMAENGINE is not set
# CONFIG_IIO_BUFFER_HW_CONSUMER is not set
CONFIG_IIO_KFIFO_BUF=m
CONFIG_IIO_TRIGGERED_BUFFER=m
# CONFIG_IIO_CONFIGFS is not set
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
# CONFIG_IIO_SW_DEVICE is not set
# CONFIG_IIO_SW_TRIGGER is not set
# CONFIG_IIO_TRIGGERED_EVENT is not set

#
# Accelerometers
#
# CONFIG_ADIS16201 is not set
# CONFIG_ADIS16209 is not set
# CONFIG_ADXL313_I2C is not set
# CONFIG_ADXL313_SPI is not set
# CONFIG_ADXL345_I2C is not set
# CONFIG_ADXL345_SPI is not set
# CONFIG_ADXL355_I2C is not set
# CONFIG_ADXL355_SPI is not set
# CONFIG_ADXL367_SPI is not set
# CONFIG_ADXL367_I2C is not set
# CONFIG_ADXL372_SPI is not set
# CONFIG_ADXL372_I2C is not set
# CONFIG_ADXL380_SPI is not set
# CONFIG_ADXL380_I2C is not set
# CONFIG_BMA180 is not set
# CONFIG_BMA220 is not set
# CONFIG_BMA400 is not set
# CONFIG_BMC150_ACCEL is not set
# CONFIG_BMI088_ACCEL is not set
# CONFIG_DA280 is not set
# CONFIG_DA311 is not set
# CONFIG_DMARD06 is not set
# CONFIG_DMARD09 is not set
# CONFIG_DMARD10 is not set
# CONFIG_FXLS8962AF_I2C is not set
# CONFIG_FXLS8962AF_SPI is not set
CONFIG_HID_SENSOR_ACCEL_3D=m
# CONFIG_IIO_ST_ACCEL_3AXIS is not set
# CONFIG_IIO_KX022A_SPI is not set
# CONFIG_IIO_KX022A_I2C is not set
# CONFIG_KXSD9 is not set
# CONFIG_KXCJK1013 is not set
# CONFIG_MC3230 is not set
# CONFIG_MMA7455_I2C is not set
# CONFIG_MMA7455_SPI is not set
# CONFIG_MMA7660 is not set
# CONFIG_MMA8452 is not set
# CONFIG_MMA9551 is not set
# CONFIG_MMA9553 is not set
# CONFIG_MSA311 is not set
# CONFIG_MXC4005 is not set
# CONFIG_MXC6255 is not set
# CONFIG_SCA3000 is not set
# CONFIG_SCA3300 is not set
# CONFIG_STK8312 is not set
# CONFIG_STK8BA50 is not set
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD4000 is not set
# CONFIG_AD4130 is not set
# CONFIG_AD4695 is not set
# CONFIG_AD7091R5 is not set
# CONFIG_AD7091R8 is not set
# CONFIG_AD7124 is not set
# CONFIG_AD7173 is not set
# CONFIG_AD7192 is not set
# CONFIG_AD7266 is not set
# CONFIG_AD7280 is not set
# CONFIG_AD7291 is not set
# CONFIG_AD7292 is not set
# CONFIG_AD7298 is not set
# CONFIG_AD7380 is not set
# CONFIG_AD7476 is not set
# CONFIG_AD7606_IFACE_PARALLEL is not set
# CONFIG_AD7606_IFACE_SPI is not set
# CONFIG_AD7625 is not set
# CONFIG_AD7766 is not set
# CONFIG_AD7768_1 is not set
# CONFIG_AD7779 is not set
# CONFIG_AD7780 is not set
# CONFIG_AD7791 is not set
# CONFIG_AD7793 is not set
# CONFIG_AD7887 is not set
# CONFIG_AD7923 is not set
# CONFIG_AD7944 is not set
# CONFIG_AD7949 is not set
# CONFIG_AD799X is not set
# CONFIG_AD9467 is not set
# CONFIG_ENVELOPE_DETECTOR is not set
# CONFIG_GEHC_PMC_ADC is not set
# CONFIG_HI8435 is not set
# CONFIG_HX711 is not set
# CONFIG_INA2XX_ADC is not set
# CONFIG_LTC2309 is not set
# CONFIG_LTC2471 is not set
# CONFIG_LTC2485 is not set
# CONFIG_LTC2496 is not set
# CONFIG_LTC2497 is not set
# CONFIG_MAX1027 is not set
# CONFIG_MAX11100 is not set
# CONFIG_MAX1118 is not set
# CONFIG_MAX11205 is not set
# CONFIG_MAX11410 is not set
# CONFIG_MAX1241 is not set
# CONFIG_MAX1363 is not set
# CONFIG_MAX34408 is not set
# CONFIG_MAX9611 is not set
# CONFIG_MCP320X is not set
# CONFIG_MCP3422 is not set
# CONFIG_MCP3564 is not set
# CONFIG_MCP3911 is not set
# CONFIG_NAU7802 is not set
# CONFIG_PAC1921 is not set
# CONFIG_PAC1934 is not set
# CONFIG_RICHTEK_RTQ6056 is not set
# CONFIG_SD_ADC_MODULATOR is not set
# CONFIG_TI_ADC081C is not set
# CONFIG_TI_ADC0832 is not set
# CONFIG_TI_ADC084S021 is not set
# CONFIG_TI_ADC12138 is not set
# CONFIG_TI_ADC108S102 is not set
# CONFIG_TI_ADC128S052 is not set
# CONFIG_TI_ADC161S626 is not set
# CONFIG_TI_ADS1015 is not set
# CONFIG_TI_ADS1119 is not set
# CONFIG_TI_ADS7924 is not set
# CONFIG_TI_ADS1100 is not set
# CONFIG_TI_ADS1298 is not set
# CONFIG_TI_ADS7950 is not set
# CONFIG_TI_ADS8344 is not set
# CONFIG_TI_ADS8688 is not set
# CONFIG_TI_ADS124S08 is not set
# CONFIG_TI_ADS131E08 is not set
# CONFIG_TI_LMP92064 is not set
# CONFIG_TI_TLC4541 is not set
# CONFIG_TI_TSC2046 is not set
# CONFIG_VF610_ADC is not set
# CONFIG_XILINX_XADC is not set
# end of Analog to digital converters

#
# Analog to digital and digital to analog converters
#
# CONFIG_AD74115 is not set
# CONFIG_AD74413R is not set
# end of Analog to digital and digital to analog converters

#
# Analog Front Ends
#
# CONFIG_IIO_RESCALE is not set
# end of Analog Front Ends

#
# Amplifiers
#
# CONFIG_AD8366 is not set
# CONFIG_ADA4250 is not set
# CONFIG_HMC425 is not set
# end of Amplifiers

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
# CONFIG_AD7746 is not set
# end of Capacitance to digital converters

#
# Chemical Sensors
#
# CONFIG_AOSONG_AGS02MA is not set
# CONFIG_ATLAS_PH_SENSOR is not set
# CONFIG_ATLAS_EZO_SENSOR is not set
# CONFIG_BME680 is not set
# CONFIG_CCS811 is not set
# CONFIG_ENS160 is not set
# CONFIG_IAQCORE is not set
# CONFIG_SCD30_CORE is not set
# CONFIG_SCD4X is not set
# CONFIG_SENSIRION_SGP30 is not set
# CONFIG_SENSIRION_SGP40 is not set
# CONFIG_SPS30_I2C is not set
# CONFIG_SENSEAIR_SUNRISE_CO2 is not set
# CONFIG_VZ89X is not set
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=m
CONFIG_HID_SENSOR_IIO_TRIGGER=m
# end of Hid Sensor IIO Common

#
# IIO SCMI Sensors
#
# end of IIO SCMI Sensors

#
# SSP Sensor Common
#
# CONFIG_IIO_SSP_SENSORHUB is not set
# end of SSP Sensor Common

#
# Digital to analog converters
#
# CONFIG_AD3552R_HS is not set
# CONFIG_AD3552R is not set
# CONFIG_AD5064 is not set
# CONFIG_AD5360 is not set
# CONFIG_AD5380 is not set
# CONFIG_AD5421 is not set
# CONFIG_AD5446 is not set
# CONFIG_AD5449 is not set
# CONFIG_AD5592R is not set
# CONFIG_AD5593R is not set
# CONFIG_AD5504 is not set
# CONFIG_AD5624R_SPI is not set
# CONFIG_AD9739A is not set
# CONFIG_LTC2688 is not set
# CONFIG_AD5686_SPI is not set
# CONFIG_AD5696_I2C is not set
# CONFIG_AD5755 is not set
# CONFIG_AD5758 is not set
# CONFIG_AD5761 is not set
# CONFIG_AD5764 is not set
# CONFIG_AD5766 is not set
# CONFIG_AD5770R is not set
# CONFIG_AD5791 is not set
# CONFIG_AD7293 is not set
# CONFIG_AD7303 is not set
# CONFIG_AD8460 is not set
# CONFIG_AD8801 is not set
# CONFIG_DPOT_DAC is not set
# CONFIG_DS4424 is not set
# CONFIG_LTC1660 is not set
# CONFIG_LTC2632 is not set
# CONFIG_LTC2664 is not set
# CONFIG_M62332 is not set
# CONFIG_MAX517 is not set
# CONFIG_MAX5522 is not set
# CONFIG_MAX5821 is not set
# CONFIG_MCP4725 is not set
# CONFIG_MCP4728 is not set
# CONFIG_MCP4821 is not set
# CONFIG_MCP4922 is not set
# CONFIG_TI_DAC082S085 is not set
# CONFIG_TI_DAC5571 is not set
# CONFIG_TI_DAC7311 is not set
# CONFIG_TI_DAC7612 is not set
# CONFIG_VF610_DAC is not set
# end of Digital to analog converters

#
# IIO dummy driver
#
# end of IIO dummy driver

#
# Filters
#
# CONFIG_ADMV8818 is not set
# end of Filters

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# CONFIG_AD9523 is not set
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# CONFIG_ADF4350 is not set
# CONFIG_ADF4371 is not set
# CONFIG_ADF4377 is not set
# CONFIG_ADMFM2000 is not set
# CONFIG_ADMV1013 is not set
# CONFIG_ADMV1014 is not set
# CONFIG_ADMV4420 is not set
# CONFIG_ADRF6780 is not set
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
# CONFIG_ADIS16080 is not set
# CONFIG_ADIS16130 is not set
# CONFIG_ADIS16136 is not set
# CONFIG_ADIS16260 is not set
# CONFIG_ADXRS290 is not set
# CONFIG_ADXRS450 is not set
# CONFIG_BMG160 is not set
# CONFIG_FXAS21002C is not set
CONFIG_HID_SENSOR_GYRO_3D=m
# CONFIG_MPU3050_I2C is not set
# CONFIG_IIO_ST_GYRO_3AXIS is not set
# CONFIG_ITG3200 is not set
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4403 is not set
# CONFIG_AFE4404 is not set
# CONFIG_MAX30100 is not set
# CONFIG_MAX30102 is not set
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
# CONFIG_DHT11 is not set
# CONFIG_ENS210 is not set
# CONFIG_HDC100X is not set
# CONFIG_HDC2010 is not set
# CONFIG_HDC3020 is not set
CONFIG_HID_SENSOR_HUMIDITY=m
# CONFIG_HTS221 is not set
# CONFIG_HTU21 is not set
# CONFIG_SI7005 is not set
# CONFIG_SI7020 is not set
# end of Humidity sensors

#
# Inertial measurement units
#
# CONFIG_ADIS16400 is not set
# CONFIG_ADIS16460 is not set
# CONFIG_ADIS16475 is not set
# CONFIG_ADIS16480 is not set
# CONFIG_BMI160_I2C is not set
# CONFIG_BMI160_SPI is not set
# CONFIG_BMI270_I2C is not set
# CONFIG_BMI270_SPI is not set
# CONFIG_BMI323_I2C is not set
# CONFIG_BMI323_SPI is not set
# CONFIG_BOSCH_BNO055_I2C is not set
# CONFIG_FXOS8700_I2C is not set
# CONFIG_FXOS8700_SPI is not set
# CONFIG_KMX61 is not set
# CONFIG_INV_ICM42600_I2C is not set
# CONFIG_INV_ICM42600_SPI is not set
# CONFIG_INV_MPU6050_I2C is not set
# CONFIG_INV_MPU6050_SPI is not set
# CONFIG_SMI240 is not set
# CONFIG_IIO_ST_LSM6DSX is not set
# CONFIG_IIO_ST_LSM9DS0 is not set
# end of Inertial measurement units

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
# CONFIG_ADJD_S311 is not set
# CONFIG_ADUX1020 is not set
# CONFIG_AL3010 is not set
# CONFIG_AL3320A is not set
# CONFIG_APDS9300 is not set
# CONFIG_APDS9306 is not set
# CONFIG_APDS9960 is not set
# CONFIG_AS73211 is not set
# CONFIG_BH1745 is not set
# CONFIG_BH1750 is not set
# CONFIG_BH1780 is not set
# CONFIG_CM32181 is not set
# CONFIG_CM3232 is not set
# CONFIG_CM3323 is not set
# CONFIG_CM3605 is not set
# CONFIG_CM36651 is not set
# CONFIG_GP2AP002 is not set
# CONFIG_GP2AP020A00F is not set
# CONFIG_SENSORS_ISL29018 is not set
# CONFIG_SENSORS_ISL29028 is not set
# CONFIG_ISL29125 is not set
# CONFIG_ISL76682 is not set
CONFIG_HID_SENSOR_ALS=m
CONFIG_HID_SENSOR_PROX=m
# CONFIG_JSA1212 is not set
# CONFIG_ROHM_BU27008 is not set
# CONFIG_ROHM_BU27034 is not set
# CONFIG_RPR0521 is not set
# CONFIG_LTR390 is not set
# CONFIG_LTR501 is not set
# CONFIG_LTRF216A is not set
# CONFIG_LV0104CS is not set
# CONFIG_MAX44000 is not set
# CONFIG_MAX44009 is not set
# CONFIG_NOA1305 is not set
# CONFIG_OPT3001 is not set
# CONFIG_OPT4001 is not set
# CONFIG_PA12203001 is not set
# CONFIG_SI1133 is not set
# CONFIG_SI1145 is not set
# CONFIG_STK3310 is not set
# CONFIG_ST_UVIS25 is not set
# CONFIG_TCS3414 is not set
# CONFIG_TCS3472 is not set
# CONFIG_SENSORS_TSL2563 is not set
# CONFIG_TSL2583 is not set
# CONFIG_TSL2591 is not set
# CONFIG_TSL2772 is not set
# CONFIG_TSL4531 is not set
# CONFIG_US5182D is not set
# CONFIG_VCNL4000 is not set
# CONFIG_VCNL4035 is not set
# CONFIG_VEML3235 is not set
# CONFIG_VEML6030 is not set
# CONFIG_VEML6040 is not set
# CONFIG_VEML6070 is not set
# CONFIG_VEML6075 is not set
# CONFIG_VL6180 is not set
# CONFIG_ZOPT2201 is not set
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AK8974 is not set
# CONFIG_AK8975 is not set
# CONFIG_AK09911 is not set
# CONFIG_ALS31300 is not set
# CONFIG_BMC150_MAGN_I2C is not set
# CONFIG_BMC150_MAGN_SPI is not set
# CONFIG_MAG3110 is not set
CONFIG_HID_SENSOR_MAGNETOMETER_3D=m
# CONFIG_MMC35240 is not set
# CONFIG_IIO_ST_MAGN_3AXIS is not set
# CONFIG_SENSORS_HMC5843_I2C is not set
# CONFIG_SENSORS_HMC5843_SPI is not set
# CONFIG_SENSORS_RM3100_I2C is not set
# CONFIG_SENSORS_RM3100_SPI is not set
# CONFIG_TI_TMAG5273 is not set
# CONFIG_YAMAHA_YAS530 is not set
# end of Magnetometer sensors

#
# Multiplexers
#
# CONFIG_IIO_MUX is not set
# end of Multiplexers

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=m
CONFIG_HID_SENSOR_DEVICE_ROTATION=m
# end of Inclinometer sensors

#
# Triggers - standalone
#
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
# CONFIG_IIO_SYSFS_TRIGGER is not set
# end of Triggers - standalone

#
# Linear and angular position sensors
#
# CONFIG_HID_SENSOR_CUSTOM_INTEL_HINGE is not set
# end of Linear and angular position sensors

#
# Digital potentiometers
#
# CONFIG_AD5110 is not set
# CONFIG_AD5272 is not set
# CONFIG_DS1803 is not set
# CONFIG_MAX5432 is not set
# CONFIG_MAX5481 is not set
# CONFIG_MAX5487 is not set
# CONFIG_MCP4018 is not set
# CONFIG_MCP4131 is not set
# CONFIG_MCP4531 is not set
# CONFIG_MCP41010 is not set
# CONFIG_TPL0102 is not set
# CONFIG_X9250 is not set
# end of Digital potentiometers

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set
# end of Digital potentiostats

#
# Pressure sensors
#
# CONFIG_ABP060MG is not set
# CONFIG_ROHM_BM1390 is not set
# CONFIG_BMP280 is not set
# CONFIG_DLHL60D is not set
# CONFIG_DPS310 is not set
CONFIG_HID_SENSOR_PRESS=m
# CONFIG_HP03 is not set
# CONFIG_HSC030PA is not set
# CONFIG_ICP10100 is not set
# CONFIG_MPL115_I2C is not set
# CONFIG_MPL115_SPI is not set
# CONFIG_MPL3115 is not set
# CONFIG_MPRLS0025PA is not set
# CONFIG_MS5611 is not set
# CONFIG_MS5637 is not set
# CONFIG_SDP500 is not set
# CONFIG_IIO_ST_PRESS is not set
# CONFIG_T5403 is not set
# CONFIG_HP206C is not set
# CONFIG_ZPA2326 is not set
# end of Pressure sensors

#
# Lightning sensors
#
# CONFIG_AS3935 is not set
# end of Lightning sensors

#
# Proximity and distance sensors
#
# CONFIG_HX9023S is not set
# CONFIG_IRSD200 is not set
# CONFIG_ISL29501 is not set
# CONFIG_LIDAR_LITE_V2 is not set
# CONFIG_MB1232 is not set
# CONFIG_PING is not set
# CONFIG_RFD77402 is not set
# CONFIG_SRF04 is not set
# CONFIG_SX9310 is not set
# CONFIG_SX9324 is not set
# CONFIG_SX9360 is not set
# CONFIG_SX9500 is not set
# CONFIG_SRF08 is not set
# CONFIG_VCNL3020 is not set
# CONFIG_VL53L0X_I2C is not set
# CONFIG_AW96103 is not set
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# CONFIG_AD2S90 is not set
# CONFIG_AD2S1200 is not set
# CONFIG_AD2S1210 is not set
# end of Resolver to digital converters

#
# Temperature sensors
#
# CONFIG_LTC2983 is not set
# CONFIG_MAXIM_THERMOCOUPLE is not set
CONFIG_HID_SENSOR_TEMP=m
# CONFIG_MLX90614 is not set
# CONFIG_MLX90632 is not set
# CONFIG_MLX90635 is not set
# CONFIG_TMP006 is not set
# CONFIG_TMP007 is not set
# CONFIG_TMP117 is not set
# CONFIG_TSYS01 is not set
# CONFIG_TSYS02D is not set
# CONFIG_MAX30208 is not set
# CONFIG_MAX31856 is not set
# CONFIG_MAX31865 is not set
# CONFIG_MCP9600 is not set
# end of Temperature sensors

CONFIG_NTB=m
CONFIG_NTB_MSI=y
CONFIG_NTB_AMD=m
# CONFIG_NTB_IDT is not set
CONFIG_NTB_INTEL=m
# CONFIG_NTB_EPF is not set
# CONFIG_NTB_SWITCHTEC is not set
CONFIG_NTB_PINGPONG=m
CONFIG_NTB_TOOL=m
CONFIG_NTB_PERF=m
CONFIG_NTB_MSI_TEST=m
CONFIG_NTB_TRANSPORT=m
CONFIG_PWM=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_CLK is not set
# CONFIG_PWM_DWC is not set
# CONFIG_PWM_GPIO is not set
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# CONFIG_LAN966X_OIC is not set
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_GPIO is not set
# CONFIG_RESET_SIMPLE is not set
# CONFIG_RESET_TI_SYSCON is not set
# CONFIG_RESET_TI_TPS380X is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_USB_LGM_PHY is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
# CONFIG_BCM_KONA_USB2_PHY is not set
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_CPCAP_USB is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
CONFIG_INTEL_RAPL_TPMI=m
CONFIG_IDLE_INJECT=y
# CONFIG_MCB is not set

#
# Performance monitor support
#
# CONFIG_DWC_PCIE_PMU is not set
# CONFIG_CXL_PMU is not set
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
CONFIG_AMD_ATL=m
CONFIG_AMD_ATL_PRM=y
CONFIG_RAS_FMPM=m
CONFIG_USB4=y
# CONFIG_USB4_DEBUGFS_WRITE is not set
# CONFIG_USB4_DMA_TEST is not set

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
# CONFIG_NVDIMM_SECURITY_TEST is not set
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_HMEM=m
CONFIG_DEV_DAX_CXL=m
CONFIG_DEV_DAX_HMEM_DEVICES=y
CONFIG_DEV_DAX_KMEM=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_LAYOUTS is not set
# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
CONFIG_STM=m
CONFIG_STM_PROTO_BASIC=m
CONFIG_STM_PROTO_SYS_T=m
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
CONFIG_TEE=m
# CONFIG_AMDTEE is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
CONFIG_COUNTER=m
CONFIG_INTEL_QEP=m
# CONFIG_INTERRUPT_CNT is not set
# CONFIG_MOST is not set
# CONFIG_PECI is not set
# CONFIG_HTE is not set
CONFIG_DPLL=y
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
CONFIG_FS_STACK=y
CONFIG_BUFFER_HEAD=y
CONFIG_LEGACY_DIRECT_IO=y
CONFIG_EXT2_FS=m
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_SUPPORT_ASCII_CI=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
# CONFIG_XFS_RT is not set
CONFIG_XFS_DRAIN_INTENTS=y
CONFIG_XFS_LIVE_HOOKS=y
CONFIG_XFS_MEMORY_BUFS=y
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_SCRUB_STATS=y
# CONFIG_XFS_ONLINE_REPAIR is not set
# CONFIG_XFS_WARN is not set
# CONFIG_XFS_DEBUG is not set
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
# CONFIG_BTRFS_FS_POSIX_ACL is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_EXPERIMENTAL is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_F2FS_IOSTAT=y
# CONFIG_F2FS_UNFAIR_RWSEM is not set
# CONFIG_BCACHEFS_FS is not set
# CONFIG_ZONEFS_FS is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FS_VERITY=y
# CONFIG_FS_VERITY_BUILTIN_SIGNATURES is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=y
CONFIG_CUSE=m
CONFIG_VIRTIO_FS=y
CONFIG_FUSE_DAX=y
CONFIG_FUSE_PASSTHROUGH=y
CONFIG_OVERLAY_FS=m
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
CONFIG_OVERLAY_FS_INDEX=y
CONFIG_OVERLAY_FS_XINO_AUTO=y
CONFIG_OVERLAY_FS_METACOPY=y
# CONFIG_OVERLAY_FS_DEBUG is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=y
CONFIG_NETFS_STATS=y
# CONFIG_NETFS_DEBUG is not set
CONFIG_FSCACHE=y
CONFIG_FSCACHE_STATS=y
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_ERROR_INJECTION is not set
# CONFIG_CACHEFILES_ONDEMAND is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
CONFIG_EXFAT_FS=m
CONFIG_EXFAT_DEFAULT_IOCHARSET="utf8"
# CONFIG_NTFS3_FS is not set
# CONFIG_NTFS_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
CONFIG_TMPFS_INODE64=y
# CONFIG_TMPFS_QUOTA is not set
CONFIG_HUGETLBFS=y
# CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON is not set
CONFIG_HUGETLB_PAGE=y
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_UBIFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
# CONFIG_CRAMFS_MTD is not set
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT is not set
CONFIG_SQUASHFS_COMPILE_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
CONFIG_SQUASHFS_ZSTD=y
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_COMPRESS=y
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
CONFIG_EROFS_FS=m
# CONFIG_EROFS_FS_DEBUG is not set
CONFIG_EROFS_FS_XATTR=y
CONFIG_EROFS_FS_POSIX_ACL=y
CONFIG_EROFS_FS_SECURITY=y
CONFIG_EROFS_FS_BACKED_BY_FILE=y
# CONFIG_EROFS_FS_ZIP is not set
# CONFIG_EROFS_FS_ONDEMAND is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
CONFIG_NFS_FSCACHE=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFS_V4_2_READ_PLUS is not set
CONFIG_NFSD=m
# CONFIG_NFSD_V2 is not set
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
CONFIG_NFSD_V4_2_INTER_SSC=y
CONFIG_NFSD_V4_SECURITY_LABEL=y
# CONFIG_NFSD_LEGACY_CLIENT_TRACKING is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
# CONFIG_NFS_LOCALIO is not set
CONFIG_NFS_V4_2_SSC_HELPER=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1=y
CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_CAMELLIA=y
CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2=y
CONFIG_SUNRPC_DEBUG=y
CONFIG_SUNRPC_XPRT_RDMA=m
CONFIG_CEPH_FS=m
CONFIG_CEPH_FSCACHE=y
CONFIG_CEPH_FS_POSIX_ACL=y
CONFIG_CEPH_FS_SECURITY_LABEL=y
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SWN_UPCALL is not set
CONFIG_CIFS_SMB_DIRECT=y
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CIFS_COMPRESSION is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS=m
# CONFIG_CODA_FS is not set
CONFIG_AFS_FS=m
CONFIG_AFS_DEBUG=y
CONFIG_AFS_FSCACHE=y
# CONFIG_AFS_DEBUG_CURSOR is not set
CONFIG_9P_FS=y
# CONFIG_9P_FSCACHE is not set
CONFIG_9P_FS_POSIX_ACL=y
CONFIG_9P_FS_SECURITY=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_NLS_UCS2_UTILS=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_BIG_KEYS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_HAVE_TRUSTED_KEYS=y
CONFIG_TRUSTED_KEYS_TPM=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
CONFIG_KEY_DH_OPERATIONS=y
CONFIG_KEY_NOTIFICATIONS=y
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_PROC_MEM_ALWAYS_FORCE=y
# CONFIG_PROC_MEM_FORCE_PTRACE is not set
# CONFIG_PROC_MEM_NO_FORCE is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_INFINIBAND=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=9
CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=256
# CONFIG_SECURITY_SELINUX_DEBUG is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
CONFIG_SECURITY_LOCKDOWN_LSM=y
CONFIG_SECURITY_LOCKDOWN_LSM_EARLY=y
CONFIG_LOCK_DOWN_KERNEL_FORCE_NONE=y
# CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY is not set
# CONFIG_LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY is not set
# CONFIG_SECURITY_LANDLOCK is not set
# CONFIG_SECURITY_IPE is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
CONFIG_INTEGRITY_PLATFORM_KEYRING=y
CONFIG_INTEGRITY_MACHINE_KEYRING=y
CONFIG_INTEGRITY_CA_MACHINE_KEYRING=y
CONFIG_INTEGRITY_CA_MACHINE_KEYRING_MAX=y
CONFIG_LOAD_UEFI_KEYS=y
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
# CONFIG_IMA_KEXEC is not set
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
# CONFIG_IMA_NG_TEMPLATE is not set
CONFIG_IMA_SIG_TEMPLATE=y
CONFIG_IMA_DEFAULT_TEMPLATE="ima-sig"
# CONFIG_IMA_DEFAULT_HASH_SHA1 is not set
CONFIG_IMA_DEFAULT_HASH_SHA256=y
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
CONFIG_IMA_DEFAULT_HASH="sha256"
CONFIG_IMA_WRITE_POLICY=y
CONFIG_IMA_READ_POLICY=y
CONFIG_IMA_APPRAISE=y
CONFIG_IMA_ARCH_POLICY=y
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
CONFIG_IMA_APPRAISE_MODSIG=y
CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=y
# CONFIG_IMA_DISABLE_HTABLE is not set
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
# CONFIG_DEFAULT_SECURITY_SELINUX is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="lockdown,yama,integrity,selinux,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO_BARE=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
CONFIG_INIT_STACK_NONE=y
# CONFIG_INIT_STACK_ALL_PATTERN is not set
# CONFIG_INIT_STACK_ALL_ZERO is not set
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

#
# Hardening of kernel data structures
#
CONFIG_LIST_HARDENED=y
CONFIG_BUG_ON_DATA_CORRUPTION=y
# end of Hardening of kernel data structures

CONFIG_RANDSTRUCT_NONE=y
# CONFIG_RANDSTRUCT_FULL is not set
# CONFIG_RANDSTRUCT_PERFORMANCE is not set
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SIG=y
CONFIG_CRYPTO_SIG2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=y
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_ENGINE=m
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_DH_RFC7919_GROUPS=y
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_ECDSA=y
# CONFIG_CRYPTO_ECRDSA is not set
CONFIG_CRYPTO_CURVE25519=m
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_ARIA=y
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_SM4_GENERIC=y
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
CONFIG_CRYPTO_ADIANTUM=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_HCTR2 is not set
# CONFIG_CRYPTO_KEYWRAP is not set
CONFIG_CRYPTO_LRW=m
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_NHPOLY1305=m
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
# CONFIG_CRYPTO_AEGIS128 is not set
CONFIG_CRYPTO_CHACHA20POLY1305=m
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_GENIV=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m
CONFIG_CRYPTO_ESSIV=m
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
CONFIG_CRYPTO_BLAKE2B=m
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
# CONFIG_CRYPTO_SM3_GENERIC is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_VMAC=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_XXHASH=m
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=y
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
CONFIG_CRYPTO_ZSTD=m
# end of Compression

#
# Random number generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_JITTERENTROPY_MEMORY_BLOCKS=64
CONFIG_CRYPTO_JITTERENTROPY_MEMORY_BLOCKSIZE=32
CONFIG_CRYPTO_JITTERENTROPY_OSR=1
CONFIG_CRYPTO_KDF800108_CTR=y
# end of Random number generation

#
# Userspace interface
#
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
# CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE is not set
# end of Userspace interface

CONFIG_CRYPTO_HASH_INFO=y

#
# Accelerated Cryptographic Algorithms for CPU (x86)
#
CONFIG_CRYPTO_CURVE25519_X86=m
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES3_EDE_X86_64=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m
# CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_ARIA_AESNI_AVX2_X86_64 is not set
# CONFIG_CRYPTO_ARIA_GFNI_AVX512_X86_64 is not set
CONFIG_CRYPTO_CHACHA20_X86_64=y
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_NHPOLY1305_SSE2=m
CONFIG_CRYPTO_NHPOLY1305_AVX2=m
CONFIG_CRYPTO_BLAKE2S_X86=y
# CONFIG_CRYPTO_POLYVAL_CLMUL_NI is not set
CONFIG_CRYPTO_POLY1305_X86_64=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=y
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
# end of Accelerated Cryptographic Algorithms for CPU (x86)

CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=m
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_SP_PSP=y
# CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
CONFIG_CRYPTO_DEV_NITROX=m
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=m
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
CONFIG_CRYPTO_DEV_QAT_4XXX=m
# CONFIG_CRYPTO_DEV_QAT_420XX is not set
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
# CONFIG_CRYPTO_DEV_QAT_ERROR_INJECTION is not set
CONFIG_CRYPTO_DEV_IAA_CRYPTO=m
# CONFIG_CRYPTO_DEV_IAA_CRYPTO_STATS is not set
CONFIG_CRYPTO_DEV_CHELSIO=m
CONFIG_CRYPTO_DEV_VIRTIO=m
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS8_PRIVATE_KEY_PARSER=m
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y
CONFIG_FIPS_SIGNATURE_SELFTEST=y
CONFIG_FIPS_SIGNATURE_SELFTEST_RSA=y
CONFIG_FIPS_SIGNATURE_SELFTEST_ECDSA=y

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_MODULE_SIG_KEY_TYPE_RSA=y
# CONFIG_MODULE_SIG_KEY_TYPE_ECDSA is not set
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
CONFIG_SECONDARY_TRUSTED_KEYRING=y
# CONFIG_SECONDARY_TRUSTED_KEYRING_SIGNED_BY_BUILTIN is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# CONFIG_SYSTEM_REVOCATION_LIST is not set
# CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
# CONFIG_RAID6_PQ_BENCHMARK is not set
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=m
CONFIG_PRIME_NUMBERS=m
CONFIG_RATIONAL=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_UTILS=y
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_AESCFB=y
CONFIG_CRYPTO_LIB_AESGCM=m
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_LIB_GF128MUL=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_BLAKE2S=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CURVE25519=m
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=m
CONFIG_CRYPTO_LIB_CURVE25519=m
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=m
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_ARM64=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_RISCV=y
# CONFIG_XZ_DEC_MICROLZMA is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_BTREE=y
CONFIG_INTERVAL_TREE=y
CONFIG_INTERVAL_TREE_SPAN_ITER=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS_HELPERS=y
CONFIG_NEED_SG_DMA_FLAGS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
# CONFIG_SWIOTLB_DYNAMIC is not set
CONFIG_DMA_NEED_SYNC=y
CONFIG_DMA_COHERENT_POOL=y
CONFIG_DMA_CMA=y
# CONFIG_DMA_NUMA_CMA is not set

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_IOMMU_HELPER=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_DIMLIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT=y
CONFIG_VDSO_GETRANDOM=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
# CONFIG_FONT_6x11 is not set
# CONFIG_FONT_7x14 is not set
# CONFIG_FONT_PEARL_8x8 is not set
# CONFIG_FONT_ACORN_8x8 is not set
CONFIG_FONT_MINI_4x6=y
# CONFIG_FONT_6x10 is not set
# CONFIG_FONT_10x18 is not set
# CONFIG_FONT_SUN8x16 is not set
# CONFIG_FONT_SUN12x22 is not set
# CONFIG_FONT_TER16x32 is not set
# CONFIG_FONT_6x8 is not set
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACKDEPOT_ALWAYS_INIT=y
CONFIG_STACKDEPOT_MAX_FRAMES=64
CONFIG_SBITMAP=y
CONFIG_PARMAN=m
CONFIG_OBJAGG=m
# CONFIG_LWQ_TEST is not set
# end of Library routines

CONFIG_PLDMFW=y
CONFIG_ASN1_ENCODER=y
CONFIG_POLYNOMIAL=m
CONFIG_FIRMWARE_TABLE=y
CONFIG_UNION_FIND=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
# CONFIG_STACKTRACE_BUILD_ID is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_AS_HAS_NON_CONST_ULEB128=y
# CONFIG_DEBUG_INFO_NONE is not set
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
# CONFIG_DEBUG_INFO_REDUCED is not set
CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
# CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_DEBUG_INFO_BTF=y
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_PAHOLE_HAS_LANG_EXCLUDE=y
CONFIG_DEBUG_INFO_BTF_MODULES=y
# CONFIG_MODULE_ALLOW_BTF_MISMATCH is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
CONFIG_HEADERS_INSTALL=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B is not set
CONFIG_OBJTOOL=y
# CONFIG_VMLINUX_MAP is not set
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN=y
# CONFIG_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# CONFIG_DEBUG_NET is not set
# CONFIG_DEBUG_NET_SMALL_RTNL is not set
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_DEBUG_ON is not set
CONFIG_SLUB_RCU_DEBUG=y
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_TABLE_CHECK is not set
CONFIG_PAGE_POISONING=y
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
CONFIG_DEBUG_WX=y
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
# CONFIG_PTDUMP_DEBUGFS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_PER_VMA_LOCK_STATS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SHRINKER_DEBUG is not set
# CONFIG_DEBUG_STACK_USAGE is not set
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
# CONFIG_MEM_ALLOC_PROFILING is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
CONFIG_KASAN_OUTLINE=y
# CONFIG_KASAN_INLINE is not set
CONFIG_KASAN_STACK=y
# CONFIG_KASAN_VMALLOC is not set
# CONFIG_KASAN_EXTRA_INFO is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
CONFIG_HAVE_ARCH_KMSAN=y
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_SOFTLOCKUP_DETECTOR_INTR_STORM is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_BUDDY=y
CONFIG_HARDLOCKUP_DETECTOR=y
# CONFIG_HARDLOCKUP_DETECTOR_PREFER_BUDDY is not set
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
# CONFIG_HARDLOCKUP_DETECTOR_BUDDY is not set
# CONFIG_HARDLOCKUP_DETECTOR_ARCH is not set
CONFIG_HARDLOCKUP_DETECTOR_COUNTS_HRTIMER=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_WQ_WATCHDOG=y
# CONFIG_WQ_CPU_INTENSIVE_REPORT is not set
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_PREEMPT is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
CONFIG_PROVE_RAW_LOCK_NESTING=y
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
# CONFIG_NMI_CHECK_CPU is not set
# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_MAPLE_TREE is not set
# end of Debug kernel data structures

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_TORTURE_TEST=m
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_REF_SCALE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=60
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_CPU_STALL_CPUTIME is not set
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
# CONFIG_LATENCYTOP is not set
# CONFIG_DEBUG_CGROUP_REF is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_RETVAL=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_OBJTOOL_NOP_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_BOOTTIME_TRACING=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_FUNCTION_GRAPH_RETVAL=y
# CONFIG_FUNCTION_GRAPH_RETADDR is not set
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_FPROBE=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
CONFIG_IRQSOFF_TRACER=y
# CONFIG_PREEMPT_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
CONFIG_OSNOISE_TRACER=y
CONFIG_TIMERLAT_TRACER=y
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_FPROBE_EVENTS=y
CONFIG_PROBE_EVENTS_BTF_ARGS=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_BPF_KPROBE_OVERRIDE=y
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
# CONFIG_USER_EVENTS is not set
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_FTRACE_SORT_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
CONFIG_PREEMPTIRQ_DELAY_TEST=m
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
CONFIG_DA_MON_EVENTS=y
CONFIG_DA_MON_EVENTS_ID=y
CONFIG_RV=y
CONFIG_RV_MON_WWNR=y
CONFIG_RV_REACTORS=y
CONFIG_RV_REACT_PRINTK=y
CONFIG_RV_REACT_PANIC=y
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
CONFIG_SAMPLES=y
# CONFIG_SAMPLE_AUXDISPLAY is not set
# CONFIG_SAMPLE_TRACE_EVENTS is not set
# CONFIG_SAMPLE_TRACE_CUSTOM_EVENTS is not set
CONFIG_SAMPLE_TRACE_PRINTK=m
CONFIG_SAMPLE_FTRACE_DIRECT=m
# CONFIG_SAMPLE_FTRACE_DIRECT_MULTI is not set
# CONFIG_SAMPLE_FTRACE_OPS is not set
# CONFIG_SAMPLE_TRACE_ARRAY is not set
# CONFIG_SAMPLE_KOBJECT is not set
# CONFIG_SAMPLE_KPROBES is not set
# CONFIG_SAMPLE_HW_BREAKPOINT is not set
# CONFIG_SAMPLE_FPROBE is not set
# CONFIG_SAMPLE_KFIFO is not set
# CONFIG_SAMPLE_LIVEPATCH is not set
# CONFIG_SAMPLE_CONFIGFS is not set
# CONFIG_SAMPLE_CONNECTOR is not set
# CONFIG_SAMPLE_FANOTIFY_ERROR is not set
# CONFIG_SAMPLE_HIDRAW is not set
# CONFIG_SAMPLE_LANDLOCK is not set
# CONFIG_SAMPLE_PIDFD is not set
# CONFIG_SAMPLE_SECCOMP is not set
# CONFIG_SAMPLE_TIMER is not set
# CONFIG_SAMPLE_UHID is not set
CONFIG_SAMPLE_VFIO_MDEV_MTTY=m
# CONFIG_SAMPLE_VFIO_MDEV_MDPY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
# CONFIG_SAMPLE_VFIO_MDEV_MBOCHS is not set
# CONFIG_SAMPLE_ANDROID_BINDERFS is not set
# CONFIG_SAMPLE_VFS is not set
# CONFIG_SAMPLE_INTEL_MEI is not set
# CONFIG_SAMPLE_TPS6594_PFSM is not set
# CONFIG_SAMPLE_WATCHDOG is not set
# CONFIG_SAMPLE_WATCH_QUEUE is not set
# CONFIG_SAMPLE_CGROUP is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
# CONFIG_IOMMU_DEBUG is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAULT_INJECTION_USERCOPY is not set
# CONFIG_FAIL_MAKE_REQUEST is not set
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
CONFIG_FAIL_FUNCTION=y
# CONFIG_FAIL_MMC_REQUEST is not set
# CONFIG_FAIL_SUNRPC is not set
# CONFIG_FAIL_SKB_REALLOC is not set
# CONFIG_FAULT_INJECTION_CONFIGFS is not set
# CONFIG_FAULT_INJECTION_STACKTRACE_FILTER is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_TEST_DHRY is not set
# CONFIG_LKDTM is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_DIV64 is not set
# CONFIG_TEST_MULDIV64 is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_TEST_REF_TRACKER is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_SCANF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_MAPLE_TREE is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_PARMAN is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
CONFIG_TEST_VMALLOC=m
CONFIG_TEST_BPF=m
CONFIG_TEST_BLACKHOLE_DEV=m
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_DYNAMIC_DEBUG is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_KALLSYMS is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_OBJAGG is not set
# CONFIG_TEST_MEMINIT is not set
CONFIG_TEST_HMM=m
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
# CONFIG_TEST_OBJPOOL is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--cPUXwabp04B8QD1l
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='perf-event-tests'
	export testcase='perf-event-tests'
	export category='functional'
	export job_origin='perf-event-tests.yaml'
	export arch='x86_64'
	export initrds='linux_headers'
	export queue_cmdline_keys='branch
commit'
	export queue='bisect'
	export testbox='lkp-skl-d05'
	export tbox_group='lkp-skl-d05'
	export branch='linux-next/master'
	export commit='eca51ce01d4956ab4b8f06bb55c031f4913fffcb'
	export job_file='/lkp/jobs/queued/bisect/lkp-skl-d05/perf-event-tests-not_paranoid_at_all-debian-12-x86_64-20240206.cgz-eca51ce01d49-20241207-21354-b34j8-1.yaml'
	export id='b3ebf8d1df417274ccfd33ebd2b4bfc387b3ad80'
	export queuer_version='/zday/lkp'
	export model='Skylake'
	export nr_cpu=4
	export memory='32G'
	export nr_ssd_partitions=1
	export nr_hdd_partitions=4
	export hdd_partitions='/dev/disk/by-id/wwn-0x5000c50091e544de-part*'
	export ssd_partitions='/dev/disk/by-id/wwn-0x55cd2e4151977e28-part2'
	export rootfs_partition='/dev/disk/by-id/wwn-0x55cd2e4151977e28-part1'
	export brand='Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz'
	export need_kconfig_hw='{"PTP_1588_CLOCK"=>"y"}
{"E1000E"=>"y"}
SATA_AHCI
DRM_I915'
	export ucode='0xf0'
	export rootfs='debian-12-x86_64-20240206.cgz'
	export kconfig='x86_64-rhel-9.4-bpf'
	export enqueue_time='2024-12-07 16:30:01 +0800'
	export compiler='gcc-12'
	export _rt='/result/perf-event-tests/not_paranoid_at_all/lkp-skl-d05/debian-12-x86_64-20240206.cgz/x86_64-rhel-9.4-bpf/gcc-12/eca51ce01d4956ab4b8f06bb55c031f4913fffcb'
	export user='lkp'
	export LKP_SERVER='internal-lkp-server'
	export scheduler_version='/lkp/lkp/src'
	export max_uptime=1200
	export initrd='/osimage/debian/debian-12-x86_64-20240206.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/perf-event-tests/not_paranoid_at_all/lkp-skl-d05/debian-12-x86_64-20240206.cgz/x86_64-rhel-9.4-bpf/gcc-12/eca51ce01d4956ab4b8f06bb55c031f4913fffcb/0
BOOT_IMAGE=/pkg/linux/x86_64-rhel-9.4-bpf/gcc-12/eca51ce01d4956ab4b8f06bb55c031f4913fffcb/vmlinuz-6.13.0-rc1-00027-geca51ce01d49
branch=linux-next/master
job=/lkp/jobs/scheduled/lkp-skl-d05/perf-event-tests-not_paranoid_at_all-debian-12-x86_64-20240206.cgz-eca51ce01d49-20241207-21354-b34j8-1.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-9.4-bpf
commit=eca51ce01d4956ab4b8f06bb55c031f4913fffcb
intremap=posted_msi
max_uptime=1200
LKP_SERVER=internal-lkp-server
nokaslr
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-9.4-bpf/gcc-12/eca51ce01d4956ab4b8f06bb55c031f4913fffcb/modules.cgz'
	export linux_headers_initrd='/pkg/linux/x86_64-rhel-9.4-bpf/gcc-12/eca51ce01d4956ab4b8f06bb55c031f4913fffcb/linux-headers.cgz'
	export bm_initrd='/osimage/deps/debian-12-x86_64-20240206.cgz/lkp_20241102.cgz,/osimage/deps/debian-12-x86_64-20240206.cgz/rsync-rootfs_20241102.cgz,/osimage/deps/debian-12-x86_64-20240206.cgz/run-ipconfig_20241102.cgz,/osimage/deps/debian-12-x86_64-20240206.cgz/perf-event-tests_20241102.cgz,/osimage/pkg/debian-12-x86_64-20240206.cgz/perf-event-tests-x86_64-a052241-1_20241102.cgz,/osimage/deps/debian-12-x86_64-20240206.cgz/hw_20241102.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20230906.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export job_initrd='/lkp/jobs/scheduled/lkp-skl-d05/perf-event-tests-not_paranoid_at_all-debian-12-x86_64-20240206.cgz-eca51ce01d49-20241207-21354-b34j8-1.cgz'
	export last_kernel='6.12.0'
	export acpi_rsdp='0x000f05b0'
	export kernel='/pkg/linux/x86_64-rhel-9.4-bpf/gcc-12/eca51ce01d4956ab4b8f06bb55c031f4913fffcb/vmlinuz-6.13.0-rc1-00027-geca51ce01d49'
	export result_root='/result/perf-event-tests/not_paranoid_at_all/lkp-skl-d05/debian-12-x86_64-20240206.cgz/x86_64-rhel-9.4-bpf/gcc-12/eca51ce01d4956ab4b8f06bb55c031f4913fffcb/0'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_setup $LKP_SRC/setup/sanity-check

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test paranoid='not_paranoid_at_all' $LKP_SRC/tests/wrapper perf-event-tests
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env paranoid='not_paranoid_at_all' $LKP_SRC/stats/wrapper perf-event-tests
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time perf-event-tests.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--cPUXwabp04B8QD1l
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--cPUXwabp04B8QD1l
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="perf-event-tests"
Content-Transfer-Encoding: quoted-printable

Decompressing Linux... No EFI environment detected.
Parsing ELF... No relocation needed... done.
Booting the kernel (entry_offset: 0x0000000000000888).
Linux version 6.13.0-rc1-00027-geca51ce01d49 (kbuild@8637b1bd82a1) (gcc-12 =
(Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #1 SMP PR=
EEMPT_DYNAMIC Sat Dec  7 16:35:26 CST 2024
Command line: ip=3D::::lkp-skl-d05::dhcp root=3D/dev/ram0 RESULT_ROOT=3D/re=
sult/perf-event-tests/not_paranoid_at_all/lkp-skl-d05/debian-12-x86_64-2024=
0206.cgz/x86_64-rhel-9.4-bpf/gcc-12/eca51ce01d4956ab4b8f06bb55c031f4913fffc=
b/0 BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-9.4-bpf/gcc-12/eca51ce01d4956ab4b8f=
06bb55c031f4913fffcb/vmlinuz-6.13.0-rc1-00027-geca51ce01d49 branch=3Dlinux-=
next/master job=3D/lkp/jobs/scheduled/lkp-skl-d05/perf-event-tests-not_para=
noid_at_all-debian-12-x86_64-20240206.cgz-eca51ce01d49-20241207-21354-b34j8=
-1.yaml user=3Dlkp ARCH=3Dx86_64 kconfig=3Dx86_64-rhel-9.4-bpf commit=3Deca=
51ce01d4956ab4b8f06bb55c031f4913fffcb intremap=3Dposted_msi max_uptime=3D12=
00 LKP_SERVER=3Dinternal-lkp-server nokaslr selinux=3D0 debug apic=3Ddebug =
sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=3D100 net.ifnames=3D0 p=
rintk.devkmsg=3Don panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oop=
s=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8 systemd.=
log_level=3Derr ignore_loglevel console=3Dtty0 earlyprintk=3DttyS0,115200 c=
onsole=3DttyS0,115200 vga=3Dnor
BIOS-provided physical RAM map:
BIOS-e820: [mem 0x0000000000000400-0x00000000000903ff] usable
BIOS-e820: [mem 0x0000000000090400-0x000000000009ffff] reserved
BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
BIOS-e820: [mem 0x0000000000100000-0x00000000cb11ffff] usable
BIOS-e820: [mem 0x00000000cb120000-0x00000000cb120fff] ACPI NVS
BIOS-e820: [mem 0x00000000cb121000-0x00000000cb14afff] reserved
BIOS-e820: [mem 0x00000000cb14b000-0x00000000cb1a1fff] usable
BIOS-e820: [mem 0x00000000cb1a2000-0x00000000cb9a2fff] reserved
BIOS-e820: [mem 0x00000000cb9a3000-0x00000000db514fff] usable
BIOS-e820: [mem 0x00000000db515000-0x00000000db738fff] reserved
BIOS-e820: [mem 0x00000000db739000-0x00000000db772fff] ACPI data
BIOS-e820: [mem 0x00000000db773000-0x00000000dbf25fff] ACPI NVS
BIOS-e820: [mem 0x00000000dbf26000-0x00000000dc4fefff] reserved
BIOS-e820: [mem 0x00000000dc4ff000-0x00000000dc4fffff] usable
BIOS-e820: [mem 0x00000000dc500000-0x00000000dfffffff] reserved
BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
BIOS-e820: [mem 0x0000000100000000-0x000000081dffffff] usable
random: crng init done
printk: debug: ignoring loglevel setting.
printk: legacy bootconsole [earlyser0] enabled
NX (Execute Disable) protection: active
APIC: Static calls initialized
e820: update [mem 0x00100000-0x0010000f] usable =3D=3D> usable
extended physical RAM map:
reserve setup_data: [mem 0x0000000000000400-0x00000000000903ff] usable
reserve setup_data: [mem 0x0000000000090400-0x000000000009ffff] reserved
reserve setup_data: [mem 0x00000000000e0000-0x00000000000fffff] reserved
reserve setup_data: [mem 0x0000000000100000-0x000000000010000f] usable
reserve setup_data: [mem 0x0000000000100010-0x00000000cb11ffff] usable
reserve setup_data: [mem 0x00000000cb120000-0x00000000cb120fff] ACPI NVS
reserve setup_data: [mem 0x00000000cb121000-0x00000000cb14afff] reserved
reserve setup_data: [mem 0x00000000cb14b000-0x00000000cb1a1fff] usable
reserve setup_data: [mem 0x00000000cb1a2000-0x00000000cb9a2fff] reserved
reserve setup_data: [mem 0x00000000cb9a3000-0x00000000db514fff] usable
reserve setup_data: [mem 0x00000000db515000-0x00000000db738fff] reserved
reserve setup_data: [mem 0x00000000db739000-0x00000000db772fff] ACPI data
reserve setup_data: [mem 0x00000000db773000-0x00000000dbf25fff] ACPI NVS
reserve setup_data: [mem 0x00000000dbf26000-0x00000000dc4fefff] reserved
reserve setup_data: [mem 0x00000000dc4ff000-0x00000000dc4fffff] usable
reserve setup_data: [mem 0x00000000dc500000-0x00000000dfffffff] reserved
reserve setup_data: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
reserve setup_data: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
reserve setup_data: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
reserve setup_data: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
reserve setup_data: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
reserve setup_data: [mem 0x0000000100000000-0x000000081dffffff] usable
SMBIOS 3.0.0 present.
DMI: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.8.1 12/05/2017
DMI: Memory slots populated: 4/4
tsc: Detected 3200.000 MHz processor
tsc: Detected 3199.980 MHz TSC
e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> reserved
e820: remove [mem 0x000a0000-0x000fffff] usable
last_pfn =3D 0x81e000 max_arch_pfn =3D 0x400000000
MTRR map: 4 entries (3 fixed + 1 variable; max 23), built from 10 variable =
MTRRs
x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT =20
x2apic: enabled by BIOS, switching to x2apic ops
last_pfn =3D 0xdc500 max_arch_pfn =3D 0x400000000
Scan for SMP in [mem 0x00000000-0x000003ff]
Scan for SMP in [mem 0x0009fc00-0x0009ffff]
Scan for SMP in [mem 0x000f0000-0x000fffff]
found SMP MP-table at [mem 0x000fcdd0-0x000fcddf]
mpc: fcba0-fcd54
Using GB pages for direct mapping
RAMDISK: [mem 0x7ab39e000-0x815ffffff]
ACPI: Early table checksum verification disabled
ACPI: RSDP 0x00000000000F05B0 000024 (v02 DELL  )
ACPI: XSDT 0x00000000DB7450A0 0000C4 (v01 DELL   CBX3     01072009 AMI  000=
10013)
ACPI: FACP 0x00000000DB767A50 00010C (v05 DELL   CBX3     01072009 AMI  000=
10013)
ACPI: DSDT 0x00000000DB7451F8 022857 (v02 DELL   CBX3     01072009 INTL 201=
20913)
ACPI: FACS 0x00000000DBF25D80 000040
ACPI: APIC 0x00000000DB767B60 000084 (v03 DELL   CBX3     01072009 AMI  000=
10013)
ACPI: FPDT 0x00000000DB767BE8 000044 (v01 DELL   CBX3     01072009 AMI  000=
10013)
ACPI: MCFG 0x00000000DB767C30 00003C (v01 DELL   CBX3     01072009 MSFT 000=
00097)
ACPI: HPET 0x00000000DB767C70 000038 (v01 DELL   CBX3     01072009 AMI. 000=
5000B)
ACPI: WSMT 0x00000000DB767CA8 000028 (v01 DELL   CBX3     01072009 AMI  000=
10013)
ACPI: SSDT 0x00000000DB767CD0 00546C (v02 SaSsdt SaSsdt   00003000 INTL 201=
20913)
ACPI: UEFI 0x00000000DB76D140 000042 (v01                 00000000      000=
00000)
ACPI: LPIT 0x00000000DB76D188 000094 (v01 INTEL  SKL      00000000 MSFT 000=
0005F)
ACPI: SSDT 0x00000000DB76D220 000248 (v02 INTEL  sensrhub 00000000 INTL 201=
20913)
ACPI: SSDT 0x00000000DB76D468 002BAE (v02 INTEL  PtidDevc 00001000 INTL 201=
20913)
ACPI: SSDT 0x00000000DB770018 000BE3 (v02 INTEL  Ther_Rvp 00001000 INTL 201=
20913)
ACPI: SSDT 0x00000000DB770C00 0004A3 (v02 INTEL  zpodd    00001000 INTL 201=
20913)
ACPI: DBGP 0x00000000DB7710A8 000034 (v01 INTEL           00000000 MSFT 000=
0005F)
ACPI: DBG2 0x00000000DB7710E0 000054 (v00 INTEL           00000000 MSFT 000=
0005F)
ACPI: SSDT 0x00000000DB771138 000613 (v02 INTEL  DELL__MT 00000000 INTL 201=
20913)
ACPI: SSDT 0x00000000DB771750 000E73 (v02 CpuRef CpuSsdt  00003000 INTL 201=
20913)
ACPI: SLIC 0x00000000DB7725C8 000176 (v03 DELL   CBX3     01072009 MSFT 000=
10013)
ACPI: ASF! 0x00000000DB772740 0000A5 (v32 INTEL   HCG     00000001 TFSM 000=
F4240)
ACPI: DMAR 0x00000000DB7727E8 0000C8 (v01 INTEL  SKL      00000001 INTL 000=
00001)
ACPI: Reserving FACP table memory at [mem 0xdb767a50-0xdb767b5b]
ACPI: Reserving DSDT table memory at [mem 0xdb7451f8-0xdb767a4e]
ACPI: Reserving FACS table memory at [mem 0xdbf25d80-0xdbf25dbf]
ACPI: Reserving APIC table memory at [mem 0xdb767b60-0xdb767be3]
ACPI: Reserving FPDT table memory at [mem 0xdb767be8-0xdb767c2b]
ACPI: Reserving MCFG table memory at [mem 0xdb767c30-0xdb767c6b]
ACPI: Reserving HPET table memory at [mem 0xdb767c70-0xdb767ca7]
ACPI: Reserving WSMT table memory at [mem 0xdb767ca8-0xdb767ccf]
ACPI: Reserving SSDT table memory at [mem 0xdb767cd0-0xdb76d13b]
ACPI: Reserving UEFI table memory at [mem 0xdb76d140-0xdb76d181]
ACPI: Reserving LPIT table memory at [mem 0xdb76d188-0xdb76d21b]
ACPI: Reserving SSDT table memory at [mem 0xdb76d220-0xdb76d467]
ACPI: Reserving SSDT table memory at [mem 0xdb76d468-0xdb770015]
ACPI: Reserving SSDT table memory at [mem 0xdb770018-0xdb770bfa]
ACPI: Reserving SSDT table memory at [mem 0xdb770c00-0xdb7710a2]
ACPI: Reserving DBGP table memory at [mem 0xdb7710a8-0xdb7710db]
ACPI: Reserving DBG2 table memory at [mem 0xdb7710e0-0xdb771133]
ACPI: Reserving SSDT table memory at [mem 0xdb771138-0xdb77174a]
ACPI: Reserving SSDT table memory at [mem 0xdb771750-0xdb7725c2]
ACPI: Reserving SLIC table memory at [mem 0xdb7725c8-0xdb77273d]
ACPI: Reserving ASF! table memory at [mem 0xdb772740-0xdb7727e4]
ACPI: Reserving DMAR table memory at [mem 0xdb7727e8-0xdb7728af]
APIC: Switched APIC routing to: cluster x2apic
No NUMA configuration found
Faking a node at [mem 0x0000000000000000-0x000000081dffffff]
NODE_DATA(0) allocated [mem 0x81dfd4c00-0x81dffffff]
Zone ranges:
DMA      [mem 0x0000000000001000-0x0000000000ffffff]
DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
Normal   [mem 0x0000000100000000-0x000000081dffffff]
Device   empty
Movable zone start for each node
Early memory node ranges
node   0: [mem 0x0000000000001000-0x000000000008ffff]
node   0: [mem 0x0000000000100000-0x00000000cb11ffff]
node   0: [mem 0x00000000cb14b000-0x00000000cb1a1fff]
node   0: [mem 0x00000000cb9a3000-0x00000000db514fff]
node   0: [mem 0x00000000dc4ff000-0x00000000dc4fffff]
node   0: [mem 0x0000000100000000-0x000000081dffffff]
Initmem setup node 0 [mem 0x0000000000001000-0x000000081dffffff]
On node 0, zone DMA: 1 pages in unavailable ranges
On node 0, zone DMA: 112 pages in unavailable ranges
On node 0, zone DMA32: 43 pages in unavailable ranges
On node 0, zone DMA32: 2049 pages in unavailable ranges
On node 0, zone DMA32: 4074 pages in unavailable ranges
On node 0, zone Normal: 15104 pages in unavailable ranges
On node 0, zone Normal: 8192 pages in unavailable ranges
kasan: KernelAddressSanitizer initialized
Reserving Intel graphics memory at [mem 0xde000000-0xdfffffff]
ACPI: PM-Timer IO Port: 0x1808
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 2, APIC INT 02
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID 2, APIC INT 09
Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 2, APIC INT 01
Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 2, APIC INT 03
Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 2, APIC INT 04
Int: type 0, pol 0, trig 0, bus 00, IRQ 05, APIC ID 2, APIC INT 05
Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 2, APIC INT 06
Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 2, APIC INT 07
Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 2, APIC INT 08
Int: type 0, pol 0, trig 0, bus 00, IRQ 0a, APIC ID 2, APIC INT 0a
Int: type 0, pol 0, trig 0, bus 00, IRQ 0b, APIC ID 2, APIC INT 0b
Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 2, APIC INT 0c
Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 2, APIC INT 0d
Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 2, APIC INT 0e
Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 2, APIC INT 0f
ACPI: Using ACPI (MADT) for SMP configuration information
ACPI: HPET id: 0x8086a701 base: 0xfed00000
TSC deadline timer available
CPU topo: Max. logical packages:   1
CPU topo: Max. logical dies:       1
CPU topo: Max. dies per package:   1
CPU topo: Max. threads per core:   1
CPU topo: Num. cores per package:     4
CPU topo: Num. threads per package:   4
CPU topo: Allowing 4 present CPUs plus 0 hotplug CPUs
mapped IOAPIC to ffffffffff5fb000 (fec00000)
PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
PM: hibernation: Registered nosave memory: [mem 0x00090000-0x00090fff]
PM: hibernation: Registered nosave memory: [mem 0x00091000-0x0009ffff]
PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000dffff]
PM: hibernation: Registered nosave memory: [mem 0x000e0000-0x000fffff]
PM: hibernation: Registered nosave memory: [mem 0x00100000-0x00100fff]
PM: hibernation: Registered nosave memory: [mem 0xcb120000-0xcb120fff]
PM: hibernation: Registered nosave memory: [mem 0xcb121000-0xcb14afff]
PM: hibernation: Registered nosave memory: [mem 0xcb1a2000-0xcb9a2fff]
PM: hibernation: Registered nosave memory: [mem 0xdb515000-0xdb738fff]
PM: hibernation: Registered nosave memory: [mem 0xdb739000-0xdb772fff]
PM: hibernation: Registered nosave memory: [mem 0xdb773000-0xdbf25fff]
PM: hibernation: Registered nosave memory: [mem 0xdbf26000-0xdc4fefff]
PM: hibernation: Registered nosave memory: [mem 0xdc500000-0xdfffffff]
PM: hibernation: Registered nosave memory: [mem 0xe0000000-0xf7ffffff]
PM: hibernation: Registered nosave memory: [mem 0xf8000000-0xfbffffff]
PM: hibernation: Registered nosave memory: [mem 0xfc000000-0xfdffffff]
PM: hibernation: Registered nosave memory: [mem 0xfe000000-0xfe010fff]
PM: hibernation: Registered nosave memory: [mem 0xfe011000-0xfebfffff]
PM: hibernation: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
PM: hibernation: Registered nosave memory: [mem 0xfec01000-0xfedfffff]
PM: hibernation: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
PM: hibernation: Registered nosave memory: [mem 0xfee01000-0xfeffffff]
PM: hibernation: Registered nosave memory: [mem 0xff000000-0xffffffff]
[mem 0xe0000000-0xf7ffffff] available for PCI devices
Booting paravirtualized kernel on bare hardware
clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_=
idle_ns: 1910969940391419 ns
setup_percpu: NR_CPUS:8192 nr_cpumask_bits:4 nr_cpu_ids:4 nr_node_ids:1
percpu: Embedded 85 pages/cpu s311296 r8192 d28672 u524288
pcpu-alloc: s311296 r8192 d28672 u524288 alloc=3D1*2097152
pcpu-alloc: [0] 0 1 2 3=20
Kernel command line: ip=3D::::lkp-skl-d05::dhcp root=3D/dev/ram0 RESULT_ROO=
T=3D/result/perf-event-tests/not_paranoid_at_all/lkp-skl-d05/debian-12-x86_=
64-20240206.cgz/x86_64-rhel-9.4-bpf/gcc-12/eca51ce01d4956ab4b8f06bb55c031f4=
913fffcb/0 BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-9.4-bpf/gcc-12/eca51ce01d495=
6ab4b8f06bb55c031f4913fffcb/vmlinuz-6.13.0-rc1-00027-geca51ce01d49 branch=
=3Dlinux-next/master job=3D/lkp/jobs/scheduled/lkp-skl-d05/perf-event-tests=
-not_paranoid_at_all-debian-12-x86_64-20240206.cgz-eca51ce01d49-20241207-21=
354-b34j8-1.yaml user=3Dlkp ARCH=3Dx86_64 kconfig=3Dx86_64-rhel-9.4-bpf com=
mit=3Deca51ce01d4956ab4b8f06bb55c031f4913fffcb intremap=3Dposted_msi max_up=
time=3D1200 LKP_SERVER=3Dinternal-lkp-server nokaslr selinux=3D0 debug apic=
=3Ddebug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=3D100 net.ifna=
mes=3D0 printk.devkmsg=3Don panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3D=
panic oops=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8=
 systemd.log_level=3Derr ignore_loglevel console=3Dtty0 earlyprintk=3DttyS0=
,115200 console=3DttyS0,115200=20
sysrq: sysrq always enabled.
ignoring the deprecated load_ramdisk=3D option
Unknown kernel command line parameters "nokaslr RESULT_ROOT=3D/result/perf-=
event-tests/not_paranoid_at_all/lkp-skl-d05/debian-12-x86_64-20240206.cgz/x=
86_64-rhel-9.4-bpf/gcc-12/eca51ce01d4956ab4b8f06bb55c031f4913fffcb/0 BOOT_I=
MAGE=3D/pkg/linux/x86_64-rhel-9.4-bpf/gcc-12/eca51ce01d4956ab4b8f06bb55c031=
f4913fffcb/vmlinuz-6.13.0-rc1-00027-geca51ce01d49 branch=3Dlinux-next/maste=
r job=3D/lkp/jobs/scheduled/lkp-skl-d05/perf-event-tests-not_paranoid_at_al=
l-debian-12-x86_64-20240206.cgz-eca51ce01d49-20241207-21354-b34j8-1.yaml us=
er=3Dlkp ARCH=3Dx86_64 kconfig=3Dx86_64-rhel-9.4-bpf commit=3Deca51ce01d495=
6ab4b8f06bb55c031f4913fffcb max_uptime=3D1200 LKP_SERVER=3Dinternal-lkp-ser=
ver prompt_ramdisk=3D0 vga=3Dnormal", will be passed to user space.
printk: log buffer data + meta data: 2097152 + 7340032 =3D 9437184 bytes
Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear=
)
Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
Fallback order for Node 0: 0=20
Built 1 zonelists, mobility grouping on.  Total pages: 8359033
Policy zone: Normal
mem auto-init: stack:off, heap alloc:off, heap free:off
stackdepot: allocating hash table via alloc_large_system_hash
stackdepot hash table entries: 1048576 (order: 12, 16777216 bytes, linear)
software IO TLB: area num 4.
SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D4, Nodes=3D1
Kernel/User page tables isolation: enabled
Poking KASLR using RDRAND RDTSC...
ftrace: allocating 59580 entries in 233 pages
ftrace: allocated 233 pages with 5 groups
Dynamic Preempt: full
Running RCU self tests
Running RCU synchronous self tests
rcu: Preemptible hierarchical RCU implementation.
rcu: 	RCU lockdep checking is enabled.
rcu: 	RCU restricting CPUs from NR_CPUS=3D8192 to nr_cpu_ids=3D4.
	RCU CPU stall warnings timeout set to 100 (rcu_cpu_stall_timeout).
	Trampoline variant of Tasks RCU enabled.
	Rude variant of Tasks RCU enabled.
	Tracing variant of Tasks RCU enabled.
rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=3D4
Running RCU synchronous self tests
RCU Tasks: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=3D1 rcu_task_=
cpu_ids=3D4.
RCU Tasks Rude: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=3D1 rcu_=
task_cpu_ids=3D4.
RCU Tasks Trace: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=3D1 rcu=
_task_cpu_ids=3D4.
NR_IRQS: 524544, nr_irqs: 1024, preallocated irqs: 16
rcu: srcu_init: Setting srcu_struct sizes based on contention.
Console: colour VGA+ 80x25
printk: legacy console [tty0] enabled
printk: legacy console [ttyS0] enabled
printk: legacy console [ttyS0] enabled
printk: legacy bootconsole [earlyser0] disabled
printk: legacy bootconsole [earlyser0] disabled
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:  8
... MAX_LOCK_DEPTH:          48
... MAX_LOCKDEP_KEYS:        8192
... CLASSHASH_SIZE:          4096
... MAX_LOCKDEP_ENTRIES:     32768
... MAX_LOCKDEP_CHAINS:      65536
... CHAINHASH_SIZE:          32768
memory used by lock dependency info: 6429 kB
memory used for stack traces: 4224 kB
per task-struct memory footprint: 1920 bytes
ACPI: Core revision 20240827
clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79=
635855245 ns
APIC: Switch to symmetric I/O mode setup
DMAR: Host address width 39
DMAR: DRHD base: 0x000000fed90000 flags: 0x0
DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660462 ecap 7e3ff0=
505e
DMAR: DRHD base: 0x000000fed91000 flags: 0x1
DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c40660462 ecap f050da
DMAR: RMRR base: 0x000000db5db000 end: 0x000000db5fafff
DMAR: RMRR base: 0x000000dc024000 end: 0x000000dc26dfff
DMAR: RMRR base: 0x000000dd800000 end: 0x000000dfffffff
DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
DMAR-IR: HPET id 0 under DRHD base 0xfed91000
DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-rem=
apping.
DMAR-IR: IRQ remapping was enabled on dmar0 but we are not in kdump mode
DMAR-IR: Enabled IRQ remapping in x2apic mode
Masked ExtINT on CPU#0
ENABLING IO-APIC IRQs
Init IO_APIC IRQs
apic 2 pin 0 not connected
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dl=
vry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-1 -> IRQ 1 Level:0 ActiveLow:0)
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dl=
vry_Mode:0 Avail:0 Vector:30 Dest:00000001 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-2 -> IRQ 0 Level:0 ActiveLow:0)
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dl=
vry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-3 -> IRQ 3 Level:0 ActiveLow:0)
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dl=
vry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-4 -> IRQ 4 Level:0 ActiveLow:0)
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dl=
vry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-5 -> IRQ 5 Level:0 ActiveLow:0)
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dl=
vry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-6 -> IRQ 6 Level:0 ActiveLow:0)
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dl=
vry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-7 -> IRQ 7 Level:0 ActiveLow:0)
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dl=
vry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-8 -> IRQ 8 Level:0 ActiveLow:0)
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dl=
vry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-9 -> IRQ 9 Level:1 ActiveLow:0)
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dl=
vry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-10 -> IRQ 10 Level:0 ActiveLow:0)
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dl=
vry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-11 -> IRQ 11 Level:0 ActiveLow:0)
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dl=
vry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-12 -> IRQ 12 Level:0 ActiveLow:0)
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dl=
vry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-13 -> IRQ 13 Level:0 ActiveLow:0)
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dl=
vry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-14 -> IRQ 14 Level:0 ActiveLow:0)
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dl=
vry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-15 -> IRQ 15 Level:0 ActiveLow:0)
apic 2 pin 16 not connected
apic 2 pin 17 not connected
apic 2 pin 18 not connected
apic 2 pin 19 not connected
apic 2 pin 20 not connected
apic 2 pin 21 not connected
apic 2 pin 22 not connected
apic 2 pin 23 not connected
apic 2 pin 24 not connected
apic 2 pin 25 not connected
apic 2 pin 26 not connected
apic 2 pin 27 not connected
apic 2 pin 28 not connected
apic 2 pin 29 not connected
apic 2 pin 30 not connected
apic 2 pin 31 not connected
apic 2 pin 32 not connected
apic 2 pin 33 not connected
apic 2 pin 34 not connected
apic 2 pin 35 not connected
apic 2 pin 36 not connected
apic 2 pin 37 not connected
apic 2 pin 38 not connected
apic 2 pin 39 not connected
apic 2 pin 40 not connected
apic 2 pin 41 not connected
apic 2 pin 42 not connected
apic 2 pin 43 not connected
apic 2 pin 44 not connected
apic 2 pin 45 not connected
apic 2 pin 46 not connected
apic 2 pin 47 not connected
apic 2 pin 48 not connected
apic 2 pin 49 not connected
apic 2 pin 50 not connected
apic 2 pin 51 not connected
apic 2 pin 52 not connected
apic 2 pin 53 not connected
apic 2 pin 54 not connected
apic 2 pin 55 not connected
apic 2 pin 56 not connected
apic 2 pin 57 not connected
apic 2 pin 58 not connected
apic 2 pin 59 not connected
apic 2 pin 60 not connected
apic 2 pin 61 not connected
apic 2 pin 62 not connected
apic 2 pin 63 not connected
apic 2 pin 64 not connected
apic 2 pin 65 not connected
apic 2 pin 66 not connected
apic 2 pin 67 not connected
apic 2 pin 68 not connected
apic 2 pin 69 not connected
apic 2 pin 70 not connected
apic 2 pin 71 not connected
apic 2 pin 72 not connected
apic 2 pin 73 not connected
apic 2 pin 74 not connected
apic 2 pin 75 not connected
apic 2 pin 76 not connected
apic 2 pin 77 not connected
apic 2 pin 78 not connected
apic 2 pin 79 not connected
apic 2 pin 80 not connected
apic 2 pin 81 not connected
apic 2 pin 82 not connected
apic 2 pin 83 not connected
apic 2 pin 84 not connected
apic 2 pin 85 not connected
apic 2 pin 86 not connected
apic 2 pin 87 not connected
apic 2 pin 88 not connected
apic 2 pin 89 not connected
apic 2 pin 90 not connected
apic 2 pin 91 not connected
apic 2 pin 92 not connected
apic 2 pin 93 not connected
apic 2 pin 94 not connected
apic 2 pin 95 not connected
apic 2 pin 96 not connected
apic 2 pin 97 not connected
apic 2 pin 98 not connected
apic 2 pin 99 not connected
apic 2 pin 100 not connected
apic 2 pin 101 not connected
apic 2 pin 102 not connected
apic 2 pin 103 not connected
apic 2 pin 104 not connected
apic 2 pin 105 not connected
apic 2 pin 106 not connected
apic 2 pin 107 not connected
apic 2 pin 108 not connected
apic 2 pin 109 not connected
apic 2 pin 110 not connected
apic 2 pin 111 not connected
apic 2 pin 112 not connected
apic 2 pin 113 not connected
apic 2 pin 114 not connected
apic 2 pin 115 not connected
apic 2 pin 116 not connected
apic 2 pin 117 not connected
apic 2 pin 118 not connected
apic 2 pin 119 not connected
..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1
clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2e2036ff8d5,=
 max_idle_ns: 440795275316 ns
Calibrating delay loop (skipped), value calculated using timer frequency.. =
6399.96 BogoMIPS (lpj=3D3199980)
x86/cpu: SGX disabled or unsupported by BIOS.
CPU0: Thermal monitoring enabled (TM1)
Last level iTLB entries: 4KB 128, 2MB 8, 4MB 8
Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
process: using mwait in idle threads
Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer saniti=
zation
Spectre V2 : Mitigation: IBRS
Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context swi=
tch
Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
RETBleed: Mitigation: IBRS
Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Ba=
rrier
Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via=
 prctl
MDS: Mitigation: Clear CPU buffers
MMIO Stale Data: Mitigation: Clear CPU buffers
SRBDS: Mitigation: Microcode
GDS: Vulnerable: No microcode
x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
x86/fpu: Enabled xstate features 0x1f, context size is 960 bytes, using 'co=
mpacted' format.
Freeing SMP alternatives memory: 48K
pid_max: default: 32768 minimum: 301
LSM: initializing lsm=3Dlockdown,capability,yama,bpf,ima,evm
Yama: becoming mindful.
LSM support for eBPF active
Mount-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
Running RCU synchronous self tests
Running RCU synchronous self tests
smpboot: CPU0: Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (family: 0x6, model:=
 0x5e, stepping: 0x3)
Running RCU Tasks wait API self tests
Running RCU Tasks Rude wait API self tests
Running RCU Tasks Trace wait API self tests
Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width cou=
nters, Intel PMU driver.
... version:                4
... bit width:              48
... generic registers:      8
... value mask:             0000ffffffffffff
... max period:             00007fffffffffff
... fixed-purpose events:   3
Callback from call_rcu_tasks_trace() invoked.
... event mask:             00000007000000ff
signal: max sigframe size: 2032
Estimated ratio of average max frequency by base frequency (times 1024): 10=
56
rcu: Hierarchical SRCU implementation.
rcu: 	Max phase no-delay instances is 400.
Timer migration: 1 hierarchy levels; 8 children per group; 1 crossnode leve=
l
NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
smp: Bringing up secondary CPUs ...
smpboot: x86: Booting SMP configuration:
.... node  #0, CPUs:      #1 #2 #3
Masked ExtINT on CPU#1
Masked ExtINT on CPU#2
Masked ExtINT on CPU#3
smp: Brought up 1 node, 4 CPUs
smpboot: Total of 4 processors activated (25599.84 BogoMIPS)
node 0 deferred pages initialised in 180ms
Memory: 26713652K/33436132K available (30720K kernel code, 19538K rwdata, 2=
1964K rodata, 7688K init, 19088K bss, 6709656K reserved, 0K cma-reserved)
devtmpfs: initialized
x86/mm: Memory block size: 128MB
Callback from call_rcu_tasks() invoked.
ACPI: PM: Registering ACPI NVS region [mem 0xcb120000-0xcb120fff] (4096 byt=
es)
ACPI: PM: Registering ACPI NVS region [mem 0xdb773000-0xdbf25fff] (8073216 =
bytes)
Running RCU synchronous self tests
Running RCU synchronous self tests
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns:=
 1911260446275000 ns
futex hash table entries: 1024 (order: 5, 131072 bytes, linear)
pinctrl core: initialized pinctrl subsystem
NET: Registered PF_NETLINK/PF_ROUTE protocol family
DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic allocations
DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
audit: initializing netlink subsys (disabled)
audit: type=3D2000 audit(1733574722.775:1): state=3Dinitialized audit_enabl=
ed=3D0 res=3D1
thermal_sys: Registered thermal governor 'fair_share'
thermal_sys: Registered thermal governor 'step_wise'
thermal_sys: Registered thermal governor 'user_space'
cpuidle: using governor ladder
cpuidle: using governor menu
ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
PCI: ECAM [mem 0xf8000000-0xfbffffff] (base 0xf8000000) for domain 0000 [bu=
s 00-3f]
PCI: Using configuration type 1 for base access
kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if =
possible.
HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
cryptd: max_cpu_qlen set to 1000
ACPI: Added _OSI(Module Device)
ACPI: Added _OSI(Processor Device)
ACPI: Added _OSI(3.0 _SCP Extensions)
ACPI: Added _OSI(Processor Aggregator Device)
ACPI: 8 ACPI AML tables successfully acquired and loaded
ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0xFFFF8881018D2000 00037F (v02 PmRef  Cpu0Cst  00003001 INTL 201=
20913)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0xFFFF888102E28000 0006A2 (v02 PmRef  Cpu0Ist  00003000 INTL 201=
20913)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0xFFFF888102764900 00008E (v02 PmRef  Cpu0Hwp  00003000 INTL 201=
20913)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0xFFFF8881015C5C00 000130 (v02 PmRef  HwpLvt   00003000 INTL 201=
20913)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0xFFFF888102E38000 0005AA (v02 PmRef  ApIst    00003000 INTL 201=
20913)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0xFFFF8881015F4800 000119 (v02 PmRef  ApHwp    00003000 INTL 201=
20913)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0xFFFF8881015F6000 000119 (v02 PmRef  ApCst    00003000 INTL 201=
20913)
ACPI: Interpreter enabled
ACPI: PM: (supports S0 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
PCI: Using host bridge windows from ACPI; if necessary, use "pci=3Dnocrs" a=
nd report a bug
PCI: Using E820 reservations for host bridge windows
ACPI: Enabled 7 GPEs in block 00 to 7F
ACPI: \_SB_.PCI0.PEG0.PG00: New power resource
ACPI: \_SB_.PCI0.PEG1.PG01: New power resource
ACPI: \_SB_.PCI0.PEG2.PG02: New power resource
ACPI: \_SB_.PCI0.RP09.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP10.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP11.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP12.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP13.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP01.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP02.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP03.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP04.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP05.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP06.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP07.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP08.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP17.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP18.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP19.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP20.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP14.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP15.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP16.PXSX.WRST: New power resource
ACPI: \_TZ_.FN00: New power resource
ACPI: \_TZ_.FN01: New power resource
ACPI: \_TZ_.FN02: New power resource
ACPI: \_TZ_.FN03: New power resource
ACPI: \_TZ_.FN04: New power resource
ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MS=
I EDR HPX-Type3]
acpi PNP0A08:00: _OSC: OS requested [PCIeHotplug SHPCHotplug PME AER PCIeCa=
pability LTR DPC]
acpi PNP0A08:00: _OSC: platform willing to grant [PCIeHotplug SHPCHotplug P=
ME AER PCIeCapability LTR DPC]
acpi PNP0A08:00: _OSC: platform retains control of PCIe features (AE_ERROR)
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: root bus resource [mem 0xe0000000-0xf7ffffff window]
pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff window]
pci_bus 0000:00: root bus resource [bus 00-3e]
pci 0000:00:00.0: [8086:191f] type 00 class 0x060000 conventional PCI endpo=
int
pci 0000:00:01.0: [8086:1901] type 01 class 0x060400 PCIe Root Port
pci 0000:00:01.0: PCI bridge to [bus 01]
pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
pci 0000:00:02.0: [8086:1912] type 00 class 0x030000 PCIe Root Complex Inte=
grated Endpoint
pci 0000:00:02.0: BAR 0 [mem 0xf6000000-0xf6ffffff 64bit]
pci 0000:00:02.0: BAR 2 [mem 0xe0000000-0xefffffff 64bit pref]
pci 0000:00:02.0: BAR 4 [io  0xf000-0xf03f]
pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000df=
fff]
pci 0000:00:14.0: [8086:a12f] type 00 class 0x0c0330 conventional PCI endpo=
int
pci 0000:00:14.0: BAR 0 [mem 0xf7030000-0xf703ffff 64bit]
pci 0000:00:14.0: PME# supported from D3hot D3cold
pci 0000:00:14.2: [8086:a131] type 00 class 0x118000 conventional PCI endpo=
int
pci 0000:00:14.2: BAR 0 [mem 0xf704e000-0xf704efff 64bit]
pci 0000:00:16.0: [8086:a13a] type 00 class 0x078000 conventional PCI endpo=
int
pci 0000:00:16.0: BAR 0 [mem 0xf704d000-0xf704dfff 64bit]
pci 0000:00:16.0: PME# supported from D3hot
pci 0000:00:17.0: [8086:2822] type 00 class 0x010400 conventional PCI endpo=
int
pci 0000:00:17.0: BAR 0 [mem 0xf7048000-0xf7049fff]
pci 0000:00:17.0: BAR 1 [mem 0xf704c000-0xf704c0ff]
pci 0000:00:17.0: BAR 2 [io  0xf090-0xf097]
pci 0000:00:17.0: BAR 3 [io  0xf080-0xf083]
pci 0000:00:17.0: BAR 4 [io  0xf060-0xf07f]
pci 0000:00:17.0: BAR 5 [mem 0xf704b000-0xf704b7ff]
pci 0000:00:17.0: PME# supported from D3hot
pci 0000:00:1c.0: [8086:a110] type 01 class 0x060400 PCIe Root Port
pci 0000:00:1c.0: PCI bridge to [bus 02-03]
pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1f.0: [8086:a146] type 00 class 0x060100 conventional PCI endpo=
int
pci 0000:00:1f.2: [8086:a121] type 00 class 0x058000 conventional PCI endpo=
int
pci 0000:00:1f.2: BAR 0 [mem 0xf7044000-0xf7047fff]
pci 0000:00:1f.3: [8086:a170] type 00 class 0x040300 conventional PCI endpo=
int
pci 0000:00:1f.3: BAR 0 [mem 0xf7040000-0xf7043fff 64bit]
pci 0000:00:1f.3: BAR 4 [mem 0xf7020000-0xf702ffff 64bit]
pci 0000:00:1f.3: PME# supported from D3hot D3cold
pci 0000:00:1f.4: [8086:a123] type 00 class 0x0c0500 conventional PCI endpo=
int
pci 0000:00:1f.4: BAR 0 [mem 0xf704a000-0xf704a0ff 64bit]
pci 0000:00:1f.4: BAR 4 [io  0xf040-0xf05f]
pci 0000:00:1f.6: [8086:15b7] type 00 class 0x020000 conventional PCI endpo=
int
pci 0000:00:1f.6: BAR 0 [mem 0xf7000000-0xf701ffff]
pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
pci 0000:00:01.0: PCI bridge to [bus 01]
pci 0000:02:00.0: [104c:8240] type 01 class 0x060400 PCIe to PCI/PCI-X brid=
ge
pci 0000:02:00.0: PCI bridge to [bus 03]
pci 0000:02:00.0: supports D1 D2
pci 0000:00:1c.0: PCI bridge to [bus 02-03]
pci_bus 0000:03: extended config space not accessible
pci 0000:02:00.0: PCI bridge to [bus 03]
ACPI: PCI: Interrupt link LNKA configured for IRQ 7
ACPI: PCI: Interrupt link LNKA disabled
ACPI: PCI: Interrupt link LNKB configured for IRQ 10
ACPI: PCI: Interrupt link LNKB disabled
ACPI: PCI: Interrupt link LNKC configured for IRQ 5
ACPI: PCI: Interrupt link LNKC disabled
ACPI: PCI: Interrupt link LNKD configured for IRQ 11
ACPI: PCI: Interrupt link LNKD disabled
ACPI: PCI: Interrupt link LNKE configured for IRQ 7
ACPI: PCI: Interrupt link LNKE disabled
ACPI: PCI: Interrupt link LNKF configured for IRQ 3
ACPI: PCI: Interrupt link LNKF disabled
ACPI: PCI: Interrupt link LNKG configured for IRQ 4
ACPI: PCI: Interrupt link LNKG disabled
ACPI: PCI: Interrupt link LNKH configured for IRQ 11
ACPI: PCI: Interrupt link LNKH disabled
iommu: Default domain type: Translated
iommu: DMA domain TLB invalidation policy: lazy mode
SCSI subsystem initialized
ACPI: bus type USB registered
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giome=
tti@linux.it>
PTP clock support registered
EDAC MC: Ver: 3.0.0
NetLabel: Initializing
NetLabel:  domain hash size =3D 128
NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
NetLabel:  unlabeled traffic allowed by default
PCI: Using ACPI for IRQ routing
PCI: pci_cache_line_size set to 64 bytes
e820: reserve RAM buffer [mem 0x00090400-0x0009ffff]
e820: reserve RAM buffer [mem 0xcb120000-0xcbffffff]
e820: reserve RAM buffer [mem 0xcb1a2000-0xcbffffff]
e820: reserve RAM buffer [mem 0xdb515000-0xdbffffff]
e820: reserve RAM buffer [mem 0xdc500000-0xdfffffff]
e820: reserve RAM buffer [mem 0x81e000000-0x81fffffff]
pci 0000:00:02.0: vgaarb: setting as boot VGA device
pci 0000:00:02.0: vgaarb: bridge control possible
pci 0000:00:02.0: vgaarb: VGA device added: decodes=3Dio+mem,owns=3Dio+mem,=
locks=3Dnone
vgaarb: loaded
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
hpet0: 8 comparators, 64-bit 24.000000 MHz counter
clocksource: Switched to clocksource tsc-early
VFS: Disk quotas dquot_6.6.0
VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
netfs: FS-Cache loaded
pnp: PnP ACPI init
system 00:00: [io  0x0a00-0x0a3f] has been reserved
system 00:00: [io  0x0a40-0x0a7f] has been reserved
pnp 00:01: [dma 0 disabled]
system 00:02: [io  0x0680-0x069f] has been reserved
system 00:02: [io  0xffff] has been reserved
system 00:02: [io  0xffff] has been reserved
system 00:02: [io  0xffff] has been reserved
system 00:02: [io  0x1800-0x18fe] has been reserved
system 00:02: [io  0x164e-0x164f] has been reserved
system 00:03: [io  0x0800-0x087f] has been reserved
system 00:05: [io  0x1854-0x1857] has been reserved
system 00:06: [mem 0xfed10000-0xfed17fff] has been reserved
system 00:06: [mem 0xfed18000-0xfed18fff] has been reserved
system 00:06: [mem 0xfed19000-0xfed19fff] has been reserved
system 00:06: [mem 0xf8000000-0xfbffffff] has been reserved
system 00:06: [mem 0xfed20000-0xfed3ffff] has been reserved
system 00:06: [mem 0xfed90000-0xfed93fff] could not be reserved
system 00:06: [mem 0xfed45000-0xfed8ffff] has been reserved
system 00:06: [mem 0xff000000-0xffffffff] has been reserved
system 00:06: [mem 0xfee00000-0xfeefffff] could not be reserved
system 00:06: [mem 0xf7fe0000-0xf7ffffff] has been reserved
system 00:07: [mem 0xfd000000-0xfdabffff] has been reserved
system 00:07: [mem 0xfdad0000-0xfdadffff] has been reserved
system 00:07: [mem 0xfdb00000-0xfdffffff] has been reserved
system 00:07: [mem 0xfe000000-0xfe01ffff] could not be reserved
system 00:07: [mem 0xfe036000-0xfe03bfff] has been reserved
system 00:07: [mem 0xfe03d000-0xfe3fffff] has been reserved
system 00:07: [mem 0xfe410000-0xfe7fffff] has been reserved
system 00:08: [io  0xff00-0xfffe] has been reserved
system 00:09: [mem 0xfdaf0000-0xfdafffff] has been reserved
system 00:09: [mem 0xfdae0000-0xfdaeffff] has been reserved
system 00:09: [mem 0xfdac0000-0xfdacffff] has been reserved
pnp: PnP ACPI: found 10 devices
clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 208=
5701024 ns
NET: Registered PF_INET protocol family
IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
tcp_listen_portaddr_hash hash table entries: 16384 (order: 8, 1179648 bytes=
, linear)
Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
TCP established hash table entries: 262144 (order: 9, 2097152 bytes, linear=
)
TCP bind hash table entries: 65536 (order: 11, 9437184 bytes, vmalloc hugep=
age)
TCP: Hash tables configured (established 262144 bind 65536)
MPTCP token hash table entries: 32768 (order: 9, 2883584 bytes, linear)
UDP hash table entries: 16384 (order: 10, 4194304 bytes, linear)
UDP-Lite hash table entries: 16384 (order: 10, 4194304 bytes, linear)
NET: Registered PF_UNIX/PF_LOCAL protocol family
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp-with-tls transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
NET: Registered PF_XDP protocol family
pci 0000:00:01.0: PCI bridge to [bus 01]
pci 0000:02:00.0: PCI bridge to [bus 03]
pci 0000:00:1c.0: PCI bridge to [bus 02-03]
pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: resource 7 [mem 0xe0000000-0xf7ffffff window]
pci_bus 0000:00: resource 8 [mem 0xfd000000-0xfe7fffff window]
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dl=
vry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-16 -> IRQ 16 Level:1 ActiveLow:1)
pci 0000:00:14.0: quirk_usb_early_handoff+0x0/0x1d0 took 33260 usecs
PCI: CLS 0 bytes, default 64
pci 0000:00:1f.1: [8086:a120] type 00 class 0x058000 conventional PCI endpo=
int
pci 0000:00:1f.1: BAR 0 [mem 0xfd000000-0xfdffffff 64bit]
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
Trying to unpack rootfs image as initramfs...
software IO TLB: mapped [mem 0x00000000d7515000-0x00000000db515000] (64MB)
ACPI: bus type thunderbolt registered
AES CTR mode by8 optimization enabled
Initialise system trusted keyrings
Key type blacklist registered
workingset: timestamp_bits=3D36 max_order=3D23 bucket_order=3D0
zbud: loaded
fuse: init (API version 7.41)
9p: Installing v9fs 9p2000 file system support
integrity: Platform Keyring initialized
integrity: Machine keyring initialized
NET: Registered PF_ALG protocol family
Key type asymmetric registered
Asymmetric key parser 'x509' registered
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 245)
io scheduler mq-deadline registered
io scheduler kyber registered
io scheduler bfq registered
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dl=
vry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-16 -> IRQ 16 Level:1 ActiveLow:1)
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/in=
put0
ACPI: button: Sleep Button [SLPB]
input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/in=
put1
ACPI: button: Power Button [PWRB]
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
ACPI: button: Power Button [PWRF]
thermal LNXTHERM:00: registered as thermal_zone0
ACPI: thermal: Thermal Zone [TZ00] (28 C)
thermal LNXTHERM:01: registered as thermal_zone1
ACPI: thermal: Thermal Zone [TZ01] (30 C)
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
00:01: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200) is a 16550A
Non-volatile memory driver v1.3
loop: module loaded
rdac: device handler registered
hp_sw: device handler registered
emc: device handler registered
alua: device handler registered
e1000: Intel(R) PRO/1000 Network Driver
e1000: Copyright (c) 1999-2006 Intel Corporation.
e1000e: Intel(R) PRO/1000 Network Driver
e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dl=
vry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-19 -> IRQ 19 Level:1 ActiveLow:1)
e1000e 0000:00:1f.6: Interrupt Throttling Rate (ints/sec) set to dynamic co=
nservative mode
e1000e 0000:00:1f.6 0000:00:1f.6 (uninitialized): registered PHC clock
e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Width x1) 64:00:6a:30:91:48
e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network Connection
e1000e 0000:00:1f.6 eth0: MAC: 12, PHY: 12, PBA No: FFFFFF-0FF
igb: Intel(R) Gigabit Ethernet Network Driver
igb: Copyright (c) 2007-2014 Intel Corporation.
Intel(R) 2.5G Ethernet Linux Driver
Copyright(c) 2018 Intel Corporation.
ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver
ixgbe: Copyright (c) 1999-2016 Intel Corporation.
i40e: Intel(R) Ethernet Connection XL710 Network Driver
i40e: Copyright (c) 2013 - 2019 Intel Corporation.
usbcore: registered new device driver r8152-cfgselector
usbcore: registered new interface driver r8152
usbcore: registered new interface driver asix
usbcore: registered new interface driver ax88179_178a
xhci_hcd 0000:00:14.0: xHCI Host Controller
xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x000=
0000001109810
xhci_hcd 0000:00:14.0: xHCI Host Controller
xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
usb usb1: New USB device found, idVendor=3D1d6b, idProduct=3D0002, bcdDevic=
e=3D 6.13
usb usb1: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
usb usb1: Product: xHCI Host Controller
usb usb1: Manufacturer: Linux 6.13.0-rc1-00027-geca51ce01d49 xhci-hcd
usb usb1: SerialNumber: 0000:00:14.0
tsc: Refined TSC clocksource calibration: 3191.999 MHz
hub 1-0:1.0: USB hub found
clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2e02c398820, max_i=
dle_ns: 440795273435 ns
hub 1-0:1.0: 16 ports detected
clocksource: Switched to clocksource tsc
usb usb2: New USB device found, idVendor=3D1d6b, idProduct=3D0003, bcdDevic=
e=3D 6.13
usb usb2: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
usb usb2: Product: xHCI Host Controller
usb usb2: Manufacturer: Linux 6.13.0-rc1-00027-geca51ce01d49 xhci-hcd
usb usb2: SerialNumber: 0000:00:14.0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 10 ports detected
usbcore: registered new interface driver usbserial_generic
usbserial: USB Serial support registered for generic
i8042: PNP: No PS/2 controller found.
mousedev: PS/2 mouse device common for all mice
rtc_cmos 00:04: RTC can wake from S4
rtc_cmos 00:04: registered as rtc0
rtc_cmos 00:04: setting system clock to 2024-12-07T12:32:12 UTC (1733574732=
)
rtc_cmos 00:04: alarms up to one month, y3k, 242 bytes nvram
iTCO_vendor_support: vendor-support=3D0
intel_pstate: HWP enabled by BIOS
intel_pstate: Intel P-state driver initializing
intel_pstate: HWP enabled
hid: raw HID events driver (C) Jiri Kosina
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
drop_monitor: Initializing network drop monitor service
Initializing XFRM netlink socket
NET: Registered PF_INET6 protocol family
Freeing initrd memory: 1749384K
Segment Routing with IPv6
In-situ OAM (IOAM) with IPv6
NET: Registered PF_PACKET protocol family
9pnet: Installing 9P2000 support
NET: Registered PF_VSOCK protocol family
mpls_gso: MPLS GSO support
microcode: Current revision: 0x000000f0
IPI shorthand broadcast: enabled
... APIC ID:      00000000 (0)
... APIC VERSION: 01060015
0000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000001000

number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 120.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00770020
.......     : max redirection entries: 77
.......     : PRQ implemented: 0
.......     : IO APIC version: 20
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
IOAPIC 0:
pin00, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin01, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin02, enabled , edge , high, V(02), IRR(0), S(0), remapped, I(0001),  Z(0)
pin03, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin04, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin05, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin06, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin07, disabled, edge , high, V(01), IRR(0), S(0), remapped, I(0412),  Z(2)
pin08, enabled , edge , high, V(08), IRR(0), S(0), remapped, I(0007),  Z(0)
pin09, enabled , level, high, V(09), IRR(0), S(0), remapped, I(0008),  Z(0)
pin0a, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin0b, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin0c, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin0d, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin0e, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin0f, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin10, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin11, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin12, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin13, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin14, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin15, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin16, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin17, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin18, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin19, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin1a, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin1b, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin1c, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin1d, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin1e, disabled, edge , high, V(40), IRR(0), S(0), physic	al, D(1200), M(2)
pin1f, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin20, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin21, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin22, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin23, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin24, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin25, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin26, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin27, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin28, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin29, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin2a, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin2b, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin2c, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin2d, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin2e, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin2f, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin30, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin31, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin32, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin33, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin34, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin35, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin36, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin37, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin38, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin39, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin3a, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(4000), M(2)
pin3b, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin3c, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin3d, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin3e, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin3f, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin40, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin41, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin42, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin43, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin44, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin45, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin46, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin47, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin48, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin49, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin4a, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin4b, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin4c, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin4d, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin4e, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin4f, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin50, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin51, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin52, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin53, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin54, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin55, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin56, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin57, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin58, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin59, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin5a, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin5b, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin5c, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin5d, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin5e, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin5f, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin60, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin61, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin62, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin63, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin64, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin65, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin66, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin67, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin68, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin69, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin6a, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin6b, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin6c, disabled, edge , high, V(14), IRR(0), S(0), physic	al, D(1060), M(2)
pin6d, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin6e, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin6f, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin70, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin71, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin72, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin73, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin74, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin75, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin76, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
pin77, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(0)
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ19 -> 0:19
.................................... done.
sched_clock: Marking stable (125501010162, 1132075750)->(127044369487, -411=
283575)
registered taskstats version 1
Loading compiled-in X.509 certificates
Loaded X.509 cert 'Build time autogenerated kernel key: 7f19a3d4f59bb6116f9=
21afe8b8db098c758382d'
Demotion targets for Node 0: null
Key type big_key registered
Key type encrypted registered
ima: No TPM chip found, activating TPM-bypass!
Loading compiled-in module X.509 certificates
Loaded X.509 cert 'Build time autogenerated kernel key: 7f19a3d4f59bb6116f9=
21afe8b8db098c758382d'
ima: Allocated hash algorithm: sha256
ima: No architecture policies found
evm: Initialising EVM extended attributes:
evm: security.selinux
evm: security.SMACK64 (disabled)
evm: security.SMACK64EXEC (disabled)
evm: security.SMACK64TRANSMUTE (disabled)
evm: security.SMACK64MMAP (disabled)
evm: security.apparmor (disabled)
evm: security.ima
evm: security.capability
evm: HMAC attrs: 0x1
Running certificate verification RSA selftest
Loaded X.509 cert 'Certificate verification self-testing key: f58703bb33ce1=
b73ee02eccdee5b8817518fe3db'
Running certificate verification ECDSA selftest
Loaded X.509 cert 'Certificate verification ECDSA self-testing key: 2900bce=
a1deb7bc8479a84a23d758efdfdd2b2d3'
e1000e 0000:00:1f.6 eth0: NIC Link is Up 1000 Mbps Full Duplex, Flow Contro=
l: None
Sending DHCP requests ..., OK
IP-Config: Got DHCP answer from 192.168.3.1, my address is 192.168.3.99
IP-Config: Complete:
device=3Deth0, hwaddr=3D64:00:6a:30:91:48, ipaddr=3D192.168.3.99, mask=3D25=
5.255.255.0, gw=3D192.168.3.200
host=3Dlkp-skl-d05, domain=3Dlkp.intel.com, nis-domain=3D(none)
bootserver=3D192.168.3.200, rootserver=3D192.168.3.200, rootpath=3D
nameserver0=3D192.168.3.200
clk: Disabling unused clocks
PM: genpd: Disabling unused power domains
Freeing unused decrypted memory: 2028K
Freeing unused kernel image (initmem) memory: 7688K
Write protecting the kernel read-only data: 53248k
Freeing unused kernel image (rodata/data gap) memory: 564K
x86/mm: Checked W+X mappings: passed, no W+X pages found.
x86/mm: Checking user space page tables
x86/mm: Checked W+X mappings: passed, no W+X pages found.
Run /init as init process
with arguments:
/init
nokaslr
with environment:
HOME=3D/
TERM=3Dlinux
RESULT_ROOT=3D/result/perf-event-tests/not_paranoid_at_all/lkp-skl-d05/debi=
an-12-x86_64-20240206.cgz/x86_64-rhel-9.4-bpf/gcc-12/eca51ce01d4956ab4b8f06=
bb55c031f4913fffcb/0
BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-9.4-bpf/gcc-12/eca51ce01d4956ab4b8f06bb=
55c031f4913fffcb/vmlinuz-6.13.0-rc1-00027-geca51ce01d49
branch=3Dlinux-next/master
job=3D/lkp/jobs/scheduled/lkp-skl-d05/perf-event-tests-not_paranoid_at_all-=
debian-12-x86_64-20240206.cgz-eca51ce01d49-20241207-21354-b34j8-1.yaml
user=3Dlkp
ARCH=3Dx86_64
kconfig=3Dx86_64-rhel-9.4-bpf
commit=3Deca51ce01d4956ab4b8f06bb55c031f4913fffcb
max_uptime=3D1200
LKP_SERVER=3Dinternal-lkp-server
prompt_ramdisk=3D0
vga=3Dnormal
systemd[1]: RTC configured in localtime, applying delta of 0 minutes to sys=
tem time.

device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@lists=
.linux.dev
ACPI: bus type drm_connector registered
wmi_bus wmi_bus-PNP0C14:00: [Firmware Bug]: WQBC data block query control m=
ethod not found
EDAC ie31200: No ECC support
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dl=
vry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
EDAC ie31200: No ECC support
intel_pmc_core INT33A1:00:  initialized
Linux agpgart interface v0.103
libata version 3.00 loaded.
IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dl=
vry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
IOAPIC[0]: Preconfigured routing entry (2-17 -> IRQ 17 Level:1 ActiveLow:1)
ahci 0000:00:17.0: controller can't do SNTF, turning off CAP_SNTF
input: PC Speaker as /devices/platform/pcspkr/input/input3
ahci 0000:00:17.0: AHCI vers 0001.0301, 32 command slots, 6 Gbps, RAID mode
i801_smbus 0000:00:1f.4: SPD Write Disable is set
ahci 0000:00:17.0: 4/4 ports implemented (port mask 0xf)
i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
ahci 0000:00:17.0: flags: 64bit ncq pm led clo only pio slum part ems deso =
sadm sds apst=20
iTCO_wdt iTCO_wdt: Found a Intel PCH TCO device (Version=3D4, TCOBASE=3D0x0=
400)
IPMI message handler: version 39.2
i2c i2c-0: Successfully instantiated SPD at 0x51
scsi host0: ahci
i2c i2c-0: Successfully instantiated SPD at 0x52
i2c i2c-0: Successfully instantiated SPD at 0x53
ipmi device interface
scsi host1: ahci
RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
RAPL PMU: hw unit of domain package 2^-14 Joules
RAPL PMU: hw unit of domain dram 2^-14 Joules
LKP: ttyS0: 256: current_version: f0, target_version: f0
scsi host3: ahci
LKP: ttyS0: 256: skip deploy intel ucode as ucod[  143.466430][  T180] ata1=
: SATA max UDMA/133 abar m2048@0xf704b000 port 0xf704b100 irq 129 lpm-pol 0
e is same
ata2: SATA max UDMA/133 abar m2048@0xf704b000 port 0xf704b180 irq 129 lpm-p=
ol 0
ata3: SATA max UDMA/133 abar m2048@0xf704b000 port 0xf704b200 irq 129 lpm-p=
ol 0
RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
ata4: SATA max UDMA/133 abar m2048@0xf704b000 port 0xf704b280 irq 129 lpm-p=
ol 0
Error: Driver 'pcspkr' is already registered, aborting...
ipmi_si: IPMI System Interface driver
ipmi_si: Unable to find any System Interface(s)
ata3: SATA link down (SStatus 4 SControl 300)
ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
ata4: SATA link down (SStatus 4 SControl 300)
ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
ata2.00: Model 'INTEL SSDSC2KG960G8', rev 'XCV10120', applying quirks: zero=
aftertrim
ata2.00: ATA-10: INTEL SSDSC2KG960G8, XCV10120, max UDMA/133
ata2.00: 1875385008 sectors, multi 1: LBA48 NCQ (depth 32)
LKP: ttyS0: 256:[  143.860133][  T246] ata1.00: ATA-9: ST3000VX000-1ES166, =
CV27, max UDMA/133
Kernel tests: B[  143.868917][  T272] ata2.00: configured for UDMA/133
oot OK!
ata1.00: 5860533168 sectors, multi 16: LBA48 NCQ (depth 32), AA
ata1.00: configured for UDMA/133
LKP: ttyS0: 256: HOSTNAME lkp-skl-d05, MAC 64:00:6a:30:91:48, kernel 6.13.0=
-rc1-00027-geca51ce01d49 1
scsi 0:0:0:0: Direct-Access     ATA      ST3000VX000-1ES1 CV27 PQ: 0 ANSI: =
5
scsi 1:0:0:0: Direct-Access     ATA      INTEL SSDSC2KG96 0120 PQ: 0 ANSI: =
5
scsi 0:0:0:0: Attached scsi generic sg0 type 0
input: Dell WMI hotkeys as /devices/platform/PNP0C14:00/wmi_bus/wmi_bus-PNP=
0C14:00/9DBB5994-A997-11DA-B012-B622A1EF5492/input/input4
scsi 1:0:0:0: Attached scsi generic sg1 type 0
ata2.00: Enabling discard_zeroes_data
sd 0:0:0:0: [sda] 5860533168 512-byte logical blocks: (3.00 TB/2.73 TiB)
sd 1:0:0:0: [sdb] 1875385008 512-byte logical blocks: (960 GB/894 GiB)
sd 0:0:0:0: [sda] 4096-byte physical blocks
sd 0:0:0:0: [sda] Write Protect is off
sd 1:0:0:0: [sdb] 4096-byte physical blocks
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write Protect is off
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't suppor=
t DPO or FUA
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Preferred minimum I/O size 4096 bytes
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't suppor=
t DPO or FUA
sd 1:0:0:0: [sdb] Preferred minimum I/O size 4096 bytes
ata2.00: Enabling discard_zeroes_data
sda: sda1 sda2 sda3 sda4
sdb: sdb1 sdb2
sd 0:0:0:0: [sda] Attached SCSI disk
sd 1:0:0:0: [sdb] Attached SCSI disk
i915 0000:00:02.0: [drm] Found skylake (device ID 1912) display version 9.0=
0 stepping G0
i915 0000:00:02.0: vgaarb: deactivate vga console
Console: switching to colour dummy device 80x25
i915 0000:00:02.0: vgaarb: VGA decodes changed: olddecodes=3Dio+mem,decodes=
=3Dio+mem:owns=3Dio+mem
i915 0000:00:02.0: Direct firmware load for i915/skl_dmc_ver1_27.bin failed=
 with error -2
i915 0000:00:02.0: [drm] Failed to load DMC firmware i915/skl_dmc_ver1_27.b=
in (-ENOENT). Disabling runtime power management.
i915 0000:00:02.0: [drm] DMC firmware homepage: https://git.kernel.org/pub/=
scm/linux/kernel/git/firmware/linux-firmware.git
[drm] Initialized i915 1.6.0 for 0000:00:02.0 on minor 0
ACPI: video: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00=
/input/input5
snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops i915_audio_component_bi=
nd_ops [i915])
i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
snd_hda_codec_realtek hdaudioC0D0: ALC3234: picked fixup  (pin match)
snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC3234: line_outs=3D1 (0=
x1b/0x0/0x0/0x0/0x0) type:line
snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=3D1 (0x14/0x0/0x0/0x0/0x=
0)
snd_hda_codec_realtek hdaudioC0D0:    hp_outs=3D1 (0x21/0x0/0x0/0x0/0x0)
snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=3D0x0
snd_hda_codec_realtek hdaudioC0D0:    inputs:
snd_hda_codec_realtek hdaudioC0D0:      Headset Mic=3D0x19
snd_hda_codec_realtek hdaudioC0D0:      Headphone Mic=3D0x1a
raid6: skipped pq benchmark and selected avx2x4
raid6: using avx2x2 recovery algorithm
xor: automatically using best checksumming function   avx      =20
input: HDA Intel PCH Headphone Mic as /devices/pci0000:00/0000:00:1f.3/soun=
d/card0/input6
input: HDA Intel PCH Line Out as /devices/pci0000:00/0000:00:1f.3/sound/car=
d0/input7
input: HDA Intel PCH HDMI/DP,pcm=3D3 as /devices/pci0000:00/0000:00:1f.3/so=
und/card0/input8
input: HDA Intel PCH HDMI/DP,pcm=3D7 as /devices/pci0000:00/0000:00:1f.3/so=
und/card0/input9
input: HDA Intel PCH HDMI/DP,pcm=3D8 as /devices/pci0000:00/0000:00:1f.3/so=
und/card0/input10
intel_rapl_common: Found RAPL domain package
intel_rapl_common: Found RAPL domain core
intel_rapl_common: Found RAPL domain uncore
intel_rapl_common: Found RAPL domain dram
Btrfs loaded, zoned=3Dyes, fsverity=3Dyes
BTRFS: device fsid 64203e43-b048-4ba6-a0ac-92d7beafcd8a devid 1 transid 276=
00 /dev/sdb1 (8:17) scanned by mount (522)
BTRFS info (device sdb1): first mount of filesystem 64203e43-b048-4ba6-a0ac=
-92d7beafcd8a
BTRFS info (device sdb1): using crc32c (crc32c-intel) checksum algorithm
BTRFS info (device sdb1): using free-space-tree
LKP: ttyS0: 256:  /lkp/lkp/src/bin/run-lkp /lkp/jobs/scheduled/lkp-skl-d05/=
perf-event-tests-not_paranoid_at_all-debian-12-x86_64-20240206.cgz-eca51ce0=
1d49-20241207-21354-b34j8-1.yaml
LKP: ttyS0: 541: current_version: f0, target_version: f0
x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus for =
[mem 0x00000000-0x00000fff], got write-back
x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus for =
[mem 0xdb745000-0xdb745fff], got write-back
x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus for =
[mem 0xdb745000-0xdb745fff], got write-back
x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus for =
[mem 0x00000000-0x00000fff], got write-back
x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus for =
[mem 0xdb745000-0xdb745fff], got write-back
x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus for =
[mem 0xdb745000-0xdb745fff], got write-back
x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus for =
[mem 0x00000000-0x00000fff], got write-back
x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus for =
[mem 0xdb745000-0xdb745fff], got write-back
x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus for =
[mem 0xdb745000-0xdb745fff], got write-back
x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus for =
[mem 0x00000000-0x00000fff], got write-back
x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus for =
[mem 0xdb745000-0xdb745fff], got write-back
x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus for =
[mem 0xdb745000-0xdb745fff], got write-back
x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus for =
[mem 0x00000000-0x00000fff], got write-back
x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus for =
[mem 0xdb745000-0xdb745fff], got write-back
x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus for =
[mem 0xdb745000-0xdb745fff], got write-back
x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus for =
[mem 0x00000000-0x00000fff], got write-back
x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus for =
[mem 0xdb745000-0xdb745fff], got write-back
x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus for =
[mem 0xdb745000-0xdb745fff], got write-back
x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus for =
[mem 0x00000000-0x00000fff], got write-back
x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus for =
[mem 0xdb745000-0xdb745fff], got write-back
x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus for =
[mem 0xdb745000-0xdb745fff], got write-back
x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus for =
[mem 0x00000000-0x00000fff], got write-back
x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus for =
[mem 0xdb745000-0xdb745fff], got write-back
x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus for =
[mem 0xdb745000-0xdb745fff], got write-back
x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus for =
[mem 0x00000000-0x00000fff], got write-back
x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus for =
[mem 0xdb745000-0xdb745fff], got write-back
x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus for =
[mem 0xdb745000-0xdb745fff], got write-back
x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus for =
[mem 0x00000000-0x00000fff], got write-back
x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus for =
[mem 0xdb745000-0xdb745fff], got write-back
x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus for =
[mem 0xdb745000-0xdb745fff], got write-back
x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus for =
[mem 0x00000000-0x00000fff], got write-back
x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus for =
[mem 0xdb745000-0xdb745fff], got write-back
is_virt=3Dfalse

x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus for =
[mem 0xdb745000-0xdb745fff], got write-back
x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus for =
[mem 0x00000000-0x00000fff], got write-back
x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus for =
[mem 0xdb745000-0xdb745fff], got write-back
x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus for =
[mem 0xdb745000-0xdb745fff], got write-back
x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus for =
[mem 0x00000000-0x00000fff], got write-back
x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus for =
[mem 0xdb745000-0xdb745fff], got write-back
x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus for =
[mem 0xdb745000-0xdb745fff], got write-back
x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus for =
[mem 0x00000000-0x00000fff], got write-back
x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus for =
[mem 0xdb745000-0xdb745fff], got write-back
x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus for =
[mem 0xdb745000-0xdb745fff], got write-back
x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus for =
[mem 0x00000000-0x00000fff], got write-back
x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus for =
[mem 0xdb745000-0xdb745fff], got write-back
x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus for =
[mem 0xdb745000-0xdb745fff], got write-back
lkp: kernel tainted state: 0

LKP: stdout: 256: Kernel tests: Boot OK!

ntpdig: internal-lkp-server: Response dropped: stratum 0, probable KOD pack=
et

ntpdig: no eligible servers

ar: creating libhelper.a

LKP: stdout: 256: HOSTNAME lkp-skl-d05, MAC 64:00:6a:30:91:48, kernel 6.13.=
0-rc1-00027-geca51ce01d49 1

install debs round one: dpkg -i --force-confdef --force-depends /opt/deb/nt=
pdate_1%3a4.2.8p15+dfsg-2~1.2.2+dfsg1-1+deb12u1_all.deb

/opt/deb/ntpsec-ntpdate_1.2.2+dfsg1-1+deb12u1_amd64.deb

/opt/deb/python3-ntp_1.2.2+dfsg1-1+deb12u1_amd64.deb

/opt/deb/patch_2.7.6-7_amd64.deb

/opt/deb/libdpkg-perl_1.21.22_all.deb

/opt/deb/g++_4%3a12.2.0-3_amd64.deb

/opt/deb/g++-12_12.2.0-14_amd64.deb

/opt/deb/gcc_4%3a12.2.0-3_amd64.deb

/opt/deb/gcc-12_12.2.0-14_amd64.deb

/opt/deb/libgcc-12-dev_12.2.0-14_amd64.deb

/opt/deb/libquadmath0_12.2.0-14_amd64.deb

/opt/deb/libatomic1_12.2.0-14_amd64.deb

Selecting previously unselected package ntpdate.

(Reading database ... 16595 files and directories currently installed.)

Preparing to unpack .../ntpdate_1%3a4.2.8p15+dfsg-2~1.2.2+dfsg1-1+deb12u1_a=
ll.deb ...

Unpacking ntpdate (1:4.2.8p15+dfsg-2~1.2.2+dfsg1-1+deb12u1) ...

Selecting previously unselected package ntpsec-ntpdate.

Preparing to unpack .../ntpsec-ntpdate_1.2.2+dfsg1-1+deb12u1_amd64.deb ...

Unpacking ntpsec-ntpdate (1.2.2+dfsg1-1+deb12u1) ...

Selecting previously unselected package python3-ntp.

Preparing to unpack .../python3-ntp_1.2.2+dfsg1-1+deb12u1_amd64.deb ...

Unpacking python3-ntp (1.2.2+dfsg1-1+deb12u1) ...

Selecting previously unselected package patch.

Preparing to unpack .../deb/patch_2.7.6-7_amd64.deb ...

Unpacking patch (2.7.6-7) ...

Selecting previously unselected package libdpkg-perl.

Preparing to unpack .../libdpkg-perl_1.21.22_all.deb ...

Unpacking libdpkg-perl (1.21.22) ...

Selecting previously unselected package g++.

Preparing to unpack .../deb/g++_4%3a12.2.0-3_amd64.deb ...

Unpacking g++ (4:12.2.0-3) ...

Selecting previously unselected package g++-12.

Preparing to unpack .../deb/g++-12_12.2.0-14_amd64.deb ...

Unpacking g++-12 (12.2.0-14) ...

Selecting previously unselected package gcc.

Preparing to unpack .../deb/gcc_4%3a12.2.0-3_amd64.deb ...

Unpacking gcc (4:12.2.0-3) ...

Selecting previously unselected package gcc-12.

Preparing to unpack .../deb/gcc-12_12.2.0-14_amd64.deb ...

Unpacking gcc-12 (12.2.0-14) ...

Selecting previously unselected package libgcc-12-dev:amd64.

Preparing to unpack .../libgcc-12-dev_12.2.0-14_amd64.deb ...

Unpacking libgcc-12-dev:amd64 (12.2.0-14) ...

Selecting previously unselected package libquadmath0:amd64.

Preparing to unpack .../libquadmath0_12.2.0-14_amd64.deb ...

Unpacking libquadmath0:amd64 (12.2.0-14) ...

Selecting previously unselected package libatomic1:amd64.

Preparing to unpack .../libatomic1_12.2.0-14_amd64.deb ...

Unpacking libatomic1:amd64 (12.2.0-14) ...

Setting up python3-ntp (1.2.2+dfsg1-1+deb12u1) ...

Setting up patch (2.7.6-7) ...

Setting up libdpkg-perl (1.21.22) ...

Setting up libquadmath0:amd64 (12.2.0-14) ...

Setting up libatomic1:amd64 (12.2.0-14) ...

Setting up libgcc-12-dev:amd64 (12.2.0-14) ...

Setting up ntpdate (1:4.2.8p15+dfsg-2~1.2.2+dfsg1-1+deb12u1) ...

Setting up ntpsec-ntpdate (1.2.2+dfsg1-1+deb12u1) ...

Setting up g++ (4:12.2.0-3) ...

update-alternatives: using /usr/bin/g++ to provide /usr/bin/c++ (c++) in au=
to mode

Setting up g++-12 (12.2.0-14) ...

Setting up gcc (4:12.2.0-3) ...

Setting up gcc-12 (12.2.0-14) ...

Processing triggers for libc-bin (2.36-9+deb12u8) ...

NO_NETWORK=3D

LKP: stdout: 256:  /lkp/lkp/src/bin/run-lkp /lkp/jobs/scheduled/lkp-skl-d05=
/perf-event-tests-not_paranoid_at_all-debian-12-x86_64-20240206.cgz-eca51ce=
01d49-20241207-21354-b34j8-1.yaml

RESULT_ROOT=3D/result/perf-event-tests/not_paranoid_at_all/lkp-skl-d05/debi=
an-12-x86_64-20240206.cgz/x86_64-rhel-9.4-bpf/gcc-12/eca51ce01d4956ab4b8f06=
bb55c031f4913fffcb/0

job=3D/lkp/jobs/scheduled/lkp-skl-d05/perf-event-tests-not_paranoid_at_all-=
debian-12-x86_64-20240206.cgz-eca51ce01d49-20241207-21354-b34j8-1.yaml

result_service: raw_upload, RESULT_MNT: /internal-lkp-server/result, RESULT=
_ROOT: /internal-lkp-server/result/perf-event-tests/not_paranoid_at_all/lkp=
-skl-d05/debian-12-x86_64-20240206.cgz/x86_64-rhel-9.4-bpf/gcc-12/eca51ce01=
d4956ab4b8f06bb55c031f4913fffcb/0, TMP_RESULT_ROOT: /tmp/lkp/result

run-job /lkp/jobs/scheduled/lkp-skl-d05/perf-event-tests-not_paranoid_at_al=
l-debian-12-x86_64-20240206.cgz-eca51ce01d49-20241207-21354-b34j8-1.yaml

/usr/bin/wget -q --timeout=3D3600 --tries=3D1 --local-encoding=3DUTF-8 http=
://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=3D/l=
kp/jobs/scheduled/lkp-skl-d05/perf-event-tests-not_paranoid_at_all-debian-1=
2-x86_64-20240206.cgz-eca51ce01d49-20241207-21354-b34j8-1.yaml&job_state=3D=
running -O /dev/null

target ucode: 0xf0

LKP: stdout: 541: current_version: f0, target_version: f0

check_nr_cpu

CPU(s):                               4

On-line CPU(s) list:                  0-3

Model name:                           Intel(R) Core(TM) i5-6500 CPU @ 3.20G=
Hz

BIOS Model name:                      Intel(R) Core(TM) i5-6500 CPU @ 3.20G=
Hz  CPU @ 3.2GHz

Thread(s) per core:                   1

Core(s) per socket:                   4

Socket(s):                            1

CPU(s) scaling MHz:                   94%

NUMA node(s):                         1

NUMA node0 CPU(s):                    0-3

linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-9.4-bpf-eca51ce01d4=
956ab4b8f06bb55c031f4913fffcb

make -C lib

make[1]: Entering directory '/lkp/benchmarks/perf_event_tests/lib'

gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o bpf_helper=
s.o bpf_helpers.c

gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o branches_t=
estcode.o branches_testcode.c

gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o detect_cac=
he.o detect_cache.c

gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o instructio=
ns_testcode.o instructions_testcode.c

gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o matrix_mul=
tiply.o matrix_multiply.c

gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o nops_testc=
ode.o nops_testcode.c

gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o parse_reco=
rd.o parse_record.c

gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o perf_helpe=
rs.o perf_helpers.c

gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o test_utils=
.o test_utils.c

gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o tracefs_he=
lpers.o tracefs_helpers.c

ar r libhelper.a bpf_helpers.o branches_testcode.o detect_cache.o instructi=
ons_testcode.o matrix_multiply.o nops_testcode.o parse_record.o perf_helper=
s.o test_utils.o tracefs_helpers.o

ranlib libhelper.a

make[1]: Leaving directory '/lkp/benchmarks/perf_event_tests/lib'

make -C tests

make[1]: Entering directory '/lkp/benchmarks/perf_event_tests/tests'

make -C attr_fields

make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/tests/attr_fi=
elds'

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o disable=
d.o disabled.c

gcc   disabled.o ../../lib/libhelper.a  -lpthread -o disabled

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o enable_=
on_exec.o enable_on_exec.c

gcc   enable_on_exec.o ../../lib/libhelper.a  -lpthread -o enable_on_exec

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o exclude=
_guest.o exclude_guest.c

gcc   exclude_guest.o ../../lib/libhelper.a  -lpthread -o exclude_guest

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o exclude=
_host.o exclude_host.c

gcc   exclude_host.o ../../lib/libhelper.a  -lpthread -o exclude_host

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o exclude=
_idle.o exclude_idle.c

IPMI BMC is not supported on this machine, skip bmc-watchdog setup!

gcc   exclude_idle.o ../../lib/libhelper.a  -lpthread -o exclude_idle

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o exclude=
_hv.o exclude_hv.c

gcc   exclude_hv.o ../../lib/libhelper.a  -lpthread -o exclude_hv

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o exclude=
_kernel.o exclude_kernel.c

gcc   exclude_kernel.o ../../lib/libhelper.a  -lpthread -o exclude_kernel

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o exclude=
_user.o exclude_user.c

gcc   exclude_user.o ../../lib/libhelper.a  -lpthread -o exclude_user

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o exclusi=
ve.o exclusive.c

gcc   exclusive.o ../../lib/libhelper.a  -lpthread -o exclusive

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o format_=
id_support.o format_id_support.c

gcc   format_id_support.o ../../lib/libhelper.a  -lpthread -o format_id_sup=
port

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o inherit=
.o inherit.c

gcc   inherit.o ../../lib/libhelper.a  -lpthread -o inherit

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o inherit=
_stat.o inherit_stat.c

gcc   inherit_stat.o ../../lib/libhelper.a  -lpthread -o inherit_stat

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o pinned.=
o pinned.c

gcc   pinned.o ../../lib/libhelper.a  -lpthread -o pinned

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o read_fo=
rmat_range_check.o read_format_range_check.c

gcc   read_format_range_check.o ../../lib/libhelper.a  -lpthread -o read_fo=
rmat_range_check

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o sample_=
type_range_check.o sample_type_range_check.c

gcc   sample_type_range_check.o ../../lib/libhelper.a  -lpthread -o sample_=
type_range_check

make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests/attr_fie=
lds'

make -C breakpoints

make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/tests/breakpo=
ints'

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o breakpo=
int_support.o breakpoint_support.c

gcc   breakpoint_support.o ../../lib/libhelper.a   -o breakpoint_support

make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests/breakpoi=
nts'

make -C bugs

make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/tests/bugs'

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o check_s=
chedulability.o check_schedulability.c

gcc   check_schedulability.o ../../lib/libhelper.a   -o check_schedulabilit=
y

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o nmi_wat=
chdog_group_leader.o nmi_watchdog_group_leader.c

gcc   nmi_watchdog_group_leader.o ../../lib/libhelper.a   -o nmi_watchdog_g=
roup_leader

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o peo_zer=
o_return.o peo_zero_return.c

gcc   peo_zero_return.o ../../lib/libhelper.a   -o peo_zero_return

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o read_gr=
oup_attached.o read_group_attached.c

gcc   read_group_attached.o ../../lib/libhelper.a   -o read_group_attached

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o sync_re=
ad_required.o sync_read_required.c

gcc   sync_read_required.o ../../lib/libhelper.a   -o sync_read_required

make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests/bugs'

make -C constraints

make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/tests/constra=
ints'

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o check_c=
onstraints.o check_constraints.c

gcc   check_constraints.o ../../lib/libhelper.a   -o check_constraints

make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests/constrai=
nts'

make -C corner_cases

make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/tests/corner_=
cases'

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o check_r=
eset_mpx.o check_reset_mpx.c

gcc   check_reset_mpx.o ../../lib/libhelper.a   -o check_reset_mpx

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o context=
_switch_user_kernel.o context_switch_user_kernel.c

gcc   context_switch_user_kernel.o ../../lib/libhelper.a   -o context_switc=
h_user_kernel

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o huge_ev=
ents_start.o huge_events_start.c

gcc   huge_events_start.o ../../lib/libhelper.a   -o huge_events_start

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o huge_gr=
oup_start.o huge_group_start.c

gcc   huge_group_start.o ../../lib/libhelper.a   -o huge_group_start

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o hw_sw_m=
ix.o hw_sw_mix.c

gcc   hw_sw_mix.o ../../lib/libhelper.a   -o hw_sw_mix

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o ioctl_r=
efresh_0.o ioctl_refresh_0.c

gcc   ioctl_refresh_0.o ../../lib/libhelper.a   -o ioctl_refresh_0

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o max_mul=
tiplex.o max_multiplex.c

gcc   max_multiplex.o ../../lib/libhelper.a   -o max_multiplex

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o max_num=
_events.o max_num_events.c

gcc   max_num_events.o ../../lib/libhelper.a   -o max_num_events

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o multipl=
e_active.o multiple_active.c

gcc   multiple_active.o ../../lib/libhelper.a   -o multiple_active

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o overflo=
w_requires_mmap.o overflow_requires_mmap.c

gcc   overflow_requires_mmap.o ../../lib/libhelper.a   -o overflow_requires=
_mmap

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o reset_l=
eader.o reset_leader.c

gcc   reset_leader.o ../../lib/libhelper.a   -o reset_leader

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o sampled=
_notleader_refresh.o sampled_notleader_refresh.c

gcc   sampled_notleader_refresh.o ../../lib/libhelper.a   -o sampled_notlea=
der_refresh

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o signal_=
after_close.o signal_after_close.c

gcc   signal_after_close.o ../../lib/libhelper.a   -o signal_after_close

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o signal_=
after_exec.o signal_after_exec.c

gcc   signal_after_exec.o ../../lib/libhelper.a   -o signal_after_exec

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o sw_star=
t_leader.o sw_start_leader.c

gcc   sw_start_leader.o ../../lib/libhelper.a   -o sw_start_leader

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o wrap.o =
wrap.c

gcc   wrap.o ../../lib/libhelper.a   -o wrap

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o wrong_s=
ize_enospc.o wrong_size_enospc.c

gcc   wrong_size_enospc.o ../../lib/libhelper.a   -o wrong_size_enospc

make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests/corner_c=
ases'

make -C error_returns

make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/tests/error_r=
eturns'

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o e2big.o=
 e2big.c

gcc   e2big.o ../../lib/libhelper.a   -o e2big

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o eacces.=
o eacces.c

gcc   eacces.o ../../lib/libhelper.a   -o eacces

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o ebadf.o=
 ebadf.c

gcc   ebadf.o ../../lib/libhelper.a   -o ebadf

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o efault.=
o efault.c

gcc   efault.o ../../lib/libhelper.a   -o efault

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o einval.=
o einval.c

gcc   einval.o ../../lib/libhelper.a   -o einval

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o emfile.=
o emfile.c

gcc   emfile.o ../../lib/libhelper.a   -o emfile

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o enoent.=
o enoent.c

gcc   enoent.o ../../lib/libhelper.a   -o enoent

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o enospc.=
o enospc.c

gcc   enospc.o ../../lib/libhelper.a   -o enospc

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o eopnots=
upp.o eopnotsupp.c

gcc   eopnotsupp.o ../../lib/libhelper.a   -o eopnotsupp

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o eoverfl=
ow.o eoverflow.c

gcc   eoverflow.o ../../lib/libhelper.a   -o eoverflow

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o eperm.o=
 eperm.c

gcc   eperm.o ../../lib/libhelper.a   -o eperm

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o esrch.o=
 esrch.c

gcc   esrch.o ../../lib/libhelper.a   -o esrch

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o non-exi=
stent.o non-existent.c

gcc   non-existent.o ../../lib/libhelper.a   -o non-existent

make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests/error_re=
turns'

make -C flags

make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/tests/flags'

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o flags_c=
group.o flags_cgroup.c

gcc   flags_cgroup.o ../../lib/libhelper.a   -o flags_cgroup

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o flags_f=
d_no_group.o flags_fd_no_group.c

gcc   flags_fd_no_group.o ../../lib/libhelper.a   -o flags_fd_no_group

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o flags_f=
d_output.o flags_fd_output.c

gcc   flags_fd_output.o ../../lib/libhelper.a   -o flags_fd_output

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o flags_r=
ange_check.o flags_range_check.c

gcc   flags_range_check.o ../../lib/libhelper.a   -o flags_range_check

make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests/flags'

make -C generalized_events

make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/tests/general=
ized_events'

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o branche=
s.o branches.c

gcc   branches.o ../../lib/libhelper.a   -o branches

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o branch-=
misses.o branch-misses.c

gcc   branch-misses.o ../../lib/libhelper.a   -o branch-misses

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o cycles.=
o cycles.c

gcc  -o cycles cycles.o ../../lib/libhelper.a -lrt

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o instruc=
tions.o instructions.c

gcc   instructions.o ../../lib/libhelper.a   -o instructions

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o l1-dcac=
he-loads.o l1-dcache-loads.c

gcc   l1-dcache-loads.o ../../lib/libhelper.a   -o l1-dcache-loads

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o l1-dcac=
he-stores.o l1-dcache-stores.c

gcc   l1-dcache-stores.o ../../lib/libhelper.a   -o l1-dcache-stores

make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests/generali=
zed_events'

make -C ioctl

make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/tests/ioctl'

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o ioctl_f=
lag_group.o ioctl_flag_group.c

gcc   ioctl_flag_group.o ../../lib/libhelper.a   -o ioctl_flag_group

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o ioctl_0=
_enable.o ioctl_0_enable.c

gcc   ioctl_0_enable.o ../../lib/libhelper.a   -o ioctl_0_enable

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o ioctl_1=
_disable.o ioctl_1_disable.c

gcc   ioctl_1_disable.o ../../lib/libhelper.a   -o ioctl_1_disable

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o ioctl_2=
_refresh.o ioctl_2_refresh.c

gcc   ioctl_2_refresh.o ../../lib/libhelper.a   -o ioctl_2_refresh

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o ioctl_3=
_reset.o ioctl_3_reset.c

gcc   ioctl_3_reset.o ../../lib/libhelper.a   -o ioctl_3_reset

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o ioctl_4=
_period.o ioctl_4_period.c

gcc   ioctl_4_period.o ../../lib/libhelper.a   -o ioctl_4_period

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o ioctl_5=
_set_output.o ioctl_5_set_output.c

gcc   ioctl_5_set_output.o ../../lib/libhelper.a   -o ioctl_5_set_output

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o ioctl_6=
_set_filter.o ioctl_6_set_filter.c

gcc   ioctl_6_set_filter.o ../../lib/libhelper.a   -o ioctl_6_set_filter

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o ioctl_7=
_id.o ioctl_7_id.c

gcc   ioctl_7_id.o ../../lib/libhelper.a   -o ioctl_7_id

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o ioctl_8=
_set_bpf.o ioctl_8_set_bpf.c

gcc   ioctl_8_set_bpf.o ../../lib/libhelper.a   -o ioctl_8_set_bpf

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o ioctl_9=
_pause_output.o ioctl_9_pause_output.c

gcc   ioctl_9_pause_output.o ../../lib/libhelper.a   -o ioctl_9_pause_outpu=
t

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o ioctl_1=
0_query_bpf.o ioctl_10_query_bpf.c

gcc   ioctl_10_query_bpf.o ../../lib/libhelper.a   -o ioctl_10_query_bpf

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o ioctl_1=
1_modify_attributes.o ioctl_11_modify_attributes.c

gcc   ioctl_11_modify_attributes.o ../../lib/libhelper.a   -o ioctl_11_modi=
fy_attributes

make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests/ioctl'

make -C multiplexing

make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/tests/multipl=
exing'

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o check_m=
ultiplexing.o check_multiplexing.c

gcc   check_multiplexing.o ../../lib/libhelper.a   -o check_multiplexing

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o check_p=
api_multiplexing.o check_papi_multiplexing.c

gcc   check_papi_multiplexing.o ../../lib/libhelper.a   -o check_papi_multi=
plexing

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o old_mul=
tiplexing.o old_multiplexing.c

gcc   old_multiplexing.o ../../lib/libhelper.a   -o old_multiplexing

make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests/multiple=
xing'

make -C multithread

make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/tests/multith=
read'

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o fork_th=
en_read.o fork_then_read.c

gcc   fork_then_read.o ../../lib/libhelper.a   -o fork_then_read

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o lots_of=
_forks.o lots_of_forks.c

gcc   lots_of_forks.o ../../lib/libhelper.a   -o lots_of_forks

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o open_fo=
rk_close_kill.o open_fork_close_kill.c

gcc   open_fork_close_kill.o ../../lib/libhelper.a   -o open_fork_close_kil=
l

make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests/multithr=
ead'

make -C openmp

make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/tests/openmp'

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o openmp_=
test.o openmp_test.c

gcc   openmp_test.o ../../lib/libhelper.a  -fopenmp -o openmp_test

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o openmp_=
overflow.o openmp_overflow.c

gcc   openmp_overflow.o ../../lib/libhelper.a  -fopenmp -o openmp_overflow

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o openmp_=
sample.o openmp_sample.c

gcc   openmp_sample.o ../../lib/libhelper.a  -fopenmp -o openmp_sample

make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests/openmp'

make -C overflow

make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/tests/overflo=
w'

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o breakpo=
int_overflow.o breakpoint_overflow.c

gcc   breakpoint_overflow.o ../../lib/libhelper.a   -o breakpoint_overflow

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o overflo=
w_large.o overflow_large.c

gcc   overflow_large.o ../../lib/libhelper.a   -o overflow_large

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o overflo=
w_poll.o overflow_poll.c

gcc   overflow_poll.o ../../lib/libhelper.a   -o overflow_poll

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o overflo=
w_signal.o overflow_signal.c

gcc   overflow_signal.o ../../lib/libhelper.a   -o overflow_signal

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o overflo=
w_skid.o overflow_skid.c

gcc   overflow_skid.o ../../lib/libhelper.a   -o overflow_skid

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o overflo=
w_requires_wakeup.o overflow_requires_wakeup.c

gcc   overflow_requires_wakeup.o ../../lib/libhelper.a   -o overflow_requir=
es_wakeup

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o simple_=
overflow_leader.o simple_overflow_leader.c

gcc   simple_overflow_leader.o ../../lib/libhelper.a   -o simple_overflow_l=
eader

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o simple_=
overflow_leader_poll.o simple_overflow_leader_poll.c

gcc   simple_overflow_leader_poll.o ../../lib/libhelper.a   -o simple_overf=
low_leader_poll

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o simple_=
overflow_sibling.o simple_overflow_sibling.c

gcc   simple_overflow_sibling.o ../../lib/libhelper.a   -o simple_overflow_=
sibling

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o simulta=
neous_group_overflow.o simultaneous_group_overflow.c

gcc   simultaneous_group_overflow.o ../../lib/libhelper.a   -o simultaneous=
_group_overflow

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o simul_o=
neshot_group_overflow.o simul_oneshot_group_overflow.c

gcc   simul_oneshot_group_overflow.o ../../lib/libhelper.a   -o simul_onesh=
ot_group_overflow

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o simulta=
neous_overflow.o simultaneous_overflow.c

gcc   simultaneous_overflow.o ../../lib/libhelper.a   -o simultaneous_overf=
low

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o single_=
shot_overflow.o single_shot_overflow.c

gcc   single_shot_overflow.o ../../lib/libhelper.a   -o single_shot_overflo=
w

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o single_=
shot_w_enable.o single_shot_w_enable.c

gcc   single_shot_w_enable.o ../../lib/libhelper.a   -o single_shot_w_enabl=
e

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o wakeup_=
events_overflow.o wakeup_events_overflow.c

gcc   wakeup_events_overflow.o ../../lib/libhelper.a   -o wakeup_events_ove=
rflow

make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests/overflow=
'

make -C periodic_stats

make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/tests/periodi=
c_stats'

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o print_r=
ecord_sample.o print_record_sample.c

gcc   print_record_sample.o  -lpthread -o print_record_sample

make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests/periodic=
_stats'

make -C prctl

make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/tests/prctl'

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o prctl.o=
 prctl.c

gcc   prctl.o ../../lib/libhelper.a   -o prctl

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o prctl_a=
ttach.o prctl_attach.c

gcc   prctl_attach.o ../../lib/libhelper.a   -o prctl_attach

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o prctl_c=
hild.o prctl_child.c

gcc   prctl_child.o ../../lib/libhelper.a   -o prctl_child

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o prctl_i=
nherit.o prctl_inherit.c

gcc   prctl_inherit.o ../../lib/libhelper.a   -o prctl_inherit

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o prctl_p=
arent.o prctl_parent.c

gcc   prctl_parent.o ../../lib/libhelper.a   -o prctl_parent

make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests/prctl'

make -C rdpmc

make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/tests/rdpmc'

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o rdpmc_a=
ttach.o rdpmc_attach.c

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o rdpmc_l=
ib.o rdpmc_lib.c

gcc   rdpmc_attach.o rdpmc_lib.o ../../lib/libhelper.a  -lpthread -o rdpmc_=
attach

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o rdpmc_a=
ttach_cpu.o rdpmc_attach_cpu.c

gcc   rdpmc_attach_cpu.o rdpmc_lib.o ../../lib/libhelper.a  -lpthread -o rd=
pmc_attach_cpu

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o rdpmc_a=
ttach_global_cpu.o rdpmc_attach_global_cpu.c

gcc   rdpmc_attach_global_cpu.o rdpmc_lib.o ../../lib/libhelper.a  -lpthrea=
d -o rdpmc_attach_global_cpu

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o rdpmc_a=
ttach_other_cpu.o rdpmc_attach_other_cpu.c

gcc   rdpmc_attach_other_cpu.o rdpmc_lib.o ../../lib/libhelper.a  -lpthread=
 -o rdpmc_attach_other_cpu

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o rdpmc_a=
ttach_multi_enable.o rdpmc_attach_multi_enable.c

gcc   rdpmc_attach_multi_enable.o rdpmc_lib.o ../../lib/libhelper.a  -lpthr=
ead -o rdpmc_attach_multi_enable

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o rdpmc_e=
xec.o rdpmc_exec.c

gcc   rdpmc_exec.o rdpmc_lib.o ../../lib/libhelper.a  -lpthread -o rdpmc_ex=
ec

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o rdpmc_e=
xec_papi.o rdpmc_exec_papi.c

gcc   rdpmc_exec_papi.o rdpmc_lib.o ../../lib/libhelper.a  -lpthread -o rdp=
mc_exec_papi

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o rdpmc_g=
roup.o rdpmc_group.c

gcc   rdpmc_group.o rdpmc_lib.o ../../lib/libhelper.a  -lpthread -o rdpmc_g=
roup

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o rdpmc_g=
roup_syswide.o rdpmc_group_syswide.c

gcc   rdpmc_group_syswide.o rdpmc_lib.o ../../lib/libhelper.a  -lpthread -o=
 rdpmc_group_syswide

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o rdpmc_i=
nvalid.o rdpmc_invalid.c

gcc   rdpmc_invalid.o rdpmc_lib.o ../../lib/libhelper.a  -lpthread -o rdpmc=
_invalid

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o rdpmc_m=
ultiattach.o rdpmc_multiattach.c

gcc   rdpmc_multiattach.o rdpmc_lib.o ../../lib/libhelper.a  -lpthread -o r=
dpmc_multiattach

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o rdpmc_m=
ultiattach_papi.o rdpmc_multiattach_papi.c

gcc   rdpmc_multiattach_papi.o rdpmc_lib.o ../../lib/libhelper.a  -lpthread=
 -o rdpmc_multiattach_papi

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o rdpmc_m=
ultiplexing.o rdpmc_multiplexing.c

gcc   rdpmc_multiplexing.o rdpmc_lib.o ../../lib/libhelper.a  -lpthread -o =
rdpmc_multiplexing

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o rdpmc_p=
threads.o rdpmc_pthreads.c

gcc   rdpmc_pthreads.o rdpmc_lib.o ../../lib/libhelper.a  -lpthread -o rdpm=
c_pthreads

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o rdpmc_p=
threads_group.o rdpmc_pthreads_group.c

gcc   rdpmc_pthreads_group.o rdpmc_lib.o ../../lib/libhelper.a  -lpthread -=
o rdpmc_pthreads_group

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o rdpmc_r=
eset.o rdpmc_reset.c

gcc   rdpmc_reset.o rdpmc_lib.o ../../lib/libhelper.a  -lpthread -o rdpmc_r=
eset

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o rdpmc_s=
upport.o rdpmc_support.c

gcc   rdpmc_support.o rdpmc_lib.o ../../lib/libhelper.a  -lpthread -o rdpmc=
_support

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o rdpmc_s=
w_events.o rdpmc_sw_events.c

gcc   rdpmc_sw_events.o rdpmc_lib.o ../../lib/libhelper.a  -lpthread -o rdp=
mc_sw_events

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o rdpmc_v=
alidation.o rdpmc_validation.c

gcc   rdpmc_validation.o rdpmc_lib.o ../../lib/libhelper.a  -lpthread -o rd=
pmc_validation

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o rdpmc_c=
omparision_readsyscall.o rdpmc_comparision_readsyscall.c

gcc   rdpmc_comparision_readsyscall.o  -lpthread -o rdpmc_comparision_reads=
yscall

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o rdpmc_c=
omparision_mmap.o rdpmc_comparision_mmap.c

gcc   rdpmc_comparision_mmap.o  -lpthread -o rdpmc_comparision_mmap

make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests/rdpmc'

make -C record_sample

make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/tests/record_=
sample'

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o lost_re=
cord_sample.o lost_record_sample.c

gcc   lost_record_sample.o ../../lib/libhelper.a   -o lost_record_sample

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o mmap_mu=
ltiple.o mmap_multiple.c

gcc   mmap_multiple.o ../../lib/libhelper.a   -o mmap_multiple

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o multipl=
e_mmap_sizes.o multiple_mmap_sizes.c

gcc   multiple_mmap_sizes.o ../../lib/libhelper.a   -o multiple_mmap_sizes

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o overwri=
te_mmap.o overwrite_mmap.c

gcc   overwrite_mmap.o ../../lib/libhelper.a   -o overwrite_mmap

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o print_r=
ecord_sample.o print_record_sample.c

gcc   print_record_sample.o ../../lib/libhelper.a   -o print_record_sample

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o record_=
comm.o record_comm.c

gcc   record_comm.o ../../lib/libhelper.a   -o record_comm

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o record_=
comm_exec.o record_comm_exec.c

gcc   record_comm_exec.o ../../lib/libhelper.a   -o record_comm_exec

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o record_=
fork.o record_fork.c

gcc   record_fork.o ../../lib/libhelper.a   -o record_fork

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o record_=
mmap.o record_mmap.c

gcc   record_mmap.o ../../lib/libhelper.a   -o record_mmap

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o record_=
mmap2.o record_mmap2.c

gcc   record_mmap2.o ../../lib/libhelper.a   -o record_mmap2

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o record_=
mmap_data.o record_mmap_data.c

gcc   record_mmap_data.o ../../lib/libhelper.a   -o record_mmap_data

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o sample_=
branch_stack.o sample_branch_stack.c

gcc   sample_branch_stack.o ../../lib/libhelper.a   -o sample_branch_stack

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o sample_=
data_src.o sample_data_src.c

gcc   sample_data_src.o ../../lib/libhelper.a   -o sample_data_src

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o sample_=
regs_intr.o sample_regs_intr.c

gcc   sample_regs_intr.o ../../lib/libhelper.a   -o sample_regs_intr

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o sample_=
regs_user.o sample_regs_user.c

gcc   sample_regs_user.o ../../lib/libhelper.a   -o sample_regs_user

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o sample_=
stack_user.o sample_stack_user.c

gcc   sample_stack_user.o ../../lib/libhelper.a   -o sample_stack_user

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o sample_=
weight.o sample_weight.c

gcc   sample_weight.o ../../lib/libhelper.a   -o sample_weight

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o validat=
e_record_sample.o validate_record_sample.c

gcc   validate_record_sample.o ../../lib/libhelper.a   -o validate_record_s=
ample

make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests/record_s=
ample'

make -C size

make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/tests/size'

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o header_=
mismatch.o header_mismatch.c

gcc   header_mismatch.o ../../lib/libhelper.a   -o header_mismatch

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o just_ri=
ght.o just_right.c

gcc   just_right.o ../../lib/libhelper.a   -o just_right

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o too_big=
.o too_big.c

gcc   too_big.o ../../lib/libhelper.a   -o too_big

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o too_lit=
tle.o too_little.c

gcc   too_little.o ../../lib/libhelper.a   -o too_little

make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests/size'

make -C socket

make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/tests/socket'

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o socket_=
pass.o socket_pass.c

gcc   socket_pass.o ../../lib/libhelper.a   -o socket_pass

make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests/socket'

make -C sysfs

make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/tests/sysfs'

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o events.=
o events.c

gcc   events.o ../../lib/libhelper.a   -o events

make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests/sysfs'

make -C tracepoints

make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/tests/tracepo=
ints'

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o tracepo=
int_alias.o tracepoint_alias.c

gcc   tracepoint_alias.o ../../lib/libhelper.a   -o tracepoint_alias

make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests/tracepoi=
nts'

make -C utils

make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/tests/utils'

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o check_p=
aranoid.o check_paranoid.c

gcc   check_paranoid.o ../../lib/libhelper.a   -o check_paranoid

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o get_cac=
he_info.o get_cache_info.c

gcc   get_cache_info.o ../../lib/libhelper.a   -o get_cache_info

make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests/utils'

make -C x86_amd

make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/tests/x86_amd=
'

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o ibs_fet=
ch.o ibs_fetch.c

gcc   ibs_fetch.o ../../lib/libhelper.a   -o ibs_fetch

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o ibs_op.=
o ibs_op.c

gcc   ibs_op.o ../../lib/libhelper.a   -o ibs_op

make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests/x86_amd'

make -C x86_intel

make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/tests/x86_int=
el'

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o bts_aux=
.o bts_aux.c

gcc   bts_aux.o ../../lib/libhelper.a   -o bts_aux

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o bts_ker=
nel.o bts_kernel.c

gcc   bts_kernel.o ../../lib/libhelper.a   -o bts_kernel

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o fixed_c=
tr0.o fixed_ctr0.c

gcc   fixed_ctr0.o ../../lib/libhelper.a   -o fixed_ctr0

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o fixed_c=
tr1.o fixed_ctr1.c

gcc   fixed_ctr1.o ../../lib/libhelper.a   -o fixed_ctr1

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o fixed_c=
tr2.o fixed_ctr2.c

gcc   fixed_ctr2.o ../../lib/libhelper.a   -o fixed_ctr2

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o offcore=
_response.o offcore_response.c

gcc   offcore_response.o ../../lib/libhelper.a   -o offcore_response

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o offcore=
_response_mask.o offcore_response_mask.c

gcc   offcore_response_mask.o ../../lib/libhelper.a   -o offcore_response_m=
ask

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o pebs.o =
pebs.c

gcc   pebs.o ../../lib/libhelper.a   -o pebs

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o pebs_ad=
dr.o pebs_addr.c

gcc   pebs_addr.o ../../lib/libhelper.a   -o pebs_addr

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o pebs_la=
tency.o pebs_latency.c

gcc   pebs_latency.o ../../lib/libhelper.a   -o pebs_latency

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o pebs_re=
gisters.o pebs_registers.c

gcc   pebs_registers.o ../../lib/libhelper.a   -o pebs_registers

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o uncore_=
events.o uncore_events.c

gcc   uncore_events.o ../../lib/libhelper.a   -o uncore_events

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o uncore_=
cpu_cbox.o uncore_cpu_cbox.c

gcc   uncore_cpu_cbox.o ../../lib/libhelper.a   -o uncore_cpu_cbox

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o uncore_=
max_cbox.o uncore_max_cbox.c

gcc   uncore_max_cbox.o ../../lib/libhelper.a   -o uncore_max_cbox

gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o uncore_=
group_cbox.o uncore_group_cbox.c

gcc   uncore_group_cbox.o ../../lib/libhelper.a   -o uncore_group_cbox

make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests/x86_inte=
l'

make[1]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests'

make -C crashes

make[1]: Entering directory '/lkp/benchmarks/perf_event_tests/crashes'

gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o pe_inherit=
_memleak.o pe_inherit_memleak.c

gcc   pe_inherit_memleak.o ../lib/libhelper.a  -lpthread -o pe_inherit_meml=
eak

gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o pe_task_sc=
hedule_panic.o pe_task_schedule_panic.c

gcc   pe_task_schedule_panic.o ../lib/libhelper.a  -lpthread -o pe_task_sch=
edule_panic

gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o perf_mmap_=
close_bug.o perf_mmap_close_bug.c

gcc   perf_mmap_close_bug.o ../lib/libhelper.a  -lpthread -o perf_mmap_clos=
e_bug

gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o offcore_re=
sponse_mask.o offcore_response_mask.c

gcc   offcore_response_mask.o ../lib/libhelper.a  -lpthread -o offcore_resp=
onse_mask

gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o oflo_sw_cp=
u_clock_crash.o oflo_sw_cpu_clock_crash.c

gcc   oflo_sw_cpu_clock_crash.o ../lib/libhelper.a  -lpthread -o oflo_sw_cp=
u_clock_crash

gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o sw_event_c=
onfig_overflow.o sw_event_config_overflow.c

gcc   sw_event_config_overflow.o ../lib/libhelper.a  -lpthread -o sw_event_=
config_overflow

gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o nmi_soft_l=
ockup.o nmi_soft_lockup.c

gcc   nmi_soft_lockup.o  -lpthread -o nmi_soft_lockup

gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o tracepoint=
_irq_work_exit.o tracepoint_irq_work_exit.c

gcc   tracepoint_irq_work_exit.o  -lpthread -o tracepoint_irq_work_exit

gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o arm_valida=
te_event_oops.o arm_validate_event_oops.c

gcc   arm_validate_event_oops.o  -lpthread -o arm_validate_event_oops

gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o arm_map_hw=
_event_oops.o arm_map_hw_event_oops.c

gcc   arm_map_hw_event_oops.o  -lpthread -o arm_map_hw_event_oops

gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o perf_ftrac=
e_event_crash.o perf_ftrace_event_crash.c

gcc   perf_ftrace_event_crash.o  -lpthread -o perf_ftrace_event_crash

gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o css_cgroup=
_crash.o css_cgroup_crash.c

gcc   css_cgroup_crash.o ../lib/libhelper.a  -lpthread -o css_cgroup_crash

gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o rapl_crash=
.o rapl_crash.c

gcc   rapl_crash.o ../lib/libhelper.a  -lpthread -o rapl_crash

make[1]: Leaving directory '/lkp/benchmarks/perf_event_tests/crashes'

make -C fuzzer

make[1]: Entering directory '/lkp/benchmarks/perf_event_tests/fuzzer'

gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I./t=
rinity_files/include  -c -o perf_fuzzer.o perf_fuzzer.c

gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I./t=
rinity_files/include  -c -o perf_attr_print.o perf_attr_print.c

gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I./t=
rinity_files/include  -c -o get_cpuinfo.o get_cpuinfo.c

gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I./t=
rinity_files/include  -c -o filter_address.o filter_address.c

gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I./t=
rinity_files/include  -c -o filter_tracepoint.o filter_tracepoint.c

gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I./t=
rinity_files/include  -c -o fuzz_access.o fuzz_access.c

gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I./t=
rinity_files/include  -c -o fuzz_close.o fuzz_close.c

gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I./t=
rinity_files/include  -c -o fuzz_fork.o fuzz_fork.c

gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I./t=
rinity_files/include  -c -o fuzz_ioctl.o fuzz_ioctl.c

gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I./t=
rinity_files/include  -c -o fuzz_million.o fuzz_million.c

gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I./t=
rinity_files/include  -c -o fuzz_mmap.o fuzz_mmap.c

gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I./t=
rinity_files/include  -c -o fuzz_open.o fuzz_open.c

gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I./t=
rinity_files/include  -c -o fuzz_overflow.o fuzz_overflow.c

gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I./t=
rinity_files/include  -c -o fuzz_poll.o fuzz_poll.c

gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I./t=
rinity_files/include  -c -o fuzz_prctl.o fuzz_prctl.c

gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I./t=
rinity_files/include  -c -o fuzz_read.o fuzz_read.c

gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I./t=
rinity_files/include  -c -o fuzz_vsyscall.o fuzz_vsyscall.c

gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I./t=
rinity_files/include  -c -o fuzz_write.o fuzz_write.c

gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I./t=
rinity_files/include  -c -o fuzzer_random.o fuzzer_random.c

gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I./t=
rinity_files/include  -c -o fuzzer_stats.o fuzzer_stats.c

make -C trinity_files

make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/fuzzer/trinit=
y_files'

gcc -Wno-all -Wno-incompatible-pointer-types -I./include -I../../include -I=
.  -c -o fds.o fds.c

gcc -Wno-all -Wno-incompatible-pointer-types -I./include -I../../include -I=
.  -c -o generic-sanitise.o generic-sanitise.c

gcc -Wno-all -Wno-incompatible-pointer-types -I./include -I../../include -I=
.  -c -o interesting-numbers.o interesting-numbers.c

gcc -Wno-all -Wno-incompatible-pointer-types -I./include -I../../include -I=
.  -c -o log.o log.c

gcc -Wno-all -Wno-incompatible-pointer-types -I./include -I../../include -I=
.  -c -o perf_event_open.o perf_event_open.c

gcc -Wno-all -Wno-incompatible-pointer-types -I./include -I../../include -I=
.  -c -o pids.o pids.c

gcc -Wno-all -Wno-incompatible-pointer-types -I./include -I../../include -I=
.  -c -o random-address.o random-address.c

gcc -Wno-all -Wno-incompatible-pointer-types -I./include -I../../include -I=
.  -c -o random-length.o random-length.c

gcc -Wno-all -Wno-incompatible-pointer-types -I./include -I../../include -I=
.  -c -o random.o random.c

gcc -Wno-all -Wno-incompatible-pointer-types -I./include -I../../include -I=
.  -c -o shm.o shm.c

gcc -Wno-all -Wno-incompatible-pointer-types -I./include -I../../include -I=
.  -c -o unicode.o unicode.c

gcc -Wno-all -Wno-incompatible-pointer-types -I./include -I../../include -I=
.  -c -o utils.o utils.c

ar ru trinity_lib.a fds.o generic-sanitise.o interesting-numbers.o log.o pe=
rf_event_open.o pids.o random-address.o random-length.o random.o shm.o unic=
ode.o utils.o

ar: `u' modifier ignored since `D' is the default (see `U')

ar: creating trinity_lib.a

ranlib trinity_lib.a

make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/fuzzer/trinity=
_files'

gcc   perf_fuzzer.o perf_attr_print.o get_cpuinfo.o filter_address.o filter=
_tracepoint.o fuzz_access.o fuzz_close.o fuzz_fork.o fuzz_ioctl.o fuzz_mill=
ion.o fuzz_mmap.o fuzz_open.o fuzz_overflow.o fuzz_poll.o fuzz_prctl.o fuzz=
_read.o fuzz_vsyscall.o fuzz_write.o fuzzer_random.o fuzzer_stats.o ../lib/=
libhelper.a trinity_files/trinity_lib.a   -o perf_fuzzer

gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I./t=
rinity_files/include  -c -o replay_log.o replay_log.c

gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I./t=
rinity_files/include  -c -o parse_log.o parse_log.c

gcc   replay_log.o parse_log.o ../lib/libhelper.a perf_attr_print.o trinity=
_files/trinity_lib.a   -o replay_log

gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I./t=
rinity_files/include  -c -o log_to_code.o log_to_code.c

gcc   log_to_code.o perf_attr_print.o parse_log.o ../lib/libhelper.a   -o l=
og_to_code

gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I./t=
rinity_files/include   filter_log.c   -o filter_log

gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I./t=
rinity_files/include  -c -o active_events.o active_events.c

gcc   active_events.o parse_log.o ../lib/libhelper.a perf_attr_print.o   -o=
 active_events

make[1]: Leaving directory '/lkp/benchmarks/perf_event_tests/fuzzer'

make -C tools

make[1]: Entering directory '/lkp/benchmarks/perf_event_tests/tools'

gcc -Wno-all -Wno-incompatible-pointer-types   -c -o event_parser.o event_p=
arser.c

gcc   event_parser.o   -o event_parser

gcc -Wno-all -Wno-incompatible-pointer-types   -c -o trace_event_parser.o t=
race_event_parser.c

gcc   trace_event_parser.o   -o trace_event_parser

gcc -Wno-all -Wno-incompatible-pointer-types   -c -o trace_filter_generator=
.o trace_filter_generator.c

gcc   trace_filter_generator.o   -o trace_filter_generator

make[1]: Leaving directory '/lkp/benchmarks/perf_event_tests/tools'

make -C warnings

make[1]: Entering directory '/lkp/benchmarks/perf_event_tests/warnings'

gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o core2_nmi_=
flood.o core2_nmi_flood.c

gcc   core2_nmi_flood.o   -o core2_nmi_flood

gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o kec_2122_w=
arn.o kec_2122_warn.c

gcc   kec_2122_warn.o ../lib/libhelper.a   -o kec_2122_warn

gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o pec_1076_w=
arn.o pec_1076_warn.c

gcc   pec_1076_warn.o ../lib/libhelper.a   -o pec_1076_warn

make[1]: Leaving directory '/lkp/benchmarks/perf_event_tests/warnings'

mount: /sys/kernel/tracing: nodev already mounted or mount point busy.

dmesg(1) may have more information after failed mount system call.

2024-12-07 12:36:04 ./run_tests.sh



**** RUNNING perf_event_tests ****

Linux lkp-skl-d05 6.13.0-rc1-00027-geca51ce01d49 #1 SMP PREEMPT_DYNAMIC Sat=
 Dec  7 16:35:26 CST 2024 x86_64 GNU/Linux



* Testing /proc/sys/kernel/perf_event_paranoid setting

+ tests/utils/check_paranoid

Checking /proc/sys/kernel/perf_event_paranoid setting...   PASSED



* Checking infrastructure

+ tests/utils/get_cache_info

Seeing if cache info is provided by the kernel...          PASSED

+ tests/sysfs/events

Testing format of event files under /sys/...               PASSED



* Checking generalized events

+ tests/generalized_events/branches

Testing "branches" generalized event...                    PASSED

+ tests/generalized_events/branch-misses

Testing "branch-misses" generalized event...               PASSED

+ tests/generalized_events/cycles

Testing "cycles" generalized event...                      PASSED

+ tests/generalized_events/instructions

Testing "instructions" generalized event...                PASSED

+ tests/generalized_events/l1-dcache-stores

Testing "L1-dcache-stores" generalized event...            FAILED

+ tests/generalized_events/l1-dcache-loads

Testing "L1-dcache-loads" generalized event...             FAILED



* Checking Intel x86 specific features

+ tests/x86_intel/fixed_ctr0

Testing fixed counter 0 event...                           PASSED

+ tests/x86_intel/fixed_ctr1

Testing fixed counter 1 event...                           PASSED

+ tests/x86_intel/fixed_ctr2

Testing fixed counter 2 event...                           PASSED

+ tests/x86_intel/offcore_response

Testing RAW access to offcore response counters...         PASSED

+ tests/x86_intel/offcore_response_mask

Testing if setting invalid offcore bits is blocked...      PASSED

+ tests/x86_intel/uncore_events

Testing uncore events...                                   PASSED



* Checking breakpoint support

+ tests/breakpoints/breakpoint_support

Testing hardware breakpoints...                            PASSED



* Checking basic perf_event functionality

+ tests/attr_fields/disabled

Testing disabled bit...                                    PASSED

+ tests/attr_fields/exclusive

Testing exclusive eventsets...                             FAILED

+ tests/attr_fields/format_id_support

Testing for FORMAT_ID support...                           PASSED

+ tests/attr_fields/inherit

Testing inherit...                                         PASSED

+ tests/attr_fields/inherit_stat

Testing inherit_stat...                                    UNEXPLAINED

+ tests/attr_fields/pinned

Testing pinned...                                          PASSED

+ tests/attr_fields/read_format_range_check

Testing attr->read_format invalid bits...                  PASSED

+ tests/attr_fields/sample_type_range_check

Testing attr->sample_type invalid bits...                  PASSED

+ tests/attr_fields/exclude_user

Testing exclude_user...                                    PASSED

+ tests/attr_fields/exclude_kernel

Testing exclude_kernel...                                  PASSED

+ tests/attr_fields/exclude_hv

Testing exclude_hv...                                      PASSED

+ tests/attr_fields/exclude_idle

Testing exclude_idle...                                    PASSED

+ tests/attr_fields/exclude_guest

Testing exclude_guest...                                   PASSED

+ tests/attr_fields/exclude_host

Testing exclude_host...                                    PASSED

+ tests/flags/flags_range_check

Testing flags invalid bits...                              PASSED

+ tests/flags/flags_cgroup

Testing PERF_FLAG_PID_CGROUP flag...                       SKIPPED

+ tests/flags/flags_fd_no_group

Testing PERF_FLAG_FD_NO_GROUP flag...                      PASSED

+ tests/flags/flags_fd_output

Testing PERF_FLAG_FD_OUTPUT flag...                        KNOWN KERNEL BUG

+ tests/socket/socket_pass

Testing passing fd over a socket...                        PASSED



* Checking attr.size behavior

+ tests/size/too_big

Testing attr > kernel supported size...                    PASSED

+ tests/size/too_little

Testing attr < kernel supported size...                    PASSED

+ tests/size/just_right

Testing attr is kernel supported size...                   PASSED

+ tests/size/header_mismatch

Testing header vs kernel attr size...                      PASSED



* Checking perf_event ioctl calls

+ tests/ioctl/ioctl_flag_group

Testing PERF_IOC_FLAG_GROUP...                             PASSED

+ tests/ioctl/ioctl_0_enable

Testing ioctl(PERF_EVENT_IOC_ENABLE)...                    PASSED

+ tests/ioctl/ioctl_1_disable

Testing ioctl(PERF_EVENT_IOC_DISABLE)...                   PASSED

+ tests/ioctl/ioctl_2_refresh

perf: interrupt took too long (2503 > 2500), lowering kernel.perf_event_max=
_sample_rate to 79000
Testing ioctl(PERF_IOC_REFRESH)...                         PASSED

+ tests/ioctl/ioctl_3_reset

Testing ioctl(PERF_IOC_RESET)...                           PASSED

+ tests/ioctl/ioctl_4_period

Testing ioctl(PERF_EVENT_IOC_PERIOD)...                    PASSED

+ tests/ioctl/ioctl_5_set_output

Testing PERF_EVENT_IOC_SET_OUTPUT ioctl...                 PASSED

+ tests/ioctl/ioctl_6_set_filter

Testing PERF_EVENT_IOC_SET_FILTER ioctl...                 PASSED

+ tests/ioctl/ioctl_7_id

Testing ioctl(PERF_EVENT_IOC_ID)...                        PASSED

+ tests/ioctl/ioctl_8_set_bpf

We are running release 6.13.0-rc1-00027-geca51ce01d49

Using LINUX_VERSION_CODE: 396544

Testing PERF_EVENT_IOC_SET_BPF ioctl...                    PASSED

+ tests/ioctl/ioctl_9_pause_output

perf: interrupt took too long (3174 > 3128), lowering kernel.perf_event_max=
_sample_rate to 63000
Testing ioctl(PERF_IOC_PAUSE_OUTPUT)...                    PASSED

+ tests/ioctl/ioctl_10_query_bpf

Testing PERF_EVENT_IOC_QUERY_BPF ioctl...                  PASSED

+ tests/ioctl/ioctl_11_modify_attributes

Testing ioctl(PERF_EVENT_IOC_MODIFY_ATTRIBUTES)...         PASSED



* Checking perf_event prctl calls

+ tests/prctl/prctl

Testing prctl()...                                         PASSED

+ tests/prctl/prctl_child

Testing if prctl() affects attached events...              PASSED

+ tests/prctl/prctl_parent

Testing if prctl() affects remote attached events...       PASSED

+ tests/prctl/prctl_inherit

Testing if prctl() affects inherited events...             PASSED

+ tests/prctl/prctl_attach

Testing if prctl() affects attached events...              PASSED



* Checking error returns

+ tests/error_returns/e2big

Testing E2BIG errors...                                    PASSED

+ tests/error_returns/eacces

Testing EACCES generation...                               PASSED

+ tests/error_returns/ebadf

Testing EBADF generation...                                PASSED

+ tests/error_returns/efault

Testing EFAULT generation...                               PASSED

+ tests/error_returns/einval

Testing EINVAL generation...                               PASSED

+ tests/error_returns/emfile

Testing if EMFILE can be triggered...                      PASSED

+ tests/error_returns/enoent

Testing ENOENT generation...                               FAILED

+ tests/error_returns/enospc

Testing ENOSPC generation...                               PASSED

+ tests/error_returns/eopnotsupp

Testing EOPNOTSUPP generation...                           PASSED

+ tests/error_returns/eoverflow

Testing EOVERFLOW generation...                            PASSED

+ tests/error_returns/eperm

Testing EPERM generation...                                PASSED

+ tests/error_returns/esrch

Testing ESRCH generation...                                PASSED

+ tests/error_returns/non-existent

	Failed with wrong error fd=3D-1 error 22 !=3D 2 Invalid argument!

Testing if non-existent events fail...                     FAILED



* Checking multithread functionality

+ tests/multithread/fork_then_read

Testing reads in forked children...                        PASSED



* Checking overflow functionality

+ tests/overflow/breakpoint_overflow

Testing hardware breakpoint overflow...                    PASSED

+ tests/overflow/simple_overflow_leader

Testing overflow on leaders...                             PASSED

+ tests/overflow/simple_overflow_sibling

Testing overflows on sibling...                            PASSED

+ tests/overflow/simultaneous_overflow

Testing multiple event overflow...                         PASSED

+ tests/overflow/simultaneous_group_overflow

perf: interrupt took too long (3987 > 3967), lowering kernel.perf_event_max=
_sample_rate to 50000
Testing multiple event overflow within group...            PASSED

+ tests/overflow/simul_oneshot_group_overflow

Testing simultaneous one-shot group overflow...            PASSED

+ tests/overflow/single_shot_overflow

Testing single shot overflow...                            PASSED

+ tests/overflow/single_shot_w_enable

Testing enable vs refresh signal types...                  PASSED

+ tests/overflow/wakeup_events_overflow

Testing wakeup events overflow...                          PASSED

+ tests/overflow/overflow_requires_wakeup

Testing if we overflow w/o setting wakeup...               PASSED

+ tests/overflow/overflow_poll

Testing catching overflow with poll()...                   PASSED

+ tests/overflow/overflow_large

Testing large sample_period...                             PASSED

+ tests/overflow/overflow_skid

Testing if we can skid into kernel...                      KNOWN KERNEL BUG



* Checking tracepoint functionality

+ tests/tracepoints/tracepoint_alias

Testing if tracepoint event ids alias...                   PASSED

perf: interrupt took too long (5010 > 4983), lowering kernel.perf_event_max=
_sample_rate to 39000


* Checking mmap record sample functionality

+ tests/record_sample/print_record_sample

Testing record sampling...                                 PASSED

+ tests/record_sample/validate_record_sample

Validating sample record overflow...                       PASSED

+ tests/record_sample/lost_record_sample

Checking behavior on mmap overflow...                      PASSED

+ tests/record_sample/multiple_mmap_sizes

Checking behavior of various mmap sizes...                 PASSED

+ tests/record_sample/sample_branch_stack

Testing PERF_SAMPLE_BRANCH_STACK...                        PASSED

+ tests/record_sample/record_comm

Testing PERF_RECORD_COMM...                                PASSED

+ tests/record_sample/record_comm_exec

Testing PERF_RECORD_COMM_EXEC...                           PASSED

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ tests/record_sample/record_fork
BUG: KASAN: null-ptr-deref in perf_mmap_to_page+0x1b/0x150
Read of size 4 at addr 0000000000000178 by task record_mmap/2618


CPU: 0 UID: 0 PID: 2618 Comm: record_mmap Not tainted 6.13.0-rc1-00027-geca=
51ce01d49 #1
Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.8.1 12/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x62/0x90
Testing PERF_RECORD_FORK...                                PASSED
kasan_report+0xb9/0xf0
? perf_mmap_to_page+0x1b/0x150

perf_mmap_to_page+0x1b/0x150
perf_mmap+0x5cb/0xda0
? __init_rwsem+0xd4/0xf0
+ tests/record_sample/record_mmap
__mmap_new_vma+0x1f9/0x5f0
__mmap_region+0x52e/0x950

? __pfx___mmap_region+0x10/0x10
? lock_is_held_type+0x9a/0x110
? vm_unmapped_area+0x2b6/0x470
? lock_acquire+0x123/0x2e0
? mm_get_unmapped_area_vmflags+0x4d/0xa0
mmap_region+0x136/0x170
do_mmap+0x6a2/0x810
? __pfx_do_mmap+0x10/0x10
? down_write_killable+0x131/0x1d0
? __pfx_down_write_killable+0x10/0x10
? __fget_files+0x114/0x1f0
vm_mmap_pgoff+0x184/0x280
? __pfx_vm_mmap_pgoff+0x10/0x10
? __fget_files+0x11e/0x1f0
ksys_mmap_pgoff+0x1a9/0x2b0
do_syscall_64+0x8c/0x170
? __up_write+0xec/0x2c0
? vm_mmap_pgoff+0x1df/0x280
? __pfx_vm_mmap_pgoff+0x10/0x10
? put_ctx+0x20/0x120
? mark_held_locks+0x24/0x90
? lockdep_hardirqs_on_prepare+0x131/0x200
? syscall_exit_to_user_mode+0xa2/0x2a0
? do_syscall_64+0x98/0x170
? __kasan_slab_alloc+0x2f/0x70
? rcu_is_watching+0x1c/0x50
? lockdep_init_map_type+0xcf/0x340
? __rwlock_init+0x80/0xa0
? file_f_owner_allocate+0x90/0xc0
? do_fcntl+0x484/0x9b0
? __pfx_do_fcntl+0x10/0x10
? mark_held_locks+0x24/0x90
? lockdep_hardirqs_on_prepare+0x131/0x200
? syscall_exit_to_user_mode+0xa2/0x2a0
? do_syscall_64+0x98/0x170
? mark_held_locks+0x24/0x90
? lockdep_hardirqs_on_prepare+0x131/0x200
? syscall_exit_to_user_mode+0xa2/0x2a0
? do_syscall_64+0x98/0x170
? do_user_addr_fault+0x3f6/0x790
? __rcu_read_unlock+0x65/0x90
? do_user_addr_fault+0x400/0x790
? mark_held_locks+0x24/0x90
? lockdep_hardirqs_on_prepare+0x131/0x200
entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f9dbc1c88a3
Code: ef e8 d1 b4 ff ff eb e7 e8 3a 68 01 00 66 2e 0f 1f 84 00 00 00 00 00 =
41 89 ca 41 f7 c1 ff 0f 00 00 75 14 b8 09 00 00 00 0f 05 <48> 3d 00 f0 ff f=
f 77 25 c3 0f 1f 40 00 48 8b 05 29 05 0d 00 64 c7
RSP: 002b:00007ffd7c31e008 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007ffd7c31e318 RCX: 00007f9dbc1c88a3
RDX: 0000000000000003 RSI: 0000000000009000 RDI: 0000000000000000
RBP: 00007ffd7c31e070 R08: 0000000000000004 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd7c31e328 R14: 000055886087cdd8 R15: 00007f9dbc2e7020
</TASK>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Disabling lock debugging due to kernel taint
BUG: kernel NULL pointer dereference, address: 0000000000000178
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0=20
Oops: Oops: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 2 UID: 0 PID: 2618 Comm: record_mmap Tainted: G    B              6.13=
.0-rc1-00027-geca51ce01d49 #1
Tainted: [B]=3DBAD_PAGE
Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.8.1 12/05/2017
RIP: 0010:perf_mmap_to_page+0x1b/0x150
Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 41 54 55 =
48 89 f5 53 48 89 fb 48 81 c7 78 01 00 00 e8 65 c4 17 00 <4c> 63 a3 78 01 0=
0 00 45 85 e4 74 29 48 8d bb 70 01 00 00 e8 ad c5
RSP: 0018:ffff8887ed2af400 EFLAGS: 00010282
RAX: 0000000000000001 RBX: 0000000000000000 RCX: ffffffff81144e06
RDX: fffffbfff0cf8609 RSI: 0000000000000008 RDI: ffffffff867c3040
RBP: 0000000000000000 R08: 0000000000000001 R09: fffffbfff0cf8608
R10: ffffffff867c3047 R11: 0000000000000001 R12: 0000000000000000
R13: ffff8887eff9af70 R14: 00007f9dbc0b2000 R15: 0000000000000000
FS:  00007f9dbc0c4740(0000) GS:ffff88874c700000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000178 CR3: 00000001092a4004 CR4: 00000000003726f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
<TASK>
? __die+0x1f/0x60
? page_fault_oops+0x8d/0xc0
? exc_page_fault+0x57/0xe0
? asm_exc_page_fault+0x22/0x30
? add_taint+0x26/0x90
? perf_mmap_to_page+0x1b/0x150
perf_mmap+0x5cb/0xda0
? __init_rwsem+0xd4/0xf0
__mmap_new_vma+0x1f9/0x5f0
__mmap_region+0x52e/0x950
? __pfx___mmap_region+0x10/0x10
? lock_is_held_type+0x9a/0x110
? vm_unmapped_area+0x2b6/0x470
? lock_acquire+0x123/0x2e0
? mm_get_unmapped_area_vmflags+0x4d/0xa0
mmap_region+0x136/0x170
do_mmap+0x6a2/0x810
? __pfx_do_mmap+0x10/0x10
? down_write_killable+0x131/0x1d0
? __pfx_down_write_killable+0x10/0x10
? __fget_files+0x114/0x1f0
vm_mmap_pgoff+0x184/0x280
? __pfx_vm_mmap_pgoff+0x10/0x10
? __fget_files+0x11e/0x1f0
ksys_mmap_pgoff+0x1a9/0x2b0
do_syscall_64+0x8c/0x170
? __up_write+0xec/0x2c0
? vm_mmap_pgoff+0x1df/0x280
? __pfx_vm_mmap_pgoff+0x10/0x10
? put_ctx+0x20/0x120
? mark_held_locks+0x24/0x90
? lockdep_hardirqs_on_prepare+0x131/0x200
? syscall_exit_to_user_mode+0xa2/0x2a0
? do_syscall_64+0x98/0x170
? __kasan_slab_alloc+0x2f/0x70
? rcu_is_watching+0x1c/0x50
? lockdep_init_map_type+0xcf/0x340
? __rwlock_init+0x80/0xa0
? file_f_owner_allocate+0x90/0xc0
? do_fcntl+0x484/0x9b0
? __pfx_do_fcntl+0x10/0x10
? mark_held_locks+0x24/0x90
? lockdep_hardirqs_on_prepare+0x131/0x200
? syscall_exit_to_user_mode+0xa2/0x2a0
? do_syscall_64+0x98/0x170
? mark_held_locks+0x24/0x90
? lockdep_hardirqs_on_prepare+0x131/0x200
? syscall_exit_to_user_mode+0xa2/0x2a0
? do_syscall_64+0x98/0x170
? do_user_addr_fault+0x3f6/0x790
? __rcu_read_unlock+0x65/0x90
? do_user_addr_fault+0x400/0x790
? mark_held_locks+0x24/0x90
? lockdep_hardirqs_on_prepare+0x131/0x200
entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f9dbc1c88a3
Code: ef e8 d1 b4 ff ff eb e7 e8 3a 68 01 00 66 2e 0f 1f 84 00 00 00 00 00 =
41 89 ca 41 f7 c1 ff 0f 00 00 75 14 b8 09 00 00 00 0f 05 <48> 3d 00 f0 ff f=
f 77 25 c3 0f 1f 40 00 48 8b 05 29 05 0d 00 64 c7
RSP: 002b:00007ffd7c31e008 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007ffd7c31e318 RCX: 00007f9dbc1c88a3
RDX: 0000000000000003 RSI: 0000000000009000 RDI: 0000000000000000
RBP: 00007ffd7c31e070 R08: 0000000000000004 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd7c31e328 R14: 000055886087cdd8 R15: 00007f9dbc2e7020
</TASK>
Modules linked in: intel_rapl_msr intel_rapl_common btrfs snd_hda_codec_hdm=
i blake2b_generic x86_pkg_temp_thermal xor intel_powerclamp zstd_compress c=
oretemp raid6_pq libcrc32c snd_ctl_led snd_soc_avs snd_hda_codec_realtek sn=
d_soc_hda_codec snd_hda_codec_generic snd_hda_ext_core snd_hda_scodec_compo=
nent kvm_intel snd_soc_core dell_pc platform_profile snd_compress sd_mod kv=
m snd_hda_intel dell_wmi snd_intel_dspcfg crct10dif_pclmul snd_intel_sdw_ac=
pi crc32_pclmul sg i915 crc32c_intel dell_smbios snd_hda_codec ghash_clmuln=
i_intel snd_hda_core snd_hwdep snd_pcm mei_wdt rapl cec intel_cstate wmi_bm=
of drm_buddy rfkill sparse_keymap snd_timer ipmi_devintf dell_wmi_descripto=
r dcdbas ipmi_msghandler snd i2c_i801 soundcore intel_uncore ttm i2c_smbus =
pcspkr drm_display_helper ahci drm_kms_helper libahci intel_gtt mei_me agpg=
art libata video intel_pmc_core mei intel_pch_thermal intel_vsec acpi_pad w=
mi pmt_telemetry pmt_class binfmt_misc drm dm_mod ip_tables x_tables sch_fq=
_codel
CR2: 0000000000000178
---[ end trace 0000000000000000 ]---
RIP: 0010:perf_mmap_to_page+0x1b/0x150
Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 41 54 55 =
48 89 f5 53 48 89 fb 48 81 c7 78 01 00 00 e8 65 c4 17 00 <4c> 63 a3 78 01 0=
0 00 45 85 e4 74 29 48 8d bb 70 01 00 00 e8 ad c5
RSP: 0018:ffff8887ed2af400 EFLAGS: 00010282
RAX: 0000000000000001 RBX: 0000000000000000 RCX: ffffffff81144e06
RDX: fffffbfff0cf8609 RSI: 0000000000000008 RDI: ffffffff867c3040
RBP: 0000000000000000 R08: 0000000000000001 R09: fffffbfff0cf8608
R10: ffffffff867c3047 R11: 0000000000000001 R12: 0000000000000000
R13: ffff8887eff9af70 R14: 00007f9dbc0b2000 R15: 0000000000000000
FS:  00007f9dbc0c4740(0000) GS:ffff88874c700000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000178 CR3: 00000001092a4004 CR4: 00000000003726f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Kernel panic - not syncing: Fatal exception
Kernel Offset: disabled
No EFI environment detected.
early console in extract_kernel
input_data: 0x000000081bec62cc
input_len: 0x000000000197949a
output: 0x0000000816000000
output_len: 0x00000000077a6d68
kernel_total_size: 0x0000000006a30000
needed_size: 0x0000000007800000
trampoline_32bit: 0x0000000000000000


KASLR disabled: 'nokaslr' on cmdline.



--cPUXwabp04B8QD1l
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job.yaml"

---

#! /db/releases/20241203102937/lkp-src/jobs/perf-event-tests.yaml
suite: perf-event-tests
testcase: perf-event-tests
category: functional
perf-event-tests:
  paranoid: not_paranoid_at_all
job_origin: perf-event-tests.yaml
arch: x86_64

#! include/category/functional
kmsg:
heartbeat:
meminfo:

#! include/category/ALL
sanity-check:

#! programs/perf-event-tests/include
initrds:
- linux_headers

#! queue options
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-skl-d05
tbox_group: lkp-skl-d05
branch: linux-next/master
commit: eca51ce01d4956ab4b8f06bb55c031f4913fffcb
job_file: "/lkp/jobs/scheduled/lkp-skl-d05/perf-event-tests-not_paranoid_at_all-debian-12-x86_64-20240206.cgz-eca51ce01d49-20241207-21354-b34j8-1.yaml"
id: b3ebf8d1df417274ccfd33ebd2b4bfc387b3ad80
queuer_version: "/zday/lkp"

#! hosts/lkp-skl-d05
model: Skylake
nr_cpu: 4
memory: 32G
nr_ssd_partitions: 1
nr_hdd_partitions: 4
hdd_partitions: "/dev/disk/by-id/wwn-0x5000c50091e544de-part*"
ssd_partitions: "/dev/disk/by-id/wwn-0x55cd2e4151977e28-part2"
rootfs_partition: "/dev/disk/by-id/wwn-0x55cd2e4151977e28-part1"
brand: Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz
need_kconfig_hw:
- PTP_1588_CLOCK: "y"
- E1000E: "y"
- SATA_AHCI
- DRM_I915
ucode: '0xf0'
rootfs: debian-12-x86_64-20240206.cgz
kconfig: x86_64-rhel-9.4-bpf
enqueue_time: 2024-12-07 16:30:01.185463319 +08:00
compiler: gcc-12
_rt: "/result/perf-event-tests/not_paranoid_at_all/lkp-skl-d05/debian-12-x86_64-20240206.cgz/x86_64-rhel-9.4-bpf/gcc-12/eca51ce01d4956ab4b8f06bb55c031f4913fffcb"

#! schedule options
user: lkp
LKP_SERVER: internal-lkp-server
scheduler_version: "/lkp/lkp/src"
max_uptime: 1200
initrd: "/osimage/debian/debian-12-x86_64-20240206.cgz"
bootloader_append:
- root=/dev/ram0
- RESULT_ROOT=/result/perf-event-tests/not_paranoid_at_all/lkp-skl-d05/debian-12-x86_64-20240206.cgz/x86_64-rhel-9.4-bpf/gcc-12/eca51ce01d4956ab4b8f06bb55c031f4913fffcb/0
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-9.4-bpf/gcc-12/eca51ce01d4956ab4b8f06bb55c031f4913fffcb/vmlinuz-6.13.0-rc1-00027-geca51ce01d49
- branch=linux-next/master
- job=/lkp/jobs/scheduled/lkp-skl-d05/perf-event-tests-not_paranoid_at_all-debian-12-x86_64-20240206.cgz-eca51ce01d49-20241207-21354-b34j8-1.yaml
- user=lkp
- ARCH=x86_64
- kconfig=x86_64-rhel-9.4-bpf
- commit=eca51ce01d4956ab4b8f06bb55c031f4913fffcb
- intremap=posted_msi
- max_uptime=1200
- LKP_SERVER=internal-lkp-server
- nokaslr
- selinux=0
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw
modules_initrd: "/pkg/linux/x86_64-rhel-9.4-bpf/gcc-12/eca51ce01d4956ab4b8f06bb55c031f4913fffcb/modules.cgz"
linux_headers_initrd: "/pkg/linux/x86_64-rhel-9.4-bpf/gcc-12/eca51ce01d4956ab4b8f06bb55c031f4913fffcb/linux-headers.cgz"
bm_initrd: "/osimage/deps/debian-12-x86_64-20240206.cgz/lkp_20241102.cgz,/osimage/deps/debian-12-x86_64-20240206.cgz/rsync-rootfs_20241102.cgz,/osimage/deps/debian-12-x86_64-20240206.cgz/run-ipconfig_20241102.cgz,/osimage/deps/debian-12-x86_64-20240206.cgz/perf-event-tests_20241102.cgz,/osimage/pkg/debian-12-x86_64-20240206.cgz/perf-event-tests-x86_64-a052241-1_20241102.cgz,/osimage/deps/debian-12-x86_64-20240206.cgz/hw_20241102.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20230906.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /db/releases/20241204090034/lkp-src/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
job_initrd: "/lkp/jobs/scheduled/lkp-skl-d05/perf-event-tests-not_paranoid_at_all-debian-12-x86_64-20240206.cgz-eca51ce01d49-20241207-21354-b34j8-1.cgz"
last_kernel: 6.13.0-rc1-00008-gf87326dedd3a
acpi_rsdp: '0x000f05b0'

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-9.4-bpf/gcc-12/eca51ce01d4956ab4b8f06bb55c031f4913fffcb/vmlinuz-6.13.0-rc1-00027-geca51ce01d49"
result_root: "/result/perf-event-tests/not_paranoid_at_all/lkp-skl-d05/debian-12-x86_64-20240206.cgz/x86_64-rhel-9.4-bpf/gcc-12/eca51ce01d4956ab4b8f06bb55c031f4913fffcb/0"
dequeue_time: 2024-12-07 16:54:15.130226701 +08:00
job_state: running

--cPUXwabp04B8QD1l--
