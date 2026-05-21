Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B4530FC03
	for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 01:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779328357; cv=none; b=npTqkXjFHpUFjpHsJ1oPUkqIZl2+t54vLY1DM1HlEmpSX8371CTv/5uP4O/wvxF3iAV6o8qDbjzo6DKA+eogRidCk/RcSQz61Pxb21xvQDnJvYkBv8OJE9qUF/pBSktXGCvK9EZDuxJaSYPUXc+kI5hq+UXd9uKNzbG+AeFcbJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779328357; c=relaxed/simple;
	bh=o5Any/+/VHlosVvj/Vs8F5TQA/pgCbRYz50VT5k/Z6I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qjkC4PB+3wQvWof1dtgGRaE+4SE7j4YhGD6DgbWBj9gYR6MezcOvIGNLYUfs+nuVpaxYE61O/r9/kMBQdoRZQaPkN/BYWJyEf4EiLICqeD6gXSkBqo9C7E70snIj5fXH4Ui439+MMqqODGc7Ni4m0Jgn7RbB+zpsYurViidC5fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRkEax9b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRkEax9b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54DC21F00A3B;
	Thu, 21 May 2026 01:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779328347;
	bh=ALm0SRLbaFkK1gXKzppni754QuEOTkhAV96zbwFoAS0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZRkEax9bd0TaMn5CX3YEVz9G5MC3/gTtm+BIxtP03aayLOnPRjjMcqIGGKX6ZtEQM
	 FzEpnGqsRUqKLJcU8XLKG3e8A+zNfCqwexkkyxSkumqCIAWGP0cy0VSmFpj5oE4v7I
	 3Id8x4ErcsNKmU+kuZPeQCAAJlCBdocj6ZPGmVl8LZlmDWPQ0ygfA8XnzzK7bCFSLA
	 T2CT5NgI9j2eeTWvJe5kMH6HXZo4y/XLsR+8STyG8WDWo4+eXKAjUnXHtDTByiAMEY
	 HzF2yM7nNx78s3dA5b9C8q29Ic107ceMz1N4gXdmsmHwkgNvOXWjmRUuuIFengP/k+
	 9wNePmgF5eqrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/27] perf session: Add validated swap infrastructure
 with null-termination checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260521011027.622268-8-acme@kernel.org>
References: <20260521011027.622268-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 01:52:26 +0000
Message-Id: <20260521015227.54DC21F00A3B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf_session__peek_events() incorrectly advances the file offset=
 by an unaligned or garbage event size on critical parsing errors.
- [Medium] TOCTOU race in native-endian event processing leads to integer u=
nderflow and massive out-of-bounds read in the newly added perf_event__chec=
k_nul().
--

commit 2f80ab41c25d6a21ae7c19d9e2f07ede302f3108
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf session: Add validated swap infrastructure with null-termination checks

This commit changes the swap handlers to return an int instead of void, all=
owing
them to propagate errors. It introduces perf_event__check_nul() to ensure s=
tring
fields are null-terminated before processing. Several bounds checks and size
validations are also added to various swap handlers to improve safety.

> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 415693a3450a7..8c5b3323d0ee0 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1481,6 +1603,25 @@ static int session__flush_deferred_samples(struct =
perf_session *session,
>  	return ret;
>  }
> =20
> +/*
> + * Return true if the string field is properly null-terminated
> + * within the event boundary.  Native-endian files are mapped
> + * read-only (MAP_SHARED + PROT_READ) so we cannot write a
> + * null byte in place; skip the event instead.
> + */
> +static bool perf_event__check_nul(const char *str, const void *end, cons=
t char *event_name)
> +{
> +	size_t max_len =3D (const char *)end - str;
> +

[Severity: Medium]
Since native-endian files are mapped using MAP_SHARED and a concurrent writ=
er
could shrink event->header.size after the initial validation, could end
become less than str?

If that happens, could this regression cause max_len to underflow to a
massive value, leading strnlen() to perform a huge out-of-bounds read?
Would it be safer to check if ((const void *)str >=3D end) here to prevent =
this?

> +	if (max_len =3D=3D 0 || strnlen(str, max_len) =3D=3D max_len) {
> +		pr_warning("WARNING: PERF_RECORD_%s: string not null-terminated, skipp=
ing event\n",
> +			   event_name);
> +		return false;
> +	}
> +
> +	return true;
> +}

[ ... ]

> @@ -1976,11 +2176,25 @@ int perf_session__peek_events(struct perf_session=
 *session, u64 offset,
>  	int err;
> =20
>  	do {
> +		event =3D NULL;
>  		err =3D perf_session__peek_event(session, offset, buf,
>  					       PERF_SAMPLE_MAX_SIZE, &event,
>  					       NULL);
> -		if (err)
> -			return err;
> +		if (err) {
> +			/*
> +			 * peek_event sets event_ptr when it read enough
> +			 * to know the event size (min_sz and swap failures).
> +			 * If event is NULL or size is 0, we can't advance
> +			 * and must abort.  Otherwise skip past this entry.
> +			 */
> +			if (event && event->header.size) {
> +				offset +=3D event->header.size;

[Severity: Medium]
If perf_session__peek_event() fails and returns -1 because the size is
unaligned (e.g., event->header.size % sizeof(u64) !=3D 0), wouldn't this
regression add the unaligned size to the offset?

If the offset becomes unaligned, doesn't it guarantee that all subsequent
reads will interpret the middle of events as headers, leading to a cascade
of parsing corruption?

> +				err =3D 0;
> +			} else {
> +				return err;
> +			}
> +			continue;
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521011027.6222=
68-1-acme@kernel.org?part=3D7
