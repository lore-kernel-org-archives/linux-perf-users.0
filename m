Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22D11FC7DB
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jan 2025 19:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736883362; cv=none; b=h2FuUvpti302joiMCKMy8dNcFzH0hvuw6RVFiuQbUwo7bPgsCQxpRiYJIA1D5Oyzofkg1iGcgJyxuVzy75pEU+aCqycY8x8sQtR7xkq5Sz96FsfX1h2yJ/VyWBuesxsFXwXMZ5GFCTYCXQCquPkAk+bEP/bihkax86zCLrld5u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736883362; c=relaxed/simple;
	bh=O+yA0BcFooderA43nycapEcPhnF2b5ugZ03N5RSt6H4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pQas0cWFN47YRwBGsilQHuahvNl6k1X5nbc62dE3RmhV9vnDDTVG3peA4eqz1yPnAcAMvxF3nfh6GwrBkJUr/7j+KHTWq8OVVdw4/dFA5yhXn/ixptl11BSvgH+6Fo5x0dw8rP7mT8hWmeqG76sAB/qo/OUd81cHw6m0gRVO0kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=vnHolxqZ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="vnHolxqZ"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2165448243fso127901755ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jan 2025 11:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736883360; x=1737488160; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zjPSmGagsH0v8BRh7RqgTWU2umihKyaeHVzwlH5BliU=;
        b=vnHolxqZ9jeF61pO1uWeVOg4BGtxYyb5DJiTacoIEuqoIOqxokhMyb5N+ck9pER4Bl
         fSZBSUGYB1JMxV0ONIc3OZhZ5e9QtFeUlsO2u0GI7Ys8aS1fJblDvrTdce9eJ+6oZPEM
         yII4Ax12G2H73uXHOQIyY5RU5gDJZxNt2h7fgnlEsSnXuZzfr0QeGvXZEK1XAFfwCi3u
         ckR92YkjFwJ14B3bJD+Y7inj9Wrz6cS3p4f06iRJI0ZDbP/GXqx2IXvkxbLpsxHzEPJi
         ulAxerP18nPgGxiTsNegJwhUWWtuFF6V2hlsfGdeEzlPOTdGwniD6uS/HOlz84nNAUMQ
         6q7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736883360; x=1737488160;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zjPSmGagsH0v8BRh7RqgTWU2umihKyaeHVzwlH5BliU=;
        b=Fqe+wX5DCpDMst1094HcOTsIMsRS+klwZapxsKPLw4v8o4xHAXQ6BfLbHKjuudeBb5
         dB+MfFdyA6pETbXvf8BEobfQgYmDeNxK7ehxx+1CbK+DYB1dCnQ9vPo21XSjnlsAqDvW
         y+N8ov4Y3Gv1AUvqeMjS0l9YzlPzm6ZBoksY4DjBodKCQ1xwMl2Cw2GpZ+Pu1R0VRRsC
         L3rbDVPE0/1ppIyn1Iyx6LMez+iR7CiniAL+RBnLnk9tf1oELu0qZg1jERbIgdcgB6bf
         2mT5yRbPo9AB+W0i6VB99hs/lFGla+v48B6k+yvfeNGl+c6wAChImtMupuGf4wJtEmcj
         HQRw==
X-Forwarded-Encrypted: i=1; AJvYcCVj/7N4SnGX5yweY1E0r3IJN0sBvox7uaI6/1hcuu6aF4i9fbfJ1Vrhl/Ih5flwwvoZeu25k0U85eS4JuwY+c+5@vger.kernel.org
X-Gm-Message-State: AOJu0YyE8IucoNvsVD5tcxFctjQ2eDb6gfDjbuheVlqjA8So3+UtRBPj
	A7Q0FWO3m6rcdfn6v46DX+dRhBt6rO+jt2qXvnECas1PGR10VplAuuIZ2UR6okk=
X-Gm-Gg: ASbGncsyngtLno1ePk412WgAUKmKE8frTTGk79aZenRH1ZffAaRACrFi6W+uEgg9r4n
	IBbH+Tj80BKImadra3aL4uc7zIYE7J2iK+9adkZoBJXIkSHeHKs77KyGVH4nqeWjoYAF/c5nFj3
	oSl/nNfASQ/euh/djLhQ3aWEXTingrDkO5jmOQigMPAXFAyD9X5sZYHLdu7lTiOx7DJHc3oWIRE
	z1DcAWymJbQ+20MoQssCjEdpxjAh2mARbnJNovOoBLAl//9JTATB3lj86/ptKasvAsQomwD
X-Google-Smtp-Source: AGHT+IEgEQ10/D4X/vMFHIRsZzWMSEwp0cQc4L0bKoR1oseHYe1ipJQlzxnnAZuOmG10fkB2fgzL1g==
X-Received: by 2002:a05:6a20:c89b:b0:1e1:aef4:9cd0 with SMTP id adf61e73a8af0-1e88d139b44mr40009862637.3.1736883360270;
        Tue, 14 Jan 2025 11:36:00 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a317a07c769sm8491598a12.7.2025.01.14.11.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 11:35:58 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 14 Jan 2025 11:35:44 -0800
Subject: [PATCH FOR-NEXT] perf tools: Expose quiet/verbose variables in
 Makefile.perf
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-perf_make_test-v1-1-decc1c517b11@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAI+8hmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDQ0MT3YLUorT43MTs1PiS1OISXaCQYYpJYoqFhbm5ElBTQVFqWmYF2MB
 oJTf/IF0/14gQpdjaWgCHfi1magAAAA==
X-Change-ID: 20250114-perf_make_test-1141d4ad8877
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 Arnaldo Carvalho de Melo <acme@redhat.com>, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4609; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=O+yA0BcFooderA43nycapEcPhnF2b5ugZ03N5RSt6H4=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3rbnqnejl0F6ecsvs39q3Ts5bNnu7cvFnvp+oZNc4vm5
 V7n/u8nOkpZGMQ4GGTFFFl4rjUwt97RLzsqWjYBZg4rE8gQBi5OAZjI7Y0M/33Xrl5X5eh0cIFq
 UJt83mrJvXmVV1i51kZYiin3vmNZvZORYcvzKPOOdemOtbvtu16f1bfbHZ4exGB+qGziPcb3O/P
 imQE=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

The variables to make builds silent/verbose live inside
tools/build/Makefile.build. Move those variables to the top-level
Makefile.perf to be generally available.

Committer testing:

See the SYSCALL lines, now they are consistent with the other
operations in other lines:
  SYSTBL  /tmp/build/perf-tools-next/arch/x86/include/generated/asm/syscalls_32.h
  SYSTBL  /tmp/build/perf-tools-next/arch/x86/include/generated/asm/syscalls_64.h
  GEN     /tmp/build/perf-tools-next/common-cmds.h
  GEN     /tmp/build/perf-tools-next/arch/arm64/include/generated/asm/sysreg-defs.h
  PERF_VERSION = 6.13.rc2.g3d94bb6ed1d0
  GEN     perf-archive
  MKDIR   /tmp/build/perf-tools-next/jvmti/
  MKDIR   /tmp/build/perf-tools-next/jvmti/
  MKDIR   /tmp/build/perf-tools-next/jvmti/
  MKDIR   /tmp/build/perf-tools-next/jvmti/
  GEN     perf-iostat
  CC      /tmp/build/perf-tools-next/jvmti/libjvmti.o

Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/Makefile.build                | 20 -----------------
 tools/perf/Makefile.perf                  | 37 ++++++++++++++++++++++++++++++-
 tools/perf/tests/shell/coresight/Makefile |  2 +-
 3 files changed, 37 insertions(+), 22 deletions(-)

diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
index 5fb3fb3d97e0fd114e245805809e4fc926b4343e..e710ed67a1b49d9fda11db02821bbd8d36066b44 100644
--- a/tools/build/Makefile.build
+++ b/tools/build/Makefile.build
@@ -12,26 +12,6 @@
 PHONY := __build
 __build:
 
-ifeq ($(V),1)
-  quiet =
-  Q =
-else
-  quiet=quiet_
-  Q=@
-endif
-
-# If the user is running make -s (silent mode), suppress echoing of commands
-# make-4.0 (and later) keep single letter options in the 1st word of MAKEFLAGS.
-ifeq ($(filter 3.%,$(MAKE_VERSION)),)
-short-opts := $(firstword -$(MAKEFLAGS))
-else
-short-opts := $(filter-out --%,$(MAKEFLAGS))
-endif
-
-ifneq ($(findstring s,$(short-opts)),)
-  quiet=silent_
-endif
-
 build-dir := $(srctree)/tools/build
 
 # Define $(fixdep) for dep-cmd function
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index a449d0015536442273a9268b37be34e4757f577a..55d6ce9ea52fb2a57b8632cc6d0ddc501e29cbfc 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -161,12 +161,47 @@ export VPATH
 SOURCE := $(shell ln -sf $(srctree)/tools/perf $(OUTPUT)/source)
 endif
 
+# Beautify output
+# ---------------------------------------------------------------------------
+#
+# Most of build commands in Kbuild start with "cmd_". You can optionally define
+# "quiet_cmd_*". If defined, the short log is printed. Otherwise, no log from
+# that command is printed by default.
+#
+# e.g.)
+#    quiet_cmd_depmod = DEPMOD  $(MODLIB)
+#          cmd_depmod = $(srctree)/scripts/depmod.sh $(DEPMOD) $(KERNELRELEASE)
+#
+# A simple variant is to prefix commands with $(Q) - that's useful
+# for commands that shall be hidden in non-verbose mode.
+#
+#    $(Q)$(MAKE) $(build)=scripts/basic
+#
+# To put more focus on warnings, be less verbose as default
+# Use 'make V=1' to see the full commands
+
 ifeq ($(V),1)
+  quiet =
   Q =
 else
-  Q = @
+  quiet=quiet_
+  Q=@
 endif
 
+# If the user is running make -s (silent mode), suppress echoing of commands
+# make-4.0 (and later) keep single letter options in the 1st word of MAKEFLAGS.
+ifeq ($(filter 3.%,$(MAKE_VERSION)),)
+short-opts := $(firstword -$(MAKEFLAGS))
+else
+short-opts := $(filter-out --%,$(MAKEFLAGS))
+endif
+
+ifneq ($(findstring s,$(short-opts)),)
+  quiet=silent_
+endif
+
+export quiet Q
+
 # Do not use make's built-in rules
 # (this improves performance and avoids hard-to-debug behaviour);
 MAKEFLAGS += -r
diff --git a/tools/perf/tests/shell/coresight/Makefile b/tools/perf/tests/shell/coresight/Makefile
index b070e779703e9fbd70f88c826172b2150ee3d302..fa08fd9a5991dd889583edc1afe8304e72278f64 100644
--- a/tools/perf/tests/shell/coresight/Makefile
+++ b/tools/perf/tests/shell/coresight/Makefile
@@ -24,6 +24,6 @@ CLEANDIRS = $(SUBDIRS:%=clean-%)
 
 clean: $(CLEANDIRS)
 $(CLEANDIRS):
-	$(call QUIET_CLEAN, test-$(@:clean-%=%)) $(Q)$(MAKE) -C $(@:clean-%=%) clean >/dev/null
+	$(call QUIET_CLEAN, test-$(@:clean-%=%)) $(MAKE) -C $(@:clean-%=%) clean >/dev/null
 
 .PHONY: all clean $(SUBDIRS) $(CLEANDIRS) $(INSTALLDIRS)

---
base-commit: e9cbc854d8b148e3491291fb615e94261970fb54
change-id: 20250114-perf_make_test-1141d4ad8877
-- 
- Charlie

