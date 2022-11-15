Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802F9C433FE
	for <linux-perf-users@archiver.kernel.org>; Tue, 15 Nov 2022 12:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238008AbiKOMOk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 15 Nov 2022 07:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbiKOMOi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 15 Nov 2022 07:14:38 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D34140FE
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Nov 2022 04:14:37 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-37063f855e5so135219147b3.3
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Nov 2022 04:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pJ9B/AyuvfxCmb9k0O9GWQZuR6Is6hTYtAiZyyDXWr4=;
        b=yTeZWAWuz0ZkGXPVuOdjw4baVc7XAMaPWlQo5pjBP0URrWDgUrGhgp9hjLrYaXy+as
         t/o6dzEeNM/l9Lbju7acnc7EChNAZdIPiSKmrf2lGMfJnQN3jc5t+7L5E5HJYPeK5alL
         xmKmIiGRM0ISe0AJBGDAvjhpesZ5S4z97AyKutBh2IIIBjfsZcfItXtVvpRlq0VJjbuM
         SvTor1dTyVvVotzUGLvz2ok13rGrfbtLfyUzyfNMzpv48VYkerQ3dqGDWcdfM0VHA25d
         9zZbrbNrberr+zH+1Y/GqFPzAxhHe/RqSjFzSSredc3J4NDefXvnvENipZ8EsvloXwxV
         pwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pJ9B/AyuvfxCmb9k0O9GWQZuR6Is6hTYtAiZyyDXWr4=;
        b=mF3XewHZl/Tn2Dhi/4o8ugEjZSZFTLV+ElyHoARCwVYwVdqDwFuI5wLPk5GhJ6Fcje
         GZBCN2m1pFMBDNDEqyZcdSxFHbtKI8FrI6aupZmzWM+g1UX34FLiQdvZt9SzsaqAdivw
         zgMqzdFj5c0a3b594mkYBRg5kypW/TPxtgQKOc4gmQc4DM0GCNYlEiclxF2A+VRMfBvq
         RyAZlMe5s3Qcv3GBRpRHEXPpYCskCFyvNLiedrgsGwhmV83uLaNzMab5R9S34QVTuRH8
         RnbV6+wRTuVWEaMQ9X/OWxA1zZAxTbihMPFAadHXcJEvA7NGKwDGh1BrjIZkCEOB/wOS
         LlyA==
X-Gm-Message-State: ANoB5pldHS0aueTTrbXTgHOIJcJ/vQu/NPTz5Lj0cG1oLk3JhzL+nLdZ
        wP2jjoAMAV7ZRNL8F6NvGH//4fU0dcaeR2v7L60MFZOYd0D13w==
X-Google-Smtp-Source: AA0mqf4WgL5FyUuvn0rk8f3Rxa2UBLFMVnXy0SqIuqGpUtWEZoxgn/mDM93AtXin51nPduY+UYAqfKWIF45emxNi3aM=
X-Received: by 2002:a0d:cc12:0:b0:373:6d43:2ee6 with SMTP id
 o18-20020a0dcc12000000b003736d432ee6mr18109812ywd.443.1668514476253; Tue, 15
 Nov 2022 04:14:36 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 15 Nov 2022 17:44:25 +0530
Message-ID: <CA+G9fYvOGH92jByQYcFDGBKMQzFma=k=JLuaOOnHDq2FS1vWjQ@mail.gmail.com>
Subject: perf: gcc-12: tests/builtin-test.c:242:66: error: array subscript 1
 is outside array bounds of 'struct test_suite *[1]' [-Werror=array-bounds] ^
To:     open list <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

You might be aware of the following perf build fails with gcc-12 for
32bit arm and i386.
Whereas gcc-11 builds passed.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
-----------
  CC      /home/tuxbuild/.cache/tuxmake/builds/1/build/util/block-info.o
In function '__cmd_test',
    inlined from 'cmd_test' at tests/builtin-test.c:522:9:
tests/builtin-test.c:242:66: error: array subscript 1 is outside array
bounds of 'struct test_suite *[1]' [-Werror=array-bounds]
  242 |                 for (k = 0, t = tests[j][k]; tests[j][k]; k++,
t = tests[j][k])
      |                                                                  ^
tests/builtin-test.c:351:9: note: in expansion of macro 'for_each_test'
  351 |         for_each_test(j, k, t) {
      |         ^~~~~~~~~~~~~
tests/builtin-test.c: In function 'cmd_test':
tests/builtin-test.c:35:27: note: at offset 4 into object 'arch_tests' of size 4
   35 | struct test_suite *__weak arch_tests[] = {
      |                           ^~~~~~~~~~
cc1: all warnings being treated as errors

  CC      /home/tuxbuild/.cache/tuxmake/builds/1/build/util/expr.o
In function 'parse_events_term__num',
    inlined from 'parse_events_multi_pmu_add' at util/parse-events.c:1594:6:
util/parse-events.c:2638:64: error: array subscript 'YYLTYPE[0]' is
partly outside array bounds of 'char[4]' [-Werror=array-bounds]
 2638 |                 .err_term  = loc_term ? loc_term->first_column : 0,
      |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
util/parse-events.c: In function 'parse_events_multi_pmu_add':
util/parse-events.c:1579:15: note: object 'config' of size 4
 1579 |         char *config;
      |               ^~~~~~
cc1: all warnings being treated as errors

build log link,
https://builds.tuxbuild.com/2HXiqb3LCKg451GckF052odBiPY/

Please refer following links for perf build results comparison between
gcc-11 and gcc-12

https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.0.y/build/v6.0.8-191-gf8896c3ebbcf/testrun/13003574/suite/build/test/gcc-11-lkftconfig-perf/history/

https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.0.y/build/v6.0.8-191-gf8896c3ebbcf/testrun/13003574/suite/build/test/gcc-12-lkftconfig-perf/history/

--
Linaro LKFT
https://lkft.linaro.org
