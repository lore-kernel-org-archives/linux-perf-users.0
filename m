Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011011.outbound.protection.outlook.com [52.101.62.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907BA29DB6E;
	Mon, 14 Sep 2026 02:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789352666; cv=fail; b=ZwNDQtMS9+XECv6eyC2ApzJVi24JWWNiYRFfiu06YoYvokfqaXSYa38eWsSOdEaNWUHHsw8YCEISJZLVTKla5PckLJdrI+w0PK7DDVxObW08J/FTO3Pn6KAKCgxQ/HUt9XE97OLTV19ucv8A2aAti5bCKXzeE1doaMXpHxMO2OU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789352666; c=relaxed/simple;
	bh=LA7ZnXqPsAszfR1Ql4sikyCXEX9QkFYqkT6HbKr3v84=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=dpLLOjOO+7w91cx0C3EfF7p5kY13xwD8gourBBFTqmmExF8ad321JMmleNiJIw1YeZkqQHfzM3TDAKGv8oD6QHNIgawfL0Oh7L4G8vB30iVrww96dmhD2t0ygvIfxBOHiQh07mcM0I0QwdBFrXVW2pZ10V6yPJIfPvNIjvkvPes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CUBOGkGS; arc=fail smtp.client-ip=52.101.62.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CUBOGkGS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TG41vWkgIkBZ36zXKL8nTq1hyWgiXsnq6Yo0aJf3/tpBbhyu6mfMEami2jJyLatDupuleCtGUzkN14mH7DT2AALVJ4d+kxfRJ9SBmnpUyYZoyjCslC5bZs/DrRJRoVZsOHOidwYOFMxKMvcSBqwcQ+SkFnVwm9l2HUVKdUDJCbYBy9jvyq+Zy7uBj7/dVlRHZXQZOWNUjyrOvHEsKgF7KwaOHMxCWJYUZbmEO9TYTWKKlA7bhW6zle+rlIB4L9zsBvjvoWelFKzIn6w57Uh9gep1CAg0lmnrqgM+AYuxbNAzzURAJ54clC21QcH2c1qRE3mTfmpffiq13XoupGZOTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gpnw9Gpg4JeqTBKlcim2Ze+bj98VqYRU3sYXsAgbZDY=;
 b=bqOD6bcNk78uxBKGet+fcF3S2zOPVzfhaO0StmOL3HWJWRsZWQGoyu72NP6LeMevrzwOKmpjFmADDEB/afYvzClfkX6dFXSJv9Rqy87hwaVCy/3XU94JvJnlLxyyAqyhlgATzL86Ub7pnTC4eBWz3FzL+6XZSs2M+WHkeXQ7+/yY+yF39hvDWCj005MWf5muFfK+jNzNxdEON0BLEE9efuiAwt3eiTAiDQKDQqHeFxB/SP/0wBpJItPzRjAflF4TlctJrsyhLRpY9hS9VTTTXyNJiU42Ql6+QnNsVUB0uNn4xPNUiO5yxnbXqKzsLJz0yYpbpVsLlwXSJ0Wg2fUEyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpnw9Gpg4JeqTBKlcim2Ze+bj98VqYRU3sYXsAgbZDY=;
 b=CUBOGkGS/Xh12oy1gyK5dFAznWrlkJR9BqRCLhMv04sTWFJlJEi+V+GS+WmSSIq85gS1CazpLRGb+w0w4vOEQGfLRJ3ekhITJEGc7baNeNWL8dw6aCG9ZZ83usDGSc6nSgcojutjQ6urY7ZmXgyIxWx+aB23m6hAV/HaIQEa+LFZBJ1BgYQpSxrWiWZ1pOwTQWJ7f60QckVowYNeySY5Go5jQo4xyXogX72dQdmR/t4dJV5ZUSTetulL9ripLDPNEbZ/W+ue+YyeB2Y0VtAlNPL8XXARhS+2sDG6HM4Z5QLdw3PCnJJ2IblaQXm6QR8/Gr2SoDBvsDQ/RLGhdd23OA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 02:24:16 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 02:24:16 +0000
From: Zi Yan <ziy@nvidia.com>
Date: Sun, 13 Sep 2026 22:24:00 -0400
Subject: [PATCH v4 02/16] perf/ring_buffer: stop using PG_private as AUX
 page high-order marker
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-remove-pg_private-v4-2-848550f7574e@nvidia.com>
References: <20260913-remove-pg_private-v4-0-848550f7574e@nvidia.com>
In-Reply-To: <20260913-remove-pg_private-v4-0-848550f7574e@nvidia.com>
To: David Hildenbrand <david@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Muchun Song <muchun.song@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Zi Yan <ziy@nvidia.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, "H. Peter Anvin" <hpa@zytor.com>, 
 linux-perf-users@vger.kernel.org
X-Mailer: b4 0.16.0
X-ClientProxiedBy: BLAP220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::11) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|DS0PR12MB6486:EE_
X-MS-Office365-Filtering-Correlation-Id: 743548cc-34f7-4400-80b4-08df1207460d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|22082099003|18002099003|3023799007|921020|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	AbJ00LC6l1iueRkrmXBeolv0ENOdZDtId1CuSjsGPd65c1EBOnfcRL02fA4/aliW1EzFmM52DslPUjtpIt+plmLKGiBmndsuCOBcV0/yfAYYuRZRzjXE8Lye/46+IiBN8bgRgjYnstl6jxaPs4WFKuH/RDC9+3arB8p7JWvNGpUrdF2lcKCJN/C+hBKpOfM5EBlg2+qhrrtGW6mJUjISe//UGkigGNgm6sny+rckwihRJ5tBvYZxkBKFSA+yy4V0oGLLA47SXs5ibtnfzSsDw3UzZf9aCaMmXfyzC/HbJ/SH8j/+05J4QoaUezV3IeYv/QkvYJ3TmUKDeOO6MvveD5XzPrvkt57cW1DuS80BfLT5laIEvNTXviJO5Hf7yjuyKHpMSyu/ZNlYohhfkaSa2nbdH0TTdML1hKKFJPBua5i8AsT9xSuE/1Zz4mtvktz6fG+pgovJORnUFBAEIia3W1yPftvwUeSzbwBy2jFkw8VJhpb26Iqf595F+eBKdb8AYozpLKMzvbqKkQKGLNcAdk/tdgi+JRHSdAGthzNQvvfpj7Z9YyefqguLvjObtNw3gosYrkd602u0kIlYrgciP855ADCR1qiqxemaTpIy+Zhn4BWSKGiM1VgMXfdUFflN65qRQT2JGJLwnuXqDBxWMa1yIdTM3h0pF3GpvIfGRWX+fZ/wSbN6HRj3ghqIH+I+3vMaxzK2Dr6rO+Mf3IMzbw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(22082099003)(18002099003)(3023799007)(921020)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2hGKyszbmVvMDZQQno5eW5UVS9wclpTZTA2bXZGcm5CbTd5TkZWVlJsV1Ux?=
 =?utf-8?B?ak45Zzd5d2IvRngvZkg2bVJDNG1XMmVkemp1d0E5c0JYcGxSSEVqaks4Zllp?=
 =?utf-8?B?cTAwalFuQ1Uvek56Z0xaTTVwYVN2aUNLSHYwKzU0YVFsRVJTQ1ZSVG5ycUF5?=
 =?utf-8?B?V0QxVVhCZHZYN0szWFQ5NmxlOUNwNVR3eUp6dDA2cTF2UmY1OUhkdUIvWTE0?=
 =?utf-8?B?dENjcGZFemxwNGJTcFVpa0t0NXNJdVREcXEwN0xseHV0S3hZU3VHUG9FYWN0?=
 =?utf-8?B?WkhUL3d0K2xKZlVZR0ZGZ1ByVkY3TnVPMHl5WnlobFpmZjJqazc5MEErTWIr?=
 =?utf-8?B?V0ZEQzJsNUNNR3ZnN2tDUEJHYU5WTm5yaXo1UWRXWG5xdEgzZVM3WnVtbXRj?=
 =?utf-8?B?VjRWZ1h2TGtrN1FJTDR1VWppNGl2NVQ1MUkyRFBLZUVDTTRlYjJQeTNmRGRS?=
 =?utf-8?B?eGkxaHFYM0R4YnNuTVdsMVc0YVEydFdyeWIzaWFLRFdUMGhTbnNtRXJCVncr?=
 =?utf-8?B?dVVJcUwwQlJKdDU2RVJtOVVpOGVtdzAxRDMxY3JmUnFtNlF2K1BYWUhnRUdj?=
 =?utf-8?B?TVRFWUFETGt1S3hsa0JwcnZaRWI5STJIa3FvSERUM2M3MjIzaVRHSkFNK1lK?=
 =?utf-8?B?UEZ1NkdHbmVEUU9XTzNYYlIxZjJOSUVGdkp2VkRJWkJGZVAvOXNEZlNYU2Ew?=
 =?utf-8?B?RXNhemtvT2pJWUY0VW51amRUUUxKSEpQcEQ5WWFJV2JHVlZNckFvYWpMMzZM?=
 =?utf-8?B?T1ZPOExMbW50NndyT0V1SkN3ZGRVdVBHc0dxZHlhbW90SU9QREw3cUJBYlRE?=
 =?utf-8?B?V2pUc09sTGFKV2JsQWpqdGx2M1YxcmQzYkU4eVQwOGphYTdTUE1BeFdCZDVY?=
 =?utf-8?B?eDNFR1dlQ1lkSjYxbXpZck4vbXlHdnptaVpPODB5SU1GaDVLZE5LNzVzYjNW?=
 =?utf-8?B?ZllCbDlkN0hpdXNnUHdYTFN3WjN1Yi9pcVNRKzJIRzdzaENlNjlZcFhycU5u?=
 =?utf-8?B?VHI2cUQ5U2RYOHVSdEExQmRyUmhtZmhyWVYyOXkwejZ5czBCSTlCY2xYcjFq?=
 =?utf-8?B?UFBzdzY0T3pHclBRd0hoVSswVVNrc1F2MjdPSnRZcGplVGpiSmt2K2Q4ZXls?=
 =?utf-8?B?dWV6RXpEYS81Y0NIK255d1Bnb0lFeUxPRFFNSkhtNmZiTUk3ZUF2dldsYU80?=
 =?utf-8?B?aHA4MnhZVmRHWU0yVDhyUm4xa1VnZnNRVFR4RUFhNFNQTS9jVUVad0NyU2kx?=
 =?utf-8?B?cUE5SG9KUFFIREM4N1hWMXpRQmowaUtsNmRMYTRUSFAyMVpZam1PU1RPTTBS?=
 =?utf-8?B?T2liNWtKVFB2R2txbFBWQWpDSnVwZVlmZzBiK2FrNFhnMWNTZkpBdlhvWWl3?=
 =?utf-8?B?eUdmaWgvTzVTT2swcWFiay9idmhtV0krMU53Zlp6VmVtTXdJVU9ndlFMSDVH?=
 =?utf-8?B?TDBSUGVGcjhyUFJqeEY4a1doSkM5RjhXb1dKNDlqREhQNUE2Qm1jUGpYMm5B?=
 =?utf-8?B?aWlvTUdnMXZrc2pXa1h5dG1JNldmdE1WUFNlZVY0UVdld0d4MUptMzcvRWVn?=
 =?utf-8?B?WmtwWUFTMzA1blgzQXRjeVJrY0dMbVc2YWxxd2Q3RjRzTm5maFlwR3BvYlB4?=
 =?utf-8?B?Q21VeDMvK3VQOU93QUpDRzZqTEw3clRxblVuV20yejh6VjNzaWxiaEJJZ1U2?=
 =?utf-8?B?K0lYM1FyWTNHVk5PTzVuSStJUWhuWkNQUnFVRk02QUJoS2ptVUZ0dEE5anU2?=
 =?utf-8?B?NzJ5dDljSGtPLzMrV2F4VU1NbFRhK2lJdmJDYWFwS2dQMWRISjg3YmdSVHNw?=
 =?utf-8?B?TjNTWnFiWEtEUGxabW9iWGgzNmZ0NXRlbEdHMjVVL0dHSmE0UldCei8vb2JW?=
 =?utf-8?B?TmFrN0RQdzdnVTFYS01vUVdZdVlrL1l0ek1mRUYwWFJpSFNsZjdpMnhyWmRG?=
 =?utf-8?B?ZURKSUlDdGpnVGdrSVY3aFdSR2lwRG1PeE5ISUtVbXE2cWJka0JQZ1RheVlW?=
 =?utf-8?B?VEN5UE9IQXNMWHVsdkxubnVvaUhIZWVkZlhtdHF5RmZoOXF6aXgxdEQyUlVz?=
 =?utf-8?B?WEpkUlV1ZkRBY1ZxR1BpNndiZFhyWVVxTENzekVxWXorbUpwdlFxaFBEaWhL?=
 =?utf-8?B?TzRnQTl0NlorOHg2c2tpZGNRbFdaTDVaaGdIZEFycFVlb3lvcHlSbWZQSVVk?=
 =?utf-8?B?cjRkNCtNanpYTTdDazVhVDZ1U1F1SVlZSUJkaWJIUUZaVTNacDd2bVM1UEta?=
 =?utf-8?B?OG5jcDdmQzFuVVdvcU9oM2Qxd3hGWWdZSjNLemlNRTRoclcxR0dQZnRYWk9K?=
 =?utf-8?Q?8nO7UM75gEytvFWqfO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 743548cc-34f7-4400-80b4-08df1207460d
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 02:24:16.0157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YrCfjlk2iCViqgCSPFpIk+YbG/5Aoh2/izuE0Kp5KSSDgbacq/BZY79aefC54EGI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6486

A high-order AUX page sets PG_private on its first page and stores the
order in first_page->private. Stop using PG_private and check
first_page->private for AUX page order only in the ring buffer and its
users. This is fine because page->private is 0 for order-0 AUX pages,
matching the page order.

It prepares for a future commit that remove PG_private.

No functional change intended.

Assisted-by: LLM
To: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@redhat.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
To: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@linux.intel.com>
To: x86@kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: James Clark <james.clark@linaro.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Acked-by: Usama Arif <usama.arif@linux.dev>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 arch/x86/events/intel/bts.c | 3 ---
 arch/x86/events/intel/pt.c  | 6 ++----
 kernel/events/ring_buffer.c | 7 +++----
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index cbac54cb3a9ec..5849392cf26d5 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -66,9 +66,6 @@ static struct pmu bts_pmu;
 
 static int buf_nr_pages(struct page *page)
 {
-	if (!PagePrivate(page))
-		return 1;
-
 	return 1 << page_private(page);
 }
 
diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 5754cd4055628..49349afee6119 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -781,8 +781,7 @@ static int topa_insert_pages(struct pt_buffer *buf, int cpu, gfp_t gfp)
 	struct page *p;
 
 	p = virt_to_page(buf->data_pages[buf->nr_pages]);
-	if (PagePrivate(p))
-		order = page_private(p);
+	order = page_private(p);
 
 	if (topa_table_full(topa)) {
 		topa = topa_alloc(cpu, gfp);
@@ -1296,8 +1295,7 @@ static int pt_buffer_try_single(struct pt_buffer *buf, int nr_pages)
 	if (!intel_pt_validate_hw_cap(PT_CAP_single_range_output))
 		goto out;
 
-	if (PagePrivate(p))
-		order = page_private(p);
+	order = page_private(p);
 
 	if (1 << order != nr_pages)
 		goto out;
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 9fe92161715e0..061b5cb222266 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -630,11 +630,10 @@ static struct page *rb_alloc_aux_page(int node, int order)
 		/*
 		 * Communicate the allocation size to the driver:
 		 * if we managed to secure a high-order allocation,
-		 * set its first page's private to this order;
-		 * !PagePrivate(page) means it's just a normal page.
+		 * set its first page's private to this order, otherwise page's
+		 * private remains zero.
 		 */
 		split_page(page, order);
-		SetPagePrivate(page);
 		set_page_private(page, order);
 	}
 
@@ -645,7 +644,7 @@ static void rb_free_aux_page(struct perf_buffer *rb, int idx)
 {
 	struct page *page = virt_to_page(rb->aux_pages[idx]);
 
-	ClearPagePrivate(page);
+	set_page_private(page, 0);
 	__free_page(page);
 }
 

-- 
2.53.0

