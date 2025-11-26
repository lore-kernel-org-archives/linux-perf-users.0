Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2422B1C84A0;
	Wed, 26 Nov 2025 03:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764126404; cv=none; b=l5fZlKQsiMNjg76xL16M0U4HgTKRwbrLqC6Ewlx/OInomvDqwD4ig/3tlvCt1k/PRCR5VdrHjHlJo3DBa93pahUbSXcA3Zq/mTJYhzY+bIpHXUcoKbod82SPguwT4kPQuXsGAygeUhHtWhEn2O1ltyg0utFIWzl/dIUfU/oHKpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764126404; c=relaxed/simple;
	bh=MBJAYOFJwbgOrAqN6DfhZVL9wvz/JBv9GTu7o4AoKUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQBNVD0OseQyZeUyV0sAuP47gB/dl5+XQbUMIYPPSmf28BvpCRBflPWg8pxeuSd800KudK7ejkIFAnqt3kAyJPsAyWK2FfB5SAf2EpDOlRi1auJP2rNN2nj8++N26Z6VOdv6Gh1GWuZ7/MSsSduZDUKeEsFOfO89TlKR1BW5KtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEkDdXy8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEkDdXy8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BFABC4CEF1;
	Wed, 26 Nov 2025 03:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764126403;
	bh=MBJAYOFJwbgOrAqN6DfhZVL9wvz/JBv9GTu7o4AoKUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KEkDdXy8Kq8fxFsIh7Xu9T9yhHxTkzo+sBG4wORwhfZBl7CY5QsUGBfH47n3EJPOB
	 Ltfo8/Q6/NSiFzbskon6ZPhEymCKMMlExj8cM3C+JnWuEIK/zLSF3g5+g6nOT6at7y
	 7xSpwmOvbIFmUO4PnNa+T7f87uW1mUvz7G+I3vDlFVD+2EZXvj+lG0LBPSGxCgHdDh
	 pFW66NN6dvy0CRNqVpdA9njbTkraFom4Y5eOivopsXWCVGg/RdAz+8l7KFKPxOJJVP
	 zBZcgasTmBFy6g57n6Wb3K5B9puRZ6JWB0NUTiMNLiTUfUOiDTEl68sN8VQELdrYF+
	 5KgCjWnTC9KOg==
Date: Tue, 25 Nov 2025 19:04:52 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Pablo Galindo <pablogsal@gmail.com>,
	Fangrui Song <maskray@sourceware.org>
Subject: Re: [PATCH v2 1/2] perf jitdump: Add sym/str-tables to build-ID
 generation
Message-ID: <20251126030452.GA85316@sol>
References: <20251125080748.461014-1-namhyung@kernel.org>
 <20251125192943.GA3061247@google.com>
 <CAP-5=fXh82HpvLhPr9uFtq=HK5V+ZL3xntz7-gspEE5az2+7nw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXh82HpvLhPr9uFtq=HK5V+ZL3xntz7-gspEE5az2+7nw@mail.gmail.com>

On Tue, Nov 25, 2025 at 06:55:39PM -0800, Ian Rogers wrote:
> On Tue, Nov 25, 2025 at 11:29 AM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > On Tue, Nov 25, 2025 at 12:07:46AM -0800, Namhyung Kim wrote:
> > > It was reported that python backtrace with JIT dump was broken after the
> > > change to built-in SHA-1 implementation.  It seems python generates the
> > > same JIT code for each function.  They will become separate DSOs but the
> > > contents are the same.  Only difference is in the symbol name.
> > >
> > > But this caused a problem that every JIT'ed DSOs will have the same
> > > build-ID which makes perf confused.  And it resulted in no python
> > > symbols (from JIT) in the output.
> > >
> > > Looking back at the original code before the conversion, it used the
> > > load_addr as well as the code section to distinguish each DSO.  But it'd
> > > be better to use contents of symtab and strtab instead as it aligns with
> > > some linker behaviors.
> > >
> > > This patch adds a buffer to save all the contents in a single place for
> > > SHA-1 calculation.  Probably we need to add sha1_update() or similar to
> > > update the existing hash value with different contents and use it here.
> > > But it's out of scope for this change and I'd like something that can be
> > > backported to the stable trees easily.
> > >
> > > Fixes: e3f612c1d8f3945b ("perf genelf: Remove libcrypto dependency and use built-in sha1()")
> > > Cc: Eric Biggers <ebiggers@kernel.org>
> > > Cc: Pablo Galindo <pablogsal@gmail.com>
> > > Cc: Fangrui Song <maskray@sourceware.org>
> > > Link: https://github.com/python/cpython/issues/139544
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> >
> > That commit actually preserved the behavior of the existing variant of
> > gen_build_id() that was under #ifdef BUILD_ID_SHA.  So I guess that code
> > was always broken, and it was just never noticed because the alternative
> > variant of gen_build_id() under #ifdef BUILD_ID_MD5 was used instead?
> >
> > The MD5 variant of gen_build_id() just hashed the load_addr concatenated
> > with the code.  That's not what this patch does, though.  So just to
> > clarify, you'd actually like to go with a third approach rather than
> > just restoring the original hash(load_addr || code) approach?
> >
> > Also, I missed that you had actually changed the hash algorithm.  I had
> > assumed the perf folks were were pushing SHA-1 because they were already
> > using it.  Given that the algorithm changed, there must not be any
> > backwards compatibility concerns here, and you should switch to a modern
> > hash algorithm such as SHA-256 instead.
> >
> > I'd be glad to add an incremental API if you need it, but I'm confused
> > why you want SHA-1 and not a modern hash algorithm.
> 
> Hi Eric,
> 
> Thanks for the help with the hash functions! There's a bit more
> context in this thread:
> https://lore.kernel.org/linux-perf-users/CAP-5=fWLgaWsv82dcPajVk=UmBbmwyEd7OVp6psZQ4TiXh-Meg@mail.gmail.com/
> 
> So genelf is trying to take snippets of jitted code and create ELF
> files from them for the purpose of symbolizing in perf. The buildid
> hash being used is SHA1 and I think the MD5 support was removed as
> unnecessary. The problem this patch is addressing is that a JIT may
> create many identical stubs which then end up being deduplicated into
> the same buildid as only the code is hashed. The BFD linker seems to
> have the same issue (Fangrui filed a bug), gold and lld appear to hash
> the symbols (which Namhyung adds to genelf here) but still yield
> different build id for the same source assembly code. It is possible
> to hash the address of the symbol rather than the symbol itself, but I
> think the intent for the code should be to best match what a compiler
> and linker would generate. The problem there is that this differs for
> every linker :-)
> 
> Something that is unfortunate in the code now is copying/concatenating
> all the build data for the sake of producing the hash. It would be
> nice if the code could incrementally build up the sha1 hash to avoid
> the copying. I don't know if there is functionality for this
> currently.

Again, I can add support for incremental hashing if you need it.  But I
don't understand why you want the hash function to be SHA-1.  Also,
given that this seems to be a regression fix, it's surprising that
you're suddenly changing the inputs to the hash entirely, instead of
just going back to hashing load_addr concatenated with the code for now.

- Eric
