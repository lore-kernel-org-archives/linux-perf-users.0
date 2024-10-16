Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE66519340E
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 04:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729052707; cv=none; b=dtQq9nFiLr760L5GRYczgVIQvgs3Qwqr8sTa3vawuUVUhe4P1kK1+EEh0m3aBHZg+h8+5dkZ+RJND4cz844SlPrYG8Rhd0dJjUcD2ps7NqcJFM130P1c1xZ3SBs90gzFUSXUehE1h6am4U0Qz5PYX2bvVcGRo1EmmmSKI6bsEm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729052707; c=relaxed/simple;
	bh=Lxd44HNIIUMBFIsdkVzpn2nUHSToU/AOD0h6f9vtF1I=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ROm3zDCPLIKdOD5Y4qDb9DeGGEqaTsJjOYrHfLbIgI3pdqvUz9Edj4Rlsu+gq5kn5nmSCytAnLKfCYmjKrFoiBnb4E/n7ZquOLXiJ1Y8uHG2rSuJWc2cJV0AIK60mBqThLBdQ6HOUvMIc/jtq/pTELj7dDkSe30ELBcFiVKhIeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fOb3SRGh; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fOb3SRGh"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e28fea2adb6so7410904276.3
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Oct 2024 21:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729052705; x=1729657505; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wEJZm+zO7NJ5VjFkt41/KKWQvQrLbI4UzfjSvW39ruY=;
        b=fOb3SRGhuDmWpADCTJL9bQtzjLtJ9wlFhmg6g4XBTDPj5Xk+grP0ZpaaXegrGNe/kY
         kpMvwzCqfnry4DgFsMh3fKKrIlJxReMJeqdW/YTUpWmw7M/bwaMvX29OhgjzT9W4RGk0
         +wYLqSQ21kyF7w6uMn543kFGNiERCZSfCgkUcFFavUX8BxTw3RnKXqskHV1/JdWiy1hU
         KMIFK4tvpiGL1X6nbbpcNf4Cfaylzvaek79qBse8S2fE2Vzfv6gSbquIxOzO4kGJpzGu
         IUs+MeJ0DAq5qmn1ZRTfzUGQLnWySjG9XtWf2GSor1kAt1XEFoD87Ifr00VbW3l+Jh+p
         jhKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729052705; x=1729657505;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wEJZm+zO7NJ5VjFkt41/KKWQvQrLbI4UzfjSvW39ruY=;
        b=PaMbXnb/KWY05gSRy/ZFV4rgXs+gyJrO5BqzoDNrPHGgwo3EkdTY5r87zOfCTke2fl
         MLmLPl1S1+szZK0saQl4Xf9Qx/l8lCmOXZkzugnKFvSk5DUbFLyKcl9Ex6kpxlsNDUhH
         ACUwGybB8XQTaOCSUTPSySlSrdsD80wC/XuMWdpAoRfeaWESJor5RppNtKHfrABbm8ik
         YULY+Nv8woy19VUHnGEXD/DAnqvOtuGard95bdfJ1xC5D0xv7Pb5Lqv7YelCvq1jne67
         WKJK37cuL2oXdxWJh/XiHqG9+bqI0uDJq7aUpXxHaV9ywIFw4AvBUXcrYiRk1ypgw84o
         0whg==
X-Forwarded-Encrypted: i=1; AJvYcCURIZGTkwnNl/WpZeZ8N/VOp6xnqcWB/xmD7wmZ2NzFZ8sNaLtTcJwbdIUNSgwpdVBFqWs2KrRgbpKbdA0rhepk@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjxg5kDK6oWpqGlE4YWXHmbwGCMpvS9gfUyvhuZYytSiBhw7bB
	+JKJzopPLTUR/N5o8DTvI8G3DKwkLeJtM6NDbSEIMOFdGyLNA+po9sRP4qYaxwU5GHWPi5uUHFS
	cYc3qTQ==
X-Google-Smtp-Source: AGHT+IEN9tRbNqWXI3cWGhRxH41kFQoOZdjSIJ+Slt9AQ5secKvbfHsMFkGkNd2I3hJ4+wwqJgXxiRybI3G3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a25:e910:0:b0:e1f:eaf1:2254 with SMTP id
 3f1490d57ef6-e2978573afemr2136276.8.1729052704783; Tue, 15 Oct 2024 21:25:04
 -0700 (PDT)
Date: Tue, 15 Oct 2024 21:24:12 -0700
In-Reply-To: <20241016042415.7552-1-irogers@google.com>
Message-Id: <20241016042415.7552-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241016042415.7552-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 13/16] perf bench: Remove reference to cmd_inject
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
index 105f734b6820..e54c6953cf02 100644
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
2.47.0.rc1.288.g06298d1525-goog

