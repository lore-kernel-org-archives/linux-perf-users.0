Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EA9188012;
	Mon, 28 Oct 2024 06:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730095830; cv=fail; b=BiWnEWWD8FLxPXSIsS8T3pgVwjfzOyvYdzsjDlAOns0SdkIrOAjvzntrg6FDaCBLAZ8m2FFSdHwAtopLaswi/9sh5YvHFQ4mCytYqyRnD99j7/lQ0ahVbyyxvIMPVOH7dnHXUSTYO/RkiDrjZS3q5ZAPaFD5jpbh+dTTMRZRKao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730095830; c=relaxed/simple;
	bh=oUWOci7p3oJxyIHAhIqOH0CIviMw8+44//2lVJ4ys1w=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=VrH9VvuGUcVptEUM1+U+3sr+3kru51vCwrMYm1jNEsz/lA2vvAa5M4WBeCEVon+KDqWbTP3EDXMqWemo+eJL4+mjOdJiECg+ZgpzPoLGtzvHOxMvp4+6PXaBCZ6wMrYm9lppzBXpJF/AKDUyMmaEWRJEIMiLdpruLRK7D9fLgfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OKs+CjX+; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OKs+CjX+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730095828; x=1761631828;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oUWOci7p3oJxyIHAhIqOH0CIviMw8+44//2lVJ4ys1w=;
  b=OKs+CjX+FV63TsyVFrYWlb/Op/0oYmD49EhFw+nBT+Sa92Awqu3OwNGu
   y/ScNC83uVE47SADVbCQu81hD2gDrFDuZwelwD8qWb+U+e6ez+eTzAR50
   MJsdF6lKOEVwUVP2Bj2CmOOJbbw8wDMYUqp508gncqnqedce+rQfamH6s
   f1UrvQNRTsBpLnPArYN8lM9kGPBrWYCfdi28u0TZNj9bpoIrFAPMATVWh
   bd6RXnE4QNc4Il4QqIaSVKyuWZligtFYZnv7oKkw9EvgdfZhucrdkkSJg
   HAsZrV0giCasOKik7lPEnasBssNHPHlhb6JmdHxj2woyX5JbCdFe48tWL
   g==;
X-CSE-ConnectionGUID: Ut34H7DISoyxz9hoAso49Q==
X-CSE-MsgGUID: deK91oHhT320LVOzJFgfzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="29140803"
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="29140803"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 23:10:27 -0700
X-CSE-ConnectionGUID: 5t7GU42gSti07fqoRFt7kw==
X-CSE-MsgGUID: 0QpWoynnTNeTctBkzNfXbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="118976093"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2024 23:10:26 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 27 Oct 2024 23:10:25 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 27 Oct 2024 23:10:25 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 27 Oct 2024 23:10:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0u9zakr7wNmvAj7ITgyJB/yNfPixgaX4w+zGKyO1Lc2QE1iQWwdKslVY4Q1UyzYGppOo9ClnEc2oMZlhbE7AHRWDh7XBPE+HfblKsOOVT985uZZ6+QYJEBIxH/eCBZ6DAoifFKwJcBo/kFXPY2uYbitNOwVaIoHSWBHKgigGjcpv6Ul1wO83DT078jxctOPLNWuL25wuW5CwDZ1ece2JHGXS8FQMu12THume5xLQWJM066A1vrW66pHmKqdGpVar8pEd1ihmdUNvASpE5+cx3ioftwG/PfETZJweAcC0O4+642A+8hFuWya2lHqRowuNSNzLJz1GDJvmPuoby5kHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVTnyEiPXvDtL9l1iCGgfBDWxTXuyFFmSTPElXxLK1c=;
 b=k1no0AVzTIxBiiQLGpKYxnJs/0FVMyYwwijZzR/AfdNKHvBAcp3YvTpfqnxVEMuBOB0o2/dXPF07IOx+oPAj8mgksxTkOPEy6GnXDqgddra+FSjaiV78mftM55677nMOnbRUIJsZsRoQxhP5xz3n98foL4LQjy/P5yij0lto60zDoHK6761AaLmWgukPfTF+rxg3WTZy578TlJdxdQ+O65kiPY61375gIDkQLzOjpcLW1T7J1DNA9lMCMaB6tfFQpPDY3LRDGur9LhiOZfB4SQcx+GnhHgKW78hiLprvXW+5Wec7XH4hQuDod1IIIawqo/4zwYhnpVuunZ/hRyJaIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 06:10:22 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8093.023; Mon, 28 Oct 2024
 06:10:22 +0000
Date: Mon, 28 Oct 2024 14:10:14 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Namhyung Kim <namhyung@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [namhyung-perf:perf/ibs-swfilt-v4] [perf/core] 5c5371bf97:
 BUG:KASAN:slab-out-of-bounds_in__perf_read_group_add
Message-ID: <202410281338.59203d1a-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0091.apcprd02.prod.outlook.com
 (2603:1096:4:90::31) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB6373:EE_
X-MS-Office365-Filtering-Correlation-Id: b8bef944-5ca5-4bc6-34b0-08dcf717350c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ceVO9s/q+grt7dFhmM3EbxftgGe9Fxjg+DHqrVunlr+DfnZ6YRWKsT27Osf6?=
 =?us-ascii?Q?0GT7purr64/FmXSNsLNVmYC2IER/sbgMBOzxXtOCIVS0s+2zQuFj10twVGMz?=
 =?us-ascii?Q?bQ/uJM4A+iF/8lA6Yu7Qrz2pQFw9rALLpfgVmcXbc8Gs5nxC9Z2LjbJsGJw2?=
 =?us-ascii?Q?HZBfn/VM5WNvz07gwrbT2rkyM8F/ojm1ljAWtoPlSGyxQhGLP6OU9zvBykLo?=
 =?us-ascii?Q?xmTEcSqfMytQ2d+GlvGbRE7iS78g520ZcEpRChsxPchjvHQctfzjbDqlGFfx?=
 =?us-ascii?Q?hWZ7XnQe2f/4R7nZtnqyGkyDVrZvnvxLm8Cc4tcJRc8uT97uqZfkSKO5Aac3?=
 =?us-ascii?Q?Jv6aTczQ13+BteOExjSV58kj5HlKrT9zIUW1SLg78VJMqADLm3wfIVUkJpof?=
 =?us-ascii?Q?iw/IkKz/rYkPXP6Pcgr41BCFvYhRMmGJkUkb8eJIUNM5Qo28YURI0v4ziAfd?=
 =?us-ascii?Q?RTt5iHWv9iSWE34MYk74vgwBiOfvin0cIaBlOUoLh8TMtWtfxmMOxti385Mg?=
 =?us-ascii?Q?2L63d2hvYPnwNOwswR2rnoVJHwbYitb2DZHEE/OUfjTy9vBpmKby9AEPs675?=
 =?us-ascii?Q?LmjXv8kmOC2LN81uykZcIul9ja87Mlb0LANT+YPcEo6YCJ2lx2NyxoptJMsq?=
 =?us-ascii?Q?0AvDIO9vff6EWwFGbiUNOndT24p8h+KetwH6g5CjpGqxuyBXxvghL/Pj/bdg?=
 =?us-ascii?Q?6FWM5FKgeBJgbhA0/AB1L12CFFG6DXdq6Tct9LDRMsl/QUJdxyLBPeyAPMRm?=
 =?us-ascii?Q?s7PlfTYMdWog1BuCTolDmBlokgyWpqmtb9tkOo8y76sjY0n5aT3b0UFshL7e?=
 =?us-ascii?Q?AypZXM3kvPKrN79eH3CQQMUUIZ6oumU2wU0pRyLrH+bOO24c/Wz0yAjGzNYA?=
 =?us-ascii?Q?pLDIFChY4S8MfFcdLbkHB/Pq0f1Jk8Kq31/8T81nFEJyIoUgE8CiDG/UtJeN?=
 =?us-ascii?Q?zZQttB/E6Yj+iMpMjl3F+NFCldZbqL3UUCnFr5Ka9BEcTstK5BDG3ItXnxeJ?=
 =?us-ascii?Q?Ay/kAKEHQ4K9yllsBi8+03ZQXxzGYDYsiptRNhqdBKWKyZD+9FbAIw8sM5FB?=
 =?us-ascii?Q?RL3TTnBN+39/6sthFQ5qGg71ZHFOFyagVfDtWK3EeLzL3Ruhemafu+8TeDox?=
 =?us-ascii?Q?RYQaNxF605UweRSn/ALsNkicubPwL3F8r4fHTX6ovDXFow0QZEPl6cdRa8Gz?=
 =?us-ascii?Q?PwGMHDqT1HGxwPpYdsZcYIFCEHOocTIPp/HiHcjyQMHd+KjgCnt+vp1bYZwb?=
 =?us-ascii?Q?rdklGnqm7TXCkrpoIbQSZdhLUqy+aDUwi66BCkfkpg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R+aROchakcvnzG6hWYJ3ztSPJbtkH2EQrSBjV5X1E3Pz5RSbM8DZAHBgidQF?=
 =?us-ascii?Q?V/6m3OJ0gvyiTYw1tFRKVYGEvfuhHhYXfqE7jUBATeOay6KgiqOCQN2YrPyg?=
 =?us-ascii?Q?zYzeV3b5fOWnWcJFe1eH/z8ETFnRMEQcfq5VmR34ocVbJlvqZ8iNi/0i6gjY?=
 =?us-ascii?Q?iCWBBgPzaStSD+j0ENzBZkLuwzQIPTJbgYNRR7eg9rTHS1cBYTsuoEDiYmzU?=
 =?us-ascii?Q?lMvuCHt9GOp+TXN4evGNKGkecmKfWSu/Xw1aHHgrt24kQBT9+eMbFOyNMJIS?=
 =?us-ascii?Q?FOqNBnDCeA5J+vfMhvlkMpSf+X7se0kx8RK4NV0zX3sPegCLbEBhymbCKr2h?=
 =?us-ascii?Q?a0Wpc2+igbAa3jwhFjEpchaNi1dVMl5dhu3Dh6tyEHHEt7rLrbf/lHgJNebv?=
 =?us-ascii?Q?+S/d8V+1dVyv8OMPZAPTQbiJbc8FjJc0oZPleC+4O6RECwAQO53Gh5HQa5pF?=
 =?us-ascii?Q?kKzfxQpyE3FU/8VgE5r72DwUamnQb02rsdFEfX1fFYFixQUODpixtiLnu8KW?=
 =?us-ascii?Q?uaZSEcvhVd8p1BQVfWpESFmILysl+50wrA/Ta0mHmBHDiC07Z4KH9Ia1WJXG?=
 =?us-ascii?Q?2MENm0qWXQecNXxHfHLHcnNhOGXl2cuG8NlcbEhxnkrHLFMtcODGQyuBXlpL?=
 =?us-ascii?Q?7DGfQLuVEciAsElVdNceMC+6egx2KZFzU7GVVFTpadKJ5ND2t8kv37I7RqEl?=
 =?us-ascii?Q?uomd3CszSWYN43BdgJAcw6YtbF6qEPGWevZHRLgMciT1NqsJuA1+0zHT3LwA?=
 =?us-ascii?Q?Pp/qYaKX5tdAr/FNv8CCay1N9hRrSkQn7QeZt/2jk62ynx0L+twGIfbCiq/O?=
 =?us-ascii?Q?RbBk2V55gM5DHDdVkCYpmP/eIScWKE36WEAEfHRBKOtir0V+sBr2xbw2hxFj?=
 =?us-ascii?Q?T8lKIsu68PQpuj+Sqyyq24a+waEHVBD1WhpoeROwxZyYH9cjbc8dSY85jO15?=
 =?us-ascii?Q?VjH2LvEMkjeFgqv/NkR6h28uCD9c4GLM9Ymp2vSIVcczVVFxVtSVB+9v762e?=
 =?us-ascii?Q?fnx29SJivsLwrHYvTMn8OzbGlMyKHDZ1TJVLjgBr5sGuaRe1f6NbFj8MJAqq?=
 =?us-ascii?Q?1ze0OqrvB6IeLlGQ85zU1jgnxwkcVrzA+1Pxkfo1lGRHuQqOySX4CH1wmRP/?=
 =?us-ascii?Q?zjYLBhwcVztPTz2fnnOfAHaRAeGyin2sitBU901S6AiZz/xUazy5rYbzJFtp?=
 =?us-ascii?Q?R9C2tNvZeE5/Cc1PU7QLQle14BRS4JEj/+89u9u4VobmwhcMQBYbqqhWcuTj?=
 =?us-ascii?Q?jj+YIaFIFnr+Ri/f/3IHT51/G3W4y1lkOJwlbrKHa8TTH/0KLJsauIHVKxej?=
 =?us-ascii?Q?TkTy5F0Kbmnq2TLomwhS7kVbB2VOR7eBB0UCGSEnJSlonYfK4jiz8X+9QNnp?=
 =?us-ascii?Q?fEvbObGhFahmLIBf9+B+XzO7PrgfOfT0F60xB83ce4qS/FQOaQSAyvTKkC3Q?=
 =?us-ascii?Q?g2f7fWqyvTxj/rhQ2o6d2v0GBmnx6Eu2sJEzGglBRMxO+41D33+dq3GQdpzI?=
 =?us-ascii?Q?Oo4nOyw9cZdCe0f1Ml+Ngwzz24hIDAEssnsMFtejzT+au0Cv119pErd+ATVi?=
 =?us-ascii?Q?kpdUVoJ7aPOqkhmeNDZaGnvNth4MkxxRqi48YUf2DPhogm0AfyKmU+3sFS3J?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b8bef944-5ca5-4bc6-34b0-08dcf717350c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 06:10:22.7786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ruGFEHgRtd6O1Cc2CaPEKfBH8IKHZn5fKZmqKQVDgtztOlEVVtJdUseNNzTWJTskrK+VYk3yKsA8wXFhXL50oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6373
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:KASAN:slab-out-of-bounds_in__perf_read_group_add" on:

commit: 5c5371bf97a3e321d5e032779f1996a0dd054cc0 ("perf/core: Add PERF_FORMAT_DROPPED")
https://git.kernel.org/cgit/linux/kernel/git/namhyung/linux-perf.git perf/ibs-swfilt-v4

in testcase: trinity
version: trinity-i386-abe9de86-1_20230429
with following parameters:

	runtime: 300s
	group: group-02
	nr_groups: 5



config: x86_64-randconfig-121-20241024
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+------------------------------------------------------+------------+------------+
|                                                      | de20037e1b | 5c5371bf97 |
+------------------------------------------------------+------------+------------+
| boot_successes                                       | 6          | 0          |
| boot_failures                                        | 0          | 6          |
| BUG:KASAN:slab-out-of-bounds_in__perf_read_group_add | 0          | 6          |
+------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202410281338.59203d1a-oliver.sang@intel.com


[ 142.100293][ T3684] BUG: KASAN: slab-out-of-bounds in __perf_read_group_add (kernel/events/core.c:5701) 
[  142.101343][ T3684] Write of size 8 at addr ffff88810b667d68 by task trinity-c0/3684
[  142.102099][ T3690] module: module-autoload: duplicate request for module net-pf-8
[  142.102283][ T3684]
[  142.102322][ T3684] CPU: 0 UID: 65534 PID: 3684 Comm: trinity-c0 Not tainted 6.12.0-rc2-00016-g5c5371bf97a3 #1 36c1eff993709d0a36f75e4a1cd3187be70e0857
[  142.105131][ T3684] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  142.106411][ T3684] Call Trace:
[  142.106907][ T3684]  <TASK>
[ 142.107367][ T3684] dump_stack_lvl (lib/dump_stack.c:123) 
[ 142.108032][ T3684] print_address_description+0x53/0x2d5 
[ 142.108745][ T3684] ? __perf_read_group_add (kernel/events/core.c:5701) 
[ 142.109300][ T3684] print_report (mm/kasan/report.c:489) 
[  142.109568][ T3690] module: module-autoload: duplicate request for module net-pf-43
[ 142.109627][ T3684] ? virt_to_folio (include/linux/mm.h:1282) 
[ 142.109639][ T3684] ? virt_to_slab (mm/slab.h:209) 
[ 142.111632][ T3684] ? kmem_cache_debug_flags (mm/slab.h:544) 
[ 142.112072][ T3684] ? kasan_complete_mode_report_info (mm/kasan/report_generic.c:172) 
[ 142.112649][ T3684] ? __perf_read_group_add (kernel/events/core.c:5701) 
[ 142.113134][ T3684] kasan_report (mm/kasan/report.c:603) 
[ 142.113513][ T3684] ? __perf_read_group_add (kernel/events/core.c:5701) 
[ 142.114066][ T3684] __asan_report_store8_noabort (mm/kasan/report_generic.c:386) 
[ 142.114548][ T3684] __perf_read_group_add (kernel/events/core.c:5701) 
[ 142.115189][ T3684] perf_read_group (kernel/events/core.c:5737) 
[ 142.118413][ T3684] perf_read (kernel/events/core.c:5820 kernel/events/core.c:5839) 
[ 142.118976][ T3684] do_loop_readv_writev+0x1e4/0x2b0 
[ 142.119468][ T3684] ? perf_read_one (kernel/events/core.c:5829) 
[ 142.119866][ T3684] vfs_readv (fs/read_write.c:1029) 
[ 142.120240][ T3684] ? check_prev_add (kernel/locking/lockdep.c:3860) 
[ 142.120844][ T3684] ? __ia32_compat_sys_sendfile64 (fs/read_write.c:999) 
[ 142.121591][ T3684] ? fdget (fs/file.c:1129) 
[ 142.122022][ T3684] do_readv (fs/read_write.c:1088) 
[ 142.122378][ T3684] ? vfs_readv (fs/read_write.c:1077) 
[ 142.122799][ T3684] ? syscall_enter_from_user_mode_prepare (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:97 kernel/entry/common.c:78) 
[ 142.123307][ T3684] __ia32_sys_readv (fs/read_write.c:1175) 
[ 142.123734][ T3684] ia32_sys_call (kbuild/obj/consumer/x86_64-randconfig-121-20241024/./arch/x86/include/generated/asm/syscalls_32.h:146) 
[ 142.124147][ T3684] __do_fast_syscall_32 (arch/x86/entry/common.c:165 arch/x86/entry/common.c:386) 
[ 142.124558][ T3684] do_fast_syscall_32 (arch/x86/entry/common.c:411) 
[ 142.124963][ T3684] do_SYSENTER_32 (arch/x86/entry/common.c:450) 
[ 142.125341][ T3684] entry_SYSENTER_compat_after_hwframe (arch/x86/entry/entry_64_compat.S:127) 
[  142.125840][ T3684] RIP: 0023:0xf7f50579
[ 142.126207][ T3684] Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
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
  2d:	c3                   	retq   
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
   3:	c3                   	retq   
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   f:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
[  142.127543][ T3684] RSP: 002b:00000000ff9a427c EFLAGS: 00000292 ORIG_RAX: 0000000000000091
[  142.128188][ T3684] RAX: ffffffffffffffda RBX: 0000000000000120 RCX: 000000005710a850
[  142.128806][ T3684] RDX: 0000000000000001 RSI: 0000000000010000 RDI: 00000000ffffffff
[  142.129417][ T3684] RBP: 00000000a000009c R08: 0000000000000000 R09: 0000000000000000
[  142.130027][ T3684] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[  142.130637][ T3684] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  142.131268][ T3684]  </TASK>
[  142.131551][ T3684]
[  142.131789][ T3684] Allocated by task 3684:
[ 142.132155][ T3684] stack_trace_save (kernel/stacktrace.c:114) 
[ 142.132540][ T3684] kasan_save_stack (mm/kasan/common.c:48) 
[ 142.132928][ T3684] kasan_save_track (arch/x86/include/asm/current.h:49 mm/kasan/common.c:60 mm/kasan/common.c:69) 
[ 142.133306][ T3684] kasan_save_alloc_info (mm/kasan/generic.c:566) 
[ 142.133710][ T3684] poison_kmalloc_redzone (mm/kasan/common.c:379) 
[ 142.134115][ T3684] __kasan_kmalloc (mm/kasan/common.c:398) 
[ 142.134489][ T3684] __kmalloc_noprof (mm/slub.c:4265 mm/slub.c:4276) 
[ 142.134877][ T3684] kzalloc_noprof (include/linux/slab.h:882 include/linux/slab.h:1014) 
[ 142.135297][ T3684] perf_read_group (kernel/events/core.c:5728 (discriminator 9)) 
[ 142.135773][ T3684] perf_read (kernel/events/core.c:5820 kernel/events/core.c:5839) 
[ 142.136282][ T3684] do_loop_readv_writev+0x1e4/0x2b0 
[ 142.136956][ T3684] vfs_readv (fs/read_write.c:1029) 
[ 142.137484][ T3684] do_readv (fs/read_write.c:1088) 
[ 142.138001][ T3684] __ia32_sys_readv (fs/read_write.c:1175) 
[ 142.138565][ T3684] ia32_sys_call (kbuild/obj/consumer/x86_64-randconfig-121-20241024/./arch/x86/include/generated/asm/syscalls_32.h:146) 
[ 142.139070][ T3684] __do_fast_syscall_32 (arch/x86/entry/common.c:165 arch/x86/entry/common.c:386) 
[  142.139246][ T3689] module: module-autoload: duplicate request for module net-pf-14
[ 142.139329][ T3684] do_fast_syscall_32 (arch/x86/entry/common.c:411) 
[ 142.139334][ T3684] do_SYSENTER_32 (arch/x86/entry/common.c:450) 
[ 142.141382][ T3684] entry_SYSENTER_compat_after_hwframe (arch/x86/entry/entry_64_compat.S:127) 
[  142.141559][ T3689] module: module-autoload: duplicate request for module net-pf-18
[  142.141824][ T3684]
[  142.141830][ T3684] The buggy address belongs to the object at ffff88810b667d40
[  142.141830][ T3684]  which belongs to the cache kmalloc-rnd-11-64 of size 64
[  142.141837][ T3684] The buggy address is located 0 bytes to the right of
[  142.141837][ T3684]  allocated 40-byte region [ffff88810b667d40, ffff88810b667d68)
[  142.141844][ T3684]
[  142.141848][ T3684] The buggy address belongs to the physical page:
[  142.141853][ T3684] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88810b667c40 pfn:0x10b667
[  142.141859][ T3684] flags: 0x4000000000000200(workingset|zone=2)
[  142.149380][ T3684] page_type: f5(slab)
[  142.149887][ T3684] raw: 4000000000000200 ffff8881000644c0 ffffea00058f9150 ffff888100062810
[  142.150834][ T3684] raw: ffff88810b667c40 0000000000100003 00000001f5000000 0000000000000000
[  142.151803][ T3684] page dumped because: kasan: bad access detected
[  142.152528][ T3684] page_owner tracks the page as allocated
[  142.153360][ T3684] page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1, tgid 1 (swapper/0), ts 11494771432, free_ts 0
[ 142.155275][ T3684] __set_page_owner (mm/page_owner.c:322) 
[ 142.155879][ T3684] post_alloc_hook (mm/page_alloc.c:1539) 
[ 142.156485][ T3684] get_page_from_freelist (mm/page_alloc.c:1547 mm/page_alloc.c:3457) 
[ 142.157133][ T3684] __alloc_pages_noprof (mm/page_alloc.c:4734) 
[ 142.157761][ T3684] __alloc_pages_node_noprof (include/linux/gfp.h:265) 
[ 142.158343][ T3684] alloc_slab_page (mm/slub.c:2416) 
[ 142.158884][ T3684] allocate_slab (mm/slub.c:2579) 
[ 142.159439][ T3684] new_slab (mm/slub.c:2633 (discriminator 9)) 
[ 142.159917][ T3684] ___slab_alloc (mm/slub.c:3819 (discriminator 3)) 
[ 142.160482][ T3684] __slab_alloc+0x68/0xd7 
[ 142.161121][ T3684] __kmalloc_noprof (mm/slub.c:3961 mm/slub.c:4122 mm/slub.c:4263 mm/slub.c:4276) 
[ 142.161718][ T3684] kzalloc_noprof (include/linux/slab.h:1015) 
[ 142.162323][ T3684] acpi_evaluate_object (drivers/acpi/acpica/nsxfeval.c:247 (discriminator 4)) 
[ 142.162974][ T3684] acpi_evaluate_dsm (drivers/acpi/utils.c:799) 
[ 142.163625][ T3684] acpi_evaluate_dsm_typed+0x1f/0x6c 
[ 142.164399][ T3684] pci_acpi_preserve_config (drivers/pci/pci-acpi.c:137) 
[  142.165061][ T3684] page_owner free stack trace missing
[  142.165716][ T3684]
[  142.166092][ T3684] Memory state around the buggy address:
[  142.166790][ T3684]  ffff88810b667c00: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
[  142.167816][ T3684]  ffff88810b667c80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  142.168826][ T3684] >ffff88810b667d00: fc fc fc fc fc fc fc fc 00 00 00 00 00 fc fc fc
[  142.169800][ T3684]                                                           ^
[  142.170756][ T3684]  ffff88810b667d80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  142.171758][ T3684]  ffff88810b667e00: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
[  142.172753][ T3684] ==================================================================
[  142.173487][ T3690] module: module-autoload: duplicate request for module net-pf-13


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241028/202410281338.59203d1a-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

