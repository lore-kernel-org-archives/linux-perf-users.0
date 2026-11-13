Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599702;
	b=o27udb65+i/xUPvfNgvZPNwZ73BoCN/AiI/VvKuyEWC66PcMPhIJFEW0w97oDHqvlGeF
	 w9Xvon7oEt/DClgHgVerSbpLA5nOnvvvGOjM9Ouak/lg/cBWgnQGf24mMxP/OPhiFU/bm
	 V1XjVoScH0gDCECdfJQfzvdBayfWUhHUL1MOmPntaKcQ9lSfdPpdRgCtT4LWVe/HvpXGO
	 C2sNMIx9L12vvQutsaZYRkYPn+hPXQjJgVxRZEFFojtt5BJA8nMe73NTxhK7pG35rmhVA
	 GpeJh+q9gPZoDmbAEaTqY8M2Gj3BjCdQLIzMhzHCdFKLaUB7O+iPZKEOKXs8vN1PElw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599702;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=REEOs4+lso35Y8Rmrpxi75vaKUJPE0laFh24ljZuVk8=;
	b=uyPdCNmdp55wAv7QICJnnVP13in0bJY6jLfL2VcNYdGw1vdrZDJU7YW5PxCC9yyLQDbl
	 T+jKjXIzNRKRrVrAje4oDbJbV7XWvHm99RNtjuwXfcGr55Y6W7yDFIGNa3EEM7+1s3uuJ
	 dtcIRFtjKf8xjyTI+t4kDMYkZFvmqRF5p5rZiz5n4eMRWXb43wE1iJ90W8+qoEtR94k9a
	 4ykf9oRqOfoEkwRNiXuByOWoxUS1v2KMo10c931QTMUphga48c8XDnDVLGCtfsQ6SINx1
	 b39khmVH+CcBHKSrLC1s+PYwtzFb1dJHVR6WidyTy0HRpuFI6VpMS3x6hcCyM0yh0DA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QsFV6mAV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CC2606BCDE
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 19:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QsFV6mAV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D65F1F000C6;
	Fri, 13 Nov 2026 19:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599702;
	bh=REEOs4+lso35Y8Rmrpxi75vaKUJPE0laFh24ljZuVk8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QsFV6mAVNPLf4Dz2e2tD79fjAGSyYUtGehqYi5EwqwnxldezugrD4+gBCQgCPqdr4
	 qp3fxHzjLkWe0+C0ksuoO6++7P2hZBk7yyKvKGgCIaFJHJdkge8c8s2JxtlECxJ4eb
	 uVHmyfbMynYcj/WDohzGjglDxSbg0vi8KKwJZEBoV15YKMx0bvIMlMmoiNTvInkCK0
	 KlpA0bTxwBA4rIcURvRA+/7MgbJhxeUfstKG1vrYDSo3X/wfXcgRdRhVbP90dHX/64
	 z0NJRB0ItuUUDo/pUKoc/GKZo6Aeg5q7RRY8K3wWXorvJJ/nPEpOeQB7N92lATgMQc
	 JDCZ32lK+ikUg==
Message-ID: <sashiko-outbox-213583@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/7] kbuild: factor the userspace ABI flags out into
 KBUILD_USERABI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261112195427.3411746-2-sashal@kernel.org>
References: <20261112195427.3411746-1-sashal@kernel.org>
 <20261112195427.3411746-2-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 19:55:02 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> KBUILD_USERCFLAGS and KBUILD_USERLDFLAGS pick up the flags that select
> the target ABI for userspace programs: --target=3D under clang, -m32/-m64,
> or CONFIG_ARCH_USERFLAGS. Collect those in KBUILD_USERABI and export it,
> so programs built outside of kbuild's userprogs can be compiled for the
> same ABI without also inheriting kbuild's warning and language flags.
>=20
> No functional change: KBUILD_USERCFLAGS and KBUILD_USERLDFLAGS keep the
> same value.
>=20
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112195427.3411=
746-1-sashal@kernel.org?part=3D1

