Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0F4748F;
	Tue, 18 Mar 2025 01:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742262711; cv=none; b=JSsq31sbdhP9cP2WOS+LCnNNf9xNinDtpO4akJ25OCizXUmMBFsJuvkkDYe8/d/M+ivcPcl9L70so2mCK+B8rCiZF/ZAG/tmLzgviyeUEwUHtDj54EB2vWDHR8OpjoNCoUWDwgAusIuzMPrGw0MmHro3OIKO7LJKFWsoqb7GUQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742262711; c=relaxed/simple;
	bh=G23mUapcKGI0bq5I23W+bVxIi2SUfa9ELELg6EDzo7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BhxPJBrrWdl3dsM7tT11ig+62QWp4cRbkP2RSf9fS9iGeW5dAGoblV3+VXJpOBWV1S9Y5cWZxYEbKyTFSVIUOw01fXCwaPWV40fFt2ilAdwhC4BUzsCfwkJSEaw2kCuBaGw0neDfLkG6wY40Q6qE+l70BwAeYRvUuNxXkoq45qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhwdCBNV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhwdCBNV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E47C4CEE3;
	Tue, 18 Mar 2025 01:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742262711;
	bh=G23mUapcKGI0bq5I23W+bVxIi2SUfa9ELELg6EDzo7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UhwdCBNVmArLhOku75QhRPkOI7QN7I+Ll8ui4Zt4yq2YSEYOORmcOyIpo/QLRgc75
	 UZllW+VVGrcLwTNoK1HswqMaVdGE+7Xs1AZ8gEiTDoCOPP4uttALf9hDwxxyBEaOkR
	 N8/OJeBkFFm3mclyrh8bvlXEN+N5OypSs6n+HpZ96mmdb4frW293e97sHgAwyENCH1
	 slp3MKn/dqf9YosCD+BIiFJbrK+yOYe2l+azIb2oPYc68Vr8KoUvW9cT6ih/jDlkvF
	 dsQZUgl3ZAAh7zoQEQKAOsvfEHiRSs3r7yKWb4k9FCmF+JJyILB3KEZfErlUcHRlfF
	 sDDeRIYTtHWnQ==
Date: Mon, 17 Mar 2025 18:51:48 -0700
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
Subject: Re: [PATCH 5/7] perf annotate-data: Support instruction tracking for
 arm64
Message-ID: <Z9jRtDJY-RjiyFer@google.com>
References: <20250314162137.528204-1-lihuafei1@huawei.com>
 <20250314162137.528204-6-lihuafei1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250314162137.528204-6-lihuafei1@huawei.com>

On Sat, Mar 15, 2025 at 12:21:35AM +0800, Li Huafei wrote:
> Support for arm64 instruction tracing. This patch addresses the scenario
> where type information cannot be found during multi-level pointer
> references. For example, consider the vfs_ioctl() function:
> 
>  long vfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  {
>      int error = -ENOTTY;
> 
>      if (!filp->f_op->unlocked_ioctl)
>          goto out;
> 
>      error = filp->f_op->unlocked_ioctl(filp, cmd, arg);
>      if (error == -ENOIOCTLCMD)
>          error = -ENOTTY;
>  out:
>      return error;
>  }
> 
> The 'SYSCALL_DEFINE3(ioctl)' inlines vfs_ioctl, and the assembly
> instructions for 'if (!filp->f_op->unlocked_ioctl)' are as follows:
> 
>  ldr     x0, [x21, #16]
>  ldr     x3, [x0, #80]
>  cbz     x3, ffff80008048e9a4
> 
> The first instruction loads the 'filp->f_op' pointer, and the second
> instruction loads the 'filp->f_op->unlocked_ioctl' pointer. DWARF
> generates type information for x21, but not for x0. Therefore, if
> PMU sampling occurs on the second instruction, the corresponding data
> type cannot be obtained. However, by using the type information and
> offset from x21 in the first ldr instruction, we can infer the type
> of x0 and, combined with the offset, resolve the accessed data member.
> 
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> ---
>  tools/perf/arch/arm64/annotate/instructions.c | 44 ++++++++++++++++++-
>  tools/perf/util/annotate-data.c               |  3 +-
>  tools/perf/util/annotate-data.h               |  2 +-
>  tools/perf/util/disasm.c                      |  3 ++
>  4 files changed, 49 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/arch/arm64/annotate/instructions.c b/tools/perf/arch/arm64/annotate/instructions.c
> index 54497b72a5c5..f70d93001fe7 100644
> --- a/tools/perf/arch/arm64/annotate/instructions.c
> +++ b/tools/perf/arch/arm64/annotate/instructions.c
> @@ -215,7 +215,8 @@ extract_reg_offset_arm64(struct arch *arch __maybe_unused,
>  	static bool regex_compiled;
>  
>  	if (!regex_compiled) {
> -		regcomp(&reg_off_regex, "^\\[(sp|[xw][0-9]{1,2})(, #(-?[0-9]+))?\\].*",
> +		regcomp(&reg_off_regex,
> +			"^\\[(sp|[xw][0-9]{1,2})(, #(-?[0-9]+))?\\].*",

Does it have any real changes?  If not I'd rather leave it or move the
change to the original commit.


>  			REG_EXTENDED);
>  		regex_compiled = true;
>  	}
> @@ -250,3 +251,44 @@ extract_reg_offset_arm64(struct arch *arch __maybe_unused,
>  	free(str);
>  	return 0;
>  }
> +
> +#ifdef HAVE_LIBDW_SUPPORT
> +static void
> +update_insn_state_arm64(struct type_state *state, struct data_loc_info *dloc,
> +			Dwarf_Die * cu_die __maybe_unused, struct disasm_line *dl)
> +{
> +	struct annotated_insn_loc loc;
> +	struct annotated_op_loc *dst = &loc.ops[INSN_OP_TARGET];
> +	struct type_state_reg *tsr;
> +	Dwarf_Die type_die;
> +	int sreg, dreg;
> +
> +	if (strncmp(dl->ins.name, "ld", 2))
> +		return;
> +
> +	if (annotate_get_insn_location(dloc->arch, dl, &loc) < 0)
> +		return;
> +
> +	sreg = get_arm64_regnum(dl->ops.source.raw);
> +	if (sreg < 0)
> +		return;
> +	if (!has_reg_type(state, sreg))
> +		return;

It'd be better to invalidate state of the target register even if it
failed to get the information of source register and its state.  The
destination would be updated anyway and keeping the stale state would
result in an invalid report at the end.

Thanks,
Namhyung

> +
> +	dreg = dst->reg1;
> +	if (has_reg_type(state, dreg) && state->regs[dreg].ok &&
> +	    state->regs[dreg].kind == TSR_KIND_TYPE &&
> +	    dwarf_tag(&state->regs[dreg].type) == DW_TAG_pointer_type &&
> +	    die_deref_ptr_type(&state->regs[dreg].type,
> +			       dst->offset, &type_die)) {
> +		tsr = &state->regs[sreg];
> +		tsr->type = type_die;
> +		tsr->kind = TSR_KIND_TYPE;
> +		tsr->ok = true;
> +
> +		pr_debug_dtp("load [%x] %#x(reg%d) -> reg%d",
> +			     (u32)dl->al.offset, dst->offset, dreg, sreg);
> +		pr_debug_type_name(&tsr->type, tsr->kind);
> +	}
> +}
> +#endif
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> index 976abedca09e..2bc8d646eedc 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -1293,7 +1293,8 @@ static enum type_match_result find_data_type_insn(struct data_loc_info *dloc,
>  
>  static int arch_supports_insn_tracking(struct data_loc_info *dloc)
>  {
> -	if ((arch__is(dloc->arch, "x86")) || (arch__is(dloc->arch, "powerpc")))
> +	if ((arch__is(dloc->arch, "x86")) || (arch__is(dloc->arch, "powerpc")) ||
> +	    (arch__is(dloc->arch, "arm64")))
>  		return 1;
>  	return 0;
>  }
> diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
> index 98c80b2268dd..717f394eb8f1 100644
> --- a/tools/perf/util/annotate-data.h
> +++ b/tools/perf/util/annotate-data.h
> @@ -190,7 +190,7 @@ struct type_state_stack {
>  };
>  
>  /* FIXME: This should be arch-dependent */
> -#ifdef __powerpc__
> +#if defined(__powerpc__) || defined(__aarch64__)
>  #define TYPE_STATE_MAX_REGS  32
>  #else
>  #define TYPE_STATE_MAX_REGS  16
> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index 1035c60a8545..540981c155f9 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -129,6 +129,9 @@ static struct arch architectures[] = {
>  		.name = "arm64",
>  		.init = arm64__annotate_init,
>  		.extract_reg_offset = extract_reg_offset_arm64,
> +#ifdef HAVE_LIBDW_SUPPORT
> +		.update_insn_state = update_insn_state_arm64,
> +#endif
>  	},
>  	{
>  		.name = "csky",
> -- 
> 2.25.1
> 
