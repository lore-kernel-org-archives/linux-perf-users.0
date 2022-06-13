Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372B4CCA47E
	for <linux-perf-users@archiver.kernel.org>; Mon, 13 Jun 2022 08:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239993AbiFMIrv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 13 Jun 2022 04:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240225AbiFMIru (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 13 Jun 2022 04:47:50 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A471055A
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Jun 2022 01:47:49 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-30c1d90587dso47520967b3.14
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Jun 2022 01:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CO3D4hTzGOfHEmW5/B6ajWEyTv2kPQTJ9KX6c7xDLfk=;
        b=pdLuOfjOGGpuAIIIUbBK2mNwR2jn9y06YPNqwblzFH9UyjNTaqkPmiN+5spxAEX9dS
         ljOkNDxuYuvP8qqIWgc7pHoxSeJ8vgaZHiSXlfOk1/A0WoL1nA1oT7oBwr0lImoxTf9a
         ik8hnEac+5G0rgC3fT107Ri//zEKe44geIb7sy/KQoTcVODUvEJ2rSMV4fGLCSX2lQms
         A8QK/LiG3xfEMTKWoQWTOiLZT7PHAtoTf+XH0IYZtDWmNJuPllhhAzsrs8y9DuhwNJXb
         V37Cb++sGxT1mBxvQ/MQ5LSifNgWQDMBAHcLwovryRm8wWHU4vq9JPXgeCSCtpGHUxWq
         jfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CO3D4hTzGOfHEmW5/B6ajWEyTv2kPQTJ9KX6c7xDLfk=;
        b=zFbBR8m/1klDc3veFIcdSAMnC/KWRo1KXRAIqz3e1KV33opsV9ii1P1mdhHdW22qbJ
         FCmi7oX8P669Bmo7m+Jy7moaeNkHPSu+GcOUEFpC5jJwVRRhcWwuYK/rMzyEXc7bwuP2
         8RaJ+/mSzTaws/jruNac6ky1lTt/PIyxcETd+MDlMzNKOZ0bnbJu9iAAdi8cj+ehDo0z
         7rdoxm3bautaqDEaTyOp+QwegCJFtjnT51vhOX1+P7+2Vmgh/PwoyQnRg0cz2mxm00+t
         n3VnC+CTT9Kndk4LGeBEoDMg/s62FYawSugVqCp4pN9cIih9gr1L30pwabCw5L4dOdzX
         piqw==
X-Gm-Message-State: AOAM533YmfZoebJRJV9O4ucAlx3hKi3a/rLER+qzs7d5uiitbGlix7pT
        rzt6Ov4Rvzkj9JRQLTVRsaRhSxqnbFrh
X-Google-Smtp-Source: ABdhPJyiA7WDdiT+o/vB3cnKSfyG8RTVsZXdEnIl6QLd+ZSHqTvHapOTeZj8NYrr6a2AwWTov4D0SeY4mQLB
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:1256:a8b4:594a:9164])
 (user=irogers job=sendgmr) by 2002:a05:6902:191:b0:660:26f4:3318 with SMTP id
 t17-20020a056902019100b0066026f43318mr60821815ybh.5.1655110068179; Mon, 13
 Jun 2022 01:47:48 -0700 (PDT)
Date:   Mon, 13 Jun 2022 01:47:35 -0700
In-Reply-To: <20220613084739.1159111-1-irogers@google.com>
Message-Id: <20220613084739.1159111-3-irogers@google.com>
Mime-Version: 1.0
References: <20220613084739.1159111-1-irogers@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH 2/6] perf cpumap: Synthetic events and const/static
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

