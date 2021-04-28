Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC64C433B4
	for <linux-perf-users@archiver.kernel.org>; Wed, 28 Apr 2021 11:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A550C610F7
	for <linux-perf-users@archiver.kernel.org>; Wed, 28 Apr 2021 11:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhD1L65 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 28 Apr 2021 07:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbhD1L65 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 28 Apr 2021 07:58:57 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE88C061574
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Apr 2021 04:58:12 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id z16so3620651pga.1
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Apr 2021 04:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mkMbPMNc8FrnP1KGwkLDeuVNNhulyW7sGFTZ5AZrIsI=;
        b=ZLckhhCpN9pyq4UEm0Ez/r/KXh8xRLpXup/VBIVgEsRqD98hdgMxzWzr7olhSXOp2E
         po1SKCue0Fd2QRSyGk1k7r1aA1C7kVwAHPRvQL+H909rxysQmmbzGlHh3RpN9D3cGURT
         HfROCIylDpoxmuDlQYO7MSfWYW6jDJ0UomFFEYhubHFMcqmzo5/4xx9MJPjmvWdG07zw
         lb2ohJugNDyEZ7fBrjWTylpHkT4QtdTlctkqp1dUYM8cfjxykog0kNLQ6CQgpzlsBi4F
         TLtauOtH2Nc2gjyn522V5o6uQH95rToghX421exiZJ8vdKggAxp7ZJnNm4owgUQMeoYe
         kvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mkMbPMNc8FrnP1KGwkLDeuVNNhulyW7sGFTZ5AZrIsI=;
        b=gz5Uu4JPcv0GCK8pmNDIj9xdQM0johuYI3MBETA8FkhtrIFz4ghxCKRaaMGtWxSJSZ
         X79qzKT9xj9sL/3irWkw0VlpEz2J26dfDoz+KVsHQL7zi5Gd5wnKTVMWVLm/TBuXy6MQ
         mdEkBcSAE+VM4QONtbNb3m0JaG1e6HMpvnA7kxUmyOy9Qcs181Wq5ybFp4iKe85D6XfS
         byeePQ1X4UtLWVADMVoHSOQ/AtXqXUyhRDwrI9RSTeg6eeFFpa4p2eXbSFqV3RC2J701
         6f1lN9UkLmo3aFn5KkrofNPMh2EMjp/1Mr/5C369QWbEAbSkmBjV5LwqTGkKMwmnv0sd
         bQow==
X-Gm-Message-State: AOAM530mjU/a2X7yfT3zbsniZvabkOV1rDP62Rtux6k7QXCd/lhjZtSv
        W2POzQN5bvGvHmjqsic+/v4ixSeqbopYQxLD
X-Google-Smtp-Source: ABdhPJzjKP3SaW1skFaXQk2w6oVlp46c3Ap84jbXg1gAv9zIf11TRLHkDu14Qi6IKiq+sVnBPAIPqw==
X-Received: by 2002:a05:6a00:2283:b029:261:abae:917e with SMTP id f3-20020a056a002283b0290261abae917emr27308366pfe.78.1619611092089;
        Wed, 28 Apr 2021 04:58:12 -0700 (PDT)
Received: from localhost (ec2-18-166-74-158.ap-east-1.compute.amazonaws.com. [18.166.74.158])
        by smtp.gmail.com with ESMTPSA id pc17sm5010138pjb.19.2021.04.28.04.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 04:58:11 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Steve MacLean <Steve.MacLean@Microsoft.com>,
        Yonatan Goldschmidt <yonatan.goldschmidt@granulate.io>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 0/4] perf: Allow TIME_CONV to be backwards-compatible and dump it
Date:   Wed, 28 Apr 2021 19:57:45 +0800
Message-Id: <20210428115749.5229-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The event PERF_RECORD_TIME_CONV was extended for clock parameters, but
the tool fails to be backwards-compatible for the old event format.

Based on checking the event size, this patch series can decide if the
extended clock parameters are contained in the perf event or not.  This
allows the event PERF_RECORD_TIME_CONV to be backwards-compatible.

The last patch also is introduced for dumping the event, for both the
old and latest event formats.

The patch set has been rebased on perf/core branch with:

  commit 4c391ea001cb ("perf beauty: Fix fsconfig generator")

And the patches have been tested on Arm64 HiSilicon D06 platform.

Changes from v1:
* Changed from bool to __u8 for perf_record_time_conv (Adrain);
* Added helper event_contains() and used it (Adrian).


Leo Yan (4):
  perf tool: Change fields type in cap_user_time_short
  perf jit: Let convert_timestamp() to be backwards-compatible
  perf session: Add swap operation for event TIME_CONV
  perf session: Dump PERF_RECORD_TIME_CONV event

 tools/lib/perf/include/perf/event.h |  7 +++++--
 tools/perf/util/jitdump.c           | 30 +++++++++++++++++++----------
 tools/perf/util/session.c           | 28 +++++++++++++++++++++++++--
 tools/perf/util/tsc.c               | 30 +++++++++++++++++++++++++++++
 tools/perf/util/tsc.h               |  4 ++++
 5 files changed, 85 insertions(+), 14 deletions(-)

-- 
2.25.1

