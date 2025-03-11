Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F65626561E
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Mar 2025 21:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741729014; cv=none; b=WsKy4+pDe0B/IPZuhO/S1iJkB6BUFLtAn6YlJytkxoqG7Sc9daCbf7Jwzf+cQ0BTCHxFKMIY9mW3ErtDMwHit0YldKxLYrZYqjmksQ5BF9UBnHRooTEpp2RwUMNsLjWizjHLGXhtCwOWvVAA0JMpogJ0cIb6sfdfh66bYlOr+hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741729014; c=relaxed/simple;
	bh=prFPYctpMfMxXw8YsBRXlFw6WjUGqFtw2PRPkyMQJC8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=TwhE1y+WGCxzublziuDzV3NCgAvFowR0UWyVm2BQzEfifU806XbPcfV1HUrkCnozbrXu58v2+BGo4JTpRZyB5MgXhKtZ4vt5JDI0bLXQKfxvApVv728X+P2lUlZwsvq+8sAeE1Mnfj9+sAAVq0MoFfFZbt1YUGoT0zMc9UKtQjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=07Z0mbgx; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="07Z0mbgx"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e635f5b4130so408836276.1
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Mar 2025 14:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741729010; x=1742333810; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7leD7T+ctFgDCp3PQfIKE2njcEEfQzDszwWeOPPtNYs=;
        b=07Z0mbgxmy4vqF7BT+8eZAcRoqSnJC0+dchw+0ClKd1AqspHCdJ3hyce5zjC2hCQ23
         Jgc9sD9eNUHi2Al+JoJhmuWP0vKNqPpIl0fQ8ruMIBMOrBzZxyJkUtwTQwTnQpkUnOca
         JhJOcFZt3KbK4BolvAklJCP8snYk/Q2EOmOSSoQ8YVLHiJy04B1GwIBcitGKa9iDMfGd
         XNdCywGtzvSEeujDtmVbR/krcTb1lyvjRkgO7jn6nLBLJyS2kT0XwVaU1vrCbci+sAaG
         OLWaV9DDN/6kPd9BfTUR1zpGKQypblJ6r+b2jBhi79eS6Qkn1JG/u6Q62kpT8tXfFRIH
         lR/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741729010; x=1742333810;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7leD7T+ctFgDCp3PQfIKE2njcEEfQzDszwWeOPPtNYs=;
        b=FmWQjP8qLBqR0/4YPLxx5J36sdpvFJs22yxjXKp/lOWqbqmVyQJVzL8zoGpBHPIYFF
         x3sCmQEycPXWkd4ujwUiqcjPEfzN91uUlHyT63Vk1Ci1tsAfoX1Ff+jID7/rG3fLhxbc
         IOrxmLz4rp+9oaUb5zGFvwmpMXc8c5GTqzmwceHHon3csaEyk0Jy5V4iiGREoX/1b+aP
         fpO6B409lWu8NL2CNISGejvf6u/g8ujlch4hgCYxw95Tv3UAU3WsfjvCP0AetlpoBN34
         pAdJiKEYtepzPD/uG3ax8rEhh8gBWNz5JTcF7qsqVyvh0sCYDcjLSpBoz0FROZBDFmR0
         juRw==
X-Forwarded-Encrypted: i=1; AJvYcCVjrnUMITOeR3cr0DsTTklueByM5269EQZQ5v0GjLLHx8EH0Z9npExrt2sBt3mpJUNAMjnWG3Qwyq4hAw+h7QZp@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/SVHwcaBws24ImfspaLCXulR5I3sRU3VJYX2OeInwklxRmZ1J
	LGPY0yUfv4EPycDJp0HYxtx8HRqbb1vLaGcm23aCx69rr+bLASy6zY5sWnx58vd4VkPq9e+le2J
	Lh5tOgQ==
X-Google-Smtp-Source: AGHT+IFeP7v/iSDazRmZSu0vFcSGIP6luGjDf3wXpCxNFnO3naR5HkBjUWpMrt8qh8sR4Voc+6jL30QnFn1j
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8bc2:942f:1b93:42dd])
 (user=irogers job=sendgmr) by 2002:a25:d8c7:0:b0:e63:c634:aded with SMTP id
 3f1490d57ef6-e63c634afe7mr23838276.2.1741729010338; Tue, 11 Mar 2025 14:36:50
 -0700 (PDT)
Date: Tue, 11 Mar 2025 14:36:26 -0700
In-Reply-To: <20250311213628.569562-1-irogers@google.com>
Message-Id: <20250311213628.569562-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250311213628.569562-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Subject: [PATCH v2 4/6] perf build: Add pylint build tests
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

If PYLINT=1 is passed to the build then run pylint over python code in
perf. Unlike shellcheck this isn't default on as there are currently
too many errors.

An example of an error:
```
************* Module setup
util/setup.py:19:0: C0301: Line too long (127/100) (line-too-long)
util/setup.py:20:0: C0301: Line too long (138/100) (line-too-long)
util/setup.py:63:0: C0301: Line too long (106/100) (line-too-long)
util/setup.py:1:0: C0114: Missing module docstring (missing-module-docstring)
util/setup.py:24:4: W0622: Redefining built-in 'vars' (redefined-builtin)
util/setup.py:11:4: C0103: Constant name "cc_options" doesn't conform to UPPER_CASE naming style (invalid-name)
util/setup.py:13:4: C0103: Constant name "cc_options" doesn't conform to UPPER_CASE naming style (invalid-name)
util/setup.py:15:34: R1732: Consider using 'with' for resource-allocating operations (consider-using-with)
util/setup.py:18:0: C0116: Missing function or method docstring (missing-function-docstring)
util/setup.py:19:16: R1732: Consider using 'with' for resource-allocating operations (consider-using-with)
util/setup.py:44:0: C0413: Import "from setuptools import setup, Extension" should be placed at the top of the module (wrong-import-position)
util/setup.py:46:0: C0413: Import "from setuptools.command.build_ext import build_ext as _build_ext" should be placed at the top of the module (wrong-import-position)
util/setup.py:47:0: C0413: Import "from setuptools.command.install_lib import install_lib as _install_lib" should be placed at the top of the module (wrong-import-position)
util/setup.py:49:0: C0115: Missing class docstring (missing-class-docstring)
util/setup.py:49:0: C0103: Class name "build_ext" doesn't conform to PascalCase naming style (invalid-name)
util/setup.py:52:8: W0201: Attribute 'build_lib' defined outside __init__ (attribute-defined-outside-init)
util/setup.py:53:8: W0201: Attribute 'build_temp' defined outside __init__ (attribute-defined-outside-init)
util/setup.py:55:0: C0115: Missing class docstring (missing-class-docstring)
util/setup.py:55:0: C0103: Class name "install_lib" doesn't conform to PascalCase naming style (invalid-name)
util/setup.py:58:8: W0201: Attribute 'build_dir' defined outside __init__ (attribute-defined-outside-init)

*-----------------------------------------------------------------
Your code has been rated at 6.67/10 (previous run: 6.51/10, +0.16)

make[4]: *** [util/Build:442: util/setup.py.pylint_log] Error 1
```

Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Build            | 13 +++++++++++++
 tools/perf/Makefile.perf    |  7 ++++++-
 tools/perf/pmu-events/Build | 13 ++++++++++++-
 tools/perf/scripts/Build    | 13 +++++++++++++
 tools/perf/tests/Build      | 13 +++++++++++++
 tools/perf/util/Build       | 12 ++++++++++++
 6 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Build b/tools/perf/Build
index 312914994c89..06107f1e1d42 100644
--- a/tools/perf/Build
+++ b/tools/perf/Build
@@ -89,3 +89,16 @@ $(OUTPUT)%.mypy_log: %
 	$(Q)$(call echo-cmd,test)mypy "$<" > $@ || (cat $@ && rm $@ && false)
 
 perf-y += $(MYPY_TEST_LOGS)
+
+ifdef PYLINT
+  PY_TESTS := $(shell find python -type f -name '*.py')
+  PYLINT_TEST_LOGS := $(PY_TESTS:python/%=python/%.pylint_log)
+else
+  PYLINT_TEST_LOGS :=
+endif
+
+$(OUTPUT)%.pylint_log: %
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,test)pylint "$<" > $@ || (cat $@ && rm $@ && false)
+
+perf-y += $(PYLINT_TEST_LOGS)
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index c773f0dd8226..367746e3c9b0 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -311,8 +311,13 @@ ifeq ($(MYPY),1)
   MYPY := $(shell which mypy 2> /dev/null)
 endif
 
+# Runs pylint on perf python files
+ifeq ($(PYLINT),1)
+  PYLINT := $(shell which pylint 2> /dev/null)
+endif
+
 export srctree OUTPUT RM CC CXX LD AR CFLAGS CXXFLAGS V BISON FLEX AWK
-export HOSTCC HOSTLD HOSTAR HOSTCFLAGS SHELLCHECK MYPY
+export HOSTCC HOSTLD HOSTAR HOSTCFLAGS SHELLCHECK MYPY PYLINT
 
 include $(srctree)/tools/build/Makefile.include
 
diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index fc1dc810ffb6..32f387d48908 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -52,8 +52,19 @@ $(OUTPUT)%.mypy_log: %
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,test)mypy "$<" > $@ || (cat $@ && rm $@ && false)
 
+ifdef PYLINT
+  PMU_EVENTS_PY_TESTS := $(wildcard *.py)
+  PMU_EVENTS_PYLINT_TEST_LOGS := $(JEVENTS_PY_TESTS:%=%.pylint_log)
+else
+  PMU_EVENTS_PYLINT_TEST_LOGS :=
+endif
+
+$(OUTPUT)%.pylint_log: %
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,test)pylint "$<" > $@ || (cat $@ && rm $@ && false)
+
 $(PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_TEST_LOG) \
-    $(EMPTY_PMU_EVENTS_TEST_LOG) $(PMU_EVENTS_MYPY_TEST_LOGS)
+    $(EMPTY_PMU_EVENTS_TEST_LOG) $(PMU_EVENTS_MYPY_TEST_LOGS) $(PMU_EVENTS_PYLINT_TEST_LOGS)
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVENTS_MODEL) pmu-events/arch $@
 endif
diff --git a/tools/perf/scripts/Build b/tools/perf/scripts/Build
index a5350dc6ac50..91229a1fe3ff 100644
--- a/tools/perf/scripts/Build
+++ b/tools/perf/scripts/Build
@@ -15,3 +15,16 @@ $(OUTPUT)%.mypy_log: %
 	$(Q)$(call echo-cmd,test)mypy "$<" > $@ || (cat $@ && rm $@ && false)
 
 perf-y += $(MYPY_TEST_LOGS)
+
+ifdef PYLINT
+  PY_TESTS := $(shell find python -type f -name '*.py')
+  PYLINT_TEST_LOGS := $(PY_TESTS:python/%=python/%.pylint_log)
+else
+  PYLINT_TEST_LOGS :=
+endif
+
+$(OUTPUT)%.pylint_log: %
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,test)pylint "$<" > $@ || (cat $@ && rm $@ && false)
+
+perf-y += $(PYLINT_TEST_LOGS)
diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 0d4af485bf55..934f32090553 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -104,3 +104,16 @@ $(OUTPUT)%.mypy_log: %
 	$(Q)$(call echo-cmd,test)mypy "$<" > $@ || (cat $@ && rm $@ && false)
 
 perf-test-y += $(MYPY_TEST_LOGS)
+
+ifdef PYLINT
+  PY_TESTS := $(shell find tests/shell -type f -name '*.py')
+  PYLINT_TEST_LOGS := $(PY_TESTS:tests/shell/%=shell/%.pylint_log)
+else
+  PYLINT_TEST_LOGS :=
+endif
+
+$(OUTPUT)%.pylint_log: %
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,test)pylint "$<" > $@ || (cat $@ && rm $@ && false)
+
+perf-test-y += $(PYLINT_TEST_LOGS)
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 583f425713eb..946bce6628f3 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -430,3 +430,15 @@ $(OUTPUT)%.mypy_log: %
 	$(Q)$(call echo-cmd,test)mypy "$<" > $@ || (cat $@ && rm $@ && false)
 
 perf-util-y += $(MYPY_TEST_LOGS)
+
+ifdef PYLINT
+  PYLINT_TEST_LOGS := $(PY_TESTS:%=%.pylint_log)
+else
+  PYLINT_TEST_LOGS :=
+endif
+
+$(OUTPUT)%.pylint_log: %
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,test)pylint "$<" > $@ || (cat $@ && rm $@ && false)
+
+perf-util-y += $(PYLINT_TEST_LOGS)
-- 
2.49.0.rc0.332.g42c0ae87b1-goog

