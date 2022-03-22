Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10063C433FE
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Mar 2022 13:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbiCVNDm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 22 Mar 2022 09:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235189AbiCVNDj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 22 Mar 2022 09:03:39 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7E485974;
        Tue, 22 Mar 2022 06:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=prF9czoDtl9GAA4LHPQoYGhsJJ4PrlX0+rNnCZcAsR4=; b=SpVe8SEYVv4YB7KKDtRtugDGa8
        ucWnhCYUjaw5wsBv3zqqPJY5OJHHV6JgAN+6h6iCabNZo1FUj1gk5ggpESdJbL82UJ1eE7MZqspHV
        oPPgV20vxRM3DawwBZNVf/XNwt9Y6/nXnmo6ZT9BzBROLWfsSioHixPXSB1bHJU7VxkwPN0//21s6
        hT/RMQxUSDRoOEg8bSUzw66zrBFjvHfsvq3Hv4koikeOO95YB+NjJiVsAijtxftbskXcq+QWWXV+N
        dPOxa09OMFYICMps4JcX6YfCQf85wbA+lSSuSfvRIK9vDgU2O/Z7POp46T1fwEph785Gnaz8illn/
        yXcm1MJQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWe9A-003T3J-2n; Tue, 22 Mar 2022 13:02:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B324C30020B;
        Tue, 22 Mar 2022 14:01:59 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A26AE2019FD09; Tue, 22 Mar 2022 14:01:59 +0100 (CET)
Date:   Tue, 22 Mar 2022 14:01:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, eranian@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com
Subject: Re: [PATCH v2 3/6] perf/core: Don't pass task around when ctx sched
 in
Message-ID: <YjnIx5x6/sTeua4H@hirez.programming.kicks-ass.net>
References: <20220322120834.98637-1-zhouchengming@bytedance.com>
 <20220322120834.98637-4-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322120834.98637-4-zhouchengming@bytedance.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Mar 22, 2022 at 08:08:31PM +0800, Chengming Zhou wrote:
> The current code pass task around for ctx_sched_in(), only
> to get perf_cgroup of the task, then update the timestamp
> of it and its ancestors and set them to active.
> 
> But we can use cpuctx->cgrp to get active perf_cgroup and
> its ancestors since cpuctx->cgrp has been set before
> ctx_sched_in().
> 
> This patch remove the task argument in ctx_sched_in()
> and cleanup related code.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Yeah, this looks reasonable I suppose...
