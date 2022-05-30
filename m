Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B77AC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 30 May 2022 08:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbiE3IhI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 30 May 2022 04:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233936AbiE3IhG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 30 May 2022 04:37:06 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3CB65C5
        for <linux-perf-users@vger.kernel.org>; Mon, 30 May 2022 01:37:00 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id i18so9984390pfk.7
        for <linux-perf-users@vger.kernel.org>; Mon, 30 May 2022 01:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UhkR/xwMVW188JuNs6C6f8j4661lnOTgyOGhSkFU51U=;
        b=RX8p/ioqUv9vKJwWEHErAhzsNdDv+lzw6ldOZ2tLzYsA2BtTduGeCybTgIGcEPbL8x
         FPPS0TqIzDyDYPidnLHRdx8lkvCC4f0d2TBBCfUeqVVdMnusVqefk68FoljFIjusekHA
         7qlmnfJzNpZsagijS0GsAvGOzoV2EJ9TQh01ZZFVwCuLY99sc0sGqdOIzW9ykFwyxvSo
         uzdjWRuYxBvJsgxSRHri4PmmvQCz1yiLFiLOZq9m2YkYUdLqRtqXt4sC4zvohBWnkcLs
         21q0aMSrAuPk1cbY0C4cVwjaRPKYymHsLDqG5EVDxKhGMyYXaqGzzQnQ7BIKMdabRyKD
         MqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UhkR/xwMVW188JuNs6C6f8j4661lnOTgyOGhSkFU51U=;
        b=0QWGDLEA7Nmk4AqGcvZPn+3LF8qmmGBLD9CnQ4fn8jeINv61kXizIugBjNoaIoPyuM
         F9cDgdvtPnJBvToaErWGEvc8Vt0rNtk6UaKGd3iTUE0Q3u6+75wdmU3FVnH+aAE1fjll
         HpVvHxr70TKBxAF6/IvRL0LmN0Do2F4pztnRdCB9w5SsD3OEZzzlYAsneY6yzFEBvACi
         KFvC1EshZoOQeEcshXvLM9gdpxVbIFPp1rOO0bHzpgCmP7Y4Q+zzFCgfcmHAIpgfKu3k
         byrRThh1mbmf4ch8W5Jcx+YSKKcOGs0MkBzKQlWg4/a9zvoFMJAq/VUHBgy3vSPPdJ2K
         uaKw==
X-Gm-Message-State: AOAM532NwP+iwmm1AFFbi7piVw2HWOr4w+L6AqoxqV2qTSgipwzKeZ7R
        Pvu0ZE7UgNIAdy5nIQNELGrmHA==
X-Google-Smtp-Source: ABdhPJwmlOiMnXPNpqTc1QvLvtX4BdfJK0TQYozh+L0RCqyyIOrqFxwHS8VViVjHuwYOBBoy/5b7UA==
X-Received: by 2002:a65:52cd:0:b0:3f5:f3fb:6780 with SMTP id z13-20020a6552cd000000b003f5f3fb6780mr49020668pgp.150.1653899820324;
        Mon, 30 May 2022 01:37:00 -0700 (PDT)
Received: from leo-build-box.lan ([46.249.98.195])
        by smtp.gmail.com with ESMTPSA id c20-20020a170902b69400b0015e8d4eb1e5sm8556786pls.47.2022.05.30.01.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 01:36:59 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        German Gomez <german.gomez@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] perf mem: Trace physical address for Arm SPE events
Date:   Mon, 30 May 2022 16:36:45 +0800
Message-Id: <20220530083645.253432-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Currently, Arm SPE events don't trace physical address, therefore, the
field 'phys_addr' is always zero in synthesized memory samples.  This
leads to perf c2c tool cannot locate the memory node for samples.

This patch enables configuration 'pa_enable' for Arm SPE events, so the
physical address packet can be traced, finally this can allow perf c2c
tool to locate properly for memory node.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/arch/arm64/util/mem-events.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/arm64/util/mem-events.c b/tools/perf/arch/arm64/util/mem-events.c
index be41721b9aa1..df817d1f9f3e 100644
--- a/tools/perf/arch/arm64/util/mem-events.c
+++ b/tools/perf/arch/arm64/util/mem-events.c
@@ -5,9 +5,9 @@
 #define E(t, n, s) { .tag = t, .name = n, .sysfs_name = s }
 
 static struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
-	E("spe-load",	"arm_spe_0/ts_enable=1,load_filter=1,store_filter=0,min_latency=%u/",	"arm_spe_0"),
-	E("spe-store",	"arm_spe_0/ts_enable=1,load_filter=0,store_filter=1/",			"arm_spe_0"),
-	E("spe-ldst",	"arm_spe_0/ts_enable=1,load_filter=1,store_filter=1,min_latency=%u/",	"arm_spe_0"),
+	E("spe-load",	"arm_spe_0/ts_enable=1,pa_enable=1,load_filter=1,store_filter=0,min_latency=%u/",	"arm_spe_0"),
+	E("spe-store",	"arm_spe_0/ts_enable=1,pa_enable=1,load_filter=0,store_filter=1/",			"arm_spe_0"),
+	E("spe-ldst",	"arm_spe_0/ts_enable=1,pa_enable=1,load_filter=1,store_filter=1,min_latency=%u/",	"arm_spe_0"),
 };
 
 static char mem_ev_name[100];
-- 
2.25.1

