From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: perf script doesn't dump a normal call trace
Date: Mon, 5 Nov 2018 09:49:06 +0100
Message-ID: <20181105084906.GA30951@krava>
References: <CADvbK_dNN34=5V3qtk3_vBzKNts55ACR4c-erPafgNuAQ-eRuw@mail.gmail.com>
 <20181102102616.GC5458@krava>
 <CADvbK_cr_vhtyaid=xbECdNs+xCr4Oi8pJJc83jZa+XJOWAjJw@mail.gmail.com>
 <20181104191754.GB18517@krava>
 <CADvbK_cgp7S-8Q-6GArwViCDBhCoB9LcZvJaGM6QFAg9qNOeHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CADvbK_cgp7S-8Q-6GArwViCDBhCoB9LcZvJaGM6QFAg9qNOeHw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xin Long <lucien.xin@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On Mon, Nov 05, 2018 at 03:20:15PM +0900, Xin Long wrote:

SNIP

> > > > [root@ibm-x3650m4-02 perf]# ./perf probe 'consume_skb'
> > > > [root@ibm-x3650m4-02 perf]# ./perf record -g -e probe:consume_skb* -aR ^C
> > > >
> > > Thanks Jiri,
> > >
> > > My debugging script is using tracepoint with some filters which I
> > > don't think probe can support.
> > > Any one have fixes for this tracepoint issue?
> >
> > trying to bisect that.. looks like orc code issue,
> > it works for me when you switch to fp unwind:
> >   CONFIG_UNWINDER_FRAME_POINTER
> >
> 
> That's a good workaround, thanks.
> 
> Another problem is when I'm using perf built manually from upstream kernel tree,
> I couldn't see the function's names.
> # perf --version
> perf version 4.19.g26f1de
> 
> # perf report -T
> # To display the perf.data header info, please use
> --header/--header-only options.
> #
> #
> # Total Lost Samples: 0
> #
> # Samples: 97  of event 'probe:consume_skb'
> # Event count (approx.): 97
> #
> # Children      Self  Trace output
> # ........  ........  ..................
> #
>    100.00%   100.00%  (ffffffff86f090f0)
>             |
>             |--93.81%--0xffffffff868000e6
>             |          0xffffffff8684ed7f
>             |          0xffffffff868e97ad
>             |          0xffffffff868e953a
>             |          0xffffffff87087623
>             |          0xffffffff8682a06f
>             |          0xffffffff870872ad
>             |          |
>             |          |--89.69%--0xffffffff8720098f
>             |          |          0xffffffff87201b69
>             |          |          0xffffffff868b9c2e
> 
> 
> The below is with rhel7's perf
> # perf --version
> perf version 3.10.0-957.el7.x86_64.debug
> # perf report -T
> # To display the perf.data header info, please use
> --header/--header-only options.
> #
> #
> # Total Lost Samples: 0
> #
> # Samples: 97  of event 'probe:consume_skb'
> # Event count (approx.): 97
> #
> # Children      Self  Trace output
> # ........  ........  ..................
> #
>    100.00%   100.00%  (ffffffff86f090f0)
>             |
>             |--93.81%--0x2000e6
>             |          start_secondary
>             |          cpu_startup_entry
>             |          do_idle
>             |          default_idle_call
>             |          arch_cpu_idle
>             |          default_idle
>             |          |
>             |          |--89.69%--ret_from_intr
>             |          |          do_IRQ
>             |          |          irq_exit

I think that's already fixed on Arnaldo's perf/urgent branch,
  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git

but perhaps this post as well:
  https://lore.kernel.org/lkml/20181031091043.23465-1-adrian.hunter@intel.com/

please give it a try.. it should be merged in soon

jirka
