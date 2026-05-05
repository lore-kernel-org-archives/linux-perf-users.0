Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FC147CC6C
	for <linux-perf-users@vger.kernel.org>; Tue,  5 May 2026 13:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777987771; cv=fail; b=J3hNkXCOeLIJorc/vPcrIpyTrDvP/LHpBQk+1w3hH+vbNeUwWGW+mIoswRfNhlrd7tTlpCxhHjdbp63PL92TLwJkn6+FErJRw3HddbiniV3ox18jnjVT0XM3wjOPpGAGO8I4Em6jR6vM8FQa429ARtycgaFS6YbVU/JKwC1tQqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777987771; c=relaxed/simple;
	bh=4L9EsvQSZw7MtRAjDz1hIqCVJ7kNiFNl7EIld49jeOc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uPT3iNGl2qPBGYg4fzUP8DBwgzHzvu10S/QUIJI2LIuoV6sy1QEyIBmFIia7c8ivy0V4xVk22brEiCUIH7+nuT9IZFAJHx8aMMa94nj2x4u3xmPeLWkW27/Ufg8DeNxxEbwto/mNkGyFErsqYRLCacB6VhzX5dRv+W+Ddv9r+1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FdOIB41T; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FdOIB41T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777987769; x=1809523769;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4L9EsvQSZw7MtRAjDz1hIqCVJ7kNiFNl7EIld49jeOc=;
  b=FdOIB41TGr2lIA4gu7tIYEOZ3R8wrERLaT4BqA0aJB1A3k/jLZYU8K2u
   a75bLN91puOx32CugE0hs5WFgseRLp7TaJS4WZwVTUIyn4tg1wCertbA+
   A8VoeKvQviHW5VlHgzJSrewWFEIO55+2mqluELqbbich0+JxZ5qgxfJ4e
   YPCF1/HbpEysW69Fre3xA2ijeiRuxQDf7iR9+Vz4taHILZjFuaiUDJpho
   msJYgJsjFX8ry0cNWK5G27P3qMWhO+Z2FZO7aoyw7VUzgEY5wgEUAeKKA
   6cmVtGgOUlIFBNAGfZDIJ7f5cMPV8CxA5OC5eotXVARx4Kfzq2rBRzHDS
   g==;
X-CSE-ConnectionGUID: mxfnx8DRRFyunmk2nB7U/A==
X-CSE-MsgGUID: 3CznKgHJSyeeoiZkxyYUVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="79047348"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="79047348"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 06:29:28 -0700
X-CSE-ConnectionGUID: x2vRv5G7SfqFzPzFKwDOTg==
X-CSE-MsgGUID: 4P06mt/bRVugU24gVQxsUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="259162973"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 06:29:27 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 06:29:26 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 06:29:26 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.41)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 06:29:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZAyNXqaiueFJjXk1SOvmLzXcOhtrlGrCqEcN7WLr1n4gwuPk1rIjUjzYZKsWKn5BtotigOwN8FzPRJM/LTDxNCpE1wm7aZetQoGIQU5IHWjZ1OIiw0ICDqPPeGRtuRRs20FI7WhtWYzJFW/DBR3CTsLZHo0KmV9MlAD0LfA5zurbou6gyqci3Aei+nQGEX+D45fuOpvs2Uvv19KlhwrgXV29sb21O7FBpJe6DGdGnFNbkcLKr2oEEBS1/+FCpOpy6fx+5gfZ88EwjztXdrhk5+X5AOuAHP0fEvrmQlF++FJMzLuhfWur1s46oe78zuy6NPoYPcpW++r9H4398u8jBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVEUxdI/Ok1Ee9jYfHIjshAE1IaLS3vba1geUEceans=;
 b=T4mJv3NgluOVyu66QfpVNMTBSguBcocZp8YbblSGEkaXmH/pbeJ80yuWA3yN/YWa6J82SrI19hqIxeNobqxiSz9xexSMYZwIS7/0txr7nuJqnbERl6enyS2yXP9GHZWPux82WemK1PLQelhpI9UUZ0Bs8+mMzO32o8y1bP0C1m3o3Bl1SiA0evLULNdZgH8F+7kk9tBZrJA0AdeYAtRD0Fe1SN2osZ6zzRSCcQRBvYPY71BtDtqVVegRJxOIPy0L9iLcHgOR+9w14CAoFE7li7CPiO5DGt63J1fSHmnSXidyOWgr+6sRYIfnYYveRznVENN7uBL7hXKRFwaR81iFZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 13:29:23 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 13:29:23 +0000
Message-ID: <0a14487f-38d4-41cc-9e75-79f19a594e08@intel.com>
Date: Tue, 5 May 2026 16:29:17 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 2/2] tools/perf: Add kernel-doc comment to
 auxtrace_record__init() function
To: Athira Rajeev <atrajeev@linux.ibm.com>, <acme@kernel.org>,
	<jolsa@kernel.org>, <mpetlan@redhat.com>, <tmricht@linux.ibm.com>,
	<maddy@linux.ibm.com>, <irogers@google.com>, <namhyung@kernel.org>
CC: <linux-perf-users@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<hbathini@linux.vnet.ibm.com>, <Tejas.Manhas1@ibm.com>,
	<Tanushree.Shah@ibm.com>, <shivani@linux.ibm.com>
References: <20260504151321.12346-1-atrajeev@linux.ibm.com>
 <20260504151321.12346-2-atrajeev@linux.ibm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260504151321.12346-2-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR01CA0021.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::26) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DS4PPF0BAC23327:EE_
X-MS-Office365-Filtering-Correlation-Id: c6380022-46ed-42c4-68ec-08deaaaa5223
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 015/6NplYK/PRNd2I/8wJNiezOQE0SkujfkzPq87VN4e/zjIJneqp8enfvFD3ULn/q1ntKIiFN/x6jPRovFrLzP1CvjQuCJoT+BCNFMzH3DtabkGKt8W1QO+RIQ+Zhtrg2jRI23iIuvdg8kGnQLPix7cbu/hI00lsK/gr+MK1lrecQu38nH/5N8N9LOOIPs2/ez5/ZBvNOMzUNrb/+JXZo+1vns+gOOyaVtoWeBbOdAeyFVJR/aWJ4o5aMDaP4Jw0Rzl2ADlXhJayg+/dq8gQP6x5iUGDtAtWJ081uv33n5b6FQ7FfzClUIHPnnrFnlhPXw3iaxb5ab+X0Tlsm+s7xEFBpjGzJAlLkz58h2AGVO3jYrn2ac0TCMKfOM/hymNAoV1Jh2lUaAYReHaeFiyh+lulVtzdu8P1wXwtjYNLcZMpwVmGVhJjuUbiuCVSVqoUW1bPOKheWa+rzvE0/D5KXRK4nlkJJ1oEAHkbRg5xXb8y6WCpPBYstR4cR/9nBlbqZaVvy9TDBEjdY+RP8D54xlzguBu3MfAV0CSziRvjfJ4UfeqkuJjj8/2lR3GNoh8TbV3n/FVRHhpUUcOXcP4uJDoiiaL6K2oemi/b5SzxhDZMH58bwbTJxYat6Uy6JjP1Iemu16h5NwNJsiiAuUbjSDf01H0MkRJV9EyzBH35i4O8DWpl4+Wrj+hzRvqvMVA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z09YUmJPY3g4K1FXeXhaWkxPVHpOZnp2TU5GSnZwZlc1Z3VaMkV3RWE4OVpl?=
 =?utf-8?B?eUMweGtMak1hVFNINkRVVU8wbU5aZnllcmxoUGxvTDNFQ2JxdVhWeENkdXRp?=
 =?utf-8?B?akRqY1N2N3VFN2I3cXpFWXAvaUkrWXFBdDlHT1pWRW5pbFBOOWZPVmN2VHpl?=
 =?utf-8?B?OXkrOXNMTlR3RlhpWnZtTXdIeENyWTNCTnVVMFRVSll0V295UmdNNWtvdGl6?=
 =?utf-8?B?RUZLTlJsUnZsSWtxOW1XRnU5U2g3b1BjckpaWXl6RFNrRFkrYzA3RmhIeEta?=
 =?utf-8?B?SVpQdklta2VPUkdVam1vWllIZkJDcnBSZmJDUUtIQnZWUyt4c3hiU2J1RnZM?=
 =?utf-8?B?dUJ4d0UxSWRreTg3VHIzKzMzTE1SNnNkUXVvTkFhcENDQ2pIRlozVWxJdkM3?=
 =?utf-8?B?alpxYzN4OXVVVlRoQWQ5blVwbjFOdXNPbytieDMySjEwM25jeDVkRzM2cGdS?=
 =?utf-8?B?U05LNlpGZ211dGhIL2gvTytFbmpVejVDbUd0MDlycDVnbVVuM3lZbEROeFNm?=
 =?utf-8?B?SFpKWDBpSk1iQStaL2dqdmZRazdZeTBwWjZCQ2gzVFQ1QmRwckdlTW9URG1q?=
 =?utf-8?B?QithSFBKaTEwcDB3czBqYWhaM0E2Z1hkdW5lSWJubEtadVBnM2kvWXZXUm96?=
 =?utf-8?B?SWNjV1VQVS80UDdSUjJQa2U4eTRYQ3hnWmRLRWZJdHhaOFdGTkdHa3BRWE1J?=
 =?utf-8?B?TUwxaHdXYm83K2JXUDMrcTliMm9ObmRLSWdYRlRvbDFjZnJLajVHSkowdDQy?=
 =?utf-8?B?bEt5a1U5VzlGdzVrNUhxTGpBbVZLU1hSMHFJelcyTUtQRkozQnRzN0FpWWJz?=
 =?utf-8?B?REJrSG5lMXBHT0FzMkd5V2dyZ0pZZk52TkZicEhNR3J4c0IwNVBHK3QwOVY3?=
 =?utf-8?B?SFRQMlU3R1dzUGYxWm1vd3NNNzNMeXd2QzcraDFPclZva29WdHNSV1RjenBE?=
 =?utf-8?B?YmVidE9QMDVldXJBZVJpKzE4eHRxOEorWUNuRlhyM1NUSThwT05VajVrTzRB?=
 =?utf-8?B?aXV4ZWlzR1lNM2hDeFNuMEduV2pKM1Ribzlxa2dPbDRDMkhVcWRieWdTbmFt?=
 =?utf-8?B?MUdvbjNBaExvd01TclVIYlBIRVF3ZG03MlUwSHFlV05EUENNU0NTUjJyQWx3?=
 =?utf-8?B?M0JjZ2ZwdCt0OFhucjhldUxPckw5dHB2dXVEMlo1dEFzdWNEOFUzcHpmaTlG?=
 =?utf-8?B?WGt4YkxIV1FsUHN0Z05GcVVnU2IyQlZPOG1pRFRNQ0NIZloyd0JTUWN0c2Nz?=
 =?utf-8?B?RXVRd1Q5a0R6dmNzNWRsOTk3RjNzTjMxNWczZzhVd2ZyWXBZVk9WZjVySTZC?=
 =?utf-8?B?N2dHOFJzbGFwREY4Mm0vZ01LaDNmS2pyZlVtYk9RQndtT1VpOGswc0lFWnQx?=
 =?utf-8?B?ZlFWaENFa1FNTkp2NW1naWJZQ0pud085K3RkY0VqMkJ2VDRMckp6WFJaak9C?=
 =?utf-8?B?amlFaFk3bEc5M1gyTkJ3dFcxbTEzcFNNTHh3QzJhazZJblViNEhYVms4VUJj?=
 =?utf-8?B?SHhCdUtheHdNZnlDc3piRkl2RG55Y1lXRzNsNm5XUWJlQmkwbFNZZGZGS0tN?=
 =?utf-8?B?TVF3R3l6cXNmKzRnTlZUeHp5dVBpazZ4M25qZVZKeElFL2JrZmhscEd0clVL?=
 =?utf-8?B?OVJyZTFVR3loUk9yM1orTkdZSkhGU2wxRmJYRVJtYWJTcVJLY3hZMGhVS1Nx?=
 =?utf-8?B?UVhiZTEza0w5VEptdlR2OU14Y0VaVU9lVDI4SEdBekVwMEVTRjVnOWtBdFlW?=
 =?utf-8?B?amRuMmI2UndsWGJYdk1BdmdtYmk0SjErMUNxN3ZnZXJmVjRKL2Qrc2JOdDNL?=
 =?utf-8?B?cm5GTFNFODlCNEgrMUFDeVdxbnBOU2RYOTdncGpVSkhweFllT0hEY3d3RTAx?=
 =?utf-8?B?c05ubXJSZTlhbmRPWGFuNWh0ZnpHamFtN2ZSdXdRWFBjWlV2WmxYZzdqbDlG?=
 =?utf-8?B?ZitsWjdPRFZaMkF2M0VFNWZlU3ZjbCtGZFlNc3NVeC9GdE1LRGx0SnE4MS9F?=
 =?utf-8?B?dXZPOUJVaGJBK21xM2VVcVBtYzI2c2dIcS91WS9rTVUycmthUEdnZ05SQnFk?=
 =?utf-8?B?M1ZseFFOQ0taSXBCdGtZOUU3WWEyd0U5dEJVY2h1bkViSk5hQ2FmanNLVnZy?=
 =?utf-8?B?Si9jVmMvaGEzWnBlN1JyUFBNd3huZmVIRThybHdPczJWeUtNZ0R1MzhVcXBS?=
 =?utf-8?B?b2wzZ2VjN1dHZDEvUmdsc3RDZkdtRmswTCtSVTR1a1l5UHkwaWRZTTZHMENs?=
 =?utf-8?B?RVgzL3lKNnRsK2VZc1VEYUZDOTcxb3pCd2FYZlgyeWIzSmhmTXpmaGxTWGNO?=
 =?utf-8?B?K0xGZEF5K0dVUzNQQmliTlZPOXlPOFBRNWVTMVJMNHJEclFNbk9FcUdlYUFK?=
 =?utf-8?Q?2SKEgMiAkGbcH+wA=3D?=
X-Exchange-RoutingPolicyChecked: ADU8AlFroGxOQIvOfTxJJh+vI8ulwHt4sR92exNeoCeJsaltRgv0RO3/l49Jq7IgJjtS/NlLrsY3f5rko4R0DT+AHVR1w3PhX/kHrkmYBk0xfnTbodMmtlM1ABd+lHGcdkaiZwD7keTi0ex83/UgfQn47C98ZVSnVxRqInbZAlMGLjy6DaMrWkRuMCdSXfSYItAcQGRP7NHGje0BYAY30L8faqapszmopIMh2+0QlQ3ko02pgGkyrr14u7ZomKtwXFZZscwA9R7AoW0q/tMa5Ns7gJYnzqVaJNO3drNzRfbhburwZo6PhyG3B24izxkJxcoLgNQEcUKv0W4uylFMlw==
X-MS-Exchange-CrossTenant-Network-Message-Id: c6380022-46ed-42c4-68ec-08deaaaa5223
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 13:29:23.5173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: daydjfNCX4RFLCyztvkHzuxogcedldJ81E97tL9abipHMZJib1PPaLkQcv5H4XYO1FWUT3RMjEkgGfOR7pNSgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF0BAC23327
X-OriginatorOrg: intel.com

On 04/05/2026 18:13, Athira Rajeev wrote:
> Add documentation comment describing the parameters
> and return code for auxtrace_record__init() in util/auxtrace.c
> 
> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changelog:
> v4 > v5:
> Addressed review comment from Namhyung:
> - Used original placement for __maybe_unused as
> "struct evlist *evlist __maybe_unused"
> - Added return code expectation on success case
> 
> v3 -> v4:
> Addressed review comment from Sashiko:
> Update return value expectation for fail as
> non zero return err code.
> 
> v2 -> v3:
> Addressed review comment from Sashiko:
> Update return value expectation for success and fail
> correctly.
> 
>  tools/perf/util/auxtrace.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index a224687ffbc1..a9f007d47c0b 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -896,6 +896,21 @@ int auxtrace_parse_aux_action(struct evlist *evlist)
>  	return 0;
>  }
>  
> +/**
> + * auxtrace_record__init - Initialize an AUX area tracing record.
> + * @evlist: The list of events to check for AUX area tracing event.
> + * @err: Pointer to an integer to store return code.
> + *
> + * This function looks through the @evlist to determine which AUX area
> + * tracing hardware is being used and initializes the auxtrace_record
> + * structure.
> + *
> + * Return:
> + * a) A pointer to the struct auxtrace_record with @err = 0 on success.
> + * b) NULL with @err = 0 if no AUX area tracing event is found/supported
> + *    (not considered an error).
> + * c) NULL with non-zero @err on actual auxtrace_record__init failure.
> + */
>  struct auxtrace_record *__weak
>  auxtrace_record__init(struct evlist *evlist __maybe_unused, int *err)
>  {

