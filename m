Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F8E49891A
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187220; cv=none; b=O5TKu78B1byV9j+kNkVfpX8JBY/8Y71TQpbUWMgA4tZ8jvfslB2KiKt/VhDFRPtI0ZRWGhH2G9z2dM6vLZLBPVhcofdmvE+fUVokmYC4AOYOYzV51cGLIYj1bT1P5/DUmUt5ntBFkzCRDnNVi6p93s7vKl4qoSC75ANer7X0jZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187220; c=relaxed/simple;
	bh=Mqme3tjYOsx6QvtSOqg1yMKFJwfr64HkzN9wNnVljLk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MwIlRI/FXZ/ip197oTNXTPzRjbgoIu1C47KFxs8psGMdBNvT8yIa6oAETPXgPfoEqWJClN4W/kl7b/XsEwxV+93p+OUQU+q96JmAk14vzVtji7QNp66jap9OUDy5X45cn4zKUOWJezvIsg4usyMuRDA/A5X2foJseZDXghZIgQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ath9SWRk; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ath9SWRk"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-86ab8302b54so946139b3a.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 11:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790187205; x=1790792005; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qt8LZpEBEh0Ra99otG9OHNC1wC4EnMMGyhmdZrr4ouo=;
        b=Ath9SWRkxAK1hVXEnUVUWBRdPUoyYSNZnyx1CR4hKNQ+MILBL4g+vQGa13g49N3xtg
         2Q2T5CrddEFRbzh1r530e9rckvoLeoHThoduDnDtmQpEClD/cSK+VYTBY19j6EhETtWE
         km5ZvjPN+q/PA12FTadoNzdjECp9rAsQL8/NZWpXHxExIB1MSJC0av5br5/kSaqGlcdL
         q9Uu0vRKQ4wu8btyTupGQ+Ct4B4H4Gqzi7pU+LhorH4F1OfQE+DwipoLVMtbqai0BUB5
         byLwScD2hSrbeG++waWPG6FJPMjD3dh2MECHWBwMw3r7Z3XRdD3X8ljyzfNPYQ1nl4Y0
         KHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790187205; x=1790792005;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qt8LZpEBEh0Ra99otG9OHNC1wC4EnMMGyhmdZrr4ouo=;
        b=uyoS+1nLqgaUEnlVItiLWNgEM/qelPvKw9WbLvKNgxP5GzO09Xj6E3PrktbKJMi+y9
         6fIXYtBSweRrKoHXNHMIwovNt7DOdTSJpbIZpDULhwLZGmPUZnVd/EEbn4JXGc3/NlBs
         HYuxaJ3kfiMCAc8RBldCdjJzuh5U7TfuGhvQGF+tmnzwdNIwP214ypQTiR7/2MLJKjwu
         Vm9VNlg3LMFeND6eJ7uTWh5/MRxe+Ir+EoyZYzGlEczeM2F3aCRU5HUYvLs/1HTSxuHI
         fbkWTLvXfxVxz4yObDixxRIfUEptFaRTF653bQyeGaPJoe4SaD4zQuUOs67SIoD1ef/B
         u9dA==
X-Forwarded-Encrypted: i=1; AKwUvBw5svI/8Wp1YCxI2MdXeKDNMqIkWkR1Gq8V+8El+YvsK33eoBPBUW0yZJ60OxABrhMf5ZoaEbyIuHpigAPeY6qF@vger.kernel.org
X-Gm-Message-State: AFuF++mD/H8SvHc+BGgcnxjH8AjXGSX6q8b23aJK/D0XcpXnN746YtXj
	mvhZWxevLSzEh6T/0iplccJe23+yyyMQdV0TGEqo+XzAXX1AtfeoA8dCS6HEhVZgO3OCQKvVSjB
	I3fWQClpCPQ==
X-Received: from pfpk17.prod.google.com ([2002:aa7:9d11:0:b0:86b:a074:218a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4650:b0:87c:e44e:5694
 with SMTP id d2e1a72fcca58-87e98f91b9amr10642b3a.21.1790187204911; Wed, 23
 Sep 2026 11:13:24 -0700 (PDT)
Date: Wed, 23 Sep 2026 11:11:36 -0700
In-Reply-To: <20260923181213.3032038-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com> <20260923181213.3032038-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260923181213.3032038-14-irogers@google.com>
Subject: [PATCH v3 13/49] perf build: Make mypy build test opt-out (NO_MYPY=1)
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Commit 168910d0f937 ("perf build: Add mypy build tests") added a
compile-time mypy type check for Python files in tools/perf, but left it
opt-in via MYPY=1.

Now that mypy issues across tools/perf/python, tools/perf/pmu-events,
and tools/perf/tests/shell/lib have been cleaned up, enable the mypy
check by default when mypy is installed on the system, with an opt-out
via NO_MYPY=1 (matching NO_SHELLCHECK=1 and other perf build feature
flags). Also configure MYPYPATH in Makefile.perf so scripts can resolve
perf.pyi type stubs and local modules, pass --ignore-missing-imports so
optional third-party packages do not fail default builds, and remove
*.mypy_log files during `make clean`.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Build            |  2 +-
 tools/perf/Makefile.perf    | 26 ++++++++++++++++++++++----
 tools/perf/pmu-events/Build |  2 +-
 tools/perf/tests/Build      |  2 +-
 tools/perf/util/Build       |  2 +-
 5 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/tools/perf/Build b/tools/perf/Build
index e18c80a5c1bc..37d603faea6d 100644
--- a/tools/perf/Build
+++ b/tools/perf/Build
@@ -88,7 +88,7 @@ endif
 
 $(OUTPUT)%.mypy_log: %
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,test)mypy "$<" > $@ || (cat $@ && rm $@ && false)
+	$(Q)$(call echo-cmd,test)$(MYPY) "$<" > $@ || (cat $@ && rm $@ && false)
 
 perf-y += $(MYPY_TEST_LOGS)
 
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 2438b40eaaec..c7cade270b23 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -129,6 +129,8 @@ include ../scripts/utilities.mak
 # Define GEN_VMLINUX_H to generate vmlinux.h from the BTF.
 #
 # Define NO_SHELLCHECK if you do not want to run shellcheck during build
+#
+# Define NO_MYPY if you do not want to run mypy during build
 
 # As per kernel Makefile, avoid funny character set dependencies
 unexport LC_ALL
@@ -262,9 +264,24 @@ ifneq ($(SHELLCHECK),)
   endif
 endif
 
-# Runs mypy on perf python files
-ifeq ($(MYPY),1)
-  MYPY := $(shell which mypy 2> /dev/null)
+# Runs mypy on perf python files.
+# Wait until after the fixdep bootstrap sub-make (force_fixdep != 1) so
+# command-line overrides (MYPY=1, MYPY=/custom/path, NO_MYPY=1) reach the
+# main Makefile.perf pass intact, then strip MYPY=% from MAKEOVERRIDES
+# (substituting escaped spaces so multi-word overrides like MYPY="mypy --strict"
+# are removed as a single token) so child Makefile.build sub-makes inherit the
+# MYPYPATH-wrapped export MYPY environment variable.
+ifneq ($(force_fixdep),1)
+  MAKEOVERRIDES := $(subst __SPACE__,\ ,$(filter-out MYPY=%,$(subst \ ,__SPACE__,$(MAKEOVERRIDES))))
+  ifeq ($(NO_MYPY),1)
+    override MYPY :=
+  else ifeq ($(filter-out 1,$(MYPY)),)
+    override MYPY := $(shell which mypy 2> /dev/null)
+  endif
+
+  ifneq ($(MYPY),)
+    override MYPY := MYPYPATH=$(srctree)/tools/perf/python $(MYPY) --ignore-missing-imports
+  endif
 endif
 
 # Runs pylint on perf python files
@@ -948,7 +965,8 @@ clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(
 	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive \
 		$(OUTPUT)perf-iostat $(LANG_BINDINGS)
 	$(Q)find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '*.a' -delete -o \
-		-name '\.*.cmd' -delete -o -name '\.*.d' -delete -o -name '*.shellcheck_log' -delete
+		-name '\.*.cmd' -delete -o -name '\.*.d' -delete -o -name '*.shellcheck_log' -delete -o \
+		-name '*.mypy_log' -delete
 	$(Q)$(RM) $(OUTPUT).config-detected
 	$(call QUIET_CLEAN, core-progs) $(RM) $(ALL_PROGRAMS) perf perf-read-vdso32 \
 		perf-read-vdsox32 $(OUTPUT)$(LIBJVMTI).so
diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index 372773b998e4..c3542e5ae46f 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -187,7 +187,7 @@ JEVENTS_DEPS := $(OUT_JSON) $(GEN_JSON) $(JEVENTS_PY) $(METRIC_PY) $(EMPTY_PMU_E
 ifdef MYPY
 define MYPY_RULE
 $(2): $(1)
-	$$(Q)$$(call echo-cmd,test)mypy $(1) > $(2) || (cat $(2) && rm $(2) && false)
+	$$(Q)$$(call echo-cmd,test)$$(MYPY) $(1) > $(2) || (cat $(2) && rm $(2) && false)
 endef
 $(foreach src,$(wildcard pmu-events/*.py), \
     $(eval dest := $(patsubst pmu-events/%,$(OUTPUT)pmu-events/%.mypy_log,$(src))) \
diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 406e48eed1c8..98b05b68fc14 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -104,7 +104,7 @@ endif
 
 $(OUTPUT)%.mypy_log: %
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,test)mypy "$<" > $@ || (cat $@ && rm $@ && false)
+	$(Q)$(call echo-cmd,test)$(MYPY) "$<" > $@ || (cat $@ && rm $@ && false)
 
 perf-test-y += $(MYPY_TEST_LOGS)
 
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index d08f2af7d970..71d1f7289d03 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -426,7 +426,7 @@ endif
 
 $(OUTPUT)%.mypy_log: %
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,test)mypy "$<" > $@ || (cat $@ && rm $@ && false)
+	$(Q)$(call echo-cmd,test)$(MYPY) "$<" > $@ || (cat $@ && rm $@ && false)
 
 perf-util-y += $(MYPY_TEST_LOGS)
 
-- 
2.56.0.rc1.310.g51773c2048-goog

