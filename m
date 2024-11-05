Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0802F1CEAD3;
	Tue,  5 Nov 2024 09:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730798916; cv=none; b=oAAgkM/ACO373zirbS9BnktnBGy6avZRAbtQTpoplfTrBDjvyW//n2hQq+0Qx09K5NvOYuMfLo1SBZiq9jWrn/FYwJrsBgMsbcISLJijE09AiZqM/pW9wAu9XjkQftUwWIsuX2ksdQwbKWq7maGIhkNhNGTctXATTFubAnF3Eso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730798916; c=relaxed/simple;
	bh=PPZvz5qoYNEfErwJ5Zdp9p8k7QnqWb6iyN5gYt91vdw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lbCJLN2wNznDlDQ1Et4aiMmzYnCyG5bn/cS2jKrI6qFFzl0TE4O+ULT1Uw1ntDebG0e3IL1UJtucMh2h4y4aJ70y1FTRUnGyUQz6Y7T695Wi2gDQ0LP3lLIvvKOc4LWuTKYd0ZWXbBMpHjLa8RI/l19jotPQS5KcrrwiBh/N9k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kK+spCA9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kK+spCA9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A88C4CECF;
	Tue,  5 Nov 2024 09:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730798913;
	bh=PPZvz5qoYNEfErwJ5Zdp9p8k7QnqWb6iyN5gYt91vdw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kK+spCA9XZ1JelSgBzWHUKZmLiNLH614lY5ad59Hx50NV7zu1lhvGVRR9LdCOv4VQ
	 GBW5LFFwEREH4fjddMB15q31/7ksZnQNgKUDpPj+Y5h8Xc2BRizj3t2KrpsRgQjP65
	 zhD+mbmQxQeXg2PuugGFy4LrIGgAvaRbNIxxOCGR/xnz5o2mtg9l3Up/reB+RkD+wA
	 388xsXmwRb9Ww1tzJApNY27YBMA1RfYjkqJqp4TFc+abtxy6p/3YcyGl/AY+7d1bZ5
	 VxLy49X1lsZSn5HmoPCPp1oOBgeW67NM2CJ1bWKQQp9tKyDDh6noTsCvqkBA29+zXW
	 NnlWqqqRg0XqQ==
Date: Tue, 5 Nov 2024 18:28:30 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Ian Rogers
 <irogers@google.com>, Dima Kogan <dima@secretsauce.net>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] perf-probe: Require '@' prefix for filename always
Message-Id: <20241105182830.384b70727ff34391eb0ef9eb@kernel.org>
In-Reply-To: <ZykqQTMbA8PlaIBW@x1>
References: <173073702882.2098439.13342508872190995896.stgit@mhiramat.roam.corp.google.com>
	<173073704685.2098439.2208365513857043203.stgit@mhiramat.roam.corp.google.com>
	<ZykqQTMbA8PlaIBW@x1>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Nov 2024 17:10:41 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> On Tue, Nov 05, 2024 at 01:17:26AM +0900, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>  
> > Currently perf probe allows user to specify probing place without '@'
> > prefix, for example, both `-V file:line` and `-V function:line` are
> > allowed. But this makes a problem if a (demangled) function name is
> > hard to be distinguished from a file name.
>  
> > This changes the perf-probe to require '@' prefix for filename even
> > without function name. For example, `-V @file:line` and
> > `-V function:line` are acceptable.
>  
> > With this change, users can specify filename or function correctly.
> 
> Well, this will break scripts that use perf probe for a given file,
> probably the right thing not to break backwards compatibility is to
> continue accepting and when there is a real conflict, an ambiguity that
> makes differentiating from file to function names, then refuse it,
> stating that it is ambiguous, probably spelling out the names of the
> files and functions that match so and stating that to make it
> unambiguoius, prefix file names with @.

The problem is that the ambiguous function name. For example, Go's
main routine is `main.main`, and this is not likely to the C function
name, so currently perf probe treats it as a filename and failed to
find that.

I think one possible solution is to run search loop twice internally
(search it as file name, if fails, search it as function name) if it
looks like a file name but it does not start from `@`.
This takes costs a bit but can keep backward compatibility.

Thank you,

> 
> - Arnaldo
>  
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  tools/perf/util/probe-event.c |   31 +++++++++----------------------
> >  1 file changed, 9 insertions(+), 22 deletions(-)
> > 
> > diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> > index 665dcce482e1..913a27cbb5d9 100644
> > --- a/tools/perf/util/probe-event.c
> > +++ b/tools/perf/util/probe-event.c
> > @@ -1341,7 +1341,7 @@ static bool is_c_func_name(const char *name)
> >   * Stuff 'lr' according to the line range described by 'arg'.
> >   * The line range syntax is described by:
> >   *
> > - *         SRC[:SLN[+NUM|-ELN]]
> > + *         @SRC[:SLN[+NUM|-ELN]]
> >   *         FNC[@SRC][:SLN[+NUM|-ELN]]
> >   */
> >  int parse_line_range_desc(const char *arg, struct line_range *lr)
> > @@ -1404,16 +1404,10 @@ int parse_line_range_desc(const char *arg, struct line_range *lr)
> >  			err = -ENOMEM;
> >  			goto err;
> >  		}
> > +		if (*name != '\0')
> > +			lr->function = name;
> > +	} else
> >  		lr->function = name;
> > -	} else if (strpbrk_esc(name, "/."))
> > -		lr->file = name;
> > -	else if (is_c_func_name(name))/* We reuse it for checking funcname */
> > -		lr->function = name;
> > -	else {	/* Invalid name */
> > -		semantic_error("'%s' is not a valid function name.\n", name);
> > -		err = -EINVAL;
> > -		goto err;
> > -	}
> >  
> >  	return 0;
> >  err:
> > @@ -1463,7 +1457,7 @@ static int parse_perf_probe_point(char *arg, struct perf_probe_event *pev)
> >  
> >  	/*
> >  	 * <Syntax>
> > -	 * perf probe [GRP:][EVENT=]SRC[:LN|;PTN]
> > +	 * perf probe [GRP:][EVENT=]@SRC[:LN|;PTN]
> >  	 * perf probe [GRP:][EVENT=]FUNC[@SRC][+OFFS|%return|:LN|;PAT]
> >  	 * perf probe %[GRP:]SDT_EVENT
> >  	 */
> > @@ -1516,19 +1510,12 @@ static int parse_perf_probe_point(char *arg, struct perf_probe_event *pev)
> >  	/*
> >  	 * Check arg is function or file name and copy it.
> >  	 *
> > -	 * We consider arg to be a file spec if and only if it satisfies
> > -	 * all of the below criteria::
> > -	 * - it does not include any of "+@%",
> > -	 * - it includes one of ":;", and
> > -	 * - it has a period '.' in the name.
> > -	 *
> > +	 * We consider arg to be a file spec if it starts with '@'.
> >  	 * Otherwise, we consider arg to be a function specification.
> >  	 */
> > -	if (!strpbrk_esc(arg, "+@%")) {
> > -		ptr = strpbrk_esc(arg, ";:");
> > -		/* This is a file spec if it includes a '.' before ; or : */
> > -		if (ptr && memchr(arg, '.', ptr - arg))
> > -			file_spec = true;
> > +	if (*arg == '@') {
> > +		file_spec = true;
> > +		arg++;
> >  	}
> >  
> >  	ptr = strpbrk_esc(arg, ";:+@%");


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
