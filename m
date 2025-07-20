Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1730C4A0A;
	Sun, 20 Jul 2025 08:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753000521; cv=fail; b=Rd2wnNcWFElXqnOD7CJrqkvGSY1acl/nK9ezAxjDSn2abto/1CP+s9m3yU08NNAh1Q/js8j3Q0SuOXuQVf+6/NbwC4n3kFuxuIWHbD+BiZMkXJehKFV/1GXracR+CEJebVyHq1XywhwalnRzKjIjrPwTCjVkg84V3sp2ZsU4eU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753000521; c=relaxed/simple;
	bh=WXy2RXxQX5d+4pIZWAL1b2e/hKms1B7zrC0Pxg/w9Z8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L8FgjBzg0u7FMYwqX3Xd/sMtuVjHdnMTS+6ZV+7y62wpxVth3sbYbBfGB5M5VO+fyOuwnt2P6Wuzerw5cj62Tzf7Us+QNINq2FdXdUpgTSUe2Hq71ldBsVVF2eFj8kbHU7u2PQRa1F4gbme4iV1OObYdsp1A35iYvC7HLME82W0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QQYk5Ho/; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QQYk5Ho/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753000519; x=1784536519;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=WXy2RXxQX5d+4pIZWAL1b2e/hKms1B7zrC0Pxg/w9Z8=;
  b=QQYk5Ho/tozQ/yX6C+dRw0e3X260A2cYM+Zyl4gXKbM/FDKYb5NcA7AJ
   6AELFuADd1xQqBDglqfps6S3HD9Vo62UHXSjrWWfo0T+Shh6oBEi6zj58
   AesE30WKyYK6mAyz3pJuU14pr6Ue8Vf1WrEOESJ+tf8fjjFd+2Pm9h63S
   7OHDklaNaKqm41s0jYT4pO22Aj6FK6S0ItFqQy3AJZ7dWkXOExyWkvkkX
   v0OmoblO7ZoZP3kXm6QtGChoYTFs5+Vl0CLsfhNyvsCksHLQw9yZi6rFy
   0NnYT1Mn0IAgZYtcpd/MLyKREZZB7cq1D+r4Rx8VIAYO0R2zKHb9r/7rP
   g==;
X-CSE-ConnectionGUID: dJxciDEMS6aWXIigmsEvcg==
X-CSE-MsgGUID: 10kTDKg4SzO1zTkkvXYrnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11497"; a="72693267"
X-IronPort-AV: E=Sophos;i="6.16,326,1744095600"; 
   d="scan'208";a="72693267"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2025 01:35:19 -0700
X-CSE-ConnectionGUID: FQWZRBqQSmGIZtiPU1kRgQ==
X-CSE-MsgGUID: poLQ1MBeSLubwMyiKMQcVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,326,1744095600"; 
   d="scan'208";a="158898596"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2025 01:35:18 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sun, 20 Jul 2025 01:35:17 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Sun, 20 Jul 2025 01:35:17 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.42) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sun, 20 Jul 2025 01:35:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hSY83QL5PcdLMjU+ijSmYR80QbugdTQ1mklAUgKVDetEREtfseFSkPSKk6J4e3jOunsffVX6+SQff6fsAoRm5+3ZVS+WvWJPT0azofzWjonHsupMMR3gkKZOdNSLPcvNA+GIYnN1edF4PiK+SzZIAPkrR4MrrpJhH2g11MQnTioo9TcZNDFib6L5BaPsTBtFp7c+mCeG1DUUmnSsqWzMV3JasPacCZmxFVsS+h8JiWOE7LmCk6DG9i0HjIHYGbSOVjGd3v7dg2PCDDhbbg1vR/55VrFvabMc2V6atrvdxA6ajl18Pqx3d3JLgLn8qBqWn+0vgDxNJUyC2btN8m6V3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MwuxKaj2G/2ZL9CkT8I/KhJpFA0peXgfbc8/I8pDSo=;
 b=OALUmagBgse9U2JeNOGeBlJfczgfai1d1su7ULHOlsAGgXxTz3oKKrBlSBuvHY8d/dodWvueUJkI5Udknw024A2vcSf/xzjwLlfnXd+biaPaxQJ0HfFFChPxAUBRv1zoCpquZvwbJ/MhxcsXgcf5MW/yXe6RUKRhmf1+P1xerAtlEaUY7VqPiQ7HY1t7I9ASuH7boyaCxnOo5Ta9K/G3DFOGVnSIbZd4K59GxyOZczWpdz7zAULIaMgCIqgRo+qiTEFppCSGLPfCVihz+N3mZzRSJ3ZFJOlwaK2bzzn/1/rprQdJFe7j++guXFSf7AzJXzlIyw7KQNiX1Vff1A5KZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH3PR11MB8703.namprd11.prod.outlook.com (2603:10b6:610:1cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Sun, 20 Jul
 2025 08:35:15 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8901.018; Sun, 20 Jul 2025
 08:35:15 +0000
Date: Sun, 20 Jul 2025 16:35:03 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Ian Rogers <irogers@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, James Clark
	<james.clark@linaro.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
	<jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
	<adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v3 2/2] perf test: Add sched latency and script shell
 tests
Message-ID: <202507201046.5842fe9a-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250628012302.1242532-2-irogers@google.com>
X-ClientProxiedBy: SG2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:54::14) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH3PR11MB8703:EE_
X-MS-Office365-Filtering-Correlation-Id: afa732d6-bd11-47c4-b8f3-08ddc76859c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ViCH9ciTM5oK1QYE6nB+zHoeWJSLHTSDKoHWZLtshXOhsBwGB4dcTKPOb4bw?=
 =?us-ascii?Q?X1H+r0y5BBjFHA/GgbAd/xkWhaW7sqIRLfepC1g+/ibTFrSL2VJMK9F+SHvh?=
 =?us-ascii?Q?9ohjjxONpLBsw3xexEREuDm+WCkV/c7mlCmIwtlHg3ECq6mX1uQiLj+E+5xD?=
 =?us-ascii?Q?LDivDeWwI2e+fz5blJLeJkGfoLrvlCPNWcpBAxWc7eOkaGetdiK+8XQYtXt4?=
 =?us-ascii?Q?IRAcdl+b7QJN+mT+XhTHpy8r452BqkYoj6tq4htSindfHbnFoz657TadLKbr?=
 =?us-ascii?Q?OsCuxto2PC9YB8ASdySJcXNUopxrhDn6hA1rlX41jnWf1nsIMgCbZtEMB3ST?=
 =?us-ascii?Q?mZNcUV9wyWHmYsHcWjpKq9XNpYqhlLANTvF7FhOmDNlqhzXmw9b401szRn4q?=
 =?us-ascii?Q?yri+w764TF3gBuQK0hkw+newjkxFu79iD6+J30XAFHVkeuZ3WVa9DIgynn26?=
 =?us-ascii?Q?T7a9kEe/bFWZig5BKrnPJRfXutk6ZeaaT0pCqiV7DajbPtXBf3dNTkT7ZE35?=
 =?us-ascii?Q?aZlBPxO++1Qg053KarswsIQ8QsJ+y4Uwo5wb6ZSibJKZmEeuYskj9ThRasEG?=
 =?us-ascii?Q?+WKaYU1pPOMxXyOD7iVBM4pz/eHF/VloV4zI6iU80DTMinr/S/eXT3BW3+0J?=
 =?us-ascii?Q?VnNhQMLFHO/OEAs1dMvoJJx0vA4brVJhrzdMNOARxIRzG13PNlY4xgT9iuMv?=
 =?us-ascii?Q?TiBkj3LuS8x58c2yrKNqG33X+eSWCl8//cY+90kY1F6WkOdi7F8fK++pS3Zh?=
 =?us-ascii?Q?kYIrwfHcsohzv08ITHQ9QsZF3WzHDACmtkV7riK9h2UZ8StD4vVKLIw5eTHO?=
 =?us-ascii?Q?PURpPCbARhVTeGi2WzTQ3D4Mz43G9jCSEbuH/jjjGB95Y+6rAzQu55X6yRAV?=
 =?us-ascii?Q?fpsNWpNEbGLv+mDFRQ1BcqpwHoodKrjBfUutxjvoeslG/YmeeMkrW9lJIxiZ?=
 =?us-ascii?Q?J+DeB7sfu8wO3BJzeF7m3S679+uUbd23jbvKZqJY24VEZLCFpMOzRtPXUYkL?=
 =?us-ascii?Q?BRn30VPnOZpdD2konTwOGhb2NPF7K7Q0Ze2YS44TMH+FoaKSQd4W4kVvMpv9?=
 =?us-ascii?Q?oSo+0es7WHmUZ7HzL/3oTXbpJq6Zs78NoiPGk16dPB0D7fYojMMoAmtkQeXy?=
 =?us-ascii?Q?BVrKRGvNQWcnWrjy+VJqI0XwGg+1yYz1S3lmnmtTrTX34M6YuRRE2GNo/Voj?=
 =?us-ascii?Q?sUjxKnL/2so5h9GPOCOvfhMw8Ok8zHWTs9nPVJ1NBU3QR1JrCNi7UoOglvBX?=
 =?us-ascii?Q?5qc7wW+pTJzGKNSN1EVaQtDHFnuL+NRnvWrXO7DD0OzV8K54RoZ+JB8XDZNP?=
 =?us-ascii?Q?H2Lhv8CXLpKevnMHG1R0T+dQ9w9oYplgZoiAWb5CjLba4lGle2o+c6rrU6Xv?=
 =?us-ascii?Q?/YqPwd/wGvVhF8ITtXwTFQxGf+Zr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jAkUhbuzp36or0KPvTnwuc6F4R8xunA86i9WhdF6CbSYupZtRPBFGlQ4xFiP?=
 =?us-ascii?Q?IDCwmkvI2TFt7MKP4D1XtnknGyWRiIMxYZOwJHrxLpXShOqqyItwaGrLiMTd?=
 =?us-ascii?Q?3eJmnJ8ku0I00JwcHSjeuNgFJIKhEMTVIbsn3k84HuA+UBg/sDvE4VNh8Nml?=
 =?us-ascii?Q?snn/sKwmiVPvlKwjZMS0A4JF14ABh+5wXtV5Wj8XCpexghG5kydGogQnP5KI?=
 =?us-ascii?Q?MXS25AwUfRTQf9BzFsiUrhgfxbfqMLwQNszikUGI85wcUMQ18nBq0tS7oBoI?=
 =?us-ascii?Q?Ct/k1PgRcJU30yIrx7iU+lg9iDEmILz19MzcnYoGmSDn1dTEhZNW8XqUAJmR?=
 =?us-ascii?Q?7+3W+Lb2dVZjL0jFa85VoWE/7KRQK5hSeL90Sr6s9Y1DhdBODWkAVJLgi/li?=
 =?us-ascii?Q?u78LWuxscVwj37bQmvjXK8Z9dVULzOrh2uWMqNjCf0lcXRpZr3gIH39rjdax?=
 =?us-ascii?Q?B8sW/v1+QD7BiQuLFm6nrWHL1sQDLtgj18QlD/5Bh0v4aBt8tyyMpu7zINCp?=
 =?us-ascii?Q?k9NgMR64duR9Q7Jq1DK0oJ9Y6MefReFEpqi/0Mnppoy9mkYsHsCyhB0OaQtX?=
 =?us-ascii?Q?KFBtPIXZJn35RvXXRW0gBxg+m+9oyYLl3hsbQnHR5O34jYNgie8O1vyJ74yD?=
 =?us-ascii?Q?IklGuVUMMvH/Z8MntGwQyYViIUHYo0x5tFgYRhe76jQHmKQXbOkV61h0FWWD?=
 =?us-ascii?Q?y71IZqfegKJQitHkhjkoylEoiu3gCsWRaCy3nAcmFws2nTt+KiwmqUwzyV27?=
 =?us-ascii?Q?GZJY6JCoCBwESDiXf7Z3W05K4u86Xt4SeEp/hcd2KxeTxji1ukoUsHyBT++t?=
 =?us-ascii?Q?gXaQkynkXGQj3vTEUxglyQATgsafh2+kta2CRjt67k4aIDwh8EfHqImq+cv+?=
 =?us-ascii?Q?dvUg28RzNz/QWBx/+0QY5qsBXL8aa5hxL7nJ6VJafeS5CemZpkwEhjXhi17f?=
 =?us-ascii?Q?TP2jm398eU7qN3CNNJu2Au7KDbPcxaqsCHnDyUtozdp7nv2tS14Z8dxPxARi?=
 =?us-ascii?Q?oKMR/TRvGt4VeLklb+y3NNmM8jZT9TiJGo45iK61121hSBhFQPpTXxphBtIs?=
 =?us-ascii?Q?1xfZ7gK19u6q7hA/yiG5J8UfqH+PHI9FgFfkyHEoHGWXmr3qiuULbnmF3sqO?=
 =?us-ascii?Q?fII3rD4hgjjoNwxpxAwyRf20C8XlENKGsFSPoOvLj3iTgo86URvQjPgh5uPW?=
 =?us-ascii?Q?caEXRPtFM4acPLQV6ZtklkpLF31BvgyhidoC5IJEMuXS0tiT8AbKQl5ItMt8?=
 =?us-ascii?Q?9nqVqqoepNiRX8r/9BHVPOMipBN1J7KYAccnOqNB5zV1KxHN6pjiRKRrdkY9?=
 =?us-ascii?Q?rfyhNNfQuw2u5eVJYE5SEbNLbKqC/phW7+bmanb+EoUO70Bxiq7Ebi6agGJk?=
 =?us-ascii?Q?zigpU+A095wqXUvk3M7K+Z4VLL0BlqKXE0z/oUAp7lC1iW4b5bwQdgeOH1lX?=
 =?us-ascii?Q?52FrnuUXXHE2ackC/TKtaRln4UaAcDUrYQhuPbhqSiVEW5QeIlXuckyKc1C/?=
 =?us-ascii?Q?DNiCCpOpgz1XM8YMJd0S5YMfdO7uqVeRYpaovydJQiG1UAdOvKt/uChWAJ57?=
 =?us-ascii?Q?jIuxDMz6wY1o8WuAQNudzRX1+1RivVluOwzbDPMX3/ukNk2vo4r8+cnc8f7m?=
 =?us-ascii?Q?ig=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: afa732d6-bd11-47c4-b8f3-08ddc76859c1
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2025 08:35:15.5389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +AgpZe7uPhYOCnzGy+kx4tpYHHJeaeBlTU6dyxlJZqBZx9D88iyb0aCkOvm9VSZkpDPOBU/y4SC/6cuM8Fj8Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8703
X-OriginatorOrg: intel.com


Hello,

kernel test robot noticed "kmsg.sanitizer.direct_leak/__interceptor_realloc" on:

commit: 738c34064b92cfb47180911f409e393e78a96818 ("[PATCH v3 2/2] perf test: Add sched latency and script shell tests")
url: https://github.com/intel-lab-lkp/linux/commits/Ian-Rogers/perf-test-Add-sched-latency-and-script-shell-tests/20250628-092510
base: https://git.kernel.org/cgit/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
patch link: https://lore.kernel.org/all/20250628012302.1242532-2-irogers@google.com/
patch subject: [PATCH v3 2/2] perf test: Add sched latency and script shell tests

in testcase: perf-sanity-tests
version: 
with following parameters:

	perf_compiler: clang
	group: group-01



config: x86_64-rhel-9.4-bpf
compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz (Kaby Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202507201046.5842fe9a-lkp@intel.com



2025-07-10 21:48:29 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-738c34064b92cfb47180911f409e393e78a96818/tools/perf/perf test 91 -v
 91: perf sched tests                                                : Running (1 active)
--- start ---
test child forked, pid 10659
Sched latency
pid 10663's current affinity list: 0-7
pid 10663's new affinity list: 0
pid 10665's current affinity list: 0-7
pid 10665's new affinity list: 0
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.335 MB /tmp/__perf_test_sched.perf.data.1IqjN (1973 samples) ]

=================================================================
==10672==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 67 byte(s) in 1 object(s) allocated from:
    #0 0x7fdf4ada98d5 in __interceptor_realloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:85
    #1 0x7fdf4a2723e1  (/lib/x86_64-linux-gnu/libc.so.6+0x7e3e1)
    #2 0x4f63ab0b0c0befff  (<unknown module>)

SUMMARY: AddressSanitizer: 67 byte(s) leaked in 1 allocation(s).
Unexpected signal in test_sched_latency
---- end(-1) ----
 91: perf sched tests                                                : FAILED!



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250720/202507201046.5842fe9a-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

