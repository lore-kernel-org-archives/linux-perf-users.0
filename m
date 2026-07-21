Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494153CB2E0
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 23:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784676262; cv=none; b=J26Nv2U8Y9L5dLLZLaVLP39FKw/7JODnwYEXFDL1q5b6owx70NX2FwiByOdvrAPWd2WDp7UVRkGI4A29pGWQS4X9llQVNGhwu+dMkCwifoEQbTeeq9YPrPH4Cc7RVWgyn2ZQfafeb3Pa8lXc2jpAHo/QKB6ObPwkG7aZ6RXMoDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784676262; c=relaxed/simple;
	bh=EVuhl2UKMcADVXT8gE3WdKpDJwIN2kPnFtYNL0Mz1jU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=inZPNmsGBjy1qgp7j6f6uQRuXt+M2XMSf1kW2VxEHgq4aq1idCiI/Twc9O1TNW9Ol0NaMy13DEUqnSyxQ6yRpGl3VPLfESZIEuyXGK+OThvKVDePzi96MNGeny5pFknfNbJZvDrPUeU1vrvZS7+ahRfaBjQ6a9MauZMzslmeYNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=To5LwMjg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="To5LwMjg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B541F000E9;
	Tue, 21 Jul 2026 23:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784676260;
	bh=D4QuKDVNQ8Cqq7dO+ZOtELrR1bmY+VkbxWU7xWiTJUk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=To5LwMjgaBlk5Zn4Yen43FCoAstA7D+Oom7ui7ljdT18ZgHh8ee8BbLFl6ttOQUY1
	 KFoIztzFpboVT3vwrGxuo16KRJMoJ7qhRZj26JmNP4v97EXH+rmSo+6EDA8q49Y/OV
	 4myT36FKs4N4VqmvrI2CZuDi0ehDnTQJffh6kMiW0Sy2XPNzpXWeMG2PmWQjb7Lwoe
	 gYDe3Gfwveu52Da9FDAHmwbu/iz94Wt78sUI/9HS2KpfJTtHmBD+bRWUavz2UUF+4G
	 EQMnwSLY/FQv8BSLoGv3GO8TKAZZD6gdW0u4HZC89gCa7LosC1WYAdHh2yYcwjckD/
	 w7LtL/g1d0AoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/4] perf synthetic-events: Fix line synchronization,
 bounds, and truncation bugs in proc maps reader
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260721230952.267754-3-irogers@google.com>
References: <20260721205746.183206-1-irogers@google.com>
 <20260721230952.267754-1-irogers@google.com>
 <20260721230952.267754-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 23:24:20 +0000
Message-Id: <20260721232420.B1B541F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Stack buffer overflow in `perf_event__synthesize_cgroup` due to ou=
t-of-bounds null byte padding.
--

--- Patch [2]: [PATCH v6 2/4] perf synthetic-events: Fix line synchronizati=
on, bounds, and truncation bugs in proc maps reader ---
commit 23e7a3b35e7f0fff60a5a4e566945538124d1c0f
Author: Ian Rogers <irogers@google.com>

perf synthetic-events: Fix line synchronization, bounds, and truncation bug=
s in proc maps reader

This commit addresses logic and boundary bugs in read_proc_maps_line() and
its caller. It handles parsing failures by draining lines appropriately and
secures truncated entries by extracting pathnames within safe bounds.

> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthet=
ic-events.c
> index 5307d707711d8..e9952c27b3bc0 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
[ ... ]
> @@ -579,7 +658,8 @@ static int perf_event__synthesize_cgroup(const struct=
 perf_tool *tool,
> =20
>  	event->cgroup.id =3D handle.cgroup_id;
>  	strncpy(event->cgroup.path, path + mount_len, path_len);
> -	memset(event->cgroup.path + path_len, 0, machine->id_hdr_size);
> +	memset((char *)event + offsetof(struct perf_record_cgroup, path) + path=
_len,
> +	       0, machine->id_hdr_size);
> =20
>  	if (perf_tool__process_synth_event(tool, event, machine, process) < 0) {
>  		pr_debug("process synth event failed\n");

[Severity: High]
This is a pre-existing issue, but can this code path trigger a stack buffer
overflow when aligning the path string?

In perf_event__synthesize_cgroups(), the path buffer is allocated on the st=
ack:

tools/perf/util/synthetic-events.c:perf_event__synthesize_cgroups() {
	...
	char cgrp_root[PATH_MAX];
	...
}

This buffer is passed as path and recursively appended to in
perf_event__walk_cgroup_tree(), which allows the length to reach
PATH_MAX - 1:

tools/perf/util/synthetic-events.c:perf_event__walk_cgroup_tree() {
	...
		/* any sane path should be less than PATH_MAX */
		if (strlen(path) + strlen(dent->d_name) + 1 >=3D PATH_MAX)
			continue;
	...
}

When this path is then passed into perf_event__synthesize_cgroup(), the
following loop aligns path_len to an 8-byte boundary:

tools/perf/util/synthetic-events.c:perf_event__synthesize_cgroup() {
	...
	while (path_len % sizeof(u64))
		path[mount_len + path_len++] =3D '\0';
	...
}

If strlen(path) is exactly PATH_MAX - 1, and path_len is not a multiple of =
8,
will this loop write null bytes past the end of the cgrp_root stack buffer?

It appears that an attacker with permissions to create nested cgroups could
create a directory path of exactly the required length. When an administrat=
or
runs perf with cgroup synthesis enabled, could this overflow trigger and
potentially overwrite adjacent stack variables or control data, providing a
vector for local privilege escalation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721230952.2677=
54-1-irogers@google.com?part=3D2
