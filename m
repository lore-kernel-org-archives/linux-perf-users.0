Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793941202;
	b=yxP+rkwiJMdjIINbdTKyflDVkpos/FUcG6+rwVugxM4jidafp82GQzblwGBDMiRDGsBR
	 SGpdm+dWidVM+OVgAysKXCMNb1DYVA/jUZ+SC9Apjyiq6cr5wKBqBF6g452frkoiIfXY0
	 edC2ZXbzZpY0CFaee4KUUNA5NcNFbVzxYkBvKshKOvW1YuvMkJWpMkuJJf4C/9lbqNPhG
	 W13CjNkvDkeaUDgDKA4wBK35ZbyQI3i+17avXKoUIIt6cmltTlp/7jZlMuUKfNpJtZBif
	 QB4eZX0LgZ3Z+0WteXIdBzo9BNleHpYSOXUbHJtT4PzRC1gKlBuvvJhlPUlx9Qfbb2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793941202;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IkhM+AWSV+n6OY3rsrAk7bH+XnMG4r8tkgzqH2ZVmZM=;
	b=FcoqYeeRxiwbSZ2fQu4KC+gKPYPJ6WkznsvwD01nh1LjALbMGRvyhVL4utMTsWew9z5J
	 OUJoGYJFiRZlQcJ7Po1E/9MnTmlut3YAjw2fv9mtS+txWz86D3k8holkp69mAOAeLdK4A
	 Nslc6aH1JuZ7X9sWq2EKtiv4Lob/v/anTuoWbgekYonPTNAUpR9GGA9YO7iMZim5lUq/I
	 oLfEJcPLizaXQHzEvmkCYy59bMJPklyNDP0riLyP7k80EFk/cj2mk76EuvA6Dszd1lpeA
	 5QXxrxH0CgBllpk1EtGGBpiw+ORkU517CPrxircVSwt6cF3jVTEjGh0Y8DugCAPjSsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pxk3aFU8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE317606A31B
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 05:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pxk3aFU8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262201F0089F;
	Fri,  6 Nov 2026 05:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793941201;
	bh=IkhM+AWSV+n6OY3rsrAk7bH+XnMG4r8tkgzqH2ZVmZM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pxk3aFU8ASr0eXuJIbSkv0+Rm94jNoP8mig9y70XPfGD7itkG/eo9A0s+yZfRskP6
	 /kzs/x01WR3oXm19faASAJlUBXyul6AIgn4MVLbRsyYwuWu6HASx6Lr3k946hjnIa1
	 hmy3i1h0XPK5c3rCYmJGT+NcjaDfBWUrfLDnkY9WMtgn1mKDSbn3F3g6XuM1aNqdGA
	 SeHmw6hr/OSH7b2sNGVQ4u0iiSQXwLkgBFYXIETcBQgTXM7/dQsHCm+sQJYH7kr+B7
	 +h9KGLSU26cVlNLce0gUQk24IhL3ibHBRurAL1cG6SjbnJ2LDQZR2yOYdIcZnwJffO
	 rLxBPW8Zr1MiQ==
Message-ID: <sashiko-outbox-200783@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 08/14] alpha/perf: attach ProfileMe status as
 PERF_SAMPLE_RAW data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105-alpha-profileme-v7-8-c474e892abb0@gmail.com>
References: <20261105-alpha-profileme-v7-0-c474e892abb0@gmail.com>
 <20261105-alpha-profileme-v7-8-c474e892abb0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 05:00:00 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> A ProfileMe sample's PC alone does not say what happened to the profiled
> instruction. I_STAT and PCTR_CTL do: whether it trapped and why, was
> mispredicted, stalled, or was killed on a wrong path, and what PCTR1
> counted during the window.
>=20
> With PERF_SAMPLE_RAW, attach PMPC, I_STAT and PCTR_CTL to each ProfileMe
> sample in a versioned struct alpha_profileme_sample. PMPC is included
> because a PALmode PMPC is not the sample's IP. Killed instructions can be
> told apart by PM_KILLED_BM and VAL. The 64-bit fields are packed after
> the 32-bit version, since the payload follows the 32-bit raw size in the
> sample record: they are then 8-byte aligned in the record, which needs
> no padding.
>=20
> Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
> Tested-by: Magnus Lindholm <linmag7@gmail.com>
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-alpha-prof=
ileme-v7-0-c474e892abb0@gmail.com?part=3D8

