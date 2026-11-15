Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794749685;
	b=OWREp6Xse7S2gaLhGHWyXIN1dCdvIECahTkcHuZbzHcVyey8Z8526EQn56SC7qpG13JR
	 TqretMBZiWVtPU9uNImDYMQ8jblJ7AIq3q4NoQ3+FYk415OvHqLtTcZc4dOPKYZuOaNbd
	 fL42CgLSIel0H4Hg2MNEKD9Cl4wRLtVSzUEUhieYOAwQhMAhzw+i66xN/v+P7TeZ3Ts1j
	 U4ZFTVeZ9UKum5HeKYxpkzOqFt7vc/ZsJfBM5oVQzj8NiHuXJ3dZ9EnX/C7sfptV04qAv
	 qOpE6cIHVwYiBVasttY7TOCiR0bHAEIdChuy5ry1q/UJGio1/RAH40wfSflnfNDt1KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794749685;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=inrmVcpInsb4L/fSWAUM9L7yO1QRaFOAORmV9Vu2DP8=;
	b=hdRKCl2idgUrdgcPe+QCLylPMK4uBLSevXjPxg++YhLepECX3pC23kTeEihyrcYFE4aY
	 NfPg1WjB3zQBbTwRt8oh2HcdMgGXXbnzpf/022STj4vb9W5cYXSudpXPLbnwmQwdG7SnC
	 CI1qPE+ppFsz3euD/roYHxjEnFuDbp8VO0UEqX9qS6IA6ZYOD8w3VHvwsiime+g/sa/RD
	 coKqTwTtvhmd7n57Y4E8GqFNwvvlzB9VxB3DiEue0S43LfNMUztpYSVZnecFCw0Dwz0cf
	 HWhkt979I8THll+tM8e3TM7bNgQRT/EnA4Bgu48M77YOoc8WhksUZMqMlF4bYg+KrbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=MOOhJP4C;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40329606A334;
	Sun, 15 Nov 2026 13:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40329606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=MOOhJP4C
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 281CB153B;
	Sun, 15 Nov 2026 05:34:36 -0800 (PST)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D09F73F85F;
	Sun, 15 Nov 2026 05:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794749679; bh=nXaZ08av6Dgk2HJdSrddyWsHFa8Pcv/1VXkodIcb284=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MOOhJP4CrHTa8K2sBSzjsLhRRDuF7JY23zo9tFFRuDs3+pnGtkhSoKYQuj0uVARql
	 zGgVS8IirTv7RASLtSaKJ/6XiHjoYXIyPVHAwiq67fNzBxwTGmalpsx5mBvwQbNQ+3
	 Gk6FidnIvrxl4l8gU0+ijnr061umYtEEpzlKvRvw=
From: Leo Yan <leo.yan@arm.com>
Date: Sun, 15 Nov 2026 13:34:20 +0000
Subject: [PATCH 2/4] perf: Assemble split thread maps in script and stat
 report
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261115-perf_fix_large_threads-v1-2-69c9b86b9ae5@arm.com>
References: <20261115-perf_fix_large_threads-v1-0-69c9b86b9ae5@arm.com>
In-Reply-To: <20261115-perf_fix_large_threads-v1-0-69c9b86b9ae5@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Suyash Mahar <smahar@meta.com>, 
 Amir Ayupov <aaupov@fb.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794749674; l=7779;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=nXaZ08av6Dgk2HJdSrddyWsHFa8Pcv/1VXkodIcb284=;
 b=yiXWQEiIYQhwbhy/7a+a5lba5houF+Rp+cjKTWVmX8V+NXxRuNrnkkiIzcK/D+jCaFf8M3dLO
 nUtdeq3BI8jAg1d5gJwFY5h2T8dHvy/KEmbvf4E4SpWNxhSmn3z/in8
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

perf script and perf stat report accept only the first thread-map record
and ignore subsequent records. For split maps, this leaves per-thread
counters sized for only part of the map.

Add thread_map__append_event() to assemble records in order, and reuse
it for single-record construction. Free any command names copied by a
failed append.

Keep the map private until the final record arrives. Publish it to the
evlist and allocate counters once both the complete thread map and CPU
map are available. This avoids reallocating a map already shared with
the evlist.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/builtin-script.c  | 21 ++++++++++++++----
 tools/perf/builtin-stat.c    | 25 ++++++++++++++++------
 tools/perf/util/thread_map.c | 51 ++++++++++++++++++++++++++++++++++----------
 tools/perf/util/thread_map.h |  2 ++
 4 files changed, 77 insertions(+), 22 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index b6691ebb1b4eff14cabe99e4388368503af28a6b..e41925fb86b8d8acff5c85fb4951720fcb5dde0d 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -162,6 +162,7 @@ struct perf_script {
 	bool			show_cgroup_events;
 	bool			show_text_poke_events;
 	bool			allocated;
+	bool			threads_is_appending;
 	bool			per_event_dump;
 	bool			stitch_lbr;
 	struct evswitch		evswitch;
@@ -3416,6 +3417,10 @@ static int __cmd_script(struct perf_script *script)
 	}
 
 	ret = perf_session__process_events(script->session);
+	if (!ret && !session_done() && script->threads_is_appending) {
+		pr_err("Incomplete thread map: missing final record.\n");
+		ret = -EINVAL;
+	}
 
 	if (script->per_event_dump)
 		perf_script__exit_per_event_dump_stats(script);
@@ -3975,6 +3980,10 @@ static int set_maps(struct perf_script *script)
 {
 	struct evlist *evlist = script->session->evlist;
 
+	/* Appending can move the map, so share it only after the final record. */
+	if (script->threads_is_appending)
+		return 0;
+
 	if (!script->cpus || !script->threads)
 		return 0;
 
@@ -3996,18 +4005,22 @@ int process_thread_map_event(const struct perf_tool *tool,
 			     union perf_event *event)
 {
 	struct perf_script *script = container_of(tool, struct perf_script, tool);
+	int ret;
 
 	if (dump_trace)
 		perf_event__fprintf_thread_map(event, stdout);
 
-	if (script->threads) {
+	if (script->threads && !script->threads_is_appending) {
 		pr_warning("Extra thread map event, ignoring.\n");
 		return 0;
 	}
 
-	script->threads = thread_map__new_event(&event->thread_map);
-	if (!script->threads)
-		return -ENOMEM;
+	ret = thread_map__append_event(&script->threads, &event->thread_map);
+	if (ret)
+		return ret;
+
+	script->threads_is_appending =
+		event->header.misc & PERF_RECORD_MISC_THREAD_MAP_MORE;
 
 	return set_maps(script);
 }
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 37752d6bfef451e1e8e5ccdddfa741c2c6795882..19d120b64706563251cec000eb7706cd4ad5897d 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -147,6 +147,7 @@ struct perf_stat {
 	u64			 bytes_written;
 	struct perf_tool	 tool;
 	bool			 maps_allocated;
+	bool			 threads_is_appending;
 	struct perf_cpu_map	*cpus;
 	struct perf_thread_map *threads;
 	enum aggr_mode		 aggr_mode;
@@ -2280,6 +2281,10 @@ int process_stat_config_event(const struct perf_tool *tool,
 
 static int set_maps(struct perf_stat *st)
 {
+	/* Appending can move the map, so share it only after the final record. */
+	if (st->threads_is_appending)
+		return 0;
+
 	if (!st->cpus || !st->threads)
 		return 0;
 
@@ -2301,15 +2306,19 @@ int process_thread_map_event(const struct perf_tool *tool,
 			     union perf_event *event)
 {
 	struct perf_stat *st = container_of(tool, struct perf_stat, tool);
+	int ret;
 
-	if (st->threads) {
+	if (st->threads && !st->threads_is_appending) {
 		pr_warning("Extra thread map event, ignoring.\n");
 		return 0;
 	}
 
-	st->threads = thread_map__new_event(&event->thread_map);
-	if (!st->threads)
-		return -ENOMEM;
+	ret = thread_map__append_event(&st->threads, &event->thread_map);
+	if (ret)
+		return ret;
+
+	st->threads_is_appending =
+		event->header.misc & PERF_RECORD_MISC_THREAD_MAP_MORE;
 
 	return set_maps(st);
 }
@@ -2405,11 +2414,13 @@ static int __cmd_report(int argc, const char **argv)
 	evsel_list         = session->evlist;
 
 	ret = perf_session__process_events(session);
-	if (ret)
-		return ret;
+	if (!ret && !session_done() && perf_stat.threads_is_appending) {
+		pr_err("Incomplete thread map: missing final record.\n");
+		ret = -EINVAL;
+	}
 
 	perf_session__delete(session);
-	return 0;
+	return ret;
 }
 
 static void setup_system_wide(int forks)
diff --git a/tools/perf/util/thread_map.c b/tools/perf/util/thread_map.c
index 918ab318023205e48ccc18d9a0dd675c1b77f1ed..4b3e0cd022fb79635b914610f32cb0c9c161568f 100644
--- a/tools/perf/util/thread_map.c
+++ b/tools/perf/util/thread_map.c
@@ -336,28 +336,57 @@ void thread_map__read_comms(struct perf_thread_map *threads)
 		comm_init(threads, i);
 }
 
-static void thread_map__copy_event(struct perf_thread_map *threads,
-				   struct perf_record_thread_map *event)
+int thread_map__append_event(struct perf_thread_map **map,
+			    const struct perf_record_thread_map *event)
 {
-	unsigned i;
+	struct perf_thread_map *threads = *map;
+	bool new_map = !threads;
+	u64 old_nr = threads ? threads->nr : 0, nr, i;
 
-	threads->nr = (int) event->nr;
+	/*
+	 * Trust event->nr to describe chunks of a valid thread map, whose total
+	 * count and allocation size are representable without overflow.
+	 */
+	nr = old_nr + event->nr;
+
+	threads = perf_thread_map__realloc(threads, nr);
+	if (!threads)
+		return -ENOMEM;
+
+	if (new_map) {
+		threads->nr = 0;
+		refcount_set(&threads->refcnt, 1);
+	}
+	*map = threads;
 
 	for (i = 0; i < event->nr; i++) {
-		perf_thread_map__set_pid(threads, i, (pid_t) event->entries[i].pid);
-		threads->map[i].comm = strndup(event->entries[i].comm, 16);
+		u64 idx = old_nr + i;
+
+		perf_thread_map__set_pid(threads, idx,
+					 (pid_t) event->entries[i].pid);
+		threads->map[idx].comm = strndup(event->entries[i].comm,
+						 sizeof(event->entries[i].comm));
+		if (!threads->map[idx].comm)
+			goto out_free;
 	}
+	threads->nr = nr;
 
-	refcount_set(&threads->refcnt, 1);
+	return 0;
+
+out_free:
+	while (i--)
+		zfree(&threads->map[old_nr + i].comm);
+	return -ENOMEM;
 }
 
 struct perf_thread_map *thread_map__new_event(struct perf_record_thread_map *event)
 {
-	struct perf_thread_map *threads;
+	struct perf_thread_map *threads = NULL;
 
-	threads = thread_map__alloc(event->nr);
-	if (threads)
-		thread_map__copy_event(threads, event);
+	if (thread_map__append_event(&threads, event)) {
+		perf_thread_map__put(threads);
+		return NULL;
+	}
 
 	return threads;
 }
diff --git a/tools/perf/util/thread_map.h b/tools/perf/util/thread_map.h
index d700a22b7ae4663aca843baf80f7e5f522d6e607..7ddb9dd3fe9f2525cc7ba358bd6294a293cac910 100644
--- a/tools/perf/util/thread_map.h
+++ b/tools/perf/util/thread_map.h
@@ -13,6 +13,8 @@ struct perf_thread_map *thread_map__new_by_pid(pid_t pid);
 struct perf_thread_map *thread_map__new_by_tid(pid_t tid);
 struct perf_thread_map *thread_map__new(pid_t pid, pid_t tid);
 struct perf_thread_map *thread_map__new_event(struct perf_record_thread_map *event);
+int thread_map__append_event(struct perf_thread_map **map,
+			     const struct perf_record_thread_map *event);
 
 struct perf_thread_map *thread_map__new_str(const char *pid,
 		const char *tid, bool all_threads);

-- 
2.34.1

