Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A7EC432BE
	for <linux-perf-users@archiver.kernel.org>; Thu, 26 Aug 2021 00:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7491D60F39
	for <linux-perf-users@archiver.kernel.org>; Thu, 26 Aug 2021 00:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbhHZAR1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 25 Aug 2021 20:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbhHZAR1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 25 Aug 2021 20:17:27 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173FBC0613C1
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Aug 2021 17:16:41 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f64-20020a2538430000b0290593bfc4b046so1253803yba.9
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Aug 2021 17:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=jKpOvBSXMQrCJiT5zO1xY+EZk8vDkrov86gD8oj2C2Q=;
        b=NpeAHgNjtm+yStWpoNqTQ3x7Xlzz/icd7LOJxn2vJfRcN6H/9c1ykD7krmgc2BEgNY
         +KV+HVbFD3M9Pq4xLayOJYzCy2H7KvEwD+bmzEbvEG1OhRX+datgCNNSY2jCFkAji4+o
         sbvyLW1e7nUE882dXm0As55FPIyDr73ocQOC4710N5q+csJe6WoMsLQboy3Zlb4wifDp
         1NCNQj7ofnbYv8LpZ+Cb66jyEQNshzPzphbl7RvWWUEW/V8XGVkWuRHkvE+MoMocL73X
         p7xUMilKuI6frKK1rAyow+MFsPng6EHu1MnkrFAYkDRZRWr25EImsWO1dDvwQgcCumpu
         yPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=jKpOvBSXMQrCJiT5zO1xY+EZk8vDkrov86gD8oj2C2Q=;
        b=eeWuvYLd4QpczRplE3aOW7tOMaso7gOBMaGoB72PklvGzFszLUEV9QMxXde/ot2WwS
         joXyUqZVEDpWy/P9A+V+RLJc8OJCLdpFbz4Mi3570K/GUvz/HCc/kEjkzOs3d6d7MC6A
         0fMVNVciA/00Lzp4M98IXWyHPFNdMucdccd2dwgzWxV5K3K6X8NcTAk+ezUGSPVsMctV
         EFjvLAwXBrrsK99GchSMfT7XgPphc4roegU7Gut6aaRo8jzuMVsUGZEvx0FhslOAIKI0
         Ov+2siIxPOPWYEmRuUmhvkGpD1POdrDFiTE2E8oC0/7IWrB1rw/QgNL39gxI9cmorb7a
         UgmA==
X-Gm-Message-State: AOAM533WmnKQ5V76uBXxwXWJGN/16Qi05D4orRCaJIOllI9+RWSKtCij
        Q89P7qd3Qb8Fg/UegV3Y5QJG7GENQkbi
X-Google-Smtp-Source: ABdhPJxknXL2IQv1ORhIsgH9DLjXnjQK1sOefpzkiQe5Fq2OyH7vNUBwGCXZE2VTdxpDiq7eoEr2nRIpQBJd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:d2f8:e3e3:cd4a:a809])
 (user=irogers job=sendgmr) by 2002:a25:5086:: with SMTP id
 e128mr1648317ybb.89.1629937000311; Wed, 25 Aug 2021 17:16:40 -0700 (PDT)
Date:   Wed, 25 Aug 2021 17:16:35 -0700
Message-Id: <20210826001635.285752-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH] perf bpf: Fix memory leak during synthesis.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

BTF needs to be freed with btf_free.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf-event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index cdecda1ddd36..d193104db7f7 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -296,7 +296,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
 
 out:
 	free(info_linear);
-	free(btf);
+	btf__free(btf);
 	return err ? -1 : 0;
 }
 
-- 
2.33.0.rc2.250.ged5fa647cd-goog

