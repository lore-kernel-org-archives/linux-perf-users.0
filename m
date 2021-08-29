Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962F3C432BE
	for <linux-perf-users@archiver.kernel.org>; Sun, 29 Aug 2021 10:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69D7260E90
	for <linux-perf-users@archiver.kernel.org>; Sun, 29 Aug 2021 10:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbhH2KXp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 29 Aug 2021 06:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235019AbhH2KXo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 29 Aug 2021 06:23:44 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410CBC061575
        for <linux-perf-users@vger.kernel.org>; Sun, 29 Aug 2021 03:22:53 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id j10-20020a17090a94ca00b00181f17b7ef7so11845138pjw.2
        for <linux-perf-users@vger.kernel.org>; Sun, 29 Aug 2021 03:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4MRRIZZkt9tye/aSkZ8szLuchNWkKPYUS23tJYjGKbc=;
        b=Bozq91IDxk7Z01Rw3IsWHeNB0Ai4ky7kqsxkGsX2x1LTxD4gyYzmDjc7emz8Ccho7g
         x27elPh8eWqS0zowODCSOrEWFRcp7M41di1oClbW2G3684QOZ7MTyQiuovnKFe+tq/jX
         iazOs2jNkC+TWWKgFJeXcho57BLx2c4fcPfgIVJJyczimEp2smlh42oDGoKEQkf56eaG
         sEznFfLfJpUukTrBKS5nTaMYf8yAm3ax9ZJGmT4LHVkzi0qk3+YZUlbVkRIo1Yd0KV9S
         y8naOYYArX8NGOtKcvQLYyEsHIPDbndbLdUNgqAeWzv28TfMbP4qS2yrqkxqdC+czZbr
         fxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4MRRIZZkt9tye/aSkZ8szLuchNWkKPYUS23tJYjGKbc=;
        b=pSEnyHMY7m2vFufA2y774vGgoFIuFyKXpxxTNa1KJNX5NoMhxkex90LIJaiyfwCqHi
         LK16fASgSM12KlBzGk7acD/7qBbrlKu/kSf3M7MvHe5gwbgigRvpQvxn+K+JC/lxqtch
         PNAFFS9I+s/TEWpM3UpG1tw3hYTD9UnvQv4tUzCVbt3p4c//XkIWmThkJqvYkcMg8wMT
         IreLHVGwEywXI6ILz65Pw9EHpQJami2IiAD0pPuoGPBFNzBWgbQRJv305Zs9kqDiQB93
         xQO7X9uTF1PlbQ4cv9KseBEfG8f9zi2L/BK280+bxVUQnPIgx1K6YaTJDZk8gFyYiMnH
         CrQA==
X-Gm-Message-State: AOAM532zIAHr08UpEvucoA603tbS5V4yLvH2GNZtbBJ1a8p/vAaPLyer
        rUbjsB6luN5MjTcsS4Mrbg89jA==
X-Google-Smtp-Source: ABdhPJxcZxrA6s2WVeX4pV8eRNY68Q1x+RiDSEGh0KxfPSlVQ//9mmT6h7HDnrp3yZpG56gOktEJdA==
X-Received: by 2002:a17:902:a407:b0:138:849b:56f6 with SMTP id p7-20020a170902a40700b00138849b56f6mr15340746plq.0.1630232572666;
        Sun, 29 Aug 2021 03:22:52 -0700 (PDT)
Received: from localhost ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id b17sm13438812pgl.61.2021.08.29.03.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 03:22:52 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 0/2] perf: Support compat mode for AUX ring buffer
Date:   Sun, 29 Aug 2021 18:22:36 +0800
Message-Id: <20210829102238.19693-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch set is to address the comments in the patch set v1 [1] and
updates the patches.

Changes from v1:
- Added Adrian's review tag for patch 01;
- Refined comment in patch 01 (James);
- Added James' review and test tag for patch 02.

[1] https://lore.kernel.org/patchwork/cover/1473936/


Leo Yan (2):
  perf auxtrace: Add compat_auxtrace_mmap__{read_head|write_tail}
  perf auxtrace arm: Support
    compat_auxtrace_mmap__{read_head|write_tail}

 tools/perf/arch/arm/util/auxtrace.c | 32 +++++++++++
 tools/perf/util/auxtrace.c          | 88 +++++++++++++++++++++++++++--
 tools/perf/util/auxtrace.h          | 22 +++++++-
 3 files changed, 135 insertions(+), 7 deletions(-)

-- 
2.25.1

