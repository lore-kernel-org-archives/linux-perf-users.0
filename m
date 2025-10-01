Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75F318DB01;
	Wed,  1 Oct 2025 15:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759332141; cv=none; b=NkhAtrmZNgOMaSI+QubeBzJ2Z2D2IH+FdxHEgYFbG45ObH4kzF9l8VlbE84BxnLhdLezpJtPlVtYyOBL/hx4ptSFAwSGXFsfOdjaYC3LzPdXIWWDFz5sS0SjRZq0akUcNLSgp10bg9HR1pceNFvkwygPpgM/DUX296x4EXmuTtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759332141; c=relaxed/simple;
	bh=Q7Wjglx0bW6cmBXT78OZQGD3WEnnqIDV8cnmhObQUhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPyQoLAz/MQmKSXX8bCe6f7pHPXgBKZa0KafmpN/HKq9h2lrzY6RQVyMg0Zo22E13yCmxRzL4yw7Y1ioOC2ipHqWMLxZT8R0HYQBdiA75KS3JTh8Ps3l2bg0YB8evVwPq2HGfBLcVn2tsNzTc5Zy1RrvzPokjUzNvRm5WEhu3T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34E5A1424;
	Wed,  1 Oct 2025 08:22:11 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D688B3F59E;
	Wed,  1 Oct 2025 08:22:18 -0700 (PDT)
Date: Wed, 1 Oct 2025 16:22:17 +0100
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
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
Message-ID: <20251001152217.GQ7985@e132581.arm.com>
References: <20250930-perf_build_android_ndk-v2-0-2ea440b7ef01@arm.com>
 <aN044EY-Ds9-E6iz@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aN044EY-Ds9-E6iz@x1>

On Wed, Oct 01, 2025 at 11:21:20AM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Sep 30, 2025 at 05:54:48PM +0100, Leo Yan wrote:
> > This series adds support for building perf with Clang, following the
> > discussion in [1]. Because the Android NDK uses Clang by default,
> > enabling Clang builds naturally covers Android as well.
> > 
> > The series is organized as follows:
> > 
> >   - Patches 1–2: Fix two bugs found with Clang.
> >   - Patches 3–6: Correct CROSS_ARCH and dismiss Clang build warnings.
> >   - Patches 7–8: Enable Clang in the Makefile and update the
> >     documentation.
> > 
> > Testing:
> > 
> >   - Clang 15.0.7 on Ubuntu 22.04.5: native and cross-compiling (aarch64)
> >   - Clang 18.1.3 on Ubuntu 24.04.2: native and cross-compiling (aarch64)
> >   - Android NDK r27d (latest LTS): cross-compiling (aarch64)
> 
>   LD      /tmp/build/perf/util/perf-util-in.o
>   LD      /tmp/build/perf/perf-util-in.o
>   AR      /tmp/build/perf/libperf-util.a
>   CC      /tmp/build/perf/pmu-events/pmu-events.o
>   LD      /tmp/build/perf/pmu-events/pmu-events-in.o
>   AR      /tmp/build/perf/libpmu-events.a
>   LINK    /tmp/build/perf/perf
> make: Leaving directory '/git/perf-6.17.0-rc6/tools/perf'
> + rm -rf /tmp/build/perf
> + mkdir /tmp/build/perf
> + make 'ARCH=' 'CROSS_COMPILE=' 'EXTRA_CFLAGS=' -C tools/perf 'O=/tmp/build/perf' 'CC=clang'
> make: Entering directory '/git/perf-6.17.0-rc6/tools/perf'
>   BUILD:   Doing 'make -j28' parallel build
> Makefile.config:494: *** No gnu/libc-version.h found, please install glibc-dev[el].  Stop.
> make[1]: *** [Makefile.perf:289: sub-make] Error 2
> make: *** [Makefile:76: all] Error 2
> make: Leaving directory '/git/perf-6.17.0-rc6/tools/perf'
> + exit 1
> toolsbuilder@five:~$ cat dm.log/alpine\:3.22

A quick look: the build cannot find both libelf (feature-libelf=0) and
glibc (feature-glibc=0), thus lead to build failure. It is good to
know what the reason for the feature building failures:

  tools/perf/feature/test-libelf.make.output
  tools/perf/feature/test-glibc.make.output

I am not surprised for the failure of libelf (this is common case
that the package is not installed by default in a distro), but it is a
bit confused for the glibc feature failure.

It seems the issue occurs on Alpine 3.22, but the highest version
supported in container-build is 3.21 [1]. Could you confirm whether
the issue reproduces on other distros or versions?

Thanks,
Leo

[1] https://github.com/acmel/linux-tools-container-builds/tree/main/alpine
