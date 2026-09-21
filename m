Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C6236729A
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789967266; cv=none; b=gAOZJkGKgDXUh8SG10u9S31pAYQhKsyaUKzTF4QQHVRn2a1+y8YKA7mZveLoZyhVtQx8bMl51cp8Nsb6DJ1Nrf0n0bpxqECXiSXt0RcZhncUFfBqS8xdd0jzxvMbXm+ThYhFJlUsf7GKcK6VMSO/4hVCrjo9NRVn2RvHXSrtQhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789967266; c=relaxed/simple;
	bh=S6mL8H/b3NpwzuCBgaGKWVjxzCruzeEOAud4VZhZBww=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sNWBXPgG2PyaVIH6mh/MtSj+kHsF/v+zUzjPrgNwcq5Kc01mDV28SfTaPY6SwHn71lGSy6FgjVtVQXeLMY1A2btkKZXzs6l5k3VXJEsX/om2Y4rpvRV5hYUqbT68ohXVRUNFb/dDHcjZcyEB9jHABpNRYX5UjQORv7XlycObxc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=unZ+iKgX; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="unZ+iKgX"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c89704da8c7so3489274a12.0
        for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 22:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789967264; x=1790572064; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tuebB8yjUONaP5k4givMWNJoLg+Rg6Sf1ayYARW2BaQ=;
        b=unZ+iKgX7gdOeZGO/iUM01zYThh4enlRQjs8NvYBOE/7bFkpRY/wZVTJvrR7bFKpdM
         4okCp5VkHW2ulWkJFXOCZSXgxiCO0NwirjBts/5UjXXNVfPBHsnQ4UeWts+fbkpUSe4G
         rpqJfdnDQlNzBudPixHSGLhx/+ja13zmB0QAZz36a5f2q/aoGQK+WymmILcj1Zt+swsb
         +TJtzW8vShRRdct83/UeHvhbucy7B2nQNrbRESm9SN3anSSrlkcb+JHPXuVxyhWD3NTj
         ehFO4ekoOkHbYswatvYwYJJ1pRCj8Jw2YQyazPgCXyjfoZGxmXXHG47LXVkTcRjQ1qwq
         upOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789967264; x=1790572064;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tuebB8yjUONaP5k4givMWNJoLg+Rg6Sf1ayYARW2BaQ=;
        b=mvjrz5WoZQKAnJk1K2Ie2HsNK9nT+b3uNyREu2WFPAUjzpME4PCjXxlC1D1tyQt/PZ
         SADKSdXlashXiKPG+SWCuHIq1izIo0OQbfy0a+ulNotoh91Ku9oB2i0ZFzIAr+HTzZdL
         7rddYJtcrdxhwaKi0RRUCGETtseJOpMHhbfN+ws/GBWiryto8z2A5P6BfUPbURAk5Gvq
         yN2jlAcny1rVkFRILz1uwF9BGuy+YGtHr1ybHSsu4ykVqDHgUEwfB9ERaZcEFg4Aci1S
         Tv6z/FbKnw4rwM1J4rYxHtldKfFol0XUPb0V0Oo5rgO7SGlDspvkxyOEY9WPzpIYrcKz
         7ICw==
X-Forwarded-Encrypted: i=1; AKwUvBx9jMR5+Sr2PzGUkqZYTb032sIfuFBr5tn6kdvecrQXFiKCY/yafIOisiXow+yNepfgHNzOf64LssY2RPQi3T1N@vger.kernel.org
X-Gm-Message-State: AFuF++mM6+10/3IZMbyX4zBvDvsj/UvuTyMJ1B6RnNdmo8wfcg34PiC7
	w+qU+jwn4oxbL+WJ1s71o4BjRLhPGcsdARZyv6MFkuv4AyHTukeQgJd3N6DoQaIHw1kxMAxCW2s
	om2rzW60qdA==
X-Received: from dyjh28.prod.google.com ([2002:a05:7300:561c:b0:32f:3095:c216])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:5483:b0:3d3:b00b:50fc
 with SMTP id adf61e73a8af0-3dd8c493051mr18965216637.28.1789967264055; Sun, 20
 Sep 2026 22:07:44 -0700 (PDT)
Date: Sun, 20 Sep 2026 22:06:31 -0700
In-Reply-To: <cover.1789966896.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <7c56d15d6e61fabe8b94f5a98713305f15bf0848.1789966896.git.irogers@google.com>
Subject: [PATCH v2 13/49] perf build: Make mypy build test opt-out (NO_MYPY=1)
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Commit 168910d0f937 ("perf build: Add mypy build tests") added mypy as an
opt-in compile-time check (MYPY=1) because of existing mypy errors across
perf Python scripts.

Now that all Python scripts in tools/perf have been cleaned up and pass
mypy without errors, make the mypy build test opt-out (default on when
mypy is installed, disabled with NO_MYPY=1), matching NO_SHELLCHECK=1.
Set MYPYPATH to tools/perf/python so local imports resolve during type
checking, and clean *.mypy_log files in 'make clean'.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Build            |  2 +-
 tools/perf/Makefile.perf    | 20 +++++++++++++++++---
 tools/perf/pmu-events/Build |  2 +-
 tools/perf/tests/Build      |  2 +-
 tools/perf/util/Build       |  2 +-
 5 files changed, 21 insertions(+), 7 deletions(-)

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
index 2438b40eaaec..f22eda3d2852 100644
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
@@ -263,8 +265,19 @@ ifneq ($(SHELLCHECK),)
 endif
 
 # Runs mypy on perf python files
-ifeq ($(MYPY),1)
-  MYPY := $(shell which mypy 2> /dev/null)
+MAKEOVERRIDES := $(filter-out MYPY=%,$(MAKEOVERRIDES))
+ifeq ($(NO_MYPY),1)
+  override MYPY :=
+else
+  ifeq ($(MYPY),1)
+    override MYPY := $(shell which mypy 2> /dev/null)
+  else
+    MYPY ?= $(shell which mypy 2> /dev/null)
+  endif
+endif
+
+ifneq ($(MYPY),)
+  override MYPY := MYPYPATH=$(srctree)/tools/perf/python $(MYPY)
 endif
 
 # Runs pylint on perf python files
@@ -948,7 +961,8 @@ clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(
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
2.55.0.1082.g2b9226bbc0-goog

