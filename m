Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7E9EACD;
	Tue, 18 Mar 2025 18:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742320938; cv=none; b=T1T2S7gGdFFD9s5mIsIDPiBu1QpplRBiqbVxITHNsgAP8IQKrTDQMFUTomzHKO587eLL+Cwu1nshxw1yDbDQx/1tyZ7PPWbF1uVWwxWqt/0VHzCzXpxdu3rLOFkNKo6msbgZJK62nAT4QpGKrblctSaVdx6AB/pzD1v454CGOZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742320938; c=relaxed/simple;
	bh=wjs6vsTclECnstXx8XOME5Hl6++49dOy3x3tajN/WcI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=R8qPzEVExruvabP71dAeE+ISVINME7kA+FzWs0feYCs8vszjzNOPQmfl8crmUFe7TxFkdokMgn2MI2+NnvYZLvhOc5dkq93B12/DnyMaxJnBbJiIneRAEmEvJ9uulNPP4pBBMQ4Dg6bUMW7xFksIxQwFuk//BxqUUTJoDxvmrr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LU+huyz5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LU+huyz5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF070C4CEDD;
	Tue, 18 Mar 2025 18:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742320937;
	bh=wjs6vsTclECnstXx8XOME5Hl6++49dOy3x3tajN/WcI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=LU+huyz5q4ilqnOnsXZfx1o3lPLWz64FrTbQGks+ujxYQArHhAdfVyCaMvFPI/abz
	 wVGcuNTFBCu8kD8YQoSDpmgUq6MBemSa7h7LHR4rEGMRm4heLqWUNEuleUnQbtMJTn
	 j4IDZsHA1eJEMjoj4aVYUYLmUTH9k3QRYPH4FvZFgJj9EfCB6o06D0f5qfAHAHvN+m
	 HYJf04XpqTHDDpqx6WJtfXM8xslv53JS4UxChLtTm2uvOJcDspVxz5Gy2bXGFNVS1G
	 rxLFFOcNjJg6hc3YO9mx1F2SbA8d975siZr7B6f5I3HgZmsYg6pNxVsyO6QRXbrDrX
	 ziESI7x+1tGcA==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, Yunseong Kim <yskelg@gmail.com>, 
 James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 Andi Kleen <ak@linux.intel.com>, Charlie Jenkins <charlie@rivosinc.com>, 
 John Garry <john.g.garry@oracle.com>, Leo Yan <leo.yan@linux.dev>, 
 Michael Petlan <mpetlan@redhat.com>, 
 Tavian Barnes <tavianator@tavianator.com>, 
 Veronika Molnarova <vmolnaro@redhat.com>, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20250313033121.758978-1-irogers@google.com>
References: <20250313033121.758978-1-irogers@google.com>
Subject: Re: [PATCH v2] perf libunwind: Fixup conversion
 perf_sample->user_regs to a pointer
Message-Id: <174232093676.2542685.15670125863336766245.b4-ty@kernel.org>
Date: Tue, 18 Mar 2025 11:02:16 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 12 Mar 2025 20:31:21 -0700, Ian Rogers wrote:
> The dc6d2bc2d893a878 ("perf sample: Make user_regs and intr_regs optional") misses
> the changes to a file, resulting in this problem:
> 
>   $ make LIBUNWIND=1 -C tools/perf O=/tmp/build/perf-tools-next install-bin
>   <SNIP>
>     CC      /tmp/build/perf-tools-next/util/unwind-libunwind-local.o
>     CC      /tmp/build/perf-tools-next/util/unwind-libunwind.o
>   <SNIP>
>   util/unwind-libunwind-local.c: In function ‘access_mem’:
>   util/unwind-libunwind-local.c:582:56: error: ‘ui->sample->user_regs’ is a pointer; did you mean to use ‘->’?
>     582 |         if (__write || !stack || !ui->sample->user_regs.regs) {
>         |                                                        ^
>         |                                                        ->
>   util/unwind-libunwind-local.c:587:38: error: passing argument 2 of ‘perf_reg_value’ from incompatible pointer type [-Wincompatible-pointer-types]
>     587 |         ret = perf_reg_value(&start, &ui->sample->user_regs,
>         |                                      ^~~~~~~~~~~~~~~~~~~~~~
>         |                                      |
>         |                                      struct regs_dump **
> <SNIP>
>   ⬢ [acme@toolbox perf-tools-next]$ git bisect bad
>   dc6d2bc2d893a878e7b58578ff01b4738708deb4 is the first bad commit
>   commit dc6d2bc2d893a878e7b58578ff01b4738708deb4 (HEAD)
>   Author: Ian Rogers <irogers@google.com>
>   Date:   Mon Jan 13 11:43:45 2025 -0800
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


