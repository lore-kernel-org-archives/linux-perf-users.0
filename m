Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795123116;
	b=Xz+tge08qzKhShhAy0y/yKji4svQiIgbrDvkq3HhpVdJ5o/pFZ1nRo8XQbgCbfD3n+RM
	 njL5THMPsBGzTPr8MXaf/VQo37N+acHFWAG9K+uW26NQ9Fhpqk+4C+K/5jSsnyAJLwleV
	 Z6e+TMNpTxaAUfpkmGcpYuwMbaBlcJKCsdD3yRZVCbwcH36KWD8s67A5bZD83ifK5+VAU
	 JGF0UHxU2qo7sPdNIs716NIVAGQ8aC13zdyMS5TeCETx4i7FvQVkX2iequslnt7ZQLwY5
	 NYlXB0PZvGz+O1CE6ZYg3jS1zMgc/8Cmg7r27nNRSuZc0GFy25IE8SMcA41av6/iYdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795123116;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5sufJzSvBAYMIwjFclGSDSlQjKmxr8h8Lk8rzjRUlkY=;
	b=dPcUg4YSFB5I0xL+6v7Hd1oke+rRxTnvcMP41Gc0CstSED60H8PAP/ILAr6vQ1b1Ufrj
	 FdPc+iwYSpm+nx6nfUU8l8sW+jgPPsK3BKzGjB2bS3Vp7a1DU1l479hZ0S8MXcJvAfQAe
	 D5ShfQtpMGSxgITrjxrPnyDfeG7gMrlfGXNY1Cjh1VRaIlZdyPqIwQxYFMfh0nm+ZS/2J
	 KKW0Hc5/31Te9NyNYUIFMMyBmkiUWJXJ6O/Pz/1gAmCuAJ9O0uDlf8ACOCCVCFFnmRLVn
	 jAJ9iGN0lBA1SzOlBbgDJf+MGNX3yHBT7k3I+/QDnWxrOmuhzLVAKwkCwZEnc0x7iKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CDM2Mr5V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4D5606A325
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 21:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CDM2Mr5V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E82031F000C0;
	Thu, 19 Nov 2026 21:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795123116;
	bh=5sufJzSvBAYMIwjFclGSDSlQjKmxr8h8Lk8rzjRUlkY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=CDM2Mr5VuTBxI56/s7HCs1Qe2aJnVXDLQyGmycE0t197j1cLgYTr9/RnKvjshbcJL
	 H1HgOvmTBky0vK6wu17yrvwTI1O6oqqXRMC7w+6jhhQ4Fc8dDjCmiqYNtHpm4E+Toh
	 W0z1vXn8CmFG7lVMrevTYpqHWmJucT/F0FoN36+qy6sKjwag2INjBxEZ/HuM7c/bui
	 FTyCuNclsjdLV2gYsmEIT+HCVK3xHDFqhRPXzPQY4m0g8yBM2sZ6I09+IxR3D4Fzs3
	 S40xC/NtPbATnsywpVF1JJRVT+u1rgAwYaIfS5EB0MQ9xSjzx7xuNNfGWMbOjFUUMB
	 kAyeS5NJtEKrw==
Message-ID: <sashiko-outbox-224087@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] perf/core: Don't let BPF programs read an
 uninitialized sample address
Reply-To: sashiko-reviews@lists.linux.dev
To: "Usama Arif" <usama.arif@linux.dev>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261119211235.99805-3-usama.arif@linux.dev>
References: <20261119211235.99805-1-usama.arif@linux.dev>
 <20261119211235.99805-3-usama.arif@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 21:18:35 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> A BPF program attached to a perf event gets a struct
> bpf_perf_event_data, and reading its addr field turns into a load from
> the perf_sample_data the sample is being assembled in. The verifier
> allows that load no matter which fields the event samples.
>=20
> perf_sample_data_init() used to store the address unconditionally, so
> the program read 0 when there was none. To touch fewer cachelines, it
> now stores the address only when it is non-zero, and
> perf_prepare_sample() fills it in only when the event samples it
> (PERF_SAMPLE_ADDR, PHYS_ADDR or DATA_PAGE_SIZE). For all other events,
> including context switches, cpu-clock and hardware counters like
> cycles, the program reads whatever was left in that stack slot, often a
> kernel pointer.
>=20
> Kernels built with CONFIG_INIT_STACK_ALL_ZERO, the default when the
> compiler supports it, mostly hide this by clearing the struct on
> function entry. With INIT_STACK_ALL_PATTERN the program reads the fill
> pattern instead.
>=20
> Clear the address before running the program if nobody filled it in,
> the same way the SIGTRAP path already checks PERF_SAMPLE_ADDR before
> using it. Events without a BPF program are not affected.
>=20
> Fixes: 7b0846301531 ("perf: Use sample_flags for addr")
> Cc: stable@vger.kernel.org
> Signed-off-by: Usama Arif <usama.arif@linux.dev>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119211235.9980=
5-1-usama.arif@linux.dev?part=3D2

