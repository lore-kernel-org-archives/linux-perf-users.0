Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE79C678D5
	for <linux-perf-users@archiver.kernel.org>; Wed,  8 Mar 2023 23:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjCHXAx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 8 Mar 2023 18:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjCHXA3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 8 Mar 2023 18:00:29 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3804D3335
        for <linux-perf-users@vger.kernel.org>; Wed,  8 Mar 2023 15:00:14 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id x64-20020a25ce43000000b00ae6d5855d78so233043ybe.12
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Mar 2023 15:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678316414;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dcvWMdLTJ1iuXhAaTLlBF3OqMzr4/MuwhIZh3sQrcPM=;
        b=PZRWXsWyADHy4mHeUXfY7eIe/xrWmdkDJrMwb2jSMuPSbFIhhmJzZ1o0/wjrUqNstt
         cqtNrNIfM5xuzRRHpDGe9KgHWeCS1PN7gzn2xt4jLpq06QR2klOwgxB7GtHWAUsCwqPI
         eoEqtmRdgmFINGPcsI+w4704lHFMvDkZYFWvALIWLS+RVWM7dHzTFEMpNTjSkjgpeNqI
         6HjGyK4aGU+gEF6gYHMayjhtdhdJHW44d2PA0zp2OGqdyXV/QRp78bXUC15kbkUb70n9
         vwfjR2VH6Y+by5dQIfLTsh1tb49rv8CQbdFX3gw+M1+dzhmJhSI1wpR7BCmJsH/QHzdq
         HUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678316414;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dcvWMdLTJ1iuXhAaTLlBF3OqMzr4/MuwhIZh3sQrcPM=;
        b=A+8H73Bi5phf+KZoN62qhv54fNAzTcZoEfzZCiPp0K/+wMYiVGaJi1RxGC+qUTCBvq
         sacJWwIqtc3UNyzG6eslEb1J9ASUmKj2+7coBctxTzAHNK0cXoi+cKcIa8harM6Syng4
         n9OQAtNhscvgREgpGl7joAA/aPdIHLPBgY7E7l5k+nFrDwAHRDLBsaXTxSYA/6Cwhir4
         ziI610ElHEW2vllGaRyvitfyIpslDFbTDwokT/6UOJCz6fEnPFHbBeJ2iJMHlECKVReA
         zuwmf7LZCDzEBBVL1bzbfiK/auRm5D90WNioWWwzLkoeVYYIEO+W99l36VTYzcRe88w3
         C6qA==
X-Gm-Message-State: AO0yUKWhHKMgQ/3lSn11R9HaXNKNGb2O9PGiWMETY4lFSKdLZDUAT2Hj
        viyABxKkMHYY0FZmnc3hPSDfd3dFtK4J
X-Google-Smtp-Source: AK7set92OL1DUlHDMUMQ4k9Yj7wQXKCg/3n8NSJSe2/cDPHS5azdpg94Ta35YErsydO4/UTa/tFbOgZB/LCJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:5292:ba14:c261:246a])
 (user=irogers job=sendgmr) by 2002:a5b:b03:0:b0:ad7:b81e:69bd with SMTP id
 z3-20020a5b0b03000000b00ad7b81e69bdmr9346841ybp.2.1678316413963; Wed, 08 Mar
 2023 15:00:13 -0800 (PST)
Date:   Wed,  8 Mar 2023 14:59:08 -0800
In-Reply-To: <20230308225912.1960990-1-irogers@google.com>
Message-Id: <20230308225912.1960990-8-irogers@google.com>
Mime-Version: 1.0
References: <20230308225912.1960990-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Subject: [PATCH v4 07/11] perf parse-events: Pass ownership of the group name
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
2.40.0.rc0.216.gc4246ad0f0-goog

