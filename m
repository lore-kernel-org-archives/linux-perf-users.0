Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5910C54EBE
	for <linux-perf-users@archiver.kernel.org>; Mon, 16 Jan 2023 14:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbjAPOFZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 16 Jan 2023 09:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjAPOEk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 16 Jan 2023 09:04:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77F12200F;
        Mon, 16 Jan 2023 06:03:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 599CF60FD8;
        Mon, 16 Jan 2023 14:03:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922F1C4339B;
        Mon, 16 Jan 2023 14:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673877787;
        bh=yCh1gxprDPV2j4TdHefwpjqIEflJF3XS4z66DJlh69g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZgCz45bkE2UF09idMamE1rIQRTWWQ/Wg5ZOILV68LEegE713wtpgGjOMHREJqZaYj
         LCTRNTKCkYkSsq9FV2uBoxD4mN5fDGJCIdVOVUzLJ3Krq+kCqCF3nko6Lr4Btx5+if
         znkAe/55uLkhBA1cE7W/hmdAu/7LVlZj9AdMhxFI7mR11ZemTDgSC4rvI0uoNSXnRS
         KRwU7yFuEXI+XN+Jdeatg6StQLpylPf4UPtIhiDY0BeJfk3Sl4qbEXagC8eCDVVGlV
         TQp73PUY1uNCOetXlWn4UbzO0VAHzzIWe+qAB48cllwi2OPietioiJRSsxa+GAiopc
         WNerJTkOOcbPg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sashal@kernel.org>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, tglx@linutronix.de,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 25/53] perf/x86/intel/uncore: Add Emerald Rapids
Date:   Mon, 16 Jan 2023 09:01:25 -0500
Message-Id: <20230116140154.114951-25-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230116140154.114951-1-sashal@kernel.org>
References: <20230116140154.114951-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

[ Upstream commit 5268a2842066c227e6ccd94bac562f1e1000244f ]

From the perspective of the uncore PMU, the new Emerald Rapids is the
same as the Sapphire Rapids. The only difference is the event list,
which will be supported in the perf tool later.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230106160449.3566477-4-kan.liang@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/intel/uncore.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 6f1ccc57a692..459b1aafd4d4 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1833,6 +1833,7 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,	&adl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	&adl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&spr_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X,	&spr_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&snr_uncore_init),
 	{},
 };
-- 
2.35.1

