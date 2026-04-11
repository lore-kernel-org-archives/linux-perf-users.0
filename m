Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7089278F4F
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 20:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775937750; cv=none; b=iZG2/OFuiLhS5Q6KZNwrEsFg33j4JM4FFl5nqjKj4qnRh7dhimFYRcQ65l1Aan2fbccLKhEtBrL9t4QD/G+jgtFhIFBhgCfkah+F9h2YpPo+xIHRRSfvSgHC5KHxzRbiy2YZeqMdjE3EkjNFP7IhtQMQT1NMaRiv3Rdhbn9KWFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775937750; c=relaxed/simple;
	bh=+PZ8EyJDy+z+J+xBNfp78kwpe6DMDQPpR7XmP2Bpg6c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oYRIs2u0MJQbKmvlboQ0I+vwdV90HMA4ynLFShMJrvt+AQF+ylnYp6JmbiTA5XrSzDUo70UT1ZdF+8wtZ7c5zfNzqGQDDNS8a2SG0Ouq+oKpGiBlSHUGi2UaKvkEqtXGTW1l9lqJYv6g/M3qtW5yY+4lX1bq0ayf69vbIlGgQ5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ub8To6rW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ub8To6rW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01391C2BCAF;
	Sat, 11 Apr 2026 20:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775937750;
	bh=+PZ8EyJDy+z+J+xBNfp78kwpe6DMDQPpR7XmP2Bpg6c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Ub8To6rWFxcp0Rje3SdlTrLEL3/saYJ5VVuOAY8WZAxJhSw4POEEuXxqAZNOoANpv
	 wTBxIXDCn59D32hFv0uTomRBOuEMOBZXN9rXDEOSMTRLLl4flnPa2C9e4yjqDzjMz8
	 POb17HjnE/r+1O/iQUdStdhldT4MKG3PKabCCzwXMbGq7agNWmSdD7OWeKjYuP9Yrd
	 HKdc5bYKByv83MJHQcGKLtVayq9QcFwA9nz2U+gwsPiEA6u1uSNFf6jWwTGrhlCm7V
	 yLdgSkRCyhj8WGC/1nfN/wFWDPJjUs7gK4ucMKjq91S+SVzs/hTCIMlzpmehc7w0LA
	 v9wHHLhVCqcVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 25/29] perf sched: Bounds check CPU in sched switch
 events
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260411191710.524998-26-irogers@google.com>
References: <20260411191710.524998-26-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Apr 2026 20:02:29 +0000
Message-Id: <20260411200230.01391C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 5 potential issue(s):
- [Critical] Out-of-bounds heap read/write in `perf sched timehist` due to =
unchecked `sample->cpu`.
- [Critical] Negative index and off-by-one bypass in `get_sample_cpu()` all=
ows arbitrary heap read/write.
- [Critical] Unchecked `cpu_id` tracepoint payload leads to out-of-bounds h=
eap writes in `builtin-timechart.c`.
- [High] Incomplete fix leaves `sched:sched_stat_runtime` events vulnerable=
 to DoS via `BUG_ON()`.
- [Medium] Returning -1 for an out-of-bounds CPU fatally aborts the entire =
perf session with a hidden error message.
--

commit ee5811718c2f5992d5f203b3876aaf1507998bbd
Author: Ian Rogers <irogers@google.com>

perf sched: Bounds check CPU in sched switch events

Ensure the CPU is within expected bounds to avoid out of bound memory
accesses.

Signed-off-by: Ian Rogers <irogers@google.com>

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
> +	}

Does returning -1 here fatally abort the entire perf session instead of just
skipping the corrupted sample?

Since a negative return propagates up and terminates the processing loop,
users might experience a sudden exit. Also, since this uses pr_debug, will
users without verbose mode enabled see a generic abort error without knowing
why the tool failed?

Does this fix also need to cover process_sched_runtime_event() to fully
prevent out of bound accesses?

When handling sched:sched_stat_runtime events, that function passes the
sample directly to latency_runtime_event(), where it extracts sample->cpu
and immediately hits BUG_ON(cpu >=3D MAX_CPUS || cpu < 0). Processing a
malformed perf.data file could still crash the tool.

Are there similar out-of-bounds regressions in perf sched timehist?

In perf_timehist__process_sample(), sample->cpu is assigned to a 16-bit
integer and passed to get_idle_thread(). Since an input like 0xFFFFFFFF wra=
ps
to -1, it bypasses the upper bounds check and accesses idle_threads[-1],
which could lead to an out-of-bounds read and write.

Additionally, timehist_print_sample() tests the bit using
test_bit(sample->cpu, cpu_bitmap), potentially causing another out-of-bounds
read.

Could get_sample_cpu() in data-convert-bt.c also be bypassed?

The sample->cpu is assigned to a signed integer, meaning 0xFFFFFFFF wraps
to -1 and bypasses the check for cpu > cw->stream_cnt. The check also
evaluates to false if cpu is equal to cw->stream_cnt, creating an off-by-one
bypass.

This allows ctf_stream() to access cw->stream[-1] or
cw->stream[cw->stream_cnt], potentially allocating a new stream
out-of-bounds.

Is builtin-timechart.c similarly vulnerable to unchecked tracepoint payload=
s?

The process_sample_cpu_idle() and process_sample_cpu_frequency() functions
extract cpu_id and pass it directly to c_state_start() and p_state_change(),
where it is used as an index for static arrays bounded by MAX_CPUS. Supplyi=
ng
a large cpu_id could result in out-of-bounds writes.

This regression was fixed later in the patch series by commit aa15bc3e9dfa
(perf timechart: Bounds check CPU).

>  	if (sched->curr_pid[this_cpu] !=3D (u32)-1) {
>  		/*
>  		 * Are we trying to switch away a PID that is

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260411191710.5249=
98-1-irogers@google.com?part=3D25
