Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D08CCA47C
	for <linux-perf-users@archiver.kernel.org>; Tue, 14 Jun 2022 14:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345441AbiFNOfV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 14 Jun 2022 10:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355258AbiFNOeI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 14 Jun 2022 10:34:08 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3A736177
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jun 2022 07:34:05 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-30c14765d55so26861787b3.13
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jun 2022 07:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CO3D4hTzGOfHEmW5/B6ajWEyTv2kPQTJ9KX6c7xDLfk=;
        b=phffdDdBU4lgb8BoixzP/AC9Kl0ZOB2Uj+TgZCRIxAhkQ6fzCHTWcQEFbTK/aGYTgL
         +pB57c8L+coHi9FCFrR9DOdMI3W66G8vZVhalCi68PMMVALvh2qput85ncMVrXktD7Xr
         +qFAjoL0s4ln+eu0cQHhnZzPpPP/NdH6/rVfirDLUI07gc6kFdsZ0E4kIHhlhOD2XfYJ
         3p3W8YTRa8hEadLrk9gvu3c0hqNXypHHjeODjmAkPytVfd3lvRkpQLFI0EP4mQPkqbkv
         yosTQ8Dm9OQfl2eewK/IXZ/8axDUT7hT4H0gfKPBpGaE+Xs66XAkwLCi9LOQjAJFvP8K
         g9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CO3D4hTzGOfHEmW5/B6ajWEyTv2kPQTJ9KX6c7xDLfk=;
        b=V+mTqXwtygSj0KgN20gfOlE2SKSX6F1NdQk9DVNQof1oLn+Jy6mYFj+kzXBg8Sx11j
         Y0SPDlni8qtBC7LrGTMNReEbPNyLBfsMFoRQCN+J80W/kAGWtvX7K2FQop+Y5xxZRHiA
         Tk02Y94gx7wscH+WUQiuelPj9IZUZUQyRxVYEsB39+3bpRhYcfTHwcPARbpnzMLwPx14
         DRWyWYwilydkw9f1DOMqXYLTX9MSHd1mH7radKgjkYd1qBl3njwTFiZQxkmMRsTO6pP0
         rCP2X0rqM0BKB3YpAxrkZpsN2hg7ZWzexCu2AaxYw68O03XE/ji34b7OhqUIaEqwYX4N
         WJ3A==
X-Gm-Message-State: AJIora/QPLOyG3QPnb2QhiZArPCTSPoVo0h3nY2DTw/t7xZvfEQfWRKo
        tyXy5MneUptjKs8bcUW69mZcVaALVFe1
X-Google-Smtp-Source: AGRyM1vb+8dVtgkqAvldV+wIVoCPTAtyJliDFVvrwzrOT1wfCpvgGQys+evmTm/OCXAd1QLatlZ1CoO0iRLp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:b55a:aaa7:a:1b17])
 (user=irogers job=sendgmr) by 2002:a05:6902:1006:b0:660:6f21:a210 with SMTP
 id w6-20020a056902100600b006606f21a210mr5360979ybt.178.1655217244544; Tue, 14
 Jun 2022 07:34:04 -0700 (PDT)
Date:   Tue, 14 Jun 2022 07:33:49 -0700
In-Reply-To: <20220614143353.1559597-1-irogers@google.com>
Message-Id: <20220614143353.1559597-3-irogers@google.com>
Mime-Version: 1.0
References: <20220614143353.1559597-1-irogers@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH v2 2/6] perf cpumap: Synthetic events and const/static
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        German Gomez <german.gomez@arm.com>,
        Colin Ian King <colin.king@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Make the cpumap arguments const to make it clearer they are in rather
than out arguments. Make two functions static and remove external
declarations.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/event.h            |  4 ----
 tools/perf/util/synthetic-events.c | 20 +++++++++++---------
 tools/perf/util/synthetic-events.h |  2 +-
 3 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index cdd72e05fd28..2a69e639f6b3 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -461,10 +461,6 @@ size_t perf_event__fprintf(union perf_event *event, struct machine *machine, FIL
 int kallsyms__get_function_start(const char *kallsyms_filename,
 				 const char *symbol_name, u64 *addr);
 
-void *cpu_map_data__alloc(struct perf_cpu_map *map, size_t *size, u16 *type, int *max);
-void  cpu_map_data__synthesize(struct perf_record_cpu_map_data *data, struct perf_cpu_map *map,
-			       u16 type, int max);
-
 void event_attr_init(struct perf_event_attr *attr);
 
 int perf_event_paranoid(void);
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 27acdc5e5723..b8a42a096502 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1184,7 +1184,7 @@ int perf_event__synthesize_thread_map2(struct perf_tool *tool,
 }
 
 static void synthesize_cpus(struct cpu_map_entries *cpus,
-			    struct perf_cpu_map *map)
+			    const struct perf_cpu_map *map)
 {
 	int i, map_nr = perf_cpu_map__nr(map);
 
@@ -1195,7 +1195,7 @@ static void synthesize_cpus(struct cpu_map_entries *cpus,
 }
 
 static void synthesize_mask(struct perf_record_record_cpu_map *mask,
-			    struct perf_cpu_map *map, int max)
+			    const struct perf_cpu_map *map, int max)
 {
 	int i;
 
@@ -1206,12 +1206,12 @@ static void synthesize_mask(struct perf_record_record_cpu_map *mask,
 		set_bit(perf_cpu_map__cpu(map, i).cpu, mask->mask);
 }
 
-static size_t cpus_size(struct perf_cpu_map *map)
+static size_t cpus_size(const struct perf_cpu_map *map)
 {
 	return sizeof(struct cpu_map_entries) + perf_cpu_map__nr(map) * sizeof(u16);
 }
 
-static size_t mask_size(struct perf_cpu_map *map, int *max)
+static size_t mask_size(const struct perf_cpu_map *map, int *max)
 {
 	int i;
 
@@ -1228,7 +1228,8 @@ static size_t mask_size(struct perf_cpu_map *map, int *max)
 	return sizeof(struct perf_record_record_cpu_map) + BITS_TO_LONGS(*max) * sizeof(long);
 }
 
-void *cpu_map_data__alloc(struct perf_cpu_map *map, size_t *size, u16 *type, int *max)
+static void *cpu_map_data__alloc(const struct perf_cpu_map *map, size_t *size,
+				 u16 *type, int *max)
 {
 	size_t size_cpus, size_mask;
 	bool is_dummy = perf_cpu_map__empty(map);
@@ -1262,8 +1263,9 @@ void *cpu_map_data__alloc(struct perf_cpu_map *map, size_t *size, u16 *type, int
 	return zalloc(*size);
 }
 
-void cpu_map_data__synthesize(struct perf_record_cpu_map_data *data, struct perf_cpu_map *map,
-			      u16 type, int max)
+static void cpu_map_data__synthesize(struct perf_record_cpu_map_data *data,
+				     const struct perf_cpu_map *map,
+				     u16 type, int max)
 {
 	data->type = type;
 
@@ -1278,7 +1280,7 @@ void cpu_map_data__synthesize(struct perf_record_cpu_map_data *data, struct perf
 	}
 }
 
-static struct perf_record_cpu_map *cpu_map_event__new(struct perf_cpu_map *map)
+static struct perf_record_cpu_map *cpu_map_event__new(const struct perf_cpu_map *map)
 {
 	size_t size = sizeof(struct perf_record_cpu_map);
 	struct perf_record_cpu_map *event;
@@ -1298,7 +1300,7 @@ static struct perf_record_cpu_map *cpu_map_event__new(struct perf_cpu_map *map)
 }
 
 int perf_event__synthesize_cpu_map(struct perf_tool *tool,
-				   struct perf_cpu_map *map,
+				   const struct perf_cpu_map *map,
 				   perf_event__handler_t process,
 				   struct machine *machine)
 {
diff --git a/tools/perf/util/synthetic-events.h b/tools/perf/util/synthetic-events.h
index 78a0450db164..44839190234a 100644
--- a/tools/perf/util/synthetic-events.h
+++ b/tools/perf/util/synthetic-events.h
@@ -46,7 +46,7 @@ typedef int (*perf_event__handler_t)(struct perf_tool *tool, union perf_event *e
 int perf_event__synthesize_attrs(struct perf_tool *tool, struct evlist *evlist, perf_event__handler_t process);
 int perf_event__synthesize_attr(struct perf_tool *tool, struct perf_event_attr *attr, u32 ids, u64 *id, perf_event__handler_t process);
 int perf_event__synthesize_build_id(struct perf_tool *tool, struct dso *pos, u16 misc, perf_event__handler_t process, struct machine *machine);
-int perf_event__synthesize_cpu_map(struct perf_tool *tool, struct perf_cpu_map *cpus, perf_event__handler_t process, struct machine *machine);
+int perf_event__synthesize_cpu_map(struct perf_tool *tool, const struct perf_cpu_map *cpus, perf_event__handler_t process, struct machine *machine);
 int perf_event__synthesize_event_update_cpus(struct perf_tool *tool, struct evsel *evsel, perf_event__handler_t process);
 int perf_event__synthesize_event_update_name(struct perf_tool *tool, struct evsel *evsel, perf_event__handler_t process);
 int perf_event__synthesize_event_update_scale(struct perf_tool *tool, struct evsel *evsel, perf_event__handler_t process);
-- 
2.36.1.476.g0c4daa206d-goog

