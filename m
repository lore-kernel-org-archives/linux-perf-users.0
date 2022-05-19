Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3E0C433FE
	for <linux-perf-users@archiver.kernel.org>; Thu, 19 May 2022 03:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbiESDUP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 18 May 2022 23:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiESDUO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 18 May 2022 23:20:14 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466B955353
        for <linux-perf-users@vger.kernel.org>; Wed, 18 May 2022 20:20:12 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id r206-20020a2576d7000000b0064d82e5b692so3288442ybc.11
        for <linux-perf-users@vger.kernel.org>; Wed, 18 May 2022 20:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=LuxVni4aHwzoBwXpBkpdF8i7m2uNy0PLkWHwBcKxQ00=;
        b=CCKtd7GR8nSvO6PQYhltu3h/jGWY/Y8WgaHPFGIar1fsm8WFvHmlZ0ipzwvPm3DWKC
         NSlOLAJ62X7PsFEYEtcdlaB4Z5rUBdR/sFiebQA3VN8/cEXtjINVhzPsVo10qoRtC+BO
         Y3oeM5c/vtsngEFrpCFJUILd43x2CdCOybSn5Wvi3hgKSy9CLgtbG5ywEJACY1rLJoR0
         dEi2EVtz4lOrC3s2MG6Joh1qutsBpdwj5GZaQm57tHmxPJJYT6T2kJYIKbP6Zzvh3cQk
         sLtId9YpMX4I8w7xhLE7CckWwGWjv/cvopWJMGTRtbAgowx+3eqyH2WpFhy9oW68f3Jz
         xVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=LuxVni4aHwzoBwXpBkpdF8i7m2uNy0PLkWHwBcKxQ00=;
        b=PKgnsrGgnsziibvSWaC0ZlYNT44tzFiWQ9wf/F/bcl51+EpBd45rCZMg1FA/2GbaxR
         PPQX6g7SbNXx2bynGOMrSyrKJr054GBoTicngyS6C5EkxFCM4+NwNFzIFaasuEGtJFLE
         5rf3eipT/X+tCcOFCvosjflSq0V3yNwYj3iZ3110MaxGck1/ndxsE/t5rjSq13kX2JUj
         WoUPFUmGBUKQO461r+QQUHMdYWkYZdRYxZbYCa9BjUoUyv8vumWAUle2Lte0+p+65Dw+
         yMQqPs0siTqG/4vGrvtlM+ocohm/Wd3QVYou6V8kDuRYcnABeq+zbxF7pXXzT/NFOGvl
         Kaag==
X-Gm-Message-State: AOAM533fXQLdV4Styy6GfyGS8j8A+Y7DY5VNQqXClh7rYaasHqwFd7ro
        J+UFfiU9UsX4PHvz0dp/nd7qUquu77hS
X-Google-Smtp-Source: ABdhPJzG1oTOx2/i021ptIUrHFpfkP7ts5RITI/ZnnYmmrugR/Rhh79It43/VBwAMEbVyobDpdUWt238HZS7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:a233:bf3c:6ac:2a98])
 (user=irogers job=sendgmr) by 2002:a05:6902:1002:b0:649:70c2:db58 with SMTP
 id w2-20020a056902100200b0064970c2db58mr2518912ybt.68.1652930411395; Wed, 18
 May 2022 20:20:11 -0700 (PDT)
Date:   Wed, 18 May 2022 20:20:00 -0700
Message-Id: <20220519032005.1273691-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH 0/5] perf_counts clean up and perf stat report bug fix
From:   Ian Rogers <irogers@google.com>
To:     Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Lv Ruyi <lv.ruyi@zte.com.cn>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

perf_counts takes a CPU map index as an argument, however, there were
a few places where this hadn't been cleaned up and the index was
called cpu. In part this led to the bug discovered by Michael Petlan in:
https://lore.kernel.org/linux-perf-users/CAP-5=fWQR=sCuiSMktvUtcbOLidEpUJLCybVF6=BRvORcDOq+g@mail.gmail.com/

Fix the bug, tidy up more of the arguments passed to perf_counts, add
a test to ensure the bug isn't reintroduced and add a helper macro to
iterate over just CPU map indices.

Ian Rogers (5):
  perf stat: Fix and validate inputs in stat events
  perf stat: Add stat record+report test
  perf cpumap: Add perf_cpu_map__for_each_idx
  perf bpf_counter: Tidy use of CPU map index
  perf stat: Make use of index clearer with perf_counts

 tools/lib/perf/include/perf/cpumap.h |  3 ++
 tools/perf/tests/shell/stat.sh       | 13 ++++++
 tools/perf/util/bpf_counter.c        | 61 ++++++++++++++++------------
 tools/perf/util/stat-display.c       | 22 +++++-----
 tools/perf/util/stat.c               | 27 ++++++++----
 5 files changed, 81 insertions(+), 45 deletions(-)

-- 
2.36.1.124.g0e6072fb45-goog

