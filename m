Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990B654DADD;
	Tue, 29 Sep 2026 18:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707703; cv=none; b=SX0wxP8XOcjmA+43hye1KPwJZCtb0Ki37pUzADgPZnxqo7YrJGx55uVhliCytvkM9/XzHe4Q2s1Bvl98ETcpjoFlg4TB4F/Jfm7acKjXa9comi/mRJud9OaMw625ZG1C/4vKvvrc+fElFG+Q1dPgeecT/Hz4ygC7HI3ScyNsEH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707703; c=relaxed/simple;
	bh=4uMYhmNiQuKFtWZ8PzQM0xoJgFTeGAkegWqsarouonM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BH/TK5a4KSSmIbG9ZNSnJrRDrGd3GeCBsLdWKnzpLH93TGoNcyPCsuozC7XeqqIxHnWxQWroYNKZCP/p0Ou7rqXEwUNSl2hEuzCg3FAeHNKvNC03hEicOO7UOJ6Pb44J/7c1NqshnSv6jOUVl6w9pYTAtZ05RrrcBcta6EKNaLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgQbI7EO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgQbI7EO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB4201F000FF;
	Tue, 29 Sep 2026 18:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790707702;
	bh=G/Y9YOiPY/niWLl5QhNtA1Bz0KTA6ZgEcyPTldzu490=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SgQbI7EOAgjLWd62oDJgH4uRTu9MfNXavXd3NRrKnctg3Xhe02MXELkwm2l6JP+9P
	 JNdVACKgww69vOne4let6NVZ9AuvQaepfLRCkd7etipBcw6CkNvhD1JmXlJG+kEndz
	 Cel1ov2fSEcDxuRJXT5zQ3Ipynz1ujpCnmTwmO0goDeDGjCGcIK2qvjOHIL+eVJH+K
	 Pku4gSvxc2uRxCXatRnDMUrUg103k6KkNZtVWww+t+6W3rsHSNrM/gQp39YbfuuYAe
	 +0XBgTbM5piFz4UvtqTGN8ura/hzoQygp6qe4mXaSouGyvEyoRE54jbfqVLWFkORv5
	 N87CQGS3gSWJg==
Date: Tue, 29 Sep 2026 20:48:18 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 3/8] perf tools: Check system path when check debuginfo
Message-ID: <arwH8oIlQNxsK2fO@x2>
References: <20260929011139.53242-1-namhyung@kernel.org>
 <20260929011139.53242-4-namhyung@kernel.org>
 <20260929012302.984D51F00893@smtp.kernel.org>
 <arwA36u1stwk0rkg@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arwA36u1stwk0rkg@google.com>

On Tue, Sep 29, 2026 at 11:18:07AM -0700, Namhyung Kim wrote:
> On Tue, Sep 29, 2026 at 01:23:02AM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [High] perf: skipping libdw fallback on stripped binaries breaks debuginfod
> > --
> > 
> > commit b8cad86bb3e8eff20f4bbb18f568843350d829d9
> > Author: Namhyung Kim <namhyung@kernel.org>
> > 
> > perf tools: Check system path when check debuginfo
> > 
> > This commit refactors debuginfo__new() to check the system path via
> > dso__find_dbginfo_type() rather than using an explicit fallback. The new
> > approach adds DSO_BINARY_TYPE__SYSTEM_PATH_DSO to the debuginfo types list
> > and removes the fallback code in debuginfo__new().
> > 
> > > diff --git a/tools/perf/util/debuginfo.c b/tools/perf/util/debuginfo.c
> > > index d6bd0fcc22648..2669d5f5ee612 100644
> > > --- a/tools/perf/util/debuginfo.c
> > > +++ b/tools/perf/util/debuginfo.c
> > [ ... ]
> > > @@ -114,18 +114,12 @@ struct debuginfo *debuginfo__new(const char *path)
> > >  	dso__find_dbginfo_type(dso);
> > >  	if (dso__read_binary_type_filename(dso, dso__dbginfo_type(dso), &nil,
> > >  					   buf, PATH_MAX) < 0)
> > > -		goto out;
> > > +		return NULL;
> > 
> > [Severity: High]
> > Does this skip the libdw fallback entirely for stripped binaries, which
> > could break remote debuginfo resolution via debuginfod?
> > 
> > When running a tool like perf annotate on a stripped binary that lacks local
> > debuginfo files, dso__find_dbginfo_type() checks for debug sections:
> > 
> > tools/perf/util/dso.c:dso__find_dbginfo_type() {
> >     ...
> > 		if (filename__has_section(buf, ".debug_info") ||
> > 		    filename__has_section(buf, ".zdebug_info"))
> > 			break;
> >     ...
> > }
> > 
> > Because stripped binaries fail this section check, their type is marked as
> > DSO_BINARY_TYPE__NOT_FOUND even when DSO_BINARY_TYPE__SYSTEM_PATH_DSO is
> > evaluated.
> > 
> > This causes the dso__read_binary_type_filename() check in debuginfo__new()
> > to fail and return NULL early. By bypassing __debuginfo__new(), this
> > prevents libdw from invoking dwfl_standard_find_debuginfo() to remotely
> > resolve the debuginfo.
> 
> I think this is what Arnaldo wanted to add.  As we already have

s/wanted/wants/ :-)

> debuginfod support, I think it's better to check it explicitly with
> introducing DSO_BINARY_TYPE__DEBUGINFOD or so.

Unsure, I'll try to rebase my branch on top of what is being merged,
proably after LPC, we'll see.

If this is the only issue Sashiko found, I'll merge it.

- Arnaldo
 
> By checking sections, it would be independent from libdw support which
> may be useful for minimal systems that only uses external tools like
> addr2line.
