Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795418426;
	b=uSnmEHuNndM/dgxdaNuQI6U/OC4VBOq78SPkUI6mWBCZFniY7IkNRTHDBP/BUJTMCJBY
	 q3i7gnM1HHvFi3qaa5/uEoHe7BBtdQoJI0sOBXcdIcH329Ccl43ejiM1ikzJRewiGUH8z
	 5oVyj7xoQuxy3XWJZL66RfbUvDMKAcz4Ma6KZDIE9L3hygcQg/Sp191JzTthZaFXtB21f
	 +B0e0PuJ9PSmMdM1MtpKFrxQW2s1s+aBiR98n1dQcOoK5OfHnBJFlrcJJan5xDdOFNs+E
	 RBbF/GdzpHCzhDSem+RRCf4PF4yGfPt3adtEy0Is7Cu/CCtUce/Vfzjy9PTjssQgIrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795418426;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=PY83dvEYzjfItmlyYLWJEIclB8aLqW3e/KxXiFj0wiQ=;
	b=odwGCFNaAZG9z1SqGEYpRKpTnECdzMT+p2vwoTAIjX59uiHtmtTkLPjQMpOllnlRoJyV
	 urcC0NYjwyjReKHSshfGKRomP38fNxt8dA3iv/c6ZN4YIW7/TZ6frfo3mF7/NUhbyiiyF
	 WgW7swJfL2Be3yjYJGChJMKxcgOdze8RZSWoZpTpwCraMaAyPIJgNqxC92TVblFWKDvVS
	 RZ7T3sOgXOrzbstNA9qvfxdzIBW76KzGJTxugW7Od6q42fDlcvwxW4gYCDSbae5FKZfTv
	 /fA86vbZcKAEFJgE6eDsaf1MuUPecRFrYcXRaOQ/4x/SZztmFrCmdXhYQVYWbvPjhxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=anstpVv7;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C088606A31E
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 07:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C088606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=anstpVv7
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-386b8624cf7so249963eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 22 Nov 2026 23:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795418424; x=1796023224; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PY83dvEYzjfItmlyYLWJEIclB8aLqW3e/KxXiFj0wiQ=;
        b=anstpVv71gJIAPWZQaPcB2b5wGNrW76PrmpD0vsFioqZo3lyWeUZf07ORqFeppRkOD
         +y58pvLOYyLwZ5knaaBpvIrrrpKbDEoKMljiHcAhqi2YMMXv2XupKs2m4aNP6fkoDTT6
         AtSkyrIFHRIKUVoS4sVCm3D/YKya3QhrhzDWRLaVUXjRny/SRFOlTqALfK7f/wXVjuXO
         f2HCJjhkUngvb8GFHuB5N52D0nYvUmbQ83ITRT4A+cnxDtSWpQtbei42p5SjrQVh6e+M
         Z6WIuhkBkhdNozpbuXipomZJFHX18ewlnhum8LBmkZkukL7/9m1UtRkAUg3LK1bsc6Xb
         JVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795418424; x=1796023224;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PY83dvEYzjfItmlyYLWJEIclB8aLqW3e/KxXiFj0wiQ=;
        b=rw2ShjUu2KmJ+Av7/G4ZpVxobvJl+Wg4PeOJg32Y6h2VQeY1W7mb3ePSL6F5t0We5B
         h3ILI+6op7ISxsFgdQ9QB9AkQHrhm3xq1sIMt+4O02p8hCjqHL5GQsJtp99zEK7E5gUH
         lTulDrKCrJWMVAK2VywVog/mTL8141kb1CcoqHtG5pLpw9APP61lCMm6zROGu5tbohA7
         YzEykjn/d4k0+q1jf1QTHZ9Ouw/SMn+q8BNCE3lOCoQpu5jWrB5gyZ7sZpnd5aO9Gi8N
         S4ntptNEJH7F5rHiDFRlP3HYeKAr+9ujcIh97JhgTPwlSE8qlogNXGS/qBHwBjltyTUR
         EgKQ==
X-Forwarded-Encrypted: i=1; AL+hErF9GVM9Kq3SdoU2T96S+T/rM2ABUiVX+onho31nB++0IOXfKMULrn+Jrx1UuKWuONnyyvFuT8U9h0JyY1cu2b7q@vger.kernel.org
X-Gm-Message-State: APuU4Z/uXpi++5tGhPvDz+NE653cvhuDiiViOi/u27xSxkskFRqiO9Ke
	3Y8HEbZq+tASa1tn3K4xH23oUnjOVAdITjzaRIlANcbDOa47MWfG7vzQL/fg8lvbZ4iRqAx06mn
	fEcFHN98new==
X-Received: from dyr3.prod.google.com ([2002:a05:693c:4003:b0:370:f640:2508])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:b597:b0:386:9e36:df0a
 with SMTP id 5a478bee46e88-3869e36e011mr10386849eec.13.1795418423867; Sun, 22
 Nov 2026 23:20:23 -0800 (PST)
Date: Sun, 22 Nov 2026 23:19:12 -0800
In-Reply-To: <20261123071913.653315-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261123071913.653315-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261123071913.653315-13-irogers@google.com>
Subject: [PATCH v1 12/13] perf bpf-filter: Support BPF sample filters on
 tracepoint events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: Howard Chu <howardchu95@gmail.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Song Liu <songliubraving@fb.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit 466db4275edd ("perf parse-events: Add parse_uid_filter helper")
updated set_filter() to route non-tracepoint filter terms (such as uid
and gid) on PERF_TYPE_TRACEPOINT events to evsel->bpf_filters instead
of the ftrace tracepoint predicate filter.

However, in the kernel's __perf_event_set_bpf_prog()
(kernel/events/core.c), attaching a BPF program to a perf_event fd
branches on perf_event_is_tracing(event):
- Non-tracing events (hardware PMU, software events, breakpoints) call
  perf_event_set_bpf_handler(), which requires BPF_PROG_TYPE_PERF_EVENT
  (SEC("perf_event")).
- Tracepoint events (event->pmu == &perf_tracepoint) reject
  BPF_PROG_TYPE_PERF_EVENT with -EINVAL and instead require
  BPF_PROG_TYPE_TRACEPOINT (SEC("tracepoint")), which is attached to
  event->tp_event->prog_array and executed in
  perf_trace_run_bpf_submit() before perf_tp_event(), dropping the
  sample if the BPF program returns 0. Furthermore, the
  bpf_cast_to_kern_ctx() kfunc is only permitted in
  BPF_PROG_TYPE_PERF_EVENT programs.

Add SEC("tracepoint") int perf_tp_sample_filter(void *ctx) in
sample_filter.bpf.c to evaluate context-independent filter terms (uid,
gid, tid, cpu, time, cgroup) using BPF helpers without calling
bpf_cast_to_kern_ctx(), guarding bpf_get_current_cgroup_id() with CO-RE
for !CONFIG_CGROUPS kernels. When preparing a BPF filter on a
PERF_TYPE_TRACEPOINT evsel, autoload perf_tp_sample_filter instead of
perf_sample_filter and attach it once to the shared trace_event_call.
Check CAP_SYS_ADMIN || (CAP_BPF && CAP_PERFMON) when deciding whether
the caller can load BPF filter programs directly.

Because perf_bpf_filter__pin() and perf_bpf_filter__unpin() only load
perf_sample_filter and disable autoload on perf_tp_sample_filter,
introduce pin_filter_object() and unpin_filter_object() to pin/unpin the
maps and only the loaded perf_sample_filter program.

Fixes: 466db4275edd ("perf parse-events: Add parse_uid_filter helper")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf-filter.c                 | 158 ++++++++++++++++---
 tools/perf/util/bpf_skel/sample_filter.bpf.c | 101 ++++++++++++
 2 files changed, 238 insertions(+), 21 deletions(-)

diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index affb75e7ff85..0a07429642be 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -41,8 +41,10 @@
  * it will be reported as lost samples.
  */
 #include <errno.h>
+#include <stdio.h>
 #include <stdlib.h>
 #include <fcntl.h>
+#include <unistd.h>
 #include <sys/ioctl.h>
 #include <sys/stat.h>
 
@@ -120,19 +122,36 @@ static const struct perf_sample_info *get_sample_info(enum perf_bpf_filter_term
 	return NULL;
 }
 
+static bool can_load_bpf_filter(void)
+{
+	return perf_cap__capable(CAP_SYS_ADMIN) ||
+	       (perf_cap__capable(CAP_BPF) && perf_cap__capable(CAP_PERFMON));
+}
+
 static int check_sample_flags(struct evsel *evsel, struct perf_bpf_filter_expr *expr)
 {
 	const struct perf_sample_info *info;
 
-	if (expr->term >= PBF_TERM_SAMPLE_START && expr->term <= PBF_TERM_SAMPLE_END &&
-	    (evsel->core.attr.sample_type & (1 << (expr->term - PBF_TERM_SAMPLE_START))))
-		return 0;
-
 	if (expr->term == PBF_TERM_UID || expr->term == PBF_TERM_GID) {
 		/* Not dependent on the sample_type as computed from a BPF helper. */
 		return 0;
 	}
 
+	if (evsel->core.attr.type == PERF_TYPE_TRACEPOINT) {
+		if (expr->term == PBF_TERM_TID || expr->term == PBF_TERM_CPU ||
+		    expr->term == PBF_TERM_TIME || expr->term == PBF_TERM_CGROUP)
+			return 0;
+		if (expr->op != PBF_OP_GROUP_BEGIN) {
+			pr_err("Error: %s tracepoint event does not support BPF sample term %d\n",
+			       evsel__name(evsel), expr->term);
+			return -1;
+		}
+	}
+
+	if (expr->term >= PBF_TERM_SAMPLE_START && expr->term <= PBF_TERM_SAMPLE_END &&
+	    (evsel->core.attr.sample_type & (1 << (expr->term - PBF_TERM_SAMPLE_START))))
+		return 0;
+
 	if (expr->op == PBF_OP_GROUP_BEGIN) {
 		struct perf_bpf_filter_expr *group;
 
@@ -426,6 +445,11 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 	struct sample_filter_bpf *skel = NULL;
 	struct perf_bpf_filter_entry *entry;
 	bool needs_idx_hash = !target__has_cpu(target);
+	bool is_tracepoint = (evsel->core.attr.type == PERF_TYPE_TRACEPOINT);
+	bool can_load = can_load_bpf_filter();
+
+	if (evsel->bpf_skel)
+		return 0;
 
 	entry = calloc(MAX_FILTERS, sizeof(*entry));
 	if (entry == NULL)
@@ -437,7 +461,13 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 		goto err;
 	}
 
-	if (needs_idx_hash && geteuid() != 0) {
+	if (is_tracepoint && !can_load) {
+		pr_err("Error: Tracepoint BPF filter requires CAP_BPF and CAP_PERFMON (or CAP_SYS_ADMIN)\n");
+		ret = -EPERM;
+		goto err;
+	}
+
+	if (needs_idx_hash && !can_load) {
 		int zero = 0;
 
 		/* The filters map is shared among other processes */
@@ -477,8 +507,17 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 		return 0;
 	}
 
-	skel = sample_filter_bpf__open_and_load();
+	skel = sample_filter_bpf__open();
 	if (!skel) {
+		ret = -errno;
+		pr_err("Failed to open perf sample-filter BPF skeleton\n");
+		goto err;
+	}
+
+	bpf_program__set_autoload(skel->progs.perf_sample_filter, !is_tracepoint);
+	bpf_program__set_autoload(skel->progs.perf_tp_sample_filter, is_tracepoint);
+
+	if (sample_filter_bpf__load(skel) < 0) {
 		ret = -errno;
 		pr_err("Failed to load perf sample-filter BPF skeleton\n");
 		goto err;
@@ -494,14 +533,32 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 		goto err;
 	}
 
-	fd = bpf_program__fd(skel->progs.perf_sample_filter);
-	for (x = 0; x < xyarray__max_x(evsel->core.fd); x++) {
-		for (y = 0; y < xyarray__max_y(evsel->core.fd); y++) {
-			ret = ioctl(FD(evsel, x, y), PERF_EVENT_IOC_SET_BPF, fd);
-			if (ret < 0) {
-				ret = -errno;
-				pr_err("Failed to attach perf sample-filter program\n");
-				goto err;
+	if (is_tracepoint) {
+		/*
+		 * For PERF_TYPE_TRACEPOINT, PERF_EVENT_IOC_SET_BPF attaches the
+		 * BPF program to event->tp_event->prog_array on the shared
+		 * trace_event_call, which perf_trace_run_bpf_submit() executes
+		 * for all CPUs and tasks before iterating the per-CPU perf
+		 * events. Attach once on the first FD so tp_event->prog_array
+		 * does not get duplicate copies for each per-CPU FD.
+		 */
+		fd = bpf_program__fd(skel->progs.perf_tp_sample_filter);
+		ret = ioctl(FD(evsel, 0, 0), PERF_EVENT_IOC_SET_BPF, fd);
+		if (ret < 0) {
+			ret = -errno;
+			pr_err("Failed to attach perf tracepoint sample-filter program\n");
+			goto err;
+		}
+	} else {
+		fd = bpf_program__fd(skel->progs.perf_sample_filter);
+		for (x = 0; x < xyarray__max_x(evsel->core.fd); x++) {
+			for (y = 0; y < xyarray__max_y(evsel->core.fd); y++) {
+				ret = ioctl(FD(evsel, x, y), PERF_EVENT_IOC_SET_BPF, fd);
+				if (ret < 0) {
+					ret = -errno;
+					pr_err("Failed to attach perf sample-filter program\n");
+					goto err;
+				}
 			}
 		}
 	}
@@ -649,7 +706,7 @@ static bool check_bpf_filter_capable(void)
 {
 	int fd;
 
-	if (perf_cap__capable(CAP_BPF))
+	if (can_load_bpf_filter())
 		return true;
 
 	/* Check if root already pinned the filter programs and maps */
@@ -659,7 +716,7 @@ static bool check_bpf_filter_capable(void)
 		return true;
 	}
 
-	pr_err("Error: BPF filter only works for users with the CAP_BPF capability!\n"
+	pr_err("Error: BPF filter requires CAP_BPF and CAP_PERFMON (or CAP_SYS_ADMIN)!\n"
 	       "\tPlease run 'perf record --setup-filter pin' as root first.\n");
 
 	return false;
@@ -684,6 +741,55 @@ int perf_bpf_filter__parse(struct list_head *expr_head, const char *str)
 	return ret;
 }
 
+/*
+ * perf_bpf_filter__pin() and perf_bpf_filter__unpin() only load
+ * perf_sample_filter and disable autoload on other programs in the skeleton
+ * (such as perf_tp_sample_filter). While libbpf's bpf_object__pin_maps() skips
+ * maps that were not created, bpf_object__pin_programs() and
+ * bpf_object__unpin_programs() iterate over every program in skel->obj without
+ * checking whether autoload was enabled and fail with -EINVAL when a program
+ * was not loaded. Pin and unpin the maps and the loaded perf_sample_filter
+ * program explicitly instead of calling bpf_object__pin() / bpf_object__unpin().
+ */
+static int pin_filter_object(struct sample_filter_bpf *skel, const char *path)
+{
+	char *prog_path = NULL;
+	int ret;
+
+	ret = bpf_object__pin_maps(skel->obj, path);
+	if (ret < 0)
+		return ret;
+
+	if (asprintf(&prog_path, "%s/perf_sample_filter", path) < 0) {
+		bpf_object__unpin_maps(skel->obj, path);
+		return -ENOMEM;
+	}
+
+	ret = bpf_program__pin(skel->progs.perf_sample_filter, prog_path);
+	if (ret < 0)
+		bpf_object__unpin_maps(skel->obj, path);
+
+	free(prog_path);
+	return ret;
+}
+
+static int unpin_filter_object(struct sample_filter_bpf *skel, const char *path)
+{
+	char *prog_path = NULL;
+	int ret, map_ret;
+
+	if (asprintf(&prog_path, "%s/perf_sample_filter", path) < 0) {
+		bpf_object__unpin_maps(skel->obj, path);
+		return -ENOMEM;
+	}
+
+	ret = bpf_program__unpin(skel->progs.perf_sample_filter, prog_path);
+	free(prog_path);
+
+	map_ret = bpf_object__unpin_maps(skel->obj, path);
+	return ret < 0 ? ret : map_ret;
+}
+
 int perf_bpf_filter__pin(void)
 {
 	struct sample_filter_bpf *skel;
@@ -698,6 +804,7 @@ int perf_bpf_filter__pin(void)
 	}
 
 	/* pinned program will use pid-hash */
+	bpf_program__set_autoload(skel->progs.perf_tp_sample_filter, false);
 	bpf_map__set_max_entries(skel->maps.filters, MAX_FILTERS);
 	bpf_map__set_max_entries(skel->maps.event_hash, MAX_EVT_HASH);
 	bpf_map__set_max_entries(skel->maps.idx_hash, MAX_IDX_HASH);
@@ -717,7 +824,7 @@ int perf_bpf_filter__pin(void)
 		goto err;
 	}
 
-	ret = bpf_object__pin(skel->obj, path);
+	ret = pin_filter_object(skel, path);
 	if (ret < 0) {
 		pr_err("Failed to pin BPF filter objects\n");
 		goto err;
@@ -726,8 +833,8 @@ int perf_bpf_filter__pin(void)
 	/* setup access permissions for the pinned objects */
 	dir_fd = open(path, O_PATH);
 	if (dir_fd < 0) {
-		bpf_object__unpin(skel->obj, path);
-		ret = dir_fd;
+		ret = -errno;
+		unpin_filter_object(skel, path);
 		goto err;
 	}
 
@@ -770,6 +877,8 @@ int perf_bpf_filter__pin(void)
 
 err_close:
 	close(dir_fd);
+	if (ret < 0)
+		unpin_filter_object(skel, path);
 
 err:
 	free(path);
@@ -783,13 +892,20 @@ int perf_bpf_filter__unpin(void)
 	char *path = NULL;
 	int ret = -1;
 
-	skel = sample_filter_bpf__open_and_load();
+	skel = sample_filter_bpf__open();
 	if (!skel) {
 		ret = -errno;
 		pr_err("Failed to open perf sample-filter BPF skeleton\n");
 		goto err;
 	}
 
+	bpf_program__set_autoload(skel->progs.perf_tp_sample_filter, false);
+	if (sample_filter_bpf__load(skel) < 0) {
+		ret = -errno;
+		pr_err("Failed to load perf sample-filter BPF skeleton\n");
+		goto err;
+	}
+
 	if (asprintf(&path, "%s/fs/bpf/%s", sysfs__mountpoint(),
 		     PERF_BPF_FILTER_PIN_PATH) < 0) {
 		ret = -errno;
@@ -797,7 +913,7 @@ int perf_bpf_filter__unpin(void)
 		goto err;
 	}
 
-	ret = bpf_object__unpin(skel->obj, path);
+	ret = unpin_filter_object(skel, path);
 
 err:
 	free(path);
diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/util/bpf_skel/sample_filter.bpf.c
index 9ddac8e5cd78..ac6309728e14 100644
--- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
+++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
@@ -206,6 +206,30 @@ static inline __u64 perf_get_sample(struct bpf_perf_event_data_kern *kctx,
 	return 0;
 }
 
+static __always_inline __u64 perf_get_common_sample(struct perf_bpf_filter_entry *entry)
+{
+	switch (entry->term) {
+	case PBF_TERM_TID:
+		if (entry->part)
+			return bpf_get_current_pid_tgid() >> 32;
+		return (__u32)bpf_get_current_pid_tgid();
+	case PBF_TERM_CPU:
+		return bpf_get_smp_processor_id();
+	case PBF_TERM_TIME:
+		return bpf_ktime_get_ns();
+	case PBF_TERM_CGROUP:
+		if (bpf_core_field_exists(struct task_struct, cgroups))
+			return bpf_get_current_cgroup_id();
+		return 0;
+	case PBF_TERM_UID:
+		return bpf_get_current_uid_gid() & 0xFFFFFFFF;
+	case PBF_TERM_GID:
+		return bpf_get_current_uid_gid() >> 32;
+	default:
+		return 0;
+	}
+}
+
 #define CHECK_RESULT(data, op, val)			\
 	if (!(data op val)) {				\
 		if (!in_group)				\
@@ -309,4 +333,81 @@ int perf_sample_filter(void *ctx)
 	return 0;
 }
 
+/*
+ * BPF program to be called for tracepoint perf events.
+ *
+ * For PERF_TYPE_TRACEPOINT events, the kernel's __perf_event_set_bpf_prog()
+ * rejects BPF_PROG_TYPE_PERF_EVENT and only accepts BPF_PROG_TYPE_TRACEPOINT,
+ * attaching the program to the shared trace_event_call->prog_array executed
+ * by perf_trace_run_bpf_submit() prior to perf_tp_event(). Because returning 0
+ * filters the event at trace_event_call->prog_array (affecting the
+ * trace_event_call globally while attached), tracepoint BPF filters are never
+ * pinned for unprivileged use and require CAP_BPF + CAP_PERFMON or
+ * CAP_SYS_ADMIN.
+ */
+SEC("tracepoint")
+int perf_tp_sample_filter(void *ctx)
+{
+	struct perf_bpf_filter_entry *entry;
+	__u64 sample_data;
+	int in_group = 0;
+	int group_result = 0;
+	int i, k = 0;
+	int *losts;
+
+	(void)ctx;
+	entry = bpf_map_lookup_elem(&filters, &k);
+	if (entry == NULL)
+		goto drop;
+
+	for (i = 0; i < MAX_FILTERS; i++) {
+		sample_data = perf_get_common_sample(&entry[i]);
+
+		switch (entry[i].op) {
+		case PBF_OP_EQ:
+			CHECK_RESULT(sample_data, ==, entry[i].value)
+			break;
+		case PBF_OP_NEQ:
+			CHECK_RESULT(sample_data, !=, entry[i].value)
+			break;
+		case PBF_OP_GT:
+			CHECK_RESULT(sample_data, >, entry[i].value)
+			break;
+		case PBF_OP_GE:
+			CHECK_RESULT(sample_data, >=, entry[i].value)
+			break;
+		case PBF_OP_LT:
+			CHECK_RESULT(sample_data, <, entry[i].value)
+			break;
+		case PBF_OP_LE:
+			CHECK_RESULT(sample_data, <=, entry[i].value)
+			break;
+		case PBF_OP_AND:
+			CHECK_RESULT(sample_data, &, entry[i].value)
+			break;
+		case PBF_OP_GROUP_BEGIN:
+			in_group = 1;
+			group_result = 0;
+			break;
+		case PBF_OP_GROUP_END:
+			if (group_result == 0)
+				goto drop;
+			in_group = 0;
+			break;
+		case PBF_OP_DONE:
+			return 1;
+		default:
+			break;
+		}
+	}
+	return 1;
+
+drop:
+	losts = bpf_map_lookup_elem(&dropped, &k);
+	if (losts != NULL)
+		__sync_fetch_and_add(losts, 1);
+
+	return 0;
+}
+
 char LICENSE[] SEC("license") = "Dual BSD/GPL";
-- 
2.56.1.750.gf70dc682cf-goog

