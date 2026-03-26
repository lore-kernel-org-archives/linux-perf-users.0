Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600BB2E3AEA;
	Thu, 26 Mar 2026 22:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774565482; cv=none; b=eQf8k59gf73uO+XvyzYRDKCin1sdnct7LzlrXxuXSzFcob7OlJJjxzWN7id0uW7IDMGLlKRFOouyzgjRNWyXnGuisz8A4AKuazQ79f2vNnqUVgHbxsrsrhL4l4uipNgqv/HLVzJHNZHmVPOMIMDYpz5q/pOTxSG3J8iBmLuNtdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774565482; c=relaxed/simple;
	bh=BwSkK1FHDJhBb9L9q07poJvujcAazF3P+8G7lS5m8FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pM7zCt/aHq8xwUfeR4D3z4SoGSqK5zTKeODlhMyG78NSlpf6Z/YhHA5dsFr6JcQJQYx1gYTKFRScWz+6IhmZBofq1KmWMTYWtpGFZiqXOxSVPKw1eiYAm+Vir5gk7OizooRCK38HviCRWW67vN+nnLihJQyt0yy0IUTEYvskF+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tlvjDkbi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tlvjDkbi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36DDC116C6;
	Thu, 26 Mar 2026 22:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774565482;
	bh=BwSkK1FHDJhBb9L9q07poJvujcAazF3P+8G7lS5m8FQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tlvjDkbiz41h+QYZBsxuhb0YHGNmEY6otaPvKnoKakmWMQqlrYOSbZReuq6XlEHso
	 xyp67AjYIlAZvu3KV40GFta00jszUBhc4AGQA2Vs9pUn2KA9Mjkl3cmnU2rYZdqLJ6
	 IFFQ0CYxuEmgRxY2dFGWOeFto0qf3MvM1WCSo5LPvU+1G7jmFjGrNVtLn5elwDvHP8
	 gcudumydS5QdzscqjKIqpPsfhYCCKiToA2j/dAfMLC4RT/gnN8O4ARQzYbxJOUqKJ2
	 HbfJ9H76p/ealtpFxGBywfdeMy8zGK/4cEDa+5rHLuDuniNjmj7VWwJluZaGnsXiMp
	 x7z9WkFqXlZeQ==
Date: Thu, 26 Mar 2026 15:51:19 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: 9erthalion6@gmail.com, acme@kernel.org, adrian.hunter@intel.com,
	alex@ghiti.fr, alexander.shishkin@linux.intel.com,
	andrew.jones@oss.qualcomm.com, aou@eecs.berkeley.edu,
	atrajeev@linux.ibm.com, blakejones@google.com, ctshao@google.com,
	dapeng1.mi@linux.intel.com, howardchu95@gmail.com,
	james.clark@linaro.org, john.g.garry@oracle.com, jolsa@kernel.org,
	leo.yan@linux.dev, libunwind-devel@nongnu.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
	mingo@redhat.com, palmer@dabbelt.com, peterz@infradead.org,
	pjw@kernel.org, shimin.guo@skydio.com, tglozar@redhat.com,
	tmricht@linux.ibm.com, will@kernel.org, amadio@gentoo.org,
	yuzhuo@google.com
Subject: Re: [PATCH v1 0/2] perf build: Remove libunwind support
Message-ID: <acW4Z2KJbyPZM1SG@google.com>
References: <abxs-2rozL1tBEO1@google.com>
 <20260321234220.848859-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260321234220.848859-1-irogers@google.com>

On Sat, Mar 21, 2026 at 04:42:18PM -0700, Ian Rogers wrote:
> libunwind support exists for "--call-graph dwarf", however, libunwind
> support has been opt-in rather than opt-out since Linux v6.13 as libdw
> is preferred - commit 13e17c9ff49119aa ("perf build: Make libunwind
> opt-in rather than opt-out"). A problem with the libdw support was
> that it was slow, an issue fixed in Linux v7.0 in commit 6b2658b3f36a
> ("perf unwind-libdw: Don't discard loaded ELF/DWARF after every
> unwind"). As such libunwind support is now unnecessary.
> 
> The patch series:
> https://lore.kernel.org/lkml/20260305221927.3237145-1-irogers@google.com/
> looked to make the libunwind support in perf similar to the libdw
> support, allow cross-architecture unwinding, etc. This was motivated
> by the perf regs conventions being altered by the addition of x86 APX
> support:
> https://lore.kernel.org/lkml/20260209072047.2180332-1-dapeng1.mi@linux.intel.com/
> It is necessary to translate the library's notion of registers to the
> perf register convention so that the stack unwinding state can be
> initialized. On this series it was stated that removing libunwind
> support from perf should be an option, rather than updating support:
> https://lore.kernel.org/lkml/abxs-2rozL1tBEO1@google.com/
> This was also what motivated making libunwind opt-in rather than
> opt-out.
> 
> Given that 7 minor releases have happened with libunwind "deprecated"
> by making it opt-in, let's remove the libunwind support. There doesn't
> appear to be any disagreement to this on the mailing list.

I'm not sure if we want to remove it now.  I think we need more time to
verify libdw unwinding is stable and fast enough.  Also maybe we can
add build- or run-time warning when people try to use libunwind.

Thanks,
Namhyung

> 
> Ian Rogers (2):
>   perf build: Remove libunwind support
>   tools build: Remove libunwind feature tests
> 
>  tools/build/feature/Makefile                  |  31 -
>  tools/build/feature/test-libunwind-aarch64.c  |  27 -
>  tools/build/feature/test-libunwind-arm.c      |  28 -
>  .../test-libunwind-debug-frame-aarch64.c      |  17 -
>  .../feature/test-libunwind-debug-frame-arm.c  |  17 -
>  .../feature/test-libunwind-debug-frame.c      |  17 -
>  tools/build/feature/test-libunwind-x86.c      |  28 -
>  tools/build/feature/test-libunwind-x86_64.c   |  28 -
>  tools/build/feature/test-libunwind.c          |  28 -
>  tools/perf/Documentation/perf-check.txt       |   1 -
>  tools/perf/Documentation/perf-config.txt      |   4 +-
>  tools/perf/Documentation/perf-record.txt      |   2 +-
>  tools/perf/Makefile.config                    | 163 +---
>  tools/perf/Makefile.perf                      |   3 -
>  tools/perf/arch/arm/util/Build                |   1 -
>  tools/perf/arch/arm/util/unwind-libunwind.c   |  50 --
>  tools/perf/arch/arm64/util/Build              |   1 -
>  tools/perf/arch/arm64/util/unwind-libunwind.c |  17 -
>  tools/perf/arch/loongarch/util/Build          |   1 -
>  .../arch/loongarch/util/unwind-libunwind.c    |  82 --
>  tools/perf/arch/mips/util/Build               |   1 -
>  tools/perf/arch/mips/util/unwind-libunwind.c  |  22 -
>  tools/perf/arch/powerpc/util/Build            |   1 -
>  .../perf/arch/powerpc/util/unwind-libunwind.c |  92 --
>  tools/perf/arch/x86/util/Build                |   1 -
>  tools/perf/arch/x86/util/unwind-libunwind.c   | 115 ---
>  tools/perf/builtin-check.c                    |   1 -
>  tools/perf/builtin-report.c                   |   4 +-
>  tools/perf/tests/make                         |   2 -
>  tools/perf/util/Build                         |   5 -
>  tools/perf/util/callchain.c                   |   2 +-
>  tools/perf/util/dso.h                         |   6 -
>  tools/perf/util/libunwind/arm64.c             |  40 -
>  tools/perf/util/libunwind/x86_32.c            |  41 -
>  tools/perf/util/maps.c                        |  47 +-
>  tools/perf/util/maps.h                        |   6 -
>  tools/perf/util/thread.c                      |  40 +-
>  tools/perf/util/thread.h                      |   1 -
>  tools/perf/util/unwind-libunwind-local.c      | 832 ------------------
>  tools/perf/util/unwind-libunwind.c            |  92 --
>  tools/perf/util/unwind.h                      |  41 +-
>  41 files changed, 19 insertions(+), 1919 deletions(-)
>  delete mode 100644 tools/build/feature/test-libunwind-aarch64.c
>  delete mode 100644 tools/build/feature/test-libunwind-arm.c
>  delete mode 100644 tools/build/feature/test-libunwind-debug-frame-aarch64.c
>  delete mode 100644 tools/build/feature/test-libunwind-debug-frame-arm.c
>  delete mode 100644 tools/build/feature/test-libunwind-debug-frame.c
>  delete mode 100644 tools/build/feature/test-libunwind-x86.c
>  delete mode 100644 tools/build/feature/test-libunwind-x86_64.c
>  delete mode 100644 tools/build/feature/test-libunwind.c
>  delete mode 100644 tools/perf/arch/arm/util/unwind-libunwind.c
>  delete mode 100644 tools/perf/arch/arm64/util/unwind-libunwind.c
>  delete mode 100644 tools/perf/arch/loongarch/util/unwind-libunwind.c
>  delete mode 100644 tools/perf/arch/mips/util/unwind-libunwind.c
>  delete mode 100644 tools/perf/arch/powerpc/util/unwind-libunwind.c
>  delete mode 100644 tools/perf/arch/x86/util/unwind-libunwind.c
>  delete mode 100644 tools/perf/util/libunwind/arm64.c
>  delete mode 100644 tools/perf/util/libunwind/x86_32.c
>  delete mode 100644 tools/perf/util/unwind-libunwind-local.c
>  delete mode 100644 tools/perf/util/unwind-libunwind.c
> 
> -- 
> 2.53.0.959.g497ff81fa9-goog
> 
