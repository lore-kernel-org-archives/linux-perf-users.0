Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885E0C43334
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Jun 2022 03:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356032AbiFVDBF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 21 Jun 2022 23:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356000AbiFVDBF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 21 Jun 2022 23:01:05 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCAD38A0
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Jun 2022 20:01:03 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id i15so14194437plr.1
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Jun 2022 20:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ouk7+Ke+HW093nWEFwQ5D14yOFTrhJHXFT/fgT162bQ=;
        b=jA3j6FyEGH1/5+bAOoD0Ib6WIKkZ8k/bg0Bzh4SHDOYIX6jgNPmYo0CZ/UQuaxDX82
         QhRVKdI1oq0Y3/NM2baS1JMSBo6vgjYgZmMw3fEsdr5hOYZtkbpK31n0c37FcL5u3wR3
         V9snxpgc69x/y6owSUvi0gCiZom2KJ6j0q+dt9BnBKNi9K+KV8hbTJJDKgBAc0cN8lrO
         LjK1V9saaKmDQhIURvWjvQixzioaM9CTFXT2AC4FYniZrdfiirM8cg0U9nqSPlF7dz3q
         feqbriu0sGFdTsoHBwfOJj5UvT0kfLCh0QteCTOsUqW03a+7gjSxoWOL4rZE3xfKOiuy
         srlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ouk7+Ke+HW093nWEFwQ5D14yOFTrhJHXFT/fgT162bQ=;
        b=pKRkKwJcB1ddEDuH/N3dtX1Hy8CSj2UgmAoDVjQ9ARHLpe+mLXyFGo+S9IdOkKIa6Q
         ET7tmKvr4Rd7yZwYBFDByNrd5cTKx7g9u1bcQuvWGlMLPHaAYfBAyOPlxw575y2CLYLe
         AyseCorKMQYHGNiZAXO8CK38hBQ5/MEQiVxWcvTFxNhBWdy1RC10gSNTrc2ZnZZBALnH
         d4uX70VcttTkr8YZcH8TSRtQZkDY60bq/C8pPTKLdh29HJmwEGmm8Z4CWd4M8SQTO71C
         M8PnhKOXzdAKZGSQEnSjrznC7Ac6ct0F39F7QCE4+9b48FM0sF5s7FqjAsa4PcHjOLB4
         kONg==
X-Gm-Message-State: AJIora90h1WefAkAaJu6e7QMGV2IPA+7IZAl5Lti1B1dRNhMv9YX0X9J
        d6BUnEHXo2qpzfb6pduBCFfI4w==
X-Google-Smtp-Source: AGRyM1sIw0vkJI0h3xc94T1nViSALDbu1qL270YXWZwxWkMDEIkDFHduJOG0UYjLJS+cTW+qxf2ywA==
X-Received: by 2002:a17:90b:3d91:b0:1ec:d594:31f5 with SMTP id pq17-20020a17090b3d9100b001ecd59431f5mr1281779pjb.114.1655866863236;
        Tue, 21 Jun 2022 20:01:03 -0700 (PDT)
Received: from C02FT5A6MD6R.bytedance.net ([61.120.150.78])
        by smtp.gmail.com with ESMTPSA id r13-20020a63b10d000000b003fe28130b12sm11769790pgf.62.2022.06.21.20.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 20:01:01 -0700 (PDT)
From:   Gang Li <ligang.bdlg@bytedance.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Gang Li <ligang.bdlg@bytedance.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v1] perf stat: Enable ignore_missing_thread for stat
Date:   Wed, 22 Jun 2022 11:00:37 +0800
Message-Id: <20220622030037.15005-1-ligang.bdlg@bytedance.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

perf already support ignore_missing_thread for -p, but not yet
applied to `perf stat -p <pid>`. This patch enables ignore_missing_thread
for `perf stat -p <pid>`.

Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
---
 tools/perf/builtin-stat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 4ce87a8eb7d7..d2ecd4d29624 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2586,6 +2586,8 @@ int cmd_stat(int argc, const char **argv)
 	if (evlist__initialize_ctlfd(evsel_list, stat_config.ctl_fd, stat_config.ctl_fd_ack))
 		goto out;
 
+	/* Enable ignoring missing threads when -p option is defined. */
+	evlist__first(evsel_list)->ignore_missing_thread = target.pid;
 	status = 0;
 	for (run_idx = 0; forever || run_idx < stat_config.run_count; run_idx++) {
 		if (stat_config.run_count != 1 && verbose > 0)
-- 
2.20.1

