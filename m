Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB8713AA5F;
	Wed, 25 Sep 2024 21:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727300422; cv=fail; b=WhxfmKluLMUgVcR+Yhi87/gy8/OZxjMDLVWEyYXoKqYhwk97gAtpLVHhcauJizCrPuHwULv3hyVTxtNEtVQTmNEUsoGubRhQPqb6/s4oOtQnnruGqkyq4xiqP8ShSWlBMfbC/urI27vEXNtoXags+ccH1oR+GKoXVltsNj3LTVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727300422; c=relaxed/simple;
	bh=v5B8yH4jvPb5V2Eq7k9z4yLSM5b8E6kJc/XAfLoKcDg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pyrXMKBMXqztjRLMvJAi6tuQIA0M2TgbAj8Q5cDq3/S1lAlykkp5ps+JNHhu2eUzzNvwuS3W0kzE4N9DPq8+pIyOwRRLBcUFAGEVLTjI9c2jcalBu+dBeAPH5NXcHxNpo67vEAbD2cDx0Sl7JB0dtcgf43kfucXMMjRRk08MgW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ImDNqYgT; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ImDNqYgT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727300421; x=1758836421;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=v5B8yH4jvPb5V2Eq7k9z4yLSM5b8E6kJc/XAfLoKcDg=;
  b=ImDNqYgT8lVW0nE93Oije82OZ5iv5D99kZlASbzHuRm/i71sOfWqRCZy
   rfBmJ/X0/DmLHYMKsDNdUbJP4rAdoShJ+sySBy7LJFzgEPQ/wu30qfZEq
   JovlY6I732rHLSu35nVSuotfVXWST5Dq/EuMoRq59Xeqx8Xyp1R6/3fZw
   8VBYkyJlsmXc+lmkKJyUvvJ7m2DT+4PIG3w7jERT9sXLzoyHOcqWRf3Rx
   vqwei3xYrF2thHcR7wXW7pNtwmTMBv8UdYj1BzotfbQHViZ3psSnCfga2
   QwVUcEEsGwRpByMscbsM3ZcN76Ijpct7rMTyPMvPvjCPFLhwyWmdujNuB
   Q==;
X-CSE-ConnectionGUID: XePjk1+rSQuzD1rHEdFo/g==
X-CSE-MsgGUID: /MZKnjLdTBKvkeJctd8oCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="26185390"
X-IronPort-AV: E=Sophos;i="6.10,258,1719903600"; 
   d="scan'208";a="26185390"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 14:40:20 -0700
X-CSE-ConnectionGUID: U/FpgFLeToO1PbkqtqNL9Q==
X-CSE-MsgGUID: wQQet/WNQjG8sdpAjIGSaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,258,1719903600"; 
   d="scan'208";a="76420579"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2024 14:40:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 14:40:19 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 25 Sep 2024 14:40:19 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 25 Sep 2024 14:40:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQ/nZAiZVXuzEonsTmeJJ1TYGm7PFO0Wjw0wnaGDUPcIG+TiyqQCGnK691Jh55W3ElJbes/8l62AJ9pEIGNFcRyTig8FMrWxpm9xZ1PbFozY93ZQsiLsRt4smpcCdWOYn/68Pj/a7acBfhGQtCU7LBp2WUtdRT1s7ecDrakLixkOsYbqtwo+TZ+zsMO0fxoZr0eVfA4JyLBzmhVGDIoiRyBocOw1Q/gWhXnbcmsicQXcoWsJgT24dFaiHhC6XjUqFLWSQQID375DL0EJnSw2gY56evNROqOwxhRkPb5awhhYVbaF6DG7ubGVFOm6osA/iAlToAss71wYduS/PKr1DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5B8yH4jvPb5V2Eq7k9z4yLSM5b8E6kJc/XAfLoKcDg=;
 b=Szqr8IcApMT3/ZU+E9FQAB9pFTn0c4R2pAIjwdJLy12PbUVFAEpBkWUVhOG/Dl1FoQ2n4or5TwlgqbknYBnrHpPvFC4JNcLinto/9qSuWKLJoFjrmc3bCqr7VMA86Tcm1wan0ug3lWnnBA6ocfqE4iwxG9Hzk2I9JHdCZHD7LyyNf+vU4A+Mnesc/OSPrRzDplpyJNezL0mj3u/lwZ9qcibwvp8bbkh5pE+o8K6UekOOifrB1GkLzxKeSCr5JAi++EnqNvmhNvnCzX31LxeTcBWpSZpO0zE5+1+sK/5yrepP23TgFJcEOh+3/LyLVr3s0a2Dg00So7Gqh3+k/8E2ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3398.namprd11.prod.outlook.com (2603:10b6:a03:19::19)
 by MW6PR11MB8368.namprd11.prod.outlook.com (2603:10b6:303:246::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Wed, 25 Sep
 2024 21:40:15 +0000
Received: from BYAPR11MB3398.namprd11.prod.outlook.com
 ([fe80::8165:d375:7a90:9f5c]) by BYAPR11MB3398.namprd11.prod.outlook.com
 ([fe80::8165:d375:7a90:9f5c%4]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 21:40:15 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"leo.yan@arm.com" <leo.yan@arm.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "acme@kernel.org" <acme@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"namhyung@kernel.org" <namhyung@kernel.org>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
	"irogers@google.com" <irogers@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH] perf mem: Fix printing PERF_MEM_LVLNUM_{L2_MHB|MSC}
Thread-Topic: [PATCH] perf mem: Fix printing PERF_MEM_LVLNUM_{L2_MHB|MSC}
Thread-Index: AQHbD3ntzCBQ9S+zvEyWT3KsZttXKrJo8MEAgAAXTQA=
Date: Wed, 25 Sep 2024 21:40:15 +0000
Message-ID: <3bb83817d36128426cafa31b6cd5863be89f1ea0.camel@intel.com>
References: <20240925183633.49653-1-thomas.falcon@intel.com>
	 <6d409278-988b-4c09-adfb-5e075c9b326e@arm.com>
In-Reply-To: <6d409278-988b-4c09-adfb-5e075c9b326e@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3398:EE_|MW6PR11MB8368:EE_
x-ms-office365-filtering-correlation-id: 1f10b1f0-11fd-4910-2f0d-08dcddaaa4b5
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TExiZlppRnkraFAyUkRMeGc4QXlQQmkxem90RWdDajdHVENvbGMvOGxZWTZZ?=
 =?utf-8?B?YmZFMTNVK2hncTdOZ2wvM2QxY3RWOThpamNIRkxNM0FZOFhsRXlvaW90bVdj?=
 =?utf-8?B?ZWs3UHFpYkRmS0RxQlpOUEw5K2o3emlleTFWcXluY2tQK09xdGU4V0x0NDFO?=
 =?utf-8?B?TU83T0NqWWdRSUJhbi9WY1NBbkQ2VElvS0FUMm9kUi9PRE0xU01ZNGxqMnFW?=
 =?utf-8?B?Yi9McUtIcFl0ZStPcTRQWm1hQlowOVZMcGNkNVFlbHhNSjkzSEdtZUVyY1RZ?=
 =?utf-8?B?NmJjcnB6RjhTeitCeW9WcXRYanFhNWQvSk13T0lLWEZoRXo3bHFLSUl1djN6?=
 =?utf-8?B?S3EySGRHaHYzWVBGcWdzR3pQVVZBUDQvM2VMN1o4QUkvVmppbzlWNHl2Y2lO?=
 =?utf-8?B?bjdIbS9nOTk4VDNKeE4yS1J0ekt5QXNIZHBjYTVlQ0hIZTZ0bUN0dWlURmw2?=
 =?utf-8?B?U1hIV0V2NTJpellpRHQ4R1VMUFQ3WFNmRTE3YUVQeVdDcDE3NDBsUkhTT0ty?=
 =?utf-8?B?VmcvUVhTVzdtV2g0RlhzMFJZTmtnNEFXM28vQUJUdzEyN2FBUE9CSk9TRWhB?=
 =?utf-8?B?SDE0R21jY0w1OXRBK3RsWUp6TXE5c21GWVJlMUluM2ZIbzdOZ1JpbVVPUDBE?=
 =?utf-8?B?aFNBWkZyZ3hLSE1XcFZBRzZmdTh1R0tDZkJya240MnQrY1gyY2U5aEUxLzRM?=
 =?utf-8?B?NzJQT1Z1ZXh0YUI1RFUrQmlRd2Q3OCtQWjFmQU4rZGxZVXpEOStZTzFRNEpa?=
 =?utf-8?B?bkFEM0ViTnRxY3pOOHFRcmQyQzBwTjNBbGZSRGlWVFJNSkoyenZZMDdTdVNa?=
 =?utf-8?B?a2owUGlDR2JocFNIZVcxQ3U2WHgzbEpKQ1dDQUQ5Y3JFdDlCeHl4Tm0wRDVL?=
 =?utf-8?B?eThybHVic2FTV2Iva1FBdHhuOXJIMGtRcFEzUlhuTDNlVDAyQVN4aDFHYlQ4?=
 =?utf-8?B?Zk5yb25jaG5WZDU4eFpmRWhnWWx2SzM2QUdscmRHa1BpWkZOaWVYczVveWlw?=
 =?utf-8?B?MUJpNENBdGlLaFJvd3J4bkhSZ0NJcXI4Slg5OVUyNTIzcDdmQWQrMEd2Tm9a?=
 =?utf-8?B?aEVzS2k4RC9VMXdKQWpvZytkTHF6M2FjKzV4cXcvOUFzUnd5aVR6K2pkL0Ra?=
 =?utf-8?B?UGw4NUh4M3RaWlVqZDIxdlBCY1NDMnVnQUhjQjRacGdNNUdydE52SmNuN1Mx?=
 =?utf-8?B?WWlJbFc2RUlOYW9CR1lOWk1DU3gwMTJld2RaRHhsVkJwcHpSU0xzRTFaalFQ?=
 =?utf-8?B?MVBkU3U0SlUwNDcwWldhRmd0ditzK2NZcHdqb2dkaEJkYXU3VmdMWjNKcHlp?=
 =?utf-8?B?UVFkQ1JBZTFsUzVIU3dEaGV0Zzk3azFIODNjb1ZwSjFqdVR0V1VBWFlpTnB2?=
 =?utf-8?B?bGlMWE5Kamx5aGwzdVorQWFxc3lMelhvMi9TcGR3V2M2NVY5aW84cWFUTmNu?=
 =?utf-8?B?MHc5bGcxbEh6ZFozS1dPbkxrQmZDa1o3SjNxK1BWb3BvRlRORGF3ZFRRc0Vz?=
 =?utf-8?B?dXpzMjRtam9FdXJweERvSTcvVlVMN3lqajV2VGRYTWF1cFl0SkZ0UGgwVWpm?=
 =?utf-8?B?eGorOWNGRFZwbnNJSmlUM2s1QUg0Z2NGQy95cGJvMlRaU3R3Qk0rR1dLdTB2?=
 =?utf-8?B?Z2hNekNOVHBUNERESWJmakR1MUUzVFJMR3NYZ3VQRVVxS2ZIakI0d0lUSktP?=
 =?utf-8?B?ZVdYNm5FTUJjWS9jcEFyc2JXRXBGM01SdzhERlVzblJma3J6YkoxWHozRDlI?=
 =?utf-8?B?VzdJQmdpV2JxUnU1QzlFcm1JNjA3andVOFp6N0lpRG5BeW9UZDg2Zk5sVDJL?=
 =?utf-8?Q?JDYlmBVmRYQEF09qAEyTAd9dKgtoFURM/uXMw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3398.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUtlamcxbkZuK3RXWVF4cGN0ZDNFemk4dUcwNmVvbklVSUFQV1dob1VOSmV5?=
 =?utf-8?B?L3MrczJsODZBMmxTekpQK1BsUkxyT1VLTGhRcVhMcGE4MktLN2Fac3hoamtv?=
 =?utf-8?B?NnRHdzE0OGtHNmNSMWpkYVRva3FVR2ZNSHJXSVMxV1kzSWxvenFEQVRRVWhq?=
 =?utf-8?B?cTEyWE1sMzE1MXRXRXFKcjRoYWJ5ei8zNHdEaWdocWRpb0pyakQ1NW5ib2pN?=
 =?utf-8?B?TXJiYXpMSHFhWWVISlM0ay9tN3FVcVF0R2NhZkQyV1hoTThFOFFJMHRjM1JK?=
 =?utf-8?B?R2lPTmdjRjZWcGdyK0s3aDUwcUNiL0JlUFA1aGRkSjJJOWpvV3lFTml4SGFu?=
 =?utf-8?B?cFRYbGFBakdNMlZxWDVtQkdJYzFnc3JEVVBaR2RaV3B1SWN5aS9rSVE4RHlw?=
 =?utf-8?B?RGdPMUpoa0ZKSzNYbHBTeUJJZjJzOWQ4YWtyTTVsMG90K2lBbi9tUHlwa0RW?=
 =?utf-8?B?aGpvL3h5cTByek9HR1dMS3c0SXVEQ0F2V2c5c2s4Z09kVy8yc2RzSTJHNlM2?=
 =?utf-8?B?My9YVGVBUjlnMlI0dXdZWHNOaWN3eE1udFd0RDNsZlNUTnhPRmZFdi9uZ3lu?=
 =?utf-8?B?eGdZRkZXNU54UmY0Zk9FWGd1YVJseU5NS3RrNzBuMjR2Y1VZMGJyaEk4d3Vi?=
 =?utf-8?B?TThnUERDekFVMEtHTmFMRXgrZE1VbVQ1Ry9RQXRueERkL0d4WVJxa3pRdDAx?=
 =?utf-8?B?Y3dac28vV093RVBETGRidjRHdVZEaGdMYzhhR04ycVlkUUZtOTV0NzRmTEdC?=
 =?utf-8?B?eWJkNDFEcGlIUVBuZ0ROaktoUlQ5U0k5cDdxZ1VickVnRm1LaEU3ZURRRE1Q?=
 =?utf-8?B?WHc2MlFFelYvbmdGbisxcnhxVW1JOVhGcFdZYzhLZFQ3SEQ0ZUtqckZla1Jm?=
 =?utf-8?B?N3ZIVUlCMDY5cU5QQWhma3pCZUFBWFNPM2hrcThySWJCOHlkSmc5SjlCQkFM?=
 =?utf-8?B?VGNKY1BvM0pFYURhN2k1ZTVrQWRBcElnK0plUDg4SERheU5MWW9SL1VUdTdX?=
 =?utf-8?B?ZU92VmNYTmFpZ2VDWlRjU1ZycWJJK2tRNy9iWldTWk1MejZJc3NKN1FiUjZp?=
 =?utf-8?B?L1dNakllc1lkc0ZFVzJJZ0JpUVRvSThWRTNpcUtLR1ZraGhVOGEyOHljTGI3?=
 =?utf-8?B?TnNmV2wrVnUzQ04yeEtpT1B4V0ZoTmh3Mk10VjhHTUx5WFJZNUpTR0xKajkx?=
 =?utf-8?B?RXNtRG11VDlweWsrcWtqNWNjNm5wbWpCV09Gd2hnQzV2Zmd0cG9HK3JPeldJ?=
 =?utf-8?B?RTlxbGNTekhQaVVlTTR1QWJIT01QZy9GdVFRWXp0MHlCSVJjSkFkMmRYc2RD?=
 =?utf-8?B?dlNwWFI3VlE4aVFadmM1MGtTQi9QdVBXSTNGWnIrbEVoSnBXSlV1V2lid2Qy?=
 =?utf-8?B?elV3eXVtMkhHWjVDZk5xNVk5U1BsR2plMlFqS3NvZGk2bDRHQzhRbE1ZUlZW?=
 =?utf-8?B?bk5WK0pKTER5djNDK0tTcWZJV3o1S05VQjJQWDR2RnQ0aUVEaTMxNEV3S2tI?=
 =?utf-8?B?akorbTBHOUlDK2tHZzlsOFp2Q2JPdmVGVnVDVytONmtKSGxIOE1VZTFJVEJj?=
 =?utf-8?B?eVBXdXRuRnVONStUYUQydDRuVUQrRk12K2tHNlB6cEpLczQrRXRRZU9aK1Jt?=
 =?utf-8?B?YnNGZ20wcVZPN21wUzZJMUEvd1FNVXBNK1I2RHQvMCt3cmhCYzZWWHByTTRo?=
 =?utf-8?B?V09ZdWZtcXl6OWtBWjQ2SjBtVjdOa2lwMm9pM0psL3pIYW83amxvQk0yRFZW?=
 =?utf-8?B?QVpsLyt6VTdlcWFDbFRscExuaU1OM3lPY0dsWnJxUGl1ZUptNDNCNnB5Z0pG?=
 =?utf-8?B?V3U1YWwwT0RlVXN5ay96Ky9LMFdzdjl2WDRBRXhLUGZRS2FsUW85RHg4ZFAr?=
 =?utf-8?B?bE5veWs5ZUZsQTRTVFcvNXNaeTc5blV6M3hqbVQ5MTczMGsxcEE5Yk9pazhh?=
 =?utf-8?B?Q0JlRkd6Vlo1STI3TGNyUE9HQVlRTDdWRGt5dmNTQ0xKRS9EZTFXaE5kcThM?=
 =?utf-8?B?RlppeElnNVFqWjNrYWxTK3lFbXExUkc4SWhudTBHemdZenRXdnRNcyszbm40?=
 =?utf-8?B?Mm9XVy9tUXIyRUV0ZklQc3VhZDREZTRsbVhDWXlyMXhwU3ZXNHJ6YmkvY0g2?=
 =?utf-8?B?ZHlhSE9OUkdoaGQxekR2K2pUMEZDaDVpSDdqOGkwSzlSWDhVSWExc0xXdlNr?=
 =?utf-8?B?U3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D64422C6ED8A99489819F22926166188@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3398.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f10b1f0-11fd-4910-2f0d-08dcddaaa4b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 21:40:15.7016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JpxcELzk517+Mn61QXAfCIGSwrkieKMJ4jswcb8WImz/5AvhhcpcvWSuLmheMX7N9UdaI30GjNidZ+RTUwF4mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8368
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTA5LTI1IGF0IDIxOjE2ICswMTAwLCBMZW8gWWFuIHdyb3RlOg0KPiBPbiA5
LzI1LzIwMjQgNzozNiBQTSwgVGhvbWFzIEZhbGNvbiB3cm90ZToNCj4gPiANCj4gPiANCj4gPiBX
aXRoIGNvbW1pdCA4ZWM5NDk3ZDNlZjM0ICgidG9vbHMvaW5jbHVkZTogU3luYyB1YXBpL2xpbnV4
L3BlcmYuaA0KPiA+IHdpdGggdGhlIGtlcm5lbCBzb3VyY2VzIiksICdwZXJmIG1lbSByZXBvcnQn
IGdpdmVzIGFuIGluY29ycmVjdA0KPiA+IG1lbW9yeQ0KPiA+IGFjY2VzcyBzdHJpbmcuDQo+ID4g
Li4uDQo+ID4gMC4wMiXCoMKgIDHCoMKgwqDCoMKgwqAgMzY0NMKgwqDCoCBMNSBoaXTCoCBbLl0g
MHgwMDAwMDAwMDAwMDA5YjBlwqAgbWxjwqDCoMKgwqAgWy5dDQo+ID4gMHgwMDAwN2ZjZTQzZjU5
NDgwDQo+ID4gLi4uDQo+ID4gDQo+ID4gVGhpcyBvY2N1cnMgYmVjYXVzZSwgaWYgbm8gZW50cnkg
ZXhpc3RzIGluIG1lbV9sdmxudW0sDQo+ID4gcGVyZl9tZW1fX2x2bF9zY25wcmludGYNCj4gPiB3
aWxsIGRlZmF1bHQgdG8gJ0wlZCwgbHZsJywgd2hpY2ggaW4gdGhpcyBjYXNlIGZvcg0KPiA+IFBF
UkZfTUVNX0xWTE5VTV9MMl9NSEIgaXMgMHgwNS4NCj4gPiBBZGQgZW50cmllcyBmb3IgUEVSRl9N
RU1fTFZMTlVNX0wyX01IQiBhbmQgUEVSRl9NRU1fTFZMTlVNX01TQyB0bw0KPiA+IG1lbV9sdmxu
dW0sDQo+ID4gc28gdGhhdCB0aGUgY29ycmVjdCBzdHJpbmdzIGFyZSBwcmludGVkLg0KPiA+IC4u
Lg0KPiA+IDAuMDIlwqDCoCAxwqDCoMKgwqDCoMKgIDM2NDTCoMKgwqAgTDIgTUhCIGhpdMKgwqDC
oMKgwqAgWy5dIDB4MDAwMDAwMDAwMDAwOWIwZcKgDQo+ID4gbWxjwqDCoMKgwqAgWy5dIDB4MDAw
MDdmY2U0M2Y1OTQ4MA0KPiA+IC4uLg0KPiA+IA0KPiA+IEZpeGVzOiA4ZWM5NDk3ZDNlZjM0ICgi
dG9vbHMvaW5jbHVkZTogU3luYyB1YXBpL2xpbnV4L3BlcmYuaCB3aXRoDQo+ID4gdGhlIGtlcm5l
bCBzb3VyY2VzIikNCj4gPiBTdWdnZXN0ZWQtYnk6IEthbiBMaWFuZyA8a2FuLmxpYW5nQGxpbnV4
LmludGVsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBUaG9tYXMgRmFsY29uIDx0aG9tYXMuZmFs
Y29uQGludGVsLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogS2FuIExpYW5nIDxrYW4ubGlhbmdAbGlu
dXguaW50ZWwuY29tPg0KPiANCj4gVGhpcyBjaGFuZ2UgaXMgZmluZSBmb3IgbWUuIEJ1dCBmb3Ig
bGF0ZXIgYXZvaWQgc2FtZSBpc3N1ZXMsIEkgd291bGQNCj4gbGlrZSB0bw0KPiBpbXByb3ZlIGEg
Yml0Og0KPiANCj4gc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCBtZW1fbHZsbnVtW10gPSB7DQo+
IMKgwqDCoMKgwqDCoCBbUEVSRl9NRU1fTFZMTlVNX0wxXSA9ICJMMSIsDQo+IMKgwqDCoMKgwqDC
oCBbUEVSRl9NRU1fTFZMTlVNX0wyXSA9ICJMMiIsDQo+IMKgwqDCoMKgwqDCoCBbUEVSRl9NRU1f
TFZMTlVNX0wzXSA9ICJMMyIsDQo+IMKgwqDCoMKgwqDCoCBbUEVSRl9NRU1fTFZMTlVNX0w0XSA9
ICJMNCIsDQo+IMKgwqDCoMKgwqDCoCBbUEVSRl9NRU1fTFZMTlVNX0wyX01IQl0gPSAiTDIgTUhC
IiwNCj4gwqDCoMKgwqDCoMKgIFtQRVJGX01FTV9MVkxOVU1fTVNDXSA9ICJNZW1vcnktc2lkZSBD
YWNoZSIsDQo+IMKgwqDCoMKgwqDCoCAuLi4NCj4gfTsNCj4gDQo+IFRoZW4gaW4gdGhlIGZ1bmN0
aW9uIHBlcmZfbWVtX19sdmxfc2NucHJpbnRmKCkgOg0KPiANCj4gwqDCoCBpZiAobWVtX2x2bG51
bVtsdmxdKQ0KPiDCoMKgwqDCoMKgwqAgbCArPSBzY25wcmludGYob3V0ICsgbCwgc3ogLSBsLCBt
ZW1fbHZsbnVtW2x2bF0pOw0KPiDCoMKgIGVsc2UNCj4gwqDCoMKgwqDCoMKgIGwgKz0gc2NucHJp
bnRmKG91dCArIGwsIHN6IC0gbCwgIlVua25vd24gbGV2ZWwgJWQiLCBsdmwpOw0KPiANCj4gVGhp
cyBjYW4gaGVscCB1cyBlYXNpbHkgdG8gY2F0Y2ggdW5leHBlY3RlZCBtZW1vcnkgbGV2ZWwuDQo+
IA0KDQpUaGFuayB5b3UhIEkgd2lsbCBzZW5kIGFuIHVwZGF0ZWQgdjIgd2l0aCB5b3VyIHN1Z2dl
c3RlZCBjaGFuZ2VzLiANCg0KVG9tDQoNCj4gVGhhbmtzLA0KPiBMZW8NCj4gDQo+ID4gLS0tDQo+
ID4gwqB0b29scy9wZXJmL3V0aWwvbWVtLWV2ZW50cy5jIHwgMiArKw0KPiA+IMKgMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS90b29scy9wZXJm
L3V0aWwvbWVtLWV2ZW50cy5jIGIvdG9vbHMvcGVyZi91dGlsL21lbS0NCj4gPiBldmVudHMuYw0K
PiA+IGluZGV4IDA1MWZlYjkzZWQ4ZC4uYzYzMGFjYTViZDkzIDEwMDY0NA0KPiA+IC0tLSBhL3Rv
b2xzL3BlcmYvdXRpbC9tZW0tZXZlbnRzLmMNCj4gPiArKysgYi90b29scy9wZXJmL3V0aWwvbWVt
LWV2ZW50cy5jDQo+ID4gQEAgLTM2Niw2ICszNjYsOCBAQCBzdGF0aWMgY29uc3QgY2hhciAqIGNv
bnN0IG1lbV9sdmxbXSA9IHsNCj4gPiDCoH07DQo+ID4gDQo+ID4gwqBzdGF0aWMgY29uc3QgY2hh
ciAqIGNvbnN0IG1lbV9sdmxudW1bXSA9IHsNCj4gPiArwqDCoMKgwqDCoMKgIFtQRVJGX01FTV9M
VkxOVU1fTDJfTUhCXSA9ICJMMiBNSEIiLA0KPiA+ICvCoMKgwqDCoMKgwqAgW1BFUkZfTUVNX0xW
TE5VTV9NU0NdID0gIk1lbW9yeS1zaWRlIENhY2hlIiwNCj4gPiDCoMKgwqDCoMKgwqDCoCBbUEVS
Rl9NRU1fTFZMTlVNX1VOQ10gPSAiVW5jYWNoZWQiLA0KPiA+IMKgwqDCoMKgwqDCoMKgIFtQRVJG
X01FTV9MVkxOVU1fQ1hMXSA9ICJDWEwiLA0KPiA+IMKgwqDCoMKgwqDCoMKgIFtQRVJGX01FTV9M
VkxOVU1fSU9dID0gIkkvTyIsDQo+ID4gLS0NCj4gPiAyLjQ2LjANCj4gPiANCj4gPiANCg0K
