Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3940238C15;
	Wed,  1 Oct 2025 14:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759328483; cv=none; b=t3xVfyjKrbvxVXCUOXBaeruZ8f/e2m/PcdeZbE3Ksvs5xTb5XfNgfV9HusjY1z/MNjZ+E3T4NfJz+Perkls8kX/HrUZETQDJjG6E4xsLDbiz3pzTi5T90xX0JTkUQD9wOxIHajc64+rfhnJuDt9fOPxhCkXpD5rUrzhPaxrl3n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759328483; c=relaxed/simple;
	bh=J2fqNDAd1wRU864eSpkfrd999qUHOFK/4c5fDl4Dl/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dx//Nbd6H9KlLf1WNbhf9ttCez+L0dBzMU8siDfLHWw8w6YwNsKBDvmYG9TzUBNDK/c8atOGXp5WG/ziqiuwcxNyI0wyjSAZJ/QV3o9k6xqYLjdZEmPAk2H/8LHH2KbeDNMMx7LSjgPDwRnj/RH6OYpOm4DKcrJr6i3QozCCqqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ppq0wNVC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ppq0wNVC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00075C4CEF1;
	Wed,  1 Oct 2025 14:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759328483;
	bh=J2fqNDAd1wRU864eSpkfrd999qUHOFK/4c5fDl4Dl/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ppq0wNVCZl49QUnuNWMqJMVyXU2DqLrdlPDr8cnmvrzwqvtM5wRv7ff6hocv7/oFC
	 Pfun6y0oKel+L98l7ayCFYyz7gHiItSbbxHUUtaCdQhFIxs2vPPbcXsq+EIFIbRhFa
	 iLE5/2QhcQuTkHZH8tODay3K7NUSDmYXr+PyGqJV14OxlA0p1TnzejJp2Wgnev6pwc
	 CFEYxRtp71kJYY01z0L9yJlmffr//QTNB4lWqO61W6pigaWm5l1ZI1dMiqnysVT6Se
	 3jC2aExEmObG4DxPaJ/ZTTtf2ZJUpazGiym+nDMHQT9cI4HcNxbhTp2jxAU1c4jgVj
	 Yn4tNZoh85oHA==
Date: Wed, 1 Oct 2025 11:21:20 -0300
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
Message-ID: <aN044EY-Ds9-E6iz@x1>
References: <20250930-perf_build_android_ndk-v2-0-2ea440b7ef01@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250930-perf_build_android_ndk-v2-0-2ea440b7ef01@arm.com>

On Tue, Sep 30, 2025 at 05:54:48PM +0100, Leo Yan wrote:
> This series adds support for building perf with Clang, following the
> discussion in [1]. Because the Android NDK uses Clang by default,
> enabling Clang builds naturally covers Android as well.
> 
> The series is organized as follows:
> 
>   - Patches 1–2: Fix two bugs found with Clang.
>   - Patches 3–6: Correct CROSS_ARCH and dismiss Clang build warnings.
>   - Patches 7–8: Enable Clang in the Makefile and update the
>     documentation.
> 
> Testing:
> 
>   - Clang 15.0.7 on Ubuntu 22.04.5: native and cross-compiling (aarch64)
>   - Clang 18.1.3 on Ubuntu 24.04.2: native and cross-compiling (aarch64)
>   - Android NDK r27d (latest LTS): cross-compiling (aarch64)

  LD      /tmp/build/perf/util/perf-util-in.o
  LD      /tmp/build/perf/perf-util-in.o
  AR      /tmp/build/perf/libperf-util.a
  CC      /tmp/build/perf/pmu-events/pmu-events.o
  LD      /tmp/build/perf/pmu-events/pmu-events-in.o
  AR      /tmp/build/perf/libpmu-events.a
  LINK    /tmp/build/perf/perf
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
toolsbuilder@five:~$ cat dm.log/alpine\:3.22
