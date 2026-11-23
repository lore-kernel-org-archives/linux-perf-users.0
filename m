Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795452626;
	b=LPdkVZBrJX6eZG4km5I4yJBrEFAYdbZu8lNuxGYFidI6gQOxEXin+IJ/uwCepz6/gbYK
	 I6ZW0sEv6uDIItH3k+ALP17A4g7fmnnnr4muHOb1RIF3Rgzvpmfjnsb7KqgGlRAE/ThHe
	 VPPPt2NCDAzxP/GTLJbDgrRTMUT4Y4tC9PjnLa+5KoDfga+yn7aXf/M5Goz+VIUqcQDDg
	 tO+KIeXNKJBGu82/SlSrIBMwVl56XpOGn/dKjsU+Y+oBNh0LTyvwtjdUcUAcP1AIJeqfh
	 mXgRlJKB+M28TdD0g2PXvuDBgb2XsbHVYfe1wdMohp4AjSarFKbJkKQ0Df3PovHsr5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795452626;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yKuFolj+9tuoa0JRCwL+680JxFlPp1SIvQA3KmjaNsk=;
	b=AbhKJPjUXJgnrSh+QqbCKIMf25Rff2fCAeMuEih8wFqzL7Lo7lJUg3mqRr+ZLhJYfRLM
	 EKuiIPNcb9oOF42lo88rvpJuF0TQv7CEVnZkrt+ANiN6GlsEbhtRre9CjtwBZLH3AVEdR
	 FklB9Z/uSRNrBxNRzmubiNeArBm0y2lB8vnCocJWLSybMqVStkDmr7CH/8W4dtxD04D3a
	 385+s1K87kAQ3vS32FB7NjVwLImkX4wSCyH4m/gp3pPlScmsI/8TstAzhXC0k5arhlxqL
	 3vev7gV1AEZtw2arGZu0WkkeVrVdq+D+IP1UUnScX/FFXcxl8eCfFZt/1lHNnMGLMRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lmo2IVGG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8386606A32A
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 16:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lmo2IVGG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6741F000C0;
	Mon, 23 Nov 2026 16:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795452626;
	bh=yKuFolj+9tuoa0JRCwL+680JxFlPp1SIvQA3KmjaNsk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lmo2IVGG9eyrsjI9v1zgbr1sN9da94c+X9KXNRvEAdx3BuxLiIzrnK7YoFyeobgmB
	 GHaXvEgt9PQq9AQL32MYAiv5t6eH/9jR/Tq7gORtVrqaaTWRi3M7rudlVT+1maSBur
	 nbj1p1fC+7jMLl+J63feQ738gIMb0EzcAliKLWl8ToOOTpQTEcAvs4IZWg3IQeOCRC
	 g1GS34T+X4sz6NLp7oY+rHxh5t4SCREcWSSvldUZZrPRh1m2QuE2jpH+hWoMbX0uZA
	 jBofkNzoAqoHNAoojscdodiBWd4G+Hf8/kNxrEliHoF03fBzeOGV0Of9o7qyQNtNAp
	 h7zG2lUx5DRdA==
Message-ID: <sashiko-outbox-229673@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf build: Only enable context analysis with Clang 23
 or later
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261123-james-perf-late-parse-attr-v1-1-cfebcd81a962@linaro.org>
References: <20261123-james-perf-late-parse-attr-v1-1-cfebcd81a962@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 16:50:25 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Context analysis requires Clang 23 or later (see
> Documentation/dev-tools/context-analysis.rst), otherwise the build fails
> on older versions, e.g. Clang 18:
>=20
>   util/env.h:142:39: error: use of undeclared identifier 'lock'
>     142 |    struct rb_root          infos __guarded_by(&lock);
>=20
> Only enable it when the Clang version is supported. Leave the other
> thread safety options enabled if they exist because they don't cause
> build failures at the moment, and might provide benefits even without
> -DWARN_CONTEXT_ANALYSIS.
>=20
> Fixes: 321967859933 ("perf build: Enable context analysis and Clang threa=
d-safety flags")
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-james-perf=
-late-parse-attr-v1-1-cfebcd81a962@linaro.org?part=3D1
