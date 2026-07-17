Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3C030F55B;
	Fri, 17 Jul 2026 17:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784310464; cv=none; b=lEQbOi6Wca5hajgvHC5rG/V9WYyzM8DRsrT1XE2yAameJAI1LHDEdmYaPXXp2kAXTJj5CPXZIHHdSYypmqxKbXB/jn6IOSmD9vvfQIA5TOqIPrZBTjDF3R9mVn/zYU/O7iTlFOadoTf0VDTH4PZQ4/aaAyO+p05PaZP6MDE+yYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784310464; c=relaxed/simple;
	bh=psf8BfNgO3ujQbOnPFpGmq2fccFAiikCWkFZslN6eFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uT7DrimRVKcrTdWxkNcZGxEETwF/ohpRRiiSwikTrWrhQVvkpW4nFf787ATM9B/WTcrS+x2OzLOkyk1fQiTAgnJWVyFs0RhqiVV7uM4VAOpU8pleXiIwh3DIBgClwF6WyUeBU8pqlukhx+jesXfmMyMS17FvSg7u4EBQgK3luRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JL0mVK23; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JL0mVK23"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B921F000E9;
	Fri, 17 Jul 2026 17:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784310462;
	bh=UKuwfoDjBSrEuq/lRYb/SjFqPggF5NRfcJ1XC+kW9Mo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JL0mVK23r+1kTX/e+TEQHJh617wr8jQDJd+0OSUwmwMupWRdl0rBApkdDD5SqmHPk
	 QBB4oYT2sz5pXVB3wmG/6sVuOlwry5ocAkSBE77Zp+KS4lVOPGQ2MFaAyd3+qk5waV
	 Qxn+b8yvtxgp67NIqIBX8hN2ILrK9qAJNLaVTV7OVAbjsKUtmWtFrPBmzU9/fSpda9
	 d+X0ba1CKUobnmKvxxSQBuntf26JAGQ5ux62Ct+SJF2VEJIxCjfYyqznzIZ7pFQ7cQ
	 xAdppG2WbGMB3s4UszCbmG+iVcG3YszuYkQgtZG/wwNTuc6TwPDCeGa3DJxjFsGrhr
	 s9tdrPDe4vWrw==
Date: Fri, 17 Jul 2026 10:47:39 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Sandipan Das <sandipan.das@amd.com>,
	Chun-Tse Shao <ctshao@google.com>,
	John Garry <john.g.garry@oracle.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nazar Kazakov <nazar.kazakov@codethink.co.uk>
Subject: Re: [PATCH v1 0/3]  perf jevents: Deterministic build fix and mypy
 cleanliness
Message-ID: <alpqu5vX8WmmkrqI@google.com>
References: <20260707034019.241762-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260707034019.241762-1-irogers@google.com>

On Mon, Jul 06, 2026 at 08:40:16PM -0700, Ian Rogers wrote:
> Nazar Kazakov reported non-deterministic builds due to the metrics
> being reordered in the jevents.py output. Fix by sorting metrics on
> more than just their name.
> 
> Checking the code with mypy showed a large range of type warnings. Fix
> by largely adding asserts that values aren't None and by adding type
> annotations.
> 
> Ian Rogers (3):
>   perf jevents: Add more components to the metric sorting order
>   perf jevents: Add python type annotations
>   perf jevents metric: Add python type annotations

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
