Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7524AEEAA71
	for <linux-perf-users@archiver.kernel.org>; Thu, 14 Sep 2023 21:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjINVUC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 14 Sep 2023 17:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjINVUB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 14 Sep 2023 17:20:01 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9A526BB
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Sep 2023 14:19:57 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59c0327b75dso7320687b3.2
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Sep 2023 14:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694726397; x=1695331197; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gyCa8y2D4tfagLdEhZkffRRlznGd/QDpuIxcjKD4E/c=;
        b=ULpz5Oo6VSuE8V0wxV+/CzBqWNORlkgya7siYPEDDVTpgoSW2zSIUaCIjVseg27xgh
         bNjZ5GX4ED6wx0gosbObdjzy/fb59mevqy343lBYpSc6yqbfcegDmfbcYKibcJovHLZ1
         tjBQo6YNPuKNTG08+2DfrZbsT+zgeazub8uOYn/xRdUEzghEcp9pOI40GjFPiaktP01Y
         qWGxCnefPBne7FXi6sdBXmswWzNGWNy7Wl8ngZcNXPv6JUMi9UtE0zEDWYlXFWVaUHeb
         oYkMoXW6FiOCPxlyadX1Pq0AK/WAFIME79OF3nLnZYJKktMSVXkaC6whwCw4cSAULCVW
         PHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694726397; x=1695331197;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gyCa8y2D4tfagLdEhZkffRRlznGd/QDpuIxcjKD4E/c=;
        b=BiZCnNjnfIJJL6gMPnclUOIXSTz0Q1HVXos0z79nb6VcANj0tcjwCNibQUWkATKabJ
         Ixp/k4nWMWegXVx4vwMIFHHMFm4GndmjLHD2K09cYKIu/fd0sFPPE2aDmdqVQwo8xkLk
         IaRyuz/D6CHwpKL8gK+DfnQWRd6aWM1iXahUjMbpxNqFIFfNkWv5/rIriVgdtuhyqPs7
         q1dy205jTydD4m/EUIaUtuwUk7fR4YEy8U0ST3D0IwyKykStobdTmWZHTZXVMCFo+C4/
         04s/vJ3k0Blfy0wR3jtmLfClw9WR7xmaVZt5560evq7aC5ISvyuoXrmWl9DQ9IKmVcBO
         qcpQ==
X-Gm-Message-State: AOJu0Yw/qIGkkwAjZjuASUHnC4zEUt0WHA+tl/TaX3M2GFvl61V2C+V3
        O+nKbRO46ja0ebEm9Z2jqYTkXCMGHUkQ
X-Google-Smtp-Source: AGHT+IFICCNKx7p+w3Fwj7ubun2Y+fAPBczDWbh5iaJborCvmiUiAZpQehTzmuFkOiLw/9n5Yvv+V5nsTa3o
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:5357:1d03:3084:aacb])
 (user=irogers job=sendgmr) by 2002:a05:690c:a8a:b0:59b:c6bb:babb with SMTP id
 ci10-20020a05690c0a8a00b0059bc6bbbabbmr148679ywb.6.1694726397030; Thu, 14 Sep
 2023 14:19:57 -0700 (PDT)
Date:   Thu, 14 Sep 2023 14:19:43 -0700
Message-Id: <20230914211948.814999-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Subject: [PATCH v1 0/5] Enable BPF skeletons by default
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nick Terrell <terrelln@fb.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Patrice Duroux <patrice.duroux@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Enable BPF skeletons by default but warn don't fail if they can't be
supported. This was the intended behavior for Linux 6.4 but it caused
an issue captured in this thread:
https://lore.kernel.org/lkml/20230503211801.897735-1-acme@kernel.org/

This issue isn't repeated here as the previous issue related to
generating vmlinux.h, which is no longer performed by default as a
checked-in vmlinux.h is used instead.

Unlike with those changes, the BUILD_BPF_SKEL is kept and setting it
to 0 disables BPF skeletons. Also, rather than fail the build due to a
missed dependency, dependencies are checked and BPF skeletons disabled
if they aren't present.

Some related commits:
b7a2d774c9c5 perf build: Add ability to build with a generated vmlinux.h
a887466562b4 perf bpf skels: Stop using vmlinux.h generated from BTF, use subset of used structs + CO-RE
a2af0f6b8ef7 perf build: Add system include paths to BPF builds
5be6cecda080 perf bpf skels: Make vmlinux.h use bpf.h and perf_event.h in source directory
9a2d5178b9d5 Revert "perf build: Make BUILD_BPF_SKEL default, rename to NO_BPF_SKEL"
a887466562b4 perf bpf skels: Stop using vmlinux.h generated from BTF, use subset of used structs + CO-RE
1d7966547e11 perf build: Add warning for when vmlinux.h generation fails
a980755beb5a perf build: Make BUILD_BPF_SKEL default, rename to NO_BPF_SKEL

Ian Rogers (5):
  perf version: Add status of bpf skeletons
  perf build: Default BUILD_BPF_SKEL, warn/disable for missing deps
  perf test: Update build test for changed BPF skeleton defaults
  perf test: Ensure EXTRA_TESTS is covered in build test
  perf test: Detect off-cpu support from build options

 tools/perf/Makefile.config              | 78 ++++++++++++++++---------
 tools/perf/Makefile.perf                |  8 +--
 tools/perf/builtin-version.c            |  1 +
 tools/perf/tests/make                   |  7 ++-
 tools/perf/tests/shell/record_offcpu.sh |  2 +-
 5 files changed, 59 insertions(+), 37 deletions(-)

-- 
2.42.0.459.ge4e396fd5e-goog

