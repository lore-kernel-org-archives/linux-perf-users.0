Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2561F1C3F2F
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Oct 2024 17:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729618273; cv=none; b=HKmsT4934cTL1K4vWCTbjEA3iBNrpknruCd2Yh/1towl6OtEL/TGtBUe9/ywFHbX6bPJatmc3p+JWxF494qcmmHRNB1pz4jGOkIUf4r37rQdeDSPHA9GnYnFWQ3+rL9ftWGQSjAixPJTp7ZMIDmthFh2DIIKcdaVist25QoZNK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729618273; c=relaxed/simple;
	bh=/crqTxCEFIJ8zM+Mn3jruBiNWQfecVziDkUeZ96I01M=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=JWoB4dWdQn8IWQPk0/ilgWxuqVs6TmbvbC2DpigQh7VnDMzNGJCGt9lKcoM2baGannqKPUUFM1WYIFfD7TSUOwwizfqFhB2WLEbYSbpfEeuq9WcRO08o6ZFokvPZPR6uTaXRGWopRzoqnOaBSgph1N1J1qWBeYiPcaQj5/De8+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X/xM0Zz2; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X/xM0Zz2"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e29135d1d0cso9381838276.1
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Oct 2024 10:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729618271; x=1730223071; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fhvpBUz7ScY2P9mICu9O6uJW+157JnJHgqfTK+JmiWc=;
        b=X/xM0Zz20LSfhjyoT1Mm5HLnhGBBsrMhAmY6xgCdSOjmmDRpuK4gTWQWmSr7frF1n4
         /Y4uOCnDW2riR+yqmcrM7Ali/48Zi2k6wyQf6wWePP0Xw93DnSxcDuP3qhWANc0bXMB3
         oCOY95Xv7ClUacw4Kw1CJiPe7yne8Nh70cG1fIjv/qTRpTCZNdHMb7LX2+Lu3Dt6lU2Z
         uohbBeNooOygcq1/zczIVe44uyCvhBFOONoCXuiidLaXZBzzCN2Ycw8iv7WBGfISxAuW
         FoamERyxX277pFchhVjDk5xgjF947dUlIbZtIERfMNDi7OPLTiall0AuS9FEhK/1Y4nA
         1/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729618271; x=1730223071;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fhvpBUz7ScY2P9mICu9O6uJW+157JnJHgqfTK+JmiWc=;
        b=j+uXlngLPNS6faCF0LuVXGWUJJipQbCe0eKNCE7M8BCj9c1P+PjYFSf6AHERaes5H5
         q9Ra+BKGgmyJc1U1atbK01szARAy24O4YKjpypXRTo22LyfUXei7+C90Oa3wKjeTNk/R
         T9nDewD4eBNCHT4QlirGlHmuoatpLTyhRj0Rvkp76MKahayhTGZm8gshquiBWd1Q8Neg
         HBgWywjq4vaIjfLy5HKKuZz8n8sDR5pW5N4ri8XShjvr2q0A0yrPM+4E/5elzGadrrHP
         Vb2ewHb0JbZe4ZzwOR7D0JUX7GfahxVBpxZR2Lq9/IaQcAn0lToCmS64Y9Ksr2SwOSfw
         GFGA==
X-Forwarded-Encrypted: i=1; AJvYcCULyNkh38Iw/lUu//5DD6ou+zG4W8+PnEDRZXJ2VlA/KcjBWbvj+FQj/FC8KVDlNwNmlzXSH3DWGRztKfR7fEMZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwtUd0znOJLc0qIoCzH3LKrZdyJlEX3kGH7Wo93V7YRdExiPy8B
	5LNEDaIWBDz4qvM+ajT7Wk3Y6gCepvrIvODfbMhu4EvEsS2HuWmLAn7CpsKpgwzV5OOno+jrYe5
	/zzRRgg==
X-Google-Smtp-Source: AGHT+IHDnq+abCllals/kqnWsGmCM/mFjJoZMc4Oom4dfZXS3a6TCKQxUeC1YZSC/YAiejk1FxZfEJUjmYXh
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:57ba:88e0:aaf6:282])
 (user=irogers job=sendgmr) by 2002:a25:d8c4:0:b0:e2b:d0e9:130f with SMTP id
 3f1490d57ef6-e2bd0e914admr8223276.0.1729618271277; Tue, 22 Oct 2024 10:31:11
 -0700 (PDT)
Date: Tue, 22 Oct 2024 10:30:07 -0700
In-Reply-To: <20241022173015.437550-1-irogers@google.com>
Message-Id: <20241022173015.437550-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241022173015.437550-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v3 09/16] perf script: Move script_fetch_insn to trace-event-scripting.c
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

Add native_arch as a parameter to script_fetch_insn rather than
relying on the builtin-script value that won't be initialized for the
dlfilter and python Context use cases. Assume both of those cases are
running natively. Switch the weak arch_fetch_insn to being guarded by
ifdefs as weak functions are outside of the C specification.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-script.c                      | 15 +--------------
 .../scripts/python/Perf-Trace-Util/Context.c     |  2 +-
 tools/perf/util/dlfilter.c                       |  3 ++-
 tools/perf/util/python.c                         |  6 ------
 tools/perf/util/trace-event-scripting.c          | 16 ++++++++++++++++
 tools/perf/util/trace-event.h                    |  2 +-
 6 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index b838470657d4..63a00dad02c6 100644
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
index ad62d8e5a368..543e78b17e5f 100644
--- a/tools/perf/util/trace-event-scripting.c
+++ b/tools/perf/util/trace-event-scripting.c
@@ -13,6 +13,7 @@
 #include <traceevent/event-parse.h>
 #endif
 
+#include "archinsn.h"
 #include "debug.h"
 #include "trace-event.h"
 #include "evsel.h"
@@ -269,3 +270,18 @@ void setup_perl_scripting(void)
 }
 #endif
 #endif
+
+#if !defined(__i386__) && !defined(__x86_64__)
+void arch_fetch_insn(struct perf_sample *sample __maybe_unused,
+		     struct thread *thread __maybe_unused,
+		     struct machine *machine __maybe_unused)
+{
+}
+#endif
+
+void script_fetch_insn(struct perf_sample *sample, struct thread *thread,
+		       struct machine *machine, bool native_arch)
+{
+	if (sample->insn_len == 0 && native_arch)
+		arch_fetch_insn(sample, thread, machine);
+}
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index 81fceaf297ba..e0bb42e6509e 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -120,7 +120,7 @@ struct scripting_ops *script_spec__lookup(const char *spec);
 int script_spec__for_each(int (*cb)(struct scripting_ops *ops, const char *spec));
 
 void script_fetch_insn(struct perf_sample *sample, struct thread *thread,
-		       struct machine *machine);
+		       struct machine *machine, bool native_arch);
 
 void setup_perl_scripting(void);
 void setup_python_scripting(void);
-- 
2.47.0.163.g1226f6d8fa-goog

