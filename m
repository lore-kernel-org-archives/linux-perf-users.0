Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6742B30749E;
	Fri,  4 Jul 2025 13:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751637201; cv=fail; b=oC1dvsSHAQ4BWrCDJ0+3Qja2XrItctrDapeah9zjM7KZOzU8AgAUPmihxxHiBXo1DEWdZ+Xb9qmL80SrLbzb/ULftww6G68QcLdWegxWOcfE9SsrMW5ouM46ozAcmee8fTj7GxzN7T2kOoKg1a+iQp6ug0qPPcLw/GY6lcaoj1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751637201; c=relaxed/simple;
	bh=WRtwiSIHX021XmiQEX7y1dJ9rPqLdC6aZzFD1Z44i+Y=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=nwlyeRxsMdPGqHGf6VmmNYvNYSCV4XnvM4MifPGCu6tnbvUpVkpmmW/7rzEHmKyzFNcAHKqpQ5hjXw5C75qpess/8ZKCQnkGAgXlUCOcCitOS8Wec27vpIjAV8MnZWQY2K6WuNB+yOXKUyoxELcp716VCDObW227+zOxbdR46Xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XxvF0jW+; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XxvF0jW+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751637198; x=1783173198;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WRtwiSIHX021XmiQEX7y1dJ9rPqLdC6aZzFD1Z44i+Y=;
  b=XxvF0jW+HvkwJZdV1Dn1gYIQcDcaMY9U8pV45qo65ZnHCRJacslwv/6Z
   68Sd8nUuxa87Jg3DCZnCvrpS1XUg/9HR3WSrKJmuBg6mtpWZSSSehTLh4
   +OLTX9sw37tGIpvTh5aAmkz6w5NVldNCCzQhtwA6W788JS4TvPr1plRSZ
   mUa3jY78zWsapfbJrC5JWrwlCYzNrwDPIywVH2FGqD/vfdUyMyv4g8bUH
   gd7hdgcysvdzE+z+ASGc4DAdJ5SCjdxmWDppRwNlO+4QTCKomx8qkRcJ8
   4cMtNc8FFflDeMChaXE6+SJqJPuJdqWKjo7xB45TVyCY7piBSe2331ZJ9
   Q==;
X-CSE-ConnectionGUID: FF8mfmARTsGcHXY8S2DGKQ==
X-CSE-MsgGUID: I57XOQsbR2m4DwoIScRBDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11484"; a="79413190"
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; 
   d="scan'208";a="79413190"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 06:53:18 -0700
X-CSE-ConnectionGUID: Iw6Fs36JSwWa15Y/WgN1jA==
X-CSE-MsgGUID: aIvxvQiFS6qJrA40t6cBxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; 
   d="scan'208";a="155010120"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 06:53:18 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 4 Jul 2025 06:53:17 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 4 Jul 2025 06:53:17 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.74)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 4 Jul 2025 06:53:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qd99baUactjp8BK+nFAYBfVOiInqVipKneyqNIuvOUtl4GPNrFcny8invjFtIQgYxqso7iJYcyIjlNNbwaercbxfjqnI6Gq3e5Pr5UhhrhEe6tbnSBcHuvwZ8cysgLEWZir7jlsyMNG0qE0sesHrseRNyyPKuGNu5sNTPPAMZNBn1XhzTmoWpQHGuccdaTQ1Dk8V1MVMhIplWQMU88R+Hm8oDT222/YBYr0QVlpZxW+dC7ZZzqPcBkzqUyxOOWZguNvPxb+ZSqmaEr+oxNdGBr5PupprnW9Syy0qr5lN4P7XNA5BYUGahawYXTxx111j4CAfNATyiKy2NuCVOS6cbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbwTNL/CfTi6nIaku/0BrorVI9NEuF0YKWzmWwDuyic=;
 b=o5D+DIN4EILEWT2ljjFKIWyhVAwK1pItsX3cN2n6cKVdRprieG6IUD/I5ViTgwTI+20N7LB04BpWhkTRvXL86osFV4rIVtFscm3kBl4JigvEOEnxgOfMiA0gTkztPOO9RyWxBuLVfxHUondJIQCoWyDkCCoXxKS5kiZuueOteLkzUOu8/XNejdDfybUY5dZ+Wm/qN6eTaydAi1gbELD6qjhG/Sdm5q3JhnWz8xVW57G8av3HftXRJiEsaiKuPgcntSv1cnN7OkiPf7Y0Z0a3o4NGp8Hd1mWfGFIwC8x8W2CWOvky1RznyNMGOMk+4n6AexHr4sS1nCt6syfuFFfbig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SN7PR11MB6797.namprd11.prod.outlook.com (2603:10b6:806:263::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Fri, 4 Jul
 2025 13:52:55 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8901.018; Fri, 4 Jul 2025
 13:52:55 +0000
Date: Fri, 4 Jul 2025 21:52:46 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Kan Liang <kan.liang@linux.intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Namhyung Kim
	<namhyung@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [perf]  9734e25fbf:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <202507042103.a15d2923-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SGAP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::22)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SN7PR11MB6797:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c571fd9-ec34-4f03-d714-08ddbb0213ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xfZuB92cvU4PIAoCDtWFkWzvuIYInagY0Ii7rPlfHHZ95dvYxmxy2OtBfLlV?=
 =?us-ascii?Q?nLSUnFFTagKcHAQZgCTr94PRQH5kZCsEVfiNw0nArFioIMISs/mPdPg1XmFU?=
 =?us-ascii?Q?82ZTddu763FFO+IZcKc1QGiNhilIjXrzlZxqhDTzCN03pu3yBEVOJW5zkiDT?=
 =?us-ascii?Q?dCWHIgvzFWlBVCDy2pIMe861QUP7has1LxJTQZVikO7RCLuIC/rmjK1YFImR?=
 =?us-ascii?Q?4YX/PenFRsPqqw+Jy3hzkTS8/3OcsUk3RQ63EhuwDPRXycaO+/R5gW38tMe8?=
 =?us-ascii?Q?bt5g+6kskeEr6abtT6V/KOlhNczXSJ/nGzcJLhb7WJjCX8EXhl/eyTlEcRg9?=
 =?us-ascii?Q?yhvZ+ZoplTWIqZ1ycUSBWvAIgOmTpDzsqxRH4N0UbdJ2cM//F6RJ3ristCwv?=
 =?us-ascii?Q?6gHUIgypqSZ16Dr65f3XCzi0nfNuUPCoaeebk6MPe7QsyM8TAneSv+rhtKEf?=
 =?us-ascii?Q?405CYZBSwaxIk/ltgJnQHSinuL1v8lhWvvkjrEkasByRWyp2/jObyKdbAuWf?=
 =?us-ascii?Q?OxKlsDo1FXBb2YeLGTf69lX14XuWssBc+SphNdTJG9NlkCi+tnjy/429JVzc?=
 =?us-ascii?Q?euW0gkZ1rPlDjcuOPSrRLyzLg1h1E+RjlQUyK5Bwl+AS/UJcLGE4yn1EGs9o?=
 =?us-ascii?Q?Tbk4LKPp7hXGyLn0B/VgASC9f5nj6XBkrrwhBiTJnQ6knOTpolTt8j4T+SIR?=
 =?us-ascii?Q?L462jXYBE86d8iC1UE5UkAFuw1xAiDXBFf6zQj7PaWewMBumZSc85aUo7qPa?=
 =?us-ascii?Q?NDFlng0znIYfqWyAOLMZ+vPFY86HCFt4bCkTL9MhrmiLHbjnUe7CYbprP9tm?=
 =?us-ascii?Q?0NWvVK2EdnZyjcm1yRLFEB6jXX4lc8rzlUBM0lNC1CXs1OJEjYo1CAR7UPnr?=
 =?us-ascii?Q?yxwm7NWzbM+WlXK5m+zfSIpO7oNvaCTLmVljmgtgz/vm9znf92svpeTIHHxO?=
 =?us-ascii?Q?rvTTaKu3KCB/raY91wZCZZ+hT/UvhNJ4ULwFoAQjBKNc9v7RBWQ9zKa9k8NH?=
 =?us-ascii?Q?VnU/Rtpln9jFHSFQXqovqug1LvBg6Py4byiIQxCm75N7fYebBrRuib8KZmu+?=
 =?us-ascii?Q?+8ZdD6kHHxEopZIo7aFDv0SmCkaLVWmfs8E5b6tYvorTqe+pZd8EBQqSIDJN?=
 =?us-ascii?Q?K5bfb6FZokWY+wIucX7FG1G1KpHS3U20zlCa0aVzOM8env15cPlarM5+A7O+?=
 =?us-ascii?Q?Hy+3lfq3RM4+Tm3VsdwuU4avp1KPtbMqjsGFMCyxE9RcMw+9GBPBAYwx588n?=
 =?us-ascii?Q?5lz/nYaBEkm7Mt/hmGg93vutvNQ1/Y15jBa5rXlQOCWi93C9g7wOHrQ+838r?=
 =?us-ascii?Q?HMgLoTYkuF2M14e9+PgwTOwE+kirTuylSsVQXZUOgQJ8l64nAbmVuq5aWUhQ?=
 =?us-ascii?Q?Iq7OyOHR/OLU7Q2DjnzCRPrHbvt9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6JQupOuPgK3aBi8DuleLuYzHSc64sz0MwH+guCbxqMcZJkOAxTDaSiB3Zq4U?=
 =?us-ascii?Q?fferPMou7AzOp7MLyCnGEipZKKJWkFsTbsAfbc0Rcrnig6WnyTD/mgVvJ80W?=
 =?us-ascii?Q?GeCqpVKLAzoKSizH5oyb5OITuAbSl/EqhbQkSeiBtekODHTkxrgewVlkvxtD?=
 =?us-ascii?Q?yfAg3oZtJgI3Ef3yazMtsOJVsF7J2rsaWdyeARZkdQOCOxcLh0En3gpy9s63?=
 =?us-ascii?Q?8u/cdd4qfhdIS+K0hJYHua78uKbKZMufBj6HDaxSWHc3TGesBkuCNyui51iI?=
 =?us-ascii?Q?0wxO5LWqqCLkamQ9zp98nQ+BADslfRbsgqkNgVGzStL+8UiUimPiuZ5XL/ZJ?=
 =?us-ascii?Q?yHdbgBSLwfWUYuNQUCTfCDQe5EfaRJSqwhy34s5FqM9aJeLN0lJkSB3Mb2AP?=
 =?us-ascii?Q?YvBxePW4ddYWc++3+kPhH4nwegtSPxEsnY1ZZPFqD4NXBh9cxMlb+DAuRoO9?=
 =?us-ascii?Q?DkreogxUawgJGNoIoixYLKI58N+/XRPlVk61vhglE2T+ZyxC/pVtxYBb7/QE?=
 =?us-ascii?Q?nl+0aZ/YIurPSFV8GSrLQ9tBYo0FMfYiGKpxmk5baLTCVzqufLmAeHqaP0m7?=
 =?us-ascii?Q?mF9q5COAyrXLjgyvBAVDztW1DbvEBdrssQFG6hb3uNKimCU6bs64M7MI/DUT?=
 =?us-ascii?Q?YszvLgENiEGrsw9wW31knYX1m//fAztUyGVnkYXTN/i6UC0bXYbJcEmyaYVz?=
 =?us-ascii?Q?BGPG7kytv1hKHu8r+hOJp2OiCMzvMri7yYmk/3PHX+M/LoIC2aVhqghbmGra?=
 =?us-ascii?Q?XsymhtdNVEw1BcAQEeLjEfuTZ7cuijZmkrY0dLOc64jFcnjW3i0H46teWRyh?=
 =?us-ascii?Q?ysesbyGzKe7K05NtLbsbRozfUnvNXRLjma8C5Ai8Aftouofnd13CqZkhZx0P?=
 =?us-ascii?Q?iRWtxRO6SDG6TNovuN1W32fgGnnPPnciNArmE9reu3rCMMk816tV9pq7LjYN?=
 =?us-ascii?Q?oY5ZMHFVulIElDzeRbRS1gnTXnP/GOfJFljxixADZf1g3H/lmJtcMjjIVWqO?=
 =?us-ascii?Q?sDqIL+UfNwtC2c+P2HPZLpkKg4semf4/0h3Gl3XFyOxObSn9RAlnHxycCPaV?=
 =?us-ascii?Q?L/+65BazOBoTHmrN9ZrujHqdzJkX1b2BhZS6Diq/F73btpzCCg1VDBo6yCBt?=
 =?us-ascii?Q?N5Z06TDUDdKt07NEBRu0YAyefMTbqfMmKYLYY9Fl+O5HRHChPewrKMUd2JmI?=
 =?us-ascii?Q?c8HmcKV9fDWlKr9cyn3bIvEqs+iuW7n5xO7YJoXDyfUmLbxqMwuG3ImxLYCt?=
 =?us-ascii?Q?WpL/4XzHWQZY9kr7eKmmQFa8C0KZDtYd0yPPZqQQuekf6xwRvq1lyV1rhusK?=
 =?us-ascii?Q?IoyTO+bzynb49lnJH8o7nxcnr9u0xIKvyTMjGEOxETs37NDZZVH+igWK78vG?=
 =?us-ascii?Q?ewf8GtjQqdVn1aTVN0hqahEoUHUBNNspHttCe/ddhZIbBic3/EuQlAG0bXpi?=
 =?us-ascii?Q?HRelEbwhTgnAPbKpzShOy8d55WxEz8fE6HYrL/bAZqUPcFLVrjE/3TGWb3iY?=
 =?us-ascii?Q?JcE3BCaVqjAlZcOO5H8TJmNPDu+IyhuONS4PMpko6PgsoerqhdqeO8obPZb2?=
 =?us-ascii?Q?YrHDzrlvppAaj/adH7bbn/LPcDsXtty5LuIDpGBv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c571fd9-ec34-4f03-d714-08ddbb0213ef
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 13:52:55.7133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2U4NJDNZ0rKFsQwwRWTDGbm1kj0N/ZU7eXUSta+PnBAuMlHXvz2ASL/Z9rqbXj8hDaxNVxG9XxlZkDFpUjizQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6797
X-OriginatorOrg: intel.com


Hello,

kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:

commit: 9734e25fbf5ae68eb04234b2cd14a4b36ab89141 ("perf: Fix the throttle logic for a group")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      66701750d5565c574af42bef0b789ce0203e3071]
[test failed on linux-next/master 3f804361f3b9af33e00b90ec9cb5afcc96831e60]
[test failed on fix commit        bc4394e5e79cdda1b0997e0be1d65e242f523f02]


in testcase: stress-ng
version: stress-ng-x86_64-f76f86ffb-1_20250412
with following parameters:

	nr_threads: 100%
	testtime: 60s
	test: memthrash
	cpufreq_governor: performance



config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 192 threads 2 sockets Intel(R) Xeon(R) Platinum 8468V  CPU @ 2.4GHz (Sapphire Rapids) with 384G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202507042103.a15d2923-lkp@intel.com


[   93.379225][  C143] BUG: kernel NULL pointer dereference, address: 00000000000000f0
[   93.379247][  C143] #PF: supervisor read access in kernel mode
[   93.379253][  C143] #PF: error_code(0x0000) - not-present page
[   93.379259][  C143] PGD 161558067 P4D 0
[   93.379263][  C143] Oops: Oops: 0000 [#1] SMP NOPTI
[   93.379274][  C143] CPU: 143 UID: 0 PID: 3944 Comm: perf Not tainted 6.15.0-rc3-00069-g9734e25fbf5a #1 VOLUNTARY
[   93.379281][  C143] Hardware name: KAYTUS NF5280-M7-A0-R0-00/NF5280-M7-A0-R0-00, BIOS 06.08.01 12/24/2024
[ 93.379286][ C143] RIP: 0010:setup_pebs_adaptive_sample_data (kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/events/intel/ds.c:2083) 
[ 93.379325][ C143] Code: 04 24 48 85 d2 0f 84 81 02 00 00 49 89 d5 49 89 fe 49 89 f4 48 89 ce 49 c7 80 a8 00 00 00 00 00 00 00 8b 02 4c 89 c5 48 89 cb <4c> 8b bf f0 00 00 00 89 44 24 0c 48 89 44 24 10 48 8b 87 08 02 00
All code
========
   0:	04 24                	add    $0x24,%al
   2:	48 85 d2             	test   %rdx,%rdx
   5:	0f 84 81 02 00 00    	je     0x28c
   b:	49 89 d5             	mov    %rdx,%r13
   e:	49 89 fe             	mov    %rdi,%r14
  11:	49 89 f4             	mov    %rsi,%r12
  14:	48 89 ce             	mov    %rcx,%rsi
  17:	49 c7 80 a8 00 00 00 	movq   $0x0,0xa8(%r8)
  1e:	00 00 00 00 
  22:	8b 02                	mov    (%rdx),%eax
  24:	4c 89 c5             	mov    %r8,%rbp
  27:	48 89 cb             	mov    %rcx,%rbx
  2a:*	4c 8b bf f0 00 00 00 	mov    0xf0(%rdi),%r15		<-- trapping instruction
  31:	89 44 24 0c          	mov    %eax,0xc(%rsp)
  35:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
  3a:	48                   	rex.W
  3b:	8b                   	.byte 0x8b
  3c:	87 08                	xchg   %ecx,(%rax)
  3e:	02 00                	add    (%rax),%al

Code starting with the faulting instruction
===========================================
   0:	4c 8b bf f0 00 00 00 	mov    0xf0(%rdi),%r15
   7:	89 44 24 0c          	mov    %eax,0xc(%rsp)
   b:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
  10:	48                   	rex.W
  11:	8b                   	.byte 0x8b
  12:	87 08                	xchg   %ecx,(%rax)
  14:	02 00                	add    (%rax),%al
[   93.379327][  C143] RSP: 0018:fffffe00021028f0 EFLAGS: 00010082
[   93.379332][  C143] RAX: 0000000000000001 RBX: fffffe0002102c80 RCX: fffffe0002102c80
[   93.379338][  C143] RDX: fffffe0002121040 RSI: fffffe0002102c80 RDI: 0000000000000000
[   93.379340][  C143] RBP: fffffe0002102970 R08: fffffe0002102970 R09: 0000000000000001
[   93.379345][  C143] R10: 0000000000000013 R11: 0000000000000008 R12: fffffe0002102ef8
[   93.379349][  C143] R13: fffffe0002121040 R14: 0000000000000000 R15: ff110001a0a69500
[   93.379356][  C143] FS:  00007f539e726840(0000) GS:ff1100303c39f000(0000) knlGS:0000000000000000
[   93.379359][  C143] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   93.379362][  C143] CR2: 00000000000000f0 CR3: 0000000180052002 CR4: 0000000000f73ff0
[   93.379363][  C143] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   93.379364][  C143] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[   93.379365][  C143] PKRU: 55555554
[   93.379366][  C143] Call Trace:
[   93.379377][  C143]  <NMI>
[ 93.379380][ C143] ? x86_perf_event_set_period (kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/events/core.c:1442) 
[ 93.379410][ C143] intel_pmu_drain_pebs_icl (kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/events/intel/ds.c:2356 kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/events/intel/ds.c:2666) 
[ 93.379424][ C143] ? shmem_write_end (kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/include/asm/bitops.h:55 kbuild/obj/consumer/x86_64-rhel-9.4/include/asm-generic/bitops/instrumented-atomic.h:29 kbuild/obj/consumer/x86_64-rhel-9.4/include/linux/page-flags.h:835 kbuild/obj/consumer/x86_64-rhel-9.4/mm/shmem.c:3319) 
[ 93.379436][ C143] handle_pmi_common (kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/events/intel/core.c:3206) 
[ 93.379440][ C143] ? shmem_write_end (kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/include/asm/bitops.h:55 kbuild/obj/consumer/x86_64-rhel-9.4/include/asm-generic/bitops/instrumented-atomic.h:29 kbuild/obj/consumer/x86_64-rhel-9.4/include/linux/page-flags.h:835 kbuild/obj/consumer/x86_64-rhel-9.4/mm/shmem.c:3319) 
[ 93.379443][ C143] ? set_pte_vaddr_p4d (kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/mm/init_64.c:307 kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/mm/init_64.c:315) 
[ 93.379462][ C143] ? flush_tlb_one_kernel (kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/include/asm/paravirt.h:85 kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/mm/tlb.c:1544 kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/mm/tlb.c:1499) 
[ 93.379489][ C143] ? native_set_fixmap (kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/mm/pgtable.c:652 kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/mm/pgtable.c:661) 
[ 93.379492][ C143] ? ghes_copy_tofrom_phys (kbuild/obj/consumer/x86_64-rhel-9.4/drivers/acpi/apei/ghes.c:345) 
[ 93.379500][ C143] ? __ghes_peek_estatus+0x49/0xb0 
[ 93.379503][ C143] intel_pmu_handle_irq (kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/include/asm/msr.h:86 kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/include/asm/msr.h:120 kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/events/intel/core.c:2504 kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/events/intel/core.c:3351) 
[ 93.379507][ C143] perf_event_nmi_handler (kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/events/core.c:1767 kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/events/core.c:1753) 
[ 93.379518][ C143] nmi_handle (kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/kernel/nmi.c:184) 
[ 93.379529][ C143] default_do_nmi (kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/kernel/nmi.c:152 kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/kernel/nmi.c:393) 
[ 93.379541][ C143] exc_nmi (kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/kernel/nmi.c:588) 
[ 93.379545][ C143] end_repeat_nmi (kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/entry/entry_64.S:1409) 
[ 93.379558][ C143] RIP: 0010:shmem_write_end (kbuild/obj/consumer/x86_64-rhel-9.4/mm/shmem.c:3321) 
[ 93.379564][ C143] Code: 48 8b 13 83 e2 08 75 41 48 8b 13 83 e2 40 ba 00 10 00 00 74 0c 0f b6 4b 40 ba 00 10 00 00 48 d3 e2 48 39 d0 72 25 f0 80 0b 08 <48> 89 df e8 23 fd fd ff 48 89 df e8 db 1e fd ff f0 ff 4b 34 74 54
All code
========
   0:	48 8b 13             	mov    (%rbx),%rdx
   3:	83 e2 08             	and    $0x8,%edx
   6:	75 41                	jne    0x49
   8:	48 8b 13             	mov    (%rbx),%rdx
   b:	83 e2 40             	and    $0x40,%edx
   e:	ba 00 10 00 00       	mov    $0x1000,%edx
  13:	74 0c                	je     0x21
  15:	0f b6 4b 40          	movzbl 0x40(%rbx),%ecx
  19:	ba 00 10 00 00       	mov    $0x1000,%edx
  1e:	48 d3 e2             	shl    %cl,%rdx
  21:	48 39 d0             	cmp    %rdx,%rax
  24:	72 25                	jb     0x4b
  26:	f0 80 0b 08          	lock orb $0x8,(%rbx)
  2a:*	48 89 df             	mov    %rbx,%rdi		<-- trapping instruction
  2d:	e8 23 fd fd ff       	call   0xfffffffffffdfd55
  32:	48 89 df             	mov    %rbx,%rdi
  35:	e8 db 1e fd ff       	call   0xfffffffffffd1f15
  3a:	f0 ff 4b 34          	lock decl 0x34(%rbx)
  3e:	74 54                	je     0x94

Code starting with the faulting instruction
===========================================
   0:	48 89 df             	mov    %rbx,%rdi
   3:	e8 23 fd fd ff       	call   0xfffffffffffdfd2b
   8:	48 89 df             	mov    %rbx,%rdi
   b:	e8 db 1e fd ff       	call   0xfffffffffffd1eeb
  10:	f0 ff 4b 34          	lock decl 0x34(%rbx)
  14:	74 54                	je     0x6a
[   93.379572][  C143] RSP: 0018:ffa00000187bfd48 EFLAGS: 00000206
[   93.379575][  C143] RAX: 0000000000001000 RBX: ffd4000005435680 RCX: 0000000001128000
[   93.379580][  C143] RDX: 0000000000001000 RSI: 0000000001127000 RDI: ff1100011221d8c0
[   93.379580][  C143] RBP: 0000000000001000 R08: 0000000000001000 R09: ffd4000005435680
[   93.379581][  C143] R10: 0000000000000001 R11: 0000000000000003 R12: ff1100014115e5d0
[   93.379588][  C143] R13: 0000000000001000 R14: 0000000000000000 R15: 0000000000001000
[ 93.379592][ C143] ? shmem_write_end (kbuild/obj/consumer/x86_64-rhel-9.4/mm/shmem.c:3321) 
[ 93.379600][ C143] ? shmem_write_end (kbuild/obj/consumer/x86_64-rhel-9.4/mm/shmem.c:3321) 
[   93.379604][  C143]  </NMI>
[   93.379605][  C143]  <TASK>
[ 93.379607][ C143] generic_perform_write (kbuild/obj/consumer/x86_64-rhel-9.4/mm/filemap.c:4124) 
[ 93.379633][ C143] shmem_file_write_iter (kbuild/obj/consumer/x86_64-rhel-9.4/mm/shmem.c:3464) 
[ 93.379636][ C143] vfs_write (kbuild/obj/consumer/x86_64-rhel-9.4/fs/read_write.c:591 kbuild/obj/consumer/x86_64-rhel-9.4/fs/read_write.c:684) 
[ 93.379644][ C143] ksys_write (kbuild/obj/consumer/x86_64-rhel-9.4/fs/read_write.c:736) 
[ 93.379651][ C143] do_syscall_64 (kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/entry/syscall_64.c:63 kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/entry/syscall_64.c:94) 
[ 93.379656][ C143] ? exc_page_fault (kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/include/asm/irqflags.h:37 kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/include/asm/irqflags.h:114 kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/mm/fault.c:1488 kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/mm/fault.c:1538) 
[ 93.379659][ C143] entry_SYSCALL_64_after_hwframe (kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/entry/entry_64.S:130) 
[   93.379662][  C143] RIP: 0033:0x7f53aa05f27f
[ 93.379672][ C143] Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 39 d5 f8 ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 8c d5 f8 ff 48
All code
========
   0:	89 54 24 18          	mov    %edx,0x18(%rsp)
   4:	48 89 74 24 10       	mov    %rsi,0x10(%rsp)
   9:	89 7c 24 08          	mov    %edi,0x8(%rsp)
   d:	e8 39 d5 f8 ff       	call   0xfffffffffff8d54b
  12:	48 8b 54 24 18       	mov    0x18(%rsp),%rdx
  17:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
  1c:	41 89 c0             	mov    %eax,%r8d
  1f:	8b 7c 24 08          	mov    0x8(%rsp),%edi
  23:	b8 01 00 00 00       	mov    $0x1,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 31                	ja     0x63
  32:	44 89 c7             	mov    %r8d,%edi
  35:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  3a:	e8 8c d5 f8 ff       	call   0xfffffffffff8d5cb
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 31                	ja     0x39
   8:	44 89 c7             	mov    %r8d,%edi
   b:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  10:	e8 8c d5 f8 ff       	call   0xfffffffffff8d5a1
  15:	48                   	rex.W


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250704/202507042103.a15d2923-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

