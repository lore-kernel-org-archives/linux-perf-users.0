Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79364214A66;
	Fri,  4 Apr 2025 18:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743792922; cv=none; b=gT9jVsIxKNYDTCWjZqoYb15Lgu5tQmce4jbK3Erm7RLbOl2YpvgbRfzXXQJ+HMxsTW7sm9Y8E61NBRknUA5aurScRTbXGSBkP/loGCW0RU8vY/bYPUXk3xBKgBSyLUG85BxRj6uE+PmxlsQq2RMJhIy2rft0B/P1nDpDBsQ20yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743792922; c=relaxed/simple;
	bh=uGvJX+mVnoGeSQaFeYRrOHhVGthxAFm4BVArWwobaPM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jhVmYMsO0Lx1z3jacPd/XKFl29YWfGnGR8krFSp+qQwoVipe/oHDUbDmR9wt4CRFOj7+lgWvQUOJggtHp2xKcxqsWsUhc3drycr3GSBC1K6gp7AmZyqgjwgmD2Ngca+3v9Y5QeAq+Dn1tO42+UGcH6Ir0dLvBJKHYqQWY2O3/Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdZUHwDt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdZUHwDt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9687BC4CEDD;
	Fri,  4 Apr 2025 18:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743792921;
	bh=uGvJX+mVnoGeSQaFeYRrOHhVGthxAFm4BVArWwobaPM=;
	h=Date:From:To:Cc:Subject:From;
	b=fdZUHwDt5V7O6Ws1ZS+XAZR8SGCtDi531ewHlkgaUueJ1e2HlcM4QnznvPaO2iluD
	 XYSlmxeye4HdbpSy9FC9bIIg6E4BZ3z/Ggl4YvNY0oTHxxI+T4sEOfFPegNUHdVNOS
	 nVUmSAwttE/EXdUl3+vTeztukRNqRHoyGaoMAGLxcKP2eatQqXr3Jr95zusIcfJXMT
	 T0YYW+h/41hWedDd94F8GOzTIj7++oOu4n57nZndrKSvByNE/Umy4xovN/8iijGafF
	 4GmRcVyt5y05PlljXIzuktxMWopoiOWwia7vZ2JOGDRwMQtRBya2WJF+0TyFEeykXO
	 Z7Gz7pZq1QhoA==
Date: Fri, 4 Apr 2025 15:55:18 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
	Dmitry Vyukov <dvyukov@google.com>, Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] tools build: Don't set libunwind as available if
 test-all.c build succeeds
Message-ID: <Z_ArFrHU7hMNUOv3@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The tools/build/feature/test-all.c file tries to detect the expected,
most common set of libraries/features we expect to have available to
build perf with.

At some point libunwind was deemed not to be part of that set of
libraries, but the patches making it to be opt-in ended up forgetting
some details, fix one more.

Testing it:

  $ rm -rf /tmp/build/$(basename $PWD)/ ; mkdir -p /tmp/build/$(basename $PWD)/
  $ rpm -q libunwind-devel
  libunwind-devel-1.8.0-3.fc40.x86_64
  $ make -k LIBUNWIND=1 CORESIGHT=1 O=/tmp/build/$(basename $PWD)/ -C tools/perf install-bin |& grep unwind && ldd ~/bin/perf | grep unwind
  ...                               libunwind: [ on  ]
    CC      /tmp/build/perf-tools-next/arch/x86/tests/dwarf-unwind.o
    CC      /tmp/build/perf-tools-next/arch/x86/util/unwind-libunwind.o
    CC      /tmp/build/perf-tools-next/util/arm64-frame-pointer-unwind-support.o
    CC      /tmp/build/perf-tools-next/tests/dwarf-unwind.o
    CC      /tmp/build/perf-tools-next/util/unwind-libunwind-local.o
    CC      /tmp/build/perf-tools-next/util/unwind-libunwind.o
	  libunwind-x86_64.so.8 => /lib64/libunwind-x86_64.so.8 (0x00007f615a549000)
	  libunwind.so.8 => /lib64/libunwind.so.8 (0x00007f615a52f000)
  $ sudo rpm -e libunwind-devel
  $ rm -rf /tmp/build/$(basename $PWD)/ ; mkdir -p /tmp/build/$(basename $PWD)/
  $ make -k LIBUNWIND=1 CORESIGHT=1 O=/tmp/build/$(basename $PWD)/ -C tools/perf install-bin |& grep unwind && ldd ~/bin/perf | grep unwind
  Makefile.config:653: No libunwind found. Please install libunwind-dev[el] >= 1.1 and/or set LIBUNWIND_DIR
  ...                               libunwind: [ OFF ]
    CC      /tmp/build/perf-tools-next/arch/x86/tests/dwarf-unwind.o
    CC      /tmp/build/perf-tools-next/arch/x86/util/unwind-libdw.o
    CC      /tmp/build/perf-tools-next/util/arm64-frame-pointer-unwind-support.o
    CC      /tmp/build/perf-tools-next/tests/dwarf-unwind.o
    CC      /tmp/build/perf-tools-next/util/unwind-libdw.o
  $

Should be in a separate patch, but tired now, so also adding a message
about the need to use LIBUNWIND=1 in the output when its not available,
so done here as well.

So, now when the devel files are not available we get:

  $ make -k LIBUNWIND=1 CORESIGHT=1 O=/tmp/build/$(basename $PWD)/ -C tools/perf install-bin |& grep unwind && ldd ~/bin/perf | grep unwind
  Makefile.config:653: No libunwind found. Please install libunwind-dev[el] >= 1.1 and/or set LIBUNWIND_DIR and set LIBUNWIND=1 in the make command line as it is opt-in now
  ...                               libunwind: [ OFF ]
  $

Fixes: 13e17c9ff49119aa ("perf build: Make libunwind opt-in rather than opt-out")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/lkml/Z_AnsW9oJzFbhIFC@x1
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/Makefile.feature | 1 -
 tools/perf/Makefile.config   | 4 +++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 1931b6321314684c..54c8adfb94662c03 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -87,7 +87,6 @@ FEATURE_TESTS_BASIC :=                  \
         libtracefs                      \
         libcpupower                     \
         libcrypto                       \
-        libunwind                       \
         pthread-attr-setaffinity-np     \
         pthread-barrier     		\
         reallocarray                    \
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index eea95c6c0c71f76e..8ff1d8ade73fc061 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -624,6 +624,8 @@ endif
 ifndef NO_LIBUNWIND
   have_libunwind :=
 
+  $(call feature_check,libunwind)
+
   $(call feature_check,libunwind-x86)
   ifeq ($(feature-libunwind-x86), 1)
     $(call detected,CONFIG_LIBUNWIND_X86)
@@ -648,7 +650,7 @@ ifndef NO_LIBUNWIND
   endif
 
   ifneq ($(feature-libunwind), 1)
-    $(warning No libunwind found. Please install libunwind-dev[el] >= 1.1 and/or set LIBUNWIND_DIR)
+    $(warning No libunwind found. Please install libunwind-dev[el] >= 1.1 and/or set LIBUNWIND_DIR and set LIBUNWIND=1 in the make command line as it is opt-in now)
     NO_LOCAL_LIBUNWIND := 1
   else
     have_libunwind := 1
-- 
2.48.1

