Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CD9C25B07
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Aug 2022 06:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbiHKGZJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 11 Aug 2022 02:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiHKGZI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 Aug 2022 02:25:08 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1894F8A6FF
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Aug 2022 23:25:07 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 15-20020a17090a098f00b001f305b453feso4418042pjo.1
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Aug 2022 23:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=i7Z567wnPQResZwkbA9bhahJXQAAUrN9ioX9I5+gOa4=;
        b=nX+ND60x40FmgG2d5K6hI0dekXkW2/oDgX4okhvQTMgu15F9ZM8UvkWWGylQTHKsck
         HwYD/bPW8C/qFaVLclZxyLNGxUp4oo0itYtSP708w+XR0+rESTu7qAIHem/6ZsyAaesc
         QyE90atwq7DhODul57hjUL/0XVermZHbit0SzsLgOvVz3Kpq4nFK9yjK81NFA1dF5Aak
         AZb7YQJhP7LKdyH4JV8g6FKvgSvjfCiJbkz/vZNCFFRZvXwl5wcjBCaV30pqNb01yZ7U
         x02bLwOm0qvrxmVR11kENbBczkL3TM4lCZQYAO4nuXakjx1IlmhQ1n5gzLPeVsUCtEP4
         SIPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=i7Z567wnPQResZwkbA9bhahJXQAAUrN9ioX9I5+gOa4=;
        b=GjS+mAxg3AP3s5u7A0dj10u/OLkMYwkt/mdmyVvXMS1zmIOmEJGYYPBnvptdDt5tlF
         IUBsM+X/Ds5OUenQDfiSEbvNRDSfRq1ceci1msX84ZRnY/XYvHZNZAvTkZ8uwZn2FNDw
         cpsZIslO3o73qq5vrA8Fghwz9wTqfySsY1874efRoflDcxEV5xF7nSvgCTg2XsxH6jEv
         WCNLM6+sZSfJsWo1SELZjey1rb3xpNPXIx4aU1+ayKLQgG3PHP2b+9Zt/EzauRg1EA4d
         MMUcAI+DeMuHkIC87bKm3AJQjEPLiwQJAsleAMNQfZArX6fVGUs7EzcaXHmxAoZqtzpO
         aUqg==
X-Gm-Message-State: ACgBeo2L+rBHnt6YMYMUvCNZty6Jhb14RfFXQp9i0pyuRaq5iTr8rfLw
        31F8ygFK0S1+6vC2hqTDWuiwPQ==
X-Google-Smtp-Source: AA6agR7kWfMikr56EQjLtH494GZ4vZcdlrk+19bGX1lm9Fgn/Kr6nBKF54L+RwLSBp0IHuQ9ygliaQ==
X-Received: by 2002:a17:902:d64a:b0:16d:570c:9d7b with SMTP id y10-20020a170902d64a00b0016d570c9d7bmr30896287plh.1.1660199106391;
        Wed, 10 Aug 2022 23:25:06 -0700 (PDT)
Received: from leoy-yangtze.lan (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id o12-20020a17090a55cc00b001f506009036sm2766926pjm.49.2022.08.10.23.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 23:25:05 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ian Rogers <irogers@google.com>, Like Xu <likexu@tencent.com>,
        German Gomez <german.gomez@arm.com>,
        Timothy Hayes <timothy.hayes@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v6 00/15] perf c2c: Support data source and display for Arm64
Date:   Thu, 11 Aug 2022 14:24:36 +0800
Message-Id: <20220811062451.435810-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Arm64 Neoverse CPUs supports data source in Arm SPE trace, this allows
us to detect cache line contention and transfers.

This patch set has been rebased on the acme/perf/core branch with the latest
commit b39c9e1b101d ("perf machine: Fix missing free of
machine->kallsyms_filename").

To make building success, a compilation fixing commit [1] has been sent
to LKML, this patch set is dependent on it.  This patch set has been verified
for both x86 perf memory events and Arm SPE events.

[1] https://lore.kernel.org/lkml/20220811044341.426796-1-leo.yan@linaro.org/

Changes from v5:
* Removed the patch "perf: Add SNOOP_PEER flag to perf mem data struct"
  (Arnaldo);
* Removed the patch "perf arm-spe: Don't set data source if it's not a
  memory operation" which has been merged in the mainline kernel, so can
  dismiss merging conflict.
* Rebased on the latest acme perf/core branch, no any code change
  compared to previous version.

Changes from v4:
* Included Ali's patch set for adding data source in Arm SPE samples;
* Added Ian's ACK and Ali's review and test tags;
* Update document for the default peer dispaly for Arm64 (Ali).

Changes from v3:
* Changed to display remote and local peer accesses (Joe);
* Fixed the usage info for display types (Joe);
* Do not display HITM dimensions when use 'peer' display, and HITM
  display doesn't show any 'peer' dimensions (James);
* Split to smaller patches for adding dimensions of peer operations;
* Updated documentation to reflect the latest GUI and stdio.


Ali Saidi (2):
  perf tools: sync addition of PERF_MEM_SNOOPX_PEER
  perf arm-spe: Use SPE data source for neoverse cores

Leo Yan (13):
  perf mem: Print snoop peer flag
  perf mem: Add statistics for peer snooping
  perf c2c: Output statistics for peer snooping
  perf c2c: Add dimensions for peer load operations
  perf c2c: Add dimensions of peer metrics for cache line view
  perf c2c: Add mean dimensions for peer operations
  perf c2c: Use explicit names for display macros
  perf c2c: Rename dimension from 'percent_hitm' to
    'percent_costly_snoop'
  perf c2c: Refactor node header
  perf c2c: Refactor display string
  perf c2c: Sort on peer snooping for load operations
  perf c2c: Use 'peer' as default display for Arm64
  perf c2c: Update documentation for new display option 'peer'

 tools/include/uapi/linux/perf_event.h         |   2 +-
 tools/perf/Documentation/perf-c2c.txt         |  31 +-
 tools/perf/builtin-c2c.c                      | 454 ++++++++++++++----
 .../util/arm-spe-decoder/arm-spe-decoder.c    |   1 +
 .../util/arm-spe-decoder/arm-spe-decoder.h    |  12 +
 tools/perf/util/arm-spe.c                     | 130 ++++-
 tools/perf/util/mem-events.c                  |  46 +-
 tools/perf/util/mem-events.h                  |   3 +
 8 files changed, 547 insertions(+), 132 deletions(-)

-- 
2.34.1

