Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AED415E5D2
	for <linux-perf-users@vger.kernel.org>; Fri, 10 May 2024 05:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715319491; cv=none; b=tJZan7rTgIWsfIhGQtJhFnDsQFJIeu214AvLfu6T/n47g83X06inz2sGf5Hf41FFt/ufr0KkRj2hshOPL56sQzfGEMb3uIk0V8gnales7z1FUzZLN6Jy3shRiYkV+sovUmAaeVq1tQOWszgU9D89pNiqLmu//G/VEEpVarLOrPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715319491; c=relaxed/simple;
	bh=zNU/+vvLwssObyq665v420J21ONwE2lm3SPbdGLqo8o=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=BWhpY0IUwRTV1/gg0cSwWMsDT9Ove+0YCybBrcj6O6j3lyxZ/gm5uiT9WuckfQxaGTM/F1hY3tKbZGO7ETdg5+tc0S0rzu8G3NI/IJ0oIzc5bTyeeCpH5P6c/YhNL4zuxhqANTzen7USy8+m54SVxzTFHWdwe9D/b1NENPaBh0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E9Ay2NYv; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E9Ay2NYv"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be8f9ca09so28523067b3.2
        for <linux-perf-users@vger.kernel.org>; Thu, 09 May 2024 22:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715319489; x=1715924289; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U81cdFZOryTWzARq4P9O2qKcBTbob0BFWgpG3EYHhxM=;
        b=E9Ay2NYvkOyVjbvspBHGn2SUF5FAS5vWERXYyVUdbqm86SmN90aurIgG9tsiWqNGdT
         aKPQJQeEONSvpOTKNswD8nJgAXIEoyazcu7mJVk1HmVlnlz6pCdnbXtyDJDPib3akSwT
         mBfBFrGu3fWlSyNiMP58SosJ2KDMkNMHjqDriupJEt7IcIGM/kvJ40Q1Hy6OP2XJQ/Pk
         plxRkB0TFj/zzLaLYHxUlTaeILCBIpa9KsUZMydMSprsPl9rmyIKB1sqc1ngM4lr/KGX
         jGcJ3g5ffs1D1dZCqs4gLZRHAkJWWUGlqpBABK+eU1kYrD9W6qrfGV2ADgRz3Uey8xEy
         +S4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715319489; x=1715924289;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U81cdFZOryTWzARq4P9O2qKcBTbob0BFWgpG3EYHhxM=;
        b=uQdchATWrO82fIPAzRGGGf3ixAAzDkCQyhIWd2TNXG9Zz5Xxz6ds9PuTRUoOyuMuFa
         DMd5K7HEOJnFxqgNs2RQFiZ2eVtg+MP8KcyPlo/OzAJjorMJOpgSFROG0UfouIP93bXv
         BkbbnB2WoK9FVaQ/QMG/DfBTj+TUHlBO2FyKoN4Q9yzAMkHYaNZutpH3gLwYcErTO4va
         ZIhvnifJveJPAsFnDQYSjYVxEcAL1q9emzqQicmkcl+mY6oiuZhFDHwtZj9s1h9YlUAh
         /klKye52kKQNPzN+uXR28oLnmJICOURZ5E/pcrqqCAXQZmUJDOjrRKZ3KyOdQKwntfY9
         MP/Q==
X-Forwarded-Encrypted: i=1; AJvYcCX40oM0Mv5sVyzXJRrdGRnjGGq7M2ZUKzpzuDE6jT8/8HkxpJuEnVVGjCm5csoZbdWz19O1y78kSf96Q5qHdeAv2QQx64hHIPUtP1vOZjtUpg==
X-Gm-Message-State: AOJu0Yzf+kek3MGHyvMntyqEBZdfiL+uOnjuGWOQliTcsGKQmpFOKEET
	YOmKlpBrcrwPtfLiGwQQSl7H/11qi7xB1Z3ABPOwpkfs2LRWeX+CqP8Ik5RPVYaMWcrBQPmsZmA
	f/1+p6w==
X-Google-Smtp-Source: AGHT+IFRjnvnZQt14aMD9YvF6AMr7sQg6gNtp9//xebqaPSpiEn6kA1W44VXfwdCT4L4dEfFyxzpxvgkU6NV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:79ed:c375:51e3:ed39])
 (user=irogers job=sendgmr) by 2002:a05:690c:284:b0:614:f416:9415 with SMTP id
 00721157ae682-622b0163084mr4450367b3.7.1715319488741; Thu, 09 May 2024
 22:38:08 -0700 (PDT)
Date: Thu,  9 May 2024 22:37:02 -0700
In-Reply-To: <20240510053705.2462258-1-irogers@google.com>
Message-Id: <20240510053705.2462258-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510053705.2462258-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Subject: [PATCH v3 2/5] perf stat: Uniquify event name improvements
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	James Clark <james.clark@arm.com>, Yang Jihong <yangjihong@bytedance.com>, 
	Ze Gao <zegao2021@gmail.com>, Leo Yan <leo.yan@linux.dev>, Song Liu <song@kernel.org>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Kaige Ye <ye@kaige.org>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Without aggregation on Intel:
```
$ perf stat -e instructions,cycles ...
```
Will use "cycles" for the name of the legacy cycles event but as
"instructions" has a sysfs name it will and a "[cpu]" PMU suffix. This
often breaks things as the space between the event and the PMU name
look like an extra column. The existing uniquify logic was also
uniquifying in cases when all events are core and not with uncore
events, it was not correctly handling modifiers, etc.

Change the logic so that an initial pass that can disable
uniquification is run. For individual counters, disable uniquification
in more cases such as for consistency with legacy events or for
libpfm4 events. Don't use the "[pmu]" style suffix in uniquification,
always use "pmu/.../". Change how modifiers/terms are handled in the
uniquification so that they look like parse-able events.

This fixes "102: perf stat metrics (shadow stat) test:" that has been
failing due to "instructions [cpu]" breaking its column/awk logic when
values aren't aggregated. This started happening when instructions
could match a sysfs rather than a legacy event, so the fixes tag
reflects this.

Fixes: 617824a7f0f7 ("perf parse-events: Prefer sysfs/JSON hardware events over legacy")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 101 +++++++++++++++++++++++++--------
 1 file changed, 78 insertions(+), 23 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index bfc1d705f437..ea11e3437444 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -868,38 +868,66 @@ static void printout(struct perf_stat_config *config, struct outstate *os,
 
 static void uniquify_event_name(struct evsel *counter)
 {
-	char *new_name;
-	char *config;
-	int ret = 0;
+	const char *name, *pmu_name;
+	char *new_name, *config;
+	int ret;
 
-	if (counter->uniquified_name || counter->use_config_name ||
-	    !counter->pmu_name || !strncmp(evsel__name(counter), counter->pmu_name,
-					   strlen(counter->pmu_name)))
+	/* The evsel was already uniquified. */
+	if (counter->uniquified_name)
 		return;
 
-	config = strchr(counter->name, '/');
+	/* Avoid checking to uniquify twice. */
+	counter->uniquified_name = true;
+
+	/* The evsel has a "name=" config term or is from libpfm. */
+	if (counter->use_config_name || counter->is_libpfm_event)
+		return;
+
+	/* Legacy no PMU event, don't uniquify. */
+	if  (!counter->pmu ||
+	     (counter->pmu->type < PERF_TYPE_MAX && counter->pmu->type != PERF_TYPE_RAW))
+		return;
+
+	/* A sysfs or json event replacing a legacy event, don't uniquify. */
+	if (counter->pmu->is_core && counter->alternate_hw_config != PERF_COUNT_HW_MAX)
+		return;
+
+	name = evsel__name(counter);
+	pmu_name = counter->pmu->name;
+	/* Already prefixed by the PMU name. */
+	if (!strncmp(name, pmu_name, strlen(pmu_name)))
+		return;
+
+	config = strchr(name, '/');
 	if (config) {
-		if (asprintf(&new_name,
-			     "%s%s", counter->pmu_name, config) > 0) {
-			free(counter->name);
-			counter->name = new_name;
-		}
-	} else {
-		if (evsel__is_hybrid(counter)) {
-			ret = asprintf(&new_name, "%s/%s/",
-				       counter->pmu_name, counter->name);
+		int len = config - name;
+
+		if (config[1] == '/') {
+			/* case: event// */
+			ret = asprintf(&new_name, "%s/%.*s/%s", pmu_name, len, name, config + 2);
 		} else {
-			ret = asprintf(&new_name, "%s [%s]",
-				       counter->name, counter->pmu_name);
+			/* case: event/.../ */
+			ret = asprintf(&new_name, "%s/%.*s,%s", pmu_name, len, name, config + 1);
 		}
+	} else {
+		config = strchr(name, ':');
+		if (config) {
+			/* case: event:.. */
+			int len = config - name;
 
-		if (ret) {
-			free(counter->name);
-			counter->name = new_name;
+			ret = asprintf(&new_name, "%s/%.*s/%s", pmu_name, len, name, config + 1);
+		} else {
+			/* case: event */
+			ret = asprintf(&new_name, "%s/%s/", pmu_name, name);
 		}
 	}
-
-	counter->uniquified_name = true;
+	if (ret > 0) {
+		free(counter->name);
+		counter->name = new_name;
+	} else {
+		/* ENOMEM from asprintf. */
+		counter->uniquified_name = false;
+	}
 }
 
 static bool hybrid_uniquify(struct evsel *evsel, struct perf_stat_config *config)
@@ -1541,6 +1569,31 @@ static void print_cgroup_counter(struct perf_stat_config *config, struct evlist
 		print_metric_end(config, os);
 }
 
+static void disable_uniquify(struct evlist *evlist)
+{
+	struct evsel *counter;
+	struct perf_pmu *last_pmu = NULL;
+	bool first = true;
+
+	evlist__for_each_entry(evlist, counter) {
+		/* If PMUs vary then uniquify can be useful. */
+		if (!first && counter->pmu != last_pmu)
+			return;
+		first = false;
+		if (counter->pmu) {
+			/* Allow uniquify for uncore PMUs. */
+			if (!counter->pmu->is_core)
+				return;
+			/* Keep hybrid event names uniquified for clarity. */
+			if (perf_pmus__num_core_pmus() > 1)
+				return;
+		}
+	}
+	evlist__for_each_entry_continue(evlist, counter) {
+		counter->uniquified_name = true;
+	}
+}
+
 void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *config,
 			    struct target *_target, struct timespec *ts,
 			    int argc, const char **argv)
@@ -1554,6 +1607,8 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
 		.first = true,
 	};
 
+	disable_uniquify(evlist);
+
 	if (config->iostat_run)
 		evlist->selected = evlist__first(evlist);
 
-- 
2.45.0.118.g7fe29c98d7-goog

