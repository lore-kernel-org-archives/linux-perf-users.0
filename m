Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90E7C4338F
	for <linux-perf-users@archiver.kernel.org>; Tue, 10 Aug 2021 15:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 820F96101E
	for <linux-perf-users@archiver.kernel.org>; Tue, 10 Aug 2021 15:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241849AbhHJPAi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 10 Aug 2021 11:00:38 -0400
Received: from foss.arm.com ([217.140.110.172]:57432 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239443AbhHJPAi (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 10 Aug 2021 11:00:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D818F1FB;
        Tue, 10 Aug 2021 08:00:15 -0700 (PDT)
Received: from [10.163.67.89] (unknown [10.163.67.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B4943F718;
        Tue, 10 Aug 2021 08:00:12 -0700 (PDT)
Subject: Re: [PATCH] arm64/perf: Replace '0xf' instances with
 ID_AA64DFR0_PMUVER_IMP_DEF
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-perf-users@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
References: <1628571998-13634-1-git-send-email-anshuman.khandual@arm.com>
 <20210810133101.GD2946@willie-the-truck>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <995fce58-d1fa-9f0f-b8bd-05e689330482@arm.com>
Date:   Tue, 10 Aug 2021 20:31:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210810133101.GD2946@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 8/10/21 7:01 PM, Will Deacon wrote:
> On Tue, Aug 10, 2021 at 10:36:38AM +0530, Anshuman Khandual wrote:
>> ID_AA64DFR0_PMUVER_IMP_DEF which indicate implementation defined PMU, never
>> actually gets used although there are '0xf' instances scattered all around.
>> Just do the macro replacement to improve readability.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: linux-perf-users@vger.kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: kvmarm@lists.cs.columbia.edu
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> This applies on v5.14-rc5
>>
>>  arch/arm64/include/asm/cpufeature.h | 2 +-
>>  arch/arm64/kernel/perf_event.c      | 2 +-
>>  arch/arm64/kvm/perf.c               | 2 +-
>>  arch/arm64/kvm/pmu-emul.c           | 6 +++---
>>  4 files changed, 6 insertions(+), 6 deletions(-)
> 
> Please can you split this with the KVM parts in their own patch?

Sure, will do.
