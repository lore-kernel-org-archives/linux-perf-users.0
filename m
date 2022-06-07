Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FE4C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue,  7 Jun 2022 00:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbiFGAJK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 6 Jun 2022 20:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbiFGAJJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 6 Jun 2022 20:09:09 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA53C8CB04
        for <linux-perf-users@vger.kernel.org>; Mon,  6 Jun 2022 17:09:07 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id a127-20020a621a85000000b0051bc393dcb4so7113735pfa.6
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Jun 2022 17:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=5njyuqsJfb5ANEto3T4lhSV8l6ei77v301vQGlsYZZs=;
        b=Xarlvgo+aGPSnUVW4AOncnP8EbZ3BDRcAMJ/n5Vh/I2VAK/jbjiHP70PuNcB5+ROEq
         L5E1vlBRIZKAd/n389NC8wA25BLPCjYTKd8SQ9AmXkzshhNsaYdYIQeb2YoVwbviJijj
         DHtroToE9o7QMHbETr6NQ/PqJBn/pA3glQhTKRmS5cHTWQ/epMRkS42JuM/iOd0kEu5E
         nVfq/0CEs+H9LqMuL9j203jGJlksrY6JXLcL1dkDXkI9Jg9GUQFJGLwTh491SGdDr0mA
         7aLezO8L8vN2MTOXmmYx9ATd3CwK1Nwct7CwcLAaMmxPQ/uSHhVRj7SEm01O3BRzbbSe
         fEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=5njyuqsJfb5ANEto3T4lhSV8l6ei77v301vQGlsYZZs=;
        b=PeBpt5zYn/fmSyolbOU1cx7mNLHVkYQnho4/NT3nFpsk+hN5aoqO8zPUniXOcFjOyz
         V2KNbZF3H00EtR/M+p5pjgSmivrNLOi6dxAOFVOAcaHV/CaQiNU355ibWGyoNUWSTP03
         +dEvDCMMam69OsHsnLqEMnIWpBtNx9LEXIDAZ/ILPKpIaNf4S5cTZ3DwWfD+KaUfBz0V
         vOmkIWjUBsOg/wT40bQ3zE+1PPJgahJS7m1/DI15+QXQiQAfu3xWdh+Ej8stuB46/DXc
         +17ikfpp/LXmv9E7roblP4pw6ur8NvTXQ11euT6cBoNu7gfKBSHSI8scm3v2VNT/dKJw
         sWdg==
X-Gm-Message-State: AOAM531V1UZLDmA83Q6vJQqdAsotzc/UOMFMc2MXHMP/p2cN+/ocReG2
        0hAEhsFC/l5g9HRFVlrKR3tmwt+rttBL
X-Google-Smtp-Source: ABdhPJysN3Jfvc2kr6L+a1zuctuQEbH8RmFdNFd8u4ZR9Tc4WGWrW/1ALQMRqSCJyjJYXehXqmpBCH6RijA0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:e763:4219:a098:af4b])
 (user=irogers job=sendgmr) by 2002:a05:6a00:cd2:b0:51c:28b5:1573 with SMTP id
 b18-20020a056a000cd200b0051c28b51573mr5173255pfv.59.1654560547157; Mon, 06
 Jun 2022 17:09:07 -0700 (PDT)
Date:   Mon,  6 Jun 2022 17:08:51 -0700
Message-Id: <20220607000851.39798-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH] perf unwind: Fix uninitialized variable
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Ian Rogers <irogers@google.com>, llvm@lists.linux.dev,
        Fangrui Song <maskray@google.com>,
        Sebastian Ullrich <sebasti@nullri.ch>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

ret may be uninitialized on error goto paths.

Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Fixes: dc2cf4ca866f ("perf unwind: Fix segbase for ld.lld linked objects")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/unwind-libunwind-local.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index 37622699c91a..6e5b8cce47bf 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -174,7 +174,7 @@ static int elf_section_address_and_offset(int fd, const char *name, u64 *address
 	Elf *elf;
 	GElf_Ehdr ehdr;
 	GElf_Shdr shdr;
-	int ret;
+	int ret = -1;
 
 	elf = elf_begin(fd, PERF_ELF_C_READ_MMAP, NULL);
 	if (elf == NULL)
-- 
2.36.1.255.ge46751e96f-goog

