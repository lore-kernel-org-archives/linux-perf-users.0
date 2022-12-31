Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D62C4332F
	for <linux-perf-users@archiver.kernel.org>; Sat, 31 Dec 2022 05:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbiLaF17 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 31 Dec 2022 00:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiLaF16 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 31 Dec 2022 00:27:58 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A63140B6
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Dec 2022 21:27:57 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id 20so10380489plo.3
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Dec 2022 21:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qvXUYwi5ZyU74DKdX9d8zZyO8Ta/Eto0kB/925S6woI=;
        b=eNVSgI8Iffys1qMsVkR5qdhv5aDN9L6WgHnk771KmegnIxIojGrOuyoK/H7l8rlrbe
         z0JsinNRo5iAZWKrEsqQciRzTfvRVJgkoU+6yj+lRCms6MsO96Dk8b1OweA28AWQ2yXt
         amtxjM4FZx0K5IU7pwXWQoEBARvZH9eB/XAwfkIpcfcEzgoSS6zW0PMOEmAm1mvgbnuA
         0Le//8Qj0wF2vhZ7Gn77N5TDY4GFreoykrkMxUn2vQrnSwnOFdYXiGC3Prvz8+NNRTLh
         jYTVbxpg5Y1eiDnab3Q7O1Oe2zt5yiT2BHkJ6RW/N4BPQ9x4SRw4xvSUxCn0X/BL44m+
         8FUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qvXUYwi5ZyU74DKdX9d8zZyO8Ta/Eto0kB/925S6woI=;
        b=sTgDQoX0wvPY5IJozZccBoufJjsYxX/qOZaiwqrhUE8bSvR2p+Wb3FyyxgxkuBTh/Q
         EZKUR30bN/uKriRq4E7K+cStXqJe//kbLFbogXMJsISLINcDSlYOQkY9qpvn95Tv4YPz
         41D3v3NglVeps5UIzu3gZlaxZruYlcvYZ0F4D6AJxZ4h/vZ2/BlLpu/lSEjQtIZgrxIn
         ZQncr/za08dXxG0HRPW9x3K8xt3YKFa1GEFfllyhLRlOwPEx9TAJjU98Tm3N+6QA1fYk
         as0oknfvfs8P7Ebn2VqJ6BmKR8VJX8wBc2LCYhiL/XCYvL63sJgEEDBbnCcZLx4TbCY7
         yJ0g==
X-Gm-Message-State: AFqh2kpJEXGLAlf6rVTZZbdeVT1Qa4yOKXwYJA6PWHvyyJywGne3uptm
        niaBcSkGfxj39iww5ceDWSMgNC/o1yY5iFWGiy0=
X-Google-Smtp-Source: AMrXdXsGSF4DED03XvcK7I2wPfr7RidesmY8h4auVFQgGrgKL5ewV9ZB6jZlmLnBYUDjvl/EKf/KIw==
X-Received: by 2002:a17:903:40cb:b0:192:8502:77f9 with SMTP id t11-20020a17090340cb00b00192850277f9mr18853159pld.27.1672464477035;
        Fri, 30 Dec 2022 21:27:57 -0800 (PST)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id c16-20020a170903235000b0016d773aae60sm15836612plh.19.2022.12.30.21.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 21:27:56 -0800 (PST)
From:   Eric Lin <eric.lin@sifive.com>
To:     peterz@infradead.org, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, palmer@dabbelt.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     paul.walmsley@sifive.com, greentime.hu@sifive.com,
        vincent.chen@sifive.com, Eric Lin <eric.lin@sifive.com>
Subject: [PATCH] perf tools riscv: Fix perf tool build error on riscv
Date:   Sat, 31 Dec 2022 05:27:31 +0000
Message-Id: <20221231052731.24908-1-eric.lin@sifive.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Since the definition of 'struct perf_sample' has been moved to sample.h,
we need to include this header file to fix the build error as follows:

arch/riscv/util/unwind-libdw.c: In function 'libdw__arch_set_initial_registers':
arch/riscv/util/unwind-libdw.c:12:50: error: invalid use of undefined type 'struct perf_sample'
   12 |         struct regs_dump *user_regs = &ui->sample->user_regs;
      |                                                  ^~

Fixes: 9823147da6c8 ("perf tools: Move 'struct perf_sample' to a separate header file to disentangle headers")
Signed-off-by: Eric Lin <eric.lin@sifive.com>
---
 tools/perf/arch/riscv/util/unwind-libdw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/riscv/util/unwind-libdw.c b/tools/perf/arch/riscv/util/unwind-libdw.c
index 19536e172850..54a198714eb8 100644
--- a/tools/perf/arch/riscv/util/unwind-libdw.c
+++ b/tools/perf/arch/riscv/util/unwind-libdw.c
@@ -4,7 +4,7 @@
 #include <elfutils/libdwfl.h>
 #include "../../util/unwind-libdw.h"
 #include "../../util/perf_regs.h"
-#include "../../util/event.h"
+#include "../../util/sample.h"
 
 bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
 {
-- 
2.17.1

