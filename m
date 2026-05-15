Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D17F3126DA
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 02:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778811700; cv=none; b=djQOK1wgh9wSYdqxUjjgLlsfsqe34pzOOefwl2Y22Qy7lsiltPyA3C8IxwvN0q9gGNO1mmGQweRXriglE1n+lq0A+0e03INgTIvGUBGiTL006BIXojuQ8oUSFbQ+SJlYLgNn8lDmTfPVjkUcj95G+7aLMUgr87ELHRrCK8uUN3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778811700; c=relaxed/simple;
	bh=v10+HXlwkUcUIXTySKXLGIbShZ9k+ecd5+zNSz84sHw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iWcB4k0XTM3OAGYEGx9frepjV9YbIREgJiBUHlaBuw05ValxZwjSVYr/M9Yk1TvRioisgfb20sLNa83y3Za8XihDUgliDsr+Q2JcJlZMnEjvmi0ZqFAl07VNjtP34n05jA+YeSm3yPt1XfKgQ+cGKeqcJge3oX1x90ianj1gz5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOE8nKd/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOE8nKd/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 111E0C2BCB3;
	Fri, 15 May 2026 02:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778811700;
	bh=v10+HXlwkUcUIXTySKXLGIbShZ9k+ecd5+zNSz84sHw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=tOE8nKd/j2omXNd9Qtzjo70f+5ZVmwzGhQfITw4LD4OABaXWY0xvJMWtUXnUBZ2bv
	 4zMdj60umwBm7HcPnBLofGZq7cejPeunoJK/fYSVisnMZjs/jSbtEjPLJJHMSQoF4K
	 FOg1r+xtN2tmOzZ5borWHw/GBCb83+BJUvcswyEDLeeM8Bdhqu2oz4QgbT/OiHCbER
	 R1U1TFRPdn1ICiTlmyilajE8A7GEBw2jmk5Omiu71EhcfBYBYgUkmrdohwRr+qNyUk
	 I1O6csPE/8Egznl24VapH8SHPJ1BTdr3eMA/booXSFU3phsn7BiNNeP74/2b+OZLrn
	 8M/HM6sOBlWjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 28/32] perf sched: Bounds check CPU in sched switch
 events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260512223001.2952848-29-irogers@google.com>
References: <20260512223001.2952848-29-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 02:21:39 +0000
Message-Id: <20260515022140.111E0C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The `perf_sched__timehist` function is missing the `.mmap2` callba=
ck registration.
- [High] Out-of-bounds memory accesses and DoS vulnerabilities in `latency_=
switch_event`, `latency_runtime_event`, and `map_switch_event`.
- [Medium] Uncapped warnings in the event parsing loop will flood the conso=
le and severely degrade performance.
- [Low] Incorrect format specifier for `sample->cpu` in `timehist_sched_cha=
nge_event`.
--

commit 3fdb227eb96c3cdfcd8144894aa0add09c128ffa
Author: Ian Rogers <irogers@google.com>

perf sched: Bounds check CPU in sched switch events

Ensure the CPU is within expected bounds to avoid out of bound memory
accesses during sched switch events.

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

Could this pr_warning() flood the console and severely degrade performance
if a trace contains a large number of out-of-bounds events?

Would it be better to rate-limit this warning or restrict it to a single
occurrence?

> +		return 0;
> +	}

[ ... ]

> @@ -2775,6 +2785,11 @@ static int timehist_sched_change_event(const struc=
t perf_tool *tool,
>  	int rc =3D 0;
>  	const char state =3D perf_sample__taskstate(sample, "prev_state");
> =20
> +	if (sample->cpu >=3D MAX_CPUS) {
> +		pr_warning("Out-of-bound sample CPU %d. Skipping sample\n", sample->cp=
u);

Since sample->cpu is an unsigned 32-bit integer, will using the %d format
specifier cause an unassigned CPU value like 0xFFFFFFFF to be incorrectly
printed as -1?

Does this also introduce an inconsistency, given process_sched_runtime_event
correctly uses %u for the exact same variable?

> +		return 0;
> +	}

While reviewing this change, a few related issues in the subsystem stood ou=
t:

In perf_sched__timehist, the subcommand registers .mmap but completely omits
.mmap2. Will this cause MMAP2 events to be silently dropped and leave memory
maps uninitialized, potentially leading to NULL pointer dereferences?

Additionally, this patch adds graceful bounds checks for sched switch event=
s,
but handlers like latency_switch_event, latency_runtime_event, and
map_switch_event still rely on BUG_ON(cpu >=3D MAX_CPUS || cpu < 0) for
validation.

If perf is compiled with NDEBUG, will these evaluate to a no-op and allow
out-of-bounds array reads and writes against sched->cpu_last_switched[cpu]
and sched->map.comp_cpus_mask?

Could these handlers be updated to gracefully skip invalid samples like the
ones modified in this patch?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512223001.2952=
848-1-irogers@google.com?part=3D28
