Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAB1C43334
	for <linux-perf-users@archiver.kernel.org>; Sun, 24 Jul 2022 06:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiGXGAV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 24 Jul 2022 02:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiGXGAU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 24 Jul 2022 02:00:20 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2007111154
        for <linux-perf-users@vger.kernel.org>; Sat, 23 Jul 2022 23:00:19 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id y9so7713789pff.12
        for <linux-perf-users@vger.kernel.org>; Sat, 23 Jul 2022 23:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wMKdwBG848qBHhNARCtBeFqUtsE99EGKMgpSlGcHe0g=;
        b=Gz5KEwpuisNA2ho8J2DzD8NshjTqDEC5OI20qOEFygh8H6ta4drpmRwmeiaty9faVC
         B+HEnpHtekw8KjrQ2+KNFiYlklC10NNiyYhcThERGjySadyzsM/l0qt+0MC7vfeDjuAW
         YdameMlwDgf8dfcag3ihuxaKJMb3k7uQ0TW55dqdKZgaP3/UuNWYFwiqBvx0BdHogMi4
         Waj1zxhKUblfXgGwt14RmUV5qp3N1RrPfT8fr45wSDgAg4rJTx0jAbPlVe+yY1IPIAlp
         /BWEKLIQqk4BRN4RqvzXUV3VryCRlF9x6sLmgTr/c8WWcVqdLWGhIggl82C4YJOK470N
         Znhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wMKdwBG848qBHhNARCtBeFqUtsE99EGKMgpSlGcHe0g=;
        b=cBtR6DdT2WCPneq3vpEOA9qkORZJdONKP8EulHl5qRvwR9al0CdZscT//MKe+XIDbM
         EGIKxcG5V++5qxgbTzIKpHuoocVLF02h/iqFekTykDLUfNdkF/nnZtvtBNTrBvqdREVM
         E9dJHdRxUeYoGTos+SlrP4ADyJaK2UW7qwXiGE6G4V9TzvelQJDQdQ8NCkvGazvLAPBN
         aD9URBWFgoCDZofm2/sXFHG+lAvMnV7i8oYBgbrToBArIk7b3nCdkcd7OnSDwyH5sDSo
         OCNjkrpEUB2k+Y40l8Ysdqfbk2ea9wIcCqETkypamdfpahmyI/JDBTPZrMOQMNGzFGAV
         HvjQ==
X-Gm-Message-State: AJIora8qQVF7/SXFIJn9jC257TDu/mNRSk53hL/+V1jdnuOyqjRjLlMo
        KNVt+lZPHNd7CgnVh1DHFf9N6Q==
X-Google-Smtp-Source: AGRyM1t1ae4LtipmS2FroS284T8+XN+ltj1IyuZuCCM0EEjjeucPZpN9EAW07a+Joh3AXazDwyFT1A==
X-Received: by 2002:a63:3181:0:b0:417:b4b5:df09 with SMTP id x123-20020a633181000000b00417b4b5df09mr6438567pgx.398.1658642418418;
        Sat, 23 Jul 2022 23:00:18 -0700 (PDT)
Received: from localhost (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902654a00b0016a7b9558f7sm6543219pln.136.2022.07.23.23.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 23:00:18 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Fangrui Song <maskray@google.com>,
        Chang Rui <changruinj@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 0/2] perf symbol: Minor fixing
Date:   Sun, 24 Jul 2022 14:00:11 +0800
Message-Id: <20220724060013.171050-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch set contains two minor fixing for parsing symbols.

The first patch changes to use program header for parsing symbols of
user space executable and shared objects.  Since kernel's symbol parsing
is more complex than userspace for support both kernel symbols and module
symbols, this is why this patch set uses conservative way and doesn't
change kernel symbols parsing.

The second patch is to detect symbols from sections without setting
attribute flag SHF_ALLOC, these symbols are used for linker warning,
skip to record them to avoid spurious symbols.

Changes from v2:
- Changed to use more gernal way to check the attribute bit SHF_ALLOC
  for sections rather than check the section string name (Fangrui).

Changes from v1:
- Changed to use program header / PT_LOAD segments to parse symbols for
  userspace executable and shared object files (Fangrui).


Leo Yan (2):
  perf symbol: Correct address for bss symbols
  perf symbol: Skip symbols if SHF_ALLOC flag is not set

 tools/perf/util/symbol-elf.c | 56 +++++++++++++++++++++++++++++++++---
 1 file changed, 52 insertions(+), 4 deletions(-)

-- 
2.25.1

