Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5754C545DAD;
	Tue, 13 Oct 2026 20:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791922890; cv=none; b=ItYw+aQh2lxInpQLRKzMa99V0IWVvTpCyANWiTslcPid1KISAQruikTqPc/wLLBmkpQH2VR3vKeuhfyxGW/n6cKvDzEwhSBmFitQaKpMVqQBbh8LBEdPmXpL3KhTYMyefj8oHn1ZTfU8bTcRl2O86/OFk8sK6D+83iQIhERIKZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791922890; c=relaxed/simple;
	bh=WRAGDn7uCmRLheSmi5D6snHxgOOKfZ9bK4tZ6R0MVWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVq4X3l8pwZdHuKBhWjH+XrJqJxFtp+D4g9htFvDBzb4rIPRS3NbqZbAnHsykyE0RcdWSgoDOUlqY8bTSfZ6jIHS9ZP5gNBDSUXp1Xle/C/omb8XrA3sfiwl19v0aJU7ntsOmgZkQ7eYzO3uJAIzn5BVZ/gfp1RkiJUJdep2xiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hR0j/mmI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hR0j/mmI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B8C1F000FF;
	Tue, 13 Oct 2026 20:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791922888;
	bh=ab6c6ZHScbVpnYjiLAZ028mdAsaw1iZNpJzunrJ6AE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hR0j/mmIs/jflTlFf8nucxYJwIMbuVpKE6T8gy3xb1sBc43+cNwpyVViOJQeg5qeB
	 2hEExDOwcm+RxSgraplo2IynXsGIFRbozNASmpp8EQsQ2o1CwyTbufqNQL9ARlBtv2
	 mB449PVMKdnk3lXQkD2w3x0o5WzctmhxN8P65H8qJLjkjZcJw6aIpN5qMMt+REKimF
	 F/vnGoBQiVkf6Q28Pq38+0dwKD6evg85XV4FUhLG+lHyjD3CX7aiWAMfQSMd4bNOVO
	 rx+b4InLpkZBni3CzoDlW4bk5nuSYx2otmdYFxTutOhEpkRW6vT/I4Jx1gBmEEjCZK
	 w/gQWss9qoitw==
Date: Tue, 13 Oct 2026 17:21:25 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
	Namhyung Kim <namhyung@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>, linux-kbuild@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/6] tools: build perf in tools_build
Message-ID: <as6SxXELnoIJenIX@x2>
References: <20261011233647.2454648-1-sashal@kernel.org>
 <20261011233647.2454648-4-sashal@kernel.org>
 <CAP-5=fWFY-tpJz2vcBZvurwdZY5gwd8cuTemE9q1rtZ0Vi0dng@mail.gmail.com>
 <20261013170854.647305-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013170854.647305-1-sashal@kernel.org>

On Tue, Oct 13, 2026 at 01:08:53PM -0400, Sasha Levin wrote:
> On Mon, Oct 12, 2026 at 03:07:10PM -0700, Ian Rogers wrote:
> > On Sun, Oct 11, 2026 at 4:36 PM Sasha Levin <sashal@kernel.org> wrote:
> > > +# Every optional feature off, so the result does not depend on which
> > > +# libraries are installed
> > > +perf-flags-$(CONFIG_TOOLS_BUILD_PERF_MINIMAL) += \
> > > +       NO_LIBELF=1 NO_LIBTRACEEVENT=1 NO_JEVENTS=1 NO_LIBPYTHON=1 NO_LIBDW=1 \
> > > +       NO_LIBBPF=1 BUILD_BPF_SKEL=0 NO_SLANG=1 NO_GTK2=1 NO_AIO=1 \
> > > +       NO_BACKTRACE=1 NO_DEMANGLE=1 NO_LZMA=1 NO_LIBZSTD=1 NO_ZLIB=1 \
> > > +       NO_LIBNUMA=1 NO_LIBUNWIND=1 NO_LIBLLVM=1 NO_CAPSTONE=1 NO_LIBPFM4=1 \
> > > +       NO_SDT=1 NO_JVMTI=1 NO_LIBDEBUGINFOD=1 NO_BABELTRACE2=1 NO_RUST=1 \
> > > +       NO_SHELLCHECK=1 NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1

> > It seems unfortunate to maintain this list here, we also have a
> > minimal target as a build test here:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/tests/make?h=perf-tools-next#n123
> > I wonder we should just add support for a MINIMAL=1 variable in
> > tools/perf/Makefile.config and have that set these other variables.
 
> Yup :(
 
> What allmodconfig really wants from perf is what allmodconfig already does for
> the kernel: build everything the environment supports and skip the rest. A
> kernel option that needs something the toolchain lacks just ends up off rather
> than breaking the build.
 
> perf has no mode like that I think? A default build fails when libelf,
> libtraceevent or python is missing, so an arm64 cross build, or a native build
> without libtraceevent-dev, breaks. Turning everything off was the only way I
> found around that.
 
> Would it make sense to add such a mode to perf instead of MINIMAL=1?  A missing
> library would disable its feature with a warning rather than fail the build,
> and the mode could skip shellcheck, mypy and pylint too. allmodconfig would
> then build as much of perf as the host allows.

Alternatively using:

acme@number:~/git/perf-tools-next$ make -C tools/perf help
make: Entering directory '/home/acme/git/perf-tools-next/tools/perf'
  BUILD:   Doing 'make -j32' parallel build
Perf make targets:
  doc		- make *all* documentation (see below)
  man		- make manpage documentation (access with man <foo>)
  html		- make html documentation
  info		- make GNU info documentation (access with info <foo>)
  pdf		- make pdf documentation
  TAGS		- use etags to make tag information for source browsing
  tags		- use ctags to make tag information for source browsing
  cscope	- use cscope to make interactive browsing database

Perf install targets:
  NOTE: documentation build requires asciidoc, xmlto packages to be installed
  HINT: use "prefix" or "DESTDIR" to install to a particular
        path like "make prefix=/usr/local install install-doc"
  install	- install compiled binaries
  install-build-deps - install the development packages needed to build
  install-doc	- install *all* documentation
  install-man	- install manpage documentation
  install-html	- install html documentation
  install-info	- install GNU info documentation
  install-pdf	- install pdf documentation

  quick-install-doc	- alias for quick-install-man
  quick-install-man	- install the documentation quickly
  quick-install-html	- install the html documentation quickly

Perf maintainer targets:
  clean			- clean all binary objects and build output
make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
acme@number:~/git/perf-tools-next$

Why is that difficult to run:

make -C tools/perf install-build-deps

To do a recommended perf build deps install?

That would be useful as it is what we expect users to do.

If that is too difficult, for some reason, there is a minimal build in
tools/perf/tests/make, that is tested since forever:

# all the NO_* variable combined
make_minimal        := NO_PYTHON_MODULE=1
make_minimal        += NO_DEMANGLE=1 NO_LIBELF=1 NO_BACKTRACE=1
make_minimal        += NO_LIBNUMA=1 NO_LIBBIONIC=1 NO_LIBDW=1
make_minimal        += NO_LIBBPF=1
make_minimal        += NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1
make_minimal        += NO_CAPSTONE=1

- Arnaldo
