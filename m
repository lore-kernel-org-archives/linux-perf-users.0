Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D86186E40;
	Fri, 14 Feb 2025 11:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739531438; cv=none; b=L9Fe/XPBw1w2WWdJIwGMvxPvpD60rCaNHMA3msmxKnX909eQWCt5GHcH5nhvxxIoECdYf8IBVbdYfOGfJ3aKw8V2SyyLLaHgC6kfNuMIqkLeXIlgq7ZGJVMAdFDzdeLYZOtUYBZ57LAVsVPBNIwJRFfJVG8hlIv0dB01oLth9G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739531438; c=relaxed/simple;
	bh=LLJu4XpDn8EUNeYfwR1U/MwHFUENgL7xVLX/DUBDG0s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=swjBUYT89Ar/aML7JH7t7bTgy18TuRTI/CryYHR6nACkza0UHZf3bs96mY6EKm1r9Bff7x47fFHubGGV6KIVbhjjyeRQYI7eYH0FFi4TDk5w4fIxV2rLLMMj6G2MvoAqXTCjJvlfHxVlSzJuLI6pbOq/EkXwSNvmCRdSL0Fuxxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70FFF113E;
	Fri, 14 Feb 2025 03:10:54 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1865B3F6A8;
	Fri, 14 Feb 2025 03:10:31 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH] perf: arm64: Fix compilation error
Date: Fri, 14 Feb 2025 11:10:25 +0000
Message-Id: <20250214111025.14478-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since the commit dc6d2bc2d893 ("perf sample: Make user_regs and
intr_regs optional"), the building for Arm64 reports error:

arch/arm64/util/unwind-libdw.c: In function ‘libdw__arch_set_initial_registers’:
arch/arm64/util/unwind-libdw.c:11:32: error: initialization of ‘struct regs_dump *’ from incompatible pointer type ‘struct regs_dump **’ [-Werror=incompatible-pointer-types]
   11 |  struct regs_dump *user_regs = &ui->sample->user_regs;
      |                                ^
cc1: all warnings being treated as errors
make[6]: *** [/home/niayan01/linux/tools/build/Makefile.build:85: arch/arm64/util/unwind-libdw.o] Error 1
make[5]: *** [/home/niayan01/linux/tools/build/Makefile.build:138: util] Error 2
arch/arm64/tests/dwarf-unwind.c: In function ‘test__arch_unwind_sample’:
arch/arm64/tests/dwarf-unwind.c:48:27: error: initialization of ‘struct regs_dump *’ from incompatible pointer type ‘struct regs_dump **’ [-Werror=incompatible-pointer-types]
   48 |  struct regs_dump *regs = &sample->user_regs;
      |                           ^

To fix the issue, use the helper perf_sample__user_regs() to retrieve
the user_regs.

Fixes: dc6d2bc2d893 ("perf sample: Make user_regs and intr_regs optional")
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/arch/arm64/tests/dwarf-unwind.c | 2 +-
 tools/perf/arch/arm64/util/unwind-libdw.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/arm64/tests/dwarf-unwind.c b/tools/perf/arch/arm64/tests/dwarf-unwind.c
index b2603d0d3737..440d00f0de14 100644
--- a/tools/perf/arch/arm64/tests/dwarf-unwind.c
+++ b/tools/perf/arch/arm64/tests/dwarf-unwind.c
@@ -45,7 +45,7 @@ static int sample_ustack(struct perf_sample *sample,
 int test__arch_unwind_sample(struct perf_sample *sample,
 		struct thread *thread)
 {
-	struct regs_dump *regs = &sample->user_regs;
+	struct regs_dump *regs = perf_sample__user_regs(sample);
 	u64 *buf;
 
 	buf = calloc(1, sizeof(u64) * PERF_REGS_MAX);
diff --git a/tools/perf/arch/arm64/util/unwind-libdw.c b/tools/perf/arch/arm64/util/unwind-libdw.c
index e056d50ab42e..b89b0a7e5ad9 100644
--- a/tools/perf/arch/arm64/util/unwind-libdw.c
+++ b/tools/perf/arch/arm64/util/unwind-libdw.c
@@ -8,7 +8,7 @@
 bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
 {
 	struct unwind_info *ui = arg;
-	struct regs_dump *user_regs = &ui->sample->user_regs;
+	struct regs_dump *user_regs = perf_sample__user_regs(ui->sample);
 	Dwarf_Word dwarf_regs[PERF_REG_ARM64_MAX], dwarf_pc;
 
 #define REG(r) ({						\
-- 
2.34.1

