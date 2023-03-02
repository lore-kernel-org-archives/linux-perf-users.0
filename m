Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BA1C6FA8E
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Mar 2023 22:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjCBWec (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 2 Mar 2023 17:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjCBWea (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 2 Mar 2023 17:34:30 -0500
Received: from mail-ot1-x34a.google.com (mail-ot1-x34a.google.com [IPv6:2607:f8b0:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCD9241D4
        for <linux-perf-users@vger.kernel.org>; Thu,  2 Mar 2023 14:34:06 -0800 (PST)
Received: by mail-ot1-x34a.google.com with SMTP id w27-20020a056830411b00b0069411644fc5so330937ott.14
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Mar 2023 14:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677796446;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dcvWMdLTJ1iuXhAaTLlBF3OqMzr4/MuwhIZh3sQrcPM=;
        b=lhE39hZwYqU5pKzGgXUsKs+1xAQ831ajiuj5B1QKiRlPoHOZV+W7YeiwNKwHqR/rml
         4+kcfGE8GUOjm/G8EMEKRsrVFcLYbMUfQjWiqcrPLJa71GJthY8uwaINWSLCBmTzoqfK
         +nolvo/+LJWagjp3PYXnoat5orMPUOr23f7kr6Dx2PMMvOBMvBUsoU7deYrWI/VHLkLL
         mEHBMSYAHinwXzZjs/x6Oa2z4tNb2klapLRqHZM9uL7WOntjMAA9bDWfoiKlZm/BaUPH
         /H8Z/+ne0z7WYThG4JASXO+Qcqa1RsqNpekaxlOsjSkD8M+u7iF0bj7ehABprE4W01yE
         hamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677796446;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dcvWMdLTJ1iuXhAaTLlBF3OqMzr4/MuwhIZh3sQrcPM=;
        b=fudN/c5WFmmCUwQs7g0ycuaP5kwJk+KsOhWVJDe9Kw5ool13Uq3ZcSISOgkxXDiEvi
         r1c/oicEKL4ok+OOEdP7IX1ephfrQ6R/7Wa+Mw2uJTrRYToGX7rRGYxDCbeiPqf0Lk0s
         oQSm0XHLrtQ+5deiRWk4ySG1Nej8J8NubDVH+hmW6jipC3k8Hham0lBnRunmEfSRBYUW
         tjnuyqxqSFNQUOdWQeXNzfMlF3SRO6F5r/0yvF3wkr+/MhiOy0UZtyqZFXfCoVD22PVI
         /x1Kd9RM0ymXnLj+pVj9nf6sIRmWW3P7KIxLEH7dNbnvnPjvId6aahG89qioik62GfdZ
         1xeQ==
X-Gm-Message-State: AO0yUKXQbdz1rrh75IGFK30x39F94BOXX1UAVc1Sr5vh6V9a+W7h9h8Z
        M486SpXmw+EfGEnLYyVjGwkuxtszr5Eo
X-Google-Smtp-Source: AK7set+J7xhJXlPokHx7LXJwm2IqRttp6kpC4gGTiT8erLWQVPEcFhFcT67z288CpJXfg3wHvD28CGfNiln2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:5f50:6ef4:b4d0:568e])
 (user=irogers job=sendgmr) by 2002:a05:6902:4f0:b0:a9d:be6e:3340 with SMTP id
 w16-20020a05690204f000b00a9dbe6e3340mr6135153ybs.1.1677792402429; Thu, 02 Mar
 2023 13:26:42 -0800 (PST)
Date:   Thu,  2 Mar 2023 13:25:28 -0800
In-Reply-To: <20230302212531.1043318-1-irogers@google.com>
Message-Id: <20230302212531.1043318-8-irogers@google.com>
Mime-Version: 1.0
References: <20230302212531.1043318-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Subject: [PATCH v2 07/10] perf parse-events: Pass ownership of the group name
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

