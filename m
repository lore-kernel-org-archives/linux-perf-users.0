Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B98C47082
	for <linux-perf-users@archiver.kernel.org>; Mon, 31 May 2021 17:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47E10610A8
	for <linux-perf-users@archiver.kernel.org>; Mon, 31 May 2021 17:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbhEaRXg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 31 May 2021 13:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbhEaRXa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 31 May 2021 13:23:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C15EC06F0FB;
        Mon, 31 May 2021 08:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lE1hDy09j0KTbLLoUxbq+EnHpIMPD9qqZ9pibZXYJSo=; b=cdbrjCofYVR4z6XzntlRc1H8if
        KOb7UEPFcTKzI0bvgdDUPGOygzYUWpZ9wmdZUVCXXW04uerqFjYiXw+3J5oQpSaJ2bmryxZvHkp3D
        /9i8qnXS29fU8M7Pvep/rFS1rvOEeATQYowxNjzdcsXZhYimlo5VKHSVH5qzjeIvULUy/XEIVDtAc
        DU0OO7O0OrTZBfrkXTlwGd4DJjLRqHHYTOoj4+TBMFaWHK1CAIfun6U0MgefBpbNVxfSwn7UDGKU2
        l4l5V1MknQl1W+DfrK/cI04fPOZnh5nq6wQTH6V7s36kFZZq0cLznduB6fbRJOftWhS/txBYDHnGh
        K4PSRk3g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lnk97-009AEz-22; Mon, 31 May 2021 15:48:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9581A300223;
        Mon, 31 May 2021 17:48:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 742B020126D07; Mon, 31 May 2021 17:48:03 +0200 (CEST)
Date:   Mon, 31 May 2021 17:48:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf auxtrace: Change to use SMP memory barriers
Message-ID: <YLUFMzxin1PpgIdZ@hirez.programming.kicks-ass.net>
References: <20210519140319.1673043-1-leo.yan@linaro.org>
 <d1fc3dd3-e79a-4e93-1083-6b08e0cabe59@intel.com>
 <YK9UFl7Grv/mwmVc@hirez.programming.kicks-ass.net>
 <3c7dcd5d-fddd-5d3b-81ac-cb7b615b0338@intel.com>
 <7cdc3578-a50e-89ef-477a-3dc1f84f96bb@intel.com>
 <YK9tEQmk4Q+M5yJh@hirez.programming.kicks-ass.net>
 <20210531145302.GC9324@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531145302.GC9324@leoy-ThinkPad-X240s>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, May 31, 2021 at 10:53:02PM +0800, Leo Yan wrote:
> Hi Peter, Adrian,
> 
> On Thu, May 27, 2021 at 11:57:37AM +0200, Peter Zijlstra wrote:
> > On Thu, May 27, 2021 at 12:24:15PM +0300, Adrian Hunter wrote:
> > 
> > > > If all we want is a compiler barrier, then shouldn't that be what we use?
> > > > i.e. barrier()
> 
> Sorry for a bit late.  Just bring up one question before I respin
> this patch set.
> 
> > > I guess you are saying we still need to stop potential re-ordering across
> > > CPUs, so please ignore my comments.
> > 
> > Right; so the ordering issue is real, consider:
> > 
> > 	CPU0 (kernel)		CPU1 (user)
> > 
> > 	write data		read head
> > 	smp_wmb()		smp_rmb()
> > 	write head		read data
> 
> One thing should be mentioned is the Linux kernel has _not_ used an
> explict "smb_wmb()" between writing AUX trace data and updating header
> "aux_head".  Please see the function perf_aux_output_end():

I think we pushed that into the driver. There is nothing the generic
code can do here.

It is the drivers responsibility of ensuring the data is stable before
calling perf_aux_output_end() or something along those lines.
