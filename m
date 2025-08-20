Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1319A2D3A74;
	Wed, 20 Aug 2025 07:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755674261; cv=fail; b=V9FtWp+hMewklJ9cak+wLtOtYZTIy6GYDaXidKPQqsaHzl0pvZzbCYTyJmLc/tLc+NnVVb0a9NC+g8/twKTafzR4lgie9K9VQl2gPlSM8YhQaGEgtG3OC7FxnkMOrGceQwlR6z1XrfbZx/fQHhIOTy2logRdiDaJlGZcbGVR5wU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755674261; c=relaxed/simple;
	bh=7H+Uy0A5s9V2bkRkncnODuYzGlOTEmuMU18X2+2C0xk=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ke0NfmS1eLxf0urkZKPPHT2bCuMBDiVfGERn0xqXU3K6Cic5ziIZriaZWfdsXvUXZvBeZmXkuRsZGYvLe+ihFMdIsuR6On2V8IMU82hcDoNjtO1RbslP39x/1ORSXMGh3GKiEf0ZfSZBHiIdxlMaNG/CX7jVxCIWLmDI+/APvr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c5pRgqVq; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c5pRgqVq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755674260; x=1787210260;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=7H+Uy0A5s9V2bkRkncnODuYzGlOTEmuMU18X2+2C0xk=;
  b=c5pRgqVq5nywqokEshxcMPjN6tqlz4hAJe1e/yL67UjEq6Hd18pAhohp
   Y7QwGSp6JU1rKrwxIw2kuTQ97w7mcn1haWtSpYRGEYmE0c5tRGWz8Xjk+
   Y6Al59mb9SmXSFQLjcn+46U9WCKZJ6zyPWT2nv+y9AlqgTKMCtUDoHF0z
   n9Dx6w6iFauWoILIUH/Owtoni0QX298Tib/x9qgNAZQTOMA2b99y45gTK
   EhdkmXJduG9/c6EdLtM7D64gGk9il01K6n+z8VKRz1aDjKZzlfwUZKYpq
   Q1fxsLF2lub7N7aCitMMru/5HLB2gNCPRDhNw86YHp/kqRI8TEAt2YCjY
   g==;
X-CSE-ConnectionGUID: ynmuwa5IQAGd41gQ8T+NSg==
X-CSE-MsgGUID: WwQ3T0QERbW9hCORQY7qbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="75382281"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="75382281"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 00:17:39 -0700
X-CSE-ConnectionGUID: MGYXovuzSeCwUeqVNUH41g==
X-CSE-MsgGUID: 1veZT+wISpKgBxJqlzpT9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="167672457"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 00:17:39 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 00:17:38 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 20 Aug 2025 00:17:38 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.55) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 00:17:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GpifflWgWiIhyV/2AHmTlI8JcRGETFyDIaoUehH3fGOT9jSmdCgZdhg6xo8CbKw+JxO8wrIuHjwZmBrYvAvuXLPw0CVE6gZcnPdGVN0B/FAR4UFeVCdrtRCHH1xfyEPST1qJI9NZq9QH3V9gPTH5qvI7jtK1sQaRqb5jIcFrTk170JPm/JTSaAag/ewlVFGlIBcwfYpShfT0X9oYGtgcFOhbnZTTrFjtL+w148epcrfqOJIRXt200rDntMHGw+ZrK4J+ajzzdJkqQKNqg0XUeueRg1dWpAInZRzDpVFzmxSAVS28lvz3pQ7q2acHC2ArvFxuJVlQ87KjLLUIr/z2Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQaXgJGHL79j+/mNjoCmbrqtYR5yOXepGV32cBfsnCE=;
 b=OCoj/eRf/A6MNEmcW2fW2wYZC5JsjcFzH5fSr7jjvVhXhhyuypirDp9ROuX9phHDp+ezioATIUy7A0EFeGP3hknsh2LL5LTAObVrJDYc2KAT4fTqT2NKPjgKeqLRlrdARujGCvIZACkBhT9NQOb7aR4x0VAoai/3mYyAWW+HgLGHPA/fOsUHN/bRbmna/0Dio27trO62KGjlZXhRQKc/dYajWp0gxXa/N4gy+fCxxkUTT3frTIaLiV5IZ9xq7QqhFmOJ/3vetUNxRU4qO79qJ2KYyqPpzGwBah2KrOnPYSyRJoOuZo4xskBAUbmKz7g179REGtEIxz9LLlz64qHZ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA1PR11MB7917.namprd11.prod.outlook.com (2603:10b6:208:3fe::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 07:17:36 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9052.013; Wed, 20 Aug 2025
 07:17:36 +0000
Date: Wed, 20 Aug 2025 15:17:25 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Chengdong Li <chengdongli@optimatist.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	Chengdong Li <chengdongli@optimatist.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH] perf/core: Improve arguments checking of inherited
 per-task counters when sampling.
Message-ID: <202508200832.1aec09e3-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250814110625.84622-1-chengdongli@optimatist.com>
X-ClientProxiedBy: SG2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:3:18::35) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA1PR11MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: e4276ca1-0c8b-4545-4f1e-08dddfb9a393
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zRtbYfw+OrTqzJ2Otx4+KnS7CknnHnEbggd817MzeLSyl0DGSHqWA/DJYKhD?=
 =?us-ascii?Q?MxslvmzCnTX3s04hRVCl614lc0LXUfAFutF9k04SrIdtvuCP2SSwfE9c8lw8?=
 =?us-ascii?Q?eehWMmrXGCuIV2WYmTCSkqQfcgYffv6i0WjUifVxMk/6V3ulEEXawDFnlNXj?=
 =?us-ascii?Q?YHqXWzXXULeHqctNXYc7UuK2nW4gWyeG7A5A4V+g/vyaNpmu3BSo6Cud55W7?=
 =?us-ascii?Q?6xBxS9TufKePbilUuK1OLpoC6+hunGzwiUeD1sx38IFoT1X/2tVNdxvryf0B?=
 =?us-ascii?Q?YZ6UAr/9zu7CPPbrYE3M7xs96wZ7tXN9aEmaumd9iI4Fh30Lsq1ZZzXXFKqy?=
 =?us-ascii?Q?a56Pi8vTJFDsBLk4UYNtStxrmrraTLwWLdcs1WVfuRzhxCA6UPj+2K5JerCo?=
 =?us-ascii?Q?vg39WUnvuatrmNbOLGg5CCYPoiWG9IeVO5SCj2a/x9SnyBalcF5qVNgW730A?=
 =?us-ascii?Q?r+XmEeTK6ekBcCeODJA2Tj5eS3GqXNLWV4YjuRr8lAOZEzAM1O2TLXBLcvS7?=
 =?us-ascii?Q?slmFQ+565tY6eU5JXsT+lKyVJs+TaWXew/JCcmwPDcldTO8dBkncldnNdAR6?=
 =?us-ascii?Q?7GnjYmHVBvjNT0sxH4DBV87WaBNW1eZqSbuWYVDDd3NmLChyeasfiJ1UaKMu?=
 =?us-ascii?Q?cdIBR3qCBu9g16YMMpkaYXgBMh9HifUX0DCUTjL2g6YB2t+Ox9NkzoeaKg0Q?=
 =?us-ascii?Q?37v5eRGHw76M4ImcQbmiWJuW1fTby0A4SXWJaSxr6DeC/LQP1KSpCRKNDeM6?=
 =?us-ascii?Q?XQISouOAfXQ/QcP/nQrBzye9osLCj5mQEEjA0vfWmeLLxZSLVKHy6jrDEUCN?=
 =?us-ascii?Q?kkn4OtRfYjUY7zi4If4WINI/TySEJLCfrRyO1LFFBqPz+jIED0KYqjd26o2Z?=
 =?us-ascii?Q?w2VD5L/b4q6fFxII7wLBPtwzcWKI9AGEXjxqvK4jzeXCLa77XxK+RHb49TRB?=
 =?us-ascii?Q?NaE1DICaecNg9lxGDjlp1gV0Uy9QH2VoEvscr031af/ac2b+qivms5qyYtJn?=
 =?us-ascii?Q?JNK955eGJwH0ybYII0VExeCXihViR6c0E/0+RxJbpbpo46sizPhrDgjNzDA4?=
 =?us-ascii?Q?130tf13OCWmM6wfoL3McsyOkgWuPwiACnkDskbQHUnfo7qv2Dl6jdWBG36Yz?=
 =?us-ascii?Q?HRtNL6WDMfeSJw/3EXw4f7dS1juIgAmvEk9ZXeNHDcda9SFy8b2UwyrmwMtM?=
 =?us-ascii?Q?w3d+MbprGkp0tmAl8atyGV5tzVYrR/uORAneN5m5sE8b8gwAwJEXb1nmHBZE?=
 =?us-ascii?Q?X7ws+ybfoWUFdEvsNIpo4ZiQ0JGHi7oL2TdweygeEUU9itwc8fBSum1l0nb1?=
 =?us-ascii?Q?3pAnvm9/wDA1utCHMR94Jtrew2GWAraja11AEkaUZwuecc0kfxRtcWAJX/SZ?=
 =?us-ascii?Q?zfozBReACYWQrTUAbJYXuMw6AhGt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bn0I1zVjxXIyNjFrU4uLoiGzoDfAySwINfLnvV943NotVfZMSQFJZ+wVAJuX?=
 =?us-ascii?Q?lUXsDDzQlnxBdf/QHrJZJqPwzSoVlxbFXbriI4W4pobLzLWVkzCN8BLC1Umf?=
 =?us-ascii?Q?kzLKOf7KCMcQ8XLwiLQRKe832KeG3mdkLCa/DqmzuQ/4CbTB1OlCKWm6M+sx?=
 =?us-ascii?Q?A01bE2IGIXct62xmo/gbNYk+WUNNDekZ5lm1+krpOXIElwfKtUUJCM3UJl5p?=
 =?us-ascii?Q?Ej000O4/eHoXPdPlYFGVH60yFnYaEQMA+RXfy8g/FUCkuwNMGrss6JyFy3lZ?=
 =?us-ascii?Q?NR+LtBEyJKaozlBKryFVpYCjYqRiatI1BYNnw5uXt/t8dL3AWJO11mo3r2ni?=
 =?us-ascii?Q?HHZJKLBUI0JlIFBYM15HZUJCiWxqSpvPCbT1D9Wn8bisgr+LB2NoVWtsvRcW?=
 =?us-ascii?Q?3qoLQvdZDRtvHj2pazzASOwjuOxaif14ErLxqo7LbfhyZoAXxGOX85HDztzS?=
 =?us-ascii?Q?Bp1o+ZGkCzDnKGCri7DukQIvXpFFle9IyodDn+LAFTONjJ5Vm5DDBOBWfQk/?=
 =?us-ascii?Q?fhq03/eLjheJX6d4cyxZNq/5wy7QGQL9knrD9g0Vk4YpTzIKrGjZGtf7zsIm?=
 =?us-ascii?Q?0lHR5yoyRjsCKhhDiuiw9u/3yBJ3I6cDLMx0QPcOaeVBGcldOEfb+vuqsNU4?=
 =?us-ascii?Q?F71WOtzp7SzgcYqNdmW3aPpI5w2nJ3USBy2JKPeu/DHHy6isqfmnv3cakkcp?=
 =?us-ascii?Q?yoBeev2Ak+hbAZuCHHyH5kKhIfZ4sga+jtYd/J35RaWVDqe5wPpaIFMbO88t?=
 =?us-ascii?Q?AIzfN5Q8UXTNb+9lCtC3+oueEsYYqF4bjX5YhyKbgtnbElaYkSfGRy2ktKrc?=
 =?us-ascii?Q?Jl614GPPNJRrNmXGwJ2GGgTsDs92owX2ks0SF+oTD1IUxsIcd0Lrl/6TO2ZJ?=
 =?us-ascii?Q?GJTvxvND0z8FG5abCK+SPNW31R+qn1uOSpNYLrsn9K2bLHHiIl0ffZV7k8pK?=
 =?us-ascii?Q?2qfMiDPUVIUTw5NnQ80Mm6ZM0ks1tTN5xB+sB7rr85DjE7OftaOEqX3LYI3k?=
 =?us-ascii?Q?aCgQIFT5MIscdJIBJ7RwSJ0ov8Y5ZXQr3cdu3mosDFGYtRBcfisowznAXY9q?=
 =?us-ascii?Q?ClMlVJNwf8XSeEC+Diyfinp/SVirrMsqROnNJ2zCC19esqsXYV+YAcsFbFMj?=
 =?us-ascii?Q?lqThIPLwGzED/paHjW6H9jk6FNhh+kgMFPENl/fTGQ82UuqBfXvy+EPxPi76?=
 =?us-ascii?Q?g1zCUydOanhuU85iY0Pmsb/PMyjvba8BUb/qIWWykQxRyceaYCcFG4FU0v9v?=
 =?us-ascii?Q?WhPvje7pOdtjDQZbODnEoFvFi6ghjn8qf5jXSTchR/Mb/w1YDnwI3h5My84O?=
 =?us-ascii?Q?Gzb0AtYCl8jVU+JJLuHCoMdO3gLElVCJBReF9jQ8AAj0Vu3RE1KLtrpaW5pW?=
 =?us-ascii?Q?aJvWJ56aWwJN/AI6njyswtvoBYuk7iaaiPqzRzD9x4DX3c9/Eg/Qi31mONd2?=
 =?us-ascii?Q?4JnFw4+lhW9Kc1z0UyOnWwlp9JrF2jq9u4RXxVYBu0Z5Wy5bWmPOy+sUwHKV?=
 =?us-ascii?Q?5+wobgiK2GnDw6D6jK12KKBmBABMcssqfi6RmvV6kmKfK6rB4y7s14x7NXav?=
 =?us-ascii?Q?6w6p65SBnehT6pAv7xjCCJUoSn5d2FWkFD9CoEu4YVK3TqbneA4nvuvmZkbL?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e4276ca1-0c8b-4545-4f1e-08dddfb9a393
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 07:17:36.4185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pUtMi7BQkRzykfSMnhJcYtgASEFR+b3R2X3SN5H3JGPTy66og19vzAFDZjJEjtglloJvK5c7IpdKxfasuA9jYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7917
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "perf-sanity-tests.Sigtrap.fail" on:

commit: d692062da890da0c9f0c6bb2d7818c635eecd2d7 ("[PATCH] perf/core: Improve arguments checking of inherited per-task counters when sampling.")
url: https://github.com/intel-lab-lkp/linux/commits/Chengdong-Li/perf-core-Improve-arguments-checking-of-inherited-per-task-counters-when-sampling/20250814-190823
base: https://git.kernel.org/cgit/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
patch link: https://lore.kernel.org/all/20250814110625.84622-1-chengdongli@optimatist.com/
patch subject: [PATCH] perf/core: Improve arguments checking of inherited per-task counters when sampling.

in testcase: perf-sanity-tests
version: 
with following parameters:

	perf_compiler: gcc
	group: group-01



config: x86_64-rhel-9.4-bpf
compiler: gcc-12
test machine: 20 threads 1 sockets (Commet Lake) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202508200832.1aec09e3-lkp@intel.com


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250820/202508200832.1aec09e3-lkp@intel.com


2025-08-18 01:23:06 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-d692062da890da0c9f0c6bb2d7818c635eecd2d7/tools/perf/perf test 65 -v
 65: Sigtrap                                                         : Running (1 active)
--- start ---
test child forked, pid 7414
FAILED sys_perf_event_open(): Invalid argument
---- end(-1) ----
 65: Sigtrap                                                         : FAILED!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

