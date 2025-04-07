Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C879B335BA;
	Mon,  7 Apr 2025 05:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744002466; cv=fail; b=ts7tGRfb/VBTTG8JwaNDek/avdn5kYJsqZc+ODbkVWImoOC5tspSd/LsQA3OftRqPT6jIQq4Yzdpphtcvka/62VkDPX0Ui88a7zrN3lno/UoNoK6bLGbGvYwBThJIg1s2e4rdL7tZ3rX72L7yQIdpQtx8UiK/kmsghFxb0uXbcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744002466; c=relaxed/simple;
	bh=+luenkTxrsdIs8sePLqWOzJ7FSao9Z3w5CsT8QMcrgY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=QdPSSm5O5kX+SNQC0oploPBf2qOkpCpnNxFQrFyMgG075+B2bjq7Vr37KlDsfhotlE1iIQehDuxhtVEwwkXtfDfrhN24HoXzyIFgTZEVf3UNxhCGCR9Z/fTNNLUecf2KD5coRPIpeY/HICjxv+zrS9L+6CeWotcr/lZjWY0Aw9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hj8L4VQp; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hj8L4VQp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744002465; x=1775538465;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+luenkTxrsdIs8sePLqWOzJ7FSao9Z3w5CsT8QMcrgY=;
  b=Hj8L4VQp7wPS3xNt5rQZUwLwPpskCmXRK2SuFgrvAFCuvsdbzzwR+OVt
   ixd4aYgwYBNDHEimGSY5xvc15Svrcjq7dP2G+WBzJV4Bo4O5/Hf/e/AiH
   LcoiN4vQ4GrIlLGHvOCzWxvFNPX/C1V5ZxMvqt4bgBSo1eQr1njHQV2hU
   49PMTO1ppXWRr0Jo5i/VTYk2mxFFSJkD9McYDmgs58/XN4pZf8uQVq0ZA
   Q9u8dkQgm28TauvmpxAczm5FzMbE3JEyMU2M2eU8bNTzGfbiH2/pPYedQ
   V5DT9CeVmyVNUXD8wbi4faaPLsHiZ8TXTN3mKLfCCriCWmipeM2ZLx8ay
   Q==;
X-CSE-ConnectionGUID: sEyp9EUET+CKg5v57Z9www==
X-CSE-MsgGUID: hqxuyTXpS8eZPDXfyx114Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="56003770"
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; 
   d="log'?scan'208";a="56003770"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2025 22:07:44 -0700
X-CSE-ConnectionGUID: ltpmEGTiQe2DfEwXMuRpIQ==
X-CSE-MsgGUID: 7tyzdds9Te+alv9c+n1qlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; 
   d="log'?scan'208";a="127685980"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Apr 2025 22:07:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 6 Apr 2025 22:07:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 6 Apr 2025 22:07:43 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 6 Apr 2025 22:07:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lt7SBwEM2hHRG7ngslo3CLzHwZg0XjUvLSIUCjufagCXZBF/ay4+FaZyxR1GHgMDbEZAult5780lSCEGHlvwjd+phmOqKoUrVkfIU4Jf6rvS6lo9AOyzGvnAujLTr4hZwN99JTc5fNafyjurbEkATAgC24m6+iTEkXsODuPbrAGy/d9YKyVjj7Nztod3Nf82KxrkxBlWllfJQsqNWhZdxE8eB59EdBQOIHVME4PYFHADzFDUYCbV7f4O0PPOWdc6fQWKV0EpXf9mHvbjpDtX2FPzXjHFGzxDoewGjq4Cq/8ZfDHpJq+Ls0as4kf5kjd5qXbrrB01xlelnFa2c+EOIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlg7cnyHxuT7kZhluWZRJwY2gKcKe/o6QpxQsna6gws=;
 b=h5jnUboZEQ4kgefxZ8EekTqV1tnP0PVnRksVLeS5ASsCpdIPkq3t8Mf2X5QIgdILA5vbGkvwHiLwUVjGY1G8EQyT0oWQL+09Q9Fbsuxypi130DtdANWkG7Fz9ljrSQ54gv6Wv2AB6tInBFx/wemLZw4VDIbg94xzGhlkURuH8Tc7tMAj6lEI2XdhLbvDZyU5fgWHFO9gevgAS+UWB9HVLd9YDMPDqbi9pRB+kH9gi4PZCfTDoExY0HxSn2u2riT/01NbdFCLthJLzIh8MPBAZwM1bFKBURNVZ/Gpuj4JqpoMY7ziAwp7Kyw4FElntGaI67mq1+wK2q3Ejl2GVoC86w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MN0PR11MB6253.namprd11.prod.outlook.com (2603:10b6:208:3c6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Mon, 7 Apr
 2025 05:07:27 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8606.028; Mon, 7 Apr 2025
 05:07:26 +0000
Date: Mon, 7 Apr 2025 13:07:17 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Kan Liang <kan.liang@linux.intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>, "Peter
 Zijlstra" <peterz@infradead.org>, <linux-perf-users@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [perf/x86]  88ec7eedbb: kvm-unit-tests.pmu_lbr.fail
Message-ID: <202504071232.3c2fa7d5-lkp@intel.com>
Content-Type: multipart/mixed; boundary="A3gEDkc/lJ/+Stz+"
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
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MN0PR11MB6253:EE_
X-MS-Office365-Filtering-Correlation-Id: fa69226b-f952-4fc0-57ba-08dd759216f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|4053099003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?61IrfXD3wzaI+ZuhbeBYoDphPsT4C1CJcrqBVKlbAoFXoJ/pwjxqyTfQoDor?=
 =?us-ascii?Q?i8KMNhn+zQ1g11WefwdxcJC/3Ufk0FasPley16xVrfa0TZnbsgkRDtKmxqFC?=
 =?us-ascii?Q?bg09vMcCbKdMRsN37/pLLE3R/gk1p1WigKfxgsmZ6ByGa1DDIcn4CAkADLXr?=
 =?us-ascii?Q?psTUpaX4KUJ7X1SDrps5G9Lgu9G0qo7sutpmiGZCoPBtJ8qokjVXA4OcsCtc?=
 =?us-ascii?Q?zODDdmg4tifP3PSs3CFyL37ZILeSFHOK5mu+NRc5WiAIN1JVKwwzFLbZAZH1?=
 =?us-ascii?Q?hOO0PBkOZztFN5fuTBOFwmN0VjAgS5nGIKJKn55qEGdaz8UInc9JMTLavdrq?=
 =?us-ascii?Q?P+yos8J+PGwYEErw5jVE7fj8+lYy4+eUAjI5GbMJ6BO9nuqOUhOny3fknxCf?=
 =?us-ascii?Q?Sq5RKhrSpYZNI4RLDVZwIl7isoEsFzN/ObUlsowDOuK2RLXfUZxi9oXy8812?=
 =?us-ascii?Q?GuvW1dgawVDFr9mf44VcVNNuR5DBRrRVwjPp1SLfGxVRELPWOfTCL46ruRE4?=
 =?us-ascii?Q?gi4A6PskTrTD5NEE8u3sekE2iJTs+AKi4ved6a6E1hl32eHuB4woN/RhQgtT?=
 =?us-ascii?Q?bYG9wChHymgm31nZoe76gU4Rrvc9sDMrBSeaSM3mzG6MIaD5s5hdKsd4i6aH?=
 =?us-ascii?Q?jN//cYNaAuMtvl4dfpZGi8kcdyrKFCRtK7/I0khLpw0zfXfWyH4eVuytU07J?=
 =?us-ascii?Q?4bKfkRhfZTUszs6rD8raRHt2A8azIrXRO5opPDFtlTjvgQyesYWrIT8s6I9/?=
 =?us-ascii?Q?c9vJxPZXE4c/gK3ybQ23pGt65ozY9nT9057kGTgWINEQMpyyhas11o2zadYn?=
 =?us-ascii?Q?22HPzv4sFa5LOmGw7SyKASuIB7axXKnmK84I+AiV1c/Y+KXun4mjMklE+zpR?=
 =?us-ascii?Q?vfk2Iqiu5AjeiywHIeGqy4JmLpIEzQlx+pX4xW6EF6honAKhuOb0XoVdosD5?=
 =?us-ascii?Q?5+8mOzyEu2Rt5IOBWWh48sSv6ZrM9pL62D6JS+I1f+VceIvknnOarj9PEQKM?=
 =?us-ascii?Q?UbIpCaAuluPR6M5MYdh2qMvXKlNBVnO2LOrUmvnRH9absfuFgRtQL34SrpZ7?=
 =?us-ascii?Q?MYBV+PC1fPfmYsN229IU+TBaAZ7Y/Lji69WWa6QEqviBhW+Bg6hj2DHyWGXx?=
 =?us-ascii?Q?fSD44fCe2X7mp8LHuuHSFhkvPJYELaNLt6Z3RHSiLYQsDJOaBkjrRMqrnX9j?=
 =?us-ascii?Q?hzaxBjd6j4inNRDNZ/oaoFK5y6cQkNRxKDrPRyWh90AGGVyeuhmSCKZRsX1S?=
 =?us-ascii?Q?pD3PfBv8DEUwYqQcZQZNSC+DGvPgqEDuW4VCiin/Y8wXj+GwZ6c+xxm6dYtK?=
 =?us-ascii?Q?nBAFQl4VxrO9Yjlp0AGJLOWwKOkVtKYGMgOtmVFdMPqRkOCXunEn1WR6CrnM?=
 =?us-ascii?Q?qSLNLtShGZ0zcApwVN4rpwQPjhuM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(4053099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6HZK67tnpqiEpwQqNmT3jycFENEVhf8DgQYwBjuQaLGma9psYm6c7FIYcglK?=
 =?us-ascii?Q?XdvpGE5pVkqPbBoXicw0RjPs9CW1zsXa+mwXpksPuOP+d9X1kzkBboD7/QnO?=
 =?us-ascii?Q?GUmpsHctn01XeuXob8VK6iahXCxJ21D8Xbf6B5CWTGKRva/FGRhZzO+onydN?=
 =?us-ascii?Q?EPrOuCBPMpEi5LQ7HEJ0x8M/6PfcdUZO+h36ght6AB9TcuJeTrHqrBS7UpXX?=
 =?us-ascii?Q?89cTJ2rCNI/p7ww7uotW6MPykT3G+YumYtKNGLIgTgg4buKzPDlVYeTBasr2?=
 =?us-ascii?Q?1OaKVrFQ6kUx7O21Mb5qemwOtRRYM8GH1QtLhp1Cx1yYVQ0KiBV2qnPZjCtn?=
 =?us-ascii?Q?W8AFkOtk7eXCSBJde45sE5LQx3fDjb7Aqnae/DlJH92QvagwlcNEVjSXFyM1?=
 =?us-ascii?Q?Y3Keu1dzzbb15UZi3YjBs/ARSml0Ooes6B3Ljky/MMTZVJtt+bs93MER3To6?=
 =?us-ascii?Q?0rg1ZLSmcaQ99tWdSz3qhs3VsL2DagywsuzS4g6GFWeR0UHtciZ3qfr6YVgq?=
 =?us-ascii?Q?pEUrn4xPB6HEujntoc2i3duEjOzJBNORcM+Yp9au/GDZimxoaPhA/2tL8Yad?=
 =?us-ascii?Q?VrHV6RNfMRMyJvkanYVOH334pCjo7dqMzu6rSGR+czgo+fS+bTcp1BRE7aT/?=
 =?us-ascii?Q?7jhTebASI38AZ5xLh1Eq4Mq7rhWH9idymEr7NcLt+gW5k1RvASE4Sd0iifFz?=
 =?us-ascii?Q?Jo1WV5GNt2ApGh4xU8be+8y9yZP0Q58MKW9ZmUk83fzwkw1faDhOw+HiiJL6?=
 =?us-ascii?Q?X5p3r+mSBx2t4AzCdQsshmgJKe6aSoo/4jnYFxsE1VNh0NbeoMgp0fmeVwDc?=
 =?us-ascii?Q?UDHX1i6YKduo3hIfCSMNREKhZ1F0WOYDvX11qHxhrEzl/9i86G/btRrMQVQv?=
 =?us-ascii?Q?2AENJxQSHUbDMHWYzT6nb2p83nWU+RGwgBXh0M4jRO4TdhAxaxpJqNRWUw6B?=
 =?us-ascii?Q?xPpD4a5LRvTm5s8YSTjJeJWNl1sLtYE5/TXvADlhJtRGLGFWtxzaVC/pty2q?=
 =?us-ascii?Q?8qFIMxlbsGdp40CarYO1Mn1oaFHLsPckhQhVf8X6ikJRAT8Lk82nrPsZnwGQ?=
 =?us-ascii?Q?yfhr7mt07R6jy/tY0jWT07u2CISxJpEsqrNZddXX4MWXXTwatYINddmSge4M?=
 =?us-ascii?Q?lslgLhFoYItyCJoBmmwQCpu29YfaTSoSndnOObG7CriHRfFvaNe3h9lbNafT?=
 =?us-ascii?Q?SLK6SkA3eXQqk54fYfhZsJryQF2YllYCUj7xM25CtwhGw+X5ZQNFR2goMMf6?=
 =?us-ascii?Q?+K5Tg4Ny7ISScJ/lvi67a9phjGFmEV9THyxkKm77Cg+4uTrcUnqvCtlIzmhG?=
 =?us-ascii?Q?QlwdocZiDEcYF3vGVfKo2SoZ6P37BBSMG8+B1gklGRgixcUOGHZ4PtJxTPlK?=
 =?us-ascii?Q?99qIdpgbGX0HGl5aH7xoQDH7FEJ59xYNOBFO8Qjcxa5RVnFin5/23y7zdABu?=
 =?us-ascii?Q?+LsLK9ViyMQZO8JpTpt+Oh7EKJ6a/DvQl0j5K3mah1vlWvxDXOMyySHrvckF?=
 =?us-ascii?Q?B0rD65O0KMl0n1oAvBLJ8csZboRz8vGhjnLH7B76Sw78zmAL/cuNDuWzgd34?=
 =?us-ascii?Q?Z7BVNOhwhZhZVdDsXS5h3QMCYjG32GnM8vAVdQwJdRYEWvqCtCQmrUEksEcF?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fa69226b-f952-4fc0-57ba-08dd759216f7
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 05:07:26.8612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qjnUNyphRDhhqF7FzMmNfK8H6OiR3kQM6tbHno3WdDbtMNu71aGfy4h96NsMxUSartGKVON9sNDDH2n7bUJSew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6253
X-OriginatorOrg: intel.com

--A3gEDkc/lJ/+Stz+
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



Hello,

kernel test robot noticed "kvm-unit-tests.pmu_lbr.fail" on:

commit: 88ec7eedbbd21cad38707620ad6c48a4e9a87c18 ("perf/x86: Fix low freqen=
cy setting issue")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      0a87d6bb6fd274cde3bf217a821153714374198f]
[test failed on linux-next/master fefb886b1344e222b3218f3c0165b0fd770e8b88]

in testcase: kvm-unit-tests
version: kvm-unit-tests-x86_64-69574079-1_20250322
with following parameters:


config: x86_64-rhel-9.4-func
compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz (=
Haswell) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202504071232.3c2fa7d5-lkp@intel.co=
m


...
=1B[32mPASS=1B[0m pmu (143 tests, 14 skipped)
=1B[31mFAIL=1B[0m pmu_lbr (2 tests, 1 unexpected failures)   <---
=1B[33mSKIP=1B[0m pmu_pebs (1 tests, 1 skipped)
...


one log is attached.


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250407/202504071232.3c2fa7d5-lkp@=
intel.com



--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


--A3gEDkc/lJ/+Stz+
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="pmu_lbr.log"

timeout -k 1s --foreground 90s /usr/bin/qemu-system-x86_64 --no-reboot -nodefaults -device pc-testdev -device isa-debug-exit,iobase=0xf4,iosize=0x4 -vnc none -serial stdio -device pci-testdev -machine accel=kvm -kernel x86/pmu_lbr.flat -smp 1 -cpu host,migratable=no # -initrd /tmp/tmp.1JDHego9zM
enabling apic
smp: waiting for 0 APs
paging enabled
cr0 = 80010011
cr3 = 1007000
cr4 = 20
PMU version:		 2
LBR version:		 4
PASS: The number of guest LBR entries is good.
FAIL: The guest LBR FROM_IP/TO_IP values are good.
SUMMARY: 2 tests, 1 unexpected failures


--A3gEDkc/lJ/+Stz+--
