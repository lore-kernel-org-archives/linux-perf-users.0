Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173D3299951;
	Wed, 25 Jun 2025 15:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750865102; cv=fail; b=TaD869cEqWSPm1CySvouAggmBzEXtQgHrM67+Xq63NmCO+f0pcmYmMXif8Ox3C6HsfyKUfEKw6JGFcdDLw5pInqsKeRkkYGQ/hBFwN5yuxaXRUbNocxM183WEsBvOkc9rpfyHlkA3iJtiniHLqzdj+XEko4b/bVcyT+vkSzCWBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750865102; c=relaxed/simple;
	bh=bdYSKl9DyvHp5UO8oraDwxskkL0PSgg5alER/jdA7fs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YzDsNU8IiWGX4AIY5rmZq/g8B7q4qyQoYXJHMZ8RngQBccjyXYYUaS0En2t+0nDh2TmBP2wzpQtQ8IVVjW9u4ubv12XewNy6QG4okgEZeskeu8RR58nBM+WONVw2Eskhf8ZW2d6RQ702Hx/gSc8lLWGBhW/SBKmZnNqXZLuNvys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LTATnex7; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LTATnex7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750865101; x=1782401101;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bdYSKl9DyvHp5UO8oraDwxskkL0PSgg5alER/jdA7fs=;
  b=LTATnex7cO3Xi7IT7i0YIxszMiyfaPQpjXsQLuAn4K7ad9oEj8mTL9uc
   VgUEb796FwG5Oczg5spvmtOS8yeBurzZ2p9p3PI1uJ0vgu6fXmNyrqq7B
   U9H1J+n/Imub4uoh87u2t+LEgJ5tJs83ON+x78eGUDXSWabKORk8dEvRc
   jYnOQF4TaRoTo4ZGtAXA+fnCxSAo6jEk8Us/cf4kFW2aEy3QloZCoZwaF
   7L2U2HhxC4VxcGjdL9YLVEBitKAih2U6lZxCk8PgcY+6/iaZlOi6v7gV5
   jOJVJzBGa90IwMwNitVcoErM0bs+vHAAM0mO4Xt8f/8KoRc+GHvhsWiTo
   A==;
X-CSE-ConnectionGUID: Cd7oC/PxTACRbuh0hLBTIg==
X-CSE-MsgGUID: HICjjAzPRJaFJDGRQnHMqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="64199973"
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="64199973"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 08:25:00 -0700
X-CSE-ConnectionGUID: Fa4FCZi5R0Gk6D/xschB1g==
X-CSE-MsgGUID: nUkCB5XbQAaC1fI90JFoTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="151865622"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 08:24:59 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 08:24:58 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 25 Jun 2025 08:24:58 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.57)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 08:24:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZE+QZyiqGfA6yE/Dz9/kwf7S2dtrer3ZWz8W0Gwa7dzOnCeKErhT1OmOWPV5rbWfi1lrW7NZ0zlq5Z7Nh/UtLY5vWxPZVsU73iWEye9sNMGFzZzsfMH/ezjXEa7zsRrOu1X3SPc+MgmdeeBzGx7tcyQrHlZydEOj+ktrA0DZOZKxy90uVc7JaDTTcWItDClTZ+1QNJFjzDCK0cGXszNyog0vey20RUv+OQ1bAH8DFmfpADgW6+ARx5h4opsPFPQxRHLIaEGMlC2VCKy5y3hd79UFg/TqRYSkV5xkRdJtYQPxmZ1RjlHXNc2TQGwMNN8Au5jjgRrLDDSmGlBFnE2Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdYSKl9DyvHp5UO8oraDwxskkL0PSgg5alER/jdA7fs=;
 b=WsELX4I6iWpPBCvIlqLP5nnTDC/Py3zFBHisfnusKU448413DoNBumS+Y1jszr62aoEG5sOcIJ/tJpeIjPnxadg1UWZYZbQqGyRmtzo0S8vT+koVeL0dNMld/E3DpHLEvZEJQwuUznIsEnRjrCWiootxtv83eDeAoptY8nAR7SxgHjH7a7M/HJNZMrvEyq3wHcg4F1k3oHIWA78mS0Z5rNWr2ovW7J0Pv0pDfK/qThAQT5Z+HcwPuidTyQrmx1IyK2igvD+Fdm7Ign8pxKCFb2oLzHtVWzU95kQxnj+X9irWFtlApCA7phAuU730HlqPAAA7PgPkjGwt78Szyys8rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB8289.namprd11.prod.outlook.com (2603:10b6:303:1e8::9)
 by PH7PR11MB7988.namprd11.prod.outlook.com (2603:10b6:510:243::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Wed, 25 Jun
 2025 15:24:41 +0000
Received: from MW4PR11MB8289.namprd11.prod.outlook.com
 ([fe80::d626:a4f8:c029:5022]) by MW4PR11MB8289.namprd11.prod.outlook.com
 ([fe80::d626:a4f8:c029:5022%7]) with mapi id 15.20.8835.027; Wed, 25 Jun 2025
 15:24:41 +0000
From: "Li, Tianyou" <tianyou.li@intel.com>
To: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, "Hunter, Adrian" <adrian.hunter@intel.com>, Kan
 Liang <kan.liang@linux.intel.com>, "Guo, Wangyang" <wangyang.guo@intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] Read perf data file header from the file user
 specified with -i option for perf script flamegraph
Thread-Topic: [PATCH 1/2] Read perf data file header from the file user
 specified with -i option for perf script flamegraph
Thread-Index: AQHb2bWKCxWmjWzyvkS+T2lRlsHtMbQSrkWAgAFouFA=
Date: Wed, 25 Jun 2025 15:24:41 +0000
Message-ID: <MW4PR11MB82898AB65A5CD31B3698D1DF957BA@MW4PR11MB8289.namprd11.prod.outlook.com>
References: <aEeIN_u4KpLZXDBx () google ! com>
 <20250610040536.2390060-1-tianyou.li@intel.com>
 <175078758996.337518.10407598236638254580.b4-ty@kernel.org>
In-Reply-To: <175078758996.337518.10407598236638254580.b4-ty@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB8289:EE_|PH7PR11MB7988:EE_
x-ms-office365-filtering-correlation-id: 23314c55-ad9c-4ff7-014d-08ddb3fc6834
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aFdkOE9GZjZUWjNrSldMMUxnWFA3T0JrK09WOE5yVUZ3c3pPaWw3VUtyaGRV?=
 =?utf-8?B?cS8yZklqenU4ZFNKU2wxY3Y3VURoQVVyRWh3NDhFankwWnhRM2hnMUo0L29B?=
 =?utf-8?B?NVc5UnlGRVEvYWZYN3M3MytRc01JclNYdWp2enVFeWw5U0RYVG43RUNVWHBn?=
 =?utf-8?B?eFMwMWhpclRZN2xvT3I0NEJPWC9scjYydWNtUHdieHRUZUsrOUhkakhpYjVl?=
 =?utf-8?B?ekI4WTBKMWZmOXRHbXZUQTNmaDBBSUZhWWdqTEQ3YU9DOVBINkx1RjlMZGJU?=
 =?utf-8?B?d3lHRUNBUmYzYldvZUdRQTVpTm1EUC9BbUdUbENLVURRYktKWGV1UFhDT3dn?=
 =?utf-8?B?VDdTdUxJZk1xcVJNNm03WHR6T0c2SGxYNzdQcGpSRDA2czZ3aE03bnBtUFNI?=
 =?utf-8?B?YVBiaUtpbjlHVlo0Z2V4K1Z1TVJxUGpLQ3BhMk1tM0lzdHNRQncxcEhiM2R5?=
 =?utf-8?B?Q29rdEJZMDZBcE9NVXBJSVZibWlmUUlXbEVoYWxjby9OT2M4RUpoU1ZFcDk2?=
 =?utf-8?B?Z0RvcXYzSmxFOFk2M2l6Vjl4cHdhK2dHckkwWVQybVNXMTJ3THQrbEswdDFu?=
 =?utf-8?B?NHdzR1czYUhMVFZzOFNmY2V6SXhHTmRFajBMak1IVUoremF1U2N6MFpoVXlx?=
 =?utf-8?B?NDVIZ3FKSW1VSU1xZDVEbUFWQzNobldxOGZRa3JoVkJLcW5DOVZKclBLcm5N?=
 =?utf-8?B?T0tTNmJEbDdhelJRbEY2K2JIQkZPL05TektGZUdSUDlpeTN1T21sUk5IZ0NN?=
 =?utf-8?B?VlhFK2tLM0ZJMktYRTN4bHNLbFc1cGR4QnJIekdCNk5hVktneGhlOWROdHI4?=
 =?utf-8?B?Sjloc2pxUkRFUndSR3l6Q08rcHJ1U2pUUmtScU1aUmlITS9zdDF0ZTZZNEhn?=
 =?utf-8?B?WFQzeTR5NDNnNVU2N29WS3FQRkNnUGRFSHF4K0ZsUmYwb2JUTGZQTlF0UW81?=
 =?utf-8?B?WWRpMlNodVJnSjNvTFYxYmcwYzQzYnFNTXJ3MGVDaFFJeTFJVVEwZEdIaXlV?=
 =?utf-8?B?dGdpdDVYTzNFc2dodzMxRHJTdFRCSEkvbnd5RGNNTndWUi9qUXUvekRXejhy?=
 =?utf-8?B?Rk9BSXoycHR4aWhKaXVQNURsSXp3dm54MHd3REVDdzBaKzIwOGJGRnFUMGFr?=
 =?utf-8?B?MlBGQkF1eXZTKzNrTmhLMkFHczhvVFRjVEdIOER5V1ZoVXFRaXpqSER2Y0hy?=
 =?utf-8?B?TUs4bVc5eUZlUlRXSjRBc1dkQmx0UW9vYWhJN3NlQy9MTGNZM0lqamVJNXdq?=
 =?utf-8?B?QWp5VGRGLzZOdHdMRWxEZ2lrRlhVdEZTY0R1K2tRTTI2UlRJcTV6VkZGbWdz?=
 =?utf-8?B?SmkvUTcrbi94Mzh5dkd1bHFKODVRUGYrSHBCby95b01kMFNuMGQxdEk4SnRm?=
 =?utf-8?B?UG55c2h4VVZ2cGxhRlgwVUhNMVZWd3QwWmxYcVNkL0paazc0TlRGOE12MkhX?=
 =?utf-8?B?TnRBbVhna3J2bjdNQ2xWekZFalpzZ0FhRG1sTXJ0SlJKUEU2MFlrYVJwWmZa?=
 =?utf-8?B?MHdwUjg3eVMwY3o3ZGg5VHlyZEw1dk85eFBSOXhhWTNReHE4NVBzREFqcDZo?=
 =?utf-8?B?UlNqaFl4eEFlUi9yYXlYMUFHRzVwc28vZldrQWxTaHlnWGIvaXM2cFZMU2Jx?=
 =?utf-8?B?UUJvd01BbkRkbERNVUYyRmE0NFZGdnNTeG5JVklHTG5lVFUxSy9JWEUrbmx6?=
 =?utf-8?B?aUdJYmFmeVlhVFdLaG1ScnZwTVZpdGFPOVNUbGJ2d0VZOGZ1RStuOVVYMm5R?=
 =?utf-8?B?NkFIQXFaaUVDODlZRk1iS0o2aTY1MnpPa1VsMG53RVVaVGJ4K2Q5c1NGRFVI?=
 =?utf-8?B?RHIwUmdJelZRUG1pOE1rdVltd2JzM3FtZmlPeWZNSm9KRlpXY1FYNjV3TGt2?=
 =?utf-8?B?OTdRWVByT0lLWmJuWG4yb204aFcwRjNrL1EwQmVTMXMzRUZCclYxeVRMMjF0?=
 =?utf-8?B?UDNNNjN6K3RoVjJmcG1JT2NiOFovOWl6ZFptd0ZsQ2NsNmZuNklqWGFmSkpG?=
 =?utf-8?B?UXdUejhrckFnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB8289.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UElmM2I0TTFSc0RIOGFkeHhUVEhjM05iM2tSdi9FWmsvdmlKVVRiZlM4cHZa?=
 =?utf-8?B?Qkp4WUNuZUcrWUtJemRMK1BSdzFRc3UzWWkxYmFDblJ2RHJUVzhVaEI0NVIy?=
 =?utf-8?B?aTVaa2FmUGdjVGtia01nL3gzam1pTHljQ2ttbUtJQkNvTC8rTlJOYkpmMFZI?=
 =?utf-8?B?am9IbWYyRWtjd3diMmRrVDM4V1Q4dmVJVkE2SitpZm9ncmFnU2ZnZDE1cHY2?=
 =?utf-8?B?NWZtOVBoaWVkdjdzSCtkcVdyVHlNNjk1Ylgzbkt0dm1DL0tzVjk1c3kvalNn?=
 =?utf-8?B?SXhaZ1pVdjlkMXRaY3BPemk0bldFSEZYZlBSbHlaZUxYcnhEczNuVzhPY1da?=
 =?utf-8?B?WTZCY3lvOEdsQ1psVDAvTGhhNjhqeUk1ejFWeVZvMi8wN0x4Z0YxUkN2Y2xh?=
 =?utf-8?B?YWMyUXRKd0NLMTRjaDEySVB6aFBuTS9BM1N4V2pWa0lMWW0yVENTL2c4djJN?=
 =?utf-8?B?VnVuUlZvRis1eGlXQkovZDhEV1JFTXlhaStSdTV5SlovTFR0Unl1cHlmbUMr?=
 =?utf-8?B?VnJIVkF6eWxXSmc0YW9ka1UwMGpPUGFPWVIzbVM3R05WdTlBRUgwNWxLbEpa?=
 =?utf-8?B?K001VzJ0cUthTWs1RjZQakdzRE52OGFiMEJ3UDhxNnBDZjJkZjlMT0xnd24r?=
 =?utf-8?B?SEtNUlBQSjZ4QkthY1lFQ1ZoeFVHVHdIRk53MmVqL0RFellkSlUvd0JzOGk3?=
 =?utf-8?B?S2c0dE9jU25RTzV2Z01meG9yRkZrbng4emJEVFpzT1RxZzdFSXNHclZ6OWJY?=
 =?utf-8?B?bTdYSXdXd3FraWp4aCtMcDlQMkZRSHFkSS95SkZjaHJYbkU5VThuTGdWbDlD?=
 =?utf-8?B?a2ZTU2c2b285NEtrNnRPbEpTUTN0RitQcEYyZ0RQSXZBUmREMmtDai95NWsr?=
 =?utf-8?B?d1pSUUJLS2Flb0lvTEdEaGdxRVBVdTdXL3E3THhBL0JnMkhMaWhIMUVtQVpj?=
 =?utf-8?B?bGI5aUs5UHNXaDlKTTlLdjJYTjBUTVJPeUNUeFBON01ycGUrVnJ5ODRiVUps?=
 =?utf-8?B?b1JRZkQrVEc1S05Pai8vV2ZYRmpXalFmMk14ZnZ2RmI4cGtGclQxZ2JXRm9I?=
 =?utf-8?B?bzluZjAzQVBncG5YZnRxbHBnb0JsUDd0VEJxNkdNaCtuNUJNV21LdXNFZFNy?=
 =?utf-8?B?Tzd0bGpIemEwQVEzQlJVUldCVlNrbThYNUZyNFZORW1LV1JZejdNcmhqZGRT?=
 =?utf-8?B?M2hnZ2IrOVBwQW9ReTZILzE4RCtDYkpYbHg5cDc1K29hWTVZVWxuU3BSMHRB?=
 =?utf-8?B?WFlQenV6VUFuV2xDaGlKT2ZiM1VjZTdrRWw4M3Y4Q3NWYWhlb1VVem1KT1gy?=
 =?utf-8?B?eU1Kb0Q3NDlwQkpQV0ZHTWN6ZzhVQW85ZUxlaTVGVVdGUFNiQlAyT1BXV3c0?=
 =?utf-8?B?RXVFakJpeGhqZUZSTVR2MnhHN21OUVEyYVNVYU4xVjRJeXI5UmRGSUtlZm9Q?=
 =?utf-8?B?ZHRlQWFQKzFLSXRESU8vRjU2M0hvVkFGQ0N0VGJOTnpLKzByTHZTQVhNTE1N?=
 =?utf-8?B?UGthL1JCRHNadXF2WkxCczErVk1BK0YwMVF0RVdZS1RYaWZEQ2FoOHZ1clll?=
 =?utf-8?B?VnR4UTVMWkswVEJlTHV1TmpPTWxucjc5Sy9nckNydTlweUsvSENWWndLNk00?=
 =?utf-8?B?V2g4V0Iwc09KSTdUQnhra0laVzU0RXk5eXlZVVdjNDc0UXV0TkNZSHV0YnhH?=
 =?utf-8?B?THhSN0xOZUplajQ5bWJtRHp6cEw1TWVkQVZYZGxKMjBJcUt0VzFDbUJTWTZY?=
 =?utf-8?B?dUR3QWpwVytyLytvbHhSVXlpZWN0LzlvclNHRWh2Z1gvemdMY2VIbTc2YWpz?=
 =?utf-8?B?cFoxMWFnNlROQnp2dys2Z2xQM2l3U3hGL013ZkZ2djZ5RSs3YXlxNjZIMU15?=
 =?utf-8?B?a2UxbGRCZHVQWm1MaWpmVEJxNk54eXhvQlFtVUdmU1FhdEtEdWVaM2dzcFdS?=
 =?utf-8?B?Zk5SZ1lVT3cwRndMSEtsQnh4N2kzdkpOd251M2RSSkJFQ0QxaXVJUm9jNUFt?=
 =?utf-8?B?Y1BTSHhVazd1aG9hSStvdUFibUp5SHZ4NklRV2toMS8xdld3My9Jd2dQOE5H?=
 =?utf-8?B?WWdGYWtQOWpGWmRxeUFaK0x1Ynl5alltV3lOY1BvZUpka0tXY1RrRE1oaEo0?=
 =?utf-8?Q?mDbdxv9ixuVt3dIH6R3zpCj3H?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB8289.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23314c55-ad9c-4ff7-014d-08ddb3fc6834
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 15:24:41.7237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b5ZwybpF0sQdi6l5rO6vvod+D2y5LTk8wgLHU9nVWFm573PmUtHI5RD+sxsW+5sGikJMF3nDdLVf2DmOorLEWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7988
X-OriginatorOrg: intel.com

QXBwcmVjaWF0ZWQgZm9yIHlvdXIga2luZGx5IHJldmlldy4gVGhhbmtzLg0KDQotLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTmFtaHl1bmcgS2ltIDxuYW1oeXVuZ0BrZXJuZWwub3Jn
PiANClNlbnQ6IFdlZG5lc2RheSwgSnVuZSAyNSwgMjAyNSAxOjUzIEFNDQpUbzogUGV0ZXIgWmlq
bHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPjsgSW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhhdC5j
b20+OyBBcm5hbGRvIENhcnZhbGhvIGRlIE1lbG8gPGFjbWVAa2VybmVsLm9yZz47IExpLCBUaWFu
eW91IDx0aWFueW91LmxpQGludGVsLmNvbT4NCkNjOiBNYXJrIFJ1dGxhbmQgPG1hcmsucnV0bGFu
ZEBhcm0uY29tPjsgQWxleGFuZGVyIFNoaXNoa2luIDxhbGV4YW5kZXIuc2hpc2hraW5AbGludXgu
aW50ZWwuY29tPjsgSmlyaSBPbHNhIDxqb2xzYUBrZXJuZWwub3JnPjsgSWFuIFJvZ2VycyA8aXJv
Z2Vyc0Bnb29nbGUuY29tPjsgSHVudGVyLCBBZHJpYW4gPGFkcmlhbi5odW50ZXJAaW50ZWwuY29t
PjsgS2FuIExpYW5nIDxrYW4ubGlhbmdAbGludXguaW50ZWwuY29tPjsgR3VvLCBXYW5neWFuZyA8
d2FuZ3lhbmcuZ3VvQGludGVsLmNvbT47IGxpbnV4LXBlcmYtdXNlcnNAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0g
UmVhZCBwZXJmIGRhdGEgZmlsZSBoZWFkZXIgZnJvbSB0aGUgZmlsZSB1c2VyIHNwZWNpZmllZCB3
aXRoIC1pIG9wdGlvbiBmb3IgcGVyZiBzY3JpcHQgZmxhbWVncmFwaA0KDQpPbiBUdWUsIDEwIEp1
biAyMDI1IDEyOjA0OjIyICswODAwLCBUaWFueW91IExpIHdyb3RlOg0KPiBJZiBzcGVjaWZ5IHRo
ZSBwZXJmIGRhdGEgZmlsZSB3aXRoIC1pIG9wdGlvbiwgdGhlIHNjcmlwdCB3aWxsIHRyeSB0byAN
Cj4gcmVhZCB0aGUgaGVhZGVyIGluZm9ybWF0aW9uIHJlZ2FyZGxlc3Mgb2YgdGhlIGZpbGUgbmFt
ZSBzcGVjaWZpZWQsIA0KPiBpbnN0ZWFkIGl0IHdpbGwgdHJ5IHRvIGFjY2VzcyB0aGUgcGVyZi5k
YXRhLiBUaGlzIHNpbXBsZSBwYXRjaCB1c2UgdGhlIGZpbGUgbmFtZSBmcm9tIC1pIG9wdGlvbiBm
b3IgY29tbWFuZCBwZXJmIHJlcG9ydCAtLWhlYWRlci1vbmx5IHRvIHJlYWQgdGhlIGhlYWRlci4N
Cj4gDQo+IA0KQXBwbGllZCB0byBwZXJmLXRvb2xzLW5leHQsIHRoYW5rcyENCg0KQmVzdCByZWdh
cmRzLA0KTmFtaHl1bmcNCg0KDQo=
