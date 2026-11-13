Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604285;
	b=w0WLjw/y9R2Tz3+kbMl48jV7KxffYUoRyK6MRVjAJsm+LyJApfxg14SKf7hcbz+c8CFZ
	 JZW4ccwiYanK0w5XKvLWqPBa8tmtQeLfiEVQ85Bl7uW1sOqIiW9u60eYDQQQxcbH0C+cd
	 E9w0BlBRzDVutSH+qtQWYMx0e1DolSvmYGG0f1HRppB2IGDFpgfESq+TlVHeHvQeZDu71
	 gtqj0Bd1qZsYTfnvYpUueqFrPb0oG8j3eFspWZ8frVy/icm5unvx0AiFH+szHmMOVWNRx
	 +rZf6kHNYqynRZ2rweMSSi6VhXb4r2iHVwYxjeNFQFEteb1T9yDuQZwoan677dL5Y7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604285;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=0AI1lauf47iRLgk+FoHY45N08pvtrJHzT3/fgRj/61A=;
	b=WRXYP+xKcP1U9t0rQ2Cv5w3B9i3BaJGjCCQY9R5aT24INc6/tAEN3N08WGvbhuEU+Xp9
	 0lJvlCXR50b5bKSzLj5o9RIDYGqrOWBBwHRiNJppiHoLhWQuiUq1faguYmk/+1H+pqD7J
	 EUv4AllbC+pgfDVwIrj8pE+SwrPP6KzNUWdiHhgF0SbyNcff1X8QqHc45E/NCdIwcnJW/
	 0K8S+YctwOCaoorIJdslmvrDNCBy0K1Zc3VURykvmdUk2el5AHZgtJytuHn+vDgyHutXQ
	 xMyQAPfVn/qXWEBnvYKk483TO/dgKD+JLKYgiZmyY5cyBcwq4HfYJyVa+Z6vzY9Xp8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Xtchxyvb;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D305606A8B8
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D305606A8B8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Xtchxyvb
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso2080450eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 13:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794604283; x=1795209083; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0AI1lauf47iRLgk+FoHY45N08pvtrJHzT3/fgRj/61A=;
        b=XtchxyvbE4TPNZhy8aR4khnsEkWWQzWUkMe57d0xFZNqcau8aX+xoK3zTo/UhuRS5w
         VsqlAajdkSz07vG9SBkiTp6as6lRDxwAOykDQNOYsKmC9OI2Tit2f82i1jVZ5lkOQh0d
         0TM6yrAjUHPvdaYSWt3t4oXg+EZfw53PrH2cc8+qSrz2E7nMSjf2QuvjhtWBpxSXiGCo
         69Lqn2ep9B8a1twyBhgMIFqApQoUOzfSsgLuTNDbnQkSTJC334vjcKBhS3bjTuMom6up
         j+lfpHWSduINDl30e87l5VBO8FIzs3jeW7dgU4F8SN3Eyx+ct1lsiUOX/Cg/DwuW6sZV
         8tEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794604283; x=1795209083;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0AI1lauf47iRLgk+FoHY45N08pvtrJHzT3/fgRj/61A=;
        b=hZvR3JERRlEpY37oHDHMsH3h3I+byW0Li1D5mHXH9pwYmLRBnR6fJlOVOqVpD0FTSP
         KNZht434U3VFp5upawsqJNikEIAmWaTzrho2c5fq5sLrmG423sP0bEE9nv9zVhVao7fi
         970Hl0MbG3Gkudjk7+RuuOCMsAdQ4L81hSpGP5+yU75EWTPggIaCbJyDbAO+Dx3w6OuE
         dtBeiWmqxL3isuZixET8Hpbltrh6UbpDnIu8Xk0qoyEjWNuLzEHU/xa9y2wI9af8dks0
         UmDeqSPSKJWsN3CuJOJAXr0OdJOKclO/8fObDFQpfACfA0wryj/xBg7wiKxVmhWlBZfi
         KtLQ==
X-Forwarded-Encrypted: i=1; AL+hErE40wZVr4mfB76766pvM38r07ORjVGPZmEkA+J1zmB78+NKX09GTR4FpRINNmuFOiGajWFrtIg3v9MOivch3ap2@vger.kernel.org
X-Gm-Message-State: APuU4Z86vkuMjdlRGcQpv+o+gCM6T59kdB67un0VA9QnqoC/8o47YAER
	JJQMXqbDI++qFAmla287fnCrazutIKfxOh1Sv+M+Ubx80PLkvvFXK3wFgWBzSFadDOZC3fsAwNx
	6RCbClzhUAg==
X-Received: from dyah18-n1.prod.google.com ([2002:a05:693c:83d2:10b0:37a:8a0f:3aba])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:7108:b0:376:b957:bfb
 with SMTP id 5a478bee46e88-3796628d619mr2976359eec.17.1794604282777; Fri, 13
 Nov 2026 13:11:22 -0800 (PST)
Date: Fri, 13 Nov 2026 13:10:56 -0800
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
Message-ID: <20261113211105.3118281-6-irogers@google.com>
Subject: [PATCH 05/11] perf config: Add pmu-events.dir configuration option
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Add [pmu-events] dir to perf_config() (~/.perfconfig,
$(sysconfdir)/perfconfig, or PERF_CONFIG) to configure one or more
colon-separated user or system PMU overlay directories (ordered from
highest to lowest priority) with leading ~/ home expansion.

For example, configuring:

  [pmu-events]
      dir = ~/.perf-events/local:/opt/pmu-events

allows a developer or fleet administrator to layer host-local or
stepping-specific patches in ~/.perf-events/local ahead of a shared
multi-CPU directory tree in /opt/pmu-events:

  ~/.perf-events/local/
  |-- cpus/GenuineIntel-6-8F-8/cpu/events/
  |   `-- inst_retired.any.desc         # stepping-specific fixup
  `-- default_core/metrics/
      |-- my_ipc                        # host-local custom metric
      `-- my_ipc.desc

  /opt/pmu-events/
  |-- cpus/
  |   |-- GenuineIntel-6-8F -> ../models/x86/sapphirerapids
  |   `-- 0x00000000410fd490 -> ../models/arm64/arm/neoverse-n2
  `-- models/...

On a Sapphire Rapids stepping 8 host (GenuineIntel-6-8F-8), perf first
matches ~/.perf-events/local/cpus/GenuineIntel-6-8F-8/ (overriding only
inst_retired.any.desc while inheriting event encoding terms from lower
layers) and ~/.perf-events/local/default_core/, then falls back to
/opt/pmu-events/cpus/GenuineIntel-6-8F -> ../models/x86/sapphirerapids,
and finally to compiled-in tables and kernel sysfs.

When pmu-events.dir is unset, PMU_LAYER_USER_DIR is omitted from the
layer stack so runtime overhead is zero extra syscalls. Reset the layer
stack in perf_config__exit() and perf_pmus__destroy() so process
teardown and perf test config isolation reload cleanly, and document
pmu-events.dir in Documentation/perf-config.txt.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-config.txt | 42 ++++++++++++++++++
 tools/perf/util/config.c                 | 15 +++++++
 tools/perf/util/pmu-layer.c              | 55 +++++++++++++++++++++++-
 tools/perf/util/pmus.c                   |  2 +
 4 files changed, 113 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 6cff6f26af8d..e81c33717688 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -94,6 +94,10 @@ Given a $HOME/.perfconfig like this:
 		# Default, disable using /dev/null
 		dir = ~/.debug
 
+	[pmu-events]
+		# Colon-separated sysfs-style PMU event/metric overlay directories
+		dir = ~/.perf-events
+
 	[annotate]
 		# Defaults
 		hide_src_code = false
@@ -259,6 +263,44 @@ buildid-cache.*::
 
 		  buildid-cache.debuginfod=http://192.168.122.174:8002
 
+pmu-events.*::
+	pmu-events.dir::
+		Specify a directory, or a colon-separated list of directories
+		(ordered from highest to lowest priority), containing sysfs-style
+		PMU event, metric, and metricgroup definitions. Leading '~/' is
+		expanded to '$HOME/'.
++
+Overlay directories have higher priority than inbuilt JSON tables and kernel
+sysfs ('pmu-events.dir > inbuilt CPU/SoC > sysfs > inbuilt common'). Attributes
+merge top-down per event or metric so individual sidecar files (such as
+'<pmu>/events/<event>.desc' or '<pmu>/metrics/<metric>.threshold') can override
+single fields while preserving lower-layer definitions.
++
+Within each '<dir>', perf probes three scopes in order:
+'<dir>/cpus/<cpuid>/<pmu>/', '<dir>/sys/<id>/<pmu>/', and host-direct
+'<dir>/<pmu>/' (matching exact PMU names, 'default_core' for core PMUs, and
+suffix-stripped uncore prefixes, plus '<dir>/metricgroups/<group>.desc'). Under
+'<dir>/cpus/', perf tries the exact CPUID first and then deterministic base
+CPUIDs stripped of stepping or revision fields (for example
+'GenuineIntel-6-8F-8' then 'GenuineIntel-6-8F' on x86, '0x00000000411fd493'
+then '0x00000000410fd490' on ARM64, '0x00800200' then '0x00800000' on PowerPC,
+'IBM,8561,703' then 'IBM,8561' on s390, and '0x489-0x8000000000000007-0x1' then
+'0x489-0x8000000000000007' on RISC-V), stopping at the first matching
+'cpus/<candidate>' in that '<dir>' and following POSIX symlinks (such as
+'cpus/GenuineIntel-6-4E -> ../models/x86/skylake') without requiring a
+'mapfile.csv'.
++
+For example, to layer local overrides ahead of a shared directory in
+'$HOME/.perfconfig' and define a custom metric:
+
+		[pmu-events]
+			dir = ~/.perf-events/local:/opt/pmu-events
+
+		$ mkdir -p ~/.perf-events/local/default_core/metrics
+		$ printf 'instructions / cpu-cycles\n' > ~/.perf-events/local/default_core/metrics/my_ipc
+		$ printf 'Custom instructions per cycle\n' > ~/.perf-events/local/default_core/metrics/my_ipc.desc
+		$ perf stat -M my_ipc true
+
 annotate.*::
 	These are in control of addresses, jump function, source code
 	in lines of assembly code from a specific program.
diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 287401f159e6..c9e68f0c6163 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -33,6 +33,7 @@
 #include "header.h"
 #include "mutex.h"
 #include "path.h"
+#include "pmu-layer.h"
 #include "srcline.h"
 #include "unwind.h"
 #include "util/event.h" /* proc_map_timeout */
@@ -518,6 +519,16 @@ static int perf_stat_config(const char *var, const char *value)
 	return 0;
 }
 
+static int perf_pmu_events_config(const char *var, const char *value)
+{
+	if (!strcmp(var, "pmu-events.dir")) {
+		if (!value)
+			return config_error_nonbool(var);
+	}
+
+	return 0;
+}
+
 int perf_default_config(const char *var, const char *value,
 			void *dummy __maybe_unused)
 {
@@ -536,6 +547,9 @@ int perf_default_config(const char *var, const char *value,
 	if (strstarts(var, "buildid."))
 		return perf_buildid_config(var, value);
 
+	if (strstarts(var, "pmu-events."))
+		return perf_pmu_events_config(var, value);
+
 	if (strstarts(var, "stat."))
 		return perf_stat_config(var, value);
 
@@ -917,6 +931,7 @@ void perf_config__exit(void)
 	perf_config_set__delete(config_set);
 	config_set = NULL;
 	mutex_unlock(&config_set_mutex);
+	pmu_layers__exit();
 }
 
 int perf_config_set__write(struct perf_config_set *set,
diff --git a/tools/perf/util/pmu-layer.c b/tools/perf/util/pmu-layer.c
index e54d7e8f487f..2c60fc1e3285 100644
--- a/tools/perf/util/pmu-layer.c
+++ b/tools/perf/util/pmu-layer.c
@@ -21,6 +21,7 @@
 #include <linux/err.h>
 #include <linux/string.h>
 #include <linux/zalloc.h>
+#include "config.h"
 #include "cpumap.h"
 #include "debug.h"
 #include "hashmap.h"
@@ -1848,7 +1849,7 @@ static int user_dir_load_metricgroup(const struct pmu_layer *layer,
 	return ret < 0 ? ret : 0;
 }
 
-static const struct pmu_layer_ops __maybe_unused user_dir_layer_ops = {
+static const struct pmu_layer_ops user_dir_layer_ops = {
 	.find_event = user_dir_find_event,
 	.for_each_event = user_dir_for_each_event,
 	.find_metric = user_dir_find_metric,
@@ -2017,13 +2018,65 @@ void pmu_layers__exit(void)
 	pmu_layers_initialized = false;
 }
 
+static int pmu_layers_add_user_dirs(const char *cfg)
+{
+	const char *p = cfg;
+
+	if (!cfg || !cfg[0])
+		return 0;
+
+	while (*p) {
+		const char *colon = strchr(p, ':');
+		size_t seg_len = colon ? (size_t)(colon - p) : strlen(p);
+
+		if (seg_len > 0 && seg_len < PATH_MAX) {
+			char raw[PATH_MAX];
+			char expanded[PATH_MAX];
+			const char *use_path = raw;
+			int ret;
+
+			memcpy(raw, p, seg_len);
+			raw[seg_len] = '\0';
+
+			if (raw[0] == '~' && (raw[1] == '\0' || raw[1] == '/')) {
+				const char *home = getenv("HOME");
+
+				if (home && home[0]) {
+					int n = snprintf(expanded, sizeof(expanded),
+							 "%s%s", home, raw + 1);
+
+					if (n < 0 || (size_t)n >= sizeof(expanded))
+						return -ENAMETOOLONG;
+					use_path = expanded;
+				}
+			}
+
+			ret = pmu_layers_append(PMU_LAYER_USER_DIR,
+						&user_dir_layer_ops, use_path);
+			if (ret)
+				return ret;
+		}
+
+		if (!colon)
+			break;
+		p = colon + 1;
+	}
+	return 0;
+}
+
 static int pmu_layers_ensure_init(void)
 {
+	const char *user_dirs;
 	int ret;
 
 	if (pmu_layers_initialized)
 		return 0;
 
+	user_dirs = perf_config_get("pmu-events.dir");
+	ret = pmu_layers_add_user_dirs(user_dirs);
+	if (ret)
+		goto err;
+
 	ret = pmu_layers_append(PMU_LAYER_BUILTIN_CPU, &builtin_cpu_layer_ops, NULL);
 	if (ret)
 		goto err;
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 1355b317f3ed..6ecea8f0d382 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -17,6 +17,7 @@
 #include "evsel.h"
 #include "pmus.h"
 #include "pmu.h"
+#include "pmu-layer.h"
 #include "hwmon_pmu.h"
 #include "tool_pmu.h"
 #include "print-events.h"
@@ -124,6 +125,7 @@ void perf_pmus__destroy(void)
 		perf_pmu__delete(pmu);
 	}
 	read_pmu_types = 0;
+	pmu_layers__exit();
 }
 
 static struct perf_pmu *pmu_find(const char *name)
-- 
2.56.1.703.gf848ed807c-goog

