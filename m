Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E76372ECD;
	Tue, 24 Mar 2026 01:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774314092; cv=none; b=eOHdXBDirDW6o8FzTShWqDejUGPDk8PD41SJhPFfIH/h+zsh2j8ZCqGAeIKslfNiclVXunb5w2o/4FK+zUvl5YYchcRU1rV+WnIMd/hIcVPB28y/bT/JejspK16GwXzzqstZJICeCETkaMWQpwedbi2mjt6enrTqVvsYJoz/IGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774314092; c=relaxed/simple;
	bh=G8khddG3CHnvakJ5FMPCmUyJSjB8cRGMzNe6c/XuBB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rXrwXfrP7gVu3+l81UvhkKL7DNlDHPdyTFBPNvVBb3GcVeVo8wcC609OJ3MTYMxd7seMDCeUQ0JqVqw+H24ZA13cTKRgDpEem0EeCiQmi+wTurMJ6+97pYn1w8m1e9oaXuz9LVTjnk6Y7JsinpegnaMOohcXUJqhDveFjlmLmC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RozvbNxq; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RozvbNxq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774314091; x=1805850091;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G8khddG3CHnvakJ5FMPCmUyJSjB8cRGMzNe6c/XuBB0=;
  b=RozvbNxqAlQvDVZa/7QFsXZkEAe/HReDI4QxWEt6naX+tH6a5ck1tra0
   BMHcOePi5m9gu9FJlOHldkrRVrpP8Wy9ZOgZvz6Wo0rV+BZi87OGb4Uae
   9DNPOCxxv9oKGhnq+Wbs4VDZkVLv651IJ47wyvYlgIB8yj5Mkqf4rnmrp
   7S7aGkN68IrKD1I4VkIJ5h1u8FEw8GCztbpVpoaN7Ub/lSFQXwYkG7eHY
   TfG+j2OeTtDvsXh1F2jxkHTUSDzOBeqd4gMyjSyHM/vvIUejFZtlsuVyF
   4Tc7XK3tx2ZNVn089e/3feP4l8twp9jXeLpsLLNB8DozMneiO0R7oX5KT
   g==;
X-CSE-ConnectionGUID: NjlBfH2ZQaWLOGVu0yb1Ig==
X-CSE-MsgGUID: 3WnPa6W1SBmtnBXH4XQRJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75441713"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="75441713"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 18:01:30 -0700
X-CSE-ConnectionGUID: kEvackkHR++WAA+851lwxw==
X-CSE-MsgGUID: wIJnNWVkT9OqwJ18eLcEbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="228263266"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa003.jf.intel.com with ESMTP; 23 Mar 2026 18:01:24 -0700
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
Subject: [Patch v7 2/4] perf regs: Support x86 eGPRs/SSP sampling
Date: Tue, 24 Mar 2026 08:57:04 +0800
Message-Id: <20260324005706.3778057-3-dapeng1.mi@linux.intel.com>
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

This patch adds support for sampling x86 extended GP registers (R16-R31)
and the shadow stack pointer (SSP) register.

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

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---

V7: Limit dwarf minimal regs to legacy GPRs (excluding APX eGPRs).

 tools/perf/builtin-script.c                   |   2 +-
 tools/perf/util/evsel.c                       |   7 +-
 tools/perf/util/parse-regs-options.c          |  17 ++-
 .../perf/util/perf-regs-arch/perf_regs_x86.c  | 124 +++++++++++++++---
 tools/perf/util/perf_regs.c                   |  12 +-
 tools/perf/util/perf_regs.h                   |  10 +-
 .../scripting-engines/trace-event-python.c    |   2 +-
 tools/perf/util/session.c                     |   9 +-
 8 files changed, 142 insertions(+), 41 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index b80c406d1fc1..714528732e02 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -730,7 +730,7 @@ static int perf_sample__fprintf_regs(struct regs_dump *regs, uint64_t mask,
 	for_each_set_bit(r, (unsigned long *) &mask, sizeof(mask) * 8) {
 		u64 val = regs->regs[i++];
 		printed += fprintf(fp, "%5s:0x%"PRIx64" ",
-				   perf_reg_name(r, e_machine, e_flags),
+				   perf_reg_name(r, e_machine, e_flags, regs->abi),
 				   val);
 	}
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 5a294595a677..f565ef2eb476 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1054,19 +1054,22 @@ static void __evsel__config_callchain(struct evsel *evsel, const struct record_o
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
diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse-regs-options.c
index c93c2f0c8105..6cf865bfc2f7 100644
--- a/tools/perf/util/parse-regs-options.c
+++ b/tools/perf/util/parse-regs-options.c
@@ -10,7 +10,8 @@
 #include "util/perf_regs.h"
 #include "util/parse-regs-options.h"
 
-static void list_perf_regs(FILE *fp, uint64_t mask)
+static void
+list_perf_regs(FILE *fp, uint64_t mask, int abi)
 {
 	const char *last_name = NULL;
 
@@ -21,7 +22,7 @@ static void list_perf_regs(FILE *fp, uint64_t mask)
 		if (((1ULL << reg) & mask) == 0)
 			continue;
 
-		name = perf_reg_name(reg, EM_HOST, EF_HOST);
+		name = perf_reg_name(reg, EM_HOST, EF_HOST, abi);
 		if (name && (!last_name || strcmp(last_name, name)))
 			fprintf(fp, "%s%s", reg > 0 ? " " : "", name);
 		last_name = name;
@@ -29,7 +30,8 @@ static void list_perf_regs(FILE *fp, uint64_t mask)
 	fputc('\n', fp);
 }
 
-static uint64_t name_to_perf_reg_mask(const char *to_match, uint64_t mask)
+static uint64_t
+name_to_perf_reg_mask(const char *to_match, uint64_t mask, int abi)
 {
 	uint64_t reg_mask = 0;
 
@@ -39,7 +41,7 @@ static uint64_t name_to_perf_reg_mask(const char *to_match, uint64_t mask)
 		if (((1ULL << reg) & mask) == 0)
 			continue;
 
-		name = perf_reg_name(reg, EM_HOST, EF_HOST);
+		name = perf_reg_name(reg, EM_HOST, EF_HOST, abi);
 		if (!name)
 			continue;
 
@@ -56,6 +58,7 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 	char *s, *os = NULL, *p;
 	int ret = -1;
 	uint64_t mask;
+	int abi = 0;
 
 	if (unset)
 		return 0;
@@ -66,7 +69,7 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 	if (*mode)
 		return -1;
 
-	mask = intr ? perf_intr_reg_mask(EM_HOST) : perf_user_reg_mask(EM_HOST);
+	mask = intr ? perf_intr_reg_mask(EM_HOST, &abi) : perf_user_reg_mask(EM_HOST, &abi);
 
 	/* str may be NULL in case no arg is passed to -I */
 	if (!str) {
@@ -87,11 +90,11 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 			*p = '\0';
 
 		if (!strcmp(s, "?")) {
-			list_perf_regs(stderr, mask);
+			list_perf_regs(stderr, mask, abi);
 			goto error;
 		}
 
-		reg_mask = name_to_perf_reg_mask(s, mask);
+		reg_mask = name_to_perf_reg_mask(s, mask, abi);
 		if (reg_mask == 0) {
 			ui__warning("Unknown register \"%s\", check man page or run \"perf record %s?\"\n",
 				s, intr ? "-I" : "--user-regs=");
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
index 5b8f34beb24e..afc567718bee 100644
--- a/tools/perf/util/perf_regs.c
+++ b/tools/perf/util/perf_regs.c
@@ -32,7 +32,7 @@ int perf_sdt_arg_parse_op(uint16_t e_machine, char *old_op, char **new_op)
 	return ret;
 }
 
-uint64_t perf_intr_reg_mask(uint16_t e_machine)
+uint64_t perf_intr_reg_mask(uint16_t e_machine, int *abi)
 {
 	uint64_t mask = 0;
 
@@ -64,7 +64,7 @@ uint64_t perf_intr_reg_mask(uint16_t e_machine)
 		break;
 	case EM_386:
 	case EM_X86_64:
-		mask = __perf_reg_mask_x86(/*intr=*/true);
+		mask = __perf_reg_mask_x86(/*intr=*/true, abi);
 		break;
 	default:
 		pr_debug("Unknown ELF machine %d, interrupt sampling register mask will be empty.\n",
@@ -75,7 +75,7 @@ uint64_t perf_intr_reg_mask(uint16_t e_machine)
 	return mask;
 }
 
-uint64_t perf_user_reg_mask(uint16_t e_machine)
+uint64_t perf_user_reg_mask(uint16_t e_machine, int *abi)
 {
 	uint64_t mask = 0;
 
@@ -107,7 +107,7 @@ uint64_t perf_user_reg_mask(uint16_t e_machine)
 		break;
 	case EM_386:
 	case EM_X86_64:
-		mask = __perf_reg_mask_x86(/*intr=*/false);
+		mask = __perf_reg_mask_x86(/*intr=*/false, abi);
 		break;
 	default:
 		pr_debug("Unknown ELF machine %d, user sampling register mask will be empty.\n",
@@ -118,7 +118,7 @@ uint64_t perf_user_reg_mask(uint16_t e_machine)
 	return mask;
 }
 
-const char *perf_reg_name(int id, uint16_t e_machine, uint32_t e_flags)
+const char *perf_reg_name(int id, uint16_t e_machine, uint32_t e_flags, int abi)
 {
 	const char *reg_name = NULL;
 
@@ -150,7 +150,7 @@ const char *perf_reg_name(int id, uint16_t e_machine, uint32_t e_flags)
 		break;
 	case EM_386:
 	case EM_X86_64:
-		reg_name = __perf_reg_name_x86(id);
+		reg_name = __perf_reg_name_x86(id, abi);
 		break;
 	default:
 		break;
diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
index 7c04700bf837..c9501ca8045d 100644
--- a/tools/perf/util/perf_regs.h
+++ b/tools/perf/util/perf_regs.h
@@ -13,10 +13,10 @@ enum {
 };
 
 int perf_sdt_arg_parse_op(uint16_t e_machine, char *old_op, char **new_op);
-uint64_t perf_intr_reg_mask(uint16_t e_machine);
-uint64_t perf_user_reg_mask(uint16_t e_machine);
+uint64_t perf_intr_reg_mask(uint16_t e_machine, int *abi);
+uint64_t perf_user_reg_mask(uint16_t e_machine, int *abi);
 
-const char *perf_reg_name(int id, uint16_t e_machine, uint32_t e_flags);
+const char *perf_reg_name(int id, uint16_t e_machine, uint32_t e_flags, int abi);
 int perf_reg_value(u64 *valp, struct regs_dump *regs, int id);
 uint64_t perf_arch_reg_ip(uint16_t e_machine);
 uint64_t perf_arch_reg_sp(uint16_t e_machine);
@@ -64,8 +64,8 @@ uint64_t __perf_reg_ip_s390(void);
 uint64_t __perf_reg_sp_s390(void);
 
 int __perf_sdt_arg_parse_op_x86(char *old_op, char **new_op);
-uint64_t __perf_reg_mask_x86(bool intr);
-const char *__perf_reg_name_x86(int id);
+uint64_t __perf_reg_mask_x86(bool intr, int *abi);
+const char *__perf_reg_name_x86(int id, int abi);
 uint64_t __perf_reg_ip_x86(void);
 uint64_t __perf_reg_sp_x86(void);
 
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 2b0df7bd9a46..4cc5b96898e6 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -733,7 +733,7 @@ static void regs_map(struct regs_dump *regs, uint64_t mask, uint16_t e_machine,
 
 		printed += scnprintf(bf + printed, size - printed,
 				     "%5s:0x%" PRIx64 " ",
-				     perf_reg_name(r, e_machine, e_flags), val);
+				     perf_reg_name(r, e_machine, e_flags, regs->abi), val);
 	}
 }
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 4b465abfa36c..7cf7bf86205d 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -959,15 +959,16 @@ static void branch_stack__printf(struct perf_sample *sample,
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
 
@@ -995,7 +996,7 @@ static void regs__printf(const char *type, struct regs_dump *regs,
 	       mask,
 	       regs_dump_abi(regs));
 
-	regs_dump__printf(mask, regs->regs, e_machine, e_flags);
+	regs_dump__printf(mask, regs, e_machine, e_flags);
 }
 
 static void regs_user__printf(struct perf_sample *sample, uint16_t e_machine, uint32_t e_flags)
-- 
2.34.1

