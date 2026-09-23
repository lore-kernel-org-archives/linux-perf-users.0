Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AFD497B93
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187219; cv=none; b=m3ltKSmvur493RQzjS+K4+gy7wYKRXUVDYfuTfPTMRQ6hq6ZKC0TvJX0HG1e7QWJthvMnM+leiZP5nlIxHQwSww+Ub3iMq5M0Iz92HX7qW2x5pQOPOB1MvTR/F7TpG1PluNt13JyvnkXLpqnTucnIeD0EGKJp/3sHatVPqv8DQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187219; c=relaxed/simple;
	bh=tK+fRx6syfWM9ocycAOJ6lVgRUkKT9ljETZX87PyWwo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hpIGH6WguReQdy32u7/xrWdmbRzDlq7uBtPTU4C0NktQtqH5WhQwHS+8Q5sjYUDsYQQqCoshzOYxap0dCLVLbDWf4rMHdcT6R/jmkzzELRLyXD9w7I6NrMaRilbAclBqv+URlYJBJUEGw5VYSdvm7VaSMAfwPPerVhHZAMap9hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UO1mOAMh; arc=none smtp.client-ip=74.125.82.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UO1mOAMh"
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-14388794dcfso453592c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 11:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790187207; x=1790792007; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jnoc9MZNbNt2LlkkCvZ6RrV9DZCe8GgCTw1SQFJkYmY=;
        b=UO1mOAMhbCvTEPqrO79KKSCrUP9dQU3wd3RQBM7/yObo7LAr2PY+jhL5Z85AcPhho5
         V9RFridRcXpYKU7EbYhytH50fpObjTb99vdHQgHSfPu3oR+EW6ecKFUb2Q+CTZTKmlXL
         bw8gJA/Zp7oyEBTe985FWqFxhZKMmUsgVaMylqUv0ZTWyOOCBrFSVkHf55wCb3M2qwc5
         lQWIx42OOrAp8ktdxGC4Y/CNZe1P7HHvrCefdRq/djXmFi9DfJFj1Qpa4Z8DDjEmpcyU
         YX4sQvrJ/nxlhIs5nrKdTLUvHKV6j8rh1TizLpbKUqeOiX0C5vnRQGnjC7KoBH7uROOR
         hdvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790187207; x=1790792007;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jnoc9MZNbNt2LlkkCvZ6RrV9DZCe8GgCTw1SQFJkYmY=;
        b=VhwD0GNE2S1Z1151W6h9AkQHPpdXipe14OC4pYtj6TClpDXzdT4BQlgFfPb6dz+ZpX
         J58AwpKUukNPHoDEzLnZBmJyqz4DJfSYh7BDWphvYVVRW4ic2AfvQU4xI8DwWTHmdNZb
         Tw/+SIKLQz9FOY/kAiRFbSbYfj+2lhTecqbq7j8rC9spvV9uB54xr6A5DwQB2sl3MODV
         KeSFlauXsGgNVyYcnZYSzsFor91MU/H28oWFG2nz9v/ClA+aWgyChRMXHvf99rIbPfYZ
         teihk4Tjt1de8LKNwQNct7HuittTZn1b64wrMBjR9fWGymcGNNGSp0BklKEWe0DqXWyK
         0uZQ==
X-Forwarded-Encrypted: i=1; AKwUvBy57QsGdP2zb+KRK0mDqeBXjynzq5GigzTKMmuHBjfK6U6MWU4oj8gGjj/rN2p/1eJQLfV26/XdXnZDiuCaGi2V@vger.kernel.org
X-Gm-Message-State: AFuF++nYpXByhvWDG+A4d7PGjVphq74+9vu9gP7PfN33S/2ZQWe8ZQlO
	P0Rh9TxDv3itcw+IIzMpeK5K2eke1o6rVkIOiMZFKbXd/+IVFrPxL3fb1o61xiqaINp0LIHFuGM
	nVfAWk2ogVg==
X-Received: from dlbem11.prod.google.com ([2002:a05:7022:100b:b0:144:d7d5:5999])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:42c7:10b0:144:fb31:a5a4
 with SMTP id a92af1059eb24-144fb31a6eemr3029203c88.42.1790187206598; Wed, 23
 Sep 2026 11:13:26 -0700 (PDT)
Date: Wed, 23 Sep 2026 11:11:37 -0700
In-Reply-To: <20260923181213.3032038-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com> <20260923181213.3032038-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260923181213.3032038-15-irogers@google.com>
Subject: [PATCH v3 14/49] perf build: Make pylint build test opt-out (NO_PYLINT=1)
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Commit 8a54784e708b ("perf build: Add pylint build tests") added a
compile-time pylint check for Python files in tools/perf, but left it
opt-in via PYLINT=1.

Now that pylint issues across tools/perf/python, tools/perf/pmu-events,
and tools/perf/tests/shell/lib have been cleaned up, enable the pylint
check by default when pylint is installed on the system, with an opt-out
via NO_PYLINT=1 (matching NO_SHELLCHECK=1, NO_MYPY=1, and other perf
build feature flags).

Configure PYTHONPATH in Makefile.perf so pylint resolves perf.pyi type
stubs and pmu-events modules, enable error and warning categories
(--disable=all --enable=E,W --disable=W0123,W0311,W0511,W0603,W0622,W0718
--ignored-modules=textual,setproctitle) appropriate for perf's standalone
CLI and test scripts, and require pylint >= 2.16.0 (skipping with a
warning if an older version is installed).

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Build            |  2 +-
 tools/perf/Makefile.perf    | 40 +++++++++++++++++++++++++++++++++----
 tools/perf/pmu-events/Build |  2 +-
 tools/perf/tests/Build      |  2 +-
 tools/perf/util/Build       |  2 +-
 5 files changed, 40 insertions(+), 8 deletions(-)

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
index c7cade270b23..aacaa04854c5 100644
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
@@ -284,9 +286,39 @@ ifneq ($(force_fixdep),1)
   endif
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
+# Wait until after the fixdep bootstrap sub-make (force_fixdep != 1) before
+# resolving PYLINT and stripping PYLINT=% from MAKEOVERRIDES (substituting
+# escaped spaces so multi-word overrides are removed as a single token) so child
+# Makefile.build sub-makes inherit the PYTHONPATH- and flag-wrapped export.
+ifneq ($(force_fixdep),1)
+  MAKEOVERRIDES := $(subst __SPACE__,\ ,$(filter-out PYLINT=%,$(subst \ ,__SPACE__,$(MAKEOVERRIDES))))
+  ifeq ($(NO_PYLINT),1)
+    override PYLINT :=
+  else ifeq ($(filter-out 1,$(PYLINT)),)
+    override PYLINT := $(shell which pylint 2> /dev/null)
+  endif
+
+  ifneq ($(PYLINT),)
+    ifneq ($(shell $(PYLINT) --version 2>/dev/null | \
+          awk '/^pylint / { split($$2, v, "."); print (v[1]+0 > 2 || (v[1]+0 == 2 && v[2]+0 >= 16)) }'), 1)
+      $(warning Warning: pylint version is older than 2.16.0, skipping pylint checks.)
+      override PYLINT :=
+    else
+      override PYLINT := PYTHONPATH=$(srctree)/tools/perf/python:$(srctree)/tools/perf/pmu-events \
+        $(PYLINT) --disable=all --enable=E,W --disable=W0123,W0311,W0511,W0603,W0622,W0718 \
+        --ignored-modules=textual,setproctitle
+    endif
+  endif
 endif
 
 export srctree OUTPUT RM CC CXX RUSTC CLANG LD AR CFLAGS CXXFLAGS RUST_FLAGS V BISON FLEX AWK LIBBPF READELF
@@ -966,7 +998,7 @@ clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(
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
2.56.0.rc1.310.g51773c2048-goog

