Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B56CEE49B0
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Aug 2023 08:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbjHWILQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Aug 2023 04:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbjHWIJl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Aug 2023 04:09:41 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AADF10E6
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Aug 2023 01:08:50 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58cbf62bae8so68857057b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Aug 2023 01:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692778129; x=1693382929;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OGsb2LJqZ8wAIRiG/qrlIeUwXu2dut6icoftip7LD1w=;
        b=t7YWKvAyigj8U88vk9f3zOUQnRe0+b3J74n4CDXzBteW3I6pYJXXR3X4wv9hcSCGPK
         HdLYN1nTnmFe57Yb0PNC7k4jNp63jzNq8DXg95C6tZsPRVzQ+8UjQF0O3Md3Hy6WFbeX
         v5ruAEg3gWg6ml7nI2MFuQ8cNC+CWl4ukTlx/uGz7efHl6GCm6X//Rs9ldYMbS+xJ057
         7F+4xnc6BAObK0Ud5VIGYQBumNhm76UAe6RWs1pGhPeW2fREfsNwRybKcSZjNRVGtRn5
         INunjtywsNnnGa3c4T8LhOdkVicDIFucaS74sMk6Wi6CN6Es+bP+zvplupFsEHzJcCKy
         EK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692778129; x=1693382929;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OGsb2LJqZ8wAIRiG/qrlIeUwXu2dut6icoftip7LD1w=;
        b=IV5ciHhr0H8PH0xzd9BwVaeyz2DlkTHhj7iNBcLz/6QsPYBZmCno6x7j2y4G1fhzC2
         FnWZB6FxF3Txauhj2JrFjKg0SLPCyMCwVOjDnFRjlxqME1VpGZyiFkf2vJhN/PxfgoaS
         5zuzbh9aQas52qltw/yyi2oDJjzcIri91U0iqpM2WBEbEHcVsDJWKVlulpz5rlO4ixXb
         PkU9g69LnlW5qYJSlSMJUsFCmx515k6PBoi1xIWBGHuuJvyd/Lvl6ei24UoVaUbMW52A
         3AgZyFzr2JMCBJgsn7vEB6wNv3aZavOtBENn4BjW3UNNo1ICfBF0orH0gpf/zO6jMdN1
         wRiA==
X-Gm-Message-State: AOJu0YwpvSqhtzQykiJTHBZWNXb8PSJ+xonmT81+UK7vtvEsnPpS8iI/
        JuGMbBTVJk/gB3p/kZxr5A/EMfRD9k+W
X-Google-Smtp-Source: AGHT+IFXZyc0ktV2s4ZqpFXnx//sQPxDg35HOEfPLbOvB8QvWhBnjMa0znczpxLSbhGfW7nZZyGA5vrNKAeR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3971:e84:f508:9a36])
 (user=irogers job=sendgmr) by 2002:a81:4318:0:b0:57a:141f:b4f7 with SMTP id
 q24-20020a814318000000b0057a141fb4f7mr150466ywa.6.1692778129476; Wed, 23 Aug
 2023 01:08:49 -0700 (PDT)
Date:   Wed, 23 Aug 2023 01:08:10 -0700
In-Reply-To: <20230823080828.1460376-1-irogers@google.com>
Message-Id: <20230823080828.1460376-8-irogers@google.com>
Mime-Version: 1.0
References: <20230823080828.1460376-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Subject: [PATCH v1 07/25] perf pmu: Avoid passing format list to perf_pmu__format_bits
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
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Rob Herring <robh@kernel.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Pass the pmu so the format list can be better abstracted and later
lazily loaded.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/intel-pt.c | 7 +++----
 tools/perf/util/parse-events.c      | 2 +-
 tools/perf/util/pmu.c               | 6 +++---
 tools/perf/util/pmu.h               | 2 +-
 4 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 0da76f848cbc..27944c15ac14 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -122,7 +122,7 @@ static int intel_pt_read_config(struct perf_pmu *intel_pt_pmu, const char *str,
 
 	*res = 0;
 
-	mask = perf_pmu__format_bits(&intel_pt_pmu->format, str);
+	mask = perf_pmu__format_bits(intel_pt_pmu, str);
 	if (!mask)
 		return -EINVAL;
 
@@ -346,8 +346,7 @@ static int intel_pt_info_fill(struct auxtrace_record *itr,
 	intel_pt_parse_terms(intel_pt_pmu, "tsc", &tsc_bit);
 	intel_pt_parse_terms(intel_pt_pmu, "noretcomp", &noretcomp_bit);
 	intel_pt_parse_terms(intel_pt_pmu, "mtc", &mtc_bit);
-	mtc_freq_bits = perf_pmu__format_bits(&intel_pt_pmu->format,
-					      "mtc_period");
+	mtc_freq_bits = perf_pmu__format_bits(intel_pt_pmu, "mtc_period");
 	intel_pt_parse_terms(intel_pt_pmu, "cyc", &cyc_bit);
 
 	intel_pt_tsc_ctc_ratio(&tsc_ctc_ratio_n, &tsc_ctc_ratio_d);
@@ -502,7 +501,7 @@ static int intel_pt_val_config_term(struct perf_pmu *intel_pt_pmu, int dirfd,
 
 	valid |= 1;
 
-	bits = perf_pmu__format_bits(&intel_pt_pmu->format, name);
+	bits = perf_pmu__format_bits(intel_pt_pmu, name);
 
 	config &= bits;
 
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 8ede27089766..7d9d687d9191 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1162,7 +1162,7 @@ static int get_config_chgs(struct perf_pmu *pmu, struct list_head *head_config,
 			type = perf_pmu__format_type(pmu, term->config);
 			if (type != PERF_PMU_FORMAT_VALUE_CONFIG)
 				continue;
-			bits |= perf_pmu__format_bits(&pmu->format, term->config);
+			bits |= perf_pmu__format_bits(pmu, term->config);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_CONFIG:
 			bits = ~(u64)0;
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 96189afe54b0..1839c3668ec5 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1000,7 +1000,7 @@ void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evsel,
 	if (term)
 		user_bits = term->val.cfg_chg;
 
-	bits = perf_pmu__format_bits(&pmu->format, config_name);
+	bits = perf_pmu__format_bits(pmu, config_name);
 
 	/* Do nothing if the user changed the value */
 	if (bits & user_bits)
@@ -1023,9 +1023,9 @@ pmu_find_format(struct list_head *formats, const char *name)
 	return NULL;
 }
 
-__u64 perf_pmu__format_bits(struct list_head *formats, const char *name)
+__u64 perf_pmu__format_bits(struct perf_pmu *pmu, const char *name)
 {
-	struct perf_pmu_format *format = pmu_find_format(formats, name);
+	struct perf_pmu_format *format = pmu_find_format(&pmu->format, name);
 	__u64 bits = 0;
 	int fbit;
 
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 1ea78d2fa531..1249fca02ffd 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -221,7 +221,7 @@ int perf_pmu__config_terms(struct perf_pmu *pmu,
 			   struct perf_event_attr *attr,
 			   struct list_head *head_terms,
 			   bool zero, struct parse_events_error *error);
-__u64 perf_pmu__format_bits(struct list_head *formats, const char *name);
+__u64 perf_pmu__format_bits(struct perf_pmu *pmu, const char *name);
 int perf_pmu__format_type(struct perf_pmu *pmu, const char *name);
 int perf_pmu__check_alias(struct perf_pmu *pmu, struct list_head *head_terms,
 			  struct perf_pmu_info *info);
-- 
2.42.0.rc1.204.g551eb34607-goog

