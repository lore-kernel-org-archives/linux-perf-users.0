Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC56429BD87;
	Wed, 10 Jun 2026 16:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781110183; cv=none; b=UnsGhxGkhg9w7pm5qWXFknPATR9+sTPC1bDRgSE5+9smQaV1M5hK0HovotZ9rGItn5/rcGnmF/0EgZqEwMQTiomK+WI2Nd9m5y1ysFTDhNXS5PeZUGTVf/OBeTUKSO1KawJp/PuEpzHdtSj+IFpCLNoad82bnWz/LjpLqtGRWCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781110183; c=relaxed/simple;
	bh=O83XDOgikWm/aHQxtAdPOrc3rrnDEv1cE/AhbTEUy9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Na+y2IXq6O0LWlgMQyc/6y+H+jOU6fKcTi7eZLrtaGdoWrjn49zem98bc4kTK4LY5fgZFsj927nAgTWhW/CaX8AFykrpJ4J6+IxgNdOy9OdtSAgum/FyJuLdizsKqza7AUhv7GJOB11LTxVM2r/oHp63RHJt2uQYgZVCaPFwscQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2Lvnip7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2Lvnip7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB221F00893;
	Wed, 10 Jun 2026 16:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781110182;
	bh=1K4C5cPKeYBdJTzXedsW1nCTfxrxNHI7dcozTp6DT1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F2Lvnip7EbfPISM9okFIkEP3k/JuVV/mi5jQjJMdpqRP598a7cwItWjA3UcSVqn9B
	 LnePM/QC/qThnGvBw23vPIqr5fsOCzoQEG9u2eziLsHEXfZDuRpef2JGVaL6XAsmy1
	 6WYzTenlEuLDmqmS19lInwBMlJoaGeqqc0kXBLE8R7/BTpjhxqZYbnPEXItLvnHQ/5
	 3fSS5ogoFanq8uFf0VsYZrRS+Fserz2CM+XycOr4/SPH9dtwgAwjZApmcYuYea2q64
	 fFzOopGjVgoi3L4dSjK72UcHa4901HrDmSmU9DTrzwWx/30d5R57CfNfG6D/F7Ljm3
	 h+t2XmzVUumPw==
Date: Wed, 10 Jun 2026 13:49:37 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 07/11] perf tools: Add O_CLOEXEC to open() calls in DSO
 and ELF code
Message-ID: <aimVobFTV8MZ0pFy@x1>
References: <20260609010526.1998472-8-acme@kernel.org>
 <20260609011626.DE73D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260609011626.DE73D1F00893@smtp.kernel.org>

On Tue, Jun 09, 2026 at 01:16:26AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] Incomplete fix for file descriptor leaks in DSO and ELF code.
> 
> Pre-existing issues:
> - [Critical] Stack buffer overflow in sysfs__read_build_id when skipping non-matching GNU notes.
> --
> 
> commit 66274b4049c9a2092defa7caf237fe0295853d9c
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> perf tools: Add O_CLOEXEC to open() calls in DSO and ELF code
> 
> The commit adds O_CLOEXEC to open() calls in dso.c and symbol-elf.c to
> prevent leaking file descriptors to child processes during symbol
> resolution.
> 
> > diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> > index 7dced896c64ea..fb2e78fe2aa8e 100644
> > --- a/tools/perf/util/dso.c
> > +++ b/tools/perf/util/dso.c
> > @@ -344,7 +344,7 @@ int filename__decompress(const char *name, char *pathname,
> >  	 * descriptor to the uncompressed file.
> >  	 */
> >  	if (!compressions[comp].is_compressed(name))
> > -		return open(name, O_RDONLY);
> > +		return open(name, O_RDONLY | O_CLOEXEC);
> >  
> >  	fd = mkstemp(tmpbuf);
> 
> [Severity: High]
> Since the goal of this patch is to prevent leaking file descriptors to child
> processes, should we also address the mkstemp() calls in these files?
> 
> mkstemp() creates file descriptors without O_CLOEXEC. For instance, here in
> filename__decompress(), the temporary file descriptor will still be leaked.
> Should mkostemp(tmpbuf, O_CLOEXEC) be used instead?

This is fixed in the next patch series.
 
> [ ... ]
> > diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> > index 186e6d92ac3d7..c2bdfd0003df2 100644
> > --- a/tools/perf/util/symbol-elf.c
> > +++ b/tools/perf/util/symbol-elf.c
> [ ... ]
> > @@ -935,7 +935,7 @@ int sysfs__read_build_id(const char *filename, struct build_id *bid)
> >  	size_t size = sizeof(bid->data);
> >  	int fd, err = -1;
> >  
> > -	fd = open(filename, O_RDONLY);
> > +	fd = open(filename, O_RDONLY | O_CLOEXEC);
> >  	if (fd < 0)
> >  		goto out;
> 
> [Severity: Critical]
> This is a pre-existing issue, but while reviewing this function, could
> an unbounded read() happen later in sysfs__read_build_id() when skipping
> non-matching GNU notes?
> 
> If a crafted sysfs note has a maliciously large nhdr.n_descsz, the code does:
> 
>     } else if (read(fd, bf, descsz) != (ssize_t)descsz)
> 
> Since bf is a fixed-size stack array (char bf[BUFSIZ]), could this read past
> the end of bf and overwrite the stack frame if descsz exceeds BUFSIZ?

Ditto, as several other issues you reported in this series and in other
series.

- Arnaldo
 
> [ ... ]
> > @@ -1985,7 +1985,7 @@ static int kcore__init(struct kcore *kcore, char *filename, int elfclass,
> >  	if (temp)
> >  		kcore->fd = mkstemp(filename);
> >  	else
> > -		kcore->fd = open(filename, O_WRONLY | O_CREAT | O_EXCL, 0400);
> > +		kcore->fd = open(filename, O_WRONLY | O_CREAT | O_EXCL | O_CLOEXEC, 0400);
> >  	if (kcore->fd == -1)
> >  		return -1;
> 
> [Severity: High]
> Similarly to the issue in filename__decompress(), if temp is true here,
> mkstemp() is called without O_CLOEXEC.
> 
> There is also a similar mkstemp() call in read_gnu_debugdata() in this file
> that extracts debug data without O_CLOEXEC. Should all of these be updated
> to prevent leaking file descriptors?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260609010526.1998472-1-acme@kernel.org?part=7
