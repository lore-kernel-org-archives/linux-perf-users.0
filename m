Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EE0347B4;
	Wed, 10 Jul 2024 04:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720587580; cv=fail; b=sFoaIRyMJveXKDO+ZOO3sS67u4tGh+o5+t0y0MfrMF8sGoMHOq9EOBeemCN2WJiG1nCk3LdDInjDx1lLGRQGiP+2ugBNIcdujyyMV3W5I0URd1Ud8MgU31sNTEnvm5+xPLFKFJrK/SCTAvySaVlUll5qlpZ5ZqNnG3HPXP4JF+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720587580; c=relaxed/simple;
	bh=2taZuAri9CFDVRQtqwktbLtNlWAfWUNDdEgnuuJgFRs=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=bqcp+SUMZxgOmPj3WaUg0UqM3sn2x7xFxYzuGfppVRNB24G1HqR81XkAwRpIJpbsOqfktRecfCqn4jC4PQyZPN3sQ4+0NyA3nefEsKF+HA87O3JtUcG2gY2KywmKVBVk8YhnsgxoIEZQLbbkKMYpbCk4hPWZ/Ku5mlVY8/q4JLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TZMCh33R; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TZMCh33R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720587578; x=1752123578;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2taZuAri9CFDVRQtqwktbLtNlWAfWUNDdEgnuuJgFRs=;
  b=TZMCh33RYOF+PVksL7wx/oLY3Eldy6p0bKAJU0z8Ee97MQHwvSBx8aa4
   u+lZ/QbFohiPOF8oQVvmTZp4esQ8SGuutNZyPQMQ7A9AD257Qh6Q/8faI
   x0BkCL4/uMTIgBYOE8lH8zdAHvFIVe/W/18Kg/1VchPO7IRpuGAmHWIYw
   9BFeqn2qK28GqWnLpb58fFDt+CYEGlbji5f7n27oKemhnyKXsoJgBqL8M
   MVxKx4Wsqxs3A6+Jgk5jjh3u/9lzmVK8Hg5p60xbTme/wgkLok19NnJKp
   OfBnJQkZBuFaQlGPbnE4khKIlgPdLKGBoKRPbaHiL33azNq3/bslgpGM8
   g==;
X-CSE-ConnectionGUID: 9n7SpoHPTY+GTG+WYz1Uvw==
X-CSE-MsgGUID: mLjspdgtQmSS/CQIbBfKBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="29042172"
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="29042172"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 21:59:37 -0700
X-CSE-ConnectionGUID: kNG3cKpFSjOIz4jCsI06mA==
X-CSE-MsgGUID: gbXOR24fTDumOnR2F74IIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="79243818"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jul 2024 21:59:37 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 21:59:36 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 9 Jul 2024 21:59:36 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 9 Jul 2024 21:59:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMZBwV42J8nBrH3Te6BNU0qRMyuYfW4YaJF9iPnwlwENWErwYtKpxer3sE0Wj8zGZRDxwbP5HCnfpZXB19SIhmx42oFo+g7Tv5VA5uWMjAMkWbAEwoZ6HXgA2Z+ceO9Pbm+QWwnX1oY3UfuRiM+Il2u+IxOKthYpD33YqyFbKkN4XVGWWT2m+I8fg9M+Z0B9TJQWCnfY0+FCgRpCcA2C42FPmj1R5yJQRzni740c74woxJBW6VIiYVjG8J5hR76O+CDTD2qdvGowE/JWj6WqcRLYBacxlOpkQlWDuzbNURAeSkfs4AKhKgJsW8CjBafpnH1SIvDz+WFNLneo8LW9yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kcd/oHDw4+L3yQ6EB6UtfKkeUK53eDFv/jO06EC988=;
 b=Xa99ZN597TndMhZD5wD65YdrYblK4Z/yTjS9zW77CwSC45KGH/8pnQciZDvv+xENYiqJx30iGB8PhFhzoEx0LzGT8kT1iuaqV+WzNnVtEzaF5pEeMr+iY7F2bHyFWfvbg1174j0wOFI75jH90SSsbP+VTLAtHFLDSOGWRcjClVFLCgdGUk4MpnNLe0uAflKO3ANcP0YVqcAob6Mg4AndFc3NEkhu6yrja1OXZbqHxdHxLFdqKscHz+PkrJBiwf4sBdmw9iCF+fbOHpquBYsAWSt5noIgxYQEwNXd+QuJbNygnidIHVacW7FpWZmDptYYC0lr8xLeZPwG1YaYoWu+zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ0PR11MB4910.namprd11.prod.outlook.com (2603:10b6:a03:2d7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 04:59:34 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 04:59:34 +0000
Date: Wed, 10 Jul 2024 12:59:22 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Ian Rogers <irogers@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Namhyung Kim <namhyung@kernel.org>, Weilin Wang
	<weilin.wang@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, Kan Liang
	<kan.liang@linux.intel.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [perf vendor events]  e2641db83f:
 perf-sanity-tests.perf_all_PMU_test.fail
Message-ID: <202407101021.2c8baddb-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0031.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::11) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ0PR11MB4910:EE_
X-MS-Office365-Filtering-Correlation-Id: 42fa5166-32f3-4c47-cf70-08dca09d174f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FLRwVuXjTENjBnruIov+R6sB8AtcefO9mOpeSQrbl5BQtc6/M2bly3YsHJ5/?=
 =?us-ascii?Q?1DJi0l/ndDeMAbJgJ7M/+XvU1Som1DEMuaOmaq7T0EB9DyU+K6fqU6khXXCr?=
 =?us-ascii?Q?IoTHWRcjIFnUeZBoecVIG9pMqEM/518fTE888jJrURHiJ76ILzjPwxOGgITT?=
 =?us-ascii?Q?xijzObaPlxVylEKp0cLK6xG4XEz3shRR/0oTDzGeyfSzCpl+httXwsrDQ/JE?=
 =?us-ascii?Q?ewIASSAGyACc96Dn4Lrti7WCwIqvgwtDJmkr5d0fcAntTyzW+Hncrfbb04Be?=
 =?us-ascii?Q?e0p1GsZDM6qeLWRk/ZamyFEqY8Dg04NRrK5wT9/bECPY33vPfRv/fC95n6xd?=
 =?us-ascii?Q?mcpkT6mndiuqyssqz9XrwnwSkP+WYYo0y4VsriU03k9JiHc4sBOmWM1D8xTe?=
 =?us-ascii?Q?Yy21Bwgste4OioZj6XDF3KzO//dG8wFoVYwuVZaw6B9ctQvFHmtCXIkAEq/f?=
 =?us-ascii?Q?xG3EIwI0B87ZCaNwUK0UVGPrT9YJimhqeKERLceaE/2e+YpyO4rIubLvqvzC?=
 =?us-ascii?Q?6Gypl1bLJrMen1JgriUQ61qkZF0LSIbT0EDCAjySkCUhX3zdY1OYVcZzWFRd?=
 =?us-ascii?Q?8GOgjktwY552uIuHdCExbWv9EQfbA65fjLLV1PD+GLdmgYqkr74LmWGIE6NB?=
 =?us-ascii?Q?tqUwUzZRRvoQSkrP7ezeDdr28AjfFAoRRD1IFaOFMW/L7i0Jlc9VVqJFPzYb?=
 =?us-ascii?Q?klJw/uTqLXB0Q/hKoZRsJx5A5B5T72c1eLxDLD46wQdLQfai6I04b8T6LWDL?=
 =?us-ascii?Q?QmS/oI5BO2HBoox+ko/NxRMI7h9X6THuz9k1cwgnPx0bTwQGKp2T8wCtyOao?=
 =?us-ascii?Q?btJ5OjeQp7ZMN7KEKek9gY01zooUO6VKjw/YPqSrdDUI6YvtjF3lgtJUVBIu?=
 =?us-ascii?Q?VHS/zNtU5V1zFoX8siDVjHKsr2vtyeW7c78Dl//ZqaE8cNJOXszlej3YpLCf?=
 =?us-ascii?Q?4wL3FyE/1fLJo1oXCN7JgAZT0Enx+GMfY6eYNZwgzuIgLYkh0Q/1gw3URX+q?=
 =?us-ascii?Q?VSmIWgzt8Aj1e2+Ckq6R9+QQcfjOGAjYpGeDUpm7onFHTpxUceZ6x4UZvKQr?=
 =?us-ascii?Q?oIrsva2FneoBXc0b3FLyfK+iuT/ZrzGuvbUdBqQ7hA+aCNdIGUj/15sqNXH0?=
 =?us-ascii?Q?ZBCC26RVg65rOPGpxYHhShTKX/pXUB0bjeZJBeC5lXx+ol1QZbW0Auk7rCAC?=
 =?us-ascii?Q?iPjvDEBhTC1iNzUv/c+Bk5LFznqSe4b+H8e8z6lhF7Au9ffIwK0+pxzEsptV?=
 =?us-ascii?Q?ZN3sunSv6hotYljXPbgPdDTyWjTF6DB2ngDTPurLzCGP9KupLNmpSmuHKHf+?=
 =?us-ascii?Q?hMKOWFZsX0LXr8cjnSIyH35V?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nOZqWvMzg/Kqpt00rGVlqM2fRy9RBwJqc3yRCHvyFinCWR1pCu4q2Xv35Rbo?=
 =?us-ascii?Q?h0C7rra65+17yAny7Tlpih/G81n1E/pa7F5mztC+7Hvx+vpLj+FtiCpnwg6s?=
 =?us-ascii?Q?7ilSYUSudNIu9TTj8+7m5aw7hikxc0mJv25m1AwwhXz9hOXEPkuEjycIqpkX?=
 =?us-ascii?Q?0H3Z6OAw0YYihWm9fslhiXnszB9faCNpSLH6BmHYTf1Mt8dRpUMLQiz85hF7?=
 =?us-ascii?Q?kOFIO1lfFYbM95js2RT7A+qIOsUvkCHerp6hJhMGa3tTHpZ2gLWExEJ66cjc?=
 =?us-ascii?Q?aWU9LkAMTS4sNF6cNst+nKdFeq8d9l3pNfpiv2RfMULUpSINP8md9qybn0rp?=
 =?us-ascii?Q?CH6A81DqMGQLMbQLBksJhYquda6/DFCnPvVT7MNYWTKiJ8Ix3gI5xWPsFpen?=
 =?us-ascii?Q?1tGd2YvjFyG1dpgcBXNBq5CUcF+EocmXBO1hru3tS+Gtw2KSG0CSuNbVzB+f?=
 =?us-ascii?Q?vPq4dqO0tAWEepsoHE32px8KM9sCYg3iTd5IZXaEt6G4uzcKVqtqxkkVi7OG?=
 =?us-ascii?Q?OSBxuhncJ+ADa5NG2IL2z/gEj+QFlRd1yIj+CIKuVFCcXWNyVr5Cq1Or23lU?=
 =?us-ascii?Q?ghjoDDgmsZsU6pSRrvB4bhHw88AHFRg/gA8M6K4rKhAb6voCyNJvGQH/eumy?=
 =?us-ascii?Q?+Ex9UMvA+yZhPHszjc9vB1yEsEuYB0O1BXhSLQnChPIAYijMV3M5CNE4M4kn?=
 =?us-ascii?Q?nIL87+uyv7dHP/YXeAWSkNN7QPkAnkjVijPZVSUCflHmQsJi/Zd5+O0pN1ql?=
 =?us-ascii?Q?SMbiSbrCFIdTa/kaaGLCjTHBD+/BM0vQnM/B2yqUtA0kHoyLImSmkhftTBQI?=
 =?us-ascii?Q?qfNLMDDTG0K6oKwuaSxNEX3g4Mk3j1zAo0Tr2QXjdUDBO3r14iTcboduW1YF?=
 =?us-ascii?Q?n5KyNNcMoVSJR4IBV3VPOrQsHsFzajhs60haxD8lHwTMsJB6e4GQSdFjDL9G?=
 =?us-ascii?Q?2zfVwi0jEcbQBolU6HvUpECDKIOTk+7NRpOe1hGItNW3nqi5rXi1nntZytPE?=
 =?us-ascii?Q?/ve+ZX5LPD/WZMhPRyJtq1wGYKMz8gru9oFgCZcv5tCAf4VCPCfm4mJsUT3u?=
 =?us-ascii?Q?aJJJN1w5T4itlmM71Ry4F8JVtR5znZTNHVc5er0E9DjMFfkDXZszyHTmg8Ac?=
 =?us-ascii?Q?M4ubfxEZYiwblu1jXbdRGKbKf7zgyWgPBSMWFwVz+2aicI03my8UHLC3C0OW?=
 =?us-ascii?Q?0eRTdBDCzaBvnWNnGBktkDeL/hjgYrgqCmGptLEyf2/44mPBfV137VaRvnPW?=
 =?us-ascii?Q?9qZ/Nw8Jko01IFwPCXJFvQEuHHUeBF3kcfedyPcR6CZ8Q5Xmgu3VHDYlWd9O?=
 =?us-ascii?Q?P3+mG8PzhufLXksxM8ZJHGOgcX6ou5yfdYZnqFJgqt3t0+0M164Uegt+/cye?=
 =?us-ascii?Q?R1TW3eEb+fTF8rxSMc7AW2eMYA6O0SFLtc0OEQHq/tSgN9RjRcRLtfPpKzek?=
 =?us-ascii?Q?vV/mtr2Hki8+Szo/PaMXxW1ZKUNKU1xM7hpM0IdfOjoYW7jO0kRGECNQ2EZ+?=
 =?us-ascii?Q?1E25R/VSHsG1fmrOg6DIsBK+OQEDEKB2bXSV0HYx/uRIM5iKuSS8WcJVrcHP?=
 =?us-ascii?Q?R75kutNnes6gyPTWexEwLYwvjn1SjkLsOXwU8leL5Se+lzsnjZKFH+7bvLLB?=
 =?us-ascii?Q?mQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 42fa5166-32f3-4c47-cf70-08dca09d174f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 04:59:34.1941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fxinwahpLkQhGWw/eUrthui/Qlej4ISVSk9gzhHxwDu1j5XMRuyvbSA1ozbBzHkIogqGXRcy40hqrRPJUETRGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4910
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "perf-sanity-tests.perf_all_PMU_test.fail" on:

commit: e2641db83f18782f57a0e107c50d2d1731960fb8 ("perf vendor events: Add/update skylake events/metrics")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 82d01fe6ee52086035b201cfa1410a3b04384257]

in testcase: perf-sanity-tests
version: 
with following parameters:

	perf_compiler: gcc



compiler: gcc-13
test machine: 16 threads 1 sockets Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz (Coffee Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


we also observed two cases which also failed on parent can pass on this commit.
FYI.


caccae3ce7b988b6 e2641db83f18782f57a0e107c50
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :6          100%           6:6     perf-sanity-tests.perf_all_PMU_test.fail
           :6          100%           6:6     perf-sanity-tests.perf_all_metricgroups_test.pass
           :6          100%           6:6     perf-sanity-tests.perf_all_metrics_test.pass





If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202407101021.2c8baddb-oliver.sang@intel.com



2024-07-09 07:09:53 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-e2641db83f18782f57a0e107c50d2d1731960fb8/tools/perf/perf test 105
105: perf all metricgroups test                                      : Ok
2024-07-09 07:10:11 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-e2641db83f18782f57a0e107c50d2d1731960fb8/tools/perf/perf test 106
106: perf all metrics test                                           : Ok
2024-07-09 07:10:23 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-e2641db83f18782f57a0e107c50d2d1731960fb8/tools/perf/perf test 107
107: perf all libpfm4 events test                                    : Ok
2024-07-09 07:10:47 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-e2641db83f18782f57a0e107c50d2d1731960fb8/tools/perf/perf test 108
108: perf all PMU test                                               : FAILED!



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240710/202407101021.2c8baddb-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

