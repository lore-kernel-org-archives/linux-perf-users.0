Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E431346AE3;
	Wed, 10 Jun 2026 21:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781128341; cv=none; b=LYMiRwC7bAZuQOCVrG+3PMy+Le1KOGuIcceT4Rz+OB2v8AzPb1pQRWtO2hy8dF1dzJYfPpGuS+08iOBw2D5FSFAfmmN/F1KAiepwD23IeZLqzXclV3Vzw1XhttUuBwUqR25ua1+k9GNo9Z6SjPYVQCQ3dGrfs/tD3jBd/GjNmRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781128341; c=relaxed/simple;
	bh=qDONElu3xhs1dhaLkWy+ArSwEXiXyBfiXLYq1aQNmhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYYHQ+ydIRQOUL0B/gbzOXnCiK5nG/kFJKfovHt2gsi1aUAgZZs3guDjh9DweTBIQTykDVgUX11qkJ7/1rOXCAKoa6oXtxQ52RMWDZmcwRygQE6ILxtftrnLF+5cAfXuF8qe650+Llo63cKUY6p8dMourVJ/POvMiS+d/sremYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+4zwo2e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+4zwo2e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 069751F00899;
	Wed, 10 Jun 2026 21:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781128339;
	bh=W+g0kURUWm2SFDjuoL2mOlxyHqR9oAnLpNooPEONMbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P+4zwo2e/bqdkChLsG9cX+I2A/MFHzKWT1uKGEs5De0pDpZ1RbzFRtextPzlBcc7u
	 E/bQLCaLcXZWyjnCzwHuw12ry//xdqb9i+4EjTEhdFC0hSXL6fNZPAmBCLw9XqYuqR
	 j0s4ZeyT5b9/TSno4gvcsznrHdtnC3EGJq/BzpCe9jew3FddUdF155WXAYl0B4KTSe
	 cpywZq4rLF3qWBegb6Cc1I1Ked6tsemD/f86yPQ929vyLcy4lDbFkeZHght5se4WCi
	 F4G9MKomJz/7j70K6sKpT2hsKORI8sTjlMN4A7xRSHyLCE8X2e8DZ5ES70nhOXyCQL
	 ghaTOoPDbpY+g==
Date: Wed, 10 Jun 2026 18:52:15 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 13/23] perf tools: Fix uninitialized pathname on
 uncompressed fallback in filename__decompress()
Message-ID: <aincj3a3BDJ22jfq@x1>
References: <20260610195157.2091137-14-acme@kernel.org>
 <20260610200810.8D93F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260610200810.8D93F1F00893@smtp.kernel.org>

On Wed, Jun 10, 2026 at 08:08:10PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [Medium] The commit message explicitly describes a logic flow that would cause a severe data-loss bug, while the code implements the opposite (safe) logic.
> 
> Pre-existing issues:
> - [High] Missing error code propagation and improper negative error handling cause `__open_dso` to mistakenly return valid file descriptors on failure.
> --
> 
> commit 5ae85aedfdb730a58a0d285fd77526ec0c92c20e
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> perf tools: Fix uninitialized pathname on uncompressed fallback in filename__decompress()
> 
> This commit addresses an issue where filename__decompress() left the
> pathname parameter uninitialized on the early return path for uncompressed
> files. The code is updated to set an empty string in this case, and
> callers are modified to check for this empty string condition.
> 
> > Fix by copying the original filename to pathname before the early return,
> > matching the behavior of the normal decompression path.
> 
> [Severity: Medium]
> Does this commit message accurately describe the implementation?
> 
> The code below sets pathname[0] = '\0' instead of copying the filename. If
> the code had copied the original filename as described here, wouldn't callers
> assume the populated pathname was a newly created temporary file and call
> unlink() on it, deleting the user's uncompressed kernel module or binary?

So this was the only non pre-existing issue found in this series, I
rebased it on top of the 28 patches I merged in perf-tools-next while
waiting for this last series to be reviewed and will do a full container
suite test build, then push everything publicly.

- Arnaldo
 
> [ ... ]
> 
> > diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> > index ee06a252a54d3..6a34717c9f31f 100644
> > --- a/tools/perf/util/dso.c
> > +++ b/tools/perf/util/dso.c
> > @@ -343,8 +343,11 @@ int filename__decompress(const char *name, char *pathname,
> >  	 * To keep this transparent, we detect this and return the file
> >  	 * descriptor to the uncompressed file.
> >  	 */
> > -	if (!compressions[comp].is_compressed(name))
> > +	if (!compressions[comp].is_compressed(name)) {
> > +		if (pathname && len > 0)
> > +			pathname[0] = '\0';
> >  		return open(name, O_RDONLY | O_CLOEXEC);
> 
> [Severity: High]
> This is a pre-existing issue, but if open() fails here, it returns -1
> without populating the *err pointer.
> 
> If open() fails, could this sequence occur?
> 
> filename__decompress()
>    returns -1 without setting *err
> 
> dso__get_filename() catches the failure:
>    errno = *dso__load_errno(dso); // errno is overwritten with 0
> 
> __open_dso() handles the NULL return:
>    fd = -errno; // results in fd = 0
> 
> Alternatively, if decompression fails later in this function, *err is
> populated with DSO_LOAD_ERRNO__DECOMPRESSION_FAILURE (which expands to
> -10005).
> 
> In that case, would errno become -10005, and fd = -(-10005) = 10005?
> 
> Since both 0 and 10005 are non-negative, does this cause callers to treat
> the operation as successful and attempt to read from standard input or a
> bogus file descriptor?
> 
> > +	}
> >  
> >  	fd = mkostemp(tmpbuf, O_CLOEXEC);
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260610195157.2091137-1-acme@kernel.org?part=13
