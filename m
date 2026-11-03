Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793738449;
	b=2y5Cev1CcQ9uUQe02q1EjpRatira1b7MvQ+t9H0armSObvahKStXFRTJenPewlnSk3Ls
	 rK4d3J1hA0EmIP7MRzqiZDDduoQRS97Dn6Lpwpg9preVc0+K5WJwL0PQ+eisSEGrtUh0O
	 gMvr6uW0CB0R7FVWgIdKtLNRMyWJfrmuXIpfvF6SeqdCs/80Jw0qcAnmHuYS+PvUHDOJ1
	 7gIlg+Ou91vyCQj04TcX+6YYyNIZ+FasGNJcmQfGsBdngKB3wsAvhJd0i65FIIaJxNOPE
	 2EF6AiCjWgfzqi0qVVe4FbJe3ssQhclXQF8nosZffzTSXRaG023xx8csbfeoCjmZQug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793738449;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0ygIecNos5fhhYWBBlv18a0ZELloZzSkuo3NfWF4iIw=;
	b=s3lJ1pFfc4zoZQeINnRO7etivT4EsZeOmtWUUOxpmvPg7NbdgMbDAlucKZn07yhOHTH2
	 Q2As1fDE8B7LpwlHg67FT/z3oijfWFD96SX67aobJGIg9CaoZoF3xMCGOxoUGZiQDQFFX
	 ZeX3aB/5Vuy9HKqms37Ttz+joH5Z88ODPKEmPB9Jdl5w2Bzwzn6jUdVJW3Cw5h/cHtFwG
	 ZKjt8HibyeFTU024k9ro8WfbSYJ+NrAP5Uq5Tky5A/dECfKZMMqj7sBtuwZu31m7xrrB+
	 kc9VDFQI2R+ZKovTO1E+EBsvWzSqqCk2yxmNaWnTaRhI8bN58iECJE8k40+13QwDySw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=exW4gBnp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4D2606A324
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 20:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=exW4gBnp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05C21F000C1;
	Tue,  3 Nov 2026 20:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793738448;
	bh=0ygIecNos5fhhYWBBlv18a0ZELloZzSkuo3NfWF4iIw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=exW4gBnpdDZCn6I2QPI3bS+DsCZR/Ba6FMIgbsFKIJbrRBvR987fWkTShnRS3CGFN
	 K+rKSYvJPxfBSsMxBWhMLCxRSKlfvb7MdWOr0qKoo9rYpXk/htCClov6z6AXNDJQ0T
	 EzgPKnYQaMkxl6AS3IbjZT7Zb7UHK/G4XvGRjL7RXOkZ/ODSpKTbPMJ9VQI4HzB4FW
	 1UGNJuTW6DDcDfo/ROT4IZ9+y9ljj1P7j5ZmLv3WcEGBGmiEIl9EtgTqqVmgvHlle4
	 PD2sqmeKB3O+hXM/C1aHvFgDXQdyGIm64weG21zL0lFB4WFm43hUwduJO2kvx75Lgq
	 5GUYFQ32i4Vuw==
Message-ID: <sashiko-outbox-196000@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/11] alpha/perf: pass PERFMON_CMD_LOGGING_ALL to
 the logging options call
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261103-alpha-profileme-v5-1-bbe3937fbf3a@gmail.com>
References: <20261103-alpha-profileme-v5-0-bbe3937fbf3a@gmail.com>
 <20261103-alpha-profileme-v5-1-bbe3937fbf3a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 20:40:48 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> alpha_pmu_enable() passes EV67_PCTR_MODE_AGGREGATE to
> PERFMON_CMD_LOGGING_OPTIONS. That constant is the counting mode bit for
> PCTR_CTL, which belongs in the PERFMON_CMD_DESIRED_EVENTS argument. The
> logging options call takes a flag in bit 0 where 0 means "count all
> processes". It works only because EV67_PCTR_MODE_AGGREGATE happens to be
> 0.
>=20
> Table E-18 of the Alpha Architecture Reference Manual gives bit 0 the
> opposite sense, but the PALcode in the ES40 and ES47 firmware agrees
> with the above: it sets I_CTL[SPCE], which enables counting for all
> processes, unless bit 0 is set. Linux never sets the PME bit in the
> PCB, so if 0 meant "selected processes only", nothing would be counted.
>=20
> Add a name for that argument and pass it instead. No functional change.
>=20
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-alpha-prof=
ileme-v5-0-bbe3937fbf3a@gmail.com?part=3D1

