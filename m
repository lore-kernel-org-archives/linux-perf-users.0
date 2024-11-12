Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2FF21C18A;
	Tue, 12 Nov 2024 23:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731454731; cv=none; b=X85o45mKv+9txwy582AEhjZFL8I0ImWjdzsqYl7i5Fh2944KuOVx5ruSya7+sNbY+3v3hj7iV6h9VvQiZEOJsQDEcFN5BgpnKt54b34HyAwUCbDEQmIZhXtCakyQmZIz+epnpBSCJhMkayiQZdgOTjWRkz2hDZdIAAFKRtiSFgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731454731; c=relaxed/simple;
	bh=A2UR8xFBYF8FQUGSKMRMl7/XBWFxCi/E2gMC3jz7qUQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=O/QdleHcNv2UHSWNxCBo4Y+nyE3Qh1F+pHYzdEu9cRkHZd2LkzNJC42e82rXG1Eio724l3LJHXg9IMpzTlUcLzME+Dv+p2EXQz7FDJ05j74XXPF78ZvzSt7Ex6BQ/6aSxfMMbYeO+HKWz6lTvfw3bHY2YaaVjZ+Ms3j7CIqbpZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yd9BW/a4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yd9BW/a4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD78C4CECD;
	Tue, 12 Nov 2024 23:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731454731;
	bh=A2UR8xFBYF8FQUGSKMRMl7/XBWFxCi/E2gMC3jz7qUQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Yd9BW/a4YKHcfOBFSJsxGXcenJ+nZaKgiAm33wJHAy6olEFDJFcJUvo0jAU8iLFZB
	 LFJQdIBQbEDkn4+TMvZA3VgmccsS1Fx8TVIflk8uC+CBzx8jCcs+L4oRrrOjQz/rLh
	 jYhJHTwIGRDtZ0GvChurA91EW6p12PUQW8rrQw1KXcYeoEuxmAVgb4nAsVAO7PrMdM
	 WtDiELtDGQ+ZLY4ZJL3h172nN6cjwwBs6te/kmc4lQzicK3wIfhrAobgzvxuXPjBL4
	 7Fbbjz/IZ2uRx7gL8w6+vJ2A+Vbd/bOI7fBZY6fwYfuBMZicwwx2KkfjEHfSBPAdQz
	 K42EtbB0D/gnw==
Date: Wed, 13 Nov 2024 08:38:47 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Ian Rogers
 <irogers@google.com>, Dima Kogan <dima@secretsauce.net>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] perf-probe: Replace unacceptable characters when
 generating event name
Message-Id: <20241113083847.447deb4eeea33afe7bd068be@kernel.org>
In-Reply-To: <ZzOQV3Og0UcO05J1@x1>
References: <173099112488.2431889.1181692857521683304.stgit@mhiramat.roam.corp.google.com>
	<173099117811.2431889.17590362733353379842.stgit@mhiramat.roam.corp.google.com>
	<ZzOQV3Og0UcO05J1@x1>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 12 Nov 2024 14:28:55 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> On Thu, Nov 07, 2024 at 11:52:58PM +0900, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> This last patch isn't applying, to make progress I appled 1-5, please
> take a look at the tmp.perf-tools-next branch at:
> 

OK, let me resend on top of that branch.

Thank you!

> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git tmp.perf-tools-next
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/log/?h=tmp.perf-tools-next
> 
> - Arnaldo
> 
> Applying: perf-probe: Replace unacceptable characters when generating event name
> error: patch failed: tools/perf/util/probe-event.c:2874
> error: tools/perf/util/probe-event.c: patch does not apply
> error: patch failed: tools/perf/util/probe-finder.h:103
> error: tools/perf/util/probe-finder.h: patch does not apply
> Patch failed at 0006 perf-probe: Replace unacceptable characters when generating event name
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> hint: When you have resolved this problem, run "git am --continue".
> hint: If you prefer to skip this patch, run "git am --skip" instead.
> hint: To restore the original branch and stop patching, run "git am --abort".
> hint: Disable this message with "git config advice.mergeConflict false"
> ⬢ [acme@toolbox perf-tools-next]$ 
> 
>  
> > Replace unacceptable characters with '_' when generating event name from
> > the probing function name. This is not for C program. For the C program,
> > it will continue to remove suffixes.
> > Note that this language checking depends on the debuginfo. So without the
> > debuginfo, perf probe will always replaces unacceptable characters with
> > '_'.
> > 
> > For example.
> > 
> > $ ./perf probe -x cro3 -D \"cro3::cmd::servo::run_show\"
> > p:probe_cro3/cro3_cmd_servo_run_show /work/cro3/target/x86_64-unknown-linux-gnu/debug/cro3:0x197530
> > 
> > $ ./perf probe -x /work/go/example/outyet/main -D 'main.(*Server).poll'
> > p:probe_main/main_Server_poll /work/go/example/outyet/main:0x353040
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  Changes in v2:
> >   - Check dwarf language instead of checking wildcards.
> > ---
> >  tools/perf/util/probe-event.c  |   32 +++++++++++++++++++++++++-------
> >  tools/perf/util/probe-event.h  |    3 ++-
> >  tools/perf/util/probe-finder.c |   15 +++++++++++++++
> >  tools/perf/util/probe-finder.h |    6 +++++-
> >  4 files changed, 47 insertions(+), 9 deletions(-)
> > 
> > diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> > index 31e257c84cd1..9eaf0fc7975a 100644
> > --- a/tools/perf/util/probe-event.c
> > +++ b/tools/perf/util/probe-event.c
> > @@ -2771,7 +2771,7 @@ int show_perf_probe_events(struct strfilter *filter)
> >  
> >  static int get_new_event_name(char *buf, size_t len, const char *base,
> >  			      struct strlist *namelist, bool ret_event,
> > -			      bool allow_suffix)
> > +			      bool allow_suffix, bool not_C_symname)
> >  {
> >  	int i, ret;
> >  	char *p, *nbase;
> > @@ -2782,10 +2782,24 @@ static int get_new_event_name(char *buf, size_t len, const char *base,
> >  	if (!nbase)
> >  		return -ENOMEM;
> >  
> > -	/* Cut off the dot suffixes (e.g. .const, .isra) and version suffixes */
> > -	p = strpbrk(nbase, ".@");
> > -	if (p && p != nbase)
> > -		*p = '\0';
> > +	if (not_C_symname) {
> > +		/* Replace non-alnum with '_' */
> > +		char *s, *d;
> > +
> > +		s = d = nbase;
> > +		do {
> > +			if (*s && !isalnum(*s)) {
> > +				if (d != nbase && *(d - 1) != '_')
> > +					*d++ = '_';
> > +			} else
> > +				*d++ = *s;
> > +		} while (*s++);
> > +	} else {
> > +		/* Cut off the dot suffixes (e.g. .const, .isra) and version suffixes */
> > +		p = strpbrk(nbase, ".@");
> > +		if (p && p != nbase)
> > +			*p = '\0';
> > +	}
> >  
> >  	/* Try no suffix number */
> >  	ret = e_snprintf(buf, len, "%s%s", nbase, ret_event ? "__return" : "");
> > @@ -2874,6 +2888,7 @@ static int probe_trace_event__set_name(struct probe_trace_event *tev,
> >  				       bool allow_suffix)
> >  {
> >  	const char *event, *group;
> > +	bool not_C_symname = true;
> >  	char buf[64];
> >  	int ret;
> >  
> > @@ -2888,8 +2903,10 @@ static int probe_trace_event__set_name(struct probe_trace_event *tev,
> >  			(strncmp(pev->point.function, "0x", 2) != 0) &&
> >  			!strisglob(pev->point.function))
> >  			event = pev->point.function;
> > -		else
> > +		else {
> >  			event = tev->point.realname;
> > +			not_C_symname = !is_known_C_lang(tev->lang);
> > +		}
> >  	}
> >  	if (pev->group && !pev->sdt)
> >  		group = pev->group;
> > @@ -2900,7 +2917,8 @@ static int probe_trace_event__set_name(struct probe_trace_event *tev,
> >  
> >  	/* Get an unused new event name */
> >  	ret = get_new_event_name(buf, sizeof(buf), event, namelist,
> > -				 tev->point.retprobe, allow_suffix);
> > +				 tev->point.retprobe, allow_suffix,
> > +				 not_C_symname);
> >  	if (ret < 0)
> >  		return ret;
> >  
> > diff --git a/tools/perf/util/probe-event.h b/tools/perf/util/probe-event.h
> > index 7e3b6c3d1f74..6516105f43e2 100644
> > --- a/tools/perf/util/probe-event.h
> > +++ b/tools/perf/util/probe-event.h
> > @@ -57,7 +57,8 @@ struct probe_trace_event {
> >  	char				*event;	/* Event name */
> >  	char				*group;	/* Group name */
> >  	struct probe_trace_point	point;	/* Trace point */
> > -	int				nargs;	/* Number of args */
> > +	int					nargs;	/* Number of args */
> > +	int					lang;	/* Dwarf language code */
> >  	bool				uprobes;	/* uprobes only */
> >  	struct probe_trace_arg		*args;	/* Arguments */
> >  };
> > diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
> > index 630e16c54ed5..13ff45d3d6a4 100644
> > --- a/tools/perf/util/probe-finder.c
> > +++ b/tools/perf/util/probe-finder.c
> > @@ -35,6 +35,19 @@
> >  /* Kprobe tracer basic type is up to u64 */
> >  #define MAX_BASIC_TYPE_BITS	64
> >  
> > +bool is_known_C_lang(int lang)
> > +{
> > +	switch (lang) {
> > +	case DW_LANG_C89:
> > +	case DW_LANG_C:
> > +	case DW_LANG_C99:
> > +	case DW_LANG_C11:
> > +		return true;
> > +	default:
> > +		return false;
> > +	}
> > +}
> > +
> >  /*
> >   * Probe finder related functions
> >   */
> > @@ -1272,6 +1285,8 @@ static int add_probe_trace_event(Dwarf_Die *sc_die, struct probe_finder *pf)
> >  		ret = -ENOMEM;
> >  		goto end;
> >  	}
> > +	tev->lang = dwarf_srclang(dwarf_diecu(sc_die, &pf->cu_die,
> > +										  NULL, NULL));
> >  
> >  	pr_debug("Probe point found: %s+%lu\n", tev->point.symbol,
> >  		 tev->point.offset);
> > diff --git a/tools/perf/util/probe-finder.h b/tools/perf/util/probe-finder.h
> > index 3add5ff516e1..04a52d5fd568 100644
> > --- a/tools/perf/util/probe-finder.h
> > +++ b/tools/perf/util/probe-finder.h
> > @@ -26,6 +26,9 @@ static inline int is_c_varname(const char *name)
> >  #include "dwarf-aux.h"
> >  #include "debuginfo.h"
> >  
> > +/* Check the language code is known C */
> > +bool is_known_C_lang(int lang);
> > +
> >  /* Find probe_trace_events specified by perf_probe_event from debuginfo */
> >  int debuginfo__find_trace_events(struct debuginfo *dbg,
> >  				 struct perf_probe_event *pev,
> > @@ -103,7 +106,8 @@ struct line_finder {
> >  	Dwarf_Die		sp_die;
> >  	int			found;
> >  };
> > -
> > +#else
> > +#define is_known_C_lang(lang) (false)
> >  #endif /* HAVE_DWARF_SUPPORT */
> >  
> >  #endif /*_PROBE_FINDER_H */


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
