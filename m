Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AC3384CC2;
	Mon, 24 Aug 2026 21:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787608704; cv=none; b=Jc3oZu0jmuvBgnWoURSWCyJKNZT3pmz2eyr0T3tDPEdGLTd0PWOHtsDtTJtwnX1MCVS/XLVXa6ld58d/uj+7gvwts4yd/wAhb2w5E+4olJPGUTREcD3/F9WAnh5qzUS2cgT4GvH32fPDljBbe+34SH+3TwWb0e/B0CrCYHPegYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787608704; c=relaxed/simple;
	bh=3+e1LEL1GTN37WIUSW3CYs28IERN7B+MvdsHKwkiuMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ceOk154eRXDiL0Y3nVmtUKgD7v2sYO8zHr7ZHcI9CMK4afoKRTPcx61LyGnwek9/LyGQ+bZwnX87JJ82o6S69caqRkX9B8jp+4K5BTIP/KdkDTP0XSM0sb9kVkmUJJj1NfoRmBkFqudwtwgcRdUyFiwslaRPW7iRUW3QGkbhxkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAF82jiu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAF82jiu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0959C1F000E9;
	Mon, 24 Aug 2026 21:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787608698;
	bh=ddc8LIwIoZ20tI8UJZNbO3PstIIFDU+UdXfxRxuiYdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nAF82jiuU6rzNca3JQQfFz/IRBZMJ2fl/TI0G5EFvxt0aiNGYFyznMFR0M1MDpbEu
	 huP6lP1sCImvrbGOzRmpwi3mYXl/P4psSQTAKiDx7hmW9+O3tdnWJnfZvfOisk7bd2
	 gEwEPykxfKM5paJkdunrTvo4y7xompMPLEKVNC8QzypODIrYHrqbqZv+2srgpokKqd
	 WFdXs9pMWDEQpWPBH1pUGsZXWU4AxGi7iFEVvjEczJSQVc5xgERCGrQA+cgyY9AL+r
	 zOAWqha3LeYtYevzVgGUh8XVETovT0CYIvpt9IbsMZfPY/Z6aSRVy822JdpkqgiomC
	 qeykYl1QBg9Yw==
Date: Mon, 24 Aug 2026 14:58:16 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>, james.clark@linaro.org,
	Li Huafei <lihuafei1@huawei.com>,
	Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
	Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Zecheng Li <zli94@ncsu.edu>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v4 20/23] perf annotate-arm64: Support 'add' instruction
 tracking
Message-ID: <aoy-eAVaW_TsdymE@google.com>
References: <20260808122400.2961238-1-wutengda@huaweicloud.com>
 <20260808122400.2961238-21-wutengda@huaweicloud.com>
 <89e66d40-5f9f-4147-beda-00623797cd04@linux.alibaba.com>
 <b5e4ef0d-cb11-45de-987a-226340b576ed@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b5e4ef0d-cb11-45de-987a-226340b576ed@huaweicloud.com>

On Wed, Aug 19, 2026 at 11:04:36AM +0800, Tengda Wu wrote:
> 
> 
> On 2026/8/11 16:45, Shuai Xue wrote:
> > 
> > 
> > On 8/8/26 8:23 PM, Tengda Wu wrote:
> >> Extend update_insn_state() for arm64 to track 'add' instructions for
> >> structure member address calculation, which commonly appear as:
> >>
> >>    add  dreg, base, #offset
> >>    add  dreg, base, reg2     (reg2 holds a constant)
> >>
> >> Unlike x86, the arm64 'add' instruction has an extra base register among
> >> its source operands. Therefore, in terms of propagating the data type,
> >> it is essentially performing a 'mov', except that before the 'mov', it
> >> first needs to be updated by adding the offset or reg2.
> >>
> >> A real-world example is shown below:
> >>
> >>    ffff80008001c9a8 <flush_ptrace_hw_breakpoint>:
> >>    ffff80008001c9c4:  add  x19, x0, #0xeb8   // x0 (task_struct*) + 0xeb8 -> x19
> >> * ffff80008001c9d0:  ldr  x0, [x19]
> >>
> >> Before this commit, the type flow broke at the 'add' instruction,
> >> leaving the subsequent load with no type information:
> >>
> >>    chk [28] reg19 offset=0 ok=0 kind=0 cfa : no type information
> >>    final result: no type information
> >>
> >> After this commit, the tracker correctly follows the member address
> >> calculation:
> >>
> >>    var [0] reg0 offset 0 type='struct task_struct*'
> >>    add [1c] address of 0xeb8(reg0) -> reg19 type='struct task_struct*'
> >>    chk [28] reg19 offset=0 ok=1 kind=1 (struct task_struct*) : Good!
> >>    found by insn track: 0(reg19) type-offset=0xeb8
> >>    final result: type='struct task_struct'
> >>
> >> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> >> ---
> >>   .../perf/util/annotate-arch/annotate-arm64.c  | 87 ++++++++++++++++++-
> >>   1 file changed, 85 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
> >> index 7b780bad8c07..eaeb4433fc3a 100644
> >> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> >> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> >> @@ -688,6 +688,87 @@ static void update_mov_insn_state(struct type_state *state,
> >>       pr_debug_type_name(&tsr->type, tsr->kind);
> >>   }
> >>   +static void update_add_insn_state(struct type_state *state,
> >> +                  struct disasm_line *dl,
> >> +                  struct annotated_op_loc *src,
> >> +                  struct annotated_op_loc *dst)
> >> +{
> >> +    struct type_state_reg *tsr;
> >> +    struct type_state_reg src_tsr;
> >> +    u32 insn_offset = dl->al.offset;
> >> +    int sreg = src->reg1;
> >> +    int dreg = dst->reg1;
> >> +    u64 imm_value;
> >> +
> >> +    if (!has_reg_type(state, dreg))
> >> +        return;
> >> +
> >> +    tsr = &state->regs[dreg];
> >> +    tsr->copied_from = -1;
> >> +
> >> +retry:
> >> +    if (!has_reg_type(state, sreg) || !state->regs[sreg].ok) {
> >> +        invalidate_reg_state(tsr);
> >> +        return;
> >> +    }
> >> +
> >> +    src_tsr = state->regs[sreg];
> >> +
> >> +    /*
> >> +     * Handle 'add' instructions of the form:
> >> +     *   add  dreg, base, #offset     (immediate offset)
> >> +     *   add  dreg, base, reg2        (reg2 holds a constant)
> >> +     *
> >> +     * For case 2, retrieve the constant value from reg2
> >> +     * and use it as the offset.
> >> +     */
> >> +    imm_value = src->offset;
> >> +    if (src->multi_regs) {
> >> +        int reg2 = (sreg == src->reg1) ? src->reg2 : src->reg1;
> >> +
> >> +        if (!has_reg_type(state, reg2) || !state->regs[reg2].ok) {
> >> +            /* Unable to resolve type for dst, bail out */
> >> +            invalidate_reg_state(tsr);
> >> +            return;
> >> +        }
> >> +        if (state->regs[reg2].kind == TSR_KIND_CONST)
> >> +            imm_value = state->regs[reg2].imm_value;
> > 
> > First, when reg2 is valid but not TSR_KIND_CONST - say a pointer
> > freshly loaded from memory - the addend is unknown at analysis time,
> > yet imm_value silently stays 0 and propagation continues, tracking
> > the destination as base + 0. Note the asymmetry: no state at all
> > invalidates, but state that doesn't yield a value pretends the
> > addend is zero. Unknown addend should invalidate as well:
> > 
> >         if (state->regs[reg2].kind != TSR_KIND_CONST) {
> >             invalidate_reg_state(tsr);
> >             return;
> >         }
> > 
> 
> It might not be a direct invalidation, but rather swapping reg1/reg2 and
> then retrying.
> 
> > Second, the shifted/extended forms still break even with a constant
> > reg2: extract_op_location_arm64() drops the "lsl #3" (or uxtw/sxtw)
> > modifier, so add x0, x1, x2, lsl #3 contributes the unshifted value
> > and maps later accesses to the wrong field. Maybe flag such operands
> > during extraction (or fail the reg2 extraction) so the handler can
> > skip them.
> >
> 
> Okay, so it seems shifted/extended forms are unavoidable. We may need to
> introduce more fields into annotated_op_loc to record them, like this:
> 
> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index 138d9258281c..b00e0ad96023 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -501,6 +501,8 @@ int arch__dwarf_regnum(const struct arch *arch, const char *str);
>   * @offset: Memory access offset in the operand
>   * @segment: Segment selector register
>   * @addr_mode: Addressing mode, only valid if @mem_ref is true
> + * @extend_type: ARM64 register extend specifier (enum annotated_ext_type)
> + * @shift: ARM64 shift amount (e.g., 0 to 4)
>   * @mem_ref: Whether the operand accesses memory
>   * @multi_regs: Whether the second register is used
>   * @imm: Whether the operand is an immediate value (in offset)
> @@ -511,6 +513,8 @@ struct annotated_op_loc {
>  	int offset;
>  	u8 segment;
>  	u8 addr_mode;
> +	u8 extend_type;
> +	u8 shift;
>  	bool mem_ref;
>  	bool multi_regs;
>  	bool imm;
> @@ -542,6 +546,19 @@ enum annotated_addr_mode {
>  	PERF_ADDR_MODE_POST_INDEX,
>  };
>  
> +enum annotated_ext_type {
> +	PERF_EXT_NONE = 0,
> +
> +	PERF_EXT_UXTB,
> +	PERF_EXT_SXTB,
> +	PERF_EXT_UXTH,
> +	PERF_EXT_SXTH,
> +	PERF_EXT_UXTW,
> +	PERF_EXT_SXTW,
> +	PERF_EXT_UXTX,  /* LSL is equivalent to UXTX */
> +	PERF_EXT_SXTX,
> +};
> +

Looks ok to me.  But more comments are needed for those who are not
familiar with the arm64 ISA.

Thanks,
Namhyung


>  /**
>   * struct annotated_insn_loc - Location info of instruction
>   * @ops: Array of location info for source and target operands
> 
> 
> >> +    }
> >> +
> >> +    if (src_tsr.kind == TSR_KIND_CONST) {
> >> +        tsr->kind = src_tsr.kind;
> >> +        tsr->imm_value = src_tsr.imm_value + imm_value;
> >> +        tsr->offset = 0;
> >> +        tsr->ok = src_tsr.ok;
> >> +
> >> +        pr_debug_dtp("add [%x] imm %#"PRIx64"(reg%d) -> reg%d\n",
> >> +                 insn_offset, imm_value, sreg, dreg);
> > 
> > And since add is commutative, this early return drops the pointer
> > side for add rd, const_reg, ptr_reg: sreg starts as reg1, hits the
> > CONST case and returns before the goto retry at the bottom ever gets
> > a chance to evaluate the pointer register. The result should be the
> > pointer with the constant applied as an offset, not a plain constant.
> > Maybe check the other register for a pointer type before falling into
> > the CONST case (or move the CONST handling after the retry).
> > 
> 
> Yeah, this issue is a side effect of the previous incomplete handling and
> will be fixed together.
> 
> Thanks,
> Tengda
> 
