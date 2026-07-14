Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021096.outbound.protection.outlook.com [52.101.95.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6839445AED;
	Tue, 14 Jul 2026 16:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784046598; cv=fail; b=HqiJI7e2Og2nY5eD+8zFWuwLceqNiu93E0ZuqW+gtR7aTsVs0FH4huT+jd5LW+uKrfVhXG3HvjRvnW8NDEcGsVD0cEkYff1wFvEBoCvj4DSsdU0GXMtze4ecodaApGY9dAfVxm8YKgHLkTy0iN/lDQqNV/DV3Y7rJPYxFN/7NOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784046598; c=relaxed/simple;
	bh=3t8KAmrDotn79UJeqJX9QWLS1XRXIHdoCyRqxhRSRA0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OaI3rUh3gb1M9gmHLB3nx85QsPw1gHgsqbGT4PJUjJ9KCdw4Qrl4wpAmjZkdXq0or9fJPH32sszmsKPSJISRhSCCXEr+Q7vQAhL+EjbIML26gO/ru2XNufaTfcjqa9ZXweR5Qv5Al43T29CyqKBxmjTlVYLv3lRkbJFArUZw3a4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHmf/RYX/quT+80WhwHCbBNdPraXvHx5pMw+FFR82VVqNfChO/RYgryALX5mxXyMFrKdQDGtDXlLptpWeh7KSAgL6QIXxc2oky4R6T1jmp/F7LYdGJb8B1/5bJYsO9bTDQ48wcgXTajCWRaY3h7AmNhsW0V9eytL46sVovDbwW6QIBWGzHyf1i3qJRZy12WDuj42cdJ+G658NGCKVI0d7rax9P0xvELjwL/1llKC4QmnNrNziOE69VCQcx5ZN1iTg+HSHZvVNooIr6dElO/DbQUSwdVsUIAtLfWcbJkaWnhyF+At4xmTi0RBL2AxcxBRmDbMWDT/e45Pl/CeYmbyVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=TwJmVrWp5y3ymnIvqjxHcZHrJBBORhtseGTMBFQiRpQ=;
 b=QtUtAQ8ofICoQsO2Z4D4Pjj47q7cGTq9zLIhSWY91zcuIuoYhXCfSBBOstvNf3vx+kIDifmeUF0/eiORxG/zXRrB5BFRPsmwAgU17NrTITy48sM9cO+qAF+FCOYBiLeX3vPGPmavBh4DWxBkHfBhljv7KKaUA5w/k+m7WM1XVMheGEOzmHCdun3q3ESw43C0PdEi8v2KqvfImfv9PgriBLX18+nT80tps/R/s5W37ovEqa1Grev++jjfUOhOdRnJf3BmefRGSyLy85H+RkxCMn7RJIKztGo9ePxqtI+1NKluL5mMMvfZKXpoxy0A7OoBh3zsyjpv2dYvhBgFrIoMpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWXP123MB4198.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:b5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.18; Tue, 14 Jul
 2026 16:29:51 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 16:29:51 +0000
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
	sean@ashe.io,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf trace: Add --bitmask-list option and correct cpumask formatting
Date: Tue, 14 Jul 2026 12:29:47 -0400
Message-ID: <20260714162947.214270-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0346.namprd03.prod.outlook.com
 (2603:10b6:408:f6::21) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWXP123MB4198:EE_
X-MS-Office365-Filtering-Correlation-Id: 269d1fe7-b91f-45a1-fc33-08dee1c520ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|6133799003|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	jJl3II1zn0kKIfznI2e5b/4o03IT1T5zurkovIeSMwM79PeGtvLig1C97nGoLD+LYtcHGo4iPuOJe7Dqm400wQ1y0lHkCA3Ucso3OeYbcddYk6P08Bia02rhqOsK4jqz40x2sJx7ycFfJSYK1AHtGnKv7yo0LPt+mXkuXHA1vQyqRlN1jq2Bkv0CYYVPmxVUJBFMTj27bv4+ljjuNhaMalOBaGqDZxgPyEbuEaYcvWJE3BL+rKUFfz4If3sXpXjnbuNbtuNBCV6HBBWmXjU/thfO3J3nhKqxNIHFZDvbkkDZrv0ZLd2CM7U2fZgNshvWUUZlLYKmNM716B79wd7vMMsY1P7VefQAvnHou8AM3kzWLSogHdRVdEjHPqt4qAK48ItEff4KMgk4LRUYkk28o7wRiuyZsPLUiBc1GaVP3vn3dQtebmnU+w4KuMUHiszc3voFDyaxAyA9GXMYMc+sodsztCqHBqyYKpNml9mzvNa0RayzuFrzEPFEhR9PLaoSeNN7ZIWpBFvtodKFk3xxyCMZo1RyRy7t6xkpCyidtOalle1sCrhD7IfeLzEvOzyUPOjSLfno4HYbuWU360hrBiRZhMCyubUW4253btkUYoA8IHye/32u4/uIdMuvy0G4vydvMbr97gp2+Vzfr1gaEtqPN6yvWoyOmuk9iF8WyAg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(6133799003)(56012099006)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0wBA0S/KVvNe1A2VPcHQqKvCaB7bSkYGRQtYdn4IDhojAIVy9VvCgXSjsbMF?=
 =?us-ascii?Q?ekZyP3roFlZAanJKnAijJ4GIIFyuPWHZlkFQldnbAoGaz7Nh3ydL6w1fpXHB?=
 =?us-ascii?Q?dJJbaLele+BVU7CJdU44N0Hlht6F9Ct1dsNY6rAGsYI16BpQwtT/gRXamG4f?=
 =?us-ascii?Q?65pKLAnYjUpVR+dEkFcJdCnxGkxKW4eNbg4rL8QqoLYB0BQBNUKuq+KxXd0D?=
 =?us-ascii?Q?riVLbhH8RHi4EIeeoclchiXwlFY1uJhWiRonE8YezPzhMpVa5tBJ6eudMJDC?=
 =?us-ascii?Q?3MGPCh7GmFQJLv3S4ZwBv9TyuOrpn0vfSoIiMZfz01XVq9EGTOqjVxri7wI4?=
 =?us-ascii?Q?TeK7smYkdxKVrSryYQN8q53gaS5Ko0m0XQ8Jn7941e2zpg/BJ1EIwuI/bYwr?=
 =?us-ascii?Q?tx9xxm+G4ls5zwAFAEsQX4thi+QiW6icVXXWkYvHXRDXvGffDU05Pn5DPO7Y?=
 =?us-ascii?Q?L0Iw2EIMPdESLi9uN5sp07Am/VE16lK6L+dj0XPcclGN8P7Po16SewAbhAjN?=
 =?us-ascii?Q?DHkrsgwdjjM8epGSNlpD5wSipCljtgLrnB1k15RQFn0eSfR491d969Vd7y+K?=
 =?us-ascii?Q?7jYnfMVI+eKg2TzVXKb8+GETBk0ettM+DpAT16t2PClZ6oNYu8Ksq/DRMZoG?=
 =?us-ascii?Q?LOCihPfqNlFPBkFGxpetNX7o5pull9RjmXRAKCNYOXJdB0AD8PCATc9Quz9g?=
 =?us-ascii?Q?EG9qvZ+bjhKq+GQPrG3y1v1iwrVhPLFHe9NGm2fT2MgyYRdxsDPq6A/8RmLY?=
 =?us-ascii?Q?zDUtw6bdlnO8kEaDjr2oc2Q78UBvpE68uxIJ+uTJt0h7af/sJmUQginYRU8B?=
 =?us-ascii?Q?mkcA75O/8hZZNyUYbI0LjrrI7SrO5vzGnRvmYRIGlest0vQX8oQ4J8c9/8H1?=
 =?us-ascii?Q?+hZW0TotfeVaJd7/Hadf05pckIJ8gV9IwWSUMBZCWM03K6nkD5gwolxFuZ3m?=
 =?us-ascii?Q?/wJPWQz0jDO0HNOzqUL6iZuXwn0qRKbJATYDpEoIOazihtvyz3UI2gLf5uSz?=
 =?us-ascii?Q?5Xv+XobyLnJP7kzMdtqEWpfhYBJg/VsvheESPM5IXpJhmAe49IwJpa9xrDbp?=
 =?us-ascii?Q?FQwtEGCOKjgS8u70MOpyYMbJbRj+1Eh6QDcGlwIakyJqnPXKosSfI07Qrmay?=
 =?us-ascii?Q?pNztoq7eDtt9dRO+eLpBhcDPxZEN30oge5v6aaREM0QXUbHUCWc1wPx9oDDc?=
 =?us-ascii?Q?M9E6LgL3Z/FtS3hNDvTF2J0xvTB32FS+Fi8qSil6YMrDfbI07ui6qvYaP2MG?=
 =?us-ascii?Q?gIYC4WouapK4bdNhSUyJjbBWFsp8hkdRCA3ibif7gZwN8QyipZUcJGCVfnSX?=
 =?us-ascii?Q?CIxNhiHwjiRkWQ9ruIrH/5XlolO6+tmuFfbR9SM85VjlfqShPThUzxpPrPvK?=
 =?us-ascii?Q?rSK6JVZdFa2PSHHQt4KFmDK9DNh5BqSW6USjzuTQ57LxTp4NzGAuGMjG5/kn?=
 =?us-ascii?Q?AbXH3yn9/eOoG8aWn1MbCA6klJG/b4x44Bl6tzWy+IVtRHiLNIXhU0sSUN9k?=
 =?us-ascii?Q?R6L2K4t4/z/FTG28pbLtSFEoLexLB51szgoGctIHximnB9a8erxarRs8ftSS?=
 =?us-ascii?Q?emNvpVT8jKhy+7WZpQFT/MjL9BMzSHjLgI0kNQeC2QClu0ZpsnTVEf4rbQku?=
 =?us-ascii?Q?wVpmv5QSZEQc2debwGhowkiQKyCzIkFXkKPLzhBPnrx5fQdM0RO/6FGOwO5i?=
 =?us-ascii?Q?AR0a5RMwd42ayKDOHEflsJYO6x1gTMkhS6CoZxziJUc8iB0kj+eIv5eLU69b?=
 =?us-ascii?Q?I3EPYJ8z8Q=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 269d1fe7-b91f-45a1-fc33-08dee1c520ed
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 16:29:51.3000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q27d4bsGgKL05WECsrHfQRbqoxumW7NyD5CecR2eI2TKd4eVQaZkZU//eZxeAa+siPJx0ZC2J2m0Tl43w1/wkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB4198

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
 tools/perf/builtin-trace.c | 70 ++++++++++++++++++++++++++++++++------
 tools/perf/util/evsel.c    | 29 ++++++++++++++++
 tools/perf/util/evsel.h    |  3 ++
 3 files changed, 92 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index ba0f8749fc7d..cd75ac4e5169 100644
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
@@ -3216,7 +3217,7 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct perf_sample *
 	const struct tep_event *tp_format = evsel__tp_format(evsel);
 	struct tep_format_field *field = tp_format ? tp_format->format.fields : NULL;
 	struct syscall_arg_fmt *arg = __evsel__syscall_arg_fmt(evsel);
-	size_t printed = 0, btf_printed;
+	size_t printed = 0, btf_printed, saved_printed;
 	unsigned long val;
 	u8 bit = 1;
 	struct syscall_arg syscall_arg = {
@@ -3238,17 +3239,65 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct perf_sample *
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
+			void *ptr = format_field__get_raw_data(field, sample,
+							       evsel->needs_swap,
+							       &syscall_arg.len);
+
+			if (!ptr) {
+				pr_err("Problem processing %s field, skipping...\n", field->name);
+				continue;
 			}
+			val = (uintptr_t)ptr;
 
-			val = (uintptr_t)(sample->raw_data + offset);
+			saved_printed = printed;
+
+			printed += scnprintf(bf + printed, size - printed, "%s", printed ? ", " : "");
+			if (trace->show_arg_names)
+				printed += scnprintf(bf + printed, size - printed, "%s: ", field->name);
+
+			if (trace->bitmask_list) {
+				if (syscall_arg.len > 0) {
+					unsigned long *mask = zalloc(BITS_TO_LONGS(syscall_arg.len * 8) * sizeof(unsigned long));
+					if (!mask) {
+						pr_err("Problem processing %s field, skipping...\n", field->name);
+						printed = saved_printed;
+						continue;
+					}
+					memcpy(mask, (void *)val, syscall_arg.len);
+					printed += bitmap_scnprintf(mask, syscall_arg.len * 8,
+								    bf + printed, size - printed);
+					free(mask);
+				}
+			} else {
+				unsigned char *b = (unsigned char *)val;
+				int i;
+				bool skip_zero = true;
+
+				printed += scnprintf(bf + printed, size - printed, "0x");
+				/* Print in little-endian order */
+				for (i = syscall_arg.len - 1; i >= 0; i--) {
+					if (skip_zero && b[i] == 0 && i > 0)
+						continue;
+					if (skip_zero) {
+						printed += scnprintf(bf + printed, size - printed, "%x", b[i]);
+						skip_zero = false;
+					} else {
+						printed += scnprintf(bf + printed, size - printed, "%02x", b[i]);
+					}
+				}
+			}
+			continue;
 		} else
 			val = format_field__intval(field, sample, evsel->needs_swap);
 		/*
@@ -5537,6 +5586,7 @@ int cmd_trace(int argc, const char **argv)
 		     "start"),
 	OPT_BOOLEAN(0, "force-btf", &trace.force_btf, "Prefer btf_dump general pretty printer"
 		       "to customized ones"),
+	OPT_BOOLEAN(0, "bitmask-list", &trace.bitmask_list, "Show bitmask as a human-readable list"),
 	OPT_BOOLEAN(0, "bpf-summary", &trace.summary_bpf, "Summary syscall stats in BPF"),
 	OPT_INTEGER(0, "max-summary", &trace.max_summary,
 		     "Max number of entries in the summary."),
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ea9fa04429f0..0d5eb2cc4ce5 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3933,6 +3933,35 @@ void *perf_sample__rawptr(struct perf_sample *sample, const char *name)
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
+		if (out_of_bounds(field, field->offset, 4, sample->raw_size))
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
 u64 format_field__intval(struct tep_format_field *field, struct perf_sample *sample,
 			 bool needs_swap)
 {
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 163fc2b6a7ea..1babfecc5d13 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -400,6 +400,9 @@ static inline char *perf_sample__strval(struct perf_sample *sample, const char *
 
 struct tep_format_field;
 
+void *format_field__get_raw_data(struct tep_format_field *field,
+				 struct perf_sample *sample,
+				 bool needs_swap, u16 *len_out);
 u64 format_field__intval(struct tep_format_field *field, struct perf_sample *sample, bool needs_swap);
 
 #ifdef HAVE_LIBTRACEEVENT
-- 
2.54.0

