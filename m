Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1F2C54EBD
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Jan 2023 15:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237012AbjAIPlc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 9 Jan 2023 10:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237035AbjAIPka (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Jan 2023 10:40:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DFC26CD;
        Mon,  9 Jan 2023 07:38:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA1606119C;
        Mon,  9 Jan 2023 15:38:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25459C433D2;
        Mon,  9 Jan 2023 15:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673278687;
        bh=7myYQ1O115vx5+6y13iy7L0NzEU0V3HzwHUsg+NH+y8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nXLxlMiBSkNwxh8n8nZ1vVZtKrpWP6cKV3BEKLs5ZLhbBbUVBTtwGfbjczACpvhNo
         r3k9Wb1pNjhJU5ENdo4xVolEVy2AXQ0a6vFKyFT6CWQ5es6LGXPBVOQM43ZeGt4Szi
         CTrALVeDCveynhJWg8+SHWpKkYyIFocQ/GRdIodwJFfLQftY7PT24K+PQzEjBcYl3Q
         S7PJPciKGxoRx3CCU2AcQrOyg8LW1JJxDniFUiOQW3rHMTta7x5excEB2BlQOhziMv
         izWiXuQXYHROlwEynDBXcnLe48RQYBjgJfbOJAzfzk12Lmoczra+Icq/k7rwD5D7HE
         NFQKH6qdiMZNw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6BB8640468; Mon,  9 Jan 2023 12:38:04 -0300 (-03)
Date:   Mon, 9 Jan 2023 12:38:04 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] perf kmem: Support legacy tracepoints
Message-ID: <Y7w03A7f2zUWwihm@kernel.org>
References: <20230108062400.250690-1-leo.yan@linaro.org>
 <14dd06c2-39f8-ccb5-ce59-f3a1e45c94d0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14dd06c2-39f8-ccb5-ce59-f3a1e45c94d0@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Jan 09, 2023 at 03:11:47PM +0000, James Clark escreveu:
> 
> 
> On 08/01/2023 06:23, Leo Yan wrote:
> > Commit 11e9734bcb6a ("mm/slab_common: unify NUMA and UMA version of
> > tracepoints") removed tracepoints 'kmalloc_node' and
> > 'kmem_cache_alloc_node', these two tracepoints have disappeared in the
> > latest kernel, but we also need to consider the tool should be backward
> > compatible with old kernels.
> > 
> > If detects the tracepoint "kmem:kmalloc_node" is existed on a system,
> > this patch enables the legacy tracepoints, otherwise, it will ignore
> > them for the new kernels.
> > 
> > Reported-by: Ravi Bangoria <ravi.bangoria@amd.com>
> > Fixes: 11e9734bcb6a ("mm/slab_common: unify NUMA and UMA version of tracepoints")
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/builtin-kmem.c | 29 ++++++++++++++++++++++++++---
> >  1 file changed, 26 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
> > index e20656c431a4..50a3df5dc18a 100644
> > --- a/tools/perf/builtin-kmem.c
> > +++ b/tools/perf/builtin-kmem.c
> > @@ -1824,6 +1824,19 @@ static int parse_line_opt(const struct option *opt __maybe_unused,
> >  	return 0;
> >  }
> >  
> > +static bool slab_legacy_tp_is_exposed(void)
> > +{
> > +	/*
> > +	 * The tracepoints "kmem:kmalloc_node" and
> > +	 * "kmem:kmem_cache_alloc_node" have been removed on the latest
> > +	 * kernel, if the tracepoint "kmem:kmalloc_node" is existed it
> > +	 * means the tool is running on an old kernel, we need to
> > +	 * rollback to support these legacy tracepoints.
> > +	 */
> > +	return IS_ERR(trace_event__tp_format("kmem", "kmalloc_node")) ?
> > +		false : true;
> > +}
> > +
> >  static int __cmd_record(int argc, const char **argv)
> >  {
> >  	const char * const record_args[] = {
> > @@ -1831,22 +1844,28 @@ static int __cmd_record(int argc, const char **argv)
> >  	};
> >  	const char * const slab_events[] = {
> >  	"-e", "kmem:kmalloc",
> > -	"-e", "kmem:kmalloc_node",
> >  	"-e", "kmem:kfree",
> >  	"-e", "kmem:kmem_cache_alloc",
> > -	"-e", "kmem:kmem_cache_alloc_node",
> >  	"-e", "kmem:kmem_cache_free",
> >  	};
> > +	const char * const slab_legacy_events[] = {
> > +	"-e", "kmem:kmalloc_node",
> > +	"-e", "kmem:kmem_cache_alloc_node",
> > +	};
> 
> Reviewed-by: James Clark <james.clark@arm.com>
> 
> This fixes the error with mem:kmalloc_node for me.
> 
> I was thinking that it might be best to add all events to the list
> conditionally instead of just the legacy ones. That way, the same error
> won't happen in the future. But maybe it's best to have an explicit
> error again in case the breaking change was unintentional so it's fine
> as it is I think.

Just applied this, the changes you brains stormed may come as later
patches, thanks,

- Arnaldo
