Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BEE1C862B;
	Thu, 10 Apr 2025 03:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744254764; cv=fail; b=Fa/DgBuAuFg5NiX1WY8IhHdwZu8eanTw3Mj7ZdsP2/TF6GVIokRrZkTeC2FLvcbU2Wc+Y5o+1Hog6W6J4UhJ2qXZI0HulPxJfH0U+4CBmnR3QxtRZQBlDJ2D6UcSzJd1QuyDa+Z3v1SIEeAcJaWq7a2g5DEY8CvbiaoPMnYEXno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744254764; c=relaxed/simple;
	bh=QaajO8tWofrABryGCM91V4X7itPMiDoUPjnOXs7ZMPs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U5iftN7CgyvgsIF4JY/mHGTZAoW2x5HtDpL+XCi7s7lY25PVzFNXn0P9o/0vW4HLdWSLkwQlI5nv4FXK0bTGXPLmvEcHp7CWTdBU5Xe6J5jlKm1xMtA9/zoqDoEHCD5RXSU/0nvHNDjULK+cC3eO4cgVuer5Rn/zE2M0JUBhsFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DyrQ2boL; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DyrQ2boL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744254762; x=1775790762;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=QaajO8tWofrABryGCM91V4X7itPMiDoUPjnOXs7ZMPs=;
  b=DyrQ2boLNfLN/oHjvvR28iRbImnBuFaZFGDCygcsuMen9J6UZPl6DAhk
   L1oWdb/y2+8fSBZYc8laZJy+UZdzRsDR5143gc9W6Mq8vF62dfQnpDeU5
   ahqhvGKg+w5WUWEquq4ggng955RxtNbVkzHt8df9eYu7qVKSR0uzzsUhZ
   Js4YfQR7zjhYRFQ8pdcIv1EqzEsi5nL6+bRE9ANRORwT17jHfzGmdQj35
   Y1kN0UibgNUPYQGJAK5IZNheJbn5Timm5R+L1ktX73+HJ2jbUYZgkzAXf
   RypfiB7UdGor6njujNgzjuCfkirBHlnPze2o6hf7AYoFxB1unBh84rDpN
   Q==;
X-CSE-ConnectionGUID: Qp6/5JvtQaKavzZ3sqmwXw==
X-CSE-MsgGUID: c/wDqjuESOOStVC1XHwFow==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="57124788"
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="57124788"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 20:12:41 -0700
X-CSE-ConnectionGUID: Xax/PqaARWeVwLwthNsTaw==
X-CSE-MsgGUID: Qd7VR+QzTiWEOX39XfynIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="151948562"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 20:12:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Apr 2025 20:12:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 9 Apr 2025 20:12:39 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 9 Apr 2025 20:12:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=La6BmsiDYlVtimd/42AX9GdenT70SBg7lOlwzPJ56PXmhu/NQyd+cWrqWoqCCixo+l6fJ0uABPvCQy7xZQ7SU2xdOWQoRQYOxsS3Rs8ZpbFgsV8zsV+PULVrKJN9zFECXUqsaVT68RC0LefRJiC6mbvEGI10c9K/Wsk3mZOiWTclhqSM/Yojbem+mn9y7LE8W9h/CuPvEALmlo92odjDlfqlx18Q/AFSXmMQacnhkB8OtEF0UOUSNnjPrnI+/AihXPfz0lhcj/NxYE4lPdKQunmjB3zW/mkz/HKo96IQsbWoNYOZzQTz6rTzbPNcenOlYHOb541/7XY3omCcwucaNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QaajO8tWofrABryGCM91V4X7itPMiDoUPjnOXs7ZMPs=;
 b=QcJA0eNI5VtdBD5B+D53OJvARwX+Y3h28duaEPH867T82FaiSrIx00/8cV5y2GX08FLbY7DsxiVAg8C4if9v5oD5YQhBbYvX9aP83o6H4UACBZNWEV8cLc+dGSxE8kkNNe/Kn1Aw/cAyoDBERyhNBaEz7yylpgZwqesJESRNuwmFDVupM2XtRY1Id5Br9iulyqEZhwSUZ5dYw9r4zJPMcb8LxQTO+3liMXuKJjQ9Tou7uFDgAvSDmOqwUXfArd3lFSGOlowuuvwY1BbcWl9WyRPFOhKwpLBnWPCLWFyZ359DoJSxx28zdIu9it6Z3SRsnrffQ2+PSvPxPyodiormqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by IA4PR11MB9106.namprd11.prod.outlook.com (2603:10b6:208:55f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Thu, 10 Apr
 2025 03:12:31 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf%6]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 03:12:31 +0000
From: "Wang, Weilin" <weilin.wang@intel.com>
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
	<jolsa@kernel.org>, "Hunter, Adrian" <adrian.hunter@intel.com>, Kan Liang
	<kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, Xu Yang
	<xu.yang_2@nxp.com>, John Garry <john.g.garry@oracle.com>, Howard Chu
	<howardchu95@gmail.com>, Levi Yun <yeoreum.yun@arm.com>, Dominique Martinet
	<asmadeus@codewreck.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 16/16] perf record: Retirement latency cleanup in
 evsel__config
Thread-Topic: [PATCH v4 16/16] perf record: Retirement latency cleanup in
 evsel__config
Thread-Index: AQHbqRY8GLbZ2NWmaUCgQrMLWgeDyLOcOg2g
Date: Thu, 10 Apr 2025 03:12:31 +0000
Message-ID: <CO6PR11MB5635677AA5BCAC3E65B1274BEEB72@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <20250409061043.700792-1-irogers@google.com>
 <20250409061043.700792-17-irogers@google.com>
In-Reply-To: <20250409061043.700792-17-irogers@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|IA4PR11MB9106:EE_
x-ms-office365-filtering-correlation-id: b45b9f14-a860-48af-b13b-08dd77dd886c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?NjRnM0t5SzJ0RnNKYlIzcHRvaEZVNWp2WnZWUU5rL1pkWkdVeWFVejRoMkFK?=
 =?utf-8?B?NzQrVUFpV2M4S3NNdWpqMVBjZ3k5TVY3czJNN3YrQ3dNL1Q4VUdONFFCd0Ni?=
 =?utf-8?B?bklWRDB5SjJFYTNTQ3BaUzJ5eTRFT2V4ZEpTRXlOV1YrNWR4dzZwRkQrdEZ4?=
 =?utf-8?B?U0RaeTNaU0FaTmQ5RC93anVkTjR3MGNFOHVQaGx4UnU0dWkzSDNMVWlHdTkx?=
 =?utf-8?B?dDB0OTVWckY1V2MwdHQ3cm92bDBZSmxmdkZDV3EyQjdCNGY3VjVjdVlLYk1j?=
 =?utf-8?B?RmlZbWtvL2QvN0YwK2NZY3h5ZkNJVkFRWktaWlk0S0tScjlybHpYY29kYU9k?=
 =?utf-8?B?NTI4SnpDc3FHT0RoWWllUEhObHQ1N1I2U0NDRE1DSjBvaXo1bzFNSXhMSVZ2?=
 =?utf-8?B?QUdpTGYzb3p1RndBbE8vWUVRTHprTkNYdnppcDFWUW9KZDZUZjV0R09RdDhK?=
 =?utf-8?B?aWF3dVZaTGZiL2gwV0tOTHRmelBrTzFiR1FDeFVFajM4c2FKTDdsUTIwaHFt?=
 =?utf-8?B?WXlLZk0xT3hiUkxramRmUW12akQzeDVsVFE5bldqNGFmWDlyTW9IcEVXazZI?=
 =?utf-8?B?aEN2U3h5M0RZUEs3aTV4Q01ZTXdSeTI3L0J4SnhoTktPQVdMa29PR2UyVUM2?=
 =?utf-8?B?TEwzWWYxakhDZUhjSkNGVG5jUWtrU0hOMEJGY0JCVHovK1drSkV6UHNWTTc0?=
 =?utf-8?B?MVo0OEQrTng4eEROOWNaODNLR05HanZBM0d4T1VMK0JnV0tVMERoYjhjWnRj?=
 =?utf-8?B?Z2FEalhPb1h1WmFFdm9kbk1PbmZQcEJvMW9iSDF6MUlvQ3JRdmhsYVFpTnpK?=
 =?utf-8?B?dGxSc3U4WEkycVdsL05YTE1qMDFISXgrSldHRW5BTm5HS1FFYjdpbnJTRmg4?=
 =?utf-8?B?ZUJ1dXo0c3V0R3AveEo5RGlQdG1DRHBHUGNmaFFGbXI0SHhCRjkwRmhqMm1w?=
 =?utf-8?B?ajRIUnN3NzRibTVRZkVCMFBoS3Uxb0RiVDBnU0hFdm1wQ2xQZjFENnJ6cEwv?=
 =?utf-8?B?cXFUOGlodk5xNUdGOElEaXN3dVV0dzlCSjdmUSs2dEZmcDdIeTlwdmNncWZO?=
 =?utf-8?B?ZEdjN1piOEVUdjNlVkgwcmw0VkNtVzc4ZmpzYzFlNmVhdVF1by92aURaeGd6?=
 =?utf-8?B?UE5MT1FJUXBzVXZ0S1RQRU8yM2pQOFFOTmlLcXViVk1tMEkzMGdOS3N1cEYy?=
 =?utf-8?B?dmNQbDU4T1JhVWQ0dDlTT1BmZHczR2cwRXpuOUU5aWM4Y3ptRk5aeDRqWnhm?=
 =?utf-8?B?cFZRTSt0KzNTTXlzR01xU0pPRGZaMFFIaWViUWdGZkJUejlVQzBKWktsNHJ1?=
 =?utf-8?B?UUltTkZQK2Y2aWxYS2Z5ajNFVkZmSFhDNFZCY2dOa0ZSSlB5WTFyZlBjZDFm?=
 =?utf-8?B?ZTVHOUIwME9wVzZYOGxvZGNIRG9Hc05wSUUvRExXMjhYM2RpMCtFakkvU3R6?=
 =?utf-8?B?TVFzS1MzZlNzSnBWTFRaOHY4L1psZzRBblhlMDB2YTVXNnFQUFJwQ3Z4SGJM?=
 =?utf-8?B?bkM0aUVVSlQ0Vml6NlcyNzJabURxQmxTbytrWVBjaVRvVE5PQTNwenNxQnRt?=
 =?utf-8?B?ZW9mb0ZoQUZlcy94L04vZ3YxdnRzMlROSHZOZnNUVTRLdkRvV25VMnNINi8w?=
 =?utf-8?B?NmhxcGNwbUd4bjNVVExZZkhjNWV3SkZ5TzA5eFVGZVRYdXlack9LemxtQnBS?=
 =?utf-8?B?cXdmZ3VHSm1HaXJ0MzN2ZStsM2NMbDlOci92R3FZQ0I4YWliMkdsSUoyUGov?=
 =?utf-8?B?azFkTzBnOXhYT24xTktkaFNWMGhLaVFYSS94MVVvQXBYcFBabE45U0Y2TzZG?=
 =?utf-8?B?WVZxaC9HUGpqRlBES2RTZVFPZ2kxM2FJc1lOL0pGYXZuYTl1R1MyeDJEVmZ1?=
 =?utf-8?B?WGJ5R2xUL3NXV2pkMUt6MW9nWXUxMWQ4MzB3QWs4OUc3KzVmdjlhRlowZkhB?=
 =?utf-8?B?d0tPeGJjOW91UDBWYXdOaFphL0d2MW52Q3QzSUhybU9zcjArdGZuUDJEME42?=
 =?utf-8?Q?kyv1rNbQ0Mjy0fQQ+YevJNVe4wpHCY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QlpJbFp0VUtjU3JORmlFYmFETHl1L2xablMvcUM5d1UwbHZJcDZzU095NnF6?=
 =?utf-8?B?TllXQXBPM2ptOXVuQi9QV2FpbjdtUmllaU1OTGJrRkRWM2JPR1c5Q0U5TXFI?=
 =?utf-8?B?amRBZll2L3pqc3NHQjVYcVNjNFFmQnRTNDNZU2YxaThEMnVBYkpwV1JPRjJ1?=
 =?utf-8?B?cDk2TTNKRzdOVmI0WXNmY24yMlBrbzdmNm93V3doZFo3VnE4Ny91ZGtlWCt4?=
 =?utf-8?B?TEhRRjNDd3NOODhDR1ZrWGpoS1BuWFg5VWNXeUV5anpFUlgvSWVBNTF1Wmw3?=
 =?utf-8?B?ZXZIOUFudEJOTTNRWUdPTnVrQVVONm0zaVFjellLVGtpenI4dDd3U3NMOTBp?=
 =?utf-8?B?Tko2bWozNGJLRXMrWlBxNnR4UXY3ZWlTcTRQTnhjNEVqSXlNZEY2NlJBWDBx?=
 =?utf-8?B?ajJlMjFDVDRveEIyNkhwQ0FLMjhwK3ZqL3pYVlk0WVhVcHVPdHpBS3pYUDRw?=
 =?utf-8?B?SmpMNUdHMWVOc3YzMnNTcnNobzF2dkhyb1NCSWhNTmhNVFJ4b1ZZeGlwUzRN?=
 =?utf-8?B?TGVPUW5sWER0WE5aTDBPKzhBWWdObERzM1pYL0laSWtHMVZxU3QxaTBIMzlp?=
 =?utf-8?B?WHBwQW12SU5GeWY2ZVI1VnNERWFXMWRBRTVzQVg2dmJhNlJCNXJVT3llZHRQ?=
 =?utf-8?B?cWgxMmZqTytKUms3VjZOZEhCN2ZWSEtJb2p6dkgreTNwQWlyUFRwdnUzMk85?=
 =?utf-8?B?aWhqRTA1N0ZpV3ljRE5nakltaFVON1UwOGd3VWloVVEzZWI3b05IQmRzK3ZJ?=
 =?utf-8?B?MytjTmJydkxMaFlMbUVOWE5vU0pPRjNza2l5OTJNWGRTRFYrQzVlZU9JK3FB?=
 =?utf-8?B?dXRVMDhiTjV2SFhHMHo1bllNYklIRmUrcEUwVkFWUHVqR2JNKzQxQ0x3NXNo?=
 =?utf-8?B?ZDl1aERHWCs1QUpoNDZGN2lPSHlSTlRjQkpIOG9tV2ZyaUdmaklsV1ppYTFQ?=
 =?utf-8?B?MVlvZm5pN3RjbnIxY2R6UnA2UjRTc2gwcHBlaEdUODBmek9kWGkrcXEzWW5t?=
 =?utf-8?B?MlFMWmxyaFBxcWczWXhpYzdSalVaOURaOWZxVDlQUE9Ock1jcFFraGdXcTVn?=
 =?utf-8?B?YmNuNWJFNmlZOXdPZktnZ2grTHFIM05NYkVNZUpVTDhPSTNINjNEUkFzQVBj?=
 =?utf-8?B?TVhCbmtqSUFQV0xYQVFSRlJMZ3EyQ3k3enl1Q0tySld2N2J3OUViT25kRjhU?=
 =?utf-8?B?eDh1YjlYVUM1dldrYmFpR1h6U3AraW9FeHE5aHVoVVhGbW10M3NVblJOdERH?=
 =?utf-8?B?cVgzTW8ySnI4M3RoQ1JxcmRNWGtwZ1hBWXZaZEtRbXE2dkhYZGl4WkFMb0NM?=
 =?utf-8?B?RHdoSHc0SGFKMGFmWU1tMURGcEEyM0pubTJWSDgxbTJ4WVdMcXBBT3hraHY3?=
 =?utf-8?B?clFVQ2oxZTA2dzV6elVmOW9TZ1BmeUlyYVoxMUdXMEQvaVp5aE84ZzNnSks3?=
 =?utf-8?B?QTNHaG9pQjZvUUJDaFMrMEpib3drUzZOQ3lpdGRXY3VtK1FDNm9lOHdVMUV6?=
 =?utf-8?B?RGgxRUQwUkh3RHJMSDE1bXpzVkVKQjd4cW1iazA4azNMRDhBL2J2L2FCUU5T?=
 =?utf-8?B?YWNQWlJ2RUNhU09OWXZxY1dTUVUzeWhTME1jcXFHVy9VVWtaWldGWjBTWXNL?=
 =?utf-8?B?aHJXQkpUNDdKb0xWWGo5ckk4V0FHdlNSZit5ODMzdTdPaHdHaVBpTkxKRmE3?=
 =?utf-8?B?QnhEczFsR2RzbXZzeHhXSU5IV1RTTTdWSnFWM2tld2dxVFc5WjVxb0t1ejIr?=
 =?utf-8?B?RlFkazlhV2tablFnYnJzZ1ZYYUhKQ2ptSHByVVh2ZUNQQTNuQU56Zm15ZVd5?=
 =?utf-8?B?Q09mUzJwL0JYNU43Q2g2UU9TOW1jSWdZWHdrZjIvTWtPK3YyblNJRmRNZlBR?=
 =?utf-8?B?U3ZFd2NLTGtpQmRuQjFnenJURXdUellBS3BTUFY4MlJwenJQUzhWU0FkOEdH?=
 =?utf-8?B?aGNYR3F5SWg3ZzlvRU9nbVByYTRKWEtlWCtsZmdlcVBBN29FVU5YYTVBQlU0?=
 =?utf-8?B?R21jQVlpQy9UaEJ4dXR3QUNzbm5CYUtVa1hmd0paczFyejNMa2hMOUd3ZnpG?=
 =?utf-8?B?UzUrSzE5bTgvUTVGS0IzTllST0RLSVR0eG9xOTB4cFB1dzhDOWVYZWw3MkVN?=
 =?utf-8?Q?NQcdxRf+Mj5hzot/tAfVusn6T?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5635.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b45b9f14-a860-48af-b13b-08dd77dd886c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2025 03:12:31.6379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NqxGnn7r7oeJDX+KBSM+WeSIYihM3dA2TRoyw0LJmO/igxjao6SzfjwX325pkynE4XFls72D+p3ktRkxgbTF3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9106
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSWFuIFJvZ2VycyA8aXJv
Z2Vyc0Bnb29nbGUuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBBcHJpbCA4LCAyMDI1IDExOjExIFBN
DQo+IFRvOiBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+OyBJbmdvIE1vbG5h
ciA8bWluZ29AcmVkaGF0LmNvbT47DQo+IEFybmFsZG8gQ2FydmFsaG8gZGUgTWVsbyA8YWNtZUBr
ZXJuZWwub3JnPjsgTmFtaHl1bmcgS2ltDQo+IDxuYW1oeXVuZ0BrZXJuZWwub3JnPjsgTWFyayBS
dXRsYW5kIDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT47DQo+IEFsZXhhbmRlciBTaGlzaGtpbiA8YWxl
eGFuZGVyLnNoaXNoa2luQGxpbnV4LmludGVsLmNvbT47IEppcmkgT2xzYQ0KPiA8am9sc2FAa2Vy
bmVsLm9yZz47IElhbiBSb2dlcnMgPGlyb2dlcnNAZ29vZ2xlLmNvbT47IEh1bnRlciwgQWRyaWFu
DQo+IDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT47IEthbiBMaWFuZyA8a2FuLmxpYW5nQGxpbnV4
LmludGVsLmNvbT47IFdhbmcsDQo+IFdlaWxpbiA8d2VpbGluLndhbmdAaW50ZWwuY29tPjsgSmFt
ZXMgQ2xhcmsgPGphbWVzLmNsYXJrQGxpbmFyby5vcmc+OyBYdQ0KPiBZYW5nIDx4dS55YW5nXzJA
bnhwLmNvbT47IEpvaG4gR2FycnkgPGpvaG4uZy5nYXJyeUBvcmFjbGUuY29tPjsgSG93YXJkDQo+
IENodSA8aG93YXJkY2h1OTVAZ21haWwuY29tPjsgTGV2aSBZdW4gPHllb3JldW0ueXVuQGFybS5j
b20+Ow0KPiBEb21pbmlxdWUgTWFydGluZXQgPGFzbWFkZXVzQGNvZGV3cmVjay5vcmc+OyBsaW51
eC1wZXJmLQ0KPiB1c2Vyc0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmcNCj4gU3ViamVjdDogW1BBVENIIHY0IDE2LzE2XSBwZXJmIHJlY29yZDogUmV0aXJlbWVu
dCBsYXRlbmN5IGNsZWFudXAgaW4NCj4gZXZzZWxfX2NvbmZpZw0KPiANCj4gUGVyZiByZWNvcmQg
d2lsbCBmYWlsIHdpdGggcmV0aXJlbWVudCBsYXRlbmN5IGV2ZW50cyBhcyB0aGUgb3Blbg0KPiBk
b2Vzbid0IGRvIGEgcGVyZl9ldmVudF9vcGVuIHN5c3RlbSBjYWxsLiBVc2UgZXZzZWxfX2NvbmZp
ZyB0byBzZXQgdXANCj4gc3VjaCBldmVudHMgZm9yIHJlY29yZGluZyBieSByZW1vdmluZyB0aGUg
ZmxhZyBhbmQgZW5hYmxpbmcgc2FtcGxlDQo+IHdlaWdodHMgLSB0aGUgc2FtcGxlIHdlaWdodHMg
Y29udGFpbmluZyB0aGUgcmV0aXJlbWVudCBsYXRlbmN5Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
SWFuIFJvZ2VycyA8aXJvZ2Vyc0Bnb29nbGUuY29tPg0KVGVzdGVkLWJ5OiBXZWlsaW4gV2FuZyA8
d2VpbGluLndhbmdAaW50ZWwuY29tPg0KDQo+IC0tLQ0KPiAgdG9vbHMvcGVyZi91dGlsL2V2c2Vs
LmMgfCA1ICsrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYvdXRpbC9ldnNlbC5jIGIvdG9v
bHMvcGVyZi91dGlsL2V2c2VsLmMNCj4gaW5kZXggNjYxYTA3Y2JkYjI1Li42YTg0ODkzZTNjNTgg
MTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL3BlcmYvdXRpbC9ldnNlbC5jDQo+ICsrKyBiL3Rvb2xzL3Bl
cmYvdXRpbC9ldnNlbC5jDQo+IEBAIC0xNDQwLDkgKzE0NDAsMTAgQEAgdm9pZCBldnNlbF9fY29u
ZmlnKHN0cnVjdCBldnNlbCAqZXZzZWwsIHN0cnVjdA0KPiByZWNvcmRfb3B0cyAqb3B0cywNCj4g
IAkJYXR0ci0+YnJhbmNoX3NhbXBsZV90eXBlID0gb3B0cy0+YnJhbmNoX3N0YWNrOw0KPiAgCX0N
Cj4gDQo+IC0JaWYgKG9wdHMtPnNhbXBsZV93ZWlnaHQpDQo+ICsJaWYgKG9wdHMtPnNhbXBsZV93
ZWlnaHQgfHwgZXZzZWwtPnJldGlyZV9sYXQpIHsNCj4gIAkJYXJjaF9ldnNlbF9fc2V0X3NhbXBs
ZV93ZWlnaHQoZXZzZWwpOw0KPiAtDQo+ICsJCWV2c2VsLT5yZXRpcmVfbGF0ID0gZmFsc2U7DQo+
ICsJfQ0KPiAgCWF0dHItPnRhc2sgICAgID0gdHJhY2s7DQo+ICAJYXR0ci0+bW1hcCAgICAgPSB0
cmFjazsNCj4gIAlhdHRyLT5tbWFwMiAgICA9IHRyYWNrICYmICFwZXJmX21pc3NpbmdfZmVhdHVy
ZXMubW1hcDI7DQo+IC0tDQo+IDIuNDkuMC41MDQuZzNiY2VhMzZhODMtZ29vZw0KDQo=
