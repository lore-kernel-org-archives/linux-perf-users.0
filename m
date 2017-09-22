From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 4/4] Replace printf with fprintf for all the output
 functions
Date: Fri, 22 Sep 2017 11:14:18 -0300
Message-ID: <20170922141418.GG29668@kernel.org>
References: <1505714122-39141-1-git-send-email-yuzhoujian@didichuxing.com>
 <1505714122-39141-5-git-send-email-yuzhoujian@didichuxing.com>
 <20170922090304.GD15856@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752097AbdIVOOj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 22 Sep 2017 10:14:39 -0400
Content-Disposition: inline
In-Reply-To: <20170922090304.GD15856@krava>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: yuzhoujian <ufo19890607@gmail.com>, peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com, arnaldo.melo@gmail.com, yuzhoujian@didichuxing.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org

Em Fri, Sep 22, 2017 at 11:03:04AM +0200, Jiri Olsa escreveu:
> On Mon, Sep 18, 2017 at 01:55:22PM +0800, yuzhoujian wrote:
> 
> SNIP
> 
> >  static void process_event(struct perf_script *script,
> > @@ -1389,21 +1389,30 @@ static void process_event(struct perf_script *script,
> >  	struct perf_event_attr *attr = &evsel->attr;
> >  	unsigned int type = output_type(attr->type);
> >  
> > +	const char *evname;
> > +	char *file_name;
> >  	if (output[type].fields == 0)
> >  		return;
> >  
> > +	evname = perf_evsel__name(evsel);
> > +	if (script->tool.per_event_dump == true) {
> > +		if (asprintf(&file_name, "%s%s", evname, ".stack") < 0)
> 
> what's the 'stack' suffix for? It's text dump, should we use .txt?
> Also I think it should be more than 'cycles.stack', more like:
> 
>   <ORIGINAL PERF DATA FILE NAME>-script-dump-cycles.txt
> 
> or something like this
> 
> Arnaldo, thoughts?

Looks better, yes, I also was puzzled with that ".stack" suffix. And
your comment about using as a prefix the perf.data file being processed
also looks really needed.

- Arnaldo
