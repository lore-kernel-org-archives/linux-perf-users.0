Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2244487A5;
	Fri, 25 Oct 2024 02:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729822796; cv=fail; b=nHYxOLzO5xlSYR97FG0a8XohxI6fROI0VkbiV2bNOU6G9VgNF7OAzp73t20xlNYv+RpH3Fq2Tjwx5UfiPb2HzQGDBCgAvLbU9LBc3uGsz5dmqvComVi3CpF1KXxaplOI/UOM4lOi3zZAMvG55COEXFGHgoyS0omta1L5lXoWDi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729822796; c=relaxed/simple;
	bh=E/7yYDNobP3iX7iruhR5pndlrjBs4V7MHfmmM2CmYJc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=uyskOycUCiX88hsgn7oHZIqqzMyDlMXpP3nemqaoE/kdD0tWZ+NmGFOazZ2Uiwvq7FNxA+G5dG/OMYaak34S7xAdAx1wZvyivHz6ZhI1YyypvSzR8EezTVP/fbWkK4cDU24z8heZGcXc89b80AnR06s/lZ9E+j6cyXVUmjbPU6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IZRgZWTu; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IZRgZWTu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729822794; x=1761358794;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=E/7yYDNobP3iX7iruhR5pndlrjBs4V7MHfmmM2CmYJc=;
  b=IZRgZWTuH9PWKOZegwwzeIvrJjo9oIhqgr6sOZLhQwwj9aNGW3Un/qjc
   z3ZkPjK160FP8WLkbmR96U1cULrEQiWD6ctIR1a/8b0LrM0J5bqXS+eum
   eS5KtxHwjBoxNsrnNR/3RcXid0JRcSsqDkWmIlSqTjH0jMBaktEc9nePT
   ASaF3d6BO7kaGfFGyXMEovCsuWurrNYAcymsbetSynAi+eVJ0XvKyETO8
   SBj7mxI/yxTKkw2xi22I4Rw//BD1pbWdoYdgcA5FzRFrku8hF8o+kvwGG
   JJoAeD3sOTFyaIyj0BjLxPKIC8TndUaTGrw5lXFwRMwbVu3nbR08G2j8S
   A==;
X-CSE-ConnectionGUID: voUwl4ZiQL+/Ig8lx8POTQ==
X-CSE-MsgGUID: f00jAsKGR9O50yL2aZmmLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="40099631"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="40099631"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 19:19:53 -0700
X-CSE-ConnectionGUID: xdHx+6yoSXKHY96U0dArZw==
X-CSE-MsgGUID: GTfo68QKQRa4MOD8EBJM/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="85888253"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2024 19:19:53 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 24 Oct 2024 19:19:52 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 24 Oct 2024 19:19:52 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 24 Oct 2024 19:19:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GGknPrP1ValhQMcIjPQHqLwv2hlRWhoGp44XT+TH6yTuwUzziNFyMDBqTlUv0B7OpaqdX83XIotAn/RtHAFteGnwaCq5hDKmGQcyBrGFbibkx4y422qhQzaUHUWA64cEaXq56jetGsk5cXwjYh/Dp8TVQU4FSSXTaILpNMr9lgEAvLbTC2LYF6BdaDvCAVNDVt/65QmhI/D0/wlK8Igx5cnLwi3PfUaBa75gj65zSYVIaZv63rA+LLv2uDPf3GRoxXMiufHOFSMCFvOkRcbc/iYAwXktvVAeOSu29uRmjgcb6KlgI6AbLqWKQ/6aQwVl1jEibzZcy2az057u505bgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikVE6mgWlqgfzC+DcGlAKPTXDyWXtS75DtSGjF0PEKU=;
 b=M5NZGEETJP1gCiLTi22hbQetcm9cnh2OhiP3jkrhyBrlsXqkoTr6BEC5NfbzrVZU7fGhiseMJiwL4sDCKDjgkoydeCQWVV146XMW/T8t8jFHgMuCz83OBk3pHoux3gkjpYMoskQg5DAlyDu/2MCChMjJ8Haio+SIU6cGdMhTtIYRSJB3Ck874xDfvlYOy07q0x4sKkZomz6NuIN4/2S3lyYcKtCN+itZWYNfEQLVhQi7Zw9nz3UkVw9AqhrUBXhR4sYWJSs5ag4OERvHfeD2ry197DLVvqh97GqqwbEuYJf4S+HHNuF8u696vtBiKaKI7FBJPWC7ecyAfjJT6xJE0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS7PR11MB7887.namprd11.prod.outlook.com (2603:10b6:8:e2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Fri, 25 Oct
 2024 02:19:50 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 02:19:49 +0000
Date: Fri, 25 Oct 2024 10:19:41 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [peterz-queue:perf/pmu-unregister] [perf] 4cbf3df69c:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <202410251048.2505fe51-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SGAP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::30)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS7PR11MB7887:EE_
X-MS-Office365-Filtering-Correlation-Id: cbb14e99-96e3-4c40-8cb7-08dcf49b80b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w0gQ2VJqEdj4WHmieqwRUssYOCfNqt4vrICrb2MBOp4B1XPS3qfOb/uXbZqL?=
 =?us-ascii?Q?xjyjG1ItekMxsCAhjgTxoC87C3UJNFRE8fHffMOI9vZtvBu84B4hSgoXGzOT?=
 =?us-ascii?Q?/sMGEiSRihHvEpcrWws7d4NdkJh18L2AJeQTQllLRp5N7XJs4lc3sucjDICz?=
 =?us-ascii?Q?lplM/E6JB2XV/MqyVgXKbbMHJ4XtOwJOiomujrO7eAd54Y0EYvaCNbam40FC?=
 =?us-ascii?Q?QTQd6q0FwJNCGQ27OD32uxpQ7N3OeZRiTTCKV+cpM0aoszP8hr5mePFc95W5?=
 =?us-ascii?Q?MxFUGobCfevmNFX7U5kM0koq8qjPrwIMEmxExKptpZPudEwqRbqSDa9+bY/x?=
 =?us-ascii?Q?LE+G4PB1eAGawpW6JOfLttV2cBLWLJMFzAZHAtg6M/wd5lfgUnDs4lu1VUH6?=
 =?us-ascii?Q?2O9LP8LLllfPzc/dwjcyg9Dpru9bkZTUdJu/uD9BuIGeqOErBAiUpKCvhHJp?=
 =?us-ascii?Q?S1EY3YVTfLNFrL4WgOWJv5DMjY3zH1AhmHLST7LMtGxiUH39cOWVeaz03GqU?=
 =?us-ascii?Q?dW1GKNiU6Yd8miuf63S/KPN859RMLC3hxEjYpbNbYAikDiTXXmk20L4K+ul/?=
 =?us-ascii?Q?f+OcA/2CRUXVLn2YeefzCoSZ5C2/8NLHUA/fwxEEh/GTLd533a6ecoqcJKsU?=
 =?us-ascii?Q?IWShEDYFJ2SZq23mC1HViLPeaF8ntxrWQmEiTGN8jX2TqxCsVIBMqshbAUI/?=
 =?us-ascii?Q?YqZlmHgb80qY9qpofhRYDUkS1ymThunP2CgSSA7pY1ohmpHKm7ClvJwyQvbF?=
 =?us-ascii?Q?UehRPz5P2dpjObVqLRMN2zxe6aIdGXtzKweXe3DtRmUdxBe8+b4RUqCMON92?=
 =?us-ascii?Q?eea1EsBxCmDd3vWqYaOy8z2/UGrZANiA6nzq1YbB+shsdvSFDJNtD5mfEYq0?=
 =?us-ascii?Q?mfZbTkblnXMAW6eI0/uLfKaExYAOuievrZDM3VXAmOQj0qhf18DYZDEeROAQ?=
 =?us-ascii?Q?t25J0A3liCX/5oOyBrgS+VmeTuJjUJhFnX4KNOL1oOOHWw6BDmKL85Lkn0M2?=
 =?us-ascii?Q?grhPPCEtNgukdjZbyCov9qAMu4osdqpI/sEnHThhkwNPl9j8cnwYAndZSU6J?=
 =?us-ascii?Q?ddA+7G3UUNyXXHe4UE8QrXwyseBdRPMBBA2jSVk9h91SiluhKPi3wlFnQWbu?=
 =?us-ascii?Q?wVdT/rpF1GdD02GDwKt7WAdKa28IsmLEmexGgUzzofsOVKtSHZtMrT0PPBxu?=
 =?us-ascii?Q?ygveoDeHmjvlH+Hlkb3E77adpzTZ3aPzgInYNLirbXlpDXw0LrlTaOUM4MHs?=
 =?us-ascii?Q?4jbp5NkPbsrXwVgIJn09Ato8YJ9Mx9aRdIeikODNQw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ltyIW6o32eX7rgbJtxp85Z8gYo8LyEllsn374i40gBPlYNS8WARJzVlCmVtG?=
 =?us-ascii?Q?3nw3FIL4+ATfmNrOIj7xYsIXJeeIXp3/Y0u4HCKHQSnYapwOItGa/J4FnKcz?=
 =?us-ascii?Q?147UPnivgiUCWDHu4dyTfsEfxGfTgJ4dPqw1C8vlPPqoYF41P9VuQLWwCDU2?=
 =?us-ascii?Q?T4ighdFXg102bqOe4KGksl4GevD5REDGhjDsPF6LXuedr1GkHP9GWqDXrH44?=
 =?us-ascii?Q?/uSDeH66lLe3YnkCnPV0rSnskLHTkiWmCr5uFuFU3YP7md34DKvusjN7YyI2?=
 =?us-ascii?Q?KSbCJ7sCRy3NQMNXTBb9Rft52gGWvX1OBXUz3QG0a12E1OkoCltu6aBCfoGB?=
 =?us-ascii?Q?/pM6dQx7Sx/vVVGa19Uxc47kXx2vKE6kXypDqfdvXdvBium5n9oPNlvD80fk?=
 =?us-ascii?Q?fPw/dACIqyLZd4GGkFEK11DuDTydsZgIlQl4VjrlZ1IkJVosv2lJ5/sKig9G?=
 =?us-ascii?Q?pbl0yqmb7uUVicy/gnaXp6q8yi9DvD9J/nxZx49n+gxR2M1c+H7R5uhRiTpK?=
 =?us-ascii?Q?7cJmRj53JmoBkE2YN8OJMnUz/SgG6h4wYTHp11PXmwF1H8AKtCP6wwRL0N3L?=
 =?us-ascii?Q?j9M167MnW3Qq5f/G9uMSBMVXPlCRTQrWVGuTW8LdzkkGp+zJklmmey5J4RgE?=
 =?us-ascii?Q?9SGdq98ajr6T8eTYMGD2QeElRQcgAwuaGzohpFbVHDWcyAgtx5R4yijGXs4I?=
 =?us-ascii?Q?Pu70SVx5hnUQ92ORP5VulGTbQZOckcNVxhFaobnNCyuBxmKKRu3WVUwC2EKr?=
 =?us-ascii?Q?arp2yZntHmcuq3Ns4aD4rJxIG/Xe7pKUwDm9Jg79qyewSM9uYMn/8rMUq64K?=
 =?us-ascii?Q?YY+L4KMFFgCwpNyTW/ms23Opz9tf0KKPt5A2Qlc9XCcphg9N4FFfLiD2H4xk?=
 =?us-ascii?Q?4ybL2BC5JpqlDj0zIYUx87W9PSOrXWaTC0I3wvqTnfPZy4gJiWKXbYaTwnpq?=
 =?us-ascii?Q?hTcVbxSQAMjsnGv2t4C9eiXCFZjT4FaXGbx+pGik5jYxV6TKif8Mzk4m2y7H?=
 =?us-ascii?Q?1AZcDtOEmboI1AAfgZVDeVfTSDwNsBEaj7nbcF5pWC76L7pH+JkIxm8cK6h7?=
 =?us-ascii?Q?TmFQ2mobL8WLpd7wUDBO13y7yLBWkdN3YigP6xGIDfxglpNwNky3wC3ajNCf?=
 =?us-ascii?Q?G9cn7UNhqAvdr6xMTfU09GHu5GZ848AUtD7yYNgaY6Q8Vt+eb8XD9OzVKCWR?=
 =?us-ascii?Q?EKIQJf3d+RtdNk/dTaMhEcBoBmoGZlBaV6Wa1/Y4fugDmkuocEB6SwwATUig?=
 =?us-ascii?Q?/Q4Cmci7QSBxHyrlkeX98924JHd0QmUTmgJH2BJaaJApYGLpPUXAa5LD5kBO?=
 =?us-ascii?Q?q6Hip9pxj1HENrwTXZkMaG7m/tieOSFjzJ+xkWaMA0eyMQGvm+caDCvsfURb?=
 =?us-ascii?Q?wn8p3+juqcAL3OAJDwEBwiLXo2vEXJ8b8OdR9SxW+BAQdTSF3ofvNv4v/N3T?=
 =?us-ascii?Q?JCs2KwoXSfUMnYd+eBP70o/QgFugSiotT79puQT1wha+119eHeZ5arPYl+H7?=
 =?us-ascii?Q?/oaZrRCCxGBS8A026e1mrQsyZe8tSxkaRSM09E2Htuz2TiX0YwczEstEPFkO?=
 =?us-ascii?Q?A+D6QJXYgxreiX5vd53XljMbSB/eAQTlXNcfNsANBjPvu/AFpqvngrf7WD4M?=
 =?us-ascii?Q?5w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb14e99-96e3-4c40-8cb7-08dcf49b80b0
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 02:19:49.9068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: THDQlxI7o9KwJ/3C+vlz0waBNTAOXdln11NgY2tpBhMY2J2tIP/aIl5uK0h+qwt2tMYn/jSE/E4reqL649g6mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7887
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:

commit: 4cbf3df69c5697061018989b08423d4c04bbe101 ("perf: Make perf_pmu_unregister() useable")
https://git.kernel.org/cgit/linux/kernel/git/peterz/queue.git perf/pmu-unregister

in testcase: trinity
version: trinity-x86_64-ba2360ed-1_20240923
with following parameters:

	runtime: 600s



config: x86_64-kexec
compiler: clang-18
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-----------------------------------------------------------+------------+------------+
|                                                           | d4187ab34e | 4cbf3df69c |
+-----------------------------------------------------------+------------+------------+
| BUG:kernel_NULL_pointer_dereference,address               | 0          | 15         |
| Oops                                                      | 0          | 15         |
| RIP:__free_event                                          | 0          | 15         |
| Kernel_panic-not_syncing:Fatal_exception                  | 0          | 15         |
+-----------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202410251048.2505fe51-lkp@intel.com


[   27.301103][ T3733] BUG: kernel NULL pointer dereference, address: 0000000000000008
[   27.302392][ T3733] #PF: supervisor write access in kernel mode
[   27.303317][ T3733] #PF: error_code(0x0002) - not-present page
[   27.304207][ T3733] PGD 80000001bfbc3067 P4D 80000001bfbc3067 PUD 1ae899067 PMD 0
[   27.305417][ T3733] Oops: Oops: 0002 [#1] PREEMPT SMP PTI
[   27.306260][ T3733] CPU: 0 UID: 65534 PID: 3733 Comm: trinity-c0 Not tainted 6.12.0-rc2-00028-g4cbf3df69c56 #1
[   27.307747][ T3733] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 27.309232][ T3733] RIP: 0010:__free_event (include/linux/list.h:195 include/linux/list.h:218 include/linux/list.h:229 kernel/events/core.c:5395) 
[ 27.310053][ T3733] Code: ff ff 4d 85 f6 74 56 49 8b 7e 28 e8 a7 af ec ff 4d 8d 7e 10 4c 89 ff e8 2b 25 ce 00 48 8b 83 18 05 00 00 48 8b 8b 20 05 00 00 <48> 89 48 08 48 89 01 48 b8 00 01 00 00 00 00 ad de 48 89 83 18 05
All code
========
   0:	ff                   	(bad)
   1:	ff 4d 85             	decl   -0x7b(%rbp)
   4:	f6 74 56 49          	divb   0x49(%rsi,%rdx,2)
   8:	8b 7e 28             	mov    0x28(%rsi),%edi
   b:	e8 a7 af ec ff       	call   0xffffffffffecafb7
  10:	4d 8d 7e 10          	lea    0x10(%r14),%r15
  14:	4c 89 ff             	mov    %r15,%rdi
  17:	e8 2b 25 ce 00       	call   0xce2547
  1c:	48 8b 83 18 05 00 00 	mov    0x518(%rbx),%rax
  23:	48 8b 8b 20 05 00 00 	mov    0x520(%rbx),%rcx
  2a:*	48 89 48 08          	mov    %rcx,0x8(%rax)		<-- trapping instruction
  2e:	48 89 01             	mov    %rax,(%rcx)
  31:	48 b8 00 01 00 00 00 	movabs $0xdead000000000100,%rax
  38:	00 ad de 
  3b:	48                   	rex.W
  3c:	89                   	.byte 0x89
  3d:	83 18 05             	sbbl   $0x5,(%rax)

Code starting with the faulting instruction
===========================================
   0:	48 89 48 08          	mov    %rcx,0x8(%rax)
   4:	48 89 01             	mov    %rax,(%rcx)
   7:	48 b8 00 01 00 00 00 	movabs $0xdead000000000100,%rax
   e:	00 ad de 
  11:	48                   	rex.W
  12:	89                   	.byte 0x89
  13:	83 18 05             	sbbl   $0x5,(%rax)
[   27.312693][ T3733] RSP: 0018:ffffc90000a1bda8 EFLAGS: 00010246
[   27.313597][ T3733] RAX: 0000000000000000 RBX: ffff8881ae90cf90 RCX: 0000000000000000
[   27.314773][ T3733] RDX: 0000000000000002 RSI: 0000000000000002 RDI: ffffffff82dfcc30
[   27.316088][ T3733] RBP: 00000000000000ff R08: 0000000000000002 R09: 0000000000000000
[   27.317342][ T3733] R10: ffff88842fc30b48 R11: ffffffff810408c0 R12: ffffffff82dfcc20
[   27.318567][ T3733] R13: 0000000000000000 R14: ffffffff82dfcc20 R15: ffffffff82dfcc30
[   27.319832][ T3733] FS:  00007f373e201740(0000) GS:ffff88842fc00000(0000) knlGS:0000000000000000
[   27.321164][ T3733] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   27.322150][ T3733] CR2: 0000000000000008 CR3: 000000014a5b8000 CR4: 00000000000406f0
[   27.327720][ T3733] Call Trace:
[   27.328333][ T3733]  <TASK>
[ 27.328866][ T3733] ? __die_body (arch/x86/kernel/dumpstack.c:421) 
[ 27.329570][ T3733] ? page_fault_oops (arch/x86/mm/fault.c:711) 
[ 27.330359][ T3733] ? do_user_addr_fault (arch/x86/mm/fault.c:?) 
[ 27.331207][ T3733] ? __pfx_do_sync_core (arch/x86/kernel/alternative.c:2079) 
[ 27.332004][ T3733] ? exc_page_fault (arch/x86/include/asm/irqflags.h:37 arch/x86/include/asm/irqflags.h:92 arch/x86/mm/fault.c:1489 arch/x86/mm/fault.c:1539) 
[ 27.332774][ T3733] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623) 
[ 27.333605][ T3733] ? __pfx_do_sync_core (arch/x86/kernel/alternative.c:2079) 
[ 27.334428][ T3733] ? __free_event (include/linux/list.h:195 include/linux/list.h:218 include/linux/list.h:229 kernel/events/core.c:5395) 
[ 27.335253][ T3733] ? __free_event (include/linux/list.h:218 include/linux/list.h:229 kernel/events/core.c:5395) 
[ 27.336027][ T3733] perf_event_alloc (kernel/events/core.c:12566) 
[ 27.336836][ T3733] __se_sys_perf_event_open (kernel/events/core.c:12978) 
[ 27.337703][ T3733] ? enqueue_hrtimer (kernel/time/hrtimer.c:1093) 
[ 27.338512][ T3733] ? hrtimer_start_range_ns (kernel/time/hrtimer.c:1302) 
[ 27.339427][ T3733] do_syscall_64 (arch/x86/entry/common.c:?) 
[ 27.340215][ T3733] ? irqentry_exit_to_user_mode (arch/x86/include/asm/processor.h:701 arch/x86/include/asm/entry-common.h:100 include/linux/entry-common.h:364 kernel/entry/common.c:233) 
[ 27.341134][ T3733] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[   27.342052][ T3733] RIP: 0033:0x7f373e305719
[ 27.342835][ T3733] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b7 06 0d 00 f7 d8 64 89 01 48
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
[   27.345728][ T3733] RSP: 002b:00007ffce1cad208 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
[   27.347094][ T3733] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f373e305719
[   27.348378][ T3733] RDX: 0000000000000001 RSI: 0000000000000136 RDI: 000055ca24f7fab0
[   27.349658][ T3733] RBP: 00007f373cc3b058 R08: 000000000000000d R09: 0000000040000000
[   27.350991][ T3733] R10: ffffffffffffffff R11: 0000000000000246 R12: 000000000000012a
[   27.352312][ T3733] R13: 00007f373e2016c0 R14: 00007f373cc3b058 R15: 00007f373cc3b000
[   27.353629][ T3733]  </TASK>
[   27.354206][ T3733] Modules linked in: can_bcm can_raw can cn scsi_transport_iscsi ipmi_msghandler sr_mod cdrom sg ata_generic fuse dm_mod
[   27.356119][ T3733] CR2: 0000000000000008
[   27.356801][ T3733] ---[ end trace 0000000000000000 ]---
[ 27.357630][ T3733] RIP: 0010:__free_event (include/linux/list.h:195 include/linux/list.h:218 include/linux/list.h:229 kernel/events/core.c:5395) 
[ 27.358462][ T3733] Code: ff ff 4d 85 f6 74 56 49 8b 7e 28 e8 a7 af ec ff 4d 8d 7e 10 4c 89 ff e8 2b 25 ce 00 48 8b 83 18 05 00 00 48 8b 8b 20 05 00 00 <48> 89 48 08 48 89 01 48 b8 00 01 00 00 00 00 ad de 48 89 83 18 05
All code
========
   0:	ff                   	(bad)
   1:	ff 4d 85             	decl   -0x7b(%rbp)
   4:	f6 74 56 49          	divb   0x49(%rsi,%rdx,2)
   8:	8b 7e 28             	mov    0x28(%rsi),%edi
   b:	e8 a7 af ec ff       	call   0xffffffffffecafb7
  10:	4d 8d 7e 10          	lea    0x10(%r14),%r15
  14:	4c 89 ff             	mov    %r15,%rdi
  17:	e8 2b 25 ce 00       	call   0xce2547
  1c:	48 8b 83 18 05 00 00 	mov    0x518(%rbx),%rax
  23:	48 8b 8b 20 05 00 00 	mov    0x520(%rbx),%rcx
  2a:*	48 89 48 08          	mov    %rcx,0x8(%rax)		<-- trapping instruction
  2e:	48 89 01             	mov    %rax,(%rcx)
  31:	48 b8 00 01 00 00 00 	movabs $0xdead000000000100,%rax
  38:	00 ad de 
  3b:	48                   	rex.W
  3c:	89                   	.byte 0x89
  3d:	83 18 05             	sbbl   $0x5,(%rax)

Code starting with the faulting instruction
===========================================
   0:	48 89 48 08          	mov    %rcx,0x8(%rax)
   4:	48 89 01             	mov    %rax,(%rcx)
   7:	48 b8 00 01 00 00 00 	movabs $0xdead000000000100,%rax
   e:	00 ad de 
  11:	48                   	rex.W
  12:	89                   	.byte 0x89
  13:	83 18 05             	sbbl   $0x5,(%rax)


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241025/202410251048.2505fe51-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

