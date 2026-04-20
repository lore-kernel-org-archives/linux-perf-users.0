Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83445220687
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776645860; cv=none; b=ekrsZ7Dk1xio6iYD+A1USQlPEIR6y9wPIjqMmKuaX7BAMHuMnq3cdqQ7JHpFZxtXF+45QuQ2guHhWOT9c3QHsDBQn+9NBKjiZBjrYrD1i6l4sg+ItmnPfSgpiTBxJJMrL5jP53u+4NNGLzLQgSh6vUyY+7bXPs/lzGaeuU9H5DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776645860; c=relaxed/simple;
	bh=6TYL6K9X0njMXqwTWCNyJ2RWswF75FMWUO+mM/T4n3g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bJeiJO34iExLr1putnLfCpXTjE4LMlRRfpyqQx0W9VU+5TrQXkkymqnZkfDZyu+r5ZqRsMwBTw4Xs4EN4caY2szCXnrtL5tNo9GulNlaq1vFepspeDVqs85Qocz6iEnJCGFY4MbFkes0ByjoWCuz/HA9rP6LR0S+d/Gu0r9Tu98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTKcon++; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTKcon++"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13106C2BCAF;
	Mon, 20 Apr 2026 00:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776645860;
	bh=6TYL6K9X0njMXqwTWCNyJ2RWswF75FMWUO+mM/T4n3g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=UTKcon++t3ak6Gjj2m1JMbAPxN9+XmarhFWEkb184MRicVyiNteY9hKGMfFFpGS/s
	 hY9KvkufI644+q8HZ5XlQynVMkLyfOfFFn08CHMEj3+3Hog0v1UgMpMEy9304VNers
	 6aFD7Igc05cox5X+ckSdy4bT/K0/mmpyuIYCWSzfBZdIhzwgdNNRYfTD1VTy3fVfnw
	 a6SlAsmusdaAvo7S83KwuUpr+f5gLFFYY56O3RW0STrbjFVm5VBxBiSxgj8/1i6zwv
	 6l/N/OON++OwKIlM5dX77xSfqNed7geTgXCc8/NJWXE62fBn+Bah8aN5Xb611uV2Hp
	 4YyvCQks6GxJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 09/58] perf data: Add open flag
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-10-irogers@google.com>
References: <20260419235911.2186050-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 00:44:19 +0000
Message-Id: <20260420004420.13106C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] File rotation via `perf_data__switch()` is broken because `data-=
>open` is not reset when the underlying file is closed.
- [Medium] Memory leak of `data->file.path` in `open_dir()` when directory =
creation fails.
--

commit 62a658949040d29ba799d37896461f00cb2dc798
Author: Ian Rogers <irogers@google.com>

perf data: Add open flag

This commit adds an open flag to the perf_data struct to avoid double opens
and ensure only open files are closed. This helps with python integration
where data files are opened before being passed to a session.

> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> index 94dc534a73866..9a7195c68a16d 100644
> --- a/tools/perf/util/data.c
> +++ b/tools/perf/util/data.c
> @@ -360,9 +360,16 @@ static int open_dir(struct perf_data *data)
> =20
>  int perf_data__open(struct perf_data *data)
>  {
> -	if (check_pipe(data))
> +	int ret;
> +
> +	if (data->open)
>  		return 0;

Does this break file rotation via perf_data__switch()?

When perf record --switch-output triggers a file switch, it calls
perf_data__switch() which closes the current file via
perf_data_file__close(&data->file). This sets data->file.fd =3D -1
but does not reset the newly added data->open flag to false.

When perf_data__switch() subsequently attempts to open the new file by
calling perf_data__open(data), it hits this early exit and returns
immediately.

This causes subsequent calls like perf_data__seek() to attempt operations
on a -1 file descriptor, aborting the recording session.

[ ... ]

> @@ -375,16 +382,24 @@ int perf_data__open(struct perf_data *data)
> =20
>  void perf_data__close(struct perf_data *data)
>  {
> +	if (!data->open)
> +		return;
> +

Does this cause a memory leak of data->file.path if directory
creation fails?

In open_dir(), data->file.path is allocated via asprintf(). If the
subsequent mkdir() call fails, open_dir() returns -1 immediately.
Because perf_data__open() receives an error, it returns without setting
data->open =3D true.

When the caller handles the error by calling perf_data__close() to
clean up, it hits this new early return and bypasses the call to
perf_data_file__close(), permanently leaking the allocated string.

>  	if (perf_data__is_dir(data))
>  		perf_data__close_dir(data);
> =20
>  	perf_data_file__close(&data->file);
> +	data->open =3D false;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D9
