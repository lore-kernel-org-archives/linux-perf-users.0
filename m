Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B710361969;
	Mon, 28 Sep 2026 13:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790603208; cv=none; b=k1uyQxhxrKdh86IgQoGXvdHTSSRQSeFbGEBmrI1SBdoSvCgoBP2vDzS02ETaY/Cca2oyGtuKXqa5EXc4QGE7vqwu0t/Oc71M5ZAmbZf0s+GNMRq38F0H3KogtarYJTtZIZgXXzifoiwDIw3s4TNt94YoqUWwXth0Hx6oLOpbAdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790603208; c=relaxed/simple;
	bh=sTVxuhoSvKxNBjF/1eg2TBMulwNMhs0StMT/hGBGSHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POtBiX4C9MEIFvFvB1FqEuf55CqeZzwTPCs5Qz2Np4Rgi+sMz9vj1Mn8g6+A/ktBED55ybO15RPyC2j+lPYlJV/Tz2TvLfb8G06TLPi0lye+qTDmArzfdIbRBq5yJHWXUBjyWFlLPBcjiDPaWZbu2W9QrTtyg/2IeD2ZShbpVBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=TEvqXttS; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="TEvqXttS"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0832D1655;
	Mon, 28 Sep 2026 06:46:42 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0DC683F763;
	Mon, 28 Sep 2026 06:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790603205; bh=sTVxuhoSvKxNBjF/1eg2TBMulwNMhs0StMT/hGBGSHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TEvqXttSJhu1lMMlyftjQZaNh0zvqISl3fqIXfSCJ9XFkXJENHNngCrePikbezNyZ
	 tajrAApMn0r/TxxHeujrvKoLECy+AVG/730jfY7eWJtvqlSYa2+lrBxuARt3sKnpl2
	 LhsE7hAyHqvHJgLrBl/8+TS0YZT1V2Oa1IPSprf4=
Date: Mon, 28 Sep 2026 14:46:42 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf python: Fix arm-cs-trace-disasm type error
Message-ID: <20260928134642.GE14479@e132581.arm.com>
References: <20260928-james-perf-mypy-cs-disasm-v1-1-1bda909475ce@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928-james-perf-mypy-cs-disasm-v1-1-1bda909475ce@linaro.org>

On Mon, Sep 28, 2026 at 01:58:09PM +0100, James Clark wrote:
> The perf sample dso_bid getter returns a string or None, matching its
> Optional[str] annotation. Attempting to decode it as bytes causes mypy
> to report union-attr errors, even though this was behind a conditional
> that checked for bytes type.
> 
> Use the string directly, retaining the fallback for an unknown build ID.
> 
> This fixes the following build error:
> 
>   python/arm-cs-trace-disasm.py:266: error: Item "None" of "str | None" has no attribute "decode"  [union-attr]
> 
> Fixes: 279b402e5143 ("perf python: Port arm-cs-trace-disasm to perf module")
> Assisted-by: Codex:GPT-6-Astra
> Signed-off-by: James Clark <james.clark@linaro.org>

Thanks for the fix:

Reviewed-by: Leo Yan <leo.yan@arm.com>

Just curious, have you run this script and compare the result with old
one? Seems to me, the build pass is insufficient, we should run a small
test to ensure the result to keep same.

Thanks,
Leo
