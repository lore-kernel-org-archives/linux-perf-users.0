Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2AB64
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 00:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784678682; cv=none; b=HJ7wBxxUI8dKoJEzqpY6/+oNnUimHHNDR8Z4f8x5ujHeBNYLs7cmnhCr9q48IyURggvPf1rCVCOcf7CLBNb2BgQVDOhVEeG37IQwnhoEJ/ZJZEfe6WRQTOIOXBSwte0cDdeW4zUYl/GsHPVwkeZDEExd9wHpHLluAioA3iNo7zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784678682; c=relaxed/simple;
	bh=vCiK8kkza4cEM1WKseiQqPpefu+erdZZ9QFx55AGVwE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TF5muvNWBTM2n1xEG1cb0/oNWK4+ORDrngTts8MrDuu6kHlJz02lfHzo3JXNnB7q2omo9oZFqH/LBQGz2sFWrmlGEIzcpFfaF2Zfsqs3TEsXp3/vrsRXkJrqs91yWjetrBbK6dV1uU4YGZhaVFyTgFHswXBrOEKx/Uau1RGpDO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fd0A4X5A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fd0A4X5A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D951F000E9;
	Wed, 22 Jul 2026 00:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784678679;
	bh=xhaPIn59+ofPb3T+DSXR4x+Zo7zpT7C4DgbW3n9AFIo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fd0A4X5ACnIvSEkrfMJt0gh2Dyh0YslvPF2r/zVTTNutoIlIR+mxs8+/rbymSyZZ5
	 Clw67UuQECJneq585Cy4CaL8kKZHC0bXOjyRvaPvBAp3RkGl8PSPR3B1E2c3kMOYKa
	 gCOidBCFcZplqB1PxJ/AXjhebs8qnI+Hjxpu3u4SyItbzbGDfy2WkDomPH1OeXVML6
	 kftfDQluvDUcjiuc75VmbvvyJW7T0Ukmfcj2VNTm7oraG9WZvQ32vyBcgH/wu/CLaT
	 TVo0TJe/y8m6joQTF96IpFuFu0joJBvZNfm6YPSxISeBua9miFLXrCmW4xLEyjenoV
	 TUGTFnfI9NfkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/5] perf synthetic-events: Fix stack buffer overflow
 and bounds in cgroup synthesis
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260721235254.294053-4-irogers@google.com>
References: <20260721230952.267754-1-irogers@google.com>
 <20260721235254.294053-1-irogers@google.com>
 <20260721235254.294053-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 00:04:38 +0000
Message-Id: <20260722000438.F0D951F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Pre-existing 1-byte stack buffer overflow when appending a slash t=
o the cgroup mount point.
- [High] Calling pthread_join() on uninitialized thread IDs during error cl=
eanup.
--

--- Patch [3]: [PATCH v7 3/5] perf synthetic-events: Fix stack buffer overf=
low and bounds in cgroup synthesis ---
commit 65d6809cf0ab7cea41d6812171193757a21f8d99
Author: Ian Rogers <irogers@google.com>

perf synthetic-events: Fix stack buffer overflow and bounds in cgroup synth=
esis

The commit fixes a stack buffer overflow bug in perf_event__synthesize_cgro=
up()
by eliminating in-place path mutation. It uses PERF_ALIGN for path_len, cla=
mps
raw_path_len, and uses strlcpy to prevent overruns.

> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthet=
ic-events.c
> index e9952c27b3bc0..7b8095e013b98 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -635,15 +635,22 @@ static int perf_event__synthesize_cgroup(const stru=
ct perf_tool *tool,
>  					 struct machine *machine)
>  {
>  	size_t event_size =3D sizeof(event->cgroup) - sizeof(event->cgroup.path=
);

[ ... ]

This is a pre-existing issue, but I noticed a potential problem in
perf_event__synthesize_cgroups():

tools/perf/util/synthetic-events.c:perf_event__synthesize_cgroups() {
	...
	char cgrp_root[PATH_MAX];
	...
	if (cgroupfs_find_mountpoint(cgrp_root, PATH_MAX, "perf_event") < 0) {
	...
	/* make sure the path starts with a slash (after mount point) */
	strcat(cgrp_root, "/");
	...
}

[Severity: High]
Can this strcat() cause a 1-byte stack buffer overflow if the mount point
path returned by cgroupfs_find_mountpoint() is PATH_MAX - 1 bytes long?

cgroupfs_find_mountpoint() can return paths up to PATH_MAX - 1 characters
(4095 bytes) into the cgrp_root buffer of size PATH_MAX.

When strcat() appends the "/", the '/' would be written at index 4095 and t=
he
NUL terminator at index 4096.

Since cgrp_root is sized PATH_MAX (valid indices 0 to 4095), writing the NUL
terminator at index 4096 causes an overflow. While a 4095-byte mount path is
uncommon, it seems structurally possible.


This is also a pre-existing issue, but I noticed a potential problem in the
error handling path of perf_event__synthesize_threads():

tools/perf/util/synthetic-events.c:perf_event__synthesize_threads() {
	...
	synthesize_threads =3D calloc(thread_nr, sizeof(pthread_t));
	...
	for (i =3D 0; i < thread_nr; i++) {
		if (pthread_create(&synthesize_threads[i], NULL,
				   synthesize_threads_worker, &args[i]))
			goto out_join;
	}
	err =3D 0;
out_join:
	for (i =3D 0; i < thread_nr; i++)
		pthread_join(synthesize_threads[i], NULL);
	...
}

[Severity: High]
Is it safe to join uninitialized threads in this error cleanup loop?

If pthread_create() fails, the code jumps to out_join. The cleanup loop then
unconditionally iterates through all thread_nr elements, calling
pthread_join().

Because synthesize_threads was allocated with calloc, the uninitialized or
failed thread IDs are 0.

On libc implementations like musl where pthread_t is a pointer, passing 0
results in a NULL pointer dereference inside pthread_join(), which could cr=
ash
the application during the error recovery path.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721235254.2940=
53-1-irogers@google.com?part=3D3
