Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A13543DECF
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Oct 2026 05:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790833292; cv=none; b=o//5FsykdbY0UyNdiietTYMbxAwjr6BoeVAvn2sM/yBb1EBwI1nCk/gQU0bojULAqGC5dQZ1EcG6Ow01PsKLiNekfiTEDCA1eRyxvTXIxQn/QKb/WhuiKYKum5o0d9KscbI2rSHoIANxBjKUfqxp0gHzw2wH7sy96Cl0mRiIKZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790833292; c=relaxed/simple;
	bh=+tEZE5h2fHaQzDQGRdzRZc/MD8Sy2ypzqamusSQdf1Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tRprZHY9qqHhvWJ67Hb9A5GxKpEgmMHKuBYjXiZVqUNVjMJM5YPYUH1sQFKJyWkdnIBSXWcP58w6O4DF3WLKKZ8DwDGYpOM2UbhicaFXaH4rYuyAZg3c57ojXQJZeK1yuSz+b/Ys+TTDx5kS7N2tt98hXo47oH2TP/d+C7i5BZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HTnDuR9o; arc=none smtp.client-ip=74.125.82.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HTnDuR9o"
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-33baaba6371so4559075eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 22:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790833290; x=1791438090; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uhs3xsPTL5XVCDWLzT5Op8joIxVA5j1ckW7/R2Q8qoY=;
        b=HTnDuR9oUJUHEesk475uNXK/sDYLdEJ6IyvRkSvUwB/wp+3Vk+7o6+nDlEEXgV1j2E
         7rHP8B5gI9AoXig6tTBgjwKxuMyLrXsbwZ8CP3nzkb17lgfQMTiiUesycTuTDaX+T6YW
         Ozb5GmYBVfWKA2pZXhEJKiSDacC48ktiSwC29IfRgBqZLs9ROPbw7q8qGGkDq4xujCs7
         l12IfMSjM2pNv1+BFTsM/5MeDJCtNqt6ct9UbIeeDPpo8UAYY5cWCLC3VRalTyxyPWbm
         gTLCEPUtTIp1GkuQ6F21N+Cc1q7UHmJSEhnzUE+KtG/1K5RwQSDbUfhYtkKDGm+TImus
         8bag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790833290; x=1791438090;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uhs3xsPTL5XVCDWLzT5Op8joIxVA5j1ckW7/R2Q8qoY=;
        b=UFnGrJBras8PJPZRSKgYe4A2krgpyb72qzdFehPOpdh8E1HjX8gFcrTNP3o4jtGQ6z
         pGv1T0DgUocFjxuVTOn5sZgz6Obuj60bxY0jhnqvsOwexhiOzWD+xeR1diu7rorJ6EC7
         1UGqpB3F+KaHhK7qRbigvheuwuyPU0fTeTR/bzq8pGWrDZ6mZLmOtAR4hpk9Bc/QCnPa
         d4/4b/QbTFDAsWjsqhHUEnQqrNGpMfYOaGC/pFi0Qog+G+P1g2YTFoSI1Chf5MaBJfta
         3erA/1AYcnpLvXMhJwpM4RlJ8CunZ7l5ksl8yK3tALDSisK3pigFuZvNPMepqNTROdhm
         ZlcA==
X-Forwarded-Encrypted: i=1; AKwUvBxxCtnzhwDT3HuPxATb2wmUqzrFNZ6VEHy6o9eJID6Fj1rwS3lDcZHT+4z2/MBrPnhpDcXLsCwSUA5UI80r8bDp@vger.kernel.org
X-Gm-Message-State: AFuF++mAF3EoiRctRk+FC7ly9zqiT5D98b8zf0fBvB/TJt1Z+85EOvPN
	0OEcbVNUah3K4F51NWfCpUSWzn2FauipEeb6XpXBYxv5gGKETHY3sGIqjIBbAEibXL9h+M+ZcR0
	mmg1xj7p4lw==
X-Received: from dlbek3.prod.google.com ([2002:a05:7022:c83:b0:14d:8029:3678])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:d94:b0:145:5c7:71bc
 with SMTP id a92af1059eb24-14d31a7d447mr3940285c88.5.1790833289661; Wed, 30
 Sep 2026 22:41:29 -0700 (PDT)
Date: Wed, 30 Sep 2026 22:41:18 -0700
In-Reply-To: <20261001054120.1570943-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261001023423.1225713-1-irogers@google.com> <20261001054120.1570943-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001054120.1570943-3-irogers@google.com>
Subject: [PATCH v2 2/4] perf build: Run shellcheck, mypy, and remaining pylint
 checks in parallel
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, leo.yan@arm.com, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Following the approach used for pylint on standalone scripts and tests,
move the shellcheck and mypy checks in tools/perf/Build and
tools/perf/tests/Build, as well as the mypy and pylint checks in
tools/perf/util/Build and tools/perf/pmu-events/Build, into dedicated
phony targets invoked as top-level sub-makes from Makefile.perf.

Also add 'perf' to pylint's --ignored-modules (leaving perf module
type-checking to mypy via perf.pyi), since astroid's ImportlibFinder
only resolves .pyi stubs for package directories (__init__.pyi) rather
than single-file stubs like perf.pyi and does not introspect C
extensions by default. This removes the need for pylint to wait on
building $(LANG_BINDINGS).

This avoids blocking jevents code generation, archive creation
(libperf-util.a, libperf-test.a, libpmu-events.a), and final linking of
the perf binary and Python extension on linter execution.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Build            |  8 +++--
 tools/perf/Makefile.perf    | 56 ++++++++++++++++++++++++++-----
 tools/perf/pmu-events/Build | 66 +++++++++++++++++++------------------
 tools/perf/tests/Build      |  8 +++--
 tools/perf/util/Build       |  8 +++--
 5 files changed, 99 insertions(+), 47 deletions(-)

diff --git a/tools/perf/Build b/tools/perf/Build
index 09fd88f5aca5..dcba5ba55206 100644
--- a/tools/perf/Build
+++ b/tools/perf/Build
@@ -76,7 +76,9 @@ $(OUTPUT)%.shellcheck_log: %
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,test)$(SHELLCHECK) "$<" > $@ || (cat $@ && rm $@ && false)
 
-perf-y += $(SHELL_TEST_LOGS)
+.PHONY: shellcheck
+shellcheck: $(addprefix $(OUTPUT),$(SHELL_TEST_LOGS))
+	@:
 
 ifdef MYPY
   PY_TESTS := $(shell find python -type f -name '*.py')
@@ -89,7 +91,9 @@ $(OUTPUT)%.mypy_log: %
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,test)$(MYPY) "$<" > $@ || (cat $@ && rm $@ && false)
 
-perf-y += $(MYPY_TEST_LOGS)
+.PHONY: mypy
+mypy: $(addprefix $(OUTPUT),$(MYPY_TEST_LOGS))
+	@:
 
 ifdef PYLINT
   PY_TESTS := $(shell find python -type f -name '*.py')
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 7ceefc1da774..836225b08649 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -283,8 +283,12 @@ ifneq ($(force_fixdep),1)
 endif
 
 # Runs pylint on perf python files.
-# Require pylint >= 2.16.0 (which introduced W0718 broad-exception-caught and
-# astroid .pyi stub support for perf.pyi).
+# Require pylint >= 2.16.0 (which introduced W0718 broad-exception-caught).
+# Note: astroid's ImportlibFinder only resolves .pyi stubs for package
+# directories (__init__.pyi), not single-file stubs like perf.pyi, and does not
+# introspect C extensions by default. Pass 'perf' in --ignored-modules (leaving
+# perf module type-checking to mypy via perf.pyi) so pylint does not depend on
+# building the perf Python C extension first.
 # Disabled warnings:
 #   W0123 (eval-used): Use of eval()
 #   W0311 (bad-indentation): Non-4-space indentation
@@ -310,9 +314,9 @@ ifneq ($(force_fixdep),1)
       $(warning Warning: pylint version is older than 2.16.0, skipping pylint checks.)
       override PYLINT :=
     else
-      override PYLINT := PYTHONPATH=$(abspath $(OUTPUT)python):$(srctree)/tools/perf/python:$(srctree)/tools/perf/pmu-events \
+      override PYLINT := PYTHONPATH=$(srctree)/tools/perf/python:$(srctree)/tools/perf/pmu-events \
         $(PYLINT) --disable=all --enable=E,W --disable=W0123,W0311,W0511,W0603,W0622,W0718 \
-        --ignored-modules=textual,setproctitle
+        --ignored-modules=perf,textual,setproctitle
     endif
   endif
 endif
@@ -634,18 +638,52 @@ $(SCRIPTS) : $(OUTPUT)% : %.sh
 $(OUTPUT)PERF-VERSION-FILE: .FORCE-PERF-VERSION-FILE
 	$(Q)$(SHELL_PATH) util/PERF-VERSION-GEN $(OUTPUT)
 
-ifdef PYLINT
-# Run Python checks after the extension is ready, independently of C builds.
-all: pylint-perf pylint-tests
-.PHONY: pylint-perf pylint-tests
+ifdef SHELLCHECK
+# Run shellcheck independently of C builds.
+all: shellcheck-perf shellcheck-tests
+.PHONY: shellcheck-perf shellcheck-tests
+
+shellcheck-perf:
+	$(Q)$(MAKE) $(build)=perf shellcheck
+
+shellcheck-tests:
+	$(Q)$(MAKE) $(build)=perf-test dir=tests shellcheck
+endif
+
+ifdef MYPY
+# Run mypy independently of C builds.
+all: mypy-perf mypy-tests mypy-util mypy-pmu-events
+.PHONY: mypy-perf mypy-tests mypy-util mypy-pmu-events
+
+mypy-perf:
+	$(Q)$(MAKE) $(build)=perf mypy
+
+mypy-tests:
+	$(Q)$(MAKE) $(build)=perf-test dir=tests mypy
 
-pylint-perf pylint-tests: | $(LANG_BINDINGS)
+mypy-util:
+	$(Q)$(MAKE) $(build)=perf-util dir=util mypy
+
+mypy-pmu-events:
+	$(Q)$(MAKE) $(build)=pmu-events dir=pmu-events mypy
+endif
+
+ifdef PYLINT
+# Run pylint independently of C builds.
+all: pylint-perf pylint-tests pylint-util pylint-pmu-events
+.PHONY: pylint-perf pylint-tests pylint-util pylint-pmu-events
 
 pylint-perf:
 	$(Q)$(MAKE) $(build)=perf pylint
 
 pylint-tests:
 	$(Q)$(MAKE) $(build)=perf-test dir=tests pylint
+
+pylint-util:
+	$(Q)$(MAKE) $(build)=perf-util dir=util pylint
+
+pylint-pmu-events:
+	$(Q)$(MAKE) $(build)=pmu-events dir=pmu-events pylint
 endif
 
 # These can record PERF_VERSION
diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index 01f5a00f2125..5147139bbb6f 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -183,38 +183,6 @@ $(EMPTY_PMU_EVENTS_TEST_LOG): $(EMPTY_PMU_EVENTS_C) $(TEST_EMPTY_PMU_EVENTS_C)
 # Dependencies for jevents.py
 JEVENTS_DEPS := $(OUT_JSON) $(GEN_JSON) $(JEVENTS_PY) $(METRIC_PY) $(EMPTY_PMU_EVENTS_TEST_LOG) $(METRIC_TEST_LOG)
 
-# Rules to run mypy if enabled.
-ifdef MYPY
-define MYPY_RULE
-$(2): $(1)
-	$$(Q)$$(call echo-cmd,test)$$(MYPY) $(1) > $(2) || (cat $(2) && rm $(2) && false)
-endef
-$(foreach src,$(wildcard pmu-events/*.py), \
-    $(eval dest := $(patsubst pmu-events/%,$(OUTPUT)pmu-events/%.mypy_log,$(src))) \
-    $(eval $(call MYPY_RULE,$(src),$(dest))) \
-)
-
-MYPY_INPUTS := $(wildcard pmu-events/*.py)
-MYPY_OUTPUTS := $(patsubst pmu-events/%,$(OUTPUT)pmu-events/%.mypy_log,$(MYPY_INPUTS))
-JEVENTS_DEPS += $(MYPY_OUTPUTS)
-endif
-
-# Rules to run pylint if enabled.
-ifdef PYLINT
-define PYLINT_RULE
-$(2): $(1)
-	$$(Q)$$(call echo-cmd,test)$$(PYLINT) $(1) > $(2) || (cat $(2) && rm $(2) && false)
-endef
-$(foreach src,$(wildcard pmu-events/*.py), \
-    $(eval dest := $(patsubst pmu-events/%,$(OUTPUT)pmu-events/%.pylint_log,$(src))) \
-    $(eval $(call PYLINT_RULE,$(src),$(dest))) \
-)
-
-PYLINT_INPUTS := $(wildcard pmu-events/*.py)
-PYLINT_OUTPUTS := $(patsubst pmu-events/%,$(OUTPUT)pmu-events/%.pylint_log,$(PYLINT_INPUTS))
-JEVENTS_DEPS += $(PYLINT_OUTPUTS)
-endif
-
 # If there are orphaned files remove them.
 ifneq ($(strip $(ORPHAN_FILES)),)
 .PHONY: prune_orphans
@@ -243,3 +211,37 @@ $(PMU_EVENTS_STRING_C): $(PMU_EVENTS_C)
 	@:
 
 endif # ifeq ($(NO_JEVENTS),1)
+
+ifneq ($(NO_JEVENTS),1)
+  PY_TESTS := $(wildcard pmu-events/*.py)
+else
+  PY_TESTS :=
+endif
+
+ifdef MYPY
+  MYPY_TEST_LOGS := $(PY_TESTS:%=%.mypy_log)
+else
+  MYPY_TEST_LOGS :=
+endif
+
+$(OUTPUT)%.mypy_log: %
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,test)$(MYPY) "$<" > $@ || (cat $@ && rm $@ && false)
+
+.PHONY: mypy
+mypy: $(addprefix $(OUTPUT),$(MYPY_TEST_LOGS))
+	@:
+
+ifdef PYLINT
+  PYLINT_TEST_LOGS := $(PY_TESTS:%=%.pylint_log)
+else
+  PYLINT_TEST_LOGS :=
+endif
+
+$(OUTPUT)%.pylint_log: %
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,test)$(PYLINT) "$<" > $@ || (cat $@ && rm $@ && false)
+
+.PHONY: pylint
+pylint: $(addprefix $(OUTPUT),$(PYLINT_TEST_LOGS))
+	@:
diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 05c545aac732..395f2866094a 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -93,7 +93,9 @@ $(OUTPUT)%.shellcheck_log: %
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,test)$(SHELLCHECK) "$<" > $@ || (cat $@ && rm $@ && false)
 
-perf-test-y += $(SHELL_TEST_LOGS)
+.PHONY: shellcheck
+shellcheck: $(addprefix $(OUTPUT)tests/,$(SHELL_TEST_LOGS))
+	@:
 
 ifdef MYPY
   PY_TESTS := $(shell find tests/shell -type f -name '*.py')
@@ -106,7 +108,9 @@ $(OUTPUT)%.mypy_log: %
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,test)$(MYPY) "$<" > $@ || (cat $@ && rm $@ && false)
 
-perf-test-y += $(MYPY_TEST_LOGS)
+.PHONY: mypy
+mypy: $(addprefix $(OUTPUT)tests/,$(MYPY_TEST_LOGS))
+	@:
 
 ifdef PYLINT
   PY_TESTS := $(shell find tests/shell -type f -name '*.py')
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 512f2ca0cd1a..2c1f880c4c47 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -425,7 +425,9 @@ $(OUTPUT)%.mypy_log: %
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,test)$(MYPY) "$<" > $@ || (cat $@ && rm $@ && false)
 
-perf-util-y += $(MYPY_TEST_LOGS)
+.PHONY: mypy
+mypy: $(addprefix $(OUTPUT)util/,$(MYPY_TEST_LOGS))
+	@:
 
 ifdef PYLINT
   PYLINT_TEST_LOGS := $(PY_TESTS:%=%.pylint_log)
@@ -437,7 +439,9 @@ $(OUTPUT)%.pylint_log: %
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,test)$(PYLINT) "$<" > $@ || (cat $@ && rm $@ && false)
 
-perf-util-y += $(PYLINT_TEST_LOGS)
+.PHONY: pylint
+pylint: $(addprefix $(OUTPUT)util/,$(PYLINT_TEST_LOGS))
+	@:
 
 ifeq ($(CONFIG_PERF_BPF_SKEL),y)
 include $(srctree)/tools/perf/bpf_skel.mak
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

