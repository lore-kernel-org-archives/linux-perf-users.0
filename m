Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4BEC19F2D
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Aug 2022 06:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbiHKGZt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 11 Aug 2022 02:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234063AbiHKGZl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 Aug 2022 02:25:41 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D679606AF
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Aug 2022 23:25:34 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id p8so16132223plq.13
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Aug 2022 23:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=cg7a420zG6mGCvpK6vY7htHWem4OIwFbitF47hyqumE=;
        b=wFl7aouajRfbB6E+kMU6XeqMu3NoocK7br+p3/49bIpe4jYXuIs7bjd4XBZejSGPR1
         7eeALnSLscuSn2RCo5CFSEBNg3U4f7JuMkaM9p9vrTZt4DRk886qkyFOx9L402zurRl+
         CqF8AbZxmZyvmqbvoJAu8LZeL/fsAIaJQJ02tkcwvt+gvAfG0B9SLav+IbFWMqBNGCxo
         DzGuO4Dx8gM3z+lMuuHZaCW66f9s7+ULN/kLsD5mM8WFxpfx6t/kQuO/MyFDwvhtq5o4
         MIZZrk0g8I4GjuKLbcBAZ2SgUrbbeKNNm7sGHVAC5/VdL4KdnTtmCgJDemUtKHWtcvbr
         k6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=cg7a420zG6mGCvpK6vY7htHWem4OIwFbitF47hyqumE=;
        b=usmwEkaEV0vwMEwLWNHMB2gRLhJMCXSKUKoTTuY4EYwZ+IpOrcBkygcBFMy/Ov36R/
         VG3FJqc5wDqN1/VSMXqnfUXPfh9jP+fxVUp5VVvANJ4S4bzcZQnaJko27twmh2jsqDFv
         qnBXIHLTBV7D2c0vCSOe0pGsQflFj8rPNHtJlzggkQYHlGM58aHkE+LwFjyK8ub6h69/
         X+vnk/xnUFXOnyf705YcOT4UnLS4DbJtchABom6sJWN9KK7y+3EILZeD6CR9xvQ7wvtZ
         CWJaQLOnYVW4SNaf+8Hpsu2hljk0YkvCE9MVdeTYvdvnPi3bAJEUno1QDSgUZwQ5d8Oc
         ALTA==
X-Gm-Message-State: ACgBeo0IZUYP+RbUG8c2RlD3UYKThQZjiuinvoiFKxsDmG67TNgRg2E3
        HS+b37C9xV3fGD3+LUnorfOdAQ==
X-Google-Smtp-Source: AA6agR6CzoXrkfrHDM8h4A9KPEADERjSTTYsvO4KYcFXuvBg48yGNd7DKUiVXAZ7pueiI/DiQekZvg==
X-Received: by 2002:a17:90b:1907:b0:1f3:d6:985c with SMTP id mp7-20020a17090b190700b001f300d6985cmr7422284pjb.46.1660199133174;
        Wed, 10 Aug 2022 23:25:33 -0700 (PDT)
Received: from leoy-yangtze.lan (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id o12-20020a17090a55cc00b001f506009036sm2766926pjm.49.2022.08.10.23.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 23:25:32 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ian Rogers <irogers@google.com>, Like Xu <likexu@tencent.com>,
        German Gomez <german.gomez@arm.com>,
        Timothy Hayes <timothy.hayes@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v6 05/15] perf c2c: Output statistics for peer snooping
Date:   Thu, 11 Aug 2022 14:24:41 +0800
Message-Id: <20220811062451.435810-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220811062451.435810-1-leo.yan@linaro.org>
References: <20220811062451.435810-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch outputs statistics for peer snooping for whole trace events
and global shared cache line.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Ian Rogers <irogers@google.com>
Tested-by: Ali Saidi <alisaidi@amazon.com>
Reviewed-by: Ali Saidi <alisaidi@amazon.com>
---
 tools/perf/builtin-c2c.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 4898ee57d156..37bebeb6c11b 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2202,6 +2202,8 @@ static void print_c2c__display_stats(FILE *out)
 	fprintf(out, "  Load LLC Misses                   : %10d\n", llc_misses);
 	fprintf(out, "  Load access blocked by data       : %10d\n", stats->blk_data);
 	fprintf(out, "  Load access blocked by address    : %10d\n", stats->blk_addr);
+	fprintf(out, "  Load HIT Local Peer               : %10d\n", stats->lcl_peer);
+	fprintf(out, "  Load HIT Remote Peer              : %10d\n", stats->rmt_peer);
 	fprintf(out, "  LLC Misses to Local DRAM          : %10.1f%%\n", ((double)stats->lcl_dram/(double)llc_misses) * 100.);
 	fprintf(out, "  LLC Misses to Remote DRAM         : %10.1f%%\n", ((double)stats->rmt_dram/(double)llc_misses) * 100.);
 	fprintf(out, "  LLC Misses to Remote cache (HIT)  : %10.1f%%\n", ((double)stats->rmt_hit /(double)llc_misses) * 100.);
@@ -2230,6 +2232,7 @@ static void print_shared_cacheline_info(FILE *out)
 	fprintf(out, "  L1D hits on shared lines          : %10d\n", stats->ld_l1hit);
 	fprintf(out, "  L2D hits on shared lines          : %10d\n", stats->ld_l2hit);
 	fprintf(out, "  LLC hits on shared lines          : %10d\n", stats->ld_llchit + stats->lcl_hitm);
+	fprintf(out, "  Load hits on peer cache or nodes  : %10d\n", stats->lcl_peer + stats->rmt_peer);
 	fprintf(out, "  Locked Access on shared lines     : %10d\n", stats->locks);
 	fprintf(out, "  Blocked Access on shared lines    : %10d\n", stats->blk_data + stats->blk_addr);
 	fprintf(out, "  Store HITs on shared lines        : %10d\n", stats->store);
-- 
2.34.1

