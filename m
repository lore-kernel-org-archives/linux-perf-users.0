Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DBAC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 06:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01E1E610A2
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 06:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbhJGGww (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 7 Oct 2021 02:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbhJGGww (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Oct 2021 02:52:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260F2C061746;
        Wed,  6 Oct 2021 23:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r7RxJJsMsG57QM8OssME2T//95638Yr+53YLvxiUMPo=; b=N+CikdAsaH/XyP+DtK2BYK0ngf
        26yBIimbP939gKxyWwaB6Ai3vMCeNCbOGem354X/5uRDiwlSpBLJ4QQI9cSwk/eyf6rd0cErjeBnu
        dJsGBT1D4TzrSly45cZ/gOEzWvMPf7dipk1tGjlPKUJ+J9/UIzhePpZ9+stfkO3G9AUOfn1CGtVBl
        3W9wCJtJx3boVHSsG70iOjPB4Y+vOiPCrxnzYgnUAHJBmPXDaA7RKIBD8GkrSO0MzXWZGPCpPTtLK
        /U/gMKbPCjVeKkmrgAKIZu6UghiS5GrMiWriHvI2FZKkhBI+lFU8dgh/uiRPYc5+4CwwGiLE0ntWA
        92lCycdw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mYNDi-001bQI-Da; Thu, 07 Oct 2021 06:49:41 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C9EE998623A; Thu,  7 Oct 2021 08:49:33 +0200 (CEST)
Date:   Thu, 7 Oct 2021 08:49:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, acme@kernel.org,
        jolsa@kernel.org, namhyung@kernel.org, ak@linux.intel.com,
        linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, rnsastry@linux.ibm.com,
        yao.jin@linux.intel.com, ast@kernel.org, daniel@iogearbox.net,
        songliubraving@fb.com, kan.liang@linux.intel.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        paulus@samba.org
Subject: Re: [PATCH v3 0/4] Add mem_hops field in perf_mem_data_src structure
Message-ID: <20211007064933.GK174703@worktop.programming.kicks-ass.net>
References: <20211006140654.298352-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006140654.298352-1-kjain@linux.ibm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Oct 06, 2021 at 07:36:50PM +0530, Kajol Jain wrote:

> Kajol Jain (4):
>   perf: Add comment about current state of PERF_MEM_LVL_* namespace and
>     remove an extra line
>   perf: Add mem_hops field in perf_mem_data_src structure
>   tools/perf: Add mem_hops field in perf_mem_data_src structure
>   powerpc/perf: Fix data source encodings for L2.1 and L3.1 accesses
> 
>  arch/powerpc/perf/isa207-common.c     | 26 +++++++++++++++++++++-----
>  arch/powerpc/perf/isa207-common.h     |  2 ++
>  include/uapi/linux/perf_event.h       | 19 ++++++++++++++++---
>  tools/include/uapi/linux/perf_event.h | 19 ++++++++++++++++---
>  tools/perf/util/mem-events.c          | 20 ++++++++++++++++++--
>  5 files changed, 73 insertions(+), 13 deletions(-)

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

How do we want this routed? Shall I take it, or does Michael want it in
the Power tree?
