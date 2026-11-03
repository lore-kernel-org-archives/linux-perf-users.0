Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793675449;
	b=CCb0XhMXlfSXVQ7ZV+h2L4iHD7deeZc50mkThE/mH3zi4hHgw/V5nXMJHGszfW0COcNh
	 HMm0I+XeT2P49fLkivwQYdjp2ZCH1fOt/L3XD5ZRv4BUHN6FrdaeBb0mJitDnOqcNWFhd
	 W8VSW57w0Mo4hEoIule32+cQIZ43CnVtdq8hIBUv/6/7Nq/qpwpee99f+5XkACx0DmSbM
	 NxW6+ydLM+lKyQv80Ux/fS3V5PBpOeeezrJiyWnG4k7Glzn6qc7AnzkgtEWb+Lg+xBbzW
	 t92rHCCJKHfrgJFsdDNZ6tR3gPyM4MMW/N54HhNjmlDmdO2rDI1FbcG9+nB/ZQuR2Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793675449;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=B0Hc41BPLGJ8fuQziO5PWovZ32of8vYvTPjbIKQKEVw=;
	b=QCNM1DxXI6YL+7FbxWC/CAWWm2u+xG0QsQDNrHjh1HtNXlCs+aMKycDk8kMzp/xrLzQY
	 8FbE5lckBK1YvriStYvRASIV1zBtaEwYay09Mky5q8xThBMtPfTPnEsPoO8FjPlRnhBHO
	 D6hax8ljUtm/1DZoV7+l+viWPvqW310rdwZXrUy18AqLSduQFX/oFiQZdjzx8K4YB8/Ux
	 X1u17z1yljtVAQJLLFOqhAcQeKOK4GwK7rllb1sXTl3vmSaJ5UWhlnmMMNDchT1UsPxLA
	 RaELvCNjNaVXlZk04Rley8bgkm+xP4hFxta2QwWVdooVctfLAO5zkQfpFt4afNlmxqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IsJr+KLW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3043606A324
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 03:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IsJr+KLW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C721F000C1;
	Tue,  3 Nov 2026 03:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793675448;
	bh=B0Hc41BPLGJ8fuQziO5PWovZ32of8vYvTPjbIKQKEVw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IsJr+KLWEO3FXMvlUINvPgDj20mu2Vepp08PBpd9gyONRnLHRfmXVJvUcP6r1LZAi
	 uvKzEI+ZYmROFYEFtQvFCxkAj3R5i6+OjYmcVZQD+n87v6egHlV01OnSX6eaUU+7F4
	 vEB1Y8YNBXzkjZKvRudkoM0WgsiLt0XaKVPlX4saMQX5Puwlka6IxLOvGkK9kc16oR
	 3lpF4M4VOaK/hBox+a3RUX+foGN8KcdL1lPsUMH+Q8Rsoy4z4ogQMffRR5KlOWdM5L
	 No1mKr0iReNOUExcns68BJPE3OSThmSfgyoMv+SLiwWt7rMZQ6EEtlDu20z5HJc17N
	 4Ir5Q8puAvB2A==
Message-ID: <sashiko-outbox-194494@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/7] alpha/perf: do not report user registers from
 the entry code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102-alpha-profileme-v4-4-61e00f5e1da8@gmail.com>
References: <20261102-alpha-profileme-v4-0-61e00f5e1da8@gmail.com>
 <20261102-alpha-profileme-v4-4-61e00f5e1da8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 03:10:47 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> perf_get_regs_user() returns task_pt_regs() whenever a sample of a user
> task lands in the kernel. But exception entry runs with interrupts
> enabled, so the sample can land before the entry code has saved the user
> registers. Only the part PALcode pushed is valid then. An interrupt
> taken on the first instruction of entUna, say, pushes its own frame on
> top of PALcode's, which overlaps the rest of the user frame, so r7 and r8
> read as the interrupt's r23 and r24.
>=20
> Report no user registers while the interrupted PC is in the entry code.
> Such a sample also gets no user stack dump. The range is all of the entry
> code from entInt to the end of the save in entSys, so it also drops the
> registers of samples that land after they were saved there.
>=20
> An interrupt that nests on one taken in the entry code still reads the
> incomplete frame, as its own PC has left the entry code.
>=20
> Fixes: 9280e99d87dd ("alpha: add HAVE_PERF_REGS and HAVE_PERF_USER_STACK_=
DUMP support")
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-alpha-prof=
ileme-v4-0-61e00f5e1da8@gmail.com?part=3D4

