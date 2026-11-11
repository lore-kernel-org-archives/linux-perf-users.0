Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794371176;
	b=C6u7bQLH2SKJENnlpIi8QYn/W94yctIUQkMjolTlG8DOnwHwMFE1J/liGSTCbXhXsA+Q
	 sj4Wz6maFubzYsAZBwod7lRL0NN62SGCPsNFAzLqDdUeGwmFOnXHkYFKYEpSoip5kkEun
	 007Jt5h6WjvPWrymaWrSVxye+fuvKgQQ1S+k/jGdWbOPZ5DO4PQ39Pho1cz9nCbnJywp5
	 Vbj8Fl+l3fdNeOCxBrxMBphONFvaSNK57boBM+/ElXaJhijqfqOlvkUexh0nrqX8aCoba
	 vDhOoyx+OkkKZxHymxJ0FzAsWW6LGM7X+2UFawyY2vdPSEveWAZYqaAxLrOLI0hWK7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794371176;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=81TdySQZ/9OYpjfph7PdM5uvra8vYVz2PR8LFmLfu2M=;
	b=SP0gVm5x3oJpB270OpV+0BoeYsUHDbnwsWSCg6gTk6IqrN/bnMIVXUCpODgdFEvP2kNF
	 2zv4dlj22nnQ6LZU9dZN1NZZ+S939Fov2ApqCl5driemm6V681l06ob9CEnwxI58tD4oO
	 pKOwvN7zX4BPICNbM3apruXUIQMe9K6bZChXM5/S+DLR4/kqZz43PI3Hf/CAAC4YuaGzF
	 umlCxuCgfBYiaOfF7M9QGe9mQJFWf6dVyYjhgTuyD1ISZkjOYwjS57s0YQJZWnLnzBMje
	 Z04LGm1n/nCsSts+oJhuqZTzB0GWdS32IWlxKYlcRvURRYkStnpgn1Zgh+HMSTzbP5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JbiQBKvx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7CC60A3808
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 04:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JbiQBKvx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF221F00A09;
	Wed, 11 Nov 2026 04:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794371176;
	bh=81TdySQZ/9OYpjfph7PdM5uvra8vYVz2PR8LFmLfu2M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JbiQBKvxAv+E/8orga2ln3k/NagWPiWc5b90o84Xm8MXwKmf6VbhlietCy8wRMSkU
	 E8pUYBCXk22RNc6CbTJfqqA0q8H5VEa8+GiMdG8/ccsbSw6F6kzUH+v1+c6F/Dbj96
	 wYBL8C1U+guHIjziT3Ik9jCfhrDrNnPRBtsh3anKbDSKe/Ptl2640YOdHeeOSHGffe
	 XmCJR5Xz4p5bxEOhTR07iwdgpg4ytQGXQk4JQ9sKJ5vwRALlQkRohijyFdtyW2gqkC
	 mXm04V165wUA8SbdPDcxLE2DW8JaRPq8ylR3bpHyd2Y6inhaH5gcvN36HnFF2ew4pq
	 h3psUyhseFeXg==
Message-ID: <sashiko-outbox-208283@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf stat: Count kernel events in a group led by a tool
 event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hang Zhengyang" <hang.zhengyang1010@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261111-tool-pmu-leader-v1-1-6173b5569f59@gmail.com>
References: <20261111-tool-pmu-leader-v1-1-6173b5569f59@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 04:26:15 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] perf stat: missing disabled/enable_on_exec in
  create_perf_stat_counter()
- [Medium] perf evsel: get_group_fd() ignores !leader->supported for
  userspace PMU
- [Medium] perf stat: incomplete enable/disable for members under tool
  leader
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [Medium] perf stat: mixed group read and disabled flaw in
  create_perf_stat_counter() [1]
--

commit 498a1414507f8fb0fa9be7cd1e97fec9e69bc393
Author: Hang Zhengyang <hang.zhengyang1010@gmail.com>

perf stat: Count kernel events in a group led by a tool event

This commit opens kernel member events with group_fd =3D -1 and omits
PERF_FORMAT_GROUP when their group leader is a non-perf_event_open PMU
event, allowing them to be opened and read individually.

> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 37752d6bfef45..59890916dcc4a 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -721,7 +721,7 @@ static int create_perf_stat_counter(struct evsel *evs=
el,
>  	 * the group read (for leader) and ID retrieval for all
>  	 * members.
>  	 */
> -	if (leader->core.nr_members > 1)
> +	if (leader->core.nr_members > 1 && !evsel__is_non_perf_event_open_pmu(l=
eader))
>  		attr->read_format |=3D PERF_FORMAT_ID|PERF_FORMAT_GROUP;
> =20
>  	attr->inherit =3D !config->no_inherit && list_empty(&evsel->bpf_counter=
_list);

[Severity: Medium]
Should create_perf_stat_counter() (and evsel__config()) also set
attr->disabled =3D 1 and attr->enable_on_exec =3D 1 when
evsel__is_non_perf_event_open_pmu(leader) is true?

tools/perf/builtin-stat.c:create_perf_stat_counter() {
	...
	if (evsel__is_group_leader(evsel)) {
		attr->disabled =3D 1;

		if (target__enable_on_exec(&target))
			attr->enable_on_exec =3D 1;
	}
	...
}

Because non-leader members of a group led by a tool event have
evsel__is_group_leader(evsel) =3D=3D false while get_group_fd() now returns
-1, sys_perf_event_open() opens them as standalone kernel events with
attr->disabled =3D 0 and attr->enable_on_exec =3D 0.  This regression causes
those counters to start counting immediately inside sys_perf_event_open(),
recording events during setup, across initial delays (-D), and before
execvp() when profiling a child workload.

[Severity: Medium]
This problem wasn't introduced by this patch, but when a kernel PMU event
leads a mixed group containing a tool PMU member [1], does
PERF_FORMAT_GROUP still fail to read the group?

evsel__group_read_nr_members() and evsel__group_has_tpebs() only exclude
retire_lat events and do not exclude evsel__is_non_perf_event_open_pmu()
members, so evsel__group_read_size() and evsel__process_group_data()
expect more members than the kernel group contains and fail the read.  In
addition, because create_perf_stat_counter() only sets attr->disabled =3D 1
on the group leader, a subordinate tool PMU member opens with
attr->disabled =3D 0 in evsel__tool_pmu_open() and begins timing immediately
before evlist__enable() runs.

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 560741d9599d2..5a919303562a0 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2378,6 +2378,10 @@ static int get_group_fd(struct evsel *evsel, int c=
pu_map_idx, int thread)
>  	if (!evsel->supported || evsel__is_group_leader(evsel))
>  		return -1;
> =20
> +	/* A userspace PMU leader has no perf event to group with */
> +	if (evsel__is_non_perf_event_open_pmu(leader))
> +		return -1;
> +
>  	/*
>  	 * Leader must be already processed/open,
>  	 * if not it's a bug.

[Severity: Medium]
What happens in get_group_fd() if the userspace PMU leader failed to open
and leader->supported is false?

Returning -1 instead of -2 bypasses the broken-leader check in
evsel__open_cpu(), so the member events still open with core.leader
pointing to the unsupported leader.  In perf stat, __run_perf_stat() frees
leader->core.fd and in perf record (e.g. perf record -e
'{user_time,cycles}'), record__open() removes the failed leader via
evlist__remove(), while __evlist__enable() and __evlist__disable() skip
the non-leader members and leave them impossible to enable or disable.

[Severity: Medium]
Can kernel members on CPUs 1..N-1 be enabled or disabled when the group
leader is a tool event like duration_time?

perf_pmu__reads_only_on_cpu_idx0() is true for duration_time, so
__perf_evlist__propagate_maps() restricts leader->core.cpus to CPU index 0
while kernel members keep all target CPUs.  Because __evlist__enable() and
__evlist__disable() skip non-leader events (!evsel__is_group_leader(pos))
and only delegate to members from evsel__enable_cpu() and
evsel__disable_cpu() on the leader's CPUs, member counters opened on CPUs
1..N-1 are never enabled or disabled.

[1] https://sashiko.dev/#/bug/linux-ff5d792a-1b0a-41d1-9760-725926f4f860

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-tool-pmu-l=
eader-v1-1-6173b5569f59@gmail.com?part=3D1
