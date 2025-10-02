Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1620723F294;
	Thu,  2 Oct 2025 07:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759389022; cv=fail; b=jlpB4PVIwjY3g5kEP9ccp+Une3HYmf0xATtrYhCLHqACnDwUHaliGNaC745HhUv8U7WehPrtJyNNsTa729IuJyvsiq9+DN9Cn/qYy+HtOgCS/tBoDcIovZO2tDzba+3r/ouy8JlApN8hvIYAMxxzgeNFEV1dP3vLHC3NWLyvLt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759389022; c=relaxed/simple;
	bh=lMNl9GYqC14mGdhpE3EE2jeFc19o9UL/UIc1lxd6Gjo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jHIVQsuZWb5fsUptLSpmUFVMtL/yWzp/xOEFzDgC4vfbioHWC2ByXSL28J45oaI4lR+Hz8GjQXEOOd1r+h9LnR0wnENnAGTXv34tFoROc1VkTKH/k1FODRvzNVtRer8JfzubIJAL9Qv9HTDBkeJS8bg21k/4k+fSMzW0Wi96Xro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FtiLSIQ+; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FtiLSIQ+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759389022; x=1790925022;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=lMNl9GYqC14mGdhpE3EE2jeFc19o9UL/UIc1lxd6Gjo=;
  b=FtiLSIQ+70u0bfSLEvjGSBafOmbyQC3MChIgaS4S7hzqjBgvhHeQ3ohk
   blaENMBLv7m5b0F/ZS/n0ad49bWZ4f+qpqqe0C2aAS5FxKlN9q7j8tytL
   4CaccEsT++DvAFtqQD8OHGJNnlZg72t2HjTHUek/V4yoGGZluAZMNVLBj
   lvaR3g/+3asSH6i5VwHEnIfiMVByxET4WS0Z9rlraMUCDEpws4GPKzII9
   /lbav7PPGwCrnKTqjbC7e7h7BoRYWfUdMBjM9d5RZftxlni1e+K3KibL9
   TCzShPbKjxa2+ryoq6GIXALuICudBFxQFktkSU7WEqB+2hO6Z2CGcLklz
   g==;
X-CSE-ConnectionGUID: x73zNazSSf+l2yqmMCxd4w==
X-CSE-MsgGUID: aoI2cfeHTdKUPYuo3wnO1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61559658"
X-IronPort-AV: E=Sophos;i="6.18,308,1751266800"; 
   d="scan'208";a="61559658"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 00:10:21 -0700
X-CSE-ConnectionGUID: KXD10jzZQCaJOZeS5si9Mg==
X-CSE-MsgGUID: 9GWVUEHGT3Ou1sCMmrbH/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,308,1751266800"; 
   d="scan'208";a="183386896"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 00:10:20 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 2 Oct 2025 00:10:19 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 2 Oct 2025 00:10:19 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.47) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 2 Oct 2025 00:10:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tbOIAGzpM46irNgRwykLxbimgH1vmdTDbwQsKpiQQQ5fdlfRH6b5nTbE7yRcyeRc/QcifU8jrc2dWg3nZQ1QMmAn8W9gj4BLplecVZRRegyUdfTFVGf7lvJCKzXq+GLVvhxQZt9VcyB9VhbsjkM0mFFnGSgcuP+09GIEdgQc82311UFgB4ygbJU/KiPolGaHUd6qr/aPPpsvjPAJYXFK1SY/9uADps5f23oxbGq2ZbTdGBz6kTJY5ed3P71uU4uHELgHFVSBZVET2CYhiLidKfJKp9AVnE81AimqIcsD4gjpRIpHdkUqv90PdDXvgFHkYVDd9se0BehsZDl6kiZ45A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrntgUJJlW3WDLP3A9BMQEKvKoCfj+uPJgBlkQm7IIc=;
 b=n+nMDxn1ZodVPojL+az9CNAzsmxqnjxx8uyj6L3G109NselUY50FP/4gTpl3u8m7fmiGAZHeiCezpZpJgQSQSnSuBdTTql2W/T8Tz67M8m0GiS35eD6X43s1AlouXsR48RhSGNy0YHkPmwGRd/KhBYq14uasVHsKb3YVtJldmM/6uPPWTBAVaRfi7bw3Gu1vzfVfdYM6KlTq3aJdFAh7xWODJH6IkyghO3BAOD4vhYWAfYjCDqwnXe/YRHONNYTuoufryvdYbCd73VE2E9Vg1CgIMNyiTbhrDf/+/M5zNzX7uer+El57102vWWfgodjn/YKDN1Lbe+pHAA4CWRdByg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB5778.namprd11.prod.outlook.com (2603:10b6:806:23f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Thu, 2 Oct
 2025 07:10:11 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 07:10:11 +0000
Date: Thu, 2 Oct 2025 15:09:59 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Kan Liang
	<kan.liang@linux.intel.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, "Adrian
 Hunter" <adrian.hunter@intel.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, Dapeng Mi <dapeng1.mi@intel.com>,
	<oliver.sang@intel.com>
Subject: Re: [Patch v7 02/12] perf/x86/intel: Fix NULL event access and
 potential PEBS record loss
Message-ID: <aN4lR1TG8Mdz5XoU@xsang-OptiPlex-9020>
References: <202509081646.d101cfb7-lkp@intel.com>
 <e92a703d-6a92-474c-acba-b15176b97548@linux.intel.com>
 <bd48852d-e5d3-4d58-9d71-891a4e31dd5b@linux.intel.com>
 <aNtoZ3bJ5OmGAMT0@xsang-OptiPlex-9020>
 <6c4a3b2b-d207-466e-bd58-05566f36e1a4@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c4a3b2b-d207-466e-bd58-05566f36e1a4@linux.intel.com>
X-ClientProxiedBy: KUZPR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:d10:31::14) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB5778:EE_
X-MS-Office365-Filtering-Correlation-Id: 301949fc-0d6a-402f-7771-08de0182b9d2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?Jz6ShmDq8AGFzz3oXVhLonVs8M7ZMnjsYY/3YVQBN3+n+KQROoNTDqbqcG?=
 =?iso-8859-1?Q?5G+J3/bAdvcxkgXsZAXms8npk2Oio3254VV54f1pl/oZGkMfIbYT5tW4uQ?=
 =?iso-8859-1?Q?LaQ3YjpvNvjedTKdE/dImwYDwqZBZLhuGoRFGQtX4P+RRbmbBjIzNBNsb8?=
 =?iso-8859-1?Q?gqy+87Ws+9wLR9w3TSMNMB5d9pB3EYFCEVxvEEyf33X+CzRItST9cM9Ff8?=
 =?iso-8859-1?Q?zsKbhOEHKE6jhn2gbSn82PYCbxZONCqj/qdJUJwhr2gRu8rTpcWCg4VHdp?=
 =?iso-8859-1?Q?XEAMBjcHd/xgm9MhP2Q+io4lSraiwEDbteJIJaPrP3dwgl+dkBC1sO+nLG?=
 =?iso-8859-1?Q?eSOhkKguWUqwWCrljiD0ObPfsQNHWCbTeMEtqqMO6PZ7GARAvmMotMFmAB?=
 =?iso-8859-1?Q?KbVFcBHMOb592CyqmMq2Vpb8MYb+P7dn8VYmpAm4RuRqSsDHA0hpSgxthr?=
 =?iso-8859-1?Q?cFL6D9HpUhh7bKE7QcNaabMJiLU1o444Ioc11cH5VelsPMpkAW8888bxui?=
 =?iso-8859-1?Q?4Xr4ocvgCI44u/vhPOPua00k8FaG1jifPxF65oUQUkGMSHJnLGOswO5A7p?=
 =?iso-8859-1?Q?5UgyDCu5jvEUCwrSk/FLiE7NladiSfjLVlfIuHuOFctAUXOnAcF3hDe6Ug?=
 =?iso-8859-1?Q?VuU4lZXibH5J5XuquOD8m/cMcQ4ylUATsMmeiHV9NdcZILw3r22T7aHax7?=
 =?iso-8859-1?Q?8qcenzhN0Zg0grDvKN3s511iYJAwIuk97oSTwUK+FHogJHezYafd+O91yy?=
 =?iso-8859-1?Q?0mEP9dffRNRJEDmfWbHnJoT5txdikfxX+u6pER6MhpWVMTtL2DnQcSRzZI?=
 =?iso-8859-1?Q?1KJu3EcrH8vCrUMainJGfBxhArF6/9AQupgdhq72c/GWxc5/u2ONkSe33z?=
 =?iso-8859-1?Q?8qF9EElbj3JjBrFJwMDdiDx39Dck7q6m8XrB5VX9peBT1a6EdYpuXL1jp3?=
 =?iso-8859-1?Q?SyAwsuLWXo6LiYC/cWjShvAa9e0h9hk1BmRC3SBlvfZzP3JkZtxbgnJNyi?=
 =?iso-8859-1?Q?5XWU1GtISdVfRaRjPMjfwAvFfsa8+9M/GN4Y9aX/qa+vIqUBnSvdy9s8t1?=
 =?iso-8859-1?Q?2TRv4FEjf1d9QwkAnEdh+hkLwyZAQdIWGTw3Qv/Tgkrx1vjx5Y4iWChCuc?=
 =?iso-8859-1?Q?ZSe6AXLGOh4GVi79dVsQCfurH2NCUqtczhzi5dgsQB1gY47J5pR0emi5Tp?=
 =?iso-8859-1?Q?VjIesUu5pWwJLypp+eJU5Tq6aFr/vDzii6ezrDa57UA7hLSkBpfxvnLrgZ?=
 =?iso-8859-1?Q?S6HcsRaHTJZhLjPyf4ZJdDKP/C4P6vn68aSMn7FBSCy17PhBVwFZURPoEZ?=
 =?iso-8859-1?Q?NzIzG+LuDqeTl8q7iFHuSB5aWcU0qLTNYsmcG92K6r2aXFwOzt3aFcSIlx?=
 =?iso-8859-1?Q?mfk7TU0atNuYlId2Si6UMeievPRQwJ1Zrc4Bvdj9sqVfzLHQh1AzIrIw1p?=
 =?iso-8859-1?Q?ulBkZKd1/P8FCj2mMg4zkhSkGMHBtaTz42Rtgel+2IuYPo4cBGu28geKgw?=
 =?iso-8859-1?Q?YUMMWmErBEQm6e7d07D0H6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?0TEDMVlVG4KNh+VBzTUa91hKwDNjCta0Ei5AXJkPDPPq66yGBj3YD5RtNG?=
 =?iso-8859-1?Q?MZhUFxwzkK3dsC5B3Qbv2ZcPNmmaFuR3UyZdCTWXA94zYj6PJxLgRQWOkK?=
 =?iso-8859-1?Q?Fx8Z+Lx6esVl252MiuWm3CCDc5vwGbfX9nrxyjQDBrJM4+6vYD8JIcrtrI?=
 =?iso-8859-1?Q?YveB0zXKw4NQC6WdH5KKLOgRJ62wveY5fVYDU2NfNEk8WEByPPMWHX6Jab?=
 =?iso-8859-1?Q?thCHpDqKKN+efaFn5SqvZkhgW3m2f//dcA7RnVm6C77Cf1UiVyTzF8H2h0?=
 =?iso-8859-1?Q?vpfnWlERULRgX57yVoDDKXDRhTVbD5DVTikzFmAtkOj9L77F+yTSIU6fA1?=
 =?iso-8859-1?Q?L2MhLMm435YFUUahQpLCZdOitMH8eWgM8Gm9dWBBAA3TasQ4hl6m0bO6HO?=
 =?iso-8859-1?Q?Tlcxg8ghGlKfy67Nr55Pjx8gS2GoJqB2scQGdIYmvzNLhJscOxA/L+NbLG?=
 =?iso-8859-1?Q?P0rgFw35p1mXcNYFlmqhGkN3kR6HczQAPu7a4HyQymahJXO5RVat1g6+og?=
 =?iso-8859-1?Q?eMfLFfL/UAJZpwhzA5miRCL1mdurWkKI4d+rgK7iRMQm/P+7K7wBYplGqj?=
 =?iso-8859-1?Q?by9FlbiMIQtaxBySPineeXXQGcu+E2MvYqtCAyR13lpBiIuG1K8jV94eEj?=
 =?iso-8859-1?Q?35S0rYWOu3fs/7nT/cRnnsVzLoJ8USIZRQMkcgy3jDEAI4hUDVQY8Vw+jq?=
 =?iso-8859-1?Q?++J7XzkFcWX4nPrlFqCI3o2leGEg5ujNqB2i3pT0MvhBN1nX22NTyejaB6?=
 =?iso-8859-1?Q?Ws2MqMVkhtzlNalfzrXrfqczAkvUc/17xJBTKvvvo7kfNC/wjw5j/gwREx?=
 =?iso-8859-1?Q?TFoOn354eO6rekhm1QAYJw1C0V+6+0iEuK1B2werBrd/2AWGCOsmlGOevD?=
 =?iso-8859-1?Q?QRBcXceAHz/cOqdEt38ayNgQ5sD5/g6cgTtPDLLTR1Lar2nVlYOuwYsg0o?=
 =?iso-8859-1?Q?u1sNm6VVC9486vt3OBCPlO9cdjZ1zb2K2FcyIcIbkSoY8IhMkslOGmCXyi?=
 =?iso-8859-1?Q?5OuHZ256FAbfYm2f8iSDSEjIlcQhetKTuo/vJVW9OuNjFtMkQGCwGVLKA0?=
 =?iso-8859-1?Q?DJAbfx+a0eLu0LvazIN1aQfX6JWc+mJdCKKVedHnzy4cfq5oIFSuwmOFsh?=
 =?iso-8859-1?Q?5hmuZgxx1GVHZbM9/5Si878vSNBsgCT8+FAMvDX7GrAD0YVqiCDxcZqOXg?=
 =?iso-8859-1?Q?qB3PFCrM6GZK2gJ7nWx0NmsUMbezvMNHvF/FUeovLS4fbeJQSaEXnY8QwJ?=
 =?iso-8859-1?Q?JTRJYjkSVb30tDaXaonVgMgOPY0GIGCCIW0bt57IcQdrOAVUNqQ19C0kqn?=
 =?iso-8859-1?Q?ndUA1PUUV+HEuS7Fak6ivS4r9sPR5efBpyZ0RuB1fOMluDMSRjLzg8SZQH?=
 =?iso-8859-1?Q?ZUXQydR8DlxypSzH9NcC/7Izo6rJb/e9wreIGhi237vrOOHlGcafZmSa8x?=
 =?iso-8859-1?Q?Au0mhV229kY3n2i5izVMZoLgXOcYsq8GnVcRsWUjGd7cHaJsCROYyjQzPi?=
 =?iso-8859-1?Q?RLPFiIns3b6L1yBQThZFj7/h8OOC1pZOijxRjKz0KIpNttWbp/PBSKcTLi?=
 =?iso-8859-1?Q?WofXHxrRD8EmsPc2x0Im5uXeo4FNAJsdX75IDvGtuXiu6VLNVvRrwhjODA?=
 =?iso-8859-1?Q?hLymqsQDG9KGDTF4YOQGMq3SNySERfUgRJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 301949fc-0d6a-402f-7771-08de0182b9d2
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 07:10:11.0913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fVJ6YfutvtFxi4PH0XLqbYIIw/wkGVMWuRIiyqh/cVAzeJqIyfcRaZIpqSfESlfNENoKUPyRkZQGREwYpOrTSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5778
X-OriginatorOrg: intel.com

hi, Dapeng,

On Tue, Sep 30, 2025 at 02:19:25PM +0800, Mi, Dapeng wrote:
> 

[...]

> 
> Oops, it looks previous fix was incomplete. :(
> 
> Oliver, could you please verify the new attached patch (Please apply this
> patch on top of the whole patch series)? Thanks a lot for your effort. 

we confirmed the patch fixed the warning we reported.

Tested-by: kernel test robot <oliver.sang@intel.com>

=========================================================================================
compiler/cpufreq_governor/kconfig/option_a/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-9.4/Socket Activity/debian-12-x86_64-phoronix/lkp-csl-2sp7/stress-ng-1.11.0/phoronix-test-suite

commit:
  0c9567b36ae6f8 ("perf/x86: Remove redundant is_x86_event() prototype")
  a7138973beb1d1 ("perf/x86/intel: Fix NULL event access and potential PEBS record loss")
  81248d31dd384c ("perf/x86/intel: Add counter group support for arch-PEBS")
  54701e916f6782 ("Fixup: perf/x86/intel: Fix NULL event access waring from test robot")

0c9567b36ae6f83c a7138973beb1d124386472663cf 81248d31dd384c71c3b6a6af25a 54701e916f6782039c2ea8adb4b
---------------- --------------------------- --------------------------- ---------------------------
       fail:runs  %reproduction    fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
           |             |             |             |             |             |             |
           :6          100%           6:6          100%           6:6            0%            :20    dmesg.WARNING:at_arch/x86/events/intel/ds.c:#intel_pmu_drain_pebs_nhm


> 
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index 65908880f424..3dedf7a0acf6 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -2781,9 +2781,11 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs
> *iregs, struct perf_sample_d
>  
>          /* PEBS v3 has more accurate status bits */
>          if (x86_pmu.intel_cap.pebs_format >= 3) {
> -            for_each_set_bit(bit, (unsigned long *)&pebs_status, size)
> +            for_each_set_bit(bit, (unsigned long *)&pebs_status, size) {
>                  counts[bit]++;
> -
> +                if (counts[bit] && !events[bit])
> +                    events[bit] = cpuc->events[bit];
> +            }
>              continue;
>          }
>  
> @@ -2821,8 +2823,11 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs
> *iregs, struct perf_sample_d
>           * If collision happened, the record will be dropped.
>           */
>          if (pebs_status != (1ULL << bit)) {
> -            for_each_set_bit(i, (unsigned long *)&pebs_status, size)
> +            for_each_set_bit(i, (unsigned long *)&pebs_status, size) {
>                  error[i]++;
> +                if (error[i] && !events[i])
> +                    events[i] = cpuc->events[i];
> +            }
>              continue;
>          }
> 
