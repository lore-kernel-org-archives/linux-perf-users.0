Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784F034A79D
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Jul 2026 20:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784924527; cv=none; b=r2hqE+qY9dpJSX2nFp+pJPu94bJaAjvfWvQYoGtV93fZt8oPHtw1wd/TJNP/20eRFjtvchr8ql69xY7sH7QGmCMUKJAPxmza747ctedvLbbMuaRLI3GjnA0xr6bqFhPZ3AXVmumIHRDPUmH5+YLuj3IGKXepmDI0fbXL8zq9DEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784924527; c=relaxed/simple;
	bh=P/1hXJQ0r2pEJTgigQUNHhOPEB6JMgxO8vlw5O1X3Ac=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PCWnQHpQkbZn6EQwreCRyjbfZeW30ADp4DIwE+kzVq8NkicEcqSh1G6DoiS/Q5ql8TUtsXvo6hKvbX/uAOQERuEZvwUMgsR3AqPL38vqDpLm+X1M22c2xUBlZujEbShFUwoK5qU/TlOtERuKZw0ts6MkZrKhNFOVg69qhCKLl6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFssrW1b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFssrW1b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33811F000E9;
	Fri, 24 Jul 2026 20:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784924526;
	bh=ebcWb2SiLGMVFr0YaIys6dGHfensgOtaep542reRG/Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IFssrW1ba89xSjovhJLzK2Rp4RC3sn4YKNT/pnd/QIe1oQx0OBAbN0bfRLLi5RX9z
	 8fbFqXL8LrURQ4rr/H1mFhH/eUDYNQabKfm1j3eyJKdQG3BeYVkwyJ4d5sYnxOJ0hM
	 dXGz/mecLbzXe6jnCCOAkXQV03BC2BsOlswgqNIze+3PBl8ZXaISH8UZ1UtQkJQM0F
	 /KxovGdUCJ8c5H5ZpJU4sLzt5unje6wfZXbfQgwKqdwK/ASZqLD6ICZZVNirVh+DbX
	 v4vHz+o5cSuWez8wCa+6aRQk0ZT9lk6VvxOQAQAYe9YZ6WBK5dRiw6rVRIVdtZRm0G
	 f1yoF7KymCMSA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] perf sched latency: Add histogram and time interval
 options
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260724201207.661300-1-atomlin@atomlin.com>
References: <20260724201207.661300-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 20:22:05 +0000
Message-Id: <20260724202205.D33811F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Integer overflow in linear histogram bucket calculation allows o=
ut-of-bounds array writes.
--

--- Patch [1]: [RFC PATCH] perf sched latency: Add histogram and time inter=
val options ---
commit 94bdb73befc369d9beaf56650ada8fcf80ad4ac5
Author: Aaron Tomlin <atomlin@atomlin.com>

perf sched latency: Add histogram and time interval options

This patch introduces options to display a latency histogram in perf sched
latency. It includes both logarithmic and linear bucketing modes, as well
as a time interval filter.

> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
[ ... ]
> @@ -246,6 +313,59 @@ struct perf_sched {
>  	struct perf_data *data;
>  };
> =20
> +static int latency_bucket(struct perf_sched *sched, u64 delta_ns)
> +{
> +	u64 delta_us =3D delta_ns / NSEC_PER_USEC;
> +	int b;
> +
> +	if (sched->hist_mode =3D=3D HIST_MODE_LINEAR) {
> +		b =3D delta_us / 100;

[Severity: Medium]
Could a very large delta_us value cause an integer overflow here?

If perf.data contains a massive time difference between wakeup and sched-in=
,=20
delta_us / 100 could exceed INT_MAX. Since b is a signed 32-bit integer,
this would cause b to wrap into a negative number.

> +	} else {
> +		if (delta_us =3D=3D 0)
> +			return 0;
> +		b =3D 64 - __builtin_clzll(delta_us);
> +	}
> +
> +	if (b >=3D NUM_LAT_BUCKETS - 1)

Because b is signed, this bounds check will evaluate to false for negative
numbers, allowing a negative index to be returned.

> +		return NUM_LAT_BUCKETS - 1;
> +	return b;
> +}
[ ... ]
> @@ -1129,10 +1249,12 @@ add_runtime_event(struct work_atoms *atoms, u64 d=
elta,
>  }
> =20
>  static void
> -add_sched_in_event(struct work_atoms *atoms, u64 timestamp)
> +add_sched_in_event(struct perf_sched *sched, struct work_atoms *atoms,
> +		   u64 timestamp)
>  {
>  	struct work_atom *atom;
>  	u64 delta;
> +	int b;
> =20
>  	if (list_empty(&atoms->work_list))
>  		return;
> @@ -1158,6 +1280,10 @@ add_sched_in_event(struct work_atoms *atoms, u64 t=
imestamp)
>  		atoms->max_lat_end =3D timestamp;
>  	}
>  	atoms->nb_atoms++;
> +
> +	b =3D latency_bucket(sched, delta);
> +	atoms->hist[b]++;
> +	sched->global_hist[b]++;

If latency_bucket() returns a negative value, does this result in an
out-of-bounds memory write that could corrupt memory before these arrays?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724201207.6613=
00-1-atomlin@atomlin.com?part=3D1
