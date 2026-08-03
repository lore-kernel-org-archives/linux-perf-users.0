Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020117.outbound.protection.outlook.com [52.101.196.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A9D3B47C4;
	Mon,  3 Aug 2026 21:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785791339; cv=fail; b=j1rJQBsEW4UoRKLtpccmGk62ADQJjLjn9MAn8LUTdLHM8Id/SCU5AuvsfEpAEFK6ht7Tqq1WSz3YPETORGQ+y7+yZE36HLTaCRMtfkMHWcjT1GdyYsmgBFx4MnzR/Q8jseyMfwyP1Jwg8DZ6Sx8WvRDHTL1ZugewvzfvHUZOjI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785791339; c=relaxed/simple;
	bh=9zOl5OTBE+LLmZoDq/j42xuHMtXKrJa0nDrXgAcD5zM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DgfiK2BI1zprYgjL6ztbnUFWAHIjrK1cyWz6332dlM1Za4ekR8pnCzynkjcT9odk0058AhXk4n/KvCPRCxuVx0AhTw/qPvBtGWsV/Skt8vkQ9Uu0B8Ellhg4fNMUfb9h1zCOyn6xH/YJPIMZUs4ItYCPLRvTVtqF+lJfOfYLSSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OHK6PWtPUmDeqfCEXpGpENJgVoDllGfyBaqOS8bMYSu8Nhyj5tFrBxtWwyeIPMBIqXkyL2qeXmdx7OT9ozpfej/1rD7JKyqqi1ATlJUFPBy29vKVZp2i5cplj/zrBSukqNUzzVON5gSbde9IZQFzzU/a2ZbxOoZJ5YAAz6ZtN/3dzXs7G39E2sDs4QISwzO163oSKF8jk7ADjxfXb9MQQH214B+YgMTUy4kOFLDvalRgRE4GuJmd2pPqigwE13n4Icwctdmk1iZSqjcBVkemyRWnCE8FMCgugoI5DIiC69uznX0scP1OAEW7u1Us8alUUoWL0yrdniTgkjvs+RUnHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=zlXwOrZi4gAznKNjvrF3NvgAU+VaBtylPqIwFnKDNBQ=;
 b=Q8IqN3rrbEI8fRVlWEu98bVBH0gU/QcZcpA2vVAPJkZT+/9t8taIeZVa/uTFwy/32hBmoL0sOsIn08opQepAYqKDmQ0b6qU+bFeyWq7qYc5b1RL+chliBZoEiFAjFL2FcJpYiz4uaSbOs3nwUnn6JwjFXrhpCMAtUp4mYAoirEeNep/2cUtKYw+6J4lcOLh3feie+L0ndQ44kQUHhrGpsIDWwkn7pIndoRz98Y68eO8fjMgEjNLBnkIkbRR1YRTQsEm5JZMkVv6NWgY6PN7U7UBK90u5PbLcFWoZMUuPDJEcgYEzKxsnQVrGwxTdxqwphxgLXGb7cnyck59BxmrxeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CW1P123MB8695.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:274::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 21:08:55 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 21:08:55 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	howardchu95@gmail.com,
	atomlin@atomlin.com,
	neelx@suse.com,
	chjohnst@mail.com,
	sean@ashe.io,
	steve@abita.co,
	rishil1999@outlook.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] perf trace: Auto-assign kernel symbol beautifier to function pointer fields
Date: Mon,  3 Aug 2026 17:08:41 -0400
Message-ID: <20260803210842.245789-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803210842.245789-1-atomlin@atomlin.com>
References: <20260803210842.245789-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR05CA0049.namprd05.prod.outlook.com
 (2603:10b6:208:236::18) To LO6P123MB6616.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2b2::11)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CW1P123MB8695:EE_
X-MS-Office365-Filtering-Correlation-Id: 04b18045-8ff3-4b80-8343-08def1a36d12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|56012099006|10067099003|6133799003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	hGU6nufDkRX9GLl29Lv3x1/BjxaYbj1UoxkNc/QhXOfj7a1Ymwl37wdGBqBkMgC4EZxEHV8HnWOk7sK4QHmUSKS8yOO8Vxo7Jl3xw0/7n30naz4hsPJYVqmCAx8ieDvEYs6fvrucGdEFiq5VQUvwFuTPXgsEkHbVjOy8dgzEvRm07xNRcjS2Lm4w7/e9Y+y+66kFhyG021FoIchV/BOJEFE5Ml2TyUYdKt04kjgxjzcIrHALP5p0pEJtmL5bGT96eq+NKJbdQbiVcJ1V66cGGZg0AtjwQSVWnARc/nGXQIZ3akTOj865KFyhyC/MpzNqaLjWbiaWKfGd21JfRJEbD3JLwJc02IaQ3O9TwleVSpOHSS5VAVLOQYQ1NQlwIyFhs0C/bom3Al8QX+XwBM9hhjihJTRCUR1EdZvP1u3++SdNWxNvQMpwL00Tvp696/nJxHb6Sb5/oXFlI0Rxse2pUeoMUvLHGg2pYGIER1vHSCBuC54aU2HuibHX5qKj5IrhfKYS9pZS8qFaxNM2BQ1eARtbbsFDxm+9ewtFxAzj3Qt9YC/P1q0gzpqCWvH2yPhHqrDTbB7eG0b4ufERJDSrIf4cqHRoEMYTwgusq7LSSqlaYhar4nzDO0WDNB88m/kzLjYIfHgOkoFRprm3MVDETXbN3gd3mRL4i6+DVi9WDIg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(56012099006)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3Q1WTF2N3dsNUVBeXpWdzNUTzc1WnV4NGRGWEVMYk45RksvVUdaaGwrMThH?=
 =?utf-8?B?MlF5ak1rQ3Bxck1ET3RmK0MyVDRpT0NzbVhCbGhLN3NYWjVOaVFnbHNGKzFn?=
 =?utf-8?B?ZTlKOTYyTDcvbUV6cGc5Q3F4VU9paW12ZFRCZFcrTWNsTWY3ZkI1Wk5VNGVD?=
 =?utf-8?B?MTBlZlJLck1UekVEVmpPWE1BS0tWZHZtSE9telZ0cXRaak8zNC9uWlU2SDlW?=
 =?utf-8?B?VFdlNXB3M0hSbFVJdk5VMjl5VjZwbTE5WkNuVU5zM0NQbGxGTzBwQlo4YTJB?=
 =?utf-8?B?K2M0U3dGVElTd1pUcU93UmpRcllhb3ZWeE4venlNVmFvbkMvVVZYNWFuWVZk?=
 =?utf-8?B?RDhmOEhyK3JMQWw1RkgzMWdnQ2ZpeEJVWkFFV0hxVXBnRnNtR2FicytoWWF6?=
 =?utf-8?B?S0dEZnIydWtUdTZMVTZiQTNlaitwZmx6c3FxV3hTcDJKb29UOVpFOGM4UUx1?=
 =?utf-8?B?K1NaTVdLbVQ1U0ZGYlUvMWxqR0pkZHNNNlRLTTVVM0dSTWh1RXE5VkR3SGFa?=
 =?utf-8?B?dGNRdFZTS1hTQ2hvNlQ3WkVhU0Y2VFJTZ2xvQWUzaW9kTnVQQ0FNelI5UHpy?=
 =?utf-8?B?TWc1LzAzOERLeEdDMGdhNi9lS3Z6L2VwdEkxUUV6UTJBczZEOFhEZ3FYVDNL?=
 =?utf-8?B?b3NoZHRrZENhZDdxbmZzU1A1RzJIUGI3Z3FhUDhzd09CUkF1bGlpeVA3WFJz?=
 =?utf-8?B?K2IxdzhrZ3k2SkdOSm1nMkpJVEYxa083RmJabEFqNDEvZDMwbUdSaEYrMm0y?=
 =?utf-8?B?cHJ1SUUvUlVCRFlHdXZUSzR3SkE3NDdmdDJGNWhtYjRvUXBycXcwTnBXeDdZ?=
 =?utf-8?B?ZUJVSUVUVzN3d0pXOXY2YmhLYmVadEpZRkxwL2ZHQ1pqWW5pTzFkU1pWSEdq?=
 =?utf-8?B?V0wxcXYzSUhYUlprTXFiemdMWHlPREIxNWZWMWZOODdzd0dyOG1QNmUxWHdn?=
 =?utf-8?B?UnJMMis2ZUdsWElua0xqWmpSdk1YVUNLejJmUlFxdXNEeGtUZCtKN1BlYzRC?=
 =?utf-8?B?LzQ0L0YvYnVod3lNRDBuNzVmYXlpZVdsOXVmcFpXWGhSUmFwYk1NOGZxUjB1?=
 =?utf-8?B?Uk11dkdxS0JNSVRiOG93ZHo4ZlhadkFqT0hHdmQvNXMwdzRWS1dlTk9RdnFH?=
 =?utf-8?B?TElwL1owWjFHT1dCNlBaTXhUSUdsWm5tTFlIRFU1VUpPaU5qWDB4K1ZUOEIx?=
 =?utf-8?B?L0Myd1duWjFVaHFpalFxcFd4VDNlUEpPclpRNHErM21EVGNnUWNmMWE2Qm1Q?=
 =?utf-8?B?WmJ3Q1U2UDRrUzZGNCtBb3ArdEpDQXEzY1MvbVRUZTBBVUZ3ZDF1cTN5RURs?=
 =?utf-8?B?SVNXakVsZHNpSitjNFc3MklYMk4yUExHZVNaeTdhT3BXc01uTzN4b3ZXNjJZ?=
 =?utf-8?B?Z3JzbTlNQkJEVDVoUjJUYUhDY2lTaTQ0ZStPNUVjS2NCMEtpTVN5V3grUWdt?=
 =?utf-8?B?MFR1VXNIWGhKWGJIZVZLYXd5c1UrNEFDazBNWnBOdEhMUmdJV1o0VXJZTmR6?=
 =?utf-8?B?aXZPUlNJUUxKMmcvZS83aUo1b054blR2UjUyRWZSMGF2SDdwZzEzb09IWG9J?=
 =?utf-8?B?ZkFoS2VUTnJURVhNSE5CQVBXNXEwak1wb2FEcUxPOHFDcFBqYnl5K05iaUx1?=
 =?utf-8?B?dFp0bUFmcUZLVXVacElmcXBpWmgyQjNkYmF4OTc4emMzREpJa1NZSUE3MGZx?=
 =?utf-8?B?aXpjbnlMbVBPUWJHUHA3d0pnYzBqTzFRY054V3FCS2dQei9JRUU5bDlUOVZ1?=
 =?utf-8?B?U0NsTkF2bVFnQmlDN3UvM1l3NHdaa0tMZyt2N1BGbTJRYldna3hTeXdWWU95?=
 =?utf-8?B?ZTNqRlBuZVlrSVRrZmo2V2ZPSWtMb3hzclBsR3Zsd2NMZDhra2RXVmhqNkpV?=
 =?utf-8?B?VENLZlJGNnRGTHpDcjl5eklsbmdaeGQxYzJtYlJ4SS9kTTQ0QXdvTVQzU3Yz?=
 =?utf-8?B?aGluK0Q0dEhWSllUTTBkd3p2MTNnc1hPeHIxSjNIeHMyZVVPUVQxRFcyZG13?=
 =?utf-8?B?S2YxYzlEaUJFeXBGbHdxbEJIOWhINWVtVy9uYjZWTm5TMUFYVW9wK1FiMzBK?=
 =?utf-8?B?cEZzNHBweTVGM2NvZnloaFV4OEdtV2tMdVIxZDZYYlFVTmZ6TmdLVUZXRlR6?=
 =?utf-8?B?d2x6RHY4L2RYRVY0VElsRzFyYUx3aDhqS3FnLzJVOW40cXg5MWxjMWtac1Vn?=
 =?utf-8?B?ZkdLNzZ0eHFZbXNYQzM4U1dKYUxxVGlRYnRCRHluR2NiUzhvRlVJVkp0bDAz?=
 =?utf-8?B?cldoZ3V1V3R0MGxkTm41NFhLWTkrWC81YWhDSW53SmkxeXgvQjZoOFFlY1dL?=
 =?utf-8?B?c3NXbklPSXVQWTRxOGdyYWpEbnF4N2lFaFR4VzBrRFJRZkN3M05JQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b18045-8ff3-4b80-8343-08def1a36d12
X-MS-Exchange-CrossTenant-AuthSource: LO6P123MB6616.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 21:08:55.1594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pTRD0CcimfbSPVv+1gbD49DHhEDzDXfJVBPUZQ2gGMk71OAY7c2zz97mihROlbGV3NProoOKcSuTggic7AosRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB8695

Tracepoint fields that convey kernel function pointers, such as 'function',
'fn', 'work', 'action', and 'callsite' are currently formatted as generic
hexadecimal pointers by default.

Enhance syscall_arg_fmt__init_array() to automatically detect these
fields by name and type signature (e.g., typedefs ending with '_func_t'
or '_fn', or C function pointer types containing '(*)') and assign
'SCA_KSYM' as their default beautifier.

Additionally, register common function pointer field names within the
sorted 'syscall_arg_fmts__by_name' lookup table. This ensures tracepoint
arguments such as 'workqueue:workqueue_execute_start.function' are
symbolised automatically without requiring explicit per-event
configuration. For example:

    ❯ sudo tools/perf/perf trace --event workqueue:workqueue_execute_end --max-events 2 --show-cpu
         0.000 [000] kworker/u32:15/236682 workqueue:workqueue_execute_end(work: 0xffffffffab2f1420, function: toggle_allocation_gate)
         0.132 [000] kworker/u32:15/236682 workqueue:workqueue_execute_end(work: 0xffff8ac2c1adc010, function: flush_to_ldisc)

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-trace.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index cbc5bdc0cc12..d3401b64340a 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2090,8 +2090,13 @@ static int syscall__alloc_arg_fmts(struct syscall *sc, int nr_args)
 }
 
 static const struct syscall_arg_fmt syscall_arg_fmts__by_name[] = {
+	{ .name = "action",	.scnprintf = SCA_KSYM, },
+	{ .name = "callsite",	.scnprintf = SCA_KSYM, },
+	{ .name = "fn",		.scnprintf = SCA_KSYM, },
+	{ .name = "function",	.scnprintf = SCA_KSYM, },
 	{ .name = "msr",	.scnprintf = SCA_X86_MSR,	  .strtoul = STUL_X86_MSR,	   },
 	{ .name = "vector",	.scnprintf = SCA_X86_IRQ_VECTORS, .strtoul = STUL_X86_IRQ_VECTORS, },
+	{ .name = "work",	.scnprintf = SCA_KSYM, },
 };
 
 static int syscall_arg_fmt__cmp(const void *name, const void *fmtp)
@@ -2192,6 +2197,14 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
 		    ((len >= 4 && strcmp(field->name + len - 4, "name") == 0) ||
 		     strstr(field->name, "path") != NULL)) {
 			arg->scnprintf = SCA_FILENAME;
+		} else if (strcmp(field->name, "fn") == 0 ||
+			   strcmp(field->name, "function") == 0 ||
+			   strcmp(field->name, "callsite") == 0 ||
+			   strcmp(field->name, "action") == 0 ||
+			   (field->type && (strstr(field->type, "(*)") != NULL ||
+					    strstr(field->type, "_func_t") != NULL ||
+					    strstr(field->type, "_fn") != NULL))) {
+			arg->scnprintf = SCA_KSYM;
 		} else if ((field->flags & TEP_FIELD_IS_POINTER) || strstr(field->name, "addr") ||
 			   field_has_hex_fmt(field, len))
 			arg->scnprintf = SCA_PTR;
-- 
2.55.0

