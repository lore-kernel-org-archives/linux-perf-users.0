Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694111DF25F;
	Tue,  9 Dec 2025 10:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765277377; cv=none; b=qIMmmRfVXNfbRUfR0BRYcPh31nATMArQ1FaC9YmihK/02fmcqeAWUsN2VYGdRMfKNw2HxiQgFzBFKnYcnVt4sYA5qhSmKlddduEmZfhShC+xE+q7I6sM8exI20AXBfO0StTLrN8kM0jiDQt1BoadgLG7LqcAUeT/pmCMzf6+5So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765277377; c=relaxed/simple;
	bh=5e4yFUhr/PyEg1pKUCuCWpuw0KuvvwOmg2LYTn3gO1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F24ziUJay2mjAK7PSmXmfGEbZzOu8+45+MFTFHWOGlM68j0QKC4q+Y4/5n6hgy8FmozButv7mUgI1wDvTGubOVDYGzvAcbjXEq2BKezLUEchj/Wzh3j+i79V4R8jnsFSFlL8Pbp4ZtoR95qwjdrJWGiNIkqBzvb5jT5XVteCbqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A5671691;
	Tue,  9 Dec 2025 02:49:21 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45F4C3F740;
	Tue,  9 Dec 2025 02:49:28 -0800 (PST)
Date: Tue, 9 Dec 2025 10:49:26 +0000
From: Leo Yan <leo.yan@arm.com>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/2] Revert "perf tools: Fix arm64 build by generating
 unistd_64.h"
Message-ID: <20251209104926.GS724103@e132581.arm.com>
References: <20251204-perf_fix_syscall_header-v1-0-b8e27f74ed6a@arm.com>
 <20251204-perf_fix_syscall_header-v1-2-b8e27f74ed6a@arm.com>
 <CAP-5=fV-d_X1uFYACEOJOxOY43+fj9aEm0_bp7NGSo9kZVMJ4Q@mail.gmail.com>
 <20251205162147.GR724103@e132581.arm.com>
 <CAP-5=fW3ZVfTU-=3WJny6KuD+DC7fzNzAehUscztr8Zhhfwrmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fW3ZVfTU-=3WJny6KuD+DC7fzNzAehUscztr8Zhhfwrmw@mail.gmail.com>

Hi Ian,

On Fri, Dec 05, 2025 at 09:16:32AM -0800, Ian Rogers wrote:

[...]

> > For a neat fix, I think we can remove all unistd.h headers:
> >
> >   $ ls tools/arch/*/include/uapi/asm/unistd*
> >   tools/arch/arc/include/uapi/asm/unistd.h
> >   tools/arch/hexagon/include/uapi/asm/unistd.h
> >   tools/arch/riscv/include/uapi/asm/unistd.h
> >   tools/arch/x86/include/uapi/asm/unistd_64.h
> >   tools/arch/arm64/include/uapi/asm/unistd.h
> >   tools/arch/loongarch/include/uapi/asm/unistd.h
> >   tools/arch/x86/include/uapi/asm/unistd_32.h
> >   tools/arch/x86/include/uapi/asm/unistd.h
> >
> > Any concern?  I would get maintainers's confirmation before proceeding.
> 
> Thanks Leo! The tools/include directory is a concern for me as the use
> of it is pretty unstructured. For example, what does <linux/types.h>
> refer to?

I understand your concern.

For my current work, I would like to constraint to unistd.h headers
only, now this is breaking BPF skeleton building on Arm64.

I did not observe other building failures, so we can polish other
headers later.

> Thanks for doing the build testing! Doing a simpler grep:
> ```
> $ grep -r "asm/unistd" tools/include tools/perf tools/lib
> tools/perf/check-headers.sh:  "arch/x86/include/uapi/asm/unistd.h"
> tools/perf/check-headers.sh:  "arch/arm64/include/uapi/asm/unistd.h"
> tools/lib/bpf/bpf.c:#include <asm/unistd.h>
> tools/lib/bpf/libbpf.c:#include <asm/unistd.h>
> ```
> I think unistd.h is needed to make things hermetic for libbpf :-( ...
> Anyway, I think getting rid of unistd.h is a good
> thing but it will probably break perf's build that invokes libbpf's
> build because libbpf will be mixing kernel and old libc headers on one
> of the maintainers build test platforms (likely an old one) where the
> type collisions yield compile time errors. To avoid that I'd suggest
> making libbpf not use asm/unistd.h as a first step. We could get lucky
> with something non-hermetic, but it wouldn't be my preference.

Based on my test, perf (including libbpf) builds successfully without
relying on the unistd.h headers under tools/arch.

To verify which "unistd.h" headers are actually included, I searched
dependencies recorded in .cmd files:

  grep -r --include="*.cmd" "unistd.h" /data_nvme1n1/niayan01/upstream/build/

See the complete log: https://termbin.com/9w85

The mentioned libbpf building includes "unistd.h" headers from the toolchain
and can build successfully.  I verified with two GCC toolchains:

  # aarch64-linux-gnu-gcc --version
  aarch64-linux-gnu-gcc (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0
  Copyright (C) 2019 Free Software Foundation, Inc.
  This is free software; see the source for copying conditions.  There is NO
  warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

  # aarch64-linux-gnu-gcc --version
  aarch64-linux-gnu-gcc (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0
  Copyright (C) 2023 Free Software Foundation, Inc.
  This is free software; see the source for copying conditions.  There is NO
  warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

As a side topic, given libbpf is maintained on github and can support
standalone build [1], we should have confidence that it is not dependent on
tools' headers.

I still think removing the unistd.h headers from tools is the right thing to
do, and based on test, it does not break perf building.

Thanks,
Leo

[1] https://github.com/libbpf/libbpf?tab=readme-ov-file#building-libbpf
