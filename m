Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A003C432BE
	for <linux-perf-users@archiver.kernel.org>; Mon, 30 Aug 2021 12:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E84A96023F
	for <linux-perf-users@archiver.kernel.org>; Mon, 30 Aug 2021 12:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237137AbhH3MDa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 30 Aug 2021 08:03:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:48524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236889AbhH3MBc (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 30 Aug 2021 08:01:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A69261166;
        Mon, 30 Aug 2021 12:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630324838;
        bh=UKDk4g5ooPmFnegr6ztW+5fWzTPZU6cm1xNYq3hd8uo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pQl/TJRpfE1R9+6UHcKRvzdM5J98PjPNX6cZWBxN/ZuYKqQMxgR6DyfvAqo4M8nDW
         +4gQv9mYDAqp+YVX6SF2OG0UOdCwC7QJ9EVSws12DlyPO2glAvrqIJlEPDf1ipYEuj
         ox17RXy0iqvxldhyPgSdd6MSiVWYWeOdNEy9FycdKJvbNVXpbMs7ODOi1oK8xYo1VD
         6T6sZeeKZgeOr9Vuxh0UJ8qrcGbsp6KL/HYAV7IzEor6MNLMS+dr/VNA7LGLIK9j2F
         4azWYlHn+hkOmC962kBlJc4xaBaVRP2RcC0Rsb3Tlf7bhfWD5kpHQ9HSXmjOobcKgN
         a/qelLEXVX+hw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 5/8] perf/x86/intel/pt: Fix mask of num_address_ranges
Date:   Mon, 30 Aug 2021 08:00:28 -0400
Message-Id: <20210830120031.1017977-5-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210830120031.1017977-1-sashal@kernel.org>
References: <20210830120031.1017977-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Xiaoyao Li <xiaoyao.li@intel.com>

[ Upstream commit c53c6b7409f4cd9e542991b53d597fbe2751d7db ]

Per SDM, bit 2:0 of CPUID(0x14,1).EAX[2:0] reports the number of
configurable address ranges for filtering, not bit 1:0.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Link: https://lkml.kernel.org/r/20210824040622.4081502-1-xiaoyao.li@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/intel/pt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index f03100bc5fd1..849f0ba53a9b 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -69,7 +69,7 @@ static struct pt_cap_desc {
 	PT_CAP(topa_multiple_entries,	0, CPUID_ECX, BIT(1)),
 	PT_CAP(single_range_output,	0, CPUID_ECX, BIT(2)),
 	PT_CAP(payloads_lip,		0, CPUID_ECX, BIT(31)),
-	PT_CAP(num_address_ranges,	1, CPUID_EAX, 0x3),
+	PT_CAP(num_address_ranges,	1, CPUID_EAX, 0x7),
 	PT_CAP(mtc_periods,		1, CPUID_EAX, 0xffff0000),
 	PT_CAP(cycle_thresholds,	1, CPUID_EBX, 0xffff),
 	PT_CAP(psb_periods,		1, CPUID_EBX, 0xffff0000),
-- 
2.30.2

