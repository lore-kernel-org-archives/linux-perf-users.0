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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D57CC47088
	for <linux-perf-users@archiver.kernel.org>; Wed, 26 May 2021 11:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1322561360
	for <linux-perf-users@archiver.kernel.org>; Wed, 26 May 2021 11:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbhEZL4Y (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 26 May 2021 07:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbhEZL4M (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 26 May 2021 07:56:12 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E52C06138B;
        Wed, 26 May 2021 04:52:42 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id p39so724466pfw.8;
        Wed, 26 May 2021 04:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YoZUck6mACAcFeCLCeOjEWHKBtPQRIKZClOKQNYjnV8=;
        b=fs/DfN6PhqYJ1DzplFy/AcAmeFyJfFqoFw3v+wkUd4hCDuMm/2uR4D5xap3gYVdjqI
         FOeTuAw5fdZO01uM/qDzkovizBfq9hF/xmhKjQSmcSbQuq/c+pPMph/KD7HRtlo5tCKl
         8b7oKGfUxuRuuM2eNx1KEj8dgphL04tnv19StrhDiQu8e2lhi9fu/30lXXcqleuDfE7h
         QtDdm4KagbhEc9mTz+9Ybr0j/NuMFlHuHoxuLVklTSqbPrz5d7oe9trxKjPFSPC+VxIQ
         2Ujt0HzRh7EY+SNDsshTJR2uwxLklBjp/VctvdYUDOlo4yDp8xCDUN8kOznFnJPJuMjO
         tTFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YoZUck6mACAcFeCLCeOjEWHKBtPQRIKZClOKQNYjnV8=;
        b=E8EARdcOiiQhjpVRyR5U2a5LCndRYJuuw47cBIDU5gXZNvqsGOcLI4/sWiwEzAnOgs
         9oFxefDR7uzVVKxx99X/mFsh8fsHXYYk+LbwJDEwB80PfRjowKAVxcGe5G6fnsqfr2Xw
         1Qp/q/NAeJ57Wb0y2+fejZjaaFN9YRjg8AuQSmJh5OuS4cUDgr6ZFR4Pzq9pV4ojpw8L
         BnafqQMEqiEmmufyH6fP+PMdtHNWmtNXrB7Bw/hiSt+GpB56sjxhLkCaAnmq9lnUxlOy
         4ErvV6xmE0aZedRf5ILV3WmiKHgXxjIfZg0Bzw0D/AyIIgf/osR3QdbgoDN6mWKt5o9J
         vbPA==
X-Gm-Message-State: AOAM531VY2zqbN8DZ+Wd2Z3V4V2FO5+ZvLu7YmBXuHU+y0U2CJfaUAvV
        j9Rc5QOr2JDHRhlUMwec/IY=
X-Google-Smtp-Source: ABdhPJwL/ofltgpP8xnGH4jCxUlph5l9asAfrWd7iz/cw5gov5C5SFMWepRWx1HksVxiCIDLGOuaUg==
X-Received: by 2002:aa7:8d4a:0:b029:2e8:df53:cbd6 with SMTP id s10-20020aa78d4a0000b02902e8df53cbd6mr16327544pfe.13.1622029962361;
        Wed, 26 May 2021 04:52:42 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id s48sm15328843pfw.205.2021.05.26.04.52.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 May 2021 04:52:41 -0700 (PDT)
From:   Haocheng Xie <xiehaocheng.cn@gmail.com>
To:     mingo@kernel.org, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Haocheng Xie <xiehaocheng.cn@gmail.com>
Subject: [PATCH 1/3] perf core:  Make local function perf_pmu_snapshot_aux() static
Date:   Wed, 26 May 2021 19:52:18 +0800
Message-Id: <20210526115220.19134-2-xiehaocheng.cn@gmail.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210526115220.19134-1-xiehaocheng.cn@gmail.com>
References: <20210526115220.19134-1-xiehaocheng.cn@gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Fixes the following W=1 kernel build warning:
  kernel/events/core.c:6670:6: warning: no previous prototype for 'perf_pmu_snapshot_aux' [-Wmissing-prototypes]

Signed-off-by: Haocheng Xie <xiehaocheng.cn@gmail.com>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6fee4a7..0d98d6a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6667,7 +6667,7 @@ static unsigned long perf_prepare_sample_aux(struct perf_event *event,
 	return data->aux_size;
 }
 
-long perf_pmu_snapshot_aux(struct perf_buffer *rb,
+static long perf_pmu_snapshot_aux(struct perf_buffer *rb,
 			   struct perf_event *event,
 			   struct perf_output_handle *handle,
 			   unsigned long size)
-- 
2.9.5

