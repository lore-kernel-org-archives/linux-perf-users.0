Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831091EE2B9
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850114; cv=none; b=Q6lgvgCufXTq2Rt1e9NUL+1ayZIG3FnZn+oFxnDUBFxcCXsujrqtgs/nfo5mCKdkL8Z9bLhX5X2jWMs6gfpMiKS8bmZbAUVsduD8DmNLgr1erHUari1kTpifk31CXgi1Sh6LQzlaJ6CXJoUWUJWaBkUjKjgk5hgvCqDCqG0V860=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850114; c=relaxed/simple;
	bh=WHLff9HsvhZCTn+zurXTtTsxqAR58BSs1r34ht4Cgo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XeVruWOo1SXLlChcbhE6e6vfhEjbCMNelH/FLpWVq+7TGUpjNZAA/0fC+/d5kR8sYRlAjBxQdRFPRro/Nn1k4kPJmpG1Z6+pQyRcLfLhdu2UCPBFf5+waHY5/nbECqmh2/VMWu8AnVKbrRgddnHPxwCszzd1DzrIyzDCzbyuER8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrWigMuQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrWigMuQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51902C072AA;
	Thu, 11 Apr 2024 15:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712850114;
	bh=WHLff9HsvhZCTn+zurXTtTsxqAR58BSs1r34ht4Cgo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VrWigMuQIYhp0q5wLHrnffjmsyE/iTWteIqVuEOWUkNT14OMoON8WhzHxhEyy100p
	 WzQgnMr0n00YbJ8Xwix/tB30vtYryy46f+MQ069oqSm0ukI8/2rEpbhkYZTcW1JcMn
	 SWpzkLl8dedZZC09c4hiIwWlII/pip9AcFIK4cQzojzkUP8FT3WzukBb5zSwR0cWHD
	 mYt7c6wfQ2cZ0wLlT2oiWVGRUO77HHk2w8azzvhqCxJZ7OclHO7Ep6lpcJ/D4i1Pj5
	 97Odz8pxzYfkVJTphB7e+ZqmD30tdjwM56GfqxORBvBFvvI3f1mXgXlBRjxNUS0gHd
	 PBT1+3u7L6REw==
Date: Thu, 11 Apr 2024 12:41:50 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-perf-users@vger.kernel.org, anshuman.khandual@arm.com,
	james.clark@arm.com
Subject: Re: [PATCH V2 1/8] tools lib: adopt str_has_suffix() from
 bpftool/gen.c
Message-ID: <ZhgEvt5_O7eWDdGk@x1>
References: <20240408062230.1949882-1-ChaitanyaS.Prakash@arm.com>
 <20240408062230.1949882-2-ChaitanyaS.Prakash@arm.com>
 <20240409083209.f56351bcc8726439324a8d72@kernel.org>
 <40b33222-45cc-4aea-9e08-1813b2268db9@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40b33222-45cc-4aea-9e08-1813b2268db9@arm.com>

On Thu, Apr 11, 2024 at 05:45:25PM +0530, Chaitanya S Prakash wrote:
> On 4/9/24 05:02, Masami Hiramatsu (Google) wrote:
> > On Mon,  8 Apr 2024 11:52:23 +0530
> > Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com> wrote:
> > > and add it to tools/lib/string.c The function is modified to return
> > > strlen(suffix) on success and 0 on failure.
> > > +++ b/tools/include/linux/string.h
> > > @@ -42,6 +42,8 @@ static inline bool strstarts(const char *str, const char *prefix)
> > >   	return strncmp(str, prefix, strlen(prefix)) == 0;
> > >   }
> > > +size_t str_has_suffix(const char *str, const char *suffix);
> > > +
> > >   extern char * __must_check skip_spaces(const char *);
> > >   extern char *strim(char *);
> > > diff --git a/tools/lib/string.c b/tools/lib/string.c
> > > index 8b6892f959ab..9cb515048239 100644
> > > --- a/tools/lib/string.c
> > > +++ b/tools/lib/string.c
> > > @@ -226,3 +226,29 @@ void *memchr_inv(const void *start, int c, size_t bytes)
> > >   	return check_bytes8(start, value, bytes % 8);
> > >   }
> > > +
> > > +/**
> > > + * str_has_suffix - Test is a string has a given suffix
> > > + * @str: The string to be tested
> > > + * @suffix: The string to see if @str ends with
> > > + *
> > > + * Returns:
> > > + * * strlen(@suffix) if @str ends with @suffix
> > > + * * 0 if @str does not end with @suffix
> > I think this should return boolean, because user will never check the
> > return value is strlen(@suffix). (and user always use the return value
> > as a boolean)
 
> This is in accordance with Arnaldo's comments on V1 of the patch series.
> Please find the link for the same below.
 
> https://lore.kernel.org/all/ZdYPf3wMl35VemsL@x1/

Yeah, when I saw str_has_prefix() I thought it too clever, but then, why
not, there are use cases, in the kernel, where that is useful.

And one thing with tools/ that we try hard is to reduce the differences
of programming in the kernel and in there, so that people used to
functions in the kernel use them in tools/ with the same semantics.

So in these "the user will never do things like this" moments I try to
look at the users in the codebase where we're lifting the function, and
in there _there_ are uses of the strlen() return, to my surprise.

- Arnaldo
 
> > > +size_t str_has_suffix(const char *str, const char *suffix)
> > > +{
> > > +	size_t i;
> > > +	size_t str_len = strlen(str);
> > > +	size_t suffix_len = strlen(suffix);
> > > +
> > > +	if (str_len < suffix_len)
> > > +		return 0;
> > > +
> > > +	for (i = 0; i < suffix_len ; i++) {
> > > +		if (str[str_len  - i - 1] != suffix[suffix_len - i - 1])
> > > +			return 0;
> > > +	}
> > > +
> > > +	return suffix_len;
