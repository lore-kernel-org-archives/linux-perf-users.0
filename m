Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF140C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 14 Sep 2021 11:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97CFB610D1
	for <linux-perf-users@archiver.kernel.org>; Tue, 14 Sep 2021 11:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbhINL42 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 14 Sep 2021 07:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbhINL41 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 14 Sep 2021 07:56:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF365C061574;
        Tue, 14 Sep 2021 04:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lbaft6YWSRLzOdeUu5YKqGNKfNQ5U+1pdUU605d2s14=; b=k+cQuR4jbwUsDsSB8nX4cD+lbc
        OYvYy290iOuaYRLCcT1sFLq7nAjtnal2BkG2YV9KirKJI+I0voCzFBvyb9PzN9v4ZpHJIqQsMh1uH
        tUmPemdwiEWChCa37euQu1pg6OhFqcFmNASQ656X8gfDaq//ko0a8SSzdHVHToUjzH79nSbuzcvhV
        LsZG4wbEyQ+arPzXSsgUPfi4HpKJmJ32NZS1caiA1osta3yCcqsPTg9mVCH6y1t1niZNo4jWpJCQf
        uCOCJ68KZcSTwI+smqFTFHdYFykwIJz14BZWumWjnnYrfTQ7hYTVcQ/OOiMlQ9p6Oc5Jq5EGmy63r
        fmAJx00Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQ6uN-00EcUW-PY; Tue, 14 Sep 2021 11:47:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 69F2D30003A;
        Tue, 14 Sep 2021 13:47:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5911A2D1FEA08; Tue, 14 Sep 2021 13:47:26 +0200 (CEST)
Date:   Tue, 14 Sep 2021 13:47:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Song Liu <songliubraving@fb.com>, x86@kernel.org,
        Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org
Subject: Re: [PATCH v5 4/9] perf/x86: Add compiler barrier after updating BTS
Message-ID: <YUCLzrMyx2yhBE7E@hirez.programming.kicks-ass.net>
References: <20210809111407.596077-1-leo.yan@linaro.org>
 <20210809111407.596077-5-leo.yan@linaro.org>
 <20210829105657.GC14461@leoy-ThinkPad-X240s>
 <YUBwqGuQskkw328z@hirez.programming.kicks-ass.net>
 <20210914100517.GC1538480@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914100517.GC1538480@leoy-ThinkPad-X240s>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Sep 14, 2021 at 06:05:17PM +0800, Leo Yan wrote:
> Hi Peter,
> 
> On Tue, Sep 14, 2021 at 11:51:36AM +0200, Peter Zijlstra wrote:
> > On Sun, Aug 29, 2021 at 06:56:57PM +0800, Leo Yan wrote:
> > > Hi Peter, or any x86 maintainer,
> > > 
> > > On Mon, Aug 09, 2021 at 07:14:02PM +0800, Leo Yan wrote:
> > > > Since BTS is coherent, simply add a compiler barrier to separate the BTS
> > > > update and aux_head store.
> > > 
> > > Could you reivew this patch and check if BTS needs the comipler
> > > barrier in this case?  Thanks.
> > 
> > Yes, a compiler barrier is sufficient.
> > 
> > You want me to pick it up?
> 
> Maybe other maintainers are more suitable than me to answer this :)
> 
> Yeah, I think it's great if you could pick it.

OK, done.
