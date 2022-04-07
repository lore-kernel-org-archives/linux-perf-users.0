Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A09C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Apr 2022 23:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbiDGXHO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 7 Apr 2022 19:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbiDGXHN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Apr 2022 19:07:13 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5860BCB57
        for <linux-perf-users@vger.kernel.org>; Thu,  7 Apr 2022 16:05:12 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2eb4f03f212so60972517b3.2
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Apr 2022 16:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=3CKrl89DJ1eArw5yXg6yQJm2IzsI3jJzLx/oCvEr+S8=;
        b=BrjbOvi97KBq0KuSeXgzYX1tREisnvDljjjcM8IUk4AN53vhK1IvuAn3yRruMRrqYy
         3g8tROUFXw9m0hTNvLJgzpFLCUBAAclCy6ML8mp2d4I3f2V3AkAKvIrivoX00+2ccvQ4
         NheSFFgmOa9YkswoPimT0npsnm69YRnvSitFxxI3b87Bgc6cjDJXSIeeDqcTlpAJiCXM
         4QNjCI923pPwOOSmLgwM5PoDvfz0glZLUfsCI6mGrPb+03igLIrtnlPgu/s79iH3uUrD
         ikA6M5hHtPnWc9IU+8E2hvIk8kWHeKU7xJ/39JkP077VMCe1sfdxRgHGYBdWa0bYXiTh
         Mptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=3CKrl89DJ1eArw5yXg6yQJm2IzsI3jJzLx/oCvEr+S8=;
        b=y90XnAAV8wWff+5sTNoejiATMz6P0LDCBGBCvdo0/CEqEn9ir/4RP/UPkjO9mX3JOd
         k0gI6GVQ8sjdHuz/2FMUELg8rhhfrLt7GT2S/2E0O1oJne2QNKKwFoQhzUQDzKH9XVTh
         0oLT0oEOYxW73LYBYShbTK0WeAYfM7LG1/z58p7ZvF3edSRqVUU7QjnWG9KrwKQSclrs
         tGFIhp7osAfnEBiJPSb7OPSaMvzrJ51NJ1xlrt/BdzcUNxOAhbjJPY4eXCmxRmOzcTgZ
         eolTllB/rKfcMm25qrgfa+7g3oLPQBMVVfv3O2s8ajguumqvXxCBswn+F7zNWCVQ+NKt
         +v3g==
X-Gm-Message-State: AOAM532f6XsGn7DgOTG2rgcHsfATH/J9gD5WswtFRCkhmo3roCGr1cr+
        wTsa72y5HdROfi4s0CdGbXQE/CoHT6u1
X-Google-Smtp-Source: ABdhPJwy48FFOFhpFYLNupwB82gwpEN1VzGfu5MwTQeS3yqZlG6h0C+aNVT5PctDKFdcGIY5pViLbIEd3Eer
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:560:aa27:649e:a07d])
 (user=irogers job=sendgmr) by 2002:a05:6902:1107:b0:63d:e354:c541 with SMTP
 id o7-20020a056902110700b0063de354c541mr13119837ybu.346.1649372711827; Thu,
 07 Apr 2022 16:05:11 -0700 (PDT)
Date:   Thu,  7 Apr 2022 16:04:58 -0700
Message-Id: <20220407230503.1265036-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH 0/5] Tidy up symbol end fixup
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Alexandre Truong <alexandre.truong@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Ian Rogers <irogers@google.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Li Huafei <lihuafei1@huawei.com>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        William Cohen <wcohen@redhat.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Lexi Shao <shaolexi@huawei.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Denis Nikitin <denik@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Fixing up more symbol ends as introduced in:
https://lore.kernel.org/lkml/20220317135536.805-1-mpetlan@redhat.com/
caused perf annotate to run into memory limits - every symbol holds
all the disassembled code in the annotation, and so making symbols
ends further away dramatically increased memory usage (40MB to
 >1GB). Modify the symbol end logic so that special kernel cases aren't
applied in the common case.

Minor fix to perf annotate to not stall when stderr is full.

Ian Rogers (5):
  perf annotate: Drop objdump stderr
  perf symbols: Always do architecture specific fixups
  perf symbols: Add is_kernel argument to fixup end
  perf symbol: By default only fix zero length symbols
  perf symbols: More specific architecture end fixing

 tools/perf/arch/arm64/util/machine.c   | 14 +++++++++-----
 tools/perf/arch/powerpc/util/machine.c | 10 +++++++---
 tools/perf/arch/s390/util/machine.c    | 12 ++++++++----
 tools/perf/util/annotate.c             |  1 +
 tools/perf/util/symbol-elf.c           |  2 +-
 tools/perf/util/symbol.c               | 14 ++++++++------
 tools/perf/util/symbol.h               |  4 ++--
 7 files changed, 36 insertions(+), 21 deletions(-)

-- 
2.35.1.1178.g4f1659d476-goog

