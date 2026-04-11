Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7514282F09
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 07:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775892621; cv=none; b=mKduVZ3RnZuj69y/JZi7UqA/G4KCPZkVHN3IiO7SPRJPP4VdW/GYx/PX+VclL/8mMcid5F8ydvvcqyhlXbYKhu74Y9IIWnt+xaJ4Y9tcC7Tj3YiO4g63CS4q//X49Q4el1api6+zhqbAijd82mTnzc52BtAv4+Ey/pT6+e4im3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775892621; c=relaxed/simple;
	bh=dkx5AIvMdiIUCV0VnaPg1FqNSzGOjiVvKsX1lpy82eU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E7ECSGA5vR9bWr+8/oDXTN2qS7PElivA9bzF0o/jZbvrtr+dkVKteyj+fFGHnssNn9VnuL5UkIixvV6fe9za3qFR0ERkRLuvRoXY3Q9FPqnYbbSWvDRbnTi99UMy99/kX5svYJJFBWx4MtNPedeLxYVJXlVzYG504VBuT8+SXMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ah+Np6gP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ah+Np6gP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D16DC4CEF7;
	Sat, 11 Apr 2026 07:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775892621;
	bh=dkx5AIvMdiIUCV0VnaPg1FqNSzGOjiVvKsX1lpy82eU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ah+Np6gPHR5viZoqutbp5uWgczEJqjWuxGXNYXw2j9wUE+VAQPPDFoSTYjXW6lZXZ
	 7+9vLuY8j7+llXhXnwMsqvXOBW2Eo9t+K2XEsxhwHfAmnTFRjQd6z4SvbsJDilgz35
	 EQfrcznREP1vLRX80t/OVA66yPpSHu0S0o+Jt8d7QtyjgWG4GjiKBoMIeJe/jtUTpG
	 jt58iJ5L2ES+tB6w/2eJx532tpgsNo7MLuMt5FjQWSfahzuOvCH0UJXhu0R/nJTDL/
	 Js3Fhl0XYNNuPQ8FBKcqDb9rPwPvXlWlusxktKU3FVQpz1EMbilOTiueiVYA0+Qtmo
	 cI9Axa2wtEQlg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 26/29] perf timechart: Bounds check CPU
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260411065718.372240-27-irogers@google.com>
References: <20260411065718.372240-27-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Apr 2026 07:30:20 +0000
Message-Id: <20260411073021.2D16DC4CEF7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Incomplete bounds checking for CPU indexes (commit message misma=
tch)
--

commit 25dc3fef25602cbfcf60331e4d743c6fc8cc7612
Author: Ian Rogers <irogers@google.com>

perf timechart: Bounds check CPU

This commit adds bounds checking for cpu_id in several perf timechart
event handlers to prevent out-of-bounds memory accesses in CPU state
arrays.

> Ensure the CPU is within expected bounds to avoid out of bound memory
> accesses in arrays tracking CPU state.

Does this update catch all of the out-of-bounds accesses in this file?

Looking at the other handlers in builtin-timechart.c, it appears that
process_sample_power_end() was skipped. It passes the unvalidated
sample->cpu directly to c_state_end(), which uses it to index the
fixed-size cpus_cstate_state and cpus_cstate_start_times arrays:

static int
process_sample_power_end(struct timechart *tchart,
                         struct perf_sample *sample,
                         const char *backtrace __maybe_unused)
{
        c_state_end(tchart, sample->cpu, sample->time);
        return 0;
}

Should process_sample_power_end() also bounds-check sample->cpu?

Similarly, process_sample_sched_switch() and process_sample_sched_wakeup()
pass unvalidated sample->cpu values. Could these be used later in cpu2y()
via svg_process() to index the heap-allocated topology_map, allowing
out-of-bounds reads?

Also, does end_sample_processing() need a check against MAX_CPUS?

It loops up to tchart->numcpus (which is populated from the trace file
header) and accesses cpus_pstate_state. If the header specifies more
than 4096 CPUs, could this loop cause a buffer overflow during
finalization?

static void end_sample_processing(struct timechart *tchart)
{
        u64 cpu;
        struct power_event *pwr;

        for (cpu =3D 0; cpu <=3D tchart->numcpus; cpu++) {
                ...
                pwr =3D p_state_end(tchart, cpu, tchart->last_time);
                ...
        }
}

> diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechar=
t.c
> index 64f69bd67c6b7..0db2a9bd5b911 100644
> --- a/tools/perf/builtin-timechart.c
> +++ b/tools/perf/builtin-timechart.c
> @@ -607,6 +607,10 @@ process_sample_cpu_idle(struct timechart *tchart __m=
aybe_unused,
>  	u32 state  =3D perf_sample__intval(sample, "state");
>  	u32 cpu_id =3D perf_sample__intval(sample, "cpu_id");
> =20
> +	if (cpu_id >=3D MAX_CPUS) {
> +		pr_debug("Out-of-bounds cpu_id %u\n", cpu_id);
> +		return -1;
> +	}
>  	if (state =3D=3D (u32)PWR_EVENT_EXIT)
>  		c_state_end(tchart, cpu_id, sample->time);
>  	else

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260411065718.3722=
40-1-irogers@google.com?part=3D26
