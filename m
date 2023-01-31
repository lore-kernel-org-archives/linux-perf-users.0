Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FBBC636D3
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Jan 2023 15:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbjAaPAN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 31 Jan 2023 10:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbjAaPAC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 31 Jan 2023 10:00:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5E9C14F;
        Tue, 31 Jan 2023 07:00:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 899076155A;
        Tue, 31 Jan 2023 15:00:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC91FC433A4;
        Tue, 31 Jan 2023 14:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675177201;
        bh=1h13jcDyvSbj8PuzdDyhAJ3wuQIM2m7FoEzhZ3jbnA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j5oPAejO0IspF0f0uh9rapvT2oebnyGtsyRbJkK9nKetvUL1qeB7U7Fj63MwW7u73
         Mwn+xAYxDOzRnyfmw5lF2yTNgrTwtcQCiVd0uQpl+SCTKMi8UxvbEk+piAxfFA7e5N
         q22p17Zj7FFIlY0vbgh7AeZuXKui78EQAVmROmNeF8EXQhFh+VA3hbFkQ5G8bzT6g7
         gNTGLRfzKL5cJzbaQY8Z3jI+f8BhOm6oOnjUguwLbmQ8f1s5vSD0qrtKa7ExiVakij
         /RxTzKozCTlZQf7fvBk+ukJeCS4qIsa3lO2NhFg3fnkad/xzpAsBVZpXXSp21/IXgZ
         ToXZ03bAYNqrQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sashal@kernel.org>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, tglx@linutronix.de,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 05/20] perf/x86/intel: Add Emerald Rapids
Date:   Tue, 31 Jan 2023 09:59:31 -0500
Message-Id: <20230131145946.1249850-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230131145946.1249850-1-sashal@kernel.org>
References: <20230131145946.1249850-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

[ Upstream commit 6795e558e9cc6123c24e2100a2ebe88e58a792bc ]

From core PMU's perspective, Emerald Rapids is the same as the Sapphire
Rapids. The only difference is the event list, which will be
supported in the perf tool later.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230106160449.3566477-1-kan.liang@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/intel/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 1b92bf05fd65..5a1d0ea402e4 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6342,6 +6342,7 @@ __init int intel_pmu_init(void)
 		break;
 
 	case INTEL_FAM6_SAPPHIRERAPIDS_X:
+	case INTEL_FAM6_EMERALDRAPIDS_X:
 		pmem = true;
 		x86_pmu.late_ack = true;
 		memcpy(hw_cache_event_ids, spr_hw_cache_event_ids, sizeof(hw_cache_event_ids));
-- 
2.39.0

