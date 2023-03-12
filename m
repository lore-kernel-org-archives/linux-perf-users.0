Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26256C74A44
	for <linux-perf-users@archiver.kernel.org>; Sun, 12 Mar 2023 02:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjCLCQt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 11 Mar 2023 21:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjCLCQs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 11 Mar 2023 21:16:48 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989704DBDE
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Mar 2023 18:16:26 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e195-20020a25e7cc000000b00a1e59ba7ed9so9937853ybh.11
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Mar 2023 18:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678587386;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uXcDY77l4F8nFJ6IeFtiGZvS8C7nKH2bFLw1W06sHco=;
        b=hc9HjUv1Duu5eqI32NQsQb957q2Yi5F1MnFUk2WDfyyY6pd6G5MaWOks9wkXQE52+d
         ywMj3Due6PlliYPGeFp+m5sFAcj8GnV3ZjPcj6blk886sRPPiswr1v0g9y+Wdq3HUFrf
         WiSRViNbjvcEEdQt+CovLEdwambpkl7F0ohKh1F7veAzmJdtRsBTmlBlqpbjV9MFyG//
         cYrNO5mWKilWMY8VUnBkLEeUiZf7Y+gPoBPDJooS4TQkAYPj75g4FPN+WQ92ow+DxLDY
         J+EuT7YN7tFi8EEifKOG4iy48gFtfW8EAZan1zyvrpA4/GPICjjavLeIJOVLna6rZuda
         rg8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678587386;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uXcDY77l4F8nFJ6IeFtiGZvS8C7nKH2bFLw1W06sHco=;
        b=xh5I8o5iL3czWIC/ckRqAubH0mLMp0Jruk6sXhm3+baFDIM7lq1Wzlk+gmyYcNRgf1
         Mhq/ipV1T86h6fylxFtlZ7aJIkvNMukY3tzdDTkE2QOk9W0cwDljm/PKK5hNji25cE2E
         VhEn5xhjlm6kPqZ16MirGaTASfAFbvZSJrW4luPzCxOs2hqcz/C7nBoLK4t41wC7BC+1
         n69MymLKe57rQnfxUq6QwI1velUS/J0m9H9WElcbxX5/sS9BOT9dy/RQbTguTQaa0dOE
         WVxzMxsnWmMiIVCJO/o+aCfVJBSw2NqE5RX7oDbjDhAj6m9+ggVtUlaCc5f18tlBLrsB
         GObw==
X-Gm-Message-State: AO0yUKX9UCkcOsouVPNcHfwY5lci0iU02MPgynkuu4+Okxq33PBi9dP8
        4D9K0bncx2Ok1CfDW08wJJdEvm/Xsvig
X-Google-Smtp-Source: AK7set/x/A1I/b0OOUdLh84YVDmwWWkJLj2dgDbD/RHYWhQkb17EHDezeQNnJi1zEVZexigTUEwJYmvjF8xp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b42b:2e07:afb:877e])
 (user=irogers job=sendgmr) by 2002:a05:6902:188:b0:a99:de9d:d504 with SMTP id
 t8-20020a056902018800b00a99de9dd504mr18477824ybh.12.1678587385808; Sat, 11
 Mar 2023 18:16:25 -0800 (PST)
Date:   Sat, 11 Mar 2023 18:15:36 -0800
In-Reply-To: <20230312021543.3060328-1-irogers@google.com>
Message-Id: <20230312021543.3060328-5-irogers@google.com>
Mime-Version: 1.0
References: <20230312021543.3060328-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v5 04/11] perf stat: Modify the group test
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

Currently nr_members is 0 for an event with no group, however, they
are always a leader of their own group. A later change will make that
count 1 because the event is its own leader. Make the find_stat logic
consistent with this, an improvement suggested by Namhyung Kim.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-shadow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index ef85f1ae1ab2..eeccab6751d7 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -163,7 +163,7 @@ static double find_stat(const struct evsel *evsel, int aggr_idx, enum stat_type
 			continue;
 
 		/* Ignore evsels that are part of different groups. */
-		if (evsel->core.leader->nr_members &&
+		if (evsel->core.leader->nr_members > 1 &&
 		    evsel->core.leader != cur->core.leader)
 			continue;
 		/* Ignore evsels with mismatched modifiers. */
-- 
2.40.0.rc1.284.g88254d51c5-goog

