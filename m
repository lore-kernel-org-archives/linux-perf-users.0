Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66E237DE9F;
	Tue,  6 Oct 2026 20:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791317184; cv=none; b=nAkFsGegbfq5qFAW+Go3ENLnsV/26btm57/uoI5v4iGA7n1vEJA7MBMlkbreOSmCHrWq8jvXyOKvz2v3/J/J3Oh51cNrtHPYFPX7Hhmjol4id3ubNqCEMxeNwXN8ozv4gU4GvyOruIEUZhtjVtFmRTDAdPtpfkZwOO4PZ4fX6T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791317184; c=relaxed/simple;
	bh=/IzRePGEBnuoXr3n+jKiL2hFoo3tRfwwEBN55y4ke7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CdJwOrLUScyIxliYcvk/Vp8Y+CflAPd9Z57xJqZBoG+noz1C86YGoqA5xLWCcYE8R4UhLkewSdjeBdlRDLPdMpdNdY9wRThW6zZaWgT4Sf0dklk8q8jLbuyNU+1dFqHeprczRvLWTy1tkcq5+hllwJigVTfeLjpTuFUIKHSYbrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mS2hyMv/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mS2hyMv/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F075A1F0089C;
	Tue,  6 Oct 2026 20:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791317183;
	bh=u62/uxUiO2xF3l0/Z6UzpcSaaNdYfsjanidcSTccQ70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mS2hyMv/27EuHH3LNqDwIC3NCFngXc4A/iKdPVxujGkRhcH3nu0iFNTQh8sPUiRxo
	 u7x+waaL6wNScBpg0oXO+fRT2utTlLkMTXMjhZvyhz9ofu7lUVOKu+0kVnHdYx7UeG
	 yGEIkS9BO5+zrjwjMDBGZI8lfQH/iVfbdSfl0bplme/VtkRQoL8/rvYgdXndMi/gbc
	 hg9sXcKh/wqe2bp1PGo15Q5LCGwXl2ZO/THmF089ZXesoGE324Pw3ajBlukULuRr/V
	 QTXGx0owkuX48/Lt1dJYNcUHSOA9m3Af6AxelvcVBlOYsCjQulFfzlPBYd6NDrgPRp
	 R2b7eWM8aOTnA==
Date: Tue, 6 Oct 2026 13:06:21 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Michal Pluta <michalpl2003@gmail.com>, acme@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] perf symbol: Grow the Rust demangle buffer
 geometrically
Message-ID: <asVUvfhz4wG5CnZC@google.com>
References: <20260928010227.1903673-1-michalpl2003@gmail.com>
 <20260928010227.1903673-4-michalpl2003@gmail.com>
 <CAP-5=fVe=VxnxypQYNt1h-s+3=Me8D_fpBL3LD1Eeb1cGvUc3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVe=VxnxypQYNt1h-s+3=Me8D_fpBL3LD1Eeb1cGvUc3g@mail.gmail.com>

On Mon, Sep 28, 2026 at 02:43:21PM -0700, Ian Rogers wrote:
> On Sun, Sep 27, 2026 at 6:02 PM Michal Pluta <michalpl2003@gmail.com> wrote:
> >
> > When a demangled Rust name doesn't fit in the provided buffer,
> > dso__demangle_sym() adds 32 bytes to it and formats the name again from
> > the start.  The number of attempts grows with the length of the output,
> > so the total work is quadratic.  Names with deeply nested generic types
> > need many attempts, leading to noticeable slowdowns in larger programs.
> >
> > Double the buffer instead, reaching the maximum buffer limit exactly
> > rather than stopping 32 bytes early.  The demangled names are
> > unchanged.
> >
> > Add a test for a symbol whose expansion exceeds the bound.
> >
> > Signed-off-by: Michal Pluta <michalpl2003@gmail.com>
> > ---
> >  tools/perf/tests/demangle-rust-v0-test.c | 12 ++++++++++++
> >  tools/perf/util/symbol.c                 | 10 ++++++++--
> >  2 files changed, 20 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/tests/demangle-rust-v0-test.c b/tools/perf/tests/demangle-rust-v0-test.c
> > index ee4ddb61174b..d1e0636d73bc 100644
> > --- a/tools/perf/tests/demangle-rust-v0-test.c
> > +++ b/tools/perf/tests/demangle-rust-v0-test.c
> > @@ -69,6 +69,18 @@ static int test__demangle_rust(struct test_suite *test __maybe_unused, int subte
> >                 free(buf);
> >         }
> >
> > +       /*
> > +        * A symbol with more lifetimes bound than fit in the largest buffer
> > +        * must fail to demangle rather than give a truncated name.
> > +        */
> > +       buf = dso__demangle_sym(/*dso=*/NULL, /*kmodule=*/0, "_RINvC1a1fFGZZZZZZ_EuE");
> > +       if (buf) {
> > +               pr_debug("FAILED: symbol larger than the buffer limit demangled to %zu bytes\n",
> > +                        strlen(buf));
> > +               ret = TEST_FAIL;
> > +               free(buf);
> > +       }
> > +
> >         return ret;
> >  }
> >
> > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > index 3cb42805a82f..1a52bc2980a0 100644
> > --- a/tools/perf/util/symbol.c
> > +++ b/tools/perf/util/symbol.c
> > @@ -2737,29 +2737,35 @@ char *cxx_demangle_sym(const char *str __maybe_unused, bool params __maybe_unuse
> >  }
> >  #endif /* !HAVE_CXA_DEMANGLE_SUPPORT */
> >
> > +/* Buffer limit for a demangled Rust symbol name. */
> > +#define RUST_DEMANGLE_MAX_LEN (1024 * 1024)
> > +
> >  char *dso__demangle_sym(struct dso *dso, int kmodule, const char *elf_name)
> >  {
> >         struct demangle rust_demangle = {
> >                 .style = DemangleStyleUnknown,
> >         };
> >         char *demangled = NULL;
> > +       size_t buf_len;
> 
> It seems changing the scope of this variable is unnecessary.
> 
> >
> >         /*
> >          * We need to figure out if the object was created from C++ sources
> >          * DWARF DW_compile_unit has this, but we don't always have access
> >          * to it...
> >          */
> >         if (!want_demangle((dso && dso__kernel(dso)) || kmodule))
> >                 return demangled;
> >
> >         rust_demangle_demangle(elf_name, &rust_demangle);
> >         if (rust_demangle_is_known(&rust_demangle)) {
> >                 /* A rust mangled name. */
> >                 if (rust_demangle.mangled_len == 0)
> >                         return demangled;
> >
> > -               for (size_t buf_len = roundup_pow_of_two(rust_demangle.mangled_len * 2);
> > -                    buf_len < 1024 * 1024; buf_len += 32) {
> > +               for (buf_len = min_t(size_t, roundup_pow_of_two(rust_demangle.mangled_len * 2),
> > +                                    RUST_DEMANGLE_MAX_LEN);
> > +                    buf_len <= RUST_DEMANGLE_MAX_LEN;
> > +                    buf_len *= 2) {
> 
> Thanks for digging into this problem and exploring a fix! Previously,
> we guessed the demangled length was twice the mangled length, then
> added 32 bytes for each retry. These were numbers I pulled out of thin
> air, so I'm glad you've found them to be wrong :-). Could we estimate
> the initial demangled size better? Could you get data from Bevy and
> Typst? I'm a little concerned that a demangled symbol of say just over
> 2KB might require 4KB with this change, instead of 2KB + 32bytes.

I guess it's hard to predict a good initial size as backrefs can make
long strings easily.  If we really care about the memory usage, how
about calling realloc() for the actual length at the end?

Thanks,
Namhyung

