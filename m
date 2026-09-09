Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EC356853E;
	Wed,  9 Sep 2026 15:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788968320; cv=fail; b=PiaFfHVb3QaDAdiULNr4VAI3Shqc4959g3rV2NAfmJ/TCPs1groQIQntC8C16bWm3BbOPjWeDZFsXI51BAFMPIf2VJ3pXAg2cnCxxuG+FdCeC4kQbwWCnJ37uGru95hTuKEkKST44EORRPpJC1kLA5avAPAAjg2/3cRs1H20rWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788968320; c=relaxed/simple;
	bh=ILtnwP9J1mjUboZbzGblxbLzogJJMFS6Jhx943f1KNQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VyiO3ykYHIh2nHYd2Huzgm++6/FImE2jJnCvSV9+XiDzmp1GXEXjC2+M+WLYTEDxsYzmZaoo1VCKtFkDOMeY7h/PX9TAo7DifzrWsXXk817/PilrEXzoWaSYmFQ9b5LNp4xY9usJucJ6V7BtN5VhYQ0l/3Iq+h7Bl/YL9uj8KVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rbjr/ApN; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rbjr/ApN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788968318; x=1820504318;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ILtnwP9J1mjUboZbzGblxbLzogJJMFS6Jhx943f1KNQ=;
  b=Rbjr/ApNTAN1dcYIliWn8CLZBUPHinsZKXSH8KEKKjFgx6wlJWUB3QYe
   mDd2cuGvn08FUtFYKWZJryfi4HYkETcmJRoWoEW0ot9YQLXcxIZBWltGz
   kO+hwvpk44mZ2pQArBJaMEUIBegNMU4HaW15YqaN6ZPmWQ8TNoOF82SH/
   ZsIGI8Iz6P645+LAlfI/s97pSoWolylvC7LahhBivnjxTysO1PVXlwF2Q
   h5Q0oLXLozilCG7C2xhBZfPFdMvPUoxLLqKIqdsXzROBcf/AkfjsbYspn
   HLLDKO4zjRB22WX5t8IBHQ/fgAd+H2YwBkRlGCYz+F75W6vFlfWvuo8+E
   g==;
X-CSE-ConnectionGUID: 2L2kG8y8RnOD+kCHsyZhqg==
X-CSE-MsgGUID: ykS2EB0HR+a709Yvn3rUKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="93090983"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="93090983"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 08:38:37 -0700
X-CSE-ConnectionGUID: K5si9rQaSRWRrF/IiHj1Dg==
X-CSE-MsgGUID: ATWTe8fHSgOCQc4vqLX8zg==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 08:38:37 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 08:38:36 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 9 Sep 2026 08:38:36 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.17)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 08:38:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EttvBh/nixUE2w2U16fYZ8TvuVRa0Szz6rUiFlOxMxX53MmqmUKwhFHg5ZzMSCFVI+FUVnPj2liNM9oQ+AOryTihmKjkl2PKVyNXkS/9P26qw043tjqw/MO8IqnJUoLLW5iHhqY4pO4i/GuNATYH5NJBVrtRdrB6jAwN6XT0jcpxRYi/5XHufZNi7Z1Yfnp5tRXjq9USXh+oRmPhFZC5lLP3WYP0brf6WmBN4rzSit7VgwRgPBwhpp68azhecidAScsoXbjl555zo+N/2h8K2hCzcECLM2uMCrmro2LrIlURyg2a2iax6PMPsG6ItmsRtd7jvNi5N08suh5gJ3hTig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Zi2+4UU8vf/dRY5/Hr9VHD8g4jb9+hRIIjnqX5sXco=;
 b=DgySY/IYq/dZxeoWsAU8jmbbQ7IiIOyjCF81TypUhK2hllI25H8GZMaZwjENSQczvk8xqZqx4zoVHfJ5+CctkTUPsI9bG3t8IqR45h8bTanl2T4Bk9FmDXeCnEWcTLbMJCh9/HEIvtd5RwL+PXQ7yBbTbJZLahrMfUQES5twUMDyqCnhwuHDcTws3+B9U3M21j7EGTNZ+A2hAEl6dZFhSmoSqpH6p61MCaDII6JQkXkBgJdBJaoEFqEsMyeeUWLfd8Xo00CnBHsXadb9/QOllXY1iFz38F+t0H7AsV/rfknqFP8cLypTgREyPl+XMAjylmV4GJrD5eiCxgyPdXDXlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DS4PR11MB084795.namprd11.prod.outlook.com (2603:10b6:8:4bf::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 15:38:33 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 15:38:33 +0000
Message-ID: <e16c65fb-f020-4417-a7a4-bd34da79214d@intel.com>
Date: Wed, 9 Sep 2026 18:38:26 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/26] perf annotate: Default to --itrace=i1i for data
 type profiling
To: Tengda Wu <wutengda@huaweicloud.com>, Namhyung Kim <namhyung@kernel.org>,
	<james.clark@linaro.org>, <xueshuai@linux.alibaba.com>
CC: Peter Zijlstra <peterz@infradead.org>, <leo.yan@linux.dev>, Li Huafei
	<lihuafei1@huawei.com>, Ian Rogers <irogers@google.com>, Kim Phillips
	<kim.phillips@arm.com>, Mark Rutland <mark.rutland@arm.com>, "Arnaldo
 Carvalho de Melo" <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>, Bill
 Wendling <morbo@google.com>, Nick Desaulniers
	<nick.desaulniers+lkml@gmail.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Zecheng Li <zli94@ncsu.edu>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<llvm@lists.linux.dev>
References: <cover.1788872630.git.wutengda@huaweicloud.com>
 <a30bf174539765875129c06381932702934fd0c9.1788872630.git.wutengda@huaweicloud.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <a30bf174539765875129c06381932702934fd0c9.1788872630.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR02CA0007.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::12) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DS4PR11MB084795:EE_
X-MS-Office365-Filtering-Correlation-Id: dee96594-9ce2-4d3c-f67d-08df0e886798
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|6133799003|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: n67RHx1LI+0yDR/uAJB8/MuEDW5Ya//klLVyq6pWQMi10OxGjL6RlI5w/9KiVsxuFcW5cmHbmgHtx9vHUhMryawhuEjoYlI+e1XGdycycnueNZYHdPPK0M7F32RpGSbaHzCVT9i07Ry1YqqLeFZfZiXoVTTZ4JSVf7Y6tvJjS2uCXT4GQf7I0HMZpxPRpnKvsmlRw5/tGl2OCtV0GBR9cjYkJ4SBGm2L0uhpGxCVvMJSWD9bP7HMi/DWf718GQWooCU+7kHEjTAq8RPw6y31f7qLfSEKqlSGv5djvUo/5tOwgvFEdvc73wA/kKPYC1bIPJ5mYL4pE143PGFbBAN3xSuLGGWHHHXCQ4P9YneLIkhWfrHzfZHBWUJWBIsiz9R2ispjnMdqqOuLf5F+MUOtxge15iEYnlKHO4Fel7plxWPXNeXGy7zA0JDVehIAsNnjKnc0Ax5ADkR84eeVxsEdM1dksS/Al85BbdpSTgH4sFUvD/euOiuZoM/ro52WVcs7wXF0XVnjr+5yO9Qs8i8fOeGitAHQLFljb0Zx1OlJtD+R0cZ+vXjvgjTIiCMej+Maxk6HqGWTz/TJrEks/679a1TDp3/MrrNPYWZ6NOG7wbmIx80sCX0CWvVMq++dJICAb2u4B+wIPThyMrHeohsK/HLbDWlB7RlmpD8k1hVKvHE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2Yxd1pjdzNGTEdZU3hJRTlPblltemVXUmx2TCs0TmtCaWZZQzNJYW8yUmdS?=
 =?utf-8?B?bno2MWFQWkJyMHFrNU0xT1RuZ0JYQjZqdEh1NFFmb2dDai9XTDFGMENBR2Zn?=
 =?utf-8?B?OTY3OGZmRm4zemJOSmR4YlM1SG8yM3drVzBMbHRPU3BhQlVDdnNwak9CWlJO?=
 =?utf-8?B?R0R6b3Q4OTJnNEd4SUhMa25sVllFOWJOZDF6VStkRzV5cDh0bVh4NUFkVzZ4?=
 =?utf-8?B?QkIyVWZ4blVodEZzemY4REFOV1ZJSEUvaG90K3ZMOVBKNmRMWWtOREpwRldV?=
 =?utf-8?B?QVcxNjFZTkhvMy9vclVjTG9FUmZqN2JsL1NpVEgwR1V4MXJpeTB2L0E2QWli?=
 =?utf-8?B?YVQ2NGJzcjl0NVgvbHAzZFgyR2UwSitveG9PRXpuK09CaXRiRVBQT09Gakxw?=
 =?utf-8?B?eGFvdURxV2svcit2SG5LR0I5cEUrcEYySk1qU1RzQktHcFBHL3ZCVXU2UlhV?=
 =?utf-8?B?YXdnekx1RGg4OWJhS1QwWTNic1h1bWFMblh6Tko5WTY2S25IclVoeTFEeWhQ?=
 =?utf-8?B?UWxMWEpnbDVMS3lFOTk5YVBybGlQU1Z4UjRvLzZOdjdsYitFV0RhYnVlNUJi?=
 =?utf-8?B?ZzFLUFpuYTlkNitLeHlOUkhFbXNGSGZVcE0vNDhOR005RXZ1OG00WTUvc3A5?=
 =?utf-8?B?TjlEU0hOV1NCa2dkZEJuUzBvdm1yWHduSi9QOEphd1d5WWpxWDl3NC9jeWFj?=
 =?utf-8?B?U3V5R2tqZFJ3SGxQTk9YUGxabTlicFEvdUM5cm5oN01PYm1LTXRDRzdNRWIz?=
 =?utf-8?B?OC80Zm44YWp0c2Q0eVIzcitQbTB6eTlERTJEaG1tWVFBN3NmR0RtME4wN1li?=
 =?utf-8?B?OTg4aTdpczF4ZHpwYzJ3UEMzT2pYbnUzaU0vb2kwamRJYXZDaEV1U2d3d3Nm?=
 =?utf-8?B?R0JEWlpsRUJjWW5iRng4MGJ5RjdQRVU0b21Sc0ZmVm1CbmRxZWhzVkhJcEs4?=
 =?utf-8?B?NTBReWNFZG4zWWtINGUwR05UVWJZaVJGaE9OcXQ0Sldia0lCZ3NQRnVidFE5?=
 =?utf-8?B?MU4rdGdiZ3JMUkFpQjFLYmRVeUE1OWJoOVBJT1A2L0VUVTlSVzJNdlhZbE1I?=
 =?utf-8?B?ZDlmSWk4S1VxMjJuK1NlU25wd294ZmpEN1lYL201RTBzalIySXNmZVhvMDJV?=
 =?utf-8?B?dUZZOTRYVlgxSnYvc0paK1N0OWcwUks3YnBBekV1Y3I0K2ZHeUQ3TmtBdlhn?=
 =?utf-8?B?NVdoRWdRZ0FOS3N2cEFzQkNqNm43OEJ0UjVIdkxWZUdmQWRIakc1VTN2Uko4?=
 =?utf-8?B?U283U2NEZnpYa0xCblFsbjdMTCsreXFjOUxPdEZ1MmI5a2dScDdCZTBYNUpm?=
 =?utf-8?B?K0V1UjFUSVpiZi9oYTh0SnppQm1MNG03T2h3eUJRcTRVNC9ESkpkNEd2Y2dD?=
 =?utf-8?B?WnJHek9reEJqTjZkcWpHdERBS1hJZ1NVWDdOSm5VMkVVWW1DcEVCZ3BwMkxE?=
 =?utf-8?B?WFN6ZTRoVnR5NTlFUU5yNlZ6aHZrbWl2M0VpU2NHL0JCbHNPa3Q5Mjk0cWZ3?=
 =?utf-8?B?WXJ5NjhnV0wyTkVXQmF4L0J1TlNpUlN1bjBvcXIzU3hqa3hQOVZGQUtJZ21v?=
 =?utf-8?B?eVo5eVFsb2ExYklpRnM5SVE0Y3oyNDk0TzRlcVpGL1FHTUl5WDZtQjNaQnhj?=
 =?utf-8?B?UTVkY1BMczR2Ui9vZTRqUXVPb3dHVDVRVHQ1clJkT2tHbjlQdFYyZm9XRERH?=
 =?utf-8?B?SHZ3RU02L0hBa1J2cldWdFV0WGxoUE5NQUg5VFZjcGdIUEZJSktkWVU0ZnJ6?=
 =?utf-8?B?TTAwWmoyL05RaTZyWC9XUElEMEtaeVAxNG1YS0dZbFlMajYyYVhzV3JDd2Zj?=
 =?utf-8?B?WDFVNGJFMC9BTEFjc1ZpNDhROWdSK2paUEhjd1VTdS9VdGExWjY0d2RITU9F?=
 =?utf-8?B?S0k0L04wT0tvTnBya0ZaWWsvY1dabjdidE1DUUhsNlRKVnBFRlE5ZUYzaU1J?=
 =?utf-8?B?M3lFR0p5QTQvMnVWZk1LcFBNeXVXK3BIczdmSUFDN29kVkU1NXFpSER6WWVC?=
 =?utf-8?B?YjdmMVNDU0tVUHBxc3ZsTnUvVHhNS2t2L01DSmpCWmlOcXJJVzBFd0NSZ1Mz?=
 =?utf-8?B?ck0vUHVlZjNlSWs3M3hneUU2czZESGVPWTkwVCtvNnZqd080akpIKzdYOU11?=
 =?utf-8?B?cUk5U2h6RzdwMUFxTUhmREFzblNCbXlMODNobXE5YkJyOGlDQjZGVnd3STlx?=
 =?utf-8?B?cU1BTDFqY0VXaHRTT0dvU0ZXeTR0aVJjcmhUemdpUnBIZ3ZNenlISW4xYVhp?=
 =?utf-8?B?WW9LUkY2WDZ4OThBclVQRCtRTXpDeHFPZWpacVg1MUJzK01TUGFiRUVBUm1V?=
 =?utf-8?B?TXljVzhBK2RFK21mQXpYLzJ4TGo4OVZBU0FJZ1NWd1VzVmVUNmw0UStSbVFz?=
 =?utf-8?Q?bSvpG3bTleDC7VMg=3D?=
X-Exchange-RoutingPolicyChecked: V3GtVnqw6Ji1YTYSLbYtVMstuIvj9NO3CiusDuTmxMmHERSlxbhLdaRbET7joInudMVPxDQAa0EkaJL72G+rpPyLp4LHwyiz4zhZhTskF6j6xmLon7TAMfzhy8YEqJAIrUFI5iMrzMZopm8AkFfaj4h4n4MYFRryK51hL3gjB4gHLZUGx9tI8EfwWmWPOpl6zASIP8iEQJeFrRkYltFOZODoN5wxMA4gyjPUipJOwshj4RwW/yCgOW44nZyWxo9GzdU71MhyOKvqXAlpSPzLgq5+aWaquP8g+tRfI1Ky9aEttKwuDCLSVklKif6Mqv7Ec0h8LVMBOucfYeP7CZJMFw==
X-MS-Exchange-CrossTenant-Network-Message-Id: dee96594-9ce2-4d3c-f67d-08df0e886798
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 15:38:33.2253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rjo2zCUtrqxNl3n72iftJ1wU4wZlEDTfsScFGxwqAWATOtE6ztmgAgsZ0PVBr+YWieX1z7kZuNCdvzNMXjaxdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB084795
X-OriginatorOrg: intel.com

On 08/09/2026 16:05, Tengda Wu wrote:
> ARM SPE-based sampling can synthesize multiple events on a single
> instruction, as shown below. This would affect data type profiling
> statistics:
> 
>   Available samples
>   0 arm_spe_0/ts_enable=1,pa_enable=1,load_filter=1,store_filter=1,min_latency=30/
>   0 dummy:u
>   84K l1d-miss
>   95K l1d-access
>   77K llc-miss
>   58K llc-access
>   9K tlb-miss
>   108K tlb-access
>   0 branch
>   13K remote-access
>   108K memory
>   108K instructions
> 
> While 'perf report' provides an interactive menu for users to select a
> specific event to prevent duplicate counting, 'perf annotate' lacks such
> a mechanism. Consequently, it counts all instructions across these
> overlapping events, which inflates the profile and distorts the data
> type statistics.
> 
> Although using the '--itrace' option can work around this issue (e.g.:
> perf annotate --data-type --stdio --itrace=i1i), it is inconvenient for
> users to specify this explicitly every time.
> 
> To address this, introduce itrace_synth_opts.default_single_event_per_ip.
> Set this field to true when data type profiling is enabled and the user
> has not explicitly specified an itrace option. In itrace_synth_opts__set_default(),
> use this flag to default to synthesizing at most one event per IP (equivalent
> to --itrace=i1i) to prevent duplicate sample counts.
> 
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/builtin-annotate.c |  8 ++++++++
>  tools/perf/util/arm-spe.c     |  5 ++++-
>  tools/perf/util/auxtrace.c    | 12 ++++++++++--
>  tools/perf/util/auxtrace.h    |  7 ++++++-
>  tools/perf/util/cs-etm.c      |  2 +-
>  tools/perf/util/intel-bts.c   |  2 +-
>  tools/perf/util/intel-pt.c    |  3 ++-
>  7 files changed, 32 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> index 69cb72b2082a..d5b66893c47c 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -873,6 +873,14 @@ int cmd_annotate(int argc, const char **argv)
>  	annotate.session = perf_session__new(&data, &annotate.tool);
>  	if (IS_ERR(annotate.session))
>  		return PTR_ERR(annotate.session);
> +	/*
> +	 * Hardware tracing (e.g., ARM SPE) may synthesize multiple events per
> +	 * instruction. When data type profiling is enabled, default to synthesizing
> +	 * at most one event (equivalent to --itrace=i1i) to prevent skewed
> +	 * statistics.
> +	 */
> +	if (annotate.data_type && !itrace_synth_opts.set)
> +		itrace_synth_opts.default_single_event_per_ip = true;
>  
>  	annotate.session->itrace_synth_opts = &itrace_synth_opts;
>  
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 401aab529309..ae7a5e9c3892 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -2029,7 +2029,10 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
>  	if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
>  		spe->synth_opts = *session->itrace_synth_opts;
>  	} else {
> -		itrace_synth_opts__set_default(&spe->synth_opts, false);
> +		struct itrace_synth_opts *opts = session->itrace_synth_opts;
> +		bool single_event_per_ip = opts ? opts->default_single_event_per_ip : false;
> +
> +		itrace_synth_opts__set_default(&spe->synth_opts, false, single_event_per_ip);
>  		/* Default nanoseconds period not supported */
>  		spe->synth_opts.period_type = PERF_ITRACE_PERIOD_INSTRUCTIONS;
>  		spe->synth_opts.period = 1;
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index aa749e1c3036..ed2113190785 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -1478,8 +1478,15 @@ s64 perf_event__process_auxtrace(const struct perf_tool *tool __maybe_unused,
>  #define PERF_ITRACE_MAX_LAST_BRANCH_SZ		1024
>  
>  void itrace_synth_opts__set_default(struct itrace_synth_opts *synth_opts,
> -				    bool no_sample)
> +				    bool no_sample, bool single_event_per_ip)
>  {
> +	if (single_event_per_ip) {
> +		synth_opts->instructions = true;
> +		synth_opts->period_type = PERF_ITRACE_PERIOD_INSTRUCTIONS;
> +		synth_opts->period = 1;
> +		return;
> +	}
> +
>  	synth_opts->branches = true;
>  	synth_opts->transactions = true;
>  	synth_opts->ptwrites = true;
> @@ -1582,7 +1589,8 @@ int itrace_do_parse_synth_opts(struct itrace_synth_opts *synth_opts,
>  
>  	if (!str) {
>  		itrace_synth_opts__set_default(synth_opts,
> -					       synth_opts->default_no_sample);
> +					       synth_opts->default_no_sample,
> +					       synth_opts->default_single_event_per_ip);
>  		return 0;
>  	}
>  
> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> index 6947f3f284c0..5012bead1b92 100644
> --- a/tools/perf/util/auxtrace.h
> +++ b/tools/perf/util/auxtrace.h
> @@ -65,6 +65,10 @@ enum itrace_period_type {
>   * struct itrace_synth_opts - AUX area tracing synthesis options.
>   * @set: indicates whether or not options have been set
>   * @default_no_sample: Default to no sampling.
> + * @default_single_event_per_ip: Default to synthesizing at most 1 event per IP
> + *                               (equivalent to --itrace=i1i). Used by commands
> + *                               like 'perf annotate --data-type' to avoid duplicate
> + *                               sample counts for a single instruction.
>   * @inject: indicates the event (not just the sample) must be fully synthesized
>   *          because 'perf inject' will write it out
>   * @instructions: whether to synthesize 'instructions' events
> @@ -117,6 +121,7 @@ enum itrace_period_type {
>  struct itrace_synth_opts {
>  	bool			set;
>  	bool			default_no_sample;
> +	bool			default_single_event_per_ip;
>  	bool			inject;
>  	bool			instructions;
>  	bool			cycles;
> @@ -622,7 +627,7 @@ int itrace_do_parse_synth_opts(struct itrace_synth_opts *synth_opts,
>  int itrace_parse_synth_opts(const struct option *opt, const char *str,
>  			    int unset);
>  void itrace_synth_opts__set_default(struct itrace_synth_opts *synth_opts,
> -				    bool no_sample);
> +				    bool no_sample, bool single_event_per_ip);
>  
>  size_t perf_event__fprintf_auxtrace_error(union perf_event *event, FILE *fp);
>  void perf_session__auxtrace_error_inc(struct perf_session *session,
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 114b3cd2da49..2d1ab34f7b6b 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -3626,7 +3626,7 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
>  		etm->synth_opts = *session->itrace_synth_opts;
>  	} else {
>  		itrace_synth_opts__set_default(&etm->synth_opts,
> -				session->itrace_synth_opts->default_no_sample);
> +				session->itrace_synth_opts->default_no_sample, false);
>  		etm->synth_opts.callchain = false;
>  		etm->synth_opts.thread_stack = session->itrace_synth_opts->thread_stack;
>  	}
> diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
> index 02df3e460489..4c9cca3acb6c 100644
> --- a/tools/perf/util/intel-bts.c
> +++ b/tools/perf/util/intel-bts.c
> @@ -877,7 +877,7 @@ int intel_bts_process_auxtrace_info(union perf_event *event,
>  		bts->synth_opts = *session->itrace_synth_opts;
>  	} else {
>  		itrace_synth_opts__set_default(&bts->synth_opts,
> -				session->itrace_synth_opts->default_no_sample);
> +				session->itrace_synth_opts->default_no_sample, false);
>  		bts->synth_opts.thread_stack =
>  				session->itrace_synth_opts->thread_stack;
>  	}
> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index 9d6628169fd9..8c21c9f52d57 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -4463,7 +4463,8 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
>  	} else {
>  		struct itrace_synth_opts *opts = session->itrace_synth_opts;
>  
> -		itrace_synth_opts__set_default(&pt->synth_opts, opts->default_no_sample);
> +		itrace_synth_opts__set_default(&pt->synth_opts,
> +					opts->default_no_sample, false);
>  		if (!opts->default_no_sample && !opts->inject) {
>  			pt->synth_opts.branches = false;
>  			pt->synth_opts.callchain = true;

