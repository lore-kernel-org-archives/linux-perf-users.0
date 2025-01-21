Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D048785931
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Jan 2025 06:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737440220; cv=fail; b=CPYhnSUj5+esX/de0khjbuXrJX5SQzerhLeqePTO8BobhXq3yuQ3/Q1VacbzEv0VE6k03XX+qfQVCYoKmQlM2Vfy1n6Av7TwOalLaqqjQUEa65mign/4Dj8T8k2HNjemzyXO8YFjQmJpPaReDhwQ6Nqy3vb0vyNntg74r+zmDOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737440220; c=relaxed/simple;
	bh=csOkbjFqgxFf4MItnjaa0isecBxG3sT0VvScpb109PE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j+CvuopObNuFNflpzAKfh4iQE7cWyx8NPFnthfsOUfFIaK4/FTNymAlCxFavdWNYuGLTUxt5JoJBuXupHVqQFIQ6jVG65WgkFWvCrwXNqGURrzs57kw6sUeTLP8heKbg1cbSl5zIb0d2Fm3M/nfh+7EiUGYWsGGvhcY5HgXTpUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IBY1Oq4a; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IBY1Oq4a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737440215; x=1768976215;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=csOkbjFqgxFf4MItnjaa0isecBxG3sT0VvScpb109PE=;
  b=IBY1Oq4aOiAsHHL6WiZf1r4TXLkyiMWmG5n1Nt8qCFISh67ogdZUNsET
   DHC/yXgzdDxXOFA//N/P6eOAe2cthA2XMQ77txMm28Mx0S5V6qcjZ8r98
   VVT06o8C+svT2wy27JAB1jvn1n+e8iD+C2x8jrgIta8lFlb5mqV3vFpNK
   pPBbGv+p6qSKcwyO963DicApiIlpSowaQsbDD4dVVoYdSr4MX61RQe6qo
   2I0M/HNX8PRvCDNuM9tpRJwye9TMmHi6jsmQq1HKNldUxWzc8B9ENx2Pf
   TjitceMGezseBNsFSCa+Gpgaoeg1UcZK7jwQ1PWBiC18B7dwMV+uG18T8
   g==;
X-CSE-ConnectionGUID: U5eOAlCnRkuxg9ZR8D8WFQ==
X-CSE-MsgGUID: tH9WSjy5QiOZlHj8I6AoTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11321"; a="48332313"
X-IronPort-AV: E=Sophos;i="6.13,221,1732608000"; 
   d="scan'208";a="48332313"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2025 22:16:54 -0800
X-CSE-ConnectionGUID: Mln3HQdSSV+XiVH0hDDRRQ==
X-CSE-MsgGUID: uv0Q+6r4S2uY8InOxaBUAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="129966431"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Jan 2025 22:16:53 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 20 Jan 2025 22:16:53 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 20 Jan 2025 22:16:53 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 20 Jan 2025 22:16:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HTTpqB2plPxrYN1xJnvOOfk4AxNqL0kVuNyQBwoL6X6zwZh/JqB/0BZqXEUvp47j+YPFetRdZ4MwFuNV5dtqLcSmS3Jr4MkZ/wGuFd74NfxbElRIVgXzgAhtkvmymRKA3g7CI1wgvKVkobkfv9dI4E5MF1BMuxvalgGNsyCuonJOCw7311UBS2T7m9pUIh8yDn9D7jJndk4yrlDBzUL01g4jjeZBo9z7HLp403nq9JYNoQcgklaLHn+CZisgwYAhLY7Bg0XmbpebS5lL7lCMCDiSH4RPv1u/hVWoi9BB0+SCiUPM7/WdrcELv86mmORI9Iq6t+52w5pN29MDd7JyPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHCqC8SqczIE8A+PxsNGcrTvRSIUVyhj8TD8DuNJWME=;
 b=XWxED4uhNB1O3I2zhIt3B688nc6DZRxCt/kfge8LyrEj0kxE8dQPVl4o0NKtd3hcBPq0DEV3/xFn1wACMMKYXq2dkDVZnZsk37j2QCcGP8IQP7gdvz1hMD+wHlPIS5fCrc/QGjZ8unB7gpe4d4IVjXWheiex7tIMkmRqzs7/Daf5Gi9OTvIXu3/Pp0LqTO3jydxZeFcTnYyYPJMA4Lr+7pJxoyylGOBQUBIeW0GdOCUSVoNUeNrwwoHngEsg17zJjmsn0sKLZP99qz7KAUnVhfEWnczF1WKIEkiLgp1ycH2roE1WGZeg+/6DOsleoCphs/6std65hEJmKlscp15aSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 SA2PR11MB5132.namprd11.prod.outlook.com (2603:10b6:806:11a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 06:16:51 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::d3ba:63fc:10be:dfca]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::d3ba:63fc:10be:dfca%3]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 06:16:51 +0000
Message-ID: <cbf55ca1-1692-4db4-9589-c07aec53cfe6@intel.com>
Date: Tue, 21 Jan 2025 11:46:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 7/7] drm/xe/pmu: Add GT C6 events
To: Lucas De Marchi <lucas.demarchi@intel.com>,
	<intel-xe@lists.freedesktop.org>
CC: Peter Zijlstra <peterz@infradead.org>, <linux-perf-users@vger.kernel.org>,
	Vinay Belgaumkar <vinay.belgaumkar@intel.com>
References: <20250116230718.82460-1-lucas.demarchi@intel.com>
 <20250116230718.82460-8-lucas.demarchi@intel.com>
Content-Language: en-US
From: Riana Tauro <riana.tauro@intel.com>
In-Reply-To: <20250116230718.82460-8-lucas.demarchi@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0182.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::18) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|SA2PR11MB5132:EE_
X-MS-Office365-Filtering-Correlation-Id: b35bd76f-2382-4024-13a0-08dd39e331b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXFjZHFjVFZuTWE3TmFZbUVrNkM1QjVTQUVISVM3T3Z4VGVnQkJIUFlIMmlW?=
 =?utf-8?B?eFZjYithS0pqVDBDYmdHWWhLSjRnNHU1QWhpRXBINEN4M3gzNnJuRGVxSCti?=
 =?utf-8?B?b29qaDFSVDg1M3VNbkgweUpwcEltZW5xMTVBanVRWDVVQ3JKOHBtcXVwYW4w?=
 =?utf-8?B?bHF6MVAxc294dVRoVkloeDlkcFNhS2hIeEM3MDFaaVhINnA1cUNRci9QYnBa?=
 =?utf-8?B?bVhMVjVrekhBenlrVlNkaUpXL0pSV0FIZFVoc0U0eU9OY3ljOXZIMG81djFY?=
 =?utf-8?B?SElJenI2SHRoeXFoVXFEUW5pb0hFMmN3dnlZVFA5N3VtK1NVaVdLTWhPSXFo?=
 =?utf-8?B?QlRyWjJSRWxKbmtRWklDdHhvYVpvTThmUEp5Y2V5ZDB6THZYajJNY0F4WHAz?=
 =?utf-8?B?UFlwV0hUVXhMcE53NmRwL2M0R25Qd1dpbTZmNjRTVFMxMCtERjhWOTFkQmVZ?=
 =?utf-8?B?VHhDNCtKTUZoNGcvZWcyUkhPQkhKRjNWMlFuMjZvY0lMektmdXF3V2ZQWk16?=
 =?utf-8?B?T3VteEl5QklnbjQ4M2tubWUzRWN5S0FEODRiUjlYYW1KK2FkQlQ3VjgrQklR?=
 =?utf-8?B?QmtlSlVuSm9yY0NST29aL2tGd0s4S3hmc1NhLzN1Y0xucE9zQXFVenE1Z05m?=
 =?utf-8?B?U2JnZmpiUVdMS2l4RUMxRjBxVi9FOWdVdVh6QnJHdDF0YU5BQ2NxbFlTWDlm?=
 =?utf-8?B?cFlpS0FKUTdWVVM2ZndiSGRJUWFLZlhsWEVGTkYwY095M3F3MlhxOVd6T1lE?=
 =?utf-8?B?RUtBY0w1WHdNNTRzanVLY21ZVTV3d3cyRklTWjFMd3Q3Yi9hckRHaVcyUWNv?=
 =?utf-8?B?VDZyeEJDYkE5N3F0L3NxeUVZV1hNamF1SnVnNXpIKzdoVEFLUDZqMzJiTGQv?=
 =?utf-8?B?V1JEcDh2VEpZVTJSY1RTODNSL21BRGkxUXUwWlJCb1pscUt0ck5yVThza3pJ?=
 =?utf-8?B?ZzY0M0FHUlJuQmZORjA0UTVLQUJCZFBOZmVKMU9BbW1haFdqemgyMkl4UVl5?=
 =?utf-8?B?dU5PSUR2WW1wQWFldFBROWRyTVRVeFR4RGg2QTczSzhZRjUxZkw4RGFYb28z?=
 =?utf-8?B?R2prdFVPYWtrUnRjcDJ6NzR5VmhzTnFMQ29EaEt5eFN1bzV4c1hTcUgzNUNj?=
 =?utf-8?B?ZHhyU0VHd2hEUm5Od0c3QmtYWkdWSTcxaXhJeEt2cVdSV0ZQbHhUODlUcGhi?=
 =?utf-8?B?YWUrTWN0QnI1a21QK3AwblZlaEdBRm5xclp2UVloSk9xdTdIVTA2RllpOG54?=
 =?utf-8?B?aUpCaDdWY1MzVnVFcXJLcHRhOG5FR2IvcEdweEVGanBrd2c4Y0VwWFBmTHVB?=
 =?utf-8?B?aHpsMDRxUXJsb2hxSDlZODFZVENJUXBITzV6bW90MG52amUwZmlGQ3ovdUI2?=
 =?utf-8?B?YS9WSkpYTWZyYWUyaGpmKzVoZFk3bWxudnJ1WVE1ZS91THBxQlI1U3FQbFN4?=
 =?utf-8?B?ZDlsQUZuQXZaTVV2MG9RaFFoY3plMEl5U1NUWEhBSkpobGpnZkpYR3NINzZC?=
 =?utf-8?B?RjBZNlVKenpkVnl2TVRpL3hOS2VhSmZhRC9ndjhDQWtIRVFXWFhxWVF1M2Yw?=
 =?utf-8?B?UDZzMHlYT0EybXZlYlhkeERYL3dqdDFSRjQrQTgzWjlRQjdYWFZHQzV4WlhB?=
 =?utf-8?B?dEthZWM2MnR5THlLUDg2Yy82Z1NwTm1uNmMwWnRac0hyYS96clBrMk9idWVm?=
 =?utf-8?B?bDdNUUZuSno0ZTNpZytrN0xJR2tuVVMxQWZ1cG42VzZWdUxFSUNBeHZ0RkZ5?=
 =?utf-8?B?N0VINkdIaCttRFlSdzBqakpaU25VQTlSenVrZVlrMEczSklRMUhTS3NVbFFv?=
 =?utf-8?B?MXRXa0RyTjJKbk9DQnArZ0xxL3VYWGh2b0c1aHdmYkNpS1huVElteVQydklv?=
 =?utf-8?Q?1Q88fGTNPo3vk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmR5QVhKT2tydDRaSjNuNTYzZXIwNkxpYStxQjlnRWRIaFgrWFQrcUE2eWpK?=
 =?utf-8?B?V0gwd0ZGMk8rSCtVN1FFVHZ1SEtuMU9JMkIrTXg1aCtwS3oweHdFYU5vODF6?=
 =?utf-8?B?czkwaVpyZzhnMFBLdUR5UEs4VWZ6Rk9yQ1pkenJ4VWxwWExUcjRLZEhBQ2xw?=
 =?utf-8?B?aHlEYXZOemJRMVJtMlJ3VzE3VnF1VmNRdS9qbDBXWkV3aGlSdER1WFp1VS82?=
 =?utf-8?B?WTIyUWovQUludllmK0VHdzJIbkViUnZHU2UvZ0gvRmxCeE1EbC9nczFHdGhz?=
 =?utf-8?B?QXFlVUo5RE1JK0QvUWVld2FsMnpIMmkvS05CY3J6QnJHbTVkeCtLZXZoUWwv?=
 =?utf-8?B?QndsV3oyUnpzVzJ6V3JJVkdzMGk5THNpVndUYVdlbjRKc0VQWEFvZjBKVmpG?=
 =?utf-8?B?WThkRk9uNUdWVWNGc2UvOVU5S0UvTjZjdi92dDR0WkNIUFBRY2lLaFVHSTZx?=
 =?utf-8?B?MU13dXlNWFh5WTNhdWE1TmNtVVRLOGlxZzh6ait1Y2pFcklpcWlUbVBQbWFu?=
 =?utf-8?B?R0UyK1NLY1ZEbTlMOTFveGNKYTNibDcrTkZ4VGJFQkR5emlwdDdSaFFZVG9N?=
 =?utf-8?B?eFFCQXFISmRyWWd6SW5wWDRHVEZZTWpBVVUxcHFXRWlERlNtc0NnUFQxYXcw?=
 =?utf-8?B?WGVXUmpmaGVyM2dLa3BQRkd6bkhsSkRvOFVJN3lRUk5Pa2VSckh3M3lzVHd4?=
 =?utf-8?B?bklGM0ZGSHl1Nzl4VHdUOW5mZFVHbDdGdis3Rm1yblhMTmVWUzBlek1QQmxi?=
 =?utf-8?B?TVBoeitleFVKcVkwK2VkSlZ6M2JJcGtralB0cGxkcGprNTZ6eG03UVBwZnB2?=
 =?utf-8?B?aW1nZ0k2V0VBNzZlSTdMbGlBRzhzNkczOUYyUm4yOEhBNXp5USsxYitaWjdJ?=
 =?utf-8?B?bnZwSUNISUIvazhDaUNzSGJ1QjFXeUorOTBNN0VCZnlyWW1JcE1GWjZ1bVRw?=
 =?utf-8?B?Ky9Ga3RBc2lYVUhqcndBQlVaSEovNzMvN2xJaG0yQTB6cS9NdUhzREZiLzgw?=
 =?utf-8?B?ejZLWndKdkJ5YUVLRWNPdXgrems3bTFFN2FMeEZLWmFWLzhZY2ZXRUpBRXcy?=
 =?utf-8?B?RU05NmlhejRCZjNRWVd5WWU2ODZjdHBMakViekdhd2hmZjBpR1h4UldGemZz?=
 =?utf-8?B?MjhxZmVjRUV1RzlYdVVOSDAvMjV4OFByR2YyYXJGWmIvVVRvL0RCUHdVaTds?=
 =?utf-8?B?ekxuTWNGZjkrZXVKRVdMaWYwci9VazZvZGhUQkVMYmZJYTF6Y2loRm1YbStl?=
 =?utf-8?B?eGtVK05BaElEWWtjMHFYU2lqUFlqaUhMczk4SUpSRU1yYzREckUrUHRaM3dy?=
 =?utf-8?B?Rk51MUZwak40M1dVTHdEaVBUWGJiUm80OHhRL3JpTm5QdUtQTW9vY2VJVFE0?=
 =?utf-8?B?K21NelRiWDl2Q2JMUTF2Qk41Q1FCTWV2ZUVmMUs2RXJCRHZrNFd1alZ5NVJs?=
 =?utf-8?B?ejlGdnNhMzdaNm9BNTZMaU9haE1ETE5pY0Ixc3h3cGZwbFBLL2JkOEI1amRw?=
 =?utf-8?B?NldmbEJBczY2bFJTQklsQ1N0SmNsMVRoM3BkWFY0c3cwY1Nnc2NQSEV3NUlM?=
 =?utf-8?B?dktxTlQ2cVBETFVXTnlrTGFVQ2ZWbFJaZEc2cnhFZDI2eFg0WHpFRUt5WWY2?=
 =?utf-8?B?WmxVMkpHY1V5UlEwZFl4TGJvdHFpWmZCWGxHZXZjTFkyWURuWjk1SGxocDBh?=
 =?utf-8?B?LzRJYS9rcWcvQ25jaWlaUjEwNTZlaGNVNVZNeHRtR1lFL1ZVd2VoSVdTWDhl?=
 =?utf-8?B?UzllMWp6U1kwcDNNbzdkNEdpbXQrWk1DTWt1ME9YVlhLWDRiK3JjUXpuUlla?=
 =?utf-8?B?WGlpNWdLUGFrQzJxN1JDV2hycDBBM2dUS0V0eU9ZRGoxWXozUWdyN1RhMndI?=
 =?utf-8?B?MUVONVhja2JNZS9mcWZHelpPajg5KzYwOHR2ZDRHN2RlT3hTWWkyL1BINHVt?=
 =?utf-8?B?ZnV0d2Vsd1d1d3JFMDJ1Y21pakhCN0FyaXMxM3dJZnZOTksxbEhpazhweWRS?=
 =?utf-8?B?R2FXTkxUejhKd3MzbWRTOWp1M1F3OVZaUHRuZDZDV1BtNXpiQ09Pd3J5UkdL?=
 =?utf-8?B?VTU0VklTRVg2WHlza1o0TXM3TUVYK1hmby8vVzRDcFFkUHFLakNiaVBsbjZu?=
 =?utf-8?Q?lIDqQRlsKVHmFgj3iIioPR9rW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b35bd76f-2382-4024-13a0-08dd39e331b3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 06:16:51.4027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 78tLGWqNE4R82v/V33ln35CYNnJLOwW2hL/T/aGQCkig4c85RUCgmiqG3Bwl3460fi6bMwVHwPU7rL5tnI66sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5132
X-OriginatorOrg: intel.com

Hi Lucas

On 1/17/2025 4:37 AM, Lucas De Marchi wrote:
> From: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
> 
> Provide a PMU interface for GT C6 residency counters. The implementation
> is ported over from the i915 PMU code. Residency is provided in units of
> ms(like sysfs entry in - /sys/class/drm/card0/device/tile0/gt0/gtidle).
> 
> Sample usage and output:
> 
> 	$ perf list | grep gt-c6
> 	  xe_0000_00_02.0/gt-c6-residency/                   [Kernel PMU event]
> 
> 	$ tail /sys/bus/event_source/devices/xe_0000_00_02.0/events/gt-c6-residency*
> 	==> /sys/bus/event_source/devices/xe_0000_00_02.0/events/gt-c6-residency <==
> 	event=0x01
> 
> 	==> /sys/bus/event_source/devices/xe_0000_00_02.0/events/gt-c6-residency.unit <==
> 	ms
> 
> 	$ perf stat -e xe_0000_00_02.0/gt-c6-residency,gt=0/ -I1000
> 	#           time             counts unit events
> 	     1.001196056              1,001 ms   xe_0000_00_02.0/gt-c6-residency,gt=0/
> 	     2.005216219              1,003 ms   xe_0000_00_02.0/gt-c6-residency,gt=0/
> 
> Signed-off-by: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
> 
> Besides the rebase, that changed a lot how the event was added,
> here is a summary of other changes:
> 
> - Use xe_pm_runtime_get_if_active() when reading
>    xe_gt_idle_residency_msec() as there's not guarantee it will not be
>    suspended anymore by the time it reads the counter
> 
> - Drop sample[] from the pmu struct and only use the prev/counter from
>    the perf_event struct. This avoids mixing the counter reported to 2
>    separate clients.
> 
> - Drop time ktime helpers and just use what's provided by
>    include/linux/ktime.h
> 
>   drivers/gpu/drm/xe/xe_pmu.c | 56 +++++++++++++++++++++++++++++++------
>   1 file changed, 48 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_pmu.c b/drivers/gpu/drm/xe/xe_pmu.c
> index c2af82ec3f793..37df9d3cc110c 100644
> --- a/drivers/gpu/drm/xe/xe_pmu.c
> +++ b/drivers/gpu/drm/xe/xe_pmu.c
> @@ -11,6 +11,7 @@
>   #include "xe_device.h"
>   #include "xe_force_wake.h"
>   #include "xe_gt_clock.h"
> +#include "xe_gt_idle.h"
>   #include "xe_gt_printk.h"
>   #include "xe_mmio.h"
>   #include "xe_macros.h"
> @@ -117,16 +118,50 @@ static int xe_pmu_event_init(struct perf_event *event)
>   	return 0;
>   }
>   
> -static u64 __xe_pmu_event_read(struct perf_event *event)
> +static u64 read_gt_c6_residency(struct xe_pmu *pmu, struct xe_gt *gt, u64 prev)
>   {
> -	struct xe_device *xe = container_of(event->pmu, typeof(*xe), pmu.base);
> +	struct xe_device *xe = gt_to_xe(gt);
> +	unsigned long flags;
> +	ktime_t t0;
> +	s64 delta;
> +
> +	if (xe_pm_runtime_get_if_active(xe)) {
Seeing this lockdep warn on reading gt-c6-residency

[ 5032.731663] =============================
[ 5032.735699] [ BUG: Invalid wait context ]
[ 5032.745260] -----------------------------
[ 5032.749300] perf/3320 is trying to lock:
[ 5032.753260] ffff888105f2c238 (&dev->power.lock){-.-.}-{3:3}, at: 
pm_runtime_get_conditional+0x26/0xb0
[ 5032.762528] other info that might help us debug this:
[ 5032.767613] context-{5:5}
[ 5032.770262] 3 locks held by perf/3320:
[ 5032.774045]  #0: ffff88846f632048 (&cpuctx_mutex){+.+.}-{4:4}, at: 
perf_event_ctx_lock_nested+0xba/0x230
[ 5032.783587]  #1: ffff8881037482c0 (&event->child_mutex){+.+.}-{4:4}, 
at: perf_event_for_each_child+0x39/0x90
[ 5032.793480]  #2: ffff88846f631fb8 (&cpuctx_lock){....}-{2:2}, at: 
event_function+0x57/0x120


[ 5032.829907] Call Trace:
[ 5032.832384]  <TASK>
[ 5032.834513]  dump_stack_lvl+0x81/0xc0
[ 5032.838236]  dump_stack+0x10/0x20
[ 5032.841586]  __lock_acquire+0xa5a/0x2550
[ 5032.845548]  lock_acquire+0xc3/0x2f0
[ 5032.849156]  ? pm_runtime_get_conditional+0x26/0xb0
[ 5032.854066]  ? is_bpf_text_address+0x71/0x120
[ 5032.858487]  _raw_spin_lock_irqsave+0x4b/0x70
[ 5032.862892]  ? pm_runtime_get_conditional+0x26/0xb0
[ 5032.867814]  pm_runtime_get_conditional+0x26/0xb0
[ 5032.872570]  pm_runtime_get_if_active+0x13/0x20
[ 5032.877141]  xe_pm_runtime_get_if_active+0x12/0x20 [xe]
[ 5032.882545]  __xe_pmu_event_read+0x116/0x2a0 [xe]

Thanks
Riana

> +		u64 val = xe_gt_idle_residency_msec(&gt->gtidle);
> +
> +		xe_pm_runtime_put(xe);
> +
> +		return val;
> +	}
> +
> +	/*
> +	 * Estimate the idle residency by looking at the time the device was
> +	 * suspended: should be good enough as long as the sampling frequency is
> +	 * 2x or more than the suspend frequency.
> +	 */
> +	raw_spin_lock_irqsave(&pmu->lock, flags);
> +	t0 = pmu->suspend_timestamp[gt->info.id];
> +	raw_spin_unlock_irqrestore(&pmu->lock, flags);
> +
> +	delta = ktime_ms_delta(ktime_get(), t0);
> +
> +	return prev + delta;
> +}
> +
> +static u64 __xe_pmu_event_read(struct perf_event *event, u64 prev)
> +{
> +	struct xe_pmu *pmu = container_of(event->pmu, typeof(*pmu), base);
> +	struct xe_device *xe = container_of(pmu, typeof(*xe), pmu);
>   	struct xe_gt *gt = event_to_gt(event);
> -	u64 val = 0;
>   
>   	if (!gt)
> -		return 0;
> +		return prev;
> +
> +	switch (config_to_event_id(event->attr.config)) {
> +	case XE_PMU_EVENT_GT_C6_RESIDENCY:
> +		return read_gt_c6_residency(pmu, gt, prev);
> +	}
>   
> -	return val;
> +	return prev;
>   }
>   
>   static void xe_pmu_event_update(struct perf_event *event)
> @@ -136,10 +171,11 @@ static void xe_pmu_event_update(struct perf_event *event)
>   
>   	prev = local64_read(&hwc->prev_count);
>   	do {
> -		new = __xe_pmu_event_read(event);
> +		new = __xe_pmu_event_read(event, prev);
>   	} while (!local64_try_cmpxchg(&hwc->prev_count, &prev, new));
>   
> -	local64_add(new - prev, &event->count);
> +	if (new > prev)
> +		local64_add(new - prev, &event->count);
>   }
>   
>   static void xe_pmu_event_read(struct perf_event *event)
> @@ -162,7 +198,7 @@ static void xe_pmu_enable(struct perf_event *event)
>   	 * for all listeners. Even when the event was already enabled and has
>   	 * an existing non-zero value.
>   	 */
> -	local64_set(&event->hw.prev_count, __xe_pmu_event_read(event));
> +	local64_set(&event->hw.prev_count, __xe_pmu_event_read(event, 0));
>   }
>   
>   static void xe_pmu_event_start(struct perf_event *event, int flags)
> @@ -267,6 +303,10 @@ static const struct attribute_group pmu_events_attr_group = {
>   
>   static void set_supported_events(struct xe_pmu *pmu)
>   {
> +	struct xe_device *xe = container_of(pmu, typeof(*xe), pmu);
> +
> +	if (!xe->info.skip_guc_pc)
> +		pmu->supported_events |= BIT_ULL(XE_PMU_EVENT_GT_C6_RESIDENCY);
>   }
>   
>   /**

