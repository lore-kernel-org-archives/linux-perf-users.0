Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795552524;
	b=TdJIiFtnGx8QieidM51NDN5IshlHSuDvSITzMxmxpYp0Oy+WXIb6OMqBhpo5VM55T4JH
	 TlruAuqgVuSrbJP36wZtnjr9lvKmR3I5WVUsIMNGH0Q99f0ey+ZsLPWH8SqKuzAxPrlIJ
	 kNrqN0UP9kpe/kOqqf1QKpNYP/hYeqkLVCdNwTEzuwe6eZ5eM0QOnlSUhh50ufrFKb2q8
	 nIOgNTr/+xAPjvXE/TdCd9kvl+dk0AWtzZM4V6wDWEMj9nMieHtjKvuwCz+y2wx7Q4GYl
	 4CJoQK5LzTDS022xuELZbB5j+8QV3W7rWcpMaGiOm0/1nrknsi2HvpcodQ9fIdWrd2Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795552524;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Subject:To:CC:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=Uxv+sKvDKBhsmFkAyWn19qeiKIot7PidzxUIXRGeXN4=;
	b=JhvuROERNK9Y1tPNnqGBmgiyzvUU7ji+Zqeb9tnzJzgEYLI8SWs4qApGPxAlgx7/d3e8
	 TJgJboKkdNnpPX7lDYU6MdFhQIa27ECEMbDSZZC/vVO7RNnyWWPnF+s6xI4itsn/6H8fH
	 aJ9VwTJN0ue19rCJ2WtCQpBRyG3Ia8wmDBmS63M4RB+xfVi3TVr4mNM9Qn7LxG4hljReT
	 LpezvXwCVjThNOeC3Y5Pmh8z3cWilX9jDyXPYz6NcNx1FD/UuxSondEvdUl52OtcRvDqf
	 Q4UIetDkwNkJxX9wKPrcLvhinjZRrKMOUy9QsLN+Zf0l6C5Ppk3DzSDb6z9agfdFlww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NijMMiMT;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=IeuNTCHX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA031606A31E;
	Tue, 24 Nov 2026 20:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA031606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NijMMiMT;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=IeuNTCHX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795552524; x=1827088524;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o3qvveHyf0EZUt8jPZMzJHcNB1gTOF8wy9zSgwpHIcQ=;
  b=NijMMiMTRqqgZOrbxsKO+6ku9QBZ5ZShOie+Xjbd09kvNsAF4J71wQTd
   CL5Q2v/neyJ8IJTU7h1Aj1rzEHv3EvjGz+aLd5h3jzQk6evbqX8thZGlv
   nWht5qcQPQVw3NSQfvLMTcFkTwaCgmM+FjH9BO/UlUUqoijhUA4b4Lf2G
   27Ww23FYHyKSpdvdZ6SMRpTiI0dj4yXSO7YjnKjzWSJnWowc/8w7gyVHx
   JRccyBP9YR/hwJT85b0sGRmLAYN9Cb/iIbXZ0T+U6YSKjmgXaykByd3ch
   TsizdqvdNW0/rs2ykKo6cuxQusGcFxmsKVOgmcMz2GPAVMhI3ufktdgv/
   w==;
X-CSE-ConnectionGUID: R+lzHqtQSIWM6Ai2crBE+A==
X-CSE-MsgGUID: eYQV5h2ZQIOMGLYX0T/fRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4411058"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4411058"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 12:35:22 -0800
X-CSE-ConnectionGUID: WXQdKhpyTJOutVUqBYeWeg==
X-CSE-MsgGUID: Z1fcExM1T6iaGXahQZf4Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="11547564"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 12:35:22 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 12:35:21 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 12:35:21 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.34) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 12:35:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xY9fb6mx20otqrxuUdG7CoVHuU725B5nCJGoJrfYENOHOCY+ubMvT/CdvFYi3NAcciWLO773ME+yOT4LYPk0qtjeGQ2bvabwmioWm4U5LYZ7+2WQU4X/rx9ghy+vZNY02Mw18U9ji9jU2YSXfflJeXZpvH6ZF6gj6prHTQWWDoCXVDxuhSe3NxaIgaVV4e1o1ahQsbWrTt/ox1ur8Yo3Oh/W/H/Av9JHAyAKOCZnOd/uG2lC7P8C1QDQIH7aS/qpjS5gF8k+/m+b+SIADZMIb6dxXHlPsLGkHFQ3E5cH3j+PV+x6LnS73nzl7OsqyfHmGm3iUbo6KENoPKgzPu34mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uxv+sKvDKBhsmFkAyWn19qeiKIot7PidzxUIXRGeXN4=;
 b=CShpq3m3MwPXG/zKgXlJSNynNSlKnbBukdnW8mglKsY9kCfm4CudGQK8TdgxERjsfuEHyUG+U9SQ7SfYFW0gure6HBryAjuYXGUrqo0LzyEdNDiUGXD0Mqk9dvRgW7tMUjh+QVFPdI6pYOqf0nMAQDmKFKSaFPA67OA3pXY1ZkS7LJRGiJWLe7KDEnRZ2vg5LBDIK5VxUEBWg2sFWLG9jMe19yR9NATWnoSt9MfhHwCXE2au21LfyO6ubqQjm00jwxblqpONy8yv9j91Ptc8RRUKHoclHXbgdf79HQgSHGBZ2Pu/BSSl4kgIssG+SDZmxxOETlh0t6mnxhq7dNz3Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uxv+sKvDKBhsmFkAyWn19qeiKIot7PidzxUIXRGeXN4=;
 b=IeuNTCHXMxhdLR3+hu8zt/jV9jNxWE1Km76eCSf26Q8maANdL5ieT3OAtq55xmY6zLGJ0Q0SMFQYdAPLQA63azb79yJZ1+iwx1PGa3Xiyoq1SI2fGpyO4EuLDROpwVW7rJT91vSHUUpAnK/IVlh+FAFD7NnS4HwRZfNLY5A2VHg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by LV8PR11MB8606.namprd11.prod.outlook.com (2603:10b6:408:1f7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.5; Tue, 24 Nov
 2026 20:35:11 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 20:35:11 +0000
Message-ID: <09f644bf-e187-4043-974e-ef28e7a6dc46@intel.com>
Date: Tue, 24 Nov 2026 22:35:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/19] perf auxtrace: Turn Intel BTS snapshot search
 into a generic one
To: James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@linux.dev>
CC: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
	<mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, Will Deacon
	<will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
	<mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Mathieu Poirier
	<mathieu.poirier@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Suyash Mahar <smahar@meta.com>, Amir Ayupov
	<aaupov@fb.com>, <linux-arm-kernel@lists.infradead.org>,
	<coresight@lists.linaro.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>,
	<linux-doc@vger.kernel.org>, John Garry <john.garry@linux.dev>
References: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
 <20261105-james-cs-unformatted-per-thread-fix-v4-10-7759e0ce2449@linaro.org>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606-4,
 Domiciled in Helsinki
In-Reply-To: <20261105-james-cs-unformatted-per-thread-fix-v4-10-7759e0ce2449@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0154.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::24) To IA1PR11MB7198.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|LV8PR11MB8606:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c641359-ca3b-4d00-d0e8-08df4a6a6f98
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|23010399003|366016|56012099006|11063799006|10067099003|261026121527099003|261009223027099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +tZTK8T+wbsby/0uIWPLbb+b+91CdzTRzABbmvZLrpvCQzDgwlUmhiUT579JUVdgelIWqXZPBGJxJsWiu1qP/iL7b7zvEuSz+Eewkurw/GDguavpPV51x90+sHu8PrfxwDPQ5BolMbygDvJ5DGImI6fAUZwGFyw3Vqk+SPGWQCqRxJc6z7hcAkffoasooU81qkiFM1nzywhfgGuO78uA/zJKkIm4xCUdYvKYvhUAEBD4/JwTHpdrARuD8/9syrr3vajcE9O0rZkjcfSDXrjbWNiCC/yaS6P5bvNvVlebAa+/7FVvRixbWGeLnUW8phurOc78Jo9/gGXcVdLS/jpYw9HexrK8uzq24EGrfAPkN98T4yJ5ybbSBv3XbHYPbPxtHJLXF1jyrVA7JGPmMm9Er4j0dp7Jus4fkshUHEMnKF6S4eEffP6/DsTBxOFxyfapQBeGcw6+ERHheYmdD9oF+8+MwCTe3yksBkvTGx0T+QsvcjijVoxW2+QP1viyJFO6xXFotPwbmko2Mu11b3fhuBPznqiQdYtKUeI7ZoMnBzEyy7JMi4YvrFFcAwG/6UDCfeOyCjuMbwdgjuNwhCBQocG7ccga/FNvjLdvICOHhWIVA9BSaZi83XhYQMj5AGmJqIU4c8GrOWRyqqI1kL6nRyBZs/PZF0Mued2Uy2Q5gHk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(23010399003)(366016)(56012099006)(11063799006)(10067099003)(261026121527099003)(261009223027099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0h5YmNMREYrNzdyTXdYTHhLNWFHdm5EbXdncGFZMkJvbVJVNUdTYWRBR2wy?=
 =?utf-8?B?ZW9hcDFSTXBBU3AyMHhMbEdVRmo1OFBTbmNnUVVyQmhDYXhFcWZsQ1g4c1ZG?=
 =?utf-8?B?dXN4VDlaSzM4Um1iVG9GYzB3Z2Z2a2dGMVpFKzliS1R1UkhyYXFpZlRwQWQ1?=
 =?utf-8?B?UzZXVnphR1loQ2JFekYwZklRWUdVcXVIYjNwSkhIenBzV0MxM1pDQ05nTW50?=
 =?utf-8?B?NEJuQ3RwQ1FNUlJiQXdXNGwxby9FMEllZXdUMTF6bVhkVkpUWGxSWTlVQkVQ?=
 =?utf-8?B?YUN5MTE1RzJiODRCNjdkMERlSGhCRnlqblpiZG1jeVhpcXFaajlkYW9LblFs?=
 =?utf-8?B?K0xUcm9URStzMlJVQWhTSE0wb0xPaHFPbzdnRzU2a00wVndoUDEzTHVES1N2?=
 =?utf-8?B?VzhSY2J6eVhBeFliY2dtT1FHZWNiNG8ycXBvTzlmTWtmUis5ZUpReFQ3UTRC?=
 =?utf-8?B?cG9LMXNDbklwc0wvUXBiVE1WK1VuQklMVzFaanpnYmVZS0ZWaFYzcVVqeEhP?=
 =?utf-8?B?QTBQSWpuQ002bWFpcHRhSy9hSmdZS2V1MTJPcmE3ZGgyaUNoaFdYS3VpOE1T?=
 =?utf-8?B?a2FTR2EyZmRpQmxrekQ0dVpKRGU1Y08vWnI4ampQYlNJYlZ1NzJCVW4xQS9G?=
 =?utf-8?B?bUN2NGxUenIvY2RVQjU2aWtRYnpsS2ZsR3hJZXlaMXRMNHNpeEF0dmt5dFFN?=
 =?utf-8?B?dnVIcXdzMjIzWDBXQTFmcDJrd2s3VHF0a3hKbTUycHJobU9ORG5meU53cEQ2?=
 =?utf-8?B?bmY0NmNybVRneFl6VkdpZzhIRWFQaE40TDA4TVhkanI4LzZPZ0tZVFE1YS9W?=
 =?utf-8?B?OHpvbmtWalppMVlmZWtSZjdWNnM2dzFubE5adDF1dGZ3bDBjQzUrL1JXdzBr?=
 =?utf-8?B?NVk5Z1o5ZXlNMlEwUS9pU0wyaGtaZUJnanJRN3pkL2FJNjhLS0NVbG9OWHZO?=
 =?utf-8?B?TUtMZ2hLQ2ZEMk41TVBWNWZyMEVzaVUzVzNMVXhudUtFNDhSbmtkUDc2SlNn?=
 =?utf-8?B?Wmx2Y3NDNFVLbG9zYTJLMmFTYXNlMzBmMWdobkxPRk5TVytoK3JJSzd5T0Jn?=
 =?utf-8?B?bGtNVFdHWWdLSnpVOTJtamFpV29zQW55UGJaQkJTanFYejhPSkloR0VKRk1D?=
 =?utf-8?B?UVkwYVZtb2ZIMllsN0tGbGp4b3NOMVpXT0pHOERPQ1BuNDh4WW9YUHdUamNh?=
 =?utf-8?B?aWt4QmlOMzdxUHp4ZU9DSGFOSkdQVk1sTCtWK1NiL2IxaGtXbGovcitjQkUv?=
 =?utf-8?B?QXA5cVRIbUdXdHpBNTJTUW1ZblltVGFTNkx3dEovQ2xFOWg4RkZvcUZqUno0?=
 =?utf-8?B?ckhBeGtwZjdWOUd5K0hsTkM4Rno3akFFMWx1SHVvWDQvQityUjhiVW9TTlFX?=
 =?utf-8?B?WVJzYy9URzRlZnlpd3JjTytXRzBKQUFxTVl5VG53UGVrZlZQYysyOHZNZUxL?=
 =?utf-8?B?aHFlbGRGcDNqb2Z3L2tBampXdTVlUUJ4WEJUL3VhODdMbG90K2d6cnRtcTlQ?=
 =?utf-8?B?VVhIY1VadG9GMW1ZYXhOQnNsak1EMW9hdUY3L0hxU1JEOTlHczcxVllCNThu?=
 =?utf-8?B?bkkwYkZ6VmZFY05lTVBmRGVCQVdIaTIwQmp2NVBGRTlzZk1KMTdiTzVCcWI1?=
 =?utf-8?B?UGZ3c0dyVVp4SDFmLzZCUXdQdlQydUxpU3F4LzUwYjBvdlpMMmQzTS9weWtL?=
 =?utf-8?B?OU9HcnEzRFYwU0ZmZGJtbWxwRm5vU0RvQ0doYXdWUWxDOXF2K2NyWWlOeEVE?=
 =?utf-8?B?SXJ2SmoyY3dkdk1TSVdGK2FXa1dTazZLcEVqRXZJSlpyczNwSjMvbURsTGFt?=
 =?utf-8?B?azZGbk1vV2FIQzd3V0VWYTBCSDM0cW41d3pTMy90ZUVjS0luK3dFeEhOZHM5?=
 =?utf-8?B?Q0MyclQ3VlZEKzR1dDAvV0RUcHNldUZpTFVIdk9jSHhtMU4zS2JzVmRqQ01x?=
 =?utf-8?B?NDE3M2dQcUlUS1FrM0hJRmFhWWNOa3FqTk1ZYTlKQW9LYUxKRVlTWE44Q1hC?=
 =?utf-8?B?YU01bS9uV3RDSmZvL1ZLZ0YrejdrSExpZWM1alNRZFoyYklOaXl4MmhJODJh?=
 =?utf-8?B?YzdESnVEQ2NMVnE5L3VzUCtXeWJwSGpUMU16b1hnZWF6RC9UbFV0Zys0S0xJ?=
 =?utf-8?B?WWN0a0tEMXdmaVdBa1htMXhYcVRQZDF5NnVTQXpHTjUwVWJ2c1VaWjl1c3Nh?=
 =?utf-8?B?aUNod3YvMkdYWHdvb2V4YjFXbDZoQUx5RHNHNkVlZlNmZjRJMkEzbWtqZkdE?=
 =?utf-8?B?M2l4a0doNitOdXhsSnBPREJzUEwrMXc4SXFuKys5N1lGK2ZDN21GdjMyUEEz?=
 =?utf-8?B?SEJtSnd2OGFQbUV0amlFelFVRzd1dFdsOGQydzJSQkppYk1nekZrNWUyQ0dm?=
 =?utf-8?Q?CG7vo5yIaT3kej2c=3D?=
X-Exchange-RoutingPolicyChecked: kPZBng7vnTatg2MHD5+A7RacURVmLe6G1Cc6Zrl06L+0kk2IiMVWvB0OUReB1jNGXok5t7NzQeey4y9Qtyb5PhPUR09YvusIGEyCUBtPjvB86xUjWZNmpyqWFs2/Kcmdko7tT3wY8BeEL1xJYDOVQ1lCkUM7Mcb9f8zEuCrlw3ltcmZIRbzAGqjZmKOqZVjoygRHFBSWc1Erq3Ig09aFqaAb76+4QROmMaupx6jSTgiMnHD30+dITXeGvuMBSO2r0mMALGNH2+PVxyrTX9haZJA9oK0uSN1zJMFIJVzBhhEa19GEIWWtMRhcmvYj25KQZ0130UnAKN6Thciu4mvb7w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c641359-ca3b-4d00-d0e8-08df4a6a6f98
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 20:35:11.2863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6TLhH60qN1gTNnrug/bjxiLfexl26QEzsdRqv57WR43SqA9vtet6r6Y2drwWTlFlmXARtCmeC1EiGqt/1Anj3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8606
X-OriginatorOrg: intel.com

On 05/11/2026 13:44, James Clark wrote:
> Currently each auxtrace user has to implement both the snapshot search
> and the logic to fixup the 'head' and 'old' values after finding a wrap.
> IntelPT and BTS have the same fixup logic but different wrap searches.
> BTS and Arm SPE have the same search but SPE modifies head differently
> (although it probably shouldn’t), and Arm Coresight doesn't have a
> search at all, but later it will want the same search and fixup logic.
> 
> Add auxtrace_record__default_find_snapshot() as a generic
> find_snapshot() implementation that tracers can use without
> reimplementing it. It's based on intel_bts_find_snapshot() and the
> search includes the caching from it. Split the pointer fixup into
> auxtrace_record__snapshot_fixup() so that tracers with their own search,
> like Intel PT, can still share it.
> 
> No functional changes intended apart from changing the pr_debug3()s
> to print hex to match __auxtrace_mmap__read() and no longer leaking
> snapshot_refs when expanding the array length.
> 
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> Tested-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

