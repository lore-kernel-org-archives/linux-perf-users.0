Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.68
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794824130;
	b=T4EjzlvUq6Siw+olbUKFOOHwTnG0Mp0Ddv9jAbGeEvMoLHu+eBPcL2RX7ND7brZEYL0K
	 +Y1ixVgMDDFBMy1pv8+xO6SP90OXgk0256yYKdq5Taj0wV4QyIrFPJ09wjRv5L9IlhMtz
	 uB2ReNaN/Tlx4FrHxLiJ6QiCe7qFcFzc2nz4c0XT3v3YAeC2/YrAZGwCn7Tq1jPgyF0Ys
	 K+30pn7IpEZOpHgPHWvH9XNjlK7tnwJTTWYUIHArecJrXLleDLzNHKoVdOxp0ALQZjHEU
	 5gelxcRk0y5VTbjMm350jGSMH7yA6xZpC+8P/h2wCUi7519mzz7ZKs1mQ7uynp5Yo9Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794824130;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=fjrRetjuTNJxbDZnkuwLLFZ7zpAAYK0DLeoqplz9CP8=;
	b=llwAHQBdynroWHEHZHrfctrtXWfTCdHx3wMZBj38hQpB0MJ5RseRdPByL3WnpflQBOFm
	 LJK5obG8vEQo34aJKALZ2RT66t0RzYPH9cK1eBRD+6FeSO5qfRmOXZ/Dtc2LDV45QlocD
	 InW2K2PNMmIuLIJo6BERKuGjWB0RhHiPNtcdmUu0U/KP1i5jCn+AzLZuI5uBKOP0N7fud
	 3dw49kIPfHDNuFzbtlDFv+Chfz3Q8Pwjj9MCNgZDgMc3i9EKZr1skDjBW6f+DRREFI7jN
	 UFen8jU9Ij4KgB6ijOoumMZNdqNhSu41CgIznt8saSAFUHUW8ghGhyRtYS4eYHcz3IA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=dxIm6lIT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.68
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012068.outbound.protection.outlook.com [52.101.48.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8001606A31C;
	Mon, 16 Nov 2026 10:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8001606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=dxIm6lIT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TqKt8h+6EbxZCgMCVPLpKnGDMSLSDR3RsyO3TuCVNlWKFsU1FqnP7nq42YY00d05hhAejwuUF9rO5P3OARiM8FseBKAFB6L6iNeKoK/t7IblrEk5njzbodzGtRshbCUrArOgmZBvrBI1O4iWPbLHtN0+v60INaIyOMp38iGi+XWcCwdeS3061DoMTqiQMA2x6tYzbH9HFlXNAuifDR+Iuvb7gbUiMPV/0KyLP90kUvjbyYSMrlrD2ArddDif2sX97uQ+gqJ6NrxrkmdE5a3U8MNfDnHnXID4pbMVDhNz0gzLX0oZkq3YiSuJ8cEQdZz09H+Ws9iOs4OA03ig2311ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fjrRetjuTNJxbDZnkuwLLFZ7zpAAYK0DLeoqplz9CP8=;
 b=Mtejk9zqfsRISrsO7rgV7CPlKCsHkby94qFuFhRjtDbGOqAu0nyNIWPFkHtcsMNqen9TeVRTRmyyw0BqCQlm50evt4uD7si52+EvU53VjMWO7voE654gGBGg3DR/wrPMZESzQ66d722REAL731HfvNJcAVK95PMGo/cT0cEYx39FRsffe7V/rIk89Obh2D8N1pW9J2MPj9bNGHdv4b5xb3siuJYOH+miuHpbgrOruzp9PqYAIrGR7IU9hb5ScolYDERgxKMT8mzLy3OBnWZN/4Ofc+P2QkB0B63Uzur3byDjSYA77rsPVgzBvNCYGtzGQ/Xf1HahypFUHkWvX5Dv9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fjrRetjuTNJxbDZnkuwLLFZ7zpAAYK0DLeoqplz9CP8=;
 b=dxIm6lITR/CD1T8nkuVnVe1v5pILZOv7WRdEtlG07Hx6RtbuZSxVbjK6bFwUFKlPxIyIKyRxUW1m3WUVzwOINRKxQF6xFosndULVNuBmLnhftaWJ86d5ohof+PI869IpRUsT3xgrzzGHBORAoJ5nV6CbYs9z0fxIK5tMYzNJqRQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by BL1PR12MB5804.namprd12.prod.outlook.com (2603:10b6:208:394::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 10:15:25 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0615.009; Mon, 16 Nov 2026
 10:15:25 +0000
Message-ID: <bd63e202-7ee0-4943-bdbe-44bf7655afa0@amd.com>
Date: Mon, 16 Nov 2026 15:45:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] perf jevents: Add IOMMU PTW & device entry metrics
To: Ravi Bangoria <ravi.bangoria@amd.com>,
 Hang Zhengyang <hang.zhengyang1010@gmail.com>,
 Jacob Lefkowitz <jlefkowi@akamai.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Ben Chaney <bchaney@akamai.com>,
 Matt Pelland <mpelland@akamai.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261102-perf-tools-next-v2-0-4d237f886710@akamai.com>
 <20261110032232.3080268-1-hang.zhengyang1010@gmail.com>
 <c52fb4b3-1b9a-40ff-ad6f-5d2325443a73@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <c52fb4b3-1b9a-40ff-ad6f-5d2325443a73@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0229.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b1::9) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
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
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|BL1PR12MB5804:EE_
X-MS-Office365-Filtering-Correlation-Id: f128f062-feaf-42cc-b357-08df43ca87b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|366016|376014|261026121527099003|261026140227099003|261028144727099003|261021121427099003|261022105027099003|261102123227099003|4143699003|56012099006|11063799006|10067099003|18002099003|22082099003|261009223027099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	hsAIBmOW3Pn83O36KzBCKcjQ4aBxXSINNk9ck49GeIa+CPqVjZT5yTWMXs08WP8y+c0n4md9MDgsuhzA2v+GC5OE/u+TiRfCy8PxwNbUcqfnZF2z9BexpJ/8plM5y4QnkwrFhycSNJPbCQ8Qbur88RjaugvKL63sKBqPnm9jNBpI4oP7NocFpQsqw95gs7uDtB5sBGKTjxdqzCrzIGrAZ/jXh/Yr8Pfq2ihQvkfcN/3MTOTuichsY2RpTyZbBGg8GmoxD7tmKeYoLTOgo4t4TzRbzoMZR/YCCfexMHxZxFYyJAZN/kzAkKw6s4W8xllPv6niOGZ7iTghkVaOL1qkekHq3Qm1JuWbc/inn+klHXKpzkUOku56eyTTQ/ee3J1r9+UWjiEMfYHl6NORoHRS6wEGojoieG3qsm4BYVxQQHnCiM6RtxtWasHG32twxcn5gSFHbuGacTWn5H0rgLY8TuYP1GIx3j5ETqAUrnKI1U3GZMjFiyI0yAf1zXQ4lJDFo/HBcjUGEHMGvz3yGtTp+laxER53aVMO9q5Bvx52MypQQaPmeOOd+E3esVE0MPkQkqGHD0YngPvM9yJao+8IzWxZOXzy40xYX1EzZmDEvsqDN8u3Aa6lnMO91rT3xw2bLY01eSdM1C4fP/GAPe1Lnu0HGT2ejsNy36ESYa9w+OA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(366016)(376014)(261026121527099003)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261102123227099003)(4143699003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(261009223027099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YndENzJtQU1mc0xIbDkwazVQUzB3Wlk0TUMyb0x2TE5PWUNQVE5VeHFCeFJn?=
 =?utf-8?B?NHpIMG9WMzROL3BRZml6MjZ5RXR2U2cxMzFqcmRDMjJub01YWkpBMmkwRC80?=
 =?utf-8?B?Q2tGWEhuRDRJMFI2ejFBbmhMNHdHQ0lSa0Q4d2JYNVdKWEdsMEdXSlMzeEh0?=
 =?utf-8?B?Mm1UcFVCSytsL24wV1BPbFYzdlF1UTU3bXJHTEd1OWtVSW1VeURPQ2JRT2pz?=
 =?utf-8?B?eXZQcGRJWkRPM2phS29zaVZ1SnpaQWRTYWpXS0VzTTNKSkR4ZVRxL2p6N1Jy?=
 =?utf-8?B?bmMxaXdjSU01b1RESWwzVFUzSlB6QXYrd083S1B1WXZ5WHBSZXRkb0M2Zzdv?=
 =?utf-8?B?NGRXdHJhOTdSNlFhR0U0a1ZhTjdlNmk3T2haNVVBRmhwaTlUVSs3SmlUQm9a?=
 =?utf-8?B?Z2dMTWVtdm1CczdYSGhGWE5ZcGJ4eUlmQjJzSDNwZityanNMdkJpdlFVQ2Vp?=
 =?utf-8?B?YUhPTEZ2SG90V1hpTm55bmtBMGJRZ29WL0NjVEN2V0dZMnc1VFBLLzZXdVJ0?=
 =?utf-8?B?U0s4a09JQmRielY0cFBLY3p3RFJiOTkwVE5BY0g0d2tvMDJ2OFFueFR1a0Yz?=
 =?utf-8?B?clpsRllJa2dHaXpFcTV5NTUxWjlNa3E1UTF1RmFUdmlLeGVldTAyK1RmZ2Yx?=
 =?utf-8?B?RXo3Y0Nxa3dOZ3dwNnVUQ291WkFNUzd3ZnQ3KytMbmMwSFBGVHVDOUpjd0N6?=
 =?utf-8?B?bzhGdmVzYXpHUzFkUTFvUmpXTFFsbVYydUJaTGh1YTNyd2V0VmJFWU9vaVFG?=
 =?utf-8?B?dDF5NE1wdWtvRjZxMlZvYWJuM21RdFJFVVJFbzI4MzlPWHdJL21XdGduRnBj?=
 =?utf-8?B?dzdkSnFPWHFIaWx6MXlabHpRMWZZdWp0eHViRy9YQjFBYXo0KzdhcjIyWXUz?=
 =?utf-8?B?cjRZTmllMVppQ3lud0x0ZWw1VmxOMVBEM0VwdDQvNjFocFdsOUh4TFU2a3dO?=
 =?utf-8?B?aWJialVwVXRPOC8zS3RpQmQyYkgvTEdyckZxZXlWd3NLOGNQY3N3WWllV0dl?=
 =?utf-8?B?QWd3VTV3SnlnNFNRMnBhY2R0akxhV0Z2WDRVUlJqem1DVlNHY2lhQkxYdTRM?=
 =?utf-8?B?Y1pCQVFGN09heGF5M3ZaZ29JbVVXL1MyUjI2NnZUbEpJaEpWaW1oYWdXdThD?=
 =?utf-8?B?ZDk4Y2JmK1dGL0ZNRlVxdTlPblpZTElmcWFpWjlSWG5LYm4vTzRlWmtVQmNn?=
 =?utf-8?B?NWtobW85WXJDK0FaMHhDaTBRbWlvaXBkMG85WjRzaFJIdlV3T052T3YwNWFl?=
 =?utf-8?B?N1ZHQldtS1g4WjlnREY0YWE1c0RFLzJ2ZklvZUNySWZzS3kvcWdGL1BiMzRO?=
 =?utf-8?B?YndQZ1kwMm5VS2NQOHNwTnJHOGcvdjFmREtRWE0wNXRUeXhyKzVLWFJpYUNT?=
 =?utf-8?B?TXFaUUIxMXRGZ0NQZFNXaFVvY1ZJbzRmOEdsbkJCd0o0M3B3N2czM3FPWnBS?=
 =?utf-8?B?U2prU1pPMlRtV1hTa2lWQU5CblB4bVhDOCsxd2lWUHdqbEVBWG9PTmJUdjhW?=
 =?utf-8?B?UFMzRithTmE2Vmltc0NLRTc5V3RIczZrb3hUM2FJS0JFWUd3NUEvNk02YVY5?=
 =?utf-8?B?N2pvWnR6amNRUXhnK0U0TlMrMW9vUFRjUzhCZ2JhTHIvWUJCVHpPU2pLSTJR?=
 =?utf-8?B?Slk5dXF4RmZ3NGlJSHV5TjJHWjQ4K0R2T0tBMXRMOTJaOE5zQnpRd01JcFRE?=
 =?utf-8?B?clU1RHFQVW5KZE94QU01c2IxN3VFYWZoSHcvQmlHTk5vSE1SR2czaEVhQUxw?=
 =?utf-8?B?VmFiNTBldmMzeXNzS3g2dEp1NXRGa1NlU1VacTVvTWxCRWFBMWd5TmpJaUdu?=
 =?utf-8?B?VjJjRWR5eG1rNSszQ0h0SUVCVytPQ0N1RW8vU05sNFI2c01PRHJmRERsL005?=
 =?utf-8?B?eW5TeUE2a0JDNG5IVUVUY2drYlJwOU5VZU1GQzQzN2l1YTJ5dlFkaEhUSSti?=
 =?utf-8?B?VTlWbnYrUnZXWUo2eHc0VUFvOGc2U1p6OElRRldIcXRvRm1oaGtDc2RtV2hj?=
 =?utf-8?B?SkJsRHE5aW1TZzZYYURRUVBaZWFUdjBFYWZoRVZ6d0JHakYyME5vNnNLcGQv?=
 =?utf-8?B?aHVUT3h2REJCcHpIbVdSZTdlK3d0WmpvY2w3UjVoZmlDczJrQ1hWK1l2SFY1?=
 =?utf-8?B?NlJieVY5VVExNEJlWHZzcytiL0paZWk3cjJETWhSeWl0eEJDbHJYbWU2aWJG?=
 =?utf-8?B?YzNUVGRoRWhSS1YrRVVoampuZ1lNbkhydVBpbktmSG1ZM1V2U1l2Q2Nwb1dk?=
 =?utf-8?B?WnhQSVRhVWtsZnlIQm8xLzVCOWlNV3U3REtSRUdzNmRRakx0TkFZbnBWMU1B?=
 =?utf-8?B?VWoyMUZYalZFa3YrbTNFMURCK2pZLzhmWklhejVUOWhvdUJBZ1A1dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f128f062-feaf-42cc-b357-08df43ca87b4
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 10:15:24.9981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CaAlOiTxmEBotWZ5a4GaBPYjTEnUSwackT54hvf5OpSQI4ZA9SmWHHQ5dLVpuflbhyaixjrNzuzgyhbqj5evWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5804

Hi,


On 11/14/2026 8:59 AM, Ravi Bangoria wrote:
> On 10-Nov-26 8:52 AM, Hang Zhengyang wrote:
>> [You don't often get email from hang.zhengyang1010@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> On Mon, 02 Nov 2026 21:14:15 +0000, Jacob Lefkowitz wrote:
>>> Adds AMD specific metrics for the IOMMU with respect to page table
>>> walks and device table entires.
>>
>> Tested on Zen 3 (Ryzen 7 PRO 5850U) on top of perf-tools-next
>> 13a8d580433a.  Both groups show up and count, perf test 130 and 131
>> pass, and under O_DIRECT reads from NVMe the values match the raw
>> amd_iommu_0 counts.
>>
>> Tested-by: Hang Zhengyang <hang.zhengyang1010@gmail.com>
>>
>> Two values look odd on this machine:
>>
>>  - lpm_iommu_ptw_nested_read_ratio is 100% with no guest running:
>>    page_tbl_read_nst equals page_tbl_read_tot.

Its host or nested page table walk. I think this number is fine.


>>
>>  - lpm_iommu_ptw_reads_per_tlb_miss is about 0.2: 142588 page table
>>    reads against 440805 pte and 192018 pde misses.

This one is not adding up. I will check internally and get back to you.

-Vasant

