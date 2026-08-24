Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E4538F949;
	Mon, 24 Aug 2026 21:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787607903; cv=none; b=MmKrPYZ/7yK1v8v0AsO420tO0x1EsZivOHVFR/OKaRVi6AJ9+rthn6BlW4m6TB0x1YxpW788lRlkzbdSFJnHJLwMTrpnLL1C4zhRcQOaLJdrbEzVeTne3I0QWfaPpYJFK1/nyfLXFf6UBcZKGTbToYIu+wli18GL+6r4+QyIES0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787607903; c=relaxed/simple;
	bh=CxkWu+utDxO6Iw249yf8VGoSa5lqmmdnUDkaIQLX4Gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAqny/j01drrVtyH1RfN7uVpSNty9VSFwqvVCS+4zc4rq6MYpIYhi+4s3kLQf98+4Sgl/LOO2tdglcq91xs+FO9kYcADKh0Duk1OAq0ArlMCHX5MqNvoxhvvCx68wGD2Y4IWjISBhKx/J4lgWEJMRTql7nq6edTo4qKCq2sEeTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=melKk4uf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="melKk4uf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9311F000E9;
	Mon, 24 Aug 2026 21:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787607901;
	bh=RjL/UMnwwqRqqNHq02+0Ugw9AbMNTGoyTIjarQ4v69U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=melKk4uf4wdRy10Pxd+G0Z8cLWy7h5Rq/ZUBuyzFDbRuAYKzL8QDRBhaKC8V0W4Ot
	 pCD0GbtqjPwG72aUWF24FZvUpeHtxUQoLuLcntQ5FhQPabq46VwT3hfsRA75IyNyWz
	 3QNbcDfeOvi8evgoumyTMhQvW9YeBHUcnCyTdiRThu+ZCfVMmolGOsiqZbluY8o2kd
	 pTZHwZ66be8q5r72fgu6z563LaMxhVIHiPtfUaFwnGhr6RpqD2PWXnGMH8KRIeodwD
	 KVC5zm0kHIPq0kb8LqjzJeSrkj8MoKC8I34T0ybf+Cn3Un9rsgy5rlNwSJzTwyNA2q
	 JgYR8xQbagHJw==
Date: Mon, 24 Aug 2026 14:44:59 -0700
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
Subject: Re: [PATCH v4 14/23] perf annotate-arm64: Support load instruction
 tracking
Message-ID: <aoy7W51agE4QDlz6@google.com>
References: <20260808122400.2961238-1-wutengda@huaweicloud.com>
 <20260808122400.2961238-15-wutengda@huaweicloud.com>
 <d61a0cbb-373f-4bc6-8493-889a76e27e87@linux.alibaba.com>
 <d3bce9bc-80c9-418a-b3a9-3e49dd82dd34@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d3bce9bc-80c9-418a-b3a9-3e49dd82dd34@huaweicloud.com>

On Thu, Aug 13, 2026 at 10:54:00PM +0800, Tengda Wu wrote:
> 
> 
> On 2026/8/11 15:36, Shuai Xue wrote:
> > 
> > 
> > On 8/8/26 8:23 PM, Tengda Wu wrote:
> >> Extend update_insn_state_arm64() to handle LDR instructions, tracking
> >> register state changes when data is loaded from memory to registers.
> >>
> >> The implementation handles the three primary arm64 addressing modes:
> >> 1. Signed offset: [base, #imm|reg]
> >> 2. Pre-index: [base, #imm]!
> >> 3. Post-index: [base], #imm
> >>
> >> Before updating, check the addressing mode via get_reg_index_offset() to
> >> obtain the actual source's reg_offset, and then propagate the type.
> >>
> >> Since a load instruction may have two destination registers (in ldp cases),
> >> introduce propagate_load_reg_state() to propagate the type for a specified
> >> destination register using a given reg_offset. The respective reg_offset
> >> values for the two registers are as follows:
> >>
> >>    dst->reg1: reg_offset = get_reg_index_offset()
> >>    dst->reg2: reg_offset = get_reg_index_offset() + reg_size(dst->reg1)
> >>
> >> Finally, handle the side effects of pre-index and post-index addressing
> >> via adjust_reg_index_state().
> >>
> >> A real-world example is shown below:
> >>
> >>    ffff80008011f5b0 <pick_task_stop>:
> >>    ffff80008011f5b8:  ldr  x0, [x0, #2712] // x0: struct rq* -> task_struct*
> >> * ffff80008011f5c0:  ldr  w1, [x0, #104]
> >>
> >> Before this commit, the type of x0 was incorrectly inferred as 'struct rq':
> >>
> >>    find data type for 0x68(reg0) at pick_task_stop+0x10
> >>    var [8] reg0 offset 0 type='struct rq*'
> >>    chk [10] reg0 offset=0x68 ok=1 kind=1 (struct rq*) : Good!
> >>    final result:  type='struct rq'
> >>
> >> After this commit, the type of x0 is correctly inferred as 'struct task_struct':
> >>
> >>    find data type for 0x68(reg0) at pick_task_stop+0x10
> >>    var [8] reg0 offset 0 type='struct rq*'
> >>    ldr [8] 0xa98(reg0) -> reg0 type='struct task_struct*'
> >>    chk [10] reg0 offset=0x68 ok=1 kind=1 (struct task_struct*) : Good!
> >>    final result: type='struct task_struct'
> >>
> >> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> >> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> >> ---
> >>   .../perf/util/annotate-arch/annotate-arm64.c  | 148 +++++++++++++++++-
> >>   1 file changed, 147 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
> >> index acff14ca01e0..6557c0ad11b2 100644
> >> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> >> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> >> @@ -358,11 +358,152 @@ static int extract_op_location_arm64(const struct arch *arch,
> >>   }
> >>     #ifdef HAVE_LIBDW_SUPPORT
> >> +static int arm64__reg_size(const char *reg)
> >> +{
> >> +    if (!reg || !*reg || !arm64__is_reg(reg))
> >> +        return -1;
> > 
> > Since arm64__is_reg() rejects xzr and SIMD registers, something like
> > ldp xzr, x19, [sp] ends up with multi_regs = false and x19 never
> > invalidated or tracked. Admittedly a corner case - but maybe worth
> > handling if extending the register set is cheap.
> > 
> 
> Agreed. But I'd propose that we first support recognizing xzr/wzr only,
> and leave SIMD registers for a future extension when we properly add SIMD support.
> 
> There shouldn't be a case where SIMD registers and general-purpose registers
> appear together within the same operands, right? If so, then skipping SIMD
> support for now should be fine.

I agree we should focus on GP registers and skip SIMD for now.

Thanks,
Namhyung

