Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891C8264A65;
	Wed, 23 Jul 2025 06:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753251977; cv=fail; b=Jeply9iyvKQS9DiQFPG5dJ2lJHT5vbDwbkTwVbxWN+bgMd+NegwiqrgXdXum54ebGq3XOR7zZmecpXVcL04MEhRQhVLVoxEmWmMxmqC7jeeclSlMf4WmgBdgZ0CuORb2e+xFXr8OmQmIGaU+XLDbfc8wg0zjX9KiEhOFxrJ1+WU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753251977; c=relaxed/simple;
	bh=ii2q8Cxq6e1VzyE7RGQ536qxvPpTpj0EykcIQ5xoNKc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k9W5IrKgbd8kFLA77kVyVpA4zk8fioJya8urCU1JNaY6ZQEo+ANiTo61UscerlHsot4wWSLXO5IHeRb/4Oy4XxyCqSWkVFu5kgb9XbtqSuQnJGR5746hXIqpMLoaV5id8V1Hk2Q8axTbXLg3WbADM7a/pYzCV20z0OtYkAl2+FQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h1gJpHtv; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h1gJpHtv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753251976; x=1784787976;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=ii2q8Cxq6e1VzyE7RGQ536qxvPpTpj0EykcIQ5xoNKc=;
  b=h1gJpHtvsG4vo03AKIyxsqT1U7nHYM7JXDua9pzEDqduGoLnyWZL15WM
   zA4gPiVF3AI7ZOpMnsTbKiail6hUr6pV9prNUCWtTmJYfaKuHGCnmqIPu
   iQrRRyZvcihYKW6hky3pu/cddvbu1+Aj9J3PtxSfgdbbB/eod2MFrpjKx
   03KIwkCAPb2lFuMG9peOmMyKKkXbTgV9dkzFEVeXCgN/ae45YD33PNwnk
   /I858EAyyISoW6EBbX4rNMN/bVTrvLLspGRWNq+ltYSL/wLp2YKEytc5k
   Ygte8wbRPfiv755kcuaxffEnltj7wKt2jZ7WDl34mERpnx1qLi0LRHRAP
   A==;
X-CSE-ConnectionGUID: LmoCJ/TnQuWcIdYAT14Xdw==
X-CSE-MsgGUID: ceXnP9YrTteo7gznG4PptA==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="55476855"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="55476855"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 23:26:15 -0700
X-CSE-ConnectionGUID: Je50QWagSJGMUQDp811CEA==
X-CSE-MsgGUID: my7nUnGlRN6s2QpNYqxd3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="159912460"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 23:26:15 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 23:26:15 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 22 Jul 2025 23:26:13 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.76)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 23:26:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L39+qgAjC3B+LW3kZYoxinHQq/yItsJrWo7dV/JMTghF9TIzgULyI5Ax3oRUO/9fOUI0AOjTJ6FYm8HhyIhJPrSd321ehK1yFWMo4E/hODHN8sfQjiKeYMIonSuKGc8TXjwDyrDMf2tENcqMtaPolyoJnfR/bWLV7xW2nBSq03Q9ONyr2uP0DuCm3k1a7CXWbnoujOvtcr99dYPl7u5wd+KUwftRFYh42wY+i7iE53xYOP4s0EF0N4VuXNWLR64kgocSvJCyyMUazVxlZtfLW4xmU/g+67FQRyu/QKGf+e/+KvTWcd1ZC6PBi+SlpA48OpIdjtZ5LDzTLGFuKlJznw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOwcIgrcFpbovpenBmZIz7QKjOuOyhyeq4534woVVM0=;
 b=TSwNEhGw6OptnxvFxD4W2P+gc9gQyAfBDSRGX9pkUBFlxpqtGFtTrsjPlh+N3nP1OIlBkDRsvD6lNalTxhbFY/rvc8AzYL95+gUiTp0sFaLcX2nUfVfoLQqabIyrKMSRv8NCzQ8gmPjpyd/VK5M9HhEJ3ivnenY9ZPvwESTuik1HTx2KVWNdmdqfyO8NT+HqAW85spDWARQWO5lPg0iMTGnP6McHec22PGjayudJJ9DQ1MaXmzNqgAZWBXYCQbn0oiE5K0gpVOfabV8lBWtVmM3P7GxbQCswy5pqRuojUcVQ3YEieiZk+03Lb0myhBcsh7wGubZrluGl82v6cJS91Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB7064.namprd11.prod.outlook.com (2603:10b6:806:2b7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 06:26:11 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 06:26:11 +0000
Date: Wed, 23 Jul 2025 14:26:01 +0800
From: kernel test robot <oliver.sang@intel.com>
To: <thaumy.love@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Arnaldo
 Carvalho de Melo" <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Thaumy Cheng <thaumy.love@gmail.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH] perf/core: Fix missing read event generation on task exit
Message-ID: <202507230728.5545017c-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250720000424.12572-1-thaumy.love@gmail.com>
X-ClientProxiedBy: SG2P153CA0029.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::16)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB7064:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d8098ed-acca-49f7-3bc7-08ddc9b1d151
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Edbhl52dUC0rfaaGFqScBgFO3Fal4bIdUxLs6+lhMu6hetpXD6Syz4HUHEJp?=
 =?us-ascii?Q?w088iPXfBdV5adwcrpSXC9tiFQAzFdHVqqEHimjO4jYDpGxHjhxjVB8MawfA?=
 =?us-ascii?Q?gFHcljfRBF2qRDDUXd0hvRuSQChFFDwVfMNDLvfa4/FCn+TgUfQckBaEbJsT?=
 =?us-ascii?Q?K4n3m6lfM6RwrWl7rpUp6m9wBvNQWP2pLUBerJmzZufBwFZzN1t0E1yomKNe?=
 =?us-ascii?Q?X2V74ej4Cw1TpP1XwAScgYzw+hZJdgya3vdywWwgzi48ZI+3gCvwmrdD1ICO?=
 =?us-ascii?Q?7TMjjG+kMy0UPbKMhNMGLoVg+zneZwGpSTL1BucWvZE25Cv1PXgSdmTquLAC?=
 =?us-ascii?Q?14Ac8ufjG2Pg1Fpf3Lr5pu4g9YLsH516FplFBJX2ctTgo/irLx4LyR24oQ9n?=
 =?us-ascii?Q?OKQFo1NEo6GTsiuGUjAzRrkczCwmHBEvWfG1PRzBw6KMr77smtziu91t9kTF?=
 =?us-ascii?Q?LYtTo0qOfB70+0yp8qEm7+GvmSDggmOu7b5XvhbpTQyZ0sD02Sl4Stwhr/VW?=
 =?us-ascii?Q?jyOOREkvhkrvO//TLcceSOipSN5hp5x/ECeHeXdM55ZWE7+270shw2rre7Rb?=
 =?us-ascii?Q?Uj+SZETRIzHyOFzI08+bmqDMhU3vYRBr6Pqag5Dp/5oUmcr+Z91EgPCIzJDC?=
 =?us-ascii?Q?v902fHxVV1Ui4lQ5uFAeXph53lYyyaCzHVbZI/H1N/fKMA3ifyDBpZpd5nSR?=
 =?us-ascii?Q?Z81hQLIHcXJgvrfSiJOgsp3RVVL9IBrp6IXLXWiD81nwcgV7/Vx4ArkYqDVl?=
 =?us-ascii?Q?Dx7T9WoB1IWN7hiVodx2Akr+eZwwu+qT6wyIQvy46VH0XdrWxUrJXk9mJNv8?=
 =?us-ascii?Q?OPgN99DcUaX44ngxb3dERt4wA3AEbamQAnC97BKrz3sP5UGZssRfzWoGYRJ9?=
 =?us-ascii?Q?6dLEHH7U/ffuVEyNzsqjw29QZM07Unzb5R0Jy4LxBS8xTw4GeQC1l8qvSwJl?=
 =?us-ascii?Q?acAOQjkr0yZq0ILQrQoV5rY8IFxunqx4m2wLnPZp0weVV3lhrjEBfowWAPRD?=
 =?us-ascii?Q?bLBrBU7syssoWtLojbBNAYPCsGLrYEOJcOt+Pg+9HMSsK8XNKoLzqo1svYXn?=
 =?us-ascii?Q?cozivUpn4mTK+/xF4d9VTn2jgVKuWN+YCkF9w+pTh3EIv8gL9Mk1cmILwe5z?=
 =?us-ascii?Q?xAdSFgGrLlu830nGbxW1Bt81lpobCnggUcK4woLrGuO4t8X5926f+PVGypzS?=
 =?us-ascii?Q?MtIJ0XzpUFbFgYJPR15mWfTjLHgzIbH0jZ3MK2aju1Xd0lkfT9NE2Py88hSM?=
 =?us-ascii?Q?e6euLPtB0+aAfUkLSjLORZNqgFrZ8+V3ndxio8iJ/oUzrwbJ4iS8aWmm51L2?=
 =?us-ascii?Q?UPPwIrcYekciBUMQuLls2Oj87gigvtA5JSg1o/APr3MKhnmOI34QASqRCQkm?=
 =?us-ascii?Q?GbLfvW9asGA9l0Y2EMeXW1eAEi6x?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WixdCD/nV2WQliDPYrhXlnDSPylHKSVRIdrrsg+3eFhQIUpG/XyDuypiMepv?=
 =?us-ascii?Q?VD9ncfmS57ggxkMVJ5rkFrjErSAYd85jo/6dYOdWMaHyvbstKSkh4B7OXtoE?=
 =?us-ascii?Q?sF1FVeGLgaoZsLSbx9McO9py9zUpls7Ll+OOktC2CG0d/xOwkWkFP0T44yJ6?=
 =?us-ascii?Q?aQnPaqS73gnhPUPUE45d+odSgfG0Sc6GMK8bFU0JUPhP/0H5FBgwi0VWrtc4?=
 =?us-ascii?Q?E5qtBCuGf7xrQiq96aUQgoyoon+uLPu7QFy/0ZWY7Di6dhBBAHavRO9T0RHq?=
 =?us-ascii?Q?EnG2JMApb4iwbj0JYp7/xBaxIWWF77I5tTR6R3lXk8GGive/Kk4G1GsiaCNX?=
 =?us-ascii?Q?PIOiO6nIb2+Dq044zh1RTGtAgexIWXro0B88sjOxZBeVSgPbOHbCve6c+406?=
 =?us-ascii?Q?OZhVrq8ywqO4X3RAyAx1MKLoo/70rQd8TSkaB39zBsFTmr1ihfFxc+/NGED+?=
 =?us-ascii?Q?lCDPubbHn8bCqHBf63CBVE5THJhLHkOAuLLyhiVOq7c/ePg81J/qEtWKNgSH?=
 =?us-ascii?Q?WSCor6tvqk77L2UTNFp2pVyuc/0S3ibojNeQpQwPFsPv/AKX13D7EaCVJjjw?=
 =?us-ascii?Q?4nsiItOjdFWEAVRxQPRiNAnYcu5ViFvKSAbiv+GFL71hTjnQ+Otl+iTNQDn/?=
 =?us-ascii?Q?Ei3BQCvSIHKDl92lUEjyZVK07lTb7PJOiHNpAY26xD3LDOBIFXMUbCVfA53u?=
 =?us-ascii?Q?RKexxLijJ71s3+A6zCDvZso+aU7QTq2VkOFK1JyZAqcXXuxfrrJpSLWsoB1z?=
 =?us-ascii?Q?Hv3TYk0w6ZKx7GlR2v3SFzKIhoSCkI13FeX0BLOJ6EAfucPBBFgp78Oxr1TD?=
 =?us-ascii?Q?OvHWgLscS6xZpskxrRFT9RhqSiTxxY5n4la4aOosUlaFZTUPxuNEKA/iAamc?=
 =?us-ascii?Q?3vfVxU4me615xkGRR3pWEDXPtWdN9t0jddugtFF3lEpnxGH5q/Q6DC96mI1K?=
 =?us-ascii?Q?97TfYFYFmQiO4GQO4pR2Jfm09CSTPBxPIIFItkfG7Q4x1gs2v+tw0T5D3k99?=
 =?us-ascii?Q?2bVc8Le2n+Y1obRQjQD/r/7isTgaeLP/FLqqfBCQHAqe6ENyInoY8sJIO/qB?=
 =?us-ascii?Q?DjPyYyoydR7ystzeG0uG9l6FjuG4D4LfIOsa/II+qSZTWCa1j3i3bOibaSrb?=
 =?us-ascii?Q?TOSxc6j0bS4DXdM+ryy3gOVpwco6AQgFztuqrIbCTiVQdOkC7ZMDkYPFyQY5?=
 =?us-ascii?Q?8k+gZEM9c8q01zcpI3EWDNQeVyNdQvBSXffgkQbUZ59hvw/3hbLOC0M/MpFr?=
 =?us-ascii?Q?zu7h9LrOj0bxKCeQMuRNsvYYKfbuhW/2qM7+1MtAwQMFVG5E9JdVtDHBNgp9?=
 =?us-ascii?Q?jcxXMUv/tkB1g8DmvgcZmhgxAljaVPCGsLF8xiWNDOhSBfUcYI1cIDcTc40D?=
 =?us-ascii?Q?UQjaMX1Ib/C7KoFYmZ4yw7vGdE/kEeYxELFHDU0iOmkl2L0zNiKFBJR4NYDw?=
 =?us-ascii?Q?81RtWJ0XI4Db8Y/HxOVwlAsxAB0638R+9b3dGKsZCjwoE5lrFpFt2iWSErMz?=
 =?us-ascii?Q?edNjKN+P5yOof8vaWLjxi9JIfNYs5/AeKEhyjYoASCJI4f6YFDKmiO3MlW4w?=
 =?us-ascii?Q?Qla2UhmIXW3/w3JPGUt9Amx5TiZeXm6YogED2ubJH0rmu2oH/814rMLKgAMk?=
 =?us-ascii?Q?hA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d8098ed-acca-49f7-3bc7-08ddc9b1d151
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 06:26:11.5731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2P1lXOnnZdph+Ed8bWZCqJLi/IKj5/wogB1KkRf5ob9HmQY4HRcviB5s/EUFViqtBrIVjvxuL1fg6TJr3WW6Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7064
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:KASAN:slab-use-after-free_in__task_pid_nr_ns" on:

commit: 99c9e5f1d1d521da2d6b2e8db124138a5a62d01c ("[PATCH] perf/core: Fix missing read event generation on task exit")
url: https://github.com/intel-lab-lkp/linux/commits/thaumy-love-gmail-com/perf-core-Fix-missing-read-event-generation-on-task-exit/20250720-080504
base: https://git.kernel.org/cgit/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
patch link: https://lore.kernel.org/all/20250720000424.12572-1-thaumy.love@gmail.com/
patch subject: [PATCH] perf/core: Fix missing read event generation on task exit

in testcase: trinity
version: trinity-i386-abe9de86-1_20230429
with following parameters:

	runtime: 600s



config: x86_64-randconfig-074-20250720
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202507230728.5545017c-lkp@intel.com


[ 85.439456][ T728] BUG: KASAN: slab-use-after-free in __task_pid_nr_ns (kernel/pid.c:517) 
[   85.440144][  T728] Read of size 8 at addr ffff88815975d4a8 by task trinity-c3/728
[   85.440807][  T728]
[   85.441073][  T728] CPU: 0 UID: 65534 PID: 728 Comm: trinity-c3 Not tainted 6.16.0-rc3-00126-g99c9e5f1d1d5 #1 PREEMPT(full)  7cb1e1aeab1a1bce2ffdef82ac08cc822ee9d55c
[   85.442261][  T728] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   85.443112][  T728] Call Trace:
[   85.443436][  T728]  <TASK>
[ 85.443736][ T728] dump_stack_lvl (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:109 arch/x86/include/asm/irqflags.h:151 lib/dump_stack.c:123) 
[ 85.444146][ T728] print_address_description+0x6b/0x32b 
[ 85.444687][ T728] ? __task_pid_nr_ns (kernel/pid.c:517) 
[ 85.445118][ T728] print_report (mm/kasan/report.c:522) 
[ 85.445522][ T728] ? __virt_addr_valid (arch/x86/mm/physaddr.c:65) 
[ 85.445964][ T728] ? virt_to_slab (mm/slab.h:214) 
[ 85.446365][ T728] ? kmem_cache_debug_flags (mm/slab.h:527) 
[ 85.446828][ T728] ? kasan_complete_mode_report_info (mm/kasan/report_generic.c:179) 
[ 85.447339][ T728] ? __task_pid_nr_ns (kernel/pid.c:517) 
[ 85.447777][ T728] kasan_report (mm/kasan/report.c:636) 
[ 85.448175][ T728] ? __task_pid_nr_ns (kernel/pid.c:517) 
[ 85.448610][ T728] __asan_report_load8_noabort (mm/kasan/report_generic.c:381) 
[ 85.449088][ T728] __task_pid_nr_ns (kernel/pid.c:517) 
[ 85.449513][ T728] perf_event_pid_type (kernel/events/core.c:1433) 
[ 85.449954][ T728] perf_event_pid (kernel/events/core.c:1441) 
[ 85.450359][ T728] perf_event_read_event (kernel/events/core.c:8520) 
[ 85.450825][ T728] ? perf_event_switch_output (kernel/events/core.c:8510) 
[ 85.451307][ T728] ? __lock_acquire (kernel/locking/lockdep.c:5240) 
[ 85.451736][ T728] ? __kasan_check_write (mm/kasan/shadow.c:38) 
[ 85.452189][ T728] ? lock_acquire (kernel/locking/lockdep.c:5836) 
[ 85.452644][ T728] ? perf_remove_from_context (kernel/events/core.c:2558 (discriminator 9)) 
[ 85.453124][ T728] ? perf_event__header_size (kernel/events/core.c:2003) 
[ 85.453597][ T728] ? perf_group_detach (kernel/events/core.c:2316) 
[ 85.454042][ T728] __perf_remove_from_context (kernel/events/core.c:13965 kernel/events/core.c:2339 kernel/events/core.c:2510) 
[ 85.454531][ T728] perf_remove_from_context (kernel/events/core.c:2561) 
[ 85.455008][ T728] perf_event_exit_event+0xa5/0xe0 
[ 85.455530][ T728] perf_event_exit_task_context (kernel/events/core.c:14068 (discriminator 3)) 
[ 85.456027][ T728] ? perf_event_exit_event+0xe0/0xe0 
[ 85.456551][ T728] ? kfree (include/trace/events/kmem.h:94 mm/slub.c:4829) 
[ 85.456921][ T728] ? yama_ptracer_del (security/yama/yama_lsm.c:197) 
[ 85.457364][ T728] perf_event_free_task (kernel/events/core.c:14170) 
[ 85.457794][ T728] copy_process (kernel/fork.c:2468) 
[ 85.458212][ T728] ? pidfd_prepare (kernel/fork.c:1918) 
[ 85.458672][ T728] ? __lock_acquire (kernel/locking/lockdep.c:5240) 
[ 85.459110][ T728] ? rcu_lock_acquire (include/linux/rcupdate.h:331) 
[ 85.459610][ T728] ? lock_acquire (kernel/locking/lockdep.c:5836) 
[ 85.460062][ T728] kernel_clone (include/linux/random.h:26 kernel/fork.c:2600) 
[ 85.460468][ T728] ? find_held_lock (kernel/locking/lockdep.c:5353) 
[ 85.460993][ T728] ? create_io_thread (kernel/fork.c:2559) 
[ 85.461731][ T728] ? rcu_read_unlock (include/linux/rcupdate.h:874 (discriminator 9)) 
[ 85.462465][ T728] ? __task_pid_nr_ns (kernel/pid.c:521 (discriminator 11)) 
[ 85.463254][ T728] __do_compat_sys_ia32_clone (arch/x86/kernel/sys_ia32.c:243) 
[ 85.464101][ T728] ? __ia32_compat_sys_ia32_mmap (arch/x86/kernel/sys_ia32.c:243) 
[ 85.464977][ T728] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4660) 
[ 85.465914][ T728] ? rcu_lock_acquire (include/linux/rcupdate.h:331) 
[ 85.466774][ T728] ? lock_acquire (kernel/locking/lockdep.c:5836) 
[ 85.467537][ T728] ? rcu_lock_acquire (include/linux/rcupdate.h:331) 
[ 85.468369][ T728] __ia32_compat_sys_ia32_clone (arch/x86/kernel/sys_ia32.c:240) 
[ 85.469175][ T728] ia32_sys_call (kbuild/obj/consumer/x86_64-randconfig-074-20250720/./arch/x86/include/generated/asm/syscalls_32.h:121) 
[ 85.469884][ T728] __do_fast_syscall_32 (arch/x86/entry/syscall_32.c:83 arch/x86/entry/syscall_32.c:306) 
[ 85.470731][ T728] ? rcu_read_unlock (include/linux/rcupdate.h:874 (discriminator 9)) 
[ 85.471470][ T728] ? __task_pid_nr_ns (kernel/pid.c:521 (discriminator 11)) 
[ 85.472232][ T728] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4660) 
[ 85.473171][ T728] ? __do_fast_syscall_32 (arch/x86/entry/syscall_32.c:310) 
[ 85.473958][ T728] ? irqentry_exit_to_user_mode (kernel/entry/common.c:187) 
[ 85.474835][ T728] do_fast_syscall_32 (arch/x86/entry/syscall_32.c:331) 
[ 85.475578][ T728] do_SYSENTER_32 (arch/x86/entry/syscall_32.c:370) 
[ 85.476272][ T728] entry_SYSENTER_compat_after_hwframe (arch/x86/entry/entry_64_compat.S:127) 
[   85.477152][  T728] RIP: 0023:0xf7f79579
[ 85.477809][ T728] Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
All code
========
   0:	b8 01 10 06 03       	mov    $0x3061001,%eax
   5:	74 b4                	je     0xffffffffffffffbb
   7:	01 10                	add    %edx,(%rax)
   9:	07                   	(bad)
   a:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   e:	10 08                	adc    %cl,(%rax)
  10:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
	...
  20:	00 51 52             	add    %dl,0x52(%rcx)
  23:	55                   	push   %rbp
  24:*	89 e5                	mov    %esp,%ebp		<-- trapping instruction
  26:	0f 34                	sysenter
  28:	cd 80                	int    $0x80
  2a:	5d                   	pop    %rbp
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	ret
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  39:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi

Code starting with the faulting instruction
===========================================
   0:	5d                   	pop    %rbp
   1:	5a                   	pop    %rdx
   2:	59                   	pop    %rcx
   3:	c3                   	ret
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   f:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
[   85.480340][  T728] RSP: 002b:00000000ffea1d40 EFLAGS: 00000286 ORIG_RAX: 0000000000000078
[   85.481557][  T728] RAX: ffffffffffffffda RBX: 0000000001200011 RCX: 0000000000000000
[   85.482749][  T728] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000f7f722e8
[   85.483938][  T728] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[   85.485110][  T728] R10: 0000000000000000 R11: 0000000000000216 R12: 0000000000000000
[   85.486283][  T728] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   85.487473][  T728]  </TASK>
[   85.488026][  T728]
[   85.488469][  T728] Allocated by task 728:
[ 85.489121][ T728] stack_trace_save (kernel/stacktrace.c:114) 
[ 85.489831][ T728] kasan_save_stack (mm/kasan/common.c:48) 
[ 85.490544][ T728] kasan_save_track (arch/x86/include/asm/current.h:25 mm/kasan/common.c:60 mm/kasan/common.c:69) 
[ 85.491286][ T728] kasan_save_alloc_info (mm/kasan/generic.c:563) 
[ 85.492023][ T728] unpoison_slab_object (mm/kasan/common.c:320) 
[ 85.492760][ T728] __kasan_slab_alloc (mm/kasan/common.c:348) 
[ 85.493476][ T728] kmem_cache_alloc_noprof (mm/slub.c:4148 mm/slub.c:4197 mm/slub.c:4204) 
[ 85.494245][ T728] copy_signal (kernel/fork.c:1648) 
[ 85.494942][ T728] copy_process (kernel/fork.c:2166) 
[ 85.495646][ T728] kernel_clone (include/linux/random.h:26 kernel/fork.c:2600) 
[ 85.496351][ T728] __do_compat_sys_ia32_clone (arch/x86/kernel/sys_ia32.c:243) 
[ 85.497150][ T728] __ia32_compat_sys_ia32_clone (arch/x86/kernel/sys_ia32.c:240) 
[ 85.498002][ T728] ia32_sys_call (kbuild/obj/consumer/x86_64-randconfig-074-20250720/./arch/x86/include/generated/asm/syscalls_32.h:121) 
[ 85.498765][ T728] __do_fast_syscall_32 (arch/x86/entry/syscall_32.c:83 arch/x86/entry/syscall_32.c:306) 
[ 85.499552][ T728] do_fast_syscall_32 (arch/x86/entry/syscall_32.c:331) 
[ 85.500296][ T728] do_SYSENTER_32 (arch/x86/entry/syscall_32.c:370) 
[ 85.501017][ T728] entry_SYSENTER_compat_after_hwframe (arch/x86/entry/entry_64_compat.S:127) 
[   85.501945][  T728]
[   85.502416][  T728] Freed by task 728:
[ 85.503050][ T728] stack_trace_save (kernel/stacktrace.c:114) 
[ 85.503775][ T728] kasan_save_stack (mm/kasan/common.c:48) 
[ 85.504510][ T728] kasan_save_track (arch/x86/include/asm/current.h:25 mm/kasan/common.c:60 mm/kasan/common.c:69) 
[ 85.505228][ T728] kasan_save_free_info (mm/kasan/generic.c:579) 
[ 85.505987][ T728] poison_slab_object (mm/kasan/common.c:248) 
[ 85.506704][ T728] __kasan_slab_free (mm/kasan/common.c:271) 
[ 85.507142][ T728] kmem_cache_free (mm/slub.c:4643 mm/slub.c:4745) 
[ 85.507569][ T728] free_signal_struct (kernel/fork.c:721) 
[ 85.508010][ T728] copy_process (kernel/fork.c:2454) 
[ 85.508431][ T728] kernel_clone (include/linux/random.h:26 kernel/fork.c:2600) 
[ 85.508840][ T728] __do_compat_sys_ia32_clone (arch/x86/kernel/sys_ia32.c:243) 
[ 85.509323][ T728] __ia32_compat_sys_ia32_clone (arch/x86/kernel/sys_ia32.c:240) 
[ 85.509808][ T728] ia32_sys_call (kbuild/obj/consumer/x86_64-randconfig-074-20250720/./arch/x86/include/generated/asm/syscalls_32.h:121) 
[ 85.510227][ T728] __do_fast_syscall_32 (arch/x86/entry/syscall_32.c:83 arch/x86/entry/syscall_32.c:306) 
[ 85.510689][ T728] do_fast_syscall_32 (arch/x86/entry/syscall_32.c:331) 
[ 85.511124][ T728] do_SYSENTER_32 (arch/x86/entry/syscall_32.c:370) 
[ 85.511530][ T728] entry_SYSENTER_compat_after_hwframe (arch/x86/entry/entry_64_compat.S:127) 
[   85.512055][  T728]


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250723/202507230728.5545017c-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

