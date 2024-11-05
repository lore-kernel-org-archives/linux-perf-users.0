Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FDA1D041D;
	Tue,  5 Nov 2024 09:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730799001; cv=none; b=kJQBX/Z0EjApD1VdjWeuDKPhDndHY/QJFyl6NXH0IlDmO1GfzcTjQS32LSvn2GCAyZ4w2sSyRNzL7sn2N5LXL8669+D5SZ+fmw/kFPjXLcAzuv/biPSEc5zzYqK8G0OwknBYuCQi9aG3D3aRkJ1k8jLiCDb6v/U22zEaK4DeIFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730799001; c=relaxed/simple;
	bh=6Z0Q4tBipCdbfSwef5z6QtGSpDfpWBnD3ZsewSe0eH8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZfW9r2Dpwbh40NKsp9K2snSoZSf3q314/Qz+VXJO+gX1XfihpeKflFMyxutwCKnEAcY9Rp20Hw87BLML6SFPpyqRq/Ssv2Y47IVaYZ1VHhbr5Mfq/hdU+9ZgqqGMBpZurC1xlCzG1Qrf3MMMb5vxpCZ7lssNkb9YN/FGGCBt5FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rzDycj/d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzDycj/d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0CEC4CECF;
	Tue,  5 Nov 2024 09:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730799001;
	bh=6Z0Q4tBipCdbfSwef5z6QtGSpDfpWBnD3ZsewSe0eH8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rzDycj/dTq81YpCW+ozxbLVqbv55QY+MgLpGrNNYEehCL3qlpU71wWoqHYTocmszp
	 ZfSus4aSnSmWXvMP8HMdrVMTdPogpbcAZAouNAbjohuAni825HHkGqjY8hR0gSZhS1
	 XWWG/Q3Ng3payVbRl65QN/e6/AnsNuhjNSoFscam13vCiLVDv8HFOdfQs6/gWBYbDb
	 ZvsOWCGVpy+8WqzwcyRBrsa4+C0xlyV/tfGlUvBN+q+ZNVVzL1Ff+64PSajEoMgHKk
	 Uti8gGsBKnee77xU4I+YQ7S4tn/TcvObmIDHUiStSiGEQh6JOoVhmbDYQvUU5izAZe
	 Ab03h5XhGIw5w==
Date: Tue, 5 Nov 2024 18:29:58 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Ian Rogers
 <irogers@google.com>, Dima Kogan <dima@secretsauce.net>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] perf-probe: Introduce quotation marks support
Message-Id: <20241105182958.6ad93bf588eca3e716b4a02f@kernel.org>
In-Reply-To: <ZyktL05NmqRTr213@x1>
References: <173073702882.2098439.13342508872190995896.stgit@mhiramat.roam.corp.google.com>
	<173073705572.2098439.4076465830484831945.stgit@mhiramat.roam.corp.google.com>
	<ZyktL05NmqRTr213@x1>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Nov 2024 17:23:11 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> On Tue, Nov 05, 2024 at 01:17:35AM +0900, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > In non-C languages, it is possible to have ':' in the function names.
> > It is possible to escape it with backslashes, but if there are too many
> > backslashes, it is annoying.
> > This introduce quotation marks (`"` or `'`) support.
> 
> Can you please split the patch so that strpbrk_esq() and strdup_esq()
> are introduced in different patches?

Yeah, OK. Let me split it.

Thank you,

> 
> - Arnaldo
>  
> > For example, without quotes, we have to pass it as below
> > 
> > $ perf probe -x cro3 -L "cro3\:\:cmd\:\:servo\:\:run_show"
> > <run_show@/work/cro3/src/cmd/servo.rs:0>
> >       0  fn run_show(args: &ArgsShow) -> Result<()> {
> >       1      let list = ServoList::discover()?;
> >       2      let s = list.find_by_serial(&args.servo)?;
> >       3      if args.json {
> >       4          println!("{s}");
> > 
> > With quotes, we can more naturally write the function name as below;
> > 
> > $ ./perf probe -x cro3 -L \"cro3::cmd::servo::run_show\"
> > <run_show@/work/cro3/src/cmd/servo.rs:0>
> >       0  fn run_show(args: &ArgsShow) -> Result<()> {
> >       1      let list = ServoList::discover()?;
> >       2      let s = list.find_by_serial(&args.servo)?;
> >       3      if args.json {
> >       4          println!("{s}");
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  tools/perf/util/probe-event.c  |   76 ++++++++++++++++--------------
> >  tools/perf/util/probe-finder.c |    3 +
> >  tools/perf/util/string.c       |  100 ++++++++++++++++++++++++++++++++++++++++
> >  tools/perf/util/string2.h      |    2 +
> >  4 files changed, 145 insertions(+), 36 deletions(-)
> > 
> > diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> > index 913a27cbb5d9..bcba8273204d 100644
> > --- a/tools/perf/util/probe-event.c
> > +++ b/tools/perf/util/probe-event.c
> > @@ -1065,6 +1065,7 @@ static int __show_line_range(struct line_range *lr, const char *module,
> >  
> >  	ret = debuginfo__find_line_range(dinfo, lr);
> >  	if (!ret) {	/* Not found, retry with an alternative */
> > +		pr_debug2("Failed to find line range in debuginfo. Fallback to alternative\n");
> >  		ret = get_alternative_line_range(dinfo, lr, module, user);
> >  		if (!ret)
> >  			ret = debuginfo__find_line_range(dinfo, lr);
> > @@ -1078,7 +1079,7 @@ static int __show_line_range(struct line_range *lr, const char *module,
> >  		pr_warning("Specified source line is not found.\n");
> >  		return -ENOENT;
> >  	} else if (ret < 0) {
> > -		pr_warning("Debuginfo analysis failed.\n");
> > +		pr_warning("Debuginfo analysis failed (%d).\n", ret);
> >  		return ret;
> >  	}
> >  
> > @@ -1187,7 +1188,7 @@ static int show_available_vars_at(struct debuginfo *dinfo,
> >  			pr_err("Failed to find the address of %s\n", buf);
> >  			ret = -ENOENT;
> >  		} else
> > -			pr_warning("Debuginfo analysis failed.\n");
> > +			pr_warning("Debuginfo analysis failed(2).\n");
> >  		goto end;
> >  	}
> >  
> > @@ -1343,30 +1344,39 @@ static bool is_c_func_name(const char *name)
> >   *
> >   *         @SRC[:SLN[+NUM|-ELN]]
> >   *         FNC[@SRC][:SLN[+NUM|-ELN]]
> > + *
> > + * SRC and FUNC can be quoted by double/single quotes.
> >   */
> >  int parse_line_range_desc(const char *arg, struct line_range *lr)
> >  {
> > -	char *range, *file, *name = strdup(arg);
> > +	char *buf = strdup(arg);
> > +	char *p;
> >  	int err;
> >  
> > -	if (!name)
> > +	if (!buf)
> >  		return -ENOMEM;
> >  
> >  	lr->start = 0;
> >  	lr->end = INT_MAX;
> >  
> > -	range = strpbrk_esc(name, ":");
> > -	if (range) {
> > -		*range++ = '\0';
> > +	pr_debug2("Input line range: %s\n", buf);
> > +	p = strpbrk_esq(buf, ":");
> > +	if (p) {
> > +		if (p == buf) {
> > +			semantic_error("No file/function name in '%s'.\n", p);
> > +			err = -EINVAL;
> > +			goto err;
> > +		}
> > +		*(p++) = '\0';
> >  
> > -		err = parse_line_num(&range, &lr->start, "start line");
> > +		err = parse_line_num(&p, &lr->start, "start line");
> >  		if (err)
> >  			goto err;
> >  
> > -		if (*range == '+' || *range == '-') {
> > -			const char c = *range++;
> > +		if (*p == '+' || *p == '-') {
> > +			const char c = *(p++);
> >  
> > -			err = parse_line_num(&range, &lr->end, "end line");
> > +			err = parse_line_num(&p, &lr->end, "end line");
> >  			if (err)
> >  				goto err;
> >  
> > @@ -1390,28 +1400,22 @@ int parse_line_range_desc(const char *arg, struct line_range *lr)
> >  				       " than end line.\n");
> >  			goto err;
> >  		}
> > -		if (*range != '\0') {
> > -			semantic_error("Tailing with invalid str '%s'.\n", range);
> > +		if (*p != '\0') {
> > +			semantic_error("Tailing with invalid str '%s'.\n", p);
> >  			goto err;
> >  		}
> >  	}
> >  
> > -	file = strpbrk_esc(name, "@");
> > -	if (file) {
> > -		*file = '\0';
> > -		lr->file = strdup_esc(++file);
> > -		if (lr->file == NULL) {
> > -			err = -ENOMEM;
> > -			goto err;
> > -		}
> > -		if (*name != '\0')
> > -			lr->function = name;
> > -	} else
> > -		lr->function = name;
> > +	p = strpbrk_esq(buf, "@");
> > +	if (p) {
> > +		*(p++) = '\0';
> > +		lr->file = strdup_esq(p);
> > +	}
> > +	lr->function = strdup_esq(buf);
> > +	err = 0;
> >  
> > -	return 0;
> >  err:
> > -	free(name);
> > +	free(buf);
> >  	return err;
> >  }
> >  
> > @@ -1419,19 +1423,19 @@ static int parse_perf_probe_event_name(char **arg, struct perf_probe_event *pev)
> >  {
> >  	char *ptr;
> >  
> > -	ptr = strpbrk_esc(*arg, ":");
> > +	ptr = strpbrk_esq(*arg, ":");
> >  	if (ptr) {
> >  		*ptr = '\0';
> >  		if (!pev->sdt && !is_c_func_name(*arg))
> >  			goto ng_name;
> > -		pev->group = strdup_esc(*arg);
> > +		pev->group = strdup_esq(*arg);
> >  		if (!pev->group)
> >  			return -ENOMEM;
> >  		*arg = ptr + 1;
> >  	} else
> >  		pev->group = NULL;
> >  
> > -	pev->event = strdup_esc(*arg);
> > +	pev->event = strdup_esq(*arg);
> >  	if (pev->event == NULL)
> >  		return -ENOMEM;
> >  
> > @@ -1470,7 +1474,7 @@ static int parse_perf_probe_point(char *arg, struct perf_probe_event *pev)
> >  			arg++;
> >  	}
> >  
> > -	ptr = strpbrk_esc(arg, ";=@+%");
> > +	ptr = strpbrk_esq(arg, ";=@+%");
> >  	if (pev->sdt) {
> >  		if (ptr) {
> >  			if (*ptr != '@') {
> > @@ -1484,7 +1488,7 @@ static int parse_perf_probe_point(char *arg, struct perf_probe_event *pev)
> >  				pev->target = build_id_cache__origname(tmp);
> >  				free(tmp);
> >  			} else
> > -				pev->target = strdup_esc(ptr + 1);
> > +				pev->target = strdup_esq(ptr + 1);
> >  			if (!pev->target)
> >  				return -ENOMEM;
> >  			*ptr = '\0';
> > @@ -1518,7 +1522,7 @@ static int parse_perf_probe_point(char *arg, struct perf_probe_event *pev)
> >  		arg++;
> >  	}
> >  
> > -	ptr = strpbrk_esc(arg, ";:+@%");
> > +	ptr = strpbrk_esq(arg, ";:+@%");
> >  	if (ptr) {
> >  		nc = *ptr;
> >  		*ptr++ = '\0';
> > @@ -1527,7 +1531,7 @@ static int parse_perf_probe_point(char *arg, struct perf_probe_event *pev)
> >  	if (arg[0] == '\0')
> >  		tmp = NULL;
> >  	else {
> > -		tmp = strdup_esc(arg);
> > +		tmp = strdup_esq(arg);
> >  		if (tmp == NULL)
> >  			return -ENOMEM;
> >  	}
> > @@ -1565,7 +1569,7 @@ static int parse_perf_probe_point(char *arg, struct perf_probe_event *pev)
> >  				return -ENOMEM;
> >  			break;
> >  		}
> > -		ptr = strpbrk_esc(arg, ";:+@%");
> > +		ptr = strpbrk_esq(arg, ";:+@%");
> >  		if (ptr) {
> >  			nc = *ptr;
> >  			*ptr++ = '\0';
> > @@ -1592,7 +1596,7 @@ static int parse_perf_probe_point(char *arg, struct perf_probe_event *pev)
> >  				semantic_error("SRC@SRC is not allowed.\n");
> >  				return -EINVAL;
> >  			}
> > -			pp->file = strdup_esc(arg);
> > +			pp->file = strdup_esq(arg);
> >  			if (pp->file == NULL)
> >  				return -ENOMEM;
> >  			break;
> > diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
> > index 630e16c54ed5..5462b5541a6d 100644
> > --- a/tools/perf/util/probe-finder.c
> > +++ b/tools/perf/util/probe-finder.c
> > @@ -1796,6 +1796,7 @@ int debuginfo__find_line_range(struct debuginfo *dbg, struct line_range *lr)
> >  		struct dwarf_callback_param line_range_param = {
> >  			.data = (void *)&lf, .retval = 0};
> >  
> > +		pr_debug2("Start searching function '%s' in getpubname\n", lr->function);
> >  		dwarf_getpubnames(dbg->dbg, pubname_search_cb,
> >  				  &pubname_param, 0);
> >  		if (pubname_param.found) {
> > @@ -1803,8 +1804,10 @@ int debuginfo__find_line_range(struct debuginfo *dbg, struct line_range *lr)
> >  			if (lf.found)
> >  				goto found;
> >  		}
> > +		pr_debug2("Not found, use DIE tree\n");
> >  	}
> >  
> > +	pr_debug2("Search function '%s' in DIE tree\n", lr->function);
> >  	/* Loop on CUs (Compilation Unit) */
> >  	while (!lf.found && ret >= 0) {
> >  		if (dwarf_nextcu(dbg->dbg, off, &noff, &cuhl,
> > diff --git a/tools/perf/util/string.c b/tools/perf/util/string.c
> > index 116a642ad99d..308fc7ec88cc 100644
> > --- a/tools/perf/util/string.c
> > +++ b/tools/perf/util/string.c
> > @@ -263,6 +263,34 @@ char *strpbrk_esc(char *str, const char *stopset)
> >  	return ptr;
> >  }
> >  
> > +/* Like strpbrk_esc(), but not break if it is quoted with single/double quotes */
> > +char *strpbrk_esq(char *str, const char *stopset)
> > +{
> > +	char *_stopset = NULL;
> > +	char *ptr;
> > +	const char *squote = "'";
> > +	const char *dquote = "\"";
> > +
> > +	if (asprintf(&_stopset, "%s%c%c", stopset, *squote, *dquote) < 0)
> > +		return NULL;
> > +
> > +	do {
> > +		ptr = strpbrk_esc(str, _stopset);
> > +		if (!ptr)
> > +			break;
> > +		if (*ptr == *squote)
> > +			ptr = strpbrk_esc(ptr + 1, squote);
> > +		else if (*ptr == *dquote)
> > +			ptr = strpbrk_esc(ptr + 1, dquote);
> > +		else
> > +			break;
> > +		str = ptr + 1;
> > +	} while (ptr);
> > +
> > +	free(_stopset);
> > +	return ptr;
> > +}
> > +
> >  /* Like strdup, but do not copy a single backslash */
> >  char *strdup_esc(const char *str)
> >  {
> > @@ -293,6 +321,78 @@ char *strdup_esc(const char *str)
> >  	return ret;
> >  }
> >  
> > +/* Remove backslash right before quote and return next quote address. */
> > +static char *remove_consumed_esc(char *str, int len, int quote)
> > +{
> > +	char *ptr = str, *end = str + len;
> > +
> > +	while (*ptr != quote && ptr < end) {
> > +		if (*ptr == '\\' && *(ptr + 1) == quote) {
> > +			memmove(ptr, ptr + 1, end - (ptr + 1));
> > +			/* now *ptr is `quote`. */
> > +			end--;
> > +		}
> > +		ptr++;
> > +	}
> > +
> > +	return *ptr == quote ? ptr : NULL;
> > +}
> > +
> > +/*
> > + * Like strdup_esc, but keep quoted string as it is (and single backslash
> > + * before quote is removed). If there is no closed quote, return NULL.
> > + */
> > +char *strdup_esq(const char *str)
> > +{
> > +	char *d, *ret;
> > +
> > +	/* If there is no quote, return normal strdup_esc() */
> > +	d = strpbrk_esc((char *)str, "\"'");
> > +	if (!d)
> > +		return strdup_esc(str);
> > +
> > +	ret = strdup(str);
> > +	if (!ret)
> > +		return NULL;
> > +
> > +	d = ret;
> > +	do {
> > +		d = strpbrk(d, "\\\"\'");
> > +		if (!d)
> > +			break;
> > +
> > +		if (*d == '"' || *d == '\'') {
> > +			/* This is non-escaped quote */
> > +			int quote = *d;
> > +			int len = strlen(d + 1) + 1;
> > +
> > +			/*
> > +			 * Remove the start quote and remove consumed escape (backslash
> > +			 * before quote) and remove the end quote. If there is no end
> > +			 * quote, it is the input error.
> > +			 */
> > +			memmove(d, d + 1, len);
> > +			d = remove_consumed_esc(d, len, quote);
> > +			if (!d)
> > +				goto error;
> > +			memmove(d, d + 1, strlen(d + 1) + 1);
> > +		}
> > +		if (*d == '\\') {
> > +			memmove(d, d + 1, strlen(d + 1) + 1);
> > +			if (*d == '\\') {
> > +				/* double backslash -- keep the second one. */
> > +				d++;
> > +			}
> > +		}
> > +	} while (*d != '\0');
> > +
> > +	return ret;
> > +
> > +error:
> > +	free(ret);
> > +	return NULL;
> > +}
> > +
> >  unsigned int hex(char c)
> >  {
> >  	if (c >= '0' && c <= '9')
> > diff --git a/tools/perf/util/string2.h b/tools/perf/util/string2.h
> > index 52cb8ba057c7..4c8bff47cfd3 100644
> > --- a/tools/perf/util/string2.h
> > +++ b/tools/perf/util/string2.h
> > @@ -37,6 +37,8 @@ char *asprintf__tp_filter_pids(size_t npids, pid_t *pids);
> >  
> >  char *strpbrk_esc(char *str, const char *stopset);
> >  char *strdup_esc(const char *str);
> > +char *strpbrk_esq(char *str, const char *stopset);
> > +char *strdup_esq(const char *str);
> >  
> >  unsigned int hex(char c);
> >  char *strreplace_chars(char needle, const char *haystack, const char *replace);


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
