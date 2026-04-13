Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D84D155C97
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 01:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776045252; cv=none; b=r40EMI3fZgwpKLfOcK+cHTnxDmKoH+wu+94iXKCOgbIgFUKoeugoIG8GKkvCLY0KIm5IaZG4WS5tPoLXGDITq6Sc+l848ZOk5F+pZUkxODKOgCZk0KrxuTFx0aDRExqsqAcjpQk5AHKDo1g3SSuA4mz9LUsJDXR/mrbult/YLRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776045252; c=relaxed/simple;
	bh=4FGbimmdJ7lkXBLkeWbljitxlpGO6S3civDUVyR6mfo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mIDzkiuF2fuCpYmQmYajk6Q0VB1EeBPOT4WkAnoSJNYL9SelQ/hZ3zVjBQHz9VZBDNUkctfkNXGNgHUnJ/TZXtDHuOtUdLMPNfTACl3iHddiYqyb7D7SX4mOh3mmsCj71JAIIXsdQR0E88vUtP8eWbVCvcq53D5cixIEXFgY0/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGasE0CI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGasE0CI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CAF7C19424;
	Mon, 13 Apr 2026 01:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776045251;
	bh=4FGbimmdJ7lkXBLkeWbljitxlpGO6S3civDUVyR6mfo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=IGasE0CIk4ucAWIhZ6UE1FmPGBb2HgjJMWoglT+wC6Hs5/qtxqs0Qli/liKgkyOWq
	 BDxqT1MiHYXPj1znnlIT6XH3474b5CG+WEwBr64NZd+0zK0wWvshdozvyg4/nDNLbs
	 GkRiP1ZENZZNiOJbqGxPuQFNkNFYkRHvMe7Ze7wgD1Ct4KPNwmXNBtA+k4gJBH/zHA
	 KtJSaw1J7F5rXiSBdI+n0e268MM2p0iEMG+I3k8h5abX0aU580ukdRZ0UlIlOkVTXA
	 S4DW0IK+6cf3KvK8RCXEUPznh8YgfksogyilYp0hXgdroHrjM22LTsj/Lkx1dBetgJ
	 AN6Z7Bl2HLfBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 24/33] perf lock: Avoid segv if event is missing a
 callchain
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260413012227.1089445-25-irogers@google.com>
References: <20260413012227.1089445-25-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Apr 2026 01:54:11 +0000
Message-Id: <20260413015411.9CAF7C19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Inconsistent error handling masks memory allocation failures, le=
ading to silent data truncation. The patch modifies `get_callstack()` to re=
turn `NULL` on `calloc()` failure, and changes the caller `report_lock_cont=
ention_begin_event()` to return `0` instead of `-ENOMEM` when a callstack c=
annot be obtained. While the commit message justifies this as a choice to "=
skip the event" rather than "fail the entire file", it conflates a normal e=
vent condition (a sample missing a callchain) with a global system resource=
 failure (OOM). This introduces an inconsistency because other memory alloc=
ation failures within the exact same function (e.g., `lock_stat_findnew`, `=
thread_stat_findnew`) still correctly return `-ENOMEM` and safely abort the=
 file processing. Silently dropping events on OOM without warning the user =
(unless the tool is run with `-v`) degrades the reliability of the profilin=
g tool by presenting incomplete results as successful.
--

commit 13aefff8f4f4e8214a2931fe522b7eb9e3f8f481
Author: Ian Rogers <irogers@google.com>

perf lock: Avoid segv if event is missing a callchain

This commit adds a check to avoid a segmentation fault when a sample is
missing a callchain. It also changes the error handling in
report_lock_contention_begin_event() to skip the event rather than failing
the entire file when get_callstack() returns NULL.

> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -938,9 +938,16 @@ static u64 *get_callstack(struct perf_sample *sample=
, int max_stack)
>  	u64 i;
>  	int c;
> =20
> +	if (!sample->callchain) {
> +		pr_debug("Sample unexpectedly missing callchain\n");
> +		return NULL;
> +	}
> +
>  	callstack =3D calloc(max_stack, sizeof(*callstack));
> -	if (callstack =3D=3D NULL)
> +	if (callstack =3D=3D NULL) {
> +		pr_debug("Failed to allocate callstack\n");
>  		return NULL;
> +	}

[ ... ]

> @@ -1059,7 +1066,7 @@ static int report_lock_contention_begin_event(struc=
t perf_sample *sample)
>  	if (needs_callstack()) {
>  		u64 *callstack =3D get_callstack(sample, max_stack_depth);
>  		if (callstack =3D=3D NULL)
> -			return -ENOMEM;
> +			return 0;

Because get_callstack() returns NULL for both a missing callchain and a
calloc() failure, this change makes report_lock_contention_begin_event()
return 0 in both cases.

Does this conflate a normal missing callchain with a memory exhaustion
condition?

By returning 0 on OOM, the tool will silently drop events under memory
pressure rather than aborting, which might lead to incomplete and misleading
profiling results. Other memory allocations in the same function, such as
thread_stat_findnew(), still return -ENOMEM and correctly abort.

Should the OOM case still propagate an error so the file processing aborts
consistently on resource exhaustion?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260413012227.1089=
445-1-irogers@google.com?part=3D24
