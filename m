Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D4A16F288
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Aug 2026 00:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787013791; cv=none; b=sEH5j+X/mHBp0biTU9NMaphUf2dpvj3OvXu6dyUoMgoSnBasTDEITkaLaGmKoWiQPj1J/f6cmnrTsuhZPf2p/Y9MccBzFpabxD6TDVp9bjs2z+0TcwLJM19k/ES3efwUjoI/Ad7U42yci61Q9iXNYgrUhMq0RT01fVKoAFyZAxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787013791; c=relaxed/simple;
	bh=yVFzQEdY2sXnLCcfEu9dPDLwDxTcOw7uv0O0c37Yqho=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jPCoyCfDmxR4nyKmaY/3C7yGoYN9zeN/Tcy9F/RDQui0oVD7LOfQ5pXDw4LVop4h3cRORAAWzfQbRQoV7z3mcBolNef+DO+d14FU4/I7izEoULJMnVMYcQCPBdGbKz2P4knTBXHvLX72Aw0/nfuar6RCxup9KKoEbHZhpaMFSvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqjj/x9q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqjj/x9q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241F91F000E9;
	Tue, 18 Aug 2026 00:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787013790;
	bh=pIn2UM1tPV7Ix2P0Rt8U/2hhv7G/+NjrouNd6vU7+MU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mqjj/x9qiO1P7gO6bWUy9EhXp5QBWt+N4M6BWKdmSM/l1CtL7hPV/XKXxfhz0oaRM
	 973WRTE3uZsg1s4n7E/rPnjsrqohUSjYJQLL7d+Og1NdUfKDldGAMTo69IWKUASW8G
	 aOMHuQld5OW2nQzrozBIPzK2CQ6SgZ56Fv2OGMuX9uFiH30TciWw62r569qnWhK+my
	 lgPbdwK9OMJksst9r0nbec7qctqXU0/6T6L7IIT2It3TwOWDaj4oZdvKPqTERtcwFV
	 pjTbjJOABqvpRZiShLZk+QTLvo4enu5Q81rsRcOYCX/9hWx44uHyerfdWExmV52eR2
	 Ud1WFf4xWxjvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] perf record: Fix unhandled POLLHUP on non_perf_event
 descriptors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260818003101.520874-1-irogers@google.com>
References: <20260817230431.424646-1-irogers@google.com>
 <20260818003101.520874-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 00:43:09 +0000
Message-Id: <20260818004310.241F91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch completely omits necessary modifications to `tools/lib=
/api/fd/array.c`, causing the newly added unit test to fail deterministical=
ly.
--

--- Patch [1]: [PATCH v5] perf record: Fix unhandled POLLHUP on non_perf_ev=
ent descriptors ---
commit dd8edd3a80b47efe7508c7fe4d3a8d1e99fd10d2
Author: Ian Rogers <irogers@google.com>

perf record: Fix unhandled POLLHUP on non_perf_event descriptors

This commit attempts to fix a POLLHUP issue by updating the pollfd state in
record__update_evlist_pollfd_from_thread() and reverting logic in
fdarray__filter(). It also introduces a unit test to enforce that
nonfilterable items bypass the revents filtering loop.

> diff --git a/tools/perf/tests/fdarray.c b/tools/perf/tests/fdarray.c
> index 40983c3574b12..2d3db7b754a17 100644
> --- a/tools/perf/tests/fdarray.c
> +++ b/tools/perf/tests/fdarray.c
[ ... ]
> @@ -80,6 +80,30 @@ static int test__fdarray__filter(struct test_suite *te=
st __maybe_unused, int sub
>  		goto out_delete;
>  	}
> =20
> +	fdarray__init_revents(fda, POLLHUP);
> +	fda->priv[2].flags =3D fdarray_flag__nonfilterable;
> +
> +	pr_debug("\nfiltering all but fda->entries[2] (nonfilterable):");
> +	fdarray__fprintf_prefix(fda, "before", stderr);
> +	nr_fds =3D fdarray__filter(fda, POLLHUP, NULL, NULL);
> +	fdarray__fprintf_prefix(fda, " after", stderr);
> +
> +	if (nr_fds !=3D 0) {
> +		pr_debug("\nfdarray__filter()=3D%d !=3D 0, should be 0\n",
> +			 nr_fds);
> +		goto out_delete;
> +	}
> +	if (fda->entries[2].fd =3D=3D -1) {

[Severity: Medium]
The commit message mentions reverting logic in fdarray__filter() to bypass
nonfilterable events, but the actual modifications to tools/lib/api/fd/arra=
y.c
appear to be missing from this patch.

Since the logic to bypass nonfilterable items wasn't included, does this
new test in test__fdarray__filter() fail deterministically because the
underlying behavior hasn't changed?

> +		pr_debug("\nfdarray__filter() illegally modified nonfilterable fd!");
> +		goto out_delete;
> +	}
> +	if (fda->entries[2].revents !=3D POLLHUP) {
> +		pr_debug("\nfdarray__filter() illegally modified nonfilterable revents=
!");
> +		goto out_delete;
> +	}
> +
> +	fda->priv[2].flags =3D 0; /* reset flags */
> +
>  	pr_debug("\n");
> =20
>  	err =3D 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818003101.5208=
74-1-irogers@google.com?part=3D1
