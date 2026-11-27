Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795783623;
	b=Xs1D9FoQ1eDA3PjC0u8t+xLDlJyWXWQnUYVhWHGMyYrqIdqC4K3tmq8kk8PIxZcpBKPx
	 G8rPix1Mle+fF5jVLyIxZBiRFassx1pkF9oPEOTYwWAIJNvq6rKKueZDVB5V85jAuwK15
	 6dRei7EKJX1K3qqrrbTP6xsLPB9YEgEdnDIheMQKwZy+gAdhyDcOqv/z7Wg7gpSLWapNH
	 pa2ZikAggJwf3v4IpDOn29mzxEAPSTNcNfRB7P6nPMJX9bbm5n5cVaZK/oGPngYSo5xxi
	 vvbHlnj9M81kHXCqo1klAcHKt/BSOxW+htbg+OjMuxsm1DDqOkW97W19x0X1YiRNtcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795783623;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=J4ak8nnmZwDjnr7lOSGjc5m7sVijxYV5Wj0iLZ8UbYk=;
	b=JpF0GVaKrG1OBJyQi3Lu14VQgziDu3tpIZoALv4Rj/qB7UZQFBUOwGJN0518YbR2DiDN
	 BM+sA8dNY0I+hfvIfy/IVMalejzK+68JhX0+vThqxVdtR6DRScHEdPzrGW1NWgiswzTIL
	 lXFdbuxOifN3mSVF01zoxvBQuXGJzLpWq5k6PcXUn0JZSaYJjuIiEmh0LtHsVMy8GzQ9/
	 AkOEMDCo0S2gj2CWf5yx8oZSN1md56GxfcubwAd8R4VtGywSHM8GfClIwxQBf7iWTi5pi
	 9PHnh4pqHmtUng7k06/kqKC0Acg4Z9nakaeSZ7Dg/96oD4Dr+z7yqvr52HSTSGEKNPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oGOS7zZT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DC0606A31C
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Nov 2026 12:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oGOS7zZT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 788F91F000C1;
	Fri, 27 Nov 2026 12:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795783622;
	bh=J4ak8nnmZwDjnr7lOSGjc5m7sVijxYV5Wj0iLZ8UbYk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=oGOS7zZTlsywlhQwm0e+bkmL/O9Ru9g2dQVmBbob9bsv3KhocPLix9Ke/KSXuXMV8
	 uM/iYsjE9E5rI7/N333du6LxGMAbRGUoHusKhD0X3XK0pqsA6C3c/opkeeDe8c467v
	 yX5Q53ogmTh85g9SsHfRLhY4/AhQv8GqaR2kMpj/xpW2guGHoaeH4f9prlusnYoYhs
	 hVdB8/UOi3CRmlVwV2aX55TUnqZDd5sJNQX3NWfmUuJWRQzpMGsP+5FVh48BSfcKj3
	 i+NfUvudu5zqryxqoIfQ1KlI+n8OJJ2agiGaO4eNfepFauWTiPXZ+lpeIcAjz5/V4M
	 jW+79d9Fq7q+Q==
Message-ID: <sashiko-outbox-237432@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf arm-spe: Honor --time ranges when synthesizing
 samples
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jan Bernloehr" <jbernloehr@nvidia.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261127123855.78212-1-jbernloehr@nvidia.com>
References: <20261127123855.78212-1-jbernloehr@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 12:47:01 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> perf script and perf report pass their --time ranges to the AUX trace
> decoders through itrace_synth_opts. Intel PT uses them to skip decoding
> outside the ranges, but Arm SPE ignores them: it synthesizes a sample
> for every record, only for the tool to drop the samples outside the
> ranges in its sample handler.
>=20
> Check each record's timestamp against the ranges before synthesizing
> samples for it. The check runs after the --itrace period count and
> converts the record timestamp with tsc_to_perf_time(), as
> arm_spe_prep_sample() does for sample->time, so the tool receives the
> same samples as before. Without timestamps (timeless decoding) nothing
> changes.
>=20
> Decoding still runs to the end of each queue rather than stopping at the
> first record past the last range: record timestamps do not always
> increase within a queue, and on Neoverse V2 traces such an early stop
> dropped samples that were inside the range.
>=20
> On 28 GB and 55 GB Neoverse V2 traces, perf script --itrace=3Di1i with
> --time=3D70%-95% goes from 212 s to 188 s and from 383 s to 339 s, and
> with --time=3D70%-70.01% from 101 s to 72 s and from 188 s to 131 s, with
> byte-identical output.
>=20
> The code and this message were drafted with an AI coding assistant
> (Claude Opus 5.5).
>=20
> Signed-off-by: Jan Bernloehr <jbernloehr@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127123855.7821=
2-1-jbernloehr@nvidia.com?part=3D1
