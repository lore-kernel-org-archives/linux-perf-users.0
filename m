Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD9AC433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 30 May 2022 08:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbiE3InC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 30 May 2022 04:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbiE3InC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 30 May 2022 04:43:02 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46579DE9
        for <linux-perf-users@vger.kernel.org>; Mon, 30 May 2022 01:43:01 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id j6so9985801pfe.13
        for <linux-perf-users@vger.kernel.org>; Mon, 30 May 2022 01:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AcThocPJ0wzgCNB1hRmWCzKxPwFlNqlVWFyeNmHGLfE=;
        b=d3hfd5WFTV84IZ4yVXDIWkKdL2q9b1/279g6UCuN282BOKYmeawhyuFt/oZ05yo4D6
         NXBKb3hzM4d31LexOS8I7YIPE703jds2zcWxF6gstg0XWjjKa1bjwjcmAKLgk1/RP4Ll
         XFfk9taAkm+qsnKcufKotYWra3bqXU6VjkfSNKlQkNnQhx4cJs63GNLuoCSOhkghJVbE
         gh+DQm3amiLIKXUU8LMcEL+nFiQotQ3KvheVGHbfu6M7ncXdT9luJEG6DSJHnupOQtiv
         fYtUD1ElqjOz5fhnWiARMgp3I9zbyfSinQ9PcToO2z2XWueWSAXBFtbdCZw5ijXS5XM5
         tPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AcThocPJ0wzgCNB1hRmWCzKxPwFlNqlVWFyeNmHGLfE=;
        b=G/6tyt8zEu1eVQwhxIpy0QH+c4C0IGVy0Ocjg7l+0ntR8obreIO5kBW38jtaIjQghX
         qfZUSiUqhrNbvsy4QWMmcoAn00jL1UIlFFmBZaOFk8ck/UMGys3mb/SiivxEycmJwSiL
         PJiSIGA3PSCp0WxthNVek1wNFd1xQJMwj4ekvERZoTwsu1PDw1THtmtwCzwYYzHWHWpt
         fYYAUT1MTl8yhp2jf6/+9uYsw0CJdZr3Sx+ZglrTZGCye3pvpg/ACKsLL2qXkuzpNtV3
         o92qhyhe1vgjE6dzlMLGT737bea9FEyu2OFQxGe2TgqK0ib+jsgeMTIuRyKLX2LQkQS5
         wQLA==
X-Gm-Message-State: AOAM530MxhaS1YdjDl5dqcAoSw2rOsTzjPDalD83EWqq9TzDvO9N4EqA
        KcIEeXBuskL6wTsOSLuAip7KaA==
X-Google-Smtp-Source: ABdhPJxxoORpS89tmPsGbAvPtcdHdNix7f7tRDqClS80bppvL2ZAh/01+CsvMFzMblRtki8rBOUPYA==
X-Received: by 2002:a65:5c0c:0:b0:3fa:b2c0:7935 with SMTP id u12-20020a655c0c000000b003fab2c07935mr25861870pgr.600.1653900180714;
        Mon, 30 May 2022 01:43:00 -0700 (PDT)
Received: from leo-build-box.lan ([46.249.98.195])
        by smtp.gmail.com with ESMTPSA id m11-20020a170902bb8b00b0015e8d4eb24fsm8462834pls.153.2022.05.30.01.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 01:43:00 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Joe Mario <jmario@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] perf c2c: Fix sorting in percent_rmt_hitm_cmp()
Date:   Mon, 30 May 2022 16:42:53 +0800
Message-Id: <20220530084253.750190-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The function percent_rmt_hitm_cmp() wrongly uses local HITMs for
sorting remote HITMs.

Since this function is to sort cache lines for remote HITMs, this patch
changes to use 'rmt_hitm' field for correct sorting.

Fixes: 9cb3500afc09 ("perf c2c report: Add hitm/store percent related sort keys")
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-c2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index c8230c48125f..e8280973d7b8 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -928,8 +928,8 @@ percent_rmt_hitm_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 	double per_left;
 	double per_right;
 
-	per_left  = PERCENT(left, lcl_hitm);
-	per_right = PERCENT(right, lcl_hitm);
+	per_left  = PERCENT(left, rmt_hitm);
+	per_right = PERCENT(right, rmt_hitm);
 
 	return per_left - per_right;
 }
-- 
2.25.1

