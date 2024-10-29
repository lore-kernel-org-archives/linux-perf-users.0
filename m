Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F9E20CCC9
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Oct 2024 22:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730241910; cv=none; b=srgF4QwNg+DAtxyyaADkRBqpM3Qf+2fl+xfoksW9zWGDXfe4fvKkpWOtVHoNyHjQp8A2cRwjC9fGeTTOk0Wtp+DhxERiQ3OnVhdQdXJcHLJc0uqMaBmbreMKNrVrDqSBqqmYQPVmPp1QvThrYTFoyubL/VrWKHxMwMAnI99ZtFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730241910; c=relaxed/simple;
	bh=wvbasbr/bHT6byIIBcUUP6y+LhSLf7VNj3pt+3TFKi0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ZRywEIV41hjvA++tRTslKVag0M03sPpWJRCcaEAKiU/v9AQvBBumNlc9t5rZzxSj7/nmkIU6CrgrC8rzCJMvBzq2sDVHChlJ0CwDloi5Kri6yag+qfbfIkmHUjkcwiMdXPHX5U3VqRcwsTwpvvCRLWFstydael9Vvsq+x70YVBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4mnQLxbQ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4mnQLxbQ"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e376aa4586so111872307b3.1
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Oct 2024 15:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730241907; x=1730846707; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R2ba9KAPKd1ye/yPm45C2inPyTurG9rFVVaZ7EYtd/Q=;
        b=4mnQLxbQZbhxhBKiC24HNvUNtSz2MVdvmR3TpuUnXEfdT1xzdnxJQrqS0gNJOfJpC2
         Jg9oxULsxpXMgGJIpJsTDWD49WynXlUAOH1yodpRw8GaCt9flB0qbomdYYUrMbYv6Wmo
         mSzmMOKFknqK7cRlJCDqu+mgvEHJCSa33qGYJOoQKfmWTOOkASHcjVXBwjaDeD83ixyJ
         6bwQ1fFPqtl3voPgaRKgFOZ2xA4CxBCIpg+Xfi5g6BpzKGeaObFfJiVmWzAGwG1PXLI7
         trWnK6rFhuQQa1iVTEHBYboYxTiQUE2fHZSOz9mYrTq/EMNTZrTx7HGv43NAFBklg60d
         RL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730241907; x=1730846707;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R2ba9KAPKd1ye/yPm45C2inPyTurG9rFVVaZ7EYtd/Q=;
        b=lE0tYgg3dRQqFKxiwp1iYw6sCcv+tCh5lBzkEXR9cTreznbwo021EW42R5tVI0mzJG
         UUjhMbfjouVugcS5veE2g0dvgzbzGF4lfGNiaTp4oO0m2kGnPsyQltoxg5H0MrIsVDB8
         zHyWy8YecSgLNH0CRVK1CFwxfAjWFKNbTiaEnsH1kwSPw8Nd+aIqPE0g9gEmHhWslpxa
         Rdf34w4FEsNucPIV4+6pOzdUcZpfMWuutJdjYGgqZuJNQf1Qs2H4WDkC1Bo3S1r6hoJR
         j0bLHRHL1G43NVsZQe1nCivE+tTulbHh7aueNDcisGYBzXtfiywmzTwxaW/yBTnMN7Bm
         P+yw==
X-Forwarded-Encrypted: i=1; AJvYcCViXYCYTLRbWcARjShwFDwkzHFXTV6wklaF0Hd9T2oKByHAIyl7DDtYPDq+BWPych9YcUkKq5dWKpup2jBYXCte@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Mtvr9+B1YgtefBhFgXeecokt78Ch9GjULsBfbdDlmM2VioiA
	ozNI6yB9njDeAWBZkrELb65XZ16nCJg4+/q1s65M4H9tcLNIOmc/NIC9KRwHuAXr3VJBl+4MJxi
	DheCQMA==
X-Google-Smtp-Source: AGHT+IHMg4oEBPGAdsa5I6NDoxgxKClXhHgelcHadpQwzimB+n9qtTEd1pVdcb9I7LFH7agKESsocE1qb8cx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8991:d3fd:38a7:c282])
 (user=irogers job=sendgmr) by 2002:a05:690c:3381:b0:648:fc8a:cd23 with SMTP
 id 00721157ae682-6ea3b88cefbmr748647b3.2.1730241907384; Tue, 29 Oct 2024
 15:45:07 -0700 (PDT)
Date: Tue, 29 Oct 2024 15:44:25 -0700
In-Reply-To: <20241029224431.167623-1-irogers@google.com>
Message-Id: <20241029224431.167623-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241029224431.167623-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v4 13/19] perf bench: Remove reference to cmd_inject
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
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
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
index b4dee7c20ed1..ef1b39b5042d 100644
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
index 91fd444615cd..c52da509ae58 100644
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
2.47.0.163.g1226f6d8fa-goog

