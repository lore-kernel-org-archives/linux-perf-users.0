Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF25FC433ED
	for <linux-perf-users@archiver.kernel.org>; Tue,  4 May 2021 12:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70E01613BA
	for <linux-perf-users@archiver.kernel.org>; Tue,  4 May 2021 12:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhEDMOs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 4 May 2021 08:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhEDMOs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 4 May 2021 08:14:48 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFF6C061574;
        Tue,  4 May 2021 05:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hPWmdQx8VD/dPdH29Dt+eddBPPsgip0TGuW5o0LBVzk=; b=j1eQr4albLLU7f+2BcLjQ//IUT
        6Cg10KLWwGZlqvfsnb3pTC6POpaWz2jEvuWeVLjybqcCyhij0WuGi4xNNwyNl5Xt1jJLjD9oyTWhe
        pJRuNs1ra+QdcYmo8mreyE9dso4iEzWnw3mTNdMH9RgpWpO/kQh00F0lSoXmkuwgSKlwyG5SDdiYC
        8aQjTiSnkZHAtNnLTSH19w5F7HNZiQZPyEAXRDvrK9kUpUhgTz1qioiWJK0od++5ERb/blTSaCIvm
        TKDvpJRlVYzr1u9cTnjuzoH5lbNeh0GtnQLLrXK96/r7l/XQdtX0mjZgwvJBLSAp3GVmWyHBHXd6/
        1RapkG1Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1ldtvt-00GAIl-7N; Tue, 04 May 2021 12:13:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C3F293001CD;
        Tue,  4 May 2021 14:13:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B297520D11F61; Tue,  4 May 2021 14:13:44 +0200 (CEST)
Date:   Tue, 4 May 2021 14:13:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        iommu@lists.linux-foundation.org, mingo@redhat.com,
        joro@8bytes.org, Jon.Grimm@amd.com, amonakov@ispras.ru,
        David Coe <david.coe@live.co.uk>
Subject: Re: [PATCH] x86/events/amd/iommu: Fix invalid Perf result due to
 IOMMU PMC power-gating
Message-ID: <YJE6eCyHtIONCJet@hirez.programming.kicks-ass.net>
References: <20210504065236.4415-1-suravee.suthikulpanit@amd.com>
 <YJEWWbEeDm0rUyC+@hirez.programming.kicks-ass.net>
 <e9769da5-3d2a-6e86-8ebd-feb00b567bba@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9769da5-3d2a-6e86-8ebd-feb00b567bba@amd.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, May 04, 2021 at 06:58:29PM +0700, Suthikulpanit, Suravee wrote:
> Peter,
> 
> On 5/4/2021 4:39 PM, Peter Zijlstra wrote:
> > On Tue, May 04, 2021 at 01:52:36AM -0500, Suravee Suthikulpanit wrote:
> > 
> > > 2. Since AMD IOMMU PMU does not support interrupt mode, the logic
> > >     can be simplified to always start counting with value zero,
> > >     and accumulate the counter value when stopping without the need
> > >     to keep track and reprogram the counter with the previously read
> > >     counter value.
> > 
> > This relies on the hardware counter being the full 64bit wide, is it?
> > 
> 
> The HW counter value is 48-bit. Not sure why it needs to be 64-bit?
> I might be missing some points here? Could you please describe?

How do you deal with the 48bit overflow if you don't use the interrupt?
