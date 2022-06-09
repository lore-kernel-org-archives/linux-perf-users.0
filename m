Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D50C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Jun 2022 05:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238257AbiFIFYI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 9 Jun 2022 01:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238274AbiFIFYH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Jun 2022 01:24:07 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB14827CC8
        for <linux-perf-users@vger.kernel.org>; Wed,  8 Jun 2022 22:24:04 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id z67-20020a254c46000000b0065cd3d2e67eso19378368yba.7
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Jun 2022 22:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bfkEdtucqgA+wBrOBxrBZd3UEfs8ZNdv2ifdbarRzlY=;
        b=m+GH7afRGBYGWqJBmM4w4QGt8MCZhwn+CP1UOE+F21RUMbBBtczrX4dpaH1Th5zjis
         5S6qp7GTToPhKiuLySTPJzaCFI1KR6/8dXZe13wiB6LmZ/xe0yf8PvdBPr+Ok+0x2GdZ
         F9KeQSU1oKIhH6z3bkKeT54UJNjFiHmG15KjOj1sU8IbSC7CS2pxTYRshhKAblVtZfuH
         jhC7NKiOrQp6DtxkRsa8jz/FlBvkRtC8dtfKzI4z4YUZ/Tz8davC212ATw4ccRhYXd2o
         aNBeSMqX1B6ac+B4AKSv+Ftl549whZaXk6ea5N+/HveYjTol1iYFewxASPZxNJt0iEuT
         oF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bfkEdtucqgA+wBrOBxrBZd3UEfs8ZNdv2ifdbarRzlY=;
        b=mkg0NyviaSBbvnVPyEMq9/8PEqQZHn/34UN/4smeyXrbPD4eoMlmWF4M74+k1IVLZs
         BWXJ4FgC1dxxP2CzKvuMxFFiYMbcYSCsJXXDW/s+zgp0geo1NKEY6hGj2QiNdK9RT8TY
         OVHuxKkPXkeFptRihXJ/zq1zDCqOUXTGn685XKP+xdTxefTrPBiM+WyY20B/BiS3QqEU
         uwTffzxKn3dHJjhpt2iRk0HlYUGj4YwlvvSCsYBONu2oU38gzD5Yh9xfPqElUsp/mvWM
         VEP8AlgNYkw91OXkheen4bMWPR8TnhpDAAgZeEGBirgAty242YKHoPgDZ+TowF+6trhj
         kR6Q==
X-Gm-Message-State: AOAM532izNrRxBk9DgaAflRUVi4Q6lZEi5D9pygYXNSK7X1BFYRQFEpP
        LVEriUsvL6VL6RQ99WlikAO7FYN7c2zB
X-Google-Smtp-Source: ABdhPJzR1whIf7j55WQjVp8vOL2cQbpNCuyhPsZMw7XC5LhktLRlst3wiJkrl8JtpqpEzCumqhY37TGcvUF+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:ae20:7578:fb21:976b])
 (user=irogers job=sendgmr) by 2002:a81:1414:0:b0:30c:1c83:7702 with SMTP id
 20-20020a811414000000b0030c1c837702mr41227650ywu.474.1654752244006; Wed, 08
 Jun 2022 22:24:04 -0700 (PDT)
Date:   Wed,  8 Jun 2022 22:23:52 -0700
In-Reply-To: <20220609052355.1300162-1-irogers@google.com>
Message-Id: <20220609052355.1300162-2-irogers@google.com>
Mime-Version: 1.0
References: <20220609052355.1300162-1-irogers@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2 1/4] libperf evsel: Open shouldn't leak fd on failure
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

If the perf_event_open fails the fd is opened but the fd is only freed
by closing (not by delete). Typically when an open fails you don't call
close and so this results in a memory leak. To avoid this, add a close
when open fails.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/evsel.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index c1d58673f6ef..952f3520d5c2 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -149,23 +149,30 @@ int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
 			int fd, group_fd, *evsel_fd;
 
 			evsel_fd = FD(evsel, idx, thread);
-			if (evsel_fd == NULL)
-				return -EINVAL;
+			if (evsel_fd == NULL) {
+				err = -EINVAL;
+				goto out;
+			}
 
 			err = get_group_fd(evsel, idx, thread, &group_fd);
 			if (err < 0)
-				return err;
+				goto out;
 
 			fd = sys_perf_event_open(&evsel->attr,
 						 threads->map[thread].pid,
 						 cpu, group_fd, 0);
 
-			if (fd < 0)
-				return -errno;
+			if (fd < 0) {
+				err = -errno;
+				goto out;
+			}
 
 			*evsel_fd = fd;
 		}
 	}
+out:
+	if (err)
+		perf_evsel__close(evsel);
 
 	return err;
 }
-- 
2.36.1.255.ge46751e96f-goog

