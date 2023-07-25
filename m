Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B623C001DF
	for <linux-perf-users@archiver.kernel.org>; Tue, 25 Jul 2023 21:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjGYVzn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 25 Jul 2023 17:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjGYVzm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 25 Jul 2023 17:55:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EF51FE6;
        Tue, 25 Jul 2023 14:55:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9E2F61908;
        Tue, 25 Jul 2023 21:55:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C667CC433C7;
        Tue, 25 Jul 2023 21:55:38 +0000 (UTC)
Date:   Tue, 25 Jul 2023 17:55:36 -0400
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
Message-ID: <20230725175536.5449807c@rorschach.local.home>
In-Reply-To: <20230725201603.GB3784071@hirez.programming.kicks-ass.net>
References: <20230725072254.32045-1-zegao@tencent.com>
        <20230725072254.32045-2-zegao@tencent.com>
        <20230725135938.1e056a02@rorschach.local.home>
        <20230725201603.GB3784071@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, 25 Jul 2023 22:16:03 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > Now, because the old tools still do the parsing of this format, we can
> > add a new field called prev_state_char that will give you this. Now to
> > save space, we should change prev_state to int (can't make it short as
> > there's that test for "+" which does sometimes happen). I believe we
> > can make prev_prio and next prio into shorts (and possibly chars!).  
> 
> Or just leave the thing alone?

Sure, but I would like to change the fields to smaller ones just so
that the event wastes less space on the buffer.

-- Steve
