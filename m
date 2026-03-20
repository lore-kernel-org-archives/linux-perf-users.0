Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3766D230BE9
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 22:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774046131; cv=none; b=skSyMCiQro2It11NqfuvLwtIfK2a44dAZvrnzTloNiI1CsaYSIXq0jySd+fCkWjzG8OgAZaFh2R/scz2C42qdpZNaA392hN7RMfoNZcrrYjOvMu2cUd0TASpo2R++xWl/fe/0J7hjrRgnijOwT7UuWxabwqZVIHprfgvXr0RI4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774046131; c=relaxed/simple;
	bh=G7MtYIFFHFMbwEGHQn8DjIqlxtBe79a8eOcUK4C9/Ro=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=tjFurs3AeqddevgPIpoGV4Q9Bt7N2H8aLOVMjZ63BIuwAtTulm4pArRx/YpevvtTbh8CgyKupFr/ueq5MJvtMHbBPrKHGzvDdX24QSirpdMiol6EDesR3O4ucFAfqY3mzUwxQsS9zioDjXwVcmpT4G1r3gyBBjZRR0dz91mvF3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LYIhP4a3; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LYIhP4a3"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c0e264d802so45871485eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 15:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774046127; x=1774650927; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VeHMcqqKoZL6/MlDqSnSmpKB5Xc4jwgSmO6pN7mVJJw=;
        b=LYIhP4a370NtLc8d4EVxe5ZzzA8j94NeSXFSmeRNkQ3quC5fhhml3K/T5Ggaxl1RMK
         Cv/QfiQP2AlBwyC9H4ZYFsIDV4oeCKX+l5EGc84HSuZuE01eBWjsuVpyg1PAelDyhvXv
         o8Ix0u5grzlmRMWOYUspaXa85qraoeCt6CuPrkrLqrtisNBmk6wwk6BJT6gH1VFazt8D
         eLYTNvTqSqLwmbIqVJUteW1TnLOmt+8VU1Y+H0eAHlaxU7TIRwcL5DrWwjouOVnqa/VI
         8kJ+pg0KdZHs6/qHP78UD40EbjxfVu6R7WeuqiJpE2Ad70v40LuMmyNYa0QkJspkvArW
         crpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774046127; x=1774650927;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VeHMcqqKoZL6/MlDqSnSmpKB5Xc4jwgSmO6pN7mVJJw=;
        b=Be7tqMuGsAIBgvInuF0a4HblRNLQiqEGDhDARmk0BssxBm6qZD0xYycmfcLCb/BwBs
         8E1ze8XyYxqEU+5JP5kyA201Z0kCFmU+vDfKIzISTlZ/fjtssHmO97IStXc1bGsoVbq4
         WCRS7MiYv+cVKl/fFv9N/lDeEbJYXvTv0r/KGD4Mq6AgOg0GZqoPeg9v6ZJMH/sMXTbU
         oXzopC/7hF2mcxm5k0hIBWjBmn5JPzgxOXqnKJScA61d+7ovAzSn/mqsCn9nlHH4zrDz
         PG2IVChC/x3qlc2QIs1IxURy+jDRNIqNjOmEB0EiUakJLlBInWrRmRMXlEm/1ZPQ1XCA
         1GZA==
X-Forwarded-Encrypted: i=1; AJvYcCUHairAuJ6UTbDvGLqCvhSBykHqdgfaRhvIyHiZ1uwGTHW7CBuC/VADL5zFUPim/2ZesIlOGG+Mbu4jEcs2EyQa@vger.kernel.org
X-Gm-Message-State: AOJu0YxcqwXHKC+SpLYgvM1X1EzNZ7IhuIVLI98UD5aQ/Qtt+uZZwDgK
	6j91BhIHyyQg/kfK2wAJuWNRkb4SplBPgIbI5/rVg7WFrx52TtDU3phuoSg6qn6+7DzIArxV4ZY
	NB8bk1JJ+QQ==
X-Received: from dyw22.prod.google.com ([2002:a05:7300:8816:b0:2c0:d207:5bbf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:5709:b0:2bd:d3f3:b0be
 with SMTP id 5a478bee46e88-2c10970ed40mr2567679eec.20.1774046127042; Fri, 20
 Mar 2026 15:35:27 -0700 (PDT)
Date: Fri, 20 Mar 2026 15:35:20 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320223520.520454-1-irogers@google.com>
Subject: [PATCH v1] perf inject: Factor build ID inject out into a separate tool
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Create a new build_id_tool where build ID rewriting callbacks are
intercepted, handled then passed onto the delegate. All other
callbacks are just passed to the delegate. In some cast the delegate
isn't called as the event is dropped.

This is an initial refactoring of perf inject to use delegate
tools. The motivation is to make it so that tools compose and we can
do more than one perf inject rewrite at the same time by composing
them together. This should also simplify perf inject which just
becomes the orchestrator of tools.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c     | 512 ++---------------------------
 tools/perf/util/Build           |   1 +
 tools/perf/util/build-id.h      |   4 -
 tools/perf/util/build_id_tool.c | 551 ++++++++++++++++++++++++++++++++
 tools/perf/util/build_id_tool.h |  31 ++
 5 files changed, 613 insertions(+), 486 deletions(-)
 create mode 100644 tools/perf/util/build_id_tool.c
 create mode 100644 tools/perf/util/build_id_tool.h

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 5b29f4296861..86f0f6333582 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -8,6 +8,7 @@
  */
 #include "builtin.h"
 
+#include "util/build_id_tool.h"
 #include "util/color.h"
 #include "util/dso.h"
 #include "util/vdso.h"
@@ -30,7 +31,6 @@
 #include "util/tsc.h"
 
 #include <internal/lib.h>
-
 #include <linux/err.h>
 #include <subcmd/parse-options.h>
 #include <uapi/linux/mman.h> /* To get things like MAP_HUGETLB even on older libc headers */
@@ -103,14 +103,6 @@ struct guest_session {
 	struct guest_event		ev;
 };
 
-enum build_id_rewrite_style {
-	BID_RWS__NONE = 0,
-	BID_RWS__INJECT_HEADER_LAZY,
-	BID_RWS__INJECT_HEADER_ALL,
-	BID_RWS__MMAP2_BUILDID_ALL,
-	BID_RWS__MMAP2_BUILDID_LAZY,
-};
-
 struct perf_inject {
 	struct perf_tool	tool;
 	struct perf_session	*session;
@@ -132,8 +124,7 @@ struct perf_inject {
 	char			*event_copy;
 	struct perf_file_section secs[HEADER_FEAT_BITS];
 	struct guest_session	guest_session;
-	struct strlist		*known_build_ids;
-	const struct evsel	*mmap_evsel;
+	struct build_id_tool	*bit;
 	struct ip_callchain	*raw_callchain;
 };
 
@@ -143,24 +134,6 @@ struct event_entry {
 	union perf_event event[];
 };
 
-static int tool__inject_build_id(const struct perf_tool *tool,
-				 struct perf_sample *sample,
-				 struct machine *machine,
-				 const struct evsel *evsel,
-				 __u16 misc,
-				 const char *filename,
-				 struct dso *dso, u32 flags);
-static int tool__inject_mmap2_build_id(const struct perf_tool *tool,
-				      struct perf_sample *sample,
-				      struct machine *machine,
-				      const struct evsel *evsel,
-				      __u16 misc,
-				      __u32 pid, __u32 tid,
-				      __u64 start, __u64 len, __u64 pgoff,
-				      struct dso *dso,
-				      __u32 prot, __u32 flags,
-				      const char *filename);
-
 static int output_bytes(struct perf_inject *inject, void *buf, size_t sz)
 {
 	ssize_t size;
@@ -469,51 +442,6 @@ static int perf_event__convert_sample_callchain(const struct perf_tool *tool,
 	return perf_event__repipe_synth(tool, event_copy);
 }
 
-static struct dso *findnew_dso(int pid, int tid, const char *filename,
-			       const struct dso_id *id, struct machine *machine)
-{
-	struct thread *thread;
-	struct nsinfo *nsi = NULL;
-	struct nsinfo *nnsi;
-	struct dso *dso;
-	bool vdso;
-
-	thread = machine__findnew_thread(machine, pid, tid);
-	if (thread == NULL) {
-		pr_err("cannot find or create a task %d/%d.\n", tid, pid);
-		return NULL;
-	}
-
-	vdso = is_vdso_map(filename);
-	nsi = nsinfo__get(thread__nsinfo(thread));
-
-	if (vdso) {
-		/* The vdso maps are always on the host and not the
-		 * container.  Ensure that we don't use setns to look
-		 * them up.
-		 */
-		nnsi = nsinfo__copy(nsi);
-		if (nnsi) {
-			nsinfo__put(nsi);
-			nsinfo__clear_need_setns(nnsi);
-			nsi = nnsi;
-		}
-		dso = machine__findnew_vdso(machine, thread);
-	} else {
-		dso = machine__findnew_dso_id(machine, filename, id);
-	}
-
-	if (dso) {
-		mutex_lock(dso__lock(dso));
-		dso__set_nsinfo(dso, nsi);
-		mutex_unlock(dso__lock(dso));
-	} else
-		nsinfo__put(nsi);
-
-	thread__put(thread);
-	return dso;
-}
-
 /*
  * The evsel used for the sample ID for mmap events. Typically stashed when
  * processing mmap events. If not stashed, search the evlist for the first mmap
@@ -523,12 +451,13 @@ static const struct evsel *inject__mmap_evsel(struct perf_inject *inject)
 {
 	struct evsel *pos;
 
-	if (inject->mmap_evsel)
-		return inject->mmap_evsel;
+	if (inject->bit && inject->bit->mmap_evsel)
+		return inject->bit->mmap_evsel;
 
 	evlist__for_each_entry(inject->session->evlist, pos) {
 		if (pos->core.attr.mmap) {
-			inject->mmap_evsel = pos;
+			if (inject->bit)
+				inject->bit->mmap_evsel = pos;
 			return pos;
 		}
 	}
@@ -541,18 +470,14 @@ static int perf_event__repipe_common_mmap(const struct perf_tool *tool,
 					  struct perf_sample *sample,
 					  struct machine *machine,
 					  __u32 pid, __u32 tid,
-					  __u64 start, __u64 len, __u64 pgoff,
-					  __u32 flags, __u32 prot,
 					  const char *filename,
-					  const struct dso_id *dso_id,
 					  int (*perf_event_process)(const struct perf_tool *tool,
 								    union perf_event *event,
 								    struct perf_sample *sample,
 								    struct machine *machine))
 {
 	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
-	struct dso *dso = NULL;
-	bool dso_sought = false;
+	int err;
 
 #ifdef HAVE_JITDUMP
 	if (inject->jit_mode) {
@@ -570,73 +495,11 @@ static int perf_event__repipe_common_mmap(const struct perf_tool *tool,
 		}
 	}
 #endif
-	if (event->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID) {
-		dso = findnew_dso(pid, tid, filename, dso_id, machine);
-		dso_sought = true;
-		if (dso) {
-			/* mark it not to inject build-id */
-			dso__set_hit(dso);
-		}
-	}
-	if (inject->build_id_style == BID_RWS__INJECT_HEADER_ALL) {
-		if (!dso_sought) {
-			dso = findnew_dso(pid, tid, filename, dso_id, machine);
-			dso_sought = true;
-		}
-
-		if (dso && !dso__hit(dso)) {
-			struct evsel *evsel = evlist__event2evsel(inject->session->evlist, event);
-
-			if (evsel) {
-				dso__set_hit(dso);
-				tool__inject_build_id(tool, sample, machine, evsel,
-						      /*misc=*/sample->cpumode,
-						      filename, dso, flags);
-			}
-		}
-	} else {
-		int err;
+	/* Create the thread, map, etc. */
+	err = perf_event_process(tool, event, sample, machine);
 
-		/*
-		 * Remember the evsel for lazy build id generation. It is used
-		 * for the sample id header type.
-		 */
-		if ((inject->build_id_style == BID_RWS__INJECT_HEADER_LAZY ||
-		     inject->build_id_style == BID_RWS__MMAP2_BUILDID_LAZY) &&
-		    !inject->mmap_evsel)
-			inject->mmap_evsel = evlist__event2evsel(inject->session->evlist, event);
-
-		/* Create the thread, map, etc. Not done for the unordered inject all case. */
-		err = perf_event_process(tool, event, sample, machine);
-
-		if (err) {
-			dso__put(dso);
-			return err;
-		}
-	}
-	if ((inject->build_id_style == BID_RWS__MMAP2_BUILDID_ALL) &&
-	    !(event->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID)) {
-		struct evsel *evsel = evlist__event2evsel(inject->session->evlist, event);
-
-		if (evsel && !dso_sought) {
-			dso = findnew_dso(pid, tid, filename, dso_id, machine);
-			dso_sought = true;
-		}
-		if (evsel && dso &&
-		    !tool__inject_mmap2_build_id(tool, sample, machine, evsel,
-						 sample->cpumode | PERF_RECORD_MISC_MMAP_BUILD_ID,
-						 pid, tid, start, len, pgoff,
-						 dso,
-						 prot, flags,
-						 filename)) {
-			/* Injected mmap2 so no need to repipe. */
-			dso__put(dso);
-			return 0;
-		}
-	}
-	dso__put(dso);
-	if (inject->build_id_style == BID_RWS__MMAP2_BUILDID_LAZY)
-		return 0;
+	if (err)
+		return err;
 
 	return perf_event__repipe(tool, event, sample, machine);
 }
@@ -649,9 +512,7 @@ static int perf_event__repipe_mmap(const struct perf_tool *tool,
 	return perf_event__repipe_common_mmap(
 		tool, event, sample, machine,
 		event->mmap.pid, event->mmap.tid,
-		event->mmap.start, event->mmap.len, event->mmap.pgoff,
-		/*flags=*/0, PROT_EXEC,
-		event->mmap.filename, /*dso_id=*/NULL,
+		event->mmap.filename,
 		perf_event__process_mmap);
 }
 
@@ -660,25 +521,10 @@ static int perf_event__repipe_mmap2(const struct perf_tool *tool,
 				struct perf_sample *sample,
 				struct machine *machine)
 {
-	struct dso_id id = dso_id_empty;
-
-	if (event->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID) {
-		build_id__init(&id.build_id, event->mmap2.build_id, event->mmap2.build_id_size);
-	} else {
-		id.maj = event->mmap2.maj;
-		id.min = event->mmap2.min;
-		id.ino = event->mmap2.ino;
-		id.ino_generation = event->mmap2.ino_generation;
-		id.mmap2_valid = true;
-		id.mmap2_ino_generation_valid = true;
-	}
-
 	return perf_event__repipe_common_mmap(
 		tool, event, sample, machine,
 		event->mmap2.pid, event->mmap2.tid,
-		event->mmap2.start, event->mmap2.len, event->mmap2.pgoff,
-		event->mmap2.flags, event->mmap2.prot,
-		event->mmap2.filename, &id,
+		event->mmap2.filename,
 		perf_event__process_mmap2);
 }
 
@@ -744,293 +590,6 @@ static int perf_event__repipe_tracing_data(const struct perf_tool *tool,
 }
 #endif
 
-static int dso__read_build_id(struct dso *dso)
-{
-	struct nscookie nsc;
-	struct build_id bid = { .size = 0, };
-
-	if (dso__has_build_id(dso))
-		return 0;
-
-	mutex_lock(dso__lock(dso));
-	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
-	if (filename__read_build_id(dso__long_name(dso), &bid) > 0)
-		dso__set_build_id(dso, &bid);
-	else if (dso__nsinfo(dso)) {
-		char *new_name = dso__filename_with_chroot(dso, dso__long_name(dso));
-
-		if (new_name && filename__read_build_id(new_name, &bid) > 0)
-			dso__set_build_id(dso, &bid);
-		free(new_name);
-	}
-	nsinfo__mountns_exit(&nsc);
-	mutex_unlock(dso__lock(dso));
-
-	return dso__has_build_id(dso) ? 0 : -1;
-}
-
-static struct strlist *perf_inject__parse_known_build_ids(
-	const char *known_build_ids_string)
-{
-	struct str_node *pos, *tmp;
-	struct strlist *known_build_ids;
-	int bid_len;
-
-	known_build_ids = strlist__new(known_build_ids_string, NULL);
-	if (known_build_ids == NULL)
-		return NULL;
-	strlist__for_each_entry_safe(pos, tmp, known_build_ids) {
-		const char *build_id, *dso_name;
-
-		build_id = skip_spaces(pos->s);
-		dso_name = strchr(build_id, ' ');
-		if (dso_name == NULL) {
-			strlist__remove(known_build_ids, pos);
-			continue;
-		}
-		bid_len = dso_name - pos->s;
-		dso_name = skip_spaces(dso_name);
-		if (bid_len % 2 != 0 || bid_len >= SBUILD_ID_SIZE) {
-			strlist__remove(known_build_ids, pos);
-			continue;
-		}
-		for (int ix = 0; 2 * ix + 1 < bid_len; ++ix) {
-			if (!isxdigit(build_id[2 * ix]) ||
-			    !isxdigit(build_id[2 * ix + 1])) {
-				strlist__remove(known_build_ids, pos);
-				break;
-			}
-		}
-	}
-	return known_build_ids;
-}
-
-static bool perf_inject__lookup_known_build_id(struct perf_inject *inject,
-					       struct dso *dso)
-{
-	struct str_node *pos;
-
-	strlist__for_each_entry(pos, inject->known_build_ids) {
-		struct build_id bid;
-		const char *build_id, *dso_name;
-		size_t bid_len;
-
-		build_id = skip_spaces(pos->s);
-		dso_name = strchr(build_id, ' ');
-		bid_len = dso_name - pos->s;
-		if (bid_len > sizeof(bid.data))
-			bid_len = sizeof(bid.data);
-		dso_name = skip_spaces(dso_name);
-		if (strcmp(dso__long_name(dso), dso_name))
-			continue;
-		for (size_t ix = 0; 2 * ix + 1 < bid_len; ++ix) {
-			bid.data[ix] = (hex(build_id[2 * ix]) << 4 |
-					hex(build_id[2 * ix + 1]));
-		}
-		bid.size = bid_len / 2;
-		dso__set_build_id(dso, &bid);
-		return true;
-	}
-	return false;
-}
-
-static int tool__inject_build_id(const struct perf_tool *tool,
-				 struct perf_sample *sample,
-				 struct machine *machine,
-				 const struct evsel *evsel,
-				 __u16 misc,
-				 const char *filename,
-				 struct dso *dso, u32 flags)
-{
-	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
-	int err;
-
-	if (is_anon_memory(filename) || flags & MAP_HUGETLB)
-		return 0;
-	if (is_no_dso_memory(filename))
-		return 0;
-
-	if (inject->known_build_ids != NULL &&
-	    perf_inject__lookup_known_build_id(inject, dso))
-		return 1;
-
-	if (dso__read_build_id(dso) < 0) {
-		pr_debug("no build_id found for %s\n", filename);
-		return -1;
-	}
-
-	err = perf_event__synthesize_build_id(tool, sample, machine,
-					      perf_event__repipe,
-					      evsel, misc, dso__bid(dso),
-					      filename);
-	if (err) {
-		pr_err("Can't synthesize build_id event for %s\n", filename);
-		return -1;
-	}
-
-	return 0;
-}
-
-static int tool__inject_mmap2_build_id(const struct perf_tool *tool,
-				       struct perf_sample *sample,
-				       struct machine *machine,
-				       const struct evsel *evsel,
-				       __u16 misc,
-				       __u32 pid, __u32 tid,
-				       __u64 start, __u64 len, __u64 pgoff,
-				       struct dso *dso,
-				       __u32 prot, __u32 flags,
-				       const char *filename)
-{
-	int err;
-
-	/* Return to repipe anonymous maps. */
-	if (is_anon_memory(filename) || flags & MAP_HUGETLB)
-		return 1;
-	if (is_no_dso_memory(filename))
-		return 1;
-
-	if (dso__read_build_id(dso)) {
-		pr_debug("no build_id found for %s\n", filename);
-		return -1;
-	}
-
-	err = perf_event__synthesize_mmap2_build_id(tool, sample, machine,
-						    perf_event__repipe,
-						    evsel,
-						    misc, pid, tid,
-						    start, len, pgoff,
-						    dso__bid(dso),
-						    prot, flags,
-						    filename);
-	if (err) {
-		pr_err("Can't synthesize build_id event for %s\n", filename);
-		return -1;
-	}
-	return 0;
-}
-
-static int mark_dso_hit(const struct perf_inject *inject,
-			const struct perf_tool *tool,
-			struct perf_sample *sample,
-			struct machine *machine,
-			const struct evsel *mmap_evsel,
-			struct map *map, bool sample_in_dso)
-{
-	struct dso *dso;
-	u16 misc = sample->cpumode;
-
-	if (!map)
-		return 0;
-
-	if (!sample_in_dso) {
-		u16 guest_mask = PERF_RECORD_MISC_GUEST_KERNEL |
-			PERF_RECORD_MISC_GUEST_USER;
-
-		if ((misc & guest_mask) != 0) {
-			misc &= PERF_RECORD_MISC_HYPERVISOR;
-			misc |= __map__is_kernel(map)
-				? PERF_RECORD_MISC_GUEST_KERNEL
-				: PERF_RECORD_MISC_GUEST_USER;
-		} else {
-			misc &= PERF_RECORD_MISC_HYPERVISOR;
-			misc |= __map__is_kernel(map)
-				? PERF_RECORD_MISC_KERNEL
-				: PERF_RECORD_MISC_USER;
-		}
-	}
-	dso = map__dso(map);
-	if (inject->build_id_style == BID_RWS__INJECT_HEADER_LAZY) {
-		if (dso && !dso__hit(dso)) {
-			dso__set_hit(dso);
-			tool__inject_build_id(tool, sample, machine,
-					     mmap_evsel, misc, dso__long_name(dso), dso,
-					     map__flags(map));
-		}
-	} else if (inject->build_id_style == BID_RWS__MMAP2_BUILDID_LAZY) {
-		if (!map__hit(map)) {
-			const struct build_id null_bid = { .size = 0 };
-			const struct build_id *bid = dso ? dso__bid(dso) : &null_bid;
-			const char *filename = dso ? dso__long_name(dso) : "";
-
-			map__set_hit(map);
-			perf_event__synthesize_mmap2_build_id(tool, sample, machine,
-								perf_event__repipe,
-								mmap_evsel,
-								misc,
-								sample->pid, sample->tid,
-								map__start(map),
-								map__end(map) - map__start(map),
-								map__pgoff(map),
-								bid,
-								map__prot(map),
-								map__flags(map),
-								filename);
-		}
-	}
-	return 0;
-}
-
-struct mark_dso_hit_args {
-	const struct perf_inject *inject;
-	const struct perf_tool *tool;
-	struct perf_sample *sample;
-	struct machine *machine;
-	const struct evsel *mmap_evsel;
-};
-
-static int mark_dso_hit_callback(struct callchain_cursor_node *node, void *data)
-{
-	struct mark_dso_hit_args *args = data;
-	struct map *map = node->ms.map;
-
-	return mark_dso_hit(args->inject, args->tool, args->sample, args->machine,
-			    args->mmap_evsel, map, /*sample_in_dso=*/false);
-}
-
-int perf_event__inject_buildid(const struct perf_tool *tool, union perf_event *event,
-			       struct perf_sample *sample,
-			       struct evsel *evsel __maybe_unused,
-			       struct machine *machine)
-{
-	struct addr_location al;
-	struct thread *thread;
-	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
-	struct mark_dso_hit_args args = {
-		.inject = inject,
-		.tool = tool,
-		/*
-		 * Use the parsed sample data of the sample event, which will
-		 * have a later timestamp than the mmap event.
-		 */
-		.sample = sample,
-		.machine = machine,
-		.mmap_evsel = inject__mmap_evsel(inject),
-	};
-
-	addr_location__init(&al);
-	thread = machine__findnew_thread(machine, sample->pid, sample->tid);
-	if (thread == NULL) {
-		pr_err("problem processing %d event, skipping it.\n",
-		       event->header.type);
-		goto repipe;
-	}
-
-	if (thread__find_map(thread, sample->cpumode, sample->ip, &al)) {
-		mark_dso_hit(inject, tool, sample, machine, args.mmap_evsel, al.map,
-			     /*sample_in_dso=*/true);
-	}
-
-	sample__for_each_callchain_node(thread, evsel, sample, PERF_MAX_STACK_DEPTH,
-					/*symbols=*/false, mark_dso_hit_callback, &args);
-
-	thread__put(thread);
-repipe:
-	perf_event__repipe(tool, event, sample, machine);
-	addr_location__exit(&al);
-	return 0;
-}
-
 static int perf_inject__sched_process_exit(const struct perf_tool *tool,
 					   union perf_event *event __maybe_unused,
 					   struct perf_sample *sample,
@@ -2258,8 +1817,7 @@ static int __cmd_inject(struct perf_inject *inject)
 
 	signal(SIGINT, sig_handler);
 
-	if (inject->build_id_style != BID_RWS__NONE || inject->sched_stat ||
-	    inject->itrace_synth_opts.set) {
+	if (inject->sched_stat || inject->itrace_synth_opts.set) {
 		inject->tool.mmap	  = perf_event__repipe_mmap;
 		inject->tool.mmap2	  = perf_event__repipe_mmap2;
 		inject->tool.fork	  = perf_event__repipe_fork;
@@ -2268,10 +1826,7 @@ static int __cmd_inject(struct perf_inject *inject)
 #endif
 	}
 
-	if (inject->build_id_style == BID_RWS__INJECT_HEADER_LAZY ||
-	    inject->build_id_style == BID_RWS__MMAP2_BUILDID_LAZY) {
-		inject->tool.sample = perf_event__inject_buildid;
-	} else if (inject->sched_stat) {
+	if (inject->sched_stat) {
 		struct evsel *evsel;
 
 		evlist__for_each_entry(session->evlist, evsel) {
@@ -2548,6 +2103,7 @@ int cmd_inject(int argc, const char **argv)
 		NULL
 	};
 	bool ordered_events;
+	struct perf_tool *tool;
 
 	if (!inject.itrace_synth_opts.set) {
 		/* Disable eager loading of kernel symbols that adds overhead to perf inject. */
@@ -2661,7 +2217,19 @@ int cmd_inject(int argc, const char **argv)
 	inject.tool.schedstat_domain	= perf_event__repipe_op2_synth;
 	inject.tool.dont_split_sample_group = true;
 	inject.tool.merge_deferred_callchains = false;
-	inject.session = __perf_session__new(&data, &inject.tool,
+	tool = &inject.tool;
+
+	if (inject.build_id_style != BID_RWS__NONE) {
+		inject.bit = build_id_tool__new(inject.build_id_style, known_build_ids,
+						&inject.tool);
+		if (inject.bit == NULL) {
+			pr_err("Couldn't create build-id tool.\n");
+			goto out_delete;
+		}
+		tool = &inject.bit->dtool.tool;
+	}
+
+	inject.session = __perf_session__new(&data, tool,
 					     /*trace_event_repipe=*/inject.output.is_pipe,
 					     /*host_env=*/NULL);
 
@@ -2700,26 +2268,6 @@ int cmd_inject(int argc, const char **argv)
 		}
 	}
 
-	if (inject.build_id_style == BID_RWS__INJECT_HEADER_LAZY ||
-	    inject.build_id_style == BID_RWS__MMAP2_BUILDID_LAZY) {
-		/*
-		 * to make sure the mmap records are ordered correctly
-		 * and so that the correct especially due to jitted code
-		 * mmaps. We cannot generate the buildid hit list and
-		 * inject the jit mmaps at the same time for now.
-		 */
-		inject.tool.ordering_requires_timestamps = true;
-	}
-	if (inject.build_id_style != BID_RWS__NONE && known_build_ids != NULL) {
-		inject.known_build_ids =
-			perf_inject__parse_known_build_ids(known_build_ids);
-
-		if (inject.known_build_ids == NULL) {
-			pr_err("Couldn't parse known build ids.\n");
-			goto out_delete;
-		}
-	}
-
 	if (inject.convert_callchain) {
 		struct evsel *evsel;
 
@@ -2763,7 +2311,7 @@ int cmd_inject(int argc, const char **argv)
 	guest_session__exit(&inject.guest_session);
 
 out_delete:
-	strlist__delete(inject.known_build_ids);
+	build_id_tool__delete(inject.bit);
 	zstd_fini(&(inject.session->zstd_data));
 	perf_session__delete(inject.session);
 out_close_output:
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 70cc91d00804..1cf0221a3ecc 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -10,6 +10,7 @@ perf-util-y += blake2s.o
 perf-util-y += block-info.o
 perf-util-y += block-range.o
 perf-util-y += build-id.o
+perf-util-y += build_id_tool.o
 perf-util-y += cacheline.o
 perf-util-$(CONFIG_LIBCAPSTONE) += capstone.o
 perf-util-y += config.o
diff --git a/tools/perf/util/build-id.h b/tools/perf/util/build-id.h
index 47e621cebe1b..be06ebdc43b2 100644
--- a/tools/perf/util/build-id.h
+++ b/tools/perf/util/build-id.h
@@ -37,10 +37,6 @@ int build_id__mark_dso_hit(const struct perf_tool *tool, union perf_event *event
 			   struct perf_sample *sample, struct evsel *evsel,
 			   struct machine *machine);
 
-int perf_event__inject_buildid(const struct perf_tool *tool, union perf_event *event,
-			       struct perf_sample *sample, struct evsel *evsel,
-			       struct machine *machine);
-
 bool perf_session__read_build_ids(struct perf_session *session, bool with_hits);
 int perf_session__write_buildid_table(struct perf_session *session,
 				      struct feat_fd *fd);
diff --git a/tools/perf/util/build_id_tool.c b/tools/perf/util/build_id_tool.c
new file mode 100644
index 000000000000..ca48278a2c74
--- /dev/null
+++ b/tools/perf/util/build_id_tool.c
@@ -0,0 +1,551 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "build_id_tool.h"
+
+#include <linux/ctype.h>
+#include <linux/mman.h>
+#include <linux/zalloc.h>
+
+#include "addr_location.h"
+#include "build-id.h"
+#include "debug.h"
+#include "dso.h"
+#include "evlist.h"
+#include "machine.h"
+#include "map.h"
+#include "namespaces.h"
+#include "session.h"
+#include "string2.h"
+#include "strlist.h"
+#include "symbol.h"
+#include "synthetic-events.h"
+#include "thread.h"
+#include "vdso.h"
+
+static int build_id_tool__repipe(const struct perf_tool *tool,
+				 union perf_event *event,
+				 struct perf_sample *sample,
+				 struct machine *machine)
+{
+	struct build_id_tool *bit = container_of(tool, struct build_id_tool, dtool.tool);
+	struct perf_tool *delegate = bit->dtool.delegate;
+
+	if (event->header.type == PERF_RECORD_MMAP2)
+		return delegate->mmap2(delegate, event, sample, machine);
+
+	return delegate->mmap(delegate, event, sample, machine);
+}
+
+static int dso__read_build_id(struct dso *dso)
+{
+	struct nscookie nsc;
+	struct build_id bid = { .size = 0, };
+
+	if (dso__has_build_id(dso))
+		return 0;
+
+	mutex_lock(dso__lock(dso));
+	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
+	if (filename__read_build_id(dso__long_name(dso), &bid) > 0)
+		dso__set_build_id(dso, &bid);
+	else if (dso__nsinfo(dso)) {
+		char *new_name = dso__filename_with_chroot(dso, dso__long_name(dso));
+
+		if (new_name && filename__read_build_id(new_name, &bid) > 0)
+			dso__set_build_id(dso, &bid);
+		free(new_name);
+	}
+	nsinfo__mountns_exit(&nsc);
+	mutex_unlock(dso__lock(dso));
+
+	return dso__has_build_id(dso) ? 0 : -1;
+}
+
+static struct dso *findnew_dso(int pid, int tid, const char *filename,
+			       const struct dso_id *id, struct machine *machine)
+{
+	struct thread *thread;
+	struct nsinfo *nsi = NULL;
+	struct nsinfo *nnsi;
+	struct dso *dso;
+	bool vdso;
+
+	thread = machine__findnew_thread(machine, pid, tid);
+	if (thread == NULL) {
+		pr_err("cannot find or create a task %d/%d.\n", tid, pid);
+		return NULL;
+	}
+
+	vdso = is_vdso_map(filename);
+	nsi = nsinfo__get(thread__nsinfo(thread));
+
+	if (vdso) {
+		/* The vdso maps are always on the host and not the
+		 * container.  Ensure that we don't use setns to look
+		 * them up.
+		 */
+		nnsi = nsinfo__copy(nsi);
+		if (nnsi) {
+			nsinfo__put(nsi);
+			nsinfo__clear_need_setns(nnsi);
+			nsi = nnsi;
+		}
+		dso = machine__findnew_vdso(machine, thread);
+	} else {
+		dso = machine__findnew_dso_id(machine, filename, id);
+	}
+
+	if (dso) {
+		mutex_lock(dso__lock(dso));
+		dso__set_nsinfo(dso, nsi);
+		mutex_unlock(dso__lock(dso));
+	} else
+		nsinfo__put(nsi);
+
+	thread__put(thread);
+	return dso;
+}
+
+static struct strlist *build_id_tool__parse_known_build_ids(const char *known_build_ids_string)
+{
+	struct str_node *pos, *tmp;
+	struct strlist *known_build_ids;
+	int bid_len;
+
+	known_build_ids = strlist__new(known_build_ids_string, NULL);
+	if (known_build_ids == NULL)
+		return NULL;
+	strlist__for_each_entry_safe(pos, tmp, known_build_ids) {
+		const char *build_id, *dso_name;
+
+		build_id = skip_spaces(pos->s);
+		dso_name = strchr(build_id, ' ');
+		if (dso_name == NULL) {
+			strlist__remove(known_build_ids, pos);
+			continue;
+		}
+		bid_len = dso_name - pos->s;
+		dso_name = skip_spaces(dso_name);
+		if (bid_len % 2 != 0 || bid_len >= SBUILD_ID_SIZE) {
+			strlist__remove(known_build_ids, pos);
+			continue;
+		}
+		for (int ix = 0; 2 * ix + 1 < bid_len; ++ix) {
+			if (!isxdigit(build_id[2 * ix]) ||
+			    !isxdigit(build_id[2 * ix + 1])) {
+				strlist__remove(known_build_ids, pos);
+				break;
+			}
+		}
+	}
+	return known_build_ids;
+}
+
+static bool build_id_tool__lookup_known_build_id(struct build_id_tool *bit,
+						 struct dso *dso)
+{
+	struct str_node *pos;
+
+	strlist__for_each_entry(pos, bit->known_build_ids) {
+		struct build_id bid;
+		const char *build_id, *dso_name;
+		size_t bid_len;
+
+		build_id = skip_spaces(pos->s);
+		dso_name = strchr(build_id, ' ');
+		bid_len = dso_name - pos->s;
+		if (bid_len > sizeof(bid.data))
+			bid_len = sizeof(bid.data);
+		dso_name = skip_spaces(dso_name);
+		if (strcmp(dso__long_name(dso), dso_name))
+			continue;
+		for (size_t ix = 0; 2 * ix + 1 < bid_len; ++ix) {
+			bid.data[ix] = (hex(build_id[2 * ix]) << 4 |
+					hex(build_id[2 * ix + 1]));
+		}
+		bid.size = bid_len / 2;
+		dso__set_build_id(dso, &bid);
+		return true;
+	}
+	return false;
+}
+
+static int build_id_tool__inject_build_id(const struct perf_tool *tool,
+					  struct perf_sample *sample,
+					  struct machine *machine,
+					  const struct evsel *evsel,
+					  __u16 misc,
+					  const char *filename,
+					  struct dso *dso, u32 flags)
+{
+	struct build_id_tool *bit = container_of(tool, struct build_id_tool, dtool.tool);
+	int err;
+
+	if (is_anon_memory(filename) || flags & MAP_HUGETLB)
+		return 0;
+	if (is_no_dso_memory(filename))
+		return 0;
+
+	if (bit->known_build_ids != NULL &&
+	    build_id_tool__lookup_known_build_id(bit, dso))
+		return 1;
+
+	if (dso__read_build_id(dso) < 0) {
+		pr_debug("no build_id found for %s\n", filename);
+		return -1;
+	}
+
+	err = perf_event__synthesize_build_id(tool, sample, machine,
+					      build_id_tool__repipe,
+					      evsel, misc, dso__bid(dso),
+					      filename);
+	if (err) {
+		pr_err("Can't synthesize build_id event for %s\n", filename);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int tool__inject_mmap2_build_id(const struct perf_tool *tool,
+				       struct perf_sample *sample,
+				       struct machine *machine,
+				       const struct evsel *evsel,
+				       __u16 misc,
+				       __u32 pid, __u32 tid,
+				       __u64 start, __u64 len, __u64 pgoff,
+				       struct dso *dso,
+				       __u32 prot, __u32 flags,
+				       const char *filename)
+{
+	int err;
+
+	/* Return to repipe anonymous maps. */
+	if (is_anon_memory(filename) || flags & MAP_HUGETLB)
+		return 1;
+	if (is_no_dso_memory(filename))
+		return 1;
+
+	if (dso__read_build_id(dso)) {
+		pr_debug("no build_id found for %s\n", filename);
+		return -1;
+	}
+
+	err = perf_event__synthesize_mmap2_build_id(tool, sample, machine,
+						    build_id_tool__repipe,
+						    evsel,
+						    misc, pid, tid,
+						    start, len, pgoff,
+						    dso__bid(dso),
+						    prot, flags,
+						    filename);
+	if (err) {
+		pr_err("Can't synthesize build_id event for %s\n", filename);
+		return -1;
+	}
+	return 0;
+}
+
+static int mark_dso_hit(struct build_id_tool *bit,
+			const struct perf_tool *tool,
+			struct perf_sample *sample,
+			struct machine *machine,
+			const struct evsel *mmap_evsel,
+			struct map *map, bool sample_in_dso)
+{
+	struct dso *dso;
+	u16 misc = sample->cpumode;
+
+	if (!map)
+		return 0;
+
+	if (!sample_in_dso) {
+		u16 guest_mask = PERF_RECORD_MISC_GUEST_KERNEL |
+			PERF_RECORD_MISC_GUEST_USER;
+
+		if ((misc & guest_mask) != 0) {
+			misc &= PERF_RECORD_MISC_HYPERVISOR;
+			misc |= __map__is_kernel(map)
+				? PERF_RECORD_MISC_GUEST_KERNEL
+				: PERF_RECORD_MISC_GUEST_USER;
+		} else {
+			misc &= PERF_RECORD_MISC_HYPERVISOR;
+			misc |= __map__is_kernel(map)
+				? PERF_RECORD_MISC_KERNEL
+				: PERF_RECORD_MISC_USER;
+		}
+	}
+	dso = map__dso(map);
+	if (bit->style == BID_RWS__INJECT_HEADER_LAZY) {
+		if (dso && !dso__hit(dso)) {
+			dso__set_hit(dso);
+			build_id_tool__inject_build_id(tool, sample, machine,
+						       mmap_evsel, misc, dso__long_name(dso), dso,
+						       map__flags(map));
+		}
+	} else if (bit->style == BID_RWS__MMAP2_BUILDID_LAZY) {
+		if (!map__hit(map)) {
+			const struct build_id null_bid = { .size = 0 };
+			const struct build_id *bid = dso ? dso__bid(dso) : &null_bid;
+			const char *filename = dso ? dso__long_name(dso) : "";
+
+			map__set_hit(map);
+			perf_event__synthesize_mmap2_build_id(tool, sample, machine,
+							      build_id_tool__repipe,
+							      mmap_evsel,
+							      misc,
+							      sample->pid, sample->tid,
+							      map__start(map),
+							      map__end(map) - map__start(map),
+							      map__pgoff(map),
+							      bid,
+							      map__prot(map),
+							      map__flags(map),
+							      filename);
+		}
+	}
+	return 0;
+}
+
+struct mark_dso_hit_args {
+	struct build_id_tool *bit;
+	const struct perf_tool *tool;
+	struct perf_sample *sample;
+	struct machine *machine;
+	const struct evsel *mmap_evsel;
+};
+
+static int mark_dso_hit_callback(struct callchain_cursor_node *node, void *data)
+{
+	struct mark_dso_hit_args *args = data;
+	struct map *map = node->ms.map;
+
+	return mark_dso_hit(args->bit, args->tool, args->sample, args->machine,
+			    args->mmap_evsel, map, /*sample_in_dso=*/false);
+}
+
+static int build_id_tool__sample(const struct perf_tool *tool, union perf_event *event,
+				 struct perf_sample *sample,
+				 struct evsel *evsel,
+				 struct machine *machine)
+{
+	struct build_id_tool *bit = container_of(tool, struct build_id_tool, dtool.tool);
+	struct addr_location al;
+	struct thread *thread;
+	struct mark_dso_hit_args args = {
+		.bit = bit,
+		.tool = tool,
+		.sample = sample,
+		.machine = machine,
+		.mmap_evsel = bit->mmap_evsel,
+	};
+
+	addr_location__init(&al);
+	thread = machine__findnew_thread(machine, sample->pid, sample->tid);
+	if (thread == NULL) {
+		pr_err("problem processing %d event, skipping it.\n",
+		       event->header.type);
+		goto repipe;
+	}
+
+	if (thread__find_map(thread, sample->cpumode, sample->ip, &al)) {
+		mark_dso_hit(bit, tool, sample, machine, args.mmap_evsel, al.map,
+			     /*sample_in_dso=*/true);
+	}
+
+	sample__for_each_callchain_node(thread, evsel, sample, PERF_MAX_STACK_DEPTH,
+					/*symbols=*/false, mark_dso_hit_callback, &args);
+
+	thread__put(thread);
+repipe:
+	addr_location__exit(&al);
+	return bit->dtool.delegate->sample(bit->dtool.delegate, event, sample, evsel, machine);
+}
+
+static int build_id_tool__common_mmap(const struct perf_tool *tool,
+				      union perf_event *event,
+				      struct perf_sample *sample,
+				      struct machine *machine,
+				      __u32 pid, __u32 tid,
+				      __u64 start, __u64 len, __u64 pgoff,
+				      __u32 flags, __u32 prot,
+				      const char *filename,
+				      const struct dso_id *dso_id)
+{
+	struct build_id_tool *bit = container_of(tool, struct build_id_tool, dtool.tool);
+	struct perf_tool *delegate = bit->dtool.delegate;
+	struct dso *dso = NULL;
+	bool dso_sought = false;
+	int err;
+
+	if (event->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID) {
+		dso = findnew_dso(pid, tid, filename, dso_id, machine);
+		dso_sought = true;
+		if (dso) {
+			/* mark it not to inject build-id */
+			dso__set_hit(dso);
+		}
+	}
+	if (bit->style == BID_RWS__INJECT_HEADER_ALL) {
+		if (!dso_sought) {
+			dso = findnew_dso(pid, tid, filename, dso_id, machine);
+			dso_sought = true;
+		}
+
+		if (dso && !dso__hit(dso)) {
+			struct evsel *evsel = (struct evsel *)bit->mmap_evsel;
+
+			if (evsel) {
+				dso__set_hit(dso);
+				build_id_tool__inject_build_id(tool, sample, machine, evsel,
+							       /*misc=*/sample->cpumode,
+							       filename, dso, flags);
+			}
+		}
+	} else {
+		/* Create the thread, map, etc. by calling delegate. */
+		if (event->header.type == PERF_RECORD_MMAP2)
+			err = delegate->mmap2(delegate, event, sample, machine);
+		else
+			err = delegate->mmap(delegate, event, sample, machine);
+
+		if (err) {
+			dso__put(dso);
+			return err;
+		}
+	}
+	if ((bit->style == BID_RWS__MMAP2_BUILDID_ALL) &&
+	    !(event->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID)) {
+		struct evsel *evsel = (struct evsel *)bit->mmap_evsel;
+
+		if (evsel && !dso_sought) {
+			dso = findnew_dso(pid, tid, filename, dso_id, machine);
+			dso_sought = true;
+		}
+		if (evsel && dso &&
+		    !tool__inject_mmap2_build_id(tool, sample, machine, evsel,
+						 sample->cpumode | PERF_RECORD_MISC_MMAP_BUILD_ID,
+						 pid, tid, start, len, pgoff,
+						 dso,
+						 prot, flags,
+						 filename)) {
+			/* Injected mmap2 so no need to repipe further. */
+			dso__put(dso);
+			return 0;
+		}
+	}
+	dso__put(dso);
+
+	if (bit->style == BID_RWS__INJECT_HEADER_ALL ||
+	    bit->style == BID_RWS__MMAP2_BUILDID_ALL) {
+		if (event->header.type == PERF_RECORD_MMAP2)
+			return delegate->mmap2(delegate, event, sample, machine);
+		else
+			return delegate->mmap(delegate, event, sample, machine);
+	}
+
+	return 0;
+}
+
+static int build_id_tool__mmap(const struct perf_tool *tool,
+			       union perf_event *event,
+			       struct perf_sample *sample,
+			       struct machine *machine)
+{
+	return build_id_tool__common_mmap(
+		tool, event, sample, machine,
+		event->mmap.pid, event->mmap.tid,
+		event->mmap.start, event->mmap.len, event->mmap.pgoff,
+		/*flags=*/0, PROT_EXEC,
+		event->mmap.filename, /*dso_id=*/NULL);
+}
+
+static int build_id_tool__mmap2(const struct perf_tool *tool,
+				union perf_event *event,
+				struct perf_sample *sample,
+				struct machine *machine)
+{
+	struct dso_id id = dso_id_empty;
+
+	if (event->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID) {
+		build_id__init(&id.build_id, event->mmap2.build_id, event->mmap2.build_id_size);
+	} else {
+		id.maj = event->mmap2.maj;
+		id.min = event->mmap2.min;
+		id.ino = event->mmap2.ino;
+		id.ino_generation = event->mmap2.ino_generation;
+		id.mmap2_valid = true;
+		id.mmap2_ino_generation_valid = true;
+	}
+
+	return build_id_tool__common_mmap(
+		tool, event, sample, machine,
+		event->mmap2.pid, event->mmap2.tid,
+		event->mmap2.start, event->mmap2.len, event->mmap2.pgoff,
+		event->mmap2.flags, event->mmap2.prot,
+		event->mmap2.filename, &id);
+}
+
+static int build_id_tool__finished_init(const struct perf_tool *tool,
+					struct perf_session *session,
+					union perf_event *event)
+{
+	struct build_id_tool *bit = container_of(tool, struct build_id_tool, dtool.tool);
+	struct evsel *pos;
+
+	evlist__for_each_entry(session->evlist, pos) {
+		if (pos->core.attr.mmap) {
+			bit->mmap_evsel = pos;
+			break;
+		}
+	}
+
+	return bit->dtool.delegate->finished_init(bit->dtool.delegate, session, event);
+}
+
+struct build_id_tool *build_id_tool__new(enum build_id_rewrite_style style,
+					 const char *known_build_ids_string,
+					 struct perf_tool *delegate)
+{
+	struct build_id_tool *bit = zalloc(sizeof(*bit));
+
+	if (!bit)
+		return NULL;
+
+	delegate_tool__init(&bit->dtool, delegate);
+	bit->style = style;
+	if (known_build_ids_string) {
+		bit->known_build_ids = build_id_tool__parse_known_build_ids(known_build_ids_string);
+		if (!bit->known_build_ids) {
+			free(bit);
+			return NULL;
+		}
+	}
+
+	if (style == BID_RWS__INJECT_HEADER_LAZY ||
+	    style == BID_RWS__MMAP2_BUILDID_LAZY) {
+		bit->dtool.tool.sample = build_id_tool__sample;
+		/*
+		 * to make sure the mmap records are ordered correctly
+		 * and so that the correct especially due to jitted code
+		 * mmaps. We cannot generate the buildid hit list and
+		 * inject the jit mmaps at the same time for now.
+		 */
+		bit->dtool.tool.ordering_requires_timestamps = true;
+	}
+
+	if (style != BID_RWS__NONE) {
+		bit->dtool.tool.mmap = build_id_tool__mmap;
+		bit->dtool.tool.mmap2 = build_id_tool__mmap2;
+		bit->dtool.tool.finished_init = build_id_tool__finished_init;
+	}
+
+	return bit;
+}
+
+void build_id_tool__delete(struct build_id_tool *bit)
+{
+	if (bit) {
+		strlist__delete(bit->known_build_ids);
+		free(bit);
+	}
+}
diff --git a/tools/perf/util/build_id_tool.h b/tools/perf/util/build_id_tool.h
new file mode 100644
index 000000000000..38a880e0a595
--- /dev/null
+++ b/tools/perf/util/build_id_tool.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_BUILD_ID_TOOL_H
+#define __PERF_BUILD_ID_TOOL_H
+
+#include "tool.h"
+
+struct strlist;
+struct evsel;
+
+enum build_id_rewrite_style {
+	BID_RWS__NONE = 0,
+	BID_RWS__INJECT_HEADER_LAZY,
+	BID_RWS__INJECT_HEADER_ALL,
+	BID_RWS__MMAP2_BUILDID_ALL,
+	BID_RWS__MMAP2_BUILDID_LAZY,
+};
+
+struct build_id_tool {
+	struct delegate_tool dtool;
+	enum build_id_rewrite_style style;
+	struct strlist *known_build_ids;
+	const struct evsel *mmap_evsel;
+};
+
+struct build_id_tool *build_id_tool__new(enum build_id_rewrite_style style,
+					 const char *known_build_ids_string,
+					 struct perf_tool *delegate);
+
+void build_id_tool__delete(struct build_id_tool *bit);
+
+#endif /* __PERF_BUILD_ID_TOOL_H */
-- 
2.53.0.959.g497ff81fa9-goog

