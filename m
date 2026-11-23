Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795419449;
	b=jeQ1lrQoXBuY9zhNImWKMYR2xaWbkPuES7o0np/eTzVGPRrl7NVs1jG/GVzyCkNzMCfy
	 ELpqpZ3lM7yW2rmaVLIxeLkP+KyAtgDMYk73LtU1lbYGxlWtuCkR5SKB+I0vn6VhWVVFV
	 rK+ibNLahRoBqLAkSbAvKB9oQ/dIkKoC6mHH6b2ywEeSyabjEP1BMe4TnFdEz9afNtXSx
	 jhv79DuzHy48QtDY+CCs3qaCf2mV9NI7rrWzv01sKA/t6Ya3Afu4poigZlByMFeqASOJj
	 Ma0NfY8yYe877vvb3nzXARridLfhW54R30GLuS2yekZiI8emYyzaqyZIOva6dEsQAog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795419449;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GvhAU3jI0hH0IkCj/HQiYYTEqt5aLp1JjjRsv7PklaA=;
	b=XAQ9c7kceRsMH896duC7ks2gwle0vJXtMTAjkI6ojRgex5ldsqQMXiOrbxlgouki2rqT
	 8TyxFJgJKr2Lf6wOoMJkkvgdU4cXdaZrufrHtcfYYbl9Q5WKfZB4Qy5feLA0OnzTdRAPt
	 wgriOv1Or+fhstj64fVdW97tPh2sSdfNDg29x1sSXyzlW6qKsx55tERKgVY24KKcCYjrx
	 f7rMtMVUiixLt9/FO/FjW4h1ysprR3NOSmqYsUA+F7Jd553/W8G/czOXh5sCRUXbnSphX
	 P0y6d1MFP5Su6P7IQGA3JtDEP+wzGLsd2z8HF71SPbPVcqKaDT1Yn9ESophntG8lJ/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ApGPFOYM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803FB606A31E
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 07:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ApGPFOYM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812C11F000C4;
	Mon, 23 Nov 2026 07:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795419448;
	bh=GvhAU3jI0hH0IkCj/HQiYYTEqt5aLp1JjjRsv7PklaA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ApGPFOYM5cArV1C5ikNhkp/cK8ehhClpGiLcO4U2WX3p8z+YJ3zLie8yg5FSHf/bq
	 YpcLqEJ5AYBWhjIIMwcwB5Rj/QBPwuzQ6iJJc2g89zNjJA2nFUO55PSCiquEY+SLyF
	 9ahvmWYvpVrijDOtBF5vlNBrRZkl25gh6HR1KaNmmRhS707gKa8OS6xzv/nFa4ocmV
	 Ldr292Q20dDBcSBoJ/J4I37n8qiRJRBRq0Nt3td/iNuISIXtAU7inZa7h3xQ1CU/Xk
	 DwcSOf/yfXu5BliPTkHxaYENcl009AqlZSp9sbMSs0xO0M3uURssQBVTK2+N26fFsC
	 efSg0SZ2JGb0g==
Message-ID: <sashiko-outbox-228825@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 04/13] perf stat: Give non-perf_event_open events
 unique IDs for stat record
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261123071913.653315-5-irogers@google.com>
References: <20261123071913.653315-1-irogers@google.com>
 <20261123071913.653315-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 07:37:28 +0000
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
- [Medium] perf evsel: evlist__next_synthetic_id() assigns -1ULL
  sample.id sentinel
--

commit bf429860ca696e1f7721eda193a7577f31d0f3a5
Author: Ian Rogers <irogers@google.com>

perf stat: Give non-perf_event_open events unique IDs for stat record

This commit assigns unique synthetic IDs counting down from ~0ULL to events
that are not opened via perf_event_open(), so that perf stat record and perf
stat report can distinguish them.

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index d060fca8090f6..0ed598a0ed151 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -4724,15 +4724,51 @@ struct perf_env *evsel__env(struct evsel *evsel)
>  	return session ? perf_session__env(session) : NULL;
>  }
> =20
> +/*
> + * Get an ID for an event not opened with perf_event_open, such as a too=
l PMU
> + * event. Kernel assigned IDs count up from 1, so count down from the la=
rgest
> + * ID to keep as far away from them as possible. Reaching the kernel's I=
Ds
> + * would need ~2^63 perf events to have been created, but also skip any =
ID
> + * already in use by the evlist.
> + */
> +static u64 evlist__next_synthetic_id(struct evlist *evlist)
> +{
> +	static u64 next_synthetic_id =3D ~0ULL;
> +	u64 id;
> +
> +	do {
> +		id =3D next_synthetic_id--;
> +	} while (evlist__id2sid(evlist, id));
> +
> +	return id;
> +}

[Severity: Medium]
Does post-decrementing next_synthetic_id from ~0ULL cause the first synthet=
ic
ID to collide with the -1ULL sentinel used for unset sample.id values?

__evsel__parse_sample() initializes data->id to -1ULL (~0ULL) and leaves it
at -1ULL for non-sample events when sample_id_all is not set, such as the
PERF_RECORD_MMAP event synthesized during perf stat record:

tools/perf/util/evsel.c:__evsel__parse_sample() {
	perf_sample__init(data, /*all=3D*/true);
	data->evsel =3D evsel__get(evsel);
	data->cpu =3D data->pid =3D data->tid =3D -1;
	data->stream_id =3D data->id =3D data->time =3D -1ULL;
    ...
}

When the first synthetic ID (~0ULL) is assigned to an evsel that is not
first in the evlist (for example, perf stat record -e
task-clock,duration_time true), evlist__id2evsel(evlist, -1ULL) resolves to
that synthetic-ID evsel while sample->evsel on the PERF_RECORD_MMAP event is
evlist__first(evlist).  Running perf stat report then trips the assertion in
machines__deliver_event():

tools/perf/util/session.c:machines__deliver_event() {
    ...
	if (!sample->evsel) {
		sample->evsel =3D evlist__id2evsel(evlist, sample->id);
		if (sample->evsel)
			sample->evsel =3D evsel__get(sample->evsel);
	}
	else
		assert(sample->evsel =3D=3D evlist__id2evsel(evlist, sample->id));
    ...
}

Pre-decrementing next_synthetic_id (or initializing it to ~0ULL - 1) would
avoid assigning ~0ULL as a valid event ID.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123071913.6533=
15-1-irogers@google.com?part=3D4
