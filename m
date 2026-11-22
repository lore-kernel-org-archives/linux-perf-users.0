Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795339369;
	b=YHHVnanMqaCNmqz1CtkMAdWv3nf/LpakQVruTSph6IDnYidrJqoTh9dz0L+fWPO2NI9E
	 GWZu7lXcGm6Z4Cro1QNqyl/OPDSVDYCN9TLqmJFvfIpyiCNEWMGKd55FYEUkB7+vQFycs
	 2x3NE4PZfNST89/QDVJzOFObPWLfp6AvZZkF0gv9c58g0KAVAubM99GyJWjbTkL6vfa+7
	 1Juysu1BbPMFrVL2G58csCiranDuUCJbPVEBbHcDMfZ4an8UChONdXoGhXkfmUKxHoLmC
	 equXQje5xF+jSrPoI2bXdxzd2aI81Q1RTqcaovDktS+qaLGg8LpVFUVySJTPTfQg58Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795339369;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=L437UHUcIIEIaXbUtzAo0AGchfEZLJuVP5PyGVGfnjw=;
	b=VeYglCJVfRaw8Jc1YX0iLf6KYalLvBKRrpHjejxPN3oOxPO3sVwFH5IQI30O55izs4QZ
	 6nn/Cofp9T5mTJlZvnqRiWD/KB29GL9bJPIenwVsTM1yE0gQ2x5IduVazCP8VTn7QDece
	 WSF0qxXWqPT3Dqbyiuun2Msh65Ah6zKZ5mXrwKXVR9Ze3ykmSxaDbUJYZbjiJrphnbld2
	 +JpPrw/GyemwvFMZY/AM1oFiQAs4Z/tFitOsNqWIQKZteQUA0KInlNyy4JzggcYsbe57T
	 cjoQtSvTUHkgcEyxe6y3+U3TGzPnRtQJMomSkMbpJtAL0mibCekmcccwPxsy1nig9qQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=omdMRaOi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA95606A320
	for <linux-perf-users@vger.kernel.org>; Sun, 22 Nov 2026 09:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=omdMRaOi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9891F000C0;
	Sun, 22 Nov 2026 09:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795339368;
	bh=L437UHUcIIEIaXbUtzAo0AGchfEZLJuVP5PyGVGfnjw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=omdMRaOihef7YI8xYJND7uqV3K0VIFJq0Pi0clpue7eZteyULZPxfKTTZT+8YB9K1
	 FKF2mQ2tlqwEyo7d6QJh6ixyeWwCZXhm4TVGbQcD7G1+fKj88zhhgZXgO1dkhq07ec
	 ZSiEjh0PeegTAPfGifqBDEe5bkaViBzA5spMgUukBgsjq7Fn1nwNuljM/CAwP9adoT
	 ppshQxQzZrKrzGBXON3ZtZKD/RX/UR9EYqGE+7HHFfzBKMcjqcUJprd2XExyyLdTKN
	 5+ZyW9gqhvxR9rqnMu6429ePyMHNka5W+VcLr62CLkYvHnRZJ82cuuQZZOQWNGH5/e
	 59kuIWdziTBig==
Message-ID: <sashiko-outbox-227849@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] perf stat: Refuse a group mixing tool and kernel
 events
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261122085947.3107661-1-takano32@gmail.com>
References: <20261111110616.2249764-1-takano32@gmail.com>
 <20261122085947.3107661-1-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 09:22:48 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] perf stat: weak group exemption in check_tool_groups() causes
  NULL deref
- [Medium] perf stat: evlist__check_cpu_maps() splits hybrid tool groups
  before check
--

commit fce47ddb742e055cde4f936f3597701fcf5103c2
Author: TAKANO Mitsuhiro <takano32@gmail.com>

perf stat: Refuse a group mixing tool and kernel events

This commit adds check_tool_groups() to refuse event groups that mix tool
events with kernel events, together with documentation and a shell test.

Link: https://lore.kernel.org/all/20261111-tool-pmu-leader-v2-1-3faa0fb98c5=
1@gmail.com/
Link: https://lore.kernel.org/all/awC_aZXD5FBGu4mO@google.com/

> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 37752d6bfef45..7396cd92346af 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -2469,6 +2469,77 @@ static int parse_tpebs_mode(const struct option *o=
pt, const char *str,
>  }
>  #endif // HAVE_ARCH_X86_64_SUPPORT
> =20
> +/*
> + * A tool event like user_time has no event in the kernel: it reads
> + * /proc/stat, or keeps its value in perf itself.  A group that mixes one
> + * with an event the kernel opens cannot be counted.
> + * get_group_fd() passes the leader's descriptor as the group fd, and the
> + * tool event has a procfs descriptor or none at all, so the kernel reje=
cts
> + * the members with EBADF or perf gives up with "broken group leader"; w=
ith
> + * a kernel event as the leader the members do open, but the group read =
is
> + * rejected as the kernel knows only the members it opened.  perf stat u=
sed
> + * to leave the rest of the group uncounted in both cases, when the CPU =
maps
> + * had not split the group first; refuse the group instead.  A group wit=
h no
> + * event the kernel opens is left alone, as perf reads each event in it.=
  A
> + * weak group led by user_time or system_time is left to the weak group
> + * handling in the open loop, which splits it when a member fails with
> + * EBADF; any other weak group is refused like a strong one.
> + */
> +static int check_tool_groups(struct evlist *evlist)
> +{
> +	struct evsel *leader, *evsel;
> +
> +	evlist__for_each_entry(evlist, leader) {
> +		struct evsel *tool =3D NULL;
> +		bool has_kernel =3D false, weak =3D false;
> +
> +		if (!evsel__is_group_leader(leader) || leader->core.nr_members < 2)
> +			continue;
> +
> +		/*
> +		 * The members of a group are not necessarily adjacent in the
> +		 * evlist: evlist__check_cpu_maps() makes a removed member a
> +		 * leader of its own without moving it, and so does a weak
> +		 * group split in the open loop.
> +		 */
> +		evlist__for_each_entry(evlist, evsel) {
> +			if (!evsel__has_leader(evsel, leader))
> +				continue;
> +			if (evsel__is_tool(evsel)) {
> +				if (!tool)
> +					tool =3D evsel;
> +			} else if (!evsel__is_non_perf_event_open_pmu(evsel)) {
> +				has_kernel =3D true;
> +			}
> +			weak |=3D evsel->weak_group;
> +		}
> +
> +		if (!tool || !has_kernel)
> +			continue;
> +
> +		/*
> +		 * A weak group led by user_time or system_time is split by the
> +		 * weak group handling in the open loop, as the kernel refuses
> +		 * the members with EBADF, and that is what :W asks for.  Any
> +		 * other weak group does not get that far, so it is refused
> +		 * like a strong group.
> +		 */
> +		if (weak && evsel__is_tool(leader)) {
> +			enum tool_pmu_event ev =3D evsel__tool_event(leader);
> +
> +			if (ev =3D=3D TOOL_PMU__EVENT_USER_TIME ||
> +			    ev =3D=3D TOOL_PMU__EVENT_SYSTEM_TIME)
> +				continue;
> +		}

[Severity: Medium]
Can a weak group led by user_time or system_time still bypass the EBADF
split in __run_perf_stat() and trigger a NULL pointer dereference of
evsel->fd?

In the kernel, sys_perf_event_open() checks security_perf_event_open() and
perf_allow_kernel() before looking up group_fd with is_perf_file(group).
If a kernel member fails there with EACCES (for example, running
perf stat -a -e '{user_time,cycles:k}:W' -- true unprivileged under the
default kernel.perf_event_paranoid=3D2, where evsel__fallback() cannot fall
back because exclude_user is set), __run_perf_stat() does not call
evlist__reset_weak_group() because it only splits on EINVAL or EBADF.

__run_perf_stat() then calls perf_evsel__free_fd(&counter->core) on the
unsupported member while leaving it attached to the user_time leader, and
evlist__enable() -> evsel__enable_cpu() -> perf_evsel__run_ioctl()
dereferences NULL evsel->fd in xyarray__max_y(evsel->fd).

[ ... ]

> @@ -2947,6 +3018,11 @@ int cmd_stat(int argc, const char **argv)
> =20
>  	evlist__check_cpu_maps(evsel_list);
> =20
> +	if (check_tool_groups(evsel_list)) {
> +		status =3D -EINVAL;
> +		goto out;
> +	}

[Severity: Medium]
On hybrid CPU systems, doesn't running evlist__check_cpu_maps() before
check_tool_groups() split all tool events out of a core PMU group under -a
before check_tool_groups() can refuse it?

On a hybrid machine (such as Intel cpu_core and cpu_atom), core PMU events
like cycles have core.cpus restricted to that PMU's CPU subset, while
duration_time has 1 CPU and user_time has all online CPUs.  Under -a,
perf_cpu_map__equal(leader->core.cpus, evsel->core.cpus) is false for both
tool events, so evlist__check_cpu_maps() removes both from the group and
reduces leader->core.nr_members to 1.  check_tool_groups() then sees no
group left to refuse, and the new test case in stat+tool_group.sh:

  refused '{cycles,duration_time,user_time}' 'user_time|duration_time' -a

exits 0 and fails on hybrid machines.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122085947.3107=
661-1-takano32@gmail.com?part=3D1
