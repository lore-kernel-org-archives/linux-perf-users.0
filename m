Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE25923C8D3;
	Tue, 18 Feb 2025 08:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866511; cv=none; b=mnZHiW1JeB9S6O3fh4kwHFWtdlrTBVWdz5VKiOCiW7zRJB+8PFmMEBLqeHI+q+hhvFPSfgZt2WRfOghsKk3dn9/Vxwxzg0gPqxnOkVVmVqej8+XHxOwWTPbl67cBnH5k0QHQe3E2AOrRgk+dO4VR0G7ziF3VOHhyaATaT8aWBXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866511; c=relaxed/simple;
	bh=TlGL1UgwL0twzqF7sdYiEjdQ4TeIO9OLcbKqplcExwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q3zLq7+8juHrEWVqIqnIeJpEYOwkrkPmw4DTd1rhdN3bKOBYRiuM6MhQ8iwG56ZdoXeRbB3mUcknEKqyJN6+NCqcGeJbQGXjy55xRZHxHBmErKrOW+0Hfk2s5gTjLScKzUbz1WnsM1srNwZfSkV2QVKIp+w77v8UBEmyEpObDmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nUL3EAgP; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nUL3EAgP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739866511; x=1771402511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TlGL1UgwL0twzqF7sdYiEjdQ4TeIO9OLcbKqplcExwc=;
  b=nUL3EAgPHJqmpai/s/xxJFjaef1AUiGbROqWf2SelLGP+5YeyBKMLNDY
   F7UH0EHEq3Lnm+9IUsC59okHIB3wd3hKs3FiHYaGejtbnYMi0yuGnc3mb
   2mQvB2mvDJfTMR2w8BxPZnlO2bgBJretAvZnaC7xSJGewtHzz2wawT+e4
   vzjZEGDpGHROto6QNLnzx0vYlFtDN5thyQQgCdI/7/AcF+dVIN+ujs8R1
   mx1Hbd3t7onlMfOnCF8jaf2/00dgXaNr9FNXCONbxccIn/C0fG6xIiZHX
   rWxSRHeNb4dDyan/OOr0I2g6wSRNQS2pqXw99B1UlHlxh0t2bKx7YfdeZ
   A==;
X-CSE-ConnectionGUID: w1QYsIRnT6ac+pwveamAFQ==
X-CSE-MsgGUID: Q8xKgh7uTlKbRWQ8KTypkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44200892"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="44200892"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 00:15:11 -0800
X-CSE-ConnectionGUID: JKX2BRvmQHWNDHBvQ1MwGQ==
X-CSE-MsgGUID: 9a8IR+HXSqWO0zMmnoO8Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="145166355"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa002.jf.intel.com with ESMTP; 18 Feb 2025 00:15:06 -0800
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v2 21/24] perf tools: Enhance sample_regs_user/intr to capture more registers
Date: Tue, 18 Feb 2025 15:28:15 +0000
Message-Id: <20250218152818.158614-22-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
References: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intel architectural PEBS supports to capture more vector registers like
OPMASK/YMM/ZMM registers besides already supported XMM registers.

arch-PEBS vector registers (VCER) capturing on perf core/pmu driver
(Intel) has been supported by previous patches. This patch adds perf
tool's part support. In detail, add support for the new
sample_regs_intr/user_ext register selector in perf_event_attr. These 32
bytes bitmap is used to select the new register group OPMASK, YMMH, ZMMH
and ZMM in VECR. Update perf regs to introduce the new registers.

This single patch only introduces the generic support, x86/intel specific
support would be added in next patch.

Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/include/uapi/linux/perf_event.h | 14 +++++++++++++
 tools/perf/builtin-script.c           | 23 +++++++++++++++-----
 tools/perf/util/evsel.c               | 30 ++++++++++++++++++++-------
 tools/perf/util/parse-regs-options.c  | 23 ++++++++++++--------
 tools/perf/util/perf_regs.h           | 16 +++++++++++++-
 tools/perf/util/record.h              |  4 ++--
 tools/perf/util/sample.h              |  6 +++++-
 tools/perf/util/session.c             | 29 +++++++++++++++-----------
 tools/perf/util/synthetic-events.c    |  6 ++++--
 9 files changed, 112 insertions(+), 39 deletions(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 0524d541d4e3..a46b4f33557f 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -379,6 +379,13 @@ enum perf_event_read_format {
 #define PERF_ATTR_SIZE_VER6	120	/* add: aux_sample_size */
 #define PERF_ATTR_SIZE_VER7	128	/* add: sig_data */
 #define PERF_ATTR_SIZE_VER8	136	/* add: config3 */
+#define PERF_ATTR_SIZE_VER9	168	/* add: sample_regs_intr_ext[PERF_EXT_REGS_ARRAY_SIZE] */
+
+#define PERF_EXT_REGS_ARRAY_SIZE	4
+#define PERF_NUM_EXT_REGS		(PERF_EXT_REGS_ARRAY_SIZE * 64)
+
+#define PERF_SAMPLE_ARRAY_SIZE		(PERF_EXT_REGS_ARRAY_SIZE + 1)
+#define PERF_SAMPLE_REGS_NUM		((PERF_SAMPLE_ARRAY_SIZE) * 64)
 
 /*
  * Hardware event_id to monitor via a performance monitoring event:
@@ -531,6 +538,13 @@ struct perf_event_attr {
 	__u64	sig_data;
 
 	__u64	config3; /* extension of config2 */
+
+	/*
+	 * Extension sets of regs to dump for each sample.
+	 * See asm/perf_regs.h for details.
+	 */
+	__u64	sample_regs_intr_ext[PERF_EXT_REGS_ARRAY_SIZE];
+	__u64   sample_regs_user_ext[PERF_EXT_REGS_ARRAY_SIZE];
 };
 
 /*
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 33667b534634..14aba0965a26 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -712,21 +712,32 @@ static int perf_session__check_output_opt(struct perf_session *session)
 }
 
 static int perf_sample__fprintf_regs(struct regs_dump *regs, uint64_t mask, const char *arch,
-				     FILE *fp)
+				     unsigned long *mask_ext, FILE *fp)
 {
+	unsigned int mask_size = sizeof(mask) * 8;
 	unsigned i = 0, r;
 	int printed = 0;
+	u64 val;
 
 	if (!regs || !regs->regs)
 		return 0;
 
 	printed += fprintf(fp, " ABI:%" PRIu64 " ", regs->abi);
 
-	for_each_set_bit(r, (unsigned long *) &mask, sizeof(mask) * 8) {
-		u64 val = regs->regs[i++];
+	for_each_set_bit(r, (unsigned long *)&mask, mask_size) {
+		val = regs->regs[i++];
 		printed += fprintf(fp, "%5s:0x%"PRIx64" ", perf_reg_name(r, arch), val);
 	}
 
+	if (!mask_ext)
+		return printed;
+
+	for_each_set_bit(r, mask_ext, PERF_NUM_EXT_REGS) {
+		val = regs->regs[i++];
+		printed += fprintf(fp, "%5s:0x%"PRIx64" ",
+				   perf_reg_name(r + mask_size, arch), val);
+	}
+
 	return printed;
 }
 
@@ -784,14 +795,16 @@ static int perf_sample__fprintf_iregs(struct perf_sample *sample,
 				      struct perf_event_attr *attr, const char *arch, FILE *fp)
 {
 	return perf_sample__fprintf_regs(&sample->intr_regs,
-					 attr->sample_regs_intr, arch, fp);
+					 attr->sample_regs_intr, arch,
+					 (unsigned long *)attr->sample_regs_intr_ext, fp);
 }
 
 static int perf_sample__fprintf_uregs(struct perf_sample *sample,
 				      struct perf_event_attr *attr, const char *arch, FILE *fp)
 {
 	return perf_sample__fprintf_regs(&sample->user_regs,
-					 attr->sample_regs_user, arch, fp);
+					 attr->sample_regs_user, arch,
+					 (unsigned long *)attr->sample_regs_user_ext, fp);
 }
 
 static int perf_sample__fprintf_start(struct perf_script *script,
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 78bcb12a9d96..45e06aeec4e5 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1037,7 +1037,7 @@ static void __evsel__config_callchain(struct evsel *evsel, struct record_opts *o
 			arch__user_reg_mask((unsigned long *)&mask);
 			evsel__set_sample_bit(evsel, REGS_USER);
 			evsel__set_sample_bit(evsel, STACK_USER);
-			if (opts->sample_user_regs &&
+			if (bitmap_weight(opts->sample_user_regs, PERF_SAMPLE_REGS_NUM) &&
 			    DWARF_MINIMAL_REGS(arch) != mask) {
 				attr->sample_regs_user |= DWARF_MINIMAL_REGS(arch);
 				pr_warning("WARNING: The use of --call-graph=dwarf may require all the user registers, "
@@ -1373,15 +1373,19 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 	if (callchain && callchain->enabled && !evsel->no_aux_samples)
 		evsel__config_callchain(evsel, opts, callchain);
 
-	if (opts->sample_intr_regs && !evsel->no_aux_samples &&
-	    !evsel__is_dummy_event(evsel)) {
-		attr->sample_regs_intr = opts->sample_intr_regs;
+	if (bitmap_weight(opts->sample_intr_regs, PERF_SAMPLE_REGS_NUM) &&
+	    !evsel->no_aux_samples && !evsel__is_dummy_event(evsel)) {
+		attr->sample_regs_intr = opts->sample_intr_regs[0];
+		memcpy(attr->sample_regs_intr_ext, &opts->sample_intr_regs[1],
+		       PERF_NUM_EXT_REGS / 8);
 		evsel__set_sample_bit(evsel, REGS_INTR);
 	}
 
-	if (opts->sample_user_regs && !evsel->no_aux_samples &&
-	    !evsel__is_dummy_event(evsel)) {
-		attr->sample_regs_user |= opts->sample_user_regs;
+	if (bitmap_weight(opts->sample_user_regs, PERF_SAMPLE_REGS_NUM) &&
+	    !evsel->no_aux_samples && !evsel__is_dummy_event(evsel)) {
+		attr->sample_regs_user |= opts->sample_user_regs[0];
+		memcpy(attr->sample_regs_user_ext, &opts->sample_user_regs[1],
+		       PERF_NUM_EXT_REGS / 8);
 		evsel__set_sample_bit(evsel, REGS_USER);
 	}
 
@@ -3172,10 +3176,16 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 
 		if (data->user_regs.abi) {
 			u64 mask = evsel->core.attr.sample_regs_user;
+			unsigned long *mask_ext =
+				(unsigned long *)evsel->core.attr.sample_regs_user_ext;
+			u64 *user_regs_mask;
 
 			sz = hweight64(mask) * sizeof(u64);
+			sz += bitmap_weight(mask_ext, PERF_NUM_EXT_REGS) * sizeof(u64);
 			OVERFLOW_CHECK(array, sz, max_size);
 			data->user_regs.mask = mask;
+			user_regs_mask = (u64 *)&data->user_regs.mask_ext;
+			memcpy(&user_regs_mask[1], mask_ext, PERF_NUM_EXT_REGS);
 			data->user_regs.regs = (u64 *)array;
 			array = (void *)array + sz;
 		}
@@ -3228,10 +3238,16 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 
 		if (data->intr_regs.abi != PERF_SAMPLE_REGS_ABI_NONE) {
 			u64 mask = evsel->core.attr.sample_regs_intr;
+			unsigned long *mask_ext =
+				(unsigned long *)evsel->core.attr.sample_regs_intr_ext;
+			u64 *intr_regs_mask;
 
 			sz = hweight64(mask) * sizeof(u64);
+			sz += bitmap_weight(mask_ext, PERF_NUM_EXT_REGS) * sizeof(u64);
 			OVERFLOW_CHECK(array, sz, max_size);
 			data->intr_regs.mask = mask;
+			intr_regs_mask = (u64 *)&data->intr_regs.mask_ext;
+			memcpy(&intr_regs_mask[1], mask_ext, PERF_NUM_EXT_REGS);
 			data->intr_regs.regs = (u64 *)array;
 			array = (void *)array + sz;
 		}
diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse-regs-options.c
index 3dcd8dc4f81b..42b176705ccf 100644
--- a/tools/perf/util/parse-regs-options.c
+++ b/tools/perf/util/parse-regs-options.c
@@ -12,11 +12,13 @@
 static int
 __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 {
+	unsigned int size = PERF_SAMPLE_REGS_NUM;
 	uint64_t *mode = (uint64_t *)opt->value;
 	const struct sample_reg *r = NULL;
 	char *s, *os = NULL, *p;
 	int ret = -1;
-	uint64_t mask = 0;
+	DECLARE_BITMAP(mask, size);
+	DECLARE_BITMAP(mask_tmp, size);
 
 	if (unset)
 		return 0;
@@ -24,13 +26,14 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 	/*
 	 * cannot set it twice
 	 */
-	if (*mode)
+	if (bitmap_weight((unsigned long *)mode, size))
 		return -1;
 
+	bitmap_zero(mask, size);
 	if (intr)
-		arch__intr_reg_mask((unsigned long *)&mask);
+		arch__intr_reg_mask(mask);
 	else
-		arch__user_reg_mask((unsigned long *)&mask);
+		arch__user_reg_mask(mask);
 
 	/* str may be NULL in case no arg is passed to -I */
 	if (str) {
@@ -47,7 +50,8 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 			if (!strcmp(s, "?")) {
 				fprintf(stderr, "available registers: ");
 				for (r = arch__sample_reg_masks(); r->name; r++) {
-					if (r->mask & mask)
+					bitmap_and(mask_tmp, mask, r->mask_ext, size);
+					if (bitmap_weight(mask_tmp, size))
 						fprintf(stderr, "%s ", r->name);
 				}
 				fputc('\n', stderr);
@@ -55,7 +59,8 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 				goto error;
 			}
 			for (r = arch__sample_reg_masks(); r->name; r++) {
-				if ((r->mask & mask) && !strcasecmp(s, r->name))
+				bitmap_and(mask_tmp, mask, r->mask_ext, size);
+				if (bitmap_weight(mask_tmp, size) && !strcasecmp(s, r->name))
 					break;
 			}
 			if (!r || !r->name) {
@@ -64,7 +69,7 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 				goto error;
 			}
 
-			*mode |= r->mask;
+			bitmap_or((unsigned long *)mode, (unsigned long *)mode, r->mask_ext, size);
 
 			if (!p)
 				break;
@@ -75,8 +80,8 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 	ret = 0;
 
 	/* default to all possible regs */
-	if (*mode == 0)
-		*mode = mask;
+	if (!bitmap_weight((unsigned long *)mode, size))
+		bitmap_or((unsigned long *)mode, (unsigned long *)mode, mask, size);
 error:
 	free(os);
 	return ret;
diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
index 316d280e5cd7..d60a74623a0f 100644
--- a/tools/perf/util/perf_regs.h
+++ b/tools/perf/util/perf_regs.h
@@ -4,18 +4,32 @@
 
 #include <linux/types.h>
 #include <linux/compiler.h>
+#include <linux/bitmap.h>
+#include <linux/perf_event.h>
+#include "util/record.h"
 
 struct regs_dump;
 
 struct sample_reg {
 	const char *name;
-	uint64_t mask;
+	union {
+		uint64_t mask;
+		DECLARE_BITMAP(mask_ext, PERF_SAMPLE_REGS_NUM);
+	};
 };
 
 #define SMPL_REG_MASK(b) (1ULL << (b))
 #define SMPL_REG(n, b) { .name = #n, .mask = SMPL_REG_MASK(b) }
 #define SMPL_REG2_MASK(b) (3ULL << (b))
 #define SMPL_REG2(n, b) { .name = #n, .mask = SMPL_REG2_MASK(b) }
+#define SMPL_REG_EXT(n, b)	\
+	{ .name = #n, .mask_ext[b / __BITS_PER_LONG] = 0x1ULL << (b % __BITS_PER_LONG) }
+#define SMPL_REG2_EXT(n, b)	\
+	{ .name = #n, .mask_ext[b / __BITS_PER_LONG] = 0x3ULL << (b % __BITS_PER_LONG) }
+#define SMPL_REG4_EXT(n, b)	\
+	{ .name = #n, .mask_ext[b / __BITS_PER_LONG] = 0xfULL << (b % __BITS_PER_LONG) }
+#define SMPL_REG8_EXT(n, b)	\
+	{ .name = #n, .mask_ext[b / __BITS_PER_LONG] = 0xffULL << (b % __BITS_PER_LONG) }
 #define SMPL_REG_END { .name = NULL }
 
 enum {
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index a6566134e09e..2741bbbc2794 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -57,8 +57,8 @@ struct record_opts {
 	unsigned int  auxtrace_mmap_pages;
 	unsigned int  user_freq;
 	u64	      branch_stack;
-	u64	      sample_intr_regs;
-	u64	      sample_user_regs;
+	u64	      sample_intr_regs[PERF_SAMPLE_ARRAY_SIZE];
+	u64	      sample_user_regs[PERF_SAMPLE_ARRAY_SIZE];
 	u64	      default_interval;
 	u64	      user_interval;
 	size_t	      auxtrace_snapshot_size;
diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
index 70b2c3135555..a0bb7ba4b0c1 100644
--- a/tools/perf/util/sample.h
+++ b/tools/perf/util/sample.h
@@ -4,13 +4,17 @@
 
 #include <linux/perf_event.h>
 #include <linux/types.h>
+#include <linux/bitmap.h>
 
 /* number of register is bound by the number of bits in regs_dump::mask (64) */
 #define PERF_SAMPLE_REGS_CACHE_SIZE (8 * sizeof(u64))
 
 struct regs_dump {
 	u64 abi;
-	u64 mask;
+	union {
+		u64 mask;
+		DECLARE_BITMAP(mask_ext, PERF_SAMPLE_REGS_NUM);
+	};
 	u64 *regs;
 
 	/* Cached values/mask filled by first register access. */
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index c06e3020a976..ef42dbff82fc 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -910,12 +910,13 @@ static void branch_stack__printf(struct perf_sample *sample,
 	}
 }
 
-static void regs_dump__printf(u64 mask, u64 *regs, const char *arch)
+static void regs_dump__printf(struct regs_dump *regs, const char *arch)
 {
+	unsigned int size = PERF_SAMPLE_REGS_NUM;
 	unsigned rid, i = 0;
 
-	for_each_set_bit(rid, (unsigned long *) &mask, sizeof(mask) * 8) {
-		u64 val = regs[i++];
+	for_each_set_bit(rid, regs->mask_ext, size) {
+		u64 val = regs->regs[i++];
 
 		printf(".... %-5s 0x%016" PRIx64 "\n",
 		       perf_reg_name(rid, arch), val);
@@ -936,16 +937,20 @@ static inline const char *regs_dump_abi(struct regs_dump *d)
 	return regs_abi[d->abi];
 }
 
-static void regs__printf(const char *type, struct regs_dump *regs, const char *arch)
+static void regs__printf(bool intr, struct regs_dump *regs, const char *arch)
 {
-	u64 mask = regs->mask;
+	u64 *mask = (u64 *)&regs->mask_ext;
 
-	printf("... %s regs: mask 0x%" PRIx64 " ABI %s\n",
-	       type,
-	       mask,
-	       regs_dump_abi(regs));
+	if (intr)
+		printf("... intr regs: mask 0x");
+	else
+		printf("... user regs: mask 0x");
+
+	for (int i = 0; i < PERF_SAMPLE_ARRAY_SIZE; i++)
+		printf("%" PRIx64 "", mask[i]);
+	printf(" ABI %s\n", regs_dump_abi(regs));
 
-	regs_dump__printf(mask, regs->regs, arch);
+	regs_dump__printf(regs, arch);
 }
 
 static void regs_user__printf(struct perf_sample *sample, const char *arch)
@@ -953,7 +958,7 @@ static void regs_user__printf(struct perf_sample *sample, const char *arch)
 	struct regs_dump *user_regs = &sample->user_regs;
 
 	if (user_regs->regs)
-		regs__printf("user", user_regs, arch);
+		regs__printf(false, user_regs, arch);
 }
 
 static void regs_intr__printf(struct perf_sample *sample, const char *arch)
@@ -961,7 +966,7 @@ static void regs_intr__printf(struct perf_sample *sample, const char *arch)
 	struct regs_dump *intr_regs = &sample->intr_regs;
 
 	if (intr_regs->regs)
-		regs__printf("intr", intr_regs, arch);
+		regs__printf(true, intr_regs, arch);
 }
 
 static void stack_user__printf(struct stack_dump *dump)
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 6923b0d5efed..5d124e55167d 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1538,7 +1538,8 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
 	if (type & PERF_SAMPLE_REGS_INTR) {
 		if (sample->intr_regs.abi) {
 			result += sizeof(u64);
-			sz = hweight64(sample->intr_regs.mask) * sizeof(u64);
+			sz = bitmap_weight(sample->intr_regs.mask_ext,
+					   PERF_SAMPLE_REGS_NUM) * sizeof(u64);
 			result += sz;
 		} else {
 			result += sizeof(u64);
@@ -1745,7 +1746,8 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_fo
 	if (type & PERF_SAMPLE_REGS_INTR) {
 		if (sample->intr_regs.abi) {
 			*array++ = sample->intr_regs.abi;
-			sz = hweight64(sample->intr_regs.mask) * sizeof(u64);
+			sz = bitmap_weight(sample->intr_regs.mask_ext,
+					   PERF_SAMPLE_REGS_NUM) * sizeof(u64);
 			memcpy(array, sample->intr_regs.regs, sz);
 			array = (void *)array + sz;
 		} else {
-- 
2.40.1

