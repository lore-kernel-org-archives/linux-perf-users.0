Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D033826FA77
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Feb 2026 19:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771009947; cv=none; b=WHZczU/yuchnn1K2DKxWiREAwpaULlLmgRZqwqSlOuQ1pC0A9ZEzfbukL5cNrki4e2TqD3TUtyqSFQWuqs4QeQn+R9iacWmY0/8QL9gwaWrzWLy9CDZvHEK2M9LY8DSyMKNT7+aplto2DgleXYLg6s5Le3e4Ctup3DL076B0RMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771009947; c=relaxed/simple;
	bh=OcH8w7RuyScwYrcF3u0PgWhZiy0vC1nFvdfSLmhr6ao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dFFcBUdEtvDutekua0DS+x+hT+QZM/Yrv8WwfwhmnLHQZYBgjZtehUSLnXu5aUPe/inLHIumUfoJ4xfIAOIQC9+cZa3eaxkrQCePRzcRd7oBDhtwoK2eJw4R+ji3wU9mebttSxiqp1DgyjUBPngnyoxWo5lxlgDdXb4ylB710q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KfKmG/+S; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfKmG/+S"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-65a43a512b0so1436368a12.3
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Feb 2026 11:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771009944; x=1771614744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZpqJAf35CDxn8PSc9O1hec1UhW5JRewyjQeoYcibqk=;
        b=KfKmG/+S5I3jS7qi+NNZtD2TJT/B/XSCTFgYBBgAkw6kMU4v8iC4KwGvE8SzVLFKAD
         ztdL+1st3kRIDvu2auoIi/oGvDEHzV83nptV9i8K2XDb1pUMwFQopfM00UgEzMARHrdi
         EBgxshMgO6gxZD7LzEeNxRTp4HhiBoNe9lUus+q+0F6u9SsEY0k/x93V0252j0L0CUkb
         Liqf3qqcdwJfyjy6+6fDPueamJxgsxNzsYriXIm/rde5XNzborbmf8WRp9wvcBnkRKh0
         SlpElXek8dEdr4hWV+4/XvzNsRcQ8e/ScRrGa3g2cnQHtscFuPklzm09pBsqJVHIQUfU
         tT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771009944; x=1771614744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZpqJAf35CDxn8PSc9O1hec1UhW5JRewyjQeoYcibqk=;
        b=juASoniEF7rxvteqNC+gKaxW6Z2sBGz3FZUxthVr7f15YLYRYfpz93cilC6PeZs1G3
         LzhXzpIQ1L8WR1a1+iLgad3rgDidgCpqazP6zQOZYN1XSAD+FhPElfQMomELQuO+HEET
         ZDMHJrb+6JBx9QtVP5G4Vy/IS8rN682uMtPSQ6vjw6algAKRKumvuALlQ3dJmwPYjBDW
         q3l/sxm3O4xhkLAlGEvwvJ4Q3o4yKpkkyK587QgxVqCKyL8mDNDXnIMXN3bZcshPBd6X
         qcoLXFIlGIte96/ISU7t2MyTycFK4RtPx/A/Q8pPHw3sjyq/keRd2lgYz4XWYghci53m
         /Rpw==
X-Gm-Message-State: AOJu0YwKdDLS6hE9tvzkMdKrbQxU636OVaymSUkuzW6WJxFklrjG14zD
	wMQH/TrMc9i3qmYbbxO7yV2st7szzfLRA3FY8CIaI5BJ2ELQfxwCqg15bndQXw==
X-Gm-Gg: AZuq6aKulYQLNd8LVeuS7skpUl0WHQC1xJat4CyEXcW+Xcye7Pksmfhr3pnSmZ21eyz
	nmX7k7xJAB+r8VwMn7o/6rnixUjvMPbdlloguAy1vKOwWrKUCVfTcquOXKLznkbEs17V0OvP7l8
	l64bLNQHaCciwktnBzQ161q8djY1wtad1RG878aCZXoTTBNz1LfEuo6pwaCRmzwcHu7JeZONGir
	MJhy410dol510AmbiWCUaPrgJQ2knHu0TopAoHHLHzXxKYk2ggtPBzAY8ciR7ugXfxz53UzUYDr
	LV9tNeeQuPp0A71EH1nXjm3X8aoOfyfxhKbWqu+/vohmu/QhaK8Icw9mgaLHZdkL2VXBopO4XxH
	q6ziLmCQLMavM21adWhTtu6LpWtyWrXjaefa3rkA/FtIzj2cU533algIrhEdc+KkO6jZtW+CF5V
	wRaUCBKa531egb9v+/7rZlCZO8ijyVVjd5czHoF512dZwqOnChXxdGAm1DmXQCKQefDOIzYbmAi
	AO54FmFZeXCwOmXbVE2p2KpL3lg4hI=
X-Received: by 2002:a05:6402:398c:b0:65a:3c1b:d87d with SMTP id 4fb4d7f45d1cf-65bb10f4224mr1096630a12.6.1771009943923;
        Fri, 13 Feb 2026 11:12:23 -0800 (PST)
Received: from ddolgov-thinkpadt14sgen1.local (dslb-002-207-075-089.002.207.pools.vodafone-ip.de. [2.207.75.89])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65bad3f0b55sm950830a12.23.2026.02.13.11.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 11:12:23 -0800 (PST)
From: Dmitrii Dolgov <9erthalion6@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	rust-for-linux <rust-for-linux@vger.kernel.org>,
	Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [PATCH v1] tools build: Fix rust cross compilation
Date: Fri, 13 Feb 2026 20:12:09 +0100
Message-ID: <20260213191212.33328-1-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently no target is specified to compile rust code when needed, which
breaks cross compilation. Detect required target and pass it via
rust_flags to the compiler.

Note that CROSS_COMPILE might be different from what rust compiler
expects, since it may omit the target vendor value, e.g.
"aarch64-linux-gnu" instead of "aarch64-unknown-linux-gnu". Thus
explicitly map supported CROSS_COMPILE values to corresponding Rust
versions, as suggested by Miguel Ojeda.

Tested using arm64 cross-compilation example from [1].

[1]: https://perfwiki.github.io/main/arm64-cross-compilation-dockerfile/

Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
---
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
index a6d8ca3e923..f3919838243 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -271,7 +271,7 @@ ifeq ($(PYLINT),1)
   PYLINT := $(shell which pylint 2> /dev/null)
 endif
 
-export srctree OUTPUT RM CC CXX RUSTC LD AR CFLAGS CXXFLAGS V BISON FLEX AWK
+export srctree OUTPUT RM CC CXX RUSTC LD AR CFLAGS CXXFLAGS RUST_FLAGS V BISON FLEX AWK
 export HOSTCC HOSTLD HOSTAR HOSTCFLAGS SHELLCHECK MYPY PYLINT
 
 include $(srctree)/tools/build/Makefile.include

base-commit: 5d1ab659fb93eed85d6d8b2937013360157032f4
-- 
2.52.0

