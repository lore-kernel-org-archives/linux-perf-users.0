Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B7F372EFA;
	Tue, 24 Mar 2026 01:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774314098; cv=none; b=sWF66Vzd9kerEeXzdG8puDsaMhvhYdyJ9Dghcqi1EzP+e0V/Eaq8Nb9CGc87Q6g3ROUiGb/OrEW8iyp7vGKV3VZ7gEB8epYw93FdkwPNY55b7Tuovht8mMQmAVV5w2SSSRkvt+KD8504DNugm3pgphzq8L15SaOSCEV6ofVuR3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774314098; c=relaxed/simple;
	bh=2QGfqR6are3XvF2IzsxAaUnAr9oaOdhH2uZIQr1Knzw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=laUJu3LpyLcR15Fvs+vEGQy7Z/UoTmSQ7eSrsf9kW7XIL81Ji9iNNHMbB3mP2FO+YmYw8PDlwNGGb1qGSy6IArZwBLRkEzcMXWsahy16QfbcbM2xaUQg2SyM6FsIr4FefiVhw3pmvvsyri3Um/kbTc9++HWfFDj2gBu8x0rVl8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IT2z6GhN; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IT2z6GhN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774314096; x=1805850096;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2QGfqR6are3XvF2IzsxAaUnAr9oaOdhH2uZIQr1Knzw=;
  b=IT2z6GhNp4ImdAFqqZhC8wC29i+xcvIk6tktdARKqb5kAzzDqUBTIZDy
   GTp1yxv2FrCzT3KQlG22BAFON8Omygl5puQyCjvv67cJfPKgNR1HvQyGx
   57VA+MSCBH3zJ6Jcpm175gH7wpusgROXQx1HFOIxCTZDw3Vg2tn6R8GCB
   y1PKgTwHd3xu4RSdIZqRjyc98TjcVMts1P4+ln0wkTOyvdT8+HNYiTChz
   IQgpqmqTl+A0k8TdVOLO/6VnyczjvsYtvIxk33b5gaYyWx5hSx909je8+
   JAJ3ZxQ+ynal2gVWPu1ccUWg7+DdsNlfJ0GoZF3hEMd+18QFtzGATtANi
   w==;
X-CSE-ConnectionGUID: a0q7p5zaSXmxnrh4u3jIZw==
X-CSE-MsgGUID: YM/mMRiuSKyMES/GdWZb/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75441732"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="75441732"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 18:01:36 -0700
X-CSE-ConnectionGUID: FHAFra/FThm+hRxmGO7JzA==
X-CSE-MsgGUID: cWoM9XJ3QuWLZVPbyrxONQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="228263294"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa003.jf.intel.com with ESMTP; 23 Mar 2026 18:01:30 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	broonie@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v7 3/4] perf regs: Support x86 SIMD registers sampling
Date: Tue, 24 Mar 2026 08:57:05 +0800
Message-Id: <20260324005706.3778057-4-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324005706.3778057-1-dapeng1.mi@linux.intel.com>
References: <20260324005706.3778057-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds support for the newly introduced SIMD register sampling
format by adding the following 5 functions:

uint64_t perf_intr_simd_reg_class_mask(uint16_t e_machine, bool pred);
uint64_t perf_user_simd_reg_class_mask(uint16_t e_machine, bool pred);
uint64_t perf_intr_simd_reg_class_bitmap_qwords(uint16_t e_machine, int reg_c,
						uint16_t *qwords, bool pred);
uint64_t perf_user_simd_reg_class_bitmap_qwords(uint16_t e_machine, int reg_c,
						uint16_t *qwords, bool pred);
const char *perf_simd_reg_class_name(uint16_t e_machine, int id, bool pred);

The perf_{intr|user}_simd_reg_class_mask() functions retrieve the bitmap
of kernel supported SIMD/PRED register classes on current platform for
intr-regs and user-regs sampling, such as OPMASK/XMM/YMM/ZMM on
x86 platforms.

The perf_{intr|user}_simd_reg_class_bitmap_qwords() functions retrieve
the bitmap and qwords length of a certain class of SIMD/PRED register
on current platform for intr-regs and user-regs sampling. For example,
for the XMM registers on x86 platforms, the returned bitmap is 0xffff
(XMM0 ~ XMM15) and the qwords length is 2 (128 bits for each XMM
register).

The perf_simd_reg_class_name() function gets the register class name for
a certain register class index.

Additionally, the function __parse_regs() is enhanced to support parsing
these newly introduced SIMD/PRED registers. Currently, each class of
register can only be sampled collectively; sampling a specific SIMD
register is not supported. For example, all XMM registers are sampled
together rather than sampling only XMM0.

When multiple overlapping register types, such as XMM and YMM, are
sampled simultaneously, only the superset (YMM registers) is sampled.

With this patch, all supported sampling registers on x86 platforms are
displayed as follows.

 $perf record --intr-regs=?
 available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10
 R11 R12 R13 R14 R15 R16 R17 R18 R19 R20 R21 R22 R23 R24 R25 R26 R27 R28
 R29 R30 R31 SSP XMM0-15 YMM0-15 ZMM0-31 OPMASK0-7

 $perf record --user-regs=?
 available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10
 R11 R12 R13 R14 R15 R16 R17 R18 R19 R20 R21 R22 R23 R24 R25 R26 R27 R28
 R29 R30 R31 SSP XMM0-15 YMM0-15 ZMM0-31 OPMASK0-7

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c                       |  27 ++
 tools/perf/util/parse-regs-options.c          | 164 +++++++++-
 .../perf/util/perf-regs-arch/perf_regs_x86.c  | 292 ++++++++++++++++++
 tools/perf/util/perf_event_attr_fprintf.c     |   6 +
 tools/perf/util/perf_regs.c                   |  72 +++++
 tools/perf/util/perf_regs.h                   |  11 +
 tools/perf/util/record.h                      |   6 +
 7 files changed, 567 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f565ef2eb476..5f00489e714a 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1589,12 +1589,39 @@ void evsel__config(struct evsel *evsel, const struct record_opts *opts,
 	if (opts->sample_intr_regs && !evsel->no_aux_samples &&
 	    !evsel__is_dummy_event(evsel)) {
 		attr->sample_regs_intr = opts->sample_intr_regs;
+		attr->sample_simd_regs_enabled = !!opts->sample_pred_reg_qwords;
+		evsel__set_sample_bit(evsel, REGS_INTR);
+	}
+
+	if ((opts->sample_intr_vec_regs || opts->sample_intr_pred_regs) &&
+	    !evsel->no_aux_samples && !evsel__is_dummy_event(evsel)) {
+		/* The pred qwords is to implies the set of SIMD registers is used */
+		if (opts->sample_pred_reg_qwords)
+			attr->sample_simd_pred_reg_qwords = opts->sample_pred_reg_qwords;
+		else
+			attr->sample_simd_pred_reg_qwords = 1;
+		attr->sample_simd_vec_reg_intr = opts->sample_intr_vec_regs;
+		attr->sample_simd_vec_reg_qwords = opts->sample_vec_reg_qwords;
+		attr->sample_simd_pred_reg_intr = opts->sample_intr_pred_regs;
 		evsel__set_sample_bit(evsel, REGS_INTR);
 	}
 
 	if (opts->sample_user_regs && !evsel->no_aux_samples &&
 	    !evsel__is_dummy_event(evsel)) {
 		attr->sample_regs_user |= opts->sample_user_regs;
+		attr->sample_simd_regs_enabled = !!opts->sample_pred_reg_qwords;
+		evsel__set_sample_bit(evsel, REGS_USER);
+	}
+
+	if ((opts->sample_user_vec_regs || opts->sample_user_pred_regs) &&
+	    !evsel->no_aux_samples && !evsel__is_dummy_event(evsel)) {
+		if (opts->sample_pred_reg_qwords)
+			attr->sample_simd_pred_reg_qwords = opts->sample_pred_reg_qwords;
+		else
+			attr->sample_simd_pred_reg_qwords = 1;
+		attr->sample_simd_vec_reg_user = opts->sample_user_vec_regs;
+		attr->sample_simd_vec_reg_qwords = opts->sample_vec_reg_qwords;
+		attr->sample_simd_pred_reg_user = opts->sample_user_pred_regs;
 		evsel__set_sample_bit(evsel, REGS_USER);
 	}
 
diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse-regs-options.c
index 6cf865bfc2f7..3dfa7ec276c2 100644
--- a/tools/perf/util/parse-regs-options.c
+++ b/tools/perf/util/parse-regs-options.c
@@ -9,13 +9,13 @@
 #include <subcmd/parse-options.h>
 #include "util/perf_regs.h"
 #include "util/parse-regs-options.h"
+#include "record.h"
 
 static void
-list_perf_regs(FILE *fp, uint64_t mask, int abi)
+__list_gp_regs(FILE *fp, uint64_t mask, int abi)
 {
 	const char *last_name = NULL;
 
-	fprintf(fp, "available registers: ");
 	for (int reg = 0; reg < 64; reg++) {
 		const char *name;
 
@@ -27,14 +27,68 @@ list_perf_regs(FILE *fp, uint64_t mask, int abi)
 			fprintf(fp, "%s%s", reg > 0 ? " " : "", name);
 		last_name = name;
 	}
+}
+
+static void
+__list_simd_regs(FILE *fp, uint64_t mask, bool intr, bool pred)
+{
+	uint64_t bitmap = 0;
+	uint16_t qwords = 0;
+	const char *name;
+	int i = 0;
+
+	for (int reg_c = 0; reg_c < 64; reg_c++) {
+		if (((1ULL << reg_c) & mask) == 0)
+			continue;
+
+		name = perf_simd_reg_class_name(EM_HOST, reg_c, pred);
+		bitmap = intr ?
+			 perf_intr_simd_reg_class_bitmap_qwords(EM_HOST, reg_c, &qwords, pred) :
+			 perf_user_simd_reg_class_bitmap_qwords(EM_HOST, reg_c, &qwords, pred);
+		if (name && bitmap)
+			fprintf(fp, "%s%s0-%d", i++ > 0 ? " " : "",
+				name, fls64(bitmap) - 1);
+	}
+}
+
+static void
+list_perf_regs(FILE *fp, uint64_t mask, uint64_t simd_mask,
+	       uint64_t pred_mask, int abi, bool intr)
+{
+	bool printed = false;
+
+	fprintf(fp, "available registers: ");
+
+	if (mask) {
+		__list_gp_regs(fp, mask, abi);
+		printed = true;
+	}
+
+	if (simd_mask) {
+		if (printed)
+			fprintf(fp, " ");
+		__list_simd_regs(fp, simd_mask, intr, /*pred=*/false);
+		printed = true;
+	}
+
+	if (pred_mask) {
+		if (printed)
+			fprintf(fp, " ");
+		__list_simd_regs(fp, pred_mask, intr, /*pred=*/true);
+		printed = true;
+	}
+
 	fputc('\n', fp);
 }
 
 static uint64_t
-name_to_perf_reg_mask(const char *to_match, uint64_t mask, int abi)
+name_to_gp_reg_mask(const char *to_match, uint64_t mask, int abi)
 {
 	uint64_t reg_mask = 0;
 
+	if (!mask)
+		return reg_mask;
+
 	for (int reg = 0; reg < 64; reg++) {
 		const char *name;
 
@@ -51,13 +105,79 @@ name_to_perf_reg_mask(const char *to_match, uint64_t mask, int abi)
 	return reg_mask;
 }
 
+static bool
+name_to_simd_reg_mask(struct record_opts *opts, const char *to_match,
+		      uint64_t mask, bool intr, bool pred)
+{
+	bool matched = false;
+	uint64_t bitmap;
+	uint16_t qwords;
+	int reg_c;
+
+	if (!mask)
+		return false;
+
+	for (reg_c = 0; reg_c < 64; reg_c++) {
+		const char *name;
+
+		if (((1ULL << reg_c) & mask) == 0)
+			continue;
+
+		name = perf_simd_reg_class_name(EM_HOST, reg_c, pred);
+		if (!name)
+			continue;
+
+		if (!strcasecmp(to_match, name)) {
+			matched = true;
+			break;
+		}
+	}
+
+	if (!matched)
+		return false;
+
+	if (intr) {
+		bitmap = perf_intr_simd_reg_class_bitmap_qwords(EM_HOST,
+							reg_c, &qwords, pred);
+	} else {
+		bitmap = perf_user_simd_reg_class_bitmap_qwords(EM_HOST,
+							reg_c, &qwords, pred);
+	}
+
+	/* Just need the highest qwords */
+	if (pred) {
+		if (qwords >= opts->sample_pred_reg_qwords) {
+			opts->sample_pred_reg_qwords = qwords;
+			if (intr)
+				opts->sample_intr_pred_regs = bitmap;
+			else
+				opts->sample_user_pred_regs = bitmap;
+		}
+	} else {
+		if (qwords >= opts->sample_vec_reg_qwords) {
+			opts->sample_vec_reg_qwords = qwords;
+			if (intr)
+				opts->sample_intr_vec_regs = bitmap;
+			else
+				opts->sample_user_vec_regs = bitmap;
+		}
+	}
+
+	return true;
+}
+
 static int
 __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 {
 	uint64_t *mode = (uint64_t *)opt->value;
+	struct record_opts *opts;
 	char *s, *os = NULL, *p;
-	int ret = -1;
+	uint64_t simd_mask;
+	uint64_t pred_mask;
 	uint64_t mask;
+	const char *warn;
+	bool matched;
+	int ret = -1;
 	int abi = 0;
 
 	if (unset)
@@ -69,11 +189,16 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 	if (*mode)
 		return -1;
 
-	mask = intr ? perf_intr_reg_mask(EM_HOST, &abi) : perf_user_reg_mask(EM_HOST, &abi);
+	mask = intr ? perf_intr_reg_mask(EM_HOST, &abi) :
+		      perf_user_reg_mask(EM_HOST, &abi);
+	opts = intr ? container_of(opt->value, struct record_opts, sample_intr_regs) :
+		      container_of(opt->value, struct record_opts, sample_user_regs);
 
 	/* str may be NULL in case no arg is passed to -I */
 	if (!str) {
 		*mode = mask;
+		if (abi & PERF_SAMPLE_REGS_ABI_SIMD)
+			opts->sample_pred_reg_qwords = 1;
 		return 0;
 	}
 
@@ -82,6 +207,15 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 	if (!s)
 		return -1;
 
+	if (intr) {
+		simd_mask = perf_intr_simd_reg_class_mask(EM_HOST, /*pred=*/false);
+		pred_mask = perf_intr_simd_reg_class_mask(EM_HOST, /*pred=*/true);
+	} else {
+		simd_mask = perf_user_simd_reg_class_mask(EM_HOST, /*pred=*/false);
+		pred_mask = perf_user_simd_reg_class_mask(EM_HOST, /*pred=*/true);
+	}
+
+	warn = "Unknown register \"%s\", check man page or run \"perf record %s?\"\n";
 	for (;;) {
 		uint64_t reg_mask;
 
@@ -90,15 +224,23 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 			*p = '\0';
 
 		if (!strcmp(s, "?")) {
-			list_perf_regs(stderr, mask, abi);
+			list_perf_regs(stderr, mask, simd_mask, pred_mask, abi, intr);
 			goto error;
 		}
 
-		reg_mask = name_to_perf_reg_mask(s, mask, abi);
-		if (reg_mask == 0) {
-			ui__warning("Unknown register \"%s\", check man page or run \"perf record %s?\"\n",
-				s, intr ? "-I" : "--user-regs=");
-			goto error;
+		reg_mask = name_to_gp_reg_mask(s, mask, abi);
+		if (reg_mask) {
+			if (abi & PERF_SAMPLE_REGS_ABI_SIMD)
+				opts->sample_pred_reg_qwords = 1;
+		} else {
+			matched = name_to_simd_reg_mask(opts, s, simd_mask,
+							intr, /*pred=*/false) ||
+				  name_to_simd_reg_mask(opts, s, pred_mask,
+							intr, /*pred=*/true);
+			if (!matched) {
+				ui__warning(warn, s, intr ? "-I" : "--user-regs=");
+				goto error;
+			}
 		}
 		*mode |= reg_mask;
 
diff --git a/tools/perf/util/perf-regs-arch/perf_regs_x86.c b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
index ae26d991cdc9..2bc93b600662 100644
--- a/tools/perf/util/perf-regs-arch/perf_regs_x86.c
+++ b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
@@ -465,3 +465,295 @@ uint64_t __perf_reg_sp_x86(void)
 {
 	return PERF_REG_X86_SP;
 }
+
+enum {
+	PERF_REG_CLASS_X86_OPMASK = 0,
+	PERF_REG_CLASS_X86_XMM,
+	PERF_REG_CLASS_X86_YMM,
+	PERF_REG_CLASS_X86_ZMM,
+	PERF_REG_X86_MAX_SIMD_CLASSES,
+};
+
+#define PERF_REG_CLASS_X86_PRED_MASK	(BIT(PERF_REG_CLASS_X86_OPMASK))
+#define PERF_REG_CLASS_X86_SIMD_MASK	(BIT(PERF_REG_CLASS_X86_XMM) | \
+					 BIT(PERF_REG_CLASS_X86_YMM) | \
+					 BIT(PERF_REG_CLASS_X86_ZMM))
+
+/*
+ * This function is used to determin whether kernel perf subsystem supports
+ * which kinds of SIMD registers (OPMASK/XMM/YMM/ZMM) sampling.
+ *
+ * @sample_type: PERF_SAMPLE_REGS_INTR or PERF_SAMPLE_REGS_USER
+ * @qwords: the length of SIMD register, like 1/2/4/8 qwords for
+ *          OPMASK/XMM/YMM/ZMM regisers.
+ * @mask: the bitamsk of SIMD register, like 0xffff for XMM0 ~ XMM15
+ * @pred: whether It's a preceding SIMD register, like OPMASK register.
+ *
+ * Return value: true indicates support, otherwise no support.
+ */
+static bool
+__support_simd_reg_class(uint64_t sample_type, uint16_t qwords,
+			 uint64_t mask, bool pred)
+{
+	struct perf_event_attr attr = {
+		.type				= PERF_TYPE_HARDWARE,
+		.config				= PERF_COUNT_HW_CPU_CYCLES,
+		.sample_type			= sample_type,
+		.disabled			= 1,
+		.exclude_kernel			= 1,
+		.sample_simd_regs_enabled	= 1,
+	};
+	int fd;
+
+	attr.sample_period = 1;
+
+	if (!pred) {
+		attr.sample_simd_vec_reg_qwords = qwords;
+		if (sample_type == PERF_SAMPLE_REGS_INTR)
+			attr.sample_simd_vec_reg_intr = mask;
+		else
+			attr.sample_simd_vec_reg_user = mask;
+	} else {
+		attr.sample_simd_pred_reg_qwords = PERF_X86_OPMASK_QWORDS;
+		if (sample_type == PERF_SAMPLE_REGS_INTR)
+			attr.sample_simd_pred_reg_intr = PERF_X86_SIMD_PRED_MASK;
+		else
+			attr.sample_simd_pred_reg_user = PERF_X86_SIMD_PRED_MASK;
+	}
+
+	if (perf_pmus__num_core_pmus() > 1) {
+		__u64 type = perf_pmus__find_core_pmu()->type;
+
+		attr.config |= type << PERF_PMU_TYPE_SHIFT;
+	}
+
+	event_attr_init(&attr);
+
+	fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
+	if (fd != -1) {
+		close(fd);
+		return true;
+	}
+
+	return false;
+}
+
+#define PERF_X86_SIMD_ZMMH_REGS	(PERF_X86_SIMD_ZMM_REGS / 2)
+
+static bool __arch_has_simd_reg_class(uint64_t sample_type, int reg_class,
+				      uint64_t *mask, uint16_t *qwords)
+{
+	bool supported = false;
+	uint64_t bits;
+
+	*mask = 0;
+	*qwords = 0;
+
+	switch (reg_class) {
+	case PERF_REG_CLASS_X86_OPMASK:
+		bits = BIT_ULL(PERF_X86_SIMD_OPMASK_REGS) - 1;
+		supported = __support_simd_reg_class(sample_type,
+						     PERF_X86_OPMASK_QWORDS,
+						     bits, true);
+		if (supported) {
+			*mask = bits;
+			*qwords = PERF_X86_OPMASK_QWORDS;
+		}
+		break;
+	case PERF_REG_CLASS_X86_XMM:
+		bits = BIT_ULL(PERF_X86_SIMD_XMM_REGS) - 1;
+		supported = __support_simd_reg_class(sample_type,
+						     PERF_X86_XMM_QWORDS,
+						     bits, false);
+		if (supported) {
+			*mask = bits;
+			*qwords = PERF_X86_XMM_QWORDS;
+		}
+		break;
+	case PERF_REG_CLASS_X86_YMM:
+		bits = BIT_ULL(PERF_X86_SIMD_YMM_REGS) - 1;
+		supported = __support_simd_reg_class(sample_type,
+						     PERF_X86_YMM_QWORDS,
+						     bits, false);
+		if (supported) {
+			*mask = bits;
+			*qwords = PERF_X86_YMM_QWORDS;
+		}
+		break;
+	case PERF_REG_CLASS_X86_ZMM:
+		bits = BIT_ULL(PERF_X86_SIMD_ZMM_REGS) - 1;
+		supported = __support_simd_reg_class(sample_type,
+						     PERF_X86_ZMM_QWORDS,
+						     bits, false);
+		if (supported) {
+			*mask = bits;
+			*qwords = PERF_X86_ZMM_QWORDS;
+			break;
+		}
+
+		bits = BIT_ULL(PERF_X86_SIMD_ZMMH_REGS) - 1;
+		supported = __support_simd_reg_class(sample_type,
+						     PERF_X86_ZMM_QWORDS,
+						     bits, false);
+		if (supported) {
+			*mask = bits;
+			*qwords = PERF_X86_ZMM_QWORDS;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return supported;
+}
+
+static bool __support_simd_sampling(void)
+{
+	uint64_t mask = BIT_ULL(PERF_X86_SIMD_XMM_REGS) - 1;
+	uint16_t qwords = PERF_X86_XMM_QWORDS;
+	static bool simd_sampling_supported;
+	static bool cached;
+
+	if (cached)
+		return simd_sampling_supported;
+
+	simd_sampling_supported =
+		 __arch_has_simd_reg_class(PERF_SAMPLE_REGS_INTR,
+					   PERF_REG_CLASS_X86_XMM,
+					   &mask, &qwords);
+	simd_sampling_supported |=
+		 __arch_has_simd_reg_class(PERF_SAMPLE_REGS_USER,
+					   PERF_REG_CLASS_X86_XMM,
+					   &mask, &qwords);
+	cached = true;
+
+	return simd_sampling_supported;
+}
+
+/*
+ * @x86_intr_simd_cached: indicates the data of below 3
+ *  x86_intr_simd_* items has been retrieved from kernel and cached.
+ * @x86_intr_simd_reg_class_mask: indicates which kinds of PRED/SIMD
+ *  registers are supported for intr-regs option. Assume kernel perf
+ *  subsystem supports XMM/YMM sampling, then the mask is
+ *  PERF_REG_CLASS_X86_XMM|PERF_REG_CLASS_X86_YMM.
+ * @x86_intr_simd_mask: indicates register bitmask for each kind of
+ *  supported PRED/SIMD register, like
+ *  x86_intr_simd_mask[PERF_REG_CLASS_X86_XMM] = 0xffff.
+ * @x86_intr_simd_mask: indicates the register length (qwords uinit)
+ *  for each kind of supported PRED/SIMD register, like
+ *  x86_intr_simd_qwords[PERF_REG_CLASS_X86_XMM] = 2.
+ */
+static bool x86_intr_simd_cached;
+static uint64_t x86_intr_simd_reg_class_mask;
+static uint64_t x86_intr_simd_mask[PERF_REG_X86_MAX_SIMD_CLASSES];
+static uint16_t x86_intr_simd_qwords[PERF_REG_X86_MAX_SIMD_CLASSES];
+
+/*
+ * Similar with above x86_intr_simd_* items, the difference is these
+ * items are used for user-regs option.
+ */
+static bool x86_user_simd_cached;
+static uint64_t x86_user_simd_reg_class_mask;
+static uint64_t x86_user_simd_mask[PERF_REG_X86_MAX_SIMD_CLASSES];
+static uint16_t x86_user_simd_qwords[PERF_REG_X86_MAX_SIMD_CLASSES];
+
+static uint64_t __arch__simd_reg_class_mask(bool intr)
+{
+	uint64_t mask = 0;
+	bool supported;
+	int reg_c;
+
+	if (!__support_simd_sampling())
+		return 0;
+
+	if (intr && x86_intr_simd_cached)
+		return x86_intr_simd_reg_class_mask;
+
+	if (!intr && x86_user_simd_cached)
+		return x86_user_simd_reg_class_mask;
+
+	for (reg_c = 0; reg_c < PERF_REG_X86_MAX_SIMD_CLASSES; reg_c++) {
+		supported = false;
+
+		if (intr) {
+			supported = __arch_has_simd_reg_class(
+						PERF_SAMPLE_REGS_INTR,
+						reg_c,
+						&x86_intr_simd_mask[reg_c],
+						&x86_intr_simd_qwords[reg_c]);
+		} else {
+			supported = __arch_has_simd_reg_class(
+						PERF_SAMPLE_REGS_USER,
+						reg_c,
+						&x86_user_simd_mask[reg_c],
+						&x86_user_simd_qwords[reg_c]);
+		}
+		if (supported)
+			mask |= BIT_ULL(reg_c);
+	}
+
+	if (intr) {
+		x86_intr_simd_reg_class_mask = mask;
+		x86_intr_simd_cached = true;
+	} else {
+		x86_user_simd_reg_class_mask = mask;
+		x86_user_simd_cached = true;
+	}
+
+	return mask;
+}
+
+static uint64_t
+__arch__simd_reg_class_bitmap_qwords(bool intr, int reg_c, uint16_t *qwords)
+{
+	uint64_t mask = 0;
+
+	*qwords = 0;
+	if (reg_c >= PERF_REG_X86_MAX_SIMD_CLASSES)
+		return mask;
+
+	if (intr) {
+		mask = x86_intr_simd_mask[reg_c];
+		*qwords = x86_intr_simd_qwords[reg_c];
+	} else {
+		mask = x86_user_simd_mask[reg_c];
+		*qwords = x86_user_simd_qwords[reg_c];
+	}
+
+	return mask;
+}
+
+uint64_t __perf_simd_reg_class_mask_x86(bool intr, bool pred)
+{
+	uint64_t mask = __arch__simd_reg_class_mask(intr);
+
+	return pred ? mask & PERF_REG_CLASS_X86_PRED_MASK :
+		      mask & PERF_REG_CLASS_X86_SIMD_MASK;
+}
+
+uint64_t __perf_simd_reg_class_bitmap_qwords_x86(int reg_c, uint16_t *qwords,
+						 bool intr, bool pred)
+{
+	if (!x86_intr_simd_cached)
+		__perf_simd_reg_class_mask_x86(intr, pred);
+	return __arch__simd_reg_class_bitmap_qwords(intr, reg_c, qwords);
+}
+
+const char *__perf_simd_reg_class_name_x86(int id, bool pred __maybe_unused)
+{
+	switch (id) {
+	case PERF_REG_CLASS_X86_OPMASK:
+		return "OPMASK";
+	case PERF_REG_CLASS_X86_XMM:
+		return "XMM";
+	case PERF_REG_CLASS_X86_YMM:
+		return "YMM";
+	case PERF_REG_CLASS_X86_ZMM:
+		return "ZMM";
+	default:
+		return NULL;
+	}
+
+	return NULL;
+}
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index 741c3d657a8b..c6b8e53e06fd 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -362,6 +362,12 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 	PRINT_ATTRf(aux_start_paused, p_unsigned);
 	PRINT_ATTRf(aux_pause, p_unsigned);
 	PRINT_ATTRf(aux_resume, p_unsigned);
+	PRINT_ATTRf(sample_simd_pred_reg_qwords, p_unsigned);
+	PRINT_ATTRf(sample_simd_pred_reg_intr, p_hex);
+	PRINT_ATTRf(sample_simd_pred_reg_user, p_hex);
+	PRINT_ATTRf(sample_simd_vec_reg_qwords, p_unsigned);
+	PRINT_ATTRf(sample_simd_vec_reg_intr, p_hex);
+	PRINT_ATTRf(sample_simd_vec_reg_user, p_hex);
 
 	return ret;
 }
diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
index afc567718bee..dc99e797e715 100644
--- a/tools/perf/util/perf_regs.c
+++ b/tools/perf/util/perf_regs.c
@@ -246,3 +246,75 @@ uint64_t perf_arch_reg_sp(uint16_t e_machine)
 		return 0;
 	}
 }
+
+uint64_t perf_intr_simd_reg_class_mask(uint16_t e_machine, bool pred)
+{
+	switch (e_machine) {
+	case EM_386:
+	case EM_X86_64:
+		return __perf_simd_reg_class_mask_x86(/*intr=*/true, pred);
+	default:
+		return 0;
+	}
+}
+
+uint64_t perf_user_simd_reg_class_mask(uint16_t e_machine, bool pred)
+{
+	switch (e_machine) {
+	case EM_386:
+	case EM_X86_64:
+		return __perf_simd_reg_class_mask_x86(/*intr=*/false, pred);
+	default:
+		return 0;
+	}
+}
+
+uint64_t perf_intr_simd_reg_class_bitmap_qwords(uint16_t e_machine, int reg_c,
+						uint16_t *qwords, bool pred)
+{
+	switch (e_machine) {
+	case EM_386:
+	case EM_X86_64:
+		return __perf_simd_reg_class_bitmap_qwords_x86(reg_c, qwords,
+							       /*intr=*/true,
+							       pred);
+	default:
+		*qwords = 0;
+		return 0;
+	}
+}
+
+uint64_t perf_user_simd_reg_class_bitmap_qwords(uint16_t e_machine, int reg_c,
+						uint16_t *qwords, bool pred)
+{
+	switch (e_machine) {
+	case EM_386:
+	case EM_X86_64:
+		return __perf_simd_reg_class_bitmap_qwords_x86(reg_c, qwords,
+							       /*intr=*/false,
+							       pred);
+	default:
+		*qwords = 0;
+		return 0;
+	}
+}
+
+const char *perf_simd_reg_class_name(uint16_t e_machine, int id, bool pred)
+{
+	const char *name = NULL;
+
+	switch (e_machine) {
+	case EM_386:
+	case EM_X86_64:
+		name = __perf_simd_reg_class_name_x86(id, pred);
+		break;
+	default:
+		break;
+	}
+	if (name)
+		return name;
+
+	pr_debug("Failed to find %s register %d for ELF machine type %u\n",
+		 pred ? "PRED" : "SIMD", id, e_machine);
+	return "unknown";
+}
diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
index c9501ca8045d..80d1d7316188 100644
--- a/tools/perf/util/perf_regs.h
+++ b/tools/perf/util/perf_regs.h
@@ -20,6 +20,13 @@ const char *perf_reg_name(int id, uint16_t e_machine, uint32_t e_flags, int abi)
 int perf_reg_value(u64 *valp, struct regs_dump *regs, int id);
 uint64_t perf_arch_reg_ip(uint16_t e_machine);
 uint64_t perf_arch_reg_sp(uint16_t e_machine);
+uint64_t perf_intr_simd_reg_class_mask(uint16_t e_machine, bool pred);
+uint64_t perf_user_simd_reg_class_mask(uint16_t e_machine, bool pred);
+uint64_t perf_intr_simd_reg_class_bitmap_qwords(uint16_t e_machine, int reg_c,
+						uint16_t *qwords, bool pred);
+uint64_t perf_user_simd_reg_class_bitmap_qwords(uint16_t e_machine, int reg_c,
+						uint16_t *qwords, bool pred);
+const char *perf_simd_reg_class_name(uint16_t e_machine, int id, bool pred);
 
 int __perf_sdt_arg_parse_op_arm64(char *old_op, char **new_op);
 uint64_t __perf_reg_mask_arm64(bool intr);
@@ -68,6 +75,10 @@ uint64_t __perf_reg_mask_x86(bool intr, int *abi);
 const char *__perf_reg_name_x86(int id, int abi);
 uint64_t __perf_reg_ip_x86(void);
 uint64_t __perf_reg_sp_x86(void);
+uint64_t __perf_simd_reg_class_mask_x86(bool intr, bool pred);
+uint64_t __perf_simd_reg_class_bitmap_qwords_x86(int reg_c, uint16_t *qwords,
+						 bool intr, bool pred);
+const char *__perf_simd_reg_class_name_x86(int id, bool pred);
 
 static inline uint64_t DWARF_MINIMAL_REGS(uint16_t e_machine)
 {
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index 93627c9a7338..37ed44b5f15b 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -62,6 +62,12 @@ struct record_opts {
 	u64	      branch_stack;
 	u64	      sample_intr_regs;
 	u64	      sample_user_regs;
+	u64	      sample_intr_vec_regs;
+	u64	      sample_user_vec_regs;
+	u32	      sample_intr_pred_regs;
+	u32	      sample_user_pred_regs;
+	u16	      sample_vec_reg_qwords;
+	u16	      sample_pred_reg_qwords;
 	u64	      default_interval;
 	u64	      user_interval;
 	size_t	      auxtrace_snapshot_size;
-- 
2.34.1

