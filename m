Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FC4C6FA8E
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Mar 2023 04:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjCBENs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 1 Mar 2023 23:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjCBENZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 1 Mar 2023 23:13:25 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD053E624
        for <linux-perf-users@vger.kernel.org>; Wed,  1 Mar 2023 20:13:16 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 66-20020a250245000000b00a53c1100d72so2755780ybc.0
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Mar 2023 20:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677730395;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jg6IMjGjrVTTIu+EnMv4tDRbAkAbegs9QpsJAAuMpXw=;
        b=QdXTTG18tvoaUzogomQ8IIMRWYDh50wm0SYSRSBjt8mOk3Mpeny67Ubc1ihJTdykF8
         DtsvcjA0gRqZZnG16lTL7kpIw2xBrixZQg237a4JC+rVUDSl1eclwqN7PIGj5SZ8aukh
         t7JcobuwABd+/XgGeYwksYa6zcuizId/cCnYnNQPmHVfoTwZ0VKPTvotFmiSTvPAEuGP
         8n8okejR1xp5fh4wrNO4fO//Y/xur6xE4Fdpnt9WuAfgs6/qI449eCWr6bYjdizl0xfb
         d3bfq4fZCS5zkNYCp5TtB/sk+gJ2z5KLFtvcpqkZ87TerCmAdJFwyBedv1rl/BvC73ck
         NwoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677730395;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jg6IMjGjrVTTIu+EnMv4tDRbAkAbegs9QpsJAAuMpXw=;
        b=wEl38Z/mYqpS4KbA20fhkSTEZwIBmBWKHd+Rpcmd5xGAe7/5mYgQVu9jfcdw0KvQ9N
         RsnLOlThn0Cx7EO6T5dAPQ1jrSKDvBC9kvEWueiSa/RN5Y3zd43Zfj+bCu5dNmhYMasW
         kYOQuttS1pSHdJIU9bcl4noiVNoRNZ+yC0dalzUwNoaPgthI7ueJz+SsxQk1rzFV8FnD
         UxM/wUXPZjoIj+azGd16Hqersfds/azMo6eoe5Ov3rWIyaOPBL0NZMy84tfcmMlB5zEb
         54SswPiG+UU/tkHbkaCLIKdKpKvE5Q7/Q0q0wDqdCooY83gpJscW4SGkWw7AjfZkwDNT
         1Y0A==
X-Gm-Message-State: AO0yUKWsqj+Hsh9iZjSjK5AvPZeD2HFEGrQ3dbH7g5xgQZY/BBX8b8OR
        PxWxA7WygLzu+H7ecGWp3GOlSEiFB7cA
X-Google-Smtp-Source: AK7set9P5DIrE8EDR9jHyHpnOnI0Wv+Z6sn3ZEJdpyDXMfyvZtibiEi/ZiqElPkqWnMdN5n+DzbaLShxV84k
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:bdf9:f5cb:d05:c4d5])
 (user=irogers job=sendgmr) by 2002:a25:fb0e:0:b0:ad0:a82:7ef2 with SMTP id
 j14-20020a25fb0e000000b00ad00a827ef2mr900496ybe.8.1677730394822; Wed, 01 Mar
 2023 20:13:14 -0800 (PST)
Date:   Wed,  1 Mar 2023 20:12:06 -0800
In-Reply-To: <20230302041211.852330-1-irogers@google.com>
Message-Id: <20230302041211.852330-6-irogers@google.com>
Mime-Version: 1.0
References: <20230302041211.852330-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Subject: [PATCH v1 05/10] perf evsel: Limit in group test to CPUs
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

Don't just match on the event name, restict based on the PMU too.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/evsel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
index ea3972d785d1..580b0a172136 100644
--- a/tools/perf/arch/x86/util/evsel.c
+++ b/tools/perf/arch/x86/util/evsel.c
@@ -61,6 +61,9 @@ bool arch_evsel__must_be_in_group(const struct evsel *evsel)
 	if (!evsel__sys_has_perf_metrics(evsel))
 		return false;
 
+	if (evsel->pmu_name && strncmp(evsel->pmu_name, "cpu", 3))
+		return false;
+
 	return evsel->name &&
 		(strcasestr(evsel->name, "slots") ||
 		 strcasestr(evsel->name, "topdown"));
-- 
2.39.2.722.g9855ee24e9-goog

