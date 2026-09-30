Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A255447DD58;
	Wed, 30 Sep 2026 23:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790809706; cv=none; b=r3Hy1HSic9Qc92I5iPVn1Ua6nJyFeK0P+iE7jYxzXZUHH90CpRkTwU2HqYW03SzUC3l3j/46US7SrHW5/ZJIfm3EDXJF0Ki+axF3i8Ifr8FqA7sBRLLlUi0drJiWm4yhvzqAFYFD4+kpTsVj0sq/AVFuFdCt580KxCmgGqrXkSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790809706; c=relaxed/simple;
	bh=E0wiH1cVOoZl1B6eWZGEUj8IWbMAvcdH9u2DdTbsOu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OT5q4bQmp2tseWuRl27YTkOXpTzhFCsFNLa7jbqP2gM/9KNE6QkJnzq0NLSLtSvJWau7WT43RO8VIV7/jxOB2S3yzfeWQhAJnwOVcH/rLShlDHPjiQlJrl0WljEd1PbYv1fczhPPSERsywkdcm9l659oTTPDhTj1vVkvJSR5Vsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBZgOYng; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBZgOYng"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78991F000FF;
	Wed, 30 Sep 2026 23:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790809699;
	bh=EhbS6DD4ZxRw/wqbVQ1rsbt1wNsbaNE1BQ4GSkIL1vI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QBZgOYngZm2VLNPViTxEZYbSxy5dlGvZhRfx5QtYlQ9rJAsesGAS3BQExFATBZJL/
	 ORZsR/zx59T61g8f4x4GimGPhjyClajlPice8pYDC95UbA9A1zxmoJY1wOS3Nl1d3u
	 QcyaItVzgNknPcGViDIa0A/1Q9UOl/jbrxo6jJkG5VhCOh+xZJ6wVBCiPHt+tYUpZW
	 5i4rUPdxsYJwQhAfYHDz8NKi5Zw+8qjVtBlvIP9p2jYIpEfYirdRwng9D44jf++N4j
	 bHL4yQW6V5HM5SPt8FfDzSu0C9g327iNIq+H7FvcUlqLd0xQX8bhCn6vt4s8ytStax
	 Wy8hr1XhuFK3A==
Date: Wed, 30 Sep 2026 16:08:17 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
	Howard Chu <howardchu95@gmail.com>, Jakub Brnak <jbrnak@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 06/26] perf trace: Copy sockaddr arguments by their
 length
Message-ID: <ar2WYemXnrbDx-Il@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <20260928182605.3649015-1-irogers@google.com>
 <20260928182605.3649015-7-irogers@google.com>
 <ar1fon_Z4uT3Cd22@x2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ar1fon_Z4uT3Cd22@x2>

On Wed, Sep 30, 2026 at 09:14:42PM +0200, Arnaldo Carvalho de Melo wrote:
> On Mon, Sep 28, 2026 at 11:25:45AM -0700, Ian Rogers wrote:
> > The BTF augmenter copies sizeof(struct sockaddr), 16 bytes, for the
> > sockaddr arguments of connect, bind and sendto, and runs before the
> > sys_enter_connect and sys_enter_sendto programs that copy their length.
> > An IPv6 address needs 24 or 28 bytes, so the rest was read from past the
> > payload, and now that the printers are bounded only its family is shown.
> > 
> > Copy them as buffers sized by the length argument after them, up to the
> > 32 bytes augmented buffers are limited to. That holds an IPv6 address
> > and doubles the AF_LOCAL path shown.
> > 
> > Fixes: a68fd6a6cdd3 ("perf trace: Collect augmented data using BPF")
> > Assisted-by: Antigravity:gemini-3.1-pro
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-trace.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index 85db74965280..f94745a60f4a 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -4159,7 +4159,12 @@ static int trace__bpf_sys_enter_beauty_map(struct trace *trace, int e_machine, i
> >  				continue;
> >  
> >  			bt = sc->arg_fmt[i].type;
> > -			beauty_array[i] = bt->size;
> > +			/* Copy a sockaddr as a buffer sized by the next argument, e.g. addrlen. */
> > +			if (strcmp(name, "sockaddr") == 0 && field->next &&
> > +			    strstr(field->next->name, "len"))
> > +				beauty_array[i] = -((i + 1) + 1);
> > +			else
> > +				beauty_array[i] = bt->size;
> 
> 
> Humm, I thought that this would be called in BPF handlers like:
> 
> SEC("tp/syscalls/sys_enter_connect")
> int sys_enter_connect(struct syscall_enter_args *args)
> {
>         struct augmented_args_payload *augmented_args = augmented_args_payload();
>         const void *sockaddr_arg = (const void *)args->args[1];
>         unsigned int socklen = args->args[2];
>         unsigned int len = sizeof(u64) + sizeof(augmented_args->args); // the size + err in all 'augmented_arg' structs
> 
>         if (augmented_args == NULL)
>                 return 1; /* Failure: don't filter */
> 
>         _Static_assert(is_power_of_2(sizeof(augmented_args->arg.saddr)), "sizeof(augmented_args->arg.saddr) needs to be a power of two");
>         socklen &= sizeof(augmented_args->arg.saddr) - 1;
> 
>         bpf_probe_read_user(&augmented_args->arg.saddr, socklen, sockaddr_arg);
>         augmented_args->arg.size = socklen;
>         augmented_args->arg.err = 0;
> 
>         return augmented__output(args, augmented_args, len + socklen);
> }
> 
> And it knows how many bytes to read by looking at socklen
> (args->args[2]), i.e. not use the generic BPF handler that uses this
> beauty_array, because knowing how many bytes to read in this case is
> dynamic, varies with each syscall, according to one of its arguments :-\
> 
> What am I missing?

I think Ian's patch update the beauty map which is used by
augment_sys_enter() before tail-calling syscall-specific functions.

It'd be great if we cover all syscalls in the BPF skeleton and switch
to the beauty-map and discard the functions.

Thanks,
Namhyung

