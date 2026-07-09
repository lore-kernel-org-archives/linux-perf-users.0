Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839CA3D0BFB;
	Thu,  9 Jul 2026 06:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783578679; cv=none; b=K9sdHOLe/OBg8c2SebCh1jRZQTVS753HtmD97hcOJDGQB/e9PqPWiJk2q6lWHMdSEohB+ZhUoHaU/FOZx+yOBwjoX+GYzGCPU7aU1rIJ/Zi0Z0yp7K1UrGQWbbPLlovIhGh0FZM6sVJBYvZBYZhFm2bslbO2gf/g+3SXdFG8LAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783578679; c=relaxed/simple;
	bh=lLkL0NxPUHqBmph0qy84Ge/mM4CGIqnRoPdohQhSn4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJVnTHW3CaujcvsvbTUjLfheUQA6unxxJgFQicrZ4u3CLRMyOG5h0iJ4HMSExmzJbxqvGOQeYzKo9NfiDOe8KV1kDXlcs/5cvAqTlnltlCBbGEf0lk9FqUMimSHEarzA2VPlD4ZFaOOmXAjRsnouZ1lJrlPv0fFfI22pKdzcncg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fL6A9Rbz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fL6A9Rbz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E13C1F000E9;
	Thu,  9 Jul 2026 06:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783578678;
	bh=KVJwuhlHvCDuJa9PR+rRLEyjKK5uhjQqGp5xXlj+GkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fL6A9Rbzu3JEZwyXs34vfUKAlZmFQJXUZzmQyAN1bvih6rgLhP2GdEEYQDuvb5Yrk
	 CwCGB9jq/hUqQjsavNftVviCVNEcoMD42EjOKyb/rZn9zsDlyWe6de6ExZ7tM8uic7
	 w+VO8pb6ij39dnMjuoeAjHDsCtdVdY/8+O9n5Tl9WVEUSJ3w3L0AeLyESLIGB+wRcz
	 1FlBJU/egGh+65IcDm+NiR6bIkYamGGJscijz+DIamqwJ1W18u2UUJi9Ig1jB7gYYm
	 ftG7OJCDplcf4SUNfgfoqfmvSByo0HKpVhhAV94L+vsjAxg6R9GlcbsIdKUzVEw8zm
	 p0T/SlprOhPIw==
Date: Wed, 8 Jul 2026 23:31:16 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 08/21] perf annotate: Introduce extract_op_location
 callback for arch-specific parsing
Message-ID: <ak9ANIuZLqWvAJWa@z2>
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
 <20260701035355.752944-9-wutengda@huaweicloud.com>
 <20260701040647.A23771F00A3A@smtp.kernel.org>
 <2da387b1-ff15-4d7a-9cfe-062a9aa55368@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2da387b1-ff15-4d7a-9cfe-062a9aa55368@huaweicloud.com>

On Wed, Jul 01, 2026 at 03:29:57PM +0800, Tengda Wu wrote:
> 
> 
> On 2026/7/1 12:06, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> > - [Medium] Refactoring changes the error propagation behavior for memory operands with unrecognized registers, causing valid instructions to be incorrectly marked as bad.
> > - [Low] Missing explicit inclusion of `<stdlib.h>` for the POSIX libc function `strtol()`, breaking musl compatibility.
> > --
> > 
> > commit a79e03a1004b442317df26b7478d0a1daed1e563
> > Author: Tengda Wu <wutengda@huaweicloud.com>
> > 
> > perf annotate: Introduce extract_op_location callback for arch-specific parsing
> > 
> > This patch refactors operand parsing by moving it from the central
> > annotate_get_insn_location() into architecture-specific callbacks. By
> > introducing extract_op_location callbacks for PowerPC and x86, it aims to
> > simplify the core logic and improve maintainability without making functional
> > changes.
> > 
> >> diff --git a/tools/perf/util/annotate-arch/annotate-x86.c b/tools/perf/util/annotate-arch/annotate-x86.c
> >> index 7e61365363938..6a4b4bdcd7a7c 100644
> >> --- a/tools/perf/util/annotate-arch/annotate-x86.c
> >> +++ b/tools/perf/util/annotate-arch/annotate-x86.c
> >> @@ -2,6 +2,7 @@
> >>  #include <string.h>
> >>  #include <linux/compiler.h>
> >>  #include <linux/zalloc.h>
> >> +#include <linux/ctype.h>
> >>  #include <assert.h>
> >>  #include <inttypes.h>
> >>  #include "../annotate-data.h"
> > 
> > [Severity: Low]
> > Does this file need an explicit include of <stdlib.h> for musl libc
> > compatibility?
> > 
> > It appears strtol() is used later in extract_op_location_x86() without
> > the required <stdlib.h> header being directly included here, which might
> > lead to implicit function declaration errors on musl-based systems.
> > 
> 
> Agreed.
> 
> > [ ... ]
> > 
> >> @@ -809,6 +810,86 @@ static void update_insn_state_x86(struct type_state *state,
> >>  }
> >>  #endif
> >>  
> >> +/*
> >> + * Get register number and access offset from the given instruction.
> >> + * It assumes AT&T x86 asm format like OFFSET(REG).  Maybe it needs
> >> + * to revisit the format when it handles different architecture.
> >> + * Fills @reg and @offset when return 0.
> >> + */
> >> +static int extract_reg_offset(const struct arch *arch, const char *str,
> >> +			      struct annotated_op_loc *op_loc)
> >> +{
> > 
> > [ ... ]
> > 
> >> +static int extract_op_location_x86(const struct arch *arch,
> >> +				   struct disasm_line *dl __maybe_unused,
> >> +				   const char *op_str, int op_idx __maybe_unused,
> >> +				   struct annotated_op_loc *op_loc)
> >> +{
> >> +	const char *s = op_str;
> >> +	char *p = NULL;
> >> +
> >> +	if (op_str == NULL)
> >> +		return 0;
> >> +
> >> +	if (strchr(op_str, arch->objdump.memory_ref_char)) {
> >> +		op_loc->mem_ref = true;
> >> +		return extract_reg_offset(arch, op_str, op_loc);
> > 
> > [Severity: Medium]
> > Does returning the result of extract_reg_offset() here alter the error
> > propagation behavior?
> > 
> > In the previous annotate_get_insn_location() logic, the return value of
> > extract_reg_offset() was safely ignored:
> > 
> >         } else if (strchr(insn_str, arch->objdump.memory_ref_char)) {
> >                 op_loc->mem_ref = true;
> >                 op_loc->multi_regs = multi_regs;
> >                 extract_reg_offset(arch, insn_str, op_loc);
> >         } else {
> > 
> > By returning it here, extract_op_location_x86() might return -1 if the
> > register is unrecognized. This regression is now propagated back to the
> > caller in annotate_get_insn_location():
> > 
> >         if (arch->extract_op_location) {
> >                 ret = arch->extract_op_location(arch, dl, insn_str, i, op_loc);
> >                 if (ret)
> >                         return ret;
> >         }
> > 
> > Could this cause valid instructions to be completely skipped and
> > incorrectly marked as bad?
> > 
> 
> I don't think this is a problem. If we don't return an error here,
> extract_reg_offset() would continue with an uninitialized or invalid
> offset, which would then cause update_insn_state() to make incorrect
> judgments. Returning -1 and marking it as bad is actually safer than
> silently propagating wrong information.

I agree.  I'm not sure if there's actual case it fails there, but I
prefer not to process when it failed.

Thanks,
Namhyung

