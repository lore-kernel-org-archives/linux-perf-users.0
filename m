Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779D8C0015E
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jun 2023 08:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbjF3Icv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 30 Jun 2023 04:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjF3Icn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 30 Jun 2023 04:32:43 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDFE1BE9
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jun 2023 01:32:41 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fa93d61d48so17952485e9.0
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jun 2023 01:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688113960; x=1690705960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVY/yta8MPWmg9iGDhd2QZ8qAlvFNnDO2cXvkrgJQ+E=;
        b=kl/TPhm6ikHmXXieyToZuU/DsVCjRsYDu5avotvuqaFc6tZ03SeeW4FBKpCi/Mw0WK
         wYwR3smgKyTmD/+jwch8XyufhBtdkF3f7qT76g3QLFIxycHhxqlDuelvEeFLcQBDGwtt
         c99+4W37R5ubiuAV02MC9TfgLz/gSE7K7R4yhEbEZr5+7p6QH5R3OjwwnSQN3sEOn7tW
         RKj4BSD6VxbchcdMJw22xXR3zLMu8PcBAKcXWWpZR1RwCBliqolg8sKRbGtF44CNGBjW
         9CyHSusDkCPt0CnofvgfwI9NFxWhPuDzw6CUyYduupu1PMRz4yXtfiSFdQwWM5irvYAE
         GdrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688113960; x=1690705960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVY/yta8MPWmg9iGDhd2QZ8qAlvFNnDO2cXvkrgJQ+E=;
        b=P84Q/xA5zyoxVmrtCz4dd6Ga3mnN9dHuNWR3kZMgI9I+V0TRW4Y6xQAX/5SW9u+0ZD
         BtcxD+1Ro01kIG1BzvGa+Up6hMo+WQGAQ9m2M3wFk9m2EsXZyXiEUrTMRyjPGS5kYnhw
         dcugb3eg+XAU0szWdNZ0T9OfIiFlWn2YMydyBrIKHtZ0NCdhUlXKkzLi2Ud+fq8+MpwZ
         rJkZ5RooIe+6pob+rYDTOBcFWlb60lMjw8hgqAshL0Usex8CJ6KZ1aZAhp6iXxvnQd9j
         A/h2jQsGT4/rqdN9/VeARkOAsg6UbDEIg6uFA1EbpQ9tb6bY0iOt3JIeQET81iTnfcJZ
         a+fQ==
X-Gm-Message-State: AC+VfDymNkuUfztt3tbY1lJu9rFfqwXw6N70IlHNs+VXo1hmFh0d5CZW
        J9XGFTgKkFXdGQTM6pcMHCGTcg==
X-Google-Smtp-Source: ACHHUZ4sOZab/Xe9VR+3s2W1uRvunuBxqP1Egjt8iE/RBBaYrC98a4RA8h5p4k6wwDyYphRxgmB5tw==
X-Received: by 2002:a1c:7c05:0:b0:3f6:2ae:230e with SMTP id x5-20020a1c7c05000000b003f602ae230emr1443811wmc.3.1688113960321;
        Fri, 30 Jun 2023 01:32:40 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id v4-20020a05600c214400b003fa95890484sm13846402wml.20.2023.06.30.01.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 01:32:40 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v3 01/10] perf: Fix wrong comment about default event_idx
Date:   Fri, 30 Jun 2023 10:30:04 +0200
Message-Id: <20230630083013.102334-2-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230630083013.102334-1-alexghiti@rivosinc.com>
References: <20230630083013.102334-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Since commit c719f56092ad ("perf: Fix and clean up initialization of
pmu::event_idx"), event_idx default implementation has returned 0, not
idx + 1, so fix the comment that can be misleading.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
---
 include/linux/perf_event.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d5628a7b5eaa..56fe43b20966 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -442,7 +442,8 @@ struct pmu {
 
 	/*
 	 * Will return the value for perf_event_mmap_page::index for this event,
-	 * if no implementation is provided it will default to: event->hw.idx + 1.
+	 * if no implementation is provided it will default to 0 (see
+	 * perf_event_idx_default).
 	 */
 	int (*event_idx)		(struct perf_event *event); /*optional */
 
-- 
2.39.2

