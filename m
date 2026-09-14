Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6AF2F8EBB;
	Mon, 14 Sep 2026 01:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789350479; cv=none; b=kifc8XU1k7tFnwtvfaK8knd1Q2e8Y1hJzzbkfyEzNlY70BSilKGo0O/nYPo2rfWlmKlMOrGAkpLEZXd1vm9erqjmnMGkRKzHQfGEb65bo1DRAvLeiujcQJpJfL8q1KgJTvcl2Cft8BKOIOyLVTTUdsD1ZhWbfbxMx2J4XNDHGW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789350479; c=relaxed/simple;
	bh=hxWbAZH06gvlzSfnoQ7oGbd94BGf5H3UBzJQLwn7qSs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qkZ5jaTENpCDILWbObkW0mzUpHma+zr1JK4s8+Adgh3PYqArI8ybI0xXRG942M5VrgUj/kO9YuhMcYYjGGlqlTa4APNWeOLH+jsKzOgxQZv6miEhKFSAMbe390erAEUXJqVYek7oADHgWzeghqkOJ5BRz6H9awiPBZnIUh4IQuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZDuxG515; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZDuxG515"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789350473; x=1820886473;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hxWbAZH06gvlzSfnoQ7oGbd94BGf5H3UBzJQLwn7qSs=;
  b=ZDuxG5157a3/PMBRy/4RCSGwMX8NFNMczbDCDQeHmqMrFakesAgm+cZk
   nZhhJB/fIQJaROkx1I7m5y/BbV7MZ/4fhl+7g52q/Yg9fZdcu8QsvLHqQ
   iFFJh3I/IpPqm8MsrUWdhkPu7RbS11AKVVZssn/0xm0Dy/PKzVOIEmo9e
   UZFyoPijPfpaLP+9fv7toyB9lRjbeITCMvJsEuaFaXQGYxlVGzK/amfxy
   7goXj8LbXHyoq9BBasPHpMUbJwk6fUAgiv3mpkIYlw8HUbZ5By8hXDz6l
   c0nSHIgsiH5AguZQ7kxp2kVrCSRqNPpCBHm3HI05c5T8tovMtDw6Q9SxM
   w==;
X-CSE-ConnectionGUID: 0bxDZsfOS7yVPsT5Q1IhUA==
X-CSE-MsgGUID: 8BfJNNtlTquTHGQ7hmILIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="93530645"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="93530645"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2026 18:47:52 -0700
X-CSE-ConnectionGUID: 47XfN6WnQhO/gL6qe9UbKw==
X-CSE-MsgGUID: tnbkWk4xSR23sfrwCYyHHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="276664181"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa005.jf.intel.com with ESMTP; 13 Sep 2026 18:47:49 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v11 05/10] perf regs: Support x86 eGPRs/SSP sampling
Date: Mon, 14 Sep 2026 09:40:44 +0800
Message-Id: <20260914014049.2061519-6-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914014049.2061519-1-dapeng1.mi@linux.intel.com>
References: <20260914014049.2061519-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for sampling x86 extended GP registers (R16-R31) and the
shadow stack pointer (SSP) register.

The original XMM registers space in sample_regs_user/sample_regs_intr is
reclaimed to represent the eGPRs and SSP when SIMD registers sampling is
supported with the new SIMD sampling fields in the perf_event_attr
structure. This necessitates a way to distinguish which register layout
is used for the sample_regs_user/sample_regs_intr bitmap.

To address this, a new "abi" argument is added to the helpers
perf_intr_reg_mask(), perf_user_reg_mask(), and perf_reg_name(). When
"abi & PERF_SAMPLE_REGS_ABI_SIMD" is true, it indicates the eGPRs and SSP
layout is represented; otherwise, the legacy XMM registers are
represented.

Please note that PERF_SAMPLE_REGS_ABI_SIMD is set by default on platforms
that support SIMD register sampling, even when no eGPR or SSP register is
requested (for example, -Iax). As a result, sample_regs_intr and
sample_regs_usr always use the new GPR layout on platforms with SIMD
register sampling support.

The patch only supports eGPRs and SSP sampling, the complete SIMD
registers sampling would be supported in the next patch.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/builtin-script.c                   |   2 +-
 tools/perf/util/evsel.c                       |  27 +++-
 tools/perf/util/evsel.h                       |   7 +
 tools/perf/util/parse-regs-options.c          |  35 +++--
 .../perf/util/perf-regs-arch/perf_regs_x86.c  | 124 +++++++++++++++---
 tools/perf/util/perf_regs.c                   |  12 +-
 tools/perf/util/perf_regs.h                   |  10 +-
 tools/perf/util/record.h                      |   7 +
 .../scripting-engines/trace-event-python.c    |   2 +-
 tools/perf/util/session.c                     |  13 +-
 tools/perf/util/synthetic-events.c            |   4 +
 11 files changed, 198 insertions(+), 45 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index ad8ca08ceb5f..ec3ce841b33e 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -734,7 +734,7 @@ static int perf_sample__fprintf_regs(struct regs_dump *regs, uint64_t mask,
 	for_each_set_bit(r, (unsigned long *) &mask, sizeof(mask) * 8) {
 		u64 val = regs->regs[i++];
 		printed += fprintf(fp, "%5s:0x%"PRIx64" ",
-				   perf_reg_name(r, e_machine, e_flags),
+				   perf_reg_name(r, e_machine, e_flags, regs->abi),
 				   val);
 	}
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ce429eb247b6..bcd919c6bde8 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1125,19 +1125,22 @@ static void __evsel__config_callchain(struct evsel *evsel, const struct record_o
 	}
 
 	if (param->record_mode == CALLCHAIN_DWARF) {
+		int abi = -1; /* -1 indicates only basic GPRs are needed. */
+
 		if (!function) {
 			uint16_t e_machine = evsel__e_machine(evsel, /*e_flags=*/NULL);
 
 			evsel__set_sample_bit(evsel, REGS_USER);
 			evsel__set_sample_bit(evsel, STACK_USER);
 			if (opts->sample_user_regs &&
-			    DWARF_MINIMAL_REGS(e_machine) != perf_user_reg_mask(EM_HOST)) {
+			    DWARF_MINIMAL_REGS(e_machine) != perf_user_reg_mask(EM_HOST, &abi)) {
 				attr->sample_regs_user |= DWARF_MINIMAL_REGS(e_machine);
 				pr_warning("WARNING: The use of --call-graph=dwarf may require all the user registers, "
 					   "specifying a subset with --user-regs may render DWARF unwinding unreliable, "
 					   "so the minimal registers set (IP, SP) is explicitly forced.\n");
 			} else {
-				attr->sample_regs_user |= perf_user_reg_mask(EM_HOST);
+				abi = -1;
+				attr->sample_regs_user |= perf_user_reg_mask(EM_HOST, &abi);
 			}
 			attr->sample_stack_user = param->dump_size;
 			attr->exclude_callchain_user = 1;
@@ -1663,12 +1666,18 @@ void evsel__config(struct evsel *evsel, const struct record_opts *opts,
 	if (opts->sample_intr_regs && !evsel->no_aux_samples &&
 	    !evsel__is_dummy_event(evsel)) {
 		attr->sample_regs_intr = opts->sample_intr_regs;
+		attr->sample_simd_regs_enabled =
+			evsel__is_non_software_event(evsel) ?
+				!!opts->sample_simd_regs_enabled : 0;
 		evsel__set_sample_bit(evsel, REGS_INTR);
 	}
 
 	if (opts->sample_user_regs && !evsel->no_aux_samples &&
 	    !evsel__is_dummy_event(evsel)) {
 		attr->sample_regs_user |= opts->sample_user_regs;
+		attr->sample_simd_regs_enabled =
+			evsel__is_non_software_event(evsel) ?
+				!!opts->sample_simd_regs_enabled : 0;
 		evsel__set_sample_bit(evsel, REGS_USER);
 	}
 
@@ -3683,6 +3692,13 @@ int __evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 			regs->mask = mask;
 			regs->regs = (u64 *)array;
 			array = (void *)array + sz;
+
+			if (regs->abi & PERF_SAMPLE_REGS_ABI_SIMD) {
+				/* Skip SIMD-regs header. */
+				sz = 4 * sizeof(u64);
+				OVERFLOW_CHECK(array, sz, max_size);
+				array = (void *)array + sz;
+			}
 		}
 	}
 
@@ -3740,6 +3756,13 @@ int __evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 			regs->mask = mask;
 			regs->regs = (u64 *)array;
 			array = (void *)array + sz;
+
+			if (regs->abi & PERF_SAMPLE_REGS_ABI_SIMD) {
+				/* Skip SIMD-regs header. */
+				sz = 4 * sizeof(u64);
+				OVERFLOW_CHECK(array, sz, max_size);
+				array = (void *)array + sz;
+			}
 		}
 	}
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index d9ecc6628217..6f759b0e86e9 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -587,6 +587,13 @@ static inline bool evsel__is_dummy_event(struct evsel *evsel)
 	       (evsel->core.attr.config == PERF_COUNT_SW_DUMMY);
 }
 
+static inline bool evsel__is_non_software_event(struct evsel *evsel)
+{
+	return (evsel->core.attr.type != PERF_TYPE_SOFTWARE) &&
+	       (evsel->core.attr.type != PERF_TYPE_TRACEPOINT) &&
+	       (evsel->core.attr.type != PERF_TYPE_BREAKPOINT);
+}
+
 struct perf_session *evsel__session(struct evsel *evsel);
 struct perf_env *evsel__env(struct evsel *evsel);
 uint16_t evsel__e_machine(struct evsel *evsel, uint32_t *e_flags);
diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse-regs-options.c
index c93c2f0c8105..70a1cc90b2c1 100644
--- a/tools/perf/util/parse-regs-options.c
+++ b/tools/perf/util/parse-regs-options.c
@@ -6,11 +6,14 @@
 #include <stdio.h>
 #include "util/debug.h"
 #include <dwarf-regs.h>
+#include <sys/param.h>
 #include <subcmd/parse-options.h>
 #include "util/perf_regs.h"
 #include "util/parse-regs-options.h"
+#include "record.h"
 
-static void list_perf_regs(FILE *fp, uint64_t mask)
+static void
+list_perf_regs(FILE *fp, uint64_t mask, int abi)
 {
 	const char *last_name = NULL;
 
@@ -21,7 +24,7 @@ static void list_perf_regs(FILE *fp, uint64_t mask)
 		if (((1ULL << reg) & mask) == 0)
 			continue;
 
-		name = perf_reg_name(reg, EM_HOST, EF_HOST);
+		name = perf_reg_name(reg, EM_HOST, EF_HOST, abi);
 		if (name && (!last_name || strcmp(last_name, name)))
 			fprintf(fp, "%s%s", reg > 0 ? " " : "", name);
 		last_name = name;
@@ -29,7 +32,8 @@ static void list_perf_regs(FILE *fp, uint64_t mask)
 	fputc('\n', fp);
 }
 
-static uint64_t name_to_perf_reg_mask(const char *to_match, uint64_t mask)
+static uint64_t
+name_to_perf_reg_mask(const char *to_match, uint64_t mask, int abi)
 {
 	uint64_t reg_mask = 0;
 
@@ -39,7 +43,7 @@ static uint64_t name_to_perf_reg_mask(const char *to_match, uint64_t mask)
 		if (((1ULL << reg) & mask) == 0)
 			continue;
 
-		name = perf_reg_name(reg, EM_HOST, EF_HOST);
+		name = perf_reg_name(reg, EM_HOST, EF_HOST, abi);
 		if (!name)
 			continue;
 
@@ -53,9 +57,12 @@ static int
 __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 {
 	uint64_t *mode = (uint64_t *)opt->value;
+	struct record_opts *opts;
 	char *s, *os = NULL, *p;
+	const char *warn;
 	int ret = -1;
 	uint64_t mask;
+	int abi = 0;
 
 	if (unset)
 		return 0;
@@ -66,11 +73,16 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 	if (*mode)
 		return -1;
 
-	mask = intr ? perf_intr_reg_mask(EM_HOST) : perf_user_reg_mask(EM_HOST);
+	mask = intr ? perf_intr_reg_mask(EM_HOST, &abi) :
+		      perf_user_reg_mask(EM_HOST, &abi);
+	opts = intr ? container_of(opt->value, struct record_opts, sample_intr_regs) :
+		      container_of(opt->value, struct record_opts, sample_user_regs);
 
 	/* str may be NULL in case no arg is passed to -I */
 	if (!str) {
 		*mode = mask;
+		if (abi & PERF_SAMPLE_REGS_ABI_SIMD)
+			opts->sample_simd_regs_enabled = 1;
 		return 0;
 	}
 
@@ -79,6 +91,7 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 	if (!s)
 		return -1;
 
+	warn = "Unknown register \"%s\", check man page or run \"perf record %s?\"\n";
 	for (;;) {
 		uint64_t reg_mask;
 
@@ -87,14 +100,16 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 			*p = '\0';
 
 		if (!strcmp(s, "?")) {
-			list_perf_regs(stderr, mask);
+			list_perf_regs(stderr, mask, abi);
 			goto error;
 		}
 
-		reg_mask = name_to_perf_reg_mask(s, mask);
-		if (reg_mask == 0) {
-			ui__warning("Unknown register \"%s\", check man page or run \"perf record %s?\"\n",
-				s, intr ? "-I" : "--user-regs=");
+		reg_mask = name_to_perf_reg_mask(s, mask, abi);
+		if (reg_mask) {
+			if (abi & PERF_SAMPLE_REGS_ABI_SIMD)
+				opts->sample_simd_regs_enabled = 1;
+		} else {
+			ui__warning(warn, s, intr ? "-I" : "--user-regs=");
 			goto error;
 		}
 		*mode |= reg_mask;
diff --git a/tools/perf/util/perf-regs-arch/perf_regs_x86.c b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
index b6d20522b4e8..ae26d991cdc9 100644
--- a/tools/perf/util/perf-regs-arch/perf_regs_x86.c
+++ b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
@@ -235,26 +235,26 @@ int __perf_sdt_arg_parse_op_x86(char *old_op, char **new_op)
 	return SDT_ARG_VALID;
 }
 
-uint64_t __perf_reg_mask_x86(bool intr)
+static uint64_t __arch__reg_mask(u64 sample_type, u64 mask, bool has_simd_regs)
 {
 	struct perf_event_attr attr = {
-		.type			= PERF_TYPE_HARDWARE,
-		.config			= PERF_COUNT_HW_CPU_CYCLES,
-		.sample_type		= PERF_SAMPLE_REGS_INTR,
-		.sample_regs_intr	= PERF_REG_EXTENDED_MASK,
-		.precise_ip		= 1,
-		.disabled		= 1,
-		.exclude_kernel		= 1,
+		.type				= PERF_TYPE_HARDWARE,
+		.config				= PERF_COUNT_HW_CPU_CYCLES,
+		.sample_type			= sample_type,
+		.precise_ip			= 1,
+		.disabled			= 1,
+		.exclude_kernel			= 1,
+		.sample_simd_regs_enabled	= has_simd_regs,
 	};
 	int fd;
-
-	if (!intr)
-		return PERF_REGS_MASK;
-
 	/*
 	 * In an unnamed union, init it here to build on older gcc versions
 	 */
 	attr.sample_period = 1;
+	if (sample_type == PERF_SAMPLE_REGS_INTR)
+		attr.sample_regs_intr = mask;
+	else
+		attr.sample_regs_user = mask;
 
 	if (perf_pmus__num_core_pmus() > 1) {
 		struct perf_pmu *pmu = NULL;
@@ -276,13 +276,38 @@ uint64_t __perf_reg_mask_x86(bool intr)
 				 /*group_fd=*/-1, /*flags=*/0);
 	if (fd != -1) {
 		close(fd);
-		return (PERF_REG_EXTENDED_MASK | PERF_REGS_MASK);
+		return mask;
+	}
+
+	return 0;
+}
+
+uint64_t __perf_reg_mask_x86(bool intr, int *abi)
+{
+	u64 sample_type = intr ? PERF_SAMPLE_REGS_INTR : PERF_SAMPLE_REGS_USER;
+	uint64_t mask = PERF_REGS_MASK;
+
+	/* -1 indicates only basic GPRs are needed. */
+	if (*abi < 0)
+		return PERF_REGS_MASK;
+
+	*abi = 0;
+	mask |= __arch__reg_mask(sample_type,
+				 GENMASK_ULL(PERF_REG_X86_R31, PERF_REG_X86_R16),
+				 true);
+	mask |= __arch__reg_mask(sample_type, BIT_ULL(PERF_REG_X86_SSP), true);
+
+	if (mask != PERF_REGS_MASK) {
+		*abi |= PERF_SAMPLE_REGS_ABI_SIMD;
+	} else {
+		mask |= __arch__reg_mask(sample_type, PERF_REG_EXTENDED_MASK,
+					 false);
 	}
 
-	return PERF_REGS_MASK;
+	return mask;
 }
 
-const char *__perf_reg_name_x86(int id)
+static const char *__arch_reg_gpr_name(int id)
 {
 	switch (id) {
 	case PERF_REG_X86_AX:
@@ -333,7 +358,60 @@ const char *__perf_reg_name_x86(int id)
 		return "R14";
 	case PERF_REG_X86_R15:
 		return "R15";
+	default:
+		return NULL;
+	}
+
+	return NULL;
+}
 
+static const char *__arch_reg_egpr_name(int id)
+{
+	switch (id) {
+	case PERF_REG_X86_R16:
+		return "R16";
+	case PERF_REG_X86_R17:
+		return "R17";
+	case PERF_REG_X86_R18:
+		return "R18";
+	case PERF_REG_X86_R19:
+		return "R19";
+	case PERF_REG_X86_R20:
+		return "R20";
+	case PERF_REG_X86_R21:
+		return "R21";
+	case PERF_REG_X86_R22:
+		return "R22";
+	case PERF_REG_X86_R23:
+		return "R23";
+	case PERF_REG_X86_R24:
+		return "R24";
+	case PERF_REG_X86_R25:
+		return "R25";
+	case PERF_REG_X86_R26:
+		return "R26";
+	case PERF_REG_X86_R27:
+		return "R27";
+	case PERF_REG_X86_R28:
+		return "R28";
+	case PERF_REG_X86_R29:
+		return "R29";
+	case PERF_REG_X86_R30:
+		return "R30";
+	case PERF_REG_X86_R31:
+		return "R31";
+	case PERF_REG_X86_SSP:
+		return "SSP";
+	default:
+		return NULL;
+	}
+
+	return NULL;
+}
+
+static const char *__arch_reg_xmm_name(int id)
+{
+	switch (id) {
 #define XMM(x) \
 	case PERF_REG_X86_XMM ## x:	\
 	case PERF_REG_X86_XMM ## x + 1:	\
@@ -362,6 +440,22 @@ const char *__perf_reg_name_x86(int id)
 	return NULL;
 }
 
+const char *__perf_reg_name_x86(int id, int abi)
+{
+	const char *name;
+
+	name = __arch_reg_gpr_name(id);
+	if (name)
+		return name;
+
+	if (abi & PERF_SAMPLE_REGS_ABI_SIMD)
+		name = __arch_reg_egpr_name(id);
+	else
+		name = __arch_reg_xmm_name(id);
+
+	return name;
+}
+
 uint64_t __perf_reg_ip_x86(void)
 {
 	return PERF_REG_X86_IP;
diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
index 558c143abbab..089ededbae94 100644
--- a/tools/perf/util/perf_regs.c
+++ b/tools/perf/util/perf_regs.c
@@ -38,7 +38,7 @@ int perf_sdt_arg_parse_op(uint16_t e_machine, char *old_op, char **new_op)
 	return ret;
 }
 
-uint64_t perf_intr_reg_mask(uint16_t e_machine)
+uint64_t perf_intr_reg_mask(uint16_t e_machine, int *abi /*inout*/)
 {
 	uint64_t mask = 0;
 
@@ -70,7 +70,7 @@ uint64_t perf_intr_reg_mask(uint16_t e_machine)
 		break;
 	case EM_386:
 	case EM_X86_64:
-		mask = __perf_reg_mask_x86(/*intr=*/true);
+		mask = __perf_reg_mask_x86(/*intr=*/true, abi);
 		break;
 	default:
 		pr_debug("Unknown ELF machine %d, interrupt sampling register mask will be empty.\n",
@@ -81,7 +81,7 @@ uint64_t perf_intr_reg_mask(uint16_t e_machine)
 	return mask;
 }
 
-uint64_t perf_user_reg_mask(uint16_t e_machine)
+uint64_t perf_user_reg_mask(uint16_t e_machine, int *abi /*inout*/)
 {
 	uint64_t mask = 0;
 
@@ -113,7 +113,7 @@ uint64_t perf_user_reg_mask(uint16_t e_machine)
 		break;
 	case EM_386:
 	case EM_X86_64:
-		mask = __perf_reg_mask_x86(/*intr=*/false);
+		mask = __perf_reg_mask_x86(/*intr=*/false, abi);
 		break;
 	default:
 		pr_debug("Unknown ELF machine %d, user sampling register mask will be empty.\n",
@@ -124,7 +124,7 @@ uint64_t perf_user_reg_mask(uint16_t e_machine)
 	return mask;
 }
 
-const char *perf_reg_name(int id, uint16_t e_machine, uint32_t e_flags)
+const char *perf_reg_name(int id, uint16_t e_machine, uint32_t e_flags, int abi)
 {
 	const char *reg_name = NULL;
 
@@ -156,7 +156,7 @@ const char *perf_reg_name(int id, uint16_t e_machine, uint32_t e_flags)
 		break;
 	case EM_386:
 	case EM_X86_64:
-		reg_name = __perf_reg_name_x86(id);
+		reg_name = __perf_reg_name_x86(id, abi);
 		break;
 	default:
 		break;
diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
index 79be2b791509..1c78549127cc 100644
--- a/tools/perf/util/perf_regs.h
+++ b/tools/perf/util/perf_regs.h
@@ -13,10 +13,10 @@ enum {
 };
 
 int perf_sdt_arg_parse_op(uint16_t e_machine, char *old_op, char **new_op);
-uint64_t perf_intr_reg_mask(uint16_t e_machine);
-uint64_t perf_user_reg_mask(uint16_t e_machine);
+uint64_t perf_intr_reg_mask(uint16_t e_machine, int *abi /*inout*/);
+uint64_t perf_user_reg_mask(uint16_t e_machine, int *abi /*inout*/);
 
-const char *perf_reg_name(int id, uint16_t e_machine, uint32_t e_flags);
+const char *perf_reg_name(int id, uint16_t e_machine, uint32_t e_flags, int abi);
 int perf_reg_value(u64 *valp, struct regs_dump *regs, int id);
 uint64_t perf_arch_reg_ip(uint16_t e_machine);
 uint64_t perf_arch_reg_sp(uint16_t e_machine);
@@ -66,8 +66,8 @@ uint64_t __perf_reg_sp_s390(void);
 int __perf_sdt_arg_parse_op_s390(char *old_op, char **new_op);
 
 int __perf_sdt_arg_parse_op_x86(char *old_op, char **new_op);
-uint64_t __perf_reg_mask_x86(bool intr);
-const char *__perf_reg_name_x86(int id);
+uint64_t __perf_reg_mask_x86(bool intr, int *abi);
+const char *__perf_reg_name_x86(int id, int abi);
 uint64_t __perf_reg_ip_x86(void);
 uint64_t __perf_reg_sp_x86(void);
 
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index 93627c9a7338..411bb7276ad7 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -62,6 +62,13 @@ struct record_opts {
 	u64	      branch_stack;
 	u64	      sample_intr_regs;
 	u64	      sample_user_regs;
+	u16	      sample_simd_regs_enabled;
+	u16	      sample_vec_reg_qwords;
+	u16	      sample_pred_reg_qwords;
+	u32	      sample_intr_pred_regs;
+	u32	      sample_user_pred_regs;
+	u64	      sample_intr_vec_regs;
+	u64	      sample_user_vec_regs;
 	u64	      default_interval;
 	u64	      user_interval;
 	size_t	      auxtrace_snapshot_size;
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 7e8e3a7df1b1..11877b56548f 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -730,7 +730,7 @@ static void regs_map(struct regs_dump *regs, uint64_t mask, uint16_t e_machine,
 
 		printed += scnprintf(bf + printed, size - printed,
 				     "%5s:0x%" PRIx64 " ",
-				     perf_reg_name(r, e_machine, e_flags), val);
+				     perf_reg_name(r, e_machine, e_flags, regs->abi), val);
 	}
 }
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index c7ac0e7c5c04..90d4e45f09f0 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1433,15 +1433,16 @@ static void branch_stack__printf(struct perf_sample *sample,
 	}
 }
 
-static void regs_dump__printf(u64 mask, u64 *regs, uint16_t e_machine, uint32_t e_flags)
+static void regs_dump__printf(u64 mask, struct regs_dump *regs,
+			      uint16_t e_machine, uint32_t e_flags)
 {
 	unsigned rid, i = 0;
 
 	for_each_set_bit(rid, (unsigned long *) &mask, sizeof(mask) * 8) {
-		u64 val = regs[i++];
+		u64 val = regs->regs[i++];
 
 		printf(".... %-5s 0x%016" PRIx64 "\n",
-		       perf_reg_name(rid, e_machine, e_flags), val);
+		       perf_reg_name(rid, e_machine, e_flags, regs->abi), val);
 	}
 }
 
@@ -1449,11 +1450,13 @@ static const char *regs_abi[] = {
 	[PERF_SAMPLE_REGS_ABI_NONE] = "none",
 	[PERF_SAMPLE_REGS_ABI_32] = "32-bit",
 	[PERF_SAMPLE_REGS_ABI_64] = "64-bit",
+	[PERF_SAMPLE_REGS_ABI_SIMD | PERF_SAMPLE_REGS_ABI_32] = "32-bit SIMD",
+	[PERF_SAMPLE_REGS_ABI_SIMD | PERF_SAMPLE_REGS_ABI_64] = "64-bit SIMD",
 };
 
 static inline const char *regs_dump_abi(struct regs_dump *d)
 {
-	if (d->abi > PERF_SAMPLE_REGS_ABI_64)
+	if (d->abi >= ARRAY_SIZE(regs_abi) || !regs_abi[d->abi])
 		return "unknown";
 
 	return regs_abi[d->abi];
@@ -1469,7 +1472,7 @@ static void regs__printf(const char *type, struct regs_dump *regs,
 	       mask,
 	       regs_dump_abi(regs));
 
-	regs_dump__printf(mask, regs->regs, e_machine, e_flags);
+	regs_dump__printf(mask, regs, e_machine, e_flags);
 }
 
 static void regs_user__printf(struct perf_sample *sample, uint16_t e_machine, uint32_t e_flags)
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 0c150193cca8..2779f63a442c 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1644,6 +1644,8 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
 		if (sample->user_regs && sample->user_regs->abi) {
 			result += sizeof(u64);
 			sz = hweight64(sample->user_regs->mask) * sizeof(u64);
+			if (sample->user_regs->abi & PERF_SAMPLE_REGS_ABI_SIMD)
+				sz += 4 * sizeof(u64);
 			result += sz;
 		} else {
 			result += sizeof(u64);
@@ -1672,6 +1674,8 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
 		if (sample->intr_regs && sample->intr_regs->abi) {
 			result += sizeof(u64);
 			sz = hweight64(sample->intr_regs->mask) * sizeof(u64);
+			if (sample->intr_regs->abi & PERF_SAMPLE_REGS_ABI_SIMD)
+				sz += 4 * sizeof(u64);
 			result += sz;
 		} else {
 			result += sizeof(u64);
-- 
2.34.1

