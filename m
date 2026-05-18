Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CADF359A68
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 20:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779137360; cv=none; b=p3w7+DeG5/gO04gienez3mb1DkVBCfik8Gd/5/6MEeINQ27UKSQ+dX10JSfRX+9h4HX7iKa5xuAnmDPyiA3qzKazZZns1EL7yHWBy7jXegBA4+Qt/uh2vBeMyTOD53/2RAZumuWbSj6SUpPIUUb6PHZTsfIWxfZ/9qVxQ5IzxXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779137360; c=relaxed/simple;
	bh=VnUz5LTAUvB7UX17VLDHf/9Vu686cyQpTGiI2D3y/Ec=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qHdxDtxFZcjZ0QCLdsUyK0c5LUtMPa45bHoENQyjF/qpQpyIDY3jx95LtdYTuMhEJ3zoCGl4H2i9JjdX6VKmf5etUBQ/9rPlZg1QyGuajP/W7W63TyNqLsCGz7JpE20EbSdnElN7V1c5BeagBaACpuko8NXfNPiOA8xdcy5nJYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6BfXFzB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6BfXFzB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E62C2BCB7;
	Mon, 18 May 2026 20:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779137360;
	bh=VnUz5LTAUvB7UX17VLDHf/9Vu686cyQpTGiI2D3y/Ec=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=V6BfXFzBVqa6MdVZMThcS+4mQfVc6TRthBIhn4YiI7gQa9IWnHtE6NtP3+57f+4Oc
	 sx66w9H5aJWAQo42t4BfdFLQ9LmMPYN6+ufWnjEfhDNruAThTijwP4KKtO8b2vBhEW
	 feXY4C6LrlYF8A5s8twSPLgpZyeFNust+tYwcYHE1GHlmYAS+0VzuXDZNcQhrCq83L
	 F8hI6/STyvupUJzo9T3ZbrutJaXGeqCEsrD48MPZSQ97qMdt1JGFCLgLqa55dNriFV
	 8nE4VDYwEY5seU+lL44dT4MVCUt/6OHy1HipnUzoDxqzsr1ApNa1oObcuF6Q2Cdo6W
	 59WxKnyf+8m9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] perf tool_pmu: Make tool PMU events respect
 enable/disable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260518201419.2943132-2-irogers@google.com>
References: <20260518201419.2943132-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 20:49:19 +0000
Message-Id: <20260518204920.22E62C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Tool PMU events (user_time and system_time) fail to update their `=
disabled` state when acting as event group members, leading to missing data=
 (reporting 0).
- [Medium] File descriptor leak in `evsel__tool_pmu_open()` error path.
--

commit 1e5a2efb24e0315c712078601af14ae8cc8be1ff
Author: Ian Rogers <irogers@google.com>

perf tool_pmu: Make tool PMU events respect enable/disable

This commit implements enable and disable support for tool PMU events
(duration_time, user_time, system_time) to make them behave more like regul=
ar
counters. It adds accumulated_time tracking to prevent the events from
counting time while paused.

Closes: https://lore.kernel.org/linux-perf-users/20260517093650.2540920-1-n=
igro.fra@gmail.com/

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 2ee87fd84d3ea..63bfb03b6b13a 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
[ ... ]
> @@ -1795,12 +1798,63 @@ int evsel__append_addr_filter(struct evsel *evsel=
, const char *filter)
[ ... ]
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
> +			if (evsel__is_tool(member)) {
[ ... ]
> +				int mem_err =3D evsel__tool_pmu_enable(member);
> +
> +				if (mem_err)
> +					return mem_err;
> +			}
> +		}
> +	}
> =20
>  	if (!err)
>  		evsel->disabled =3D false;

When evsel__enable() iterates over group members to enable them, does the
disabled flag get updated correctly for user_time and system_time events?

Since evsel->disabled =3D false at the end of this function only applies to
the group leader, it seems the group members are reliant on
evsel__tool_pmu_enable_cpu() to update their state.

> diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
> index 6a9df3dc0e076..bb398fe82f6d9 100644
> --- a/tools/perf/util/tool_pmu.c
> +++ b/tools/perf/util/tool_pmu.c
[ ... ]
> @@ -246,8 +292,8 @@ int evsel__tool_pmu_open(struct evsel *evsel,
[ ... ]
> +				if (evsel->core.attr.disabled) {
> +					evsel->disabled =3D true;
> +					*start_time =3D INVALID_START_TIME;
>  				} else {
> -					struct perf_cpu cpu;
> -
> -					cpu =3D perf_cpu_map__cpu(evsel->core.cpus, idx);
> -					err =3D read_stat_field(fd, cpu, system ? 3 : 1,
> -							      start_time);
> +					evsel->disabled =3D false;
> +					err =3D tool_pmu__read_stat(evsel, idx, thread, start_time);
> +					if (err)
> +						goto out_close;
>  				}

If tool_pmu__read_stat() fails here and jumps to out_close, is the file
descriptor we just successfully opened and saved in FD(evsel, idx, thread)
leaked?

Looking at the out_close cleanup logic:

out_close:
        ...
        do {
                while (--thread >=3D 0) {
                        if (FD(evsel, idx, thread) >=3D 0)
                                close(FD(evsel, idx, thread));
                        FD(evsel, idx, thread) =3D -1;
                }
                thread =3D nthreads;
        } while (--idx >=3D 0);

Since the loop pre-decrements the thread index, it seems to skip closing
the file descriptor for the currently failing thread.

[ ... ]
> @@ -467,10 +514,108 @@ static void perf_counts__update(struct perf_counts=
_values *count,
[ ... ]
> +int evsel__tool_pmu_enable_cpu(struct evsel *evsel, int cpu_map_idx)
> +{
> +	enum tool_pmu_event ev =3D evsel__tool_event(evsel);
> +	int thread, nthreads;
> +
> +	if (!evsel->disabled)
> +		return 0;
> +
> +	if (ev =3D=3D TOOL_PMU__EVENT_DURATION_TIME) {
> +		if (cpu_map_idx =3D=3D 0) {
> +			evsel->duration_time.start_time =3D rdclock();
> +			evsel->disabled =3D false;
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
> +			__u64 val;
> +			int err;
> +
> +			err =3D tool_pmu__read_stat(evsel, cpu_map_idx, thread, &val);
> +			if (!err)
> +				*start_time =3D val;
> +			else
> +				*start_time =3D INVALID_START_TIME;
> +		}
> +	}
> +	return 0;
> +}

Unlike the duration_time branch, it looks like evsel->disabled is not set
to false when processing user_time or system_time events here.

Will this cause evsel__tool_pmu_read() to see evsel->disabled as still true
and unconditionally return the frozen accumulated time for these members?
A similar pattern appears to be present in the disable path as well.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518201419.2943=
132-1-irogers@google.com?part=3D1
