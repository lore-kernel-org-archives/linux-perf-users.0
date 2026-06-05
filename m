Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AD443E9C4
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 19:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688290; cv=none; b=tCOATQjUZsMtNrmsnNKNWzwKXDkLxtqji/Y59N4KAUuWdorjtGuQdqnusBeY9p+/B9Zds6EAZLIHycypMZw4D0lYludj0pKwa7jtY/IoiIK2gzpEn0aKpODE4WK/zvnLr/kBpa3qeZepwKAmFjW2bXbK1+NYEdGx2o248iptfVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688290; c=relaxed/simple;
	bh=Stl3C0naiL8VQp4QHgb6217hz/Qx0eUeCDukZVjENpk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YcnrBUGBDgaRx9TWxIcdlCfVtWA0XsJJP0HRye5FPzVkXNPQzKQdPfSWV3Udbdd/PkQXKM2Q5j+BnAAKxDTHNhHWJQ5Q6p7oHPrvGQhZIp4p6ccJ6Azzndt2L2h82DgF/E7rZQoLILTYT9uAvNDQYGGaYhrF9wyhuCeee2QRSDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDEeOAlX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDEeOAlX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1441F00893;
	Fri,  5 Jun 2026 19:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688288;
	bh=dyq7/y9QsEVdeNynmTLXwJwcYhtJi5Gcu/1dVbalqbA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jDEeOAlXBbSv1pIU/euZwN49D0HQBZK7I9lgMiz+b/bAdIrBR9qbofuzgmXDWHvw3
	 xRS/zc27rPWsU221H8MFqqacaftpqChO8YVjP05up/ntchnEZ58zsrOiEzcmkAMmWc
	 NPwFjgj7oHGZYYtQaIklYHtcv4o/OtKSNnJiXWYgBNdh8+6SMNJjtfWezNTzPCNLu7
	 bCjvSYtxGrs2XhU3mYrFKI2uYA8d0ttEBk+M2hSS5p1vu/uLcmKw2yoHzpsNfOtCuR
	 k+wuPNMfuS7w6hs4D2W4d8/QFpCEL2lFkB+Q7up+y0NUVajNnCIqfavizHLFcb/KKB
	 7wd8jaZyPVHxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 08/19] perf python: Use evsel in sample in
 pyrf_event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605191500.2477026-9-irogers@google.com>
References: <20260605191500.2477026-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 19:38:08 +0000
Message-Id: <20260605193808.AC1441F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Overwriting `sample.evsel` without dropping the existing reference=
 causes an `evsel` memory leak.
- [High] Leaked `evsel` reference when `evsel__parse_sample` or `evlist__pa=
rse_sample` fails on error paths that bypass cleanup.
--

commit f3d12718541e9a7c485a3e3991c159212f6a7942
Author: Ian Rogers <irogers@google.com>

perf python: Use evsel in sample in pyrf_event
   =20
Avoid a duplicated evsel by using the one in sample. Add
evsel__get/put to the evsel in perf_sample.

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index ba88c29ebe5ce..d01c78da51e2b 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -3365,7 +3365,7 @@ int evsel__parse_sample(struct evsel *evsel, union =
perf_event *event,
>  	union u64_swap u;
> =20
>  	perf_sample__init(data, /*all=3D*/true);
> -	data->evsel =3D evsel;
> +	data->evsel =3D evsel__get(evsel);

[Severity: High]
Since data->evsel now holds a reference count acquired here, do existing
callers that manually overwrite sample.evsel need to be updated?=20

For example, in tools/perf/util/session.c:session__flush_deferred_samples():

        sample.evsel =3D evlist__id2evsel(evlist, sample.id);
        if (sample.evsel)
                sample.evsel =3D evsel__get(sample.evsel);

If evlist__parse_sample() already populated sample.evsel with an evsel__get=
()
reference, does this manual overwrite permanently leak the original referen=
ce
since perf_sample__exit() will only drop the new one?

[Severity: High]
If parsing fails later in evsel__parse_sample() (for example, by jumping
to out_efault), the function returns an error, but data->evsel already
holds the reference.

Since several callers abort on parsing failure without calling
perf_sample__exit(), does this error path permanently leak the evsel refere=
nce?

For example, in tools/perf/builtin-inject.c:guest_session__fetch():

        ret =3D evlist__parse_sample(gs->session->evlist, gs->ev.event,
                                   &gs->ev.sample);
        if (ret) {
                pr_err("Parse failed fetching guest event");
                return ret;
        }

>  	data->cpu =3D data->pid =3D data->tid =3D -1;
>  	data->stream_id =3D data->id =3D data->time =3D -1ULL;
>  	data->period =3D evsel->core.attr.sample_period;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605191500.2477=
026-1-irogers@google.com?part=3D8
