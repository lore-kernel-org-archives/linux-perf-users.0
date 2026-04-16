Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC43F18AE2
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Apr 2026 01:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776304496; cv=none; b=SQYYyE/SCOB2uSkWT13i5s2f1Ov09bZd6wiezTcEVUFgwtg1bhVeK0+2Nc8YMQyCHbWuMzUN/orqTEPbgISy1380sXwB9lmfsvTGwoEjVeJmHGf3HGbcaXrdiwvTJHhUnldpQepUYLjVdhE6+kqPgPPZVMpk3cFV6i3yOJCKLOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776304496; c=relaxed/simple;
	bh=R6mrDUVBYFD2BvQw8AZs6mMoJ9qjndFCbBZfYZjTd7k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T6c62OJ3HgZynNNk02hYTUKAPeXLSXx6DwejlDZsKCD6RdCaDA0cisDDQnBDp2KpP/vLwh4tasV+3QrTTDozTDGijYvpUQ2SFhWQ0R37kEQIg62IbvugRsoKp0iZYgPNnaGIVhepjIVIIPva18SHWT7io7r9yvqQ1TR1Sn48nuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9UlMEmY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9UlMEmY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40645C19424;
	Thu, 16 Apr 2026 01:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776304496;
	bh=R6mrDUVBYFD2BvQw8AZs6mMoJ9qjndFCbBZfYZjTd7k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=d9UlMEmYZ+uvL6LcbdePRQSUl6hrZPNmGzjtRLcnpbIYYqOENrjI6VQDw/Yr5361F
	 eSYPrS2Vqq9MOIigANZL8jaFcxazNN2kF/CLWVvhmYsRh9TOQlgpCDUFqO4oeWFeos
	 v2gn2ojUfgdncVZpNw4xWShF0EzX+bo6OtCdpkdtcK3MHjMgH2ca0ykSDdXTjBJbF6
	 DTKKx2e1Rq2uYAH5bF7ZWUYLQ7VYALrKhn+zPG28wnGV7lP+uGF29nbnaHSisFe1Tn
	 uX2WRWCWE35oUhCcVbN7JAXIgxhSNSJ08GYJlnSG53I/hGlL/ep7Ut1L2kyl+YZ+Kb
	 kd5VzFZs5rPDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] perf header: Sanity check HEADER_EVENT_DESC
Reply-To: sashiko@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260416001424.362797-4-acme@kernel.org>
References: <20260416001424.362797-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Apr 2026 01:54:55 +0000
Message-Id: <20260416015456.40645C19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [Critical] An integer overflow in `nre + 1` causes a 0-byte allocation, l=
eading to a massive heap out-of-bounds write.
- [Critical] `perf_event__attr_swap()` reads and writes out-of-bounds on th=
e heap due to an unvalidated internal `attr->size` field.
- [High] The expression `sz + sizeof(u32)` can overflow to zero on 32-bit a=
rchitectures, causing a division by zero crash.
--

commit b80424f0e9f35df0a96f24ae74fd6b6f3c4d97e2
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf header: Sanity check HEADER_EVENT_DESC

This commit adds bounds checks to read_event_desc() to prevent large
allocations or excessive loop iterations by validating sizes against the
section size.

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index f8acd06ae9235..696f19739074e 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
[ ... ]
> @@ -2101,6 +2101,13 @@ static struct evsel *read_event_desc(struct feat_f=
d *ff)
>  	if (do_read_u32(ff, &sz))
>  		goto error;
> =20
> +	/*
> +	 * The minimum section footprint per event is sz bytes for the attr
> +	 * plus a u32 for the id count, check that nre events fit.
> +	 */
> +	if (sz =3D=3D 0 || sz > ff->size || nre > (ff->size - ff->offset) / (sz=
 + sizeof(u32)))
> +		goto error;
> +

Can the expression sz + sizeof(u32) overflow to zero on 32-bit architecture=
s?

Since sz is a u32 read directly from the file, if an attacker crafts a file
where sz is UINT32_MAX - 3 (0xFFFFFFFC), the addition wraps around to exact=
ly 0
in 32-bit arithmetic. This would cause the bounds check to divide by zero.

The preceding sz > ff->size check might not prevent this because ff->size is
read from the file header and could be arbitrarily large.

>  	/* buffer to hold on file attr struct */
>  	buf =3D malloc(sz);
>  	if (!buf)
>  		goto error;
> =20
>  	/* the last event terminates with evsel->core.attr.size =3D=3D 0: */
>  	events =3D calloc(nre + 1, sizeof(*events));

Could nre + 1 wrap around to 0 if nre is UINT32_MAX?

The new bounds check restricts nre based on ff->size, but if ff->size is
controlled by the file and set to UINT64_MAX, nre can still be 0xFFFFFFFF.

If nre + 1 wraps to 0, calloc returns a minimal valid 0-byte allocation. The
loop below would then write out of bounds on its first iteration:

    for (i =3D 0, evsel =3D events; i < nre; evsel++, i++) {
        evsel->core.idx =3D i;
        ...

>  	if (!events)
>  		goto error;
> =20
>  	msz =3D sizeof(evsel->core.attr);
>  	if (sz < msz)
>  		msz =3D sz;
> =20
>  	for (i =3D 0, evsel =3D events; i < nre; evsel++, i++) {
>  		evsel->core.idx =3D i;
> =20
>  		/*
>  		 * must read entire on-file attr struct to
>  		 * sync up with layout.
>  		 */
>  		if (__do_read(ff, buf, sz))
>  			goto error;
> =20
>  		if (ff->ph->needs_swap)
>  			perf_event__attr_swap(buf);

Is it possible for perf_event__attr_swap() to read and write beyond the buf
allocation here?

The buf allocation is sized using the user-provided sz. When
perf_event__attr_swap(buf) executes, it byte-swaps the attr->size field ins=
ide
the buffer, and then uses the newly swapped attr->size to determine how many
subsequent fields to byte-swap.

If sz is small, but the embedded attr->size in the payload is large,
perf_event__attr_swap() will swap fields based on the larger internal size
instead of the allocated sz bytes, causing an out-of-bounds access.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260416001424.3627=
97-1-acme@kernel.org?part=3D3
