Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD70C678D4
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Mar 2023 22:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjCBWXl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 2 Mar 2023 17:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjCBWXk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 2 Mar 2023 17:23:40 -0500
Received: from mail-ot1-x34a.google.com (mail-ot1-x34a.google.com [IPv6:2607:f8b0:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C06C11EBE
        for <linux-perf-users@vger.kernel.org>; Thu,  2 Mar 2023 14:23:34 -0800 (PST)
Received: by mail-ot1-x34a.google.com with SMTP id l10-20020a056830334a00b00694420738edso333565ott.6
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Mar 2023 14:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677795813;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dvqLbFbIa5Th4hLVJzIhGZ3VgrtC26zZgF3M8vwaoio=;
        b=jRla/kUviyKfiXQESPwuR7jJ/pVzh3GeUc8PlfDJKrMAP3x2k5jHzpQH60NB+K5Bf0
         tLGmuRZMeiwjrzO+D00XKe6A2WJilAhald2UD7jhZSwGzRfNrtC79hySa+//SG3fzklh
         5p1XW5LKEHqqwazlpqooVohVzWKGw+U5YUA/LkyUA/9mO2j6eymZ5eN+fCapcCcQnD5v
         dqYzAVT4uT5gLhowaj0lqWUuuthcIY6l35EThTg+lD6Y4R2KL9gweXlKwdF8D/o03g5S
         kbpT2g+RvXy+L0BwhSEckQ4dCkm9yy17YGIYV016qMjmkVR5EY/Ijc4JLuC0yGAUhkek
         y0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677795813;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dvqLbFbIa5Th4hLVJzIhGZ3VgrtC26zZgF3M8vwaoio=;
        b=7IYOBVdGzmBr25+G4OGB1cEmNxOLhueWhW1uaQYVlzRmPv0JXhUKToNtm9FYw/eRmR
         TEQgtpB84ksWjQ1BjfTgj0vPThV5MD7+5z6rFQIVf6x9KcPDK5ZzhWIRyM+qCfs5L/Uv
         ptB3lzg5tv/z91BWvtC7Xx0GcUbQipJBCZOItVqq+kxZ/v+HjfVqajUCCbU1jeEhHb6J
         CgvPCNSt4VaOde4FCF57p2wUab8nCUIaLu/BpwyVSlSNbChL7Za5EJteijck3vk9J2/3
         0C08oGWQfNe2CU41OUZ1fhkfCXxKWQ9oa3zfZcmERLXYjoOsdRGzK9qK1loNwWKOJxgM
         65NA==
X-Gm-Message-State: AO0yUKXy3QXjw6/zNWVzYNJ6FTeMI0a+a3NhUpOL2xRWsvKzZl7LSYhf
        YsNDpJ7k4kOFmTW4OdxluAW/ORQkPBsO
X-Google-Smtp-Source: AK7set/77hq2nbjz3JZillK85E2ztOk6/zaHwTy51JirFxWAWfnzXGB75tCD+P3ovof7qkUcsCy8lqK3pepL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:5f50:6ef4:b4d0:568e])
 (user=irogers job=sendgmr) by 2002:a05:6902:101:b0:a4e:4575:f3ec with SMTP id
 o1-20020a056902010100b00a4e4575f3ecmr5273607ybh.0.1677792363948; Thu, 02 Mar
 2023 13:26:03 -0800 (PST)
Date:   Thu,  2 Mar 2023 13:25:23 -0800
In-Reply-To: <20230302212531.1043318-1-irogers@google.com>
Message-Id: <20230302212531.1043318-3-irogers@google.com>
Mime-Version: 1.0
References: <20230302212531.1043318-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Subject: [PATCH v2 02/10] perf stat: Don't remove all grouped events when CPU
 maps disagree
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

