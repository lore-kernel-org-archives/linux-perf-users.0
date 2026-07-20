Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3262C4499BA
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 18:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784572109; cv=none; b=myw5dmhyG8fFas/2vc4eS4o3H+fXtaApgJqyRogSJb+xXNaSe0jbov9yl5D0MWhKvydtSOrSOPFkG0CusD9R43hIXdEgcnn5aj7naPVLef/MdWx4BKBgM4cawJCnqcj341Y42KalY+6hKCrUV0n7IXMDhXHdM/fyVkYXMJa/32E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784572109; c=relaxed/simple;
	bh=4GA6xHhaBSEuqTNCYsltBzYkMzl3r/ECPno+oI3/huM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uGgYN97aYU6VhHdoK6yT+S6QZIJUD78+TFh6mhAD5t4seV/8LjYkEofbe9RPH8bBhFEKCbf/G+O17mYHa0VC1dPf6AiMKv4apzcm/np2KvGTVmxdV39WiWBss2Sk7zvmo0tFHJ/nxCpTLa+wJAuJ2nWna4yF8AZMljYIxSSXa0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNjCkbM2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNjCkbM2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9011F00A3D;
	Mon, 20 Jul 2026 18:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784572105;
	bh=7/aq5Ntx7zkx9+3ZwWLoDwo+5vJwPoISOGKZCZxsxEE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cNjCkbM2+Kk9WBqOkUlZLRZRIvz5qctaufV1cn/ZbX3owij5YJiI/bhoG8jmw5UAA
	 uI1DaCB80yzA1X16vcB138QgA8eLnAykuQPxnoo9dsvapb25G5B5NM00ai17C+6rd8
	 Krp5/ilR9RwNCW4xlUnH0ao7GzfYMVYjThaU3fXHfk3AIxmyDZUGoltkKf8sqzG5Kf
	 WFIQAN1NNgTQ1cb7M1q64tKBnugRYpLvbIqscbicqDK88l75ytJw0wC1bjmbDI8LbS
	 /0p1P5dYB7gq7/7iLIS+VrVrmE1Pzos88AYchNB6WM3zhR6Q3HPwbrEoM+LBFwVrp8
	 aZ/NIx/+XOCnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 4/4] perf synthetic-events: Fix bounds and union
 member access in mmap2 build_id synthesis
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260720175455.3645946-5-irogers@google.com>
References: <20260720175455.3645946-1-irogers@google.com>
 <20260720175455.3645946-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 18:28:24 +0000
Message-Id: <20260720182825.6E9011F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly introduced `max_filename_len` clamping mechanism fails=
 to prevent `-E2BIG` errors for long filenames because it does not account =
for alignment padding and the NUL byte.
--

--- Patch [4]: [PATCH v1 4/4] perf synthetic-events: Fix bounds and union m=
ember access in mmap2 build_id synthesis ---
commit 2f96e2c59cef660df31770f938440d336831e6e7
Author: Ian Rogers <irogers@google.com>

perf synthetic-events: Fix bounds and union member access in mmap2 build_id=
 synthesis

Fix a critical logic bug in perf_event__synthesize_mmap2_build_id() where
the wrong union member structure size and offset boundaries were utilized.

> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthet=
ic-events.c
> index 043f902f1bd2e..3a4030835a320 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -2441,13 +2441,16 @@ int perf_event__synthesize_mmap2_build_id(const s=
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
> +	max_filename_len =3D sizeof(ev.mmap2.filename) - (MAX_ID_HDR_ENTRIES * =
sizeof(__u64));
> =20
> -	ev_len =3D sizeof(ev.mmap2) - sizeof(ev.mmap2.filename) + filename_len =
+ 1;
> +	if (filename_len > max_filename_len)
> +		filename_len =3D max_filename_len;
> +
> +	ev_len =3D offsetof(struct perf_record_mmap2, filename) + filename_len =
+ 1;
>  	ev_len =3D PERF_ALIGN(ev_len, sizeof(u64));
> =20
>  	if (ev_len + MAX_ID_HDR_ENTRIES * sizeof(__u64) > sizeof(ev))
>  		return -E2BIG;

[Severity: Medium]
Does this clamping logic fail to prevent -E2BIG errors for very long
filenames?

If filename_len is clamped to max_filename_len (4048 bytes), ev_len is
subsequently calculated as offsetof(struct perf_record_mmap2, filename) +
4048 + 1 (for the NUL byte), which equals 4129.

PERF_ALIGN(4129, sizeof(u64)) aligns this up to 4136.

When checking if the padded length plus the ID header trailer exceeds the
maximum event size:
4136 + 48 =3D 4184, which exceeds sizeof(ev) (4176).

This causes the function to return -E2BIG instead of successfully truncating
and processing the event. Should max_filename_len account for the NUL byte
and the 8-byte alignment padding to ensure the clamped size fits within
the boundaries?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720175455.3645=
946-1-irogers@google.com?part=3D4
