Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F054261593;
	Tue, 30 Sep 2025 11:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759232503; cv=fail; b=mWXhaEFWVV96Iia8pFdDPLZrMcsxZzdBSSKvhl85+4awIcqM1Aqr1BtcB6GlBJeDd3G8Il2acF/4yF1NwseYSUf2zvYelHMjQg4LrV9HItIzGTAdD2xR9hBC9hZnJak/R2UHdKBtOxpxmzpjgFhLmBQYUaqB5LABYTGucGW4sMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759232503; c=relaxed/simple;
	bh=NF0NJCQH47wXexJsu5OYzH4e1INiiKEED0jKby4b1iw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UJfSRwPokLUEgDw8D7dSN8xGIxYylKqr288cudb2LJ99NfI9rZtpOfynBMmD287n5hIN+yV54LwUOatbqcsOG9EJaWNtOhQS0mumu6lXCcbSfF9XIl/b69QRxnwN8Uidcvk9PpPod6ubP7088QdCpfKMFrNgM2ijD+i9W3jvcz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kp68E2yb; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kp68E2yb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759232501; x=1790768501;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NF0NJCQH47wXexJsu5OYzH4e1INiiKEED0jKby4b1iw=;
  b=kp68E2ybXpjSWbOdbiDnv3sjXU/YKwVA1f2VDgZSbprRw/miSECzTcOv
   AZcS86XhPPaBKOrpePjx8j9VWB6oWYYJShLcnscnGIEEC/m5oeyWYvJTR
   cwqGfRIdqCRC6lwf8JB0e9JnAhprx1pv6wGFMGt5afw5/9meGZJnyoqRD
   Nr2BhTRxzZ31hARk+fVmVPLYKlt76BQU2qMACq8WUgGLvjEGWzAp0B43w
   CDiYQZuMhSTwJ7Y3IZU7rWNOHH0573AzrIeBXXbGjZEHVC+5vTOJIR6bp
   hvE1OOk/VJh43wpf+OO3SstI5p7YLBPDJ64ZpvGMsvBWM7b3k0RgkSHV9
   g==;
X-CSE-ConnectionGUID: trzTqTIvSqiFDwZqHW5C8A==
X-CSE-MsgGUID: 1edEMzsgQhOR6jKnoUmUog==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="61594330"
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="61594330"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 04:41:40 -0700
X-CSE-ConnectionGUID: K+i+8kN6RqeRN8hXOOoLjA==
X-CSE-MsgGUID: JdjBHLBSTauGX6etmSpSfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="209213908"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 04:41:39 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 30 Sep 2025 04:41:39 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 30 Sep 2025 04:41:39 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.54) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 30 Sep 2025 04:41:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ca7of9+cD3TuCogXRR20Z6SZW/flU8tg6JQFnfYI8msPP3LXoVzGRKTnAG7iAP7NYE+qPiIzMUAZD4YRj7aHiljlTA+MCE4IJhqm9OZem6UGY4WbZIy0TZYo45h/GF6vtA8L8MoHCFI2R9S0Qmi8I+xivL2ugw9yL+aGs0Ql7d1FoCzHWWw69U3dIdWFp7ILnhj3kY7zmF0bEyol9NjuQSmgWB/W9pCJsXmXL+mFA/Q6cDmoVhmdCAl6G8M10Nm4fMz0dS9er8eDqF4MJeT1NnKsEgmtg8Ov4VHw8hJUGsSH9mzKB2Y5X9d6xBHVv7v93j4drz8SS9S6e4suUOylcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tv1jyv5pJJzlql9K3nkUaq7gBHMIhe2dTqYDbm7FhEk=;
 b=xDHJPi7zweRQN6TEHQ2FWddz00yUcYZCBWMlI+5lkDqPlKz84rPuoyDAZzxDAuEHpLg64lk/PeN3fL0Uju75qoXz4Z8BuHcLX4TOsTrZ7SUq5g6wyRm4Yzs19/WKkQUJR/Wq9BL+0RGEgz/Mjmzq6lS4CQMoD/h2y/SkeFhRPv9LU1bie3i6Ii56IqV/w8q4mkgY3+v+5KZmpEpxkyDwfNPZJm5KOZZbbVSZSkVfRyUSb4y2pw6YPCNJ0hU46hAY5RH2n2+HTgzEENtmBtE8HAwZt6BxlJnJdJLWKrrHI4iObfXZAemX4liRTJtD/z62kP3FoUGvGQUEXbmg7JjpYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB8289.namprd11.prod.outlook.com (2603:10b6:303:1e8::9)
 by PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 11:41:35 +0000
Received: from MW4PR11MB8289.namprd11.prod.outlook.com
 ([fe80::d626:a4f8:c029:5022]) by MW4PR11MB8289.namprd11.prod.outlook.com
 ([fe80::d626:a4f8:c029:5022%6]) with mapi id 15.20.9160.014; Tue, 30 Sep 2025
 11:41:34 +0000
Message-ID: <5ea9bf13-c78d-43ef-ae3b-5ded69f75afc@intel.com>
Date: Tue, 30 Sep 2025 19:41:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] perf tools c2c: Add annotation support to perf c2c
 report
To: Namhyung Kim <namhyung@kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "Kan
 Liang" <kan.liang@linux.intel.com>, <wangyang.guo@intel.com>,
	<pan.deng@intel.com>, <zhiguo.zhou@intel.com>, <jiebin.sun@intel.com>,
	<thomas.falcon@intel.com>, <dapeng1.mi@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <aMpWcdjoCBsRVo72@z2>
 <20250928090212.1324797-1-tianyou.li@intel.com>
 <be2b23a3-9951-4357-a3f2-3eebe7ef20a5@intel.com>
 <aNo-U0KquRbcJam9@google.com>
Content-Language: en-US
From: "Li, Tianyou" <tianyou.li@intel.com>
In-Reply-To: <aNo-U0KquRbcJam9@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR01CA0043.apcprd01.prod.exchangelabs.com
 (2603:1096:820:1::31) To MW4PR11MB8289.namprd11.prod.outlook.com
 (2603:10b6:303:1e8::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB8289:EE_|PH0PR11MB5832:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eac3eac-f1d5-4126-06a9-08de00164ec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2NyUHdJTCs3SytCZFRGN1I4YkV4cVBqcXBRaDhxRWNURjZ3ZjV1REtGaUtV?=
 =?utf-8?B?YVJCQWgyVWg5UUN6SUg2VzdGVENadndEYUhreG9ZdFlrK1F2WFpIcDZsK3R1?=
 =?utf-8?B?VkM1UUc1bzRKcE1DYmlGS0ZzTkRjNkZEbmRJU1ZYRmVkdkwwUE80UklJVi91?=
 =?utf-8?B?YW9HQWJqekpscUJzM1BaMmRIUjVEdFo4eVdWTC9UMVhiWEZQbkxvY3gyTFk3?=
 =?utf-8?B?Qmx3UzZwNE03QTM3Y2xTVnlNcTRxTElxejNmVzBaVFRNUlZCR1ZXUnIwbGtt?=
 =?utf-8?B?cTRkMFNGODhwYlE0ay9oZ25zRkxVV3ZuV0VVN2w2dEQ5TzZwOEJpUGZxK0dG?=
 =?utf-8?B?d2tqeVo2Rkd3c2pubkUvdUZnTkRaSTNkb3E1aDZCQ2V2cURrZGNka2tjaUdJ?=
 =?utf-8?B?dXlSQXlKNTNVbDl4SmJ0Vmh4UzBBdlY1Y2IyTnlYcWU5QS9tOTJOZzBaNHcz?=
 =?utf-8?B?YlNOcVVoYndNT1puN3hSOW9yL2dubThWT1dKQlM4UnY2ZTNSVlM1R0QrSkJQ?=
 =?utf-8?B?dnU0dGVoNkxuT2RzSm5TanhuZm5SeTFjeVh4WW1yeGtNc2tYWkVIZklidHRR?=
 =?utf-8?B?ZmxLRm0rTThMODJFNWRRbFhuMS9ldGVIYWhBWlFGVCt5QUpWREZtS0JodFVB?=
 =?utf-8?B?Y3ZQUCtUdHU2Um4xSlBYNFR0LzJ6dDdSSCtTcXNFZHViTzM1NFFMS2lXYnpN?=
 =?utf-8?B?cXFIakc3Q05QK3hwbUltdmhYYVdMZUU1bWNTYktGQ1RJRG1lTGFSMFRNc0xV?=
 =?utf-8?B?aVBYQytGQ1dqM2FrVFpJZnpWOWhoNVd6MzhFMElDcGFLSk1CWVNwUWhpeTBt?=
 =?utf-8?B?cThRSUJUeFJ2eXJoMzF0bWcwZWZkVGNyKzYrZ2dTRTZrNmVIMG9GK0Jndk5L?=
 =?utf-8?B?c1c5WEpGYUNZb1ZmUXMvV3NKY3J1YjNBWWxGQWFYeHFsZG5QaU5lYllKbmNE?=
 =?utf-8?B?NVFaSTNPYTJlUEd0cG9yQVFjcUg5aktSbE5sYjdjdVdDUkd0VzR6ZFVKeERq?=
 =?utf-8?B?VkhoZTZ2elNvcGIwRUZNekplczRIZmFVanh4blZZS3FsZ3JFcUNVbVJHUWpw?=
 =?utf-8?B?bXFpNDdmOG1sSUpSbUNBall5UkEzcTJxRkhFZ21EUjJFZ2tZZWhzbSsvUkEv?=
 =?utf-8?B?S2NZZmtoRG1iSzlkVHZzWXV0eTBuM0QxWm9pRUpaekFHcERzNXB5THYzNy96?=
 =?utf-8?B?OC9hMHYrbjR6R0hzQ1FPalpJcXBKYVU5OHNFYkE5ZEFOYk8zUzBuMzJGY3dG?=
 =?utf-8?B?Zm5YVWNXdHNUbU9RcXFnKzBoQUhBT3RqeDZwNm5Ga2k4eWhNRS8xTmpNblVp?=
 =?utf-8?B?cVhMQzVUZUJybkkyYllPSk1tRUxNTGliZ2NLVy90RU1iRk1LWDJwbDJwdjZs?=
 =?utf-8?B?aDE3VXg1aENTUFRHZ01nL0p0d0lKVituODNPemRwOUlyRmtmRjFiWkE3WU5Q?=
 =?utf-8?B?bHJMOWZObElod1hFL1I4SXduTjhYeFNoNmk0M00yVVZ5SlVxZDFQTVZnaENG?=
 =?utf-8?B?N2prZXdSMFlRMmRwN210dVBmTkRrRnh6ektFc0VNa0QwS3U3bHMybHVLditI?=
 =?utf-8?B?WGVTS1NxTmtXVXdaMmxoN3dnRURUTGNnejM4RVRibmJwK25wUk54TElab255?=
 =?utf-8?B?dy9KeG44L2pzdENzdlpWVmVrZFhacGRQdFFiRk9KNU5CRlJJRWJwRWZFOWc5?=
 =?utf-8?B?V0pYeXFxMENyTVJqUGdOTHVWcVZWa0FtVWs1WGNWaDF4Znh3a1Y5UzdQazVh?=
 =?utf-8?B?em9uQS9oT2ZqSTRwMnd2QVhqMHcxNnhZMTZzeDZtNDc4eUFDaTlleUxtY0E3?=
 =?utf-8?B?ajMxRjVYOUtGNVNFT0tsamNObnBGU3IvR09rUndranhscWI1K2Ixb3MzV2dR?=
 =?utf-8?B?a1R6bFRQQVdQNzZ1MWxUV3NWem9YY1JoK0M0ZURmQUFrZS82RmE5LzRKWWNz?=
 =?utf-8?Q?6rRsD9biQGqGkvJ75gLiMtOwtP/RS8D8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB8289.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVVMTGIwbHF0dHNESCtHRnh0aytaY21BMzM0VzZTZVVqK3E2NWRiMFRrTHpK?=
 =?utf-8?B?OXdJTnRTUVU2VHQ2RVN0Ky9IeWUxWUxvN0NLdzJ4QUZKMWxHMlBPNy9OYk45?=
 =?utf-8?B?eVQrUFliU0locGd0VjlLRmhxWFpBQ09QRGtlYUlFRU90SkkxM3Z2MkZWVDJ3?=
 =?utf-8?B?YlFveXpaNUc1ZlNGckdoMWdLN1NDbnh3RE1YR1RjS3VGN3FqZkdtR1BFRVZi?=
 =?utf-8?B?OWJMUVU0TGpQSFVodlpzM09XNlB4Y3E1TFIyekt2d1BXS2ZJMFNQRVVqMVY4?=
 =?utf-8?B?U2syN0dlZTRoOEp4eFNuUE4xTVowVUpkRDlXT285QzE5Vlo0TkgxdEttckFN?=
 =?utf-8?B?WThCMnZjOFBHL1RUVDBnc2N3eS8vMHFmb25jTHdRTXNpSGFXV2xQWm1RSWhv?=
 =?utf-8?B?VXZXTTFIU1JTQXlFa1FvVnBiWlFBNnVyY1lDbFJibjZ1YVhDUkRTeS9BK1ZZ?=
 =?utf-8?B?dnlHVmx6ZHhxaTdrcWUzUWtONms4dDl1Q1liMkNndHJBaWF6dEE5a2JzWnF5?=
 =?utf-8?B?RlRlUEhPUkdOTnZTTm1Da1VUN0R5R2dnMTR0L2tuYmdwQkNWZUNNYVY0eDY3?=
 =?utf-8?B?WkVXWllqQlRHbXhuSmlTaEx3aTEzN3dLZW5KWG0xTW1LdWVhTndlOWtYWHB2?=
 =?utf-8?B?VXhkNTJoNVVocGZQNnM4YXFoSGVxR2RTRVlUdk9tYzhlaTRKMlE3QmVIeDBR?=
 =?utf-8?B?aGwxelFkUWxWeDNHSkhkVWZ5MEFsTFpLcmM2SzJPS05wdVR2NTFMUS9RUm1Q?=
 =?utf-8?B?a1FwTzcwTWdKNG8zV0VaV3VVckxjWlUrTGhqU1FYbWFiZWdObDhUTStwTUs1?=
 =?utf-8?B?UnRHLzNXVHFVWjNRZHNTOUJndUtDd1Z0b3NtdlRxcHRQVEdtNm9GdDZqSFY3?=
 =?utf-8?B?Qmo2dG4rcWxDUXRLY2NwWWl6RllkQ1FkUjBmZ3JqZFprZTJiaTkzZGZ0dU1Y?=
 =?utf-8?B?cWlZdjIvVWxQNFNmN3MwNHBBWXArWFVlaGJPd3VTRE5XSC9USTg2OWpYSm4v?=
 =?utf-8?B?N3dLTnFrcFZLWnJwYW9RNFZVaFVXYXM4TDk1aGdpZWtldEJTdG9wam1QZXZy?=
 =?utf-8?B?NzlJcFlta3R3bzFKZzdPcXpOUW83cmV2Z2QwUWdwR1YzR3VRRDB3bFpvRk5k?=
 =?utf-8?B?U2RGTFREZ29BQUp1QzN2TDR2bHFiZnMzcmJ0TUFvbmg2aE1udTgzcFZiN1FC?=
 =?utf-8?B?dlMwWXhDZnlnanE1N2l3L2o3R0dDalZNWE90eXVqdHN3aDM2Y0IzZm5hbG84?=
 =?utf-8?B?U0w0VnN2R1U4Z293YksyMnE1TnVpZnBUYmhXYzFOemQyS2JEVUcyMFVSNk9G?=
 =?utf-8?B?aURnMVpYV214TXF3aVNibm1ZckRUOHgzcGZzYU96aUxLelpVZk0vR1M3aWNQ?=
 =?utf-8?B?SVg0TVFpNVJwUkFua1VtUG9xZ1dJc0IxQWtnN1ZzOGY1RXNPYXVpSVpYNnNQ?=
 =?utf-8?B?Z1pKSzVlL2JIUTFUL1Z1alk2OEV6blVpUW1BNHUxT1MvVXhERUNJUm5LMEE1?=
 =?utf-8?B?STE3QVBMa2pGWE0wUGRPRWtzbG5oaGIvUVh1Mk1MV0xwL2pDa3VQMzRPUndj?=
 =?utf-8?B?OHBwVm55NGF1MEo4RExWTzNjTkRpSFBEbzJDMXVGWkIwMmtjSVNkMDlzZDRR?=
 =?utf-8?B?NmJLRldDVytENkdHbFRnZE01R2tMRFRtZ3p0cTJHamRsSnVIMjJjZGpNV2Rs?=
 =?utf-8?B?MHF5SjBlaG9EcWRvRFIzMUdZVGo1LzlnQzV2QnNjYjNBc3ZXUm53WXZLcERB?=
 =?utf-8?B?TGgxeS9Ea3dnNmEvR2w0RXVDM25VNDAvSkYxenV3UlYxcGNSMXI5WGs1UkJx?=
 =?utf-8?B?UzRRSTJCbkxrdHNyZTl6ZXRhdk82ZDRyS2txZ0c4Uk9aY05HY0xnekNBZnNI?=
 =?utf-8?B?SnE2eW0wdFJMMHZmUllQbndYalZCWE8veWpnSkY0YUFoV3B3RHJTN2o4SDdJ?=
 =?utf-8?B?dVhXQUdic2FoVDNpZzFPTDNMNTUvQUR4d2lHa0hsejBoc1o2V0Q4emFFNFdw?=
 =?utf-8?B?Q0ZpS3lBcHcxN0ZJMjZGSUpCYzhXbjN6aHNZQ1c2VUw2Si9iclYzTHA0ZDZJ?=
 =?utf-8?B?RmlSWmRLdWdNeFdRWjk2TjFyQmZyT1phQWFLRzVHS1pRSmUyUmt2U3ZjZGdU?=
 =?utf-8?Q?gOzhnWQQwNRQkT08GkjrFwjXW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eac3eac-f1d5-4126-06a9-08de00164ec4
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB8289.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 11:41:34.7962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LH8W4cH8nk/qyz/O3LhRxSH0eN0p0uzA36oabNjzTQVq8yoasgDVmYY2GXWQEnxKKbv4WvmJVPUUJEfZszmX4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5832
X-OriginatorOrg: intel.com


On 9/29/2025 4:07 PM, Namhyung Kim wrote:
> Hello,
>
> On Sun, Sep 28, 2025 at 04:16:16PM +0800, Li, Tianyou wrote:
>> Rebased with latest perf-tools-next. Looking forward to your review
>> comments. Thanks.
> Sorry for the delay, I was on vacation.
Very appreciated for your time to review the patch. Believes you have a 
great vacation.
>   
>> On 9/28/2025 5:02 PM, Tianyou Li wrote:
>>> Perf c2c report currently specified the code address and source:line
>>> information in the cacheline browser, while it is lack of annotation
>>> support like perf report to directly show the disassembly code for
>>> the particular symbol shared that same cacheline. This patches add
>>> a key 'a' binding to the cacheline browser which reuse the annotation
>>> browser to show the disassembly view for easier analysis of cacheline
>>> contentions. By default, the 'TAB' key navigate to the code address
>>> where the contentions detected.
>>>
>>> Signed-off-by: Tianyou Li <tianyou.li@intel.com>
>>> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>> Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
>>> Reviewed-by: Jiebin Sun <jiebin.sun@intel.com>
>>> Reviewed-by: Pan Deng <pan.deng@intel.com>
>>> Reviewed-by: Zhiguo Zhou <zhiguo.zhou@intel.com>
>>> Reviewed-by: Wangyang Guo <wangyang.guo@intel.com>
>>> ---
>>>    tools/perf/builtin-annotate.c     |   2 +-
>>>    tools/perf/builtin-c2c.c          | 130 ++++++++++++++++++++++++++++--
>>>    tools/perf/ui/browsers/annotate.c |  41 +++++++++-
>>>    tools/perf/ui/browsers/hists.c    |   2 +-
>>>    tools/perf/util/annotate.c        |   2 +-
>>>    tools/perf/util/annotate.h        |   2 +
>>>    tools/perf/util/hist.h            |   6 +-
>>>    7 files changed, 171 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
>>> index 646f43b0f7c4..f977e97a9c96 100644
>>> --- a/tools/perf/builtin-annotate.c
>>> +++ b/tools/perf/builtin-annotate.c
>>> @@ -519,7 +519,7 @@ static void hists__find_annotations(struct hists *hists,
>>>    			/* skip missing symbols */
>>>    			nd = rb_next(nd);
>>>    		} else if (use_browser == 1) {
>>> -			key = hist_entry__tui_annotate(he, evsel, NULL);
>>> +			key = hist_entry__tui_annotate(he, evsel, NULL, NO_INITIAL_IP);
>>>    			switch (key) {
>>>    			case -1:
>>> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
>>> index 9e9ff471ddd1..bf2136d062ef 100644
>>> --- a/tools/perf/builtin-c2c.c
>>> +++ b/tools/perf/builtin-c2c.c
>>> @@ -45,6 +45,8 @@
>>>    #include "pmus.h"
>>>    #include "string2.h"
>>>    #include "util/util.h"
>>> +#include "util/symbol.h"
>>> +#include "util/annotate.h"
>>>    struct c2c_hists {
>>>    	struct hists		hists;
>>> @@ -62,6 +64,7 @@ struct compute_stats {
>>>    struct c2c_hist_entry {
>>>    	struct c2c_hists	*hists;
>>> +	struct evsel		*evsel;
>>>    	struct c2c_stats	 stats;
>>>    	unsigned long		*cpuset;
>>>    	unsigned long		*nodeset;
>>> @@ -225,6 +228,12 @@ he__get_c2c_hists(struct hist_entry *he,
>>>    	return hists;
>>>    }
>>> +static void c2c_he__set_evsel(struct c2c_hist_entry *c2c_he,
>>> +				struct evsel *evsel)
>>> +{
>>> +	c2c_he->evsel = evsel;
>>> +}
>>> +
>>>    static void c2c_he__set_cpu(struct c2c_hist_entry *c2c_he,
>>>    			    struct perf_sample *sample)
>>>    {
>>> @@ -334,6 +343,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
>>>    	c2c_he__set_cpu(c2c_he, sample);
>>>    	c2c_he__set_node(c2c_he, sample);
>>> +	c2c_he__set_evsel(c2c_he, evsel);
>>>    	hists__inc_nr_samples(&c2c_hists->hists, he->filtered);
>>>    	ret = hist_entry__append_callchain(he, sample);
>>> @@ -371,6 +381,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
>>>    		c2c_he__set_cpu(c2c_he, sample);
>>>    		c2c_he__set_node(c2c_he, sample);
>>> +		c2c_he__set_evsel(c2c_he, evsel);
>>>    		hists__inc_nr_samples(&c2c_hists->hists, he->filtered);
>>>    		ret = hist_entry__append_callchain(he, sample);
>>> @@ -2550,6 +2561,35 @@ static void perf_c2c__hists_fprintf(FILE *out, struct perf_session *session)
>>>    }
>>>    #ifdef HAVE_SLANG_SUPPORT
>>> +
>>> +static int perf_c2c__toggle_annotation(struct hist_browser *browser)
>>> +{
>>> +	struct hist_entry *he = browser->he_selection;
>>> +	struct symbol *sym = NULL;
>>> +	struct c2c_hist_entry *c2c_he = NULL;
>>> +	struct annotated_source *src = NULL;
>>> +
>>> +	if (he == NULL) {
>>> +		ui_browser__help_window(&browser->b, "No entry selected for annotation");
>>> +		return 0;
>>> +	}
>>> +	sym = (&he->ms)->sym;
>>> +
>>> +	if (sym == NULL) {
>>> +		ui_browser__help_window(&browser->b, "Can not annotate, no symbol found");
>>> +		return 0;
>>> +	}
>>> +
>>> +	src = symbol__hists(sym, 0);
>>> +	if (src == NULL) {
>>> +		ui_browser__help_window(&browser->b, "Failed to initialize annotation source");
>>> +		return 0;
>>> +	}
>>> +
>>> +	c2c_he = container_of(he, struct c2c_hist_entry, he);
>>> +	return hist_entry__tui_annotate(he, c2c_he->evsel, NULL, he->ip);
> I'm skeptical about using he->ip.  An hist_entry can collapse multiple
> samples with different IP in a symbol (even if hpp_list has symbol sort
> key).  That means he->ip cannot represent the entry is from the specific
> point in the function.  This might lead users to an inaccurate place in
> the annotation browser.  I'd recommend not passing IP.
Understood. Thanks. What if we use cacheline browser's he->mem_info to 
get the al_addr? I will change the code accordingly for your review.
>>> +}
>>> +
>>>    static void c2c_browser__update_nr_entries(struct hist_browser *hb)
>>>    {
>>>    	u64 nr_entries = 0;
>>> @@ -2617,6 +2657,7 @@ static int perf_c2c__browse_cacheline(struct hist_entry *he)
>>>    	" ENTER         Toggle callchains (if present) \n"
>>>    	" n             Toggle Node details info \n"
>>>    	" s             Toggle full length of symbol and source line columns \n"
>>> +	" a             Toggle annotation view \n"
>>>    	" q             Return back to cacheline list \n";
>>>    	if (!he)
>>> @@ -2651,6 +2692,9 @@ static int perf_c2c__browse_cacheline(struct hist_entry *he)
>>>    			c2c.node_info = (c2c.node_info + 1) % 3;
>>>    			setup_nodes_header();
>>>    			break;
>>> +		case 'a':
>>> +			perf_c2c__toggle_annotation(browser);
>>> +			break;
>>>    		case 'q':
>>>    			goto out;
>>>    		case '?':
>>> @@ -2989,6 +3033,11 @@ static int setup_coalesce(const char *coalesce, bool no_source)
>>>    	return 0;
>>>    }
>>> +static bool perf_c2c__has_annotation(void)
>>> +{
>>> +	return use_browser == 1;
> Please check if it has symbol dimension in the c2c_hists->list like in
> the ui__has_annotation().  Maybe you need to add this in the
> c2c_hists__init_sort().
>
> 	if (dim == &dim_symbol)
> 		hpp_list->sym = 1;
>
> Thanks,
> Namhyung
Agreed, will do. I am thinking to add the 'symbol' sort key into 
cl_resort so it will not impact the 'dcacheline' sort key in the 
c2c_hists__init  and the cl_sort sort key which also controls the cl 
output. In this way it may need to have a hpp_list parameter to indicate 
the caller from c2c_browser or cacheline_browser.
>>> +}
>>> +
>>>    static int perf_c2c__report(int argc, const char **argv)
>>>    {
>>>    	struct itrace_synth_opts itrace_synth_opts = {
>>> @@ -3006,6 +3055,7 @@ static int perf_c2c__report(int argc, const char **argv)
>>>    	const char *display = NULL;
>>>    	const char *coalesce = NULL;
>>>    	bool no_source = false;
>>> +	const char *disassembler_style = NULL, *objdump_path = NULL, *addr2line_path = NULL;
>>>    	const struct option options[] = {
>>>    	OPT_STRING('k', "vmlinux", &symbol_conf.vmlinux_name,
>>>    		   "file", "vmlinux pathname"),
>>> @@ -3033,6 +3083,12 @@ static int perf_c2c__report(int argc, const char **argv)
>>>    	OPT_BOOLEAN(0, "stitch-lbr", &c2c.stitch_lbr,
>>>    		    "Enable LBR callgraph stitching approach"),
>>>    	OPT_BOOLEAN(0, "double-cl", &chk_double_cl, "Detect adjacent cacheline false sharing"),
>>> +	OPT_STRING('M', "disassembler-style", &disassembler_style, "disassembler style",
>>> +		   "Specify disassembler style (e.g. -M intel for intel syntax)"),
>>> +	OPT_STRING(0, "objdump", &objdump_path, "path",
>>> +		   "objdump binary to use for disassembly and annotations"),
>>> +	OPT_STRING(0, "addr2line", &addr2line_path, "path",
>>> +		   "addr2line binary to use for line numbers"),
>>>    	OPT_PARENT(c2c_options),
>>>    	OPT_END()
>>>    	};
>>> @@ -3040,6 +3096,12 @@ static int perf_c2c__report(int argc, const char **argv)
>>>    	const char *output_str, *sort_str = NULL;
>>>    	struct perf_env *env;
>>> +	annotation_options__init();
>>> +
>>> +	err = hists__init();
>>> +	if (err < 0)
>>> +		goto out;
>>> +
>>>    	argc = parse_options(argc, argv, options, report_c2c_usage,
>>>    			     PARSE_OPT_STOP_AT_NON_OPTION);
>>>    	if (argc)
>>> @@ -3052,6 +3114,36 @@ static int perf_c2c__report(int argc, const char **argv)
>>>    	if (c2c.stats_only)
>>>    		c2c.use_stdio = true;
>>> +	/**
>>> +	 * Annotation related options
>>> +	 * disassembler_style, objdump_path, addr2line_path
>>> +	 * are set in the c2c_options, so we can use them here.
>>> +	 */
>>> +	if (disassembler_style) {
>>> +		annotate_opts.disassembler_style = strdup(disassembler_style);
>>> +		if (!annotate_opts.disassembler_style) {
>>> +			err = -ENOMEM;
>>> +			pr_err("Failed to allocate memory for annotation options\n");
>>> +			goto out;
>>> +		}
>>> +	}
>>> +	if (objdump_path) {
>>> +		annotate_opts.objdump_path = strdup(objdump_path);
>>> +		if (!annotate_opts.objdump_path) {
>>> +			err = -ENOMEM;
>>> +			pr_err("Failed to allocate memory for annotation options\n");
>>> +			goto out;
>>> +		}
>>> +	}
>>> +	if (addr2line_path) {
>>> +		symbol_conf.addr2line_path = strdup(addr2line_path);
>>> +		if (!symbol_conf.addr2line_path) {
>>> +			err = -ENOMEM;
>>> +			pr_err("Failed to allocate memory for annotation options\n");
>>> +			goto out;
>>> +		}
>>> +	}
>>> +
>>>    	err = symbol__validate_sym_arguments();
>>>    	if (err)
>>>    		goto out;
>>> @@ -3126,6 +3218,38 @@ static int perf_c2c__report(int argc, const char **argv)
>>>    	if (err)
>>>    		goto out_mem2node;
>>> +	if (c2c.use_stdio)
>>> +		use_browser = 0;
>>> +	else
>>> +		use_browser = 1;
>>> +
>>> +	/*
>>> +	 * Only in the TUI browser we are doing integrated annotation,
>>> +	 * so don't allocate extra space that won't be used in the stdio
>>> +	 * implementation.
>>> +	 */
>>> +	if (perf_c2c__has_annotation()) {
>>> +		int ret = symbol__annotation_init();
>>> +
>>> +		if (ret < 0)
>>> +			goto out_mem2node;
>>> +		/*
>>> +		 * For searching by name on the "Browse map details".
>>> +		 * providing it only in verbose mode not to bloat too
>>> +		 * much struct symbol.
>>> +		 */
>>> +		if (verbose > 0) {
>>> +			/*
>>> +			 * XXX: Need to provide a less kludgy way to ask for
>>> +			 * more space per symbol, the u32 is for the index on
>>> +			 * the ui browser.
>>> +			 * See symbol__browser_index.
>>> +			 */
>>> +			symbol_conf.priv_size += sizeof(u32);
>>> +		}
>>> +		annotation_config__init();
>>> +	}
>>> +
>>>    	if (symbol__init(env) < 0)
>>>    		goto out_mem2node;
>>> @@ -3135,11 +3259,6 @@ static int perf_c2c__report(int argc, const char **argv)
>>>    		goto out_mem2node;
>>>    	}
>>> -	if (c2c.use_stdio)
>>> -		use_browser = 0;
>>> -	else
>>> -		use_browser = 1;
>>> -
>>>    	setup_browser(false);
>>>    	err = perf_session__process_events(session);
>>> @@ -3210,6 +3329,7 @@ static int perf_c2c__report(int argc, const char **argv)
>>>    out_session:
>>>    	perf_session__delete(session);
>>>    out:
>>> +	annotation_options__exit();
>>>    	return err;
>>>    }
>>> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
>>> index 8fe699f98542..63d0e28fb991 100644
>>> --- a/tools/perf/ui/browsers/annotate.c
>>> +++ b/tools/perf/ui/browsers/annotate.c
>>> @@ -605,7 +605,7 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
>>>    	target_ms.map = ms->map;
>>>    	target_ms.sym = dl->ops.target.sym;
>>>    	annotation__unlock(notes);
>>> -	__hist_entry__tui_annotate(browser->he, &target_ms, evsel, hbt);
>>> +	__hist_entry__tui_annotate(browser->he, &target_ms, evsel, hbt, NO_INITIAL_IP);
>>>    	/*
>>>    	 * The annotate_browser above changed the title with the target function
>>> @@ -864,6 +864,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
>>>    	const char *help = "Press 'h' for help on key bindings";
>>>    	int delay_secs = hbt ? hbt->refresh : 0;
>>>    	char *br_cntr_text = NULL;
>>> +	u64 init_ip = NO_INITIAL_IP;
>>>    	char title[256];
>>>    	int key;
>>> @@ -873,6 +874,13 @@ static int annotate_browser__run(struct annotate_browser *browser,
>>>    	annotate_browser__calc_percent(browser, evsel);
>>> +	/* the selection are intentionally even not from the sample percentage */
>>> +	if (browser->entries.rb_node == NULL && browser->selection) {
>>> +		init_ip = sym->start + browser->selection->offset;
>>> +		disasm_rb_tree__insert(browser, browser->selection);
>>> +		browser->curr_hot = rb_last(&browser->entries);
>>> +	}
>>> +
>>>    	if (browser->curr_hot) {
>>>    		annotate_browser__set_rb_top(browser, browser->curr_hot);
>>>    		browser->b.navkeypressed = false;
>>> @@ -973,6 +981,18 @@ static int annotate_browser__run(struct annotate_browser *browser,
>>>    				ui_helpline__puts(help);
>>>    			annotate__scnprintf_title(hists, title, sizeof(title));
>>>    			annotate_browser__show(browser, title, help);
>>> +			/* Previous RB tree may not valid, need refresh according to new entries*/
>>> +			if (init_ip != NO_INITIAL_IP) {
>>> +				struct disasm_line *dl = find_disasm_line(sym, init_ip, true);
>>> +
>>> +				browser->curr_hot = NULL;
>>> +				browser->entries.rb_node = NULL;
>>> +				if (dl != NULL) {
>>> +					disasm_rb_tree__insert(browser, &dl->al);
>>> +					browser->curr_hot = rb_last(&browser->entries);
>>> +				}
>>> +				nd = browser->curr_hot;
>>> +			}
>>>    			continue;
>>>    		case 'o':
>>>    			annotate_opts.use_offset = !annotate_opts.use_offset;
>>> @@ -1106,22 +1126,23 @@ static int annotate_browser__run(struct annotate_browser *browser,
>>>    }
>>>    int hist_entry__tui_annotate(struct hist_entry *he, struct evsel *evsel,
>>> -			     struct hist_browser_timer *hbt)
>>> +			     struct hist_browser_timer *hbt, u64 init_ip)
>>>    {
>>>    	/* reset abort key so that it can get Ctrl-C as a key */
>>>    	SLang_reset_tty();
>>>    	SLang_init_tty(0, 0, 0);
>>>    	SLtty_set_suspend_state(true);
>>> -	return __hist_entry__tui_annotate(he, &he->ms, evsel, hbt);
>>> +	return __hist_entry__tui_annotate(he, &he->ms, evsel, hbt, init_ip);
>>>    }
>>>    int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
>>>    			       struct evsel *evsel,
>>> -			       struct hist_browser_timer *hbt)
>>> +			       struct hist_browser_timer *hbt, u64 init_ip)
>>>    {
>>>    	struct symbol *sym = ms->sym;
>>>    	struct annotation *notes = symbol__annotation(sym);
>>> +	struct disasm_line *dl = NULL;
>>>    	struct annotate_browser browser = {
>>>    		.b = {
>>>    			.refresh = annotate_browser__refresh,
>>> @@ -1173,6 +1194,18 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
>>>    		browser.he = &annotate_he;
>>>    	}
>>> +	/*
>>> +	 * If init_ip is set, it means that there should be a line
>>> +	 * intentionally selected, not based on the percentages
>>> +	 * which caculated by the event sampling. In this case, we
>>> +	 * convey this information into the browser selection, where
>>> +	 * the selection in other cases should be empty.
>>> +	 */
>>> +	if (init_ip != NO_INITIAL_IP) {
>>> +		dl = find_disasm_line(sym, init_ip, false);
>>> +		browser.selection = &dl->al;
>>> +	}
>>> +
>>>    	ui_helpline__push("Press ESC to exit");
>>>    	if (annotate_opts.code_with_type) {
>>> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
>>> index 487c0b08c003..3675a703de11 100644
>>> --- a/tools/perf/ui/browsers/hists.c
>>> +++ b/tools/perf/ui/browsers/hists.c
>>> @@ -2485,7 +2485,7 @@ do_annotate(struct hist_browser *browser, struct popup_action *act)
>>>    		evsel = hists_to_evsel(browser->hists);
>>>    	he = hist_browser__selected_entry(browser);
>>> -	err = __hist_entry__tui_annotate(he, &act->ms, evsel, browser->hbt);
>>> +	err = __hist_entry__tui_annotate(he, &act->ms, evsel, browser->hbt, NO_INITIAL_IP);
>>>    	/*
>>>    	 * offer option to annotate the other branch source or target
>>>    	 * (if they exists) when returning from annotate
>>> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
>>> index c9b220d9f924..937effbeda69 100644
>>> --- a/tools/perf/util/annotate.c
>>> +++ b/tools/perf/util/annotate.c
>>> @@ -2622,7 +2622,7 @@ int annotate_get_insn_location(struct arch *arch, struct disasm_line *dl,
>>>    	return 0;
>>>    }
>>> -static struct disasm_line *find_disasm_line(struct symbol *sym, u64 ip,
>>> +struct disasm_line *find_disasm_line(struct symbol *sym, u64 ip,
>>>    					    bool allow_update)
>>>    {
>>>    	struct disasm_line *dl;
>>> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
>>> index eaf6c8aa7f47..bbe67588bbdd 100644
>>> --- a/tools/perf/util/annotate.h
>>> +++ b/tools/perf/util/annotate.h
>>> @@ -170,6 +170,8 @@ static inline struct disasm_line *disasm_line(struct annotation_line *al)
>>>    	return al ? container_of(al, struct disasm_line, al) : NULL;
>>>    }
>>> +struct disasm_line *find_disasm_line(struct symbol *sym, u64 ip, bool allow_update);
>>> +
>>>    /*
>>>     * Is this offset in the same function as the line it is used?
>>>     * asm functions jump to other functions, for instance.
>>> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
>>> index c64005278687..e544e1795f19 100644
>>> --- a/tools/perf/util/hist.h
>>> +++ b/tools/perf/util/hist.h
>>> @@ -713,12 +713,14 @@ struct block_hist {
>>>    #include "../ui/keysyms.h"
>>>    void attr_to_script(char *buf, struct perf_event_attr *attr);
>>> +#define NO_INITIAL_IP 0
>>> +
>>>    int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
>>>    			       struct evsel *evsel,
>>> -			       struct hist_browser_timer *hbt);
>>> +			       struct hist_browser_timer *hbt, u64 init_ip);
>>>    int hist_entry__tui_annotate(struct hist_entry *he, struct evsel *evsel,
>>> -			     struct hist_browser_timer *hbt);
>>> +			     struct hist_browser_timer *hbt, u64 init_ip);
>>>    int evlist__tui_browse_hists(struct evlist *evlist, const char *help, struct hist_browser_timer *hbt,
>>>    			     float min_pcnt, struct perf_env *env, bool warn_lost_event);
