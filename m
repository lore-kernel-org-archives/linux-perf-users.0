Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D882C11F69
	for <linux-perf-users@archiver.kernel.org>; Thu,  1 Jul 2021 09:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1277A61585
	for <linux-perf-users@archiver.kernel.org>; Thu,  1 Jul 2021 09:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235161AbhGAJiT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 1 Jul 2021 05:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235428AbhGAJiS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 1 Jul 2021 05:38:18 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAD8C061756
        for <linux-perf-users@vger.kernel.org>; Thu,  1 Jul 2021 02:35:47 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 67-20020a17090a0fc9b02901725ed49016so657065pjz.1
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Jul 2021 02:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RO+W36IfmCoOF5xjf8ZackNVFoRy6NygyQXZ/WJRofM=;
        b=amvEoN9eeC+VEBTD1Zaf1gJDs8BfXOLUFzr2bPmh3NDlpAr7wa6izhXSlUg6ufPnPw
         xpVRznI1jPWm2KBvbsXd7Q7OCmjgO2kQMEDYydzfgeaqkgAtuj7wrZX6yYvE1C2+9Rmh
         9RuBcA30NcqbRWxeMrLMNgbsyj0U0du6rXT/GeMiiaSKmQpIk/c2/67CV5a227JD6bvp
         GNYEUUVNDqWr0b+d2E+FkjIjugfw9nDMeSay++s5zJw1Jr//gl/LBJxWfxQqyhaN0Aff
         GE/aMQfkKNuP1jEmO7fjQBdU2nmgjp2yOMxRwvsfClV6zH1EwrHpsdLbZTeC4m/xXMT1
         RQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RO+W36IfmCoOF5xjf8ZackNVFoRy6NygyQXZ/WJRofM=;
        b=XlH2t7npll4tUgo1hJrJohbPBmaj5wbgDBH75O4L3en3c7dmNmQttsWA1XzZo1PGIr
         rjuo2KMW9Bc8Pr4e52nQu1GI3hTUGEE6k1gqr8YAeeaFt+cUobNhLya7ZbpeTK6bo1qd
         Boxip39RyhyoDS+tdfvNvOIdUys+9rwm4mfHWYvYJAs0USmHMlPnGExJrq81tLxRMHWN
         j57LRFHRqjlLmv7tWUVB9exOYiymzTHK8iMvPPuP778JDo5YkyYj4ctxaB3TR+LUsLyh
         ikoQDDhykKvKEIAFg9nM0jU/4oil3iVhPNSYUbAsn2qR9PwJa6pjWTLOkqAVOkJ/GkIH
         9sJw==
X-Gm-Message-State: AOAM530L+Akl4w5c2X9z5NVB7pxWM4rM5MXL6peTArgO+X/dRLsHEY2O
        iQ82D9jAgqU5lksNWEnhKmsCug==
X-Google-Smtp-Source: ABdhPJyE/KA0+duFfM8NqupreWeG8QVd2YC27MOUmBwTeRg6FRzcSGd2EMTkjhDusy27JhzUdVXQpw==
X-Received: by 2002:a17:902:7446:b029:128:ec77:b41e with SMTP id e6-20020a1709027446b0290128ec77b41emr14929267plt.80.1625132146445;
        Thu, 01 Jul 2021 02:35:46 -0700 (PDT)
Received: from localhost ([202.131.71.237])
        by smtp.gmail.com with ESMTPSA id q21sm9005717pjg.43.2021.07.01.02.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 02:35:45 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <James.Clark@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Daniel Kiss <daniel.kiss@arm.com>,
        Denis Nikitin <denik@google.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 0/3] coresight: Fix for snapshot mode
Date:   Thu,  1 Jul 2021 17:35:34 +0800
Message-Id: <20210701093537.90759-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch series is to correct the pointer usages for the snapshot
mode.

Patch 01 is to polish code, it removes the redundant header maintained
in tmc-etr driver and directly uses pointer perf_output_handle::head.

Patch 02 removes the callback cs_etm_find_snapshot() which wrongly
calculates the buffer headers; we can simply use the perf's common
function __auxtrace_mmap__read() for headers calculation.  Patch 03 is
to update comments in CoreSight drivers to reflect the changes
introduced by patch 02.

This patch can be cleanly applied on the mainline kernel with:

  commit dbe69e433722 ("Merge tag 'net-next-5.14' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next")

And it has been tested on Arm64 Juno board.

Changes from v1:
- Dropped the patch "coresight: etm-perf: Correct buffer syncing for
  snapshot", after a long discussion, the patch doesn't really resolve
  any issues for snapshot mode.  And another reason for unlike this
  patch is now the CoreSight and Intel-PT have the consistent behaviour
  (Suzuki/James/Mathieu);
- Added the patch 03 to updates drivers' comments (James);
- Added Suzuki's review tag for patch 01;
- Added James' review and testing tags for patch 02.


Leo Yan (3):
  coresight: tmc-etr: Use perf_output_handle::head for AUX ring buffer
  perf cs-etm: Remove callback cs_etm_find_snapshot()
  coresight: Update comments for removing cs_etm_find_snapshot()

 drivers/hwtracing/coresight/coresight-etb10.c |   2 +-
 .../hwtracing/coresight/coresight-tmc-etf.c   |   2 +-
 .../hwtracing/coresight/coresight-tmc-etr.c   |  12 +-
 tools/perf/arch/arm/util/cs-etm.c             | 133 ------------------
 4 files changed, 6 insertions(+), 143 deletions(-)

-- 
2.25.1

