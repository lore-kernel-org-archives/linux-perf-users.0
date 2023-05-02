Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5E7C7EE21
	for <linux-perf-users@archiver.kernel.org>; Tue,  2 May 2023 22:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjEBWyd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 2 May 2023 18:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjEBWyX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 2 May 2023 18:54:23 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6BA3C05
        for <linux-perf-users@vger.kernel.org>; Tue,  2 May 2023 15:53:44 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-55a3f6a29edso971457b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 May 2023 15:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683067963; x=1685659963;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aRrQWfMbhp+rlO4pd/8kREfyV/ueQNA+MFq0luWCz2E=;
        b=uH8dLLHV9VAkcbnRVoJsJuOEduNrj0iGNP3KCy/ymDzqpYFajcjSeUA7gGnrCcTw85
         0TaLt2UY5fsVtJ7coUldx5rwZYX0Rdg3ZmGuj5kU2rrP8PjN8QZrgJ9cY9ZVTsdzcxI8
         SXalSvCcFqrpjZ2geAhtgrHRWitvVS1RjRWDeN5kFGCU+Pm2A6G1UVywsZQpoBfY5nA3
         MysLaft0D1kRNv9cqcZefif9H+X5msp5AzsYF3m1xZusK9AuPzYMGpZ0eNBEb6hJc+YF
         bE4+0hE6N5Tx6mWK+s9/Rxsb9xHURuS1NmmOBtKp/CPZTjwgijLOaWbbTfpttenWPN+a
         Cq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683067963; x=1685659963;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aRrQWfMbhp+rlO4pd/8kREfyV/ueQNA+MFq0luWCz2E=;
        b=g+9JrDF2jWzJGhAE4dkzq0hwOl1xrTWMbbbvr7Z6SrmgBk6H2IxK27SndM6ygrirVf
         KNe/YvSViRSrDvcPmachPwT1PMji494W+96KbFU+zYP5LvtNZ4PC/ZkxGOmEXZMz/RE4
         YfzUxZZtapnZNeH20HN5wPpjZL+uuFXjviink4lvHt4Nq7k+cw0IWXpoKEqrZkcIShbc
         oeiTXnNAkomlQE+RNud3Vh3By+/FkHiSwCtzraoiQOvRjvOJFPS3siikW9YqrO2jsn9j
         D3zaZ1ICwO8s/mW6vBpMFD7Z6K11mcWE0N1PpG6jl/yBOsMUbR8+amxHj3HoKQfIa6Jj
         ZtRQ==
X-Gm-Message-State: AC+VfDxxexJqocehPbEkKktg9dN0r6z9Dv+MsTweRkCBxknv6hWXYM8W
        L+7Vfc05WYwBwYBRdYN0IULACGzZA9rN
X-Google-Smtp-Source: ACHHUZ6l6yQT0eNizaa54wKMpaY+fppvn7gI2uSsn6yH/Kk1CrNSxJL7CW+d6Nmv2hlVj0VFHbeLUspxXl1Q
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e70c:446b:d23b:982e])
 (user=irogers job=sendgmr) by 2002:a17:903:408d:b0:1a9:7f45:8711 with SMTP id
 z13-20020a170903408d00b001a97f458711mr8155plc.6.1683067402755; Tue, 02 May
 2023 15:43:22 -0700 (PDT)
Date:   Tue,  2 May 2023 15:38:42 -0700
In-Reply-To: <20230502223851.2234828-1-irogers@google.com>
Message-Id: <20230502223851.2234828-36-irogers@google.com>
Mime-Version: 1.0
References: <20230502223851.2234828-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v4 35/44] perf parse-events: Avoid error when assigning a
 legacy cache term
From:   Ian Rogers <irogers@google.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Avoid the parser error:
'''
$ perf stat -e 'cycles/name=l1d/' true
event syntax error: 'cycles/name=l1d/'
                                \___ parser error
'''
by combining the name and legacy cache cases in the parser.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c | 21 +++++++++++++++++++++
 tools/perf/util/parse-events.y  | 10 ++++++----
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index eb893cc15878..72a10bed84fd 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1509,6 +1509,16 @@ static int test__term_equal_term(struct evlist *evlist)
 	return TEST_OK;
 }
 
+static int test__term_equal_legacy(struct evlist *evlist)
+{
+	struct evsel *evsel = evlist__first(evlist);
+
+	TEST_ASSERT_VAL("wrong type", evsel->core.attr.type == PERF_TYPE_HARDWARE);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
+	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "l1d") == 0);
+	return TEST_OK;
+}
+
 #ifdef HAVE_LIBTRACEEVENT
 static int count_tracepoints(void)
 {
@@ -1886,6 +1896,11 @@ static const struct evlist_test test__events[] = {
 		.check = test__term_equal_term,
 		/* 8 */
 	},
+	{
+		.name  = "cycles/name=l1d/",
+		.check = test__term_equal_legacy,
+		/* 9 */
+	},
 };
 
 static const struct evlist_test test__events_pmu[] = {
@@ -2073,6 +2088,12 @@ static const struct evlist_test test__events_pmu[] = {
 		.check = test__term_equal_term,
 		/* 0 */
 	},
+	{
+		.name  = "cpu/cycles,name=l1d/",
+		.valid = test__pmu_cpu_valid,
+		.check = test__term_equal_legacy,
+		/* 1 */
+	},
 };
 
 struct terms_test {
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 0aaebc57748e..f4ee03b5976b 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -82,7 +82,7 @@ static void free_list_evsel(struct list_head* list_evsel)
 %type <str> PE_EVENT_NAME
 %type <str> PE_KERNEL_PMU_EVENT PE_PMU_EVENT_FAKE
 %type <str> PE_DRV_CFG_TERM
-%type <str> name_or_raw
+%type <str> name_or_raw name_or_legacy
 %destructor { free ($$); } <str>
 %type <term> event_term
 %destructor { parse_events_term__delete ($$); } <term>
@@ -739,6 +739,8 @@ event_term
 
 name_or_raw: PE_RAW | PE_NAME | PE_LEGACY_CACHE
 
+name_or_legacy: PE_NAME | PE_LEGACY_CACHE
+
 event_term:
 PE_RAW
 {
@@ -752,7 +754,7 @@ PE_RAW
 	$$ = term;
 }
 |
-name_or_raw '=' PE_NAME
+name_or_raw '=' name_or_legacy
 {
 	struct parse_events_term *term;
 
@@ -826,7 +828,7 @@ PE_TERM_HW
 	$$ = term;
 }
 |
-PE_TERM '=' PE_NAME
+PE_TERM '=' name_or_legacy
 {
 	struct parse_events_term *term;
 
@@ -872,7 +874,7 @@ PE_TERM
 	$$ = term;
 }
 |
-name_or_raw array '=' PE_NAME
+name_or_raw array '=' name_or_legacy
 {
 	struct parse_events_term *term;
 
-- 
2.40.1.495.gc816e09b53d-goog

