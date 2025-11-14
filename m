Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447832F547F;
	Fri, 14 Nov 2025 07:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763104487; cv=fail; b=hBPHuoSzYq9t4oRT40MCaTWP3C9UIjX6b3Fcwjw53LadxjuAGYqz6s6593eLm9zPY6LSeMcvF+NjkDDTxRs65AONqx4VnlUKwCq5ny8C21QzIS43d4yTH+4xSk9H3XDx37Z78hLD6ctQfkfHEHu2wQVCTS5zK3NIe9yDwaTxjns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763104487; c=relaxed/simple;
	bh=F+cV9XAsifPJe26WMRRBYldd5BZTDZekXuk6cbRXLVk=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=tx6SU/Zry5hPKzv/n46jMfnwR9CgQmuEQvfkw05I0PL5iNx5oXogiROeOB8lNhmum6qYqXJTpLBI7np4DJFHAo92wXkRlSWNNwxeB2mpEqclpfdsGxmY8dtsb+JhJrA3vkFMfHZam/Lyfo6NsK9p8s1MkcXPZSrlIe6LMyfovC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wuzwc56P; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wuzwc56P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763104485; x=1794640485;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=F+cV9XAsifPJe26WMRRBYldd5BZTDZekXuk6cbRXLVk=;
  b=Wuzwc56PxFamUCzCC+51kbpYynXCLJUcaD9fEQLfaNmQIEhzj0GEQ44u
   x93k3kFCdb/IM9Lge7u9Hn4TolXCH9+cKg6fBkUh2DNTVIHbIyr/uUZGN
   XAj7TJ9g8qGokisQfpG2EbNDTGyeVCTv7V7YMfu0SEnjNQq/AWay8Dhqb
   SKNtccEyYZ5IsrJu1ztPjZ5FJlGix0y028JEttc2ePmikZYRTlJg6DQgE
   06WNEhdQO0MUqrF9cpxW7I5wkxseBQ79D7gnBc3CqhE4ZgW1IREHAj5bL
   BCHDftNSQjc6ygKg9pHhTp3cjE6CjPWd81mAoaa2Mq16M49Q3PhRCKm4Z
   Q==;
X-CSE-ConnectionGUID: qd/KeZN5QpSX7e10LTm0gA==
X-CSE-MsgGUID: K5msBRR6RJK4Aq70pTrV5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="64402641"
X-IronPort-AV: E=Sophos;i="6.19,304,1754982000"; 
   d="scan'208";a="64402641"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 23:14:43 -0800
X-CSE-ConnectionGUID: WgWgPtAORummPz72IuyZvA==
X-CSE-MsgGUID: VFafgUl1SOWrzPSK3FNG1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,304,1754982000"; 
   d="scan'208";a="227067970"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 23:14:43 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 23:14:42 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 13 Nov 2025 23:14:42 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.65)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 23:14:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RCxiUa/srX7lzY3haWlM/WSpoQTjSDNbH4iVk8ewVP0x7m1HJyrmJZocAv0eEJkdiMnVYliJB+HJUHnAuJS/RVKLJYyTkNxRvKAvyUQZZ7uanRO8gQjXDwjzL0YsUKQzGugR+6HWpHTlmq+tfV94XQhDmg5oRXiM1DGb49s3L0qlyHi6XLw1LfAEO74a4dQMS7rC+14LnWgnGavgyiavc5+tTwebC54EbCazPNEsQY5PFZ5AAjW/nXpnVMRfT2b/H2SMbqeaTWNPdZXuzdXTVVxzDaOTIMU9EMXuhz5CqBMjRtEwsrD/zWWtU6uj1dkPTdzRMd0O1z0rYjnog8ZiiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEKG9tuPv6Dj0PiijI1s3KvuONQo/9loHO/YLpjIR/c=;
 b=YfojiHCnKQsMgq2YwqCzoNGNcE8yt47HibD7RFA/SxOBIKfGBn5vL7hqnD0O9BcQeq/86P6pw3Fvc+49ddzDuUf9Zt59WI590tLfRW3iYem5voZmj8ye2ixOqOKDl9yS5E9/db6FjJS3gNM8he/c+dhqbkk8XicsXiMCutfdzHGRYwcYQVKqgxJf2fwXmt1LkveX2zuN8TFAcv3V+P+Ypj2HIJHGWh+oye6fugIivrUv87u6J5FoFP65AfO0k+n0HinAUNnf45jhta/ouhERYqYiG2UjLerVgEv4+aL67wsxxVrnPrCZHdOkB3vJ5UpvH/AdQCwSZ4Fc1JU92MdgxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com (2603:10b6:a03:568::21)
 by CH3PR11MB7843.namprd11.prod.outlook.com (2603:10b6:610:124::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 07:14:40 +0000
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::fc95:158a:24ce:885b]) by SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::fc95:158a:24ce:885b%4]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 07:14:40 +0000
Date: Fri, 14 Nov 2025 15:14:31 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Namhyung Kim <namhyung@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Ian Rogers
	<irogers@google.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [namhyung-perf:perf/defer-callchain-v3] [perf record]  6bd89ae7d1:
 perf-sanity-tests.Zstd_perf.data_compression/decompression.fail
Message-ID: <202511141407.f9edcfa6-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: KU1PR03CA0001.apcprd03.prod.outlook.com
 (2603:1096:802:18::13) To SJ2PR11MB8587.namprd11.prod.outlook.com
 (2603:10b6:a03:568::21)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8587:EE_|CH3PR11MB7843:EE_
X-MS-Office365-Filtering-Correlation-Id: 92c8739d-ebf6-4645-8acb-08de234d7a13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R+mdtgxhpwTyN+Zu3Y+t1ipEOttfVZZs2Xw1aGk3tTnPKJLonohk9bBgEY0I?=
 =?us-ascii?Q?zQEkfw0tLbT7YHiL6op2+psSY081dK61U3hYiA/ckTC57Z4WuULGQiCPeiCh?=
 =?us-ascii?Q?TdA8LuyjTV5V4BsRI8LAL8iWGyLKbbbA9+7pnzHiObD47S3vggFL7mkhfmlT?=
 =?us-ascii?Q?cwkElvEQOeJpf3JVHJrMFkzZugS7ryQy4Edn/+h5HpIhfS/d6crkbQ3yD5lA?=
 =?us-ascii?Q?7wsa/WCCJZ2woqV7RsLgVrTGenlLQiydTSHKCPw0anBoWqoEMU10TJ/qZ16K?=
 =?us-ascii?Q?d2tucyk0vFEtB+rftf5GLnrhK2Z2V/ML+oL+T+9okHul8ip5ybC8LWpytGLU?=
 =?us-ascii?Q?Vg3QMsbz9SrM5t0Fe3szfo4pyc9KlheoDmIUPITN+Yx2Mp6ZM09FkrAzmBTn?=
 =?us-ascii?Q?2KUkdL50CESk/I3vsuUnUm3dg4sSr98M9aZMria5izKvMbQq5A+xvgLksVsk?=
 =?us-ascii?Q?w3fwm8wWF4l/WSraNKnO8Yw40uu50HcEnXoC0sh2FqpWrZN/0fuQi6ImB9cD?=
 =?us-ascii?Q?UJxq1je9T8wRO7SWrvJm5g3Su9Ns1JNmGhrceUxAyfHjkoPcH5rkrLqVUuXp?=
 =?us-ascii?Q?/5AUTYh9rrOmAiUl4vGSTZ+kp8mDae6rhs6U9pw/Yb2NY0BsosGBE4jW8QgZ?=
 =?us-ascii?Q?he/1/fqkrRWw4+jjYDipDvLlCsOpwDI38k6kHQFzg99OwPOM5pbnGZMr9HJ7?=
 =?us-ascii?Q?BI7u4uuNAxir7jS2Wo5wTQ/EDrImXkDHRqaRUSxDKz6aJqWRgRFNQd/SzgaV?=
 =?us-ascii?Q?qSMk4ShSK71RuLWaoVJ42fi4wbP/c+qJDVdLMMAN6aPwnB247dHP0TstdTmx?=
 =?us-ascii?Q?QIE4qB4f4tAhhM8EMbtuXyvx5cDfYLkxcZPtAJSCJ/B543xIQ5+Y7RM08ewy?=
 =?us-ascii?Q?PdgyIpEy3k99DGiqujKUqC1H9nWJH3lArW14+Q5J18I9pR0SzQEISaGYsbne?=
 =?us-ascii?Q?3KF7LmDuPyCHja4hLmArXli7fQsUPMRpEcebWr2OxQ83jxWwCqCpB2dVe+YJ?=
 =?us-ascii?Q?0hZBvlUSifi5YzOpX6kzL4cXNusmimFqXvIcFHt7VaijTgcoJHdZ9Bozs2bj?=
 =?us-ascii?Q?wz1k2K3sLYr9EZ1BCm0g71UN2vHgV0Vp0ZSeHuVh4DeOtvMlZ6K21+cdalFE?=
 =?us-ascii?Q?CPWBjjyy4GCwhQaIV9TSWxoVxFQY6+OphW3tvCkSRrYRHciDE3scEvNzivsC?=
 =?us-ascii?Q?MjFNqiipHJTJ8dTxLTmCQM5TTZ/ysjhBwFL5RhH3f6Feom5mC0nwGjGGJsR9?=
 =?us-ascii?Q?PXLMeHtbTQrxmhtDdtdKTGb5OOE6g91ySeckB+2FC4/j5Vj2ZCI8ESlGsvzT?=
 =?us-ascii?Q?9dPuUP8tuQh9JBmHfxR70w21hsG1KkEVd/16+9ERZBiCPbqcfY8kdNgjRcMa?=
 =?us-ascii?Q?KihRaAryL/R3cUaEJdoVJmfqp2m6Knzonb+qOG7iKt2mI/IBOfU4X7wCsevJ?=
 =?us-ascii?Q?DFyJWs3hTRleLXu3muRE4GmZ33FswV2tYC0wRBvJtBR1FG4EKX0kFg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8587.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w3o5Wil/JIGONN+zxHagB/xlI8lrFRioL5S+wiO597x0UHFDK0GbzdTqhgMO?=
 =?us-ascii?Q?inCjQlmALQPFfyrqjPXaHN6MrjtOYjkTlnSSpJTh+TiwA12jFp+UkSx6L6Y2?=
 =?us-ascii?Q?PlneMEm3zUYSqkKYvv7tW8YdRT3EUs0lvNC7/P3fiG/GHMIDaXzs4J7fb/HF?=
 =?us-ascii?Q?oK3HIx8mvCeypohsYHzSSrF3qucqG9Kl2qOQ8Wi8XgABrOdgMd3FzqFeyUKq?=
 =?us-ascii?Q?o17VohifJmiHYkQrHp+7/E0oTPV8jBSX9e2lI1+zldjDUQO/xM2rmLlzj/6R?=
 =?us-ascii?Q?zlDa0nV3sIprAOFIo6FhFI01/yEtP546SXSZjpT5AQvCG2eZUjf4Q09S3uFv?=
 =?us-ascii?Q?mkFhPHL9Og+wviTSAIXlMVkT1XlWwipcxv7DZci3cv9egIHBPeajZ/Jimicz?=
 =?us-ascii?Q?T3HkOnpuSQkG8qG5HnGR+BkoasGaTNtp3fWCUQmh93142qSGHAmN5x3mTTgR?=
 =?us-ascii?Q?YaQ81ddjvb+JGCKYRKDfKOLDdpbc6cB6qAOJYolLng5FHqEVfFuKIwz4PVlR?=
 =?us-ascii?Q?BRMLP6KRD7sByD0XTJB/nvQabYnKwv1Yo7X0IwivMRqJ4Ci9VQLp86y1tcR2?=
 =?us-ascii?Q?mEl+qCx6Cml+VJptBpzBWmfhrmHYrj9o0F6QRjBx7cwIoAkGXfOZowMDTkUG?=
 =?us-ascii?Q?2aQEDa668q3E70DsxtloNZTcCE3NuuNyvphXQQeCCybxYn3zup+vJ5uw1dYF?=
 =?us-ascii?Q?OjztZ8i+xGHKNGSzx6hFQRU0LNgTCQXVZ0SRvQHynNQiReAkuczlReEeFFJ8?=
 =?us-ascii?Q?6dtrPc3TQI3rRQ4F1tdpHNpGHRE80cKRRMV+FkiNW/ZA1y4wUzAhvUMmzVGO?=
 =?us-ascii?Q?EvsCN/HhhBqM3hhWF7r1AlEKg51nmx8oAn1xn8a4bdN32OG2s41MOa3SGL92?=
 =?us-ascii?Q?t0Oz35Wu68+Zo9Or++jIlzDIoyLw4pkYH8M9PcGMVUMIdyZ3sYlkAwAqP+p3?=
 =?us-ascii?Q?yFTVFZDfPUlwj7HznOIdFhDNV/yu8ih6q6pAaZ7UYzGB43Ga/89IwQz7fGaV?=
 =?us-ascii?Q?16nEgU18NM0d8Cih8QMz+GvMBpPVg22UOy7cBav0v3ZJscH5ZJJtifXEV8bn?=
 =?us-ascii?Q?Px2To49xgZHkuXhvZCUV+pId0d+XqMxd9rfPzHzmcFd0Of4Oa2JKniSpAHT6?=
 =?us-ascii?Q?gWgrv1diGIxIp9ofUsgR6JM1aZMxfjcvMxDv7l4ZXj/QhaW9HJskTeKRjNJE?=
 =?us-ascii?Q?uc5MaT0k1AJfpf28xMVRFzF1BbQbzj2Yg5P0R6Rx0AiSNjYD6wroGTtGxBOo?=
 =?us-ascii?Q?SSAI0zQGP/upNZnUIS50ME4GcxWeYB1Fx10AA6sOU+ezBvlVDqiYPDwngt54?=
 =?us-ascii?Q?YtPUOcXGCE2l39CyBazc6zdKBAqK3L/4uwkteKDFXZghiaiB2fxMQiikV3Ea?=
 =?us-ascii?Q?2b9xNnkeLMmVWVwKUQHtWPiOiwd5NRvF4Zv+lILW/KpTfPsFk2p60vgHZvGA?=
 =?us-ascii?Q?WQuBWh6ZEKPdOdvXOO5hklyE5QiSw5+Pac19RBxkjy87PaUYG1Dflu2TzxWv?=
 =?us-ascii?Q?W2I0VTeXdFctzh1sz+Y81THR9Hl7MABmS+OYuOg+olWNXtlRuXjZsYeWEavR?=
 =?us-ascii?Q?CSqwgiYRArsDor8Aw3rgO8PsB4DAvOpFe1WHET8hgGV65J6opQRXmgWAShe7?=
 =?us-ascii?Q?3w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c8739d-ebf6-4645-8acb-08de234d7a13
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 07:14:40.2072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OHo8O1wSuat+ycAq24Y2MbbTYQzwxFu5ySd5S6da7iE2efqAg8SqGARIpKgm+l8hYETK4yMU9+yX92O8dwdi8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7843
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "perf-sanity-tests.Zstd_perf.data_compression/decompression.fail" on:

commit: 6bd89ae7d14788ba15e25289479addcb98e7dc26 ("perf record: Make sure to update build-ID cache")
https://git.kernel.org/cgit/linux/kernel/git/namhyung/linux-perf.git perf/defer-callchain-v3

[test failed on linux-next/master b179ce312bafcb8c68dc718e015aee79b7939ff0]

in testcase: perf-sanity-tests
version: 
with following parameters:

	perf_compiler: gcc
	group: group-02


config: x86_64-rhel-9.4-bpf
compiler: gcc-14
test machine: 16 threads 1 sockets Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz (Coffee Lake-E) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202511141407.f9edcfa6-lkp@intel.com


one thing we observed is the test still can pass sometimes. as below, upon
6bd89ae7d1, the tests failed 14 times out of 20 runs, but those other 6 runs
really pass, the log is just same as parent, which can always pass.

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/perf_compiler/group:
  lkp-cfl-e1/perf-sanity-tests/debian-13-x86_64-20250902.cgz/x86_64-rhel-9.4-bpf/gcc-14/gcc/group-02

4df43709370cc18e 6bd89ae7d14788ba15e25289479
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :20          70%          14:20    perf-sanity-tests.Zstd_perf.data_compression/decompression.fail



2025-11-13 09:14:20 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-6bd89ae7d14788ba15e25289479addcb98e7dc26/tools/perf/perf test 89 -v
 89: Zstd perf.data compression/decompression                        : Running (1 active)
--- start ---
test child forked, pid 13474
Collecting compressed record file:
500+0 records in
500+0 records out
256000 bytes (256 kB, 250 KiB) copied, 0.0023166 s, 111 MB/s
[ perf record: Woken up 1 times to write data ]
=================================================================
==13482==ERROR: AddressSanitizer: heap-use-after-free on address 0x50200003ddf0 at pc 0x557d1757c895 bp 0x7ffd3008e670 sp 0x7ffd3008e668
READ of size 8 at 0x50200003ddf0 thread T0
    #0 0x557d1757c894 in maps__by_name_index util/maps.c:423
    #1 0x557d1757d476 in __maps__remove util/maps.c:535
    #2 0x557d1758107c in __maps__fixup_overlap_and_insert util/maps.c:956
    #3 0x557d175811a8 in maps__fixup_overlap_and_insert util/maps.c:975
    #4 0x557d175568a7 in machine__process_ksymbol_register util/machine.c:756
    #5 0x557d1755706f in machine__process_ksymbol util/machine.c:824
    #6 0x557d173f2ceb in perf_event__process_ksymbol util/event.c:301
    #7 0x557d175986f4 in machines__deliver_event util/session.c:1349
    #8 0x557d17598d60 in perf_session__deliver_event util/session.c:1386
    #9 0x557d1759c7a4 in perf_session__process_event util/session.c:1682
    #10 0x557d175a3e5f in process_simple util/session.c:2259
    #11 0x557d175a2e1f in reader__read_event util/session.c:2188
    #12 0x557d175a37c5 in reader__process_events util/session.c:2237
    #13 0x557d175a464e in __perf_session__process_events util/session.c:2282
    #14 0x557d175a770a in perf_session__process_events util/session.c:2446
    #15 0x557d16eb78e5 in process_buildids /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6bd89ae7d14788ba15e25289479addcb98e7dc26/tools/perf/builtin-record.c:1570
    #16 0x557d16ebc3ad in record__finish_output /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6bd89ae7d14788ba15e25289479addcb98e7dc26/tools/perf/builtin-record.c:1894
    #17 0x557d16eca47c in __cmd_record /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6bd89ae7d14788ba15e25289479addcb98e7dc26/tools/perf/builtin-record.c:2966
    #18 0x557d16ed804c in cmd_record /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6bd89ae7d14788ba15e25289479addcb98e7dc26/tools/perf/builtin-record.c:4453
    #19 0x557d170e9a83 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6bd89ae7d14788ba15e25289479addcb98e7dc26/tools/perf/perf.c:349
    #20 0x557d170ea374 in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6bd89ae7d14788ba15e25289479addcb98e7dc26/tools/perf/perf.c:401
    #21 0x557d170ea8ca in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6bd89ae7d14788ba15e25289479addcb98e7dc26/tools/perf/perf.c:445
    #22 0x557d170eb071 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6bd89ae7d14788ba15e25289479addcb98e7dc26/tools/perf/perf.c:553
    #23 0x7f986fa0cca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #24 0x7f986fa0cd64 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x29d64) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #25 0x557d16e55250 in _start (/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6bd89ae7d14788ba15e25289479addcb98e7dc26/tools/perf/perf+0x1010250) (BuildId: dcac6dff4df47b4588a4b1759f9412523bee60ca)

0x50200003ddf0 is located 0 bytes inside of 8-byte region [0x50200003ddf0,0x50200003ddf8)
freed by thread T0 here:
    #0 0x7f9879ce38f8 in free ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:52
    #1 0x557d1757545f in map__put util/map.c:312
    #2 0x557d1757d37b in __maps__remove util/maps.c:529
    #3 0x557d1758107c in __maps__fixup_overlap_and_insert util/maps.c:956
    #4 0x557d175811a8 in maps__fixup_overlap_and_insert util/maps.c:975
    #5 0x557d175568a7 in machine__process_ksymbol_register util/machine.c:756
    #6 0x557d1755706f in machine__process_ksymbol util/machine.c:824
    #7 0x557d173f2ceb in perf_event__process_ksymbol util/event.c:301
    #8 0x557d175986f4 in machines__deliver_event util/session.c:1349
    #9 0x557d17598d60 in perf_session__deliver_event util/session.c:1386
    #10 0x557d1759c7a4 in perf_session__process_event util/session.c:1682
    #11 0x557d175a3e5f in process_simple util/session.c:2259
    #12 0x557d175a2e1f in reader__read_event util/session.c:2188
    #13 0x557d175a37c5 in reader__process_events util/session.c:2237
    #14 0x557d175a464e in __perf_session__process_events util/session.c:2282
    #15 0x557d175a770a in perf_session__process_events util/session.c:2446
    #16 0x557d16eb78e5 in process_buildids /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6bd89ae7d14788ba15e25289479addcb98e7dc26/tools/perf/builtin-record.c:1570
    #17 0x557d16ebc3ad in record__finish_output /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6bd89ae7d14788ba15e25289479addcb98e7dc26/tools/perf/builtin-record.c:1894
    #18 0x557d16eca47c in __cmd_record /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6bd89ae7d14788ba15e25289479addcb98e7dc26/tools/perf/builtin-record.c:2966
    #19 0x557d16ed804c in cmd_record /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6bd89ae7d14788ba15e25289479addcb98e7dc26/tools/perf/builtin-record.c:4453
    #20 0x557d170e9a83 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6bd89ae7d14788ba15e25289479addcb98e7dc26/tools/perf/perf.c:349
    #21 0x557d170ea374 in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6bd89ae7d14788ba15e25289479addcb98e7dc26/tools/perf/perf.c:401
    #22 0x557d170ea8ca in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6bd89ae7d14788ba15e25289479addcb98e7dc26/tools/perf/perf.c:445
    #23 0x557d170eb071 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6bd89ae7d14788ba15e25289479addcb98e7dc26/tools/perf/perf.c:553
    #24 0x7f986fa0cca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)

previously allocated by thread T0 here:
    #0 0x7f9879ce4c57 in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x557d1757894e in map__get util/map.h:188
    #2 0x557d1757faaf in __maps__insert_sorted util/maps.c:790
    #3 0x557d175810f3 in __maps__fixup_overlap_and_insert util/maps.c:965
    #4 0x557d175811a8 in maps__fixup_overlap_and_insert util/maps.c:975
    #5 0x557d175568a7 in machine__process_ksymbol_register util/machine.c:756
    #6 0x557d1755706f in machine__process_ksymbol util/machine.c:824
    #7 0x557d173f2ceb in perf_event__process_ksymbol util/event.c:301
    #8 0x557d175986f4 in machines__deliver_event util/session.c:1349
    #9 0x557d17598d60 in perf_session__deliver_event util/session.c:1386
    #10 0x557d1759c7a4 in perf_session__process_event util/session.c:1682
    #11 0x557d175a3e5f in process_simple util/session.c:2259
    #12 0x557d175a2e1f in reader__read_event util/session.c:2188
    #13 0x557d175a37c5 in reader__process_events util/session.c:2237
    #14 0x557d175a464e in __perf_session__process_events util/session.c:2282
    #15 0x557d175a770a in perf_session__process_events util/session.c:2446
    #16 0x557d16eb78e5 in process_buildids /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6bd89ae7d14788ba15e25289479addcb98e7dc26/tools/perf/builtin-record.c:1570
    #17 0x557d16ebc3ad in record__finish_output /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6bd89ae7d14788ba15e25289479addcb98e7dc26/tools/perf/builtin-record.c:1894
    #18 0x557d16eca47c in __cmd_record /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6bd89ae7d14788ba15e25289479addcb98e7dc26/tools/perf/builtin-record.c:2966
    #19 0x557d16ed804c in cmd_record /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6bd89ae7d14788ba15e25289479addcb98e7dc26/tools/perf/builtin-record.c:4453
    #20 0x557d170e9a83 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6bd89ae7d14788ba15e25289479addcb98e7dc26/tools/perf/perf.c:349
    #21 0x557d170ea374 in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6bd89ae7d14788ba15e25289479addcb98e7dc26/tools/perf/perf.c:401
    #22 0x557d170ea8ca in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6bd89ae7d14788ba15e25289479addcb98e7dc26/tools/perf/perf.c:445
    #23 0x557d170eb071 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6bd89ae7d14788ba15e25289479addcb98e7dc26/tools/perf/perf.c:553
    #24 0x7f986fa0cca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)

SUMMARY: AddressSanitizer: heap-use-after-free util/maps.c:423 in maps__by_name_index
Shadow bytes around the buggy address:
  0x50200003db00: fa fa 00 fa fa fa fd fa fa fa 00 07 fa fa 00 fa
  0x50200003db80: fa fa fd fa fa fa 00 fa fa fa fd fa fa fa 00 01
  0x50200003dc00: fa fa 00 fa fa fa fd fd fa fa 00 fa fa fa fd fa
  0x50200003dc80: fa fa fd fa fa fa fd fa fa fa fd fa fa fa 00 fa
  0x50200003dd00: fa fa 00 fa fa fa 00 04 fa fa 00 fa fa fa 00 fa
=>0x50200003dd80: fa fa fd fa fa fa fd fa fa fa 00 fa fa fa[fd]fa
  0x50200003de00: fa fa 00 fa fa fa 00 06 fa fa 00 01 fa fa 00 01
  0x50200003de80: fa fa 00 03 fa fa 00 00 fa fa 00 05 fa fa 00 03
  0x50200003df00: fa fa 00 02 fa fa 00 03 fa fa 00 02 fa fa 00 01
  0x50200003df80: fa fa 00 06 fa fa fd fa fa fa fd fa fa fa 00 fa
  0x50200003e000: fa fa 00 fa fa fa 00 fa fa fa fd fa fa fa fd fa
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
==13482==ABORTING
---- end(-1) ----
 89: Zstd perf.data compression/decompression                        : FAILED!



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251114/202511141407.f9edcfa6-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

