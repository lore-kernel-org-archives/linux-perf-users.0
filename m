Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9BFC6FA8E
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Mar 2023 04:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjCBEO0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 1 Mar 2023 23:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjCBENn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 1 Mar 2023 23:13:43 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34DB3E624
        for <linux-perf-users@vger.kernel.org>; Wed,  1 Mar 2023 20:13:41 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id g5-20020a25a485000000b009419f64f6afso2776046ybi.2
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Mar 2023 20:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677730418;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s8e2GbMOJCiKu31bRYD395XKtu1B0wMiO24x2A+fRDY=;
        b=Aqy8a7r86cYMeWfSGW4ApM7jCJHRfZfX6lC7MGITzZBZFk8BccoaKzvaKBEOPPT5OB
         nfNFTcCbajzSA10N/Bsznosyz9V/I9PYHFY9iZkv53xckgR/vBLv5Fa/n5EpjzYEQb9f
         N2ZFXeSQynryaBhzqg7m331cZpt+UsWZ/SfXSv+K2XoHzrVEOAoMDlquiKBgqS2D7vd7
         QjAxm3DeeXtAAMqkHttbbFO9w37uv3BPpYUfH5sHFjXV4qM64d4gN3eiG+RyJu+jRI86
         DUuwNpdvxXEixmNLix17/YVV2lXeT9dnMhiadzZf2JDJCvh+GCfhGf2TKTN+H+NTHG+B
         oc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677730418;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s8e2GbMOJCiKu31bRYD395XKtu1B0wMiO24x2A+fRDY=;
        b=xuLn+8Mvd2ccCe66Bs0l0E30wSOlvdwhNWedqOqsqOd2WC/mkQCnl0gcoVm/1fN/i8
         GEHWTg12uj4wGCyRx3oLYniNglEeLZUJf5yBfO5wFioCM/SSLfZMgm7hFnEeOHWMjBlo
         X7KyQWzpdFX3gp8sk5eCSfnsneSLXp0VGvvXRyDFiGaq9c4Mlv2E3l+BMWixdvGDKq8g
         FiH6kB9xtiBjzzw6+so2qrGXBmhCFY+zHUdVcNQXPZg4dl0u6gobpSxHUgZaHyBpsYNO
         VthBRPKOw47ZDxTykQ50s6bURR8Pw/EoP3yCegd/4TXto9qM1eBvJVbJnEHmS0+5nXHT
         tpTg==
X-Gm-Message-State: AO0yUKVT5jPWwPD9DyZzJDwg/H+6mQdURKnkr2YNIDfJ/vz2bdhYXJoK
        tdwGcIePrjzbtl2qXBYiDLjjX2BrBump
X-Google-Smtp-Source: AK7set/3Ple0PpXkqYIrXmPMzXDI7RYhZscTwrY6yWIaY05VqKoWtRvy3KcSVdAjUeCSIcoVWmRAIDoP/Kqz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:bdf9:f5cb:d05:c4d5])
 (user=irogers job=sendgmr) by 2002:a05:6902:88:b0:a27:3ecd:6 with SMTP id
 h8-20020a056902008800b00a273ecd0006mr532396ybs.1.1677730418420; Wed, 01 Mar
 2023 20:13:38 -0800 (PST)
Date:   Wed,  1 Mar 2023 20:12:09 -0800
In-Reply-To: <20230302041211.852330-1-irogers@google.com>
Message-Id: <20230302041211.852330-9-irogers@google.com>
Mime-Version: 1.0
References: <20230302041211.852330-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Subject: [PATCH v1 08/10] perf parse-events: Pass ownership of the group name
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
2.39.2.722.g9855ee24e9-goog

