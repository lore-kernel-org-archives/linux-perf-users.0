Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EBB190486
	for <linux-perf-users@vger.kernel.org>; Sat,  9 Nov 2024 06:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731133140; cv=none; b=iOZj/lsqFMa6BHb7RIk+8lmYR1JCrV+20F7MKrmKBcOpn2jDC01MqL21pMQAOEgXcSzccLipU/pfJcKBabxL3aw5kQyyoaU4GsLU+wNB7hqnkLKYiKZIDHJgol2YRlp0hxUajrBJXvwQ5dbC9G06WHNUTdVJU3Nv/7isAUg5KCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731133140; c=relaxed/simple;
	bh=w8HaB/UZZ8fjRZSrgVSw7XPmtOqwKAnXaljOTleBeY8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=qGlPsww+xd0YvuIYkhjDJByGlDqI22m9H+U1dDkrFT8qrMQsnOvgQ+EtxjRS6AELQj1huFeHwxBc2SHp/ERzwjYNc0X4Kexv6Ff3wOVg8zvo9MLhe0NBS6vu+wtsMkjvChLeZ1h78iZzoPjUuxGjSCbyKvtnAko1y0NfTsQGp5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o+38z74n; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o+38z74n"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea8a238068so52952697b3.1
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Nov 2024 22:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731133138; x=1731737938; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K3lOW3KhmOwWh4gGD39AVpZawRDyngvbS6RFQf8pauU=;
        b=o+38z74n0989CAjkTnPNS+GwyGeML9zttEiy9R97nz2bLHxgnk6WKuCDuHPqb7yV+h
         /9rE1oS9KWR+QQtxfmqG0snk60TDH5rMuM0pvnatMPgWd6BWBbQVI7HsH0BTJOyP3ssG
         z2t+jnz6SHKROJs0CXEazqk9NJARu76zNBca8YZtBnYiX7n8+xKgUJ6T0QBjVSy5yz6c
         KdsRULWuCc9y74tcMn9wG8ReHvI2XYDl7MOBa09zV8gn0BOSkekwpcVC6qc49MAiLAcU
         z1GemscZtj0Ww1LdTZZxLmarQ3YB6gvT1NJMOA1hqsBFmEE2i6fYeHlcZI2f4ldfMCyp
         TU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731133138; x=1731737938;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K3lOW3KhmOwWh4gGD39AVpZawRDyngvbS6RFQf8pauU=;
        b=kMJxS40QxjjFxv2X90v0fKQrL5Xx1cvaU55Ts8MIfl3jZOU+i8OTn71ilgWkUQ/Xp5
         KE4dVlp5VOOJuVBlU9EwSgA1vLh/koEViNSE1q0a7VNwsVuECQgGTKj8zDGdTKl9/uTl
         0d96sq9fMG6qneIy06N1RMsRqlx+E+4ozc3hgVgGy53bDhFs5P8aqvbDahhWnRmJvBCc
         XvLnID4euimvLrHCpYlM2WxBZIODkM+UyEoX34R91SzI9xh4sTb84JA6RNtoYOFsiLYE
         F7frzPd0iffOLKMoEwJlcAG37DTJoN64IzP7152bTEbyWkFxtXfAOroPevRkWnWWgIQY
         PQBw==
X-Forwarded-Encrypted: i=1; AJvYcCXjEJeP/aH7BqR60OCwtjPbLwBv7vZmZiTijyKPmevkyGm3XhVTijI210t3+GzVZ5LdcOsREKVLCwi4Kron+Fzw@vger.kernel.org
X-Gm-Message-State: AOJu0YyovhJORg670hoGmYC2iK65ofqtkXpwZ64eRMME0XkJUbdrnbYa
	i0KKXZ8GOlzJTVgoUuI9vllMEotCQ8Ua67W8Vt05+XTRsoERmejZ6IE7UJcTTj56xvYkBHWkm1Z
	V0SPCfg==
X-Google-Smtp-Source: AGHT+IG9mZ2Uxz3PTmRVxavk0ppfRpa8BCEprXGc9sKj57y4LQOFJhg5BR8resUQ3qTazUHGf7DdZdHSbWxr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:acc2:d48f:a998:5915])
 (user=irogers job=sendgmr) by 2002:a05:6902:4d1:b0:e0e:4841:3a7e with SMTP id
 3f1490d57ef6-e337f8da4fdmr10466276.7.1731133138130; Fri, 08 Nov 2024 22:18:58
 -0800 (PST)
Date: Fri,  8 Nov 2024 22:18:03 -0800
In-Reply-To: <20241109061809.811922-1-irogers@google.com>
Message-Id: <20241109061809.811922-17-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241109061809.811922-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v6 16/22] perf bench: Remove reference to cmd_inject
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
2.47.0.277.g8800431eea-goog

