Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5823FC433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 24 Sep 2021 18:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 219706124B
	for <linux-perf-users@archiver.kernel.org>; Fri, 24 Sep 2021 18:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344342AbhIXS47 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 24 Sep 2021 14:56:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:48706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344271AbhIXS46 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 24 Sep 2021 14:56:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25DFA61050;
        Fri, 24 Sep 2021 18:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632509725;
        bh=TXsn3Uv+TGGzH1xr8185AlXEnFQs8EcjzTwxfzor9E0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F2WJ/kN1Gz4F61xI6E2RuSDUpvi0bDm4YS7ZfaRYZiqz05SFD90se/o0c9Y3rUyPL
         xb4ok/rCqjIlJBP5lqJBxUwc/uMv9vcCSyif2BCGyTk4dlW8zHpo4vB8NvyTMqy42N
         w+lipffCMIPfPZiQ9/6ZwOyQ4lRpf4W1vr1NYbBx340WSAS9rhYROzUyhN2s3Mc5QA
         6crOPZX3Fd5RLDLpc07rR3ckd9E/jM6kir4JzlE4/rBYv7Vcfbtnu6iMdRlYMc/5hu
         uSSXtsBzoEcsGZScE6J7VGM6kzIPBH1U5CLmE7NPdygDZzl29PcT8DlU56i1qb5Eag
         siRl9QRkheeiQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BB327410A1; Fri, 24 Sep 2021 15:55:22 -0300 (-03)
Date:   Fri, 24 Sep 2021 15:55:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf list: Display pmu prefix for partially supported
 hybrid cache events
Message-ID: <YU4fGqAHXZQavw09@kernel.org>
References: <20210909061844.10221-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909061844.10221-1-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Sep 09, 2021 at 02:18:44PM +0800, Jin Yao escreveu:
> Part of hardware cache events are only available on one CPU PMU.
> For example, 'L1-dcache-load-misses' is only available on cpu_core.
> perf list should clearly report this info.
> 
> root@otcpl-adl-s-2:~# ./perf list
> 
> Before:
>   L1-dcache-load-misses                              [Hardware cache event]
>   L1-dcache-loads                                    [Hardware cache event]
>   L1-dcache-stores                                   [Hardware cache event]
>   L1-icache-load-misses                              [Hardware cache event]
>   L1-icache-loads                                    [Hardware cache event]
>   LLC-load-misses                                    [Hardware cache event]
>   LLC-loads                                          [Hardware cache event]
>   LLC-store-misses                                   [Hardware cache event]
>   LLC-stores                                         [Hardware cache event]
>   branch-load-misses                                 [Hardware cache event]
>   branch-loads                                       [Hardware cache event]
>   dTLB-load-misses                                   [Hardware cache event]
>   dTLB-loads                                         [Hardware cache event]
>   dTLB-store-misses                                  [Hardware cache event]
>   dTLB-stores                                        [Hardware cache event]
>   iTLB-load-misses                                   [Hardware cache event]
>   node-load-misses                                   [Hardware cache event]
>   node-loads                                         [Hardware cache event]
>   node-store-misses                                  [Hardware cache event]
>   node-stores                                        [Hardware cache event]
> 
> After:
>   L1-dcache-loads                                    [Hardware cache event]
>   L1-dcache-stores                                   [Hardware cache event]
>   L1-icache-load-misses                              [Hardware cache event]
>   LLC-load-misses                                    [Hardware cache event]
>   LLC-loads                                          [Hardware cache event]
>   LLC-store-misses                                   [Hardware cache event]
>   LLC-stores                                         [Hardware cache event]
>   branch-load-misses                                 [Hardware cache event]
>   branch-loads                                       [Hardware cache event]
>   cpu_atom/L1-icache-loads/                          [Hardware cache event]
>   cpu_core/L1-dcache-load-misses/                    [Hardware cache event]
>   cpu_core/node-load-misses/                         [Hardware cache event]
>   cpu_core/node-loads/                               [Hardware cache event]
>   dTLB-load-misses                                   [Hardware cache event]
>   dTLB-loads                                         [Hardware cache event]
>   dTLB-store-misses                                  [Hardware cache event]
>   dTLB-stores                                        [Hardware cache event]
>   iTLB-load-misses                                   [Hardware cache event]

Thanks, applied.

- Arnaldo

