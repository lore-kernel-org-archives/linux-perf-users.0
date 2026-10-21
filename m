Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792624041;
	b=OUUNHv8XtiY6ITl7yEbXfLKnfV+3Qoo3pc/4ugjSsYmaGHSK5WlBi8rYBT1KYhTCuWh0
	 0uJ79dOMnm+jkAOhCU+/lZImgYH/X+Lmx2PgpbCllXQRiO8XT5qc/Irsg4UxK4WYoSilr
	 MjQx4ibsRgjH3khrr9KFG1XlqhrMGF+5nfcKAIKSrRvLIRpglDWfG0lCl1WLXnxzJ3XFE
	 /obiguUkKexmdnSCERtHhEkqOg3ImkqwkF9K0UpsVDkJWR7Wmt8jXvgSr7GitiOJzbrhr
	 zVphOq7+gKEZrZ2/NlukLHQ+hW12pgQgttMCOcl1i1lm2kqN7Gqsiua2XQkO38LyNwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792624041;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4WzEBSww3uie89bKyQmaC/6D9e3EX1V4e08N/CFRjaI=;
	b=x1Y4Pl6FaEHL25TOpCYJhDTfn0a3pdwXiy0H2Qf0w0dLS2tD0E2X/7qCfiV3FqD9d2+y
	 AxkQF9828iaH61s32D0xMH8UwfBg8kNZark5dxfdPILiSFNA9jbxZmT38rEihVRWLYqdU
	 D1TZ82qBntqzlzetbUKPqYHF0FE48BajwcQTLyiiFBU0BxyXRbjF/Zw7u67glVSkoXcqb
	 V04sxTar3EXxgRLGFVXiIujQPOxLeCoXgDfX6W+vaAKasChefH11R+WBEYoXHDr4hQ19R
	 M0qDzP6zugC+fGUnYiZUFRqqN9JRacYaUSrrPmrovAi2l10+hheHTVeOeIbgwL9c0kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Vcy02ER/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B7B606A319
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 23:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vcy02ER/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D911F000C1;
	Wed, 21 Oct 2026 23:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792624041;
	bh=4WzEBSww3uie89bKyQmaC/6D9e3EX1V4e08N/CFRjaI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vcy02ER/07FAW2bBg/iSngqNtWIMLLvJ2Dyd4+AsT0wUz5aELWdYJLwYIPBg0H83I
	 RoAqaYJd+rX45VX1qTnh5EdjL7N8CKnVoWWM/TKtn1QwIxO4uLNIRaAAlLOXUoszMs
	 ManmCmfVXfbR3dg06vIIWi978FV8Sg1vAVPJ/w5z0tuj0c7bOq3/M+XsYtna6yda11
	 ZtB8VFd8wfNp59pFYWAAWjwKiujPZR2ecA3ZCQ9Avjse6gRS0qbg0BuRYCjXzAZV+j
	 tGlBMxTwMxiznNRTq5ruqn5H4XSCKiaoT1PwD0EglYUEAYI34QoLk2yWXQ7GnxzP1X
	 xbHvcLtERCJfQ==
Message-ID: <sashiko-outbox-180770@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 17/17] perf maps: Add context analysis annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021223905.715051-18-irogers@google.com>
References: <20261021171044.155240-1-irogers@google.com>
 <20261021223905.715051-1-irogers@google.com>
 <20261021223905.715051-18-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 23:07:20 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add __returns_ctx_lock() to maps__lock(), annotate DECLARE_RC_STRUCT(maps)
> members protected by lock with __guarded_by(&lock), and annotate
> internal maps helpers with __must_hold() and __must_hold_shared().
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021223905.7150=
51-1-irogers@google.com?part=3D17

