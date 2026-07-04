Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECCE13D891;
	Sat,  4 Jul 2026 16:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783181810; cv=none; b=dRi0MQ1yDGHDCDWUP5su4pwvNTGuQBTCC5lXc0/B+GMvoDeRscUh36UIHbI7bxkCopESahb2ERY/DtunVXPw/c11goisI2vZyI/wuZQ3Dj56y0z11Toy45yh6J8bpGQoVAmaQM2i38y4L5yGKA9O22i1KegxO737rNuoKT4UtWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783181810; c=relaxed/simple;
	bh=9cf3J09n7d21AiaS/704+qLyywH8NgM+GsH5lj7JNtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZO4/naMGLX9bt08pTONJosSe4HncaQ2VZWe/jtqmrEcppzx5IgDeJeA8F6RBpDHukhd2mr6u+ziZWNRlCMaCIrfVraY1bruHTnMFXKvYsvPKJ4J/tgkXAe2CXVscHvqueAOzKdRDiQhurKMiMfIhYKuMTdekBxlZbZOoSp9OT3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThisLgyZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThisLgyZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC2D1F000E9;
	Sat,  4 Jul 2026 16:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783181808;
	bh=Yu2SypPL876PEV9aoxCcuXzto8/BMaas2Cd+wYKhEaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ThisLgyZ4A1XT+9oTsEruSBjdOWcTgoI2O3iADZ3w50Xvp1MpQyPk5CzaNWyszFiX
	 r19G6W4cd5BjxmpNy7tHaYfBX18px0DG7tjtON1yemdkYM1OHIw06pW592D4W2Uijn
	 ZAT2s/OGmiQEVfgOyglDSMFg3Yo7grlT/fRRycMnTWu6b2lYxIWtyQqAaFJguvNMcb
	 5I14JYlkbzmZLa6EjRbhhAB+9m6UacrQ5dT4YarW7rJfY8fSgLJxl+YwtPAkZl9820
	 D1VhIFXdyJDccHrdsRwZnmIM3SkAaMd4tH9bd0C14YnqguG5w0ZVIrD1yTYn+O27bf
	 5yGZBRi4hCVmA==
Date: Sat, 4 Jul 2026 09:16:45 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Trevor Allison <tallison@redhat.com>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf build: Add LDFLAGS to dlfilters .so link
Message-ID: <akkx7cDfBb1pBdIw@google.com>
References: <20260626182739.53294-1-tallison@redhat.com>
 <20260626183423.ADD211F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260626183423.ADD211F000E9@smtp.kernel.org>

On Fri, Jun 26, 2026 at 06:34:23PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Adding `$(LDFLAGS)` to the unconditionally built `dlfilters` shared library link rule breaks statically linked `perf` builds.
> --
> 
> commit 18f2c24db710920618ef1d894a2b24abff4dbeb9
> Author: Trevor Allison <tallison@redhat.com>
> 
> perf build: Add LDFLAGS to dlfilters .so link
>     
> Build-time linker flags were not applied when linking dlfilters.
> Pass LDFLAGS for consistency with the other link rules.
> 
> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > index 476b8dcaef58c..f2294a6d89604 100644
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
> > @@ -677,7 +677,7 @@ $(OUTPUT)dlfilters/%.o: dlfilters/%.c include/perf/perf_dlfilter.h
> >  .SECONDARY: $(DLFILTERS:.so=.o)
> >  
> >  $(OUTPUT)dlfilters/%.so: $(OUTPUT)dlfilters/%.o
> > -	$(QUIET_LINK)$(CC) $(EXTRA_CFLAGS) -shared -o $@ $<
> > +	$(QUIET_LINK)$(CC) $(LDFLAGS) $(EXTRA_CFLAGS) -shared -o $@ $<
> 
> [Severity: Low]
> Does this break static builds of perf?
> 
> If a user builds perf statically by setting LDFLAGS="-static", this rule
> will pass both "-static" and "-shared" to the linker. Since these flags are
> mutually exclusive, this results in a fatal linker error.

Oops, I missed this message and merged it.  It indeed caused a failure 
in the build test.  It seems we should skip building dlfilters when the
LDFLAGS has -static or remove -static from the LDFLAGS for dlfilters.

Thanks,
Namhyung
