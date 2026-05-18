Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCF019E819
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 23:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779145362; cv=none; b=P2f946Z2zzHSU18Ri+9QR46MWrsq0FkDDXs5KAV5IRXfPXoUF7nTg39uOWLHld9VxoA7Yyg5wyX7lN1OCEkHbCjHw+667K6opFAM8rxrYxd6m74pJ5S/g3365ki/WkDPVU2HrSps70ShkJ+Arx70DB+JhaVpgm37tmPU1JRBnJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779145362; c=relaxed/simple;
	bh=KNsa4b1lvGxOT2vbNyOn3U4F4TiOnLFL88DO0D/THxM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EnuYSItkF+N6+k2qZ2quHas3M69C0VS1D+/YGM0z6DfbYWcXEOX7LquBCF4cOHz3xorOpJRPEg2o9g+09U07o6Zi3qa4UPmpT8WrCSvZmY5xDAIaqlz3GB4oTuo39aDhqJC3O1NUr0Wn7NM7tbnGbVWxgGmHwvzrZYYB6G95CR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQsv7HKW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQsv7HKW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1132DC2BCB7;
	Mon, 18 May 2026 23:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779145362;
	bh=KNsa4b1lvGxOT2vbNyOn3U4F4TiOnLFL88DO0D/THxM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=AQsv7HKW1WIonMUrxjsCb5t4MaLWeoKA1Lu6JYJU5iXXJjjX+/a5cv6ykh7Lx4+IS
	 rqMwxmCEuSZq1qXFLviniB9kcQAoPWCrfwyA9XxsUyhq9/xNjNT79JQpS+rd7hX50V
	 MkDojkjHoYyyO1njNH1hac8y192ukFfiau4g/VjBTt2QRVkpVBZacsAxwuXhJIS5d4
	 KYgVB9XtPGsLo7bB0o0Z7J92SZEkcR6nh1EQ97Cst9ikPsNplxRViEv5Wxx1EbcKd/
	 feTulgSXIHJX3Xg6xRdTcfpl0acyWHVpQN07tv7rRWdkjscDbWqpA/ez9ZZcafAhgg
	 Ysyq274SBhRKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] perf tool_pmu: Make tool PMU events respect
 enable/disable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260518223733.3034897-2-irogers@google.com>
References: <20260518223733.3034897-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 23:02:41 +0000
Message-Id: <20260518230242.1132DC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Inconsistent disabled state on early return in evsel__enable() a=
nd evsel__disable().
- [Medium] evsel__tool_pmu_disable_cpu() leaves start_time intact if readin=
g stats fails, causing disabled CPUs to keep counting.
- [Medium] Disabling a duration_time group leader prematurely sets its disa=
bled flag, causing __evlist__disable() to skip member events on CPUs > 0.
--

commit c37afe120a59773ddf6b54a63fa825fceec20137
Author: Ian Rogers <irogers@google.com>

perf tool_pmu: Make tool PMU events respect enable/disable

Tool PMU events (duration_time, user_time, system_time) currently
count from when the event is opened to when it is read. This causes
issues with features like the delay option (-D) or control fd, where
events are opened but should not start counting immediately. Make these
events behave more like regular counters by implementing proper enable
and disable support.

Link: https://lore.kernel.org/linux-perf-users/20260517093650.2540920-1-nig=
ro.fra@gmail.com/

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
[ ... ]
> @@ -1810,12 +1867,65 @@ int evsel__enable(struct evsel *evsel)
>  int evsel__enable(struct evsel *evsel)
>  {
> -	int err =3D perf_evsel__enable(&evsel->core);
> +	int err;
> +
> +	if (evsel__is_tool(evsel))
> +		err =3D evsel__tool_pmu_enable(evsel);
> +	else
> +		err =3D perf_evsel__enable(&evsel->core);
> +
> +	if (!err && evsel__is_group_leader(evsel)) {
> +		struct evsel *member;
> +
> +		for_each_group_member(member, evsel) {
> +			if (evsel__is_non_perf_event_open_pmu(evsel) ||
> +			    evsel__is_non_perf_event_open_pmu(member)) {
[ ... ]
> +				int mem_err =3D evsel__enable(member);
> +
> +				if (mem_err)
> +					return mem_err;

Does this early return on mem_err skip setting evsel->disabled =3D false at
the end of the function? It looks like this could leave the group leader wi=
th
its software disabled flag set to true, even though the kernel already
successfully enabled it via perf_evsel__enable(&evsel->core).

> +			}
> +			member->disabled =3D false;
> +		}
> +	}
> =20
>  	if (!err)
>  		evsel->disabled =3D false;
>  	return err;
>  }
[ ... ]
>  int evsel__disable(struct evsel *evsel)
>  {
> -	int err =3D perf_evsel__disable(&evsel->core);
> +	int err;
> +
> +	if (evsel__is_tool(evsel))
> +		err =3D evsel__tool_pmu_disable(evsel);
> +	else
> +		err =3D perf_evsel__disable(&evsel->core);
> +
> +	if (!err && evsel__is_group_leader(evsel)) {
> +		struct evsel *member;
> +
> +		for_each_group_member(member, evsel) {
> +			if (evsel__is_non_perf_event_open_pmu(evsel) ||
> +			    evsel__is_non_perf_event_open_pmu(member)) {
[ ... ]
> +				int mem_err =3D evsel__disable(member);
> +
> +				if (mem_err)
> +					return mem_err;

A similar early return happens here. If evsel__disable(member) fails, it
skips marking the group leader evsel->disabled =3D true at the bottom of the
function. Could this leave the state inconsistent for the leader?

> +			}
> +			member->disabled =3D true;
> +		}
> +	}

> diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
> --- a/tools/perf/util/tool_pmu.c
> +++ b/tools/perf/util/tool_pmu.c
[ ... ]
> +int evsel__tool_pmu_disable_cpu(struct evsel *evsel, int cpu_map_idx)
> +{
> +	enum tool_pmu_event ev =3D evsel__tool_event(evsel);
> +	int thread, nthreads;
> +
> +	if (evsel->disabled)
> +		return 0;
> +
> +	if (ev =3D=3D TOOL_PMU__EVENT_DURATION_TIME) {
> +		if (cpu_map_idx =3D=3D 0) {
> +			__u64 delta =3D rdclock() - evsel->duration_time.start_time;
> +
> +			evsel->duration_time.accumulated_time +=3D delta;
> +			evsel->disabled =3D true;

Since evsel->disabled =3D true is set globally here when processing
cpu_map_idx 0, will __evlist__disable() see pos->disabled =3D=3D true for t=
his
group leader when iterating over the remaining CPUs?

If so, would it skip calling evsel__disable_cpu() for CPUs > 0, failing to
disable the associated member events on those CPUs?

> +		}
> +		return 0;
> +	}
> +
> +	if (ev =3D=3D TOOL_PMU__EVENT_USER_TIME || ev =3D=3D TOOL_PMU__EVENT_SY=
STEM_TIME) {
> +		nthreads =3D xyarray__max_y(evsel->process_time.start_times);
> +		for (thread =3D 0; thread < nthreads; thread++) {
> +			__u64 *start_time =3D xyarray__entry(evsel->process_time.start_times,
> +							   cpu_map_idx, thread);
> +			__u64 *accumulated_time =3D xyarray__entry(
> +				evsel->process_time.accumulated_times, cpu_map_idx, thread);
> +			__u64 val;
> +			int err;
> +
> +			err =3D tool_pmu__read_stat(evsel, cpu_map_idx, thread, &val);
> +			if (!err) {
> +				if (*start_time !=3D INVALID_START_TIME && val >=3D *start_time)
> +					*accumulated_time +=3D (val - *start_time);
> +				*start_time =3D INVALID_START_TIME;
> +			}

If tool_pmu__read_stat() fails here (for instance, due to transient /proc
errors or a terminating thread), does leaving *start_time intact cause
subsequent calls to evsel__tool_pmu_read() to continue calculating deltas
using the lingering *start_time and erroneously add them to accumulated_tim=
e?

Should *start_time =3D INVALID_START_TIME; be done unconditionally outside
the if (!err) block?

> +		}
> +	}
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518223733.3034=
897-1-irogers@google.com?part=3D1
