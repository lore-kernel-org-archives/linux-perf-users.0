Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CA3325737
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Feb 2026 08:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771404482; cv=none; b=B+eIbjU6H8BO9IdLJyb1I05T8vtbNxMkONBEygoTVX7duTqtzYUWSAOtdfnFY5EgBcec9J7jyWQ5CNNih+npP+XWspc28J4vFiaLw+84wu1e2SlRXkTHT3H+P0Mqa8QAhm3Qt7V78iSBrGO5LgUHFoQKqGBYB85u7bt1oq8esdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771404482; c=relaxed/simple;
	bh=db8UoqXBuWlXRrOvDWR6NTe1jADOw1CPeFcMqQs31ok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DyK3qS43O92a5VzZPdpIjEOkIXCnmU7WM6VqS9S5CUL5MK5dv8oYqWoUIUD1OaYWNizYU/G/Dld7mguMMR4K6hXq1js7DWwe/fvC9ggyS49v5kqov7+ThH/WHiVdw6vUiam8vWtw0ggiRdLyn9xqmEdCZkDOO1+XuVP5S4YiMiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ia9dWHdk; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ia9dWHdk"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-65b9608a9adso8716164a12.3
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Feb 2026 00:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771404478; x=1772009278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E/5hsVF/ES9WFVEKAhexr1uhkj6T0T0kWE33e5/ideo=;
        b=ia9dWHdkFSmapGtt7InHJ9ylZD+FIhNJxzak6qdgRKDs5NaLvhPrmo1fG76sZrOPFr
         BeZdgy5FdFiN1xPCOzb8Ica/ZaAfR6L//kzmfy68vAbl/aIakPgdi46CAtQYY+3PhKxU
         dT+2Hf5YHFR1idOH0aWXNU2Rn3E+ydmWZF2hm8jfX2zk1eSTPL/ZU+desn/rZuRzLABq
         z+2jBVPo6SaumzydqAVwmA4442Sg4Y88pxLePlfby1+Zno0oMv2s+Z6Gu30h5UhRYRQ8
         DwNCiHfukvrBScxm2cd9vjBDSxN47dZvK67FrKsN9CyzSpKKCV5tnbnc0dvm0ZuZb4T/
         gZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771404478; x=1772009278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/5hsVF/ES9WFVEKAhexr1uhkj6T0T0kWE33e5/ideo=;
        b=W6aT/PanazT9TUfUe1Gb2ns3/Q+9pMA1pNkyuxmfk6x8u42HOo5DLzICcy1hYOeFcD
         BvYTualEOFuOZFFAzddc2WneSZLuqGQyNIgyOuSCk3L88L8vxTrxzyIsNwsQBlxMZtBd
         cMGM9Er6sw9kBFCgEgxuTvgF1X3IzQgOM+6nqsRdHnfONx8iQLR2B6PcUW3vm65/Bm1T
         vIiqGgmo2Vs7DTj1ts3s8PihBQQL349UX4DNOpfv8/ti9WLLU7rKNwiVUAj1l+IpKuR8
         q22DJtydj9/hjeWvgimYO3m+w5JeisjPP3egnirEZXBqGV8ZEPdovJE4x4jYN9lX3s5u
         i8DA==
X-Gm-Message-State: AOJu0YwNa44faG9Su4skIAwcsIw7gydJgcixgl1Id371AFQReChmUIDD
	BF94EKSVkgsPbBma2mquHzXghMDqmhOSmkQofLm58zuAuYMe/oGcaWcdgDCtmw==
X-Gm-Gg: AZuq6aKXe07ys1cfSj8pZp6rsJOUybT1E+JAEZqHRX5PQ90/KiW6LqcA7GSl0sXLGGD
	L48oxE3OM4odIyMThklTViTJRezIDV4dp15LkMZfnlI8Fy6y10l67TngqZGr8/shiIEsJimBPss
	Zrqjq7Ml0A4GQ3YXM/+xSakBHVoXY9vid0gBvf6DX6AwQtmNj12bn9pw0zn4X7XqxLCkE/1WxR6
	Hpd8rYQc7igORpsSa0a9hKlFWcB8H6vQTSmJrsloLLcnnymLmrA7qLGHTa+6zMqLk/CAfW0aCqZ
	i5oqLN4P5/scBZQGDd0GeR3+bQW27SZGfMCUyrHUhsTuO7TvjscJXW4DUCJVkWt40BbNbiksSfK
	V4T6AZ/1kWgYtKpJ7lam3sCHFh2bACu9YpYoVBosnxdYD2L0Y6CsZyGqxD5TkEySORI3f1OfoOl
	GacTk6qNRcA4/hTrSB9LfiG/q/Bg9VbVBoQEGV9bl/A71e+JCnN9tVLr4mOFT0HOtZkpy9WyqwF
	44pybBFK9Sv56Vv9hk8wXYFO4VFkxU=
X-Received: by 2002:a17:906:6a28:b0:b8f:a195:bad8 with SMTP id a640c23a62f3a-b8fc3cb90f5mr718449766b.45.1771404477251;
        Wed, 18 Feb 2026 00:47:57 -0800 (PST)
Received: from ddolgov-thinkpadt14sgen1.local (dslb-002-207-075-089.002.207.pools.vodafone-ip.de. [2.207.75.89])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc7629b56sm447920766b.37.2026.02.18.00.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 00:47:56 -0800 (PST)
From: Dmitrii Dolgov <9erthalion6@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	rust-for-linux <rust-for-linux@vger.kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [PATCH v3] tools build: Fix rust cross compilation
Date: Wed, 18 Feb 2026 09:47:25 +0100
Message-ID: <20260218084736.33114-1-9erthalion6@gmail.com>
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
Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
---
Changes in v3
- Improved commit message, add an example of the compilation failure

Changes in v2:
- Map supported CROSS_COMPILE values to corresponding Rust targets

 tools/build/Build.include  |  9 +++++++++
 tools/perf/Makefile.config | 14 ++++++++++++++
 tools/perf/Makefile.perf   |  2 +-
 3 files changed, 24 insertions(+), 1 deletion(-)

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
index a8dc72cfe48..f40c5a70520 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1163,6 +1163,20 @@ ifndef NO_RUST
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
+    RUST_TARGET_FLAGS_riscv	:= riscv64-unknown-linux-gnu
+    RUST_TARGET_FLAGS_s390	:= s390x-unknown-linux-gnu
+    RUST_TARGET_FLAGS_x86	:= x86_64-unknown-linux-gnu
+    RUST_TARGET_FLAGS_x86_64	:= x86_64-unknown-linux-gnu
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

base-commit: dbf0108347bdb5d4ccef8910555b16c1f1a505f8
-- 
2.52.0

