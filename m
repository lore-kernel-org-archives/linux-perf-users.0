Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A19BC47080
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Jun 2021 06:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CCF961159
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Jun 2021 06:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbhFAHAi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 1 Jun 2021 03:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbhFAHAi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 1 Jun 2021 03:00:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD25C061574;
        Mon, 31 May 2021 23:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0l2yYQsJKshGfYOkmILgyUlyXhH0uHawPd3uvuaVdjM=; b=k4IBvCxuSl/cf3JYsEuCg30doH
        NVZXR6Yd2MqaEquUWs6A+cNso2m+KF0VSIW5qrLXOZdgEI28CMTG20Q3taB8n10nEuPAQSZaA6hmM
        vu2BZiUjBSHYqRVppoBpoB24mcTLdPkMWrcBhPhZso/aOEOwf6Y3zzECWNxenMV5tlsySEd1J0PP4
        SLpO4668CFUvfVkW4veDHNiPG5oZhPNbZAIFixGXYXCSrF8l1SmIsVjkgkeoThtYg9NkN0hjrlRT3
        5pB2zBJ470/tiOxr6Mq8/iiJF/9GbUIzblC4nuDrScPiMcxbokqu+mK6OsQURH6ia6VcLjavc1R9H
        /OUHZ/CA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lnyMG-009lrX-4B; Tue, 01 Jun 2021 06:58:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A9B0930019C;
        Tue,  1 Jun 2021 08:58:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 845732011CA24; Tue,  1 Jun 2021 08:58:35 +0200 (CEST)
Date:   Tue, 1 Jun 2021 08:58:35 +0200
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
Subject: Re: [PATCH v1 2/2] perf auxtrace: Optimize barriers with
 load-acquire and store-release
Message-ID: <YLXamz7BChYBspmY@hirez.programming.kicks-ass.net>
References: <20210519140319.1673043-1-leo.yan@linaro.org>
 <20210519140319.1673043-2-leo.yan@linaro.org>
 <20210531151049.GE9324@leoy-ThinkPad-X240s>
 <cc3810cd-5edc-26d3-9c77-8bb6479152c1@intel.com>
 <20210601063342.GB10026@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601063342.GB10026@leoy-ThinkPad-X240s>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jun 01, 2021 at 02:33:42PM +0800, Leo Yan wrote:
> 
> 32-bit perf wants to access 64-bit value atomically, I think it tries to
> avoid the issue caused by scenario:
> 
>         CPU0 (64-bit kernel)           CPU1 (32-bit user)
> 
>                                          read head_lo
>         WRITE_ONCE(head)
>                                          read head_hi

Right; so I think Mark and me once spend a bunch of time on this for the
regular ring buffer, but my memory is vague.

It was supposed to be that the high word would always be zero on 32bit,
but it turns out that that is not in fact the case and we get to have
this race that's basically unfixable :/

Or maybe that was only the compat case.. Ah yes, so see the kernel uses
unsigned long, so on 32bit the high word is empty and we always
read/write 0s, unless you're explicitly doing daft things.

But on compat, the high word can be non-zero and we get to have 'fun'.
