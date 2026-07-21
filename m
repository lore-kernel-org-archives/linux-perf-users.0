Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F40946EC8E
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 19:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784661911; cv=none; b=HK93TXmJ6C3JKEyzyxqGswWPN1amGg1/O33C8J1pAwoKsBazSOQGU0gWa1jIV24NH/ruKx3To6hXnX+va5vfvJJMwedjSziyETjcZuD416ygHCv9WDPMf9KU499Hg4LvyPr9QrwBnl+UTrZL/0p8Xj3etPhgO1RXgyDDEpFf0fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784661911; c=relaxed/simple;
	bh=cdtZkXK8+FrgFd/Hg2sEcPQ4+fo/XLtqIoaTUr/pGFQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g9OY+J3+Uov67/DOy5qvszNt+j+61y1F1Qvvlctgyr0Xa+bJse4EF7FYhR/O4BIcWR+ex9d+2LdTXeg0ENMC3SAkt5c+4H9vhL7EHrGPcIFhMcbc0r3NV0kTi4oHliLAkM6+HzXLPXb5FUxzyp2ylMefVepF7rHvmZyH4jupmrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsia//9H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsia//9H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1AC51F000E9;
	Tue, 21 Jul 2026 19:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784661910;
	bh=p+gSWeq1hX7xBJMprhPihYZ6zDrTymcqFUuk2j5Qi5M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gsia//9HNkqbynMG6BNehpHxMu83NnRKeK4oS1gkM/UT3lcsNWX8SRUTo2ZUnPcmh
	 RY39J6fPv9uaSt1xk3Bt9jArsbFjDC1cEtd8aOJvGKKjnn9m8sd4vZQaEI8ZDpzkSE
	 ttZzDlwuD9UxsJ/KoAKELyMrH8lLkLxp6hk8AZwQsomRPjjziov/TtMIkddarBJiy1
	 SlL1u2WtXT1YW1rPW3NZQcOyihLJe+DJEmLE2SVFkPMcAh7UOq54C4sqAXa9TTsF/F
	 uLxncHzqwLxtn01jlZzvCUGET9ewxYPzWdSTpVXaL1F4AmR2fa7ZgzpJDujYBy1V3P
	 KH9ed4hqB34ZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/4] perf synthetic-events: Fix bounds and union
 member access in mmap2 build_id synthesis
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260721182150.94016-5-irogers@google.com>
References: <20260721173347.9163-1-irogers@google.com>
 <20260721182150.94016-1-irogers@google.com>
 <20260721182150.94016-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 19:25:09 +0000
Message-Id: <20260721192509.E1AC51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Latent buffer overflow and potential FORTIFY_SOURCE abort due to=
 incorrect string length bounds check against union capacity instead of arr=
ay size.
--

--- Patch [4]: [PATCH v4 4/4] perf synthetic-events: Fix bounds and union m=
ember access in mmap2 build_id synthesis ---
commit a02cc1d93b140eea5444d6b7ee95e98c02c00905
Author: Ian Rogers <irogers@google.com>

perf synthetic-events: Fix bounds and union member access in mmap2 build_id=
 synthesis

This commit modifies bounds and union member access in mmap2 build_id
synthesis. It replaces the previous array-based bounds check with a new
calculation based on the size of the event union.

> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthet=
ic-events.c
> index 63c9c85b02f37..8928c6964fc9d 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
[ ... ]
> @@ -2448,13 +2448,18 @@ int perf_event__synthesize_mmap2_build_id(const s=
truct perf_tool *tool,
>  	size_t filename_len =3D strlen(filename);
>  	size_t ev_len;
>  	u64 sample_type =3D sample->evsel ? sample->evsel->core.attr.sample_typ=
e : 0;
> -	void *array;
> +	void *array =3D &ev;
>  	int ret;
> +	size_t max_filename_len;
> =20
> -	if (filename_len >=3D sizeof(ev.mmap2.filename))
> -		return -EINVAL;
> +	max_filename_len =3D sizeof(ev) -
> +			   (MAX_ID_HDR_ENTRIES * sizeof(__u64)) -
> +			   offsetof(struct perf_record_mmap2, filename) - 1;

[Severity: Medium]
Will this calculation cause an issue if the size of the union perf_event
ever grows larger than struct perf_record_mmap2?

Since max_filename_len is derived from sizeof(ev) rather than the capacity =
of
the ev.mmap2.filename array, any future expansion of the union could cause
max_filename_len to exceed the actual array bounds.

> =20
> -	ev_len =3D sizeof(ev.mmap2) - sizeof(ev.mmap2.filename) + filename_len =
+ 1;
> +	if (filename_len > max_filename_len)
> +		filename_len =3D max_filename_len;
> +
> +	ev_len =3D offsetof(struct perf_record_mmap2, filename) + filename_len =
+ 1;
>  	ev_len =3D PERF_ALIGN(ev_len, sizeof(u64));
[ ... ]
> @@ -2474,16 +2479,15 @@ int perf_event__synthesize_mmap2_build_id(const s=
truct perf_tool *tool,
[ ... ]
> -	memcpy(ev.mmap2.filename, filename, min(strlen(filename), sizeof(ev.mma=
p.filename)));
> +	strlcpy(ev.mmap2.filename, filename, filename_len + 1);

[Severity: Medium]
If filename_len is bounded by sizeof(ev) and the union expands, could this
strlcpy write past the ev.mmap2.filename array capacity and trigger a
_FORTIFY_SOURCE abort?

When built with _FORTIFY_SOURCE=3D2, bounds checks evaluate against the sub=
-object
array capacity (ev.mmap2.filename) rather than the enclosing struct.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721182150.9401=
6-1-irogers@google.com?part=3D4
