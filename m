Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B95FC6FD1D
	for <linux-perf-users@archiver.kernel.org>; Tue,  4 Apr 2023 17:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjDDRHv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 4 Apr 2023 13:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbjDDRHt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 4 Apr 2023 13:07:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482225242;
        Tue,  4 Apr 2023 10:07:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7BAC6275B;
        Tue,  4 Apr 2023 17:07:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16FD6C433EF;
        Tue,  4 Apr 2023 17:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680628049;
        bh=uAg/6YfJ9exiCMZhWLLr52NpllDeXhgQ29NBfLIH7Fw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CuUcKWxVUI3Zs81EX5tsuObCl1OSJZ9QIr6BKpnNGnoyavdTwYhAtJvBw196yAIsM
         JCvhE/t7sy4Bkula8ACdYp87iJTzGu5UyrUb/VWjw6t1vXfJbefoILjkzV1NBQZRqC
         OmYKU54WJYuIwJYZ05Np0Y5t7FQd/Rty8kxALbGfPl4eIR+ub4VEYarPod1xEV4ytv
         hMAxNVF0HiDg03OBG2ZwHASCsCS78rEVtJmsEZ8bB7fXW4glcAvH+9CyqNU2Z0YwTL
         z11rYUdUoTEj7S9pCqHzG321Yg9GurscsPEA1yg5jQv5dVF4Oq00ZcGkGeQfF2O/Og
         04vfOyPidyAqA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B98BD4052D; Tue,  4 Apr 2023 14:07:26 -0300 (-03)
Date:   Tue, 4 Apr 2023 14:07:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        James Clark <james.clark@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hao Luo <haoluo@google.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v5 00/17] Reference count checker and related fixes
Message-ID: <ZCxZTkoQT1Doh//q@kernel.org>
References: <20230320212248.1175731-1-irogers@google.com>
 <CAP-5=fX4=pUmcFpRZ5xFds1awSr7HSo1F9rH4=D7NJXW9OXXVQ@mail.gmail.com>
 <ZCxYLAMrdNyiLVvr@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZCxYLAMrdNyiLVvr@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Apr 04, 2023 at 02:02:36PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Apr 04, 2023 at 08:58:55AM -0700, Ian Rogers escreveu:
> > Ping. It would be nice to have this landed or at least the first 10
> > patches that refactor the map API and are the bulk of the
> > lines-of-code changed. Having those landed would make it easier to
> > rebase in the future, but I also think the whole series is ready to
> > go.
> 
> I'm trying to get it to compile:
> 
>   CC      /tmp/build/perf-tools-next/util/bpf-event.o
> In file included from util/machine.h:7,
>                  from util/session.h:8,
>                  from util/unwind-libunwind-local.c:35:
> util/unwind-libunwind-local.c: In function ‘read_unwind_spec_eh_frame’:
> util/maps.h:29:18: error: assignment to ‘struct map *’ from incompatible pointer type ‘struct map_rb_node *’ [-Werror=incompatible-pointer-types]
>    29 |         for (map = maps__first(maps); map; map = map_rb_node__next(map))
>       |                  ^
> util/unwind-libunwind-local.c:328:9: note: in expansion of macro ‘maps__for_each_entry’
> 
> ⬢[acme@toolbox perf-tools-next]$ git log --oneline -1
> 51a0f26e88c893ac (HEAD) perf maps: Remove rb_node from struct map
> ⬢[acme@toolbox perf-tools-next]$
> 
> I'm also making some changes to reduce the number of patch lines and
> conserve the project 'git blame' usefulness, not changing the logic in
> your patches.

The fix for the above problem demonstrate the changes I made to this
patch, see the

  struct map *map = map_node->map;

Line, to avoid touching the logic right after it.

Now I'm working on this other error:

  CC      /tmp/build/perf-tools-next/util/jitdump.o
  CC      /tmp/build/perf-tools-next/util/bpf-event.o
util/unwind-libunwind.c: In function ‘unwind__get_entries’:
util/unwind-libunwind.c:95:24: error: too few arguments to function ‘ops->get_entries’
   95 |                 return ops->get_entries(cb, arg, thread, data, max_stack);
      |                        ^~~
util/unwind-libunwind.c:90:31: error: unused parameter ‘best_effort’ [-Werror=unused-parameter]
   90 |                          bool best_effort)
      |                               ^
cc1: all warnings being treated as errors
make[4]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:97: /tmp/build/perf-tools-next/util/unwind-libunwind.o] Error 1
make[4]: *** Waiting for unfinished jobs....
  LD      /tmp/build/perf-tools-next/ui/browsers/perf-in.o
  LD      /tmp/build/perf-tools-next/ui/perf-in.o
  LD      /tmp/build/perf-tools-next/util/scripting-engines/perf-in.o
make[3]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:140: util] Error 2
make[2]: *** [Makefile.perf:676: /tmp/build/perf-tools-next/perf-in.o] Error 2
make[1]: *** [Makefile.perf:236: sub-make] Error 2
make: *** [Makefile:113: install-bin] Error 2
make: Leaving directory '/var/home/acme/git/perf-tools-next/tools/perf'

 Performance counter stats for 'make -k BUILD_BPF_SKEL=1 CORESIGHT=1 PYTHON=python3 O=/tmp/build/perf-tools-next -C tools/perf install-bin':

      162599516548      cycles:u
      194726899066      instructions:u                   #    1.20  insn per cycle

       4.991056085 seconds time elapsed

      39.350659000 seconds user
       8.413527000 seconds sys


⬢[acme@toolbox perf-tools-next]$ git log --oneline -1
a95f2d0f62bfd750 (HEAD) perf maps: Add functions to access maps
⬢[acme@toolbox perf-tools-next]$

- Arnaldo
