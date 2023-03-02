Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7705EC6FA8E
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Mar 2023 21:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjCBV4M (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 2 Mar 2023 16:56:12 -0500
Received: from mail-yw1-f201.google.com ([209.85.128.201]:39827 "EHLO
        mail-yw1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjCBV4J (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 2 Mar 2023 16:56:09 -0500
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-536cad819c7so4204457b3.6
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Mar 2023 13:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677794108;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pFZEua8oTOpEy63/43z9gHKJd5DuGh8paDEjQxW2aig=;
        b=cFrj3Q48z6/qxh19GHe2WXDLV1Hr44Yrec/3CZtEMProG1rkVYqkW8AVv5oQ2/LoeP
         J2DxzrljXCY7SFUcMJmd76NrZ4vSDlW7UIW1+80FDryXiDb5sachLus3hiOOWXlal9ev
         mUznon1KZeawu4C+zl5APZHvlwovEqOVg+05/c0iYH0A/kVegLUzlaqAPQlDVKeuocMn
         vGJ84MoOYcCMkmhFlPJNkaXCejgwHjLs32shiXSi8lxOYy05SYJHzvtbme40rzW/+scU
         FlHcVnEcH0crjgMx/fW+y127rdti++WWqTXTOZm7azPAr9Em7KOrlca6kj5QuqrZ+rfk
         B0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677794108;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pFZEua8oTOpEy63/43z9gHKJd5DuGh8paDEjQxW2aig=;
        b=ZUiAbT+INbaB/ukugXJU8mUBzXM10OCOxZ4vSgdx3Yh7MDXp6FhlCc6kxMcybBjXwk
         AsIxJq5quFQMSMOFS6NGM+eKRL84VceR5QB5/b5cz0tGdi4Ey78GcUK5Wl3xqaeR98Wd
         aOJi78zLy4k9eskPntE4x4Y74YS1zGmzoIWT4/sDaPfXqGsuTe5CJF9RCK2b4Swvrm+P
         F18D3jgZo7/8s3JsiZUvdrfafyWHk68hPKwUON+2HRwFq7ELT4YbKBAWOfADNYE6ZOUS
         45DRFMswS6vEosxTAPnl6r9grBcoDbAT3++4FzIH+5NUBgrF2fBvsTBv572nSDQX5MW/
         bIzQ==
X-Gm-Message-State: AO0yUKVreGWxk1tGmuCpv2SQeocFLMfxcz7+vunsxeviR7IHXxDktsBR
        hit1FjL6ucuuMW24hrxrRBgHPaaXeBTJ
X-Google-Smtp-Source: AK7set9TS9AIzk17qdo6XO2UQeX7T5f+JoZlvnDu9vwkLALw4z4bmxPkvoTtgbCu8K9raAkgAtQEfYVer3Cy
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:5f50:6ef4:b4d0:568e])
 (user=irogers job=sendgmr) by 2002:a81:5d89:0:b0:536:4aec:295d with SMTP id
 r131-20020a815d89000000b005364aec295dmr28ywb.453.1677792395505; Thu, 02 Mar
 2023 13:26:35 -0800 (PST)
Date:   Thu,  2 Mar 2023 13:25:27 -0800
In-Reply-To: <20230302212531.1043318-1-irogers@google.com>
Message-Id: <20230302212531.1043318-7-irogers@google.com>
Mime-Version: 1.0
References: <20230302212531.1043318-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Subject: [PATCH v2 06/10] perf evsel: Add function to compute pmu_name
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The computed pmu_name respects software events and aux event groups,
such that the pmu_name is changed to be that of the aux event leader
or group leader for software events. This is done as a later change
will split events that are in different PMUs into different groups.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 24 ++++++++++++++++++++++++
 tools/perf/util/evsel.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 2dc2c24252bb..9c6b486f8bd4 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -821,6 +821,30 @@ const char *evsel__name(struct evsel *evsel)
 	return "unknown";
 }
 
+const char *evsel__pmu_name(const struct evsel *evsel)
+{
+	const struct evsel *leader;
+
+	/* If the pmu_name is set use it. pmu_name isn't set for CPU and software events. */
+	if (evsel->pmu_name)
+		return evsel->pmu_name;
+	/*
+	 * Software events may be in a group with other uncore PMU events. Use
+	 * the pmu_name of the group leader to avoid breaking the software event
+	 * out of the group.
+	 *
+	 * Aux event leaders, like intel_pt, expect a group with events from
+	 * other PMUs, so substitute the AUX event's PMU in this case.
+	 */
+	leader  = evsel__leader(evsel);
+	if ((evsel->core.attr.type == PERF_TYPE_SOFTWARE || evsel__is_aux_event(leader)) &&
+	    leader->pmu_name) {
+		return leader->pmu_name;
+	}
+
+	return "cpu";
+}
+
 const char *evsel__metric_id(const struct evsel *evsel)
 {
 	if (evsel->metric_id)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 676c499323e9..72121194d3b1 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -280,6 +280,7 @@ int arch_evsel__hw_name(struct evsel *evsel, char *bf, size_t size);
 
 int __evsel__hw_cache_type_op_res_name(u8 type, u8 op, u8 result, char *bf, size_t size);
 const char *evsel__name(struct evsel *evsel);
+const char *evsel__pmu_name(const struct evsel *evsel);
 const char *evsel__metric_id(const struct evsel *evsel);
 
 static inline bool evsel__is_tool(const struct evsel *evsel)
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

