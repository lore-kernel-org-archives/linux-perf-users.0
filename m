Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D5E8460;
	Tue, 21 Oct 2025 04:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761021938; cv=fail; b=uPGSqfgcPcjg72uILSi7xrF7e8X/oSGrCKPvgb9/rBc5iRINoWR7ZmaA1WABGs+xs35tKGqndfmIC4pcHM8Wmo4rz2RL3CF4H13HBxGRgxA4b5AYgdo0U2vSF4wYMPgbBBRyvuL+Fn7asK/p31HEv9R3KDfWHG3eijBikgQnW3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761021938; c=relaxed/simple;
	bh=na0g3HXi70lPGSbnKew9UhMw/loT6DOGbvqjDCL85B4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H4hfmyU0c4RlX1MjAfi9zQ490imkFj6KY8gLQAnyYsmrKIyEM9iOJzVQvMR9msubhYnDQSZQuSzLGEMpKapXZmXjBJxaD6/U5jUol6tQ1o6ryUTPT+y3zbdkdYCGO2lzJ+/gS4OtnreU8sH1q8ULEzmMrVRvj+3qWaljdUKMtag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aMDoW9FT; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aMDoW9FT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761021936; x=1792557936;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=na0g3HXi70lPGSbnKew9UhMw/loT6DOGbvqjDCL85B4=;
  b=aMDoW9FTMcwux8xFAHTjtCLzToWOn5V2FmdCYZwFkKGALDLr/bYEPp0/
   yIfIWFrQS4S9q7Zru51EEPCNYKsWuOd8EqTUBvWY/re53YticNvWGnxDa
   C0bnS16NZixfKUwD1uIWnOBde9goQ06MWZVRW1pm4i/P9d6nXBMbYY2m0
   lH7JX0hqDR9wfNd1Obe2iiL5gyD6Sh70zVXJKiymujf9Vgz3mmVO4ZH5N
   K11ehpr1XSyZvWZVmwgRiqPBKmxWbFfuNvqX0A9f8K4uvaH1lBOE06CGe
   KVHNjvpIf1t7YQ255l65bfAdO2aeVWBU1mbJXJgGxVXv4upvBjZORMT8t
   A==;
X-CSE-ConnectionGUID: KqYaOI8eS16jbSXDS99nqg==
X-CSE-MsgGUID: DQjTfy+qRzatKfAEYSCSJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73814997"
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="73814997"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 21:45:36 -0700
X-CSE-ConnectionGUID: wv5YLd9JQEOntr2Tv08zlw==
X-CSE-MsgGUID: AkwuQGdLR0uemS2VIfLDYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="207175739"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 21:45:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 21:45:34 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 20 Oct 2025 21:45:34 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.26) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 21:45:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ezhIdwwmkmI8ycmxZIokEXDYqFjgY8PjbclBAj/aeorFnvEfScICyq8z1tNgkJlSEvKPpqLjKwA/G0a0ioGT3Lo+FRmWgZSjqGW/D5FgjxQTN5rjKmprzus4R+niT/R5e872hsYN5hB8JE53ms1eySTKjzs6dbUMtLAWkuNu0nxa7GAOG3Cu4ZXI3bH/JGgxRf2c31HCw7aa/akgTUfAJmyblyiy9MLuXy+aR7FBeRNeAa/TB4dpRwX7Idx7azgF/cCsmmvI2OJ+xfDbKRjiQk85p+ikjbxw2MkXDbtZmy5DAgIlvh9ETI5xrY+WY4BU6C4sJtidm1VzMSMXxxkIUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CjZi2g5HAVsSi2q5U+UVh08qknJWzrHBJqbpSB0O7wI=;
 b=Ouw/tGaHesrXnQd6E93543liin70LiZ2meuRmWnIK1JAs+HT7JV/grDW6/tMmODsL+aQohTQNHWC6/2eyalU0lyPXIdgFGAGgZ6xpDadC45HVWRk2zCtabdyiR1eLbRRJ1iqwNtMutddW9rrToc4T3OdJSjJyRyIYU5NRIxijMFtqMsxb8GNE0EAsk341TMbDMjGVJSHPDl/Rycko2/6MG+ZldioS2CHIpQh0Q65Bck+H1woWVrMb8m/4Ak3ma0Tup8pQUplLJC/k+UvcdTHUpdMwFVBW9YVTzmGhHQB1EabwOkre3i4CmGZintEEACUZJ0LiEoaQFFT4kJaO3gdmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB8289.namprd11.prod.outlook.com (2603:10b6:303:1e8::9)
 by IA4PR11MB8990.namprd11.prod.outlook.com (2603:10b6:208:56b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 04:45:32 +0000
Received: from MW4PR11MB8289.namprd11.prod.outlook.com
 ([fe80::d626:a4f8:c029:5022]) by MW4PR11MB8289.namprd11.prod.outlook.com
 ([fe80::d626:a4f8:c029:5022%6]) with mapi id 15.20.9228.015; Tue, 21 Oct 2025
 04:45:32 +0000
Message-ID: <a12268cc-3e7b-4432-a620-6a7400f1da4a@intel.com>
Date: Tue, 21 Oct 2025 12:45:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf annotate: Fix build with NO_SLANG=1
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Ian Rogers <irogers@google.com>
CC: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>, "James
 Clark" <james.clark@linaro.org>
References: <20251021030750.254186-1-namhyung@kernel.org>
Content-Language: en-US
From: "Li, Tianyou" <tianyou.li@intel.com>
In-Reply-To: <20251021030750.254186-1-namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU2P306CA0045.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3c::17) To MW4PR11MB8289.namprd11.prod.outlook.com
 (2603:10b6:303:1e8::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB8289:EE_|IA4PR11MB8990:EE_
X-MS-Office365-Filtering-Correlation-Id: f40c0a72-5da0-4221-81b8-08de105caa27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bytDd2J0dk9TMjRlSkY5VVdNSFRtSGZ1ODZBcDFkU0JvRXQ0cDQrU0crY1hw?=
 =?utf-8?B?YnNzc1hpamgyQ1RpbjRKWklEWFJKeElpRlRpMUVkdjFnaDRqRW5PZTRYMEtW?=
 =?utf-8?B?Z1FLa1p6WnQwOU5IQ0lEUVQ5RVpxa2RjWE56Mk5xODdGVy9qdjdHVURldVU2?=
 =?utf-8?B?ZlZQYUp0K3F4cHF1b3RhZE9kOW16VWxJNk1qWW9UQ0VSZlVrSjVjaXRYRFZ0?=
 =?utf-8?B?N0YxWHMzZGE1bFlKaTcwRGR5MzNHTm1JRi9lZERTZlZwZ0hJaVhHdHFoTjJ4?=
 =?utf-8?B?NXdoUnNiSHNPRU1qUTNkMFpTZ0RkdEJocEk2ZFVtdVB2a3RiTkdPaW5kRStt?=
 =?utf-8?B?Tm52N202ckV2S3V4UkxnMVZwNkRDbnVQblNGeU1WbXE1MW8zbjNTK0hzV1VX?=
 =?utf-8?B?cVg5ejdnOWFzbTRUaU5RY205WW9SSEJwN05YNWhQRzRWYjBjbWpXeVE0WnY0?=
 =?utf-8?B?OTY2U01Ebkwxd1RSa1FxbG1HUUZPUktOYW9Vdm1lSTJQblJMUmNrbVpCTGNH?=
 =?utf-8?B?R2RiT29WTHltdmUvTVYzQ1pxZ1BjVm9RMWVqdDBFM0hIYlZkK3U5V2xYbmVt?=
 =?utf-8?B?Sjg0d09nZE11elJFYklXSmh0bStTa1lrQVZ3czdxWjNVNGd1Um8vTGNpTUlE?=
 =?utf-8?B?Y2pZOVNmMGE2OHA2L3VScEp0czc5UjRhN2tKTTBKT2R0Q3dDRGFjblFWemZq?=
 =?utf-8?B?Y3gyT3BHRjZkUGJaeWdBd0hYdlF0YU1NQk9RRVZneWc0ZHZzQTkzQmUzSS9P?=
 =?utf-8?B?YWtFWGt0a2lxWE11QnZ4c1d4cm1TN2ZLSXNaWjA1bUF4K1NMME1JUFBmUHY5?=
 =?utf-8?B?MTA0a1VzempWTklGVituQjR2WWZVRkwyUy8xM25LczJtWTJBZ0diYUp2bXNM?=
 =?utf-8?B?bGY3a3hlSU1HYmYyU3M5aFMrT2JQKzlaWGg0SnhyM3BqaWtlbEo3WVdVVzJZ?=
 =?utf-8?B?QitpR2VMZzVZMWxTK3pzU2hYakFBeGpDeDNkT0p5azRMcVBRRzZ2ZkppaFVo?=
 =?utf-8?B?RnNjYTJrcHFBNnRkNEpTK1o1ejdHa0xHcUxyMFNRV2Nnb0tmODMvOFc5VTY4?=
 =?utf-8?B?YTlZTXBadkNJbkxjdnFzM3hkTkkzNnFVOVJuSDVHSEowd2hkZ2o0dUxvcFVy?=
 =?utf-8?B?dm1OWnQ1SnNHaXBHcnpnNGpQSHhIczYrNWFGNU43aEJDakk3UVQ0UHpQdUFa?=
 =?utf-8?B?Sngzc3hkSldrZUlsSlRiUXNKSWp6aUtCaFV6TUpNMUJIT3Avd0lCcFZoVzFs?=
 =?utf-8?B?Ynd1QitjbGNXRkVHdzh6ZzFTaFFIRmJQaXpqdytVUkdNR3BwZ0FRY2tOMWRP?=
 =?utf-8?B?RzNVT1V2czMrZFlDbDZVQ01XMjgrTzZESjBmYWI2QWhHTmxyajRKK0JRejZm?=
 =?utf-8?B?TTNKRVhDZ1JHcXA4KzFwZEoyNDRnOEZYNXAydVpIUFVkamtLZy9sUi9xanph?=
 =?utf-8?B?T1ptZ0Q4TnFOQmxUeW02TjdGOE85ZmRGNHY1WjlDTXBuVHhvV0NXcGc0dGQy?=
 =?utf-8?B?emFRRUZ6VUtUd0Jpc3o3Y3FMczd0a1VlamVrSjhQY25sZmNzT1J0b3lWREJZ?=
 =?utf-8?B?SkZ5d0YveWY1QXltNzdmemhCWHR5QjdSM1JkOVVFK2VOdlVxWGVFWmpWbFYr?=
 =?utf-8?B?L0poMkFuL0FsVEs5R21vd2tvMUt6YVZKUmZObFNZNkE1c2I4SG5BQzNvczcv?=
 =?utf-8?B?NHpTcTNOZ0doaFEvQU9HYzJ3S25TdmdzdldieXJXSEFiWVUvaW44dkRWd1dl?=
 =?utf-8?B?dGRpNkdFTTE1WVJOOGdwbTBBd3AyVXlPQXpvVHFTc1dyVUd4ZXFrZGRZcC9Y?=
 =?utf-8?B?T3hrTjB3bGxlQTZ1cU8vWHdXS3EzZisvUGZ5VXlmUy9IME9SOWRzL3BvQUxQ?=
 =?utf-8?B?cjUySkNzMWlob0x3UWpwR2FNRlNYLzFqVlFjbStRR0V6Z2RCdlFUenVWV0pn?=
 =?utf-8?Q?i11f8gPSVTBRadZW05vZFSwvJ0Ptp+RI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB8289.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDJJUklKSWtLNUV6bXhsaUNaRlowU2JBdHVPTEMrS3R5QUJ0VWVENk1LeXo4?=
 =?utf-8?B?ZTRuNVczYUpVc014dy9lOTh2YTFoOUkyMVNlSUM5Z0lOWTBZdVpkTzhsRkRv?=
 =?utf-8?B?OTNNV2VYLzRkZi9vVVM1TjdIRHplby9QTzFEb0dVeG5vWWxacFBLVHViSTVJ?=
 =?utf-8?B?REY2RGcwUmE0VFJsdURjdWVPL01uRUhHU2FmKzA4eVhRL3pJNGxia2FxZDU2?=
 =?utf-8?B?ZWNkVWZZZXpLaFdLNzhsNEJTUzdNWkJOSDZlbzNjVk1vN1pEaVlZTytJRWFs?=
 =?utf-8?B?VDBXbjF0QjlxcHEvRU5jcHhQSm91ck12eGZiU2FRWmpnZkUya1VkUjJERHIw?=
 =?utf-8?B?Q0NXMThhcnA0Q25tRkpnR3Q1andwQWdYVFZCQStrRjdTQUxzRHZOVUxFTnYw?=
 =?utf-8?B?am5TVWhCVVByNUcvand2b1NQWTBYd2cxM1V2WnppdWIxTFR2MWtqc2s1ekVz?=
 =?utf-8?B?NVlscXNCOUVWU2t5RlQzZ3Z6UmlQVksxdnhJN25JWU1qY0lxektxbWhqSEhB?=
 =?utf-8?B?cHYrZGF4RlU2NVhlTUtCM2hYL3IvVUtZKzBMejh4dmF4WHpteTdWNU1EZE1i?=
 =?utf-8?B?bGRBaXV3ZlFKMDBPY3NkbUpXZmlZakpyZTkrS0ROV3h0d3NwS2IwQmRISC93?=
 =?utf-8?B?aVhYaVdSdXhzRVlybFVZdStlOGRBOU1WVmtsZzN5dG1qbFdQZHVEamdQdWgy?=
 =?utf-8?B?SzNZeGs3TkhrUCtnOHpGeGEzaFRKNk5ZaTJFTDlCTU0xUkdUai9ZOHBER2tC?=
 =?utf-8?B?SnM5TDhFWk5ud0JiY0oxSnd5amlYZ2luWERzQlJIaWFEU1Z4WUF6My9aWVpR?=
 =?utf-8?B?bnBveFFmUEdGMUI4L0Jic0ZJd05FcFlFblZIbkNLZjhxMkd5UVk2YTZ0cVJP?=
 =?utf-8?B?UEp4L29DVmtzWklEbGpZS0FLTG9pUE41QzFYQlpUelU3U2E3ZTdLdXQ4VUtQ?=
 =?utf-8?B?M3hONmZkK05veEhoa0E5WS9WNWRWQ3I3K2dmVGdjTUpINmZrWFoxMzgwUUJw?=
 =?utf-8?B?eWZ0SGtKNkJaUmt2Q1BLcmpHVStINFRSQlcxc2R4OStlZU5ySVBwc3hNeUsz?=
 =?utf-8?B?VnhPVUlCMW5UaExHQzhqanphZk1JTldIY1B4d2FzYWtNUmxNSHI0ZTlkaDI3?=
 =?utf-8?B?ZVRta2Q4eGtMUzVDakUrTW9Ob0QvYjEwV3BFR0VLaFZqZ0Jtcks3RUV2cnUz?=
 =?utf-8?B?UTY4YmRKejBKVjJuVmRGMDh0WXErWDR3TG5Jb2ZPbXl6WXhLQlV0Qkl6QTJq?=
 =?utf-8?B?QThrbVE5NXk3SmNPMUx5UDhBUTVZbFBVdUZKa1pxNDRHNjZmTGx2RVJqNEY5?=
 =?utf-8?B?bVljZ25wY1FTNU81ZFZ3emg3ZmZycWF2anFlbmlrbjlVSHJDY21QZDlGV1Nk?=
 =?utf-8?B?ZURSKy9rTHZMY2ZrR3c3bjJoWlc3SlRYMzFhSm9NTyswVVpmejRkY1BhdnM5?=
 =?utf-8?B?dFQycjk5MFhPdmNVZ1hKZTZ4NWs5eDJHUlJINnNoQ0JnZ1Zsc0FzRGsxczZy?=
 =?utf-8?B?MkVudkRHNTErQ2lkZFFnUHJqT25wbnVWbU1yQURmU3gvVUtmSndtRk9STURT?=
 =?utf-8?B?THByZEkzNGtTTXlGVm96UXhDRlI2YTgxU2NoS1E1MExQcVE4ODJUcjNhS2J0?=
 =?utf-8?B?WFJad3J6a2llbUlIZHhGRzVQZ0lDQjlPZUluaGxyVzlmZDFPcE9kclpTWHQy?=
 =?utf-8?B?N0FITmpEZVJWUDg5NlFHZDFmTk9GOW13QW5GejhOYkxNTGg4Y3RrYUpTY0FK?=
 =?utf-8?B?cStIUWszY1BYb1B2Q2dhSko5NjNJd2UwMTh4dU9LK04wZVJ2WVpwb3VOR0Nz?=
 =?utf-8?B?ZFdzWTJ5dzlBZW5lUm9QVFRLVkVzbVk4cVRRbDV1ejNoWE56Ri9Uc0hadjB0?=
 =?utf-8?B?dFFCbmpCUDRUOStkOTIxNlY0TEpsYnBRd1oyUGFJN0swYm1sb2dnbFJNWUdl?=
 =?utf-8?B?VEh6Z1Z6Rks1dXFibHF5VUJUQnZGaWRLT1NJdk1XcEpDV3J1V051Vy9kM3Qz?=
 =?utf-8?B?T3dPRjVmV3BuZ1l1TTdERUtCUmxpUWQ5M3NoTTBzdGQ0SUpnVGZYTVhQcWpF?=
 =?utf-8?B?NUdPbGt6OWFHT3BDMmx3Mjh6bTZKeFNQaVpSSEt4QkNMQkNET0xmUGVsZlV6?=
 =?utf-8?Q?36z9ludoSO1R9d5IkaSVogbQx?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f40c0a72-5da0-4221-81b8-08de105caa27
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB8289.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 04:45:32.1003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gEVY5XhOzwoReuCeuzSLIdA5FodU4/B4lOl30vI0Njczyla8Tr+8Kax6HeJLf3oj1DNItdOrDott1zDzk9Ncsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8990
X-OriginatorOrg: intel.com

Hi Namhyung,

My bad. Thanks for taking time to fix this. I've tested with my ICX box 
with and without the patch. I can confirm the issue reproduced and fixed 
by your patch, tested through 'make NO_SLANG=1'. Sorry about the 
inconvenience. Thanks.

Regards,

Tianyou


On 10/21/2025 11:07 AM, Namhyung Kim wrote:
> The recent change for perf c2c annotate broke build without slang
> support like below.
>
>    builtin-annotate.c: In function 'hists__find_annotations':
>    builtin-annotate.c:522:73: error: 'NO_ADDR' undeclared (first use in this function); did you mean 'NR_ADDR'?
>      522 |                         key = hist_entry__tui_annotate(he, evsel, NULL, NO_ADDR);
>          |                                                                         ^~~~~~~
>          |                                                                         NR_ADDR
>    builtin-annotate.c:522:73: note: each undeclared identifier is reported only once for each function it appears in
>
>    builtin-annotate.c:522:31: error: too many arguments to function 'hist_entry__tui_annotate'
>      522 |                         key = hist_entry__tui_annotate(he, evsel, NULL, NO_ADDR);
>          |                               ^~~~~~~~~~~~~~~~~~~~~~~~
>    In file included from util/sort.h:6,
>                     from builtin-annotate.c:28:
>    util/hist.h:756:19: note: declared here
>      756 | static inline int hist_entry__tui_annotate(struct hist_entry *he __maybe_unused,
>          |                   ^~~~~~~~~~~~~~~~~~~~~~~~
>
> And I noticed that it missed to update the other side of #ifdef
> HAVE_SLANG_SUPPORT.  Let's fix it.
>
> Fixes: cd3466cd2639783d ("perf c2c: Add annotation support to perf c2c report")
> Cc: Tianyou Li <tianyou.li@intel.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>   tools/perf/util/hist.h | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> index 6795816eee856e8f..1d5ea632ca4e1b0b 100644
> --- a/tools/perf/util/hist.h
> +++ b/tools/perf/util/hist.h
> @@ -709,12 +709,12 @@ struct block_hist {
>   	struct hist_entry	he;
>   };
>   
> +#define NO_ADDR 0
> +
>   #ifdef HAVE_SLANG_SUPPORT
>   #include "../ui/keysyms.h"
>   void attr_to_script(char *buf, struct perf_event_attr *attr);
>   
> -#define NO_ADDR 0
> -
>   int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
>   			       struct evsel *evsel,
>   			       struct hist_browser_timer *hbt, u64 al_addr);
> @@ -748,14 +748,16 @@ int evlist__tui_browse_hists(struct evlist *evlist __maybe_unused,
>   static inline int __hist_entry__tui_annotate(struct hist_entry *he __maybe_unused,
>   					     struct map_symbol *ms __maybe_unused,
>   					     struct evsel *evsel __maybe_unused,
> -					     struct hist_browser_timer *hbt __maybe_unused)
> +					     struct hist_browser_timer *hbt __maybe_unused,
> +					     u64 al_addr __maybe_unused)
>   {
>   	return 0;
>   }
>   
>   static inline int hist_entry__tui_annotate(struct hist_entry *he __maybe_unused,
>   					   struct evsel *evsel __maybe_unused,
> -					   struct hist_browser_timer *hbt __maybe_unused)
> +					   struct hist_browser_timer *hbt __maybe_unused,
> +					   u64 al_addr __maybe_unused)
>   {
>   	return 0;
>   }
