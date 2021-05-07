Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344F7C433ED
	for <linux-perf-users@archiver.kernel.org>; Fri,  7 May 2021 20:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB7376145A
	for <linux-perf-users@archiver.kernel.org>; Fri,  7 May 2021 20:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhEGU4h (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 7 May 2021 16:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhEGU4g (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 7 May 2021 16:56:36 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E90C061574
        for <linux-perf-users@vger.kernel.org>; Fri,  7 May 2021 13:55:36 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id x7-20020a17090a5307b02901589d39576eso3530174pjh.0
        for <linux-perf-users@vger.kernel.org>; Fri, 07 May 2021 13:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RPwYxQ/G3rhOoLfwIgiJmY5QnE9mrhjUeAyG7fqUPTY=;
        b=LNxZxepW+UC0Y1XBj2dy4y1rp1H6OzGzwlDR5/k47T6tyxD79Y/i4yJwV5N0lZ+VFZ
         a8Xu/wG2Tm7gtc0rRRA8uUCmZHCDoCL9NS9Sm2WL7Qh6S0U++r1/xl0A2IeMQkpThR5W
         LaAH+0LietCJ7G1AT7P3w0Joc/JNVwQhcV8P8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RPwYxQ/G3rhOoLfwIgiJmY5QnE9mrhjUeAyG7fqUPTY=;
        b=CeoeoHlgcc+F0VVfqjtLLo/cDUnUMzhPtxFDx7gWdDt5DdfbJyh/0Y+B/6k+/OvP7x
         1FnPhqDL6Zb+KogCd+LhjEDHLh5WF1wjJyP2wh7NEzv7QPd+r2Ra+rfl7njqWIx20bXf
         sEJ1Rf5hkR6NKJh+U/aZTT07tHvIJQk2d8H5ekYfAlBsFc5DaUSJIThfWkOyQqXZnLOk
         2tNt6xlUbhQSBhG+h+Y8bbrKIQWf8omy48DvfpHVNt0AemsRC3TZrLIH5vLtqb/TO9OL
         apEuf7Jn/q0tKQ8rBNkoksslY5HtZu/w1aAOB7eEhzDxyT1wOvNL6QtveCxncBm3lI8Y
         70DA==
X-Gm-Message-State: AOAM5302FCkvuBXRXnGfvjlHcasNLE1D+RGaBjUn0OkgXaKbZAvAV/9T
        7co2YniiXQLMMjNTK9eZv6U14w==
X-Google-Smtp-Source: ABdhPJzk5q+RqqaeU/dImKZTUfx8BnrHWZjv79jeHRGyFTZRMB87eu1vtuUpAfgd2ErT3+E0DOME3g==
X-Received: by 2002:a17:90a:c087:: with SMTP id o7mr12769919pjs.65.1620420935943;
        Fri, 07 May 2021 13:55:35 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:3c7e:d35:3a19:632f])
        by smtp.gmail.com with ESMTPSA id ge4sm13161565pjb.49.2021.05.07.13.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 13:55:35 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Seth LaForge <sethml@google.com>,
        Ricky Liang <jcliang@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 0/3] arm64: perf: Make compat tracing better
Date:   Fri,  7 May 2021 13:55:10 -0700
Message-Id: <20210507205513.640780-1-dianders@chromium.org>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The goal for this series is to improve "perf" behavior when 32-bit
userspace code is involved. This turns out to be fairly important for
Chrome OS which still runs 32-bit userspace for the time being (long
story there).

I won't repeat everything said in the individual patches since since
they are wordy enough as it is.

Please enjoy and I hope this isn't too ugly/hacky for inclusion in
mainline.

Thanks to Nick Desaulniers for his early review of these patches and
to Ricky for the super early prototype that some of this is based on.


Douglas Anderson (3):
  arm64: perf: perf_callchain_user() compat support for
    clang/non-APCS-gcc-arm
  arm64: perf: Improve compat perf_callchain_user() for clang leaf
    functions
  arm64: perf: Add a config option saying 32-bit thumb code uses R11 for
    FP

 arch/arm64/Kconfig                 |  12 ++
 arch/arm64/kernel/perf_callchain.c | 329 +++++++++++++++++++++++++----
 2 files changed, 305 insertions(+), 36 deletions(-)

-- 
2.31.1.607.g51e8a6a459-goog

