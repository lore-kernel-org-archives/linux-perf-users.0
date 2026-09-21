Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10E634CFC2
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789967268; cv=none; b=GrKQ5wzG4tmTPDSxj/h7Cuvw3oT0q03ZrD1lcSVIYntbFj+GfI1PuosH2l7raqNzKoVG1Hl4SWwvnwNFpS3CI4n6MuhfLZEyXrgxEveRwl0/TCs6moQHU8iUD4xllsf1mvdBB4Ky1Uhr8yHWbi/MOwwv9RqTIYWWGrj4qhUg+j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789967268; c=relaxed/simple;
	bh=zuycMtg5eKZrs8s8eypBtjLTX21DAkgnItk8B0j0DQw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C0yjaVbIENvAlTW1mafov1s18FMN6CMZzl7my8vH0xqJv5xG8kyqm9ih5wuj+DNg/uFPIxINxOr4GPAib0aHJ8Hn2LLyQmclPVuDWECxT0gps1lAwA0Yn9QTCc56if+z40DlfBUoCO+MHd/Ei8fmU6jEUuVVbbAMrT9FvgWOBkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NcdL2biH; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NcdL2biH"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38dbf293831so6181266a91.3
        for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 22:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789967266; x=1790572066; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PwtddJRknDHV1Gp49R0RIm84gq/uTIAaiAp2YpcIxtc=;
        b=NcdL2biHG9SKhEH1+dobzwfthm68l00/f8h5moRJUzyCaARI1WeCa9EhoiywazB5+M
         fED4TFgc+lnj/ree3VbS+ix/8SfKFpOydxPmVRmL+0T6okTMyEfa0slOeOmvRpfyfFhM
         IpbQS31WEzgD6moa6t1xYPh39OmZq2hm3lc+dvub64UZM4XM2QCCSlaItIon1669W5xL
         D5pk17Lkaj8W/+ec5FkAMdLTx7OWMDYhUgfRBIDg9hYk0qJwpqQRaw9SaZAygIWxZ3ML
         E0wObEeKErXNziK2St5sWm9DuZObWyMHj9hvncnTE9P3Xr8tKMBFw7BIPoKmTtrpDRBt
         RIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789967266; x=1790572066;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PwtddJRknDHV1Gp49R0RIm84gq/uTIAaiAp2YpcIxtc=;
        b=R+EL+XnUNyB3xz3nJ6NW3mXUZGoneQsFDyMlWfxVO1lntWN9VM/iHKxx3k+0HW6v8g
         jLmVlFnsOTT0LwkYYvoFngLmzpSE/wLr2S2OgNaDwxI4zfEer59oqBzCHyk99w8DCyeu
         3BVle0hgDUrChHY0mkejf0imZUssjEPveUvMFWmcyElMlcI/vHgbIuTJNfFAsNr6f663
         nxDH9jY7QlGx+GXrlB8zEKZxK4Iu4EQJjQoszXa99xzF3RYnNV0voxG9obFKdlP4sTBK
         9X/sjfXesEDEosS/gtyRZps9J9iS0Oxp1cVm22j3UlMCslpM0QvPyzbZSL8OZ7v8e6xF
         u5Dw==
X-Forwarded-Encrypted: i=1; AKwUvBxclU49vCeNuRm9u5VVpKR9pscVzifBO1OE5xANqrIkBP+PLh8Y4cYbgiNvEJ5UGxf4xdFGLxmmZwCdL4ka+AJ/@vger.kernel.org
X-Gm-Message-State: AFuF++mbJZMYfO9NzO6A5E9EMRPdq/uGN7G7gNvADwXDV/GvVLI1zFPH
	dbjS20VvKcu2bvLiYV4xt8/J+MzFXZ8h19mlR2CyVnuF4Pr/Fegv/tpLKg5SPSmtStIyrp8Q25p
	JKZLCQ4M64A==
X-Received: from dldnz4.prod.google.com ([2002:a05:701a:ca04:b0:143:75c2:6d21])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:50c6:b0:39d:e213:9dd3
 with SMTP id 98e67ed59e1d1-39e54cc62d2mr16763558a91.1.1789967265953; Sun, 20
 Sep 2026 22:07:45 -0700 (PDT)
Date: Sun, 20 Sep 2026 22:06:32 -0700
In-Reply-To: <cover.1789966896.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <e09a629b8d92a9554be1f9a08ffcaa994394b8d2.1789966896.git.irogers@google.com>
Subject: [PATCH v2 14/49] perf build: Make pylint build test opt-out (NO_PYLINT=1)
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
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

