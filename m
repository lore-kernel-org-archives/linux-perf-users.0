Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DC1C4707F
	for <linux-perf-users@archiver.kernel.org>; Thu, 27 May 2021 09:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F36BF613C9
	for <linux-perf-users@archiver.kernel.org>; Thu, 27 May 2021 09:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236003AbhE0KAE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 27 May 2021 06:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235867AbhE0KAE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 27 May 2021 06:00:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C92C061574;
        Thu, 27 May 2021 02:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M06BuFAj4yuWOZYB2BCUAwndvtEu3fLzqS5XWt/dw1o=; b=t8bjjiP2YWixI4qv9xTsJdH7nJ
        gux/gd6vQ+nWycY8df/tUys7eGrbt1hG/Zsa6F90elOPyVGgLy3ddY+eSpV+vN/TiqJHzbp7HANcI
        YW7E9PXf3oyyc8xmHgDtT+WFgiw8QY9Z9566L34iSCd3+9jmm5j4kHGscS+1OWFBzLTaEe1wKkCHD
        GSopVMDMYAOIatIPWNaUKcq5vJlJArT0h7gy3zmXkOFZ3E1KqtW9DUuwsALNY754tNRhlXHjIm9FH
        GJCnS0LvYfXBBHRVvcppMz1qQza0zSp+bFSjO7NG95ELKg4+mkhZ//X1jKz+okgPXD8IPw6RrVMU5
        Vih36JkQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lmCll-005PLs-TW; Thu, 27 May 2021 09:57:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 72DA730022C;
        Thu, 27 May 2021 11:57:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 38669200D3A72; Thu, 27 May 2021 11:57:37 +0200 (CEST)
Date:   Thu, 27 May 2021 11:57:37 +0200
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
Message-ID: <YK9tEQmk4Q+M5yJh@hirez.programming.kicks-ass.net>
References: <20210519140319.1673043-1-leo.yan@linaro.org>
 <d1fc3dd3-e79a-4e93-1083-6b08e0cabe59@intel.com>
 <YK9UFl7Grv/mwmVc@hirez.programming.kicks-ass.net>
 <3c7dcd5d-fddd-5d3b-81ac-cb7b615b0338@intel.com>
 <7cdc3578-a50e-89ef-477a-3dc1f84f96bb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cdc3578-a50e-89ef-477a-3dc1f84f96bb@intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, May 27, 2021 at 12:24:15PM +0300, Adrian Hunter wrote:

> > If all we want is a compiler barrier, then shouldn't that be what we use?
> > i.e. barrier()
> 
> I guess you are saying we still need to stop potential re-ordering across
> CPUs, so please ignore my comments.

Right; so the ordering issue is real, consider:

	CPU0 (kernel)		CPU1 (user)

	write data		read head
	smp_wmb()		smp_rmb()
	write head		read data

Without explicit ordering (on either side), we might either read data
that isn't written yet:

			     ,--(read data)
	write data	     |
	smp_wmb()	     |
	write head ---.	     |
		      `-->   |	read head
			     `- read data

Where the head load observes the new head writte, but the data load is
speculated and loads data before it is written.

Or, we can write the head before the data write is visible:

    ,--	write data
    |	write head
    |				read head
    |				smp_rmb()
    |				read data
    `-> (data visible)

Where we read the head head, but still observe stale data because the
stores got committed out of order.

x86 is TSO, so neither reordering is actually possible, hence both
barriers being a compiler barrier (to ensure the compiler doesn't
reorder them for us). But weaker hardware *will* allow those orderings
and we very much need actual barriers there.

Welcome to the magical world of memory ordering and weak architectures.
