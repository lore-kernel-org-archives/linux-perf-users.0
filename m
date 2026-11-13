Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794600306;
	b=IafUf81QK3BTEU7zpHMmyLJlxL+JUXn8hkM7ib8JAYia/2tXz2iTEB3MIRGV72uKnWEa
	 PDq9n9TTWCo0ALOP30SqWi1PD4HSsTuxN1Bce/grrKBbysBwl6YsffLV3QPkl/3cyhWDV
	 ug985Tfvqyw2T3Lb7YvhSOViOdoO47vHj4gVPjd7iB9hVQh5CgXUudadC1CuXFjX+xBg3
	 U0zkpaAJB3RwvhD63vebSFI9axOOU7iXcV73liLNAeugTjCNkaImew9iwOqZqW5nsUH+x
	 R7ADZAsxSFFgVFzV12fTmfNg6kR1lJSep0N/cwZrscQXG5RA6bJAIuNat05JF+EjZOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600306;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lKvBrG2BDxdVGG2nSWgHW3d9JNVdRf3f2kjY+LycTT0=;
	b=RKAHji1ip/mEjVcJ/k4ehhtzhLzIJ6So8zi1847lfyB/+1cFIHBBZFNfcsxErx4bWYHl
	 TX/5wADWFWfCVJxX5DlF5/moxWHLqOe9Pnyiu/kf6CWJBcgUG7ON4dA9D4btWHzkRbRes
	 dByWbRvQIdUOoZFlAuh1BuNd+OQ2QpTIRURKNM4z2U5NCOHuXNDru0/dWCEt+6nHuB6A/
	 Bh8nffIEi/OdevmFw6n5c3BerI4MrPSNhywR/PprGJenYH16SFN5U8Olg1X2xBPA1inag
	 eaqwjfmfRMcCCcAsAWE4tbKBlp1BSQKgMcwuI2KBj2y+eS49d2n56pRmli8HJtEXk7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ek03RS//";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDD0606A337
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 20:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ek03RS//
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B781F000C4;
	Fri, 13 Nov 2026 20:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794600306;
	bh=lKvBrG2BDxdVGG2nSWgHW3d9JNVdRf3f2kjY+LycTT0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ek03RS//4icYZVhEaQ8cfXTrJYGPmro9TJa+M6E7kKF0h8+pp6l5J48UD+jA2kIr5
	 lxj0HlSgm2mhcWvS41HjnSWiN2Zf/ho//BWv8TBnpBOIeXI29aPfgSF71hG+V6ZHD3
	 9bzTTtdAiVwBszA1dfWlsvfo2RcfVs2dDw7ClqVDN2XBux0eAOVqr03DhKilMlAgkF
	 upVh4TFpjPRa2IGQKkfptkMyq621YNNkkLdBlLkbytND4mFTQanHkw2HRo8AOAIr+X
	 SMjBJZZ5arm9Tjx1HsYeCbGhUxoVVM15LhaCd8lug+ZvYkMMSkHTvo79wemjT0PDM7
	 CoofqsClkHYMw==
Message-ID: <sashiko-outbox-213609@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/30] perf script: Fix metrics computed from samples
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113195335.2865725-3-irogers@google.com>
References: <20261113195335.2865725-1-irogers@google.com>
 <20261113195335.2865725-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:05:05 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> perf script -F metric computes metrics from the sum of sample periods of
> the events, but the computed values were wrong and the output was
> garbled:
>=20
>  - perf_stat_process_counter() replaces each count with its delta from
>    the previous raw count. As counts were left as deltas, the next sample
>    computed negative deltas for the counts of all CPUs and threads other
>    than the sample's. Restore the counts to the running totals after
>    processing.
>=20
>  - Metrics for all events were displayed after every sample. Only display
>    the metrics associated with the sampled event.
>=20
>  - The new_line callback started a metric line that the next metric
>    started again. Each metric starts its own line, so make it a no-op.
> [ ... ]
> of the sample periods of all CPUs.
>=20
> Fixes: 4bd1bef8bba2 ("perf script: Allow computing 'perf stat' style metr=
ics")
> Fixes: 3622990efaab ("perf script: Change metric format to use json metri=
cs")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113195335.2865=
725-1-irogers@google.com?part=3D2

