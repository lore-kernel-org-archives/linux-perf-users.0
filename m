Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71E5322C88
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 07:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775891957; cv=none; b=eZUSmYI7HCg9mo7u+HYgeY08d7YDcbA0yW7prFuxRqbnRiuJAEdFeKTH+SPrHmd3FdTxpJjBz6lf9DkjQisVdQw73GHH7+stBC8xQ/57paGowIPYEco/UMu0FmZsxzz4la2DZK4bpCjXdZUXLRspOTwtLZKD5+Eznx6G28HyHdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775891957; c=relaxed/simple;
	bh=ZXX7gbwYu8W40qiFp3MwwSnBu62EyE20kwO8w3ojpXc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j9Zxxg8BLtB3848QKTXBfGvai/4ccLl5/HerSZzJXtMOuGn5hV/T7fjm7i+thBJzThhQlwy4TVY0LTPiH/LtawcQzh8X3QGaDlwTXpfApBd5aYwd/0JHx9ony8qEDG04pv/EyejyjDkChcs1kpmFi9PAifxX6+kEnRj4C5FXHLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhRo4iXN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhRo4iXN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A881C4CEF7;
	Sat, 11 Apr 2026 07:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775891957;
	bh=ZXX7gbwYu8W40qiFp3MwwSnBu62EyE20kwO8w3ojpXc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=RhRo4iXNxI+UaBTPdaQejr8dK5KF9GFqJNnSvaTbl59v5X//nRCIy5tyMSCXNE1Y3
	 lCszdbQfbW5wbjo5HaR4oJrmvxGRwDLmbQb0SD5rfIO8iMU13mO1gKj0TDbx3NGkPQ
	 wAx0qkVlBZBRRYpqiHbGgL2DWchcmFX2DjAj+6xq7e//6W7h7NRhMBPE11BDllc8PC
	 ZcT+NB/85eL0WVOIWjydR9NmkilgVK6DxT+zNV9zsvle+XJ/39SfuxjSxDGQzX69sr
	 KlzfAvgB8OPK1EfSVJ9bwcevGS/KV4LDfN1EH3FqToRxQhdfSedc3SXjiWqxgQJT3l
	 wrLbfmWKqEAQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 14/29] perf inject: Don't pass evsel with sample
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260411065718.372240-15-irogers@google.com>
References: <20260411065718.372240-15-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Apr 2026 07:19:16 +0000
Message-Id: <20260411071917.4A881C4CEF7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Critical] Missing bounds check for `filename` length in `perf_event__syn=
thesize_build_id` causes stack buffer overflow.
--

commit 2a4830e2b3a06525f60938587293cda249c94ea7
Author: Ian Rogers <irogers@google.com>

perf inject: Don't pass evsel with sample

This commit cleans up the handling of the sample and mmap_evsel structures
when synthesizing build id events. It refactors functions to avoid passing
evsel separately. It also adds a bounds check to the filename length in
perf_event__synthesize_mmap2_build_id() to prevent a potential buffer
overrun caught by Sashiko.

> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthet=
ic-events.c
> index 85bee747f4cd2..86049b6991d1f 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
[ ... ]
> @@ -2252,7 +2267,6 @@ int perf_event__synthesize_build_id(const struct pe=
rf_tool *tool,
>  				    struct perf_sample *sample,
>  				    struct machine *machine,
>  				    perf_event__handler_t process,
> -				    const struct evsel *evsel,
>  				    __u16 misc,
>  				    const struct build_id *bid,
>  				    const char *filename)
> @@ -2275,12 +2289,13 @@ int perf_event__synthesize_build_id(const struct =
perf_tool *tool,
>  	ev.build_id.header.size =3D len;
>  	strcpy(ev.build_id.filename, filename);
> =20
> -	if (evsel) {
> +	if (sample->evsel) {
>  		void *array =3D &ev;
>  		int ret;

Should a bounds check for the filename length be added to this function as
well?

Like perf_event__synthesize_mmap2_build_id(), this function allocates a
union perf_event ev on the stack. The len variable is calculated using
strlen(filename) just prior to this block, and then used in a memset()
and strcpy() without bounds verification.

Since filename comes from untrusted profiling data, could a crafted
perf.data file with an unusually long filename overflow the ev stack
buffer here?

[ ... ]
> @@ -2308,13 +2322,24 @@ int perf_event__synthesize_mmap2_build_id(const s=
truct perf_tool *tool,
>  					  const char *filename)
>  {
>  	union perf_event ev;
> +	size_t filename_len =3D strlen(filename);
>  	size_t ev_len;
>  	void *array;
>  	int ret;
> +	u64 sample_type =3D 0;
> =20
> -	ev_len =3D sizeof(ev.mmap2) - sizeof(ev.mmap2.filename) + strlen(filena=
me) + 1;
> +	if (sample->evsel)
> +		sample_type =3D sample->evsel->core.attr.sample_type;
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

This is the bounds check that was added for the mmap2 variant. Adding a
similar verification that len + MAX_ID_HDR_ENTRIES * sizeof(__u64) is within
sizeof(ev) to perf_event__synthesize_build_id() would prevent a similar
stack overflow.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260411065718.3722=
40-1-irogers@google.com?part=3D14
