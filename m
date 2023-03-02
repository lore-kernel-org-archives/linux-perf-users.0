Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25458C6FA8E
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Mar 2023 04:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjCBENG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 1 Mar 2023 23:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjCBEMz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 1 Mar 2023 23:12:55 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A781BF8
        for <linux-perf-users@vger.kernel.org>; Wed,  1 Mar 2023 20:12:52 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 23-20020a250b17000000b00a1f7de39bf5so2807191ybl.19
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Mar 2023 20:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677730371;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pbWEbRbutsNUN5sTWrzxwdPi+ofZdxqM4XD/ZOPKz9c=;
        b=dk0jI3kOiQBk9W2lLqgz+VaudhSa/CCW/ODrtT0tyOePHBKtrFJUvQQAPYg6319gFj
         sz5ylm1roUVU+84JZuR3TdmJMWSoidy3zxMl828qu0O7jAl50dfWP3fpeFzU3fZev7zZ
         QpoIXKETiuB3T2AmvOc3T6030jPbIOTsD1ilLyBawehp3KaYHpyXo8WjOqr97i5geWqW
         VYUVc1WRgySWJ+uJ1lKoZ6XTkeauHlREYHJNO+DHvrBsM1VwXoQ8Gp4pZ1P4elO8OJvu
         IJO1v1wrTVgOew5IoHZBIE4gcSLR3gUE481C+y0Wcta5ENi0HPMBwWyvcimxlDMs3j37
         2SYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677730371;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pbWEbRbutsNUN5sTWrzxwdPi+ofZdxqM4XD/ZOPKz9c=;
        b=t0UF6R9pWmXD9Ol1ybZ7na6Iyl0SopZWwjM9ERKBKlHKxCgOWPcfpdgeppF/zIXnrf
         z61g+G488/kLzCuKbjEkQtQYx3ivUZlkAX4NXZ0TaXXxh3XYGZuk9klktSxP1164qe/b
         r8xhLKkHeYQpeQNimfavVTKsuUxOc3KsmU8jWDv7WAbToRkMXc+5kMKJ2+MViTThWFyY
         VXjnrbVYsp+uuEjLEBrfipgHeOGXKxiYlfn7wxAZlfLmAWsfTxSa3VESY3rTY0DQYDw0
         eol2ItWU0s9HZoB9OQv33wqiJKyg0Ym7AGYIQP9hI5+fsBbOiXTyCGw4v7B3Yc2+qAly
         KRcg==
X-Gm-Message-State: AO0yUKWnPlF+xM6kAKNFYbraRPvR2bC+1t0GtU5RKtRy7Mq3zRSUywbQ
        00NffxmISdWTb5++xTFZ8JJtJvxJuskh
X-Google-Smtp-Source: AK7set+W/bIoe35+5Se46H/fsjUeerGMB7s1zWFvSFbBTPKuRV1HVKalzCXXsdo4lqp1E2fH/U8kPqKb6Hdg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:bdf9:f5cb:d05:c4d5])
 (user=irogers job=sendgmr) by 2002:a0d:f786:0:b0:539:2d32:9f97 with SMTP id
 h128-20020a0df786000000b005392d329f97mr13ywf.298.1677730370827; Wed, 01 Mar
 2023 20:12:50 -0800 (PST)
Date:   Wed,  1 Mar 2023 20:12:03 -0800
In-Reply-To: <20230302041211.852330-1-irogers@google.com>
Message-Id: <20230302041211.852330-3-irogers@google.com>
Mime-Version: 1.0
References: <20230302041211.852330-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Subject: [PATCH v1 02/10] perf stat: Don't remove all grouped events when CPU
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
2.39.2.722.g9855ee24e9-goog

