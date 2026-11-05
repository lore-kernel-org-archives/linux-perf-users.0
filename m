Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793883116;
	b=PGS9NFcghMvmkcmzDf8FRmQ2zrKJiqWgKw9oShsjQkizpcEZ2WoBxG/j0kT2805XIU99
	 wt78/+AsMsbOy3ZrUCCrhN4kPh3Dux+Spz5fiJ6MUUGqxCYNZAVQ9N40NCTPZe0QL8E9F
	 Bf3LSqQ8VUDp/B5OxL1s5En+mVVv2AvZdhTDC8SV97TY5wV0VCc79TGjriVBXZzpq+SHo
	 ZYBGYbaEovbdXEichtZknZpPBUazsS3RV+KoSHJkLvwUhOF8ictBgsJJcjIxLq4evR7mS
	 2+x/513U4XVZjO1kKvbhMaMeLtDoIX4UYbeld5tyl2fZ0Hc9nAvpV9/M5ZcrQCD4JcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793883116;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=G5Le86+j0AvmfCcuZsupq7YHO76PndaV/ZSwxIG0srY=;
	b=SV7NMTSVfpYXQfo5iRBJCpUo3GTvH4/AyRE7WPrOJ+ycs/q+jS51kAxM/GeXCIk/bYwB
	 nXEKhFGwCG1JjxUxm3LJU9fT9M1lf41QgzNH8oBdE+Bbybebqyxw3rFNDjbLZqf43wjbS
	 wBfz1sp+5XtyRDcQNd9YtBM/PZ7GQqVEj1ici/W0o8m9rM883fXr68rG2uG7w/ofId4cx
	 SKfs7SG3RIoHSNAty5kYyNwGJq9Jlut3Xf02hccfukikVJ6ekEoz4iEvtFmSu+BjKVwpq
	 uv+QciOwXdZ80Ht2GONp6yZd1E9hCvZYmdF8+oNSwGm7cnHSl+nmr5XAzrmyihSeXYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MnCaUIwd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040AB606A31B
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 12:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MnCaUIwd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B4D1F000C1;
	Thu,  5 Nov 2026 12:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793883115;
	bh=G5Le86+j0AvmfCcuZsupq7YHO76PndaV/ZSwxIG0srY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MnCaUIwd2ttGL5K4Mv3cj2DLFGjOVUVAFY9CSm14U/53fr2HCIp8l7ILGc/gagfXc
	 OtNJdX87ADddDziPRAAt9imiW9mr1GIgxfhTS42KLPHX8wBwLfibseAJR0JxAxC32J
	 74fvTz2/jQxee0T+/xxgWt9ekAsXPFhOGz1rPPxXAJPtVRkoexek5Ppe/73ySjEBL2
	 zFyhOluTit7Pauv+E2G6fh7RSoDgiycMkJSTqJy9PpXC5DPDKd/YShjr9g1gw3ZKJN
	 fgfbokY52GMuoHDEIOvXaXq8GfCMnKWUGCcAMuG9VrqzAT7jZc2StE0bsqJ1e70aiX
	 Aqe5T5jAhEnNw==
Message-ID: <sashiko-outbox-199071@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/19] perf cs-etm: Don't drop previous target for
 kernel samples
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105-james-cs-unformatted-per-thread-fix-v4-6-7759e0ce2449@linaro.org>
References: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
 <20261105-james-cs-unformatted-per-thread-fix-v4-6-7759e0ce2449@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 12:51:54 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The branch target of the previous sample is used as the start of the
> range to disassemble, but if that sample's DSO is "[unknown]" then we'll
> drop it even though it's useful information. This happens when recording
> userspace only. Save the address earlier for "Trace On" samples, before
> we get to the early exit condition for unknown DSOs.
>=20
> In a later commit to change the default timestamp interval, trace will
> be collected that triggers this issue, so fix it now.
>=20
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> Tested-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-james-cs-u=
nformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org?part=3D6

