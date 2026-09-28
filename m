Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67784D6C5D;
	Mon, 28 Sep 2026 16:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612951; cv=none; b=lcD/00mPvGdBW94HW7MptNTW3VqgK2qS6/vyz/r2kqSDZ6LOxKZ3+aBiE9cR2gtGIfgUfsNgcAmaEWWbf4h26BrkwpctjS8iKLVq9xSLjM8CmH6VUfdqZpDNErxuKWTgpBSvyWDMcfPWiztp2eeGykcQ9tozEkW1xePLGHN7qsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612951; c=relaxed/simple;
	bh=vIX3dY8N8v+gwA4XFSadrzG1QlcuIYUajuGr1tjux4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ksw72KirtpN+5dG+mA0sOwFsXLq5El0C64EQbgCJdgzD+yZ+z6JRWRw/WTbBZoz9OBYDM3VmKcQuCJNegQhmXk6UkmDjji5V5ujOhPuiLKqT7MrdJ8zhMc7LOGEsniH/KJS0/KMyVmzKLPBqyIpuNZlIDg1/oVByUIJmDmmQfwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JlvQEKSx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JlvQEKSx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB511F00893;
	Mon, 28 Sep 2026 16:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790612949;
	bh=/im+pGN7Pp/cTSdLeQKeqRThm1FYHfj1MnbESwMq4Fc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JlvQEKSxblYJb/NSPE4U+oh0M7PCQAMGyMYhRDjkYEwB1wnAi7/xZ7EhYasGGzBCC
	 nodsr6U9i6oM6SELrDAfDUxBEDxFQiSDysUCkyI2ubDtX5VrA9sggtYU9sPag1qQQn
	 HYZLooMYVFJA2eub9KpeOCKDdw1A86D3qBIETslKNy+0N3xpqhBosOSaFsz6fHQOVL
	 vF/OdA6Bp9+1517l8KoXpfbbpkEkHV7R6a6+tWv3I9Wy0mzuCzrRxuzBeWx4cSqMFn
	 8Uw2BjXRog+AdQIdFJMIGDfVcRb1ls0FMaae+FJEmH/2Qdtjrqs6pyhV8PDpBVFtU/
	 2O45fwoU2B7Eg==
Date: Mon, 28 Sep 2026 18:29:05 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Leo Yan <leo.yan@arm.com>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf python: Fix arm-cs-trace-disasm type error
Message-ID: <arqV0VTyWKlANPQ6@x2>
References: <20260928-james-perf-mypy-cs-disasm-v1-1-1bda909475ce@linaro.org>
 <20260928134642.GE14479@e132581.arm.com>
 <79e7cb39-b4af-4ac9-b72b-b01872603cff@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79e7cb39-b4af-4ac9-b72b-b01872603cff@linaro.org>

On Mon, Sep 28, 2026 at 02:52:04PM +0100, James Clark wrote:
> On 28/09/2026 14:46, Leo Yan wrote:
> > On Mon, Sep 28, 2026 at 01:58:09PM +0100, James Clark wrote:
> > > The perf sample dso_bid getter returns a string or None, matching its
> > > This fixes the following build error:
> > >    python/arm-cs-trace-disasm.py:266: error: Item "None" of "str | None" has no attribute "decode"  [union-attr]
> > > Fixes: 279b402e5143 ("perf python: Port arm-cs-trace-disasm to perf module")
> > > Assisted-by: Codex:GPT-6-Astra
> > > Signed-off-by: James Clark <james.clark@linaro.org>

> > Thanks for the fix:
> > Reviewed-by: Leo Yan <leo.yan@arm.com>

> > Just curious, have you run this script and compare the result with old
> > one? Seems to me, the build pass is insufficient, we should run a small
> > test to ensure the result to keep same.
 
> Yep the test still passes. I assume the "if isinstance(sample.dso_bid,
> bytes)" part was just dead code.

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
