Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8361C9EDC;
	Fri, 25 Oct 2024 08:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729845001; cv=fail; b=e8UEw1naHtNumZV6J4cwlFbMg5XKjEtpVeBiUxb+HAUYsHDH8w0pg9t29w5HmXI5ZjcVSfzPnjKOZkLgaB49enhyHDJro271CedbJtrvMTYemnHU/4WKDYCGFmVzdO/UTi2N+mdhq64S4ZDXI+Yjl7DGbeRlaKLZYZxui01j4Q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729845001; c=relaxed/simple;
	bh=PaGQeTwCplXAVj9pmasCLcSSO7va2Oze469tN8yC5DM=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=tYwj1Ozgl0SU9CRL/7jJ1ezhi+H5q6mzNR/Ac4dyGuQWmetnC02h/v/iUTcT+0UPjS2r6Bwk0ls7f/wImMfdxOwrDAPKyUMYMpXMlzm6RWjHO4oBqEdHh26J1DVJjMAscEbefOBMe1eIQ7r0fw9Y1rBqVxsAVze/wEVCIKzqtaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nli/0TJI; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nli/0TJI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729844998; x=1761380998;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PaGQeTwCplXAVj9pmasCLcSSO7va2Oze469tN8yC5DM=;
  b=nli/0TJIiilhJA8uIYbbudFetkLLS9jEtgVEYyHMRapXeC8qHvIBBdVS
   ggKdgqdDfwSLiT188S61XDNffXgJGwZi4uVpUOkd2yDT8ZBOTJSceIylx
   NnOAMc87MlkFIBlPWECc64QHNCqQvdYu592m4xzoKx/jBqHsHJC+AoLnc
   vPpN78sJltT+ECiULfmjmvdqcP2NJBLmbOEqcvbqE/djimiDamtLuAgtb
   xkeE8THhhAJFGuWNhrZ9Upm1eahiEBHqJg7WqyOJyGicRV5wjO/oqwLC8
   NZNROGhKM9jUIGDiMP4I6MZLhwk9ltL3XhfzXbs5ZrBCOBblPhHqkVnWj
   Q==;
X-CSE-ConnectionGUID: j4qaQ9O/QKOAuDFquszohg==
X-CSE-MsgGUID: +XeaUBbtQHy4rXm2BCyyYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="17138278"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="17138278"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 01:29:57 -0700
X-CSE-ConnectionGUID: PKpY+xkkRyG9TKRpvcNexg==
X-CSE-MsgGUID: 7Dbfx66GTWKCLccNyg5kuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="85434796"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 01:29:58 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 01:29:57 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 01:29:57 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 01:29:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B2xStaJ3TILazZEUFyPzHo01k5TPZMDc1djGQT5tiInlXx48fSpgaPT5SrgPTNJHwQerduc01kHIiHDL7/tO/BfZ0bs9Sd5RlaAzMvTB8nYomvs4nkXeIOYRFF7SWlUzGxBQWeCNgjzmBc10JZgGetqVQYeapONw39UE4zXJUusEsIpfHngoJMEvDKiaR8ShuI/jwtGlIzn4la26vR20gmlSM6b9nQE61Z2iRnIjpfzVPsjvOXOfizTbNnRFqrs39mh2ykDnWVs7+EX5XqxdRJtCRkdQ6DvqgkO6g0TndFRJHJt+B3OvKpo1Z5QwI5eJdbY/mUqQPlU6Y+yWEeGHNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRoaXky899g/kiooSdFB6xRNrR9PzjkN5XhT4gfftv0=;
 b=eV+OfkXccfPUdEtPORBfZcEMsFZsJdH325BC6DQ32VaxJwXouMpy7Wyp4fA7OR+KtMmckPifMIlxAVcZZI7sAoDXIqNUxRWHLrFvkA0PxFjCm4FYDs2vLS3PXhAIz1Tn5feQ1YvE68C7mDjQAio8Aw8qU9GwLBDK6pCwfvMrLB9+P8uAX53VknNpi4OmLvji79KcJX1Rb3n+vrugmoy0h+ErdtzjP/Kg6lgOaniq5W1BjG5nlvIKEUX3v0SSK79sw5VruPNZmZck50xIOM1DeLmhlm62WScbmVREsm9wEiWHOrpcRT9A+xfYBzcTPrjkRHo82WDZSSX1v50JUl1/wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH8PR11MB6902.namprd11.prod.outlook.com (2603:10b6:510:229::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Fri, 25 Oct
 2024 08:29:49 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 08:29:49 +0000
Date: Fri, 25 Oct 2024 16:29:40 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [peterz-queue:perf/pmu-unregister] [perf] d4700c3ee4:
 WARNING:at_kernel/jump_label.c:#static_key_dec_not_one
Message-ID: <202410251648.683b17b1-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:4:197::11) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH8PR11MB6902:EE_
X-MS-Office365-Filtering-Correlation-Id: db8e08da-37ba-478a-829c-08dcf4cf30c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rdlVvGtGBF6Y5Da61zTMTUh3GeKqMr6GMY3HcjCc1JgUp0FARwmwVfX0dYTe?=
 =?us-ascii?Q?xgvReBo99Oc2DPkgaacSWCM55TU4lfd3+Iy56ajkz0vcnv3M2J45JKgY1Nqb?=
 =?us-ascii?Q?qXxzkLuyheOfedvKreKP5QJFxlukXtJrznlh8fjV8KckmOnSnuq8kYreIEI4?=
 =?us-ascii?Q?ROzuYvo4/oVMJeRfgPn0ghG0zuQjnGFKpyTTT7K3lbKP0RO9rpZUBDjctEG1?=
 =?us-ascii?Q?tRG1+hHh9AVHH3NBPbfBKuxAdlpneJ2eNsboKxjvZj5iaWXPFE/kBLp9Lgu7?=
 =?us-ascii?Q?mvQwLiHhFRR/NsZ7SMDlYflsUomT8YNIpMZO8rwYEWxZRdajmLC1kWMW7aES?=
 =?us-ascii?Q?+DiohSnPbIRqtCLYJ5lB1cxvMNP4St0tfEXATjUc+m0SVkph7B9rALFW7+wI?=
 =?us-ascii?Q?CxWqsbWGueduvAT+9ONj6MEo8/ZEQPUIyyFZUpq0mw/taxkUh6iCJsoF/L10?=
 =?us-ascii?Q?i7EZlj5HEEQnm/HYAG1lsNEKjIpu3vfhPO3Oc3vhtiTQskXJ1MY+4HFOB2/l?=
 =?us-ascii?Q?gwMDSndIzFrYslIpQXynLQK9c75MhdsM15Fgb/1YeZD9SqbSGWrk/SeWkxDD?=
 =?us-ascii?Q?ijz6SZNnN70gxDeskcRhr4jkkTxphsLUjA7Ozz6Dri+siBLox6QYYjYmIAFU?=
 =?us-ascii?Q?AHNG+Kp8bCkHn+ipmpJDFszFWqlSDhpFslEHAoRnxK2A2xx9vsdPQs2NXeGr?=
 =?us-ascii?Q?S2CVvqhQ6xFitjFKZBrGbPFhCEFYtpZJlo9XpPpz2lh+ZxiHBj09/RDazLFG?=
 =?us-ascii?Q?jiohJuUiUtoWdRedaMH85DvD2NnjRgd0ncqKjmBsHTGrqGD13aXTf/kViZ+D?=
 =?us-ascii?Q?VS+19OFd4HrWuDR3B+bBaoG6/YSFBSRjqusG9rr6bNByMWTErFGjrKfDTySJ?=
 =?us-ascii?Q?tQlpRQLqj8qB3Vb9pC0+VUl13FJTgQgV5RWPZqRoBmvCPT8OoACT1+f3GGYL?=
 =?us-ascii?Q?6WpCgQxyT+/0Z0bgDF9cu666yEsT4xRfX390ZA+pVgUqp3r6fcXxcucIuvmc?=
 =?us-ascii?Q?CGzaIsIs7DaEtO237gT7GZZ1jK3MHBenCr3h4Zr4y2znjVNwmqvqkGDXhid6?=
 =?us-ascii?Q?Oin/w1nJfM2CkAgaji5Dg94xv35ZuuJHzdSOg9mOwX3AGk+/3lM5zl4JQO8z?=
 =?us-ascii?Q?6tkP/qDeeaBPo2SB70Qwg9kYqisWE1Fv7JiypnCGXdWxRXwRGMMjPMxi+lQ2?=
 =?us-ascii?Q?1f2in/Fk8XQ3gOL7g5ydjA/jOOFou9K5NjAiXLDqxAnHTxfX1vqnN0fHbN6e?=
 =?us-ascii?Q?BeOdq4CsI+aaVj0iFnktQmssYbi3kWqJW7UBl/rXTw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tD4iNhL7YG8gsnFOaZuGgYTnxFjObtoZulFMUqdfpg8MI/FtmlPA0GW+aLOr?=
 =?us-ascii?Q?rN/NmzTdt3dUjeM4dRsvHc3mKT+7W3W1FSo0bw8vbxTQvtQjlgFs1r3zK/DP?=
 =?us-ascii?Q?8xbiuZSUUCnSQ0jXZljSRat2KzijUEt02l6YyelM2erBwi5YkBRx8MrqBkKp?=
 =?us-ascii?Q?686h36F6ZlJRSURX/h6ByEL/Xu+FZ5g0//lCyH6TPoIzr1hgIOE70CV4VZjy?=
 =?us-ascii?Q?W9PaEWeWqkiF74KJQQxszzQMFTnRfIaX4ZIpvYIN8kERv8WVRz37mxiUapLX?=
 =?us-ascii?Q?RbLZk6Ei83aTXd3dxckHIU+oza84Eh89nWUtGQS0Ndh+yVRHF7qPEI6EJAGt?=
 =?us-ascii?Q?W8Jzw4QdfEqAusQke5zTwruG0LIX9zWFBwJxbiEqiNsURY3vxO9tETBwqjTG?=
 =?us-ascii?Q?ZmKssXNiVSC/LOtwJYb/ltqPbEsrGAQY2iuJsj8gUcj1D4P/eCTb1yv9hLTH?=
 =?us-ascii?Q?vgjFU5XyTN/AUXr2VbBGnk4gvpcsnjIjnQ3teBa/SJwhGdmscM9ftpdJLDqP?=
 =?us-ascii?Q?IhUPFOYqEKrTAEWUFqeYtbqNaWUIVRXueS90hzq2tywuHQPtotjagPQVzcml?=
 =?us-ascii?Q?3tVXiz9rIBLdqgkC6dyYWUiu6SM1583c6jKiA3Xz4rLhlwcouNiuWInZaVOt?=
 =?us-ascii?Q?C5ADrnaUZDG7w1OA0L6NdFaT/RJsd9TIkknysvMI2xubnVFQLsVKxSc8uots?=
 =?us-ascii?Q?wJT8LVZ1jdny4/k3AauvD6mRCoaE0jcrYDPvCgH46rUTmBIPUEqNbgUFQEqy?=
 =?us-ascii?Q?2yFhMiIBBTSL+MqbT+hIKfcUVKYLS3PCc7IwJ+PLiL5bl11VymLh9R6/+eq9?=
 =?us-ascii?Q?zGgMy57ERwoXY/N4YxcSBV+V23ERLby6DrLRCbxS6psK30gtqTyuau5rbgb+?=
 =?us-ascii?Q?5akUbW9gNQgv/aIqFd/lK5smSe1yfJYSbqbvmaxHNZMP9aE2qxBzAY0lBskM?=
 =?us-ascii?Q?JkM3GNNsWeYWdHXFMpWRr04wY/kqIg/CKj9eyhFiUvNdE4ikVyzkE+5xFyKI?=
 =?us-ascii?Q?lJfYmxag3eQetS5p3NS/wH0fSYfX/8MVsEh/TMYRKedlhGzpeqPs0Py0jPPv?=
 =?us-ascii?Q?pQXLCgQYclJSUx7MavHFWJniivsLVU5oqva7z8L/IQ28KSH0uPDLbJpG/dUl?=
 =?us-ascii?Q?oHPow4VYa96aBRkYHsJaRGxODV5+csLCBqsfy9V50yRi9I0ZUgIouEBKP7Dg?=
 =?us-ascii?Q?JUwDsKQ1E2d8E4V/9yxG6RMnkZNtwc+7iMLsPekg81ZmlAwfXsLpeHL1XEEG?=
 =?us-ascii?Q?QH/pbja3VnQcP3gXMPzlwabEIA4FH4SEr1zRfnczH2zdi/swXAzQo6Yvql01?=
 =?us-ascii?Q?+nKrffsBMtICNX3QOErzAWsRD7GsyP1MnM/3MAcK6Qf8Nd8harN0apxJiagA?=
 =?us-ascii?Q?tGZ6zKNN9uWjYX2S3Q+8ku3w25wjhSmaPQtnApSA/h3ckN7/fjuGLSnO6T3I?=
 =?us-ascii?Q?irq2vhLErXeHse3u1kN/Ensft32sFGLdMTp0ADV0uc1dJ86J2ugEsGqQUodk?=
 =?us-ascii?Q?xKvV3Fao2Ldu+PtH34YzvixegLJjXf2xAQ1fZR5MmW7fOIga+GHlmatf283/?=
 =?us-ascii?Q?7Yzqjq4M8QHOPCi3Y7SS9TrKKDQ26fNJse3B//I//RRCpBMLF5re1cqVe8ET?=
 =?us-ascii?Q?XQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: db8e08da-37ba-478a-829c-08dcf4cf30c6
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 08:29:49.6662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +RXJiTQEmQCpNwsbsRzJPy0kKCeD39g0sZX09osk6RnY4aramzf3gGbyv/ngnbI4BNYtUKQojKMFwgy/8L1wmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6902
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_kernel/jump_label.c:#static_key_dec_not_one" on:

commit: d4700c3ee4c19fc8ff8925709b3227ddb9b64b1a ("perf: Simplify perf_event_alloc() error path")
https://git.kernel.org/cgit/linux/kernel/git/peterz/queue.git perf/pmu-unregister

in testcase: trinity
version: trinity-x86_64-ba2360ed-1_20240923
with following parameters:

	runtime: 300s
	group: group-02
	nr_groups: 5



config: x86_64-randconfig-073-20241023
compiler: gcc-11
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+--------------------------------------------------------+------------+------------+
|                                                        | 07dec8f2ff | d4700c3ee4 |
+--------------------------------------------------------+------------+------------+
| WARNING:at_kernel/jump_label.c:#static_key_dec_not_one | 0          | 5          |
| RIP:static_key_dec_not_one                             | 0          | 5          |
+--------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202410251648.683b17b1-lkp@intel.com


[  287.833484][ T3554] ------------[ cut here ]------------
[ 287.834530][ T3554] WARNING: CPU: 0 PID: 3554 at kernel/jump_label.c:282 static_key_dec_not_one (kernel/jump_label.c:282 (discriminator 1)) 
[  287.836443][ T3554] Modules linked in: crc32_pclmul ghash_clmulni_intel sha512_ssse3 rapl intel_agp intel_gtt psmouse agpgart tiny_power_button button input_leds fuse configfs dmi_sysfs qemu_fw_cfg aesni_intel
[  287.839884][ T3554] CPU: 0 UID: 65534 PID: 3554 Comm: trinity-main Not tainted 6.12.0-rc2-00019-gd4700c3ee4c1 #1
[  287.841724][ T3554] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 287.843605][ T3554] RIP: 0010:static_key_dec_not_one (kernel/jump_label.c:282 (discriminator 1)) 
[ 287.844669][ T3554] Code: 83 c0 03 38 d0 7c 0c 84 d2 74 08 4c 89 ff e8 1d b5 0e 00 41 8b 07 4d 8d 74 24 e0 41 89 44 24 e0 85 c0 79 04 0f 0b eb 40 75 07 <0f> 0b 41 b0 01 eb 3a 83 f8 01 74 32 44 8d 68 ff be 04 00 00 00 4c
All code
========
   0:	83 c0 03             	add    $0x3,%eax
   3:	38 d0                	cmp    %dl,%al
   5:	7c 0c                	jl     0x13
   7:	84 d2                	test   %dl,%dl
   9:	74 08                	je     0x13
   b:	4c 89 ff             	mov    %r15,%rdi
   e:	e8 1d b5 0e 00       	call   0xeb530
  13:	41 8b 07             	mov    (%r15),%eax
  16:	4d 8d 74 24 e0       	lea    -0x20(%r12),%r14
  1b:	41 89 44 24 e0       	mov    %eax,-0x20(%r12)
  20:	85 c0                	test   %eax,%eax
  22:	79 04                	jns    0x28
  24:	0f 0b                	ud2
  26:	eb 40                	jmp    0x68
  28:	75 07                	jne    0x31
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	41 b0 01             	mov    $0x1,%r8b
  2f:	eb 3a                	jmp    0x6b
  31:	83 f8 01             	cmp    $0x1,%eax
  34:	74 32                	je     0x68
  36:	44 8d 68 ff          	lea    -0x1(%rax),%r13d
  3a:	be 04 00 00 00       	mov    $0x4,%esi
  3f:	4c                   	rex.WR

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	41 b0 01             	mov    $0x1,%r8b
   5:	eb 3a                	jmp    0x41
   7:	83 f8 01             	cmp    $0x1,%eax
   a:	74 32                	je     0x3e
   c:	44 8d 68 ff          	lea    -0x1(%rax),%r13d
  10:	be 04 00 00 00       	mov    $0x4,%esi
  15:	4c                   	rex.WR
[  287.848166][ T3554] RSP: 0018:ffffc90001c9fbd8 EFLAGS: 00010246
[  287.849416][ T3554] RAX: 0000000000000000 RBX: 1ffff92000393f7b RCX: fffffbfff0a1eb45
[  287.850773][ T3554] RDX: fffffbfff0a1eb00 RSI: 0000000000000004 RDI: ffffffff850f5a20
[  287.852296][ T3554] RBP: ffffc90001c9fc40 R08: fffffbfff0a1eb45 R09: 0000000000000000
[  287.853673][ T3554] R10: ffffffff8145e5ac R11: ffffffff850f5a23 R12: ffffc90001c9fc18
[  287.855035][ T3554] R13: dffffc0000000000 R14: ffffc90001c9fbf8 R15: ffffffff850f5a20
[  287.856516][ T3554] FS:  00007f77a3aed740(0000) GS:ffffffff834fe000(0000) knlGS:0000000000000000
[  287.858053][ T3554] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  287.859312][ T3554] CR2: 00005597f0734028 CR3: 0000000116316000 CR4: 00000000000406f0
[  287.860753][ T3554] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  287.862184][ T3554] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  287.863597][ T3554] Call Trace:
[  287.864232][ T3554]  <TASK>
[ 287.864777][ T3554] ? show_regs (arch/x86/kernel/dumpstack.c:479) 
[ 287.865664][ T3554] ? static_key_dec_not_one (kernel/jump_label.c:282 (discriminator 1)) 
[ 287.866597][ T3554] ? __warn (kernel/panic.c:748) 
[ 287.867328][ T3554] ? static_key_dec_not_one (kernel/jump_label.c:282 (discriminator 1)) 
[ 287.868300][ T3554] ? report_bug (lib/bug.c:201 lib/bug.c:219) 
[ 287.869181][ T3554] ? handle_bug (arch/x86/kernel/traps.c:285) 
[ 287.869961][ T3554] ? exc_invalid_op (arch/x86/kernel/traps.c:309 (discriminator 1)) 
[ 287.870811][ T3554] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
[ 287.871907][ T3554] ? static_key_dec_not_one (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/atomic/atomic-instrumented.h:33 kernel/jump_label.c:268) 
[ 287.872864][ T3554] ? static_key_dec_not_one (kernel/jump_label.c:282 (discriminator 1)) 
[ 287.873795][ T3554] ? static_key_dec_not_one (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/atomic/atomic-instrumented.h:33 kernel/jump_label.c:268) 
[ 287.874700][ T3554] ? static_key_set_mod (kernel/jump_label.c:254) 
[ 287.875732][ T3554] __static_key_slow_dec_cpuslocked (kernel/jump_label.c:297) 
[ 287.876874][ T3554] static_key_slow_dec (kernel/jump_label.c:337 (discriminator 3)) 
[ 287.877765][ T3554] sw_perf_event_destroy (kernel/events/core.c:10232 (discriminator 3) kernel/events/core.c:10245 (discriminator 3) kernel/events/core.c:10305 (discriminator 3)) 
[ 287.878723][ T3554] __free_event (kernel/events/core.c:5338) 
[ 287.879557][ T3554] perf_event_alloc (include/linux/err.h:41 kernel/events/core.c:12393) 
[ 287.880509][ T3554] __do_sys_perf_event_open (kernel/events/core.c:12802) 
[ 287.881560][ T3554] ? perf_remove_from_context (kernel/events/core.c:12696) 
[ 287.882663][ T3554] ? rcu_read_unlock (include/linux/rcupdate.h:347 (discriminator 9) include/linux/rcupdate.h:880 (discriminator 9)) 
[ 287.883569][ T3554] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 287.884565][ T3554] ? lock_release (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5848) 
[ 287.885498][ T3554] __x64_sys_perf_event_open (kernel/events/core.c:12693) 
[ 287.886445][ T3554] x64_sys_call (kbuild/obj/consumer/x86_64-randconfig-073-20241023/./arch/x86/include/generated/asm/syscalls_64.h:299) 
[ 287.887311][ T3554] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
[ 287.888193][ T3554] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[  287.889316][ T3554] RIP: 0033:0x7f77a3bf1719
[ 287.890122][ T3554] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b7 06 0d 00 f7 d8 64 89 01 48
All code
========
   0:	08 89 e8 5b 5d c3    	or     %cl,-0x3ca2a418(%rcx)
   6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   d:	00 00 00 
  10:	90                   	nop
  11:	48 89 f8             	mov    %rdi,%rax
  14:	48 89 f7             	mov    %rsi,%rdi
  17:	48 89 d6             	mov    %rdx,%rsi
  1a:	48 89 ca             	mov    %rcx,%rdx
  1d:	4d 89 c2             	mov    %r8,%r10
  20:	4d 89 c8             	mov    %r9,%r8
  23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
  28:	0f 05                	syscall
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	ret
  33:	48 8b 0d b7 06 0d 00 	mov    0xd06b7(%rip),%rcx        # 0xd06f1
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	ret
   9:	48 8b 0d b7 06 0d 00 	mov    0xd06b7(%rip),%rcx        # 0xd06c7
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241025/202410251648.683b17b1-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

