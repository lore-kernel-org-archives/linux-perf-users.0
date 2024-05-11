Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A06B7F6
	for <linux-perf-users@vger.kernel.org>; Sat, 11 May 2024 00:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715387776; cv=none; b=MXJzZa81C4O2n0M1IUmg49GBYWpSe/dtH9eY1bIRyBRYRlvAR/P0IjjEtLhZjaTyuSH5q3Dvfalwrnn6LRDyZDinlNfBDLf0cJ9K2ZhTPe61CvOb7duTkaYvm2d4UAXo5+8/y5ZLkouRvpxbqil4GCgRFutGa4hS6NvffCk8P+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715387776; c=relaxed/simple;
	bh=jPulCMae9SCrPdsTA41izc3f8UO4kFtkVT4jNnB2tJ0=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=C/S4vpuBWhUqBYg4AfUaLfSn+/2G3gNpGnSuWvwTCJrBJNVTJdwQDX6dJvNGpIyRtxX2TWIvf5/H5pDbNg5tdCkEKXWTzrIs7aJzG3XFpsyEY9PIJS0koOcnECi3nC+2i6/o2541jUNRFHRx82SyYmWHmutvImRQzePa4ysn8Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CndgaZ7A; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CndgaZ7A"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbf216080f5so4339905276.1
        for <linux-perf-users@vger.kernel.org>; Fri, 10 May 2024 17:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715387774; x=1715992574; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0MNib63AMsNXJf0LXOww7d6a7tjn4YDbXl6LrsheYYI=;
        b=CndgaZ7AQ88IdG9ctFefowx9IvOWU+y83OLZVsi3VoVr1JxDriKrSQRsDzgooxEl2j
         lNpTtjtoJd9OXBg4eJg8Boy6MnSfk53sqlEsHOS1SG/ElrIiA7UFBxOeN/WhP6+2tEJn
         OaUJjdmIDTh+qkkHdUbZQj00T2z7EqO4pmYkK1D8VQXRlvbKS+3+7k7ZYPApt29CCe6x
         BVePrCBWiFP7EUN65dl/DhxFzOFUck28R6TFWlsrdsY0lUByX+u4UI/Y4xXd3LMRwEtL
         AqNGc0/radUSlcoorfkwvRye/2LT9xHPF6yuMlRuU2ip2nJHqrBWlNx8DNXB5QEKO+mz
         C5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715387774; x=1715992574;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0MNib63AMsNXJf0LXOww7d6a7tjn4YDbXl6LrsheYYI=;
        b=ulwrRgHMMnQZVEpBBgKBIg0dI/9cRMgl5s69MoP4BMOx2ObNZbBRkapmTycVVTAhG2
         O1XNFSIucAFJS4VJQfzrO9C6vtUIZhm/kgLpVpSzeAPVSRd588seKvPSstnGZsRdtNrL
         EQXh2DLhOrf7bf7TYXn31HjBiOE2jfFVcf2fzLpdfQHPpf3xE2zcgat6uwhk5qPAt2oU
         03LOop5HaukCyzeyy4BwMcdiGTKG8ly84UNHWtd2lK4O/cxm4tOkZRzEQkZiPRV/QV8S
         SSEUz/Q9+sF5DdcqR36PkmwH1x8y24eKBrQsET4MI8K+yrz477wq2FdTxr1O4u2i+QO7
         jqKw==
X-Forwarded-Encrypted: i=1; AJvYcCWw91/ujry+2B97d+IWCsnCWH8ePheZNZ7rbCYEAlClV1/ppVMbpbaE5kvFJ4dIx6/S9hymb7TmzgfAk2r8YOpJU164kRfq2bUuYKsPtyhaNA==
X-Gm-Message-State: AOJu0Yw/HIk2Ba1U3Dqix/YHcp8NsuTPVoFsQoszYjRg7qDi37q1Q5+J
	G5G9KpRps/MLR3RCc+kKve5B55Zf8T2XHxXjc2USOgz2+PCGh1tguP1Q1Lnw9pbpGK7WhK/HZcN
	kdHT3mw==
X-Google-Smtp-Source: AGHT+IFRbkoPxRq0h2QRrKQoPRlb4mlkwVOd0SFEvJm/9Y0Bdm49gtd5DvNiA0aJ+7ryyw6AOYbDgdcLEPZt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:351a:2e3e:f5b0:df31])
 (user=irogers job=sendgmr) by 2002:a25:d80e:0:b0:dc2:466a:23c4 with SMTP id
 3f1490d57ef6-dee4f362fe5mr1026945276.4.1715387774159; Fri, 10 May 2024
 17:36:14 -0700 (PDT)
Date: Fri, 10 May 2024 17:36:01 -0700
Message-Id: <20240511003601.2666907-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Subject: [PATCH v1] perf pmu: Count sys and cpuid json events separately
From: Ian Rogers <irogers@google.com>
To: Jia He <justin.he@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	John Garry <john.g.garry@oracle.com>
Content-Type: text/plain; charset="UTF-8"

Sys events are eagerly loaded as each event has a compat option that
may mean the event is or isn't associated with the PMU. These
shouldn't be counted as loaded_json_events as that is used for json
events matching the CPUID that may or may not have been loaded. The
mismatch causes issues on ARM64 that uses sys events.

Reported-by: Jia He <justin.he@arm.com>
Closes: https://lore.kernel.org/lkml/20240510024729.1075732-1-justin.he@arm.com/
Fixes: e6ff1eed3584 ("perf pmu: Lazily add JSON events")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 70 ++++++++++++++++++++++++++++++-------------
 tools/perf/util/pmu.h |  6 ++--
 2 files changed, 53 insertions(+), 23 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index b3b072feef02..888ce9912275 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -36,6 +36,18 @@ struct perf_pmu perf_pmu__fake = {
 
 #define UNIT_MAX_LEN	31 /* max length for event unit name */
 
+enum event_source {
+	/* An event loaded from /sys/devices/<pmu>/events. */
+	EVENT_SRC_SYSFS,
+	/* An event loaded from a CPUID matched json file. */
+	EVENT_SRC_CPU_JSON,
+	/*
+	 * An event loaded from a /sys/devices/<pmu>/identifier matched json
+	 * file.
+	 */
+	EVENT_SRC_SYS_JSON,
+};
+
 /**
  * struct perf_pmu_alias - An event either read from sysfs or builtin in
  * pmu-events.c, created by parsing the pmu-events json files.
@@ -521,7 +533,7 @@ static int update_alias(const struct pmu_event *pe,
 
 static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 				const char *desc, const char *val, FILE *val_fd,
-				const struct pmu_event *pe)
+			        const struct pmu_event *pe, enum event_source src)
 {
 	struct perf_pmu_alias *alias;
 	int ret;
@@ -574,25 +586,30 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 		}
 		snprintf(alias->unit, sizeof(alias->unit), "%s", unit);
 	}
-	if (!pe) {
-		/* Update an event from sysfs with json data. */
-		struct update_alias_data data = {
-			.pmu = pmu,
-			.alias = alias,
-		};
-
+	switch (src) {
+	default:
+	case EVENT_SRC_SYSFS:
 		alias->from_sysfs = true;
 		if (pmu->events_table) {
+			/* Update an event from sysfs with json data. */
+			struct update_alias_data data = {
+				.pmu = pmu,
+				.alias = alias,
+			};
 			if (pmu_events_table__find_event(pmu->events_table, pmu, name,
 							 update_alias, &data) == 0)
-				pmu->loaded_json_aliases++;
+				pmu->cpu_json_aliases++;
 		}
-	}
-
-	if (!pe)
 		pmu->sysfs_aliases++;
-	else
-		pmu->loaded_json_aliases++;
+		break;
+	case  EVENT_SRC_CPU_JSON:
+		pmu->cpu_json_aliases++;
+		break;
+	case  EVENT_SRC_SYS_JSON:
+		pmu->sys_json_aliases++;
+		break;
+
+	}
 	list_add_tail(&alias->list, &pmu->aliases);
 	return 0;
 }
@@ -653,7 +670,8 @@ static int __pmu_aliases_parse(struct perf_pmu *pmu, int events_dir_fd)
 		}
 
 		if (perf_pmu__new_alias(pmu, name, /*desc=*/ NULL,
-					/*val=*/ NULL, file, /*pe=*/ NULL) < 0)
+					/*val=*/ NULL, file, /*pe=*/ NULL,
+					EVENT_SRC_SYSFS) < 0)
 			pr_debug("Cannot set up %s\n", name);
 		fclose(file);
 	}
@@ -946,7 +964,8 @@ static int pmu_add_cpu_aliases_map_callback(const struct pmu_event *pe,
 {
 	struct perf_pmu *pmu = vdata;
 
-	perf_pmu__new_alias(pmu, pe->name, pe->desc, pe->event, /*val_fd=*/ NULL, pe);
+	perf_pmu__new_alias(pmu, pe->name, pe->desc, pe->event, /*val_fd=*/ NULL,
+			    pe, EVENT_SRC_CPU_JSON);
 	return 0;
 }
 
@@ -981,13 +1000,14 @@ static int pmu_add_sys_aliases_iter_fn(const struct pmu_event *pe,
 		return 0;
 
 	if (pmu_uncore_alias_match(pe->pmu, pmu->name) &&
-			pmu_uncore_identifier_match(pe->compat, pmu->id)) {
+	    pmu_uncore_identifier_match(pe->compat, pmu->id)) {
 		perf_pmu__new_alias(pmu,
 				pe->name,
 				pe->desc,
 				pe->event,
 				/*val_fd=*/ NULL,
-				pe);
+				pe,
+				EVENT_SRC_SYS_JSON);
 	}
 
 	return 0;
@@ -1082,6 +1102,12 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 	pmu->max_precise = pmu_max_precise(dirfd, pmu);
 	pmu->alias_name = pmu_find_alias_name(pmu, dirfd);
 	pmu->events_table = perf_pmu__find_events_table(pmu);
+	/*
+	 * Load the sys json events/aliases when loading the PMU as each event
+	 * may have a different compat regular expression. We therefore can't
+	 * know the number of sys json events/aliases without computing the
+	 * regular expressions for them all.
+	 */
 	pmu_add_sys_aliases(pmu);
 	list_add_tail(&pmu->list, pmus);
 
@@ -1739,12 +1765,14 @@ size_t perf_pmu__num_events(struct perf_pmu *pmu)
 	size_t nr;
 
 	pmu_aliases_parse(pmu);
-	nr = pmu->sysfs_aliases;
+	nr = pmu->sysfs_aliases + pmu->sys_json_aliases;;
 
 	if (pmu->cpu_aliases_added)
-		 nr += pmu->loaded_json_aliases;
+		 nr += pmu->cpu_json_aliases;
 	else if (pmu->events_table)
-		nr += pmu_events_table__num_events(pmu->events_table, pmu) - pmu->loaded_json_aliases;
+		nr += pmu_events_table__num_events(pmu->events_table, pmu) - pmu->cpu_json_aliases;
+	else
+		assert(pmu->cpu_json_aliases == 0);
 
 	return pmu->selectable ? nr + 1 : nr;
 }
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 561716aa2b25..b2d3fd291f02 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -123,8 +123,10 @@ struct perf_pmu {
 	const struct pmu_events_table *events_table;
 	/** @sysfs_aliases: Number of sysfs aliases loaded. */
 	uint32_t sysfs_aliases;
-	/** @sysfs_aliases: Number of json event aliases loaded. */
-	uint32_t loaded_json_aliases;
+	/** @cpu_json_aliases: Number of json event aliases loaded specific to the CPUID. */
+	uint32_t cpu_json_aliases;
+	/** @sys_json_aliases: Number of json event aliases loaded matching the PMU's identifier. */
+	uint32_t sys_json_aliases;
 	/** @sysfs_aliases_loaded: Are sysfs aliases loaded from disk? */
 	bool sysfs_aliases_loaded;
 	/**
-- 
2.45.0.118.g7fe29c98d7-goog

