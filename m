Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793608303;
	b=iAFZX66l5UkXI9eMp4zYxu/8hMGty0l43gYp/CLeXnxyokRKq6GPOleeU9/Z5xFGECzl
	 2zsgSVaI0ysh1iAAfrbOz+yQxigLn41joO9Mb+uBwm/8P3PsuhNcDggCv2xHkS34r5Pw7
	 0GoKbRx3EJVSMO9So57WSAD/w2hLrdmbxgVEZBzjKhrBoXybwGUbcf1qSJ4VKj7gbU5m9
	 f2+LmxlCq2Xn60K5ZSKB5mWh2QwuQKlHJgLpqQY1owVHC0bT2Q/79gloIXZ+PJmNSFDrM
	 jQfFs207nxRzVhaY1SQJ9ENDWgKlo6FQka9GAuMUhf0Y9gSi0ML2tpdp+i7/tnJ/HUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793608303;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NaA1VUivfnrnRerXlc8rdVNlkmFDH2ZRNiahABFqU1o=;
	b=ecbL8U5b2JoIdPGB1xgv/FwdeB93tX/KhAmu1avDMJDWOJ+OzYz9v5qoBBBPUdRGe70D
	 eYssB7dqdosb5QzIuw+VDdkkJiRVb20aUTp7qwjqK21+PyJjQZLnG4Bpx8KBFP72lPZKC
	 8V1JkNyvZJZPOy9c4mu/gVDxbQKOKMV57dKDq21x+yf4cbK/Pon5W/411icq0oECg+wPo
	 OCT9ZPiO6eX6vDtpJL7+T3/AH08E0io27k5ml7FP+6IhSdPq1qmbg4CMxm0T6F/756C3j
	 hYMcbgRHOePBT3x1TgXLFv262cJMvTJuwecZTHdSEB5obW8tv4OzCnp0LjvJzbIz+fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RgkLki6r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205EF60A2619
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 08:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RgkLki6r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C631F00A1E;
	Mon,  2 Nov 2026 08:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793608302;
	bh=NaA1VUivfnrnRerXlc8rdVNlkmFDH2ZRNiahABFqU1o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RgkLki6rMc9lX1JXc2eB19XcUmPGj5iXd2qzFDYb9WiTsiHEqAwsUm55o4OuvZnUs
	 uuMHfcSL/9JRNZAZIYlR/4URENO9XNLmiRTgUaCF8fHt/yrHIw/onJACjyKGvjHwOZ
	 2vUSUkC9ylt9es6zZ/e1XgeZeICHoZsafjOlF4lc8X+RmYJW+MO7EUqmHGUMiBdrO5
	 QOV8YE3OCKcZCUCFhwCcAsuZGmqecZ3VK+p5c9MY6hDGc8/sTRVaCp70vH/AF6OMYi
	 3VLpb3bjq6D2FfSrGxZ2u+YQ7GlYG+CeCAXKqNjAxUYppObfbliVAYYM9W1wfrRVZn
	 PsHg7ERQyaPtA==
Message-ID: <sashiko-outbox-193114@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] perf/x86/intel/pt: Reset stale MSR state on CPU
 start and resume
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102074039.26983-6-adrian.hunter@intel.com>
References: <20261102074039.26983-1-adrian.hunter@intel.com>
 <20261102074039.26983-6-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 08:31:42 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The Intel PT driver caches the last values written to
> IA32_RTIT_OUTPUT_BASE, IA32_RTIT_OUTPUT_MASK_PTRS and IA32_RTIT_ADDRn_A/B,
> and skips redundant WRMSRs.  Those cached values are not invalidated when
> the hardware state changes outside the driver's control.
>=20
> After S3, hibernation, CPU replacement, or similar events, the hardware
> MSRs may be reset while the cached copies retain their old values.
> Conversely, after warm reboot, kexec or kdump, the MSRs may retain values
> from a previous kernel while the cached copies start at zero.  In either
> case, the cached state no longer matches the hardware state and the
> driver can wrongly skip WRMSRs that must be issued.
>=20
> In particular, after resume the driver can restart tracing with
> OUTPUT_BASE left at its reset value of 0.  Depending on the output mode,
> this may cause Intel PT to write trace data to unintended physical
> [ ... ]
>=20
> Fixes: 295c52ee1485 ("perf/x86/intel/pt: Prevent redundant WRMSRs")
> Fixes: eadf48cab4b6 ("perf/x86/intel/pt: Add support for address range fi=
ltering in PT")
> Fixes: 9a6694cfa239 ("perf/x86/intel/pt: Do not force sync packets on eve=
ry schedule-in")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102074039.2698=
3-1-adrian.hunter@intel.com?part=3D5

