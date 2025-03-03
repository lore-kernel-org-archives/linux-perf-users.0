Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821C222332D;
	Mon,  3 Mar 2025 16:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020455; cv=fail; b=AE+tiDNgbyJ0Y+MtpgHbzOEqa0QGFapxGVwT73U0Egh7yEg/HvICrWH4JqbMYgRTrH9FKrJqBZBDEPnHrfFmD//U4wm3tnJB6uCIhc/Kd6zzU+pNWowCRDudifeCzTRTrEQHWuBuY7doAKuQRz0E14cS/pNPKuBbtdz6ChDksDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020455; c=relaxed/simple;
	bh=Y5t7515Y6ymRj6KCZHXP/7tjZtacRHu/46K+BeDOtds=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u+AXwAGRRlga4mETZjXeTrtoWtd5UqoDERGCjDUgfxYouXUaxa4IENWnOavg5vhsMdfb7NZr/2MDFTM0a2YZcUmPhqN2IP8L9OuKBc+zjS35l/NXXh8ngV8ZWgCGNyqvy7wJ71xI2uVKm+i+dJG7L9uOkjUZBBwq4wLrVPtHT7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nJnvPldT; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nJnvPldT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741020453; x=1772556453;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y5t7515Y6ymRj6KCZHXP/7tjZtacRHu/46K+BeDOtds=;
  b=nJnvPldTnthhFEHwgw63g8e3sF52m2mQ3eO9fJmunSJRIXjFN8TG4twH
   8RZJV/k1cnH+dkNTjHQgqM7nsxjaETiI9pDB+Ogbx7W9AYWVNayStxQ38
   IfkCh1Lmj9PwRc3kLQHnzHFIT+oYKrzOUsPYRtTUpV+3oDA7YF9p+El52
   y8y62mbMs4ohOYO7SQh114g0Nc48yUJWGTG+GGkImPymItU6jDhGKMb5a
   Ucgq6liAEnYLU0Krffe4kJjczJUBDu7hhA5EHEjxxLR0rIyHeWS1V2HCD
   3iJ6Ojwpoc/8IcYntmuiIi2xEHMeDGduyKL9DJiqaWoWF2pzSNmWUgkec
   Q==;
X-CSE-ConnectionGUID: YqnDGiDLR7qmFIh9AiqWCw==
X-CSE-MsgGUID: douUl9QcQ+Wcc1B8LLFSBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41816572"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="41816572"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 08:47:33 -0800
X-CSE-ConnectionGUID: Se0NrQTCTuOn/F+zdu6yRA==
X-CSE-MsgGUID: D4HyT3h+SSeGTzlGU9iaYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="123090196"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Mar 2025 08:47:33 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 3 Mar 2025 08:47:32 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 08:47:32 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 3 Mar 2025 08:47:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qga1aAvqSFqPK3GDP5EoLBMiTasqEP4X55PcWlbHmC7SuQZAG4+U/Jlau64QVKPq+H1T8VuLMRFB2WCbP99/MHzAoUwe0pzHi3GBPo1yw54vQUg+qU5Cm4i3LxRs9CC5gQO+lltrN6kdbuFybK9kz3XPPlB1BbghkAeQffn6H+AGB+lBw8eTFgiwaNdePbN+KXIf/iGOMLK7NBnHCRVzdj1W0PmrbvmO0VAyZ54LtIPh0xuNQWIqi67UMYKTHzFMzVtdS12HciC7zC7hPYQC58CzMT35OHRf6yFtnjur6EPVO5eUZwCGN5Z/BkBWj6TQWCezJEPC7jf1ZFqVhzna0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwCLhupdsTgAXlXIifyxq2nUEiA/PTysZjd90Xnd8dM=;
 b=nIGNMYy/GSOF/l5ce6i400CPa05HZhqUdPsv2LBSeV436CcmxU9INQrK8L2XbX5zIV8DRhQKYDXzjDofkeUxdocRp5GD9BI3R90lSSUtvZAetD0ryPFslGa4papYsx64ngm+F6bEIR+M83Y48ZbRCWLEnIjRlXNUGHFxIVqVawY8AZer8qlJEaTU7w+ra3SCyuUVoYe9gDgz4XH3RTTqiWXA8O0fGhy8UHuMB8l82J7WJF3WkZ0+NKXBwlDIIKp6jjduGl1DlYpzJXh0NH4pBmR1zNk2TWSUK+6EjBtdLsAMAPhjCgndD/v+AHAZJXXHoSvuLZPSloWx52+h2kyRbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3605.namprd11.prod.outlook.com (2603:10b6:a03:f5::33)
 by DM4PR11MB6213.namprd11.prod.outlook.com (2603:10b6:8:ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Mon, 3 Mar
 2025 16:47:28 +0000
Received: from BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89]) by BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 16:47:28 +0000
Message-ID: <447bcafc-4c47-4b95-bf21-7aee2cb6a629@intel.com>
Date: Mon, 3 Mar 2025 17:05:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/12] perf script: Make printing flags reliable
To: Leo Yan <leo.yan@arm.com>
CC: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Ian Rogers <irogers@google.com>, James Clark
	<james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, Mark Rutland
	<mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Liang,
 Kan" <kan.liang@linux.intel.com>, Will Deacon <will@kernel.org>, "Graham
 Woodward" <graham.woodward@arm.com>, <Paschalis.Mpeis@arm.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
References: <20250217195908.176207-1-leo.yan@arm.com>
 <20250217195908.176207-2-leo.yan@arm.com>
 <34795c29-d256-49ce-9d01-435f8cd91611@intel.com>
 <20250303162210.GH2157064@e132581.arm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20250303162210.GH2157064@e132581.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0143.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::22) To BYAPR11MB3605.namprd11.prod.outlook.com
 (2603:10b6:a03:f5::33)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3605:EE_|DM4PR11MB6213:EE_
X-MS-Office365-Filtering-Correlation-Id: 0df89d2e-3174-4a8e-527f-08dd5a731570
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bElqdWVOdlJRZ0pmeEpIOFE2bzZKNDVnN0dkK1BkUjV3RU9UejVldXZsdUNa?=
 =?utf-8?B?OWQ2aUE5akszdnp1bmJ2SDVZdkgycFl6SGYvZDRyQ0lXUUswOTV4dVVzT1FY?=
 =?utf-8?B?aDVZdkZFUVMydnRvazYrM0kvYkxmTVRVQUg1d1F4V2xrUXc0MTN0MEd0aTIw?=
 =?utf-8?B?S2lvRzFpTGdEdUZ1NHE5SFJQa25hamxkNzRaOUEzWHZJQTZpVWkyQlVSb2Jt?=
 =?utf-8?B?TUhBSEV4d2dYS0FlTkhMMW1UUEJjNktZR1Z2bE01WkhLTU5tQ0N6TWtQQmxR?=
 =?utf-8?B?MnoxYVhIWlRad1M3WjAxVTVud3NWU3BGV2xjd3ppaHcyNS93NWh4Wml2WDN4?=
 =?utf-8?B?SGtaak82ZGxabTFlNmQzcUpsTzVjN3FxVkFwanNmeTZVcVRWVlRzZUNUN3Nm?=
 =?utf-8?B?R0FiV0gvR3BoNkNYUHRrRFljN2w5WXM3eUJYbDA3WnZQUlRTSmZuTkkwTjRq?=
 =?utf-8?B?Ui9EYTNCOGFsR0hxWDVxekFMRy8wVUZkQ1FBeWdVYUJwOUVUdmtOeEYwaWx2?=
 =?utf-8?B?Smg4TEs3N21Fc0FpTnl1cHhYV0tiQVRsS1BSMExJejBTa3lKNERTNU5odHlp?=
 =?utf-8?B?M1NJZkQvMGVYOEM3ZzBmSUtHbzdnbHEvQTFGa1JOSnlkZEN6c3J1cS9nc0JI?=
 =?utf-8?B?UG9nODhVM3haTFpxK2tsaUsrMlJ0TlJFa2lIQkxrY2ZVSFlTVEx3K3pZV2sx?=
 =?utf-8?B?Tmx3bEJOd2tpdjlOMlA3Z3MvOEdsdGVOdjl5OGhwbkV4MzZQMkwzZGEraGhn?=
 =?utf-8?B?T3Brc0Z5MFc3UnMyMVloVEp2VlBDY2dYVEw3NlpvOVRrbDlFTzY3K1RteUFT?=
 =?utf-8?B?TXIxMXhDcE90ck0vQWZpK2h0TTJxZHlOaGk2aWFJdnlSOUdSb1RpaEtPWFRR?=
 =?utf-8?B?U2psNGhFUFlpZDBzV2VMM2VEeFBaWDI2OW9iSHVzR014U2tMTXpYQ2N4N001?=
 =?utf-8?B?MEJCNkZHazR1TUNFK3RJbXoxYWdIL01COTlZYXkzdjVCbVVWYWl0MlZWeHdG?=
 =?utf-8?B?SzJpY0VNRkxOUlRoTzRlMDVhYTU2M3VOR21IQWpPRzJFV05pWVRXTlNEUVZq?=
 =?utf-8?B?b1VYVEJkRXVndmVrejFVYjFiNjhlQXoxanE1MlVGUm9OV3N1WSswNE9XWEx6?=
 =?utf-8?B?WENQL2FKYkp2Rk9HTWF4THdpUkEwVlgzSFpDMkp1a3ZEL2lGZXhrcXFjR2U5?=
 =?utf-8?B?VjdBeFJJWGlQMElmUHhnZnV4Y2xjajcxc3JMd3MzakYycUxDWWtQYkd0eGU2?=
 =?utf-8?B?VkJxa2xIcHNsenU0ZUdmS3I2b3N3WjBIeUtSTmVYdUtJK2Z5aU9BNEpvNktX?=
 =?utf-8?B?d0tGM0NiT1BMUnR6eEI0L05NRm85NUdPMmcyREJCelpZWDJkVkM3T3MwQVhJ?=
 =?utf-8?B?S3RKQmZYOUxyRjZZOHVPb016akxDbnlxRHNRSDNSZlFySUpEcTlQL0xxdE54?=
 =?utf-8?B?SkgvT1E4cGNaeVdOUHNuNncwdmpoQ1hCZmRFeEtpeUhBeXl1ZFA0em1WemJL?=
 =?utf-8?B?eHhwNDRFUkxST0ZvV0xScUZJcmtnN0Zpc1RMOVEwRGhUYmtnQjBqM1BhNVVL?=
 =?utf-8?B?QWFQU1luRjVMQU9YN2ZCSEpKam5aRmQxWUJ3Sm9KcGpmb0d4bFgyVWR3YTFE?=
 =?utf-8?B?cnVBTHRFaWxTVlQ0NjVpdWVKTG1kUVp3RCs1SG4xOHhZTmMvaVMwcFZEeUlv?=
 =?utf-8?B?RUJDWlZpVlRSbXY4dDJmNnZNeW5QVG15QW91a3QwMldVMXdiTXhURStKNXhl?=
 =?utf-8?B?dVNDSWpRaDZiaDV4S2xVWXFqME1WQStqSmR6dGhsL0pxa2JMdDNHU2dmY2ty?=
 =?utf-8?B?YTcxL1Q3bit5RkxLTUNiQXRnQ21DQWh0bFIwbEVLRzNIYk9PcitnRG80Z2p4?=
 =?utf-8?Q?06QZ8T16e9gjR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVNCOUNwZlRQQTMzM25SajZsYlN1TzZobzEvY1pyV3VGWldEejYrR3dOL0o3?=
 =?utf-8?B?RThsTkpCZkJBbXRpK1NhKzZMSk4waUI5d0JPT2cxNWYyWlBZcmFsSlptUHNl?=
 =?utf-8?B?enhnbHNuOExvOE5VaGd3MlBmT0lJalNTL3Q3R3cwQnE5QTRJUUVQUmdIc3dI?=
 =?utf-8?B?QWNEZTFRYnZUMnFrRFlMejhkZXNnSzBoU2dmNHJ5T0NNazVTeDFMT1hkYnJr?=
 =?utf-8?B?UmRwVk5WQkZ4TlkvanJoNnR2SUcraE5HVHVNdll4MytvUCtXMGFkVjhuQytC?=
 =?utf-8?B?RUFTOENwY0NzMDd3cXNyTlJ6OXBONnpYQTBZRmNhQytXN1VJays0aWhlTXBJ?=
 =?utf-8?B?TEpsQTAxOUpVL0djR2EvenVGRVJuRDZwdS9HOVR2Vk1NYjYrTGo2NW9rTTE3?=
 =?utf-8?B?KzFvNktLSjJGTWhWV2F5NHQ4dE91L0kvSE9TMzVmalZQM0E2dXRnOVNSRy9M?=
 =?utf-8?B?Ky85UHF2UkorVzBPMlBQRmhUQlo0ZXBEQTBJYTJqZEpCMm9mbmFkQnBkbGlo?=
 =?utf-8?B?V1l0bW90cUhQVDZTMDlPTWVWb3MyVXZ1NFFZRkZSN2dET296QWMxQzMxejN0?=
 =?utf-8?B?SUtyeTY1b2xOb21SU0hpQkxWQUF1emkxakdYazdOTHgveUVHQUxIcWtIWDJ2?=
 =?utf-8?B?RVdadEtTeWd6UGtGbWtXNjNpSHVzK1NxRG5qQXVXek42czFEWUpIVm1Yeng2?=
 =?utf-8?B?eHFDYXptN3Nqei80QlNscld1MjF6akU0aGZKQW5SVFlYRzFML0pPTXo0eDVM?=
 =?utf-8?B?R3c4d2FWTjVTY1crY25aSW5EdStad1BLVDJUL1RsU3g1c1JlN1JRamhLWWVr?=
 =?utf-8?B?MkU3WGpVTVRpL1RFVHpFTmk0akhMVEJZZDFGMU01OWYyT25ac1lLMEo3M1Ba?=
 =?utf-8?B?KzdsRjBHTmtmVlJ5cTZ2QzdzS2IwcWNvMHlTazdPUUZuTllEdlc5eWhuTHJi?=
 =?utf-8?B?cytCbWtSUkY0eXFCM05UNlhzL05pcldUTSt6VGQxSkJQYkpES0dzdE1RUFBp?=
 =?utf-8?B?R2QwRTNTdUV2eE9Oek1kSG5jeTdsa2syUzh5eFNTdUt0UVdjVmtIeGF3YUJW?=
 =?utf-8?B?SDZ2N1dlei85WjRYY0tIT0doRGZyaXErZ1M2NC95UmVHWHVVell2WFZkdHov?=
 =?utf-8?B?c1BJVFYreWpmUzJXWFpWSXlHWTlBeHBmd3NodVJER29PalVvYWh4K1Ayc0M1?=
 =?utf-8?B?MlRlSUJPRW5vT1dxRmh6Zks0cGhYckttRjVTR0g5WjFuc1ViRElRUENOZXJK?=
 =?utf-8?B?cHpJMHNTK3NJNmhzalNXZVFXekptL0d2R1k2WG9GaW45cjN4WUtuZG9JblRi?=
 =?utf-8?B?bnFUdU5JdzBKZTZqV2FNTjI1TDlWOS8wNVBNTzdUc053OWgwOFZrZW9jYkVZ?=
 =?utf-8?B?bDRFSHUvbndIMExneldObmlzK29vZlFva0lxY00wa3dCcmpkajNRcXRxYmZQ?=
 =?utf-8?B?ZU5hb3NqL2RSMUpiM05xbVU3T2g0enkzWUlNMGhyOWtoR2dxaXFGSTZiNWNK?=
 =?utf-8?B?Q1B3eGEvVzB6S01wNWg3alRIMk9ncHU2d1d4WXBuSkhoWmh5TVVrWW96RWNj?=
 =?utf-8?B?dmJWSmd2eTM0K29wUEFYOFhVZXdlRDBmTVNBTzZDSzVUK0UyaTZYTk9PN09N?=
 =?utf-8?B?STE2dXVDVHhvVFVmSkNwZnpWdUp4b25INGZUbkJCMXFscGlYeWtLSmxZc2Zt?=
 =?utf-8?B?YWpJOWZmY3NibVFTcmRrY2l3WmdSVnNCbXdraS84amNTYmVmc2s1eUFNMzlr?=
 =?utf-8?B?aHVUOGpibjRKUHZNdW5Bakx2QkVqK1NuODc2QTh3T2ZiMVZZRy9JN2F1YTRj?=
 =?utf-8?B?Mkl5YWJ2U3lvQVREeWxTVzJaVk0rM1RISjc1RGdxODQweG5rOW0ySFhxcU9z?=
 =?utf-8?B?eWE1RC91Z1crSlZWNS9lQWJxRjQ0YmFEeThpVU1qVjI0TFNTV2cyaG5hYXMx?=
 =?utf-8?B?N1BseVQvTnZaYk8yU2FDUzVXL1VtR3YyQW1PYzZvRFl3TnFidTUvREpsWkI5?=
 =?utf-8?B?MFZGZlJIYVdpT0hCem52SEpIa2trM1M5S3p5U0c1VkJjR3lJSXV4NFBnR040?=
 =?utf-8?B?VTIvNlppK3cwNGxTMEpoTnhCOU9xRU1WaHJGWnNIOVA3RDlZeDU1WFdnekdy?=
 =?utf-8?B?QThWWktCaU5LRXJUZnBNRXR4cnNXUFFEN3c5STdOYnR5QjVoRjRZRThnZmlG?=
 =?utf-8?B?L1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df89d2e-3174-4a8e-527f-08dd5a731570
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 16:47:28.8163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iEs4bEeBXNuvdim94zRbPcoSDI0msYdcZ/u5jUFgyq76urdDHFb0zLHnylz0xIrje6SKK+pOh6vdPsvnDQ6Q8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6213
X-OriginatorOrg: intel.com

On 3/03/25 18:22, Leo Yan wrote:
> Hi Adrian,
> 
> On Mon, Mar 03, 2025 at 12:44:33PM +0200, Adrian Hunter wrote:
>> On 17/02/25 21:58, Leo Yan wrote:
>>> Add a check for the generated string of flags.  Print out the raw number
>>> if the string generation fails.
>>
>> How does it fail?
> 
> In practice, I agreed perf_sample__sprintf_flags() will not fail.  This
> bases on a careful calculation for every invoking snprintf().
> 
> Please see comment below.
> 
>>> In another case, if the string length is longer than the aligned size,
>>> allow the completed string to be printed.
>>>
>>> Reviewed-by: Ian Rogers <irogers@google.com>
>>> Reviewed-by: James Clark <james.clark@linaro.org>
>>> Signed-off-by: Leo Yan <leo.yan@arm.com>
>>> ---
>>>  tools/perf/builtin-script.c   | 10 ++++++++--
>>>  tools/perf/util/trace-event.h |  2 ++
>>>  2 files changed, 10 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
>>> index d797cec4f054..2c4b1fb7dc72 100644
>>> --- a/tools/perf/builtin-script.c
>>> +++ b/tools/perf/builtin-script.c
>>> @@ -1709,9 +1709,15 @@ static int perf_sample__fprintf_bts(struct perf_sample *sample,
>>>  static int perf_sample__fprintf_flags(u32 flags, FILE *fp)
>>>  {
>>>  	char str[SAMPLE_FLAGS_BUF_SIZE];
>>> +	int ret;
>>> +
>>> +	ret = perf_sample__sprintf_flags(flags, str, sizeof(str));
>>> +	if (ret < 0)
>>
>> AFAICT ret is always >= 0
> 
> Since I refactored perf_sample__sprintf_flags() in the sequential
> patches, for easier capturing and debugging, here checks the return
> value to detect any potential issues.
> 
> Later when we review a perf log, a printed raw number for error cases
> can remind there must be something wrong for printing flags.
> 
>>> +		return fprintf(fp, "  raw flags:0x%-*x ",
>>> +			       SAMPLE_FLAGS_STR_ALIGNED_SIZE - 12, flags);
>>>  
>>> -	perf_sample__sprintf_flags(flags, str, sizeof(str));
>>> -	return fprintf(fp, "  %-21s ", str);
>>> +	ret = max(ret, SAMPLE_FLAGS_STR_ALIGNED_SIZE);
>>> +	return fprintf(fp, "  %-*s ", ret, str);
>>
>> -21 means the field width is 21 and left-justified.  It should not
>> truncate the string.
> 
> No, it does not truncate the string.
> 
> It calculates a maximum value between the returned length and 21 (
> defined in SAMPLE_FLAGS_STR_ALIGNED_SIZE).  It keeps left-justified and
> can printing a complete string if the string length is bigger than 21.

Maybe I am missing something, but that isn't that what

	return fprintf(fp, "  %-21s ", str);

does anyway?  Why change it to something more complicated.

> 
> 
>>
>>>  }
>>>  
>>>  struct printer_data {
>>> diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
>>> index ac9fde2f980c..71e680bc3d4b 100644
>>> --- a/tools/perf/util/trace-event.h
>>> +++ b/tools/perf/util/trace-event.h
>>> @@ -145,6 +145,8 @@ int common_flags(struct scripting_context *context);
>>>  int common_lock_depth(struct scripting_context *context);
>>>  
>>>  #define SAMPLE_FLAGS_BUF_SIZE 64
>>> +#define SAMPLE_FLAGS_STR_ALIGNED_SIZE	21
>>> +
>>>  int perf_sample__sprintf_flags(u32 flags, char *str, size_t sz);
>>>  
>>>  #if defined(LIBTRACEEVENT_VERSION) &&  LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
>>

