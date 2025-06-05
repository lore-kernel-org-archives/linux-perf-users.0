Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C382749D9;
	Thu,  5 Jun 2025 19:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749153594; cv=none; b=on0cPuZ4zN0YmxyShqFcjXM0Psi5sTJ//ZBJ1h1YjV5CK9L0FsQaCyyjvv78VBs4DkeCG9KwnyDRRJsRFIHiJ3XYtu7OD18u7esR2YspJ/+e+yNqqPJSEs8YR4n80A2Df312QKx4773uGb2J6yQUKEpxvtswu1hM91iMfpS2DGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749153594; c=relaxed/simple;
	bh=QxGdSy46tMoMI7VgXy9BBcpt63FiDyWWo1u7zMYA8NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOPeek8NUB+GKdwGcOX4q3/VttMDx8J0zL5r+CoY0o512Jclf1LnSNxZf2+Vt4zhZb96cn+7cf7gRej+Ce8/t6OJ6Ep/HbxH6S7vpEMP7ZseIuaxgQ9SmGHkPP0i+UQT/OU8I+xX9IpJsdiALmOFzBOdG/5qW/2Rc1Cc86LWi1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6uy7XI2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6uy7XI2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8B5C4CEEB;
	Thu,  5 Jun 2025 19:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749153594;
	bh=QxGdSy46tMoMI7VgXy9BBcpt63FiDyWWo1u7zMYA8NM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u6uy7XI2JrhN5ZxVSn+zgBj4Ph4hkUCIry9gm+RUhmZ2cOePTPKEx6WV1ljAl65B+
	 e35m2IfGWM/w7CJcEkIoLGOoB/0J8OImhkAoVVMicWtcVb2PM+b98iGw0qjG6kvfNQ
	 g1bk9OFwj+P/a6NgzAtCq65W8fUv4g97fZ8z0cuwrMWl16kKzen/sdC1VpFj3VZbop
	 8zGqVcLI3GxMtkPSlDzjD0bq/J33T7YcdSME/9aAhcIzHy2QJvxuGGOOAogvdIs4jR
	 qyh3rihe2Q5yu1if1QD5eRerSFBKE2aupxFDUHaJy08d8F6mo7GsaI7DowR7SfME2v
	 QREUawtVyHxBg==
Date: Thu, 5 Jun 2025 16:59:51 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/6] perf annotate: Remove __annotation_line__write()
Message-ID: <aEH3NwfDVq2LT0b6@x1>
References: <20250601065302.12531-1-namhyung@kernel.org>
 <20250601065302.12531-3-namhyung@kernel.org>
 <aEH2KoxicdjYUW1g@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEH2KoxicdjYUW1g@x1>

On Thu, Jun 05, 2025 at 04:55:26PM -0300, Arnaldo Carvalho de Melo wrote:
> On Sat, May 31, 2025 at 11:52:58PM -0700, Namhyung Kim wrote:
> > Get rid of the internal function and convert function arguments into
> > local variables if they are used more then twice.
> 
> "more than once"? "twice or more"?

Well, its "more than twice", as you did:

-               if (change_color)
+               if (wops->change_color)
                        color = obj__set_color(obj, HE_COLORSET_ADDR);
                obj__printf(obj, bf);
-               if (change_color)
+               if (wops->change_color)
                        obj__set_color(obj, color);

Ok, I wouldn't touch this, i.e. would leave all as local variables that
way the patch would be smaller :-)

So its just 'then once' to 'than once' the fixup.

- Arnaldo

> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/annotate.c | 49 ++++++++++++++++----------------------
> >  1 file changed, 20 insertions(+), 29 deletions(-)
> > 
> > diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> > index 264a212b47df850c..48fac08c4c9502b1 100644
> > --- a/tools/perf/util/annotate.c
> > +++ b/tools/perf/util/annotate.c
> > @@ -1934,24 +1934,25 @@ int annotation_br_cntr_entry(char **str, int br_cntr_nr,
> >  	return -ENOMEM;
> >  }
> >  
> > -static void __annotation_line__write(struct annotation_line *al, struct annotation *notes,
> > -				     bool first_line, bool current_entry, bool change_color, int width,
> > -				     void *obj, unsigned int percent_type,
> > -				     int  (*obj__set_color)(void *obj, int color),
> > -				     void (*obj__set_percent_color)(void *obj, double percent, bool current),
> > -				     int  (*obj__set_jumps_percent_color)(void *obj, int nr, bool current),
> > -				     void (*obj__printf)(void *obj, const char *fmt, ...),
> > -				     void (*obj__write_graph)(void *obj, int graph))
> > -
> > -{
> > -	double percent_max = annotation_line__max_percent(al, percent_type);
> > -	int pcnt_width = annotation__pcnt_width(notes),
> > -	    cycles_width = annotation__cycles_width(notes);
> > +void annotation_line__write(struct annotation_line *al, struct annotation *notes,
> > +			    struct annotation_write_ops *wops)
> > +{
> > +	bool current_entry = wops->current_entry;
> > +	double percent_max = annotation_line__max_percent(al, annotate_opts.percent_type);
> > +	int width = wops->width;
> > +	int pcnt_width = annotation__pcnt_width(notes);
> > +	int cycles_width = annotation__cycles_width(notes);
> >  	bool show_title = false;
> >  	char bf[256];
> >  	int printed;
> > -
> > -	if (first_line && (al->offset == -1 || percent_max == 0.0)) {
> > +	void *obj = wops->obj;
> > +	int  (*obj__set_color)(void *obj, int color) = wops->set_color;
> > +	void (*obj__set_percent_color)(void *obj, double percent, bool current) = wops->set_percent_color;
> > +	int  (*obj__set_jumps_percent_color)(void *obj, int nr, bool current) = wops->set_jumps_percent_color;
> > +	void (*obj__printf)(void *obj, const char *fmt, ...) = wops->printf;
> > +	void (*obj__write_graph)(void *obj, int graph) = wops->write_graph;
> > +
> > +	if (wops->first_line && (al->offset == -1 || percent_max == 0.0)) {
> >  		if (notes->branch && al->cycles) {
> >  			if (al->cycles->ipc == 0.0 && al->cycles->avg == 0)
> >  				show_title = true;
> > @@ -1965,7 +1966,8 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
> >  		for (i = 0; i < al->data_nr; i++) {
> >  			double percent;
> >  
> > -			percent = annotation_data__percent(&al->data[i], percent_type);
> > +			percent = annotation_data__percent(&al->data[i],
> > +							   annotate_opts.percent_type);
> >  
> >  			obj__set_percent_color(obj, percent, current_entry);
> >  			if (symbol_conf.show_total_period) {
> > @@ -2101,10 +2103,10 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
> >  			}
> >  		}
> >  
> > -		if (change_color)
> > +		if (wops->change_color)
> >  			color = obj__set_color(obj, HE_COLORSET_ADDR);
> >  		obj__printf(obj, bf);
> > -		if (change_color)
> > +		if (wops->change_color)
> >  			obj__set_color(obj, color);
> >  
> >  		disasm_line__write(disasm_line(al), notes, obj, bf, sizeof(bf), obj__printf, obj__write_graph);
> > @@ -2114,17 +2116,6 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
> >  
> >  }
> >  
> > -void annotation_line__write(struct annotation_line *al, struct annotation *notes,
> > -			    struct annotation_write_ops *wops)
> > -{
> > -	__annotation_line__write(al, notes, wops->first_line, wops->current_entry,
> > -				 wops->change_color, wops->width, wops->obj,
> > -				 annotate_opts.percent_type,
> > -				 wops->set_color, wops->set_percent_color,
> > -				 wops->set_jumps_percent_color, wops->printf,
> > -				 wops->write_graph);
> > -}
> > -
> >  int symbol__annotate2(struct map_symbol *ms, struct evsel *evsel,
> >  		      struct arch **parch)
> >  {
> > -- 
> > 2.49.0
