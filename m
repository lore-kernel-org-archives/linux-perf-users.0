Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E7A1C7B70
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Oct 2024 17:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729618282; cv=none; b=tVwgpDiiPBiC3XjOTulRJ+kPKqlRRiBG431Eqs/gbLqB/Zjmt22vxLpt2Owu5GtoL7IR1e6KWQRiskg0kA0+J5hIFppRIvH5FVh3MerQgJ3ZwPGgV3GFnwya0K7pndDRM+rulBAbt3GIk5ZWly2SX0eJug33pdsjLg2ryQbur4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729618282; c=relaxed/simple;
	bh=h8Ou5g5DrhLFfv50C/dN4S1HrMs3trrQOcpAWXFdCag=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=u20zyQn6peL1detf+56ttNa2Z9rnWVUzFQKj47oApf1697EeKBMAbPpSfG6n2B2Y9SHKrpQrLb7sTGcYF+VdnzWy5juslkLu58LlWLaC4sX/jJC3VGytfLmDIsjJ6Xfb+IWAHUQntE1LRiumvVqSxOFQNO37lQp6j8ERygbAYhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4CldvtaT; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4CldvtaT"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e38fabff35so109355517b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Oct 2024 10:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729618280; x=1730223080; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kd9t++03UqxW+nAg8foHREOoohXM4WxHxsh35bvMJTw=;
        b=4CldvtaT3VL3NM+J6R4h8a5SRnsDFWp5rrpbc7Bes+WqT5+DTJkVpjx+gvdrMAByrm
         xyguf+P/CurYftM8u0UW1vxioowhsvxVk4v/Ar1ASKYTDeZPzLJP6PUU/XLvfZlFKV97
         ikvpv58k7ERNqXgtIwEwj1vpikIXJL0LdKl1hhcGWUQw/yV+hlqjQkBjv0IW8F0ogykp
         aUBGS8QcZARnoUaXn+wyvUZCOTnAqNmtFhkTLKv7q9HR5l8lHjU38sFaWMR3RmRKKLRb
         CYEy2QOYA/6OfBNBqjMgCvU2HYiGcbWlz5px9HaOUQgZBdiS5dOJwMtyv/0PjlpRQiNi
         /HXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729618280; x=1730223080;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kd9t++03UqxW+nAg8foHREOoohXM4WxHxsh35bvMJTw=;
        b=bta5ZpXdAVcvFBbITuyaneufV4WhHNdBn4FI+sZB41Vsql+YsEp27PENorWNo02sUN
         jORQnpv/7lRTujtvGNPUhXilbQsAqbvyKzF2Wp97gBvdIHg5MGQtAL3z+XMlgOTFcI2m
         gD4EClVVbANYjJJf7FS75JPr8HRKqEChDn8ACDlwnwjbUTnVRpegeEIpYmIBF+ki+2wq
         4A75CLZFPYz2s3Q5ZkwnSzlfagvMpv65xzEFxplJapPXDKTT9OCl6LwVvt26z7Jru05Q
         Rpx5D0MC3LqV31oBpiT4IpgqLHc+qD4GVAPU+yHhNFkp3ilJLga78YH3Yu0h5JggHfxe
         qEMA==
X-Forwarded-Encrypted: i=1; AJvYcCUE7Lbe4S2zLr/wMWsIOmX4gCB98yGefodfFMr5ZsCdyTtJmpoxibX98UsFj6V4nM8o1yhzN7ERcOs0BP1tDrjK@vger.kernel.org
X-Gm-Message-State: AOJu0YykI5yux37W3pX+xTfR1EpjaaYjEXJj0Lk7qB1ASoTXPfcjEmPq
	CXPCJZaOxQ0uLDFghuq16HMwjSrji9RnEeVQov65R7zZ64M4UIEi2AXab7hRttJBEj76nrS6FI+
	B1H7fwQ==
X-Google-Smtp-Source: AGHT+IEPVjkVUrVyWr92okZd44uTJWhsJ7++u4e+qUxWtLRQgdL/39dFblyN0funt1fdnaaLPWEpJa2VplC3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:57ba:88e0:aaf6:282])
 (user=irogers job=sendgmr) by 2002:a05:690c:6902:b0:6db:c6eb:bae9 with SMTP
 id 00721157ae682-6e5bfb868e1mr4151097b3.2.1729618280324; Tue, 22 Oct 2024
 10:31:20 -0700 (PDT)
Date: Tue, 22 Oct 2024 10:30:11 -0700
In-Reply-To: <20241022173015.437550-1-irogers@google.com>
Message-Id: <20241022173015.437550-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241022173015.437550-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v3 13/16] perf bench: Remove reference to cmd_inject
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
2.47.0.163.g1226f6d8fa-goog

