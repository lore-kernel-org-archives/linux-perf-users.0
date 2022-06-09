Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194DBC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Jun 2022 04:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237430AbiFIEJj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 9 Jun 2022 00:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237375AbiFIEJi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Jun 2022 00:09:38 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AC624BCA
        for <linux-perf-users@vger.kernel.org>; Wed,  8 Jun 2022 21:09:36 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id y187so20758247pgd.3
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Jun 2022 21:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ouk7+Ke+HW093nWEFwQ5D14yOFTrhJHXFT/fgT162bQ=;
        b=EUct5RkmkaOLADrUzrUz5MXFt81MEoAJJPQJNDRYKMCCRgMZ+kpm7cCxAhIKTHtBIy
         6Ck22WNMJHvCfqO1etE0f3llvL4v4UBLX0+xI8w0HSPYbCQcndGrC1usEzdb3gec1gDs
         r9LmND37fJbm//K7ZnhlrftOLznexRtzA4jYLPCUoSCxcaIf368C0a7TXbTzz/yjqjIF
         6HbsJ40OBeJiq2fUgVMTzVkuwMGQvFeE6Fe+9nl+54rE57gO/x3OB04MJj1SFrXgfoGL
         PrIJ06T8iIGeeI5L449Pk48yWbe7VsQBAfmkgLKjIvD3gFbxC0PQGqjE0hMxkncI/i4x
         My1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ouk7+Ke+HW093nWEFwQ5D14yOFTrhJHXFT/fgT162bQ=;
        b=sUjHYbtI2t7a1rL/gbDr0lYLBFOEnqcvYuoqc1xLXz2Z4I+hXOUb24jebi0qe29869
         YKXEY7VOHupaYL+AooNzNx2deD8LFW7bcW0UGGT5qYwKH6MiQVJei7s7xAw9i69BtWlM
         eQmDiZSv6Xp7AvhtVhWKpqwxI694RbbebjYaotCUHrPc2EIt2cJzfhzKCh0B7hGHn1z/
         zC5xdYXUpcsamSkITjUz1cSfwDI+faE7UENBTXrsk2kWmE1Trd82Szw+V5wvw0tcLY60
         gVs1GxHT2dFcnOIhpakixXZKfKDk4EJFeEwDwdl+uvxxDCrhFxPeEXqn9bje5qPomHqm
         M5qw==
X-Gm-Message-State: AOAM530IHtniv28XNv+7dPZPJl2VgWxG1P1xQkM8Py8zz6YtDJkclUtR
        LrPTa3bJKIEuBJQDfnkJAjSxZyeVAagzOvQ+4qs=
X-Google-Smtp-Source: ABdhPJyRq3/5D98T+QkcS5O1SPAlo57Uw3qIqKhI1hJS+mY3bjIHB2P9+hfcTjWWZR59I3qe2NQuBA==
X-Received: by 2002:a63:5:0:b0:3fe:2558:677 with SMTP id 5-20020a630005000000b003fe25580677mr7137001pga.113.1654747776233;
        Wed, 08 Jun 2022 21:09:36 -0700 (PDT)
Received: from C02FT5A6MD6R.bytedance.net ([2404:9dc0:cd01::1c])
        by smtp.gmail.com with ESMTPSA id j18-20020a170902759200b001624965d83bsm15592967pll.228.2022.06.08.21.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 21:09:35 -0700 (PDT)
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
Subject: [PATCH v1] perf trace: Enable ignore_missing_thread for stat
Date:   Thu,  9 Jun 2022 12:09:24 +0800
Message-Id: <20220609040924.12885-1-ligang.bdlg@bytedance.com>
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

