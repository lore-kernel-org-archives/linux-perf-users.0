Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A18B322C77;
	Fri, 27 Feb 2026 08:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772181793; cv=fail; b=MPLSWC9uISEo+FC6ZkvG8UXlXz7VJg9/HrXFH8prMoj+Z2ec96FIrecmVKuPCZZVgy1B5alsuBT7aSMv7jAkif1sFRvcEEKvXZjsR5AIsevUUXpn5+ZfPwRYuirQrdyDbUyQpaYJtCiZWnfx8QoWKJYWua8pGfVHp/EN4ZXzCsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772181793; c=relaxed/simple;
	bh=x7agPRHMvrum/XaEKyL3HKdxRGn1N1khWa+hj2M04aA=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=BmD5GcxjaAX2XoRkdp03GvwQwtngg7+fWwFA49ZkzVGxlGKWArkBnUGt+wQbbYmWVR+xmXsrXuspStwEZSAj8/+G1CpWYCOoTJ9aHXUmlD0PrJR+ZhCDkaw8HRBmb195IpfpQzumWjKP5NSQmLuWiaBcTsodsPodYcTJx11h1fM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H1fQAfyd; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H1fQAfyd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772181791; x=1803717791;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=x7agPRHMvrum/XaEKyL3HKdxRGn1N1khWa+hj2M04aA=;
  b=H1fQAfyd0neASl2RaUuzYwPPY0BAsA5q3p2JYxalA57o0a+t9KSGPpn0
   8e/HryLJSmI9R4lf12+hoMjJZsV0hLk0IHB/xcAKQDSxVDd/mp1H7ab9I
   Ty8ny5/Z/oCYcyxoc0WHvhlEZNZfbGyUdz1vaWiQrnddOh9BWhCov46t5
   nJdl18CXKze5VqnMBJoKAlPqsw3+CZ99LPIIRRRBhiIRNu1XDUf9fXUis
   nmt6nME0lLtv3Opucr8XZi7xGH3+K+/6rhgyyPzv7cWoA7RzCh9czJpK5
   O+GGCF3Jgu0W1wxgJ4jgTeQ6mkZ/yQgLg4s8Ue88E5mRiNnIz6ovRjSzX
   A==;
X-CSE-ConnectionGUID: stl0cGS3QwCB6GXQYWUHpQ==
X-CSE-MsgGUID: hkW/ZTAKSKSJ8/RafC7Orw==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="72963876"
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="72963876"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 00:43:10 -0800
X-CSE-ConnectionGUID: APkohNjTTxawEiXasWG/IQ==
X-CSE-MsgGUID: bsCFIgJjThqcNodOsMGWrw==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 00:43:10 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Feb 2026 00:43:09 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Feb 2026 00:43:09 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.54) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Feb 2026 00:43:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jnFCUhzIz0Vv2JLVGINXFTVXIzei5+4OUrmeq542Mt/MfEgaRBtJ9nr5I1naVFKA52MNhJEKHOyZyjaq6Wi2BMf06E93rDZSuoT6940SfnVjuy8j1SchJ68dPnfSuLUiNADtIF2PZsw1I0e6QggXTLQEmoSrtUj3mP/WsF9dgqRpBbh9I80JixrUkEEpxjNu/AY+I89MpaH4GO0Wgmuw6k/QmmbPdSXzVdNFb8UDHyxQs6ACrLipeYzIlGvF+sAfO7YpV14wEBEi91uIkw1u3O8ni+x+Qvv3fkuIIp7jLcyOWxNbfFJHUZQ5hLYgL+xvEOtIdrdnJ7q1546ACcuxOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+DOiIhfgRVlAWBxJyyxvtwo+bU6Kr38HT8dN/SXUDo=;
 b=SgH7YwFgv2t5ylLxscLYQOg09naVCYn62Cf3QXiUnnM2gIWvaUhgfLdfB5lCoeyyHnuiNctZxIinFQ6engH6X2s5Fqxz0SYl98n87XYVWbX5BQEsI37i8dSPHDZo9j3/s1UKpa+f/1DbUIKlBzqhIagDuyRyHaEsRdfTuNP2d6zcX/ilLfnVwcpl4i6pvLy+rALMj/mKXeeixVNzPn0GfBFaGoWtJvuTRl/Dgezu17u5VuMAxPRERVyz0PQr7ryMeVTFGDXrMUmPJi4XINNUhePqV1DMSN3Yv3hWBD9PzP48Psn6iD0kEr3Maq462zKKrCsA1wJHFAoSurk5PF2Z1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by BN9PR11MB5260.namprd11.prod.outlook.com (2603:10b6:408:135::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 08:43:06 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::e4de:b1d:5557:7257]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::e4de:b1d:5557:7257%5]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 08:43:06 +0000
Date: Fri, 27 Feb 2026 16:42:59 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Namhyung Kim <namhyung@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Pablo Galindo <pablogsal@gmail.com>, <linux-perf-users@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [perf test]  c9cd0c7e52:
 perf-sanity-tests.python_profiling_with_jitdump.fail
Message-ID: <202602270932.50ed0a9f-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: TP0P295CA0014.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::11) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|BN9PR11MB5260:EE_
X-MS-Office365-Filtering-Correlation-Id: 28143f4d-cd87-42b9-39f0-08de75dc3a07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: pH+/nAoonypKROhqsXjKXBm1tWV3KccNa84057sHMaDDcG5vZLJroZyn7FOV6qt28QSEHblbwC7igHv9Z4jQO0TAQOdS8dobnfN6iiQ8aHsEx5flbwr80nIvToYG3cnqR+7hlvFX1iFX9Mm8qkxpWCKPmD2mjn6TawGWfUhayF2wMCunrTjE6AE+OGWvYujEMG7/n/ZA+lCyNg4PnohWh1TM/C4Fy22Ol2WYof/1+AjWqCbA8eerWCOxY3idRFoREt3eBHPbNXohcJH8EGZe8xfGyrelA0PuviQIOcBtOqGZmRHsjn8wM167SYUWENrXHaUhlEgomODqzPIcN6j01SMPpWBSQE3NYCEVYNlHy5n1mPrLIP9Q/ZCmxGt75JpfPI9njqst23LH+TdzSAKlsxtmT9NxvIfHflKpswgglST0k0LNL+7g/Kqxh6qKxnr3ptztCsSiNtFUfaHZ5EhX81AQ/T+VoPAwCfXImgIT41zE1f5ZWup3oTaCRIYRXA9ShPlmfG4I9z+STZwbD8M982Q9oWe8OHO/Q/htNAGgPFcSW/NZqBqcYM6mjjij/uALy5x81qwglOFhx8zdP+BkVLbCo4krV0Q3o5lbcgAYlBo/IiW+IM9Je9olgKXHzQrG60wTTHF0LE+rM7zyQbGSI4UUShkWCWjDQjwR2w6W7H6rlnL+CnWMphJcr/nciQ8A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oB0f7/DfqMEi6yD49aPFlurPTN/1ZhftyrZajK8R6YPQ3buNZ6ya80DqJJD0?=
 =?us-ascii?Q?qIdTUMiyHsrXC+NeAu3f/2lg8YA3dWtMlyt3wt95wSrtYOlkisdBBgkORlva?=
 =?us-ascii?Q?4K829eLSU8RyCOdYKXmRcbde4TIp25MuLVPzor5HlhWWQB/q4hPPM1CmhV2h?=
 =?us-ascii?Q?JPljdRJeNWYS0MIYWTYjuc/g6PLKAJUlltTvHThh8vBOj1i3wvCDXMDvBvr1?=
 =?us-ascii?Q?wXGAcHGA1EyA7Fyr0WZrW8r0MnSfh2WdqqxwlX3I41SmPqQElI9Dj1h390T8?=
 =?us-ascii?Q?1BUKEv640YQZtcINnVFDja3EJYSCUniDKeq5/MxV7Vow0cBXDeUDguVRZDYv?=
 =?us-ascii?Q?Z93gquAT4QbiY/ijEnMWtpjRVZXm4yrmy/bbds7XzITZIohj7SIVAM3LrEFh?=
 =?us-ascii?Q?4zekLqRdXjxUw4C9TdCfOXPa8G8WDoV+ULPVHUUFpiugnWFROWzNCIHyL0kd?=
 =?us-ascii?Q?cTW2gqYcdw4tKm7dBsXKNR7dQHyFD1reGVHWjjiJf7chojf7rkS9pPbUvMmN?=
 =?us-ascii?Q?/iLRde0oFW5cDsHXsmFVncMK/Izzdy2Z/nSoPOPRLpPxme1SRZNP+tKaSW+r?=
 =?us-ascii?Q?yP9H4kiV52/lngButuy7EC7DZ3O5rtmX9ZbAmZgG48GYLYP045ALwA9BxlhM?=
 =?us-ascii?Q?lr8cRLsqEWeMitaIzIsI2u8doxZW1kOFWZNPEFE3m8KtJj8L617JtuWSPHrK?=
 =?us-ascii?Q?/iKK0Mcw4Kwqtrv/ctkAPUJikV2U19wDBeTGhq7c6XnNiua2Vue/u2FSSJwO?=
 =?us-ascii?Q?y7I9HgBqxIvh904+r/ECmzC6Enc3h9n5vGx4+3efPVm+Zh6VS8icU/h/e+qd?=
 =?us-ascii?Q?LuSZU1tgHH02QujKgX+6DEkP5VYymo/dgjPepH4H2uOqW3bhA9E2UMIMNq1y?=
 =?us-ascii?Q?Ck+SSuEx7MnTb54jfnVtd8jf/BxP4FTWzsetg+5IFxMZHweK1zGzytqscMpw?=
 =?us-ascii?Q?bH1mpY7Xm8t2xQEvVcTqMJ4YqedABTndQ3ZgFFvUCacGsXIzPB51N8L+RU2v?=
 =?us-ascii?Q?DSG4YLusU55BbY9jgnWv5dcX7/WqJjVLeMtVnCQK7ngn4Dqli5WHn8hXTtrj?=
 =?us-ascii?Q?7VlMRq8jNj4ARsR6ZJB3MwIrpAF3I2zYCLPhuM3gIx0CvFce5lrXUiD4eBYk?=
 =?us-ascii?Q?jQWK+IM5y97LJCtuzq5P590tn0fLoBKVN/DWwHsaNGZT9iWdRGIxt/RcUSe3?=
 =?us-ascii?Q?OBQYCpkJSOQv0C9k5B5gZFwehGEsm1ZZAFOZyDBflub12om310pvom2gW5bO?=
 =?us-ascii?Q?2YxVA7rrOutiillBLNb3qKeWZa13aT242QnWTzGNrUoHPa5siUiVGcriF7pL?=
 =?us-ascii?Q?W2fzfnZVdw/cc+3YXb1SELl0OkOYQhYl0P9RAgCvvVOLNQJZ29J4rSEy6OEB?=
 =?us-ascii?Q?6Jp40EDKJXgXwMGGbNot2EHmNylCOXtvvwOcGrnslxJgu3YT55SVuQe56V7o?=
 =?us-ascii?Q?xJcGZ6wwVfiiFLoOT39yKPzP6IvQiUUUJZacILf5GM51JIIGGchhyjq/S53t?=
 =?us-ascii?Q?GpRhUkHDoi4qC1oKerHefBLUDOfjsTs8mscxH0F+RR3eHr2NWfLm4raa4iHi?=
 =?us-ascii?Q?KkJy0tSWGaBL4Lw8+iHe+mlCi6QMuK+1xymZF8BNx1cG/iZ/zY6N0hD+xGaZ?=
 =?us-ascii?Q?K40NRm+6SVy5ypjJ70unX4iOiLCcUaLz5Yk+Zyk2RKIDGsG13dxuB/DAT5LA?=
 =?us-ascii?Q?mV7DTRu2nDs6XtxJnbYzyqLgOKG5BtKNDs7m4WFownr6l3a2ulUng0+4iPnr?=
 =?us-ascii?Q?SeTime8RXA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 28143f4d-cd87-42b9-39f0-08de75dc3a07
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 08:43:06.0995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Q8noP+u5iKZIibnId3fJD+3CDhdYWDyf0qbPXi6v5/O9lS5/WZtFWMneD2zOAPHq0ey32fPRN22YhoHP2GPww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5260
X-OriginatorOrg: intel.com



Hello,


we failed to run this new added test. not sure if we miss any dependencies?


below is full report FYI.


kernel test robot noticed "perf-sanity-tests.python_profiling_with_jitdump.fail" on:

commit: c9cd0c7e529e80e9be79867d2ebb874f67dbc35e ("perf test: Add python JIT dump test")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

in testcase: perf-sanity-tests
version: 
with following parameters:

	perf_compiler: clang
	group: group-02


config: x86_64-rhel-9.4-bpf
compiler: gcc-14
test machine: 16 threads Intel(R) Core(TM) i7-13620H (Raptor Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202602270932.50ed0a9f-lkp@intel.com


2026-01-26 15:25:04 sudo ASAN_OPTIONS=fast_unwind_on_malloc=0 /usr/src/linux-perf-x86_64-rhel-9.4-bpf-c9cd0c7e529e80e9be79867d2ebb874f67dbc35e/tools/perf/perf test 84 -v
 84: python profiling with jitdump                                   : Running (1 active)
--- start ---
test child forked, pid 12390
Run python with -Xperf_jit
[ perf record: Woken up 5 times to write data ]
=================================================================
==12400==ERROR: AddressSanitizer: heap-use-after-free on address 0x50200002ba30 at pc 0x55c306993987 bp 0x7ffd98998720 sp 0x7ffd98998718
READ of size 8 at 0x50200002ba30 thread T0
    #0 0x55c306993986 in map__start util/map.h:54
    #1 0x55c306993cd0 in map__dso_map_ip util/map.h:110
    #2 0x55c3069b1ecb in unwind_entry util/machine.c:2950
    #3 0x55c306e4197b in unwind__get_entries util/unwind-libdw.c:321
    #4 0x55c3069b2398 in thread__resolve_callchain_unwind util/machine.c:2976
    #5 0x55c3069b24ec in __thread__resolve_callchain util/machine.c:3003
    #6 0x55c306987e78 in sample__for_each_callchain_node util/callchain.c:1808
    #7 0x55c3067d4ece in build_id__mark_dso_hit util/build-id.c:77
    #8 0x55c3062f7004 in process_sample_event /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-c9cd0c7e529e80e9be79867d2ebb874f67dbc35e/tools/perf/builtin-record.c:1504
    #9 0x55c3069dbec3 in evlist__deliver_sample util/session.c:1259
    #10 0x55c3069dc425 in machines__deliver_event util/session.c:1299
    #11 0x55c3069de009 in perf_session__deliver_event util/session.c:1386
    #12 0x55c3069cb296 in ordered_events__deliver_event util/session.c:134
    #13 0x55c306a06aac in do_flush util/ordered-events.c:245
    #14 0x55c306a07951 in __ordered_events__flush util/ordered-events.c:324
    #15 0x55c306a07e62 in ordered_events__flush util/ordered-events.c:342
    #16 0x55c3069d6863 in perf_event__process_finished_round util/session.c:786
    #17 0x55c3069deb7e in perf_session__process_user_event util/session.c:1446
    #18 0x55c3069e190e in perf_session__process_event util/session.c:1668
    #19 0x55c3069e9198 in process_simple util/session.c:2259
    #20 0x55c3069e8158 in reader__read_event util/session.c:2188
    #21 0x55c3069e8afe in reader__process_events util/session.c:2237
    #22 0x55c3069e9987 in __perf_session__process_events util/session.c:2282
    #23 0x55c3069eca43 in perf_session__process_events util/session.c:2446
    #24 0x55c3062f7328 in process_buildids /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-c9cd0c7e529e80e9be79867d2ebb874f67dbc35e/tools/perf/builtin-record.c:1534
    #25 0x55c3062fbdf0 in record__finish_output /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-c9cd0c7e529e80e9be79867d2ebb874f67dbc35e/tools/perf/builtin-record.c:1858
    #26 0x55c306309ebf in __cmd_record /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-c9cd0c7e529e80e9be79867d2ebb874f67dbc35e/tools/perf/builtin-record.c:2930
    #27 0x55c306317a8f in cmd_record /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-c9cd0c7e529e80e9be79867d2ebb874f67dbc35e/tools/perf/builtin-record.c:4417
    #28 0x55c30652bf7b in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-c9cd0c7e529e80e9be79867d2ebb874f67dbc35e/tools/perf/perf.c:349
    #29 0x55c30652c86c in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-c9cd0c7e529e80e9be79867d2ebb874f67dbc35e/tools/perf/perf.c:401
    #30 0x55c30652cdc2 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-c9cd0c7e529e80e9be79867d2ebb874f67dbc35e/tools/perf/perf.c:445
    #31 0x55c30652d569 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-c9cd0c7e529e80e9be79867d2ebb874f67dbc35e/tools/perf/perf.c:553
    #32 0x7f026b873ca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #33 0x7f026b873d64 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x29d64) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #34 0x55c306293210 in _start (/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-c9cd0c7e529e80e9be79867d2ebb874f67dbc35e/tools/perf/perf+0x1023210) (BuildId: 47c1eede4a6cf8e0c379d2104e8b035638daa1b4)

0x50200002ba30 is located 0 bytes inside of 8-byte region [0x50200002ba30,0x50200002ba38)
freed by thread T0 here:
    #0 0x7f0275b3d8f8 in free ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:52
    #1 0x55c3069ba258 in map__put util/map.c:312
    #2 0x55c30679b7f8 in __map__zput util/map.h:198
    #3 0x55c30679c0df in addr_location__exit util/addr_location.c:31
    #4 0x55c306e3f7fe in entry util/unwind-libdw.c:147
    #5 0x55c306e40b1b in frame_callback util/unwind-libdw.c:259
    #6 0x7f02758daae2 in dwfl_thread_getframes (/lib/x86_64-linux-gnu/libdw.so.1+0x78ae2) (BuildId: bafe9cb5bbbe6cee778d0d137730ea5c223d553e)
    #7 0x7f02758dae53 in dwfl_getthread_frames (/lib/x86_64-linux-gnu/libdw.so.1+0x78e53) (BuildId: bafe9cb5bbbe6cee778d0d137730ea5c223d553e)
    #8 0x55c306e414af in unwind__get_entries util/unwind-libdw.c:307
    #9 0x55c3069b2398 in thread__resolve_callchain_unwind util/machine.c:2976
    #10 0x55c3069b24ec in __thread__resolve_callchain util/machine.c:3003
    #11 0x55c306987e78 in sample__for_each_callchain_node util/callchain.c:1808
    #12 0x55c3067d4ece in build_id__mark_dso_hit util/build-id.c:77
    #13 0x55c3062f7004 in process_sample_event /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-c9cd0c7e529e80e9be79867d2ebb874f67dbc35e/tools/perf/builtin-record.c:1504
    #14 0x55c3069dbec3 in evlist__deliver_sample util/session.c:1259
    #15 0x55c3069dc425 in machines__deliver_event util/session.c:1299
    #16 0x55c3069de009 in perf_session__deliver_event util/session.c:1386
    #17 0x55c3069cb296 in ordered_events__deliver_event util/session.c:134
    #18 0x55c306a06aac in do_flush util/ordered-events.c:245
    #19 0x55c306a07951 in __ordered_events__flush util/ordered-events.c:324
    #20 0x55c306a07e62 in ordered_events__flush util/ordered-events.c:342
    #21 0x55c3069d6863 in perf_event__process_finished_round util/session.c:786
    #22 0x55c3069deb7e in perf_session__process_user_event util/session.c:1446
    #23 0x55c3069e190e in perf_session__process_event util/session.c:1668
    #24 0x55c3069e9198 in process_simple util/session.c:2259
    #25 0x55c3069e8158 in reader__read_event util/session.c:2188
    #26 0x55c3069e8afe in reader__process_events util/session.c:2237
    #27 0x55c3069e9987 in __perf_session__process_events util/session.c:2282

previously allocated by thread T0 here:
    #0 0x7f0275b3ec57 in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x55c3069bd747 in map__get util/map.h:188
    #2 0x55c3069c72c4 in maps__find util/maps.c:1112
    #3 0x55c30683b979 in thread__find_map util/event.c:687
    #4 0x55c30683be37 in thread__find_symbol util/event.c:723
    #5 0x55c306e3e7c3 in __report_module util/unwind-libdw.c:54
    #6 0x55c306e3f428 in entry util/unwind-libdw.c:133
    #7 0x55c306e40b1b in frame_callback util/unwind-libdw.c:259
    #8 0x7f02758daae2 in dwfl_thread_getframes (/lib/x86_64-linux-gnu/libdw.so.1+0x78ae2) (BuildId: bafe9cb5bbbe6cee778d0d137730ea5c223d553e)
    #9 0x7f02758dae53 in dwfl_getthread_frames (/lib/x86_64-linux-gnu/libdw.so.1+0x78e53) (BuildId: bafe9cb5bbbe6cee778d0d137730ea5c223d553e)
    #10 0x55c306e414af in unwind__get_entries util/unwind-libdw.c:307
    #11 0x55c3069b2398 in thread__resolve_callchain_unwind util/machine.c:2976
    #12 0x55c3069b24ec in __thread__resolve_callchain util/machine.c:3003
    #13 0x55c306987e78 in sample__for_each_callchain_node util/callchain.c:1808
    #14 0x55c3067d4ece in build_id__mark_dso_hit util/build-id.c:77
    #15 0x55c3062f7004 in process_sample_event /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-c9cd0c7e529e80e9be79867d2ebb874f67dbc35e/tools/perf/builtin-record.c:1504
    #16 0x55c3069dbec3 in evlist__deliver_sample util/session.c:1259
    #17 0x55c3069dc425 in machines__deliver_event util/session.c:1299
    #18 0x55c3069de009 in perf_session__deliver_event util/session.c:1386
    #19 0x55c3069cb296 in ordered_events__deliver_event util/session.c:134
    #20 0x55c306a06aac in do_flush util/ordered-events.c:245
    #21 0x55c306a07951 in __ordered_events__flush util/ordered-events.c:324
    #22 0x55c306a07e62 in ordered_events__flush util/ordered-events.c:342
    #23 0x55c3069d6863 in perf_event__process_finished_round util/session.c:786
    #24 0x55c3069deb7e in perf_session__process_user_event util/session.c:1446
    #25 0x55c3069e190e in perf_session__process_event util/session.c:1668
    #26 0x55c3069e9198 in process_simple util/session.c:2259
    #27 0x55c3069e8158 in reader__read_event util/session.c:2188

SUMMARY: AddressSanitizer: heap-use-after-free util/map.h:54 in map__start
Shadow bytes around the buggy address:
  0x50200002b780: fa fa fd fa fa fa fd fd fa fa 00 06 fa fa 00 fa
  0x50200002b800: fa fa 00 fa fa fa fd fa fa fa 00 fa fa fa 00 fa
  0x50200002b880: fa fa 00 fa fa fa fd fa fa fa fd fa fa fa fd fa
  0x50200002b900: fa fa fd fa fa fa fd fa fa fa fd fa fa fa fd fa
  0x50200002b980: fa fa fd fa fa fa fd fa fa fa fd fa fa fa fd fa
=>0x50200002ba00: fa fa fd fa fa fa[fd]fa fa fa fd fa fa fa fd fa
  0x50200002ba80: fa fa fd fa fa fa fd fa fa fa fd fa fa fa fd fa
  0x50200002bb00: fa fa fd fa fa fa fd fa fa fa fd fa fa fa fd fa
  0x50200002bb80: fa fa fd fa fa fa fd fa fa fa fd fa fa fa fd fa
  0x50200002bc00: fa fa fd fa fa fa fd fa fa fa fd fa fa fa fd fa
  0x50200002bc80: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07 
  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb
==12400==ABORTING
Error:
failed to process sample
Generate JIT-ed DSOs using perf inject
WARNING: The /tmp/__perf_test.perf.data.W1jHYt file's data size field is 0 which is unexpected.
Was the 'perf record' command properly terminated?
Add JIT-ed DSOs to the build-ID cache
Couldn't add /tmp/jitted--*.so: No such file or directory
Check the symbol containing the function/module name
zero-sized data (/tmp/__perf_test.perf.data.W1jHYt.jit), nothing to do!
Found 0 matching lines
Remove JIT-ed DSOs from the build-ID cache
Cleaning up files...
---- end(-1) ----
 84: python profiling with jitdump                                   : FAILED!



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260227/202602270932.50ed0a9f-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

