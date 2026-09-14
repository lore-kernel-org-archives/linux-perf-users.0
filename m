Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D480D37F8DB;
	Mon, 14 Sep 2026 18:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789410579; cv=none; b=TGBcJrhr+dKNY5VENwa2gmJMaeRjw5u5UGv+evM7ug+AUQGK3VQKRC4Q+V5XtyKQ/rSNgjt57pzaaGJgn4TsWYXBxuAtLe5AitZ9BUya84YDSGm0ulxXaHG3rZGGySkVRkNKDo2HStaAkgpbxiKvppicHefT2LTW7K3qOfDyBfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789410579; c=relaxed/simple;
	bh=pj4qmB9ljnZQOtKncfDQ6cDshIDKeqBUyrovGUmVeXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2cXTiU8Y4M9TtFU/Ibp2xmNKKkIeVTVwG6bFSANy/nYR6MZQyJjzgFiwovBH5LcgtjVuIrcBNNt6EJ+J4K5aiuVqeo/A3pYEeSeV5Z2WFLkLi9Vb8fOs0Xyo7BT1i6HtqN1mAe3xmpVIJfel2YMQv8Z6P2w1FFTKl/0Xstrkeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkhF2Mak; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkhF2Mak"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD94C1F000FF;
	Mon, 14 Sep 2026 18:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789410577;
	bh=uYl4DuQg7GEyWsAsWUx39SCZDduudy9YEJWobZDmAmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EkhF2MakXAMxcRVFIc7FDkJqCUb3Q8+gPO8j1qtG+kn+ig3U9wOIpDX2q+hUUx+r+
	 1zIhTuHmTfG3+nO7Cptgs5DgsfaJ8LgrCMAj1mH9UZH1fkSlJMuJoi/7EmA91pIRmx
	 4d/AMpio57C7ckipwKG070PgWrXQ9K9dhVCnr1i6JCj7S4Zy1N8YlhaiLSRTsHrFP4
	 5iZjX/tVQ32QSC/8TzYpFhE77WEeOvTG7XzeXb38dgfSNAvm2b6S5Im/0ESYbnrwWH
	 t6Ecu5fsCmdN1NBHK1jbuKRe0XRSWtnsO1yB7SeMlcpr1TBXU2U4AYNrHUYWsaMyGI
	 o/OlaSR0WvQ0Q==
Date: Mon, 14 Sep 2026 15:29:33 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
Subject: Re: [Patch v11 07/10] perf regs: Enable dumping of SIMD registers
Message-ID: <aqg9DV05lxzLKu0t@x2>
References: <20260914014049.2061519-1-dapeng1.mi@linux.intel.com>
 <20260914014049.2061519-8-dapeng1.mi@linux.intel.com>
 <20260914020418.97E881F000FF@smtp.kernel.org>
 <1870044f-ab4c-4906-8f8b-c3216fb28211@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1870044f-ab4c-4906-8f8b-c3216fb28211@linux.intel.com>

On Mon, Sep 14, 2026 at 01:17:00PM +0800, Mi, Dapeng wrote:
> 
> On 9/14/2026 10:04 AM, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [Low] Missing explicit `<stdio.h>` inclusion for `printf` usage, which can cause musl build failures.
> > --
> >
> > commit a307c3e7165562ef96094cdee1fc722a99865e02
> > Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
> >
> > perf regs: Enable dumping of SIMD registers
> >
> > This commit adds support for dumping SIMD registers with the new
> > PERF_SAMPLE_REGS_ABI_SIMD ABI. It currently supports XMM, YMM, ZMM,
> > OPMASK, eGPRs, and SSP registers on x86 platforms.
> >
> >> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> >> index 90d4e45f09f08..a5b596cd14be6 100644
> >> --- a/tools/perf/util/session.c
> >> +++ b/tools/perf/util/session.c
> >> @@ -1446,6 +1446,86 @@ static void regs_dump__printf(u64 mask, struct regs_dump *regs,
> >>  	}
> >>  }
> >>  
> >> +static void simd_regs_dump__printf(uint16_t e_machine, struct regs_dump *regs, bool intr)
> >> +{
> >> +	const char *name = "unknown";
> >> +	const char *simd_header;
> >> +	u32 i, j, idx, pred_base;
> >> +	uint16_t qwords;
> >> +	int reg_c;
> >> +
> >> +	if (!(regs->abi & PERF_SAMPLE_REGS_ABI_SIMD))
> >> +		return;
> >> +
> >> +	if (!regs->nr_vectors && !regs->nr_pred)
> >> +		return;
> >> +
> >> +	simd_header = "... SIMD ABI nr_vectors %" PRIu64 " vector_qwords %" PRIu64 \
> >> +		      " nr_pred %" PRIu64 "  pred_qwords %" PRIu64 "\n";
> >> +	printf(simd_header, regs->nr_vectors, regs->vector_qwords,
> >> +	       regs->nr_pred, regs->pred_qwords);
> > [Severity: Low]
> > Does this file need an explicit inclusion of <stdio.h>?
> >
> > The perf tool can be compiled with musl libc, which enforces strict POSIX
> > namespace separation and does not implicitly include headers. Relying on
> > implicit header inclusion for printf() can cause build failures under musl.
> 
> Ok, this can be fixed in a separate patch later.

Ok, merging it now, later you send fixes for these minor issues.

Thanks,

- Arnaldo
