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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444BFC4743C
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Jun 2021 21:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25F8261164
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Jun 2021 21:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhFUVow (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 21 Jun 2021 17:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhFUVow (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Jun 2021 17:44:52 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40F7C061574;
        Mon, 21 Jun 2021 14:42:37 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d11so18876746wrm.0;
        Mon, 21 Jun 2021 14:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2kIxbJ5p1hWp8t+v1VsmjQyHEIPMSprKSEwd932/Pb8=;
        b=uCeZNaem5Z5JlwRjX6SdVoD45e5/KbyFz/G47OchLMlN0pH6tZEIqvm9mumYHztAID
         lMLz1cZLtHD5MaIYaj0bAxvkNBtnkLgdB/CcWaljfw0qOezWWUU9OGmjVulkGSsWWtPY
         MqIkdTQmq6ca7n5Tx5/EIV5ryfNBNnYkxHFMUCcE6Pv9Ie8cjEfoNASEZbUqT1KL++8X
         +4hykG+zmQ0ZVVU6XldDf1gMedIqWxuODS347eXHILnPo1E5pNeVfethhTF5ad7ZgFHW
         P7tuC67EtD3hmK1TgScC3XmXWGZqWOF3Cah+jTBYbqKs8jzi5raUdUslApyV1VT3mzeb
         5UoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2kIxbJ5p1hWp8t+v1VsmjQyHEIPMSprKSEwd932/Pb8=;
        b=BcTvEpaVIIbx0OTsLbCop13i7deQ1dxHMbMDeKoV8SN0aNn8kpAF92Ay6HUCIFq/+7
         xhpIGMbj1fGxMt0uKDg4LY4zxttGH6b/hVw10R7PFj8O8sg8IRMG8HGygB46QVhOMY0D
         BRtyJtADhA6e/NdETPDRjQhTqUf4GtNRcu6mJYtv94kkl5c4YbhYv6V9wIaqtdxpbM4i
         ef87SqTLj/OUG3LgJH4tHp+px62ekfxPahWxcasBUPH2h1Dy3TdiJXPy7Vwko7QfmdQE
         aO9cCv9uVV7cEPRh2AhWs0aWTmB8ZwxUJdhV6p+PoQkF6NW0ilOS2bCd6Dp/6gPbhIo3
         O58w==
X-Gm-Message-State: AOAM5311NoBsLQ3qI/uJnXji1FqhCciPSWc+LL5UULjx+29znhAZwZhK
        952svqJiwKnx2vmbQu5JvKU=
X-Google-Smtp-Source: ABdhPJwCUTb9mch7bOyLRl56DvcyA06rZ0zKQvPxWWyoCsDlroTrH2fkGRp8k21mKrW2GspuV9KCcw==
X-Received: by 2002:a5d:6091:: with SMTP id w17mr583693wrt.241.1624311756322;
        Mon, 21 Jun 2021 14:42:36 -0700 (PDT)
Received: from honeypot.. ([151.29.45.200])
        by smtp.googlemail.com with ESMTPSA id y16sm15316045wrp.51.2021.06.21.14.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 14:42:35 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf data: close all files in close_dir
Date:   Mon, 21 Jun 2021 23:42:19 +0200
Message-Id: <20210621214220.167927-1-rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

When using perf report in directory mode, the first file is not closed on
exit, causing a memory leak.
The problem is caused by the iterating variable never reaching 0.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/util/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 8fca4779ae6a..70b91ce35178 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -20,7 +20,7 @@
 
 static void close_dir(struct perf_data_file *files, int nr)
 {
-	while (--nr >= 1) {
+	while (--nr >= 0) {
 		close(files[nr].fd);
 		zfree(&files[nr].path);
 	}
-- 
2.23.0

