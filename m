Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1097EC64EC4
	for <linux-perf-users@archiver.kernel.org>; Wed,  8 Mar 2023 08:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjCHISN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 8 Mar 2023 03:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjCHISG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 8 Mar 2023 03:18:06 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A59A93C6
        for <linux-perf-users@vger.kernel.org>; Wed,  8 Mar 2023 00:18:03 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id e195-20020a25e7cc000000b00a1e59ba7ed9so16921739ybh.11
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Mar 2023 00:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678263483;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dvqLbFbIa5Th4hLVJzIhGZ3VgrtC26zZgF3M8vwaoio=;
        b=PjnUeRwk9Flf5/KgWTPUHPhH1Ksd8NChwAqNNyKs3hT2VJ+j8t84vRp08y/phCC/3n
         Dq1CoTyHkTLSMh7RCIznqMyHpfko9YaK3uC2hxljieaD0TZ3saXHKv07rr5LGQirmsvR
         8z4eHHGsX8zUisVsnHcKYNf3TslDxRCqhGUaSvjLruJv9nHy9vOto/hLbtERz2H+ST01
         I1x+C44Sq4bVRaZ4PgY3siaL5mzf59AFQvlXUsRNIfWsgtteIZpFK8r4iccq9SsWd7kD
         6V2OR2BLoMNB12b55Jz/qKGiOSZo0vn/oFmabWvdRvgIe2h8Ab66rhSXwO1QRvtS5icu
         LV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678263483;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dvqLbFbIa5Th4hLVJzIhGZ3VgrtC26zZgF3M8vwaoio=;
        b=1GHg1QmTVu3Sreo1byByACUVWluz29jaB5XrnW202L2i3H3sYE/wBRrmQ6mKxvZDbC
         wXTr61ha+u6xA54984wAS7GFpvtDlOM2N7DDDpbKKS2p4zV+ufueaxfw+6xkUKqoPrvU
         AgHtbc55gtOsIl2OZj+2PX4hifFMpuW3HSJaEh08My10samwnllYCVCwRjhcebEJnj7A
         aMdCmzV+abl7POScuSEvXclD75zIc2gS7fqWqX1JyfWcGP6R7iC4iF1jme4s60WPu8UO
         JC/y1D/2AtJ/tln8qSXiNW2teJeR55Wq2oyT9wrpa6DeIFFZ+IkpJBspmAUcMNEmGmwn
         GtSg==
X-Gm-Message-State: AO0yUKWCC+5X8od6WEkd+N9U2WiRu9T/daZeNKNi301qnYrOLyJs1sfT
        RLRj1ZETDIpk9+PL2ZqQfjHSuDSExvii
X-Google-Smtp-Source: AK7set8sUjOKoa5f+EMHlB+KYfOPxPp735B6lo22IR78tMM7/iFbITr44EyzpBv8HaNOBVWz7gZMCvPbq5GL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:9a99:fbc4:7488:8b5f])
 (user=irogers job=sendgmr) by 2002:a5b:308:0:b0:90d:af77:9ca6 with SMTP id
 j8-20020a5b0308000000b0090daf779ca6mr10538713ybp.7.1678263483246; Wed, 08 Mar
 2023 00:18:03 -0800 (PST)
Date:   Wed,  8 Mar 2023 00:17:22 -0800
In-Reply-To: <20230308081731.1887278-1-irogers@google.com>
Message-Id: <20230308081731.1887278-3-irogers@google.com>
Mime-Version: 1.0
References: <20230308081731.1887278-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Subject: [PATCH v3 02/11] perf stat: Don't remove all grouped events when CPU
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
2.40.0.rc0.216.gc4246ad0f0-goog

