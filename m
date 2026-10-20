Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792507599;
	b=oOvQmSAX2uHWx5bk2zqL+BzmL2jaeRUl617G1619IpylzJZlVUvrrKFVXSQ9gj898lJ0
	 x0l5o1IeIO5quEa1I7+np6BJP7YDd6om4MUu+sXY6pfV2ersRi2k2et6bVlcctzZ4k5f8
	 IJjQDQD2qD2DJVglR4+23704y2wms+MJ2qW3HwImLvB4k/jPylB0isa3YThKw+gGd1P+N
	 4HkWNjLksWtAD6C3j7KK/gKmQc3Ohs5taNo31oS9n/8UZpIGlansoDj9IrM9jNsT946vq
	 PkWft/KBQqlWkvhSmkGaEQBvcahx7UdjgBS78MKd5IVfsfyivo/Fd4T8w7ZE2KCFkAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792507599;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SpmDEedeopY9qjkqBs3RXQ1jOuy91q6hYTyIl4ZwMeQ=;
	b=q1lrYLwMM5eOBpo7PamN8LOJk2d9Arptcjnl4OlT34xwju6Bv2XdkQJfVcRe/uORwPcY
	 Gt88P2K5aJth1Aljp9u3ZgnXPZcLcBsI6RuVE4KJd4HXDyT5IeibvuoSS2EZxaSxG8NoV
	 t/bY/8Pr7Omeon6IH5l70cx5cHIRkWBB4/aR6CQV26o6eMztS0n5UeT6XaN2f1Y6Xxmbl
	 keWokUE4URSD158KUmnu+m0x7mWRu6Q7UUSVCK+URlVgnzANI518WoQfDW8zbm4pOtGPQ
	 qNiVMlTI4pfLuXAToEOEtSvrX97M50fzdqgHlZ+kVPOsCdG/srWE/du0LhT0dWxeZgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dsqOxHyt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36049606A31D
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 14:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dsqOxHyt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF501F000C4;
	Tue, 20 Oct 2026 14:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792507598;
	bh=SpmDEedeopY9qjkqBs3RXQ1jOuy91q6hYTyIl4ZwMeQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dsqOxHyt83J7xfgKA3bxPn1oP17uzx4PzV0wpi7koMi0xruR1bezvYz2rB/MUUvZd
	 KeYvM4VnGvO9VtmT8theQxOdshEJNgnP+Za0i7g3Jdrc/EPvhlm1sQZ1BFBXaSs7e7
	 XX5wFUb18bXufdTQjLhfRbI81t/fwyVGAi2fQrOPOi04GoEvgKmlSYeyUlOP+L6f8W
	 d6M697OH0UpimPijrHFf0hwL5AxKye87CerHrAJ0BQ49PePBS64H+hfyr0PlreP0bp
	 A0AO2KuyMLseR95tdlffkni+DKk6cjF2yVHBhzc7k+kpm78QRC18mt7qGUzyd/UqOC
	 SON6/3jlz6fiQ==
Message-ID: <sashiko-outbox-179191@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 08/15] perf annotate-data: Track imm_value for stack
 variables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <229d5b940a370daf47dfff23cc9e348093adc8eb.1792411435.git.wutengda@huaweicloud.com>
References: <cover.1792411435.git.wutengda@huaweicloud.com>
 <229d5b940a370daf47dfff23cc9e348093adc8eb.1792411435.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 14:46:33 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Currently, imm_value is tracked in registers but dropped when values
> are saved to or loaded from stack variables during type profiling.
> If a register of type TSR_KIND_CONST is stored to the stack, its value
> will be lost.
>=20
> Add an imm_value field to struct type_state_stack and update
> set_stack_state() and findnew_stack_state() to accept and preserve the
> immediate value when updating stack state.
>=20
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792411435.gi=
t.wutengda@huaweicloud.com?part=3D8

