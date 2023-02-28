Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32882C64ED6
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Feb 2023 11:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbjB1Lww (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Feb 2023 06:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbjB1Lwv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Feb 2023 06:52:51 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0A42DE75
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Feb 2023 03:52:49 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id n6so8726660plf.5
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Feb 2023 03:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=guDwbtDzSe+f0+mE5P/BUoxD2wXxd/5dZJDCePQTDmo=;
        b=E+V5mFVRRI43IP7kqQcke3AznYV/S6Ax/UM7BApz+3FkhQxAr93dXOqZuqoF/LS+qX
         04HAAJqfSO4vTVuVKUm5Ak1zItk75wJTyI1Ig0R7FfmZFDKedx/11l/5tRwvMC5d7EIX
         vd8w08ex43ahzUMY+XPJL/R6EdGiMF6Ndy1mFcVOgmkx2GL0MbqupOL5LkA3+vQW1/zd
         eJFr8GlHR/1qNjS/Zn0wNk36DogNRB+W/saHAdwUxnUa8PXKdgeNxv5bAIemq087I9cW
         iQL+T0w1Q5WLiaS2TtNS0fnBcDPpl564goMRO4280uEGNLnML1rzjQ00rvJhfuzwCU4h
         5MbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=guDwbtDzSe+f0+mE5P/BUoxD2wXxd/5dZJDCePQTDmo=;
        b=zqMuob0v8cCXvLb/YOCfMgSsJ5r72T+BvmMIHhxglpahwwpA4iLuBSz+3Orp5J8P+v
         1lnc1IaWK3EAvhEFyynuKc4m1g5c8Aa1lc65/iSHr/1tznGBtW0/rVjdwPqnJIx9GIpF
         mJfcZ7JY2B7mrjUUCVPPBM2n5ROOWrPy+wLlZh5z7Shu4hcr7qRMejfvFtarSr5HaKMT
         KWHM3j1Ri7a2mOAjRHSGpjs9Se2vkXChSvfeqcEKtmCLHYJJLuHPmb1kCpkd61KmKDAX
         OhokkjEqDM1YupV1SqyF2P0O2+PY8EWHNLqDXbP/v97rEluuCLZq9XrGF2Zl6xev6zqT
         g15Q==
X-Gm-Message-State: AO0yUKVCSFNaAdGZlYzNuICDCuPZQWY7ChKWWjI1BzsP7bEYsEs/vQ9/
        D0yxfvIgR02b9UHxIKd2T3tf0A==
X-Google-Smtp-Source: AK7set/i2bqxU9AV3gKotxdi1R4HmL6WNw5Uze90LzuUY6rnWopKherWyWPttSRADRJIn1bKAN3G6g==
X-Received: by 2002:a17:90b:350b:b0:236:9e16:b49b with SMTP id ls11-20020a17090b350b00b002369e16b49bmr3150244pjb.21.1677585168902;
        Tue, 28 Feb 2023 03:52:48 -0800 (PST)
Received: from leoy-huanghe.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id gk8-20020a17090b118800b002339491ead6sm7922317pjb.5.2023.02.28.03.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 03:52:48 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 00/14] perf kvm: Support histograms and TUI mode
Date:   Tue, 28 Feb 2023 19:51:11 +0800
Message-Id: <20230228115125.144172-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch set is to enable histograms and (partially) TUI mode in perf
kvm tool.

Patch set v1 [1] gives brief introduction for the change and this series
has a minor update for the patch 13 'perf kvm: Add TUI mode for stat
report' to avoid building failure when the system doesn't support
HAVE_SLANG_SUPPORT.

We can use below commands for testing this series:

In a terminal, you could launch a virtual machine with qemu command; in
below case, I downloaded a Ubuntu (or Debian) iso file and used it as
the file system image:

  $ qemu-system-x86_64 -M pc -enable-kvm -cpu host -m 4096 -hda ubuntu-22.04-desktop-amd64.iso

Then in another terminal, I can use below command to capture KVM trace
data and report the result:

  # cd linux/tools/perf
  # ./perf kvm stat record
  # ./perf kvm stat report          => Output in TUI mode
  # ./perf kvm stat report --stdio  => Output in stdio mode

Changes from v2:
* Found building failure with command 'make VF=1 DEBUG=1 NO_SLANG=1',
  fixed it in the patch 13. (James Clark)

Changes from v1:
* Updated the patch 13 'perf kvm: Add TUI mode for stat report' to avoid
  building failure if no support HAVE_SLANG_SUPPORT.

[1] https://lore.kernel.org/lkml/20230226042053.1492409-1-leo.yan@linaro.org/


Leo Yan (14):
  perf kvm: Refactor overall statistics
  perf kvm: Add pointer to 'perf_kvm_stat' in kvm event
  perf kvm: Move up metrics helpers
  perf kvm: Use subtraction for comparison metrics
  perf kvm: Introduce histograms data structures
  perf kvm: Pass argument 'sample' to kvm_alloc_init_event()
  perf kvm: Parse address location for samples
  perf kvm: Add dimensions for KVM event statistics
  perf kvm: Use histograms list to replace cached list
  perf kvm: Polish sorting key
  perf kvm: Support printing attributions for dimensions
  perf kvm: Add dimensions for percentages
  perf kvm: Add TUI mode for stat report
  perf kvm: Update documentation to reflect new changes

 tools/perf/Documentation/perf-kvm.txt |   9 +-
 tools/perf/builtin-kvm.c              | 856 +++++++++++++++++++++-----
 tools/perf/util/kvm-stat.h            |  26 +-
 3 files changed, 716 insertions(+), 175 deletions(-)

-- 
2.34.1

