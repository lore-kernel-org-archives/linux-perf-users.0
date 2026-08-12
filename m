Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687933644A2;
	Wed, 12 Aug 2026 15:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549730; cv=fail; b=npaomnDYVvc/YA2ZmNdCM1UvuvaUJj/+nTy60zqpRTcjxpAKMzjy2MavHrOvdQ1dFu9u7QZMdBnPi3mcNe2dH+TM3Ui41DK4wcLCu4y8xiM6rrzL502jQGRf4E79ya4uekvbzv5JnFRhKptrNG4pzgUeZ9Nsy30MWH1aS2iUk7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549730; c=relaxed/simple;
	bh=fPECpg3/O5gQc3lffLefiNqb9z5lAZKjot63xp64jQA=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y5iubw2T5IUtTNhFqBJfi+DA6OT7wDHr7y4rXFRbxWMBSLWcTu49oSlkjJMncEVGXa+qbBWRtz9GDxaZi6Hl1TA2h9TMUrJP7J6qJjAdr+uyx+lxd02Iaov1nXrw9E28fjMxGRKjXChqeZLvS8t0ePiTGv7cyObozpyCuQLiiLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MZf9ItrK; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MZf9ItrK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786549727; x=1818085727;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fPECpg3/O5gQc3lffLefiNqb9z5lAZKjot63xp64jQA=;
  b=MZf9ItrKcnjoOnghp0ZZs7s8CSrqL9yFI19IMUYlMRtjZc8fqKH/v0AT
   4ekbnZle/RiqDS12wRZWwaZmU9iyn2spXdwKhnJbuyGYTDlHFcMOIOLV3
   fUO/msRAVZ/JE1gzebTjdqV86wi/okTTrP8eefprZ6pJ4/CsrGa/p+DEx
   WaNw+Be7hKQBeYHxBmTB5vS3fs8CAgQA+s5FVzg3chdR4H7VNyiOVoY2V
   4W8Laai6eUKB12tJdWPyUVn3Hlm9zshcGD5L/HxyhSfaNwgpcyodGNV55
   th8nPHW44Iwe4sNzCek33dgHbK3rSCsIQ/bM8LY1n7/IuaBQDiG0CgqtL
   g==;
X-CSE-ConnectionGUID: iqqi1dWuSfWJpzcRw8JPgQ==
X-CSE-MsgGUID: fpzJR/ozRPKm2W0B0yCxDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="104644306"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="104644306"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 08:48:46 -0700
X-CSE-ConnectionGUID: ryH6zu/GS5GzgqhTTL2MFg==
X-CSE-MsgGUID: sXOh/iIVRA+Cy4J2vNzt6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="267537713"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 08:48:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 08:48:45 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 12 Aug 2026 08:48:45 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.62) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 08:48:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nX3VzmSa6qyBd8TqT8NKbS9XvWgU/vL9hmcm0hv+1lq0u7HnTi31tdqsPqxxjRFiYmN7QfotMy+g1gZ//67Dw9u8ykBprW59GeSSRIBzbLFcOS5wzZSSh+av4hlG5MrVOg+EH/wVD9aVRwgo9bRLuySsO6lC7H3YeTSrK1AXi69Il4yEvjsdLOYWfO92eatd1Lya/yEQ8aMkBClyHBVzQ6LFFkw4JHttOT9ww4IVLW3/VdEb84vIyBOQg88XRciv5pvT/UWDG50BH831BTnwjtETN+ACZXxJmfdzEY/gRZ/Tx4Yltk3tdfS1eW3ARA4XxylzcfJHRAmRUS598cPRrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZFmpyPpDQD//k4LJcCUPkHRgovlyg+YxWdNPRxrWzw=;
 b=DerdLbj7FffRyh62rzWyFfrpu4RqfE1GjMHFxDoa7UYifGJNEIJg0EdAOCcbfy6T7e64gzuue584Mg57l/pWaBDlZEm9TVKuOKwxA6PdJNRH8gpUa5nuaL2KMBttowXlGJh5j1w1eVn4pHuExG91684D9+1LOVxjHZGJDXoquWOF3AvCa1OtVIN9Je/GuvR7crHjB5WDYD/TcbOjEJb0kDe64Lsrd8trfNk4rQHgYplRo+nq28qjTs3StIbniSvKZTaxbEe8+W4sMDotKNZsKLT9QZIkLByF+1Xjb7L7ySnQOQoByGkmjWT0BIPXcWjk4Kcx/ucpF2/hlmSADG+rKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SA1PR11MB8373.namprd11.prod.outlook.com (2603:10b6:806:38d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 15:48:31 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0315.014; Wed, 12 Aug 2026
 15:48:31 +0000
Message-ID: <83378be0-1e89-4e31-94a4-ba083f0f7c8c@intel.com>
Date: Wed, 12 Aug 2026 18:48:24 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] perf thread-stack: Report branch stack hw_idx as not
 available
From: Adrian Hunter <adrian.hunter@intel.com>
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
 <544211a6-29c5-49ab-b9f9-543f199b9533@intel.com>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <544211a6-29c5-49ab-b9f9-543f199b9533@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0091.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::26) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SA1PR11MB8373:EE_
X-MS-Office365-Filtering-Correlation-Id: f966c1bc-84f1-408d-0214-08def8892882
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|921020|6133799003|56012099006|11063799006|10067099003|4143699003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: l8feSCMIwDHElz/HblEktV0Qse3zofAR5Y/WhrkqGz71dQkcVlmmkgAwt9B3eIwIfcRy4LfHT0okQKk0B4Kz+TKGyE4vF6BIPGVZWC+KzJDzm0bP2G3VMAW+1KHmZiyN/a4pVh6d/V8yazJkAilWrV09OHFl59bWdUxzX+WME6TP4UlhsJDeMFaE/zOKAqZDhO5COgMsQs7EU8kiqtlqoeHqySiNmDRX9WXRb5smJFAj4WouWDzjdcffGyFIQBM4kv4YnlExhGoZZI7rWavHq2+iHtk04RXq9TpZc4v4Y/Ch5y4PyV+IAMnRvRGlxNV9AsZcFr6LbY0jfloE2a6O/3gKOxf+NmCRb7M6JQS8ZD3GvP1jfIXZhE/xSHCoJyawZcfYf0MB206WpGn7+psRtcNOEesH+wwn9HKtgO1ecjTqSYyTl6EXlyGD/FI7ypc4RNUxVUabLrP01JxxOgfEUDJ8Qr5nNS3J48PX3p/2rBFSVA2y+YZsGPd3BaU9wSUQjLdyTnPAHf9/mmscdeamk/W249kxUQ5oW7T5JqyExs2w+zP9PuJ72Yf2puef1FT5XCrMwVhoAU0VYJIsY1lHyecgiOdQxlJwP5VkWMngsZaHs8HNHJdVytuu/9TiIGLrao7yVU3JasVJz+7TrG5XTcKhySKT9EsSyNCnNBc1QPuTspsPxHv72/k5/6MiwdSqq+UEPe04fE+xWOPJlfdcAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(921020)(6133799003)(56012099006)(11063799006)(10067099003)(4143699003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnljSFlua3RReGdiQi8vMnBZWHRtVzZaV1ZpTURQRW9wN2pEZWdOWnNtazZU?=
 =?utf-8?B?akEvb216cGJWUWwxSU93NnpZWWdvZWpGNHc4eFQ2SVM0N2RJODl4VkNIQVFo?=
 =?utf-8?B?NHAzYU8ya2NYS0RLbEo3b3pNTEJsMjdsZHpZQUxjV1pGUXFickl6VnNDbC9C?=
 =?utf-8?B?bjhPN1Y0QTExT1lUWnBYRjdXd2tGR3FOQ0M4TTRuVDMvU094NUV1cXZ5UWQ1?=
 =?utf-8?B?WVp4WkJZWlVReHpVTXp5ZTUwaUlmd29KWDlpeUJCaDBnejBlZ1lQVUNhN1lL?=
 =?utf-8?B?ckFCbTVzb1BFZUlDVzhjV3RQQ3JjTzg1aWFYK0RoUytTRDRlMElHb013eDkw?=
 =?utf-8?B?MlZmL0ZLSitjay8yR3Y2dlBsQXEwS2duME4vS1cwampySEgvYitwVVdmclJ5?=
 =?utf-8?B?ZWZpU0JBc3lpckpVVmM5NFJHWjhqelVWaFg2VmhtUS9URzdDeUFRbFk5NWJy?=
 =?utf-8?B?TVAwdlpGcTN4eXlqUUF4S1N5VE9rQ3pBVkN3ang5TS9DOUZPd1huWFRSQ2Jx?=
 =?utf-8?B?WmNsNWxBUUVWUTlzTXdpS3J0K0FDUEt3Qlp0NEJWaFFEakM1NklBbDFIMkpi?=
 =?utf-8?B?VWhpWkhvdUtrcGU4VWExVTZtU01PZGJnL0ZyallyR3FTZmFBVncrRGVSSHl3?=
 =?utf-8?B?SGRVdEdPblVwWlkyRXhtK2tTNXF3SFM4cTFZaFdVUk5OUmpCNzl0QjAvdS8w?=
 =?utf-8?B?TmoxV1hDdGxiYkJUVXdjM3dKeXhjQysvcTQxbzU4NXBCZzU5ZGJHVFRTN3Jv?=
 =?utf-8?B?VDJ3bVo4R3AxaFZKMndVSk5jYTN1OWhRdUU5dS9hSkNhcHJ3R1BqaDNMRVds?=
 =?utf-8?B?bnI3M0xtQ2ZyK2NrekFLVW9vY09MOVRlcDZUczFxNzUzVk1pSTZlb1ZRWEov?=
 =?utf-8?B?cHNhQ21VWGowYnZ1QldrL095TmFnb2VjODdlR0hoSGtxMExHVytSa08wUW9a?=
 =?utf-8?B?Q3dSUGt0ZXdSZE55c0Qwd0hnc2Q2bXV5OW9IOVc2SW8yRjFhWVQ2VzFZL2th?=
 =?utf-8?B?bDJFV1pMYlArc2E3U1Y0bTA4TmNrTm1MWE1NZ2JLSVVLc1pmVlptWnVWaDBK?=
 =?utf-8?B?cmIxQU1GVFFUOE85aUk4NUpTUE8wQjJDUTIrOEcvWGttcEpPUmltdnY0SE15?=
 =?utf-8?B?YVVaOEdEV1dFYWZXd2ZIYWphcVhqK3dhcWlnUWcwSzcrNWtMVkVZTnl3SWNm?=
 =?utf-8?B?UnNCdkhXbW5pQzhlR3NWMVRzVmdLZDdaSzFsS2NWcGFQMkRYMU1yTXMyUVBM?=
 =?utf-8?B?Qk1rRXJvVEIyazB4MGVLN3QxUkdGTnRGRDBlYVhBWk5Cb0Y0eXdCdmpndUo2?=
 =?utf-8?B?d1lTSmphU3NRU1ZQTEl1YVUwdmFyeDlWVlY5QmJVMnI4STVwQ2VkYXJaWFd3?=
 =?utf-8?B?RjRMU3UrdlcyaUJFTHBRcXJ3SVMrRXl1VmQwL2ZJNUxYUE5qeUhRUC9wSmJG?=
 =?utf-8?B?YmcvaG5uRGhqNDQvU0dJWFZNQ2J0cTdzWXFmenVxWnlVZ0xJMUV6cEVvbWJ2?=
 =?utf-8?B?a2c2bjhvWjFXQWw5amlnNmpGY1p0NUVCVWd1cVh2cTBHQWZUQTR1cFIwQUNO?=
 =?utf-8?B?MWhDWUJ5aHBjM2Z1Y3Z6Skl0ellJRFVKVFBkZFNnMmlKZ1BjcmUwNGFkK28y?=
 =?utf-8?B?R2tNZGdDK253S2E1d2hMN3hibGd1NFZRNjBBc2lWei96S1AvbHRWenl3SnZx?=
 =?utf-8?B?U1FpVGdURy9iNDY4QXBYVmZoeHVqL1c4ZFdNdTZ1R3ZlRk56akhBR05zbE5k?=
 =?utf-8?B?aFdLL2VyWnpBL3hmNzl1bTVLR09CaUNNMzF6OHlVR0JQN3Q3M3orb3VIM0cy?=
 =?utf-8?B?VG5EWDJlZnprNGVpaUJVUkNHZVFrSi95VnJiWU4ySzkxaTdHQTJzRDJhRHQ5?=
 =?utf-8?B?V05QSndJRkNVUjhSM2NqbzliQUN0dkJLNXZuMFcxdjBzeVhkY2ErbkhtNnZp?=
 =?utf-8?B?UTRYalhaeGlkTTJwVlZ0dk1aRkNJRGpsRmJyZVhUeVovd1FBN2hIVE03Rkpa?=
 =?utf-8?B?QmUwTVJ6WXM2WEVqWnBBc0d4eGpJVTJGVSs4OEFVLzIrVG8wdnBNcFRDQzVI?=
 =?utf-8?B?VXZXN0phc0ljc2xPMjNnSy81dU5FdXgzaE9tOEJGQ0V0N25ZZ2JieTl2NDQ1?=
 =?utf-8?B?UWgzdmFiTjg1OFN0K1EyV3VDZWdLNWh4M29xSG9jOVNmUDZOM2JSTjBES2xo?=
 =?utf-8?B?STdpZVYzaXFlZElSQXkyQlNtUG1SYkNuMWFQV1UyOUQ2ZEYzNkRlK3hxOFBM?=
 =?utf-8?B?TWVNT0ZqUTIzRzExZmkrYVlJWXVqbUE0NnErMDNaaXdOeWxuRjI4VnhKTzI5?=
 =?utf-8?B?bGRxTzJYdGY5bVYyaTFvajFpRFIzREV0SGh1WDhCWEJDKzFEYkJZc2NxWGRP?=
 =?utf-8?Q?cHs/zmuu1mKAesAk=3D?=
X-Exchange-RoutingPolicyChecked: oclmatifLjXUDnd6OlAOG6JCFQawF0pbqgk/76B5Ks1bcb4Y/Km1CcOtqHqXAfPLebSS2XeL/fGLL0NzYHKu+3xrOTi2sidSfc9OkyBF/yGjhfFpTCzXVWMkeq6GqcS0mYErRpNFq4XT9J+GZMT86RND89NMVFUEuRJ3jeB6LSBtiOLDjldDqyP7jeHie4kRa5jCJYNDpuvi5L5cSBYyR5gTieJy2BIg4etY22Phs0b7mwNhmMvqDl7LFqrv2OoNIr3j+elAV3neugHS/XBv2m0jbCo25upWK2rGPxNOzFXnwRxlJd4iOhqc/dYeoGxOR8fgnD6hb9w9mX4B1/CCBg==
X-MS-Exchange-CrossTenant-Network-Message-Id: f966c1bc-84f1-408d-0214-08def8892882
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 15:48:31.0222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Sh2SWidjXM4pzWOLq5SjNUs9giDpbnrS2W12NDFCxDLkYQ+3pHmPLUTmzC8ALzB9y1tcC1DMSZzKJg1aQviMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8373
X-OriginatorOrg: intel.com

On 11/08/2026 18:58, Adrian Hunter wrote:
> On 03/08/2026 12:06, Amir Ayupov wrote:
>> thread_stack__br_sample() and thread_stack__br_sample_late() fill a
>> caller-supplied branch_stack that is typically allocated with zalloc(),
>> leaving hw_idx as 0. Zero is a valid hardware index, so consumers that
>> honour PERF_SAMPLE_BRANCH_HW_INDEX see a reconstructed branch stack
>> claiming to start at LBR TOS entry 0.
>>
>> These branch stacks are reconstructed from instruction trace and have no
>> hardware index at all. Set hw_idx to -1ULL, which is the established way
>> to say "not available" and matches what intel-pt and cs-etm already put
>> in the branch stacks they synthesise directly.
>>
>> Signed-off-by: Amir Ayupov <aaupov@fb.com>
> 
> Fixes tag?
> 
> Otherwise:
> 
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

On second thoughts, it seems that hw_idx is only used for stitching
LBRs which is anyway disabled by default and only enabled by --stitch-lbr.

Setting -1ULL will prevent has_stitched_lbr() making a match, but we can
rely on the user to decide that for themselves via --stitch-lbr.

So, in fact, it doesn't look like this change should be needed?

> 
>> ---
>>  tools/perf/util/thread-stack.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
>> index c5ce741b07446..1a3dffa83bde2 100644
>> --- a/tools/perf/util/thread-stack.c
>> +++ b/tools/perf/util/thread-stack.c
>> @@ -624,6 +624,7 @@ void thread_stack__br_sample(struct thread *thread, int cpu,
>>  	unsigned int nr;
>>  
>>  	dst->nr = 0;
>> +	dst->hw_idx = -1ULL;
>>  
>>  	if (!ts)
>>  		return;
>> @@ -686,6 +687,7 @@ void thread_stack__br_sample_late(struct thread *thread, int cpu,
>>  	bool start = false;
>>  
>>  	dst->nr = 0;
>> +	dst->hw_idx = -1ULL;
>>  
>>  	if (!ts)
>>  		return;
> 

