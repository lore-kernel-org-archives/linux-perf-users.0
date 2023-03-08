Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4BEC678D5
	for <linux-perf-users@archiver.kernel.org>; Wed,  8 Mar 2023 23:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjCHXAn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 8 Mar 2023 18:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjCHXAV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 8 Mar 2023 18:00:21 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DFFCDA08
        for <linux-perf-users@vger.kernel.org>; Wed,  8 Mar 2023 15:00:07 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id c192-20020a25c0c9000000b0092aabd4fa90so211528ybf.18
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Mar 2023 15:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678316406;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NBVnqvPJIWvW8Q6RkCDyc/WyuejWqbt8BpFQxOyzWTY=;
        b=sfF4NsXjNPzOlaCQv7Sz5Ye6go5SiEOXfFBrNpoTa+tZ1mK7YvK2WHLYREzhcgMpI3
         O4uIhQueBUkj5YvAUu+/Rz8+yEzlsmEXOxHL+JJM9DnIkWGiUxtyg6WcsWBBQukvJIvy
         QNQPuP71o2FUjndE4oEHU3jcJp0qGwAwpQdF4WNfZ+GyMC64nkYssNiJuPRoUcpxcb4/
         LovTvcUlEcuq1N7DQOqpIAFLfpd2sFCVioxBF+UvjhGarTlbyPVkCQyGAxisoM9aC4mM
         lD0r/P5VNHQMfr2Ci+MJAuZD4LkrVPlKCJQW+Vk6YtlgcHJkDWziRihb7g8A+yR7UleA
         fJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678316406;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NBVnqvPJIWvW8Q6RkCDyc/WyuejWqbt8BpFQxOyzWTY=;
        b=7wbyuyy0v3Qg9oVcsYj/Kh8/nDnYW8QzNIoqu8Awqau058QEAvmIn+UPy9Xz4OnPx/
         hYoFxamyUe+oap0FvAT76gJS2bTcB1qNWeSXnHlB0bpWMnIk07zkVNhFrxg/qfmJg1Ju
         MWm6TDdVEcgUn7H2uwmqzac/aLGFVUr5sd0SjC9GWJhhSL6EismDivrgGgDU2zM49Nz7
         fuQIiDmv/3K62M0v8qFdVBs2HVTtpJgIDhf1ENNrjZOpAJab9uGmcdaj4vAhCRHgiUOu
         Z2nXsr7hSa7ahp7mm2oGx0OsUu2vJO/676xyAAuDOfc/5tq4TIIKoxF4OIyPSWh1QnCW
         t19A==
X-Gm-Message-State: AO0yUKUjt7j/3QlgQNwZO0rQ9eLD9VuwTmeO1NDnHF88DLSiG+gjphHS
        r6vFJFdWzUSS+FFiE+OzOKQk3YTgC8uf
X-Google-Smtp-Source: AK7set8AqOtXzUp7XFpVbp5HX4AXJ5d5ACxWD32UiHn7PCmWWKmI2Gaz0M0s3lPu0FeQYTs1BqEWydYqpKP4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:5292:ba14:c261:246a])
 (user=irogers job=sendgmr) by 2002:a05:6902:208:b0:a98:bd27:91de with SMTP id
 j8-20020a056902020800b00a98bd2791demr11990629ybs.7.1678316406588; Wed, 08 Mar
 2023 15:00:06 -0800 (PST)
Date:   Wed,  8 Mar 2023 14:59:07 -0800
In-Reply-To: <20230308225912.1960990-1-irogers@google.com>
Message-Id: <20230308225912.1960990-7-irogers@google.com>
Mime-Version: 1.0
References: <20230308225912.1960990-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Subject: [PATCH v4 06/11] perf evsel: Add function to compute group PMU name
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
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

The computed name respects software events and aux event groups, such
that the pmu_name is changed to be that of the aux event leader or
group leader for software events. This is done as a later change will
split events that are in different PMUs into different groups.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 24 ++++++++++++++++++++++++
 tools/perf/util/evsel.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 2dc2c24252bb..51d9650267d0 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -821,6 +821,30 @@ const char *evsel__name(struct evsel *evsel)
 	return "unknown";
 }
 
+const char *evsel__group_pmu_name(const struct evsel *evsel)
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
index 676c499323e9..d26745ca6147 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -280,6 +280,7 @@ int arch_evsel__hw_name(struct evsel *evsel, char *bf, size_t size);
 
 int __evsel__hw_cache_type_op_res_name(u8 type, u8 op, u8 result, char *bf, size_t size);
 const char *evsel__name(struct evsel *evsel);
+const char *evsel__group_pmu_name(const struct evsel *evsel);
 const char *evsel__metric_id(const struct evsel *evsel);
 
 static inline bool evsel__is_tool(const struct evsel *evsel)
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

