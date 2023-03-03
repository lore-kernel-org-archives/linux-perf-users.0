Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4B8C7EE2F
	for <linux-perf-users@archiver.kernel.org>; Fri,  3 Mar 2023 19:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjCCTbF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 3 Mar 2023 14:31:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjCCTbE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 3 Mar 2023 14:31:04 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DA21554C
        for <linux-perf-users@vger.kernel.org>; Fri,  3 Mar 2023 11:31:03 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id j2so3303040wrh.9
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Mar 2023 11:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677871862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DY/RsrwQtoulloPUsXVpIgU+LbyVaN6H5jV3mQtvsxs=;
        b=O7K+l0NPhigKpNBRroeZ4ddEnMwKC3oCJI6bfdvWLo3jZZ3lsGJe7Jdaa06Njc+std
         nscBPiPb/2Hp14LYlO6dAUufhA9/mNRfmymSZEbpZl/gPej0f4J20likSfuRHb5Mx/qr
         U/+IXQnM9YcR6Z5eTF1XpntyGQOxOJFngLaIeoUbqCsmNKAVdohnVJwsaKUHPo5tjBbh
         SLuvTEq7eb/9fVPQZkmlkptRAX1nlU0JFPneCRsjNKK9BoANnKv6W+mf9oA8dkAw6Be7
         blogmgO3qWVWpcCw3mBtWok+0N86TdbwgfKFBDT6dn2HZNG04qWMSSXBUS9ycp2vpgjL
         7JIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677871862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DY/RsrwQtoulloPUsXVpIgU+LbyVaN6H5jV3mQtvsxs=;
        b=CB5f2TZmlxMBtNRsaVSzdt+/t8gPDBfr1mUIsrruf2gwdtgQCfHNKY54J2LbN+/OE8
         IKaUfonXrOy3uLU0yPGN33ippWSnRZsXiDotI2igHBYf1A4M2Sdgo2zha+P11lC6pVqq
         7ncW4LCpAdp6vRq2/TKYsahdT4J69YXhhBvn+BvDICP+dRfG9GMvegZ/biN0+Qc6lEIW
         r+MdEgVfq6jq6rMiRzD67ulfWiv3/WZXNrov2AQChPhvvuheLHmximlInen+BHTj76EX
         guyTxgqXy4PXYOJf6REueXrLs/GBf7AY8W+u1KYin/HjDBf1V5NzJPTCI5Ej+6mDGSDK
         2v9g==
X-Gm-Message-State: AO0yUKXfO83FfbfyWkA855Vbn507NKn9GC7pvacs+LHZJirrQ6RnFGNl
        UncD0e+QlrN6TLtJygHwwCbqBimM26M=
X-Google-Smtp-Source: AK7set8JGYhXxg8u9NNzE8az9iug0DxsY7ikPcdrHkkSI4aedFwfbGKco2YtERn5DM7vATgP/umEWw==
X-Received: by 2002:adf:f092:0:b0:2c7:83b:9d20 with SMTP id n18-20020adff092000000b002c7083b9d20mr2090184wro.34.1677871862096;
        Fri, 03 Mar 2023 11:31:02 -0800 (PST)
Received: from kos-moceratops.home ([2a01:cb1d:8ddc:f000:36ae:1bf1:281b:95d9])
        by smtp.gmail.com with ESMTPSA id b16-20020a5d4d90000000b002c70851bfcasm2983341wru.28.2023.03.03.11.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 11:31:01 -0800 (PST)
From:   Patrice Duroux <patrice.duroux@gmail.com>
To:     linux-perf-users@vger.kernel.org
Cc:     Patrice Duroux <patrice.duroux@gmail.com>
Subject: [PATCH 1/2] replace 2&>1 by 2>&1
Date:   Fri,  3 Mar 2023 20:30:58 +0100
Message-Id: <20230303193058.21274-1-patrice.duroux@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CAGKjw9KHDnVgRz5bstJYkq4t0-bT5fvkuQZbEB48d-8jo4Q00g@mail.gmail.com>
References: <CAGKjw9KHDnVgRz5bstJYkq4t0-bT5fvkuQZbEB48d-8jo4Q00g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Signed-off-by: Patrice Duroux <patrice.duroux@gmail.com>
---
 tools/perf/tests/shell/record_offcpu.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/record_offcpu.sh b/tools/perf/tests/shell/record_offcpu.sh
index e01973d4e0fb..f062ae9a95e1 100755
--- a/tools/perf/tests/shell/record_offcpu.sh
+++ b/tools/perf/tests/shell/record_offcpu.sh
@@ -65,7 +65,7 @@ test_offcpu_child() {
 
   # perf bench sched messaging creates 400 processes
   if ! perf record --off-cpu -e dummy -o ${perfdata} -- \
-    perf bench sched messaging -g 10 > /dev/null 2&>1
+    perf bench sched messaging -g 10 > /dev/null 2>&1
   then
     echo "Child task off-cpu test [Failed record]"
     err=1
-- 
2.39.2

