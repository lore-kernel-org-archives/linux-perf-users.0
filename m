Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCD1178372
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Feb 2026 18:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770922698; cv=none; b=IKtFhicwNOlorlWVXf/Yw665cpWIX7mNPStabQnVIbOqxi60XWwaacPEZvYWcuYRpYeakVCu0MQRews+lyF7AOua4NiCwYNin+aD9K7mHKKoW1WZMx5JYSuno22tQPbre0Q7PJmCx4tBFxRa8y+0sN8cbBEJ4GdEeNAR6lOhRNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770922698; c=relaxed/simple;
	bh=jaCplkj9P/whtB6A5OAwLdYg/wLmlg32rjwvrTXxAjE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FUWusETkM7Ox4RL3tYvySgjTnahxzzAk+1St0ZmIM+dNTVlcEv62Nuv04oeZhIiw89WPI8KjKtcUjMPqVE13gKjbQWyKX5QeOXOTCMQcTlUH3dL3O4AtppfENFPjggKVX/SgXqqULvFVummfmG4J8sEUFAdygMu1AJXw0ttkHhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFwFomJd; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFwFomJd"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b88593aa4dcso9409766b.3
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Feb 2026 10:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770922695; x=1771527495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w7koUxEnJ8qJTQm6zEGAuSnrRJGm+RijWpLIoq7B1u4=;
        b=kFwFomJdQFbOhNL04C/JzKM4sep4pnI45bobC3v8VecblR9i33nYPGAstx0h701tok
         Pl3Qsho7jqnrs0DrKaqQCglSEc+ev6jC1+7lOlHga6vP2SSmjgMKT8589Z8nVsTzUcTV
         pbTbtqFeu0b7wOJvmVU1P0cTZdNgnH6mpt1zu2sB7+Gk6hGOndBr8EqyETOOLufmwSjw
         Xx/gxQbPONqzLUfv8iaVxxEVobCK/HbIkn0qpa7n1/0f0YhycgtRCKpQk3hBFyVjG56h
         7Maievo1A8o5M+MAJ/P4YVPstRKCZ9ap4v4o4Gd9H1GFLVKzLZoSojahGgtgkY89m7wN
         jROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770922695; x=1771527495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w7koUxEnJ8qJTQm6zEGAuSnrRJGm+RijWpLIoq7B1u4=;
        b=lhGDMMeHEbiNQiCyRpIwJ/Zq9/6ftQnyOcyZ6pZa2JRpYYgzXMtEWOpiuPcrJ8Lpkp
         yucrpAZNQdShKo0s41dtmEFtiYmk16vPXtxJxTRSnc76NSRQpLIttHcP43KY4+VIpFY2
         /lS1kdzXrqhCaHKk9iu6gD0sWtzeQ1OPI3LT/tbcq+XsewvyqadtbKTOlmCqKNYiRoi6
         VoIV+MetHCFW0g3g/2CfiftxZT7CEr5V6KHPUXx0uhlXV+oousrtw+gKZ7kGc5Aj7MHD
         RsZlTERS3td10bMHoaFX7go3xNthxO0VbzCmcy7DBZ5aSo+Rmit8hlOKzALjIAPjtnCp
         3Ifw==
X-Gm-Message-State: AOJu0Yz+3DDr4wAwgKPsdB7GxWrvh4F0OL3KVV0a62gJRNwidNPdM6VX
	lJJ+Qy3Ak66pYuFeXIItsBnWhOetX8PntozGHrSTfCwureWWYZbZIDgfWiidrQ==
X-Gm-Gg: AZuq6aLlQUUGy4mZSp+MzS4v8GYPvwtW2Vj0u8aSSRsAlkeuSXrk/mvzMQinVedtqI/
	hxaaB0QiUHtJwIDMcYJshvxRsl54lxGvXvRPJXcWk0RtHxNNGE8gybtL3bEpJhpN22PK+UDAzdB
	hr/E3HJpvGibUoT49sqnBMW7alz50EdMRe+4c8pJhKuhePVJUK2ulZMRMwxnrhGcMVu3VxmqECS
	2CGBh/OOfb0VNUZHgf1lZdc74kYRATDRdYDHNSkRQvDHFlWpkkcf5OKWOZteeNeAP7U/68/MhQt
	LfV46LO2fPFcE1BBO2uVdieunk5aU7mfFQ+N52CDrbDRyqpHIJ+Drs2DnV3t3YWTaaKNuLmpvKQ
	9HvEPTv9RqhiD1s6IdricWeimz/0SXp7aMSpOjXjM13iifieVa3pkzkJjvIbZ5rHswbCn44jZtQ
	Hof6HnlG3DwZyQAUTXFdX9LgEGbj6Eo9ReOOnAnltKiUuivYBUl6yRAVLUCqcrRnZ7kMJ5xGeXL
	CMFNYCFGXT112erRPAAIYhqezktwAk=
X-Received: by 2002:a17:907:db02:b0:b8f:1c:e815 with SMTP id a640c23a62f3a-b8face16a1cmr1899266b.48.1770922695262;
        Thu, 12 Feb 2026 10:58:15 -0800 (PST)
Received: from ddolgov-thinkpadt14sgen1.local (dslb-002-207-075-089.002.207.pools.vodafone-ip.de. [2.207.75.89])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8f7a48890esm161664466b.65.2026.02.12.10.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 10:58:14 -0800 (PST)
From: Dmitrii Dolgov <9erthalion6@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [PATCH v1] tools build: Fix rust cross compilation
Date: Thu, 12 Feb 2026 19:57:14 +0100
Message-ID: <20260212185810.648364-1-9erthalion6@gmail.com>
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
"aarch64-linux-gnu" instead of "aarch64-unknown-linux-gnu". Thus provide
an explicit RUST_TARGET_ARCH, and if not specified, try to match
the CROSS_COMPILE value.

Tested using arm64 cross-compilation example from [1].

[1]: https://perfwiki.github.io/main/arm64-cross-compilation-dockerfile/

Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
---
 tools/build/Build.include  |  9 +++++++++
 tools/perf/Makefile.config | 18 ++++++++++++++++++
 tools/perf/Makefile.perf   |  4 +++-
 3 files changed, 30 insertions(+), 1 deletion(-)

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
index a8dc72cfe48..9b164b442da 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1163,6 +1163,24 @@ ifndef NO_RUST
     CFLAGS += -DHAVE_RUST_SUPPORT
     $(call detected,CONFIG_RUST_SUPPORT)
   endif
+
+  ifneq ($(CROSS_COMPILE),)
+    ifneq ($(RUST_TARGET_ARCH),)
+      RUST_FLAGS += --target=$(RUST_TARGET_ARCH)
+    else
+      # CROSS_COMPILE specifies the target triple, which may not match what
+      # Rust expects, e.g. it can omit the target vendor if C toolchain is
+      # used. For example the value can be aarch64-linux-gnu, where Rust uses
+      # aarch64-unknown-linux-gnu. Try to match that and insert an "unknown"
+      # vendor if omitted.
+      TRIPLE := $(subst -, ,$(CROSS_COMPILE:%-=%))
+      ifeq ($(words $(TRIPLE)),3)
+        RUST_FLAGS += --target=$(word 1,$(TRIPLE))-unknown-$(word 2,$(TRIPLE))-$(word 3,$(TRIPLE))
+      else
+        RUST_FLAGS += --target=$(CROSS_COMPILE:%-=%)
+      endif
+    endif
+  endif
 endif
 
 # Among the variables below, these:
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index a6d8ca3e923..621800e1716 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -17,6 +17,8 @@ include ../scripts/utilities.mak
 #
 # Define CROSS_COMPILE as prefix name of compiler if you want cross-builds.
 #
+# Define RUST_TARGET_ARCH as rust target arch if you want cross-builds.
+#
 # Define LIBPERL to enable perl script extension.
 #
 # Define NO_LIBPYTHON to disable python script extension.
@@ -271,7 +273,7 @@ ifeq ($(PYLINT),1)
   PYLINT := $(shell which pylint 2> /dev/null)
 endif
 
-export srctree OUTPUT RM CC CXX RUSTC LD AR CFLAGS CXXFLAGS V BISON FLEX AWK
+export srctree OUTPUT RM CC CXX RUSTC LD AR CFLAGS CXXFLAGS RUST_FLAGS V BISON FLEX AWK
 export HOSTCC HOSTLD HOSTAR HOSTCFLAGS SHELLCHECK MYPY PYLINT
 
 include $(srctree)/tools/build/Makefile.include

base-commit: 5d1ab659fb93eed85d6d8b2937013360157032f4
-- 
2.52.0

