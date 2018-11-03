From: Xin Long <lucien.xin@gmail.com>
Subject: Re: perf script doesn't dump a normal call trace
Date: Sat, 3 Nov 2018 18:36:21 +0900
Message-ID: <CADvbK_cr_vhtyaid=xbECdNs+xCr4Oi8pJJc83jZa+XJOWAjJw@mail.gmail.com>
References: <CADvbK_dNN34=5V3qtk3_vBzKNts55ACR4c-erPafgNuAQ-eRuw@mail.gmail.com>
 <20181102102616.GC5458@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181102102616.GC5458@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On Fri, Nov 2, 2018 at 7:26 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Nov 02, 2018 at 03:36:13PM +0900, Xin Long wrote:
> > On upstream kernel(4.19) or RHEL-8 kernel(4.18.0):
> >
> > # perf record -e 'skb:consume_skb' -ag
> > ^C[ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.612 MB perf.data (634 samples) ]
> >
> > # perf script
> > swapper     0 [009] 274370.117711: skb:consume_skb: skbaddr=0xffff962c591d5b00
> >         ffffffffa4abe534 consume_skb+0x64 ([kernel.kallsyms])
> >
> > kworker/9:1-eve   926 [009] 274370.117729: skb:consume_skb:
> > skbaddr=0xffff962c591d5b00
> >         ffffffffa4abe534 consume_skb+0x64 ([kernel.kallsyms])
> >
> > kworker/9:1-eve   926 [009] 274370.117732: skb:consume_skb:
> > skbaddr=0xffff962c591d4900
> >         ffffffffa4abe534 consume_skb+0x64 ([kernel.kallsyms])
> >
> > swapper     0 [009] 274370.145528: skb:consume_skb: skbaddr=0xffff962c591d4900
> >         ffffffffa4abe534 consume_skb+0x64 ([kernel.kallsyms])
> >
> > kworker/9:1-eve   926 [009] 274370.145545: skb:consume_skb:
> > skbaddr=0xffff962c591d4900
> >         ffffffffa4abe534 consume_skb+0x64 ([kernel.kallsyms])
> >
> > kworker/9:1-eve   926 [009] 274370.145547: skb:consume_skb:
> > skbaddr=0xffff962c591d5b00
> >         ffffffffa4abe534 consume_skb+0x64 ([kernel.kallsyms])
> >
> > swapper     0 [009] 274370.173443: skb:consume_skb: skbaddr=0xffff962c591d5b00
> >         ffffffffa4abe534 consume_skb+0x64 ([kernel.kallsyms])
>
> I can see that on upstream as well, probably something within
> tracepoint entry code, because I have it working nicely when
> from kprobe, like:
>
> [root@ibm-x3650m4-02 perf]# ./perf probe 'consume_skb'
> [root@ibm-x3650m4-02 perf]# ./perf record -g -e probe:consume_skb* -aR ^C
>
Thanks Jiri,

My debugging script is using tracepoint with some filters which I
don't think probe can support.
Any one have fixes for this tracepoint issue?
