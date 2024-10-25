Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F85214420
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Oct 2024 17:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729876995; cv=none; b=Vi7W0A/VsPZKUD8TwC9elKbBinh1Fk15JTwoNJFnj9fS25+TdhYSXDoQXlSgZj+yGYugym0CPkYBJ5NrYq5NoCYq5b+sdpbi/Q4J5G3h2VpVnP2VEi+tdHFpCAUNU8BBB7Z9PNhXwzd4pT/jaDHmOBnCvU+edKQDHrUpBVcFbMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729876995; c=relaxed/simple;
	bh=Fd8jVS+hLHl/V1z7KbwDNJkWMfJHuFyuDP/XkZOLB5U=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=IDNHcCVGU26RZRqJouf73X41j2ae0LTH9pWUehR87xAqSl3SsEMEDN6IngmuUbUKL+Fp0Goo83qsjaIJhNKZ4gAPxsanKOj9b2kZI2BjNw0emEBFZuD3wwk7240yOhC6RIcAlu45L9zwcPXW3X9n0q2X9mWQRgpRSCn6T889yiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cuXNRi8C; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cuXNRi8C"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e355f1ff4bso43431817b3.2
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Oct 2024 10:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729876991; x=1730481791; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZdPRzam7s3Ef71ekAYeKidwnjChTJkDNv4lJBksWIAI=;
        b=cuXNRi8CeW/H+u42vqhOTJttdgHoLhYZOUf1mJHjWJEn7O6o7SGdfqCH0GENuJS70D
         kkIZSyxWwUre4rkmmNWrWV6C1LRrhujhBtxCrNq/6SDMmJcivnSwnEPVe3HROJyMG0Tp
         QJG8akT+1J5ZnogfYAUsNJovbCezN3mXzLLu/0idcfx7QAgy1fTEAJcX+r+4zVM8qWvE
         DfBnt0YF25B89KxeUa6nyjOSxFAWmWqcMR8E8jDBNQGkmwViD6OAAH0vabr/lQXTjvag
         nm8YsyPe3z0X4Hc5plADaPoDTp6YY99bdIWMLZTWBmTmNHts2nUM5CiioiEtMbJY5JHz
         WmnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729876991; x=1730481791;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZdPRzam7s3Ef71ekAYeKidwnjChTJkDNv4lJBksWIAI=;
        b=BHbTbX9OWcq5ohJkAP4bnQMJzEN/WHbTESgqoxwG7sUBMPWGm6oAJevSzHA4H6rfPN
         DL4IddG36bYhDSBp4FL2UxRi8qO9OiLSjYQLV4xFbqGDF2bFsY+bSLkeuGoNQzlVwCFp
         e1qKXFI2UTLpJ4R7uMWCP197S0UVBKi4GpJ1+IGBmO/Qwa2x5F2IAfaAOj/xB20Df5FI
         gfXOqySiPMxm2rtO5pddiu1SkE1KiEioCyLz3xSu6S/2kkb7RjHPwqj6w9I0mpIHv0Mr
         DaEE7FNQsfbl4/M1KPPVqmyV7SfECGAl1U2fGqBv1AwYZz1s9HU/ukF4lPbF28ZpHJBP
         0SsA==
X-Forwarded-Encrypted: i=1; AJvYcCXQ8Wjy0zZkcbNO5T0olCN00tei6b02hXfCjtc1x3HcCeCinx/Uo9fekvkHe02V+ihoOCtmB8KkNFxde2l5ZcNW@vger.kernel.org
X-Gm-Message-State: AOJu0YyYBYZLkvlLEYMGv8URb8SiQQ3AKmUoNj9QS0t/pJ1HLK8OZ06p
	TOQRQLT0u08vAhPJG3I6v+4j++oonwpD9EDMrgbjKwONzaDWYJx+N+2/g3Q3lpjXT4cIr43r6Tq
	/FAUW0A==
X-Google-Smtp-Source: AGHT+IFOK4STJ52RU7m0gtk0HaVDIgUqJIt7KWYDbxaiFvjDsXA+L+1VhnFiXQ5cu4cgUOLCgF9HAYvfaaHx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:5d42:c43e:5e08:3a85])
 (user=irogers job=sendgmr) by 2002:a05:690c:23c6:b0:6db:c34f:9e4f with SMTP
 id 00721157ae682-6e9d8b5bda4mr102277b3.8.1729876991559; Fri, 25 Oct 2024
 10:23:11 -0700 (PDT)
Date: Fri, 25 Oct 2024 10:22:59 -0700
In-Reply-To: <20241025172303.77538-1-irogers@google.com>
Message-Id: <20241025172303.77538-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241025172303.77538-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v1 2/6] perf build: Rename TEST_LOGS to SHELL_TEST_LOGS
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Ze Gao <zegao2021@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Rename TEST_LOGS to SHELL_TEST_LOGS as later changes will add more
kinds of test logs.
Minor comment tweak in Makefile.perf as more than just test shell
tests are checked.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Build                | 6 +++---
 tools/perf/Makefile.perf        | 2 +-
 tools/perf/arch/x86/Build       | 6 +++---
 tools/perf/arch/x86/tests/Build | 6 +++---
 tools/perf/tests/Build          | 6 +++---
 tools/perf/trace/beauty/Build   | 6 +++---
 tools/perf/util/Build           | 6 +++---
 7 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/tools/perf/Build b/tools/perf/Build
index 3e486f7df94b..5e385f370dd7 100644
--- a/tools/perf/Build
+++ b/tools/perf/Build
@@ -65,14 +65,14 @@ gtk-y += ui/gtk/
 
 ifdef SHELLCHECK
   SHELL_TESTS := $(wildcard *.sh)
-  TEST_LOGS := $(SHELL_TESTS:%=%.shellcheck_log)
+  SHELL_TEST_LOGS := $(SHELL_TESTS:%=%.shellcheck_log)
 else
   SHELL_TESTS :=
-  TEST_LOGS :=
+  SHELL_TEST_LOGS :=
 endif
 
 $(OUTPUT)%.shellcheck_log: %
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,test)shellcheck -s bash -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
 
-perf-y += $(TEST_LOGS)
+perf-y += $(SHELL_TEST_LOGS)
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index b4dee7c20ed1..a9f2a9f6ebf0 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -260,7 +260,7 @@ else
   force_fixdep := $(config)
 endif
 
-# Runs shellcheck on perf test shell scripts
+# Runs shellcheck on perf shell scripts
 ifeq ($(NO_SHELLCHECK),1)
   SHELLCHECK :=
 else
diff --git a/tools/perf/arch/x86/Build b/tools/perf/arch/x86/Build
index 87d057491343..1d91c46ad031 100644
--- a/tools/perf/arch/x86/Build
+++ b/tools/perf/arch/x86/Build
@@ -3,14 +3,14 @@ perf-test-y += tests/
 
 ifdef SHELLCHECK
   SHELL_TESTS := entry/syscalls/syscalltbl.sh
-  TEST_LOGS := $(SHELL_TESTS:%=%.shellcheck_log)
+  SHELL_TEST_LOGS := $(SHELL_TESTS:%=%.shellcheck_log)
 else
   SHELL_TESTS :=
-  TEST_LOGS :=
+  SHELL_TEST_LOGS :=
 endif
 
 $(OUTPUT)%.shellcheck_log: %
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,test)shellcheck -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
 
-perf-test-y += $(TEST_LOGS)
+perf-test-y += $(SHELL_TEST_LOGS)
diff --git a/tools/perf/arch/x86/tests/Build b/tools/perf/arch/x86/tests/Build
index 3227053f3355..86262c720857 100644
--- a/tools/perf/arch/x86/tests/Build
+++ b/tools/perf/arch/x86/tests/Build
@@ -13,14 +13,14 @@ perf-test-y += amd-ibs-via-core-pmu.o
 
 ifdef SHELLCHECK
   SHELL_TESTS := gen-insn-x86-dat.sh
-  TEST_LOGS := $(SHELL_TESTS:%=%.shellcheck_log)
+  SHELL_TEST_LOGS := $(SHELL_TESTS:%=%.shellcheck_log)
 else
   SHELL_TESTS :=
-  TEST_LOGS :=
+  SHELL_TEST_LOGS :=
 endif
 
 $(OUTPUT)%.shellcheck_log: %
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,test)shellcheck -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
 
-perf-test-y += $(TEST_LOGS)
+perf-test-y += $(SHELL_TEST_LOGS)
diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 03cbdf7c50a0..a51d28c7431c 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -80,14 +80,14 @@ perf-test-y += workloads/
 
 ifdef SHELLCHECK
   SHELL_TESTS := $(shell find tests/shell -executable -type f -name '*.sh')
-  TEST_LOGS := $(SHELL_TESTS:tests/shell/%=shell/%.shellcheck_log)
+  SHELL_TEST_LOGS := $(SHELL_TESTS:tests/shell/%=shell/%.shellcheck_log)
 else
   SHELL_TESTS :=
-  TEST_LOGS :=
+  SHELL_TEST_LOGS :=
 endif
 
 $(OUTPUT)%.shellcheck_log: %
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,test)shellcheck -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
 
-perf-test-y += $(TEST_LOGS)
+perf-test-y += $(SHELL_TEST_LOGS)
diff --git a/tools/perf/trace/beauty/Build b/tools/perf/trace/beauty/Build
index cb3c1399ff40..f50ebdc445b8 100644
--- a/tools/perf/trace/beauty/Build
+++ b/tools/perf/trace/beauty/Build
@@ -23,14 +23,14 @@ perf-y += tracepoints/
 
 ifdef SHELLCHECK
   SHELL_TESTS := $(wildcard trace/beauty/*.sh)
-  TEST_LOGS := $(SHELL_TESTS:trace/beauty/%=%.shellcheck_log)
+  SHELL_TEST_LOGS := $(SHELL_TESTS:trace/beauty/%=%.shellcheck_log)
 else
   SHELL_TESTS :=
-  TEST_LOGS :=
+  SHELL_TEST_LOGS :=
 endif
 
 $(OUTPUT)%.shellcheck_log: %
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,test)shellcheck -s bash -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
 
-perf-y += $(TEST_LOGS)
+perf-y += $(SHELL_TEST_LOGS)
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 1eedead5f2f2..18cd02ccd3ff 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -398,14 +398,14 @@ $(OUTPUT)util/list_sort.o: ../lib/list_sort.c FORCE
 
 ifdef SHELLCHECK
   SHELL_TESTS := generate-cmdlist.sh
-  TEST_LOGS := $(SHELL_TESTS:%=%.shellcheck_log)
+  SHELL_TEST_LOGS := $(SHELL_TESTS:%=%.shellcheck_log)
 else
   SHELL_TESTS :=
-  TEST_LOGS :=
+  SHELL_TEST_LOGS :=
 endif
 
 $(OUTPUT)%.shellcheck_log: %
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,test)shellcheck -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
 
-perf-util-y += $(TEST_LOGS)
+perf-util-y += $(SHELL_TEST_LOGS)
-- 
2.47.0.163.g1226f6d8fa-goog

