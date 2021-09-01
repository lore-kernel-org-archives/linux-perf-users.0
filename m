Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E35C432BE
	for <linux-perf-users@archiver.kernel.org>; Wed,  1 Sep 2021 09:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7967D60FED
	for <linux-perf-users@archiver.kernel.org>; Wed,  1 Sep 2021 09:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbhIAKAL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 1 Sep 2021 06:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhIAKAK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 1 Sep 2021 06:00:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361A4C061575;
        Wed,  1 Sep 2021 02:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SAtktkGm7H51tdkwrltXh8zGCu8BIrDGrCMNYgtiUbQ=; b=pVh08Jvjlw96GrrYnVagrJUfrL
        iyp677uLnCHcyP1uZoQkNFWYc3vr940CZD/xiHlAjnml8D81oRQKU3seQeWWj84xBjO2o1zPNxSlJ
        /Vfht0d3ONEDrZPrh46KjvaA4o1vrJWPsNqMYCYOJQZrLdwG6Qz5BqFD2bAOUd4Vlw6BQ4477L4UC
        t9tWlciPPggLh+5VyUwUS5jgJDubBRWnXeJ3xw0DoZrSBQJeanQKPjwgC+hNrHBWCT/sCTzq2OPkO
        PJJTYzXFv5tFsVGgrSFpeg+RGvPFLcgKeuWHeQrdLUhHL0yyYjgxQWri8e8fh7mMXQtylK3ckDAWg
        y0JiIE7A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLN0K-0027UN-OS; Wed, 01 Sep 2021 09:58:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3EE483003FE;
        Wed,  1 Sep 2021 11:57:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E53FE2DD4238C; Wed,  1 Sep 2021 11:57:58 +0200 (CEST)
Date:   Wed, 1 Sep 2021 11:57:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
Cc:     "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: libperf: lack of interface
Message-ID: <YS9OpunoSHpNPA3/@hirez.programming.kicks-ass.net>
References: <OSBPR01MB460016842A4310264B1CC5A0F7CD9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB460016842A4310264B1CC5A0F7CD9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Sep 01, 2021 at 09:45:10AM +0000, nakamura.shun@fujitsu.com wrote:
> Hello.
> 
> I'm trying to change rdpmc test in perf_event_tests[1] to use libperf, but libperf doesn't have enough interfaces.
> Does anyone plan to implement any of these libperf features?
> 
> - Interfaces that can run ioctl (PERF_EVENT_IOC_RESET) from userland
> - Interfaces that can run fcntl (SIGIO) from userland
> 
> [1] https://github.com/deater/perf_event_tests/tree/master/tests/rdpmc

While IOC_RESET has it's uses, it really shouldn't be used in
combination with RDPMC, it destroys the whole 'dont do
syscalls'/performance thing.

The typical RDPMC usage is:

	/* setup counter on self */

	...

	start = RDPMC
	/* your code */
	end = RDPMC
	delta = end - start;

	...

Nowhere do we need a reset...
