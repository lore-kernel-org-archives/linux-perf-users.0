Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C834C6C
	for <linux-perf-users@vger.kernel.org>; Wed,  6 May 2026 00:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778027339; cv=none; b=HtfPpicPgc5jW4/acd/PrOFqYDwSJjGROzdpzFVwUM6kK3rtoGryudC7wwCbgTc0vGrEWUmA3aWyxmKQvm9zYllZbYGNfwzirCRvfo0WJ7rz6rMyJGHrwKhA9XNNL58yKlKkpWVUjl8PzVzILXCUKlokwCbM8oaNFrze/uiGSNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778027339; c=relaxed/simple;
	bh=/upRCmTkDloXq8wUYyUhXsDIN1ojjkNYcZy86yn2V1Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uTit8/M1YvH1gPPzYVkoNX/1zK4yP5MHh6/vpj3jQ82luw3wuiO3o15WXUk+Nr2IcDkLYR3a802ofw7dm4/fHfNitVat7fHEq5cJQJlSAdGlO7tD2FyY/L8JAHbpeZbt7HCxQS0Am7kqJIuvYzD5/kt6ybi1qDrnUCr0ClCkR1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0VQ+0A5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0VQ+0A5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F58C2BCB4;
	Wed,  6 May 2026 00:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778027339;
	bh=/upRCmTkDloXq8wUYyUhXsDIN1ojjkNYcZy86yn2V1Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=d0VQ+0A5PNsJKdy+3HL9KwyTURBE3R8+VuKVYUuoa2q1PpWPLRomBlbEjDGYOHrr6
	 rfpQsQdgKUuOfJHodUFAFsqUvGabporzwcm7CnJfQ54zhhFq5124vN+3uj/Ct2QqD0
	 0eFcFbwcQ//dTwcj+0wuXNW9v4DI0iBm+1Af3tcAsdm4iRUsAUx8PXu8XLH3+dVhku
	 SCuyL3Zy5Dzb7RaDCq1W64U6/B8obu+jV3fBLPl7XWKzVTalpvtakt7w0va9EgC0cF
	 LcffD5JEbHS0Wt5Oa0WQn72GLnGu3B0S0AWH7PiaOgjRZpjpqNR2+XjvdJyjmSV/TE
	 EBsI2GA1lHrQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] perf sched stats: Fix segmentation faults, memory
 leaks, and stale pointers in diff mode
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260506000018.3113599-1-irogers@google.com>
References: <20260506000018.3113599-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 00:28:58 +0000
Message-Id: <20260506002858.E7F58C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Resource and memory leak of the second perf session when the fir=
st session's data is empty.
- [Medium] Stranded elements in the global `cpu_head` list are leaked when =
`perf_session__process_events()` fails.
--

commit 2f5196e9db7b207b2b2f6bf8c143c68c7b431e3b
Author: Ian Rogers <irogers@google.com>

perf sched stats: Fix segmentation faults, memory leaks, and stale pointers=
 in diff mode

This commit addresses multiple crash vectors and memory leaks in perf sched
stats diff mode by adding bounds checks, NULL checks, proper error
propagation, and robust memory cleanup.

> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c

[ ... ]

> @@ -4632,7 +4704,10 @@ static int perf_sched__schedstat_diff(struct perf_=
sched *sched,
>  	err =3D perf_session__process_events(session[0]);
>  	if (err)
>  		goto out_delete_ses0;

Is this code leaking the events added to the global cpu_head list?

The schedstat callbacks dynamically allocate and add parsed elements to the
global cpu_head list during perf_session__process_events(). However, the
transfer to cpu_head_ses0 via list_replace_init() hasn't happened yet at
this point. Since out_delete_ses0 only frees cpu_head_ses0, it looks like
any items added to cpu_head before the error occurred would be stranded.

The same pattern appears to exist for session[1] and cpu_head_ses1.

[ ... ]

>  	if (list_empty(&cpu_head_ses1)) {
>  		pr_err("Data is not available\n");
>  		ret =3D -1;
>  		goto out_delete_ses1;
>  	}
>=20
>  	if (list_empty(&cpu_head_ses0)) {
>  		pr_err("Data is not available\n");
>  		ret =3D -1;
>  		goto out_delete_ses0;
>  	}

Does jumping to out_delete_ses0 here bypass the cleanup for the second
session?

Since session[1] has already been successfully opened, parsed, and its
events transferred into cpu_head_ses1, skipping the out_delete_ses1 block
would mean free_schedstat(&cpu_head_ses1) and
perf_session__delete(session[1]) are never called.

> -	show_schedstat_data(&cpu_head_ses0, cd_map0, &cpu_head_ses1, cd_map1, t=
rue);
> +	ret =3D show_schedstat_data(&cpu_head_ses0, cd_map0, session[0]->header=
.env.nr_cpus_avail,
> +				  &cpu_head_ses1, cd_map1, session[1]->header.env.nr_cpus_avail, tru=
e);
> +	if (ret)
> +		goto out_delete_ses1;
> =20
>  out_delete_ses1:
>  	free_schedstat(&cpu_head_ses1);
>  	if (!IS_ERR(session[1]))
>  		perf_session__delete(session[1]);
>=20
>  out_delete_ses0:
>  	free_schedstat(&cpu_head_ses0);
>  	if (!IS_ERR(session[0]))
>  		perf_session__delete(session[0]);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506000018.3113=
599-1-irogers@google.com?part=3D1
