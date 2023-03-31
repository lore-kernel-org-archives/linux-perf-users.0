Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3B7C6FD18
	for <linux-perf-users@archiver.kernel.org>; Fri, 31 Mar 2023 05:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjCaF4w (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 31 Mar 2023 01:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjCaF4v (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 31 Mar 2023 01:56:51 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A57C16D
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Mar 2023 22:56:50 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id v6-20020a05600c470600b003f034269c96so2895660wmo.4
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Mar 2023 22:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680242209;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/jH0xPqB6+Pn+vISLE52np45zk9fgumfQUoqdD2YAc=;
        b=UslLcl/w9lPYagwyWUN6K+ZQJdTl/H20JiW1rJDfE1uogo/kwa9HTd52sgBvP8WdkK
         e9GLPmNGdRvA1ZxTWkOIjlrTy4TApoyzZfvrB7U4f4KLgrAUGLOwT+zZxmK6AebnG8We
         FhYoLzAku62Oh1fG1h8aBSN05+PKhftIhzp0X69uvDujRqmNRp2KPA3GZ8/FK/JQqa2n
         ZH7UB/XZe1S36MpkGHKXNWJVj2ztBr5t2nUXV5akoQ8ny6ea6CgAGXXCE9rQKou0ZKME
         zZcp2njq5UUblK1PsBOIYMiF3x43BJdHhfdoHNEUTK7n2MZQ0DPMOLka7YDePvesIIrl
         NaLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680242209;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s/jH0xPqB6+Pn+vISLE52np45zk9fgumfQUoqdD2YAc=;
        b=N/Za8Et6p29AEN53cchMsOgIvsAtZsB/VpDUCotTXlDDZH45NdSTCPlViLQ00ufDgs
         a/vYIJ8xlMdTwYKiNlLrg/TfCXIqEYu8gZ3k1CgfMDr/2SAlVyWwPHlorauxo+TR4+nO
         p2Ggy1MnMT2Oh74U+ubr4v5cAczlnMC1/e+nh1TNFt2kn7NP4ebIoaa9XKuaaMeMnBik
         Tst3OoTs43HgFmxnlKCbKVH1fkKl4IvRxSIZgkk654Fvyr7gQcKVledBKbUOu4Gv2Sku
         wUEaKzdPUObW4DgB1Otm9ChPDlSjoGekV4tOWdq5cnbyPOdhBUa/+dYmxtTR+GUMmKjv
         pHVg==
X-Gm-Message-State: AO0yUKW2yM2+dimU+Huc6f8kAnSMnSIIQE2WsRMilVEtw/tEC2wqhoGw
        qRWU5KKjv4ec+kKcmLDdX38djrvrzQ7OfwOP3BU=
X-Google-Smtp-Source: AK7set9P5+8EdigmsCScfkL39tpuIF6bb7WS1jmhE+FKALWhub/tvT57wsJPsrCo7mbn5hxwgHU2SQ==
X-Received: by 2002:a7b:cb93:0:b0:3ee:814b:9c39 with SMTP id m19-20020a7bcb93000000b003ee814b9c39mr19104518wmi.18.1680242209130;
        Thu, 30 Mar 2023 22:56:49 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:680a:d01:24d4:5fa:d4b2:7c14])
        by smtp.gmail.com with ESMTPSA id iz5-20020a05600c554500b003ef67ac3846sm8464055wmb.24.2023.03.30.22.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 22:56:48 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, acme@kernel.org
Cc:     suzuki.poulose@arm.com, leo.yan@linaro.org, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, gankulkarni@os.amperecomputing.com,
        darren@os.amperecomputing.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v9 0/3] perf: cs-etm: Update perf to handle new Coresight Trace ID
Date:   Fri, 31 Mar 2023 06:56:42 +0100
Message-Id: <20230331055645.26918-1-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The original method for allocating trace source ID values to sources was
to use a fixed algorithm for CPU based sources of (cpu_num * 2 + 0x10).
The STM was allocated ID 0x1.

This mechanism is broken for systems with more than 47 cores.

The kernel related patches the provide a fixed Trace ID allocation mechanism
are now upstreamed.

This patchset updates the perf code to handle the changes to the trace ID
notification mechanism that now uses the PERF_RECORD_AUX_OUTPUT_HW_ID
packet to set Trace ID in the perf ETM decoders.

Applies and test oo perf/core

Changes since v8:
1. Fix build issues
2. Fix implicit function problem

Changes since v7:
Split from original patchset [1] to be sent separately as kernel related
patches are now upstream.

[1] https://lore.kernel.org/linux-arm-kernel/20230116124928.5440-1-mike.leach@linaro.org/

Mike Leach (3):
  perf: cs-etm: Move mapping of Trace ID and cpu into helper function
  perf: cs-etm: Update record event to use new Trace ID protocol
  perf: cs-etm: Handle PERF_RECORD_AUX_OUTPUT_HW_ID packet

 tools/include/linux/coresight-pmu.h           |  47 ++-
 tools/perf/arch/arm/util/cs-etm.c             |  27 +-
 tools/perf/util/cs-etm-base.c                 |   3 +-
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c |   7 +
 tools/perf/util/cs-etm.c                      | 326 +++++++++++++++---
 tools/perf/util/cs-etm.h                      |  14 +-
 6 files changed, 356 insertions(+), 68 deletions(-)

-- 
2.17.1

