Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794369001;
	b=mPLfRqcXVNVohOJomG9D/lQUY9mHAiEmIBt1Mg9QTXXcMgYusN9QihK9n5uZlTwKY4Zx
	 9FnKsUVYM1iibwoiaZJzZtsmKn/FPLlKeJ/tNHo+Sp/JZGhL6IPUsM0gMHZF5jqJJ3/n3
	 wO8XmCBMaas9x2PLM+YBW4amtEj/lEaDdx8rTPCKvhsh4YqS27hKBoKKmsK8w/dU8iReP
	 vC0TJolHzJzNYk0jvZzoRJvzXuezYyj97eG5K8m2YXdO9ndVVQgYzcfflL6QPjmT3caIK
	 MV9+r+q7nJEp1XVXmsg42Kr5eE9GSx57JFdVaXkrnFVjBPt4LyquAXUpUr86WJ7FA7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794369001;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CVah+2+K9VyGgkkUivVhWaeEskc1duX3DUuoHlRiROY=;
	b=WLT29Um31G5vcXRTJtmtNPyiKEwb5YrPOM7j8MmJ/OKqC8BOE6IxsU+88yG6GTau/iz+
	 Yg9hqOvuA33qsP4jRK7O5n+jtyfPsA+w1ZoKICpBI0VcwQUyQr+2VtYIQ8VbQHcfP/KPZ
	 KTZv8IimLhG1pWt9UKAa28K6Kke7nuj8uCV/L2sTH+vefvDUlx2D6KDGsVAcmRtJzBM4p
	 ceifNyuBpCvb5ZTPmYtz5j9OI/NY7DjH40/ZdC+SN7RPrhadIbZP8yqA54kao5NKICXhI
	 vznybFWKXT2rGANntuEF1AAPhoiMvY/dU/T1V/u7FoquvqEZIXbbCx3ny9ijkOPKE8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="A/09xFVw";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CF6606A320
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 03:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A/09xFVw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245621F0089F;
	Wed, 11 Nov 2026 03:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794369001;
	bh=CVah+2+K9VyGgkkUivVhWaeEskc1duX3DUuoHlRiROY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=A/09xFVwguL7PCCdx6nz8flnYDWmWOwSjxZkMTyahaBdke9Om2YzxlGF5E6lDwvES
	 ahVdCEvPqkPXrZsIbW5P8ITLg9/c7UUcLQ7fNwEm0VZlc9sWWjlvoEcC2OziohZP/G
	 LLXpJWqiO9rlPD6h+CVueOrzEMxDmjPuLhwTLsPUC8sJImjuqyWGhB2yalHXbVQTJS
	 NfQmLA4FQSswa0Szr11nApNB9gVSf+UBrpeuWjlx9FoXgNrTTg0ehe0/3U7Yu8iSy6
	 khXc854jfNudpj/G4+kfiSEANuOkffppAP+dFGYiTvwutXysXkXlYROIEvKddwbDXh
	 Jdsi7BOzpALvA==
Message-ID: <sashiko-outbox-208228@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] perf jevents: Make the model argument optional
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261111034333.2019831-3-takano32@gmail.com>
References: <20261111023448.1970467-1-takano32@gmail.com>
 <20261111034333.2019831-1-takano32@gmail.com>
 <20261111034333.2019831-3-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 03:50:00 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The model argument carries a default of "all", but a positional argument
> with a default and no nargs is still required: "jevents.py x86 <dir>" exi=
ts
> with "the following arguments are required: model", and so does any caller
> that only wants the tables for an architecture.
>=20
> Make it nargs=3D'?' so the default is reachable and an omitted model means
> "all".  Builds pass it explicitly, so the generated tables do not change.
>=20
> Fixes: 5a09b1fd1b1f ("perf jevents: Add model list option")
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111034333.2019=
831-1-takano32@gmail.com?part=3D2

