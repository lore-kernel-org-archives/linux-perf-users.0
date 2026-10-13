Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C0A4078C1
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 09:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791885591; cv=none; b=QLrpsV75HeO8xk2CADCVw0KVOyXnXXBxl+G/7AmVNG1Pm0hyNtoHNjLdvq57lEzha4nrXWpbgjEtNIEWHBHNjjd/nhRbVNjcWE3S+Lf3Tfkls/Bj6R34xcujzMrfLbN7bcy+Z8ZPlf6t0y49Oi6s37UI1Bvo7Jc49UmdCHqgBUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791885591; c=relaxed/simple;
	bh=WmoZlUYqx73M3SkwS7hPLv1zwPITBPTdTI+RA4JWpzg=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=BhWUd49611Bmk16wGVp1Ww/vDe0/8AUnVnVA+/D0YamEDRu+G6MOw3b3+62ZhNLjbwy8Emd4vTZeVKNcbEzembQetPLzJjy9SA6uZaNGST323TTBgdcynbs69Dtp80/pv9HEyQADY5hY3fbAUZ4Bovc/e4BEPk0Pl98q+/Vb6bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4NHGkLr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4NHGkLr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2AB61F000FF;
	Tue, 13 Oct 2026 09:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791885590;
	bh=h0CcetD2NoumSBTno8p1uAQCKNoBKuUUr4P2Mj5mv4w=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Z4NHGkLrkrqhtPzxgeoVeqmMVFhuc/YYLW9TKWjJe0k09VsXdaoUocZUYX/ADM+l2
	 XGPFdeJNqvG/a9pSntarpFy7QYnT165yoI2YtyuWX/7EWyO4jlHcmYmi8xGXgkgJV0
	 JdgjgbmpBnTGXHmnsllPhCi6dRAlNe7KCD8ehUh/D05pxOdrREOyNK36eXWqWbPwFT
	 oFIYYmQKYXpq2c/PbYVj5l9YJYnAvvYNCP3MYHOOjmuEuF1pJJCvfeQnygTDA2Hudh
	 OBXa1LN5Cf05IMem89VKV0Lo1BSqKp0FQyKRF5AUjU/YJ9Ae0fXk7xalGVT1STi4QI
	 4sYge5AbhaAJw==
Message-ID: <sashiko-outbox-169411@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/x86/rapl: Fix use-after-free on rapl_pmus_core on
 AMD/Hygon
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jayapal Ashwin Nair" <jayapalashwin.nair@amd.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261013095051.24777-1-jayapalashwin.nair@amd.com>
References: <20261013095051.24777-1-jayapalashwin.nair@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 09:59:49 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The global rapl_pmus_core pointer can be used after it has been freed in
> two ways:
>=20
> 1) init_rapl_pmus() stores the newly allocated rapl_pmus in
>    *rapl_pmus_ptr before calling init_rapl_pmu(). If init_rapl_pmu()
>    fails, rapl_pmus is freed but *rapl_pmus_ptr is not cleared, leaving
>    rapl_pmus_core pointing to freed memory. rapl_pmu_init() then jumps
>    to core_init_failed, where rapl_advertise() dereferences it.
>=20
> 2) If perf_pmu_register() fails for the power_core PMU,
>    cleanup_rapl_pmus() frees rapl_pmus_core, but the pointer is not
>    cleared. rapl_advertise() then dereferences the stale pointer in the
>    same way as in 1).
>=20
> In both cases, rmmod can result in use-after-free and a double free.
>=20
> Fix this by setting rapl_pmus_core to NULL on both failure paths.
>=20
> Fixes: b4943b8bfc41 ("perf/x86/rapl: Add core energy counter support for =
AMD CPUs")
> Signed-off-by: Jayapal Ashwin Nair <jayapalashwin.nair@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013095051.2477=
7-1-jayapalashwin.nair@amd.com?part=3D1

