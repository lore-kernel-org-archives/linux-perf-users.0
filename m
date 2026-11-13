Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794567686;
	b=Dm5x0NCPE2OYePK2a2rI6AvDAmat/mQk7Zj0jloTgcG3NwARVWLZSOschzyMtjupD3tf
	 aF9o8OkJDCC0/4EDmcYnRHvK6mKXzL3KlWPWKIdpv0eedB3/DklGXp/HgkUMKuXcGLUUa
	 1CEwRkUmDqQi3MREK1c0r+d5WEIU7XgCbiR2cucCN4iQlIk8aJyxeaTmXcZ6xhOZ7g2Rs
	 c7vDubE90qMg0dTRdKFe97ncqk6Cvth3leFVyjK9cgTx62uQs60nPbm2qxe4rnvX6lckP
	 KGDpj211LCXcGHidN05QuFUhT5RGO2JFbANTUyVGO2B6v9UGjPyvzfmm2wpnWo/1kWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794567686;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=H6X5oDk9RfFUhMIhUONoJHtu1Krm11CdWtL3nyzFNQY=;
	b=bNeXJ4Hf76Zuubdka2Qn0i+NTzdOV9mws14pUj+IaeynngMUGRZR/EuE3PPtC5hxGAms
	 rQLbUV+v6t0yT/qp1f8zEqdYL01u73bjmDUpnrF/XMa2ByHTsOe/Y8E1HBZXWOd45nyGp
	 sqfavgEVn/oehKKITU3SFTbbTvV5mV5peIyBrdChUpDjnAJUN/ol98fr7EHmDEz1R4zFp
	 zl1BB+Izwzy4JDCPuTt0vzPcKaGPzNQe3Dv/lCeFZ/K9iHLthNdfEZZrRsw3r1C8aQYCf
	 tmCFASk+fyrUh8lUC4KbJTDw8oeyuo36hkFhiDeHQOblaLHZgyEHPnPkSZ3mpQAevjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=etP9b78h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41ECC606A323
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 11:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=etP9b78h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2F31F000C8;
	Fri, 13 Nov 2026 11:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794567685;
	bh=H6X5oDk9RfFUhMIhUONoJHtu1Krm11CdWtL3nyzFNQY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=etP9b78hW8I8BQb+mA4MLD8BEh6oD0WQU+aoLCN7j837ExQ8DvebdjwYtt7N0CVHT
	 MPPbxMuaFB1CW+JdCDfKq8Fblx2y9R6XSE238mTevHIvqu4Lz5o6QKaANkPgWDOl6h
	 a0HyE5MJedE8a88z/Z1MULAjAUOTS0d9QbwFVyiqpn7Ra1/R4LSQkJs8gooVgrQPLT
	 brJ3ZPKItadGqkacWoDcRyRLlUhZ/cUyTcuMUDPKXaxQpfQ0xi4beKPFK6lKkjISet
	 +eyhgzKW52nKd4wzAti90/PKYYeVwpUEhO1T8dyJ05gwwUXcpm/EZb7fsLMTTIyWUN
	 KEtHPTflKfKOQ==
Message-ID: <sashiko-outbox-212657@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] perf cs-etm: Use the packet instruction size for
 stack events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113-perf_fix_gcc15_failure-v1-2-eae592c5ff64@arm.com>
References: <20261113-perf_fix_gcc15_failure-v1-0-eae592c5ff64@arm.com>
 <20261113-perf_fix_gcc15_failure-v1-2-eae592c5ff64@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 11:01:25 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> cs_etm__add_stack_event() uses the last executed instruction of the
> previous packet as the branch source. The decoder already records this
> instruction's size in last_instr_size, including for T32 instructions.
>=20
> Use the recorded size directly instead of reading instruction memory
> again. This removes an unnecessary read and the dependency on DSO data
> when updating the thread stack.
>=20
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-perf_fix_g=
cc15_failure-v1-0-eae592c5ff64@arm.com?part=3D2

