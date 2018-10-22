From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 2/2] perf script: flush output stream after events in
 verbose mode
Date: Mon, 22 Oct 2018 12:16:18 +0200
Message-ID: <20181022101618.GH2452@krava>
References: <20181021191424.16183-1-milian.wolff@kdab.com>
 <20181021191424.16183-2-milian.wolff@kdab.com>
 <20181022094317.GG2452@krava>
 <4444017.LnbBPIbh24@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4444017.LnbBPIbh24@agathebauer>
Sender: linux-kernel-owner@vger.kernel.org
To: Milian Wolff <milian.wolff@kdab.com>
Cc: acme@kernel.org, jolsa@kernel.org, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Mon, Oct 22, 2018 at 12:09:22PM +0200, Milian Wolff wrote:
> On Montag, 22. Oktober 2018 11:43:17 CEST Jiri Olsa wrote:
> > On Sun, Oct 21, 2018 at 09:14:24PM +0200, Milian Wolff wrote:
> > > When the perf script output is written to a terminal stream,
> > > the normal output of `perf script` would get buffered, but its
> > > debug output would be written directly. This made it quite hard
> > > to figure out where a given debug output is coming from. We can
> > > improve on this by flushing the output buffer after processing an
> > > event. To see the value, compare the following output for a
> > > `perf script -v` run:
> > > 
> > > Before this patch:
> > > ```
> > > unwind: reg 16, val 7faf7dfdc000
> > > unwind: reg 7, val 7ffc80811e30
> > > unwind: find_proc_info dso /usr/lib/ld-2.28.so
> > > unwind: reg 6, val 0
> > > unwind: _start:ip = 0x7faf7dfdc000 (0x2000)
> > > unwind: reg 16, val 7faf7dfdc000
> > > unwind: reg 7, val 7ffc80811e30
> > > unwind: find_proc_info dso /usr/lib/ld-2.28.so
> > > unwind: reg 6, val 0
> > > unwind: _start:ip = 0x7faf7dfdc000 (0x2000)
> > > unwind: reg 16, val 7faf7dfdc000
> > > unwind: reg 7, val 7ffc80811e30
> > > unwind: find_proc_info dso /usr/lib/ld-2.28.so
> > > unwind: reg 6, val 0
> > > unwind: _start:ip = 0x7faf7dfdc000 (0x2000)
> > > unwind: reg 16, val 7faf7dfdc000
> > > unwind: reg 7, val 7ffc80811e30
> > > ... lots and lots of verbose debug output
> > > 
> > > cpp-inlining 24617 90229.122036534:          1 cycles:uppp:
> > >             7faf7dfdc000 _start+0x0 (/usr/lib/ld-2.28.so)
> > > 
> > > cpp-inlining 24617 90229.122043974:          1 cycles:uppp:
> > >             7faf7dfdc000 _start+0x0 (/usr/lib/ld-2.28.so)
> > > 
> > > ...
> > > ```
> > > 
> > > After this patch:
> > > ```
> > > ...
> > > unwind: reg 16, val 7faf7dfdc000
> > > unwind: reg 7, val 7ffc80811e30
> > > unwind: find_proc_info dso /usr/lib/ld-2.28.so
> > > unwind: reg 6, val 0
> > > unwind: _start:ip = 0x7faf7dfdc000 (0x2000)
> > > 
> > > cpp-inlining 24617 90229.122036534:          1 cycles:uppp:
> > >             7faf7dfdc000 _start+0x0 (/usr/lib/ld-2.28.so)
> > > 
> > > unwind: reg 16, val 7faf7dfdc000
> > > unwind: reg 7, val 7ffc80811e30
> > > unwind: find_proc_info dso /usr/lib/ld-2.28.so
> > > unwind: reg 6, val 0
> > > unwind: _start:ip = 0x7faf7dfdc000 (0x2000)
> > > 
> > > cpp-inlining 24617 90229.122043974:          1 cycles:uppp:
> > >             7faf7dfdc000 _start+0x0 (/usr/lib/ld-2.28.so)
> > > 
> > > ...
> > > ```
> > > 
> > > This new output format makes it much easier to use perf script
> > > output for debugging purposes, e.g. to investigate broken dwarf
> > > unwinding.
> > 
> > yep, I plan to check on this ;-)
> > 
> > > Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
> > > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > ---
> > > 
> > >  tools/perf/builtin-script.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > > index bd468b90801b..ca09b7d2adb7 100644
> > > --- a/tools/perf/builtin-script.c
> > > +++ b/tools/perf/builtin-script.c
> > > @@ -1737,6 +1737,9 @@ static void process_event(struct perf_script
> > > *script,
> > > 
> > >  	if (PRINT_FIELD(METRIC))
> > >  	
> > >  		perf_sample__fprint_metric(script, thread, evsel, sample, fp);
> > > 
> > > +
> > > +	if (verbose)
> > > +		fflush(fp);
> > 
> > should we call fflush(NULL) to dump all the streams?
> > 
> > the verbose goes to stderr and fp seems to be stdout byt default
> 
> stderr isn't buffered, so we don't need to flush it. So personally, I don't 
> see a need to dump all streams - fp should be enough? Can you maybe explain 
> where it would be required to flush more buffers?

hum, did not know stderr wasn't buffer

I think there's perf script feature to store the events data to
separate files per each event.. but I guess we don't need to
flush them.. we just need to have stdout and stderr in sync IIUC

jirka
