Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794385243;
	b=43wiwAKC5Q+s5zGyx7XUEUZgSdJPBBe/BD0/YBJPouvF7K5c6kxMtkIusycVsQMSEHZU
	 NjSkvNvaSIP+WEu6Ys4N6kpdslAo1c+g+kPRrkVE2w02CkLy0drdEuiC7CdTemRvqSj3z
	 WonwDbEBpBvs5NoPHwYfdK9ZmpxENR1HxSwt4uIa7nRXsBejaVoItiPcTOZB4Vusnmus1
	 v3VR02iyvGBHsqlAK3Mh1QxEDY+AAubBh0l7ctvfeEIIhoOH4kI97zM0D/kS5l0lXvnhh
	 A1zOCZ/J6MwCy598QFyZ3Oi/Nc2tPVlkGyAlu8p+Fb3hm0L8YSKEGYUcMvnWsOStYlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794385243;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Wn7DwW0fkaftRpNTwVk0gQ50vcjPF1Ed72h2b6l6bpc=;
	b=xfeZyAZA46KqKrTRjsQt3iuOEmEWyskHm0pQL/HOhsWxvDJDogOZa3Rci1BVoeQkYrxf
	 zoQ5gyg3obu89t0/02w4suPiZZ5jswsiyAyn+IVc/+WU6YfMiWjKVmGj8xnrGeIAgrXnU
	 k9yWfH9Y1vJcTRymzz3JBkCRd3xaebtSYk3AGUJF6+g1JjltrexJkNre/5P92DvTL1SIw
	 MqsOZZyIwJa8eQ0UZKtUsgFvkzcbo2jqAtz7JCdg/5vGwU6mZyGUzuKyT1c8O39zUkfOx
	 LYyoXXYIQHiCZfdh6a2hNtrJJaNFMQ9KyWL+y7YepaRLVd7EtFuR3yFOD/fCu90oR9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KX77VH8D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B421606A324
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 08:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KX77VH8D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716C51F00A05;
	Wed, 11 Nov 2026 08:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794385242;
	bh=Wn7DwW0fkaftRpNTwVk0gQ50vcjPF1Ed72h2b6l6bpc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=KX77VH8DwgjGIQW9SC8Tuu/YfGZuLzle68+ajL3MxyGtvs26vdiip8H1dXA5ugs3e
	 Os3S5BGjbUtQBWdbXdzOLXLaKt2CbJEK2KmANTj5G9nPstjD23dFEYVlHAeFcvKOd4
	 X8CssgOesqk4Lcib8Jmfosj65JkVG7Q8mxLDX5WGY6XDLi/nRbdKWnfBow43nihgjz
	 s5nA8/vTj4VKRsqb9ROg9hEUNB/jkEC4hWl5piGW4VjVcNxLnnZ7V3e40qcagTL7Gg
	 8XkFMWTfZydLgEV5Nj+4lDSGz38QafDF7CqoOUxqLjyk6iYXn9doFKUW0ICkbsVbXu
	 YqEfS2CZ7juhg==
Message-ID: <sashiko-outbox-208591@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] perf: Use cpumask_intersects where applicable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shrikanth Hegde" <sshegde@linux.ibm.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261111075945.3930230-4-sshegde@linux.ibm.com>
References: <20261111075945.3930230-1-sshegde@linux.ibm.com>
 <20261111075945.3930230-4-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 08:20:41 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> cpumask_any_and returns, usually the first cpu in the intersection
> of the two cpumasks. However, if the returned value is not used or
> only to check it against nr_cpu_ids, that implies whether the two
> cpumask have a bit in common. i.e cpumask_intersects.
>=20
> cpumask_any_and uses ffs on (addr1[idx] & addr2[idx]) whereas
> cpumask_intersects checks only (addr1[idx] & addr2[idx]).
>=20
> So replace such occurrences.
>=20
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111075945.3930=
230-1-sshegde@linux.ibm.com?part=3D3

