Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F09C61DA4
	for <linux-perf-users@archiver.kernel.org>; Sun, 12 Mar 2023 02:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjCLCQT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 11 Mar 2023 21:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjCLCQS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 11 Mar 2023 21:16:18 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8A73CE05
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Mar 2023 18:16:11 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id w5-20020a253005000000b00aedd4305ff2so10059174ybw.13
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Mar 2023 18:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678587370;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gCy3nPTLL3BzM9vzwEu0uYJt1g84QjoxQ2scYL/5UQQ=;
        b=GZenkIHqhn+3YGrQcHzj3aX6bW1NryTIU40Mc8cjvA/t592pE3P5uhCYyL4Ca5earh
         clnmbwuMQ8rQv1Dg6BnNgUdXMzvNQTDjqjutrBe337/0V8IF6cTUC5r17dD1BYhuiLLP
         AQd0elBDbJf6NJdVfACpwk3PNJD5SHq9SKQXa+LATb5QpP19SEAGk/wX3EO+kkPvRNie
         FyOoIT2H8QXbxE3J1xHRJekv9HI/KVW28pPyZ/dQAOU/Lp7yR1jdMmXqIZTBqi7qWPTe
         FaJcl/2uYVRXHuxWPKnnGWbE7x7JeCzcwoR26j0kL0Sn534+6/4YdbTRZ/yYiakRxvxV
         HX/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678587370;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gCy3nPTLL3BzM9vzwEu0uYJt1g84QjoxQ2scYL/5UQQ=;
        b=Pk54+TKYabxo9hlsQ9Hg1tkvIJ7EVjrOwPr+PdrqibETXhbS56CnBxJdDP826YEXWX
         vWseJZhUawxrjMP5+draOBfpA31GfXnh6Q5W7bc+E5Oexlv8P4dbAUx8xaYcGTwbRS/6
         49Cgqlnc/nFpJYwlIWhMcAzh02TmFWUSySbW7WHz3d4LeceeZuZ3JVwydH5Xg9mcIuoO
         fMcBAT4Taomd++5XgPWFBePPGOGGrgNsEHq1E/z1YJwu+hVOlrdiVRSI6038H3qBUkW7
         SeumTCnRuBbAsnwX4ws48CXD+Mu3iVSfvaogs6t3GNqUTJzxP6jGtJTNOK1sgEkNhYUR
         rQ4g==
X-Gm-Message-State: AO0yUKVa2oUtnmf7K7Y0BFJVauChEUlwRtAv1nD6Bb9zjV/ChVYuR+Ez
        PElUXy5lI7crmz0auGFymt56a8Wcg0FH
X-Google-Smtp-Source: AK7set9WL0H7uaR8gnswB0fr2WWJ0r5ebx2D1lniuNixfKkpgOq8ZsiYhWEul//k+sv5pDlh00cx4nFb8QNV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b42b:2e07:afb:877e])
 (user=irogers job=sendgmr) by 2002:a0d:df95:0:b0:506:6059:e949 with SMTP id
 i143-20020a0ddf95000000b005066059e949mr5ywe.502.1678587370183; Sat, 11 Mar
 2023 18:16:10 -0800 (PST)
Date:   Sat, 11 Mar 2023 18:15:34 -0800
In-Reply-To: <20230312021543.3060328-1-irogers@google.com>
Message-Id: <20230312021543.3060328-3-irogers@google.com>
Mime-Version: 1.0
References: <20230312021543.3060328-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v5 02/11] perf stat: Don't remove all grouped events when CPU
 maps disagree
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

If the events in an evlist's CPU map differ then the entire group is
removed. For example:

```
$ perf stat -e '{imc_free_running/data_read/,imc_free_running/data_write/,cs}' -a sleep 1
WARNING: grouped events cpus do not match, disabling group:
  anon group { imc_free_running/data_read/, imc_free_running/data_write/, cs }
```

Change the behavior so that just the events not matching the leader
are removed. So in the example above, just 'cs' will be removed.

Modify the warning so that it is produced once for each group, rather
than once for the entire evlist. Shrink the scope and size of the
warning text buffer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index d70b1ec88594..5c12ae5efce5 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -181,14 +181,13 @@ static bool cpus_map_matched(struct evsel *a, struct evsel *b)
 
 static void evlist__check_cpu_maps(struct evlist *evlist)
 {
-	struct evsel *evsel, *pos, *leader;
-	char buf[1024];
+	struct evsel *evsel, *warned_leader = NULL;
 
 	if (evlist__has_hybrid(evlist))
 		evlist__warn_hybrid_group(evlist);
 
 	evlist__for_each_entry(evlist, evsel) {
-		leader = evsel__leader(evsel);
+		struct evsel *leader = evsel__leader(evsel);
 
 		/* Check that leader matches cpus with each member. */
 		if (leader == evsel)
@@ -197,19 +196,26 @@ static void evlist__check_cpu_maps(struct evlist *evlist)
 			continue;
 
 		/* If there's mismatch disable the group and warn user. */
-		WARN_ONCE(1, "WARNING: grouped events cpus do not match, disabling group:\n");
-		evsel__group_desc(leader, buf, sizeof(buf));
-		pr_warning("  %s\n", buf);
-
+		if (warned_leader != leader) {
+			char buf[200];
+
+			pr_warning("WARNING: grouped events cpus do not match.\n"
+				"Events with CPUs not matching the leader will "
+				"be removed from the group.\n");
+			evsel__group_desc(leader, buf, sizeof(buf));
+			pr_warning("  %s\n", buf);
+			warned_leader = leader;
+		}
 		if (verbose > 0) {
+			char buf[200];
+
 			cpu_map__snprint(leader->core.cpus, buf, sizeof(buf));
 			pr_warning("     %s: %s\n", leader->name, buf);
 			cpu_map__snprint(evsel->core.cpus, buf, sizeof(buf));
 			pr_warning("     %s: %s\n", evsel->name, buf);
 		}
 
-		for_each_group_evsel(pos, leader)
-			evsel__remove_from_group(pos, leader);
+		evsel__remove_from_group(evsel, leader);
 	}
 }
 
-- 
2.40.0.rc1.284.g88254d51c5-goog

