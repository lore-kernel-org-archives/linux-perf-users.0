From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCHv2] perf bpf: Fix endianness problem when loading
 parameters in prologue
Date: Mon, 14 Aug 2017 13:39:15 -0300
Message-ID: <20170814163915.GB4114@kernel.org>
References: <20170814114644.82526-1-tmricht@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751042AbdHNQj0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Aug 2017 12:39:26 -0400
Content-Disposition: inline
In-Reply-To: <20170814114644.82526-1-tmricht@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: wangnan0@huawei.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, brueckner@linux.vnet.ibm.com

Em Mon, Aug 14, 2017 at 01:46:44PM +0200, Thomas Richter escreveu:
> Perf BPF prologue generator unconditionally fetches 8 bytes for function
> parameters, which causes problem on big endian machine. Thomas gives a
> detail analysis for this problem:
> 
>  http://lkml.kernel.org/r/968ebda5-abe4-8830-8d69-49f62529d151@linux.vnet.ibm.com
> 
> This patch parses the type of each argument and converts data from
> memory to expected type.
> 
> Now the test runs successfully on 4.13.0-rc5:
> [root@s8360046 perf]# ./perf test  bpf
> 38: BPF filter                                 :
> 38.1: Basic BPF filtering                      : Ok
> 38.2: BPF pinning                              : Ok
> 38.3: BPF prologue generation                  : Ok
> 38.4: BPF relocation checker                   : Ok
> [root@s8360046 perf]#
> 
> Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
> Signed-off-by: Wang Nan <wangnan0@huawei.com>
> Acked-by: Wang Nan <wangnan0@huawei.com>
> Tested-by: Wang Nan <wangnan0@huawei.com>


That is strange, who is the author of the patch? Also I think Tested-by
is enough, being an even stronger form of Acked-by?

But then you also have Signed-off-by: Wang in there...

From Documentation/process/submitting-patches.rst:

---------

12) When to use Acked-by: and Cc:
---------------------------------

The Signed-off-by: tag indicates that the signer was involved in the
development of the patch, or that he/she was in the patch's delivery path.

If a person was not directly involved in the preparation or handling of a
patch but wishes to signify and record their approval of it then they can
ask to have an Acked-by: line added to the patch's changelog.

Acked-by: is often used by the maintainer of the affected code when that
maintainer neither contributed to nor forwarded the patch.

------------------

If Wang wrote the original patch and you made it better working together
with him, probably having both of you in Signed-off-by lines should be
enough?

- Arnaldo

> ---
>  tools/perf/tests/bpf-script-test-prologue.c |  4 ++-
>  tools/perf/util/bpf-prologue.c              | 49 +++++++++++++++++++++++++++--
>  2 files changed, 50 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/tests/bpf-script-test-prologue.c b/tools/perf/tests/bpf-script-test-prologue.c
> index b4ebc75..43f1e16 100644
> --- a/tools/perf/tests/bpf-script-test-prologue.c
> +++ b/tools/perf/tests/bpf-script-test-prologue.c
> @@ -26,9 +26,11 @@ static void (*bpf_trace_printk)(const char *fmt, int fmt_size, ...) =
>  	(void *) 6;
>  
>  SEC("func=null_lseek file->f_mode offset orig")
> -int bpf_func__null_lseek(void *ctx, int err, unsigned long f_mode,
> +int bpf_func__null_lseek(void *ctx, int err, unsigned long _f_mode,
>  			 unsigned long offset, unsigned long orig)
>  {
> +	fmode_t f_mode = (fmode_t)_f_mode;
> +
>  	if (err)
>  		return 0;
>  	if (f_mode & FMODE_WRITE)
> diff --git a/tools/perf/util/bpf-prologue.c b/tools/perf/util/bpf-prologue.c
> index 1356220..827f914 100644
> --- a/tools/perf/util/bpf-prologue.c
> +++ b/tools/perf/util/bpf-prologue.c
> @@ -58,6 +58,46 @@ check_pos(struct bpf_insn_pos *pos)
>  	return 0;
>  }
>  
> +/*
> + * Convert type string (u8/u16/u32/u64/s8/s16/s32/s64 ..., see
> + * Documentation/trace/kprobetrace.txt) to size field of BPF_LDX_MEM
> + * instruction (BPF_{B,H,W,DW}).
> + */
> +static int
> +argtype_to_ldx_size(const char *type)
> +{
> +	int arg_size = type ? atoi(&type[1]) : 64;
> +
> +	switch (arg_size) {
> +	case 8:
> +		return BPF_B;
> +	case 16:
> +		return BPF_H;
> +	case 32:
> +		return BPF_W;
> +	case 64:
> +	default:
> +		return BPF_DW;
> +	}
> +}
> +
> +static const char *
> +insn_sz_to_str(int insn_sz)
> +{
> +	switch (insn_sz) {
> +	case BPF_B:
> +		return "BPF_B";
> +	case BPF_H:
> +		return "BPF_H";
> +	case BPF_W:
> +		return "BPF_W";
> +	case BPF_DW:
> +		return "BPF_DW";
> +	default:
> +		return "UNKNOWN";
> +	}
> +}
> +
>  /* Give it a shorter name */
>  #define ins(i, p) append_insn((i), (p))
>  
> @@ -258,9 +298,14 @@ gen_prologue_slowpath(struct bpf_insn_pos *pos,
>  	}
>  
>  	/* Final pass: read to registers */
> -	for (i = 0; i < nargs; i++)
> -		ins(BPF_LDX_MEM(BPF_DW, BPF_PROLOGUE_START_ARG_REG + i,
> +	for (i = 0; i < nargs; i++) {
> +		int insn_sz = (args[i].ref) ? argtype_to_ldx_size(args[i].type) : BPF_DW;
> +
> +		pr_debug("prologue: load arg %d, insn_sz is %s\n",
> +			 i, insn_sz_to_str(insn_sz));
> +		ins(BPF_LDX_MEM(insn_sz, BPF_PROLOGUE_START_ARG_REG + i,
>  				BPF_REG_FP, -BPF_REG_SIZE * (i + 1)), pos);
> +	}
>  
>  	ins(BPF_JMP_IMM(BPF_JA, BPF_REG_0, 0, JMP_TO_SUCCESS_CODE), pos);
>  
> -- 
> 2.9.3
