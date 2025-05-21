Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4F1236431;
	Wed, 21 May 2025 08:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747815294; cv=fail; b=Yc/9xQK5qDu7j0RVNQnEHC6rtnyrp5jcFvsq7TGxKBoWHWosc8HAmRokma27nTu+Px1i9BJAnDU1dXBd+MM/QwmkdX//oqrtIjvKt6nBmS6krQfKS5KKHk5aaOHltRFcHch9TtNEoxGzORko64FbIkr6Gjn6PzbhW1ZopxKEr3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747815294; c=relaxed/simple;
	bh=P3zKP5u95m2RvOR5VPQGFn1FSeXzoUgpRJu+zxBVXsM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GCQb4g1OwIF86LV6AkOaD+vLDKnYNFx64QebJQd5WtwL7sGAKg6FpYKUUtSZxRLiBDdTp4AEFgCRrYmlmMrJb2EHSLeSHWhfywXElkjl6fwELCrTEjYW5/1znFt9XPEfLUmciIINTJ6aYE+TC8XNPdj4tzXM3bmOdFOCfhKMuKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NEl2zURE; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NEl2zURE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747815292; x=1779351292;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=P3zKP5u95m2RvOR5VPQGFn1FSeXzoUgpRJu+zxBVXsM=;
  b=NEl2zUREwgPNibGMtjsYZNn8B9L2xrg0menIr/F/8SD6zb3mQLT0BqPV
   dau1JT1EZqy+1JPqVVEEzjl6H4k1dkGSzSP1WoagexvXsMBm0EM1jMzrM
   ww9MDjfaBpvankXON4fTNTECi0BOgd8jd9lVvmlLycruoFWC1znSxECAS
   rP6P6O7kEMl0Ei2SpJDz6VLpLMK5/bthZrYQ3OjpgS++HXln03NZiUVPz
   FoHyQvHGCChJ151JIb0gflSid/FhJr3L9pVk+aI3waMK2H/zbyeR6p0ik
   Vr7JNOpeNxHxeGY78eTttZs6LiCxwlCnbbB2mX9bh/nVKrp64K2olQDJ4
   g==;
X-CSE-ConnectionGUID: ITBEXFErQ3a8jnQlSvHpZg==
X-CSE-MsgGUID: vO6UqcmQQoWgl8SgodB1Og==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="52408463"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="52408463"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 01:14:51 -0700
X-CSE-ConnectionGUID: BIubImD8Q+iBi9B2IdOxGg==
X-CSE-MsgGUID: FthkMGrPSe+M132zueOncA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="139686014"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 01:14:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 May 2025 01:14:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 21 May 2025 01:14:49 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 21 May 2025 01:14:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=row7EyYocUfa5HPMRIvjq8YecIBKQ9ZUcxalC0L0g9HTGNdniz7haj/UAdPP88jrluiGslTtr0pW8rTDZE1/HSCurR/HL3R+dwkaxmoScq8g3TBtgt0CkAzQKRrpP5dHGy9YJIjapKucibxnuq41iuHXXMJCYkHpfQc8xNBS97q0BgfTmYj7Qz9m4InwaBV1KI56vkky1U9ufGc2lbtLbYlwLkzO2hN7FyytAv9Z+0688uZsdGyxReSIw0l+0+VEuHsy8D5tFIo8syDc3sJwspf6g5oc8Rl3tl5DzMHd7bErby82SZ4C5OLT2lAZsCx2NzI/UAJF6caXWEXG0sDzIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IjMjIDJh75jwPYFbEKlYD3kEt2FDgZZ4k0zAlfMj55w=;
 b=EB0pA+yEI16Ff/UtEw2aRSzNH2Ww+1p0W4hfO9taG430Udl4q6A0Cz64ew8RUJ8ViKFwjfhWtBlyX3Z/ZS+rkiIEA2dTAjqKgQ2g5JGJIS2h+PGGVyKjtNJWpzVE1Kzf18ehWYUPzdd1OXnio7phMCffRK979cD3lJsHTkJ1e1u8orMycvy8RF4UetoK4Cv6/GabIOJ76Huhzn6DSk4gfCKv39CFv6Vdbpv6Qf4R9ZJH5kSrpRhwnz7dL+2lGHqMnWC181ycDBLCUN/z7lCvNDRpGNB6Tnh90pSM7RV3yBgX1uoyVmwC+3SsIap8j2oRkfmv5mAkp1mD03JTKV7AjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6054.namprd11.prod.outlook.com (2603:10b6:510:1d2::8)
 by PH7PR11MB7051.namprd11.prod.outlook.com (2603:10b6:510:20e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Wed, 21 May
 2025 08:14:03 +0000
Received: from PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301]) by PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301%5]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 08:14:03 +0000
Message-ID: <8f162665-be8d-4299-9442-a677e935999b@intel.com>
Date: Wed, 21 May 2025 11:13:54 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] perf sample: Remove arch notion of sample parsing
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
	<jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, James Clark
	<james.clark@linaro.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>, Leo Yan <leo.yan@arm.com>, Yujie Liu
	<yujie.liu@intel.com>, Graham Woodward <graham.woodward@arm.com>, Howard Chu
	<howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, Dmitry Vyukov
	<dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, Thomas Falcon
	<thomas.falcon@intel.com>, Matt Fleming <matt@readmodwrite.com>, "Chun-Tse
 Shao" <ctshao@google.com>, Ben Gainey <ben.gainey@arm.com>, Song Liu
	<song@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>
References: <20250521052029.658800-1-irogers@google.com>
 <20250521052029.658800-2-irogers@google.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20250521052029.658800-2-irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7PR01CA0004.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::18) To PH7PR11MB6054.namprd11.prod.outlook.com
 (2603:10b6:510:1d2::8)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6054:EE_|PH7PR11MB7051:EE_
X-MS-Office365-Filtering-Correlation-Id: c8a5ada6-bc14-47a0-d31b-08dd983f728c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RGN5NUFyRlYzUDJnVlI1TWNES3F1ZGZzb25OUTZvZUlhK0NBUzFKd3ZqbkRh?=
 =?utf-8?B?ajRuMWZobGRVMXE5c0JtdDYvdUxQS3BsQ25ualJrN1VmTjdxVDFkYVorUEx2?=
 =?utf-8?B?S01xZCtEN240L1RJOW1IbU9IUnkyN0xwVjZVM1J6OXlVc0dOMVNmd3hJcmZx?=
 =?utf-8?B?SHRmckdvdDJQd25IeENEWGpFY3UzZ2lHRTlWL2lkWFQ5aHg2S0JHeWRqbEl6?=
 =?utf-8?B?NVltdTEydWxQQ2swVUZIM2UyQjhycElQbzhZQUY4SndKSHhyRERBZWlvRi8x?=
 =?utf-8?B?QlNjcnd5c0VweXI3KzVmTFIzbVRtSGZhUXhhSVM4b2tFNHkvUUljSi9JV2Jk?=
 =?utf-8?B?ZktqclRIK0dQdmtFaHhnZkV1M3NGN3lVdG1IUjIxampwdVZoNnpzRThNRVVh?=
 =?utf-8?B?MnlscFhveWlrSitaQlFnSHFoay9IU2UyeFNTK3lsa3RIRkdIM1FZOHVyTndK?=
 =?utf-8?B?ZzN3UFJ3NElWQkhGMm5HSldTamtGNEx5WmREL3gzNFJKb2VCZVR3aHloU3hu?=
 =?utf-8?B?eFRIVjUzYkJqMm5uck9LNENaWlR2SVpsbmlMa3FWSDhBMFhIOXdQV2E1S002?=
 =?utf-8?B?T1FvU2ViNEFHTWVJdlNieCtpemlGcU1hTVE2V0R5aXE5d3hLUkp4U0E2aUF3?=
 =?utf-8?B?TWYzbDFMRStOTGtEQm5Qa1B4RmgwRmtZYWpWUUtlQldJT0xQWUJQRUpQTXRq?=
 =?utf-8?B?KytBT2huaGVKalIxQzQyb21XME4xUi9hMEs3SlRGdjNIYzlkYmlId1djOUFQ?=
 =?utf-8?B?ZmlZdE15WFN5U1o1UWZjb1BkU084bXc0QU9xczlsenFRa0tGWlZYWUlZRVlt?=
 =?utf-8?B?blBBZTJhSEZmTFBSaGsxQUtvTm1jSGNEd0taSmwyLzJPTmpaa0FwaWs5UWJK?=
 =?utf-8?B?TUt0NU14WEtLQklOYXhzeHE1V25UZnNWSFRBWWE4MjBQVVVqeERUSERtNDBK?=
 =?utf-8?B?US9MR0dlMXRLN3FZcEdIanN3T0VnVzZPdGFrUGtGNVZwWVFKY1BoWHhWcllV?=
 =?utf-8?B?eGNLOS82d25mdjNrWUllUDQ5d0JIOUpDRFdJSlFPeFJzVzRhK292bDVtam8w?=
 =?utf-8?B?ODc5MEtsMTZrNkFFdkdkYk9oSC9lL09nSEFOSzZpZGJxeGpPZlgyckp0V090?=
 =?utf-8?B?SjAwbXd1SngyUVVnMVJ0QlkvbDhlUENnYUNKRkwrS3QxQW1GNGZidmVJdTlH?=
 =?utf-8?B?RFV1cDVEMFp3a3RkNkJzYlFra1ppdTBuTnhxbjhqMlZKdzdVR3k4bDVybnpG?=
 =?utf-8?B?WHVtSmYwNWxyQmtSMUN2SEQwRkVXUmZnSHRlQ3Z4akxsMWlzS01kUEZPYjcw?=
 =?utf-8?B?VFp6dG9Fb29xcktrcjF6akY4Z2VoYUE1YWZVejhDUzMxS1pZVEhiMHY3RVJB?=
 =?utf-8?B?S2pHTTdXNDFQZlNtRTVpRHhEMml0dUkyYS84K0hDMVVnWHlvbW9BUldZcnNT?=
 =?utf-8?B?aEFCSW9tMWE3dTRNTFJzM3NLWktHRVZ0WUdzcXdKVjNIRjBaRXVmSmJhUU0x?=
 =?utf-8?B?VU5QcmZCMEJhZ2dWMU1oTE5yYWdyb295OExCMld1YkIxMnFVSUdUU0xLd2Fm?=
 =?utf-8?B?dlhvdE1KNGZ6QmJDOVdiZ01adThYYm1qa2IxKzJDOFdZbWowRFRvcWZncnNF?=
 =?utf-8?B?K1hVczNDOEkxdkorUjJYWCtYVllBbHF6VE9pZ2htMmZ4R0NBTnVhOXQxd0xT?=
 =?utf-8?B?dWF5cTlsdm5YalhvUmJVSHhleDkvcG9iNEF1QjNUYi9JcHJZVk91WGVpSHMy?=
 =?utf-8?B?UEtzcEdEU2Q5REliVDhBM2NZUDBYSFpQNFNUaUVtc0c3SkV1UzlYTWw4b1VX?=
 =?utf-8?B?UC9tTnRpMldZZGU0em5uVERybkIvc01IeUZCMmlSWHpKdTNVbmRFYnA1NEEy?=
 =?utf-8?B?a2NHM3BxS29TdWxIaGpENnZnWDR1Z0lyNnFUems0YUpNRGhiUWhwK1d6VzhN?=
 =?utf-8?B?ZFFubHdwN1lCWDdZVG95L0Z3bDl3VXhQS0ZwQ0ZIb1BJdVh5V254NHptMlJs?=
 =?utf-8?B?YlBOVGxsNDl3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6054.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nm9aN2ZlbUFJWFJLYjVMVW5XN05EamRBcEZpdkRoZjNyY3JCVjlyYzZzN1JW?=
 =?utf-8?B?TE1HdTZGcStna2d0K3lrRnd2eXkvWkQ3SENlK25jZTk1cnNxbUp5bE1ZOTN0?=
 =?utf-8?B?QWxPbWxCTU9rTWlqTTdIK0dnOG14YmhGOTc5WE1YOUdYMy85QlFnc3VFVE05?=
 =?utf-8?B?c1dvRXdIRm5oV0ZQbHRpelVYNGx6amVnbEljQkNjWkJzUHNPdTRVMHNPZmxz?=
 =?utf-8?B?MHhiS0JHclRKSGQwYkUyaG1oakFTN2V4MC9MZHRhWkhhNHFDRmxkeXZLK1pu?=
 =?utf-8?B?WUhQZ0ZjdVUzY0hnWEJLV0ZJVEV6SmMwaHJNOVNzVHRjNHQ2ZjhpN0tnZ3FU?=
 =?utf-8?B?K2I0VzQ1VVNFTW5ZYk1uZ0JoakZDTUVjclpKbXI2d05NaWpCZSt3bGdwQXZn?=
 =?utf-8?B?TWtCMXhvVWE0NldpMGxyRHJ4Z0s0UkwvRWI5WnFjRi81WEMzZFN3Qms2MzhC?=
 =?utf-8?B?cGY5Zk0vcmczcVBZRytrMVZoMCttNmN6cXA0VW45aDZDV0lQNE9ySWliVUdM?=
 =?utf-8?B?RVIyRU1zMzNFWHcyVjlRN0FUVjViRTloSElVai94Yng3Z2lkOVQzUkJjSmlP?=
 =?utf-8?B?NGVmSnhnbUh0dGJMMTJPZlBWQXpyb3ZUK28wakFROFMycXBHSjhhbExiOVlH?=
 =?utf-8?B?T1lMaVRHalZOeFNxVW9BNmJNaWJOS3M3c3laaWxWT2IwQXhCNFVHVloweElK?=
 =?utf-8?B?WFRjZ2R0T3J2R3NHWm5hdFRmdnV6S0hOeWxyZlpGN0pUeHpPYjAwc2dzVVhr?=
 =?utf-8?B?NStLUkhGaUF4STlPZWo2ZUt0TkFjYlZXbVQreHFNbnVLKzFpY3pKR3pJcnlj?=
 =?utf-8?B?WngzdFJ2N2U4Z2xzVEhiTFpXVHhUdVVqMlF5T0RWelZjTzlwUUxPbzYycDlP?=
 =?utf-8?B?WFovL21MT3AzR0ZIN05tVmtvd2RmSUw5ZEg4NzdXeEd3R2FWQ0VBY2lKRUoy?=
 =?utf-8?B?WnBMT3hqVlArak8vSTF6NURkSW9nZUdFVWlkT2NFSk5reUU0Q3pSRlA2QlZa?=
 =?utf-8?B?TUN0TmFERUVpV29weWNYSENkSGEvejBVeTJ2UmJsMnFJelJuNTYxSkppVENv?=
 =?utf-8?B?eU5qU3U1T2xVazVlNXdPVEJhSFQyQnMxQ2hQcXlIMEdWVm9OSmQwV0xpb1Bm?=
 =?utf-8?B?R080OWE5WXZpZ0pDMGYrT1QzSHQ1czJ1T29yTnZRbWV1Q2I0MTJsZkhIMEp2?=
 =?utf-8?B?WkNraVZUZmowSk43eEpYU3Q0R2ZMQ295aEx4OFRNcFJiWkdLZHJQem1DNUxY?=
 =?utf-8?B?V3FKVEJmZWxiem9pM01JcG8vY0VobDhURTJlNlVMWU1HSFh3SHZJV2xKT2g5?=
 =?utf-8?B?eTNHWDc3ZlZHZXBBZW5nTjB5K2Q4NFNKVDJ3bWFSREo4ZGxQT1hDNlMvYWNy?=
 =?utf-8?B?OEdYVTZQZkZQb3l1UUZSWkxMQmhRdHlrZzFreThoNHRNTzNPYzF2ZUJYcDhz?=
 =?utf-8?B?bTlROHJJbThyand1dytITTArZHFLMFdRODNpbFc1THZ6SXBhZ2E1cm0zMFNU?=
 =?utf-8?B?dTNHWUJteWd1ZFNNbkFldmZPUG01cmFqeWYydG8ycUhMZFU3QXRJczBENklo?=
 =?utf-8?B?YU81SjFpTVc2SllpMEFHdHJFT1RST1YrRWxUclJUUCtJVDFWdHlBSkJMVTh3?=
 =?utf-8?B?Z204dHVDWjM1T2ZMeldZcmJhREZZNGU3UFFXNEV6MVVuR0w1c3VzR3NzOU1a?=
 =?utf-8?B?WnhBTEpjeURQWXQrNW1GZ01iZDNJUTh3QUlWc0l3NEY5VzdSWUFWYnQrditC?=
 =?utf-8?B?VHRMUlMwQVQvMC8rNExmRFVVL0FwN2JFU09rUlhrNVU2SXFNaXlTQ1dZcWFI?=
 =?utf-8?B?R2J3UW9JVWN5TEQ2N2ZrYmxyT085bnlwUHo2ZmFQR3lHWWE3T1h0ZXNOMjNT?=
 =?utf-8?B?OVo1a3RJNGVjR29MckJkdlh4TGI2b2ZhaUhwUlJXRWdlZVRQeVdURUxZbE9h?=
 =?utf-8?B?ZlIxYXZUc3ZwN1dpSm1OUFVXRzlZejdBTE1peGlCVWFWelBQUUdsZTlidjJh?=
 =?utf-8?B?ai9HUmVPK2FYM2tpUUZyeE9pYXBYQjFxYzdxL2lGNDRQNHp2ajNWb1BNSHFu?=
 =?utf-8?B?R0FOMkRIRGlIOE1HT2JvVENpUk1hMVJtbHBoUmZROGRVK0RQTXNsQWlyd2FL?=
 =?utf-8?B?SEN4UWJ5YjlTWUUzMnBNMkcxZ2pJZUJNbFQrS1VrNFdlOWhyVkFzaDFZdUwr?=
 =?utf-8?B?SlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a5ada6-bc14-47a0-d31b-08dd983f728c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6054.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 08:14:03.1886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5QuSsYQceP/OIIpNOeyrX4R8Dkb+hWsHMy3AW/n1fXk0CTbpySM6cf5qSwyaBjIh8upRGCFI4Lq6vqknK1fBuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7051
X-OriginatorOrg: intel.com

> diff --git a/tools/perf/include/perf/perf_dlfilter.h b/tools/perf/include/perf/perf_dlfilter.h
> index 16fc4568ac53..ec154fd937e7 100644
> --- a/tools/perf/include/perf/perf_dlfilter.h
> +++ b/tools/perf/include/perf/perf_dlfilter.h
> @@ -38,7 +38,7 @@ enum {
>  struct perf_dlfilter_sample {
>  	__u32 size; /* Size of this structure (for compatibility checking) */
>  	__u16 ins_lat;		/* Refer PERF_SAMPLE_WEIGHT_TYPE in <linux/perf_event.h> */
> -	__u16 p_stage_cyc;	/* Refer PERF_SAMPLE_WEIGHT_TYPE in <linux/perf_event.h> */
> +	__u16 p_stage_cyc_or_retire_lat; /* Refer PERF_SAMPLE_WEIGHT_TYPE in <linux/perf_event.h> */

Don't rename dlfilter API identifiers.  It will break dlfilter
compilation for anyone using the old identifier in their dlfilters.

