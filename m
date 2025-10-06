Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7DB1F7098;
	Mon,  6 Oct 2025 18:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759776535; cv=none; b=g6k+awgwVGjbOO6RMnDJbPej+bXJ/8BelYoNwncxlJZaryj45wJQyAErrnw2h1qLs5ti4zwFKwHwEAmLaVPuIzrI63do8DX9nWERsuIsn84KminTGlDXrdGizYOK+YT3/2JVVTebWmRN9qfMAcnNr+WjqtqgXMyckjB+vgvtgjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759776535; c=relaxed/simple;
	bh=rcIVOSltuO8gB9UARzera3hSNz+GSt4EaNpkP0kh+qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGzjo1nUZiOehIHMiRsAIAv71Gl8RpzS7odkQGEmjpeM5SPu8hNLeDhIE+ERDOz08raLAjCqiQ+FoRRGCCuJ+ByvhU6/okkPWFqfkhwC1hNzwn9rONFUvQISIdw33gFME4R/VSYL4E7rpkHpoVBL6i1seoKEAKREC4ZvHuTI3Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fk7bj3R/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fk7bj3R/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B34EC4CEF5;
	Mon,  6 Oct 2025 18:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759776534;
	bh=rcIVOSltuO8gB9UARzera3hSNz+GSt4EaNpkP0kh+qg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fk7bj3R/tUTYNz3QS0QZyAQjypJVsDgjgfnhTEDYgI3uMVu8xt4XumnktxefaHOwm
	 lEdaKew/4XH5LzBMx4aj5O9n/xDzvU7wmnbHrc6uqty/sVHj14C6tjtRdxf5O8F+2h
	 EQkobofuSnYb4+DM5ivSgDH8C/hBTYV0b3XoJ6rDaUZ7b3xS9huUV3mPe4rCcfDv9X
	 aeUNRoUggJCX7xfQYUD9iimK5j+w3Gl2oMwdOyXitjfjpZwLMktaT/s9zJtEP/KpeF
	 IDm3XgasEFWsyYky2SvPW29YOo/7f4vvMtjyRwFAFwKvpcOwoEfEZs/d5aHrpxMb1M
	 Iw7SshajQScBA==
Date: Mon, 6 Oct 2025 15:48:51 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Leo Yan <leo.yan@arm.com>, Namhyung Kim <namhyung@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 4/9] perf build: Disable thread safety analysis for
 perl header
Message-ID: <aOQPE33mYPVYnkl5@x1>
References: <20251006-perf_build_android_ndk-v3-0-4305590795b2@arm.com>
 <20251006-perf_build_android_ndk-v3-4-4305590795b2@arm.com>
 <CAP-5=fUVs8Dn+kQDgPW08SNC=W5ZQKMFEETjjqkOJ_Mvbv22dw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUVs8Dn+kQDgPW08SNC=W5ZQKMFEETjjqkOJ_Mvbv22dw@mail.gmail.com>

On Mon, Oct 06, 2025 at 10:56:43AM -0700, Ian Rogers wrote:
> On Mon, Oct 6, 2025 at 9:21 AM Leo Yan <leo.yan@arm.com> wrote:
> >
> > When build with perl5, it reports error:
> >
> >     In file included from /usr/lib/perl5/5.42.0/x86_64-linux-thread-multi/CORE/perl.h:7933:
> >     /usr/lib/perl5/5.42.0/x86_64-linux-thread-multi/CORE/inline.h:298:5: error:
> >           mutex 'PL_env_mutex.lock' is not held on every path through
> >           here [-Werror,-Wthread-safety-analysis]
> >       298 |     ENV_UNLOCK;
> >           |     ^
> >     /usr/lib/perl5/5.42.0/x86_64-linux-thread-multi/CORE/perl.h:7091:31: note:
> >           expanded from macro 'ENV_UNLOCK'
> >      7091 | #  define ENV_UNLOCK          PERL_REENTRANT_UNLOCK("env"...
> >           |                               ^
> >     /usr/lib/perl5/5.42.0/x86_64-linux-thread-multi/CORE/perl.h:6465:7: note:
> >           expanded from macro 'PERL_REENTRANT_UNLOCK'
> >      6465 |     } STMT_END
> >           |       ^
> >     /usr/lib/perl5/5.42.0/x86_64-linux-thread-multi/CORE/perl.h:865:28: note:
> >           expanded from macro 'STMT_END'
> >       865 | #   define STMT_END     while (0)
> >           |                                ^
> >
> > The error is caused by perl header but not perf code, disable thread
> > safety analysis if including the header.
> >
> > Though GCC does not support the thread safety analysis option, this
> > negative warning flag is silently ignored by it.
> >
> > Signed-off-by: Leo Yan <leo.yan@arm.com>
> > ---
> >  tools/perf/scripts/perl/Perf-Trace-Util/Build | 2 +-
> >  tools/perf/util/scripting-engines/Build       | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/scripts/perl/Perf-Trace-Util/Build b/tools/perf/scripts/perl/Perf-Trace-Util/Build
> > index 9b0e5a8b5070f1a1640518fae75557f824ef21ee..01a1a0ed51aefd721b4bc7eba728c29a8ffcd551 100644
> > --- a/tools/perf/scripts/perl/Perf-Trace-Util/Build
> > +++ b/tools/perf/scripts/perl/Perf-Trace-Util/Build
> > @@ -2,7 +2,7 @@ perf-util-y += Context.o
> >
> >  CFLAGS_Context.o += $(PERL_EMBED_CCOPTS) -Wno-redundant-decls -Wno-strict-prototypes -Wno-bad-function-cast -Wno-declaration-after-statement -Wno-switch-enum
> >  CFLAGS_Context.o += -Wno-unused-parameter -Wno-nested-externs -Wno-undef
> > -CFLAGS_Context.o += -Wno-switch-default -Wno-shadow
> > +CFLAGS_Context.o += -Wno-switch-default -Wno-shadow -Wno-thread-safety-analysis
> 
> I wasn't able to reproduce this on Debian with perf-tools-next and:
> make -C tools/perf O=/tmp/perf DEBUG=1 CC=clang CXX=clang++
> HOSTCC=clang LIBPERL=1 clean all
> but my libperl is 5.40. I'm a little concerned that the warning may
> cause an unrecognized compiler option warning/error with GCC given
> progress on thread-safety-analysis has ended there. Anyway, these
> aren't blockers.
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

I was a bit wary and saw this on only, IIRC Manjaro Linux, and since
libperl support is opt-in, I left it in the backburner, but having it
building there as well may help detecting some other stuff with things
only enabled/present there, so thanks Leo and Ian, for the patch and the
Reviewed-by, applying.

- Arnaldo
