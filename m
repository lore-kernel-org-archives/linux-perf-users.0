Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05D01547EF
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Nov 2024 01:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731979094; cv=none; b=lH8m2Tr84djPdeTql6Xv0vW4WEwML8mxIL4fJQZF57p4qo/MmDrZ/7bQpHWndwiUVUhOVQ/XCMCPQABtADVQ2ydGOvqOK9LidYjH7xG5iV4C6UGjZMmWZt8JsNq1QHi1tkYX/CuLjkAxRhXTbZx3sTu/EV+EyYFrZvpgKZ7CEHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731979094; c=relaxed/simple;
	bh=TbR4BOS7mQPgSaQH1tcutfX+y86KQP6eWwApMmstiek=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=WoBHHeFGpnwomeaAiZri/EWhS64V0Vzn/lH82SVA7kiUp+2ge8InjqQBcS/j6tnskgcT+QeUJk66blqCeEk7mVVFIgchqr/fCVdnQ+AkXeXznyid+4BOkMnWV8CaDHuxkf7ingGHnISM27wM1sG3raYVT+smdU9yeDFNEySpXpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qpaKDP7w; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qpaKDP7w"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e389ef22432so2554615276.0
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Nov 2024 17:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731979092; x=1732583892; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wrXtQg5+ba7sDCX0vVayflm8VxueJWYimdy8axJrFZ8=;
        b=qpaKDP7w4gMaer+TNpEapxNciCXSt/vCaqUK7nXn4ZioLbdg+6sqsjPRr6nE5vzNCE
         7RcgHPnKbdP1p1lmGlCw8k/sHQrN+Cl+gGw3qZWtEepdX4fA7rccs4XZ9yNq/tJdJ6uk
         yTsYYPd2oh9c+tG7GFLdKNHl7WEzN0eDuMjQ+XSLTUjYkH5rMLSyewX5U/VNTmDdo4Ko
         gDI2oYxoxAxlFkrb9s/UYH5v7bEzpKc2LqV4bfv8UHvxGYz01Xd5eyDB3SnNsEy4rMRS
         64RT+wnlRyil+TQOPf0Z/mnY23w94O90AsyzWFy8dV0vpdvwPX/l1G7wyTYJK73ZECli
         L9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731979092; x=1732583892;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wrXtQg5+ba7sDCX0vVayflm8VxueJWYimdy8axJrFZ8=;
        b=u2rWBAGnbjEkB7ggtS6nOXr9kCrXgwbT1iHuFOugTS+10vqPEakGElKZ503p3yVYWp
         EPbV7FGbsLs+vPRatTQ7G3rGsWcNkLMyLAV/nBm/rZPaIuuXlI2hm87HzJ9K9TpoOR8k
         hmkM/hnIYQGKO9PKHdWg80QNPjQAQqnWjcRplxDHstti+dmq+NOp4eUx9MqyW6yFJK/p
         vOAX2SwLwdPQXmN39KQNiyRGwAG7zsrwdy9KGRNgFSisqJs/ukxffzpl7mDTEqeu0y/p
         +Hy9siO0RlAFqI9LbjxmOg4NDw6yx84vocq/EMEZuU/l6nuX5nrfQYT9Yks43hcEPMpz
         Igtg==
X-Forwarded-Encrypted: i=1; AJvYcCXJXWqeb37DVapJN91eTEbmmpheu+nBobWEHKuexc8nu1p3CLeeW+yDDlfKdTaz8t3R72nmGF1YZHE8sd4whVwt@vger.kernel.org
X-Gm-Message-State: AOJu0YyaW5X5xVZu8LTF/OZlVs7BEO3i81BXX9vGSr16gYWaWVVZR4x8
	mO2wkR+R+k/K4Pw0Lj8eg3XCVruKSJKdTJeupPS+SJRy79WNXU2YEdloizhnarNSjUNVB2FwViX
	hrVroEw==
X-Google-Smtp-Source: AGHT+IEyRYVBQBZBqB+W3paPg6O1q0NERXZbtpznVI+9FR9vI2hLxhnsONIVMlmtNtw/uYgBLJjH//9eTJUQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:22a4:ded5:5c37:fcc7])
 (user=irogers job=sendgmr) by 2002:a25:8392:0:b0:e38:1293:ee43 with SMTP id
 3f1490d57ef6-e3825d2823amr11237276.1.1731979091806; Mon, 18 Nov 2024 17:18:11
 -0800 (PST)
Date: Mon, 18 Nov 2024 17:16:38 -0800
In-Reply-To: <20241119011644.971342-1-irogers@google.com>
Message-Id: <20241119011644.971342-17-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241119011644.971342-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v7 16/22] perf bench: Remove reference to cmd_inject
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Avoid `perf bench internals inject-build-id` referencing the
cmd_inject sub-command that requires perf-bench to backward reference
internals of builtins. Replace the reference to cmd_inject with a call
to main. To avoid python.c needing to link with something providing
main, drop the libperf-bench library from the python shared object.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf          |  7 +++++--
 tools/perf/bench/inject-buildid.c | 13 +++++++------
 tools/perf/util/python.c          |  6 ------
 3 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index d74241a15131..cbcb698cea38 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -487,6 +487,9 @@ endif
 EXTLIBS := $(call filter-out,$(EXCLUDE_EXTLIBS),$(EXTLIBS))
 LIBS = -Wl,--whole-archive $(PERFLIBS) $(EXTRA_PERFLIBS) -Wl,--no-whole-archive -Wl,--start-group $(EXTLIBS) -Wl,--end-group
 
+PERFLIBS_PY := $(call filter-out,$(LIBPERF_BENCH),$(PERFLIBS))
+LIBS_PY = -Wl,--whole-archive $(PERFLIBS_PY) $(EXTRA_PERFLIBS) -Wl,--no-whole-archive -Wl,--start-group $(EXTLIBS) -Wl,--end-group
+
 export INSTALL SHELL_PATH
 
 ### Build rules
@@ -735,9 +738,9 @@ all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS)
 # Create python binding output directory if not already present
 $(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)python')
 
-$(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): util/python.c util/setup.py $(PERFLIBS)
+$(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): util/python.c util/setup.py $(PERFLIBS_PY)
 	$(QUIET_GEN)LDSHARED="$(CC) -pthread -shared" \
-        CFLAGS='$(CFLAGS)' LDFLAGS='$(LDFLAGS) $(LIBS)' \
+        CFLAGS='$(CFLAGS)' LDFLAGS='$(LDFLAGS) $(LIBS_PY)' \
 	  $(PYTHON_WORD) util/setup.py \
 	  --quiet build_ext; \
 	cp $(PYTHON_EXTBUILD_LIB)perf*.so $(OUTPUT)python/
diff --git a/tools/perf/bench/inject-buildid.c b/tools/perf/bench/inject-buildid.c
index a759eb2328be..f55c07e4be94 100644
--- a/tools/perf/bench/inject-buildid.c
+++ b/tools/perf/bench/inject-buildid.c
@@ -52,7 +52,7 @@ struct bench_dso {
 static int nr_dsos;
 static struct bench_dso *dsos;
 
-extern int cmd_inject(int argc, const char *argv[]);
+extern int main(int argc, const char **argv);
 
 static const struct option options[] = {
 	OPT_UINTEGER('i', "iterations", &iterations,
@@ -294,7 +294,7 @@ static int setup_injection(struct bench_data *data, bool build_id_all)
 
 	if (data->pid == 0) {
 		const char **inject_argv;
-		int inject_argc = 2;
+		int inject_argc = 3;
 
 		close(data->input_pipe[1]);
 		close(data->output_pipe[0]);
@@ -318,15 +318,16 @@ static int setup_injection(struct bench_data *data, bool build_id_all)
 		if (inject_argv == NULL)
 			exit(1);
 
-		inject_argv[0] = strdup("inject");
-		inject_argv[1] = strdup("-b");
+		inject_argv[0] = strdup("perf");
+		inject_argv[1] = strdup("inject");
+		inject_argv[2] = strdup("-b");
 		if (build_id_all)
-			inject_argv[2] = strdup("--buildid-all");
+			inject_argv[3] = strdup("--buildid-all");
 
 		/* signal that we're ready to go */
 		close(ready_pipe[1]);
 
-		cmd_inject(inject_argc, inject_argv);
+		main(inject_argc, inject_argv);
 
 		exit(0);
 	}
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 6851f9b07e04..5e6db4b143a1 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -19,7 +19,6 @@
 #include "util/kwork.h"
 #include "util/sample.h"
 #include <internal/lib.h>
-#include "../builtin.h"
 
 #define _PyUnicode_FromString(arg) \
   PyUnicode_FromString(arg)
@@ -1309,8 +1308,3 @@ struct kwork_work *perf_kwork_add_work(struct perf_kwork *kwork __maybe_unused,
 {
 	return NULL;
 }
-
-int cmd_inject(int argc __maybe_unused, const char *argv[] __maybe_unused)
-{
-	return -1;
-}
-- 
2.47.0.338.g60cca15819-goog

