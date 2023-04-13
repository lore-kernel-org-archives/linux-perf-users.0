Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F318C77B61
	for <linux-perf-users@archiver.kernel.org>; Thu, 13 Apr 2023 16:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjDMQRf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 13 Apr 2023 12:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjDMQRe (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 13 Apr 2023 12:17:34 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4321977F
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Apr 2023 09:17:31 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id j16so1489275wms.0
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Apr 2023 09:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1681402650; x=1683994650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=38Yb3K2X39JYdroVCYnZn1iH0zsgOPm1opWg6u9OrnA=;
        b=FYMc15O2+ikuHwDZXewujBymuKjb0wLG3G9POi/bxOvkCAVqfUklYRLX0godmEWGyl
         Mb0djbmpWZ0hLSRiWdLcrBCLV45eQOqDXCa0Nc2vK5NzWC60U92C3lcWGqlYAXV/KtCQ
         rCqtnkk3YhyRaaoUwTApDJTHO7XmmgvmhppYk+Dlp8WGbqjPYJPws+iIgqZTOLr5qqxA
         ICXBCUnEN9BY+gBFYb06nnH6hPPOnmzEqivs0CbguiSY4J1A6j5dGec27xGTfZ2nKqbp
         76aOt1t7EtPrYCm14ndD5tk1sxdtnsLnaaLtQ2NHqC8XWn1I6tX1sRe0BuacrDD9WZRx
         hJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681402650; x=1683994650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=38Yb3K2X39JYdroVCYnZn1iH0zsgOPm1opWg6u9OrnA=;
        b=TX2dChyq+AFVOBlwJrMMOOYeUZzKKz6fK5tDNyspkXNdYzgOUWyf5Dss/ylAp02yQT
         NJFp796WCA9R73Zw8kJm021CbUgfHgZkGEoqoL4uk05CZ16CpKqS3TBs7/Q5z2PSG36v
         KL8My4kEa33P7zkch1858lc48dY/l8LOzf5xSSRD4Ctw7t7NYk/a9i3ajFiL+yNglQr8
         udO+OnQkZCsRcUOSDc1iu6Mhcs+2mCecOzf16I3lTEgROiKziYkYBUXPlp96hkJTjZdJ
         Twp9IyklX964WKYO+sPSPwUU15c+E9rsFC2l7y3lOYMdiuilsTnltTTK1v/5HpVhTOFs
         JiUw==
X-Gm-Message-State: AAQBX9eCfGzUENaA/MBC40rlBuCp2QdBorTSgJVXwQXFrWd9Y0BIhkE6
        bgmuQSy/+0UPWTd6UjciOm1jLw==
X-Google-Smtp-Source: AKy350bmCsEok/fFa5YgX7ncV0/zToqAzAd+sbPw5hmVDKRgBIpNP0624v+FkMa0rAlXJlrVKb571A==
X-Received: by 2002:a1c:6a14:0:b0:3f0:7db5:607a with SMTP id f20-20020a1c6a14000000b003f07db5607amr2179470wmc.33.1681402650384;
        Thu, 13 Apr 2023 09:17:30 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id w16-20020a05600c475000b003f092f0e0a0sm9350624wmo.3.2023.04.13.09.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 09:17:30 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH 0/4] riscv: Allow userspace to directly access perf counters
Date:   Thu, 13 Apr 2023 18:17:21 +0200
Message-Id: <20230413161725.195417-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

riscv used to allow direct access to cycle/time/instret counters,
bypassing the perf framework, this patchset intends to allow the user to
mmap any counter when accessed through perf. But we can't break the
existing behaviour so we introduce a sysctl perf_user_access like arm64
does, which defaults to the legacy mode described above.

The core of this patchset lies in patch 4, the first 3 patches are
simple fixes.

base-commit-tag: v6.3-rc1

Alexandre Ghiti (4):
  perf: Fix wrong comment about default event_idx
  include: riscv: Fix wrong include guard in riscv_pmu.h
  riscv: Make legacy counter enum match the HW numbering
  riscv: Enable perf counters user access only through perf

 Documentation/admin-guide/sysctl/kernel.rst |  23 +++-
 arch/riscv/include/asm/perf_event.h         |   3 +
 arch/riscv/kernel/Makefile                  |   2 +-
 arch/riscv/kernel/perf_event.c              |  65 +++++++++++
 drivers/perf/riscv_pmu.c                    |  42 ++++++++
 drivers/perf/riscv_pmu_legacy.c             |  24 ++++-
 drivers/perf/riscv_pmu_sbi.c                | 113 ++++++++++++++++++--
 include/linux/perf/riscv_pmu.h              |   9 +-
 include/linux/perf_event.h                  |   3 +-
 tools/lib/perf/mmap.c                       |  65 +++++++++++
 10 files changed, 332 insertions(+), 17 deletions(-)
 create mode 100644 arch/riscv/kernel/perf_event.c

-- 
2.37.2

