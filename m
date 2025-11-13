Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8657B3E1;
	Thu, 13 Nov 2025 04:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763006748; cv=fail; b=EiFzX28BQNUiSrcZZS8TX/aWHoCoXsZn6KxAvPObL3a4v7fWvT9Std4IRxi7GmQ/P0TtkwylXInBRePhWRuNehl5HNZxIgh8PvgzBvLg6p5j2zgQ4dxUFp+YJnsN5U274wLPpFeuclCZ6akUCntZKKDDEUd1yZlQdiPSIrvYAtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763006748; c=relaxed/simple;
	bh=/4gS/u5IXJyNxKoLWw5plLt9cKpVlITVKzHtvHcnhB0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SvywjDOPFiW0Uku3YqDsUSwng03jzi+BFZaq7ZeHe56b2+hEdTbWOGcc8WC2GX+0HWadoEfj+MRKZG/NSRM1PAxuw1xd8Z9I+C3zfXx+aTv7iMVd+PdDKjWCC0iRaqzrMNb2r69loOU5dMlH2qa3qwN/ZFbbhb8d5FsJWaRjb90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VQ5ABOD0; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VQ5ABOD0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763006748; x=1794542748;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/4gS/u5IXJyNxKoLWw5plLt9cKpVlITVKzHtvHcnhB0=;
  b=VQ5ABOD0lwEW/puB1qeD4Mm5JFe9wxa+nledxkxDK2jOut2/gSb2SU6T
   gBx1jvCRT1txKSu3Xmz7AZLfawIfPGFDkCUKah7TIXglHc+/VJ3nz7D+z
   0MC6RzD8nFDWCHmGGU2CwC7Rio8ieLEpnotb1qCT4Si93UEhbHIla01LC
   LrjDBO8XnzMuA5yDNrpt0mbO0b8fZ4NGdlUWtvX9NvLXmN7Uuqd0+/gbH
   Xc4ForC9en3hDe58oaRB+bjAvaKtBOTRbPdYghQv0URnhXsnVcYZmma7S
   zv1Y2VKpm1MrrEDShuT4v9A2SMSIWYOzfLkKkPZwne2E+waJII3/DjqGo
   g==;
X-CSE-ConnectionGUID: ip631tn8RpWh9x2izYs1cg==
X-CSE-MsgGUID: 1oxwaRSPTEyi3H4pGoApEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="82477978"
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="82477978"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 20:05:48 -0800
X-CSE-ConnectionGUID: Ud/lmme+RQqW/ZhxT4gPiA==
X-CSE-MsgGUID: 8pyVQQlfQJ+WsEBMpAN/zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="189247374"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 20:05:47 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 20:05:46 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 12 Nov 2025 20:05:46 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.27)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 20:05:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LsQVuC1VdVTfblFCVtuVy3fMxcs5CeGK4QWFe0mXMhHhjr0N4qETEzLupHlHvT+iMI5WqewCVvDqtL0br+CbQ5U7u0HDb9RogNlnrd9P2UZvYIooAMQztLSEzj3YT5MshRy4xMGd0VVNoRKeyouc4uZJDgwt/gH5loT8hFYLDb3PBOn2XDaG10inRYI+6dZXYG8TbTZVZz8gYD29t2k4oexqdn5BronYSLkxaSDn9zfMuKkG6Qdg/+OMQ/bnvUQL0SlT3ysYdWQ2Mz4MPaga7Smv+8UGdJpSCqNepaSb/kf6HqM3oScO2D5Q9B/mT1+CR+0RHwbHdfzsYiJQkcKStA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4gS/u5IXJyNxKoLWw5plLt9cKpVlITVKzHtvHcnhB0=;
 b=PmDVweEXHJHq+aMGKQZCf8UvMctcqe8pN6D5RxVPHGP0zTqog8ERjZOVO42SdBgEhQ/R0WQy5oyYRYNSo4KAxnzdfKqfdNUiOUTFAjFTe3+3ICPSahmoY1iKq5fYjpiwMLIkLw+yBYPMTxmC2drqbFqB8tyXxzuMMKqBt0IGW6i++keW6/s8yjLC6JKrN7S/P+YZsWI92MB5GQuzOgk8btjuFRIh5g+0G0XaZVGBzKxtCe4hfFmZ6rqsJ6vPERu3QtQLR9ltJmi/f8UvB0xKU+6beYeBiwZZpiQEa5BquDPf/hRKxQu7t39rJ+cjdfnEPmbV63fIb5YYHtC9HwayKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19)
 by SN7PR11MB8263.namprd11.prod.outlook.com (2603:10b6:806:26d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 04:05:41 +0000
Received: from LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308]) by LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308%6]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 04:05:40 +0000
From: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
To: "Hansen, Dave" <dave.hansen@intel.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "acme@kernel.org" <acme@kernel.org>,
	"namhyung@kernel.org" <namhyung@kernel.org>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/events/intel/cstate: Add Pantherlake support
Thread-Topic: [PATCH] x86/events/intel/cstate: Add Pantherlake support
Thread-Index: AQHcVA/yuVycok0wc0eQYHOWzNwi67Tv+0DQ
Date: Thu, 13 Nov 2025 04:05:40 +0000
Message-ID: <LV3PR11MB87682D759248CA310546261CF5CDA@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <20251112090024.3298186-1-kaushlendra.kumar@intel.com>
 <1ba407b6-a108-41ce-b1b2-3c03aa25d272@intel.com>
In-Reply-To: <1ba407b6-a108-41ce-b1b2-3c03aa25d272@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8768:EE_|SN7PR11MB8263:EE_
x-ms-office365-filtering-correlation-id: 92a43f79-0706-4d8a-a5c5-08de2269e8bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|921020|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?VVF1QTdSeHFCOWlFZ2w0VzRTQ29JREJSalQwSDJmY2ZVTWc1clBMeWUzZkh1?=
 =?utf-8?B?R2FabE9RMERPTkJGR251czEwcWxBRk1zV1drdmwveWl3U1RIQm1aS3AwTzFp?=
 =?utf-8?B?TW1TWjZreFBweVRVVHVIS2tBODBpMzR4MG5iblhCZHp2TXVvdWlqS01teC9R?=
 =?utf-8?B?a1M1WWdMMmt2ZkkwWlBraGpOSzV1a1hBRmJaQjd5R0Z1LzBvTjVMcFpDbXV1?=
 =?utf-8?B?cEZqVitBaEt2NlJ0L3U0UzgrNWYrTDVicndvMnZEemRSTXpKNW5TK3hwc1M0?=
 =?utf-8?B?aUZJdkVkK2lTSUZHaytyNFB6eXBZeGR4M0VmV0JKK0p4WU1sQjNqQ05RbGZC?=
 =?utf-8?B?RTdWSUJUQXVoZ0lpMTJTVG1ka3NoaERIWXFLVVhLTjVkMWVqWElDeit3NU9N?=
 =?utf-8?B?VFZteXJQNWdLY2hSRm1OZmdCSjBKd3hTeE4yeHZPbWlIaGpvT1BCU21USkUx?=
 =?utf-8?B?RnhJbGtIeXJxM3VlckRqNXphMTJFczJzbm41Y09KQTJNUFk5ZU1PN2tncko3?=
 =?utf-8?B?a1kzV3JnRkwzaEFGenZadmoxSVFkWE1uaXA5L2x5b0Iwb0Jldm4wOUk1NFNi?=
 =?utf-8?B?UUVVV0VqVjVpY3prY0FJczExbG1ENzc1ZWs2cW0rK0xvcWRhMW5MOEVNaGFx?=
 =?utf-8?B?amxsTUt0WUpNS1h0Sm5zWW1pTkpjMk1IWjY2di9WWjJZMzhJQzFGNUVkN2xa?=
 =?utf-8?B?T0oyeUowdmFpL0JSUVhCbEVhZzhVc21hUU9FOFNrTzBuT2ZqZGc5WXBqc2ZX?=
 =?utf-8?B?ekx1YnNLMEE3MVVyZk5wL1ZFTnhlRVl0YUZISnRhNjRTRjRYZnhFTlA0d0dv?=
 =?utf-8?B?Tk9iOVhFd0ZNZVg2VFMvWWJiaGF1anBTM292YmQ0VmM5ZDdsNEdoSmlHM2NS?=
 =?utf-8?B?RDBjakxDclpCcUNOT29OMkR3U3ZvWjhlRkFpbnR3SzNBZW1uVU1sVkZibldR?=
 =?utf-8?B?eUl6NTBCVXNpVjZpajhKTTZiRjV6SmtSQkpGcENycmpoYUdmMnU3YnhDc2Fo?=
 =?utf-8?B?WnZRRWMzNUxxeFpPbG15WU9qUkpYNWRCUlJZNjhOdkgwenJjWk9sSHBNTmR2?=
 =?utf-8?B?M2w3NlFySk05WnFNWHIycGVFM0pDV2Z1RjNtQ2FDZzJPc043VnRTOHlxZGNm?=
 =?utf-8?B?cmVmampzcTJmMEIyNzBod1dDTjQ4eVVRNmlZZ2dQRXZCTVJ5YU5xWkxjU2h3?=
 =?utf-8?B?eldWeU9OYW93bWNBTVR5QU84Q1llc1I1cVZZZTNabFZFb09EZUNrQU9wbjJo?=
 =?utf-8?B?bGgwMnBmbzBKVnAyTk42NGYvZU9PMVdlNWJNUmhrdGR5Nkw5QjNTbzZTZEVv?=
 =?utf-8?B?MWFQTUpMNE1OQXZ3eE44QnN2N2xaWDExR2VyLzhMdmw1N29tODg1MWxVMGFW?=
 =?utf-8?B?RS81MUozTG5SRVhVQ28yNFBjSG5CdkZuNWJqZDdIb1k4RGdlSlA4VlNwWEpm?=
 =?utf-8?B?SEpkQ0JUMnl1bERSU1I2ajNBeS80YWxVdis0QkV0TThvdW5PZlhZREs4QVpN?=
 =?utf-8?B?a0NCOWFuTTQ3by9ycUpiMHErQ2crdGJNWnJSWFptSmJyZTFrbUN1ZktOeUpI?=
 =?utf-8?B?TFBCbnNKcGdnWHBpNG43OGljakFvMVc3MGRBTWYvUHFiQUh6UzFrelJSVjVs?=
 =?utf-8?B?MllVUnh6K015ai9RN2hnbkpRdVpaMkZVK1hPZUttMkJzbFhxR0JTMW5nb2Ra?=
 =?utf-8?B?eDVTekZtZ0NnZmFjTGxRSnJ0STIzSXRYWmdpMWppTmlkUjAxN1lGclBiTjkw?=
 =?utf-8?B?WDFHSkdCQzBqWEROdU9UQ3g3ZEFhVThNNCt5cmNyM2VERWdkU1kwNjJhTGlM?=
 =?utf-8?B?ZjkweU5HbTlIRFQ0TWtIZm9KbzBnaWsrK2JteTRRdUk0NTFnaVd5bVRBRmsv?=
 =?utf-8?B?eHAvWHFLR3NOcGM2UVFVUkN6bHhwSzFxQy9NRWRMb05sdGFBVmRvZkp4bkJE?=
 =?utf-8?B?cW0wYmowb2l6dFdmMGJ2Qlp0REczdFRKWVQzT3FBaTJ2T2JpeEZQRDBVWTJ6?=
 =?utf-8?B?Uk5JMHo0eit6aFAxWVhBZGxYdGhrb1ZlcGJ3eTd4V0VUUGs0aHNJTXFvWnlH?=
 =?utf-8?B?YVU1VDFNTFJOOUR4THRCVWIwUmdtdGRvY1k4QT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajRDN3p2cnYyQVFER0gzMXp2KzdkRkU2RXFUam9aQm5yZGdsSWY0L1VMYnZZ?=
 =?utf-8?B?TUQrMGFNNzFLTUh1Q3pTb2w3SnMyZVd2dDZoR3FNZHBYTXBmZmlIYmNxNWpv?=
 =?utf-8?B?dU1mNGU1bTdxa1RSaEJiblpqVGdzNmdNL2V3anVYajFsTjIra3pGNUZyL0FF?=
 =?utf-8?B?d01GWURxTXRlNjN5RjZPRm1teFZkeE9mVWZseDRvaEpxbXIvanNCaisvMkNN?=
 =?utf-8?B?QnJVcjVsOVBKc2FmNXZlMEp3Zis4b2lsY3FFL0dVeHM1UnpOKzZXSVZpRkpl?=
 =?utf-8?B?WlVveldSbTI3MHovNWdYQTFaeDI5dEVKNlk0emN1T0RoSm9BMkR4ZXNqcitE?=
 =?utf-8?B?S2VtLzRtYXIzdkhhMFo2TU5RLy9BYnE3cUxXcjJBMmFmWjlJQ25JWEFhUXFS?=
 =?utf-8?B?eTAxbzBQaWdSeVVGTk53L1VEcTR5SDF2R0JldHlqekRWNndDMDBVUDdYVm82?=
 =?utf-8?B?NmZVVHZNNHcra3ZwcVlOeVQ5eXJ1cU1tN2doRjg3NUR3NFMvUGMyU3U2aVFH?=
 =?utf-8?B?Y2hSNDFXNFBSSTlHZElzVm4xT1M3QjdiZWVrdDdrSDZJV0VqNFN2RFlIK3Rn?=
 =?utf-8?B?Yk13UHg2eEpBMnJVTUhmak5kZlVUSVR2Vy9yWURiQWlmRXgwU3IveXVmS25l?=
 =?utf-8?B?dytnMExyNnh4eDd4dVJHVnBuZlFKL1FTYmJ1aGZkNTN0YzBLY2dRYjYzOHhm?=
 =?utf-8?B?UTZieUxrU0xMK3hoTVVVd21WNGl2NVFwS2VkOUZMdTBKaTVDcW42bHpKcnI2?=
 =?utf-8?B?blpuempqc0FLZFE4ZkpTbmlxa285SGlRU3VCc0MzOUU3aUhhTTBFVE05UndD?=
 =?utf-8?B?NXVYQlJFc1N6UDV5WkE0anNIZVhSaDNSS2E4czRtZEtNTXhaRUEwV2ZPTlho?=
 =?utf-8?B?eXp6cFZsYzhpMW5oVHo2UU5BZDNLM2dwRjkxN3B5Tm9UWERBRHhFbCt4T0V6?=
 =?utf-8?B?NU5HQmkzdXNNTldtM3BCTDZzNmZQTGd3OGRhQnpPQmtGdmphQnVuaVNWbURF?=
 =?utf-8?B?RjVBMC9Td0VjMFYwTHpMRXVraVkrcVZhdDBmMHpoRW9TVCtYUVdQOWxmWnpv?=
 =?utf-8?B?cXRYMkcrb3ZueCtLeTR6c0t0Z2FENnVXdXhsalg5aGlRelBQWWRGMzdMa093?=
 =?utf-8?B?a3B0YkU3OVZFOFd4aUcwdnlEUUsxSmkyRkQ2aXllTjcyVVI1anRKY1pGL21h?=
 =?utf-8?B?QnduYndESkIzL2Z3dFhBcCs2b1BLOU1iUEtlb21RVjFvemRrWHUrY0JYbHNz?=
 =?utf-8?B?U3BkVVEwZEU1RytmcXhqWkFPR05XdWRjVmUveXFRdUltVlREcFNZY0kweUd6?=
 =?utf-8?B?STdHZ0xJanY5NTluM21RQnE5ZXFRbTJEVHFWcTBFRzJXZjB1RzdzZit6cEtH?=
 =?utf-8?B?dEw1UzJ2eExpSlE0Wkh2TElNbVpkd1ZqWGY2ckNwUDllQitVb1YzUkQ4bEw4?=
 =?utf-8?B?N2xDclVjblo4SXUvSDdBWmVpU0FTYlNnb3VjTGwwMkE4Vjhud1cwRGJxcElD?=
 =?utf-8?B?QU1mUHl4Y3B4ekdFMmJDQlp6aE1qYWU1Y2pRRlFTYW9sVUdacHRDeTRwRnVZ?=
 =?utf-8?B?NGpNeDh5Yi9YMGRZV00wZU1DSlQyWEMwM1gzVHUrRVRMQXZRWVRJYkhyeUIy?=
 =?utf-8?B?ekk1TlIvdW56Q0FOWTJnL2xpaG52Q241cDU2SDF5UEMvYisvQWxPQmVNelR0?=
 =?utf-8?B?Qzg1TkdJSk9FVWlUcHoveGNIK3V1WWZTSnd5a29VS3FZS0lCdHM5UTBwRXhX?=
 =?utf-8?B?cUhGTDFTRkEwbUxyS2Q4cjFRb29LbWJST2xhRlptZGd4TlFheEZIcFR1N2dw?=
 =?utf-8?B?V0RZdFBZaXZ1SHpaeFhMK2cyblNEemV1ZnZkMzg0OHg4OC9hZDFIYW9XNmlr?=
 =?utf-8?B?K25wajhEWFVwRkVuZUlIM2sxMlR1SDlpMk5QSVVseERSWk5SckpSU1B0TGVO?=
 =?utf-8?B?WmlQczdMd0Z3czdzVDdVbjcxY01JS29xM1JPVHZZeHJscmNuM0FTcm5wclBn?=
 =?utf-8?B?TkJPajlFVk9GSEU2eVpDeitieDBmMktoUWVlaWs3Tmg3YjBKQ3RJOFptUHhS?=
 =?utf-8?B?cUd0YmpCRWkxOG9TSDErTXNJNDRqUVR1SGRDM1JpcFZ4VkJKVVNudmY2eVho?=
 =?utf-8?B?MWpwT2RlVEpnNm50VFpTQkZMcVozQVdPbW9DK3ZicmVCNjVzZEtKaWltVmdy?=
 =?utf-8?B?c2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a43f79-0706-4d8a-a5c5-08de2269e8bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2025 04:05:40.4700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RValZFxjZWxXzoQgANVZ2pw6pnz+kf7XoUJRa2613CuTtLVwUwqlIuetyU+i75OSqKR7DQTfCCTD6EQRX+9QnzDD7l/oZVcHNymHdJxNY/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8263
X-OriginatorOrg: intel.com

T24gMTEvMTIvMjUsIFtSZXZpZXdlciBOYW1lXSB3cm90ZToNCj4gT24gMTEvMTIvMjUgMDE6MDAs
IEthdXNobGVuZHJhIEt1bWFyIHdyb3RlOg0KPiA+IEl0IHN1cHBvcnRzIHRoZSBzYW1lIEMtc3Rh
dGUgcmVzaWRlbmN5IGNvdW50ZXJzIGFzIEx1bmFybGFrZS5UaGlzIA0KPiA+IGVuYWJsZXMgbW9u
aXRvcmluZyBvZiBDMSwgQzYsIEM3IGNvcmUgc3RhdGVzIGFuZCBDMixDMyxDNixDMTAgcGFja2Fn
ZSANCj4gPiBzdGF0ZXMgcmVzaWRlbmN5IGNvdW50ZXJzIG9uIFBhbnRoZXJsYWtlIHBsYXRmb3Jt
cy4NCj4gDQo+IElzIHRoaXMgYWN0dWFsbHkgZG9jdW1lbnRlZD8gT3IgaXMgdGhlcmUganVzdCBh
IHNtb2tlLWZpbGxlZCByb29tIGF0IA0KPiBJbnRlbCBzb21ld2hlcmUgd2hlcmUgdGhpcyBpcyBk
ZWNpZGVkPw0KDQpHb29kIHBvaW50LiBCYXNlbGluZSBmb3IgUGFudGhlcmxha2UgaXMgTHVuYXJs
YWtlIHdpdGggcmVzcGVjdCB0byBDIHN0YXRlcy4gSXQgaXMgZG9jdW1lbnRlZCBpbiBpbnRlcm5h
bCBkb2N1bWVudHMuIFRoaXMgYXBwcm9hY2ggaXMgY29uc2lzdGVudCB3aXRoIHNpbWlsYXIgaW1w
bGVtZW50YXRpb25zIA0KdGhyb3VnaG91dCB0aGUga2VybmVsIGNvZGViYXNlIGZvciByZWxhdGVk
IENQVSBmYW1pbGllcy4NCg0KPiA+IEBAIC00MSw3ICs0MSw3IEBADQo+ID4gICAqCU1TUl9DT1JF
X0MxX1JFUzogQ09SRSBDMSBSZXNpZGVuY3kgQ291bnRlcg0KPiA+ICAgKgkJCSBwZXJmIGNvZGU6
IDB4MDANCj4gPiAgICoJCQkgQXZhaWxhYmxlIG1vZGVsOiBTTE0sQU1ULEdMTSxDTkwsSUNYLFRO
VCxBREwsUlBMDQo+ID4gLSAqCQkJCQkgIE1UTCxTUkYsR1JSLEFSTCxMTkwNCj4gPiArICoJCQkJ
CSAgTVRMLFNSRixHUlIsQVJMLExOTCxQVEwNCj4gDQo+IENvdWxkIHdlIGdldCByaWQgb2YgdGhl
c2UsIHBsZWFzZT8NCj4gDQo+IEZvbGtzIGNhbiAxMDAlIGZpZ3VyZSB0aGlzIG91dCBmcm9tIHRo
ZSBkYXRhIHN0cnVjdHVyZXMgdGhlbXNlbHZlcy4NCj4gVW5sZXNzIHRoZXJlJ3MgYSBjb21wZWxs
aW5nIHJlYXNvbiwgdGhpcyBpcyBwdXJlIGNodXJuLg0KDQpBZ3JlZWQuIFRoZXNlIGNvbW1lbnRz
IGFyZSBpbmRlZWQgcmVkdW5kYW50LiANCklmIHdlIGFsbCBhZ3JlZSwgSSdsbCByZW1vdmUgdGhv
c2UuDQoNCj4gPiBAQCAtNjUyLDYgKzY1Myw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgeDg2X2Nw
dV9pZCBpbnRlbF9jc3RhdGVzX21hdGNoW10gX19pbml0Y29uc3QgPSB7DQo+ID4gIAlYODZfTUFU
Q0hfVkZNKElOVEVMX0FSUk9XTEFLRV9ILAkmYWRsX2NzdGF0ZXMpLA0KPiA+ICAJWDg2X01BVENI
X1ZGTShJTlRFTF9BUlJPV0xBS0VfVSwJJmFkbF9jc3RhdGVzKSwNCj4gPiAgCVg4Nl9NQVRDSF9W
Rk0oSU5URUxfTFVOQVJMQUtFX00sCSZsbmxfY3N0YXRlcyksDQo+ID4gKwlYODZfTUFUQ0hfVkZN
KElOVEVMX1BBTlRIRVJMQUtFX0wsCSZsbmxfY3N0YXRlcyksDQo+ID4gIAl7IH0sDQo+ID4gIH07
DQo+ID4gIE1PRFVMRV9ERVZJQ0VfVEFCTEUoeDg2Y3B1LCBpbnRlbF9jc3RhdGVzX21hdGNoKTsN
Cj4gDQo+IEFsc28sIHdoeSAqY2FuJ3QqIHRoaXMganVzdCBiZSBlbnVtZXJhdGVkPw0KDQpDb3Vs
ZCB5b3UgY2xhcmlmeSB3aGF0IHlvdSBtZWFuIGJ5ICJlbnVtZXJhdGVkIj8gQXJlIHlvdSBzdWdn
ZXN0aW5nOg0KMS4gUnVudGltZSBkZXRlY3Rpb24gaW5zdGVhZCBvZiBzdGF0aWMgbWF0Y2hpbmc/
DQoyLiBBIGRpZmZlcmVudCBhcHByb2FjaCB0byBDUFUgbW9kZWwgbWF0Y2hpbmc/DQozLiBTb21l
dGhpbmcgZWxzZT8NCg0KVGhlIGN1cnJlbnQgYXBwcm9hY2ggZm9sbG93cyB0aGUgZXN0YWJsaXNo
ZWQgcGF0dGVybiBmb3Igb3RoZXIgSW50ZWwgDQpDUFUgbW9kZWxzIGluIHRoaXMgZHJpdmVyLiBJ
ZiB0aGVyZSdzIGEgcHJlZmVycmVkIGFsdGVybmF0aXZlIGFwcHJvYWNoLCANCkknbSBoYXBweSB0
byBpbXBsZW1lbnQgaXQuDQo=
