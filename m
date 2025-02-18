Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D278223C8C4;
	Tue, 18 Feb 2025 08:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866509; cv=none; b=s4QyNoBUtH8b0N8NI8hKusJh37x1SO7zw4QZkZTkuO1qnyz8LWLuwTsCft7wq3015QvwiRQpmWcmNJE6utzKcJmXGifTk1m6kkoDzYqnA2tBqJ+lat/frcKO/rMUrSVorXZXEKjUIkEjkbd20vNpBgXzE+ANJ/DKEg8nFO3bKBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866509; c=relaxed/simple;
	bh=hLaUV58Mqklu5FIy1HcEKoxuAKuLoLyY4Z3+4tcOcDM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bWfraAkD7oHj+g9ZCmEoJu9vt5WQMAgJ+hSMZOUQnB9Jq7TQnxXN7lC7HSuObaA9NyXb8HItxHALxOLTopXo16e0WtPvVXHCGR8I38f1/+OETI3utod8Qj93Url/NsN4KhZjZbM7nS0dKtE5H7Du/RUGAu3dRxNvjbQ5zFP1nEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qhm+1l9Q; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qhm+1l9Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739866509; x=1771402509;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hLaUV58Mqklu5FIy1HcEKoxuAKuLoLyY4Z3+4tcOcDM=;
  b=Qhm+1l9Qqr++51ly1Wba8Jhd2fei/YxxkIEy71wZ9pa0id4kLbbeYhms
   sYr//wzHIbWs6O+U3tG4CQ+gm/ehPnBQCKt8ziRcdGl2DFI+wPvilxwCF
   a/qkMePHoaE73qeAjZBvoLrv6LU9cxfVp3kDK+0A6DYFnsZDgLuntc+dI
   Ik7zpXkHANOxTsGsPUeVdDGCYmwwJW+HleX14MJuFMeb2W+sDXuuEJl4A
   80E9VPsP7y1Ssvb+xkgROTJWjzVUr6wZFd1ylw8ji46FWupORkKZExIOK
   4em+qKQd+PXbN2LX8NeXpD72VawKjZuYZy4X6zKUw+ka4UJcg+0RoqHVn
   w==;
X-CSE-ConnectionGUID: 826z3xwnQ4GuXxCgNVOPEQ==
X-CSE-MsgGUID: j6+rGjJETNWeKkdOOEolMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44200875"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="44200875"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 00:15:08 -0800
X-CSE-ConnectionGUID: EYaEHoDiQYeCNKLCqDhGXA==
X-CSE-MsgGUID: ZBzLq9PFR5iE8Jlwlx27gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="145166348"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa002.jf.intel.com with ESMTP; 18 Feb 2025 00:14:57 -0800
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
Subject: [Patch v2 20/24] perf tools: Enhance arch__intr/user_reg_mask() helpers
Date: Tue, 18 Feb 2025 15:28:14 +0000
Message-Id: <20250218152818.158614-21-dapeng1.mi@linux.intel.com>
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

Arch-PEBS supports to capture higher-width vector registers, like
YMM/ZMM registers, while the return value "uint64_t" of these 2 helpers
is not enough to represent these new added registors. Thus enhance these
two helpers by passing a "unsigned long" pointer, so these two helpers
can return more bits via this pointer.

Currently only sample_intr_regs supports these new added vector
registers, but change arch__user_reg_mask() for the sake of consistency
as well.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/arch/arm/util/perf_regs.c       |  8 ++++----
 tools/perf/arch/arm64/util/perf_regs.c     | 11 ++++++-----
 tools/perf/arch/csky/util/perf_regs.c      |  8 ++++----
 tools/perf/arch/loongarch/util/perf_regs.c |  8 ++++----
 tools/perf/arch/mips/util/perf_regs.c      |  8 ++++----
 tools/perf/arch/powerpc/util/perf_regs.c   | 17 +++++++++--------
 tools/perf/arch/riscv/util/perf_regs.c     |  8 ++++----
 tools/perf/arch/s390/util/perf_regs.c      |  8 ++++----
 tools/perf/arch/x86/util/perf_regs.c       | 13 +++++++------
 tools/perf/util/evsel.c                    |  6 ++++--
 tools/perf/util/parse-regs-options.c       |  6 +++---
 tools/perf/util/perf_regs.c                |  8 ++++----
 tools/perf/util/perf_regs.h                |  4 ++--
 13 files changed, 59 insertions(+), 54 deletions(-)

diff --git a/tools/perf/arch/arm/util/perf_regs.c b/tools/perf/arch/arm/util/perf_regs.c
index f94a0210c7b7..14f18d518c96 100644
--- a/tools/perf/arch/arm/util/perf_regs.c
+++ b/tools/perf/arch/arm/util/perf_regs.c
@@ -6,14 +6,14 @@ static const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG_END
 };
 
-uint64_t arch__intr_reg_mask(void)
+void arch__intr_reg_mask(unsigned long *mask)
 {
-	return PERF_REGS_MASK;
+	*(uint64_t *)mask = PERF_REGS_MASK;
 }
 
-uint64_t arch__user_reg_mask(void)
+void arch__user_reg_mask(unsigned long *mask)
 {
-	return PERF_REGS_MASK;
+	*(uint64_t *)mask = PERF_REGS_MASK;
 }
 
 const struct sample_reg *arch__sample_reg_masks(void)
diff --git a/tools/perf/arch/arm64/util/perf_regs.c b/tools/perf/arch/arm64/util/perf_regs.c
index 09308665e28a..9bcf4755290c 100644
--- a/tools/perf/arch/arm64/util/perf_regs.c
+++ b/tools/perf/arch/arm64/util/perf_regs.c
@@ -140,12 +140,12 @@ int arch_sdt_arg_parse_op(char *old_op, char **new_op)
 	return SDT_ARG_VALID;
 }
 
-uint64_t arch__intr_reg_mask(void)
+void arch__intr_reg_mask(unsigned long *mask)
 {
-	return PERF_REGS_MASK;
+	*(uint64_t *)mask = PERF_REGS_MASK;
 }
 
-uint64_t arch__user_reg_mask(void)
+void arch__user_reg_mask(unsigned long *mask)
 {
 	struct perf_event_attr attr = {
 		.type                   = PERF_TYPE_HARDWARE,
@@ -170,10 +170,11 @@ uint64_t arch__user_reg_mask(void)
 		fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
 		if (fd != -1) {
 			close(fd);
-			return attr.sample_regs_user;
+			*(uint64_t *)mask = attr.sample_regs_user;
+			return;
 		}
 	}
-	return PERF_REGS_MASK;
+	*(uint64_t *)mask = PERF_REGS_MASK;
 }
 
 const struct sample_reg *arch__sample_reg_masks(void)
diff --git a/tools/perf/arch/csky/util/perf_regs.c b/tools/perf/arch/csky/util/perf_regs.c
index 6b1665f41180..56c84fc91aff 100644
--- a/tools/perf/arch/csky/util/perf_regs.c
+++ b/tools/perf/arch/csky/util/perf_regs.c
@@ -6,14 +6,14 @@ static const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG_END
 };
 
-uint64_t arch__intr_reg_mask(void)
+void arch__intr_reg_mask(unsigned long *mask)
 {
-	return PERF_REGS_MASK;
+	*(uint64_t *)mask = PERF_REGS_MASK;
 }
 
-uint64_t arch__user_reg_mask(void)
+void arch__user_reg_mask(unsigned long *mask)
 {
-	return PERF_REGS_MASK;
+	*(uint64_t *)mask = PERF_REGS_MASK;
 }
 
 const struct sample_reg *arch__sample_reg_masks(void)
diff --git a/tools/perf/arch/loongarch/util/perf_regs.c b/tools/perf/arch/loongarch/util/perf_regs.c
index f94a0210c7b7..14f18d518c96 100644
--- a/tools/perf/arch/loongarch/util/perf_regs.c
+++ b/tools/perf/arch/loongarch/util/perf_regs.c
@@ -6,14 +6,14 @@ static const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG_END
 };
 
-uint64_t arch__intr_reg_mask(void)
+void arch__intr_reg_mask(unsigned long *mask)
 {
-	return PERF_REGS_MASK;
+	*(uint64_t *)mask = PERF_REGS_MASK;
 }
 
-uint64_t arch__user_reg_mask(void)
+void arch__user_reg_mask(unsigned long *mask)
 {
-	return PERF_REGS_MASK;
+	*(uint64_t *)mask = PERF_REGS_MASK;
 }
 
 const struct sample_reg *arch__sample_reg_masks(void)
diff --git a/tools/perf/arch/mips/util/perf_regs.c b/tools/perf/arch/mips/util/perf_regs.c
index 6b1665f41180..56c84fc91aff 100644
--- a/tools/perf/arch/mips/util/perf_regs.c
+++ b/tools/perf/arch/mips/util/perf_regs.c
@@ -6,14 +6,14 @@ static const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG_END
 };
 
-uint64_t arch__intr_reg_mask(void)
+void arch__intr_reg_mask(unsigned long *mask)
 {
-	return PERF_REGS_MASK;
+	*(uint64_t *)mask = PERF_REGS_MASK;
 }
 
-uint64_t arch__user_reg_mask(void)
+void arch__user_reg_mask(unsigned long *mask)
 {
-	return PERF_REGS_MASK;
+	*(uint64_t *)mask = PERF_REGS_MASK;
 }
 
 const struct sample_reg *arch__sample_reg_masks(void)
diff --git a/tools/perf/arch/powerpc/util/perf_regs.c b/tools/perf/arch/powerpc/util/perf_regs.c
index bd36cfd420a2..e5d042305030 100644
--- a/tools/perf/arch/powerpc/util/perf_regs.c
+++ b/tools/perf/arch/powerpc/util/perf_regs.c
@@ -187,7 +187,7 @@ int arch_sdt_arg_parse_op(char *old_op, char **new_op)
 	return SDT_ARG_VALID;
 }
 
-uint64_t arch__intr_reg_mask(void)
+void arch__intr_reg_mask(unsigned long *mask)
 {
 	struct perf_event_attr attr = {
 		.type                   = PERF_TYPE_HARDWARE,
@@ -199,7 +199,7 @@ uint64_t arch__intr_reg_mask(void)
 	};
 	int fd;
 	u32 version;
-	u64 extended_mask = 0, mask = PERF_REGS_MASK;
+	u64 extended_mask = 0;
 
 	/*
 	 * Get the PVR value to set the extended
@@ -210,8 +210,10 @@ uint64_t arch__intr_reg_mask(void)
 		extended_mask = PERF_REG_PMU_MASK_300;
 	else if ((version == PVR_POWER10) || (version == PVR_POWER11))
 		extended_mask = PERF_REG_PMU_MASK_31;
-	else
-		return mask;
+	else {
+		*(u64 *)mask = PERF_REGS_MASK;
+		return;
+	}
 
 	attr.sample_regs_intr = extended_mask;
 	attr.sample_period = 1;
@@ -224,14 +226,13 @@ uint64_t arch__intr_reg_mask(void)
 	fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
 	if (fd != -1) {
 		close(fd);
-		mask |= extended_mask;
+		*(u64 *)mask = PERF_REGS_MASK | extended_mask;
 	}
-	return mask;
 }
 
-uint64_t arch__user_reg_mask(void)
+void arch__user_reg_mask(unsigned long *mask)
 {
-	return PERF_REGS_MASK;
+	*(uint64_t *)mask = PERF_REGS_MASK;
 }
 
 const struct sample_reg *arch__sample_reg_masks(void)
diff --git a/tools/perf/arch/riscv/util/perf_regs.c b/tools/perf/arch/riscv/util/perf_regs.c
index 6b1665f41180..56c84fc91aff 100644
--- a/tools/perf/arch/riscv/util/perf_regs.c
+++ b/tools/perf/arch/riscv/util/perf_regs.c
@@ -6,14 +6,14 @@ static const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG_END
 };
 
-uint64_t arch__intr_reg_mask(void)
+void arch__intr_reg_mask(unsigned long *mask)
 {
-	return PERF_REGS_MASK;
+	*(uint64_t *)mask = PERF_REGS_MASK;
 }
 
-uint64_t arch__user_reg_mask(void)
+void arch__user_reg_mask(unsigned long *mask)
 {
-	return PERF_REGS_MASK;
+	*(uint64_t *)mask = PERF_REGS_MASK;
 }
 
 const struct sample_reg *arch__sample_reg_masks(void)
diff --git a/tools/perf/arch/s390/util/perf_regs.c b/tools/perf/arch/s390/util/perf_regs.c
index 6b1665f41180..56c84fc91aff 100644
--- a/tools/perf/arch/s390/util/perf_regs.c
+++ b/tools/perf/arch/s390/util/perf_regs.c
@@ -6,14 +6,14 @@ static const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG_END
 };
 
-uint64_t arch__intr_reg_mask(void)
+void arch__intr_reg_mask(unsigned long *mask)
 {
-	return PERF_REGS_MASK;
+	*(uint64_t *)mask = PERF_REGS_MASK;
 }
 
-uint64_t arch__user_reg_mask(void)
+void arch__user_reg_mask(unsigned long *mask)
 {
-	return PERF_REGS_MASK;
+	*(uint64_t *)mask = PERF_REGS_MASK;
 }
 
 const struct sample_reg *arch__sample_reg_masks(void)
diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
index 9f492568f3b4..5b163f0a651a 100644
--- a/tools/perf/arch/x86/util/perf_regs.c
+++ b/tools/perf/arch/x86/util/perf_regs.c
@@ -283,7 +283,7 @@ const struct sample_reg *arch__sample_reg_masks(void)
 	return sample_reg_masks;
 }
 
-uint64_t arch__intr_reg_mask(void)
+void arch__intr_reg_mask(unsigned long *mask)
 {
 	struct perf_event_attr attr = {
 		.type			= PERF_TYPE_HARDWARE,
@@ -295,6 +295,9 @@ uint64_t arch__intr_reg_mask(void)
 		.exclude_kernel		= 1,
 	};
 	int fd;
+
+	*(u64 *)mask = PERF_REGS_MASK;
+
 	/*
 	 * In an unnamed union, init it here to build on older gcc versions
 	 */
@@ -320,13 +323,11 @@ uint64_t arch__intr_reg_mask(void)
 	fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
 	if (fd != -1) {
 		close(fd);
-		return (PERF_REG_EXTENDED_MASK | PERF_REGS_MASK);
+		*(u64 *)mask = PERF_REG_EXTENDED_MASK | PERF_REGS_MASK;
 	}
-
-	return PERF_REGS_MASK;
 }
 
-uint64_t arch__user_reg_mask(void)
+void arch__user_reg_mask(unsigned long *mask)
 {
-	return PERF_REGS_MASK;
+	*(uint64_t *)mask = PERF_REGS_MASK;
 }
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index bc144388f892..78bcb12a9d96 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1032,17 +1032,19 @@ static void __evsel__config_callchain(struct evsel *evsel, struct record_opts *o
 	if (param->record_mode == CALLCHAIN_DWARF) {
 		if (!function) {
 			const char *arch = perf_env__arch(evsel__env(evsel));
+			uint64_t mask = 0;
 
+			arch__user_reg_mask((unsigned long *)&mask);
 			evsel__set_sample_bit(evsel, REGS_USER);
 			evsel__set_sample_bit(evsel, STACK_USER);
 			if (opts->sample_user_regs &&
-			    DWARF_MINIMAL_REGS(arch) != arch__user_reg_mask()) {
+			    DWARF_MINIMAL_REGS(arch) != mask) {
 				attr->sample_regs_user |= DWARF_MINIMAL_REGS(arch);
 				pr_warning("WARNING: The use of --call-graph=dwarf may require all the user registers, "
 					   "specifying a subset with --user-regs may render DWARF unwinding unreliable, "
 					   "so the minimal registers set (IP, SP) is explicitly forced.\n");
 			} else {
-				attr->sample_regs_user |= arch__user_reg_mask();
+				attr->sample_regs_user |= mask;
 			}
 			attr->sample_stack_user = param->dump_size;
 			attr->exclude_callchain_user = 1;
diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse-regs-options.c
index cda1c620968e..3dcd8dc4f81b 100644
--- a/tools/perf/util/parse-regs-options.c
+++ b/tools/perf/util/parse-regs-options.c
@@ -16,7 +16,7 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 	const struct sample_reg *r = NULL;
 	char *s, *os = NULL, *p;
 	int ret = -1;
-	uint64_t mask;
+	uint64_t mask = 0;
 
 	if (unset)
 		return 0;
@@ -28,9 +28,9 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 		return -1;
 
 	if (intr)
-		mask = arch__intr_reg_mask();
+		arch__intr_reg_mask((unsigned long *)&mask);
 	else
-		mask = arch__user_reg_mask();
+		arch__user_reg_mask((unsigned long *)&mask);
 
 	/* str may be NULL in case no arg is passed to -I */
 	if (str) {
diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
index 44b90bbf2d07..7a96290fd1e6 100644
--- a/tools/perf/util/perf_regs.c
+++ b/tools/perf/util/perf_regs.c
@@ -11,14 +11,14 @@ int __weak arch_sdt_arg_parse_op(char *old_op __maybe_unused,
 	return SDT_ARG_SKIP;
 }
 
-uint64_t __weak arch__intr_reg_mask(void)
+void __weak arch__intr_reg_mask(unsigned long *mask)
 {
-	return 0;
+	*(uint64_t *)mask = 0;
 }
 
-uint64_t __weak arch__user_reg_mask(void)
+void __weak arch__user_reg_mask(unsigned long *mask)
 {
-	return 0;
+	*(uint64_t *)mask = 0;
 }
 
 static const struct sample_reg sample_reg_masks[] = {
diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
index f2d0736d65cc..316d280e5cd7 100644
--- a/tools/perf/util/perf_regs.h
+++ b/tools/perf/util/perf_regs.h
@@ -24,8 +24,8 @@ enum {
 };
 
 int arch_sdt_arg_parse_op(char *old_op, char **new_op);
-uint64_t arch__intr_reg_mask(void);
-uint64_t arch__user_reg_mask(void);
+void arch__intr_reg_mask(unsigned long *mask);
+void arch__user_reg_mask(unsigned long *mask);
 const struct sample_reg *arch__sample_reg_masks(void);
 
 const char *perf_reg_name(int id, const char *arch);
-- 
2.40.1

