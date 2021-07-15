Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D83C47E4B
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D020613F6
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbhGOQK1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 12:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbhGOQK1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 12:10:27 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D29CC06175F;
        Thu, 15 Jul 2021 09:07:33 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k4so8452227wrc.8;
        Thu, 15 Jul 2021 09:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oPqoI64FABaKjdFYPgM6tAP/Q30NeajCJabF0tjvs5g=;
        b=qNvFIltehBU52bCKU/WYyAvG+ZAoXCWbSW/6LuzAdCkLuUI+AXjwCdeq0W2Sq+gUWp
         huQnyKB31Qnh3DHyfkMnGhu9T/18eMjLW/poRBod9q6SknNBipbR4dYKLMfNMx2lkl/a
         b/yMvesZFg72XVVGmVgvN62bZ/NIGwqihjb4bWlhmQK32dZMTbS7xOrys8ruMVRdi2WO
         Z9DwPjAIuBcqfxQiF31qpOpJXtSaTvWAt3dKvEAayogAJhBcHk4/IGvc/lVSTlCa5jUk
         g0UA+YDzNWwt//gUZRAo71Sq2dHG4e8cmZnsjJO89meaEaBoCwEWhxWOtXsy2SJ5SZFn
         5RTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oPqoI64FABaKjdFYPgM6tAP/Q30NeajCJabF0tjvs5g=;
        b=VAJKlvFxTa/XLFXNWTSjKMAdMNMplJqil0b22RenKNc4+FX/wSaaUh3PqZX31p+QmX
         iTaGD+WXmaI5PSTN0zQkSv7srcpFLwexFPXL7eWV5pbr34oZg/aWvrS8x2vJbcP7+vug
         dbguM8PhwtYROQx08tEmbsc4ze2nuCFeOxzl0xeCjJLF344g2CcIdUxJBofIKt2q/Ea4
         h4Txs1uVU6kP4wURIOx0qCRmFIxwyzQ/tSaHQ78bEleEITF8tiguA3GG8NF2+Z/vY3dW
         NdjOA4RcohRzvezi6xkQkucY8XU7LjPDk2BTvr1SY3pL7t3T6DYD3KKbLztj6LIEOLJB
         czGA==
X-Gm-Message-State: AOAM5331PJ8lpxGZkeVMt5CYR94d2hTlgJGN5cHs6DVJiV6IuxbB/Et6
        E2awpeC4SLFatNyuYRigPLs=
X-Google-Smtp-Source: ABdhPJwjFxwnG9CiuNXkbY9CqadJXfcnxWjGAKtMVAtIJPqLqR9U08ik686UIQgtQxvE2xNmjYO8eA==
X-Received: by 2002:adf:fcd0:: with SMTP id f16mr6699881wrs.368.1626365251980;
        Thu, 15 Jul 2021 09:07:31 -0700 (PDT)
Received: from honeypot.lan ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.googlemail.com with ESMTPSA id k13sm7446952wrp.34.2021.07.15.09.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 09:07:31 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: [PATCH 04/20] perf test: event_update: fix memory leak of evlist
Date:   Thu, 15 Jul 2021 18:07:09 +0200
Message-Id: <f7994ad63d248f7645f901132d208fadf9f2b7e4.1626343282.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626343282.git.rickyman7@gmail.com>
References: <cover.1626343282.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

ASan reports a memory leak when running the perf test
"49: Synthesize attr update" caused by evlist not being deleted.

This patch adds the missing evlist__delete and removes the
perf_cpu_map__put since it's already being deleted by evlist__delete.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/tests/event_update.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_update.c
index 656218179222cc58..932ab0740d11ced6 100644
--- a/tools/perf/tests/event_update.c
+++ b/tools/perf/tests/event_update.c
@@ -118,6 +118,6 @@ int test__event_update(struct test *test __maybe_unused, int subtest __maybe_unu
 	TEST_ASSERT_VAL("failed to synthesize attr update cpus",
 			!perf_event__synthesize_event_update_cpus(&tmp.tool, evsel, process_event_cpus));
 
-	perf_cpu_map__put(evsel->core.own_cpus);
+	evlist__delete(evlist);
 	return 0;
 }
-- 
2.31.1

