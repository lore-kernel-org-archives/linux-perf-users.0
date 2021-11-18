Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453DCC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 18 Nov 2021 22:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18CAC61AA2
	for <linux-perf-users@archiver.kernel.org>; Thu, 18 Nov 2021 22:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhKRWJy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 18 Nov 2021 17:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhKRWJy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 18 Nov 2021 17:09:54 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9786EC061574
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Nov 2021 14:06:53 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id jx2-20020a17090b46c200b001a62e9db321so3716848pjb.7
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Nov 2021 14:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bPMPgZzyhDtannpbp/itJXQHsFdPQT97DYPC6FjJqDE=;
        b=IrYK7nDdhdHRuX7dxzYGzNkNKzZ6RXZ7gOErHcf38Hwl7kTRZXT7wNicTi7hGjQyns
         C83SbJUkT8drQXkNgxXOUhhSrNTASMA/1xm9fmkvKE+II89SIwWU7hPSWak5xw5Iu0mD
         euS+ktyORqvWbhMP40+Aqk/fpNsBEUgNMP111ue0lvla+qXY7bifxJlHiiIZcjwGcsFZ
         +37dpSYlYeHfONT/Uq+nkjDxk9KpabhdREMvRWUi0bfMPThfMLdAPJKzlumMtFPKEzX9
         jRbLxc4Vq7tCv1kkq2x6UjNzSlaDmjweXuS1uUtyNjr00qvWeN9+os+AMbtkf0i3gH61
         k+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bPMPgZzyhDtannpbp/itJXQHsFdPQT97DYPC6FjJqDE=;
        b=0uTz/ZWIwmlYBt50KyrIGdPOqciff/HYQdy1aWKfxHUF/WC4r/pvEJhsDsH0QH8Rp3
         fn8w9WY/bavkeQRWsXkXrnvDftDhW5h2rPuFKebRri98YbcxdqkE/tsDIQ2mbrP/Wh6f
         cSsuB6xoTDmys3XzJ9yScSt1+ruFj59zFqZ6G0pqATwhxqsQUrNPzzL+CIiPPBIGS2EU
         PMTQqfSD+J7JHracdXZdB9+8i7ZktoLnl43rp1ciwpcLeGolMRkfAcxi8hUt4Fli4XOx
         MlhkVYIN0t4FtT1NynDgshs1dQcq6W1vb7z7f6xT1k5zDsSkGJ2K4siWtaGD7o2yOU/4
         YQeA==
X-Gm-Message-State: AOAM53100z16fv/j8sZAJI55Gt02JS9+evgu1OlNkBRfs0LmRxYBNGBp
        8J6JceY18hmMqVrA0VL2fgnkO9wcmhDa
X-Google-Smtp-Source: ABdhPJxmNmmgb0mBdEemGyrSaIXpTYTPoI4yq88XcxPpDGxzzKj1HKzoKhiq3AgVYpMnJKRZIu+GWPWilHsf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3908:af20:80e3:e47])
 (user=irogers job=sendgmr) by 2002:a17:902:7fcd:b0:142:8ab3:ec0e with SMTP id
 t13-20020a1709027fcd00b001428ab3ec0emr69556088plb.4.1637273212657; Thu, 18
 Nov 2021 14:06:52 -0800 (PST)
Date:   Thu, 18 Nov 2021 14:06:46 -0800
Message-Id: <20211118220647.2355999-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v2 1/2] perf evlist: Allow setting arbitrary leader
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The leader of a group is the first, but allow it to be an arbitrary
list member so that for Intel topdown events slots may always be the
group leader.

Reviewed-by: Kajol Jain<kjain@linux.ibm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/evlist.c                  | 15 +++++++++------
 tools/lib/perf/include/internal/evlist.h |  2 +-
 tools/perf/util/parse-events.c           |  2 +-
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index e37dfad31383..974da341b8b0 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -643,14 +643,14 @@ perf_evlist__next_mmap(struct perf_evlist *evlist, struct perf_mmap *map,
 	return overwrite ? evlist->mmap_ovw_first : evlist->mmap_first;
 }
 
-void __perf_evlist__set_leader(struct list_head *list)
+void __perf_evlist__set_leader(struct list_head *list, struct perf_evsel *leader)
 {
-	struct perf_evsel *evsel, *leader;
+	struct perf_evsel *first, *last, *evsel;
 
-	leader = list_entry(list->next, struct perf_evsel, node);
-	evsel = list_entry(list->prev, struct perf_evsel, node);
+	first = list_entry(list->next, struct perf_evsel, node);
+	last = list_entry(list->prev, struct perf_evsel, node);
 
-	leader->nr_members = evsel->idx - leader->idx + 1;
+	leader->nr_members = last->idx - first->idx + 1;
 
 	__perf_evlist__for_each_entry(list, evsel)
 		evsel->leader = leader;
@@ -659,7 +659,10 @@ void __perf_evlist__set_leader(struct list_head *list)
 void perf_evlist__set_leader(struct perf_evlist *evlist)
 {
 	if (evlist->nr_entries) {
+		struct perf_evsel *first = list_entry(evlist->entries.next,
+						struct perf_evsel, node);
+
 		evlist->nr_groups = evlist->nr_entries > 1 ? 1 : 0;
-		__perf_evlist__set_leader(&evlist->entries);
+		__perf_evlist__set_leader(&evlist->entries, first);
 	}
 }
diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/include/internal/evlist.h
index f366dbad6a88..6f74269a3ad4 100644
--- a/tools/lib/perf/include/internal/evlist.h
+++ b/tools/lib/perf/include/internal/evlist.h
@@ -127,5 +127,5 @@ int perf_evlist__id_add_fd(struct perf_evlist *evlist,
 
 void perf_evlist__reset_id_hash(struct perf_evlist *evlist);
 
-void __perf_evlist__set_leader(struct list_head *list);
+void __perf_evlist__set_leader(struct list_head *list, struct perf_evsel *leader);
 #endif /* __LIBPERF_INTERNAL_EVLIST_H */
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 5bfb6f892489..6308ba739d19 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1834,8 +1834,8 @@ void parse_events__set_leader(char *name, struct list_head *list,
 	if (parse_events__set_leader_for_uncore_aliase(name, list, parse_state))
 		return;
 
-	__perf_evlist__set_leader(list);
 	leader = list_entry(list->next, struct evsel, core.node);
+	__perf_evlist__set_leader(list, &leader->core);
 	leader->group_name = name ? strdup(name) : NULL;
 }
 
-- 
2.34.0.rc2.393.gf8c9666880-goog

