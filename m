Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7ECC433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 Nov 2021 22:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242815AbhKZWhX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 Nov 2021 17:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243492AbhKZWfX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 Nov 2021 17:35:23 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A60C06175A;
        Fri, 26 Nov 2021 14:31:26 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id l16so21487351wrp.11;
        Fri, 26 Nov 2021 14:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vzycsHuQSReBj1bUpfhIwziDiaIARC7YgVu13ZE149E=;
        b=o4OMEDcGL6/mJDWKAAnXfWf3+FumNwYF/Mz+F8k9Jlbk9rBawRIMRlwE8roTEwiUua
         5PCvCiaU0/Z8mQ1+Bx99n0ETdB7ZOheFh9w6g47+7USuc2DhibxVv+2PeOS3JnKmG+76
         w+Vhj2FOqOwDs9ojaydbVbHac6FL9b/eLajx6Vk0RV5VT0/9klfD+t/6kJR57cqz8pAD
         kulrlUbLJ11DAp6R4Jo8UDJyCmwr4cvaaeSeaj9s+F/D7mqv5qioT9PFRMnm7Kw38nOD
         tHXYCfTJ6AKkaDQ57Os68xYmfW6zP9OYwTuyxp6vB/FzSmaLK/ipY4pMPk1T9sISpBrO
         ru6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vzycsHuQSReBj1bUpfhIwziDiaIARC7YgVu13ZE149E=;
        b=0H5AkdUol2bvxHTvhWYV0X3za6HwoQ6FmGNRlKa/rIZT1y5CtnSRnct2L3b6HaQSfT
         KbR9n4wRsgKljHk+8lfPHsdFHP+bonH+r6iCyfms6LtZYw6lH2cJln6JCHzN5R70z53u
         jf8/QsM79SS2NDu0o1WNITmvlKPqHTvHyLGr6AnRlOdNvjw9y8SUBW4LJhjXZhrHyUWv
         4sZ57eajpApSQ9RByVGjp9ZYg+RZiGZm4RsKzDdnw6bJcJdYrS7/RCX/dikzWCNNxgzZ
         qwatfWGoGy0xLMptR/a4yBxz6zVEhV8U2TSJMdgm6P2fr7zkIxdh1zR8qLWimY8tiOtG
         ow/w==
X-Gm-Message-State: AOAM530/sdPh6cVM0YUZHU+tim65av8ye2yA0spt8DQGnBKaIEuOFaJN
        120n0lRk49wDKw==
X-Google-Smtp-Source: ABdhPJyo/IITKp614mlK65Ll6L5bsQWurHOd2/rQpQSYeyJCW6LbTL0lSFK5lvUF1wwiy51mEm2CRQ==
X-Received: by 2002:adf:8296:: with SMTP id 22mr16446971wrc.581.1637965884784;
        Fri, 26 Nov 2021 14:31:24 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id w4sm7070745wrs.88.2021.11.26.14.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 14:31:24 -0800 (PST)
From:   Colin Ian King <colin.i.king@googlemail.com>
X-Google-Original-From: Colin Ian King <colin.i.king@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: perf_event: Remove redundant initialization of variable ret
Date:   Fri, 26 Nov 2021 22:31:23 +0000
Message-Id: <20211126223123.1125916-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The variable ret is being initialized with a value that is never
read, it is being updated later on. The assignment is redundant and
can be removed. Clean up the incorrectly indented following
declaration of variable code and move to the same line as the
declaration of variable ret.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 arch/riscv/kernel/perf_event.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/perf_event.c b/arch/riscv/kernel/perf_event.c
index c835f0362d94..cf3e2ac9bbb2 100644
--- a/arch/riscv/kernel/perf_event.c
+++ b/arch/riscv/kernel/perf_event.c
@@ -156,8 +156,7 @@ static int riscv_map_cache_decode(u64 config, unsigned int *type,
 static int riscv_map_cache_event(u64 config)
 {
 	unsigned int type, op, result;
-	int err = -ENOENT;
-		int code;
+	int err, code;
 
 	err = riscv_map_cache_decode(config, &type, &op, &result);
 	if (!riscv_pmu->cache_events || err)
-- 
2.33.1

