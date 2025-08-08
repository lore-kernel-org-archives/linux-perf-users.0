Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC4F1C5F27;
	Fri,  8 Aug 2025 06:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754634566; cv=fail; b=SqJSkhyS4NTaefMxsvZrKJ2rqEZErj6VqEO139lYsZJvzamuZML9UNsFxNpGHAX1cxsSVFxBbhQeQMFMyd+bn7G6a+6X/21Kzivt/XoRlTr4/sY9LiJLg7uHCWrRq4HawoiRIyn2zTTyvkwp5ywEEGwMctaQXwUKTokez83Jfuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754634566; c=relaxed/simple;
	bh=uS9r851ceNL4d5HnKYAhjHREXCkys8mdYctPGW6ya+I=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=FEGZSY89WghgTij+uk+jjNLfJYMEtbJw0N3p4wm9Ki9azp76EAeiOFGfk0unrmSOOrR6Qy8+cKCa2ogQgOeYjsVqX2Coy3WXwncyu54fBQL4/MjBL6HZ1DCXnD9Ac89j1dXUHMTvVCwg37Ve28Ivt4VD+YpEAxk02pqudMtFpro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XMspe2mz; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XMspe2mz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754634561; x=1786170561;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uS9r851ceNL4d5HnKYAhjHREXCkys8mdYctPGW6ya+I=;
  b=XMspe2mzXX4QLfmZEZDQPa9vw0kMCEsbpRmPcCBCELUjioY+EjmIM/Eo
   KQplkqtxoBRML9W6KGPavCG3EPr8WJYry7ZG74tiGMe9gqqURtaHNRpAF
   g6Zm+nAYEJ9XqbJpLn7WOXR38BuG02ph5G8tqcW/o0RUTNdTZY+WvOuLp
   JASgBUF30tgIEkO838OtT1kOZu1rN8tZBZIimTWnXeaVJUgbCSvhyN1tz
   t8hekrBHa6UJ0eQktw6L8E9pWv00uaZaUDDBe2wBIpxAeStdHtpR3JUPp
   U+2tyjGATyHBAQ7WT0NjFYA9PzesM1CEnbF/QAtXwt/MOn/F3tFQGkp7M
   Q==;
X-CSE-ConnectionGUID: 9sF7uzyfTViCdAsNjozY1g==
X-CSE-MsgGUID: ZzXfdG/LQZiCAuzTV7lcug==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="74433321"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="74433321"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 23:29:21 -0700
X-CSE-ConnectionGUID: KG96Lgi+Rq+gYZ8rQMbERw==
X-CSE-MsgGUID: j6r71ZUBRkq3twQOQcXciw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="169382592"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 23:29:20 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 23:29:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 7 Aug 2025 23:29:19 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.81) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 23:29:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OS5OuQwDOCO93f2bEYuFX9GRYSpwIHtxx8ZV2dccii+bFej6QSgz+gU+FmOwial3E6aXLq8f4F0q8JNxEOtKkYio+q0J2DukCarjPpmfpX8wIoBm8iVwiQwHBAxB3Oo8LOewCJ2+AUJAOFGX2yE7aPGqin4hafZHY1SAkpIR0njQC2P/6wHH515PbPd3xv2Drh0k8qEffxqUrOsmR8T1mrDcZOB59WMz5+Uqf8pj+MG6YOqv574EsS309uG61U+L2SS7QnH/g17lxn62U+qU/8FBfR44HKgaRM3DPe9D974zQHBau/N7mwZhwy3C4chEKfUhwxJGiVQFbw3AafY/Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=baSJuX0RqrVx4taBFALMsbD5KnB23K6btGBKQuMzcCs=;
 b=U6omA1QZBxjwadB3w5EGT0ySXBbWXx5WVwXmBuyqpAGuFxDGIlU99y40KtyRKjCS2JDduQNZz+peXklqsMm5Ghmmw2AGrkquPEeJQtZaQjsihUaMrFqNkZQq2T49o+a68a9g7m74fSGjTeCzpIFsnkRTAiIJauWzHeyI3WvpzTvIKpaEfvUWgQKNdMEPm6yuRXx9E0U5IK3rriNPBNYEouV8It0/KYomAX4K3wp6rWtng+OsgI4hhycHFZkhr1IZf43P5W5cHzrGHbhgR+Dd0roywfa3hrVQoeOeacFirmWF9+2IkxlLz5QdoHeIK7ce2M7ChYhZugJ9xuxOrOkiTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by BL4PR11MB8872.namprd11.prod.outlook.com (2603:10b6:208:5a8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 06:29:16 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 06:29:16 +0000
Date: Fri, 8 Aug 2025 14:29:07 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Ian Rogers <irogers@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Namhyung Kim
	<namhyung@kernel.org>, Thomas Falcon <thomas.falcon@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [namhyung-perf:perf/annotate-code-type-tui-v4] [perf vendor events]
 8b7b7e8f8b:
 perf-sanity-tests.PMU_JSON_event_tests.Parsing_of_PMU_event_table_metrics.fail
Message-ID: <202508080756.8c64d87-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|BL4PR11MB8872:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b9c8748-0f47-4639-f699-08ddd644e5d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?B1wWdfkJAYXOa5Gp8+ZjklVvnFAb+vlrQDi+n4l5iJsex9NrgoWEGBtqo8OD?=
 =?us-ascii?Q?0Ojt3VqTkv/Z46bPbbpOaAEongGRN5dHkXffAuuoW99/pvGU7Ud3JmQUG3WK?=
 =?us-ascii?Q?3C6fLnuJVeF2yLxHdFXzJOBHZ2Y7wxtHwJyNGWGsU6rUEBo84hHjFr8Bdg7F?=
 =?us-ascii?Q?efM9n/e6e2FohDC6AAxamk88R9cpbYD1O0YaWlEPu+jBxhszc2C2gPwyitKp?=
 =?us-ascii?Q?zTfvO21Utp7f+E+3Od5V9OcWBkrxLBMvTeCjVWWgZ22dZoB04SPlh/dJN5xe?=
 =?us-ascii?Q?KJAelKAzy6+9swK76MW7e1ofmBAVdXQivR7hmGRCbg9tykWozcXQM5+bns1a?=
 =?us-ascii?Q?rndnxeY2PHyMVEISh2bz6hwxPt8B+icGV/cMFKi1pFsin63zqeI89SCT746m?=
 =?us-ascii?Q?4hal3k1rlNjW4damV1J4R/PJWAzRvPvZ3y9skhfG60KXnitQd920kCelI5KU?=
 =?us-ascii?Q?04xdSQSQnyMV3uaU2QwXUN7neIcLDjIo3uXKkSdMBKMbdCR4ZWWoAUWUEHPb?=
 =?us-ascii?Q?zUlwt9OjKW4RAV7UqGSc7jsgqfnGRBFH+ib2xLUHl4fHuSWC0i3JbMaMleP+?=
 =?us-ascii?Q?Hda2OB8xkvdeHStkhIGZa7RfrDauBzkthGKIaYJKqRTiDccJNaJTDILbOtqO?=
 =?us-ascii?Q?y+c8e6E4gSffz70KdTdBUpdUWBHCPyq8frRw09V1k299hUFjmoVWPpQgOfwh?=
 =?us-ascii?Q?lgidKFSMDMKlut1QhmEnguLCoIgpKqioolTDIYwd5S9u3EjUbau0i6Aooi5N?=
 =?us-ascii?Q?6pyC7lUtJ8lI4fXDOI6viVj97SGYDGd79VVspzZlHIwY664o/qWEQlIAh3S2?=
 =?us-ascii?Q?P8rYzgybNAxF0R98SjFzSx57NBZy7ikFsRWTm40IyYnW9xR2P/xapfIQlBCm?=
 =?us-ascii?Q?mpB4sWYXlvI0YEuxcmPQ050X/oTWy/pK2e1eU7KYb/mHedjs+jELXdbxExQE?=
 =?us-ascii?Q?mb0nzPtv7aaedpiGToFbCdEPlGrwkH7fIWj9Dk7MH8rB1XbOzr1dMG6otfcp?=
 =?us-ascii?Q?KRTPTvU1O6GWn+W7foDdpQ83hpl7VLoyJzXg6Xvae0doeEUtBCrelDCw2Ory?=
 =?us-ascii?Q?oKtdCPbLBnBIwYbVLYygGZOGKHAEwkuaoNrFS2JbqRYFl1gNIRcmBtRucMpy?=
 =?us-ascii?Q?YSY6t1BBcjeTPSLJETQUlwuqHnqwzGPtW53PkfAzfQ1f6NJEkC1YAIAEMmwq?=
 =?us-ascii?Q?g4hn6MlCkd8YuzMsAj+aPafMr7fw+ZQvTsUziHkJvYBBY2piHCrjJi5lBIop?=
 =?us-ascii?Q?MNLNe7WT7b0PXFSqD2x25V6YCKnLyGffvYaoiNaq4fKVGyfqYJwdrzGPKGPJ?=
 =?us-ascii?Q?81YeUQn+wCq5KoGnOmzj9xN85ypJvvJd9SGOg2xcdbx/RFNu5YYLUUlzByAD?=
 =?us-ascii?Q?oOxe2Fkaru1PV0kvwhrSwaZcryJO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zyw6bJJONXHTipsCJI107NA3VX/2UbwYkzGx0HjAmq+35s43aslJELd69l2s?=
 =?us-ascii?Q?bSJSxMnBw+0yOLeeJVp3L1qPWHJrN/Mr3dsj2WuupAD47w+e+rq+Qp6RvH+H?=
 =?us-ascii?Q?hy8v3MeHAwEeCm1luVzNOELpCh43DSoe9KuLo0hG2zKEe9DcHg2LD7u6kNMJ?=
 =?us-ascii?Q?+tK6orRlWEZCATN3YEB5kK/PoI3Sly5BITlrElyWZ4hLJEBXUKZw7N1l9Aqw?=
 =?us-ascii?Q?EQ7KA/ZeANWkuRgOr4Bpjs2VZrLpxUW/GA2XpG4A4s+fyTFplSAVSAjIxcQx?=
 =?us-ascii?Q?cE+FRtJXPBeTRHZOpbyfKo5gmE3WN/pypRGFRt0eJy/dfzPHxpGBYebGZ/r4?=
 =?us-ascii?Q?ZxfoBy9oYrj1YCVIskWT1v2HgTrtif/VXxsvGD8vHWMNd/H0/VTJ+FMHuiE5?=
 =?us-ascii?Q?ud7Juor/JHX903+UrNO96Oc+HwJ8Ng8q86glLMg4KlW/UoxNI7b2vdAnmj40?=
 =?us-ascii?Q?c6mAoTjFCUKLlXNxbSJBa1FJD53eZ3Aa+BIua1FY+0kUZfPOR09x+HlmbUL2?=
 =?us-ascii?Q?Sa5FeHd8JhW2JiXR6ce+SkhrfcR7eRw6eBWEPae5t6ek5gVlkWc57Ebfloqr?=
 =?us-ascii?Q?8gd+XPkDOkYDpnmWhSmLq1YDvsaI64LlPpeFSBsKVJNpgTfFJyD5DtAYSVMW?=
 =?us-ascii?Q?296Z/0sg7FYnjz3yPRPZgD6PpIgJfWQPdPPc5nxbmWVZF/MaG2YIhUQDIRVV?=
 =?us-ascii?Q?Ty0IIlsdqSuWz0mGEgR/YWjN0q3AJgJpxNErW4B1NQQ+CR9soByvgj+iup4v?=
 =?us-ascii?Q?FNfmyTveK+sJa8RPQRXCSmVkNaJoiDcZHgoZX1mYtcDELcFyh3aNaIEZqQXr?=
 =?us-ascii?Q?dxgkKh21ginDGbiJZF5FN2JfI46S8v7lxK0Y4N7LBG0eWGGVV1riUnKATCuL?=
 =?us-ascii?Q?JpF6djyA03htRic9GNoJ0V59DEmNiJjljYyjMSQ0pZhBs7sBALxA0akT2UpX?=
 =?us-ascii?Q?+m3bH7Pw3KX6wzV1FBqpGlpYvU5IwTXGYKrzJ9/tnJMKeyCWHlijImox9BFu?=
 =?us-ascii?Q?aaT8L0h58K9dr/2Lj5GkRXb1U99C2hyUXnL+8oiyaHgl7DWNHX04e0JIdDjp?=
 =?us-ascii?Q?HnYxI6jeLGRz5ANDZ1lFdu+zUhZ+3cYOCiklukjqdC5RnK12fzEVWLzWNl03?=
 =?us-ascii?Q?96ehmevOdLqGrm7WkK4R/4L2t7Rq7vtaCrsG+6lCw5C2uVJ+zEOIhK3qQY4J?=
 =?us-ascii?Q?0mFKKPmlmrMKs8DRGiMx0YdNdCv9YYm903Kq/EXM9BgUPCt+/zjs/Osh2e9+?=
 =?us-ascii?Q?OS5hYOB/6cH769926b0TDfzB4Q0e7O4d4fsfT6uVXXawQu8vOkaVLn3QH653?=
 =?us-ascii?Q?jCZsMYYlctlYmadXjlb7woMfVEgd1UGiFwWJaKb9OR7O7/i5xDpM45sZrlAU?=
 =?us-ascii?Q?jmrMhUQkAClB8S1J8zaM+uxfrOWzbHNTwWzHPXPt1kLXSalIJmj6pw8QPwVx?=
 =?us-ascii?Q?n3z7X+wN9pKphzl2tUcEQZxdxRU5071Q+FbTzYspT8G61YCMUyvoKEHOXwNZ?=
 =?us-ascii?Q?qiHC80IKHMFW0cLw1au4tC1pFR0IVqcjk2UkBFZ8Cs0/twzMmsgMJYgjzUzG?=
 =?us-ascii?Q?0Bhs96Fj1Ehna9BrrSKd7nvi/r5BnBM9p5Ru0hYJSGpG4++jdEF2cISdeXQW?=
 =?us-ascii?Q?wg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b9c8748-0f47-4639-f699-08ddd644e5d1
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 06:29:16.3823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jMM2tAyVkOGWkZehOIe0x/aaioM/GDybS3gY00Tdxu4Luv/Ijh1X39vIHpgiWNAnExPSsGK+7DUWrbn5++buzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8872
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "perf-sanity-tests.PMU_JSON_event_tests.Parsing_of_PMU_event_table_metrics.fail" on:

commit: 8b7b7e8f8b93a84b46de3a886c5e8f4996d99e84 ("perf vendor events: Update alderlake events/metrics")
https://git.kernel.org/cgit/linux/kernel/git/namhyung/linux-perf.git perf/annotate-code-type-tui-v4

in testcase: perf-sanity-tests
version: 
with following parameters:

	perf_compiler: clang
	group: group-00



config: x86_64-rhel-9.4-bpf
compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz (Kaby Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <olive.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202508080756.8c64d87-lkp@intel.com


we observed two tests become failed after this commit.

6e19839a80b8713b 8b7b7e8f8b93a84b46de3a886c5
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :6          100%           6:6     perf-sanity-tests.PMU_JSON_event_tests.Parsing_of_PMU_event_table_metrics.fail
           :6          100%           6:6     perf-sanity-tests.PMU_JSON_event_tests.Parsing_of_PMU_event_table_metrics_with_fake_PMUs.fail


--- start ---
test child forked, pid 7468
Found metric 'CPI'
metric expr 1 / IPC for CPI
Using CPUID GenuineIntel-6-9E-9
metric expr inst_retired.any / cpu_clk_unhalted.thread for IPC
found event inst_retired.any
found event cpu_clk_unhalted.thread
Parsing metric events '{inst_retired.any/metric-id=inst_retired.any/,cpu_clk_unhalted.thread/metric-id=cpu_clk_unhalted.thread/}:W'
Matched metric-id inst_retired.any to inst_retired.any
Matched metric-id cpu_clk_unhalted.thread to cpu_clk_unhalted.thread
processing metric: IPC ENTRY
processing metric: IPC EXIT: nan
Result nan
Found metric 'DCache_L2_All'
metric expr DCache_L2_All_Hits + DCache_L2_All_Miss for DCache_L2_All
metric expr max(l2_rqsts.all_demand_data_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss for DCache_L2_All_Miss
metric expr l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hit + l2_rqsts.rfo_hit for DCache_L2_All_Hits
found event l2_rqsts.rfo_miss
found event l2_rqsts.rfo_hit
found event l2_rqsts.pf_miss
found event l2_rqsts.demand_data_rd_hit
found event l2_rqsts.all_demand_data_rd
found event l2_rqsts.pf_hit
Parsing metric events '{l2_rqsts.rfo_miss/metric-id=l2_rqsts.rfo_miss/,l2_rqsts.rfo_hit/metric-id=l2_rqsts.rfo_hit/,l2_rqsts.pf_miss/metric-id=l2_rqsts.pf_miss/,l2_rqsts.demand_data_rd_hit/metric-id=l2_rqsts.demand_data_rd_hit/,l2_rqsts.all_demand_data_rd/metric-id=l2_rqsts.all_demand_data_rd/,l2_rqsts.pf_hit/metric-id=l2_rqsts.pf_hit/}:W'
Matched metric-id l2_rqsts.rfo_miss to l2_rqsts.rfo_miss
Matched metric-id l2_rqsts.rfo_hit to l2_rqsts.rfo_hit
Matched metric-id l2_rqsts.pf_miss to l2_rqsts.pf_miss
Matched metric-id l2_rqsts.demand_data_rd_hit to l2_rqsts.demand_data_rd_hit
Matched metric-id l2_rqsts.all_demand_data_rd to l2_rqsts.all_demand_data_rd
Matched metric-id l2_rqsts.pf_hit to l2_rqsts.pf_hit
processing metric: DCache_L2_All_Hits ENTRY
processing metric: DCache_L2_All_Hits EXIT: nan
processing metric: DCache_L2_All_Miss ENTRY
processing metric: DCache_L2_All_Miss EXIT: nan
Result nan
Found metric 'DCache_L2_All_Hits'
metric expr l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hit + l2_rqsts.rfo_hit for DCache_L2_All_Hits
found event l2_rqsts.rfo_hit
found event l2_rqsts.demand_data_rd_hit
found event l2_rqsts.pf_hit
Parsing metric events '{l2_rqsts.rfo_hit/metric-id=l2_rqsts.rfo_hit/,l2_rqsts.demand_data_rd_hit/metric-id=l2_rqsts.demand_data_rd_hit/,l2_rqsts.pf_hit/metric-id=l2_rqsts.pf_hit/}:W'
Matched metric-id l2_rqsts.rfo_hit to l2_rqsts.rfo_hit
Matched metric-id l2_rqsts.demand_data_rd_hit to l2_rqsts.demand_data_rd_hit
Matched metric-id l2_rqsts.pf_hit to l2_rqsts.pf_hit
Result nan
Found metric 'DCache_L2_All_Miss'
metric expr max(l2_rqsts.all_demand_data_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss for DCache_L2_All_Miss
found event l2_rqsts.rfo_miss
found event l2_rqsts.pf_miss
found event l2_rqsts.demand_data_rd_hit
found event l2_rqsts.all_demand_data_rd
Parsing metric events '{l2_rqsts.rfo_miss/metric-id=l2_rqsts.rfo_miss/,l2_rqsts.pf_miss/metric-id=l2_rqsts.pf_miss/,l2_rqsts.demand_data_rd_hit/metric-id=l2_rqsts.demand_data_rd_hit/,l2_rqsts.all_demand_data_rd/metric-id=l2_rqsts.all_demand_data_rd/}:W'
Matched metric-id l2_rqsts.rfo_miss to l2_rqsts.rfo_miss
Matched metric-id l2_rqsts.pf_miss to l2_rqsts.pf_miss
Matched metric-id l2_rqsts.demand_data_rd_hit to l2_rqsts.demand_data_rd_hit
Matched metric-id l2_rqsts.all_demand_data_rd to l2_rqsts.all_demand_data_rd
Result nan
Found metric 'DCache_L2_Hits'
metric expr d_ratio(DCache_L2_All_Hits, DCache_L2_All) for DCache_L2_Hits
metric expr l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hit + l2_rqsts.rfo_hit for DCache_L2_All_Hits
metric expr DCache_L2_All_Hits + DCache_L2_All_Miss for DCache_L2_All
metric expr l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hit + l2_rqsts.rfo_hit for DCache_L2_All_Hits
metric expr max(l2_rqsts.all_demand_data_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss for DCache_L2_All_Miss
found event l2_rqsts.rfo_miss
found event l2_rqsts.rfo_hit
found event l2_rqsts.pf_miss
found event l2_rqsts.demand_data_rd_hit
found event l2_rqsts.all_demand_data_rd
found event l2_rqsts.pf_hit
Parsing metric events '{l2_rqsts.rfo_miss/metric-id=l2_rqsts.rfo_miss/,l2_rqsts.rfo_hit/metric-id=l2_rqsts.rfo_hit/,l2_rqsts.pf_miss/metric-id=l2_rqsts.pf_miss/,l2_rqsts.demand_data_rd_hit/metric-id=l2_rqsts.demand_data_rd_hit/,l2_rqsts.all_demand_data_rd/metric-id=l2_rqsts.all_demand_data_rd/,l2_rqsts.pf_hit/metric-id=l2_rqsts.pf_hit/}:W'
Matched metric-id l2_rqsts.rfo_miss to l2_rqsts.rfo_miss
Matched metric-id l2_rqsts.rfo_hit to l2_rqsts.rfo_hit
Matched metric-id l2_rqsts.pf_miss to l2_rqsts.pf_miss
Matched metric-id l2_rqsts.demand_data_rd_hit to l2_rqsts.demand_data_rd_hit
Matched metric-id l2_rqsts.all_demand_data_rd to l2_rqsts.all_demand_data_rd
Matched metric-id l2_rqsts.pf_hit to l2_rqsts.pf_hit
processing metric: DCache_L2_All_Hits ENTRY
processing metric: DCache_L2_All_Hits EXIT: nan
processing metric: DCache_L2_All ENTRY
processing metric: DCache_L2_All_Miss ENTRY
processing metric: DCache_L2_All_Miss EXIT: nan
processing metric: DCache_L2_All EXIT: nan
Result nan
Found metric 'DCache_L2_Misses'
metric expr d_ratio(DCache_L2_All_Miss, DCache_L2_All) for DCache_L2_Misses
metric expr max(l2_rqsts.all_demand_data_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss for DCache_L2_All_Miss
metric expr DCache_L2_All_Hits + DCache_L2_All_Miss for DCache_L2_All
metric expr l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hit + l2_rqsts.rfo_hit for DCache_L2_All_Hits
metric expr max(l2_rqsts.all_demand_data_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss for DCache_L2_All_Miss
found event l2_rqsts.rfo_miss
found event l2_rqsts.rfo_hit
found event l2_rqsts.pf_miss
found event l2_rqsts.demand_data_rd_hit
found event l2_rqsts.all_demand_data_rd
found event l2_rqsts.pf_hit
Parsing metric events '{l2_rqsts.rfo_miss/metric-id=l2_rqsts.rfo_miss/,l2_rqsts.rfo_hit/metric-id=l2_rqsts.rfo_hit/,l2_rqsts.pf_miss/metric-id=l2_rqsts.pf_miss/,l2_rqsts.demand_data_rd_hit/metric-id=l2_rqsts.demand_data_rd_hit/,l2_rqsts.all_demand_data_rd/metric-id=l2_rqsts.all_demand_data_rd/,l2_rqsts.pf_hit/metric-id=l2_rqsts.pf_hit/}:W'
Matched metric-id l2_rqsts.rfo_miss to l2_rqsts.rfo_miss
Matched metric-id l2_rqsts.rfo_hit to l2_rqsts.rfo_hit
Matched metric-id l2_rqsts.pf_miss to l2_rqsts.pf_miss
Matched metric-id l2_rqsts.demand_data_rd_hit to l2_rqsts.demand_data_rd_hit
Matched metric-id l2_rqsts.all_demand_data_rd to l2_rqsts.all_demand_data_rd
Matched metric-id l2_rqsts.pf_hit to l2_rqsts.pf_hit
processing metric: DCache_L2_All_Miss ENTRY
processing metric: DCache_L2_All_Miss EXIT: nan
processing metric: DCache_L2_All ENTRY
processing metric: DCache_L2_All_Hits ENTRY
processing metric: DCache_L2_All_Hits EXIT: nan
processing metric: DCache_L2_All EXIT: nan
Result nan
Found metric 'Frontend_Bound_SMT'
metric expr idq_uops_not_delivered.core / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active / cpu_clk_unhalted.ref_xclk))) for Frontend_Bound_SMT
found event cpu_clk_unhalted.one_thread_active
found event idq_uops_not_delivered.core
found event cpu_clk_unhalted.ref_xclk
found event cpu_clk_unhalted.thread
Parsing metric events '{cpu_clk_unhalted.one_thread_active/metric-id=cpu_clk_unhalted.one_thread_active/,idq_uops_not_delivered.core/metric-id=idq_uops_not_delivered.core/,cpu_clk_unhalted.ref_xclk/metric-id=cpu_clk_unhalted.ref_xclk/,cpu_clk_unhalted.thread/metric-id=cpu_clk_unhalted.thread/}:W'
Matched metric-id cpu_clk_unhalted.one_thread_active to cpu_clk_unhalted.one_thread_active
Matched metric-id idq_uops_not_delivered.core to idq_uops_not_delivered.core
Matched metric-id cpu_clk_unhalted.ref_xclk to cpu_clk_unhalted.ref_xclk
Matched metric-id cpu_clk_unhalted.thread to cpu_clk_unhalted.thread
Result nan
Found metric 'IPC'
metric expr inst_retired.any / cpu_clk_unhalted.thread for IPC
found event inst_retired.any
found event cpu_clk_unhalted.thread
Parsing metric events '{inst_retired.any/metric-id=inst_retired.any/,cpu_clk_unhalted.thread/metric-id=cpu_clk_unhalted.thread/}:W'
Matched metric-id inst_retired.any to inst_retired.any
Matched metric-id cpu_clk_unhalted.thread to cpu_clk_unhalted.thread
Result nan
Found metric 'L1D_Cache_Fill_BW'
metric expr 64 * l1d.replacement / 1e9 / duration_time for L1D_Cache_Fill_BW
found event duration_time
found event l1d.replacement
Parsing metric events '{l1d.replacement/metric-id=l1d.replacement/}:W,duration_time'
duration_time -> tool/duration_time/
duration_time -> fake/duration_time/
Matched metric-id l1d.replacement to l1d.replacement
Matched metric-id duration_time to duration_time
Result nan
Found metric 'M1'
metric expr ipc + M2 for M1
metric expr ipc + M1 for M2
metric expr ipc + M2 for M1
failed: recursion detected for M1
Expected broken metric M1 skipping
Found metric 'M2'
metric expr ipc + M1 for M2
metric expr ipc + M2 for M1
metric expr ipc + M1 for M2
failed: recursion detected for M2
Expected broken metric M2 skipping
Found metric 'M3'
metric expr 1 / M3 for M3
metric expr 1 / M3 for M3
failed: recursion detected for M3
Expected broken metric M3 skipping
Found metric 'cache_miss_cycles'
metric expr dcache_miss_cpi + icache_miss_cycles for cache_miss_cycles
metric expr l1d\-loads\-misses / inst_retired.any for dcache_miss_cpi
metric expr l1i\-loads\-misses / inst_retired.any for icache_miss_cycles
found event inst_retired.any
found event l1i-loads-misses
found event l1d-loads-misses
Parsing metric events '{inst_retired.any/metric-id=inst_retired.any/,l1i-loads-misses/metric-id=l1i!1loads!1misses/,l1d-loads-misses/metric-id=l1d!1loads!1misses/}:W'
Matched metric-id l1i-loads-misses to l1i-loads-misses
Matched metric-id l1d-loads-misses to l1d-loads-misses
Matched metric-id inst_retired.any to inst_retired.any
processing metric: dcache_miss_cpi ENTRY
processing metric: dcache_miss_cpi EXIT: nan
processing metric: icache_miss_cycles ENTRY
processing metric: icache_miss_cycles EXIT: nan
Result nan
Found metric 'dcache_miss_cpi'
metric expr l1d\-loads\-misses / inst_retired.any for dcache_miss_cpi
found event inst_retired.any
found event l1d-loads-misses
Parsing metric events '{inst_retired.any/metric-id=inst_retired.any/,l1d-loads-misses/metric-id=l1d!1loads!1misses/}:W'
Matched metric-id l1d-loads-misses to l1d-loads-misses
Matched metric-id inst_retired.any to inst_retired.any
Result nan
Found metric 'icache_miss_cycles'
metric expr l1i\-loads\-misses / inst_retired.any for icache_miss_cycles
found event inst_retired.any
found event l1i-loads-misses
Parsing metric events '{inst_retired.any/metric-id=inst_retired.any/,l1i-loads-misses/metric-id=l1i!1loads!1misses/}:W'
Matched metric-id l1i-loads-misses to l1i-loads-misses
Matched metric-id inst_retired.any to inst_retired.any
Result nan
Found metric 'tma_allocation_restriction'
metric expr tma_core_bound for tma_allocation_restriction
metric expr cpu_atom@TOPDOWN_BE_BOUND.ALL@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_backend_bound
metric expr cpu_atom@TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_core_bound
metric expr tma_core_bound for tma_allocation_restriction
metric expr cpu_atom@TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_core_bound
found event cpu_atom@TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS@
found event cpu_atom@CPU_CLK_UNHALTED.CORE@
found event cpu_atom@TOPDOWN_BE_BOUND.ALL@
Parsing metric events '{cpu_atom/TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS,metric-id=cpu_atom!3TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS!3/,cpu_atom/CPU_CLK_UNHALTED.CORE,metric-id=cpu_atom!3CPU_CLK_UNHALTED.CORE!3/,cpu_atom/TOPDOWN_BE_BOUND.ALL,metric-id=cpu_atom!3TOPDOWN_BE_BOUND.ALL!3/}:W'
Matched metric-id cpu_atom@TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS@ to cpu_atom/TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS/
Matched metric-id cpu_atom@CPU_CLK_UNHALTED.CORE@ to cpu_atom/CPU_CLK_UNHALTED.CORE/
Matched metric-id cpu_atom@TOPDOWN_BE_BOUND.ALL@ to cpu_atom/TOPDOWN_BE_BOUND.ALL/
processing metric: tma_core_bound ENTRY
processing metric: tma_core_bound EXIT: nan
Result nan
Found metric 'tma_backend_bound'
metric expr cpu_atom@TOPDOWN_BE_BOUND.ALL@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_backend_bound
metric expr cpu_atom@TOPDOWN_BE_BOUND.ALL@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_backend_bound
metric expr cpu_core@topdown\-be\-bound@ / (cpu_core@topdown\-fe\-bound@ + cpu_core@topdown\-bad\-spec@ + cpu_core@topdown\-retiring@ + cpu_core@topdown\-be\-bound@) for tma_backend_bound
metric expr cpu_atom@TOPDOWN_BE_BOUND.ALL@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_backend_bound
found event cpu_atom@CPU_CLK_UNHALTED.CORE@
found event cpu_atom@TOPDOWN_BE_BOUND.ALL@
Parsing metric events '{cpu_atom/CPU_CLK_UNHALTED.CORE,metric-id=cpu_atom!3CPU_CLK_UNHALTED.CORE!3/,cpu_atom/TOPDOWN_BE_BOUND.ALL,metric-id=cpu_atom!3TOPDOWN_BE_BOUND.ALL!3/}:W'
Matched metric-id cpu_atom@CPU_CLK_UNHALTED.CORE@ to cpu_atom/CPU_CLK_UNHALTED.CORE/
Matched metric-id cpu_atom@TOPDOWN_BE_BOUND.ALL@ to cpu_atom/TOPDOWN_BE_BOUND.ALL/
found event cpu_atom@CPU_CLK_UNHALTED.CORE@
found event cpu_atom@TOPDOWN_BE_BOUND.ALL@
Parsing metric events '{cpu_atom/CPU_CLK_UNHALTED.CORE,metric-id=cpu_atom!3CPU_CLK_UNHALTED.CORE!3/,cpu_atom/TOPDOWN_BE_BOUND.ALL,metric-id=cpu_atom!3TOPDOWN_BE_BOUND.ALL!3/}:W'
Matched metric-id cpu_atom@CPU_CLK_UNHALTED.CORE@ to cpu_atom/CPU_CLK_UNHALTED.CORE/
Matched metric-id cpu_atom@TOPDOWN_BE_BOUND.ALL@ to cpu_atom/TOPDOWN_BE_BOUND.ALL/
cpu_core@topdown-be-bound@ not found
cpu_core@topdown-fe-bound@ not found
cpu_core@topdown-bad-spec@ not found
cpu_core@topdown-retiring@ not found
cpu_core@topdown-be-bound@ not found
Result nan
Found metric 'tma_bad_speculation'
metric expr (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@ - (cpu_atom@TOPDOWN_FE_BOUND.ALL@ + cpu_atom@TOPDOWN_BE_BOUND.ALL@ + cpu_atom@TOPDOWN_RETIRING.ALL@)) / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_bad_speculation
metric expr (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@ - (cpu_atom@TOPDOWN_FE_BOUND.ALL@ + cpu_atom@TOPDOWN_BE_BOUND.ALL@ + cpu_atom@TOPDOWN_RETIRING.ALL@)) / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_bad_speculation
metric expr max(1 - (tma_frontend_bound + tma_backend_bound + tma_retiring), 0) for tma_bad_speculation
metric expr (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@ - (cpu_atom@TOPDOWN_FE_BOUND.ALL@ + cpu_atom@TOPDOWN_BE_BOUND.ALL@ + cpu_atom@TOPDOWN_RETIRING.ALL@)) / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_bad_speculation
found event cpu_atom@TOPDOWN_RETIRING.ALL@
found event cpu_atom@CPU_CLK_UNHALTED.CORE@
found event cpu_atom@TOPDOWN_FE_BOUND.ALL@
found event cpu_atom@TOPDOWN_BE_BOUND.ALL@
Parsing metric events '{cpu_atom/TOPDOWN_RETIRING.ALL,metric-id=cpu_atom!3TOPDOWN_RETIRING.ALL!3/,cpu_atom/CPU_CLK_UNHALTED.CORE,metric-id=cpu_atom!3CPU_CLK_UNHALTED.CORE!3/,cpu_atom/TOPDOWN_FE_BOUND.ALL,metric-id=cpu_atom!3TOPDOWN_FE_BOUND.ALL!3/,cpu_atom/TOPDOWN_BE_BOUND.ALL,metric-id=cpu_atom!3TOPDOWN_BE_BOUND.ALL!3/}:W'
Matched metric-id cpu_atom@TOPDOWN_RETIRING.ALL@ to cpu_atom/TOPDOWN_RETIRING.ALL/
Matched metric-id cpu_atom@CPU_CLK_UNHALTED.CORE@ to cpu_atom/CPU_CLK_UNHALTED.CORE/
Matched metric-id cpu_atom@TOPDOWN_FE_BOUND.ALL@ to cpu_atom/TOPDOWN_FE_BOUND.ALL/
Matched metric-id cpu_atom@TOPDOWN_BE_BOUND.ALL@ to cpu_atom/TOPDOWN_BE_BOUND.ALL/
found event cpu_atom@TOPDOWN_RETIRING.ALL@
found event cpu_atom@CPU_CLK_UNHALTED.CORE@
found event cpu_atom@TOPDOWN_FE_BOUND.ALL@
found event cpu_atom@TOPDOWN_BE_BOUND.ALL@
Parsing metric events '{cpu_atom/TOPDOWN_RETIRING.ALL,metric-id=cpu_atom!3TOPDOWN_RETIRING.ALL!3/,cpu_atom/CPU_CLK_UNHALTED.CORE,metric-id=cpu_atom!3CPU_CLK_UNHALTED.CORE!3/,cpu_atom/TOPDOWN_FE_BOUND.ALL,metric-id=cpu_atom!3TOPDOWN_FE_BOUND.ALL!3/,cpu_atom/TOPDOWN_BE_BOUND.ALL,metric-id=cpu_atom!3TOPDOWN_BE_BOUND.ALL!3/}:W'
Matched metric-id cpu_atom@TOPDOWN_RETIRING.ALL@ to cpu_atom/TOPDOWN_RETIRING.ALL/
Matched metric-id cpu_atom@CPU_CLK_UNHALTED.CORE@ to cpu_atom/CPU_CLK_UNHALTED.CORE/
Matched metric-id cpu_atom@TOPDOWN_FE_BOUND.ALL@ to cpu_atom/TOPDOWN_FE_BOUND.ALL/
Matched metric-id cpu_atom@TOPDOWN_BE_BOUND.ALL@ to cpu_atom/TOPDOWN_BE_BOUND.ALL/
tma_frontend_bound not found
tma_backend_bound not found
tma_retiring not found
Result 0.000000
Found metric 'tma_branch_detect'
metric expr cpu_atom@TOPDOWN_FE_BOUND.BRANCH_DETECT@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_branch_detect
metric expr cpu_atom@TOPDOWN_FE_BOUND.FRONTEND_LATENCY@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_ifetch_latency
metric expr cpu_atom@TOPDOWN_FE_BOUND.ALL@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_frontend_bound
metric expr cpu_atom@TOPDOWN_FE_BOUND.BRANCH_DETECT@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_branch_detect
found event cpu_atom@TOPDOWN_FE_BOUND.BRANCH_DETECT@
found event cpu_atom@CPU_CLK_UNHALTED.CORE@
found event cpu_atom@TOPDOWN_FE_BOUND.FRONTEND_LATENCY@
found event cpu_atom@TOPDOWN_FE_BOUND.ALL@
Parsing metric events '{cpu_atom/TOPDOWN_FE_BOUND.BRANCH_DETECT,metric-id=cpu_atom!3TOPDOWN_FE_BOUND.BRANCH_DETECT!3/,cpu_atom/CPU_CLK_UNHALTED.CORE,metric-id=cpu_atom!3CPU_CLK_UNHALTED.CORE!3/,cpu_atom/TOPDOWN_FE_BOUND.FRONTEND_LATENCY,metric-id=cpu_atom!3TOPDOWN_FE_BOUND.FRONTEND_LATENCY!3/,cpu_atom/TOPDOWN_FE_BOUND.ALL,metric-id=cpu_atom!3TOPDOWN_FE_BOUND.ALL!3/}:W'
Matched metric-id cpu_atom@TOPDOWN_FE_BOUND.BRANCH_DETECT@ to cpu_atom/TOPDOWN_FE_BOUND.BRANCH_DETECT/
Matched metric-id cpu_atom@CPU_CLK_UNHALTED.CORE@ to cpu_atom/CPU_CLK_UNHALTED.CORE/
Matched metric-id cpu_atom@TOPDOWN_FE_BOUND.FRONTEND_LATENCY@ to cpu_atom/TOPDOWN_FE_BOUND.FRONTEND_LATENCY/
Matched metric-id cpu_atom@TOPDOWN_FE_BOUND.ALL@ to cpu_atom/TOPDOWN_FE_BOUND.ALL/
Result nan
Found metric 'tma_branch_mispredicts'
metric expr cpu_atom@TOPDOWN_BAD_SPECULATION.MISPREDICT@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_branch_mispredicts
metric expr cpu_atom@TOPDOWN_BAD_SPECULATION.MISPREDICT@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_branch_mispredicts
metric expr (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@ - (cpu_atom@TOPDOWN_FE_BOUND.ALL@ + cpu_atom@TOPDOWN_BE_BOUND.ALL@ + cpu_atom@TOPDOWN_RETIRING.ALL@)) / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_bad_speculation
metric expr cpu_core@topdown\-br\-mispredict@ / (cpu_core@topdown\-fe\-bound@ + cpu_core@topdown\-bad\-spec@ + cpu_core@topdown\-retiring@ + cpu_core@topdown\-be\-bound@) for tma_branch_mispredicts
metric expr cpu_atom@TOPDOWN_BAD_SPECULATION.MISPREDICT@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_branch_mispredicts
metric expr (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@ - (cpu_atom@TOPDOWN_FE_BOUND.ALL@ + cpu_atom@TOPDOWN_BE_BOUND.ALL@ + cpu_atom@TOPDOWN_RETIRING.ALL@)) / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_bad_speculation
found event cpu_atom@TOPDOWN_RETIRING.ALL@
found event cpu_atom@TOPDOWN_BAD_SPECULATION.MISPREDICT@
found event cpu_atom@CPU_CLK_UNHALTED.CORE@
found event cpu_atom@TOPDOWN_FE_BOUND.ALL@
found event cpu_atom@TOPDOWN_BE_BOUND.ALL@
Parsing metric events '{cpu_atom/TOPDOWN_RETIRING.ALL,metric-id=cpu_atom!3TOPDOWN_RETIRING.ALL!3/,cpu_atom/TOPDOWN_BAD_SPECULATION.MISPREDICT,metric-id=cpu_atom!3TOPDOWN_BAD_SPECULATION.MISPREDICT!3/,cpu_atom/CPU_CLK_UNHALTED.CORE,metric-id=cpu_atom!3CPU_CLK_UNHALTED.CORE!3/,cpu_atom/TOPDOWN_FE_BOUND.ALL,metric-id=cpu_atom!3TOPDOWN_FE_BOUND.ALL!3/,cpu_atom/TOPDOWN_BE_BOUND.ALL,metric-id=cpu_atom!3TOPDOWN_BE_BOUND.ALL!3/}:W'
Matched metric-id cpu_atom@TOPDOWN_RETIRING.ALL@ to cpu_atom/TOPDOWN_RETIRING.ALL/
Matched metric-id cpu_atom@TOPDOWN_BAD_SPECULATION.MISPREDICT@ to cpu_atom/TOPDOWN_BAD_SPECULATION.MISPREDICT/
Matched metric-id cpu_atom@CPU_CLK_UNHALTED.CORE@ to cpu_atom/CPU_CLK_UNHALTED.CORE/
Matched metric-id cpu_atom@TOPDOWN_FE_BOUND.ALL@ to cpu_atom/TOPDOWN_FE_BOUND.ALL/
Matched metric-id cpu_atom@TOPDOWN_BE_BOUND.ALL@ to cpu_atom/TOPDOWN_BE_BOUND.ALL/
found event cpu_atom@TOPDOWN_RETIRING.ALL@
found event cpu_atom@TOPDOWN_BAD_SPECULATION.MISPREDICT@
found event cpu_atom@CPU_CLK_UNHALTED.CORE@
found event cpu_atom@TOPDOWN_FE_BOUND.ALL@
found event cpu_atom@TOPDOWN_BE_BOUND.ALL@
Parsing metric events '{cpu_atom/TOPDOWN_RETIRING.ALL,metric-id=cpu_atom!3TOPDOWN_RETIRING.ALL!3/,cpu_atom/TOPDOWN_BAD_SPECULATION.MISPREDICT,metric-id=cpu_atom!3TOPDOWN_BAD_SPECULATION.MISPREDICT!3/,cpu_atom/CPU_CLK_UNHALTED.CORE,metric-id=cpu_atom!3CPU_CLK_UNHALTED.CORE!3/,cpu_atom/TOPDOWN_FE_BOUND.ALL,metric-id=cpu_atom!3TOPDOWN_FE_BOUND.ALL!3/,cpu_atom/TOPDOWN_BE_BOUND.ALL,metric-id=cpu_atom!3TOPDOWN_BE_BOUND.ALL!3/}:W'
Matched metric-id cpu_atom@TOPDOWN_RETIRING.ALL@ to cpu_atom/TOPDOWN_RETIRING.ALL/
Matched metric-id cpu_atom@TOPDOWN_BAD_SPECULATION.MISPREDICT@ to cpu_atom/TOPDOWN_BAD_SPECULATION.MISPREDICT/
Matched metric-id cpu_atom@CPU_CLK_UNHALTED.CORE@ to cpu_atom/CPU_CLK_UNHALTED.CORE/
Matched metric-id cpu_atom@TOPDOWN_FE_BOUND.ALL@ to cpu_atom/TOPDOWN_FE_BOUND.ALL/
Matched metric-id cpu_atom@TOPDOWN_BE_BOUND.ALL@ to cpu_atom/TOPDOWN_BE_BOUND.ALL/
cpu_core@topdown-br-mispredict@ not found
cpu_core@topdown-fe-bound@ not found
cpu_core@topdown-bad-spec@ not found
cpu_core@topdown-retiring@ not found
cpu_core@topdown-be-bound@ not found
Result nan
Found metric 'tma_branch_resteer'
metric expr cpu_atom@TOPDOWN_FE_BOUND.BRANCH_RESTEER@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_branch_resteer
metric expr cpu_atom@TOPDOWN_FE_BOUND.FRONTEND_LATENCY@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_ifetch_latency
metric expr cpu_atom@TOPDOWN_FE_BOUND.ALL@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_frontend_bound
metric expr cpu_atom@TOPDOWN_FE_BOUND.BRANCH_RESTEER@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_branch_resteer
found event cpu_atom@CPU_CLK_UNHALTED.CORE@
found event cpu_atom@TOPDOWN_FE_BOUND.FRONTEND_LATENCY@
found event cpu_atom@TOPDOWN_FE_BOUND.ALL@
found event cpu_atom@TOPDOWN_FE_BOUND.BRANCH_RESTEER@
Parsing metric events '{cpu_atom/CPU_CLK_UNHALTED.CORE,metric-id=cpu_atom!3CPU_CLK_UNHALTED.CORE!3/,cpu_atom/TOPDOWN_FE_BOUND.FRONTEND_LATENCY,metric-id=cpu_atom!3TOPDOWN_FE_BOUND.FRONTEND_LATENCY!3/,cpu_atom/TOPDOWN_FE_BOUND.ALL,metric-id=cpu_atom!3TOPDOWN_FE_BOUND.ALL!3/,cpu_atom/TOPDOWN_FE_BOUND.BRANCH_RESTEER,metric-id=cpu_atom!3TOPDOWN_FE_BOUND.BRANCH_RESTEER!3/}:W'
Matched metric-id cpu_atom@CPU_CLK_UNHALTED.CORE@ to cpu_atom/CPU_CLK_UNHALTED.CORE/
Matched metric-id cpu_atom@TOPDOWN_FE_BOUND.FRONTEND_LATENCY@ to cpu_atom/TOPDOWN_FE_BOUND.FRONTEND_LATENCY/
Matched metric-id cpu_atom@TOPDOWN_FE_BOUND.ALL@ to cpu_atom/TOPDOWN_FE_BOUND.ALL/
Matched metric-id cpu_atom@TOPDOWN_FE_BOUND.BRANCH_RESTEER@ to cpu_atom/TOPDOWN_FE_BOUND.BRANCH_RESTEER/
Result nan
Found metric 'tma_cisc'
metric expr cpu_atom@TOPDOWN_FE_BOUND.CISC@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_cisc
metric expr cpu_atom@TOPDOWN_FE_BOUND.ALL@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_frontend_bound
metric expr cpu_atom@TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_ifetch_bandwidth
metric expr cpu_atom@TOPDOWN_FE_BOUND.CISC@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_cisc
metric expr max(0, tma_microcode_sequencer - tma_assists) for tma_cisc
metric expr cpu_core@UOPS_RETIRED.MS@ / tma_info_thread_slots for tma_microcode_sequencer
metric expr cpu_core@TOPDOWN.SLOTS@ for tma_info_thread_slots
metric expr cpu_core@topdown\-heavy\-ops@ / (cpu_core@topdown\-fe\-bound@ + cpu_core@topdown\-bad\-spec@ + cpu_core@topdown\-retiring@ + cpu_core@topdown\-be\-bound@) for tma_heavy_operations
metric expr cpu_atom@TOPDOWN_FE_BOUND.CISC@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_cisc
found event cpu_core@TOPDOWN.SLOTS@
found event cpu_core@topdown-retiring@
found event cpu_core@topdown-bad-spec@
found event cpu_core@topdown-heavy-ops@
found event cpu_atom@CPU_CLK_UNHALTED.CORE@
found event cpu_core@UOPS_RETIRED.MS@
found event cpu_atom@TOPDOWN_FE_BOUND.CISC@
found event cpu_core@topdown-fe-bound@
found event cpu_core@topdown-be-bound@
Parsing metric events '{cpu_core/TOPDOWN.SLOTS,metric-id=cpu_core!3TOPDOWN.SLOTS!3/,cpu_core/topdown-retiring,metric-id=cpu_core!3topdown!1retiring!3/,cpu_core/topdown-bad-spec,metric-id=cpu_core!3topdown!1bad!1spec!3/,cpu_core/topdown-heavy-ops,metric-id=cpu_core!3topdown!1heavy!1ops!3/,cpu_atom/CPU_CLK_UNHALTED.CORE,metric-id=cpu_atom!3CPU_CLK_UNHALTED.CORE!3/,cpu_core/UOPS_RETIRED.MS,metric-id=cpu_core!3UOPS_RETIRED.MS!3/,cpu_atom/TOPDOWN_FE_BOUND.CISC,metric-id=cpu_atom!3TOPDOWN_FE_BOUND.CISC!3/,cpu_core/topdown-fe-bound,metric-id=cpu_core!3topdown!1fe!1bound!3/,cpu_core/topdown-be-bound,metric-id=cpu_core!3topdown!1be!1bound!3/}:W'
Matched metric-id cpu_core@TOPDOWN.SLOTS@ to cpu_core/TOPDOWN.SLOTS/
Matched metric-id cpu_core@topdown-retiring@ to cpu_core/topdown-retiring/
Matched metric-id cpu_core@topdown-bad-spec@ to cpu_core/topdown-bad-spec/
Matched metric-id cpu_core@topdown-heavy-ops@ to cpu_core/topdown-heavy-ops/
Matched metric-id cpu_atom@CPU_CLK_UNHALTED.CORE@ to cpu_atom/CPU_CLK_UNHALTED.CORE/
Matched metric-id cpu_core@UOPS_RETIRED.MS@ to cpu_core/UOPS_RETIRED.MS/
Matched metric-id cpu_atom@TOPDOWN_FE_BOUND.CISC@ to cpu_atom/TOPDOWN_FE_BOUND.CISC/
Matched metric-id cpu_core@topdown-fe-bound@ to cpu_core/topdown-fe-bound/
Matched metric-id cpu_core@topdown-be-bound@ to cpu_core/topdown-be-bound/
found event cpu_atom@CPU_CLK_UNHALTED.CORE@
found event cpu_atom@TOPDOWN_FE_BOUND.ALL@
found event cpu_atom@TOPDOWN_FE_BOUND.CISC@
found event cpu_atom@TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH@
Parsing metric events '{cpu_atom/CPU_CLK_UNHALTED.CORE,metric-id=cpu_atom!3CPU_CLK_UNHALTED.CORE!3/,cpu_atom/TOPDOWN_FE_BOUND.ALL,metric-id=cpu_atom!3TOPDOWN_FE_BOUND.ALL!3/,cpu_atom/TOPDOWN_FE_BOUND.CISC,metric-id=cpu_atom!3TOPDOWN_FE_BOUND.CISC!3/,cpu_atom/TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH,metric-id=cpu_atom!3TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH!3/}:W'
Matched metric-id cpu_atom@CPU_CLK_UNHALTED.CORE@ to cpu_atom/CPU_CLK_UNHALTED.CORE/
Matched metric-id cpu_atom@TOPDOWN_FE_BOUND.ALL@ to cpu_atom/TOPDOWN_FE_BOUND.ALL/
Matched metric-id cpu_atom@TOPDOWN_FE_BOUND.CISC@ to cpu_atom/TOPDOWN_FE_BOUND.CISC/
Matched metric-id cpu_atom@TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH@ to cpu_atom/TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH/
processing metric: tma_microcode_sequencer ENTRY
processing metric: tma_info_thread_slots ENTRY
processing metric: tma_info_thread_slots EXIT: nan
processing metric: tma_microcode_sequencer EXIT: nan
tma_assists not found
Result nan
Found metric 'tma_core_bound'
metric expr cpu_atom@TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_core_bound
metric expr cpu_atom@TOPDOWN_BE_BOUND.ALL@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_backend_bound
metric expr cpu_atom@TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_core_bound
metric expr max(0, tma_backend_bound - tma_memory_bound) for tma_core_bound
metric expr cpu_atom@TOPDOWN_BE_BOUND.ALL@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_backend_bound
metric expr cpu_atom@TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_core_bound
found event cpu_atom@CPU_CLK_UNHALTED.CORE@
found event cpu_atom@TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS@
found event cpu_atom@TOPDOWN_BE_BOUND.ALL@
Parsing metric events '{cpu_atom/CPU_CLK_UNHALTED.CORE,metric-id=cpu_atom!3CPU_CLK_UNHALTED.CORE!3/,cpu_atom/TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS,metric-id=cpu_atom!3TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS!3/,cpu_atom/TOPDOWN_BE_BOUND.ALL,metric-id=cpu_atom!3TOPDOWN_BE_BOUND.ALL!3/}:W'
Matched metric-id cpu_atom@CPU_CLK_UNHALTED.CORE@ to cpu_atom/CPU_CLK_UNHALTED.CORE/
Matched metric-id cpu_atom@TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS@ to cpu_atom/TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS/
Matched metric-id cpu_atom@TOPDOWN_BE_BOUND.ALL@ to cpu_atom/TOPDOWN_BE_BOUND.ALL/
found event cpu_atom@CPU_CLK_UNHALTED.CORE@
found event cpu_atom@TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS@
found event cpu_atom@TOPDOWN_BE_BOUND.ALL@
Parsing metric events '{cpu_atom/CPU_CLK_UNHALTED.CORE,metric-id=cpu_atom!3CPU_CLK_UNHALTED.CORE!3/,cpu_atom/TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS,metric-id=cpu_atom!3TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS!3/,cpu_atom/TOPDOWN_BE_BOUND.ALL,metric-id=cpu_atom!3TOPDOWN_BE_BOUND.ALL!3/}:W'
Matched metric-id cpu_atom@CPU_CLK_UNHALTED.CORE@ to cpu_atom/CPU_CLK_UNHALTED.CORE/
Matched metric-id cpu_atom@TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS@ to cpu_atom/TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS/
Matched metric-id cpu_atom@TOPDOWN_BE_BOUND.ALL@ to cpu_atom/TOPDOWN_BE_BOUND.ALL/
processing metric: tma_backend_bound ENTRY
processing metric: tma_backend_bound EXIT: nan
tma_memory_bound not found
Result nan
Found metric 'tma_decode'
metric expr cpu_atom@TOPDOWN_FE_BOUND.DECODE@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_decode
metric expr cpu_atom@TOPDOWN_FE_BOUND.DECODE@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_decode
metric expr cpu_atom@TOPDOWN_FE_BOUND.ALL@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_frontend_bound
metric expr cpu_atom@TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_ifetch_bandwidth
found event cpu_atom@TOPDOWN_FE_BOUND.DECODE@
found event cpu_atom@CPU_CLK_UNHALTED.CORE@
found event cpu_atom@TOPDOWN_FE_BOUND.ALL@
found event cpu_atom@TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH@
Parsing metric events '{cpu_atom/TOPDOWN_FE_BOUND.DECODE,metric-id=cpu_atom!3TOPDOWN_FE_BOUND.DECODE!3/,cpu_atom/CPU_CLK_UNHALTED.CORE,metric-id=cpu_atom!3CPU_CLK_UNHALTED.CORE!3/,cpu_atom/TOPDOWN_FE_BOUND.ALL,metric-id=cpu_atom!3TOPDOWN_FE_BOUND.ALL!3/,cpu_atom/TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH,metric-id=cpu_atom!3TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH!3/}:W'
Matched metric-id cpu_atom@TOPDOWN_FE_BOUND.DECODE@ to cpu_atom/TOPDOWN_FE_BOUND.DECODE/
Matched metric-id cpu_atom@CPU_CLK_UNHALTED.CORE@ to cpu_atom/CPU_CLK_UNHALTED.CORE/
Matched metric-id cpu_atom@TOPDOWN_FE_BOUND.ALL@ to cpu_atom/TOPDOWN_FE_BOUND.ALL/
Matched metric-id cpu_atom@TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH@ to cpu_atom/TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH/
Result nan
Found metric 'tma_fast_nuke'
metric expr cpu_atom@TOPDOWN_BAD_SPECULATION.FASTNUKE@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_fast_nuke
metric expr cpu_atom@TOPDOWN_BAD_SPECULATION.FASTNUKE@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_fast_nuke
metric expr cpu_atom@TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_machine_clears
metric expr (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@ - (cpu_atom@TOPDOWN_FE_BOUND.ALL@ + cpu_atom@TOPDOWN_BE_BOUND.ALL@ + cpu_atom@TOPDOWN_RETIRING.ALL@)) / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_bad_speculation
found event cpu_atom@TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS@
found event cpu_atom@TOPDOWN_BAD_SPECULATION.FASTNUKE@
found event cpu_atom@TOPDOWN_RETIRING.ALL@
found event cpu_atom@CPU_CLK_UNHALTED.CORE@
found event cpu_atom@TOPDOWN_FE_BOUND.ALL@
found event cpu_atom@TOPDOWN_BE_BOUND.ALL@
Parsing metric events '{cpu_atom/TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS,metric-id=cpu_atom!3TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS!3/,cpu_atom/TOPDOWN_BAD_SPECULATION.FASTNUKE,metric-id=cpu_atom!3TOPDOWN_BAD_SPECULATION.FASTNUKE!3/,cpu_atom/TOPDOWN_RETIRING.ALL,metric-id=cpu_atom!3TOPDOWN_RETIRING.ALL!3/,cpu_atom/CPU_CLK_UNHALTED.CORE,metric-id=cpu_atom!3CPU_CLK_UNHALTED.CORE!3/,cpu_atom/TOPDOWN_FE_BOUND.ALL,metric-id=cpu_atom!3TOPDOWN_FE_BOUND.ALL!3/,cpu_atom/TOPDOWN_BE_BOUND.ALL,metric-id=cpu_atom!3TOPDOWN_BE_BOUND.ALL!3/}:W'
Matched metric-id cpu_atom@TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS@ to cpu_atom/TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS/
Matched metric-id cpu_atom@TOPDOWN_BAD_SPECULATION.FASTNUKE@ to cpu_atom/TOPDOWN_BAD_SPECULATION.FASTNUKE/
Matched metric-id cpu_atom@TOPDOWN_RETIRING.ALL@ to cpu_atom/TOPDOWN_RETIRING.ALL/
Matched metric-id cpu_atom@CPU_CLK_UNHALTED.CORE@ to cpu_atom/CPU_CLK_UNHALTED.CORE/
Matched metric-id cpu_atom@TOPDOWN_FE_BOUND.ALL@ to cpu_atom/TOPDOWN_FE_BOUND.ALL/
Matched metric-id cpu_atom@TOPDOWN_BE_BOUND.ALL@ to cpu_atom/TOPDOWN_BE_BOUND.ALL/
Result nan
Found metric 'tma_frontend_bound'
metric expr cpu_atom@TOPDOWN_FE_BOUND.ALL@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_frontend_bound
metric expr cpu_atom@TOPDOWN_FE_BOUND.ALL@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_frontend_bound
metric expr cpu_core@topdown\-fe\-bound@ / (cpu_core@topdown\-fe\-bound@ + cpu_core@topdown\-bad\-spec@ + cpu_core@topdown\-retiring@ + cpu_core@topdown\-be\-bound@) - cpu_core@INT_MISC.UOP_DROPPING@ / tma_info_thread_slots for tma_frontend_bound
metric expr cpu_atom@TOPDOWN_FE_BOUND.ALL@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_frontend_bound
found event cpu_atom@CPU_CLK_UNHALTED.CORE@
found event cpu_atom@TOPDOWN_FE_BOUND.ALL@
Parsing metric events '{cpu_atom/CPU_CLK_UNHALTED.CORE,metric-id=cpu_atom!3CPU_CLK_UNHALTED.CORE!3/,cpu_atom/TOPDOWN_FE_BOUND.ALL,metric-id=cpu_atom!3TOPDOWN_FE_BOUND.ALL!3/}:W'
Matched metric-id cpu_atom@CPU_CLK_UNHALTED.CORE@ to cpu_atom/CPU_CLK_UNHALTED.CORE/
Matched metric-id cpu_atom@TOPDOWN_FE_BOUND.ALL@ to cpu_atom/TOPDOWN_FE_BOUND.ALL/
found event cpu_atom@CPU_CLK_UNHALTED.CORE@
found event cpu_atom@TOPDOWN_FE_BOUND.ALL@
Parsing metric events '{cpu_atom/CPU_CLK_UNHALTED.CORE,metric-id=cpu_atom!3CPU_CLK_UNHALTED.CORE!3/,cpu_atom/TOPDOWN_FE_BOUND.ALL,metric-id=cpu_atom!3TOPDOWN_FE_BOUND.ALL!3/}:W'
Matched metric-id cpu_atom@CPU_CLK_UNHALTED.CORE@ to cpu_atom/CPU_CLK_UNHALTED.CORE/
Matched metric-id cpu_atom@TOPDOWN_FE_BOUND.ALL@ to cpu_atom/TOPDOWN_FE_BOUND.ALL/
cpu_core@topdown-fe-bound@ not found
cpu_core@topdown-fe-bound@ not found
cpu_core@topdown-bad-spec@ not found
cpu_core@topdown-retiring@ not found
cpu_core@topdown-be-bound@ not found
cpu_core@INT_MISC.UOP_DROPPING@ not found
tma_info_thread_slots not found
Result nan
Found metric 'tma_icache_misses'
metric expr cpu_atom@TOPDOWN_FE_BOUND.ICACHE@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_icache_misses
metric expr cpu_atom@TOPDOWN_FE_BOUND.FRONTEND_LATENCY@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_ifetch_latency
metric expr cpu_atom@TOPDOWN_FE_BOUND.ICACHE@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_icache_misses
metric expr cpu_atom@TOPDOWN_FE_BOUND.ALL@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_frontend_bound
metric expr cpu_core@ICACHE_DATA.STALLS@ / tma_info_thread_clks for tma_icache_misses
metric expr cpu_atom@TOPDOWN_FE_BOUND.ICACHE@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_icache_misses
metric expr cpu_atom@TOPDOWN_FE_BOUND.ALL@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_frontend_bound
metric expr cpu_core@topdown\-fetch\-lat@ / (cpu_core@topdown\-fe\-bound@ + cpu_core@topdown\-bad\-spec@ + cpu_core@topdown\-retiring@ + cpu_core@topdown\-be\-bound@) - cpu_core@INT_MISC.UOP_DROPPING@ / tma_info_thread_slots for tma_fetch_latency
metric expr cpu_core@TOPDOWN.SLOTS@ for tma_info_thread_slots
found event cpu_core@TOPDOWN.SLOTS@
found event cpu_atom@TOPDOWN_FE_BOUND.ICACHE@
found event cpu_core@topdown-retiring@
found event cpu_core@topdown-bad-spec@
found event cpu_atom@CPU_CLK_UNHALTED.CORE@
found event cpu_core@topdown-fetch-lat@
found event cpu_atom@TOPDOWN_FE_BOUND.ALL@
found event cpu_core@INT_MISC.UOP_DROPPING@
found event cpu_core@topdown-fe-bound@
found event cpu_core@topdown-be-bound@
Parsing metric events '{cpu_core/TOPDOWN.SLOTS,metric-id=cpu_core!3TOPDOWN.SLOTS!3/,cpu_atom/TOPDOWN_FE_BOUND.ICACHE,metric-id=cpu_atom!3TOPDOWN_FE_BOUND.ICACHE!3/,cpu_core/topdown-retiring,metric-id=cpu_core!3topdown!1retiring!3/,cpu_core/topdown-bad-spec,metric-id=cpu_core!3topdown!1bad!1spec!3/,cpu_atom/CPU_CLK_UNHALTED.CORE,metric-id=cpu_atom!3CPU_CLK_UNHALTED.CORE!3/,cpu_core/topdown-fetch-lat,metric-id=cpu_core!3topdown!1fetch!1lat!3/,cpu_atom/TOPDOWN_FE_BOUND.ALL,metric-id=cpu_atom!3TOPDOWN_FE_BOUND.ALL!3/,cpu_core/INT_MISC.UOP_DROPPING,metric-id=cpu_core!3INT_MISC.UOP_DROPPING!3/,cpu_core/topdown-fe-bound,metric-id=cpu_core!3topdown!1fe!1bound!3/,cpu_core/topdown-be-bound,metric-id=cpu_core!3topdown!1be!1bound!3/}:W'
Matched metric-id cpu_core@TOPDOWN.SLOTS@ to cpu_core/TOPDOWN.SLOTS/
Matched metric-id cpu_atom@TOPDOWN_FE_BOUND.ICACHE@ to cpu_atom/TOPDOWN_FE_BOUND.ICACHE/
Matched metric-id cpu_core@topdown-retiring@ to cpu_core/topdown-retiring/
Matched metric-id cpu_core@topdown-bad-spec@ to cpu_core/topdown-bad-spec/
Matched metric-id cpu_atom@CPU_CLK_UNHALTED.CORE@ to cpu_atom/CPU_CLK_UNHALTED.CORE/
Matched metric-id cpu_core@topdown-fetch-lat@ to cpu_core/topdown-fetch-lat/
Matched metric-id cpu_atom@TOPDOWN_FE_BOUND.ALL@ to cpu_atom/TOPDOWN_FE_BOUND.ALL/
Matched metric-id cpu_core@INT_MISC.UOP_DROPPING@ to cpu_core/INT_MISC.UOP_DROPPING/
Matched metric-id cpu_core@topdown-fe-bound@ to cpu_core/topdown-fe-bound/
Matched metric-id cpu_core@topdown-be-bound@ to cpu_core/topdown-be-bound/
found event cpu_atom@TOPDOWN_FE_BOUND.ICACHE@
found event cpu_atom@CPU_CLK_UNHALTED.CORE@
found event cpu_atom@TOPDOWN_FE_BOUND.FRONTEND_LATENCY@
found event cpu_atom@TOPDOWN_FE_BOUND.ALL@
Parsing metric events '{cpu_atom/TOPDOWN_FE_BOUND.ICACHE,metric-id=cpu_atom!3TOPDOWN_FE_BOUND.ICACHE!3/,cpu_atom/CPU_CLK_UNHALTED.CORE,metric-id=cpu_atom!3CPU_CLK_UNHALTED.CORE!3/,cpu_atom/TOPDOWN_FE_BOUND.FRONTEND_LATENCY,metric-id=cpu_atom!3TOPDOWN_FE_BOUND.FRONTEND_LATENCY!3/,cpu_atom/TOPDOWN_FE_BOUND.ALL,metric-id=cpu_atom!3TOPDOWN_FE_BOUND.ALL!3/}:W'
Matched metric-id cpu_atom@TOPDOWN_FE_BOUND.ICACHE@ to cpu_atom/TOPDOWN_FE_BOUND.ICACHE/
Matched metric-id cpu_atom@CPU_CLK_UNHALTED.CORE@ to cpu_atom/CPU_CLK_UNHALTED.CORE/
Matched metric-id cpu_atom@TOPDOWN_FE_BOUND.FRONTEND_LATENCY@ to cpu_atom/TOPDOWN_FE_BOUND.FRONTEND_LATENCY/
Matched metric-id cpu_atom@TOPDOWN_FE_BOUND.ALL@ to cpu_atom/TOPDOWN_FE_BOUND.ALL/
cpu_core@ICACHE_DATA.STALLS@ not found
tma_info_thread_clks not found
Result nan
Found metric 'tma_ifetch_bandwidth'
metric expr cpu_atom@TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_ifetch_bandwidth
metric expr cpu_atom@TOPDOWN_FE_BOUND.ALL@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_frontend_bound
metric expr cpu_atom@TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_ifetch_bandwidth
found event cpu_atom@CPU_CLK_UNHALTED.CORE@
found event cpu_atom@TOPDOWN_FE_BOUND.ALL@
found event cpu_atom@TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH@
Parsing metric events '{cpu_atom/CPU_CLK_UNHALTED.CORE,metric-id=cpu_atom!3CPU_CLK_UNHALTED.CORE!3/,cpu_atom/TOPDOWN_FE_BOUND.ALL,metric-id=cpu_atom!3TOPDOWN_FE_BOUND.ALL!3/,cpu_atom/TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH,metric-id=cpu_atom!3TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH!3/}:W'
Matched metric-id cpu_atom@CPU_CLK_UNHALTED.CORE@ to cpu_atom/CPU_CLK_UNHALTED.CORE/
Matched metric-id cpu_atom@TOPDOWN_FE_BOUND.ALL@ to cpu_atom/TOPDOWN_FE_BOUND.ALL/
Matched metric-id cpu_atom@TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH@ to cpu_atom/TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH/
Result nan
Found metric 'tma_ifetch_latency'
metric expr cpu_atom@TOPDOWN_FE_BOUND.FRONTEND_LATENCY@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_ifetch_latency
metric expr cpu_atom@TOPDOWN_FE_BOUND.FRONTEND_LATENCY@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_ifetch_latency
metric expr cpu_atom@TOPDOWN_FE_BOUND.ALL@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_frontend_bound
found event cpu_atom@TOPDOWN_FE_BOUND.FRONTEND_LATENCY@
found event cpu_atom@CPU_CLK_UNHALTED.CORE@
found event cpu_atom@TOPDOWN_FE_BOUND.ALL@
Parsing metric events '{cpu_atom/TOPDOWN_FE_BOUND.FRONTEND_LATENCY,metric-id=cpu_atom!3TOPDOWN_FE_BOUND.FRONTEND_LATENCY!3/,cpu_atom/CPU_CLK_UNHALTED.CORE,metric-id=cpu_atom!3CPU_CLK_UNHALTED.CORE!3/,cpu_atom/TOPDOWN_FE_BOUND.ALL,metric-id=cpu_atom!3TOPDOWN_FE_BOUND.ALL!3/}:W'
Matched metric-id cpu_atom@TOPDOWN_FE_BOUND.FRONTEND_LATENCY@ to cpu_atom/TOPDOWN_FE_BOUND.FRONTEND_LATENCY/
Matched metric-id cpu_atom@CPU_CLK_UNHALTED.CORE@ to cpu_atom/CPU_CLK_UNHALTED.CORE/
Matched metric-id cpu_atom@TOPDOWN_FE_BOUND.ALL@ to cpu_atom/TOPDOWN_FE_BOUND.ALL/
Result nan
Found metric 'tma_info_bottleneck_%_dtlb_miss_bound_cycles'
metric expr 100 * (cpu_atom@LD_HEAD.DTLB_MISS_AT_RET@ + cpu_atom@LD_HEAD.PGWALK_AT_RET@) / cpu_atom@CPU_CLK_UNHALTED.CORE@ for tma_info_bottleneck_%_dtlb_miss_bound_cycles
found event cpu_atom@LD_HEAD.DTLB_MISS_AT_RET@
found event cpu_atom@CPU_CLK_UNHALTED.CORE@
found event cpu_atom@LD_HEAD.PGWALK_AT_RET@
Parsing metric events '{cpu_atom/LD_HEAD.DTLB_MISS_AT_RET,metric-id=cpu_atom!3LD_HEAD.DTLB_MISS_AT_RET!3/,cpu_atom/CPU_CLK_UNHALTED.CORE,metric-id=cpu_atom!3CPU_CLK_UNHALTED.CORE!3/,cpu_atom/LD_HEAD.PGWALK_AT_RET,metric-id=cpu_atom!3LD_HEAD.PGWALK_AT_RET!3/}:W'
Matched metric-id cpu_atom@LD_HEAD.DTLB_MISS_AT_RET@ to cpu_atom/LD_HEAD.DTLB_MISS_AT_RET/
Matched metric-id cpu_atom@CPU_CLK_UNHALTED.CORE@ to cpu_atom/CPU_CLK_UNHALTED.CORE/
Matched metric-id cpu_atom@LD_HEAD.PGWALK_AT_RET@ to cpu_atom/LD_HEAD.PGWALK_AT_RET/
Result nan
Found metric 'tma_info_bottleneck_%_ifetch_miss_bound_cycles'
metric expr 100 * cpu_atom@MEM_BOUND_STALLS.IFETCH@ / cpu_atom@CPU_CLK_UNHALTED.CORE@ for tma_info_bottleneck_%_ifetch_miss_bound_cycles
found event cpu_atom@CPU_CLK_UNHALTED.CORE@
found event cpu_atom@MEM_BOUND_STALLS.IFETCH@
Parsing metric events '{cpu_atom/CPU_CLK_UNHALTED.CORE,metric-id=cpu_atom!3CPU_CLK_UNHALTED.CORE!3/,cpu_atom/MEM_BOUND_STALLS.IFETCH,metric-id=cpu_atom!3MEM_BOUND_STALLS.IFETCH!3/}:W'
Matched metric-id cpu_atom@CPU_CLK_UNHALTED.CORE@ to cpu_atom/CPU_CLK_UNHALTED.CORE/
Matched metric-id cpu_atom@MEM_BOUND_STALLS.IFETCH@ to cpu_atom/MEM_BOUND_STALLS.IFETCH/
Result nan
Found metric 'tma_info_bottleneck_%_load_miss_bound_cycles'
metric expr 100 * cpu_atom@MEM_BOUND_STALLS.LOAD@ / cpu_atom@CPU_CLK_UNHALTED.CORE@ for tma_info_bottleneck_%_load_miss_bound_cycles
found event cpu_atom@MEM_BOUND_STALLS.LOAD@
found event cpu_atom@CPU_CLK_UNHALTED.CORE@
Parsing metric events '{cpu_atom/MEM_BOUND_STALLS.LOAD,metric-id=cpu_atom!3MEM_BOUND_STALLS.LOAD!3/,cpu_atom/CPU_CLK_UNHALTED.CORE,metric-id=cpu_atom!3CPU_CLK_UNHALTED.CORE!3/}:W'
Matched metric-id cpu_atom@MEM_BOUND_STALLS.LOAD@ to cpu_atom/MEM_BOUND_STALLS.LOAD/
Matched metric-id cpu_atom@CPU_CLK_UNHALTED.CORE@ to cpu_atom/CPU_CLK_UNHALTED.CORE/
Result nan
Found metric 'tma_info_bottleneck_%_mem_exec_bound_cycles'
metric expr 100 * cpu_atom@LD_HEAD.ANY_AT_RET@ / cpu_atom@CPU_CLK_UNHALTED.CORE@ for tma_info_bottleneck_%_mem_exec_bound_cycles
found event cpu_atom@CPU_CLK_UNHALTED.CORE@
found event cpu_atom@LD_HEAD.ANY_AT_RET@
Parsing metric events '{cpu_atom/CPU_CLK_UNHALTED.CORE,metric-id=cpu_atom!3CPU_CLK_UNHALTED.CORE!3/,cpu_atom/LD_HEAD.ANY_AT_RET,metric-id=cpu_atom!3LD_HEAD.ANY_AT_RET!3/}:W'
Matched metric-id cpu_atom@CPU_CLK_UNHALTED.CORE@ to cpu_atom/CPU_CLK_UNHALTED.CORE/
Matched metric-id cpu_atom@LD_HEAD.ANY_AT_RET@ to cpu_atom/LD_HEAD.ANY_AT_RET/
Result nan
Found metric 'tma_info_br_inst_mix_ipbranch'
metric expr cpu_atom@INST_RETIRED.ANY@ / cpu_atom@BR_INST_RETIRED.ALL_BRANCHES@ for tma_info_br_inst_mix_ipbranch
found event cpu_atom@INST_RETIRED.ANY@
found event cpu_atom@BR_INST_RETIRED.ALL_BRANCHES@
Parsing metric events '{cpu_atom/INST_RETIRED.ANY,metric-id=cpu_atom!3INST_RETIRED.ANY!3/,cpu_atom/BR_INST_RETIRED.ALL_BRANCHES,metric-id=cpu_atom!3BR_INST_RETIRED.ALL_BRANCHES!3/}:W'
Matched metric-id cpu_atom@INST_RETIRED.ANY@ to cpu_atom/INST_RETIRED.ANY/
Matched metric-id cpu_atom@BR_INST_RETIRED.ALL_BRANCHES@ to cpu_atom/BR_INST_RETIRED.ALL_BRANCHES/
Result nan
Found metric 'tma_info_br_inst_mix_ipcall'
metric expr cpu_atom@INST_RETIRED.ANY@ / cpu_atom@BR_INST_RETIRED.CALL@ for tma_info_br_inst_mix_ipcall
found event cpu_atom@INST_RETIRED.ANY@
found event cpu_atom@BR_INST_RETIRED.CALL@
Parsing metric events '{cpu_atom/INST_RETIRED.ANY,metric-id=cpu_atom!3INST_RETIRED.ANY!3/,cpu_atom/BR_INST_RETIRED.CALL,metric-id=cpu_atom!3BR_INST_RETIRED.CALL!3/}:W'
Matched metric-id cpu_atom@INST_RETIRED.ANY@ to cpu_atom/INST_RETIRED.ANY/
Matched metric-id cpu_atom@BR_INST_RETIRED.CALL@ to cpu_atom/BR_INST_RETIRED.CALL/
Result nan
Found metric 'tma_info_br_inst_mix_ipfarbranch'
metric expr cpu_atom@INST_RETIRED.ANY@ / cpu_atom@BR_INST_RETIRED.FAR_BRANCH@u for tma_info_br_inst_mix_ipfarbranch
found event cpu_atom@BR_INST_RETIRED.FAR_BRANCH@u
found event cpu_atom@INST_RETIRED.ANY@
Parsing metric events '{cpu_atom/BR_INST_RETIRED.FAR_BRANCH,metric-id=cpu_atom!3BR_INST_RETIRED.FAR_BRANCH!3u/u,cpu_atom/INST_RETIRED.ANY,metric-id=cpu_atom!3INST_RETIRED.ANY!3/}:W'
Matched metric-id cpu_atom@BR_INST_RETIRED.FAR_BRANCH@u to cpu_atom/BR_INST_RETIRED.FAR_BRANCH/u
Matched metric-id cpu_atom@INST_RETIRED.ANY@ to cpu_atom/INST_RETIRED.ANY/
Result nan
Found metric 'tma_info_br_inst_mix_ipmisp_cond_ntaken'
metric expr cpu_atom@INST_RETIRED.ANY@ / (cpu_atom@BR_MISP_RETIRED.COND@ - cpu_atom@BR_MISP_RETIRED.COND_TAKEN@) for tma_info_br_inst_mix_ipmisp_cond_ntaken
found event cpu_atom@BR_MISP_RETIRED.COND_TAKEN@
found event cpu_atom@INST_RETIRED.ANY@
found event cpu_atom@BR_MISP_RETIRED.COND@
Parsing metric events '{cpu_atom/BR_MISP_RETIRED.COND_TAKEN,metric-id=cpu_atom!3BR_MISP_RETIRED.COND_TAKEN!3/,cpu_atom/INST_RETIRED.ANY,metric-id=cpu_atom!3INST_RETIRED.ANY!3/,cpu_atom/BR_MISP_RETIRED.COND,metric-id=cpu_atom!3BR_MISP_RETIRED.COND!3/}:W'
Matched metric-id cpu_atom@BR_MISP_RETIRED.COND_TAKEN@ to cpu_atom/BR_MISP_RETIRED.COND_TAKEN/
Matched metric-id cpu_atom@INST_RETIRED.ANY@ to cpu_atom/INST_RETIRED.ANY/
Matched metric-id cpu_atom@BR_MISP_RETIRED.COND@ to cpu_atom/BR_MISP_RETIRED.COND/
Result nan
Found metric 'tma_info_br_inst_mix_ipmisp_cond_taken'
metric expr cpu_atom@INST_RETIRED.ANY@ / cpu_atom@BR_MISP_RETIRED.COND_TAKEN@ for tma_info_br_inst_mix_ipmisp_cond_taken
found event cpu_atom@BR_MISP_RETIRED.COND_TAKEN@
found event cpu_atom@INST_RETIRED.ANY@
Parsing metric events '{cpu_atom/BR_MISP_RETIRED.COND_TAKEN,metric-id=cpu_atom!3BR_MISP_RETIRED.COND_TAKEN!3/,cpu_atom/INST_RETIRED.ANY,metric-id=cpu_atom!3INST_RETIRED.ANY!3/}:W'
Matched metric-id cpu_atom@BR_MISP_RETIRED.COND_TAKEN@ to cpu_atom/BR_MISP_RETIRED.COND_TAKEN/
Matched metric-id cpu_atom@INST_RETIRED.ANY@ to cpu_atom/INST_RETIRED.ANY/
Result nan
Found metric 'tma_info_br_inst_mix_ipmisp_indirect'
metric expr cpu_atom@INST_RETIRED.ANY@ / cpu_atom@BR_MISP_RETIRED.INDIRECT@ for tma_info_br_inst_mix_ipmisp_indirect
found event cpu_atom@BR_MISP_RETIRED.INDIRECT@
found event cpu_atom@INST_RETIRED.ANY@
Parsing metric events '{cpu_atom/BR_MISP_RETIRED.INDIRECT,metric-id=cpu_atom!3BR_MISP_RETIRED.INDIRECT!3/,cpu_atom/INST_RETIRED.ANY,metric-id=cpu_atom!3INST_RETIRED.ANY!3/}:W'
Matched metric-id cpu_atom@BR_MISP_RETIRED.INDIRECT@ to cpu_atom/BR_MISP_RETIRED.INDIRECT/
Matched metric-id cpu_atom@INST_RETIRED.ANY@ to cpu_atom/INST_RETIRED.ANY/
Result nan
Found metric 'tma_info_br_inst_mix_ipmisp_ret'
metric expr cpu_atom@INST_RETIRED.ANY@ / cpu_atom@BR_MISP_RETIRED.RETURN@ for tma_info_br_inst_mix_ipmisp_ret
found event cpu_atom@INST_RETIRED.ANY@
found event cpu_atom@BR_MISP_RETIRED.RETURN@
Parsing metric events '{cpu_atom/INST_RETIRED.ANY,metric-id=cpu_atom!3INST_RETIRED.ANY!3/,cpu_atom/BR_MISP_RETIRED.RETURN,metric-id=cpu_atom!3BR_MISP_RETIRED.RETURN!3/}:W'
Matched metric-id cpu_atom@INST_RETIRED.ANY@ to cpu_atom/INST_RETIRED.ANY/
Matched metric-id cpu_atom@BR_MISP_RETIRED.RETURN@ to cpu_atom/BR_MISP_RETIRED.RETURN/
Result nan
Found metric 'tma_info_br_inst_mix_ipmispredict'
metric expr cpu_atom@INST_RETIRED.ANY@ / cpu_atom@BR_MISP_RETIRED.ALL_BRANCHES@ for tma_info_br_inst_mix_ipmispredict
found event cpu_atom@BR_MISP_RETIRED.ALL_BRANCHES@
found event cpu_atom@INST_RETIRED.ANY@
Parsing metric events '{cpu_atom/BR_MISP_RETIRED.ALL_BRANCHES,metric-id=cpu_atom!3BR_MISP_RETIRED.ALL_BRANCHES!3/,cpu_atom/INST_RETIRED.ANY,metric-id=cpu_atom!3INST_RETIRED.ANY!3/}:W'
Matched metric-id cpu_atom@BR_MISP_RETIRED.ALL_BRANCHES@ to cpu_atom/BR_MISP_RETIRED.ALL_BRANCHES/
Matched metric-id cpu_atom@INST_RETIRED.ANY@ to cpu_atom/INST_RETIRED.ANY/
Result nan
Found metric 'tma_info_br_mispredict_bound_branch_mispredict_ratio'
metric expr cpu_atom@BR_MISP_RETIRED.ALL_BRANCHES@ / cpu_atom@BR_INST_RETIRED.ALL_BRANCHES@ for tma_info_br_mispredict_bound_branch_mispredict_ratio
found event cpu_atom@BR_MISP_RETIRED.ALL_BRANCHES@
found event cpu_atom@BR_INST_RETIRED.ALL_BRANCHES@
Parsing metric events '{cpu_atom/BR_MISP_RETIRED.ALL_BRANCHES,metric-id=cpu_atom!3BR_MISP_RETIRED.ALL_BRANCHES!3/,cpu_atom/BR_INST_RETIRED.ALL_BRANCHES,metric-id=cpu_atom!3BR_INST_RETIRED.ALL_BRANCHES!3/}:W'
Matched metric-id cpu_atom@BR_MISP_RETIRED.ALL_BRANCHES@ to cpu_atom/BR_MISP_RETIRED.ALL_BRANCHES/
Matched metric-id cpu_atom@BR_INST_RETIRED.ALL_BRANCHES@ to cpu_atom/BR_INST_RETIRED.ALL_BRANCHES/
Result nan
Found metric 'tma_info_br_mispredict_bound_branch_mispredict_to_unknown_branch_ratio'
metric expr cpu_atom@BR_MISP_RETIRED.ALL_BRANCHES@ / cpu_atom@BACLEARS.ANY@ for tma_info_br_mispredict_bound_branch_mispredict_to_unknown_branch_ratio
found event cpu_atom@BACLEARS.ANY@
found event cpu_atom@BR_MISP_RETIRED.ALL_BRANCHES@
Parsing metric events '{cpu_atom/BACLEARS.ANY,metric-id=cpu_atom!3BACLEARS.ANY!3/,cpu_atom/BR_MISP_RETIRED.ALL_BRANCHES,metric-id=cpu_atom!3BR_MISP_RETIRED.ALL_BRANCHES!3/}:W'
Matched metric-id cpu_atom@BACLEARS.ANY@ to cpu_atom/BACLEARS.ANY/
Matched metric-id cpu_atom@BR_MISP_RETIRED.ALL_BRANCHES@ to cpu_atom/BR_MISP_RETIRED.ALL_BRANCHES/
Result nan
Found metric 'tma_info_buffer_stalls_%_load_buffer_stall_cycles'
metric expr 100 * cpu_atom@MEM_SCHEDULER_BLOCK.LD_BUF@ / cpu_atom@CPU_CLK_UNHALTED.CORE@ for tma_info_buffer_stalls_%_load_buffer_stall_cycles
found event cpu_atom@CPU_CLK_UNHALTED.CORE@
found event cpu_atom@MEM_SCHEDULER_BLOCK.LD_BUF@
Parsing metric events '{cpu_atom/CPU_CLK_UNHALTED.CORE,metric-id=cpu_atom!3CPU_CLK_UNHALTED.CORE!3/,cpu_atom/MEM_SCHEDULER_BLOCK.LD_BUF,metric-id=cpu_atom!3MEM_SCHEDULER_BLOCK.LD_BUF!3/}:W'
Matched metric-id cpu_atom@CPU_CLK_UNHALTED.CORE@ to cpu_atom/CPU_CLK_UNHALTED.CORE/
Matched metric-id cpu_atom@MEM_SCHEDULER_BLOCK.LD_BUF@ to cpu_atom/MEM_SCHEDULER_BLOCK.LD_BUF/
Result nan
Found metric 'tma_info_buffer_stalls_%_mem_rsv_stall_cycles'
metric expr 100 * cpu_atom@MEM_SCHEDULER_BLOCK.RSV@ / cpu_atom@CPU_CLK_UNHALTED.CORE@ for tma_info_buffer_stalls_%_mem_rsv_stall_cycles
found event cpu_atom@CPU_CLK_UNHALTED.CORE@
found event cpu_atom@MEM_SCHEDULER_BLOCK.RSV@
Parsing metric events '{cpu_atom/CPU_CLK_UNHALTED.CORE,metric-id=cpu_atom!3CPU_CLK_UNHALTED.CORE!3/,cpu_atom/MEM_SCHEDULER_BLOCK.RSV,metric-id=cpu_atom!3MEM_SCHEDULER_BLOCK.RSV!3/}:W'
Matched metric-id cpu_atom@CPU_CLK_UNHALTED.CORE@ to cpu_atom/CPU_CLK_UNHALTED.CORE/
Matched metric-id cpu_atom@MEM_SCHEDULER_BLOCK.RSV@ to cpu_atom/MEM_SCHEDULER_BLOCK.RSV/
Result nan
Found metric 'tma_info_buffer_stalls_%_store_buffer_stall_cycles'
metric expr 100 * cpu_atom@MEM_SCHEDULER_BLOCK.ST_BUF@ / cpu_atom@CPU_CLK_UNHALTED.CORE@ for tma_info_buffer_stalls_%_store_buffer_stall_cycles
found event cpu_atom@CPU_CLK_UNHALTED.CORE@
found event cpu_atom@MEM_SCHEDULER_BLOCK.ST_BUF@
Parsing metric events '{cpu_atom/CPU_CLK_UNHALTED.CORE,metric-id=cpu_atom!3CPU_CLK_UNHALTED.CORE!3/,cpu_atom/MEM_SCHEDULER_BLOCK.ST_BUF,metric-id=cpu_atom!3MEM_SCHEDULER_BLOCK.ST_BUF!3/}:W'
Matched metric-id cpu_atom@CPU_CLK_UNHALTED.CORE@ to cpu_atom/CPU_CLK_UNHALTED.CORE/
Matched metric-id cpu_atom@MEM_SCHEDULER_BLOCK.ST_BUF@ to cpu_atom/MEM_SCHEDULER_BLOCK.ST_BUF/
Result nan
Found metric 'tma_info_core_cpi'
metric expr cpu_atom@CPU_CLK_UNHALTED.CORE@ / cpu_atom@INST_RETIRED.ANY@ for tma_info_core_cpi
found event cpu_atom@CPU_CLK_UNHALTED.CORE@
found event cpu_atom@INST_RETIRED.ANY@
Parsing metric events '{cpu_atom/CPU_CLK_UNHALTED.CORE,metric-id=cpu_atom!3CPU_CLK_UNHALTED.CORE!3/,cpu_atom/INST_RETIRED.ANY,metric-id=cpu_atom!3INST_RETIRED.ANY!3/}:W'
Matched metric-id cpu_atom@CPU_CLK_UNHALTED.CORE@ to cpu_atom/CPU_CLK_UNHALTED.CORE/
Matched metric-id cpu_atom@INST_RETIRED.ANY@ to cpu_atom/INST_RETIRED.ANY/
Result nan
Found metric 'tma_info_core_ipc'
metric expr cpu_atom@INST_RETIRED.ANY@ / cpu_atom@CPU_CLK_UNHALTED.CORE@ for tma_info_core_ipc
found event cpu_atom@CPU_CLK_UNHALTED.CORE@
found event cpu_atom@INST_RETIRED.ANY@
Parsing metric events '{cpu_atom/CPU_CLK_UNHALTED.CORE,metric-id=cpu_atom!3CPU_CLK_UNHALTED.CORE!3/,cpu_atom/INST_RETIRED.ANY,metric-id=cpu_atom!3INST_RETIRED.ANY!3/}:W'
Matched metric-id cpu_atom@CPU_CLK_UNHALTED.CORE@ to cpu_atom/CPU_CLK_UNHALTED.CORE/
Matched metric-id cpu_atom@INST_RETIRED.ANY@ to cpu_atom/INST_RETIRED.ANY/
Result nan
Found metric 'tma_info_core_upi'
metric expr cpu_atom@UOPS_RETIRED.ALL@ / cpu_atom@INST_RETIRED.ANY@ for tma_info_core_upi
found event cpu_atom@UOPS_RETIRED.ALL@
found event cpu_atom@INST_RETIRED.ANY@
Parsing metric events '{cpu_atom/UOPS_RETIRED.ALL,metric-id=cpu_atom!3UOPS_RETIRED.ALL!3/,cpu_atom/INST_RETIRED.ANY,metric-id=cpu_atom!3INST_RETIRED.ANY!3/}:W'
Matched metric-id cpu_atom@UOPS_RETIRED.ALL@ to cpu_atom/UOPS_RETIRED.ALL/
Matched metric-id cpu_atom@INST_RETIRED.ANY@ to cpu_atom/INST_RETIRED.ANY/
Result nan
Found metric 'tma_info_ifetch_miss_bound_%_ifetchmissbound_with_l2hit'
metric expr 100 * cpu_atom@MEM_BOUND_STALLS.IFETCH_L2_HIT@ / cpu_atom@MEM_BOUND_STALLS.IFETCH@ for tma_info_ifetch_miss_bound_%_ifetchmissbound_with_l2hit
found event cpu_atom@MEM_BOUND_STALLS.IFETCH@
found event cpu_atom@MEM_BOUND_STALLS.IFETCH_L2_HIT@
Parsing metric events '{cpu_atom/MEM_BOUND_STALLS.IFETCH,metric-id=cpu_atom!3MEM_BOUND_STALLS.IFETCH!3/,cpu_atom/MEM_BOUND_STALLS.IFETCH_L2_HIT,metric-id=cpu_atom!3MEM_BOUND_STALLS.IFETCH_L2_HIT!3/}:W'
Matched metric-id cpu_atom@MEM_BOUND_STALLS.IFETCH@ to cpu_atom/MEM_BOUND_STALLS.IFETCH/
Matched metric-id cpu_atom@MEM_BOUND_STALLS.IFETCH_L2_HIT@ to cpu_atom/MEM_BOUND_STALLS.IFETCH_L2_HIT/
Result nan
Found metric 'tma_info_ifetch_miss_bound_%_ifetchmissbound_with_l2miss'
metric expr 100 * (cpu_atom@MEM_BOUND_STALLS.IFETCH_LLC_HIT@ + cpu_atom@MEM_BOUND_STALLS.IFETCH_DRAM_HIT@) / cpu_atom@MEM_BOUND_STALLS.IFETCH@ for tma_info_ifetch_miss_bound_%_ifetchmissbound_with_l2miss
found event cpu_atom@MEM_BOUND_STALLS.IFETCH@
found event cpu_atom@MEM_BOUND_STALLS.IFETCH_LLC_HIT@
found event cpu_atom@MEM_BOUND_STALLS.IFETCH_DRAM_HIT@
Parsing metric events '{cpu_atom/MEM_BOUND_STALLS.IFETCH,metric-id=cpu_atom!3MEM_BOUND_STALLS.IFETCH!3/,cpu_atom/MEM_BOUND_STALLS.IFETCH_LLC_HIT,metric-id=cpu_atom!3MEM_BOUND_STALLS.IFETCH_LLC_HIT!3/,cpu_atom/MEM_BOUND_STALLS.IFETCH_DRAM_HIT,metric-id=cpu_atom!3MEM_BOUND_STALLS.IFETCH_DRAM_HIT!3/}:W'
Matched metric-id cpu_atom@MEM_BOUND_STALLS.IFETCH@ to cpu_atom/MEM_BOUND_STALLS.IFETCH/
Matched metric-id cpu_atom@MEM_BOUND_STALLS.IFETCH_LLC_HIT@ to cpu_atom/MEM_BOUND_STALLS.IFETCH_LLC_HIT/
Matched metric-id cpu_atom@MEM_BOUND_STALLS.IFETCH_DRAM_HIT@ to cpu_atom/MEM_BOUND_STALLS.IFETCH_DRAM_HIT/
Result nan
Found metric 'tma_info_ifetch_miss_bound_%_ifetchmissbound_with_l3hit'
metric expr 100 * cpu_atom@MEM_BOUND_STALLS.IFETCH_LLC_HIT@ / cpu_atom@MEM_BOUND_STALLS.IFETCH@ for tma_info_ifetch_miss_bound_%_ifetchmissbound_with_l3hit
found event cpu_atom@MEM_BOUND_STALLS.IFETCH@
found event cpu_atom@MEM_BOUND_STALLS.IFETCH_LLC_HIT@
Parsing metric events '{cpu_atom/MEM_BOUND_STALLS.IFETCH,metric-id=cpu_atom!3MEM_BOUND_STALLS.IFETCH!3/,cpu_atom/MEM_BOUND_STALLS.IFETCH_LLC_HIT,metric-id=cpu_atom!3MEM_BOUND_STALLS.IFETCH_LLC_HIT!3/}:W'
Matched metric-id cpu_atom@MEM_BOUND_STALLS.IFETCH@ to cpu_atom/MEM_BOUND_STALLS.IFETCH/
Matched metric-id cpu_atom@MEM_BOUND_STALLS.IFETCH_LLC_HIT@ to cpu_atom/MEM_BOUND_STALLS.IFETCH_LLC_HIT/
Result nan
Found metric 'tma_info_ifetch_miss_bound_%_ifetchmissbound_with_l3miss'
metric expr 100 * cpu_atom@MEM_BOUND_STALLS.IFETCH_DRAM_HIT@ / cpu_atom@MEM_BOUND_STALLS.IFETCH@ for tma_info_ifetch_miss_bound_%_ifetchmissbound_with_l3miss
found event cpu_atom@MEM_BOUND_STALLS.IFETCH@
found event cpu_atom@MEM_BOUND_STALLS.IFETCH_DRAM_HIT@
Parsing metric events '{cpu_atom/MEM_BOUND_STALLS.IFETCH,metric-id=cpu_atom!3MEM_BOUND_STALLS.IFETCH!3/,cpu_atom/MEM_BOUND_STALLS.IFETCH_DRAM_HIT,metric-id=cpu_atom!3MEM_BOUND_STALLS.IFETCH_DRAM_HIT!3/}:W'
Matched metric-id cpu_atom@MEM_BOUND_STALLS.IFETCH@ to cpu_atom/MEM_BOUND_STALLS.IFETCH/
Matched metric-id cpu_atom@MEM_BOUND_STALLS.IFETCH_DRAM_HIT@ to cpu_atom/MEM_BOUND_STALLS.IFETCH_DRAM_HIT/
Result nan
Found metric 'tma_info_load_miss_bound_%_loadmissbound_with_l2hit'
metric expr 100 * cpu_atom@MEM_BOUND_STALLS.LOAD_L2_HIT@ / cpu_atom@MEM_BOUND_STALLS.LOAD@ for tma_info_load_miss_bound_%_loadmissbound_with_l2hit
found event cpu_atom@MEM_BOUND_STALLS.LOAD@
found event cpu_atom@MEM_BOUND_STALLS.LOAD_L2_HIT@
Parsing metric events '{cpu_atom/MEM_BOUND_STALLS.LOAD,metric-id=cpu_atom!3MEM_BOUND_STALLS.LOAD!3/,cpu_atom/MEM_BOUND_STALLS.LOAD_L2_HIT,metric-id=cpu_atom!3MEM_BOUND_STALLS.LOAD_L2_HIT!3/}:W'
Matched metric-id cpu_atom@MEM_BOUND_STALLS.LOAD@ to cpu_atom/MEM_BOUND_STALLS.LOAD/
Matched metric-id cpu_atom@MEM_BOUND_STALLS.LOAD_L2_HIT@ to cpu_atom/MEM_BOUND_STALLS.LOAD_L2_HIT/
Result nan
Found metric 'tma_info_load_miss_bound_%_loadmissbound_with_l2miss'
metric expr 100 * (cpu_atom@MEM_BOUND_STALLS.LOAD_LLC_HIT@ + cpu_atom@MEM_BOUND_STALLS.LOAD_DRAM_HIT@) / cpu_atom@MEM_BOUND_STALLS.LOAD@ for tma_info_load_miss_bound_%_loadmissbound_with_l2miss
found event cpu_atom@MEM_BOUND_STALLS.LOAD@
found event cpu_atom@MEM_BOUND_STALLS.LOAD_DRAM_HIT@
found event cpu_atom@MEM_BOUND_STALLS.LOAD_LLC_HIT@
Parsing metric events '{cpu_atom/MEM_BOUND_STALLS.LOAD,metric-id=cpu_atom!3MEM_BOUND_STALLS.LOAD!3/,cpu_atom/MEM_BOUND_STALLS.LOAD_DRAM_HIT,metric-id=cpu_atom!3MEM_BOUND_STALLS.LOAD_DRAM_HIT!3/,cpu_atom/MEM_BOUND_STALLS.LOAD_LLC_HIT,metric-id=cpu_atom!3MEM_BOUND_STALLS.LOAD_LLC_HIT!3/}:W'
Matched metric-id cpu_atom@MEM_BOUND_STALLS.LOAD@ to cpu_atom/MEM_BOUND_STALLS.LOAD/
Matched metric-id cpu_atom@MEM_BOUND_STALLS.LOAD_DRAM_HIT@ to cpu_atom/MEM_BOUND_STALLS.LOAD_DRAM_HIT/
Matched metric-id cpu_atom@MEM_BOUND_STALLS.LOAD_LLC_HIT@ to cpu_atom/MEM_BOUND_STALLS.LOAD_LLC_HIT/
Result nan
Found metric 'tma_info_load_miss_bound_%_loadmissbound_with_l3hit'
metric expr 100 * cpu_atom@MEM_BOUND_STALLS.LOAD_LLC_HIT@ / cpu_atom@MEM_BOUND_STALLS.LOAD@ for tma_info_load_miss_bound_%_loadmissbound_with_l3hit
found event cpu_atom@MEM_BOUND_STALLS.LOAD@
found event cpu_atom@MEM_BOUND_STALLS.LOAD_LLC_HIT@
Parsing metric events '{cpu_atom/MEM_BOUND_STALLS.LOAD,metric-id=cpu_atom!3MEM_BOUND_STALLS.LOAD!3/,cpu_atom/MEM_BOUND_STALLS.LOAD_LLC_HIT,metric-id=cpu_atom!3MEM_BOUND_STALLS.LOAD_LLC_HIT!3/}:W'
Matched metric-id cpu_atom@MEM_BOUND_STALLS.LOAD@ to cpu_atom/MEM_BOUND_STALLS.LOAD/
Matched metric-id cpu_atom@MEM_BOUND_STALLS.LOAD_LLC_HIT@ to cpu_atom/MEM_BOUND_STALLS.LOAD_LLC_HIT/
Result nan
Found metric 'tma_info_load_miss_bound_%_loadmissbound_with_l3miss'
metric expr 100 * cpu_atom@MEM_BOUND_STALLS.LOAD_DRAM_HIT@ / cpu_atom@MEM_BOUND_STALLS.LOAD@ for tma_info_load_miss_bound_%_loadmissbound_with_l3miss
found event cpu_atom@MEM_BOUND_STALLS.LOAD@
found event cpu_atom@MEM_BOUND_STALLS.LOAD_DRAM_HIT@
Parsing metric events '{cpu_atom/MEM_BOUND_STALLS.LOAD,metric-id=cpu_atom!3MEM_BOUND_STALLS.LOAD!3/,cpu_atom/MEM_BOUND_STALLS.LOAD_DRAM_HIT,metric-id=cpu_atom!3MEM_BOUND_STALLS.LOAD_DRAM_HIT!3/}:W'
Matched metric-id cpu_atom@MEM_BOUND_STALLS.LOAD@ to cpu_atom/MEM_BOUND_STALLS.LOAD/
Matched metric-id cpu_atom@MEM_BOUND_STALLS.LOAD_DRAM_HIT@ to cpu_atom/MEM_BOUND_STALLS.LOAD_DRAM_HIT/
Result nan
Found metric 'tma_info_load_store_bound_l1_bound'
metric expr 100 * cpu_atom@LD_HEAD.L1_BOUND_AT_RET@ / cpu_atom@CPU_CLK_UNHALTED.CORE@ for tma_info_load_store_bound_l1_bound
found event cpu_atom@CPU_CLK_UNHALTED.CORE@
found event cpu_atom@LD_HEAD.L1_BOUND_AT_RET@
Parsing metric events '{cpu_atom/CPU_CLK_UNHALTED.CORE,metric-id=cpu_atom!3CPU_CLK_UNHALTED.CORE!3/,cpu_atom/LD_HEAD.L1_BOUND_AT_RET,metric-id=cpu_atom!3LD_HEAD.L1_BOUND_AT_RET!3/}:W'
Matched metric-id cpu_atom@CPU_CLK_UNHALTED.CORE@ to cpu_atom/CPU_CLK_UNHALTED.CORE/
Matched metric-id cpu_atom@LD_HEAD.L1_BOUND_AT_RET@ to cpu_atom/LD_HEAD.L1_BOUND_AT_RET/
Result nan
Found metric 'tma_info_load_store_bound_load_bound'
metric expr 100 * (cpu_atom@LD_HEAD.L1_BOUND_AT_RET@ + cpu_atom@MEM_BOUND_STALLS.LOAD@) / cpu_atom@CPU_CLK_UNHALTED.CORE@ for tma_info_load_store_bound_load_bound
found event cpu_atom@MEM_BOUND_STALLS.LOAD@
found event cpu_atom@CPU_CLK_UNHALTED.CORE@
found event cpu_atom@LD_HEAD.L1_BOUND_AT_RET@
Parsing metric events '{cpu_atom/MEM_BOUND_STALLS.LOAD,metric-id=cpu_atom!3MEM_BOUND_STALLS.LOAD!3/,cpu_atom/CPU_CLK_UNHALTED.CORE,metric-id=cpu_atom!3CPU_CLK_UNHALTED.CORE!3/,cpu_atom/LD_HEAD.L1_BOUND_AT_RET,metric-id=cpu_atom!3LD_HEAD.L1_BOUND_AT_RET!3/}:W'
Matched metric-id cpu_atom@MEM_BOUND_STALLS.LOAD@ to cpu_atom/MEM_BOUND_STALLS.LOAD/
Matched metric-id cpu_atom@CPU_CLK_UNHALTED.CORE@ to cpu_atom/CPU_CLK_UNHALTED.CORE/
Matched metric-id cpu_atom@LD_HEAD.L1_BOUND_AT_RET@ to cpu_atom/LD_HEAD.L1_BOUND_AT_RET/
Result nan
Found metric 'tma_info_load_store_bound_store_bound'
metric expr 100 * (cpu_atom@MEM_SCHEDULER_BLOCK.ST_BUF@ / cpu_atom@MEM_SCHEDULER_BLOCK.ALL@) * tma_mem_scheduler for tma_info_load_store_bound_store_bound
metric expr cpu_atom@TOPDOWN_BE_BOUND.MEM_SCHEDULER@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_mem_scheduler
found event cpu_atom@TOPDOWN_BE_BOUND.MEM_SCHEDULER@
found event cpu_atom@CPU_CLK_UNHALTED.CORE@
found event cpu_atom@MEM_SCHEDULER_BLOCK.ST_BUF@
found event cpu_atom@MEM_SCHEDULER_BLOCK.ALL@
Parsing metric events '{cpu_atom/TOPDOWN_BE_BOUND.MEM_SCHEDULER,metric-id=cpu_atom!3TOPDOWN_BE_BOUND.MEM_SCHEDULER!3/,cpu_atom/CPU_CLK_UNHALTED.CORE,metric-id=cpu_atom!3CPU_CLK_UNHALTED.CORE!3/,cpu_atom/MEM_SCHEDULER_BLOCK.ST_BUF,metric-id=cpu_atom!3MEM_SCHEDULER_BLOCK.ST_BUF!3/,cpu_atom/MEM_SCHEDULER_BLOCK.ALL,metric-id=cpu_atom!3MEM_SCHEDULER_BLOCK.ALL!3/}:W'
Matched metric-id cpu_atom@TOPDOWN_BE_BOUND.MEM_SCHEDULER@ to cpu_atom/TOPDOWN_BE_BOUND.MEM_SCHEDULER/
Matched metric-id cpu_atom@CPU_CLK_UNHALTED.CORE@ to cpu_atom/CPU_CLK_UNHALTED.CORE/
Matched metric-id cpu_atom@MEM_SCHEDULER_BLOCK.ST_BUF@ to cpu_atom/MEM_SCHEDULER_BLOCK.ST_BUF/
Matched metric-id cpu_atom@MEM_SCHEDULER_BLOCK.ALL@ to cpu_atom/MEM_SCHEDULER_BLOCK.ALL/
processing metric: tma_mem_scheduler ENTRY
processing metric: tma_mem_scheduler EXIT: nan
Result nan
Found metric 'tma_info_machine_clear_bound_machine_clears_disamb_pki'
metric expr 1e3 * cpu_atom@MACHINE_CLEARS.DISAMBIGUATION@ / cpu_atom@INST_RETIRED.ANY@ for tma_info_machine_clear_bound_machine_clears_disamb_pki
found event cpu_atom@INST_RETIRED.ANY@
found event cpu_atom@MACHINE_CLEARS.DISAMBIGUATION@
Parsing metric events '{cpu_atom/INST_RETIRED.ANY,metric-id=cpu_atom!3INST_RETIRED.ANY!3/,cpu_atom/MACHINE_CLEARS.DISAMBIGUATION,metric-id=cpu_atom!3MACHINE_CLEARS.DISAMBIGUATION!3/}:W'
Matched metric-id cpu_atom@INST_RETIRED.ANY@ to cpu_atom/INST_RETIRED.ANY/
Matched metric-id cpu_atom@MACHINE_CLEARS.DISAMBIGUATION@ to cpu_atom/MACHINE_CLEARS.DISAMBIGUATION/
Result nan
Found metric 'tma_info_machine_clear_bound_machine_clears_fp_assist_pki'
metric expr 1e3 * cpu_atom@MACHINE_CLEARS.FP_ASSIST@ / cpu_atom@INST_RETIRED.ANY@ for tma_info_machine_clear_bound_machine_clears_fp_assist_pki
found event cpu_atom@INST_RETIRED.ANY@
found event cpu_atom@MACHINE_CLEARS.FP_ASSIST@
Parsing metric events '{cpu_atom/INST_RETIRED.ANY,metric-id=cpu_atom!3INST_RETIRED.ANY!3/,cpu_atom/MACHINE_CLEARS.FP_ASSIST,metric-id=cpu_atom!3MACHINE_CLEARS.FP_ASSIST!3/}:W'
Matched metric-id cpu_atom@INST_RETIRED.ANY@ to cpu_atom/INST_RETIRED.ANY/
Matched metric-id cpu_atom@MACHINE_CLEARS.FP_ASSIST@ to cpu_atom/MACHINE_CLEARS.FP_ASSIST/
Result nan
Found metric 'tma_info_machine_clear_bound_machine_clears_monuke_pki'
metric expr 1e3 * cpu_atom@MACHINE_CLEARS.MEMORY_ORDERING@ / cpu_atom@INST_RETIRED.ANY@ for tma_info_machine_clear_bound_machine_clears_monuke_pki
found event cpu_atom@MACHINE_CLEARS.MEMORY_ORDERING@
found event cpu_atom@INST_RETIRED.ANY@
Parsing metric events '{cpu_atom/MACHINE_CLEARS.MEMORY_ORDERING,metric-id=cpu_atom!3MACHINE_CLEARS.MEMORY_ORDERING!3/,cpu_atom/INST_RETIRED.ANY,metric-id=cpu_atom!3INST_RETIRED.ANY!3/}:W'
Matched metric-id cpu_atom@MACHINE_CLEARS.MEMORY_ORDERING@ to cpu_atom/MACHINE_CLEARS.MEMORY_ORDERING/
Matched metric-id cpu_atom@INST_RETIRED.ANY@ to cpu_atom/INST_RETIRED.ANY/
Result nan
Found metric 'tma_info_machine_clear_bound_machine_clears_mrn_pki'
metric expr 1e3 * cpu_atom@MACHINE_CLEARS.MRN_NUKE@ / cpu_atom@INST_RETIRED.ANY@ for tma_info_machine_clear_bound_machine_clears_mrn_pki
found event cpu_atom@MACHINE_CLEARS.MRN_NUKE@
found event cpu_atom@INST_RETIRED.ANY@
Parsing metric events '{cpu_atom/MACHINE_CLEARS.MRN_NUKE,metric-id=cpu_atom!3MACHINE_CLEARS.MRN_NUKE!3/,cpu_atom/INST_RETIRED.ANY,metric-id=cpu_atom!3INST_RETIRED.ANY!3/}:W'
Matched metric-id cpu_atom@MACHINE_CLEARS.MRN_NUKE@ to cpu_atom/MACHINE_CLEARS.MRN_NUKE/
Matched metric-id cpu_atom@INST_RETIRED.ANY@ to cpu_atom/INST_RETIRED.ANY/
Result nan
Found metric 'tma_info_machine_clear_bound_machine_clears_page_fault_pki'
metric expr 1e3 * cpu_atom@MACHINE_CLEARS.PAGE_FAULT@ / cpu_atom@INST_RETIRED.ANY@ for tma_info_machine_clear_bound_machine_clears_page_fault_pki
found event cpu_atom@INST_RETIRED.ANY@
found event cpu_atom@MACHINE_CLEARS.PAGE_FAULT@
Parsing metric events '{cpu_atom/INST_RETIRED.ANY,metric-id=cpu_atom!3INST_RETIRED.ANY!3/,cpu_atom/MACHINE_CLEARS.PAGE_FAULT,metric-id=cpu_atom!3MACHINE_CLEARS.PAGE_FAULT!3/}:W'
Matched metric-id cpu_atom@INST_RETIRED.ANY@ to cpu_atom/INST_RETIRED.ANY/
Matched metric-id cpu_atom@MACHINE_CLEARS.PAGE_FAULT@ to cpu_atom/MACHINE_CLEARS.PAGE_FAULT/
Result nan
Found metric 'tma_info_machine_clear_bound_machine_clears_smc_pki'
metric expr 1e3 * cpu_atom@MACHINE_CLEARS.SMC@ / cpu_atom@INST_RETIRED.ANY@ for tma_info_machine_clear_bound_machine_clears_smc_pki
found event cpu_atom@MACHINE_CLEARS.SMC@
found event cpu_atom@INST_RETIRED.ANY@
Parsing metric events '{cpu_atom/MACHINE_CLEARS.SMC,metric-id=cpu_atom!3MACHINE_CLEARS.SMC!3/,cpu_atom/INST_RETIRED.ANY,metric-id=cpu_atom!3INST_RETIRED.ANY!3/}:W'
Matched metric-id cpu_atom@MACHINE_CLEARS.SMC@ to cpu_atom/MACHINE_CLEARS.SMC/
Matched metric-id cpu_atom@INST_RETIRED.ANY@ to cpu_atom/INST_RETIRED.ANY/
Result nan
Found metric 'tma_info_mem_exec_blocks_%_loads_with_adressaliasing'
metric expr 100 * cpu_atom@LD_BLOCKS.4K_ALIAS@ / cpu_atom@MEM_UOPS_RETIRED.ALL_LOADS@ for tma_info_mem_exec_blocks_%_loads_with_adressaliasing
found event cpu_atom@MEM_UOPS_RETIRED.ALL_LOADS@
found event cpu_atom@LD_BLOCKS.4K_ALIAS@
Parsing metric events '{cpu_atom/MEM_UOPS_RETIRED.ALL_LOADS,metric-id=cpu_atom!3MEM_UOPS_RETIRED.ALL_LOADS!3/,cpu_atom/LD_BLOCKS.4K_ALIAS,metric-id=cpu_atom!3LD_BLOCKS.4K_ALIAS!3/}:W'
Matched metric-id cpu_atom@MEM_UOPS_RETIRED.ALL_LOADS@ to cpu_atom/MEM_UOPS_RETIRED.ALL_LOADS/
Matched metric-id cpu_atom@LD_BLOCKS.4K_ALIAS@ to cpu_atom/LD_BLOCKS.4K_ALIAS/
Result nan
Found metric 'tma_info_mem_exec_blocks_%_loads_with_storefwdblk'
metric expr 100 * cpu_atom@LD_BLOCKS.DATA_UNKNOWN@ / cpu_atom@MEM_UOPS_RETIRED.ALL_LOADS@ for tma_info_mem_exec_blocks_%_loads_with_storefwdblk
found event cpu_atom@MEM_UOPS_RETIRED.ALL_LOADS@
found event cpu_atom@LD_BLOCKS.DATA_UNKNOWN@
Parsing metric events '{cpu_atom/MEM_UOPS_RETIRED.ALL_LOADS,metric-id=cpu_atom!3MEM_UOPS_RETIRED.ALL_LOADS!3/,cpu_atom/LD_BLOCKS.DATA_UNKNOWN,metric-id=cpu_atom!3LD_BLOCKS.DATA_UNKNOWN!3/}:W'
Matched metric-id cpu_atom@MEM_UOPS_RETIRED.ALL_LOADS@ to cpu_atom/MEM_UOPS_RETIRED.ALL_LOADS/
Matched metric-id cpu_atom@LD_BLOCKS.DATA_UNKNOWN@ to cpu_atom/LD_BLOCKS.DATA_UNKNOWN/
Result nan
Found metric 'tma_info_mem_exec_bound_%_loadhead_with_l1miss'
metric expr 100 * cpu_atom@LD_HEAD.L1_MISS_AT_RET@ / cpu_atom@LD_HEAD.ANY_AT_RET@ for tma_info_mem_exec_bound_%_loadhead_with_l1miss
found event cpu_atom@LD_HEAD.ANY_AT_RET@
found event cpu_atom@LD_HEAD.L1_MISS_AT_RET@
Parsing metric events '{cpu_atom/LD_HEAD.ANY_AT_RET,metric-id=cpu_atom!3LD_HEAD.ANY_AT_RET!3/,cpu_atom/LD_HEAD.L1_MISS_AT_RET,metric-id=cpu_atom!3LD_HEAD.L1_MISS_AT_RET!3/}:W'
Matched metric-id cpu_atom@LD_HEAD.ANY_AT_RET@ to cpu_atom/LD_HEAD.ANY_AT_RET/
Matched metric-id cpu_atom@LD_HEAD.L1_MISS_AT_RET@ to cpu_atom/LD_HEAD.L1_MISS_AT_RET/
Result nan
Found metric 'tma_info_mem_exec_bound_%_loadhead_with_otherpipelineblks'
metric expr 100 * cpu_atom@LD_HEAD.OTHER_AT_RET@ / cpu_atom@LD_HEAD.ANY_AT_RET@ for tma_info_mem_exec_bound_%_loadhead_with_otherpipelineblks
found event cpu_atom@LD_HEAD.OTHER_AT_RET@
found event cpu_atom@LD_HEAD.ANY_AT_RET@
Parsing metric events '{cpu_atom/LD_HEAD.OTHER_AT_RET,metric-id=cpu_atom!3LD_HEAD.OTHER_AT_RET!3/,cpu_atom/LD_HEAD.ANY_AT_RET,metric-id=cpu_atom!3LD_HEAD.ANY_AT_RET!3/}:W'
Matched metric-id cpu_atom@LD_HEAD.OTHER_AT_RET@ to cpu_atom/LD_HEAD.OTHER_AT_RET/
Matched metric-id cpu_atom@LD_HEAD.ANY_AT_RET@ to cpu_atom/LD_HEAD.ANY_AT_RET/
Result nan
Found metric 'tma_info_mem_exec_bound_%_loadhead_with_pagewalk'
metric expr 100 * cpu_atom@LD_HEAD.PGWALK_AT_RET@ / cpu_atom@LD_HEAD.ANY_AT_RET@ for tma_info_mem_exec_bound_%_loadhead_with_pagewalk
found event cpu_atom@LD_HEAD.PGWALK_AT_RET@
found event cpu_atom@LD_HEAD.ANY_AT_RET@
Parsing metric events '{cpu_atom/LD_HEAD.PGWALK_AT_RET,metric-id=cpu_atom!3LD_HEAD.PGWALK_AT_RET!3/,cpu_atom/LD_HEAD.ANY_AT_RET,metric-id=cpu_atom!3LD_HEAD.ANY_AT_RET!3/}:W'
Matched metric-id cpu_atom@LD_HEAD.PGWALK_AT_RET@ to cpu_atom/LD_HEAD.PGWALK_AT_RET/
Matched metric-id cpu_atom@LD_HEAD.ANY_AT_RET@ to cpu_atom/LD_HEAD.ANY_AT_RET/
Result nan
Found metric 'tma_info_mem_exec_bound_%_loadhead_with_stlbhit'
metric expr 100 * cpu_atom@LD_HEAD.DTLB_MISS_AT_RET@ / cpu_atom@LD_HEAD.ANY_AT_RET@ for tma_info_mem_exec_bound_%_loadhead_with_stlbhit
found event cpu_atom@LD_HEAD.DTLB_MISS_AT_RET@
found event cpu_atom@LD_HEAD.ANY_AT_RET@
Parsing metric events '{cpu_atom/LD_HEAD.DTLB_MISS_AT_RET,metric-id=cpu_atom!3LD_HEAD.DTLB_MISS_AT_RET!3/,cpu_atom/LD_HEAD.ANY_AT_RET,metric-id=cpu_atom!3LD_HEAD.ANY_AT_RET!3/}:W'
Matched metric-id cpu_atom@LD_HEAD.DTLB_MISS_AT_RET@ to cpu_atom/LD_HEAD.DTLB_MISS_AT_RET/
Matched metric-id cpu_atom@LD_HEAD.ANY_AT_RET@ to cpu_atom/LD_HEAD.ANY_AT_RET/
Result nan
Found metric 'tma_info_mem_exec_bound_%_loadhead_with_storefwding'
metric expr 100 * cpu_atom@LD_HEAD.ST_ADDR_AT_RET@ / cpu_atom@LD_HEAD.ANY_AT_RET@ for tma_info_mem_exec_bound_%_loadhead_with_storefwding
found event cpu_atom@LD_HEAD.ST_ADDR_AT_RET@
found event cpu_atom@LD_HEAD.ANY_AT_RET@
Parsing metric events '{cpu_atom/LD_HEAD.ST_ADDR_AT_RET,metric-id=cpu_atom!3LD_HEAD.ST_ADDR_AT_RET!3/,cpu_atom/LD_HEAD.ANY_AT_RET,metric-id=cpu_atom!3LD_HEAD.ANY_AT_RET!3/}:W'
Matched metric-id cpu_atom@LD_HEAD.ST_ADDR_AT_RET@ to cpu_atom/LD_HEAD.ST_ADDR_AT_RET/
Matched metric-id cpu_atom@LD_HEAD.ANY_AT_RET@ to cpu_atom/LD_HEAD.ANY_AT_RET/
Result nan
Found metric 'tma_info_mem_mix_ipload'
metric expr cpu_atom@INST_RETIRED.ANY@ / cpu_atom@MEM_UOPS_RETIRED.ALL_LOADS@ for tma_info_mem_mix_ipload
found event cpu_atom@MEM_UOPS_RETIRED.ALL_LOADS@
found event cpu_atom@INST_RETIRED.ANY@
Parsing metric events '{cpu_atom/MEM_UOPS_RETIRED.ALL_LOADS,metric-id=cpu_atom!3MEM_UOPS_RETIRED.ALL_LOADS!3/,cpu_atom/INST_RETIRED.ANY,metric-id=cpu_atom!3INST_RETIRED.ANY!3/}:W'
Matched metric-id cpu_atom@MEM_UOPS_RETIRED.ALL_LOADS@ to cpu_atom/MEM_UOPS_RETIRED.ALL_LOADS/
Matched metric-id cpu_atom@INST_RETIRED.ANY@ to cpu_atom/INST_RETIRED.ANY/
Result nan
Found metric 'tma_info_mem_mix_ipstore'
metric expr cpu_atom@INST_RETIRED.ANY@ / cpu_atom@MEM_UOPS_RETIRED.ALL_STORES@ for tma_info_mem_mix_ipstore
found event cpu_atom@MEM_UOPS_RETIRED.ALL_STORES@
found event cpu_atom@INST_RETIRED.ANY@
Parsing metric events '{cpu_atom/MEM_UOPS_RETIRED.ALL_STORES,metric-id=cpu_atom!3MEM_UOPS_RETIRED.ALL_STORES!3/,cpu_atom/INST_RETIRED.ANY,metric-id=cpu_atom!3INST_RETIRED.ANY!3/}:W'
Matched metric-id cpu_atom@MEM_UOPS_RETIRED.ALL_STORES@ to cpu_atom/MEM_UOPS_RETIRED.ALL_STORES/
Matched metric-id cpu_atom@INST_RETIRED.ANY@ to cpu_atom/INST_RETIRED.ANY/
Result nan
Found metric 'tma_info_mem_mix_load_locks_ratio'
metric expr 100 * cpu_atom@MEM_UOPS_RETIRED.LOCK_LOADS@ / cpu_atom@MEM_UOPS_RETIRED.ALL_LOADS@ for tma_info_mem_mix_load_locks_ratio
found event cpu_atom@MEM_UOPS_RETIRED.ALL_LOADS@
found event cpu_atom@MEM_UOPS_RETIRED.LOCK_LOADS@
Parsing metric events '{cpu_atom/MEM_UOPS_RETIRED.ALL_LOADS,metric-id=cpu_atom!3MEM_UOPS_RETIRED.ALL_LOADS!3/,cpu_atom/MEM_UOPS_RETIRED.LOCK_LOADS,metric-id=cpu_atom!3MEM_UOPS_RETIRED.LOCK_LOADS!3/}:W'
Matched metric-id cpu_atom@MEM_UOPS_RETIRED.ALL_LOADS@ to cpu_atom/MEM_UOPS_RETIRED.ALL_LOADS/
Matched metric-id cpu_atom@MEM_UOPS_RETIRED.LOCK_LOADS@ to cpu_atom/MEM_UOPS_RETIRED.LOCK_LOADS/
Result nan
Found metric 'tma_info_mem_mix_load_splits_ratio'
metric expr 100 * cpu_atom@MEM_UOPS_RETIRED.SPLIT_LOADS@ / cpu_atom@MEM_UOPS_RETIRED.ALL_LOADS@ for tma_info_mem_mix_load_splits_ratio
found event cpu_atom@MEM_UOPS_RETIRED.ALL_LOADS@
found event cpu_atom@MEM_UOPS_RETIRED.SPLIT_LOADS@
Parsing metric events '{cpu_atom/MEM_UOPS_RETIRED.ALL_LOADS,metric-id=cpu_atom!3MEM_UOPS_RETIRED.ALL_LOADS!3/,cpu_atom/MEM_UOPS_RETIRED.SPLIT_LOADS,metric-id=cpu_atom!3MEM_UOPS_RETIRED.SPLIT_LOADS!3/}:W'
Matched metric-id cpu_atom@MEM_UOPS_RETIRED.ALL_LOADS@ to cpu_atom/MEM_UOPS_RETIRED.ALL_LOADS/
Matched metric-id cpu_atom@MEM_UOPS_RETIRED.SPLIT_LOADS@ to cpu_atom/MEM_UOPS_RETIRED.SPLIT_LOADS/
Result nan
Found metric 'tma_info_mem_mix_memload_ratio'
metric expr 1e3 * cpu_atom@MEM_UOPS_RETIRED.ALL_LOADS@ / cpu_atom@UOPS_RETIRED.ALL@ for tma_info_mem_mix_memload_ratio
found event cpu_atom@UOPS_RETIRED.ALL@
found event cpu_atom@MEM_UOPS_RETIRED.ALL_LOADS@
Parsing metric events '{cpu_atom/UOPS_RETIRED.ALL,metric-id=cpu_atom!3UOPS_RETIRED.ALL!3/,cpu_atom/MEM_UOPS_RETIRED.ALL_LOADS,metric-id=cpu_atom!3MEM_UOPS_RETIRED.ALL_LOADS!3/}:W'
Matched metric-id cpu_atom@UOPS_RETIRED.ALL@ to cpu_atom/UOPS_RETIRED.ALL/
Matched metric-id cpu_atom@MEM_UOPS_RETIRED.ALL_LOADS@ to cpu_atom/MEM_UOPS_RETIRED.ALL_LOADS/
Result nan
Found metric 'tma_info_serialization_%_tpause_cycles'
metric expr 100 * cpu_atom@SERIALIZATION.C01_MS_SCB@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@) for tma_info_serialization_%_tpause_cycles
found event cpu_atom@CPU_CLK_UNHALTED.CORE@
found event cpu_atom@SERIALIZATION.C01_MS_SCB@
Parsing metric events '{cpu_atom/CPU_CLK_UNHALTED.CORE,metric-id=cpu_atom!3CPU_CLK_UNHALTED.CORE!3/,cpu_atom/SERIALIZATION.C01_MS_SCB,metric-id=cpu_atom!3SERIALIZATION.C01_MS_SCB!3/}:W'
Matched metric-id cpu_atom@CPU_CLK_UNHALTED.CORE@ to cpu_atom/CPU_CLK_UNHALTED.CORE/
Matched metric-id cpu_atom@SERIALIZATION.C01_MS_SCB@ to cpu_atom/SERIALIZATION.C01_MS_SCB/
Result nan
Found metric 'tma_info_system_cpu_utilization'
metric expr cpu_atom@CPU_CLK_UNHALTED.REF_TSC@ / msr@tsc\,cpu\=cpu_atom@ for tma_info_system_cpu_utilization
metric expr tma_info_system_cpus_utilized / #num_cpus_online for tma_info_system_cpu_utilization
metric expr cpu_core@CPU_CLK_UNHALTED.REF_TSC@ / msr@tsc\,cpu\=cpu_core@ for tma_info_system_cpus_utilized
found event msr@tsc,cpu=cpu_core@
found event cpu_core@CPU_CLK_UNHALTED.REF_TSC@
Parsing metric events '{msr/tsc,cpu=cpu_core,metric-id=msr!3tsc!0cpu!2cpu_core!3/,cpu_core/CPU_CLK_UNHALTED.REF_TSC,metric-id=cpu_core!3CPU_CLK_UNHALTED.REF_TSC!3/}:W'
event syntax error: '{msr/tsc,cpu=cpu_core,metric-id=msr!3tsc!0cpu!2cpu_core!..'
                      \___ Bad event or PMU

Unable to find PMU or event on a PMU of 'msr'

event syntax error: '{msr/tsc,cpu=cpu_core,metric-id=msr!3tsc!0cpu!2cpu_core!..'
                                  \___ not a valid PMU or CPU number

event syntax error: '{msr/tsc,cpu=cpu_core,metric-id=msr!3tsc!0cpu!2cpu_core!..'
                                  \___ not a valid PMU or CPU number

event syntax error: '{msr/tsc,cpu=cpu_core,metric-id=msr!3tsc!0cpu!2cpu_core!..'
                                  \___ not a valid PMU or CPU number

event syntax error: '{msr/tsc,cpu=cpu_core,metric-id=msr!3tsc!0cpu!2cpu_core!..'
                                  \___ not a valid PMU or CPU number
Broken metric tma_info_system_cpu_utilization
---- end(-1) ----
  9.3: Parsing of PMU event table metrics                            : FAILED!


--- start ---
test child forked, pid 7469
parsing '': '(unc_p_power_state_occupancy.cores_c0 / unc_p_clockticks) * 100.'
Using CPUID GenuineIntel-6-9E-9
unc_p_power_state_occupancy.cores_c0 -> fake/unc_p_power_state_occupancy.cores_c0/
unc_p_clockticks -> fake/unc_p_clockticks/
parsing '': 'imx8_ddr0@read\-cycles@ * 4 * 4'
parsing '': 'imx8_ddr0@axid\-read\,axi_mask\=0xffff\,axi_id\=0x0000@ * 4'
parsing '': '(cstate_pkg@c2\-residency@ / msr@tsc@) * 100'
parsing '': '(imx8_ddr0@read\-cycles@ + imx8_ddr0@write\-cycles@)'
parsing 'CPI': '1 / IPC'
IPC -> fake/IPC/
parsing 'DCache_L2_All': 'DCache_L2_All_Hits + DCache_L2_All_Miss'
DCache_L2_All_Miss -> fake/DCache_L2_All_Miss/
DCache_L2_All_Hits -> fake/DCache_L2_All_Hits/
parsing 'DCache_L2_All_Hits': 'l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hit + l2_rqsts.rfo_hit'
l2_rqsts.rfo_hit -> cpu/l2_rqsts.rfo_hit/
l2_rqsts.rfo_hit -> fake/l2_rqsts.rfo_hit/
l2_rqsts.demand_data_rd_hit -> cpu/l2_rqsts.demand_data_rd_hit/
l2_rqsts.demand_data_rd_hit -> fake/l2_rqsts.demand_data_rd_hit/
l2_rqsts.pf_hit -> cpu/l2_rqsts.pf_hit/
l2_rqsts.pf_hit -> fake/l2_rqsts.pf_hit/
parsing 'DCache_L2_All_Miss': 'max(l2_rqsts.all_demand_data_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss'
l2_rqsts.rfo_miss -> cpu/l2_rqsts.rfo_miss/
l2_rqsts.rfo_miss -> fake/l2_rqsts.rfo_miss/
l2_rqsts.pf_miss -> cpu/l2_rqsts.pf_miss/
l2_rqsts.pf_miss -> fake/l2_rqsts.pf_miss/
l2_rqsts.demand_data_rd_hit -> cpu/l2_rqsts.demand_data_rd_hit/
l2_rqsts.demand_data_rd_hit -> fake/l2_rqsts.demand_data_rd_hit/
l2_rqsts.all_demand_data_rd -> cpu/l2_rqsts.all_demand_data_rd/
l2_rqsts.all_demand_data_rd -> fake/l2_rqsts.all_demand_data_rd/
parsing 'DCache_L2_Hits': 'd_ratio(DCache_L2_All_Hits, DCache_L2_All)'
DCache_L2_All_Hits -> fake/DCache_L2_All_Hits/
DCache_L2_All -> fake/DCache_L2_All/
parsing 'DCache_L2_Misses': 'd_ratio(DCache_L2_All_Miss, DCache_L2_All)'
DCache_L2_All_Miss -> fake/DCache_L2_All_Miss/
DCache_L2_All -> fake/DCache_L2_All/
parsing 'Frontend_Bound_SMT': 'idq_uops_not_delivered.core / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active / cpu_clk_unhalted.ref_xclk)))'
cpu_clk_unhalted.one_thread_active -> cpu/cpu_clk_unhalted.one_thread_active/
cpu_clk_unhalted.one_thread_active -> fake/cpu_clk_unhalted.one_thread_active/
idq_uops_not_delivered.core -> cpu/idq_uops_not_delivered.core/
idq_uops_not_delivered.core -> fake/idq_uops_not_delivered.core/
cpu_clk_unhalted.ref_xclk -> cpu/cpu_clk_unhalted.ref_xclk/
cpu_clk_unhalted.ref_xclk -> fake/cpu_clk_unhalted.ref_xclk/
cpu_clk_unhalted.thread -> cpu/cpu_clk_unhalted.thread/
cpu_clk_unhalted.thread -> fake/cpu_clk_unhalted.thread/
parsing 'IPC': 'inst_retired.any / cpu_clk_unhalted.thread'
inst_retired.any -> cpu/inst_retired.any/
inst_retired.any -> fake/inst_retired.any/
cpu_clk_unhalted.thread -> cpu/cpu_clk_unhalted.thread/
cpu_clk_unhalted.thread -> fake/cpu_clk_unhalted.thread/
parsing 'L1D_Cache_Fill_BW': '64 * l1d.replacement / 1e9 / duration_time'
duration_time -> tool/duration_time/
duration_time -> fake/duration_time/
l1d.replacement -> cpu/l1d.replacement/
l1d.replacement -> fake/l1d.replacement/
parsing 'M1': 'ipc + M2'
M2 -> fake/M2/
ipc -> fake/ipc/
parsing 'M2': 'ipc + M1'
M1 -> fake/M1/
ipc -> fake/ipc/
parsing 'M3': '1 / M3'
M3 -> fake/M3/
parsing 'cache_miss_cycles': 'dcache_miss_cpi + icache_miss_cycles'
dcache_miss_cpi -> fake/dcache_miss_cpi/
icache_miss_cycles -> fake/icache_miss_cycles/
parsing 'dcache_miss_cpi': 'l1d\-loads\-misses / inst_retired.any'
inst_retired.any -> cpu/inst_retired.any/
inst_retired.any -> fake/inst_retired.any/
parsing 'icache_miss_cycles': 'l1i\-loads\-misses / inst_retired.any'
inst_retired.any -> cpu/inst_retired.any/
inst_retired.any -> fake/inst_retired.any/
parsing 'tma_allocation_restriction': 'tma_core_bound'
tma_core_bound -> fake/tma_core_bound/
parsing 'tma_backend_bound': 'cpu_atom@TOPDOWN_BE_BOUND.ALL@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@)'
parsing 'tma_bad_speculation': '(5 * cpu_atom@CPU_CLK_UNHALTED.CORE@ - (cpu_atom@TOPDOWN_FE_BOUND.ALL@ + cpu_atom@TOPDOWN_BE_BOUND.ALL@ + cpu_atom@TOPDOWN_RETIRING.ALL@)) / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@)'
parsing 'tma_branch_detect': 'cpu_atom@TOPDOWN_FE_BOUND.BRANCH_DETECT@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@)'
parsing 'tma_branch_mispredicts': 'cpu_atom@TOPDOWN_BAD_SPECULATION.MISPREDICT@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@)'
parsing 'tma_branch_resteer': 'cpu_atom@TOPDOWN_FE_BOUND.BRANCH_RESTEER@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@)'
parsing 'tma_cisc': 'cpu_atom@TOPDOWN_FE_BOUND.CISC@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@)'
parsing 'tma_core_bound': 'cpu_atom@TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@)'
parsing 'tma_decode': 'cpu_atom@TOPDOWN_FE_BOUND.DECODE@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@)'
parsing 'tma_fast_nuke': 'cpu_atom@TOPDOWN_BAD_SPECULATION.FASTNUKE@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@)'
parsing 'tma_frontend_bound': 'cpu_atom@TOPDOWN_FE_BOUND.ALL@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@)'
parsing 'tma_icache_misses': 'cpu_atom@TOPDOWN_FE_BOUND.ICACHE@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@)'
parsing 'tma_ifetch_bandwidth': 'cpu_atom@TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@)'
parsing 'tma_ifetch_latency': 'cpu_atom@TOPDOWN_FE_BOUND.FRONTEND_LATENCY@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@)'
parsing 'tma_info_bottleneck_%_dtlb_miss_bound_cycles': '100 * (cpu_atom@LD_HEAD.DTLB_MISS_AT_RET@ + cpu_atom@LD_HEAD.PGWALK_AT_RET@) / cpu_atom@CPU_CLK_UNHALTED.CORE@'
parsing 'tma_info_bottleneck_%_ifetch_miss_bound_cycles': '100 * cpu_atom@MEM_BOUND_STALLS.IFETCH@ / cpu_atom@CPU_CLK_UNHALTED.CORE@'
parsing 'tma_info_bottleneck_%_load_miss_bound_cycles': '100 * cpu_atom@MEM_BOUND_STALLS.LOAD@ / cpu_atom@CPU_CLK_UNHALTED.CORE@'
parsing 'tma_info_bottleneck_%_mem_exec_bound_cycles': '100 * cpu_atom@LD_HEAD.ANY_AT_RET@ / cpu_atom@CPU_CLK_UNHALTED.CORE@'
parsing 'tma_info_br_inst_mix_ipbranch': 'cpu_atom@INST_RETIRED.ANY@ / cpu_atom@BR_INST_RETIRED.ALL_BRANCHES@'
parsing 'tma_info_br_inst_mix_ipcall': 'cpu_atom@INST_RETIRED.ANY@ / cpu_atom@BR_INST_RETIRED.CALL@'
parsing 'tma_info_br_inst_mix_ipfarbranch': 'cpu_atom@INST_RETIRED.ANY@ / cpu_atom@BR_INST_RETIRED.FAR_BRANCH@u'
parsing 'tma_info_br_inst_mix_ipmisp_cond_ntaken': 'cpu_atom@INST_RETIRED.ANY@ / (cpu_atom@BR_MISP_RETIRED.COND@ - cpu_atom@BR_MISP_RETIRED.COND_TAKEN@)'
parsing 'tma_info_br_inst_mix_ipmisp_cond_taken': 'cpu_atom@INST_RETIRED.ANY@ / cpu_atom@BR_MISP_RETIRED.COND_TAKEN@'
parsing 'tma_info_br_inst_mix_ipmisp_indirect': 'cpu_atom@INST_RETIRED.ANY@ / cpu_atom@BR_MISP_RETIRED.INDIRECT@'
parsing 'tma_info_br_inst_mix_ipmisp_ret': 'cpu_atom@INST_RETIRED.ANY@ / cpu_atom@BR_MISP_RETIRED.RETURN@'
parsing 'tma_info_br_inst_mix_ipmispredict': 'cpu_atom@INST_RETIRED.ANY@ / cpu_atom@BR_MISP_RETIRED.ALL_BRANCHES@'
parsing 'tma_info_br_mispredict_bound_branch_mispredict_ratio': 'cpu_atom@BR_MISP_RETIRED.ALL_BRANCHES@ / cpu_atom@BR_INST_RETIRED.ALL_BRANCHES@'
parsing 'tma_info_br_mispredict_bound_branch_mispredict_to_unknown_branch_ratio': 'cpu_atom@BR_MISP_RETIRED.ALL_BRANCHES@ / cpu_atom@BACLEARS.ANY@'
parsing 'tma_info_buffer_stalls_%_load_buffer_stall_cycles': '100 * cpu_atom@MEM_SCHEDULER_BLOCK.LD_BUF@ / cpu_atom@CPU_CLK_UNHALTED.CORE@'
parsing 'tma_info_buffer_stalls_%_mem_rsv_stall_cycles': '100 * cpu_atom@MEM_SCHEDULER_BLOCK.RSV@ / cpu_atom@CPU_CLK_UNHALTED.CORE@'
parsing 'tma_info_buffer_stalls_%_store_buffer_stall_cycles': '100 * cpu_atom@MEM_SCHEDULER_BLOCK.ST_BUF@ / cpu_atom@CPU_CLK_UNHALTED.CORE@'
parsing 'tma_info_core_cpi': 'cpu_atom@CPU_CLK_UNHALTED.CORE@ / cpu_atom@INST_RETIRED.ANY@'
parsing 'tma_info_core_ipc': 'cpu_atom@INST_RETIRED.ANY@ / cpu_atom@CPU_CLK_UNHALTED.CORE@'
parsing 'tma_info_core_upi': 'cpu_atom@UOPS_RETIRED.ALL@ / cpu_atom@INST_RETIRED.ANY@'
parsing 'tma_info_ifetch_miss_bound_%_ifetchmissbound_with_l2hit': '100 * cpu_atom@MEM_BOUND_STALLS.IFETCH_L2_HIT@ / cpu_atom@MEM_BOUND_STALLS.IFETCH@'
parsing 'tma_info_ifetch_miss_bound_%_ifetchmissbound_with_l2miss': '100 * (cpu_atom@MEM_BOUND_STALLS.IFETCH_LLC_HIT@ + cpu_atom@MEM_BOUND_STALLS.IFETCH_DRAM_HIT@) / cpu_atom@MEM_BOUND_STALLS.IFETCH@'
parsing 'tma_info_ifetch_miss_bound_%_ifetchmissbound_with_l3hit': '100 * cpu_atom@MEM_BOUND_STALLS.IFETCH_LLC_HIT@ / cpu_atom@MEM_BOUND_STALLS.IFETCH@'
parsing 'tma_info_ifetch_miss_bound_%_ifetchmissbound_with_l3miss': '100 * cpu_atom@MEM_BOUND_STALLS.IFETCH_DRAM_HIT@ / cpu_atom@MEM_BOUND_STALLS.IFETCH@'
parsing 'tma_info_load_miss_bound_%_loadmissbound_with_l2hit': '100 * cpu_atom@MEM_BOUND_STALLS.LOAD_L2_HIT@ / cpu_atom@MEM_BOUND_STALLS.LOAD@'
parsing 'tma_info_load_miss_bound_%_loadmissbound_with_l2miss': '100 * (cpu_atom@MEM_BOUND_STALLS.LOAD_LLC_HIT@ + cpu_atom@MEM_BOUND_STALLS.LOAD_DRAM_HIT@) / cpu_atom@MEM_BOUND_STALLS.LOAD@'
parsing 'tma_info_load_miss_bound_%_loadmissbound_with_l3hit': '100 * cpu_atom@MEM_BOUND_STALLS.LOAD_LLC_HIT@ / cpu_atom@MEM_BOUND_STALLS.LOAD@'
parsing 'tma_info_load_miss_bound_%_loadmissbound_with_l3miss': '100 * cpu_atom@MEM_BOUND_STALLS.LOAD_DRAM_HIT@ / cpu_atom@MEM_BOUND_STALLS.LOAD@'
parsing 'tma_info_load_store_bound_l1_bound': '100 * cpu_atom@LD_HEAD.L1_BOUND_AT_RET@ / cpu_atom@CPU_CLK_UNHALTED.CORE@'
parsing 'tma_info_load_store_bound_load_bound': '100 * (cpu_atom@LD_HEAD.L1_BOUND_AT_RET@ + cpu_atom@MEM_BOUND_STALLS.LOAD@) / cpu_atom@CPU_CLK_UNHALTED.CORE@'
parsing 'tma_info_load_store_bound_store_bound': '100 * (cpu_atom@MEM_SCHEDULER_BLOCK.ST_BUF@ / cpu_atom@MEM_SCHEDULER_BLOCK.ALL@) * tma_mem_scheduler'
tma_mem_scheduler -> fake/tma_mem_scheduler/
parsing 'tma_info_machine_clear_bound_machine_clears_disamb_pki': '1e3 * cpu_atom@MACHINE_CLEARS.DISAMBIGUATION@ / cpu_atom@INST_RETIRED.ANY@'
parsing 'tma_info_machine_clear_bound_machine_clears_fp_assist_pki': '1e3 * cpu_atom@MACHINE_CLEARS.FP_ASSIST@ / cpu_atom@INST_RETIRED.ANY@'
parsing 'tma_info_machine_clear_bound_machine_clears_monuke_pki': '1e3 * cpu_atom@MACHINE_CLEARS.MEMORY_ORDERING@ / cpu_atom@INST_RETIRED.ANY@'
parsing 'tma_info_machine_clear_bound_machine_clears_mrn_pki': '1e3 * cpu_atom@MACHINE_CLEARS.MRN_NUKE@ / cpu_atom@INST_RETIRED.ANY@'
parsing 'tma_info_machine_clear_bound_machine_clears_page_fault_pki': '1e3 * cpu_atom@MACHINE_CLEARS.PAGE_FAULT@ / cpu_atom@INST_RETIRED.ANY@'
parsing 'tma_info_machine_clear_bound_machine_clears_smc_pki': '1e3 * cpu_atom@MACHINE_CLEARS.SMC@ / cpu_atom@INST_RETIRED.ANY@'
parsing 'tma_info_mem_exec_blocks_%_loads_with_adressaliasing': '100 * cpu_atom@LD_BLOCKS.4K_ALIAS@ / cpu_atom@MEM_UOPS_RETIRED.ALL_LOADS@'
parsing 'tma_info_mem_exec_blocks_%_loads_with_storefwdblk': '100 * cpu_atom@LD_BLOCKS.DATA_UNKNOWN@ / cpu_atom@MEM_UOPS_RETIRED.ALL_LOADS@'
parsing 'tma_info_mem_exec_bound_%_loadhead_with_l1miss': '100 * cpu_atom@LD_HEAD.L1_MISS_AT_RET@ / cpu_atom@LD_HEAD.ANY_AT_RET@'
parsing 'tma_info_mem_exec_bound_%_loadhead_with_otherpipelineblks': '100 * cpu_atom@LD_HEAD.OTHER_AT_RET@ / cpu_atom@LD_HEAD.ANY_AT_RET@'
parsing 'tma_info_mem_exec_bound_%_loadhead_with_pagewalk': '100 * cpu_atom@LD_HEAD.PGWALK_AT_RET@ / cpu_atom@LD_HEAD.ANY_AT_RET@'
parsing 'tma_info_mem_exec_bound_%_loadhead_with_stlbhit': '100 * cpu_atom@LD_HEAD.DTLB_MISS_AT_RET@ / cpu_atom@LD_HEAD.ANY_AT_RET@'
parsing 'tma_info_mem_exec_bound_%_loadhead_with_storefwding': '100 * cpu_atom@LD_HEAD.ST_ADDR_AT_RET@ / cpu_atom@LD_HEAD.ANY_AT_RET@'
parsing 'tma_info_mem_mix_ipload': 'cpu_atom@INST_RETIRED.ANY@ / cpu_atom@MEM_UOPS_RETIRED.ALL_LOADS@'
parsing 'tma_info_mem_mix_ipstore': 'cpu_atom@INST_RETIRED.ANY@ / cpu_atom@MEM_UOPS_RETIRED.ALL_STORES@'
parsing 'tma_info_mem_mix_load_locks_ratio': '100 * cpu_atom@MEM_UOPS_RETIRED.LOCK_LOADS@ / cpu_atom@MEM_UOPS_RETIRED.ALL_LOADS@'
parsing 'tma_info_mem_mix_load_splits_ratio': '100 * cpu_atom@MEM_UOPS_RETIRED.SPLIT_LOADS@ / cpu_atom@MEM_UOPS_RETIRED.ALL_LOADS@'
parsing 'tma_info_mem_mix_memload_ratio': '1e3 * cpu_atom@MEM_UOPS_RETIRED.ALL_LOADS@ / cpu_atom@UOPS_RETIRED.ALL@'
parsing 'tma_info_serialization_%_tpause_cycles': '100 * cpu_atom@SERIALIZATION.C01_MS_SCB@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@)'
parsing 'tma_info_system_cpu_utilization': 'cpu_atom@CPU_CLK_UNHALTED.REF_TSC@ / msr@tsc\,cpu\=cpu_atom@'
check_parse_fake failed
---- end(-1) ----
  9.4: Parsing of PMU event table metrics with fake PMUs             : FAILED!



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250808/202508080756.8c64d87-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

