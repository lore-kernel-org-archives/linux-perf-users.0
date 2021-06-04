Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2101FC07E94
	for <linux-perf-users@archiver.kernel.org>; Fri,  4 Jun 2021 09:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09B4361168
	for <linux-perf-users@archiver.kernel.org>; Fri,  4 Jun 2021 09:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhFDJiH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 4 Jun 2021 05:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhFDJiG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 4 Jun 2021 05:38:06 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08F4C06174A;
        Fri,  4 Jun 2021 02:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fR7+i+YmNawjkoccoFSeAPqd8amJASiNbCSjyQ5VpkM=; b=psUWVn2ryRG0cjFeMXkFKMtfzP
        3h9+IfLSQvrU0KkRyyk/AWCZKJzSbH0616/cglVhCglIhsrZfZt0vAuvNNLd/1rJ7k7wZaFBgYCTt
        XlEQ6jZx3b8niAJugSDTppyrQ+DSsh2qvvRpYArh1lc4b6UbBPG/mWX4p31ycqn7QFuo79XB3uvzY
        8BsmsV1pFaeUiFdzFbyTbFSHlRGuLcA4hgR2URvkafhsfzrp7/f6TohFeES+/7l+wiZpVuQ6HTTuz
        vQQ0sIzr2yRqbxOXLDZASWArLXooc7ULR1Q8izNY6mQK1iav2wPDOz1SjoU/BGQgbfqvZmuQOQjjg
        4U5FMYYA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lp6FN-003OtO-LX; Fri, 04 Jun 2021 09:36:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C61D6300223;
        Fri,  4 Jun 2021 11:36:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B57F8200DCB64; Fri,  4 Jun 2021 11:36:15 +0200 (CEST)
Date:   Fri, 4 Jun 2021 11:36:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] tools/perf: Do not set a variable unless it will be used
Message-ID: <YLn0D+1R2QHZYRVV@hirez.programming.kicks-ass.net>
References: <20210604092638.985694-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604092638.985694-1-ribalda@chromium.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jun 04, 2021 at 11:26:38AM +0200, Ricardo Ribalda wrote:
> clang-13 triggers the following warning:
> 
> bench/inject-buildid.c:351:6: error: variable 'len' set but not used [-Werror,-Wunused-but-set-variable]
>         u64 len = 0;
> 
> This patch sets the value to len only if it will be used afterwards.

My vote would be to kill that warning, what absolute shite.
