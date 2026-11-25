Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795569557;
	b=eAuyvDZ0OTEq+lPIplzkruazMRqv2Z9Xu5vZ2Y+3U32BCu5w6hzHSvCJPXzy0cG6QtVv
	 t9UlAOMn3eqlo/ErfBZx3DrSpDgSp2f5C3IdggzuBJi3nBx4jI+Qn9AvDGMm17c19WKYY
	 6KY6lVsz9kfDiZ4ZMufMB/axeroI7mgISnFLU5sxETvBhWnxEAqlnbKdcL5nyUmVYpo2K
	 yQiqKxNSE4JtypCJwnFmildjlwjXLL59g70LKepLYlm3hElydmVDENPuPgHpDxrVzcN1l
	 mX3ANaRuFqo3qgo2u190PdLSkYbjO2DLHNuIwO861emVHZFtONDj39wzGZ+nHqo138w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795569557;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MnppyyXNibu6PD6i9x0J505JAt5UPpm2X0CTDGMLkgY=;
	b=m67GE+p8zKu597LpdOgcYkD4F7Ha8aUV2qcgOh72bZrMi79upqLvmNK3z5CGk7gh1CTt
	 Op/5kwmGAWqYMIyNfdYAHlP2OmxqAnUjnLVeP4AT84aQPkhsIKPV94fPvBdOx1Cjg79VV
	 HTrGuCzzWno5hXBYRLzXP7i4j9rtpwh7lkC7AIcSOo/Wp61kECySWxThtOVb/COeujdZP
	 NckwAWNPlgND4GXGrQ005wiqynmKsBZWQmqAq5suAkyRVFyzPgpcaHhxTBd+dJLFC+VgI
	 GCNh/fima8T0Z+gDXRe4Kv5RqxamjoejF49Vl42o/6x2vJIcEXHZkgvq6iMbu+PJ/Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CtBLXO2g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB4C606A31E;
	Wed, 25 Nov 2026 01:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CtBLXO2g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D596D1F000C6;
	Wed, 25 Nov 2026 01:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795569557;
	bh=MnppyyXNibu6PD6i9x0J505JAt5UPpm2X0CTDGMLkgY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CtBLXO2giuQzjp1Db6NoRf3QPXC82UwbLR4+5Qay1rHtudGkmtBstvEhFknNaUiiG
	 5rFKLhdP5Sxj7GY8NYYsVJggfbesr0EBFQP/sW8iqpBOZJNeI54OdIFJ/fjzek5Pn1
	 Le49rrD3ZfGGv193dgjvxnEEHAqeeg3d9WmcacyaeiOrY1Rd1rcTvWBZd8SdtYTovo
	 kxzVAzTmgi/zSCEsLTnOX+oZ2mGkXWKc1PHm7Mt7uvbKn0Sljs6r/OEERE9yaXjIyg
	 A1NfgtyzQDBlCjYa5Ali2D2hUvFKypRuEX4OL9aBqH+Any8rE2eMGuNKR4VTYPogt/
	 5zCxLHDLGoyrA==
Message-ID: <sashiko-outbox-232324@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 17/19] perf record: Add --buildid-offset option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261125005108.1020003-18-irogers@google.com>
References: <20261125005108.1020003-1-irogers@google.com>
 <20261125005108.1020003-18-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 01:19:16 +0000
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
- [Low] perf record: conflicting callchain bits on reused dummy in
  evlist__config()
--

commit ebeb5605bf130a4b58a8b8f7a5e3f1498a1c7f01
Author: Ian Rogers <irogers@google.com>

perf record: Add --buildid-offset option

This commit adds the --buildid-offset option to perf record to configure
evsel attributes with PERF_SAMPLE_BUILD_ID_OFFSET and
PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET instead of IP and CALLCHAIN.

> diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
> index 38e8aee3106b7..77337e1318ab4 100644
> --- a/tools/perf/util/record.c
> +++ b/tools/perf/util/record.c
> @@ -110,6 +110,28 @@ void evlist__config(struct evlist *evlist, struct re=
cord_opts *opts, struct call
>  			evsel->core.attr.comm_exec =3D 1;
>  	}
> =20
> +	if (opts->buildid_offset) {
> +		bool has_callchain_bid =3D false;
> +
> +		evlist__for_each_entry(evlist, evsel) {
> +			if ((evsel->core.attr.sample_type &
> +			     PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET) &&
> +			    !evsel->core.attr.exclude_callchain_user) {
> +				has_callchain_bid =3D true;
> +				break;
> +			}
> +		}
> +		if (has_callchain_bid) {
> +			evlist__for_each_entry(evlist, evsel) {
> +				if (evsel->core.attr.defer_output &&
> +				    evsel__is_dummy_event(evsel)) {
> +					evsel__set_sample_bit(evsel, CALLCHAIN_BUILD_ID_OFFSET);
> +					evsel->core.attr.exclude_callchain_kernel =3D 1;
> +				}
> +			}
> +		}
> +	}

[Severity: Low]
Can this leave both PERF_SAMPLE_CALLCHAIN and
PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET set on the dummy tracking event,
or leave exclude_callchain_user set on it?

When the first event in evlist is a user-specified dummy event (for
example, -e dummy/call-graph=3Ddwarf/,cycles/call-graph=3Dfp/),
evlist__findnew_tracking_event() reuses it as the tracking event with
no_aux_samples =3D=3D false.  In evsel__config(), exclude_callchain_user is
1 on that dummy event, so it gets defer_callchain =3D 1 and keeps
PERF_SAMPLE_CALLCHAIN.  Adding PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET
here without resetting PERF_SAMPLE_CALLCHAIN causes perf_copy_attr() in
the kernel to reject perf_event_open() with -EINVAL, and leaving
exclude_callchain_user set also prevents
has_defer_output_callchain_build_id_offset() from matching.

Should this also call evsel__reset_sample_bit(evsel, CALLCHAIN) and clear
evsel->core.attr.exclude_callchain_user?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125005108.1020=
003-1-irogers@google.com?part=3D17
