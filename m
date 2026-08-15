Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022129.outbound.protection.outlook.com [52.101.96.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A2E399007;
	Sat, 15 Aug 2026 23:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786837025; cv=fail; b=atmP3zOneHSBqKO9mEN2mQDAzm07Y/v9Kca02DwUiSFKCwxbw9e0iqGPLNHINYQRkXb5aRpsjilaJs3cEQxFZJxCtBYP+Q/rliC2ThxosEuHlcSVSi4aQ9llhg4TbGIzAswMNl5fVm/KvVONhWWEkC0mrweTxi1p6+Jq7KEEcv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786837025; c=relaxed/simple;
	bh=9mai6pR7J4x1H4QbZ9/D9/kCpE1IjyFwR2xWqHPWFto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iFXXLF2V9ruFHaryrMl3Wnz0EPSpJlSL3qi8/igjbHuPZGO2qNmKdxvl0hywgZOpLYp5eXMjBrOXd/fXgBrQzzXmldh09R4aC1atRS79yv2x/xmACnnB47FvuRUdWOY49zwBKp39GsY/aUgdOXZz4U/fiV1plPNx+SqLcsJDOcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LLFRwmlQnJon4ZALOgNhiplNgXMSYpQXc7cykBXORpbvGcj28wxjsGYzho6HuEzmXsQ0tjKK+fDDRbK3q+nmT4zIZ+2+v1HgnGt4WMIz+s0YTNG6iW4MfzUmpgqxPGKDE7M3Fc9A+lWHPlcWesMUPdLdrgT8Cnvqyxsm9E4xd9p1rcEXDr52Oh08aHE2z65rqOoZYRI3WtaF8WMsFRKoY4rRvuIJ7oeLTKk5ua294tjO+CA7HjWV2NOPel85OMJSi0EXAuXkI+oJGB8gSe2/aCm5QdxtB829MHNKQyrYGuknglzk/GpMLPbAZpzspCxxzII6MBXCX5g1rnc2/ydS6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=PFx7B+93hTp2GIlpVk23AzT0Amj+WUZi0G5Dg5cMIJ8=;
 b=JvjiLCQcoThvWb/iD48omTFJtLu1i2869WVfAlfRfAxFWxy3i+nXNP4OeupEja5C/1BqtsC/W+NPEiQEI5OZoKrQw7npYJrV22FeU1u8UODwmWiCFJl6Iv36+JAJ6dt6tp08ThO/+RPmXeGKm2eebkzSsMdt3z9OYggP4azc2tUdtiIgokNzdCtKh7zFOnA/0GVstifD7cTzGBfOKqoT39+7siUSVL7L0b9AxCIrOX45yirm1aCOcrQKKk2XOmbguCLkYvZOAzDcOVOfHqZj5kha4Rnr1FgQ4BAMZPfhx8eu3RAgdYVh+rYOww2AFwVUbVwH9NTlxqUTrfpzSi1zBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWXP123MB3254.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:33::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Sat, 15 Aug
 2026 23:37:02 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0315.016; Sat, 15 Aug 2026
 23:37:02 +0000
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
Subject: [PATCH perf-tools-next 2/3] perf trace: Auto-assign kernel symbol beautifier to function pointer fields
Date: Sat, 15 Aug 2026 19:36:50 -0400
Message-ID: <20260815233651.527936-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260815233651.527936-1-atomlin@atomlin.com>
References: <20260815233651.527936-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR04CA0088.namprd04.prod.outlook.com
 (2603:10b6:408:ea::33) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWXP123MB3254:EE_
X-MS-Office365-Filtering-Correlation-Id: 75cb910a-a547-4939-b268-08defb261bb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|7416014|6133799003|3023799007|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NXnAPMIEzSe1o/L7B4Afiidy0Pu2zSyk9cPtSZlGiaR04ymcKT26C2ULqfog7endlS50lTk9GOZEoilhCiFLbcZlvBj442Q1/JVBtIIF9rjOoHouGLbpqyDLlp6miKNuas7TAgEydzUPDhVYRTkatLWTM9Ncb9qehWIkCOjdlL4RgmKTAYnOSTeTPvObvHz98WLuas7b1z/jNBeYjdHha3MpFk0G1a3oQSKvTHnkGkj+/HLdguD8ozUFR3YYqFl/ARt/NdDwsLy5sS9zOC3zwFrh4nQ4ndjM/k3iYNV7qytQl7iTfAziP8BSuM7bG9/y1Mn/9t4zderQ2LtRldF564QVZw3k+UETvrVZ49tqdXtS5r8nXk8XGrTyKAM8irssozxzHizVT9WHfkSaQKp1SlauSt5IrZg6EHsPDflfQzAnPwoVm7bPMoaPYEYw+6crSQ1+dt4pBchrVL+cZ48YqXq+hLI4c0cTlPD6hofAe/R1T1xtKGIy108+qoD6oA60RWU0NyIjolgUQLEI69qGvZbh8si9y8dSgGmdHRtTBxejJUIoJP6WDMyhZy2VCW+GjYFsXtFwXnN4jJv5XB8euq0pwCOY456kb8sr946Lb/ZLXu1G844cJuuTEdrt3z12E9O/uyqtGYCiij9MO8Z58IHyxlI4KsmbH6DZ77XnfXU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(7416014)(6133799003)(3023799007)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3RVbGF6Y0UyaGprSnBtK3Ewa3VGZnZtRUxMRU9lZEFzTHZSK2wxNkN6VnY0?=
 =?utf-8?B?R1c0cVh6U0dueExjb2tkK2ozd1BLaUZZM0RDZjNRZFRPS0hrZ1JaZVFIanNK?=
 =?utf-8?B?eEFTQUpNVTBja1ZjQndIa0ljYmNKQUJKeGpmcFZSMXFNeUx2NnFlaTR1ZUtK?=
 =?utf-8?B?WFppczNkUHlKY1lJOGtsMnVNYmFXYVY2T2U1TTIwSnMrQllGTklNOHJCODd5?=
 =?utf-8?B?ODJVNExVK1FoaTZHbFZYaWtEa1gyNEFocEZkQnRjWEFuMEJmZGxvM0x3aC9U?=
 =?utf-8?B?TWU3ak0wTWNqNng3aVBCRzlKRWRPa1FuWUdnYiswOTBtS3BwS0k5Qnpqc21S?=
 =?utf-8?B?QjZZbXVmWi9ocjA0UmxVYjhselZQN1NGNldueVBwRm9EQzZ1MzNhclo2RTZp?=
 =?utf-8?B?QnhLeWhHZWRKNGpWN0UzVzRvS0YyNnVSeTNkNEpBVkdJanRQSFVmQnI2NzI2?=
 =?utf-8?B?cCtIRk9BTG9nLzhvTVZibWRPWmk1UjNzb3k2Z3g2cFhISkxzZXJoQkVUL0gw?=
 =?utf-8?B?YWlMNzlQeTIrcXlCTENVYVBhaHVYd3RtQXdlQkFBSUlXYmZzYUQ4ZE1VaTJr?=
 =?utf-8?B?cjBLcy8zR0xGUGtMS0NZa1BNTEg3c0R2L3VCWm5jMU8ya3RTdWJIeG1XaFVi?=
 =?utf-8?B?NEd0bS9lWVJSUjhYUitmdVdHSWYxUWpFY3QyVjFVNEh3UUVEVnBmODB3UEpX?=
 =?utf-8?B?MmNmZVI3ODlqM0J5Zm1RVW5KdHlDSDBvWmtCN0FqOUdldFU0K1E1S1Jhc1VL?=
 =?utf-8?B?cHhMby9KcUlpSUtwdWVkK3VoaFpkbE50Nk05MkNNNE1IZ1VZSjd6aWFQaVlR?=
 =?utf-8?B?c05OaHNDb3ZrN3RuSkNrQmc0c0ZvQ3Q0Q0p3OFFwc3pya0lZR3h6TWlmQ0Jq?=
 =?utf-8?B?WXEzZzZCcDZYeVFaVWZXQk5MWjZ4VWdJYS8yOVp4NzRzMjhERUNoQi9jVVV4?=
 =?utf-8?B?RUFJNzYzalV1dkNyblJ5K0ZMYTFodUFIYnJ3U0lkczI4empaRXAxZHBZWEVt?=
 =?utf-8?B?WVJWUnN0TVlKeDRLaUFkckNzaXRaSHNQRXZvVkpHbEgzQVV6YkZod08zSGJX?=
 =?utf-8?B?ejUwWDgwc0RVNUhjbTVkcjVMY1YwRlczemRiNjBmV0U0aGQ1RmMvR3lLdFhq?=
 =?utf-8?B?WVNoUE9MdnpDTTQ4TUQ0MjE2cW0xSGFhdVJQZHMwOVZiYlJKUG1rQ3M2R3Ra?=
 =?utf-8?B?UU5LdXdnYmk1ODBuVlBOYkJ2OVE0L3B4aHNiN3phQ29JdExpOTdIMWxSando?=
 =?utf-8?B?Tzh3dzBlVFRTeHIzUlJHRXE1aEJDNHF1Qm56LzIzcHBIR0M3Z1dvbEIzS0s2?=
 =?utf-8?B?T2pzT1RFZDljQ2U3Yys0eWM3QTY5OFBQNnAxVGRPVFZkRGFUb3YvYUdubGRY?=
 =?utf-8?B?OEhBQk5qQm03b3FKNDM2Nis4aUh5VWJZZzBvMldpQmlzbGpmQkRENm1LQjQy?=
 =?utf-8?B?Y1J6Z29BQTgwUGJiYlVTV1ovNjk2VURSdzVRNnl6SXR0UW84SDkyMWtBMUZq?=
 =?utf-8?B?Vlg4TEV1RCtRNEFhdnBUdHhvS05sdjB1Ynl1OGJmZG81MW5KRGIvclN6ZVV0?=
 =?utf-8?B?ZjNMVjFLSDgrWnJLVXhxTDA0OEpOdGpoSCtDdkhDMFFWbmc5YnhtZ0puWUlh?=
 =?utf-8?B?OVVJVXlldTRuK0NSOVA3cXVUM0dWWjNFZVBDb1B2ODRzNFhtQkNBaEZPeWFH?=
 =?utf-8?B?Rjg1M1RHT2l4SE5iaE1Ga1lnMmlabHlSbk9RWUI5TiswSDkvVi9oM1NZMXR6?=
 =?utf-8?B?VHg1Q0dqK05QMGg3WWIwbHdtK3cySlBtNWJRTnplUVdDS2lrYmZtbm04bWZo?=
 =?utf-8?B?NGU3bHYzNHk3eXlTYXRCbmFRa2FxZjN6ZkVDeUtPOElTS0szZWtkUWxsa3Fp?=
 =?utf-8?B?UzRyQXFrVEh1cTl4MFN5eGIySWM5V1YweEVCYllVVU0wbHJISERlaWxSOVFj?=
 =?utf-8?B?aVpkekhrMi9XZUJOUjVSeU5JL3N0THE1Yzh2UW94c013TkpKNEk1TEdJWTNL?=
 =?utf-8?B?NDRIeXl6eXlBSU1QZ3lwTzdCUkFyMStuZHdxL2l3TUs3a3BhbzdtWEpWbHNI?=
 =?utf-8?B?TWZvWElsTGMxUVFkdkRNaGhndjIxSFhOR29hY0FlS0MzaU5Qak5qaThtWDNS?=
 =?utf-8?B?Q0hkWEpYOHZkMVhTa2h5Q2FkOU92T2NCa1hONkNuaGRvTWo4UllLKy9aQ2J6?=
 =?utf-8?B?OXFjYkhpOGZkaGZFc01RaUxBNmRrbmg5bGFQOE5IOFFaeDFEaVd1ZlhPYTBO?=
 =?utf-8?B?WTZaTWJTTlNLR0tqSEhEZURoZUJkcll1ZjB1MzRIRTFzSWp1NlJWdUdndlZL?=
 =?utf-8?B?d0x5Um1KdFFxbzdBNnI4UGw4ZEg4NHpFc2Irc28raEF2QlJWMzhFdz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75cb910a-a547-4939-b268-08defb261bb8
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2026 23:37:02.7258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JpWqJePRv3Ju4d+F9zQKg5t4aQeIbzSF079k/g8KGbIIz+Q5zA0znXUNoz88ikd5pekF29qH4hHtxFfpC6L/1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3254

Tracepoint fields that convey kernel function pointers, such as function,
fn, work, action, and callsite are currently formatted as generic
hexadecimal pointers by default.

Enhance syscall_arg_fmt__init_array() to automatically detect these
fields by name and type signature (e.g., typedefs ending with _func_t
or _fn, or C function pointer types containing (*)) and assign
SCA_KSYM as their default beautifier.

Additionally, register common function pointer field names within the
sorted syscall_arg_fmts__by_name lookup table. This ensures tracepoint
arguments such as workqueue:workqueue_execute_start.function are
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
index 102221b301a5..825b16581581 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2091,8 +2091,13 @@ static int syscall__alloc_arg_fmts(struct syscall *sc, int nr_args)
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
@@ -2193,6 +2198,14 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
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

