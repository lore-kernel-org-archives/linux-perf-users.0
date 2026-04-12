Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B19B1D7E41
	for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 02:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775962534; cv=none; b=XAoOlp8lsuHhFovc8OOrBcPHYQ2FUuZA+8y6x+9HJ6XTQaVDu4/jZHa/scfRd5+kk3S9GveWhjeiEsA7AvG3zGMiB4NYSdzSbrQKCo0lwYlR75oJLrKqm3U+IM9RuTfeHIX/3e/pjT9u0KOnZHALgCQPnWqdW3wzBNlivY5XLWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775962534; c=relaxed/simple;
	bh=mv7rmQTjD+xeQMyTc6rB05jz8SJFijhOd16reZLTGbY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MXQLso2SyeZeXO9A/9LCwAuaSeSfKB1RBq5AC0SXju3+SGuY9IYuqCXi5KFVpgJIBxumAlxy7cYyUk4h/qUZdQtMTg/BN/qhTgnV5BkMZvB8H5kpPZOn2gcDezYEx2VpXP1XpJn9EdLg0guv9eBNMmlOMMuxm1JbE7XfprxsJOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3y5HrYN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3y5HrYN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3B4C116C6;
	Sun, 12 Apr 2026 02:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775962533;
	bh=mv7rmQTjD+xeQMyTc6rB05jz8SJFijhOd16reZLTGbY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=B3y5HrYNTaSmYrRswgY/msdlSKjDOF54PIwAO1wxPIkoolq6h7D7fHOs8hYVSLQ/W
	 jX/3kYsHcoLEWNqxzx6mY4OeOFPkp3WJHjRNqTbMUyse+zRpvXFLWFkevayIDflu++
	 VM13gR5sshiW5js34ZdeQCRmEp8sS1YLmTAQhWVWJrsn+nHCdqT4tlfZO/8/DQzmbZ
	 ZpmS47L5Mf17bMM9QwJ6KzdO8C3xkzp7RJPv/pi/5ThEenx4DXEUyXMhkrgLR68I/4
	 MFXKpfDJDubAGM/texHuMerucR81nTVlYHai8K8DdTtZnLr4CPtx7NxMRDBXFBaIK3
	 7+wse1xYRARJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 25/29] perf sched: Bounds check CPU in sched switch
 events
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260412020833.641177-26-irogers@google.com>
References: <20260412020833.641177-26-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Apr 2026 02:55:33 +0000
Message-Id: <20260412025533.AF3B4C116C6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] Unvalidated CPU values in `timehist` handlers cause out-of-bounds =
heap read/write
- [Medium] Missing bounds check in `process_sched_runtime_event` leads to t=
ool crash via `BUG_ON`
- [Medium] Returning -1 for out-of-bounds CPUs causes premature abortion of=
 the entire perf session
--

commit 063652e61f7d3a2993ab963919bbc194b73f6f39
Author: Ian Rogers <irogers@google.com>

perf sched: Bounds check CPU in sched switch events

This commit adds a bounds check on the CPU value in sched switch events
to prevent out of bound memory accesses when parsing samples.

> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 45439e2af8ffa..6d0655d56e269 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -1791,6 +1791,11 @@ static int process_sched_switch_event(const struct=
 perf_tool *tool,
>  	u32 prev_pid =3D perf_sample__intval(sample, "prev_pid"),
>  	    next_pid =3D perf_sample__intval(sample, "next_pid");
> =20
> +	if (this_cpu < 0 || this_cpu >=3D MAX_CPUS) {
> +		pr_debug("Out-of-bound sample CPU %d\n", this_cpu);
> +		return -1;

Does returning -1 here cause a regression where the entire perf session
parsing aborts?

If a trace is recorded on a system with more than 4096 CPUs, returning a
negative value bubbles up to perf_session__process_events(), halting trace
parsing completely.

Would returning 0 gracefully skip the unsupported sample instead?

> +	}
> +
>  	if (sched->curr_pid[this_cpu] !=3D (u32)-1) {
>  		/*
>  		 * Are we trying to switch away a PID that is

Since we are bounds checking process_sched_switch_event(), do we also need
similar protection in process_sched_runtime_event()?

If a malformed sched:sched_stat_runtime event contains an out-of-bounds CPU,
it is passed to latency_runtime_event() which executes
BUG_ON(cpu >=3D MAX_CPUS || cpu < 0). Could this crash the perf tool?

Similarly, do timehist handlers like timehist_sched_change_event()
need this bounds check to prevent out-of-bounds regressions?

If a corrupted trace provides sample->cpu =3D 0xFFFFFFFF, it gets passed to
get_idle_thread(int cpu) and cast to -1. This bypasses the expansion check
(-1 >=3D idle_max_cpu is false) and accesses idle_threads[-1].

Also, evsel__save_time() calculates __roundup_pow_of_two(cpu + 1),
which can overflow to 0, resulting in a realloc(..., 0) (effectively a free)
and an out-of-bounds write at last_time[cpu].

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260412020833.6411=
77-1-irogers@google.com?part=3D25
