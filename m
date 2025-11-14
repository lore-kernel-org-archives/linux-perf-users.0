Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074F92C21CD;
	Fri, 14 Nov 2025 23:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763162689; cv=none; b=nBc2lvOHTc6tHSHdZ5Cs/vzD2vRgQaJpTcXJZfkMh8XyS1yRs1mQQ5DHqyy+PBj8tKuTYPGpvqlJBJtmMJDFUNPv0jAO+jkJH49N/bMksFoXeqBg2WRPHL4XTijtBH3/A8/VQ7SDoaZjJr/tT5ZFsoV8HW+zGI6GqyNv8VnbroA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763162689; c=relaxed/simple;
	bh=yuS0cJJC/rVpG3pADiOVbFeubmBFm8dq0WtbD5vF0Jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rm1LZZEafgjptVEuXFSyYwaaSRek7qiJqVY9nMIYJ+yFA3ZCpc9GCPhHTVGaZRBGEVPAmqpnRzupeb37NoWTPJ7LL0jxgNW8itxfxWexWhbQudVXXE9Xyohikqtcgm4kBnPPpuTI9ee6p2agdQsYa8M0hLs/ZwtF/8G4LGZV19E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1LfHzsL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1LfHzsL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648ECC4CEF1;
	Fri, 14 Nov 2025 23:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763162688;
	bh=yuS0cJJC/rVpG3pADiOVbFeubmBFm8dq0WtbD5vF0Jw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X1LfHzsLr18OURWSYDi/tIuXhydVHQf04N0WSdKhaq79HcoA3rop4kkCIMBFm5PfR
	 qDQUEVWoEiY7bVXWtcbGYE94rv7VqBoWggxRen19Ua6Hc9O7Gsy+muEwMMXV2LbU91
	 erNcDOhMAWQJCsRDqlYvO3/OfHijWUflIXJL+FxILwjNt3Kt1lYH7FZ21cNNl9NJPF
	 LVItRFA8Z6kyaBFGDNzVF/wdJD4nsWwVaZRgmgN8am5i2GjMW2PXbjPGf6EVs18/fm
	 Qgr5c8fRSTb9PsouxIzro/Rupmpr5jatsYFdG8AKYXhRikZLk3J48P7ihbFxP3Cd5s
	 rfuZPF3+T+cBg==
Date: Fri, 14 Nov 2025 15:24:46 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: maskray@sourceware.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	Pablo Galindo <pablogsal@gmail.com>
Subject: Re: [PATCH 1/2] perf jitdump: Add load_addr to build-ID generation
Message-ID: <aRe6PnZ1rk2oOz85@google.com>
References: <20251114092914.217533-1-namhyung@kernel.org>
 <CAP-5=fWsFLkYGFFyzSrpZNdRLpjaTZAuW7-YVUr-zMVH5dk8eg@mail.gmail.com>
 <aRd7iJJxgT-0G8Ky@google.com>
 <CAP-5=fUC88TVwnjTuTgU+s=LqqP0xOhNTG5hU27cSbaZRH7Jpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUC88TVwnjTuTgU+s=LqqP0xOhNTG5hU27cSbaZRH7Jpg@mail.gmail.com>

On Fri, Nov 14, 2025 at 11:32:52AM -0800, Ian Rogers wrote:
> On Fri, Nov 14, 2025 at 10:57 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Fri, Nov 14, 2025 at 09:33:29AM -0800, Ian Rogers wrote:
> > > On Fri, Nov 14, 2025 at 1:29 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > It was reported that python backtrace with JIT dump was broken after the
> > > > change to built-in SHA-1 implementation.  It seems python generates the
> > > > same JIT code for each function.  They will become separate DSOs but the
> > > > contents are the same.  Only difference is in the symbol name.
> > > >
> > > > But this caused a problem that every JIT'ed DSOs will have the same
> > > > build-ID which makes perf confused.  And it resulted in no python
> > > > symbols (from JIT) in the output.
> > >
> > > The lookup of a DSO involves the build ID and the filename. I'm
> > > confused as to why things weren't deduplicated and why no symbols
> > > rather than repeatedly the same symbol?
> >
> > I don't know, but that's the symptom in the original bug report in the
> > python github (see Links: below).  I guess the behavior is
> > non-deterministic.
> >
> > >
> > > > Looking back at the original code before the conversion, it used the
> > > > load_addr as well as the code section to distinguish each DSO.  I think
> > > > we should do the same or use symbol table as an additional input for
> > > > SHA-1.
> > >
> > > Hmm.. the build ID for the contents of the code should be a constant.
> > > As the build ID is a note for the entire ELF file then something is
> > > wrong with the filename handling it seems.
> >
> > When it tries to load symbols from a DSO, it prefer reading from the
> > build-ID cache than the file system since it trusts build-IDs more than
> > the path name.  See dso__load() and binary_type_symtab[].
> >
> > So having multiple DSO's with the same build-ID can be a problem if they
> > are in the build-ID cache.  Normally `perf inject -j` won't add the new
> > JIT-ed DSOs to the build-ID cache but it's still possible.
> 
> +Fangrui
> 
> I'm surprised that build IDs don't include symbol names but:
> ```
> $ cat a.s
> .text
> .global main
> .global foo
> main:
> foo:
>        ret
> $ cat b.s
> .text
> .global main
> .global bar
> main:
> bar:
>        ret
> $ gcc -Wl,--build-id a.s -o a.out
> $ gcc -Wl,--build-id b.s -o b.out
> $ readelf -n a.out
> ...
>    Build ID: 9dd0371b953db5d72929af5d98552e4ee1043616
> ...
> $ readelf -n b.out
> ...
>    Build ID: 9dd0371b953db5d72929af5d98552e4ee1043616
> ...
> ```
> so ugh. Perhaps we need to have jitdump make a single object file (and
> so 1 build ID) but with multiple unique symbols.

Right, that'd be better.  But I'm afraid some JIT code could spread to
many segments so it's not possible to create a map to cover all areas
due to conflicts with other libraries.

Thanks,
Namhyung

