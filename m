Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8148145C0B;
	Sat,  4 Apr 2026 00:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775261701; cv=none; b=Ju2Kv7UryV86AJLVld4wL7pUlxFjypJIFJ/DAYCZh2hYNQe1+6nTKXuQmv6bvJ3L7rHw1oIx5r/Zn/AjpiPZ1IW368aGLmIq93gH2n/VDXhbEnp6OTuSKiK+QXTdGbNJVMpTZ1HzE4jVgf/A21q1KmqkYDc6YN/Oqt8j26cKr8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775261701; c=relaxed/simple;
	bh=wAx7K8y50k2xuQU5qG/hqR+3jhf0sV2RFAJ+evB7/2Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=j2qznLWzyOQaBRHj97/zZUCzV4Z50C4UHA1UZ8QlmwbSyMs4VCUm0ksICL8YKkhstPEnUEeoFNF1HNyGrP89wL1COk8iKzn/+pg8w93dirU7wubM7SwPxhd/1wedyT8oBnaegtWdQa0rch8VGU3wGVtYbrQLJxs0WGBGsW8elEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2mBwP4+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2mBwP4+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1DA9C4CEF7;
	Sat,  4 Apr 2026 00:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775261701;
	bh=wAx7K8y50k2xuQU5qG/hqR+3jhf0sV2RFAJ+evB7/2Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=E2mBwP4+cNX62fLabNTqgYR5IKY5s9cOMZiCgbN04bPQ+y98nWkQnNH/Rl7y9MCXp
	 kE0kbHMM5R2fDKEoIcF6tJWPOTyHNXzYc5dWr1mP17MiHsVocSEseUgx57Azcsk+Wm
	 4FCFlcFelH9oUnQ7I/h55tKPkMv6mHAQ4rZLeLilyGAp++pvee8NMLrnlrtHpOjRe1
	 7ZONt/w+4A0vDb8842cFD8H61Tnl5H1/HzFgmy9f7GkRZe8Xsmt9cpcsi0GbvSSHy6
	 i9NO7o467Hov/CBj3f42FUyqrFuGQpj2fP0kMWDwrCz13Ku3Hl5D7YA7gnh/rfol2M
	 tz/oJZvqP1jUw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260402-perf_fix_metrics_group-v2-0-1f9427a5d763@arm.com>
References: <20260402-perf_fix_metrics_group-v2-0-1f9427a5d763@arm.com>
Subject: Re: [PATCH v2 0/3] perf metricgroup: Fix segmentation fault and
 refine logs
Message-Id: <177526170066.2123878.6179314321409109019.b4-ty@kernel.org>
Date: Fri, 03 Apr 2026 17:15:00 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 02 Apr 2026 17:04:46 +0100, Leo Yan wrote:
> The first patch is to fix segmentation fault if there have syntax errors
> in metric groups.
> 
> The last two patches are to refine logs to give users clear hints for
> failures.
> 
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


