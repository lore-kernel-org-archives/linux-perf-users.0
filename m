Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5423C6FA8E
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Mar 2023 04:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjCBEOV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 1 Mar 2023 23:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjCBENf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 1 Mar 2023 23:13:35 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0609512074
        for <linux-perf-users@vger.kernel.org>; Wed,  1 Mar 2023 20:13:33 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5376fa4106eso302254337b3.7
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Mar 2023 20:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677730410;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/xN8iuJv1MwmAnYiwxUStUWtntqNOPw9NdTU5dZ4INM=;
        b=AvkU0jrks7LC3k+CG51zaJjxNiUmWOkBDUXwqMuaTkpPnvWrtSWjLG+i9D6LB3phPJ
         dd+Jyg27C0Ak5OqjBpy/965D6LNvaRQxe3AJO4JJFFdJ11PEuAi2/KtZQh8nVDK2bLY+
         M2jL2FLqYS5Nr7K3JAP3yzvJYIPFR42JsGjoAFwAJJuzkTVRACFJ6N4Kl65cL+D1Bafy
         f77PtaJ2NzAR9HmuH0Fr2FROhhNQKBqapDIpRzyXHxQTbqMpV3k3apHOLV0Dy6FjyUCW
         xGxWDZ2Hm1mnixNeJddZyJcY3Xfq9ICe1bS+SUaFLBKpLz4fnuX20UdQu6vwcshlyimJ
         l5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677730410;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/xN8iuJv1MwmAnYiwxUStUWtntqNOPw9NdTU5dZ4INM=;
        b=NxtaF9aVB+BIz+3dYFgP/OTcKE4n4ODLZRUa2EGZAmY9ongv8k/X8YJWg3ku4PJ2SK
         CtVU91VBWMTZw6VA0OM80DOQ8Q5RmYQh+MQ2A9/Amhfb8i5Fe7f3ujun9n/Q8pIVLYs5
         Jv4MtwN+mfCiRbLPI26qKRNbHyp8PhatTLqWzDAEUFQjKjwxXtQYpaE/O0c9teyqHNW8
         MdI9vZ9dwKF/tW8BSM6bFIUXSJkVZ4NeE3uM71g7Itlzg499H4S+T93iRqsN9K5e2dAD
         mt+Nr6CBqRQ/9wijca+e+HS8dAPEp1YZ2tZ7mzyK01Ei5Agwfom2FMPxoqv+Eq0zJ+Vi
         9djg==
X-Gm-Message-State: AO0yUKWLruMm7DhW8EcWZX9b7MB4q5Lxb80bmdDyvwEelC9m0kzYaCv8
        Qj4AMzRJ1Eim7Fxy8N6FGDN50uKKBOAs
X-Google-Smtp-Source: AK7set/LhGMjABxvayYzpREccFiH3hj+NJM9GUP/aPbn5ocwVtCFBMRnbM1lX1csQTDnx4DarH6rYnJl0reU
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:bdf9:f5cb:d05:c4d5])
 (user=irogers job=sendgmr) by 2002:a81:4515:0:b0:534:eef8:caa9 with SMTP id
 s21-20020a814515000000b00534eef8caa9mr5430233ywa.8.1677730410545; Wed, 01 Mar
 2023 20:13:30 -0800 (PST)
Date:   Wed,  1 Mar 2023 20:12:08 -0800
In-Reply-To: <20230302041211.852330-1-irogers@google.com>
Message-Id: <20230302041211.852330-8-irogers@google.com>
Mime-Version: 1.0
References: <20230302041211.852330-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Subject: [PATCH v1 07/10] perf evsel: Add function to compute pmu_name
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
        Qi Liu <liuqi115@huawei.com>,
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
2.39.2.722.g9855ee24e9-goog

