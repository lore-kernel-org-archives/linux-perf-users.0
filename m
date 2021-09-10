Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1572C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Sep 2021 16:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B39B0611C7
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Sep 2021 16:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbhIJQW3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 10 Sep 2021 12:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhIJQW3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 10 Sep 2021 12:22:29 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20ED3C061574;
        Fri, 10 Sep 2021 09:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=m/A6vsfwr9fdi2l9LU6Y7yfZuw/3zeOQr55qGQ2UFCk=; b=ixUbFIHOSnpDyyXisHuE0mFYqv
        1QxVvabuuSmzCB+F6OE6ReCxVwTz72w61+u73Z+n6fq9Q/d7fJjyp6V3I2WujBI5NPSa/x+3ELaxW
        vbw4VyxZlMiwVHifTIFRPtVulgUWvnxVz+czHpy+zSaWbFO46qOy/vqwQk0xjG4nKhhg43BsomWoq
        YCcpwQ6whS9PM7gU7ZsyzRFN4nYumRZhGkUzM/AUfptyuTNNAtR7rqXT+cC1cmloXBepybM5T5XRT
        DjVmywF+YUZr4a6VfSuP/9vmxsVLEZkpUZQE2mStwM2mqiVEPRSNF0SVXYWIoj53MpQwjQEUwvPU0
        g42Boy4A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOjH1-002Aju-PG; Fri, 10 Sep 2021 16:21:07 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4F36E98627A; Fri, 10 Sep 2021 18:21:07 +0200 (CEST)
Date:   Fri, 10 Sep 2021 18:21:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Baptiste Lepers <baptiste.lepers@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] events: Reuse value read using READ_ONCE instead of
 re-reading it
Message-ID: <20210910162107.GK4323@worktop.programming.kicks-ass.net>
References: <20210906015310.12802-1-baptiste.lepers@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210906015310.12802-1-baptiste.lepers@gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Sep 06, 2021 at 11:53:10AM +1000, Baptiste Lepers wrote:
> In perf_event_addr_filters_apply, the task associated with
> the event (event->ctx->task) is read using READ_ONCE at the beginning
> of the function, checked, and then re-read from event->ctx->task,
> voiding all guarantees of the checks. Reuse the value that was read by
> READ_ONCE to ensure the consistency of the task struct throughout the
> function.
> 
> Signed-off-by: Baptiste Lepers <baptiste.lepers@gmail.com>
> Fixes: 375637bc52495 ("perf/core: Introduce address range filtering")

Thanks!
