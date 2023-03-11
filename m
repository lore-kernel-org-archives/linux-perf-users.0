Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E97BC678D5
	for <linux-perf-users@archiver.kernel.org>; Sat, 11 Mar 2023 06:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjCKG6M (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 11 Mar 2023 01:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjCKG6L (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 11 Mar 2023 01:58:11 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19B4193E8
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Mar 2023 22:58:08 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id x64-20020a25ce43000000b00ae6d5855d78so8157154ybe.12
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Mar 2023 22:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678517888;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pD8c7jNdpj5ptTgq1gX/x9ALXUHbsLatMpWGDnoqbzQ=;
        b=kWuFyS4fBm4SiaMrQwcGUG+RzZteQEFtk8mf3AG6uyRzq7T3wLQb7jOQsVkQZ+tBYY
         fuzH0baQNT7imkIuqlEF/oDU2tHjCViefrXQc7Rcd2ksllCsadqMo0KHCKAWjP40UACN
         flARb8jvg5Zb6RM4FFO6mD6DyH7Td9s+CzE2KZfYlXajgIBgcHKNxaqeRmDUGegjnsmG
         xIKNKhSzxK5D3/LXWkTMaa6I1kA16k5xaE1l0mchax554KT+c4i10VdgEYxzp1yIG13a
         UGgIetYbLlqqIPWOJAy7rO7OrdcWLo69ihSzaIg5wopzlPqqlCZRft6Oe9YWJDyJ35DG
         s7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678517888;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pD8c7jNdpj5ptTgq1gX/x9ALXUHbsLatMpWGDnoqbzQ=;
        b=R3n2VEijdmfW+1hZ2jqBkgfyvgZSdvxsVMqFZGhD7ohzJ1Ud7jzllfBQhlmsyuljyQ
         vrqZ6egMCdaYaMskzTJI4tOHMSoQ+6NlsQ75DQBcGEIgfzNw2QsaxyCEKsRZekt/rqr/
         HoZFXlVmYy0DX1H/or//rdnsMyc+dBjoBX5hZqDAWpzInrhQqCoX+IBPsmguFB9hCG1y
         bCrndcdbVHmYq3XcdaVi1yEBUa9fTzrh30RtcIkzA0JRTo0gFE0HbzA/3KnEiMTNEqt4
         e89i1ZWeBQUw+9LLgYZS6/3NoEVEml6EayGw1Kj2p9dp3Sh5xm/Mge5eczbRexAFM668
         GvSg==
X-Gm-Message-State: AO0yUKUd7v8/oo+oISbx16Lo//ojjwN9csWRS20D5Ip7RtPDBzKNC8UM
        /7j8ilRSD+12Gz6zz8BXgSVU0USa6KEI
X-Google-Smtp-Source: AK7set8ozQE07aJyWsS9+H7+0a3rX8LyO18V2wF+euw7j31c9xAaAA7NMVClhPZfql3wEq3+LUy8xhszx5Jv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a11d:a763:a328:f2d6])
 (user=irogers job=sendgmr) by 2002:a81:ae1d:0:b0:52f:23f5:4079 with SMTP id
 m29-20020a81ae1d000000b0052f23f54079mr18340384ywh.4.1678517888215; Fri, 10
 Mar 2023 22:58:08 -0800 (PST)
Date:   Fri, 10 Mar 2023 22:57:40 -0800
Message-Id: <20230311065753.3012826-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v1 00/13] Perf tool build improvements
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Andres Freund <andres@anarazel.de>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        llvm@lists.linux.dev
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Make the default build options a more preferred set, such as making
BPF skeletons default and failing the build if jevents or libtracevent
dependencies fail. The binutil dependencies are opt-in given license
restrictions. abi::__cxa_demangle demangling support is added so that
libiberty, from binutils, isn't necessary for C++ demangling.

Some build/test dependencies are fixed and the code cleaned up.

Ian Rogers (13):
  perf build: Support python/perf.so testing
  perf build: Make BUILD_BPF_SKEL default, rename to NO_BPF_SKEL
  perf build: Remove unused HAVE_GLIBC_SUPPORT
  perf build: Error if no libelf and NO_LIBELF isn't set
  perf util: Remove weak sched_getcpu
  perf build: Error if jevents won't work and NO_JEVENTS=1 isn't set
  perf build: Make binutil libraries opt in
  tools build: Add feature test for abi::__cxa_demangle
  perf symbol: Add abi::__cxa_demangle C++ demangling support
  perf build: Switch libpfm4 to opt-out rather than opt-in
  perf build: If libtraceevent isn't present error the build
  tools headers: Make the difference output easier to read
  perf build: Remove redundant NO_NEWT build option

 tools/build/Makefile.feature              |   1 +
 tools/build/feature/Makefile              |   4 +
 tools/build/feature/test-cxa-demangle.cpp |  17 ++
 tools/perf/Makefile.config                |  84 +++-----
 tools/perf/Makefile.perf                  |  21 +-
 tools/perf/builtin-lock.c                 |   2 +-
 tools/perf/builtin-record.c               |   2 +-
 tools/perf/builtin-version.c              |   2 +-
 tools/perf/check-headers.sh               | 229 ++++++++++++----------
 tools/perf/tests/make                     |  17 +-
 tools/perf/tests/shell/record_offcpu.sh   |   2 +-
 tools/perf/util/Build                     |   1 +
 tools/perf/util/cloexec.c                 |  13 --
 tools/perf/util/demangle-cxx.cpp          |  50 +++++
 tools/perf/util/demangle-cxx.h            |  16 ++
 tools/perf/util/symbol-elf.c              |  37 +---
 tools/perf/util/util.c                    |  16 ++
 17 files changed, 294 insertions(+), 220 deletions(-)
 create mode 100644 tools/build/feature/test-cxa-demangle.cpp
 create mode 100644 tools/perf/util/demangle-cxx.cpp
 create mode 100644 tools/perf/util/demangle-cxx.h

-- 
2.40.0.rc1.284.g88254d51c5-goog

