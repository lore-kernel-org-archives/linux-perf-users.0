Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886701B86DB
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 00:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721262650; cv=none; b=f0Pymu1Rqv6YPsoHcqV2v+O/v4awVbN2GBjXqm34d8XzItcHOQCCP6YvlIK2L7iqn9AhlHzDGPuofgWBiu+4PMBX58XExcwgc/VLXBRqfAg2hG1C936QJ0fYAM3WiI1eeJIlE6xjGfMc1AToRNvLKgvhQbHiuMizR+n3rBJC1KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721262650; c=relaxed/simple;
	bh=80YyIwk/8VkjU4yqstE1PlbqioOpSQzgF7vZUjQSVCE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=LCQpbqjEapOcGWXvMQIiTiL6SZgqdKFmc4Kg2tKSUdJ+hne08frSXtPz/n/+2YihTE25QH/THje+LD55pJPOn3WZfEs+eEMerR5g+fRUDOGTI42KuxFwCIa3AFwcDKemYr3ovY8okwr5ZAdmTEH0DrKIFOk6zpRjI57Uy7FL7Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XPGSTcs9; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XPGSTcs9"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e05e3938a37so560439276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Jul 2024 17:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721262647; x=1721867447; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gDSkmz2B6LUpQkGELdRI3zhIL2uXO0hylwMkxD4wWcI=;
        b=XPGSTcs9oEovpu+c75CYIvQFf+5TEJG2W6tRXaI+Q+LBja+qjrQFzf6fQKM7a/aI6k
         96QS5xevZdD24OcjipZ23N15Xi0ER8aBSnMIp9OZ3XU6b3JH3zDv6LLN9TNiLDa/kfjC
         F6VaelwvWa7AXexWXLWPjyIB/Ac7y+Ud3s1BWPpgScnxn/SMChEg4QKmwobCu/a4K2oH
         anWGmkjIVhRiXY75y2CD2wQsPTTbn5tYeFtzk62synIx7q2hAjBX6lOH1gpgZ6euETPm
         GiAZRFhPgLg7jtsiCEWJxFuMX2K8lQVD9sZjbXipWxx5z0+SSM8zVoCyfYe5C/dTIODA
         rhkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721262647; x=1721867447;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gDSkmz2B6LUpQkGELdRI3zhIL2uXO0hylwMkxD4wWcI=;
        b=nwvEvYu4sPzjjVZzVoJdbdjLtZoLZafHVDCrJdJgire/SjIBOw91gktduX/REsuHJB
         OWcCWH1MkrbJJqTFlv0ZDZc8wDi+SRA0IFMaMHirVOnrxCcte5PJYsE2bxXkMVfxSw4c
         FV5Qs3U8Nn72rqBdN1ycdAltEbupcRFmix1eBcU2vhZPYG3qYDgQkKIAIQCeEoGJ73jx
         ShS4dE8lj2meZKQBINGPB6exlF5p0XCnMLjtmnEOEd6r6gOabf9QeIneSsFaG9CMO1G2
         Vh+ElqApLXSj0+le4mqSpQS252RP6O6cZo8egqiPj8SbZvV4wBA0/DFogHgI+YCyte6m
         07jQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpoZjAxSM1ITzbkZ7LdO970c3E9fYc+MHnxuqJbBgDgC+ZIUElipxFu3KSa0I8oLfB/krSklLi610BY8vjEXDfR1rYCi1/bhHnpxsCmV85ZA==
X-Gm-Message-State: AOJu0Ywcw0BhJw3fr/HUs2ZdIyrr/bUnQZ4wTSV0A4fQY1P5VGhihrSv
	ZVwpPYsfKhPnpjzwXYov9sjqoJfQ5J40NI4ikZSnsbh7XXKYSN19C4j778OLbcqNE8phk3a6jxv
	0NBL6yw==
X-Google-Smtp-Source: AGHT+IH1DzVbGdCGf8iHYG86fAS44PcWG5nVWkwtb0soiT/pdpCH02hy1TkeYGYlcEMSjompVQrf1VmgRxIm
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a25:a2c4:0:b0:e03:39fb:5729 with SMTP id
 3f1490d57ef6-e05fedaf378mr1994276.10.1721262647487; Wed, 17 Jul 2024 17:30:47
 -0700 (PDT)
Date: Wed, 17 Jul 2024 17:30:22 -0700
In-Reply-To: <20240718003025.1486232-1-irogers@google.com>
Message-Id: <20240718003025.1486232-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240718003025.1486232-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v2 3/6] perf pmu: Add support for event.cpus files in sysfs
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, James Clark <james.clark@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, ananth.narayan@amd.com, gautham.shenoy@amd.com, 
	kprateek.nayak@amd.com, sandipan.das@amd.com
Content-Type: text/plain; charset="UTF-8"

If an event file exists in sysfs, check if a event.cpus file exists
and read a perf_cpu_map from it if it does. This allows particular
events to have a different set of CPUs compared to the PMU.

One scenario where this could be useful is when a PMU is set up with a
cpumask/events per SMT thread but some events record for all SMT
threads. Programming an event on each SMT thread will cause
unnecessary counters to be programmed and the aggregate value to be
too large.

Another scenario where this could be useful if when a PMU has
historically had a cpumask at the package level, but now newer per
die, core or CPU information is available.

Additional context for the motivation is in these patches and
conversation:
https://lore.kernel.org/lkml/20240711102436.4432-1-Dhananjay.Ugwekar@amd.com/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../sysfs-bus-event_source-devices-events     | 14 ++++++
 tools/perf/util/parse-events.c                | 45 ++++++++++---------
 tools/perf/util/pmu.c                         | 44 +++++++++++++++++-
 tools/perf/util/pmu.h                         |  1 +
 4 files changed, 82 insertions(+), 22 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
index e7efeab2ee83..d8e3a4dd3ba7 100644
--- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
@@ -70,6 +70,20 @@ Description:	Per-pmu performance monitoring events specific to the running syste
 		This is referred to as "event parameterization". Event
 		parameters have the format 'param=?'.
 
+What: /sys/bus/event_source/devices/<pmu>/events/<event>.cpus
+Date: 2024/07/17
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:	Perf event CPUs
+
+		A list of CPUs on which a the perf event should be
+		opened by default. This is an event specific variant
+		of /sys/bus/event_source/devices/<pmu>/cpumask.
+
+		Examples (each of these lines would be in a separate file):
+
+			0,2,4,6
+			0-7
+
 What: /sys/bus/event_source/devices/<pmu>/events/<event>.unit
 Date: 2014/02/24
 Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 43501eb56336..b181f83c9678 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1425,12 +1425,13 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 				bool auto_merge_stats)
 {
 	struct perf_event_attr attr;
-	struct perf_pmu_info info;
+	struct perf_pmu_info info = {};
 	struct evsel *evsel;
 	struct parse_events_error *err = parse_state->error;
 	LIST_HEAD(config_terms);
 	struct parse_events_terms parsed_terms;
 	bool alias_rewrote_terms = false;
+	int ret = 0;
 
 	if (verbose > 1) {
 		struct strbuf sb;
@@ -1465,8 +1466,7 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 
 	parse_events_terms__init(&parsed_terms);
 	if (const_parsed_terms) {
-		int ret = parse_events_terms__copy(const_parsed_terms, &parsed_terms);
-
+		ret = parse_events_terms__copy(const_parsed_terms, &parsed_terms);
 		if (ret)
 			return ret;
 	}
@@ -1474,15 +1474,15 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 
 	/* Configure attr/terms with a known PMU, this will set hardcoded terms. */
 	if (config_attr(&attr, &parsed_terms, parse_state->error, config_term_pmu)) {
-		parse_events_terms__exit(&parsed_terms);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out_err;
 	}
 
 	/* Look for event names in the terms and rewrite into format based terms. */
 	if (!parse_state->fake_pmu && perf_pmu__check_alias(pmu, &parsed_terms,
 							    &info, &alias_rewrote_terms, err)) {
-		parse_events_terms__exit(&parsed_terms);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out_err;
 	}
 
 	if (verbose > 1) {
@@ -1497,13 +1497,13 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 	/* Configure attr/terms again if an alias was expanded. */
 	if (alias_rewrote_terms &&
 	    config_attr(&attr, &parsed_terms, parse_state->error, config_term_pmu)) {
-		parse_events_terms__exit(&parsed_terms);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out_err;
 	}
 
 	if (get_config_terms(&parsed_terms, &config_terms)) {
-		parse_events_terms__exit(&parsed_terms);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out_err;
 	}
 
 	/*
@@ -1512,24 +1512,23 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 	 */
 	if (pmu->perf_event_attr_init_default &&
 	    get_config_chgs(pmu, &parsed_terms, &config_terms)) {
-		parse_events_terms__exit(&parsed_terms);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out_err;
 	}
 
 	if (!parse_state->fake_pmu &&
 	    perf_pmu__config(pmu, &attr, &parsed_terms, parse_state->error)) {
-		free_config_terms(&config_terms);
-		parse_events_terms__exit(&parsed_terms);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out_err;
 	}
 
 	evsel = __add_event(list, &parse_state->idx, &attr, /*init_attr=*/true,
 			    get_config_name(&parsed_terms),
 			    get_config_metric_id(&parsed_terms), pmu,
-			    &config_terms, auto_merge_stats, /*cpu_list=*/NULL);
+			    &config_terms, auto_merge_stats, info.cpus);
 	if (!evsel) {
-		parse_events_terms__exit(&parsed_terms);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out_err;
 	}
 
 	if (evsel->name)
@@ -1542,13 +1541,17 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 		return 0;
 	}
 
-	parse_events_terms__exit(&parsed_terms);
 	free((char *)evsel->unit);
 	evsel->unit = strdup(info.unit);
 	evsel->scale = info.scale;
 	evsel->per_pkg = info.per_pkg;
 	evsel->snapshot = info.snapshot;
-	return 0;
+out_err:
+	parse_events_terms__exit(&parsed_terms);
+	if (ret)
+		free_config_terms(&config_terms);
+	perf_cpu_map__put(info.cpus);
+	return ret;
 }
 
 int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 5148b6639dd3..280b2499c861 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -73,6 +73,11 @@ struct perf_pmu_alias {
 	 * differ from the PMU name as it won't have suffixes.
 	 */
 	char *pmu_name;
+	/**
+	 * @cpus: A possible per-event cpumap that overrides that given for the
+	 * PMU.
+	 */
+	struct perf_cpu_map *cpus;
 	/** @unit: Units for the event, such as bytes or cache lines. */
 	char unit[UNIT_MAX_LEN+1];
 	/** @scale: Value to scale read counter values by. */
@@ -332,6 +337,32 @@ static int perf_pmu__parse_scale(struct perf_pmu *pmu, struct perf_pmu_alias *al
 	return ret;
 }
 
+static void perf_pmu__parse_cpus(struct perf_pmu *pmu, struct perf_pmu_alias *alias)
+{
+	char path[PATH_MAX];
+	size_t len;
+	FILE *file;
+	int fd;
+
+	len = perf_pmu__event_source_devices_scnprintf(path, sizeof(path));
+	if (!len)
+		return;
+	scnprintf(path + len, sizeof(path) - len, "%s/events/%s.cpus", pmu->name, alias->name);
+
+	fd = open(path, O_RDONLY);
+	if (fd == -1)
+		return; /* Expected common case. */
+
+	file = fdopen(fd, "r");
+	if (!file) {
+		close(fd);
+		return;
+	}
+
+	alias->cpus = perf_cpu_map__read(file);
+	fclose(file);
+}
+
 static int perf_pmu__parse_unit(struct perf_pmu *pmu, struct perf_pmu_alias *alias)
 {
 	char path[PATH_MAX];
@@ -493,6 +524,7 @@ static void read_alias_info(struct perf_pmu *pmu, struct perf_pmu_alias *alias)
 	/*
 	 * load unit name and scale if available
 	 */
+	perf_pmu__parse_cpus(pmu, alias);
 	perf_pmu__parse_unit(pmu, alias);
 	perf_pmu__parse_scale(pmu, alias);
 	perf_pmu__parse_per_pkg(pmu, alias);
@@ -618,7 +650,7 @@ static inline bool pmu_alias_info_file(const char *name)
 	size_t len;
 
 	len = strlen(name);
-	if (len > 5 && !strcmp(name + len - 5, ".unit"))
+	if (len > 5 && (!strcmp(name + len - 5, ".cpus") || !strcmp(name + len - 5, ".unit")))
 		return true;
 	if (len > 6 && !strcmp(name + len - 6, ".scale"))
 		return true;
@@ -1560,6 +1592,12 @@ static int check_info_data(struct perf_pmu *pmu,
 	 * define unit, scale and snapshot, fail
 	 * if there's more than one.
 	 */
+	if (!perf_cpu_map__is_empty(info->cpus) && !perf_cpu_map__is_empty(alias->cpus)) {
+		parse_events_error__handle(err, column,
+					strdup("Attempt to set event's cpus twice"),
+					NULL);
+		return -EINVAL;
+	}
 	if (info->unit && alias->unit[0]) {
 		parse_events_error__handle(err, column,
 					strdup("Attempt to set event's unit twice"),
@@ -1579,6 +1617,9 @@ static int check_info_data(struct perf_pmu *pmu,
 		return -EINVAL;
 	}
 
+	if (!perf_cpu_map__is_empty(alias->cpus))
+		info->cpus = perf_cpu_map__get(alias->cpus);
+
 	if (alias->unit[0])
 		info->unit = alias->unit;
 
@@ -1610,6 +1651,7 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct parse_events_terms *head_
 	 * Mark unit and scale as not set
 	 * (different from default values, see below)
 	 */
+	info->cpus     = NULL;
 	info->unit     = NULL;
 	info->scale    = 0.0;
 	info->snapshot = false;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index b2d3fd291f02..b1ccfe8d3df4 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -177,6 +177,7 @@ struct perf_pmu {
 extern struct perf_pmu perf_pmu__fake;
 
 struct perf_pmu_info {
+	struct perf_cpu_map *cpus;
 	const char *unit;
 	double scale;
 	bool per_pkg;
-- 
2.45.2.1089.g2a221341d9-goog

