Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB8138552C;
	Tue, 11 Aug 2026 18:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786472976; cv=none; b=ilVP52UPiy6BlWZ51bjm49MOTl3w3jQLhp07fHoi+6pH6ArLBpI0ucLs2Y7JW+jO1PrXowesr4Qz7RECSCuURRkjY+g4q+J6itHYgzo9m1ku6QdpBcUhjMY9kPsiwr5zKM/dXMk53goc6Cspv6TTQgCMBB0Iy80X/1yYEIJsWVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786472976; c=relaxed/simple;
	bh=cLrSw0Uqu+iLNBe0d4lfA8dTZeOFNm1dbUQ/bp0FX9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xck6p7rtFid5u9n8qcgiNATGNxIN6GrKFe5ybwrpGuSxxpMhVmPuMhAkiGSygXLNeumrfi7pDEqdLlTXS49+pewQNOuXtg8FA4lLop54EPi+3hsR/eELggfNE6Ejwc5EezlYTz5TB66Tm/BoQ3SuUNKEa6ktxuO44TVLR5NQAMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1Z1IGgV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1Z1IGgV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4217B1F000E9;
	Tue, 11 Aug 2026 18:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786472975;
	bh=stFdSUc44LqGWKljLA8vNKkppR5KV+uSshexvSqq3WA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q1Z1IGgVaPJ75Myuuvr6xbk0VQ04OB23CRnlwsOpiOt2LM4IYuhQ2qpmZr2YHt53O
	 SZecRmQg3vgDe1PijH7/40gAfx34dCdYsF5XAXs/3c24Ps7nLly7TsEEPlJYnezuIq
	 7rPtPUPO2b3HgOK46FZEyL1BV17JEts7MQ1Omcbu7PHNW8CG0YFST5tnKcg78dLzGH
	 dPdQTo3EpTZ/LqLqwiumDW1S4TYur9/ZscW/KwfPHgkn7eVQ4AHVznaIrUPNqS3+sK
	 xDuPW5u7Bn/OQ6HJxK14/Xv1Apmk5jx/fUN6TFML/TwmavZn6rOk1fCW87rONGPYMD
	 Hsv/6uJ1rZpag==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 6/7] perf build: Remove leftover feature tests for removed cxx and clang support
Date: Tue, 11 Aug 2026 15:28:59 -0300
Message-ID: <20260811182900.27063-7-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260811182900.27063-1-acme@kernel.org>
References: <20260811182900.27063-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

56b11a2126bf2f42 ("perf bpf: Remove support for embedding clang for
compiling BPF events (-e foo.c)") removed the test-cxx.cpp and
test-clang.cpp sources, but left behind their entries in the feature
test FILES list, the build rules and the cxx and clang entries in
FEATURE_TESTS_EXTRA.

Since the sources no longer exist, those rules would always fail,
making the artificial feature-cxx and feature-clang results to be
perpetually disabled/absent, remove the leftover entries, making the
feature test scripts list match the available sources.

Fixes: 56b11a2126bf2f42 ("perf bpf: Remove support for embedding clang for compiling BPF events (-e foo.c)")
Cc: Ian Rogers <irogers@google.com>
Assisted-by: opencode:deepseek-v4-flash-free
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/Makefile.feature |  2 --
 tools/build/feature/Makefile | 14 --------------
 2 files changed, 16 deletions(-)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index ed1374af31c16838..99eb0ea095375606 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -123,9 +123,7 @@ FEATURE_TESTS_EXTRA :=                  \
          libbfd-liberty-z               \
          libopencsd                     \
          libperl                        \
-         cxx                            \
          llvm                           \
-         clang                          \
          libbpf                         \
          libpfm4                        \
          libdebuginfod			\
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 62909a9c799d3338..7d165018116a552f 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -55,7 +55,6 @@ FILES=                                          \
          test-bpf.bin                           \
          test-libbpf.bin                        \
          test-sdt.bin                           \
-         test-cxx.bin                           \
          test-gettid.bin			\
          test-jvmti.bin				\
          test-jvmti-cmlr.bin			\
@@ -63,7 +62,6 @@ FILES=                                          \
          test-sched_getcpu.bin			\
          test-setns.bin				\
          test-libopencsd.bin			\
-         test-clang.bin				\
          test-llvm.bin				\
          test-llvm-perf.bin   			\
          test-libaio.bin			\
@@ -335,9 +333,6 @@ $(OUTPUT)test-libbpf.bin:
 $(OUTPUT)test-sdt.bin:
 	$(BUILD)
 
-$(OUTPUT)test-cxx.bin:
-	$(BUILDXX) -std=gnu++11
-
 $(OUTPUT)test-gettid.bin:
 	$(BUILD)
 
@@ -363,15 +358,6 @@ $(OUTPUT)test-llvm-perf.bin:
 		$(shell $(LLVM_CONFIG) --system-libs)		\
 		> $(@:.bin=.make.output) 2>&1
 
-$(OUTPUT)test-clang.bin:
-	$(BUILDXX) -std=gnu++17					\
-		-I$(shell $(LLVM_CONFIG) --includedir) 		\
-		-L$(shell $(LLVM_CONFIG) --libdir)		\
-		-Wl,--start-group -lclang-cpp -Wl,--end-group	\
-		$(shell $(LLVM_CONFIG) --libs Core option)	\
-		$(shell $(LLVM_CONFIG) --system-libs)		\
-		> $(@:.bin=.make.output) 2>&1
-
 -include $(OUTPUT)*.d
 
 $(OUTPUT)test-libaio.bin:
-- 
2.55.0

