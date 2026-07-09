Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9E0365A17;
	Thu,  9 Jul 2026 07:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783581455; cv=none; b=jSm6PJ9Alwf5CDH3OrChLfT6TvaTqIMTtVYgaWRZz0A3o+uxVkTmPzZ5151AyUi3JF+w3mE1G2ukEIpIMQQwAl7fsthY6EvJFbEE1jKlT5TzQLxygFWkHsOK6nodqCBmdIN/MFjX/rhuN5Jna1CPsnVMOzGb2L3eUT0Y/XEj1Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783581455; c=relaxed/simple;
	bh=Bqo0uoRSlE6EkmhNLxqF4nRijEAU3pLvxs6Uw2fk6/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVkhD/QrEWOQbVjtmwkj0FiY6izWRN9bwc6ZW35HMsfdeXxiSW11DcdZ6Z28GicHZIMC4WoEOkUoGEXka1m2yEfHUgvRsWxh2TAwxOwjN2R7TzTn+OHQeFNQZO9V5FRZs2dKBaECIxfG47iDPmYc6t0bbO36PdrurcfgcTIfqY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Auh5r01n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Auh5r01n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D03F1F00A3A;
	Thu,  9 Jul 2026 07:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783581454;
	bh=GJiK3L3oRRiN3d8ICHLHs7dvqb9hVUGKtEiTpqWX+oo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Auh5r01n0MdeEFfxafkHCQPtn+P7ucr3BwW/T0NHblPbd7Cth398B8mu0bVRHloYV
	 TgHfKm6SYdxVfRY+1PV+i3qso5+it98JN+CtKGL7SGPDpZ+53Ts53glyShk2ySj2Of
	 LhafSMByjnx751n+bp1cOgY9Ds1lsNHyStacSCHc/dVxpWtGuxFvQWUdKAcXCXKCAQ
	 +joM7F/ZLThUYUDg5EuQbMmKWt5WFEUNXxG2BJLCdsFklw7J5UQ5i6J4qdMGp9GAet
	 3+BC3hmIRqprmzr2i8cz+x69Jd56EAYNT5ZeU0V56NDyiID2gq9bzeCM5mnQwkbllq
	 s/rebnucJjPNQ==
Date: Thu, 9 Jul 2026 00:17:33 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 17/21] perf annotate-arm64: Support 'mov' instruction
 tracking
Message-ID: <ak9LDT7NL2bWTkdv@z2>
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
 <20260701035355.752944-18-wutengda@huaweicloud.com>
 <20260701042109.565541F000E9@smtp.kernel.org>
 <7cd2afbf-51a6-4c47-8212-87fba14876ce@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7cd2afbf-51a6-4c47-8212-87fba14876ce@huaweicloud.com>

On Wed, Jul 01, 2026 at 04:46:02PM +0800, Tengda Wu wrote:
> 
> 
> On 2026/7/1 12:21, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [Medium] Type state corruption due to DWARF register overloading for the stack pointer (`sp`) and zero registers (`xzr`/`wzr`).
> > --
> > 
> > commit 8b77f0fe5f1ec7e9d14eee63f44f48d6c55f7234
> > Author: Tengda Wu <wutengda@huaweicloud.com>
> > 
> > perf annotate-arm64: Support 'mov' instruction tracking
> > 
> > This commit extends update_insn_state() for arm64 to track register-to-register
> > and immediate-to-register 'mov' instructions. It propagates data type
> > information or immediate values to the destination register to improve type
> > inference.
> > 
> >> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
> >> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> >> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> > 
> > [ ... ]
> > 
> >> +static void update_mov_insn_state(struct type_state *state,
> >> +				  struct disasm_line *dl,
> >> +				  struct annotated_op_loc *src,
> >> +				  struct annotated_op_loc *dst)
> >> +{
> > 
> > [ ... ]
> > 
> >> +	if (!has_reg_type(state, sreg) || !state->regs[sreg].ok) {
> >> +		invalidate_reg_state(tsr);
> >> +		return;
> >> +	}
> >> +
> >> +	tsr->type = state->regs[sreg].type;
> > 
> > [Severity: Medium]
> > Will this code corrupt the stack pointer's type state if the zero register
> > (xzr or wzr) is used in a mov instruction?
> > 
> > Looking at tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c, the function
> > __get_dwarf_regnum_arm64() maps sp, wzr, and xzr all to DWARF register 31:
> > 
> >     if (!strcmp(name, "sp") || !strcmp(name, "wzr") || !strcmp(name, "xzr"))
> >         return 31;
> > 
> > If a zero register is used as a destination (e.g., mov xzr, x0), does its
> > tracked state overwrite the tracked state of the stack pointer?
> > 
> > Conversely, if a zero register is used as a source (e.g., mov x0, xzr),
> > does the destination register incorrectly inherit the type of the stack
> > pointer instead of being treated as a constant 0?
> > 
> 
> I'll drop wzr/xzr register support to avoid this confusion.
 
Yep, that'd be right.

But I'm curious how we interpret 'mov x0, xzr' when x0 has a pointer
type.  Maybe intention of the source code is to initialize the pointer
to NULL, but this function may set it to const 0 and drop the type info.

Thanks,
Namhyung

