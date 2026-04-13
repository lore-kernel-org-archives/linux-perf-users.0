Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06197232395
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 02:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776047411; cv=none; b=e9/c/3Voa+E5hJrydSqrYI2p60xGSlUnFSgCPecxT0XKi8Rqw05neyk4DTERkGN+FyOEEM4CXbZc89n/AUo1sDZMrrpCzKggefzlitCppXS9SRfZ7PEIiAit0CjcI8+KLCXSzgeYUfnKOr3imc0DRtEykrIuplszPRat9mOX1AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776047411; c=relaxed/simple;
	bh=p3P5YrQ4C43zYKuV58zOvEYi2zd8NDC0I+Tjpzl9t5w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kfqV7A13w2z7uf8vWL0Xw1gnufoYxH+u/+tAmzdmH6SXLNN9wJKKiposfHhFThb1kI7Lf5enH0WOUgB1nSMLN9AnuCMnWhqBA+jwXns62iqDFWa0MwLmh8wkt5/q5EWuw9TcSF4b3o7wTazgigeif+x+xm+Yvcl4zPD552KChkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDIJG+xK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDIJG+xK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70359C19424;
	Mon, 13 Apr 2026 02:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776047410;
	bh=p3P5YrQ4C43zYKuV58zOvEYi2zd8NDC0I+Tjpzl9t5w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=tDIJG+xKmwMSPBM+76Euy37DE0lag8AwStQigARdyWdkHSH5XolbUIYXfUZ5Dar/z
	 tRl+29caDfj4B0YWLcg0Wz3FbRFWpNBkj/8yQmS8Jzp/Gwbu81USOvCNaTYIDPK3WX
	 u+w89YmTZF1BiR9TliMAHoe6FMTWhk75Kq1b2Unf3CEjvz1XDi4XhQBJ92EaFIuyW3
	 UWMJEqwCGbscnGy4UuHrK7ax4yUA7leXhIw8kfDFh/4O5sI6rfVy15STXkGaF4vH/m
	 DUAoS/KxlmNOfO0/W2iMdnRKD4inAXN6kL4y+NgcixYPIPb/1lK2FZsTk2o57/0nky
	 0CauKzwsYdkag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 29/33] perf sched: Bounds check CPU in sched switch
 events
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260413012227.1089445-30-irogers@google.com>
References: <20260413012227.1089445-30-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Apr 2026 02:30:09 +0000
Message-Id: <20260413023010.70359C19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] Un-ratelimited warnings inside the per-sample processing loop ca=
n cause severe console spam and performance degradation.
- [Low] Type mismatch and format string errors cause compiler warnings that=
 break the build under `-Werror`.
--

commit 30019433f1de0fe00c79f330acfbb9ea9ed08603
Author: Ian Rogers <irogers@google.com>

perf sched: Bounds check CPU in sched switch events

This commit adds bounds checking for the CPU index in various perf sched
event handlers to prevent out-of-bounds memory accesses.

> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -1791,6 +1791,11 @@ static int process_sched_switch_event(const struct=
 perf_tool *tool,
>  	u32 prev_pid =3D perf_sample__intval(sample, "prev_pid"),
>  	    next_pid =3D perf_sample__intval(sample, "next_pid");
> =20
> +	if (this_cpu < 0 || this_cpu >=3D MAX_CPUS) {
> +		pr_warning("Out-of-bound sample CPU %d. Skipping sample\n", this_cpu);

Could printing a warning for every out-of-bounds sample cause severe
console spam and bottleneck trace processing?

Since these functions are called per-sample in the perf.data file, a trace
with corrupted data or recorded on a system with more than MAX_CPUS cores
might print millions of lines.

Would it be better to rate-limit this warning, aggregate the skipped counts,
or lower the log level to pr_debug()?

> +		return 0;
> +	}
> +
>  	if (sched->curr_pid[this_cpu] !=3D (u32)-1) {

[ ... ]

> @@ -1813,6 +1818,11 @@ static int process_sched_runtime_event(const struc=
t perf_tool *tool,
>  {
>  	struct perf_sched *sched =3D container_of(tool, struct perf_sched, tool=
);
> =20
> +	if (sample->cpu < 0 || sample->cpu >=3D MAX_CPUS) {
> +		pr_warning("Out-of-bound sample CPU %d. Skipping sample\n", sample->cp=
u);

Since sample->cpu is an unsigned 32-bit integer, will the sample->cpu < 0
condition evaluate to always false and trigger a compiler warning?

Additionally, does using the %d format specifier for this unsigned value
trigger a format string warning, potentially breaking the build under -Werr=
or?

> +		return 0;
> +	}
> +
>  	if (sched->tp_handler->runtime_event)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260413012227.1089=
445-1-irogers@google.com?part=3D29
