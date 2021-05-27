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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDADC4707F
	for <linux-perf-users@archiver.kernel.org>; Thu, 27 May 2021 03:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AFD2613DA
	for <linux-perf-users@archiver.kernel.org>; Thu, 27 May 2021 03:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbhE0DVs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 26 May 2021 23:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbhE0DVr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 26 May 2021 23:21:47 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D4FC061574;
        Wed, 26 May 2021 20:20:14 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id n6-20020a17090ac686b029015d2f7aeea8so1511692pjt.1;
        Wed, 26 May 2021 20:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SgrK0Rp+6uI7UXrVdr3LXkgGvvUlF/qXSVzV7pcp+dQ=;
        b=m+G4xSsgL4jGqmdti4+nulAb9NJwATCnxtZD3fa2GDfApX/qhbiZQnmY45fwNX6pIY
         kyxYkSZ0xMxMyfis4i8glVrAQLHU4swf4ILoUXgwxZj0bWbX/i09ZqWTwbB5G5qT84Ie
         o1G5EzRVa4Rfy4VcSVGUYP8K6xwCFJ9Zz11FL/hRWRObzCnmRtVrKcKw4IGFz9I6uOZg
         TTQ3evA6prBlD2T1dvJL0z0PaPtLU+YXUbX63b6Ih4y5OYo46+5CLafxvdZZihAxv153
         JdrDX0HuDxMsJlH+gHBJ3Nmnpz7N1Ti97eqgLqA/DiIL+FLiHWWHRRYFXkf6/Ptjhf96
         JgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SgrK0Rp+6uI7UXrVdr3LXkgGvvUlF/qXSVzV7pcp+dQ=;
        b=SHrKAgBhnmZY1FSI86NrfRoTkPMT6boUxFXvedgKXwx67vmzajIRp2Yt9Qx7KhC47G
         wSGsi5BSyPEu9QtMoxK/JEsh/11eR5PP6GfOf+Kz3EaFO2fj9CBK+sD2tT+9AyrCsYno
         p8znv9yiU3/rc5miu4GX0vV7dTWHRhnFJpzoGiHfX7nc5rGP+K5RsND0JYw234U/seXo
         WHXryT+s+82Tq0qNLNRkh3MgoXYk5mxfpKQUw4ly1AAJRJp/un+8Dk6YCJKrEQNWuWWF
         XBygqYCLGxl/9Z9Ks/iU24wWPsltpvf7I+V+YIqpCRilO8/Xc4FKQHZxMWwb4bhJTUyj
         NNUw==
X-Gm-Message-State: AOAM533OiMIoSvdb+XvDxtnsocQSaUjE+PvLcKqyXgfmhq/f0Ks3jHFN
        nGwLCPNmUGTxew4kXcA1pjo=
X-Google-Smtp-Source: ABdhPJwgDcbx1nJqHEPdDVcuj4ZVsumMTPfLV45SpffxECp5DHnBlCQl9LPR7TLAOdBmDp2fz0nKQw==
X-Received: by 2002:a17:902:d643:b029:ef:62cd:eeed with SMTP id y3-20020a170902d643b02900ef62cdeeedmr1328780plh.42.1622085614021;
        Wed, 26 May 2021 20:20:14 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id l6sm554716pjf.28.2021.05.26.20.20.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 May 2021 20:20:13 -0700 (PDT)
From:   Haocheng Xie <xiehaocheng.cn@gmail.com>
To:     mingo@kernel.org, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Haocheng Xie <xiehaocheng.cn@gmail.com>
Subject: [PATCH v2 1/3] perf core: Make local function perf_pmu_snapshot_aux() static
Date:   Thu, 27 May 2021 11:19:45 +0800
Message-Id: <20210527031947.1801-2-xiehaocheng.cn@gmail.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210527031947.1801-1-xiehaocheng.cn@gmail.com>
References: <20210527031947.1801-1-xiehaocheng.cn@gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Fixes the following W=1 kernel build warning:

  kernel/events/core.c:6670:6: warning: no previous prototype for 'perf_pmu_snapshot_aux' [-Wmissing-prototypes]

Signed-off-by: Haocheng Xie <xiehaocheng.cn@gmail.com>
---
 kernel/events/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6fee4a7..e1a80e1 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6667,10 +6667,10 @@ static unsigned long perf_prepare_sample_aux(struct perf_event *event,
 	return data->aux_size;
 }
 
-long perf_pmu_snapshot_aux(struct perf_buffer *rb,
-			   struct perf_event *event,
-			   struct perf_output_handle *handle,
-			   unsigned long size)
+static long perf_pmu_snapshot_aux(struct perf_buffer *rb,
+                                 struct perf_event *event,
+                                 struct perf_output_handle *handle,
+                                 unsigned long size)
 {
 	unsigned long flags;
 	long ret;
-- 
2.9.5

