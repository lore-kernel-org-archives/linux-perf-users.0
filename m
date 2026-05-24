Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4AB25C804
	for <linux-perf-users@vger.kernel.org>; Sun, 24 May 2026 04:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779595715; cv=none; b=WssZ+nOuzUq6KG+pyloNJmVRF2sVUti6/17w6JtlSBn6ZSlGo89/s/sOdy7c2kAE0RTqVLqynVpnw47IqA3zvd3AM2pGZBz3O2m9CvjNeahKTJUfN/SbgH4gBDbQ4rIjomz0fIowd0sZrpPR8AVVJ1VLmR/ZomRS5sdpm/OJZsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779595715; c=relaxed/simple;
	bh=OU+EpCtDyutcuUvAkI6y0BDE7WHNfddRXAP/eF5pnhE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C+2TfT3+RUnoX+3vzsPpNAff2RVobHIoDc6pOHIGIpNpZjAOWd95E0dHjst8i0JGE1gQF+MksTZ2BC8q3arzIBWAYf5PIlvbhTS9VdPC+2ZsFcW5mWr+wtiHkBk3x/c6BcxlEqSyl0r/a6PANnpoP3vbOrShFZkowRq/fkduNh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pqzg0Qjn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pqzg0Qjn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E0AC1F00A3A;
	Sun, 24 May 2026 04:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779595714;
	bh=fa3d59/1CoGT6N7xwRjVrC+ESAa4F2BIx7dCoTOdCAE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pqzg0Qjnw+/wWqSMZBx/ZbhJVAVZYasi4Dz0N/nuCNVtK6gLU0Y0rJ+wVp1RZkH5v
	 jzuEFFz/ELPy8t57K8Nd9QM558aP/8EfUUoBh60slELPA22W9/4JSbDCezsmsACvLb
	 YfNDw6maUQTWjllxw/ldDtjITsKCHAgWyef8m7ICMvkbm65I2SXg1ePtvE+NMyMhLs
	 J6FK9qaLa6JGDLiuzPI2YznZlYbqsNVUtZMIXCIQfDZd8PwGhJwcNQrc96NkYB6XEp
	 3MRcoTCQytDEctrUXnVAP8A6UecDjM28suzGDRY5+V9w1KdihTMGVxNQiASx7dR6t0
	 lbvuLscA4RGsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/29] perf header: Byte-swap build ID event pid and
 bounds check section entries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260524032709.1080771-13-acme@kernel.org>
References: <20260524032709.1080771-13-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 24 May 2026 04:08:33 +0000
Message-Id: <20260524040834.2E0AC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The newly added `perf_event__build_id_swap` callback ignores the `=
sample_id_all` flag, failing to byte-swap the trailing sample ID fields of =
stream-mode build ID events.
--

commit ef67469fd36e5fce5748002d1210d212fdcc1c74
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf header: Byte-swap build ID event pid and bounds check section entries

This commit fixes cross-endian perf.data processing by byte-swapping the
build ID event PID. It also adds a stream-mode build ID swap callback,
enforces bounds checking, and ensures NUL-termination for build ID filenames
to prevent hangs or out-of-bounds reads on corrupted data.

> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
[ ... ]
> @@ -686,6 +686,14 @@ static int perf_event__hdr_attr_swap(union perf_even=
t *event,
>  	return 0;
>  }
> =20
> +static int perf_event__build_id_swap(union perf_event *event,
> +				     bool sample_id_all __maybe_unused)
> +{

[Severity: High]
If sample_id_all is enabled, perf_event__synthesize_build_id() appends
id_sample fields (like timestamps, PIDs, and CPUs) to the end of the
PERF_RECORD_HEADER_BUILD_ID event payload.

Since this callback explicitly ignores the sample_id_all flag and does
not locate the end of the filename to call swap_sample_id_all(), will the
trailing sample ID fields remain in their foreign-endian format?

> +	/* Only pid needs swapping =E2=80=94 build_id[] is a raw byte array */
> +	event->build_id.pid =3D bswap_32(event->build_id.pid);
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260524032709.1080=
771-1-acme@kernel.org?part=3D12
