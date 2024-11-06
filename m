Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E3320126B;
	Wed,  6 Nov 2024 14:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730904611; cv=none; b=t9faB3CtO+8ebJgLJLcyAWIQNYLO7gSlh2CxBBAW5em8H6LCuOYVC6TlWqRt0PRLL7d07qUSERY6pE4Lvsy/4a7pS2KxVBpckuDfk/PFNSx7k1FWlibPvrpQa043ZfHb1SPYN5yb/QHPizFEpwK9pYzqfycONtOyT0EEte+7wIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730904611; c=relaxed/simple;
	bh=pafdbCKJ4T0X9ew4LkODpKKyd/czMwM+QSMDM1Wv1xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OY7A5JyNtyJnx68zHXEhhduVQDbhenxi8nkBhPhXm2woWijWdHinw0WN43fwNtcrZP208xaFW6aKfNGkaSUeS2JBKenjLKZSOrCOh8Gc+mnK6coMb8AivbOMIoQfnh5/TIlzpWesX3zukUPZN40vOafbyydNnOCQrvzC3Alr3xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=ppsfjl+v; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="ppsfjl+v"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=48SrrvM08TEZKc3LzQPWlbvvtC60XKoMO5KYeMToqlI=; b=ppsfjl+vksFmgwWr
	XvHipSjpAP6g+RGH9s0bJ0d/+MFrcZm/u/TE3jnsO0zbLa/K1QBPcGqT5R++vbkZLsvO9Dk5rGdHf
	2DxPH4BMuIus5cnUcHj7Sj57cSIsVVdCV6iHNHEz7FEFWlQopOrqGlJQekpaGh+0gXy2ss3iA+nWG
	xqPFdvBbImn1cniif05Wd7bcEVR6W5aq5UVGJW3erbNG0/dKUQ6bepuXIq3A0i0e5T2FDuNdEhBkc
	MqFYArCsUkTOu43pyoLWy56m/rPJpyqQ+azkeluerli1QYs43V/KA8HU3XJk1yFi25dJyTWpE2I3X
	bGNxxlWhxJVByuYDtA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1t8hM7-00FoOw-0i;
	Wed, 06 Nov 2024 14:49:59 +0000
Date: Wed, 6 Nov 2024 14:49:59 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: event: Remove deadcode
Message-ID: <ZyuCF3reuIHZjZwp@gallifrey>
References: <20241103142302.230370-1-linux@treblig.org>
 <ZyscLqAzo9Z7Zg02@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <ZyscLqAzo9Z7Zg02@google.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 14:49:36 up 182 days,  2:03,  1 user,  load average: 0.00, 0.01,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Namhyung Kim (namhyung@kernel.org) wrote:
> Hello,
> 
> On Sun, Nov 03, 2024 at 02:23:01PM +0000, linux@treblig.org wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > event_format__print() last use was removed by 2017's
> > commit 894f3f1732cb ("perf script: Use event_format__fprintf()")
> > 
> > evlist__find_tracepoint_by_id() last use was removed by 2012's
> > commit e60fc847cefa ("perf evlist: Remove some unused methods")
> > 
> > evlist__set_tp_filter_pid() last use was removed by 2017's
> > commit dd1a50377c92 ("perf trace: Introduce filter_loop_pids()")
> > 
> > Remove them.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> 
> Unfortunately it doesn't apply to the current perf-tools-next cleanly.
> Can you please rebase?

Done, you should see the v2 as a reply to your message
with id 20241106144826.91728-1-linux@treblig.org

Dave

> Thanks,
> Namhyung
> 
> > ---
> >  tools/perf/util/evlist.c            | 18 ------------------
> >  tools/perf/util/evlist.h            |  2 --
> >  tools/perf/util/trace-event-parse.c |  6 ------
> >  tools/perf/util/trace-event.h       |  3 ---
> >  4 files changed, 29 deletions(-)
> > 
> > diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> > index f14b7e6ff1dc..4b992a3f2985 100644
> > --- a/tools/perf/util/evlist.c
> > +++ b/tools/perf/util/evlist.c
> > @@ -362,19 +362,6 @@ __weak int arch_evlist__add_default_attrs(struct evlist *evlist,
> >  	return __evlist__add_default_attrs(evlist, attrs, nr_attrs);
> >  }
> >  
> > -struct evsel *evlist__find_tracepoint_by_id(struct evlist *evlist, int id)
> > -{
> > -	struct evsel *evsel;
> > -
> > -	evlist__for_each_entry(evlist, evsel) {
> > -		if (evsel->core.attr.type   == PERF_TYPE_TRACEPOINT &&
> > -		    (int)evsel->core.attr.config == id)
> > -			return evsel;
> > -	}
> > -
> > -	return NULL;
> > -}
> > -
> >  struct evsel *evlist__find_tracepoint_by_name(struct evlist *evlist, const char *name)
> >  {
> >  	struct evsel *evsel;
> > @@ -1199,11 +1186,6 @@ int evlist__set_tp_filter_pids(struct evlist *evlist, size_t npids, pid_t *pids)
> >  	return ret;
> >  }
> >  
> > -int evlist__set_tp_filter_pid(struct evlist *evlist, pid_t pid)
> > -{
> > -	return evlist__set_tp_filter_pids(evlist, 1, &pid);
> > -}
> > -
> >  int evlist__append_tp_filter_pids(struct evlist *evlist, size_t npids, pid_t *pids)
> >  {
> >  	char *filter = asprintf__tp_filter_pids(npids, pids);
> > diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> > index bcc1c6984bb5..ff73908e2178 100644
> > --- a/tools/perf/util/evlist.h
> > +++ b/tools/perf/util/evlist.h
> > @@ -144,7 +144,6 @@ int __evlist__set_tracepoints_handlers(struct evlist *evlist,
> >  	__evlist__set_tracepoints_handlers(evlist, array, ARRAY_SIZE(array))
> >  
> >  int evlist__set_tp_filter(struct evlist *evlist, const char *filter);
> > -int evlist__set_tp_filter_pid(struct evlist *evlist, pid_t pid);
> >  int evlist__set_tp_filter_pids(struct evlist *evlist, size_t npids, pid_t *pids);
> >  
> >  int evlist__append_tp_filter(struct evlist *evlist, const char *filter);
> > @@ -152,7 +151,6 @@ int evlist__append_tp_filter(struct evlist *evlist, const char *filter);
> >  int evlist__append_tp_filter_pid(struct evlist *evlist, pid_t pid);
> >  int evlist__append_tp_filter_pids(struct evlist *evlist, size_t npids, pid_t *pids);
> >  
> > -struct evsel *evlist__find_tracepoint_by_id(struct evlist *evlist, int id);
> >  struct evsel *evlist__find_tracepoint_by_name(struct evlist *evlist, const char *name);
> >  
> >  int evlist__add_pollfd(struct evlist *evlist, int fd);
> > diff --git a/tools/perf/util/trace-event-parse.c b/tools/perf/util/trace-event-parse.c
> > index f0332bd3a501..d97830cdbd7e 100644
> > --- a/tools/perf/util/trace-event-parse.c
> > +++ b/tools/perf/util/trace-event-parse.c
> > @@ -116,12 +116,6 @@ void event_format__fprintf(struct tep_event *event,
> >  	trace_seq_destroy(&s);
> >  }
> >  
> > -void event_format__print(struct tep_event *event,
> > -			 int cpu, void *data, int size)
> > -{
> > -	return event_format__fprintf(event, cpu, data, size, stdout);
> > -}
> > -
> >  /*
> >   * prev_state is of size long, which is 32 bits on 32 bit architectures.
> >   * As it needs to have the same bits for both 32 bit and 64 bit architectures
> > diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
> > index bbf8b26bc8da..0e5133f1b910 100644
> > --- a/tools/perf/util/trace-event.h
> > +++ b/tools/perf/util/trace-event.h
> > @@ -42,9 +42,6 @@ struct tep_event *trace_event__tp_format_id(int id);
> >  void event_format__fprintf(struct tep_event *event,
> >  			   int cpu, void *data, int size, FILE *fp);
> >  
> > -void event_format__print(struct tep_event *event,
> > -			 int cpu, void *data, int size);
> > -
> >  int parse_ftrace_file(struct tep_handle *pevent, char *buf, unsigned long size);
> >  int parse_event_file(struct tep_handle *pevent,
> >  		     char *buf, unsigned long size, char *sys);
> > -- 
> > 2.47.0
> > 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
