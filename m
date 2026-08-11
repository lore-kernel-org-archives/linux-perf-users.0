Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB892D2394;
	Tue, 11 Aug 2026 16:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786464063; cv=fail; b=qsqWl+ihTyaSSskDKALY2VGTcAWx1bWG+ha4oFaLWAZvFGSAp1qcKphSBt2I8x1Q2Fce+jyEHzBLAYc+oT3/9Pt5+U38L0hQm/3yqhohUK549ZTKrt9ev5zXIVfVUX9QlY7bAed0lGNut54zTOnO1C3qlO7QuO2DlLwTuXHhDjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786464063; c=relaxed/simple;
	bh=57n605jxtzp6W2BrJR6ULTVluQRUvSxki/NXweBgez0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gkYjje0Iwis8aLQa0bllAs46eZvglzf313cRmjjJRyPvWgSQ+RajeQjvUfDfQKFQSGn6jFU0BQXgYjDMZ7YZTJLLuXwkIVx2TUsTZhVwzREROKG3/pF5DJfdSkeqadxW3tn9OQJNYpgMWwjxVVW0Zibib3JKFgizON0udI1Ulks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XxAjhu7W; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XxAjhu7W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786464063; x=1818000063;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=57n605jxtzp6W2BrJR6ULTVluQRUvSxki/NXweBgez0=;
  b=XxAjhu7WDvn89Whp7yyjN6NaiRyqNyGt1gGXVpWtCaN1J+89dFksCJyl
   WJLSqq2EtSs1E9WI1B7wi0zQAn7OFWDli7kTCdqtQOb/tQ/1qfDn2Cyga
   sX0/AYPIq+XWTV8CSg2pt3AWo+sD0DX3HeAH/oHFhMRbZzNEVp+uRT/yg
   /3godHAdveN+uUwLZhdsFOqSYtyIKtGIpgkW9uWBY5eY+LAcloM5VlBGb
   +YB36y7mx66dm7e2/ldh6muS+ktoU08QydAhSNruUoYj+K0rPHv9zuuxL
   Kk2k3VdUtu94ttr0FZPG1YIKoFlk6tFF2zADmsBdHJleAMyWu/rExgC9Y
   g==;
X-CSE-ConnectionGUID: 5sOWx/wvSpCN5ldrvCIfXw==
X-CSE-MsgGUID: BEETkXiKSTGSCbVZMyXisw==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="109792172"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="109792172"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 09:00:01 -0700
X-CSE-ConnectionGUID: GuBdCHMiRlOTgnCNUzHong==
X-CSE-MsgGUID: ys3ilNwgRBi2ikjS9iEttQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="259530575"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 08:58:40 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 08:58:27 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 11 Aug 2026 08:58:27 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.16) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 08:58:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FSeLrU9RapFk7X6WWkTP4hlmyhj9UjeTPVqdMzFM6qNUAWoxm7EIqyut2WDtKaFJtJZe836XHklSIGxQ+TS6WXbMMwwet94kAtYiC344itN6eW+4ktwOvxT1d3wBMY/BuLqfz7NDieU4uPOXHOQMUA/97dNODGyX6b+DXtNftFRbzXgjSdoMSKGDNDnAAwCBudxNsM+ZkiktTKsRvwnOxb+yto+Q+/DTGqbZRNjuRAn16WolJmLQCyOOvTQAG4M7yZIrByroLWsFXRxdXPBDZrB8h3F53Kgxr6FzpDGEEvcQQxSp4BS5l/X5lAywvbOjwXC7S+vjPTvAAN6BNrFD7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQumvgAGQzRPOvO0zyp6nlPepvPeyW7qIncw05CQbi8=;
 b=mjupxTCc+fOM8AytRABK6cln6AoSLDwbCVxzbM4QRGWRFdnHoQKoywZEWbnoIYf93SVyq2k4c/IXJo/nIeDfmZMEPblpXii1VbT0K7v6UMBul0KKwya7altrHP3Q2QQOGZKvWVqeQh3eTzC9U42f5cu8kEW5he+frR//U5jNSzBSlK1YKejc9B0HZJjV2SPjRSd+imYpKKZQ2VXcutr2EkJi+d3Dm56tq62OUvTJpebVXvnP4HbQwx1OYc8LOT0lTpVjkd/BaBG3y0goC4+0rGYFqALNs4bCbc0qV27U7T3dIp6iiJflIe+syYPdj2NiDDL2TbZUd9YAlOZx7muKMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DS0PR11MB7286.namprd11.prod.outlook.com (2603:10b6:8:13c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 15:58:19 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 15:58:19 +0000
Message-ID: <544211a6-29c5-49ab-b9f9-543f199b9533@intel.com>
Date: Tue, 11 Aug 2026 18:58:12 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] perf thread-stack: Report branch stack hw_idx as not
 available
To: Amir Ayupov <aaupov@fb.com>, <linux-perf-users@vger.kernel.org>,
	<coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>, "Suzuki
 K Poulose" <suzuki.poulose@arm.com>, James Clark <james.clark@linaro.org>,
	"Leo Yan" <leo.yan@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo
 Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	"Alexander Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa
	<jolsa@kernel.org>, Ian Rogers <irogers@google.com>, John Garry
	<john.g.garry@oracle.com>, "Will Deacon" <will@kernel.org>
CC: <linux-doc@vger.kernel.org>, Mike Leach <mike.leach@arm.com>, "Jonathan
 Corbet" <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, "Swapnil
 Sapkal" <swapnil.sapkal@amd.com>
References: <20260803090640.2412336-1-aaupov@fb.com>
 <20260803090640.2412336-2-aaupov@fb.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260803090640.2412336-2-aaupov@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZP191CA0050.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::23) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DS0PR11MB7286:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c90ca1e-5bcc-4d10-60b5-08def7c15ca9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|11063799006|4143699003|56012099006|10067099003|6133799003|3023799007|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: Rd7N7PJS1A6t2ZNUWUEqHry3XaYqpGPZyw4AyCaafO629UOBe0lItb8pPY5OLv4vlC2JIgPTT6pQuFEGMjEZdI/lqptAlQeiAWBXtLlGJIeKky1EPBylfMwjSaDgUlua3dLsGvK4icX2KJj1YCfUCduUahxs+leSy+njC7EibLxcnSVETZf+E2/OZ13fKtobYuBIDJSxRNfN17t/JfD+vwmO9VRDkU74dggHZbhoeEJqUZGu2fhurcVkU+NIxWzrWmcTqdvS51b3wlY3axEBhJgi5QLtaZ4hAzEI0SypWwNi7SZGHfDmkp/TTMGEsKHDvubraqro6uFrtV9mBzcr0bB7O3d6YbpKci+ZLtc5N3uRfRyRB3y2fn+I15tvsq7FkyFhscwTxhOmYmj2exemsgkmZCoP4iSp7ijcjqU+hrex4Th9MRX7+F6qlzpMAkV/JW4JBbgcZlkQ6XhtTLwlcgYshTznNDMbYgxp3Q7AASmIUdIHfcvr3n3yJxlCYSyg9HXNfrMLgkYd5kRe/Ndja3DJMQ68gJeJjtKhJlSDzT7zwcdpEGONy5fG6SVATAtplvxRNZzPuzjv6RyLd5oE7UkKn9qCodU4wiM/LwnFuV0LzWAAG56Tzji3qXsRTxekSF+m83kxtG26539RATsIq3MHV5xZfGFriRhLQIMbOIXXr1hkpMw2hoB0DuaooF99y+jZCtrTDwNSOeow9zL43g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(11063799006)(4143699003)(56012099006)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WW1hVmxPZnBFZnVTc2g4NUh2dU5JNWRmaWdhNGZmM0dPaTZWRjlaTmlRRkY1?=
 =?utf-8?B?aFphVHQrN2JwOFRkMkZxTFhiOWFOS2huWWEyWjM1Yy9zTi9CN2ZENzZqMTRj?=
 =?utf-8?B?c2hIUkN5Qi9ETzlqVEhPcVlzTjdRdVM4NWxiSWphaE0reHdHbFJRdk81NGQ3?=
 =?utf-8?B?UjRBeWhiQjVldkNLampHZUZTekM2UlJTUGE5YzB3SFludHdzREhETURITTlB?=
 =?utf-8?B?U282ZzA1Tk12aXIzODdzamxKSUJyNmtIbGlaUVI5a1NKUTREejlzMkg3Vk56?=
 =?utf-8?B?Qm9kajlmYUUxelJaK1RFazBRRDhNbkdWTk0zcG1GWXV3aUxTMlRIRkZYYVBr?=
 =?utf-8?B?QXBKc3ZHckwwL005UFQ0akk2eGVVUUJiSXJGeVI0TDI2eUx5d0d2dEttVlZJ?=
 =?utf-8?B?Z2duMWphdTNtMUxTaG9QcTE1YS9CMGVsWHEvbUlrbTZCUS8vams0RU5JK0s2?=
 =?utf-8?B?NllZeFVRQ0lsMjFzYktWS3N5dFgrc01hTmY2NXR1Y2dqd2g5cVVxWC9VclNJ?=
 =?utf-8?B?TmdzN25yRnRaK0lpOFJEYVpVOUF4WU5XS09zMkpFUjl0K2NlaWdsRllNWG0z?=
 =?utf-8?B?WVZScjJOZGlKUHp0TDdkcHM4Sk1mSElSL2wwamxhRDdCR1gxS0xvcWlkN0xj?=
 =?utf-8?B?eEVtTHBCZmxGNWlKSXo3T1k2Ylcva2VpMjMreEJTWmVBczUvM2RmN0xwNm1E?=
 =?utf-8?B?NGZPZXA3b3FDQ1NMUzRveWhSbjBiZnRxZ2lmT1JWZlRrZEpHQjdIOFJtd1Bu?=
 =?utf-8?B?ME5VR0pkN1JrZ3JrS29IZUI2RWVpYy9aRit4cDVIaUppTWlBZ2lJZ2RxMGl6?=
 =?utf-8?B?KytNNUdUQm82N2dxdDVpWFUyWG5LbW1NWGVVWTEyMG5YRUVYNFMrNy9BNFhI?=
 =?utf-8?B?d09jakc2dkhoS2tYSVBVUHlOeHl1U045SDVBRFhuOWJhcXprTVdwL2pNNitq?=
 =?utf-8?B?YTgrTWt6L1JtekZHRWRyQUp0REM4Q1JRRFRvbCtGRzNveTBxOFZpcXl0Tkpj?=
 =?utf-8?B?Q1VkenptM1FwTUsveVJPK0J1c0VQL1FYTXFiVjU5bXRRTXVmdWdqVFRVQkFE?=
 =?utf-8?B?c2Y4Zkt2Q2prS2tUaHVVdU1GSjFtZUhpRWZDR1ZSaGV4RWQvN1JDcU9naDNQ?=
 =?utf-8?B?NklHK2gzVmgrZkxNS3laWjM4cXhhY202S1prZzlmMGxuRzFSSE1MK2Jnelkv?=
 =?utf-8?B?SkFmV1hSWWVjNWFuWXl4MDFpZGdTQis3eHpuYzNrZzQxT253T3d2Vzc3UXA2?=
 =?utf-8?B?d1pqdVY4VElwaUUrbDZwVkovcHpPQVBzNmJadVIxWER5Zng3ZGpOaG4vaXMz?=
 =?utf-8?B?VE1xMWEyK2RocWhtYklSR1cwdUVzQ3RBVTBYeEZZT2dscUM2aXdhbnh6cElw?=
 =?utf-8?B?Q1Z3akZBanZRMERhOHlzSVZWVzdnWUo4aGFpU3NrS0JTdU8yZS9wbVE4c2ox?=
 =?utf-8?B?Z3N1eWd5VkdFcDdhKytMZzRQejFQQjIyMFVsd21zbEZwaDdDY0s2N3laQ0pL?=
 =?utf-8?B?b3EveVBhM0srdkFodENyWVZTOGdUMSsrQXRqSFlVWm9QRk1Hd2FOVkxjY0sw?=
 =?utf-8?B?Vm80Z3F0cFlIb2l6WXJpeFVEMW51RjYvMXo5NEk0Z3NDRUU5c1ZUeGZja1hu?=
 =?utf-8?B?WjZDbTJDR3huNXJ2RmxyQkl4bUlPVHJJeTk5VXdqYVJDWG12TEg0K2FtTHNl?=
 =?utf-8?B?bDlBVGh1cFNEYkMxMlhGY29kdFQ5djZITGRjY0ErTVRnVy9aR3B6MFlrZkoz?=
 =?utf-8?B?N096WStZR0F3WUhOUWNFWTc0YlZiUE83Wlk1bWVmcEcvNTFpaC9sbHlSV0Jx?=
 =?utf-8?B?bUFhYjJQb1dpWUFmU1ZnTDYrYUQxeTRYaEpkQk5CZnljSDRVOHhpY2RnZTMw?=
 =?utf-8?B?aHFRZ3JvbVZJMVZEWWxLTTVyN1lJREJpaS9pQ1p3b3RWWklFOXQxbUNFOTVi?=
 =?utf-8?B?VTBxTGUrM2lkSG9VWmtvazV3Y1lHU0hzc2EzMGM4eWprbE1BVndxaVJ5VmRS?=
 =?utf-8?B?c0ZPVGRJdW5HNkZjYnljNkhXVUt6S2VUNEZrVFhkd3ZKcVhJbFg2aEkxNGtm?=
 =?utf-8?B?R2ZmOVRseXRiUWt0eVo3b2FkWUhSV2Z5YTRKZGpzcUF5QlZFVWorWnpvTW04?=
 =?utf-8?B?cmNkUWk2QlI0WXVRbitmYzhkY0Y4L1hNamIrSHdTditSZkN4RkowQ2Z5OEN3?=
 =?utf-8?B?QjdMVG9YWEdOOWd1aTVyVmU5clJqUW1YcThvZ0NrZU54TEtjM1BGUHU1OGRw?=
 =?utf-8?B?a1N1NjNTTEdKenY0Q2J6ZTAxcVpjaUJtUHEzQStGKy9FNW9STGw1bmdyWUgx?=
 =?utf-8?B?OHpNRHk1QVRsWlpGZDdGOWR4TzV4ZkJNM21VNnppL0h4ZExCVTZRQT09?=
X-Exchange-RoutingPolicyChecked: kz4AmrOr9kCrI7tojkaR4cEkxfhbrSZBnWYMPe20KjttNR35kNsvVsmhv1gUkXaAte4UkCwHot6prKyg8xQo1RggR2jIiquMxI9qiG9j2RrnOnQm3q29MTmgaajgV6judz0gnc5rLWujV9mpC8IFaffcxd4VrfbKlbNHaH2jO3FAXdmUifsJfQyvm9TupFXhg3cYCmrE7K25bpyk4m3oIvId1uvCB+0rl2xbve7KmQpywzQ63s8cD8pVXgHBAWrub/WBEpdC9SO5b1Sjy/6OD2U+v9aAPPUdIVLnN7hfoTc7m8mYV92WwoafmzfbvsyELjoKgSrXxQHycvUuVnSIGw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c90ca1e-5bcc-4d10-60b5-08def7c15ca9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 15:58:19.1697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: faEtCN1MtIReG3l54KWZS2r/sfj63BbZYIOX5qwaZfaPIsk6IkzLMpDjYAVi7plDiHUc4U3X9aKJCjg3CT1Jaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7286
X-OriginatorOrg: intel.com

On 03/08/2026 12:06, Amir Ayupov wrote:
> thread_stack__br_sample() and thread_stack__br_sample_late() fill a
> caller-supplied branch_stack that is typically allocated with zalloc(),
> leaving hw_idx as 0. Zero is a valid hardware index, so consumers that
> honour PERF_SAMPLE_BRANCH_HW_INDEX see a reconstructed branch stack
> claiming to start at LBR TOS entry 0.
> 
> These branch stacks are reconstructed from instruction trace and have no
> hardware index at all. Set hw_idx to -1ULL, which is the established way
> to say "not available" and matches what intel-pt and cs-etm already put
> in the branch stacks they synthesise directly.
> 
> Signed-off-by: Amir Ayupov <aaupov@fb.com>

Fixes tag?

Otherwise:

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/util/thread-stack.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
> index c5ce741b07446..1a3dffa83bde2 100644
> --- a/tools/perf/util/thread-stack.c
> +++ b/tools/perf/util/thread-stack.c
> @@ -624,6 +624,7 @@ void thread_stack__br_sample(struct thread *thread, int cpu,
>  	unsigned int nr;
>  
>  	dst->nr = 0;
> +	dst->hw_idx = -1ULL;
>  
>  	if (!ts)
>  		return;
> @@ -686,6 +687,7 @@ void thread_stack__br_sample_late(struct thread *thread, int cpu,
>  	bool start = false;
>  
>  	dst->nr = 0;
> +	dst->hw_idx = -1ULL;
>  
>  	if (!ts)
>  		return;

