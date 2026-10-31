Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793427351;
	b=cspTl0Nf4Xb1H6MmP5r5cZmfQQ3fF7JPy4+1BnC+tRfMsICsqDHCRz3rf8iKcKCAuh8R
	 vJjs/4pmf09ZQLs/3s8xaUJxbxE+rnomcrcQLMJeNaFtQxYRiZZAK01odonU6WSZO6/NU
	 kRhEUt3bAQa2o/4OYkpCn2VaHMUnyjrgfW3Zk5uUEp/vje85HVGjy7z7mcr1C336uqPM5
	 DV+v48cuvN4Yf7BVg1fDy++/X5i3UMaGn6YfNjeiomjtQp4qXzK/7uwngdM5FJGL5XU3g
	 HEXJqLJ13rX5n4y8NjJTpkzQ+NtyYZkPJkPU+cRLAzPtLSixbr4GK42LyRpFKsHiQrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793427351;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6SAPhStgskZ3/Kbb+Kc3vmxkFmycCrYzErbtoPMpR9c=;
	b=W35GR+pZ1YTgwSXkguVAF9OV0lxt8pC/An1qjunRk390sFEhyINJ9/WfkYkdGbDUGiBZ
	 ehWfPj62fHaq770Atzosa4bzeVg84CfqQGyCNe4GzrLNaRuhw9c3NcZRTgMmlE9+ZJHLH
	 CH/P00UInjzEX4TpTkTwXmdJ9p73vZeTAL00iS7/gmH20qe+cDq0sCIH6b2rZl9HtmEi+
	 SuEH8oqSxgEL63o2F0BzzXqadJO3UhKAnrDG5ClnYvimYm7QnSZ1+KcraV2yueh43YGwa
	 Uqbmstr8EMbYTToyA5gYYRcwfv1HNKrVTVcJ+Kakfc/mn31uzBfxa6B4XQ24OkLHCeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T58NbKNZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B2F606A31A
	for <linux-perf-users@vger.kernel.org>; Sat, 31 Oct 2026 06:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T58NbKNZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15511F000C1;
	Sat, 31 Oct 2026 06:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793427350;
	bh=6SAPhStgskZ3/Kbb+Kc3vmxkFmycCrYzErbtoPMpR9c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T58NbKNZFDq2XMefMwutC9l3U3omuN5IsBfJQ1dam8fn6aHLFmR32M9GH2BU0uuic
	 leC+bqrCMiBpkZRMvjHF4/vyCDIhzIrTnIo8yRo3hnDHxUkHghpWxkIEFOSYZYOaBn
	 Zry2zfG5VAS2eRQurBzt83JxacHm1fZQ3Bc32MvnBNHSN2Mrk6v6NiOiXUA5+kRNgu
	 cypShnU2/YfARlgkdB9gChZ8eZOL/Hw0rM0oiqvlXbdSnzrKsP46EFuX8NNGB+hGUP
	 eMvrCqdtQfbRardH0uj1L1SB0qOy2F1553jRYkwLXRwjSF9tCi7a85KEzOcnV+TYgN
	 0v7Kaq8lyOv6Q==
Message-ID: <sashiko-outbox-191783@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf docs: Correct JIT_CODE_UNWINDING_INFO
 specification
Reply-To: sashiko-reviews@lists.linux.dev
To: "Letian Jiang" <letian.jiang@outlook.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <CYXPR84MB347640EF284BED04EADB0B4A826C2@CYXPR84MB3476.NAMPRD84.PROD.OUTLOOK.COM>
References: <CYXPR84MB347620A9EC3D829B4279F138826D2@CYXPR84MB3476.NAMPRD84.PROD.OUTLOOK.COM>
 <CYXPR84MB347640EF284BED04EADB0B4A826C2@CYXPR84MB3476.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 06:15:50 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The JIT_CODE_UNWINDING_INFO description places the EH Frame Header before
> the EH Frame. However, jit_add_eh_frame_info() uses the beginning of the
> unwinding data for .eh_frame and the trailing eh_frame_hdr_size bytes for
> .eh_frame_hdr.
>=20
> Correct the unwinding_data description and the eh_frame_hdr_size field
> description to match the layout consumed by perf.
>=20
> Also document that an unwinding record precedes and applies to the next
> JIT_CODE_LOAD record. perf caches the unwinding data and uses it when
> processing that load record.
>=20
> Revise the mapped_size note to describe frame-pointer-based unwinding as
> a possibility depending on the backend and valid frame pointers in the
> generated code.
>=20
> The libunwind-specific use case still matters: its EH Frame Header fields
> through fde_count are read directly from the ELF file, while lookup-table
> and EH Frame accesses require a mapping covering those addresses. An
> empty lookup table can trigger frame-pointer-based unwinding fallback
> without mapping the unwinding data. This does not impose the same access
> requirements on other unwinding backends.
>=20
> Signed-off-by: Letian Jiang <letian.jiang@outlook.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/CYXPR84MB347640EF28=
4BED04EADB0B4A826C2@CYXPR84MB3476.NAMPRD84.PROD.OUTLOOK.COM?part=3D1

