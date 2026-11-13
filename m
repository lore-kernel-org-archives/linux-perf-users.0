Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604274;
	b=EqSM3fF1SqURRZYcmz+XicpodepnYx9720nr1NkI1bnVaFfGwkGlN3sEKoyZN3zLpZd3
	 4pgP7MiAlgc+XYBZDeYLb0iIfWCZf75oCHD4HiZs+qDHHoev8p7eFdU7mhbFyqyoL3cFT
	 +hmkAnVbgVJIw4/Ex8QKeJa3ADm+JOekjsCkwt3DOz9UV14zRR9aufsDm7XWcwNBhQ1Sa
	 IlhSOsAcedt5LDdIISqZI1hhBLdpjz6aaAlZkCAwIruClLhjamcdH1JyyOc7nbD2oQIKw
	 aP0TUIz4hcTJ+vUt1wUyznwifv9B34/yOthwqtNGz+JN047GHF5tgp6XzaXYYbjrqsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604274;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=lJbx/9/bxRie1Vn/nZGlTEpf8lzACywxzUaMCTo6+iM=;
	b=Rm4p7BMXHGNl2B+aKojzar6ECtgTa/bFT6xuvZDntS/zIV/6LmETqBTnwHfmnhS8ZWi5
	 MD2sZW1VeGCNtV/ChvzYwqVuKM4okoFDTxz/Y1tj7ry+yI6g/B6va5v0g9NehpHwUS8MU
	 hP2HVFJ+eIAI5OvcEs1UoDOMWUeMwI12VL374Q+ecS4y5Y6lLTnyHsXdGYccfRHYI0Y9x
	 gGEYsxErKRqjf9R10oGHjJXGDoFBdKxKj7Yo27WtwpBb/5kqRBgU1R9sGZ/UmGeCI/NR2
	 /Kj6GrduL5UgOgWhsozObnTbXqv0zqNCBFzIOKLSQQwexAS6dh5vwRp4RIHRjqexIVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mX3QeYU9;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B17606A8A9
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95B17606A8A9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mX3QeYU9
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30bcb065bfdso1807111eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 13:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794604273; x=1795209073; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lJbx/9/bxRie1Vn/nZGlTEpf8lzACywxzUaMCTo6+iM=;
        b=mX3QeYU9t+wu6R3a4P6xVvxufpfInG3POmaQoKoJpHkpByhROXeI47vK0q29Luh5T3
         9ziRAj3qdZ2sgokIYiyc9sFy2RnISOtCVIJLGsCIIpowTjt/LmRWjPPs8nWuXHzjcger
         JPMdPH4Olmrfn4seAExb5TqEBgBjttr/KdjM6kG0TsX6PQHWe7LwpoOsh9bxGsPdw+5r
         Y12kBb+cD+Y9TS/5w8eIvhpgyAlQg2zgzamh22nRE6IMZQC6fxfBq6Q/8Fs4ntZdKuS/
         LE42lU6Kt+ix/0oWalrGk6aYDuUC68tP7jx/IJu8w5sMAJfB1ZsbK0GV1dxPTFzq9U/d
         5xdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794604273; x=1795209073;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lJbx/9/bxRie1Vn/nZGlTEpf8lzACywxzUaMCTo6+iM=;
        b=2n/H9wG6HnXnJZJYlxVsIVRcO6LVK9K4bnJd5jSvnVR6AQJHWNaSRzlCbtiKk+PS/d
         jusBy38e9P2RvKKYhrQxvlX+LvS86DkCCQTBZ5x7fvfEQU+ypP3MaLV6xM+6lQ9JpCtH
         mKXX2nJ8FcO3YbUMWiecGlUqi090cLx2i0pufeNKxyASiexMrNalxTrVBLzu6LyUprI5
         JWoafRnBwnhOZEPrR5GJwXkYJ1lgjkI0Nj7XigGZKuC11rHlryJu0ZHxcmdxBaGJUi8d
         rOD7EIPZDrKkPefnO4YJ1tldulDp0v2Yo517LCH2XWNeGUPUdTQ+Vv1QzpAJzWM68Y4j
         ArAw==
X-Forwarded-Encrypted: i=1; AL+hErEa4UAlkcJJL71+2UHn60eUYG3ChbdFQ0mgqpL468Wk+OD5ymuSOWoW6sqkO3q7aKpXfIovXFICWmKHeprw/88Q@vger.kernel.org
X-Gm-Message-State: APuU4Z9Y3wzgMNopdHoHQBlpWI2wR+L2W6jB/RcJVegdyFzOS5YqKtAx
	rX4NXUTM9vqDm60enUlQ2N0d8F86C7WkzFR6Cvg012c+OJmTuCzAn8TiJR2AoKdhORg62Yx7WiF
	F61KIQeLsIw==
X-Received: from dyax22-n1.prod.google.com ([2002:a05:693c:4196:10b0:33e:5767:2163])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:f18e:b0:360:b8b4:840a
 with SMTP id 5a478bee46e88-37967ad9187mr3983497eec.39.1794604271929; Fri, 13
 Nov 2026 13:11:11 -0800 (PST)
Date: Fri, 13 Nov 2026 13:10:52 -0800
In-Reply-To: <20261113211105.3118281-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113211105.3118281-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113211105.3118281-2-irogers@google.com>
Subject: [PATCH 01/11] perf pmu: Generalize pmu_alias_info_file() and lazy
 single-event sysfs loading
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Prepare struct perf_pmu_alias and sysfs event loading for layered
filesystem overlays while keeping struct perf_pmu_alias private to
pmu.c:

1. Add enum pmu_event_file_kind and pmu_event_file_kind() in pmu.c,
   teaching pmu_alias_info_file() to recognize extended sidecar
   extensions (.scale-unit, .desc, .long-desc, .topic, .compat,
   .deprecated, .legacy-terms, .retire-lat-mean, .retire-lat-min, and
   .retire-lat-max) alongside existing kernel sysfs sidecars (.unit,
   .scale, .per-pkg, and .snapshot).
2. Switch sidecar attribute readers to openat() relative to an open
   events directory fd, allowing boolean sidecars to express both 0
   and 1 and marking alias->info_loaded once read so sidecars are not
   re-opened repeatedly.
3. Make perf_pmu__find_alias() lazily open only the requested event
   (trying exact, lowercase, and uppercase names) and its sidecars via
   openat() instead of calling pmu_aliases_parse() to readdir() and
   open every file in <sysfs>/<pmu>/events/ on a single-event lookup.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 365 +++++++++++++++++++++++++++++-------------
 1 file changed, 252 insertions(+), 113 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 01753d5c69d1..d10b8c0810fb 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -10,9 +10,11 @@
 #include <unistd.h>
 #include <errno.h>
 #include <stdbool.h>
+#include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <strings.h>
 #include <dirent.h>
 #include <api/fs/fs.h>
 #include <api/io.h>
@@ -54,9 +56,28 @@ enum event_source {
 	EVENT_SRC_SYS_JSON,
 };
 
+enum pmu_event_file_kind {
+	PMU_EVENT_FILE_BASE,
+	PMU_EVENT_FILE_UNIT,
+	PMU_EVENT_FILE_SCALE,
+	PMU_EVENT_FILE_PER_PKG,
+	PMU_EVENT_FILE_SNAPSHOT,
+	PMU_EVENT_FILE_SCALE_UNIT,
+	PMU_EVENT_FILE_DESC,
+	PMU_EVENT_FILE_LONG_DESC,
+	PMU_EVENT_FILE_TOPIC,
+	PMU_EVENT_FILE_COMPAT,
+	PMU_EVENT_FILE_DEPRECATED,
+	PMU_EVENT_FILE_LEGACY_TERMS,
+	PMU_EVENT_FILE_RETIRE_LAT_MEAN,
+	PMU_EVENT_FILE_RETIRE_LAT_MIN,
+	PMU_EVENT_FILE_RETIRE_LAT_MAX,
+};
+
 /**
- * struct perf_pmu_alias - An event either read from sysfs or builtin in
- * pmu-events.c, created by parsing the pmu-events json files.
+ * struct perf_pmu_alias - An event either read from sysfs, a directory
+ * overlay, or builtin in pmu-events.c, created by parsing the pmu-events json
+ * files.
  */
 struct perf_pmu_alias {
 	/** @name: Name of the event like "mem-loads". */
@@ -74,7 +95,7 @@ struct perf_pmu_alias {
 	char *terms;
 	/**
 	 * @legacy_terms: If the event aliases a legacy event, holds a copy
-	 * ofthe legacy event string.
+	 * of the legacy event string.
 	 */
 	char *legacy_terms;
 	/**
@@ -82,8 +103,10 @@ struct perf_pmu_alias {
 	 * differ from the PMU name as it won't have suffixes.
 	 */
 	char *pmu_name;
+	/** @compat: Optional uncore/system PMU identifier match pattern. */
+	char *compat;
 	/** @unit: Units for the event, such as bytes or cache lines. */
-	char unit[UNIT_MAX_LEN+1];
+	char unit[UNIT_MAX_LEN + 1];
 	/** @scale: Value to scale read counter values by. */
 	double scale;
 	/** @retirement_latency_mean: Value to be given for unsampled retirement latency mean. */
@@ -111,7 +134,7 @@ struct perf_pmu_alias {
 	bool deprecated;
 	/**
 	 * @legacy_deprecated_checked: Legacy events may not be supported by the
-	 * PMU need to be checked. If they aren't supported they are marked
+	 * PMU and need to be checked. If they aren't supported they are marked
 	 * deprecated.
 	 */
 	bool legacy_deprecated_checked;
@@ -119,6 +142,26 @@ struct perf_pmu_alias {
 	bool from_sysfs;
 	/** @info_loaded: Have the scale, unit and other values been read from disk? */
 	bool info_loaded;
+	/** @resolved: Fully resolved across all PMU layers. */
+	bool resolved;
+	/** @terms_from_legacy: @terms was promoted from @legacy_terms. */
+	bool terms_from_legacy;
+	/** @has_scale: Has scale been explicitly set by a layer? */
+	bool has_scale;
+	/** @has_unit: Has unit been explicitly set by a layer? */
+	bool has_unit;
+	/** @has_per_pkg: Has per_pkg been explicitly set by a layer? */
+	bool has_per_pkg;
+	/** @has_snapshot: Has snapshot been explicitly set by a layer? */
+	bool has_snapshot;
+	/** @has_deprecated: Has deprecated been explicitly set by a layer? */
+	bool has_deprecated;
+	/** @has_retire_lat_mean: Has retirement_latency_mean been explicitly set? */
+	bool has_retire_lat_mean;
+	/** @has_retire_lat_min: Has retirement_latency_min been explicitly set? */
+	bool has_retire_lat_min;
+	/** @has_retire_lat_max: Has retirement_latency_max been explicitly set? */
+	bool has_retire_lat_max;
 };
 
 static int pmu_aliases_parse(struct perf_pmu *pmu);
@@ -295,28 +338,64 @@ int perf_pmu__convert_scale(const char *scale, char **end, double *sval)
 	return parse_double(scale, end, sval);
 }
 
-static int perf_pmu__parse_scale(struct perf_pmu *pmu, struct perf_pmu_alias *alias)
+static const struct {
+	const char *suffix;
+	size_t len;
+	enum pmu_event_file_kind kind;
+} pmu_event_suffixes[] = {
+	{ ".unit",		5,  PMU_EVENT_FILE_UNIT },
+	{ ".desc",		5,  PMU_EVENT_FILE_DESC },
+	{ ".scale",		6,  PMU_EVENT_FILE_SCALE },
+	{ ".topic",		6,  PMU_EVENT_FILE_TOPIC },
+	{ ".compat",		7,  PMU_EVENT_FILE_COMPAT },
+	{ ".per-pkg",		8,  PMU_EVENT_FILE_PER_PKG },
+	{ ".snapshot",		9,  PMU_EVENT_FILE_SNAPSHOT },
+	{ ".long-desc",		10, PMU_EVENT_FILE_LONG_DESC },
+	{ ".scale-unit",	11, PMU_EVENT_FILE_SCALE_UNIT },
+	{ ".deprecated",	11, PMU_EVENT_FILE_DEPRECATED },
+	{ ".legacy-terms",	13, PMU_EVENT_FILE_LEGACY_TERMS },
+	{ ".retire-lat-min",	15, PMU_EVENT_FILE_RETIRE_LAT_MIN },
+	{ ".retire-lat-max",	15, PMU_EVENT_FILE_RETIRE_LAT_MAX },
+	{ ".retire-lat-mean",	16, PMU_EVENT_FILE_RETIRE_LAT_MEAN },
+};
+
+static enum pmu_event_file_kind pmu_event_file_kind(const char *name, size_t *base_len)
+{
+	size_t len = strlen(name);
+
+	for (size_t i = 0; i < ARRAY_SIZE(pmu_event_suffixes); i++) {
+		size_t slen = pmu_event_suffixes[i].len;
+
+		if (len > slen && !strcasecmp(name + len - slen, pmu_event_suffixes[i].suffix)) {
+			if (base_len)
+				*base_len = len - slen;
+			return pmu_event_suffixes[i].kind;
+		}
+	}
+	if (base_len)
+		*base_len = len;
+	return PMU_EVENT_FILE_BASE;
+}
+
+static inline bool pmu_alias_info_file(const char *name)
+{
+	return pmu_event_file_kind(name, NULL) != PMU_EVENT_FILE_BASE;
+}
+
+static int perf_pmu__parse_scale_at(int events_dir_fd, const char *event_name,
+				    struct perf_pmu_alias *alias)
 {
-	struct stat st;
 	ssize_t sret;
-	size_t len;
 	char scale[128];
+	char filename[NAME_MAX + 16];
 	int fd, ret = -1;
-	char path[PATH_MAX];
-
-	len = perf_pmu__event_source_devices_scnprintf(path, sizeof(path));
-	if (!len)
-		return 0;
-	scnprintf(path + len, sizeof(path) - len, "%s/events/%s.scale", pmu->name, alias->name);
 
-	fd = open(path, O_RDONLY);
+	scnprintf(filename, sizeof(filename), "%s.scale", event_name);
+	fd = openat(events_dir_fd, filename, O_RDONLY);
 	if (fd == -1)
 		return -1;
 
-	if (fstat(fd, &st) < 0)
-		goto error;
-
-	sret = read(fd, scale, sizeof(scale)-1);
+	sret = read(fd, scale, sizeof(scale) - 1);
 	if (sret <= 0)
 		goto error;
 
@@ -326,25 +405,22 @@ static int perf_pmu__parse_scale(struct perf_pmu *pmu, struct perf_pmu_alias *al
 		scale[sret] = '\0';
 
 	ret = perf_pmu__convert_scale(scale, NULL, &alias->scale);
+	if (!ret)
+		alias->has_scale = true;
 error:
 	close(fd);
 	return ret;
 }
 
-static int perf_pmu__parse_unit(struct perf_pmu *pmu, struct perf_pmu_alias *alias)
+static int perf_pmu__parse_unit_at(int events_dir_fd, const char *event_name,
+				   struct perf_pmu_alias *alias)
 {
-	char path[PATH_MAX];
-	size_t len;
+	char filename[NAME_MAX + 16];
 	ssize_t sret;
 	int fd;
 
-
-	len = perf_pmu__event_source_devices_scnprintf(path, sizeof(path));
-	if (!len)
-		return 0;
-	scnprintf(path + len, sizeof(path) - len, "%s/events/%s.unit", pmu->name, alias->name);
-
-	fd = open(path, O_RDONLY);
+	scnprintf(filename, sizeof(filename), "%s.unit", event_name);
+	fd = openat(events_dir_fd, filename, O_RDONLY);
 	if (fd == -1)
 		return -1;
 
@@ -359,6 +435,7 @@ static int perf_pmu__parse_unit(struct perf_pmu *pmu, struct perf_pmu_alias *ali
 	else
 		alias->unit[sret] = '\0';
 
+	alias->has_unit = true;
 	return 0;
 error:
 	close(fd);
@@ -366,45 +443,57 @@ static int perf_pmu__parse_unit(struct perf_pmu *pmu, struct perf_pmu_alias *ali
 	return -1;
 }
 
-static bool perf_pmu__parse_event_source_bool(const char *pmu_name, const char *event_name,
-					      const char *suffix)
+static int perf_pmu__parse_bool_at(int events_dir_fd, const char *event_name,
+				   const char *suffix, bool *out_val)
 {
-	char path[PATH_MAX];
-	size_t len;
+	char filename[NAME_MAX + 32];
+	char buf[16];
+	ssize_t sret;
 	int fd;
 
-	len = perf_pmu__event_source_devices_scnprintf(path, sizeof(path));
-	if (!len)
-		return false;
-
-	scnprintf(path + len, sizeof(path) - len, "%s/events/%s.%s", pmu_name, event_name, suffix);
-
-	fd = open(path, O_RDONLY);
+	scnprintf(filename, sizeof(filename), "%s.%s", event_name, suffix);
+	fd = openat(events_dir_fd, filename, O_RDONLY);
 	if (fd == -1)
-		return false;
+		return -ENOENT;
 
-#ifndef NDEBUG
-	{
-		char buf[8];
+	sret = read(fd, buf, sizeof(buf) - 1);
+	close(fd);
+	if (sret <= 0)
+		return -EINVAL;
 
-		len = read(fd, buf, sizeof(buf));
-		assert(len == 1 || len == 2);
-		assert(buf[0] == '1');
-	}
-#endif
+	while (sret > 0 && isspace(buf[sret - 1]))
+		sret--;
+	buf[sret] = '\0';
 
-	close(fd);
-	return true;
+	if (!strcmp(buf, "1") || !strcasecmp(buf, "true") || !strcasecmp(buf, "yes")) {
+		*out_val = true;
+		return 0;
+	}
+	if (!strcmp(buf, "0") || !strcasecmp(buf, "false") || !strcasecmp(buf, "no")) {
+		*out_val = false;
+		return 0;
+	}
+	return -EINVAL;
 }
 
-static void perf_pmu__parse_per_pkg(struct perf_pmu *pmu, struct perf_pmu_alias *alias)
+static void read_alias_info_at(int events_dir_fd, struct perf_pmu_alias *alias)
 {
-	alias->per_pkg = perf_pmu__parse_event_source_bool(pmu->name, alias->name, "per-pkg");
-}
+	bool val;
 
-static void perf_pmu__parse_snapshot(struct perf_pmu *pmu, struct perf_pmu_alias *alias)
-{
-	alias->snapshot = perf_pmu__parse_event_source_bool(pmu->name, alias->name, "snapshot");
+	if (!alias->from_sysfs || alias->info_loaded || events_dir_fd < 0)
+		return;
+
+	perf_pmu__parse_unit_at(events_dir_fd, alias->name, alias);
+	perf_pmu__parse_scale_at(events_dir_fd, alias->name, alias);
+	if (perf_pmu__parse_bool_at(events_dir_fd, alias->name, "per-pkg", &val) == 0) {
+		alias->per_pkg = val;
+		alias->has_per_pkg = true;
+	}
+	if (perf_pmu__parse_bool_at(events_dir_fd, alias->name, "snapshot", &val) == 0) {
+		alias->snapshot = val;
+		alias->has_snapshot = true;
+	}
+	alias->info_loaded = true;
 }
 
 /* Delete an alias entry. */
@@ -418,6 +507,7 @@ static void perf_pmu_free_alias(struct perf_pmu_alias *alias)
 	zfree(&alias->long_desc);
 	zfree(&alias->topic);
 	zfree(&alias->pmu_name);
+	zfree(&alias->compat);
 	zfree(&alias->terms);
 	zfree(&alias->legacy_terms);
 	free(alias);
@@ -438,13 +528,22 @@ static void perf_pmu__del_aliases(struct perf_pmu *pmu)
 	pmu->aliases = NULL;
 }
 
+static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
+			       const char *desc, const char *val, int val_fd,
+			       const struct pmu_event *pe, enum event_source src,
+			       int events_dir_fd);
+
 static struct perf_pmu_alias *perf_pmu__find_alias(struct perf_pmu *pmu,
 						   const char *name,
 						   bool load)
 {
-	struct perf_pmu_alias *alias;
-	bool has_sysfs_event;
-	char event_file_name[NAME_MAX + 8];
+	struct perf_pmu_alias *alias = NULL;
+	char path[PATH_MAX];
+	char lower_name[NAME_MAX];
+	char upper_name[NAME_MAX];
+	const char *candidates[3];
+	size_t nr_candidates = 0, name_len, path_len;
+	int events_dir_fd;
 
 	if (hashmap__find(pmu->aliases, name, &alias))
 		return alias;
@@ -452,29 +551,61 @@ static struct perf_pmu_alias *perf_pmu__find_alias(struct perf_pmu *pmu,
 	if (!load || pmu->sysfs_aliases_loaded)
 		return NULL;
 
-	/*
-	 * Test if alias/event 'name' exists in the PMU's sysfs/events
-	 * directory. If not skip parsing the sysfs aliases. Sysfs event
-	 * name must be all lower or all upper case.
-	 */
-	scnprintf(event_file_name, sizeof(event_file_name), "events/%s", name);
-	for (size_t i = 7, n = 7 + strlen(name); i < n; i++)
-		event_file_name[i] = tolower(event_file_name[i]);
+	name_len = strlen(name);
+	if (name_len == 0 || name_len >= NAME_MAX || name[0] == '.' ||
+	    strchr(name, '/') || pmu_alias_info_file(name))
+		return NULL;
 
-	has_sysfs_event = perf_pmu__file_exists(pmu, event_file_name);
-	if (!has_sysfs_event) {
-		for (size_t i = 7, n = 7 + strlen(name); i < n; i++)
-			event_file_name[i] = toupper(event_file_name[i]);
+	path_len = perf_pmu__event_source_devices_scnprintf(path, sizeof(path));
+	if (!path_len)
+		return NULL;
+	scnprintf(path + path_len, sizeof(path) - path_len, "%s/events", pmu->name);
 
-		has_sysfs_event = perf_pmu__file_exists(pmu, event_file_name);
+	events_dir_fd = open(path, O_DIRECTORY | O_RDONLY);
+	if (events_dir_fd == -1) {
+		if (errno == ENOENT)
+			pmu->sysfs_aliases_loaded = true;
+		return NULL;
 	}
-	if (has_sysfs_event) {
-		pmu_aliases_parse(pmu);
-		if (hashmap__find(pmu->aliases, name, &alias))
-			return alias;
+
+	candidates[nr_candidates++] = name;
+	for (size_t i = 0; i < name_len; i++) {
+		lower_name[i] = tolower((unsigned char)name[i]);
+		upper_name[i] = toupper((unsigned char)name[i]);
 	}
+	lower_name[name_len] = '\0';
+	upper_name[name_len] = '\0';
 
-	return NULL;
+	if (strcmp(lower_name, name) != 0)
+		candidates[nr_candidates++] = lower_name;
+	if (strcmp(upper_name, name) != 0 && strcmp(upper_name, lower_name) != 0)
+		candidates[nr_candidates++] = upper_name;
+
+	/*
+	 * Lazily open only the requested event and its sidecars via openat()
+	 * rather than scanning every file in sysfs/events/.
+	 */
+	for (size_t i = 0; i < nr_candidates; i++) {
+		struct stat st;
+		int fd = openat(events_dir_fd, candidates[i], O_RDONLY);
+
+		if (fd < 0)
+			continue;
+		if (fstat(fd, &st) == 0 && !S_ISDIR(st.st_mode)) {
+			if (perf_pmu__new_alias(pmu, candidates[i], /*desc=*/NULL,
+						/*val=*/NULL, fd, /*pe=*/NULL,
+						EVENT_SRC_SYSFS, events_dir_fd) == 0 &&
+			    hashmap__find(pmu->aliases, name, &alias)) {
+				read_alias_info_at(events_dir_fd, alias);
+				close(fd);
+				break;
+			}
+		}
+		close(fd);
+	}
+
+	close(events_dir_fd);
+	return alias;
 }
 
 static bool assign_str(const char *name, const char *field, char **old_str,
@@ -497,21 +628,30 @@ static bool assign_str(const char *name, const char *field, char **old_str,
 
 static void read_alias_info(struct perf_pmu *pmu, struct perf_pmu_alias *alias)
 {
+	char path[PATH_MAX];
+	size_t len;
+	int events_dir_fd;
+
 	if (!alias->from_sysfs || alias->info_loaded)
 		return;
 
-	/*
-	 * load unit name and scale if available
-	 */
-	perf_pmu__parse_unit(pmu, alias);
-	perf_pmu__parse_scale(pmu, alias);
-	perf_pmu__parse_per_pkg(pmu, alias);
-	perf_pmu__parse_snapshot(pmu, alias);
+	len = perf_pmu__event_source_devices_scnprintf(path, sizeof(path));
+	if (!len)
+		return;
+	scnprintf(path + len, sizeof(path) - len, "%s/events", pmu->name);
+
+	events_dir_fd = open(path, O_DIRECTORY | O_RDONLY);
+	if (events_dir_fd == -1)
+		return;
+
+	read_alias_info_at(events_dir_fd, alias);
+	close(events_dir_fd);
 }
 
 struct update_alias_data {
 	struct perf_pmu *pmu;
 	struct perf_pmu_alias *alias;
+	int events_dir_fd;
 	bool legacy;
 };
 
@@ -522,7 +662,10 @@ static int update_alias(const struct pmu_event *pe,
 	struct update_alias_data *data = vdata;
 	int ret = 0;
 
-	read_alias_info(data->pmu, data->alias);
+	if (data->events_dir_fd >= 0)
+		read_alias_info_at(data->events_dir_fd, data->alias);
+	else
+		read_alias_info(data->pmu, data->alias);
 	assign_str(pe->name, "desc", &data->alias->desc, pe->desc);
 	assign_str(pe->name, "long_desc", &data->alias->long_desc, pe->long_desc);
 	assign_str(pe->name, "topic", &data->alias->topic, pe->topic);
@@ -559,8 +702,9 @@ static int update_alias(const struct pmu_event *pe,
 }
 
 static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
-				const char *desc, const char *val, int val_fd,
-			        const struct pmu_event *pe, enum event_source src)
+			       const char *desc, const char *val, int val_fd,
+			       const struct pmu_event *pe, enum event_source src,
+			       int events_dir_fd)
 {
 	struct perf_pmu_alias *alias, *old_alias;
 	int ret = 0;
@@ -607,8 +751,10 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 		ret = parse_double(pe->retirement_latency_max, NULL,
 				   &alias->retirement_latency_max);
 	}
-	if (ret)
+	if (ret) {
+		perf_pmu_free_alias(alias);
 		return ret;
+	}
 
 	if (val_fd < 0) {
 		alias->terms = strdup(val);
@@ -621,6 +767,7 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 		ret = io__getline(&io, &alias->terms, &line_len) < 0 ? -errno : 0;
 		if (ret) {
 			pr_err("Failed to read alias %s\n", name);
+			perf_pmu_free_alias(alias);
 			return ret;
 		}
 		if (line_len >= 1 && alias->terms[line_len - 1] == '\n')
@@ -631,6 +778,7 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 	alias->long_desc = long_desc ? strdup(long_desc) : NULL;
 	alias->topic = topic ? strdup(topic) : NULL;
 	alias->pmu_name = pmu_name ? strdup(pmu_name) : NULL;
+	alias->compat = (pe && pe->compat) ? strdup(pe->compat) : NULL;
 	if (unit) {
 		if (perf_pmu__convert_scale(unit, (char **)&unit, &alias->scale) < 0) {
 			perf_pmu_free_alias(alias);
@@ -647,6 +795,7 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 			struct update_alias_data data = {
 				.pmu = pmu,
 				.alias = alias,
+				.events_dir_fd = events_dir_fd,
 				.legacy = false,
 			};
 			if ((pmu_events_table__find_event(pmu->events_table, pmu, name,
@@ -681,28 +830,11 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 	return 0;
 }
 
-static inline bool pmu_alias_info_file(const char *name)
-{
-	size_t len;
-
-	len = strlen(name);
-	if (len > 5 && !strcmp(name + len - 5, ".unit"))
-		return true;
-	if (len > 6 && !strcmp(name + len - 6, ".scale"))
-		return true;
-	if (len > 8 && !strcmp(name + len - 8, ".per-pkg"))
-		return true;
-	if (len > 9 && !strcmp(name + len - 9, ".snapshot"))
-		return true;
-
-	return false;
-}
-
 /*
  * Reading the pmu event aliases definition, which should be located at:
  * /sys/bus/event_source/devices/<dev>/events as sysfs group attributes.
  */
-static int __pmu_aliases_parse(struct perf_pmu *pmu, int events_dir_fd)
+static int __pmu_aliases_parse(struct perf_pmu *pmu, int events_dir_fd, bool eager_info)
 {
 	struct io_dirent64 *evt_ent;
 	struct io_dir event_dir;
@@ -713,7 +845,7 @@ static int __pmu_aliases_parse(struct perf_pmu *pmu, int events_dir_fd)
 		char *name = evt_ent->d_name;
 		int fd;
 
-		if (!strcmp(name, ".") || !strcmp(name, ".."))
+		if (!strcmp(name, ".") || !strcmp(name, "..") || name[0] == '.')
 			continue;
 
 		/*
@@ -730,8 +862,14 @@ static int __pmu_aliases_parse(struct perf_pmu *pmu, int events_dir_fd)
 
 		if (perf_pmu__new_alias(pmu, name, /*desc=*/ NULL,
 					/*val=*/ NULL, fd, /*pe=*/ NULL,
-					EVENT_SRC_SYSFS) < 0)
+					EVENT_SRC_SYSFS, events_dir_fd) < 0)
 			pr_debug("Cannot set up %s\n", name);
+		else if (eager_info) {
+			struct perf_pmu_alias *alias;
+
+			if (hashmap__find(pmu->aliases, name, &alias))
+				read_alias_info_at(events_dir_fd, alias);
+		}
 		close(fd);
 	}
 
@@ -758,7 +896,7 @@ static int pmu_aliases_parse(struct perf_pmu *pmu)
 		pmu->sysfs_aliases_loaded = true;
 		return 0;
 	}
-	ret = __pmu_aliases_parse(pmu, events_dir_fd);
+	ret = __pmu_aliases_parse(pmu, events_dir_fd, /*eager_info=*/false);
 	close(events_dir_fd);
 	return ret;
 }
@@ -774,7 +912,7 @@ static int pmu_aliases_parse_eager(struct perf_pmu *pmu, int sysfs_fd)
 		pmu->sysfs_aliases_loaded = true;
 		return 0;
 	}
-	ret = __pmu_aliases_parse(pmu, events_dir_fd);
+	ret = __pmu_aliases_parse(pmu, events_dir_fd, /*eager_info=*/true);
 	close(events_dir_fd);
 	return ret;
 }
@@ -1066,7 +1204,7 @@ static int pmu_add_cpu_aliases_map_callback(const struct pmu_event *pe,
 	struct perf_pmu *pmu = vdata;
 
 	perf_pmu__new_alias(pmu, pe->name, pe->desc, pe->event, /*val_fd=*/ -1,
-			    pe, EVENT_SRC_CPU_JSON);
+			    pe, EVENT_SRC_CPU_JSON, /*events_dir_fd=*/ -1);
 	return 0;
 }
 
@@ -1119,7 +1257,8 @@ static int pmu_add_sys_aliases_iter_fn(const struct pmu_event *pe,
 				pe->event,
 				/*val_fd=*/ -1,
 				pe,
-				EVENT_SRC_SYS_JSON);
+				EVENT_SRC_SYS_JSON,
+				/*events_dir_fd=*/ -1);
 	}
 	return 0;
 }

base-commit: 4af65363b11fc4fe65fcb497f68bbe4f3e3a4d2c
prerequisite-patch-id: 3e93fd262f5e70cff78114a0736c8fc8abeb7977
prerequisite-patch-id: 5e284ee3a3af71e8bfe3e40719396cf60fbece96
prerequisite-patch-id: 4d4b5b43c0ca0ac929fb3b73db615805e022d86a
prerequisite-patch-id: 447412f5e17799157dc8981ffa28378bc5f7fe72
prerequisite-patch-id: ac7b807fcd0e795cc831307eed2d7148a609b941
prerequisite-patch-id: 8c306425c73d176dfeeede044b57f7ed383e19d1
prerequisite-patch-id: dfce7f2910fbd18bc8dc3965c52cf6b08a825180
prerequisite-patch-id: 4730aa572afe4e6d47f6aceaff92fccc15327881
prerequisite-patch-id: 17cb0dd6eaa58cec5d6309dda84f122c6e381d4d
prerequisite-patch-id: cda8414fd68671e1333246f22cbfedb980173821
-- 
2.56.1.703.gf848ed807c-goog

