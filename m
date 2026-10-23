Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792747204;
	b=CRBKtHBX291FlnrK6WAwnk4+2+wia94Kh0VO9pF6UKRPF7koXvMThwTVyDt0GyK5BcVD
	 IMRhiyC3A3LWjoX/r9DFUl5heRUm/xX7071Qvl05XB2liDgsC3u6u7HcChqL5qZ3Vax6i
	 /u+lGWMaCbuKwCMGZfumeYeysae6LQVmSu4aL+cCQZoH/Eo3wLcvEt6ZjHwVYmAuuaWV8
	 bLJ20C9qz1Lkx8V7baVtcVIN8yx9A6At806+aivPa6mY3C42YnLbPtoDHHzl9II4OzSUQ
	 6AJNkwNdnPTeUb6P3ra/8ENou4dPn1vd7zxo+GRnTdMSjvWIy816Ruq30HQ2m+Jq/NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792747204;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JrzGu4Ii4XxLdeuYDfuSqy5HU0jVTrqPS41e6J9XUYs=;
	b=m6+vyugDm7TRhrbOK9cnp9jV/N+7it+ROPxnMjGRVDT1Y1WFisxtPE8V+3p1xMnKBuwn
	 rKuY1x8715FVARNHaklTuCQxCkqEMgsRGtv4CK5CEMIdealkjCl8WpH/UXBoTrOESA4ez
	 GTWnETkO95NNPujGzCoxe91n8NzDs+xZAs6E06/sjwJw9zTwhNKhjt/ncL0tQviRLfuMX
	 rb40vxwAeS79yFW+azxB4X+rnRWHFE3wrzc/92K0fkA048j9fl2X5vs1OmbZblXqmBJBE
	 UqxJusUFVrIFlg5/7gvVn9IBkXkVE/XPSlJIPh7H+gmOYAHqtJb4p2RjigTzo90UcTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jp63EfHs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0E1606A31B
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 09:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jp63EfHs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FACC1F01825;
	Fri, 23 Oct 2026 09:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792747203;
	bh=JrzGu4Ii4XxLdeuYDfuSqy5HU0jVTrqPS41e6J9XUYs=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=jp63EfHs2Ez+zXTpHYlQEEILG2WMClJYLgJT3d1qfDGPWZGqYS7MGPiuJvBeRJ/YF
	 mJeenrwO2K1B3CDwKRJ/MCjKlq0Ls/cF++q3mU8zvX2+bgZRd3F/gxTboLue5V3svq
	 PigXnrZ1dGZa1Vm4mdfDF+0IYej0vT5I343joYXNfqWu/Ep5oiEZ4mL4RqPjb+g9i5
	 OmGHAlNRXl5MVUZeqDQVIW4lHAq5TuW0E/AaaPoXERbJd5LGmvZ/V9vP+dPRBOefnB
	 HMHHLcG12czx8bO3aOEdi+Zro8PEDExzcJb/vGm/l2s6Zrq6s0LRUzomvdZgYuPe5j
	 bJS86DxPylfGw==
Message-ID: <sashiko-outbox-182570@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf evsel: Skip group members without fds when walking
 a group
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261023085629.1694941-1-takano32@gmail.com>
References: <20261023085629.1694941-1-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 09:20:03 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf evsel: incomplete fix in evsel__enable_cpu() for tool PMU g=
roups
--

commit 9f4b8cfeed3bb333c7e55d36118aab80f6b77164
Author: TAKANO Mitsuhiro <takano32@gmail.com>

perf evsel: Skip group members without fds when walking a group

This commit skips group members that have a NULL core.fd pointer when
enabling or disabling event groups in evsel__enable_cpu(), evsel__enable(),
evsel__disable_cpu(), and evsel__disable() to avoid a segmentation fault wi=
th
tool-PMU-led event groups.

>     perf evsel: Skip group members without fds when walking a group
>    =20
>     A group led by a userspace PMU event and containing kernel events is
>     opened with group_fd =3D -1 for the members, because the kernel cannot
>     group a userspace PMU with a kernel one.  The members are therefore
>     enabled from userspace when the leader is enabled, but their fd array=
 is
>     not set up in that case, so perf_evsel__enable_cpu() dereferences a N=
ULL
>     pointer:
>    =20
>       $ perf stat -a -e '{user_time,cycles}' -- sleep 0.05
>       Segmentation fault
>    =20
>       $ perf stat -a -e '{system_time,cycles}' -- sleep 0.05
>       Segmentation fault
>    =20
>     Only the leaders of such a group are opened with an fd in this path.
>     Skip the members that have no fd, the same way __evlist__enable() ski=
ps
>     leaders without one, in the four loops that walk the members of a gro=
up.
>    =20
>     Verified on an Ampere Altra (arm64, Neoverse-N1) with a perf built fr=
om
>     this tree: the two commands above segfault before the change and print
>     user_time/system_time after it, while plain groups such as
>     '{cycles,instructions}', 'perf stat' with no event and '-r 2' are
>     unchanged.
>    =20
>     Fixes: 0b18bced5444 ("perf tool_pmu: Make tool PMU events respect ena=
ble/disable")
>     Assisted-by: LLM
>     Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index d4cb455f4a7d4..32c54cd4acf0b 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1882,6 +1882,8 @@ int evsel__enable_cpu(struct evsel *evsel, int cpu_=
map_idx)
>  		struct evsel *member;
> =20
>  		for_each_group_member(member, evsel) {
> +			if (!member->core.fd)
> +				continue;

[Severity: Medium]
Does skipping !member->core.fd here mask an earlier open failure in
evsel__open_cpu() -> get_group_fd() rather than allowing the kernel member
event to open with group_fd =3D -1?

The commit message states that a group led by a userspace PMU event and
containing kernel events is opened with group_fd =3D -1 for the members, and
that their fd array is not set up in that case.

However, looking at how '{user_time,cycles}' or '{system_time,cycles}' is
opened:

1. When user_time or system_time leads the group, evsel__tool_pmu_open() in
tools/perf/util/tool_pmu.c opens /proc/stat (or /proc/<pid>/stat) and stores
that procfs file descriptor in FD(leader, idx, thread).

2. When the kernel member event cycles is opened in
tools/perf/util/evsel.c:evsel__open_cpu(), __evsel__prepare_open() allocates
cycles->core.fd and then evsel__open_cpu() calls get_group_fd():

tools/perf/util/evsel.c:get_group_fd() {
	struct evsel *leader =3D evsel__leader(evsel);
	int fd;

	if (!evsel->supported || evsel__is_group_leader(evsel))
		return -1;

	BUG_ON(!leader->core.fd);

	cpu_map_idx =3D evsel__hybrid_group_cpu_map_idx(evsel, cpu_map_idx);
	if (cpu_map_idx =3D=3D -1)
		return -1;

	fd =3D FD(leader, cpu_map_idx, thread);
	BUG_ON(fd =3D=3D -1 && leader->supported);

	return fd =3D=3D -1 ? -2 : fd;
}

3. Because get_group_fd() does not check
evsel__is_non_perf_event_open_pmu(leader) to return -1, it returns the
leader's /proc/stat file descriptor as group_fd to evsel__open_cpu():

tools/perf/util/evsel.c:evsel__open_cpu() {
	...
	group_fd =3D get_group_fd(evsel, idx, thread);
	...
	fd =3D sys_perf_event_open(&evsel->core.attr, pid, cpu.cpu,
				group_fd, evsel->open_flags);
}

4. sys_perf_event_open() then fails with -EBADF because group_fd is a procfs
file descriptor rather than a perf_event file descriptor. That failure leav=
es
cycles->supported =3D false, causing __run_perf_stat() in
tools/perf/builtin-stat.c to free cycles->core.fd:

tools/perf/builtin-stat.c:__run_perf_stat() {
	evlist__for_each_entry(evsel_list, counter) {
		if (!counter->supported) {
			perf_evsel__free_fd(&counter->core);
			continue;
		}
}

With this patch, cycles still fails to open and is reported as
<not supported> instead of being opened with group_fd =3D -1 and enabled fr=
om
userspace as intended by commit 0b18bced5444 ("perf tool_pmu: Make tool PMU
events respect enable/disable").

Furthermore, if duration_time leads the group (for example,
perf stat -a -e '{duration_time,cycles}' -- sleep 0.05),
evsel__tool_pmu_open() succeeds and sets leader->supported =3D true while
leaving FD(leader, cpu_map_idx, thread) =3D=3D -1, which triggers
BUG_ON(fd =3D=3D -1 && leader->supported) in get_group_fd() before
evsel__enable_cpu() is ever reached.

Should get_group_fd() check evsel__is_non_perf_event_open_pmu(leader) and
return -1 so that kernel members in a tool-PMU-led group actually open with
group_fd =3D -1?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023085629.1694=
941-1-takano32@gmail.com?part=3D1
