Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B11C47080
	for <linux-perf-users@archiver.kernel.org>; Mon, 31 May 2021 16:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AAFF61370
	for <linux-perf-users@archiver.kernel.org>; Mon, 31 May 2021 16:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbhEaQZW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 31 May 2021 12:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbhEaQXN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 31 May 2021 12:23:13 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676E8C07E5F4
        for <linux-perf-users@vger.kernel.org>; Mon, 31 May 2021 07:53:08 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id e15so5358539plh.1
        for <linux-perf-users@vger.kernel.org>; Mon, 31 May 2021 07:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wIAKONQD0AzlFwHcL/Yws7RQlIzhCQy0inG8VqEz6s4=;
        b=pm6mKaQjthX6s1X+0eAP26KjoxeCZHKj0MP4l+RcQ7IuzzGOOiWpzbIgO5f60jqaH/
         Cy30hBiK62VHDPVyNsQn8/ebv47NQ5XZLCraA9vZqIX4IpsDAYmMJO1J7xYcdT4OfT8L
         UBgffcjBFM/BvfHf3LIqZ92TviRhL2/fE8nJTb8ZsZ42LTUV4TWavac4n3tNhwxyjmf9
         pcm6zyevZnIsF909GktpTJ2zEPAUDFCGghC+erj+rCFfCRvaNO7RIayTRDYchBuajPJb
         ucSR3pg6/9Fn362+9tb7y9v9MXhd6vfFBnEgj0pxIqxKQP0habimPNnCwhecd+Uc5+r/
         lKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wIAKONQD0AzlFwHcL/Yws7RQlIzhCQy0inG8VqEz6s4=;
        b=IYPmxC8iTJHlA8n2yjlhmHDUyuFbNfvN0EFMuH97T8ISbulTLs684UBIcQzh03LtnX
         5wlszXKQacuv9CyQ0s3uZBWvDGF5rDqb2E197Hsc/LJnBmPO+qFD0KFMKANGgrmlszPt
         L57C0anNfEiacdvmmGzdqa9SvrCAKSOZTT3H/sqdQw8EHfZJ2P7l+cMKZSflg34UA1kc
         1EhY3geVxKgIOB3k7EU77pqXL032yeOLrB8UsrrRICzWeDjaFXVNDV4BnzH80Feadcsa
         pCVzBDIPnDLRsWQVC3VA8QEONsYCeGHDQQS+4xUi1nlHYvyYs9lxKIdEyYxGIfmfs3MG
         LFrw==
X-Gm-Message-State: AOAM533luHbzKlBe9tCQ8g/RFc1fCLd0nLMSW4lBUcGHq2BHMQZ28n01
        sm0qrI6ap/CD9ns+GWYCh+Lk3g==
X-Google-Smtp-Source: ABdhPJwFsQ+XrtpARwX9UkPJDpXWwZYa4Vmim475x0KQSs/9QytzjFq3MCoXuRZcDPzMVLIaObUgwQ==
X-Received: by 2002:a17:90b:38c4:: with SMTP id nn4mr5685864pjb.166.1622472787838;
        Mon, 31 May 2021 07:53:07 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (ec2-18-167-84-74.ap-east-1.compute.amazonaws.com. [18.167.84.74])
        by smtp.gmail.com with ESMTPSA id n8sm11001911pff.167.2021.05.31.07.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 07:53:07 -0700 (PDT)
Date:   Mon, 31 May 2021 22:53:02 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf auxtrace: Change to use SMP memory barriers
Message-ID: <20210531145302.GC9324@leoy-ThinkPad-X240s>
References: <20210519140319.1673043-1-leo.yan@linaro.org>
 <d1fc3dd3-e79a-4e93-1083-6b08e0cabe59@intel.com>
 <YK9UFl7Grv/mwmVc@hirez.programming.kicks-ass.net>
 <3c7dcd5d-fddd-5d3b-81ac-cb7b615b0338@intel.com>
 <7cdc3578-a50e-89ef-477a-3dc1f84f96bb@intel.com>
 <YK9tEQmk4Q+M5yJh@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YK9tEQmk4Q+M5yJh@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Peter, Adrian,

On Thu, May 27, 2021 at 11:57:37AM +0200, Peter Zijlstra wrote:
> On Thu, May 27, 2021 at 12:24:15PM +0300, Adrian Hunter wrote:
> 
> > > If all we want is a compiler barrier, then shouldn't that be what we use?
> > > i.e. barrier()

Sorry for a bit late.  Just bring up one question before I respin
this patch set.

> > I guess you are saying we still need to stop potential re-ordering across
> > CPUs, so please ignore my comments.
> 
> Right; so the ordering issue is real, consider:
> 
> 	CPU0 (kernel)		CPU1 (user)
> 
> 	write data		read head
> 	smp_wmb()		smp_rmb()
> 	write head		read data

One thing should be mentioned is the Linux kernel has _not_ used an
explict "smb_wmb()" between writing AUX trace data and updating header
"aux_head".  Please see the function perf_aux_output_end():

void perf_aux_output_end(..., size)
{
        ...

	if (size || (handle->aux_flags & ~(u64)PERF_AUX_FLAG_OVERWRITE))
		perf_event_aux_event(handle->event, aux_head, size,
				     handle->aux_flags);

	WRITE_ONCE(rb->user_page->aux_head, rb->aux_head);

        ...
}

But I think it's needless to add "smb_wmb()" prior to WRITE_ONCE()
sentence.  This is because:

Before updating the "aux_head", it calls perf_event_aux_event(), so
event PERF_RECORD_AUX is filled into the perf ring buffer, and executes
smb_wmb() + updates the header "user_page->data_head"; so the flow is
like blow:

  Fill AUX trace data to AUX ring buffer
  Fill RECORD_AUX event into perf ring buffer
  smb_wmb()
  update "user_page->data_head"  -> See perf_event_aux_event()/perf_output_end()
  update "user_page->aux_head"

This is a bit weird for two ring buffers (AUX and perf generic ring
buffers) share the same memory barrier between the write data and
write headers.

Do you think I understand correctly?  Or should add an explict
"smb_wmb()" before WRITE_ONCE(rb->user_page->aux_head, ...)?

Thanks,
Leo

> Without explicit ordering (on either side), we might either read data
> that isn't written yet:
> 
> 			     ,--(read data)
> 	write data	     |
> 	smp_wmb()	     |
> 	write head ---.	     |
> 		      `-->   |	read head
> 			     `- read data
> 
> Where the head load observes the new head writte, but the data load is
> speculated and loads data before it is written.
> 
> Or, we can write the head before the data write is visible:
> 
>     ,--	write data
>     |	write head
>     |				read head
>     |				smp_rmb()
>     |				read data
>     `-> (data visible)
> 
> Where we read the head head, but still observe stale data because the
> stores got committed out of order.
> 
> x86 is TSO, so neither reordering is actually possible, hence both
> barriers being a compiler barrier (to ensure the compiler doesn't
> reorder them for us). But weaker hardware *will* allow those orderings
> and we very much need actual barriers there.
> 
> Welcome to the magical world of memory ordering and weak architectures.
