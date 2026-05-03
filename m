Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3FC2E3FE
	for <linux-perf-users@vger.kernel.org>; Sun,  3 May 2026 01:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777770713; cv=none; b=lOk7oUc2fzsZ16wC6+pKrKD/tZnIbWDj2IwESbYKQlywpuk4rF/vgtBN7MeYeW+8a74tm/I1V2ZybAGSULdVOYQj6SLOXwRQgYVXko7ZXufmwmZE+xcakHWKGJggc41mnyCBI9sOZrPFKyfdNiJlwyb6SxCxzgLYHHMyjmnsxCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777770713; c=relaxed/simple;
	bh=8SV6fA5Aop80qUhWfSFsXuBc6SRERHqzPJpTayiXOgE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZgVfcHRZp268P5h1hkE3bXh95fsxl5inidGKgZtWLvPnml8S41df7gVTif050o2WjrhMRAs/USnZPoEB3ywgnLbqc/oS0cbR0K0SBYEkSyBu1HJZuzeDCULDb8b79CRh9eyH3+Qj+QN+fYlIM4KdR60jhJp5LGLNzUNagdJferQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFqRyN6a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFqRyN6a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 807B0C19425;
	Sun,  3 May 2026 01:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777770712;
	bh=8SV6fA5Aop80qUhWfSFsXuBc6SRERHqzPJpTayiXOgE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=HFqRyN6aZenXfAaUAJ8++lLpglL/eLbtj0YTgAd918dsGkRdV5ybLteIq2ehJeYFm
	 /Po890EgEQ+VHlzO/5DVOE781NtP5x8KtWTGRmR5TvqkZnO1BXWJRETLVTGaghvohe
	 p5lfp9Pp+tbPa6bayR9PmtJHY4xaCOWWW0YmVQhtdytdvwSv5mD9RVMibWoct6zdXX
	 ZahzhJEBIAbXAUrbJNrs1I9BoKnpZXngr9rH2aEvoG2XV4d5eIb78WyTcqrWIqcAXy
	 BBem/X+94V6WzSQM81fUGP/iSqe6VG7IE1YoxgpCr9JdTPWBnj/iirEOZzxMGbkr6J
	 PlUSMeZ0FkC6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 14/18] perf env: Refactor perf_env__arch_strerrno
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260503002248.1040791-15-irogers@google.com>
References: <20260503002248.1040791-15-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 May 2026 01:11:51 +0000
Message-Id: <20260503011152.807B0C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Cross-architecture analysis regression in errno string decoding =
for global system summaries.
--

commit db5c373c1c19f2552fd69fd048980560d992a842
Author: Ian Rogers <irogers@google.com>

perf env: Refactor perf_env__arch_strerrno

This commit modifies perf_env__arch_strerrno to take an e_machine constant
instead of an architecture string and updates callers in builtin-trace.c.
It also adds a helper script to map Linux directory names to ELF machine
constants.

> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index e58c49d047a2..d278af18542f 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
[ ... ]
> @@ -4890,7 +4889,9 @@ static size_t syscall__dump_stats(struct trace *tra=
ce, int e_machine, FILE *fp,
> =20
>  				for (e =3D 0; e < stats->max_errno; ++e) {
>  					if (stats->errnos[e] !=3D 0)
> -						fprintf(fp, "\t\t\t\t%s: %d\n", perf_env__arch_strerrno(trace->hos=
t->env, e + 1), stats->errnos[e]);
> +						fprintf(fp, "\t\t\t\t%s: %d\n",
> +							perf_env__arch_strerrno(e_machine, e + 1),
> +							stats->errnos[e]);
>  				}
>  			}
>  			lines++;

How does this impact cross-architecture analysis for global system summarie=
s?

Prior to this patch, syscall__dump_stats() used the target environment=20
(trace->host->env) to decode errno strings.

By switching to the e_machine argument, if the caller for global system
summaries passes a hardcoded EM_HOST (or an equivalent host-specific
default), will cross-architecture global summaries now incorrectly decode
errnos using the host architecture's mappings instead of the target's?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260503002248.1040=
791-1-irogers@google.com?part=3D14
