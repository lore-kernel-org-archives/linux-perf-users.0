Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF33284B50;
	Wed, 17 Sep 2025 06:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758090043; cv=fail; b=Il+DNcOG8JwFm+ZQl58sSoula7gRw26833L0PMZeq9BCxzGwZSiel3XWwD23c5Nmi+JaiPl5E4OWIwPI/JgSXC5L7xDiMkCk+Y1HoVl9misgmZ1htBoiSo8301SK4ZKMuzKyhaT9VCaoFt6kRMHtH16Sg4E7c1F7FUXkyPe0nhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758090043; c=relaxed/simple;
	bh=MbdWm833Pyv4eojzn+0r9d/f/daXM3o+C0AjyScbsN4=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jH5dWqGry+e78WipnrPcJHp7dSPwDlN3/6bVq0PgVc+1ATxJ6XLHCKY26MBsHK6Lpp+RUwONV2WC2s5PzzGj5WYsi7M6xsGZXoJlKsf6ucWCEnA5B81vLg+1kAV52rYKCExLQ1c1/VgCGuNg4fuY829bZjMkiKGcedK40jqvUwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DLTrUktu; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DLTrUktu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758090041; x=1789626041;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=MbdWm833Pyv4eojzn+0r9d/f/daXM3o+C0AjyScbsN4=;
  b=DLTrUktunZdOuOwC6/v9rZ4Kz8BlomBdQvC4OWq6tqWKS0nqCG6KIdYn
   vagntU1zlex21eMsJHPvJpdWCIA7NlvP8iuteaKHtQO5RW1kp3Btvec6B
   C8nCSHiqT2uL2eI94lQKy+FGGoAx5krJaXQCLKRH0wQvMc11kPruGFUX+
   CUMRFFonryfb0/EvuCskjxJ6iY4cAD4vfC8kTOuz6I78I7LqB6dql9dw/
   Yfr/EdFCmkst+tCCRG8YHLphoQPvmOHQZHjEnLAu2LniUyoXiEp/pFAoh
   IuDVHcharCDzrfdtKSp0uHAMLLaijqxIt8708ehHhpFAVNqVTuZ097zvm
   Q==;
X-CSE-ConnectionGUID: whL/J2lfTU6a7/iheOE+aA==
X-CSE-MsgGUID: WUFEKhEGQAysMYbKxneWXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="63019887"
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="63019887"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 23:20:40 -0700
X-CSE-ConnectionGUID: vd6vsyy5TnODvS2rteUF7A==
X-CSE-MsgGUID: skE/QXrUTNmGLWHlRhOtRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="206110283"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 23:20:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 16 Sep 2025 23:20:38 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 16 Sep 2025 23:20:38 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.40) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 16 Sep 2025 23:20:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ECelB1/ZnIA4sFq1u7q8vPivkj3oLivFWEtDAy66QOBtfWOtcRj4s/DPH9BkwnzmV3VGr8wx+JDTWo/5qg8mdKkR18COfW16TWSQuFKtXoJHRM5LpOetU62GzzLVo/hTqBW/e0hXPEbEnW1olTJSF8FLeqiEz5HTsMkbiFMq7o6uWpxPlEJ5KEJIGJinYV+N0kogrozUkquHytEXAq+JjGo9Brw9/AL6XQ8VgNbmPXIX+u1DTOxDzgsUtc6/mDOmYNKIo5VnlgRWWjBd7D/jGEpEm5yNVMvOk+0GAdI3Z6TgO4VJEK/5jm1bXfXmxCxeWsRfSo2brMttySymMIDl9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVmIm1T0+pxhqUXCf3S807AQI+cyRApo7oi0xc51NRA=;
 b=J2/CWnzxmkk2qeVgXxge7IQnclatTu8QdtduKpFFVWR9E4t+zZEGR0Ag7mfCn3MXAzsu8XXwgERA3r8vyYI2XsZ2udoWOhJDchmw6ohrrLEYD48GCs+IUmwETxqY9OX6Smid1QEy1KDGeXCERvZuT5/P9bxDgMR0FaBD/o0iBQLcXvHZdEYUecv4EYGg8Qkr4ivNrcU5pjvog+HfVolNfwn+TzHlNVgT3rFaLPS5slOl8FMrirdvfFI1WaMd+vq/l7k54m5EUVKcjsGl4qHW5lUEm8KC4BxKAwvNcw1kIxwrjwKb7442Go+HxDCishP3wrgBhYnGMLI7/84tSPXbzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB5326.namprd11.prod.outlook.com (2603:10b6:5:391::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 17 Sep
 2025 06:20:31 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 06:20:30 +0000
Date: Wed, 17 Sep 2025 14:20:10 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Swapnil Sapkal <swapnil.sapkal@amd.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <irogers@google.com>, <james.clark@arm.com>,
	<ravi.bangoria@amd.com>, <swapnil.sapkal@amd.com>, <yu.c.chen@intel.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <rostedt@goodmis.org>, <vincent.guittot@linaro.org>,
	<adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<gautham.shenoy@amd.com>, <kprateek.nayak@amd.com>, <juri.lelli@redhat.com>,
	<yangjihong@bytedance.com>, <void@manifault.com>, <tj@kernel.org>,
	<sshegde@linux.ibm.com>, <ctshao@google.com>, <quic_zhonhan@quicinc.com>,
	<thomas.falcon@intel.com>, <blakejones@google.com>, <ashelat@redhat.com>,
	<leo.yan@arm.com>, <dvyukov@google.com>, <ak@linux.intel.com>,
	<yujie.liu@intel.com>, <graham.woodward@arm.com>, <ben.gainey@arm.com>,
	<vineethr@linux.ibm.com>, <tim.c.chen@linux.intel.com>, <linux@treblig.org>,
	<santosh.shukla@amd.com>, <sandipan.das@amd.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH RESEND v4 03/11] perf header: Support CPU DOMAIN relation
 info
Message-ID: <202509171303.b892ad4b-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250909114227.58802-4-swapnil.sapkal@amd.com>
X-ClientProxiedBy: SI2PR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:4:197::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB5326:EE_
X-MS-Office365-Filtering-Correlation-Id: 88f51079-be86-4339-fa63-08ddf5b24d0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9Yb3ZixKKOh5vDErNE5JhXgGSl+crROTZBLswI8ZlImEeEqiqbXAXlOiPXji?=
 =?us-ascii?Q?drR2IUduiFkl4PO6jK719xeP6ZMnNQhdBjV0/uyXlZ+u2Tz6UcV27cjmJyvP?=
 =?us-ascii?Q?7JG4sP5SDeUz1kVQzpFYOuaLtphaRrxi8iYoxttvbEphqe2OhNkJC/N1v6E9?=
 =?us-ascii?Q?IpIkN8SIrddOnp3MEQEo/ADhDDrIO+CjYIfEJ8clxnyBi/Legqx8Lv9ED8X4?=
 =?us-ascii?Q?2hl1kGkinMYNRhNlDb+krtbw9DacS1V8PALA5DTzinqix3lgnHKzkvsO90vR?=
 =?us-ascii?Q?hWY4PI6Y0My1RPpIfsukC6DsFcdWkDuRR2GqDwyElPnSQ5gMjgQyO/dSMnt5?=
 =?us-ascii?Q?ro2Z9qMtSOv6CIMvAp6nR8BKw1izATf2xXxFb5+VxjmOX76YQZl1F+SBEWoD?=
 =?us-ascii?Q?mipp4jAa9pOSWqQIZ+e0kiiHgz3xk2U2RCjMjsTOLibbWqsgg13F7P7ClJzz?=
 =?us-ascii?Q?cn3jzbfbru5CZt7dvS8QOFBp4YbUZnIiXpjrcV06tLvmD1omQrxohg0DG7E2?=
 =?us-ascii?Q?MfW9Qk2VA5YbwGFIBACA5n6VDa1xRwM1hs/DFyRbu4BluFVm2Zb9kkdK7nlM?=
 =?us-ascii?Q?Ux6Wl7heu8dScDeF1TzlpNO3V183/oPiMOOLaVQ5s00Qaulbiy41jecfiN/q?=
 =?us-ascii?Q?HmueXvMEvTgZ/NJYIVMX5BaKVy5z4/R+ZY9JzNG3GaA7p61BSyqUFWr7WgUA?=
 =?us-ascii?Q?5f2WxFp7oGZHINbqFIXz633csbm2i/hbtdhCYSP+PWaeA9RsYK96DGYHhwiW?=
 =?us-ascii?Q?y1MkrMryS6+39VEQd6iPqrDjWtxk0Fc9wFX12ZqgPwrEqbYSvgeKx5g8e7dM?=
 =?us-ascii?Q?hQNu3dNxxYsOGyWMlLubBR1pwxTqS0ShPlaRknAuIRjGJpwLPD/xMW0Khy4c?=
 =?us-ascii?Q?guL3r2XgqGbZhmemoPNzxI8Pqcwdk6cZ7QyjOdh3k35RkKewvZ8S+9t5Xa5Z?=
 =?us-ascii?Q?VR+AJnh6qeMWYtkVlwmv5FMwHQ299A2yLCrxqcgSitl/OUxUd0fThyZXsfAZ?=
 =?us-ascii?Q?fAyPXUJXCALnlNByNBz+kEzGVGQ8pmMj+Mj1Gc0iTGotTRPTs9rB1tz0ZO4o?=
 =?us-ascii?Q?0AWxrXafkKV1NHtzMKesk9vxoWLMUf2pXGzPmIKTsB+a8WgQMyV0UCneRvKU?=
 =?us-ascii?Q?iP/mCtuV5LV6ct5aUVB+PoLDFMjFpmj9tPh2GZvB+m9FUfHu9yFIbSbyJxuH?=
 =?us-ascii?Q?NKqu7lkDge5feNKKg42NwbGHurLytYCSSJu9SGZb8x7oMtK2uyPtcmV7Dr8f?=
 =?us-ascii?Q?AmXzeKBfMFzdYTCeDSb/agGOey0Qtz8J1jizncX3firEVszGFt7Yt2uGJF1i?=
 =?us-ascii?Q?AbmtZ/IYl6UCAjIVhW9T4V504v1eNu1Hi4qrKUOfO6ypfAxa4vkIOEifFp8y?=
 =?us-ascii?Q?EEAlmJT4hTaIYFdozDc5pUOpHmT1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G5jtGth9UjQMQNxa5twkQWIr1KUY+YPr0vULG9Kg8S6NdwtlGomPMfdgTk87?=
 =?us-ascii?Q?TPEKh3axAAzP4dfNpnLerrImIBx57z94RN4YYXpy74zUoG+a7zvMoJ4kDUl4?=
 =?us-ascii?Q?YH55vn1AVde6STFn6oHzD5tBjWz5WaX0Ucy+nmfJdJaB6SqxMoAnx9pqZ/vZ?=
 =?us-ascii?Q?IttzVbhCpTBmITf1KCNuGc0JAmDjkxj51j9x+Jba3UKcLBtL1hOW8JxeGdap?=
 =?us-ascii?Q?E+/doFXkK+POC1iyFnjmTWDtZ4J7ceIoD1S6F13MEhkI8kvETTJ3D66NcAHq?=
 =?us-ascii?Q?1W45B7NYUVSnSv6bV3J7act/7xrvF5sVq632QQIktAwQYq3PIVDQH/zHTQuB?=
 =?us-ascii?Q?3+T9KMkjXjF3RKNUyQ0mDytmVGAB2DWlq3dZhPSXtP8JGmtjwqfYr0xBwmoj?=
 =?us-ascii?Q?KK4R3HW6qg0aKzY7ZIljU6WVuGGQjRi37I0L8nWUt4eoplaWyFqY1N0IYVxX?=
 =?us-ascii?Q?XaavtAoNPYGsTbvKSylilarYnj/sFZUuPWSDXYHZIYtkFR9k7TpVWQxER6o5?=
 =?us-ascii?Q?8NPj6jPF6pvi7kuE9hrm/KoTL7wHwoIJGFtYAsaxAsmRvIgSnaitn85l4jxL?=
 =?us-ascii?Q?AsW6Pd9ITTFNYZuCZ2i1+/lDTX4sqAh9QCO9stC04MPIlvXugFje7lI1mba1?=
 =?us-ascii?Q?eczRtRt8FsurOvcktP+ZxVe82cZv3LHhe9nGyvYRNhE0JKrlQ74YNZQh1NgR?=
 =?us-ascii?Q?QgMgQZMHH1BRyySo0JxyUl7ttu8quLEzz05XjJXbu31HQn+emMsXhkgjCcXe?=
 =?us-ascii?Q?ToZoMzHRH/mfWWNV6S0niKx01p+8yoM44gLCITesA1d2xS3f3h3AEWWLCoTF?=
 =?us-ascii?Q?CYUFcplCZfHLtSENH0p8w7A11KJUV6UIgWIaYzUrZdj/dYdSlITOMcZl6gRz?=
 =?us-ascii?Q?SHMTpC/Ks5mnEZbNVzWCw8i6SxQFyU+RU1WD4GxfNAQYqaki7bcheVz6LiS/?=
 =?us-ascii?Q?XE9LTyFSXUOZ3GdfCNblA5Si4rgResrM5TgIf5zDv4g7LN8NWwVsQXgcLMnc?=
 =?us-ascii?Q?L6ghg37cx9pgACbEjbX1ys6OONBoSJ0myJZpYp41m9zWL4gFqGFFqGdyTeGw?=
 =?us-ascii?Q?nT/DMBz0ZsDTgFFCrKbcP/BPSguFn0iDbsOWF+Bkn6/RYlDOPY8gPtWAq+R9?=
 =?us-ascii?Q?PK5UzRJuoCJWXlDuD4EttQT1aNmUpNyCl6qF+HhbA321/nyDlIJYP0iUIswr?=
 =?us-ascii?Q?zd1XE78wVPucMbYp8uQH6lF51FGg1YAZqh+dV+WSS5o8Qm8JGfgyHe+Kyg3O?=
 =?us-ascii?Q?EO4+EI2A85iHdtD8jnLAF9nwGk5Bfq46oamShjbLtvoyoqpMQKx1uUraxoNl?=
 =?us-ascii?Q?xa4jnYN06Ao85M4Iwu/hfmNwzF4sDgrGrk9xreCFgR/1WeHwW+V4OVMC1VyD?=
 =?us-ascii?Q?td3yxM0YaLmFmugCTWjWkxa8bPZgxzHf0P3FU+er6kcwk74Sh+JZv+mSdR80?=
 =?us-ascii?Q?h4jTBVVO8DKil1RegQI6KspsNVPh/kkjjC+Y5RnrLCoNEZ503eLiQhF589Ib?=
 =?us-ascii?Q?jTq7cdUdtjM7WTLXUOcZRwDRpk3CcSlwqck+mqahiugzgZlB2iJdwozmaogQ?=
 =?us-ascii?Q?1P0IXoix3D7Ul5Cm6xUtpKSmqCCCnBoKs9Mobrdu5IgPauhCrhSj/Pu4CtJi?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f51079-be86-4339-fa63-08ddf5b24d0e
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 06:20:30.6384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kzdwKCTgo6modk95Q/Hy/ffXVx3a/M0xQWrgFAkvY7lWZSa51hnBMi5mKWwNCy3KllI5/UiHkcn3deJJCVxTnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5326
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "perf-sanity-tests.perf_pipe_recording_and_injection_test.fail" on:

commit: 01c79e2544b044e2c01ab435a28a03c3f0d63be3 ("[PATCH RESEND v4 03/11] perf header: Support CPU DOMAIN relation info")
url: https://github.com/intel-lab-lkp/linux/commits/Swapnil-Sapkal/perf-Add-print_separator-to-util/20250909-195256
base: https://git.kernel.org/cgit/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
patch link: https://lore.kernel.org/all/20250909114227.58802-4-swapnil.sapkal@amd.com/
patch subject: [PATCH RESEND v4 03/11] perf header: Support CPU DOMAIN relation info

in testcase: perf-sanity-tests
version: 
with following parameters:

	perf_compiler: gcc
	group: group-02



config: x86_64-rhel-9.4-bpf
compiler: gcc-14
test machine: 256 threads 2 sockets GENUINE INTEL(R) XEON(R) (Sierra Forest) with 128G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202509171303.b892ad4b-lkp@intel.com


we also observed failure of perf-sanity-tests.Zstd_perf.data_compression/decompression
which can pass on parent.

138d89b6ba9cd79a 01c79e2544b044e2c01ab435a28
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :6          100%           6:6     perf-sanity-tests.Zstd_perf.data_compression/decompression.fail
           :6          100%           6:6     perf-sanity-tests.perf_pipe_recording_and_injection_test.fail



2025-09-15 14:22:07 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/perf test 88 -v
 88: perf pipe recording and injection test                          : Running (1 active)
--- start ---
test child forked, pid 16787
 140175e-1401871 l noploop
perf does have symbol 'noploop'

Record+report pipe test
util/util.c:295:6: runtime error: index 64 out of bounds for type 'char [17]'
util/util.c:295:12: runtime error: store to address 0x7f4b418a1060 with insufficient space for an object of type 'char'
0x7f4b418a1060: note: pointer points here
 00 00 00 00  01 00 00 00 00 00 00 00  18 00 04 2e 00 00 00 00  9d 77 00 00 00 00 00 00  02 00 00 00
              ^ 
=================================================================
==16803==ERROR: AddressSanitizer: stack-buffer-overflow on address 0x7f4b418a1050 at pc 0x561dc13e9257 bp 0x7ffe75d35540 sp 0x7ffe75d35538
WRITE of size 1 at 0x7f4b418a1050 thread T0
    #0 0x561dc13e9256 in cpumask_to_cpulist util/util.c:295
    #1 0x561dc11fb37b in build_cpu_domain_map util/header.c:1727
    #2 0x561dc11fb91f in write_cpu_domain_info util/header.c:1753
    #3 0x561dc145a9ef in perf_event__synthesize_features util/synthetic-events.c:2419
    #4 0x561dc145b224 in perf_event__synthesize_for_pipe util/synthetic-events.c:2471
    #5 0x561dc0bc2085 in record__synthesize /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/builtin-record.c:2063
    #6 0x561dc0bc9ded in __cmd_record /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/builtin-record.c:2581
    #7 0x561dc0bda8cb in cmd_record /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/builtin-record.c:4376
    #8 0x561dc0de7aac in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/perf.c:349
    #9 0x561dc0de839d in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/perf.c:401
    #10 0x561dc0de88f3 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/perf.c:445
    #11 0x561dc0de909a in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/perf.c:553
    #12 0x7f4b4efc7ca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #13 0x7f4b4efc7d64 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x29d64) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #14 0x561dc0b58470 in _start (/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/perf+0xf9b470) (BuildId: 7c6fd1162dbb1e721de92bbfd9fc751e2178f1fa)

Address 0x7f4b418a1050 is located in stack of thread T0 at offset 80 in frame
    #0 0x561dc13e8c26 in cpumask_to_cpulist util/util.c:267

  This frame has 2 object(s):
    [32, 49) 'blk' (line 291)
    [96, 1120) 'cpus' (line 271) <== Memory access at offset 80 underflows this variable
HINT: this may be a false positive if your program uses some custom stack unwind mechanism, swapcontext or vfork
      (longjmp and C++ exceptions *are* supported)
SUMMARY: AddressSanitizer: stack-buffer-overflow util/util.c:295 in cpumask_to_cpulist
Shadow bytes around the buggy address:
  0x7f4b418a0d80: 00 00 00 00 00 00 00 00 00 00 00 00 f3 f3 f3 f3
  0x7f4b418a0e00: f3 f3 f3 f3 f3 f3 f3 f3 f3 f3 f3 f3 00 00 00 00
  0x7f4b418a0e80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7f4b418a0f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7f4b418a0f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
=>0x7f4b418a1000: f1 f1 f1 f1 00 00 01 f2 f2 f2[f2]f2 00 00 00 00
  0x7f4b418a1080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7f4b418a1100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7f4b418a1180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7f4b418a1200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7f4b418a1280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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
==16803==ABORTING
Record+report pipe test [Failed - cannot find the test file in the perf report #1]

Inject -B build-ids test
util/util.c:295:6: runtime error: index 64 out of bounds for type 'char [17]'
util/util.c:295:12: runtime error: store to address 0x7faa03ca1060 with insufficient space for an object of type 'char'
0x7faa03ca1060: note: pointer points here
 00 00 00 00  01 00 00 00 00 00 00 00  18 00 04 2e 00 00 00 00  9d 77 00 00 00 00 00 00  02 00 00 00
              ^ 
=================================================================
==16818==ERROR: AddressSanitizer: stack-buffer-overflow on address 0x7faa03ca1050 at pc 0x5613ca51a257 bp 0x7ffde4af7240 sp 0x7ffde4af7238
WRITE of size 1 at 0x7faa03ca1050 thread T0
    #0 0x5613ca51a256 in cpumask_to_cpulist util/util.c:295
    #1 0x5613ca32c37b in build_cpu_domain_map util/header.c:1727
    #2 0x5613ca32c91f in write_cpu_domain_info util/header.c:1753
    #3 0x5613ca58b9ef in perf_event__synthesize_features util/synthetic-events.c:2419
    #4 0x5613ca58c224 in perf_event__synthesize_for_pipe util/synthetic-events.c:2471
    #5 0x5613c9cf3085 in record__synthesize /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/builtin-record.c:2063
    #6 0x5613c9cfaded in __cmd_record /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/builtin-record.c:2581
    #7 0x5613c9d0b8cb in cmd_record /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/builtin-record.c:4376
    #8 0x5613c9f18aac in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/perf.c:349
    #9 0x5613c9f1939d in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/perf.c:401
    #10 0x5613c9f198f3 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/perf.c:445
    #11 0x5613c9f1a09a in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/perf.c:553
    #12 0x7faa11387ca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #13 0x7faa11387d64 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x29d64) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #14 0x5613c9c89470 in _start (/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/perf+0xf9b470) (BuildId: 7c6fd1162dbb1e721de92bbfd9fc751e2178f1fa)

Address 0x7faa03ca1050 is located in stack of thread T0 at offset 80 in frame
    #0 0x5613ca519c26 in cpumask_to_cpulist util/util.c:267

  This frame has 2 object(s):
    [32, 49) 'blk' (line 291)
    [96, 1120) 'cpus' (line 271) <== Memory access at offset 80 underflows this variable
HINT: this may be a false positive if your program uses some custom stack unwind mechanism, swapcontext or vfork
      (longjmp and C++ exceptions *are* supported)
SUMMARY: AddressSanitizer: stack-buffer-overflow util/util.c:295 in cpumask_to_cpulist
Shadow bytes around the buggy address:
  0x7faa03ca0d80: 00 00 00 00 00 00 00 00 00 00 00 00 f3 f3 f3 f3
  0x7faa03ca0e00: f3 f3 f3 f3 f3 f3 f3 f3 f3 f3 f3 f3 00 00 00 00
  0x7faa03ca0e80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7faa03ca0f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7faa03ca0f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
=>0x7faa03ca1000: f1 f1 f1 f1 00 00 01 f2 f2 f2[f2]f2 00 00 00 00
  0x7faa03ca1080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7faa03ca1100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7faa03ca1180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7faa03ca1200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7faa03ca1280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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
==16818==ABORTING
Error:
The - data has no samples!
Inject build-ids test [Failed - cannot find noploop function in pipe #1]

Inject -b build-ids test
util/util.c:295:6: runtime error: index 64 out of bounds for type 'char [17]'
util/util.c:295:12: runtime error: store to address 0x7fad986a1060 with insufficient space for an object of type 'char'
0x7fad986a1060: note: pointer points here
 00 00 00 00  01 00 00 00 00 00 00 00  18 00 04 2e 00 00 00 00  9d 77 00 00 00 00 00 00  02 00 00 00
              ^ 
=================================================================
==16835==ERROR: AddressSanitizer: stack-buffer-overflow on address 0x7fad986a1050 at pc 0x563c459e2257 bp 0x7ffe9db4ac80 sp 0x7ffe9db4ac78
WRITE of size 1 at 0x7fad986a1050 thread T0
    #0 0x563c459e2256 in cpumask_to_cpulist util/util.c:295
    #1 0x563c457f437b in build_cpu_domain_map util/header.c:1727
    #2 0x563c457f491f in write_cpu_domain_info util/header.c:1753
    #3 0x563c45a539ef in perf_event__synthesize_features util/synthetic-events.c:2419
    #4 0x563c45a54224 in perf_event__synthesize_for_pipe util/synthetic-events.c:2471
    #5 0x563c451bb085 in record__synthesize /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/builtin-record.c:2063
    #6 0x563c451c2ded in __cmd_record /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/builtin-record.c:2581
    #7 0x563c451d38cb in cmd_record /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/builtin-record.c:4376
    #8 0x563c453e0aac in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/perf.c:349
    #9 0x563c453e139d in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/perf.c:401
    #10 0x563c453e18f3 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/perf.c:445
    #11 0x563c453e209a in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/perf.c:553
    #12 0x7fada5de9ca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #13 0x7fada5de9d64 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x29d64) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #14 0x563c45151470 in _start (/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/perf+0xf9b470) (BuildId: 7c6fd1162dbb1e721de92bbfd9fc751e2178f1fa)

Address 0x7fad986a1050 is located in stack of thread T0 at offset 80 in frame
    #0 0x563c459e1c26 in cpumask_to_cpulist util/util.c:267

  This frame has 2 object(s):
    [32, 49) 'blk' (line 291)
    [96, 1120) 'cpus' (line 271) <== Memory access at offset 80 underflows this variable
HINT: this may be a false positive if your program uses some custom stack unwind mechanism, swapcontext or vfork
      (longjmp and C++ exceptions *are* supported)
SUMMARY: AddressSanitizer: stack-buffer-overflow util/util.c:295 in cpumask_to_cpulist
Shadow bytes around the buggy address:
  0x7fad986a0d80: 00 00 00 00 00 00 00 00 00 00 00 00 f3 f3 f3 f3
  0x7fad986a0e00: f3 f3 f3 f3 f3 f3 f3 f3 f3 f3 f3 f3 00 00 00 00
  0x7fad986a0e80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7fad986a0f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7fad986a0f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
=>0x7fad986a1000: f1 f1 f1 f1 00 00 01 f2 f2 f2[f2]f2 00 00 00 00
  0x7fad986a1080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7fad986a1100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7fad986a1180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7fad986a1200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7fad986a1280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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
==16835==ABORTING
Error:
The - data has no samples!
Inject build-ids test [Failed - cannot find noploop function in pipe #1]

Inject --buildid-all build-ids test
util/util.c:295:6: runtime error: index 64 out of bounds for type 'char [17]'
util/util.c:295:12: runtime error: store to address 0x7fb708ca1060 with insufficient space for an object of type 'char'
0x7fb708ca1060: note: pointer points here
 00 00 00 00  01 00 00 00 00 00 00 00  18 00 04 2e 00 00 00 00  9d 77 00 00 00 00 00 00  02 00 00 00
              ^ 
=================================================================
==16849==ERROR: AddressSanitizer: stack-buffer-overflow on address 0x7fb708ca1050 at pc 0x55677eb40257 bp 0x7ffe5b049bd0 sp 0x7ffe5b049bc8
WRITE of size 1 at 0x7fb708ca1050 thread T0
    #0 0x55677eb40256 in cpumask_to_cpulist util/util.c:295
    #1 0x55677e95237b in build_cpu_domain_map util/header.c:1727
    #2 0x55677e95291f in write_cpu_domain_info util/header.c:1753
    #3 0x55677ebb19ef in perf_event__synthesize_features util/synthetic-events.c:2419
    #4 0x55677ebb2224 in perf_event__synthesize_for_pipe util/synthetic-events.c:2471
    #5 0x55677e319085 in record__synthesize /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/builtin-record.c:2063
    #6 0x55677e320ded in __cmd_record /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/builtin-record.c:2581
    #7 0x55677e3318cb in cmd_record /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/builtin-record.c:4376
    #8 0x55677e53eaac in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/perf.c:349
    #9 0x55677e53f39d in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/perf.c:401
    #10 0x55677e53f8f3 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/perf.c:445
    #11 0x55677e54009a in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/perf.c:553
    #12 0x7fb716412ca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #13 0x7fb716412d64 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x29d64) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #14 0x55677e2af470 in _start (/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/perf+0xf9b470) (BuildId: 7c6fd1162dbb1e721de92bbfd9fc751e2178f1fa)

Address 0x7fb708ca1050 is located in stack of thread T0 at offset 80 in frame
    #0 0x55677eb3fc26 in cpumask_to_cpulist util/util.c:267

  This frame has 2 object(s):
    [32, 49) 'blk' (line 291)
    [96, 1120) 'cpus' (line 271) <== Memory access at offset 80 underflows this variable
HINT: this may be a false positive if your program uses some custom stack unwind mechanism, swapcontext or vfork
      (longjmp and C++ exceptions *are* supported)
SUMMARY: AddressSanitizer: stack-buffer-overflow util/util.c:295 in cpumask_to_cpulist
Shadow bytes around the buggy address:
  0x7fb708ca0d80: 00 00 00 00 00 00 00 00 00 00 00 00 f3 f3 f3 f3
  0x7fb708ca0e00: f3 f3 f3 f3 f3 f3 f3 f3 f3 f3 f3 f3 00 00 00 00
  0x7fb708ca0e80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7fb708ca0f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7fb708ca0f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
=>0x7fb708ca1000: f1 f1 f1 f1 00 00 01 f2 f2 f2[f2]f2 00 00 00 00
  0x7fb708ca1080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7fb708ca1100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7fb708ca1180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7fb708ca1200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7fb708ca1280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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
==16849==ABORTING
Error:
The - data has no samples!
Inject build-ids test [Failed - cannot find noploop function in pipe #1]

Inject --mmap2-buildid-all build-ids test
util/util.c:295:6: runtime error: index 64 out of bounds for type 'char [17]'
util/util.c:295:12: runtime error: store to address 0x7f790f8a1060 with insufficient space for an object of type 'char'
0x7f790f8a1060: note: pointer points here
 00 00 00 00  01 00 00 00 00 00 00 00  18 00 04 2e 00 00 00 00  9d 77 00 00 00 00 00 00  02 00 00 00
              ^ 
=================================================================
==16869==ERROR: AddressSanitizer: stack-buffer-overflow on address 0x7f790f8a1050 at pc 0x5602d1c61257 bp 0x7ffc6a01f190 sp 0x7ffc6a01f188
WRITE of size 1 at 0x7f790f8a1050 thread T0
    #0 0x5602d1c61256 in cpumask_to_cpulist util/util.c:295
    #1 0x5602d1a7337b in build_cpu_domain_map util/header.c:1727
    #2 0x5602d1a7391f in write_cpu_domain_info util/header.c:1753
    #3 0x5602d1cd29ef in perf_event__synthesize_features util/synthetic-events.c:2419
    #4 0x5602d1cd3224 in perf_event__synthesize_for_pipe util/synthetic-events.c:2471
    #5 0x5602d143a085 in record__synthesize /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/builtin-record.c:2063
    #6 0x5602d1441ded in __cmd_record /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/builtin-record.c:2581
    #7 0x5602d14528cb in cmd_record /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/builtin-record.c:4376
    #8 0x5602d165faac in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/perf.c:349
    #9 0x5602d166039d in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/perf.c:401
    #10 0x5602d16608f3 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/perf.c:445
    #11 0x5602d166109a in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/perf.c:553
    #12 0x7f791cfd5ca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #13 0x7f791cfd5d64 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x29d64) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #14 0x5602d13d0470 in _start (/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/perf+0xf9b470) (BuildId: 7c6fd1162dbb1e721de92bbfd9fc751e2178f1fa)

Address 0x7f790f8a1050 is located in stack of thread T0 at offset 80 in frame
    #0 0x5602d1c60c26 in cpumask_to_cpulist util/util.c:267

  This frame has 2 object(s):
    [32, 49) 'blk' (line 291)
    [96, 1120) 'cpus' (line 271) <== Memory access at offset 80 underflows this variable
HINT: this may be a false positive if your program uses some custom stack unwind mechanism, swapcontext or vfork
      (longjmp and C++ exceptions *are* supported)
SUMMARY: AddressSanitizer: stack-buffer-overflow util/util.c:295 in cpumask_to_cpulist
Shadow bytes around the buggy address:
  0x7f790f8a0d80: 00 00 00 00 00 00 00 00 00 00 00 00 f3 f3 f3 f3
  0x7f790f8a0e00: f3 f3 f3 f3 f3 f3 f3 f3 f3 f3 f3 f3 00 00 00 00
  0x7f790f8a0e80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7f790f8a0f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7f790f8a0f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
=>0x7f790f8a1000: f1 f1 f1 f1 00 00 01 f2 f2 f2[f2]f2 00 00 00 00
  0x7f790f8a1080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7f790f8a1100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7f790f8a1180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7f790f8a1200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7f790f8a1280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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
==16869==ABORTING
Error:
The - data has no samples!
Inject build-ids test [Failed - cannot find noploop function in pipe #1]
---- end(-1) ----
 88: perf pipe recording and injection test                          : FAILED!
2025-09-15 14:22:22 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/perf test 89 -v
 89: Zstd perf.data compression/decompression                        : Running (1 active)
--- start ---
test child forked, pid 16896
Collecting compressed record file:
500+0 records in
500+0 records out
256000 bytes (256 kB, 250 KiB) copied, 0.00308355 s, 83.0 MB/s
[ perf record: Woken up 2 times to write data ]
util/util.c:295:6: runtime error: index 64 out of bounds for type 'char [17]'
util/util.c:295:12: runtime error: store to address 0x7f9ffdca2060 with insufficient space for an object of type 'char'
0x7f9ffdca2060: note: pointer points here
 00 00 00 00  01 00 00 00 00 00 00 00  18 00 04 2e 00 00 00 00  9d 77 00 00 00 00 00 00  02 00 00 00
              ^ 
=================================================================
==16904==ERROR: AddressSanitizer: stack-buffer-overflow on address 0x7f9ffdca2050 at pc 0x564af4570257 bp 0x7ffd6f117510 sp 0x7ffd6f117508
WRITE of size 1 at 0x7f9ffdca2050 thread T0
    #0 0x564af4570256 in cpumask_to_cpulist util/util.c:295
    #1 0x564af438237b in build_cpu_domain_map util/header.c:1727
    #2 0x564af438291f in write_cpu_domain_info util/header.c:1753
    #3 0x564af439cc44 in do_write_feat util/header.c:3892
    #4 0x564af439d65f in perf_header__adds_write util/header.c:3936
    #5 0x564af439f14a in perf_session__do_write_header util/header.c:4060
    #6 0x564af439f72c in perf_session__write_header util/header.c:4100
    #7 0x564af3d46044 in record__finish_output /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/builtin-record.c:1826
    #8 0x564af3d53e54 in __cmd_record /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/builtin-record.c:2894
    #9 0x564af3d618cb in cmd_record /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/builtin-record.c:4376
    #10 0x564af3f6eaac in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/perf.c:349
    #11 0x564af3f6f39d in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/perf.c:401
    #12 0x564af3f6f8f3 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/perf.c:445
    #13 0x564af3f7009a in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/perf.c:553
    #14 0x7fa00b28eca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #15 0x7fa00b28ed64 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x29d64) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #16 0x564af3cdf470 in _start (/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-01c79e2544b044e2c01ab435a28a03c3f0d63be3/tools/perf/perf+0xf9b470) (BuildId: 7c6fd1162dbb1e721de92bbfd9fc751e2178f1fa)

Address 0x7f9ffdca2050 is located in stack of thread T0 at offset 80 in frame
    #0 0x564af456fc26 in cpumask_to_cpulist util/util.c:267

  This frame has 2 object(s):
    [32, 49) 'blk' (line 291)
    [96, 1120) 'cpus' (line 271) <== Memory access at offset 80 underflows this variable
HINT: this may be a false positive if your program uses some custom stack unwind mechanism, swapcontext or vfork
      (longjmp and C++ exceptions *are* supported)
SUMMARY: AddressSanitizer: stack-buffer-overflow util/util.c:295 in cpumask_to_cpulist
Shadow bytes around the buggy address:
  0x7f9ffdca1d80: 00 00 00 00 00 00 00 00 00 00 00 00 f3 f3 f3 f3
  0x7f9ffdca1e00: f3 f3 f3 f3 f3 f3 f3 f3 f3 f3 f3 f3 00 00 00 00
  0x7f9ffdca1e80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7f9ffdca1f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7f9ffdca1f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
=>0x7f9ffdca2000: f1 f1 f1 f1 00 00 01 f2 f2 f2[f2]f2 00 00 00 00
  0x7f9ffdca2080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7f9ffdca2100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7f9ffdca2180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7f9ffdca2200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7f9ffdca2280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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
==16904==ABORTING
---- end(-1) ----
 89: Zstd perf.data compression/decompression                        : FAILED!



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250917/202509171303.b892ad4b-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

