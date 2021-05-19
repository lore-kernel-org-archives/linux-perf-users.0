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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0725C433B4
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 May 2021 15:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EEA8610CD
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 May 2021 15:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348804AbhESPNq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 19 May 2021 11:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234361AbhESPNn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 May 2021 11:13:43 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C2DC06175F
        for <linux-perf-users@vger.kernel.org>; Wed, 19 May 2021 08:12:20 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id z9-20020a05622a0609b02901f30a4fcf9bso6018695qta.4
        for <linux-perf-users@vger.kernel.org>; Wed, 19 May 2021 08:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=oO5AKNsRSSnrJptTZQeQrJnBbvbH66aYrmljzYTwDeI=;
        b=tCLCiIrH8w8VmA+arhHU+ywzOryvrr+CesPIkyIa1DbBDY4l7ECqELkC3a/R0GCkgn
         oswgIt9bgSOYmog9+Ru2dxq+QEZ0QlLgdW/izDaTHQ6+OdorG9TCpXRG6rruxGsl1klc
         SuolBqr71uYITu+hACVPX8+MDqpM/zrMs0U4rkMUbCGdmIOklzcvF9iuPiCyyPnqVMVS
         yI9240QC28FiCnKPk2lkU2BRgcyOb6Wtp9m+TJoTd/Ab/0zUqnxhzV3CgfReePDy+xWL
         3IfO5lUoZHaRXJt055x/z8QJ2WHwlcQIoVKnvBO7yKLMAeRoY4Qv51+HbakH+udR15LR
         7Icw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=oO5AKNsRSSnrJptTZQeQrJnBbvbH66aYrmljzYTwDeI=;
        b=HEW03tYX1uvBqrSxWZBgGTg0B4a2p3e0UfgaBsXzRqz0sL2sZEmZABiXYy0nUCw8a0
         /cNWFcSqHzlQRA7/28epOeLsAvD0dMqSyt7EAKfBDLArcd/U0JhU7rdbwePv/SsENKYh
         rcSQKcn34rJxX5Tw+Zgv8sWeRudvxbkKwlkgg9dxKVqf9nxLqMdVTKWSLENue7jR8bzy
         AfK2R6AJWE5kjLBRcfY5QY8P0eaNqPmGsSSrp1KUmdKiaCeZeblxQSutYwvK88ZgNBeR
         k4wf2fTa07xhvEqPg0aYdx3Q6GR1DEMXwxwideccU1/N/3A1sO/FJH8RH/KDhuW/Sx2/
         E9Tw==
X-Gm-Message-State: AOAM530HZeiKfjGH7DiemTFct57KJMaIgw1hyvO0SxwAfRpOi9MOyNiL
        C6CWQGkDGiR/idQ8bNTCJczJ3faOrBhp
X-Google-Smtp-Source: ABdhPJzA/kKG/MEzQLWxdX0i5sLjbYnvy9r6NmZGAqzO2NWb0EEu69DIMNoUCj2Q9OY9vkinfT9OrWVh8tdd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:636:a116:b1fd:c4e8])
 (user=irogers job=sendgmr) by 2002:a0c:e601:: with SMTP id
 z1mr14019739qvm.62.1621437139616; Wed, 19 May 2021 08:12:19 -0700 (PDT)
Date:   Wed, 19 May 2021 08:12:13 -0700
Message-Id: <20210519151213.2643570-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [PATCH] perf test: Test 2 libpfm4 error cases
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Proposed in:
https://lore.kernel.org/lkml/20210517140931.2559364-1-tmricht@linux.ibm.com/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/pfm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/tests/pfm.c b/tools/perf/tests/pfm.c
index d4b0ef74defc..acd50944f6af 100644
--- a/tools/perf/tests/pfm.c
+++ b/tools/perf/tests/pfm.c
@@ -155,6 +155,16 @@ static int test__pfm_group(void)
 			.nr_events = 3,
 			.nr_groups = 1,
 		},
+		{
+			.events = "instructions}",
+			.nr_events = 1,
+			.nr_groups = 0,
+		},
+		{
+			.events = "{{instructions}}",
+			.nr_events = 0,
+			.nr_groups = 0,
+		},
 	};
 
 	for (i = 0; i < ARRAY_SIZE(table); i++) {
-- 
2.31.1.751.gd2f1c929bd-goog

