Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376321C4A24;
	Wed, 22 Oct 2025 00:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761093558; cv=none; b=Piw4EtnTuo5ZOD9zUhPq/0iOgbHq23nSW5jjTKdFuyzRvNqjJlABZ+xawD0CljI96Be6hUDXZwD9r81A9K6WK5J7Oiw/fwj1gfbdcIxYL+92jbMBPoiHVQXKOG/ha5PGN4q83JLAseQ7CCslnS+mrWnCpnnzpzPox4pf/1zpglI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761093558; c=relaxed/simple;
	bh=tUtAJYcu718g9kcKB6ppq+zP6sGH+i+ouEiFkgFgBlg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CV23oJbyO0KUyJ074+5aZ7KeAAYiIgCpRMh4XmDdwOY24SVqvWJ5LvBMO68L2lrRibj1Z2DpqDnsdESkKKUflOmH3s2b5oePAYjcAUX3gfJy83Ssy/mqQhirCaw5WxwOWXL1feahKvnRXq74pU2YX/JNtxWsksjmcOUeMvHbAk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYg9FRyT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYg9FRyT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419F1C4CEFF;
	Wed, 22 Oct 2025 00:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761093557;
	bh=tUtAJYcu718g9kcKB6ppq+zP6sGH+i+ouEiFkgFgBlg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pYg9FRyTMjST8mVEXMcfNGlkINg2qzASwY29nhBp0EG3aqSJ9urim9ZdOjRsadQFu
	 aCasrFWz1hAdh79dXq0B6ai08QfNfSCRIIMQ+KZIA+xpUDZJ0BgakFN7q6KIavssJb
	 ICNrBMkdv6bm3lEEi/ZF11H5XWSze/RgEfIKmaTz/+/VE5vo9+upnwzV6UZW2FQ19T
	 Rqy8AGgAMCd7mFl4VcwSxsv232u67IxrxyqGACQnkMww4/tY+rvuOyvivAwn2FeCAa
	 2mmjMsImUncvwg0zQdds1bboePS2ermiS6K7XxI9LRy6xzMoT56QuP8LU3Jcv5WFbH
	 opMHgpXpHlTxA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
 James Clark <james.clark@linaro.org>, Tianyou Li <tianyou.li@intel.com>
In-Reply-To: <20251021030750.254186-1-namhyung@kernel.org>
References: <20251021030750.254186-1-namhyung@kernel.org>
Subject: Re: [PATCH] perf annotate: Fix build with NO_SLANG=1
Message-Id: <176109355722.1850903.12007508719780031483.b4-ty@kernel.org>
Date: Tue, 21 Oct 2025 17:39:17 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 21 Oct 2025 12:07:50 +0900, Namhyung Kim wrote:
> The recent change for perf c2c annotate broke build without slang
> support like below.
> 
>   builtin-annotate.c: In function 'hists__find_annotations':
>   builtin-annotate.c:522:73: error: 'NO_ADDR' undeclared (first use in this function); did you mean 'NR_ADDR'?
>     522 |                         key = hist_entry__tui_annotate(he, evsel, NULL, NO_ADDR);
>         |                                                                         ^~~~~~~
>         |                                                                         NR_ADDR
>   builtin-annotate.c:522:73: note: each undeclared identifier is reported only once for each function it appears in
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


