Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793884153;
	b=gVLx61HM9ZLaMEf3fxwZK2oZvJbnTv2+TV3qtyB8U8emb57lWG0kVSnvKCN2MovG1jQE
	 jfGSm0ifGqJlejht+3Q8cG//VFMV0a10WrFdLcn9/Os2M7YSIbBPNpGr9HIisGs/JtWBr
	 tFYvQo7oDNaAfOgQAHmmpQ/p9tBVHZJotn1CCciaIJYdZ68qp0vKdFf2zpALEZklT88pp
	 oBgtAkCzOSAjh/+hKkzCOuKLYn7W04aEQH4nm1D7z1hbw3qg9h1LfkKszFNgYX8Gg425z
	 eupAmTLNTlkk5hdpfFbnPVG4xWo8cQb+FJoH58VH5Wk9D9tZmsT+47201NjWr6f8NXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793884153;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SNhEGCaAGgFK2ofFneIwsfgpU/FHs73i8yxLwxK1Caw=;
	b=rYZCPQvEJC5pQP5s7NKApxyhaGvM7k3ktwglr9FdUxQFjNBsTqJNCYl6/0RptcjZO5Z4
	 VHBVOpmlp+NxuvaBvjnDcJ3giRjsFN0ViLTUD9RHUHzqghtbDn+9C0R8oxMB3VrOCaq0h
	 c+NeJi2o3D6MhZPFjIn0nSmfb3HIgjcf0oEf6XILqjLOKZH3yC/PFo3+hO3heU7jhyueo
	 D6cNZg6WlioAM/h/WY2qnXGxvBZX7OkNXmWrzHfEtsnF/RtBuCOy9ddhlyakiH5FGvjuh
	 poAqiDEkgisSQSFdC4FBdoEeGOCDMg3T9vYNqWFBYJBS8NBG1NLDTxZNh9Kjar5BRmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UwBVvWge;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839EB606A31B
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 13:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UwBVvWge
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441D11F00919;
	Thu,  5 Nov 2026 13:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793884153;
	bh=SNhEGCaAGgFK2ofFneIwsfgpU/FHs73i8yxLwxK1Caw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UwBVvWgeZmCNBigdfMBiz8KCMasT4wW14XxWRmI2yWdmWdhcSdUcR6D9/VmmfiHxE
	 i/o26ehN7r8zAZDlX9mgc0WBjZqGg6mnqooILKprrBYzCgqqLUqjlww4fXKzUFPKYq
	 6z0ae7XtyZCrZHyCvLAkd6ZHHP4Q/mAjXdNaj+QZIs6xwYEI4S/M6xdxI87ELP3Tec
	 IcGoq8i046Aia/nLNoVl6xZa0kDD3vB7oy5giMhKZq3Y4CfH2FfSC8B5bksBCzVHoK
	 T3apALgiQbEw8ki1QeXgxnz/4Fk+KIFcF5pKYbpfdWfm4TTZVaAlVoOhr0r/jIA3+R
	 vyyeqTLmTx8ag==
Message-ID: <sashiko-outbox-199122@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/19] perf arm-spe: Use generic snapshot search
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105-james-cs-unformatted-per-thread-fix-v4-11-7759e0ce2449@linaro.org>
References: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
 <20261105-james-cs-unformatted-per-thread-fix-v4-11-7759e0ce2449@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 13:09:12 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The new generic snapshot search gives a similar result as the
> reimplemented version of it here. One slight difference is in the
> pointer fixup. SPE has:
>=20
>   *head +=3D mm->len;
>   *old =3D *head - mm->len;
>=20
> Which gives exactly the same result but written in reverse order to the
> generic one:
>=20
>   *old =3D *head;
>   *head +=3D mm->len;
>=20
> SPE also had a special fixup cases (if (head >=3D buffer_size)):
>=20
> [ ... ]
> are treated as PAD packets and discarded during decoding.
>=20
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> Tested-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-james-cs-u=
nformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org?part=3D11

