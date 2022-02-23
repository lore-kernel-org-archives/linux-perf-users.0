Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB3CC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Feb 2022 13:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236430AbiBWNDb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Feb 2022 08:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbiBWNDa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Feb 2022 08:03:30 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AD893190
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Feb 2022 05:03:02 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id r13so29200727ejd.5
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Feb 2022 05:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Cb63FRuEj0z5AiD3zIcv5uOqYVg4Nom83uDPWgeSb9I=;
        b=bjrTVzBQDYrVL4t3M4w5hxpvbuIbXyPo1qbc5TJ1sBsZ/3d0v1ru1gI+fN0PriSZDO
         v50B1Oc1JnCtHem46iF8VMVJWgxO7AV3g9ggkJSe+ED+X+YdoLGaJJ2hgVlc4axcN2L4
         DhUUJ1GNx6LcSdDRRBpx/k37XXJ96wduI21cuhLP5Al5qe2uIW59rPBP0dhsT8Cu7j78
         9rjMbT67kw2MLauF395oZbIpvBlQA8QUEg7mM1HDTQZuY21F/qs53GAv5Geo8oIqTV23
         BX9Plg0kBJlf9+xkv8KhU+ZR6Zzegrqi5/NRrha6F3OoWRcNFuWPBTba4t3J7uE2DEnV
         dKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cb63FRuEj0z5AiD3zIcv5uOqYVg4Nom83uDPWgeSb9I=;
        b=EcEHEXMJhZ3jHa78RID+8AHj7UtZ4RodXvdGA4D7i6x3Bip3K/ozbANVepwj/8zUT7
         MAyVw44wZMDzuH1DwfQnytbOb4X3KAtIEXVJMdT7e2ezSNN9gA/7P+xDikP1Q9NUZXoz
         g0XP2+ovWKiSB8UEGn0nxR6Aef1A8TvjGtcujulUBfaqldRVhshnkEc5yVsLL6K1TR+A
         GZyfyAF5zTfCSoCPAah9xkgxGz9vI5I0Ubm+gVa30rwLGNwWU+Ydiww1kiNBflh22wpp
         VMnLr+41bfmI+PMUogRqm9UVicHORa020Dn3dlQZSIBWztXTIbyawawuLqY9Rr2PpySz
         e4nA==
X-Gm-Message-State: AOAM5328r+EmzNNnwzhL6VLGQMRear3ZtciwBm+M9kjHiDgbTNOUedan
        trHJ34BjeatdZ913DT13BVM=
X-Google-Smtp-Source: ABdhPJyMEevR3c7FH3Of8mD/Sr+W0ub8SWgxoifOx6PehyvB9POiruCMUE245F6fgJNl2yEAZX0m6g==
X-Received: by 2002:a17:906:4116:b0:6cd:1980:5ad0 with SMTP id j22-20020a170906411600b006cd19805ad0mr24393100ejk.595.1645621380479;
        Wed, 23 Feb 2022 05:03:00 -0800 (PST)
Received: from krava ([83.240.63.118])
        by smtp.gmail.com with ESMTPSA id b4sm7504713ejv.108.2022.02.23.05.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 05:02:59 -0800 (PST)
Date:   Wed, 23 Feb 2022 14:02:56 +0100
From:   Jiri Olsa <olsajiri@gmail.com>
To:     Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] libperf: Add API for allocating new thread map
Message-ID: <YhYwgJogf9gFjn6w@krava>
References: <20220221102628.43904-1-tz.stoyanov@gmail.com>
 <YhPsKeK0UdjiDN1R@krava>
 <C62503E3-B72B-4441-8900-1439CB7CAB04@gmail.com>
 <CAPpZLN7Qmgsm6ptthvsjgcqgMQd1tnuX=ohHBcPAQ4zu4VVkrw@mail.gmail.com>
 <YhV+BOp0A+aqavlc@kernel.org>
 <CAPpZLN7rPxjT2zUNe7jFJh_3vY64hYFEkOP7-Kp0POrRSUQhWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPpZLN7rPxjT2zUNe7jFJh_3vY64hYFEkOP7-Kp0POrRSUQhWw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Feb 23, 2022 at 11:08:24AM +0200, Tzvetomir Stoyanov wrote:
> On Wed, Feb 23, 2022 at 2:21 AM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> > Em Tue, Feb 22, 2022 at 04:32:05AM +0200, Tzvetomir Stoyanov escreveu:
> > > On Mon, Feb 21, 2022 at 10:21 PM Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > > > On February 21, 2022 4:46:49 PM GMT-03:00, Jiri Olsa <olsajiri@gmail.com> wrote:
> > > > >On Mon, Feb 21, 2022 at 12:26:28PM +0200, Tzvetomir Stoyanov (VMware) wrote:
> > > > >looks good, would you also find useful in your use case the comm support
> > > > >in thread_map? the thread_map__read_comms function? we could move it from
> > > > >perf to libperf
> >
> > > > IOW: we're happy that you're working on libperf, so feel encouraged
> > > > to move things from tools/perf/util/ to tools/lib/perf/ if you find
> > > > a supporting use case, brownie points if you also add an entry to
> > > > tools/perf/tests/, AKA 'perf test'.
> >
> > > Thanks, I see that there is a lot of functionality that could be moved
> > > from perf to libperf and which will be useful for the library users.
> > > We are going to use libperf in trace-cruncher,
> > > https://github.com/vmware/trace-cruncher, as an interface to perf.
> >
> > Cool, so as you go on adding functionality to trace cruncher and notice
> > that something that is in tools/perf/util/ that is usable, please submit
> > patches to move things to tools/lib/perf/, adding tests to 'perf test'
> > as you go.
> >
> > Thanks a lot!
> >
> > - Arnaldo
> 
> Sure, I'll do it. I have one more question - do you plan to release
> the next version of libperf soon, so we can use this new functionality
> in trace-cruncher ?

we can discuss that, can be fast ;-)

btw I took a look on that and already put some change together,
please take a look and feel free to use it

I just moved thread_map__read_comms, but I wonder we want it
to change to return status if it's in libperf

jirka


---
 tools/lib/perf/Build                    |  7 ++-
 tools/lib/perf/Makefile                 |  1 +
 tools/lib/perf/include/perf/threadmap.h |  2 +
 tools/lib/perf/libperf.map              |  5 +++
 tools/lib/perf/threadmap.c              | 57 +++++++++++++++++++++++++
 tools/perf/builtin-stat.c               |  2 +-
 tools/perf/tests/thread-map.c           |  6 +--
 tools/perf/util/Build                   |  6 ---
 tools/perf/util/python-ext-sources      |  1 -
 tools/perf/util/thread_map.c            | 53 -----------------------
 tools/perf/util/thread_map.h            |  1 -
 11 files changed, 75 insertions(+), 66 deletions(-)

diff --git a/tools/lib/perf/Build b/tools/lib/perf/Build
index e8f5b7fb9973..6d3f63793a51 100644
--- a/tools/lib/perf/Build
+++ b/tools/lib/perf/Build
@@ -7,8 +7,13 @@ libperf-y += mmap.o
 libperf-y += zalloc.o
 libperf-y += xyarray.o
 libperf-y += lib.o
+libperf-y += string.o
 
-$(OUTPUT)zalloc.o: ../../lib/zalloc.c FORCE
+$(OUTPUT)zalloc.o: ../zalloc.c FORCE
+	$(call rule_mkdir)
+	$(call if_changed_dep,cc_o_c)
+
+$(OUTPUT)string.o: ../string.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_o_c)
 
diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
index 08fe6e3c4089..81b495af3cf1 100644
--- a/tools/lib/perf/Makefile
+++ b/tools/lib/perf/Makefile
@@ -75,6 +75,7 @@ override CFLAGS += -Werror -Wall
 override CFLAGS += -fPIC
 override CFLAGS += $(INCLUDES)
 override CFLAGS += -fvisibility=hidden
+override CFLAGS += -D_GNU_SOURCE
 
 all:
 
diff --git a/tools/lib/perf/include/perf/threadmap.h b/tools/lib/perf/include/perf/threadmap.h
index a7c50de8d010..6301f0db1db4 100644
--- a/tools/lib/perf/include/perf/threadmap.h
+++ b/tools/lib/perf/include/perf/threadmap.h
@@ -17,4 +17,6 @@ LIBPERF_API pid_t perf_thread_map__pid(struct perf_thread_map *map, int thread);
 LIBPERF_API struct perf_thread_map *perf_thread_map__get(struct perf_thread_map *map);
 LIBPERF_API void perf_thread_map__put(struct perf_thread_map *map);
 
+LIBPERF_API void perf_thread_map__read_comms(struct perf_thread_map *map);
+
 #endif /* __LIBPERF_THREADMAP_H */
diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
index 6fa0d651576b..4345f7b9b0c5 100644
--- a/tools/lib/perf/libperf.map
+++ b/tools/lib/perf/libperf.map
@@ -56,3 +56,8 @@ LIBPERF_0.0.1 {
 	local:
 		*;
 };
+
+LIBPERF_0.0.2 {
+	global:
+		perf_thread_map__read_comms;
+} LIBPERF_0.0.1;
diff --git a/tools/lib/perf/threadmap.c b/tools/lib/perf/threadmap.c
index e92c368b0a6c..f5ad6d939365 100644
--- a/tools/lib/perf/threadmap.c
+++ b/tools/lib/perf/threadmap.c
@@ -6,6 +6,10 @@
 #include <string.h>
 #include <asm/bug.h>
 #include <stdio.h>
+#include <errno.h>
+#include <api/fs/fs.h>
+#include <linux/string.h>
+#include "internal.h"
 
 static void perf_thread_map__reset(struct perf_thread_map *map, int start, int nr)
 {
@@ -89,3 +93,56 @@ pid_t perf_thread_map__pid(struct perf_thread_map *map, int thread)
 {
 	return map->map[thread].pid;
 }
+
+static int get_comm(char **comm, pid_t pid)
+{
+	char *path;
+	size_t size;
+	int err;
+
+	if (asprintf(&path, "%s/%d/comm", procfs__mountpoint(), pid) == -1)
+		return -ENOMEM;
+
+	err = filename__read_str(path, comm, &size);
+	if (!err) {
+		/*
+		 * We're reading 16 bytes, while filename__read_str
+		 * allocates data per BUFSIZ bytes, so we can safely
+		 * mark the end of the string.
+		 */
+		(*comm)[size] = 0;
+		strim(*comm);
+	}
+
+	free(path);
+	return err;
+}
+
+static void comm_init(struct perf_thread_map *map, int i)
+{
+	pid_t pid = perf_thread_map__pid(map, i);
+	char *comm = NULL;
+
+	/* dummy pid comm initialization */
+	if (pid == -1) {
+		map->map[i].comm = strdup("dummy");
+		return;
+	}
+
+	/*
+	 * The comm name is like extra bonus ;-),
+	 * so just warn if we fail for any reason.
+	 */
+	if (get_comm(&comm, pid))
+		pr_warning("Couldn't resolve comm name for pid %d\n", pid);
+
+	map->map[i].comm = comm;
+}
+
+void perf_thread_map__read_comms(struct perf_thread_map *threads)
+{
+	int i;
+
+	for (i = 0; i < threads->nr; ++i)
+		comm_init(threads, i);
+}
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 3f98689dd687..8456ad3e73b8 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2477,7 +2477,7 @@ int cmd_stat(int argc, const char **argv)
 	 * so we could print it out on output.
 	 */
 	if (stat_config.aggr_mode == AGGR_THREAD) {
-		thread_map__read_comms(evsel_list->core.threads);
+		perf_thread_map__read_comms(evsel_list->core.threads);
 		if (target.system_wide) {
 			if (runtime_stat_new(&stat_config,
 				perf_thread_map__nr(evsel_list->core.threads))) {
diff --git a/tools/perf/tests/thread-map.c b/tools/perf/tests/thread-map.c
index e413c1387fcb..00180b56948e 100644
--- a/tools/perf/tests/thread-map.c
+++ b/tools/perf/tests/thread-map.c
@@ -30,7 +30,7 @@ static int test__thread_map(struct test_suite *test __maybe_unused, int subtest
 	map = thread_map__new_by_pid(getpid());
 	TEST_ASSERT_VAL("failed to alloc map", map);
 
-	thread_map__read_comms(map);
+	perf_thread_map__read_comms(map);
 
 	TEST_ASSERT_VAL("wrong nr", map->nr == 1);
 	TEST_ASSERT_VAL("wrong pid",
@@ -46,7 +46,7 @@ static int test__thread_map(struct test_suite *test __maybe_unused, int subtest
 	map = perf_thread_map__new_dummy();
 	TEST_ASSERT_VAL("failed to alloc map", map);
 
-	thread_map__read_comms(map);
+	perf_thread_map__read_comms(map);
 
 	TEST_ASSERT_VAL("wrong nr", map->nr == 1);
 	TEST_ASSERT_VAL("wrong pid", perf_thread_map__pid(map, 0) == -1);
@@ -97,7 +97,7 @@ static int test__thread_map_synthesize(struct test_suite *test __maybe_unused, i
 	threads = thread_map__new_by_pid(getpid());
 	TEST_ASSERT_VAL("failed to alloc map", threads);
 
-	thread_map__read_comms(threads);
+	perf_thread_map__read_comms(threads);
 
 	TEST_ASSERT_VAL("failed to synthesize map",
 		!perf_event__synthesize_thread_map2(NULL, threads, process_event, NULL));
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 9a7209a99e16..285b466ac1c3 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -32,7 +32,6 @@ perf-y += print_binary.o
 perf-y += rlimit.o
 perf-y += argv_split.o
 perf-y += rbtree.o
-perf-y += libstring.o
 perf-y += bitmap.o
 perf-y += hweight.o
 perf-y += smt.o
@@ -279,7 +278,6 @@ $(OUTPUT)util/expr.o: $(OUTPUT)util/expr-flex.c $(OUTPUT)util/expr-bison.c
 CFLAGS_bitmap.o        += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ETC_PERFCONFIG_SQ))"
 CFLAGS_find_bit.o      += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ETC_PERFCONFIG_SQ))"
 CFLAGS_rbtree.o        += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ETC_PERFCONFIG_SQ))"
-CFLAGS_libstring.o     += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ETC_PERFCONFIG_SQ))"
 CFLAGS_hweight.o       += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ETC_PERFCONFIG_SQ))"
 CFLAGS_parse-events.o  += -Wno-redundant-decls
 CFLAGS_expr.o          += -Wno-redundant-decls
@@ -309,10 +307,6 @@ $(OUTPUT)util/rbtree.o: ../lib/rbtree.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_o_c)
 
-$(OUTPUT)util/libstring.o: ../lib/string.c FORCE
-	$(call rule_mkdir)
-	$(call if_changed_dep,cc_o_c)
-
 $(OUTPUT)util/hweight.o: ../lib/hweight.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_o_c)
diff --git a/tools/perf/util/python-ext-sources b/tools/perf/util/python-ext-sources
index a685d20165f7..b4cbd727c8b1 100644
--- a/tools/perf/util/python-ext-sources
+++ b/tools/perf/util/python-ext-sources
@@ -20,7 +20,6 @@ util/namespaces.c
 ../lib/find_bit.c
 ../lib/list_sort.c
 ../lib/hweight.c
-../lib/string.c
 ../lib/vsprintf.c
 util/thread_map.c
 util/util.c
diff --git a/tools/perf/util/thread_map.c b/tools/perf/util/thread_map.c
index c9bfe4696943..7dff6e315aa9 100644
--- a/tools/perf/util/thread_map.c
+++ b/tools/perf/util/thread_map.c
@@ -315,59 +315,6 @@ size_t thread_map__fprintf(struct perf_thread_map *threads, FILE *fp)
 	return printed + fprintf(fp, "\n");
 }
 
-static int get_comm(char **comm, pid_t pid)
-{
-	char *path;
-	size_t size;
-	int err;
-
-	if (asprintf(&path, "%s/%d/comm", procfs__mountpoint(), pid) == -1)
-		return -ENOMEM;
-
-	err = filename__read_str(path, comm, &size);
-	if (!err) {
-		/*
-		 * We're reading 16 bytes, while filename__read_str
-		 * allocates data per BUFSIZ bytes, so we can safely
-		 * mark the end of the string.
-		 */
-		(*comm)[size] = 0;
-		strim(*comm);
-	}
-
-	free(path);
-	return err;
-}
-
-static void comm_init(struct perf_thread_map *map, int i)
-{
-	pid_t pid = perf_thread_map__pid(map, i);
-	char *comm = NULL;
-
-	/* dummy pid comm initialization */
-	if (pid == -1) {
-		map->map[i].comm = strdup("dummy");
-		return;
-	}
-
-	/*
-	 * The comm name is like extra bonus ;-),
-	 * so just warn if we fail for any reason.
-	 */
-	if (get_comm(&comm, pid))
-		pr_warning("Couldn't resolve comm name for pid %d\n", pid);
-
-	map->map[i].comm = comm;
-}
-
-void thread_map__read_comms(struct perf_thread_map *threads)
-{
-	int i;
-
-	for (i = 0; i < threads->nr; ++i)
-		comm_init(threads, i);
-}
-
 static void thread_map__copy_event(struct perf_thread_map *threads,
 				   struct perf_record_thread_map *event)
 {
diff --git a/tools/perf/util/thread_map.h b/tools/perf/util/thread_map.h
index 3bb860a32b8e..1f84edd38b17 100644
--- a/tools/perf/util/thread_map.h
+++ b/tools/perf/util/thread_map.h
@@ -25,7 +25,6 @@ struct perf_thread_map *thread_map__new_by_tid_str(const char *tid_str);
 
 size_t thread_map__fprintf(struct perf_thread_map *threads, FILE *fp);
 
-void thread_map__read_comms(struct perf_thread_map *threads);
 bool thread_map__has(struct perf_thread_map *threads, pid_t pid);
 int thread_map__remove(struct perf_thread_map *threads, int idx);
 #endif	/* __PERF_THREAD_MAP_H */
-- 
2.35.1

