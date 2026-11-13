Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604287;
	b=SReUfrS+IIdLHXLIe/IDV2/cecGFm36btG/FQC+N0qjORnLu/dTN9zYpuOECNP8pCykF
	 VTMq/e4GTIjXiUwB3aYXjo3mlo06QAL3D4z2Djdg6E7TSR6pAv+gaOxFqdaMcAVNkBXun
	 szcxG/doCv1531zNezaHjScWkf2lh+rdV0YZJk/vvxAXf3hAYSFwdYaaE4ZM+mVjjlNxR
	 g/etMdohtnNBfSOdFFEtTyB7TWOvo84wd0OGNxxTOmWMbQ3Ry9kk14GwZGtd69mW8bGZ+
	 T9sRCZuwQvtwSCxhD9YcH6wx3pjWmIUmJIw9Oh1KckwJSvf99dC4GdPJA0nu7bhkh/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604287;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=DCSqKol2fYToL03ErUPenQExC8vPmjstVWxCh7sivNc=;
	b=I/HaBKYMW13t30Y5ZL4dyil4uFOKQk3O3iolioeBE4thmAO2u6HX80eEqJFQymLtR0kv
	 8xlEAo07f7ZYFLezt5UBk/JyxT0sEUc2WF2IF/ImeCK+tMMFO1lce3RCs1YGi5x8OZrYo
	 60eVPm+ry5PVDONdbbSZEgrCuGsD+lX+mwGqgMl/Z1rDN2RBgxq5szUK/171mPnXeUgQ9
	 5j0NQO9FLCIVfI3EMtKp7KLpdyNVnCiaMKcPjBovjSfRxCSe9GrpdLXyw+Wh9eXSUPVcM
	 QQVr8XUuiHp8B/P3pUJTWO2T3li2faCpa0gyzOxb2xWMIedZQ6N0dw6SMih6t41edNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DOSMd4s7;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E1D60A261A
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4E1D60A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DOSMd4s7
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-37628596fc9so2887869eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 13:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794604286; x=1795209086; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DCSqKol2fYToL03ErUPenQExC8vPmjstVWxCh7sivNc=;
        b=DOSMd4s7oA1BIvrmvbF18Q0EsSz51XUMne4iK3aUHlHljpaqsD1ekQXJtmWl3ayUi4
         3Cc3S9XrLnaSSvNR1pxtatv9bJMuhfEeIp37DmfvXTvtfAAd4zU7kGi4odjzrooeIEjW
         zP4KdfMwM0lM0O4tPJXukeuj5hFi+UNXoxacJ9qcayOWSNuYXRFXDThQ5TFJCuAY0T/9
         rSrBKIva34nJ1DcHYJrccqjxJhzJY2+XwdsRCj6QW39zLtdTmH/++mJbiesvfaANQLqo
         A0qiAc4b9M6J/YGldpEOszzRR0B9fo4j7/OnlwSAcUalE7J3BAFohZIVKo5XkRP3jvVL
         RbCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794604286; x=1795209086;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DCSqKol2fYToL03ErUPenQExC8vPmjstVWxCh7sivNc=;
        b=NfEW3sc3pg14mEUuM14zZR0Nyjo07ZuOWOBhlZGUJqnrx7Lz0je/b7SYo3dJrm7ucn
         9Z6CSOwzesN4aCYRHrVfU1KgPnMUIRHwt4PHyhK6lOZTLNc2KKwuOJo4NTP7WuOgsflS
         lw9LKuUA4LDm/kkN2qiLOkrPrtpy1D70ARJ3AXOggNYyBfpFlCSQlWUIgp4zafl9StoX
         OnQT+kycie35pXXBB4HQqqAjnlfteqViJDVL5pTAqa7PqxK5hMnixlJlGNWcFTMaY69l
         yOVDd3XnjjUcUO36BqCj8KjqXdMCKdIZ92rSN9rEHK6EmxuYmSk7s9TifO7B47FJEUBO
         WAUg==
X-Forwarded-Encrypted: i=1; AL+hErGRWO7ZggTs2lt5hz6yEZAVKm0oJLPsh2MT8ZCGKqIts/8UQCVd5Q3ChLydgzFFQYo0ymCDWsIOyySeEh0N9oTq@vger.kernel.org
X-Gm-Message-State: APuU4Z+McHZ1n5L0/CyDWWLutI55VhB9PRZl0dmYVnH4nGGZUWDXde8p
	5Jd4H02XNVeCzhUg4hVNlWseDIcWTY8KJ2UF1XYIZPE+O9d5OirmMKRYxzIqvguM6Kn98uUAI7h
	R1UnKUoUeqA==
X-Received: from dybmh6.prod.google.com ([2002:a05:7301:f06:b0:367:8226:2370])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:805c:b0:376:9323:22b8
 with SMTP id 5a478bee46e88-37965da96e5mr3977236eec.10.1794604285512; Fri, 13
 Nov 2026 13:11:25 -0800 (PST)
Date: Fri, 13 Nov 2026 13:10:57 -0800
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
Message-ID: <20261113211105.3118281-7-irogers@google.com>
Subject: [PATCH 06/11] perf pmu: Switch alias resolution and enumeration to
 layered PMU stack
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Route perf_pmu__find_alias(), pmu_find_alias(),
perf_pmu__have_event(), perf_pmu__num_events(),
perf_pmu__for_each_event(), and perf_pmu__name_from_config() through
pmu_layer__find_event() and pmu_layer__load_events().

This replaces the inverted EVENT_SRC_SYSFS + update_alias() in-place
mutation pipeline with uniform top-down attribute merging across the
four-tier stack:

  1. pmu-events.dir user/system overlay directories (when configured)
  2. Compiled-in CPUID and system/SoC JSON tables (PMU_LAYER_BUILTIN_CPU)
  3. Kernel sysfs /sys/bus/event_source/devices/<pmu>/ (PMU_LAYER_SYSFS)
  4. Compiled-in cross-CPU common JSON tables (PMU_LAYER_BUILTIN_COMMON)

Keeping compiled-in CPUID/sys JSON ahead of kernel sysfs and kernel
sysfs ahead of common fallback JSON matches existing upstream perf
precedence (for example, per-CPU JSON enriches or overrides same-named
sysfs events while sysfs events take priority over arch/common
fallbacks), and preserves single-event lazy openat() sysfs lookups
without full readdir().

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 665 ++----------------------------------------
 tools/perf/util/pmu.h |  11 -
 2 files changed, 32 insertions(+), 644 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 685c61935f50..a3e1630c5a84 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -44,20 +44,6 @@
 #include "util/evsel_config.h"
 #include <regex.h>
 
-enum event_source {
-	/* An event loaded from /sys/bus/event_source/devices/<pmu>/events. */
-	EVENT_SRC_SYSFS,
-	/* An event loaded from a CPUID matched json file. */
-	EVENT_SRC_CPU_JSON,
-	/*
-	 * An event loaded from a /sys/bus/event_source/devices/<pmu>/identifier matched json
-	 * file.
-	 */
-	EVENT_SRC_SYS_JSON,
-};
-
-static int pmu_aliases_parse(struct perf_pmu *pmu);
-
 static struct perf_pmu_format *perf_pmu__new_format(struct list_head *list, char *name)
 {
 	struct perf_pmu_format *format;
@@ -269,11 +255,6 @@ enum pmu_event_file_kind pmu_event_file_kind(const char *name, size_t *base_len)
 	return PMU_EVENT_FILE_BASE;
 }
 
-static inline bool pmu_alias_info_file(const char *name)
-{
-	return pmu_event_file_kind(name, NULL) != PMU_EVENT_FILE_BASE;
-}
-
 static const struct {
 	const char *suffix;
 	size_t len;
@@ -310,120 +291,6 @@ enum pmu_metric_file_kind pmu_metric_file_kind(const char *name, size_t *base_le
 	return PMU_METRIC_FILE_BASE;
 }
 
-static int perf_pmu__parse_scale_at(int events_dir_fd, const char *event_name,
-				    struct perf_pmu_alias *alias)
-{
-	ssize_t sret;
-	char scale[128];
-	char filename[NAME_MAX + 16];
-	int fd, ret = -1;
-
-	scnprintf(filename, sizeof(filename), "%s.scale", event_name);
-	fd = openat(events_dir_fd, filename, O_RDONLY);
-	if (fd == -1)
-		return -1;
-
-	sret = read(fd, scale, sizeof(scale) - 1);
-	if (sret <= 0)
-		goto error;
-
-	if (scale[sret - 1] == '\n')
-		scale[sret - 1] = '\0';
-	else
-		scale[sret] = '\0';
-
-	ret = perf_pmu__convert_scale(scale, NULL, &alias->scale);
-	if (!ret)
-		alias->has_scale = true;
-error:
-	close(fd);
-	return ret;
-}
-
-static int perf_pmu__parse_unit_at(int events_dir_fd, const char *event_name,
-				   struct perf_pmu_alias *alias)
-{
-	char filename[NAME_MAX + 16];
-	ssize_t sret;
-	int fd;
-
-	scnprintf(filename, sizeof(filename), "%s.unit", event_name);
-	fd = openat(events_dir_fd, filename, O_RDONLY);
-	if (fd == -1)
-		return -1;
-
-	sret = read(fd, alias->unit, UNIT_MAX_LEN);
-	if (sret <= 0)
-		goto error;
-
-	close(fd);
-
-	if (alias->unit[sret - 1] == '\n')
-		alias->unit[sret - 1] = '\0';
-	else
-		alias->unit[sret] = '\0';
-
-	alias->has_unit = true;
-	return 0;
-error:
-	close(fd);
-	alias->unit[0] = '\0';
-	return -1;
-}
-
-static int perf_pmu__parse_bool_at(int events_dir_fd, const char *event_name,
-				   const char *suffix, bool *out_val)
-{
-	char filename[NAME_MAX + 32];
-	char buf[16];
-	ssize_t sret;
-	int fd;
-
-	scnprintf(filename, sizeof(filename), "%s.%s", event_name, suffix);
-	fd = openat(events_dir_fd, filename, O_RDONLY);
-	if (fd == -1)
-		return -ENOENT;
-
-	sret = read(fd, buf, sizeof(buf) - 1);
-	close(fd);
-	if (sret <= 0)
-		return -EINVAL;
-
-	while (sret > 0 && isspace(buf[sret - 1]))
-		sret--;
-	buf[sret] = '\0';
-
-	if (!strcmp(buf, "1") || !strcasecmp(buf, "true") || !strcasecmp(buf, "yes")) {
-		*out_val = true;
-		return 0;
-	}
-	if (!strcmp(buf, "0") || !strcasecmp(buf, "false") || !strcasecmp(buf, "no")) {
-		*out_val = false;
-		return 0;
-	}
-	return -EINVAL;
-}
-
-static void read_alias_info_at(int events_dir_fd, struct perf_pmu_alias *alias)
-{
-	bool val;
-
-	if (!alias->from_sysfs || alias->info_loaded || events_dir_fd < 0)
-		return;
-
-	perf_pmu__parse_unit_at(events_dir_fd, alias->name, alias);
-	perf_pmu__parse_scale_at(events_dir_fd, alias->name, alias);
-	if (perf_pmu__parse_bool_at(events_dir_fd, alias->name, "per-pkg", &val) == 0) {
-		alias->per_pkg = val;
-		alias->has_per_pkg = true;
-	}
-	if (perf_pmu__parse_bool_at(events_dir_fd, alias->name, "snapshot", &val) == 0) {
-		alias->snapshot = val;
-		alias->has_snapshot = true;
-	}
-	alias->info_loaded = true;
-}
-
 /* Delete an alias entry. */
 void perf_pmu_free_alias(struct perf_pmu_alias *alias)
 {
@@ -536,393 +403,22 @@ static void perf_pmu__del_metricgroups(struct perf_pmu *pmu)
 	pmu->metricgroups = NULL;
 }
 
-static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
-			       const char *desc, const char *val, int val_fd,
-			       const struct pmu_event *pe, enum event_source src,
-			       int events_dir_fd);
-
 static struct perf_pmu_alias *perf_pmu__find_alias(struct perf_pmu *pmu,
 						   const char *name,
 						   bool load)
 {
 	struct perf_pmu_alias *alias = NULL;
-	char path[PATH_MAX];
-	char lower_name[NAME_MAX];
-	char upper_name[NAME_MAX];
-	const char *candidates[3];
-	size_t nr_candidates = 0, name_len, path_len;
-	int events_dir_fd;
-
-	if (hashmap__find(pmu->aliases, name, &alias))
-		return alias;
-
-	if (!load || pmu->sysfs_aliases_loaded)
-		return NULL;
-
-	name_len = strlen(name);
-	if (name_len == 0 || name_len >= NAME_MAX || name[0] == '.' ||
-	    strchr(name, '/') || pmu_alias_info_file(name))
-		return NULL;
 
-	path_len = perf_pmu__event_source_devices_scnprintf(path, sizeof(path));
-	if (!path_len)
+	if (!pmu || !name)
 		return NULL;
-	scnprintf(path + path_len, sizeof(path) - path_len, "%s/events", pmu->name);
 
-	events_dir_fd = open(path, O_DIRECTORY | O_RDONLY);
-	if (events_dir_fd == -1) {
-		if (errno == ENOENT)
-			pmu->sysfs_aliases_loaded = true;
+	if (!load) {
+		if (hashmap__find(pmu->aliases, name, &alias))
+			return alias->terms ? alias : NULL;
 		return NULL;
 	}
 
-	candidates[nr_candidates++] = name;
-	for (size_t i = 0; i < name_len; i++) {
-		lower_name[i] = tolower((unsigned char)name[i]);
-		upper_name[i] = toupper((unsigned char)name[i]);
-	}
-	lower_name[name_len] = '\0';
-	upper_name[name_len] = '\0';
-
-	if (strcmp(lower_name, name) != 0)
-		candidates[nr_candidates++] = lower_name;
-	if (strcmp(upper_name, name) != 0 && strcmp(upper_name, lower_name) != 0)
-		candidates[nr_candidates++] = upper_name;
-
-	/*
-	 * Lazily open only the requested event and its sidecars via openat()
-	 * rather than scanning every file in sysfs/events/.
-	 */
-	for (size_t i = 0; i < nr_candidates; i++) {
-		struct stat st;
-		int fd = openat(events_dir_fd, candidates[i], O_RDONLY);
-
-		if (fd < 0)
-			continue;
-		if (fstat(fd, &st) == 0 && !S_ISDIR(st.st_mode)) {
-			if (perf_pmu__new_alias(pmu, candidates[i], /*desc=*/NULL,
-						/*val=*/NULL, fd, /*pe=*/NULL,
-						EVENT_SRC_SYSFS, events_dir_fd) == 0 &&
-			    hashmap__find(pmu->aliases, name, &alias)) {
-				read_alias_info_at(events_dir_fd, alias);
-				close(fd);
-				break;
-			}
-		}
-		close(fd);
-	}
-
-	close(events_dir_fd);
-	return alias;
-}
-
-static bool assign_str(const char *name, const char *field, char **old_str,
-				const char *new_str)
-{
-	if (!*old_str && new_str) {
-		*old_str = strdup(new_str);
-		return true;
-	}
-
-	if (!new_str || !strcasecmp(*old_str, new_str))
-		return false; /* Nothing to update. */
-
-	pr_debug("alias %s differs in field '%s' ('%s' != '%s')\n",
-		name, field, *old_str, new_str);
-	zfree(old_str);
-	*old_str = strdup(new_str);
-	return true;
-}
-
-static void read_alias_info(struct perf_pmu *pmu, struct perf_pmu_alias *alias)
-{
-	char path[PATH_MAX];
-	size_t len;
-	int events_dir_fd;
-
-	if (!alias->from_sysfs || alias->info_loaded)
-		return;
-
-	len = perf_pmu__event_source_devices_scnprintf(path, sizeof(path));
-	if (!len)
-		return;
-	scnprintf(path + len, sizeof(path) - len, "%s/events", pmu->name);
-
-	events_dir_fd = open(path, O_DIRECTORY | O_RDONLY);
-	if (events_dir_fd == -1)
-		return;
-
-	read_alias_info_at(events_dir_fd, alias);
-	close(events_dir_fd);
-}
-
-struct update_alias_data {
-	struct perf_pmu *pmu;
-	struct perf_pmu_alias *alias;
-	int events_dir_fd;
-	bool legacy;
-};
-
-static int update_alias(const struct pmu_event *pe,
-			const struct pmu_events_table *table __maybe_unused,
-			void *vdata)
-{
-	struct update_alias_data *data = vdata;
-	int ret = 0;
-
-	if (data->events_dir_fd >= 0)
-		read_alias_info_at(data->events_dir_fd, data->alias);
-	else
-		read_alias_info(data->pmu, data->alias);
-	assign_str(pe->name, "desc", &data->alias->desc, pe->desc);
-	assign_str(pe->name, "long_desc", &data->alias->long_desc, pe->long_desc);
-	assign_str(pe->name, "topic", &data->alias->topic, pe->topic);
-	data->alias->per_pkg = pe->perpkg;
-	if (pe->event) {
-		if (data->legacy) {
-			zfree(&data->alias->legacy_terms);
-			data->alias->legacy_terms = strdup(pe->event);
-		} else {
-			zfree(&data->alias->terms);
-			data->alias->terms = strdup(pe->event);
-		}
-	}
-	if (!ret && pe->unit) {
-		char *unit;
-
-		ret = perf_pmu__convert_scale(pe->unit, &unit, &data->alias->scale);
-		if (!ret)
-			snprintf(data->alias->unit, sizeof(data->alias->unit), "%s", unit);
-	}
-	if (!ret && pe->retirement_latency_mean) {
-		ret = parse_double(pe->retirement_latency_mean, NULL,
-					      &data->alias->retirement_latency_mean);
-	}
-	if (!ret && pe->retirement_latency_min) {
-		ret = parse_double(pe->retirement_latency_min, NULL,
-					      &data->alias->retirement_latency_min);
-	}
-	if (!ret && pe->retirement_latency_max) {
-		ret = parse_double(pe->retirement_latency_max, NULL,
-					      &data->alias->retirement_latency_max);
-	}
-	return ret;
-}
-
-static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
-			       const char *desc, const char *val, int val_fd,
-			       const struct pmu_event *pe, enum event_source src,
-			       int events_dir_fd)
-{
-	struct perf_pmu_alias *alias, *old_alias;
-	int ret = 0;
-	const char *long_desc = NULL, *topic = NULL, *unit = NULL, *pmu_name = NULL;
-	bool deprecated = false, perpkg = false;
-
-	if (perf_pmu__find_alias(pmu, name, /*load=*/ false)) {
-		/* Alias was already created/loaded. */
-		return 0;
-	}
-
-	if (pe) {
-		long_desc = pe->long_desc;
-		topic = pe->topic;
-		unit = pe->unit;
-		perpkg = pe->perpkg;
-		deprecated = pe->deprecated;
-		if (pe->pmu && strcmp(pe->pmu, "default_core"))
-			pmu_name = pe->pmu;
-	}
-
-	alias = zalloc(sizeof(*alias));
-	if (!alias)
-		return -ENOMEM;
-
-	alias->scale = 1.0;
-	alias->unit[0] = '\0';
-	alias->per_pkg = perpkg;
-	alias->snapshot = false;
-	alias->deprecated = deprecated;
-	alias->retirement_latency_mean = 0.0;
-	alias->retirement_latency_min = 0.0;
-	alias->retirement_latency_max = 0.0;
-
-	if (!ret && pe && pe->retirement_latency_mean) {
-		ret = parse_double(pe->retirement_latency_mean, NULL,
-				   &alias->retirement_latency_mean);
-	}
-	if (!ret && pe && pe->retirement_latency_min) {
-		ret = parse_double(pe->retirement_latency_min, NULL,
-				   &alias->retirement_latency_min);
-	}
-	if (!ret && pe && pe->retirement_latency_max) {
-		ret = parse_double(pe->retirement_latency_max, NULL,
-				   &alias->retirement_latency_max);
-	}
-	if (ret) {
-		perf_pmu_free_alias(alias);
-		return ret;
-	}
-
-	if (val_fd < 0) {
-		alias->terms = strdup(val);
-	} else {
-		char buf[256];
-		struct io io;
-		size_t line_len;
-
-		io__init(&io, val_fd, buf, sizeof(buf));
-		ret = io__getline(&io, &alias->terms, &line_len) < 0 ? -errno : 0;
-		if (ret) {
-			pr_err("Failed to read alias %s\n", name);
-			perf_pmu_free_alias(alias);
-			return ret;
-		}
-		if (line_len >= 1 && alias->terms[line_len - 1] == '\n')
-			alias->terms[line_len - 1] = '\0';
-	}
-	alias->name = strdup(name);
-	alias->desc = desc ? strdup(desc) : NULL;
-	alias->long_desc = long_desc ? strdup(long_desc) : NULL;
-	alias->topic = topic ? strdup(topic) : NULL;
-	alias->pmu_name = pmu_name ? strdup(pmu_name) : NULL;
-	alias->compat = (pe && pe->compat) ? strdup(pe->compat) : NULL;
-	if (unit) {
-		if (perf_pmu__convert_scale(unit, (char **)&unit, &alias->scale) < 0) {
-			perf_pmu_free_alias(alias);
-			return -1;
-		}
-		snprintf(alias->unit, sizeof(alias->unit), "%s", unit);
-	}
-	switch (src) {
-	default:
-	case EVENT_SRC_SYSFS:
-		alias->from_sysfs = true;
-		if (pmu->events_table || pmu->is_core) {
-			/* Update an event from sysfs with json data. */
-			struct update_alias_data data = {
-				.pmu = pmu,
-				.alias = alias,
-				.events_dir_fd = events_dir_fd,
-				.legacy = false,
-			};
-			if ((pmu_events_table__find_event(pmu->events_table, pmu, name,
-							  update_alias, &data) == 0)) {
-				/*
-				 * Override sysfs encodings with json encodings
-				 * specific to the cpuid.
-				 */
-				pmu->cpu_common_json_aliases++;
-			}
-			if (pmu->is_core) {
-				/* Add in legacy encodings. */
-				data.legacy = true;
-				if (pmu_events_table__find_event(
-						perf_pmu__default_core_events_table(),
-						pmu, name, update_alias, &data) == 0)
-					pmu->cpu_common_json_aliases++;
-			}
-		}
-		pmu->sysfs_aliases++;
-		break;
-	case  EVENT_SRC_CPU_JSON:
-		pmu->cpu_json_aliases++;
-		break;
-	case  EVENT_SRC_SYS_JSON:
-		pmu->sys_json_aliases++;
-		break;
-
-	}
-	hashmap__set(pmu->aliases, alias->name, alias, /*old_key=*/ NULL, &old_alias);
-	perf_pmu_free_alias(old_alias);
-	return 0;
-}
-
-/*
- * Reading the pmu event aliases definition, which should be located at:
- * /sys/bus/event_source/devices/<dev>/events as sysfs group attributes.
- */
-static int __pmu_aliases_parse(struct perf_pmu *pmu, int events_dir_fd, bool eager_info)
-{
-	struct io_dirent64 *evt_ent;
-	struct io_dir event_dir;
-
-	io_dir__init(&event_dir, events_dir_fd);
-
-	while ((evt_ent = io_dir__readdir(&event_dir))) {
-		char *name = evt_ent->d_name;
-		int fd;
-
-		if (!strcmp(name, ".") || !strcmp(name, "..") || name[0] == '.')
-			continue;
-
-		/*
-		 * skip info files parsed in perf_pmu__new_alias()
-		 */
-		if (pmu_alias_info_file(name))
-			continue;
-
-		fd = openat(events_dir_fd, name, O_RDONLY);
-		if (fd == -1) {
-			pr_debug("Cannot open %s\n", name);
-			continue;
-		}
-
-		if (perf_pmu__new_alias(pmu, name, /*desc=*/ NULL,
-					/*val=*/ NULL, fd, /*pe=*/ NULL,
-					EVENT_SRC_SYSFS, events_dir_fd) < 0)
-			pr_debug("Cannot set up %s\n", name);
-		else if (eager_info) {
-			struct perf_pmu_alias *alias;
-
-			if (hashmap__find(pmu->aliases, name, &alias))
-				read_alias_info_at(events_dir_fd, alias);
-		}
-		close(fd);
-	}
-
-	pmu->sysfs_aliases_loaded = true;
-	return 0;
-}
-
-static int pmu_aliases_parse(struct perf_pmu *pmu)
-{
-	char path[PATH_MAX];
-	size_t len;
-	int events_dir_fd, ret;
-
-	if (pmu->sysfs_aliases_loaded)
-		return 0;
-
-	len = perf_pmu__event_source_devices_scnprintf(path, sizeof(path));
-	if (!len)
-		return 0;
-	scnprintf(path + len, sizeof(path) - len, "%s/events", pmu->name);
-
-	events_dir_fd = open(path, O_DIRECTORY);
-	if (events_dir_fd == -1) {
-		pmu->sysfs_aliases_loaded = true;
-		return 0;
-	}
-	ret = __pmu_aliases_parse(pmu, events_dir_fd, /*eager_info=*/false);
-	close(events_dir_fd);
-	return ret;
-}
-
-static int pmu_aliases_parse_eager(struct perf_pmu *pmu, int sysfs_fd)
-{
-	char path[NAME_MAX + 8];
-	int ret, events_dir_fd;
-
-	scnprintf(path, sizeof(path), "%s/events", pmu->name);
-	events_dir_fd = openat(sysfs_fd, path, O_DIRECTORY, 0);
-	if (events_dir_fd == -1) {
-		pmu->sysfs_aliases_loaded = true;
-		return 0;
-	}
-	ret = __pmu_aliases_parse(pmu, events_dir_fd, /*eager_info=*/true);
-	close(events_dir_fd);
-	return ret;
+	return pmu_layer__find_event(pmu, name);
 }
 
 static int pmu_alias_terms(struct perf_pmu_alias *alias, struct list_head *terms)
@@ -1205,78 +701,18 @@ bool pmu_uncore_identifier_match(const char *compat, const char *id)
 	return match;
 }
 
-static int pmu_add_cpu_aliases_map_callback(const struct pmu_event *pe,
-					const struct pmu_events_table *table __maybe_unused,
-					void *vdata)
-{
-	struct perf_pmu *pmu = vdata;
-
-	perf_pmu__new_alias(pmu, pe->name, pe->desc, pe->event, /*val_fd=*/ -1,
-			    pe, EVENT_SRC_CPU_JSON, /*events_dir_fd=*/ -1);
-	return 0;
-}
-
 /*
  * From the pmu_events_table, find the events that correspond to the given
- * PMU and add them to the list 'head'.
+ * PMU and merge them into pmu->aliases.
  */
 void pmu_add_cpu_aliases_table(struct perf_pmu *pmu, const struct pmu_events_table *table)
 {
-	pmu_events_table__for_each_event(table, pmu, pmu_add_cpu_aliases_map_callback, pmu);
-}
-
-static void pmu_add_cpu_aliases(struct perf_pmu *pmu)
-{
-	if (!pmu->events_table && !pmu->is_core)
-		return;
-
-	if (pmu->cpu_aliases_added)
-		return;
-
-	pmu_add_cpu_aliases_table(pmu, pmu->events_table);
-	if (pmu->is_core)
-		pmu_add_cpu_aliases_table(pmu, perf_pmu__default_core_events_table());
-
-	pmu->cpu_aliases_added = true;
-}
-
-static int pmu_add_sys_aliases_iter_fn(const struct pmu_event *pe,
-				       const struct pmu_events_table *table __maybe_unused,
-				       void *vdata)
-{
-	struct perf_pmu *pmu = vdata;
-
-	if (!pe->compat || !pe->pmu) {
-		/* No data to match. */
-		return 0;
-	}
-
-	if (!perf_pmu__match_wildcard_uncore(pmu->name, pe->pmu) &&
-	    !perf_pmu__match_wildcard_uncore(pmu->alias_name, pe->pmu)) {
-		/* PMU name/alias_name don't match. */
-		return 0;
-	}
-
-	if (pmu_uncore_identifier_match(pe->compat, pmu->id)) {
-		/* Id matched. */
-		perf_pmu__new_alias(pmu,
-				pe->name,
-				pe->desc,
-				pe->event,
-				/*val_fd=*/ -1,
-				pe,
-				EVENT_SRC_SYS_JSON,
-				/*events_dir_fd=*/ -1);
-	}
-	return 0;
+	pmu_layer__merge_event_table(pmu, table);
 }
 
 void pmu_add_sys_aliases(struct perf_pmu *pmu)
 {
-	if (!pmu->id)
-		return;
-
-	pmu_for_each_sys_event(pmu_add_sys_aliases_iter_fn, pmu);
+	pmu_layer__merge_sys_events(pmu);
 }
 
 static char *pmu_find_alias_name(struct perf_pmu *pmu, int dirfd)
@@ -1466,21 +902,12 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 	pmu->alias_name = pmu_find_alias_name(pmu, dirfd);
 	pmu->events_table = perf_pmu__find_events_table(pmu);
 	pmu->metrics_table = perf_pmu__lookup_metrics_table(pmu);
-	/*
-	 * Load the sys json events/aliases when loading the PMU as each event
-	 * may have a different compat regular expression. We therefore can't
-	 * know the number of sys json events/aliases without computing the
-	 * regular expressions for them all.
-	 */
-	pmu_add_sys_aliases(pmu);
 	list_add_tail(&pmu->list, pmus);
 
 	perf_pmu__arch_init(pmu);
 
-	if (eager_load) {
-		pmu_aliases_parse_eager(pmu, dirfd);
-		pmu->eager_sysfs_loaded = true;
-	}
+	if (eager_load)
+		pmu_layer__load_events_at(pmu, dirfd);
 
 	return pmu;
 }
@@ -1917,7 +1344,6 @@ int perf_pmu__config(struct perf_pmu *pmu, struct perf_event_attr *attr,
 static struct perf_pmu_alias *pmu_find_alias(struct perf_pmu *pmu,
 					     struct parse_events_term *term)
 {
-	struct perf_pmu_alias *alias;
 	const char *name;
 
 	if (parse_events__is_hardcoded_term(term))
@@ -1938,32 +1364,16 @@ static struct perf_pmu_alias *pmu_find_alias(struct perf_pmu *pmu,
 		return NULL;
 	}
 
-	alias = perf_pmu__find_alias(pmu, name, /*load=*/ true);
-	if (alias || pmu->cpu_aliases_added)
-		return alias;
-
-	/* Alias doesn't exist, try to get it from the json events. */
-	if ((pmu_events_table__find_event(pmu->events_table, pmu, name,
-					  pmu_add_cpu_aliases_map_callback,
-					  pmu) == 0) ||
-	    (pmu->is_core &&
-	     pmu_events_table__find_event(perf_pmu__default_core_events_table(),
-					  pmu, name,
-					  pmu_add_cpu_aliases_map_callback,
-					  pmu) == 0)) {
-		alias = perf_pmu__find_alias(pmu, name, /*load=*/ false);
-	}
-	return alias;
+	return perf_pmu__find_alias(pmu, name, /*load=*/true);
 }
 
 
-static int check_info_data(struct perf_pmu *pmu,
+static int check_info_data(struct perf_pmu *pmu __maybe_unused,
 			   struct perf_pmu_alias *alias,
 			   struct perf_pmu_info *info,
 			   struct parse_events_error *err,
 			   int column)
 {
-	read_alias_info(pmu, alias);
 	/*
 	 * Only one term in event definition can
 	 * define unit, scale and snapshot, fail
@@ -2311,20 +1721,13 @@ bool perf_pmu__have_event(struct perf_pmu *pmu, const char *name)
 		return hwmon_pmu__have_event(pmu, name);
 	if (perf_pmu__is_drm(pmu))
 		return drm_pmu__have_event(pmu, name);
-	if (perf_pmu__find_alias(pmu, name, /*load=*/ true) != NULL)
-		return true;
-	if (pmu->cpu_aliases_added || (!pmu->events_table && !pmu->is_core))
-		return false;
-	if (pmu_events_table__find_event(pmu->events_table, pmu, name, NULL, NULL) == 0)
-		return true;
-	return pmu->is_core &&
-		pmu_events_table__find_event(perf_pmu__default_core_events_table(),
-					     pmu, name, NULL, NULL) == 0;
+	return perf_pmu__find_alias(pmu, name, /*load=*/true) != NULL;
 }
 
 size_t perf_pmu__num_events(struct perf_pmu *pmu)
 {
-	size_t nr;
+	struct hashmap_entry *entry;
+	size_t bkt, nr = 0;
 
 	if (perf_pmu__is_tracepoint(pmu))
 		return tp_pmu__num_events(pmu);
@@ -2333,25 +1736,17 @@ size_t perf_pmu__num_events(struct perf_pmu *pmu)
 	if (perf_pmu__is_drm(pmu))
 		return drm_pmu__num_events(pmu);
 
-	pmu_aliases_parse(pmu);
-	nr = pmu->sysfs_aliases + pmu->sys_json_aliases;
+	pmu_layer__load_events(pmu);
+	hashmap__for_each_entry(pmu->aliases, entry, bkt) {
+		struct perf_pmu_alias *event = entry->pvalue;
 
-	if (pmu->cpu_aliases_added) {
-		nr += pmu->cpu_json_aliases;
-	} else if (pmu->events_table || pmu->is_core) {
-		nr += pmu_events_table__num_events(pmu->events_table, pmu);
-		if (pmu->is_core) {
-			nr += pmu_events_table__num_events(
-				perf_pmu__default_core_events_table(), pmu);
-		}
-		nr -= pmu->cpu_common_json_aliases;
-	} else {
-		assert(pmu->cpu_json_aliases == 0 && pmu->cpu_common_json_aliases == 0);
+		if (!event->terms)
+			continue;
+		if (perf_pmu__is_tool(pmu) && tool_pmu__skip_event(event->name))
+			continue;
+		nr++;
 	}
 
-	if (perf_pmu__is_tool(pmu))
-		nr -= tool_pmu__num_skip_events();
-
 	return pmu->selectable ? nr + 1 : nr;
 }
 
@@ -2469,12 +1864,13 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 	if (perf_pmu__is_drm(pmu))
 		return drm_pmu__for_each_event(pmu, state, cb);
 
-	pmu_aliases_parse(pmu);
-	pmu_add_cpu_aliases(pmu);
+	pmu_layer__load_events(pmu);
 	hashmap__for_each_entry(pmu->aliases, entry, bkt) {
 		struct perf_pmu_alias *event = entry->pvalue;
 		size_t buf_used, pmu_name_len;
 
+		if (!event->terms)
+			continue;
 		if (perf_pmu__is_tool(pmu) && tool_pmu__skip_event(event->name))
 			continue;
 
@@ -2999,12 +2395,15 @@ const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config)
 	if (!pmu)
 		return NULL;
 
-	pmu_aliases_parse(pmu);
-	pmu_add_cpu_aliases(pmu);
+	pmu_layer__load_events(pmu);
 	hashmap__for_each_entry(pmu->aliases, entry, bkt) {
 		struct perf_pmu_alias *event = entry->pvalue;
 		struct perf_event_attr attr = {.config = 0,};
-		int ret = perf_pmu__parse_terms_to_attr(pmu, event->terms, &attr);
+		int ret;
+
+		if (!event->terms)
+			continue;
+		ret = perf_pmu__parse_terms_to_attr(pmu, event->terms, &attr);
 
 		if (ret == 0 && config == attr.config)
 			return event->name;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 2587279fa0ce..42a0f5655b1c 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -160,17 +160,6 @@ struct perf_pmu {
 	 * @metrics_table: The metrics table for json metrics in pmu-events.c.
 	 */
 	const struct pmu_metrics_table *metrics_table;
-	/** @sysfs_aliases: Number of sysfs aliases loaded. */
-	uint32_t sysfs_aliases;
-	/** @cpu_json_aliases: Number of json event aliases loaded specific to the CPUID. */
-	uint32_t cpu_json_aliases;
-	/** @sys_json_aliases: Number of json event aliases loaded matching the PMU's identifier. */
-	uint32_t sys_json_aliases;
-	/**
-	 * @cpu_common_json_aliases: Number of json events that overlapped with sysfs when
-	 * loading all sysfs events.
-	 */
-	uint32_t cpu_common_json_aliases;
 	/** @sysfs_aliases_loaded: Are sysfs aliases loaded from disk? */
 	bool sysfs_aliases_loaded;
 	/**
-- 
2.56.1.703.gf848ed807c-goog

