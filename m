Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BD32F2914;
	Sat, 23 May 2026 14:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779547477; cv=fail; b=St535xFqhlSuVF0ie4v4PMrZoMarc9T1tFCLnypZOTk8S+DVhMOrH9Qa5ERhwrAm9EBqZ+Ei1qohmgPrtBf7mNFtXoLjN1RexUsveNYee9yVBSmfr9nfAcfd6ut7T5azFtlCExCc88t6nA2E6AXCtxFvOUN2A97jYCwstw/PNko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779547477; c=relaxed/simple;
	bh=1Dnf5WEgUEjGcjYqa6maIP24winOnoPPQ11F7nwe17s=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oOcitAR9Uq3qziWOJUJSeguc5zwd3ZWkmwY+WPVo7lTyTTxVtOP/9crWyyxi/0yRrGEvbGo3Uaf7vzJugoE6vjhlLDWt6w0+1TxD942elO2EeOcvUpa1nc44/nQYc0f9HeQOs3+qlpMMyr18qxmF6RpFu+x2PMbk6VnaYbGYJRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gzSIWANO; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gzSIWANO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779547476; x=1811083476;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=1Dnf5WEgUEjGcjYqa6maIP24winOnoPPQ11F7nwe17s=;
  b=gzSIWANOg12efEx5V4w3Uf/L0ARwDaOe9YAugUgCfAnHtE3k1wbS9ypR
   ghKulNhMpJRaIwC7HnxNj5fzijDa6jv0eWF/uXBGomzXyjxpF6QVKA72i
   8253S0eHrvaHeLQTbl1KLUJCGTVRNaJzBeJFh/KEkaCn6YaDiDSv0zYyr
   E17vYfdWUGVR1tmxIt5sZHDVGJ0kwo6oiyKuug99dUTwEeCfqQ+xuCk+q
   tCfRkPfDzGi2YPsz7xz70PGlKK5IkxMgffJplUQB37Rx7o8P/YE2WR5kN
   Fe6hB2BiDa0V8qRuuVSm9026HeGgeYCHJQMD4+JvXhEFw+KK+JlNJHyw7
   g==;
X-CSE-ConnectionGUID: YhiT8vvAQTinEVLEV5eprw==
X-CSE-MsgGUID: j/Y5agDtTp2qN/MIIu9ScQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11795"; a="103123827"
X-IronPort-AV: E=Sophos;i="6.24,164,1774335600"; 
   d="scan'208";a="103123827"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2026 07:44:35 -0700
X-CSE-ConnectionGUID: tVSY4uQJSd2TeUFtmevgSA==
X-CSE-MsgGUID: rNcCAO7CQI+AO3/MHkG0mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,164,1774335600"; 
   d="scan'208";a="241238449"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2026 07:44:34 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sat, 23 May 2026 07:44:34 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sat, 23 May 2026 07:44:34 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.28) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sat, 23 May 2026 07:44:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qn4EjqS/0hleJe2i8KzCaCD/RFu4+kTijYvgK4OxlIWPPsgNK1r7hdaJ6IYX6OMhPzCa1MxAjdIrq9TM1bbuXUYiNf5YvRDwbkKjv8m954FUpPfEA+lkZ5e1VLVfUHgdSzkWxc2D2OVSB7PeBzsqQIEIFvjlCJBQYpEV4OhFdALieqf8XXTLnFDXi1BiPRmYXJUSuYm7EdcF/q5OT5RRg0CuGNkaqtMbZXLixiZlGkTIc7n7ibTqqiwEU4/bNvZ/t57PxXU7WtlX9mz7EeQZr494DsWv0TZX9Zvrd79MkNUWiM/vKwllImknTrXgAZPanpvgW7TGmhqBNg6OhwnvDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BmOb/z5ris3OxACuN4zB/2eUCODwkhB/m6hm3wzw5Q=;
 b=UbJZciHzDgJzFAligUVOKGid50TbMbgo8Lxr1klwfrw6At0sQKjMEvbKftA0t83U2+LzPmVqpIN/pt11nXR0ZRq87Pyky1sw0bGNLnO6V+7JZeTvF49dGWV4R2CTMEt86mjAi0A7zttpYmgKTbGrU2uSHaMui3rs/i3TV+QBquBPcb99888tBtGSpTTYGs8oNz84y+QmykwZT6xMbKcHfSLD09cKxwNQG/6Oi9KhZrAl3l2PKmdFWqfsbrRabXMAZP5qf2axg+KeBBdLGXGYbcetCfOV+T1/Z+dHpSID5nb21PhV0+1G2DiZrdL2QHlyrE3qX/AzifcwDg9dimPewQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by CO1PR11MB5026.namprd11.prod.outlook.com (2603:10b6:303:9c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Sat, 23 May
 2026 14:44:31 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%3]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 14:44:31 +0000
Date: Sat, 23 May 2026 22:44:20 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Ian Rogers <irogers@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Gabriel Marin <gmx@google.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<irogers@google.com>, <acme@kernel.org>, <james.clark@linaro.org>,
	<namhyung@kernel.org>, <adrian.hunter@intel.com>, <jolsa@kernel.org>,
	<mingo@redhat.com>, <peterz@infradead.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH v8 2/4] perf inject/aslr: Add aslr tool to
 remap/obfuscate virtual addresses
Message-ID: <202605231644.ac628f76-lkp@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260520063050.3917261-3-irogers@google.com>
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|CO1PR11MB5026:EE_
X-MS-Office365-Filtering-Correlation-Id: 734af306-c773-49ef-c1bc-08deb8d9cc8b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|11063799006|6133799003|3023799007|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 60aqPU1QQuykJ+a7PQ+Q6lqiVc41VGzef9inM/Q/WZ34UMScLJktQloKD7AA1S0wDmxXzUL8l5TYc/cR6HTa03BTJx+AnP0JHSfK95QR4TFTPmP+pSoE/l3/J7+kkDRf/vt6xhytAeVpqtzqxF9E1rsr02GDIxskncO6j8n0t70XkGdcsXiSP9jKobOXhSlEn9r7ADnFdEwn3QeVQKdMRRTx2QnxqNzGfPAgKEOw65tOSXrna7D/z7XPYKcTvfBSaSAvI77iMmT4DaupHFHm4GH4pbr7uof1wQNP4TRqGnfHHsssfapFLgzvc1LSYOQ8N2IdbffD2DIOKrDBFn2EA5IhlexQlmcDbjLg6hOlr6FS07Tmiew20EZCWM557rO+l4WTy/6QHSRC1L6KPWV+ZsRVnQoJkyvcGYROfmF7WHOliyHgZJR/OZ1R/HDIHSkiRJ1A316APpZYiAHizwNS2+PE9MK2b99OVapQF8xp7Fhr415SiHjheqSWIUEJ8aFq/tEUdPu2uREVtYEyq3gpE670dgeEjb3QW8C/ci8e362BPmwuqJCxg8FwlaeYVjzMr8D+IGwP/XzL1tfr6qBFgj8DbSD49fLYs0ECntTinswz6PM1AEcqCEBGD8+r+RtHyEXnOPxZzwiYPyuZ8/jDlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(11063799006)(6133799003)(3023799007)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aG5EYjd0OG1veERoTCtWcjlCVlg4dkNnVlVSdTZmVGdVMC8vVHVJYk1iNUVX?=
 =?utf-8?B?Skpib29NNzUvNndVMWIycDJ6bFV1M0ppYlp0MDI0WDU5Ny9TakdXSjdIVXBt?=
 =?utf-8?B?c3VZbDlTMHBjTUVyMzh4eGJJa3dMRjZMMGtIOSswNGEvSy9sTVp5YXZkaElQ?=
 =?utf-8?B?UGNMbk1zV0J4NUg5QkNWTkVmSTFVY3VBam01dlc1TlF6d2FlbXp3QW0rTHZN?=
 =?utf-8?B?dFJUbm1XM3paZGFlZGFEUkxVYVU2enBxZVhEdFVnZi9VOXh0Y2lzZ0V2bHV0?=
 =?utf-8?B?M2VBdENOV0E3R25Hcldka3hrcXNLd2pLVWptbWtxTTBwdUxVQ2JhRjFGbnEv?=
 =?utf-8?B?T3d2dldwVGc3OWtOSWhOQURDWGhrY0s3emt6MTVsZFVyS0tJd0NjRTVJMDVz?=
 =?utf-8?B?R0ZlaFFtcmF6b0lKVk5BQlVESGYrZkNzZlZCVVNSSlIrUFNVTEVCN1hUNkdK?=
 =?utf-8?B?Q0dLSTN0MnlwclIxWFlZazVEYmxHRzlTdENWYTY0alZybUgyeXlaREc2NnVO?=
 =?utf-8?B?cW5xSFFBRVptSWp0L3RsRUpGa0xSL3VtTWdSRlFkRlArY0RKRHJYbFZEeHVJ?=
 =?utf-8?B?UGlXM0J1a0YyY3NheGpSN0tjNDQvLzZiZkJOZDJSbjRNVmpBN21tbDdDNEZs?=
 =?utf-8?B?QXI3MmdPa2JCUTBPdHdqQWVFZnR1eDQrYm5aMkxEWlRsak1zYy9FbW5leC94?=
 =?utf-8?B?VDdJeWJlOUZ0c3FVOGtodTgyVFN4K3ZUV1FPUkdxNHJSRHJKWDFpOW9QQy9N?=
 =?utf-8?B?ZTZVTGdRSWNtd2ZDSVJmb202ZjVjNXBJeHJkS2Ryc2xaNGp3K2pLazQrY3V2?=
 =?utf-8?B?emFXWnV0NC83Rk5aMkNWYXFDNXdhazBaQTd0NGpONUFsd2ZXVmpGQmdrYTRO?=
 =?utf-8?B?empZelFwb0piRFUrVVVZVkE2ZTBtcTBITWUvanZ2bFNTWS9wKzNBUmM0ODhh?=
 =?utf-8?B?QXB3VENLZDExWkJscGFaTFdaWUlmcVIvSXFlUnVpZWs4VlhJL3pJU3Y4a0dq?=
 =?utf-8?B?SnZCcEk4ZWlTZWdFdDByc0ltOFgyUVhDYndIRDBEalQ4c1A2bkQ0YWVkYkpZ?=
 =?utf-8?B?YUpIS0FYUnM2b3dLRkx3emw1cGR3U25qK0tvWk1tRlFiWWMzUktZOXJWNm4r?=
 =?utf-8?B?VjFZMTJQQ3ZwUVZzS1czekRqNko3cUNBUldob0krOUdNa25SNXk2VWU3VUpQ?=
 =?utf-8?B?dldoeGFNSVo1bVAzZFlETEY2Tms0MzArbGdOMTdNU0RJM2pZQnd4TlVyVVFi?=
 =?utf-8?B?cjhURzl0UGtqYVAvanZzK0tXV0Z1Ri9PRkt3ZXQ4ZEYzVENIOExKT2NiNE1o?=
 =?utf-8?B?ckdRSXIrS0xTdEN1RjFXbkowOFczQUZPWldqSG5TWms2cVhkNkVlVGtNNndK?=
 =?utf-8?B?eVZZcEphbUVwOHg2WDBvZ2dTb0tDdkdWc2NQVmZ6RnY5ZzlaenFReDRRZFVR?=
 =?utf-8?B?VHFURXpkRHJQTjNOZG01am1WOTNqMEVBUkFPY2FDWEllS3RUSjg4dyt1eE4z?=
 =?utf-8?B?S1lhMjFkT3NyUXBxcDJ0Z3pTUElJMDZPZkpycngvb2ZmNWJlcWhxNkg4QnRo?=
 =?utf-8?B?WTd5VEloNU9ibUlHYWVnOFhyMGJOSDBha0NOUCtCUFhZRmtQRlpGK1Myb2RD?=
 =?utf-8?B?UUNsWU4zblViR3VLQTFGRS9ITHYvZVk5dHRka2hGSWFsT05hd3VUUzM4ZDBC?=
 =?utf-8?B?eS9WY1ExdzVzQ0dZMWMvaTNrRnB1bldvU0NlRGpkbnd4c2RGeGhoWVZuaExR?=
 =?utf-8?B?SmZSYWNOVkw5ZXF3bmhDcXVJV0NxS2NGa3VUZXkzMXZMbmsxaUZTL3VnK011?=
 =?utf-8?B?SXZrbDR2RjJyMXZJQkhPcTd4UGFMNTZ0REpESHFHZmk0OTVybTRzUUNiZTll?=
 =?utf-8?B?Z1QvTFZKMDM3WlFMTUJ6ZGZNVUtFcTBGeWNOVHVkSkVxVEJpN25tTzB1M2hj?=
 =?utf-8?B?WUVrNy9NQTZGL1REZCtucDJkZmY3bm9jUm1xeGtRMGFSQjU3YmEvTWhhYkdP?=
 =?utf-8?B?bjBRcjlmNFNLOXpxTzBVU0g3ZzRUTmNBWHpxTXBLTjA1R3dFZW1aUnJFbjh1?=
 =?utf-8?B?Wm9OT2NHSlB5Slcrb2kwb0Z0UlIzaGU0RTQ1M0Iwc0xmemdzUkxsc2MyWFZt?=
 =?utf-8?B?WFVYeFhRTk4wTlMra2hwbGhvaEZiV01URHI1dmxTY2NyTFhsM2xYcWp1dUEx?=
 =?utf-8?B?aTJENDA4VnF5VnNCMGh6blB4ZlM0WERyczh0UWVoQVJxOUxQNGcrTmFZb0Fl?=
 =?utf-8?B?c1QxUUlNeXlPK25HZjUwTXpHOTFlYlJGWDFjRjg5Z3Jnc0xJS1F3d29nbXRP?=
 =?utf-8?B?anZMVFUzc1Z0L3UyMFN0dlkyanBTZGZCd0ZBa1kvWGMrR1UxbnREQT09?=
X-Exchange-RoutingPolicyChecked: soxPwlnbZZ/qGjADXAm9OPxTGUUDssAZR2T5w/eufmslOOjRZnz/LHappw7YbRSW1zntnL+6WWUgdgknbmYsTpcEb5OmsBZicV0le5cNqjZQ3STY5ENeFMWr3CrIOAbnEli3BF594RF+AjbXF92ln6B+4EB4Lh1w/XxgafhQh7ToKjKrH+fGGpZIV7yHvjCFC+BNs049MN1C52f9GXxnjYr81051DGtIs2q4Q6mGIuzQT3v5KIaw9Yu0kekN/jOzO7sume2xFphpIBTNLnemBOCkvr8wi7Nk7kK2Bo18qlqf04nifLgIOAoiv/qCj0RARH6hiMS/rTMyVtK8H3A4+Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 734af306-c773-49ef-c1bc-08deb8d9cc8b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 14:44:31.3652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vKS57Sue20JZa25wPdoYPzj/1OX8MOtZxYXWruMTXSPhqX/Rvhk50OD9PcXlxi9+POG4GEdklDVe2VRjzw9bgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5026
X-OriginatorOrg: intel.com


Hello,

kernel test robot noticed "perf-sanity-tests.perf.make.fail" on:

commit: ac4569348731804907b1e2e53b53583534fc0f5b ("[PATCH v8 2/4] perf inject/aslr: Add aslr tool to remap/obfuscate virtual addresses")
url: https://github.com/intel-lab-lkp/linux/commits/Ian-Rogers/perf-maps-Add-maps__mutate_mapping/20260520-143636
patch link: https://lore.kernel.org/all/20260520063050.3917261-3-irogers@google.com/
patch subject: [PATCH v8 2/4] perf inject/aslr: Add aslr tool to remap/obfuscate virtual addresses

in testcase: perf-sanity-tests
version: 
with following parameters:

	perf_compiler: gcc
	group: group-01



config: x86_64-rhel-9.4-bpf
compiler: gcc-14
test machine: 16 threads Intel(R) Core(TM) i7-13620H (Raptor Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202605231644.ac628f76-lkp@intel.com



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260523/202605231644.ac628f76-lkp@intel.com


user  :err   : [  174.437942] [    T434] util/aslr.c: In function ‘aslr_tool__remap_address’:

user  :err   : [  175.421882] [    T434] util/aslr.c:143:48: error: ‘struct thread’ has no member named ‘maps’

user  :err   : [  175.439227] [    T434]   143 |         key.machine = maps__machine(aslr_thread->maps);

user  :err   : [  175.455264] [    T434]       |                                                ^~

user  :err   : [  175.480862] [    T434] util/aslr.c:148:43: error: ‘struct thread’ has no member named ‘pid_’

user  :err   : [  175.498459] [    T434]   148 |                   kernel_pid : aslr_thread->pid_;

user  :err   : [  175.513973] [    T434]       |                                           ^~

user  :err   : [  175.775147] [    T434] util/aslr.c: In function ‘aslr_tool__findnew_mapping’:

user  :err   : [  175.800930] [    T434] util/aslr.c:242:54: error: ‘struct thread’ has no member named ‘maps’

user  :err   : [  175.818508] [    T434]   242 |         remap_key.machine = maps__machine(aslr_thread->maps);

user  :err   : [  175.835226] [    T434]       |                                                      ^~

user  :err   : [  175.861033] [    T434] util/aslr.c:245:49: error: ‘struct thread’ has no member named ‘pid_’

user  :err   : [  175.878595] [    T434]   245 |                         kernel_pid : aslr_thread->pid_;

user  :err   : [  175.894692] [    T434]       |                                                 ^~

user  :err   : [  181.727159] [    T434] make[4]: *** [/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-ac4569348731804907b1e2e53b53583534fc0f5b/tools/build/Makefile.build:96: util/aslr.o] Error 1

user  :err   : [  181.748550] [    T434] make[4]: *** Waiting for unfinished jobs....

user  :err   : [  181.761820] [    T434] make[3]: *** [/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-ac4569348731804907b1e2e53b53583534fc0f5b/tools/build/Makefile.build:158: util] Error 2

user  :err   : [  181.783098] [    T434] make[2]: *** [Makefile.perf:797: perf-util-in.o] Error 2

user  :err   : [  181.796142] [    T434] make[2]: *** Waiting for unfinished jobs....

user  :err   : [  183.966859] [    T434] make[1]: *** [Makefile.perf:289: sub-make] Error 2

user  :notice: [  183.977452] [    T432] make PERF failed
user  :err   : [  183.978411] [    T434] make: *** [Makefile:76: all] Error 2




-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

