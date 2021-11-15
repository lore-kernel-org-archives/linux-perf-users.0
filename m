Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385A2C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 15 Nov 2021 12:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 165E2613A7
	for <linux-perf-users@archiver.kernel.org>; Mon, 15 Nov 2021 12:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhKOMKP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 15 Nov 2021 07:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbhKOMKN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 15 Nov 2021 07:10:13 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD44C061746;
        Mon, 15 Nov 2021 04:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JvoktfdODrK+E6Hn17SM3KNIUHT3t1bSzP+0XvL3miU=; b=Qxt6K4DGfAfHP4nOIfR8UYymv9
        nO61k3APNFN2HOJDkAIn8DspLzn8w0L8hempXmMnWSixhCHz9/NZniqFEa/xXCNpS4HmHEfuKCw42
        Dj423D6Kbmkn1mFvqZvdZosBjP5mMJ8ejXOu8qni3+yoHTV/2V01kCrvbuamOcRSlbI61iCIAVF1f
        RlFFQ4sQc+pV9JBsuu0c62uIjIK0FKZ70fEJtx/yaupP3Y/c1FgNnvsucDcGJW9NjU9GjDoEr0R+r
        vArT4+YEm6E/TUsSX8/aj578bvFEPZSJ8l3ZeVQL7owb63sAhA0H137fq9L1w5rFv3SWi6/kgLMzw
        /wopZJZA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmalK-00G8u0-Os; Mon, 15 Nov 2021 12:07:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A6FE030001B;
        Mon, 15 Nov 2021 13:07:01 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 967412CCBCBAD; Mon, 15 Nov 2021 13:07:01 +0100 (CET)
Date:   Mon, 15 Nov 2021 13:07:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     kim.phillips@amd.com, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, santosh.shukla@amd.com,
        sandipan.das@amd.com
Subject: Re: [RFC] perf/amd/ibs: Move ibs pmus under perf_sw_context
Message-ID: <YZJNZRuXjND9zqjL@hirez.programming.kicks-ass.net>
References: <20211115094838.3359-1-ravi.bangoria@amd.com>
 <YZJB5FVHpzhwFMtZ@hirez.programming.kicks-ass.net>
 <7ee6951e-eda1-7872-4158-e3bbb9eb31b7@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ee6951e-eda1-7872-4158-e3bbb9eb31b7@amd.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Nov 15, 2021 at 05:31:21PM +0530, Ravi Bangoria wrote:
> 
> 
> On 15-Nov-21 4:47 PM, Peter Zijlstra wrote:
> > On Mon, Nov 15, 2021 at 03:18:38PM +0530, Ravi Bangoria wrote:
> >> Ideally, a pmu which is present in each hw thread belongs to
> >> perf_hw_context, but perf_hw_context has limitation of allowing only
> >> one pmu (a core pmu) and thus other hw pmus need to use either sw or
> >> invalid context which limits pmu functionalities.
> >>
> >> This is not a new problem. It has been raised in the past, for example,
> >> Arm big.LITTLE (same for Intel ADL) and s390 had this issue:
> >>
> >>   Arm:  https://lore.kernel.org/lkml/20160425175837.GB3141@leverpostej
> >>   s390: https://lore.kernel.org/lkml/20160606082124.GA30154@twins.programming.kicks-ass.net
> >>
> >> Arm big.LITTLE (followed by Intel ADL) solved this by allowing multiple
> >> (heterogeneous) pmus inside perf_hw_context. It makes sense as they are
> >> still registering single pmu for each hw thread.
> >>
> >> s390 solved it by moving 2nd hw pmu to perf_sw_context, though that 2nd
> >> hw pmu is count mode only, i.e. no sampling.
> >>
> >> AMD IBS also has similar problem. IBS pmu is present in each hw thread.
> >> But because of perf_hw_context restriction, currently it belongs to
> >> perf_invalid_context and thus important functionalities like per-task
> >> profiling is not possible with IBS pmu. Moving it to perf_sw_context
> >> will:
> >>  - allow per-task monitoring
> >>  - allow cgroup wise profiling
> >>  - allow grouping of IBS with other pmu events
> >>  - disallow multiplexing
> >>
> >> Please let me know if I missed any major benefit or drawback of
> >> perf_sw_context. I'm also not sure how easy it would be to lift
> >> perf_hw_context restriction and start allowing more pmus in it.
> >>
> >> Suggestions?
> > 
> > Same as I do every time this comes up... this patch is still lingering
> > and wanting TLC:
> > 
> >   https://lore.kernel.org/lkml/20181010104559.GO5728@hirez.programming.kicks-ass.net/
> 
> Thanks for the pointer Peter. I have looked at the patch and it is quite complex,
> altering the very way perf event scheduling works.
> 
> I don't dispute that is the right 'fix' for the issue, but do you think adding a
> new perf context can help alleviate some of the issues in the interim?

And take away the motivation for people to do the right thing? How does
that work out in my favour?
