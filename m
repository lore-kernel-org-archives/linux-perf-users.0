Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0CAC432BE
	for <linux-perf-users@archiver.kernel.org>; Tue, 10 Aug 2021 13:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF2F860F41
	for <linux-perf-users@archiver.kernel.org>; Tue, 10 Aug 2021 13:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbhHJNbc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 10 Aug 2021 09:31:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:46700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232542AbhHJNba (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 10 Aug 2021 09:31:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2DA4B601FA;
        Tue, 10 Aug 2021 13:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628602268;
        bh=9g4KB3k94i74QQB7YFvE+KdRAouTAqYyabRWaS73qHo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sNbpVUkI4h4ekQjr8OZvCUrNa439HxRQDf1YrgH0BSrOMTQh167nBFQEttr0HQNWa
         l6ActKSc2gtRf4JUjjMaNt7sYRIJuboAN4kbL+T2RF9fwpZygNsxiHE8oPTaGQn1IE
         SN8DtbNtGEAsBRhS+Zge5jTT4vLbgqDLhiZYYnmHUql8TFfz5pYnL7DUMPXZ7KoBjt
         5I2ujVcAuFUNComKlstjLlrqHcjwdeOIMro/WBQVrAS9LbjWKWmqRuoF8ORGPr+h3n
         iJpfbsH/11gPiFt+dqvklsTM0JKT0uP6U7O96Y4TzakkIeM5/t1SutIiTT1d2EXOwS
         Lx75xYrfpy5eQ==
Date:   Tue, 10 Aug 2021 14:31:01 +0100
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-perf-users@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/perf: Replace '0xf' instances with
 ID_AA64DFR0_PMUVER_IMP_DEF
Message-ID: <20210810133101.GD2946@willie-the-truck>
References: <1628571998-13634-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1628571998-13634-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Aug 10, 2021 at 10:36:38AM +0530, Anshuman Khandual wrote:
> ID_AA64DFR0_PMUVER_IMP_DEF which indicate implementation defined PMU, never
> actually gets used although there are '0xf' instances scattered all around.
> Just do the macro replacement to improve readability.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: kvmarm@lists.cs.columbia.edu
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This applies on v5.14-rc5
> 
>  arch/arm64/include/asm/cpufeature.h | 2 +-
>  arch/arm64/kernel/perf_event.c      | 2 +-
>  arch/arm64/kvm/perf.c               | 2 +-
>  arch/arm64/kvm/pmu-emul.c           | 6 +++---
>  4 files changed, 6 insertions(+), 6 deletions(-)

Please can you split this with the KVM parts in their own patch?

Thanks,

Will
