Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829A03A35AA;
	Tue, 20 Jan 2026 07:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768895898; cv=fail; b=oJwa9X8gTp4Bc2EtAMhZNbTxvxfOHctiNvHbRX2CT4dGZnSxdHpv6pBh0uRMAZO3p9myWq0xBuUlDDoo0jkjZ+sN+0122qcsYkcGuiNexb70SqinTQGq2qNZQW44/PQt3jJuaqPs++XuiY3L9Q5Z/P6Pf9VF8kGllIt8XErcHjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768895898; c=relaxed/simple;
	bh=YaDc8WGtjTWsEdXc1jtRElOfOQCJdCm9qMEOlx08pTQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Vp1Kz2gIPNTROjRMl94WzfcRkPKSSd7jqoLH3ocdcVoQglwvm+0Pn3/4cLuORBftU33OLA49QSUvwoI8UM1E4kEMV/TeU3cynMjvRYlrLepX7ol1IIlcrkRrmxrR5WzzVepv4acxfY2aIZg4VhcKOeuSzbx7shYctBv34k6FUWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=arVsLWbC; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="arVsLWbC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768895896; x=1800431896;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YaDc8WGtjTWsEdXc1jtRElOfOQCJdCm9qMEOlx08pTQ=;
  b=arVsLWbC165S1oQA9ZHybbyIs1/kbhV5pWR962FsKvbRXhtNPYIYxnDq
   PrSJGg8kplKUh8M0Xgh2ldmtwwmczFMRmWX8j5g5LdTubcvzkv9eV4ixm
   0zv9fjGMjwz2iQ3w5kB64g5dnr8g5I66GDQW5lCIShBfJZaDRVkDxi3IK
   GhPaToe9Cx2R9X6uosz8OJ0gI5dzxSGubRSZHSCswrfbI/Fhc6ceHwf4A
   7+eMXexIF8w8bvN67UWCrZAuyOwE+bZGIGuM96zNNZhgeIXXKyi6+grxK
   oyVtNfPO5eRfEWh+6xJkjzqOgsNzKXIp7JviWbnu4h+7Ox6smPBi7MVwx
   g==;
X-CSE-ConnectionGUID: zriuFRchQASdopbEVqxEcA==
X-CSE-MsgGUID: TyucNl3lRiaYEvZBW2I+fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="70262634"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="70262634"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 23:58:16 -0800
X-CSE-ConnectionGUID: P5BeNv6MQdKWsgomejs4/g==
X-CSE-MsgGUID: aks+WxrZQ+uUm5HEeXyRhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="206316826"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 23:58:15 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 19 Jan 2026 23:58:14 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 19 Jan 2026 23:58:14 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.55) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 19 Jan 2026 23:58:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JHbsjwshFmL9V6Ko+iDGo3XXCXW4Z/hBAS98oROeYA1TZ7xABzFb/Sw1njLxIUrEcj5sjKltXkze/lNQHRJR4CeS8NBjLIyI+kS8LKb/dPHnr7JR1gHHLqm+HRQ0EgIoLsYW1xuIbIkd8+1wGNI/BG6iEoxqWZ2PnTd1TW0XbR1sW7wJtrHm1kcPUFhjcLRdKugUvvDUeGPkBKVHw9lRBYSjNno3gA4NaIV4v9gZx3HO2pJ1mu5Ow5J4F2A2oTWcpZNqeTTBrMBoeEhlYpiWX8sb76Q+W3Jy2tl7H8ycjj7noIN0S+2i3dooN7yTEHVkclglDHpFMLjSnJdXgvMoCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQEs0wRn+lx7Jg+fDnIg8DQBlExYZ9oPBx6Hs/D6ONg=;
 b=majbTt3lS5VjwkvZUymysfKLLvHLfH2MyTg+zZBz+NiQTT5m6fhe0Ki8wak+RhSYjaTngYtN6P4gpSVS1gIj9lEye83FIKrj6mORVvbCTT/nzQYoEkWTX0cwIJ5XFpSNpvPxxyEFpJxv89QEIpbiHHBwRiPvQtjhhQUXnChw8+JkAcmJUTwruDJrOe1x4yo6CbSHVgQZwkYfCnn0W5G61O8IsDnrlcSt9XQD/X9LDAz0ZSx1MeQH01J+fbZ1jGsgr5HsOzBfC1TJEcfFjGs9EtAk6yw9Etz71MW3RWrq5lx9Q66Aj7a76/ikJ5ILSNfto4uSjzms6weRswEMkcvjew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ0PR11MB4991.namprd11.prod.outlook.com (2603:10b6:a03:2df::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 20 Jan
 2026 07:58:11 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9520.010; Tue, 20 Jan 2026
 07:58:11 +0000
Date: Tue, 20 Jan 2026 15:57:58 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Ian Rogers <irogers@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Arnaldo Carvalho de Melo
	<acme@redhat.com>, Sri Jayaramappa <sjayaram@akamai.com>, Adrian Hunter
	<adrian.hunter@intel.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Guilherme Amadio <amadio@gentoo.org>,
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [perf test subcmd help]  ef92c4351e:
 kmsg.sanitizer.indirect_leak/malloc/___interceptor_backtrace/child_test_sig_handler/raise/abort
Message-ID: <202601201519.ce4c3ab3-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: KU2P306CA0064.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:39::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ0PR11MB4991:EE_
X-MS-Office365-Filtering-Correlation-Id: a0fa1d65-134e-447c-a53b-08de57f9a83a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mwe6xRcylR/HznMOyXOogbaeueknJ6RvMAvukd0okPAc8zynZZ03xFinL8Bz?=
 =?us-ascii?Q?sPs/JH5zUh6mvh9P+RnsqaOUv/19bPth7PRBSFXtieWzDj9CFxATq6DoQyBU?=
 =?us-ascii?Q?CAg+iZ3HT8MD3uPM08CNFGBHdLFxj3xXBrZjZ4XGOyfRMaEeoA1IxQ78wl+d?=
 =?us-ascii?Q?s8tQhCCCAVCX5OPV1NXUwN4p6XqLGMPHmQ3O9whvtTU76ZiK34i6V11fY5cb?=
 =?us-ascii?Q?OOThBxTgYzwV3JoUZzPRop4NnUfNVZXRCU06XzU7C+M1sypes7S6Rc9leSk6?=
 =?us-ascii?Q?P0DnhAEzem+QbEvLW4g1TMTGbGilVFebhKcFxtiUgClCSz3gktmxo5lB5xUd?=
 =?us-ascii?Q?AJRug5WnVD4CbFuNf2PYyQTHoGifKIOsV5WZCA7pbAMoOm8yAlxhJ40fQLAC?=
 =?us-ascii?Q?yWt2J1nMLPN/Ollv1sQJwsyzvngRxcF8UniMhEwdSlSy+nHote18Wb3EfDeD?=
 =?us-ascii?Q?jQc9/MNS03pLXlbNJj57DBrhiMUmud/gqrl/kX5il3JoflqBPt7cYnAsVGJn?=
 =?us-ascii?Q?djXdn87UdiTL8w9rS83T2fqqKf1hhHEGT8DfTVr60EGjYJEwpl3SaLmxN73/?=
 =?us-ascii?Q?U68rExP5/dahwqD1udRgogrpIZQsyb+xS7GLqqOndZqIqjTa3emL2x9pTMKL?=
 =?us-ascii?Q?kyXnaDKkHqXU4qqY/CjIIrUH0GVxewkgRy8imwhF6SSU6EsAOViDd5rVFwIJ?=
 =?us-ascii?Q?2Lt4heWR6jh3yBROROXBSZ9CZkUmuVgfEEplT7A99LuJCwR0ZYOvyJ+pOeaO?=
 =?us-ascii?Q?JxWM55zzQhnTygbTOqLXvkah9XApUceYezhI2bG/SDmvLM5J94RYHTcw15ut?=
 =?us-ascii?Q?VtQLWJV1C0lGbUpkaN8BCrC/J9thePKvJRAYx8gaeDlQjn+giPssl+QQ3SZp?=
 =?us-ascii?Q?pJHCsWAi2FAEFN3VoRFdo9t+sLHtrmrPJM9LccqXU0nCrD3qeCjHpSKzwaTe?=
 =?us-ascii?Q?d7o2SsV3+ESbIJqQCtAOs5NXj7ezemZcOZXZW2PHqKi0ealtxlenGE4rCXSf?=
 =?us-ascii?Q?OAHJBcDIltoX4OSMVwsWOeDJleJWW6z3DsKEhHqOm/dLW86ZL8V8cLMxmg7S?=
 =?us-ascii?Q?TjKfceiwLIIfX89M8RU7EsHwA79OuAdmGa0UEbxWWoUvaUzXnvmTQVTyNhVy?=
 =?us-ascii?Q?4ba7mnW1oMejEJKQtU4WjrbJKGxMuMISi9JuB1LzBpyBkrO4W+rchk3b9Cu3?=
 =?us-ascii?Q?sstC0iJrbcJDOUXv0/X926xiunslsWfKmr0+xSZhdi0Pd/BGolbznurEbnGe?=
 =?us-ascii?Q?Hg1pRfKAc9Rdr7SsKaPjm07tarwXgG9PzAEmS2pLuLlI1zK8tsipwhKQBLNc?=
 =?us-ascii?Q?oPKKc/egmjOj2lCaTK2hC03QKHlVYKsJuzWXo1dIKGB0vXwrg8RIY7fIrdCM?=
 =?us-ascii?Q?IW2ONCKMCRNHcjy7u5aOnoYQn5XMWIWmQgQiMwuvP8ueAdobRdMjqWyIey9v?=
 =?us-ascii?Q?/qkwiQZKHN+MqHrZE5pdlHu4mtfejWX9Nq8I28E0+rKMRkNKHM1hg+GZWrej?=
 =?us-ascii?Q?8fV7G9fbsGxIn4Qtm9zN7cFs4fzCIVD31hhGq87fV8yDqH0PLaUqDBkmNcqJ?=
 =?us-ascii?Q?anBZuWfkCeH1gfF8FkhVm0jEm6KBEjgYctcc7OTH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ymhvmHnoX6JAgbSj+QhDsduJX3KHKiIp1Jc+j/NPlCpIFOpBlAO8gL9x+rjf?=
 =?us-ascii?Q?KwdLhJNYdH+x822qMgRfZRU+w5yBosPgySfU98JcFxzPezjpDcL4z4VIkov+?=
 =?us-ascii?Q?CkqVA7CmVcxemBS7pCJqsOTlgGUtng2ffggjg43bRj+/A9l5SBWBsSrojoiz?=
 =?us-ascii?Q?sQoYhlv4J7VcDsuedXdvfhNr9mUrGkMj0HjMDFLWWKmfIZWEfI6Astv9BCgO?=
 =?us-ascii?Q?B6qlvvdh9HGQQlb+f2aVCWxLuat9t2+O7wSmJQBF9tEmKmNZ0UQcxzpAaEUW?=
 =?us-ascii?Q?+S5m3Ir36iGo0jGbLSraG1xyFTOQ6y2L6maY9Yo6XjHt6zYEK+qwQgh2pQid?=
 =?us-ascii?Q?NmjGs3ewTVOlJ1yXpuxTY1sLiO1+4Pkwl5autnf3S0vySF5vjeA4yu7gq31W?=
 =?us-ascii?Q?ObPYHUCt0/n8LtrWQ7lVw5tCLKAGXdH6uPw2+Pc0jEoHpA6SuA/MbrcIRpXG?=
 =?us-ascii?Q?j6/D76RGnD0IIbZFIKMj0Z00OgUiHiiV2cScGkB/ofNyMyXfZzaJ/NMe4AbJ?=
 =?us-ascii?Q?O9hkDC7Bv0MzPLKJSlJelM8Vr2IR/Kw9KEBZwWC2KLqFinmeTcz3o9omXTZ7?=
 =?us-ascii?Q?CKqf6YPM0StiZ+/z7GUX70kBg0X7SCoyr0/sh6Lcxo4FcuP0FI2jfwcm5Uku?=
 =?us-ascii?Q?YAeCltxNCW8l1ymLUtwVV/9lKwCwKKpITNANfTz4MxVR79nS0LbOd1OJGdBl?=
 =?us-ascii?Q?QzR1g6cNwS3vgTDtwLjru7m6iKTNqWhJ/iAoCWEKWAQ79Era9vuQWUO2I1SB?=
 =?us-ascii?Q?n3sx1zUVDkUYGMSS76ITAyWIAKbEhO00Qel7PjiaXpRIbONDv9AjvmqrdXlT?=
 =?us-ascii?Q?rbijTaN1uk4au2GGe7/770Fo9KP3cP9oFZq7WvHjkndDTEbd+dQ33DnysGdb?=
 =?us-ascii?Q?Jx5dXvPGNE/ikXgyv12o+yWoecdMw2ZhGc0dQI6mNFBwjbFM9lQsU46wfNWD?=
 =?us-ascii?Q?mzcRalr2uLk2SmwFKLPlYYPLKy2GJLM5cnsJgjbEtHz4v7I0Fr+ZASHYU6rr?=
 =?us-ascii?Q?2/d/8Xt2+fVhRZNrCVPWHHVO4H/kt/xoVpcfp5gb/f1MN6UoRDVT+PSOA7C7?=
 =?us-ascii?Q?gxT65wcaoD6BysMDqybYvrMlEnaj19YEFuI1/eWjayy/lTTJdEDkn+CzH2Ep?=
 =?us-ascii?Q?lsikSQK50SIrZMSbE6vn6FIK2s9okoL6oSdtnlQ1PwPPvbmWkGaeC9q1BVdG?=
 =?us-ascii?Q?UZ+uACoPG9aSPVDPo3t2ZLV2fJttfEXMZRQ9BpTuRvyOJ8sJuXFa8O4r64so?=
 =?us-ascii?Q?q67geOKOt+75cd4mlHkA8RNLtB3KfV/xgx4KADOzFqLea+BxsrcCWbtWHBvI?=
 =?us-ascii?Q?TqKEoiOuZQjjQsYc/vmFyvvFzHfkA0tGoFuFIjKPfWWthKTW+zSqW2HJdSom?=
 =?us-ascii?Q?XYqNSMadbPGpn8ISh+eXL69unPjPhEU9TzQ/SF+0C1NpuKKoesnkjUysSl5k?=
 =?us-ascii?Q?HVq9O0kAbo5rzdEBHIGN3hJIQ4Sbny8CZdkXIPolXZbI8SM5WBcBXt1R65Ih?=
 =?us-ascii?Q?hrVVPvQW7JzFK60qzeuZ3H/dXYITix20/bvM7ix7Uss3J3bfsBn+t6cej4L5?=
 =?us-ascii?Q?8cUHEEHCuwDfr02zaP67gObKuluznjflIE9knu9DjNBaXt/aTZd+guKt3gRH?=
 =?us-ascii?Q?2ttY/l3x+P5HlnfCZUksird4zaWNei+xi8rinTlC8zlU7wFv1MZub22jSAqR?=
 =?us-ascii?Q?Uuv/E6k+BxIb2DYSoS6NK2cZFVn7bWm13kcBKqWvAo9tXwCZk9dxtdv3Tiua?=
 =?us-ascii?Q?eHhjY6nYsg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a0fa1d65-134e-447c-a53b-08de57f9a83a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 07:58:11.5219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x225akidOTkLFPpcGeu14MzZduOmzj3lmQTEtPW5omK8d92etJ9c5XIZ3537rKlBfPuPBFRkB9qmW7zCzvX+Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4991
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kmsg.sanitizer.indirect_leak/malloc/___interceptor_backtrace/child_test_sig_handler/raise/abort" on:

commit: ef92c4351ec75bcfb8a1cc3a88109b5339f296ef ("perf test subcmd help: Add exclude disjoint subcmd names")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master d08c85ac8894995d4b0d8fb48d2f6a3e53cd79ab]

in testcase: perf-sanity-tests
version: 
with following parameters:

	perf_compiler: clang
	group: group-02



config: x86_64-rhel-9.4-bpf
compiler: gcc-14
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202601201519.ce4c3ab3-lkp@intel.com


--- start ---
test child forked, pid 11710
perf: help.c:107: exclude_cmds: Assertion `cmds->names[ci] == NULL' failed.

---- unexpected signal (6) ----
    #0 0x7f7688c77403 in ___interceptor_backtrace.part.0 sanitizer_common_interceptors.inc:4358
    #1 0x55f34adb6c34 in child_test_sig_handler builtin-test.c:312
    #2 0x7f767ea2bdf0 libc.so.6[3fdf0]
    #3 0x7f767ea8095c libc.so.6[9495c]
    #4 0x7f767ea2bcc2 in raise libc.so.6[3fcc2]
    #5 0x7f767ea144ac in abort libc.so.6[284ac]
    #6 0x7f767ea14420 in __assert_perror_fail libc.so.6[28420]
    #7 0x55f34acf4e70 in exclude_cmds help.c:106
    #8 0x55f34ae9a646 in test__exclude_cmdnames_no_overlap subcmd-help.c:112
    #9 0x55f34adb74c5 in run_test_child builtin-test.c:340
    #10 0x55f34ad08db3 in start_command run-command.c:128
    #11 0x55f34adb99a1 in start_test builtin-test.c:546
    #12 0x55f34adba90d in __cmd_test builtin-test.c:648
    #13 0x55f34adbd2c0 in cmd_test builtin-test.c:850
    #14 0x55f34acc2a45 in run_builtin perf.c:349
    #15 0x55f34acc3336 in handle_internal_command perf.c:401
    #16 0x55f34acc388c in run_argv perf.c:448
    #17 0x55f34acc4033 in main perf.c:555
    #18 0x7f767ea15ca8 libc.so.6[29ca8]
    #19 0x7f767ea15d65 in __libc_start_main libc.so.6[29d65]
    #20 0x55f34aa28241 in _start perf[102f241]

=================================================================
==11710==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 30952 byte(s) in 3 object(s) allocated from:
    #0 0x7f7688ced610 in calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x7f7688ace808  (/lib/x86_64-linux-gnu/libelf.so.1+0x3808) (BuildId: d6a40be9eadcbcb0562b7bb13bbe81166e82cc40)

Indirect leak of 9280 byte(s) in 3 object(s) allocated from:
    #0 0x7f7688cedc57 in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x7f7688ad6550  (/lib/x86_64-linux-gnu/libelf.so.1+0xb550) (BuildId: d6a40be9eadcbcb0562b7bb13bbe81166e82cc40)

Indirect leak of 1873 byte(s) in 3 object(s) allocated from:
    #0 0x7f7688cedc57 in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x7f7688ad73fa  (/lib/x86_64-linux-gnu/libelf.so.1+0xc3fa) (BuildId: d6a40be9eadcbcb0562b7bb13bbe81166e82cc40)

SUMMARY: AddressSanitizer: 42105 byte(s) leaked in 9 allocation(s).
 68.4: Exclude disjoint subcmd names                                 : FAILED!



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260120/202601201519.ce4c3ab3-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

