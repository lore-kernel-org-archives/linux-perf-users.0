Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F49C07E9C
	for <linux-perf-users@archiver.kernel.org>; Sun, 11 Jul 2021 10:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1493C61205
	for <linux-perf-users@archiver.kernel.org>; Sun, 11 Jul 2021 10:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbhGKKoG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 11 Jul 2021 06:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbhGKKoD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 11 Jul 2021 06:44:03 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54173C0613E5
        for <linux-perf-users@vger.kernel.org>; Sun, 11 Jul 2021 03:41:16 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id d12so14947683pgd.9
        for <linux-perf-users@vger.kernel.org>; Sun, 11 Jul 2021 03:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=autL+G6wNOJhX+2XA6qCLFYkzemigzI9rlpwicEf3/0=;
        b=qmxcjU7pcuXli6awXmV/nZtxDOtEBwFxPrj6N1DIcmTZdtfhFAaPT/AsX3g3YYrZpV
         v0vqF6jyLC1EKqz3YRS5wITXbvMjNmUjKEO/jPb/MUVroPlelu6xOA3qI6A8xxFvWTU4
         VvqkBRJCNqFxVw3CURKvgtoZ0eqJHJQ8cXVfHnNNbbJMGcTwrfYAhoArao6DPawblPS9
         5GWtOB/TnbTOefACYg8WKfeecai7diFsc//80s9+oLet10sngwTlOVNqRw0Wb9tTSmC/
         ShsFIkXwaJ8HMSzv2XvXXMYiu0/ScBCknf3Syxq1FYijVXpl6wjR3VpHN4oEcSL1xKyp
         TQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=autL+G6wNOJhX+2XA6qCLFYkzemigzI9rlpwicEf3/0=;
        b=qh+WOQb0nT5xiP0smhvFeqPbLXM5W9ek69oX1wp7Z5MP2KnH3Mohx3kUrZpDttcWzM
         UpQA2XtDxOjOCkiiIslMAyeqLiGdYqH3c1AnJuKbKlKioixqsOui/UcUOxxysQJlENrl
         H9zkKlSmFlpoadku9KuLNJaYCx/qgJzS4iKZF9huae64fcrBIJKZGd5gMOQVsBNcLgYK
         r9tMD6BTpX3IkMSKJuuYyKNOKqjTVai64Q9Fs+uPvWVfyNjxxDZfzTyfLVCYrZIyz7ph
         4EamxV/ooX31Y1Q8WUKvM8F+8B/keBdbuXY2oEDnnBZj0OWoGxR91ZVsSF2sv3V6DEoQ
         hNfg==
X-Gm-Message-State: AOAM532lu578TZSx4Ye7FzivnhLmit7xStnt4DGbW963/TdmmCyI+ZaD
        nEqyh34u/KXm25b/tQj0yWolnA==
X-Google-Smtp-Source: ABdhPJx6JaA27RaGLvgVyJTKnzik6HHN9J9xNcylnEcWBb6V6DAIk/u/8UHFXFG/VZOrnguSvrwVlA==
X-Received: by 2002:a62:888d:0:b029:329:b081:128 with SMTP id l135-20020a62888d0000b0290329b0810128mr8217397pfd.70.1626000075775;
        Sun, 11 Jul 2021 03:41:15 -0700 (PDT)
Received: from localhost ([103.127.241.250])
        by smtp.gmail.com with ESMTPSA id d3sm10152263pjo.31.2021.07.11.03.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 03:41:15 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 00/11] perf: Refine barriers for AUX ring buffer
Date:   Sun, 11 Jul 2021 18:40:54 +0800
Message-Id: <20210711104105.505728-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch series is to refine the memory barriers for AUX ring buffer.

Patches 01 ~ 04 to address the barriers usage in the kernel.  The first
patch is to make clear comment for how to use the barriers between the
data store and aux_head store, this asks the driver to make sure the
data is visible.  Patches 02 ~ 04 is to refine the drivers for barriers
after the data store.

Patch 05 is to use WRITE_ONCE() for updating aux_tail.

Patches 06 ~ 09 is to drop the legacy __sync functions, and polish for
duplicate code and cleanup the build and feature test after
SYNC_COMPARE_AND_SWAP is not used.

Patch 10 introduces a new global variable to indicate the kernel runs in
64-bit mode which can be used to confirm if in compat mode; patch 11
introduces variant functions for accessing AUX head/tail, it resolves
the aotmicity for reading head pointer, and returns error for the tail
is bigger than 4GB.

Have testes the patches on Arm64 Juno platform.

Changes from v3:
- Removed the inapprocate paragraph in the commit log for patch "perf
  auxtrace: Drop legacy __sync functions" (Adrian);
- Added new patch to remove feature-sync-compare-and-swap test (Adrian);
- Th patch for "perf auxtrace: Use WRITE_ONCE() for updating aux_tail",
  is a standlone and simple change, so moved it ahead in the patch set
  for better ordering;
- Minor improvement for commit logs in the last two patches.

Changes from v2:
- Removed auxtrace_mmap__read_snapshot_head(), which has the duplicated
  code with auxtrace_mmap__read_head();
- Cleanuped the build for HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT (Adrian);
- Added global variable "kernel_is_64_bit" (Adrian);
- Added compat variants compat_auxtrace_mmap__{read_head|write_tail}
  (Adrian).


Leo Yan (11):
  perf/ring_buffer: Add comment for barriers on AUX ring buffer
  coresight: tmc-etr: Add barrier after updating AUX ring buffer
  coresight: tmc-etf: Add comment for store ordering
  perf/x86: Add barrier after updating bts
  perf auxtrace: Use WRITE_ONCE() for updating aux_tail
  perf auxtrace: Drop legacy __sync functions
  perf auxtrace: Remove auxtrace_mmap__read_snapshot_head()
  perf: Cleanup for HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT
  tools: Remove feature-sync-compare-and-swap feature detection
  perf env: Set flag for kernel is 64-bit mode
  perf auxtrace: Add compat_auxtrace_mmap__{read_head|write_tail}

 arch/x86/events/intel/bts.c                   |   3 +
 .../hwtracing/coresight/coresight-tmc-etf.c   |   6 +
 .../hwtracing/coresight/coresight-tmc-etr.c   |   8 ++
 kernel/events/ring_buffer.c                   |   9 ++
 tools/build/Makefile.feature                  |   1 -
 tools/build/feature/Makefile                  |   4 -
 tools/build/feature/test-all.c                |   4 -
 .../feature/test-sync-compare-and-swap.c      |  15 ---
 tools/perf/Makefile.config                    |   4 -
 tools/perf/util/auxtrace.c                    |  19 ++-
 tools/perf/util/auxtrace.h                    | 109 ++++++++++++++----
 tools/perf/util/env.c                         |  17 ++-
 tools/perf/util/env.h                         |   1 +
 13 files changed, 136 insertions(+), 64 deletions(-)
 delete mode 100644 tools/build/feature/test-sync-compare-and-swap.c

-- 
2.25.1

