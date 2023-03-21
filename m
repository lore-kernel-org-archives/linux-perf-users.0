Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E979C74A5B
	for <linux-perf-users@archiver.kernel.org>; Tue, 21 Mar 2023 13:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjCUNn2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 21 Mar 2023 09:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjCUNn1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 21 Mar 2023 09:43:27 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A56293E9
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Mar 2023 06:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=I++tXunxEhQMFCH5VvRXdYwKlkMkRCWfnCq9Wki+U8g=; b=CbknfLdz1qC9+sMbCN2Lp9ASk8
        acqX6s/EzHud5bPP0fwToVfcMDr/w1hzSMLuWY4kqZlJ/l3vo8LeBQYbHqn0B5pzDfR6xVZ2mLS9O
        PL0XgaJg+jW4F4tG00fJdQzmc6P29Q/FImzr1aJzByWX4GOfPBip4tV+5gaeLN4vbgmJI4v+WE+QE
        ybr3GruTgco2a5ub/YHboUyc2rtdv/grADr005XuxWEIb2LIeBL/npcLaZ2oybXcXIbbMFptHV4pv
        VkP7TGFxzSVPk8PXKqxSj7TCRUVAaZN/OClk58JSDjcyXaxKs8yKKi+KJ9LX1TMPRSIBC5f89Pw3V
        GdfpTFkA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pecGc-004Gcr-2x;
        Tue, 21 Mar 2023 13:43:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2F42F3001D6;
        Tue, 21 Mar 2023 14:43:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1904A240BB806; Tue, 21 Mar 2023 14:43:09 +0100 (CET)
Date:   Tue, 21 Mar 2023 14:43:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     Breno Leitao <leitao@debian.org>, mingo@redhat.com,
        acme@kernel.org, jolsa@kernel.org, namhyung@kernel.org,
        thomas.lendacky@amd.com, linux-perf-users@vger.kernel.org,
        x86@kernel.org, leit@fb.com
Subject: Re: [PATCH] perf/x86/amd/core: always clear status for idx
Message-ID: <20230321134309.GA2264331@hirez.programming.kicks-ass.net>
References: <20230321113338.1669660-1-leitao@debian.org>
 <20230321124227.GL2234901@hirez.programming.kicks-ass.net>
 <ad31a4ea-8e91-dad0-7944-3893189b918b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad31a4ea-8e91-dad0-7944-3893189b918b@amd.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Mar 21, 2023 at 06:26:11PM +0530, Sandipan Das wrote:
> On 3/21/2023 6:12 PM, Peter Zijlstra wrote:
> > On Tue, Mar 21, 2023 at 04:33:38AM -0700, Breno Leitao wrote:
> >> The variable 'status' (which contains the unhandled overflow bits) is
> >> not being properly masked in some cases, displaying the following
> >> warning:
> >>
> >>   WARNING: CPU: 156 PID: 475601 at arch/x86/events/amd/core.c:972 amd_pmu_v2_handle_irq+0x216/0x270
> >>
> >> This seems to be happening because the loop is being continued before
> >> the status bit being unset, in case x86_perf_event_set_period()
> >> returns 0. This is also causing an inconsistency because the "handled"
> >> counter is incremented, but the status bit is not cleaned.
> >>
> >> Move the bit cleaning together above, together when the "handled"
> >> counter is incremented.
> >>
> >> Signed-off-by: Breno Leitao <leitao@debian.org>
> > 
> > Can I get a Fixes: tag so I can consider it for perf/urgent ?
> 
> That would be
> 
> Fixes: 7685665c390d ("perf/x86/amd/core: Add PerfMonV2 overflow handling")
> 

Cheers!
