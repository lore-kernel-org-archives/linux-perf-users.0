Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793942096;
	b=M2LDHrzq9xQjNZz/o3E6gorhlgNLXICihp3799RLy/wwDMMIfVGAT0cHziH+mtzzrJ35
	 /ArbBYqZbrrisasPTC37pGCB3A1uJOeNV/xPO5/9ECgKmWCSQSN+0yZnJkN7cONYaobGH
	 AU/orvuoWer7IyexsZjOifUPsiJMGR4bJETQu/eZOi6RvaAlzZcTY2wiO98skX0sLe+zO
	 QfuREx1QUT3sBdlb1IReBgj/nCIDsCXQHylIKuGLNaMFusnds4u+oFTIqVA5yNsO8RvbC
	 s2QtujTx+Sv88Sc48xOIr1XncYaxVH4G9R44GLOyWUTvQxPE3iiRsF1qooy86Z8e0Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793942096;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=clSnnLV1EvdVPl5f7/JwDfbig6rIdyUSMbJBacuaHF0=;
	b=CUC1DwZEmkjP1DwHTZEG0M8fpw7yacHK+WEIqtb+9XhTuqKWz7PiI4qNRPBOb7a2SKVP
	 zqbtEVQsvGf45vrJxHUgi5R5ESEWkIAazrvrxzc4jdkk6v3D2fEDjrjAuhDcRaA2YlQRk
	 qMN9CGGCfCZwGUi2wpxipQiPo1b0AM1Hu48kmeGWix05dXQSzGnhxSOszHaaEjjenYRbz
	 erLDJ+2Bf7Uz0/fB5u3Y13R0hcMrleA53Joq84rmpCmbhWNNJqAPrZVH9u+eWzNUZnlqf
	 ExvZ/dr08JFrylqKC6fpe7YCvU4jrLQeGZ9nx7vVtuhiU79Dbrq76w4nVu5vP8AnL1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DPIzMGdi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366CE606A31B
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 05:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DPIzMGdi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C201F0089F;
	Fri,  6 Nov 2026 05:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793942095;
	bh=clSnnLV1EvdVPl5f7/JwDfbig6rIdyUSMbJBacuaHF0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DPIzMGdiyvEDvkijy8Sr95DqZBTxPTLRY1NA31A+uBZwbwiPkEFJ3We2tbv02jtkQ
	 lSu66srqgkkJqnk3Hnk7KcHOyYG+2wceorEPw0P62wMHpthrFat+vhx6e5HlufbHZL
	 p9PGRN6pF57nGdjkMnCtGRG0AEd/0wXcL5cISlYmmIY8ROVohJHay78/rqEYCa3mS9
	 d3pt/h6XNGhXobRMLZMojPFmszAnW1lIIXdWEUOGJxsbNXzcEY2jOcxA2c7U3IoYbT
	 lCnay5n/CIiFxgiqhXX3F66t2Fzk+tnHWnJoiYo22z00lyP86RqqYLixSiWfn5yMTN
	 Iv9JKYdU8MZ0g==
Message-ID: <sashiko-outbox-200806@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 13/14] alpha/perf: sample only retired instructions
 for precise events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105-alpha-profileme-v7-13-c474e892abb0@gmail.com>
References: <20261105-alpha-profileme-v7-0-c474e892abb0@gmail.com>
 <20261105-alpha-profileme-v7-13-c474e892abb0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 05:14:55 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> ProfileMe samples include instructions killed on a wrong path, which
> show up as hot spots in perf report although they did no work. On an
> EV7 loop with a randomly mispredicted branch, 19% of the samples were
> killed before being mapped and another 48% later.
>=20
> PEBS and AMD IBS op samples are of retired instructions only, so make
> precise_ip imply the retired filter, unless filters are given. The
> profileme bit still selects every sample. With cycles:p, both kinds of
> killed sample went to 0%.
>=20
> DTB miss samples, whose instruction is aborted, are then dropped too:
> cycles:p reports DTB hits only, and the misses need cpu/cycles,trapped/p.
>=20
> The kept samples carry the full period, as do those AMD IBS keeps when
> its swfilt discards others. So in frequency mode the sample rate, and
> the event count perf report estimates from the periods, fall by the
> share of killed instructions: to about a third on that loop.
>=20
> Suggested-by: Ian Rogers <irogers@google.com>
> Assisted-by: Claude:claude-opus-5-5
> Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
> Tested-by: Magnus Lindholm <linmag7@gmail.com>
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-alpha-prof=
ileme-v7-0-c474e892abb0@gmail.com?part=3D13

