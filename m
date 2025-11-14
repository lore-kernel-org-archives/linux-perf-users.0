Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E13287504;
	Fri, 14 Nov 2025 18:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763146635; cv=none; b=KFIy4p0jLwq+V3X/KBEGBGY1FT11zXyPlHdmRDxuVbi/v2qfRTdxByDvRyDOg+PmWnEZX+MmsssGsNVq8+lbcFmU4FhgvwlP07Bc+562Y77nDpzaBvi7/EuJgD7zxiLInTGbj4IkWmLktHmrrCxFcB0HedS9TB7W7U9SJ15Npv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763146635; c=relaxed/simple;
	bh=lYD3SZ9RO4v3fms8UESEkEBQASbTiZ6xYkrrrx/0ZVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRBd0AL4bNauDSXV3+8NO3oeJl0QgJrY2VbZkAT4rRM8jD5JNhrvUIotXr0MRLxfzZzk6tsz72Bb3yAcogHsrt41GClhh9K7P6KqOGvuGNhbotKGVA8GwXoYyzEHskXy4WfaF+wfN9UxDBguH/fuimtKKsbnheR7EQP+KeVc5OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZcNORuc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZcNORuc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DBC9C4CEF8;
	Fri, 14 Nov 2025 18:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763146634;
	bh=lYD3SZ9RO4v3fms8UESEkEBQASbTiZ6xYkrrrx/0ZVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NZcNORucU05v10ff3B6wb0F1tK8SOD10H5hwi8HooAwoIAkz+9yXonj46kfDNUFEa
	 5LoGhZvbe5neujtNqJIayr9qS/Tf91rlpN9L6AM40MtFDJBFq7qVVZl8AHq3WlurVy
	 Avwt6yCX8h8Hp6nwBzQN4SewNhN1tQ/N57wssuolO3IP8oMvKYAhGsy7+znA3VDcKl
	 2TdoZhCICxJH4vK/xhrakRVpzzDf20759QIWDaWgliL6XveF71YxAyS2AFJ69fvINT
	 7ChYugobKvf1cFqDrn0I2PLgtHPl283c+OJNobVkagaXqPlygUvTBXHpD192qCK0Gt
	 dG5EC+IRfNtLA==
Date: Fri, 14 Nov 2025 10:57:12 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	Pablo Galindo <pablogsal@gmail.com>
Subject: Re: [PATCH 1/2] perf jitdump: Add load_addr to build-ID generation
Message-ID: <aRd7iJJxgT-0G8Ky@google.com>
References: <20251114092914.217533-1-namhyung@kernel.org>
 <CAP-5=fWsFLkYGFFyzSrpZNdRLpjaTZAuW7-YVUr-zMVH5dk8eg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWsFLkYGFFyzSrpZNdRLpjaTZAuW7-YVUr-zMVH5dk8eg@mail.gmail.com>

On Fri, Nov 14, 2025 at 09:33:29AM -0800, Ian Rogers wrote:
> On Fri, Nov 14, 2025 at 1:29 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > It was reported that python backtrace with JIT dump was broken after the
> > change to built-in SHA-1 implementation.  It seems python generates the
> > same JIT code for each function.  They will become separate DSOs but the
> > contents are the same.  Only difference is in the symbol name.
> >
> > But this caused a problem that every JIT'ed DSOs will have the same
> > build-ID which makes perf confused.  And it resulted in no python
> > symbols (from JIT) in the output.
> 
> The lookup of a DSO involves the build ID and the filename. I'm
> confused as to why things weren't deduplicated and why no symbols
> rather than repeatedly the same symbol?

I don't know, but that's the symptom in the original bug report in the
python github (see Links: below).  I guess the behavior is
non-deterministic.

> 
> > Looking back at the original code before the conversion, it used the
> > load_addr as well as the code section to distinguish each DSO.  I think
> > we should do the same or use symbol table as an additional input for
> > SHA-1.
> 
> Hmm.. the build ID for the contents of the code should be a constant.
> As the build ID is a note for the entire ELF file then something is
> wrong with the filename handling it seems.

When it tries to load symbols from a DSO, it prefer reading from the
build-ID cache than the file system since it trusts build-IDs more than
the path name.  See dso__load() and binary_type_symtab[].

So having multiple DSO's with the same build-ID can be a problem if they
are in the build-ID cache.  Normally `perf inject -j` won't add the new
JIT-ed DSOs to the build-ID cache but it's still possible.

Thanks,
Namhyung

> 
> > This patch is a quick-and-dirty fix just to add each byte of the
> > load_addr to the first 8 bytes of SHA-1 result.  Probably we need to add
> > sha1_update() or similar to update the existing hash value and use it
> > here.  I'd like something that can be backported to the stable trees
> > easily.
> >
> > Fixes: e3f612c1d8f3945b ("perf genelf: Remove libcrypto dependency and use built-in sha1()")
> > Cc: Eric Biggers <ebiggers@kernel.org>
> > Cc: Pablo Galindo <pablogsal@gmail.com>
> > Link: https://github.com/python/cpython/issues/139544
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/genelf.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/tools/perf/util/genelf.c b/tools/perf/util/genelf.c
> > index 591548b10e34ef6a..a412e6faf70e37f3 100644
> > --- a/tools/perf/util/genelf.c
> > +++ b/tools/perf/util/genelf.c
> > @@ -395,6 +395,15 @@ jit_write_elf(int fd, uint64_t load_addr __maybe_unused, const char *sym,
> >          * build-id generation
> >          */
> >         sha1(code, csize, bnote.build_id);
> > +       /* FIXME: update the SHA-1 hash using additional contents */
> > +       bnote.build_id[0] += (load_addr >> 0) & 0xff;
> > +       bnote.build_id[1] += (load_addr >> 8) & 0xff;
> > +       bnote.build_id[2] += (load_addr >> 16) & 0xff;
> > +       bnote.build_id[3] += (load_addr >> 24) & 0xff;
> > +       bnote.build_id[4] += (load_addr >> 32) & 0xff;
> > +       bnote.build_id[5] += (load_addr >> 40) & 0xff;
> > +       bnote.build_id[6] += (load_addr >> 48) & 0xff;
> > +       bnote.build_id[7] += (load_addr >> 56) & 0xff;
> >         bnote.desc.namesz = sizeof(bnote.name); /* must include 0 termination */
> >         bnote.desc.descsz = sizeof(bnote.build_id);
> >         bnote.desc.type   = NT_GNU_BUILD_ID;
> > --
> > 2.52.0.rc1.455.g30608eb744-goog
> >
