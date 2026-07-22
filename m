Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF95721FF25
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 00:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784679010; cv=none; b=pN19OL6hyZWCaoDQlr3xaHdbsHrI+sf8JTVVyEPAHAkI41kR3mhhWYCJM2WI5t/E50N2RV8+Tv9hL1fEORqMxOsjbatjjsGEeQlcWvrCu5ug4HivkKp4IcyI8dshW/0On6jDL0i8Ly8gLObrGkL5tc4kvYuYloQhXfMYXtriYyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784679010; c=relaxed/simple;
	bh=P/1KbSkcE28bN1iVca1pNcShYwclCbE2aTvDhrY2PNw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z27/XnOSwR7BYO4lgRdvf1jc3+w5/cxjSw8wGpVQ+HX1OFKCfQO6f197vbgEu171s+69aUl/DZKfwyvfO4zzIitwqzgchiXswAnOZGPvOdEHSyQL9DmjgUHKBH9HG7JwK0d27kmx7FiGdUrp+h1N9ljjCl+ADNa7ZIN6pZPgP8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k61TN6Nf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k61TN6Nf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260EE1F000E9;
	Wed, 22 Jul 2026 00:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784679009;
	bh=libcLRxtfIIyYjX+b8Nnd3NXfC9N4GUP41f4jVy0BBM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k61TN6Nfbgaz8ZukOSXMwNKlqrIf93J7lZ7X0wkiV7s31D65Jk2K0EdfU/UnJiC/h
	 sudB4toE1iz8y5lpMUlsh1YRH+xRQ+YfAlh+mWHDxuxypm7mqdz7PJV1ucE7DnbVi9
	 Jm9eaH3XeqJpxN0Zy3frDjl0xUv2t4L3BZ3yWrlWPamNtB45IB5DqErp3McyNSSJH/
	 WRwzM4PZMuliJEI+lf/epWustyN/6LymkADCMnKxQ/bATudNMG9oeRKBGJfw71qRXR
	 YVEzdFa5RCM4acp1hWmE4BJCexyl64ImWadfgAvOfLlgd4x3mzsABeUE2z3EtY7gss
	 Ti5idy48z7C4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/5] perf synthetic-events: Fix line synchronization,
 bounds, and truncation bugs in proc maps reader
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260721235254.294053-3-irogers@google.com>
References: <20260721230952.267754-1-irogers@google.com>
 <20260721235254.294053-1-irogers@google.com>
 <20260721235254.294053-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 00:10:08 +0000
Message-Id: <20260722001009.260EE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Stack buffer overflow in cgroup event synthesis due to unhandled a=
lignment padding in `perf_event__synthesize_cgroup`.
--

--- Patch [2]: [PATCH v7 2/5] perf synthetic-events: Fix line synchronizati=
on, bounds, and truncation bugs in proc maps reader ---
commit 5a6494ecb67ef07c1f503dd9bb0692e1d9860b8d
Author: Ian Rogers <irogers@google.com>
Date:   Tue Jul 21 23:52:51 2026 +0000

    perf synthetic-events: Fix line synchronization, bounds, and truncation=
 bugs in proc maps reader
   =20
    Fix critical logic and boundary bugs in read_proc_maps_line() and calle=
r.
    Ensure any mid-line hex/dec/char parsing failure invokes io__drain_line=
()
    safely, using a do-while loop to read and discard remaining characters
    until a newline or EOF is reached.

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

[Severity: High]
This is a pre-existing issue, but can the padding loop earlier in
perf_event__synthesize_cgroup() overflow the cgrp_root stack buffer?

The function perf_event__synthesize_cgroups() allocates a fixed-size stack
array:

    char cgrp_root[PATH_MAX];

This buffer is passed to perf_event__walk_cgroup_tree(), which recursively
appends directory names. The recursion bounds check allows the length of the
path to reach up to PATH_MAX - 2:

    if (strlen(path) + strlen(dent->d_name) + 1 >=3D PATH_MAX)
        continue;

When this near-maximum path is passed to perf_event__synthesize_cgroup(),
the function calculates path_len and attempts to align it to an 8-byte
boundary:

    while (path_len % sizeof(u64))
        path[mount_len + path_len++] =3D '\0';

Because mount_len + path_len can start around 4095, the loop will write null
bytes up to index 4101, which exceeds the PATH_MAX limit of cgrp_root. Does
this out-of-bounds write need to be bounded to prevent stack corruption?

> =20
>  	if (perf_tool__process_synth_event(tool, event, machine, process) < 0) {
>  		pr_debug("process synth event failed\n");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721235254.2940=
53-1-irogers@google.com?part=3D2
