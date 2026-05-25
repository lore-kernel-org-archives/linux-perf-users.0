Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C80C1D5174;
	Mon, 25 May 2026 13:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779717097; cv=fail; b=PwwAcsPWR2djZcxoFa5P4NyGvr2k3YvynIF2+bK13yxCPhHETY9j4G71SP0nlI4mJVYtm3LiiWw318FtLXCMJawi58EFV0QGYAGzNienWJrJGmvNYLEqKqEUSsM4jNsNnkjlN99ftKUW/YBlNS5wGgisNem+8YBYiqWoBxbaWHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779717097; c=relaxed/simple;
	bh=+D7PWL7e4VDXQhICGM65WKzx7gN6f/zrWXWHuTQmnkI=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cMYW5Dxx0VOaP4gRtkpWUGXEFXNwKjrcbsKq0eh9DZcsNIgDARoWMNcuQRtVMHSNI9VVQvlF0+Okf7BJ8qGgbE7D262h0tmVGnlVo9lTKd4e0ibJwKUV/zWxPWkgV+PsAsamQ/SoYujck3yU3AhHB9QVrc5YqRuA6BSGI5zSXO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GI5yTqgI; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GI5yTqgI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779717095; x=1811253095;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=+D7PWL7e4VDXQhICGM65WKzx7gN6f/zrWXWHuTQmnkI=;
  b=GI5yTqgIelU1x+CB1PcpXsl/VAtjiCCcst1UWMY+q0q1h0sgI++A1v7W
   wbLnsMCITqsUTW+mqEMz6SpYqv007hmUMW6RvNfPYAn72bk9cJGJ3Wtdx
   pnpRE5hf7o+Ku5S7NfHFbLe7Zx7fMMt1xNHaTgATWChLpOjG2gDDN3sLQ
   PGEbyNtZ7BlTwqPnWnwiCG7Har1J8ESJ4SN/cq0e8DU+Ni6p70hTmRe8h
   KlJEnNOjsdxVZBLLUg2CUzlmj5MxyqKn1DDfGTqeLOTo+WpxZvo6l8030
   vywpgS8iAdG4Ljx3XDz5xTe09e8sm+pHj/uI4rAmdS4RNuhQgcfo7UiWt
   A==;
X-CSE-ConnectionGUID: Ran8oyokQwekX2EUqG/2Iw==
X-CSE-MsgGUID: QDfSgffpToeWbEdSppv3FQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="80390883"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="80390883"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 06:51:35 -0700
X-CSE-ConnectionGUID: OWWAL3HQSAWBAhBFuvQykg==
X-CSE-MsgGUID: 7c2jr6+0Tt65D2hl+w8B4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="279723887"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 06:51:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 25 May 2026 06:51:33 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 25 May 2026 06:51:33 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.48)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 25 May 2026 06:51:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WXZnTgAg6L6dB3hvCHksK2nuAff02iBuW2dTPOdduqyJxft74U6EHeVc5+xhqkPkHNH4/r+adNEeQOgPDl1zq90DEbYURRNVY1I+nLFZvlEaWQo2SHuDBAjj1oX7O2hqSGto99mHqxyc8GxZYfK2OT3w2CJEYBKQgSBzM6Mc2mpCzjQTyY/x5KwNZstAJ5FtnnqAPa6zgE5FR3LRrAY0e9vX4qDaNkPKXU3pV8cOeU13bbi9E1GxVXVRL+Pp9segZmTMCF+Aicn2gI48EzGBaFo65ew32GXnq5NY9wIyFUBfKZ/nIJxXAdQQQdQ1kWJcbZhy6wk/gBUIHCYu91vMgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=imC7ub19fAYJFQS95cnsiQWxypAvXKtP++AhbdvoFtw=;
 b=flu7pHyhH09TzxEe9acaNhM1j+t3xQa1rLFvmUIf7xnbVVAIkDEZtDYdj+pPMQslIUujIjOEExdH693fo3CvzZviH5+wni5gSHwcS09Po8eUXyo5L7oz/GvqANX4QBJQqmS7NEigwHRhgthevZPG8latQ/UJrKcb9XAAnIlKMX+8Zfka5jp11CPHvgck3K6VnHFFVI6DlNcvF3MIOPFLnVpoNURhpG6qbx6NqKM3Dwgm75Pq1sHZtfYlkKb0lfRw/EydGLonvEyfwOFdJ24dWP4eG7T4kLRiIT5KdtA+7qEzZPkuPe2PMbfRIppMXXl3OpCFlQSnwyBCxX1ZcpAXiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by CYYPR11MB8407.namprd11.prod.outlook.com (2603:10b6:930:c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 13:51:28 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%3]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 13:51:28 +0000
Date: Mon, 25 May 2026 21:51:15 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Ian Rogers <irogers@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Namhyung Kim
	<namhyung@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <irogers@google.com>, <acme@kernel.org>,
	<adrian.hunter@intel.com>, <ajones@ventanamicro.com>, <ak@linux.intel.com>,
	<alex@ghiti.fr>, <alexander.shishkin@linux.intel.com>, <anup@brainfault.org>,
	<aou@eecs.berkeley.edu>, <atrajeev@linux.ibm.com>, <blakejones@google.com>,
	<ctshao@google.com>, <dapeng1.mi@linux.intel.com>,
	<derek.foreman@collabora.com>, <dvyukov@google.com>, <howardchu95@gmail.com>,
	<hrishikesh123s@gmail.com>, <james.clark@linaro.org>, <jolsa@kernel.org>,
	<krzysztof.m.lopatowski@gmail.com>, <leo.yan@arm.com>, <linux@treblig.org>,
	<mingo@redhat.com>, <nichen@iscas.ac.cn>, <palmer@dabbelt.com>,
	<peterz@infradead.org>, <pjw@kernel.org>, <ravi.bangoria@amd.com>,
	<swapnil.sapkal@amd.com>, <tanze@kylinos.cn>, <thomas.falcon@intel.com>,
	<tianyou.li@intel.com>, <yujie.liu@intel.com>, <zhouquan@iscas.ac.cn>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v14 32/32] perf kwork: Fix memory management of kwork_work
Message-ID: <202605251514.4b99efea-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260520190538.142018-33-irogers@google.com>
X-ClientProxiedBy: TP0P295CA0044.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:4::6)
 To PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|CYYPR11MB8407:EE_
X-MS-Office365-Filtering-Correlation-Id: c4ff1d3a-7d2e-414b-9ff6-08deba64b85b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|18002099003|56012099003|22082099003|3023799007|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: Wkzb2NqXcj4MKesuo2WfC7Ga9IuOykFpaV7+cxZLNuD0YcMbYqoHATh/+vl7qmPrMZd1E8y0MOK8W+fPam1ju+N2bmNmOM2dg1hj7j9BPvYPQGXLMyUE7EAU//4Bjtd2CfTA6Ua2ecnMaAGfuUl7VrQ16KvH3PBmbZcL2lH3kC3t8oWpOMPZq4fLg1+F5LONWewjJD8Cgj89FWy7GJrD9HYtuipFVRHFV4fXXOH0q8V1+YkzrXd6T9RHm48Ly4QLUGWofkCQZubCLUQWrOyvvuHW4nCwCQ/bsFpEJTowOoC4dugZsoyi3WJFpYoIJQ1yph9y4Ej7giC35fsE0u7LE5ud3vnIsS50AJoKUFj8LsPzPwu/blQ2h2kApFMG/8kcO49vqeq2aiHklV2UBFzvygbEj6Joc4HWA6cqrjcptjDaSrgb7ZmxLqVyJ4mwwtq4v+YoDi5sbrnBHNqNkerwy7xnwHVOCrIUdPDaKCsI648kQ1A1yzcbUFZGfTXIXIt5hAnKCxw8G8YdIrFsZBsgYMakg5zo2SJdqIHsjOKF2mhSYvMt4intJGYoXApj9KLIABbxYv08YW/v36sFhnH90RgI7yDsZ1K4b9t64zG3JCowIj4muJqn/yKLTKi8k21fpzs8s/rnZZVE1fnhecY/+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(56012099003)(22082099003)(3023799007)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+NEDtmvA0eQR2OCtYbbaRbp0Spht1r0Ya0iU23dQLsszkWUiTm6D5caydqZb?=
 =?us-ascii?Q?nIv34dQfwWKo07RWgklwjmNauDO7kgA7O1RZEr8sYDGuUaVRC8wh1M8GMl7x?=
 =?us-ascii?Q?2peLosDXkZBPearxxEmi7wl/GwwTC6MHYj+spDxvftyzpj+i0vTYojHsNsbk?=
 =?us-ascii?Q?zYsCq63B8G77xQ7Gg0zN/K5WraaG170uJDBnktSuBROUPyQByoB4vkSv1Kdi?=
 =?us-ascii?Q?ssdJ+pDs9aQEcV9t3Bbt37UF+vFWNgAC+foYaM+7GN6fDtdDPo9sl9TS4Che?=
 =?us-ascii?Q?/k6wh9RNr/xhJ87kpBK8BziL+12Wqnt22PG3cCzpb3jXUcoyh1g0dFbwtx0c?=
 =?us-ascii?Q?1P4TooBcTOIxE6Q3M4RS1NFR8GJHLu+MxyDBJJJ3YYPIfhylCQJEfOiiGKAL?=
 =?us-ascii?Q?cryZEaq84ZnZU7f5cn9QCqaUdoPh0B2lxydffEp27x28pW+Yqq1mkxEI4dh/?=
 =?us-ascii?Q?sC1LegJYm/2Ww2/isIbY0eEY9jrgNlOPcoNan2BMeEhK/rcIu4cSrf8iLu+2?=
 =?us-ascii?Q?FHhB2QdgdyUW7pFWneILUN42c/t9qBsOr7RayIl9FaDVFsnQT23KUWsq98HQ?=
 =?us-ascii?Q?z5VR15VvQlMzJT0BhXbNIKdyTUR54jnn8zOAPEmVuriwSnGfaAgwSDAMNqdc?=
 =?us-ascii?Q?eE+uUWMtlrU1h/4kvVqF3BeaxkN5pB/NrSFIJkVMfKBZQDfp9VvpR4aD2Dir?=
 =?us-ascii?Q?kvwKlk56UTEzDioGpqDBpEdybp5yUcf9NOkUbF6FxDvk7ZDKyjXwpmlPYQOD?=
 =?us-ascii?Q?QQ7zY6VLJdCeOvjNGldUjgQkSfuGrGkqJJo5LW8oKcYQGG+lONa58wfV7NoL?=
 =?us-ascii?Q?GXoFTYyn8+zBricDbBU1m2T3H789s8EPaTf7F+1WrJkGt54JTmqENo3JBpmg?=
 =?us-ascii?Q?L7THeS6n6G5Sy1YbquqQQByB3eB9RHxbPrwwALi8X3W0+QNK7JHYaYN8UhRZ?=
 =?us-ascii?Q?L5PpgiGlCX9Js0G9MRFt28YNMXBpFmbLyYDbDT2C/lvbUZxSaRUWdJoaLkl3?=
 =?us-ascii?Q?Hl6OJOxo9uVH+ZkBktz4A3JVVGvTZQ+3P7R3AazPqibpdH4T/thMHjm3Mnf6?=
 =?us-ascii?Q?ERA/TxywQltkR2HFzGJzWeuy1uzLw1eaRAKzaVBbHqqtH7gN0ZN+/dI04dx+?=
 =?us-ascii?Q?5YrsPVsZGeAbQhZ91/IddN6YIg9FmojrVEM3fANUO+tFE4kTnsgxM5avqQYS?=
 =?us-ascii?Q?czUhcqUETxIiMnYHAi2WlBkm9An2XfyJpDjVC4TmVpLAP4kwYpw/QywvGNYL?=
 =?us-ascii?Q?idkCoaOpiAC8LbNzzKY4rmTLXeH5e+/U+iK2rIrpjS9CToxFq3VpwrrLE7jI?=
 =?us-ascii?Q?9iacmtN2noqWPXiYlKyEFFawYzNFgm3rZUlD6G8RMHZNf04/Gf/Xg6GbVJJp?=
 =?us-ascii?Q?sfVB6pSzkHxNbiDmFA3/1aiocC9PPNMv8Sqx8Nwukyc4F3BSARsoFwfVV2Q8?=
 =?us-ascii?Q?z43HUWUqIen7hu+GVi0GZhOQd/RUcfhMTOsqqAzMOpRvHQK4JUSEMXfNyEq9?=
 =?us-ascii?Q?rLnthmkRQ2j4XzkSYtfV9QNkZV97B1FwFEMntoV9ail1KmqvJxb8ru+mT8k3?=
 =?us-ascii?Q?LIpguyB8n0lTrWBQ53aem/uThg+kuVrfapaDogS7wUnef7/MXNDpGVadCW83?=
 =?us-ascii?Q?wNvrLYvjx/X+UJ/4B+oodTc0oS+sEzjcZDUita8oRf7D8FvTlGAQ0E/aLFTx?=
 =?us-ascii?Q?2PBtDPzg/g9adeACXY9CfBW7u/4203C5GUnQ1/cuum+n+Sk8LDRnv9/7+7uL?=
 =?us-ascii?Q?4jn0u/XReQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: CSWAny9eUOPh66jlu0nxBdZzm+j8oCLoemglq9A+kgzAo6BkTC+XzfnH396CoiAHt2hQlrAD9QraMolky3p1in/BrtvMpuYm4vvB6bMS2txsuOQG1xx6jsncjtZo46NQa4dzytqYDBjtRCfVJXENUdvYlOQNZedn7LSGQt2Tplj5Tnrv0+ewHi+VR/bchrZiayDtbAkdkcn5cqaTKs0DfQn9v9l2pC0N3Uln4VkXoi/TBG9s8yViULoP66ULrfZFAHXG4wFtmX6OXk5bYoH4t+4eQ9Pm4pf5oPJbCo/Gp3P5GSO9bEOmeZCQs8HDazy/SeURghzQIi6sJhBVgjzyjw==
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ff1d3a-7d2e-414b-9ff6-08deba64b85b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 13:51:28.7132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZtNtAJMnjejjHEdiFlfLskbdM8LncJ5dho7XBpXLJxzOdPYaB3KeIZtf9LQ3gL1OqnLlCHSHOAPXsQyNIgDSHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8407
X-OriginatorOrg: intel.com


Hello,

kernel test robot noticed "perf-stat-tests.perf.make.fail" on:

commit: 7f9aae3554b369864c01505b2ec02ddf6f6e12f3 ("[PATCH v14 32/32] perf kwork: Fix memory management of kwork_work")
url: https://github.com/intel-lab-lkp/linux/commits/Ian-Rogers/perf-tool-Remove-evsel-from-tool-APIs-that-pass-the-sample/20260521-061855
patch link: https://lore.kernel.org/all/20260520190538.142018-33-irogers@google.com/
patch subject: [PATCH v14 32/32] perf kwork: Fix memory management of kwork_work

in testcase: perf-stat-tests
version: 
with following parameters:


config: x86_64-rhel-9.4-bpf
compiler: gcc-14
test machine: 16 threads Intel(R) Core(TM) i7-13620H (Raptor Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202605251514.4b99efea-lkp@intel.com


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260525/202605251514.4b99efea-lkp@intel.com


==> /tmp/stderr <==
Makefile.config:661: Warning: Disabled BPF skeletons as clang (clang) is missing
Makefile.config:1134: Rust is not found. Test workloads with rust are disabled.
  PERF_VERSION = 7.1.0-rc2
/usr/bin/ld: perf-in.o: in function `work_delete':
/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-7f9aae3554b369864c01505b2ec02ddf6f6e12f3/tools/perf/builtin-kwork.c:383:(.text+0x1b569b): undefined reference to `work_exit'
/usr/bin/ld: perf-in.o: in function `work_push_atom':
/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-7f9aae3554b369864c01505b2ec02ddf6f6e12f3/tools/perf/builtin-kwork.c:549:(.text+0x1b77d3): undefined reference to `work_exit'
/usr/bin/ld: perf-in.o: in function `work_pop_atom':
/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-7f9aae3554b369864c01505b2ec02ddf6f6e12f3/tools/perf/builtin-kwork.c:590:(.text+0x1b7fc6): undefined reference to `work_exit'
collect2: error: ld returned 1 exit status
make[2]: *** [Makefile.perf:803: perf] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [Makefile.perf:289: sub-make] Error 2
make: *** [Makefile:76: all] Error 2


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

