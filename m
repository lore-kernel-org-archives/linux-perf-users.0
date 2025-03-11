Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857F4264F9D
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Mar 2025 21:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741729008; cv=none; b=JPYAceWK7kgLUfHVMRpu6bkbyX4cmf2C4PBAmeBrL3aBK12Y0OpCupZCTplkc8LBA4/T9hSkkYS3qRmlLh8R5s5etJQeXDlzELzZrlDIZDgEWhwuAhmyawXoogUuAG22l7VadFgRcSnVfJM1iZMDo3p0Id5hxhFPbhMLgvLMTNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741729008; c=relaxed/simple;
	bh=abWTkuhBxJ+RVd19Eh1BA2MT3QnNIrohi8wQGbUI7kM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ceS0UdiVtCF9RRuUHvKiIEvZfSsyyF50cyrulTlkbxYz7vnsJldnmcoG7SCNmboxkjLBq07RgozJiDUVk86/OpbtPwk5M4haBtbEHB0KPSvbwth7TnD3ko/qC9Z+TUgvgNEE5f0F+HpMHmF1t8xbsvn9tj2cMHxihJZVqQjD26s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WWcNHni6; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WWcNHni6"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6fedcc61536so4312027b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Mar 2025 14:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741729005; x=1742333805; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zhf6VKyWwg1fHz/o1/UiVpPWROjzR4aN8f2BVl2+a3M=;
        b=WWcNHni6DpUagayiSoDQP2bJb6dxexHdkNuJczRawSOvVQ1WjgGFEBq/ZjSY2iZQlt
         5gRcbatCZVrqqoZIbkQrCbXQMgFIrY9sVSbneWhelC9APCROoPrMW7pOO2i4W9NY2BMx
         iM1g2fJsbqQBUsFGTegym4B8Tp0P7iuTJeZ8g/Qgt9xNlfeY+0iwGMV7rGEjd7iGp4EL
         wwGLBHvMmFpRQPJbmWyrmyA3kTZ45IVIAOlIiIbtDm2f+8GtYQxtySd7I9czL9lNpEBq
         WMnzfP15lcU+XB6wW6KIsdIub061qkgEDiPK78deHslsGDrK0R/P5OIfrnwTV1iSVfIc
         WxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741729005; x=1742333805;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zhf6VKyWwg1fHz/o1/UiVpPWROjzR4aN8f2BVl2+a3M=;
        b=SiBb710Xre1D2VHdVhUetctsi6kQ5/DBk37LmEl+6t/31FS3afr9QRCu6CP3QV28Jd
         mO5QM+NlNj6Hdyt7wwQo0gg1YnjZtlKX2oockishFzlznEECuEvYYPy2atPXi6hMHy7a
         /vApQ22F4M3X+TehP8QvFLd+i1ObzfDyqwOKWRR+dpSw5KQyGRCJTJewlaW5rFSzK9D9
         htYldZx1uS8wLXwATUQ6zJ8s4PZaQ5lywFmBV6+p7oUt6EIiaQptK1v5EXOi6uENrfhG
         kK0qhdUI/pR4/WhN18vLDOSSaWH8OzGYAcIIO+r1Da+RJQ1hJJuFEN8s2NBiwCxYztPG
         /YPg==
X-Forwarded-Encrypted: i=1; AJvYcCXfxAvl2mbADQ1h6No1DibJBLnaUrK7iRb0BUcWAUmP5VFHXXwZeg8r5tlYraKqjwgBepZd8v28pwkge3Qt+ZTy@vger.kernel.org
X-Gm-Message-State: AOJu0YxWZOB4cYJ5yfFKXyxwUWZSnKxaec1qroTym6eNtofxhTXmXZod
	b/3Q7naeBXXse9hiyHe8NoFMnAd9ihrGY8no8YiPg0sZRs+zYcJoWRa700nSfBhxfYK+m2RpDGE
	0ikbyZA==
X-Google-Smtp-Source: AGHT+IG1pfnr1R733TYv83i5t8vnjGZeDgbpUt+WgmLmzXitw/Fu6ze/SYEveIc2o+h4jjDKLa3FhXsxiZqM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8bc2:942f:1b93:42dd])
 (user=irogers job=sendgmr) by 2002:a25:abe9:0:b0:e60:90e0:fa83 with SMTP id
 3f1490d57ef6-e63b5111fa5mr410524276.1.1741729005534; Tue, 11 Mar 2025
 14:36:45 -0700 (PDT)
Date: Tue, 11 Mar 2025 14:36:24 -0700
In-Reply-To: <20250311213628.569562-1-irogers@google.com>
Message-Id: <20250311213628.569562-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250311213628.569562-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Subject: [PATCH v2 2/6] perf build: Rename TEST_LOGS to SHELL_TEST_LOGS
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Charlie Jenkins <charlie@rivosinc.com>, John Garry <john.g.garry@oracle.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Rename TEST_LOGS to SHELL_TEST_LOGS as later changes will add more
kinds of test logs.
Minor comment tweak in Makefile.perf as more than just test shell
tests are checked.

Reviewed-by: James Clark <james.clark@linaro.org>
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
index d0b50ccc9d7b..aebdf317afcc 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -289,7 +289,7 @@ else
   force_fixdep := $(config)
 endif
 
-# Runs shellcheck on perf test shell scripts
+# Runs shellcheck on perf shell scripts
 ifeq ($(NO_SHELLCHECK),1)
   SHELLCHECK :=
 else
diff --git a/tools/perf/arch/x86/Build b/tools/perf/arch/x86/Build
index 02a1ca780a20..afae7b8f6bd6 100644
--- a/tools/perf/arch/x86/Build
+++ b/tools/perf/arch/x86/Build
@@ -2,14 +2,14 @@ perf-util-y += util/
 perf-test-y += tests/
 
 ifdef SHELLCHECK
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
index 4bf8d3f5eae7..5b4b7a3825fd 100644
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
index 034a6603d5a8..fd595454766e 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -406,14 +406,14 @@ $(OUTPUT)util/list_sort.o: ../lib/list_sort.c FORCE
 
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
2.49.0.rc0.332.g42c0ae87b1-goog

