Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021091.outbound.protection.outlook.com [52.101.95.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B45432300;
	Wed, 22 Jul 2026 15:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784735464; cv=fail; b=TXUgHWXwC3fjp7n2wU/OSsW0bADV9C5p8Y+iUBbVbMduM7kH6UZ4P4N21WyKLVvql14gpluFStiC2QtMkVo+Y7Ne6RUZVETFtNdLVI0l4/QrK49iPCfJA6/aIs01aKi8y4rp2EcXX3AY6imt9cUqHOgahL5msJTf01FqCDUQOXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784735464; c=relaxed/simple;
	bh=FB20Epr+e0WpqAtd5VRySspv11KQCHSm1luebsLFEH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DLj0DXD0aLI8Ihfwf57ibeqqiAdm7VdRnueyDPHp0KLonM8AuwBMn8nbtC683QRZIK2aKNKOr/HGWwd85BcaYyVqq10wn4wy+eMlWH+FQ26H93zDjP+k5d2OJxDF/rGMMWoqhxY9xEx6nAzVT5ytmzEfWHDJCvUVPuMtKnGRqjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gnII71Yl/sZHBoc+YQshZD+nHnHEVb8bJdej3CuSJvH/Q3Zbtot6hErkHoFIdjG8wxD5HY0JlIWNKAyu/gW2egE+6Ts9LHvPbXqz18eV9HNN4mvDCGdgEs4kLVYaVqy1Wsa74xZqlQSBowszy93MDfV5Q20VHJwgZ1UIS6pRxhROM/cnOCKAycRm+yrYNu++Rt0BGs0pfBjK7yVeFJmHMjXSwt6+kDYYkMBlnCauEgcA/gIyX0ZKZplpbLOaDIrHMxXi3IRmYDKKRX8nreOPZwoOlg9K8grB7RAWn9uiuT0rWXMetl2dYhFueuWCNsBQenWJyeMDAMgmwupvdqYOUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=NBFQnGTRkEv2g0Dd2oPTFpD9KVWMTnUYqI5OBdbqz64=;
 b=bmiG6iSqDVX8hID9O3feEcpjH9FzWDKSKtZcggAA/p8l10ODRTROTzZsZfjaam+r/91ErUrPGEW/NF4xpJJRm9F8KCcpkmfO2oKd7nVvGfLYSjg7Ep2nICgLHTiMzWgpZz2O4+XFLsTLx3Et7SrtmkfJrQz0r0obMmjMXYgxQig50Dk6vqXt8s5QmGQOuv6sfD5bJ2fNSrAecnfRpjMTvu4rb/1kN4DbvlmhQuGl5tZGQB+kMb6pSVnsBcCqnFsXZxDrtkOzHYAH2EPNVAvw91tlbdqgPCi89CUrVqxgGTt+4NOGA2R0+4UTwBhuejarwOWXrTw+Pj3gbp6N5g73kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO8P123MB7473.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:3a7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 15:50:58 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 15:50:58 +0000
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
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] perf trace: Correct default cpumask formatting to hexadecimal
Date: Wed, 22 Jul 2026 11:50:48 -0400
Message-ID: <20260722155050.503516-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260722155050.503516-1-atomlin@atomlin.com>
References: <20260722155050.503516-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P223CA0004.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::9) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO8P123MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: e4be3201-34a0-4f4a-69c5-08dee809059d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|7416014|1800799024|6133799003|18002099003|22082099003|3023799007|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	O/wVBdU06OlyCaYAtKu56gDpVnGAdYAClHh3e2+q2sH9vovXkE7c1YozcRjuk83m3bLlxJeNv61SNym2w6FryihmK6Nrmp6qqs1/Id0gy0owIrr+5w28CfsKkJXn/iNkZt+TW9MSJ51jsG9gzGRzK6eSCJeTABmfKVqlwUtEIIAWQoWKxaDom+DmvnVijVvUCeMc4svFRDhQ2nU3LotDGaTvv5PPRkthZGVh/+nK/B3LG2F5r+sQ8pEUaMExtFZ0iug2Zyx4298mK8GN48y1ODkOnJxDPb3mf7C/+pNw0kDqZ5i/e+8+AdJjGCuukgIn72S8zeDSKGUgr9db5gP8qTFjDu6lJMuk/rRtwadMRtIK4JFu9JMHGPVj9ob2D248LNP69TRyTBq1SfM2aH0Hu4RF7PLlBfRIIo395wvizZVE3BefQNoZ70MWQBYvDkTBKrIrXzKSfqUPlyrY5F5XXrGOc3UaLy6hiQwxX3e3URNF6pwFsbvXhd66RYAbFn4TNt7v1oMkHmyW2cjBXZAyKp0XYPSuiZe8tIjhZNfGAxzyugqzmkKpVFyMi8tKDbJS8fSGYCswg8GC7sXfIdr9JOUxYMWhGiadwNMqNT6nZYDfzdft9kUmj9Ngj56GfIMJjN7F0eNQjbDJpLJ2ULG3/WSLm4Ne2zL4d4SVn5sEWMQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(6133799003)(18002099003)(22082099003)(3023799007)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r2CrxCb6eKtCjgBlhyAowiiZmWEFGTukS6Jvu5Gqs52QkXmcD7lGbUTC8fHA?=
 =?us-ascii?Q?itxI9/UttYU0VXXv9+W784BtcJt5qjvW8A9OwffK1av/MFfQFWiI168O+DCF?=
 =?us-ascii?Q?paTxlTSE+C3aXrN/6+tXyN97f+6p891ClVYfFIDQOO0dzriGsyqm4VllB5UL?=
 =?us-ascii?Q?O7sJSTbtdrtNHqqWIpdf2li5vnvAtA63XjhGL0L2Wfv+j87gS70Lj6HZkkno?=
 =?us-ascii?Q?y8vi+eHdOhWAX5mKplwMb2P5EGItcn2VyaaugfCCmOYQ5Tkbi68qZblxsaHH?=
 =?us-ascii?Q?QIAB/MvuDkvx7pcN+jq5ypk7GgUPP2ytsJXGI1tmKXzhKVkwT4AaNe60lA0g?=
 =?us-ascii?Q?tdhGyv9P2sASUbGCmqVpn2hMpBlsNyz1nLsaLAewdLid2uX0EKYs98r0LA9F?=
 =?us-ascii?Q?JpLG3ZApbXEJSaEn50HaGru2FMgAv8ZBT2U0lNPvvXobR8oLz4vIvx5WU662?=
 =?us-ascii?Q?hPAQClCGGaaujmaa+76FdsBtdxr1qSh4tL2e9KiQOwctMzGs2E3x8vqvay3Q?=
 =?us-ascii?Q?jJi3KG/jxPcC5hg9u8Gi4seYe5G8RCG4PJJqknePXj0fPmc0ClIBAOD7m7oW?=
 =?us-ascii?Q?ZO0sT7qXjWswzjGxRv+W8W7xAykWGoKei1OlJ5NL0WK4z0+jGvE6qNZk94T6?=
 =?us-ascii?Q?SQ2YKZzFOv8DtyjxF562v8jyLXy8Eh3gsYL+BxvoWnkwrPMuqacbkWaRE3qj?=
 =?us-ascii?Q?/+Dtj6Iut77FazSYwphKVYL12nQxZhpnGdPRAueh/q1TKOfJroItWr8K7tP1?=
 =?us-ascii?Q?BlQoTrkEVOHLM/ZWO5TzU5r6hMg0NlDHB8CbpLao8Q27egZ3bMa9F1z5Vja1?=
 =?us-ascii?Q?03cc/Bx4rUw0uJHNNmK8L5q12bvihB1TvlpdUWVYgBuek1wVCqCk0ogHW6o5?=
 =?us-ascii?Q?KYIw7EV709qrQGIPStsH53a2ji+ZPKGkJGxWFCyiBOIslqr+D+JzLgptI6w6?=
 =?us-ascii?Q?2KCaWLOpKaT/DPv/QoCiFmOJOCz5kb1Z8H391jX8KuTDzKlsic05F0blnyGn?=
 =?us-ascii?Q?dcVm55Q0L6indqC7O9Rafqjv1ob5MorEr2pcw3Gf3IAVMUJuMv/q2WYo6ETJ?=
 =?us-ascii?Q?a6jcGxj6i8AbavG2sxRpYjBhFDDnejg+L7kZ4s02k0uiC8Ahl7SwGqKTHBXt?=
 =?us-ascii?Q?S9b8noMgncjIOHHts4dcmwQ61u2JSYGFX21ASJgtOnmqsciixKDKgqEENkX/?=
 =?us-ascii?Q?DtWbrAQOjF+QwvoQNiVq7r5Or+Z8rWhZGjJDEd8RqKJ2eAqaHHnX3TCY5phG?=
 =?us-ascii?Q?PQKoN4VQ3oX8Rq6qPaU9AqlakwpgNcMYUpECW8d2JfVwZVf6bMGDlIsE/OSQ?=
 =?us-ascii?Q?O5xCCQ1Q+AD5x0DLuFI5H0nq3LWc8DRy+YJqcxFATREuiA5elBwcDyxfotFp?=
 =?us-ascii?Q?dr8fMmEz6a+R0k2M1+G//TFHLDoXydW1P4vjeDhaCgAdgR4TF5LWhQSDUw6d?=
 =?us-ascii?Q?3v4X4XcDf1QYh7HrlF3zffMHv2hINfWGbvo7iE8IQBWlsSbA4FIevC5MEQDI?=
 =?us-ascii?Q?gPlJkK3+uK98VtvZToijwP+AFVhtaO6RRFCQ3VDqXGs3g6zCgXK1WSk/vZGI?=
 =?us-ascii?Q?lpi2X8MZ3LPuCxHPVmJxf+GDulzYyJ8yzHuNK06cX5MzGoQnUH2bxZGUPo3T?=
 =?us-ascii?Q?Ht1qBdlvu7Z09Dk/WmxMxNFJYWZTHS3kjGcBbTdSPUZuzbhfAsYNmEz9vJNt?=
 =?us-ascii?Q?H1gVL087LgF55Uqnts56m38/qGjxne/IUmgyAccDcW2zTcjB0ApF59XlO/U9?=
 =?us-ascii?Q?X21pJ4GzyA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4be3201-34a0-4f4a-69c5-08dee809059d
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 15:50:58.2238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 407yu8juW9sgHJJ3w+lKSDK9l6NysqH8SaXqQIVxYAlG+YTDvkKClHQTSviNAY0IuWes4a/I/v7CjyNu9ft4VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P123MB7473

Currently, dynamic non-array fields such as 'cpumask_t' are mishandled in
'perf trace', causing the raw length and offset descriptors to be interpreted
and displayed as a literal integer (e.g., "cpumask: 524320" instead of the
actual mask data).

Correct the parsing of dynamic fields that do not have the
TEP_FIELD_IS_ARRAY flag set by introducing helper functions
format_field__get_raw_data() and format_field__get_cpumask().
Using these helpers, resolve the pointer to the raw bits within the
payload and format the cpumask as a zero-padded hexadecimal string by default.

Fixes: c5e006cdbd27 ("perf trace: Support tracepoint dynamic char arrays")
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-trace.c | 71 +++++++++++++++++++++++++----
 tools/perf/util/evsel.c    | 91 ++++++++++++++++++++++++++++++++++++++
 tools/perf/util/evsel.h    |  6 +++
 3 files changed, 159 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index ba0f8749fc7d..5808adad52ae 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3207,6 +3207,22 @@ static void bpf_output__fprintf(struct trace *trace,
 	++trace->nr_events_printed;
 }
 
+static unsigned char bitmap_byte(const unsigned long *mask, int byte_idx)
+{
+	unsigned char b_val = 0;
+	int bit_in_byte;
+
+	for (bit_in_byte = 0; bit_in_byte < 8; bit_in_byte++) {
+		int b_idx = byte_idx * 8 + bit_in_byte;
+		int host_w_idx = b_idx / BITS_PER_LONG;
+		int host_bit_in_word = b_idx % BITS_PER_LONG;
+
+		if (mask[host_w_idx] & (1UL << host_bit_in_word))
+			b_val |= (1 << bit_in_byte);
+	}
+	return b_val;
+}
+
 static size_t trace__fprintf_tp_fields(struct trace *trace, struct perf_sample *sample,
 				       struct thread *thread, void *augmented_args, int augmented_args_size)
 {
@@ -3238,17 +3254,54 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct perf_sample *
 		syscall_arg.len = 0;
 		syscall_arg.fmt = arg;
 		if (field->flags & TEP_FIELD_IS_ARRAY) {
-			int offset = field->offset;
-
-			if (field->flags & TEP_FIELD_IS_DYNAMIC) {
-				offset = format_field__intval(field, sample, evsel->needs_swap);
-				syscall_arg.len = offset >> 16;
-				offset &= 0xffff;
-				if (tep_field_is_relative(field->flags))
-					offset += field->offset + field->size;
+			void *ptr = format_field__get_raw_data(field, sample,
+							       evsel->needs_swap,
+							       &syscall_arg.len);
+
+			if (!ptr) {
+				pr_err("Problem processing %s field, skipping...\n", field->name);
+				continue;
+			}
+			val = (uintptr_t)ptr;
+		} else if ((field->flags & TEP_FIELD_IS_DYNAMIC) &&
+			   strstr(field->type, "cpumask")) {
+			unsigned long *mask = format_field__get_cpumask(field, sample,
+									evsel->needs_swap,
+									&syscall_arg.len);
+
+			if (!mask) {
+				pr_err("Problem processing %s field, skipping...\n", field->name);
+				continue;
 			}
 
-			val = (uintptr_t)(sample->raw_data + offset);
+			printed += scnprintf(bf + printed, size - printed, "%s", printed ? ", " : "");
+			if (trace->show_arg_names)
+				printed += scnprintf(bf + printed, size - printed, "%s: ", field->name);
+
+			if (syscall_arg.len == 0) {
+				printed += scnprintf(bf + printed, size - printed, "0");
+			} else {
+				int i;
+				bool skip_zero = true;
+
+				printed += scnprintf(bf + printed, size - printed, "0x");
+				/* Print bytes from most significant to least significant */
+				for (i = syscall_arg.len - 1; i >= 0; i--) {
+					unsigned char b_val = bitmap_byte(mask, i);
+
+					if (skip_zero && b_val == 0 && i > 0)
+						continue;
+
+					if (skip_zero) {
+						printed += scnprintf(bf + printed, size - printed, "%x", b_val);
+						skip_zero = false;
+					} else {
+						printed += scnprintf(bf + printed, size - printed, "%02x", b_val);
+					}
+				}
+			}
+			free(mask);
+			continue;
 		} else
 			val = format_field__intval(field, sample, evsel->needs_swap);
 		/*
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ea9fa04429f0..185673874aa0 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -16,9 +16,11 @@
 #include <errno.h>
 #include <inttypes.h>
 #include <stdlib.h>
+#include <string.h>
 
 #include <dirent.h>
 #include <linux/bitops.h>
+#include <linux/bitmap.h>
 #include <linux/compiler.h>
 #include <linux/ctype.h>
 #include <linux/err.h>
@@ -3933,6 +3935,95 @@ void *perf_sample__rawptr(struct perf_sample *sample, const char *name)
 	return sample->raw_data + offset;
 }
 
+void *format_field__get_raw_data(struct tep_format_field *field, struct
+				 perf_sample *sample, bool needs_swap,
+				 u16 *len_out)
+{
+	int offset = field->offset;
+	int size = field->size;
+
+	if (field->flags & TEP_FIELD_IS_DYNAMIC) {
+		unsigned int dynamic_data;
+
+		if (out_of_bounds(field, field->offset, field->size, sample->raw_size))
+			return NULL;
+
+		dynamic_data = format_field__intval(field, sample, needs_swap);
+
+		offset = dynamic_data & 0xffff;
+		size = (dynamic_data >> 16) & 0xffff;
+
+		if (tep_field_is_relative(field->flags))
+			offset += field->offset + field->size;
+	}
+
+	if (out_of_bounds(field, offset, size, sample->raw_size))
+		return NULL;
+
+	*len_out = size;
+	return sample->raw_data + offset;
+}
+
+unsigned long *format_field__get_cpumask(struct tep_format_field *field,
+					 struct perf_sample *sample,
+					 bool needs_swap, u16 *len_out)
+{
+	u16 len;
+	void *ptr = format_field__get_raw_data(field, sample, needs_swap, &len);
+	unsigned long *mask;
+	struct perf_env *env;
+	bool target_is_64;
+	int target_word_size;
+	int nr_words;
+	int bit_idx;
+	int nbits;
+
+	if (!ptr)
+		return NULL;
+
+	nbits = len * 8;
+	mask = bitmap_zalloc(nbits ?: 1);
+	if (!mask)
+		return NULL;
+
+	env = evsel__env(sample->evsel);
+	target_is_64 = env ? perf_env__kernel_is_64_bit(env) : (sizeof(void *) == 8);
+	target_word_size = target_is_64 ? 8 : 4;
+	nr_words = len / target_word_size;
+
+	for (bit_idx = 0; bit_idx < nbits; bit_idx++) {
+		int w_idx = bit_idx / (target_word_size * 8);
+		int bit_in_word = bit_idx % (target_word_size * 8);
+		bool set = false;
+
+		if (w_idx >= nr_words)
+			break;
+
+		if (target_is_64) {
+			u64 word;
+			memcpy(&word, (unsigned char *)ptr + w_idx * 8, 8);
+			if (needs_swap)
+				word = bswap_64(word);
+			set = (word & (1ULL << bit_in_word)) != 0;
+		} else {
+			u32 word32;
+			memcpy(&word32, (unsigned char *)ptr + w_idx * 4, 4);
+			if (needs_swap)
+				word32 = bswap_32(word32);
+			set = (word32 & (1U << bit_in_word)) != 0;
+		}
+
+		if (set) {
+			int host_w_idx = bit_idx / BITS_PER_LONG;
+			int host_bit_in_word = bit_idx % BITS_PER_LONG;
+			mask[host_w_idx] |= (1UL << host_bit_in_word);
+		}
+	}
+
+	*len_out = len;
+	return mask;
+}
+
 u64 format_field__intval(struct tep_format_field *field, struct perf_sample *sample,
 			 bool needs_swap)
 {
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 163fc2b6a7ea..02129a022ea3 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -400,6 +400,12 @@ static inline char *perf_sample__strval(struct perf_sample *sample, const char *
 
 struct tep_format_field;
 
+void *format_field__get_raw_data(struct tep_format_field *field,
+				 struct perf_sample *sample,
+				 bool needs_swap, u16 *len_out);
+unsigned long *format_field__get_cpumask(struct tep_format_field *field,
+					 struct perf_sample *sample,
+					 bool needs_swap, u16 *len_out);
 u64 format_field__intval(struct tep_format_field *field, struct perf_sample *sample, bool needs_swap);
 
 #ifdef HAVE_LIBTRACEEVENT
-- 
2.54.0

