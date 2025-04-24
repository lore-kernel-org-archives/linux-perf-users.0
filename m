Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EF4A93D;
	Thu, 24 Apr 2025 18:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745518388; cv=none; b=bJUm/21sajx3zAWyaphaL/l0N0FK1X/9t4l8dsFccjiozkEllvTS3JnCQw6uYHJAMIXar546LdAlsWyt77HV4c+2qSX//Ep5TULbOJJuxsFIUvPkr+rQxY2TWLp7JvnygT2eBHRXW5vJXAAvoYxu1N1JEdYx8r+CkNIILZ8sQZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745518388; c=relaxed/simple;
	bh=yYs97Jd1RkJGVCrGGdVNydUIykMVC7x1/mkHbVGzG14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBXzfbxFWnpy7sl+PwRS+phj3RFnnVLrQUZBZ6xBiMqv53E8TqyQDTsn22GXWoNW09UABhWz0oEBupHAErR4NsbMrCaKpq/nAmYZUBaMLUiYCM6hoi4fvj5GmDh/C1ayFY9e/NQz9q8FAERkqCuFyoK3SahifC2Z4izFjKMUTK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTRnKJ7o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTRnKJ7o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527BFC4CEE3;
	Thu, 24 Apr 2025 18:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745518387;
	bh=yYs97Jd1RkJGVCrGGdVNydUIykMVC7x1/mkHbVGzG14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NTRnKJ7oRP07ihCoPNkZfR+5CEXTwJdhGnjrjvtctPdYPt/IxVZ59IN5H46vAYZW/
	 40+4G2Cl1s4ioX0ZsEn0tzqvFBgaE4XAPDZCkXuLjUBvarNtiH3R4FXp3cT5R7CR/y
	 ll+/b4gmtUAEDx2may7hdsHThIWmZz7FxW71kTTM2gcauhD5wIXpg7T8h4YoEt2yEk
	 B4rRlyUpaTDiz+wvF2Qz7DQRk1XU8/O+Gf/vllpAqI5xeeYy5l3M/SDhWm+CKZUeh8
	 8HsMywD5lg2I60VE8DXR6RCR2mM4edJTVXBz2z82B2T22ozgQwQLR/2hHyKgGO7s+d
	 8srE4vYo9GSGQ==
Date: Thu, 24 Apr 2025 15:13:04 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Athira Rajeev <atrajeev@linux.ibm.com>
Cc: jolsa@kernel.org, adrian.hunter@intel.com, irogers@google.com,
	namhyung@kernel.org, linux-perf-users@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
	disgoel@linux.vnet.ibm.com, hbathini@linux.vnet.ibm.com,
	Aditya.Bodkhe1@ibm.com, jiang.peng9@zte.com.cn,
	venkat88@linux.ibm.com, Tejas.Manhas1@ibm.com,
	sshegde@linux.ibm.com, sfr@canb.auug.org.au,
	linux-kernel@vger.kernel.org, mingo@redhat.com,
	ravi.bangoria@amd.com, bp@alien8.de
Subject: Re: [PATCH] perf build: Add tools/arch/x86/include/asm/amd/ibs.h to
 sync the headers
Message-ID: <aAp_MGf8HcKJ1QjY@x1>
References: <20250424163033.6601-1-atrajeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424163033.6601-1-atrajeev@linux.ibm.com>

On Thu, Apr 24, 2025 at 10:00:33PM +0530, Athira Rajeev wrote:
> Headers sync up update for the patch that adds the original
> copy of the IBS header file in arch/x86/include/asm/amd/ibs.h
 
> Without this, perf shows build warning:

Warning != error, so shouldn't result in something stopping to work.
 
>  # make

What is the cwd?

Probably tools/perf/

>   BUILD:   Doing 'make -j24' parallel build
> diff: tools/arch/x86/include/asm/amd/ibs.h: No such file or directory
> Warning: Kernel ABI header differences:
>   diff -u tools/include/uapi/linux/bits.h include/uapi/linux/bits.h
>   diff -u tools/include/linux/bits.h include/linux/bits.h
>   diff -u tools/include/vdso/unaligned.h include/vdso/unaligned.h
>   diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h
>   diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h
>   diff -u tools/arch/x86/include/asm/amd/ibs.h arch/x86/include/asm/amd/ibs.h
>   diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h
 
> Add tools/arch/x86/include/asm/amd directory and also file
> tools/arch/x86/include/asm/amd/ibs.h to sync up the kernel headers
> with perf tools and fix the warning:
 
> diff: tools/arch/x86/include/asm/amd/ibs.h: No such file or directory
 
> Apart from the warning, the perf build also fails as below on powerpc:
 
>   In file included from util/amd-sample-raw.c:12:0:
>   /root/bug/tip/tools/include/../../arch/x86/include/asm/amd/ibs.h:10:10: fatal error: asm/msr-index.h: No such file or directory
>    #include <asm/msr-index.h>
>             ^~~~~~~~~~~~~~~~~
>   compilation terminated.
 
> To fix this, added this change:
 
>   -#include <asm/msr-index.h>
>   +#include "../msr-index.h"
 
> And change the check-headers.sh entry to ignore this line when
> comparing with the original kernel header.

So, was this caused by some file being updated under tools/ that didn't
go thru the maintainers for that area?

It is important to read this file:

tools/include/uapi/README

Specially this part:

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.

--

So, files under tools/ should only be updated once it is determined that
it doesn't break building tools/.

And for that to happen, just submit it as a separate patch that should
be processed by tools people, if it makes sense.

- Arnaldo
 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Reported-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
> ---
>  tools/arch/x86/include/asm/amd/ibs.h | 158 +++++++++++++++++++++++++++
>  tools/perf/check-headers.sh          |   2 +-
>  2 files changed, 159 insertions(+), 1 deletion(-)
>  create mode 100644 tools/arch/x86/include/asm/amd/ibs.h
> 
> diff --git a/tools/arch/x86/include/asm/amd/ibs.h b/tools/arch/x86/include/asm/amd/ibs.h
> new file mode 100644
> index 000000000000..cbce54fec7b9
> --- /dev/null
> +++ b/tools/arch/x86/include/asm/amd/ibs.h
> @@ -0,0 +1,158 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_X86_AMD_IBS_H
> +#define _ASM_X86_AMD_IBS_H
> +
> +/*
> + * From PPR Vol 1 for AMD Family 19h Model 01h B1
> + * 55898 Rev 0.35 - Feb 5, 2021
> + */
> +
> +#include "../msr-index.h"
> +
> +/* IBS_OP_DATA2 DataSrc */
> +#define IBS_DATA_SRC_LOC_CACHE			 2
> +#define IBS_DATA_SRC_DRAM			 3
> +#define IBS_DATA_SRC_REM_CACHE			 4
> +#define IBS_DATA_SRC_IO				 7
> +
> +/* IBS_OP_DATA2 DataSrc Extension */
> +#define IBS_DATA_SRC_EXT_LOC_CACHE		 1
> +#define IBS_DATA_SRC_EXT_NEAR_CCX_CACHE		 2
> +#define IBS_DATA_SRC_EXT_DRAM			 3
> +#define IBS_DATA_SRC_EXT_FAR_CCX_CACHE		 5
> +#define IBS_DATA_SRC_EXT_PMEM			 6
> +#define IBS_DATA_SRC_EXT_IO			 7
> +#define IBS_DATA_SRC_EXT_EXT_MEM		 8
> +#define IBS_DATA_SRC_EXT_PEER_AGENT_MEM		12
> +
> +/*
> + * IBS Hardware MSRs
> + */
> +
> +/* MSR 0xc0011030: IBS Fetch Control */
> +union ibs_fetch_ctl {
> +	__u64 val;
> +	struct {
> +		__u64	fetch_maxcnt:16,/* 0-15: instruction fetch max. count */
> +			fetch_cnt:16,	/* 16-31: instruction fetch count */
> +			fetch_lat:16,	/* 32-47: instruction fetch latency */
> +			fetch_en:1,	/* 48: instruction fetch enable */
> +			fetch_val:1,	/* 49: instruction fetch valid */
> +			fetch_comp:1,	/* 50: instruction fetch complete */
> +			ic_miss:1,	/* 51: i-cache miss */
> +			phy_addr_valid:1,/* 52: physical address valid */
> +			l1tlb_pgsz:2,	/* 53-54: i-cache L1TLB page size
> +					 *	  (needs IbsPhyAddrValid) */
> +			l1tlb_miss:1,	/* 55: i-cache fetch missed in L1TLB */
> +			l2tlb_miss:1,	/* 56: i-cache fetch missed in L2TLB */
> +			rand_en:1,	/* 57: random tagging enable */
> +			fetch_l2_miss:1,/* 58: L2 miss for sampled fetch
> +					 *      (needs IbsFetchComp) */
> +			l3_miss_only:1,	/* 59: Collect L3 miss samples only */
> +			fetch_oc_miss:1,/* 60: Op cache miss for the sampled fetch */
> +			fetch_l3_miss:1,/* 61: L3 cache miss for the sampled fetch */
> +			reserved:2;	/* 62-63: reserved */
> +	};
> +};
> +
> +/* MSR 0xc0011033: IBS Execution Control */
> +union ibs_op_ctl {
> +	__u64 val;
> +	struct {
> +		__u64	opmaxcnt:16,	/* 0-15: periodic op max. count */
> +			l3_miss_only:1,	/* 16: Collect L3 miss samples only */
> +			op_en:1,	/* 17: op sampling enable */
> +			op_val:1,	/* 18: op sample valid */
> +			cnt_ctl:1,	/* 19: periodic op counter control */
> +			opmaxcnt_ext:7,	/* 20-26: upper 7 bits of periodic op maximum count */
> +			reserved0:5,	/* 27-31: reserved */
> +			opcurcnt:27,	/* 32-58: periodic op counter current count */
> +			ldlat_thrsh:4,	/* 59-62: Load Latency threshold */
> +			ldlat_en:1;	/* 63: Load Latency enabled */
> +	};
> +};
> +
> +/* MSR 0xc0011035: IBS Op Data 1 */
> +union ibs_op_data {
> +	__u64 val;
> +	struct {
> +		__u64	comp_to_ret_ctr:16,	/* 0-15: op completion to retire count */
> +			tag_to_ret_ctr:16,	/* 15-31: op tag to retire count */
> +			reserved1:2,		/* 32-33: reserved */
> +			op_return:1,		/* 34: return op */
> +			op_brn_taken:1,		/* 35: taken branch op */
> +			op_brn_misp:1,		/* 36: mispredicted branch op */
> +			op_brn_ret:1,		/* 37: branch op retired */
> +			op_rip_invalid:1,	/* 38: RIP is invalid */
> +			op_brn_fuse:1,		/* 39: fused branch op */
> +			op_microcode:1,		/* 40: microcode op */
> +			reserved2:23;		/* 41-63: reserved */
> +	};
> +};
> +
> +/* MSR 0xc0011036: IBS Op Data 2 */
> +union ibs_op_data2 {
> +	__u64 val;
> +	struct {
> +		__u64	data_src_lo:3,	/* 0-2: data source low */
> +			reserved0:1,	/* 3: reserved */
> +			rmt_node:1,	/* 4: destination node */
> +			cache_hit_st:1,	/* 5: cache hit state */
> +			data_src_hi:2,	/* 6-7: data source high */
> +			reserved1:56;	/* 8-63: reserved */
> +	};
> +};
> +
> +/* MSR 0xc0011037: IBS Op Data 3 */
> +union ibs_op_data3 {
> +	__u64 val;
> +	struct {
> +		__u64	ld_op:1,			/* 0: load op */
> +			st_op:1,			/* 1: store op */
> +			dc_l1tlb_miss:1,		/* 2: data cache L1TLB miss */
> +			dc_l2tlb_miss:1,		/* 3: data cache L2TLB hit in 2M page */
> +			dc_l1tlb_hit_2m:1,		/* 4: data cache L1TLB hit in 2M page */
> +			dc_l1tlb_hit_1g:1,		/* 5: data cache L1TLB hit in 1G page */
> +			dc_l2tlb_hit_2m:1,		/* 6: data cache L2TLB hit in 2M page */
> +			dc_miss:1,			/* 7: data cache miss */
> +			dc_mis_acc:1,			/* 8: misaligned access */
> +			reserved:4,			/* 9-12: reserved */
> +			dc_wc_mem_acc:1,		/* 13: write combining memory access */
> +			dc_uc_mem_acc:1,		/* 14: uncacheable memory access */
> +			dc_locked_op:1,			/* 15: locked operation */
> +			dc_miss_no_mab_alloc:1,		/* 16: DC miss with no MAB allocated */
> +			dc_lin_addr_valid:1,		/* 17: data cache linear address valid */
> +			dc_phy_addr_valid:1,		/* 18: data cache physical address valid */
> +			dc_l2_tlb_hit_1g:1,		/* 19: data cache L2 hit in 1GB page */
> +			l2_miss:1,			/* 20: L2 cache miss */
> +			sw_pf:1,			/* 21: software prefetch */
> +			op_mem_width:4,			/* 22-25: load/store size in bytes */
> +			op_dc_miss_open_mem_reqs:6,	/* 26-31: outstanding mem reqs on DC fill */
> +			dc_miss_lat:16,			/* 32-47: data cache miss latency */
> +			tlb_refill_lat:16;		/* 48-63: L1 TLB refill latency */
> +	};
> +};
> +
> +/* MSR 0xc001103c: IBS Fetch Control Extended */
> +union ic_ibs_extd_ctl {
> +	__u64 val;
> +	struct {
> +		__u64	itlb_refill_lat:16,	/* 0-15: ITLB Refill latency for sampled fetch */
> +			reserved:48;		/* 16-63: reserved */
> +	};
> +};
> +
> +/*
> + * IBS driver related
> + */
> +
> +struct perf_ibs_data {
> +	u32		size;
> +	union {
> +		u32	data[0];	/* data buffer starts here */
> +		u32	caps;
> +	};
> +	u64		regs[MSR_AMD64_IBS_REG_COUNT_MAX];
> +};
> +
> +#endif /* _ASM_X86_AMD_IBS_H */
> diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
> index e9fab20e9330..e1a1fdfa7115 100755
> --- a/tools/perf/check-headers.sh
> +++ b/tools/perf/check-headers.sh
> @@ -186,7 +186,7 @@ done
>  # diff with extra ignore lines
>  check arch/x86/lib/memcpy_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>" -I"^SYM_FUNC_START\(_LOCAL\)*(memcpy_\(erms\|orig\))" -I"^#include <linux/cfi_types.h>"'
>  check arch/x86/lib/memset_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>" -I"^SYM_FUNC_START\(_LOCAL\)*(memset_\(erms\|orig\))"'
> -check arch/x86/include/asm/amd/ibs.h  '-I "^#include [<\"]\(asm/\)*msr-index.h"'
> +check arch/x86/include/asm/amd/ibs.h  '-I "^#include <asm/msr-index.h>" -I "^#include \"\.\./msr-index.h\""'
>  check arch/arm64/include/asm/cputype.h '-I "^#include [<\"]\(asm/\)*sysreg.h"'
>  check include/linux/unaligned.h '-I "^#include <linux/unaligned/packed_struct.h>" -I "^#include <asm/byteorder.h>" -I "^#pragma GCC diagnostic"'
>  check include/uapi/asm-generic/mman.h '-I "^#include <\(uapi/\)*asm-generic/mman-common\(-tools\)*.h>"'
> -- 
> 2.43.0
