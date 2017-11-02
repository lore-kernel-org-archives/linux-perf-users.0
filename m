From: Bram Stolk <b.stolk@gmail.com>
Subject: Re: Adding a recording delay interferes with symbols/call-stack
Date: Thu, 2 Nov 2017 00:01:24 -0700
Message-ID: <CABYXEksfK4CwgrogBZ=EZWQubOWb8UDxzw22o_pH3TQmmk6Htg@mail.gmail.com>
References: <CABYXEksdehm6S9-WGO6MV1wQaWHCsk-Ofp-sDaxY+qwQSNPp8Q@mail.gmail.com>
 <20171031142537.GT7045@kernel.org> <CABYXEktUSaLrT4Ajp17D4i93o1Sia+Jd5vpSAydEPNOw6nTFiA@mail.gmail.com>
 <20171031191411.GB3531@kernel.org> <CABYXEktgnCoc7tTzeOaT-e=ggYPAVHRk=R2tc64NgCtphL1-aw@mail.gmail.com>
 <20171102062052.GB23303@sejong>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ua0-f195.google.com ([209.85.217.195]:54924 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751567AbdKBHBZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 2 Nov 2017 03:01:25 -0400
Received: by mail-ua0-f195.google.com with SMTP id n38so3232115uai.11
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Nov 2017 00:01:25 -0700 (PDT)
In-Reply-To: <20171102062052.GB23303@sejong>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, linux-perf-users@vger.kernel.org, kernel-team@lge.com

Thanks Namhyung,

I tried the patch, but still no app symbols:

perf record --delay=1000 --freq 2000 --call-graph dwarf ./bench
...
[ perf record: Woken up 2 times to write data ]
[ perf record: Captured and wrote 0.347 MB perf.data (41 samples) ]

perf report -g 'graph,0.25,callee'
# To display the perf.data header info, please use
--header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 41  of event 'cycles:uppp'
# Event count (approx.): 94489518008269
#
# Children      Self  Command  Shared Object      Symbol
# ........  ........  .......  .................  ..........................
#
    50.11%    50.11%  bench    bench              [.] 0x0000000000010372
     7.13%     7.13%  bench    bench              [.] 0x0000000000010358
     3.56%     3.56%  bench    bench              [.] 0x00000000000127fa
     3.56%     3.56%  bench    libm-2.23.so       [.] 0x00000000000328c3
     3.56%     3.56%  bench    bench              [.] 0x000000000001241d
     3.56%     3.56%  bench    bench              [.] 0x0000000000012121
     3.56%     3.56%  bench    bench              [.] 0x000000000001032d
     3.56%     3.56%  bench    bench              [.] 0x000000000001006e
     3.56%     3.56%  bench    bench              [.] 0x00000000000121b8
     3.56%     3.56%  bench    bench              [.] 0x0000000000012464
     3.56%     3.56%  bench    bench              [.] 0x0000000000012400
     3.56%     3.56%  bench    bench              [.] 0x0000000000010377
     3.56%     3.56%  bench    bench              [.] 0x000000000001008c
     3.56%     3.56%  bench    bench              [.] 0x0000000000010091
     0.00%     0.00%  bench    bench              [.] 0x00000000000124ee
     0.00%     0.00%  bench    bench              [.] 0x000000000000a530
     0.00%     0.00%  bench    bench              [.] 0x0000000000012091
     0.00%     0.00%  bench    bench              [.] 0x000000000001212f
     0.00%     0.00%  bench    bench              [.] 0x000000000000ffff
     0.00%     0.00%  bench    bench              [.] 0x000000000000ff9b
     0.00%     0.00%  bench    bench              [.] 0x000000000001009b
     0.00%     0.00%  bench    bench              [.] 0x0000000000010332
     0.00%     0.00%  bench    bench              [.] 0x00000000000102f0
     0.00%     0.00%  bench    bench              [.] 0x0000000000010368
     0.00%     0.00%  bench    bench              [.] 0x0000000000012113
     0.00%     0.00%  bench    bench              [.] 0x0000000000010068
     0.00%     0.00%  bench    bench              [.] 0x0000000000012419
     0.00%     0.00%  bench    bench              [.] 0x0000000000012431
     0.00%     0.00%  bench    bench              [.] 0x000000000001267f
     0.00%     0.00%  bench    bench              [.] 0x000000000000aea9
     0.00%     0.00%  bench    bench              [.] 0x0000000000012742
     0.00%     0.00%  bench    [kernel.kallsyms]  [.] native_irq_return_iret





On Wed, Nov 1, 2017 at 11:20 PM, Namhyung Kim <namhyung@kernel.org> wrote:
> Hello,
>
> On Tue, Oct 31, 2017 at 09:36:20PM -0700, Bram Stolk wrote:
>> On Tue, Oct 31, 2017 at 12:14 PM, Arnaldo Carvalho de Melo
>> <arnaldo.melo@gmail.com> wrote:
>> > Em Tue, Oct 31, 2017 at 10:10:28AM -0700, Bram Stolk escreveu:
>> >> Thanks for trying to reproduce, Arnaldo.
>> >>
>> >> But for me, it's not the kernel symbols that are missing: they are all
>> >> there, syscalls and stuff.
>> >> Just the app's symbols itself are missing.
>> >>
>> >> What happens if you try it on a binary you built locally, that spends
>> >> cycles in userspace?
>
> The problem is that FORK, COMM and MMAP2 events were not generated for
> the workload given on the command line.  Normally they are generated
> by kernel during exec for this case (target__none).  But initial_delay
> makes the attr->enable_on_exec bit cleared so kernel won't generate
> the evetns for us.  System-wide and existing process cases are not
> affected since they always synthesize the events.
>
> Could you please check below patch solves your problem?
>
> Thanks,
> Namhyung
>
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index f4d9fc54b382..89a192dc235c 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -949,6 +949,14 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>
>         if (opts->initial_delay) {
>                 usleep(opts->initial_delay * USEC_PER_MSEC);
> +
> +               /*
> +                * it did not set attr.enable_on_exec so misses
> +                * task and mmap events.
> +                */
> +               if (target__none(&rec->opts.target))
> +                       record__synthesize_workload(rec, false);
> +
>                 perf_evlist__enable(rec->evlist);
>         }
>



-- 
Owner/Director of Game Studio Abraham Stolk Inc.
Vancouver BC, Canada
b.stolk@gmail.com
