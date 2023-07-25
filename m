Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C330C001DF
	for <linux-perf-users@archiver.kernel.org>; Tue, 25 Jul 2023 20:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjGYUNi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 25 Jul 2023 16:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjGYUNh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 25 Jul 2023 16:13:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D4B19AD;
        Tue, 25 Jul 2023 13:13:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD3B7616A3;
        Tue, 25 Jul 2023 20:13:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9279C433C7;
        Tue, 25 Jul 2023 20:13:33 +0000 (UTC)
Date:   Tue, 25 Jul 2023 16:13:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ze Gao <zegao2021@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Subject: Re: [RFC PATCH 1/3] sched, tracing: report task state in symbolic
 chars instead
Message-ID: <20230725161332.34ba912a@rorschach.local.home>
In-Reply-To: <20230725133100.GL3765278@hirez.programming.kicks-ass.net>
References: <20230725072254.32045-1-zegao@tencent.com>
        <20230725072254.32045-2-zegao@tencent.com>
        <20230725083357.GA3765278@hirez.programming.kicks-ass.net>
        <CAD8CoPAdRUxk3FWdNX6g0V6Kdr3+sXv8fdQ9NhgKUR29-ZLaug@mail.gmail.com>
        <20230725133100.GL3765278@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, 25 Jul 2023 15:31:00 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > > This is a format change and will likely break a ton of programs :/  
> >   
> 
> > BTW, could you help to point to any possible tools/programs that would
> > break other than perf/libtraceevent, because these two are the only
> > users I run into so far.  
> 
> Latencytop was the one breaking a few years ago, but there's a metric
> ton of sched_switch users out there, this is bound to generate pain.
> 
> Steve, you remember what the status of all this was? at the time
> breaking this was considered on par with ABI breakage and we reverted or
> something. Is this still so?

I did reply to the patch (before I switched to thread mode, and notice
that there were already replies ;-)

Pretty much all the tools have been switched over to libtraceevent, but
some just copied the code internally. Although, newer code (like
rasdaemon) are moving over to the newer shared library. Anyway, I did
post a possibly solution in my other email.

-- Steve
