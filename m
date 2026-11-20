Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795155286;
	b=KuSDx+zZFqr5TaL43jWnj1kwcrOh/tMXqgBADxLu3DHf65npjtm8mGdjBiSoiofJkQDt
	 LmZgicoAjyzItm9RhhOpdRm9n0dZSr3+F/8j3Rt9EeEn2csGtLNxTOzOBuvLVX5ob05lJ
	 qFZks8emWR4orCLLDxpz3grTo0OXrL2iTaehn8wgrsorXWmrFPOXqcGrPeWtZzql1oETu
	 BbuVqwhNWnt1aiX/Z0vX6aAQcf2LKtIIojnotsgGZnahKFeXdDWESr6j8cY31hDhfHnZw
	 wzlOwFtDtp8FIdEgbLZBHqNEKDn2PRDvgqRie5efqA619rNy2rRFp18zqSG7cg7VhvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795155286;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sj/KPz8kYx2WHXaYWw7MNaPhX5OYiKTTuLHrU581quc=;
	b=U5czLmQVV3BPQxfXbNDxgyYAbzR6KfaX1ZIy56opWoy5FmotGpVOMj3lQlQ6c6KhbG3r
	 Zx4ormp0NG0/HXnk18y+E7tut4i4yEdg4OkLyrg2SxNh0Y72ixjEpOOitNRK7+AcWH0Ac
	 NHGId0aE9onBcs8zi6B6SpdDcXywkmE0jBnIT/kUaqiNWqU2ER2rUNKaSeY0WXhxfu7BQ
	 PpV1v2uwDJQnIOajS4uZnfFFPxkN81LkkdEcjRo6jG1lGz95+9LYv+DT94N+cgGXpnawT
	 28VxSINSqw6w8j9efNYiDn/ZU9Uj2I4yX+Uuq8VQnC0GEipUewNUcqNuPaGeBoO2Jmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YjmXQSWk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C91B606A330
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 06:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YjmXQSWk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5E71F000C4;
	Fri, 20 Nov 2026 06:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795155286;
	bh=sj/KPz8kYx2WHXaYWw7MNaPhX5OYiKTTuLHrU581quc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=YjmXQSWkTYNXGAkpRmUG5HZKaDI+qLpZBDJeFyZIbuIXWCfhYqeP6j1alJLcA8Tem
	 +mx7b2lUDNVez9C/p2phsuPkvGQD6soOktA6JzQYpd3H0G5gTfnTlub0W0dI1+zETK
	 eWI4pboLklbZvET+J0ZRGGrORyusRRncN4uhl2byZGmK8Y5CiddC6Cogez+DO8MB0g
	 tJe5dUXVAkvbp1v02WmfmmYDQ415yK0zyo9yqvcSsxp0DA2LrfoqpU73T7zojrnXUO
	 Hndn+H6t4pmmLZfi5QP25dWfimDyxzg909dBBQNxIYLpr0WODL6ORcGvG/atNfXei8
	 nbEKvVF+TpHwA==
Message-ID: <sashiko-outbox-224546@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 2/2] perf jevents: Fail the build on a key the
 tables may not carry
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261120060931.711483-3-takano32@gmail.com>
References: <20261113032927.634183-1-takano32@gmail.com>
 <20261120060931.711483-1-takano32@gmail.com>
 <20261120060931.711483-3-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 06:14:45 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> jevents.py takes the fields it wants out of each JSON object by name and
> ignores the rest, so a key that is spelled differently is dropped without
> a word and the object is built without whatever that field held.
>=20
> Compare the keys of each object with _valid_keys, the keys a table may
> carry, and fail on anything else.  The error is one line naming the file
> and the key:
>=20
>   jevents.py: <path>: unknown key(s): ['BriefDescript6ion']
>=20
> Written with Hermes Agent, an LLM assistant; the author reviewed it and
> ran the generator on every arch directory, with and without a key the
> tables may not carry.
>=20
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120060931.7114=
83-1-takano32@gmail.com?part=3D2

