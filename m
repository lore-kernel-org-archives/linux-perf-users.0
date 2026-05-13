Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317993C9889
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 21:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778709402; cv=none; b=RIT7fk0GrxhBkHLhR2Hukdt4lWSmQZpiORf7S0nq0Vm37s4L4gxVpi3MQkj31pWuFkLhK0HLxLl8+dEYmhfaU6qIvgr3CEs8NR8xMRkCwforysfzFnaHvhEoW816ZgdO00Dt5VoQ4lgBaRgLYVmT+2iuBgoZbUn0creVddKmUEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778709402; c=relaxed/simple;
	bh=bYRJCBdFVUHPKDp8Z/2p+X0KWnbLQpRONZ2RDRpnboM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ReUf67hUSG3UbccGb8C+NzsB/voHynZkKVuooe50vwUsg0PpM4smwQ92OyYcoAuBtknUJwDh3S/YK2JUF0UrXyc5cJ9i/C+0Wfnu02W/Eb2o69+pWWcZ+g0SaFhNHbo5fSajvlnb9kOtB8D3FnfaQFJgVPAYKuR1jjeDLKAe5nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tAF5t3QO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tAF5t3QO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD509C19425;
	Wed, 13 May 2026 21:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778709401;
	bh=bYRJCBdFVUHPKDp8Z/2p+X0KWnbLQpRONZ2RDRpnboM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=tAF5t3QOMlvOblS2ff/wPMGCgur4fsD0EHWZnrH0qiePhWyhJs1tuGVkY1tmNAYUe
	 36x/RyIN05E6QTxLSPiDUiZMGJxuuT5/LjW55z53K/9Fl8TAiA+IteuVMb0K7Gdxx7
	 yz8gWvkQBN/ZdtFLu69MRhFWNAus5lZeo6PGNNxidos/I7iCpYs0MZN9XPSDT3eB7W
	 mnQlz44xGOwCDsxv+VtLb/on4nWPNaFMEN3N12zkrs0nfrWlgQAJXImBuKLi3Q9KdI
	 FyEryyMe2EOTlYRx04xaHVWYOfI/O7FiBnS8nRKtjnKw6+wxkcTVxh/1LiNy1lzHYI
	 +MP/M+hAixDYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 23/28] perf tools: Harden compressed event processing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260510033424.255812-24-acme@kernel.org>
References: <20260510033424.255812-24-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 21:56:41 +0000
Message-Id: <20260513215641.AD509C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Incomplete protection against `size_t` overflow in `decomp_len=
` calculation allows a massive out-of-bounds write on 32-bit architectures.
--

commit dc8938b0aa70e200085288b43495eb050468d7c8
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tools: Harden compressed event processing

This commit adds several checks to the compressed event decompression pipel=
ine.
It guards against decomp_last_rem underflows, validates comp_mmap_len size
and alignment, and ensures compressed event headers are properly sized.

> diff --git a/tools/perf/util/tool.c b/tools/perf/util/tool.c
> index 013c7839e2cfd..0a5d17946032d 100644
> --- a/tools/perf/util/tool.c
> +++ b/tools/perf/util/tool.c
[ ... ]
> @@ -24,7 +24,15 @@ static int perf_session__process_compressed_event(cons=
t struct perf_tool *tool _
>  	size_t mmap_len, decomp_len =3D perf_session__env(session)->comp_mmap_l=
en;
>  	struct decomp *decomp, *decomp_last =3D session->active_decomp->decomp_=
last;
> =20
> +	if (!decomp_len) {
> +		pr_err("Compressed events found but HEADER_COMPRESSED not set\n");
> +		return -1;
> +	}
> +
>  	if (decomp_last) {
> +		/* Prevent u64 underflow in decomp_last_rem */
> +		if (decomp_last->head > decomp_last->size)
> +			return -1;
>  		decomp_last_rem =3D decomp_last->size - decomp_last->head;
>  		decomp_len +=3D decomp_last_rem;

When decomp_len is calculated as comp_mmap_len + decomp_last_rem, could it
overflow a 32-bit size_t and wrap around to an undersized value?

While the patch caps comp_mmap_len at ~2 GB to prevent immediate overflow,
it seems a crafted perf.data file with nested or incomplete compressed
events could prevent decomp_last->head from advancing. This would cause
decomp_last_rem to accumulate and grow up to ~4 GB.

The mmap allocation would succeed with this smaller size, but the subsequent
memcpy could use decomp_last_rem (which fits in 32 bits as ~4 GB) as the
copy length, copying ~4 GB of data into a ~2 GB allocation and causing an
out-of-bounds write.

This issue appears to be fixed later in the series by commit 7a68686c9f43c
("perf session: Check for decompression buffer size overflow").

>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260510033424.2558=
12-1-acme@kernel.org?part=3D23
