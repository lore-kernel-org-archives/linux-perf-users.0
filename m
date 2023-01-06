Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7474FC3DA7A
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Jan 2023 17:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjAFR2C (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 6 Jan 2023 12:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234433AbjAFR2B (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 6 Jan 2023 12:28:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD8E687AE
        for <linux-perf-users@vger.kernel.org>; Fri,  6 Jan 2023 09:28:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8562B81E05
        for <linux-perf-users@vger.kernel.org>; Fri,  6 Jan 2023 17:27:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46908C433EF;
        Fri,  6 Jan 2023 17:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673026077;
        bh=d4wpYFuNA8Fc+HiZ6OsXf52DKaQHpa6GgjPIti0uDtU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KIAd+HQJ3tv0Re55K3bDULFwmxWDO/7Cv3HK275pPUkPD7C2QatzpfJnA+NOJm5w4
         CBJuh44fpsvlocZr8OhqsOUpIx7LTmTDrdd6ss0s+nczIjJ1P0fIKEEsKydmAwGC6n
         +aduLZ1ZmOL2iy0csy76YAdOKFZ9ic8T9jx8vRbhA/qwu57cMfcQnpMwLKGsjhSInd
         y1a+nPfDc4D3JADRCIqFVhSRELw1oGECk5J4BYHYGdQBu6AmAfJAfoaktU7upfqXWa
         6gqH0qrdXzUj+pkpJ3A48VYBDhkbTYIoE9DoLdJNMmxrBhlrZBVnkSvFl4Lp2kP9nx
         MiRsekjNt8NJg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BB69E40468; Fri,  6 Jan 2023 14:27:54 -0300 (-03)
Date:   Fri, 6 Jan 2023 14:27:54 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Leo Yan <leo.yan@linaro.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: [BUG] perf kmem: Broken because of missing tracepoints
Message-ID: <Y7haGk30muVMjRhF@kernel.org>
References: <b5f82509-41d7-7598-6ec2-fcfa74c7ddaa@amd.com>
 <Y7b6cmRE/+5HJLCa@kernel.org>
 <Y7ewMG+0YKp9pgud@leoy-yangtze.lan>
 <c4c5c3cb-f1a8-84ee-0dc8-8be0d63c820d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4c5c3cb-f1a8-84ee-0dc8-8be0d63c820d@amd.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Jan 06, 2023 at 06:34:32PM +0530, Ravi Bangoria escreveu:
> On 06-Jan-23 10:52 AM, Leo Yan wrote:
> > Hi Ravi, Arnaldo,
> > 
> > On Thu, Jan 05, 2023 at 01:27:30PM -0300, Arnaldo Carvalho de Melo wrote:
> >> Em Thu, Jan 05, 2023 at 07:03:25PM +0530, Ravi Bangoria escreveu:
> >>> Hello,
> >>>
> >>> Two tracepoints, kmem:kmalloc_node and kmem:kmem_cache_alloc_node used by perf-
> >>> kmem tool were removed from kernel by commit 11e9734bcb6a7 ("mm/slab_common:
> >>> unify NUMA and UMA version of tracepoints"). This causes issue while running
> >>> perf kmem on latest kernel:
> >>>
> >>>   $ sudo ./perf kmem record
> >>>   event syntax error: 'kmem:kmalloc_node'
> >>>                        \___ unknown tracepoint
> >>>
> >>>   $ sudo ./perf kmem record
> >>>   event syntax error: 'kmem:kmem_cache_alloc_node'
> >>>                        \___ unknown tracepoint
> >>>
> >>> Haven't got a chance to debug further. Anyone aware of this?
> >>
> >> I didn't notice this so far, would be good to have a fix soon.
> > 
> > I looked a bit for the issue, so wrote a fix and verified on my
> > Arm64 machine.  Please let me know if this works for you or not,
> > thanks!
> > 
> > From b7d26f5543401924ae4ad93daeba66cd7d58eb39 Mon Sep 17 00:00:00 2001
> > From: Leo Yan <leo.yan@linaro.org>
> > Date: Fri, 6 Jan 2023 11:16:27 +0800
> > Subject: [PATCH] perf kmem: Fix tracepoints breakage
> > 
> > Commit 11e9734bcb6a ("mm/slab_common: unify NUMA and UMA version of
> > tracepoints") removed tracepoints 'kmalloc_node' and
> > 'kmem_cache_alloc_node'; the tracepoints 'kmalloc'
> > and 'kmem_cache_alloc' add an extra field 'node' to present the
> > memory node to be allocated and replace the two removed tracepoints
> > respectively.
> > 
> > The commit introduces ABI breakage, both for the dropped tracepoints and
> > for the updated tracepoints.
> > 
> > To fix this issue, perf tool removes the support for the tracepoints
> > 'kmalloc_node' and 'kmem_cache_alloc_node'; for the two updated
> > tracepoints this patch reads out the new field 'node', if its value is
> > NUMA_NO_NODE (-1), we doesn't take it as a cross memory allocation.
> > 
> > Reported-by: Ravi Bangoria <ravi.bangoria@amd.com>
> > Fixes: 11e9734bcb6a ("mm/slab_common: unify NUMA and UMA version of tracepoints")
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> 
> Thanks Leo. A quick test shows it fixes the issue.
> 
> Tested-by: Ravi Bangoria <ravi.bangoria@amd.com>

Thanks, applied.

- Arnaldo
