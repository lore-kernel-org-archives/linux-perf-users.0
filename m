From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: Adding a recording delay interferes with symbols/call-stack
Date: Thu, 2 Nov 2017 15:20:52 +0900
Message-ID: <20171102062052.GB23303@sejong>
References: <CABYXEksdehm6S9-WGO6MV1wQaWHCsk-Ofp-sDaxY+qwQSNPp8Q@mail.gmail.com>
 <20171031142537.GT7045@kernel.org>
 <CABYXEktUSaLrT4Ajp17D4i93o1Sia+Jd5vpSAydEPNOw6nTFiA@mail.gmail.com>
 <20171031191411.GB3531@kernel.org>
 <CABYXEktgnCoc7tTzeOaT-e=ggYPAVHRk=R2tc64NgCtphL1-aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEAMRELO13.lge.com ([156.147.23.53]:61000 "EHLO
        lgeamrelo13.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750917AbdKBGUy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 2 Nov 2017 02:20:54 -0400
Content-Disposition: inline
In-Reply-To: <CABYXEktgnCoc7tTzeOaT-e=ggYPAVHRk=R2tc64NgCtphL1-aw@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Bram Stolk <b.stolk@gmail.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, linux-perf-users@vger.kernel.org, kernel-team@lge.com

Hello,

On Tue, Oct 31, 2017 at 09:36:20PM -0700, Bram Stolk wrote:
> On Tue, Oct 31, 2017 at 12:14 PM, Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> > Em Tue, Oct 31, 2017 at 10:10:28AM -0700, Bram Stolk escreveu:
> >> Thanks for trying to reproduce, Arnaldo.
> >>
> >> But for me, it's not the kernel symbols that are missing: they are all
> >> there, syscalls and stuff.
> >> Just the app's symbols itself are missing.
> >>
> >> What happens if you try it on a binary you built locally, that spends
> >> cycles in userspace?

The problem is that FORK, COMM and MMAP2 events were not generated for
the workload given on the command line.  Normally they are generated
by kernel during exec for this case (target__none).  But initial_delay
makes the attr->enable_on_exec bit cleared so kernel won't generate
the evetns for us.  System-wide and existing process cases are not
affected since they always synthesize the events.

Could you please check below patch solves your problem?

Thanks,
Namhyung


diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index f4d9fc54b382..89a192dc235c 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -949,6 +949,14 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 
        if (opts->initial_delay) {
                usleep(opts->initial_delay * USEC_PER_MSEC);
+
+               /*
+                * it did not set attr.enable_on_exec so misses
+                * task and mmap events.
+                */
+               if (target__none(&rec->opts.target))
+                       record__synthesize_workload(rec, false);
+
                perf_evlist__enable(rec->evlist);
        }
 
