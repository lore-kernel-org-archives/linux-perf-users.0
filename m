Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271AA20D515;
	Tue, 12 Nov 2024 17:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731432541; cv=none; b=l1fVXFiO4Kekb8MCMUuPpEyAFS+GaoK/Y+OraLz0/hAoRVKfRAKA6TL3NsLaesU+UCHkVFp85qqzOOFawT3dXLN6sHJHJv2jOw89cfhdFqLUhpbSfYCbnRVXpL3vyGfSNt64YKSiDDd+dM0EzguVZ7ovwa3L7u3PUUqDWWtpJVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731432541; c=relaxed/simple;
	bh=pmexuYuRRWU3lBHhMVTdpV6gv6eTYXCzoq+RKKC8JhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyL7nfIWWMDaS6dxnXSfwGb0IxwFwfEAa7nYBwER0PVQ4DUDpUstl4cael72UQzO0xNlSyx+3j+AHdzjmLKvz3cjNn7XasrhzdJyU/e4D0a3BK1xxlCEHkW9rI51Rc9Ov+Uq1QT9SUOq7KY0fOxcvEWHGP/1koE3vXA9E01jW2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3je5PnC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3je5PnC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB71C4CECD;
	Tue, 12 Nov 2024 17:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731432540;
	bh=pmexuYuRRWU3lBHhMVTdpV6gv6eTYXCzoq+RKKC8JhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R3je5PnC6CS8BsTn0YF63uktVrP0BxLy8Y3rqylvDAJ42dj2q2oT3l5i68qHLMj+z
	 P42MFLPGDZmoec/MTV7qZNw+nbcWZ6pSe+8KEWC+aXnIE0SshKJk5R1FVbthJTc/eE
	 80iFzB2gMS4oB9dAqNBlZskit3M87G0H+2FwxjjeDWD9e7QQi5v5MWoyxXEExWqOe7
	 m0EIiet+5j5vw8vDNmQzYSOYjsCPMDax9XeAMplQ/8ElA9FNZ96EqRbn6GAne9W+hO
	 q/6O8C47vMik6qFJ8Wk4RPmunxGGOordtyK7TrE6PFztatXts3FS8wj3IyHHFnQKo2
	 hVuaEXkOJLQIw==
Date: Tue, 12 Nov 2024 14:28:55 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Ian Rogers <irogers@google.com>,
	Dima Kogan <dima@secretsauce.net>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] perf-probe: Replace unacceptable characters when
 generating event name
Message-ID: <ZzOQV3Og0UcO05J1@x1>
References: <173099112488.2431889.1181692857521683304.stgit@mhiramat.roam.corp.google.com>
 <173099117811.2431889.17590362733353379842.stgit@mhiramat.roam.corp.google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <173099117811.2431889.17590362733353379842.stgit@mhiramat.roam.corp.google.com>

On Thu, Nov 07, 2024 at 11:52:58PM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

This last patch isn't applying, to make progress I appled 1-5, please
take a look at the tmp.perf-tools-next branch at:

https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git tmp.perf-tools-next

https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/log/?h=tmp.perf-tools-next

- Arnaldo

Applying: perf-probe: Replace unacceptable characters when generating event name
error: patch failed: tools/perf/util/probe-event.c:2874
error: tools/perf/util/probe-event.c: patch does not apply
error: patch failed: tools/perf/util/probe-finder.h:103
error: tools/perf/util/probe-finder.h: patch does not apply
Patch failed at 0006 perf-probe: Replace unacceptable characters when generating event name
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config advice.mergeConflict false"
⬢ [acme@toolbox perf-tools-next]$ 

 
> Replace unacceptable characters with '_' when generating event name from
> the probing function name. This is not for C program. For the C program,
> it will continue to remove suffixes.
> Note that this language checking depends on the debuginfo. So without the
> debuginfo, perf probe will always replaces unacceptable characters with
> '_'.
> 
> For example.
> 
> $ ./perf probe -x cro3 -D \"cro3::cmd::servo::run_show\"
> p:probe_cro3/cro3_cmd_servo_run_show /work/cro3/target/x86_64-unknown-linux-gnu/debug/cro3:0x197530
> 
> $ ./perf probe -x /work/go/example/outyet/main -D 'main.(*Server).poll'
> p:probe_main/main_Server_poll /work/go/example/outyet/main:0x353040
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v2:
>   - Check dwarf language instead of checking wildcards.
> ---
>  tools/perf/util/probe-event.c  |   32 +++++++++++++++++++++++++-------
>  tools/perf/util/probe-event.h  |    3 ++-
>  tools/perf/util/probe-finder.c |   15 +++++++++++++++
>  tools/perf/util/probe-finder.h |    6 +++++-
>  4 files changed, 47 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index 31e257c84cd1..9eaf0fc7975a 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -2771,7 +2771,7 @@ int show_perf_probe_events(struct strfilter *filter)
>  
>  static int get_new_event_name(char *buf, size_t len, const char *base,
>  			      struct strlist *namelist, bool ret_event,
> -			      bool allow_suffix)
> +			      bool allow_suffix, bool not_C_symname)
>  {
>  	int i, ret;
>  	char *p, *nbase;
> @@ -2782,10 +2782,24 @@ static int get_new_event_name(char *buf, size_t len, const char *base,
>  	if (!nbase)
>  		return -ENOMEM;
>  
> -	/* Cut off the dot suffixes (e.g. .const, .isra) and version suffixes */
> -	p = strpbrk(nbase, ".@");
> -	if (p && p != nbase)
> -		*p = '\0';
> +	if (not_C_symname) {
> +		/* Replace non-alnum with '_' */
> +		char *s, *d;
> +
> +		s = d = nbase;
> +		do {
> +			if (*s && !isalnum(*s)) {
> +				if (d != nbase && *(d - 1) != '_')
> +					*d++ = '_';
> +			} else
> +				*d++ = *s;
> +		} while (*s++);
> +	} else {
> +		/* Cut off the dot suffixes (e.g. .const, .isra) and version suffixes */
> +		p = strpbrk(nbase, ".@");
> +		if (p && p != nbase)
> +			*p = '\0';
> +	}
>  
>  	/* Try no suffix number */
>  	ret = e_snprintf(buf, len, "%s%s", nbase, ret_event ? "__return" : "");
> @@ -2874,6 +2888,7 @@ static int probe_trace_event__set_name(struct probe_trace_event *tev,
>  				       bool allow_suffix)
>  {
>  	const char *event, *group;
> +	bool not_C_symname = true;
>  	char buf[64];
>  	int ret;
>  
> @@ -2888,8 +2903,10 @@ static int probe_trace_event__set_name(struct probe_trace_event *tev,
>  			(strncmp(pev->point.function, "0x", 2) != 0) &&
>  			!strisglob(pev->point.function))
>  			event = pev->point.function;
> -		else
> +		else {
>  			event = tev->point.realname;
> +			not_C_symname = !is_known_C_lang(tev->lang);
> +		}
>  	}
>  	if (pev->group && !pev->sdt)
>  		group = pev->group;
> @@ -2900,7 +2917,8 @@ static int probe_trace_event__set_name(struct probe_trace_event *tev,
>  
>  	/* Get an unused new event name */
>  	ret = get_new_event_name(buf, sizeof(buf), event, namelist,
> -				 tev->point.retprobe, allow_suffix);
> +				 tev->point.retprobe, allow_suffix,
> +				 not_C_symname);
>  	if (ret < 0)
>  		return ret;
>  
> diff --git a/tools/perf/util/probe-event.h b/tools/perf/util/probe-event.h
> index 7e3b6c3d1f74..6516105f43e2 100644
> --- a/tools/perf/util/probe-event.h
> +++ b/tools/perf/util/probe-event.h
> @@ -57,7 +57,8 @@ struct probe_trace_event {
>  	char				*event;	/* Event name */
>  	char				*group;	/* Group name */
>  	struct probe_trace_point	point;	/* Trace point */
> -	int				nargs;	/* Number of args */
> +	int					nargs;	/* Number of args */
> +	int					lang;	/* Dwarf language code */
>  	bool				uprobes;	/* uprobes only */
>  	struct probe_trace_arg		*args;	/* Arguments */
>  };
> diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
> index 630e16c54ed5..13ff45d3d6a4 100644
> --- a/tools/perf/util/probe-finder.c
> +++ b/tools/perf/util/probe-finder.c
> @@ -35,6 +35,19 @@
>  /* Kprobe tracer basic type is up to u64 */
>  #define MAX_BASIC_TYPE_BITS	64
>  
> +bool is_known_C_lang(int lang)
> +{
> +	switch (lang) {
> +	case DW_LANG_C89:
> +	case DW_LANG_C:
> +	case DW_LANG_C99:
> +	case DW_LANG_C11:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>  /*
>   * Probe finder related functions
>   */
> @@ -1272,6 +1285,8 @@ static int add_probe_trace_event(Dwarf_Die *sc_die, struct probe_finder *pf)
>  		ret = -ENOMEM;
>  		goto end;
>  	}
> +	tev->lang = dwarf_srclang(dwarf_diecu(sc_die, &pf->cu_die,
> +										  NULL, NULL));
>  
>  	pr_debug("Probe point found: %s+%lu\n", tev->point.symbol,
>  		 tev->point.offset);
> diff --git a/tools/perf/util/probe-finder.h b/tools/perf/util/probe-finder.h
> index 3add5ff516e1..04a52d5fd568 100644
> --- a/tools/perf/util/probe-finder.h
> +++ b/tools/perf/util/probe-finder.h
> @@ -26,6 +26,9 @@ static inline int is_c_varname(const char *name)
>  #include "dwarf-aux.h"
>  #include "debuginfo.h"
>  
> +/* Check the language code is known C */
> +bool is_known_C_lang(int lang);
> +
>  /* Find probe_trace_events specified by perf_probe_event from debuginfo */
>  int debuginfo__find_trace_events(struct debuginfo *dbg,
>  				 struct perf_probe_event *pev,
> @@ -103,7 +106,8 @@ struct line_finder {
>  	Dwarf_Die		sp_die;
>  	int			found;
>  };
> -
> +#else
> +#define is_known_C_lang(lang) (false)
>  #endif /* HAVE_DWARF_SUPPORT */
>  
>  #endif /*_PROBE_FINDER_H */
