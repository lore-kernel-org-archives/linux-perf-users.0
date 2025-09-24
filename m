Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBEB25394A;
	Wed, 24 Sep 2025 19:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758740975; cv=fail; b=BM3ps8fCrhmk5nxu5MMvrTRFvgGsF2esD7z6fuxptK/wMm7Ykl91pHf/DZZVlqqYbqHt7Je584P60aTDgy2X9ebTB0GymZwNboBaTZyF2VKMB34GEMtemjlj/uLdUzdonQ5eGRW5CvpVUHDcf1dF2Q43XaiRkzhgJZAhJahNZyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758740975; c=relaxed/simple;
	bh=Uq2swVOOXqsRGrJo5Uhv6yoBzVAGDybPmDidARA073k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cuv9cDczUcrYHPPcV2jqh8cSPPU8onOrvbQLGr+eNhYl+rxYSbwMqJ6NDcWumVAYncRBHTOY/gPOcNyFC5KTxqgZcloweyCU2cVxXSLn+e4i7yqdgdNvcfxwCTPeEr4hM7lutZeAzsMdicJ8GCMQBckPsQpvpgSaNu61QJCn8XU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VtGVn40V; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VtGVn40V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758740973; x=1790276973;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Uq2swVOOXqsRGrJo5Uhv6yoBzVAGDybPmDidARA073k=;
  b=VtGVn40V4FTv7mwyb6k+uBcnemmWVoOAU0yVWulEMIPaalHtA3QXtMRT
   myvPAWJDNF62/PXYFIGP8jr0lt4ZSnYP3HMnbXtcahJUQjIZTUI3et0/o
   As4bSp+PIL/Leb69peWbuHnnWsqZvGEZNOgvSjufNLKaaOhU3vNHLsU9G
   IuMimnWK8wjUYucMVZcuYN22EFOsDpb3zyCBBxhIYTIc+d2GiffG5OCfK
   5KUUy9bsIc6NVf4hVGBhC/gusNMNvfTeOh0Q/B3Q6f26NOT64fmWhca2h
   EF0LiToH+ppJYAVJ5egouwM/JqKO8pXNt81U/zkaqzVah+LAhnGy/vIpe
   g==;
X-CSE-ConnectionGUID: dITeDHVzTXiIQdgO6/aDMg==
X-CSE-MsgGUID: W2ee8fAyTkeZuQWOGEU5xQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64857149"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64857149"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 12:09:32 -0700
X-CSE-ConnectionGUID: KC/ucxIpTNiwic+8OeZHZA==
X-CSE-MsgGUID: yYqirYJtQxaq3N1ssKydKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="177544129"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 12:09:32 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 24 Sep 2025 12:09:31 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 24 Sep 2025 12:09:31 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.13) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Sep 2025 12:09:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dr9YASxGBozbyoJkGW8iyogJ28Q4+MCctIRE7EFPP5Bk/mTALI0Y0GlMAlRtVH/ETWxwTFeC+eFf3qRWnZhBIXWlit2+bWL5c585DqfZypgUW/Kws50Xlprs+v8zeJ2/iumBNv41BYD6NEUwYGfX/CupYyTQTewnu4IYDWb+YUqiJCInaWytsB6iqQ6AwiYcmkc5PJdFaE0lv6gnY5UtsOWEuAR755sPavSYfQ4SJ6k2yEa8a7BiC+W8d4vsVjJsitatsGO5haB3kCVz/jqOTVNNhUnMSBPkt1NZxopVaQDTty6Lwts/4o6mPBz6WZc+fUUlQHcuTrSM+pXO7Kzq0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uq2swVOOXqsRGrJo5Uhv6yoBzVAGDybPmDidARA073k=;
 b=oJzIRlAL44hXEX4wMA3jRJMNBTa2YOZWfJWWCwVqvSCjm1PDiIrqst86w7BJyK1eMyJlhv9TQ9JJC467b0X65DHDXXh1ZklNt+afN8yuO8LbNpVIdg+UblHm6/R+E2vwzTEi8A5GsAMtnUB/mS4ncGLl6lDEjIhaNRQLwKlMjA3yFixMywINypRUjwVUcWcaosGQ4KaNrZ/iIUMXFkFa8HLH3moK4NP1QsW4nulALLV7seaX1wVmTXJ7n/Dp+fCVLd4B+wLuv7Mdtyn8LjUck5ojUjCLTulrgx1hZj0QUN0f4piJXwJ0CpuMdpoKPNzEBDIrGgn+fOlJHz+ty/3Dpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by CO1PR11MB4929.namprd11.prod.outlook.com (2603:10b6:303:6d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 19:09:23 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b%3]) with mapi id 15.20.9137.017; Wed, 24 Sep 2025
 19:09:22 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "acme@kernel.org"
	<acme@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "namhyung@kernel.org" <namhyung@kernel.org>,
	"irogers@google.com" <irogers@google.com>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"ak@linux.intel.com" <ak@linux.intel.com>
Subject: Re: [RESEND][PATCH v2 0/2] perf record: ratio-to-prev event term for
 auto counter reload
Thread-Topic: [RESEND][PATCH v2 0/2] perf record: ratio-to-prev event term for
 auto counter reload
Thread-Index: AQHcHCh2q4LtoPAB+0mbASO8ar6BLrSi1SaA
Date: Wed, 24 Sep 2025 19:09:22 +0000
Message-ID: <6478744c4c07fae4b889b252248522f81359ec77.camel@intel.com>
References: <20250902164047.64261-1-thomas.falcon@intel.com>
In-Reply-To: <20250902164047.64261-1-thomas.falcon@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|CO1PR11MB4929:EE_
x-ms-office365-filtering-correlation-id: 6ff0bf9f-a3dc-405d-e8d9-08ddfb9ddf10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024|38070700021|921020;
x-microsoft-antispam-message-info: =?utf-8?B?ZmFKTkhzUzE4RW95bXhBUmZFQnVWOS9Ob0ZVMStvWGlYK1pJK2hnZVFka0M4?=
 =?utf-8?B?NmlRdy9iVlZ2cmFFL1E2dDl5WXFzMnJJSVBnVWRVTlU3RytsUnlNNUFoSDFE?=
 =?utf-8?B?dkloZThJMmw4ZjBqUTlPL2pyZjBGSTFIT0RIMVg2dCtyVFBueWVLMzRXWm8w?=
 =?utf-8?B?L3FKVzI0emNMRW44MTluOE5pNlc1N1dSNU1sNXJCeUFGOFVJckhXd1VNRDlh?=
 =?utf-8?B?eTBDcU9RSE5Ca20yMGNtc2g1cEJPOG5lYlYzc1N5QktMK3c2b2lQRDlSUDhj?=
 =?utf-8?B?TDEzY0NZNzNaZjV5MjBDdDZRSFVkMERwQUV6dkpJVnE4clZvanRpUGFnZWow?=
 =?utf-8?B?V0wzU0pMcmVYZ2M0dEdiU01tZFc4MmxhOU9icHd1ckR5SEtyR3FXZjJWQkRP?=
 =?utf-8?B?d3BvKzh4cmRxcXovVmEyRFgyMnA3U3hKVUQvNE94QXVVdnRtSnplOVhtREt5?=
 =?utf-8?B?WFBLdCt6ZlZXQ1NHUzJVNDRPVlNOSG1jaUFzUmd4RHkwb1hkWlBOVXZFYm44?=
 =?utf-8?B?YkFRU0F4bi95WHRwRlJFTVBNTzhLWWE3NjZGcHkyYlRCZnh1SjNWWGFSSk45?=
 =?utf-8?B?ZGQ2Qy9DZEFLY2RUbWplQzRsZi9WSW5lZlFESVNKZmV1M2hDY2UzOHJYWjZs?=
 =?utf-8?B?TndVT0lZQ2JvWkUzbGFsWnNBSGlOVXhmV1k5WmJpaGI3TVR4T3VTYUgxT2JB?=
 =?utf-8?B?ZmhOYllHVks4WHV0ZkxCOWpNWXBnVnFvNkNpWDFxcFpvVm9HdkluYU5iVktC?=
 =?utf-8?B?dzhOcmkxc2drRmFkK1U5bzVsODdGaUdyNjc4QzMxb3lQUHM0SzVOYUxvQXlV?=
 =?utf-8?B?akZ6dVY3aDhaUkZocnJIU0h5cGtvNENTdGVHcDlncWxIRVRCUU1mNGJqUU01?=
 =?utf-8?B?N0x3UmxNYysxQU5KaEhBWGVMWjVRQmhacGZHcTBkMGIzYVgrWDVaQzlZR0ZP?=
 =?utf-8?B?ZFoxUzFTbklyYzVxTFRNUDZIMDBHUW9YRDZDM2N6N09jUEhFMUsreEQ2c1BJ?=
 =?utf-8?B?VGRnNEIybGdWSU9kMTNpay92RTkrVTNOdDlJdHI5cHBoNGh2ZmY4TjVNZERK?=
 =?utf-8?B?N21mb2dUVHd6Sk45VitLQ0RCZ3VlK3J4akdjQlUzR2V2Q2htOXR5MWF3cVJT?=
 =?utf-8?B?eXExT3dIbmdmSGZuaHFFS09lODhIQ2pJclBabGFOZGZMWWZnUHBlMCtJR1pZ?=
 =?utf-8?B?SHNzWHJFRHBGV204aHU5MTVaVG91WHRENGRlOVhvb0NPVnFFYlp3a0JHL25h?=
 =?utf-8?B?azJPNENJU0VaTVlZSEM3UmhJMnB3QnZiMzRrWlIwa3V0Ukt4RVprTXhmVjJi?=
 =?utf-8?B?ZkhPYm9abHJ0NUpOcUpUaW4yZ3V1MUhrWVdNY0kxcGtlL0ZsNStuZFJIbHZO?=
 =?utf-8?B?ajUyakhSSXF6NHVGR1gzeFcxd3UwTXEvREZhRjNVeVIwRFMzais0MDh5VnN2?=
 =?utf-8?B?ZWYrVzhvQnQwb2RpdUJqYnFZOUtiQXBuWnJNODNyRkJQMVl3UWRSTFpjNS9k?=
 =?utf-8?B?NnhGQkxJUnh5elZWWUpVYWViMHozQW9zeUxiOUZ6WXNmL1FQTFh0cDVhOTNk?=
 =?utf-8?B?M3RHbE9SYWtnbm5xTWNnNEkrbDBoelY2V2J2THNvb2VLdHlxWWdpS1QzUmY0?=
 =?utf-8?B?ejBLZ1NGUjFLam9jN2tYUXdOZE5YY1IwNGh4VjdoWVB3WklHWitORUJzcnV2?=
 =?utf-8?B?ODM5TWZxdnV6MENLZTNudklVUEU4NnFiSVZEVmxVUWdYL0hXQXVKK1RqMHZY?=
 =?utf-8?B?RCs5WnNud2JFWkhudFpQTnpHbmlGeUM2bVZ4dlpDTXVrSlc4cHppemYzV3hN?=
 =?utf-8?B?M3NQQTU1eWRacjNmS05POHNDRmFkVGYybTBnaG94VXJMNVhlV1RpLzRYVDhZ?=
 =?utf-8?B?emtFMW1LcFdCamEwQVh2ZENnOG96RUlGcEFodVJPZTY4SVc2QVczUEdnN3k5?=
 =?utf-8?Q?d1Y/GmGWaAJiEj6X+y5xy8Ha2OCDJHkG?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZU9kRXRtSTNYWEU0Q0NtYlRYNGJidFNtVVEyT000RGM3UkFvaGFPTzRKOFQy?=
 =?utf-8?B?alQrOFMxemNZRkY4WG5rd3FGN3hMdnNka1NMUTEzOGdjRE8rQy84TDkyT2sz?=
 =?utf-8?B?a0MyQXE2ZVd6THJnb1ZXS3lvSUp3aWVHWCtibDRodll4RTNrZmdpbDYvajA3?=
 =?utf-8?B?U1RlVkVaSlp4eXp5a0hxY3JxNWg1TjZiVkxFdWtnMkF6bUVoOEcrNElaTmZq?=
 =?utf-8?B?ODloSUtBc0UxekNrb2dTai9ZNTltNENQSFQ2bEpTc1crNVdMNVBxdlcweTMv?=
 =?utf-8?B?dW1ET3lRNmhyZGcxbHlCZmdhSTlKZmc3UmdJTFJySDBwcWFiQklsY1dZU01k?=
 =?utf-8?B?aVhrUityWU1iZHdnOVpuSHBaYkNuaFgyV0VwZjZ2RU9zZURkVGlnTWprUjRo?=
 =?utf-8?B?TEZxS2VLbG43Z0NWMnRic2lzK203RCtabm5HajYwS3IwU010Ulo1NWV1b1du?=
 =?utf-8?B?WWNoak0xenl1TmFHajdpeEtvRElDaFAyZGZpRkVMVUdEcnROS2h3aEZ2Vm9I?=
 =?utf-8?B?amt5b29XUTVoRDZPUmpROUtJRTdOL2dKcTVHQ01oNmM4R21abiswendaQVBK?=
 =?utf-8?B?L2VsZ29SZnJNNTJFa1FUbEt3THVMMi9uTTltNm5ha0g5MVhOUFhnTVVLUkpv?=
 =?utf-8?B?VVlMRmd4TWI4a24zSjFNSys5bjVYMER6b1Mwdm1QajZxVFY5U1YyRVFwMGR3?=
 =?utf-8?B?QTFUNlVYdm9UWmlQZFVXYXJhSWd3WGFIVERVWUtSMmFtUFg1TEFOTFU3bzZl?=
 =?utf-8?B?a2NzeTV4ck1jQ2YyK2UzQkd2SHRWNEx6UFZtc1ozTkZPTUZXbkJVeGY0ek1y?=
 =?utf-8?B?aFZ3b3hDUy9VcEpuQnZZWkZ4UzhBYVV6TjJqeklaV3FiRksvRkdBNWNGVy93?=
 =?utf-8?B?YTNoaG0xMEV1d0s5OGpJRjZIcFBhVkwyNGgvdVBmUEUvY0tWSmszcjhncGtW?=
 =?utf-8?B?WjkrY0NJL0Qwd25reXZkbjdSS2JvS1hUc2V5SEZMdWFOSDA3c2lnSDllUy9J?=
 =?utf-8?B?U3ByWC9abW1ON051TzRUSTVmWjFxUUE0UW5mMTNtcGZWMDROVWUzMDBuenYv?=
 =?utf-8?B?VExsTUYvRWFObU1oTDk0bGFZNTJPRy9yeXJ5NWtjTzFnWUFPMnl6R0svWlEv?=
 =?utf-8?B?QTgxSGprNnRsdEVzcE96eFJHZjNaNHBFQ1pKMnlnY3VxSXcrOHpxaWJsbEc2?=
 =?utf-8?B?ZzlCOTRyTzg5Y2F2b3BCVzllSjVNd1hkdUlUay9wK1laMlNqTmd3YWluWTZ0?=
 =?utf-8?B?TWxxcWNpWlhGZUZyQ1hmVy8xbGNMbHdpR012bXA0cVh2bTNFakI0YiswSnlU?=
 =?utf-8?B?MmdPRW9WVlkxSnFIU1BkOVUxVlVld0V3Um5DSStsZ0JFUnJJMVBlYTlMUUlj?=
 =?utf-8?B?bVMxMjJIV3RmdkxzZXh2SWpHVlF1UXpqVE1wTWJKRmtNVWxhRFk5QlJzT3Ix?=
 =?utf-8?B?dWlyMWpPU2JDRnB1WU05UmFqMnRPeW9FZHNOYkFZdGJVTWJLRzN4SWVBV055?=
 =?utf-8?B?QndhZGJnY0NiMC9aZXZtYmZpeDByeGRTT1RGUWU1WFBkcER4TGxvbC9QUnVS?=
 =?utf-8?B?NE1pc1QrblBCMXZCWk5UNjA0RmxPald0aW4wclVwb1ZFd1p1VjBlVUFkclRV?=
 =?utf-8?B?RnQzdVdrRG9UcmlmRWYxODVtUzJoTEZ4ZlhRekllcUxzTVFzM2VFMHFrNStD?=
 =?utf-8?B?VU1EcGRTdnRpTFE4U2lNTDlSaVV2by8yU0lWcWFtSzVpSDluQ3RFVHEvYkVH?=
 =?utf-8?B?SkQ0WGJZeGtvNkhXcEhkWW1NdklGTk9UdTN0Mk15ZGlVRElBUWZBeDhVT3hx?=
 =?utf-8?B?aXppZENjVzNHOTdRbU5xQnhsU0hIRVErQXdxT0NzTitoeXBwM1l2eW55bVRK?=
 =?utf-8?B?eGd2U1RJZkNHZTRKOUFTem12bmFudnJydUdSeGI4L0FmRy8wQzd6eVk2T1pC?=
 =?utf-8?B?YTFSU1NCZTZJaGZuSE1kRzErT0haeFhnOUVvTzBNRjg3QUg2VE9ROU9QQm5r?=
 =?utf-8?B?c3QwTklIQTdZZlV4dXp1UkplL3Q0bWlrZytNOWoyZDVSendGaU1EZDBRems0?=
 =?utf-8?B?QlRQOUJIUXBFUS9UVStsWFR3dkwyNkl0cnZEOEVwbG9rUGRPWEtKNUlxOUNZ?=
 =?utf-8?B?R29ZbHNqQ0M4Ym1qUDBVVHRHdHBKNStwMUtqNjRTOEE1b1pic0RDTVZnd3Vh?=
 =?utf-8?B?SjZwRTUzZ2lRZnFwT0crb2tzL2djL0hnM3pzTDd2cVBDSkZ1eUZ3Z2pURmFW?=
 =?utf-8?B?bjU5NVdlM0NEZnpGakxkRW9tNHNBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A0BE43FB192044BB6055B0375E743EB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff0bf9f-a3dc-405d-e8d9-08ddfb9ddf10
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 19:09:22.6787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4M2cXYjqoSVb9IQCDZpLENL2+N5RwWQJZGFTjsAapwzOC+chXb+RgGfieoz2SvrOLpueDOHxpHHzKHFoupZNcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4929
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI1LTA5LTAyIGF0IDExOjQwIC0wNTAwLCBUaG9tYXMgRmFsY29uIHdyb3RlOg0K
PiBUaGUgQXV0byBDb3VudGVyIFJlbG9hZCAoQUNSKVsxXSBmZWF0dXJlIGlzIHVzZWQgdG8gdHJh
Y2sgdGhlDQo+IHJlbGF0aXZlIHJhdGVzIG9mIHR3byBvciBtb3JlIHBlcmYgZXZlbnRzLCBvbmx5
IHNhbXBsaW5nDQo+IHdoZW4gYSBnaXZlbiB0aHJlc2hvbGQgaXMgZXhjZWVkZWQuIFRoaXMgaGVs
cHMgcmVkdWNlIG92ZXJoZWFkDQo+IGFuZCB1bm5lY2Vzc2FyeSBzYW1wbGVzLiBIb3dldmVyLCBl
bmFibGluZyB0aGlzIGZlYXR1cmUNCj4gY3VycmVudGx5IHJlcXVpcmVzIHNldHRpbmcgdHdvIHBh
cmFtZXRlcnM6DQoNClBpbmcuDQoNClRoYW5rcywNClRvbQ0KDQo+IA0KPiDCoC0tIEV2ZW50IHNh
bXBsaW5nIHBlcmlvZCAoInBlcmlvZCIpDQo+IMKgLS0gYWNyX21hc2ssIHdoaWNoIGRldGVybWlu
ZXMgd2hpY2ggZXZlbnRzIGdldCByZWxvYWRlZA0KPiDCoMKgwqAgd2hlbiB0aGUgc2FtcGxlIHBl
cmlvZCBpcyByZWFjaGVkLg0KPiANCj4gRm9yIGV4YW1wbGUsIGluIHRoZSBmb2xsb3dpbmcgY29t
bWFuZDoNCj4gDQo+IHBlcmYgcmVjb3JkIC1lICJ7Y3B1X2F0b20vYnJhbmNoLW1pc3NlcyxwZXJp
b2Q9MjAwMDAwLFwNCj4gYWNyX21hc2s9MHgyL3BwdSxjcHVfYXRvbS9icmFuY2gtaW5zdHJ1Y3Rp
b25zLHBlcmlvZD0xMDAwMDAwLFwNCj4gYWNyX21hc2s9MHgzL3V9IiAtLSAuL21pc3ByZWRpY3QN
Cj4gDQo+IFRoZSBnb2FsIGlzIHRvIGxpbWl0IGV2ZW50IHNhbXBsaW5nIHRvIGNhc2VzIHdoZW4g
dGhlDQo+IGJyYW5jaCBtaXNzIHJhdGUgZXhjZWVkcyAyMCUuIElmIHRoZSBicmFuY2ggaW5zdHJ1
Y3Rpb25zDQo+IHNhbXBsZSBwZXJpb2QgaXMgZXhjZWVkZWQgZmlyc3QsIGJvdGggZXZlbnRzIGFy
ZSByZWxvYWRlZC4NCj4gSWYgYnJhbmNoIG1pc3NlcyBleGNlZWQgdGhlaXIgdGhyZXNob2xkIGZp
cnN0LCBvbmx5IHRoZQ0KPiBzZWNvbmQgY291bnRlciBpcyByZWxvYWRlZCwgYW5kIGEgc2FtcGxl
IGlzIHRha2VuLg0KPiANCj4gVG8gc2ltcGxpZnkgdGhpcywgcHJvdmlkZSBhIG5ldyDigJxyYXRp
by10by1wcmV24oCdIGV2ZW50IHRlcm0NCj4gdGhhdCB3b3JrcyBhbG9uZ3NpZGUgdGhlIHBlcmlv
ZCBldmVudCBvcHRpb24gb3IgLWMgb3B0aW9uLg0KPiBUaGlzIHdvdWxkIGFsbG93IHVzZXJzIHRv
IHNwZWNpZnkgdGhlIGRlc2lyZWQgcmVsYXRpdmUgcmF0ZQ0KPiBiZXR3ZWVuIGV2ZW50cyBhcyBh
IHJhdGlvLCBtYWtpbmcgY29uZmlndXJhdGlvbiBtb3JlIGludHVpdGl2ZS4NCj4gDQo+IFdpdGgg
dGhpcyBlbmhhbmNlbWVudCwgdGhlIGVxdWl2YWxlbnQgY29tbWFuZCB3b3VsZCBiZToNCj4gDQo+
IHBlcmYgcmVjb3JkIC1lICJ7Y3B1X2F0b20vYnJhbmNoLW1pc3Nlcy9wcHUsXA0KPiBjcHVfYXRv
bS9icmFuY2gtaW5zdHJ1Y3Rpb25zLHBlcmlvZD0xMDAwMDAwLHJhdGlvX3RvX3ByZXY9NS91fSIg
XA0KPiAtLSAuL21pc3ByZWRpY3QNCj4gDQo+IG9yDQo+IA0KPiBwZXJmIHJlY29yZCAtZSAie2Nw
dV9hdG9tL2JyYW5jaC1taXNzZXMvcHB1LFwNCj4gY3B1X2F0b20vYnJhbmNoLWluc3RydWN0aW9u
cyxyYXRpby10by1wcmV2PTUvdX0iIC1jIDEwMDAwMDAgXA0KPiAtLSAuL21pc3ByZWRpY3QNCj4g
DQo+IFsxXQ0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjUwMzI3MTk1MjE3LjI2
ODM2MTktMS1rYW4ubGlhbmdAbGludXguaW50ZWwuY29tLw0KPiANCj4gQ2hhbmdlcyBpbiB2MiAo
bW9zdGx5IHN1Z2dlc3RlZCBieSBJYW4gUm9nZXJzKToNCj4gDQo+IC0tIEFkZCBkb2N1bWVudGF0
aW9uIGV4cGxhaW5pbmcgYWNyX21hc2sgYml0bWFzayB1c2VkIGJ5IEFDUg0KPiAtLSBNb3ZlIEFD
UiBzcGVjaWZpYyBpbXBsZW1lbnRhdGlvbiB0byBhcmNoL3g4Ni8NCj4gLS0gUHJvdmlkZSB0ZXN0
IGNhc2VzIGZvciBldmVudCBwYXJzaW5nIGFuZCBwZXJmIHJlY29yZCB0ZXN0cw0KPiANCj4gVGhv
bWFzIEZhbGNvbiAoMik6DQo+IMKgIHBlcmYgcmVjb3JkOiBBZGQgcmF0aW8tdG8tcHJldiB0ZXJt
DQo+IMKgIHBlcmYgcmVjb3JkOiBhZGQgYXV0byBjb3VudGVyIHJlbG9hZCBwYXJzZSBhbmQgcmVn
cmVzc2lvbiB0ZXN0cw0KPiANCj4gwqB0b29scy9wZXJmL0RvY3VtZW50YXRpb24vaW50ZWwtYWNy
LnR4dCB8IDUzICsrKysrKysrKysrKysrKysrKw0KPiDCoHRvb2xzL3BlcmYvRG9jdW1lbnRhdGlv
bi9wZXJmLWxpc3QudHh0IHzCoCAyICsNCj4gwqB0b29scy9wZXJmL2FyY2gveDg2L3V0aWwvZXZz
ZWwuY8KgwqDCoMKgwqDCoCB8IDUzICsrKysrKysrKysrKysrKysrKw0KPiDCoHRvb2xzL3BlcmYv
dGVzdHMvcGFyc2UtZXZlbnRzLmPCoMKgwqDCoMKgwqDCoCB8IDU0ICsrKysrKysrKysrKysrKysr
Kw0KPiDCoHRvb2xzL3BlcmYvdGVzdHMvc2hlbGwvcmVjb3JkLnNowqDCoMKgwqDCoMKgIHwgNDAg
KysrKysrKysrKysrKysNCj4gwqB0b29scy9wZXJmL3V0aWwvZXZzZWwuY8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8IDc2DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrDQo+IMKg
dG9vbHMvcGVyZi91dGlsL2V2c2VsLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKg
IDEgKw0KPiDCoHRvb2xzL3BlcmYvdXRpbC9ldnNlbF9jb25maWcuaMKgwqDCoMKgwqDCoMKgwqAg
fMKgIDEgKw0KPiDCoHRvb2xzL3BlcmYvdXRpbC9wYXJzZS1ldmVudHMuY8KgwqDCoMKgwqDCoMKg
wqAgfCAyMiArKysrKysrKw0KPiDCoHRvb2xzL3BlcmYvdXRpbC9wYXJzZS1ldmVudHMuaMKgwqDC
oMKgwqDCoMKgwqAgfMKgIDMgKy0NCj4gwqB0b29scy9wZXJmL3V0aWwvcGFyc2UtZXZlbnRzLmzC
oMKgwqDCoMKgwqDCoMKgIHzCoCAxICsNCj4gwqB0b29scy9wZXJmL3V0aWwvcG11LmPCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAzICstDQo+IMKgMTIgZmlsZXMgY2hhbmdl
ZCwgMzA3IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IMKgY3JlYXRlIG1vZGUgMTAw
NjQ0IHRvb2xzL3BlcmYvRG9jdW1lbnRhdGlvbi9pbnRlbC1hY3IudHh0DQo+IA0KDQo=
