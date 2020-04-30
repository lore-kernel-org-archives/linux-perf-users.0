From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH 3/8] perf bpf: Decouple creating the evlist from adding
 the SB event
Date: Thu, 30 Apr 2020 10:39:34 -0300
Message-ID: <20200430133934.GL30487@kernel.org>
References: <20200429131106.27974-1-acme@kernel.org>
 <20200429131106.27974-4-acme@kernel.org>
 <20200430090423.GD1681583@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200430090423.GD1681583@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Song Liu <songliubraving@fb.com>
List-Id: linux-perf-users.vger.kernel.org

Em Thu, Apr 30, 2020 at 11:04:23AM +0200, Jiri Olsa escreveu:
> On Wed, Apr 29, 2020 at 10:11:01AM -0300, Arnaldo Carvalho de Melo wrote:
> 
> SNIP
> 
> > -int perf_evlist__add_sb_event(struct evlist **evlist,
> > +int perf_evlist__add_sb_event(struct evlist *evlist,
> >  			      struct perf_event_attr *attr,
> >  			      perf_evsel__sb_cb_t cb,
> >  			      void *data)
> >  {
> >  	struct evsel *evsel;
> > -	bool new_evlist = (*evlist) == NULL;
> > -
> > -	if (*evlist == NULL)
> > -		*evlist = evlist__new();
> > -	if (*evlist == NULL)
> > -		return -1;
> >  
> >  	if (!attr->sample_id_all) {
> >  		pr_warning("enabling sample_id_all for all side band events\n");
> >  		attr->sample_id_all = 1;
> >  	}
> >  
> > -	evsel = perf_evsel__new_idx(attr, (*evlist)->core.nr_entries);
> > +	evsel = perf_evsel__new_idx(attr, evlist->core.nr_entries);
> >  	if (!evsel)
> >  		goto out_err;
> 
> we can return -1 right here

Yeah, I was just trying to keep the patch minimal, I'll remove the
out_err label and the goto to it and call return directly,

Thanks,

- Arnaldo
 
> jirka
> 
> >  
> >  	evsel->side_band.cb = cb;
> >  	evsel->side_band.data = data;
> > -	evlist__add(*evlist, evsel);
> > +	evlist__add(evlist, evsel);
> >  	return 0;
> > -
> >  out_err:
> > -	if (new_evlist) {
> > -		evlist__delete(*evlist);
> > -		*evlist = NULL;
> > -	}
> >  	return -1;
> >  }
> >  
> > diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> > index f5bd5c386df1..0f02408fff3e 100644
> > --- a/tools/perf/util/evlist.h
> > +++ b/tools/perf/util/evlist.h
> > @@ -107,7 +107,7 @@ int __perf_evlist__add_default_attrs(struct evlist *evlist,
> >  
> >  int perf_evlist__add_dummy(struct evlist *evlist);
> >  
> > -int perf_evlist__add_sb_event(struct evlist **evlist,
> > +int perf_evlist__add_sb_event(struct evlist *evlist,
> >  			      struct perf_event_attr *attr,
> >  			      perf_evsel__sb_cb_t cb,
> >  			      void *data);
> > -- 
> > 2.21.1
> > 
> 

-- 

- Arnaldo
