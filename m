Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5101FC64EC7
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Feb 2023 08:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjB1ImK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Feb 2023 03:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjB1ImJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Feb 2023 03:42:09 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4B42B2B1
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Feb 2023 00:42:06 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id m3-20020a17090ade0300b00229eec90a7fso1162363pjv.0
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Feb 2023 00:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J9njW0cUbNCRuiNeQxGyy89Ebw0Or/C3k7q9j1gWUT4=;
        b=Fz7i6nrjXww1gv1ezA4Y4yQxAb8IkoZCXLDxx+rCPDUDzokDGbwNvPpsZaIKP1n8Ua
         vqPz3OuTl/2iaPW3DimWs+hovbQy1+K6dohaRrsswjKI3rEye34lVeQ0v786HPvlNDCR
         KSMTBp/lXMCP64E/MocCrRRAUac5BgqayPelCb5C/0/sZeBgeVh3hg6MjqaFm0hw+BWB
         sM0psZJKlqX6HsOoJgKVaq2KU3QhhCBrL2+DueBKo2PkeBodGUpAqW4qsqNEcQv7vhXa
         qHq0QY1OSlkSNQIX6AsjKWRbKbsEyPZT7MkBSoRUvljANjmyq3aMieYGjrFmTPCtusvc
         dmtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J9njW0cUbNCRuiNeQxGyy89Ebw0Or/C3k7q9j1gWUT4=;
        b=OzZu/Ovn27nK7N3G1s0Jp+ukyg5Gty+uhlscvCHYuGowfCX1rj7ydGW2zwh8/n5SCG
         0OYcOatmItSMc+Ep7VtsjdWf+otRY2iPXqxgNtdz8/XFh2kWqFpHSdtGnlYiR5xnYOrS
         1vSdJH8TSCSnBkOMblEGuomrCvX6f8azNmyHpWotmCfMDvQeVcpimlkYpLFsADm61HQR
         C0gaRe7m+9iIxZUAhDMsTu0U800imCYv1wWto8J1p8BZa65P296L00DpPRoE+J7E1MQT
         RQP0Bd9u63ckeLDacgQbmzq5BtE2mRoidhLaTjMNg6bpy5KiytTw9LyT22Hb5Pkpkl8M
         Mr0A==
X-Gm-Message-State: AO0yUKVStNEVUv/UF3KhXCoN1dsXqoB9c5yJKZe+vqMfvch3FOt/t7eH
        jSTqGoGdf2fg2ncIthHLPyXd1A==
X-Google-Smtp-Source: AK7set+IIpVK0uNnk/0dM93v3vTiIcfRXLiIpcFn0O+TyLfiPU9UYFkt3xoDxJoFYwa9X5LOa5uqUA==
X-Received: by 2002:a05:6a20:428b:b0:c2:fb92:3029 with SMTP id o11-20020a056a20428b00b000c2fb923029mr2964908pzj.33.1677573725792;
        Tue, 28 Feb 2023 00:42:05 -0800 (PST)
Received: from leoy-huanghe.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id u25-20020aa78499000000b005d6fcd8f9desm5681270pfn.94.2023.02.28.00.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 00:42:05 -0800 (PST)
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 00/14] perf kvm: Support histograms and TUI mode
Date:   Tue, 28 Feb 2023 16:41:33 +0800
Message-Id: <20230228084147.106167-1-leo.yan@linaro.org>
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

