Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50C8C4338F
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 11:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFBCD60F8F
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 11:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbhHILPi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 9 Aug 2021 07:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234946AbhHILPi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Aug 2021 07:15:38 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE97C0613D3
        for <linux-perf-users@vger.kernel.org>; Mon,  9 Aug 2021 04:15:17 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id q2so15943766plr.11
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Aug 2021 04:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HF9zwf39YHVZ/xNRzTLJZocl+a9xlESe8qkBXQSh72k=;
        b=dD7+MJlbjpccJ9M/03ozzehQwpA+sgBRT0zT/Vqfy2jY1oBIRUBEGt0+L5IUx51kNo
         lXzsu2SFNgVaJC9tgOlvH5Y9gBvQdjb6oTYwmMpMWTkPdfWjZhf+pYc+1MRUBq10IzYq
         TD4QWBoE2TgFF/VxqEiYgbQCR+oGrXklNgpRebSfz3j6MPYQ42Rk1lZHPbnc4Vf1Y4KU
         NP+vdAsarUZ4pXUFRxFCuS35xdbT0YPu6CJhykbMZZrr/02/G3UtmjUzCE1qer9Tgniw
         a4Mt1W3IkSAgzc/zvVrE2UM7rKeHY9b0vIN6ugjsWaIFT30PNdaSd87WrxhR1rc86Yoz
         5llg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HF9zwf39YHVZ/xNRzTLJZocl+a9xlESe8qkBXQSh72k=;
        b=NhdAiF/TatOWyLZzz3OcpmiFNmhuv+oTiZvzwGQTPoKFl5dXFjrp9aUh9JH16kx1t6
         FvwIJtSKam4zc7q8Kr92nEcRsBQgEFO/+0ObFk8KIXD+Nu+reftgBX8juHJ57m2qSboD
         9YXXrGdgSC22w+81hWmma2wn0m2TJn01CU/6Zqb/kw+Eg/EhrhOJXaugOKEzuTO36TFV
         P4vZTGK94acWLFHsdsOL7jnEhTwtrhJpsDQ+8Cm2ULSE0T+LbbK8wLhyoi9YFCdty+KD
         i+3aRTP33DgAKeNqW3daHxCe4WjBtGatAtShZ8IDIWB/we6vp9xacYqJPoiM/6aSGs72
         hbcw==
X-Gm-Message-State: AOAM533ni+L5ER8CP7Odf2S7BUivxlKDzzpijZfHHsa0sle6eIZfdAfs
        ph6hPV+rTVMmpkYkNXR6zOIzdw==
X-Google-Smtp-Source: ABdhPJwH9Q0NLLJRK5o1bYiE+h3L3lo71E0x7NXitJKkzu+AEVvjTEKGnfv0brl1GKpeUjmpu/ogAw==
X-Received: by 2002:a65:68d1:: with SMTP id k17mr21274pgt.285.1628507717335;
        Mon, 09 Aug 2021 04:15:17 -0700 (PDT)
Received: from localhost ([210.0.159.74])
        by smtp.gmail.com with ESMTPSA id 186sm20611228pfg.11.2021.08.09.04.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 04:15:16 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Song Liu <songliubraving@fb.com>, x86@kernel.org,
        =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5 0/9] perf: Refine barriers for AUX ring buffer
Date:   Mon,  9 Aug 2021 19:13:58 +0800
Message-Id: <20210809111407.596077-1-leo.yan@linaro.org>
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

For easier review and more clear patch organization, comparing against
to the previous patch series, the patches for support compat mode for
AUX trace have been left out and will be sent out as a separate patch
set.

This patch set have been tested on Arm64 Juno platform.

Changes from v4:
- Refined comment for CoreSight ETR/ETF drivers (Suzuki/Peter);
- Changed to use compiler barrier for BTS (mentioned by Peter, but have
  not received response from Intel developer);
- Refined the coding style for patch 07 (Adrian).

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


Leo Yan (9):
  perf/ring_buffer: Add comment for barriers on AUX ring buffer
  coresight: tmc-etr: Add barrier after updating AUX ring buffer
  coresight: tmc-etf: Add comment for store ordering
  perf/x86: Add compiler barrier after updating BTS
  perf auxtrace: Use WRITE_ONCE() for updating aux_tail
  perf auxtrace: Drop legacy __sync functions
  perf auxtrace: Remove auxtrace_mmap__read_snapshot_head()
  perf: Cleanup for HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT
  tools: Remove feature-sync-compare-and-swap feature detection

 arch/x86/events/intel/bts.c                   |  6 ++++
 .../hwtracing/coresight/coresight-tmc-etf.c   |  5 +++
 .../hwtracing/coresight/coresight-tmc-etr.c   |  8 +++++
 kernel/events/ring_buffer.c                   |  9 ++++++
 tools/build/Makefile.feature                  |  1 -
 tools/build/feature/Makefile                  |  4 ---
 tools/build/feature/test-all.c                |  4 ---
 .../feature/test-sync-compare-and-swap.c      | 15 ---------
 tools/perf/Makefile.config                    |  4 ---
 tools/perf/util/auxtrace.c                    | 18 +++--------
 tools/perf/util/auxtrace.h                    | 31 +------------------
 11 files changed, 34 insertions(+), 71 deletions(-)
 delete mode 100644 tools/build/feature/test-sync-compare-and-swap.c

-- 
2.25.1

