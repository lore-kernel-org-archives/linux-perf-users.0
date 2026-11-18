Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795041811;
	b=32QK64Y3IxSZM9AuRLairAOEG6yKZE/3KLuzQQ8w17xlqyRHPQvF19HaQ8ViiBpU2JaP
	 N1bGV4dpVzJJ9V6L/EowIZ8fNSE6AzTAeirJ3CS+iWxdqBleEN+bXfxxRDs5nNu4I3cgH
	 pbz2njjMElK7NMwvlXtYDZd94MSkRofkGNik8vVIgQktou/nx8KtzOnImGM1NSIzv8etS
	 ByHt15JgjN2CJXjQbmYMF7Wj/2/6lFJQLLIId0ZZt8yWfK/22RJZFSfFXt4TAhEyb7eSO
	 0Jwlo9g//4QsfrEEeWTOMvv9TKrxutUJwFD76Fcpf+7rICYYroHkp2121YIiuQQmUkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795041811;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TIEsVUimb234Oj+Lqg7oES+FZOp77exSAYuqzOwyiH8=;
	b=OhhF+fpAPRKePL61AbwTqEJFxuAzrL5TaiE/F3s520roLM+0Bna+5UFnDrwAz0+HCqqQ
	 KWjFn8M/jEHBJmJnjjChmA+KywxfowuTIWQcf1pjWnnRpy7VEb0RLPORfGH4/yWVjr3O7
	 03MBjMDruJKMkq1hxxffM5JRAswtYIDIi3qlXGuj35PEKZigwinrCDB9HMdzPrG7iUnqm
	 2qaVYkZz97gDoo9Yur+VSPVWZO16PXJYn494zKQBNqKl1rR0FMXsvrvKljbDUxK/vLr3m
	 owL1FsjcMPbu2qHO7YE+cuZRvRAMqIMIXVFd/r4vcc8OMQ1xqgUFcKsE1DDYXzfD2UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AucfN+dd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6DC606A32A
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 22:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AucfN+dd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03691F000C9;
	Wed, 18 Nov 2026 22:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795041811;
	bh=TIEsVUimb234Oj+Lqg7oES+FZOp77exSAYuqzOwyiH8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AucfN+ddx/vK9OLg35KmmS7ecNQvmscWsej0xM/e51sb7i7SV1KXkCJ4DSjE7yxfu
	 70ljZ1H6C/5NIyQCMDFmZD17j6GvtguddlIZqpV37gk+RztrWshvp6ePpeiUBunPI2
	 A/9R874XDjnUKWUx/iKVeIlyyxbT/0obpPKcDvrxwk/Hcq017CyHV24t7UAi3Tyh6D
	 yWzJ7IM2UAFTz7Sgm5GUaPvL1YNWqsDcefvTKgjaewpwa7LknKh8itD5sPkLnPWi1e
	 Aef+qFVw0YG8+g8MMsJ1vBk2w+aAPe99EeFLvyZkaNUvTqzy4a+p3mkW8Yghxp94IP
	 PuVOjW/UbbpXg==
Message-ID: <sashiko-outbox-222117@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 11/13] perf tests: Fix the Intel PT virtual LBR check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118223725.121500-12-acme@kernel.org>
References: <20261118223725.121500-1-acme@kernel.org>
 <20261118223725.121500-12-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 22:43:30 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> On an Intel host the virtual LBR check failed with:
>=20
>   Warning: Processed 29 samples and lost 100.00%
>=20
> The record leaves the buffer sizes to the tool defaults: the data ring
> follows perf_event_mlock_kb, and the runner's small value left a single
> page, too small for the AUX samples.  Pin 4 data and 64 AUX pages, so
> the test does not depend on the host sysctl, and give the AUX ring room
> instead of the single page the tool sizes to the 4 KiB snapshot.  Both
> fit in the default mlock allowance regardless of the CPU count.
>=20
> Also require the Python perf module to export session: a perf module
> without it, like the distro's python3-perf, made the check fail instead
> of skipping.
>=20
> Fixes: 915d6b14dc0c8971 ("perf test: Migrate Intel PT virtual LBR test to=
 Python API")
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118223725.1215=
00-1-acme@kernel.org?part=3D11

