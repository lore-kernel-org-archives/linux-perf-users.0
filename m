Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538DAC7EE2F
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Mar 2023 04:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjCBENS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 1 Mar 2023 23:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjCBENH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 1 Mar 2023 23:13:07 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8290930DD
        for <linux-perf-users@vger.kernel.org>; Wed,  1 Mar 2023 20:13:04 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5395c8fc4a1so256350237b3.5
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Mar 2023 20:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677730379;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6p++g9ByZAXMS3Dvltn2JIvavdr7joQqdokiBOJiUtQ=;
        b=qhQeVnOHT2BT7pic+pk3JZ4w8BJBvzwsXc7rELny5/AvmuDbl8L8m/9wQdEZbB/mor
         y8TyENCjW7SElSN8lQsKc2GZw71FtlNTvsy20UTGRX+aQuD0Lpbjie2oCldNDKOJPUkP
         AqnEiJKnc4uCb1wxgEoqDX/E7yf+aSVGur0xN8NGX08f5tMIUldUVoYEAWsdADKukm5o
         AGp8dZr13hJp/9qHX77kLUed1YdGKRCAws+HL0VtaqjqYhTGUP289mhg6q1hE9q8nQYv
         q1AGAvSSqvodsspwbFCfCMr7RXv0V2W19Xb8csNp2n9OLoxwp+qkTcwWPxBUZRnxC98x
         Sp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677730379;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6p++g9ByZAXMS3Dvltn2JIvavdr7joQqdokiBOJiUtQ=;
        b=HRERSWiG/412J0RHmmlwx6Qu96FdeJOu5T0R/wzd+pV9psYNSYyzUCtBrnoY2Sldue
         aFayxPObdpvo5CKJIJngc76KqAgD6Nc+eO0gshaBLovfGJFz/qlgCAl4nvlDHQgkaQUP
         5UICCH6m1lIEKJrIdRc7RKBrpNfNJ7kACiV5yrLz7zMuhCtveLZfu+1M7T3eSfdfUkOX
         pMqg59xnPfvCGPXTfil9yiQoK2bVoEyom914uE3BxWyCJabpz+H1tKz1dlaoFbhw9fmk
         WeYMrZGzE7eirU7fyc+WgVvfP0whB4mnwC39fJh6wo6RMXTF3BYJgU36ItbzYt74daX2
         AEiQ==
X-Gm-Message-State: AO0yUKXEo3nnCigYKK2jzxfipWajfOrBUBO/Zn1qS1Snp2/mTuaYTDNI
        mJEIWRJxBPQeU0CZBDORjODEuLHxi1L5
X-Google-Smtp-Source: AK7set9hc7gaYNkasaLKqPXkgWgdb5cYkrZfQsaV3EqDm98e8P3XGcJlrqeREyqQM8X/aB+MYnmOPJya/JYS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:bdf9:f5cb:d05:c4d5])
 (user=irogers job=sendgmr) by 2002:a25:8c0b:0:b0:a20:11a9:bd4a with SMTP id
 k11-20020a258c0b000000b00a2011a9bd4amr3801540ybl.0.1677730378917; Wed, 01 Mar
 2023 20:12:58 -0800 (PST)
Date:   Wed,  1 Mar 2023 20:12:04 -0800
In-Reply-To: <20230302041211.852330-1-irogers@google.com>
Message-Id: <20230302041211.852330-4-irogers@google.com>
Mime-Version: 1.0
References: <20230302041211.852330-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Subject: [PATCH v1 03/10] perf record: Early auxtrace initialization before
 event parsing
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

This allows event parsing to use the evsel__is_aux_event function,
which is important when determining event grouping.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/auxtrace.c | 17 +++++++++++++----
 tools/perf/builtin-record.c         |  6 ++++++
 tools/perf/util/auxtrace.h          |  2 ++
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/tools/perf/arch/x86/util/auxtrace.c b/tools/perf/arch/x86/util/auxtrace.c
index 3da506e13f49..de1e4842ea2e 100644
--- a/tools/perf/arch/x86/util/auxtrace.c
+++ b/tools/perf/arch/x86/util/auxtrace.c
@@ -15,6 +15,19 @@
 #include "../../../util/intel-bts.h"
 #include "../../../util/evlist.h"
 
+void auxtrace__early_init(void)
+{
+	struct perf_pmu *intel_pt_pmu;
+	struct perf_pmu *intel_bts_pmu;
+
+	intel_pt_pmu = perf_pmu__find(INTEL_PT_PMU_NAME);
+	if (intel_pt_pmu)
+		intel_pt_pmu->auxtrace = true;
+	intel_bts_pmu = perf_pmu__find(INTEL_BTS_PMU_NAME);
+	if (intel_bts_pmu)
+		intel_bts_pmu->auxtrace = true;
+}
+
 static
 struct auxtrace_record *auxtrace_record__init_intel(struct evlist *evlist,
 						    int *err)
@@ -26,11 +39,7 @@ struct auxtrace_record *auxtrace_record__init_intel(struct evlist *evlist,
 	bool found_bts = false;
 
 	intel_pt_pmu = perf_pmu__find(INTEL_PT_PMU_NAME);
-	if (intel_pt_pmu)
-		intel_pt_pmu->auxtrace = true;
 	intel_bts_pmu = perf_pmu__find(INTEL_BTS_PMU_NAME);
-	if (intel_bts_pmu)
-		intel_bts_pmu->auxtrace = true;
 
 	evlist__for_each_entry(evlist, evsel) {
 		if (intel_pt_pmu && evsel->core.attr.type == intel_pt_pmu->type)
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 8374117e66f6..a0870c076dc0 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -3940,6 +3940,10 @@ static int record__init_thread_masks(struct record *rec)
 	return ret;
 }
 
+__weak void auxtrace__early_init(void)
+{
+}
+
 int cmd_record(int argc, const char **argv)
 {
 	int err;
@@ -3985,6 +3989,8 @@ int cmd_record(int argc, const char **argv)
 	if (err)
 		return err;
 
+	auxtrace__early_init();
+
 	argc = parse_options(argc, argv, record_options, record_usage,
 			    PARSE_OPT_STOP_AT_NON_OPTION);
 	if (quiet)
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 29eb82dff574..49a86aa6ac94 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -457,6 +457,8 @@ struct addr_filters {
 
 struct auxtrace_cache;
 
+void auxtrace__early_init(void);
+
 #ifdef HAVE_AUXTRACE_SUPPORT
 
 u64 compat_auxtrace_mmap__read_head(struct auxtrace_mmap *mm);
-- 
2.39.2.722.g9855ee24e9-goog

