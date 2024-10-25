Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227B7215C40
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Oct 2024 17:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729876997; cv=none; b=SDra/iLv+0ZtP7wGAvjge8YZTzedU8gHRJ8eErtV5MFBNcu0RpqbZYHIpZr9MhYMpp3eJ3vxYZOw/zYgDrjwmaFrsQSPi9iH1GXmAj2VCzd7YxgCxwmsiHsnc7d1XrFJg9fUjeeuUi14b3Mnm4WsHe21hiejf3UgE2iUrqtDwbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729876997; c=relaxed/simple;
	bh=whrZnL3qoDzvyvEBiYskrp9oEULuMvfjTz/ou0miBHs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=DjNF5TqBE8nuQ5OGrWE4G8UwrpxUKLWJbqxtofyq0uQ1Xxm951V+Q2GvMgjBWbwHkm2TCTFIzXB7cVPtq7try8OAo4DFSlBV3FLOe6BKTTTZNDs5Ud3U/Vz3U/sLLIycoYTQdLFO4Do/NeCG8ZsB2WrJ9AJpaDKzjstzbxyEVis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P8x6dMXH; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P8x6dMXH"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e9ba43a9a0so27511717b3.3
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Oct 2024 10:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729876994; x=1730481794; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sz/UEKXnCGA0PqXPWkBUA1nKH/NXupw2GfE27Aui+BY=;
        b=P8x6dMXHFnEqbpjrZKHVo2KF3UtBUJeuJr1oNy5AhBczTWJeZX/YxMVk1VU6ZZm269
         nSOXutSzWO2Vk95pDHKSx5XbbKhBpOxEbdlw+NkTN8SVrfP4h/jW45GWQF8NaKvs9roF
         YHUDQjq5eINKW+z7LfK7KDvANn+4aHWwjABy7qdIgmx0h8+k/xkVPsn0nDNRJ7ddnx4/
         xSsXHz1mXlwF/Gycf4haek6jIpFN4MIy0xCRV5ZYy9qpxKQrFnpjw706kFLHmXUNAbAL
         6YtYXbggacW/kj6SIgAVf69stI4aD9av2vQ+w3NifT4al6W0dQ1H0oVcR1V//VAqOA6D
         83kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729876994; x=1730481794;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sz/UEKXnCGA0PqXPWkBUA1nKH/NXupw2GfE27Aui+BY=;
        b=ij5+rcIz4h9CdnjT799gBJ8DLyLIwlSzAseb5pgpTM2EotFO+tCIgu9KFiWjJmWazu
         1+yLBNssoCGkJtpXmic+qN9qfUYpsHqyeuGdH1F6oPAWj2qtlnDY2yqk3lg7T/C4FGvi
         GTuwx9v5DGuus63/IfLCuSHjZlpaunN4tKQR/qywjG19/ecyoQQL6642r3DDpICU0fkp
         BdHz5xlxPaly5G6Xy+cccW90dRgU020CKPZ+MrHlMV9p1GNrF/DqaQeuudOLXMO+4aR3
         7YD76ehFYvsoAYPxzV3nznCQ3Q9FoFDNjuNBlwpV7AY0zGD2ZHR+gaeULSpcA8ZeRAym
         61ZA==
X-Forwarded-Encrypted: i=1; AJvYcCUSAoqKNGj1xkcyNvELu63n493316nepxj4dDsN2YTiiKon1IXAwn6pvHE3XNuJDhTb8Hcr3JdWBLHthRU3kIBM@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5kFvEIKkXKXkH/JJEqeIunJ+kiW6eJVRXjdqwf/6bAI7o6SHU
	lMvs9OuUbVQkSuEik5mfSoM0jL541mHJpc6DcRWFBFsP7N49WFJYydZjZ+BY+knq0+Mu5hRdF3t
	l2q35CQ==
X-Google-Smtp-Source: AGHT+IFPkISZQs4e9NKiWIj/FzrvdjqfTcuCXMDAbIZbIt0S3D8ofTGpQ7uXkHKKBP08p+WojO4kBt+PvyNB
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:5d42:c43e:5e08:3a85])
 (user=irogers job=sendgmr) by 2002:a05:690c:6811:b0:66a:764f:e57f with SMTP
 id 00721157ae682-6e9d8afcc6dmr2087b3.7.1729876993661; Fri, 25 Oct 2024
 10:23:13 -0700 (PDT)
Date: Fri, 25 Oct 2024 10:23:00 -0700
In-Reply-To: <20241025172303.77538-1-irogers@google.com>
Message-Id: <20241025172303.77538-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241025172303.77538-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v1 3/6] perf build: Add mypy build tests
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Ze Gao <zegao2021@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If MYPY=1 is passed to the build then run mypy over python code in
perf. Unlike shellcheck this isn't default on as there are currently
too many errors.

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
index a9f2a9f6ebf0..333afe29b1e2 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -277,8 +277,13 @@ ifneq ($(SHELLCHECK),)
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
index a51d28c7431c..4d7c38a2bf6c 100644
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
index 18cd02ccd3ff..3baa1f41502d 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -409,3 +409,16 @@ $(OUTPUT)%.shellcheck_log: %
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
2.47.0.163.g1226f6d8fa-goog

