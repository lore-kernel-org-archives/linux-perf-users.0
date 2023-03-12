Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5629CC74A44
	for <linux-perf-users@archiver.kernel.org>; Sun, 12 Mar 2023 02:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjCLCR3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 11 Mar 2023 21:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjCLCRY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 11 Mar 2023 21:17:24 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D74F39BA0
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Mar 2023 18:16:53 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id be9-20020a170902aa0900b0019f33b12bcdso917154plb.15
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Mar 2023 18:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678587409;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rAHr1Ym6m8HDaHWKquUTUVzIVoHfjpMPERLVKzK3KKk=;
        b=c6h0GsVHgKGDH1bcn7dxWPUgQfME7wApLuocb4Vg1jAr0QTtoPc8e9f0zRcXnzmDDZ
         xy7Oum6JHYQGP16fOo9sgIa+V6zKtAWjoU8HFlTqpKye6XjeqWwSaRK/3VqzagDG4/wb
         u4Udxv4YQorgEuOfWfTvH3ymWelcv44KtfMGAAvfqO3NLdFPRNQKHUCdpBFnVkdUAHsQ
         N7N8OPs6ZvFYSn4+SpJ4VjlV7cmWeIdP3R/g4Ne4dFWN98kzF1yHMcfqxsOGUnIaiOCu
         NOWWL8IHYQvlGvcWP+HMLRdWvQCWB/uEVWTsTuN/nLgEnHQ5nM1WiaLfxpyxDzPYxEfT
         buRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678587409;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rAHr1Ym6m8HDaHWKquUTUVzIVoHfjpMPERLVKzK3KKk=;
        b=XixZuyfpLLZFLebRU1t2iFkNaE8alIdjash7vD9BY1CQj7Mq82zfIUIBD3qYt1NCh2
         FDsIAJlYrAWd7uhfN+oyOIi+A+sM0ghxesvL+g+0wU7ktrONb4iACD7fl/VMvfEGgbBN
         J5gaL/kx0RVFGOQ5TtYGxDEuJ+LkpiUIUJ4Bxuxx6lrWsd/fm7yuzYoBrDLi2pmun41a
         2J74lGw6omVBM4g0K+wB7HqwuQMfewfspBHHQE7kKh9VoJLHaQMq0p/ZhoTANoX+JAOZ
         TwYeH437Ww8jH32fglM5nI8rWy6ZJm5BGMWgE0w5dmA0jtxXRscypn5voowMXwEQb9Rb
         RkOg==
X-Gm-Message-State: AO0yUKXpOlGq5BTjpn2649cNF/c/XcJKzlcUKoOHVPrAadQa3TYV2XTj
        7wMfKPTOSKyaqTxTpe0Dtev4t0Ui72ZL
X-Google-Smtp-Source: AK7set89GTn3xlU//DaHxsNTMW5n8cfLHRpRjrEJ4zsc3vMEzoFODRhs4WHPl8Qk3HhTDo7CO2zZ03Wlmv35
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b42b:2e07:afb:877e])
 (user=irogers job=sendgmr) by 2002:a62:8607:0:b0:619:46b3:7903 with SMTP id
 x7-20020a628607000000b0061946b37903mr10924410pfd.3.1678587408990; Sat, 11 Mar
 2023 18:16:48 -0800 (PST)
Date:   Sat, 11 Mar 2023 18:15:39 -0800
In-Reply-To: <20230312021543.3060328-1-irogers@google.com>
Message-Id: <20230312021543.3060328-8-irogers@google.com>
Mime-Version: 1.0
References: <20230312021543.3060328-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v5 07/11] perf parse-events: Pass ownership of the group name
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

Pass ownership of the group name rather than copying and freeing the
original. This saves a memory allocation and copy.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 3 ++-
 tools/perf/util/parse-events.y | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 0336ff27c15f..1be454697d57 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1761,6 +1761,7 @@ parse_events__set_leader_for_uncore_aliase(char *name, struct list_head *list,
 
 handled:
 	ret = 1;
+	free(name);
 out:
 	free(leaders);
 	return ret;
@@ -1786,7 +1787,7 @@ void parse_events__set_leader(char *name, struct list_head *list,
 
 	leader = arch_evlist__leader(list);
 	__perf_evlist__set_leader(list, &leader->core);
-	leader->group_name = name ? strdup(name) : NULL;
+	leader->group_name = name;
 	list_move(&leader->core.node, list);
 }
 
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index be8c51770051..541b8dde2063 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -202,8 +202,8 @@ PE_NAME '{' events '}'
 	struct list_head *list = $3;
 
 	inc_group_count(list, _parse_state);
+	/* Takes ownership of $1. */
 	parse_events__set_leader($1, list, _parse_state);
-	free($1);
 	$$ = list;
 }
 |
-- 
2.40.0.rc1.284.g88254d51c5-goog

