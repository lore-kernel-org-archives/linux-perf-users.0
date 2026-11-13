Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604301;
	b=TYAC44REhm9U9aAhSk8YYAtaM6U3qWJkhQl4BydcZVMNE+KTVuutL0td59EglGQdgp9+
	 9MnnfgX5yJEIEyCcMKLaCyeBFmcUyDjXLmJaQdBFFwavygz3TJxDYzT3GGUzilhyizs1G
	 7CwuoiJo9P59comuO3ViH0w+yFbIrD1R8F/X5TsiVEpD4f+uxNgpyn+61D8QY00sq79Do
	 0ai3aIXPVe/h81rlE2CS0+3GU1bEmydXC+fgV98s8uVFXPGc5ejlX9lVNT5fCzYhEWGdT
	 wkVoqi0rHxkdOGfDng+m7/2nM12QP/0JnYrLxqFEBG+xVlAtdD22xJknmDr+j2pm4iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604301;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=lsyocvjfIt88T5te3y3g6U0O59c6WDDtXNiSI2mDl7M=;
	b=u5dJBvKXYyEDw1dLV4UOHZasj1BfJLGZ9k/BHtMdFXwHehmtuHlXsodGlG/wJw8wcvRx
	 TO9tcepu995/kXsWzokLTaXSFmXNDuGNEUKHWwZrE6kh+RJnvSVitS0mlFRccLz/Yije5
	 UXteRC1PsOpI46Twl5zMCbTvy4wZEdj9cB+n/rrRQSIaLgFMB6+4xv2yfFtWI29OVK+VB
	 zARoJZ0tTFwDX1kYZUkWDNcPp33oH2HowsginaC5NNUDPk1InIPEnATJzYO+gk6xnU7eL
	 5vhaPjT4TDwYwcmhRrKezqV72SDIfS14k++TjS7gsfiGTAEqk6H76Pg45jWIqbysebQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ry3LRLTG;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1110E60A3801
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1110E60A3801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ry3LRLTG
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36efb506f29so1560702eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 13:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794604299; x=1795209099; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lsyocvjfIt88T5te3y3g6U0O59c6WDDtXNiSI2mDl7M=;
        b=Ry3LRLTGzzvGXmp31n3zaYuHAY1/2utuCPaHXlg88DPPZ7Csc9UDf9jnRJgIQ1QOqg
         ewULDvvqKSD0a4+6x7dvNVpVjwWs+Krk9wIWnRsNU7IBOdjqLJ6jBXwOGACmpa5U8qZz
         NSfOZXZBDQgR6mwU+Jl4KG5n96UdVUCbLv7pN9KqQaoJqqMkVPr+YtiIXGVeEzKFy+dF
         tb0/hMZsGaq8ry5V4sYbP0gHA58/xA03Nuxjv5kvjhy5PpSqMQqFidam+enGcgNmfndQ
         gArrGS7PIVKFY4wDKE69Dhgbfr5mnSwVGExLWBEpM8hU/SpzGz9NX6//aHEPT3XVzjJ9
         emnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794604299; x=1795209099;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lsyocvjfIt88T5te3y3g6U0O59c6WDDtXNiSI2mDl7M=;
        b=eKS6gUueIyzq6jUO0a2ATNz7m58YBSMGZOiLQqe98l5iKRXr0ItWBWGOL40eX6zAS4
         WRVWhyH03TQGCaNPC9PJXb9FOhB0XF6F+v+YploBXzfKPkZASmuNFb/EbQ+sDgMtMFBL
         evCGVoiDQ8sAjsRuQcyxqR0UVy3EE9+GGX3nBXMHZ0Iy8qTW0g8AEOpgE0SMGECJy9Bp
         rX+0hqsm38J1z/l0IutGzCpjb5Z3r7Ao1I0FOLMBIJ0ZGdyGl/NWxEdIs4QySNcAVIny
         nKry3aCvoXeWC/LTTivHmIs5Man6lj8xiBoYsVoCglyD0X8FzJpz/iytUE3y4vfi+ptd
         Px/Q==
X-Forwarded-Encrypted: i=1; AL+hErH7GZHL46q8wOIwlbMtvaRznsZkm4pZbd0UWm59oC8sZW82EgzrrMH8MbHmlz6l7EbQNtnGRmdPw7bz1agty/UF@vger.kernel.org
X-Gm-Message-State: APuU4Z/XHH/YOdAn6NyvhYroZgHub8lTo+NOarZNnUxl+xlr1jOeL01m
	6809dxnYolXaekg2jwDZejubTGxPyKqDYHBkMZhGehDKAGBoJUkTvzeexi/a3cB9hoGQoOrOCcD
	AmeCVRXMF4Q==
X-Received: from dyaa19.prod.google.com ([2002:a05:693c:40d3:b0:376:3d5d:fcba])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:b0aa:b0:36e:20ee:b288
 with SMTP id 5a478bee46e88-379655d449fmr3358799eec.12.1794604298636; Fri, 13
 Nov 2026 13:11:38 -0800 (PST)
Date: Fri, 13 Nov 2026 13:11:02 -0800
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
Message-ID: <20261113211105.3118281-12-irogers@google.com>
Subject: [PATCH 11/11] perf tests: Add round-trip export, CPUID symlink, and
 pmu-events.dir overlay tests
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Add C unit and CLI shell tests exercising the layered PMU directory VFS
stack and sysfs-style export tools through public pmu, pmus, and
parse-events APIs (keeping struct perf_pmu_alias and struct
perf_pmu_metric encapsulated):

- In tools/perf/tests/pmu.c (Layered PMU directory overlays):
  Test colon-separated pmu-events.dir overlays via perfconfig, base
  (cpus/GenuineIntel-6-99 -> ../models/x86/mock_arch) and
  stepping-specific (cpus/GenuineIntel-6-99-4 ->
  ../models/x86/mock_arch_step4) CPUID POSIX symlinks via PERF_CPUID
  without mapfile.csv, single-file attribute overrides preserving
  lower-layer sysfs event terms, multi-directory priority overrides
  across events, metrics, and metricgroups, extended event and metric
  sidecars, %2F filename encoding, and heterogeneous multi-instance PMU
  sub-metric resolution.

- In tools/perf/tests/shell/pmu_events_dir.sh:
  Test lossless perf list --export-dir JSON round-tripping via
  PERF_CONFIG, custom user overlay events and metrics executed with perf
  stat -e / -M, file removal restoring lower-layer defaults,
  perf list --export-cpuid (architecture, model, and stepping CPUID
  export, metric filtering, and error handling), and jevents.py
  --output-dir literal CPUID and uncore symlink generation.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/pmu.c                   | 959 +++++++++++++++++++++++
 tools/perf/tests/shell/pmu_events_dir.sh | 236 ++++++
 2 files changed, 1195 insertions(+)
 create mode 100755 tools/perf/tests/shell/pmu_events_dir.sh

diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index f208932590df..fc2a92dbb2b3 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -1,9 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "builtin.h"
+#include "config.h"
 #include "evlist.h"
 #include "evsel.h"
+#include "metricgroup.h"
 #include "parse-events.h"
 #include "pmu.h"
 #include "pmus.h"
+#include "pmu-events/pmu-events.h"
 #include "tests.h"
 #include "debug.h"
 #include "fncache.h"
@@ -12,8 +16,10 @@
 #include <dirent.h>
 #include <errno.h>
 #include <fcntl.h>
+#include <limits.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <unistd.h>
 #include <sys/stat.h>
 #include <sys/types.h>
@@ -628,6 +634,958 @@ static int test__pmu_match(struct test_suite *test __maybe_unused, int subtest _
 	return TEST_OK;
 }
 
+static int overlay_mkdir_p(const char *path)
+{
+	char tmp[PATH_MAX];
+	size_t len = strlen(path);
+
+	if (len == 0 || len >= sizeof(tmp))
+		return -ENAMETOOLONG;
+
+	memcpy(tmp, path, len + 1);
+	for (char *p = tmp + 1; *p; p++) {
+		if (*p != '/')
+			continue;
+		*p = '\0';
+		if (mkdir(tmp, 0755) < 0 && errno != EEXIST)
+			return -errno;
+		*p = '/';
+	}
+	if (mkdir(tmp, 0755) < 0 && errno != EEXIST)
+		return -errno;
+	return 0;
+}
+
+static int overlay_write_file(const char *root, const char *relpath,
+			      const char *content)
+{
+	char full[PATH_MAX];
+	char *slash;
+	size_t len = strlen(content);
+	int fd;
+
+	if (snprintf(full, sizeof(full), "%s/%s", root, relpath) >= (int)sizeof(full))
+		return -ENAMETOOLONG;
+
+	slash = strrchr(full, '/');
+	if (slash) {
+		*slash = '\0';
+		if (overlay_mkdir_p(full) < 0)
+			return -errno;
+		*slash = '/';
+	}
+
+	fd = open(full, O_WRONLY | O_CREAT | O_TRUNC, 0644);
+	if (fd < 0)
+		return -errno;
+
+	if (len > 0 && write(fd, content, len) != (ssize_t)len) {
+		int err = errno ? -errno : -EIO;
+
+		close(fd);
+		return err;
+	}
+	close(fd);
+	return 0;
+}
+
+static int overlay_symlink(const char *root, const char *relpath,
+			   const char *target)
+{
+	char full[PATH_MAX];
+	char *slash;
+
+	if (snprintf(full, sizeof(full), "%s/%s", root, relpath) >= (int)sizeof(full))
+		return -ENAMETOOLONG;
+
+	slash = strrchr(full, '/');
+	if (slash) {
+		*slash = '\0';
+		if (overlay_mkdir_p(full) < 0)
+			return -errno;
+		*slash = '/';
+	}
+	if (symlink(target, full) < 0)
+		return -errno;
+	return 0;
+}
+
+static void overlay_rm_rf_at(int parent_fd, const char *name)
+{
+	struct stat st;
+
+	if (fstatat(parent_fd, name, &st, AT_SYMLINK_NOFOLLOW) < 0)
+		return;
+
+	if (S_ISDIR(st.st_mode)) {
+		int fd = openat(parent_fd, name,
+				O_RDONLY | O_DIRECTORY | O_NOFOLLOW);
+
+		if (fd >= 0) {
+			DIR *dir = fdopendir(fd);
+
+			if (dir) {
+				struct dirent *dent;
+
+				while ((dent = readdir(dir)) != NULL) {
+					if (!strcmp(dent->d_name, ".") ||
+					    !strcmp(dent->d_name, ".."))
+						continue;
+					overlay_rm_rf_at(fd, dent->d_name);
+				}
+				closedir(dir);
+			} else {
+				close(fd);
+			}
+		}
+		unlinkat(parent_fd, name, AT_REMOVEDIR);
+		return;
+	}
+
+	unlinkat(parent_fd, name, 0);
+}
+
+static bool overlay_expect_file(const char *root, const char *relpath,
+				const char *expected)
+{
+	char full[PATH_MAX];
+	char buf[256];
+	ssize_t n;
+	int fd;
+
+	if (snprintf(full, sizeof(full), "%s/%s", root, relpath) >= (int)sizeof(full))
+		return false;
+
+	fd = open(full, O_RDONLY);
+	if (fd < 0)
+		return false;
+
+	n = read(fd, buf, sizeof(buf) - 1);
+	close(fd);
+	if (n < 0)
+		return false;
+
+	buf[n] = '\0';
+	return strcmp(buf, expected) == 0;
+}
+
+struct overlay_event_snapshot {
+	const char *target;
+	bool found;
+	char str[128];
+	char desc[128];
+	char topic[64];
+	char pmu_name[64];
+};
+
+static int snapshot_event_cb(void *state, struct pmu_event_info *info)
+{
+	struct overlay_event_snapshot *snap = state;
+	bool match = info->name && !strcmp(info->name, snap->target);
+
+	if (!match && info->name) {
+		const char *slash = strchr(info->name, '/');
+		const char *end = slash ? strrchr(slash + 1, '/') : NULL;
+		size_t tlen = strlen(snap->target);
+
+		if (slash && end && (size_t)(end - (slash + 1)) == tlen &&
+		    !strncmp(slash + 1, snap->target, tlen))
+			match = true;
+	}
+	if (!match)
+		return 0;
+
+	snap->found = true;
+	snprintf(snap->str, sizeof(snap->str), "%s", info->str ?: "");
+	snprintf(snap->desc, sizeof(snap->desc), "%s", info->desc ?: "");
+	snprintf(snap->topic, sizeof(snap->topic), "%s", info->topic ?: "");
+	snprintf(snap->pmu_name, sizeof(snap->pmu_name), "%s", info->pmu_name ?: "");
+	return 0;
+}
+
+static bool overlay_find_event(struct perf_pmu *pmu, const char *event,
+			       struct overlay_event_snapshot *snap)
+{
+	memset(snap, 0, sizeof(*snap));
+	snap->target = event;
+	if (perf_pmu__for_each_event(pmu, /*skip_duplicate_pmus=*/false,
+				     snap, snapshot_event_cb))
+		return false;
+	return snap->found;
+}
+
+static int count_metrics_cb(const struct pmu_metric *pm __maybe_unused,
+			    const struct pmu_metrics_table *table __maybe_unused,
+			    void *data)
+{
+	int *cnt = data;
+
+	(*cnt)++;
+	return 0;
+}
+
+static int run_pmu_layer_overlay_checks(const char *overlay_root,
+					char *config_path, size_t config_path_sz,
+					char *sysfs_dir, size_t sysfs_dir_sz,
+					struct perf_pmu **pmu_out)
+{
+	char config_body[PATH_MAX * 2];
+	struct perf_pmu *pmu;
+	struct overlay_event_snapshot ev_snap;
+	struct pmu_metric metric;
+	struct evlist *evlist;
+	struct evsel *first_ev;
+	struct parse_events_error err;
+	const char *mg_desc;
+	double parsed_scale = 0.0, parsed_retire_lat = 0.0;
+	char parsed_unit[32] = "";
+	int parse_ret, metric_cnt = 0;
+	u64 parsed_config;
+
+	/*
+	 * Populate dir2 (lower-priority overlay) using a canonical model tree
+	 * linked via a base-CPUID POSIX symlink (no mapfile.csv or regexes).
+	 */
+	TEST_ASSERT_VAL("write base-cpuid-event",
+		overlay_write_file(overlay_root,
+			"dir2/models/testmodel/perf-pmu-test/events/base-cpuid-event",
+			"krava01=1\n") == 0);
+	TEST_ASSERT_VAL("write base-cpuid-event.desc",
+		overlay_write_file(overlay_root,
+			"dir2/models/testmodel/perf-pmu-test/events/base-cpuid-event.desc",
+			"From base CPUID model\n") == 0);
+	TEST_ASSERT_VAL("write base-cpuid-event.topic",
+		overlay_write_file(overlay_root,
+			"dir2/models/testmodel/perf-pmu-test/events/base-cpuid-event.topic",
+			"custom\n") == 0);
+	TEST_ASSERT_VAL("write base-cpuid-event.scale-unit",
+		overlay_write_file(overlay_root,
+			"dir2/models/testmodel/perf-pmu-test/events/base-cpuid-event.scale-unit",
+			"64Bytes\n") == 0);
+	TEST_ASSERT_VAL("write base-cpuid-event.retire-lat-mean",
+		overlay_write_file(overlay_root,
+			"dir2/models/testmodel/perf-pmu-test/events/base-cpuid-event.retire-lat-mean",
+			"12.5\n") == 0);
+	TEST_ASSERT_VAL("write dir2 overridden-event",
+		overlay_write_file(overlay_root,
+			"dir2/models/testmodel/perf-pmu-test/events/overridden-event",
+			"krava01=2\n") == 0);
+	TEST_ASSERT_VAL("write slash%2Fevent",
+		overlay_write_file(overlay_root,
+			"dir2/models/testmodel/perf-pmu-test/events/slash%2Fevent",
+			"krava01=3\n") == 0);
+	TEST_ASSERT_VAL("write slash%2Fevent.desc",
+		overlay_write_file(overlay_root,
+			"dir2/models/testmodel/perf-pmu-test/events/slash%2Fevent.desc",
+			"Encoded slash event\n") == 0);
+
+	TEST_ASSERT_VAL("write base_metric",
+		overlay_write_file(overlay_root,
+			"dir2/models/testmodel/perf-pmu-test/metrics/base_metric",
+			"test-event * 2\n") == 0);
+	TEST_ASSERT_VAL("write base_metric.scale-unit",
+		overlay_write_file(overlay_root,
+			"dir2/models/testmodel/perf-pmu-test/metrics/base_metric.scale-unit",
+			"100%\n") == 0);
+	TEST_ASSERT_VAL("write base_metric.desc",
+		overlay_write_file(overlay_root,
+			"dir2/models/testmodel/perf-pmu-test/metrics/base_metric.desc",
+			"Base metric desc\n") == 0);
+	TEST_ASSERT_VAL("write base_metric.group",
+		overlay_write_file(overlay_root,
+			"dir2/models/testmodel/perf-pmu-test/metrics/base_metric.group",
+			"TestOverlayGroup\n") == 0);
+	TEST_ASSERT_VAL("write base_metric.aggr-mode",
+		overlay_write_file(overlay_root,
+			"dir2/models/testmodel/perf-pmu-test/metrics/base_metric.aggr-mode",
+			"PerCore\n") == 0);
+	TEST_ASSERT_VAL("write base_metric.constraint",
+		overlay_write_file(overlay_root,
+			"dir2/models/testmodel/perf-pmu-test/metrics/base_metric.constraint",
+			"NO_GROUP_EVENTS\n") == 0);
+	TEST_ASSERT_VAL("write dir2 overridden_metric",
+		overlay_write_file(overlay_root,
+			"dir2/models/testmodel/perf-pmu-test/metrics/overridden_metric",
+			"test-event + 1\n") == 0);
+
+	TEST_ASSERT_VAL("write dir2 TestOverlayGroup.desc",
+		overlay_write_file(overlay_root,
+			"dir2/models/testmodel/metricgroups/TestOverlayGroup.desc",
+			"Dir2 group description\n") == 0);
+
+	TEST_ASSERT_VAL("symlink base CPUID",
+		overlay_symlink(overlay_root,
+			"dir2/cpus/GenuineTest-6-AA",
+			"../models/testmodel") == 0);
+
+	/*
+	 * Populate dir1 (higher-priority overlay) with base and single-attribute
+	 * overrides.
+	 */
+	TEST_ASSERT_VAL("write dir1 test-event.desc override",
+		overlay_write_file(overlay_root,
+			"dir1/perf-pmu-test/events/test-event.desc",
+			"Overridden sysfs description\n") == 0);
+	TEST_ASSERT_VAL("write dir1 test-event.legacy-terms fallback",
+		overlay_write_file(overlay_root,
+			"dir1/perf-pmu-test/events/test-event.legacy-terms",
+			"krava01=9\n") == 0);
+	TEST_ASSERT_VAL("write dir1 legacy-only-event.legacy-terms",
+		overlay_write_file(overlay_root,
+			"dir1/perf-pmu-test/events/legacy-only-event.legacy-terms",
+			"krava01=7\n") == 0);
+	TEST_ASSERT_VAL("write dir1 malformed per-pkg boolean sidecar",
+		overlay_write_file(overlay_root,
+			"dir1/perf-pmu-test/events/base-cpuid-event.per-pkg",
+			"garbage\n") == 0);
+	TEST_ASSERT_VAL("write dir1 default_core bpu-refs.legacy-terms override",
+		overlay_write_file(overlay_root,
+			"dir1/default_core/events/bpu-refs.legacy-terms",
+			"legacy-cache-config=1\n") == 0);
+	TEST_ASSERT_VAL("write dir1 .hidden dotfile",
+		overlay_write_file(overlay_root,
+			"dir1/perf-pmu-test/events/.hidden",
+			"krava01=6\n") == 0);
+	TEST_ASSERT_VAL("write dir1 overridden-event over dir2",
+		overlay_write_file(overlay_root,
+			"dir1/perf-pmu-test/events/overridden-event",
+			"krava01=5\n") == 0);
+	TEST_ASSERT_VAL("write dir1 base_metric.threshold override",
+		overlay_write_file(overlay_root,
+			"dir1/perf-pmu-test/metrics/base_metric.threshold",
+			"base_metric > 10\n") == 0);
+	TEST_ASSERT_VAL("write dir1 malformed show-events boolean sidecar",
+		overlay_write_file(overlay_root,
+			"dir1/perf-pmu-test/metrics/base_metric.show-events",
+			"garbage\n") == 0);
+	TEST_ASSERT_VAL("write dir1 overridden_metric over dir2",
+		overlay_write_file(overlay_root,
+			"dir1/perf-pmu-test/metrics/overridden_metric",
+			"test-event * 4\n") == 0);
+	TEST_ASSERT_VAL("write dir1 TestOverlayGroup.desc override",
+		overlay_write_file(overlay_root,
+			"dir1/metricgroups/TestOverlayGroup.desc",
+			"Dir1 winning group description\n") == 0);
+	TEST_ASSERT_VAL("write dir1 tool TopdownL1.desc override",
+		overlay_write_file(overlay_root,
+			"dir1/tool/metricgroups/TopdownL1.desc",
+			"Overridden TopdownL1 on tool PMU\n") == 0);
+	TEST_ASSERT_VAL("write dir1 soc_v1 het_sub",
+		overlay_write_file(overlay_root,
+			"dir1/sys/soc_v1/het_pmu/metrics/het_sub",
+			"duration_time\n") == 0);
+	TEST_ASSERT_VAL("write dir1 soc_v1 het_parent",
+		overlay_write_file(overlay_root,
+			"dir1/sys/soc_v1/het_pmu/metrics/het_parent",
+			"het_sub + 1\n") == 0);
+	TEST_ASSERT_VAL("write dir1 soc_v2 het_sub",
+		overlay_write_file(overlay_root,
+			"dir1/sys/soc_v2/het_pmu/metrics/het_sub",
+			"user_time\n") == 0);
+	TEST_ASSERT_VAL("write dir1 soc_v2 het_parent",
+		overlay_write_file(overlay_root,
+			"dir1/sys/soc_v2/het_pmu/metrics/het_parent",
+			"het_sub + 1\n") == 0);
+	TEST_ASSERT_VAL("write dir1 soc_v2 het_soc2_only",
+		overlay_write_file(overlay_root,
+			"dir1/sys/soc_v2/het_pmu/metrics/het_soc2_only",
+			"user_time + 2\n") == 0);
+	TEST_ASSERT_VAL("write dir1 soc_v1 het_filt_m",
+		overlay_write_file(overlay_root,
+			"dir1/sys/soc_v1/het_pmu/metrics/het_filt_m",
+			"het_pmu@het_ev_0@ + 1\n") == 0);
+	TEST_ASSERT_VAL("write dir1 soc_v2 het_filt_m",
+		overlay_write_file(overlay_root,
+			"dir1/sys/soc_v2/het_pmu/metrics/het_filt_m",
+			"het_pmu@het_ev_1@ + 1\n") == 0);
+	TEST_ASSERT_VAL("write dir1 het_pmu_0 het_coexist_m",
+		overlay_write_file(overlay_root,
+			"dir1/het_pmu_0/metrics/het_coexist_m",
+			"duration_time + 10\n") == 0);
+	TEST_ASSERT_VAL("write dir2 het_pmu het_coexist_m",
+		overlay_write_file(overlay_root,
+			"dir2/het_pmu/metrics/het_coexist_m",
+			"duration_time + 20\n") == 0);
+	TEST_ASSERT_VAL("write dir1 het_pmu_0 het_coexist_ev",
+		overlay_write_file(overlay_root,
+			"dir1/het_pmu_0/events/het_coexist_ev",
+			"config=0x31\n") == 0);
+	TEST_ASSERT_VAL("write dir2 het_pmu het_coexist_ev",
+		overlay_write_file(overlay_root,
+			"dir2/het_pmu/events/het_coexist_ev",
+			"config=0x32\n") == 0);
+	TEST_ASSERT_VAL("write het_pmu_0 type",
+		overlay_write_file(overlay_root,
+			"het_sysfs/het_pmu_0/type", "9997\n") == 0);
+	TEST_ASSERT_VAL("write het_pmu_0 cpumask",
+		overlay_write_file(overlay_root,
+			"het_sysfs/het_pmu_0/cpumask", "0\n") == 0);
+	TEST_ASSERT_VAL("write het_pmu_0 format config",
+		overlay_write_file(overlay_root,
+			"het_sysfs/het_pmu_0/format/config", "config:0-63\n") == 0);
+	TEST_ASSERT_VAL("write het_pmu_0 het_ev_0",
+		overlay_write_file(overlay_root,
+			"het_sysfs/het_pmu_0/events/het_ev_0", "config=0x1\n") == 0);
+	TEST_ASSERT_VAL("write het_pmu_1 type",
+		overlay_write_file(overlay_root,
+			"het_sysfs/het_pmu_1/type", "9998\n") == 0);
+	TEST_ASSERT_VAL("write het_pmu_1 cpumask",
+		overlay_write_file(overlay_root,
+			"het_sysfs/het_pmu_1/cpumask", "0\n") == 0);
+	TEST_ASSERT_VAL("write het_pmu_1 format config",
+		overlay_write_file(overlay_root,
+			"het_sysfs/het_pmu_1/format/config", "config:0-63\n") == 0);
+	TEST_ASSERT_VAL("write het_pmu_1 het_ev_1",
+		overlay_write_file(overlay_root,
+			"het_sysfs/het_pmu_1/events/het_ev_1", "config=0x2\n") == 0);
+	TEST_ASSERT_VAL("write dir1 aa_het_core_0 het_coexist_m",
+		overlay_write_file(overlay_root,
+			"dir1/aa_het_core_0/metrics/het_coexist_m",
+			"duration_time + 30\n") == 0);
+	TEST_ASSERT_VAL("write dir2 default_core het_coexist_m",
+		overlay_write_file(overlay_root,
+			"dir2/default_core/metrics/het_coexist_m",
+			"duration_time + 40\n") == 0);
+	TEST_ASSERT_VAL("write aa_het_core_0 type",
+		overlay_write_file(overlay_root,
+			"het_sysfs/aa_het_core_0/type", "9994\n") == 0);
+	TEST_ASSERT_VAL("write aa_het_core_0 cpus",
+		overlay_write_file(overlay_root,
+			"het_sysfs/aa_het_core_0/cpus", "0\n") == 0);
+	TEST_ASSERT_VAL("write dir1 default_core het_core_m.desc",
+		overlay_write_file(overlay_root,
+			"dir1/default_core/metrics/het_core_m.desc",
+			"Heterogeneous core metric\n") == 0);
+	TEST_ASSERT_VAL("write dir2 het_core_0 het_core_m",
+		overlay_write_file(overlay_root,
+			"dir2/het_core_0/metrics/het_core_m",
+			"het_core_ev + 1\n") == 0);
+	TEST_ASSERT_VAL("write dir2 het_core_1 het_core_m",
+		overlay_write_file(overlay_root,
+			"dir2/het_core_1/metrics/het_core_m",
+			"het_core_ev + 2\n") == 0);
+	TEST_ASSERT_VAL("write dir1 default_core het_core0_only_m.desc",
+		overlay_write_file(overlay_root,
+			"dir1/default_core/metrics/het_core0_only_m.desc",
+			"Single core PMU metric\n") == 0);
+	TEST_ASSERT_VAL("write dir2 het_core_0 het_core0_only_m",
+		overlay_write_file(overlay_root,
+			"dir2/het_core_0/metrics/het_core0_only_m",
+			"het_core_ev + 3\n") == 0);
+	TEST_ASSERT_VAL("write het_core_0 type",
+		overlay_write_file(overlay_root,
+			"het_sysfs/het_core_0/type", "9995\n") == 0);
+	TEST_ASSERT_VAL("write het_core_0 cpus",
+		overlay_write_file(overlay_root,
+			"het_sysfs/het_core_0/cpus", "0\n") == 0);
+	TEST_ASSERT_VAL("write het_core_0 het_core_ev",
+		overlay_write_file(overlay_root,
+			"het_sysfs/het_core_0/events/het_core_ev", "config=0x11\n") == 0);
+	TEST_ASSERT_VAL("write het_core_1 type",
+		overlay_write_file(overlay_root,
+			"het_sysfs/het_core_1/type", "9996\n") == 0);
+	TEST_ASSERT_VAL("write het_core_1 cpus",
+		overlay_write_file(overlay_root,
+			"het_sysfs/het_core_1/cpus", "0\n") == 0);
+	TEST_ASSERT_VAL("write het_core_1 het_core_ev",
+		overlay_write_file(overlay_root,
+			"het_sysfs/het_core_1/events/het_core_ev", "config=0x22\n") == 0);
+
+	TEST_ASSERT_VAL("format perfconfig",
+		snprintf(config_body, sizeof(config_body),
+			 "[pmu-events]\n\tdir = %s/dir1:%s/dir2\n",
+			 overlay_root, overlay_root) < (int)sizeof(config_body));
+	TEST_ASSERT_VAL("write perfconfig",
+		overlay_write_file(overlay_root, "perfconfig", config_body) == 0);
+	TEST_ASSERT_VAL("format config_path",
+		snprintf(config_path, config_path_sz, "%s/perfconfig",
+			 overlay_root) < (int)config_path_sz);
+
+	config_exclusive_filename = config_path;
+	TEST_ASSERT_VAL("setenv PERF_CONFIG",
+		setenv("PERF_CONFIG", config_path, 1) == 0);
+	TEST_ASSERT_VAL("setenv PERF_CPUID",
+		setenv("PERF_CPUID", "GenuineTest-6-AA-1", 1) == 0);
+	perf_config__exit();
+	perf_pmus__destroy();
+
+	pmu = test_pmu_get(sysfs_dir, sysfs_dir_sz);
+	*pmu_out = pmu;
+	TEST_ASSERT_VAL("test_pmu_get", pmu != NULL);
+
+	/*
+	 * 1-3. Exercise lazy single-event lookup (before perf_pmu__for_each_event()
+	 * enumerates all events), then verify full enumeration metadata.
+	 */
+	TEST_ASSERT_VAL("reject lowercase event sidecar lookup",
+		!perf_pmu__have_event(pmu, "test-event.desc"));
+	TEST_ASSERT_VAL("reject uppercase event sidecar lookup",
+		!perf_pmu__have_event(pmu, "TEST-EVENT.DESC"));
+	TEST_ASSERT_VAL("reject dotfile event lookup",
+		!perf_pmu__have_event(pmu, ".hidden"));
+	TEST_ASSERT_VAL("have test-event lazily",
+		perf_pmu__have_event(pmu, "test-event"));
+
+	evlist = evlist__new();
+	TEST_ASSERT_VAL("evlist__new", evlist != NULL);
+	parse_events_error__init(&err);
+	parse_ret = parse_events(evlist, "perf-pmu-test/test-event/", &err);
+	parse_events_error__exit(&err);
+	parsed_config = parse_ret == 0 ? evlist__first(evlist)->core.attr.config : 0;
+	evlist__put(evlist);
+	TEST_ASSERT_EQUAL("parse test-event", parse_ret, 0);
+	TEST_ASSERT_VAL("test-event sysfs config preserved",
+		parsed_config == 0xc00000000002a823);
+
+	/* 2. Base CPUID symlink + extended sidecars + %2F decoding. */
+	evlist = evlist__new();
+	TEST_ASSERT_VAL("evlist__new base-cpuid-event", evlist != NULL);
+	parse_events_error__init(&err);
+	parse_ret = parse_events(evlist, "perf-pmu-test/base-cpuid-event/", &err);
+	parse_events_error__exit(&err);
+	if (parse_ret == 0) {
+		first_ev = evlist__first(evlist);
+		parsed_config = first_ev->core.attr.config;
+		parsed_scale = first_ev->scale;
+		snprintf(parsed_unit, sizeof(parsed_unit), "%s", first_ev->unit ?: "");
+		parsed_retire_lat = first_ev->retirement_latency.mean;
+	}
+	evlist__put(evlist);
+	TEST_ASSERT_EQUAL("parse base-cpuid-event via base CPUID symlink", parse_ret, 0);
+	TEST_ASSERT_VAL("base-cpuid-event config", parsed_config == 1);
+	TEST_ASSERT_VAL("base-cpuid-event scale", parsed_scale == 64.0);
+	TEST_ASSERT_VAL("base-cpuid-event unit", !strcmp(parsed_unit, "Bytes"));
+	TEST_ASSERT_VAL("base-cpuid-event retire_lat_mean", parsed_retire_lat == 12.5);
+
+	TEST_ASSERT_VAL("have %2F-encoded slash/event lazily",
+		perf_pmu__have_event(pmu, "slash/event"));
+
+	/* 3. Multi-directory priority overrides, legacy promotion, and full scan. */
+	evlist = evlist__new();
+	TEST_ASSERT_VAL("evlist__new overridden-event", evlist != NULL);
+	parse_events_error__init(&err);
+	parse_ret = parse_events(evlist, "perf-pmu-test/overridden-event/", &err);
+	parse_events_error__exit(&err);
+	parsed_config = parse_ret == 0 ? evlist__first(evlist)->core.attr.config : 0;
+	evlist__put(evlist);
+	TEST_ASSERT_EQUAL("parse overridden-event", parse_ret, 0);
+	TEST_ASSERT_VAL("dir1 event beats dir2 event",
+		parsed_config == ((1ULL << 62) | 1ULL));
+
+	evlist = evlist__new();
+	TEST_ASSERT_VAL("evlist__new legacy-only-event", evlist != NULL);
+	parse_events_error__init(&err);
+	parse_ret = parse_events(evlist, "perf-pmu-test/legacy-only-event/", &err);
+	parse_events_error__exit(&err);
+	parsed_config = parse_ret == 0 ? evlist__first(evlist)->core.attr.config : 0;
+	evlist__put(evlist);
+	TEST_ASSERT_EQUAL("parse legacy-only-event", parse_ret, 0);
+	TEST_ASSERT_VAL("legacy-terms promoted when no base event exists",
+		parsed_config == ((1ULL << 62) | 3ULL));
+
+	TEST_ASSERT_VAL("full event scan succeeds despite malformed boolean sidecar",
+		perf_pmu__num_events(pmu) >= 4);
+
+	TEST_ASSERT_VAL("find test-event info",
+		overlay_find_event(pmu, "test-event", &ev_snap) &&
+		!strcmp(ev_snap.desc, "Overridden sysfs description"));
+	TEST_ASSERT_VAL("find base-cpuid-event info",
+		overlay_find_event(pmu, "base-cpuid-event", &ev_snap) &&
+		!strcmp(ev_snap.str, "krava01=1") &&
+		!strcmp(ev_snap.desc, "From base CPUID model") &&
+		!strcmp(ev_snap.topic, "custom"));
+	TEST_ASSERT_VAL("find slash/event info",
+		overlay_find_event(pmu, "slash/event", &ev_snap) &&
+		!strcmp(ev_snap.str, "krava01=3") &&
+		!strcmp(ev_snap.desc, "Encoded slash event"));
+	TEST_ASSERT_VAL("find overridden-event info",
+		overlay_find_event(pmu, "overridden-event", &ev_snap) &&
+		!strcmp(ev_snap.str, "krava01=5"));
+	TEST_ASSERT_VAL("legacy-only-event str preserved after load_events",
+		overlay_find_event(pmu, "legacy-only-event", &ev_snap) &&
+		!strcmp(ev_snap.str, "krava01=7"));
+
+	if (perf_pmus__scan_core(NULL) != NULL) {
+		struct perf_pmu *core_pmu = perf_pmus__scan_core(NULL);
+		u32 bpu_type = 0;
+
+		TEST_ASSERT_VAL("have core bpu-refs lazily",
+			perf_pmu__have_event(core_pmu, "bpu-refs"));
+		(void)perf_pmu__num_events(core_pmu);
+		evlist = evlist__new();
+		TEST_ASSERT_VAL("evlist__new bpu-refs", evlist != NULL);
+		parse_events_error__init(&err);
+		parse_ret = parse_events(evlist, "bpu-refs", &err);
+		parse_events_error__exit(&err);
+		if (parse_ret == 0) {
+			first_ev = evlist__first(evlist);
+			bpu_type = first_ev->core.attr.type;
+			parsed_config = first_ev->core.attr.config & 0xffffffULL;
+		}
+		evlist__put(evlist);
+		TEST_ASSERT_EQUAL("parse overridden bpu-refs after load_events",
+				  parse_ret, 0);
+		TEST_ASSERT_VAL("user .legacy-terms beats builtin common table",
+			bpu_type == PERF_TYPE_HW_CACHE && parsed_config == 1);
+	}
+
+	/* 4. Metric merge and priority across dir1 + dir2. */
+	memset(&metric, 0, sizeof(metric));
+	TEST_ASSERT_VAL("find base_metric",
+		perf_pmu__find_metric(pmu, "base_metric", &metric));
+	TEST_ASSERT_VAL("base_metric expr",
+		metric.metric_expr && !strcmp(metric.metric_expr, "test-event * 2"));
+	TEST_ASSERT_VAL("base_metric threshold from dir1",
+		metric.metric_threshold &&
+		!strcmp(metric.metric_threshold, "base_metric > 10"));
+	TEST_ASSERT_VAL("base_metric scale-unit",
+		metric.unit && !strcmp(metric.unit, "100%"));
+	TEST_ASSERT_VAL("base_metric desc",
+		metric.desc && !strcmp(metric.desc, "Base metric desc"));
+	TEST_ASSERT_VAL("base_metric group",
+		metric.metric_group && !strcmp(metric.metric_group, "TestOverlayGroup"));
+	TEST_ASSERT_VAL("base_metric aggr_mode", metric.aggr_mode == PerCore);
+	TEST_ASSERT_VAL("base_metric constraint",
+		metric.event_grouping == MetricNoGroupEvents);
+	TEST_ASSERT_VAL("perf_pmus__find_metric base_metric",
+		perf_pmus__find_metric("base_metric", &metric));
+	TEST_ASSERT_VAL("default_core metric lookup does not match non-core PMU",
+		!perf_pmus__find_metric_pmu("default_core", "base_metric", NULL));
+	TEST_ASSERT_VAL("full metric scan succeeds despite malformed boolean sidecar",
+		perf_pmu__for_each_metric(pmu, count_metrics_cb, &metric_cnt) == 0 &&
+		metric_cnt == 2);
+	memset(&metric, 0, sizeof(metric));
+	TEST_ASSERT_VAL("dir1 metric beats dir2 metric",
+		perf_pmu__find_metric(pmu, "overridden_metric", &metric) &&
+		metric.metric_expr && !strcmp(metric.metric_expr, "test-event * 4"));
+	TEST_ASSERT_VAL("reject lowercase metric sidecar lookup",
+		!perf_pmu__find_metric(pmu, "base_metric.desc", &metric));
+	TEST_ASSERT_VAL("reject uppercase metric sidecar lookup",
+		!perf_pmu__find_metric(pmu, "base_metric.DESC", &metric));
+
+	/* 5. Metricgroup description precedence. */
+	mg_desc = perf_pmu__describe_metricgroup(pmu, "TestOverlayGroup");
+	TEST_ASSERT_VAL("TestOverlayGroup dir1 precedence",
+		mg_desc && !strcmp(mg_desc, "Dir1 winning group description"));
+	mg_desc = perf_pmus__describe_metricgroup("TestOverlayGroup");
+	TEST_ASSERT_VAL("perf_pmus__describe_metricgroup TestOverlayGroup",
+		mg_desc && !strcmp(mg_desc, "Dir1 winning group description"));
+	mg_desc = perf_pmus__describe_metricgroup("TopdownL1");
+	TEST_ASSERT_VAL("per-PMU user TopdownL1.desc beats compiled-in",
+		mg_desc && !strcmp(mg_desc, "Overridden TopdownL1 on tool PMU"));
+
+	/*
+	 * 5b. Sub-metric resolution on heterogeneous/multi-instance PMUs sharing
+	 * the same pm->pmu prefix resolves against each originating struct perf_pmu.
+	 */
+	{
+		char het_sysfs_path[PATH_MAX];
+		char export_coexist_dir[PATH_MAX];
+		const char *export_argv[5];
+		struct perf_pmu *het0 = NULL, *het1 = NULL;
+		struct perf_pmu *aa_c0 = NULL, *het_c0 = NULL, *het_c1 = NULL;
+		struct pmu_metric found_m;
+		struct evsel *pos;
+		bool saw_duration = false, saw_user = false;
+		bool filt_ev0 = false, filt_ev1 = false;
+		bool saw_core0_expr = false, saw_core1_expr = false;
+		int nr_core0 = 0, nr_core1 = 0;
+		int only_core0 = 0, only_core1 = 0;
+		int het_fd;
+
+		TEST_ASSERT_VAL("perf_pmu__is_core_at matches cpu name without dirfd",
+			perf_pmu__is_core_at(-1, "cpu") &&
+			!perf_pmu__is_core_at(-1, "het_pmu_0"));
+		TEST_ASSERT_VAL("format het_sysfs_path",
+			snprintf(het_sysfs_path, sizeof(het_sysfs_path),
+				 "%s/het_sysfs", overlay_root) < (int)sizeof(het_sysfs_path));
+		het_fd = open(het_sysfs_path, O_RDONLY | O_DIRECTORY);
+		TEST_ASSERT_VAL("open het_sysfs", het_fd >= 0);
+		het0 = perf_pmus__add_test_pmu(het_fd, "het_pmu_0");
+		het1 = perf_pmus__add_test_pmu(het_fd, "het_pmu_1");
+		aa_c0 = perf_pmus__add_test_pmu(het_fd, "aa_het_core_0");
+		het_c0 = perf_pmus__add_test_pmu(het_fd, "het_core_0");
+		het_c1 = perf_pmus__add_test_pmu(het_fd, "het_core_1");
+		close(het_fd);
+		TEST_ASSERT_VAL("add het_pmu_0 and het_pmu_1", het0 && het1);
+		TEST_ASSERT_VAL("add aa_het_core_0, het_core_0 and het_core_1",
+				aa_c0 && het_c0 && het_c1 &&
+				aa_c0->is_core && het_c0->is_core && het_c1->is_core);
+		het0->is_uncore = true;
+		free((char *)het0->id);
+		het0->id = strdup("soc_v1");
+		het1->is_uncore = true;
+		free((char *)het1->id);
+		het1->id = strdup("soc_v2");
+		TEST_ASSERT_VAL("set het_pmu ids", het0->id && het1->id);
+
+		evlist = evlist__new();
+		TEST_ASSERT_VAL("evlist__new het_parent", evlist != NULL);
+		parse_ret = metricgroup__parse_groups(evlist, "all",
+						      /*cputype_filter=*/false,
+						      "het_parent",
+						      /*metric_no_group=*/true,
+						      /*metric_no_merge=*/false,
+						      /*metric_no_threshold=*/false,
+						      /*user_requested_cpu_list=*/NULL,
+						      /*system_wide=*/false,
+						      /*hardware_aware_grouping=*/false);
+		evlist__for_each_entry(evlist, pos) {
+			const char *ev_name = evsel__name(pos);
+
+			if (ev_name && strstr(ev_name, "duration_time"))
+				saw_duration = true;
+			if (ev_name && strstr(ev_name, "user_time"))
+				saw_user = true;
+		}
+		evlist__put(evlist);
+		TEST_ASSERT_EQUAL("parse het_parent across het_pmu_0 and het_pmu_1",
+				  parse_ret, 0);
+		TEST_ASSERT_VAL("het_parent resolved sub-metrics per originating PMU",
+				saw_duration && saw_user);
+
+		TEST_ASSERT_VAL("uncore has_metric_or_groups filters by originating PMU",
+			metricgroup__has_metric_or_groups("het_pmu_1",
+							  "het_soc2_only") &&
+			!metricgroup__has_metric_or_groups("het_pmu_0",
+							   "het_soc2_only") &&
+			!metricgroup__has_metric_or_groups("het_core_0",
+							   "het_soc2_only"));
+		evlist = evlist__new();
+		TEST_ASSERT_VAL("evlist__new filtered het_filt_m", evlist != NULL);
+		parse_ret = metricgroup__parse_groups(evlist, "het_pmu_0",
+						      /*cputype_filter=*/false,
+						      "het_filt_m",
+						      /*metric_no_group=*/true,
+						      /*metric_no_merge=*/false,
+						      /*metric_no_threshold=*/false,
+						      /*user_requested_cpu_list=*/NULL,
+						      /*system_wide=*/false,
+						      /*hardware_aware_grouping=*/false);
+		evlist__for_each_entry(evlist, pos) {
+			if (!pos->pmu)
+				continue;
+			if (!strcmp(pos->pmu->name, "het_pmu_0"))
+				filt_ev0 = true;
+			if (!strcmp(pos->pmu->name, "het_pmu_1"))
+				filt_ev1 = true;
+		}
+		evlist__put(evlist);
+		TEST_ASSERT_EQUAL("parse het_filt_m filtered to het_pmu_0",
+				  parse_ret, 0);
+		TEST_ASSERT_VAL("het_filt_m filter excludes het_pmu_1 metric",
+				filt_ev0 && !filt_ev1);
+
+		evlist = evlist__new();
+		TEST_ASSERT_VAL("evlist__new het_core_m", evlist != NULL);
+		parse_ret = metricgroup__parse_groups(evlist, "all",
+						      /*cputype_filter=*/false,
+						      "het_core_m",
+						      /*metric_no_group=*/true,
+						      /*metric_no_merge=*/false,
+						      /*metric_no_threshold=*/false,
+						      /*user_requested_cpu_list=*/NULL,
+						      /*system_wide=*/false,
+						      /*hardware_aware_grouping=*/false);
+		evlist__for_each_entry(evlist, pos) {
+			struct metric_event *me;
+			struct metric_expr *mexp;
+
+			if (!pos->pmu)
+				continue;
+			if (!strcmp(pos->pmu->name, "het_core_0"))
+				nr_core0++;
+			if (!strcmp(pos->pmu->name, "het_core_1"))
+				nr_core1++;
+			me = metricgroup__lookup(evlist__metric_events(evlist),
+						 pos, /*create=*/false);
+			if (!me)
+				continue;
+			list_for_each_entry(mexp, &me->head, nd) {
+				if (!strcmp(pos->pmu->name, "het_core_0") &&
+				    mexp->metric_expr &&
+				    !strcmp(mexp->metric_expr, "het_core_ev + 1") &&
+				    mexp->metric_events[0] == pos)
+					saw_core0_expr = true;
+				if (!strcmp(pos->pmu->name, "het_core_1") &&
+				    mexp->metric_expr &&
+				    !strcmp(mexp->metric_expr, "het_core_ev + 2") &&
+				    mexp->metric_events[0] == pos)
+					saw_core1_expr = true;
+			}
+		}
+		evlist__put(evlist);
+		TEST_ASSERT_EQUAL("parse het_core_m across het_core_0 and het_core_1",
+				  parse_ret, 0);
+		TEST_ASSERT_VAL("het_core_m bound default_core metrics per core PMU",
+				saw_core0_expr && saw_core1_expr &&
+				nr_core0 == 1 && nr_core1 == 1);
+
+		TEST_ASSERT_VAL("has_metric_or_groups matches het_core_0 only",
+			metricgroup__has_metric_or_groups("het_core_0",
+							  "het_core0_only_m") &&
+			!metricgroup__has_metric_or_groups("het_core_1",
+							   "het_core0_only_m"));
+		evlist = evlist__new();
+		TEST_ASSERT_VAL("evlist__new het_core0_only_m", evlist != NULL);
+		parse_ret = metricgroup__parse_groups(evlist, "all",
+						      /*cputype_filter=*/false,
+						      "het_core0_only_m",
+						      /*metric_no_group=*/true,
+						      /*metric_no_merge=*/false,
+						      /*metric_no_threshold=*/false,
+						      /*user_requested_cpu_list=*/NULL,
+						      /*system_wide=*/false,
+						      /*hardware_aware_grouping=*/false);
+		evlist__for_each_entry(evlist, pos) {
+			if (!pos->pmu)
+				continue;
+			if (!strcmp(pos->pmu->name, "het_core_0"))
+				only_core0++;
+			if (!strcmp(pos->pmu->name, "het_core_1"))
+				only_core1++;
+		}
+		evlist__put(evlist);
+		TEST_ASSERT_EQUAL("parse het_core0_only_m", parse_ret, 0);
+		TEST_ASSERT_VAL("het_core0_only_m does not expand onto het_core_1",
+				only_core0 == 1 && only_core1 == 0);
+
+		TEST_ASSERT_VAL("find_metric_pmu default_core skips per-PMU override",
+			perf_pmus__find_metric_pmu("default_core", "het_coexist_m", &found_m) &&
+			found_m.metric_expr &&
+			!strcmp(found_m.metric_expr, "duration_time + 40"));
+		TEST_ASSERT_VAL("find_metric_pmu wildcard skips per-instance override",
+			perf_pmus__find_metric_pmu("het_pmu", "het_coexist_m", &found_m) &&
+			found_m.metric_expr &&
+			!strcmp(found_m.metric_expr, "duration_time + 20"));
+
+		TEST_ASSERT_VAL("het0 override event preserves pmu_name across layers",
+			overlay_find_event(het0, "het_coexist_ev", &ev_snap) &&
+			!strcmp(ev_snap.str, "config=0x31") &&
+			!strcmp(ev_snap.pmu_name, "het_pmu_0"));
+		TEST_ASSERT_VAL("het1 wildcard event keeps shared pmu_name",
+			overlay_find_event(het1, "het_coexist_ev", &ev_snap) &&
+			!strcmp(ev_snap.str, "config=0x32") &&
+			!strcmp(ev_snap.pmu_name, "het_pmu"));
+
+		TEST_ASSERT_VAL("format export_coexist_dir",
+			snprintf(export_coexist_dir, sizeof(export_coexist_dir),
+				 "%s/export_coexist", overlay_root) <
+			(int)sizeof(export_coexist_dir));
+		export_argv[0] = "list";
+		export_argv[1] = "--export-dir";
+		export_argv[2] = export_coexist_dir;
+		export_argv[3] = "metric";
+		export_argv[4] = NULL;
+		TEST_ASSERT_EQUAL("cmd_list --export-dir metric",
+				  cmd_list(4, export_argv), 0);
+		TEST_ASSERT_VAL("exported aa_het_core_0 override metric",
+			overlay_expect_file(overlay_root,
+				"export_coexist/aa_het_core_0/metrics/het_coexist_m",
+				"duration_time + 30\n"));
+		TEST_ASSERT_VAL("exported shared default_core metric",
+			overlay_expect_file(overlay_root,
+				"export_coexist/default_core/metrics/het_coexist_m",
+				"duration_time + 40\n"));
+		TEST_ASSERT_VAL("exported het_pmu_0 override metric",
+			overlay_expect_file(overlay_root,
+				"export_coexist/het_pmu_0/metrics/het_coexist_m",
+				"duration_time + 10\n"));
+		TEST_ASSERT_VAL("exported shared het_pmu wildcard metric",
+			overlay_expect_file(overlay_root,
+				"export_coexist/het_pmu/metrics/het_coexist_m",
+				"duration_time + 20\n"));
+	}
+
+	test_pmu_put(sysfs_dir, pmu);
+	*pmu_out = NULL;
+	sysfs_dir[0] = '\0';
+
+	/*
+	 * 6. Stepping-specific full CPUID symlink takes precedence over base
+	 * CPUID in the same layer without merging the coarser model tree.
+	 */
+	TEST_ASSERT_VAL("write stepping-event",
+		overlay_write_file(overlay_root,
+			"dir2/models/stepping1/perf-pmu-test/events/stepping-event",
+			"krava01=2\n") == 0);
+	TEST_ASSERT_VAL("symlink exact stepping CPUID",
+		overlay_symlink(overlay_root,
+			"dir2/cpus/GenuineTest-6-AA-1",
+			"../models/stepping1") == 0);
+
+	perf_config__exit();
+	perf_pmus__destroy();
+
+	pmu = test_pmu_get(sysfs_dir, sysfs_dir_sz);
+	*pmu_out = pmu;
+	TEST_ASSERT_VAL("test_pmu_get stepping", pmu != NULL);
+	TEST_ASSERT_VAL("stepping-event present",
+		perf_pmu__have_event(pmu, "stepping-event"));
+	TEST_ASSERT_VAL("base-cpuid-event not merged when exact stepping matched",
+		!perf_pmu__have_event(pmu, "base-cpuid-event"));
+
+	return TEST_OK;
+}
+
+static int test__pmu_layer_overlay(struct test_suite *test __maybe_unused,
+				   int subtest __maybe_unused)
+{
+	char overlay_root[PATH_MAX] = "/tmp/perf-pmu-layer-XXXXXX";
+	char config_path[PATH_MAX] = "";
+	char sysfs_dir[PATH_MAX] = "";
+	char *orig_config = NULL, *orig_cpuid = NULL;
+	const char *orig_exclusive = config_exclusive_filename;
+	const char *env_val;
+	struct perf_pmu *pmu = NULL;
+	int ret = TEST_FAIL;
+
+	env_val = getenv("PERF_CONFIG");
+	if (env_val) {
+		orig_config = strdup(env_val);
+		if (!orig_config)
+			return TEST_FAIL;
+	}
+	env_val = getenv("PERF_CPUID");
+	if (env_val) {
+		orig_cpuid = strdup(env_val);
+		if (!orig_cpuid) {
+			free(orig_config);
+			return TEST_FAIL;
+		}
+	}
+
+	if (mkdtemp(overlay_root)) {
+		ret = run_pmu_layer_overlay_checks(overlay_root,
+						   config_path, sizeof(config_path),
+						   sysfs_dir, sizeof(sysfs_dir),
+						   &pmu);
+	} else {
+		overlay_root[0] = '\0';
+	}
+
+	if (pmu) {
+		test_pmu_put(sysfs_dir, pmu);
+		pmu = NULL;
+	}
+	config_exclusive_filename = orig_exclusive;
+	if (orig_config)
+		setenv("PERF_CONFIG", orig_config, 1);
+	else
+		unsetenv("PERF_CONFIG");
+	if (orig_cpuid)
+		setenv("PERF_CPUID", orig_cpuid, 1);
+	else
+		unsetenv("PERF_CPUID");
+	free(orig_config);
+	free(orig_cpuid);
+	perf_config__exit();
+	perf_pmus__destroy();
+	if (overlay_root[0])
+		overlay_rm_rf_at(AT_FDCWD, overlay_root);
+	return ret;
+}
+
 static struct test_case tests__pmu[] = {
 	TEST_CASE("Parsing with PMU format directory", pmu_format),
 	TEST_CASE("Parsing with PMU event", pmu_events),
@@ -636,6 +1594,7 @@ static struct test_case tests__pmu[] = {
 	TEST_CASE("PMU name comparison", name_cmp),
 	TEST_CASE("PMU cmdline match", pmu_match),
 	TEST_CASE("PMU config helpers", pmu_config_helpers),
+	TEST_CASE("Layered PMU directory overlays", pmu_layer_overlay),
 	{	.name = NULL, }
 };
 
diff --git a/tools/perf/tests/shell/pmu_events_dir.sh b/tools/perf/tests/shell/pmu_events_dir.sh
new file mode 100755
index 000000000000..ffca18e674fb
--- /dev/null
+++ b/tools/perf/tests/shell/pmu_events_dir.sh
@@ -0,0 +1,236 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# pmu-events.dir overlay and export tests (no_mlock)
+
+set -e
+
+shelldir=$(dirname "$0")
+tmpdir=$(mktemp -d /tmp/__perf_test.pmu_events_dir.XXXXX)
+
+cleanup() {
+  rm -rf "${tmpdir}"
+  trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+  cleanup
+  exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
+test_export_roundtrip() {
+  echo "perf list --export-dir round-trip test"
+  perf list -j -o "${tmpdir}/baseline.json" sw metric metricgroup
+  perf list --export-dir "${tmpdir}/export" sw metric metricgroup
+  [ -d "${tmpdir}/export" ]
+
+  cat > "${tmpdir}/export_config" <<EOF
+[pmu-events]
+	dir = ${tmpdir}/export
+EOF
+
+  PERF_CONFIG="${tmpdir}/export_config" \
+    perf list -j -o "${tmpdir}/roundtrip.json" sw metric metricgroup
+  diff -u "${tmpdir}/baseline.json" "${tmpdir}/roundtrip.json"
+
+  perf list --export-dir "${tmpdir}/tp_export" tracepoint
+  [ -d "${tmpdir}/tp_export" ]
+  [ -z "$(ls -A "${tmpdir}/tp_export")" ]
+  echo "perf list --export-dir round-trip test [Success]"
+}
+
+test_user_overlay() {
+  echo "pmu-events.dir user overlay test"
+  ov_ev="${tmpdir}/overlay/tool/events"
+  ov_met="${tmpdir}/overlay/default_core/metrics"
+  ov_mg="${tmpdir}/overlay/metricgroups"
+  mkdir -p "${ov_ev}" "${ov_met}" "${ov_mg}"
+
+  printf 'config=0x1\n' > "${ov_ev}/overlay_duration"
+  printf 'Overlay custom duration event\n' > "${ov_ev}/overlay_duration.desc"
+  printf 'Overridden duration_time description\n' > "${ov_ev}/duration_time.desc"
+
+  printf 'duration_time * 2\n' > "${ov_met}/overlay_double_duration"
+  printf '1ns\n' > "${ov_met}/overlay_double_duration.scale-unit"
+  printf 'Custom doubled duration metric\n' > "${ov_met}/overlay_double_duration.desc"
+  printf 'OverlayTestGroup\n' > "${ov_met}/overlay_double_duration.group"
+
+  printf 'Custom overlay metric group\n' > "${ov_mg}/OverlayTestGroup.desc"
+
+  cat > "${tmpdir}/overlay_config" <<EOF
+[pmu-events]
+	dir = ${tmpdir}/overlay
+EOF
+
+  PERF_CONFIG="${tmpdir}/overlay_config" perf list > "${tmpdir}/list_all.txt"
+  grep -q "overlay_duration" "${tmpdir}/list_all.txt"
+  grep -q "Overlay custom duration event" "${tmpdir}/list_all.txt"
+  grep -q "Overridden duration_time description" "${tmpdir}/list_all.txt"
+
+  PERF_CONFIG="${tmpdir}/overlay_config" perf list metric > "${tmpdir}/list_metric.txt"
+  grep -q "overlay_double_duration" "${tmpdir}/list_metric.txt"
+  grep -q "Custom doubled duration metric" "${tmpdir}/list_metric.txt"
+
+  PERF_CONFIG="${tmpdir}/overlay_config" perf list metricgroup > "${tmpdir}/list_mg.txt"
+  grep -q "OverlayTestGroup" "${tmpdir}/list_mg.txt"
+  grep -q "Custom overlay metric group" "${tmpdir}/list_mg.txt"
+
+  PERF_CONFIG="${tmpdir}/overlay_config" perf stat -e overlay_duration true >/dev/null 2>&1
+  PERF_CONFIG="${tmpdir}/overlay_config" perf stat -M overlay_double_duration true >/dev/null 2>&1
+
+  rm -f "${ov_ev}/duration_time.desc" \
+        "${ov_ev}/overlay_duration" "${ov_ev}/overlay_duration.desc" \
+        "${ov_met}/overlay_double_duration" "${ov_met}/overlay_double_duration.scale-unit" \
+        "${ov_met}/overlay_double_duration.desc" "${ov_met}/overlay_double_duration.group" \
+        "${ov_mg}/OverlayTestGroup.desc"
+
+  PERF_CONFIG="${tmpdir}/overlay_config" perf list > "${tmpdir}/list_after_rm.txt"
+  if grep -q "overlay_duration" "${tmpdir}/list_after_rm.txt"; then
+    echo "Deleting overlay_duration failed to remove custom event"
+    exit 1
+  fi
+  if grep -q "Overridden duration_time description" "${tmpdir}/list_after_rm.txt"; then
+    echo "Deleting duration_time.desc failed to restore default description"
+    exit 1
+  fi
+  grep -q "duration_time" "${tmpdir}/list_after_rm.txt"
+  echo "pmu-events.dir user overlay test [Success]"
+}
+
+test_jevents_output_dir() {
+  jevents="${shelldir}/../../pmu-events/jevents.py"
+  archdir="${shelldir}/../../pmu-events/arch"
+  if [ ! -f "${jevents}" ] || [ ! -d "${archdir}" ]; then
+    echo "jevents.py --output-dir test [Skipped: source tree not present]"
+    return 0
+  fi
+
+  py="${PYTHON:-}"
+  if [ -z "${py}" ]; then
+    python3 --version >/dev/null 2>&1 && py=python3
+  fi
+  if [ -z "${py}" ]; then
+    python --version >/dev/null 2>&1 && py=python
+  fi
+  if [ -z "${py}" ]; then
+    echo "jevents.py --output-dir test [Skipped: python not found]"
+    return 0
+  fi
+
+  echo "jevents.py --output-dir CPUID symlink test"
+  "${py}" "${jevents}" --output-dir "${tmpdir}/jevents-test" test all "${archdir}"
+  [ -L "${tmpdir}/jevents-test/cpus/testcpu" ]
+  [ -L "${tmpdir}/jevents-test/sys/v8" ]
+  [ -z "$(find "${tmpdir}/jevents-test" -name 'mapfile.csv')" ]
+
+  cat > "${tmpdir}/jevents_config" <<EOF
+[pmu-events]
+	dir = ${tmpdir}/jevents-test
+EOF
+
+  PERF_CPUID=testcpu PERF_CONFIG="${tmpdir}/jevents_config" \
+    perf list > "${tmpdir}/jevents_list.txt" 2>/dev/null
+  grep -q "bp_l1_btb_correct" "${tmpdir}/jevents_list.txt"
+  grep -q "dcache_miss_cpi" "${tmpdir}/jevents_list.txt"
+
+  "${py}" "${jevents}" --output-dir "${tmpdir}/jevents-common" common all "${archdir}"
+  [ -f "${tmpdir}/jevents-common/default_core/events/cycles.legacy-terms" ]
+  [ ! -e "${tmpdir}/jevents-common/default_core/events/cycles" ]
+
+  synth_soc="${tmpdir}/synth_arch/arm64/vendor/soc"
+  mkdir -p "${synth_soc}/sys"
+  cat > "${tmpdir}/synth_arch/arm64/mapfile.csv" <<'EOF'
+Family-model,Version,Filename,EventType
+0x00000000480fd010,v1,vendor/soc,core
+EOF
+  cat > "${synth_soc}/branch.json" <<'EOF'
+[
+  {
+    "EventName": "before_sys_ev",
+    "EventCode": "0x11",
+    "BriefDescription": "Event sorting before sys/"
+  }
+]
+EOF
+  cat > "${synth_soc}/sys/uncore.json" <<'EOF'
+[
+  {
+    "Unit": "hisi_sccl,ddrc",
+    "EventName": "sys_uncore_ev",
+    "EventCode": "0x22",
+    "Compat": "0x00000030",
+    "BriefDescription": "System PMU event inside sys/"
+  }
+]
+EOF
+  cat > "${synth_soc}/virtual-memory.json" <<'EOF'
+[
+  {
+    "EventName": "after_sys_ev",
+    "EventCode": "0x33",
+    "BriefDescription": "Event sorting after sys/"
+  }
+]
+EOF
+
+  "${py}" "${jevents}" --output-dir "${tmpdir}/jevents-synth" arm64 all "${tmpdir}/synth_arch"
+  [ -f "${tmpdir}/jevents-synth/models/arm64/vendor/soc/default_core/events/before_sys_ev" ]
+  [ -f "${tmpdir}/jevents-synth/models/arm64/vendor/soc/default_core/events/after_sys_ev" ]
+  [ ! -e "${tmpdir}/jevents-synth/models/arm64/vendor/soc/sys/default_core/events/after_sys_ev" ]
+  [ -f "${tmpdir}/jevents-synth/models/arm64/vendor/soc/sys/hisi_sccl,ddrc/events/sys_uncore_ev" ]
+  [ -L "${tmpdir}/jevents-synth/cpus/0x00000000480fd010" ]
+  [ -L "${tmpdir}/jevents-synth/sys/0x00000030" ]
+  echo "jevents.py --output-dir CPUID symlink test [Success]"
+}
+
+test_export_cpuid() {
+  echo "perf list --export-cpuid test"
+  if perf list --export-cpuid testcpu >/dev/null 2>&1; then
+    echo "--export-cpuid without --export-dir unexpectedly succeeded"
+    exit 1
+  fi
+  if perf list --export-dir "${tmpdir}/bad_cpuid" \
+       --export-cpuid no_such_cpuid_xyz >/dev/null 2>&1; then
+    echo "--export-cpuid with unknown CPUID unexpectedly succeeded"
+    exit 1
+  fi
+
+  perf list --export-dir "${tmpdir}/cpuid_test" --export-cpuid testarch
+  [ -L "${tmpdir}/cpuid_test/cpus/testcpu" ]
+  [ -L "${tmpdir}/cpuid_test/sys/v8" ]
+  [ -f "${tmpdir}/cpuid_test/models/testarch/test_soc/cpu/default_core/events/bp_l1_btb_correct" ]
+  [ -f "${tmpdir}/cpuid_test/models/testarch/test_soc/cpu/default_core/metrics/dcache_miss_cpi" ]
+
+  printf 'Migrated testcpu metric description\n' \
+    > "${tmpdir}/cpuid_test/models/testarch/test_soc/cpu/default_core/metrics/dcache_miss_cpi.desc"
+  cat > "${tmpdir}/cpuid_test_config" <<EOF
+[pmu-events]
+	dir = ${tmpdir}/cpuid_test
+EOF
+  PERF_CPUID=testcpu PERF_CONFIG="${tmpdir}/cpuid_test_config" \
+    perf list metric > "${tmpdir}/cpuid_test_metric.txt" 2>/dev/null
+  grep -q "Migrated testcpu metric description" "${tmpdir}/cpuid_test_metric.txt"
+
+  perf list --export-dir "${tmpdir}/cpuid_common" --export-cpuid common
+  [ -f "${tmpdir}/cpuid_common/default_core/events/cycles.legacy-terms" ]
+
+  if perf list --export-dir "${tmpdir}/cpuid_n2" \
+       --export-cpuid 0x00000000411fd493 metric metricgroup >/dev/null 2>&1; then
+    [ -L "${tmpdir}/cpuid_n2/cpus/0x00000000410fd490" ]
+    [ -d "${tmpdir}/cpuid_n2/models/arm64/arm/neoverse-n2-v2/default_core/metrics" ]
+    [ ! -d "${tmpdir}/cpuid_n2/models/arm64/arm/neoverse-n2-v2/default_core/events" ]
+  fi
+  if perf list --export-dir "${tmpdir}/cpuid_skl" \
+       --export-cpuid x86/skylake metric >/dev/null 2>&1; then
+    [ -L "${tmpdir}/cpuid_skl/cpus/GenuineIntel-6-4E" ]
+    [ -L "${tmpdir}/cpuid_skl/cpus/GenuineIntel-6-5E" ]
+  fi
+  echo "perf list --export-cpuid test [Success]"
+}
+
+test_export_roundtrip
+test_user_overlay
+test_jevents_output_dir
+test_export_cpuid
+cleanup
+exit 0
-- 
2.56.1.703.gf848ed807c-goog

