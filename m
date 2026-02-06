Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D56334E74D;
	Fri,  6 Feb 2026 15:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770391047; cv=none; b=OSpV2X/+jRdZI+RILh0dwk0vmfd1DeUCsaCPXgi6NL6QqK79vdg1Cw/I7FSaw3w9enxIgfmedLZLPzEaatBZyGnQg5T3l9xG3FL+M167Lkqecx4xJ4OyNdfjAHu3DcSIw0R1FMJlqfZV63UApO6SMH6WICeB3nzc2jrs7u5dgsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770391047; c=relaxed/simple;
	bh=6mz/3w0UjpTEHMbTpW4AIj0Grix3lL6MyzuhtcoRSic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYICOfKb8HTh39Lfjnst5w36MDe4PX4IxDJBZy5xwtiMkOals82U95paX/jHiqzo9tENx9l6eKTK4jdQn5KEyJqQJ2m4x7IyeEEXwRzKpWs8TeToGAvVOU4zdg7XrgwXl+OEZz5WQVGsMum+duWbOVk+fEluRBB4dW/Es0UHvwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VlAOXJcF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlAOXJcF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B452C116C6;
	Fri,  6 Feb 2026 15:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770391047;
	bh=6mz/3w0UjpTEHMbTpW4AIj0Grix3lL6MyzuhtcoRSic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VlAOXJcFe4nga7Co7rthFiRF+OTrMkuvkC7VLx301zD3DttlJ9cwinHFhpJFtMBBd
	 3ngn0fnOslHfDn/rzIQG0+7N9oxPG1N+EKewk8rJHggIKFVzImQIDSI79x8NNFf5vu
	 3hlM0p2dmflv+x3Sh6C5CpkqqFIlC+d06GaVtH/OsChouzd6cPnUttTXv17XAk4Gi9
	 l8j31GXwzzXDrYx/XSKXehj0znte90kvWBaHOpF5gTIlLDSWT0mVzjgfbN7F6w/Itb
	 Mgl+Rle4jQ1iDdiCKMbjK2lqOihrs4IqtQXkV6Lmcmp6dKTJ6+IZoyrt3sY8xPXHFs
	 jq3hXzro+kiOg==
Date: Fri, 6 Feb 2026 12:17:23 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Guo Ren <guoren@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>, Xudong Hao <xudong.hao@intel.com>
Subject: Re: [Patch v3 0/4] Perf tools: perf-regs bug fix and optimization
Message-ID: <aYYGA_Mo1ppwdTH0@x1>
References: <20260203024356.444942-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203024356.444942-1-dapeng1.mi@linux.intel.com>

On Tue, Feb 03, 2026 at 10:43:52AM +0800, Dapeng Mi wrote:
> Changes:
>  v2 -> v3:
>   * Fix the abort issue for "-I" or "--user-regs" options. (Patch 1/4)
>   * Address Ian's comments.

Fixed up somme fuzz with powerpc, x86, riscv and s390  Build files wrt
removing perf_regs.o

Thanks, applied to perf-tools-next,

- Arnaldo
 
>  v1 -> v2:
>   * Fixing "PERF_REG_EXTENDED_MASK" redefinition building error by
>     changing the "asm/perf_regs.h" header path to relative UAPI path.
>     (Patch 1/3)
>   * Spliting xxx_reg_mask() and xxx_sdt_arg_parse_op() conversion into 2
>     patches.
> 
> This patch-set remove the below three architecture specific __weak
> functions and converted them into the general architecture specific
> functions which are dispatched base on "em_machine".
> 
> uint64_t arch__intr_reg_mask(void);
> uint64_t arch__user_reg_mask(void);
> int arch_sdt_arg_parse_op(char *old_op, char **new_op);
> 
> The advantage of this conversion is that these architectural functions
> can be called even for a different architecture with host instead of
> only called on the host architecture.
> 
> Although the converted functions shown below can be called on any
> architecture, currently they are still only called for the host
> architecture (EM_HOST).
> 
> int perf_sdt_arg_parse_op(uint16_t e_machine, char *old_op, char **new_op);
> uint64_t perf_intr_reg_mask(uint16_t e_machine);
> uint64_t perf_user_reg_mask(uint16_t e_machine);
> 
> Tests:
>   * This patch-set is only tested on x86 platforms. No issues are found
>     for both intr-regs and user-regs options.
>   * Tests on other architectures are welcomed and appreciated.
> 
> History:
>   v1: https://lore.kernel.org/all/20260123090938.2222960-1-dapeng1.mi@linux.intel.com/
>   v2: https://lore.kernel.org/all/20260127070259.2720468-1-dapeng1.mi@linux.intel.com/
> 
> Dapeng Mi (4):
>   perf regs: Fix abort for "-I" or "--user-regs" options
>   perf arch: Update arch headers to use relative UAPI paths
>   perf regs: Remove __weak attributive arch__xxx_reg_mask() functions
>   perf regs: Remove __weak attributive arch_sdt_arg_parse_op() function
> 
>  tools/perf/arch/arm/include/perf_regs.h       |   2 +-
>  tools/perf/arch/arm/util/Build                |   2 -
>  tools/perf/arch/arm/util/perf_regs.c          |  13 -
>  tools/perf/arch/arm64/include/perf_regs.h     |   2 +-
>  tools/perf/arch/arm64/util/Build              |   1 -
>  tools/perf/arch/arm64/util/perf_regs.c        | 141 ---------
>  tools/perf/arch/csky/Build                    |   1 -
>  tools/perf/arch/csky/include/perf_regs.h      |   2 +-
>  tools/perf/arch/csky/util/Build               |   1 -
>  tools/perf/arch/csky/util/perf_regs.c         |  13 -
>  tools/perf/arch/loongarch/include/perf_regs.h |   2 +-
>  tools/perf/arch/loongarch/util/Build          |   1 -
>  tools/perf/arch/loongarch/util/perf_regs.c    |  13 -
>  tools/perf/arch/mips/include/perf_regs.h      |   2 +-
>  tools/perf/arch/mips/util/Build               |   1 -
>  tools/perf/arch/mips/util/perf_regs.c         |  13 -
>  tools/perf/arch/powerpc/include/perf_regs.h   |   2 +-
>  tools/perf/arch/powerpc/util/Build            |   1 -
>  tools/perf/arch/powerpc/util/perf_regs.c      | 172 -----------
>  tools/perf/arch/riscv/include/perf_regs.h     |   9 +-
>  tools/perf/arch/riscv/util/Build              |   1 -
>  tools/perf/arch/riscv/util/perf_regs.c        |  13 -
>  tools/perf/arch/s390/include/perf_regs.h      |   2 +-
>  tools/perf/arch/s390/util/Build               |   1 -
>  tools/perf/arch/s390/util/perf_regs.c         |  13 -
>  tools/perf/arch/x86/include/perf_regs.h       |   2 +-
>  tools/perf/arch/x86/util/Build                |   1 -
>  tools/perf/arch/x86/util/perf_regs.c          | 283 ------------------
>  tools/perf/util/evsel.c                       |   4 +-
>  tools/perf/util/parse-regs-options.c          |  13 +-
>  .../util/perf-regs-arch/perf_regs_aarch64.c   | 139 ++++++++-
>  .../perf/util/perf-regs-arch/perf_regs_arm.c  |   7 +-
>  .../perf/util/perf-regs-arch/perf_regs_csky.c |   7 +-
>  .../util/perf-regs-arch/perf_regs_loongarch.c |   7 +-
>  .../perf/util/perf-regs-arch/perf_regs_mips.c |   7 +-
>  .../util/perf-regs-arch/perf_regs_powerpc.c   | 183 ++++++++++-
>  .../util/perf-regs-arch/perf_regs_riscv.c     |   7 +-
>  .../perf/util/perf-regs-arch/perf_regs_s390.c |   7 +-
>  .../perf/util/perf-regs-arch/perf_regs_x86.c  | 281 ++++++++++++++++-
>  tools/perf/util/perf_regs.c                   | 109 ++++++-
>  tools/perf/util/perf_regs.h                   |  27 +-
>  tools/perf/util/probe-file.c                  |   3 +-
>  42 files changed, 787 insertions(+), 724 deletions(-)
>  delete mode 100644 tools/perf/arch/arm/util/perf_regs.c
>  delete mode 100644 tools/perf/arch/arm64/util/perf_regs.c
>  delete mode 100644 tools/perf/arch/csky/Build
>  delete mode 100644 tools/perf/arch/csky/util/Build
>  delete mode 100644 tools/perf/arch/csky/util/perf_regs.c
>  delete mode 100644 tools/perf/arch/loongarch/util/perf_regs.c
>  delete mode 100644 tools/perf/arch/mips/util/perf_regs.c
>  delete mode 100644 tools/perf/arch/powerpc/util/perf_regs.c
>  delete mode 100644 tools/perf/arch/riscv/util/perf_regs.c
>  delete mode 100644 tools/perf/arch/s390/util/perf_regs.c
>  delete mode 100644 tools/perf/arch/x86/util/perf_regs.c
> 
> -- 
> 2.34.1
> 
