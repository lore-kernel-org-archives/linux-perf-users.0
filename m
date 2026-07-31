Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6003733939E;
	Fri, 31 Jul 2026 02:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785465843; cv=none; b=jINEVNTfGUDQh8F+d4YbHl3W/bKmze7dt/hFRmMA2QA5U15WHQMsF4b1524C3sPhYV4Ted/mlQwWWycaL1FzXGsM3dOG7/czoEEvCBv7H5Yd01dhwewzea01mHgJmzu09ODE6breHKxGfLfZG2evhViuS6okpH0ykKk7gfX+tyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785465843; c=relaxed/simple;
	bh=CpWe4DNXgDUHIJavIejFCbOQ37fSck9AS1zt9eQ8XDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVtzhhAtQFa85zDB5meP5p+xzRI/Yro3H0/DE0j388jSFEA89HZ6gv4gi2aN3BgV+48JXf3ntQ5FAxljqtv9z+px3XPBc/CUfvIN7sDJVqM3btwncJGO62qh6/DmzNqTQQAoQrBdTpFWK/cLPVvkquCzn5g8qL2wD3tql3m1l98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mt92lSl3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mt92lSl3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56BB31F00A3A;
	Fri, 31 Jul 2026 02:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785465842;
	bh=NSU0VQsd1sbkkQATX+6i4OyR/+z4T/0Gk2puGlmOTac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Mt92lSl3FZqg/V/6rK7WFrlpUU+Py4v+6XNbS7uoYa5eTF4xTgNCP0Q3+iJwxLcCY
	 9/xL2B/QyhCMDRyf3MER0kxJkFDV8bqdKT/T32luv4YCyi68NaPggCNH0iviT94BpC
	 UBeoQTAyEifREfXaFPfwZ6eTBHzgVvO/cKEAGIo+EcO4snze+VDpoWWK3723YIv2A9
	 A6hNHgm8s7Y+RVDA/AAeC44yh/sy9irn+vFpUMj83/USJjaDvPGSkeyxrR05T1oIks
	 k+Ftl5YXF1v00Y1fAlKT87godIqhuUVx8AWszLz18Pc1wSE9RPO4/PQcfTdj5zmfbr
	 ACKbnnKauhoBA==
Date: Thu, 30 Jul 2026 19:43:59 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Jiebin Sun <jiebin.sun@intel.com>
Cc: acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
	adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
	irogers@google.com, james.clark@linaro.org, jolsa@kernel.org,
	mark.rutland@arm.com, dapeng1.mi@linux.intel.com,
	thomas.falcon@intel.com, tianyou.li@intel.com,
	wangyang.guo@intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/9] perf c2c: add a function view
Message-ID: <amwL794Mj0O3vOkr@google.com>
References: <amjxS3hcWlvQHerx@google.com>
 <20260730090901.2216672-1-jiebin.sun@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260730090901.2216672-1-jiebin.sun@intel.com>

On Thu, Jul 30, 2026 at 05:09:01PM +0800, Jiebin Sun wrote:
> On Tue, Jul 28, 2026 at 11:13:31AM -0700, Namhyung Kim wrote:
> > Thanks for the update, I think it's almost ready to merge.  But can you
> > please address some sashiko review comments?
> 
> Thanks for the review. I went through the sashiko comments and prepared
> v5, rebased onto perf-tools-next at 0d40fedcd1b9. The full change list is
> in the cover letter. The view layout is unchanged, and the changes address
> correctness, robustness, and style, along with some adjustments to which
> entries are retained.
> 
> A few comments did not require code changes:
> 
>   - The ms/thread reference handling is deliberate. Child entries borrow
>     references from the cacheline-side entries, which outlive the function
>     hierarchy. Their custom destructor does not put those references, so
>     adding get() calls would leak them.

Is it possible to add proper refcounts instead of borrowing?  I guess
that'd make the code simpler.

Thanks,
Namhyung

> 
>   - c2c.h directly includes <linux/types.h> and <stdbool.h>, while
>     <linux/compiler.h> is provided through <asm/bug.h> and <linux/list.h>.
> 
>   - The level-3 cacheline address is not truncated. The symbol-column width
>     is expanded to fit the deepest identity cell before the browser is
>     created.
> 
> Tested with and without SLANG support; `perf test c2c` passes, and the
> cacheline `--stdio` output is unchanged from the base commit.
> 
> Thanks,
> Jiebin
