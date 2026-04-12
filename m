Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C78023EAA0;
	Sun, 12 Apr 2026 19:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776021486; cv=none; b=E9JgwEDYhyxNAmt0HwHXT1DlqmYV5yFSJHC/xLuFAIDxFrpaAdQVRqWIvR1TLbKmP/QPTg5yTToDCC47SjjruYxDVq9P6JL1NoUy914Rih7iAR71G+iQX3QZb0mT4C1kOOpOg7Yzyl+NGzV3IQFuV9w3au0WLauOmZSeM5E3uzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776021486; c=relaxed/simple;
	bh=yellk67V+k6/B4H2k9kR6wZJu3FcR3ehf63oE9bnhSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KiMd6H0TTB8ktK58i0mF17TSq+xAZA4XPhp6SbbzrK53S+jYJhysI1pBFeaexdlUnaIbAwKvPcHs4xbWjacGscxpA5JFFF6pqGBxGiY6XjOuDCqB2Zpyg0NzAD5bLH5bVQUzDXZ+M50DtdnHarMnHejMfnDhvf0cmXE9E1JzeCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZnKt7Rb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZnKt7Rb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99BB4C19424;
	Sun, 12 Apr 2026 19:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776021486;
	bh=yellk67V+k6/B4H2k9kR6wZJu3FcR3ehf63oE9bnhSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hZnKt7RbgwivElS/f3AFQ56bX4R/NE0FSJSAiy1su0vgf84BAYRn7YeERL6/R3dkw
	 Nx0Ruk0NQGL60D0vPPcY/yehUmNJNccUQaW0qSHxUEtg60/8C7MgsrmZQVbJi7buEp
	 G6ElYaE4dX5IUKeIe/lKM1FmBiwZtep346fnVvUgIZLR42A46qK83qbqTimjn8gxvh
	 aYhr5/6NgmgXFkNSZaIUf2xvDL08xA+YcnB1FGXWv+rcZo2Vn3BUfhGvrHQ5EFNPXj
	 9JYA2gEocew3xeVdvbdEpqsJMlctpAWIcKGZnLtQyIdm+Mx2mPmo8GTm1atR46s0RB
	 42af47d8qo1VQ==
Date: Sun, 12 Apr 2026 16:18:02 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, alex@ghiti.fr,
	alexander.shishkin@linux.intel.com, andrew.jones@oss.qualcomm.com,
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com,
	blakejones@google.com, ctshao@google.com,
	dapeng1.mi@linux.intel.com, howardchu95@gmail.com,
	james.clark@linaro.org, john.g.garry@oracle.com, jolsa@kernel.org,
	leo.yan@linux.dev, libunwind-devel@nongnu.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
	mingo@redhat.com, namhyung@kernel.org, palmer@dabbelt.com,
	peterz@infradead.org, pjw@kernel.org, shimin.guo@skydio.com,
	tglozar@redhat.com, tmricht@linux.ibm.com, will@kernel.org,
	yuzhuo@google.com
Subject: Re: [PATCH v3 0/8] perf libunwind multiple remote support
Message-ID: <advv6twWCEVBo_Hc@x1>
References: <20260305221927.3237145-1-irogers@google.com>
 <20260404054032.1538095-1-irogers@google.com>
 <CAP-5=fUz60Guq_gVV6wb_FfwhPs-fUN+PAbB3rQn3pycXbF3DA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUz60Guq_gVV6wb_FfwhPs-fUN+PAbB3rQn3pycXbF3DA@mail.gmail.com>

On Fri, Apr 10, 2026 at 06:04:57PM -0700, Ian Rogers wrote:
> On Fri, Apr 3, 2026 at 10:40 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Fix the libunwind build for when libdw and libunwind are feature
> > detected, currently failing with a duplicate symbol.
> >
> > Refactor the libunwind support so that whenever a remote target is
> > available, perf functions using the ELF machine can use that remote
> > target regardless of what the host/local machine is. Migrate existing
> > libunwind supported architectures like powerpc, arm64 and loongarch so
> > that they can work in a cross-architecture way. Add support for
> > RISC-V. Make the code more regular in function names, etc. and avoid
> > including a C-file. This increases the lines of code. It is similar in
> > style to the unwind-libdw implementation. It is hoped that the more
> > uniform nature of the code with help with refactoring the perf
> > registers for SIMD/APX support.
> >
> > Aside from local host testing these patches are under tested, in part
> > as I'm failing to see how to build libunwind with support for multiple
> > remote targets. Please could I get help in testing.
> >
> > v3: Minor whitespace clean up and warn when a dynamic choice of libdw
> >     or libunwind is selected for unwinding and support is missing (Arnaldo).
> 
> Hi Arnaldo,
> 
> anything else outstanding from this series?

It is not applying, I did an attempt to refresh it but stomped at 7/8

⬢ [acme@toolbx perf-tools-next]$ patch -p1 < ./v3_20260403_irogers_perf_libunwind_multiple_remote_support.mbx
patching file tools/perf/util/Build
patching file tools/perf/util/libunwind-arch/libunwind-arch.c
patching file tools/perf/util/libunwind-arch/libunwind-arch.h
patching file tools/perf/util/libunwind-arch/libunwind-arm.c
patching file tools/perf/util/libunwind-arch/libunwind-arm64.c
patching file tools/perf/util/libunwind-arch/libunwind-i386.c
patching file tools/perf/util/libunwind-arch/libunwind-loongarch.c
patching file tools/perf/util/libunwind-arch/libunwind-mips.c
patching file tools/perf/util/libunwind-arch/libunwind-ppc32.c
patching file tools/perf/util/libunwind-arch/libunwind-ppc64.c
patching file tools/perf/util/libunwind-arch/libunwind-s390.c
patching file tools/perf/util/libunwind-arch/libunwind-x86_64.c
patching file tools/perf/util/libunwind/arm64.c
patching file tools/perf/util/libunwind/x86_32.c
patching file tools/perf/util/maps.c
patching file tools/perf/util/maps.h
patching file tools/perf/util/unwind-libunwind-local.c
Reversed (or previously applied) patch detected!  Assume -R? [n] ^C
⬢ [acme@toolbx perf-tools-next]$

Can you please take a look and maybe resubmit it so that Sashiko can
have a look at it?

Two other patches had to be refreshed before 7/8.

- Arnaldo
