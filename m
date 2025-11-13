Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BF91D435F;
	Thu, 13 Nov 2025 00:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762995433; cv=none; b=kPlQQMKBH9bsRwUsCLHGVVftmgePKC8lj8IGtJDIG/bdsfHWJsExxM+D3uih1j3wMmAkYtGtblm9Y7BBZLmWDNbrKtVfiLl+vNaoNBNTeYxdLR0oQytB/02XVPHaCp+PlRhoYWIHAsTD2ZPAk1YounNcaC/Q2tATedrCiBZ8m/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762995433; c=relaxed/simple;
	bh=em2GZkCqashF0+2U2q61GHmgmICQf/BrVBW91DnIFjE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q/l9fQgU0Vf2+XvC4Vtpa/Yor77Ycgbh4Rg/wXV6VP0456jaG2M3ywFhlyTz9xyg+1Gb9QjSr1ua5UCu41ZfdHLApvP70ieLbQzmFc72oWF3tuCT9pzvd3Z6VS2433FU0yas8xTVXmPmOMWSqbAW7qm7GO5/LyCNvk+ckJJWHJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGgOAGPO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGgOAGPO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD2FC116B1;
	Thu, 13 Nov 2025 00:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762995431;
	bh=em2GZkCqashF0+2U2q61GHmgmICQf/BrVBW91DnIFjE=;
	h=Date:From:To:Cc:Subject:From;
	b=GGgOAGPOGNEJWa1f9i7G3am2CMj7dMn5v2/CySU2+HdbK6Pqf69QN3pN1E3RkZ3+s
	 WS+vvdW9Jm6SP+oNTAcBRi6iLG5xd71aeUTL9zktlO9ciTe5w++stgl9DWKBAU7zSU
	 QiF2tae+3QCQsTxRlY7BOVeG87zukuI6nEC9kk/hqyoQeo8dzYsG7SYgB37YKfkwxk
	 /97nDx8RCWB/Sz15QE6d2hH7/Ql92Z+1+RyzoYeGBkJadvGWxhzyK1Q+yiyA57PPTJ
	 3bQt8rBhctgDLNv18SaEeeXdzpPFxyWqOiGJdxhBtW2ProBrN6X/D2QGhO3x3E8gYU
	 tTszpvJcGYzKA==
Date: Wed, 12 Nov 2025 21:57:08 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] perf build: Don't fail fast path feature detection when
 binutils-devel is not available
Message-ID: <aRUs5Lp7RM2qx1Gl@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tldr; Just FYI, I'm carrying this on the perf tools tree.

This is one more remnant of the BUILD_NONDISTRO series to make building
with binutils-devel opt-in due to license incompatibility.

In this case just the references at link time were still in place, which
make building the test-all.bin file fail, which wasn't detected before
probably because the last test was done with binutils-devel available,
doh.

Now:

  $ rpm -q binutils-devel
  package binutils-devel is not installed
  $ file /tmp/build/perf-tools/feature/test-all.bin
  /tmp/build/perf-tools/feature/test-all.bin: ELF 64-bit LSB executable, x86-64, version 1 (SYSV),
  dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2,
  BuildID[sha1]=4b5388a346b51f1b993f0b0dbd49f4570769b03c, for GNU/Linux 3.2.0, not stripped
  $

Fixes: 970ae86307718c34 ("perf build: The bfd features are opt-in, stop testing for them by default")
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/feature/Makefile | 4 ++--
 tools/perf/Makefile.config   | 5 ++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 49b0add392b1c11a..95646290cb89cda3 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -107,7 +107,7 @@ all: $(FILES)
 __BUILD = $(CC) $(CFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.c,$(@F)) $(LDFLAGS)
   BUILD = $(__BUILD) > $(@:.bin=.make.output) 2>&1
   BUILD_BFD = $(BUILD) -DPACKAGE='"perf"' -lbfd -ldl
-  BUILD_ALL = $(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=2 -ldw -lelf -lnuma -lelf -lslang $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) -DPACKAGE='"perf"' -lbfd -ldl -lz -llzma -lzstd
+  BUILD_ALL = $(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=2 -ldw -lelf -lnuma -lelf -lslang $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) -ldl -lz -llzma -lzstd
 
 __BUILDXX = $(CXX) $(CXXFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.cpp,$(@F)) $(LDFLAGS)
   BUILDXX = $(__BUILDXX) > $(@:.bin=.make.output) 2>&1
@@ -115,7 +115,7 @@ __BUILDXX = $(CXX) $(CXXFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.cpp,$(
 ###############################
 
 $(OUTPUT)test-all.bin:
-	$(BUILD_ALL) || $(BUILD_ALL) -lopcodes -liberty
+	$(BUILD_ALL)
 
 $(OUTPUT)test-hello.bin:
 	$(BUILD)
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 5700516aa84aec2c..2dd5f5a60568d002 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -354,9 +354,6 @@ FEATURE_CHECK_LDFLAGS-libpython := $(PYTHON_EMBED_LDOPTS)
 
 FEATURE_CHECK_LDFLAGS-libaio = -lrt
 
-FEATURE_CHECK_LDFLAGS-disassembler-four-args = -lbfd -lopcodes -ldl
-FEATURE_CHECK_LDFLAGS-disassembler-init-styled = -lbfd -lopcodes -ldl
-
 CORE_CFLAGS += -fno-omit-frame-pointer
 CORE_CFLAGS += -Wall
 CORE_CFLAGS += -Wextra
@@ -930,6 +927,8 @@ ifdef BUILD_NONDISTRO
 
   ifeq ($(feature-libbfd), 1)
     EXTLIBS += -lbfd -lopcodes
+    FEATURE_CHECK_LDFLAGS-disassembler-four-args = -lbfd -lopcodes -ldl
+    FEATURE_CHECK_LDFLAGS-disassembler-init-styled = -lbfd -lopcodes -ldl
   else
     # we are on a system that requires -liberty and (maybe) -lz
     # to link against -lbfd; test each case individually here
-- 
2.51.1

