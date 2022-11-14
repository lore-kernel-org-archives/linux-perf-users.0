Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0940C433FE
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Nov 2022 07:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235910AbiKNHwY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 14 Nov 2022 02:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236086AbiKNHwU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Nov 2022 02:52:20 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F9019298
        for <linux-perf-users@vger.kernel.org>; Sun, 13 Nov 2022 23:52:16 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id t6-20020a25b706000000b006b38040b6f7so9719426ybj.6
        for <linux-perf-users@vger.kernel.org>; Sun, 13 Nov 2022 23:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FAjkIdGz/j9kJ1xDL5dYREJTueL8AT+RXQYxwRGY3ak=;
        b=CSUl/cD/WDzvyy7/gVUJxkLFomwzeS2nfA2va4W4NOvQegNB7iMnKzJhKFfJpEj0XS
         Yi3vAR5g5YbGcWE3BONv9feINe2WcX8c2NFXbZNEMPrx+45SI/gJp6X4t6vh//8PnT6n
         dE5Q6xxF1+8mEwQ370g22QepR6tznIJLx5XI8y2pLhkGx+t33L0CB+H8QXI0vu6DKsC0
         DPzogliilSztWZGhb7C88kERACUOPi8sr9nM/q++dJ+iPOhx3b65FNgRjZto52bU8P9K
         F2J7g25KWkIcP+YMEiSZJGWvDqxXDMsYIAGhIgKNCzEWMfKqjgpg9sENyPY0L+7/nT+d
         sCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FAjkIdGz/j9kJ1xDL5dYREJTueL8AT+RXQYxwRGY3ak=;
        b=LU525pljjSSiFgdQpHoBp5Ag3aZC9pSYaYfdwtQMfJrASyXsmGASDYILx8XKktVm48
         zeGoDk7dAOxIt70L+8/TqJDHTsyfZwTJfF3YRjZUtGXlLF8jajPmu/vEcXH9qxkaxeVA
         7Z6pJv5eETCXaSa+4PHtZjSC7qWN+EntdFJG7zACuommJzPDzrUr5U/w5a9Kyzm+NX4J
         /C9MT2q0z8X3ObENDMgawGDg4HUxei2Hb1yvTMkphEmxyZZfcnntpp5SNpcx/0GDuIti
         YiqfIZ6ZMesQCAEe4hxydlWpvT5HGkpHqUMRsLORhak5VwOTfqyJtHgl6rcIljPZVI9R
         wSWw==
X-Gm-Message-State: ACrzQf0RYtQzTEtGVbd44svc/re95MSYS8d4diiBQx7tdMJmb8QvjqTV
        /AbRbccHCS2FNxNRifMEhC3Pi+vtwAn1
X-Google-Smtp-Source: AMsMyM5JWY5Cagk3ev3ZTGWwFhYDrZbIwwHb/UZnn/RNqDB2WORgxG4dVfMFdU+Fkruz/OQNdmpNsqNDR3KX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cba6:8279:98e6:3d6e])
 (user=irogers job=sendgmr) by 2002:a0d:eac3:0:b0:36a:dfbf:3ee0 with SMTP id
 t186-20020a0deac3000000b0036adfbf3ee0mr64843865ywe.451.1668412334840; Sun, 13
 Nov 2022 23:52:14 -0800 (PST)
Date:   Sun, 13 Nov 2022 23:51:21 -0800
In-Reply-To: <20221114075127.2650315-1-irogers@google.com>
Message-Id: <20221114075127.2650315-4-irogers@google.com>
Mime-Version: 1.0
References: <20221114075127.2650315-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v1 3/9] perf tracepoint: Sort events in iterator
From:   Ian Rogers <irogers@google.com>
To:     Weilin Wang <weilin.wang@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xin Gao <gaoxin@cdjrlc.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

In print_tracepoint_events use tracing_events__scandir_alphasort and
scandir alphasort so that the subsystem and events are sorted and
don't need a secondary qsort. Locally this results in the following
change:

...
   ext4:ext4_zero_range                               [Tracepoint event]
-  fib6:fib6_table_lookup                             [Tracepoint event]
   fib:fib_table_lookup                               [Tracepoint event]
+  fib6:fib6_table_lookup                             [Tracepoint event]
   filelock:break_lease_block                         [Tracepoint event]
...

ie fib6 now is after fib and not before it. This is more consistent
with how numbers are more generally sorted, such as:

...
  syscalls:sys_enter_renameat                        [Tracepoint event]
  syscalls:sys_enter_renameat2                       [Tracepoint event]
...

and so an improvement over the qsort approach.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/print-events.c | 108 +++++++++++----------------------
 1 file changed, 37 insertions(+), 71 deletions(-)

diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index c4d5d87fae2f..fefc025bc259 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -66,26 +66,21 @@ static int cmp_string(const void *a, const void *b)
 void print_tracepoint_events(const char *subsys_glob,
 			     const char *event_glob, bool name_only)
 {
-	DIR *sys_dir, *evt_dir;
-	struct dirent *sys_dirent, *evt_dirent;
-	char evt_path[MAXPATHLEN];
-	char *dir_path;
-	char **evt_list = NULL;
-	unsigned int evt_i = 0, evt_num = 0;
-	bool evt_num_known = false;
-
-restart:
-	sys_dir = tracing_events__opendir();
-	if (!sys_dir)
-		return;
-
-	if (evt_num_known) {
-		evt_list = zalloc(sizeof(char *) * evt_num);
-		if (!evt_list)
-			goto out_close_sys_dir;
-	}
+	struct dirent **sys_namelist = NULL;
+	bool printed = false;
+	int sys_items = tracing_events__scandir_alphasort(&sys_namelist);
+
+	for (int i = 0; i < sys_items; i++) {
+		struct dirent *sys_dirent = sys_namelist[i];
+		struct dirent **evt_namelist = NULL;
+		char *dir_path;
+		int evt_items;
+
+		if (sys_dirent->d_type != DT_DIR ||
+		    !strcmp(sys_dirent->d_name, ".") ||
+		    !strcmp(sys_dirent->d_name, ".."))
+			continue;
 
-	for_each_subsystem(sys_dir, sys_dirent) {
 		if (subsys_glob != NULL &&
 		    !strglobmatch(sys_dirent->d_name, subsys_glob))
 			continue;
@@ -93,69 +88,40 @@ void print_tracepoint_events(const char *subsys_glob,
 		dir_path = get_events_file(sys_dirent->d_name);
 		if (!dir_path)
 			continue;
-		evt_dir = opendir(dir_path);
-		if (!evt_dir)
-			goto next;
 
-		for_each_event(dir_path, evt_dir, evt_dirent) {
-			if (event_glob != NULL &&
-			    !strglobmatch(evt_dirent->d_name, event_glob))
+		evt_items = scandir(dir_path, &evt_namelist, NULL, alphasort);
+		for (int j = 0; j < evt_items; j++) {
+			struct dirent *evt_dirent = evt_namelist[j];
+			char evt_path[MAXPATHLEN];
+
+			if (evt_dirent->d_type != DT_DIR ||
+			    !strcmp(evt_dirent->d_name, ".") ||
+			    !strcmp(evt_dirent->d_name, ".."))
 				continue;
 
-			if (!evt_num_known) {
-				evt_num++;
+			if (tp_event_has_id(dir_path, evt_dirent) != 0)
+				continue;
+
+			if (event_glob != NULL &&
+			    !strglobmatch(evt_dirent->d_name, event_glob))
 				continue;
-			}
 
 			snprintf(evt_path, MAXPATHLEN, "%s:%s",
 				 sys_dirent->d_name, evt_dirent->d_name);
-
-			evt_list[evt_i] = strdup(evt_path);
-			if (evt_list[evt_i] == NULL) {
-				put_events_file(dir_path);
-				goto out_close_evt_dir;
+			if (name_only)
+				printf("%s ", evt_path);
+			else {
+				printf("  %-50s [%s]\n", evt_path,
+				       event_type_descriptors[PERF_TYPE_TRACEPOINT]);
 			}
-			evt_i++;
+			printed = true;
 		}
-		closedir(evt_dir);
-next:
-		put_events_file(dir_path);
+		free(dir_path);
+		free(evt_namelist);
 	}
-	closedir(sys_dir);
-
-	if (!evt_num_known) {
-		evt_num_known = true;
-		goto restart;
-	}
-	qsort(evt_list, evt_num, sizeof(char *), cmp_string);
-	evt_i = 0;
-	while (evt_i < evt_num) {
-		if (name_only) {
-			printf("%s ", evt_list[evt_i++]);
-			continue;
-		}
-		printf("  %-50s [%s]\n", evt_list[evt_i++],
-				event_type_descriptors[PERF_TYPE_TRACEPOINT]);
-	}
-	if (evt_num && pager_in_use())
+	free(sys_namelist);
+	if (printed && pager_in_use())
 		printf("\n");
-
-out_free:
-	evt_num = evt_i;
-	for (evt_i = 0; evt_i < evt_num; evt_i++)
-		zfree(&evt_list[evt_i]);
-	zfree(&evt_list);
-	return;
-
-out_close_evt_dir:
-	closedir(evt_dir);
-out_close_sys_dir:
-	closedir(sys_dir);
-
-	printf("FATAL: not enough memory to print %s\n",
-			event_type_descriptors[PERF_TYPE_TRACEPOINT]);
-	if (evt_list)
-		goto out_free;
 }
 
 void print_sdt_events(const char *subsys_glob, const char *event_glob,
-- 
2.38.1.431.g37b22c650d-goog

