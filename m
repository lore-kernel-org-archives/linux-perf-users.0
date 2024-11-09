Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653BF150981
	for <linux-perf-users@vger.kernel.org>; Sat,  9 Nov 2024 06:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731133127; cv=none; b=ZrfDe9scxtoJrxM1MJCdBdTc8hP40J0FxucUNPSqCR8dHSaUwlT2yDtH1wOawjU784mkFm2IYvBIFPtLw3vrinJqLoKYjkKzuQjUZg2Uq7FHkKcXiZs10H6Lp+3Pr+whbguoc28mHMBCUBY1xB0Q03m07W2y4Vq+9qlMvySA5BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731133127; c=relaxed/simple;
	bh=DmhyKML5p5uyc9lw30xgAkik7ISJn6DGddaiJ31l+m4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=BYWuc5DRdE0VwWlTMa7Gqa+P34e7UjpAAkVDlbBdQjSTNTnlZuCiTwIHsSHO986EBP9Et2x5L/qt8dESJHz8vkZHatxn/xMQaUKYrGn12THD2TLyjz8B9ZPSiE/Txm3enwPrI2l2hzamsLQ9E/xeotluaQpzcKVNfkcQCd3hY9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bHCyNPeA; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bHCyNPeA"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea8a5e862eso35711817b3.0
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Nov 2024 22:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731133124; x=1731737924; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IOrkvPcvHjQedYd3c7yfUgCb4BbIK+zJ8VChcGJxjag=;
        b=bHCyNPeAWm2xGOvuTnrtTRm+1j6k0Dw5XaeNhHC9gSr0m+4C8tmgtGdWs/JmCF1yk8
         5i7F7p64tqTc3s/w7b0F54KcycWPk7fcUZAePcjTbxdM/5aAHbjRQkD4zlIuygiTfdx5
         iR7SP/SgOqtD3Aq6UJtLnAJP3UfsM3IsUJU3yo4FzxUXfwxc48gR3eJOidqg4cwNCcpr
         LZtxYqgo29KHwdEhWw2eezEU99UKutn6+aqUNhTvu30McCYxQb1qC2So2glg1lICNOiE
         x4gImp6f5WHlz0svnLdpDGGYRbIHzI7bPqVmIE30zmqCFGI7bbLDdypH4Kar7DpiLPb1
         n7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731133124; x=1731737924;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IOrkvPcvHjQedYd3c7yfUgCb4BbIK+zJ8VChcGJxjag=;
        b=AyB2z/eXn6BfyquIBG73V5Jy15vJu/80nJxq0xEf3rqKK8NPmMhDe+s1QW+cvMH/h2
         DsLY7Xi5KyAjctiqfc0RTXg0bMLkxQpiKfdQ3ss2jfYNWljswr90x14i+WOQZ01ioVYl
         +jY6ARU5apvBIgxxit52RAigCLIcRBgf04R0yVv4INqoIsZJM93cRm9UxF+Mfo3Gx3MS
         E31t8jSWGmdYod97cEx10oAHneDWZ5h8q4RobQLVdjOucr7t75A3fVheo+CIDM49Vs7R
         7Pn/KZ8lxPxqfnIx4/o+T9TBIHBh7Dlgu/gFZktoq9yhrqxr2iIxZ+F+Q/LvOhxNGokn
         ItSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtkyq6qS11KdFClr/2TaEq/AehGRWAbKlJ84JGT0ahg2Fm5qqEuaeROaHuECgzrEGwbpFDF3OrrYGDXmWRoTwy@vger.kernel.org
X-Gm-Message-State: AOJu0YwiK4oXuMSHWuhXvJx8h6FtmLl6+/cdKbRrSTETn28wGGyq0AsU
	dpjE78J+1Z9lG2wZOseUFaZ9c8Pth/cMEtI6QLGNNeWLNgRBH8Tf+u+RNrh9psIcn4IwRPnUweQ
	+eJaL9A==
X-Google-Smtp-Source: AGHT+IHac+QX1KxOp8UsOxuSd1Rqf23eoUA4r9Vn5FImDMoRE/tizKeMfe7trdWWCoUnRf6amqqkLOLu5pII
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:acc2:d48f:a998:5915])
 (user=irogers job=sendgmr) by 2002:a0d:c302:0:b0:6be:523:af53 with SMTP id
 00721157ae682-6eadc114281mr562767b3.3.1731133124450; Fri, 08 Nov 2024
 22:18:44 -0800 (PST)
Date: Fri,  8 Nov 2024 22:17:57 -0800
In-Reply-To: <20241109061809.811922-1-irogers@google.com>
Message-Id: <20241109061809.811922-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241109061809.811922-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v6 10/22] perf script: Move script_fetch_insn to trace-event-scripting.c
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
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Add native_arch as a parameter to script_fetch_insn rather than
relying on the builtin-script value that won't be initialized for the
dlfilter and python Context use cases. Assume both of those cases are
running natively.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c                       | 15 +--------------
 .../perf/scripts/python/Perf-Trace-Util/Context.c |  2 +-
 tools/perf/util/dlfilter.c                        |  3 ++-
 tools/perf/util/python.c                          |  6 ------
 tools/perf/util/trace-event-scripting.c           | 14 ++++++++++++++
 tools/perf/util/trace-event.h                     |  2 +-
 6 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 11c0ee8c1afc..22d78a9d8f27 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1586,19 +1586,6 @@ static int perf_sample__fprintf_callindent(struct perf_sample *sample,
 	return len + dlen;
 }
 
-__weak void arch_fetch_insn(struct perf_sample *sample __maybe_unused,
-			    struct thread *thread __maybe_unused,
-			    struct machine *machine __maybe_unused)
-{
-}
-
-void script_fetch_insn(struct perf_sample *sample, struct thread *thread,
-		       struct machine *machine)
-{
-	if (sample->insn_len == 0 && native_arch)
-		arch_fetch_insn(sample, thread, machine);
-}
-
 static int perf_sample__fprintf_insn(struct perf_sample *sample,
 				     struct evsel *evsel,
 				     struct perf_event_attr *attr,
@@ -1608,7 +1595,7 @@ static int perf_sample__fprintf_insn(struct perf_sample *sample,
 {
 	int printed = 0;
 
-	script_fetch_insn(sample, thread, machine);
+	script_fetch_insn(sample, thread, machine, native_arch);
 
 	if (PRINT_FIELD(INSNLEN))
 		printed += fprintf(fp, " ilen: %d", sample->insn_len);
diff --git a/tools/perf/scripts/python/Perf-Trace-Util/Context.c b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
index d742daaa5d5a..60dcfe56d4d9 100644
--- a/tools/perf/scripts/python/Perf-Trace-Util/Context.c
+++ b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
@@ -93,7 +93,7 @@ static PyObject *perf_sample_insn(PyObject *obj, PyObject *args)
 	if (c->sample->ip && !c->sample->insn_len && thread__maps(c->al->thread)) {
 		struct machine *machine =  maps__machine(thread__maps(c->al->thread));
 
-		script_fetch_insn(c->sample, c->al->thread, machine);
+		script_fetch_insn(c->sample, c->al->thread, machine, /*native_arch=*/true);
 	}
 	if (!c->sample->insn_len)
 		Py_RETURN_NONE; /* N.B. This is a return statement */
diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
index 7d180bdaedbc..ddacef881af2 100644
--- a/tools/perf/util/dlfilter.c
+++ b/tools/perf/util/dlfilter.c
@@ -234,7 +234,8 @@ static const __u8 *dlfilter__insn(void *ctx, __u32 *len)
 			struct machine *machine = maps__machine(thread__maps(al->thread));
 
 			if (machine)
-				script_fetch_insn(d->sample, al->thread, machine);
+				script_fetch_insn(d->sample, al->thread, machine,
+						  /*native_arch=*/true);
 		}
 	}
 
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 3d938fe2de6a..22edadd64e5f 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1317,12 +1317,6 @@ struct kwork_work *perf_kwork_add_work(struct perf_kwork *kwork __maybe_unused,
 	return NULL;
 }
 
-void script_fetch_insn(struct perf_sample *sample __maybe_unused,
-		struct thread *thread __maybe_unused,
-		struct machine *machine __maybe_unused)
-{
-}
-
 int perf_sample__sprintf_flags(u32 flags __maybe_unused, char *str __maybe_unused,
 			size_t sz __maybe_unused)
 {
diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trace-event-scripting.c
index ad62d8e5a368..beac456260ae 100644
--- a/tools/perf/util/trace-event-scripting.c
+++ b/tools/perf/util/trace-event-scripting.c
@@ -13,6 +13,7 @@
 #include <traceevent/event-parse.h>
 #endif
 
+#include "archinsn.h"
 #include "debug.h"
 #include "trace-event.h"
 #include "evsel.h"
@@ -269,3 +270,16 @@ void setup_perl_scripting(void)
 }
 #endif
 #endif
+
+__weak void arch_fetch_insn(struct perf_sample *sample __maybe_unused,
+		     struct thread *thread __maybe_unused,
+		     struct machine *machine __maybe_unused)
+{
+}
+
+void script_fetch_insn(struct perf_sample *sample, struct thread *thread,
+		       struct machine *machine, bool native_arch)
+{
+	if (sample->insn_len == 0 && native_arch)
+		arch_fetch_insn(sample, thread, machine);
+}
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index 0520dd269374..0c5becc822f9 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -117,7 +117,7 @@ struct scripting_ops *script_spec__lookup(const char *spec);
 int script_spec__for_each(int (*cb)(struct scripting_ops *ops, const char *spec));
 
 void script_fetch_insn(struct perf_sample *sample, struct thread *thread,
-		       struct machine *machine);
+		       struct machine *machine, bool native_arch);
 
 void setup_perl_scripting(void);
 void setup_python_scripting(void);
-- 
2.47.0.277.g8800431eea-goog

