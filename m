Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC39AC7618E
	for <linux-perf-users@archiver.kernel.org>; Sat, 29 Apr 2023 05:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjD2Ftq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 29 Apr 2023 01:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjD2Ftp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 29 Apr 2023 01:49:45 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7149C
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Apr 2023 22:49:02 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-556f4e20131so13578237b3.1
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Apr 2023 22:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682747333; x=1685339333;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jM7vst5DIFoMzXwuvX7sLg/ZL9kiwCaMvQ9X5dcPg1U=;
        b=OjwP5ejRI30I8Zr1ucxpnsBBaHZx0yO8pLWb+Q3Z0FHklEUB25RpMLmMScdX9d+BPo
         xEc1aM7i056R/yMwK2dq0U5D/M5ZyNVNC90YGpV+2bhpWVwHnL7W2kzgdjSYWPsaWDmp
         lbgys7RQL6N8FOq3XCI0cbSKCctJWCqAvu0a+XsNA2E4YzigsmDZqLCS0496fvZIsMZ3
         4cwnOxCiI3+2fiyuP+BcSasPrYTaLWDlLUoMPxUqpVF03pZz1J1dnwx0ZFjuKRGcyMeN
         KvMTgL7vpmV54N3q0lgB0GTG7J/cW3PuxK1DgKFk9PbxInwnYPMPa/ljZLaJrgd3erwE
         GILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682747333; x=1685339333;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jM7vst5DIFoMzXwuvX7sLg/ZL9kiwCaMvQ9X5dcPg1U=;
        b=l3fe9FIO1KqDcxnqxvdpIunt1BqXzCQucV9W/Dx8UxcaOz3ZGl7Olrf8sz6ttg2cIY
         4spEbBowH6fu+h3mQK0WznGnBQTTZ74Q3VYXtmlASd2MbUTmsWTKreg7aqzUJ50B+qyV
         RUWSjmZHOMAVZJmXFtLcPMre5HdgyeYgBysw5C0HHMYr+pJ5CroPqeGqxFNv/3rDiN8L
         dua3dmV4vuQf/ee8HuoYnLn+cm5F/qW5KbzJjp8Mc/eSVMV2MkafcK0WW806fC5F2HK8
         GF5KI7UriYxF2DCLlownd6iUA5Tj+8zRHRCEiKoy9EdsPzHESBk/jmjzlZgOAmX9FfKS
         WkFw==
X-Gm-Message-State: AC+VfDx5h/AbKh+Ora5KRa0Ze2U/4Q5W948SAXoOfwJDQ3hC1AGAdurg
        S+PQUm+wN3Dyg3n8aFBCx425BFQkFHVc
X-Google-Smtp-Source: ACHHUZ7BCcp9VlVRMNE/uM9WoxchVPcw3iJF1o8Em6z3X1jrQYIZNxvBFzrehb5qz7MMtg6fp+FtmE7fXhAY
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c563:7e28:fb7c:bce3])
 (user=irogers job=sendgmr) by 2002:a25:947:0:b0:b9d:8612:a8bd with SMTP id
 u7-20020a250947000000b00b9d8612a8bdmr705401ybm.4.1682746820024; Fri, 28 Apr
 2023 22:40:20 -0700 (PDT)
Date:   Fri, 28 Apr 2023 22:34:56 -0700
In-Reply-To: <20230429053506.1962559-1-irogers@google.com>
Message-Id: <20230429053506.1962559-37-irogers@google.com>
Mime-Version: 1.0
References: <20230429053506.1962559-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v3 36/46] perf parse-events: Avoid error when assigning a term
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
$ perf stat -e 'cycles/name=name/' true
event syntax error: 'cycles/name=name/'
                                \___ parser error
'''
by turning the term back to a string if it is on the right. Add PMU
and generic parsing tests.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c | 21 +++++++++++++++++++++
 tools/perf/util/parse-events.c  |  9 +++++++++
 tools/perf/util/parse-events.h  |  3 +++
 tools/perf/util/parse-events.y  |  8 ++++++++
 4 files changed, 41 insertions(+)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 49166d51c0a1..449d7a1780f4 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1485,6 +1485,16 @@ static int test__sym_event_dc(struct evlist *evlist)
 	return TEST_OK;
 }
 
+static int test__term_equal_term(struct evlist *evlist)
+{
+	struct evsel *evsel = evlist__first(evlist);
+
+	TEST_ASSERT_VAL("wrong type", evsel->core.attr.type == PERF_TYPE_HARDWARE);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
+	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "name") == 0);
+	return TEST_OK;
+}
+
 #ifdef HAVE_LIBTRACEEVENT
 static int count_tracepoints(void)
 {
@@ -1857,6 +1867,11 @@ static const struct evlist_test test__events[] = {
 		.check = test__exclusive_group,
 		/* 7 */
 	},
+	{
+		.name  = "cycles/name=name/",
+		.check = test__term_equal_term,
+		/* 8 */
+	},
 };
 
 static const struct evlist_test test__events_pmu[] = {
@@ -2038,6 +2053,12 @@ static const struct evlist_test test__events_pmu[] = {
 		.check = test__exclusive_group,
 		/* 9 */
 	},
+	{
+		.name  = "cpu/cycles,name=name/",
+		.valid = test__pmu_cpu_valid,
+		.check = test__term_equal_term,
+		/* 0 */
+	},
 };
 
 struct terms_test {
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index dea27bc0b376..5d5d77fa398b 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2581,6 +2581,15 @@ int parse_events_term__str(struct parse_events_term **term,
 	return new_term(term, &temp, str, 0);
 }
 
+int parse_events_term__term(struct parse_events_term **term,
+			    int term_lhs, int term_rhs,
+			    void *loc_term, void *loc_val)
+{
+	return parse_events_term__str(term, term_lhs, NULL,
+				      strdup(config_term_names[term_rhs]),
+				      loc_term, loc_val);
+}
+
 int parse_events_term__clone(struct parse_events_term **new,
 			     struct parse_events_term *term)
 {
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 7fe80b416143..2a8cafe0ee8f 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -148,6 +148,9 @@ int parse_events_term__num(struct parse_events_term **term,
 int parse_events_term__str(struct parse_events_term **term,
 			   int type_term, char *config, char *str,
 			   void *loc_term, void *loc_val);
+int parse_events_term__term(struct parse_events_term **term,
+			    int term_lhs, int term_rhs,
+			    void *loc_term, void *loc_val);
 int parse_events_term__clone(struct parse_events_term **new,
 			     struct parse_events_term *term);
 void parse_events_term__delete(struct parse_events_term *term);
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 819a5123fd77..0aaebc57748e 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -848,6 +848,14 @@ PE_TERM '=' PE_TERM_HW
 	$$ = term;
 }
 |
+PE_TERM '=' PE_TERM
+{
+	struct parse_events_term *term;
+
+	ABORT_ON(parse_events_term__term(&term, (int)$1, (int)$3, &@1, &@3));
+	$$ = term;
+}
+|
 PE_TERM '=' PE_VALUE
 {
 	struct parse_events_term *term;
-- 
2.40.1.495.gc816e09b53d-goog

