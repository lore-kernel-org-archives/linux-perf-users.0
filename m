Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54B6C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue,  5 Oct 2021 20:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A575761502
	for <linux-perf-users@archiver.kernel.org>; Tue,  5 Oct 2021 20:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhJEUYk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 5 Oct 2021 16:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbhJEUYk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 5 Oct 2021 16:24:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFD6C061749;
        Tue,  5 Oct 2021 13:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+8X5bhOq6FZhcb3qINVEcr3c5ULv6DfdL9C3Qj2SrpQ=; b=MUpHCsfnUDPsrJaINQKVwTGzod
        SQHHHLABNDthwLhAwW9/RsYLycFVOi5Noiv+IXx27yRs8eUSdgGaKxfB8R23ngaKH/PqrZ8lJNQ6R
        9ePe6xJjb4tTUU3t+lG6dkKRzUY807bOvyZTKXnhLW3aUs/I1dIypFanY/UXsqTYDgOywDJq/6yvJ
        N1sff/pAd8zrpF3ZwiEg/aEuU8Ut52/unlb60rMNUnsrNW244g0s+Gu9QrlcreQNSkCk9MBU2Lh/9
        OTA5WhHbUX6umVUx2LU3Lj5XaLVnIzTzdUpGwJ/scnTnn3dpddgzSKrSlrvsOitHPs3kOdBAu4eHH
        mFJh2ODw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXqv9-000EvW-TX; Tue, 05 Oct 2021 20:20:24 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 67BE0981AAA; Tue,  5 Oct 2021 22:20:15 +0200 (CEST)
Date:   Tue, 5 Oct 2021 22:20:15 +0200
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
Subject: Re: [PATCH 2/4] perf: Add mem_hops field in perf_mem_data_src
 structure
Message-ID: <20211005202015.GC174703@worktop.programming.kicks-ass.net>
References: <20211005091837.250044-1-kjain@linux.ibm.com>
 <20211005091837.250044-2-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005091837.250044-2-kjain@linux.ibm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Oct 05, 2021 at 02:48:35PM +0530, Kajol Jain wrote:
> Going forward, future generation systems can have more hierarchy
> within the chip/package level but currently we don't have any data source
> encoding field in perf, which can be used to represent this level of data.
> 
> Add a new field called 'mem_hops' in the perf_mem_data_src structure
> which can be used to represent intra-chip/package or inter-chip/off-package
> details. This field is of size 3 bits where PERF_MEM_HOPS_{NA, 0..6} value
> can be used to present different hop levels data.
> 
> Also add corresponding macros to define mem_hop field values
> and shift value.
> 
> Currently we define macro for HOPS_0 which corresponds
> to data coming from another core but same chip.
> 
> For ex: Encodings for mem_hops fields with L2 cache:
> 
> L2			- local L2
> L2 | REMOTE | HOPS_0	- remote core, same chip L2

Can we do s/chip/node/ ? Hops are something NUMA related, while chips
come in a bag or something :-)

> +/* hop level */
> +#define PERF_MEM_HOPS_0		0x01 /* remote core, same chip */
> +/* 2-7 available */
> +#define PERF_MEM_HOPS_SHIFT	43
