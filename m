Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0900A3FFD;
	Mon, 20 Oct 2025 01:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760923180; cv=fail; b=OHtpjq3w7v8zymEhfw7bHCxjPy/gzL5FY2A7GQKPFHyk62ygSek4Wep+NBRgv8MacEgyJknNW7GBe/zxRLhJ5ULJq6+5DP3XA44fDJKwPUOTQBvsYxv7OITTgP6U7Y85+2dr6WLxiuwmxsytG8B+J0+00aZz4K9U1gZsnllb+KI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760923180; c=relaxed/simple;
	bh=vGbVpxqM9xCAB6ERDfaczamxVV3YN0tOSFieKTQvWtA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uiFIzm0p4ASNRsy/39xR0CoAKJy4C0sW0BJxbVtBPC3igZigefjb/w0xzHuVG9NRbOHNZGT4kEu4+5I+CQG+ipS3Sag8lGMwpFpM7WX9lUfQ2HEURaBXsyuvdyw5BzTnEvZyZu5E3nxOm4HlYuBYePFX6XuoYNHBaSH429XwYSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NOEZzMLW; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NOEZzMLW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760923178; x=1792459178;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vGbVpxqM9xCAB6ERDfaczamxVV3YN0tOSFieKTQvWtA=;
  b=NOEZzMLWWrazqewNtl7vecNdRJBXMcQHkQxegqh+mtdDJ9KqBS2O7/3e
   l+NIFv7lvKtUObV8e/RZrFQLFo+eKrHZo4u5cjZ2w3DukSzNePno4fyQM
   gATwlo3sEr0jsfjy/oUC2SGeRQdby3vRz6iYawqYMKYTGfgcldgbeoIlv
   qKGGchQg8+TUmCAhCycQ6G1/Jlaeclrahkq1AF762j8XvyXaExg63i62n
   Y0iC7mq7BeadoavH9+taWEfMa4vfn1dzoAGf1E7P33Hfd1dU+MnAsH0Bh
   L8L7wi1BC6Is5yxka7nuN0rnDbAZyQDhozMoN4hFrHIcO57KaCKzoRGye
   Q==;
X-CSE-ConnectionGUID: LBA8zdH/QZuSoR3AKR6i2Q==
X-CSE-MsgGUID: N/DXVYgJScqGCPnMdkjjvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11587"; a="80483260"
X-IronPort-AV: E=Sophos;i="6.19,241,1754982000"; 
   d="scan'208";a="80483260"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 18:19:38 -0700
X-CSE-ConnectionGUID: PIBtFUmgRn+it6hisDUA0A==
X-CSE-MsgGUID: lOaYPBl9REGckgDMPRS4Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,241,1754982000"; 
   d="scan'208";a="182761431"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 18:19:37 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 19 Oct 2025 18:19:36 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 19 Oct 2025 18:19:36 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.2) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 19 Oct 2025 18:19:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bIW0LeiKGVCdSVlxius3iUC9kK9DMC+ds7vHJoGGqmBKLAVlbhawCSVXDht7Wm/K7ZNzKp0BqCCXzLGJRtzFdV4lJEhswvFJ9sQpL54rjX4y7qCeD9JnYj+RNgCaeAC/W/gbhqukb+BBL7qcU5oCt1G4Rm+gUACwKxIqSwjihBZI8uDHi8weIoNMMiRzW6U7/R1z3jpY1WtqAfRqD6Dz/ds/VcERUNPVCFFPdgoYXnYF2L0uBs93rnle74gLI+d54B9Kgkoty5SbRrQw9WkobSmss8lVrO990MJxu+BzizuuKxmG/XKcghBkmyz+rddfuqPRM0OfFMB48wknF4oHNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWwbwEMSjTw6YMuwPF00UvUfuNeCdIVCuDca2XUN1Cs=;
 b=PfB8/xv7dZCqJrOJgq3S7TaOBySlqb6DHY61XC6NeGveDcAy50rYaxnjcxmAho8kofJg8dYUIV8jN724HsWabTAdamiU2AQTsot77WAyDXjPj6Yb0WTia3fB8D9WOoxHgAaeXCp4/3eMHqPNu5H6YxR9+xmyQGKiNkBltfOruKggXGKTv879Lc31/T5qHct9KOP3ILokiZdWpJf57AgUStHYpmydPFv8d3PhIWDnRixT6yP6i8O9StUSW9WDrAHmVYO6+X2Z6YHCxHBd56Sde09sYuBJzUE+CT71eOj64pc8ZaRRe27W5DbauVoWZ4qgAc86+wNdI00Xl9IM9Gg1wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB8289.namprd11.prod.outlook.com (2603:10b6:303:1e8::9)
 by IA0PR11MB8303.namprd11.prod.outlook.com (2603:10b6:208:487::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 01:19:32 +0000
Received: from MW4PR11MB8289.namprd11.prod.outlook.com
 ([fe80::d626:a4f8:c029:5022]) by MW4PR11MB8289.namprd11.prod.outlook.com
 ([fe80::d626:a4f8:c029:5022%6]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 01:19:32 +0000
Message-ID: <ef5862c3-4a42-4b2a-a2ec-625e0c9806e9@intel.com>
Date: Mon, 20 Oct 2025 09:19:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf tools annotate: fix a crash when annotate the
 same symbol with 's' and 'T'
To: Namhyung Kim <namhyung@kernel.org>
CC: James Clark <james.clark@linaro.org>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Arnaldo Carvalho de
 Melo" <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	"Kan Liang" <kan.liang@linux.intel.com>, Ravi Bangoria
	<ravi.bangoria@amd.com>, <wangyang.guo@intel.com>, <pan.deng@intel.com>,
	<zhiguo.zhou@intel.com>, <jiebin.sun@intel.com>, <thomas.falcon@intel.com>,
	<dapeng1.mi@intel.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <baea1e93-5e30-404e-8a5d-8b1d20cf8761@linaro.org>
 <20251015172017.2115213-1-tianyou.li@intel.com>
 <4151e2e4-b7df-4c04-b038-71ff2612ee8d@linaro.org>
 <db33a977-c712-48b7-9be1-83721b23635f@intel.com>
 <046f1441-bc18-44e0-9bd0-f98a62ebbf9b@linaro.org>
 <9f843a5b-4fa1-4abf-9c4b-1e5433ab9704@intel.com>
 <9f33a736-ad3f-426c-93db-b5acca34e5f1@linaro.org>
 <9dd7ecce-dd4f-47a1-a7ad-bb48da8c21f2@intel.com>
 <aPRbfdU92XRLR-2N@google.com>
Content-Language: en-US
From: "Li, Tianyou" <tianyou.li@intel.com>
In-Reply-To: <aPRbfdU92XRLR-2N@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0035.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::13) To MW4PR11MB8289.namprd11.prod.outlook.com
 (2603:10b6:303:1e8::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB8289:EE_|IA0PR11MB8303:EE_
X-MS-Office365-Filtering-Correlation-Id: 971d2f93-9b89-4997-80b0-08de0f76b949
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dE1TZEE0SHl0MkZoNXZCWTFKTnYrVWFia01RNGh2YmQ4R2FGTDF2TUhNdWNa?=
 =?utf-8?B?M3VNUnNHcTVyQTlmeFQyUmRGRXd0WTNTdWxSY3h2Zk96RWNDZUJJaGsybVhR?=
 =?utf-8?B?Qnh3d0daN1NsZWlvdlV2TCs5YkExVFlUdndkOEdGU1VBUDY0OHROMzliaXd2?=
 =?utf-8?B?eVFGVitSSVVOWTh3NXdGcmlFOUYrcVBuQjM2QklJM05mYVBBdGRWcFBGUCtU?=
 =?utf-8?B?bXRZQUU4R2NXQVF6ZHhQUW95cXFtcUx4TjBLbm1IeTBYdlJCVzQyV3EzYzNx?=
 =?utf-8?B?TjA1WGxzc2Y3VnUwRHoyRjJYRWs5OXRVWkdYS1FzUko4WGtDUEtyeWFjNzNW?=
 =?utf-8?B?S1NBenBzbExJYmd1eTJ5Vmt0cHRIRGFCTC93U2lhR1VKM0Q2dGgwZ3d1MTd1?=
 =?utf-8?B?L0tYTnNrcGthMDcwc0s0NmVVblRyOFlSVEVaOGZUY0UwSHlqMXhDemErL0dl?=
 =?utf-8?B?OHpWUm9oQmYxWGRvQjFobnNSSEczOEFOWHFHMU9IUmYzWDN5Zjk5SlFLejBF?=
 =?utf-8?B?REcydVp5aC91YzhVaDFpbUdiVWhmZ016MUxhZVdBZHllL1Z3bURwVi92ZGlj?=
 =?utf-8?B?SUhzK0RnVnFwSUNoVm5hcWVzS1VUYk15QitaL3QzTHhYcEgvNFVoem92WVlV?=
 =?utf-8?B?QVVqNjVndXRUaVZwWWdsU1RxRVpaeDR4VTlmYnl5YjZlV0FkdGZhUkRwNGw2?=
 =?utf-8?B?eGhUd0xYbFRjY1dBR082Zy80MEY2RkMyTXhTSlpFTXNtdXdDSHQ1N3B1ZzZ6?=
 =?utf-8?B?Q3JWL1plTDVZa3k5VWxadktKYUM5eWdENlFiQWUwV0lWQUpvbUp2K1k0WXhX?=
 =?utf-8?B?ZlBqbC8yVVk1ZjkxRlJQbTFQY1cvOFBQRWd0ZzR2UGxoZlpRQzY2VGJnVHdJ?=
 =?utf-8?B?L00wSUhiZWxIZ0RRVzdINzBVN3YyUklPem81KzR6QTNtT0NWRDhHT0E5ckxZ?=
 =?utf-8?B?aUlSYzdKdXFneXB1cC9haGhqY2Vka0N3SFlJN1psUFpiUTRSTm1yaWlxT0p5?=
 =?utf-8?B?NWpIczRwMXRwVWwvejBlSENkWGdvLzF6UGhMdFp3eS9YNTdPOU1pUXJHb3U0?=
 =?utf-8?B?eVVUQkZSYU9hcEtBV2FCanpOTnpleXZvYXFMN2dnT0cxY1ZUL2ZIbU5rR003?=
 =?utf-8?B?dHJiMnpOM0dhT2U2cTd5cG1sSTZEVFNlNmlmTHFGemRpWVhoUXVUY0J3akdI?=
 =?utf-8?B?d0xYRlJ1Mm1YaFdpQU9KR25JekVqaDVoYXQ2YmFHb2l3NTBORXVsZkJXTm5Q?=
 =?utf-8?B?Ty83Ymx2ekhxL1R3TUs3bkxGTkJqMDMybWZUNHI4a3BLZnVMMUFkY1BXYy9I?=
 =?utf-8?B?eXl6elZDRERXTEE3cWxmUDE2WHk4czlOQmhtSElvd3ZjUndzVUM5Yk92U0Zp?=
 =?utf-8?B?OG4vS2lEcXdpanptbVB6d0doZlF0eE1lU1YrZkZRS1JjV3BhS0xKY0NTR3lm?=
 =?utf-8?B?M3NmMndId1BhTTU3a213TzFPbk5iTTI4cTNLOE1VNEV3WnhSVFZPYVpxNS9K?=
 =?utf-8?B?V092RDhZdFFkYWY3WWRGeWpaSWNWeG1SSDRVWWlZU21ObjdjdmZrYkpaNEpt?=
 =?utf-8?B?OWswaGQrQ1VTY2tKWWV3TVFxdEViUjRkUEdha2pKaVBrMW16TkpMUW9pUC9r?=
 =?utf-8?B?L28vd2dBaVlBTGhuUmRQWXhxU2FOczlIN3VMNlFjaDA3S294TGowUmlIUEtv?=
 =?utf-8?B?dTgxU0FlL3dDTkhKcVROcVlJL0JVc3NlUHk3Ny9TbUh5Z0pVR2k1aHJ2a3BS?=
 =?utf-8?B?MCs4RytGNUt2WU1kUU1RYXB1Sm5aOHVCNXVzaGtCSnBpZGFjR201d2htaW1o?=
 =?utf-8?B?VlR2bzAxRlJ4M0o5cG5IRzdQeFBpeFREZFFsM29pdXR4d1JzTWk4UUVsOHI1?=
 =?utf-8?B?Q3FZNEQ4ZjVsSUszVGJ5emJUL0lRT0FSRzExUGVwaGFLV1ZBZ1NLY0lGQlNr?=
 =?utf-8?Q?e+/um0R0UGhMILZvPa6k6MGHKYe1fUYh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB8289.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dG9aS1poYWlxNWExSlNiS253cHVWNkx2Qngxa3EwN0V1cVFxRXBjcS9BS1J1?=
 =?utf-8?B?QUxxb1k0a1hUZEJQOExwMXNYcTFXcWY3YkdjbGhndnJ2Ly94ZDNCS3dsMjVW?=
 =?utf-8?B?UWlLKy82VHVrWTJFZHFKU1BjOXkrS0IzMGhmVUtGQjVTOEVyWSt5aWFLaEpO?=
 =?utf-8?B?MGN4S2NGcFpBbWxGRzhRb2ZodGl0UW1jcmVsakxHdFo1ZElpTW9LM3VOSExW?=
 =?utf-8?B?bUZnWnNQSWRpa2NaUW1UNnk4M0xGSHpBbmRYRnBRQ3BrUUMrS2dPd3JKMHJ6?=
 =?utf-8?B?TURiTUJzL2cvcmNwd0FWeHVxek1ydnJZamxEejhXbXFIaHVFMC8xQVRwNisz?=
 =?utf-8?B?TG5KemNueVExMG1QYW5hYWc2cWF0eEVldjlMUUpqNUIwUUs0K2o0Z0hEd2cr?=
 =?utf-8?B?c2gybXRnM21FaHh4THY4T1NhYisvQnp4am03VVdwblZZMlRPbUZLT2dlTzhl?=
 =?utf-8?B?UmlpVlBRSTJxVkF6VS9DaGxsc3BIbm5pZlhZSXgvT0hKWTVJNFVsVGF4SCty?=
 =?utf-8?B?czdDQWVpb1d1QW9xMlMwZVdPRDBVOU94VnE1RE5qNVlVMWV2d0JrcWR4cVU5?=
 =?utf-8?B?cW8xMmRHQzlsYnI5S3ZKbTNuUWxob3VvRFJhODJ0MU5DUThWcXFONHZYcXBm?=
 =?utf-8?B?QWpBcWtJZTJSYTdiRE5yN3VmeXlqSmt3NEhLeGxpMW0zL1FaN1dnMFNYS0E4?=
 =?utf-8?B?c0Z3Q0FKK2NvUjRKRmpVcFpTMjFHejhRb1BmK09LUEFSdE8yQWl6SWhRYURK?=
 =?utf-8?B?VWl6M3ZqeDFCQkE1L2I1ZXhWaEpuTG9ta2p5ZHFlQ1g2YzhsV3d1TEVhcVFB?=
 =?utf-8?B?Y1lZRG5mWEhUbkJzaytYNm9CbStxcDZ0ZGJGdDZYTmk3dEVna2NibTlBNkZ2?=
 =?utf-8?B?ZjUvT0NMcHpqRHZwTUk5VGFTS0RHVCs4S1o3VlZhWXBtOSt1Y1RTbHBIK3Rm?=
 =?utf-8?B?aVVEaGt5REJHQjVwNGEwdUxOcThxcU5sVGpYT2E4R2Vma3diWllFWTVzbEZ3?=
 =?utf-8?B?VkV2U3VobTczZEVtd2FXNUpTQjVqaGVyd3ZVMkpYQ2xpOHo2WkF0UkZQRGNJ?=
 =?utf-8?B?NDdLMTN1cnFOcG5XaXBkOUYrcmlEN00vUmZZN3ptNnpIVFpBeTVjZU92bDZU?=
 =?utf-8?B?V0p1eSs0dmJHU3B2bmpsT0h0eDRoazVtN2szOWRGdzJIYzBZNy93eUt5R05D?=
 =?utf-8?B?MVhheFlYSExlRUVMeVRTczBKOUU3V1FxaGErcTBOcFUyRDRkUndOQ04wamF2?=
 =?utf-8?B?TDlJd3F5aXovUnc3eE5IaE82VnBRbEdnMFFQRjhNclc3UkxpeFRkV3hCRUll?=
 =?utf-8?B?OGs5Vk12NzQveEZQSjJXOGVjdTUxNjdXSWF3cmVPV3hiV3l2dlpzZHdSTGN0?=
 =?utf-8?B?QlZLeklHeVpmcGFvMU8vcTJ3UVZ5RzFOSkUzdWFKMzNZZVhmZUdhTFZoUW4y?=
 =?utf-8?B?amVRUkd4Q1hiQ2ovWGtRSnZ3U3U2NFRoMmh3VHh0N3VBeEhzdFVjd2hRLytw?=
 =?utf-8?B?V3RQVVF6NWQ1a2h6TnJ1SHhqQW1XN0ZRNTBmZnE0Rmx3UTc0MnJSWUNSelkr?=
 =?utf-8?B?aVFSWmRhN3JJQmQ2cWRnT0l1SDhXZGxDQ3FmeFdhOVdJUXpmV25WRmYwcnFS?=
 =?utf-8?B?REhKQjRVSEJIcVlRMzJZY1UrNmcrRUJVQzhsY0twZkV0aHJXZUprckZwWWpC?=
 =?utf-8?B?eTlIdEUxOXIvbFR5ZVhvZ3lKSmcydTZiNGw4RytlVFp2SUxReVg2SlBWdENC?=
 =?utf-8?B?dlY0VnVlc2hwR3ZSNGMvdTNVNUhJeGdiemZkejJyQkJvNVlLendvc09CbVEy?=
 =?utf-8?B?cEdTeFR3YWZreWUvMEtVMkVmcFcrdk4va05qUEdMUWMxTElMSHpTT21rRnZQ?=
 =?utf-8?B?SVJhWnA0Y2t0V2hpM0FHSWlhZTdUOCs0SzZSWWdXQXdJTkdqRklVdjJLakxT?=
 =?utf-8?B?VW1EeUlhS3VjcE45YTR4UjNFT0t4eWJ4MzgvcGNyV3h2eVpmUzJTd2diQk1E?=
 =?utf-8?B?MVBWRERVdTVuQmI1TFRZb3ZEOEJFelAyS084by9EL1o0RTdzWGI0TXYzcG5J?=
 =?utf-8?B?MmZLbmZsRWh5MC85T2dGKzNuemM3NzBhVDI5V0xkNWliSVZVakt0eGpFTHZW?=
 =?utf-8?Q?48TWDqY2VxePrwAViHFY0yFdO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 971d2f93-9b89-4997-80b0-08de0f76b949
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB8289.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 01:19:32.5194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e6ZTj/b4JvdDjahP3bWTgRtEuXZOub4eke3LkDY8NjL91OP8neVcqLvrNaa8hEDb+5hZuKsoa/ZMNzTP0aAd0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8303
X-OriginatorOrg: intel.com

Hi Namhyung,


On 10/19/2025 11:31 AM, Namhyung Kim wrote:
> Hello,
>
> On Fri, Oct 17, 2025 at 12:04:42AM +0800, Li, Tianyou wrote:
>> On 10/16/2025 11:18 PM, James Clark wrote:
>>>
>>> On 16/10/2025 4:04 pm, Li, Tianyou wrote:
>>>> On 10/16/2025 9:06 PM, James Clark wrote:
>>>>>
>>>>> On 16/10/2025 4:36 am, Li, Tianyou wrote:
>>>>>> Hi James,
>>>>>>
>>>>>> Thanks for your time to review. Please see my comments inlined.
>>>>>>
>>>>>> Regards,
>>>>>>
>>>>>> Tianyou
>>>>>>
>>>>>> On 10/16/2025 1:30 AM, James Clark wrote:
>>>>>>>
>>>>>>> On 15/10/2025 6:20 pm, Tianyou Li wrote:
>>>>>>>> When perf report with annotation for a symbol, press
>>>>>>>> 's' and 'T', then exit
>>>>>>>> the annotate browser. Once annotate the same symbol,
>>>>>>>> the annotate browser
>>>>>>>> will crash.
>>>>>>>>
>>>>>>>> The browser.arch was required to be correctly updated when data type
>>>>>>>> feature was enabled by 'T'. Usually it was
>>>>>>>> initialized by symbol__annotate2
>>>>>>>> function. If a symbol has already been correctly
>>>>>>>> annotated at the first
>>>>>>>> time, it should not call the symbol__annotate2
>>>>>>>> function again, thus the
>>>>>>>> browser.arch will not get initialized. Then at the
>>>>>>>> second time to show the
>>>>>>>> annotate browser, the data type needs to be
>>>>>>>> displayed but the browser.arch
>>>>>>>> is empty.
>>>>>>>>
>>>>>>>> Stack trace as below:
>>>>>>>>
>>>>>>>> Perf: Segmentation fault
>>>>>>>> -------- backtrace --------
>>>>>>>>       #0 0x55d365 in ui__signal_backtrace setup.c:0
>>>>>>>>       #1 0x7f5ff1a3e930 in __restore_rt libc.so.6[3e930]
>>>>>>>>       #2 0x570f08 in arch__is perf[570f08]
>>>>>>>>       #3 0x562186 in annotate_get_insn_location perf[562186]
>>>>>>>>       #4 0x562626 in __hist_entry__get_data_type annotate.c:0
>>>>>>>>       #5 0x56476d in annotation_line__write perf[56476d]
>>>>>>>>       #6 0x54e2db in annotate_browser__write annotate.c:0
>>>>>>>>       #7 0x54d061 in ui_browser__list_head_refresh perf[54d061]
>>>>>>>>       #8 0x54dc9e in annotate_browser__refresh annotate.c:0
>>>>>>>>       #9 0x54c03d in __ui_browser__refresh browser.c:0
>>>>>>>>       #10 0x54ccf8 in ui_browser__run perf[54ccf8]
>>>>>>>>       #11 0x54eb92 in __hist_entry__tui_annotate perf[54eb92]
>>>>>>>>       #12 0x552293 in do_annotate hists.c:0
>>>>>>>>       #13 0x55941c in evsel__hists_browse hists.c:0
>>>>>>>>       #14 0x55b00f in evlist__tui_browse_hists perf[55b00f]
>>>>>>>>       #15 0x42ff02 in cmd_report perf[42ff02]
>>>>>>>>       #16 0x494008 in run_builtin perf.c:0
>>>>>>>>       #17 0x494305 in handle_internal_command perf.c:0
>>>>>>>>       #18 0x410547 in main perf[410547]
>>>>>>>>       #19 0x7f5ff1a295d0 in __libc_start_call_main libc.so.6[295d0]
>>>>>>>>       #20 0x7f5ff1a29680 in
>>>>>>>> __libc_start_main@@GLIBC_2.34 libc.so.6[29680]
>>>>>>>>       #21 0x410b75 in _start perf[410b75]
>>>>>>>>
>>>>>>>> Fixes: 1d4374afd000 ("perf annotate: Add 'T' hot key
>>>>>>>> to toggle data type display")
>>>>>>>> Reviewed-by: James Clark <james.clark@linaro.org>
>>>>>>>> Signed-off-by: Tianyou Li <tianyou.li@intel.com>
>>>>>>>> ---
>>>>>>>>    tools/perf/ui/browsers/annotate.c | 3 +++
>>>>>>>>    tools/perf/util/annotate.c        | 2 +-
>>>>>>>>    tools/perf/util/annotate.h        | 2 ++
>>>>>>>>    3 files changed, 6 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/tools/perf/ui/browsers/annotate.c
>>>>>>>> b/tools/perf/ui/ browsers/annotate.c
>>>>>>>> index 8fe699f98542..3b27ef1e8490 100644
>>>>>>>> --- a/tools/perf/ui/browsers/annotate.c
>>>>>>>> +++ b/tools/perf/ui/browsers/annotate.c
>>>>>>>> @@ -1161,6 +1161,9 @@ int
>>>>>>>> __hist_entry__tui_annotate(struct hist_entry *he,
>>>>>>>> struct map_symbol *ms,
>>>>>>>>                if (!annotation__has_source(notes))
>>>>>>>>                    ui__warning("Annotation has no source code.");
>>>>>>>>            }
>>>>>>>> +    } else if (evsel__get_arch(evsel, &browser.arch)) {
>>>>>>>> +        ui__error("Couldn't get architecture for
>>>>>>>> event '%s'", evsel- >name);
>>>>>>>> +        return -1;
>>>>>>>>        }
>>>>>>> symbol_annotate() only fails for negative return values
>>>>>>> of evsel__get_arch(), but evsel__get_arch() has at least
>>>>>>> two positive error return values.
>>>>>>>
>>>>>>> If symbol_annotate() is wrong and it should be != 0 like
>>>>>>> you have, then maybe symbol_annotate() should be fixed
>>>>>>> in another commit in the same patchset as this one.
>>>>>>> Otherwise you have two calls to the same thing right
>>>>>>> next to each other that handle errors differently.
>>>>>>
>>>>>> Thanks James. I will give a try on handling the error
>>>>>> message with symbol__strerror_disassemble. I am conservative
>>>>>> to change the code in symbol_annotate, agreed it should be
>>>>>> considered in another patch. Would like to focus this
>>>>>> particular issue and get it fixed properly. Thanks.
>>>>>>
>>>>>>
>>>>> Looks like there was a misunderstanding. I'm not saying that the
>>>>> error is _reported_ differently, it's that the condition that
>>>>> triggers the error is different.
>>>>>
>>>>> symbol__annotate():
>>>>>
>>>>>    err = evsel__get_arch(evsel, &arch);
>>>>>    if (err < 0)
>>>>>        return err;
>>>>>
>>>>> You added:
>>>>>
>>>>>    if (evsel__get_arch(evsel, &browser.arch))
>>>>>       ...
>>>>>
>>>>> evsel__get_arch() returns positive error values (and maybe also
>>>>> negative?), so "< 0" behaves differently to "!= 0".
>>>>>
>>>>> You either have to assume that "< 0" is correct and not change
>>>>> it, but then you have to also check the return value in the same
>>>>> way. Or if by doing "!= 0" you're implying that
>>>>> symbol__annotate() is wrong to do "< 0", then you should fix it
>>>>> now to not leave __hist_entry__tui_annotate() doing the same
>>>>> thing two different ways at different times.
>>>>>
>>>> Thanks James. I looked at the code of symbol__annotate, and noticed
>>>> the if (err<0) statement. I did not mean to change the code in
>>>> symbol__annotate because I did not understand why it handled the
>>>> error code that way. The positive return value of evsel__get_arch
>>>> indicates some error happens, eg in arm__annotate_init, so I use the
>>>> symbol__strerror_disassemble function to handle both positive and
>>>> negative error code.
>>>>
>>>> I do agree we should check the error code of evsel__get_arch, but I
>>>> am hesitate to touch the code which I am not sure the consequences.
>>>> I agree it may deserve another patch but not in this patchset if we
>>>> have clear answers on why "<0" is not correct, or we have a case to
>>>> break the current code as a evidence. Thanks.
>>>>
>>>>
>>>> Regards,
>>>>
>>>> Tianyou
>>>>
>>> It may take a little bit of effort to follow the code and look at the
>>> git blame to see what happened, but it's really not going to be that
>>> hard.
>> Truly appreciated for your instant response, and the suggestions about
>> 'Fixes' tag, return value handling etc. I do check the git history about the
>> code "<0", I still did not quite understand the reason of handling it in
>> that way.
> Looks like I just overlooked the error handling when I factored out the
> function.  Please feel free to update symbol__annotate() to check != 0.


Thanks for the confirmation. Will send the patch v3 soon.


>>
>>> You're basically suggesting to add code that (when expanded) does this:
>>>
>>>    if (first_run) {
>>>       if (do_important_thing() < 0)
>>>          return err;
>>>    } else { // second run
>>>       if (do_important_thing() != 0)
>>>          return err;
>>>    }
>>>
>>> It's not going to help anyone who looks at it in the future. It's going
>>> to make future refactors of evsel__get_arch() more difficult, and
>>> without knowing why it's like that, it's possibly introducing another
>>> bug.
>>>
>> I am suggesting to focus on the 'else' part. If that part of code is
>> correct, then we might need to consider another patch for the "<0" code. I
>> am eager for the answer as well.
>>
>>
>>> It surely has to be consistent otherwise it doesn't make sense. And if
>>> you sent a patch that did "< 0" I would still say "but it can return
>>> positive errors, so the new code isn't right".
>>> I did suggest in the beginning to not check the error at all and add a
>>> comment saying it must succeed at that point because it's already done
>>> once before, but that's not very defensive and it doesn't fix the other
>>> possible bug.
>>>
>> Yes. I am not so sure 'must succeed' could be a right assumption, or for
>> safety it's better to check the error code.
> Agreed.  Anyway I can confirm that this patch fixed the crash.
>
> Tested-by: Namhyung Kim <namhyung@kernel.org>


Thanks. Will include and send the patch v3 soon.


> Thanks,
> Namhyung
>
