Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8167CC54E76
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Jan 2023 17:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbjAFRo7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 6 Jan 2023 12:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjAFRo7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 6 Jan 2023 12:44:59 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B168D41678
        for <linux-perf-users@vger.kernel.org>; Fri,  6 Jan 2023 09:44:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 093D4CE1D15
        for <linux-perf-users@vger.kernel.org>; Fri,  6 Jan 2023 17:44:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26771C433EF;
        Fri,  6 Jan 2023 17:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673027094;
        bh=6dER+GPZ62IbB+SAjP6qWoEGP3iMDjoJ9yaLmcwJRiI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ANg3MK7NlptuxTPQSVXOC2hhjw/7Kyxn2I3cbelMvrzmfy4u6+4Ta4OInaFSJWuLn
         FRvUi2y2t7w061FuqXr4O2dqF5/n15dq7EBY2pLMaBE79/NeMhPZIYK9jPDypkX5mk
         px8+k6PXxgF1E7nBJZL8FiWSD2koLdzCUwji+9Bh4ReUeEqv68ZtzfPszOzFNYgnsl
         UxJtf21Zomz1RqhjLWvC8hqy5qJY4z44b6AKwm/RTj7IptyqKsHtG9RKznDR5lGhjV
         IO7hq0aBthzlaVP6Sxkhk8RTc55U91nrN5m9enq5AQ35rDH1u2moqmMPhgetvBwGWv
         prsVKJtfiCJLQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D6E9640468; Fri,  6 Jan 2023 14:44:51 -0300 (-03)
Date:   Fri, 6 Jan 2023 14:44:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Leo Yan <leo.yan@linaro.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: [BUG] perf kmem: Broken because of missing tracepoints
Message-ID: <Y7heE/e+g9IbefmO@kernel.org>
References: <b5f82509-41d7-7598-6ec2-fcfa74c7ddaa@amd.com>
 <Y7b6cmRE/+5HJLCa@kernel.org>
 <Y7ewMG+0YKp9pgud@leoy-yangtze.lan>
 <c4c5c3cb-f1a8-84ee-0dc8-8be0d63c820d@amd.com>
 <Y7haGk30muVMjRhF@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7haGk30muVMjRhF@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Jan 06, 2023 at 02:27:54PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Jan 06, 2023 at 06:34:32PM +0530, Ravi Bangoria escreveu:
> > On 06-Jan-23 10:52 AM, Leo Yan wrote:
> > > Hi Ravi, Arnaldo,
> > > 
> > > On Thu, Jan 05, 2023 at 01:27:30PM -0300, Arnaldo Carvalho de Melo wrote:
> > >> Em Thu, Jan 05, 2023 at 07:03:25PM +0530, Ravi Bangoria escreveu:
> > >>> Hello,
> > >>>
> > >>> Two tracepoints, kmem:kmalloc_node and kmem:kmem_cache_alloc_node used by perf-
> > >>> kmem tool were removed from kernel by commit 11e9734bcb6a7 ("mm/slab_common:
> > >>> unify NUMA and UMA version of tracepoints"). This causes issue while running
> > >>> perf kmem on latest kernel:
> > >>>
> > >>>   $ sudo ./perf kmem record
> > >>>   event syntax error: 'kmem:kmalloc_node'
> > >>>                        \___ unknown tracepoint
> > >>>
> > >>>   $ sudo ./perf kmem record
> > >>>   event syntax error: 'kmem:kmem_cache_alloc_node'
> > >>>                        \___ unknown tracepoint
> > >>>
> > >>> Haven't got a chance to debug further. Anyone aware of this?
> > >>
> > >> I didn't notice this so far, would be good to have a fix soon.
> > > 
> > > I looked a bit for the issue, so wrote a fix and verified on my
> > > Arm64 machine.  Please let me know if this works for you or not,
> > > thanks!
> > > 
> > > From b7d26f5543401924ae4ad93daeba66cd7d58eb39 Mon Sep 17 00:00:00 2001
> > > From: Leo Yan <leo.yan@linaro.org>
> > > Date: Fri, 6 Jan 2023 11:16:27 +0800
> > > Subject: [PATCH] perf kmem: Fix tracepoints breakage
> > > 
> > > Commit 11e9734bcb6a ("mm/slab_common: unify NUMA and UMA version of
> > > tracepoints") removed tracepoints 'kmalloc_node' and
> > > 'kmem_cache_alloc_node'; the tracepoints 'kmalloc'
> > > and 'kmem_cache_alloc' add an extra field 'node' to present the
> > > memory node to be allocated and replace the two removed tracepoints
> > > respectively.
> > > 
> > > The commit introduces ABI breakage, both for the dropped tracepoints and
> > > for the updated tracepoints.
> > > 
> > > To fix this issue, perf tool removes the support for the tracepoints
> > > 'kmalloc_node' and 'kmem_cache_alloc_node'; for the two updated
> > > tracepoints this patch reads out the new field 'node', if its value is
> > > NUMA_NO_NODE (-1), we doesn't take it as a cross memory allocation.
> > > 
> > > Reported-by: Ravi Bangoria <ravi.bangoria@amd.com>
> > > Fixes: 11e9734bcb6a ("mm/slab_common: unify NUMA and UMA version of tracepoints")

But I'm removing this Fixes: tag (leaving the reference in the 1st
commit log message paragraph tho), and removing the term "ABI", as AFAIK
tracepoints can change and tools have to adapt, right?

Lemme see...

Documentation/bpf/bpf_design_QA.rst

Q: Are tracepoints part of the stable ABI?
------------------------------------------
A: NO. Tracepoints are tied to internal implementation details hence they are
subject to change and can break with newer kernels. BPF programs need to change
accordingly when this happens.

---



> > > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > 
> > Thanks Leo. A quick test shows it fixes the issue.
> > 
> > Tested-by: Ravi Bangoria <ravi.bangoria@amd.com>
> 
> Thanks, applied.

And I retract that, we need to query for the existence of these
tracepoints and use it if available, as we expect a new perf tool to
work on an older kernel, one where the removed tracepoints may be
available.

Leo, can you try to rework this?

If you look at tools/perf/builtin-sched.c it queries for the existence
of:

static bool schedstat_events_exposed(void)
{
        /*
         * Select "sched:sched_stat_wait" event to check
         * whether schedstat tracepoints are exposed.
         */
        return IS_ERR(trace_event__tp_format("sched", "sched_stat_wait")) ?
                false : true;
}

        /*
         * The tracepoints trace_sched_stat_{wait, sleep, iowait}
         * are not exposed to user if CONFIG_SCHEDSTATS is not set,
         * to prevent "perf sched record" execution failure, determine
         * whether to record schedstat events according to actual situation.
         */
        const char * const schedstat_args[] = {
                "-e", "sched:sched_stat_wait",
                "-e", "sched:sched_stat_sleep",
                "-e", "sched:sched_stat_iowait",
        };
        unsigned int schedstat_argc = schedstat_events_exposed() ?
                ARRAY_SIZE(schedstat_args) : 0;

So its something along those lines.

Thanks,

- Arnaldo
