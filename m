Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BC551004;
	Thu, 11 Jul 2024 08:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720685085; cv=fail; b=ZHL2QA6zESQg91VL2+10C4qCQIvSyXOtDPKP6KIZY48Eheyvb5T4nUUkcD+jtckabXT9YBU+tbnFICbkdZX4+SZiCRIcvlYtYFbkyZZLhrF+3e/PVUFua4X5VKAfDX9d4RT1lGpoBKt6enp+GEccrpSZLza24XLHHQI+w50DYxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720685085; c=relaxed/simple;
	bh=V3ZesiZVLcoBda2+Itk4vEUzoawRAHqxhJf1E99IA6c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Mx8YFHmeDLzAH10Hh0zzYXGd6LFN0/6bOHRZf41lyuezHERO/k7rqhOghb6FL7m8MPR6MJckH6Bv4+wOeZJHRe9bNjDgZMJcM73YrawCUHxMedEPlnWwYXhllFe8ulrq2oW0F77+TulGas2wzY/+aa45LOhGG4oHqSADmicqMfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z1kPoe2S; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z1kPoe2S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720685083; x=1752221083;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=V3ZesiZVLcoBda2+Itk4vEUzoawRAHqxhJf1E99IA6c=;
  b=Z1kPoe2SzYZimUbfaDrpUznmzJdA69ETfckeo0BwEEUX50cpt/TZBY6Z
   9G4GJUgzWvj93Dv7aGK7rwB+iDUEiaPsHj2FkzGAPoV/ygMNTv2GLW/0b
   uT/PtfP5cMPhZ/8vahtjul9uiAwxxzk5/3kbhi4UKUVDkCEMQRrHyIKbG
   qxVpWtxEAW/pZjaqjKHrh+jj3QBGc5J3nvm4a4xUTL34E3VnxZHHjAMl6
   vn6t+OXoRxIvWvVulTKZyi/rRiqh8qe+Gnl9GyqBdwdWLnln0KKu3XN5i
   2P8jeucP334o46aYwY/JlJVXHBoHExbTwj/qtJ9HQGQ/PU3DTVK/yQiYB
   g==;
X-CSE-ConnectionGUID: CNbZqMi5T1ugXNcc2JblIA==
X-CSE-MsgGUID: cJNrFC1YSmCnD6tNwM7Isg==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="40563528"
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="40563528"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 01:04:42 -0700
X-CSE-ConnectionGUID: 933VpVU/TdCfi3XSfPIk8A==
X-CSE-MsgGUID: KAxajxzMRhSMQjLMiU0jRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="48920199"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jul 2024 01:04:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 01:04:41 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 11 Jul 2024 01:04:41 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 01:04:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v0rbqfJ2uVdVBsczIdhMmpw4ninrF5bf3q8aL5xKvNOGRwoMvwC6EFKeg601EMyubtMs3v8QwCspK5Uizc02E0n7KhPp6Kylz1y660M2asaHfREEOcn0Wf8QbSUNaK4TT2buMjs3BIPBkWa1QB5cNBBl4ULisL5s7u8UBu6LNEjZuIW0eDgLqXhNSufeM85SIIC1LKIMEQ2Y9jPmYicU9Oygr67h8eh5BVaauxrVzp0r5lV8pS6be3X0mlwvLIAkPrU0naHYYHMW0eWC8jSM/uVP8DSxLoiXdvQZ/kq2veaBGdBtyFvrSVxqnDNtcRL7VFQoIUhsGNZU21Hp6Ybuvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OcBRfX+N825W9uJ7Lv+5zevhtJux2RUhYyV8Axt7lEA=;
 b=eoKmGMUy2fMAybxYIhtHEA1jZX3K5ZFWEWdiWH3vH0+yg94aYWOcS1i7WrM/uGP6QtTnmrqbQGGpAYn+NrMzTOfdpSrQhwHIbdi8CwMyTSG6xPqEXcQUWeTzcoQ3i+v0RBwPOKvCSTAN/lNXYGqetYvpiuMJgPQoVbOFJO6at4cYc+Qmo2O+8zTk2t9PuEsYfoZFNqZzStWCtOZPNx+UBKiYuLQvQ0SzqlnSUABy3nuenaHdjy1cQ6JOYlyB8/+wI4eTwFr8tP33bDH40ZRyI5zjwT9wecnWhqI0pkXivlPQp89kHR8c7D7CW7PUjpT7c8vARLICOjnO0DDaJFpuWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA2PR11MB4859.namprd11.prod.outlook.com (2603:10b6:806:f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Thu, 11 Jul
 2024 08:04:38 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 08:04:38 +0000
Date: Thu, 11 Jul 2024 16:04:27 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: "Liang, Kan" <kan.liang@linux.intel.com>
CC: Ian Rogers <irogers@google.com>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, Linux Memory Management List <linux-mm@kvack.org>, "Namhyung
 Kim" <namhyung@kernel.org>, Weilin Wang <weilin.wang@intel.com>, Caleb
 Biggers <caleb.biggers@intel.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [linux-next:master] [perf vendor events] e2641db83f:
 perf-sanity-tests.perf_all_PMU_test.fail
Message-ID: <Zo+SC/OORdGWXQ84@xsang-OptiPlex-9020>
References: <202407101021.2c8baddb-oliver.sang@intel.com>
 <a0ac56fc-eedc-492b-884c-d68e0460f178@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a0ac56fc-eedc-492b-884c-d68e0460f178@linux.intel.com>
X-ClientProxiedBy: SI2P153CA0024.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA2PR11MB4859:EE_
X-MS-Office365-Filtering-Correlation-Id: d9cec84c-7bd6-4271-0c29-08dca1801c81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0b360wD0gkJ9B9/Xh+UIYPPnVihNKCwHxHFaSt5DxgR86pFS38k48ZOfaSj0?=
 =?us-ascii?Q?uGilbbtpM8Th20CjcYhz/t7ldPqiT5LTM3fwJkIyLEUQjbL2eyOlsQ/h0nxN?=
 =?us-ascii?Q?6XzoFa7y+YxwnP3Gk0uAOYAIFX/4YG1v98gxtEuGlTAf1CnadnzkVKfydy2J?=
 =?us-ascii?Q?JlnDVAdb75w2ym4EKHZUNqoSHI6QKtmaMy/fy9fF65qZrjmSiuU86tm6FXeY?=
 =?us-ascii?Q?L2XhvMksl7FLLEWTMhhpY/caPTLQKbTQ07WbllW+ZEOUhIsp3fYrmOQn3bEK?=
 =?us-ascii?Q?ohzhmkdQQ+FjvmUyPHmuYnlgkU3sF0zSJxgSic0zbwOfSFC+7RwuRzvtiVZW?=
 =?us-ascii?Q?id/y1t3irt9yoSSlzaKfbuv+x81nqdTe/yWOaBAYFVT+1cVLp/Pk9jtkAnos?=
 =?us-ascii?Q?JmerKtseALlMiEjjRmnSkor6y6RU2gygxlcNaiPDWGM3Kusl4kxHvcd6byRJ?=
 =?us-ascii?Q?KhbJqX+C9oGXdUriQE8n5aKMLGdbWn3rKANqK9B7drfogzaQS0SG9vxsT+gH?=
 =?us-ascii?Q?n8fKgVWelrKOw7XKEze22LXRixTXyDFWiT/tB608OCJBJxTZlP4J26ZFcIJ/?=
 =?us-ascii?Q?wuUYQmjdN1nJwCS8QmMeVyhfdq3633cX81aZ/cfca0aHpmK0vpwLbKbx/i5M?=
 =?us-ascii?Q?JRcyHdsP61jBsczGlIGH49QDjMgtiaPhrqvIkf2yxsWvbnQUpVkU6zQHdkXl?=
 =?us-ascii?Q?WpRsZEukG0gZnHxrfizxj93JdlWOftqaV6kbrd/gT6Ona6n/0KDz6P0Z6+83?=
 =?us-ascii?Q?eCqb54Bjea72sfjz1M3/XL9vO3RHE2GnRbeJsbWswykeKC2Ae/ERJYt4NWcr?=
 =?us-ascii?Q?O1dvuP6ltKFjkRuI76oT5KyfJyfaDYFR7C+RJ4MJGsqUPqMpoRKzWVvWNWcn?=
 =?us-ascii?Q?0BX1yuMvdnwSUAtyXrakH5wJkT5nhQ3z6TkjT1A0cLQj5J+I978n1Kp07hRP?=
 =?us-ascii?Q?9W3wHCAFGlz8GHXDFLSqfHLXvmw+KuSFKQSo4WtLzdfC7SR1hqcdyJT4uMYj?=
 =?us-ascii?Q?h9PLE+FNvhtC+s/yK1QbZEcwYMdModYTBuzAMabrZvRlNdF0u2YpfNjmv5dn?=
 =?us-ascii?Q?InFJh0lKsQxo6vbSo/FGq/G4dO88m4V151anpcmF3MiCmDOfb4FuDgIzV+Dh?=
 =?us-ascii?Q?h6Cg3Y+i1XkexOy29yQQ9iKE/RxgfXT0LMIv+3RUfBNcUxPebtbkv5UdqR2t?=
 =?us-ascii?Q?CTWN9PVIPF7+d0S9tPfSfP+zwZLWm21Kdmk8UTzpukfQ+l3exw916ZuFDuV2?=
 =?us-ascii?Q?Bgs+BvV2EpFS58XQK7khtsQp4T9d3FVElTKpOcUl9NDcrals8FULdoO6K50W?=
 =?us-ascii?Q?eLo2CpPQUBHe3g0lFKvIjJ/R?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aPpytb4+Kww1phpm6NKf3gUhlPPBgpvaQQqmaXa8yhFa85bKY+XQm3a2yqt2?=
 =?us-ascii?Q?2RY4Ax8MwdteUHbBlmj7Ks3tr4DN7lNoZtu1U4cvyz2hdxyPl0Yh1BL6CmUN?=
 =?us-ascii?Q?Xb3V1YFAGRCpo44Sf5FKb9+gWo14a6/1mhotA41sRxrfwZDHLy5I/9JYvE9W?=
 =?us-ascii?Q?AORQ/3f+xkB/5dVggvdvGunlCux6NRkz2rGpAfRT6qJ923vlD77jXpkgopjk?=
 =?us-ascii?Q?x2yckNXe0EKn++MscDSZWfhFRbleNMoqMbH7hYsQ6PxdIbrLG8Sb0IzhcJNj?=
 =?us-ascii?Q?HWaCS9r9i0ZkUp0EG667/K6twA1BYolXKkIogLnWbH0GGF2+V6SdctbbK7St?=
 =?us-ascii?Q?FMOgHx/TZJjvV3xZHMAXPQoUq9qXoGO1IF/D1wNCXYhAUH78sIticKSaWblL?=
 =?us-ascii?Q?IUecCHHUwK0VQJVkp+osaOTUUCFtFoDzT8chIULXljRFNQfsxitWklc9Y3ip?=
 =?us-ascii?Q?fGeZet3NAAgAERkWg07kqjQxRrVHDoEZTronU/Pu/FDj5ILxKwlpkcJm6f5i?=
 =?us-ascii?Q?RHMms9HEUu3ClAo3kgriMhyozZkVeJ16We8KFJPED2Vie3iKu6eLw1EKab5r?=
 =?us-ascii?Q?ShDY53kkZK45uCLosFmO4SwmKr58zETGjKmSHYzg8BouwVwoA803qhgbsEHi?=
 =?us-ascii?Q?JzEcwcKtM7BaBubgWBpQA10zZDGWdUX4hdINjR+zj0VEay9NGmkLRoEKY3Je?=
 =?us-ascii?Q?gGSuKPhQJccgPOiXALZ4VmIoSHPy/uA2eRJTXv07KL08+Fx13umTzZSId6Ul?=
 =?us-ascii?Q?NNhEXQco8mkhT285syKvNJAx18pFcL1/aEzpP6qdTeRHFUwC/j+tunq+4Zvf?=
 =?us-ascii?Q?8CSrNOTePOHbx7pDL6iRbwbuOxPRy08A+XuDMSM7we9zDsz6OA3Ehg9NPnfC?=
 =?us-ascii?Q?7fhayXw1Zh1TaqY71r2xvpQroOshgOvlssVkjvoAdhhsbg+L832m80jxX2LI?=
 =?us-ascii?Q?KXRWx4YURDVpw4dcARwNXSdCBnhVIg7oQuWpMBuRhrZKe+K/JIuUyS1774Wh?=
 =?us-ascii?Q?sV2ok7SvgW7L1SM009AQJLr/2uN8fnH8rTuyzpmu1Gpo+m/pBUZB+qwx1vQu?=
 =?us-ascii?Q?HOGH+ncn7TD0KLqX+N7q3EzZFKQ9Uef5E7ruZUnIS268inc9kCn+j3ewAC/B?=
 =?us-ascii?Q?CVJZ+asA1belnSqPcoPBaAdEqqf+zkQe+cyLGDjyBhJlRpyPkynaS4tyeklY?=
 =?us-ascii?Q?pL//Gy/83mUYJ2cTIhs1ql7n7bdDEVOnc4am/03AkRGEqp6iyzG4QJLPjuWz?=
 =?us-ascii?Q?5fXeRgYDmX5S1bELPmmdLyIv/WOUkPOA6yDDlNlO1Fj7fupa6CwjAd+rXBT9?=
 =?us-ascii?Q?sShRaIt9rghfyNkq5Z/qK6bdMZg9Cxest5/WIKSk1v6Q8kbWPLQmiAlvMz+U?=
 =?us-ascii?Q?zBxRhcnzqj5D5k7YbhUbTROG//s8O7pvO9TtQplMd7eWtGrb41DZY6qT1kDv?=
 =?us-ascii?Q?o/70/6wZVPKtdsRmfBoWXXE5ZaXxUKudjLIzyoG6WKxnsZruTsZMlo+p4g5u?=
 =?us-ascii?Q?HbBnmPeGHkkmwIcc06OIJpWWwitWNp/hL35XbVEx1VguxfIfAtFNQPs6N5sA?=
 =?us-ascii?Q?/Jto8eCXIW4hTSFg5HLmp25yJJYxBDfmhMdglmzyJTJ5Dewms4clX2BLPKo6?=
 =?us-ascii?Q?zw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d9cec84c-7bd6-4271-0c29-08dca1801c81
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 08:04:38.6613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 600VXvrD0KnTC/yKjDQboRvwcTHQK5dzh/r+TwwBKbVpjZuUivhVkfen0TCZbY9i1VGJO9YSPSQVFD16yfIO6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4859
X-OriginatorOrg: intel.com

hi, Kan,

On Wed, Jul 10, 2024 at 09:15:05AM -0400, Liang, Kan wrote:
> 
> 
> On 2024-07-10 12:59 a.m., kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed "perf-sanity-tests.perf_all_PMU_test.fail" on:
> > 
> > commit: e2641db83f18782f57a0e107c50d2d1731960fb8 ("perf vendor events: Add/update skylake events/metrics")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > 
> > [test failed on linux-next/master 82d01fe6ee52086035b201cfa1410a3b04384257]
> > 
> > in testcase: perf-sanity-tests
> > version: 
> > with following parameters:
> > 
> > 	perf_compiler: gcc
> > 
> > 
> > 
> > compiler: gcc-13
> > test machine: 16 threads 1 sockets Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz (Coffee Lake) with 32G memory
> > 
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > 
> > 
> > we also observed two cases which also failed on parent can pass on this commit.
> > FYI.
> > 
> > 
> > caccae3ce7b988b6 e2641db83f18782f57a0e107c50
> > ---------------- ---------------------------
> >        fail:runs  %reproduction    fail:runs
> >            |             |             |
> >            :6          100%           6:6     perf-sanity-tests.perf_all_PMU_test.fail
> >            :6          100%           6:6     perf-sanity-tests.perf_all_metricgroups_test.pass
> >            :6          100%           6:6     perf-sanity-tests.perf_all_metrics_test.pass
> > 
> > 
> > 
> > 
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202407101021.2c8baddb-oliver.sang@intel.com
> > 
> > 
> > 
> > 2024-07-09 07:09:53 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-e2641db83f18782f57a0e107c50d2d1731960fb8/tools/perf/perf test 105
> > 105: perf all metricgroups test                                      : Ok
> > 2024-07-09 07:10:11 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-e2641db83f18782f57a0e107c50d2d1731960fb8/tools/perf/perf test 106
> > 106: perf all metrics test                                           : Ok
> > 2024-07-09 07:10:23 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-e2641db83f18782f57a0e107c50d2d1731960fb8/tools/perf/perf test 107
> > 107: perf all libpfm4 events test                                    : Ok
> > 2024-07-09 07:10:47 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-e2641db83f18782f57a0e107c50d2d1731960fb8/tools/perf/perf test 108
> > 108: perf all PMU test                                               : FAILED!
> 
> Can you please try the -vvv option, which should tell the failed event?
> perf test -vvv "perf all PMU test"

after add -vvv:

2024-07-11 07:45:20 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-e2641db83f18782f57a0e107c50d2d1731960fb8/tools/perf/perf test -v 108
108: perf all PMU test:
--- start ---
test child forked, pid 18989
Testing (null)
---- end(-1) ----
108: perf all PMU test                                               : FAILED!


> 
> Thanks,
> Kan
> > 
> > 
> > 
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20240710/202407101021.2c8baddb-oliver.sang@intel.com
> > 
> > 
> > 
> 
