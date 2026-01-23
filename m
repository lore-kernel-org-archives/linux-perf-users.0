Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068A922A4D6;
	Fri, 23 Jan 2026 06:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769149096; cv=fail; b=h5J+xheRGeHxX/PjxxQxyQDja10Rm6RklcFvUNEux281UKdFm1Z/wn2u5xnuNA53XMI6O+d2rMMl2KvkkmXVf3GJWxhi1uVziYPRh+dIHLHjkTQ2nyxCFFwx/00vODVqusEoEQE8tCuMfoNm6z1vyoY29GAdhoC6PEOwnJl23ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769149096; c=relaxed/simple;
	bh=fdWErV+QT7v8Uyw45P/0+9BWXHqf1AWtchrZ8okc8NM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WWiRVNjgrnH1cvbiyDJzcrfQE0yvf3JZy1xArQ97jtNeF+qvzBosoA9UKLFxecEMzENNgnP7g/iXEo4rrzJldlafi7X1kOixcm/aDdyckdriXdfoW3F1B8ePFUdQd2TMNM57gEdFpcNXCnRt4fFtI5B5nfBVuuKkgdxqMWXHR6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H4GtRDbc; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H4GtRDbc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769149091; x=1800685091;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fdWErV+QT7v8Uyw45P/0+9BWXHqf1AWtchrZ8okc8NM=;
  b=H4GtRDbcQP77+001FK8N4eZo0PFm6ujuuIn1TXcahg8XRp0keOvZxG3x
   I90yJorozC2+fH9xoq8OGGI8q5Ot5YAKz5MN6e0KUD98axfH28Ysz+Ro8
   hzr0TrJTpP+QzPHXOj2B3Kr6PUnCbtSJ+DGbYUBjlTMchi48+kbEocte5
   8UM4iKhbRqTmiGiHHaeTlpZtC+FkAC+/Cce3I/BbdSNO+Gapijb5rs5CK
   +JMNewVyYYyIIbMp8UWUcYrEL24NK5Cg1wYp7zvvDf2Tx9JRQkb8OtBhy
   n/OPy5zVVWC7LjNYV/ruh4pwo+n6LlsgB7mEw5gCWUA6duExoybkm0F0+
   g==;
X-CSE-ConnectionGUID: mw+E/4p6SjS8vPGmQDp7Jw==
X-CSE-MsgGUID: bLhU34OCRmCj3o7uGWsvDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="69596241"
X-IronPort-AV: E=Sophos;i="6.21,247,1763452800"; 
   d="scan'208";a="69596241"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 22:18:07 -0800
X-CSE-ConnectionGUID: 9uWR5wwGRkqv87xHJjjXPQ==
X-CSE-MsgGUID: cpiy10pXTzii3EA5ep9QBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,247,1763452800"; 
   d="scan'208";a="237595717"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 22:18:07 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 22:18:06 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 22 Jan 2026 22:18:06 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.3) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 22:18:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NGuw6BKL2H3D3MV3yWxY41tYPB4WzfYVvUnRZ+mIKzgOFKkSFMtcugDwg1052tV03ogE16FOKu+mcKas9+ku7gFvqM/r9j8kLzG4tJgzWtM0G3OcJW3Ytx0N0Nv3F1+yf4USu1ElFWpJjJtFHw9UH+TROVpNZwE0jALaYIzAmwDbQfudfmsoCQFwcrKR9JjrJ9g8WNgDryUEU2g62NMEM0AKG4cBNxVUWV3wiOJZ9X7uR2QabfzyCQLhi4/hMFh9mmz0vMSWQoBXKTyccQQZhv6e+JN3iifsCzSSqn+PFOOXdBF5tPY8iPOzbEAzawklG9pMhdQYtmM6f1RHYujr/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCBkK4Y+eJHxxe4oyFvxGotfaKivE5yU6/qm6xliYik=;
 b=xYqAo7YKA/1zhicmQVJYgnvG/XtSRCA8uCcd8wBgwtnXDYFPu4RlfSh2v07xxxX4bL2h4m0U6wAgqdoUKaXNX4OPSjymQiZC/byG6q9PIhK7SG6qm/hG9/3zVTOOuuROo62VOSs1jeeSNADUoOq6D1yfZ44frevXflO4m5TPJdPIRC+i0aaFbRL9I0JooWKByk72JafNB2GoXGGFlItGXfmPykZII0BvvXNE1R3tsSlUjMRUTOH77c0Jpu4RrYXHjWiJH1xZRSnCGWclII9lgJ4pjg1D51GRxbRj2metaqGD8qUHrV6U0kYhrqmPAl69RT8Ghz43KI6PKTAK/aDpGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW6PR11MB8310.namprd11.prod.outlook.com (2603:10b6:303:249::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Fri, 23 Jan
 2026 06:18:03 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 06:18:03 +0000
Date: Fri, 23 Jan 2026 14:17:51 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Ian Rogers <irogers@google.com>
CC: Thomas Richter <tmricht@linux.ibm.com>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Sri Jayaramappa
	<sjayaram@akamai.com>, Adrian Hunter <adrian.hunter@intel.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Guilherme Amadio
	<amadio@gentoo.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa
	<jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [linux-next:master] [perf test subcmd help] ef92c4351e:
 kmsg.sanitizer.indirect_leak/malloc/___interceptor_backtrace/child_test_sig_handler/raise/abort
Message-ID: <aXMSjyjjd2PRDpok@xsang-OptiPlex-9020>
References: <202601201519.ce4c3ab3-lkp@intel.com>
 <CAP-5=fVyGswdFrEw7=P8RGPJP+2wW3qQhzCfz1BoJ9Uvg4iKDg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAP-5=fVyGswdFrEw7=P8RGPJP+2wW3qQhzCfz1BoJ9Uvg4iKDg@mail.gmail.com>
X-ClientProxiedBy: KU2P306CA0053.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3d::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW6PR11MB8310:EE_
X-MS-Office365-Filtering-Correlation-Id: b743b5bd-e978-4fec-8b9d-08de5a472a20
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kMEpyn0wyiAyVGt/FOrv67TCNbhfeGkICUdl5zCDtCOEEy0u+Ye2lCS9YUxi?=
 =?us-ascii?Q?ARTJNI1YEzzulWisTdPyXVT+8vWb5IdW2sHTuaUkDVIPwPuleEgPSAtN/AkC?=
 =?us-ascii?Q?hh+j0EJV6xZ28gdwNygyOLnfQcYbS/XD2apPLHiLkxPuJfcp936OoXX2Prd7?=
 =?us-ascii?Q?j2PDpEBtZp7RsrTb+RptQtfKQSRXZBAb8Nr9ikf7xruaz8CVI3+uNQ18k3dj?=
 =?us-ascii?Q?7wiknQV9dCTtv1mQYfs7696I7K+xFWyoLgGv07DRSZouC5VSLwTkhBomSL1O?=
 =?us-ascii?Q?d3u+NMLklJczaWrGpxPvVndI+D/XDvyFMKK4ePn3gHJIN+tjOBIunnfevxsR?=
 =?us-ascii?Q?40QgvwghA0inZ6AesT/gaIMDLWC01QpB9NsrrcZqk2tZvXZpqga/UmhfBPxL?=
 =?us-ascii?Q?E35T4pu0e3cU0D9hXIXP8e+iIo7PYf4yFhb6mdqMgvnvuOYIHX/N3UIzPtch?=
 =?us-ascii?Q?pB7uHGHOs37AzsPEn93d09vkDAMRSjHIoY4zmAwHzfRy6+diY+y/HBCldxgX?=
 =?us-ascii?Q?ZH+lEHeD/v9UnFFYvbkhi5pDmSoHi5tZqpVdnQE1tHm0HSUsJUIE1bfebirr?=
 =?us-ascii?Q?PLdfBFGLh+pqFEWyIFehQmL6FjONLaKGyOywbDmWAEMXH10nFCbLEOIcCHvI?=
 =?us-ascii?Q?+UIkYGN50N3V72MASuQSJFnlkaRvYDcux7H/gGPlYnQpcIJsuiD7HrZ2D45T?=
 =?us-ascii?Q?1Dag4/yc7cU9S8L8FR233z4ULVKhcFclScqsM1Fw3gh1H62I0kBOlNFrRooj?=
 =?us-ascii?Q?LLh1eNpy5rM9VznzFCR0uHGesFoRVBSxI13zU5WWh2EZL6PCshGu9LHIAf04?=
 =?us-ascii?Q?x36sX8D+nxxmOGb1STju3euRlkEBqAJur0PNHfnT3a6fg1jpvCOWv2VwXXUA?=
 =?us-ascii?Q?Ua+Vl8e6nMd1G7zSQkVyaHDc03Xkya6WW0YYKTqsJmyKOonJcasB8SxOG6Ti?=
 =?us-ascii?Q?IgPa5xewnhVVBth2gjBjyWsuRJHUYa8/MQAPA1uz8BZ9/GgWj2cbLXUExDWG?=
 =?us-ascii?Q?jsBbyrPmXQKnUicdoPIkSKVjO7ure/c2h/VRcdfgcSGr473W2ffPTH4WEO30?=
 =?us-ascii?Q?Hyooke/c7FFR1j9Cq3sZMpHuv7iMCdO1B27K01ITrdDz6lmuNQCt83cJbaT+?=
 =?us-ascii?Q?aqbXNCFIs+u8zfDf7LM2Rv7STVBaviBoDeC8nzP9fbSpYMbIgYJoCCC5U8EP?=
 =?us-ascii?Q?ChlXVE9VOM1FNmiOrvBTL2Qb442UO0yBbd6TvGWKTismJjDd6PZBJ/Jw2Iur?=
 =?us-ascii?Q?+bOR4mqTuX1MaoJfV0Uy/lnaBzN/6CbKlFH5n+gMAWcVkp9iuJ4La/9XS4nX?=
 =?us-ascii?Q?LfKPOLIP6mrH+Y+ZkX1XYjP27kYKKwotapw6bAQxPb6afhpSBI1+y6xY9a9t?=
 =?us-ascii?Q?UMQHqIOmTI9O6wlGP3ANkCxlYzsDRGnRx9O9NRQZx1t6rrAVnhZJeJMkRdU2?=
 =?us-ascii?Q?UaOmplwVkFO/76UaNs9/qSSMsi90Fg2LEu8PLVHT6G6j6tfoqnP+SJinaw9Z?=
 =?us-ascii?Q?XN31ybr0K8+uCD6jizgJt9zuW69fcVX+/mL6houwTzR2utFAVswG27WM5shJ?=
 =?us-ascii?Q?joLRzlsfY1PdQV7v9Xhvpa/FDrYRh9hW+bSGygZ3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k8BmDglnoSO/gOWGW8fH3s2H2Vz4kqoiW12zUj1FIPsfjcCPysr7Ldszr003?=
 =?us-ascii?Q?Ycem5h8M9xk2aFFsJAdJXWIkEUon9hTJyCL/RCz8XyxQ4TzT/WMhRzStVW/e?=
 =?us-ascii?Q?nPSvTtZYPCVxhzVC9sDFiQaT8eFmnJdHk6DwHYlS4ize7HIRwO5HIRZJEu+1?=
 =?us-ascii?Q?GjxNT+JwOMzBmcOk/wyNjo3TwBhBSpmHi8ggUd6dnssHgAW5TWUs8/cuEXqK?=
 =?us-ascii?Q?5jlyIGkWUj7/N/cFIMBIeE9artKe28hkm+b0UavUhMq9AsFRAVeUud4gwke6?=
 =?us-ascii?Q?aAe9mAIhbKEdIqMlDP+ZnN7TLzoAVZg3hCLuA9jK3eFe3GAPVh7f0jRGcOik?=
 =?us-ascii?Q?BdMeGEExp2w3RFQWMuW7/Fkg+COvKm/ovOP9gGsU1l/Uxi4fPegQ0xIF6umS?=
 =?us-ascii?Q?h0OITJPopXkI+/yR/4hZcKt9sbfa2Q12OdNsIbwTHkmlaSV+9kOaBQxQbjGY?=
 =?us-ascii?Q?+pU6rGXndoggo0IP/UGNcflKb/n1ND9HNoI0nAY2HNyslO0Y5ErKcO/C+tdB?=
 =?us-ascii?Q?PR5kGt+7wJ/w0Jaql6o8hysZGjn30yh1xgfZtBLCux6aCx/TN9Zdu7TMQEfL?=
 =?us-ascii?Q?sxdqtucFVe6cDDvW90rbw6RvaXCDw4mt0qWsTLBBWTMw+Q0qx/2X/j9dvexG?=
 =?us-ascii?Q?Ar3ipdQcub3+Z7utY2zV0YP+zw+rDxqVU8BNnuoVnGaNIHiD98KF9C82vp8H?=
 =?us-ascii?Q?i+5gtyTMg751NNAhR5/QnsyJ9AmBEKBBSykLbeeO05tVe64ZFmrDVoRjpqxC?=
 =?us-ascii?Q?3raYhiM71bTPVF1nQvsbEuF+YjPLgsNiynx3Ye54ll+BxU76hMTU+XQ1riDA?=
 =?us-ascii?Q?nDByayoo3z/5nQHoYg5tJ/54KxFej7jJFMsATFJuKBjYYzY9NTU4rD9ikNiy?=
 =?us-ascii?Q?CY9USpjaHNMUmviU0ll7XmlnCOJAuDW6YJP5hGu/ogUsNs0Bu9OMhTy5b68/?=
 =?us-ascii?Q?olnIhk4EyL6QGwqC8Q8LnAB4PlHNfr9VOhK5HXOgL2DQnx9fa4iygw/KFEhv?=
 =?us-ascii?Q?yUPX1Pq5YyhsUJdzzb2mFzNu2K7hmNVk5OCrtZhVmP/2izftZsiYqDo4xf5u?=
 =?us-ascii?Q?O1wU6kcUbF0hX00Ob1Vnr5ibmYUhE1N56Z1UlbrJDAJkbBf+TaVQ5KEBkFbc?=
 =?us-ascii?Q?C/9xhcaE49r4v3J/0+K7CU+ZwuXtDJZQmVBNi08vWPN6AoGvden40b0jMhkb?=
 =?us-ascii?Q?coCgoGFBqK/oksp5BX7l9wNTJEK4QoGsUksRL1RWhTIFV2hp9g+B3yiBjvJa?=
 =?us-ascii?Q?knp7DdjZXQ19lWX3s0k94rbgvyU7MhRcGURXzjDnJS+XdT7YPuUrlz8BPtcx?=
 =?us-ascii?Q?zm7WaU0Eg6CVqoPG3nHCrH0AbwhlbjisNFEw4kR7BN2nTBRi8dU8EZZ9whWh?=
 =?us-ascii?Q?WEG1qfWNXqQmC5o8a7AlNMIDc4LB4FklNTJhWXmZ1ue2vCC06JbqGqthf9OC?=
 =?us-ascii?Q?nTsntTlAmbF2uDsjjuPEkKwEpIMSq4B9X4FvnrCiN0629XWJVmjHJ17BdjSG?=
 =?us-ascii?Q?g+wLLjyG3CVBcOe+GlIeIsJ1nQayrQxofJyJ7g27bzAHlnbgHyAGZ+wRXpGo?=
 =?us-ascii?Q?V5Qe96uWW358n49o315BxkvPgn+/JEKvtiu725pjR6UKXKzIa4ZaGvFN1ROL?=
 =?us-ascii?Q?hAgpc/ogBW2nB/Hzxc5bsYqfxNtS76BPWo7L68l1ae4vMdedgTjK498kNdEn?=
 =?us-ascii?Q?tEX0HIxLRrkUBd16hC1RXfhFaiGmwcjF9Axn2b4+j6uyIAhnGrhz8HM7mN+P?=
 =?us-ascii?Q?44rHGso33g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b743b5bd-e978-4fec-8b9d-08de5a472a20
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 06:18:03.2164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V8H+eY8FF0orkXcihInyygJaDS9QIcYgYN5Llf2AmdqmidG62aYoJ0qJ/bLByJHsZm/ZJct/5gbyAVT4LO75jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8310
X-OriginatorOrg: intel.com


hi, Ian Rogers,


On Wed, Jan 21, 2026 at 07:52:15AM -0800, Ian Rogers wrote:

[...]

> >     #20 0x55f34aa28241 in _start perf[102f241]
> 
> I believe this is resolved by:
> https://lore.kernel.org/lkml/20260121082402.2311962-1-tmricht@linux.ibm.com/
> 
> > =================================================================
> > ==11710==ERROR: LeakSanitizer: detected memory leaks
> >
> > Direct leak of 30952 byte(s) in 3 object(s) allocated from:
> >     #0 0x7f7688ced610 in calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
> >     #1 0x7f7688ace808  (/lib/x86_64-linux-gnu/libelf.so.1+0x3808) (BuildId: d6a40be9eadcbcb0562b7bb13bbe81166e82cc40)
> >
> > Indirect leak of 9280 byte(s) in 3 object(s) allocated from:
> >     #0 0x7f7688cedc57 in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
> >     #1 0x7f7688ad6550  (/lib/x86_64-linux-gnu/libelf.so.1+0xb550) (BuildId: d6a40be9eadcbcb0562b7bb13bbe81166e82cc40)
> >
> > Indirect leak of 1873 byte(s) in 3 object(s) allocated from:
> >     #0 0x7f7688cedc57 in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
> >     #1 0x7f7688ad73fa  (/lib/x86_64-linux-gnu/libelf.so.1+0xc3fa) (BuildId: d6a40be9eadcbcb0562b7bb13bbe81166e82cc40)
> >
> > SUMMARY: AddressSanitizer: 42105 byte(s) leaked in 9 allocation(s).
> >  68.4: Exclude disjoint subcmd names                                 : FAILED!
> 
> To better diagnose these leaks could you disable the fast asan stack unwinder:
> ASAN_OPTIONS=fast_unwind_on_malloc=0

thanks a lot for guidance!

we've made the change according, now see results like below [1]

we will supply these information in future reports. thanks again!


[1]

=================================================================
==11725==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 30952 byte(s) in 3 object(s) allocated from:
    #0 0x7fed49fb4610 in calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x7fed49d95808  (/lib/x86_64-linux-gnu/libelf.so.1+0x3808) (BuildId: d6a40be9eadcbcb0562b7bb13bbe81166e82cc40)
    #2 0x7fed49d965f9  (/lib/x86_64-linux-gnu/libelf.so.1+0x45f9) (BuildId: d6a40be9eadcbcb0562b7bb13bbe81166e82cc40)
    #3 0x55dc6825e4f7 in symsrc__init util/symbol-elf.c:1164
    #4 0x55dc67ddba50 in dso__load util/symbol.c:1795
    #5 0x55dc67e6fa86 in map__load util/map.c:351
    #6 0x55dc67e6fe6d in map__find_symbol util/map.c:385
    #7 0x55dc67e4480a in __dump_stack util/debug.c:343
    #8 0x55dc67ad0c84 in child_test_sig_handler tests/builtin-test.c:313
    #9 0x7fed3fcf2def  (/lib/x86_64-linux-gnu/libc.so.6+0x3fdef) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #10 0x7fed3fd4795b  (/lib/x86_64-linux-gnu/libc.so.6+0x9495b) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #11 0x7fed3fcf2cc1 in gsignal (/lib/x86_64-linux-gnu/libc.so.6+0x3fcc1) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #12 0x7fed3fcdb4ab in abort (/lib/x86_64-linux-gnu/libc.so.6+0x284ab) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #13 0x7fed3fcdb41f  (/lib/x86_64-linux-gnu/libc.so.6+0x2841f) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #14 0x55dc67a0ee6f in exclude_cmds /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-ef92c4351ec75bcfb8a1cc3a88109b5339f296ef/tools/lib/subcmd/help.c:107
    #15 0x55dc67bb4645 in test__exclude_cmdnames_no_overlap tests/subcmd-help.c:110
    #16 0x55dc67ad14c4 in run_test_child tests/builtin-test.c:340
    #17 0x55dc67a22db2 in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-ef92c4351ec75bcfb8a1cc3a88109b5339f296ef/tools/lib/subcmd/run-command.c:128
    #18 0x55dc67ad39a0 in start_test tests/builtin-test.c:545
    #19 0x55dc67ad490c in __cmd_test tests/builtin-test.c:648
    #20 0x55dc67ad72bf in cmd_test tests/builtin-test.c:850
    #21 0x55dc679dca44 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-ef92c4351ec75bcfb8a1cc3a88109b5339f296ef/tools/perf/perf.c:349
    #22 0x55dc679dd335 in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-ef92c4351ec75bcfb8a1cc3a88109b5339f296ef/tools/perf/perf.c:401
    #23 0x55dc679dd88b in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-ef92c4351ec75bcfb8a1cc3a88109b5339f296ef/tools/perf/perf.c:445
    #24 0x55dc679de032 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-ef92c4351ec75bcfb8a1cc3a88109b5339f296ef/tools/perf/perf.c:553
    #25 0x7fed3fcdcca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #26 0x7fed3fcdcd64 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x29d64) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #27 0x55dc67742240 in _start (/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-ef92c4351ec75bcfb8a1cc3a88109b5339f296ef/tools/perf/perf+0x102f240) (BuildId: b8c98ab0747f9f1fe41a64089a7488f7aedbc9d8)

Indirect leak of 9280 byte(s) in 3 object(s) allocated from:
    #0 0x7fed49fb4c57 in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x7fed49d9d550  (/lib/x86_64-linux-gnu/libelf.so.1+0xb550) (BuildId: d6a40be9eadcbcb0562b7bb13bbe81166e82cc40)
    #2 0x7fed49d9e517  (/lib/x86_64-linux-gnu/libelf.so.1+0xc517) (BuildId: d6a40be9eadcbcb0562b7bb13bbe81166e82cc40)
    #3 0x7fed49d9e0b1 in elf_rawdata (/lib/x86_64-linux-gnu/libelf.so.1+0xc0b1) (BuildId: d6a40be9eadcbcb0562b7bb13bbe81166e82cc40)
    #4 0x55dc68254770 in elf_section_by_name util/symbol-elf.c:193
    #5 0x55dc6825d641 in read_gnu_debugdata util/symbol-elf.c:1086
    #6 0x55dc6825e625 in symsrc__init util/symbol-elf.c:1173
    #7 0x55dc67ddba50 in dso__load util/symbol.c:1795
    #8 0x55dc67e6fa86 in map__load util/map.c:351
    #9 0x55dc67e6fe6d in map__find_symbol util/map.c:385
    #10 0x55dc67e4480a in __dump_stack util/debug.c:343
    #11 0x55dc67ad0c84 in child_test_sig_handler tests/builtin-test.c:313
    #12 0x7fed3fcf2def  (/lib/x86_64-linux-gnu/libc.so.6+0x3fdef) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #13 0x7fed3fd4795b  (/lib/x86_64-linux-gnu/libc.so.6+0x9495b) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #14 0x7fed3fcf2cc1 in gsignal (/lib/x86_64-linux-gnu/libc.so.6+0x3fcc1) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #15 0x7fed3fcdb4ab in abort (/lib/x86_64-linux-gnu/libc.so.6+0x284ab) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #16 0x7fed3fcdb41f  (/lib/x86_64-linux-gnu/libc.so.6+0x2841f) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #17 0x55dc67a0ee6f in exclude_cmds /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-ef92c4351ec75bcfb8a1cc3a88109b5339f296ef/tools/lib/subcmd/help.c:107
    #18 0x55dc67bb4645 in test__exclude_cmdnames_no_overlap tests/subcmd-help.c:110
    #19 0x55dc67ad14c4 in run_test_child tests/builtin-test.c:340
    #20 0x55dc67a22db2 in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-ef92c4351ec75bcfb8a1cc3a88109b5339f296ef/tools/lib/subcmd/run-command.c:128
    #21 0x55dc67ad39a0 in start_test tests/builtin-test.c:545
    #22 0x55dc67ad490c in __cmd_test tests/builtin-test.c:648
    #23 0x55dc67ad72bf in cmd_test tests/builtin-test.c:850
    #24 0x55dc679dca44 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-ef92c4351ec75bcfb8a1cc3a88109b5339f296ef/tools/perf/perf.c:349
    #25 0x55dc679dd335 in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-ef92c4351ec75bcfb8a1cc3a88109b5339f296ef/tools/perf/perf.c:401
    #26 0x55dc679dd88b in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-ef92c4351ec75bcfb8a1cc3a88109b5339f296ef/tools/perf/perf.c:445
    #27 0x55dc679de032 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-ef92c4351ec75bcfb8a1cc3a88109b5339f296ef/tools/perf/perf.c:553

Indirect leak of 1873 byte(s) in 3 object(s) allocated from:
    #0 0x7fed49fb4c57 in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x7fed49d9e3fa  (/lib/x86_64-linux-gnu/libelf.so.1+0xc3fa) (BuildId: d6a40be9eadcbcb0562b7bb13bbe81166e82cc40)
    #2 0x7fed49d9e0b1 in elf_rawdata (/lib/x86_64-linux-gnu/libelf.so.1+0xc0b1) (BuildId: d6a40be9eadcbcb0562b7bb13bbe81166e82cc40)
    #3 0x55dc68254770 in elf_section_by_name util/symbol-elf.c:193
    #4 0x55dc6825d641 in read_gnu_debugdata util/symbol-elf.c:1086
    #5 0x55dc6825e625 in symsrc__init util/symbol-elf.c:1173
    #6 0x55dc67ddba50 in dso__load util/symbol.c:1795
    #7 0x55dc67e6fa86 in map__load util/map.c:351
    #8 0x55dc67e6fe6d in map__find_symbol util/map.c:385
    #9 0x55dc67e4480a in __dump_stack util/debug.c:343
    #10 0x55dc67ad0c84 in child_test_sig_handler tests/builtin-test.c:313
    #11 0x7fed3fcf2def  (/lib/x86_64-linux-gnu/libc.so.6+0x3fdef) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #12 0x7fed3fd4795b  (/lib/x86_64-linux-gnu/libc.so.6+0x9495b) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #13 0x7fed3fcf2cc1 in gsignal (/lib/x86_64-linux-gnu/libc.so.6+0x3fcc1) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #14 0x7fed3fcdb4ab in abort (/lib/x86_64-linux-gnu/libc.so.6+0x284ab) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #15 0x7fed3fcdb41f  (/lib/x86_64-linux-gnu/libc.so.6+0x2841f) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #16 0x55dc67a0ee6f in exclude_cmds /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-ef92c4351ec75bcfb8a1cc3a88109b5339f296ef/tools/lib/subcmd/help.c:107
    #17 0x55dc67bb4645 in test__exclude_cmdnames_no_overlap tests/subcmd-help.c:110
    #18 0x55dc67ad14c4 in run_test_child tests/builtin-test.c:340
    #19 0x55dc67a22db2 in start_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-ef92c4351ec75bcfb8a1cc3a88109b5339f296ef/tools/lib/subcmd/run-command.c:128
    #20 0x55dc67ad39a0 in start_test tests/builtin-test.c:545
    #21 0x55dc67ad490c in __cmd_test tests/builtin-test.c:648
    #22 0x55dc67ad72bf in cmd_test tests/builtin-test.c:850
    #23 0x55dc679dca44 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-ef92c4351ec75bcfb8a1cc3a88109b5339f296ef/tools/perf/perf.c:349
    #24 0x55dc679dd335 in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-ef92c4351ec75bcfb8a1cc3a88109b5339f296ef/tools/perf/perf.c:401
    #25 0x55dc679dd88b in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-ef92c4351ec75bcfb8a1cc3a88109b5339f296ef/tools/perf/perf.c:445
    #26 0x55dc679de032 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-ef92c4351ec75bcfb8a1cc3a88109b5339f296ef/tools/perf/perf.c:553
    #27 0x7fed3fcdcca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)

SUMMARY: AddressSanitizer: 42105 byte(s) leaked in 9 allocation(s).
 68.4: Exclude disjoint subcmd names                                 : FAILED!

> 
> Thanks,
> Ian
> 
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20260120/202601201519.ce4c3ab3-lkp@intel.com
> >
> >
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> >
