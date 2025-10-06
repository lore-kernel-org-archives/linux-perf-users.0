Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789EA299A85
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Oct 2025 13:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759756292; cv=none; b=g6hkURjScYf45CVaI8pQLvFQqDb1DH7Z7nRka1koF9IVI0Hm2R5OIflj1G1ST+HzEIkCltjG89I7LDURYH1hqsGg8LBj8RB7wtMoBnwKuWKKtWvS+SQDin+m/Vk/RDwZGyJaSi0qUOwHjGcmyk/+ZuAszHpftWiy2BCqcgo5UvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759756292; c=relaxed/simple;
	bh=//5X3czCc4GFayvi8y/0XC+L5+/dta7u7+Xr20bo8p8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uFOI4kYQSey2iPLgWxU9IfKc0nU4P+wBjgif7GxO7snHMEi36DudBCKaVc4csSWIfxURoFd3smZ7t2rn44rHpJyO2nzIwIGB0OseczL+jCKyWL3USvIIoD38aNMl+GdXsEGdUG0m8XH3d7u2QbhyiEE05RYSw2GexYlYFD0xi20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vDER8XXL; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vDER8XXL"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42557c5cedcso2541730f8f.0
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Oct 2025 06:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759756288; x=1760361088; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QWdZlOTz0hyU0moGCRMUBDgT03J3fo3JCAg6LcKFa4w=;
        b=vDER8XXL6OKvpb0X7/YFMhK5CIr0h6PPiN9qdkfmCsn9UrkXQvwHxkeEsmJKDtzAwt
         do1+YTW0fErIFSiIKPQsXnyxm5F7Dh4z0P/a2Zzjj/T88rjT4Rz2VZjGaGCY4JjoPqDT
         Z+a8Yj8rbI4nWMhbjxzWVHP15Tqo97TjxHkdPmrZpCGCyatGUwa7Af/BmmQxjmmyCN7K
         g3hfmRU9HKaIGtFUXsiIxWxGsOaH/aq8NYZZPCH0T/4Um3806WUuY8vOyLuvbd8R2gFh
         sdTmMSuqDRV+xH4vWZXwDUvM9yFcnPwWQXnh5OJo6uPXOHb30aaXi+nZQWZUHEGDzTm8
         gSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759756288; x=1760361088;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QWdZlOTz0hyU0moGCRMUBDgT03J3fo3JCAg6LcKFa4w=;
        b=hrlZS5wBz9PkXJEN23f1zhG9CPOm/WM3s0EGDv88n5AVPh+LOArcpsul1WvMRg5DWi
         SA74xhyfJKclboWnGufvujkaaemrSmprLpHUvafBcXQXGJPUQCt59cPWaq0UzEHsoplu
         BLepsnzjNb2stM5Ozv1UYkGOYaScMapOuCiBVYQHMlw3aB650D8clxDpMnJ1t89Ku25I
         46/G69Fm5h6QsJ+pAqH3bzn2sjS+v4XO+92xK3W+bjXdZKlZ3PFxGGDUcS1B5GdMQ/8P
         dC4b9IwSCFpqSSMyeCeFSowXY+yiMaUKgdIsi7XeNnKb0MUxwRAvqs3AbbycWwGdclYu
         XDMA==
X-Gm-Message-State: AOJu0Yy+JgYY1WP+lGHuaIujDnKrzzA9Xg1WTEtSu+4eO3SRqlnHLiB+
	JjqvYr99kQYKE2DB41zpEgSoj/lPZ4T5AT/sgO7PN2Zy/c4yUY+vwWcjjPqq5elDeOk=
X-Gm-Gg: ASbGncvgTv7j86lRRBeCqx51TCDAG3W+Aa8ohP/eAoKuCxULACBuegCeOwu07XADlGU
	xloI5FuObCd0ajmuVSn02jWKtlT1kTEJDmzJJ+N8Eglw6s8iV7QxRCTpBD9Jn44wEHLcGK5tnC2
	f+jzKDQ1esfsb36slGztXJykZCvUq7jroJSllRIXj4FH6GU8Ms4KUkBMFSrKltyw2LHy8oJgYnR
	QMdq6+gNIYetimAnP+PGdbQlCLVXbUC5qcKUPTXqRY24LyTwjBCdQVMNuSusZEOLc9ERl1zzjIN
	nS6QbNTvQgmz0me1FqdOFyBc5Uk49VSpEDj04658r+zbvZJvTS6CDhwytvvSOtcDKodfXU66Rj1
	W0l6ovOfurrB9JPfZd0PKeU8Dicwo8uQR1p4gXW8Byiu+Lu/9O5QckBl/nUkGVW/QLqs7SkzNeq
	EtKM2RvQ==
X-Google-Smtp-Source: AGHT+IEb0/354XDjZL/3xqQvGmMufKoIFM6WNEwTK16lg8oM/ZM+OBF4dUnRkHGBbzVCAaFNAOCCZA==
X-Received: by 2002:a5d:5f47:0:b0:415:7a6c:6a38 with SMTP id ffacd0b85a97d-425671c3bcdmr7790794f8f.59.1759756287634;
        Mon, 06 Oct 2025 06:11:27 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e723614c9sm156577245e9.14.2025.10.06.06.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 06:11:27 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 06 Oct 2025 14:11:07 +0100
Subject: [PATCH] perf tests: Don't retest sections in "Object code reading"
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251006-james-perf-object-code-reading-v1-1-acab2129747d@linaro.org>
X-B4-Tracking: v=1; b=H4sIAOq/42gC/x3NQQqDMBBG4avIrDsQxYTaq5QuYvJrR2giExFBv
 Luhy2/z3kkFKij0ak5S7FIkp4r20VD4+jSDJVZTZzrbGuN48T8UXqET53FB2DjkCFb4KGnmwfU
 O/dNFO1iqkVUxyfEfvD/XdQNdGnhTcAAAAA==
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

We already only test each kcore map once, but on slow systems
(particularly with network filesystems) even the non-kcore maps are
slow. The test can test the same objump output over and over which only
wastes time. Generalize the skipping mechanism to track all DSOs and
addresses so that each section is only tested once.

On a fully loaded Arm Juno (simulating a parallel Perf test run) with a
network filesystem, the original runtime is:

  real  1m51.126s
  user  0m19.445s
  sys   1m15.431s

And the new runtime is:

  real  0m48.873s
  user  0m8.031s
  sys   0m32.353s

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/code-reading.c | 119 ++++++++++++++++++++++++++++------------
 1 file changed, 85 insertions(+), 34 deletions(-)

diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 9c2091310191..4c9fbf6965c4 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -2,6 +2,7 @@
 #include <errno.h>
 #include <linux/kconfig.h>
 #include <linux/kernel.h>
+#include <linux/rbtree.h>
 #include <linux/types.h>
 #include <inttypes.h>
 #include <stdlib.h>
@@ -39,11 +40,64 @@
 #define BUFSZ	1024
 #define READLEN	128
 
-struct state {
-	u64 done[1024];
-	size_t done_cnt;
+struct tested_section {
+	struct rb_node rb_node;
+	u64 addr;
+	char path[PATH_MAX];
 };
 
+static bool tested_code_insert_or_exists(const char *path, u64 addr,
+					 struct rb_root *tested_sections)
+{
+	struct rb_node **node = &tested_sections->rb_node;
+	struct rb_node *parent = NULL;
+	struct tested_section *data;
+
+	while (*node) {
+		int cmp;
+
+		parent = *node;
+		data = rb_entry(*node, struct tested_section, rb_node);
+		cmp = strcmp(path, data->path);
+		if (!cmp) {
+			if (addr < data->addr)
+				cmp = -1;
+			else if (addr > data->addr)
+				cmp = 1;
+			else
+				return true; /* already tested */
+		}
+
+		if (cmp < 0)
+			node = &(*node)->rb_left;
+		else
+			node = &(*node)->rb_right;
+	}
+
+	data = zalloc(sizeof(*data));
+	if (!data)
+		return true;
+
+	data->addr = addr;
+	strlcpy(data->path, path, sizeof(data->path));
+	rb_link_node(&data->rb_node, parent, node);
+	rb_insert_color(&data->rb_node, tested_sections);
+	return false;
+}
+
+static void tested_sections__free(struct rb_root *root)
+{
+	while (!RB_EMPTY_ROOT(root)) {
+		struct rb_node *node = rb_first(root);
+		struct tested_section *ts = rb_entry(node,
+						     struct tested_section,
+						     rb_node);
+
+		rb_erase(node, root);
+		free(ts);
+	}
+}
+
 static size_t read_objdump_chunk(const char **line, unsigned char **buf,
 				 size_t *buf_len)
 {
@@ -316,13 +370,15 @@ static void dump_buf(unsigned char *buf, size_t len)
 }
 
 static int read_object_code(u64 addr, size_t len, u8 cpumode,
-			    struct thread *thread, struct state *state)
+			    struct thread *thread,
+			    struct rb_root *tested_sections)
 {
 	struct addr_location al;
 	unsigned char buf1[BUFSZ] = {0};
 	unsigned char buf2[BUFSZ] = {0};
 	size_t ret_len;
 	u64 objdump_addr;
+	u64 skip_addr;
 	const char *objdump_name;
 	char decomp_name[KMOD_DECOMP_LEN];
 	bool decomp = false;
@@ -350,6 +406,18 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 		goto out;
 	}
 
+	/*
+	 * Don't retest the same addresses. objdump struggles with kcore - try
+	 * each map only once even if the address is different.
+	 */
+	skip_addr = dso__is_kcore(dso) ? map__start(al.map) : al.addr;
+	if (tested_code_insert_or_exists(dso__long_name(dso), skip_addr,
+					 tested_sections)) {
+		pr_debug("Already tested %s @ %#"PRIx64" - skipping\n",
+			 dso__long_name(dso), skip_addr);
+		goto out;
+	}
+
 	pr_debug("On file address is: %#"PRIx64"\n", al.addr);
 
 	if (len > BUFSZ)
@@ -387,24 +455,6 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 		goto out;
 	}
 
-	/* objdump struggles with kcore - try each map only once */
-	if (dso__is_kcore(dso)) {
-		size_t d;
-
-		for (d = 0; d < state->done_cnt; d++) {
-			if (state->done[d] == map__start(al.map)) {
-				pr_debug("kcore map tested already");
-				pr_debug(" - skipping\n");
-				goto out;
-			}
-		}
-		if (state->done_cnt >= ARRAY_SIZE(state->done)) {
-			pr_debug("Too many kcore maps - skipping\n");
-			goto out;
-		}
-		state->done[state->done_cnt++] = map__start(al.map);
-	}
-
 	objdump_name = dso__long_name(dso);
 	if (dso__needs_decompress(dso)) {
 		if (dso__decompress_kmodule_path(dso, objdump_name,
@@ -471,9 +521,9 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 	return err;
 }
 
-static int process_sample_event(struct machine *machine,
-				struct evlist *evlist,
-				union perf_event *event, struct state *state)
+static int process_sample_event(struct machine *machine, struct evlist *evlist,
+				union perf_event *event,
+				struct rb_root *tested_sections)
 {
 	struct perf_sample sample;
 	struct thread *thread;
@@ -494,7 +544,8 @@ static int process_sample_event(struct machine *machine,
 		goto out;
 	}
 
-	ret = read_object_code(sample.ip, READLEN, sample.cpumode, thread, state);
+	ret = read_object_code(sample.ip, READLEN, sample.cpumode, thread,
+			       tested_sections);
 	thread__put(thread);
 out:
 	perf_sample__exit(&sample);
@@ -502,10 +553,11 @@ static int process_sample_event(struct machine *machine,
 }
 
 static int process_event(struct machine *machine, struct evlist *evlist,
-			 union perf_event *event, struct state *state)
+			 union perf_event *event, struct rb_root *tested_sections)
 {
 	if (event->header.type == PERF_RECORD_SAMPLE)
-		return process_sample_event(machine, evlist, event, state);
+		return process_sample_event(machine, evlist, event,
+					    tested_sections);
 
 	if (event->header.type == PERF_RECORD_THROTTLE ||
 	    event->header.type == PERF_RECORD_UNTHROTTLE)
@@ -525,7 +577,7 @@ static int process_event(struct machine *machine, struct evlist *evlist,
 }
 
 static int process_events(struct machine *machine, struct evlist *evlist,
-			  struct state *state)
+			  struct rb_root *tested_sections)
 {
 	union perf_event *event;
 	struct mmap *md;
@@ -537,7 +589,7 @@ static int process_events(struct machine *machine, struct evlist *evlist,
 			continue;
 
 		while ((event = perf_mmap__read_event(&md->core)) != NULL) {
-			ret = process_event(machine, evlist, event, state);
+			ret = process_event(machine, evlist, event, tested_sections);
 			perf_mmap__consume(&md->core);
 			if (ret < 0)
 				return ret;
@@ -637,9 +689,7 @@ static int do_test_code_reading(bool try_kcore)
 			.uses_mmap   = true,
 		},
 	};
-	struct state state = {
-		.done_cnt = 0,
-	};
+	struct rb_root tested_sections = RB_ROOT;
 	struct perf_thread_map *threads = NULL;
 	struct perf_cpu_map *cpus = NULL;
 	struct evlist *evlist = NULL;
@@ -773,7 +823,7 @@ static int do_test_code_reading(bool try_kcore)
 
 	evlist__disable(evlist);
 
-	ret = process_events(machine, evlist, &state);
+	ret = process_events(machine, evlist, &tested_sections);
 	if (ret < 0)
 		goto out_put;
 
@@ -793,6 +843,7 @@ static int do_test_code_reading(bool try_kcore)
 	perf_thread_map__put(threads);
 	machine__delete(machine);
 	perf_env__exit(&host_env);
+	tested_sections__free(&tested_sections);
 
 	return err;
 }

---
base-commit: a22d167ed82505f770340c3a7c257c04ba24dac9
change-id: 20251006-james-perf-object-code-reading-9646e486d595

Best regards,
-- 
James Clark <james.clark@linaro.org>

