Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFD0C11F64
	for <linux-perf-users@archiver.kernel.org>; Thu,  1 Jul 2021 17:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B528661400
	for <linux-perf-users@archiver.kernel.org>; Thu,  1 Jul 2021 17:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbhGARFw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 1 Jul 2021 13:05:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:46378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229812AbhGARFw (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 1 Jul 2021 13:05:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 21DAD6128E;
        Thu,  1 Jul 2021 17:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625159001;
        bh=TvfZ8ZpA+Bt++OF11xc9ysqfPKVPLi3/pVy70tRJvaY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aPWGJRQyi8Puk6QOPpyBUbKuqN0a6r7hDgnTirK3X6Oe75Dk1Eqb8Kg8++/Py6gZC
         ekoyqyaAT/asilkL9vb9hLzM4lgCeoEONFMPrYsZCMPhPCTmTwDJoQOmHbON4vMP1y
         Bg7pzhBFK2UpTqs4aFV8E4HCN2DL5MdvVEwj1A+sOZzTl5ZjMrGmdrHVIrJz6L41vO
         lvmJP9Y+hTri7BmCSc56r0uO4xbwXjyUG3iNZmxCZu5qNysnfaFqwwUcwCMvZadqKa
         UR1uziy7409pOjTVAA0Sdj67PIqjYZJKt9L5XNc0ZqHE46VJBUU3wPKvJUWJ/W6CZT
         0AR5IZMBjoiYg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B526040B1A; Thu,  1 Jul 2021 14:03:16 -0300 (-03)
Date:   Thu, 1 Jul 2021 14:03:16 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>, Al Grant <Al.Grant@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] perf arm-spe: Don't wait for PERF_RECORD_EXIT
 event
Message-ID: <YN31VC9e/33QYhwn@kernel.org>
References: <20210519071939.1598923-1-leo.yan@linaro.org>
 <20210519071939.1598923-6-leo.yan@linaro.org>
 <369fd454-d94d-daa1-ead4-b42645ec4282@arm.com>
 <20210628121217.GD200044@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628121217.GD200044@leoy-ThinkPad-X240s>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Jun 28, 2021 at 08:12:17PM +0800, Leo Yan escreveu:
> On Fri, Jun 25, 2021 at 02:25:15PM +0100, James Clark wrote:
> > For the whole set:
> > Reviewed-by: James Clark <james.clark@arm.com>
> > Tested-by: James Clark <james.clark@arm.com>
 
> > I see a big improvement in decoding involving multiple processes because the timestamps are now

> > 
> > For example perf-exec samples are visible right before the exec is done, and on an
> > application that forks, samples are visible from all processes. For example:

> >    perf record -e arm_spe// -- bash -c "stress -c 1"
> >    perf script

> >    perf-exec  4502 [003] 259755.050409:          1    l1d-access:  ffff80001014b840 sched_clock+0x40 ([kernel.kallsyms])
> >    perf-exec  4502 [003] 259755.050409:          1    tlb-access:  ffff80001014b840 sched_clock+0x40 ([kernel.kallsyms])
> >    perf-exec  4502 [003] 259755.050409:          1        memory:  ffff80001014b840 sched_clock+0x40 ([kernel.kallsyms])
> >    perf-exec  4502 [003] 259755.050411:          1    tlb-access:  ffff800010120fb8 __rcu_read_lock+0x0 ([kernel.kallsyms])
> >    bash  4502 [003] 259755.050411:          1   branch-miss:  ffff8000105b2a40 memcpy+0x80 ([kernel.kallsyms])
> >    bash  4502 [003] 259755.050411:          1    tlb-access:                 0 [unknown] ([unknown])
> >    ...
> >    stress  4502 [003] 259755.051468:          1    l1d-access:  ffff800010259a24 __vma_adjust+0x1f4 ([kernel.kallsyms])
> >    stress  4502 [003] 259755.051468:          1    tlb-access:  ffff800010259a24 __vma_adjust+0x1f4 ([kernel.kallsyms])
> >    stress  4502 [003] 259755.051468:          1        memory:  ffff800010259a24 __vma_adjust+0x1f4 ([kernel.kallsyms])

> > Previously samples were only attributed to 'stress', which was obviously wrong.
> 
> Thanks a lot for the review and testing, James!
> 
> Hi Arnaldo, I confirmed this patch set can be cleanly applied on
> the latest acme/perf/core branch, so could you pick up this patch
> set?

Applied, thanks, please let me know if there is still something
outstanding,

- Arnaldo
