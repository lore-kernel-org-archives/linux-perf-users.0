Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92CA14A8B;
	Sat,  8 Mar 2025 18:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741458256; cv=none; b=gQZh5GeKrt7muWCnQ7LGXQ6FYOcbO6MeBqlQnKPIyQL0/DcZEJIjcv/vXkuOBkMrFn9SLOZiwQ5pJn3M22hvEQOpYcLW6fpFR1Kui2GZDTJmRIl+ROCjDw8BqLYM/UUC90KZ6yZHSuUZPb06tq12oR+z8vxX1YeZ+7OWNC4wtsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741458256; c=relaxed/simple;
	bh=HmE/hRyVKN2DG0Sf/V/9Vwm/F9OWdq8i2cOoz8+anVg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ctcddhwFPjmyzT0DXC2ChX9eFfE7gZNxC9mArh5NY8cJeuBxmr8BuOaVQIWqPW4sZqhQdfTnlWJ3LqqbXjyeNH7M973qFizpWRsZ6PJpwxc5PjOx44F+vU4rSjbVdN09nIE1ADXa8FlCZjRVPYVGmA75JXAEdqLA/63KLuX2EqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUt4Q/V9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUt4Q/V9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC6DC4CEE0;
	Sat,  8 Mar 2025 18:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741458256;
	bh=HmE/hRyVKN2DG0Sf/V/9Vwm/F9OWdq8i2cOoz8+anVg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CUt4Q/V920Jvn4UNmZynM1FCFmokjCQ2OZULVGzfe54yOdqMK8vG/Qdo5pshaVPme
	 cxbG05obIKWKBfYf9wxXZreknJJUVRWzWYyJG62a5zG38cA4BlBno8RzWybOTjNElp
	 Q1eD9rDYohBfPd+gWmS+CxMf30KV2plLW6pSC6GKfApPq8IZmkrpDCjb8x+CgwkbxR
	 CSvyEbw1pRgUjK3ceE+tIQet9XsWebRUzBs+Ue6dLLaGhw1M/kAdzfe9ghrvefMFeo
	 cExZZKr+OmVkBAy3Mg/1Y4K+HMkJl2CZ0d91qvDirDRJ8u0aRQhkJQHLar0yLet3H6
	 SJXy+18b+QjWg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
In-Reply-To: <20250307061250.320849-1-namhyung@kernel.org>
References: <20250307061250.320849-1-namhyung@kernel.org>
Subject: Re: [PATCH v2 1/2] perf report: Use map_symbol__copy() when
 copying callchians
Message-Id: <174145825574.807676.8614250136270461800.b4-ty@kernel.org>
Date: Sat, 08 Mar 2025 10:24:15 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 06 Mar 2025 22:12:49 -0800, Namhyung Kim wrote:
> It seems there are places to miss updating refcount of maps.
> Let's use map_symbol__copy() helper to properly copy them with
> refcounts updated.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


