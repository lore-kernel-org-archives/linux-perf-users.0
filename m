Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7C438E8A6
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790403689; cv=none; b=nbezlhOHKfSoU+AlRr3NgWduGHr6aaDBWMUusrwSaA8VCiTsCN69D3Relt0klEiIcaqAFszyofnk4zdkWhEOMpFskZe6E/YjQrw4AXZA9gjHIxrqX51XOBx4qCIHyODOQZvhGNk28Y8m7Q3XvcSwJNC2uSO3XZZ7z3wBmMPrsqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790403689; c=relaxed/simple;
	bh=vstN9V5PVQ/4gt3/DKShJNCXrSXllChjMMHOKUSy8g0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZXlQw3NwoSbDIl15ziBWfU73iYkQd65UXGd5hyYAsZlYLhmnjoaVs48zbtK1yGZjrundosUjeIpOcaJDDFYDix8uK5FNJceKYMIn29jpBfT5iftgaZ2RY7Pi6hcsyKiaeGZ5jRYoiGPbsVBHgPjIMwLWBM+LdUqgR/tW39suaO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qf9KPUnT; arc=none smtp.client-ip=74.125.82.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qf9KPUnT"
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3425098ae4bso915918eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 23:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790403686; x=1791008486; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JMuTiyaf8RLZgGMnqpEmNWwSOL4ew1Gnrcb09peYmkg=;
        b=qf9KPUnTrYOXSCBd0QSrQdVYIoeubgezBtIC1Ktoj3+Ae27CZ88lbj3UTYI1yBZ7Xf
         RQHfQbI9uI7BmMWeQyR1ZyS1KYLAJ6amvgkOQSc3VXPvLznT1oh52Fq+3WRGz+87MXVW
         B4foM4J7Uk/2cWTEFpkd1gKrNgyHE5DmiNEPc9T5XYd4+nrTT+c6BNLy5Viw3KYr5rre
         yijg0K5Uk/gSV4wtgwZXuMhb+3kL6kb3IUMNu46Rq92fnUIuCHmJcMuVaRd9lLmgrofX
         CQYaGT9Xd8ZhoGpsxOsSOdEeTs/wQb8UirYXAimCnrIBBmaGlxIgj7WkeCl7y4/7k1Qt
         im6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790403686; x=1791008486;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JMuTiyaf8RLZgGMnqpEmNWwSOL4ew1Gnrcb09peYmkg=;
        b=dLHTPyXN2mywbB/nz9Bljx34stiA5SbDBRHxFP1OxJN2DMaGFWWtelCqquuFESScMG
         0PajoBKftzk75+Q+xPka9otiagenouscFjPQqAkq/EEWQeXpWCc/Mapy5jqhuuOhkFP9
         svtaQTOviamVj9gNOXH8uW0ZTFFtysnHExxOHiVB03PVdFD1MFUvbe+oBNrmUvwKkIlO
         UxTKbCYI7VHPYT/4z8veEz7nDobBYCwjTjQd3WtYZGSLyevo9YZdH4/ErldwfM4URQ4Y
         E3yO4N9iAPT4KH1uB3RnKfag0mwM2gcZCmEAtD4stVsa8obWF5LLpAykwXYXs4iGOg5V
         VVRQ==
X-Forwarded-Encrypted: i=1; AKwUvBzO42+yP0z3EGVz0ohlZjCEBWIwiVdn9rnazWZNQhYqk/eDrqtiFa5mHSBQOMMy6SJjtvBmoo5tGJyYGFk2EKFR@vger.kernel.org
X-Gm-Message-State: AFuF++m32nv1x51ujjsuAGGQQtLiEwi3aL0cLTaLUQqw55kc+xpVTbrv
	ABmo5bxupbYpZkkyV95dSLufgcreIJNWb1fQwNIsXPuB5687nYByAvwdG8vB3rER9VLH62SGzq4
	Ovo5w9peZqw==
X-Received: from dlbpu5.prod.google.com ([2002:a05:7022:e885:b0:144:f4b8:ee5e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:454e:20b0:146:7648:619
 with SMTP id a92af1059eb24-146ce67ee01mr1815601c88.6.1790403685796; Fri, 25
 Sep 2026 23:21:25 -0700 (PDT)
Date: Fri, 25 Sep 2026 23:19:41 -0700
In-Reply-To: <20260926062029.800743-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923181213.3032038-1-irogers@google.com> <20260926062029.800743-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260926062029.800743-15-irogers@google.com>
Subject: [PATCH v4 14/49] perf build: Make pylint build test opt-out (NO_PYLINT=1)
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	james.clark@linaro.org, leo.yan@linux.dev, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
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
index fbb5dfb67089..168b286770f3 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -128,6 +128,8 @@ include ../scripts/utilities.mak
 # Define NO_SHELLCHECK if you do not want to run shellcheck during build
 #
 # Define NO_MYPY if you do not want to run mypy during build
+#
+# Define NO_PYLINT if you do not want to run pylint during build
 
 # As per kernel Makefile, avoid funny character set dependencies
 unexport LC_ALL
@@ -281,9 +283,39 @@ ifneq ($(force_fixdep),1)
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
@@ -963,7 +995,7 @@ clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(
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
index cd7b62a6c1b8..8fecd5390124 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -117,6 +117,6 @@ endif
 
 $(OUTPUT)%.pylint_log: %
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,test)pylint "$<" > $@ || (cat $@ && rm $@ && false)
+	$(Q)$(call echo-cmd,test)$(PYLINT) "$<" > $@ || (cat $@ && rm $@ && false)
 
 perf-test-y += $(PYLINT_TEST_LOGS)
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index f922794e8108..afcf98dc5006 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -438,7 +438,7 @@ endif
 
 $(OUTPUT)%.pylint_log: %
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,test)pylint "$<" > $@ || (cat $@ && rm $@ && false)
+	$(Q)$(call echo-cmd,test)$(PYLINT) "$<" > $@ || (cat $@ && rm $@ && false)
 
 perf-util-y += $(PYLINT_TEST_LOGS)
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

