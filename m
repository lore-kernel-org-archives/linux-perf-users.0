Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6268C47089
	for <linux-perf-users@archiver.kernel.org>; Thu, 27 May 2021 10:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85F03613D1
	for <linux-perf-users@archiver.kernel.org>; Thu, 27 May 2021 10:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236221AbhE0K7T (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 27 May 2021 06:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236217AbhE0K7T (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 27 May 2021 06:59:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572FCC061574;
        Thu, 27 May 2021 03:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pYhSL9rZ5yWbPh3GEPzpn/Iur2XiYh2pZd2OnaDaVY8=; b=UVTh0DJM7OAuJs3Xx5rXD/FTtX
        IG8416uNRIsQ+bGsxyo5HGyHszG5vqnGpQ48HiZutLTmJNXqE8kVognzcZxu7ibt6Wr2lOtimLqNQ
        rNBHtLHIDOXtK4GYT4OqrY14zGILhXJn8grYJqSJhIHBU5Zd+PNo5Q85MpEIkTcweE2qwlj2fW91L
        XrjP/cVQ9xUPwb6rf8yyXtawjtBh4pLvHSVPMBKugy25bKWm2SUzsYUKXKBiEInamRwPICuwfKHp6
        NIVhYNjwp3BQKz0AQvPFAfqht3up0AJJV9qqUiRSeVUL38CtAWoJ5kNZ03V2/FQUP0csuzYQjACkU
        f6zM978A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lmDhX-005Rlg-15; Thu, 27 May 2021 10:57:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 68E1C30022C;
        Thu, 27 May 2021 12:57:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 42BBA2C80046A; Thu, 27 May 2021 12:57:17 +0200 (CEST)
Date:   Thu, 27 May 2021 12:57:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        dvyukov@google.com,
        syzbot+142c9018f5962db69c7e@syzkaller.appspotmail.com
Subject: Re: [PATCH] perf: Fix data race between pin_count increment/decrement
Message-ID: <YK97DXkDbhH5BMdI@hirez.programming.kicks-ass.net>
References: <20210527104711.2671610-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527104711.2671610-1-elver@google.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, May 27, 2021 at 12:47:11PM +0200, Marco Elver wrote:
> KCSAN reports a data race between increment and decrement of pin_count:
> 
>   write to 0xffff888237c2d4e0 of 4 bytes by task 15740 on cpu 1:
>    find_get_context		kernel/events/core.c:4617
>    __do_sys_perf_event_open	kernel/events/core.c:12097 [inline]
>    __se_sys_perf_event_open	kernel/events/core.c:11933
>    ...
>   read to 0xffff888237c2d4e0 of 4 bytes by task 15743 on cpu 0:
>    perf_unpin_context		kernel/events/core.c:1525 [inline]
>    __do_sys_perf_event_open	kernel/events/core.c:12328 [inline]
>    __se_sys_perf_event_open	kernel/events/core.c:11933
>    ...
> 
> Because neither read-modify-write here is atomic, this can lead to one of the
> operations being lost, resulting in an inconsistent pin_count. Fix it by adding
> the missing locking in the CPU-event case.
> 

Indeed so!

Fixes: fe4b04fa31a6 ("perf: Cure task_oncpu_function_call() races")

> Reported-by: syzbot+142c9018f5962db69c7e@syzkaller.appspotmail.com
> Signed-off-by: Marco Elver <elver@google.com>

Thanks!
