Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79D9C432BE
	for <linux-perf-users@archiver.kernel.org>; Wed,  4 Aug 2021 11:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1A8E60FC4
	for <linux-perf-users@archiver.kernel.org>; Wed,  4 Aug 2021 11:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhHDL5Y (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 4 Aug 2021 07:57:24 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:45518
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232506AbhHDL5Y (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 4 Aug 2021 07:57:24 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id D19383F078;
        Wed,  4 Aug 2021 11:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628078230;
        bh=6zTpNWm0X0/EiBi74NN2WrAnkeoKrMW8youVb6RkoeA=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=uPuXSQkDvCCbCLGK52eDMjJeL2dcKGoYKnwvr1z7BAsIPELdmbTGU7zIpjfj/qDj4
         HkcfiIaVBMtY9vUOsnaK8Z4eA/y6pq4HlXhxnqn8LKoNdCe+fRANYPWJ2Z71qHHw0M
         Zf2FIsgblgJmbABWZlMq+laX0ftFZvpwxFyZZfkvem4cn/jAbknTo1DTtD4f8hWwfg
         0DbR56/mnWDoSndQPHbC0cdPbWnbmtK9/lJ1PeNY3xoQ8v4LjdNW1yiCWkpLCp1qvk
         k/PIowFAJD0FnXjk16ZpSvMQdg0AZEBfmJ8lNF0vwH5eAJdf8+Up/67WmBRzSH6R6G
         NetUTQMghXSSA==
From:   Colin King <colin.king@canonical.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf/x86: remove unused assignment to pointer e
Date:   Wed,  4 Aug 2021 12:57:10 +0100
Message-Id: <20210804115710.109608-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The pointer e is being assigned a value that is never read, the assignment
is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/x86/events/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 1eb45139fcc6..4110fe1b783e 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1087,10 +1087,8 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 	 * validate an event group (assign == NULL)
 	 */
 	if (!unsched && assign) {
-		for (i = 0; i < n; i++) {
-			e = cpuc->event_list[i];
+		for (i = 0; i < n; i++)
 			static_call_cond(x86_pmu_commit_scheduling)(cpuc, i, assign[i]);
-		}
 	} else {
 		for (i = n0; i < n; i++) {
 			e = cpuc->event_list[i];
-- 
2.31.1

