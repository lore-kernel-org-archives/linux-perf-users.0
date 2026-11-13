Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794614371;
	b=Px2HLDYbR4mGYWUtBu7oEaut9ZTSxhI0ygcfjrjyUiJ8cDkiyV/aZbHmZXNy0wOPQV1/
	 SOa05DNieqiY6Lsdj0EeNE51IPp4YQgLVAES9pEszayyQNUDA4+2O1AJGOB0+IklRm46z
	 S6ThzWeO1wEML5IRi82BbnULZF0pViEUud6/Hc/UsSgZf4/6ZFftK9lPcfumjHzIKWztI
	 mS2IqU6Xhu89sx9Sl+vr5q4LO0k+0IHVbPxbYJ3MV7VcPH+AfbvnQUwecCZuRlI+lx83N
	 xdn+am506zJSuBixoq9hYgOB3fsIswphZj7RDXpqOcPgFa5bjN9U8c+FuwFzTB/+rmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794614371;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6sZGzRiDRNVYI81baNr7b70cMgCmiNPGYq+c8Wb7B8I=;
	b=YJO0XWM/5FKDhcDz+y1EoFl2fMNbUKmrdjXpG1TWcecirx6SMwqwoDKBYdHwL7bUTj3Y
	 mEBTUx4j8wMi3i90WRZ/y8Avy+4MkS0q5zC9xfsmlRJcMR4G6ut/DcpFoT5SLnV66RDWN
	 B4JCGJyJKO0DH4BapRBEyKRy4X9VEJ7xCc88lxQaIG1skmcTf52YzdnhTHjubKsFUhcy3
	 5nQwibJrVeW+Fgs+kB+rioa1w5mA6Du9vw8Z5LLCq+bP2v6TG34CXNrOaovutrSHYnf6O
	 3kbCx8acOWzTzByC0YQthS6qio+uJrIblc4fjAy3NxIfZcYFWzeydLECfxOThzGn36g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LXzKtolj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DD5606A89F
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 23:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LXzKtolj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D50C1F000C4;
	Fri, 13 Nov 2026 23:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794614371;
	bh=6sZGzRiDRNVYI81baNr7b70cMgCmiNPGYq+c8Wb7B8I=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=LXzKtoljeferCe2FGS44hc65Z/mIVrtV/MnQzxO7klVqEDwlTCGUUOckaL078aFVG
	 +tUEVFtk/qKLriYFm4Q3UZbHEDtXSQKAztPQhBlFOph59aGi2VAGlvtVC2yEgu6DYc
	 1//hU4OK6RqJsMZuMf2a+nveHjAAdQeIkea0AKtKFObWvvjNYqKhqa6snrxQ7VhoeR
	 7IMH22AV3xscZHV/MEm6PGTcshd4h7plDc3NACFTiZebS3RurLMPslPe8pXKws7lWV
	 u5DgI3aFb9myVk48/jMXF4MbzX4PzIsHCtUN2qRvK/GTub/CzJyTNvJOXMuYr9pDzl
	 d5GE9K/DjkPpA==
Message-ID: <sashiko-outbox-213890@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] perf tool_pmu: Add network events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261113233739.3626499-3-irogers@google.com>
References: <20261113233739.3626499-1-irogers@google.com>
 <20261113233739.3626499-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 23:59:30 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] perf tool_pmu: grouped tool events stay disabled when
  enable_on_exec is set
--

commit 8a5f1d91c8102e028647607058772cadeb3a4c93
Author: Ian Rogers <irogers@google.com>

perf tool_pmu: Add network events

This commit adds system-wide network tool PMU events read from /proc/net/dev
and updates tool PMU enable, disable, and group leader handling.

> diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
> index 0ae08cd910bc4..655b221043201 100644
> --- a/tools/perf/util/tool_pmu.c
> +++ b/tools/perf/util/tool_pmu.c
[ ... ]
> @@ -539,40 +676,58 @@ static int open_memory_pid_dir(enum tool_pmu_event =
ev, int pid,
>  	return 0;
>  }
> =20
> +static bool tool_pmu__is_initially_disabled(const struct evsel *evsel)
> +{
> +	const struct evsel *leader =3D evsel__leader(evsel);
> +
> +	return evsel->core.attr.disabled || (leader && leader->core.attr.disabl=
ed);
> +}
> +
>  static int evsel__tool_pmu_open_one(struct evsel *evsel, enum tool_pmu_e=
vent ev,
>  				    int pid, int idx, int thread,
>  				    int *seen_tgids, int *nr_seen_tgids)
>  {
[ ... ]
> -		if (evsel->core.attr.disabled) {
> +		if (tool_pmu__is_initially_disabled(evsel)) {
>  			evsel->disabled =3D true;
>  			*start_time =3D INVALID_START_TIME;
>  		} else {

[Severity: Medium]
Does tool_pmu__is_initially_disabled() leave grouped tool events permanently
disabled when profiling a forked workload?

When target__enable_on_exec(&target) is true (for example, perf stat -e
'{cycles,duration_time}' -- <workload>), create_perf_stat_counter() sets bo=
th
attr->disabled =3D 1 and attr->enable_on_exec =3D 1 on the group leader:

tools/perf/builtin-stat.c:create_perf_stat_counter() {
	...
	if (evsel__is_group_leader(evsel)) {
		attr->disabled =3D 1;

		if (target__enable_on_exec(&target))
			attr->enable_on_exec =3D 1;
	}
	...
}

With this change, tool_pmu__is_initially_disabled() returns true for the
grouped tool event, so evsel__tool_pmu_open() and evsel__tool_pmu_open_one()
set evsel->disabled =3D true and start_time =3D INVALID_START_TIME. Because
enable_counters() skips evlist__enable() when target__enable_on_exec(&targe=
t)
is true and userspace tool events have no kernel exec hook, evsel->disabled
remains true for the entire run and perf stat reports 0 for the grouped tool
counter.

Checking !leader->core.attr.enable_on_exec (and !evsel->core.attr.enable_on=
_exec)
in tool_pmu__is_initially_disabled() would avoid leaving these counters
disabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113233739.3626=
499-1-irogers@google.com?part=3D2
