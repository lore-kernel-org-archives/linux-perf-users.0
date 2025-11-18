Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4533122083;
	Tue, 18 Nov 2025 01:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763429737; cv=none; b=c/oY6c38IBYr31oGcKkosGMk0ulMxxw5O5oExYe9wrO0gBSYk9oT16DAwZXWx3CwAWrHkfEglup+8i/SyfkqCTpa52tOe+OTp4nNYwry1U/GcOZL6iJpPwNM7Vqdk/AMruU0ZGqeQ2oj2Vk2LTaPzz4X7qdmBYsV+PZWi9M3BOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763429737; c=relaxed/simple;
	bh=c7gKWRY9eqcVKgdwR39LD/tAz1KGGtZyyTvacFyJewM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VK7dLe4rYXKy9B71sUe7GZFMPPnCa+so0DY9v7tdUf7NQsZCPgOXMmdL7KYbp30B2WQLnPGnjS8wJRjZMG+htsz88Rg7993D0ZfQREROawO/u6zsxWFiKV+P4DNSX/wD9SLWr/JsfFxyRbMU69K5jt6xr8dhExmEmJ4iYawI+3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4Ka2hK0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4Ka2hK0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A42CC4CEF5;
	Tue, 18 Nov 2025 01:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763429735;
	bh=c7gKWRY9eqcVKgdwR39LD/tAz1KGGtZyyTvacFyJewM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=O4Ka2hK0A9htu0tM6WdrsJ/E7g2Orbtb2w5mz7zPTgJ/sWtJPxUMiO6LSeivoI5Ia
	 nNQfwDjPgD9v5/6hKkpygZUUSKcs2x/TcqPMHHW96Bc6QvcIGmqwgMKk0SyOsUt7pc
	 EUfRUyd5VAzpRKgcDqEJHauFWUOayH+vI3j2vlUBQZsaJ3uoM6jpFFQSBVl5jXxJLg
	 hx5kogYWtpF4EXcQBncpnixGpINhehOa3Ru9fl4wGLlOQ0o9qttpKdGxQElcAv1zQv
	 yI6PS2yH1sxD2ecPNRXrVGkoUqW/0evVNlBCNnzFCMOPx/aYp+EFsaYpVJQHzz7EBM
	 gQIwPrhUIL1Hw==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org, irogers@google.com, acme@kernel.org, 
 James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251114140618.229205-1-james.clark@linaro.org>
References: <20251114140618.229205-1-james.clark@linaro.org>
Subject: Re: [PATCH] perf script: Fix build by removing unused
 evsel_script()
Message-Id: <176342973426.1348495.14794216773513267179.b4-ty@kernel.org>
Date: Mon, 17 Nov 2025 17:35:34 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 14 Nov 2025 14:06:18 +0000, James Clark wrote:
> The evsel_script() function is unused since the linked commit. Fix the
> build by removing it.
> 
> Fixes the following compilation error:
> 
>   static inline struct evsel_script *evsel_script(struct evsel *evsel)
>                                      ^
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


