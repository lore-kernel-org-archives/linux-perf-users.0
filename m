Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DB7C4332F
	for <linux-perf-users@archiver.kernel.org>; Wed,  4 Jan 2023 19:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240124AbjADTe0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 4 Jan 2023 14:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240138AbjADTeT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 4 Jan 2023 14:34:19 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EB51DDE5
        for <linux-perf-users@vger.kernel.org>; Wed,  4 Jan 2023 11:34:17 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-46a518991cfso325990577b3.18
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Jan 2023 11:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1tPYYgfmJsbQWqu0ltxW4RY1Nkj1mo/Al1PbZ2zMD4Q=;
        b=smJNk0zhuo1/1zHEXj0d6yRUmkqnDpfIx58BEn/cGg72LNn90pxpjarz3SeORF9+yR
         yl478rY3Qppd5f2Y2rZddHE4v8a3gs+QAutJk1j+5azEWDoaxwtIegEqQuDJ3prj1Dnd
         1SykFQVuvIO49v0UGRh5vXfggrpNq1r2pN7O6akJ9lVtiSpQ6r25tG99U4dkahMHP0fZ
         ugdj2OGR8BNOj38eCHSjfyUB+X0SwCYD98iAle3qi1XqCvIJGo/NsOnerjHn262s7apJ
         4n5Uq6j6d+L7QR9x+bLGU1VyjWUbIhmGiO8nuCF7RLGyL5gvU0COr4DthqITRqypavI+
         /d9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1tPYYgfmJsbQWqu0ltxW4RY1Nkj1mo/Al1PbZ2zMD4Q=;
        b=sGu8s72tK0/kkIB3ucg/GKk6PRMZW1qzpN4IcrNc1TWbWZvJFHBS92CFzZuoPKZ0F5
         rf459jSp1dv6QQFA5x5WjVEKUO81m5cypSfIw2rVmZvP2w7PdNbQTaexztnwZTn8lFdC
         dMCUV5eLHH0IOeL16TTrjQMk6CNsqlXz7c2ab2Xsu+DBfZZBIRp156BVNyO+0LRCMWHL
         TTZ6WYH/W9UHVtp0pXgmQmNHpB8MQdBIfvHNrYQe5ihTwBIw3uxrjrr/lk0qnSo8JzQf
         53nsWQzGOl7hriWNbufJlB8oth+kbvn4opCBM/L3evYY6sF8sd4zc3tEOA2C0hBshmmN
         AA3A==
X-Gm-Message-State: AFqh2kpo9y5vEr07ehvUwlbZglZSVYRlaupJq+ofAWxNyfqBPjH0xlwz
        EXNciQ05L3ij+1nLvgrJpPYUV1hQwKkz4H3EGZKotOI6MsJQV1JwognlVTGcLcfTdysMLICYhTH
        48VrBUWsD0c5NN/O0gEZNpx5vqQ0VO09T9sssj3KdBraUunxkwja9LJwlHHwUOX4LXJBe17DhNR
        0ihAJoKmM=
X-Google-Smtp-Source: AMrXdXudx83GP3Mrrft7oAK5KgZusnNPxKJ/c9Yu72lCZ4dQmJoXMT56KJYtoNZOE58Swk/uWBTV1OiO8Y3xHSU=
X-Received: from jesussanp.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5f10])
 (user=jesussanp job=sendgmr) by 2002:a25:790d:0:b0:7b0:62c8:d02b with SMTP id
 u13-20020a25790d000000b007b062c8d02bmr433902ybc.272.1672860857141; Wed, 04
 Jan 2023 11:34:17 -0800 (PST)
Date:   Wed,  4 Jan 2023 11:34:14 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230104193414.606905-1-jesussanp@google.com>
Subject: [PATCH v2] perf: Add missing sys/types.h include
From:   Jesus Sanchez-Palencia <jesussanp@google.com>
To:     linux-perf-users@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        Jesus Sanchez-Palencia <jesussanp@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Not all libc implementations define ssize_t as part of stdio.h like
glibc does since the standard only requires this type to be defined by
unistd.h and sys/types.h. For this reason the perf build is currently
broken for toolchains based on uClibc, for instance.

Include sys/types.h explicitly to fix that.

Fixes: 378ef0f5d9d7 ("perf build: Use libtraceevent from the system")
Signed-off-by: Jesus Sanchez-Palencia <jesussanp@google.com>
---
 tools/perf/util/trace-event.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index add6c5d9531c..9b3cd79cca12 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -4,6 +4,7 @@
 
 #include <stdbool.h>
 #include <stdio.h>
+#include <sys/types.h>
 #include <linux/types.h>
 
 struct evlist;
-- 
2.39.0.314.g84b9a713c41-goog

