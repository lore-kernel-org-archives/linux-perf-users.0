Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5B9C4332F
	for <linux-perf-users@archiver.kernel.org>; Wed, 16 Nov 2022 07:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbiKPHNG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 16 Nov 2022 02:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbiKPHNF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 16 Nov 2022 02:13:05 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CBC1F9FF
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Nov 2022 23:13:04 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id c188-20020a25c0c5000000b006d8eba07513so15519049ybf.17
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Nov 2022 23:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WXJjn8PYB9SLY1j1q0EeB8Piy7lrBilE/8YOyXaTxKY=;
        b=R9DPkR8U/JCqLAjy/iASbJFaNlfs13ciAt/+B1Xr6//ErVax+n55QLO+EUZuvA+VfB
         2pVuOsgmRzil/fEpWYMoEcLPRglB0Ehzkq21mYEGqsPs4A4YF+E5RMmBAoLmjWsO1eWj
         but174NBpm33mr/15kApu2yitVhNIprLILB8Msli2IKr+rakI4O7hv654m4STCOQAAJc
         j2jVVZLhQ2z94499I6GSdUIptbgySnp9m6CvRAfNWmRGy1mh7TscKwNCD5HF9mVnwVa7
         94KF1dMAsMJviEXYeH3Ov9KuR2HUPm0jDJuKWxYnX4ALW14ApmAgvLI4MN0HT5hMBeb0
         RvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WXJjn8PYB9SLY1j1q0EeB8Piy7lrBilE/8YOyXaTxKY=;
        b=Qf994/nmHa7mUaeIBF1k3U81B4cfWlSc1QG0QjNxtMpo0GXqPZPZ2nfANVqrxe7acc
         93H5qB0R7vPYVdFqwT6pT2n4EhI/0rWkCaI0nRBaRFPbUBFV6hVHgf2YpXfcZrxKaPFF
         JyHX5xwZzi3rAfxPzSG/daSL1T0ODUH0DUs/CJEPNHWywWkGUyuHOS3zaqHO9xPYS+GV
         H+jvPemL5HURTO3YOU/dYa/LfXmOT9USj8NSQDpzLQBdLCIZjbhGR5JfipIQtDcmeRr9
         aHY9TvCuZRU7NRftJ+QSI2PcShPfRcJ6imyWnjkOiV+RNdTnda06cCTkBYC437Oe1eO/
         bnyg==
X-Gm-Message-State: ANoB5pnqzO2aiByh7Y8zFNq2Z8wiDy0qg/p6kP4rr+1MgWuLT4hHmWjp
        RbUuwnmSntUBUaewwrRSBtFHE0r1BGWE
X-Google-Smtp-Source: AA0mqf5xyH2ENNOTYNJSqYf1bFldRQd/ujUpLe2WBGMxK8gXwmldQunucYc1jZ8DurLzY459eLTt3lmSL+n1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:bf0f:58f3:342e:c1ec])
 (user=irogers job=sendgmr) by 2002:a25:d808:0:b0:6bd:d36:f096 with SMTP id
 p8-20020a25d808000000b006bd0d36f096mr20960547ybg.150.1668582783603; Tue, 15
 Nov 2022 23:13:03 -0800 (PST)
Date:   Tue, 15 Nov 2022 23:12:55 -0800
Message-Id: <20221116071259.2832681-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v1 0/4] perf list libpfm support and other fixes
From:   Ian Rogers <irogers@google.com>
To:     Weilin Wang <weilin.wang@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xin Gao <gaoxin@cdjrlc.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Fix an asan issue and a a lack of libpfm support with the refactored
perf list code. Add some improvements to wordwrap and the escape
printing for json to aid this.

Ian Rogers (4):
  perf list: Fix asan issue
  perf list: Support newlines in wordwrap
  perf list: Json escape encoding improvements
  perf list: List callback support for libpfm

 tools/perf/builtin-list.c | 122 ++++++++++++++++++------------
 tools/perf/util/pfm.c     | 154 +++++++++++++++++---------------------
 tools/perf/util/pfm.h     |   6 +-
 3 files changed, 145 insertions(+), 137 deletions(-)

-- 
2.38.1.431.g37b22c650d-goog

