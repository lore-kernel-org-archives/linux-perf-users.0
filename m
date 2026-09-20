Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8653D5253
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789881787; cv=none; b=BMg6rX+LxTT/cI2rAxzlqtjMPMTBY2ijzs28G1E5hzM4szMSHZAIgMDl1b35fw1ehnRMXol4O5RZ75opp2b+BWAjGkBPiXDvX1VfxQl7XFEsV6g+DrcpOayrqXg2LtgDFfOOWh3eF+U7t2Bn6bEAfXWXdGS4fcFrlc0rIuEVDK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789881787; c=relaxed/simple;
	bh=zuycMtg5eKZrs8s8eypBtjLTX21DAkgnItk8B0j0DQw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZOrlOJCMuvsDeiPENGAdLN+SpQS4ajwwIpwMBVxkavA7xlykg5FmL845wIJHL9f3wYKM8Eb9u1UCHRdxVwAqt4v3MF4EVALfflbfpc34RpbVNgRb18kCqTCJFB9hSO4Nk8sQqqShAee+WaQv+lu1gzsh/QaaiJ60UGtHkdg39Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cpEfAvFT; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cpEfAvFT"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39e18af9f48so3153889a91.1
        for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 22:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789881783; x=1790486583; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PwtddJRknDHV1Gp49R0RIm84gq/uTIAaiAp2YpcIxtc=;
        b=cpEfAvFTh+BTjkAiynk25XtsNhHNjGBfknHTubyDNux/HyAl3Wm9jSoyYdUNOdCLag
         ChfgFZMRdi2ggkPKlzkRalkRsIvEL/CiNli601Lj43sliRcPppwvY4yFpF+X+kQzmnLt
         PSOG/xKp1NmiCw9X849gAREnID66//AINHWpeGCUg5qF+pielo12UeBu8i4hmW24MGa0
         8qhgNMCYU4pH/OWf2GDrcp4/BKgSO5M7cCmbIjISpPl+QfeUDdPp5Ey4sFGliDI7F+R4
         UuAYLeyqFOj234RWeajgfGTY5IvO8UhXQewkWqB3axR7eaaAD7hdemmLk5oYF9tBBbH5
         lPmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789881783; x=1790486583;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PwtddJRknDHV1Gp49R0RIm84gq/uTIAaiAp2YpcIxtc=;
        b=XUdsB2T+vjS0pi2t8arLEMUw0vlTI4ObJcVlRIhQq5WgmYK3mVjDkQb9oAhJSZ8Zlx
         rLgpYD95wNcVjsw7IKRzthOcxQWS/+JE/iYBaRvvbwDdIh9aXCl58mDEHPrAEpL9GO68
         6ikiO9u3E1ivo7bbHAPKLwfu+eAXgtEyGQgo7X5z58DHaXhbaLrQr/lZlEMkMFkBlQg8
         CIkfYuA7Ebvej4lF0i/mwMRHqQgyAJzc/FaPgERdMzR8lovzBS9Ybg/HCSuft/fJnf2d
         mp/ExC6mjBbI4Yht4YaOxF11QotQN+h6tUkP4PkpT0ar12pZjzz/mIgIB8vGYG7Nhh7K
         ubdQ==
X-Forwarded-Encrypted: i=1; AKwUvBynqZOUOPitusw68wpM/BEcUEDsX4Y9LkFn6kWRtCBStH4DZ49ejxjYzMorl+3RpUOLfM4AYGc6Yx1rbzMypCyr@vger.kernel.org
X-Gm-Message-State: AFuF++kHrwncBcP9wT4KuYxuMGSXyYsADAsKpDQWmJSKVHO+C97O46+K
	GOP11C8CN8ncZSm76jh4qR02oDYVoaNE2N0kxQ5NXKuYGOUUzRgWXdk9lIN4b4ynoVYOttw5IF8
	o05r1GT5+tQ==
X-Received: from dyaz17-n2.prod.google.com ([2002:a05:693c:6391:20b0:33c:a5ec:92cd])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:58e4:b0:39e:4c97:ce05
 with SMTP id 98e67ed59e1d1-39e4c97ced5mr10454557a91.38.1789881782952; Sat, 19
 Sep 2026 22:23:02 -0700 (PDT)
Date: Sat, 19 Sep 2026 22:21:06 -0700
In-Reply-To: <cover.1789880842.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789880842.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <faf4e4c1205cf70b39a39e784ed1d58300e938b6.1789880842.git.irogers@google.com>
Subject: [PATCH v1 14/49] perf build: Make pylint build test opt-out (NO_PYLINT=1)
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	alice.mei.rogers@gmail.com, james.clark@linaro.org, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: dapeng1.mi@linux.intel.com, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Commit 8a54784e708b ("perf build: Add pylint build tests") added a
compile-time pylint check for Python files in tools/perf, but left it
opt-in via PYLINT=1.

Now that pylint issues across tools/perf/python, tools/perf/pmu-events,
and tools/perf/tests/shell/lib have been cleaned up, enable the pylint
check by default when pylint is installed on the system, with an opt-out
via NO_PYLINT=1 (matching other perf build feature flags).

Configure PYTHONPATH in Makefile.perf so pylint resolves perf.pyi type
stubs and pmu-events modules, enable error and warning categories
(--disable=all --enable=E,W --disable=W0123,W0311,W0511,W0603,W0622,W0718)
appropriate for perf's standalone CLI and test scripts, and require
pylint >= 2.16.0 (skipping with a warning if an older version is
installed).

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Build            |  2 +-
 tools/perf/Makefile.perf    | 39 +++++++++++++++++++++++++++++++++----
 tools/perf/pmu-events/Build |  2 +-
 tools/perf/tests/Build      |  2 +-
 tools/perf/util/Build       |  2 +-
 5 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/tools/perf/Build b/tools/perf/Build
index 37d603faea6d..5bd0e58d7cb0 100644
--- a/tools/perf/Build
+++ b/tools/perf/Build
@@ -101,6 +101,6 @@ endif
 
 $(OUTPUT)%.pylint_log: %
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,test)pylint "$<" > $@ || (cat $@ && rm $@ && false)
+	$(Q)$(call echo-cmd,test)$(PYLINT) "$<" > $@ || (cat $@ && rm $@ && false)
 
 perf-y += $(PYLINT_TEST_LOGS)
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index f22eda3d2852..3e193d609988 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -131,6 +131,8 @@ include ../scripts/utilities.mak
 # Define NO_SHELLCHECK if you do not want to run shellcheck during build
 #
 # Define NO_MYPY if you do not want to run mypy during build
+#
+# Define NO_PYLINT if you do not want to run pylint during build
 
 # As per kernel Makefile, avoid funny character set dependencies
 unexport LC_ALL
@@ -280,9 +282,38 @@ ifneq ($(MYPY),)
   override MYPY := MYPYPATH=$(srctree)/tools/perf/python $(MYPY)
 endif
 
-# Runs pylint on perf python files
-ifeq ($(PYLINT),1)
-  PYLINT := $(shell which pylint 2> /dev/null)
+# Runs pylint on perf python files.
+# Require pylint >= 2.16.0 (which introduced W0718 broad-exception-caught and
+# astroid .pyi stub support for perf.pyi).
+# Disabled warnings:
+#   W0123 (eval-used): Use of eval()
+#   W0311 (bad-indentation): Non-4-space indentation
+#   W0511 (fixme): Presence of FIXME/TODO comments
+#   W0603 (global-statement): Use of the global statement
+#   W0622 (redefined-builtin): Redefining a built-in name (e.g. id, type, dir)
+#   W0718 (broad-exception-caught): Catching broad Exception
+MAKEOVERRIDES := $(filter-out PYLINT=%,$(MAKEOVERRIDES))
+ifeq ($(NO_PYLINT),1)
+  override PYLINT :=
+else
+  ifeq ($(PYLINT),1)
+    override PYLINT := $(shell which pylint 2> /dev/null)
+  else
+    PYLINT ?= $(shell which pylint 2> /dev/null)
+  endif
+endif
+
+ifneq ($(PYLINT),)
+  ifneq ($(force_fixdep),1)
+    ifneq ($(shell $(PYLINT) --version 2>/dev/null | \
+          awk '/^pylint / { split($$2, v, "."); print (v[1]+0 > 2 || (v[1]+0 == 2 && v[2]+0 >= 16)) }'), 1)
+      $(warning Warning: pylint version is older than 2.16.0, skipping pylint checks.)
+      override PYLINT :=
+    else
+      override PYLINT := PYTHONPATH=$(srctree)/tools/perf/python:$(srctree)/tools/perf/pmu-events \
+        $(PYLINT) --disable=all --enable=E,W --disable=W0123,W0311,W0511,W0603,W0622,W0718
+    endif
+  endif
 endif
 
 export srctree OUTPUT RM CC CXX RUSTC CLANG LD AR CFLAGS CXXFLAGS RUST_FLAGS V BISON FLEX AWK LIBBPF READELF
@@ -962,7 +993,7 @@ clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(
 		$(OUTPUT)perf-iostat $(LANG_BINDINGS)
 	$(Q)find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '*.a' -delete -o \
 		-name '\.*.cmd' -delete -o -name '\.*.d' -delete -o -name '*.shellcheck_log' -delete -o \
-		-name '*.mypy_log' -delete
+		-name '*.mypy_log' -delete -o -name '*.pylint_log' -delete
 	$(Q)$(RM) $(OUTPUT).config-detected
 	$(call QUIET_CLEAN, core-progs) $(RM) $(ALL_PROGRAMS) perf perf-read-vdso32 \
 		perf-read-vdsox32 $(OUTPUT)$(LIBJVMTI).so
diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index c3542e5ae46f..1ac067be9d34 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -203,7 +203,7 @@ endif
 ifdef PYLINT
 define PYLINT_RULE
 $(2): $(1)
-	$$(Q)$$(call echo-cmd,test)pylint $(1) > $(2) || (cat $(2) && rm $(2) && false)
+	$$(Q)$$(call echo-cmd,test)$$(PYLINT) $(1) > $(2) || (cat $(2) && rm $(2) && false)
 endef
 $(foreach src,$(wildcard pmu-events/*.py), \
     $(eval dest := $(patsubst pmu-events/%,$(OUTPUT)pmu-events/%.pylint_log,$(src))) \
diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 98b05b68fc14..f88e9a55c4f5 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -117,6 +117,6 @@ endif
 
 $(OUTPUT)%.pylint_log: %
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,test)pylint "$<" > $@ || (cat $@ && rm $@ && false)
+	$(Q)$(call echo-cmd,test)$(PYLINT) "$<" > $@ || (cat $@ && rm $@ && false)
 
 perf-test-y += $(PYLINT_TEST_LOGS)
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 71d1f7289d03..3ea888f4210a 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -438,7 +438,7 @@ endif
 
 $(OUTPUT)%.pylint_log: %
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,test)pylint "$<" > $@ || (cat $@ && rm $@ && false)
+	$(Q)$(call echo-cmd,test)$(PYLINT) "$<" > $@ || (cat $@ && rm $@ && false)
 
 perf-util-y += $(PYLINT_TEST_LOGS)
 
-- 
2.55.0.1082.g2b9226bbc0-goog

