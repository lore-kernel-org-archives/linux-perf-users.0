Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604282;
	b=ireYih3AMYnIAks7qefLCl4LJDLW2Af+tulKNPmP0In5N5U3d16OBxm3iD9GLmeN5emX
	 ioHcO+6lgTnec+UoH6gtGWc3DjONR3M2EbAPH4YCBB66e4LVKWCVa5fFdUU4Kz22vcvth
	 gl2DuVdod0sbLpAn6S0sDEdB/ZMpocrts2bU7U0GbaereLnTggkoUcrcKLso3vA7fTZlE
	 E/7LOcVHRKfrOY/lf05zA7qDs3zPXM6J4ldVqutsDoml1bA85S3CTVe/MQomwR9j3irfP
	 RIlFHCuSt9T6LbvIPK4mdrU6yYnDmUA2F6n8XF2BWl4HQJF2Q0bBUMzC33HVAYuSd/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604282;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=DQrXLAKRA7QClm7f1DY/8eCpz85TsTppCt1W5RXemgM=;
	b=t8ihWxwCgEYRW3V3X9217XfGJIjAhhAKsL2J3o1xne0RygyQYP9Air0eV7ycSt6vNS41
	 AkbyDu5WHUp5oq+ulIEsPZSk1d8UkQM8MLiYvbQZhWgCO/25htyIoSOl9TLztjtJRmpg2
	 ui0F3MAMlUU1dZmR+OIYYYGsLRwYY9Qp5zrf9FFZC3+F7BDtCCvTK2L4bjg4xr8rkwcCE
	 UTX2X0MUaDem8GETCmvwHThj03cRzLAbIckus0PxAivG+P8Kn05+s7qF96QACrVgROs7t
	 MlN7Fkj53NdI/0MSdZXlbTuHW/9sdhJOQeFQxFEADsS6fve/HLVPHBNBNWdebWmesBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=k3wzMJAv;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9EE606A8A0
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D9EE606A8A0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=k3wzMJAv
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-37549877380so1780702eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 13:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794604281; x=1795209081; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DQrXLAKRA7QClm7f1DY/8eCpz85TsTppCt1W5RXemgM=;
        b=k3wzMJAvpblXNtUBHw1rVomiqxwNYa+aevEPWzZQ27WQhrCbbxcsgbzYvpeVfuTNmt
         uEAWx6c72CSBj7qmWKBCEgk+zTdwQe5IZE8TCh3P7Ge0eOqKMvxxooNmMbgK/DlvLvNr
         NmoGev9FhxLYfVUbIaJoHAtQ7LOEOMVAEMmqXOoj8f0diryxeiOaUQ9U7mdV6gOTrNM0
         n4Gs22pcnh6AsfbWXJq/gqmxUqDwJYTTBF4u8EnU3p8M1jceKO9ZGxe4fkSXF6SKkycl
         9c5/C2TL/9ffZMpzyZwF7jhdoMIiAVpfAA8PG6v5NWbiUwIRgiLcg0Z9EOW57ok2XAGb
         OttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794604281; x=1795209081;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DQrXLAKRA7QClm7f1DY/8eCpz85TsTppCt1W5RXemgM=;
        b=PzX/WdzK6fGWgP8tEahvdwKqW+tjAw733jIVjdNIGkwaHSsiQsafEsaJnKc+Krtz4o
         YWShibEDdrVQn+V0STGNWvtRpjPc2w8QM5qFlc5auxiixKa+5m+Q8gEGWasb/7ZPltcG
         0v4myjNoNVNTwua77KrdVKhIIXPQyh2q12pBirBuLfcmVyNjuH0VpaWV95BBh+EWfGRb
         4OHNvu1Xj4qFejTs51v7hN32h75icjWV/GbG5wKqzjzvNZ9pbgFeLEuvKj07F8ZcEvrk
         i5FaD+HNwkL+knIImF3qKoeetxthl6zPHd+JE/iRM0/HOyJ1Edvbd6Tx8kqPNMeEocsO
         +Xzg==
X-Forwarded-Encrypted: i=1; AL+hErEfQLEZabJDd7hjeQjRT+G/Q+e2wVmsPaSaQIDhUvW6H1xyO60cLMr+C0ynaW+BTvLk+ACu5b11hWn8M3HcuyFx@vger.kernel.org
X-Gm-Message-State: APuU4Z+Ze+29Hh1vEerxxdxlK3daDZvHvTSUZN2FFROKzOY/gFPZ0Hys
	DBd2qPnUsP0TxNJGqa4ZBeOYGjQfx5w7YYz3o2IMVUGbQ7T6y629TVfnxDEO38WjLGHvJcbC2Lh
	sVfUtTrSxLA==
X-Received: from dyuw10.prod.google.com ([2002:a05:693c:880a:b0:369:f2ef:9f3d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:72cc:b0:372:598d:c0bb
 with SMTP id 5a478bee46e88-37966e3ad18mr4778085eec.13.1794604280165; Fri, 13
 Nov 2026 13:11:20 -0800 (PST)
Date: Fri, 13 Nov 2026 13:10:55 -0800
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
Message-ID: <20261113211105.3118281-5-irogers@google.com>
Subject: [PATCH 04/11] perf pmu-layer: Add openat-based directory layer with
 literal CPUID/symlink lookup
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Add the filesystem-backed PMU layer backends (user_dir_layer_ops and
sysfs_layer_ops) in util/pmu-layer.c using openat() and io_dir.

A user or system overlay directory <root> supports both portable
multi-CPU trees (keyed by CPUID or uncore identifier) and host-direct
PMU overrides without requiring a runtime mapfile.csv or regex engine:

  <root>/
  |-- cpus/
  |   |-- GenuineIntel-6-4E -> ../models/x86/skylake
  |   |-- GenuineIntel-6-5E -> ../models/x86/skylake
  |   |-- GenuineIntel-6-8F -> ../models/x86/sapphirerapids
  |   |-- GenuineIntel-6-8F-8/          # stepping-specific override
  |   |   `-- cpu/events/inst_retired.any.desc
  |   `-- 0x00000000410fd490 -> ../models/arm64/arm/neoverse-n2
  |-- sys/
  |   `-- 43401 -> ../models/arm64/arm/cmn
  |-- models/
  |   |-- x86/skylake/
  |   |   |-- cpu/{events,metrics}/...
  |   |   `-- uncore_imc/{events,metrics}/...
  |   `-- arm64/arm/neoverse-n2/
  |       `-- armv8_pmuv3/{events,metrics}/...
  |-- default_core/                     # cross-CPU or host-local core
  |   `-- metrics/my_ipc{,.desc}
  |-- <pmu>/{events,metrics}/...        # host-direct PMU overrides
  `-- metricgroups/<group>.desc

Within each <root>, dir_for_each_scope() probes three scopes in order:

1. CPUID scope (<root>/cpus/<cpuid>/):
   Queries the PMU's CPUID via get_cpuid_allow_env_override() (using
   perf_cpu_map__min(pmu->cpus) so heterogeneous core PMUs such as
   cpu_core and cpu_atom resolve against their own CPU's CPUID, and
   honoring PERF_CPUID). build_cpuid_candidates() probes the exact
   CPUID first, followed by deterministic base CPUIDs stripped of
   stepping or revision fields:
   - '-' or ',' delimited CPUIDs (x86, s390, RISC-V): strips trailing
     fields down to two components, e.g.:
       x86:    GenuineIntel-6-8F-8 -> GenuineIntel-6-8F
       s390:   IBM,8561,703        -> IBM,8561
       RISC-V: 0x489-0x8000000000000007-0x1 -> 0x489-0x8000000000000007
   - ARM64 64-bit hex MIDR (0x + 16 hex digits): masks Variant[23:20]
     and Revision[3:0] to zero, e.g.:
       0x00000000411fd493 -> 0x00000000410fd490
   - PowerPC 32-bit hex PVR (0x + 8 hex digits): masks Revision[15:0]
     to zero, e.g.:
       0x00800200 -> 0x00800000

   Each <root> stops at the first matching cpus/<candidate> directory
   so a stepping directory (such as cpus/GenuineIntel-6-8F-8/) does
   not merge coarser model events from cpus/GenuineIntel-6-8F/ in the
   same <root>, while unset sidecars and unoverridden events still fall
   through to subsequent directories in pmu-events.dir, inbuilt JSON,
   and sysfs. Because openat() traverses POSIX symlinks in the kernel
   VFS, multiple CPUIDs sharing a microarchitecture can symlink to a
   single canonical models/<arch>/<model>/ directory.

2. System/uncore identifier scope (<root>/sys/<id>/):
   Probes pmu->id read from /sys/bus/event_source/devices/<pmu>/identifier
   (supporting literal directories or POSIX symlinks).

3. Host-direct scope (<root>/):
   Probes PMU subdirectories directly under <root>/ plus
   <root>/metricgroups/<group>.desc.

Within each matched scope, dir_for_each_pmu_subdir() checks the exact
PMU name (e.g. cpu, cpu_core, uncore_imc_0), pmu->alias_name,
default_core for core PMUs, and suffix-stripped uncore prefixes (e.g.
uncore_imc matching uncore_imc_0).

Also parse extended event sidecars (.unit, .scale, .scale-unit,
.per-pkg, .snapshot, .desc, .long-desc, .topic, .compat, .deprecated,
.legacy-terms, and .retire-lat-{mean,min,max}), metric sidecars
(<pmu>/metrics/*), and metricgroup descriptions with %2F escaping for
'/' in names, and register PMU_LAYER_SYSFS between
PMU_LAYER_BUILTIN_CPU and PMU_LAYER_BUILTIN_COMMON so single-event
sysfs lookups resolve lazily via openat() without readdir().

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu-layer.c | 1351 ++++++++++++++++++++++++++++++++++-
 tools/perf/util/pmu-layer.h |    6 +
 2 files changed, 1350 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/pmu-layer.c b/tools/perf/util/pmu-layer.c
index e4c50cc6d1ea..e54d7e8f487f 100644
--- a/tools/perf/util/pmu-layer.c
+++ b/tools/perf/util/pmu-layer.c
@@ -1,23 +1,39 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <ctype.h>
+#include <dirent.h>
 #include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
 #include <stdbool.h>
 #include <stddef.h>
+#include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <strings.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <api/fs/fs.h>
+#include <api/io.h>
+#include <api/io_dir.h>
 #include <linux/compiler.h>
 #include <linux/err.h>
+#include <linux/string.h>
 #include <linux/zalloc.h>
+#include "cpumap.h"
 #include "debug.h"
 #include "hashmap.h"
+#include "header.h"
 #include "pmu.h"
+#include "pmus.h"
 #include "pmu-layer.h"
 #include "pmu-events/pmu-events.h"
 
 static struct pmu_layer *pmu_layers;
 static size_t nr_pmu_layers;
 static bool pmu_layers_initialized;
+static int active_sysfs_override_fd = -1;
 
 static struct perf_pmu_alias *pmu_layer_alloc_alias(const char *name)
 {
@@ -265,12 +281,40 @@ struct builtin_find_event_ctx {
 	bool is_common;
 };
 
+static bool pmu_layer_alias_is_empty(const struct perf_pmu_alias *alias)
+{
+	return !alias->terms && !alias->legacy_terms &&
+	       !alias->desc && !alias->long_desc && !alias->topic &&
+	       !alias->pmu_name && !alias->compat && !alias->has_scale &&
+	       !alias->has_unit && !alias->has_per_pkg &&
+	       !alias->has_snapshot && !alias->has_deprecated &&
+	       !alias->has_retire_lat_mean && !alias->has_retire_lat_min &&
+	       !alias->has_retire_lat_max;
+}
+
+static void pmu_layer_canon_alias_name(struct perf_pmu_alias *alias,
+				       const char *canon)
+{
+	char *dup_name;
+
+	if (!canon || !canon[0] || !pmu_layer_alias_is_empty(alias) ||
+	    !strcmp(alias->name, canon))
+		return;
+
+	dup_name = strdup(canon);
+	if (dup_name) {
+		free(alias->name);
+		alias->name = dup_name;
+	}
+}
+
 static int builtin_find_event_cb(const struct pmu_event *pe,
 				 const struct pmu_events_table *table __maybe_unused,
 				 void *vdata)
 {
 	struct builtin_find_event_ctx *ctx = vdata;
 
+	pmu_layer_canon_alias_name(ctx->alias, pe->name);
 	return pmu_layer_merge_pe(ctx->alias, pe, ctx->is_common);
 }
 
@@ -288,6 +332,7 @@ static int builtin_find_sys_event_cb(const struct pmu_event *pe,
 		return 0;
 	if (!pmu_uncore_identifier_match(pe->compat, ctx->pmu->id))
 		return 0;
+	pmu_layer_canon_alias_name(ctx->alias, pe->name);
 	return pmu_layer_merge_pe(ctx->alias, pe, /*is_common=*/false);
 }
 
@@ -678,6 +723,1264 @@ static const struct pmu_layer_ops builtin_common_layer_ops = {
 	.load_metricgroup = builtin_common_load_metricgroup,
 };
 
+int pmu_layer__encode_filename(const char *name, char *buf, size_t size)
+{
+	size_t out = 0;
+
+	if (!name || size == 0)
+		return -EINVAL;
+
+	for (size_t i = 0; name[i] != '\0'; i++) {
+		if (name[i] == '/') {
+			if (out + 3 >= size)
+				return -ENAMETOOLONG;
+			buf[out++] = '%';
+			buf[out++] = '2';
+			buf[out++] = 'F';
+		} else {
+			if (out + 1 >= size)
+				return -ENAMETOOLONG;
+			buf[out++] = name[i];
+		}
+	}
+	buf[out] = '\0';
+	return 0;
+}
+
+int pmu_layer__decode_filename(const char *encoded, size_t len,
+			       char *buf, size_t size)
+{
+	size_t out = 0;
+
+	if (!encoded || size == 0)
+		return -EINVAL;
+
+	for (size_t i = 0; i < len; i++) {
+		if (i + 2 < len && encoded[i] == '%' && encoded[i + 1] == '2' &&
+		    (encoded[i + 2] == 'F' || encoded[i + 2] == 'f')) {
+			if (out + 1 >= size)
+				return -ENAMETOOLONG;
+			buf[out++] = '/';
+			i += 2;
+		} else {
+			if (out + 1 >= size)
+				return -ENAMETOOLONG;
+			buf[out++] = encoded[i];
+		}
+	}
+	buf[out] = '\0';
+	return 0;
+}
+
+static int dir_read_file_at(int dirfd, const char *filename, char **out_str)
+{
+	struct stat st;
+	char *buf = NULL;
+	size_t cap = 256, len = 0;
+	int fd, ret = 0;
+
+	fd = openat(dirfd, filename, O_RDONLY);
+	if (fd < 0)
+		return -errno;
+
+	if (fstat(fd, &st) < 0) {
+		ret = -errno;
+		close(fd);
+		return ret;
+	}
+	if (S_ISDIR(st.st_mode)) {
+		close(fd);
+		return -EISDIR;
+	}
+
+	buf = malloc(cap);
+	if (!buf) {
+		close(fd);
+		return -ENOMEM;
+	}
+
+	for (;;) {
+		ssize_t n;
+
+		if (len + 1 >= cap) {
+			char *next;
+
+			cap *= 2;
+			next = realloc(buf, cap);
+			if (!next) {
+				free(buf);
+				close(fd);
+				return -ENOMEM;
+			}
+			buf = next;
+		}
+		n = read(fd, buf + len, cap - len - 1);
+		if (n < 0) {
+			if (errno == EINTR)
+				continue;
+			ret = -errno;
+			free(buf);
+			close(fd);
+			return ret;
+		}
+		if (n == 0)
+			break;
+		len += (size_t)n;
+	}
+	close(fd);
+
+	if (len > 0 && buf[len - 1] == '\n') {
+		len--;
+		if (len > 0 && buf[len - 1] == '\r')
+			len--;
+	}
+	buf[len] = '\0';
+	*out_str = buf;
+	return 0;
+}
+
+static int parse_bool_str(char *str, bool *out_val)
+{
+	size_t len = strlen(str);
+
+	while (len > 0 && isspace((unsigned char)str[len - 1]))
+		str[--len] = '\0';
+
+	if (!strcmp(str, "1") || !strcasecmp(str, "true") || !strcasecmp(str, "yes")) {
+		*out_val = true;
+		return 0;
+	}
+	if (!strcmp(str, "0") || !strcasecmp(str, "false") || !strcasecmp(str, "no")) {
+		*out_val = false;
+		return 0;
+	}
+	return -EINVAL;
+}
+
+static int dir_apply_event_file(int events_fd, const char *filename,
+				enum pmu_event_file_kind kind,
+				const char *pmu_dir_name,
+				bool is_sysfs,
+				struct perf_pmu_alias *alias,
+				bool *matched)
+{
+	char *val = NULL;
+	bool bval;
+	int r = -ENOENT;
+
+	switch (kind) {
+	case PMU_EVENT_FILE_BASE:
+		if (!alias->terms) {
+			r = dir_read_file_at(events_fd, filename, &val);
+			if (r == 0) {
+				alias->terms = val;
+				if (is_sysfs) {
+					alias->from_sysfs = true;
+					alias->info_loaded = true;
+				}
+			}
+		}
+		break;
+	case PMU_EVENT_FILE_LEGACY_TERMS:
+		if (!alias->legacy_terms) {
+			r = dir_read_file_at(events_fd, filename, &val);
+			if (r == 0)
+				alias->legacy_terms = val;
+		}
+		break;
+	case PMU_EVENT_FILE_UNIT:
+		if (!alias->has_unit) {
+			r = dir_read_file_at(events_fd, filename, &val);
+			if (r == 0) {
+				snprintf(alias->unit, sizeof(alias->unit), "%s", val);
+				alias->has_unit = true;
+				free(val);
+			}
+		}
+		break;
+	case PMU_EVENT_FILE_SCALE:
+		if (!alias->has_scale) {
+			r = dir_read_file_at(events_fd, filename, &val);
+			if (r == 0) {
+				if (perf_pmu__convert_scale(val, NULL, &alias->scale) == 0)
+					alias->has_scale = true;
+				free(val);
+			}
+		}
+		break;
+	case PMU_EVENT_FILE_SCALE_UNIT:
+		if (!alias->has_scale || !alias->has_unit) {
+			r = dir_read_file_at(events_fd, filename, &val);
+			if (r == 0) {
+				char *unit_str = NULL;
+				double sval = 1.0;
+
+				if (perf_pmu__convert_scale(val, &unit_str, &sval) == 0) {
+					if (!alias->has_scale) {
+						alias->scale = sval;
+						alias->has_scale = true;
+					}
+					if (!alias->has_unit && unit_str) {
+						snprintf(alias->unit, sizeof(alias->unit),
+							 "%s", unit_str);
+						alias->has_unit = true;
+					}
+				}
+				free(val);
+			}
+		}
+		break;
+	case PMU_EVENT_FILE_PER_PKG:
+		if (!alias->has_per_pkg) {
+			r = dir_read_file_at(events_fd, filename, &val);
+			if (r == 0) {
+				if (parse_bool_str(val, &bval) == 0) {
+					alias->per_pkg = bval;
+					alias->has_per_pkg = true;
+				}
+				free(val);
+			}
+		}
+		break;
+	case PMU_EVENT_FILE_SNAPSHOT:
+		if (!alias->has_snapshot) {
+			r = dir_read_file_at(events_fd, filename, &val);
+			if (r == 0) {
+				if (parse_bool_str(val, &bval) == 0) {
+					alias->snapshot = bval;
+					alias->has_snapshot = true;
+				}
+				free(val);
+			}
+		}
+		break;
+	case PMU_EVENT_FILE_DEPRECATED:
+		if (!alias->has_deprecated) {
+			r = dir_read_file_at(events_fd, filename, &val);
+			if (r == 0) {
+				if (parse_bool_str(val, &bval) == 0) {
+					alias->deprecated = bval;
+					alias->has_deprecated = true;
+				}
+				free(val);
+			}
+		}
+		break;
+	case PMU_EVENT_FILE_DESC:
+		if (!alias->desc) {
+			r = dir_read_file_at(events_fd, filename, &val);
+			if (r == 0)
+				alias->desc = val;
+		}
+		break;
+	case PMU_EVENT_FILE_LONG_DESC:
+		if (!alias->long_desc) {
+			r = dir_read_file_at(events_fd, filename, &val);
+			if (r == 0)
+				alias->long_desc = val;
+		}
+		break;
+	case PMU_EVENT_FILE_TOPIC:
+		if (!alias->topic) {
+			r = dir_read_file_at(events_fd, filename, &val);
+			if (r == 0)
+				alias->topic = val;
+		}
+		break;
+	case PMU_EVENT_FILE_COMPAT:
+		if (!alias->compat) {
+			r = dir_read_file_at(events_fd, filename, &val);
+			if (r == 0)
+				alias->compat = val;
+		}
+		break;
+	case PMU_EVENT_FILE_RETIRE_LAT_MEAN:
+		if (!alias->has_retire_lat_mean) {
+			r = dir_read_file_at(events_fd, filename, &val);
+			if (r == 0) {
+				if (perf_pmu__convert_scale(val, NULL,
+							    &alias->retirement_latency_mean) == 0)
+					alias->has_retire_lat_mean = true;
+				free(val);
+			}
+		}
+		break;
+	case PMU_EVENT_FILE_RETIRE_LAT_MIN:
+		if (!alias->has_retire_lat_min) {
+			r = dir_read_file_at(events_fd, filename, &val);
+			if (r == 0) {
+				if (perf_pmu__convert_scale(val, NULL,
+							    &alias->retirement_latency_min) == 0)
+					alias->has_retire_lat_min = true;
+				free(val);
+			}
+		}
+		break;
+	case PMU_EVENT_FILE_RETIRE_LAT_MAX:
+		if (!alias->has_retire_lat_max) {
+			r = dir_read_file_at(events_fd, filename, &val);
+			if (r == 0) {
+				if (perf_pmu__convert_scale(val, NULL,
+							    &alias->retirement_latency_max) == 0)
+					alias->has_retire_lat_max = true;
+				free(val);
+			}
+		}
+		break;
+	default:
+		break;
+	}
+
+	if (r == 0) {
+		if (matched)
+			*matched = true;
+		if (!is_sysfs && !alias->pmu_name && pmu_dir_name &&
+		    strcmp(pmu_dir_name, "default_core") != 0) {
+			alias->pmu_name = strdup(pmu_dir_name);
+			if (!alias->pmu_name)
+				return -ENOMEM;
+		}
+	}
+	return r == -ENOMEM ? -ENOMEM : 0;
+}
+
+static int parse_aggr_mode_str(const char *str, enum aggr_mode_class *out)
+{
+	if (!strcasecmp(str, "PerChip") || !strcmp(str, "1")) {
+		*out = PerChip;
+		return 0;
+	}
+	if (!strcasecmp(str, "PerCore") || !strcmp(str, "2")) {
+		*out = PerCore;
+		return 0;
+	}
+	return -EINVAL;
+}
+
+static int parse_constraint_str(const char *str, enum metric_event_groups *out)
+{
+	if (!strcasecmp(str, "GROUP_EVENTS") || !strcmp(str, "0")) {
+		*out = MetricGroupEvents;
+		return 0;
+	}
+	if (!strcasecmp(str, "NO_GROUP_EVENTS") || !strcmp(str, "1")) {
+		*out = MetricNoGroupEvents;
+		return 0;
+	}
+	if (!strcasecmp(str, "NO_GROUP_EVENTS_NMI") ||
+	    !strcasecmp(str, "NO_NMI_WATCHDOG") || !strcmp(str, "2")) {
+		*out = MetricNoGroupEventsNmi;
+		return 0;
+	}
+	if (!strcasecmp(str, "NO_GROUP_EVENTS_SMT") || !strcmp(str, "3")) {
+		*out = MetricNoGroupEventsSmt;
+		return 0;
+	}
+	if (!strcasecmp(str, "NO_THRESHOLD_AND_NMI") || !strcmp(str, "4")) {
+		*out = MetricNoGroupEventsThresholdAndNmi;
+		return 0;
+	}
+	return -EINVAL;
+}
+
+static int dir_apply_metric_file(int metrics_fd, const char *filename,
+				 enum pmu_metric_file_kind kind,
+				 const char *pmu_dir_name,
+				 struct perf_pmu_metric *metric,
+				 bool *matched)
+{
+	char *val = NULL;
+	bool bval;
+	int r = -ENOENT;
+
+	switch (kind) {
+	case PMU_METRIC_FILE_BASE:
+		if (!metric->metric_expr) {
+			r = dir_read_file_at(metrics_fd, filename, &val);
+			if (r == 0)
+				metric->metric_expr = val;
+		} else if (faccessat(metrics_fd, filename, F_OK, 0) == 0) {
+			r = 0;
+		}
+		break;
+	case PMU_METRIC_FILE_SCALE_UNIT:
+		if (!metric->unit) {
+			r = dir_read_file_at(metrics_fd, filename, &val);
+			if (r == 0)
+				metric->unit = val;
+		}
+		break;
+	case PMU_METRIC_FILE_DESC:
+		if (!metric->desc) {
+			r = dir_read_file_at(metrics_fd, filename, &val);
+			if (r == 0)
+				metric->desc = val;
+		}
+		break;
+	case PMU_METRIC_FILE_LONG_DESC:
+		if (!metric->long_desc) {
+			r = dir_read_file_at(metrics_fd, filename, &val);
+			if (r == 0)
+				metric->long_desc = val;
+		}
+		break;
+	case PMU_METRIC_FILE_GROUP:
+		if (!metric->metric_group) {
+			r = dir_read_file_at(metrics_fd, filename, &val);
+			if (r == 0)
+				metric->metric_group = val;
+		}
+		break;
+	case PMU_METRIC_FILE_NO_GROUP:
+		if (!metric->metricgroup_no_group) {
+			r = dir_read_file_at(metrics_fd, filename, &val);
+			if (r == 0)
+				metric->metricgroup_no_group = val;
+		}
+		break;
+	case PMU_METRIC_FILE_DEFAULT_GROUP:
+		if (!metric->default_metricgroup_name) {
+			r = dir_read_file_at(metrics_fd, filename, &val);
+			if (r == 0)
+				metric->default_metricgroup_name = val;
+		}
+		break;
+	case PMU_METRIC_FILE_THRESHOLD:
+		if (!metric->metric_threshold) {
+			r = dir_read_file_at(metrics_fd, filename, &val);
+			if (r == 0)
+				metric->metric_threshold = val;
+		}
+		break;
+	case PMU_METRIC_FILE_COMPAT:
+		if (!metric->compat) {
+			r = dir_read_file_at(metrics_fd, filename, &val);
+			if (r == 0)
+				metric->compat = val;
+		}
+		break;
+	case PMU_METRIC_FILE_AGGR_MODE:
+		if (!metric->has_aggr_mode) {
+			r = dir_read_file_at(metrics_fd, filename, &val);
+			if (r == 0) {
+				if (parse_aggr_mode_str(val, &metric->aggr_mode) == 0)
+					metric->has_aggr_mode = true;
+				free(val);
+			}
+		}
+		break;
+	case PMU_METRIC_FILE_CONSTRAINT:
+		if (!metric->has_event_grouping) {
+			r = dir_read_file_at(metrics_fd, filename, &val);
+			if (r == 0) {
+				if (parse_constraint_str(val, &metric->event_grouping) == 0)
+					metric->has_event_grouping = true;
+				free(val);
+			}
+		}
+		break;
+	case PMU_METRIC_FILE_SHOW_EVENTS:
+		if (!metric->has_default_show_events) {
+			r = dir_read_file_at(metrics_fd, filename, &val);
+			if (r == 0) {
+				if (parse_bool_str(val, &bval) == 0) {
+					metric->default_show_events = bval;
+					metric->has_default_show_events = true;
+				}
+				free(val);
+			}
+		}
+		break;
+	default:
+		break;
+	}
+
+	if (r == 0) {
+		if (matched)
+			*matched = true;
+		if (!metric->pmu && pmu_dir_name) {
+			metric->pmu = strdup(pmu_dir_name);
+			if (!metric->pmu)
+				return -ENOMEM;
+		}
+	}
+	return r == -ENOMEM ? -ENOMEM : 0;
+}
+
+static size_t build_cpuid_candidates(const char *cpuid,
+				     char candidates[][128],
+				     size_t max_candidates)
+{
+	size_t n = 0, len;
+
+	if (!cpuid || !cpuid[0] || max_candidates == 0)
+		return 0;
+
+	len = strlen(cpuid);
+	if (len >= sizeof(candidates[0]))
+		return 0;
+
+	snprintf(candidates[n++], sizeof(candidates[0]), "%s", cpuid);
+
+	if (strchr(cpuid, '-') || strchr(cpuid, ',')) {
+		char sep = strchr(cpuid, '-') ? '-' : ',';
+		char work[128];
+
+		snprintf(work, sizeof(work), "%s", cpuid);
+		while (n < max_candidates) {
+			char *last = strrchr(work, sep);
+
+			if (!last || last == work || !strchr(work, sep) ||
+			    strchr(work, sep) == last)
+				break;
+			*last = '\0';
+			snprintf(candidates[n++], sizeof(candidates[0]), "%s", work);
+		}
+	} else if (!strncmp(cpuid, "0x", 2) || !strncmp(cpuid, "0X", 2)) {
+		char *end = NULL;
+		unsigned long long val = strtoull(cpuid, &end, 16);
+
+		if (end && *end == '\0' && n < max_candidates) {
+			if (len == 18) {
+				/* ARM64 MIDR: zero Variant[23:20] and Revision[3:0]. */
+				unsigned long long masked = val & ~0x00f0000fULL;
+
+				if (masked != val)
+					snprintf(candidates[n++], sizeof(candidates[0]),
+						 "0x%016llx", masked);
+			} else if (len == 10) {
+				/* PowerPC PVR: zero Revision[15:0]. */
+				unsigned long long masked = val & ~0xffffULL;
+
+				if (masked != val)
+					snprintf(candidates[n++], sizeof(candidates[0]),
+						 "0x%08llx", masked);
+			}
+		}
+	}
+	return n;
+}
+
+typedef int (*dir_scope_cb)(int scope_fd, struct perf_pmu *pmu, void *ctx);
+
+static int dir_for_each_scope(const struct pmu_layer *layer,
+			      struct perf_pmu *pmu,
+			      dir_scope_cb cb, void *ctx)
+{
+	int root_fd, cpus_fd, ret = 0;
+
+	if (!layer->root_path || !layer->root_path[0])
+		return 0;
+
+	root_fd = open(layer->root_path, O_RDONLY | O_DIRECTORY);
+	if (root_fd < 0)
+		return 0;
+
+	/* 1. Exact and deterministic base CPUID scopes under <root>/cpus/. */
+	cpus_fd = openat(root_fd, "cpus", O_RDONLY | O_DIRECTORY);
+	if (cpus_fd >= 0) {
+		struct perf_cpu cpu = pmu ? perf_cpu_map__min(pmu->cpus)
+					  : (struct perf_cpu){ -1 };
+		char *cpuid = get_cpuid_allow_env_override(cpu);
+
+		if (!cpuid && pmu)
+			cpuid = get_cpuid_allow_env_override((struct perf_cpu){ -1 });
+		if (cpuid) {
+			char cands[6][128];
+			size_t nr_cands = build_cpuid_candidates(cpuid, cands,
+								 ARRAY_SIZE(cands));
+
+			for (size_t i = 0; i < nr_cands; i++) {
+				int scope_fd = openat(cpus_fd, cands[i],
+						      O_RDONLY | O_DIRECTORY);
+
+				if (scope_fd < 0)
+					continue;
+				ret = cb(scope_fd, pmu, ctx);
+				close(scope_fd);
+				break;
+			}
+			free(cpuid);
+		}
+		close(cpus_fd);
+		if (ret) {
+			close(root_fd);
+			return ret;
+		}
+	}
+
+	/* 2. Uncore/system PMU identifier scope under <root>/sys/<pmu->id>/. */
+	if (pmu && pmu->id && pmu->id[0]) {
+		int sys_fd = openat(root_fd, "sys", O_RDONLY | O_DIRECTORY);
+
+		if (sys_fd >= 0) {
+			int scope_fd = openat(sys_fd, pmu->id, O_RDONLY | O_DIRECTORY);
+
+			if (scope_fd >= 0) {
+				ret = cb(scope_fd, pmu, ctx);
+				close(scope_fd);
+			}
+			close(sys_fd);
+			if (ret) {
+				close(root_fd);
+				return ret;
+			}
+		}
+	}
+
+	/* 3. Host-direct layout directly under <root>/. */
+	ret = cb(root_fd, pmu, ctx);
+	close(root_fd);
+	return ret;
+}
+
+typedef int (*dir_pmu_cb)(int pmu_fd, const char *pmu_dir_name,
+			  struct perf_pmu *pmu, void *ctx);
+
+static bool seen_pmu_dir(const char *seen[], size_t nr_seen, const char *name)
+{
+	for (size_t i = 0; i < nr_seen; i++) {
+		if (!strcmp(seen[i], name))
+			return true;
+	}
+	return false;
+}
+
+static int dir_for_each_pmu_subdir(int scope_fd, struct perf_pmu *pmu,
+				   dir_pmu_cb cb, void *ctx)
+{
+	const char *cands[4];
+	char no_suffix[MAX_PMU_NAME_LEN];
+	size_t nr_cands = 0;
+	int ret = 0;
+
+	if (pmu->name && pmu->name[0])
+		cands[nr_cands++] = pmu->name;
+
+	if (pmu->alias_name && pmu->alias_name[0] &&
+	    !seen_pmu_dir(cands, nr_cands, pmu->alias_name))
+		cands[nr_cands++] = pmu->alias_name;
+
+	if (pmu->is_core && !seen_pmu_dir(cands, nr_cands, "default_core"))
+		cands[nr_cands++] = "default_core";
+
+	if (pmu->is_uncore && pmu->name) {
+		size_t base_len = pmu_name_len_no_suffix(pmu->name);
+
+		if (base_len > 0 && base_len < sizeof(no_suffix) &&
+		    base_len != strlen(pmu->name)) {
+			memcpy(no_suffix, pmu->name, base_len);
+			no_suffix[base_len] = '\0';
+			if (!seen_pmu_dir(cands, nr_cands, no_suffix))
+				cands[nr_cands++] = no_suffix;
+		}
+	}
+
+	for (size_t i = 0; i < nr_cands; i++) {
+		int pmu_fd = openat(scope_fd, cands[i], O_RDONLY | O_DIRECTORY);
+
+		if (pmu_fd < 0)
+			continue;
+		ret = cb(pmu_fd, cands[i], pmu, ctx);
+		close(pmu_fd);
+		if (ret)
+			return ret;
+	}
+
+	if (pmu->is_uncore) {
+		int dup_fd = dup(scope_fd);
+
+		if (dup_fd >= 0) {
+			struct io_dir dir;
+			struct io_dirent64 *dent;
+
+			io_dir__init(&dir, dup_fd);
+			while ((dent = io_dir__readdir(&dir)) != NULL) {
+				int pmu_fd;
+
+				if (dent->d_name[0] == '.' ||
+				    seen_pmu_dir(cands, nr_cands, dent->d_name) ||
+				    !strcmp(dent->d_name, "cpus") ||
+				    !strcmp(dent->d_name, "sys") ||
+				    !strcmp(dent->d_name, "models") ||
+				    !strcmp(dent->d_name, "metricgroups"))
+					continue;
+				if (!perf_pmu__name_wildcard_match(pmu, dent->d_name))
+					continue;
+				pmu_fd = openat(scope_fd, dent->d_name,
+						O_RDONLY | O_DIRECTORY);
+				if (pmu_fd < 0)
+					continue;
+				ret = cb(pmu_fd, dent->d_name, pmu, ctx);
+				close(pmu_fd);
+				if (ret)
+					break;
+			}
+			close(dup_fd);
+		}
+	}
+
+	return ret;
+}
+
+static int dir_scan_events_fd(int events_fd, const char *pmu_dir_name,
+			      bool is_sysfs, struct perf_pmu *pmu)
+{
+	int dup_fd = dup(events_fd);
+	struct io_dir dir;
+	struct io_dirent64 *dent;
+	int ret = 0;
+
+	if (dup_fd < 0)
+		return -errno;
+
+	io_dir__init(&dir, dup_fd);
+	while ((dent = io_dir__readdir(&dir)) != NULL) {
+		size_t base_len = 0;
+		enum pmu_event_file_kind kind;
+		char decoded[NAME_MAX];
+		struct perf_pmu_alias *alias;
+
+		if (dent->d_name[0] == '.')
+			continue;
+
+		kind = pmu_event_file_kind(dent->d_name, &base_len);
+		if (base_len == 0 ||
+		    pmu_layer__decode_filename(dent->d_name, base_len,
+					       decoded, sizeof(decoded)) != 0)
+			continue;
+
+		alias = pmu_layer_get_or_create_alias(pmu, decoded);
+		if (!alias) {
+			ret = -ENOMEM;
+			break;
+		}
+		if (alias->resolved && active_sysfs_override_fd < 0)
+			continue;
+
+		ret = dir_apply_event_file(events_fd, dent->d_name, kind,
+					   pmu_dir_name, is_sysfs, alias, NULL);
+		if (ret)
+			break;
+	}
+	close(dup_fd);
+	return ret;
+}
+
+static int dir_scan_metrics_fd(int metrics_fd, const char *pmu_dir_name,
+			       struct perf_pmu *pmu)
+{
+	int dup_fd = dup(metrics_fd);
+	struct io_dir dir;
+	struct io_dirent64 *dent;
+	int ret = 0;
+
+	if (dup_fd < 0)
+		return -errno;
+
+	io_dir__init(&dir, dup_fd);
+	while ((dent = io_dir__readdir(&dir)) != NULL) {
+		size_t base_len = 0;
+		enum pmu_metric_file_kind kind;
+		char decoded[NAME_MAX];
+		struct perf_pmu_metric *metric;
+
+		if (dent->d_name[0] == '.')
+			continue;
+
+		kind = pmu_metric_file_kind(dent->d_name, &base_len);
+		if (base_len == 0 ||
+		    pmu_layer__decode_filename(dent->d_name, base_len,
+					       decoded, sizeof(decoded)) != 0)
+			continue;
+
+		metric = pmu_layer_get_or_create_metric(pmu, decoded);
+		if (!metric) {
+			ret = -ENOMEM;
+			break;
+		}
+
+		ret = dir_apply_metric_file(metrics_fd, dent->d_name, kind,
+					    pmu_dir_name, metric, NULL);
+		if (ret)
+			break;
+	}
+	close(dup_fd);
+	return ret;
+}
+
+struct dir_find_event_ctx {
+	const char *name;
+	struct perf_pmu_alias *alias;
+};
+
+static int dir_probe_user_event_base(int events_fd, const char *enc_base,
+				     const char *canon_name,
+				     const char *pmu_dir_name,
+				     struct perf_pmu_alias *alias)
+{
+	static const struct {
+		const char *suffix;
+		enum pmu_event_file_kind kind;
+	} probes[] = {
+		{ "",			PMU_EVENT_FILE_BASE },
+		{ ".legacy-terms",	PMU_EVENT_FILE_LEGACY_TERMS },
+		{ ".unit",		PMU_EVENT_FILE_UNIT },
+		{ ".scale",		PMU_EVENT_FILE_SCALE },
+		{ ".scale-unit",	PMU_EVENT_FILE_SCALE_UNIT },
+		{ ".per-pkg",		PMU_EVENT_FILE_PER_PKG },
+		{ ".snapshot",		PMU_EVENT_FILE_SNAPSHOT },
+		{ ".desc",		PMU_EVENT_FILE_DESC },
+		{ ".long-desc",		PMU_EVENT_FILE_LONG_DESC },
+		{ ".topic",		PMU_EVENT_FILE_TOPIC },
+		{ ".compat",		PMU_EVENT_FILE_COMPAT },
+		{ ".deprecated",	PMU_EVENT_FILE_DEPRECATED },
+		{ ".retire-lat-mean",	PMU_EVENT_FILE_RETIRE_LAT_MEAN },
+		{ ".retire-lat-min",	PMU_EVENT_FILE_RETIRE_LAT_MIN },
+		{ ".retire-lat-max",	PMU_EVENT_FILE_RETIRE_LAT_MAX },
+	};
+	char filename[NAME_MAX + 32];
+	bool was_empty = pmu_layer_alias_is_empty(alias);
+	bool matched_any = false;
+
+	for (size_t i = 0; i < ARRAY_SIZE(probes); i++) {
+		bool matched = false;
+		int ret;
+
+		snprintf(filename, sizeof(filename), "%s%s", enc_base, probes[i].suffix);
+		ret = dir_apply_event_file(events_fd, filename, probes[i].kind,
+					   pmu_dir_name, /*is_sysfs=*/false,
+					   alias, &matched);
+		if (ret)
+			return ret;
+		if (matched)
+			matched_any = true;
+	}
+
+	if (was_empty && matched_any && canon_name && strcmp(alias->name, canon_name) != 0) {
+		char *dup_name = strdup(canon_name);
+
+		if (!dup_name)
+			return -ENOMEM;
+		free(alias->name);
+		alias->name = dup_name;
+	}
+	return 0;
+}
+
+static int user_dir_find_event_pmu_cb(int pmu_fd, const char *pmu_dir_name,
+				      struct perf_pmu *pmu __maybe_unused,
+				      void *vctx)
+{
+	struct dir_find_event_ctx *ctx = vctx;
+	char lower[NAME_MAX], upper[NAME_MAX];
+	char enc_exact[NAME_MAX], enc_lower[NAME_MAX], enc_upper[NAME_MAX];
+	const char *enc_cands[3], *raw_cands[3];
+	size_t nr_cands = 0, len = strlen(ctx->name);
+	const char *pmu_label;
+	int events_fd;
+
+	if (len == 0 || len >= NAME_MAX || ctx->name[0] == '.' ||
+	    pmu_event_file_kind(ctx->name, NULL) != PMU_EVENT_FILE_BASE)
+		return 0;
+
+	events_fd = openat(pmu_fd, "events", O_RDONLY | O_DIRECTORY);
+	if (events_fd < 0)
+		return 0;
+
+	for (size_t i = 0; i < len; i++) {
+		lower[i] = tolower((unsigned char)ctx->name[i]);
+		upper[i] = toupper((unsigned char)ctx->name[i]);
+	}
+	lower[len] = '\0';
+	upper[len] = '\0';
+
+	if (pmu_layer__encode_filename(ctx->name, enc_exact, sizeof(enc_exact)) == 0) {
+		enc_cands[nr_cands] = enc_exact;
+		raw_cands[nr_cands++] = ctx->name;
+	}
+	if (strcmp(lower, ctx->name) != 0 &&
+	    pmu_layer__encode_filename(lower, enc_lower, sizeof(enc_lower)) == 0) {
+		enc_cands[nr_cands] = enc_lower;
+		raw_cands[nr_cands++] = lower;
+	}
+	if (strcmp(upper, ctx->name) != 0 && strcmp(upper, lower) != 0 &&
+	    pmu_layer__encode_filename(upper, enc_upper, sizeof(enc_upper)) == 0) {
+		enc_cands[nr_cands] = enc_upper;
+		raw_cands[nr_cands++] = upper;
+	}
+
+	pmu_label = !strcmp(pmu_dir_name, "default_core") ? NULL : pmu_dir_name;
+
+	for (size_t i = 0; i < nr_cands; i++) {
+		int ret = dir_probe_user_event_base(events_fd, enc_cands[i], raw_cands[i],
+						    pmu_label, ctx->alias);
+		if (ret) {
+			close(events_fd);
+			return ret;
+		}
+	}
+
+	close(events_fd);
+	return 0;
+}
+
+static int user_dir_find_event_scope_cb(int scope_fd, struct perf_pmu *pmu, void *vctx)
+{
+	return dir_for_each_pmu_subdir(scope_fd, pmu, user_dir_find_event_pmu_cb, vctx);
+}
+
+static int user_dir_find_event(const struct pmu_layer *layer,
+			       struct perf_pmu *pmu, const char *name,
+			       struct perf_pmu_alias *alias)
+{
+	struct dir_find_event_ctx ctx = {
+		.name = name,
+		.alias = alias,
+	};
+	int ret = dir_for_each_scope(layer, pmu, user_dir_find_event_scope_cb, &ctx);
+
+	return ret < 0 ? ret : 0;
+}
+
+static int user_dir_for_each_event_pmu_cb(int pmu_fd, const char *pmu_dir_name,
+					  struct perf_pmu *pmu, void *vctx __maybe_unused)
+{
+	const char *pmu_label;
+	int events_fd, ret;
+
+	events_fd = openat(pmu_fd, "events", O_RDONLY | O_DIRECTORY);
+	if (events_fd < 0)
+		return 0;
+
+	pmu_label = !strcmp(pmu_dir_name, "default_core") ? NULL : pmu_dir_name;
+	ret = dir_scan_events_fd(events_fd, pmu_label, /*is_sysfs=*/false, pmu);
+	close(events_fd);
+	return ret;
+}
+
+static int user_dir_for_each_event_scope_cb(int scope_fd, struct perf_pmu *pmu, void *vctx)
+{
+	return dir_for_each_pmu_subdir(scope_fd, pmu, user_dir_for_each_event_pmu_cb, vctx);
+}
+
+static int user_dir_for_each_event(const struct pmu_layer *layer,
+				   struct perf_pmu *pmu)
+{
+	return dir_for_each_scope(layer, pmu, user_dir_for_each_event_scope_cb, NULL);
+}
+
+struct dir_find_metric_ctx {
+	const char *name;
+	struct perf_pmu_metric *metric;
+};
+
+static int user_dir_find_metric_pmu_cb(int pmu_fd, const char *pmu_dir_name,
+				       struct perf_pmu *pmu __maybe_unused,
+				       void *vctx)
+{
+	static const struct {
+		const char *suffix;
+		enum pmu_metric_file_kind kind;
+	} probes[] = {
+		{ "",			PMU_METRIC_FILE_BASE },
+		{ ".scale-unit",	PMU_METRIC_FILE_SCALE_UNIT },
+		{ ".desc",		PMU_METRIC_FILE_DESC },
+		{ ".long-desc",		PMU_METRIC_FILE_LONG_DESC },
+		{ ".group",		PMU_METRIC_FILE_GROUP },
+		{ ".no-group",		PMU_METRIC_FILE_NO_GROUP },
+		{ ".default-group",	PMU_METRIC_FILE_DEFAULT_GROUP },
+		{ ".threshold",		PMU_METRIC_FILE_THRESHOLD },
+		{ ".compat",		PMU_METRIC_FILE_COMPAT },
+		{ ".aggr-mode",		PMU_METRIC_FILE_AGGR_MODE },
+		{ ".constraint",	PMU_METRIC_FILE_CONSTRAINT },
+		{ ".show-events",	PMU_METRIC_FILE_SHOW_EVENTS },
+	};
+	struct dir_find_metric_ctx *ctx = vctx;
+	char enc_name[NAME_MAX];
+	char filename[NAME_MAX + 32];
+	int metrics_fd;
+
+	if (!ctx->name[0] || ctx->name[0] == '.' ||
+	    pmu_metric_file_kind(ctx->name, NULL) != PMU_METRIC_FILE_BASE ||
+	    pmu_layer__encode_filename(ctx->name, enc_name, sizeof(enc_name)) != 0)
+		return 0;
+
+	metrics_fd = openat(pmu_fd, "metrics", O_RDONLY | O_DIRECTORY);
+	if (metrics_fd < 0)
+		return 0;
+
+	for (size_t i = 0; i < ARRAY_SIZE(probes); i++) {
+		int ret;
+
+		snprintf(filename, sizeof(filename), "%s%s", enc_name, probes[i].suffix);
+		ret = dir_apply_metric_file(metrics_fd, filename, probes[i].kind,
+					    pmu_dir_name, ctx->metric, NULL);
+		if (ret) {
+			close(metrics_fd);
+			return ret;
+		}
+	}
+
+	close(metrics_fd);
+	return 0;
+}
+
+static int user_dir_find_metric_scope_cb(int scope_fd, struct perf_pmu *pmu, void *vctx)
+{
+	return dir_for_each_pmu_subdir(scope_fd, pmu, user_dir_find_metric_pmu_cb, vctx);
+}
+
+static int user_dir_find_metric(const struct pmu_layer *layer,
+				struct perf_pmu *pmu, const char *name,
+				struct perf_pmu_metric *metric)
+{
+	struct dir_find_metric_ctx ctx = {
+		.name = name,
+		.metric = metric,
+	};
+	int ret = dir_for_each_scope(layer, pmu, user_dir_find_metric_scope_cb, &ctx);
+
+	return ret < 0 ? ret : 0;
+}
+
+static int user_dir_for_each_metric_pmu_cb(int pmu_fd, const char *pmu_dir_name,
+					   struct perf_pmu *pmu,
+					   void *vctx __maybe_unused)
+{
+	int metrics_fd, ret;
+
+	metrics_fd = openat(pmu_fd, "metrics", O_RDONLY | O_DIRECTORY);
+	if (metrics_fd < 0)
+		return 0;
+
+	ret = dir_scan_metrics_fd(metrics_fd, pmu_dir_name, pmu);
+	close(metrics_fd);
+	return ret;
+}
+
+static int user_dir_for_each_metric_scope_cb(int scope_fd, struct perf_pmu *pmu, void *vctx)
+{
+	return dir_for_each_pmu_subdir(scope_fd, pmu, user_dir_for_each_metric_pmu_cb, vctx);
+}
+
+static int user_dir_for_each_metric(const struct pmu_layer *layer,
+				    struct perf_pmu *pmu)
+{
+	return dir_for_each_scope(layer, pmu, user_dir_for_each_metric_scope_cb, NULL);
+}
+
+struct dir_metricgroup_ctx {
+	const char *group;
+	struct perf_pmu_metricgroup *mg;
+};
+
+static int dir_probe_metricgroups_fd(int mg_fd, const char *enc_group,
+				     struct perf_pmu_metricgroup *mg)
+{
+	char filename[NAME_MAX + 16];
+	char *val = NULL;
+
+	snprintf(filename, sizeof(filename), "%s.desc", enc_group);
+	if (dir_read_file_at(mg_fd, filename, &val) == 0) {
+		mg->desc = val;
+		return 1;
+	}
+	return 0;
+}
+
+static int user_dir_metricgroup_pmu_cb(int pmu_fd, const char *pmu_dir_name __maybe_unused,
+				       struct perf_pmu *pmu __maybe_unused, void *vctx)
+{
+	struct dir_metricgroup_ctx *ctx = vctx;
+	char enc_group[NAME_MAX];
+	int mg_fd, ret = 0;
+
+	if (pmu_layer__encode_filename(ctx->group, enc_group, sizeof(enc_group)) != 0)
+		return 0;
+
+	mg_fd = openat(pmu_fd, "metricgroups", O_RDONLY | O_DIRECTORY);
+	if (mg_fd < 0)
+		return 0;
+
+	ret = dir_probe_metricgroups_fd(mg_fd, enc_group, ctx->mg);
+	close(mg_fd);
+	return ret;
+}
+
+static int user_dir_metricgroup_scope_cb(int scope_fd, struct perf_pmu *pmu, void *vctx)
+{
+	struct dir_metricgroup_ctx *ctx = vctx;
+	char enc_group[NAME_MAX];
+	int mg_fd, ret = 0;
+
+	if (pmu_layer__encode_filename(ctx->group, enc_group, sizeof(enc_group)) != 0)
+		return 0;
+
+	mg_fd = openat(scope_fd, "metricgroups", O_RDONLY | O_DIRECTORY);
+	if (mg_fd >= 0) {
+		ret = dir_probe_metricgroups_fd(mg_fd, enc_group, ctx->mg);
+		close(mg_fd);
+		if (ret)
+			return ret;
+	}
+	if (pmu)
+		return dir_for_each_pmu_subdir(scope_fd, pmu,
+					       user_dir_metricgroup_pmu_cb, vctx);
+	return 0;
+}
+
+static int user_dir_load_metricgroup(const struct pmu_layer *layer,
+				     struct perf_pmu *pmu,
+				     const char *group,
+				     struct perf_pmu_metricgroup *mg)
+{
+	struct dir_metricgroup_ctx ctx = {
+		.group = group,
+		.mg = mg,
+	};
+	int ret;
+
+	if (mg->desc)
+		return 0;
+
+	ret = dir_for_each_scope(layer, pmu, user_dir_metricgroup_scope_cb, &ctx);
+	return ret < 0 ? ret : 0;
+}
+
+static const struct pmu_layer_ops __maybe_unused user_dir_layer_ops = {
+	.find_event = user_dir_find_event,
+	.for_each_event = user_dir_for_each_event,
+	.find_metric = user_dir_find_metric,
+	.for_each_metric = user_dir_for_each_metric,
+	.load_metricgroup = user_dir_load_metricgroup,
+};
+
+static int sysfs_open_events_dir(struct perf_pmu *pmu)
+{
+	char path[PATH_MAX];
+	size_t len;
+
+	if (active_sysfs_override_fd >= 0) {
+		scnprintf(path, sizeof(path), "%s/events", pmu->name);
+		return openat(active_sysfs_override_fd, path, O_RDONLY | O_DIRECTORY);
+	}
+
+	if (pmu->sysfs_aliases_loaded)
+		return -1;
+
+	len = perf_pmu__event_source_devices_scnprintf(path, sizeof(path));
+	if (!len)
+		return -1;
+	scnprintf(path + len, sizeof(path) - len, "%s/events", pmu->name);
+	return open(path, O_RDONLY | O_DIRECTORY);
+}
+
+static int sysfs_layer_find_event(const struct pmu_layer *layer __maybe_unused,
+				  struct perf_pmu *pmu, const char *name,
+				  struct perf_pmu_alias *alias)
+{
+	char lower[NAME_MAX], upper[NAME_MAX];
+	const char *cands[3];
+	size_t nr_cands = 0, len = strlen(name);
+	int events_fd;
+
+	if (pmu->eager_sysfs_loaded)
+		return 0;
+
+	if (len == 0 || len >= NAME_MAX || name[0] == '.' || strchr(name, '/') ||
+	    pmu_event_file_kind(name, NULL) != PMU_EVENT_FILE_BASE)
+		return 0;
+
+	events_fd = sysfs_open_events_dir(pmu);
+	if (events_fd < 0) {
+		if (errno == ENOENT)
+			pmu->sysfs_aliases_loaded = true;
+		return 0;
+	}
+
+	cands[nr_cands++] = name;
+	for (size_t i = 0; i < len; i++) {
+		lower[i] = tolower((unsigned char)name[i]);
+		upper[i] = toupper((unsigned char)name[i]);
+	}
+	lower[len] = '\0';
+	upper[len] = '\0';
+
+	if (strcmp(lower, name) != 0)
+		cands[nr_cands++] = lower;
+	if (strcmp(upper, name) != 0 && strcmp(upper, lower) != 0)
+		cands[nr_cands++] = upper;
+
+	for (size_t i = 0; i < nr_cands; i++) {
+		struct stat st;
+		char filename[NAME_MAX + 16];
+		int fd = openat(events_fd, cands[i], O_RDONLY);
+
+		if (fd < 0)
+			continue;
+		if (fstat(fd, &st) == 0 && !S_ISDIR(st.st_mode)) {
+			static const struct {
+				const char *suffix;
+				enum pmu_event_file_kind kind;
+			} sysfs_probes[] = {
+				{ "",		PMU_EVENT_FILE_BASE },
+				{ ".unit",	PMU_EVENT_FILE_UNIT },
+				{ ".scale",	PMU_EVENT_FILE_SCALE },
+				{ ".per-pkg",	PMU_EVENT_FILE_PER_PKG },
+				{ ".snapshot",	PMU_EVENT_FILE_SNAPSHOT },
+			};
+			close(fd);
+			pmu_layer_canon_alias_name(alias, cands[i]);
+			for (size_t j = 0; j < ARRAY_SIZE(sysfs_probes); j++) {
+				int ret;
+
+				snprintf(filename, sizeof(filename), "%s%s",
+					 cands[i], sysfs_probes[j].suffix);
+				ret = dir_apply_event_file(events_fd, filename,
+							   sysfs_probes[j].kind, NULL,
+							   /*is_sysfs=*/true,
+							   alias, NULL);
+				if (ret) {
+					close(events_fd);
+					return ret;
+				}
+			}
+			break;
+		}
+		close(fd);
+	}
+
+	close(events_fd);
+	return 0;
+}
+
+static int sysfs_layer_for_each_event(const struct pmu_layer *layer __maybe_unused,
+				      struct perf_pmu *pmu)
+{
+	int events_fd, ret;
+
+	if (pmu->eager_sysfs_loaded && active_sysfs_override_fd < 0)
+		return 0;
+
+	events_fd = sysfs_open_events_dir(pmu);
+	if (events_fd < 0) {
+		pmu->sysfs_aliases_loaded = true;
+		return 0;
+	}
+
+	ret = dir_scan_events_fd(events_fd, NULL, /*is_sysfs=*/true, pmu);
+	close(events_fd);
+	if (!ret)
+		pmu->sysfs_aliases_loaded = true;
+	return ret;
+}
+
+static const struct pmu_layer_ops sysfs_layer_ops = {
+	.find_event = sysfs_layer_find_event,
+	.for_each_event = sysfs_layer_for_each_event,
+};
+
 static int pmu_layers_append(enum pmu_layer_kind kind,
 			     const struct pmu_layer_ops *ops,
 			     const char *root_path)
@@ -725,6 +2028,10 @@ static int pmu_layers_ensure_init(void)
 	if (ret)
 		goto err;
 
+	ret = pmu_layers_append(PMU_LAYER_SYSFS, &sysfs_layer_ops, NULL);
+	if (ret)
+		goto err;
+
 	ret = pmu_layers_append(PMU_LAYER_BUILTIN_COMMON, &builtin_common_layer_ops, NULL);
 	if (ret)
 		goto err;
@@ -786,7 +2093,8 @@ struct perf_pmu_alias *pmu_layer__find_event(struct perf_pmu *pmu,
 	if (hashmap__find(pmu->aliases, name, &alias))
 		return alias->terms ? alias : NULL;
 
-	if (pmu->aliases_loaded)
+	if (pmu->aliases_loaded ||
+	    (pmu->cpu_aliases_added && pmu->sysfs_aliases_loaded))
 		return NULL;
 
 	if (pmu_layers_ensure_init())
@@ -828,17 +2136,21 @@ struct perf_pmu_alias *pmu_layer__find_event(struct perf_pmu *pmu,
 	return alias;
 }
 
-int pmu_layer__load_events(struct perf_pmu *pmu)
+int pmu_layer__load_events_at(struct perf_pmu *pmu, int sysfs_fd)
 {
 	int ret;
 
-	if (!pmu || pmu->aliases_loaded)
+	if (!pmu || pmu->aliases_loaded ||
+	    (pmu->cpu_aliases_added && pmu->sysfs_aliases_loaded))
 		return 0;
 
 	ret = pmu_layers_ensure_init();
 	if (ret)
 		return ret;
 
+	if (sysfs_fd >= 0)
+		active_sysfs_override_fd = sysfs_fd;
+
 	/*
 	 * Any single-event entries cached before full enumeration remain in
 	 * pmu->aliases; top-down iteration fills any missing events cleanly.
@@ -849,17 +2161,28 @@ int pmu_layer__load_events(struct perf_pmu *pmu)
 		if (!layer->ops->for_each_event)
 			continue;
 		ret = layer->ops->for_each_event(layer, pmu);
-		if (ret) {
-			pmu_layer_finalize_aliases(pmu, /*promote_legacy=*/false);
-			return ret;
-		}
+		if (ret)
+			break;
+	}
+
+	active_sysfs_override_fd = -1;
+	if (ret) {
+		pmu_layer_finalize_aliases(pmu, /*promote_legacy=*/false);
+		return ret;
 	}
 
 	pmu_layer_finalize_aliases(pmu, /*promote_legacy=*/true);
+	if (sysfs_fd >= 0)
+		pmu->eager_sysfs_loaded = true;
 	pmu->aliases_loaded = true;
 	return 0;
 }
 
+int pmu_layer__load_events(struct perf_pmu *pmu)
+{
+	return pmu_layer__load_events_at(pmu, -1);
+}
+
 int pmu_layer__merge_event_table(struct perf_pmu *pmu,
 				 const struct pmu_events_table *table)
 {
@@ -876,6 +2199,20 @@ int pmu_layer__merge_event_table(struct perf_pmu *pmu,
 						builtin_for_each_event_cb, &ctx);
 }
 
+int pmu_layer__merge_sys_events(struct perf_pmu *pmu)
+{
+	struct builtin_iter_event_ctx ctx = {
+		.pmu = pmu,
+		.is_common = false,
+		.override_existing = true,
+	};
+
+	if (!pmu || !pmu->id)
+		return 0;
+
+	return pmu_for_each_sys_event(builtin_for_each_sys_event_cb, &ctx);
+}
+
 struct perf_pmu_metric *pmu_layer__find_metric(struct perf_pmu *pmu,
 					       const char *name)
 {
diff --git a/tools/perf/util/pmu-layer.h b/tools/perf/util/pmu-layer.h
index 330af9415448..5d8a33481410 100644
--- a/tools/perf/util/pmu-layer.h
+++ b/tools/perf/util/pmu-layer.h
@@ -154,11 +154,17 @@ void perf_pmu_free_metricgroup(struct perf_pmu_metricgroup *mg);
 void perf_pmu_metric__to_pmu_metric(const struct perf_pmu_metric *src,
 				    struct pmu_metric *dst);
 
+int pmu_layer__encode_filename(const char *name, char *buf, size_t size);
+int pmu_layer__decode_filename(const char *encoded, size_t len,
+			       char *buf, size_t size);
+
 struct perf_pmu_alias *pmu_layer__find_event(struct perf_pmu *pmu,
 					     const char *name);
 int pmu_layer__load_events(struct perf_pmu *pmu);
+int pmu_layer__load_events_at(struct perf_pmu *pmu, int sysfs_fd);
 int pmu_layer__merge_event_table(struct perf_pmu *pmu,
 				 const struct pmu_events_table *table);
+int pmu_layer__merge_sys_events(struct perf_pmu *pmu);
 
 struct perf_pmu_metric *pmu_layer__find_metric(struct perf_pmu *pmu,
 					       const char *name);
-- 
2.56.1.703.gf848ed807c-goog

