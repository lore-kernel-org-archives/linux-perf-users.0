Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C974E4C54;
	Thu, 17 Sep 2026 20:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789675828; cv=fail; b=L8UBQHWMZBcMGtwRXsfkiY/A6GOOw3noZmwQwW2syYyIiJDly/KLUYqvroxnIsMKbmRqFjNzM0Wau/9JKjdzpEjEXj6HhJWzsYi67qF7Cc6ICBvr017E1U0SRnxwQpbC0f9RPUPbbZ6AytG6fRQb1GReGOWFzGuOMxbQ/CMIzqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789675828; c=relaxed/simple;
	bh=Gjp4mRoqhm4ECsjgaqYMWmF4o3IexE/cAPTBjiTiF9I=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sNxkDFUh8VFN+aK9mDBRCSNllxvePNFYDDP0/Y/0w4unejifBfvpNFC4Q07pXn10LqZ9dSm4ufz6Is3G7jPXKQ5haJ2Af3wU18HW342otcaikEFHlEFC16nwZidNPFdwgb0a29uMzXbTE8QPykcitvd5/G+AbeVj46OA31ap/pM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QxwDAjXC; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QxwDAjXC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789675824; x=1821211824;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Gjp4mRoqhm4ECsjgaqYMWmF4o3IexE/cAPTBjiTiF9I=;
  b=QxwDAjXCkudYC+IkPV8YNyFxmYuUAcFSQr+gM/aoFUsq779h1sYOaGw+
   aDXnOL4FI/nUUNzAxRbdotF90dI1fsITkZXk7Hn14AcjdmjM0YqI6wVOZ
   qVcRGqfj6XX6oywP1BnuSq57HRA/t4qBItOCH9k0Bs1X9C5BUb6SlI2KU
   YxnsNIq98QFFobtQm2oSKmQTW9xGi2ZzeJqKIL2eLUQaSt+LIoslhXQNq
   90Q6uaJYABJdouaocOiYiObXv9F/HUBn5GnBCokSeqTuTZdp9uoYrMGwZ
   iCNdWCWeFFs/iGY7E2ZrFzoj4hw63W1sdm3PoPvMUjgkVZBW/TJxndKZ/
   g==;
X-CSE-ConnectionGUID: aPrcAmKPSp6Ptj/ZOKsUBQ==
X-CSE-MsgGUID: crF80NKUSXSsXx0rEzkvJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93972563"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="93972563"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 13:10:20 -0700
X-CSE-ConnectionGUID: kGUu0oo0QlOiW6yyKuOyVg==
X-CSE-MsgGUID: BikfaKFZQWi/tPD05Azuhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="271351602"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 13:10:20 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 13:10:19 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 13:10:19 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.19) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 13:10:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eXaDdJDFdNKm30XBRnN9Yl4rE93KyfJ3DIO9FFyeao1FYJQnT6opjrlaCa5iA2me69Bw8B1V938K3b+Y8IGK/V/L2gYTazyImTWGIV43J7XDLY8pL7zrTA2Si1xylp2mFGY+GCHihQ/3koTIyRoLHKfRrULD/t89GKmrQUhh841aG6HI3i1Ol8IHr0T5EBQO8PkSpS0w2HGy+NS7oISuyyVTTKXUxPM0FF5A9gVYiRSZT7e9tFvt8oPiOO6E3J1pkbEzCHyQiMX2BjqgtBeOZu3MlSS6HV4shTeoXn3nhV5sBOYQNvukUoMrYezi9Trn/zvfuTlv5xwcMjLl26HRvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttnUFm4JxF6w1uAdzFixJud+UA4SCK71mxS2mxHIcdg=;
 b=KawaBrPwEfyVk39ykDJKzQVMaMd2PAAhakIsrsju0VMM+NxgYEoT7Si4CVry+sY8g5xY5rMsQl3RaOVr10V1twlizTrAV0WoKI5S9nX46L7dt2CGbciPBih2wuqOgUnBtuGN6PoBblAFW/cfWUY/YxhIKXd+GEYxWKW5wAzdR6s4dYybilDIhiH7HL1xbrv0sIaZwV9IB7OUCahYQWic+N+bze7hjOY7vBXJ7FkZMfyBVkPsqg58HzyYCEhu8KTrNYNhqHB1+8AngdRmMiYtKJMy8yb3d4FD8Z7bQ2CYCIbtS/e1PV/XOPrQCU3AJsdC4mG/IYkvLirPanwZg/BQbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB7757.namprd11.prod.outlook.com (2603:10b6:8:103::22)
 by DM3PPF341F90799.namprd11.prod.outlook.com (2603:10b6:f:fc00::f19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Thu, 17 Sep
 2026 20:10:16 +0000
Received: from DM4PR11MB7757.namprd11.prod.outlook.com
 ([fe80::f3ff:11d0:7a52:db0c]) by DM4PR11MB7757.namprd11.prod.outlook.com
 ([fe80::f3ff:11d0:7a52:db0c%5]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 20:10:16 +0000
Message-ID: <e5e1d901-9cb8-44b0-a897-da48f12268bf@intel.com>
Date: Thu, 17 Sep 2026 13:10:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] perf: Add checks to prevent null ptr access
To: Peter Zijlstra <peterz@infradead.org>
CC: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers
	<irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Andi Kleen
	<ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>
References: <20260904181625.1394082-1-vinay.belgaumkar@intel.com>
 <20260904181625.1394082-2-vinay.belgaumkar@intel.com>
 <20260917083951.GC2009045@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Belgaumkar, Vinay" <vinay.belgaumkar@intel.com>
In-Reply-To: <20260917083951.GC2009045@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0148.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::33) To DM4PR11MB7757.namprd11.prod.outlook.com
 (2603:10b6:8:103::22)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB7757:EE_|DM3PPF341F90799:EE_
X-MS-Office365-Filtering-Correlation-Id: ee4cd68d-5001-4ab9-2479-08df14f7b093
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|7416014|10067099003|6133799003|22082099003|18002099003|56012099006|4143699003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: gRbRVMXhtJ1RsiJYE7sf/t9voZiyjBouXcTbtXyb3ykWjC79cOQL2uxPNR0ly/4bTtiBkKEHPmRhD5n7Fd87Pcfv5VuL7nBbe8Wghzx26x3nxp4BuXaHYvr92pvp1uOSx1NjeWFUdjMKNDkRyLWVXvTcPwClngKbLXsbCo1Cv6X0gVYmFx5AQZQCmowy8JrmDhrOaSICoOp3cbucHVAC2m7NtFHM+TFBhOtYNpEZCYkoGGmiR8Qgg+kdKktOgUUz4nU61RbP0WTktp9N/ER4fi7CoVog9wKFBaFgmgEQVJSGl+vKbNPPOmIzGojgsZof8qJb7if6L/1AJfSlUrn/xnM4245GIvoM7zt0T2JFVSMlMtpB3ukHk70JyhRpyZ20ct58pXZIzLzgiInPidyd0Gd+2zf0lH8xS/gZ9oasnr9IGu7I+3WaiXpPSH6OmqxnVsVoHTLqJUpZVQH8Xdx2vsd0BxoRkfSJ71YrqqadL0E9sOx4tMx2rTIi3NvIvD22pOK7xz5gqeO59GD6QfaswvtoSof3duHCfurJIscGxU+2JG0ZyWZUsOcUXtWk8ZV8TNBrjLZgLRw9NqncCRZbSx++ZCBLBQV+gSXm8Ybv0mq2+WdEN433miIqCYLgu0MvvvMltuwYwOS6r5U8uEsPs3b6Zqzww9QK+nKr6tW9TUI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB7757.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(7416014)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnljNUlWM1p5bU5aUUlNK05haml6Z1hSdWZwMnRydEUxLzVIdmxKZ0VieU1K?=
 =?utf-8?B?amsrYVZwekJtWUpDVGo1Ui9BbVNzUjAyMnlUMk9sVzJwYWZ3aHlPZDdUMnBF?=
 =?utf-8?B?UjE0OFlaQngxSEJuWmUzVkVQZUt6ODM3bHBBS29YVmNPczJhbzdmbUowSnBy?=
 =?utf-8?B?bzVNU281RW16S251M3NKMkUvZXdXTmpjOXNyd3U3dWNGWituclFaSEIwekt1?=
 =?utf-8?B?RUxGaXNtTmExZysyYm1vNUx4MWVabis1djlqSTJyc3RkajVFT09kazlud21i?=
 =?utf-8?B?L08zVlQrdjZKT3ExdTlrbFFCeDkybjluZmFibVJWUkczcmVHKzdJSll2eVdM?=
 =?utf-8?B?bGZmMXdxNDJNVk93cTBuN2d4TVJsUGFBMDlFRFJBZndPL3YwSkNoZFdWZmlU?=
 =?utf-8?B?RkU5VGdYMGZkUkdaSUNINWc4M2lIUTJrbVIvY2RoSGRGNnE1aFBWTTEzaDRM?=
 =?utf-8?B?L1oydGpYK284VWpUV2l2UFRnUEF2UzNGYUUwYzRMZ2Q3YThSWUxlNytpOXBZ?=
 =?utf-8?B?WVlIRDMzWm51WFFHbHBxd0s2bnJSR3MzM1lkZSszVzRtWGs1RnA3ZktDS2t6?=
 =?utf-8?B?T3BLVmNlMHRHL2FFb3FjWjd5eG4xdzZMQ1pIcWM3R3d5VG8xU0o5T1ZUa0pa?=
 =?utf-8?B?bkx3RmlKVERubnFWWkV2OVNoNGV0Yy8vc2FUNFNsY2FsWmQzdVBlWVYzaTU3?=
 =?utf-8?B?UXQ4U1lnUVlNeFhtcFRTdHBDWkdadlZmM1AwVWpKc1QvdGppWlVlMVNuWWcz?=
 =?utf-8?B?WHNKenV5ZWdDR09lY05qbWFRS2NZN1RoRTBZVXVQVXdVbWhYY3ByNkxuZk8r?=
 =?utf-8?B?bU1md09uUDVwOGxDQjZ4TGU1MXdGbnVGUy96Q3c4STduUzExTE1QY25GaURk?=
 =?utf-8?B?L2hSdGRsWEtYanY5MUd4VC9wRTJrT1hkQ2IvNmlHOFUyd3VzbnhsVGR5aVMx?=
 =?utf-8?B?blB3NStMenNIeWlLbVh5M3hBMSswRnJja2J6emorcHJVbU11QS9adTFveW5J?=
 =?utf-8?B?dWJOSVQ4QTVoV3FSNTZHM3M4bXhiNlJGYzA4VXBMV2VCZjZOcGsyM0dPSzE0?=
 =?utf-8?B?RHpTQko2SmdzY2hScitJMmptUUdNVys2NmZUK2hWRFVocS81dG0rU1N0REpS?=
 =?utf-8?B?ZW1qNWJQZStsT09RYk1rS0dqdUZHbE1RQkZ2OTVkaVd0Qzd4QTBzZlFOZC9R?=
 =?utf-8?B?NWRCMk1DTi9qbmduaUJwY0xORjEvd3ZteGY5amsvWDZ5Q21NdGk3eUdZOS84?=
 =?utf-8?B?TkxUOW4zUkdNcGRJNmI1MVhpclhNUTdZTnR0elRpbUUyWFBDSWNIenBOZDl2?=
 =?utf-8?B?a1JUT1c2YnMzWllzS2wvWnZGMGZQTHlpcThoSGRmak5CbVhqRjRiWDVPNVBF?=
 =?utf-8?B?WlY4RGlva2FDakFUKzRkMnhOWFR5SnI1THZEbFYrQTBjcVE1WWl5ZTJ4MGxi?=
 =?utf-8?B?Z2RBeFE5N0MzMTZpdVlUUWpnYkFjazI2U293UmU2L0YxbFo3VGJBM2dYNkxT?=
 =?utf-8?B?UzJCN2trMVN4aTRZUWtEa2Y4azI0bkU5cnRNSlpSOXo4c0tSeEZmK2VaRnow?=
 =?utf-8?B?NmFwR3UrS1ZNa1R5aXV2Z0pMWWkrR1pyb0UxSVZ2TzdSZXFZelhtMWJCRU1C?=
 =?utf-8?B?TE1SNGhtYjR2NVp2ZjdSUk0yY3FzWDdTeUNkd21LNlBTZm9BNEYvSGV2Uktt?=
 =?utf-8?B?bDVwc3JFM3hxZW5oT0FKTHloemJnQ3RMZ1hSd3RuS1VCWjFnQzBjYndwME4w?=
 =?utf-8?B?TFNnTHUxUkVITVlhY3M3UUd4emc5TStuYU5hdFlzdlJMV1VXYytsbEI3dE5k?=
 =?utf-8?B?THNGa0VRa0RUNnQxa1NjaWVhVkxLcm9kcU9QNHVoV0FETlYrNkw5V3RSbE1F?=
 =?utf-8?B?U05HRGxHU2RWdWJ6TW15cFlMSXZzVkZRQkZWV09VSnVBUG9zMWQxNUpNRkM5?=
 =?utf-8?B?Zzh6RFIyR3R0Mm9WMUhDYWM4aS9DZDNjUzF3Smw1U0FlanJUTlJ0WTRpdW9M?=
 =?utf-8?B?T05sWUFxdG8raVNQbSs0bUNyTzBRTHZpeWVpZk1DYU9VbTV6bGgvM3RNUE9U?=
 =?utf-8?B?Tk9sOXVLdUZ3Mm8ydTRFSWFxOTBQRHh5NmRwY3FZYkk4a1Z6ZGRCMFpZV3Nj?=
 =?utf-8?B?YWhxZHBlNVBwRHlSZ3hSeGovN2FFN01IOWZXWTI3d0tBdytlYTIrWjBaVDR3?=
 =?utf-8?B?QmdnM25nMURya0RQU2xuYkRxK2dHeFJSMGpZYWw5d2NIRTFUMmhoeWkxbEdI?=
 =?utf-8?B?c0dvcUNaZEZUeTNLNzlvOXBPWXY5QU01ZXUydUNqQ3dOdllEd3o1WkYvemJ3?=
 =?utf-8?B?WEp5cUR1MkNPUjh3bXBUZnVsOWwvM0JiQ2ZweEFLdm5sSG1pTThFSm1NSWFo?=
 =?utf-8?Q?aQe4nmNnInj/8CMc=3D?=
X-Exchange-RoutingPolicyChecked: X1nR5fhDyFH4zVwx0xCuKrscNnkQbzhmRHaNs7y15CKkjX1SFEE2L+wGCzs/XQu4rZLeIG6UieYB8eyE+8ezCUphXn41vrKgpIL0oiu4KF5JWaWIgGr2D7T/Nkhet9thbK6nLPmU8I1uNCoZ0TaY4Er9ZqpG4TSA0PF6rXsDajkKaJuNO5vRWGEzLstjI+yeMPRILI9QRaYC5ak4wXqvc5aUlIUzT8Hi6sydyR9DIlnnj/Sk8kgIFDJkjGAcxuwmCHlzpTYcAlVFaWvIxwyfy3l2pfvnEXJUlGSW/tPH8I5z5rOavGb3Lge25fneZWq3GU92xrLYIYE6M2IR0mFXXA==
X-MS-Exchange-CrossTenant-Network-Message-Id: ee4cd68d-5001-4ab9-2479-08df14f7b093
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB7757.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 20:10:16.3701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q0mYq3kB4C7/T9ZlDzTylf5DuEduvwvvlLaLKkZnHthWFsqchbh0eAp5CNSn10FAB3CFPRYeYnfkON4RRJsCRsUGet5vrlaEXdiDY7C2BtA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF341F90799
X-OriginatorOrg: intel.com


On 9/17/2026 1:39 AM, Peter Zijlstra wrote:
> On Fri, Sep 04, 2026 at 11:16:25AM -0700, Vinay Belgaumkar wrote:
>> Sashiko recommended some additional checks to prevent null pointer
>> access. Check for revoked states inside perf_event_read_local(), as
>> the pmu event may have already been freed at this point. Add a null
>> check inside __perf_event_read_cpu() as well before accessing the pmu
>> ptr.
>>
>> Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Signed-off-by: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
>> ---
>>   kernel/events/core.c | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 7777e82aad5e..059f82f0cadd 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -4788,14 +4788,19 @@ static inline const struct cpumask *perf_scope_cpu_topology_cpumask(unsigned int
>>   
>>   static int __perf_event_read_cpu(struct perf_event *event, int event_cpu)
>>   {
>> +	struct pmu *pmu = READ_ONCE(event->pmu);
>>   	int local_cpu = smp_processor_id();
>>   	u16 local_pkg, event_pkg;
>>   
>>   	if ((unsigned)event_cpu >= nr_cpu_ids)
>>   		return event_cpu;
>>   
>> +	if (!pmu)
>> +		return -ENODEV;
>> +
>>   	if (event->group_caps & PERF_EV_CAP_READ_SCOPE) {
>> -		const struct cpumask *cpumask = perf_scope_cpu_topology_cpumask(event->pmu->scope, event_cpu);
>> +		const struct cpumask *cpumask = perf_scope_cpu_topology_cpumask(pmu->scope,
>> +										event_cpu);
>>   
>>   		if (cpumask && cpumask_test_cpu(local_cpu, cpumask))
>>   			return local_cpu;
>> @@ -4917,6 +4922,11 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
>>   		goto out;
>>   	}
>>   
>> +	if (READ_ONCE(event->state) <= PERF_EVENT_STATE_REVOKED) {
>> +		ret = -ENODEV;
>> +		goto out;
>> +	}
>> +
>>   	/*
>>   	 * Get the event CPU numbers, and adjust them to local if the event is
>>   	 * a per-package event that can be read locally
> I don't think any of this is right.
>
> When unregistered, the event is de-scheduled, this means event->oncpu
> will be -1, therefore __perf_event_read_cpu() will already exit early.
>
> And perf_event_read_local() will then already do the right thing, by
> returning the old value.
>
> So AFAICT, there is nothing to fix here.

yeah, I think this was more of a defensive fix which Sashiko suggested-

CPU A                                                  CPU B

perf_event_read_local                     ...

__perf_event_read_cpu                  perf_pmu_unregister

I don't think it is easy to repro this situation, but there is a 
theoretical possibility of a race between these two functions. I don't 
think even the changes above can guarantee to work in any case. We can 
drop this second patch if that is the case.

Thanks,

Vinay.


