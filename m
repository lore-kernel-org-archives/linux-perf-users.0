Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19377C83F01
	for <linux-perf-users@archiver.kernel.org>; Sun, 27 Aug 2023 13:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjH0NhX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 27 Aug 2023 09:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjH0NhK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 27 Aug 2023 09:37:10 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCD311C
        for <linux-perf-users@vger.kernel.org>; Sun, 27 Aug 2023 06:37:08 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68c0d886ea0so1454705b3a.2
        for <linux-perf-users@vger.kernel.org>; Sun, 27 Aug 2023 06:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693143427; x=1693748227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fxGmRwFDOPFQ2VNKBgkXhNqTcIAg/eEBzz2KL/VMfQ4=;
        b=qLZ111W4W442a6ooOGzUM1cbV+FmoG1PtWYfNcmvLZNHMZ+S1Pe3QzAPziv/zKmvcd
         HGmEe9NYUdjnAMUFVZEvaO8CcQr1R2pkl3hddzURsk0ho3GLlz90zpAgrpLi9lgbaqHo
         4MRWRbUnieXVTh8DRru2qaPkLGmCYg7aJbBeH2/q0w6LCkldc/FCZJiEWOvbtkD2bUhr
         Gh2mRYFUJZlVOl5pgshjbuiVcdRdrBSc2IPUS4mXdoocrfvpBV2wperkBtIfwC9COw3O
         dRAhAp6lrv4r7oOr+BvJ+JMRpVYmj/0gC4bL++6SePVNdpH+FwvwkvPwPMcS3rLO4v6c
         YYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693143427; x=1693748227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fxGmRwFDOPFQ2VNKBgkXhNqTcIAg/eEBzz2KL/VMfQ4=;
        b=V/LIrvpROuZ+S+6uzqOJsgSp5IBSTKr//Ebkv6Rf3Yf/6AQeMB+5iAweughxeiWjc7
         7M9Hvy6unJRPxQu6NCvoRs6dCvgF9EeW9KxRmUx/s0g4dEs8HWtBj4xNbTydZUgCtO1u
         SFtgAiWJeF1Y7QtQHqi9DyTZ4teF341xZQn0fdmaTRKniflDLHVpeSYvAWx3X/9LohXS
         Laesd4LJa7nXjpRuA/AUYPgX/UDd3SYWGezeluGljai0tgXzPh7Fe8o35RFoB87+MuTI
         nRS4EarPvPF7gxpt9munfO6W5XhGpgMBp4xvfCdU0qwbCx30ttZIdSxVTb7Yii3grH2/
         oqUQ==
X-Gm-Message-State: AOJu0YwKzzlpQYtKFzzRr15s4QZS8oe70F5AHlfW1hsldIPZCly7NfMb
        BrnUjmKltrxF3hG/853vdKGYzQ==
X-Google-Smtp-Source: AGHT+IERYpuwTJTlj0ke5t7pAohCypc8C9ZeCEec+440h7vM7t37OT+xF5GUTjWJ6hrqtpi65H4oqg==
X-Received: by 2002:a05:6a21:329f:b0:10f:be0:4dce with SMTP id yt31-20020a056a21329f00b0010f0be04dcemr30895212pzb.8.1693143427445;
        Sun, 27 Aug 2023 06:37:07 -0700 (PDT)
Received: from leoy-huanghe.lan (211-75-219-204.hinet-ip.hinet.net. [211.75.219.204])
        by smtp.gmail.com with ESMTPSA id e29-20020a63371d000000b00565eb4fa8d1sm5273627pga.16.2023.08.27.06.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 06:37:06 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <james.clark@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 0/2] perf cs-etm: Improve timestamp tracing
Date:   Sun, 27 Aug 2023 21:35:55 +0800
Message-Id: <20230827133557.112494-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch series is to improve timestamp handling in per-thread mode.

The current code doesn't validate timestamp and always return success for
per-thread mode, for a sane implementation, the first patch is to allow
validation timestamp tracing in per-thread mode.

The second patch is to respect timestamp option "--timestamp" or "-T",
when users set this option, the tool will automatically enable hardware
timestamp tracing in Arm CoreSight.


Leo Yan (2):
  perf cs-etm: Validate timestamp tracing in per-thread mode
  perf cs-etm: Respect timestamp option

 tools/perf/arch/arm/util/cs-etm.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

-- 
2.34.1

