Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792740141;
	b=PvLA5pkSoEYvpPOTn60+OC9QmFFavsKceyqFB83mS3ZbVRgZF0GvLxGaQoI96XrHeyzw
	 ztaKjNT99qGKTBlQVh2GkJFh+Jl/bs/jqmEZRLwoVBRE29vewRAjYkWTAiVwsn4MoMOic
	 aFxVMc55++INi3RtvPZ8oROCBw1Xae5BVpdMtgbC3Rl4ZR67NkCZVsyH2VmPmOwxLOvig
	 eBJb94fE5EnFz3aKfv33rDMlFx9tslT65Fqq+ZieQi/JAWCF8Ud4V8GjNVw3pnr29Ccfr
	 pSCxEzmoHlQeoZMjPnb1NnrU9H/DlNSmwMLEN5OAq+/0zZavtpfDhCxn+AzRL/zfscQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792740141;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NHxKCiFO0pzf6YLOcgCxk8Qqj+PFmka4L6O5dVPjdAo=;
	b=AohRiLp0u3hgMrV9B9vPKapfo3uYBA6p6JCF5jvnTZjnTh7TiyPm5BqdBQ0G4xF3i0va
	 AdpJgQ4/hhto1pW7YxLqphsW5BZC5EOol6Tu/3mr5ipb4oAcMpUC7PJPifkILpEdv3w5m
	 8JqrrPELXtyhJvyFospjMcsSuT0F6Mp32SKZg15EDfAwRKHRenfuYQ0vfaGzevmdJVqri
	 XdtYT+J4BpyqHlkNfMj5tqBUV2SI2O5dulFbV9BaLivXiAce8wEiREic+L/FTN9BBl2Xl
	 mIGyOeISuDb30bEqimpGjsIQFOdlJaCDN6KAlf8b4qIRf4dRDwBuygT3svs3GkzP/Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lrFRp3sT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9E4606A322
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 07:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lrFRp3sT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4F81F031E0;
	Fri, 23 Oct 2026 07:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792740140;
	bh=NHxKCiFO0pzf6YLOcgCxk8Qqj+PFmka4L6O5dVPjdAo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lrFRp3sTMhvSUlcXAg8fR5RHApHxB5w804V+ZAdMmzi7ayQjv+c0h2Bzscv2cNAOR
	 qaA7/pd9NhV9UykP9hERbTGhX67P6cxqb0zdYK08HfIc8whLzskM9pP9ECD9c+kFqI
	 GNuOsNk/z5fXySf9Od3wTBxA0nmKBi8Ok02g6S3vAB/NqIaOSo4CSinZdl7Fhl2idt
	 ZecSq2qcSW3H35PaQVI+sAwQjNFIR9sPrFCDKuqrHiT419EtHS/V46nyvaAYHpCSAa
	 yGZv+KXRGm4sFlhz+SQFLg7LCWeNduqdLFwrM7b/fnUWr45wsYeQXAYJ/zGnwL720m
	 unv56wEGlIqpQ==
Message-ID: <sashiko-outbox-182405@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 02/11] perf tools: Add perf_env__is_same_boot()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261023071141.134149-3-namhyung@kernel.org>
References: <20261023071141.134149-1-namhyung@kernel.org>
 <20261023071141.134149-3-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 07:22:19 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add perf_env__is_same_boot() to compare the recorded boot_id in struct
> perf_env against the running host's /proc/sys/kernel/random/boot_id.
> For live sessions where no offline header was populated, it falls back
> to reading the host boot_id and returns true.
>=20
> Assisted-by: LLM
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023071141.1341=
49-1-namhyung@kernel.org?part=3D2

