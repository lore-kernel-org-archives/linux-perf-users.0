Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582523;
	b=J1qBAPc/LoosjCwvCsvZ6rVDLrEt89prCet9PibFwp0xEXLemeybF4mOQ1A4WS72z7WF
	 0FD+8JaBwi1kIEpkC1iVIp6Ktyf1juSlWgIjZfln2CvxNrz0furLx35TycTRXfi01jPyr
	 nUARsKWx6bhzpHVVk7IcMyBYAlqcRuN02qqHJpa5CsVxOtb8eTwmtaxaGTk+jBgcXMJf/
	 FIlobt6PTU3WO7JmxnRejhlngLXjmLNhUx6B0ml9hf4S5TAeJdWRSUSee7SMLrPbO5s6h
	 MM7hIkRLRP+HHvAYDSc0pNtOl9Ctl0sJ7Gr7imyDN1LEGIWMXJk5xm6wQpOMvtaRsUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582523;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vY9BfxyQiz87xNJlIMpL+BCcg0W0W3AJJTSflssYYv4=;
	b=idlVhpDWWRCd7CO3wBv19BxsJFzqgnQGqAwrJD7dtug6kh9Ke7t0tuMOHoCdjcqMv5Ta
	 2uKN5D6HR0+14W+Cy64THCYz+w07DL4Ov3Zv5jjMtH5DrjgOpQbVHsZ41BIEd5wdsb5FO
	 DC/+ZTRUlDfKPyVpy6l7U5HbxLYElO4if3Daf1tVSVn4Md68UDAZFRTJcJMy+Ha+krs9V
	 QoPmBW43COLsNP3ixT7bVJ3eLZakVr9DsSz6mDHaePFL/n9HRn/8VX0wHYiZ0oGZ2WiMS
	 cVdgo93a3jvg0afhWewB+2HSKf8eg+4MbR8Tm4XxTP2pAh9ZMfOG7CrogaBwcZR288A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mQXYJ9Jc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3E560A2607
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 15:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mQXYJ9Jc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBFD61F000C6;
	Fri, 13 Nov 2026 15:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794582523;
	bh=vY9BfxyQiz87xNJlIMpL+BCcg0W0W3AJJTSflssYYv4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mQXYJ9JcAFa3GUWQ/s1GVN+pK3rSniaTEqA7Su0BqPuKYDRp/BYzEhvSRk831GkNm
	 RaGK674bxIr2yVciYh5l3xv5KI3R/fLGHDB4KjDqkQx0yiJJzNasnNRHd2r5t1C+pi
	 08+SuiPOJNqwHqYjuE9F/DWCwWYJsXA8r3G4CpfH8Vel3I/u6hbDJn0SoMMOpkTYSE
	 CCPrXBqpR0OI045m4Zvq/SQMNDEEkMfWaK5SP8nvn6+foA4nXctdmz5yhJuxQj/5tZ
	 HRTSvml4dCdQh14cJ/YavTD1U/3udY5L8MWQ04h77Ij1AhTQzuNHwdhR+GiHho+Fbj
	 B1ndgEVwDZYwg==
Message-ID: <sashiko-outbox-213057@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 07/12] perf tests: Silence the libbfd probe in
 build-test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113150555.1163049-8-acme@kernel.org>
References: <20261113150555.1163049-1-acme@kernel.org>
 <20261113150555.1163049-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 15:08:42 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> build-test evaluates the libbfd probe at parse time and the compiler's
> stderr isn't captured by $(shell ...), so without binutils-devel it
> prints "bfd.h: No such file or directory" once per tests/make
> invocation, five times per run.
>=20
> Redirect the compiler's stderr; the empty result still skips the
> nondistro tests as intended.
>=20
> Fixes: 523471c5163659c6 ("perf build: Skip nondistro build test if libbfd=
 is old")
> Cc: James Clark <james.clark@linaro.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113150555.1163=
049-1-acme@kernel.org?part=3D7

