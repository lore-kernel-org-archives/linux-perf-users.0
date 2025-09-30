Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EBD3081A5;
	Tue, 30 Sep 2025 16:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759251335; cv=none; b=eeE9qA/+oGuSR88trI4g7SGU0WtngFSY4LjsJRM7NMN7TL2mjbsybPGKeaj62dYPqPAd1cuA+EPx2xfLrN5dVYKDutd4GiJTSiSCAtEf0awa90/+aIkqaQ5HRiR7tR0CkZDWvnqGhW8evxAfgN7SKwtbREJaNT/Qf8pT4WwCmVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759251335; c=relaxed/simple;
	bh=miZL6Yzqk6/EUWPBBeudxyQE12NEiBHtXzL1MUUXC30=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RK6WPfto/qPfh9PHaPTiWLpIvwv5RZVDlECR0DSuQHqeitEg1kPRlx/yTaPR6RbuQB/ooadC2xVpYhGHWBTo0URFrfC1V1iixw+YjdO9BvojVnSDBeN7ZLEkuR1kIxS8eoj8vYoljPZ0LqrYqKAcA15662Gk25BsUEXJ0AmCf9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0EA6106F;
	Tue, 30 Sep 2025 09:55:25 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F1943F59E;
	Tue, 30 Sep 2025 09:55:31 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 30 Sep 2025 17:54:55 +0100
Subject: [PATCH v2 7/8] perf build: Support build with clang
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-perf_build_android_ndk-v2-7-2ea440b7ef01@arm.com>
References: <20250930-perf_build_android_ndk-v2-0-2ea440b7ef01@arm.com>
In-Reply-To: <20250930-perf_build_android_ndk-v2-0-2ea440b7ef01@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, James Clark <james.clark@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 llvm@lists.linux.dev, linux-riscv@lists.infradead.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759251311; l=2752;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=miZL6Yzqk6/EUWPBBeudxyQE12NEiBHtXzL1MUUXC30=;
 b=MWei7t108/0dA/kXy0ivVqULgek1bY/nXrQfnZA/ANTPxo7folMUdgQgOSBpxfxzC5Cgo+9Fu
 BBwu05SO9FQB5jfviSiUmBw2xM//AI4LOcPrkUAdjauckTx51vIaZbC
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Add support for building perf with clang. For cross compilation, the
Makefile dynamically selects target flag for corresponding arch.

This patch has been verified on x86_64 machine with Ubuntu distro, it
can build successfully for native target, and for cross building Arm64
and s390.

Example: native build on x86_64 / Ubuntu machine:

  $ HOSTCC=clang CC=clang CXX=clang++ make -C tools/perf

Example: cross building s390 target on x86_64 / Ubuntu machine:

  # Install x390x cross toolchain and headers
  $ sudo apt-get install gcc-s390x-linux-gnu g++-s390x-linux-gnu \
         libc6-dev-s390x-cross linux-libc-dev-s390x-cross

  # Build with clang
  $ HOSTCC=clang CC=clang CXX=clang++ \
    ARCH=s390 CROSS_COMPILE=s390x-linux-gnu- \
    make -C tools/perf NO_LIBELF=1 NO_LIBTRACEEVENT=1 NO_LIBPYTHON=1

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/Makefile.config | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 5a5832ee7b53c604ec0d90c5ca7e2bee5bfa6a17..a2b5c291a364cbf331c16384764520dfe330a04c 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -23,8 +23,38 @@ HOSTCFLAGS := $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
 # borrowed from kernel headers depends on it, e.g. put_unaligned_*().
 CFLAGS += -fno-strict-aliasing
 
-# Enabled Wthread-safety analysis for clang builds.
+# Set target flag and options when using clang as compiler.
 ifeq ($(CC_NO_CLANG), 0)
+  CLANG_TARGET_FLAGS_arm	:= arm-linux-gnueabi
+  CLANG_TARGET_FLAGS_arm64	:= aarch64-linux-gnu
+  CLANG_TARGET_FLAGS_m68k	:= m68k-linux-gnu
+  CLANG_TARGET_FLAGS_mips	:= mipsel-linux-gnu
+  CLANG_TARGET_FLAGS_powerpc	:= powerpc64le-linux-gnu
+  CLANG_TARGET_FLAGS_riscv	:= riscv64-linux-gnu
+  CLANG_TARGET_FLAGS_s390	:= s390x-linux-gnu
+  CLANG_TARGET_FLAGS_x86	:= x86_64-linux-gnu
+
+  # Default to host architecture if ARCH is not explicitly given.
+  ifeq ($(ARCH),)
+    CLANG_TARGET_FLAGS := $(shell $(CLANG) -print-target-triple)
+  else
+    CLANG_TARGET_FLAGS := $(CLANG_TARGET_FLAGS_$(ARCH))
+  endif
+
+  ifeq ($(CROSS_COMPILE),)
+    ifeq ($(CLANG_TARGET_FLAGS),)
+      $(error Specify CROSS_COMPILE or add CLANG_TARGET_FLAGS for $(ARCH))
+    else
+      CLANG_FLAGS += --target=$(CLANG_TARGET_FLAGS)
+    endif # CLANG_TARGET_FLAGS
+  else
+    CLANG_FLAGS += --target=$(notdir $(CROSS_COMPILE:%-=%))
+  endif # CROSS_COMPILE
+
+  CC := $(CLANG) $(CLANG_FLAGS) -fintegrated-as
+  CXX := $(CXX) $(CLANG_FLAGS) -fintegrated-as
+
+  # Enabled Wthread-safety analysis for clang builds.
   CFLAGS += -Wthread-safety
 endif
 

-- 
2.34.1

