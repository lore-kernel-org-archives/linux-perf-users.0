Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231C7C433ED
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 May 2021 04:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0188561364
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 May 2021 04:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbhESERN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 19 May 2021 00:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbhESERN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 May 2021 00:17:13 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED999C06175F
        for <linux-perf-users@vger.kernel.org>; Tue, 18 May 2021 21:15:53 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id pi6-20020a17090b1e46b029015cec51d7cdso2725803pjb.5
        for <linux-perf-users@vger.kernel.org>; Tue, 18 May 2021 21:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8KlIx2h9yP5lu52R7H8yaLkI8C4WgX2JDrvEkj4ssOY=;
        b=mhFRGQhblIWhwIIBvChprBSmli3LGqtGXscKQA0LyUxX+S8NgxhImXrSM0Z0vIwvgn
         BCzS1fASl+A6G1Ax+0gxtUjGbswxQHQjHhO7UtvTUXKW00qY4B8LRarU4IFTzEhRXe9t
         juyOeb8ggNJZRuAWU6+LmJc8GdvKecg0tbTqWuFHWWNeTHxBrsQf4h/hA3gn++suCJ4Y
         RO2lslmVQHmcDVK76wO03RofWzbB9Dko1qIVoq2qV1q52xljuJCvWPkXnG6815EQoy7h
         hhZYlEYvk8/S39E49x4V7V7k0IhuuWxRi+DAgPzFh4pebYa574GDEuTR4kJQ9wLzDYm/
         Iw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8KlIx2h9yP5lu52R7H8yaLkI8C4WgX2JDrvEkj4ssOY=;
        b=kl1eYWOZImy6IdNjKbIVJmhaLfMaZtr5lqF1MMhdtCmlWowcUjsv7/YnV3bpppjab8
         7nU8ywkSPAotFKGoCQ0aLoSKz6+ZJbVBwKNH7UtsHZ4ptjkRFerWxoL369Bki/WyKyCB
         bwUIbK+DnyUfK8Z3pAO4GC25ZYH2F+ZXw0GIqABzW8lOH+7l7yo+/6tDBY+mf9aUlLql
         i7nC9D5SneKf11vCtN7iXA0gzBEk+5CRtI2F6EDCDyX8DApFueL2I0vxOxzfQw8/PB2n
         UJdsPLnSwNIE/W/p434fi4isOcWIq8BAP4u404XTE3TIIIxPzk1TRNxgfKF2M1q6njdT
         L+YA==
X-Gm-Message-State: AOAM531TiY64ItxMw03zoKVmxCNWiKg/I6uugHLX4R/R3Pz0hmjRO4kl
        y3kD/Lj95oap3pLwVI6V2JLi8g==
X-Google-Smtp-Source: ABdhPJzUgy+j31LqGWq+8AtbM+zgRTuVzM7+bhTOYQ4DSsiEzvm1Tsp8QY3mb94aFCSqtcNDMFgM9Q==
X-Received: by 2002:a17:902:b7ca:b029:f0:b0ea:db44 with SMTP id v10-20020a170902b7cab02900f0b0eadb44mr8477803plz.59.1621397753403;
        Tue, 18 May 2021 21:15:53 -0700 (PDT)
Received: from localhost ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id j189sm13434033pfd.21.2021.05.18.21.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 21:15:52 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>, Al Grant <Al.Grant@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 0/4] perf arm-spe: Correct recording configurations
Date:   Wed, 19 May 2021 12:15:42 +0800
Message-Id: <20210519041546.1574961-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch series is to correct Arm SPE recording configurations.

As James Clark found, there have several issues of recording
configurations for Arm SPE.  One main issue is the sample flags setting
for Arm SPE event and dummy event, and there have two minor issues for
enabling timestamp and redundant checking for "full_auxtrace".

This series fixes these issues and has been tested on Arm64 Hisilicon
D06 platform.

Changes from v1:
* Added patch 04/04 to remove redundant checking for "full_auxtrace" 
  (James);
* Added James Clark's Tested-by and Reviewed-by tags for patches 01-03.

Leo Yan (4):
  perf arm-spe: Correct sample flags for SPE event
  perf arm-spe: Correct sample flags for dummy event
  perf arm-spe: Enable timestamp for per-cpu mode
  perf arm-spe: Remove redundant checking for "full_auxtrace"

 tools/perf/arch/arm64/util/arm-spe.c | 45 +++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 7 deletions(-)

-- 
2.25.1

