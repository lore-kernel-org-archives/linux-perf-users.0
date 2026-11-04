Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818360;
	b=QKjZcLrEFvhu6lcbIfAVxl0yCmKNj39FBbAppFoFWGpOWtA0Nsf0ogzakT7oN2AZhJ5/
	 SD9OKtfq3lhZeFcPEKEm4y0gIEfCHEdyt+Vs8W+Xn4ZQwfwbdQ7V2k1HGe9099k1Wedrt
	 xiGAWrFg+7KTSwTh5t8Ri/x8g7YgMnhK1WHCSUjI5kXURoI5ncihKcD4IiH89XEfzZCIS
	 tBYLVZxLBmSxVulMwo5X6xfiOCEApHpIEkIAmyRHpODzPuOuHlkKOavF8dsXI9I8Rd6Wh
	 zvXkNoDabqcoXSu8UgONuRJzVF9YA0J/dasV6S4W9cgia9WYSmGAyPaTbD29UHbI3GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818360;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cQSF+FeSWnC6avhvJ2nmlUbuQXMvRj1rqf/1dBOaSDU=;
	b=WyjpxGT6xEstJfXjLCq9XIs6ClA7Xa2fOIWV0zl95YA0jA42As8NhpyPqARVgff6WlOH
	 ZCcGWZ37973dKliO9KkYYYLW75QtfXIfrvRWKYan2es2ua8eFkDPwynIDEZ0tCNzJjSgE
	 9f2/j5nGxcBRya6c/5eZ0B/DvAYjfYpVwMvfy5KBkV3E2QgxkapUdVIzZTnWLAdhPkNyr
	 z3remWvvhGgY31ZN38zdxqeVdrzzH3wMljxVYOr+sZiEgK1J2BUmOaaoTBvmLi8kBSPPN
	 1M4EVyvMdvRqpQyZ/vfrjkqSesW7MFgjqR/QRAf69NmFIBDjJ88XTw9j6bUJgjTWAQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d8PPGt5W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48289606EE99
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 18:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d8PPGt5W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B70A21F00A16;
	Wed,  4 Nov 2026 18:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793818359;
	bh=cQSF+FeSWnC6avhvJ2nmlUbuQXMvRj1rqf/1dBOaSDU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d8PPGt5WysgKt3vsh7Hg8enoRWgoNQQBfOXbcTUr/EORbGgs21cs6qxiL3UB+UVLj
	 xWAFtqxv5kCo6/jboFrxhdHix26SrcwpVQbcU/zODAF6kOnYVoU4sFDtBfkhzftKSq
	 AECE0ZCBDvYLKpVREQ/bsljxSqq3FnZgkjPU1zQ6+XYOuh/BedqL/itrIC4HaDKpD3
	 yBxC5hegXJc0p6CNZ9WcHgYdtFTMEqSNd6iBVcsKHZ02lC1yMGc3rf+cVTgVKUJEwb
	 GGbLi3xSr0SFa1odWGClqQ7VVuvwzcqX0tTXHfsKK2Mk5pcmoPhn0RDBdKSJK06+nq
	 p16Jp2lL6gdpA==
Message-ID: <sashiko-outbox-197884@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/13] alpha/perf: pass PERFMON_CMD_LOGGING_ALL to
 the logging options call
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104-alpha-profileme-v6-1-63362e9290a3@gmail.com>
References: <20261104-alpha-profileme-v6-0-63362e9290a3@gmail.com>
 <20261104-alpha-profileme-v6-1-63362e9290a3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 18:52:39 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-alpha-prof=
ileme-v6-0-63362e9290a3@gmail.com?part=3D1

