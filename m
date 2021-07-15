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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD36C12002
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 01:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2909C613D1
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 01:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235972AbhGOBhF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 14 Jul 2021 21:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236037AbhGOBhE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 14 Jul 2021 21:37:04 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147FFC061760
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jul 2021 18:34:11 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id h7-20020a5b0a870000b029054c59edf217so5428577ybq.3
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jul 2021 18:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1wHURlKzmxHcDsgqqsL7boqc8awDzR5MT7ZrdY0GfAc=;
        b=FhIUcbYKQWuBLjEcw6rTeD0kQZ0N62gcAnyt1AKJz2x9Dz1jbevUS5LNAVpsU7A6Si
         TrCpgnD/zGbmGc0F3owUEDbIG/IdEwNiqKYy0MymsXIVwbSrglxV6cUgVIaFzR8avAOY
         NIIid6gPuG/Cgd95Eyz7GAXtwdLtQLj9U1RGFA4RKcD5Rj4sIa6eqC/AJKbmNy4WCOiq
         x0HRQSMjl9+i+256MIGg2LLIxkGQ5MzUACPoLufGda/088yFbgWeP1enqsIwFax/hExl
         0OR8emoyXes6iW5MjspwCnWiaJMubsXfbIrEPqCdCqv3vOspxxrtte3B2MkQ8R22Hn8R
         O1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1wHURlKzmxHcDsgqqsL7boqc8awDzR5MT7ZrdY0GfAc=;
        b=IGppigG+gXGAtEHrhctnYwAVaNxjOljFVP5frhDcPa0eyyxZnhiN8wfds8Um0BLMXY
         lP2PE7pouzoh1PGFbxk480arAwI0gjaJf4b2LyX7Nr8GSTtNFep8C55VmyHklIpXp3JQ
         p9ezZqcW4qdKWzeJ/rzC0CBSqjvbN7icCc0rZrHr3WgbxvOP4DM8YnVNmtZq/M/GdBpX
         w5Cis3+CZLrGocnrPLRFU1dyFavERQi8fscjsnQsiSmR1Bb6NBytBmrknHKKXVqKz4RQ
         hQGuq9v9mpXGQZ8LB40dlFO3Dk88b5DgE368tjVrsozznxD9PetSYvhsi/7lGuOf+a8e
         u+lQ==
X-Gm-Message-State: AOAM532uXGVkb2F3utl2JxtmEu2Saen7hblDMFUinqZvaTOdQpCzaFHB
        pyGcC1D6UR5W0foc4MA2vVpq1I0qi9oi
X-Google-Smtp-Source: ABdhPJxbVDXRTy6sbjAARKBzB/mvgBEYIQUu73ZC19a6yWwKDW9uGGj/kjofLj71Lf31YTAM4v1rPCstk1XF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:c0a3:e3b0:6b14:de32])
 (user=irogers job=sendgmr) by 2002:a25:8146:: with SMTP id
 j6mr1349646ybm.28.1626312850299; Wed, 14 Jul 2021 18:34:10 -0700 (PDT)
Date:   Wed, 14 Jul 2021 18:33:43 -0700
In-Reply-To: <20210715013343.2286699-1-irogers@google.com>
Message-Id: <20210715013343.2286699-8-irogers@google.com>
Mime-Version: 1.0
References: <20210715013343.2286699-1-irogers@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH 7/7] perf doc: Reorganize ARTICLES variables.
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

Place early, as they are in the git Makefile. Remove references to a
'technical` directory that doesn't exist in perf.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/Makefile | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/tools/perf/Documentation/Makefile b/tools/perf/Documentation/Makefile
index 9d991b14ac4b..6e7b88917ca0 100644
--- a/tools/perf/Documentation/Makefile
+++ b/tools/perf/Documentation/Makefile
@@ -2,6 +2,10 @@
 include ../../scripts/Makefile.include
 include ../../scripts/utilities.mak
 
+ARTICLES =
+# with their own formatting rules.
+SP_ARTICLES =
+
 MAN1_TXT= \
 	$(filter-out $(addsuffix .txt, $(ARTICLES) $(SP_ARTICLES)), \
 		$(wildcard perf-*.txt)) \
@@ -16,13 +20,6 @@ _MAN_HTML=$(patsubst %.txt,%.html,$(MAN_TXT))
 MAN_XML=$(addprefix $(OUTPUT),$(_MAN_XML))
 MAN_HTML=$(addprefix $(OUTPUT),$(_MAN_HTML))
 
-ARTICLES =
-# with their own formatting rules.
-SP_ARTICLES =
-API_DOCS = $(patsubst %.txt,%,$(filter-out technical/api-index-skel.txt technical/api-index.txt, $(wildcard technical/api-*.txt)))
-SP_ARTICLES += $(API_DOCS)
-SP_ARTICLES += technical/api-index
-
 _DOC_HTML = $(_MAN_HTML)
 _DOC_HTML+=$(patsubst %,%.html,$(ARTICLES) $(SP_ARTICLES))
 DOC_HTML=$(addprefix $(OUTPUT),$(_DOC_HTML))
-- 
2.32.0.402.g57bb445576-goog

