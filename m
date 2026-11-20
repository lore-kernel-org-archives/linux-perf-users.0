Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795188644;
	b=IPhoDbbjqw3dEt0/ko/Vz0bn7gNYqZRnDcctfHS6+hJIZec0XoxWN58IC23qDWjN3Oe5
	 KkM0sjXvjL2z1QxR3CPjijJnwa0MoRgKuYBsQ1faVxMpV80v44IJye6q4SBed969fsF+Z
	 1U0WsF7wVPx+mglE9c/QgST2WJPZpfR/zAFRaeDQP1r9lMxzHwHPwNvXaB9cqm5mGSh6Z
	 6u5uEiJI29RV1AkNpR8xM0BYyKc3dcmKEDPhdgwfhFPX238iYBerYHUX4+z9NlLDSuHkT
	 ooyIaZdlw8aHCjuy70hjccb0LpjdOER7q+Ddvy0GxHJAf1zcr9dPxaCFmJ1wJf3dsow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795188644;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4cAJ38kREm3BfeJE6/1ZGoP7dnk8MHxDhuIv7le6H7Q=;
	b=YVS8hVOejqqjtFee4Hgkn57wtcgmZ6Mbk8qJ4iGQcCs8PjfHIr5NAeA95yW1cnwP1ys+
	 YaE1AJxtga/yig8GPUpr7j09mPSqlzk2pZav33aQekGgUckcjmIic2qOWiSDcnkkGEGvg
	 rvweX1wh9LleR0dKm2u70wda8NFIwPf3smw89Wp9CVXsKgp0kU8KGYy9Y8F66Je0O7HCp
	 kO44wx1plfhLirkGZ9ea+PhwJDrjtVaSbhiOjsO5L96VqQN0AiwFyS9jJ7QzzrY/smjd0
	 xXcLR4GNLwCRWEBS7UqU7J9eubhQi6AD433CYiAPu8EzvUP9A2zVP3qlZDiBfv1a6MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZWxPRWfx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C01D606A32A
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 15:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZWxPRWfx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF911F000CA;
	Fri, 20 Nov 2026 15:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795188643;
	bh=4cAJ38kREm3BfeJE6/1ZGoP7dnk8MHxDhuIv7le6H7Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZWxPRWfxZTqCP215I5uw69hngPouvTWmAJN1JnAmpyEuDbW0XdDPPhP4X3c1g2UvS
	 pbomJRaQ9hgUASIPcNj3A07WD8GcKgkPbzCzk19w3o0Mz6/CSi1MKsDH+X0AdPM1YY
	 mNGHQF/ieG3w9ybWUD8DfUdNIsEjEGmgixg4qHTTBrOiEcfShWWPFdX1CM4d9ZF7m+
	 dWoRztggCxhifXCsCfV8Tel7BplP46dwQN1i1dAHEn91q7dh2qw22ZhdXN2JU9QuC/
	 eseaQASRVeruEyYGBaFoMl5tbyZJ9wHv9gUcY2hIZ9VKPqMcvhb9u0owt3okosf66w
	 gonU8k4T5VNPA==
Message-ID: <sashiko-outbox-225462@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/7] coresight: syscfg: Remove unused
 CS_CFG_MATCH_INST_ANY
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amir Ayupov" <aaupov@fb.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <067f9ccea51c9ad604d960125396d93440fe221e.1795182850.git.aaupov@fb.com>
References: <cover.1795182850.git.aaupov@fb.com>
 <067f9ccea51c9ad604d960125396d93440fe221e.1795182850.git.aaupov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 15:30:43 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> CS_CFG_MATCH_INST_ANY has been defined since the system configuration was
> introduced but is not used by any configuration, feature or device.
> Remove it.
>=20
> Suggested-by: Leo Yan <leo.yan@arm.com>
> Assisted-by: Devmate:Opus-5.5
> Reviewed-by: James Clark <james.clark@linaro.org>
> Tested-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: Amir Ayupov <aaupov@fb.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795182850.gi=
t.aaupov@fb.com?part=3D4

