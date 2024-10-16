Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB01E18CC0C
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 04:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729052698; cv=none; b=TpbfDDsGniBv5eQ9BESfHasmE/ZdLvR6L7KzWLjKsKSpFZc+goqSGJ4vNTe0btFRWyhlfkaVJItSkicQg5/o61z3dkviX0GXF+9924Lgu9UH+glmdYsJptKGNxnLSMBTZWREh1fTqs3kBstvRL9xZyvoORHV0+tPKSKsHzPwF/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729052698; c=relaxed/simple;
	bh=cZb5xvuzqqa8/zADFxb6PqvGhOFZ4T95f/Rcci8bRQI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=RbKK/LMesvqIXYlsPsnJNbmGLabNThfriOI1rLdh7Rgkkdeo5FzVN4FXNLIb1sFJf45rm+CL/5z2t9gWaGJUexePaukBg097J0kuW9XGSFBpUS4KOeTr1oBsBbZEVjTPtbNRfUf+sl/6TwxVp6j2ixst7Hy40Jp/xFlpxh85Ps4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k21fa+Qr; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k21fa+Qr"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e293b3e014aso4976486276.3
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Oct 2024 21:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729052696; x=1729657496; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aUanJd9R6GPljwzcW3pIhRSAGsTkrn8IEGI+GvcCVuc=;
        b=k21fa+QroCXwTxf+J0PR1Z1Z2A9elPgdUb894ffPo+gd8tyeq+ZiUY0lTl9oiBKdxJ
         ElaWMymQZdKrtZFzgMqOQ/2v3B4SC7WbXG0z17uxuSuKQffh+I7yd26zg5qYbMeBmIju
         KH9G5mRRT1CWspjsaL6DB5cBewQH3rP18c82JvSZ8Nw7TwiExsKmoEnruixxwhhcL/7d
         KCnie3h4akIUgVkzZaETGMOEQaT2xEK9X2s0J54IsXNvQ5R+HI6G4bPC06644awfVfvg
         ERVrWqMIQ4Jn1A4qvgYutyy9w4fxvrQeHUh3UiFkIBORN6VtbH/khlZCvpTvQgea4kIb
         NTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729052696; x=1729657496;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aUanJd9R6GPljwzcW3pIhRSAGsTkrn8IEGI+GvcCVuc=;
        b=VfYCvX9vhZiNBgUGRP53wK8W8nVt9PdZ3uRcLJW46JsTCRj3UlgxNNHIlgeZsm5cvU
         1vk7t/vvXwMroOvplBtuWnNUZSKMh4lietndVgwBS04YUkdPsCRBBjJUsjzoEkqbB6fi
         1PQLdTr2M3NmljEj0lW2fystJyjf+bVe3h4EnoF3yKN3yfM0hBF03xYv+lxFJnRKA+uk
         jCS3m8E6vLCUM5S/SP2RlkAuRgBa8aBE52bpLcvfB6qhswoGouAi6BveRMQY25UB4r2K
         IOoeoSg1hpwJ34I3V64x+hW1z+Xkz+oDEHZTJKOzodl83iZl2yhlXKZNmBewPiPURHCN
         2riQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTnA/6hwASslgcwjYUOnK0DfgI6ELPL87G1jKnHKvMrU6qSvtxToy4SQHRII70W971MkceQST1Rbjx0rffVQvO@vger.kernel.org
X-Gm-Message-State: AOJu0YyPNNpx6R8ePeeca3AaStSUPpMPbKl0oRdpPCu1qxdY2MaVthO4
	8TSRrMOHS4w9r54Kibmtk7iTdFjH//UN7ZTlnQ6lo5bYg1aSSiCSg0+sLaM71mkylEsmzyqEkoW
	Wk79bmQ==
X-Google-Smtp-Source: AGHT+IE92oRUPfuRbjJX6fYqcZzWlqLUcLAT0RFlIRttpeNClwYVe3iHPPYhGgfCJxJOyvIG3xK8nBaMc8sV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a25:ad64:0:b0:e16:68fb:f261 with SMTP id
 3f1490d57ef6-e297830baadmr1307276.5.1729052695722; Tue, 15 Oct 2024 21:24:55
 -0700 (PDT)
Date: Tue, 15 Oct 2024 21:24:08 -0700
In-Reply-To: <20241016042415.7552-1-irogers@google.com>
Message-Id: <20241016042415.7552-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241016042415.7552-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 09/16] perf script: Move script_fetch_insn to trace-event-scripting.c
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
2.47.0.rc1.288.g06298d1525-goog

