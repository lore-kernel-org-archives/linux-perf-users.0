Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795115237;
	b=Q8PKklxOG6MukFSHkDulxZcfP411TnzUKFRMnX9mRYdWS9f1nHp9Wb0GpT/r3pKOwHBg
	 DCFq7RBPKV6W8epE/yWGM6OOnG7RzQufi1o211nB303F/x1Q9VEvNYtDuFXBasRAnv84N
	 fvFrnLyS2DexZ/knjJ/Dzkh67MT1e9ZzzBu/TLnwH7G8s3/SSC+gUCrVjSZlJAxx750MH
	 Y9DPA3XUveJI50atC/79WgOiDezUs32fH0DE+qdxgdMXO7ecHTIlBNRgB2hX5nxAVD6to
	 IMXuDN6Li6lZ9q6ZNl9ZxNEqhSJWbLB88f1cPGVpqflFNyV/N8IEhkJCP7OH3oA+SwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795115237;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=n4Wz95ig6cqnc3lhOLvGE6QBjp8DPs0FbOXnXTCLQRQ=;
	b=G5aTjb72dLT9PX8GE46TfUDbMfRvdID7naECFTksqotORU7xlj2fYOZjBC6ARwTIHMVP
	 tuTbTal7PY3uAxam/zmrG9iiQ2NF1yKsj28m+3A18z6zIqND/7lJKjwHzB+JlhYwj57L+
	 H4QZteFhESQfObsg6PhVw7/UK8zVGxVlRwL2Zmc+uJXXvxfmMxD8PxmJhU8IYRcQJi78K
	 nLeWgu3zrDhz5OWNmiwG5DeG8odrKxi/zQfQwd4saiyc3+PYEqvmNoUDbUsD8BgtUa62m
	 EcoxlOdSiG/haCFPHYxFS2nct7MXXRvJcI2mCGH5TT3CSu1bHR/BnvV35N1jipVd2iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fuE49k3O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC60606A320
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 19:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fuE49k3O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 946A31F000C4;
	Thu, 19 Nov 2026 19:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795115237;
	bh=n4Wz95ig6cqnc3lhOLvGE6QBjp8DPs0FbOXnXTCLQRQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fuE49k3OC671xBG2btCPz20zsflqGT16ykKQU/+FGYYVkBxIjgCPl2lBm6Xr7V6j3
	 4jVWJ2iIC4LTfPvIlebGy/1ivGJiRMTAivOOtaiXCW0XE1tbnH7++lUApkxj7crFtr
	 3t1ApqUJlmVkoNEyo04UrWiFbaDJzO6JA2Me+Ml1aWPU2Zbo+kQU69CQ2NkiKvcNYT
	 LLo4rDYVghQDc29RFtFlcab0F9BGnNEWWhiLaI6llJM6qltjwWRX8k7wilsSzOJD2c
	 0bIo/XSemXu509f6Ko1cGSieh1XyTWXyuJZ6/RTlQrB9OntN+dei7PnmjRx14iUgyC
	 y9MnDgMbefz9Q==
Message-ID: <sashiko-outbox-223831@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 32/33] KVM: selftests: Add find_bit to KVM library
Reply-To: sashiko-reviews@lists.linux.dev
To: "Colton Lewis" <coltonlewis@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119185215.632334-33-coltonlewis@google.com>
References: <20261119185215.632334-1-coltonlewis@google.com>
 <20261119185215.632334-33-coltonlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:07:17 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add lib/find_bit.c to the KVM selftests build using the same wrapper
> pattern as lib/rbtree.c so selftests that depend on find_bit helpers
> link cleanly when built standalone.
>=20
> Tested-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Colton Lewis <coltonlewis@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119185215.6323=
34-1-coltonlewis@google.com?part=3D32

