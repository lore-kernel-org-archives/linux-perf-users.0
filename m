Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFBD1474B2
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Aug 2024 06:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723877127; cv=none; b=hrAjEtUyr6Oa+8dSp3Zz72WG9fldmIjzkDwxihfuIjt/2HOdP9QJXVqePHr+4F02LxG3JH00AWVaGevfwRGqtBP7E0FzSwNYeDWBe750U2+KPfpoBHqNiNpRTTIh/vH6pfA3eVEUQrKunIyaDfr0/dJSSM8y+K9TDQkpU/gAnS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723877127; c=relaxed/simple;
	bh=4zMaRa9g/3QhnnPegvdyD6R5WG7LgxkQaz3wvOp74c0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ZrIyk1VbFj6PpQLBd14NpB1KoHqr5nVJtI37ZMJ5/tLNgpYrVTXkShzPo6h08wQa5lsM7Ed6eUz64fesZkQNP1LrV9T4Qu256xCLGM0/j5ARSL+6sZnXY2ZxaJ80LtYkRhqRxR3EEwev2FFZ5oVlxfmii7OdPiGIynOZqHCJYPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DjKTHVN/; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DjKTHVN/"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-690404fd230so45635567b3.3
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Aug 2024 23:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723877124; x=1724481924; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=limJFhYtfcwn5BoDQ5nprHbguRK6HBwBTzbehLiX19U=;
        b=DjKTHVN/Rz6FvkcWho8/AMwWLBhM62IHI8mJdcgrvTPJafKSg1OfUGVyq9E82rchQf
         qWWq9CFUksmpteA+rOMrJR+KfJwTwscFi619mfmwvyzvDZWw2PIl3kNmJWWh73mf8Nfb
         /QQnSTjfy2C+UvTV25fuDlI0cyjhJNk15plMKX6cHbW7y/byVEbvlaTjj4oTTzMDjr7G
         k0y9FhuSnj+swnoaz9oWO8jBZoR0T9F0TF1wfZeyb+iJMawvfCtbs6PxDIGLeBIhcGw/
         Gjvvo4tPMwUgCo/dhNiSQrLAxiqUMA7fKzC5w9TGM2oqCw7JQLaB/58JrEaoogpm6OEg
         QI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723877124; x=1724481924;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=limJFhYtfcwn5BoDQ5nprHbguRK6HBwBTzbehLiX19U=;
        b=VWHMFURfX1QQGy7RUSvEkS8ss529a2VCF5eKDrif1LwD0dq0RLqilPMvTunIObZQht
         vPK1neXnrizxYgGbLgeXmKBS+dClTTxS+RGd/CxX+Fr8wk2x0sv2YDdgDVhwelvoCUn3
         KtQf1kA4gn+1VGbHcFrKvmYRxwjNXCtzd6ihmJseLddzTOseKvvm6bEEw5rjlw9DqOiX
         /fdbsyrTzCOac38FIfCvdFu7TjOUPILvDRUNVD4C1gbyG5vw3Vsefa+9cYbOcTQKOA3p
         fzfk+qW6lyhNLxquX7H3wYpXXl7hvj4Pi4/vOLpmfNd7X3I9jHoEGPORxcu9ikzrhn5D
         cCWQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4ScS7GbFI3vd4wuNWglOAElU4H2lESCuF1oANJK3dTZnXzRUdxAb5WvVenBW8a8VTTR+P+fvLu6TbAzcMf72CUb7oRuQFXeEEXYukdIvA0g==
X-Gm-Message-State: AOJu0YxOjxsvxVDsCKOl0vITsOK8zZgqbzLCWh/LWibzG72qYIW4H/TF
	vk8MA2BVQXrUc90E0rGA8hRC95fYmxL3TwT+uBePONr7ATPsukeZLP+0mg+uxqlYz1fV+cW4Ygk
	Q/PD9ZA==
X-Google-Smtp-Source: AGHT+IEPiNa/qXZIt6ptn3zb83g/dXuvDVY4QxjK7uEvC8k1JxADUoMklonPkghHC6QCr9hBOAcIijNYfqge
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:78c9:5e58:734f:c59f])
 (user=irogers job=sendgmr) by 2002:a5b:4cb:0:b0:e11:7a38:8883 with SMTP id
 3f1490d57ef6-e1180f71f9dmr8127276.7.1723877124512; Fri, 16 Aug 2024 23:45:24
 -0700 (PDT)
Date: Fri, 16 Aug 2024 23:44:39 -0700
In-Reply-To: <20240817064442.2152089-1-irogers@google.com>
Message-Id: <20240817064442.2152089-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240817064442.2152089-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Subject: [PATCH v1 10/13] perf inject: Fix build ID injection
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Casey Chen <cachen@purestorage.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Yunseong Kim <yskelg@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Anne Macedo <retpolanne@posteo.net>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Build ID injection wasn't inserting a sample ID and aligning events to
64 bytes rather than 8. No sample ID means events are unordered and
two different build_id events for the same path, as happens when a
file is replaced, can't be differentiated.

Add in sample ID insertion for the build_id events alongside some
refactoring. The refactoring better aligns the function arguments for
different use cases, such as synthesizing build_id events without
needing to have a dso. The misc bits are explicitly passed as with
callchains the maps/dsos may span user and kernel land, so using
sample->cpumode isn't good enough.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c        | 170 ++++++++++++++++++++++-------
 tools/perf/util/build-id.c         |   6 +-
 tools/perf/util/synthetic-events.c |  44 ++++++--
 tools/perf/util/synthetic-events.h |  10 +-
 4 files changed, 175 insertions(+), 55 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index a7c859db2e15..84a4bdb5cb0a 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -131,6 +131,7 @@ struct perf_inject {
 	struct perf_file_section secs[HEADER_FEAT_BITS];
 	struct guest_session	guest_session;
 	struct strlist		*known_build_ids;
+	const struct evsel	*mmap_evsel;
 };
 
 struct event_entry {
@@ -139,8 +140,13 @@ struct event_entry {
 	union perf_event event[];
 };
 
-static int dso__inject_build_id(struct dso *dso, const struct perf_tool *tool,
-				struct machine *machine, u8 cpumode, u32 flags);
+static int dso__inject_build_id(const struct perf_tool *tool,
+				struct perf_sample *sample,
+				struct machine *machine,
+				const struct evsel *evsel,
+				__u16 misc,
+				const char *filename,
+				struct dso *dso, u32 flags);
 
 static int output_bytes(struct perf_inject *inject, void *buf, size_t sz)
 {
@@ -422,6 +428,28 @@ static struct dso *findnew_dso(int pid, int tid, const char *filename,
 	return dso;
 }
 
+/*
+ * The evsel used for the sample ID for mmap events. Typically stashed when
+ * processing mmap events. If not stashed, search the evlist for the first mmap
+ * gathering event.
+ */
+static const struct evsel *inject__mmap_evsel(struct perf_inject *inject)
+{
+	struct evsel *pos;
+
+	if (inject->mmap_evsel)
+		return inject->mmap_evsel;
+
+	evlist__for_each_entry(inject->session->evlist, pos) {
+		if (pos->core.attr.mmap) {
+			inject->mmap_evsel = pos;
+			return pos;
+		}
+	}
+	pr_err("No mmap events found\n");
+	return NULL;
+}
+
 static int perf_event__repipe_common_mmap(const struct perf_tool *tool,
 					  union perf_event *event,
 					  struct perf_sample *sample,
@@ -469,12 +497,28 @@ static int perf_event__repipe_common_mmap(const struct perf_tool *tool,
 		}
 
 		if (dso && !dso__hit(dso)) {
-			dso__set_hit(dso);
-			dso__inject_build_id(dso, tool, machine, sample->cpumode, flags);
+			struct evsel *evsel = evlist__event2evsel(inject->session->evlist, event);
+
+			if (evsel) {
+				dso__set_hit(dso);
+				dso__inject_build_id(tool, sample, machine, evsel,
+						     /*misc=*/sample->cpumode,
+						     filename, dso, flags);
+			}
 		}
 	} else {
+		int err;
+
+		/*
+		 * Remember the evsel for lazy build id generation. It is used
+		 * for the sample id header type.
+		 */
+		if (inject->build_id_style == BID_RWS__INJECT_HEADER_LAZY &&
+		    !inject->mmap_evsel)
+			inject->mmap_evsel = evlist__event2evsel(inject->session->evlist, event);
+
 		/* Create the thread, map, etc. Not done for the unordered inject all case. */
-		int err = perf_event_process(tool, event, sample, machine);
+		err = perf_event_process(tool, event, sample, machine);
 
 		if (err) {
 			dso__put(dso);
@@ -667,16 +711,20 @@ static bool perf_inject__lookup_known_build_id(struct perf_inject *inject,
 	return false;
 }
 
-static int dso__inject_build_id(struct dso *dso, const struct perf_tool *tool,
-				struct machine *machine, u8 cpumode, u32 flags)
+static int dso__inject_build_id(const struct perf_tool *tool,
+				struct perf_sample *sample,
+				struct machine *machine,
+				const struct evsel *evsel,
+				__u16 misc,
+				const char *filename,
+				struct dso *dso, u32 flags)
 {
-	struct perf_inject *inject = container_of(tool, struct perf_inject,
-						  tool);
+	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
 	int err;
 
-	if (is_anon_memory(dso__long_name(dso)) || flags & MAP_HUGETLB)
+	if (is_anon_memory(filename) || flags & MAP_HUGETLB)
 		return 0;
-	if (is_no_dso_memory(dso__long_name(dso)))
+	if (is_no_dso_memory(filename))
 		return 0;
 
 	if (inject->known_build_ids != NULL &&
@@ -684,24 +732,65 @@ static int dso__inject_build_id(struct dso *dso, const struct perf_tool *tool,
 		return 1;
 
 	if (dso__read_build_id(dso) < 0) {
-		pr_debug("no build_id found for %s\n", dso__long_name(dso));
+		pr_debug("no build_id found for %s\n", filename);
 		return -1;
 	}
 
-	err = perf_event__synthesize_build_id(tool, dso, cpumode,
-					      perf_event__repipe, machine);
+	err = perf_event__synthesize_build_id(tool, sample, machine,
+					      perf_event__repipe,
+					      evsel, misc, dso__bid(dso),
+					      filename);
 	if (err) {
-		pr_err("Can't synthesize build_id event for %s\n", dso__long_name(dso));
+		pr_err("Can't synthesize build_id event for %s\n", filename);
 		return -1;
 	}
 
 	return 0;
 }
 
+static int mark_dso_hit(const struct perf_tool *tool,
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
+	if (dso && !dso__hit(dso)) {
+		dso__set_hit(dso);
+		dso__inject_build_id(tool, sample, machine,
+				mmap_evsel, misc, dso__long_name(dso), dso,
+				map__flags(map));
+	}
+	return 0;
+}
+
 struct mark_dso_hit_args {
 	const struct perf_tool *tool;
+	struct perf_sample *sample;
 	struct machine *machine;
-	u8 cpumode;
+	const struct evsel *mmap_evsel;
 };
 
 static int mark_dso_hit_callback(struct callchain_cursor_node *node, void *data)
@@ -709,16 +798,8 @@ static int mark_dso_hit_callback(struct callchain_cursor_node *node, void *data)
 	struct mark_dso_hit_args *args = data;
 	struct map *map = node->ms.map;
 
-	if (map) {
-		struct dso *dso = map__dso(map);
-
-		if (dso && !dso__hit(dso)) {
-			dso__set_hit(dso);
-			dso__inject_build_id(dso, args->tool, args->machine,
-					     args->cpumode, map__flags(map));
-		}
-	}
-	return 0;
+	return mark_dso_hit(args->tool, args->sample, args->machine,
+			    args->mmap_evsel, map, /*sample_in_dso=*/false);
 }
 
 int perf_event__inject_buildid(const struct perf_tool *tool, union perf_event *event,
@@ -728,10 +809,16 @@ int perf_event__inject_buildid(const struct perf_tool *tool, union perf_event *e
 {
 	struct addr_location al;
 	struct thread *thread;
+	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
 	struct mark_dso_hit_args args = {
 		.tool = tool,
+		/*
+		 * Use the parsed sample data of the sample event, which will
+		 * have a later timestamp than the mmap event.
+		 */
+		.sample = sample,
 		.machine = machine,
-		.cpumode = sample->cpumode,
+		.mmap_evsel = inject__mmap_evsel(inject),
 	};
 
 	addr_location__init(&al);
@@ -743,13 +830,8 @@ int perf_event__inject_buildid(const struct perf_tool *tool, union perf_event *e
 	}
 
 	if (thread__find_map(thread, sample->cpumode, sample->ip, &al)) {
-		struct dso *dso = map__dso(al.map);
-
-		if (!dso__hit(dso)) {
-			dso__set_hit(dso);
-			dso__inject_build_id(dso, tool, machine,
-					     sample->cpumode, map__flags(al.map));
-		}
+		mark_dso_hit(tool, sample, machine, args.mmap_evsel, al.map,
+			     /*sample_in_dso=*/true);
 	}
 
 	sample__for_each_callchain_node(thread, evsel, sample, PERF_MAX_STACK_DEPTH,
@@ -1159,17 +1241,27 @@ static int process_build_id(const struct perf_tool *tool,
 static int synthesize_build_id(struct perf_inject *inject, struct dso *dso, pid_t machine_pid)
 {
 	struct machine *machine = perf_session__findnew_machine(inject->session, machine_pid);
-	u8 cpumode = dso__is_in_kernel_space(dso) ?
-			PERF_RECORD_MISC_GUEST_KERNEL :
-			PERF_RECORD_MISC_GUEST_USER;
+	struct perf_sample synth_sample = {
+		.pid	   = -1,
+		.tid	   = -1,
+		.time	   = -1,
+		.stream_id = -1,
+		.cpu	   = -1,
+		.period	   = 1,
+		.cpumode   = dso__is_in_kernel_space(dso)
+		? PERF_RECORD_MISC_GUEST_KERNEL
+		: PERF_RECORD_MISC_GUEST_USER,
+	};
 
 	if (!machine)
 		return -ENOMEM;
 
 	dso__set_hit(dso);
 
-	return perf_event__synthesize_build_id(&inject->tool, dso, cpumode,
-					       process_build_id, machine);
+	return perf_event__synthesize_build_id(&inject->tool, &synth_sample, machine,
+					       process_build_id, inject__mmap_evsel(inject),
+					       /*misc=*/synth_sample.cpumode,
+					       dso__bid(dso), dso__long_name(dso));
 }
 
 static int guest_session__add_build_ids_cb(struct dso *dso, void *data)
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 451d145fa4ed..8982f68e7230 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -277,8 +277,8 @@ static int write_buildid(const char *name, size_t name_len, struct build_id *bid
 	struct perf_record_header_build_id b;
 	size_t len;
 
-	len = name_len + 1;
-	len = PERF_ALIGN(len, NAME_ALIGN);
+	len = sizeof(b) + name_len + 1;
+	len = PERF_ALIGN(len, sizeof(u64));
 
 	memset(&b, 0, sizeof(b));
 	memcpy(&b.data, bid->data, bid->size);
@@ -286,7 +286,7 @@ static int write_buildid(const char *name, size_t name_len, struct build_id *bid
 	misc |= PERF_RECORD_MISC_BUILD_ID_SIZE;
 	b.pid = pid;
 	b.header.misc = misc;
-	b.header.size = sizeof(b) + len;
+	b.header.size = len;
 
 	err = do_write(fd, &b, sizeof(b));
 	if (err < 0)
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 0a7f93ae76fb..6bb62e4e2d5d 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2225,28 +2225,48 @@ int perf_event__synthesize_tracing_data(const struct perf_tool *tool, int fd, st
 }
 #endif
 
-int perf_event__synthesize_build_id(const struct perf_tool *tool, struct dso *pos, u16 misc,
-				    perf_event__handler_t process, struct machine *machine)
+int perf_event__synthesize_build_id(const struct perf_tool *tool,
+				    struct perf_sample *sample,
+				    struct machine *machine,
+				    perf_event__handler_t process,
+				    const struct evsel *evsel,
+				    __u16 misc,
+				    const struct build_id *bid,
+				    const char *filename)
 {
 	union perf_event ev;
 	size_t len;
 
-	if (!dso__hit(pos))
-		return 0;
+	len = sizeof(ev.build_id) + strlen(filename) + 1;
+	len = PERF_ALIGN(len, sizeof(u64));
 
-	memset(&ev, 0, sizeof(ev));
+	memset(&ev, 0, len);
 
-	len = dso__long_name_len(pos) + 1;
-	len = PERF_ALIGN(len, NAME_ALIGN);
-	ev.build_id.size = min(dso__bid(pos)->size, sizeof(dso__bid(pos)->data));
-	memcpy(&ev.build_id.build_id, dso__bid(pos)->data, ev.build_id.size);
+	ev.build_id.size = min(bid->size, sizeof(ev.build_id.build_id));
+	memcpy(ev.build_id.build_id, bid->data, ev.build_id.size);
 	ev.build_id.header.type = PERF_RECORD_HEADER_BUILD_ID;
 	ev.build_id.header.misc = misc | PERF_RECORD_MISC_BUILD_ID_SIZE;
 	ev.build_id.pid = machine->pid;
-	ev.build_id.header.size = sizeof(ev.build_id) + len;
-	memcpy(&ev.build_id.filename, dso__long_name(pos), dso__long_name_len(pos));
+	ev.build_id.header.size = len;
+	strcpy(ev.build_id.filename, filename);
+
+	if (evsel) {
+		void *array = &ev;
+		int ret;
 
-	return process(tool, &ev, NULL, machine);
+		array += ev.header.size;
+		ret = perf_event__synthesize_id_sample(array, evsel->core.attr.sample_type, sample);
+		if (ret < 0)
+			return ret;
+
+		if (ret & 7) {
+			pr_err("Bad id sample size %d\n", ret);
+			return -EINVAL;
+		}
+
+		ev.header.size += ret;
+	}
+	return process(tool, &ev, sample, machine);
 }
 
 int perf_event__synthesize_stat_events(struct perf_stat_config *config, const struct perf_tool *tool,
diff --git a/tools/perf/util/synthetic-events.h b/tools/perf/util/synthetic-events.h
index 31df7653677f..795bf3e18396 100644
--- a/tools/perf/util/synthetic-events.h
+++ b/tools/perf/util/synthetic-events.h
@@ -9,6 +9,7 @@
 #include <perf/cpumap.h>
 
 struct auxtrace_record;
+struct build_id;
 struct dso;
 struct evlist;
 struct evsel;
@@ -45,7 +46,14 @@ typedef int (*perf_event__handler_t)(const struct perf_tool *tool, union perf_ev
 
 int perf_event__synthesize_attrs(const struct perf_tool *tool, struct evlist *evlist, perf_event__handler_t process);
 int perf_event__synthesize_attr(const struct perf_tool *tool, struct perf_event_attr *attr, u32 ids, u64 *id, perf_event__handler_t process);
-int perf_event__synthesize_build_id(const struct perf_tool *tool, struct dso *pos, u16 misc, perf_event__handler_t process, struct machine *machine);
+int perf_event__synthesize_build_id(const struct perf_tool *tool,
+				    struct perf_sample *sample,
+				    struct machine *machine,
+				    perf_event__handler_t process,
+				    const struct evsel *evsel,
+				    __u16 misc,
+				    const struct build_id *bid,
+				    const char *filename);
 int perf_event__synthesize_cpu_map(const struct perf_tool *tool, const struct perf_cpu_map *cpus, perf_event__handler_t process, struct machine *machine);
 int perf_event__synthesize_event_update_cpus(const struct perf_tool *tool, struct evsel *evsel, perf_event__handler_t process);
 int perf_event__synthesize_event_update_name(const struct perf_tool *tool, struct evsel *evsel, perf_event__handler_t process);
-- 
2.46.0.184.g6999bdac58-goog

