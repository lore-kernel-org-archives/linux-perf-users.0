Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CC1C433F5
	for <linux-perf-users@archiver.kernel.org>; Sat,  1 Oct 2022 06:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiJAGG5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 1 Oct 2022 02:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiJAGGu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 1 Oct 2022 02:06:50 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0280F12C1F5
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Sep 2022 23:06:48 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k11-20020a5b038b000000b006bbf786c30aso5606263ybp.8
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Sep 2022 23:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=Qii+hgPKPKNgROLcY0ySesmuzhBUXysFitkb8xtJsts=;
        b=kZ8O2caPqw53jlKugZLlR+Ha0l+KrjBKX2Sa8I9wM+nnPRsYQSeH/Df7IoCdGrUcIl
         rgQE7UAmyPVC2VMDQbPmth6owH/L5RF4o4O4zoOlzdUPIHGd/AEYT5QOJuhcrdfoNKFf
         3aYLJb/6WHhWrQxdKEISRWilw09+C2yno3n9j1hymm5MEHmhcpqOc+0n/xe39xkg+RKN
         hn7YL2DdCVRiSnW2pEUdwZu47kzBDmzv6T2SY9gW5u3YeddJcf2u6cBpFXgEjsI0/k+l
         ply3jBRpOAiZ9MMRH5MF4kXo77kZ0R03iw0vlyeECWlLSoaBjPXIyFewjLqo0RA3PbOQ
         gGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=Qii+hgPKPKNgROLcY0ySesmuzhBUXysFitkb8xtJsts=;
        b=wAQmmMAOCue521SuQwtGVcWH7LTJsGkYrEfl0SKU3W7tPVbLANnSrN1lZClM9ISSi8
         zZIy4LYUe1ber5tTz6K1TkRfRvx0CQWWQNailtte092jBUnfQEtpoouRckYWgyjYiM7J
         GpSrX2/6D+2i+j4ERmGBHYcP3vfeTxNW6Ilswict8hcOdXFAiyrBoaIKjhlTQgtT/oHK
         ISP+V1EquVvkm8tH18rFhYNVUH88fWafgicEEdxzSme1nn3Wlqr8vQXAiTDCEjLM4Nt9
         o9Mfp9OoLr1bNwWLkam3pD7gUCcCYuEODrGUZ2okti2pr/hvy1c3bAPBPw1HlqJFa0fR
         /kgg==
X-Gm-Message-State: ACrzQf3cn3N5z+1Vr0G0czmkKXzvP/wpcbCMXuF+pNBT96FY/8zhAHY4
        SaDUzCy2mO66cjt8e0bfmn5km25ZAPgA
X-Google-Smtp-Source: AMsMyM6CSUg0wKtyN/RjOi6+y/dw3yyuWC79SAMLGo1wP4u6qYogIbOdCOf+9bT2czdlpoe/KIHHWrXQKFX4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:de60:c6ac:8491:ce1e])
 (user=irogers job=sendgmr) by 2002:a81:160e:0:b0:356:e96c:d5ab with SMTP id
 14-20020a81160e000000b00356e96cd5abmr3725765yww.506.1664604407953; Fri, 30
 Sep 2022 23:06:47 -0700 (PDT)
Date:   Fri, 30 Sep 2022 23:06:16 -0700
In-Reply-To: <20221001060636.2661983-1-irogers@google.com>
Message-Id: <20221001060636.2661983-3-irogers@google.com>
Mime-Version: 1.0
References: <20221001060636.2661983-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Subject: [PATCH v2 02/22] perf expr: Remove jevents case workaround
From:   Ian Rogers <irogers@google.com>
To:     Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, perry.taylor@intel.com,
        caleb.biggers@intel.com, kshipra.bopardikar@intel.com,
        samantha.alt@intel.com, ahmad.yasin@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

jevents.py no longer lowercases metrics and altering the case can cause
hashmap lookups to fail, so remove.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index c6827900f8d3..aaacf514dc09 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -182,7 +182,7 @@ int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref)
 {
 	struct expr_id_data *data_ptr = NULL, *old_data = NULL;
 	char *old_key = NULL;
-	char *name, *p;
+	char *name;
 	int ret;
 
 	data_ptr = zalloc(sizeof(*data_ptr));
@@ -195,15 +195,6 @@ int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref)
 		return -ENOMEM;
 	}
 
-	/*
-	 * The jevents tool converts all metric expressions
-	 * to lowercase, including metric references, hence
-	 * we need to add lowercase name for metric, so it's
-	 * properly found.
-	 */
-	for (p = name; *p; p++)
-		*p = tolower(*p);
-
 	/*
 	 * Intentionally passing just const char pointers,
 	 * originally from 'struct pmu_event' object.
-- 
2.38.0.rc1.362.ged0d419d3c-goog

