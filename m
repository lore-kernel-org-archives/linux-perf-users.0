Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795569127;
	b=a5SKTi0o+cz1ESS2qHl5aEl5CcsSNGeZHBE2zM4WKKNbZgVq8vEfTXRpbMKuNdXuX+Yj
	 1YQ3hjzdpik5GKByIO9qWVDf9013hw03xKVDoaB/ek3s959k8nLrP4hPT4LXn3uvQBH8U
	 KDKw3laywX/x3ZBYnQrMoqCs59CX9gl54rcVFmd1NPRo4+IJV55PjJBywCcggIvP8N9O9
	 UAOn0ycbQt9cnz2L+NORiW4xfHxRxE3xOxY6WxK3iqxEGalxZq4Y/QWxYwk2QANSP+kgv
	 B9R+lg3HpxB6xRFOd00oEEACwhdTeIY37DN5ThLge/76lPgg1WjykulOKn49KXehI8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795569127;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nHxppxqAYbOSdI/fWAYPw3vxa6Xv/Pg7On2jElh2liY=;
	b=zJ+mFNk6nURVs1V/0ks8udyfFbI75WNVxcsD6fVQ2gacMPsKjJ1BNUJ/3HtAoosVQ1Gf
	 BgOKlOePs1Ti1oHY1w2FbkT+V6TGOFhJWS2mB8jZ9Jny5FVvzBtCNNWVyEEqEFN9gCZjL
	 j6Q2iumYiKhoviZSMgjLsFIavxtDmtfUcT1i9mus7ZBwom7NX7LohcwGQ+UFB1SnlP7MH
	 ouQ2UYfmwQA0kPDIK+rylEu+8encG6nSpbSUxBu1+8pI16f7pc+/VCgI/m9yZ+ywpuoI/
	 +lRnkMF4f2KHxr3qRms4tINfWi+GljB+65A5tukgTthp2/LAxfmNZJkmpKcRl+N8NWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ikv60zYd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F67A606A31E;
	Wed, 25 Nov 2026 01:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ikv60zYd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853131F000C4;
	Wed, 25 Nov 2026 01:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795569126;
	bh=nHxppxqAYbOSdI/fWAYPw3vxa6Xv/Pg7On2jElh2liY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ikv60zYdjbAmYwfd/0TDEVHXOfwREDWSa4sjCiJKbnRCp9bUWjD6sICjiwBvqTW4b
	 b6Upif25yKJOk0+Oyw0lWQGO2nca47g7QuKpIYr9ZsPPRJeNe2OuCCzLp5jGuRadH2
	 mVTZUvLVhY5pSqQyRfCzEgxSoxaMnznrm2rnykJOy8lXtEMyybSMML5VY8n+ZLnuKw
	 9bzXIcY3z9LYkp+Qx0mlFRyO59kecD/bRAbovzGWKfog0YhzciBl9fum7+v7qbYsQQ
	 jlaVGjRVECaGyfDmbOhjunGu8/mQ7ggkdIoWZh0O7iks5hcH3rM5xWYteYUHlcoP+x
	 2nPsDn/qdJBcA==
Message-ID: <sashiko-outbox-232319@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/19] perf session: Avoid double byte-swapping
 re-parsed deferred samples
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261125005108.1020003-9-irogers@google.com>
References: <20261125005108.1020003-1-irogers@google.com>
 <20261125005108.1020003-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 01:12:06 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] perf evsel: perf_evsel__parse_id_sample() ignores needs_swap
  and in-place swap
--

commit 16d772fa0fe35fd77ab000644b7cb3a76f3ccb40
Author: Ian Rogers <irogers@google.com>

perf session: Avoid double byte-swapping re-parsed deferred samples

This commit unswaps PERF_SAMPLE_TID, PERF_SAMPLE_CPU, and PERF_SAMPLE_RAW's
size prefix in-place during the initial cross-endian sample parse and adds
evlist__parse_sample_unswapped() so deferred samples can be re-parsed
without double byte-swapping.

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 737a8680aaae3..322582bb4f40b 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -3520,6 +3520,7 @@ int __evsel__parse_sample(struct evsel *evsel, unio=
n perf_event *event,
>  			u.val64 =3D bswap_64(u.val64);
>  			u.val32[0] =3D bswap_32(u.val32[0]);
>  			u.val32[1] =3D bswap_32(u.val32[1]);
> +			*(__u64 *)array =3D u.val64;
>  		}
> =20
>  		data->pid =3D u.val32[0];
> @@ -3554,6 +3555,8 @@ int __evsel__parse_sample(struct evsel *evsel, unio=
n perf_event *event,
>  			/* undo swap of u64, then swap on individual u32s */
>  			u.val64 =3D bswap_64(u.val64);
>  			u.val32[0] =3D bswap_32(u.val32[0]);
> +			u.val32[1] =3D bswap_32(u.val32[1]);
> +			*(__u64 *)array =3D u.val64;
>  		}
> =20
>  		data->cpu =3D u.val32[0];

[Severity: Medium]
Does perf_evsel__parse_id_sample() also need to take needs_swap and unswap
PERF_SAMPLE_CPU and PERF_SAMPLE_TID in-place in the sample_id_all trailer?

For non-PERF_RECORD_SAMPLE events (and PERF_RECORD_CALLCHAIN_DEFERRED)
with sample_id_all enabled, __evsel__parse_sample() delegates to
perf_evsel__parse_id_sample(), which still reads evsel->needs_swap directly
and only unswaps the 32-bit fields into a local variable:

tools/perf/util/evsel.c:perf_evsel__parse_id_sample() {
	bool swapped =3D evsel->needs_swap;
	...
	if (type & PERF_SAMPLE_CPU) {
		...
		u.val64 =3D array[i--];
		if (swapped) {
			/* undo swap of u64, then swap on individual u32s */
			u.val64 =3D bswap_64(u.val64);
			u.val32[0] =3D bswap_32(u.val32[0]);
		}
		sample->cpu =3D u.val32[0];
	}
}

When pyrf_event__copy() re-parses a copied non-sample event (such as
PERF_RECORD_SWITCH) with needs_swap=3Dfalse on a cross-endian recording, the
sample_id_all trailer in event_copy still has its 32-bit halves in
post-bswap_64 order, leaving pid and tid swapped and cpu reading the
reserved word (0); conversely, calling __evsel__parse_sample() with
needs_swap=3Dfalse without mutating evsel->needs_swap still swaps in
perf_evsel__parse_id_sample().

Passing needs_swap to perf_evsel__parse_id_sample() (with needs_swap=3Dfalse
from evsel__parse_sample_timestamp() so the trailer is not modified before
perf_session__deliver_event()) and writing the unswapped u.val64 back into
array would keep sample_id_all trailers consistent with
PERF_RECORD_SAMPLE.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125005108.1020=
003-1-irogers@google.com?part=3D8
