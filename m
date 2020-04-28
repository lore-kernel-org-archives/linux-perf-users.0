From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 7/7] perf record: Introduce --switch-output-event
Date: Tue, 28 Apr 2020 15:22:57 +0200
Message-ID: <20200428132257.GH1476763@krava>
References: <20200427211935.25789-1-acme@kernel.org>
 <20200427211935.25789-8-acme@kernel.org>
 <20200428094839.GD1476763@krava>
 <20200428121601.GB2245@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200428121601.GB2245@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Song Liu <songliubraving@fb.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

On Tue, Apr 28, 2020 at 09:16:01AM -0300, Arnaldo Carvalho de Melo wrote:

SNIP

> > > +				pr_err("Couldn't create side band evlist.\n.");
> > > +				goto out_child;
> > > +			}
> > >  		}
> > >  
> > >  		if (evlist__add_bpf_sb_event(rec->sb_evlist, &session->header.env)) {
> > 
> > it's getting bigger, I wonder we should put all the sb_* setup in
> > separated functions like sb_start/sb_stop
> 
> Well, the rec->thread_id = pthread_self(); part is just for reusing a
> 'perf record' specific mechanism, what to do when the event appears in
> the side band thread ring buffer, the evlist__set_cb() also is related
> to that, moving thread_id to evlist seems too much at this time.

hum, I meant record specific static functions sb_start/sb_stop,
not inside evlist.. just to have it separated

> 
> > > @@ -2179,10 +2199,19 @@ static int switch_output_setup(struct record *rec)
> > >  	};
> > >  	unsigned long val;
> > >  
> > > +	/*
> > > +	 * If we're using --switch-output-events, then we imply its 
> > > +	 * --switch-output=signal, as we'll send a SIGUSR2 from the side band
> > > +	 *  thread to its parent.
> > > +	 */
> > > +	if (rec->sb_evlist != NULL)
> > > +		goto do_signal;
> > > +
> > >  	if (!s->set)
> > >  		return 0;
>  
> > hum, it looks like this jump is not necessay and can be avoided
> > by some bool checks.. could we add some bool when --switch-output-event
> > is used, so we don't depend on wether rec->sb_evlist was allocated for
> > whatever reason?
> 
> If rec->sb_evlist is NULL, then there was no --switch-output-event
> passed... The only advantage in adding the complexity below would be if
> we had rec->switch_output_event_set which would clarify that sb_evlist
> is not used only for --switch-output-event, to make things clearer.
> 
> And this still leaves us with the jump, otherwise we would have to test
> it twice, right?

still I like the idea of checking bool twice then adding jumps

> 
> I think I'll separate the patch adding OPT_CALLBACK_SET(), then fold the
> switch_output_event_set addition to builtin-record, ok?

ok, or set the bool directly in the callback, both works for me ;-)

thanks,
jirka
