Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021122.outbound.protection.outlook.com [52.101.95.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17CC363C55;
	Fri, 21 Aug 2026 20:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787345386; cv=fail; b=lUKl7FXwYJu2bwxsaoKs+HXNa76I90LUoLMClKgb3k4blwFfBpzDBTdk0Cb5nEpKUPRwMP8Rl5sWqbPukiSixMy6A31cEj7fLohiuhxNJcWlFAvcy256/YgkLpxsh2XUq071K+z92WjqYGhGs7zBqtlQjYNlPHLF5g+ca+8yDLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787345386; c=relaxed/simple;
	bh=q/hPSQpXVEv0i+bHYsOP0/kZFL/Kt6va6NGsLuBchzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EE6jk8maAdoSK5aykWMIr6TWNeFEis/G8L3vSJiO8ZVlqYo6t6Agg4PU3bhancTGStTqPVdnSyHg+Y7VBK2c+IeURvy3Ri5RHJFI5b2yyVIvTXXBKc/EE72fHtRLcKosAF8SmjJdT6Ap0mefErgpqtzj4iONDYiqD3x2izvzij8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ufOq7grWw0WZ0J/FLGc3CT3/GXG1DqO8R/HS+fea7/ok+gm0Q4blc0lYXnqVuarIBWh5vv2QDFoRg4Lpxk/zAxZBZ58ww/YjaXRDv+fleLfoP0F+M/U45E7JH5sJqTu+MkNtBCVH5IrNVU2B2V+j95AnkPjSWAZJsqgkVOSty9tc82zgvXrMnT93eedEVpcluU4SR51a5DGj4Ucp+ZtNyZeHshugvbGWxdtqigz7OAM8tIYKq80rHA5rZ3ZTEmDTA3KDopNk3Hg+LxxhwyWzvPF7zQgm3NATrUFKFg7VhihEj+8vJr6PpeB4xKx3LkXQU+q8QkkxOZyex7xTXFy8gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=dIyEvbqshp8w3bL7xeNT4mypxCQtnRx7F4ZVfeNClVY=;
 b=tzrpyZ/1IEHXTAABph4NxtF8NKhyz/z5sIB5BmUcK7uMIsSshtqSZKKFxXw9GzYw+USrozeOyPxX5D+AAeMuO24DcW5JtC3njWyGwvuE+wCgFotzjAtlkxRhXdWKeIAhhBse1mo295S+BSpH6tA8CLSmcbvd47toS3GCXP6YGjy3fRx1cnJQEAFKLB6Cn7umAahD+m7QT81yx0hX9v9nMK9iD4Mq+LMzN65QyGieCiHOqCszp2eOlvSeQJglyeE7QCzYSRVLUbxBaMmb3QWnFJgvZboHOwodVCGaQdR1GksXMSSS83je/yPHvzJcTj18JfiVAX56//aRDq+FU6Tudg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO2P123MB6104.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:25b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 20:49:42 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 20:49:42 +0000
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
Subject: [PATCH perf-tools-next v4 2/4] perf trace: Auto-assign kernel symbol beautifier to function pointer fields
Date: Fri, 21 Aug 2026 16:49:28 -0400
Message-ID: <20260821204930.679027-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821204930.679027-1-atomlin@atomlin.com>
References: <20260821204930.679027-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0804.namprd03.prod.outlook.com
 (2603:10b6:408:13f::29) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO2P123MB6104:EE_
X-MS-Office365-Filtering-Correlation-Id: 69bd983e-4f4a-4c29-e33d-08deffc5b996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|56012099006|10067099003|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	8ve4huT0GnBfigkJbYEYQPj2W+IUVGThIoYaonRV98bnvW68SCH8laaOBwBFzfEdfJQqCgEWAYjSP/XXblhrNG8gOSvGHcWHFxiuT7yE6q8cRluD4zPJjy9C6hE6KYRlZEEgsGtxUy+dRNS858V6JYGl+hQBpdVtXagX96BsszaKYuDUbrYWpoL8Q2Y2YPJtaIb/Ulm5ZUj0aZrhX+7OfDD8MzPMGry2LO2yvxY+upzoueWPWptXtZX6TQ0VTUtMkS/Exx5Enj0i2+FjWwfecaZswjSi2w1Y5S6nLhpVXoi6+XYffBUi9m3IUIGiYqQABF9YT+2kSGwED4wPqOFFFAxadCT6E3ZfvhnkCYLkS134j6SK35AdpeBwvVBheAkJ3EJOwOoR7zPbW3xM/9Ql6Mw/FjbCctuVOH/LPqiNsu8M93pa3RkGozg25qtH1xWjQ9sr1BI5zFO0RA73ASBy22J6GoMhjWeQTNwfTqCHGQsEmcl2t22HIqCHQNjKk/wh0PKe3JfpGbQhshRd3dKIMhOVTwuVirqxF48eo47nR/HC/uvYfCEtyrXpza1z90c+A08r70c91BTFWldwKvUrxirLuW5pztD8eBC+4x1h1SiEOc2ZraZouiIVQy4QvRHte+t5uTxG/Lev21+KsB5Xe6XQGbs3QU5j1D6cc4wDJYo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(56012099006)(10067099003)(3023799007)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVRoc3lxczZ6ZFgxcUIvTnY2VXhGWDQwcndWVnFEdUR6Y0JLb3ZJQkJzODA2?=
 =?utf-8?B?a2ZaZGgySzJMQjJGQVpOcVdtYlpIcCtNdW9LZVdDSXFPblNGanNUSi9TbGFF?=
 =?utf-8?B?Vjl2aGdmOFV3WlVlMTdiQUFrZ1ZvbUpDb1NIclpaTFhLbGdhVUtnQTFEZEdU?=
 =?utf-8?B?LzdSdmYvWmZnVGx6dWhNWm9rRndXcGpXcFJGM21jNDY5eXFPcGptYjR3TnRQ?=
 =?utf-8?B?ZFBZRlNTejJjSWVDZHNNaGhPMFdLQThsLzh4R0h2MGZnVG42NDlPT0tETXM3?=
 =?utf-8?B?Q0Z3VEdnNHNQRjVnbm9lWUppc3ZzNm83bG1nSHAwS0RlQ1VGazdKU1VpZDcw?=
 =?utf-8?B?b2JNa0FFYnFBVnRPcXhMS3g2RlhtblJTczBrZG5ldnR2MXpaWGsyVmlDbDdV?=
 =?utf-8?B?ak90bHVXOGlEK0h5Y0IySUF3eEw3QlJ1MEJVQjJSMEM1dHpkMzlLQS85d3Ny?=
 =?utf-8?B?YVBPb0R2ZGJTaVg2VHFaN2cyMng2NTFFcWI3L3NNY3k5Sng1QTVtNVdSTlFv?=
 =?utf-8?B?bWZ0dlJ4WXh5WlJHQkNFQmpBNHJxMVlRWUhucEJ0V0tVWnNZYWp3bmlvQ25E?=
 =?utf-8?B?TlBoNmpqeFJwL3MrcjhZSmo4MUtVRVlEZkVSOVJYQ1JqdGwvRlhhcVFMbG45?=
 =?utf-8?B?S3VBKzVIZ0dPRG5XcndOZktHS2swZGxRazNaK2pQK0s2b0FSVTRwci82SmFx?=
 =?utf-8?B?d1M1ZUZIRzhwRUc2eDcvQ1plMHIyeWRlKzVRSW5pbU1NWlFFdUJFTW1pTmho?=
 =?utf-8?B?dVY4eUFPZlR0Ry9lSlNRMHpUSEliblVMa1ZKdjZhdEpBOWV2KzRydERoRFBu?=
 =?utf-8?B?cngzU3JxQ1ppT25NeFFNU0NCQmJYaVoxU1ZFUkdVby9pbXEvMVZvZW5yOTQ0?=
 =?utf-8?B?QURKYUpkUGZGRXp5ZWVxTkk1dHBTblJMOTIrSDdvclpDbmw4Vlg2UG5Fb2Fo?=
 =?utf-8?B?Vzhsa012b21xbm9IZVE0cUJBeWZIZExTVGQ4SGtqaUo4NktKY25RWmdGcFVK?=
 =?utf-8?B?WUZHcUlTZ1B2c0pTaFFwbHowNERpMmdoR3J4VWttMTVDU0Y5ZGxGUG9zUWl6?=
 =?utf-8?B?alA1Q21PUzhmNnYzbm1SUHA4N29YVkt4OEZpVXdzWnRGZW56TFo1VVE2eFNj?=
 =?utf-8?B?Vzc0eWdpMGdVazBLQTRmQVJsTVdpQTlOQVBodjIyYThXVll0NGRpZlAydmps?=
 =?utf-8?B?UThBdlUzVWxYb245aEJoS1B1WnVGVlN0NkFIYVRZZEVqZjVZREhOa1BZbkxU?=
 =?utf-8?B?M21HWDhEeVdPU0o2WmpRZTV4VC9zRmtoNktHVDc4cGlUamZDQmtmd3plaHNw?=
 =?utf-8?B?K2RVRlN5ZElnM29tQnQ4K1pIUU9wVmRKcFBrd3crVWlSTzYvS3BjeHIvcFV2?=
 =?utf-8?B?dnFNQWR3ZUpTL2RzQkZPR3U4Mnd1WHFSQ0o2QU95NU90SnZiSzI5NVdJUGlR?=
 =?utf-8?B?ZENxVWJQY3lUamRseGF6ajJLdGdkcVVOa2hXQmJidlVZY0oxM0F6SGZyclRw?=
 =?utf-8?B?bEJUK1B2RWVuQ1llbDNZZHFqVXd5Y1crVVhvWnh2Q3hPbmVZc1Q0NFRiRUgz?=
 =?utf-8?B?YWo4OVJEekI2YXZpOFMxZ3phUWFrR2drUEd0ZlNUMS9sMDZDZ01JL2xrV3RI?=
 =?utf-8?B?SHJ5S3BWVk5jS2xZMlpiYk5OL0JybWhqM0hPam4wUXNYbkZ6OUo3ZmJFTW56?=
 =?utf-8?B?OHBhckpWR0RVZ1JRRm8vc3JjL3VsQlNTM0pJNUEyY0ZBZWZEdUZnM3NNRkhI?=
 =?utf-8?B?b1J5TjZqY1hVQ0U1dXdFU1VwYXZoT2xKNXNCVnI0M1BhR1ZtWDNmMUlOczEy?=
 =?utf-8?B?dEZCeU0vTU56RzRIYkpta3dvWmxVMzV6K3Z0VG4vTzVUUmlaMHhQZ3l6WDR5?=
 =?utf-8?B?TkdkK3JnaXI3aktDYWFYQmc4MGNnK0RoQThqOWFQSy9rS2svV1UrcnpwRjl6?=
 =?utf-8?B?SzBFamQ5Qy9HcllJWEp2aUcweTFpUmxlSXRsdzFQOG12cGFUaUZHTTFIUVRz?=
 =?utf-8?B?NGhTaG9VOGlQY1FPQkpBQjV6dU1nVlZlbEJZNFZmRUczSnNCWFZTWC9wWWhs?=
 =?utf-8?B?dS83M3FWYVFnSlppRlR3ZThYVUpkVzJMbTBpUTJPdDlpeWQ0dXJvdG1jZkt5?=
 =?utf-8?B?OXdSM3QwOEZQQ3FxMGlYWmxHM0VIUlUyTk1KSG0wNmNBWFB6Y3BQamJObmNW?=
 =?utf-8?B?eEJkays4NzRtYjBGb0xCcDBxazdUM0RlL2s2b0pEeHUzcWdEVUNmMk1RUmdr?=
 =?utf-8?B?TXk3Z0JQZzkxeGxBZGJzNVNLcVpJZVRmd0FRL3M3TTNVZW5McThrd1ptb2tF?=
 =?utf-8?B?TWltMUN0MlF1NWRudXFJUlRLTFROTUtjTUpEa2krMG54Y1ZpdFVOQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69bd983e-4f4a-4c29-e33d-08deffc5b996
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 20:49:42.2405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QEh3lKzyrsOSvWMx3WXAjufJibIG1Jko/YLhxouB1PuwEOOH8BLoU5eTAZfCSCl8MxQj8jsOKaL62Flr9ypv4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB6104

Tracepoint fields that convey kernel function pointers, callbacks, and
call sites, such as "function", "func", "fn", "callback", "action",
"handler", "caller", "caller_ip", "location", "callsite", and
"call_site" are currently formatted as generic hexadecimal pointers by
default.

Enhance syscall_arg_fmt__init_array() to automatically detect function
pointer fields by type signature (e.g., typedefs ending with "_func_t"
or "_fn", or C function pointer types containing "(*)") and assign
SCA_KSYM as their default beautifier.

Additionally, register common function pointer and callback field names
within the sorted syscall_arg_fmts__by_name lookup table. To prevent
misclassifying dynamic string arrays or non-pointer integers sharing
generic names, guard SCA_KSYM assignment to pointer fields and
pointer-sized non-array scalars. This ensures tracepoint arguments such
as workqueue:workqueue_execute_start.function, csd:csd_function.func,
and xfs:xfs_bunmapi.caller_ip are symbolised automatically without
requiring explicit per-event configuration. For example:

    ❯ sudo tools/perf/perf trace --event workqueue:workqueue_execute_end --max-events 2 --show-cpu
         0.000 [000] kworker/u32:15/236682 workqueue:workqueue_execute_end(work: 0xffffffffab2f1420, function: toggle_allocation_gate)
         0.132 [000] kworker/u32:15/236682 workqueue:workqueue_execute_end(work: 0xffff8ac2c1adc010, function: flush_to_ldisc)

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-trace.c | 88 ++++++++++++++++++++++----------------
 1 file changed, 50 insertions(+), 38 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 003048946503..0a12d7b37d8d 100644
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
@@ -2198,38 +2210,47 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
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
 
 			if (fmt) {
-				arg->scnprintf = fmt->scnprintf;
-				arg->strtoul   = fmt->strtoul;
+				if (fmt->scnprintf == SCA_KSYM) {
+					if ((field->flags & TEP_FIELD_IS_POINTER) ||
+					    (field->size == sizeof(void *) && !(field->flags & TEP_FIELD_IS_ARRAY))) {
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
@@ -3297,12 +3318,6 @@ static unsigned char bitmap_byte(const unsigned long *mask, int byte_idx)
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
@@ -3404,14 +3419,11 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct perf_sample *
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

