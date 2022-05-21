Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A114AC433EF
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 May 2022 13:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243499AbiEUNFA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 21 May 2022 09:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbiEUNE7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 21 May 2022 09:04:59 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA559DFCA
        for <linux-perf-users@vger.kernel.org>; Sat, 21 May 2022 06:04:58 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d22so9393328plr.9
        for <linux-perf-users@vger.kernel.org>; Sat, 21 May 2022 06:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s2n5YNqGFylFAAt45N0qR9qOr0oyP2hkHtQVdhGhKKA=;
        b=fwpjh7nVlyX8PDTyufrP1Utl9I+TbU8aqSma60xM47njNCNfifMS0+8zbIKUqSrCem
         SyaXycwDwurccTF3FSXp2VKiHqcm6Cv7D8PLY91fhgJaNwUpWyHgZwzRjKBP/pk1oGgT
         8DXyoZA1ukWgr97uWKkhFHy/FN8p8hiYmSu/YL9BxOkv/EKbI1tZV4aVOXZwv8dJhPcl
         dX5n6GQvdOvM8TNIu5F//6jX98LueEabAoi3TAPFY8imYWv3tDEfVpuuqzP3A7WDrO3F
         a1LXuhUS9hswpTbd0b5ZXpE33RsTgqFrfBptHTFG2kpOW0MTk3vwUo8Exvzc9zf8GlRF
         3NTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s2n5YNqGFylFAAt45N0qR9qOr0oyP2hkHtQVdhGhKKA=;
        b=yIIzuG7n0cNOyMlMXOG00T+JZAtam1cQ8quuWiuR+ktgPWulmZjO0XCEHFLnHQJmvP
         Fb2CWiXvjnX+M7EeIsohXsHT5NuN5jhtM2EtCsX8WMSRXdeynnb294qQAy5g2dpGONQo
         dxigTt+6rEKhPu/dcxHPriK4/T83OPMcpFTTT7xKpHL/APT7tRA85zgge2P+gNfeyueU
         q1wUKdkjvjNQY9IfHE/ODJL6xSsCtEZHx0Wf9pPAdA6FYMlhaokf2ZNZTzrFcqE5plWz
         mZwH+bVXjbaLmaSNTgqqiRuCISHZXp9cO37gaocf50h7SnHrlj6x6WXbYdJwAnd44501
         DKYA==
X-Gm-Message-State: AOAM532sQkibU49r7NdtYu9yHThrNRrguY7xbcOHwalVuuhsgUUjnGVI
        63f+FqfH7H5cEIg+adECX4zzUQ==
X-Google-Smtp-Source: ABdhPJweQgkTKhCYUsUhLdmEwD6BkQNij7Id6myVKcnLU7SMLmdQmwj4QtIsGnHXupjxwenCWzigXA==
X-Received: by 2002:a17:903:40c4:b0:161:a2fa:adfb with SMTP id t4-20020a17090340c400b00161a2faadfbmr14417150pld.16.1653138298124;
        Sat, 21 May 2022 06:04:58 -0700 (PDT)
Received: from leo-build-box.lan (n058152048195.netvigator.com. [58.152.48.195])
        by smtp.gmail.com with ESMTPSA id c2-20020a62f842000000b0050dc7628160sm3724874pfm.58.2022.05.21.06.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 06:04:57 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Tanmay Jagdale <tanmay@marvell.com>,
        "zengshun . wu" <zengshun.wu@outlook.com>,
        Al Grant <al.grant@arm.com>, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v6 0/2] perf script python: Add script for CoreSight disassembly
Date:   Sat, 21 May 2022 21:04:44 +0800
Message-Id: <20220521130446.4163597-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch set is to add CoreSight disassembly script, the python script
can dump assembly, source line and symbols for humans inspecting.

The first patch changes python script engine to expose more information
for DSO and maps, so it's helpful for disassembly with objdump program.

The second patch is to introduce the python script for CoreSight trace
data disassembly for branch samples.  It also can dump source line and
symbol info for instruction samples.

This patch set has been tested on Arm64 Juno board:

  # perf script -s scripts/python/arm-cs-trace-disasm.py
  ...
  main  6728/6728  [0004]         0.000000000  main+0x40                               /root/coresight_test/main.c                15 	for (i = 0; i < 10000; i++) {
  main  6728/6728  [0004]         0.000000000  main+0x20                               /root/coresight_test/main.c                16 		val = lib_loop_test(100);
  main  6728/6728  [0004]         0.000000000  lib_loop_test@plt+0xc                   /root/coresight_test/main
  main  6728/6728  [0004]         0.000000000  lib_loop_test+0xc                       /root/coresight_test/libcstest.c            8 	for (i = 0; i < 5; i++)
  main  6728/6728  [0004]         0.000000000  lib_loop_test+0x30                      
  main  6728/6728  [0004]         0.000000000  lib_loop_test+0x30                      
  main  6728/6728  [0004]         0.000000000  lib_loop_test+0x30                      
  main  6728/6728  [0004]         0.000000000  lib_loop_test+0x30                      
  main  6728/6728  [0004]         0.000000000  lib_loop_test+0x30                      
  main  6728/6728  [0004]         0.000000000  lib_loop_test+0x3c                      /root/coresight_test/libcstest.c           12 }
  ...

  # perf script -s scripts/python/arm-cs-trace-disasm.py -- -d llvm-objdump-11 -k ./vmlinux
  ARM CoreSight Trace Data Assembler Dump
        ffff800008eb3198 <etm4_enable_hw>:
        ffff800008eb3310: c0 38 00 35   cbnz    w0, 0xffff800008eb3a28 <etm4_enable_hw+0x890>
        ffff800008eb3314: 9f 3f 03 d5   dsb     sy
        ffff800008eb3318: df 3f 03 d5   isb
        ffff800008eb331c: f5 5b 42 a9   ldp     x21, x22, [sp, #32]
        ffff800008eb3320: fb 73 45 a9   ldp     x27, x28, [sp, #80]
        ffff800008eb3324: e0 82 40 39   ldrb    w0, [x23, #32]
        ffff800008eb3328: 60 00 00 34   cbz     w0, 0xffff800008eb3334 <etm4_enable_hw+0x19c>
        ffff800008eb332c: e0 03 19 aa   mov     x0, x25
        ffff800008eb3330: 8c fe ff 97   bl      0xffff800008eb2d60 <etm4_cs_lock.isra.0.part.0>
            main  6055/6055  [004]         0.000000000  etm4_enable_hw+0x198                     [kernel.kallsyms]
        ffff800008eb2d60 <etm4_cs_lock.isra.0.part.0>:
        ffff800008eb2d60: 1f 20 03 d5   nop
        ffff800008eb2d64: 1f 20 03 d5   nop
        ffff800008eb2d68: 3f 23 03 d5   hint    #25
        ffff800008eb2d6c: 00 00 40 f9   ldr     x0, [x0]
        ffff800008eb2d70: 9f 3f 03 d5   dsb     sy
        ffff800008eb2d74: 00 c0 3e 91   add     x0, x0, #4016
        ffff800008eb2d78: 1f 00 00 b9   str     wzr, [x0]
        ffff800008eb2d7c: bf 23 03 d5   hint    #29
        ffff800008eb2d80: c0 03 5f d6   ret
            main  6055/6055  [004]         0.000000000  etm4_cs_lock.isra.0.part.0+0x20

  # perf script -s scripts/python/arm-cs-trace-disasm.py -- -d objdump -k ./vmlinux
  ARM CoreSight Trace Data Assembler Dump
        ffff800008eb3310 <etm4_enable_hw+0x178>:
        ffff800008eb3310:       350038c0        cbnz    w0, ffff800008eb3a28 <etm4_enable_hw+0x890>
        ffff800008eb3314:       d5033f9f        dsb     sy
        ffff800008eb3318:       d5033fdf        isb
        ffff800008eb331c:       a9425bf5        ldp     x21, x22, [sp, #32]
        ffff800008eb3320:       a94573fb        ldp     x27, x28, [sp, #80]
        ffff800008eb3324:       394082e0        ldrb    w0, [x23, #32]
        ffff800008eb3328:       34000060        cbz     w0, ffff800008eb3334 <etm4_enable_hw+0x19c>
        ffff800008eb332c:       aa1903e0        mov     x0, x25
        ffff800008eb3330:       97fffe8c        bl      ffff800008eb2d60 <etm4_cs_lock.isra.0.part.0>
            main  6055/6055  [004]         0.000000000  etm4_enable_hw+0x198                     [kernel.kallsyms]
        ffff800008eb2d60 <etm4_cs_lock.isra.0.part.0>:
        ffff800008eb2d60:       d503201f        nop
        ffff800008eb2d64:       d503201f        nop
        ffff800008eb2d68:       d503233f        paciasp
        ffff800008eb2d6c:       f9400000        ldr     x0, [x0]
        ffff800008eb2d70:       d5033f9f        dsb     sy
        ffff800008eb2d74:       913ec000        add     x0, x0, #0xfb0
        ffff800008eb2d78:       b900001f        str     wzr, [x0]
        ffff800008eb2d7c:       d50323bf        autiasp
        ffff800008eb2d80:       d65f03c0        ret
            main  6055/6055  [004]         0.000000000  etm4_cs_lock.isra.0.part.0+0x20


Changes from v5:
* Updated script for using f-string format (Ian);
* Added Adrian's review tag for patch 01;
* Fixed the issue for printing souce code line;
* Fixed several issues for using python3 (dictionary index,
  decode output for 'utf-8').

Changes from v4:
* Enhanced python script engine for DSO and map infos;
* Rewrote the python script, added support for symbol and source line
  dumping.


Leo Yan (2):
  perf scripting python: Expose dso and map information
  perf scripts python: Support Arm CoreSight trace data disassembly

 .../scripts/python/arm-cs-trace-disasm.py     | 272 ++++++++++++++++++
 .../scripting-engines/trace-event-python.c    |  21 +-
 2 files changed, 289 insertions(+), 4 deletions(-)
 create mode 100755 tools/perf/scripts/python/arm-cs-trace-disasm.py

-- 
2.25.1

