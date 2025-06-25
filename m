Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E987D202987;
	Wed, 25 Jun 2025 07:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750835430; cv=fail; b=tSdfKhnQLa89Yurkuq5VFt+dar+88r7WZCp+jpbzJjp56wHgcvoETYvvYvzGT4WmRYr5OAmZBOgvY7RhNHMGWVHVMfACosPCwrqHmPcNfckZjrED4DHa6qK9awiIKKQscpwD4M9sPLb9p1Ke4FyAhK72qXbShYFI540/xkb2atU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750835430; c=relaxed/simple;
	bh=t9L/npubXnhzjRKEZBXvyelW1n4aupwZyp9SuJE3l04=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=IsFbjuuO5TzqsAYoIhNj9HxHNSXb0t52nfZvx6yH9RK/0yNjeA3qfrOotyCzZ4NXcUZW7yUYotVz6a/EENyRBwWGigJvdNWgBtrALZWEbJ15VJUbzr8kM2wRrj2XAlqBlXq+EsQokz4M+MXqxuAe2vj8j8+nRI0wUPIq9rYPSHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lYJxGBno; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lYJxGBno"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750835429; x=1782371429;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=t9L/npubXnhzjRKEZBXvyelW1n4aupwZyp9SuJE3l04=;
  b=lYJxGBnolPLnw5Ic0l2++s3KrjA6OV9vUxx1Q2xBfQDPnJNRMHvr2PRC
   5ztxo8FZuLLsb1Qs3rQV+Gf27D+ivP3tiZ2lA8XIb9Hfscj+pL6U/OYiK
   MsCRbLIv8tvY4Ipv9kM4/2FvG+ubrumIO/Cj28mbg71YpTipgv5CoBCaL
   oFIpOPMgVBxm4Zd+fHtTR064MKX4FuLCoSxA7x5A32K3J+hSTpNhP+sjZ
   5w7FeJOdD8/g5phWhCivqjbLUzd+rUunn/EBgGQyeiPn25FwuSTBf3N1q
   du3fanEFjy51Rw0WD+w4gySdJZhExPxY9xuxeW+OIIJ7IyQdd7zv7c59H
   w==;
X-CSE-ConnectionGUID: wEGFL65TSImcXb8RZ/4HvA==
X-CSE-MsgGUID: +He8zgO0R/WObr5Fm+2DWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="64449033"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="64449033"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 00:10:28 -0700
X-CSE-ConnectionGUID: ULJAqDUWSQWxLGSCO6KIkg==
X-CSE-MsgGUID: edSQjTXISdq4G96/burmPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="152425030"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 00:10:28 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 00:10:27 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 25 Jun 2025 00:10:27 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.56)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 00:10:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fcDjvo6tJ9rkAoG6epUbxwKObdPxvtV3uO1k6zRs5FSvHdHaU1KW8w9e9/3zmlXe8GW7Phx+jVnU0vAWofTtCdB88bgScZ3sN0+te/DafFhRINjkJ51FZOzwgN3bgPH81bKH1nTUWaYrUbcMfPtNV53OrG43gtv3M7k4JAguFWoUbVyPYQ2arrLra9Fhqb/RHrIFqAgGf9o7a+Mh8te5wOZlGdT9kPCLcI1p6xu4tnmNiFxixTTLED9C9ftNKB0FOyAF/SQ8I7FXHrA+VzEtIAubEOklBi6i/xR1lsikclKa1z7SVeuVf5zs0fJYFNCwLpS4s3ZfUdu6bqcO1SkvFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9MGzszZh8TNBbzPCAan7t32n4mn8pMANXC1VWR02e0=;
 b=Wg0rzsmMwjGazlCCbS+aDljnp0rHslgMNZjG8LkWdJ5fVSc3nLEULquyvBYxS0ZojUuQccza/XxQYQTIWmEUNF5ZQwvhfNvgklZd5OSMpnvbgGmTO7NT4tiqiAdZ9cKDxsNNbC0pr6ESDZOCZv76/gftWbWcdA6Qj2uEEykweJHrbXrdyrZ8c4i5Bx+riaNj5B5S/NOeW/NgODzRSjABwnKy2XmV4CEHPouUSxsaxX4iQ2mmUN72QCiat6KniHUcZi5B6jz5dd6SUXk6Plg68IILJEMCGDSNdNb/eDgO8itXldHr5A01LhUSNDCEiAeCAIe0mxk7tqb+5i8yYui3ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ5PPF89507EDE4.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::83e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Wed, 25 Jun
 2025 07:10:26 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8857.025; Wed, 25 Jun 2025
 07:10:25 +0000
Date: Wed, 25 Jun 2025 15:10:17 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Ian Rogers <irogers@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Namhyung Kim
	<namhyung@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [perf target]  5ddf4c3a17:
 perf-sanity-tests.perf_record_tests.fail
Message-ID: <202506251422.589f230a-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2P153CA0030.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::17)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ5PPF89507EDE4:EE_
X-MS-Office365-Filtering-Correlation-Id: ed3f079f-358f-4269-58fd-08ddb3b75bd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?a55LSkhRyMVUc7u/T2knttSYiMnyE/ajWpzlmfgW+VX6zQ/N0cakTT+SKUAL?=
 =?us-ascii?Q?ZNoHnfMotA14OxSiQdbSF7JKDAAWB8TA49r7wFamUhdS86Y4bZ8KIJjCPmC6?=
 =?us-ascii?Q?CVT4lL5Q8lUp9rSC3vqYuhx7KJ5emPuLU4fzrmygmmsjd7tFZJMn00vqd2oS?=
 =?us-ascii?Q?9E7DdGUp+axnIjLSLADGqNbKPdYQ40YElOKBFOA3LFSO6GeeW6JXQgIiiY3a?=
 =?us-ascii?Q?KI7nvDScsdco7faEy85gt2DvD7D+X/sm4HC04V42PDOzV76Qd7WORXWAnpnF?=
 =?us-ascii?Q?SJ5dD4N0yMq3VOEUMzr8Ib2Gazitu1pICbWFbADFn1etypvfnFmzptPlBRrn?=
 =?us-ascii?Q?oBQYugTn6yYWGHm6pYMu1uMnbGMqnxqUnc3WfcGTHC1+1cV7Gw3CT9nRDIHc?=
 =?us-ascii?Q?/9oc8QXYChT6FZO0ms/J1K0JmDn2kCqgoGGVLS3blimV2JhIQvTqgkoonngf?=
 =?us-ascii?Q?EzLFDq5/JI6AuBUd2LQ98s8ka7bjYa+CzwFxbEJCZTNCsQn3Yj9RI/LLKvgA?=
 =?us-ascii?Q?DA9YKUOdVmtGqOYXdJ+/kuhGoBcnxD5kn9oUW1PY+xu/NmZa7Rz0Xm/95J4X?=
 =?us-ascii?Q?CBdntt9grAd5T4IAy1oIQQ1muz3FJw7fnYtY3tgabYJNOfaptiNqEW0r9yk6?=
 =?us-ascii?Q?t69or1RG3CJgoow4Fwq41VN02wurdJtz9v6WT6gudqcKRRDhJK7Wv2zTb5lT?=
 =?us-ascii?Q?jySqa+SnM/e8+07TewU9FcBO1pUOKAk9Ks5inZ+Zfj4KvygIrvoeqW8eLXdl?=
 =?us-ascii?Q?+3lBIQeHunEofU2vcdTyuLhv79zbP+20aC0Y9+pFMjZ8ZglPPxlllvnDdu09?=
 =?us-ascii?Q?Cf+dGxTwOpgt58A5+LEOxO+WoQ8ZejMy/SdC8RHoW2cqELW7mCSm8lC7fee3?=
 =?us-ascii?Q?uMrisR2U9CdhQW3QjdMyitvLivvvX7QqWUWkdreqkd970YeFFJRLPJUMNsTJ?=
 =?us-ascii?Q?lsijMgX4H1U3FuurD4gYwdrgin8vOXVhw8bzc48REtG7wONbCSn0kJ8j8wxP?=
 =?us-ascii?Q?fncI1OE5RrPi1MqcCkM+PF221LyS3n95Oapnfv1HDOKaFN/XyITzQiV3LrKm?=
 =?us-ascii?Q?ecDLwYgsUFQ4LM5S0JQkZlJ1/ADURjkaha/yU8DRcHIT+elAZG0ea8xoQqi4?=
 =?us-ascii?Q?b3Ai2xnktcxtc5U3vHOWHhejUWBPHMysNrvO7GNZjojRVG37i+zF7jyxYuaz?=
 =?us-ascii?Q?Oq1Ve4wC11145kRHfDoDqlvIFkRDN4DHWtJaQYmmf8aBBt8lhuDAos22A3cY?=
 =?us-ascii?Q?9yQ4iMk0eMeTZhgU8Rv26CcNmYBk4cCtDOxeucvormCDTntj+1EgHNuVGpHt?=
 =?us-ascii?Q?GzeRMmqF8nLlw7ccfqdCRzDOJHqipMs3ZXZUpZOiI7/HQexyyprqLqS9UBh7?=
 =?us-ascii?Q?14yrnSQcPZG8bp/0FBaVzm9niWWi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2W6ALo1GC7E2/uXtXBvMrAxMNnenLycZMi3bxzGhJzUsrRYxdGI1gbF2I0pg?=
 =?us-ascii?Q?+m79Ni7NPw32brzuZvAbdQi3S9jj5rHxHSedVN6e4kGi5h2p4GtWOXVlgjNh?=
 =?us-ascii?Q?hz7jAVPVxCVXnS5s4+Lc+/LalX/dz6mOMU5UFftCy7WX1CoWKJhrsJQQ8c2h?=
 =?us-ascii?Q?k9aowx2E/+wbPHicnSQsG5Dlsm/yeuqPkeMKbHl697u/2cW18X2+p9Wr9KGq?=
 =?us-ascii?Q?07SipXAO+shkluhfgSRAhZDPBbU7+0CxAW3oX0KZVOJjONijdn8YQSgeggFj?=
 =?us-ascii?Q?J/nkpB6pxwTwB3VfAltiG3zxxNdvHSrB47ndK1SoyjxXXMz0huomvK5bWQAU?=
 =?us-ascii?Q?t6r8m3NsyZFrFXotvm8n+PE8DiPXuoSn4Apj8ptFjgnMxYiyaX6gTWeADJPn?=
 =?us-ascii?Q?lkFObshXSKG4C3x42loXbB5B2pscJj/zGW34ZBGG+2Yi3BZB9OncE1UpTi4l?=
 =?us-ascii?Q?HtOEnIx3usCep9fMl0X9e1pgBjKUiYAu1jJw2CIsE62qlyFKJJWkRvKma5xN?=
 =?us-ascii?Q?/UzepAPsSlOgs9pH4fmHNJw2c4fZCI89i2vxNGtHDu87NgGDYHNIF3N4HM7y?=
 =?us-ascii?Q?CSOQOF92SWkISDcgcSINj8l7w46k0TmxJLMw2XPYkfq0eNJJFsQUCYaObPXO?=
 =?us-ascii?Q?O3cMwaCMfeisEP5BNYIKdb5CjrFbjBVBKayeNZmytmXm2stt2Ot7KtGRF/QF?=
 =?us-ascii?Q?Zq2+M1/hpWcf5EwYsXGAf73XWohSFtVbN+F/hLh3Q2hLIzhG40kIJ/4kxnPd?=
 =?us-ascii?Q?nDMv5dVFKmAzie9IiUg4LSkqoDXt9nNzAnfcMm5rqFXleEjNvamiMjJY4rvn?=
 =?us-ascii?Q?HqnvAkNQf9q1cTQCgvvpIZ0kJt7eOXwJVZ+6o8fxnrqUqisqh2wzkS6pgHXt?=
 =?us-ascii?Q?4WgzI7krUwyGJaIpEHhft4UZg3dpsfrNLRVlairsYjwvRsjTEgEvl2QjWO07?=
 =?us-ascii?Q?omol06if2PF6beebI9mZGJzp2JhwScE4Y94BGmljY5jOr/NMYpBWyyM3ohuy?=
 =?us-ascii?Q?8xenc7XNPx+ICPK6JplQF6/8MzCVW0cUdS0SvU1S6QZo1/nelSZ97hNb8+uS?=
 =?us-ascii?Q?iVBwIJfVn/chiY6xn3PR+fYyhz++BxhyA9jRytGfUYtawWZg7zZRBpb1O/Dt?=
 =?us-ascii?Q?HekBzqTcV3dNylNIfnrOw60MiJArgejrFcWy+2R+BGDJ5LsMAmJ2x7WMlww3?=
 =?us-ascii?Q?0noTU9zyOuLDprOu9uCaZ+NbaxGNERwESxvhPNobs29qD+nhDI+6/JBw1/XT?=
 =?us-ascii?Q?2z9rFo6c90lRijcgl4V1e679wRMXT+qaPyBPD2qtqYQXhnLO49wHj7fRo1p1?=
 =?us-ascii?Q?OtYWN8GX3/Rwi9eaCgsJX7ItGWgYcG256jq8moF0/ppZ7KDQLGbHgrbgCpTl?=
 =?us-ascii?Q?DfsRGtuHguJK4jpmAT8FLvioJNGU0MsYzFcK77DfMXy7QFzgfxivZveZiYOB?=
 =?us-ascii?Q?kPYgmUEctiKJMNu08hhdWz2ENk1DM3LKIa3hke57UA/Y0IvV2kWMznMLn8qO?=
 =?us-ascii?Q?4RCTQM927MQdXKKav0i1tpdoprebTFabYaa6sgpc/IbjAn0oU90U8YYzL+Wr?=
 =?us-ascii?Q?gt4rIuCKcsryffp6ukPj7JnUa6wC+WlBZyJweLq4PgtcDzLo6Ym6bpunvYkw?=
 =?us-ascii?Q?lA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed3f079f-358f-4269-58fd-08ddb3b75bd3
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 07:10:25.9005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7X/pW9V0e/jUni5O1cHevr3EBnDTa7UeivZ+VfpLiGgsg9onhJZuaCe6+NaJdsmLIOKRICuwiHvUIm+O+YnXKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF89507EDE4
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "perf-sanity-tests.perf_record_tests.fail" on:

commit: 5ddf4c3a17dc499fcbaf35692bc894340062dee8 ("perf target: Separate parse_uid into its own function")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master f817b6dd2b62d921a6cdc0a3ac599cd1851f343c]

in testcase: perf-sanity-tests
version: 
with following parameters:

	perf_compiler: clang
	group: group-02


config: x86_64-rhel-9.4-bpf
compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz (Kaby Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202506251422.589f230a-lkp@intel.com


2025-06-22 14:23:54 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-5ddf4c3a17dc499fcbaf35692bc894340062dee8/tools/perf/perf test 126 -v
126: perf record tests                                               : Running (1 active)
--- start ---
test child forked, pid 8698
 13bca6c-13bcaa5 g test_loop
perf does have symbol 'test_loop'
Basic --per-thread mode test
Per-thread record [Skipped event not supported]
Register capture test
Register capture test [Failed missing output]
Basic --system-wide mode test
System-wide record [Skipped not supported]
Basic target workload test
Workload record [Failed record]
Branch counter test
branch counter feature not supported on all core PMUs (/sys/bus/event_source/devices/cpu) [Skipped]
Cgroup sampling test
Cgroup sampling [Skipped not supported]
Basic leader sampling test
Leader sampling [Failed record]
Topdown leader sampling test
Topdown leader sampling [Skipped event parsing failed]
precise_max attribute test
precise_max attribute [Skipped no cycles:P event]
precise_max attribute [Skipped no instructions:P event]
precise_max attribute [Skipped no hardware events]
---- end(-1) ----
126: perf record tests                                               : FAILED!


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250625/202506251422.589f230a-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

