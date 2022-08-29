Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF985ECAAA2
	for <linux-perf-users@archiver.kernel.org>; Mon, 29 Aug 2022 04:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiH2EM4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 29 Aug 2022 00:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiH2EMy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 29 Aug 2022 00:12:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9965A3A48B;
        Sun, 28 Aug 2022 21:12:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55EE123A;
        Sun, 28 Aug 2022 21:12:58 -0700 (PDT)
Received: from [10.162.40.15] (unknown [10.162.40.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 941473F766;
        Sun, 28 Aug 2022 21:12:46 -0700 (PDT)
Message-ID: <e7726423-dfc5-93f0-90e2-159cd18f1b63@arm.com>
Date:   Mon, 29 Aug 2022 09:42:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V7 0/8] perf: Expand perf_branch_entry
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        Robin Murphy <robin.murphy@arm.com>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <20220824044822.70230-1-anshuman.khandual@arm.com>
 <YwdNe52eS6LO/KJe@worktop.programming.kicks-ass.net>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <YwdNe52eS6LO/KJe@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 8/25/22 15:52, Peter Zijlstra wrote:
> On Wed, Aug 24, 2022 at 10:18:14AM +0530, Anshuman Khandual wrote:
>> Anshuman Khandual (8):
>>   perf: Add system error and not in transaction branch types
>>   perf: Extend branch type classification
>>   perf: Capture branch privilege information
>>   perf: Add PERF_BR_NEW_ARCH_[N] map for BRBE on arm64 platform
> 
> I picked up these first 4 and rebased them on top of the recent AMD LBR
> patches.
> 
> They live in:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/core
> 
> for robot exposure. If all goes well they'll land in -tip.

Thanks Peter, I guess now Arnaldo could also pick up the tools patches well.

- Anshuman
