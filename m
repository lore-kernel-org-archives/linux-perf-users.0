Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0782AF16;
	Fri, 14 Feb 2025 19:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739560602; cv=none; b=kInLZpOykLpkVkdm5zSfv72yS0udqyP8g+aPbF9+oD8FXosCi11Lfm99BMd43m1HumGloybd/OM767ZSb0Ydz0sDHMpZTO1/sO5INZR8xvHtw0PIIFq3/DgWv+DAyocrIYBHtqbYN1xHjDJchAlsT0R9kVkvDNt190QAWIwpyPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739560602; c=relaxed/simple;
	bh=rZZGuv2YyY62edJHzlcL7AnSAquJF3lbFxEnmjAzltA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QLy8HM3HQwE8+pJI4QTNoTnHas05/l2YTwcvuAU/qktg1BZI3zTByGpXrnrEEHSV4Md61uCXJX7H743YzZfwhLdAMMRWV9snjGl3WeV9mKb7yx4CpJYpu3KP92swlipO+JeNTn39CPXfm/S0kyZLnKWB43bfdRniHj7XIPXzuzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IR3zAzpY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IR3zAzpY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4B9C4CED1;
	Fri, 14 Feb 2025 19:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739560602;
	bh=rZZGuv2YyY62edJHzlcL7AnSAquJF3lbFxEnmjAzltA=;
	h=From:To:Cc:Subject:Date:From;
	b=IR3zAzpY+E2Nq8gE/TT8d0C5krZAjfex9+I4nyoOzFILb+znz+OAj3dlJin+Cng88
	 BpogjPVaOW3XHipYafq08rvySUHcXj0hsJ9wnq4Rt4BwV3zlBCfZu1Wu+Z7/+t9BKg
	 Wp/AAl0KlSIFSjM9ijeyskUiYvcjuWZ+cQDGLjiGGYXtEwY8AfE19gQHpo2rzNpIVr
	 AKNyIeov76AU8PNwzU8RWTaRjG8SWTZzZSHpg5vt6DHhqdRPrKKBa5so4SqUOEVXJv
	 3s4qdFAB7nOiWNE1FJVeZToB6J2UhJ67BMM5dEfgpXon+6jrULv15IDvqXyDUi8B5U
	 HE5G12nOnc4OA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v2] perf tools: Fix compile error on sample->user_regs
Date: Fri, 14 Feb 2025 11:16:41 -0800
Message-ID: <20250214191641.756664-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's recently changed to allocate dynamically but misses to update some
arch-dependent codes to use perf_sample__user_regs().

Fixes: dc6d2bc2d893a878 ("perf sample: Make user_regs and intr_regs optional")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
v2) fix arm (32-bit) as well

 tools/perf/arch/arm/tests/dwarf-unwind.c      | 2 +-
 tools/perf/arch/arm/util/unwind-libdw.c       | 2 +-
 tools/perf/arch/csky/util/unwind-libdw.c      | 2 +-
 tools/perf/arch/loongarch/util/unwind-libdw.c | 2 +-
 tools/perf/arch/powerpc/tests/dwarf-unwind.c  | 2 +-
 tools/perf/arch/powerpc/util/unwind-libdw.c   | 2 +-
 tools/perf/arch/riscv/util/unwind-libdw.c     | 2 +-
 tools/perf/arch/s390/util/unwind-libdw.c      | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/arch/arm/tests/dwarf-unwind.c b/tools/perf/arch/arm/tests/dwarf-unwind.c
index 9bc304cb7762b5d1..f421910e07097152 100644
--- a/tools/perf/arch/arm/tests/dwarf-unwind.c
+++ b/tools/perf/arch/arm/tests/dwarf-unwind.c
@@ -45,7 +45,7 @@ static int sample_ustack(struct perf_sample *sample,
 int test__arch_unwind_sample(struct perf_sample *sample,
 			     struct thread *thread)
 {
-	struct regs_dump *regs = &sample->user_regs;
+	struct regs_dump *regs = perf_sample__user_regs(sample);
 	u64 *buf;
 
 	buf = calloc(1, sizeof(u64) * PERF_REGS_MAX);
diff --git a/tools/perf/arch/arm/util/unwind-libdw.c b/tools/perf/arch/arm/util/unwind-libdw.c
index 4e02cef461e3af34..fbb643f224ec4b27 100644
--- a/tools/perf/arch/arm/util/unwind-libdw.c
+++ b/tools/perf/arch/arm/util/unwind-libdw.c
@@ -8,7 +8,7 @@
 bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
 {
 	struct unwind_info *ui = arg;
-	struct regs_dump *user_regs = &ui->sample->user_regs;
+	struct regs_dump *user_regs = perf_sample__user_regs(ui->sample);
 	Dwarf_Word dwarf_regs[PERF_REG_ARM_MAX];
 
 #define REG(r) ({						\
diff --git a/tools/perf/arch/csky/util/unwind-libdw.c b/tools/perf/arch/csky/util/unwind-libdw.c
index 79df4374ab18dc36..b20b1569783d7e98 100644
--- a/tools/perf/arch/csky/util/unwind-libdw.c
+++ b/tools/perf/arch/csky/util/unwind-libdw.c
@@ -10,7 +10,7 @@
 bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
 {
 	struct unwind_info *ui = arg;
-	struct regs_dump *user_regs = &ui->sample->user_regs;
+	struct regs_dump *user_regs = perf_sample__user_regs(ui->sample);
 	Dwarf_Word dwarf_regs[PERF_REG_CSKY_MAX];
 
 #define REG(r) ({						\
diff --git a/tools/perf/arch/loongarch/util/unwind-libdw.c b/tools/perf/arch/loongarch/util/unwind-libdw.c
index 7b3b9a4b21f8f482..60b1144bedd5f325 100644
--- a/tools/perf/arch/loongarch/util/unwind-libdw.c
+++ b/tools/perf/arch/loongarch/util/unwind-libdw.c
@@ -10,7 +10,7 @@
 bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
 {
 	struct unwind_info *ui = arg;
-	struct regs_dump *user_regs = &ui->sample->user_regs;
+	struct regs_dump *user_regs = perf_sample__user_regs(ui->sample);
 	Dwarf_Word dwarf_regs[PERF_REG_LOONGARCH_MAX];
 
 #define REG(r) ({							\
diff --git a/tools/perf/arch/powerpc/tests/dwarf-unwind.c b/tools/perf/arch/powerpc/tests/dwarf-unwind.c
index 5ecf82893b84d5c0..66af884baa660389 100644
--- a/tools/perf/arch/powerpc/tests/dwarf-unwind.c
+++ b/tools/perf/arch/powerpc/tests/dwarf-unwind.c
@@ -45,7 +45,7 @@ static int sample_ustack(struct perf_sample *sample,
 int test__arch_unwind_sample(struct perf_sample *sample,
 			     struct thread *thread)
 {
-	struct regs_dump *regs = &sample->user_regs;
+	struct regs_dump *regs = perf_sample__user_regs(sample);
 	u64 *buf;
 
 	buf = calloc(1, sizeof(u64) * PERF_REGS_MAX);
diff --git a/tools/perf/arch/powerpc/util/unwind-libdw.c b/tools/perf/arch/powerpc/util/unwind-libdw.c
index e9a5a8bb67d9186e..82d0c28ae3459ecd 100644
--- a/tools/perf/arch/powerpc/util/unwind-libdw.c
+++ b/tools/perf/arch/powerpc/util/unwind-libdw.c
@@ -16,7 +16,7 @@ static const int special_regs[3][2] = {
 bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
 {
 	struct unwind_info *ui = arg;
-	struct regs_dump *user_regs = &ui->sample->user_regs;
+	struct regs_dump *user_regs = perf_sample__user_regs(ui->sample);
 	Dwarf_Word dwarf_regs[32], dwarf_nip;
 	size_t i;
 
diff --git a/tools/perf/arch/riscv/util/unwind-libdw.c b/tools/perf/arch/riscv/util/unwind-libdw.c
index 5c98010d8b59777f..dc1476e16321736d 100644
--- a/tools/perf/arch/riscv/util/unwind-libdw.c
+++ b/tools/perf/arch/riscv/util/unwind-libdw.c
@@ -10,7 +10,7 @@
 bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
 {
 	struct unwind_info *ui = arg;
-	struct regs_dump *user_regs = &ui->sample->user_regs;
+	struct regs_dump *user_regs = perf_sample__user_regs(ui->sample);
 	Dwarf_Word dwarf_regs[32];
 
 #define REG(r) ({						\
diff --git a/tools/perf/arch/s390/util/unwind-libdw.c b/tools/perf/arch/s390/util/unwind-libdw.c
index f50fb6dbb35c5dc6..c27c7a0d1076c890 100644
--- a/tools/perf/arch/s390/util/unwind-libdw.c
+++ b/tools/perf/arch/s390/util/unwind-libdw.c
@@ -11,7 +11,7 @@
 bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
 {
 	struct unwind_info *ui = arg;
-	struct regs_dump *user_regs = &ui->sample->user_regs;
+	struct regs_dump *user_regs = perf_sample__user_regs(ui->sample);
 	Dwarf_Word dwarf_regs[ARRAY_SIZE(s390_dwarf_regs)];
 
 #define REG(r) ({						\
-- 
2.48.1.601.g30ceb7b040-goog

