Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B74274659;
	Wed, 12 Nov 2025 17:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762970207; cv=none; b=jCu2uGidH6HTpyhMV1Cz2HS/mWg6PjJmGdwg8X/QQoiWPFsLey/Z/uHSNQEy2TmzwnC/p80i8Qf9npKyKesI/oxC7cZ3FdUFeYE8KNOlvT12ntUyum8AeotO2+GOamx6gDAEeZfkxY3mThfaXeYcom0DTOCphVHtEJvw5LMC4hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762970207; c=relaxed/simple;
	bh=WLzdbqZFl5YuGkf2SKzBKp8Wg6mX1kMnYgxnwsW6luU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VT5hCUYX6AyZpUUWmNCysZYFdfqyTjRAsA+nKI0KHt9BncDz7eadzFRz4T38xbdafoXOPs4z3yQyrphJgIXBPGoeLP8FywjkoR1IIJ2+qh2QUacDcs6Gk6ZMBQ/9GkL6UfP3pBJ982O+b3mPzLyE9AURowRHRvZhgupQYUP9i+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qr57mz7w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qr57mz7w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA4AC4CEF5;
	Wed, 12 Nov 2025 17:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762970205;
	bh=WLzdbqZFl5YuGkf2SKzBKp8Wg6mX1kMnYgxnwsW6luU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qr57mz7wZHR6r8BUltF4BxbJFvX6hGq6sy55UiKVJx5RLtaejjmJEZXhr/M923ohT
	 6lni+BA1p+nkGv3tWzfBOl4fGfNhOu6hh9zJpiGpUbIbEJ8GG1kZtPj0iMi1A7wEtb
	 l/u7z+Jegas0c+80wREFrnuYi1y3Qmanp2OEr368BA3adhigjVo+SowLJ4iCIRUTN7
	 OvSHDahyUvvETNS895981RZGnpzdWcI7aQWB7T2X0M37bLfZcQuVJMfMU47mSDrNXc
	 mRzrWKcWDG5QC3SC3/w+haKTlsk8Zln5P11zxGkQfWDuHosODjYUEFZ5R19zaNIlcL
	 wxamK/qfUuqjw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
 "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20251111075944.2328021-1-namhyung@kernel.org>
References: <20251111075944.2328021-1-namhyung@kernel.org>
Subject: Re: [PATCH] perf tools: Fix missing feature check for inherit +
 SAMPLE_READ
Message-Id: <176297020434.2139491.13351307150193986264.b4-ty@kernel.org>
Date: Wed, 12 Nov 2025 09:56:44 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 10 Nov 2025 23:59:44 -0800, Namhyung Kim wrote:
> It should also have PERF_SAMPLE_TID to enable inherit and PERF_SAMPLE_READ
> on recent kernels.  Not having _TID makes the feature check wrongly detect
> the inherit and _READ support.
> 
> It was reported that the following command failed due to the error in
> the missing feature check on Intel SPR machines.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


