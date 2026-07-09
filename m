Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C973E3D89;
	Thu,  9 Jul 2026 07:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783582585; cv=none; b=oqYF4F5+Z6M+4hGXDyAH5gFId6w9hOMGnO1QnSOYJzelatfwYdtn72nCNzp5kx/dqoNlE5ZkndQFYRF9w3oJ/3AGPrvDrNibvCEWvGP/3ZoGj+y19hGqeQFauQeWId0V8/vWzCXzAcZT9HtuTwAojk4SebWudTbDRaitoU/KGJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783582585; c=relaxed/simple;
	bh=UNxg9kiympo3qvn/tmDRZa/UEh/7A4xSn6rAkFrxkR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGRpk939+IEu3VBeRxmRkRRNgjTW/3QNRFhQpL1Ps6xgzh0zY8Z9dVr2baSkk1JQmJG81Ej4/keVX9MgyL8uYqmOEl60ou5PMy2dqh624h4G8eKlPEnbM7pevhu08TRe4CaFrV0gQwunGpkxVGtN9VvABbEGcAeNepRR4p8VG9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYLa4EKZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYLa4EKZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4211F000E9;
	Thu,  9 Jul 2026 07:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783582580;
	bh=N4rv3rv3aDuiM2X7qoF4jvMFoMubFY32zS0YnHJnaJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YYLa4EKZifVsSY5FcAoE+f+AGMQ6abIoEvH1L1LRaCTCE2oe9CE/+tNT+gcCQFhTz
	 Tn/SYuLgprSOwzLg5TRW685N9+ZePcTNSSw5l0IownLP8m8cFWQwUz7PL7j1vmyjK/
	 Y8g0gH0oTpNQnxS2Gy4lzGopuiM3zkl+rINJoKlBLF8IVau80lYz06ab2gviMbIS6n
	 ERDFuEohQZrj8S7qI2+hWMpOJqnn6FdOVrIEp83EJmyItQ/kpEJRBs0XunfORLUcdx
	 DPpL9yqV2NZOyjVhKcqgWIolApX3RiuHts+VLVqw8YlMSf4u0M+Y6/GYQ7LmekGuFJ
	 70K4zrff/B+Lg==
Date: Thu, 9 Jul 2026 00:36:19 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 21/21] perf annotate-arm64: Support 'mrs' instruction
 to track 'current' pointer
Message-ID: <ak9Pc1Gq_eSvsoek@z2>
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
 <20260701035355.752944-22-wutengda@huaweicloud.com>
 <20260701041636.7FEDC1F000E9@smtp.kernel.org>
 <9b181384-028e-4597-8dae-4416b43c940c@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9b181384-028e-4597-8dae-4416b43c940c@huaweicloud.com>

On Wed, Jul 01, 2026 at 04:56:06PM +0800, Tengda Wu wrote:
> 
> 
> On 2026/7/1 12:16, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> > - [Medium] Memory leak of the dynamically allocated `type_name` string obtained from `strbuf_detach()`.
> > - [Medium] Cross-DSO contamination and potential type confusion due to globally caching a DWARF offset (`task_struct_dieoff`).
> > --
> > 
> > commit 0f7d6f3c161448b3cb967b47ee3887be3d974dc1
> > Author: Tengda Wu <wutengda@huaweicloud.com>
> > 
> > perf annotate-arm64: Support 'mrs' instruction to track 'current' pointer
> > 
> > This commit adds support for parsing the 'mrs' instruction on arm64 in
> > 'perf annotate' to track the 'current' task pointer. It dynamically queries
> > the DWARF debug information for the 'get_current()' inline function's
> > return type to find 'struct task_struct', caching the DWARF offset for
> > subsequent lookups.
> > 
> >> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
> >> index ec6fd59d51a27..89e3997f6721b 100644
> >> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> >> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> > [ ... ]
> >> @@ -787,6 +789,81 @@ static void update_adrp_insn_state(struct type_state *state,
> >>  		     insn_offset, tsr->addr, dreg);
> >>  }
> >>  
> >> +static Dwarf_Off task_struct_dieoff;
> >> +
> >> +static void update_mrs_insn_state(struct type_state *state,
> >> +				  struct data_loc_info *dloc, Dwarf_Die *cu_die,
> >> +				  struct disasm_line *dl,
> >> +				  struct annotated_op_loc *dst)
> >> +{
> > [ ... ]
> >> +	/* Handle case difference: LLVM (SP_EL0) vs objdump (sp_el0) */
> >> +	if (!dso__kernel(map__dso(dloc->ms->map)) ||
> >> +	    strcasecmp(dl->ops.source.raw, "sp_el0")) {
> >> +		invalidate_reg_state(tsr);
> >> +		return;
> >> +	}
> >> +
> >> +	ip = dloc->ms->sym->start + dl->al.offset;
> >> +	pc = map__rip_2objdump(dloc->ms->map, ip);
> >> +
> >> +	if (!task_struct_dieoff ||
> >> +	    !dwarf_offdie(dloc->di->dbg, task_struct_dieoff, &type_die)) {
> > 
> > [Severity: Medium]
> > Since DWARF offsets are local to their .debug_info section, if perf annotate
> > processes a symbol in a different kernel module (where dso__kernel() is still
> > true), couldn't this global task_struct_dieoff be applied to the module's
> > Dwarf * handle?
> > 
> > Would this result in type confusion or returning an arbitrary, unrelated DIE
> > across different DSOs?

Right, you need to invalidate the cache when the current debug info is
closed.

> > 
> >> +		struct strbuf sb;
> >> +		char *type_name;
> >> +		/*
> >> +		 * Find the inline function 'get_current()' Dwarf_Die
> >> +		 * and obtain its return value data type, which should
> >> +		 * be 'struct task_struct*'.
> >> +		 */
> >> +		if (!die_find_inlinefunc(cu_die, pc, &func_die) ||

Probably better to check the name of the function.

Thanks,
Namhyung


> >> +			!dwarf_attr_integrate(&func_die, DW_AT_type, &attr) ||
> >> +			!dwarf_formref_die(&attr, &type_die)) {
> >> +			invalidate_reg_state(tsr);
> >> +			return;
> >> +		}
> >> +
> >> +		strbuf_init(&sb, 32);
> >> +		die_get_typename_from_type(&type_die, &sb);
> >> +		type_name = strbuf_detach(&sb, NULL);
> >> +
> >> +		if (!type_name || strcmp(type_name, "struct task_struct*")) {
> >> +			invalidate_reg_state(tsr);
> >> +			return;
> >> +		}
> > 
> > [Severity: Medium]
> > Does this code leak the type_name string?
> > 
> > strbuf_detach() allocates and transfers ownership of the string to type_name,
> > but it appears to never be freed on either the success path or the error path
> > returning here.
> > 
> 
> Agreed. Will fix it in next version.
> 
> >> +
> >> +		/*
> >> +		 * Cache the 'struct task_struct*' die offset globally.
> >> +		 * This allows us to resolve stack canary accesses even
> >> +		 * in CUs that lack a full task_struct definition (e.g.,
> >> +		 * compiler-generated entry/exit code).
> >> +		 */
> >> +		task_struct_dieoff = dwarf_dieoffset(&type_die);
> >> +	}
> > 
> 
