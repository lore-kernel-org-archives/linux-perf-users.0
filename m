Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10C838E5E9
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790403687; cv=none; b=fxrFy7ki0vX47ruHSRU67MlO+HXJP75HT/Yy+9G+ZqjPjmnLDTOuqda273HtqDTMfs/Se/4tchzuJ4hINm2XdwrnBTYfW/x9oZOv5T0IIL4nKwNt6iObgsbC8NpKDrLOIkxFqM5hqTL2+MhHRQCnSMKvAzO8SDnFQQmMGEub+gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790403687; c=relaxed/simple;
	bh=HpllgPwp1lDAHGYPp2za0GiBUKfZxheubzvv2/e+yes=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JJRXyT4HgJb3+Wq+uz9KcB/ah1ijV5vtNlk3dxMYQhYKZi499jO7ll0f//SsMqZh0SN1BZL/xCLXRNq2Hw3GFGkZdk3dlxMtcuWePSh8u6jUYqiTe0sYuomUc0by0fuCvd3F9Yzolm1Eo47SmDVXqQKZaixeKxunKSKsfd0k3dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ufOvXtSL; arc=none smtp.client-ip=74.125.82.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ufOvXtSL"
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-139b62317d0so6200560c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 23:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790403684; x=1791008484; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XZOvoicqDNe6eg7esKHfQ5jSFbjrTjm1WUPP0ADwTvM=;
        b=ufOvXtSL4Fk2sBo9f47JSL9c16Hvn1H8EDiV9B9V8oVdkgVqnoXb1Ep8V5tsF5vOIx
         YB6hNCbHBqQKyEgpexYnfvP6yXeuUpoMUQD/v4+LNXSEbVutIyR+n3ntiOOb8MbioAMG
         sWcXUBUsUMVaCUPILIy04myYg4dAb6heDB77vcTjctBjL/abGzhqDwxif6vxtkRReK+g
         R3UT8MO5o7P8o8qk6u6/eixXLeBF397yVIfhiE4f8cg8WLyAl9KLX7dutQR6eba54j1F
         sBabd03m7Oc7BftzmyqMqhwfWfMsq766hcX2SaySZ86Mfcz95ucfE5ZyDKMO3bIh/7Gn
         r7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790403684; x=1791008484;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XZOvoicqDNe6eg7esKHfQ5jSFbjrTjm1WUPP0ADwTvM=;
        b=uPKbPl4EEs/T+PMHHw9ot7JygM4M+q0xcRpFER/pkjhMMWc6PWLU0wkgbC1i/zOKVg
         o9MTF7d6saUoSrBiWpEnO4nZiPWNNvZxuBD324XCEvAo+X/HtmG9JQJ/5Xa+X/SRafKx
         sBTBMfGO6k98V/TBpSA2EkDmt4cEikovAWsdm15N0lWupsiAQx1hsDr9MpItueBVcZLT
         Hnm81ioqBZ99zF6eFVU+MLbU4KdI5Gmzf1vvQKwuFussm3ejGJVZgLDVc6qkQQhpfzh2
         oWlEz8OjAgiaQZ5wOYWz8aw+Pr7qs6zDAgcCHfdgE5GZC4x9GdjLa6xecQBLycwK2KXg
         LmlA==
X-Forwarded-Encrypted: i=1; AKwUvBwJbcV2OHTxFmtVa53aGLi1FOPOUrlk1tn6o/dcYMPD3+2x5iiHCtLQofQQXRP+zzZRr2FQCAJaL2Kn0UprIk+b@vger.kernel.org
X-Gm-Message-State: AFuF++mp89wXsaiLiSXeCSGHGa7VqLxoELjzkln/uXIMr3Dby4D0UrwG
	YCgHh1kycwY1L5kue9YHRo37ru2uliFEUrf0aoBc68DYeGnyetoEi9QcYrzvHqBh6iqK+gf3ssc
	0KdA/lVcx2g==
X-Received: from dlbrn7.prod.google.com ([2002:a05:7022:1507:b0:144:58aa:2e86])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:428c:20b0:145:568:13cc
 with SMTP id a92af1059eb24-146d096b0f6mr2264416c88.41.1790403684119; Fri, 25
 Sep 2026 23:21:24 -0700 (PDT)
Date: Fri, 25 Sep 2026 23:19:40 -0700
In-Reply-To: <20260926062029.800743-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923181213.3032038-1-irogers@google.com> <20260926062029.800743-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260926062029.800743-14-irogers@google.com>
Subject: [PATCH v4 13/49] perf build: Make mypy build test opt-out (NO_MYPY=1)
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	james.clark@linaro.org, leo.yan@linux.dev, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
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
index e91d6138330e..fbb5dfb67089 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -126,6 +126,8 @@ include ../scripts/utilities.mak
 # Define GEN_VMLINUX_H to generate vmlinux.h from the BTF.
 #
 # Define NO_SHELLCHECK if you do not want to run shellcheck during build
+#
+# Define NO_MYPY if you do not want to run mypy during build
 
 # As per kernel Makefile, avoid funny character set dependencies
 unexport LC_ALL
@@ -259,9 +261,24 @@ ifneq ($(SHELLCHECK),)
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
@@ -945,7 +962,8 @@ clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(
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
index 81c311b131b7..cd7b62a6c1b8 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -104,7 +104,7 @@ endif
 
 $(OUTPUT)%.mypy_log: %
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,test)mypy "$<" > $@ || (cat $@ && rm $@ && false)
+	$(Q)$(call echo-cmd,test)$(MYPY) "$<" > $@ || (cat $@ && rm $@ && false)
 
 perf-test-y += $(MYPY_TEST_LOGS)
 
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index a4618e4e4848..f922794e8108 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -426,7 +426,7 @@ endif
 
 $(OUTPUT)%.mypy_log: %
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,test)mypy "$<" > $@ || (cat $@ && rm $@ && false)
+	$(Q)$(call echo-cmd,test)$(MYPY) "$<" > $@ || (cat $@ && rm $@ && false)
 
 perf-util-y += $(MYPY_TEST_LOGS)
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

