Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tuX7o+t7"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BBB1709
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Dec 2023 17:17:49 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d67fc68a82so1627907b3.2
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Dec 2023 17:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701911869; x=1702516669; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3o96R63h4tW+QyyZZjx6MH+ZM3C6AiBinWxkS0w0I9s=;
        b=tuX7o+t72YJGCKVUcUGeCW35uDhnwPXNbY23vmltyo64hrqXI3iu3kK5Mmbp6F2A+6
         7eX+YTw5x6TmjAPj9x7XFm3me7K9P2LwWIq7hc9LOjCxViyElwIAO+YkfhGB+XQe4qPa
         GUhTQ2J5CSIjaUl6tTDC8snSjwuEVa1EoxGNI/hsL687epJyFvKaWy/iIGQXmKBLnKMz
         xuO7QDvUZfUjxmf7JTNFH+piSzYmsxA8/JzYS11MCQnSI25a0ecu2ksKvhLHb2YeAWbe
         /PTL7a/LS2VWt8AvQK5ho1DCI76LpkVVn3Vhhm5qtObMjzlKDudwR0k6U5cUNVpcygMO
         7l+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701911869; x=1702516669;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3o96R63h4tW+QyyZZjx6MH+ZM3C6AiBinWxkS0w0I9s=;
        b=vYgYlo0RwXZJLRKtso6VUVia5pNwBVJLW7lifzCsLxUkns6It8Ux/s0XQLLZmTHrIp
         7eeZrDtLEOjFSQZahGxO1dM0a8Ytj4URUS3GLzkanTH7JG6Xo2ot+1aXuG8B5nB+jMUe
         4n3CneJPgThE8+aU88ISFtjLo3a/P615li1uPVV+U5vxUmLwUzJjF12cjW92J2NgTtA4
         u5uy7i4AxWTsiXk/Uu0vU5ZScoBqG2ZqKaGxOWnGuFmyqervO5fUs/k59m0fbbihFu03
         CAUSpzJZkxfLldLZjoVO4o1Narsv/1S8DVJh0QvtHBjiTHfyB26/APYhIpVnQOLLqUCY
         86yQ==
X-Gm-Message-State: AOJu0YzzxiSgdJ56NeFMLC2nkwIhv1wFm4utmbjBaLhEIrKKPbCIHOj9
	aO3m+Hy8waKLBSU1lshtbo3kuXXb3xsQ
X-Google-Smtp-Source: AGHT+IEldmR3/X81EpZlxZMbgINR4XFgb3uPK8wJLVSwf1670CHlBeFUHwbRDDtLnNjPUaqRivWe4dYfxrO5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a81:be16:0:b0:5ca:20f3:ca21 with SMTP id
 i22-20020a81be16000000b005ca20f3ca21mr31031ywn.1.1701911868933; Wed, 06 Dec
 2023 17:17:48 -0800 (PST)
Date: Wed,  6 Dec 2023 17:16:43 -0800
In-Reply-To: <20231207011722.1220634-1-irogers@google.com>
Message-Id: <20231207011722.1220634-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231207011722.1220634-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v6 09/47] perf synthetic-events: Use function to add missing
 maps lock
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Liam Howlett <liam.howlett@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Colin Ian King <colin.i.king@gmail.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Ming Wang <wangming01@loongson.cn>, 
	James Clark <james.clark@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Leo Yan <leo.yan@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, 
	Changbin Du <changbin.du@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>, 
	Sandipan Das <sandipan.das@amd.com>, liuwenyu <liuwenyu7@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"

Switch perf_event__synthesize_modules from loop macro
maps__for_each_entry to maps__for_each_map function that takes
a callback. The function holds the maps lock, which should be
held during iteration.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/synthetic-events.c | 118 ++++++++++++++++-------------
 1 file changed, 67 insertions(+), 51 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index a0579c7d7b9e..3712186353fb 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -665,18 +665,74 @@ int perf_event__synthesize_cgroups(struct perf_tool *tool __maybe_unused,
 }
 #endif
 
+struct perf_event__synthesize_modules_maps_cb_args {
+	struct perf_tool *tool;
+	perf_event__handler_t process;
+	struct machine *machine;
+	union perf_event *event;
+};
+
+static int perf_event__synthesize_modules_maps_cb(struct map *map, void *data)
+{
+	struct perf_event__synthesize_modules_maps_cb_args *args = data;
+	union perf_event *event = args->event;
+	struct dso *dso;
+	size_t size;
+
+	if (!__map__is_kmodule(map))
+		return 0;
+
+	dso = map__dso(map);
+	if (symbol_conf.buildid_mmap2) {
+		size = PERF_ALIGN(dso->long_name_len + 1, sizeof(u64));
+		event->mmap2.header.type = PERF_RECORD_MMAP2;
+		event->mmap2.header.size = (sizeof(event->mmap2) -
+					(sizeof(event->mmap2.filename) - size));
+		memset(event->mmap2.filename + size, 0, args->machine->id_hdr_size);
+		event->mmap2.header.size += args->machine->id_hdr_size;
+		event->mmap2.start = map__start(map);
+		event->mmap2.len   = map__size(map);
+		event->mmap2.pid   = args->machine->pid;
+
+		memcpy(event->mmap2.filename, dso->long_name, dso->long_name_len + 1);
+
+		perf_record_mmap2__read_build_id(&event->mmap2, args->machine, false);
+	} else {
+		size = PERF_ALIGN(dso->long_name_len + 1, sizeof(u64));
+		event->mmap.header.type = PERF_RECORD_MMAP;
+		event->mmap.header.size = (sizeof(event->mmap) -
+					(sizeof(event->mmap.filename) - size));
+		memset(event->mmap.filename + size, 0, args->machine->id_hdr_size);
+		event->mmap.header.size += args->machine->id_hdr_size;
+		event->mmap.start = map__start(map);
+		event->mmap.len   = map__size(map);
+		event->mmap.pid   = args->machine->pid;
+
+		memcpy(event->mmap.filename, dso->long_name, dso->long_name_len + 1);
+	}
+
+	if (perf_tool__process_synth_event(args->tool, event, args->machine, args->process) != 0)
+		return -1;
+
+	return 0;
+}
+
 int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t process,
 				   struct machine *machine)
 {
-	int rc = 0;
-	struct map_rb_node *pos;
+	int rc;
 	struct maps *maps = machine__kernel_maps(machine);
-	union perf_event *event;
-	size_t size = symbol_conf.buildid_mmap2 ?
-			sizeof(event->mmap2) : sizeof(event->mmap);
+	struct perf_event__synthesize_modules_maps_cb_args args = {
+		.tool = tool,
+		.process = process,
+		.machine = machine,
+	};
+	size_t size = symbol_conf.buildid_mmap2
+		? sizeof(args.event->mmap2)
+		: sizeof(args.event->mmap);
 
-	event = zalloc(size + machine->id_hdr_size);
-	if (event == NULL) {
+	args.event = zalloc(size + machine->id_hdr_size);
+	if (args.event == NULL) {
 		pr_debug("Not enough memory synthesizing mmap event "
 			 "for kernel modules\n");
 		return -1;
@@ -687,53 +743,13 @@ int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t
 	 * __perf_event_mmap
 	 */
 	if (machine__is_host(machine))
-		event->header.misc = PERF_RECORD_MISC_KERNEL;
+		args.event->header.misc = PERF_RECORD_MISC_KERNEL;
 	else
-		event->header.misc = PERF_RECORD_MISC_GUEST_KERNEL;
-
-	maps__for_each_entry(maps, pos) {
-		struct map *map = pos->map;
-		struct dso *dso;
+		args.event->header.misc = PERF_RECORD_MISC_GUEST_KERNEL;
 
-		if (!__map__is_kmodule(map))
-			continue;
+	rc = maps__for_each_map(maps, perf_event__synthesize_modules_maps_cb, &args);
 
-		dso = map__dso(map);
-		if (symbol_conf.buildid_mmap2) {
-			size = PERF_ALIGN(dso->long_name_len + 1, sizeof(u64));
-			event->mmap2.header.type = PERF_RECORD_MMAP2;
-			event->mmap2.header.size = (sizeof(event->mmap2) -
-						(sizeof(event->mmap2.filename) - size));
-			memset(event->mmap2.filename + size, 0, machine->id_hdr_size);
-			event->mmap2.header.size += machine->id_hdr_size;
-			event->mmap2.start = map__start(map);
-			event->mmap2.len   = map__size(map);
-			event->mmap2.pid   = machine->pid;
-
-			memcpy(event->mmap2.filename, dso->long_name, dso->long_name_len + 1);
-
-			perf_record_mmap2__read_build_id(&event->mmap2, machine, false);
-		} else {
-			size = PERF_ALIGN(dso->long_name_len + 1, sizeof(u64));
-			event->mmap.header.type = PERF_RECORD_MMAP;
-			event->mmap.header.size = (sizeof(event->mmap) -
-						(sizeof(event->mmap.filename) - size));
-			memset(event->mmap.filename + size, 0, machine->id_hdr_size);
-			event->mmap.header.size += machine->id_hdr_size;
-			event->mmap.start = map__start(map);
-			event->mmap.len   = map__size(map);
-			event->mmap.pid   = machine->pid;
-
-			memcpy(event->mmap.filename, dso->long_name, dso->long_name_len + 1);
-		}
-
-		if (perf_tool__process_synth_event(tool, event, machine, process) != 0) {
-			rc = -1;
-			break;
-		}
-	}
-
-	free(event);
+	free(args.event);
 	return rc;
 }
 
-- 
2.43.0.rc2.451.g8631bc7472-goog

