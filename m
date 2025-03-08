Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9626D3C38
	for <linux-perf-users@vger.kernel.org>; Sat,  8 Mar 2025 01:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741397340; cv=none; b=BG6QQleyU8yTBWH22APMz6Mdf1DVxk9nkYei7w3qcdPRGUwLiBeX47BmDudoxOVGfAi/IDKiuaHKzxI3wfOYaIcQi5f7AHG++/JrWZPdzFpfUm0JaslazROb/s4q5HzO8SYJVIIOC/T+K39PkZG0xx8He7MdJHgca0AHBQerDOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741397340; c=relaxed/simple;
	bh=mjB7SHjMyD3+60oYpIH6M9GjPdL1jvipRXeQly6Vugs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=s9NNlOP0rrPMPcFLeLTsXgnglZCwNW8lgJkqBobUAJ6+PrucXUcTqAwKvZq2c/uDI/NA8gtFCUmzYtD+j88S6vZ8rtUctLALcRXeO6UOX8d/imdU+Zg6QORY+RS/wZjxAfpwhakMQbCTIrTP+SxkjXOsgoxqtaRCnWz0hrLi2J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lE3zDUUb; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lE3zDUUb"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-225107fbdc7so4856905ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Mar 2025 17:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741397338; x=1742002138; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Pyj6AZWfv+qMjw7lV9Ur69GdqhGZug8FYcSTlsx6gAs=;
        b=lE3zDUUbVBgUTY4zRrokDWDcXjgAFAkIySLZgSV/8vdR6B47G56pUFOss9E43FxQAL
         /fRYNqjAC+eiaTQrymwcxCfS0DNnYDPuFFqSYd3Wcw/1XbdjyNb+2aLc+55eK42BeEkg
         NEog0xMzp7GIjtx45wNvHG+PsorPoFyQKGg70SYKq/ymN3KTMxSopIxwlj5ZWal93xeR
         UQIUXoXiJ0SXWQy4LDzEkmLvScIuN4+GM2jO/Lunza+jTSifbdmukm4h3ANr33MnajQ8
         LTmRJEqzus+hN86K/gekqrXJENbrKgx4Tcl5SNhELIYHk/BXCnikTm23o4cgN549g8n2
         0now==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741397338; x=1742002138;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pyj6AZWfv+qMjw7lV9Ur69GdqhGZug8FYcSTlsx6gAs=;
        b=Tn6oOqnID77aoG1PbCAjyheWKG3zZmLqqiXorqd1NgdhKWSjgnOaADG5LdV128mixE
         Su/BLVbgkc2qta7kif32vWZbqnlzOTGfMYWxMo8HNpazYPwCQ7e4U3LZeXXVzVFugFqT
         T2+T3Rhn0LBiu0/g9iCOqlsSlze1qXD26PWKHIJJeZ7G8qWz3VZ0nTvN92Wrnk2tIpTr
         v9n0xMfnIZKp/o+IfxKV+bFDRlXM0OpMf2Bk0RQVt+qyEaFIsrx4GtBrrwioReim0BpK
         jKahzxgQM/z3wHMFxctuxsbPC9tlGiinpS7TtEe/zNRYgqbz3GD2Z1qZyIv82fAJoBNA
         5XtA==
X-Forwarded-Encrypted: i=1; AJvYcCXHlajGiC+nadAiHEOrxHVTsa7yL2pSbBmE7AgZRGwkfEXgymL0+6L03ERBh4BJN0+MgkywEZCSLUJAqXmQHJ/2@vger.kernel.org
X-Gm-Message-State: AOJu0YwAHODYYIJ8VNI20oIBvnJrEMBU6zUYqEJQEqWMLpE6tySBJEzb
	/62CLcX44NESko/TBC699V5e9u2aC0i7AAqR/iRjyh4n8OkbfIXZKkWqSWYxuY/kCqeh+6BaIVP
	+lbFJ3g==
X-Google-Smtp-Source: AGHT+IED5QlnRA25ko42jmssPzmz+EG+3wQ5kfZuvC1JYesVp3sRrXdQE0TkZQTO7SQP7TEsytBQsJOVhHvM
X-Received: from pjk14.prod.google.com ([2002:a17:90b:558e:b0:2fc:2c9c:880])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ec91:b0:223:5e54:c521
 with SMTP id d9443c01a7336-22428407e93mr86368975ad.0.1741397337884; Fri, 07
 Mar 2025 17:28:57 -0800 (PST)
Date: Fri,  7 Mar 2025 17:28:53 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250308012853.1384762-1-irogers@google.com>
Subject: [PATCH v2] perf mem: Don't leak mem event names
From: Ian Rogers <irogers@google.com>
To: Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

When preparing the mem events for the argv copies are intentionally
made. These copies are leaked and cause runs of perf using address
sanitizer to fail. Rather than leak the memory allocate a chunk of
memory for the mem event names upfront and build the strings in this -
the storage is sized larger than the previous buffer size. The caller
is then responsible for clearing up this memory. As part of this
change, remove the mem_loads_name and mem_stores_name global buffers
then change the perf_pmu__mem_events_name to write to an out argument
buffer.

Tested-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
v2. Add return -ENOMEM suggested by Kan Liang.
---
 tools/perf/builtin-c2c.c     |  4 ++-
 tools/perf/builtin-mem.c     | 12 ++++---
 tools/perf/util/mem-events.c | 67 +++++++++++++++++++++---------------
 tools/perf/util/mem-events.h |  3 +-
 4 files changed, 53 insertions(+), 33 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 15e1fce71c72..5d5bb0f32334 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -3239,6 +3239,7 @@ static int perf_c2c__record(int argc, const char **argv)
 {
 	int rec_argc, i = 0, j;
 	const char **rec_argv;
+	char *event_name_storage = NULL;
 	int ret;
 	bool all_user = false, all_kernel = false;
 	bool event_set = false;
@@ -3300,7 +3301,7 @@ static int perf_c2c__record(int argc, const char **argv)
 	rec_argv[i++] = "--phys-data";
 	rec_argv[i++] = "--sample-cpu";
 
-	ret = perf_mem_events__record_args(rec_argv, &i);
+	ret = perf_mem_events__record_args(rec_argv, &i, &event_name_storage);
 	if (ret)
 		goto out;
 
@@ -3327,6 +3328,7 @@ static int perf_c2c__record(int argc, const char **argv)
 
 	ret = cmd_record(i, rec_argv);
 out:
+	free(event_name_storage);
 	free(rec_argv);
 	return ret;
 }
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 99d5e1491a28..5ec83cd85650 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -74,6 +74,7 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem,
 	int rec_argc, i = 0, j;
 	int start, end;
 	const char **rec_argv;
+	char *event_name_storage = NULL;
 	int ret;
 	struct perf_mem_event *e;
 	struct perf_pmu *pmu;
@@ -140,7 +141,7 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem,
 		rec_argv[i++] = "--data-page-size";
 
 	start = i;
-	ret = perf_mem_events__record_args(rec_argv, &i);
+	ret = perf_mem_events__record_args(rec_argv, &i, &event_name_storage);
 	if (ret)
 		goto out;
 	end = i;
@@ -170,6 +171,7 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem,
 
 	ret = cmd_record(i, rec_argv);
 out:
+	free(event_name_storage);
 	free(rec_argv);
 	return ret;
 }
@@ -521,6 +523,7 @@ int cmd_mem(int argc, const char **argv)
 		NULL,
 		NULL
 	};
+	int ret;
 
 	argc = parse_options_subcommand(argc, argv, mem_options, mem_subcommands,
 					mem_usage, PARSE_OPT_STOP_AT_NON_OPTION);
@@ -536,14 +539,15 @@ int cmd_mem(int argc, const char **argv)
 	}
 
 	if (strlen(argv[0]) > 2 && strstarts("record", argv[0]))
-		return __cmd_record(argc, argv, &mem, record_options);
+		ret = __cmd_record(argc, argv, &mem, record_options);
 	else if (strlen(argv[0]) > 2 && strstarts("report", argv[0]))
-		return __cmd_report(argc, argv, &mem, report_options);
+		ret = __cmd_report(argc, argv, &mem, report_options);
 	else
 		usage_with_options(mem_usage, mem_options);
 
 	/* free usage string allocated by parse_options_subcommand */
 	free((void *)mem_usage[0]);
+	free(sort_order_help);
 
-	return 0;
+	return ret;
 }
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 0277d3e1505c..9011784b950d 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -31,9 +31,6 @@ struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
 
 bool perf_mem_record[PERF_MEM_EVENTS__MAX] = { 0 };
 
-static char mem_loads_name[100];
-static char mem_stores_name[100];
-
 struct perf_mem_event *perf_pmu__mem_events_ptr(struct perf_pmu *pmu, int i)
 {
 	if (i >= PERF_MEM_EVENTS__MAX || !pmu)
@@ -81,7 +78,8 @@ int perf_pmu__mem_events_num_mem_pmus(struct perf_pmu *pmu)
 	return num;
 }
 
-static const char *perf_pmu__mem_events_name(int i, struct perf_pmu *pmu)
+static const char *perf_pmu__mem_events_name(struct perf_pmu *pmu, int i,
+					     char *buf, size_t buf_size)
 {
 	struct perf_mem_event *e;
 
@@ -96,31 +94,31 @@ static const char *perf_pmu__mem_events_name(int i, struct perf_pmu *pmu)
 		if (e->ldlat) {
 			if (!e->aux_event) {
 				/* ARM and Most of Intel */
-				scnprintf(mem_loads_name, sizeof(mem_loads_name),
+				scnprintf(buf, buf_size,
 					  e->name, pmu->name,
 					  perf_mem_events__loads_ldlat);
 			} else {
 				/* Intel with mem-loads-aux event */
-				scnprintf(mem_loads_name, sizeof(mem_loads_name),
+				scnprintf(buf, buf_size,
 					  e->name, pmu->name, pmu->name,
 					  perf_mem_events__loads_ldlat);
 			}
 		} else {
 			if (!e->aux_event) {
 				/* AMD and POWER */
-				scnprintf(mem_loads_name, sizeof(mem_loads_name),
+				scnprintf(buf, buf_size,
 					  e->name, pmu->name);
-			} else
+			} else {
 				return NULL;
+			}
 		}
-
-		return mem_loads_name;
+		return buf;
 	}
 
 	if (i == PERF_MEM_EVENTS__STORE) {
-		scnprintf(mem_stores_name, sizeof(mem_stores_name),
+		scnprintf(buf, buf_size,
 			  e->name, pmu->name);
-		return mem_stores_name;
+		return buf;
 	}
 
 	return NULL;
@@ -238,55 +236,69 @@ void perf_pmu__mem_events_list(struct perf_pmu *pmu)
 	int j;
 
 	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
+		char buf[128];
 		struct perf_mem_event *e = perf_pmu__mem_events_ptr(pmu, j);
 
 		fprintf(stderr, "%-*s%-*s%s",
 			e->tag ? 13 : 0,
 			e->tag ? : "",
 			e->tag && verbose > 0 ? 25 : 0,
-			e->tag && verbose > 0 ? perf_pmu__mem_events_name(j, pmu) : "",
+			e->tag && verbose > 0
+			? perf_pmu__mem_events_name(pmu, j, buf, sizeof(buf))
+			: "",
 			e->supported ? ": available\n" : "");
 	}
 }
 
-int perf_mem_events__record_args(const char **rec_argv, int *argv_nr)
+int perf_mem_events__record_args(const char **rec_argv, int *argv_nr, char **event_name_storage_out)
 {
 	const char *mnt = sysfs__mount();
 	struct perf_pmu *pmu = NULL;
-	struct perf_mem_event *e;
 	int i = *argv_nr;
-	const char *s;
-	char *copy;
 	struct perf_cpu_map *cpu_map = NULL;
-	int ret;
+	size_t event_name_storage_size =
+		perf_pmu__mem_events_num_mem_pmus(NULL) * PERF_MEM_EVENTS__MAX * 128;
+	size_t event_name_storage_remaining = event_name_storage_size;
+	char *event_name_storage = malloc(event_name_storage_size);
+	char *event_name_storage_ptr = event_name_storage;
+
+	if (!event_name_storage)
+		return -ENOMEM;
 
+	*event_name_storage_out = NULL;
 	while ((pmu = perf_pmus__scan_mem(pmu)) != NULL) {
 		for (int j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
-			e = perf_pmu__mem_events_ptr(pmu, j);
+			const char *s;
+			struct perf_mem_event *e = perf_pmu__mem_events_ptr(pmu, j);
+			int ret;
 
 			if (!perf_mem_record[j])
 				continue;
 
 			if (!e->supported) {
+				char buf[128];
+
 				pr_err("failed: event '%s' not supported\n",
-					perf_pmu__mem_events_name(j, pmu));
+					perf_pmu__mem_events_name(pmu, j, buf, sizeof(buf)));
+				free(event_name_storage);
 				return -1;
 			}
 
-			s = perf_pmu__mem_events_name(j, pmu);
+			s = perf_pmu__mem_events_name(pmu, j, event_name_storage_ptr,
+						      event_name_storage_remaining);
 			if (!s || !perf_pmu__mem_events_supported(mnt, pmu, e))
 				continue;
 
-			copy = strdup(s);
-			if (!copy)
-				return -1;
-
 			rec_argv[i++] = "-e";
-			rec_argv[i++] = copy;
+			rec_argv[i++] = event_name_storage_ptr;
+			event_name_storage_remaining -= strlen(event_name_storage_ptr) + 1;
+			event_name_storage_ptr += strlen(event_name_storage_ptr) + 1;
 
 			ret = perf_cpu_map__merge(&cpu_map, pmu->cpus);
-			if (ret < 0)
+			if (ret < 0) {
+				free(event_name_storage);
 				return ret;
+			}
 		}
 	}
 
@@ -301,6 +313,7 @@ int perf_mem_events__record_args(const char **rec_argv, int *argv_nr)
 	}
 
 	*argv_nr = i;
+	*event_name_storage_out = event_name_storage;
 	return 0;
 }
 
diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index 8dc27db9fd52..a5c19d39ee37 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -38,7 +38,8 @@ int perf_pmu__mem_events_num_mem_pmus(struct perf_pmu *pmu);
 bool is_mem_loads_aux_event(struct evsel *leader);
 
 void perf_pmu__mem_events_list(struct perf_pmu *pmu);
-int perf_mem_events__record_args(const char **rec_argv, int *argv_nr);
+int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
+				 char **event_name_storage_out);
 
 int perf_mem__tlb_scnprintf(char *out, size_t sz, const struct mem_info *mem_info);
 int perf_mem__lvl_scnprintf(char *out, size_t sz, const struct mem_info *mem_info);
-- 
2.49.0.rc0.332.g42c0ae87b1-goog

