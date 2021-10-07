Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC495C4332F
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 16:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1BE761248
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 16:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243046AbhJGRBA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 7 Oct 2021 13:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243042AbhJGRAd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Oct 2021 13:00:33 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC51C061778
        for <linux-perf-users@vger.kernel.org>; Thu,  7 Oct 2021 09:58:18 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id x16-20020a25b910000000b005b6b7f2f91cso8812868ybj.1
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Oct 2021 09:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=A5ojQafQUWecZV0zK32YyWS1qatBb2iruuAkEA0ocTI=;
        b=q+/hm3pda9jEyneBmerZYc7HQ14ZVMTGDuuUdAIAB7X1oCq4dGJSDzzmdKoYTDOWRM
         i26WMxyQLvs6Zha3iDR6u1uTv90ljKuyHJCFPa9jJDZT7hcwZEaT4t8iQgDQTnXR8DZ3
         wkABLzT3FW0y1n3U+SRZsO+Mq1zjNVJd9wRunNyaBtlj8BGGqQaLrhxIJi2Z23zriabP
         fm/Jnl8OkT5t35JKMzYecsugrH+1bqeV3fhhJdIWsUxd3Ek4L37to4oJX/NcC9TmrI8S
         JJ83u1q2vUkEXrHW0Ob+KfEQXN6w9fmn8B+nI2ywdQPMJecZUn6qieIn4Vy/pz9abdBi
         QRmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=A5ojQafQUWecZV0zK32YyWS1qatBb2iruuAkEA0ocTI=;
        b=j8mL4qsBn0W9S1SxVZfmGgaArGG95tHQ1VeYeluY9vGTZ2zzqv5kGyC9oGw5LFsyPf
         ifRjAt0pIJrHn0v3opi51KRqYAlUaxreBMEhTEVdFncyBIa0zJb7QGAvQfGNZvy6tLj1
         DB3+1Z25o63PTgiomWEUy6pVTk2lL1m72bYbLozPrM5xsSocrQfXKnOhc0uG/MuF2sFP
         8q7prTI6Kd2rwqiS6KgLOSaHYH1YoivWBHW4QSPwi9EsgJidT9paNhPHWIAU+tAxxgIg
         rxJUhYwx+rps5PllrhibXNlSrWbyh80NnR6hY2g7KzHEW7/91Eu0absqSjku9GBuvQg+
         ws8A==
X-Gm-Message-State: AOAM5319XIvkLCjezHXAW7inYWaiQ0fxu1XG0/4zgM/NxTK0URZRjqnk
        iPbeaFQHL49rS3BmRfNaRB6y1Rr/LU+q
X-Google-Smtp-Source: ABdhPJwf9eTt97ZGCrzEVO14m/DtmR7dL8lvW2DRvPeaDUFZn0dgxdjFUlkJ+ZPxEwj+GbDz4mfnhjduoALF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:fe85:5e36:cb6f:76bc])
 (user=irogers job=sendgmr) by 2002:a25:bd7:: with SMTP id 206mr6347937ybl.408.1633625897889;
 Thu, 07 Oct 2021 09:58:17 -0700 (PDT)
Date:   Thu,  7 Oct 2021 09:56:46 -0700
In-Reply-To: <20211007165647.3514803-1-irogers@google.com>
Message-Id: <20211007165647.3514803-21-irogers@google.com>
Mime-Version: 1.0
References: <20211007165647.3514803-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH 20/21] perf parse-events: Identify broken modifiers.
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        ToastC <mrtoastcheng@gmail.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Felix Fietkau <nbd@nbd.name>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Song Liu <songliubraving@fb.com>, Fabian Hemmer <copy@copy.sh>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Nicholas Fraser <nfraser@codeweavers.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Denys Zagorui <dzagorui@cisco.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Changbin Du <changbin.du@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Previously the broken modifier causes a usage message to printed but
nothing else. After:

$ perf stat -e 'cycles:kk' -a sleep 2
event syntax error: 'cycles:kk'
                            \___ Bad modifier
Run 'perf list' for a list of valid events

 Usage: perf stat [<options>] [<command>]

    -e, --event <event>   event selector. use 'perf list' to list available events

$ perf stat -e '{instructions,cycles}:kk' -a sleep 2
event syntax error: '..ns,cycles}:kk'
                                  \___ Bad modifier
Run 'perf list' for a list of valid events

 Usage: perf stat [<options>] [<command>]

    -e, --event <event>   event selector. use 'perf list' to list available events

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.y | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 17c8c66f3f51..2d60f3cbe42b 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -183,6 +183,11 @@ group_def ':' PE_MODIFIER_EVENT
 	err = parse_events__modifier_group(list, $3);
 	free($3);
 	if (err) {
+		struct parse_events_state *parse_state = _parse_state;
+		struct parse_events_error *error = parse_state->error;
+
+		parse_events__handle_error(error, @3.first_column,
+					   strdup("Bad modifier"), NULL);
 		free_list_evsel(list);
 		YYABORT;
 	}
@@ -240,6 +245,11 @@ event_name PE_MODIFIER_EVENT
 	err = parse_events__modifier_event(list, $2, false);
 	free($2);
 	if (err) {
+		struct parse_events_state *parse_state = _parse_state;
+		struct parse_events_error *error = parse_state->error;
+
+		parse_events__handle_error(error, @2.first_column,
+					   strdup("Bad modifier"), NULL);
 		free_list_evsel(list);
 		YYABORT;
 	}
-- 
2.33.0.882.g93a45727a2-goog

