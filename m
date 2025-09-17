Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E75F2367AC;
	Wed, 17 Sep 2025 04:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758085133; cv=fail; b=MYfPeipn1kZlhufpLhNQL5qhAGVP+6dfrjmuVNqcx+i70K5n3Ujd260zSAycQ8jsh0B6IMC6JKyXFQKKm+3ATzr4cJlaIlF9VHjRf1c19//LfnAXAyUNxhvbA5DjSRB9ryXxh3vLAWWF+PAQ6DLm8INn0oJ0GJU1F2iE76jRbVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758085133; c=relaxed/simple;
	bh=W2RPfioLwUv4GzV6Qhqh+U7QIWt/Snwo4ovelmROK3E=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=OnbMlB0d/QTKbOcyvqC6tkdod9JnzNLkZjRXBNWL4QqUAP0062V94omlD2sdqGflBYsuN+VB61/45fpM/PnLRhyUDqr3cOlwTBfC5tYJWeOcmq1zUcxfSpz5jVChBD2McaEXHvQgjQeEa/o87UTOB5R6G8pRsYsu10KDCDm47EE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WSlCToi5; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WSlCToi5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758085133; x=1789621133;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=W2RPfioLwUv4GzV6Qhqh+U7QIWt/Snwo4ovelmROK3E=;
  b=WSlCToi5ug8I9HM6+XHSE6fDAdSoivywcg5SrP9Oae7rxHOqRg2Fpisb
   WJeUIfr2SEoeCZAUAqUuQtytHYQyNMtUT8zyG2MsCFKxvR+bgXi1r1Fg+
   W6ELuQl19Za+/HpTGtnseNh+hGo6C3X0o1ltEk30bQRcvOPEmYHI1rVZG
   2AhAR48BIuYID5q6er1LlxxDVS/6z3JnlTbvibEj/JOhwLNGfyfsvVq1m
   IDFNGXUCJkD65qbSkO7SYoFdd/d+ui/D3Qx8kiApg5bFYuoU4BrmH1Gr6
   3IqOn156eZNpxUlO8Cl9aB/0CN8kRYjCh/kvG6rItmosR45sZIcZZ4izm
   A==;
X-CSE-ConnectionGUID: ccyuau+zROCXxfwbwFssQg==
X-CSE-MsgGUID: Z8cDGnIxQXSmUB8uWc/rug==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60296666"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60296666"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 21:58:50 -0700
X-CSE-ConnectionGUID: W0Ef4099Qc+h1v3/tm1TIA==
X-CSE-MsgGUID: GeGnNsqkTe2UXDRzncOrmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="175540052"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 21:58:45 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 16 Sep 2025 21:58:44 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 16 Sep 2025 21:58:44 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.52) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 16 Sep 2025 21:58:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vWYAj24oVOPewhVPWe157x7EwDiILhaF4Cmbdr0cWUtdc+2PU2vyoFQQGs3fSPgl2YzyIq1y/h/TMISew6YxG/MOCYpMa7+XAPwLAZTiMYpeFP3qtj0HYxUGapcmJ0tAcJUs8rSU5PCQvScv0G1AGQ7G5CD0WfeyL4sCc9LLoNeq0anKFkB6M5XgAq2AmYQlD2ziwpu4Cwov02mpQ9kzCr7xhYjABmXRXgMgkVW8SRSd15haQfpbrjn08tYpgWl6n9ei2AkQ+jiYgh14bhKQq9V0xYUjjk94IMaLX8oQ2ntONuUOLd0VSf8ZqZBwYtRbvMg4oWde3fKRF2Qc82NnOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vL6Ta3VkEhMa/XEaapJ+l+VblJ3u/wCTCJ8C+X82Vo=;
 b=AU3tMOvIZF4rKmY2BwBZErCVdSrtb+G19Em7JsMIIiP4ZQxU4yYiPdqyR8NzFLw0BpN6tzqym5RIRL9LbA/q33B39Gk2srXN3ShbxcflM7NQI2kF0lmuXmf/yKWWh+bREjTYn9Twqftg/oj4NuVFizmgD8cM8zRIUxzO5OAktVtIwBL8X5xMIQEFJ3XwAQgbRpUhnPh39lFsFXnEaU3y4f0TFSxm9SU+EZ29K9GWSNth1JnLeU2GgNypmqk+fWMEPEnpv8MclJ0b18HhyjKcWasZIFqQRcDPL+K499a5zbbM+GH1aSMd/kI+vr9/4LTAey+xLGtGcUA+rCo/ZiyBkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com (2603:10b6:a03:568::21)
 by BL3PR11MB6363.namprd11.prod.outlook.com (2603:10b6:208:3b6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Wed, 17 Sep
 2025 04:58:42 +0000
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4050:8bc7:b7c9:c125]) by SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4050:8bc7:b7c9:c125%5]) with mapi id 15.20.9115.020; Wed, 17 Sep 2025
 04:58:42 +0000
Date: Wed, 17 Sep 2025 12:58:34 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Namhyung Kim <namhyung@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>, Ian Rogers <irogers@google.com>,
	<linux-perf-users@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [perf machine]  41453107bf:
 perf-sanity-tests.build_id_cache_operations.fail
Message-ID: <202509171233.7f389399-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::13) To SJ2PR11MB8587.namprd11.prod.outlook.com
 (2603:10b6:a03:568::21)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8587:EE_|BL3PR11MB6363:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a673bf7-ac4a-46ff-3a53-08ddf5a6df6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wlHHo/RrF5J0+Xw3r1GGYk8V12WWJCeJoRfXLjjKMg8NNY34j32RVQlk+G0o?=
 =?us-ascii?Q?U+wMFqft2Ou92flGyGMNzFoQrJ+vaLZUdf7zSHRzk9E2b7iiO1PEtsauUNWH?=
 =?us-ascii?Q?ngJsUgxWGJw2mdE9Fg/vBN9H2EBO5T6olmvZBsR7iCW+bizqZnavS51tIBug?=
 =?us-ascii?Q?ioTu5mO9M+pAUXAfgH4OakZTW6e9AenjAoKN2HEWr3+v8x4kPY7f0QOcPAb0?=
 =?us-ascii?Q?qm2oqWK/OD5oY8XCDxUGVnaTZdNxCKuu3flfQW1Kb8k3y73LGA7qdL9kbgi7?=
 =?us-ascii?Q?zQ1QxMpSyGNNLUUekmE9uNXuughionN2bdF03TGSr/M13j9wRnxwyD9eH9l7?=
 =?us-ascii?Q?3HXF+yl2Yn9L2LRpKBc37gSm3Maa7/htIE/aIkETL8fJx8UxJBYkxqhIwpKU?=
 =?us-ascii?Q?zdm13fSHM6CxBs9+BSGXp8ktk0D2tUK8lj3xAyK1E6C+Qe94xqJp935U+lxp?=
 =?us-ascii?Q?yb76Q4IukXFPA37lj5JDUzaJ7jFQNJV+oRnFfK/pRbzAxuj0LpfJ19K6WjXk?=
 =?us-ascii?Q?tlzZUvyy8TIGLOLW/bJsxSXacBicx8cHKmAczYbXOJQDJ5YAewFdyhUFuHzO?=
 =?us-ascii?Q?8OGbhdS1iFzX7m2ZGIr9N6861kh9/PzwMtWX1PanPdsL9Sk2bEHvJK8yyj/9?=
 =?us-ascii?Q?QtWrE7DbqFQbJ41UOXOmQ34w2HFLpayZeKkploU7muoYSnH4fagHk9YklR+u?=
 =?us-ascii?Q?T1D/EQdMdHXX6wT/LqyTsL/c5n0e1PgJnCpPf2KbssvGpbAx7UQprl+qPqWZ?=
 =?us-ascii?Q?GjcNSl9CTOZV2j5kvSrVCpDFUAydpkr0ySH9RJiepS5RSrlaSODQrc1FSJG2?=
 =?us-ascii?Q?BRl9BoNxZdpCpYyIbwuLFgRK68GO1xEh+nLWL7RKPjGeOeJbCtF4Lq6keW+M?=
 =?us-ascii?Q?56hcYng5wmxLqM6iKlh3Y4V8BnqsH/CPiNoM7njZXECMtbNK77fln+FO/oBi?=
 =?us-ascii?Q?NjMxPWFOqswkel1dFsJLhBsECp6bBF7e1XeJJqkHDV+75kZQoRXvbJbat3b8?=
 =?us-ascii?Q?OnqURR5hX2chXQx6P9i18kVhG+03mDCig4c8G4MkhDm3SAQd4D8llRfzlo18?=
 =?us-ascii?Q?uKcFPC2YWUAZT8V0AqBJvDmfd+5zmOKqhzypVsl+p18Q74fDBfpfNTVowjY3?=
 =?us-ascii?Q?v+oPrU3o2gVruuYH+PdyrMQRecULi294GaRpPypE4sqKTms/TDWtj1KVTqze?=
 =?us-ascii?Q?ZUDr2KvSB9lkIqSqqPRbzdpg6OyToML/HeqYigM6dldcI/9BPCdu1GyZ6TAj?=
 =?us-ascii?Q?YbYtyV9HNryyYQJvEWsWoKTP06PK0dQwravUx/+15zI9tVp3CQmsCjM3m6gq?=
 =?us-ascii?Q?SpLYYpLc1AK1h0ohbjm7p0TwxZWL+jXz/bVQfKSr217hRE396UNEIwdqQDYC?=
 =?us-ascii?Q?SJhsMqkoFu5IC1TkHpdfJ2CnVoHs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8587.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uYwsX4cGWHatYet5XThgoTK5u/h8X27/sO5x9bZUlg9fumQCpEv7dI2ZyfbM?=
 =?us-ascii?Q?ins6tojdiLacQEQkg1jRT4R3yQj8F2s3Y1iZzEnlw0wiDvpp7DAkJiHxQh3o?=
 =?us-ascii?Q?pLKP83fol3Bkj92oMY6xFT5lY50ygakBor3uOXwXzq/jD8JW9Dew45JhcvpJ?=
 =?us-ascii?Q?xmMVX90XaM1BfhhJkfBQx7i1WA+56yncEzKABMKKJqvMOOmLUkkxsvqY8rcF?=
 =?us-ascii?Q?pZdu+AeoAR5WRlPSenwMFz/9eWh/n+77DwJpUYMwQFPjv5dosVl4999jb7pD?=
 =?us-ascii?Q?zfKfY2EeJDoSL/W51tQRi8FEnYC1tSa2ALn26aV+S6Rdqf4a2wafPGJXtLdj?=
 =?us-ascii?Q?/7xFTSOxbcc87fdBC1k5tLFcfAND0kREHyTC1POe8r1NkNTpIuxrFzHsgZW3?=
 =?us-ascii?Q?hLnpL/kxqGft9mmN9Qt5LmG14GscQ2SaH/CL0aDfkUt3xwX+89zpurl1n/7L?=
 =?us-ascii?Q?H0CzVHznPprHDMWSHMxrjVwNRHKONQhHxoNpL670VyJeAhXcR1SvXHkU3wZH?=
 =?us-ascii?Q?XCeP5FY/T+WzmxSpqTgCvYKG9YRXXWdmsxB46NV8J2+rWGo68ulq5A2gmhvi?=
 =?us-ascii?Q?ACZdXCLlecyxIDC341TRcq8a4nRmeyHCy/gUsXKiubKz7jPSUUCLf8mjXS7E?=
 =?us-ascii?Q?T+HcmVtL7Ma0x0wMtsXslxod+pIDMXiAHSLhZcGhzy/47JArbIfGLwnTArah?=
 =?us-ascii?Q?YXkKdzfcVL+9dpP90QmBH6N7sXJcW0cJ+Y4M9oWtPMgrgmtNfzvVRjDdwCYw?=
 =?us-ascii?Q?67tESZqwP4jtsuc2bfh03TXl/+qwoROjgItRX2AtMNBVPqF7w6WlxKIeenMT?=
 =?us-ascii?Q?GN/ByfX02OxlC8qFTq7WU2m3i61PcBt4abG/3B++4U+FyFPNkhqpr9VfmW9F?=
 =?us-ascii?Q?88AmUsssDCO4YhtMJxznPa44lwcwdQ5EHQ6f7tZpw7bZIUx42Tgwmx5ilChq?=
 =?us-ascii?Q?JHfAik/rYHSM1elc8yv9ImmLDeDX/JWg8f9SfQDpIYsC9ZjI9Mr6EnGrndPF?=
 =?us-ascii?Q?4moZ+L5irt0BR1W8EIXX2+w7FJhJLn8nFKkQoddAVDgi919E//140q5YsTTf?=
 =?us-ascii?Q?6dUk5/wFUbGAyaDVQIHMDMztZJDUYCQlZRPc7TxDwb6AYlCGNomJwz6AYnjV?=
 =?us-ascii?Q?1EnDJYAiNLfPRr1zwwDNG2xKs9pOwLWDSJZJg8WBewnIQT3dret6rBgaVwFc?=
 =?us-ascii?Q?PI/+U/fFTMkXt7xhQncmUFLzNpil2wk+9aM/tbHbcax/a/xL1FTjwxj3PQaO?=
 =?us-ascii?Q?zmuolbcHUtZqlMTi3Gs0/ALwGGE1mEvdToNMoZtVc8k57uTNqOxMKK0zgVb6?=
 =?us-ascii?Q?/TlDjUxuDhobEVEbb99KCHjsga9eVG4/cTXW3kvqpIVL0OqmRdufbKnyVe7c?=
 =?us-ascii?Q?fH3WveVQyzH2a0R1OxWUTVNPkzV9C40G97ciPdqM+Cw6vG3tbQwU442YW/at?=
 =?us-ascii?Q?4N7NBf6Yl5WLkyvDSEVWWVJqjwXlq9r47R4ikPJ266mB621uD3FcFYkcnchH?=
 =?us-ascii?Q?9+GA/OqKi9UOl23pU7djRRzpYfS0fb80cKbEYFz4q5U9Ma/g8HBUHsp3ED6Z?=
 =?us-ascii?Q?jbxhrXB8zYrQ8QKXWtzEZLu8KpfbxeSzHViMnuuJE9QJU5mphlaLhMAEFhcP?=
 =?us-ascii?Q?7w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a673bf7-ac4a-46ff-3a53-08ddf5a6df6e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 04:58:41.9682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z6iOE2GVhAmMW0YSU+rPAwZ85r04g0//8274H2wxGmgupcF0Ya6YZt+BNOlSemqyoU8OGpxex8C36Fm01Zb3sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6363
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "perf-sanity-tests.build_id_cache_operations.fail" on:

commit: 41453107bfc3008302c2b98cc01da55890235b77 ("perf machine: Fix insertion of PERF_RECORD_KSYMBOL related kernel maps")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on      linus/master 5cd64d4f92683afa691a6b83dcad5adfb2165ed0]
[test failed on linux-next/master 590b221ed4256fd6c34d3dea77aa5bd6e741bbc1]

in testcase: perf-sanity-tests
version: 
with following parameters:

	perf_compiler: clang
	group: group-02



config: x86_64-rhel-9.4-bpf
compiler: gcc-14
test machine: 16 threads 1 sockets Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz (Coffee Lake-E) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202509171233.7f389399-lkp@intel.com



2025-09-12 15:50:40 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-41453107bfc3008302c2b98cc01da55890235b77/tools/perf/perf test 77 -v
 77: build id cache operations                                       : Running (1 active)
--- start ---
test child forked, pid 10337
WARNING: perf not built with libbfd. PE binaries will not be tested.
WARNING: wine not found. PE binaries will not be run.
test binaries: /tmp/perf.ex.SHA1.lkF /tmp/perf.ex.MD5.CJf /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-41453107bfc3008302c2b98cc01da55890235b77/tools/perf/tests/shell/../pe-file.exe
DEBUGINFOD_URLS=
Adding 916d0ebaf0e95fd65f7a56c358fd8127a599f412 /tmp/perf.ex.SHA1.lkF: Ok
build id: 916d0ebaf0e95fd65f7a56c358fd8127a599f412
link: /tmp/perf.debug.OLh/.build-id/91/6d0ebaf0e95fd65f7a56c358fd8127a599f412
file: /tmp/perf.debug.OLh/.build-id/91/../../tmp/perf.ex.SHA1.lkF/916d0ebaf0e95fd65f7a56c358fd8127a599f412/elf
916d0ebaf0e95fd65f7a56c358fd8127a599f412 /tmp/perf.ex.SHA1.lkF
OK for /tmp/perf.ex.SHA1.lkF
DEBUGINFOD_URLS=
Adding 82116c4fd43ec51d956099717eef476c /tmp/perf.ex.MD5.CJf: Ok
build id: 82116c4fd43ec51d956099717eef476c
link: /tmp/perf.debug.HOq/.build-id/82/116c4fd43ec51d956099717eef476c
file: /tmp/perf.debug.HOq/.build-id/82/../../tmp/perf.ex.MD5.CJf/82116c4fd43ec51d956099717eef476c/elf
82116c4fd43ec51d956099717eef476c /tmp/perf.ex.MD5.CJf
OK for /tmp/perf.ex.MD5.CJf
running: perf record /tmp/perf.ex.SHA1.lkF
failed: record /tmp/perf.ex.SHA1.lkF
see log: /tmp/perf.log.err.KD1
---- end(-1) ----
 77: build id cache operations                                       : FAILED!



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250917/202509171233.7f389399-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

