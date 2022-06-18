Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9333C433EF
	for <linux-perf-users@archiver.kernel.org>; Sat, 18 Jun 2022 01:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiFRBkD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 17 Jun 2022 21:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiFRBkD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Jun 2022 21:40:03 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728F65A159
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Jun 2022 18:40:02 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id m68-20020a253f47000000b006683bd91962so5174423yba.0
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Jun 2022 18:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=fnkpOo5YLADNE1+B+/6+urhCqEeqX/fKxsOS3ahRu/0=;
        b=Rv94vg1GaXWkFNTVkal5h/xnyjLU4wwo+qVIxAHvc64NYBubJlRDP1prW4VKGFfrvj
         jeNamGVEb17+Mgqr7LKFQm6U13BatvULATpAOz4qpY/PzmMqsBLBZHjVudJR7sOGaYPb
         AGT3SlKRmUP8qZ3M60E5CXzAfDGnIzauEqSGXKZu9ZMhFjDVF7sTPho6TJ4LGsVAzVEL
         0zah9vs3Z8UuuHgcDISiTcnnlLir4GktJdP+WopffrsidTXmr89sRWOwHzK7H3YROSxa
         wWiwyh+YlTk4Dt32rfrq0ldnydhF4LuwsSZ9lmhYB5Q3AuYTLuncBOF4yCJOeUdI910N
         7pNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=fnkpOo5YLADNE1+B+/6+urhCqEeqX/fKxsOS3ahRu/0=;
        b=y1tpb7rj3W6TgDiWmmOc06GgS3AHtvGykZJbK5GQoszi4ZEMWQExUqQiZVqBD/n/yM
         J4g8wWcBZNho9Ww/Jaybxt/FiP8mEIJv+vBp7mQIFQq0a8u/3fMhTWEhoB0qSeXJaFzU
         Zxp/od1+w+9vmAI4qIBpy0XJuHGbfpi4KB53zfW9n42scjuFnxWm+sl/guFfKhFSbqD2
         /YhuAB0PCSo/11UDLkYtqMPqnSx/DR8UiSkJO96V4fLgJrnnYPHUX/8gItYny3LAUcnZ
         zlpc3G4fC1e1abIsJGnDJV0eyascIeaUx6B9H36XAhUnrgx9NOXjyXc95G2Heqshmbjo
         XTPw==
X-Gm-Message-State: AJIora/pePDvZCxmB7lO9h4Pv/ta2OFhKm0+ikPQrDEnMLPM8y2dyW+A
        IsS0w1TOSsXixRkLH11jZ7KESPfmre+u
X-Google-Smtp-Source: AGRyM1vuSaYRWv3SKrmvuu787RLCZx1/PUy6ELOLp5C74XHO5aco985HvPVV7TxmoctZYYn2krOviADyPLrx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:c89f:8969:c05d:79b6])
 (user=irogers job=sendgmr) by 2002:a81:38c2:0:b0:314:2ef4:4958 with SMTP id
 f185-20020a8138c2000000b003142ef44958mr14617517ywa.432.1655516401648; Fri, 17
 Jun 2022 18:40:01 -0700 (PDT)
Date:   Fri, 17 Jun 2022 18:39:57 -0700
Message-Id: <20220618013957.999321-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
Subject: [PATCH] perf metrics: Ensure at least 1 id per metric
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

We may have no events for a metric evaluated to a constant. In such a
case ensure a tool event is at least evaluated for metric parsing and
displaying.

Fixes: 8586d2744ff3 ("perf metrics: Don't add all tool events for sharing")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index ee8fcfa115e5..8f7baeabc5cf 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1372,6 +1372,7 @@ static int parse_ids(bool metric_no_merge, struct perf_pmu *fake_pmu,
 
 	*out_evlist = NULL;
 	if (!metric_no_merge || hashmap__size(ids->ids) == 0) {
+		bool added_event = false;
 		int i;
 		/*
 		 * We may fail to share events between metrics because a tool
@@ -1393,8 +1394,16 @@ static int parse_ids(bool metric_no_merge, struct perf_pmu *fake_pmu,
 				if (!tmp)
 					return -ENOMEM;
 				ids__insert(ids->ids, tmp);
+				added_event = true;
 			}
 		}
+		if (!added_event && hashmap__size(ids->ids) == 0) {
+			char *tmp = strdup("duration_time");
+
+			if (!tmp)
+				return -ENOMEM;
+			ids__insert(ids->ids, tmp);
+		}
 	}
 	ret = metricgroup__build_event_string(&events, ids, modifier,
 					      has_constraint);
-- 
2.37.0.rc0.104.g0611611a94-goog

