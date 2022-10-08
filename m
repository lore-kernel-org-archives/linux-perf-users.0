Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1F4C433FE
	for <linux-perf-users@archiver.kernel.org>; Sat,  8 Oct 2022 14:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiJHOIa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 8 Oct 2022 10:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiJHOI3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 8 Oct 2022 10:08:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8747648E88;
        Sat,  8 Oct 2022 07:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wD6pqrT2g8oCJelnKZKJ0EZlxxhJxKsk3kEfOiAnIBA=; b=Tc+b8pBy+p0jfrJ4FvsAuhuCTH
        Q0BbwH8M3eKR2MAcvigxuuPESqFY32yKT34AsAnaHJzczYwzmSLKfGKQuJfdKXI6BmFYo+b+bwKtD
        0EP6jmilk89BUtUcAlAMEfI6WkAiHioABd91oEBIEdYh0PZXBxT+dDstrwHrcc8iyPO4huUihsH/5
        5Vh3z1U/47oKVFw7eq9WR29raH2BoYOYcVamJrrgy+2Rg7EUndcHc5vnEN10YHjvNXI5T4UO3WYgw
        FVGT2jqCLGW5WcD8tOZJmzAh7+mxtS9oRsunfTnU93YT0QCai4QhLd8cJyA4U5TkcRPCvtS5S8fEu
        QGXFwYCw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ohAV5-002jXU-Jy; Sat, 08 Oct 2022 14:08:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2E6C630007E;
        Sat,  8 Oct 2022 16:08:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DB4AC209DB0E9; Sat,  8 Oct 2022 16:08:18 +0200 (CEST)
Date:   Sat, 8 Oct 2022 16:08:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] perf: Fix missing SIGTRAPs
Message-ID: <Y0GEUkLWDvU34h9f@hirez.programming.kicks-ass.net>
References: <20220927121322.1236730-1-elver@google.com>
 <Yz7ZLaT4jW3Y9EYS@hirez.programming.kicks-ass.net>
 <Yz7fWw8duIOezSW1@elver.google.com>
 <Yz78MMMJ74tBw0gu@hirez.programming.kicks-ass.net>
 <Yz/zXpF1yLshrJm/@elver.google.com>
 <Y0Ak/D05KhJeKaed@hirez.programming.kicks-ass.net>
 <Y0AwaxcJNOWhMKXP@elver.google.com>
 <Y0GAXJkwK5nXeFfG@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0GAXJkwK5nXeFfG@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sat, Oct 08, 2022 at 03:51:24PM +0200, Peter Zijlstra wrote:
> On Fri, Oct 07, 2022 at 03:58:03PM +0200, Marco Elver wrote:
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 9319af6013f1..7de83c42d312 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -2285,9 +2285,10 @@ event_sched_out(struct perf_event *event,
> >  			 */
> >  			local_dec(&event->ctx->nr_pending);
> >  		} else {
> > -			WARN_ON_ONCE(event->pending_work);
> > -			event->pending_work = 1;
> > -			task_work_add(current, &event->pending_task, TWA_RESUME);
> > +			if (!event->pending_work) {
> > +				event->pending_work = 1;
> > +				task_work_add(current, &event->pending_task, TWA_RESUME);
> > +			}
> 			  else {
> 				local_dec(&event->ctx->nr_pending);
> 			}
> >  		}
> >  	}
> 
> That whole thing can be written much saner like:
> 
> 	if (event->pending_sigtrap) {
> 		event->pending_sigtrap = 0;
> 		if (state != PERF_EVENT_STATE_OFF &&
> 		    !event->pending_work) {
> 			event->pending_work = 1;
> 			local_inc(&event->ctx->nr_pending);
> 			task_work_add(current, &event->pending_task, TWA_RESUME);
> 		}
> 		local_dec(&event->ctx->nr_pending);
> 	}
> 
> Except now we have two nr_pending ops -- I'm torn.

I've settled for:

+       if (event->pending_sigtrap) {
+               bool dec = true;
+
+               event->pending_sigtrap = 0;
+               if (state != PERF_EVENT_STATE_OFF &&
+                   !event->pending_work) {
+                       event->pending_work = 1;
+                       dec = false;
+                       task_work_add(current, &event->pending_task, TWA_RESUME);
+               }
+               if (dec)
+                       local_dec(&event->ctx->nr_pending);
+	}
