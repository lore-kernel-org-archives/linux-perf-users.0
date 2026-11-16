Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794812536;
	b=gz997tCwmQdhost6LNuOKYL+rs6NEKqZNm9OhH82uc4OGinGAoVtIckhQfyMxUJC9usY
	 BGLENkx4dd4Y2FsHkn9QnAZe7nSYsUjHyvKATXFur45uqZWnZuZ+BAZwF7VudpqAYkBi2
	 u8rEUZkTB66fvSlXshtO7ejK+n1MgS9oNdXNCPHLWWSSTDZulDcfcOR3QVIWTDMqyvGuJ
	 LWkI0teRzEhwLQYhxADn5VmVrFZC/y5s0TR+Ci3ikvOJ1RCVr1ogQ6tFIjePeQP6sUTZv
	 GgUOrFrbd2ZTiqzwTYC6Mx+Vm4XqJP98Zfcg63QpES1AwHeJatO0Plx/0U1jbwFUv2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794812536;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=W2bXycj3WQdxqUdIhDRadMTPpN5CjivdQTbhjeDz0xI=;
	b=cWsfoT/DAyr8I/Rs6ZFe+zp+K8XvIiQjqCNR2u/VpXUwH0U7+hJlB5p2vSmCH1bYhQpH
	 Dmrdmx/kf9BxgeabA2a4BsHgTGbiZxQKsGUPTekh/JHzUUDcxC0QRP99uf7thGBSiWXoj
	 UWTWEk31doa2YOWZtuFugruuotPsKjlRoHvNm3Xg6p+2fVIL2CDtb+k3gPcbunlNG7hxs
	 5mkecuyKNOZ5ANLud4/S78OcjrWjozSoUjSHJDrm/BkoMkcsxhO6nYXFk7/aiM7ASk+zA
	 qn1F2G9gI63opri021tUoQkPxR3eKbYEzhbtyLy3NY12wYoe9nQRA4aAlf/GiUEf2TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LaK9yebE;
	arc=none smtp.remote-ip=74.125.82.70
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B632C606A88A
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 07:02:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B632C606A88A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LaK9yebE
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1a71dd190b0so3894675c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 23:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794812535; x=1795417335; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W2bXycj3WQdxqUdIhDRadMTPpN5CjivdQTbhjeDz0xI=;
        b=LaK9yebEneU+koiy4m1rPZhjNX8w3OH3bRV7lRsFa44CGnVfNqWPzzRCvQIwuOdRc3
         wm/prxIaNlTXFm7Bm9rdGJv6srMADF0WfpsEZUE05KHY57Knd9FTzY3SB8e1iJPp7fJ7
         h02BDGNeTW+E8+H2vawFh7tV1B7s/LpYdyW8IYtrJdb1pp2cJU8OvG/RxidsxihIgOXn
         b/igFrXjs75A7QQcqdMze7zAzWqPgrF0eySQoZLl0Mkmqv6Kn3tEsRUqQ1umXpe2jxbk
         4wlQIC9pVFtc+HV4kvIPKO7Pj7uswFCTqLzqZyyBSoJ8wEWTl4jQS0p1ReysYC4is4KC
         RGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794812535; x=1795417335;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W2bXycj3WQdxqUdIhDRadMTPpN5CjivdQTbhjeDz0xI=;
        b=AjkuCDQ0+YATrxlF3/v8ccN8/aU6pptIajjXlqlxWB5HD/dQTF8XxfcxVd0ChQ1JgO
         2N50zxC2ZMblHd34IvUH0RE0xi5msgNRbn0uAGJhRPf5sd85RAauCVdjkEwlfoWu1F60
         eBgNUo3njS503FPCxOvA7CIr0vE8kAVjuLsuohX9YaIg/UILfjA56F3tT0tp+1bBUBvx
         mG5E6oP/D+HpgSn32Bj3M46/TQsrWKQt1L2Uef2uMWRZo2NgxjwbBB5wdxJpHRxruV3Z
         dVcZJwFaFl2SCzcLW0IRXIdlnb6RcudGrds+ojdSPuUh/KWB9i/Exc0JRddSpRT4pjhh
         exqQ==
X-Forwarded-Encrypted: i=1; AL+hErF7bbBkoKyc5bObzR5YSwcaUzKR1wSWDg8CVgGMwQ3rZDF7VnM7zBXmuWT9RWT/CBbD5zTg+TmUjMue7CVvqanF@vger.kernel.org
X-Gm-Message-State: APuU4Z+DSL6KJkXBv5vZCtQ+hmURPdZvtyKXz35zvkQ6mnnZ4Rj5L8+7
	RIzW2lAzJlW/aoByMT9UEMJSxElKw2+2hBGU2scLrSJSdn9VerjUJr6qvoQdkkoR2surw3bV/Eg
	46GI/1suL0g==
X-Received: from dlgw18-n1.prod.google.com ([2002:a05:701a:cc92:10b0:1b5:3444:f158])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4213:20b0:1b3:b4cf:8f18
 with SMTP id a92af1059eb24-1b5031a46bamr10266803c88.41.1794812534506; Sun, 15
 Nov 2026 23:02:14 -0800 (PST)
Date: Sun, 15 Nov 2026 23:01:51 -0800
In-Reply-To: <20261116070200.2972362-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261116070200.2972362-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261116070200.2972362-6-irogers@google.com>
Subject: [PATCH v2 05/11] perf config: Add pmu-events.dir configuration option
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
index 8d3238fd23f1..5c21b28e420d 100644
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
@@ -147,6 +148,7 @@ void perf_pmus__destroy(void)
 		perf_pmu__delete(pmu);
 	}
 	read_pmu_types = 0;
+	pmu_layers__exit();
 }
 
 static struct perf_pmu *pmu_find(const char *name)
-- 
2.56.1.703.gf848ed807c-goog

