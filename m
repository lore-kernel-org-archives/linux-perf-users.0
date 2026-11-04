Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793767652;
	b=ICTTGaQY9mHLuloEJHvssea/nlviGCCbUXc4Z4gUKwMSU29EHQ8DbPIxBO/KDHdm4K0c
	 KyuKV9be9vW1dB5sHoNCyz8f7JSstp/IuKiDdW4G2P4If4QdWZ0vAlcZmmN8D2Vupa2XB
	 32C7UU2NQsZdyHW+w+I9svc1HxcNdGRSpPmLTMoTqZg7MNvjDaJLaIwODtmbHlJf3wh/O
	 vRPvMzgZckmchI3l99Xi+5KjWOzZUI5tVcGXqwkEd+1l6L8pgdkCAG850svdtR80HGjFy
	 IDjvaX9EIStn4FshOP5EDz+xyVwXPNnRPUP5UxgwwSdM9FXPCFlaqLKHMJ9p9SyJv1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793767652;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YVKYE3Iv1Ah2aw0jaX6tBGKB3Q9mddrXzUNsQol94/s=;
	b=PJWWvuKZK0OHkWPWVFQ0/MWwuc20yd8rsOdd4sIgoiI2N8a4VH2NZTIVX7uJwfJXGmlD
	 R/x1/F6+csJGY4HQGideKVRQZMDQbgqHA8SLCoZGapiEVIoCJvt12S6osKDVR4CcmTN1Y
	 B1ZVNq3WQyVCm9O/29R91KXwZ9vkDVbA3yT1Tt9Jw8q2wgnDGIQl70rGKiQ4YPJ+LW6nO
	 fNRBfnJX81OYuePvWNFNUwFajIYzFqQp+uVT7afC3NHIDFmaMRvs6PO8D7OrU5ZKP9Vno
	 0bqYPFFhapl4IXI/4mHZqUe+yt+S6FopPymXvJjj+CpbFepqu/SM6r++rGxt3HAI/ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UoCi2gcY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE754606A31B
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 04:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UoCi2gcY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427EC1F000C1;
	Wed,  4 Nov 2026 04:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793767651;
	bh=YVKYE3Iv1Ah2aw0jaX6tBGKB3Q9mddrXzUNsQol94/s=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=UoCi2gcYGVj5TDjJ6wUP/UnB1KDKjAjlL72zmS36ahsY0XWnxfv0pGW4QO44ScGUx
	 VO0iQOT+zYwXesH+OLfhUwTjKm9YfQdteB6rkeawBRZmk35TH/X4jHy7KAN5hzH1Sr
	 6o7JWLeqfdIpm2MZIolqOzSuzNV9K/oXcggHrwuv20F8RZ8Gp8mzCQBuhA2tQfFFC/
	 tj34W9dkfZ1Z/v3km+TuGi+IcuebEKv4lss1zPwGnyaigfWbrXh6V+SCGDjh/aiK40
	 YfZGNvyflNs0RgDzRj8UCXBdXOyUTyCaCbuTrNoSfNA7GdbLKvaLGalTfmi07i1/Yd
	 WWHZQj4wB0EXQ==
Message-ID: <sashiko-outbox-196662@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 24/41] perf script: Display metrics for perf stat
 record data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261103234502.1008382-25-irogers@google.com>
References: <20261103234502.1008382-1-irogers@google.com>
 <20261103234502.1008382-25-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 04:47:30 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> perf script displays the counts of each stat round read from a perf stat
> record perf.data file. Also display, after each round, the metrics
> requested on the perf stat record command line (or all matching metrics
> when --all-metrics or stat.all-metrics=3Dtrue is used), computed from the
> counts aggregated across CPUs and threads, for example:
>=20
>   $ perf stat record -M insn_per_cycle -a sleep 1
>   $ perf script
>   CPU THREAD         VAL         ENA         RUN        TIME EVENT
>   ...
>   cpu_atom/cpu-cycles/  metric:      0.7 instructions  insn_per_cycle
>   cpu_core/cpu-cycles/  metric:      1.3 instructions  insn_per_cycle
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103234502.1008=
382-1-irogers@google.com?part=3D24

