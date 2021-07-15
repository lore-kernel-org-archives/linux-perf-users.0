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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D35C07E96
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66711613F8
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbhGOQKd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 12:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbhGOQKb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 12:10:31 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF36C06175F;
        Thu, 15 Jul 2021 09:07:36 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t5so8457535wrw.12;
        Thu, 15 Jul 2021 09:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mKOsdep4+AHMtJyYdkPwuXhq2BB+9CFGuNQWr4puijY=;
        b=iM2CI+kFsbchyBJETgmZhp6HPqxuYV/XVicaXJIFhvcjuNkShQsO0QxvJ4zHiCeW78
         WRzjK5SlWjHlGhL4RBq3G7UjnsNe3e4UjR8Fgz+MG5CDxmETSJJ+7iUQOVMEIRnj3T/o
         2bJrAtj2d41HYUvx0Obi2Rfd6Qyzp9dRvWGh7731sG85PgpxvfzAkLHGJjyE9PR6X1Ob
         gdiLigMFHlM8nkRey8GutnxuWfOp8psX+lF137qJO7wLR2p2hC2o2R7waudjSZhWdM0v
         xgRkcYgfYrY3kod3q2m9MGkUGyVKS7/lj7q4MiAFOmDMoLb02kcxkTZO0Pv7JG0QzyeT
         cLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mKOsdep4+AHMtJyYdkPwuXhq2BB+9CFGuNQWr4puijY=;
        b=kRAYkxY4cIaofrcQS0P+ulrZQXU4Od13AqrqsreL2MLHZm0/hyNd8f1FlmBuP0OHRE
         xk/peC8a4p/u5ZtYauCR0rrKgRfcDaT48gKiDMYU7RHXh32tLHu348apAoTBzbnzyj5w
         mws3YTricDlCZUnEE0OoWLYUfCY6wsYhPXaTmiefvMonSysx8ra6uOmy5vQ3ROkShZ0F
         Hb/U7vMMyIbZ6xE1zLSqegtxqZPbEb+xeyR691MSiHE0XxESUz/Ens8xzZtAHFLW5H8U
         NgCUrG58PgHsXO6qRyJ+LCsSpSICE8wbklf8DWQu8b+EW0IyTk/7IJjg1mdTatsT5vas
         xuHg==
X-Gm-Message-State: AOAM533Pc9PaPPDSWBGDlxzARgCa4l9XwRNjKUQpT4VwCfgdndR3fTke
        LCsOlAQHLK8HyvZ2emeiRlw=
X-Google-Smtp-Source: ABdhPJyBhxVrfItxsG76O6AbnGJn7MT/H95UPG8tGNmYuhAFJRXPBjUY0NPqoR0mWXxlGEoSusO1Ig==
X-Received: by 2002:a5d:4e4d:: with SMTP id r13mr6570410wrt.224.1626365255334;
        Thu, 15 Jul 2021 09:07:35 -0700 (PDT)
Received: from honeypot.lan ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.googlemail.com with ESMTPSA id k13sm7446952wrp.34.2021.07.15.09.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 09:07:34 -0700 (PDT)
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
Subject: [PATCH 07/20] perf test: maps__merge_in: fix memory leak of maps
Date:   Thu, 15 Jul 2021 18:07:12 +0200
Message-Id: <a1a29b97a58738987d150e94d4ebfad0282fb038.1626343282.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626343282.git.rickyman7@gmail.com>
References: <cover.1626343282.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

ASan reports a memory leak when running the perf test
"65: maps__merge_in". This is the second and final patch addressing
these memory leaks.
This time, the problem is simply that the maps object is never
destructed.

This patch adds the missing maps__exit call.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/tests/maps.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/tests/maps.c b/tools/perf/tests/maps.c
index edcbc70ff9d66e22..1ac72919fa358601 100644
--- a/tools/perf/tests/maps.c
+++ b/tools/perf/tests/maps.c
@@ -116,5 +116,7 @@ int test__maps__merge_in(struct test *t __maybe_unused, int subtest __maybe_unus
 
 	ret = check_maps(merged3, ARRAY_SIZE(merged3), &maps);
 	TEST_ASSERT_VAL("merge check failed", !ret);
+
+	maps__exit(&maps);
 	return TEST_OK;
 }
-- 
2.31.1

