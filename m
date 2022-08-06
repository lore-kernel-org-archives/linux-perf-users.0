Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74BAC19F29
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 Aug 2022 03:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238746AbiHFDeo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 5 Aug 2022 23:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238634AbiHFDem (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 5 Aug 2022 23:34:42 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071F71A067
        for <linux-perf-users@vger.kernel.org>; Fri,  5 Aug 2022 20:34:42 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id c19-20020a17090ae11300b001f2f94ed5c6so8615097pjz.1
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Aug 2022 20:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D+hrmdEAmwTGkEMDWBMXJiZSEXBkeTQ+/+EoUioJM3U=;
        b=mqAOQmzcb9wJFWUxgqeyhQaX659m3/RPcVAs2RjJr1dLGpkVTlbDV8wCbnbrpFdr3+
         8Z/cVyaItHnEFaMYY9rqMfql61BaeGKWOkkNZMdFQLNrwZgRgH+tcLJAvKDby+r178Yk
         V/tcnOagRrnvGVAFlglNttt4wM1umnqdMJoB7XTHMFPnt1+zGphCOoPlIqj7EUjvjxH/
         YWgoJV4Xjqkw6ZpWLDglL9dl3esyn3XhLpKe66hfR0f1REQavi2Ni/FjzIjmKXmy+HBw
         3UF1hYLVpqW3nv/wbqXfXzsPM5JEvE8FwPOpGr0ou4maYWJBECx6vAAyR0cPRQJiqGMu
         WRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D+hrmdEAmwTGkEMDWBMXJiZSEXBkeTQ+/+EoUioJM3U=;
        b=kyz80vTsN2qcdW31dvMyUncm6/kJ8bXRmZXbzqKugftrUhGbPPWO4HjN8DP1bcAQl9
         z3Dm8C8Mj1WwZkcTUIpYK3+x1p2D37nWZDQDeOSaMO8mLog1uka9LDVPqK4pRverdNjI
         kyjqqiKHXBZQhE5Pli4T/wlp0xV6nXqLdqN2QiwZkEA0jyuOIWMQoLEEOpHMFQCzqiiF
         LhVkIOgwdukcrs5jd9ICjM2ofnD0F+Dyh3F+jqz4l166FaUmHWpZLpKLYN1XETFhpCIt
         haqy+RyzmfMeGgJnuoxiOIRC8UkEUGVyik6gu4F9K+1Z3h8MiXrxUDtdI/1ftm6+xbZL
         dCkg==
X-Gm-Message-State: ACgBeo29uC7NeSFdTTSeA/xgrS4Wap58WprFdaOZDHID8laGsCPbT6TX
        Ngd07FS9lVtcTtHB9ThwDPZ0Zg==
X-Google-Smtp-Source: AA6agR77xQPUr1ibDY28USqNXT0ehsNzUDHGC/TVV0pGo6GzePAbxNw4umUsnFLfxBtw6HUrkB0hrg==
X-Received: by 2002:a17:902:f54b:b0:16e:f07b:46d0 with SMTP id h11-20020a170902f54b00b0016ef07b46d0mr9632990plf.77.1659756881331;
        Fri, 05 Aug 2022 20:34:41 -0700 (PDT)
Received: from localhost (ec2-18-144-7-244.us-west-1.compute.amazonaws.com. [18.144.7.244])
        by smtp.gmail.com with ESMTPSA id a14-20020aa7970e000000b0052e82671a57sm3842614pfg.73.2022.08.05.20.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 20:34:40 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH 0/2] perf test: Add test for java symbol
Date:   Sat,  6 Aug 2022 11:34:32 +0800
Message-Id: <20220806033434.121908-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
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

The test has been verified on my x86_64 machine with mainline kernel.


Leo Yan (2):
  perf subcmd: Set environment variable "PREFIX"
  perf test: Introduce script for java symbol testing

 tools/lib/subcmd/exec-cmd.c                |  3 +
 tools/perf/tests/shell/test_java_symbol.sh | 66 ++++++++++++++++++++++
 2 files changed, 69 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_java_symbol.sh

-- 
2.25.1

