Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3C51F9F75
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Mar 2025 05:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741843798; cv=none; b=X0FwSd7ZKcn5nTaHEisP00Tm4YIFuz3rHZzCNcip9IbLnB4caXmqFTHX4bktBZpQwriBtdIn65F5MvyL10UJRL03Y6cB7x+H9fm3o1dupXv3FLvDyyQTmEb3ETBgOkR2cOvVRp00WPc/65ZsXPTAf29hsxYG9XMQTuHPLh9llIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741843798; c=relaxed/simple;
	bh=sdLqXznJGK68zHO8fVk/sYHR0jFe7nGT6u5FJtbEV1w=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=bdwWkrZpvNOGhNbVeUoTLlPKnSEN66LQRpDgR+n4/+ad18lCMJQewQOVXfQiQSmleRbirEVdbeYFjcS+4CiNodj3XtnjadwAV0kBrm0PkTZHxgY8L7u1stuoQISY5Jdbow3MUfrjlZd2sBKL2ex/JgYbRYQf2THv+LcGVGHLO1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TQWF9JJy; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TQWF9JJy"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e634a124439so890623276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Mar 2025 22:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741843796; x=1742448596; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/pDVvPY/EbjpT1pnpzmTT+xHX0plEx2B0lP4lOauEaY=;
        b=TQWF9JJypu9bh8GMHqj5I+u5DRQkPOobg7b31XRBjHWY0grQNqu6I5gMhoJ+sbQPsF
         LvC/Ma6OvtQqy11dbgmOMAAbbRqOeJPH/9Ws1BCj7UPANg9ZGByz2cAgih15fbU9wk1w
         U0t0No9VyQUeIHioveDQGZrr5tTLyWueox3vbfxl5tKx6uZfRIZ73FqnqmQ2qyJIZ2wp
         d3aQM1XQpcRjK0hqhR2nVkzlwmzH21wg6R4K4c1VmfThiLZke42pAa3j97+AVHiWgM0V
         L7lET28SU0gF/hlUF3gFGl8znfn1ijsFr574fA4SJC/dTUsmXyXlLm+OFjClgrz7AsIc
         7jwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741843796; x=1742448596;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/pDVvPY/EbjpT1pnpzmTT+xHX0plEx2B0lP4lOauEaY=;
        b=sqTuvDbzZmtHteV84K8ZWUo08eu9KqxF8M8qd4McCqP/JVUL92VMyy5RGzkZSfRgfE
         8zgYeFmNbg80K3ij5S4TS7tjEeRNxyzSJWsa7XS8XNwN7eawTGPLcK9W9Z4UPgtAp7U7
         uvREZ9swgU2cQkNjwdMICRu18gxJlApkPZUcV9ZuSXEluaxB0J0ftmO0ObeNn7PjmX/x
         vSIhtrBJjc2qhej8tnToGGKQr6D8qO/AC1vxmZ3b2ANm+HfPK4lwv6rtHw83mcVhPkHf
         JASo/+mzpW23Tw7+CxkPy0vdiIQEmCvH0UAjbaawlt2gboHQih/WEAJCJaE9sXlGpQJJ
         dqlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlZd1G+ai5eDyD4ydYjTVNjnXDZ0voKTLgalKjnPJWMWiUeG6JEIwBOnICY0B/Qp9l4YL1uSR4BXnjUeU2HHHu@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+St1qtLyPLqIknbWv69799QQqHkB5ioz6JW5dN5MnMKYkXQMy
	CpaQoEM7VhQtqcK+sld94BrBfkIX/bIaMNLtpOrVs0kgYPPITNqFxyi+BhUKAE0g+619abYHcyo
	4AMCqGg==
X-Google-Smtp-Source: AGHT+IF1TurJf/mugVTINcwkgKCiDEAD4eqFaGBlP7HyXwG+ylrY+NGAPlm2xmaQRZWtZXpeeAZKGh2b6Cvs
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:de85:e25e:4e36:1ea5])
 (user=irogers job=sendgmr) by 2002:a25:7288:0:b0:e61:16cd:deb6 with SMTP id
 3f1490d57ef6-e635c10176emr2336666276.2.1741843795768; Wed, 12 Mar 2025
 22:29:55 -0700 (PDT)
Date: Wed, 12 Mar 2025 22:29:51 -0700
Message-Id: <20250313052952.871958-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Subject: [PATCH v1 1/2] perf machine: Factor creating a "live" machine out of dwarf-unwind
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Yicong Yang <yangyicong@hisilicon.com>, Howard Chu <howardchu95@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, 
	Anne Macedo <retpolanne@posteo.net>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Dmitry Vyukov <dvyukov@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Factor out for use in places other than the dwarf unwinding tests for
libunwind.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/dwarf-unwind.c | 35 ++++------------------
 tools/perf/util/machine.c       | 53 +++++++++++++++++++++++++++------
 tools/perf/util/machine.h       |  1 +
 3 files changed, 51 insertions(+), 38 deletions(-)

diff --git a/tools/perf/tests/dwarf-unwind.c b/tools/perf/tests/dwarf-unwind.c
index 4803ab2d97ba..525c46b7971a 100644
--- a/tools/perf/tests/dwarf-unwind.c
+++ b/tools/perf/tests/dwarf-unwind.c
@@ -15,7 +15,6 @@
 #include "symbol.h"
 #include "thread.h"
 #include "callchain.h"
-#include "util/synthetic-events.h"
 
 /* For bsearch. We try to unwind functions in shared object. */
 #include <stdlib.h>
@@ -37,24 +36,6 @@
 #define NO_TAIL_CALL_BARRIER __asm__ __volatile__("" : : : "memory");
 #endif
 
-static int mmap_handler(const struct perf_tool *tool __maybe_unused,
-			union perf_event *event,
-			struct perf_sample *sample,
-			struct machine *machine)
-{
-	return machine__process_mmap2_event(machine, event, sample);
-}
-
-static int init_live_machine(struct machine *machine)
-{
-	union perf_event event;
-	pid_t pid = getpid();
-
-	memset(&event, 0, sizeof(event));
-	return perf_event__synthesize_mmap_events(NULL, &event, pid, pid,
-						  mmap_handler, machine, true);
-}
-
 /*
  * We need to keep these functions global, despite the
  * fact that they are used only locally in this object,
@@ -202,8 +183,12 @@ noinline int test__dwarf_unwind(struct test_suite *test __maybe_unused,
 	struct machine *machine;
 	struct thread *thread;
 	int err = -1;
+	pid_t pid = getpid();
 
-	machine = machine__new_host();
+	callchain_param.record_mode = CALLCHAIN_DWARF;
+	dwarf_callchain_users = true;
+
+	machine = machine__new_live(/*kernel_maps=*/true, pid);
 	if (!machine) {
 		pr_err("Could not get machine\n");
 		return -1;
@@ -214,18 +199,10 @@ noinline int test__dwarf_unwind(struct test_suite *test __maybe_unused,
 		return -1;
 	}
 
-	callchain_param.record_mode = CALLCHAIN_DWARF;
-	dwarf_callchain_users = true;
-
-	if (init_live_machine(machine)) {
-		pr_err("Could not init machine\n");
-		goto out;
-	}
-
 	if (verbose > 1)
 		machine__fprintf(machine, stderr);
 
-	thread = machine__find_thread(machine, getpid(), getpid());
+	thread = machine__find_thread(machine, pid, pid);
 	if (!thread) {
 		pr_err("Could not get thread\n");
 		goto out;
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 2531b373f2cf..c5e28d15323f 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -20,6 +20,7 @@
 #include "path.h"
 #include "srcline.h"
 #include "symbol.h"
+#include "synthetic-events.h"
 #include "sort.h"
 #include "strlist.h"
 #include "target.h"
@@ -128,23 +129,57 @@ int machine__init(struct machine *machine, const char *root_dir, pid_t pid)
 	return 0;
 }
 
-struct machine *machine__new_host(void)
+static struct machine *__machine__new_host(bool kernel_maps)
 {
 	struct machine *machine = malloc(sizeof(*machine));
 
-	if (machine != NULL) {
-		machine__init(machine, "", HOST_KERNEL_ID);
+	if (!machine)
+		return NULL;
 
-		if (machine__create_kernel_maps(machine) < 0)
-			goto out_delete;
+	machine__init(machine, "", HOST_KERNEL_ID);
 
-		machine->env = &perf_env;
+	if (kernel_maps && machine__create_kernel_maps(machine) < 0) {
+		free(machine);
+		return NULL;
 	}
+	machine->env = &perf_env;
+	return machine;
+}
+
+struct machine *machine__new_host(void)
+{
+	return __machine__new_host(/*kernel_maps=*/true);
+}
+
+static int mmap_handler(const struct perf_tool *tool __maybe_unused,
+			union perf_event *event,
+			struct perf_sample *sample,
+			struct machine *machine)
+{
+	return machine__process_mmap2_event(machine, event, sample);
+}
 
+static int machine__init_live(struct machine *machine, pid_t pid)
+{
+	union perf_event event;
+
+	memset(&event, 0, sizeof(event));
+	return perf_event__synthesize_mmap_events(NULL, &event, pid, pid,
+						  mmap_handler, machine, true);
+}
+
+struct machine *machine__new_live(bool kernel_maps, pid_t pid)
+{
+	struct machine *machine = __machine__new_host(kernel_maps);
+
+	if (!machine)
+		return NULL;
+
+	if (machine__init_live(machine, pid)) {
+		machine__delete(machine);
+		return NULL;
+	}
 	return machine;
-out_delete:
-	free(machine);
-	return NULL;
 }
 
 struct machine *machine__new_kallsyms(void)
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index b56abec84fed..180b369c366c 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -171,6 +171,7 @@ void machines__set_comm_exec(struct machines *machines, bool comm_exec);
 
 struct machine *machine__new_host(void);
 struct machine *machine__new_kallsyms(void);
+struct machine *machine__new_live(bool kernel_maps, pid_t pid);
 int machine__init(struct machine *machine, const char *root_dir, pid_t pid);
 void machine__exit(struct machine *machine);
 void machine__delete_threads(struct machine *machine);
-- 
2.49.0.rc0.332.g42c0ae87b1-goog

