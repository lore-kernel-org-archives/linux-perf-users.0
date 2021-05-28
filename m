Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8CAC2B9F7
	for <linux-perf-users@archiver.kernel.org>; Fri, 28 May 2021 16:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13B5C613DA
	for <linux-perf-users@archiver.kernel.org>; Fri, 28 May 2021 16:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbhE1QRi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 28 May 2021 12:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235271AbhE1QRi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 28 May 2021 12:17:38 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68253C06174A
        for <linux-perf-users@vger.kernel.org>; Fri, 28 May 2021 09:16:02 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id f3-20020a17090a4a83b02901619627235bso656571pjh.1
        for <linux-perf-users@vger.kernel.org>; Fri, 28 May 2021 09:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LmzoCJf4YAFPMLbMFaDyVjzU4iVcJhDZdLSLwXHbWZk=;
        b=oM9RJaxUoVmpzobf0ygLoYq4B+VP2wfYxqPxmE55Pjb9KwHdxe1RUTmM2wygin375H
         DuRL2ALbaqWfPBAH78BOZRkrfUi0KxrgD3OeqNbT1MgRUbO4yoXUe17krf2lEeHMIwyQ
         wM6M7Pa1D/mU60F22Qnd3fJsw4gg6PA/T3CoJi4rNasRo466GQgjeq2z/xqnJpGJ0jld
         4lbGFpJTS+FGcfBvRqWaSnCRXrjshfeBvKlc+Ub9na8kOT3gSzYpuynj1E9DtnAy1dJl
         kZzn/zJh1MYeNNXv+yZ3vm6tGjRSXGXH2nE0tDQzC3bex8V9jgveEwbaEn83pAUA+x2s
         rmfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LmzoCJf4YAFPMLbMFaDyVjzU4iVcJhDZdLSLwXHbWZk=;
        b=s/OtCf5+8TqrlWoeXnGnKKBSSif8G8VGBdh74fiDDhvA+iTVR9MR4ZYlO5xfLJ0CXM
         OUx0WN79If+s+2Uw7Ws5eYl7v9bICUK7awHK4Ffi+MGhu1naWdkqpKxQ2R/hn067R6E9
         IlFbz3rAEylYttAv4EzZ1xPCU1mDSUq6xjUrTEAHuXppw9oXMU84FByCC6koFB9Wuy7A
         3BMBB30jEfEJeXr+pWUHMyY3Kw3vDtFkDsFnsLAk/yDVpkSoT4iTLw44A04tJ8dZAptj
         zgIOzfgNZVK3THk3EuedWhU+6iy+aYA+9IUBCKUJqSOkASjxMSPJTjGWCh3jdGMzyQFb
         +lWA==
X-Gm-Message-State: AOAM531FhEuzvyX91ZcP0HJ7UKNEzAlmuzXhPSj9SelEPu+1CgHhoqVX
        yfLEDGTnVcLp+MeTypIPob2CKw==
X-Google-Smtp-Source: ABdhPJxLpioen06LQ4X2LW+DpaHIPaW74TwQtyghkALt9YuqOH0l67rzIcFiS9+prlQr3OhHDe2UCQ==
X-Received: by 2002:a17:902:9004:b029:f0:b40d:38d with SMTP id a4-20020a1709029004b02900f0b40d038dmr8786668plp.85.1622218561662;
        Fri, 28 May 2021 09:16:01 -0700 (PDT)
Received: from localhost ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id o10sm4667028pfh.67.2021.05.28.09.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 09:16:01 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <daniel.kiss@arm.com>,
        Denis Nikitin <denik@google.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 0/3] coresight: Fix for snapshot mode
Date:   Sat, 29 May 2021 00:15:49 +0800
Message-Id: <20210528161552.654907-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch series is to correct the pointer usages for the snapshot
mode.

Patch 01 allows the AUX trace in the free run mode and only syncs the
AUX ring buffer when taking snapshot.

Patch 02 is to polish code, it removes the redundant header maintained
in tmc-etr driver and directly uses pointer perf_output_handle::head.

Patch 03 removes the callback cs_etm_find_snapshot() which wrongly
calculates the buffer headers; we can simply use the perf's common
function __auxtrace_mmap__read() for headers calculation.

This patch can be cleanly applied on the mainline kernel with:

  commit 97e5bf604b7a ("Merge branch 'for-5.13-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu")

And it has been tested on Arm64 Juno board.


Leo Yan (3):
  coresight: etm-perf: Correct buffer syncing for snapshot
  coresight: tmc-etr: Use perf_output_handle::head for AUX ring buffer
  perf cs-etm: Remove callback cs_etm_find_snapshot()

 .../hwtracing/coresight/coresight-etm-perf.c  |  30 +++-
 .../hwtracing/coresight/coresight-etm-perf.h  |   2 +
 .../hwtracing/coresight/coresight-tmc-etr.c   |  10 +-
 tools/perf/arch/arm/util/cs-etm.c             | 133 ------------------
 4 files changed, 32 insertions(+), 143 deletions(-)

-- 
2.25.1

