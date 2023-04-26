Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA9FC77B78
	for <linux-perf-users@archiver.kernel.org>; Wed, 26 Apr 2023 07:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239796AbjDZHHh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 26 Apr 2023 03:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239788AbjDZHHB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 26 Apr 2023 03:07:01 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C869D49D5
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Apr 2023 00:05:38 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b92309d84c1so33262311276.1
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Apr 2023 00:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682492720; x=1685084720;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hpUWqNL0tOEngg8yuOrwHuZx1oPdLKlDkdLSWdUpIbg=;
        b=H9/xEHdW0rbpUs3lnjyxtiTbkIPJvy45jI5bNCaQPJo7vROp1aYS4E18+wfVQV82Qy
         j0FIxLbIcEUcPtGUyVocFYIdkKDh4uuJdpKACCWaGEW4r4F4t8c+3DTCFrZvjIEYW4cx
         N1ZOy5xgym5ozlXvMxx4zWMhgRKcALQqN4mZsWmiXMS3Ys9jx/oTtXw0P19LYhv8/MjQ
         Fx+hE5SGi0osuaFG6gEQSEEkZbWmOS98PJl7TZT44f1hwKns4ZuqP9OIiCkkVsjOyN/G
         znipYkwiznoLaGWoIciso6WZkT+Q0/p/7Ed6MKk3n+5dv8cW22TvFEsn+AokubsjPIzZ
         4qgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682492720; x=1685084720;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hpUWqNL0tOEngg8yuOrwHuZx1oPdLKlDkdLSWdUpIbg=;
        b=DjEK1LlUvRhNs9tmP6sGKsExof3hK76NfEbrzBgihbFslBDDbCSCfgUH69a58MYCc3
         ZqOYkYYQvlasYM8F057kXT42pvYD7OKih+ALe20tXB2rvhF+AeZmD7GjyPsDHi8Qpjo3
         aIgwAbNVDA7C5F4iFALEFEZ972DhUBR1Q6n2jn4B+y+2sypbwWbGGFw/lIQ+lKOblXGi
         MtKodhOGkvVz0AALhIa8ge1tcbJPwDn3oKqlTo9yhmWziSpUNUxHlLDfBwMIWY1z/eDI
         yaGNgUan+ZMte6M3SQCntPYP6b3J0WJB7+0ZbtZfOHNYLGC+i7sGHQrlZwBwFsJ1+rLG
         nJnw==
X-Gm-Message-State: AC+VfDyDpmt2ZfBg9bQ+r2MEHhpyE3FjkDta3iIORRo/GnWgHqOutiGh
        1c1rnyFQV3oXCDP1UyRJSKkqGPxPCJMS
X-Google-Smtp-Source: ACHHUZ65Ydc2KtN7BWaC/ktnakyD7s40B2e42pMLpiPw3w+MRMRsBxzYMRNaXC4/qxOnDGXQtCDs+HCM1Gdc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:144f:e890:2b29:48d9])
 (user=irogers job=sendgmr) by 2002:a81:25c1:0:b0:556:aa28:f9c5 with SMTP id
 l184-20020a8125c1000000b00556aa28f9c5mr944980ywl.2.1682492719959; Wed, 26 Apr
 2023 00:05:19 -0700 (PDT)
Date:   Wed, 26 Apr 2023 00:00:41 -0700
In-Reply-To: <20230426070050.1315519-1-irogers@google.com>
Message-Id: <20230426070050.1315519-32-irogers@google.com>
Mime-Version: 1.0
References: <20230426070050.1315519-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v1 31/40] perf parse-events: Avoid error when assigning a term
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
index 4c21bef882ff..06042f450ece 100644
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
index 27c179323b6d..98e424257278 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2578,6 +2578,15 @@ int parse_events_term__str(struct parse_events_term **term,
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

