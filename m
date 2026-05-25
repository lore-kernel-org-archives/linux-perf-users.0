Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A4713B293
	for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 02:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779675455; cv=none; b=N/S+kwrp93eS/0MoYM8WzZ888WxJJ5BHAOMRy/0KGprAWC7YjngqN7qYhZV7+sWjS2pSBXprInvnGijFUey7vZPzZK7efXJfu1vKZ/d5Y1THyzHyYGc48xRCekHKNWC5d2GTTyqnMa2dxoTU0oxcCCGGPPqtnl+p/5kaVw+crJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779675455; c=relaxed/simple;
	bh=oDI5l1fa7cpeiKeVhGsp63cRXBl7sLele+EPYSB73FU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bEDgeiu9rg2uN2x4j6z0JKJd6S5wUTsJD+uT8SKsxbArAeASIiRbrwDcuTWg9OwZErNvNcqNwgJjVUV+E/0OYKm7QU5pPrVgjz8qhHhTpVKM6XazHa+ZwkwxW4exYHruptyuziWE46wA4q4NqJ3b5SABpy53b6WQ6WleCWzrRz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjUGd5Zp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjUGd5Zp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2BB11F000E9;
	Mon, 25 May 2026 02:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779675453;
	bh=a2KSx331Plrbqm89AuoVGP65Y7JpNartP4ulkRAlZ5c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IjUGd5Zp4ywmwBy9rjoqhVpwfd7UATE7JrZXVQKgK+QylW8whPPqhYbjc2m/uHZUb
	 cMpFQUhJBzPDdm2Goa0aFviQDiUFv3TYHK+3YrIWgTJ0KK4xD4o5QjE+kw/y8wwdNM
	 JyaTWsXwq/6+63ZnOvTG7nXm10+qG0DOh/+OQOxRw4Gx7qcSoacoGYMiWJOzt3ji7u
	 ypQdqH8Wa3dlrZIv4i3RPMRTw7biMcVuMaN80nuz2iSv2gsyDBMvMJVYs7i1IxNvTl
	 CXyjnnmOYYhZqK3S/SCgWlv9aq/wfXUWmrfC29jYX8UA1vishJ/EIwwmzP6AREPAz1
	 oRxCO6sbbfKLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 24/29] perf tools: Harden compressed event processing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260525010550.1100375-25-acme@kernel.org>
References: <20260525010550.1100375-25-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 02:17:32 +0000
Message-Id: <20260525021733.A2BB11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch introduces a misleading comment claiming that `perf_sess=
ion__process_compressed_event()` checks `decomp_len + sizeof(struct decomp)=
` against `SIZE_MAX` to prevent 32-bit overflows, but the check is missing =
from the implementation.
--

commit 8986e6b9eaf27b5fb5e29d70385ea196a5ce7f23
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tools: Harden compressed event processing

This commit adds several hardening checks to the compressed event
decompression pipeline. It aims to prevent underflows, validate event
sizes, and verify the presence of the HEADER_COMPRESSED feature.

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -3861,6 +3861,23 @@ static int process_compressed(struct feat_fd *ff,
>  	if (do_read_u32(ff, &(env->comp_mmap_len)))
>  		return -1;
> =20
> +	/*
> +	 * FIXME: perf.data should record the recording system's page
> +	 * size =E2=80=94 it affects mmap buffer alignment, sample addresses,
> +	 * and data_page_size/code_page_size interpretation.  Without
> +	 * it we assume 4K (the smallest Linux page size) as a safe
> +	 * minimum alignment for comp_mmap_len validation.
> +	 *
> +	 * No upper-bound cap: perf_session__process_compressed_event()
> +	 * checks decomp_len + sizeof(struct decomp) against SIZE_MAX
> +	 * before allocating, which handles 32-bit safety.
> +	 */

[Severity: High]
This is a pre-existing issue, but the comment added here claims that
perf_session__process_compressed_event() checks decomp_len +
sizeof(struct decomp) against SIZE_MAX. Is this check actually present in
the implementation?

Looking at perf_session__process_compressed_event(), decomp_len is a size_t
variable. When adding the 64-bit decomp_last_rem to decomp_len:

    decomp_last_rem =3D decomp_last->size - decomp_last->head;
    decomp_len +=3D decomp_last_rem;

Could this silently wrap around on 32-bit architectures?

If decomp_len wraps around, the subsequent mmap_len calculation would wrap
to a small value, causing an undersized buffer allocation. Would the
downstream memcpy() and zstd_decompress_stream() functions then use the
pre-overflow sizes, resulting in massive out-of-bounds writes?

I notice this issue is fixed later in the series by commit "perf session:
Check for decompression buffer size overflow", but wanted to ask about the
comment claiming the check exists here.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525010550.1100=
375-1-acme@kernel.org?part=3D24
