Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D144BC4167D
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Nov 2022 18:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237850AbiKNSNq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 14 Nov 2022 13:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238388AbiKNSNk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Nov 2022 13:13:40 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9F923BC7
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Nov 2022 10:13:38 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id bq9-20020a056a000e0900b00571802a2eaaso5862246pfb.22
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Nov 2022 10:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FAjkIdGz/j9kJ1xDL5dYREJTueL8AT+RXQYxwRGY3ak=;
        b=DAt71PWrjoITyAdCRE+Lj7mQUuYa3hVc6OS4Titnc+6zDLr3m+IeSlbkwTB6xk6oAd
         AU8DRW0kfELM38hqTfMjyQNKlY+Dh0CKMtbk4hcok0lcIPw/QATk/mSHf91CbDRs8LzN
         05NmLbPTsgxnyzdeNLFGxmNsbHYmt23xWbDfE8JADZ7xCzr1vbbZJvQismQ10uBBliui
         f5uPz/rLFtmacHATZY8F028mZc4jctekE3UW+E8OpgRaKLJiqA3KSUJjss3XJ2ly9Sv7
         b1DcSaDPmU7fPr2aZrVhVVFpBLVwI3bzM1TuY3iI1Pvn+sqF4U3YlbiFZhh7OzavwCud
         RjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FAjkIdGz/j9kJ1xDL5dYREJTueL8AT+RXQYxwRGY3ak=;
        b=xaRGSqZ/vcaxhug/f/6MIspjvRStXzO/7OftOEa8oYoYwBH17CUJ34spCK+XFrVCAo
         D6HbzAKILzJ8nn9KmT7huUEsbK7PmlvV5VAj1JPegC1KY9sZgkNIaJ7KDAl5pxgmlYKr
         vsxpZSDFzDL0094xavQC6JGNdwi8nx26wDK1l2vHFmTK+k2PRXs5EWQIFEx4ISRgaWRr
         0njcKDw4v41aZmgm++G0eelLSqfyi2rVHzKtkBI7Dk8Dyw+1M5wrzmqg7DXseh5WFPGN
         K7RkOi4XXQimTG7eI39z0Rsz+mkciHh2NCBmEZmpDocJBlQHDb590uvBxhBtRp6umGUH
         LNEQ==
X-Gm-Message-State: ANoB5pluXhVye2C4Yr8ONR022qcTLYCqt0/euCa66tY7Ah+33JZtwr34
        2mQ3dcdGOLJjAAHaD7mX7MoZOm/CyhuY
X-Google-Smtp-Source: AA0mqf7malxvbgoC6c+8CWumNqmJRYnC9BDfjyV6zPhBgMR9mlhbG4r9/ZYBE2aMoHw2HcLrlmW5IEBZldcS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:553:438f:b86a:87f])
 (user=irogers job=sendgmr) by 2002:a62:f245:0:b0:56c:3696:ad5f with SMTP id
 y5-20020a62f245000000b0056c3696ad5fmr14860112pfl.30.1668449617898; Mon, 14
 Nov 2022 10:13:37 -0800 (PST)
Date:   Mon, 14 Nov 2022 10:12:45 -0800
In-Reply-To: <20221114181251.2683871-1-irogers@google.com>
Message-Id: <20221114181251.2683871-4-irogers@google.com>
Mime-Version: 1.0
References: <20221114181251.2683871-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v2 3/9] perf tracepoint: Sort events in iterator
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

