Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9259C4707F
	for <linux-perf-users@archiver.kernel.org>; Thu, 27 May 2021 08:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C351061077
	for <linux-perf-users@archiver.kernel.org>; Thu, 27 May 2021 08:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235215AbhE0IN3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 27 May 2021 04:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbhE0IN3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 27 May 2021 04:13:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63840C061574;
        Thu, 27 May 2021 01:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4Y3CcIoxMMaFD9h9S4IhABIEBINR0ELh2dpuM4jNQiI=; b=je5rVz1rOPwpso47/jPUpsl6jm
        H6kIYADcDWvgqYJvdB7zC9T1hFPESXyZt1D+GkohM9gT6khQQxRx13i9EzQCBVjF/Ni5tvsTiVgX6
        See/Gf1pI6o90s7H3XRgikcOtRahSRqr4BuiJvLpgbeGq9ylgAGqAG5puQ+MXPla3e7IzZEevaVTU
        KPqqVAzK92pW2RihVBbXdQqjrI1EeSDVF17LCGUeGOxxLDNs1n/4xxku7mx+s0T+7YOsQp61TTz7+
        TKBZaiVMoDYEiJBPpHT97yjfVj23z7wX/iJh5Uz4y+hVttaezItWksi7s2suXEXXLPMZdGS1ez5YK
        k8FA41fA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lmB6e-005Jot-QC; Thu, 27 May 2021 08:11:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E40FF300202;
        Thu, 27 May 2021 10:11:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9F24D200A775A; Thu, 27 May 2021 10:11:02 +0200 (CEST)
Date:   Thu, 27 May 2021 10:11:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf auxtrace: Change to use SMP memory barriers
Message-ID: <YK9UFl7Grv/mwmVc@hirez.programming.kicks-ass.net>
References: <20210519140319.1673043-1-leo.yan@linaro.org>
 <d1fc3dd3-e79a-4e93-1083-6b08e0cabe59@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1fc3dd3-e79a-4e93-1083-6b08e0cabe59@intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, May 27, 2021 at 10:54:56AM +0300, Adrian Hunter wrote:
> On 19/05/21 5:03 pm, Leo Yan wrote:
> > The AUX ring buffer's head and tail can be accessed from multiple CPUs
> > on SMP system, so changes to use SMP memory barriers to replace the
> > uniprocessor barriers.
> 
> I don't think user space should attempt to be SMP-aware.

Uhh, what? It pretty much has to. Since userspace cannot assume UP, it
must assume SMP.

> For perf tools, on __x86_64__ it looks like smp_rmb() is only a compiler barrier, whereas
> rmb() is a "lfence" memory barrier instruction, so this patch does not
> seem to do what the commit message says at least for x86.

The commit message is somewhat confused; *mb() are not UP barriers
(although they are available and useful on UP). They're device/dma
barriers.

> With regard to the AUX area, we don't know in general how data gets there,
> so using memory barriers seems sensible.

IIRC (but I ddn't check) the rule was that the kernel needs to ensure
the AUX area is complete before it updates the head pointer. So if
userspace can observe the head pointer, it must then also be able to
observe the data. This is not something userspace can fix up anyway.

The ordering here is between the head pointer and the data, and from a
userspace perspective that's a regular smp ordering. Similar for the
tail update, that's between our reading the data and writing the tail,
regular cache coherent smp ordering.

So ACK on the patch, it's sane and an optimization for both x86 and ARM.
Just the Changelog needs work.

> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/util/auxtrace.h | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> > index 472c0973b1f1..8bed284ccc82 100644
> > --- a/tools/perf/util/auxtrace.h
> > +++ b/tools/perf/util/auxtrace.h
> > @@ -452,7 +452,7 @@ static inline u64 auxtrace_mmap__read_snapshot_head(struct auxtrace_mmap *mm)
> >  	u64 head = READ_ONCE(pc->aux_head);
> >  
> >  	/* Ensure all reads are done after we read the head */
> > -	rmb();
> > +	smp_rmb();
> >  	return head;
> >  }
> >  
> > @@ -466,7 +466,7 @@ static inline u64 auxtrace_mmap__read_head(struct auxtrace_mmap *mm)
> >  #endif
> >  
> >  	/* Ensure all reads are done after we read the head */
> > -	rmb();
> > +	smp_rmb();
> >  	return head;
> >  }
> >  
> > @@ -478,7 +478,7 @@ static inline void auxtrace_mmap__write_tail(struct auxtrace_mmap *mm, u64 tail)
> >  #endif
> >  
> >  	/* Ensure all reads are done before we write the tail out */
> > -	mb();
> > +	smp_mb();
> >  #if BITS_PER_LONG == 64 || !defined(HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT)
> >  	pc->aux_tail = tail;
> >  #else
> > 
> 
