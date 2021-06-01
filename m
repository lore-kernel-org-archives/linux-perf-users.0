Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D05C4708F
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Jun 2021 06:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FAE8613AB
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Jun 2021 06:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbhFAGua (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 1 Jun 2021 02:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbhFAGu3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 1 Jun 2021 02:50:29 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2BBC061574;
        Mon, 31 May 2021 23:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yXjIfNK9DTEjPITQUTzdT9Agi20asksGOpSTeydpPF0=; b=gWm1S+y0yiAyN4/XlzX0WwT10p
        HvahNPxySUtvGHvom0TwDSeXBpeovUwIqiwUb9LYzxb/9gJGda4gjgrBu2Z1CYn9g9xFoFrDCn9mR
        IkbvG8TWJ/fgn0o2APSnx1bty7UzQ9Br+TwGUOzbdk2YdGyIPOWwm+fCxN29c729kinLum63aKTlG
        Ne7ttAu/ahfn8jF/b0XL51TwqSpSTq29gcyHjEtLUP6xbZekeEFk7onpEtE9ng+IAclQcmhQju37l
        JeQM2t9n3Qjee53+4hAGQWvthaFhdsN5gfznox/EP6sG0LyZiqOfTi6b4lHCB3L8Pvh4tIE+4KpTu
        oRwHiZ6g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lnyCP-002TSS-T5; Tue, 01 Jun 2021 06:48:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AC46A300269;
        Tue,  1 Jun 2021 08:48:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5E92D2011CA24; Tue,  1 Jun 2021 08:48:29 +0200 (CEST)
Date:   Tue, 1 Jun 2021 08:48:29 +0200
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
Subject: Re: [PATCH v1 2/2] perf auxtrace: Optimize barriers with
 load-acquire and store-release
Message-ID: <YLXYPWeLB8wjo4lQ@hirez.programming.kicks-ass.net>
References: <20210519140319.1673043-1-leo.yan@linaro.org>
 <20210519140319.1673043-2-leo.yan@linaro.org>
 <20210531151049.GE9324@leoy-ThinkPad-X240s>
 <cc3810cd-5edc-26d3-9c77-8bb6479152c1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc3810cd-5edc-26d3-9c77-8bb6479152c1@intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, May 31, 2021 at 10:03:33PM +0300, Adrian Hunter wrote:
> On 31/05/21 6:10 pm, Leo Yan wrote:
> > Hi Peter, Adrian,
> > 
> > On Wed, May 19, 2021 at 10:03:19PM +0800, Leo Yan wrote:
> >> Load-acquire and store-release are one-way permeable barriers, which can
> >> be used to guarantee the memory ordering between accessing the buffer
> >> data and the buffer's head / tail.
> >>
> >> This patch optimizes the memory ordering with the load-acquire and
> >> store-release barriers.
> > 
> > Is this patch okay for you?
> > 
> > Besides this patch, I have an extra question.  You could see for
> > accessing the AUX buffer's head and tail, it also support to use
> > compiler build-in functions for atomicity accessing:
> > 
> >   __sync_val_compare_and_swap()
> >   __sync_bool_compare_and_swap()
> > 
> > Since now we have READ_ONCE()/WRITE_ONCE(), do you think we still need
> > to support __sync_xxx_compare_and_swap() atomicity?
> 
> I don't remember, but it seems to me atomicity is needed only
> for a 32-bit perf running with a 64-bit kernel.

But that:

	do {
		old_tail = __sync_val_compare_and_swap(&pc->aux_tail, 0, 0);
	} while (!__sync_bool_compare_and_swap(&pc->aux_tail, old_tail, tail));

doesn't want to make sense to me. It appears to do a cmpxchg with 0
values to load old_tail, and then a further cmpxchg with old_tail to
write the new tail.

That's some really crazy code. That makes absolutely no sense what so
ever and needs to just be deleted.

On top of that, it uses atomic instrincs for a u64, which is not
something that'll actually work on a whole bunch of 32bit platforms.
