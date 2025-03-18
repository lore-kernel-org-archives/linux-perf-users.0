Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5135695;
	Tue, 18 Mar 2025 01:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742261153; cv=none; b=QlBuTw4vSvlN19sKJg2EQH3M3+nm8LsZAJTbMvKv24LYVEqKXlXsOgKe9ZU6nKjSAMELnjJClAGajhkbKx5cSo5EmiDL5f6udRObs6uA+bhMrEDpzy4VkFnUaeYNLyv1tyF8MR1bcvZHquRLVUzb/WMYao7xBJ78uMQQTMzxX+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742261153; c=relaxed/simple;
	bh=lHp6pVTpIUCiohc57v40NhyrnetRRIhdmVNH2agBigI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLumSJ69Fo5FxO/ZaLBdOiPext4t7rx4KSQ2sL9PHfHYFSMR/Gwls8R7Pm2CifBv0gtP8OwQ4YKDTHJnsf0ilcsQixT829F9+5u5bjlynZMUcDhLVV+CDC8lXUd8ZSsgmh9BYyW4KJaWVIThvgR7N4GPSEo98rFw9TqUHDaYb2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eax/o7HZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eax/o7HZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9926DC4CEE3;
	Tue, 18 Mar 2025 01:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742261152;
	bh=lHp6pVTpIUCiohc57v40NhyrnetRRIhdmVNH2agBigI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eax/o7HZmLBkHWEqi+qFIHOXNlwwCEZja10xAohwwM/pWjFrS0w2yHRihmz4dnZeu
	 FG2cR2US6Hj6Ch9CKDFwehhlupFadbUP6qFI2mIZAvxgpj+f56CaLARqfmfM4QaxqM
	 Yr5N3LK5w3HAFSCqbSBiIPVC/fUAvrgCYSdc7oaBQHBJqAAViZ1zTLjWM0gsD78f5W
	 UKmupaiS1qa9iS22hW8Lvvti2f2l+m1AVKBaUbObc8XL9/q8XDBpun20chPWQFwub5
	 7bIhJ9bFA6G3FSHaICxdMtyzCyanI+OtQhVttsoSx+Nj4STkqU5ncOg9m3zLdvcewF
	 Az4I7kVv8D0KQ==
Date: Mon, 17 Mar 2025 18:25:50 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Li Huafei <lihuafei1@huawei.com>
Cc: acme@kernel.org, leo.yan@linux.dev, james.clark@linaro.org,
	mark.rutland@arm.com, john.g.garry@oracle.com, will@kernel.org,
	irogers@google.com, mike.leach@linaro.org, peterz@infradead.org,
	mingo@redhat.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, kjain@linux.ibm.com, mhiramat@kernel.org,
	atrajeev@linux.vnet.ibm.com, sesse@google.com,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/7] Add data type profiling support for arm64
Message-ID: <Z9jLngEKQpkZdqXQ@google.com>
References: <20250314162137.528204-1-lihuafei1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250314162137.528204-1-lihuafei1@huawei.com>

Hello,

On Sat, Mar 15, 2025 at 12:21:30AM +0800, Li Huafei wrote:
> Hi,
> 
> This patchset supports arm64 perf data type profiling. Data type
> profiling was introduced by Namhyung [1], which associates PMU sampling
> (here referring to memory access-related event sampling) with the
> referenced data types, providing developers with an effective tool for
> analyzing the impact of memory usage and layout. For more detailed
> background, please refer to [2].

Thanks a lot for working on this!  I'm glad to see it running on more
architectures!  I'll review and leave comments on each patch.

Thanks,
Namhyung

> 
> Namhyung initially supported this feature only on x86, and later Athira
> added support for it on powerpc [3]. Unlike the x86 implementation, the
> powerpc implementation parses operands directly from raw instruction
> code instead of using the results from assembler disassembly. As Athira
> mentioned, this is mainly because not all memory access instructions on
> powerpc have explicit memory reference assembler notations '()' in their
> assembly code. On arm64, all memory access instructions have the
> notation '[]', so my implementation is similar to x86, using the
> disassembly results from objdump, llvm, or libcapstone, and parsing
> based on strings. I believe this has the advantage of reusing the
> complex instruction parsing logic of the assembler, but it may not
> perform as well as raw instruction parsing in terms of efficiency.
> 
> Below is a brief description of this patchset:
>  - Patch 1 first identifies load and store instructions and provides a
>    parsing function.
>  - Patches 2-3 are refactoring patches. They primarily move the code for
>    extracting registers and offsets to specific architecture
>    implementations. Additionally, a new callback function
>    'extract_reg_offset' is introduced to avoid having too many
>    architecture-specific implementations in the function
>    'annotate_get_insn_location()'.
>  - Patch 4 implements the extract_reg_offset callback for arm64.
>    Currently, it does not support parsing instructions with register
>    pairs or register offsets in operands. Register pairs often appear in
>    stack push/pop instructions, and register offsets are common when
>    accessing per-CPU variables, both of which require special handling.
>  - Patch 5 adds support for instruction tracing on arm64, primarily
>    addressing the issue where DWARF does not generate information for
>    intermediate pointers in pointer chains.
>  - Patches 6-7 further enhance instruction tracing. Patch 6 supports
>    parsing accesses to global variables, while Patch 7 focuses on
>    resolving accesses to the kernel's current pointer.
> 
> There are still areas for improvement in the current implementation:
>  - Support more types of memory access instructions, such as those
>    involving register pairs and register offsets.
>  - Handle all data processing instructions (e.g., mov, add), as these
>    instructions can change the state of registers and may affect the
>    accuracy of instruction tracking.
>  - Supporting parsing of special memory access scenarios like per-CPU
>    variables and arrays.
> 
> The patch set is based on 6.14-rc6 (commit 80e54e84911a). After applying
> this patch set, the date type profiling results on arm64 are as follows
> (SPE support is required):
> 
>  # perf mem record -a -K -- sleep 1
>  # perf annotate --data-type --type-stat --stdio
>  Only instruction-based sampling period is currently supported by Arm SPE.
>  Annotate data type stats:
>  total 556, ok 357 (64.2%), bad 199 (35.8%)
>  -----------------------------------------------------------
>          10 : no_sym
>          36 : no_insn_ops
>          65 : no_var
>          70 : no_typeinfo
>          18 : bad_offset
>          59 : insn_track
>  
>  Annotate type: 'struct rq' in [kernel.kallsyms] (29 samples):
>  ============================================================================
>   Percent     offset       size  field
>    100.00          0      0xe80  struct rq        {
>      0.00          0        0x4      raw_spinlock_t      __lock {
>      0.00          0        0x4          arch_spinlock_t raw_lock {
>      0.00          0        0x4              union        {
>      0.00          0        0x4                  atomic_t        val {
>      0.00          0        0x4                      int counter;
>                                                  };
>      0.00          0        0x2                  struct   {
>      0.00          0        0x1                      u8  locked;
>      0.00        0x1        0x1                      u8  pending;
>                                                  };
>      0.00          0        0x4                  struct   {
>      0.00          0        0x2                      u16 locked_pending;
>      0.00        0x2        0x2                      u16 tail;
>                                                  };
>                                              };
>                                          };
>                                      };
>     13.79        0x4        0x4      unsigned int        nr_running;
>     13.79        0x8        0x4      unsigned int        nr_numa_running;
>      0.00        0xc        0x4      unsigned int        nr_preferred_running;
>      0.00       0x10        0x4      unsigned int        numa_migrate_on;
>      0.00       0x18        0x8      long unsigned int   last_blocked_load_update_tick;
>      0.00       0x20        0x4      unsigned int        has_blocked_load;
>      0.00       0x40       0x20      call_single_data_t  nohz_csd {
>      0.00       0x40       0x10          struct __call_single_node       node {
>      0.00       0x40        0x8              struct llist_node   llist {
>      0.00       0x40        0x8                  struct llist_node*      next;
>                                              };
>      0.00       0x48        0x4              union        {
>      0.00       0x48        0x4                  unsigned int    u_flags;
>      0.00       0x48        0x4                  atomic_t        a_flags {
>      0.00       0x48        0x4                      int counter;
>                                                  };
>                                              };
>      ...
> 
> Thanks,
> Huafei
> 
> [1] https://lore.kernel.org/lkml/20231213001323.718046-1-namhyung@kernel.org/
> [2] https://lwn.net/Articles/955709/
> [3] https://lore.kernel.org/all/20240718084358.72242-1-atrajeev@linux.vnet.ibm.com/#r
> 
> Li Huafei (7):
>   perf annotate: Handle arm64 load and store instructions
>   perf annotate: Advance the mem_ref check to mov__parse()
>   perf annotate: Add 'extract_reg_offset' callback function to extract
>     register number and access offset
>   perf annotate: Support for the 'extract_reg_offset' callback function
>     in arm64
>   perf annotate-data: Support instruction tracking for arm64
>   perf annotate-data: Handle arm64 global variable access
>   perf annotate-data: Handle the access to the 'current' pointer on
>     arm64
> 
>  tools/perf/arch/arm64/annotate/instructions.c | 302 +++++++++++++++++-
>  .../perf/arch/powerpc/annotate/instructions.c |  10 +
>  tools/perf/arch/x86/annotate/instructions.c   |  99 ++++++
>  tools/perf/util/Build                         |   1 +
>  tools/perf/util/annotate-data.c               |  23 +-
>  tools/perf/util/annotate-data.h               |   4 +-
>  tools/perf/util/annotate.c                    | 112 +------
>  tools/perf/util/disasm.c                      |  14 +
>  tools/perf/util/disasm.h                      |   4 +
>  tools/perf/util/dwarf-regs-arm64.c            |  25 ++
>  tools/perf/util/include/dwarf-regs.h          |   7 +
>  11 files changed, 490 insertions(+), 111 deletions(-)
>  create mode 100644 tools/perf/util/dwarf-regs-arm64.c
> 
> -- 
> 2.25.1
> 
