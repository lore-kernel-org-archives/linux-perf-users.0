Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70B2C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 27 Apr 2022 15:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240462AbiD0PyS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 27 Apr 2022 11:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240518AbiD0PyH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 27 Apr 2022 11:54:07 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC31254FBC
        for <linux-perf-users@vger.kernel.org>; Wed, 27 Apr 2022 08:50:53 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id iq2-20020a17090afb4200b001d93cf33ae9so5328588pjb.5
        for <linux-perf-users@vger.kernel.org>; Wed, 27 Apr 2022 08:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n9mbHgP4oIrBWKuBGSVuQJ/xfzioNAnEfGDPfU6omQE=;
        b=xh5Sq2ByBdI49RmxJdtiP3Dj/LfrXSKDe1Mx1s+TvGy3fdHmeCb+HVLVL4DYOhWqc4
         lQz9kni44Kfonad1tD4ZZVydqTOnhq9NijS4hD1ZGcC51OKntcIkpOsQej/5zN1LvGno
         i+AFqLyM1bjfCLWiHpHDqEJvUTYEFA3sudeKCFzP6BtuyEXlok8cuC0bEAinhWja4SI8
         PkqPuDfyK8IGfaWwI0l4cbENS7sBdDu/ioj5lBn/BIirfpO4UJUCR3S1rIeaEFiQtR6q
         eaTLxy203vweB5gtzR+kZlyPDmpw/Qvf3Q6rrgwjWhO0vXH1bgFGUKCZaMTsPaXE+sz4
         Iz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n9mbHgP4oIrBWKuBGSVuQJ/xfzioNAnEfGDPfU6omQE=;
        b=jGW8cqkwYu16MeTZYOUIjYy109GTrt5RAku0dcP/qkH0TcAxsw4u8zKa+Nzhzyz1He
         b3/gTG/ATx0nZOyxeyke4vXBtDrTwSU959PryKdvwRQJ6RWY61qEBU5GQNhglmQcabJ9
         /8o1GM4oE7nm6Sa3aoZIhFIJQ2zrZ785rPtFcnBR/oW/M059odl3JopDUO670H6BJf4k
         sDiJ7dM/lE5PMlvrs9adbp4h6YPhR3/j3cEkoKIIKSG6RGyPpe3aRXc9XwH5cJyW96Je
         VOZBfAEWUGchIV9ezEXuKI6tNIuNxPfYAylI8lXI3nQkeEaXn8NuK+JA8dTxDPX/ujO8
         w6nw==
X-Gm-Message-State: AOAM531UtROamrHx8T9uTq44JHQYEaBNwjBxqws4TVaWi2attLBtAERf
        +2Rlei9nDH87h8wJeTbUUk+xHw==
X-Google-Smtp-Source: ABdhPJxdZHLEK54DZhgcXwH5DrvFcLQ50XRUP/0XQ/Ogc+I/NhNqHONX0nS0LgGknwdiedirSifvkw==
X-Received: by 2002:a17:90b:4ac4:b0:1da:26e3:b3a2 with SMTP id mh4-20020a17090b4ac400b001da26e3b3a2mr6224072pjb.49.1651074653010;
        Wed, 27 Apr 2022 08:50:53 -0700 (PDT)
Received: from localhost.localdomain ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id v65-20020a626144000000b0050a839e490bsm19164127pfb.185.2022.04.27.08.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 08:50:52 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, Alyssa Ross <hi@alyssa.is>,
        Like Xu <likexu@tencent.com>, Kajol Jain <kjain@linux.ibm.com>,
        Li Huafei <lihuafei1@huawei.com>,
        Ali Saidi <alisaidi@amazon.com>,
        German Gomez <german.gomez@arm.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 04/11] perf mem: Add statistics for peer snooping
Date:   Wed, 27 Apr 2022 23:50:06 +0800
Message-Id: <20220427155013.1833222-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220427155013.1833222-1-leo.yan@linaro.org>
References: <20220427155013.1833222-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Since we have added the flag PERF_MEM_SNOOPX_PEER to support cache
snooping from peer core or cluster, this patch is to add statistics for
this new flag.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Ali Saidi <alisaidi@amazon.com>
---
 tools/perf/util/mem-events.c | 11 ++++++++++-
 tools/perf/util/mem-events.h |  1 +
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index bfbac365e1e4..2086f067359b 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -525,6 +525,7 @@ int c2c_decode_stats(struct c2c_stats *stats, struct mem_info *mi)
 	u64 op     = data_src->mem_op;
 	u64 lvl    = data_src->mem_lvl;
 	u64 snoop  = data_src->mem_snoop;
+	u64 snoopx = data_src->mem_snoopx;
 	u64 lock   = data_src->mem_lock;
 	u64 blk    = data_src->mem_blk;
 	u64 lvl_num = data_src->mem_lvl_num;
@@ -568,10 +569,17 @@ do {				\
 			if (lvl & P(LVL, IO))  stats->ld_io++;
 			if (lvl & P(LVL, LFB)) stats->ld_fbhit++;
 			if (lvl & P(LVL, L1 )) stats->ld_l1hit++;
-			if (lvl & P(LVL, L2 )) stats->ld_l2hit++;
+			if (lvl & P(LVL, L2)) {
+				if (snoopx & P(SNOOPX, PEER))
+					stats->ld_peer++;
+				else
+					stats->ld_l2hit++;
+			}
 			if (lvl & P(LVL, L3 )) {
 				if (snoop & P(SNOOP, HITM))
 					HITM_INC(lcl_hitm);
+				else if (snoopx & P(SNOOPX, PEER))
+					stats->ld_peer++;
 				else
 					stats->ld_llchit++;
 			}
@@ -662,6 +670,7 @@ void c2c_add_stats(struct c2c_stats *stats, struct c2c_stats *add)
 	stats->ld_l1hit		+= add->ld_l1hit;
 	stats->ld_l2hit		+= add->ld_l2hit;
 	stats->ld_llchit	+= add->ld_llchit;
+	stats->ld_peer		+= add->ld_peer;
 	stats->lcl_hitm		+= add->lcl_hitm;
 	stats->rmt_hitm		+= add->rmt_hitm;
 	stats->tot_hitm		+= add->tot_hitm;
diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index e0e8057c52e8..7b6c74e74354 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -75,6 +75,7 @@ struct c2c_stats {
 	u32	ld_l1hit;            /* count of loads that hit L1D */
 	u32	ld_l2hit;            /* count of loads that hit L2D */
 	u32	ld_llchit;           /* count of loads that hit LLC */
+	u32	ld_peer;             /* count of loads that hit peer core or cluster cache */
 	u32	lcl_hitm;            /* count of loads with local HITM  */
 	u32	rmt_hitm;            /* count of loads with remote HITM */
 	u32	tot_hitm;            /* count of loads with local and remote HITM */
-- 
2.25.1

