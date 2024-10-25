Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F58C215C61
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Oct 2024 17:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729876999; cv=none; b=Fv6QpZnSiok5tfsR355LZKKFeo6H+5GN/ysAyQAVeZ5VzRTv8L1nC6QyGoswxp8228SuDUDPOWTqDoFTi+oJyHanXaRvSdv5U7G6vIjSH23rliAx4/y+oK3jEzdX+Zplpupfn/cPNF0sdAhpfZiVWyIbgjrfUvbyM7mE9DoHEvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729876999; c=relaxed/simple;
	bh=XIcaTzPvlAddesoN9ZYb8TOpkCEOUgxBULA503FfBtM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ROyl7Fbj+EVRbXwvu5EU+K9Sa3dV7SYIDVNHgO4HDizVj+yGqpjS/67F/1rqwu4xStTbyZMuaXkfsRmGrdFDL3sqObammFzfNvLzlmBOcRPs6MeOoqkT9iSHK4B0ycYIVU8nD5jqRHigcJ+1XlFXa5aYtv90ieVBoJ/kE5J9O8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LkPSYayB; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LkPSYayB"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e9ba43a9a0so27512287b3.3
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Oct 2024 10:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729876996; x=1730481796; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SLI7/+S+crXUNgOywJ67SL6jHRzdYtHJtqzDx7qk0Yg=;
        b=LkPSYayBeBrOB6KOj7eS6cIOa+uu6CRIa/iKgYM7VzWPVSCgVgw38M0SuejcM6woUc
         Rkk104QWSX4FLGi6YyGN49zCRxI7ROSEAnL5dqTpHK3Q0ZgYgwssMWj2lQgLpU+sQiUx
         Q5Ln4RdGvIzRFC9CuDgbpoaF08//ixCoxtWydw6T/mtDwXiVjYnwBJGX69i+LJzcpvxT
         q1CmP/laND23BjpKnwYMgJU/QztnKNHpi7XZiBIBtFZL0nzM+WOuiNZhTFk6f/1XXK0q
         69h/PX/C6uo3j+lcxGgEmnj184abGEgsfsN9cB9QAYsuHzDNE3nkvWGaDiDO2BKqYJB+
         0rxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729876996; x=1730481796;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SLI7/+S+crXUNgOywJ67SL6jHRzdYtHJtqzDx7qk0Yg=;
        b=WyG65VTdIbU7b4auGZT5gSNlz47Wy56xEmnzjU41uVgJUDGKurEWKAD9RLntexNlEp
         ADiBbJDD8ahQ7qJvDTo8NUyGmelhvhs/OLBERG8J1SwKZiFUOLTmFt8pawO1BqANMMpF
         CmpFv+TDL+7dNK6H6qXtGD5gSZY9iXu11SKI6AghuufkhX+5H7qh+QpayRke42sUtmr7
         bemig1cv7b/pFCM++fjbDoui4j2XPoarvtxquXWAWtHfvBGr5HLifSvqvmOOCLLX5m1v
         169rs88QVtx8RRZjloHSVHlAqqzbmWd/chLnML5AGoxMygb6CJpiJfJYvCvB0mScoF+u
         OyQw==
X-Forwarded-Encrypted: i=1; AJvYcCUl/d68BpDtWhrg8H8af0/R/thmFUTGSYbr/NxT2yEW9KctrQb4ALWmo6dGSEx+zgCt0R6a1Av6KacN5ktRGRJW@vger.kernel.org
X-Gm-Message-State: AOJu0YzuIC8oqo5hQy0IPhIDyxt2H76pV90A3nM3h80HgSgA1YwZoDnv
	3tctrATmdsbt43bOlyWdb/ZTgV5KBEblnI55k+p6sBkSwo5gOkkHuGOuSo+Uvgjy24tFkEXThd6
	AM48E5A==
X-Google-Smtp-Source: AGHT+IGZoiQWvQ9JAee83WAw23PvOLRlPb5zfwsVSV//zAik7AAW4oFxucqd6otaGBmC2uu89bqfF+/DXLE7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:5d42:c43e:5e08:3a85])
 (user=irogers job=sendgmr) by 2002:a81:a884:0:b0:6e2:371f:4aef with SMTP id
 00721157ae682-6e9d8a77e6amr2677b3.3.1729876996311; Fri, 25 Oct 2024 10:23:16
 -0700 (PDT)
Date: Fri, 25 Oct 2024 10:23:01 -0700
In-Reply-To: <20241025172303.77538-1-irogers@google.com>
Message-Id: <20241025172303.77538-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241025172303.77538-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v1 4/6] perf build: Add pylint build tests
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

If PYLINT=1 is passed to the build then run pylint over python code in
perf. Unlike shellcheck this isn't default on as there are currently
too many errors.

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
index 333afe29b1e2..6b5b420d794a 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -282,8 +282,13 @@ ifeq ($(MYPY),1)
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
index 4d7c38a2bf6c..5fe011cf897b 100644
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
index 3baa1f41502d..c33e2372579e 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -422,3 +422,15 @@ $(OUTPUT)%.mypy_log: %
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
2.47.0.163.g1226f6d8fa-goog

