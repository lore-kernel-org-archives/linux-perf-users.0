Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0954FD2FF;
	Fri,  8 Nov 2024 00:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731024049; cv=none; b=FL23MWuJJDlF+LbjAjJlJXIz9c/4UfbQTyGrg07vysFBOnZrGHuPBkiIJm2NJ3/CFQVMFIdFf2chDU+5uFEyBmXpS0WILAR5e04jo2RkeEWcTRLolpee5jdRBPknOPuRiSCNM6emISKjdhEl0V7J0w3/ic64pCYGP+qU4XPsBD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731024049; c=relaxed/simple;
	bh=A1nYBKBjEzWsfHtk4DuraLYhFByKzZ3xxQIgXdcE7YI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dAAqxubsWrey2eEC9ZsbhioAmF5M5jiS+2TUBLqQD1H4jG5e//b1DlDhikiK6asWlPtvbipmXSgTX6rjGP0L312qQM36bQZfktux08T6PVGk/1nYhMMU3nYuho36X5dmRa2WFcewI396OKt7bkMC5n39ECWdKu7ZgP1PrN+erX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgK1c0Gx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgK1c0Gx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D47C4CECC;
	Fri,  8 Nov 2024 00:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731024048;
	bh=A1nYBKBjEzWsfHtk4DuraLYhFByKzZ3xxQIgXdcE7YI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dgK1c0Gx3JpYWiutgr99uTMw0ppxTTMR2JvkRft+iLbbm+nBkVyoMxX9/SUayeOOq
	 /B5ASGXVaOfZG4Xk2pNHYZVz57FCko1MojjWS6hHDsD/XEuBhwP3M7DVOFdZ2zEFjn
	 T6kt6y7ivMNeo2Mhg2/dxlYoL3T62gFBnCzabCVEqoB5+hmPraY6InKaGcyPcDGP6q
	 OcX34Y06SCEtysIq+D20N/6GvPF3s+095pzROJcYQqd7jtn8M5bPERxS/tODNTcGE0
	 zkbLpazUOSouCV24V6po8NmwVq0CpQitrRu/1IvBUWiRg89D1jk1Tcu+8wO10sR5HN
	 Kxl9ki5avSVtw==
Date: Fri, 8 Nov 2024 09:00:40 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Adrian
 Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, James
 Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, Leo Yan
 <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Nick Terrell <terrelln@fb.com>, Changbin Du
 <changbin.du@huawei.com>, Guilherme Amadio <amadio@gentoo.org>, Yang Jihong
 <yangjihong@bytedance.com>, Aditya Gupta <adityag@linux.ibm.com>, Athira
 Rajeev <atrajeev@linux.vnet.ibm.com>, Masahiro Yamada
 <masahiroy@kernel.org>, Bibo Mao <maobibo@loongson.cn>, Huacai Chen
 <chenhuacai@kernel.org>, Kajol Jain <kjain@linux.ibm.com>, Atish Patra
 <atishp@rivosinc.com>, Shenlin Liang <liangshenlin@eswincomputing.com>,
 Anup Patel <anup@brainfault.org>, Oliver Upton <oliver.upton@linux.dev>,
 "Steinar H. Gunderson" <sesse@google.com>, "Dr. David Alan Gilbert"
 <linux@treblig.org>, Chen Pei <cp0613@linux.alibaba.com>, Dima Kogan
 <dima@secretsauce.net>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 00/20] Remove PERF_HAVE_DWARF_REGS
Message-Id: <20241108090040.463cb3f0820e7ac22d1bb6c2@kernel.org>
In-Reply-To: <Zy0VHro3wE-ZTKsq@google.com>
References: <20241017002520.59124-1-irogers@google.com>
	<Zy0VHro3wE-ZTKsq@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

On Thu, 7 Nov 2024 11:29:34 -0800
Namhyung Kim <namhyung@kernel.org> wrote:

> Hi all,
> 
> On Wed, Oct 16, 2024 at 05:25:00PM -0700, Ian Rogers wrote:
> > These changes are on top of:
> > https://lore.kernel.org/lkml/20241017001354.56973-1-irogers@google.com/
> > 
> > Prior to these patches PERF_HAVE_DWARF_REGS indicated the presence of
> > dwarf-regs.c in the arch directory. dwarf-regs.c provided upto 4
> > functions:
> > 
> > 1) regs_query_register_offset would translate a register name into a
> > pt_regs offset and was used by BPF prologues. BPF prologues existed
> > for BPF events and support for these was removed many releases ago.
> > This code was dead and could be removed.
> > 
> > 2) get_arch_regstr duplicated get_dwarf_regstr and so it could be
> > removed.  The case for csky was a little more complicated as the ABI
> > controlled the string. The callers of get_dwarf_regstr were updated to
> > also pass the ELF flags so that on csky the ABI appropriate table
> > could be used. As the argument is only used on csky this a no-op for
> > everything else.
> > 
> > 3) get_arch_regnum translated a register name back to a dwarf number
> > and only existed on x86 where "al", "ax", "eax" and "rax" could all
> > mean register 0. This code was moved to util with similar
> > machine/flags logic to get_arch_regstr and for consistency with it.
> > 
> > 4) get_powerpc_regs a PowerPC specific function used by annotate that
> > should really be in util.
> > 
> > 2 and 3 required the wiring through of the ELF machine and flags in
> > callers to get_dwarf_regstr and get_dwarf_regnum. When these values
> > weren't dependent on an ELF file a new EM_HOST and EF_HOST were added
> > to give the host ELF machine and flags. These 2 #defines got rid of
> > the existing separate arch files and #ifdefs.
> > 
> > v3: These files were separated from the rest of the v2 libdw clean up
> >     in:
> > https://lore.kernel.org/lkml/CAP-5=fVZH3L-6y_sxLwSmT8WyMXDMFnuqUksNULdQYJCPNBFYw@mail.gmail.com/
> > 
> > Ian Rogers (20):
> >   perf bpf-prologue: Remove unused file
> >   perf dwarf-regs: Remove PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET
> >   perf dwarf-regs: Add EM_HOST and EF_HOST defines
> >   perf disasm: Add e_machine/e_flags to struct arch
> >   perf dwarf-regs: Pass accurate disassembly machine to get_dwarf_regnum
> >   perf dwarf-regs: Pass ELF flags to get_dwarf_regstr
> >   perf dwarf-regs: Move x86 dwarf-regs out of arch
> >   perf arm64: Remove dwarf-regs.c
> >   perf arm: Remove dwarf-regs.c
> >   perf dwarf-regs: Move csky dwarf-regs out of arch
> >   perf loongarch: Remove dwarf-regs.c
> >   perf mips: Remove dwarf-regs.c
> >   perf dwarf-regs: Move powerpc dwarf-regs out of arch
> >   perf riscv: Remove dwarf-regs.c and add dwarf-regs-table.h
> >   perf s390: Remove dwarf-regs.c
> >   perf sh: Remove dwarf-regs.c
> >   perf sparc: Remove dwarf-regs.c
> >   perf xtensa: Remove dwarf-regs.c
> >   perf dwarf-regs: Remove get_arch_regstr code
> >   perf build: Remove PERF_HAVE_DWARF_REGS
> 
> These look all good and I'm about to apply the series.
> 
> Masami, do you have any remaining concerns?  It'd be nice if you can
> give your Reviewed-by.

I think it looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> 
> Thanks,
> Namhyug
> 
> > 
> >  tools/perf/Makefile.config                    |  17 +-
> >  tools/perf/arch/arc/annotate/instructions.c   |   2 +
> >  tools/perf/arch/arm/Makefile                  |   3 -
> >  tools/perf/arch/arm/annotate/instructions.c   |   2 +
> >  tools/perf/arch/arm/util/Build                |   2 -
> >  tools/perf/arch/arm/util/dwarf-regs.c         |  61 -------
> >  tools/perf/arch/arm64/Makefile                |   4 -
> >  tools/perf/arch/arm64/annotate/instructions.c |   2 +
> >  tools/perf/arch/arm64/util/Build              |   1 -
> >  tools/perf/arch/arm64/util/dwarf-regs.c       |  92 -----------
> >  tools/perf/arch/csky/Makefile                 |   4 -
> >  tools/perf/arch/csky/annotate/instructions.c  |   7 +-
> >  tools/perf/arch/csky/util/Build               |   1 -
> >  tools/perf/arch/loongarch/Makefile            |   4 -
> >  .../arch/loongarch/annotate/instructions.c    |   2 +
> >  tools/perf/arch/loongarch/util/Build          |   1 -
> >  tools/perf/arch/loongarch/util/dwarf-regs.c   |  44 -----
> >  tools/perf/arch/mips/Makefile                 |   4 -
> >  tools/perf/arch/mips/annotate/instructions.c  |   2 +
> >  tools/perf/arch/mips/util/Build               |   1 -
> >  tools/perf/arch/mips/util/dwarf-regs.c        |  38 -----
> >  tools/perf/arch/powerpc/Makefile              |   5 -
> >  .../perf/arch/powerpc/annotate/instructions.c |   2 +
> >  tools/perf/arch/powerpc/util/Build            |   1 -
> >  tools/perf/arch/powerpc/util/dwarf-regs.c     | 153 ------------------
> >  tools/perf/arch/riscv/Makefile                |   5 +-
> >  .../arch/riscv/include/dwarf-regs-table.h     |  42 +++++
> >  tools/perf/arch/riscv/util/Build              |   1 -
> >  tools/perf/arch/riscv/util/dwarf-regs.c       |  72 ---------
> >  .../perf/arch/riscv64/annotate/instructions.c |   2 +
> >  tools/perf/arch/s390/Makefile                 |   4 -
> >  tools/perf/arch/s390/annotate/instructions.c  |   2 +
> >  tools/perf/arch/s390/util/Build               |   1 -
> >  tools/perf/arch/s390/util/dwarf-regs.c        |  43 -----
> >  tools/perf/arch/sh/Build                      |   1 -
> >  tools/perf/arch/sh/Makefile                   |   4 -
> >  tools/perf/arch/sh/util/Build                 |   1 -
> >  tools/perf/arch/sh/util/dwarf-regs.c          |  41 -----
> >  tools/perf/arch/sparc/Build                   |   1 -
> >  tools/perf/arch/sparc/Makefile                |   4 -
> >  tools/perf/arch/sparc/annotate/instructions.c |   2 +
> >  tools/perf/arch/sparc/util/Build              |   1 -
> >  tools/perf/arch/sparc/util/dwarf-regs.c       |  39 -----
> >  tools/perf/arch/x86/Makefile                  |   4 -
> >  tools/perf/arch/x86/annotate/instructions.c   |   3 +-
> >  tools/perf/arch/x86/util/Build                |   3 -
> >  tools/perf/arch/x86/util/dwarf-regs.c         | 153 ------------------
> >  tools/perf/arch/xtensa/Build                  |   1 -
> >  tools/perf/arch/xtensa/Makefile               |   4 -
> >  tools/perf/arch/xtensa/util/Build             |   1 -
> >  tools/perf/arch/xtensa/util/dwarf-regs.c      |  21 ---
> >  tools/perf/util/Build                         |   3 +
> >  tools/perf/util/annotate.c                    |   6 +-
> >  tools/perf/util/bpf-prologue.h                |  37 -----
> >  tools/perf/util/disasm.h                      |   4 +
> >  .../dwarf-regs.c => util/dwarf-regs-csky.c}   |  19 +--
> >  tools/perf/util/dwarf-regs-powerpc.c          |  61 +++++++
> >  tools/perf/util/dwarf-regs-x86.c              |  50 ++++++
> >  tools/perf/util/dwarf-regs.c                  |  38 +++--
> >  tools/perf/util/include/dwarf-regs.h          | 110 ++++++++++---
> >  tools/perf/util/probe-finder.c                |  13 +-
> >  tools/perf/util/probe-finder.h                |   3 +-
> >  62 files changed, 328 insertions(+), 927 deletions(-)
> >  delete mode 100644 tools/perf/arch/arm/util/dwarf-regs.c
> >  delete mode 100644 tools/perf/arch/arm64/util/dwarf-regs.c
> >  delete mode 100644 tools/perf/arch/csky/Makefile
> >  delete mode 100644 tools/perf/arch/loongarch/util/dwarf-regs.c
> >  delete mode 100644 tools/perf/arch/mips/util/dwarf-regs.c
> >  delete mode 100644 tools/perf/arch/powerpc/util/dwarf-regs.c
> >  create mode 100644 tools/perf/arch/riscv/include/dwarf-regs-table.h
> >  delete mode 100644 tools/perf/arch/riscv/util/dwarf-regs.c
> >  delete mode 100644 tools/perf/arch/s390/util/dwarf-regs.c
> >  delete mode 100644 tools/perf/arch/sh/Build
> >  delete mode 100644 tools/perf/arch/sh/Makefile
> >  delete mode 100644 tools/perf/arch/sh/util/Build
> >  delete mode 100644 tools/perf/arch/sh/util/dwarf-regs.c
> >  delete mode 100644 tools/perf/arch/sparc/Build
> >  delete mode 100644 tools/perf/arch/sparc/util/Build
> >  delete mode 100644 tools/perf/arch/sparc/util/dwarf-regs.c
> >  delete mode 100644 tools/perf/arch/x86/util/dwarf-regs.c
> >  delete mode 100644 tools/perf/arch/xtensa/Build
> >  delete mode 100644 tools/perf/arch/xtensa/Makefile
> >  delete mode 100644 tools/perf/arch/xtensa/util/Build
> >  delete mode 100644 tools/perf/arch/xtensa/util/dwarf-regs.c
> >  delete mode 100644 tools/perf/util/bpf-prologue.h
> >  rename tools/perf/{arch/csky/util/dwarf-regs.c => util/dwarf-regs-csky.c} (74%)
> >  create mode 100644 tools/perf/util/dwarf-regs-powerpc.c
> >  create mode 100644 tools/perf/util/dwarf-regs-x86.c
> > 
> > -- 
> > 2.47.0.105.g07ac214952-goog
> > 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
