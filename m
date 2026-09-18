Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454C038330E
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 06:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789712789; cv=none; b=JoS/IsX/k7RHzDS8UAfOOMR6mGdp8ByyQxLAYYckqh8D0oONsIRYoDewtmX4+NPTh1KOQQgutZVwaDw3CmH/FBZbT1UGknX5rNtd/v4I42nTpXRWlJosjTXg5rfv3h4fL5OP9joRqbCugaS0tsbgc0RQKSIyyUz5N5h05sLjs88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789712789; c=relaxed/simple;
	bh=xQRWzj5Fu19D3vhZlPB3KeKBzKXeDse3MTAZQAQ/++g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=m/8Oarci8fJkMHB3dQKC/KNQnAU/e5dojo7moWTppFRgCZAhNLjkOCH2f10bCdm/2joQdnvncFvw0SaohGj230smoYExT2tmRcRqs8cSSu/b/qSySYOVIlaN5WT3i1NaXcfd2Y0dJ7TQTOWnJFRnxppw0UrVBkxuQATzaGmgSMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fSjPrjs6; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fSjPrjs6"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39d8646b10eso477333a91.1
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 23:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789712788; x=1790317588; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6tCF6WJ2WJS1iG2OvyI+viXS+7wGZJUXbwcD+A23+n0=;
        b=fSjPrjs6TQ6DB0rA0C+aal55VCyrev2n6Sv+6LIJfs8HXOGsL5UrhHV3eVr20XoXBz
         hOpMBM6eEL7lTgZcS7udN5doV+I+JsraYOzQQ3zX8QZRMy39A4IUI4VwxLwJC6dI6+wQ
         eesoH77wXJ7gT5NuRV/FP0XIsAuP7LdloEf9ktdzhOBo0Cj5pklQcLgrczX+YLKQRKkM
         tm3Pz08OKzsQQr90+CNWWmZIEWsEa7XfPPZB7MNwle0KKllBJRmQ/pdrcwwOHaUU9KpV
         ZK/5szAkIIiYfYJCelpQYSp7pCLGyujLnTbiqzg/CW9Un2qfOZUiyAz/q9orU1esZtRr
         ObgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789712788; x=1790317588;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6tCF6WJ2WJS1iG2OvyI+viXS+7wGZJUXbwcD+A23+n0=;
        b=E47n7DsLMGWARWry00tv7diUuk7YmFDAxEeY+z3+fTmXN/D3bbSBF3qzF4nymaDxia
         NIN1kslzdKoWyrwdbXwNbJTKgGYOCc8xZCIJ572+ddBSL6FB6XR9bpZtGCM4W+MeUJ56
         buGJ8BRo8WYbTkmvH2oBvFI0R9NwSIp6VW7Sw4Si0rtIF2bODnqYFCBwRpssb3mvEnQI
         JElyTSB92MCTpxQsuMqN4eAmBPMcsjAm7XcixqNYEn4ld8DV6S8Va+T69M6PktAb4vwl
         KOy0gabQwcDCp1u8grQPOrJgQh5T81u46cDZ+yRWLIuHrJ1bQniXTg+6ff15WhbulhOK
         HH+w==
X-Forwarded-Encrypted: i=1; AKwUvBxZAwIfPYByDkuKl0+4rFHLS+pkcRdDmzud+TLgWgvG7ocFzFEc1ZqgHc6c3Bmfv+SkZYS45AiRzxc289KgyIXm@vger.kernel.org
X-Gm-Message-State: AFuF++mU+eVpdpqkOy7IytiP9ihCOgwzaBfQ3p/MTMyPCQE2etTrmoby
	GvwCP233LBZtayzQhAf0eSWb/DSNW7YIqT2W3F5ZzSLyGKJSxmGSRRDSn4S04HoB5mCZkJzyVsy
	lecn7Jfxbzg==
X-Received: from dlae20.prod.google.com ([2002:a05:701b:2314:b0:143:7cf0:d45a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b4b:b0:39d:f66e:1720
 with SMTP id 98e67ed59e1d1-39e54eaf13cmr4664801a91.13.1789712787401; Thu, 17
 Sep 2026 23:26:27 -0700 (PDT)
Date: Thu, 17 Sep 2026 23:26:20 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918062620.2145220-1-irogers@google.com>
Subject: [PATCH v1] perf machine: Add session back pointer to fix out of
 bounds read
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

thread__e_machine_endian() decides whether a thread is live, and so
whether to read /proc/pid/exe rather than fall back to the perf.data
environment, by recovering the session from the machine:

	session = container_of(machine->machines, struct perf_session,
			       machines);
	is_live = !session->data;

That only holds when the struct machines is the one embedded in a struct
perf_session. It is not the only one. aslr_tool keeps its own in struct
aslr_tool, and hists_cumulate, hists_filter, hists_link, hists_output
and thread-maps-share each put one on the stack. For those the
container_of subtracts offsetof(struct perf_session, machines) from an
address that was never inside a session, and the following load of
session->data reads outside the object, which is what ASan reports.

Replace the derivation with an explicit link. machines__init() takes the
owning session, or NULL when the machines is standalone, and
thread__e_machine_endian() reads it back through machines__session().

A NULL session is treated as live. The tests use synthetic pids that
have no /proc entry, so the read fails there and the e_machine falls
back to EM_HOST as before, rather than being decided by whatever the
out of bounds read happened to return. perf inject registers its
session with the aslr tool once the session exists, before any event is
processed, so that tool keeps reporting file based threads as not live.

Fixes: 70351029b556 ("perf thread: Add support for reading the e_machine type for a thread")
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c          |  3 +++
 tools/perf/tests/hists_cumulate.c    |  2 +-
 tools/perf/tests/hists_filter.c      |  2 +-
 tools/perf/tests/hists_link.c        |  2 +-
 tools/perf/tests/hists_output.c      |  2 +-
 tools/perf/tests/thread-maps-share.c |  3 ++-
 tools/perf/util/aslr.c               | 10 +++++++++-
 tools/perf/util/aslr.h               |  2 ++
 tools/perf/util/machine.c            |  3 ++-
 tools/perf/util/machine.h            | 10 +++++++++-
 tools/perf/util/session.c            |  2 +-
 tools/perf/util/thread.c             |  8 +++-----
 12 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 70bbfad5653e..1446e5c0f63e 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2880,6 +2880,9 @@ int cmd_inject(int argc, const char **argv)
 		goto out_close_output;
 	}
 
+	if (inject.aslr)
+		aslr_tool__register_session(tool, inject.session);
+
 	if (zstd_init(&(inject.session->zstd_data), 0) < 0)
 		pr_warning("Decompression initialization failed.\n");
 
diff --git a/tools/perf/tests/hists_cumulate.c b/tools/perf/tests/hists_cumulate.c
index 9356451a172e..c4a11a3255bc 100644
--- a/tools/perf/tests/hists_cumulate.c
+++ b/tools/perf/tests/hists_cumulate.c
@@ -723,7 +723,7 @@ static int test__hists_cumulate(struct test_suite *test __maybe_unused, int subt
 		goto out;
 	err = TEST_FAIL;
 
-	if (machines__init(&machines))
+	if (machines__init(&machines, /*session=*/NULL))
 		goto out;
 
 	/* setup threads/dso/map/symbols also */
diff --git a/tools/perf/tests/hists_filter.c b/tools/perf/tests/hists_filter.c
index f9eaa511487b..6c7e4cdc71a7 100644
--- a/tools/perf/tests/hists_filter.c
+++ b/tools/perf/tests/hists_filter.c
@@ -131,7 +131,7 @@ static int test__hists_filter(struct test_suite *test __maybe_unused, int subtes
 		goto out;
 	err = TEST_FAIL;
 
-	if (machines__init(&machines))
+	if (machines__init(&machines, /*session=*/NULL))
 		goto out;
 
 	/* setup threads/dso/map/symbols also */
diff --git a/tools/perf/tests/hists_link.c b/tools/perf/tests/hists_link.c
index d88591bcbe50..cd32c8277627 100644
--- a/tools/perf/tests/hists_link.c
+++ b/tools/perf/tests/hists_link.c
@@ -303,7 +303,7 @@ static int test__hists_link(struct test_suite *test __maybe_unused, int subtest
 		goto out;
 
 	err = TEST_FAIL;
-	if (machines__init(&machines))
+	if (machines__init(&machines, /*session=*/NULL))
 		goto out;
 
 	/* setup threads/dso/map/symbols also */
diff --git a/tools/perf/tests/hists_output.c b/tools/perf/tests/hists_output.c
index f58c8d18fe33..35d230a83e43 100644
--- a/tools/perf/tests/hists_output.c
+++ b/tools/perf/tests/hists_output.c
@@ -610,7 +610,7 @@ static int test__hists_output(struct test_suite *test __maybe_unused, int subtes
 		goto out;
 	err = TEST_FAIL;
 
-	if (machines__init(&machines))
+	if (machines__init(&machines, /*session=*/NULL))
 		goto out;
 
 	/* setup threads/dso/map/symbols also */
diff --git a/tools/perf/tests/thread-maps-share.c b/tools/perf/tests/thread-maps-share.c
index 0431bff31b3a..4a0bbf715acb 100644
--- a/tools/perf/tests/thread-maps-share.c
+++ b/tools/perf/tests/thread-maps-share.c
@@ -27,7 +27,8 @@ static int test__thread_maps_share(struct test_suite *test __maybe_unused, int s
 	 * other  group (pid: 4, tids: 4, 5)
 	*/
 
-	TEST_ASSERT_VAL("failed to init machines", machines__init(&machines) == 0);
+	TEST_ASSERT_VAL("failed to init machines",
+			machines__init(&machines, /*session=*/NULL) == 0);
 	machine = &machines.host;
 
 	/* create process with 4 threads */
diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
index 027695d96779..76eba1a23bc7 100644
--- a/tools/perf/util/aslr.c
+++ b/tools/perf/util/aslr.c
@@ -1243,7 +1243,7 @@ static int aslr_tool__init(struct aslr_tool *aslr, struct perf_tool *delegate)
 	delegate_tool__init(&aslr->tool, delegate);
 	aslr->tool.tool.ordered_events = true;
 
-	if (machines__init(&aslr->machines))
+	if (machines__init(&aslr->machines, /*session=*/NULL))
 		return -ENOMEM;
 
 	hashmap__init(&aslr->remap_addresses,
@@ -1343,6 +1343,14 @@ void aslr_tool__delete(struct perf_tool *tool)
 	free(aslr);
 }
 
+void aslr_tool__register_session(struct perf_tool *tool, struct perf_session *session)
+{
+	struct delegate_tool *del_tool = container_of(tool, struct delegate_tool, tool);
+	struct aslr_tool *aslr = container_of(del_tool, struct aslr_tool, tool);
+
+	aslr->machines.session = session;
+}
+
 int aslr_tool__cache_orig_attrs(struct perf_tool *tool, struct evsel *evsel)
 {
 	struct delegate_tool *del_tool = container_of(tool, struct delegate_tool, tool);
diff --git a/tools/perf/util/aslr.h b/tools/perf/util/aslr.h
index 522e31c8e2c0..9cc14f0263db 100644
--- a/tools/perf/util/aslr.h
+++ b/tools/perf/util/aslr.h
@@ -28,6 +28,7 @@
 	PERF_SAMPLE_CODE_PAGE_SIZE | \
 	PERF_SAMPLE_AUX)
 
+struct perf_session;
 struct perf_tool;
 struct evsel;
 struct evlist;
@@ -36,6 +37,7 @@ union perf_event;
 struct perf_tool *aslr_tool__new(struct perf_tool *delegate);
 void aslr_tool__delete(struct perf_tool *tool);
 
+void aslr_tool__register_session(struct perf_tool *tool, struct perf_session *session);
 void aslr_tool__strip_attr_event(union perf_event *event, struct evlist *evlist);
 int aslr_tool__cache_orig_attrs(struct perf_tool *tool, struct evsel *evsel);
 void aslr_tool__strip_evlist(const struct perf_tool *tool, struct evlist *evlist);
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index a1288fbed833..1d9d3bf57720 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -233,10 +233,11 @@ void machine__delete(struct machine *machine)
 	}
 }
 
-int machines__init(struct machines *machines)
+int machines__init(struct machines *machines, struct perf_session *session)
 {
 	int err = machine__init(&machines->host, "", HOST_KERNEL_ID);
 
+	machines->session = session;
 	machines->host.machines = machines;
 	machines->guests = RB_ROOT_CACHED;
 	return err;
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 26f9827062f5..973a59f7c26a 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -15,6 +15,7 @@ struct dso;
 struct dso_id;
 struct evsel;
 struct perf_sample;
+struct perf_session;
 struct symbol;
 struct target;
 struct thread;
@@ -148,13 +149,20 @@ int machine__process_event(struct machine *machine, union perf_event *event,
 typedef void (*machine__process_t)(struct machine *machine, void *data);
 
 struct machines {
+	/** @session: back link to owning session if there is one. */
+	struct perf_session *session;
 	struct machine host;
 	struct rb_root_cached guests;
 };
 
-int machines__init(struct machines *machines);
+int machines__init(struct machines *machines, struct perf_session *session);
 void machines__exit(struct machines *machines);
 
+static inline struct perf_session *machines__session(struct machines *machines)
+{
+	return machines->session;
+}
+
 void machines__process_guests(struct machines *machines,
 			      machine__process_t process, void *data);
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index a5b596cd14be..85ae20ccb489 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -161,7 +161,7 @@ struct perf_session *__perf_session__new(struct perf_data *data,
 	session->active_decomp = &session->decomp_data;
 	INIT_LIST_HEAD(&session->auxtrace_index);
 	perf_env__init(&session->header.env);
-	if (machines__init(&session->machines))
+	if (machines__init(&session->machines, session))
 		goto out_delete;
 
 	ordered_events__init(&session->ordered_events,
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index f0d3773d87db..8b8ca94e89ea 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -531,12 +531,10 @@ uint16_t thread__e_machine_endian(struct thread *thread, struct machine *machine
 		bool is_live = machine->machines == NULL;
 
 		if (!is_live) {
-			/* Check if the session has a data file. */
-			struct perf_session *session = container_of(machine->machines,
-								    struct perf_session,
-								    machines);
+			/* Check if the session has a data file (assume no session is a test). */
+			struct perf_session *session = machines__session(machine->machines);
 
-			is_live = !session->data;
+			is_live = !session || !session->data;
 		}
 		/* Read from /proc/pid/exe if live. */
 		if (is_live) {
-- 
2.55.0.1082.g2b9226bbc0-goog

