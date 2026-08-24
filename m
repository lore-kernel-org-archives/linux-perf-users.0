Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020115.outbound.protection.outlook.com [52.101.195.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05B030CD85;
	Mon, 24 Aug 2026 13:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787578306; cv=fail; b=dnhhAH4SUBp3RR6mUSOwkFJsuxCYEn3eIFcYLam1KlqNfGH5PYIBCwi3ALiu0zSDdwKIshi7OuPpWCTZk1KoicphtP7V1lmXVoxfn4Txa30iFABUzWpEKBg2ku2pGfDQwU2rvYCmPnCH201KsRu+mpVoz92h/vC2cncCGNM0Xf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787578306; c=relaxed/simple;
	bh=V2Nss0rPfERz8tni+kNmB61/s+XWbhZMXWORUpb7KCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lyGzdUgfr0LV4GsE2tk0cynDrJI+HM25Zc0u0wQ88CbgZ4lAfi/EYkE3ypgw+EJaKORSZlqkOJr5Cza05izqzm/bT0iXrdq6ggE4vdI2E28h+asBNqX4y1a+aSwmnX6wjhpqExqKguF70LgvoW6rDIkPojBKV8d8N0VmTn2sgic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=plYLa5qi57GY8vh5h3Dux8tIGTd6QcnqRtDOvZtxqHQyapDJjzhGcFngxkSaJ5PDUgNNWccj5TfSZMwbTjen3sDHz6WYCIywVuetaAFLEoiGj76ABSqgL7Mo+0xDZS/IBFEpz4d4aRy2/HDUC4OxZNN2RLUxCHrsJRcFElESwU0mpcRtaLIaV+Om9VDsOZfVZOCEWv64RbeI9B64DilreWtKKQ0CMKmPI/NiT7oyhebFMxDU7Hu06uHLmUCtHpUuO+4cHtAnXDzNcogQocD8TNgjPIkjwXCwwyo+0N8ofAgHyt3UxCiuc9L1OhWGSs1upWPeDwUzEkAZoMCWzBi6qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=5ZHTSDK7uWwI3KNGPNQDIcQGwd+ae1tqXNe/ZIeZFtw=;
 b=QAxPBCmNeVjBJgDv50Y6LXN+Qf7jRbRobcywvaUq3gR1IhMNYFO8sLXw/74EEQp34BzMy0wZZrPsbeDwypWnZSpzWNm4kzRXj0+XRHXw/0eitCL7BfZ6ct1qSSLXBbRNIUGqkW/d7Ae4A5L3dsKXoUufUYFWWUmhYRJUU35IBSjWBjCIWd+dVwV6JMp5H3ibZzJCwhXEfBpod+oy0WkyxQjeUzZD05wMxEHDYxXgBKc1rjXlX1QRvUfGXDLxxHRdVOhQB1JJGKYteR8zWtwvTUOUncC0yMozdOzvvDCIcQp/hVNEU8p0ARIuZ4a6GOk/0KvpwJd/cnDJVBMFrSEaBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CW1P123MB8950.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:271::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 13:31:28 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 13:31:28 +0000
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
Subject: [PATCH perf-tools-next v6 3/5] perf trace: Auto-assign kernel symbol beautifier to function pointer fields
Date: Mon, 24 Aug 2026 09:31:20 -0400
Message-ID: <20260824133122.751733-4-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824133122.751733-1-atomlin@atomlin.com>
References: <20260824133122.751733-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0344.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::7) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CW1P123MB8950:EE_
X-MS-Office365-Filtering-Correlation-Id: 583ffec3-186b-4238-500f-08df01e40098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|56012099006|10067099003|6133799003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	zS51VEJqG5IZeo6Bt2sCq2pki1YBnxz2hY0cmFsn+RHAUqIORhEzMh6vPdFIuXz0cW/rKN3JXjPPi7TUhGTM35hQstvop3/F3RBCzrurPZTcwXwYk4p3p8FTSpIGMoLyssQ2k7J/CCIasTPhc5hhzG+a5GhnpHGLfePLlHwldDDjavKOgrwwOuR3zfDlP0dFTgaWzDem0MV/pK2GbJmWej3CMNRwlf7vKYklS9PAva8lIPNIGcvDLK4Vp1LC5uqCLzQ+tGUSGcCg2gD94h2jw11bIpw4zBYkeLP5Ks6zvKtwdeallILXq/0+kawJXV2pMATgDxCStXa6H62uDHncaLmeQVaBoxQSzvBicWGyrMEi608Sttr+Iiz6D7+/bpk8dYqayeRV16ubu1sblBK2/7dgtF7MCMcOg+LOKSGRsHj4H8VCKBxVTj62sSqTcRsXHSpUt/zbjERAY/7TfO4BDPcuOt29wWYwAfv++PQC0UQd5wXcVPeajaaKoswm2PsY09clD9aT68kzMauFxOGkpNP5QepFbQDuyUW3JjHGh56qT7u+ZPkre/3pK3ZL6b+ceSf0sEqQbqPctnHqdHO5pZ4Fo5/9Nl7lK+uZMdcEyggr1+q3vncLoeFrkFnbpbnUeqHBwc/4Ay3dPaGM3yfoaHDQwGGnau2W/LCIN0H4lMI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(56012099006)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THlCdDEvdTcwT1crNW95Z0d2bStoNVBJYnN5b1d3L283V3VYY0ROY3FMRkYv?=
 =?utf-8?B?c3U1cXpONjNvNDBieUx3UFNPN0VVWnc3a1hqSW1TcE11bzJMOGlkblhoNDdM?=
 =?utf-8?B?K0IyM1VPbDh6UGdpakNRZThRVUtwTGVWQkQ2K3I1WHpBZjlqYXp1QVVjTFho?=
 =?utf-8?B?dVlmUlVHbVJrZDlCcUFPa2Y5c0RQY3VRNW0yRkREbWxVOWVhSU9Ua1ozWTVY?=
 =?utf-8?B?bHV6VG1zRUdRcGN4UTBLanVTb3VZRGdJekVRY2N6WURZK1dNbVhBbWdPdS8z?=
 =?utf-8?B?ZXBlSkYvdVcySE13TFVNcHp5K1NiSUhacWRGczE1bGR4UjV6WndTd0ZOZzlL?=
 =?utf-8?B?SytwTlhsUkRZWStRVlRWK21pS3ExemJGVGRoL3g1TDh2VDdhWlZlVTFRRjVM?=
 =?utf-8?B?cXNwdjRqVFVaQ21jVVVJNndTWU9vNFJHeGVCZmZmN0JXaTRxUFV0OENUeno3?=
 =?utf-8?B?YWhha2RISkRhRk1tUEVuR1p6NVlmdnpXODA5cklzRStOVktyalVjNmNYcHht?=
 =?utf-8?B?d25idDYxQjk5NkkxTzdMSkpFWHpCY0RDd2V4UjNCU09KWnBtM0tnL3U4blc3?=
 =?utf-8?B?TVdlNXRSUjZWWXpyemMwQm55d0JHWFlaZW13aFhCcjRpdjM0eUhrOWNJTnJF?=
 =?utf-8?B?c1k4NWZhQlQ0SWpiaXpzR2xMMkNMcFVQR2ZCTlYyd1VjYnI4ZXZnbXlWczhR?=
 =?utf-8?B?cTF5d1pTUE9ZR29FUTFMT294YjFQY0E4L3NpQzV3dTRBVlNLcU9sYy8xNVlF?=
 =?utf-8?B?M3daOVgyTXVYOXp3RTZSVDRwYXowcnU4R1BpY2ZEV1o0Y1BHQ0cwdkpsOUhL?=
 =?utf-8?B?MWZVZk5aT0NGdUZBdks2YlVXSmV2QUxoL2x3a0ZGRk1meXM5aGpwSXVnb20v?=
 =?utf-8?B?MmNNZ0pUYVFWQmd1V1FqY1hIOWswcXBnMFc2N0ZtL0wrRlVDMVBOVFpxS0Y5?=
 =?utf-8?B?cVBVSWVpMmNpY3BrNC9QbjNqdXRzWW9MWUcrUWlYWmdDdUE0d2o2dUx4R0Y0?=
 =?utf-8?B?ZHlOZTlFQnJ1SUNpdWt2MUYrWFFEbWVxTjZoZHZhMS9ONkdTcmhlMXlhTDhF?=
 =?utf-8?B?a2l6Rmt5b3R4djVqV0RLYmpFQ3MreU5oSkh4RXBFYjVQN2Q4WjUxRlZ1SFhl?=
 =?utf-8?B?ZGovOWZmZUpzOEtwaEJ4UnNESFhEZTkvNlFYVjAxN281MDkyOUFtbXpNbElJ?=
 =?utf-8?B?RS9vbG80OThxNTA5QkNoSUJ5WXFJcWMyUktXUnpGUGF5NnU5Q2tjUDZJN3gy?=
 =?utf-8?B?Y3k3NWdWdjhITzhoL0VVUlZ4REpzZXJlV2JuRENubVNJQld4MzVDSjVMRjU5?=
 =?utf-8?B?aWg2YWRGTCt0K3d6YUE5UndtajIyN2o5RmZRdGg1Y1NWY3U3MmlGWUJpVU9O?=
 =?utf-8?B?MGRZL1htZWk0UjMzaDBwL1YyazBuemVmNHd0VG92RzRCeFZNdjhKdys5c3Fa?=
 =?utf-8?B?OTRnUjVtT2piMFN4ZmJyS0xYNmpZOUkvSEpoQ3E3bTE5YUY3bXlNUy9KTTEz?=
 =?utf-8?B?WDd6OU9pcmI0WVVjNm5WaDFISjNQdGNmc0x2OFQyc3JmTHc5cDFlemRmbFQ3?=
 =?utf-8?B?WWdtTGNtTmVKRFBsZ2lobUdWa0MzeU40K2R4bVpReG9xUlNnNGlobmNwNm5B?=
 =?utf-8?B?WHl3Tk0zR3NSNzRJWEFzSGVFbFE0ak1lQ1BtUDZTV1FrcFlkbnJQb0w3Sjdr?=
 =?utf-8?B?ZGNOOFZLc2ltQm9CQURQZFFyODFqa0hZdTVoSzU3QWR6d0JVWnlzNjc5MC9w?=
 =?utf-8?B?R3doL2ZuR05ObHpzYXdtWVdidTN1dk01N1BqTTN5bFZKZGgyQ2ZYTDMrYy82?=
 =?utf-8?B?WVNDZkNPdjgwSHZSRU82N2VRK3pCSUNBMUsvMVRtU3hZK1lTUXFZNUJPK0NR?=
 =?utf-8?B?QkZjcHFIcE45aW90MCtjTEFwQjZmcXBPUE1RWHg5RDhIdENLeVhjZDdOVXps?=
 =?utf-8?B?SUR0WWxHNE5aL0RnV2RXaE94YUNweER0M1A0aTlJbzkxY2lHS2QvdEdRcTQ0?=
 =?utf-8?B?ZWhTYWdsbUNpeHI0UktzTnI0R3BndVBVNmhrUHlqTjhNSGVkRlVzbmg2dnYw?=
 =?utf-8?B?aXROWFBsMXJFTjJDbjBaREdmSzF1QUlleDdsMXBQekZhTDVrL0hKMmw5TUkz?=
 =?utf-8?B?RHdWRlRsUEFEVWsxblNrYTRsTTVRZjZoTnpYbzFCVW9ueVVJeWQ2ZjdqbnZV?=
 =?utf-8?B?ZEp5THV2bDBJakg3V2dQbnpXRlpEWCthclhTVWFlWnY5d0JVK0svK0QyMEEy?=
 =?utf-8?B?NzJMaFNENGNTc0J5RnZ3b0lIdjBLa1BZcnlRcEJ0UmR0R0tkZjY4SW5yWG5K?=
 =?utf-8?Q?0VmtYiWetR98LDbkly?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 583ffec3-186b-4238-500f-08df01e40098
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 13:31:28.5412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0zKFipBNEIw8WBcx1USl6Tb3PmCqQLdaHjInflVIYCAKjqMKhuTvylCV3qojx9bsgNIb2OvQRDnFhwj/j41E/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB8950

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
misclassifying dynamic string arrays, enums, or standard non-pointer
integers sharing generic names, guard SCA_KSYM assignment to true pointer
fields and pointer-sized non-array scalars (via field_is_ptr_sized(),
field_is_enum(), and field_is_plain_int()). This ensures enum fields
continue falling through to BTF pretty-printing. To support
cross-architecture analysis (e.g., analyzing 32-bit trace data on a
64-bit host) and 64-bit instruction pointers, determine target pointer
size via tep_get_long_size() while also supporting 64-bit scalars.

This ensures tracepoint arguments such as
workqueue:workqueue_execute_start.function, csd:csd_function.func,
and xfs:xfs_bunmapi.caller_ip are symbolised automatically without
requiring explicit per-event configuration. For example:

    ❯ sudo tools/perf/perf trace --event workqueue:workqueue_execute_end --max-events 2 --show-cpu
         0.000 [000] kworker/u32:15/236682 workqueue:workqueue_execute_end(work: 0xffffffffab2f1420, function: toggle_allocation_gate)
         0.132 [000] kworker/u32:15/236682 workqueue:workqueue_execute_end(work: 0xffff8ac2c1adc010, function: flush_to_ldisc)

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-trace.c | 113 ++++++++++++++++++++++++-------------
 1 file changed, 75 insertions(+), 38 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index effb00117bff..f6ab7dabfa4c 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2098,6 +2098,18 @@ static int syscall__alloc_arg_fmts(struct syscall *sc, int nr_args)
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
@@ -2173,6 +2185,29 @@ static bool field_has_hex_fmt(struct tep_format_field *field, int len)
 	return false;
 }
 
+static bool field_is_enum(const struct tep_format_field *field)
+{
+	return field->type && strstr(field->type, "enum") != NULL;
+}
+
+static bool field_is_plain_int(const struct tep_format_field *field)
+{
+	if (!field->type)
+		return false;
+
+	return !strcmp(field->type, "int") ||
+	       !strcmp(field->type, "unsigned int") ||
+	       !strcmp(field->type, "u32") ||
+	       !strcmp(field->type, "s32");
+}
+
+static bool field_is_ptr_sized(const struct tep_format_field *field)
+{
+	int ptr_size = tep_get_long_size(field->event->tep);
+
+	return field->size == ptr_size || field->size == sizeof(u64);
+}
+
 static struct tep_format_field *
 syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field *field,
 			    bool *use_btf)
@@ -2200,38 +2235,49 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
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
+					if ((field->flags & TEP_FIELD_IS_POINTER) ||
+					    (!field_is_enum(field) && !field_is_plain_int(field) &&
+					     field_is_ptr_sized(field) && !(field->flags & TEP_FIELD_IS_ARRAY))) {
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
+				} else if (field_is_enum(field) && use_btf != NULL) {
+					*use_btf = true;
+					arg->strtoul = STUL_BTF_TYPE;
+				}
 			}
 		}
 	}
@@ -3299,12 +3345,6 @@ static unsigned char bitmap_byte(const unsigned long *mask, int byte_idx)
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
@@ -3406,14 +3446,11 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct perf_sample *
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

