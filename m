Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57864C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 13 May 2022 04:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376926AbiEMEF2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 13 May 2022 00:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiEMEF1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 13 May 2022 00:05:27 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C3C29B025
        for <linux-perf-users@vger.kernel.org>; Thu, 12 May 2022 21:05:26 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2fb7bf98f1aso62603337b3.5
        for <linux-perf-users@vger.kernel.org>; Thu, 12 May 2022 21:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=AT5fEYFiJn9Jy20X399vb4DWFUsA86uVN0Y/NmGabp4=;
        b=YpXQcS5bTswt/iCpkTv5EYf8NbQ15MTR7Xt3cq+CElJxozPM+HirOd52+6OwCLzSCC
         1I+zfaO/CmNEthc9KIlw/wZKYDkXB2lw3r6WEl3xWKDrGiKzZRK7SK6/E6uvQGEkrLLl
         /do8wk2CTE+rVLj7171SDsRLovVFfsEYo0IQd5ERYYCNSiMChQmH46MTyXCPpNKJZ8Rr
         /s6oYwozGhzXW5y7I5+OxXnHoORGS5cXhv+/1m72T7JJCVhMr/jLO3R8FY+AHQW51KcU
         w6pidlwoFTpnDxXxiR2LAPeNjhHPMBWALKFqJrZ/M3I+OVPG9LYbLCR/RsQ+e98W8qHo
         CRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=AT5fEYFiJn9Jy20X399vb4DWFUsA86uVN0Y/NmGabp4=;
        b=dfYrFP2/nkmCIBItBRYgVJizt9W2ew7MOWecel8Cbra+3UKgeWXpTjac5AeW3sObQa
         CjDCRa2KpwLzFr6GCdKWSSyW0qjQI3IrCQg5vT1XxEj+wK1H2ZiDKPjSP+L0nP9f5GA/
         8xg37FT96d+x1Y/pWmkJsfyhfZFkoFzJ7Xw0KSSu1z4q1jssV4eNeJEopywTyDFazi42
         4SLU0BkaK6hnikfvymQD16BWsD1LonNRlKteK0Ic36wTAiLd5Abyz90MtQs5xukvR2Wj
         efs3LG+8ClCSvF1KlVkZpKu6QlbtkaapfSGdKeKjEGq7OwjEtIDqXtAFGwPqzg4+8BRp
         Ch8g==
X-Gm-Message-State: AOAM533pw2gb6LeXFT3qtGXrrYbT8l3l+hU0czrUUPI1HnAv5OvukkQL
        5Q3GHuld3KeLdY7IO//c/udwey/JSj2z
X-Google-Smtp-Source: ABdhPJyFab55ch05scwSx2EefnFRCnaVxXApk1fXpoFK6eRWmzRWgp6y/KUVI4p7SIp2l4Nb1+yNpJLTFk1H
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:9b61:c91f:ca29:ae54])
 (user=irogers job=sendgmr) by 2002:a05:6902:102a:b0:649:4564:5407 with SMTP
 id x10-20020a056902102a00b0064945645407mr3095918ybt.565.1652414725674; Thu,
 12 May 2022 21:05:25 -0700 (PDT)
Date:   Thu, 12 May 2022 21:05:12 -0700
Message-Id: <20220513040519.1499333-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH 0/7] Make more tests skip rather than fail
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Marco Elver <elver@google.com>,
        John Garry <john.garry@huawei.com>,
        Michael Petlan <mpetlan@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

A long standing niggle has been that tests that cannot pass are marked
as failing rather than skip.  John Garry mentioned a similar concern
in [1]. These changes fix this behavior so that as root, or not, at
least the first 10 tests are passing or skipping.

[1] https://lore.kernel.org/lkml/d32376b5-5538-ff00-6620-e74ad4b4abf2@huawei.com/

Ian Rogers (7):
  perf test: Skip reason for suites with 1 test
  perf test: Use skip in vmlinux kallsyms
  perf test: Use skip in openat syscall
  perf test: Basic mmap use skip
  perf test: Parse events tidy terms_test
  perf test: Parse events tidy evlist_test
  perf test: Parse events break apart tests

 tools/perf/tests/builtin-test.c            |   6 +-
 tools/perf/tests/mmap-basic.c              |  22 +-
 tools/perf/tests/openat-syscall-all-cpus.c |  23 +-
 tools/perf/tests/openat-syscall.c          |  20 +-
 tools/perf/tests/parse-events.c            | 492 +++++++++++----------
 tools/perf/tests/vmlinux-kallsyms.c        |  12 +-
 6 files changed, 329 insertions(+), 246 deletions(-)

-- 
2.36.0.550.gb090851708-goog

