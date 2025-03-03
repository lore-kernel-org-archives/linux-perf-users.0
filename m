Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1061C84A0;
	Mon,  3 Mar 2025 17:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741022425; cv=fail; b=AMSpdWlXzgKOPWGmfABcv7A6JsSrCRKBoJjtAihFlU6x5chM8mhSh+WMClkUkXEYnOEAUrjnMEohF3e9/sWN/G6Ubk1p4JAkfGacr4jvNh1g0Fkkw9VTbaaVvMaGtgGyXH/GQNGmtZ8vIz1NynAWQFOD4cM+Q9DQAqXnHA8meJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741022425; c=relaxed/simple;
	bh=T3b/eCZD8A+wuXCXADZl6PqDBiP9SLrflK5RBK4rMHQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZrkqN8NqLARglVPuQiM/mEomYzdBhqA59wFyJDdJQA+so3yZR3V6uk8sWaP3GUZP2daiz05Ir7AgIKyMQG19T0R6fd692YXmsSwW6QXOw6+r+kQwVKdthohf1Z+lwPaemvsg+jw4DW4PucH+/OfvxJv6A5XSs0EwpaYvoyV6LB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c63Bz6Wh; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c63Bz6Wh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741022423; x=1772558423;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=T3b/eCZD8A+wuXCXADZl6PqDBiP9SLrflK5RBK4rMHQ=;
  b=c63Bz6Whp8h5azGeDhBDpJmW0FpgDvDlv+hVKOtJH4BoaQ+kNNzWJL8A
   PrLBrBGWrLYLHDg0xx7uQd91OXKgCTdEvsnUjfhp2y8nF8kyy0/AKMflh
   tUZ9hFzgYIQ1suPSxEgNccOtU0rHiMwcZaBoW/8XiKxmbS/XSGROTl438
   RqG8eCabl1sUAPVTDFZPiJssQBJ97qg0r8fGk7sgT2MjeCCT65E/dpeuG
   XfELWsGlaDivw245F3BIcocuPZukX9zZGWEYEzaq4DXfv3Dia0/aWW6JH
   0dY0HNK2sk6xzYQ2lpM6HmsK6Dt+024AE7n+oxKqZ92L2/4NJN//aI7AZ
   Q==;
X-CSE-ConnectionGUID: WYUeMrPHScmTm6cjwLB7hQ==
X-CSE-MsgGUID: 9hDSo0gBTEG23XHyaK1GRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="45558726"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="45558726"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 09:20:21 -0800
X-CSE-ConnectionGUID: 5mUjPYn1TP6bG4flFklBJg==
X-CSE-MsgGUID: 00wXwWpgT2OmYxfSuA579A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="118586233"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Mar 2025 09:20:20 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 3 Mar 2025 09:20:18 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 09:20:18 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 3 Mar 2025 09:20:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yVBBuu96O2+QtJFAPaAaO7VlnfNTSZ3TIb33shex0wfDRSk5WaHVZ9lDpPtC6NGxBRRpHA+g3L50lqpJ1q2xn9gBL1Zvlmd/mvZsF00CtMaWnyv+YMYQ0zmUApO7ow9xqpaYxwkVWDrs1weiGH1etTG779kuViYZj7sUCTnn/m5dMoQ+NIqcODP6n+jrQE53y2+XmjkW6goHKAnMHM9GqlCH4t3HHIcLbD/aEJjFKG/sq3j/OEnlzoF+TFdk2a9wz+D63yajJ6oRbYWTW0SdUYo5AfkA3oHIKI99+oWMwOlM8fysuSUnvdns7P++gT8bdNxO7pX1zZ0SX8W9l4YjnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3b/eCZD8A+wuXCXADZl6PqDBiP9SLrflK5RBK4rMHQ=;
 b=mvVaeCXAytZ5UuVb8Whg6/FRwvERbrAdWKSpAUILTj3okxusWC+JIxCZc0z3MdUuQQlxlOAC4WDll8ddtQ69edl0GTdySqIhq+StHuj94p5suPMWTcwSru8qWdpV3Jc+QAocTqAp79CqzeW4B4J4sk6ySL+eVWJTh4HHYoXY9JVrW27odINCp0692e6VQEbpJKWBVcM5rzbx/U8KbLlJXthIPQu6Z41WMDFd/ELYv7EUuYLEAGsirOfP4V5hiKaVjI+AeQwZEuW9e8SnCvP799EHAbJmE34gWqhDzaCWRi3PkpZwOL26ehnxOjvqYRY0b5eetUL2DzzhG+oG3bNbBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by PH0PR11MB7494.namprd11.prod.outlook.com (2603:10b6:510:283::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 17:20:15 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 17:20:15 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "namhyung@kernel.org" <namhyung@kernel.org>, "james.clark@linaro.org"
	<james.clark@linaro.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "irogers@google.com" <irogers@google.com>
CC: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"yangyicong@hisilicon.com" <yangyicong@hisilicon.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "acme@kernel.org" <acme@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>
Subject: Re: [PATCH v2] perf stat: Fix non-uniquified hybrid legacy events
Thread-Topic: [PATCH v2] perf stat: Fix non-uniquified hybrid legacy events
Thread-Index: AQHbiF6scPWrR33d/02iCI3xaP1bqrNhsE6A
Date: Mon, 3 Mar 2025 17:20:15 +0000
Message-ID: <092a915aa9bc67b007ffd3ff6f53b0716426c532.camel@intel.com>
References: <20250226145526.632380-1-james.clark@linaro.org>
In-Reply-To: <20250226145526.632380-1-james.clark@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|PH0PR11MB7494:EE_
x-ms-office365-filtering-correlation-id: 2a61606b-4de4-43d7-4f87-08dd5a77a9f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?R1JpSXlhYTh5V1BpMEFSSEJ4Wm5NU2xYVm8yamFOcEtCNVgwVjNaazgzNVhD?=
 =?utf-8?B?dEtqeDJWUWlQSkxTSHVzMWlQc1BNZjRXbTBmaWRXekxEa2pSVXg3WFJVRjZt?=
 =?utf-8?B?RE5yZ3ZDaEhPN08zbHRrZjFzdERNckNmYk1GY29JTktBaEEvZ0M4bm42RDJz?=
 =?utf-8?B?RDlyTis1Q3JmQWgyQ1BQZExpcTNkcll1UkJ6WkwyN280TWZIdjVHREVCS2h6?=
 =?utf-8?B?Q1VYNXI2T0Y4eVRkcXhiV2xyRGFvQnZhOFNqZmJlcXJFTWpvelF2ZUQrenI2?=
 =?utf-8?B?T2l0VGZmUmo4Q0QzQTlXaEhhTlZDYlcycGJPZzB5d3Z3bHJzZWN6Znh3Mkwv?=
 =?utf-8?B?cysvRzUvSWxFMkRqVTI2SW81VzJTYUxUZWp3d1NCemQ0QjJscGJLUS9RNTFS?=
 =?utf-8?B?STZkOGdLZ1RCKzIzN1NOanpGN0dYaW1vL1o0T2NHMG4xdThrTzlYZFhSNy9h?=
 =?utf-8?B?MWhtaFhRRHRLWHFDY0UwMmVETWlRQTNySXR0Mmo3OUdKN3djeXNVbDBUUENx?=
 =?utf-8?B?SVFzY1RYMFRHckkyWHV4azBsU1lPN21ocnZDckllWUJvT0F5T1JBcjV0UDBk?=
 =?utf-8?B?anFuUHVYMVlzb1J5MjNkdHd2NjY5dG53d29VclFRZmcvSXhINFVwWDdsd1hl?=
 =?utf-8?B?QlMvZllaRVU2VERha0VvWGNGZ0x3a3FEeDM2UC9HYTBIQkpYVmV1U2ovM0VB?=
 =?utf-8?B?UjROeWhzRFJCMUR2LzRvV2lid1ZjU2xKa3dhNlpydzY4NUtzYVU1cmdMMmgz?=
 =?utf-8?B?RGtKK2luK0hKdjVJWHhJcndJVFo5ZHNlZUhBbk13aVJRSVpBNENlUDFWbjJi?=
 =?utf-8?B?TldGZFJSOTJpRTRlVndWNEJxZXh1bEIwM09ZL01Fa2xmQXVCOHRBak10Rzd4?=
 =?utf-8?B?VVc1UU1NUzFzR1VTRWlKYnZLNUVtSFFTaEJaMko3aEh6bmxFWHJqZnJsL1dn?=
 =?utf-8?B?MzBxZEpqek5TRlNLdEZicVovYWlqQmc4RlMzTzJvaTV3dDNtQXkrWmwreWp2?=
 =?utf-8?B?ZldTWmdLbzdjdUZxcWI5K2c2RExHa2p5RFFoMnJXaWNvRkNGRytUVW03ZXg2?=
 =?utf-8?B?eFlxRUlaeEczZ2VaOHg0cFRaZjZrVDZRdEl5NHE5Q0hRVDFzdnRaTVUzWHRh?=
 =?utf-8?B?aGEwc203MDRDN2puS0RjSmVjK0xnblh5Snp4ZjJyRy9ITW1kM2drZlZrbUhF?=
 =?utf-8?B?dzl3bGlJU1B0bnEwUjJrL3VpMXNDbGk3aWRwN0k4cEY2Tnd4amNkSGE3VHJJ?=
 =?utf-8?B?dmx4OGI4MzB0V1ZzYTgvS1RReUN0OHdPb2dId09ieGlrQk1UeW9EbVo0eGNh?=
 =?utf-8?B?MnpZeEZlVytGdjNSSURZZWJnanVpendaMm5sY0RqblVzcVBWaFpHckQyWFhp?=
 =?utf-8?B?STVDSUhZS2sxY2phdlRGZFpETFBGUUFnUjdCSkRqd28rWERuZUhzRnRPaERl?=
 =?utf-8?B?TjJJam1yYlhyQVlVM21OMWtpVDhZbTR4dkRUZkxzZXpYS2J1RXJUQ0pnYkUr?=
 =?utf-8?B?OFpoQlh4M3lYckQydG0zbkJ1QjV1VVlYZHlselFUUnVGZDA3TElpVFMybVRD?=
 =?utf-8?B?bFJORXpQVkhxa3JKYnE3SjY2ZTk1dFg0OFd3SnlscG9NYjVlYVRkdUhxWkM0?=
 =?utf-8?B?MEM3Z0lxQUtVWUxOU01DTTV4WnFWelNMaXhOamdQRXo4MmttSmEzSWVvRGhV?=
 =?utf-8?B?OThiWVZGZm04amtpbTlVL0dKSmZQNWlWUk9tMzlJZW1yalZqTmpzU3ZIWW9m?=
 =?utf-8?B?VnZJOTU5ZHFkMmcrcUJDZ2NYVDZtSC9aZFBpUVF3aXBFcDE0R1g3QUNJQUpu?=
 =?utf-8?B?VFNWSHpMQkM2QzFneDU4MkttaGhmaWVQZi8zZFhJZnlCODlPOEtPS0hsYlNC?=
 =?utf-8?B?T2NDK0ZQTE52RDhMMnowSFpPSndzVHVoNUNmUkF2RCtvcUNZdGdWdVRmTEVN?=
 =?utf-8?Q?cPWf4yRceTaszvk4u199ve/b+G8CwEqf?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0Q4RGpHR3c4bHlEMVVzU0xFQ1N5U0VZZUdlMjIxN0xOdk5nR3Zid1FiQUZU?=
 =?utf-8?B?b1UzWUNUcHFwNWpzYjloWStjejUrYmMwUHlkdStHNVNsNVJFWW9GNXBKV2po?=
 =?utf-8?B?c09MUklMSENwOHU1UWtOQW5US1JoRlllU2xGczlMQXlwQ1kyUVprTEc2UHpK?=
 =?utf-8?B?c2tLdk1jK2k3cnRCN2hzWGhJdUVFMnk3Y2lMNm8zRWdreGRTWXNrN0VFYnZK?=
 =?utf-8?B?bi81Q0hSVnoyVy9teHFJeEd3QXlqUCsvdVhKQzN4QXNEaXBacTF3cUFFWlZR?=
 =?utf-8?B?MnZaVVNJSEVyajljUlVnMFNFUEhtQ1JKeDRqT1FrUWtvUmliWjdYSmRaWVRj?=
 =?utf-8?B?Qys4YUJTNXljb0g1eld2T3ZpTUtrSmpvN21BRTZTYTBLNWlLWllsaXFtRW85?=
 =?utf-8?B?bGczakY0ZUxQRDJYd29sa211WkZrNVBFTHdpc1luN2pwOHcwV25EV2tOU2Za?=
 =?utf-8?B?RVB1cEZVY3B3MjVmL0FQZEdERkdJSEZtT0IzeDBIUG9WYUp6MTl6S1NrUkVo?=
 =?utf-8?B?YUhvQ3dla0N5RXpJOEd4YnVuY3Z6YnJCWUZWTUplRDJiRWl6NjJLYkk3UFJm?=
 =?utf-8?B?aVUxcWpmUzFRNktJTHQ0MHdzVVV2bHJ2emxWam4xV0tkSk5YamMzSnlLMGZF?=
 =?utf-8?B?T2RqSW1tcndyRVdWeC81WkhMREloZ0FmTE90a0JzTm1SQmZrdnpBYUQyYmh0?=
 =?utf-8?B?ZStlTi84cnN3S1JHbDRQOGZPQi90ajFkc1A1aVdOSXVXUXRRTW02ek5PQk1p?=
 =?utf-8?B?Vnl2cDZwMGVkWWVqOXNpVitMbkszcjdWcDlIckxIUUFRc3dyMkNoUGE0RlQ0?=
 =?utf-8?B?QitSSWF5YjhjVlpYcWZIRHF0OGRlNGVBMEFML3F5dkZnRFBIdVVUNkd6aTYr?=
 =?utf-8?B?dThqTnZONnlxWGlSbkF5Y0N3R1oxYXBOU3lpNlVOWkpkM0dSSWsvWFI1KytU?=
 =?utf-8?B?cVJpclFJSUhpTTFTbUpJaHZuTWlXem1nRis2K2dSMmRSWlBrQ2NtOERkUlU2?=
 =?utf-8?B?R0hBWGpBRVpobVdsT0NKNFhvaFQ1cDFWMzR0aWRmQmFsTk8xbFp2L0E0QlV6?=
 =?utf-8?B?VFVxeWQrM0QrQlNSRDJMajdjM2hsSUoxRDg1NjNYbHI4cldHa1UzeVR4bVpu?=
 =?utf-8?B?b1dTSmFJU1l1MUpjU1VZNnJPV3NKQU1DWlFqOXVveUdoUDUzRHBJUFNaNXYv?=
 =?utf-8?B?UmVMajBYdTR0WnNaNG03Y0E5UHJZWUhVTnVWTURoQmFSTERUUUQyR1NpL0lD?=
 =?utf-8?B?bmd2ZldMQS9DUSt6MDcxY1RiS1dBMzFXeXVDeE9waFhMQSthOUkzOWgzL2U5?=
 =?utf-8?B?MkxidEJ6d09ra0VYMjMxanl3YVU5SmlrdGlEVzNEOVluczVIRSswaEYvNlJ2?=
 =?utf-8?B?ZjEweE5EeWt0ejIyUW5mR3ZBWUhpY2FFbU4wN2t3cis5VGd5V3krNHBISXQx?=
 =?utf-8?B?ZzMrS2dBRGdNS2JqaUcwWjltbXJoRVNQemtYVnVIZjVNQU5hQ3NIc1AySkM4?=
 =?utf-8?B?QTN1djZDUXhsQUJMVTVwZ20yenNzU2ZtWVovRmVtN041NDVNeFREL200RGts?=
 =?utf-8?B?UE9Pd29FUGtvSlk4ditvY2dFazFGaGR0QUlFRmk0azlobE5nNk00WVNyYUN0?=
 =?utf-8?B?d2pKRGxUTUpkaVFNanc5YkRUbldGTU9RdUQ2RlFJb2NteFlxc1ZhRm5aY2Vl?=
 =?utf-8?B?MGtpbU9NWitrM3A1RFE0U3psQmV1ZHpLcjlsZnkxT0IrbkQ0NDQrbDFsby9o?=
 =?utf-8?B?VkJYa1NRVjhWZGEvcDR2MFJPL3NHeTVTUTNrVDMyVmFYV3dWVjZ2b0twYTNy?=
 =?utf-8?B?MlVmSTJka0xzWlV6VDY5dENjazA4MkNmbS93MzFDazBCckJhNU5mQk1BRFRX?=
 =?utf-8?B?RTVlR3piOGNKOVpNZXpuQ1BHSW1ZNjk3V3ljU1Y2UjlydG1vRGFQUzk3YUtQ?=
 =?utf-8?B?KzFJL3Y2U1pKaUR1L0JiOFBpL29mTGlKN2tkWERnK1RzRk0vOXdsYTc3ckJz?=
 =?utf-8?B?ZVlCeEdsRkFzWGV2K1h6SXJKTHhjZlhSTk5KVDk2eStwejk5bjErN0NpYitL?=
 =?utf-8?B?VzhOcXdyVzJMNEZJaTRkUGtQMG9ZY3JWVnpXVTRuaVA5cGhMRmkzRVhidVQv?=
 =?utf-8?B?ZmxnRDVvdmNNRk0xL2d6VVJ3UEhxaU9YSjJEODBuRVFzTVdJK1BrQjc2RmhT?=
 =?utf-8?Q?5J+cWVX29C+tWT5fhQj7OPg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <807C08100CD6C14F8F775B476F644227@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a61606b-4de4-43d7-4f87-08dd5a77a9f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 17:20:15.4918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OgKiKsDOwqskFeWIW7HvuYCUySuzvQrSOQzuCbfzKyk9L6FgxdGBU7hAt2DASh5USQIxlumRVfYwLlgkWLHNAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7494
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI1LTAyLTI2IGF0IDE0OjU1ICswMDAwLCBKYW1lcyBDbGFyayB3cm90ZToNCj4g
TGVnYWN5IGh5YnJpZCBldmVudHMgaGF2ZSBhdHRyLnR5cGUgPT0gUEVSRl9UWVBFX0hBUkRXQVJF
LCBzbyB0aGV5DQo+IGxvb2sNCj4gbGlrZSBwbGFpbiBsZWdhY3kgZXZlbnRzIGlmIHdlIG9ubHkg
bG9vayBhdCBhdHRyLnR5cGUuIEJ1dCBsZWdhY3kNCj4gZXZlbnRzDQo+IHNob3VsZCBzdGlsbCBi
ZSB1bmlxdWlmaWVkIGlmIHRoZXkgd2VyZSBvcGVuZWQgb24gYSBub24tbGVnYWN5IFBNVS4NCj4g
Rml4DQo+IGl0IGJ5IGNoZWNraW5nIGlmIHRoZSBldnNlbCBpcyBoeWJyaWQgYW5kIGZvcmNpbmcg
bmVlZHNfdW5pcXVpZnkNCj4gYmVmb3JlIGxvb2tpbmcgYXQgdGhlIGF0dHIudHlwZS4NCj4gDQo+
IFRoaXMgcmVzdG9yZXMgUE1VIG5hbWVzIG9uIGh5YnJpZCBzeXN0ZW1zIGFuZCBhbHNvIGNoYW5n
ZXMgInBlcmYgc3RhdA0KPiBtZXRyaWNzIChzaGFkb3cgc3RhdCkgdGVzdCIgZnJvbSBhIEZBSUwg
YmFjayB0byBhIFNLSVAgKG9uIGh5YnJpZCkuDQo+IFRoZQ0KPiB0ZXN0IHdhcyBnYXRlZCBvbiAi
Y3ljbGVzIiBhcHBlYXJpbmcgYWxvbmUgd2hpY2ggZG9lc24ndCBoYXBwZW4gb24NCj4gaGVyZS4N
Cj4gDQo+IEJlZm9yZToNCj4gwqAgJCBwZXJmIHN0YXQgLS0gdHJ1ZQ0KPiDCoCAuLi4NCj4gwqDC
oMKgwqAgPG5vdCBjb3VudGVkPsKgwqDCoMKgwqAgaW5zdHJ1Y3Rpb25zOnXCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgDQo+ICgwLjAwJSkNCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqAgMTYyLDUzNsKgwqDCoMKgwqAgaW5zdHJ1Y3Rpb25zOnXCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICMgMC41OMKgIGluc24gcGVyDQo+IGN5Y2xlDQo+IMKgIC4uLg0KPiAN
Cj4gQWZ0ZXI6DQo+IMKgICQgcGVyZiBzdGF0IC0tIHRydWUNCj4gwqAgLi4uDQo+IMKgwqDCoMKg
wqAgPG5vdCBjb3VudGVkPsKgwqDCoMKgwqAgY3B1X2F0b20vaW5zdHJ1Y3Rpb25zL3XCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgDQo+ICgwLjAwJSkNCj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAxNjIsNTQxwqDCoMKgwqDCoCBjcHVfY29yZS9pbnN0cnVjdGlvbnMvdcKgwqAgIyAw
LjYywqAgaW5zbiBwZXINCj4gY3ljbGUNCj4gwqAgLi4uDQo+IA0KPiBGaXhlczogMzU3Yjk2NWRl
YmE5ICgicGVyZiBzdGF0OiBDaGFuZ2VzIHRvIGV2ZW50IG5hbWUNCj4gdW5pcXVpZmljYXRpb24i
KQ0KPiBTdWdnZXN0ZWQtYnk6IElhbiBSb2dlcnMgPGlyb2dlcnNAZ29vZ2xlLmNvbT4NCj4gU2ln
bmVkLW9mZi1ieTogSmFtZXMgQ2xhcmsgPGphbWVzLmNsYXJrQGxpbmFyby5vcmc+DQoNCldvcmtz
IGZvciBtZSBvbiBhIGk5LTEyOTAwLiBUaGFua3MhDQoNClRlc3RlZC1ieTogVGhvbWFzIEZhbGNv
biA8dGhvbWFzLmZhbGNvbkBpbnRlbC5jb20+DQoNCj4gLS0tDQo+IA0KPiBDaGFuZ2VzIHNpbmNl
IFYxOg0KPiDCoCogTW92ZSB0aGUgZXhpc3RpbmcgZXZzZWxfX2lzX2h5YnJpZCgpIHRlc3QgZWFy
bGllciBpbnN0ZWFkIG9mDQo+IGxvb2tpbmcNCj4gwqDCoCBhdCB0aGUgUE1VIG9mIHRoZSBldnNl
bC4gTG9va2luZyBhdCB0aGUgUE1VIGNyZWF0ZXMgYSBkZXBlbmRlbmN5DQo+IHRoYXQNCj4gwqDC
oCB0aGUgUE1VIGlzIGFzc2lnbmVkIHdoaWNoIG1heSBwcmV2ZW50IHJlZmFjdG9ycyBpbiB0aGUg
ZnV0dXJlLg0KPiANCj4gwqB0b29scy9wZXJmL3V0aWwvc3RhdC1kaXNwbGF5LmMgfCAxMiArKysr
KystLS0tLS0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYvdXRpbC9zdGF0LWRpc3BsYXkuYyBi
L3Rvb2xzL3BlcmYvdXRpbC9zdGF0LQ0KPiBkaXNwbGF5LmMNCj4gaW5kZXggZTY1YzdlOWYxNWQx
Li5lODUyYWMwZDk4NDcgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL3BlcmYvdXRpbC9zdGF0LWRpc3Bs
YXkuYw0KPiArKysgYi90b29scy9wZXJmL3V0aWwvc3RhdC1kaXNwbGF5LmMNCj4gQEAgLTE2ODgs
NiArMTY4OCwxMiBAQCBzdGF0aWMgdm9pZCBldnNlbF9fc2V0X25lZWRzX3VuaXF1aWZ5KHN0cnVj
dA0KPiBldnNlbCAqY291bnRlciwgY29uc3Qgc3RydWN0IHBlcmZfcw0KPiDCoAkJcmV0dXJuOw0K
PiDCoAl9DQo+IMKgDQo+ICsJaWYgKCFjb25maWctPmh5YnJpZF9tZXJnZSAmJiBldnNlbF9faXNf
aHlicmlkKGNvdW50ZXIpKSB7DQo+ICsJCS8qIFVuaXF1ZSBoeWJyaWQgY291bnRlcnMgbmVjZXNz
YXJ5LiAqLw0KPiArCQljb3VudGVyLT5uZWVkc191bmlxdWlmeSA9IHRydWU7DQo+ICsJCXJldHVy
bjsNCj4gKwl9DQo+ICsNCj4gwqAJaWbCoCAoY291bnRlci0+Y29yZS5hdHRyLnR5cGUgPCBQRVJG
X1RZUEVfTUFYICYmIGNvdW50ZXItDQo+ID5jb3JlLmF0dHIudHlwZSAhPSBQRVJGX1RZUEVfUkFX
KSB7DQo+IMKgCQkvKiBMZWdhY3kgZXZlbnQsIGRvbid0IHVuaXF1aWZ5LiAqLw0KPiDCoAkJcmV0
dXJuOw0KPiBAQCAtMTcwNSwxMiArMTcxMSw2IEBAIHN0YXRpYyB2b2lkIGV2c2VsX19zZXRfbmVl
ZHNfdW5pcXVpZnkoc3RydWN0DQo+IGV2c2VsICpjb3VudGVyLCBjb25zdCBzdHJ1Y3QgcGVyZl9z
DQo+IMKgCQlyZXR1cm47DQo+IMKgCX0NCj4gwqANCj4gLQlpZiAoIWNvbmZpZy0+aHlicmlkX21l
cmdlICYmIGV2c2VsX19pc19oeWJyaWQoY291bnRlcikpIHsNCj4gLQkJLyogVW5pcXVlIGh5YnJp
ZCBjb3VudGVycyBuZWNlc3NhcnkuICovDQo+IC0JCWNvdW50ZXItPm5lZWRzX3VuaXF1aWZ5ID0g
dHJ1ZTsNCj4gLQkJcmV0dXJuOw0KPiAtCX0NCj4gLQ0KPiDCoAkvKg0KPiDCoAkgKiBEbyBvdGhl
ciBub24tbWVyZ2VkIGV2ZW50cyBpbiB0aGUgZXZsaXN0IGhhdmUgdGhlIHNhbWUNCj4gbmFtZT8g
SWYgc28NCj4gwqAJICogdW5pcXVpZnkgaXMgbmVjZXNzYXJ5Lg0KDQo=
