Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020119.outbound.protection.outlook.com [52.101.195.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37662F7EF4;
	Fri, 17 Jul 2026 01:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784252154; cv=fail; b=IrSRRknkpBftVfeAvpsnt2LHHTqtxUsgKn4/3Nlkby+yE3ABZh5zdIWdNjUtm+qALfX91crAUn5hhBwp0uWVSUQ7hDI/cIHcul2Qxs0XHQ9tF1jNAxjjoitt7j2+Ys4VzHMcjf3xcot4BLbVZ7m2vk3qH1LPLhhim/AWR/63rBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784252154; c=relaxed/simple;
	bh=gsiIgEp2rBvTLh0UEuHqIEdabNLLn/STVcysza40774=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HI6eayKpa+prxpj8EIeeFo5stuSvm8VXfXAXJIZFs6ZYaueQTWEr5UsrlGM1uDhbS1JT9hIRmhpgiGs5CHVpmA8V2XS8dapF4mF1Uzc3Tcov+dOTa/5w5mmYmZTlXGZVBd5St/ZDuZsbrUuExQ0hZSMbN+eNM/inBmx5jg2C9vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mwTqkD+USib+9pWFQqKqOnFoG+wqwIbUz6qCp+zqhdpu6Av+zx++TO7dE95TIi8C6xDk0gY8o5HBTtIPvED9b/+EoeUSnQuvnK0DJlO72/NFYMDxzSH88GSfc/2lnjMUakvZHJFgQeNM5R2LJK/MkWkmxwrR5fk7YMPMA88EXtIP2crEMNOvSkPag1jaHS1iNS1zNhWSVmzxsXQGiGYtf6PB0UcXvBWfkXZ0LjBXxf26ooozta2jwMI1fsR8MpmaRMmJjylgsiIp+V0yPfw0VQ4Q8O5KENbt9O78r3RrHlciOfR8c91724U15fM7t8MBYgHNzV4P6t9N2RbhApkr7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=CRJz58LxmpPiPPA+bkNNJyXAKMEDJsHtgCVLGC1vqV4=;
 b=clfgZbROyUf/Va4DeprPSTMO8Qsie3dW2x73+DKVkM3optOir2kjP6MC7mtKQI8SgoWu4WuZDEPCligQ8mWHQP53pkbXYziWKcMo8x78X7b+gjGVrRl9mavPuHVJMh82NOmc/WjD5kNZxjMiISBnMJ95ToCCy1WQbg8R+r03sX76LVS2IjFM+6ts1iULhhcSThE0mi4K3iaRU7OeQoJDYv6R5baOUPWoWzNOuQer3ARUnJJ9NmkxOmpDxmXBS4z/xan/VwiL4YqnRzW7hoPHY0j787lmUQyxK/677xJVwfOZwJqJ8FAnxh3dtCcbs1gaMoxpfw/E/2ajGVaPpfADvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB4204.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:159::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 01:35:48 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 01:35:48 +0000
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
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] perf trace: Add --bitmask-list option and correct cpumask formatting
Date: Thu, 16 Jul 2026 21:35:44 -0400
Message-ID: <20260717013544.257768-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0936.namprd03.prod.outlook.com
 (2603:10b6:408:108::11) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB4204:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fb6b0fb-d2cc-4b3c-ec84-08dee3a3baa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|7416014|10067099003|56012099006|6133799003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info:
	BYgyMpoaoFJk2dsXObgnTwlq+c4DmN6PHc1/fA1H5/vDZtm3g5UZ2v86lAFYmkVJRkNwtEXXLPe2ZlnKCSgT41pbC/mvqsOrucWkYnzIx/X9IvfYm5Bh9x+GnSbEJRF9iiutznZyzm9RBR03f0BQOJ0RN9lOEcxJdE0Wj/6/LOCKP9CWBf6rC6nSjuD4klvPdY8REV09LkOAw3dCrOEJ6F0fYLP0fXkVxuTL6lRmODikIpj4TRcUz8FDjN4h3OcpvSVexo6rau2IAZchZaDUQhPSnkTGXueWUY6TarUleggW7pLg9xwANIGfi99Rh9mrLAvXrFH5105mgDxWu6iQX3k6oqtB9pHdiFSgYubzqEIITmk5XSRWjsoFTE9+bdmM7bhr+YFQq/toFvJxUE1YM7eRnXoD4F1UvS9vD8FiR1CSrsqWLW7IBUxQsosqdLK11yqwJ8ju3UAXr/5PgbJ0aTqIg/bsr9EP7IV3kj8OSdAGZdM/z3MUweMwl9lttxIpylQuoXdo4jgsrHrg7M4fKnq9LY53ztyO3wAvd7gcv5RMweCBhJLFnpsMayRG4HU5fJNYJm9sSL40XJzHTgB4ueMU+X/1PovakLcMk/LkzNd7v0J6IG8vRvTb8plgVsfLRG4LKxr9mJYjUL8iE4iYMqnKSTKpPeDycKunmvT8QpE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(7416014)(10067099003)(56012099006)(6133799003)(3023799007)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UJB5i+Sy+25u2SSGmkp4K6qk339j/Kxz6YJV1uTuwvhrlwuYX6JqqycQXlPX?=
 =?us-ascii?Q?wy0ZUtO10Rwtp/tNhKwHZsHf8xnvFoL/ID9FW6T5dDpTD2Fb1MUtcGuyJFx8?=
 =?us-ascii?Q?tJxm+TDTa1e6jPefEZOTslv5LOqo+42yWh+VDmlMvY++a+j55oUe2w9oDemV?=
 =?us-ascii?Q?mY6VasAhJqfXU6RCnmJ2wE00Ttdi2n0YguDqeQfra/fiPiyKrWMW8Q1HJwI4?=
 =?us-ascii?Q?ZjowuVLCZlUVRLYGmiz9AR5Q6xnSlXEemJLmhVqGgSiR5OmkYWBac7YDiM6v?=
 =?us-ascii?Q?yXVLSguCks2HcHGEJeIpv8JDYNQX5gntTUBIalMagqb3dDUuFdiZyV+tCBox?=
 =?us-ascii?Q?TUA8CnQypqFT0GHvmICqW8FIUxj1TvDkV0RWtTdFiukzrVJFXKnQ4nfQcLiV?=
 =?us-ascii?Q?5zXMt4ADQ29TaTlXCZYNgHTEikir/OIYEreYTtHlYQcUGMztfsLap48FMiO4?=
 =?us-ascii?Q?5wTatOs4vAKyvMN2htZrR6EnYb5E60HxKxi2RM8N6c4rm0+Hh7yhZuheNHj7?=
 =?us-ascii?Q?ZmMaDdUyRvkEGxglfpFuhVQf20d1RgYrFC5KtYh8AvxOVG5WU7X5X0Gws4av?=
 =?us-ascii?Q?/EsJcvlhw8ZVtZM+8l6xq4TKVTGSuDvwu6kxpCraqvqF6FxIuGoAPgb5G61O?=
 =?us-ascii?Q?NcfLajwPtyCmUbi54tZRioRq6x9EaPUY3+kiSUWUnnLFn58utdGdaGOVngFq?=
 =?us-ascii?Q?P2CzGt+OBEIwMWEv5gVaKivD7NXcmdYzgJnxZ1FwUC/Yk7aY3NlyvDEkIccu?=
 =?us-ascii?Q?ttKR7H2G74YGJy0vpih5evaQZok+TwayEBaUNaQcnFgmBSX1rVf0N0C4n7P9?=
 =?us-ascii?Q?cz3AT9Tif0+f26wNGRUUxhJFaWAFOTuTFYCPOfoc/IPGGUx4Xr5O5eJLuqhS?=
 =?us-ascii?Q?DrecxMR1QXXYZ4SsV3pOTgyBv6UP9CCRv3mJrnKeWQd6NcSyxCjLuCjdH4cP?=
 =?us-ascii?Q?+/tYuCqdnLAzCXkC9EFNQcoqiSjHaVPt/c0f368cjCOgnpuyYGBMMA59ninS?=
 =?us-ascii?Q?0ddSUIQrdIP3dCnVSLBfSoI1jTqvZZXtfEWy56f6nuLxnihwL6CcWaH9Dk8a?=
 =?us-ascii?Q?Nt4tn0e21fjOyz3dWPGRdEndlwqFAIpNHADfsgI6iACtz4vtHPBoOvyOflnP?=
 =?us-ascii?Q?T5HWyAOXWJuQ7BDuKoxyFP1He9s3Bnim8okjgp8Sl+iqN4SqyOnpGXG/pqsp?=
 =?us-ascii?Q?0jZeKyYU2gXZvKuK9koNwHKdzRt5W2ywXBRexI6SMstFvE/lALXXNJWsdl8V?=
 =?us-ascii?Q?FBg/ZFPmmYmBl9wiBB9GLsoNO35YUaJKvKbBql3pn1zhO2IWhvtFyZfcb+P6?=
 =?us-ascii?Q?ACM9bck9iGf+IM+tx/Ci6diLn2m/Gfe9hYaZobCb2h4MrkOZywrVTtNP6+0T?=
 =?us-ascii?Q?cIwqX4cxs1ENI6icqhfKpykDzvBTUgHJTorU9/b7Eq3YDLRG0dFHG8XgF+X4?=
 =?us-ascii?Q?VKRzoBtVbVnSsupg/JlCOWj3Z4VnTCcuv9lTJAazicYxqeLjT8GrUCGgEkQ5?=
 =?us-ascii?Q?uexH+x23Ma+V/fYKm4/R3zNlhC3hvlHRdUK2HR5tqV4PltFEyVnDs0LnaTrc?=
 =?us-ascii?Q?Z4OpfhNvBEqz1bJfnbBm+OgtyuCC6xXR8LO73Wzy87rpa1KNx++yT0b9oWsi?=
 =?us-ascii?Q?GZYQOoX3ufNCd4j2GSJPjwKatrtRa99XMpdV/Scie6puVfljT15n4sQzr5Nr?=
 =?us-ascii?Q?2x4USrMeF1+dnsyW3INf7dY0tQZnmGP9W6VxbcmLbJqp8pRycHiPx6U+D3bu?=
 =?us-ascii?Q?f0tNhpBDdg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb6b0fb-d2cc-4b3c-ec84-08dee3a3baa6
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 01:35:48.6298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e6YWCaH1N9b60r3tz5GYeHgyYV0Oycfv0dfqhZ0YByq4a045zKwB46gqsxAjsbFc++xfyzVKHtPqeHvRHYafqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB4204

Currently, dynamic non-array fields such as 'cpumask_t' are mishandled
in 'perf trace', causing the raw length and offset descriptors to be
interpreted and displayed as a literal integer (e.g., 'cpumask: 524320'
instead of the actual mask data).

This patch corrects the parsing of dynamic fields that do not have the
TEP_FIELD_IS_ARRAY flag set. By doing so, it ensures the pointer to the
raw bits is properly resolved within the payload.

Furthermore, it improves the display formatting for 'cpumask' types:
    - By default, the cpumask is now correctly output as a zero-suppressed
      hexadecimal string, resolving the aforementioned integer display
      anomaly

    - A new '--bitmask-list' command-line option has been introduced.
      When specified, this delegates formatting to 'bitmap_scnprintf()',
      enabling the cpumask to be rendered as a condensed, human-readable
      list (e.g., '0,2-5,7')

Fixes: c5e006cdbd27 ("perf trace: Support tracepoint dynamic char arrays")
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
Changes since v1:

 - Refactored cpumask parsing by moving the dynamic bitmask
   reconstruction logic into a new helper function,
   format_field__get_cpumask()

 - Made bitmask parsing cross-platform, word-size, and endianness-safe

 - Added a new helper function, bitmap_byte() to extract bytes from the
   host-native bitmask in a host-endianness-independent manner,
   simplifying hexadecimal cpumask formatting

 - Cleaned up trace__fprintf_tp_fields() to remove complex inline
   parsing logic

 - Linked to v1: https://lore.kernel.org/lkml/20260714162947.214270-1-atomlin@atomlin.com/
---
 tools/perf/builtin-trace.c | 75 +++++++++++++++++++++++++++----
 tools/perf/util/evsel.c    | 90 ++++++++++++++++++++++++++++++++++++++
 tools/perf/util/evsel.h    |  6 +++
 3 files changed, 162 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index ba0f8749fc7d..0142a16830de 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -226,6 +226,7 @@ struct trace {
 	bool			force;
 	bool			vfs_getname;
 	bool			force_btf;
+	bool			bitmask_list;
 	bool			summary_bpf;
 	int			trace_pgfaults;
 	char			*perfconfig_events;
@@ -3207,6 +3208,21 @@ static void bpf_output__fprintf(struct trace *trace,
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
+		if (mask[host_w_idx] & (1UL << host_bit_in_word))
+			b_val |= (1 << bit_in_byte);
+	}
+	return b_val;
+}
+
 static size_t trace__fprintf_tp_fields(struct trace *trace, struct perf_sample *sample,
 				       struct thread *thread, void *augmented_args, int augmented_args_size)
 {
@@ -3238,17 +3254,57 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct perf_sample *
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
+			} else if (trace->bitmask_list) {
+				printed += bitmap_scnprintf(mask, syscall_arg.len * 8,
+							    bf + printed, size - printed);
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
@@ -5537,6 +5593,7 @@ int cmd_trace(int argc, const char **argv)
 		     "start"),
 	OPT_BOOLEAN(0, "force-btf", &trace.force_btf, "Prefer btf_dump general pretty printer"
 		       "to customized ones"),
+	OPT_BOOLEAN(0, "bitmask-list", &trace.bitmask_list, "Show bitmask as a human-readable list"),
 	OPT_BOOLEAN(0, "bpf-summary", &trace.summary_bpf, "Summary syscall stats in BPF"),
 	OPT_INTEGER(0, "max-summary", &trace.max_summary,
 		     "Max number of entries in the summary."),
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ea9fa04429f0..912d77044141 100644
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
@@ -3933,6 +3935,94 @@ void *perf_sample__rawptr(struct perf_sample *sample, const char *name)
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
+		if (w_idx < nr_words) {
+			if (target_is_64) {
+				u64 word;
+				memcpy(&word, (unsigned char *)ptr + w_idx * 8, 8);
+				if (needs_swap)
+					word = bswap_64(word);
+				set = (word & (1ULL << bit_in_word)) != 0;
+			} else {
+				u32 word32;
+				memcpy(&word32, (unsigned char *)ptr + w_idx * 4, 4);
+				if (needs_swap)
+					word32 = bswap_32(word32);
+				set = (word32 & (1U << bit_in_word)) != 0;
+			}
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

