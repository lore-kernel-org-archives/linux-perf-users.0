Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF402C43217
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Apr 2022 17:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238338AbiDFREY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 6 Apr 2022 13:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239074AbiDFRDI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 6 Apr 2022 13:03:08 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB45165B9A
        for <linux-perf-users@vger.kernel.org>; Wed,  6 Apr 2022 07:26:42 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id y6so2106754plg.2
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Apr 2022 07:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wfj1GIB+si6iET8SbCUdgiY5TZkavgwCt42bdaZqDa8=;
        b=Vvm9hL/jx899S3DqVkPLQ4gKE9BtEMVtFydVbiu7k76eQunfKC3BHg1hFdx4qg1i+e
         DjUhoSjNNE92WqiwQUNMiQEratkmQr+MsduISz4ZLfGVnZkCVbaWoD+zlLsaY7dNrilj
         aUwctTARoNBM21LjlWHKUpoD5td8acnO3XNg36vQbjhMP7wYlQDhqUuKIs5tmXd9HDHu
         k2/TGe7SPoBLkU+ISiVwk0QbnxlDY6o72IjLqzih2XLGLp/uKF3nWrBo4sOv/zEdAI0S
         RoiHTeF+wHxvshyAo9XN4B3gbG6GWGQBMfPZQhrRGOKeqFTOO1GXbTMb+9N/FHmUrdSr
         tX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wfj1GIB+si6iET8SbCUdgiY5TZkavgwCt42bdaZqDa8=;
        b=c+wm1d1wOQbeyyvEUTJ7t7OYvpM9fjLI37B+BYJj6CD0FJt6bXbC/n4wroPlzsws8F
         IO0ydZlyULbBX1PL9jPnLZJGA72682Y29RVYMCjAhqmhLlSrpCgu8HhI0miZBLjDCWu6
         F8bOfgomhvMCL/Wy7zGSX20A47BNHcWIw4nRg0AMn+xyVQVgT1gZkq/vetMBXXvWaQOJ
         aovsubSok+mUcsAOHhFqeoHWXD4R9fhoRmYw2+u+q+1/br5e++zzoBA+wNtLPXeIosFY
         SYEKNSB4W+KetOc4K4eeiax+hEXEUY5nnwpqNb87nOW1To0qB6BxW+aGPxfGLbZIFtAZ
         m7yQ==
X-Gm-Message-State: AOAM5307CUZhkK7iXoqFQIISAN1sL2saG0fsZ0Na5xy/1zP8ezRnLRk7
        avYv1vHJf2LNaDlbD1QxdqO4gA==
X-Google-Smtp-Source: ABdhPJw/oS8u3VzD9ycSvMGnTyIHEMUViuTNCy58B7lrkCZJ5lDsvskJD9wu0X6ITQ01e5SSTXqfBQ==
X-Received: by 2002:a17:902:b694:b0:153:1d9a:11a5 with SMTP id c20-20020a170902b69400b001531d9a11a5mr8919433pls.151.1649255202175;
        Wed, 06 Apr 2022 07:26:42 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id k137-20020a633d8f000000b0039800918b00sm16424151pga.77.2022.04.06.07.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 07:26:40 -0700 (PDT)
From:   Eric Lin <eric.lin@sifive.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, iii@linux.ibm.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     paul.walmsley@sifive.com, greentime.hu@sifive.com,
        Eric Lin <eric.lin@sifive.com>
Subject: [PATCH 0/1] perf jitdump: Add riscv64 support
Date:   Wed,  6 Apr 2022 22:26:05 +0800
Message-Id: <20220406142606.18464-1-eric.lin@sifive.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch enable perf jitdump for riscv64 and it tested with v8 on qemu rv64.

Qemu rv64:
# perf record -e cpu-clock -c 1000 -g -k mono ./d8_rv64 --perf-prof --no-wr
ite-protect-code-memory test.js
# perf inject -j -i perf.data -o perf.data.jitted
# perf report -i perf.data.jitted

Output:
# To display the perf.data header info, please use --header/--header-only option
s.
#
#
# Total Lost Samples: 0
#
# Samples: 87K of event 'cpu-clock'
# Event count (approx.): 87974000
#
# Children      Self  Command          Shared Object                Symbol

....
     0.28%     0.06%  d8_rv64          d8_rv64                      [.] _ZN2v88i
nternal6WasmJs7InstallEPNS0_7IsolateEb
     0.28%     0.00%  d8_rv64          d8_rv64                      [.] _ZN2v88i
nternal10ParserBaseINS0_6ParserEE22ParseLogicalExpressionEv
     0.28%     0.03%  d8_rv64          jitted-112-76.so             [.] Builtin:
InterpreterEntryTrampoline
     0.12%     0.00%  d8_rv64          d8_rv64                      [.] _ZN2v88i
nternal19ContextDeserializer11DeserializeEPNS0_7IsolateENS0_6HandleINS0_13JSGlob
alProxyEEENS_33DeserializeInternalFieldsCallbackE
     0.12%     0.01%  d8_rv64          jitted-112-651.so            [.] Builtin:
CEntry_Return1_DontSaveFPRegs_ArgvOnStack_NoBuiltinExit
....

Eric Lin (1):
  perf jitdump: Add riscv64 support.

 tools/perf/arch/riscv/Makefile | 1 +
 tools/perf/util/genelf.h       | 3 +++
 2 files changed, 4 insertions(+)

-- 
2.35.1

