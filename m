Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5ADC4332F
	for <linux-perf-users@archiver.kernel.org>; Fri, 18 Nov 2022 02:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbiKRCq2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 17 Nov 2022 21:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbiKRCq0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 17 Nov 2022 21:46:26 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B1E8DA47
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Nov 2022 18:46:25 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 204-20020a2510d5000000b006be7970889cso3363631ybq.21
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Nov 2022 18:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AgUYDEYaejS5dLEipBeiq3H0zkWJQSsfp95m7vR2umM=;
        b=aZps6l3/4Ba8QF7QljbhqdPR9mWG4AYeeRMon9lNjZFTYKwoCa7DKFRrFp5MGXFBV1
         nLLdyy5Jqgwi1iqPvWoOvXRS4XWty7N2uuoKaeW2nkfFmdFRwtBjnen0/LFFNgraexKR
         Zjcy2axt+651IrFDKC2nCRlSkFHSiLP9eVQYHk4kHeAiLQnYTfvxPnLpxhIMmgv4pf6w
         YhdONvGshrlhsr1lBLmplsNsIyf+xMx/gcdtyZPya8DnrdcNKAl6QdPOBQlnFAZfYCCP
         f7QZ9qOgrRvZVB6C58wkLpV7w0+aD3GtDTw4Aq7z8/hfQml4CVg6Pd4L/uHIRWYvo1x0
         eTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AgUYDEYaejS5dLEipBeiq3H0zkWJQSsfp95m7vR2umM=;
        b=s1qp5rEaNzwYuvscgRe2Pa7whpT7KC0Nq4a3ZcqmpWp5nNu8Mg9WjUbTLThoxE3+7R
         Adzs0bFf62s/HCf+WFsYkNox7LI0vsVfg5R054IYkE8gFtAPcT7/hSxGIc0ztIcXLK6j
         MNocZSlJsp03iE2wBPgqicstSt+8cE25AtEfqUdRu7wWqvy3Dgzf4zRQ1go890H5Pb+a
         E5qyXZR9RqaU4Td9QKao25BHsN47NPtnSETXHU/CDp4A2BLNmYvI5w4cJT6omX0U8pF2
         g5QIymNswHe7r376mN22unTJNlcYJY9yx5v9xoTLbu/SE5dKW9FQiKXDPXlJ0LhEXzzi
         q52g==
X-Gm-Message-State: ANoB5pnK/fyAixSvWKkQtNDU/G8KFf+g7dHBDl2VgXy3Fg/2SENUGthv
        qgpT++nDbYPiWhXSiPCnZOTrlGVFskNM
X-Google-Smtp-Source: AA0mqf5IQI8LuAX2DEdLTN0ckGnLEo2SU8PUK9F1qBUkl1JfhOLPnMkXFaZhHLOLGCmKYb37iJShf1a4UtbY
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3f1e:c462:d6b8:fba8])
 (user=irogers job=sendgmr) by 2002:a81:df14:0:b0:37c:24be:ce0f with SMTP id
 c20-20020a81df14000000b0037c24bece0fmr9ywn.124.1668739584353; Thu, 17 Nov
 2022 18:46:24 -0800 (PST)
Date:   Thu, 17 Nov 2022 18:46:04 -0800
Message-Id: <20221118024607.409083-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Subject: [PATCH v2 0/3] perf list libpfm fixes
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

Fix a lack of libpfm support with the refactored perf list code. Add
some improvements to wordwrap and the escape printing for json to aid
this.

v2. Rebased on acme/linux.git tmp.perf/core

Ian Rogers (3):
  perf list: Support newlines in wordwrap
  perf list: Json escape encoding improvements
  perf list: List callback support for libpfm

 tools/perf/builtin-list.c | 120 +++++++++++++++++------------
 tools/perf/util/pfm.c     | 154 +++++++++++++++++---------------------
 tools/perf/util/pfm.h     |   6 +-
 3 files changed, 144 insertions(+), 136 deletions(-)

-- 
2.38.1.584.g0f3c55d4c2-goog

