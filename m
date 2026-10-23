Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792747369;
	b=A6gSeJURm7FYioBK4308K34ncqpQdB17Mec1GgL2bbZDQx7gJxp9cqNvwnmuDcDBotir
	 IyxmseH7Xbq9gP4sz9yprusFyjhtMbNW/VsTBE9L4OyWgY9p6kBLvMHzf1TAio0Um2RN/
	 KXJ8pBMy0Z8UJg50Pq/Ot11n4D9B8u2YLw3YJxZGwelvmKoF8+mfGdZxPczM2FfMDsQoP
	 3M8Cb0X4hvVJ3bXsAwQ0hdew+yIDqj83PHDAMaDWYJvakbCCFN1HjQ1jou8DX1j4UN9fp
	 1mxBANOqeMSqh92Q8aFadriM4+w8/6FVgdmu2vxuxrfn3iUY2gaEExFtQLmFCmZOx2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792747369;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3n/MeGHffQWx1T9efnbXF6DwxtAKMZNMJuDqPOcgG6g=;
	b=LIm3dekrMsXlFekgbiiwFjZAHW24pSwEv3+jtYNpDM7Enje7FuS2Y91F3HrBqHq8LsVz
	 6xMZ+nlKW4UEqKQUU+i9BYBkNqwZdXYbWYFfu91lqFKB9pEX1H08rLf8TPy2mg5ajJfLV
	 4PxFnrlQXCZ5/jW5VAsn1KO/xm2mVtzhQsa8RiYmJK2XrAR2ig2/0+jX7HVaz4hxCZFrI
	 +TofqzMYuwZE4cLici71hLrkGCWQ1S3ITkhGaXcFcMDoxtrZytsm6Djca4e9QVayANs8m
	 FIPvSt5fC5Uunvd0oOg8zUYVNDa/gNxpa3HZ8d17c4mduCovlVhAAKS+6CkSrGnrBQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NvFpXI8B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE1D606A31D
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 09:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NvFpXI8B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D31011F01828;
	Fri, 23 Oct 2026 09:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792747369;
	bh=3n/MeGHffQWx1T9efnbXF6DwxtAKMZNMJuDqPOcgG6g=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=NvFpXI8BIhjPgU/Y0+tVwH9j+DrVz0N4jkbednXaGP8O9nyATuuBTkHvtyNLmD+15
	 6Qsia7fsD9BoLyFf8f+7reHp8ewfZpKI2cTsxXGRpIaDrBZUoFKU03g5lBNot93MzV
	 Z01r+kL3Xem2kMbWcY1K2lxDACOJtsZ166sWVvSlwfJaf/j7iGrgHLk/exBGPT2XHi
	 rSWx4GngugSYxlDdLRts02SxRFefKjOFz3EZ/jU4BViOId93SEMWzQviRLFPpWccRq
	 00TgJnHmwTe2Js6nZnBzJFxu8RXcdsyJS+Hs56tKzM/sidc7fP6MF9tXxcClVH8ZDc
	 0E/XStu44FgUw==
Message-ID: <sashiko-outbox-182579@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf stat: Start tool events when enable_on_exec is
 used
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261023085554.1694434-1-takano32@gmail.com>
References: <20261022024919.263876-1-takano32@gmail.com>
 <20261023085554.1694434-1-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 09:22:48 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf stat: NULL deref in enable_counters() on unsupported tool e=
vent
- [Medium] perf stat: inaccurate mixed group enable_on_exec handling and NU=
LL fd crash
--

commit 3216cd73e8c11e372e4510bb56208ee17997bddb
Author: TAKANO Mitsuhiro <takano32@gmail.com>

perf stat: Start tool events when enable_on_exec is used

This commit starts emulated tool events explicitly via
evsel__tool_pmu_enable() in enable_counters() when target__enable_on_exec()
is true, avoiding calling evsel__enable() on mixed PMU groups.

> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index c50cf230f16ed..ca4483f34addb 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -510,6 +510,18 @@ static int enable_counters(void)
>  	if (!target__enable_on_exec(&target)) {
>  		if (!all_counters_use_bpf)
>  			evlist__enable(evsel_list);
> +	} else {
> +		/*
> +		 * Tool events are emulated in perf, so enable_on_exec above
> +		 * does not start them.  Do not go through evsel__enable(),
> +		 * which would also enable the members of a mixed PMU group
> +		 * the kernel already handles.
> +		 */

[Severity: Medium]
Is this comment and the commit message's explanation of mixed PMU groups
accurate?

When running a mixed group led by a tool event such as
perf stat -e "{user_time,cycles}" -- sleep 0.1,
parse_events__sort_events_and_fix_groups() keeps both events in the same
group because perf_pmu__is_software() returns true for PERF_PMU_TYPE_TOOL
in evsel__compute_group_pmu_name().

During __run_perf_stat(), evsel__tool_pmu_open() stores the procfs fd in
FD(user_time, idx, thread). When opening the member cycles in
evsel__open_cpu(), get_group_fd() in tools/perf/util/evsel.c does not check
evsel__is_non_perf_event_open_pmu(leader):

tools/perf/util/evsel.c:get_group_fd() {
	...
	fd =3D FD(leader, cpu_map_idx, thread);
	BUG_ON(fd =3D=3D -1 && leader->supported);
	...
	return fd =3D=3D -1 ? -2 : fd;
}

For user_time or system_time, get_group_fd() passes the procfs fd as
group_fd to sys_perf_event_open(), which fails with -EINVAL, sets
cycles->supported =3D false, and causes __run_perf_stat() to free
cycles->core.fd to NULL via perf_evsel__free_fd(). (For
"{duration_time,cycles}", FD(duration_time, 0, 0) is -1 while
duration_time->supported is true, hitting BUG_ON(fd =3D=3D -1 &&
leader->supported) in get_group_fd().)

Additionally, in create_perf_stat_counter() in tools/perf/builtin-stat.c:

	if (evsel__is_group_leader(evsel)) {
		attr->disabled =3D 1;

		if (target__enable_on_exec(&target))
			attr->enable_on_exec =3D 1;
	}

attr->disabled and attr->enable_on_exec are only set on the group leader.
Because of this:

1. Kernel members under a tool group leader do not have enable_on_exec set,
   and their fds are NULL here because sys_perf_event_open() failed with
   -EINVAL in get_group_fd(), rather than being unavailable in this process
   or started by the kernel on exec.

2. Tool members under a kernel group leader (for example,
   "{cycles,duration_time}" or "{cycles,user_time}") have attr->disabled =
=3D=3D 0,
   so evsel__tool_pmu_open() sets evsel->disabled =3D false and starts
   counting immediately at open time rather than when enable_counters()
   runs.

3. Because this patch only avoids evsel__enable() in the
   target__enable_on_exec(&target) branch of enable_counters(),
   evsel__enable_cpu(), evsel__enable(), evsel__disable_cpu(), and
   evsel__disable() in tools/perf/util/evsel.c still iterate over
   for_each_group_member(member, evsel) without checking member->core.fd !=
=3D
   NULL, which will still dereference a NULL member->core.fd in
   perf_evsel__run_ioctl() -> xyarray__max_y(evsel->fd) whenever
   !target__enable_on_exec(&target) or !target__none(&target) is true (such
   as with -a, -C, -p, -t, or -D).

Should mixed group opening in get_group_fd(), member attribute setup in
create_perf_stat_counter(), and NULL core.fd checks in the evsel
enable/disable helpers be addressed instead?

> +		evlist__for_each_entry(evsel_list, evsel) {
> +			if (evsel__is_tool(evsel) &&
> +			    !evsel__tool_pmu_enable(evsel))
> +				evsel->disabled =3D false;
> +		}

[Severity: Medium]
Can this loop dereference a NULL evsel->core.fd when a tool event is
unsupported?

Before calling enable_counters(), __run_perf_stat() in
tools/perf/builtin-stat.c frees counter->core.fd (setting it to NULL) for
any unsupported event:

	evlist__for_each_entry(evsel_list, counter) {
		if (!counter->supported) {
			perf_evsel__free_fd(&counter->core);
			continue;
		}

Unlike __evlist__enable() (which checks !pos->core.fd) and
read_counter_cpu() (which checks !counter->supported), this loop calls
evsel__tool_pmu_enable(evsel) without checking evsel->supported or
evsel->core.fd.

In evsel__tool_pmu_open() in tools/perf/util/tool_pmu.c:

				if (evsel->core.attr.disabled) {
					evsel->disabled =3D true;
					*start_time =3D INVALID_START_TIME;

evsel->disabled is set to true as soon as an entry is opened with
attr.disabled =3D=3D 1, and out_close does not reset evsel->disabled if a f=
ailure
occurs.

When target__enable_on_exec(&target) is true, a user_time or system_time
event can end up with evsel->disabled =3D=3D true, evsel->supported =3D=3D =
false,
and evsel->core.fd =3D=3D NULL (for example, if a weak group "{user_time,cy=
cles}:W"
resets and fails to reopen user_time on the second pass, if a later CPU ind=
ex
fails to open when evlist__has_bpf_output() is true, or across repeat runs
after --control disables counters).

When that happens, evsel__tool_pmu_enable() -> evsel__tool_pmu_enable_cpu()
-> tool_pmu__read_stat() evaluates FD(evsel, cpu_map_idx, thread) and
dereferences evsel->core.fd =3D=3D NULL.

Should this check evsel->supported (or evsel->core.fd) before calling
evsel__tool_pmu_enable(evsel)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023085554.1694=
434-1-takano32@gmail.com?part=3D1
