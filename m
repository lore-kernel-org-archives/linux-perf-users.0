Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEDD495E5
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 01:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776044729; cv=none; b=V9wna3/SRblOzjJMOKkpyJLmu2hRzRu1MvUbEQwMK6VQL7HD9N8Z1XbU0ZX7tDLQMlulyy0+FbX5gkPjzfZdRXBUavC/gX3pcSBvHgIOIUh53xWs2I+nRX4uiJoVzlYaOPfVlIIF4e1j/MhWJVOmZf3zmzJ/31eRgCLpiow6CdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776044729; c=relaxed/simple;
	bh=U78Aaqj3uBe6DdKWhXx1RZ0yj0d6rQAuCOch+rXfDR8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KwEyOZ3NVQdhli0/9NdVQtNzLISHMVvs5cym2c6wmwlRuYagEyhg752S59JCiGFnPz4hnERQEqRsklI0b8WTc1dYfIzIrDmeVZ+aSnl8MnM3wJWcbuzuDUb9wUbBbxqsmAlFGgWkP4+LwOc+uMIV45d/t/OqizciYQFgd+BwGuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GElfT019; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GElfT019"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E60C19424;
	Mon, 13 Apr 2026 01:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776044729;
	bh=U78Aaqj3uBe6DdKWhXx1RZ0yj0d6rQAuCOch+rXfDR8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=GElfT019lFjvik153Hym/7wnHSoQdy6/Uvz3EstFgGWZwVbH809ak9m3n2imVbeRI
	 twbgr7ooqWOgsBWo+viKv7itGm2RO/V1P9EHA/RLsWCnMNHPd/RoFizJ8rev8HMCZa
	 OyQ5bqKrPSPJ1fAnqPYz1KE4wWeZCeHb93ICn3E6waVUizDceusMdrFLfwId7fte5C
	 +TF0jzKJX4HYSmOzbX2Oy/MY5NzeHq6uCcAzpA2Za62J2SsM4QXbk1ywauMhbikwoD
	 MziPHdIhYm5i9NaXf7DpkXBK3zcP/0YTce/ZhJxsMjjN/i0ndUYa0wqnBZD90VMwMP
	 GXvga9Wc6gnZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 19/33] perf evlist: Try to avoid computing evsel
 from sample
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260413012227.1089445-20-irogers@google.com>
References: <20260413012227.1089445-20-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Apr 2026 01:45:28 +0000
Message-Id: <20260413014529.27E60C19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Low] The fallback check `if (!evsel) evsel =3D evlist__id2evsel(..., sam=
ple.id);` introduced by this patch is mathematically unreachable dead code.
--

commit 70039c4c6052c77672e3d3e7b9f3b386bae9924f
Author: Ian Rogers <irogers@google.com>

perf evlist: Try to avoid computing evsel from sample

This commit modifies the event processing logic to use the evsel already
present in the sample, falling back to looking it up by id if it is not
present.

> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
[ ... ]
> @@ -1164,7 +1164,9 @@ static int deliver_event(struct ordered_events *qe,
>  		goto next_event;
>  	}
> =20
> -	evsel =3D evlist__id2evsel(session->evlist, sample.id);
> +	evsel =3D sample.evsel;
> +	if (!evsel)
> +		evsel =3D evlist__id2evsel(session->evlist, sample.id);
>  	assert(evsel !=3D NULL);

Is the fallback check for !evsel ever reachable in this path, or could this
be a dead code regression?

Looking at the code just prior to this in deliver_event(),
evlist__parse_sample() is executed and any parsing failure results in
jumping to next_event.

If evlist__parse_sample() succeeds, it appears to unconditionally
populate sample.evsel. Does evlist__parse_sample() have a success path
that leaves sample.evsel unpopulated?

> diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
> --- a/tools/perf/tests/mmap-basic.c
> +++ b/tools/perf/tests/mmap-basic.c
[ ... ]
> @@ -142,7 +142,9 @@ static int test__basic_mmap(struct test_suite *test _=
_maybe_unused, int subtest
>  		}
> =20
>  		err =3D -1;
> -		evsel =3D evlist__id2evsel(evlist, sample.id);
> +		evsel =3D sample.evsel;
> +		if (!evsel)
> +			evsel =3D evlist__id2evsel(evlist, sample.id);

A similar pattern occurs here. Since evlist__parse_sample() is called
just before this and errors branch to out_delete_evlist, would
sample.evsel always be populated by the time we reach this check?

> diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch=
-tracking.c
> --- a/tools/perf/tests/switch-tracking.c
> +++ b/tools/perf/tests/switch-tracking.c
[ ... ]
> @@ -138,7 +138,10 @@ static int process_sample_event(struct evlist *evlis=
t,
>  		goto out;
>  	}
> =20
> -	evsel =3D evlist__id2evsel(evlist, sample.id);
> +	evsel =3D sample.evsel;
> +	if (!evsel)
> +		evsel =3D evlist__id2evsel(evlist, sample.id);
> +

This section also shares the same behavior following
evlist__parse_sample().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260413012227.1089=
445-1-irogers@google.com?part=3D19
