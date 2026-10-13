Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1A555408F;
	Tue, 13 Oct 2026 20:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924581; cv=none; b=BnV3+wN3pwfHPEOlIXdvyTeIaRQvqr0PFzSL3aehBoEkVmlHRL3Xg08QJhFFioEe+CEps+87hJhpkiWM7IlI0q635MD207BUPlw+KGFCB7FtmixMXxGjPKDw5tty79pD7jukyJstyvlHyd/KNwzfL08zMvUNBqex7erS5Wywnu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924581; c=relaxed/simple;
	bh=Abvg6add0/5i7xKTQmCMWUrzZ7UJf0kB51c5bxF0hlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qhAkYtQvUiscR9dqxQAd6VUA0pVK/QGmoBqz6feG3ndx+MGSTm3vHLafay1pfFgyQ3jtADnTyj8kzZTRKE7rkPj1Gi3IgGEyqPTFv+XCPVsTfQ/IiaCW0UvLdJOWwILvlp9v/f6xuIR8N7FR9T5vhGnZ892CYEU5gFFXCUNrAME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NoeYufws; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NoeYufws"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8EB1F000FF;
	Tue, 13 Oct 2026 20:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791924579;
	bh=mocG94rIykU+JVCHV3KlPT9EwN6iySKYcHDI9bsbA/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NoeYufwsN1r/utXl+j3JSf5ORbZVK9XCenf30reyiXTyBwINWWquK0xOlJ9JCYdxm
	 e8A7DIhwRzIdZ1yOlIixu4mIu+0nhuPrMWuDKiNnSjpp4CsD8XapYonKaeim4MLD0o
	 ZhPmKlwq6L01sgwLjhplQXg/T9aKcmgMmYhq0CwCtfpL+iaAXPXEL/l/LzJbLI65EI
	 +9wCvBXYKf8yBbja2vUGGWg5N9EOn6a+2jzj9dmNulYdWulJKp27CcOwF/mhyZ8sZ4
	 d500VWDeKRCxmgEV0fKSQOHDb/KQk09X0edxpssBjZJjXaikrbCWfUp/IkcPDS8xUn
	 H8sNvqxaVCoDA==
Date: Tue, 13 Oct 2026 13:49:38 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 02/11] perf tools: Check ELF section type with name
Message-ID: <as6ZYu8YcVjKB1YQ@google.com>
References: <20261013172155.160869-1-namhyung@kernel.org>
 <20261013172155.160869-3-namhyung@kernel.org>
 <sashiko-outbox-170233@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-170233@kernel.org>

On Tue, Oct 13, 2026 at 05:31:14PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] perf symbol-elf: uninitialized memory read on gelf_getshdr failure
> --
> 
> commit f2750bf0f2a1c49778b5a9d0173f02f48eb9e193
> Author: Namhyung Kim <namhyung@kernel.org>
> 
> perf tools: Check ELF section type with name
> 
> This commit updates filename__has_section() to verify that a section
> has the SHT_PROGBITS type instead of just checking its name. This prevents
> empty sections with SHT_NOBITS from being incorrectly identified as present.
> 
> > diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> > --- a/tools/perf/util/symbol-elf.c
> > +++ b/tools/perf/util/symbol-elf.c
> > @@ -228,7 +228,8 @@ bool filename__has_section(const char *filename, const char *sec)
> >  	if (gelf_getehdr(elf, &ehdr) == NULL)
> >  		goto elf_out;
> >  
> > -	found = !!elf_section_by_name(elf, &ehdr, &shdr, sec, NULL);
> > +	found = !!elf_section_by_name(elf, &ehdr, &shdr, sec, NULL) &&
> > +		shdr.sh_type == SHT_PROGBITS;
> 
> [Severity: Medium]
> Can this lead to an uninitialized memory read of shdr.sh_type if the ELF
> file is malformed?
> 
> Looking at elf_section_by_name(), it does not check the return value of
> gelf_getshdr():
> 
> tools/perf/util/symbol-elf.c:elf_section_by_name() {
>     ...
>     gelf_getshdr(sec, shp);
>     str = elf_strptr(elf, ep->e_shstrndx, shp->sh_name);
>     ...
> }
> 
> If gelf_getshdr() fails, it returns NULL and leaves the shp struct unmodified.
> Because shp points to the stack-allocated shdr in filename__has_section(),
> a failure in gelf_getshdr() leaves shdr potentially uninitialized.
> 
> Since this patch adds a direct read of shdr.sh_type after elf_section_by_name()
> returns, does this new check risk reading uninitialized stack memory?

Well.. it's already checked shp->sh_name is valid so I think it's ok.

But probably safer to check the return value.  It's also a separate
change though.

Thanks,
Namhyung
