Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20682C77B7E
	for <linux-perf-users@archiver.kernel.org>; Thu, 25 May 2023 07:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238957AbjEYHNq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 25 May 2023 03:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239428AbjEYHMs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 25 May 2023 03:12:48 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F6C10E6
        for <linux-perf-users@vger.kernel.org>; Thu, 25 May 2023 00:12:34 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5655d99da53so6064907b3.0
        for <linux-perf-users@vger.kernel.org>; Thu, 25 May 2023 00:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684998748; x=1687590748;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+m2pnwk7ltDlRfODCcS98B4qxXpyD/wmySMIwUeQIa0=;
        b=3I/660dhM9lZf9IEkWxnK7nkFcSifm+MxTnqZxo1HIHPCMgFuczZTKQKko9pimGaAR
         KW+h/lWcmmDUB+9Qg7oBkaoKx7ICAG0RlJufytpXp6OVeIbXCyTzUHolDfuCumgGvmdB
         LIs+TiP23mCsJk1FwJnI7NvdstKE0tOdKgPoDgWX2fj72g3/uk9lYvD+BF0NVW7zAfwh
         ryxOat6Q2JryQ6iERzMFybbEGHGN5Qsa3RdbftPt6jhgxH2bmxeTSnHUn1MFemcbjrJ9
         ya4+m/9d4ZsQ2u2J6Yy911kLOaCi6VzjXq5eQ7ZVVuAiaul5sFY0NqAfbNfBgFUjqpD9
         wNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684998748; x=1687590748;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+m2pnwk7ltDlRfODCcS98B4qxXpyD/wmySMIwUeQIa0=;
        b=j/L0MSXTMMobqfrDrATK96lW066faaNASnXwpluNqwr52eXJN9DpkTzcYQ0KLE6zCt
         JjPdJxwB7aYA8GL+x2DN9XW0qat24Esop0be+a7IDlykmoq/qnbTwUTmFangia+IYJhi
         5Jq/84m4MRhICn/hXqZC3By0OSVnL9V8GIsaHf1DybwfI1k5+NxLWr1FwlGyvJS/7re5
         ejXpuQl6p2irFdD3hXlp9lAY60A3fWKVR21DUjmqHnk+vS3W+NoSC5oIJy9vSdpqYkEe
         P35izypcu5MwZBdxe6z+FcARmJX2RcvDrPFbBMzt2M15sX607NecoUKI3h2t2BSwu1Ki
         6gYg==
X-Gm-Message-State: AC+VfDyX/d33egVxu4rufaxneVmfmnkY+1lip6PFNYrROWBrMOBm7Fdb
        k3pPLB7FKOFAVEJnO4hHQb10qUXqHoW3
X-Google-Smtp-Source: ACHHUZ56MPxsMx36Wz7nvFDJJuJBcGPxPIUE7ojVvrebDC27lXhEXg5YoRdSUiYt0XDG5gOoxyZPnmchi5ws
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a81:ac07:0:b0:561:8c16:2b66 with SMTP id
 k7-20020a81ac07000000b005618c162b66mr1514887ywh.4.1684998748115; Thu, 25 May
 2023 00:12:28 -0700 (PDT)
Date:   Thu, 25 May 2023 00:11:30 -0700
In-Reply-To: <20230525071133.2066610-1-irogers@google.com>
Message-Id: <20230525071133.2066610-14-irogers@google.com>
Mime-Version: 1.0
References: <20230525071133.2066610-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v1 13/16] perf scripting-engines: Move static to local variable
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
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Ross Zwisler <zwisler@chromium.org>,
        Leo Yan <leo.yan@linaro.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Avoid 16,384 bytes in .bss by stack allocating two bitmaps.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/scripting-engines/trace-event-perl.c   | 4 ++--
 tools/perf/util/scripting-engines/trace-event-python.c | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/perf/util/scripting-engines/trace-event-perl.c
index 039d0365ad41..65b761d83a1f 100644
--- a/tools/perf/util/scripting-engines/trace-event-perl.c
+++ b/tools/perf/util/scripting-engines/trace-event-perl.c
@@ -67,8 +67,6 @@ INTERP my_perl;
 #define TRACE_EVENT_TYPE_MAX				\
 	((1 << (sizeof(unsigned short) * 8)) - 1)
 
-static DECLARE_BITMAP(events_defined, TRACE_EVENT_TYPE_MAX);
-
 extern struct scripting_context *scripting_context;
 
 static char *cur_field_name;
@@ -353,7 +351,9 @@ static void perl_process_tracepoint(struct perf_sample *sample,
 	void *data = sample->raw_data;
 	unsigned long long nsecs = sample->time;
 	const char *comm = thread__comm_str(thread);
+	DECLARE_BITMAP(events_defined, TRACE_EVENT_TYPE_MAX);
 
+	bitmap_zero(events_defined, TRACE_EVENT_TYPE_MAX);
 	dSP;
 
 	if (evsel->core.attr.type != PERF_TYPE_TRACEPOINT)
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 41d4f9e6a8b7..40964078f92f 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -93,8 +93,6 @@ PyMODINIT_FUNC PyInit_perf_trace_context(void);
 #define TRACE_EVENT_TYPE_MAX				\
 	((1 << (sizeof(unsigned short) * 8)) - 1)
 
-static DECLARE_BITMAP(events_defined, TRACE_EVENT_TYPE_MAX);
-
 #define N_COMMON_FIELDS	7
 
 static char *cur_field_name;
@@ -934,6 +932,9 @@ static void python_process_tracepoint(struct perf_sample *sample,
 	unsigned long long nsecs = sample->time;
 	const char *comm = thread__comm_str(al->thread);
 	const char *default_handler_name = "trace_unhandled";
+	DECLARE_BITMAP(events_defined, TRACE_EVENT_TYPE_MAX);
+
+	bitmap_zero(events_defined, TRACE_EVENT_TYPE_MAX);
 
 	if (!event) {
 		snprintf(handler_name, sizeof(handler_name),
-- 
2.40.1.698.g37aff9b760-goog

