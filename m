Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B264C433DB
	for <linux-perf-users@archiver.kernel.org>; Mon, 15 Mar 2021 03:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01C6864DCE
	for <linux-perf-users@archiver.kernel.org>; Mon, 15 Mar 2021 03:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbhCOD4z (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 14 Mar 2021 23:56:55 -0400
Received: from mail.loongson.cn ([114.242.206.163]:46436 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229663AbhCOD4y (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 14 Mar 2021 23:56:54 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxL_Hx2k5g64cZAA--.16480S2;
        Mon, 15 Mar 2021 11:56:33 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add Mailing list and Web-page for PERFORMANCE EVENTS SUBSYSTEM
Date:   Mon, 15 Mar 2021 11:56:32 +0800
Message-Id: <1615780592-21838-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9DxL_Hx2k5g64cZAA--.16480S2
X-Coremail-Antispam: 1UD129KBjvdXoWruFyxuFy7CF4kJFy5uryUJrb_yoWfuFc_Aw
        4xJ348XrW5Jr4DKw1kGFZakr1Yy3y7XFySqanIy3y7Xas8J3ZxJw4fG3Zak3WDWrs5ur4D
        K3Z8GFsavr1UXjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb2AYjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8GwCF04k2
        0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
        AIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
        x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j2LvNUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add entry "L: linux-perf-users@vger.kernel.org" to archive the
related mail on https://lore.kernel.org/linux-perf-users/, add
entry "W: https://perf.wiki.kernel.org/" so that newbies could
get some useful materials.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa84121..e1626db 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14021,8 +14021,10 @@ R:	Mark Rutland <mark.rutland@arm.com>
 R:	Alexander Shishkin <alexander.shishkin@linux.intel.com>
 R:	Jiri Olsa <jolsa@redhat.com>
 R:	Namhyung Kim <namhyung@kernel.org>
+L:	linux-perf-users@vger.kernel.org
 L:	linux-kernel@vger.kernel.org
 S:	Supported
+W:	https://perf.wiki.kernel.org/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
 F:	arch/*/events/*
 F:	arch/*/events/*/*
-- 
2.1.0

