Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803A3C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Oct 2021 17:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D2A360E8B
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Oct 2021 17:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237516AbhJORZ1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 15 Oct 2021 13:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237530AbhJORZF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 15 Oct 2021 13:25:05 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E0CC061797
        for <linux-perf-users@vger.kernel.org>; Fri, 15 Oct 2021 10:22:26 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i83-20020a256d56000000b005b706d1417bso11970153ybc.6
        for <linux-perf-users@vger.kernel.org>; Fri, 15 Oct 2021 10:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/ICUTnn0+DHTkHe1Sa2FAQhyptinzYEiREIP815vWD4=;
        b=ox/64JkrW3jXnk0RlnPstVbJFZZOWV3tK2cfmCw971N9LjBbHfNBWvjw3tzgdVpa87
         woqDGI40TwCac71jo1uzm/id843f45ebpMXnd3/XpRMtF4gCA2dSze7kvzugn620pELl
         eInwgQH9RWGQ3Qk6FsLczjzFBLZ3JH85Wnf81HfUq6i3PVWekKD8fOUdrN0qWx/85Vse
         TkvMEdvS+UeDOlsJc5ik0CqWM3mUZ21qFjrxGZSVpWoNVPlUJjOx1lkyZZqF12fd1THy
         3rIuIKhBBSicB7eBx15dqNtdtmf/xrGJWdWv98mdBWhV+qa2c/ztylfokA4JmXnGLjOi
         mqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/ICUTnn0+DHTkHe1Sa2FAQhyptinzYEiREIP815vWD4=;
        b=bJPc08RWECWPoXsiJKYVh8TN0lQfiQYTV5kdi18WyXauIRirT6u6Gjshr0NZYv/5L6
         Bd0tD+fbfsvEOhC0J/AnFB/4rpxA2NW2F2Wb8ASBNq/s0ZtaoF1g/pWpjiQ1vIp7aaFy
         wy/6BrfAWGlcxsBlJYlufg4edn0F9FB17Hug/XrzXuZk+6L640NoAntW+JJI72GXAZQr
         DQrE6owX7csYqRaxsArbV56Hz7DI62zmK/tSMxkgz3gkbCREbK98T2bMg70LPOoBBOUH
         CmwqIuLeGHOOZTLOyfKvK2MOfKHDaWHsgc9XSRVNTYeTxpZPlTgYuTiJn+O5y25TFJRM
         zY5w==
X-Gm-Message-State: AOAM533xQBxHq5QM+BBB1aeX9dhAgGiyC4xr4/pHHAD+0isF/Cit1En1
        OsOz5+T/8/by3nFc6UQCergc+YMImQes
X-Google-Smtp-Source: ABdhPJyRvhfP6Pti3om40J5PlAGhQdTzAtJhyOQrTQmoqLGVrVv0UmBqe6DMFNqwyDbIQvwRrVluyeeeD8HY
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:69bc:7451:58ad:6585])
 (user=irogers job=sendgmr) by 2002:a25:5b8b:: with SMTP id
 p133mr14099440ybb.273.1634318545867; Fri, 15 Oct 2021 10:22:25 -0700 (PDT)
Date:   Fri, 15 Oct 2021 10:21:31 -0700
In-Reply-To: <20211015172132.1162559-1-irogers@google.com>
Message-Id: <20211015172132.1162559-21-irogers@google.com>
Mime-Version: 1.0
References: <20211015172132.1162559-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2 20/21] perf parse-events: Identify broken modifiers.
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
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andrew Kilroy <andrew.kilroy@arm.com>
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

Acked-by: Andi Kleen <ak@linux.intel.com>
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
2.33.0.1079.g6e70778dc9-goog

