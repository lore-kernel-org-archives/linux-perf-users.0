Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B010EC6FD1D
	for <linux-perf-users@archiver.kernel.org>; Tue,  4 Apr 2023 21:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbjDDVA7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 4 Apr 2023 17:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234717AbjDDVA5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 4 Apr 2023 17:00:57 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737405580
        for <linux-perf-users@vger.kernel.org>; Tue,  4 Apr 2023 14:00:34 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54161af1984so333301827b3.3
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Apr 2023 14:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680642029;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mxn0E0FAY/ukx0XogLEmWEdFPlsoSvFOzcJYSSNA4QA=;
        b=EUczPLAUnJNdgVzKOd0lBOpvV33TEnLbczWC/rsjdAkFVWbXRkLpKdLtTUQ2eA59NV
         3kjQNMAjmt0hHcbum8LJQhmqcFQRaG0tN+wrU9XmUuwr7Z7WQqwPHuKY11OqVY2CBC+s
         yuUeCJm1SfpdG/82QPwOVxuC72GXiqsgdS9pUhq8b0NqbNqPHMwlmarxIaHKetx1N0oV
         X2jYkMZBPwp6mmSMZo/jDAJoegSUrHNTErbRNx1JYzW4CwoJLZdVXbP1Bowgqyxn9yu0
         GYjncY8SADP41G2IX023fOH4PYYhTRMxXxuOsresxexOCZsl1M6iRbjupx9bgcM3I111
         TSjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680642029;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mxn0E0FAY/ukx0XogLEmWEdFPlsoSvFOzcJYSSNA4QA=;
        b=zDyc6OYb+GhOjh0tbK1wT+vV7ghaCA1BroLspPlmK9Z6hXZiu5xIe2zkY8AWgLe4w4
         VaHm4TmDO6b9ydow3jZ3szVIAFkcapdkbXv3kKDM7qzepyaQuzh+n7lQfXOY+LDb69EU
         BqYo585yDgN1jqCbLx1kQ6teojju+tFTK6+hFHp61BaAxzAC9HXFA3t6BODy/5QPOnBR
         ByeV9QYo6zLvNAGrIttwbaPVDWKnMLSU7hzZfbwFIC2VppfWnTmKPxISSAag5zb86yxE
         a+0j3pUn96CFOKz1gAj/Lu9dbbY0yY3+v6Bwr39IOJoB5TwYHweeAn8cMoI6knkfSNks
         M+ng==
X-Gm-Message-State: AAQBX9f0uPDN1ssQHK/ZB5zHWAkyEBQ32/CSlowdGMuoTGwbNz/KtKCS
        l6TIQykJWbqohXf1X66eSpeVq14TsJ1V
X-Google-Smtp-Source: AKy350bGRkRJjaPremdg8Fl3wE55T1VIzbQa0ONWjDYvXNRpxQVYvcIcm8zXrULg4hBfad78XdQ/8nZ472fj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a051:e074:d6f:dc29])
 (user=irogers job=sendgmr) by 2002:a05:690c:72c:b0:52f:184a:da09 with SMTP id
 bt12-20020a05690c072c00b0052f184ada09mr392053ywb.2.1680642028954; Tue, 04 Apr
 2023 14:00:28 -0700 (PDT)
Date:   Tue,  4 Apr 2023 13:59:43 -0700
In-Reply-To: <20230404205954.2245628-1-irogers@google.com>
Message-Id: <20230404205954.2245628-2-irogers@google.com>
Mime-Version: 1.0
References: <20230404205954.2245628-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v6 01/12] perf map: Rename map_ip and unmap_ip
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        James Clark <james.clark@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, Hao Luo <haoluo@google.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add dso to match comment. This avoids a naming conflict with later
added accessor functions for variables in struct map.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kmem.c    | 2 +-
 tools/perf/builtin-script.c  | 4 ++--
 tools/perf/util/machine.c    | 4 ++--
 tools/perf/util/map.c        | 8 ++++----
 tools/perf/util/map.h        | 4 ++--
 tools/perf/util/symbol-elf.c | 4 ++--
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index f3029742b800..4d4b770a401c 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -423,7 +423,7 @@ static u64 find_callsite(struct evsel *evsel, struct perf_sample *sample)
 		if (!caller) {
 			/* found */
 			if (node->ms.map)
-				addr = map__unmap_ip(node->ms.map, node->ip);
+				addr = map__dso_unmap_ip(node->ms.map, node->ip);
 			else
 				addr = node->ip;
 
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 1d078106abc4..af0a69c7f41f 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1012,11 +1012,11 @@ static int perf_sample__fprintf_brstackoff(struct perf_sample *sample,
 
 		if (thread__find_map_fb(thread, sample->cpumode, from, &alf) &&
 		    !map__dso(alf.map)->adjust_symbols)
-			from = map__map_ip(alf.map, from);
+			from = map__dso_map_ip(alf.map, from);
 
 		if (thread__find_map_fb(thread, sample->cpumode, to, &alt) &&
 		    !map__dso(alt.map)->adjust_symbols)
-			to = map__map_ip(alt.map, to);
+			to = map__dso_map_ip(alt.map, to);
 
 		printed += fprintf(fp, " 0x%"PRIx64, from);
 		if (PRINT_FIELD(DSO)) {
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 7852b97da10a..9d24980a0a93 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -3058,7 +3058,7 @@ static int append_inlines(struct callchain_cursor *cursor, struct map_symbol *ms
 	if (!symbol_conf.inline_name || !map || !sym)
 		return ret;
 
-	addr = map__map_ip(map, ip);
+	addr = map__dso_map_ip(map, ip);
 	addr = map__rip_2objdump(map, addr);
 	dso = map__dso(map);
 
@@ -3103,7 +3103,7 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
 	 * its corresponding binary.
 	 */
 	if (entry->ms.map)
-		addr = map__map_ip(entry->ms.map, entry->ip);
+		addr = map__dso_map_ip(entry->ms.map, entry->ip);
 
 	srcline = callchain_srcline(&entry->ms, addr);
 	return callchain_cursor_append(cursor, entry->ip, &entry->ms,
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 416fc449bde8..d97a6d20626f 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -109,8 +109,8 @@ void map__init(struct map *map, u64 start, u64 end, u64 pgoff, struct dso *dso)
 	map->pgoff    = pgoff;
 	map->reloc    = 0;
 	map->dso      = dso__get(dso);
-	map->map_ip   = map__map_ip;
-	map->unmap_ip = map__unmap_ip;
+	map->map_ip   = map__dso_map_ip;
+	map->unmap_ip = map__dso_unmap_ip;
 	map->erange_warned = false;
 	refcount_set(&map->refcnt, 1);
 }
@@ -590,12 +590,12 @@ struct maps *map__kmaps(struct map *map)
 	return kmap->kmaps;
 }
 
-u64 map__map_ip(const struct map *map, u64 ip)
+u64 map__dso_map_ip(const struct map *map, u64 ip)
 {
 	return ip - map__start(map) + map->pgoff;
 }
 
-u64 map__unmap_ip(const struct map *map, u64 ip)
+u64 map__dso_unmap_ip(const struct map *map, u64 ip)
 {
 	return ip + map__start(map) - map->pgoff;
 }
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 16646b94fa3a..9b0a84e46e48 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -41,9 +41,9 @@ struct kmap *map__kmap(struct map *map);
 struct maps *map__kmaps(struct map *map);
 
 /* ip -> dso rip */
-u64 map__map_ip(const struct map *map, u64 ip);
+u64 map__dso_map_ip(const struct map *map, u64 ip);
 /* dso rip -> ip */
-u64 map__unmap_ip(const struct map *map, u64 ip);
+u64 map__dso_unmap_ip(const struct map *map, u64 ip);
 /* Returns ip */
 u64 identity__map_ip(const struct map *map __maybe_unused, u64 ip);
 
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index e715869eab8a..c55981116f68 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1357,8 +1357,8 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 			map->start = shdr->sh_addr + ref_reloc(kmap);
 			map->end = map__start(map) + shdr->sh_size;
 			map->pgoff = shdr->sh_offset;
-			map->map_ip = map__map_ip;
-			map->unmap_ip = map__unmap_ip;
+			map->map_ip = map__dso_map_ip;
+			map->unmap_ip = map__dso_unmap_ip;
 			/* Ensure maps are correctly ordered */
 			if (kmaps) {
 				int err;
-- 
2.40.0.348.gf938b09366-goog

