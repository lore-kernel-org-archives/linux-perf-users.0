Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BEAC61DA4
	for <linux-perf-users@archiver.kernel.org>; Mon, 13 Mar 2023 11:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjCMLkj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 13 Mar 2023 07:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjCMLki (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 13 Mar 2023 07:40:38 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B64F5D892
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Mar 2023 04:40:37 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id i3so12590582plg.6
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Mar 2023 04:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678707637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0EAtvo1So/zPFTCpyYhVNyCZVLKaC2sgLkHS7h4c9HI=;
        b=X1KDjnPYBYAadbBiCgglFFKeQZxJ/PEdNiBAUYNkojjh67qEA65iUTnBjaB2AvaE+l
         fy2jSsu8P5/IBXSYWxxFDFfRgSmgwP0kq43Wyh3I4nCyf1l7WtkKT74/DvQMM9qQ17j+
         ccUC1l3yk5usFBDWHYBB2Yo/DfliCEaec4XA3ECBOqJoRZRlILI+X0LAHcUfnfEQ+pE1
         P3Ef718VCS/mRIadlud9RVl6nO+OuRjfQ7DFfCXPg0cSge5Rtj7RfKZuO8qdHlOAFlFp
         6P2ERambOtJhrCBAKhC0XXE/XPL5ypnCiIh2bbhXwq1hLh5d+0bRrAci+UDeD7q7oYDw
         DLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678707637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0EAtvo1So/zPFTCpyYhVNyCZVLKaC2sgLkHS7h4c9HI=;
        b=DA9sl8XNna0XgCub5azMOfZzbfTp7BQnsN66CdmPuqV9PwdFlIPzqyNgJOAnfuEpA6
         JF3Fk2rf99XakdtKiYz9TEWByIqHD51tuh++QzZJaOu4HeVn54YSsTWs0NGnhsSmu0xG
         TYFHcX6GkfB0Zn9tB7lCAXjaI/zbqn8FdlgqA3lmSYLPkqkaLS56KyX/k2LryDC2hdrW
         Z+MwxZpEwzPbkj4BaxswiE9fDo1YmZrTUXBiTbdtHLJtLD9fFJeIildNT9lcV5O6r2eo
         7qrKb8H6Cn5ibCPknI8OA7dsOx2Xn9zirlyRkp1qe6BMEZYyL112lP//BRNZ4DvG/ZHo
         NKAg==
X-Gm-Message-State: AO0yUKWPupGrJZPI4zVlvBfu2Y6BJzVJ2JsSvtfPa2E8OMudghot7IGY
        rZDRAPhT80nF/ocTdOh/DciGRg==
X-Google-Smtp-Source: AK7set9socWh1UG+jyBtropg1WjPePnuqA3jmkI1RbgqzI8RMELBbwR9dWUiGkRWFsQfGBlVQ4/tLw==
X-Received: by 2002:a17:90a:b89:b0:23b:5537:8c99 with SMTP id 9-20020a17090a0b8900b0023b55378c99mr4477602pjr.45.1678707636603;
        Mon, 13 Mar 2023 04:40:36 -0700 (PDT)
Received: from leoy-huanghe.lan ([156.59.236.112])
        by smtp.gmail.com with ESMTPSA id q21-20020a17090a2e1500b0022335f1dae2sm4281625pjd.22.2023.03.13.04.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 04:40:36 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.g.garry@oracle.com>,
        James Clark <james.clark@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 00/16] perf kvm: Support histograms and TUI mode
Date:   Mon, 13 Mar 2023 19:40:02 +0800
Message-Id: <20230313114018.543254-1-leo.yan@linaro.org>
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

Changes from v3:
* Updated patch 04 to change comparison function return type from int to
  int64_t to avoid overflow;
* Added a refactoring patch 05 "perf kvm: Use macro to replace variable
  'decode_str_len'";
* Refined to use hists__add_entry_ops() and hist_entry__cmp() to compare
  hist entry and add new entries, to support comparison between hist
  entry, added a new patch 09; (Namhyung Kim)
* Updated patch 10 for comparison event name; (Namhyung Kim)
* Refined patch 11 to move init_stats() and hists__inc_nr_samples()
  into kvm_he_zalloc(); (Namhyung Kim)
* Minor refactoring for sort_result() and kvm_hists__init() in patch 15.

Changes from v2:
* Found building failure with command 'make VF=1 DEBUG=1 NO_SLANG=1',
  fixed it in the patch 13. (James Clark)

Changes from v1:
* Updated the patch 13 'perf kvm: Add TUI mode for stat report' to avoid
  building failure if no support HAVE_SLANG_SUPPORT.

[1] https://lore.kernel.org/lkml/20230226042053.1492409-1-leo.yan@linaro.org/


Leo Yan (16):
  perf kvm: Refactor overall statistics
  perf kvm: Add pointer to 'perf_kvm_stat' in kvm event
  perf kvm: Move up metrics helpers
  perf kvm: Use subtraction for comparison metrics
  perf kvm: Use macro to replace variable 'decode_str_len'
  perf kvm: Introduce histograms data structures
  perf kvm: Pass argument 'sample' to kvm_alloc_init_event()
  perf kvm: Parse address location for samples
  perf hist: Add 'kvm_info' field in histograms entry
  perf kvm: Add dimensions for KVM event statistics
  perf kvm: Use histograms list to replace cached list
  perf kvm: Polish sorting key
  perf kvm: Support printing attributions for dimensions
  perf kvm: Add dimensions for percentages
  perf kvm: Add TUI mode for stat report
  perf kvm: Update documentation to reflect new changes

 tools/perf/Documentation/perf-kvm.txt   |   9 +-
 tools/perf/arch/arm64/util/kvm-stat.c   |   1 -
 tools/perf/arch/powerpc/util/kvm-stat.c |   3 +-
 tools/perf/arch/s390/util/kvm-stat.c    |   1 -
 tools/perf/arch/x86/util/kvm-stat.c     |   7 +-
 tools/perf/builtin-annotate.c           |   2 +-
 tools/perf/builtin-c2c.c                |   4 +-
 tools/perf/builtin-diff.c               |   4 +-
 tools/perf/builtin-kvm.c                | 859 +++++++++++++++++++-----
 tools/perf/tests/hists_link.c           |   4 +-
 tools/perf/util/hist.c                  |  19 +-
 tools/perf/util/hist.h                  |   3 +
 tools/perf/util/kvm-stat.h              |  33 +-
 tools/perf/util/sort.h                  |   1 +
 14 files changed, 745 insertions(+), 205 deletions(-)

-- 
2.34.1

