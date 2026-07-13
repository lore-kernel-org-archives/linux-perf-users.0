Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E6234DB74;
	Mon, 13 Jul 2026 20:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783974809; cv=none; b=QiSOUZUtkKOSGwcas9w10xvyvHLW/z3Jd5PyAi97nzVhZnPoBV+2YNBWN7nMjkScu1EoteecjAOcy/TbP/HpQDgHM3j4TRZHuyU7d6oZ0f8rULTOGbM+eWYzwfRr6JcVixart1TDVR40wCO+QuIF4RVK2dRrd8hGNxsxPDRdmc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783974809; c=relaxed/simple;
	bh=BzXnWYycZtrsC4eYp80TBiwS/8l9vkPcVQHMfEwIaHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YrVF1NO5lRK9+8mhfU1d3GmGNhE1uwkmDl/0d9sn0UUQ9HWdlfbx3uk8pNM/NXSH9qIl2xGvKh7f7fVx3im6KxGW+m3lzKy1CqcBwwCDJU5pDJcII/hlGdq0s3bwHvjdo91a63cObXOJJl5mkXbCJvqo3lP0WugN1LHK7nI9i10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+njEd0h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+njEd0h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBBFA1F00A3A;
	Mon, 13 Jul 2026 20:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783974807;
	bh=cRkPSO91bFeK9182PS7Iusjus+5qu8ApU8Ds9AgNKO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J+njEd0hPiFuXkUjQ/5/i4upvCIBDFBxs5vg2NHF4FYvEtDBeJ2cQFRJ6WMOdltt3
	 bhGNcW0smNWjC0n74L8kCC2kRofEcyhYc2Kr8xwHYfivqAtpQfQDLdjjVDjxBbkKGR
	 Jpg/eoQXMiuhQnn60IG1UvMB6h3h+qAADqWo9xTtEkZX5mQRMm1HdgrgPNRkjaLxgm
	 e3yK6LKKTrHFnHzComDtHn57rf6bbj2AE7FoF4OuARZ/Ax3TeR5K8+u8JIr34Em2Al
	 A6HZOHiqshYEF5LoGvbAxzzufWMf4qVkrQgFkoXWPA60x+zKUrO9GEuhdLxe8QWoqA
	 DIzyfOj+yZhGQ==
Date: Mon, 13 Jul 2026 13:33:26 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Trevor Allison <tallison@redhat.com>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 3/3] perf x86: Add .note.gnu.property to assembly linked
 into perf
Message-ID: <alVLlpmtps__MBCl@google.com>
References: <20260708045606.43649-1-tallison@redhat.com>
 <20260708045606.43649-4-tallison@redhat.com>
 <20260708050839.BD9491F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260708050839.BD9491F000E9@smtp.kernel.org>

Hello,

On Wed, Jul 08, 2026 at 05:08:39AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] Adding .note.gnu.property asserts IBT support without providing ENDBR64 instructions, causing a #CP crash in perf memory benchmarks.
> - [Medium] The .note.gnu.property section hardcodes 8-byte alignment, violating the 32-bit x86 ELF specification.
> --

Can you please take a look and address the both comments?

Thanks,
Namhyung

> 
> --- Patch [3]: [PATCH 3/3] perf x86: Add .note.gnu.property to assembly linked into perf ---
> commit b48d7edb7fb18bc3dace2af272de108eb561d69b
> Author: Trevor Allison <tallison@redhat.com>
> 
> perf x86: Add .note.gnu.property to assembly linked into perf
> 
> This commit adds `.note.gnu.property` to x86 assembly files linked into
> perf to indicate CET properties support. This is intended to prevent static
> linking from dropping CET from the final binary.
> 
> > diff --git a/tools/perf/arch/x86/tests/regs_load.S b/tools/perf/arch/x86/tests/regs_load.S
> > index 80f14f52e3f60..1947f95cceda5 100644
> > --- a/tools/perf/arch/x86/tests/regs_load.S
> > +++ b/tools/perf/arch/x86/tests/regs_load.S
> [ ... ]
> > @@ -97,3 +97,27 @@ SYM_FUNC_END(perf_regs_load)
> >   * the ELF stack should not be restricted at all and set it RWX.
> >   */
> >  .section .note.GNU-stack,"",@progbits
> > +
> > +/*
> > + * We need to provide .note.gnu.property section with IBT and SHSTK,
> > + * saying that this object supports the same CET properties as C code
> > + * built with -fcf-protection. Otherwise static linking drops CET from
> > + * the final perf binary when other objects are CET-enabled.
> > + */
> > +	.pushsection .note.gnu.property, "a"
> > +	.p2align 3
> 
> [Severity: Medium]
> Does this unconditionally hardcode 8-byte alignment for 32-bit x86 builds?
> 
> The assembly file `regs_load.S` can be compiled for 32-bit x86, which requires
> 4-byte alignment (`.p2align 2`) for ELF notes. When the linker merges these,
> the forced 8-byte alignment can create zero-byte padding gaps between notes,
> corrupting the contiguous ELF note structure.
> 
> Could this cause the dynamic loader or tools like `readelf` to fail to parse
> the ELF notes properly?
> 
> [ ... ]
> > diff --git a/tools/perf/bench/mem-memcpy-x86-64-asm.S b/tools/perf/bench/mem-memcpy-x86-64-asm.S
> > index 1b9fef7efcdcc..e7b84aa43ab44 100644
> > --- a/tools/perf/bench/mem-memcpy-x86-64-asm.S
> > +++ b/tools/perf/bench/mem-memcpy-x86-64-asm.S
> [ ... ]
> > @@ -18,3 +18,27 @@
> >   * the ELF stack should not be restricted at all and set it RWX.
> >   */
> >  .section .note.GNU-stack,"",@progbits
> > +
> > +/*
> > + * We need to provide .note.gnu.property section with IBT and SHSTK,
> > + * saying that this object supports the same CET properties as C code
> > + * built with -fcf-protection. Otherwise static linking drops CET from
> > + * the final perf binary when other objects are CET-enabled.
> > + */
> > +	.pushsection .note.gnu.property, "a"
> > +	.p2align 3
> 
> [Severity: Medium]
> Will this cause a Control Protection Exception (#CP) crash on IBT-capable
> hardware when running `perf bench mem memcpy`?
> 
> Adding this section artificially claims IBT support and forces the linker to
> enable CET on the final `perf` binary. However, `perf`'s local linkage headers
> do not automatically emit `endbr64` instructions for `SYM_FUNC_START`.
> 
> When `do_memcpy()` in `tools/perf/bench/mem-functions.c` indirectly calls
> these assembly entry points like `memcpy_orig`:
> 
> 	fn(dst, src, size);
> 
> the hardware may detect the missing `endbr64` on the indirect branch target
> and throw a #CP fault.
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260708045606.43649-1-tallison@redhat.com?part=3
