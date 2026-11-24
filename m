Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795520275;
	b=BD8/98gEYT+rTzGatEpDsz9pUwqFa2syoYo2bsJpwPcot800LNTRgAkXPtDoijsGg/+1
	 y//h4X/YBshuGG3TqNanIUmLIq12rVfUho8qSmLk/+grB47WrHgjaMUypXATZV+cxzmiP
	 MASZsTwc1FveCcYuoOhZPSjR3k+M4oqbeprfhlnKZsh/TDS82S9Y0tlHGdzl2udr9lbgy
	 qcodxSvIZTxl49NhwK5FRHN4RModS0OxrgvaNM3xUm8ItBPEQ/WI8drAJ3X+sF/usV7ni
	 h/LUArd9bc/yhwuD/zfI7BgqzquD33ctbSEttkx1uwqSPH7Yt7MgkeUjLWs6BxRL7kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795520275;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZPj21lixiWYTGNjeK724flcGAuKxiTBYwGipvKFcktQ=;
	b=cNmbzY1nP1ZslKxH/YQP5/vvx7d34VdQzQ1Yb+gQXW4rnpBGjcv3Ouu2Wh2xru9suyT+
	 VloaHQWAt2AP0qeSDvcJf6JtsKQKMTGo5pApqo0202AaVxqrt6AThkm5t/6ugbkaio6AF
	 PtiR1Vi7PCvKt51U0Fm6sAF5kCOyPxnhny/I59pCPKASofvuaQ19vqAg1gp/r0OGrgyoc
	 X1KibSMMXatUABENsp+Uf8ksUpPZJDG8QQJPiv48dD0Z8qU/qaLQGaGyHR8nFEA1GRQIV
	 399KXFRIZ6tkIBZ53pHaJYAp+ZVvtZlqCrLT9rKqCayn1pZScaISPxE8QTlljeL3sLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hRvH0Kez;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E957F606A31E
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 11:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hRvH0Kez
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366371F000C0;
	Tue, 24 Nov 2026 11:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795520274;
	bh=ZPj21lixiWYTGNjeK724flcGAuKxiTBYwGipvKFcktQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hRvH0Kez+XO6ahQWHzeVkEM8JBLLMmOj+F0fDYFr93SxG1asBUYavBJnC7+zne6+5
	 2JCEeA2vXrlQ8xojo8V7NEgX3jiyhaQVzHJlG7YYQyuMadSy8zvOzkmtnQycHeaY1L
	 V69r/j58ph2nqy6Kyb4dXnlKq7lNg4yEQmCv9GEYSR0AEIfzeEoT7F6bqKB54vWYYK
	 LQiu5RiIqsChrQDdqKaAe3ckFWFYue9FM5u6zR/Xt/zJkHdR1PPG1oVNXgejnjdQhJ
	 LwWKRSzcMMC1cLHDFI9/xRJoHjaRAGyQOYyWOiBgWZqpF+Y4aENw5biTCOMjfG+NEn
	 /oSHgTLdLHUjg==
Message-ID: <sashiko-outbox-231057@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] perf build: Stub out __guarded_by() on older Clang
 versions
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261124-james-perf-late-parse-attr-v3-1-f9e906dd9da5@linaro.org>
References: <20261124-james-perf-late-parse-attr-v3-1-f9e906dd9da5@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 11:37:53 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> __guarded_by() annotations that reference struct members require Clang
> 19 or later [1], otherwise the build fails on older versions, e.g. Clang
> 18:
>=20
>   util/env.h:142:39: error: use of undeclared identifier 'lock'
>     142 |    struct rb_root          infos __guarded_by(&lock);
>=20
> Stub out __guarded_by() and __pt_guarded_by() on older versions, but
> keep the rest of the context analysis enabled. Add an exception to
> check-headers.sh for the tools only change.
>=20
> [1]: https://github.com/llvm/llvm-project/pull/95455
>=20
> Fixes: 321967859933 ("perf build: Enable context analysis and Clang threa=
d-safety flags")
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-james-perf=
-late-parse-attr-v3-1-f9e906dd9da5@linaro.org?part=3D1
