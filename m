Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C0A37881B
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 18:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777141205; cv=none; b=n7pXYK6Q5DaSvY/BtQbzqxA1rz/9TFlnPdlsgld8wwe06AVS5cIb7FTmbYlPlhvhkOXg/5S7E8o2JvVPJ4jeE48gUn99XcfC0T0eHulQv4YYCsmojvqM5j1P8MSB1LFLLlEs0QOos5q7WOdg6ofVk0JyiOnfCar1AHpEerHg0Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777141205; c=relaxed/simple;
	bh=BIKfGVsacYRFxOJoCuo6/TfC4O0/PCPAte2YOu6g38g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZDurLwSjYBtfXCO0w0lCkdYJo0/UoUlrlCmoqwMt0ND1YZkAZ9LoC+n/KHf668XbWs3bE8el+9glKCR10NulMezw4aBODysjxsy4F4LBoS6ZFCsWKy9BYOU+vD/r5OVUUji75CKDqdI/KX83JYg0rR346svlKruFyMuPRRhxU9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9Kot3/y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9Kot3/y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2442DC2BCB8;
	Sat, 25 Apr 2026 18:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777141204;
	bh=BIKfGVsacYRFxOJoCuo6/TfC4O0/PCPAte2YOu6g38g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=B9Kot3/yy34hs+yqfR+yi3GCBtceA0jWAKjQHlzkMwDbK8ix1Px1QK/Tvy9d836Pw
	 gB06Iv8FEhcXohpyL3I1m0woVnxinjUk35zFL0VwWPXfhMl460VXsK8o+uAM0EIjGn
	 LgqUmJJAuZOGplnyRTMY//1yOFdPptsSbQU3PGWeuIIzlAiI1o6A+aoGLEldSfBfIs
	 Dx3YxUF/wADNGPrHkjfmmF2yZoW89eC24V/P86Jt9Rc+FCL7wcDUdxX8keofFhTZhI
	 4PwHrcnJgELEd8Tj9qxauW8IteO8+A/emYW5zOTa4f4rFW2sy1xvPv6hCihpUPkmxA
	 G59W1iExgXiww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/59] perf data: Add open flag
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425174858.3922152-10-irogers@google.com>
References: <20260425174858.3922152-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 18:20:03 +0000
Message-Id: <20260425182004.2442DC2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] Uninitialized Memory Bug in `perf_data` array causing undefined be=
havior.
--

commit 3ce27148af7a0598a2cfebfa260efe575e34351e
Author: Ian Rogers <irogers@google.com>

perf data: Add open flag

This commit adds an open flag to struct perf_data to track whether the
underlying file or directory has been opened. This avoids double opens
and ensures only open files are closed.

> diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
> index 8299fb5fa7da..76f57f60361f 100644
> --- a/tools/perf/util/data.h
> +++ b/tools/perf/util/data.h

[ ... ]

> @@ -50,6 +50,8 @@ struct perf_data {
>  	const char		*path;
>  	/** @file: Underlying file to be used. */
>  	struct perf_data_file	 file;
> +	/** @open: Has the file or directory been opened. */
> +	bool			 open;
>  	/** @is_pipe: Underlying file is a pipe. */
>  	bool			 is_pipe;
>  	/** @is_dir: Underlying file is a directory. */

[ ... ]

> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> index 94dc534a7386..17baf71897d1 100644
> --- a/tools/perf/util/data.c
> +++ b/tools/perf/util/data.c

[ ... ]

> @@ -360,9 +362,16 @@ static int open_dir(struct perf_data *data)
> =20
>  int perf_data__open(struct perf_data *data)
>  {
> -	if (check_pipe(data))
> +	int ret;
> +
> +	if (data->open)
>  		return 0;

Could the new open flag be uninitialized in some call paths?

Looking at perf_sched__schedstat_diff() in tools/perf/builtin-sched.c, the
data array is allocated on the stack:

tools/perf/builtin-sched.c:perf_sched__schedstat_diff() {
    ...
    struct perf_data data[2];
    ...
    data[0].path =3D sched->old_file;
    data[0].mode =3D PERF_DATA_MODE_READ;
    ...
}

Since the struct isn't zero-initialized, could data[0].open and data[1].open
contain stack garbage?

If data->open happens to evaluate to true, perf_data__open() will return 0
without actually opening the file or initializing the file descriptor.

This could cause __perf_session__new() to read from an uninitialized file
descriptor.

I see this regression is fixed later in the series by commit
81cf4f4c4c1266ce2e1faa604bb84ef9cfc8657f (perf sched stats: Fix segmentation
faults in diff mode), but I wanted to point it out here.

> +
> +	if (check_pipe(data)) {
> +		data->open =3D true;
> +		return 0;
> +	}
> +
>  	/* currently it allows stdio for pipe only */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425174858.3922=
152-1-irogers@google.com?part=3D9
