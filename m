Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825F9C433F5
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 Nov 2021 00:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68764611CE
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 Nov 2021 00:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbhKFBBY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 5 Nov 2021 21:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbhKFBBY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 5 Nov 2021 21:01:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D905BC061570;
        Fri,  5 Nov 2021 17:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=8X0DdUNCAoyfQsZpIBtLXCHewJf/Ra0c7ujN9TKLlFw=; b=k9WLnGRbv/Pg5N/X5M+LkmDbgi
        AiB3Hg1m6ePDcjdTzkeKjhtqZYhz8/QGqZwxEd859Y63kFbArHTqCpoP+xcLq6F4VFRTxOoD+uDTL
        ZcZ9QUIbEEQWI0yfG1+JCR16BHbqYRARh7ZJjOBkBbXlDcg86ClCuJYBwp+cuVbQc2NOHMByDHcbt
        qoFEHf3g4YGRNhrU3fiW3QibCDB8Ynk/NFocnrAxb/Mo/fW0Krysh34Y0mv3/2e3ZEifVUvYe/KPm
        9F2xunnqJGdibw2JPnHa02550Gd/A95YqP9fAV+ovAiG+HRCToEL3p4qjg0YST9hgcSqBhLrUYpDY
        Yk0tnskA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mjA1L-006xtr-MN; Sat, 06 Nov 2021 00:57:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5519230031A;
        Sat,  6 Nov 2021 01:57:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3BF1A201C7B51; Sat,  6 Nov 2021 01:57:23 +0100 (CET)
Date:   Sat, 6 Nov 2021 01:57:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     kan.liang@linux.intel.com, LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: Using perf_event_open() to sample multiple events of a process
Message-ID: <YYXS8yldO/dwwVD4@hirez.programming.kicks-ass.net>
References: <92645262-D319-4068-9C44-2409EF44888E@gmail.com>
 <YYXQRYbRO193U4re@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YYXQRYbRO193U4re@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sat, Nov 06, 2021 at 01:45:57AM +0100, Peter Zijlstra wrote:
> On Thu, Nov 04, 2021 at 10:57:50PM -0700, Nadav Amit wrote:
> > Hello Ken, Peter,
> > 
> > I would appreciate some help regarding the use of perf_event_open()
> > to have multiple samples getting into the same mmap’d memory when they
> > are both attached to the same process.
> > 
> > I am doing so (using both PERF_FLAG_FD_NO_GROUP and PERF_FLAG_FD_OUTPUT),
> > but it results in -EINVAL. Debugging the code shows that
> > perf_event_set_output() fails due to the following check:
> > 
> >         /*
> >          * If its not a per-cpu rb, it must be the same task.
> >          */
> >         if (output_event->cpu == -1 && output_event->ctx != event->ctx)
> >                 goto out;
> > 
> > However, it appears that at this point, event->ctx is not initialized
> > (it is null) so the test fails and the whole perf_event_open() syscall
> > fails.
> > 
> > Am I missing something? If not, I am unsure, unfortunately, what the
> > proper way to fix it is…
> > 
> > I include a small test that fails on my system. The second
> > perf_event_open fails due to the check in perf_event_set_output():
> > 
> 
> Works when you use the SET_OUTPUT ioctl()...
> 
> I think something went sideways in the syscall path and things went out
> of order :/ I'll try and have a look.

The problem seems to be that we call perf_event_set_output() before we
set event->ctx, which is a bit of a problem.

Now, afaict it's been broken since c3f00c70276d ("perf: Separate
find_get_context() from event initialization"), which is ages ago :/

It's waaay too late to try and fix it; I'll be likely to make an even
bigger mess if I tried. Perhaps tomorrow.

Clearly FD_OUTPUT isn't much used :-(
