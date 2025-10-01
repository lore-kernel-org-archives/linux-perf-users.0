Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E09F49620;
	Wed,  1 Oct 2025 18:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759343160; cv=none; b=XLh3DizaJWo7xChT3ZwF+NJAssSaujpIOhEsYHsTMoyo/uISyax6xCnaHH0Aoc2gJYVxZP6qUZ8dXEjXqF4yhW9Uw84NfKq3jnq4xhg3iLRVOSGNzaihi/NROwFvMAztmBCMnDLq6gI2K3i3aNefIBobu3aDjiME0wE45DHxDQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759343160; c=relaxed/simple;
	bh=5tYNT4AGhA/+brjUhG2yYDjWkEhcuOCmBfZz1pB8S80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyZcVx06cRIHXMYZ2QRnj4qr8u0ZTk6wjy0IF0iCuHKdRhscfCxgFRxmOYKCJmBF3f2Les76GVL/iKZumqYTaMI6gyH4owcbW06S9n64fCaGRGc9vyuZLwGWgUEfOqzneq8lOnuEuXRnAt/NKWIRijbhGuDpwDOVMRBi2hLgTos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggQQZR28; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggQQZR28"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2A2C4CEF1;
	Wed,  1 Oct 2025 18:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759343159;
	bh=5tYNT4AGhA/+brjUhG2yYDjWkEhcuOCmBfZz1pB8S80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ggQQZR28GyrqV38FAse77cgleFho3+rhhrF1fmbm4xBVbG8ZvrODWbxMN1//DAiM9
	 lr0hmlEL4hzMrny7caHA5VOPxXg2sP4qyZEycboXHPcLxTYov6qcp7AZjpwucGsTly
	 zlBBopr9omwfkXqzFwWO55kxXGpO8jJJsg/R+piBqu3/6X/hX+Eq9G+PCMQ1Siv35o
	 u2OMbtituhHO22VoDospws+EJmTNswQ6ZziJQGYZaMmgXL6fotsjl8T48QklpqNney
	 2JwK1LkMwQSIz4BlKzdi5eLT1DU9cfDvvoEfTL9oikVfmvhFlP55NmAmjCJP7TMk8z
	 QUCFZItEvHHdQ==
Date: Wed, 1 Oct 2025 15:25:56 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
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
Subject: Re: [PATCH v2 0/8] perf build: Support building with Clang
Message-ID: <aN1yNKxXLnMtQczW@x1>
References: <20250930-perf_build_android_ndk-v2-0-2ea440b7ef01@arm.com>
 <aN044EY-Ds9-E6iz@x1>
 <20251001152217.GQ7985@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251001152217.GQ7985@e132581.arm.com>

On Wed, Oct 01, 2025 at 04:22:17PM +0100, Leo Yan wrote:
> On Wed, Oct 01, 2025 at 11:21:20AM -0300, Arnaldo Carvalho de Melo wrote:
> > On Tue, Sep 30, 2025 at 05:54:48PM +0100, Leo Yan wrote:
> > > This series adds support for building perf with Clang, following the
> > > discussion in [1]. Because the Android NDK uses Clang by default,
> > > enabling Clang builds naturally covers Android as well.
> > > 
> > > The series is organized as follows:
> > > 
> > >   - Patches 1–2: Fix two bugs found with Clang.
> > >   - Patches 3–6: Correct CROSS_ARCH and dismiss Clang build warnings.
> > >   - Patches 7–8: Enable Clang in the Makefile and update the
> > >     documentation.
> > > 
> > > Testing:
> > > 
> > >   - Clang 15.0.7 on Ubuntu 22.04.5: native and cross-compiling (aarch64)
> > >   - Clang 18.1.3 on Ubuntu 24.04.2: native and cross-compiling (aarch64)
> > >   - Android NDK r27d (latest LTS): cross-compiling (aarch64)
> > 
> >   LD      /tmp/build/perf/util/perf-util-in.o
> >   LD      /tmp/build/perf/perf-util-in.o
> >   AR      /tmp/build/perf/libperf-util.a
> >   CC      /tmp/build/perf/pmu-events/pmu-events.o
> >   LD      /tmp/build/perf/pmu-events/pmu-events-in.o
> >   AR      /tmp/build/perf/libpmu-events.a
> >   LINK    /tmp/build/perf/perf
> > make: Leaving directory '/git/perf-6.17.0-rc6/tools/perf'
> > + rm -rf /tmp/build/perf
> > + mkdir /tmp/build/perf
> > + make 'ARCH=' 'CROSS_COMPILE=' 'EXTRA_CFLAGS=' -C tools/perf 'O=/tmp/build/perf' 'CC=clang'
> > make: Entering directory '/git/perf-6.17.0-rc6/tools/perf'
> >   BUILD:   Doing 'make -j28' parallel build
> > Makefile.config:494: *** No gnu/libc-version.h found, please install glibc-dev[el].  Stop.
> > make[1]: *** [Makefile.perf:289: sub-make] Error 2
> > make: *** [Makefile:76: all] Error 2
> > make: Leaving directory '/git/perf-6.17.0-rc6/tools/perf'
> > + exit 1
> > toolsbuilder@five:~$ cat dm.log/alpine\:3.22
 
> A quick look: the build cannot find both libelf (feature-libelf=0) and
> glibc (feature-glibc=0), thus lead to build failure. It is good to
> know what the reason for the feature building failures:
 
>   tools/perf/feature/test-libelf.make.output
>   tools/perf/feature/test-glibc.make.output
 
> I am not surprised for the failure of libelf (this is common case
> that the package is not installed by default in a distro), but it is a
> bit confused for the glibc feature failure.
 
> It seems the issue occurs on Alpine 3.22, but the highest version
> supported in container-build is 3.21 [1]. Could you confirm whether
> the issue reproduces on other distros or versions?

It was in all alpine versions I have containers to test on:

toolsbuilder@five:~$ grep FAIL dm.log.old/summary 
   3    71.85 almalinux:9-i386              : FAIL clang version 17.0.6 (AlmaLinux OS Foundation 17.0.6-5.el9)
   5    78.60 alpine:3.16                   : FAIL gcc version 11.2.1 20220219 (Alpine 11.2.1_git20220219) 
   6    59.77 alpine:3.17                   : FAIL gcc version 12.2.1 20220924 (Alpine 12.2.1_git20220924-r4) 
   7    56.89 alpine:3.18                   : FAIL gcc version 12.2.1 20220924 (Alpine 12.2.1_git20220924-r10) 
   8    60.86 alpine:3.19                   : FAIL gcc version 13.2.1 20231014 (Alpine 13.2.1_git20231014) 
   9    60.18 alpine:3.20                   : FAIL gcc version 13.2.1 20240309 (Alpine 13.2.1_git20240309) 
  10    64.58 alpine:3.22                   : FAIL gcc version 14.2.0 (Alpine 14.2.0) 
  11    63.36 alpine:edge                   : FAIL gcc version 14.2.0 (Alpine 14.2.0) 
toolsbuilder@five:~$

  GEN     /tmp/build/perf/python/perf.cpython-312-x86_64-linux-musl.so
make: Leaving directory '/git/perf-6.17.0-rc6/tools/perf'
+ rm -rf /tmp/build/perf
+ mkdir /tmp/build/perf
+ make 'ARCH=' 'CROSS_COMPILE=' 'EXTRA_CFLAGS=' -C tools/perf 'O=/tmp/build/perf' 'CC=clang'
make: Entering directory '/git/perf-6.17.0-rc6/tools/perf'
  BUILD:   Doing 'make -j28' parallel build
Makefile.config:494: *** No gnu/libc-version.h found, please install glibc-dev[el].  Stop.
make[1]: *** [Makefile.perf:289: sub-make] Error 2
make: *** [Makefile:76: all] Error 2
make: Leaving directory '/git/perf-6.17.0-rc6/tools/perf'
+ exit 1
toolsbuilder@five:~
$

lemme try to reapply those patches and get the
tools/perf/feature/test-libelf.make.output and
tools/perf/feature/test-glibc.make.output files.

- Arnaldo
