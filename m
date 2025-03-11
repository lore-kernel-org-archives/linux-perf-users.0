Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D35265607
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Mar 2025 21:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741729010; cv=none; b=KhUNUiYYdf3piipkgGtLbtGxPX2FzjH1w23g0fbjxFlbzU+rzRp9fGi2uUCjopoA0DS2f6hF2nVDCsWvYJLL6b8P00gPw2i39rdOulxJeEOIOHLeZ0xmFIUdfTz/3skdRJKsQ6hVEt8waL3ljDsv2xlo4J1/kbeKO9ROiHF2/P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741729010; c=relaxed/simple;
	bh=oyu8lw9K/26NHvHUSulTIqzjOCPRQJ1LifG2wGMOKOk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=YLXwgsIXGH1uawVhukukYz0my6WrvtQFOtMq1IuhSrOFF/QXERzzxqC0bnF9mA4+/ZAt3XNrLk5XIaiC1MuQ6WZXlOyMpVCfi7nBD6JRQV1jy+LkzfxXsDub6pmLlGYXXuXVtmX/nVNEfaj71+LoQVEVdnIkqMds+z2UnItXd/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0+2SzjeY; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0+2SzjeY"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6fcfa304ef4so4446517b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Mar 2025 14:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741729008; x=1742333808; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xogXU6Og8ryJY6/dwJTkee5oWdKRrgoK8k4Hjzq9iqc=;
        b=0+2SzjeYBFahRYHsKchVCdsnrjwO52AYU9NgdmcHbouZf1/azLPk+sZAgEQmYxVamD
         33wp6VGA0AKuU8R/FDSdZsDUU6eqd9ni+oyUDNaBBdMZAHo/UXAB5+eaYq2iK4LeGZeN
         ikOhA/M6AaH2gFi/bzBSS50WPW1Sok6c7jlDacGwZTc+hGSF5oxcRQ3sWuDRTMgRhhPR
         pX+Bk8HGhaj8+s6sg6tN1xtarRc79GGfINjw4wqfVajfxX0VNzuX0KDW1PXQ6imB2D0u
         1toVt048ZWfuLPO8yUZeztFm17ECv/860lrUVJi2WXEeD+twLl/BtJOpI4JnWW7T6FzC
         FdFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741729008; x=1742333808;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xogXU6Og8ryJY6/dwJTkee5oWdKRrgoK8k4Hjzq9iqc=;
        b=Ve6ktMXZDQhMJwZUqD9Sf/1pFb4UMixPUTO3g6+WJ41p/K74cz/32XE/YJSAqw/IgH
         93yeAmDx0lcpS2MzDlSwJkkelpKz781BlJYnQKdyubXo0JN0KRq4NzkLef8icDCwbyJx
         ja2MaSx2CK6LHr0wCMY55nD68q8imizusni9zzTNTmEttDP7zZrbG+fUl7V+cer7sBow
         fXj6B2xS/wh0Yh965kQKw5wICgT3JWEo1k3clzu7/q85A5bp92n2M8Fx9u4jW2X95vSF
         SfXAWmLWPlIKUhlddmjdRUeB2VUrKGsszb+SFwKHRLDy+pZXNIi4eKggJtL11r3fp74z
         WzCQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2Xq7ugXOSYMpbjFNrp1Bv40wnta7LzhFB85fl2U11wUCZOLWuB4WTwz/k/kt9y9btJpDocqHqMOfGDt5OZ/sC@vger.kernel.org
X-Gm-Message-State: AOJu0YzlA8uecj5c62AITxCmLxAct69a96NPylrZNaTaqVI1xdZ/tCT/
	hBka6CfhjdTZgzyK+A/sF/CyJLkR1eMFSpcGue0f2yKnmSg1djsu+j2TwxOE4xzNVNuX6Sja0Mj
	ky6dhWQ==
X-Google-Smtp-Source: AGHT+IFpNpLqO6N7avVB4iTUdP7MEq+rMgk+d6OC8QKIeW5YDFyDKq7mUCUwtdx57HqFJb2wkQgHhmnYDKeI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8bc2:942f:1b93:42dd])
 (user=irogers job=sendgmr) by 2002:a81:be0e:0:b0:6fe:ccb5:1dbd with SMTP id
 00721157ae682-6ff0a3f00d3mr5279137b3.5.1741729007828; Tue, 11 Mar 2025
 14:36:47 -0700 (PDT)
Date: Tue, 11 Mar 2025 14:36:25 -0700
In-Reply-To: <20250311213628.569562-1-irogers@google.com>
Message-Id: <20250311213628.569562-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250311213628.569562-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Subject: [PATCH v2 3/6] perf build: Add mypy build tests
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

If MYPY=1 is passed to the build then run mypy over python code in
perf. Unlike shellcheck this isn't default on as there are currently
too many errors.

An example of an error:
```
util/setup.py:8: error: Item "None" of "str | None" has no attribute "split"  [union-attr]
util/setup.py:15: error: Item "None" of "IO[bytes] | None" has no attribute "readline"  [union-attr]
util/setup.py:15: error: List item 0 has incompatible type "str | None"; expected "str | bytes | PathLike[str] | PathLike[bytes]"  [list-item]
util/setup.py:16: error: Unsupported left operand type for + ("None")  [operator]
util/setup.py:16: note: Left operand is of type "str | None"
util/setup.py:74: error: Unsupported left operand type for + ("None")  [operator]
util/setup.py:74: note: Left operand is of type "str | None"
Found 5 errors in 1 file (checked 1 source file)
make[4]: *** [util/Build:430: util/setup.py.mypy_log] Error 1
```

Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Build            | 13 +++++++++++++
 tools/perf/Makefile.perf    |  7 ++++++-
 tools/perf/pmu-events/Build | 14 +++++++++++++-
 tools/perf/scripts/Build    | 13 +++++++++++++
 tools/perf/tests/Build      | 13 +++++++++++++
 tools/perf/util/Build       | 13 +++++++++++++
 6 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Build b/tools/perf/Build
index 5e385f370dd7..312914994c89 100644
--- a/tools/perf/Build
+++ b/tools/perf/Build
@@ -76,3 +76,16 @@ $(OUTPUT)%.shellcheck_log: %
 	$(Q)$(call echo-cmd,test)shellcheck -s bash -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
 
 perf-y += $(SHELL_TEST_LOGS)
+
+ifdef MYPY
+  PY_TESTS := $(shell find python -type f -name '*.py')
+  MYPY_TEST_LOGS := $(PY_TESTS:python/%=python/%.mypy_log)
+else
+  MYPY_TEST_LOGS :=
+endif
+
+$(OUTPUT)%.mypy_log: %
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,test)mypy "$<" > $@ || (cat $@ && rm $@ && false)
+
+perf-y += $(MYPY_TEST_LOGS)
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index aebdf317afcc..c773f0dd8226 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -306,8 +306,13 @@ ifneq ($(SHELLCHECK),)
   endif
 endif
 
+# Runs mypy on perf python files
+ifeq ($(MYPY),1)
+  MYPY := $(shell which mypy 2> /dev/null)
+endif
+
 export srctree OUTPUT RM CC CXX LD AR CFLAGS CXXFLAGS V BISON FLEX AWK
-export HOSTCC HOSTLD HOSTAR HOSTCFLAGS SHELLCHECK
+export HOSTCC HOSTLD HOSTAR HOSTCFLAGS SHELLCHECK MYPY
 
 include $(srctree)/tools/build/Makefile.include
 
diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index d941bc9d16e9..fc1dc810ffb6 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -41,7 +41,19 @@ $(EMPTY_PMU_EVENTS_TEST_LOG): $(EMPTY_PMU_EVENTS_C) $(TEST_EMPTY_PMU_EVENTS_C)
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,test)diff -u $^ 2> $@ || (cat $@ && false)
 
-$(PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_TEST_LOG) $(EMPTY_PMU_EVENTS_TEST_LOG)
+ifdef MYPY
+  PMU_EVENTS_PY_TESTS := $(wildcard *.py)
+  PMU_EVENTS_MYPY_TEST_LOGS := $(JEVENTS_PY_TESTS:%=%.mypy_log)
+else
+  PMU_EVENTS_MYPY_TEST_LOGS :=
+endif
+
+$(OUTPUT)%.mypy_log: %
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,test)mypy "$<" > $@ || (cat $@ && rm $@ && false)
+
+$(PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_TEST_LOG) \
+    $(EMPTY_PMU_EVENTS_TEST_LOG) $(PMU_EVENTS_MYPY_TEST_LOGS)
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVENTS_MODEL) pmu-events/arch $@
 endif
diff --git a/tools/perf/scripts/Build b/tools/perf/scripts/Build
index 46f0c6f76dbf..a5350dc6ac50 100644
--- a/tools/perf/scripts/Build
+++ b/tools/perf/scripts/Build
@@ -2,3 +2,16 @@ ifeq ($(CONFIG_LIBTRACEEVENT),y)
   perf-util-$(CONFIG_LIBPERL)   += perl/Perf-Trace-Util/
 endif
 perf-util-$(CONFIG_LIBPYTHON) += python/Perf-Trace-Util/
+
+ifdef MYPY
+  PY_TESTS := $(shell find python -type f -name '*.py')
+  MYPY_TEST_LOGS := $(PY_TESTS:python/%=python/%.mypy_log)
+else
+  MYPY_TEST_LOGS :=
+endif
+
+$(OUTPUT)%.mypy_log: %
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,test)mypy "$<" > $@ || (cat $@ && rm $@ && false)
+
+perf-y += $(MYPY_TEST_LOGS)
diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 5b4b7a3825fd..0d4af485bf55 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -91,3 +91,16 @@ $(OUTPUT)%.shellcheck_log: %
 	$(Q)$(call echo-cmd,test)shellcheck -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
 
 perf-test-y += $(SHELL_TEST_LOGS)
+
+ifdef MYPY
+  PY_TESTS := $(shell find tests/shell -type f -name '*.py')
+  MYPY_TEST_LOGS := $(PY_TESTS:tests/shell/%=shell/%.mypy_log)
+else
+  MYPY_TEST_LOGS :=
+endif
+
+$(OUTPUT)%.mypy_log: %
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,test)mypy "$<" > $@ || (cat $@ && rm $@ && false)
+
+perf-test-y += $(MYPY_TEST_LOGS)
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index fd595454766e..583f425713eb 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -417,3 +417,16 @@ $(OUTPUT)%.shellcheck_log: %
 	$(Q)$(call echo-cmd,test)shellcheck -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
 
 perf-util-y += $(SHELL_TEST_LOGS)
+
+PY_TESTS := setup.py
+ifdef MYPY
+  MYPY_TEST_LOGS := $(PY_TESTS:%=%.mypy_log)
+else
+  MYPY_TEST_LOGS :=
+endif
+
+$(OUTPUT)%.mypy_log: %
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,test)mypy "$<" > $@ || (cat $@ && rm $@ && false)
+
+perf-util-y += $(MYPY_TEST_LOGS)
-- 
2.49.0.rc0.332.g42c0ae87b1-goog

