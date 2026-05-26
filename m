Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0623B841B
	for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 22:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779833154; cv=none; b=rvoTmm5021tz7Vrn3sS9dy3sUGpxie2TKvbgNIYqQtcHGf0sf6ChrinmfX5CsFjk1GCsqPMUmGiTbJ8sWCjwsRu2hzAylBow469c4Es2lTp8++GhMGUxcmCFZyoAuHS1gE5HqJFksO6UpXeD+Bfy/HbKC7y1xL+PU0q9F4hwf+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779833154; c=relaxed/simple;
	bh=1hk+7wPNTTVtCwpkUQHaCOSPHBManloUh+ZWApQFzAw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Apwz+xFOHxKIsiIObLeG91qNoeF/E9w5mrWxZA+5kzWrtylyLHx4Elv1pGtUgePxQNLA5nJDbmGtG2ANbr3WzH/PsYuOd6+4l7oWde8/kcp63Bw7ehaZACSSTclPWNeD74hxLpY6MvLGd99WbnPQ2dmA1ow2qLJj6ZTgC6FBQTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQh6k4Qm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQh6k4Qm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E866A1F000E9;
	Tue, 26 May 2026 22:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779833153;
	bh=/bYJ3wap9+nKWAPw64t+LknpERSKyLvFUiGtnNkzKzQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RQh6k4QmaHlTaQUHLpQ4+G7nTip+/WO9o/PKs/R14SXJ2npDizjgVFdObHrBAY0Mo
	 DaEwU/E97Rq/vxh3sbdSNAIRVwWqgUHRtQyfWCAH8rsa1vQfSMOUDGnMq7vd7x83TZ
	 njkqbw3RPVeyKVwQpmhQcTF9E7gBBbOUMnV/lP5Pjc/YBG0pohWw8PiszHaF0ZXZDN
	 d6HSE9VDXSGapM6eHN4vbRbzUkYIQHvd9AkWHO+2FjXsUFMZpXcHckCB/3oCq5dwEr
	 1uHTy8nnxlE4zxztI6xVgAW4VqQSBmPxJC/dD+2pBNtXBl07BMCjQQ8F8U0YF/228/
	 O3FejSeF+wPJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/29] perf header: Byte-swap build ID event pid and
 bounds check section entries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260526211806.1193848-13-acme@kernel.org>
References: <20260526211806.1193848-13-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 22:05:52 +0000
Message-Id: <20260526220552.E866A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incorrect `sample_id` offset calculation in `perf_event__build_i=
d_swap` causes cross-endian stream parsing failures.
--

commit b5fb0a97a4ece334d3f6c106328194158f99aa94
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf header: Byte-swap build ID event pid and bounds check section entries

This commit fixes a missing byte swap of the pid field for build ID events =
in
cross-endian perf.data files. It also adds a build_id_swap callback for
stream-mode events, checks NUL-termination, and hardens the reader against
crafted files.

> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 8588e12f110fc..0fac8f4e0e223 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
[ ... ]
> @@ -686,6 +686,25 @@ static int perf_event__hdr_attr_swap(union perf_even=
t *event,
>  	return 0;
>  }
> =20
> +static int perf_event__build_id_swap(union perf_event *event,
> +				     bool sample_id_all)
> +{
> +	event->build_id.pid =3D bswap_32(event->build_id.pid);
> +
> +	if (sample_id_all) {
> +		void *data =3D &event->build_id.filename;
> +		void *end =3D (void *)event + event->header.size;
> +		size_t len =3D strnlen(data, end - data);
> +
> +		/* See comment in perf_event__comm_swap() */
> +		if (len =3D=3D (size_t)(end - data))
> +			return -1;
> +		data +=3D PERF_ALIGN(len + 1, sizeof(u64));

[Severity: Medium]
Will this result in an incorrect offset for the sample_id data?

Since data points to &event->build_id.filename, which is at offset 36 in the
event structure, adding an 8-byte aligned value to an unaligned base offset
yields an address that is 4 bytes misaligned relative to the event start.

However, the event synthesizer correctly pads the entire variable-length ev=
ent
to an 8-byte boundary before appending sample_id using:

PERF_ALIGN(36 + len + 1, 8)

As a result, does this leave data pointing 4 bytes away from the actual
sample_id location?=20

Furthermore, won't swap_sample_id_all() unconditionally trigger an alignment
warning and skip swapping because the remaining size is not a multiple of 8?

> +		swap_sample_id_all(event, data);
> +	}
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526211806.1193=
848-1-acme@kernel.org?part=3D12
