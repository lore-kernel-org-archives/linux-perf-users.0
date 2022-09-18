Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AF4C32771
	for <linux-perf-users@archiver.kernel.org>; Sun, 18 Sep 2022 03:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiIRDPk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 17 Sep 2022 23:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiIRDPd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 17 Sep 2022 23:15:33 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BEA2314F
        for <linux-perf-users@vger.kernel.org>; Sat, 17 Sep 2022 20:15:30 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id q9-20020a17090a178900b0020265d92ae3so3552263pja.5
        for <linux-perf-users@vger.kernel.org>; Sat, 17 Sep 2022 20:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=O9R+a6tAKsKk3N09bqIfrqrBjzSc1SVHcDt6BGSwBbI=;
        b=yMUkeddPLijVmgHg0vaH4Z2lzAsOv5lqJWsNwvrz4pdGCuNIU3ITXeOaE2O8PQRH+j
         NiqCR0KDbQ7aQkicZQW5A9JagoeiONKqHNfib2jccR9vGdCik5VSjdF/oWjBXizJkMdF
         GMT9qujyqEaCbLFlcgSxFfbT7GYSYtPY1GQSnXfA7vndK+mzljALtJqtTyZodo9oUf49
         Z3Ej8TwHBfXQpnL7ExUxbpReRl/DHwzCNvL2+MiqZ+O9faoM0Y6/9OT1rc6FT33AojqS
         DfFHBsor3ETKQrkcMhvEFuZIGydl6mQx3TzNUyVXjrUWZtcYPRo8yAnb0m3CH/w0m5Rs
         0DBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=O9R+a6tAKsKk3N09bqIfrqrBjzSc1SVHcDt6BGSwBbI=;
        b=dMtuypthDXrjt+nNBBux9NmXG0abX85ZH3Y6MT+UL3/I9trbsqOElGVg3WRe/0G8KC
         6OxA7kld1HYZYAmexxdf5dAjWvl6mdJ5gH6ELMTMaoj2CbSLGORYiW74m5gfoO8QBOdS
         B+/m4p6mJPKz8bzqwUYqQli2o2yeP6su1t1CfL0Ds+l8Tr+2jxMbqcZjE+UtExuBJyO0
         QL92oPWI9EcrSKCqC+UIGNeQ2XcmL1w3KmVvGG+Tzaxp6TXg0iv/Z3bBc3PcP25EHql9
         qMqZ/Ry9mwlMHLjElV8tdGdnXi/2EtNmulcdzP8cimmVTbwRse8Fv1B96HczsQ8rmr6m
         lSjg==
X-Gm-Message-State: ACrzQf04Odi1wUobZNU4byy/wg2ycG5sV/NCL61P9WNvj8I3bD5JtRk3
        2acZE3Z0ILD1tzwT2mR7IuG9eQ==
X-Google-Smtp-Source: AMsMyM7CZdMKQ7bgSSm5w4wMnhxPvff7yX9FEUgaZXnRC82lIKPWLzdibfpUAbFu/EQsXg0+2Go04Q==
X-Received: by 2002:a17:902:7c0b:b0:174:abfc:f5 with SMTP id x11-20020a1709027c0b00b00174abfc00f5mr7007397pll.124.1663470929916;
        Sat, 17 Sep 2022 20:15:29 -0700 (PDT)
Received: from leoy-yangtze.lan (45.78.11.189.16clouds.com. [45.78.11.189])
        by smtp.gmail.com with ESMTPSA id e13-20020a17090301cd00b00177f4ef7970sm17822647plh.11.2022.09.17.20.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 20:15:29 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 0/2] perf test: Add test for java symbol
Date:   Sun, 18 Sep 2022 11:15:22 +0800
Message-Id: <20220918031524.26719-1-leo.yan@linaro.org>
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

The test has been verified on x86_64 machine with mainline kernel, with
the latest commit 62e64c9d2fd1 ("perf test: Add basic core_wide
expression test").

Changes from v1:
- Added Ian's suggested tag;
- Added the search folder for the system lib libperf-jvmti.so;
- Skip the test if fail to find jvmti lib.


Leo Yan (2):
  perf subcmd: Set environment variable "PREFIX"
  perf test: Introduce script for java symbol testing

 tools/lib/subcmd/exec-cmd.c                |  3 +
 tools/perf/tests/shell/test_java_symbol.sh | 69 ++++++++++++++++++++++
 2 files changed, 72 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_java_symbol.sh

-- 
2.34.1

