Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794809821;
	b=R+m8IyHNW1kHhbBJLY1XbFZARFw/Ss7mKxkwX8WXBpe8pm1CRiXpe3YujwzbryQUvUH4
	 76ozp5+6DVCbsUIpA6EnVFY4jxORP+4gxjIWeV8A5YCkL+WvAiStUtUI85yfYdZsOeFNN
	 ppkqGXdJBJyko5rRE0lPeHrRDd5gL9Yx8h16/dom9qvVjbfddzPj5AzAyl53dw5fb6nar
	 xdVGBe6EBFp3MMeYxlusJbufNG9mtYAyOX/OhrfTLS8K0c1uANUZ9krheNP6YUbqmu+gE
	 ZnQVq7QQMiuKq8RyGkQEFhXtM+18Zx6VGpB6RVjPz3323i1JMks2griAKENxk/Cascw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794809821;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=G2eQHKG/no4c0NhqzD9xgW9TUAo9fhIOIt08q7oF9+Y=;
	b=Va/Is4sYFk9cF4sJ06veCFugcQJhX+rG3004No7pTPQuD51rPJ+4NI9Ju71EzqqhxEFw
	 bVwdvWdL+TuGxUqX7BWqVglmjcGGLahjcIOa7HYjnlbEB+s4mk8aZeLnzQlWlLg2/Yh0s
	 l9gJx/fdppEa9Y0ad84s7lOO6liULB5uGPhC0tXbNmJfnOI0958E1SOMLzZKupLM2aunZ
	 ZeSZJ6ikb+dqU2Qi8nDq2wr+nY+AygV1NgA8Vl/FNM/iddU07HeNhxkmDYQJATKvjPKxv
	 EZ361tS3zjV+ObunYcd/016J5gp/kYHvez7TiYcnbCYRx4I7tkH4fStjXJ+sw9tQmOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="D/whaEtA";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21619606A31C
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 06:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D/whaEtA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61761F000C4;
	Mon, 16 Nov 2026 06:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794809821;
	bh=G2eQHKG/no4c0NhqzD9xgW9TUAo9fhIOIt08q7oF9+Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D/whaEtAMRdEKznh2InvcnvkvGsDugX2on+02j6esL6+zZ02C31SG3X8DgXoSvvZe
	 S2TPoTGaJ9ebAyVDKgzUmlaOn4Zi5FwzI89AP+l3eyqMs0UpnWO0xI4GL1CTvcfqx3
	 xhvlDeFRJvGtxf3TY+8/DXlfDcHKedTfwDw2PQIwAJlAsfA6BzVQnAPU4ffzJR15J0
	 sZ3AEdv89qcAAdAkHd7sPkg7JsXFvMN56/1cFH8ZhVGdq1lBld6y/HaZfQEaqDROiY
	 l1bnS48rLo5WXySVvVfcvLkls9fc2vtGFI8o/r1fS4PYVE4Hx9MVJYCMlrIvGP+Hkn
	 qBGAfmOmPQ7/g==
Message-ID: <sashiko-outbox-216258@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/11] perf tools: Add lock to struct nsinfo
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116055731.707164-5-namhyung@kernel.org>
References: <20261116055731.707164-1-namhyung@kernel.org>
 <20261116055731.707164-5-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 06:17:00 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> A struct nsinfo instance can be shared across threads via
> thread->nsinfo and dso->nsinfo.  Add a mutex lock inside struct nsinfo
> to synchronize access to its fields, initialization, copying, and mount
> namespace path duplication in nsinfo__mountns_enter().
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116055731.7071=
64-1-namhyung@kernel.org?part=3D4

