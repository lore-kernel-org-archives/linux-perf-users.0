Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9C33B3894;
	Wed,  1 Jul 2026 17:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782927813; cv=none; b=EJGJcyaohbPJHBPBPPU0sy4cxbiPRJiPGTdNSYFxlRt0N+U1+nP/G/xMWMs/nJx2t84IHwYMREtteFQpzPRYZF4YUOuLS7blHSsWnHcG5P9XC2+cWO3ZznHynjU8VVNOo6iEHhdPQf8kZ3897AVlMlFFrc+7drsxTFG5GVdQjW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782927813; c=relaxed/simple;
	bh=FZZ3JX3Jt0wCJqDqMoWgne8Z9LRnOnHvXbdp/J2rFow=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sUH65J96JlXEppZ3fBf8ik6Er0Kyx0NDs13xI+BCz30+jbYD0LigaH/QJnc1NzPVHx+dcw81RycNyUAdXLmVlCdDXOOrRF3cpi/spDAI7cTVPE5IMYvSS7Ube6OvLPeVZKZJiH4myFrbBSfLKZRuzgKTmwAJCnaNYsNxfGjG5Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9YELE3F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9YELE3F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45CEC1F00A3A;
	Wed,  1 Jul 2026 17:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782927812;
	bh=5SIRMQ8ZD7yHueLn/yhwsNwdxvUPxtf+KfkisPVfJss=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=f9YELE3FbLR4yyviSmZupksSSkB9jHk6Ao1BqmFIXi3drP+PmF1FRFfRMoLYUiAIU
	 Xl195egCIHoXPzYgp+3mVBbiKPrj+EtedMuqMh0rGoRSTElx6o45z9E+SmD6bZ5qtw
	 nw237lMnpEyM6m0Saqptr9OjbNo6Po7v6iSldb0WqcjkpUKSGMDcTR2tl6xuh/g4fR
	 srrTrbT9hZUcCs0w/MqCisYUC9Wc5BBvJBFlPNt3SHFeZ8oeAlFrBKpL8aRw7bcOs7
	 okCCSFkbqKmMz31zqQ2ZZ+Y8mIbGk6XMMJGMSymnapnmB9p/rxI9v9O96K9R1I8XGK
	 zCpl3pzj2uC2w==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
 linux-perf-users@vger.kernel.org
In-Reply-To: <20260624205852.3864874-1-namhyung@kernel.org>
References: <20260624205852.3864874-1-namhyung@kernel.org>
Subject: Re: [PATCH v3 0/8] perf timechart: Fix memory leaks
Message-Id: <178292781225.3559466.11302975633009015643.b4-ty@kernel.org>
Date: Wed, 01 Jul 2026 10:43:32 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 24 Jun 2026 13:58:26 -0700, Namhyung Kim wrote:
> This patchset fixes memory leaks in the perf timechart code.
> I've extended and verified the timechart test with ASAN.
> 
> I'm sending it with my previous work on backtrace optimization.
> 
> v3)
>  * combine small optimization series
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


