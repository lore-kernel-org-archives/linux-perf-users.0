Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19900C74A5B
	for <linux-perf-users@archiver.kernel.org>; Tue, 21 Mar 2023 12:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjCUMna (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 21 Mar 2023 08:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjCUMn2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 21 Mar 2023 08:43:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D359497C5
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Mar 2023 05:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=E3RCTYCIZksHTol92zr6CE+WlvTYIYZty7EHSztWSZk=; b=wEJgV4m1fW0wQTE+pa3csgZ+TN
        ISPnCUWy0bqpzaKNy8UntzuuUPLZHEfllW848cerhC0/W1LsEGfkmBmjF8JkHn5j8Y92HDUPGUQhr
        CxE/lwOYvRwOT3cydWJnTAei4IT7nR0/hs5Tmlv4y0rBYxe0ePrtb2lk7xhLurxlNsc3RfOtOOSC+
        orwl0lWgoczSUu/1QrJvKdK+QYwUpnn9qhyR9v/5u7AbzPqZxxBlPF2e6LKu4IuNaArjc/Dq2AO4B
        ho+F6ymVi46GJQmCiirwLUULT7YIrmssNdg4gEgupQfo6W0ZtohimbSeoafw6Y8E4x9jyV5B2oVfn
        AC4EYWqw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pebJs-0022LL-JD; Tue, 21 Mar 2023 12:42:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D5AFF3001D6;
        Tue, 21 Mar 2023 13:42:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BDE912394C189; Tue, 21 Mar 2023 13:42:27 +0100 (CET)
Date:   Tue, 21 Mar 2023 13:42:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Breno Leitao <leitao@debian.org>
Cc:     mingo@redhat.com, acme@kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, sandipan.das@amd.com, thomas.lendacky@amd.com,
        linux-perf-users@vger.kernel.org, x86@kernel.org, leit@fb.com
Subject: Re: [PATCH] perf/x86/amd/core: always clear status for idx
Message-ID: <20230321124227.GL2234901@hirez.programming.kicks-ass.net>
References: <20230321113338.1669660-1-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321113338.1669660-1-leitao@debian.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Mar 21, 2023 at 04:33:38AM -0700, Breno Leitao wrote:
> The variable 'status' (which contains the unhandled overflow bits) is
> not being properly masked in some cases, displaying the following
> warning:
> 
>   WARNING: CPU: 156 PID: 475601 at arch/x86/events/amd/core.c:972 amd_pmu_v2_handle_irq+0x216/0x270
> 
> This seems to be happening because the loop is being continued before
> the status bit being unset, in case x86_perf_event_set_period()
> returns 0. This is also causing an inconsistency because the "handled"
> counter is incremented, but the status bit is not cleaned.
> 
> Move the bit cleaning together above, together when the "handled"
> counter is incremented.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Can I get a Fixes: tag so I can consider it for perf/urgent ?
