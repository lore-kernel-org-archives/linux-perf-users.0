Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020087.outbound.protection.outlook.com [52.101.195.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E2530EF80;
	Sat, 22 Aug 2026 21:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787434584; cv=fail; b=GWOAdcExY0ba6UpB2j+kJyUdUetbFp1oKoDzUHEYNoPPWZ0OxnECD/NTdIIxKW/cxc40GiUoSGp3rkmpiJTiPCDpQAlV3uc37OD+8JMSGruPFOp0mjaPpdjf2cUy+oNMl6H8Ut7v5Ys2czGXkkpcz/SdsOoH4fmf1GdKUfx3XMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787434584; c=relaxed/simple;
	bh=tT5YQRjTJ90xQwacb9pcIpnthXyGQoQ8jCH6b7HDrKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cV4yKZ32Vt0Zjl3SSojh++qIcXRWu+1SzpQhxYVM6rADPsu1b7jr/tNcHE+N7XyalOlc6qqLJL+WMa7WtP2JTYlUFZf1w2o6ysF7+3FNAMMAp0O/6fASTVZpryb0Rp/E6aMTcdLm+EZGG1zEJyxk6tzphecxHMo3f13uYJtpYwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQcGXZn3D7Ol7bvuH89tDr/uXNsko8eOX39u/nW5s3FVXHhpmH/AB2/STxTo4kf9W2/Ho2+nvxUcte0Sd2I6HYEj0qx9EvMSVNYSGErOlOc9iC7584UBD2F5RMm17L5kMcNb55MJh6AXM0iGEhIUlM5cTM6CT/vKlFQ2aVXy3/OxZhj+DZ2VRQVAiqHr+S/rToZec/s1AGE0gQRP5cA/EyV/mU+jsCmEEiLbHmhfixyDQKvgdB15tDxvInm75kbutX39GwJsSW3Pgmzv+fEmexkdtvyVZPaW+B5RMRT7wxTDTpb/2PLnDNtPm4WeRNjTEw5eViiNXuh9+zvNTCBSRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=hPV+0tweCWY5vG3dgnQcV9Z0PtyZ5oMTEJ5uV11oAG0=;
 b=aZTzoe4Bf0GUgnhDEr1HIokU3e7ylIBFxAqDCBUuwlneoVjojAG3PUwVc6MJnEn6k7/dcgpScM78AvPzPynqxfx5pKYj6h+L3p2ynogsOsJ8YM9X3dCndU9birZJ60isnSO8XBNwHh1rpGdx74pqoxt9ikYEiJvt2acLVuYEGgrTQCFWMvzHBmBlpY8ryM1178MN94a5ylF9sAm6VKPgzKApXok6tRSD8pBzm2/aCyf7ZUapN7m7YKy+NTc60M7PBfu7uOO+r8EqbmYZPHLeQWeg2VLmIeBw5n+deA8KYrJsP4vXpzqOoygl3H9/6gnmanw2L0QH25YcdG6OcVzkSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO3P123MB3193.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sat, 22 Aug
 2026 21:36:20 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0339.010; Sat, 22 Aug 2026
 21:36:20 +0000
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
Subject: [PATCH perf-tools-next v5 2/4] perf trace: Auto-assign kernel symbol beautifier to function pointer fields
Date: Sat, 22 Aug 2026 17:35:56 -0400
Message-ID: <20260822213558.704018-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260822213558.704018-1-atomlin@atomlin.com>
References: <20260822213558.704018-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0102.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::17) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO3P123MB3193:EE_
X-MS-Office365-Filtering-Correlation-Id: c6042c35-8bb3-41e2-3ce8-08df00955cf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|10067099003|56012099006|3023799007|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	i7+Ds3Sn1+QEbaSLm3iYbqm/NOzm89+CfoZigCsfPRU7E2QBlq9mgYMTJphctAB5F0srA9AUDMYIb9RZKlFe55AgPAN/U5mtDprOVoN0Ikx/qPqawFLpGXhGKKyFthZKEyI5/NYPWbDAZ3wAYYLtnZJwKCiBUEawnU3waqhZf16qhySA1mdecHXwPtsAxj3Qzo8iN0cjZQmC7mBi4NHILGVGpF16EBU80INb4rGKSEvlx1zb1dFYySkPLvXbo+RRW7mZbwEQ7Erzv2EXyes7XkPhQKv9+j1uQcOLaaUcgzPTfHLy5o0N4AXNMonmyAB48LWzMN/gKVv23OvhgrathnLtkKLc8VsnynOTnAvF2OqnlDnxVxlbjlDfDD7pFiolq5gUXMFcg60dhLVXRAzDpA7qLuXALArdJk7SfPOthNSxwbVuKHvkXyFHvBb6IxL4PvCKC1QhXYKK4vFNsCSVZhJUvvvIxMQRnUiLA1QeEEUQgolgO/dlkV+lNmpCgtpYjbIAa0W2I+0s9BQsKv+tnOLpIj+udp3+2OWoVglrQZMUcFRjssSU/X13mcbL98Nd7DABJ4md2Caxu4nd2i3CXxPSokOWHwRNtlHxhPgMNGUzHEssqFQJlwuqXmGONDp8S4wRkS56lTvy0RvO7Wmb+EOl1gjZyK6abamhrfnAj5I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(3023799007)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UU1Na3RCQy9WMGhoSU8zM3JJVmhhSTQyL1J5MEt6S0ZTSWRFSTQ5VjJ1RDJt?=
 =?utf-8?B?MWlLY1lNOGZBR2dwVytGZDd3M0NJdWlENFJRTlpEWUNHbVJOUE00cU1lTGVp?=
 =?utf-8?B?TmltSEY3SVZERW9nRCtwQzM2bGdBd0RTSVlDcmpGcjNReWFwaTFpRkNteUdC?=
 =?utf-8?B?UzB3ZHZQUEtjWkNzeUZCb1hiNTJoclVlWU9iS25JbUxsaDgyaGhzMVBOZkZR?=
 =?utf-8?B?RDNibEhZTXpnblNxRkJmTHJVekROWUNDVEZuMkhLTjZWeC9tbHBQSzBodzlZ?=
 =?utf-8?B?NFY4SGFGV0xqbTRMeFRJSkdoMyt3UnlzRUxGS2UvTkpOb2Y5TUhBeXU2ZG10?=
 =?utf-8?B?b2pwWCt4aTR3eFVqMlZtNFNNNi92ME5tTjF6dXFaTURpNDhCeWczd0VDSjRM?=
 =?utf-8?B?cXd2QkZKaE5lYThHRXNOYmZtb0xQNTFWOEZtRk9LU3lXYUpjYVIyaWxrRVRS?=
 =?utf-8?B?cktTM29pdWVtV0UvdVVhaWMzNEJJbGMwQU1QUWhOMVlFd0s4dlp2dVV4MHBG?=
 =?utf-8?B?NGxDdG9DQnZWVFRETjlCVmkwN0VmZEs4Zm5lMENDd0V2L09BMENtQnMyaUxW?=
 =?utf-8?B?dHRTVW1vMGhMVmxSTFR0aU5GTlhtRnBxSFdLbElDZkZLRlVtRE1NREg4aDRz?=
 =?utf-8?B?aEJZb2MrZUdnVDMxejQzeTVjNHJ6bGVSb1JTNXhhYnVmYTg0aVM5dENpS05B?=
 =?utf-8?B?Y3Q1aW9PSlV1U3dlcXE0L0gzY3RJWVBleWpYNnVZeWYydlErVWdCU3hHT0Jt?=
 =?utf-8?B?dWRvckYrRkYyQTdwRGEwV05mTGhhcnBmdkVjS2lRY2owYnk2VHZ1a3h2eUJo?=
 =?utf-8?B?VmhMaG1wZkFyOWNXRXBYOTQ0VEIwQXFTd1kzdFVrenlybGdPaFE4dkIra0ll?=
 =?utf-8?B?L1gzTnhVV3NsQWVCZ2VmM2lRN28rRHNXMndFd2ljeDdXa2ViMjdrMVd3NjNl?=
 =?utf-8?B?VDZGL3U4K2lJeHBwSnpxRmtmeXYwK3FJSW9QL2FKVEFxUEhvZnRZR0VaL0Yr?=
 =?utf-8?B?TGN1RzZtbXJWenJHMzhxR1dmSm96eXFWR0Y3Wk5wODk2c3V6V1B2RWlQUUwx?=
 =?utf-8?B?UTZkN1ZETkYvVkJTVUpvZkhQZHhpaWpxbkY5RnhDaDdYM05kdU42K2VQQzJM?=
 =?utf-8?B?dnpFTy9SYkJZZmtCTkdVM1FUQmhHUXpocFRLZ1FWb2xjMitOK1dyRnZCVG9M?=
 =?utf-8?B?dEkwdHA0ZVYzS3dFU0wySjIzRmFhRFZWSHMrRmYyT25PUFZGSTZJdE9VNXpW?=
 =?utf-8?B?LzhEME15RU1SMnVWNm5Eak4vRFhDMmRpVHp5dlQzT0pQdHhwTC9QWlJuNGNo?=
 =?utf-8?B?TC96OXZNZXp4aHYvRmNTYmkwTEZhcElxK1JRODhHYWdsTWxjNGVkSWh3VUdp?=
 =?utf-8?B?Z1Vpakt6VEtGQkNsUnFrbnFEMWpvNUpGOEdvcFFxQTJJaFNzYUtCbjUrOU5n?=
 =?utf-8?B?aWx5WFhuZWFsNUhUZy9EN1VYT2hVMTJwYTNKdUNDcldnZVlwamdvdEZPaU9n?=
 =?utf-8?B?dkwzREZnQzJwN0lvOHhGNStTV2lZZm5iSjdTSW5mSjdTMTBmbS9Bam9pL1dh?=
 =?utf-8?B?WVVKMEMrRG01QmNwNFV1OUVUVWNldEdkOS9aVUlYRmYyd2lxcTdiREdJNkh6?=
 =?utf-8?B?VWJrZGpMWHdNWm5GYVkzTHBUM2VQWXIrOVVFVDZmUXZvVGtwcVl6UnpVbHJ2?=
 =?utf-8?B?SG1lZjJ5c3p1eGlGNkpGbjdEZDMzem9lN1dEeFp0VkhzRXBsSi9WSVVlN2ZB?=
 =?utf-8?B?dWlXZWZrVlBXanJDUTcyQWxlMGdTY3FqaUhKTzNtdW9qMUIrTFVxL0lsRHpz?=
 =?utf-8?B?MGVuRzhmVUpvRW05Z0l3bEhFZ3ZiNEFjSExoRFYycitGUjNRVytqMlpkYXo4?=
 =?utf-8?B?c1pOYitkU1NxM0wzcy9zNGNNOC81eDlST25uZElwVkJZc3pRWXo4b0xXRGF1?=
 =?utf-8?B?RE9tcVhVang0VFRIR1VWM0I5SjhxTXMyNUNJQmo4OTFqTkUvUTlDais4aC91?=
 =?utf-8?B?YmJvYVlEeVBCY3AvTUEybm0wWkJLZFlPb1NFSnhiQWlERDF3TjZkT3M0TktO?=
 =?utf-8?B?UG9Zbit6dEF4NzkvZ0VxZ1Y2OFRNZWU4N3Rxdy96cHlZWFBzYm83YjRncjVi?=
 =?utf-8?B?OW45OFFmcUx6N0tTMXJRajVGbFNEbzRsb2lkaUthcUpMckdudjByT2lGS3Zh?=
 =?utf-8?B?YVdudEpybGQ0MW9FRzRycFRrWFhhYVpOOTRGN0VKdUF6MEhhRm5JZUcveWVj?=
 =?utf-8?B?ZXdsVy9wOXdZS2c1d3NHUlN3TEtwWHZZTCtZcm1lTlo4TW1kYjdBSDlyeGM4?=
 =?utf-8?Q?LDlP9p4JurDsEcFQkp?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6042c35-8bb3-41e2-3ce8-08df00955cf9
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2026 21:36:02.1345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gpPyblc/MyusMctchkqGYZXiDP0EW43qMnCdNKX7n0GP2YcZevYo5h8cVeqm/XHE//3Cc+vizfPvRcx29YRw+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P123MB3193

Tracepoint fields that convey kernel function pointers, callbacks, and
call sites, such as "function", "func", "fn", "callback", "action",
"handler", "caller", "caller_ip", "location", "callsite", and
"call_site" are currently formatted as generic hexadecimal pointers by
default.

Enhance syscall_arg_fmt__init_array() to automatically detect non-array
function pointer fields by type signature (e.g., typedefs ending with
"_func_t" or "_fn", or C function pointer types containing "(*)") and
assign SCA_KSYM as their default beautifier.

Additionally, register common function pointer and callback field names
within the sorted syscall_arg_fmts__by_name lookup table. To prevent
misclassifying dynamic string arrays or non-pointer integers sharing
generic names, guard SCA_KSYM assignment to pointer fields and
pointer-sized non-array scalars. To support cross-architecture analysis
(e.g., analyzing 32-bit trace data on a 64-bit host), determine the
target pointer size via tep_get_long_size().

This ensures tracepoint arguments such as
workqueue:workqueue_execute_start.function, csd:csd_function.func,
and xfs:xfs_bunmapi.caller_ip are symbolised automatically without
requiring explicit per-event configuration. For example:

    ❯ sudo tools/perf/perf trace --event workqueue:workqueue_execute_end --max-events 2 --show-cpu
         0.000 [000] kworker/u32:15/236682 workqueue:workqueue_execute_end(work: 0xffffffffab2f1420, function: toggle_allocation_gate)
         0.132 [000] kworker/u32:15/236682 workqueue:workqueue_execute_end(work: 0xffff8ac2c1adc010, function: flush_to_ldisc)

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-trace.c | 93 ++++++++++++++++++++++----------------
 1 file changed, 55 insertions(+), 38 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 003048946503..10fbea7ed4db 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2096,6 +2096,18 @@ static int syscall__alloc_arg_fmts(struct syscall *sc, int nr_args)
 }
 
 static const struct syscall_arg_fmt syscall_arg_fmts__by_name[] = {
+	{ .name = "action",	.scnprintf = SCA_KSYM, },
+	{ .name = "call_site",	.scnprintf = SCA_KSYM, },
+	{ .name = "callback",	.scnprintf = SCA_KSYM, },
+	{ .name = "caller",	.scnprintf = SCA_KSYM, },
+	{ .name = "caller_ip",	.scnprintf = SCA_KSYM, },
+	{ .name = "callsite",	.scnprintf = SCA_KSYM, },
+	{ .name = "cb",		.scnprintf = SCA_KSYM, },
+	{ .name = "fn",		.scnprintf = SCA_KSYM, },
+	{ .name = "func",	.scnprintf = SCA_KSYM, },
+	{ .name = "function",	.scnprintf = SCA_KSYM, },
+	{ .name = "handler",	.scnprintf = SCA_KSYM, },
+	{ .name = "location",	.scnprintf = SCA_KSYM, },
 	{ .name = "msr",	.scnprintf = SCA_X86_MSR,	  .strtoul = STUL_X86_MSR,	   },
 	{ .name = "vector",	.scnprintf = SCA_X86_IRQ_VECTORS, .strtoul = STUL_X86_IRQ_VECTORS, },
 };
@@ -2198,38 +2210,52 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
 		    ((len >= 4 && strcmp(field->name + len - 4, "name") == 0) ||
 		     strstr(field->name, "path") != NULL)) {
 			arg->scnprintf = SCA_FILENAME;
-		} else if ((field->flags & TEP_FIELD_IS_POINTER) || strstr(field->name, "addr") ||
-			   field_has_hex_fmt(field, len))
-			arg->scnprintf = SCA_PTR;
-		else if (strcmp(field->type, "pid_t") == 0)
-			arg->scnprintf = SCA_PID;
-		else if (strcmp(field->type, "umode_t") == 0)
-			arg->scnprintf = SCA_MODE_T;
-		else if ((field->flags & TEP_FIELD_IS_ARRAY) && strstr(field->type, "char")) {
-			arg->scnprintf = SCA_CHAR_ARRAY;
-			arg->nr_entries = field->arraylen;
-		} else if ((strcmp(field->type, "int") == 0 ||
-			  strcmp(field->type, "unsigned int") == 0 ||
-			  strcmp(field->type, "long") == 0) &&
-			 len >= 2 && strcmp(field->name + len - 2, "fd") == 0) {
-			/*
-			 * /sys/kernel/tracing/events/syscalls/sys_enter*
-			 * grep -E 'field:.*fd;' .../format|sed -r 's/.*field:([a-z ]+) [a-z_]*fd.+/\1/g'|sort|uniq -c
-			 * 65 int
-			 * 23 unsigned int
-			 * 7 unsigned long
-			 */
-			arg->scnprintf = SCA_FD;
-		} else if (strstr(field->type, "enum") && use_btf != NULL) {
-			*use_btf = true;
-			arg->strtoul = STUL_BTF_TYPE;
+		} else if (field->type && !(field->flags & TEP_FIELD_IS_ARRAY) &&
+			   (strstr(field->type, "(*)") != NULL ||
+			    strstr(field->type, "_func_t") != NULL ||
+			    strstr(field->type, "_fn") != NULL)) {
+			arg->scnprintf = SCA_KSYM;
 		} else {
 			const struct syscall_arg_fmt *fmt =
 				syscall_arg_fmt__find_by_name(field->name);
 
 			if (fmt) {
-				arg->scnprintf = fmt->scnprintf;
-				arg->strtoul   = fmt->strtoul;
+				if (fmt->scnprintf == SCA_KSYM) {
+					int ptr_size = (field->event && field->event->tep) ?
+						       tep_get_long_size(field->event->tep) :
+						       (int)sizeof(void *);
+
+					if ((field->flags & TEP_FIELD_IS_POINTER) ||
+					    (field->size == ptr_size && !(field->flags & TEP_FIELD_IS_ARRAY))) {
+						arg->scnprintf = fmt->scnprintf;
+						arg->strtoul   = fmt->strtoul;
+					}
+				} else {
+					arg->scnprintf = fmt->scnprintf;
+					arg->strtoul   = fmt->strtoul;
+				}
+			}
+
+			if (arg->scnprintf == NULL) {
+				if ((field->flags & TEP_FIELD_IS_POINTER) || strstr(field->name, "addr") ||
+				    field_has_hex_fmt(field, len)) {
+					arg->scnprintf = SCA_PTR;
+				} else if (strcmp(field->type, "pid_t") == 0) {
+					arg->scnprintf = SCA_PID;
+				} else if (strcmp(field->type, "umode_t") == 0) {
+					arg->scnprintf = SCA_MODE_T;
+				} else if ((field->flags & TEP_FIELD_IS_ARRAY) && strstr(field->type, "char")) {
+					arg->scnprintf = SCA_CHAR_ARRAY;
+					arg->nr_entries = field->arraylen;
+				} else if ((strcmp(field->type, "int") == 0 ||
+					    strcmp(field->type, "unsigned int") == 0 ||
+					    strcmp(field->type, "long") == 0) &&
+					   len >= 2 && strcmp(field->name + len - 2, "fd") == 0) {
+					arg->scnprintf = SCA_FD;
+				} else if (strstr(field->type, "enum") && use_btf != NULL) {
+					*use_btf = true;
+					arg->strtoul = STUL_BTF_TYPE;
+				}
 			}
 		}
 	}
@@ -3297,12 +3323,6 @@ static unsigned char bitmap_byte(const unsigned long *mask, int byte_idx)
 	return b_val;
 }
 
-static bool trace__field_is_ip(const char *name)
-{
-	return !strcmp(name, "__probe_ip") ||
-	       !strcmp(name, "caller_ip") ||
-	       !strcmp(name, "call_site");
-}
 
 static size_t trace__fprintf_tp_fields(struct trace *trace, struct perf_sample *sample,
 				       struct thread *thread, void *augmented_args, int augmented_args_size)
@@ -3404,14 +3424,11 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct perf_sample *
 		 * Suppress it by default to avoid cluttering the output.
 		 * If verbose mode is enabled, ensure it is formatted as a
 		 * hexadecimal memory address rather than a signed integer.
-		 *
-		 * caller_ip and call_site are also expected to be instruction
-		 * pointers and should always be represented in hexadecimal.
 		 */
 		is_probe_ip = evsel__is_probe(evsel) && !strcmp(field->name, "__probe_ip");
 
-		if (is_probe_ip || trace__field_is_ip(field->name)) {
-			if (is_probe_ip && !verbose)
+		if (is_probe_ip) {
+			if (!verbose)
 				continue;
 
 			printed += scnprintf(bf + printed, size - printed,
-- 
2.55.0

