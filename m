From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: eBPF program symbols in perf top
Date: Wed, 28 Nov 2018 10:04:38 -0300
Message-ID: <20181128130438.GB31608@kernel.org>
References: <CANWdNRAD2XBnztZN760mOX+LfXY_uAvsRqEnkTJnqwrZCBK92w@mail.gmail.com>
 <20181127133054.GE15747@kernel.org>
 <CANWdNRDdSMeQ1RHpHMoG7-aRVjufG79jyrZqYqho2_3gX3hrfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANWdNRDdSMeQ1RHpHMoG7-aRVjufG79jyrZqYqho2_3gX3hrfw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivan Babrou <ibobrik@gmail.com>
Cc: arnaldo.melo@gmail.com, linux-perf-users@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org, davem@davemloft.net, dsahern@gmail.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

Em Tue, Nov 27, 2018 at 11:41:19PM -0800, Ivan Babrou escreveu:
> Hey Arnaldo,
> 
> Thanks for the quick response. I've tried your patch and it works as
> expected with perf top.

Ok, I'll add the patch to my perf/core branch with your Reported-by and
Tested-by, is that ok with you?
 
> What are the reasons for not giving kallsyms precedence at this moment?

The use of vmlinux for these things predates having many of the code
modifications that are performed in a live kernel these days, also
pre-dates eBPF, etc, etc, so using vmlinux, when found, was better
because ELF symtabs are more expressive, kallsyms have just the start of
a symbol, for instance, etc.

Having that said, with the advent of things like Intel PT, etc using
/proc/kcore + /proc/kallsyms became a requirement, there is even code to
stash copies of those in ~/.debug/ for post processing (off-site using
'perf archive' even, etc).

I _think_ that switch to using /proc/kallsyms as default now is becoming
a requirement, just haven't thought thru all possible implications of
doing that.

I don't recall if there is a way to set kallsyms precedence in
~/.perfconfig, have to look at that.

- Arnaldo

> On Tue, Nov 27, 2018 at 5:30 AM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> > Em Mon, Nov 26, 2018 at 04:21:15PM -0800, Ivan Babrou escreveu:
> > > It's possible to see eBPF programs in "perf report" and "perf script"
> > > started with "--kallsyms=/proc/kallsyms", if net.core.bpf_jit_kallsyms
> > > sysctl is set to 1. However, it's not possible to pass "--kallsyms" to
> > > "perf top".
> >
> >
> > So, the first step, I think, is to check if having 'perf top
> > --kallsyms=..." would help, i.e. to check the patch that introduced
> > '--kallsyms' to 'perf report' and see if that would be difficult to have
> > the same functionality in 'perf top', the cset where it is introduced
> > is:
> >
> >   b226a5a72901b ("perf report: Allow user to specify path to kallsyms file"
> >
> > Below is the resulting patch, can you please check if with that you get
> > the result you want? We can then go from there to some simplification,
> > perhaps give precedence to kallsyms.
> >
> > diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
> > index 808b664343c9..44d89fb9c788 100644
> > --- a/tools/perf/Documentation/perf-top.txt
> > +++ b/tools/perf/Documentation/perf-top.txt
> > @@ -70,6 +70,9 @@ Default is to monitor all CPUS.
> >  --ignore-vmlinux::
> >         Ignore vmlinux files.
> >
> > +--kallsyms=<file>::
> > +       kallsyms pathname
> > +
> >  -m <pages>::
> >  --mmap-pages=<pages>::
> >         Number of mmap data pages (must be a power of two) or size
> > diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> > index aa0c73e57924..1252d1759064 100644
> > --- a/tools/perf/builtin-top.c
> > +++ b/tools/perf/builtin-top.c
> > @@ -1289,6 +1289,8 @@ int cmd_top(int argc, const char **argv)
> >                    "file", "vmlinux pathname"),
> >         OPT_BOOLEAN(0, "ignore-vmlinux", &symbol_conf.ignore_vmlinux,
> >                     "don't load vmlinux even if found"),
> > +       OPT_STRING(0, "kallsyms", &symbol_conf.kallsyms_name,
> > +                  "file", "kallsyms pathname"),
> >         OPT_BOOLEAN('K', "hide_kernel_symbols", &top.hide_kernel_symbols,
> >                     "hide kernel symbols"),
> >         OPT_CALLBACK('m', "mmap-pages", &opts->mmap_pages, "pages",

-- 

- Arnaldo
