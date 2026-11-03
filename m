Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793721439;
	b=PMbQlKt2ciVUKHiWdtW2Wj8H3kTSmCA3snkWSUv5dDPKgfSOELyBZ3ZAQyEWYT3DdXWk
	 CUcO/dxetIMnkOASTvFLNGwNsBWpk/D9Nwy7GgbfoWffa0o2ahQ2RhUsWg4hCRLWhdGJf
	 pSP8c2LDJh0LstQUHi6HcUYslOqtDLm0GotS64F5HErwzdtIhAxKa0HKscttfTf4ldGqO
	 yqit02FF+AddjikRWJyvZVXlTfnbgYoHDtkMy20DzJ9cd7wApwLjo3QG3QqYIAeQcVTLC
	 hJERFbAmzOn1Rt63zIEO7v+jAOtQHhFrMsN9fvVQCIV90FQcTtHx0feFaTzz/BOZ22A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793721439;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:Content-Language:From:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=i0A9KSWoOZsf8OWZd4sqaUZ/PRztEH5iU2/62BfXFyA=;
	b=ZfJSSrjMCtAw62gycl8ZCKU7JfwXrf9HdAFzyPHEem15VpEDpl/X+ERUWGH5H2AoLmpT
	 DRFT+3UIlA4wxs55Prsr5aCbHwMKUrWib/xO1/xMIJJM2SkMC1p0GoVMHoqZtRyCelCYL
	 H9B6NuktfuUESxeHX0hXKtN3q4XsPWbz8noKGcA16bD8FDXkfwMX1fp+HsoKItJOq6DVF
	 kVo5LhFsvO9abEG2aWs5eVg9mNA/cGaD2/lQ2Ay6agp5HhVt8lpc8OsxVww0DpDUPCyYC
	 roPIXSxYAdz7mOXWIMhibS6Thz33DLk3p59zbJ0hZLG/F6rHjoI3DumGVapGwJHXnvA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kI0UQMfK;
	arc=fail smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A48D606D802
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 15:57:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A48D606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kI0UQMfK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793721438; x=1825257438;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8avGu3lZzC8t9ZdGwKfgpMGBzO3oawNxzIiXhJf2z5g=;
  b=kI0UQMfKulxit1LnS228TdcvFRNbJ1BHR5lqbbXn8hYTXEbDN2MoPAaf
   OqVBcRmpsV4eS/BcXUXtsYgHeMm++hNJnQRZHSclepzVDbcHoSJ90dob5
   +ueVgT/QZbWrPh8VEiiXL5hZvsZYkY1W8A4hywwU+lMucYv3fSCI7ogqj
   iz618V6qTKrTQv5TeJEfkyFywG4wpx/z2N3+Ht/kfCyhEs5B/S97wgaUH
   G2YgNMj7ID8gGBpFMB/jvBCy3wFz9ySsOuUFnCqUPBd/bCucJtHua2szF
   LsZrPfpqeRx0CeTHxpNTD8nBoFVDfGC1dXdp6XaK6i1ryBE4s8Rdqyjg6
   g==;
X-CSE-ConnectionGUID: HNTzlgRgROC8p0iE9pALGQ==
X-CSE-MsgGUID: Yue4nm1VQEyTgxqvKDID7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2331212"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2331212"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 07:57:17 -0800
X-CSE-ConnectionGUID: HJPnvOCmQGmqoXfalbrZYg==
X-CSE-MsgGUID: 42ymj0aISfSyy37Fqx9jBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6295642"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 07:57:17 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 07:57:16 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 3 Nov 2026 07:57:16 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.16) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 07:57:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PHD2giKT+hpf2Mqlh5W/npPnISl7tDj7BSF35TixsV+ORf1Qj9uVcmwEz1Jc4mg+dg66MyOBMu/S0XEEQZ4TwmpSgt3TLdv7j7Kdwz1wd9NpLWP9oe8o3iHWGcDaoL7hoeP/+4MgyiMuTAyx7WDqZ945URIv+WH3ByPYtGYNncQBjHMvs576kxjslyNX7LTip1Ibpgmj0znyXlFseswLas0VxTePVyS6Oa7yeaL1gAK3q13QL79u5BJX9qYtN/kx7dgSaK4AolpRt862zKhdTe62x8OtCR8HRx8N24tMHWfh9XB95pYaXTrVFj/XR1kA7Cl+INI5sCa1XPmc1Z4pQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0A9KSWoOZsf8OWZd4sqaUZ/PRztEH5iU2/62BfXFyA=;
 b=oAHZdWnCDh1Ln4T/O6iLvIm01atKbWIqgkfy6P167bkFV8zoCz22Rp1ijxoz8jh2P33AM8NViUjss20/g7+0A6n3ITxcJveTq0vTqSuGAI3taJeEBr+Evt6j4u4ddUXYFY7djRwjaSin40LOrVFNpZ45ebTcxuE4Bgv8+ylccffnPV94nN2tJm3ICAaFo5MCxGsRj0DffEkMEbELzn/4Hoy5iDLO4/oHnhPOCpN64PVdC2lUlO/mQQAks5wjnOs0tJaItwk+cQg7BKwJMxFovtQzO2qxM5EaD7VZFJZn9soEBD7ugLTt7dU8jfaOO1Q2BMf0gIayYm0c81yOElOBbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DS6PR11MB610166.namprd11.prod.outlook.com (2603:10b6:8:469::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 15:57:15 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 15:57:15 +0000
Message-ID: <1cb49f46-9453-4ea2-adb1-e78575837d09@intel.com>
Date: Tue, 3 Nov 2026 17:57:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] perf/x86/intel/pt: Stop tracing across system suspend
To: <sashiko-reviews@lists.linux.dev>
CC: <linux-perf-users@vger.kernel.org>
References: <20261102074039.26983-1-adrian.hunter@intel.com>
 <20261102074039.26983-7-adrian.hunter@intel.com>
 <sashiko-outbox-193146@kernel.org>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <sashiko-outbox-193146@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU7P191CA0025.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:54e::9) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DS6PR11MB610166:EE_
X-MS-Office365-Filtering-Correlation-Id: eafeedd2-b698-4d6a-e6f2-08df39c3212f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|4143699003|11063799006|56012099006|261022075727099003|261102123227099003|261021121427099003|261022105027099003|261028144727099003|261026140227099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: w2Xo4pgoEGss8lkDJi9Z2Ea+MTSWKWfvzfzlNBguFyqgVuwt++RtCvKvHo19t02XODTRVnXXRCTSu69F7aXUkJ4P6ONQr9ZPAAEPKzRyEjjV8S3uFY5TLk0cBVByN4HHK6I6SjdE7iSimdnm3Jpzl/B2Zmk+sqsAGhV+fcD4O+NHIlyEZubZ6JGlSedirq5iZup00YjzogrVdsuEt6vg/OD6ZX7HO0DSolHtCC4VR6CVZNFpwC70LOc64LlGMvHZoQNZN1GfmGUMS+kWMQMR9A51pySlnMk5oag3ObA2naS27mwYrRUrLAX+++gR1VaZmYdA7u9tRk+MS+9BKuwAJdp7wrSEWWQbAaXDQjIQMBJt/CQB0k+9l4W9b6hr+cPcLgEfd2AbVYKzKma7FrvkZhBjBmGs2gJJpwUhnwvlklzzkqWIXuweCuVhWbmKyrAH23zF3Qq3Ab6Rf7reg2MtSVl2ucDusspwAo4r+nU7Tr9e583xnlML0nK1+/gkytMREWXuSiCyimm6jbObrohPlqukr9gGy3DDTGjhzocI7ZQjzb47bin6NPb/+3nVRa6ia8VSisKmV/y/qvbfWIClHPKn4wn3rHRUja31JqCCsvMr4+Yp5b8vIcjeZ3ZO7SQSzIZLqh/Cbj4jGX89zCSKSScEntUqm7yHtZrZtqgA10Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(4143699003)(11063799006)(56012099006)(261022075727099003)(261102123227099003)(261021121427099003)(261022105027099003)(261028144727099003)(261026140227099003)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlRtV2FhNGh4dlVVeXExZFRIM0xBSDRxYjJDUFlYOFR6WklRZmc5Q3Q2dURP?=
 =?utf-8?B?dCtCRysybTNTOGNSVTdiblE3NHVoTWxVaTVVeGxKTUR6K1pqSEFIdzF2QVNE?=
 =?utf-8?B?ODF0UW9OY0MyMm9aYmluUVZqZlJVRmZlOVVnV1pyMjAvZjltR2hsVDhkOFVJ?=
 =?utf-8?B?MEwxZWRaaU1PVSt1eWR0NHZqSW1jQ1JhZ1FOSkMyKzZmbk8vVlpYK2creWtt?=
 =?utf-8?B?eVlyQzZKaVNheVdGNDR0R0dpaGF0b2h0OXR5b09wY1VBTFNZbzRrazdGSUNa?=
 =?utf-8?B?SUNIMEVyRWNia3lrQ2gxanFZcmFnSzkraU1FSEhBRDZJNHJKaEZrZUFkeVg2?=
 =?utf-8?B?djQyMFlyOWNJb1NUZnRHWG40Y200WHo0ZW5XQUdqYVdFLzdiS21Oa05RQmRG?=
 =?utf-8?B?SmFLK2hzWXNaeVZuRDJzM1VWWW5DWHhyWjhHbU1NYTV5eEdvdTV5ZUVHc2Zr?=
 =?utf-8?B?SWVSM1ViTnRvVDRWQkJzMC9JV1N6dExLMWJlSk5CZzRTMDFBaVVRYlRZUHRJ?=
 =?utf-8?B?TnZuTmpqUUFHWjhLbXcyVWJVazc2aHF3N1psUHU5aHVTTkMyNDBXN1ZHSlpC?=
 =?utf-8?B?OTNkeng2b3B1SmhCYzl0b2h3aU50MWlnL1dseXM2K3N5M3ltN1pmbnZ2MndF?=
 =?utf-8?B?Kzd1RExSRk1qM1d3N3l5SU9EZmFxWjA2V3RyM2xNTHhwcTJsYnd3UWREV1gy?=
 =?utf-8?B?cHB2aDhPR0lmamlLNzVlaUhFM2RPajN4VXlhc2NiUEtTb2JleWZUNXd2aE1m?=
 =?utf-8?B?cVc4VXR0SnhOSHpLVnpWRmJlNnhPTzNoNm1Pam12aVd5NXRYNisvdzdZOTdY?=
 =?utf-8?B?MWxFWUoyblVwMUJMaDRZK3drQVBVb0ZTUWV6cFVyazkyaDBxMGZkeDh3U3pQ?=
 =?utf-8?B?S0I2V3FaWHpaeFpoUndNekIrdlEzdE1zTkpUSXNsQm1mWVVKaEZJS0ZIV0Jq?=
 =?utf-8?B?akZkZkVFd05PZTdscnJnTkNtdGxuRDJoUzdWTnpwZi9YbkJwM21CMUNNVFpZ?=
 =?utf-8?B?Y3NkZnBQSy9paVJwNGJvMm0wS2NhSElKNlEzdlJsWHg3aEt0ZnZhVVV6eG4x?=
 =?utf-8?B?S1JPM0Y1Nm5yVTFlM1B6cFVjalJtZEl5L1NNMWdvSzBvWEcvL2N0VUFweGhJ?=
 =?utf-8?B?eElmRG9GQkdlSTAvM0twVTBFMTVjZC8zUGR1eFVIcHk2YjZna2tudjNKMnZJ?=
 =?utf-8?B?bElXZW5uekdwQVJSVm9XWG1iYkpzSGFSay9GYm80UlZNTG9lcmpobUo0K2pr?=
 =?utf-8?B?ZmhiUFdjYkNOQWh3YldwYVVobzU1dUtWRk9wQW95eWM4NGJ4YlBtaEtlQjFP?=
 =?utf-8?B?TlBNdTRieStRRkhzN0lyZCtaTExvanJEbWNCZng5eUtscXBqdERxbHk2NnRH?=
 =?utf-8?B?eDNDSCtUS29iYVBZcGtmZmJ6c3RSRFFIdzZ6TTdLbEcyNmNYRXh0TEVWcjVv?=
 =?utf-8?B?THBvdmtkUG1QTlBOZ3F2dXg1NlZDdUNzNVI4dnU2dTAxNVdmL1VLQkIyb0Ra?=
 =?utf-8?B?d1pFbmdJYnJuL1VOd3UzTGpjOWJNWlVENUpVQ3dpZ3NXS01nTEx1c3ZzUzVm?=
 =?utf-8?B?dEtGNkp0dDhZMEtKMnN0VGxOL2FUZVN2VnFUU2FtYXhOL0t3ZDVzUXQyd09O?=
 =?utf-8?B?Y2dYamZ6VnQ0MXFTVXBQdVhZc0NvalhFTzJsc0NKQUpEL25aYnlsQmlISEE2?=
 =?utf-8?B?am9ZVGl6WjFYT2tnQk5LdXRaMUU4elZUc0JIS1YvTS9DMFBIdlpzWFpjVGh1?=
 =?utf-8?B?RUZCR1djUEtUOXN0QzFPNHE3ZUNnVEN5QWV5S2twOEVtRjhtYkZWRVFpRDBu?=
 =?utf-8?B?NEJmcFZ4M3B3d2tqdFhuSS9QV1lLcVZ4SGpoZTU1TTY5V1E4djlpVEVzd1k4?=
 =?utf-8?B?Q2FQUjZRZDh4eFFGbU1hNWtLakpNN1AxMnlUTWdrM253S1JPMThlVllCYnZV?=
 =?utf-8?B?Y2xnSEFQNFh0c3BWbHdWNWlnQVQrbjR0MHlJaWxXVzQrbXBWLyt4WXM0OThQ?=
 =?utf-8?B?YVk0SE4rWk83eWJuOC9DcTk0SGYrNVZHNjNFM2pkZHU4eVRLV0ZuMGpxVFo4?=
 =?utf-8?B?c1l6YXpDTW9NaXo0YnQ4VEhDR3hOcjhZMmdSNTI1a2hFOFd2TUNTdFdPd3Mr?=
 =?utf-8?B?S2p5ZFN0akhqYWpqbWc3djZhZ2VTMnd6VEtDcmRPblVNQjhTb2N3Uk5hdG43?=
 =?utf-8?B?Y1MzdkorVDU3RC9mbnJRSGlkckVpOFVyeEtqdUgydnk4RG8rM2Z3aEFWLy9T?=
 =?utf-8?B?WmQ0Z2lNaUV3Q3FQcEhENHJOZXE0OVVXTVFWQUR2UCs1bjZKc1pjaFJNUkpU?=
 =?utf-8?B?NHBKcCtDOFpwSlMrVkVXTUlKYzZjbW9hemF2c0NmQmZqWVB4T0I5Zz09?=
X-Exchange-RoutingPolicyChecked: lPpTiqInzsufBIdtspv0F80i178HCou1ltsAyRzirV328AvygSTucADPJBOF/lNZpujBAP55JNyRm/M1RsWJztlDY5oA3mzDDjG07ADkmRWXlqsv+WfJ9FDtK8bhGZ2Lp+TYOniinUkKGZKtModUZNU4d4MUPEPwe2/LzBkpcszpfM/Sx2lDNCEa+4AGGNp6btS1j5OPKC94sNpl9tYhe/XDoV5349LK0kTkaA4AsEouBZ3xHeWJsRgU65E5SAfc8IN6v/WM1nvKvz5y370eUOj+1vSX8PenjHgqXoqLaruAJE8T2EiIoc4kvJgojNIcc9zKc9OZZ7Ie3fkjRzJuNA==
X-MS-Exchange-CrossTenant-Network-Message-Id: eafeedd2-b698-4d6a-e6f2-08df39c3212f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 15:57:15.0773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8gYZzkWNnQP+frUibQOd5a4q+G167Rd1PS+HpdW5JUGYPW/oargd7cLpxAcE/zTC3v4gvi7xV/EVw1MZbsgFlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB610166
X-OriginatorOrg: intel.com

On 02/11/2026 10:59, sashiko-bot@kernel.org wrote:
> Can pt_syscore_resume() prematurely restart an Intel PT event that has been
> throttled by perf_event_throttle(), leading to a duplicate pt_event_start()
> call when the event is unthrottled on the next timer tick?

 Yes, the duplicate start can happen

> Also, if pt_syscore_resume() skips calling pt_event_start() when the event is
> throttled, wouldn't clearing pt_suspended_event in pt_syscore_resume() before
> perf_event_unthrottle() later calls pt_event_start() cause a throttled
> snapshot event to read reset PT MSRs in pt_read_offset() and take the
> pt_config_enable() path without reprogramming the output MSRs?

Right, so keep the restart and make the redundant start a no-op
instead.  An event with both PERF_HES_UPTODATE and PERF_HES_STOPPED
clear is already running.

 	if (!(hwc->state & PERF_HES_UPTODATE)) {
+		/* Already running, e.g. restarted by pt_syscore_resume() */
+		if (!(hwc->state & PERF_HES_STOPPED))
+			return;
	hwc->state &= ~PERF_HES_STOPPED;

One side effect remains. A throttled PT event restarted on resume
traces until the next tick while its sibling is still throttled.
That lasts at most one tick and is harmless.

