Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DEC4C0413
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 22:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781217922; cv=none; b=a2YTBChbveYEzh6cnYRWgNcKY1oUp6SK25SgYxLyC+yFarKuPBbWnWD2k1ZZVA5D8+7vkaysQslJD3VaxdDpxKRG4N1SyCBo3JUUOrV7ozXIH8XA6esUHsElOeJ2+nikTCzoKPIglLBJm0bgN9bBfmfr+yV2ubc24alAOqHcaBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781217922; c=relaxed/simple;
	bh=rOjHSepdzZ9RrkLyC/EoNXPb3BiB/Kt9Zt44eaRQUc0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rPYc2NLiUd4/BOzGQyRFQ4tFedc4+kmX8IKe1HrGptgMdHUo8MJcM4IAXEXDNzolHCmasHKcVIRTyXrLc89io5x2LLBFOeU+Rw8CbbYwpHoJkLPWkw0tUgKXckT3sGifvaYg3ZLtKse6mbG5vfvEWg1FKG+qeBiXVpqg1ByPuwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LDKKaOqQ; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LDKKaOqQ"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1383678095cso1494203c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 15:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781217916; x=1781822716; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hpuL3bDGJcG38Fgexrkp0SY6TvqwKOiZHkLJYAhjh3Q=;
        b=LDKKaOqQDi0Q4WSOjfTqkdzc9pb+zKeD8zGlUQVorjLVBAnW2y2UkBSTbznYoVM6DX
         fiO8hZQVgtJ4mum8XD6uX8BW8GmNX1djDvfCzHNFPE05omUezg7e3e2I+oasfTbrqMe/
         icC6MTOm0D3T856Zw4Oe6WbceexMG4UHFsFYScq7TePDbTSmGZsLBuvAV8nDi/rrcBKV
         WqnzfNTvbx7CAPo0g1flj6tITvJfWiFIhkolDDeiFhUwStoRvUVVtNqWfHF8/OS2Bvz9
         nGRV2fc3+osi1Ra4pFGKcBnh9wqyWSr4/mUnPrBhp+tjYcg8nqQp7kvue54Y0nC0/DNz
         Cjwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781217916; x=1781822716;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hpuL3bDGJcG38Fgexrkp0SY6TvqwKOiZHkLJYAhjh3Q=;
        b=r2LN/6uqik/bUOBrH/i5WQmTbb9qOaFqktf3u3v+BPHusynxMMzhZl7Y/M42Tmj8wN
         B/T0ddmID4sVWiwgSExYFEG0MeqWpo77Ww9FCr4jA/YYzNJH88PvVSCkb1dmyYY8vdCn
         OET94flgfrxcc7h7RV/DIyXk4l8gns3Gw34+iLx1/PGPYZxMtwom545dZaJM0r2+dNmX
         5ZGcyPVeE4hh3qpYiELBO01C0V+1wsmXmFyOFbI8fO3yTosfxfNLexybTNDBFb0pQqDK
         AoXJWvWGYYF/efimlMNO2I3L81IeN9tnXUkPTunBVduRUKcwP7Dppc2CIbWQ4hRg5CFx
         GRWA==
X-Forwarded-Encrypted: i=1; AFNElJ9Uo28oShRSzhkfCP3FK4kne2HoNXStVMlrd6R4Sg+HuGaJkHCJGxlLx2+dyVTQ2ywubP2ytm5ZWHwm5sqRYufj@vger.kernel.org
X-Gm-Message-State: AOJu0YzU8TohkC00jvnc8Ckn82bOuGGcg23x1dAhOOK4I0RDTmXHOcwl
	r2VoE8wpKfQ/sbhRFOh2pOUsd4XiT6Sdrm3nl5uWejZVO+xKBT1GMngMZhghT9dOIAEFg7eyD4P
	7sAOxunQPWA==
X-Received: from dlbti13.prod.google.com ([2002:a05:7022:1b0d:b0:135:9081:542c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:43a9:b0:137:99bd:d156
 with SMTP id a92af1059eb24-1384baef0d3mr167398c88.7.1781217915483; Thu, 11
 Jun 2026 15:45:15 -0700 (PDT)
Date: Thu, 11 Jun 2026 15:44:44 -0700
In-Reply-To: <20260611224455.201994-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260611171756.4008769-1-irogers@google.com> <20260611224455.201994-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260611224455.201994-9-irogers@google.com>
Subject: [PATCH v13 08/19] perf python: Use evsel in sample in pyrf_event
From: Ian Rogers <irogers@google.com>
To: irogers@google.com
Cc: acme@kernel.org, adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Avoid a duplicated evsel by using the one in sample. Add
evsel__get/put to the evsel in perf_sample.

Signed-off-by: Ian Rogers <irogers@google.com>

---
v12:
 - Removed an extra `evsel__get` in `evsel__parse_sample` to fix a reference leak on error paths.
---
 tools/perf/builtin-inject.c       |  5 ++++-
 tools/perf/builtin-trace.c        |  5 ++++-
 tools/perf/util/evsel.c           |  2 +-
 tools/perf/util/intel-pt.c        |  2 +-
 tools/perf/util/python.c          | 10 +++-------
 tools/perf/util/s390-sample-raw.c |  1 +
 tools/perf/util/sample.c          | 17 ++++++++++++-----
 tools/perf/util/session.c         | 19 ++++++++++++++++---
 8 files changed, 42 insertions(+), 19 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 0c7e27917bb8..c6e5b1b3b8df 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -702,8 +702,11 @@ static int perf_event__repipe_common_mmap(const struct perf_tool *tool,
 		}
 
 		if (dso && !dso__hit(dso)) {
-			if (!sample->evsel)
+			if (!sample->evsel) {
 				sample->evsel = evlist__event2evsel(inject->session->evlist, event);
+				if (sample->evsel)
+					evsel__get(sample->evsel);
+			}
 
 			if (sample->evsel) {
 				dso__set_hit(dso);
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 570750b9c27d..524d2febccf3 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3657,8 +3657,11 @@ static void trace__handle_event(struct trace *trace, union perf_event *event, st
 		return;
 	}
 
-	if (sample->evsel == NULL)
+	if (sample->evsel == NULL) {
 		sample->evsel = evlist__id2evsel(trace->evlist, sample->id);
+		if (sample->evsel)
+			evsel__get(sample->evsel);
+	}
 
 	if (sample->evsel == NULL) {
 		fprintf(trace->output, "Unknown tp ID %" PRIu64 ", skipping...\n", sample->id);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ba88c29ebe5c..d01c78da51e2 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3365,7 +3365,7 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 	union u64_swap u;
 
 	perf_sample__init(data, /*all=*/true);
-	data->evsel = evsel;
+	data->evsel = evsel__get(evsel);
 	data->cpu = data->pid = data->tid = -1;
 	data->stream_id = data->id = data->time = -1ULL;
 	data->period = evsel->core.attr.sample_period;
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 56a9e439f5f8..11a5ebf3b236 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1830,9 +1830,9 @@ static int intel_pt_synth_branch_sample(struct intel_pt_queue *ptq)
 		ptq->last_br_cyc_cnt = ptq->ipc_cyc_cnt;
 	}
 
-	perf_sample__exit(&sample);
 	ret = intel_pt_deliver_synth_event(pt, event, &sample,
 					    pt->branches_sample_type);
+	perf_sample__exit(&sample);
 	return ret;
 }
 
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 9f4216aa3867..669b65ce3f3d 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -63,7 +63,6 @@ PyMODINIT_FUNC PyInit_perf(void);
 
 struct pyrf_event {
 	PyObject_HEAD
-	struct evsel *evsel;
 	struct perf_sample sample;
 	union perf_event   event;
 };
@@ -294,7 +293,6 @@ static PyMemberDef pyrf_sample_event__members[] = {
 
 static void pyrf_sample_event__delete(struct pyrf_event *pevent)
 {
-	evsel__put(pevent->evsel);
 	perf_sample__exit(&pevent->sample);
 	Py_TYPE(pevent)->tp_free((PyObject*)pevent);
 }
@@ -316,7 +314,7 @@ static PyObject *pyrf_sample_event__repr(const struct pyrf_event *pevent)
 #ifdef HAVE_LIBTRACEEVENT
 static bool is_tracepoint(const struct pyrf_event *pevent)
 {
-	return pevent->evsel->core.attr.type == PERF_TYPE_TRACEPOINT;
+	return pevent->sample.evsel->core.attr.type == PERF_TYPE_TRACEPOINT;
 }
 
 static PyObject*
@@ -363,7 +361,7 @@ tracepoint_field(const struct pyrf_event *pe, struct tep_format_field *field)
 static PyObject*
 get_tracepoint_field(struct pyrf_event *pevent, PyObject *attr_name)
 {
-	struct evsel *evsel = pevent->evsel;
+	struct evsel *evsel = pevent->sample.evsel;
 	struct tep_event *tp_format = evsel__tp_format(evsel);
 	struct tep_format_field *field;
 
@@ -529,7 +527,7 @@ static PyObject *pyrf_event__new(const union perf_event *event)
 	pevent = PyObject_New(struct pyrf_event, ptype);
 	if (pevent != NULL) {
 		memcpy(&pevent->event, event, event->header.size);
-		pevent->evsel = NULL;
+		perf_sample__init(&pevent->sample, /*all=*/false);
 	}
 	return (PyObject *)pevent;
 }
@@ -1900,8 +1898,6 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 			return Py_None;
 		}
 
-		pevent->evsel = evsel__get(evsel);
-
 		perf_mmap__consume(&md->core);
 
 		err = evsel__parse_sample(evsel, &pevent->event, &pevent->sample);
diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
index 01111c4e3488..aaf8838b2cb2 100644
--- a/tools/perf/util/s390-sample-raw.c
+++ b/tools/perf/util/s390-sample-raw.c
@@ -343,6 +343,7 @@ void evlist__s390_sample_raw(struct evlist *evlist, union perf_event *event,
 		sample->evsel = evlist__event2evsel(evlist, event);
 		if (!sample->evsel)
 			return;
+		evsel__get(sample->evsel);
 	}
 
 	/* Check for raw data in sample */
diff --git a/tools/perf/util/sample.c b/tools/perf/util/sample.c
index cf73329326d7..bccc19e2aaf2 100644
--- a/tools/perf/util/sample.c
+++ b/tools/perf/util/sample.c
@@ -1,18 +1,23 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include "sample.h"
+
+#include <stdlib.h>
+#include <string.h>
+
+#include <elf.h>
+#include <linux/zalloc.h>
+
+#include "../../arch/x86/include/asm/insn.h"
 #include "debug.h"
+#include "evsel.h"
 #include "thread.h"
-#include <elf.h>
+
 #ifndef EM_CSKY
 #define EM_CSKY		252
 #endif
 #ifndef EM_LOONGARCH
 #define EM_LOONGARCH	258
 #endif
-#include <linux/zalloc.h>
-#include <stdlib.h>
-#include <string.h>
-#include "../../arch/x86/include/asm/insn.h"
 
 void perf_sample__init(struct perf_sample *sample, bool all)
 {
@@ -29,6 +34,8 @@ void perf_sample__init(struct perf_sample *sample, bool all)
 
 void perf_sample__exit(struct perf_sample *sample)
 {
+	evsel__put(sample->evsel);
+	sample->evsel = NULL;
 	zfree(&sample->user_regs);
 	zfree(&sample->intr_regs);
 	if (sample->merged_callchain) {
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 89d0f4cec6c7..18af70488e07 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1854,6 +1854,7 @@ static int evlist__deliver_deferred_callchain(struct evlist *evlist,
 
 	list_for_each_entry_safe(de, tmp, evlist__deferred_samples(evlist), list) {
 		struct perf_sample orig_sample;
+		struct evsel *new_evsel;
 
 		perf_sample__init(&orig_sample, /*all=*/false);
 		ret = evlist__parse_sample(evlist, de->event, &orig_sample);
@@ -1874,7 +1875,11 @@ static int evlist__deliver_deferred_callchain(struct evlist *evlist,
 		else
 			orig_sample.deferred_callchain = false;
 
-		orig_sample.evsel = evlist__id2evsel(evlist, orig_sample.id);
+		new_evsel = evlist__id2evsel(evlist, orig_sample.id);
+		if (new_evsel != orig_sample.evsel) {
+			evsel__put(orig_sample.evsel);
+			orig_sample.evsel = evsel__get(new_evsel);
+		}
 		ret = evlist__deliver_sample(evlist, tool, de->event,
 					     &orig_sample, machine);
 
@@ -1903,6 +1908,7 @@ static int session__flush_deferred_samples(struct perf_session *session,
 
 	list_for_each_entry_safe(de, tmp, evlist__deferred_samples(evlist), list) {
 		struct perf_sample sample;
+		struct evsel *new_evsel;
 
 		perf_sample__init(&sample, /*all=*/false);
 		ret = evlist__parse_sample(evlist, de->event, &sample);
@@ -1913,7 +1919,11 @@ static int session__flush_deferred_samples(struct perf_session *session,
 		}
 		sample.file_offset = de->file_offset;
 
-		sample.evsel = evlist__id2evsel(evlist, sample.id);
+		new_evsel = evlist__id2evsel(evlist, sample.id);
+		if (new_evsel != sample.evsel) {
+			evsel__put(sample.evsel);
+			sample.evsel = evsel__get(new_evsel);
+		}
 		ret = evlist__deliver_sample(evlist, tool, de->event,
 					     &sample, machine);
 
@@ -1959,8 +1969,11 @@ static int machines__deliver_event(struct machines *machines,
 
 	dump_event(evlist, event, file_offset, sample, file_path);
 
-	if (!sample->evsel)
+	if (!sample->evsel) {
 		sample->evsel = evlist__id2evsel(evlist, sample->id);
+		if (sample->evsel)
+			sample->evsel = evsel__get(sample->evsel);
+	}
 	else
 		assert(sample->evsel == evlist__id2evsel(evlist, sample->id));
 	machine = machines__find_for_cpumode(machines, event, sample);
-- 
2.54.0.1136.gdb2ca164c4-goog

