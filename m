Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7096134AB;
	Fri, 14 Feb 2025 18:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739559295; cv=none; b=GRWUANZ6BzGPjSjLKgEElwkXfW2xlXk3EG1IXwXbEWubG8B/tWQksBjkSLy8V/XZpW0zDX7lKSuUj+iNVA01OKCKxH7pooMQw01xaAQFgbDmd7IkOKhhuoEApFJG67Y+D/hVSpuDj50dMolT7tz3ZHJCu5ha3jmeqg2YTfMb5do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739559295; c=relaxed/simple;
	bh=ia/ucavXjq6WnO3QZMyQf6RkJzq6OShVb4GpeeFZXo0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qD7kNOhdAaxSD1HoN3ffkSeNyg/QJMJXrGNKi7A8epftOapATrwqmsetx3DUM0+K4KWPgJfCnCEpKlBMWnBNQQ5/+M8O2AkbrgU3hixWr2GyAmc8bvx+tWhsEW8yDVUWWWViy8UA36X8cvWAiQDpG0+QyIynIjRrJPrfD5PVwo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUjpuxeO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUjpuxeO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF4DC4CED1;
	Fri, 14 Feb 2025 18:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739559295;
	bh=ia/ucavXjq6WnO3QZMyQf6RkJzq6OShVb4GpeeFZXo0=;
	h=From:To:Cc:Subject:Date:From;
	b=DUjpuxeOE2Es4StoHMlBPFQ3vBpaGtKI/AgNu3KjEqH08MkaR++I6oMZ2RGUGYcP/
	 hM9GoCN5SIqgP2n+S8uQ3JiWxTuL/i5Wx9O45WPo7KgzO0H2uOBkgHFaYXqS9X9+9P
	 7F8XKzFGlUUA580ycbm/Y5dVoY9dokaTYu6bBFS4G2rfWG+HvGgiyz9o7sswOT40xq
	 EoeaTVE0Q8T5BSf/V5DO+wDIFHt6eNTaZ3zJvTxOxcxHEX9tinT3zim/Fi/WJAEi5V
	 O30s1o99N5UVt/pocMypsR0Rbqx1zjHOW7bQk1hdkjqgK0GxwINoY1rAwdpfDRO/0A
	 vYs5FgftM/glQ==
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
Subject: [PATCH] perf tools: Fix compile error on sample->user_regs
Date: Fri, 14 Feb 2025 10:54:54 -0800
Message-ID: <20250214185454.753122-1-namhyung@kernel.org>
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
 tools/perf/arch/csky/util/unwind-libdw.c      | 2 +-
 tools/perf/arch/loongarch/util/unwind-libdw.c | 2 +-
 tools/perf/arch/powerpc/tests/dwarf-unwind.c  | 2 +-
 tools/perf/arch/powerpc/util/unwind-libdw.c   | 2 +-
 tools/perf/arch/riscv/util/unwind-libdw.c     | 2 +-
 tools/perf/arch/s390/util/unwind-libdw.c      | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

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

