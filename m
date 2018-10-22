From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 2/2] perf script: flush output stream after events in
 verbose mode
Date: Mon, 22 Oct 2018 14:25:56 -0300
Message-ID: <20181022172556.GM3849@kernel.org>
References: <20181021191424.16183-1-milian.wolff@kdab.com>
 <4444017.LnbBPIbh24@agathebauer>
 <20181022101618.GH2452@krava>
 <1755624.MxyOU8z0WO@agathebauer>
 <20181022135430.GA2945@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181022135430.GA2945@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Milian Wolff <milian.wolff@kdab.com>, jolsa@kernel.org, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Mon, Oct 22, 2018 at 03:54:30PM +0200, Jiri Olsa escreveu:
> On Mon, Oct 22, 2018 at 12:38:57PM +0200, Milian Wolff wrote:
> 
> SNIP
> 
> > > > > > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > > > > > index bd468b90801b..ca09b7d2adb7 100644
> > > > > > --- a/tools/perf/builtin-script.c
> > > > > > +++ b/tools/perf/builtin-script.c
> > > > > > @@ -1737,6 +1737,9 @@ static void process_event(struct perf_script
> > > > > > *script,
> > > > > > 
> > > > > >  	if (PRINT_FIELD(METRIC))
> > > > > >  	
> > > > > >  		perf_sample__fprint_metric(script, thread, evsel, 
> > sample, fp);
> > > > > > 
> > > > > > +
> > > > > > +	if (verbose)
> > > > > > +		fflush(fp);
> > > > > 
> > > > > should we call fflush(NULL) to dump all the streams?
> > > > > 
> > > > > the verbose goes to stderr and fp seems to be stdout byt default
> > > > 
> > > > stderr isn't buffered, so we don't need to flush it. So personally, I
> > > > don't
> > > > see a need to dump all streams - fp should be enough? Can you maybe
> > > > explain
> > > > where it would be required to flush more buffers?
> > > 
> > > hum, did not know stderr wasn't buffer
> > >
> > > I think there's perf script feature to store the events data to
> > > separate files per each event.. but I guess we don't need to
> > > flush them.. we just need to have stdout and stderr in sync IIUC
> > 
> > Exactly, and that's achieved with this patch form what I see :) Or should we 
> > maybe instead call 
> > 
> > setbuf(fp, NULL);
> > 
> > in verbose mode?
> 
> I think your solution is ok
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo
