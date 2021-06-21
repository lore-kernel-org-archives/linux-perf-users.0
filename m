Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40564C4743C
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Jun 2021 23:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29ABA60FF2
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Jun 2021 23:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbhFUXqk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 21 Jun 2021 19:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbhFUXqk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Jun 2021 19:46:40 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EF3C061574;
        Mon, 21 Jun 2021 16:44:24 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id h21-20020a1ccc150000b02901d4d33c5ca0so1066775wmb.3;
        Mon, 21 Jun 2021 16:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LGzFw4/zhJJykqlsIMyi5pwwSFK7n1uyNpDxg53rdIE=;
        b=QiICc3PCdJ+5oWewpbZFf7jOEh9wFeo4QoRSGaVHW5ykY3CtdoTOrCVJ0IaxxzKZkL
         I1SI5YsVZIBrylNRE679LJr7oex7iMfyh6kM8QVGnLRkIl4sj8UaEB7ebdXtTstlII5g
         LPZgyXDYMaMgNIE37mOBu7TqnJBIuKi1h5kBF0di5ysM8Tj7L6K6Re0WEQBWaTgQZP56
         U4418aOu/Zx+ceAZG0ZuPEl8fw87Pl8pwtp3jvsP/20Cpg6GKiFuozMbD2xbgbkr/41C
         TYAM+BqFwEafecnlAhE0InsCKX5AMnFfk/f1ke3enwth7E5Yx6xbxOxXqKwZgAcEpWL9
         llAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LGzFw4/zhJJykqlsIMyi5pwwSFK7n1uyNpDxg53rdIE=;
        b=fNkgElk53Gq3jXrW6kfurI9Ryg3dL1afdAcfovVn+u/L6Td1LjcyCh8D0ubD1QT0LX
         esaK7zINeVK65FA85n9PmAfz7WT1pK5d4dK+Nr9yovSLVgkrmQGgxDEjcx15Q74ffCnV
         TExliyyV32w9eLQ+hyFZHjYhy6HvFKZK8PHqvKiw5K0v9VgyyjCw9rjiwKeIJRFPtxjr
         IxWkB1ZTX4XC0G8GD0kALr0kqgvAJqGViRl0PUSw5rYUZdsLqCnZHYmBVdz6YMxFc+Yl
         wSwAbn4fGWkREELFfas5/h6nKHNHMMcRDN71aisnpAZ0XsMKskFt2+41ILHNiXN04rnm
         1WOg==
X-Gm-Message-State: AOAM531nVfIhw4+sPGScq4Xh2FTcxTOpRgazjK/r6QVrla6HGArAk99N
        7UdG6aJUWwlBa84KmYkBsJ8=
X-Google-Smtp-Source: ABdhPJxPTA+JLP9zNqgLc6MwO9gn6BvOjo1AsOTB4OJWsp8bWTOHYJ0spYPkxDqqpoaVPwm07gDoYQ==
X-Received: by 2002:a05:600c:35cb:: with SMTP id r11mr921312wmq.187.1624319062838;
        Mon, 21 Jun 2021 16:44:22 -0700 (PDT)
Received: from honeypot.. ([151.29.45.200])
        by smtp.googlemail.com with ESMTPSA id n18sm473130wmq.41.2021.06.21.16.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 16:44:22 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] perf script: delete evlist when deleting session
Date:   Tue, 22 Jun 2021 01:43:19 +0200
Message-Id: <20210621234317.235545-3-rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210621234317.235545-1-rickyman7@gmail.com>
References: <20210621234317.235545-1-rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

ASan reports a memory leak related to session->evlist never being deleted.
The evlist member is not deleted in perf_session__delete, so it should be
deleted separately.
This patch adds the missing deletion in perf-script.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/builtin-script.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 1280cbfad4db..635a1d9cfc88 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3991,7 +3991,7 @@ int cmd_script(int argc, const char **argv)
 		zfree(&script.ptime_range);
 	}
 
-	evlist__free_stats(session->evlist);
+	evlist__delete(session->evlist);
 	perf_session__delete(session);
 
 	if (script_started)
-- 
2.31.1

