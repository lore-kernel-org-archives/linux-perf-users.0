Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A9F29ACD1
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 07:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775635116; cv=none; b=Cda7sdG2RdhmEp8tq7Yi9V6gXmUr64oPlE35DctXrDc4PWviGZiAOFiXJDZN1YpObwDoJg+z6KOJrkfAqhKcsmkDmm+t7CR/RyJfb/1GqI6gv02vDVaSdXMoxZ8JyrYj56yptY6GZ2i7Ws5Mj64v8q7qvAbmq9ccfujQkxAGa1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775635116; c=relaxed/simple;
	bh=8oZ9UpJrzEZ0paPpPBH3VS0ECGAbysv4PYAgGwJCPP8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p8V6kgiOq40d2o0XXjK6K4GwK7u6E6eu6Vdj2ErGk30DfKY3veUji8oQIAnLjABhl81teWI7qfGKP2H6aADE10hRJtnR9Kqv5da6IElXwRJFfWcEHfctKekScl8Oe7dPLJvMq6zzjk6PbCrHy5wTxt+GsPtR0y6T5/8+iRY0Nsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdXyZt3D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdXyZt3D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A85C19424;
	Wed,  8 Apr 2026 07:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775635116;
	bh=8oZ9UpJrzEZ0paPpPBH3VS0ECGAbysv4PYAgGwJCPP8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=kdXyZt3DgcQpXS8jslfShiscP7HEaFgZ2cXu4Ubo7UWBq8gsk2ie8WNkMMM6NsYta
	 gxW9i19o8L/LPMWIZbpyql0GYMLzEdmuwK14RbdN2KpoQ1Nwa/jziC7ffAtZTTKcvG
	 itKTPoJKQnEiW56A1lGmYjtU5/CPs/SRKv9prxnwvotcKIMGzOOW2K7cGCDK2GBPW3
	 SQ89Olz0jYeNoPwb6882ZOMjm/pP+4f7XzigkBCZbKFE3y+R6ciZyE5DU4R4IxXwao
	 km71qCe+WWeXFh8SbP5nb9mh8MnT1qXx6Ilid/S3hhxkSsG4XFmAZSqWKEnUmT4Zpz
	 yqrIAYXbtG6Iw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 14/23] perf inject: Don't pass evsel with sample
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260408072601.210837-15-irogers@google.com>
References: <20260408072601.210837-15-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Apr 2026 07:58:35 +0000
Message-Id: <20260408075835.E4A85C19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] Incomplete fix for stack buffer overflow during event synthesis; `=
perf_event__synthesize_build_id` remains vulnerable.
- [High] `perf_event__synthesize_mmap2_build_id` unconditionally aborts if =
`evsel` is NULL, which silently drops valid events during DSO hit marking.
- [Medium] The bounds check in `perf_event__synthesize_mmap2_build_id` drop=
s valid events with long paths instead of properly allocating the promised =
space.
--

commit 9127a57d3b6c56a5eb8812d5d12e6bf3a1c023e6
Author: Ian Rogers <irogers@google.com>

perf inject: Don't pass evsel with sample

This commit simplifies the handling of evsel by using the one already
contained in the sample instead of passing it as a separate argument.
It also adds checks to avoid potential buffer overruns when appending
sample identifiers.

> Add space for sample identifiers in
> perf_event__synthesize_mmap2_build_id to avoid Sashiko caught
> potential buffer overrun.

The commit message states "Add space for sample identifiers in
perf_event__synthesize_mmap2_build_id". However, looking at the code change=
s,
it appears we only added a bounds check rather than allocating additional
space.

Could this wording be updated if the intent was just to add bounds checking?
Since sizeof(ev) is bounded by the union size, does returning -E2BIG here
risk dropping valid events with long paths?

> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthet=
ic-events.c
> index 85bee747f4cd2..502b1f847c91c 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c

[ ... ]

> @@ -2275,12 +2289,13 @@ int perf_event__synthesize_build_id(const struct =
perf_tool *tool,
>  	ev.build_id.header.size =3D len;
>  	strcpy(ev.build_id.filename, filename);
> =20
> -	if (evsel) {
> +	if (sample->evsel) {
>  		void *array =3D &ev;
>  		int ret;
> =20
>  		array +=3D ev.header.size;
> -		ret =3D perf_event__synthesize_id_sample(array, evsel->core.attr.sampl=
e_type, sample);
> +		ret =3D perf_event__synthesize_id_sample(array, sample->evsel->core.at=
tr.sample_type,
> +						       sample);

Does this function also need the capacity check that was added to
perf_event__synthesize_mmap2_build_id()?

If filename approaches PATH_MAX, len can reach ~4136 bytes. Appending up to
48 bytes of sample identifiers could exceed sizeof(ev) and cause a stack
buffer overflow.

[ ... ]

> @@ -2299,7 +2314,6 @@ int perf_event__synthesize_mmap2_build_id(const str=
uct perf_tool *tool,
>  					  struct perf_sample *sample,
>  					  struct machine *machine,
>  					  perf_event__handler_t process,
> -					  const struct evsel *evsel,
>  					  __u16 misc,
>  					  __u32 pid, __u32 tid,
>  					  __u64 start, __u64 len, __u64 pgoff,
> @@ -2308,13 +2322,23 @@ int perf_event__synthesize_mmap2_build_id(const s=
truct perf_tool *tool,
>  					  const char *filename)
>  {
>  	union perf_event ev;
> +	size_t filename_len =3D strlen(filename);
>  	size_t ev_len;
>  	void *array;
>  	int ret;
> =20
> -	ev_len =3D sizeof(ev.mmap2) - sizeof(ev.mmap2.filename) + strlen(filena=
me) + 1;
> +	if (!sample->evsel)
> +		return -EINVAL; /* Evsel is needed for sample_type data. */

Previously, if evsel was NULL, this function skipped appending the sample ID
trailer but still called process() to successfully repipe the synthesized
mmap2 event.

Will this early return silently drop valid events during DSO hit marking,
where mmap_evsel might be NULL and fail to resolve?

> +
> +	if (filename_len >=3D sizeof(ev.mmap2.filename))
> +		return -EINVAL;
> +
> +	ev_len =3D sizeof(ev.mmap2) - sizeof(ev.mmap2.filename) + filename_len =
+ 1;
>  	ev_len =3D PERF_ALIGN(ev_len, sizeof(u64));
> =20
> +	if (ev_len + MAX_ID_HDR_ENTRIES * sizeof(__u64) > sizeof(ev))
> +		return -E2BIG;
> +
>  	memset(&ev, 0, ev_len);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260408072601.2108=
37-1-irogers@google.com?part=3D14
