Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795041774;
	b=VYQC4SO8avuiJIZnEPgCwP6SilNOfd4x/cH1aDuQ+6zb+ZYDmhV3T1bZceUZgZGT8BdV
	 DtfUxH92DVrXb73ypBH/2EzpcwRoGI+gwAEe5VTY54M3XVUZZdxYptSUk/5EKMCu6OdK1
	 p+QYX6wE1fHwdGuhlGOoXG21tcmLMJOpEPM2dvqc+5e0jQ8DhrloEWJllTUKO+3vflljm
	 U5AnhOQy5VSHZwBom/mNsAuvgF5jrjhvoMqoV5iqln26mJN7hevOdU1q7ysGykayniuL9
	 q3NNGHoV3iWMIbgR9wAcCeMYhdrxE3RjWKx/5sRw86fqtns5FehVlnQhls9jfqAkFXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795041774;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CzAYV4yhNkPg6zAodvipCqW6XkRKFYzrdK0PgTCOEag=;
	b=SNuqq/Q9k/N0Y4G4GmX2jv1Glp2pZfEELrptB3+xvZMoARI3pnsGSTtouIA0k5KXKRAn
	 8FurmVe7cbMwAB6FNVjJw2mE9A/ixcCx1yyIwUshwAcy/AP3a67cNpv8+2OFjEGMLxkVI
	 L6+hJsMVKsrayZUGUomVBclecEyMq17iTGle9Fshc+nuOu/azGQ8gpbTK/uIqPeIjY033
	 hrQF/ZtFDuibwKoE/BjA8WTUqXiVuyyaf21KgYtqNf7zAjpT4+AqAXRywXAHspp0PM8V4
	 zTlnpK0K0ZgAvWcZEGuuttJW+XZBcjhJcCblthVryNS/67scYofU7ibBBEvN2r8i0ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gvtgmsFS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCCD606A332
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 22:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gvtgmsFS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E022D1F000C4;
	Wed, 18 Nov 2026 22:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795041774;
	bh=CzAYV4yhNkPg6zAodvipCqW6XkRKFYzrdK0PgTCOEag=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gvtgmsFSP+p7hh7w+W+thiko00mSDJkEtp+iHsWzaad6ftWVyeUx9UdJFiyZpWngV
	 m2DgZrycK3eBF276Dsz4foiZxhL+IfQoFt0EWHR/F0AKCop+a7v0cYgUT5hw3zym9F
	 VCdyAiv7uepMx0+y/uTuGzyd4hG5p1WeEgUl8uf6mJrT7f0/WAxnehdla79DpJDXRQ
	 LxOiboMF2ofPZp1M+MFZFI87F0fUSHdI6djH/avYL2Y+/mLXmQTUFo7JEBVMdLjNeZ
	 /vJY4NTOHox1z2Q0ji+Z3Kd+T5UWDATIz0Odbn9EICpV7k0L8rVrDSEAl7jG6avFeG
	 cXhFaNB43qyEw==
Message-ID: <sashiko-outbox-222114@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 05/13] perf tests: Exercise the flexible array member
 path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118223725.121500-6-acme@kernel.org>
References: <20261118223725.121500-1-acme@kernel.org>
 <20261118223725.121500-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 22:42:53 +0000
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
> No test covered find_flex_array() and get_flex_array_member().  Add a
> flex_array workload that keeps a struct with a trailing data[] behind a
> global pointer, and a test that checks the accesses past the struct size
> are resolved and named after the flexible array member; find_data_type()
> folds offsets past the struct modulo the element size back to the
> member's offset (+0x4 for char data[]).  The test skips on 32-bit PIE
> builds, which reach static globals relative to the GOT base register.
>=20
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118223725.1215=
00-1-acme@kernel.org?part=3D5

