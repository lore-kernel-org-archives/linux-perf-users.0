Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45952C43334
	for <linux-perf-users@archiver.kernel.org>; Sat,  4 Jun 2022 04:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350473AbiFDE3W (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 4 Jun 2022 00:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350512AbiFDE3T (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 4 Jun 2022 00:29:19 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE05E4C7AB
        for <linux-perf-users@vger.kernel.org>; Fri,  3 Jun 2022 21:29:17 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id gd1so8738565pjb.2
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Jun 2022 21:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cBhbTEYatQ8ux5y6Tpm1b5eQI3hSdv3I21ABVLF0r08=;
        b=dcvR1ANBqSOcKf51hqH6H0v6zOnzmnkR/oLFzoAEAvU13u0xKzrgHAQwuMri4diNgI
         mfWGPl+UjyyLTf2OBC5ws956ToQUq8dJWCAOWQ0ufXvdSA9AWIWDAMreOm0+bJa4FGXL
         aXmN6JhYPJvOivg4qDie7U7ICCUKwgQMIUCNCkyeWqQPteMm2CXUVNMETV0qy8uBCroW
         njfvK4WUhKEtmm8+HJIM/MP5y8KJrRopMBGF1tJMVKjLkbPEIdXEzDR+9aZPIF+Qf4E9
         ld/oajDzXRjaPEbNt3bRCMrNhIE+eVwIwiI27D0pqS0YuRmDmiK9clh4AsWzCBc3BQWx
         razA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cBhbTEYatQ8ux5y6Tpm1b5eQI3hSdv3I21ABVLF0r08=;
        b=jrUqDCv8Sd5EoE2CjQxQJ123zhBV2n/WB+7lj6ixl9FIKVcNuWz/sBE2moraUirUgF
         oRCFsipcSQv93J341z8P1kxvuTZkeaEbwAFy13hjurxIepQqb6Z19K9yFNm9PeTJio2k
         pDVinqtZjf5DlDQgT36C6FD2P7Bbf5l9rAHqJUKUCS9thMiqDYLFrCz/TCP1i+RzE190
         o2KrcBKfmxKZUHCqvsoU0iHkBr+cJFpfwqT5NfUDZSIDFxdfCjGgUVeW62zBEiVMGLGW
         xGQAn8fThmfntWy/WVkI6b5bZkrDCI5F+qfXpX2aV2PwXP/0vCK8q0LDRtGeKh2AplMn
         NH8g==
X-Gm-Message-State: AOAM531ozDR19VTiVi5+7m/Q6xwJE7h50xdif8x0egVZWdatEVMhR6O/
        mwemrbx7uL1rdEqi00mPt050yQ==
X-Google-Smtp-Source: ABdhPJyuff1MpGI19MYjeS04VgDFA9owXedQ5UnzZqdBdb8CRUrn0oriKxkV+W2Ki7Al6QxG3tm9sQ==
X-Received: by 2002:a17:90b:380b:b0:1e6:67f6:f70c with SMTP id mq11-20020a17090b380b00b001e667f6f70cmr16631863pjb.120.1654316957049;
        Fri, 03 Jun 2022 21:29:17 -0700 (PDT)
Received: from leo-build-box.lan (ec2-54-67-95-58.us-west-1.compute.amazonaws.com. [54.67.95.58])
        by smtp.gmail.com with ESMTPSA id w24-20020a1709027b9800b00163d4c3ffabsm6152916pll.304.2022.06.03.21.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 21:29:16 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>, Joe Mario <jmario@redhat.com>,
        Adam Li <adam.li@amperecomputing.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5 06/17] perf mem: Add statistics for peer snooping
Date:   Sat,  4 Jun 2022 12:28:09 +0800
Message-Id: <20220604042820.2270916-7-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220604042820.2270916-1-leo.yan@linaro.org>
References: <20220604042820.2270916-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Since the flag PERF_MEM_SNOOPX_PEER is added to support cache snooping
from peer cache line, it can come from a peer core, a peer cluster, or
a remote NUMA node.

This patch adds statistics for the flag PERF_MEM_SNOOPX_PEER.  Note, we
take PERF_MEM_SNOOPX_PEER as an affiliated info, it needs to cooperate
with cache level statistics.  Therefore, we account the load operations
for both the cache level's metrics (e.g. ld_l2hit, ld_llchit, etc.) and
peer related metrics when flag PERF_MEM_SNOOPX_PEER is set.

So three new metrics are introduced: 'lcl_peer' is for local cache
access, the metric 'rmt_peer' is for remote access (includes remote DRAM
and any caches in remote node), and the metric 'tot_peer' is accounting
the sum value of 'lcl_peer' and 'rmt_peer'.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Ian Rogers <irogers@google.com>
Tested-by: Ali Saidi <alisaidi@amazon.com>
Reviewed-by: Ali Saidi <alisaidi@amazon.com>
---
 tools/perf/util/mem-events.c | 28 +++++++++++++++++++++++++---
 tools/perf/util/mem-events.h |  3 +++
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 5dca1882c284..764883183519 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -525,6 +525,7 @@ int c2c_decode_stats(struct c2c_stats *stats, struct mem_info *mi)
 	u64 op     = data_src->mem_op;
 	u64 lvl    = data_src->mem_lvl;
 	u64 snoop  = data_src->mem_snoop;
+	u64 snoopx = data_src->mem_snoopx;
 	u64 lock   = data_src->mem_lock;
 	u64 blk    = data_src->mem_blk;
 	/*
@@ -544,6 +545,12 @@ do {				\
 	stats->tot_hitm++;	\
 } while (0)
 
+#define PEER_INC(__f)		\
+do {				\
+	stats->__f++;		\
+	stats->tot_peer++;	\
+} while (0)
+
 #define P(a, b) PERF_MEM_##a##_##b
 
 	stats->nr_entries++;
@@ -567,12 +574,20 @@ do {				\
 			if (lvl & P(LVL, IO))  stats->ld_io++;
 			if (lvl & P(LVL, LFB)) stats->ld_fbhit++;
 			if (lvl & P(LVL, L1 )) stats->ld_l1hit++;
-			if (lvl & P(LVL, L2 )) stats->ld_l2hit++;
+			if (lvl & P(LVL, L2)) {
+				stats->ld_l2hit++;
+
+				if (snoopx & P(SNOOPX, PEER))
+					PEER_INC(lcl_peer);
+			}
 			if (lvl & P(LVL, L3 )) {
 				if (snoop & P(SNOOP, HITM))
 					HITM_INC(lcl_hitm);
 				else
 					stats->ld_llchit++;
+
+				if (snoopx & P(SNOOPX, PEER))
+					PEER_INC(lcl_peer);
 			}
 
 			if (lvl & P(LVL, LOC_RAM)) {
@@ -597,10 +612,14 @@ do {				\
 		if ((lvl & P(LVL, REM_CCE1)) ||
 		    (lvl & P(LVL, REM_CCE2)) ||
 		     mrem) {
-			if (snoop & P(SNOOP, HIT))
+			if (snoop & P(SNOOP, HIT)) {
 				stats->rmt_hit++;
-			else if (snoop & P(SNOOP, HITM))
+			} else if (snoop & P(SNOOP, HITM)) {
 				HITM_INC(rmt_hitm);
+			} else if (snoopx & P(SNOOPX, PEER)) {
+				stats->rmt_hit++;
+				PEER_INC(rmt_peer);
+			}
 		}
 
 		if ((lvl & P(LVL, MISS)))
@@ -664,6 +683,9 @@ void c2c_add_stats(struct c2c_stats *stats, struct c2c_stats *add)
 	stats->lcl_hitm		+= add->lcl_hitm;
 	stats->rmt_hitm		+= add->rmt_hitm;
 	stats->tot_hitm		+= add->tot_hitm;
+	stats->lcl_peer		+= add->lcl_peer;
+	stats->rmt_peer		+= add->rmt_peer;
+	stats->tot_peer		+= add->tot_peer;
 	stats->rmt_hit		+= add->rmt_hit;
 	stats->lcl_dram		+= add->lcl_dram;
 	stats->rmt_dram		+= add->rmt_dram;
diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index 8a8b568baeee..12372309d60e 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -78,6 +78,9 @@ struct c2c_stats {
 	u32	lcl_hitm;            /* count of loads with local HITM  */
 	u32	rmt_hitm;            /* count of loads with remote HITM */
 	u32	tot_hitm;            /* count of loads with local and remote HITM */
+	u32	lcl_peer;            /* count of loads with local peer cache */
+	u32	rmt_peer;            /* count of loads with remote peer cache */
+	u32	tot_peer;            /* count of loads with local and remote peer cache */
 	u32	rmt_hit;             /* count of loads with remote hit clean; */
 	u32	lcl_dram;            /* count of loads miss to local DRAM */
 	u32	rmt_dram;            /* count of loads miss to remote DRAM */
-- 
2.25.1

