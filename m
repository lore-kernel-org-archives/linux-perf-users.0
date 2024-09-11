Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0AB5339F;
	Wed, 11 Sep 2024 08:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726043547; cv=fail; b=tSTp7j46h92teVDk4I/zO8B9BmaAwVV7rz93Yt7iYh6EcM2jZleRP19ZjLaKtGOO549NQLdxrmF9LB1iu1/LjAOOfxTp3Pr7avVzGshN4C8yZgp4LTSGiFW10dOwEl0kruMtzaBEA7tfTczYXTQ9sNBIdiy+MJ1eFswVjqo5Idk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726043547; c=relaxed/simple;
	bh=9B5Hm6zuz1XTpae+yZ9OwuBY/yYUKketrHmNDvC3/sA=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=dn/HFwcs5jYo4lwkyPAwoLQUOMSveKPoQ59OcMV0RuGLQo2XrjFtpDXJIkjdtNK0EfgvT8C3dtmqsdAVUKr0sOlbOvftBmIw9GH3DtC0kUCLsX088gtYd51NRmKGQTL9S5U6snqNhTpiMaqK2dUG+sBqZkm/teNrQ/96NEuzBg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RE/kKDGV; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RE/kKDGV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726043546; x=1757579546;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9B5Hm6zuz1XTpae+yZ9OwuBY/yYUKketrHmNDvC3/sA=;
  b=RE/kKDGVnos9+fRbqI2WuIU4tsW66XD7yPsI7nZh1jsF0DYQ0hd82zC4
   lheMRyhVu8mD5AOoZo6cdzClSbZJ+wn4I7fBHx8ok+1jdfzmQi/LwdH/k
   xPwjQ4W6YKb0p0eJTr9YRcST1WUrsZpV75Mbaf0iiLh18VUK8un/7P++R
   88Bmnos6WuKqzjVy3QFFPCMEYesbASRwAtNK37bnSFJMI235uMrS7mzz4
   AOGQrmNWOkHiqGMM0rC1fxaWa0HEzAhU0B8v59HXWVrOjfdnDj14grpPd
   jvcAyvWgs+oPN5xzMWcXGxwzI2Y9dXdijYDcoXo/UgiYiWpQiwbH2l1VK
   g==;
X-CSE-ConnectionGUID: 1iodKUx4RwiUDeZhEW+Vqw==
X-CSE-MsgGUID: kDh0l872RrGeP7Q16Q7TnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="28569174"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="28569174"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 01:32:25 -0700
X-CSE-ConnectionGUID: DK8EwirgQ9a2dBKRnPD/jw==
X-CSE-MsgGUID: zoDgdRywSJKngrI21Ei2fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="67578199"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2024 01:32:25 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Sep 2024 01:32:24 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Sep 2024 01:32:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 11 Sep 2024 01:32:24 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Sep 2024 01:32:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMVBD3tT/qk/OkND403hand/wxTyFg7QujmWouBSJSCLrCkH2yyHmg/luijyGF/4/BBkWvUnai3eaE4LyDOeWG/prPWIUtXwcvj3QPyR5K9rqopAajALY9K7cL7Cpo/i9il2yt19oSQNXTq2bI3e+o8+hoJ5tn2CeszzYhKCUCozHyse9X1599mogji/tstwmv3yvYU1Gbja8NpvB+4SlY+7BU2v5+1PBEL6/B/5Ke7Mn1ZJpyB8fTCRLgzO1eAf44dIchSykGmZTHBgvv8CmO1dTrCJheVMh+sUrcKBd9/vUuwP5P8Rl27xevrwHOguM/ozbRQ7eNJFnPMPh1WwBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcv4PAVQ+ciH3hPlfmuqIj5nREPjBF9OB8XdY00uqvY=;
 b=ONpuKW5GdJSBzvVkKnNVZiQlYhv1OFtzonCeimKBgJ7EHcm34PRj0ebQCFh9ZomvS4YYZ+5Y+ZtPNBBRoXHvd+91Lz15LDETj9vN7Jr/oshDkkOVvoXcxtzLiegrdXfh2c7dnSCPZeFZIt1wjXYnTOHFPb9CajMB2yx6zaaLCUZQin+/4PdwxY3Qetk2Z8olYHuxx1SI1AFJ/a2fU+AWx8Bq0LyX8J7E89LfzGNeQI+B9M0gu5ciftbIvjFJSiEMsf09gcUVsgCP3HUfnaOMBS+joa2OvR18Tjtbry4imdukUG01QTiQPbWeR0LqEqtDvCXjWKjEcwcOQhC8JkljPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CYYPR11MB8408.namprd11.prod.outlook.com (2603:10b6:930:b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 11 Sep
 2024 08:32:22 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7918.020; Wed, 11 Sep 2024
 08:32:22 +0000
Date: Wed, 11 Sep 2024 16:32:13 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Kan Liang <kan.liang@linux.intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Peter Zijlstra
	<peterz@infradead.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [peterz-queue:perf/core] [perf/x86/rapl]  90942140bb:
 UBSAN:array-index-out-of-bounds_in_arch/x86/events/rapl.c
Message-ID: <202409111521.c7c6d56f-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CYYPR11MB8408:EE_
X-MS-Office365-Filtering-Correlation-Id: bb716246-7f83-4b9e-5377-08dcd23c4192
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wu0tKgoj2XeTR3BNrE8wHelHWR7MM8nO/yz4+SuJ9Ufbu5PCELXD/uMn7C5Z?=
 =?us-ascii?Q?KDYbyKXxGFn3Gsj2gdFZGrvcCkmwHufw1a6h7ZWSSk0a0dddUbFl0xExtAm+?=
 =?us-ascii?Q?S7BkZgXk0xertO11P0kDs6pjzRpGHmLJWmgNCuQC6GsnpiPxYymb/nL1tB+L?=
 =?us-ascii?Q?MzZYDG1VyO7rm7DYeZi1se5bIRIvIV7S1a1Z/IXC0Xx/YqdXY2sl3qe7bvQK?=
 =?us-ascii?Q?vpHjW8hWUdotEyHKeK6wac6mHRRDFM0YFyPWdVIaTG5sTRg9nWaLV+d/JlBU?=
 =?us-ascii?Q?oQXUU/a7Xp+L7CAKESVfZUoBx3CW2CzIFFIiuaxKExObUIpkRSgL2hPt1NVm?=
 =?us-ascii?Q?HkGzbxpr4Xs7f2GH/wDePfIocdXN9iBbPyh9IYJ2+2TgcW/Vny9m4V0AyI8x?=
 =?us-ascii?Q?31WuNGQ+lDlJlUt11+veNQQyKDCjbMVMbG94uYer4y1PxFufDPb7C7dkzItZ?=
 =?us-ascii?Q?oVdtg5+Zef0vFcEV7n5dWiagjK/voyFdblyUcvK2293Intcjf/tdVPHqxYmN?=
 =?us-ascii?Q?kbRrNJFk0ov/QtzlWPHGBChAwf1WwEg+l3sgK7/1tt7lmFU4/LOXutWwwWGW?=
 =?us-ascii?Q?jPCvLsURh88YU08x2kv4Wp2vXPr264Z/zGzXK6rvx1xVftX7htLXKTh5EPZV?=
 =?us-ascii?Q?tiMcFDGUzuFUouEY7t+u3NMEt+hiSpYqTeLrNPWIKGQWAdldbsI+42Fme40i?=
 =?us-ascii?Q?ili3u05sN74/Gy4d8VfIVllhwelpydTPaZBsYGQrYV1tw0r/Tz5g90DEyAvV?=
 =?us-ascii?Q?5QLz4EGKINEp8xa/p/hJhjgOUuSMbj2u5miC2jsHvlEtnmflxHhNk7Lmjqf3?=
 =?us-ascii?Q?vIOcGJKl5F6kNw+uVnndvQe1KDntY53sUP6R5EFrTFwguSSlpQ4bJ4aRXN3C?=
 =?us-ascii?Q?ULg/AR/uWXc7emlHQ1FGAHATOAdMFDzyYaD+zTz22yr/BW9zlQXncLhabzDk?=
 =?us-ascii?Q?hwiGll+RdusldaqODkk/xnO3rfYOdLVbvmAtgHpIL7RkW5n/S+CH8NXIPMKI?=
 =?us-ascii?Q?cKd1uSLSEE6y62WTn9UU8lPR3jIQDvHz6Pbj+8+Dbdm7Zo/zAKq0NMTZpF6f?=
 =?us-ascii?Q?86zEyKHgh7f63lFZBW+mCnpiGjQw1FevVpGiFPZT0mWF5QKwnV7tIYrZsinQ?=
 =?us-ascii?Q?nO1mNXX2tncezpTCjDWxt0Wnyvkds8MTN6zY0gWuht9/3Yeu44t4jJUPy2TN?=
 =?us-ascii?Q?UXZZfYgUKQEWGrDqxQKCWes1nXuDmR8Nao9qcXWQ8qI0KdmRJ1WbuDreY9Kd?=
 =?us-ascii?Q?lzny2gdLLQTQU6vr/hlQg6EIGPevmfwKgYq1fSo49iQF52/s7u7PZ5qWDdzQ?=
 =?us-ascii?Q?xozRAeNJpgfBwa3X1+1p6sBhCAiDqm/iBg9YlFCT8471HHqEADYY0eUepNKS?=
 =?us-ascii?Q?sGlDU+E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NuavJAPV44jhTlQBlFW+GS5dKCWCRQ4UANrWmV/g91S9XOAtF9KtrFRuFxCd?=
 =?us-ascii?Q?INCqY0jRIJtPxLq0cMqKftqvIF9PBB/rAH9pEIM6tMbVpySGZ2XKU72ID8iT?=
 =?us-ascii?Q?r8AWzwcO72IKAq+F9DLcAA7QficqQqviNHCsYrmKqCybUpdZwnrPlZ8LRxxo?=
 =?us-ascii?Q?1NZtWTTW1awVpmrFrf8C+f5+ySNNN1oS8b/2Qe6aJJEUVYQRyxOHSzlQfCTP?=
 =?us-ascii?Q?M2bniT/I7K7/sxdSOomVK3D7OkF1JilwUAW0ePqPK+tuJP3t+fPHJnU6ooiQ?=
 =?us-ascii?Q?zLuEnj/3mclFnBv/te9Og7lNqh5rq/+7Ql2KpJp5kZHVq62gxN0QAwKIP8CV?=
 =?us-ascii?Q?6NIAdilcebGFEsJ9ivSDzSuEiXnR9FxMigemY5jVW6oM6QY/uVEf3M4tvPrJ?=
 =?us-ascii?Q?HXjw21hrIU1fgnvxPH6emXYecmgZH/wTmE2LxKl+taGPR0+ClbgfO2hLrs8Q?=
 =?us-ascii?Q?F0QCg+3SSBd2IBT3rVyOG2TznYgW/+OhAJ+6tpvoshpQTLtZJ0Z2REmoMfVR?=
 =?us-ascii?Q?igQ4xPWHgvbTXUI11e2MSyfYReQy9MEzEUQsANUUuQnNt3PcrM+yRPkykr7z?=
 =?us-ascii?Q?3zkE279kLbE0NNMUmmPMgOaWZcy+AHmxUxIF8jFc8ZpbhYM06vnfLCpg8X3b?=
 =?us-ascii?Q?J+fowWhi/GH//AdkmVw6PDKkLQL+Gyba8tgUC6C0wlaLFSe8ib3s5W0GwRW5?=
 =?us-ascii?Q?vOxo14UHauQnD2zEj+nFLhb0x69kv7XLSDE8BsmgrKsMnQWK/9VDiegmyYrD?=
 =?us-ascii?Q?TCp6j4xKOJ3eENrMxfdRWiWdsKTVNsfk+avkbxpPmS010DP+jy0UQSwu9hIF?=
 =?us-ascii?Q?DrTD47byeJNRwc7Svf53nGFLdw4haiMVuUpGiNzGI4u5tPTGYPAy4cp6vdw0?=
 =?us-ascii?Q?wsLonGG0avdlOW5DWVMDGjhglGs8OFcMtEkgBjVKPuDTpmbEqiE777NpCo9e?=
 =?us-ascii?Q?7L46uZ1h77nUdyKbFHAY8r+uo3fzvqPYRkz863gY1ZsXwU8jlHdvZ2/rqKGa?=
 =?us-ascii?Q?GJsjp6ojRu2kt5qG998qfEgIxiGHCFC3pPhYtZvfjjOjuyFWqxvNL2oz45Dv?=
 =?us-ascii?Q?E8x2/cxomopQr2jkihkrAQhU3JycRuiuEXo/MMci03vSFbXhd+/zkQhI7S/+?=
 =?us-ascii?Q?iiKubusRI7XoVRFr2wWGfzpk4+F16jcgSffZrdDacsao7gZxxaefMoPCnHTm?=
 =?us-ascii?Q?s3/P5yUdJpXu16mxSESZ5bbEqnPt81RFW5C9njU78v37cK2IThJnCEzSDAnf?=
 =?us-ascii?Q?LH1ck48n6JmWF7ALv3Xivw0fFO7LBmGKwY6L4pTRazu40wmxli1aAqc/6mVP?=
 =?us-ascii?Q?iJkYH+H1cJQyjdLqtAgTs+Vsosgtj6sz0RdOVjiHe/QdcuFuSFPs9QZGRCFs?=
 =?us-ascii?Q?q1n9QnMKuh6On6ItC9QrUY/kcE2GS9iwhPwKA06hl7Xw7QGJy67gU9hQ0Epn?=
 =?us-ascii?Q?YVt03qrT8K72NrptTABJLuB0TipxP6/ggQQk4D8RfJlB6YmhdtzJZwpQ9sFm?=
 =?us-ascii?Q?MFOvfqkQ3qGvzzIhTfOvCrzFAKCUV+6fVEdlwmEYcpnpL7l902TEYM6Mkp1f?=
 =?us-ascii?Q?tKgewjsg+iFa5iPjG9ACC6Np86M2r55pRamQt0g/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb716246-7f83-4b9e-5377-08dcd23c4192
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 08:32:22.2718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8PgxNFyz+/FkBMCCB7v2SzkOBjgR3YH6FNEbPH0lt0+jAR8aNYuj51wAxxXK49YJ0RV7R4YVLrroV71Q5eRIhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8408
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "UBSAN:array-index-out-of-bounds_in_arch/x86/events/rapl.c" on:

commit: 90942140bb6cc7e9a41d5927c7617ee522896f7a ("perf/x86/rapl: Move the pmu allocation out of CPU hotplug")
https://git.kernel.org/cgit/linux/kernel/git/peterz/queue.git perf/core

in testcase: boot

compiler: clang-18
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-----------------------------------------------------------+------------+------------+
|                                                           | c206df6d69 | 90942140bb |
+-----------------------------------------------------------+------------+------------+
| UBSAN:array-index-out-of-bounds_in_arch/x86/events/rapl.c | 0          | 12         |
+-----------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202409111521.c7c6d56f-lkp@intel.com


[   22.115286][    T1] ------------[ cut here ]------------
[   22.115957][    T1] UBSAN: array-index-out-of-bounds in arch/x86/events/rapl.c:685:3
[   22.116970][    T1] index 0 is out of range for type 'struct rapl_pmu *[]'
[   22.117779][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.11.0-rc5-00045-g90942140bb6c #1
[   22.118811][    T1] Call Trace:
[   22.119182][    T1]  <TASK>
[ 22.121759][ T1] dump_stack_lvl (lib/dump_stack.c:121) 
[ 22.121759][ T1] __ubsan_handle_out_of_bounds (lib/ubsan.c:232 lib/ubsan.c:429) 
[ 22.121759][ T1] init_rapl_pmu (arch/x86/events/rapl.c:?) 
[ 22.121759][ T1] init_rapl_pmus (arch/x86/events/rapl.c:701) 
[ 22.121759][ T1] rapl_pmu_init (arch/x86/events/rapl.c:855) 
[ 22.121759][ T1] do_one_initcall (init/main.c:1267) 
[ 22.121759][ T1] ? pmu_check_apic (arch/x86/events/rapl.c:840) 
[ 22.121759][ T1] ? _raw_spin_unlock_irqrestore (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:97 arch/x86/include/asm/irqflags.h:155 include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194) 
[ 22.121759][ T1] ? stack_depot_save_flags (lib/stackdepot.c:664) 
[ 22.121759][ T1] ? kasan_save_track (arch/x86/include/asm/current.h:49 mm/kasan/common.c:60 mm/kasan/common.c:69) 
[ 22.121759][ T1] ? kasan_save_track (mm/kasan/common.c:48 mm/kasan/common.c:68) 
[ 22.121759][ T1] ? __kasan_kmalloc (mm/kasan/common.c:391) 
[ 22.121759][ T1] ? __kmalloc_noprof (mm/slub.c:4159) 
[ 22.121759][ T1] ? do_initcalls (init/main.c:1339) 
[ 22.121759][ T1] ? kernel_init_freeable (init/main.c:1580) 
[ 22.121759][ T1] ? kernel_init (init/main.c:1469) 
[ 22.121759][ T1] ? asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:702) 
[ 22.121759][ T1] ? strlen (lib/string.c:402) 
[ 22.121759][ T1] ? parameq (kernel/params.c:99) 
[ 22.121759][ T1] ? parse_args (kernel/params.c:153) 
[ 22.121759][ T1] do_initcall_level (init/main.c:1328) 
[ 22.121759][ T1] do_initcalls (init/main.c:1342) 
[ 22.121759][ T1] kernel_init_freeable (init/main.c:1580) 
[ 22.121759][ T1] ? rest_init (init/main.c:1465) 
[ 22.121759][ T1] kernel_init (init/main.c:1469) 
[ 22.121759][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 22.121759][ T1] ? rest_init (init/main.c:1465) 
[ 22.121759][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
[   22.121759][    T1]  </TASK>
[   22.145056][    T1] ---[ end trace ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240911/202409111521.c7c6d56f-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

