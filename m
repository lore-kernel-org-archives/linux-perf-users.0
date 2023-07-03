Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BF2EB64DD
	for <linux-perf-users@archiver.kernel.org>; Mon,  3 Jul 2023 12:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjGCMsA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 3 Jul 2023 08:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjGCMrx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 3 Jul 2023 08:47:53 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09189CA
        for <linux-perf-users@vger.kernel.org>; Mon,  3 Jul 2023 05:47:52 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-314319c0d3eso1866078f8f.0
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Jul 2023 05:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688388470; x=1690980470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVY/yta8MPWmg9iGDhd2QZ8qAlvFNnDO2cXvkrgJQ+E=;
        b=QlE2Iqus6AP6Te3dv3Y5Sx4aMQ+r5SKgwVSpZ0lVhlvFOkGw0WYXtGXIyYV13AdXyg
         BF50w/diT8Np6DqNMws/6d/47CDoirkmcKusK6cN3dPFI2VGnUd9hAmyNYSlA4poktO+
         eBlIbLnt08K37EodkyVat6+liUHZWpeoQatiE5O/3ceBUMebG7p6wzso8g68vqx48QeP
         Q50WOmsmdac9sn01EhF2WYiEkGFTwOTVO9QCJi6lJY9lnNqqXeQk/4wQoS1+c5EPLsLm
         ycCf9vXUK/7Q3fhEEM4/FDM3oJBppGTNdLj8CelDbYB3NzmZu/AEwfXT3hZ6/haUCtRa
         EgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688388470; x=1690980470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVY/yta8MPWmg9iGDhd2QZ8qAlvFNnDO2cXvkrgJQ+E=;
        b=HABHYF4knunEeJ78tCeOOVox+c/fBO6NpSW4utjOV/cndmGO+TwRQUIlWfdW0WaQrt
         MjsdeelAUvG/wLbgreP6Jhd24O9Z6JJyM8UArieFAwrBZbrJnmUACieDUBaBgNexenho
         GvLVbiCz0ecbP5nf2yzjawstQOqJjIBHCo/m3jK5ms13I2MBzzCWBVUILdB3qY/4rtrH
         b6WLEtlTyfWSlLK80aCu6bS5ZxedH4RdWVwFcpCUdB5SmX2jXbOXqwC1RpT/ADa7q5ux
         Lz/XNiQnXwAGicTgcIn9KfIRKbzZxFGI+lbi+5o0/3fl9S6vHCqJqbZe0fGv9ZGUTtdR
         veEA==
X-Gm-Message-State: ABy/qLYJNcXL46GqDD66PBexPB4Xn13CSvKwt6nVL+AS407cmtm0dKoW
        wSFcc35T9IJIKDcLPXW2ZGrYkN0RsPjUn0R7lCk=
X-Google-Smtp-Source: APBJJlGkvS0VBTA5uxFkpZhC1EeXtotxBOQUfL8gsoFO3JwjxcRP9zPFqdv6CO7IZsrTAyG8/+JKUQ==
X-Received: by 2002:a05:6000:124f:b0:314:3746:d44b with SMTP id j15-20020a056000124f00b003143746d44bmr2701847wrx.41.1688388470517;
        Mon, 03 Jul 2023 05:47:50 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id v2-20020a5d6782000000b00313f5babb18sm19568022wru.9.2023.07.03.05.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 05:47:50 -0700 (PDT)
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
Subject: [PATCH v4 01/10] perf: Fix wrong comment about default event_idx
Date:   Mon,  3 Jul 2023 14:46:38 +0200
Message-Id: <20230703124647.215952-2-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230703124647.215952-1-alexghiti@rivosinc.com>
References: <20230703124647.215952-1-alexghiti@rivosinc.com>
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

