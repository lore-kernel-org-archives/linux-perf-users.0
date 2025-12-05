Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9B4299ABF;
	Fri,  5 Dec 2025 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764951717; cv=none; b=k29Y9MoNjOfM3zjVHMo1pVuWTWtmz7lSMl8/8Hhx9XpX+qz0uNC9ddzPs1gNDZNNwgAVfxCKLf+Y8yurUiBshHQ4i1rNAivUMNeYxZUe252+3xXL9D5APDmvIetU0GEFkZJnTLK0C3t/oWhhtXtBd21e9WHPE05meW48g5j1sqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764951717; c=relaxed/simple;
	bh=c1Qy+ijeU3CIB1tQbl0ibO5xYwhNCoO9OqVu2VQPs3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqTvj099I8oWoHcFCJKkTCoGUI034//s2zhYwAujrfb89HjLD0HMSu4newhtHrpZ13G4cnRAPiol2EZ1OIN/gNgpGdNXSxhkEcZm+A7OIXbR0kkj4uyYnp1i0cqgFNYyMPy8rDx6Phi5ypaRSiQzejkha3/qlVpGqwt/jr6clik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA0EB1A00;
	Fri,  5 Dec 2025 08:21:42 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C24E73F740;
	Fri,  5 Dec 2025 08:21:49 -0800 (PST)
Date: Fri, 5 Dec 2025 16:21:47 +0000
From: Leo Yan <leo.yan@arm.com>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/2] Revert "perf tools: Fix arm64 build by generating
 unistd_64.h"
Message-ID: <20251205162147.GR724103@e132581.arm.com>
References: <20251204-perf_fix_syscall_header-v1-0-b8e27f74ed6a@arm.com>
 <20251204-perf_fix_syscall_header-v1-2-b8e27f74ed6a@arm.com>
 <CAP-5=fV-d_X1uFYACEOJOxOY43+fj9aEm0_bp7NGSo9kZVMJ4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fV-d_X1uFYACEOJOxOY43+fj9aEm0_bp7NGSo9kZVMJ4Q@mail.gmail.com>

On Thu, Dec 04, 2025 at 10:19:59AM -0800, Ian Rogers wrote:
> On Thu, Dec 4, 2025 at 8:53 AM Leo Yan <leo.yan@arm.com> wrote:
> >
> > This reverts:
> >
> > commit 8988c4b91945 ("perf tools: Fix in-source libperf build")
> > commit bfb713ea53c7 ("perf tools: Fix arm64 build by generating unistd_64.h")
> >
> > Since we now have a static unistd_64.h for the arm64 build, there is no
> > need to generate unistd_64.h in libperf.  Revert all patches related to
> > generating unistd_64.h.
> 
> Could we generate the file and then compare the two? We do something
> like this for empty-pmu-events.c here:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/pmu-events/Build?h=perf-tools-next#n49
> 
> Similarly, could we get rid of the unistd_64.h generation and just add
> a build time validation test? Generating the file is painful in many
> ways, as this series testifies.

Thanks for suggestions!

I had a question: why we need to maintain unistd.h particually in
./tools folder?  This header is a standard C header and should be
provided by toolchain instead.  Due to multiple copies, it is a bit mess
the programs might include unpurposed one.

I went through the history and found:

  commit 34b009cfde2b ("tools include: Grab copies of arm64 dependent unistd.h files")

It introduces the header unistd.h for generating system call table.

Afterwards,

  commit cb8197db8c09 ("perf tools arm64: Use syscall table")

unistd.h headers are not used to generate syscall table anymore.  Since
then, syscall tables are maintained in
tools/perf/arch/*/entry/syscalls/syscall*.tbl for each arch.

To verify this, I did a quick try with removing x86 and arm64 headers:

  tools/arch/arm64/include/uapi/asm/unistd.h
  tools/arch/x86/include/uapi/asm/unistd.h
  tools/arch/x86/include/uapi/asm/unistd_32.h
  tools/arch/x86/include/uapi/asm/unistd_64.h

I run the linux-tools-container-builds and confirmed all x86 and arm64
building tests pass and did not see any failure.

For a neat fix, I think we can remove all unistd.h headers:

  $ ls tools/arch/*/include/uapi/asm/unistd*
  tools/arch/arc/include/uapi/asm/unistd.h
  tools/arch/hexagon/include/uapi/asm/unistd.h
  tools/arch/riscv/include/uapi/asm/unistd.h
  tools/arch/x86/include/uapi/asm/unistd_64.h
  tools/arch/arm64/include/uapi/asm/unistd.h
  tools/arch/loongarch/include/uapi/asm/unistd.h
  tools/arch/x86/include/uapi/asm/unistd_32.h
  tools/arch/x86/include/uapi/asm/unistd.h

Any concern?  I would get maintainers's confirmation before proceeding.

Thanks,
Leo
