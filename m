Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CC48C11;
	Mon, 14 Apr 2025 02:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744596023; cv=fail; b=WyFPObSfNdtb88tOW4hhGXvtF9Du/kBuL7CYAmSA0Zmnjkt5L2ezO7som83L3f6NhLFX9muhB28vZbZXPKJnvK12VDmvqm0wE0a2Scg2tJzdb7nMRNQstSMaAAssf3FuiqTszgx+N+byouU2WNefTGSQVEdexeo3KruRWv0HgoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744596023; c=relaxed/simple;
	bh=6zyRbos5wFYSvuScEMeWpdpVMJyewGcLVInZQjj6VVo=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=UPOkniJP6jttPBaKLgsSShlhArfhz9x+xgVRrT+mYxv7fTTK+uoGCsen9G8Cmux/ce9BMvACt4rRC9MSNCcW7n7fQzeFGXvswjxzgRWZiwZvQEgbVb6Fi/Q32Mz0lSQHTivTJWhT0us3y6JefGAh1l4lW6w4u8xEHj/EzeerJY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KxP7mkNa; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KxP7mkNa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744596021; x=1776132021;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6zyRbos5wFYSvuScEMeWpdpVMJyewGcLVInZQjj6VVo=;
  b=KxP7mkNat4sCS0M2Y8o5qK9Eb7geQTr1vIQeWcVwRssI3I8ycwkgZDhC
   wUl2ovyfGbrugg/rY6wWBMEcW5pmrHXlMRQq186UaiJP7MgMA+ta7WysF
   uMnC0N9ZaPKFPEhPcMdXx1eLTkQgJvIWnniUHRwPrfHhvymgnBQtSpqBY
   F/UkfKWAfVdXvafh6FPUcxi9XqTMMgQzsMn8HcUqsraGrYnQ4B3BaXxQL
   mT1H0SKiHI74MIcGEMMdhUnNGECrLAXJ/rGCLr3bdfowh7urf+YHB4mKV
   rCgxokqKsZ6+2DKh6ecNBjt5NUe8Ty/RafTXF2sDydHKPhNGv6aoJzhqf
   Q==;
X-CSE-ConnectionGUID: eRFCTMpoSLy11JUvZ+8O4g==
X-CSE-MsgGUID: AYF3mnjTSIOzx0HPbXrPTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="57037471"
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="57037471"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2025 19:00:20 -0700
X-CSE-ConnectionGUID: 87EAcPfBSrCpatoQQG8MRQ==
X-CSE-MsgGUID: pTLvuHfnTHiKG1reE2ZpAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="129681522"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2025 18:59:51 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 13 Apr 2025 18:59:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 13 Apr 2025 18:59:51 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 13 Apr 2025 18:59:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DthLu+9eYwOs2KG+foX+hOLhRz6bheV3SMz2hGcdXyYnZNad3z8CbNK6gltQ/ex+OnFS02ItsklGZZODkzbOghtO49VolgW4jtlTk1UnsdZi9mjmcUFSYgUMHJNWDFHFTciCMWmfKyjyX6Ykcxz5VMOlun+glik0JJCaUcu/GcMLPzTIZsnnDZk2h14YxVCgb0+lQeaKsWo61o85/g5N85l+FaCNC3eE1PWTmrc/anvFUHpwU3NI//2rq7N0IEEtB+5EnZmkgKNOIEM4Fzsuy6YEZUGSVaHdZTnoUWKW6slxg4WTHFTyCAE5R2mKYpNO14IHaUOB1hfpTbTBeDak4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wthry9eZG9M7aZYo0rEbRdGvOkCZiKpmhLqt48eZrvA=;
 b=ALo8O63Qs85REl81eXE7Vt8+f8w8VTq1ynQLzEHGQOCNijsZp1Ff4vNd124OE5yn8vProOOMOdxc0TwzaG8hmQAvz1B+WqPXU4yqqoO+yso9HuzVPEcHQRuNC98szaPlOyb+rE5Dfa0JmTTS7BCXX8TlXJQR70nwkrdD2pfSnzbnBoLpfwdXPXRnAH74wcTQLaeIfyRog0VyUX4y7n5AVPg8Nma/B2WQhY2eCYpojm32hpNpT7Jb/GMuyDG79KGO/h/f0cc+pmJtFoO5iD8PB8K4NrKE7uojhV2i8EG9Vfhmq/g9YpdUTh/ofA0vADdwYOv91j9Qe1h8/jrY+PLKDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW3PR11MB4713.namprd11.prod.outlook.com (2603:10b6:303:2f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Mon, 14 Apr
 2025 01:59:35 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 01:59:35 +0000
Date: Mon, 14 Apr 2025 09:59:25 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
	<linux-perf-users@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [tip:perf/core] [perf]  da916e96e2:
  BUG:KASAN:null-ptr-deref_in_put_event
Message-ID: <202504131701.941039cd-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW3PR11MB4713:EE_
X-MS-Office365-Filtering-Correlation-Id: 41155a90-5c5e-4d11-bbc2-08dd7af80119
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?B6wwt9KydFWO4nvbp1Tq6eHNV/A9gkAiI2DSJDyRxhqkanxgO2to+MZaHfFA?=
 =?us-ascii?Q?fH/EYtfjaliXvUEvD+pBC3bwsOsRvNWYRmmVZkd4S28kxPoFWrL8/h+VSjqm?=
 =?us-ascii?Q?m6tjPQmXDAxUjYAIRDX/ep/WlyYnAFwqdjw0snOW/Zj6bl2GbL3tKRKmG0oA?=
 =?us-ascii?Q?xNfUEI2yS8KHOH5uaJ53c2ModmWuoZjCZwSSnkXHI/sxx17cv557GZtew499?=
 =?us-ascii?Q?I0G6Xb1iuwWqNJDMNSA1/j/Bj1Fo7NLRwrJdvtfUpsHeSgesT4/eon7LjB9c?=
 =?us-ascii?Q?FsvNMgCKBBT/N8MT86V7dirs8/eTeheIORQz+iY9iFzGpZrnfPGf43cW2iIU?=
 =?us-ascii?Q?hARgKJz5lRNwD1dIqjGNSPb5Pye26mRdd0o+p6miPHyNudtAXI7aLGouuxJO?=
 =?us-ascii?Q?1mBLdDJhVkXQLRZb2Zy9NlJ67V5DzrJGZZb0Af1/HiMvLqCHe0nvlQnwZZCI?=
 =?us-ascii?Q?0Qvw3PRQ3pfybBmZm5EjZLZ1kFQXgqzLj+7Nv3SqZWuyedadASUr5eXlIwtK?=
 =?us-ascii?Q?iNi3OiiZnUvIjYYLZsAqzVcUDVFd3fHuM+F4ajwuLcaUsPN+Uij+nvuYmdo0?=
 =?us-ascii?Q?N4AIQeg45ChI5IYFHl3wLgQ+VRBhhjY5AMCL5ewy85GQ7rUKNUccYaDPj3Kz?=
 =?us-ascii?Q?3Gf86S8aaJp9EbQStmfbbt3SVfGG9eNlA6AuU02iQt8FobsP6NMqP3W+S8XV?=
 =?us-ascii?Q?lP+rnGGRK2ocpGv/xW3u74mbBRKjM25NC2FDKLW4oYgstf0L0eS6OyElmf3j?=
 =?us-ascii?Q?WRS2KCpTZ1IergpERTK9i0hPwcIOMEkxXqyrkFXUEZEZ4XKJRPzVUZVG2pGO?=
 =?us-ascii?Q?ga8aJgKUA0TxoleX7bomhRZ4ZYt0X7sqBndmVM6C6rQfdAtA76XixMuzypss?=
 =?us-ascii?Q?K8AiPPryDG7BEWVvcsat3NZspwcsxc/3vp3d1BEU9QOdpSF1icrSifOVs5vG?=
 =?us-ascii?Q?5dEU9InYAoItQiQHLnhU6F8QuBs/Q2/EqWJ8cA5C76vEmrboE8YK2L2A62W4?=
 =?us-ascii?Q?Ro6IrV9UZCVRSLJeYRZREo1R0UAwN2E/kd6TPZfeX/YlLH+uq8RZVzcGroBE?=
 =?us-ascii?Q?T6yeNIDtoCOujaRVA9d1n5lVUx+5N6fseeWmqrBpX2JfvTb+HppKp7bSjOpZ?=
 =?us-ascii?Q?/g9ZdO6Ym13uTlM9NiXKIec8FKAf9Y9kdHrG+HNpWCAxFpGTOTXtDMqQ5DpJ?=
 =?us-ascii?Q?zmc170SBjFzCBuP8HjVVlUivXDkzfrDV58fHCo6Rv+l/eQWmszHN9/V0O6mg?=
 =?us-ascii?Q?6Pw1mW1FbYGzFT4d2Bgrd37LplHZj8V/lum7lf0RYABIpDpr2w2iOKhsqRTc?=
 =?us-ascii?Q?Ec1XVB7TCz7AqoByQiDKeekdb5bHQL29hL1WGDKxbCvZwPsxOFQzLrbGg+Ul?=
 =?us-ascii?Q?QduAAzg1SU68xu7/RWxXC9Xt17Fs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/Ngrit9ukiTMO9VzhxPOBJp0fU34KoKzROqjP2VeqXqG8snQkud7PcjVaqYb?=
 =?us-ascii?Q?6n0X4Rx8LWYEq6BehPtLn9c6/bomjowkofbZl9lHR0YrEXcyH+XcpnbTuaHG?=
 =?us-ascii?Q?yQr8GXsLzpf0Z+Ia5ROV/89jlMdWBup4kCEnaXRYl62BGPO9wb5HvOWWYd8K?=
 =?us-ascii?Q?NDf2j1OTUcy8/TJfLmF+jfe6aiGtBWtZjjVhSPf8xfoWVtxCwtKrDxKQaQMZ?=
 =?us-ascii?Q?KieRtU3rxmohKGs/WxB9n8HORdh2NlSer8EtQF0vUu9WTIyIyTjMu+V5p05N?=
 =?us-ascii?Q?dZ5HPO3Xl87bnZyCDof7sSuON/1baWUOktmcO1p12xv2asL+A+EAYTR8dMP3?=
 =?us-ascii?Q?SACcW7jk4sN2IJvMxY/0eV6ZqaS5jvQxeHfKlGBm1+qR+KQ7HO2AnbcoAO7K?=
 =?us-ascii?Q?3HBdtT6KDC5uWAdx5Jf1YEpx103qff2/6xz9GBiFgfZcNQ4Sr2hbwYUKnpKJ?=
 =?us-ascii?Q?Zo6D11bW7JuD8TBfexF8rlF/azfIc44N/yVBChaiqA7eJJyuo1orLE+5A7mq?=
 =?us-ascii?Q?IsXEIPzukNTw9W25iaKYRT691308iEJnHhoWTHUW1yGhSLrz5ehwQmdmBs9b?=
 =?us-ascii?Q?jilOLdmuRYtW7w6VTb3fHyTO5UYabokOJj0mTOGF2qYxexp+ZNmt4fpTalTQ?=
 =?us-ascii?Q?rG5NAEb1dd+AStkuYEyBgtBM72zgF8RApWIC3Uwi26dvtkGjOpuAYkCp87Za?=
 =?us-ascii?Q?h+WaJhtvCFeEgv+KkgIeBqKNnk4bcOZ0/KpypGe1SpKIAPzCkNdnhJiGQHI3?=
 =?us-ascii?Q?1h61uW8BO5wDMcDEh7jD97aA+mQS2M1dke2gUymUiv+raKo0nl8fYAyw0cHX?=
 =?us-ascii?Q?F18+UG14NIjU0tawIeJf/oKqHMb+DQPWHK0c63PsoJxuMWJoka9F9j7NKWqv?=
 =?us-ascii?Q?Ytjp5NaGlwxK5GU/Gs1T4jMQHdz54EH98xD4hgTCI/ha6sMAwsVBe2+W2VGv?=
 =?us-ascii?Q?U99ee+cjNPb+uygPD+RgbVQmzq9+H5UKKVnEwWRRcNjCo5SvAFS537sAED5+?=
 =?us-ascii?Q?yXuyUaRFPM7pxQ62hT3VuDH0fKJ4c/O333CEphYzBuVNwU7x8Js96zfW04op?=
 =?us-ascii?Q?Xg+pdWDO63wOGzgGYDWK9cOjBTH4P28WjMZw1nVchlR04pyi2t/euToqE+9Z?=
 =?us-ascii?Q?wIRI1CbrR+Fu8ZXzhggEN4cX5gIm4UzbjW/uw+xaus9EiFwNKEJujvkDaPsm?=
 =?us-ascii?Q?6Cxn2owpkGwVVN/50q3m2mm6fAzc6mLgs2E+QDKfTv00HxNEPSl+LHyfvjbE?=
 =?us-ascii?Q?b0tMUNA/OXGATplaNWkUSIMBa++2WTmEpNSDHIzmM110DK2Ao1U+6uaos0AE?=
 =?us-ascii?Q?hlUyVrQs0+nzKClOP/hYLp/oL+RpUv9hqWWJvkflYpn2gtBqv5OPmZGhMLUG?=
 =?us-ascii?Q?+He7arQG3u3mGMA76vK/nyi384Y28VbJMxI3N9UGYbHZjWSRcLQ09Fj4nDgS?=
 =?us-ascii?Q?G0fmZHkkqjUAw6X1sPR9I5woliiUW09V8FhFunLlWiel3qCeNrmbM65tkcBe?=
 =?us-ascii?Q?dOTzaexgGNWpr8tzwGCXO+fWYETJ0AiI7sR/o/E08GmWAp7fIOBhfa/ueWKV?=
 =?us-ascii?Q?8wvbqJh6WjFtIZBeQ5kU+9kqyuqr84NktwZpPbdTTPSzAda0/BmdmOtdsBD8?=
 =?us-ascii?Q?jQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 41155a90-5c5e-4d11-bbc2-08dd7af80119
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 01:59:34.9243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x3Ghz10+dfKBU68AeJ56SSI20V8s/o8XL73lowJfCh3y+Zd68CVbr65SXDRPv9WdZTPyepapSStwlU/4l5AWTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4713
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:KASAN:null-ptr-deref_in_put_event" on:

commit: da916e96e2dedcb2d40de77a7def833d315b81a6 ("perf: Make perf_pmu_unregister() useable")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git perf/core

[test failed on linux-next/master 29e7bf01ed8033c9a14ed0dc990dfe2736dbcd18]

in testcase: trinity
version: trinity-x86_64-ba2360ed-1_20241228
with following parameters:

	runtime: 300s
	group: group-02
	nr_groups: 5



config: x86_64-randconfig-078-20250407
compiler: clang-20
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202504131701.941039cd-lkp@intel.com



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250413/202504131701.941039cd-lkp@intel.com


[  100.647813][ T3900] ==================================================================
[  100.648676][ T3900] BUG: KASAN: null-ptr-deref in put_event+0x2a/0x730
[  100.649303][ T3900] Write of size 8 at addr 0000000000000237 by task trinity-c1/3900
[  100.650021][ T3900] 
[  100.650314][ T3900] CPU: 1 UID: 65534 PID: 3900 Comm: trinity-c1 Tainted: G                T   6.15.0-rc1-00011-gda916e96e2de #1 PREEMPT(voluntary) 
[  100.650323][ T3900] Tainted: [T]=RANDSTRUCT
[  100.650325][ T3900] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  100.650328][ T3900] Call Trace:
[  100.650332][ T3900]  <TASK>
[  100.650334][ T3900]  __dump_stack+0x19/0x30
[  100.650345][ T3900]  dump_stack_lvl+0xaf/0x118
[  100.650350][ T3900]  print_report+0x41/0x2d0
[  100.650359][ T3900]  kasan_report+0x15c/0x1a0
[  100.650367][ T3900]  ? put_event+0x2a/0x730
[  100.650373][ T3900]  ? put_event+0x2a/0x730
[  100.650379][ T3900]  kasan_check_range+0x2b3/0x2c0
[  100.650383][ T3900]  __kasan_check_write+0x18/0x20
[  100.650389][ T3900]  put_event+0x2a/0x730
[  100.650392][ T3900]  ? __free_event+0x707/0x7f0
[  100.650398][ T3900]  put_event+0x69f/0x730
[  100.650401][ T3900]  ? perf_event_wakeup+0x66/0x2c0
[  100.650404][ T3900]  ? perf_event_wakeup+0x1b3/0x2c0
[  100.650408][ T3900]  perf_event_exit_event+0xa6/0xd0
[  100.650417][ T3900]  perf_event_exit_task_context+0x44e/0x550
[  100.650424][ T3900]  perf_event_exit_task+0x1dd/0x2a0
[  100.650428][ T3900]  ? fpu__drop+0x131/0x390
[  100.650432][ T3900]  ? preempt_count_sub+0x218/0x2f0
[  100.650441][ T3900]  ? fpu__drop+0x131/0x390
[  100.650445][ T3900]  do_exit+0xa4d/0x2490
[  100.650449][ T3900]  ? _raw_spin_unlock_irq+0x38/0x90
[  100.650454][ T3900]  ? do_group_exit+0x1ae/0x290
[  100.650459][ T3900]  ? _raw_spin_unlock_irq+0x38/0x90
[  100.650463][ T3900]  ? trace_preempt_on+0x179/0x2e0
[  100.650473][ T3900]  do_group_exit+0x1be/0x290
[  100.650478][ T3900]  __x64_sys_exit_group+0x48/0x50
[  100.650481][ T3900]  x64_sys_call+0x2c68/0x2c70
[  100.650484][ T3900]  do_syscall_64+0xff/0x220
[  100.650493][ T3900]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  100.650499][ T3900] RIP: 0033:0x7fc7ce262349
[  100.650503][ T3900] Code: Unable to access opcode bytes at 0x7fc7ce26231f.
[  100.650505][ T3900] RSP: 002b:00007ffdecd6a3e8 EFLAGS: 00000206 ORIG_RAX: 00000000000000e7
[  100.650513][ T3900] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fc7ce262349
[  100.650515][ T3900] RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
[  100.650517][ T3900] RBP: 00007fc7ccbbe058 R08: ffffffffffffff80 R09: fffffffffffffff8
[  100.650522][ T3900] R10: 00007fc7ce1a0200 R11: 0000000000000206 R12: 0000000000000128
[  100.650524][ T3900] R13: 00007fc7ce18b6c0 R14: 00007fc7ccbbe058 R15: 00007fc7ccbbe000
[  100.650530][ T3900]  </TASK>
[  100.650532][ T3900] ==================================================================
[  100.673381][ T3900] BUG: kernel NULL pointer dereference, address: 0000000000000237
[  100.674119][ T3900] #PF: supervisor write access in kernel mode
[  100.674687][ T3900] #PF: error_code(0x0002) - not-present page
[  100.675251][ T3900] PGD 0 P4D 0 
[  100.675618][ T3900] Oops: Oops: 0002 [#1] SMP KASAN
[  100.676091][ T3900] CPU: 1 UID: 65534 PID: 3900 Comm: trinity-c1 Tainted: G    B           T   6.15.0-rc1-00011-gda916e96e2de #1 PREEMPT(voluntary) 
[  100.677189][ T3900] Tainted: [B]=BAD_PAGE, [T]=RANDSTRUCT
[  100.677704][ T3900] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  100.678670][ T3900] RIP: 0010:put_event+0x2a/0x730
[  100.679152][ T3900] Code: 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 41 55 41 54 53 48 83 ec 38 48 89 fb 48 81 c7 38 02 00 00 be 08 00 00 00 e8 06 14 22 00 <f0> 48 ff 8b 38 02 00 00 0f 85 67 06 00 00 49 be 00 00 00 00 00 fc
[  100.680761][ T3900] RSP: 0018:ffffc90004d67b70 EFLAGS: 00010246
[  100.681342][ T3900] RAX: 0000000000000000 RBX: ffffffffffffffff RCX: 0000000000000000
[  100.682061][ T3900] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[  100.682766][ T3900] RBP: ffffc90004d67bd0 R08: 0000000000000000 R09: 0000000000000000
[  100.686319][ T3900] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffffffffffff
[  100.687356][ T3900] R13: 1ffff11024ef368a R14: dffffc0000000000 R15: ffff88812779b618
[  100.694079][ T3900] FS:  00007fc7ce18b740(0000) GS:ffff888428dd7000(0000) knlGS:0000000000000000
[  100.695168][ T3900] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  100.695958][ T3900] CR2: 0000000000000237 CR3: 0000000004cd7000 CR4: 00000000000406b0
[  100.696932][ T3900] DR0: 00007fc7cc290000 DR1: 0000000000000000 DR2: 0000000000000000
[  100.702041][ T3900] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
[  100.703069][ T3900] Call Trace:
[  100.703563][ T3900]  <TASK>
[  100.704019][ T3900]  ? __free_event+0x707/0x7f0
[  100.704649][ T3900]  put_event+0x69f/0x730
[  100.705985][ T3900]  ? perf_event_wakeup+0x66/0x2c0
[  100.706648][ T3900]  ? perf_event_wakeup+0x1b3/0x2c0
[  100.707305][ T3900]  perf_event_exit_event+0xa6/0xd0
[  100.708809][ T3900]  perf_event_exit_task_context+0x44e/0x550
[  100.709677][ T3900]  perf_event_exit_task+0x1dd/0x2a0
[  100.710349][ T3900]  ? fpu__drop+0x131/0x390
[  100.710922][ T3900]  ? preempt_count_sub+0x218/0x2f0
[  100.711576][ T3900]  ? fpu__drop+0x131/0x390
[  100.712162][ T3900]  do_exit+0xa4d/0x2490
[  100.712728][ T3900]  ? _raw_spin_unlock_irq+0x38/0x90
[  100.717506][ T3900]  ? do_group_exit+0x1ae/0x290
[  100.718138][ T3900]  ? _raw_spin_unlock_irq+0x38/0x90
[  100.718797][ T3900]  ? trace_preempt_on+0x179/0x2e0
[  100.719458][ T3900]  do_group_exit+0x1be/0x290
[  100.720074][ T3900]  __x64_sys_exit_group+0x48/0x50
[  100.720714][ T3900]  x64_sys_call+0x2c68/0x2c70
[  100.721340][ T3900]  do_syscall_64+0xff/0x220
[  100.721946][ T3900]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  100.722683][ T3900] RIP: 0033:0x7fc7ce262349
[  100.723272][ T3900] Code: Unable to access opcode bytes at 0x7fc7ce26231f.
[  100.724109][ T3900] RSP: 002b:00007ffdecd6a3e8 EFLAGS: 00000206 ORIG_RAX: 00000000000000e7
[  100.725125][ T3900] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fc7ce262349
[  100.726139][ T3900] RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
[  100.727073][ T3900] RBP: 00007fc7ccbbe058 R08: ffffffffffffff80 R09: fffffffffffffff8
[  100.727935][ T3900] R10: 00007fc7ce1a0200 R11: 0000000000000206 R12: 0000000000000128
[  100.728806][ T3900] R13: 00007fc7ce18b6c0 R14: 00007fc7ccbbe058 R15: 00007fc7ccbbe000
[  100.729722][ T3900]  </TASK>
[  100.730174][ T3900] Modules linked in: tiny_power_button button pcspkr evdev input_leds loop
[  100.731230][ T3900] CR2: 0000000000000237
[  100.731791][ T3900] ---[ end trace 0000000000000000 ]---
[  100.731795][ T3903] BUG: kernel NULL pointer dereference, address: 0000000000000237
[  100.732199][ T3900] RIP: 0010:put_event+0x2a/0x730
[  100.732817][ T3903] #PF: supervisor write access in kernel mode
[  100.733228][ T3900] Code: 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 41 55 41 54 53 48 83 ec 38 48 89 fb 48 81 c7 38 02 00 00 be 08 00 00 00 e8 06 14 22 00 <f0> 48 ff 8b 38 02 00 00 0f 85 67 06 00 00 49 be 00 00 00 00 00 fc
[  100.733677][ T3903] #PF: error_code(0x0002) - not-present page
[  100.733686][ T3903] PGD 0 
[  100.735120][ T3900] RSP: 0018:ffffc90004d67b70 EFLAGS: 00010246
[  100.735548][ T3903] P4D 0 
[  100.735789][ T3900] 
[  100.736225][ T3903] Oops: Oops: 0002 [#2] SMP KASAN
[  100.736469][ T3900] RAX: 0000000000000000 RBX: ffffffffffffffff RCX: 0000000000000000
[  100.736653][ T3903] CPU: 0 UID: 65534 PID: 3903 Comm: trinity-c4 Tainted: G    B D         T   6.15.0-rc1-00011-gda916e96e2de #1 PREEMPT(voluntary) 
[  100.737053][ T3900] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[  100.737624][ T3903] Tainted: [B]=BAD_PAGE, [D]=DIE, [T]=RANDSTRUCT
[  100.737634][ T3903] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  100.738628][ T3900] RBP: ffffc90004d67bd0 R08: 0000000000000000 R09: 0000000000000000
[  100.739246][ T3903] RIP: 0010:put_event+0x2a/0x730
[  100.739740][ T3900] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffffffffffff
[  100.740493][ T3903] Code: 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 41 55 41 54 53 48 83 ec 38 48 89 fb 48 81 c7 38 02 00 00 be 08 00 00 00 e8 06 14 22 00 <f0> 48 ff 8b 38 02 00 00 0f 85 67 06 00 00 49 be 00 00 00 00 00 fc
[  100.741089][ T3900] R13: 1ffff11024ef368a R14: dffffc0000000000 R15: ffff88812779b618
[  100.741461][ T3903] RSP: 0018:ffffc90004d97b70 EFLAGS: 00010246
[  100.741877][ T3900] FS:  00007fc7ce18b740(0000) GS:ffff888428dd7000(0000) knlGS:0000000000000000
[  100.743537][ T3903] 
[  100.744014][ T3900] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  100.744534][ T3903] RAX: 0000000000000001 RBX: ffffffffffffffff RCX: 0000000000000000
[  100.745071][ T3900] CR2: 0000000000000237 CR3: 0000000004cd7000 CR4: 00000000000406b0
[  100.745279][ T3903] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[  100.745681][ T3900] DR0: 00007fc7cc290000 DR1: 0000000000000000 DR2: 0000000000000000
[  100.746350][ T3903] RBP: ffffc90004d97bd0 R08: 0000000000000000 R09: 0000000000000000
[  100.746828][ T3900] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
[  100.746840][ T3900] Kernel panic - not syncing: Fatal exception
[  101.916945][ T3900] Shutting down cpus with NMI
[  101.929723][ T3900] Kernel Offset: disabled


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

