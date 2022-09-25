Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEE5C07E9D
	for <linux-perf-users@archiver.kernel.org>; Sun, 25 Sep 2022 02:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiIYC7J (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 24 Sep 2022 22:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIYC7H (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 24 Sep 2022 22:59:07 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013F543639
        for <linux-perf-users@vger.kernel.org>; Sat, 24 Sep 2022 19:59:07 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so9401337pjq.3
        for <linux-perf-users@vger.kernel.org>; Sat, 24 Sep 2022 19:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Ze7hH0t/gP8ZC1eQRaIjQjlxIkny84c949uR2bepf6Y=;
        b=I+GAiJ3GEm892A4gkHivtoHbaBsitppjp5S+laoBM5oYh92ca+ySFXXUofK1b2967F
         TpZ8Vvdk7T9NHrbSYIGGFzbuPl1/teQMEzSovZtzxb7RcgaJBxX+R2t2fF1KbUkZeVVq
         VfHFvgg18C78jQqH/AgLyS8evjDnvGJ5MQSugM045QVISD99/Cs3Lq2vCwis+cSNpCAo
         I32LQOJBHk35Fo3F27waGuJ6os22Ok2aPIK1CyHuM1ihfnyJ5fXSenjNJx0EQxBbgn7T
         eOOI420Gmc6A/JCXWO7DLZkQRpdYaTCM0Jr4jqetk+R9FbGzJYORpXLIwS6uvzfSFO8e
         Uuyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Ze7hH0t/gP8ZC1eQRaIjQjlxIkny84c949uR2bepf6Y=;
        b=yIRXxqXow77OAFV2oDSAloZWnYEp5Lbb/btjz3z8uZHzxxMgHC4sHCAxtmYFdXodUQ
         e8ik1rwA7bVlHmqytga55syZJDKprZW58dLTJQen/K0Q2VesTBm+3m7i0JX6h9TuD2ol
         0axxrRH1JYrExswiQIAwz6DKptnOh/vFaqcQp4CyFPmaqNLdJeAxrLOCTEsN4Jk4ioD+
         gbvCe5Lf7h/SCA18iep4+3i8aOl2sHeis7mmhBneIQJ3h9gpRkd4hTbRkCR4rF8FVNd1
         mwCyRqq6F5RvZ16d001s2yyELyLn65OGCq8sO85e2SdPgs+8ik6ERD0bYeU5Fewnu3dO
         1F3w==
X-Gm-Message-State: ACrzQf2Ny0lG3V8dGiN8eBXiiJ+X6S1LG9/PEcfGz/fynmuIQFo2Qmk0
        iYdU7PpY/0/J3yH5M7eVfdShtw==
X-Google-Smtp-Source: AMsMyM5xhOW5ZFCm2qYXEI4DQ+m+2aei5Of+RoohyXvH8XpbIetpHYScIK39PtGTqPuDLkeXl5h9Vg==
X-Received: by 2002:a17:90b:1c82:b0:1ee:eb41:b141 with SMTP id oo2-20020a17090b1c8200b001eeeb41b141mr18366231pjb.143.1664074746462;
        Sat, 24 Sep 2022 19:59:06 -0700 (PDT)
Received: from leoy-huanghe.lan ([137.184.34.254])
        by smtp.gmail.com with ESMTPSA id z11-20020a170903018b00b0016bf5557690sm8409198plg.4.2022.09.24.19.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 19:59:05 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 0/2] perf test: Add test for java symbol
Date:   Sun, 25 Sep 2022 10:58:33 +0800
Message-Id: <20220925025835.70364-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch set is to add a test for java symbol.

To allow a shell script to know the installed lib path, we need to
export the environment variable "PREFIX" in the C code.  We use the
first patch for this purpose.  The second patch introduces the java
symbol testing.

The test has been verified on x86_64 machine with perf/core branch with
the latest commit 62e64c9d2fd1 ("perf test: Add basic core_wide
expression test").

Changes from v2:
- Skipped test if jshell is not existed (Namhyung);
- Fixed a typo for s/if/elif/ (Namhyung).

Changes from v1:
- Added Ian's suggested tag;
- Added the search folder for the system lib libperf-jvmti.so;
- Skip the test if fail to find jvmti lib.


Leo Yan (2):
  perf subcmd: Set environment variable "PREFIX"
  perf test: Introduce script for java symbol testing

 tools/lib/subcmd/exec-cmd.c                |  3 +
 tools/perf/tests/shell/test_java_symbol.sh | 75 ++++++++++++++++++++++
 2 files changed, 78 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_java_symbol.sh

-- 
2.34.1

