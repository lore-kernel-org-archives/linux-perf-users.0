Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E8979DA;
	Sat, 13 Jun 2026 00:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781310472; cv=none; b=Is/9SYgsO2uFBtpHkz4PIsHF7tNHEuxc+ebhNfAdSafu56F/HFB2Yw9CwuBIvNbBgq81G3qJYpTL/8UW4ARJFn7aZBhehTK+qMNAEDGgIN+2vikgGU3fcHpor+MXqeMP3wsqRV2+FIelm01SED4DK2oeF2wYIQjdZJ+Q5tRY1Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781310472; c=relaxed/simple;
	bh=1l3rOnoFoPmFnfA5RUqFC7Tz32k9egrm3+dT61T+hSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gtf/csy/KBYWvtwcMJFpacCN086WPS5L/0r5QYjXuatWUwBV8FEyd/my7tqqI7KREG9GNqHgyxkyGDG9qhcichSfLiCYOgmIUOrVlBTHkYozOXrD7aLcwoxbF5H9mIaxF8vteheFRoZrQUK2u2Xr+mJvsBhZ6wAex+PQHKvsEbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JnrC4uvc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnrC4uvc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD191F000E9;
	Sat, 13 Jun 2026 00:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781310471;
	bh=GYoTnfEUbQyrZ7p/J/KyluL7hNK6Qw5EOLDmxxK79MM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JnrC4uvcsjYq9n75Mwtk1IPxnn2R4IusmUSuT4yO1727XJDsX5wUfsYXhIl/Ejmo/
	 +O/U2U4UNGWGmxEr0ZJb9xm98D1pUfOHp2gGX7t6XznM6T7gCzfarC/B8IPUIxIMsK
	 fv0N4eR9eMM0tIgMZJomKWMcDF0qKfrp8QAGTIGbSd2FaIOH9O/0aqzfWf4r/EJQ35
	 SVXOs5pwmiWYXmWJhFya0mvatVUCVwopeDBKkziSYuDzOCMf8c9/zNv1QFxAAS3B9u
	 9R2UCDhmXW9uwOGYLh8l2wF2DlLbdfwnKlTLlLqqFi4u72uwUzmNBVz2Yh7VAPAjhl
	 X0z3Kl4HIBslA==
Date: Fri, 12 Jun 2026 21:27:48 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Aaron Tomlin <atomlin@atomlin.com>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf trace: Fix noise and signed formatting of
 __probe_ip in bare dynamic probes
Message-ID: <aiykBASNHYv-MR_M@x1>
References: <20260612220843.1320348-1-atomlin@atomlin.com>
 <20260612221602.4886D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260612221602.4886D1F000E9@smtp.kernel.org>

On Fri, Jun 12, 2026 at 10:16:01PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The patch hardcodes the `__probe_ip` argument name in the output format, ignoring the `trace->show_arg_names` configuration.
> --
> 
> commit 52fd2385bfe746191bd8b95bc76fff9e349f4450
> Author: Aaron Tomlin <atomlin@atomlin.com>
> 
> perf trace: Fix noise and signed formatting of __probe_ip in bare dynamic probes
> 
> This commit hides the implicit __probe_ip field in bare dynamic probes
> by default, and formats it as a hexadecimal kernel address when verbose mode
> is enabled.
> 
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index 48615ddccd93a..ca0b2680d531b 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> 
> [ ... ]
> 
> > @@ -3234,6 +3234,23 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
> >  		if (val == 0 && !trace->show_zeros && !arg->show_zero && arg->strtoul != STUL_BTF_TYPE)
> >  			continue;
> >  
> > +		/*
> > +		 * __probe_ip is implicitly added to bare dynamic probes.
> > +		 * Suppress it by default to avoid cluttering the output.
> > +		 * If verbose mode is enabled, ensure it is formatted as a
> > +		 * hexadecimal memory address rather than a signed integer.
> > +		 */
> > +		if (!strcmp(field->name, "__probe_ip")) {
> > +			if (!verbose)
> > +				continue;
> > +
> > +			printed += scnprintf(bf + printed, size - printed,
> > +					     "%s%s: %#016llx", printed ?
> > +					     ", " : "", field->name,
> > +					     (unsigned long long)val);
> 
> [Severity: Medium]
> Does this hardcoded format string bypass the trace->show_arg_names
> configuration?
> 
> In trace__fprintf_tp_fields(), other arguments dynamically check if their
> names should be printed:
> 
>         if (trace->show_arg_names)
>                 printed += scnprintf(bf + printed, size - printed, "%s: ", field->name);
> 
> By explicitly formatting "%s%s: %#016llx" using field->name, it looks like
> __probe_ip will always print its argument name here, even if perf trace
> is executed with --no-arg-names alongside --verbose.

I think this is a valid concern, please make it follow the
trace->show_arg_names for consistency.

This is a nice improvement, thanks for working on it,

- Arnaldo
 
> > +			continue;
> > +		}
> > +
> >  		printed += scnprintf(bf + printed, size - printed, "%s", printed ? ", " : "");
> >  
> >  		if (trace->show_arg_names)
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260612220843.1320348-1-atomlin@atomlin.com?part=1
