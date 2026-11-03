Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793675480;
	b=opn/mXcD3X3D3CiBWDvpJfy2LZ29JwoQdOk1YnpXzyHM0e9+SDKeMv/n3+qIMRwGXH2Y
	 /DiaGdvaxqIVxJA0RtJnBHxHXKXejdz6XC1EstyuixaQ8kpYCBoPiQO3LntLPOhl6DWU3
	 VWD+KY5QlaLDdzTsFtMIrAb/Y3GS3pM2IhyiN+BQ+dNW+oShcByv3YPGyFHizbYF8DTJC
	 WS2Ju/lF1rfzTJ0ba+xkznlMhc3hlHgPG6XxJ55sHEMW2zT5bmHBwOre6gvBjWS47qjbE
	 DqOUDuAWNN9p2M8GkzVMbvL+MPHSe+hnbqy9NaewoHfNcxcmlCAYNXcQjvFx5wdT8Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793675480;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=w2QS3z+K3SmrbHmnEcY34OBDVvwG1vgT1wyZgPGH6eg=;
	b=CGlDFuZEAdF5mNv39eSZtXrGlqRby1dneMPzruwvyBMMQz6ffio0NzxbAx1NpY1BZEaV
	 4rw5PXUo0WV1+Yy05wsqOoklGKR+Wv9lDAXia0V7ZWT27z37es0NgGwMcchz820j1Edf2
	 HdEj7i22LL7nu3QKl0KdRaxqzx+qBj+HuJD19ZAhNdho/8ipS96H4xWt+XR1J3QGCRpnD
	 u+tg5BM0YK8NemBbXSIikoNkiURIH2sMB6ab0uK57TR7F8pMYe08xNDMrr4JijB3x1uml
	 iXNrruBYndCNJhb+s3vOE8ALb0U8FY6wty7Ma7MbCKPmP707V6bH8pyMxTQieEyINvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cYtJt1QQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C4F606A324
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 03:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cYtJt1QQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738DE1F000C1;
	Tue,  3 Nov 2026 03:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793675479;
	bh=w2QS3z+K3SmrbHmnEcY34OBDVvwG1vgT1wyZgPGH6eg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cYtJt1QQL/74uiV5hAWIWJv2pf3uEfyp/43Lj6sAlw9X1DA5R+MyDGAFcfCDm1EQQ
	 iFp2K8c1Wz5CnJns7KXt7RLpFtBWv4LEYZUSxtlsw9u+znIgy2vDr2Th3TShxAm4sL
	 XPyXSEExjC0FbpYG8P3jQym4Gdyt73ekDLHCIepxxSr98AOMaeviMf+PGCP4LKaWVD
	 Q46XCqP5oIW+uvX9V3jdd53Xz0ZZ9rOuWrX0vcxZv9CI12XEvRhYwpLmZ8lH9ncokG
	 6k43h+t0jiAhPOjWHI154y/Bfy6oK2XTZXQiykAu50fP/DiALRDdwVhMmhKT6e1NQx
	 vIYz9x/CsyOww==
Message-ID: <sashiko-outbox-194495@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 7/7] alpha/perf: optionally randomize the ProfileMe
 sampling interval
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102-alpha-profileme-v4-7-61e00f5e1da8@gmail.com>
References: <20261102-alpha-profileme-v4-0-61e00f5e1da8@gmail.com>
 <20261102-alpha-profileme-v4-7-61e00f5e1da8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 03:11:19 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> A fixed sampling interval can phase-lock with a loop whose length divides
> it, so that the same few instructions are profiled over and over while
> the rest of the loop is never seen. DCPI avoided this by randomizing the
> interval.
>=20
> Add a randomize config bit that varies each interval by up to 1/16 of
> the period in either direction. Only ProfileMe events accept it, since
> Aggregate mode samples already land a variable distance from the
> instruction that overflowed. Counts are unaffected, because prev_count
> already records the value written to the counter. The jitter
> is computed with mul_u64_u32_shr() and the sum saturates, so that a
> period beyond 32 bits cannot overflow.
>=20
> The jitter comes from a per-CPU prandom state rather than
> get_random_u32_below(), which takes the batched entropy local lock and
> triggers an invalid wait context report from lockdep in the PMI.
>=20
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-alpha-prof=
ileme-v4-0-61e00f5e1da8@gmail.com?part=3D7

