Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6671CC7EE2E
	for <linux-perf-users@archiver.kernel.org>; Sat, 27 May 2023 03:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjE0Dnr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 May 2023 23:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjE0Dnp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 May 2023 23:43:45 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0A0FB
        for <linux-perf-users@vger.kernel.org>; Fri, 26 May 2023 20:43:43 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-2562fbb193bso812313a91.1
        for <linux-perf-users@vger.kernel.org>; Fri, 26 May 2023 20:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685159023; x=1687751023;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6LNFgpANWxclZfBQXN09BDTHOQ1Q2FmhmEUjxzQcKoQ=;
        b=M8gRdZwcYSReKulMtU0M6CnxWVgvH2I6XPogufA7q910crmXUeW0QuwrxlUvUFs7zv
         +PxA7rcqQbFioYAEvSRzcqGXuCiGMEwBk+M3wV+Xvrrjvgnk5KcowEjcF+Ki5GyPaMBx
         /iXEdQYbmAAD9kGE7wb1ESERjkC2x69dgmdwlAb3vOvbGi6HW95EuL9oWbeE5M41ngIv
         55kfOJso0tbfEIg7HEY5g9wSrr9KAHRj8TjT6lL6+NlB8wzmaTnzSMUsQdzfbPOWK/nr
         lnaDmVJjgWSfRmQdRdkZfd7JuWUxPrH/zoqJwDePppJBDHzbLUoo4hZijHWDkkOwc4vL
         vM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685159023; x=1687751023;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6LNFgpANWxclZfBQXN09BDTHOQ1Q2FmhmEUjxzQcKoQ=;
        b=h0ThrDT0zVvnsgeibzZvi9Y/YGRb6iG6aD9s8Cm32rUbX6k+2PcHNUbb9lTUp6qTy0
         hoYs6RJv5IlknIg5izv40mbDCRw/DrTnBIWupjtMCtJyi+Gly0kXp33B5zX47oMTpfpA
         cRZOBn7uRZmU/L4nW98jR1xqBtD2P48lYakJwBEZkKSPHGdKbxYZHf97mns85pMVbdwq
         PanD9PYCCEdnUIRaG16OgeOkykgYs5CojE1k89IBLgfCTnJ1d9X2No91LfX9U02oTth2
         b0kLAj9zGJ0kw84skWXuRwh+B0Qsvkrt6jsF4p9qukO0yLlAAzzq2AgPwRLrNDlu8KJm
         mjGQ==
X-Gm-Message-State: AC+VfDzTVMSY7tW94AjgKGdBLuO4oAgqNmmBpRXIpj+BVI2X6IM1Iycn
        P3VWgFMigJEMUf+4fN1mkXNtw4Mz63q2
X-Google-Smtp-Source: ACHHUZ6P92HLgMuSv7U9cMBYIS6/tm/9qWP4Dk6tYLuWOhZrZHhNrXMo0E9rCtfGDsRNkUbHuC00vgizK/rc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a17:90a:9904:b0:246:6a3a:6aec with SMTP id
 b4-20020a17090a990400b002466a3a6aecmr929999pjp.4.1685159023392; Fri, 26 May
 2023 20:43:43 -0700 (PDT)
Date:   Fri, 26 May 2023 20:43:19 -0700
In-Reply-To: <20230527034324.2597593-1-irogers@google.com>
Message-Id: <20230527034324.2597593-2-irogers@google.com>
Mime-Version: 1.0
References: <20230527034324.2597593-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v1 1/4] perf sched: Avoid large stack allocations
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Commit 5ded57ac1bdb ("perf inject: Remove static variables") moved
static variables to local, however, in this case 3 MAX_CPUS (4096)
sized arrays were moved onto the stack making the stack frame quite
large. Avoid the stack usage by dynamically allocating the arrays.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-sched.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index cc4ba506e119..2aeb3c8ac396 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -193,8 +193,8 @@ struct perf_sched {
  * weird events, such as a task being switched away that is not current.
  */
 	struct perf_cpu	 max_cpu;
-	u32		 curr_pid[MAX_CPUS];
-	struct thread	 *curr_thread[MAX_CPUS];
+	u32		 *curr_pid;
+	struct thread	 **curr_thread;
 	char		 next_shortname1;
 	char		 next_shortname2;
 	unsigned int	 replay_repeat;
@@ -224,7 +224,7 @@ struct perf_sched {
 	u64		 run_avg;
 	u64		 all_runtime;
 	u64		 all_count;
-	u64		 cpu_last_switched[MAX_CPUS];
+	u64		 *cpu_last_switched;
 	struct rb_root_cached atom_root, sorted_atom_root, merged_atom_root;
 	struct list_head sort_list, cmp_pid;
 	bool force;
@@ -3599,7 +3599,22 @@ int cmd_sched(int argc, const char **argv)
 
 	mutex_init(&sched.start_work_mutex);
 	mutex_init(&sched.work_done_wait_mutex);
-	for (i = 0; i < ARRAY_SIZE(sched.curr_pid); i++)
+	sched.curr_thread = calloc(MAX_CPUS, sizeof(*sched.curr_thread));
+	if (!sched.curr_thread) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	sched.cpu_last_switched = calloc(MAX_CPUS, sizeof(*sched.cpu_last_switched));
+	if (!sched.cpu_last_switched) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	sched.curr_pid = malloc(MAX_CPUS * sizeof(*sched.curr_pid));
+	if (!sched.curr_pid) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	for (i = 0; i < MAX_CPUS; i++)
 		sched.curr_pid[i] = -1;
 
 	argc = parse_options_subcommand(argc, argv, sched_options, sched_subcommands,
@@ -3668,6 +3683,9 @@ int cmd_sched(int argc, const char **argv)
 	}
 
 out:
+	free(sched.curr_pid);
+	free(sched.cpu_last_switched);
+	free(sched.curr_thread);
 	mutex_destroy(&sched.start_work_mutex);
 	mutex_destroy(&sched.work_done_wait_mutex);
 
-- 
2.41.0.rc0.172.g3f132b7071-goog

