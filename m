Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D6FC636C8
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 20:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEBBE613DA
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 20:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhGOUqz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 16:46:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:60794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230209AbhGOUqy (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 16:46:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC301613D4;
        Thu, 15 Jul 2021 20:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626381840;
        bh=W8ev9GZ6BGfozC2HPh3Bg7OOO89HihDLI5lIuHJhVPw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hkEBJ+TWuTzIQNgmU7cFqtIOU7GQw9mJXKDw9NNjxk3wI0OcEl2evkIpxIBbl1NRU
         Ctfz42Ul7wXm8oWopz82qjDXaGcYdhFi0fkOYlmE5/z2Fv5Nbe30YE6+0ltlsvOXMQ
         mFs/hnFh3tp059AdosVzYKyPhLcmvcXoo2HNNp9UnLdiX4ZXVBRQbXEjJxYc45vrvY
         o0bQdt4UdlPEuDHKd10WH8zN/lmvJKC2YS7nGX7pisbzgZdW5mZg7d2ZS/yis2AusZ
         cP0PjFnobH3WgTg4fCPBijzJK7skTSJqV7r1ZrUPU/kSVgM4B+PWHDS15WAnUvwW/I
         /afrq8+csUTXQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2E0CC403F2; Thu, 15 Jul 2021 17:43:58 -0300 (-03)
Date:   Thu, 15 Jul 2021 17:43:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Subject: Re: [RFC PATCH 03/10] perf workqueue: add threadpool start and stop
 functions
Message-ID: <YPCeDjYxVHXSInZJ@kernel.org>
References: <cover.1626177381.git.rickyman7@gmail.com>
 <118c988358322b9daf69aeb98ff8986748b0dad2.1626177381.git.rickyman7@gmail.com>
 <YO7/n4YAy/R08Wss@kernel.org>
 <b758e519c0fe1336ce01d741b2340734faac7af2.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b758e519c0fe1336ce01d741b2340734faac7af2.camel@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Jul 15, 2021 at 06:42:16PM +0200, Riccardo Mancini escreveu:
> Hi Arnaldo,
> 
> On Wed, 2021-07-14 at 12:15 -0300, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Jul 13, 2021 at 02:11:14PM +0200, Riccardo Mancini escreveu:
> > > +++ b/tools/perf/util/workqueue/threadpool.c
> > > @@ -4,12 +4,23 @@
> > >  #include <unistd.h>
> > >  #include <errno.h>
> > >  #include <string.h>
> > > +#include <pthread.h>
> > > +#include <signal.h>
> > > +#include <syscall.h>
> > >  #include "debug.h"
> > >  #include "asm/bug.h"
> > >  #include "threadpool.h"
> > >  
> > > +#ifndef HAVE_GETTID
> > > +static inline pid_t gettid(void)
> > > +{
> > > +       return (pid_t)syscall(__NR_gettid);
> > > +}
> > > +#endif

> > Isn't this defined elsewhere? Yeah, when we decide to move it to
> > tools/lib/workqueue/ we'll need it, but for now, reduce patch size.
 
> No, it's just statically defined in tools/perf/jvmti/jvmti_agent.c.
> I saw there is a libc_compat.h header in tools/include/tools, I could put this
> definition there, and remove the one from jvmti_agent.c.

Please, do it as a prep patch.

Thanks,

- Arnaldo
 
