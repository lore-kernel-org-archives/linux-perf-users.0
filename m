Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE19C433EF
	for <linux-perf-users@archiver.kernel.org>; Sun,  7 Nov 2021 09:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57FD5613D2
	for <linux-perf-users@archiver.kernel.org>; Sun,  7 Nov 2021 09:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbhKGJDE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 7 Nov 2021 04:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235267AbhKGJDD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 7 Nov 2021 04:03:03 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0EAC061570
        for <linux-perf-users@vger.kernel.org>; Sun,  7 Nov 2021 01:00:21 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id t24-20020a252d18000000b005c225ae9e16so20885904ybt.15
        for <linux-perf-users@vger.kernel.org>; Sun, 07 Nov 2021 01:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=m2otj9XBu2PcJainIjXgKv2kW+bjLowTkdHsom43oaI=;
        b=JcnUKs01SmWnCOoxBwXPLREobdqvM/0WzdG2Yj1+JnWtVpuraqjxY4nzz9jx2ZCVC8
         a+RpCE3/w2x7AA4ck/SpIGawiFX2akngfC9oiopoAs88j4Nmv51EDHvUcCKZA/Iwi5iH
         Ku2hb5UhD2eSkTXKL+wymOkMFcTAfVbmYnslSisFLuoLgdIAWTiQPA2tusheNjVCM5wI
         6yCerfcPYldiTtfXqkgo8Ga5mjARAQeYptYQ2adAebXsb9Lu+KE+ISNC/pQaRlmrEM5D
         Yfq8Fr7t8/cJl00lULhMpj1Q8g1YmGO40v5OCIyWqtDK9a/jdkYc+v6FRgRgJxoRxEKh
         9nfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=m2otj9XBu2PcJainIjXgKv2kW+bjLowTkdHsom43oaI=;
        b=Sd/SE40R1LfihnJNbkwiZFUhODU0t4DhmedWjkAczyz9tcQKxp7sx69ZePW6SGswhk
         nxmKIS1C4LNEO1CcG1lh1M28pQmOc4yBxtX28iPuY9iaKzyNG4d4ttjFGDXlNwDhwcur
         s87IAsABVCoLQr2NXdNrJ68Xf7KGPfuE8UrAXpGSciKQzYYdL7W+TX04pR3Qke5xc9rm
         msWiJbfBFHWQeNxUqYLjljB96oY56SN+oXV1G6W1woboWSlomksxeszC6gZdRY5TRkLh
         L9hPTmNVWp4eFxnczXuptIvSGDz7anHgQh/xiBmhLYNoxZXl9TcK97iZm7IhLMBaD9Fn
         vjLg==
X-Gm-Message-State: AOAM533Z99m+HV1tnvatlcVh9GA4BUzDyrm7PTgwscfpGG8JOZJIUimk
        5UHQKDVXMrKnqkIuIceojpoizrY2ZMRj
X-Google-Smtp-Source: ABdhPJzRd6lnqIoH8o3+YkXD32j7GbsxVuRzQ7cT4t/6Po7TRrxeBvoHiyZkX3lB5m2LjP7zGi+ZyACw1xy5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:421f:fd78:d785:693a])
 (user=irogers job=sendgmr) by 2002:a25:1503:: with SMTP id
 3mr77497145ybv.214.1636275620322; Sun, 07 Nov 2021 01:00:20 -0800 (PST)
Date:   Sun,  7 Nov 2021 01:00:02 -0800
In-Reply-To: <20211107090002.3784612-1-irogers@google.com>
Message-Id: <20211107090002.3784612-3-irogers@google.com>
Mime-Version: 1.0
References: <20211107090002.3784612-1-irogers@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v2 3/3] perf metric: Fix memory leaks.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Certain error paths may leak memory as caught by address sanitizer.
Ensure this is cleaned up to make sure address/leak sanitizer is happy.

Fixes: 5ecd5a0c7d1c ("perf metrics: Modify setup and deduplication")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 1b43cbc1961d..fffe02aae3ed 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -228,6 +228,7 @@ static void metric__free(struct metric *m)
 	free(m->metric_refs);
 	expr__ctx_free(m->pctx);
 	free((char *)m->modifier);
+	evlist__delete(m->evlist);
 	free(m);
 }
 
@@ -1482,8 +1483,10 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
 	}
 
 
-	if (combined_evlist)
+	if (combined_evlist) {
 		evlist__splice_list_tail(perf_evlist, &combined_evlist->core.entries);
+		evlist__delete(combined_evlist);
+	}
 
 	list_for_each_entry(m, &metric_list, nd) {
 		if (m->evlist)
-- 
2.34.0.rc0.344.g81b53c2807-goog

