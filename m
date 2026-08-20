Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020122.outbound.protection.outlook.com [52.101.195.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CED47CA9C;
	Thu, 20 Aug 2026 21:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787260274; cv=fail; b=Y4CAdyf0xhUCzfRBjwuLQ+G5egVoptvnHEs+04qfSYHLOQgUjf9msbUtj42UO0O7Lxb9Ks4iBw8I6FQXCEcOLwRgwi+bKPDO5fTQLUR+15XoxrUvW+bVPljw3IKg0viIWHM5Yu9HZvHjtyRH79LGu7xpzV+DT8WEuQH189GXDtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787260274; c=relaxed/simple;
	bh=M4mPYrkIC2N4OLNgMKvuW8ms2ukzoNyhoWPcutMiwRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vh65o4a/qfy4RTW/5Q79I4nM/QygCHGgKv7Z5T8/LSWlKM9Mb74rIAWWcdC3X9snkcHjrXYfbT6zx17OOiLE+Q4tZ/tSGs7tSj9AVqlSJCF7F58pKDqCX1Uwjk5gJWCm63eYyC2Xt4FnTkZmfWJWhbwr0eOo/YL7oaxKme8VP/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fVj9P4cWl53Ox9UWEz2kqOZLjISYld6Hk1vvxKUZKgmSv+NEqBX5jAuzGOvYuDrcasuwLV/n/pd/nhaDBUgFwklqF3VgnOSsh4ZeJgrOPA3dH0x9WyjVOz9Ja3FCfbqgy345RSfIjljGISzZKNqANgtAAMeO/2v0YEtPjxZwURl0AEoM6sdG6HJJ8GNWJ4eSv480qnKKPoQ555GBBuJrfrSMSpuoPmmRfv1hOPuQu0MhXkmN3DwrIa3r/sqtwKvvR5VEGBSqPtP6H1GQYs0b/fyQms2lSrd+uQZl3MTly+wHGjCP1M6D/lHX7K0MKx3a0n4/1Vd/nyEBTiPvV/F1cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=pOtkPXe0ydO/epUPw9RM4qpO7f6Ta6VAM0/d6I4UDRk=;
 b=taoJUL/52HKgmL9dd9FbRK6ISizRXFG5a+BQh8fHqlWeFmh3zV1UXtFxLvne35E6j6syAwg3kbymXf5b2FyCb0qXZX5tX29LEWwgK2qtTRdCd6Fh9gEybijVFWLbovTEZSM705YfnftSCendABambuWiZ1khMKJXu+FRRtmECZ8DdKSHuGPgOqMuxWsxr1ahGY+0SXHCFQNtvlaUXUwbkt3OaC9rUItnMLEGHpLcbP3Uu1pawWbvnAhuWZkl77pZPEMuN8WwVKYxm7XeA5q3mIfAEXTgl0OHIZ+Ox+ky7kEJEteTsHhbEubZ7lmteJypJkTRL4S4S0dqtW5i7CrtRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOBP123MB9004.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:4c0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Thu, 20 Aug
 2026 21:11:10 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0339.008; Thu, 20 Aug 2026
 21:11:10 +0000
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
Subject: [PATCH perf-tools-next v3 2/4] perf trace: Auto-assign kernel symbol beautifier to function pointer fields
Date: Thu, 20 Aug 2026 17:10:58 -0400
Message-ID: <20260820211100.649142-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820211100.649142-1-atomlin@atomlin.com>
References: <20260820211100.649142-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0494.namprd03.prod.outlook.com
 (2603:10b6:408:130::19) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOBP123MB9004:EE_
X-MS-Office365-Filtering-Correlation-Id: 247e8e83-7dd2-4e69-c67a-08defeff8f3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|56012099006|10067099003|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	F9BWKHmw/bVl2qYfRYWH+QqwoH6+OYFHrY1fbyPZIktXf/3+8R/2g2SvCExpwrLsK66ckl/eF6DYGpmI61Lf2Vqp+hc3vrFsfvKBWdvivfXvTIGs/IaSvTCMBKqRzEjV6mp0c4vvjMW4VJUtPsA77nIf4x9iaLbHJQmcvSJXZYToIyPq+yxUQiSRMMr9iuccgtBnaIkeVrduNRZM5SjRArpnvwId+MmMR1+eZHQAebojmkblaFB3Fxzm3G9ET5BjSWBr5IKM0xhM7Wvb/v5CbJhDOkbuytJBSQkIY4twJem3bLGikxr8M2cs1nYLJbbrrn0T8kzFai+TW51PR7YB170K+BPzTr/aJVjFi5noaAgGqejpiSETwSciyMNyUc/+0xsqi4+0+FqO1Nv6UZ8anQNiUUJrlKJAaE5tQkafOaUeA73oWXw3Zy8HJ8Wkh3lqIbZ272asrYM5/wT/2+5ccT1cFMuugvgAhBmceWFHO/UD7i0oMZmwu0bZFJkq9s64aXoRLjq6VOdxSbPqPa078Losmr+zdUi3VK+P3iz9i7Y+wREto6zKGhaYdM5MeDAAx6U/GVIZBBIsbhtkyS9JoM1AFWXH1zqGZnzvR5MEWfWvTbEut71c1NWjZNO60LtnqEtp/wmMn3qfumgeRw+pe4vv1KNYRJOGJMy4BwNeh9Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(56012099006)(10067099003)(3023799007)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDdzdWZGaHNPMU9jd05GQTFDcXU2bDNmTUVFcGRUYmRIVjZVdVZFWTdKeWNl?=
 =?utf-8?B?SzVEeFY0ekI3RGJLK2t2T0x4WWRzVk4vMXE2WjlSVUVIdzEwQWJaZXZMdjVN?=
 =?utf-8?B?MzBoRlRqTEpUQWxsczUza0sreXBHWThyRG9CeityUVFuamx4TXQ1MDVncSsx?=
 =?utf-8?B?akdNMUR2d1VKMldvd0c4U3U3ZENTQVl1dFNLeWg0MGtwSXhCaEtBZ1dOcGdI?=
 =?utf-8?B?ejVZSlN3Vm5RK285bXFNY0RlUlFxVHdmWktsSUU2Y0p4dnNnUHVKY04xY1Vs?=
 =?utf-8?B?ZFVSOTJxOW92SGxHNVhIOGFDQXZBdzcwaTNKOGFDZ0NKb0czTTBndzZiOTRj?=
 =?utf-8?B?amZDLzJFbFNVUi9lbHBKT0NjY01xMHZUYlozY3VSSHdaeVpicWJwMElVeWxa?=
 =?utf-8?B?N3dReXF2WjRzbHZZbCsvQ2M5RmlCVTFJSm1QeGZGeDZmQ3BXVThQelJnemV3?=
 =?utf-8?B?Rlg2WFhSeGtHdDhINGlIc1RwaEQycWk4Q2hHelFTQVY4RGJZTmk4Y2lDOVV4?=
 =?utf-8?B?MFZ6b2dTeFlmR1FSVHpaajRzNit1amZhdFZxL0xZd25IbUlhS205bGNDQm1i?=
 =?utf-8?B?eWxPcmJtYVl1NEJHckJGWEtwTTJJRXVwRnp2empWazRjZnpkSTVtSHEyNFBX?=
 =?utf-8?B?MDJmSnBFT2tuTkdqTHlIcTdhWU15bTRVa2V2UklUZ2pPQnQ2WElZZ09jNVlo?=
 =?utf-8?B?cmFMd3N3OXcwYVdUSkE2T2k5b1RSNnRiVHJWRjdUQWU3U01aenk3MFBmSWRV?=
 =?utf-8?B?dGZyRzE1QXdLTlZhWEZJSWIrYTJ0TnlnemNnNFkwZWhjMUd3MWZGU2JmS2p6?=
 =?utf-8?B?dU9TenhqZGUvYVliMTNMclR1ayt4RlFvL2U1b3pwSGxhVGE2cGkwbmRFTVdw?=
 =?utf-8?B?L0MvNjJWK2ZjakdtSUc0ZXJBZzhSYy90VDRuU2taVndhejVGZ1cxUFQ4bGdS?=
 =?utf-8?B?MzdIVEQ4RS9jTEFwRUV3REhxUlNuWFhiWDNCdHoxNmFlWmxaRTVYZG5DSXZO?=
 =?utf-8?B?OUJSdVlsQUhrT2VFWWt2eUV2LzdLa25sOEhzVWpKZjRVVkZxM1RKMjlYdnR2?=
 =?utf-8?B?ZzFhRG1UZWlISmxsYkltM0FpZXhNNGJNbkNQWGU4VjFDMmkxUGNGbWFINDky?=
 =?utf-8?B?eXloMkc0TjU2WCt6amtra21VdzdYV0ZUckQwbFhqcW9MQ3dvSmUxZ2lOL2k5?=
 =?utf-8?B?dHJJS3F1MGZjRi9XeWRQd1BWbkdyUGhMTmE5Mzh2cjBORS9ERWM0b3pzYVRG?=
 =?utf-8?B?WUpHR1JFOVBMbXYxb2xSdTJWVFJ5S1RUSkNxcHo5OVBtbUx6WU02UUhjV2dS?=
 =?utf-8?B?S3RDWFdLQ2wvbGRoOHBaTlBEaVorTzhlbDc2bnZYYkxEZUZlcVE2UFh4TXA2?=
 =?utf-8?B?eHFnOFBOUll3NFpMUEo0amZQWUdtc2ZBOTk5U3hXdlVBRzNCbXhMOWhhNGpI?=
 =?utf-8?B?WVZXNlU2aENaa2owaWVUUWVzV1BJMFlwSzhBSzN5bmtKb0FqT0llNWJaa0d5?=
 =?utf-8?B?ejJ0bzlSd3drR3ZqS0FkZlVreFpyNzM2cVY1a0hLMWdZazgrMlR5RkRDUC9D?=
 =?utf-8?B?MVRCczlMZno3VS9wc284RUZTeFdRVGhuNHQyS25GSUxkODVoaHlpclpKWnhZ?=
 =?utf-8?B?ckUvNkd2ZFQ5Tit1ME9oN3BUSTZ0ZGNMbCtqK3F0eUttUTFlWTY5UE5GbUF1?=
 =?utf-8?B?SDZUT2pGQnpFTktyNG5WZDVxNVBQTWdNRDcvSVkyRTlJNUZXMG8zWUpvUll5?=
 =?utf-8?B?cS9OSDhuK2ZIU0VLSUk3MTIyMUF6SEsxek02VmZZREJHZEYxVzhSeDVGOGNG?=
 =?utf-8?B?UmZGYXFMQjJvN2Q0ZzFOVnVFRDZKYW9TeHBDdkI5eXYwYm9EdDVGM2FlTEtG?=
 =?utf-8?B?S2QwVnQzQzBRdC91TlpIZjFvYXlOODhlVml3S1M5ek5uc1NTMzYwNXpmNkFO?=
 =?utf-8?B?ZUNod1dsYjhCZndpMnA0WTJtM3BUdVhNZFhyVlN6N09obVR0YmNyd3BVdDQr?=
 =?utf-8?B?UTlTd0MrZW1tbWxrQ0lPaHU1SHVoK0pjM3VzOGUxTlVzdXd5VVNCdGpFYWxm?=
 =?utf-8?B?OExHSnAyd21sU1l0bGFJcnlwYXFWQWs5SzhDTjVvQnhRdGFpOGFQZVorWTMy?=
 =?utf-8?B?STVPUzJKZlc0eGxCUld3WmdYdkdCN0pHOWNUakdhcDdWdDBmVGtCYjFUTWJ3?=
 =?utf-8?B?WTA2S0N1R1QxRFZzNVh0b0RsRFV3OURKVXMydmtIakNSMksrcGUrTGJQTjJM?=
 =?utf-8?B?Q2NtdXZFb09NRytNd1lyRXY3dThOZlVRVHZKTXB2RnQwMkdVMUZ1TWQyQms4?=
 =?utf-8?B?MzlBUXpLd2Rmc1o5Qkk2M2RZMDExdkNPQnZ3OW56WnFZYjV2eE5xdz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 247e8e83-7dd2-4e69-c67a-08defeff8f3d
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 21:11:10.8153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hCXNZshinbpj8SANQZi4tYhksIZXuvvJF0jBAVE33wlxcQxUAJhI7aTp2Ie20azaqppbc5FJEJEHLvqdgj9ZUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP123MB9004

Tracepoint fields that convey kernel function pointers, callbacks, and
call sites, such as "function", "func", "fn", "callback", "action",
"handler", "caller", "location", "callsite", and "call_site" are
currently formatted as generic hexadecimal pointers by default.

Enhance syscall_arg_fmt__init_array() to automatically detect function
pointer fields by type signature (e.g., typedefs ending with "_func_t"
or "_fn", or C function pointer types containing "(*)") and assign
SCA_KSYM as their default beautifier.

Additionally, register common function pointer and callback field names
within the sorted syscall_arg_fmts__by_name lookup table. This ensures
tracepoint arguments such as workqueue:workqueue_execute_start.function
and csd:csd_function.func are symbolised automatically without requiring
explicit per-event configuration. For example:

    ❯ sudo tools/perf/perf trace --event workqueue:workqueue_execute_end --max-events 2 --show-cpu
         0.000 [000] kworker/u32:15/236682 workqueue:workqueue_execute_end(work: 0xffffffffab2f1420, function: toggle_allocation_gate)
         0.132 [000] kworker/u32:15/236682 workqueue:workqueue_execute_end(work: 0xffff8ac2c1adc010, function: flush_to_ldisc)

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-trace.c | 71 +++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 36 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 003048946503..bb8f4fd9ba24 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2096,6 +2096,17 @@ static int syscall__alloc_arg_fmts(struct syscall *sc, int nr_args)
 }
 
 static const struct syscall_arg_fmt syscall_arg_fmts__by_name[] = {
+	{ .name = "action",	.scnprintf = SCA_KSYM, },
+	{ .name = "call_site",	.scnprintf = SCA_KSYM, },
+	{ .name = "callback",	.scnprintf = SCA_KSYM, },
+	{ .name = "caller",	.scnprintf = SCA_KSYM, },
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
@@ -2198,31 +2209,10 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
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
+		} else if (field->type && (strstr(field->type, "(*)") != NULL ||
+					   strstr(field->type, "_func_t") != NULL ||
+					   strstr(field->type, "_fn") != NULL)) {
+			arg->scnprintf = SCA_KSYM;
 		} else {
 			const struct syscall_arg_fmt *fmt =
 				syscall_arg_fmt__find_by_name(field->name);
@@ -2230,6 +2220,24 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
 			if (fmt) {
 				arg->scnprintf = fmt->scnprintf;
 				arg->strtoul   = fmt->strtoul;
+			} else if ((field->flags & TEP_FIELD_IS_POINTER) || strstr(field->name, "addr") ||
+				   field_has_hex_fmt(field, len)) {
+				arg->scnprintf = SCA_PTR;
+			} else if (strcmp(field->type, "pid_t") == 0) {
+				arg->scnprintf = SCA_PID;
+			} else if (strcmp(field->type, "umode_t") == 0) {
+				arg->scnprintf = SCA_MODE_T;
+			} else if ((field->flags & TEP_FIELD_IS_ARRAY) && strstr(field->type, "char")) {
+				arg->scnprintf = SCA_CHAR_ARRAY;
+				arg->nr_entries = field->arraylen;
+			} else if ((strcmp(field->type, "int") == 0 ||
+				    strcmp(field->type, "unsigned int") == 0 ||
+				    strcmp(field->type, "long") == 0) &&
+				   len >= 2 && strcmp(field->name + len - 2, "fd") == 0) {
+				arg->scnprintf = SCA_FD;
+			} else if (strstr(field->type, "enum") && use_btf != NULL) {
+				*use_btf = true;
+				arg->strtoul = STUL_BTF_TYPE;
 			}
 		}
 	}
@@ -3297,12 +3305,6 @@ static unsigned char bitmap_byte(const unsigned long *mask, int byte_idx)
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
@@ -3404,14 +3406,11 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct perf_sample *
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

