Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022130.outbound.protection.outlook.com [52.101.96.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF311A0B0E;
	Sun, 19 Jul 2026 00:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784420122; cv=fail; b=GyirPohISEJW3bF5Pd4Y2gGEqkkdW6HCXRmX7p1PC7pnfr84U2PE08sPhsRutzw44412sHiEPhyWGPG8iwX7yAttMkZaLzBEOOyYEUflajQKVptgGlgE5sG7zCe8ZzWI86se3U16iktX7y5eHfCTq5AVi8kKAVRKS4znCurhSHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784420122; c=relaxed/simple;
	bh=5KFb6FnZod5P6i1qbhY+RCu3Nin/qq53f68Edvmnrvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jzD+cYIAk/ERYZq1pP9RulAZoR8TeBvEwsswh3RltMRn73ooICw8ofxAogvHq4qQx06SjXvnxpZI8gIKnVgQE89YSppERUhGFoRdtQfAoYY2lcnUqHHbjSjSJn2Vz1fMtyaI+TfIXioTdlc9BeQsj5tmMwOFOnAAF7VoQ13MVm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P5aCcVB0fbdtFJqttZYY0iREdvKIAtKgDzXKwu1zSBWA60JObqnHOT5e5PTadMlHjv9AGbnDCl7QlBl1JyZV/VfGzmVYhLVmAHzOrilrYQXxUm7KfX48ZGgsamVKd8j/pnTQ4u5FwOt+wx/EtknKPUbDexG8njqt35KBhEpYGnxrULhHNj0yIncZZiLxblAVerlxw8Vo7w5rS+qAClOjBYTxniC5fxNWCuYtoUHQP2ZH/7Id8Rzqp31/li4lIBB6hOqnVGeofT+5JQW/jTQxK6vmtw0x7dzlaiZTZb1AvjWyWDfyIfkGTNktoDAnhrruJz/wGb4zk/dVMG2uUy5vBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=Z4KyPHZycT0Lz7JqDTInz7UzSysMQ6TkWgmFz7M9Zks=;
 b=TfMB++p4dKU2rQvccgPBcRSTGCCD4Vic7EPRQeS5RGC2pYotS+IqZstrutmeX0vow5qDz4RDdXX2vglvGVN/dhLOhtYiV30nvxfIa2CZNKCLyOo8yZYhCmoJM6HweeY9u+dOPHzuiPrO0RRzXOTLRWm5ufhuwUugV95QTFPPdczjJajxa/HJVx3O2qC7nq0ITuulb4KxzN8NyxyWYFqP2t1hzA1/oedmwvNQYAXaKz+vnVloNfyVkr+WUAGULg3xFWcHceyIfypGfyuTLd4lmQ+zbtqilMQp91d4cMx297XaNhs3qMpEYCO9o76e2GRzZGdUGo434g1tTruXunuCaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO6P123MB6616.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2b2::11)
 by LO4P123MB6514.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:27c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.15; Sun, 19 Jul
 2026 00:15:17 +0000
Received: from LO6P123MB6616.GBRP123.PROD.OUTLOOK.COM
 ([fe80::3975:c5e7:bc1a:f383]) by LO6P123MB6616.GBRP123.PROD.OUTLOOK.COM
 ([fe80::3975:c5e7:bc1a:f383%4]) with mapi id 15.21.0223.013; Sun, 19 Jul 2026
 00:15:17 +0000
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
Subject: [PATCH v3 1/2] perf trace: Correct default cpumask formatting to hexadecimal
Date: Sat, 18 Jul 2026 20:15:09 -0400
Message-ID: <20260719001510.398616-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260719001510.398616-1-atomlin@atomlin.com>
References: <20260719001510.398616-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0190.namprd03.prod.outlook.com
 (2603:10b6:408:f9::15) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO6P123MB6616:EE_|LO4P123MB6514:EE_
X-MS-Office365-Filtering-Correlation-Id: 73cb3096-ae8d-4ef0-b925-08dee52ad01e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|22082099003|18002099003|10067099003|56012099006|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info:
	A50oX1WAZSzc3kyjZKktiVm+jAjSDlwsnbUyRRHRzgOqMnmXjeq2r1GrXzlhdIVPVcQAOLv80iKfWgyrDAKr8wOEg/NDw+Qh/A49PnLYigzXCni6TftXG0VSk+2UmXUwp2EU95LwYsKyDKPe3SSTUTGseWlnVZ8Cil7S21zP6C4/DcH6SJF+9mV67FZAnOPCanI+NGvSaIQT+iq8PVs3jgMICrkXKAKZQuDHV+KHmSqY4ucHoZ0+heQ/9WYFBQaim/hkPEmEmzu4Jw37bbVliQKwOXs6f8Mkh2K0aH1Lppbdx1/X0MTJY7flH49a8M1nQL9gR/5WGLf0z9qBKNItpzg+oXjlKigywxbGfh2mtyk9XZFZLjS5h7newKHrMBaS8By/N6b9tLhes5WaH7y6aTSlLIXc80L6SXlYjkQWLezeK23HCW7WJB5AxSO6FpoWXBKUsmaRxskXnASRrsqnDaY6WrKojUnqW47WjG6hFeiv4kEryH4zfkaroQPRE2wh1K43a2kLGf2u3jNnWKD4/u+RRMdTS93wAJh5YjS+NRz4q2Mbk6v1VWhymOI/OJVNRGaADZOpLKMQoct3gsxHQk/Uov/8jECy5vRlbbvwsrtAzqze/PxkflKQKwa1tdGmYhNBbSz27aPafAddz1AvrP/5SwhY2tk0/AECp66/pGA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO6P123MB6616.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(22082099003)(18002099003)(10067099003)(56012099006)(3023799007)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ETkDbKKhiM3E+RuO83fzLTHSYi6QWHz1h434HaCdpRnYBWh+h0kwrU7/rS0w?=
 =?us-ascii?Q?26jeTLCxQVZiexkb+mCt65SIjl/9pyo4YzgDnM1HUCiXixrUIKXghAY3wPRD?=
 =?us-ascii?Q?vWBfLwgt/UAYK4hlq6l3vtxYFhu+uKk6aIdsgpNujTbxDMoDDwnXvP9BHvrL?=
 =?us-ascii?Q?BSIliWGZYlhvAD2W/ILrR2HuWsHC9RnZ658XZk4ravFQjTovsxsiB3WeBHR/?=
 =?us-ascii?Q?0Evg0na9ltLGE0HfarM67hl7zoQ3D4ESufCdZYj98Y7bPIWVsrIGySqcVwV/?=
 =?us-ascii?Q?JJd6WlKapbifzHLWuTZVuj5IkY3YQemkbUTEfLc4GbbqXFWjxvsKa3YDrLt6?=
 =?us-ascii?Q?ZQ58ysDaRcc97qm305eHazr+lUYC/ZlNheduA8pYG2RJ5WzJFp1DihJ9Gfgb?=
 =?us-ascii?Q?fKYTbET/N2EwN3mkwRAmLxgkGIemhp+ilBWOtk6IvGlmbv764HoFeQFWadYK?=
 =?us-ascii?Q?XB6wwJHhEInWBz5Qtucu5QSvUCuIGP4mw1c+C2CS1a+eO896D6I/kDiZCNWA?=
 =?us-ascii?Q?KZq9XXIyaag/iULqc00SaWSXZaGH5hAO8dl3yqaBDF9r+p/PNuG5Z3QWoDN+?=
 =?us-ascii?Q?GQr+CyCiG+Q0AQt7tJMwyDM3lUrhm0/nd3LI9n62MVJp2fbNtqv70Px/TvaC?=
 =?us-ascii?Q?TjxJsLyUuGDA3gA9NFpbL0xFq50BmjL7q3s3x6ysXvd/upM1zVR+ZSuSOKiQ?=
 =?us-ascii?Q?ERuC5znXbvgt5ASda0ytRlkM5khlnrhjRNqZDIlz3AbE+y5Bi+HDsiWe6KLp?=
 =?us-ascii?Q?13EOmtInznfPIRp3eqJwdA5WmQEVqveKfCtHX2EKzeIjtwDf+Dhc/KPUPliy?=
 =?us-ascii?Q?RUtoJLNnuJMSGf+Nrb1DXoxXg6tjga8kOpV28LHdQni037LnFMHc/ifCK4fT?=
 =?us-ascii?Q?h/hq6+9KUa6ssH4lL7yeuwLA3vBOHTFdtvqhWfrJe53jjfvWBIUFMCivQFSY?=
 =?us-ascii?Q?CKj7onC07KmUFtfNcEiMbdTkY6lB4r77yY9pt1qURYVgJaTjER4rZD/NZd/y?=
 =?us-ascii?Q?H4/8Rsek15UIQT/gSfUcr1sB4C6CKNqdgKIfpAnctwlBQcnetXFskaXbjeIX?=
 =?us-ascii?Q?W521oR40pefR/0D/zTzy9rqtu3FCFJUm5KajZ3xKOAuR6YN0tmJ+ce+HWui8?=
 =?us-ascii?Q?TS5gzNkuX8HaoIBcfwuF3NCBVzprXwbh4XZymKamesKNNOh9IRVSMfMeXxQH?=
 =?us-ascii?Q?4k4hpUN5lHfuf26dMX25ADGCDQzgEwp43ayS1eypOByaqgO1rtxdfPbpcGiJ?=
 =?us-ascii?Q?NmXboN/6poPnENVo5PhmOyS7G8a1gxlpNbCqGpSJBjHTcSmEpRpm9a4rPd0u?=
 =?us-ascii?Q?OHKM8guwm/2oQ+ncttFNS6Jrfe75cxmT9Q9k9kZwJna00wZHwuQqozzsZ6ww?=
 =?us-ascii?Q?Si5uQeIePHeSr5rCMLDfNVJ1TRf7vrTv/4OSKkLVeYaugArY9iKZrG3ac7Wu?=
 =?us-ascii?Q?n53Zy4u/HqGsSMVxq+54cYx7VwWkEldm8iqgnJnJnXFGk1GoKAly+YDymhMy?=
 =?us-ascii?Q?lypfQY9H/tjrGx1KlfZk9gmq6KtHVdflApD6VxPMu9nbw4VMD9CotoLyG9TT?=
 =?us-ascii?Q?XEGjyA5dRPXEYLzLgwnBGmB3g6IquKEd0FrkYysQTlFbYpe0JCfhQWtGK1pR?=
 =?us-ascii?Q?j48iU7XHWGezJBtE1l5L8dmzdsmJLWwtLQZ/hwDolEIVFsGf+WQIJDgG6Pv6?=
 =?us-ascii?Q?VqDQjNXlW2d2W1KgpStkgwyf8ZC5WTNn+0eWQEC9CZt0eRDw3/NAs0JHAJvo?=
 =?us-ascii?Q?QyebZzobmQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73cb3096-ae8d-4ef0-b925-08dee52ad01e
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2026 00:15:17.8426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LQ7TjUml7ZK95p1ypxG71cV9j/pT0A4CqrUak9C19AdD5Em3AvOoQ0fkUq5nHbamepJNgpun9KVowuUB4hT7zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6514

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
 tools/perf/builtin-trace.c | 70 +++++++++++++++++++++++++----
 tools/perf/util/evsel.c    | 90 ++++++++++++++++++++++++++++++++++++++
 tools/perf/util/evsel.h    |  6 +++
 3 files changed, 157 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index ba0f8749fc7d..f8b8431f9543 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3207,6 +3207,21 @@ static void bpf_output__fprintf(struct trace *trace,
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
@@ -3238,17 +3253,54 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct perf_sample *
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

