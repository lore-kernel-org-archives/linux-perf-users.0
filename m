Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D61C4321E
	for <linux-perf-users@archiver.kernel.org>; Mon,  5 Dec 2022 02:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiLECzp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 4 Dec 2022 21:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiLECzl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 4 Dec 2022 21:55:41 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B91610FDD
        for <linux-perf-users@vger.kernel.org>; Sun,  4 Dec 2022 18:55:40 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id k88-20020a17090a4ce100b00219d0b857bcso1473008pjh.1
        for <linux-perf-users@vger.kernel.org>; Sun, 04 Dec 2022 18:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hSNynX4Sq04HRNzeYRW4MxMHV7orcwezehiZD+s4b+0=;
        b=m0obYKkLHQxYAki+nPI03F2xMccBXz6NXxl1Iy+Gx+Yc1TYGtCvZneeJOA1N5uxgAj
         R6H8k/L2ZP+B8EjHdOLnxuQZj2We7s+xCWN1/hYvah9ufORJ8Fbl50en6/xCP0p1D5uo
         IaifvXpAc9jmIiPTAojTzEeb07UFlFCs4oFWPSwDKryd226Xm16rN5ORjISRx0myDpCd
         gnuOlOOIO1Q7G9edm1yNan5X/rqyPPnEoe05RhReOUaUqu+WucNbLWUVUSjnp7nN9YHW
         ACV+fxQ+tUMYFdSjK2aMuD6EiVTm6Aty75HLnm3QBSBqTVk0qY6Aa1gNPreGoZy0cFtJ
         qzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hSNynX4Sq04HRNzeYRW4MxMHV7orcwezehiZD+s4b+0=;
        b=edFa4EMKxjfuoKxIG4PaZUzFIV9IKWZxAy9rqnL+CDEoJRpmWZ3Oh4shVsMNUWLlwi
         Wn9jN7SXDz2B6jInpluazaKG7TaQB7208n8m0ep5cxcvrJped8bhxpJ6qzmKXkU0PyTL
         fJ6gcmO3vg/p9eT/C0PfU6AFMYG6ptB9qQI+f9SEtW/NWmD+xb76sYUyEXThW1tdS70m
         PqaohZP9W1UdRuB4Vo7B/1ypkZtOzTNziTldAa8pV51lYBAf3PV0fTz+SNUg5R5mYZgu
         AiI2oAmRn6Us+e/fA8KT0Yr1BFbmC5MLViu+0abXprxsnpAcJq3EHO0oeAJ2GJqmE+B4
         b2IA==
X-Gm-Message-State: ANoB5plOLbDKHt8UvoeIcoxLugXp3KyG5B3cA6OjdEFSNkX93uw2RXVo
        nDmUoV0zZamo/cD2uGVfPdRnIus3UqQ=
X-Google-Smtp-Source: AA0mqf6wgzLrJTdh2WL14NZAJBkD+9JSJluXqXQ65Gd0sSrowi4XG0/7/wSKcDWa9qPnAbWAEVkOEQ==
X-Received: by 2002:a17:90a:a095:b0:218:e358:12d2 with SMTP id r21-20020a17090aa09500b00218e35812d2mr57503605pjp.208.1670208939239;
        Sun, 04 Dec 2022 18:55:39 -0800 (PST)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9181:1cf0::d00])
        by smtp.gmail.com with ESMTPSA id i9-20020a17090a058900b00210039560c0sm9849777pji.49.2022.12.04.18.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 18:55:38 -0800 (PST)
From:   Khem Raj <raj.khem@gmail.com>
To:     linux-perf-users@vger.kernel.org
Cc:     Khem Raj <raj.khem@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Fangrui Song <maskray@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        John Keeping <john@metanate.com>, Leo Yan <leo.yan@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
Subject: [PATCH] perf python: Account for multiple words in CC
Date:   Sun,  4 Dec 2022 18:55:34 -0800
Message-Id: <20221205025534.150006-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Sometimes build systems may append options e.g. --sysroot etc. to CC
variable especially in cross-compile environments like yocto project
where CC varable is composed of cross-compiler name and some needed
options for it to work in a relocatable environment. Therefore separate
out the compiler name from rest of the options in CC, then add the
options via second argument to Popen() API

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Fangrui Song <maskray@google.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: John Keeping <john@metanate.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 tools/perf/util/setup.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 5b1e6468d5e8..e9be6e36408f 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -7,7 +7,7 @@ cc_is_clang = b"clang version" in Popen([cc.split()[0], "-v"], stderr=PIPE).stde
 src_feature_tests  = getenv('srctree') + '/tools/build/feature'
 
 def clang_has_option(option):
-    cc_output = Popen([cc, option, path.join(src_feature_tests, "test-hello.c") ], stderr=PIPE).stderr.readlines()
+    cc_output = Popen([cc.split()[0], str(cc.split()[1:]) + option, path.join(src_feature_tests, "test-hello.c") ], stderr=PIPE).stderr.readlines()
     return [o for o in cc_output if ((b"unknown argument" in o) or (b"is not supported" in o))] == [ ]
 
 if cc_is_clang:
-- 
2.38.1

