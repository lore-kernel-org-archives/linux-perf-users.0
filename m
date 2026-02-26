Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865EC426ED8
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Feb 2026 17:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772125238; cv=none; b=oXddj6AciasWaOOVVFUc8/+X3O6dWas/TuWRLfBvu5ORUL8R+IFV+wCh5dEGoMt0NysJC8k1B+D4EtxTaz0O3GH8cf2VPypqBrOYmbomor6GcdgOrhro2/JPGyxdmKrpurssOzMTAgn02GI6vgTspxuosMqHGN5lIErM/fwaKqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772125238; c=relaxed/simple;
	bh=aUmpyzSrby1qhl5sgoZlhWbu9bvueo80bPZ+F/4kLzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q0JKDS3l/a/+g3MnaAlWk43ueahHHxsvFRtLkcIo03sh9NraBerYn5JYwiVx2CZaiQxdrXekNivYRwy5dMzFBsJL/9jYpDvXmb+L/Vh399evINYjmT/Q1+LYfPwt0z33mbu4qQHGMmOldsC1/aK77U7/WRGWG1KSylr7q6SSlts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfCqnO6v; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfCqnO6v"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-65c187dfc82so1798650a12.2
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Feb 2026 09:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772125234; x=1772730034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ALqBvDE1FO+pe4+Grs49xjYdZp5dzbvZUUI22o6rYDw=;
        b=IfCqnO6vfhmLflYdiMHsOaSyjTm6lB4X9+UuCJfqLTQ14vkh+aRFUta5VUI45L33IO
         X5Ts9D4whddgELe8593teHhtfioPSF3JOpJNZ/zYnlLotFp6yctZzYwc+YfpmA/6PZri
         i7bpd1cfGssKnlZOJ9YY9Ds72DYpUEydm8HrCXWZlHTOzgv05IXZeRAlGS4R72qr+qNS
         Qey28boiqFD+971y4TZxKF9fOXr9h+6o8+lp83gD9fFgEkVvny0dOfFrK2FsDUZc+hze
         72nyJ9jGi4SwulRR2VXjbj7zXgWPW61eFQcDN6p7xV2Lcgh7KthcThnUsEGmA+eqh5+K
         CRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772125234; x=1772730034;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALqBvDE1FO+pe4+Grs49xjYdZp5dzbvZUUI22o6rYDw=;
        b=alHbinOeVDO9Pvv3ZoBz9gfaP3ekB6R2l6FhRZdTt1Pfm4dGbv2/KWa25fl+jSHuBY
         CuZ8spnlqEyrQQ9WBTdVRAUOKOpoN7P2y9V6/iMg/7zWWOKjoeUehJ5DpausW3DcJQhu
         3ItS3tLsobCP4UV0sMjpDGpJaEaufetMPUJGFrrqTFSJsG1XNwtoV5JK0mPWWUClI3Ma
         r6Fl9lP8JhF7gJudicaUpfPjVMJROCmCYEgbGoYeGbWLzrPb/zGxYf/hqAyjjN1zwzWs
         3kRPiF3R9oTb7RzVqrS5VPk8sCkue5dCUJSqYzqpi0zQPuXDxjoqBWBOtYUcseGGnWHJ
         m0Tg==
X-Gm-Message-State: AOJu0YyJwUTOFVkVjJY0nbspv3/OtWCuIvWimRZ3MbpkA5DfbsnK71ku
	vAQP5D+ZPGF1kBVukq4OWO3RFyuG/NdQXD1CHyh6U3p1LIn+jNb78G3jvRaz2A==
X-Gm-Gg: ATEYQzyH3QR74VcxbbnzDLNkBBpWHM4ax7PIceIiafgd5k8T18IaDvaIBkbuMmRjsNP
	piXkb8RVR468bfsm42AyaL6YIaF+NNos8IeExhGbXrwsJARC32VqNcwFxCH7XKClbHRi1Bi8H28
	stsDFyXmHavHDqZt5ZoqZERtUbR0FXGojspwun/WouNZ/RxBQAR56Chx3jDQBF7rTIRJSmtLURq
	GCI3Hd3YmFf3ljJCWqb7IjaDvpdkgdkeQJfa8aSLSsinoGQher2LkP16L7BDg+wZ5EGsXMSt1Mk
	oMJ9hjEUyAaRVX9Md4S+085DlayKSE24qxpdT1sJZqA0axGHnpTt+9N+ycYvTAzSLwdBMBxKcgO
	rFxLUL3idpLclpK6Q7ylmejGBivE4xZ5oA5Qqw11mfffvjYNkb7cuR2gftpmmvBySxmAikwmP3L
	WGNLZs1gqms4agiwqfcsM4kluFMYRMpvwzJfWabVDPRpU9wSbq9nS3Of+OeA==
X-Received: by 2002:a17:907:6d13:b0:b93:335f:18d5 with SMTP id a640c23a62f3a-b935b8ea035mr225250866b.36.1772125233377;
        Thu, 26 Feb 2026 09:00:33 -0800 (PST)
Received: from ddolgov-thinkpadt14sgen1.rmtde.csb ([2a00:20:6364:854a:4ce7:5ea2:2f05:232b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935ac7371esm77838766b.24.2026.02.26.09.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 09:00:32 -0800 (PST)
From: Dmitrii Dolgov <9erthalion6@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Levi Zim <i@kxxt.dev>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	rust-for-linux <rust-for-linux@vger.kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [PATCH v5] tools build: Fix rust cross compilation
Date: Thu, 26 Feb 2026 17:59:59 +0100
Message-ID: <20260226170025.517743-1-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently no target is specified to compile rust code when needed, which
breaks cross compilation. E.g. for arm64:

      LD      /tmp/build/tests/workloads/perf-test-in.o
    aarch64-linux-gnu-ld: /tmp/build/tests/workloads/code_with_type.a(code_with_type.code_with_type.d12f4324cb53c560-cgu.0.rcgu.o): Relocations in generic ELF (EM: 62)
    aarch64-linux-gnu-ld: /tmp/build/tests/workloads/code_with_type.a(code_with_type.code_with_type.d12f4324cb53c560-cgu.0.rcgu.o): Relocations in generic ELF (EM: 62)
    [...repeated...]
    aarch64-linux-gnu-ld: /tmp/build/tests/workloads/code_with_type.a(code_with_type.code_with_type.d12f4324cb53c560-cgu.0.rcgu.o): Relocations in generic ELF (EM: 62)
    aarch64-linux-gnu-ld: /tmp/build/tests/workloads/code_with_type.a(code_with_type.code_with_type.d12f4324cb53c560-cgu.0.rcgu.o): Relocations in generic ELF (EM: 62)
    aarch64-linux-gnu-ld: /tmp/build/tests/workloads/code_with_type.a: error adding symbols: file in wrong format
    make[5]: *** [/perf/tools/build/Makefile.build:162: /tmp/build/tests/workloads/perf-test-in.o] Error 1
    make[4]: *** [/perf/tools/build/Makefile.build:156: workloads] Error 2
    make[3]: *** [/perf/tools/build/Makefile.build:156: tests] Error 2
    make[2]: *** [Makefile.perf:785: /tmp/build/perf-test-in.o] Error 2
    make[2]: *** Waiting for unfinished jobs....
    make[1]: *** [Makefile.perf:289: sub-make] Error 2
    make: *** [Makefile:76: all] Error 2

Detect required target and pass it via rust_flags to the compiler.

Note that CROSS_COMPILE might be different from what rust compiler
expects, since it may omit the target vendor value, e.g.
"aarch64-linux-gnu" instead of "aarch64-unknown-linux-gnu". Thus
explicitly map supported CROSS_COMPILE values to corresponding Rust
versions, as suggested by Miguel Ojeda.

Tested using arm64 cross-compilation example from [1].

Fixes: 2e05bb52a12 ("perf test workload: Add code_with_type test workload")
Link: https://perfwiki.github.io/main/arm64-cross-compilation-dockerfile/ [1]
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
---
Changes in v5
- Error out if the target arch is not covered

Changes in v4
- Fixed incorrect target name for riscv

Changes in v3
- Improved commit message, add an example of the compilation failure

Changes in v2:
- Map supported CROSS_COMPILE values to corresponding Rust targets

 tools/build/Build.include  |  9 +++++++++
 tools/perf/Makefile.config | 18 ++++++++++++++++++
 tools/perf/Makefile.perf   |  2 +-
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/tools/build/Build.include b/tools/build/Build.include
index e45b2eb0d24..cd0baa7a168 100644
--- a/tools/build/Build.include
+++ b/tools/build/Build.include
@@ -98,6 +98,15 @@ c_flags_2 = $(filter-out $(CFLAGS_REMOVE_$(basetarget).o), $(c_flags_1))
 c_flags   = $(filter-out $(CFLAGS_REMOVE_$(obj)), $(c_flags_2))
 cxx_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@ $(CXXFLAGS) -D"BUILD_STR(s)=\#s" $(CXXFLAGS_$(basetarget).o) $(CXXFLAGS_$(obj))
 
+###
+# Rust flags to be used on rule definition, includes:
+# - global $(RUST_FLAGS)
+# - per target Rust flags
+# - per object Rust flags
+rust_flags_1 = $(RUST_FLAGS) $(RUST_FLAGS_$(basetarget).o) $(RUST_FLAGS_$(obj))
+rust_flags_2 = $(filter-out $(RUST_FLAGS_REMOVE_$(basetarget).o), $(rust_flags_1))
+rust_flags   = $(filter-out $(RUST_FLAGS_REMOVE_$(obj)), $(rust_flags_2))
+
 ###
 ## HOSTCC C flags
 
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index a8dc72cfe48..15fbba9f4ca 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1163,6 +1163,24 @@ ifndef NO_RUST
     CFLAGS += -DHAVE_RUST_SUPPORT
     $(call detected,CONFIG_RUST_SUPPORT)
   endif
+
+  ifneq ($(CROSS_COMPILE),)
+    RUST_TARGET_FLAGS_arm	:= arm-unknown-linux-gnueabi
+    RUST_TARGET_FLAGS_arm64	:= aarch64-unknown-linux-gnu
+    RUST_TARGET_FLAGS_m68k	:= m68k-unknown-linux-gnu
+    RUST_TARGET_FLAGS_mips	:= mipsel-unknown-linux-gnu
+    RUST_TARGET_FLAGS_powerpc	:= powerpc64le-unknown-linux-gnu
+    RUST_TARGET_FLAGS_riscv	:= riscv64gc-unknown-linux-gnu
+    RUST_TARGET_FLAGS_s390	:= s390x-unknown-linux-gnu
+    RUST_TARGET_FLAGS_x86	:= x86_64-unknown-linux-gnu
+    RUST_TARGET_FLAGS_x86_64	:= x86_64-unknown-linux-gnu
+
+    ifeq ($(RUST_TARGET_FLAGS_$(ARCH)),)
+      $(error Unknown rust cross compilation architecture $(ARCH))
+    endif
+
+    RUST_FLAGS += --target=$(RUST_TARGET_FLAGS_$(ARCH))
+  endif
 endif
 
 # Among the variables below, these:
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 11b63bafdb2..f7b936deeaa 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -274,7 +274,7 @@ ifeq ($(PYLINT),1)
   PYLINT := $(shell which pylint 2> /dev/null)
 endif
 
-export srctree OUTPUT RM CC CXX RUSTC LD AR CFLAGS CXXFLAGS V BISON FLEX AWK
+export srctree OUTPUT RM CC CXX RUSTC LD AR CFLAGS CXXFLAGS RUST_FLAGS V BISON FLEX AWK
 export HOSTCC HOSTLD HOSTAR HOSTCFLAGS SHELLCHECK MYPY PYLINT
 
 include $(srctree)/tools/build/Makefile.include

base-commit: c5a244bf17caf2de22f9e100832b75f72b31d3e6
-- 
2.52.0

