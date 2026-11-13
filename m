Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794613075;
	b=1bdalZS75wfTcGzdP7eS4n35871429lMGiPqMV7unX7g8pJAjkA8DWY1ECx7C6jHoiCX
	 XPMXgrg2mhTYV/kMGpE+Zf/4eGINaPUiYMB9b8Iuet+sPDOugdg3jplkJ8IUP/8JS6HdV
	 5uiPbleNkSuJPmrNgGi0C3WN5DPrDhh69i4XetLLj7LENEBHkB74Wpk+66DQCDalF5coL
	 hA13rupTdNjyn70K7JaYg/Tm1TtmhhveYOMi98tYX4Tl5oiDKys6KLkUgKEN0+H144lNs
	 WGqQzsGxksNA0kufYa5bdfjc9Dxt4lXwYeOHKHqbm7jl5vJ4OqIAKj09TRBcpD+FAoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794613075;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=EF3k78RFStMhvXUVmDOidHVlPIqx7qqaQlnH52Xt8V4=;
	b=xYFoNImBGgXtNYJhcgd3P6sN237/RyJ3qP6uFk4EH7b1cOiLCrY3ygRP9Lw00YDcea9q
	 CFwO9x0MuuzjjObnIP4EbPbh3V6vCZNYP9rykT7DD7e9IYhJnmqv65ggqLJLsbgQKWlvP
	 RCBQ4waTNs2rYZThL1XS2FzVAMMWJd8bbPLZYBRYEvAC8F4VYsRBTkw4uPq883gSblaez
	 k+7/QMOznb+xpZZn4IfBClEa0deWTDdzPXJLuWaUQhj76RInV2C0JXtXmeGBOhWqw7++K
	 CU7TeCc7uI4DPBole0iL9ug5zD2kEcgnhpr3LSEN5NYt7hXTToT3HnfeWeh6UuJHvmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ooyRgQCQ;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8434660A2604
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 23:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8434660A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ooyRgQCQ
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ea71803effso13548305ad.3
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 15:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794613074; x=1795217874; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EF3k78RFStMhvXUVmDOidHVlPIqx7qqaQlnH52Xt8V4=;
        b=ooyRgQCQbrifA9uDRPIh9Bvo93jfOlm0/u3rs4NyTWcoj4DoP/ypEdeXnNypixtoLO
         /AslfOO9EChxlPurKCa2X36hFKsivrFnetvkZ5yUwCVAEdTCzUItHt6xxKrk0gsVrsJb
         P9NkPXEHGDsCEhhrGGP4/BgnnNCKtYL3Mo7xwTJMJyfXBNjt61gmXb8t3BunG4cwojFk
         MnOT0HijxuA4TiesRQr51mo1bAWMJbmqI8l3C1Y0zzvDfubPq+iwU4f1YFEa4VkEZfgR
         BpYGQ9H2UvllMumjjULYmzBQGFj1JlVFvtRl78iTJce4HIlwtHx7tnQuN4BYO0nWLDnh
         dybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794613074; x=1795217874;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EF3k78RFStMhvXUVmDOidHVlPIqx7qqaQlnH52Xt8V4=;
        b=pKbHfLrUqwkxtJykyHobqGeFUO06AEpaWPKEWaJ6kiKVxpi2oMCXYLks09xw/3bs1F
         N6ioRsVGLaY2XKsq/vXx0KOOGQFEyBtBZE+WLjtZbKgaoEb0Vtwa7iIGokWZ0VwnEvwX
         bQeBmN+UAuMFqJsTaX+kW4pQFroaZy7V2Ai0KdEhBiijbKG/tmsVTvzEtB49JZENE8Fu
         Cw9l0FuRzYWLpe7ojH1KZSRnUjwULjAqTuaO50U4fH3bSvOW6sPum4G17VdPFe5aG9SM
         xD1o2t4vVyKSYil+tMsV/SXhHeBuF5apG+CwaCwUm1cUxftMhyBAar7MJ2wIFuHiwM+j
         U2NQ==
X-Forwarded-Encrypted: i=1; AL+hErGWSrWIxm7E6B2QL0jmnL9OQk6UX8/WE928PilnUd+N1GljIPGVV1HwUJgTP+aALoa7PalQoVVg3Hd7esdzGoVt@vger.kernel.org
X-Gm-Message-State: APuU4Z/rujdYuRM7TcAVbZqZW3hrbol3N7vHRdsww8VJna6U3eKusPkA
	gFLcgN73zQW6/YRKCnDnticbddhDZSWP2X9N92AsVnv4Rj4gxOrwqFzreOLV7SgdYgCn5i/7Yrh
	yJp9Eabot2Q==
X-Received: from plbbj3.prod.google.com ([2002:a17:902:8503:b0:2eb:4f8a:98bd])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b47:b0:2e5:a355:56e4
 with SMTP id d9443c01a7336-2ee0dc93fb2mr35011945ad.11.1794613073503; Fri, 13
 Nov 2026 15:37:53 -0800 (PST)
Date: Fri, 13 Nov 2026 15:37:39 -0800
In-Reply-To: <20261113233739.3626499-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113233739.3626499-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113233739.3626499-5-irogers@google.com>
Subject: [PATCH v2 4/4] perf test tool_pmu: Add memory, network and schedstat tests
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Extend the Tool PMU unit test suite with subtests covering:
- Per-process, multi-threaded Tgid deduplication, and system-wide reading
  of memory events (smaps_rollup and statm).
- Per-process open rejection (-EINVAL) and synthetic /proc/net/dev
  parsing (including space-padded and unpadded columns) across
  enable/disable transitions for network events.
- Per-process open rejection (-EINVAL) and per-CPU synthetic
  /proc/schedstat delta accumulation across enable/disable transitions
  for schedstat events.
- Mixed CPU-map tool groups ({schedstat_yield,net_rx_bytes} and
  {net_rx_bytes,schedstat_yield}) across evlist__enable() and
  evlist__disable().

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/tool_pmu.c | 689 ++++++++++++++++++++++++++++++++++++
 1 file changed, 689 insertions(+)

diff --git a/tools/perf/tests/tool_pmu.c b/tools/perf/tests/tool_pmu.c
index 667160f9e2cd..783aa13abe40 100644
--- a/tools/perf/tests/tool_pmu.c
+++ b/tools/perf/tests/tool_pmu.c
@@ -1,14 +1,20 @@
 // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 #include <errno.h>
 #include <fcntl.h>
+#include <pthread.h>
+#include <stdio.h>
+#include <stdlib.h>
 #include <string.h>
+#include <sys/types.h>
 #include <unistd.h>
 #include <internal/xyarray.h>
+#include "counts.h"
 #include "cpumap.h"
 #include "debug.h"
 #include "evlist.h"
 #include "evsel.h"
 #include "parse-events.h"
+#include "target.h"
 #include "tests.h"
 #include "thread_map.h"
 #include "tool_pmu.h"
@@ -178,10 +184,693 @@ static int test__tool_pmu_incremental_open_unwind(struct test_suite *test __mayb
 	return ret;
 }
 
+static int write_temp_file(int fd, const char *contents)
+{
+	size_t len = strlen(contents);
+
+	if (ftruncate(fd, 0) < 0)
+		return -1;
+	if (lseek(fd, 0, SEEK_SET) < 0)
+		return -1;
+	if ((size_t)write(fd, contents, len) != len)
+		return -1;
+	return 0;
+}
+
+struct sleeper_thread_args {
+	int ready_fd;
+	int stop_fd;
+};
+
+static void *sleeper_thread_fn(void *arg)
+{
+	struct sleeper_thread_args *args = arg;
+	char ch = '1';
+
+	if (write(args->ready_fd, &ch, 1) == 1) {
+		while (read(args->stop_fd, &ch, 1) < 0 && errno == EINTR)
+			;
+	}
+	return NULL;
+}
+
+static int check_multithread_memory_dedup(struct perf_cpu_map *cpus)
+{
+	struct evlist *evlist = NULL;
+	struct perf_thread_map *mt_threads = NULL;
+	struct parse_events_error err;
+	struct sleeper_thread_args args;
+	struct evsel *evsel;
+	int ready_pipe[2] = { -1, -1 }, stop_pipe[2] = { -1, -1 };
+	pthread_t th;
+	bool th_started = false;
+	int nthreads, non_zero = 0, ret = TEST_FAIL;
+	u64 total_rss = 0;
+	char ch;
+
+	if (pipe(ready_pipe) < 0 || pipe(stop_pipe) < 0)
+		goto out;
+
+	args.ready_fd = ready_pipe[1];
+	args.stop_fd = stop_pipe[0];
+	if (pthread_create(&th, NULL, sleeper_thread_fn, &args) != 0)
+		goto out;
+	th_started = true;
+
+	if (read(ready_pipe[0], &ch, 1) != 1)
+		goto out;
+
+	mt_threads = thread_map__new_by_pid(getpid());
+	nthreads = perf_thread_map__nr(mt_threads);
+	if (!mt_threads || nthreads < 2) {
+		pr_debug("Expected >= 2 threads for getpid(), got %d\n", nthreads);
+		goto out;
+	}
+
+	evlist = evlist__new();
+	if (!evlist)
+		goto out;
+
+	parse_events_error__init(&err);
+	if (parse_events(evlist, "memory_rss", &err)) {
+		parse_events_error__exit(&err);
+		goto out;
+	}
+	parse_events_error__exit(&err);
+
+	perf_evlist__set_maps(evlist__core(evlist), cpus, mt_threads);
+	evsel = evlist__first(evlist);
+	if (evsel__alloc_counts(evsel) < 0 ||
+	    evsel__open(evsel, cpus, mt_threads) < 0)
+		goto out;
+
+	for (int t = 0; t < nthreads; t++) {
+		u64 val;
+
+		if (evsel__read_counter(evsel, 0, t) < 0)
+			goto out;
+		val = perf_counts(evsel->counts, 0, t)->val;
+		if (val > 0)
+			non_zero++;
+		total_rss += val;
+	}
+
+	if (non_zero != 1 || total_rss == 0) {
+		pr_debug("Expected 1 non-zero thread slot for memory_rss, got %d (sum=%llu)\n",
+			 non_zero, (unsigned long long)total_rss);
+		goto out;
+	}
+
+	ret = TEST_OK;
+out:
+	if (stop_pipe[1] >= 0) {
+		close(stop_pipe[1]);
+		stop_pipe[1] = -1;
+	}
+	if (th_started)
+		pthread_join(th, NULL);
+	if (ready_pipe[0] >= 0)
+		close(ready_pipe[0]);
+	if (ready_pipe[1] >= 0)
+		close(ready_pipe[1]);
+	if (stop_pipe[0] >= 0)
+		close(stop_pipe[0]);
+	if (evlist) {
+		evlist__for_each_entry(evlist, evsel)
+			evsel__close(evsel);
+		evlist__put(evlist);
+	}
+	perf_thread_map__put(mt_threads);
+	return ret;
+}
+
+static int test__tool_pmu_memory_events(struct test_suite *test __maybe_unused,
+					int subtest __maybe_unused)
+{
+	struct evlist *evlist = evlist__new();
+	struct parse_events_error err;
+	struct perf_cpu_map *cpus = NULL;
+	struct perf_thread_map *threads = NULL, *sys_threads = NULL;
+	struct evsel *evsel;
+	u64 pid_rss = 0, pid_uss = 0, pid_size = 0, pid_text = 0, pid_data = 0;
+	u64 sys_size = 0;
+	const char *events =
+		"memory_rss,memory_uss,memory_size,memory_text,memory_data";
+	int ret = TEST_FAIL;
+
+	if (!evlist)
+		return TEST_FAIL;
+
+	parse_events_error__init(&err);
+	if (parse_events(evlist, events, &err)) {
+		parse_events_error__exit(&err);
+		evlist__put(evlist);
+		return TEST_FAIL;
+	}
+	parse_events_error__exit(&err);
+
+	cpus = perf_cpu_map__new_int(0);
+	threads = thread_map__new_by_tid(getpid());
+	if (!cpus || !threads)
+		goto out;
+	perf_evlist__set_maps(evlist__core(evlist), cpus, threads);
+
+	evlist__for_each_entry(evlist, evsel) {
+		enum tool_pmu_event ev = evsel__tool_event(evsel);
+		struct perf_counts_values *count;
+
+		if (evsel__alloc_counts(evsel) < 0)
+			goto out;
+		if (evsel__open(evsel, cpus, threads) < 0) {
+			pr_debug("Failed to open %s per-process\n", evsel__name(evsel));
+			goto out;
+		}
+		if (evsel__read_counter(evsel, 0, 0) < 0) {
+			pr_debug("Failed to read %s per-process\n", evsel__name(evsel));
+			goto out;
+		}
+		count = perf_counts(evsel->counts, 0, 0);
+		if (ev == TOOL_PMU__EVENT_MEMORY_RSS)
+			pid_rss = count->val;
+		else if (ev == TOOL_PMU__EVENT_MEMORY_USS)
+			pid_uss = count->val;
+		else if (ev == TOOL_PMU__EVENT_MEMORY_SIZE)
+			pid_size = count->val;
+		else if (ev == TOOL_PMU__EVENT_MEMORY_TEXT)
+			pid_text = count->val;
+		else if (ev == TOOL_PMU__EVENT_MEMORY_DATA)
+			pid_data = count->val;
+		else
+			goto out;
+		evsel__close(evsel);
+	}
+
+	if (pid_rss == 0 || pid_size < pid_rss || pid_uss > pid_rss ||
+	    pid_text == 0 || pid_data == 0) {
+		pr_debug("Unexpected per-pid memory values: rss=%llu uss=%llu size=%llu text=%llu data=%llu\n",
+			 (unsigned long long)pid_rss, (unsigned long long)pid_uss,
+			 (unsigned long long)pid_size, (unsigned long long)pid_text,
+			 (unsigned long long)pid_data);
+		goto out;
+	}
+
+	/* Verify system-wide aggregation on memory_size. */
+	sys_threads = perf_thread_map__new_dummy();
+	if (!sys_threads)
+		goto out;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel__tool_event(evsel) != TOOL_PMU__EVENT_MEMORY_SIZE)
+			continue;
+		evsel->pid_stat = false;
+		evsel->core.system_wide = true;
+		if (evsel__open(evsel, cpus, sys_threads) < 0)
+			goto out;
+		if (evsel__read_counter(evsel, 0, 0) < 0)
+			goto out;
+		sys_size = perf_counts(evsel->counts, 0, 0)->val;
+		evsel__close(evsel);
+	}
+
+	if (sys_size < pid_size) {
+		pr_debug("System-wide memory_size (%llu) < pid memory_size (%llu)\n",
+			 (unsigned long long)sys_size, (unsigned long long)pid_size);
+		goto out;
+	}
+
+	if (check_multithread_memory_dedup(cpus) != TEST_OK)
+		goto out;
+
+	ret = TEST_OK;
+out:
+	evlist__for_each_entry(evlist, evsel)
+		evsel__close(evsel);
+	perf_thread_map__put(sys_threads);
+	perf_thread_map__put(threads);
+	perf_cpu_map__put(cpus);
+	evlist__put(evlist);
+	return ret;
+}
+
+static int test__tool_pmu_net_events(struct test_suite *test __maybe_unused,
+				     int subtest __maybe_unused)
+{
+	static const char snap1[] =
+		"Inter-|   Receive |  Transmit\n"
+		" face |bytes packets errs drop fifo frame compressed multicast|bytes packets...\n"
+		"    lo:    1000   10  0  0  0  0  0  0    2000   20  0  0  0  0  0   5\n"
+		"  eth0:123456789012  100  0  0  0  0  0  0    3000   30  0  0  0  0  0   7\n";
+	static const char snap2[] =
+		"Inter-|   Receive |  Transmit\n"
+		" face |bytes packets errs drop fifo frame compressed multicast|bytes packets...\n"
+		"    lo:    1500   12  0  0  0  0  0  0    2250   20  0  0  0  0  0   8\n"
+		"  eth0:123456789612  105  0  0  0  0  0  0    3750   30  0  0  0  0  0  11\n";
+	static const char snap3[] =
+		"Inter-|   Receive |  Transmit\n"
+		" face |bytes packets errs drop fifo frame compressed multicast|bytes packets...\n"
+		"    lo:    9999   99  0  0  0  0  0  0    9999   99  0  0  0  0  0  99\n"
+		"  eth0:123456799999  999  0  0  0  0  0  0    9999   99  0  0  0  0  0  99\n";
+	const char *events =
+		"net_rx_bytes,net_rx_packets,net_tx_bytes,net_tx_compressed";
+	char tmp_path[] = "/tmp/perf-tool-net-XXXXXX";
+	struct evlist *evlist = evlist__new();
+	struct parse_events_error err;
+	struct perf_cpu_map *cpus = NULL;
+	struct perf_thread_map *pid_threads = NULL, *sys_threads = NULL;
+	struct evsel *evsel;
+	int ret = TEST_FAIL, tmp_fd = -1;
+
+	if (!evlist)
+		return TEST_FAIL;
+
+	parse_events_error__init(&err);
+	if (parse_events(evlist, events, &err)) {
+		parse_events_error__exit(&err);
+		evlist__put(evlist);
+		return TEST_FAIL;
+	}
+	parse_events_error__exit(&err);
+
+	cpus = perf_cpu_map__new_int(0);
+	pid_threads = thread_map__new_by_tid(getpid());
+	sys_threads = perf_thread_map__new_dummy();
+	if (!cpus || !pid_threads || !sys_threads)
+		goto out;
+
+	/* Per-process open must fail with EINVAL. */
+	evsel = evlist__first(evlist);
+	errno = 0;
+	if (evsel__open(evsel, cpus, pid_threads) != -EINVAL || errno != EINVAL) {
+		pr_debug("Expected -EINVAL opening net_rx_bytes per-process\n");
+		goto out;
+	}
+
+	if (access("/proc/net/dev", R_OK) != 0) {
+		ret = TEST_SKIP;
+		goto out;
+	}
+
+	tmp_fd = mkstemp(tmp_path);
+	if (tmp_fd < 0)
+		goto out;
+	unlink(tmp_path);
+
+	if (write_temp_file(tmp_fd, snap1) < 0)
+		goto out;
+
+	evlist__for_each_entry(evlist, evsel) {
+		int fd;
+
+		evsel->supported = true;
+		evsel->core.system_wide = true;
+		evsel->core.attr.disabled = 1;
+		perf_cpu_map__put(evsel->core.cpus);
+		evsel->core.cpus = perf_cpu_map__get(cpus);
+		perf_thread_map__put(evsel->core.threads);
+		evsel->core.threads = perf_thread_map__get(sys_threads);
+		if (evsel__alloc_counts(evsel) < 0)
+			goto out;
+		if (evsel__open(evsel, cpus, sys_threads) < 0)
+			goto out;
+		fd = *(int *)xyarray__entry(evsel->core.fd, 0, 0);
+		if (fd < 0 || dup2(tmp_fd, fd) < 0)
+			goto out;
+
+		/* Reading while initially disabled must return 0. */
+		if (evsel__read_counter(evsel, 0, 0) < 0 ||
+		    perf_counts(evsel->counts, 0, 0)->val != 0)
+			goto out;
+		if (evsel__enable(evsel) < 0)
+			goto out;
+	}
+
+	if (write_temp_file(tmp_fd, snap2) < 0)
+		goto out;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel__disable(evsel) < 0)
+			goto out;
+	}
+
+	/* Traffic occurring while disabled must not change accumulated counts. */
+	if (write_temp_file(tmp_fd, snap3) < 0)
+		goto out;
+
+	evlist__for_each_entry(evlist, evsel) {
+		enum tool_pmu_event ev = evsel__tool_event(evsel);
+		u64 got, expected;
+
+		if (evsel__read_counter(evsel, 0, 0) < 0)
+			goto out;
+		got = perf_counts(evsel->counts, 0, 0)->val;
+		if (ev == TOOL_PMU__EVENT_NET_RX_BYTES)
+			expected = 1100;
+		else if (ev == TOOL_PMU__EVENT_NET_RX_PACKETS)
+			expected = 7;
+		else if (ev == TOOL_PMU__EVENT_NET_TX_BYTES)
+			expected = 1000;
+		else if (ev == TOOL_PMU__EVENT_NET_TX_COMPRESSED)
+			expected = 7;
+		else
+			goto out;
+		if (got != expected) {
+			pr_debug("Mismatch for %s: got %llu, expected %llu\n",
+				 evsel__name(evsel), (unsigned long long)got,
+				 (unsigned long long)expected);
+			goto out;
+		}
+	}
+
+	ret = TEST_OK;
+out:
+	if (tmp_fd >= 0)
+		close(tmp_fd);
+	evlist__for_each_entry(evlist, evsel)
+		evsel__close(evsel);
+	perf_thread_map__put(sys_threads);
+	perf_thread_map__put(pid_threads);
+	perf_cpu_map__put(cpus);
+	evlist__put(evlist);
+	return ret;
+}
+
+static int test__tool_pmu_schedstat_events(struct test_suite *test __maybe_unused,
+					   int subtest __maybe_unused)
+{
+	static const char snap1[] =
+		"version 17\n"
+		"timestamp 4295733968\n"
+		"cpu0 10 0 100 50 80 40 1000000 200000 300\n"
+		"domain0 SMT 0000003 0 0 0\n"
+		"cpu1 20 0 200 60 90 45 5000000 400000 700\n";
+	static const char snap2[] =
+		"version 17\n"
+		"timestamp 4295734068\n"
+		"cpu0 13 0 110 55 85 42 1250000 210000 315\n"
+		"domain0 SMT 0000003 0 0 0\n"
+		"cpu1 20 0 220 70 95 48 5750000 420000 725\n";
+	char tmp_path[] = "/tmp/perf-tool-sched-XXXXXX";
+	struct evlist *evlist = evlist__new();
+	struct parse_events_error err;
+	struct perf_cpu_map *cpus = NULL;
+	struct perf_thread_map *pid_threads = NULL, *sys_threads = NULL;
+	struct evsel *evsel;
+	const char *events =
+		"tool/schedstat_yield/,tool/schedstat_runtime/,tool/schedstat_timeslices/";
+	int ret = TEST_FAIL, tmp_fd = -1;
+
+	if (!evlist)
+		return TEST_FAIL;
+
+	parse_events_error__init(&err);
+	if (parse_events(evlist, events, &err)) {
+		parse_events_error__exit(&err);
+		evlist__put(evlist);
+		return TEST_FAIL;
+	}
+	parse_events_error__exit(&err);
+
+	cpus = perf_cpu_map__new("0,1");
+	pid_threads = thread_map__new_by_tid(getpid());
+	sys_threads = perf_thread_map__new_dummy();
+	if (!cpus || !pid_threads || !sys_threads)
+		goto out;
+
+	/* Per-process open must fail with EINVAL. */
+	evsel = evlist__first(evlist);
+	errno = 0;
+	if (evsel__open(evsel, cpus, pid_threads) != -EINVAL || errno != EINVAL) {
+		pr_debug("Expected -EINVAL opening schedstat_yield per-process\n");
+		goto out;
+	}
+
+	if (access("/proc/schedstat", R_OK) != 0) {
+		ret = TEST_SKIP;
+		goto out;
+	}
+
+	tmp_fd = mkstemp(tmp_path);
+	if (tmp_fd < 0)
+		goto out;
+	unlink(tmp_path);
+
+	if (write_temp_file(tmp_fd, snap1) < 0)
+		goto out;
+
+	evlist__for_each_entry(evlist, evsel) {
+		evsel->supported = true;
+		evsel->core.system_wide = true;
+		evsel->core.attr.disabled = 1;
+		perf_cpu_map__put(evsel->core.cpus);
+		evsel->core.cpus = perf_cpu_map__get(cpus);
+		perf_thread_map__put(evsel->core.threads);
+		evsel->core.threads = perf_thread_map__get(sys_threads);
+		if (evsel__alloc_counts(evsel) < 0)
+			goto out;
+		if (evsel__open(evsel, cpus, sys_threads) < 0)
+			goto out;
+		for (int cpu_idx = 0; cpu_idx < 2; cpu_idx++) {
+			int fd = *(int *)xyarray__entry(evsel->core.fd, cpu_idx, 0);
+
+			if (fd < 0 || dup2(tmp_fd, fd) < 0)
+				goto out;
+		}
+		if (evsel__enable(evsel) < 0)
+			goto out;
+	}
+
+	if (write_temp_file(tmp_fd, snap2) < 0)
+		goto out;
+
+	evlist__for_each_entry(evlist, evsel) {
+		enum tool_pmu_event ev = evsel__tool_event(evsel);
+		u64 c0, c1, exp0, exp1;
+
+		if (evsel__disable(evsel) < 0)
+			goto out;
+		if (evsel__read_counter(evsel, 0, 0) < 0 ||
+		    evsel__read_counter(evsel, 1, 0) < 0)
+			goto out;
+		c0 = perf_counts(evsel->counts, 0, 0)->val;
+		c1 = perf_counts(evsel->counts, 1, 0)->val;
+		if (ev == TOOL_PMU__EVENT_SCHEDSTAT_YIELD) {
+			exp0 = 3;
+			exp1 = 0;
+		} else if (ev == TOOL_PMU__EVENT_SCHEDSTAT_RUNTIME) {
+			exp0 = 250000;
+			exp1 = 750000;
+		} else if (ev == TOOL_PMU__EVENT_SCHEDSTAT_TIMESLICES) {
+			exp0 = 15;
+			exp1 = 25;
+		} else {
+			goto out;
+		}
+		if (c0 != exp0 || c1 != exp1) {
+			pr_debug("Mismatch for %s: got (%llu, %llu), expected (%llu, %llu)\n",
+				 evsel__name(evsel),
+				 (unsigned long long)c0, (unsigned long long)c1,
+				 (unsigned long long)exp0, (unsigned long long)exp1);
+			goto out;
+		}
+	}
+
+	ret = TEST_OK;
+out:
+	if (tmp_fd >= 0)
+		close(tmp_fd);
+	evlist__for_each_entry(evlist, evsel)
+		evsel__close(evsel);
+	perf_thread_map__put(sys_threads);
+	perf_thread_map__put(pid_threads);
+	perf_cpu_map__put(cpus);
+	evlist__put(evlist);
+	return ret;
+}
+
+static int run_mixed_group_case(const char *group_str, const char *cpu_list,
+				int c0, int c1, int net_fd, int sched_fd)
+{
+	static const char net_snap1[] =
+		"Inter-|   Receive |  Transmit\n"
+		" face |bytes packets errs drop fifo frame compressed multicast|bytes packets...\n"
+		"    lo:    1000   10  0  0  0  0  0  0    2000   20  0  0  0  0  0   0\n";
+	static const char net_snap2[] =
+		"Inter-|   Receive |  Transmit\n"
+		" face |bytes packets errs drop fifo frame compressed multicast|bytes packets...\n"
+		"    lo:    1600   15  0  0  0  0  0  0    2000   20  0  0  0  0  0   0\n";
+	struct target target = {
+		.system_wide = true,
+		.cpu_list = cpu_list,
+	};
+	struct evlist *evlist = evlist__new();
+	struct parse_events_error err;
+	struct evsel *evsel, *net_evsel = NULL, *sched_evsel = NULL;
+	char sched_snap1[256], sched_snap2[256];
+	int ret = TEST_FAIL;
+
+	if (!evlist)
+		return TEST_FAIL;
+
+	snprintf(sched_snap1, sizeof(sched_snap1),
+		 "version 17\ncpu%d 10 0 0 0 0 0 0 0 0\ncpu%d 20 0 0 0 0 0 0 0 0\n",
+		 c0, c1);
+	snprintf(sched_snap2, sizeof(sched_snap2),
+		 "version 17\ncpu%d 13 0 0 0 0 0 0 0 0\ncpu%d 27 0 0 0 0 0 0 0 0\n",
+		 c0, c1);
+
+	parse_events_error__init(&err);
+	if (parse_events(evlist, group_str, &err)) {
+		parse_events_error__exit(&err);
+		goto out;
+	}
+	parse_events_error__exit(&err);
+
+	if (evlist__create_maps(evlist, &target) < 0)
+		goto out;
+
+	if (write_temp_file(net_fd, net_snap1) < 0 ||
+	    write_temp_file(sched_fd, sched_snap1) < 0)
+		goto out;
+
+	evlist__for_each_entry(evlist, evsel) {
+		enum tool_pmu_event ev = evsel__tool_event(evsel);
+
+		evsel->supported = true;
+		evsel->core.system_wide = true;
+		/* Only group leaders set attr.disabled = 1 in perf stat/evsel__config. */
+		if (evsel__is_group_leader(evsel))
+			evsel->core.attr.disabled = 1;
+		if (evsel__alloc_counts(evsel) < 0 ||
+		    evsel__open(evsel, evsel->core.cpus, evsel->core.threads) < 0)
+			goto out;
+		if (!evsel->disabled)
+			goto out;
+
+		if (ev == TOOL_PMU__EVENT_NET_RX_BYTES) {
+			int fd;
+
+			net_evsel = evsel;
+			if (perf_cpu_map__nr(evsel->core.cpus) != 1)
+				goto out;
+			fd = *(int *)xyarray__entry(evsel->core.fd, 0, 0);
+			if (fd < 0 || dup2(net_fd, fd) < 0)
+				goto out;
+		} else if (ev == TOOL_PMU__EVENT_SCHEDSTAT_YIELD) {
+			sched_evsel = evsel;
+			if (perf_cpu_map__nr(evsel->core.cpus) != 2)
+				goto out;
+			for (int idx = 0; idx < 2; idx++) {
+				int fd = *(int *)xyarray__entry(evsel->core.fd, idx, 0);
+
+				if (fd < 0 || dup2(sched_fd, fd) < 0)
+					goto out;
+			}
+		} else {
+			goto out;
+		}
+	}
+
+	if (!net_evsel || !sched_evsel)
+		goto out;
+
+	/* Both leader and member must read 0 while the group is still disabled. */
+	if (evsel__read_counter(net_evsel, 0, 0) < 0 ||
+	    evsel__read_counter(sched_evsel, 0, 0) < 0 ||
+	    evsel__read_counter(sched_evsel, 1, 0) < 0 ||
+	    perf_counts(net_evsel->counts, 0, 0)->val != 0 ||
+	    perf_counts(sched_evsel->counts, 0, 0)->val != 0 ||
+	    perf_counts(sched_evsel->counts, 1, 0)->val != 0)
+		goto out;
+
+	evlist__enable(evlist);
+
+	if (write_temp_file(net_fd, net_snap2) < 0 ||
+	    write_temp_file(sched_fd, sched_snap2) < 0)
+		goto out;
+
+	evlist__disable(evlist);
+
+	if (evsel__read_counter(net_evsel, 0, 0) < 0 ||
+	    evsel__read_counter(sched_evsel, 0, 0) < 0 ||
+	    evsel__read_counter(sched_evsel, 1, 0) < 0)
+		goto out;
+
+	if (perf_counts(net_evsel->counts, 0, 0)->val != 600 ||
+	    perf_counts(sched_evsel->counts, 0, 0)->val != 3 ||
+	    perf_counts(sched_evsel->counts, 1, 0)->val != 7) {
+		pr_debug("Unexpected mixed group counts for %s: net=%llu sched=(%llu, %llu)\n",
+			 group_str,
+			 (unsigned long long)perf_counts(net_evsel->counts, 0, 0)->val,
+			 (unsigned long long)perf_counts(sched_evsel->counts, 0, 0)->val,
+			 (unsigned long long)perf_counts(sched_evsel->counts, 1, 0)->val);
+		goto out;
+	}
+
+	ret = TEST_OK;
+out:
+	evlist__for_each_entry(evlist, evsel)
+		evsel__close(evsel);
+	evlist__put(evlist);
+	return ret;
+}
+
+static int test__tool_pmu_mixed_group_events(struct test_suite *test __maybe_unused,
+					     int subtest __maybe_unused)
+{
+	char net_path[] = "/tmp/perf-tool-grp-net-XXXXXX";
+	char sched_path[] = "/tmp/perf-tool-grp-sched-XXXXXX";
+	struct perf_cpu_map *online = NULL;
+	char cpu_list[64];
+	int net_fd = -1, sched_fd = -1, c0, c1, ret = TEST_FAIL;
+
+	if (access("/proc/net/dev", R_OK) != 0 ||
+	    access("/proc/schedstat", R_OK) != 0)
+		return TEST_SKIP;
+
+	online = cpu_map__online();
+	if (!online || perf_cpu_map__nr(online) < 2) {
+		perf_cpu_map__put(online);
+		return TEST_SKIP;
+	}
+	c0 = perf_cpu_map__cpu(online, 0).cpu;
+	c1 = perf_cpu_map__cpu(online, 1).cpu;
+	perf_cpu_map__put(online);
+	snprintf(cpu_list, sizeof(cpu_list), "%d,%d", c0, c1);
+
+	net_fd = mkstemp(net_path);
+	if (net_fd < 0)
+		goto out;
+	unlink(net_path);
+
+	sched_fd = mkstemp(sched_path);
+	if (sched_fd < 0)
+		goto out;
+	unlink(sched_path);
+
+	if (run_mixed_group_case("{schedstat_yield,net_rx_bytes}",
+				 cpu_list, c0, c1, net_fd, sched_fd) != TEST_OK)
+		goto out;
+	if (run_mixed_group_case("{net_rx_bytes,schedstat_yield}",
+				 cpu_list, c0, c1, net_fd, sched_fd) != TEST_OK)
+		goto out;
+
+	ret = TEST_OK;
+out:
+	if (net_fd >= 0)
+		close(net_fd);
+	if (sched_fd >= 0)
+		close(sched_fd);
+	return ret;
+}
+
 static struct test_case tests__tool_pmu[] = {
 	TEST_CASE("Parsing without PMU name", tool_pmu_without_pmu),
 	TEST_CASE("Parsing with PMU name", tool_pmu_with_pmu),
 	TEST_CASE("Incremental open error unwind boundary", tool_pmu_incremental_open_unwind),
+	TEST_CASE("Memory events", tool_pmu_memory_events),
+	TEST_CASE("Network events", tool_pmu_net_events),
+	TEST_CASE("Schedstat events", tool_pmu_schedstat_events),
+	TEST_CASE("Mixed CPU-map tool groups", tool_pmu_mixed_group_events),
 	{	.name = NULL, }
 };
 
-- 
2.56.1.703.gf848ed807c-goog

