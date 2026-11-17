Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941998;
	b=lqxMNLNxTuJktuonrLdnSX+r0+Etv2P6U3NVlfAsf5neICdv20eFXd13S7V0I82ktl0R
	 34XfPxmwFyIwJWx2XD0AeadhuVfsBtTCXmpnhrhxiZzryzE3PNsdpa9RaPX/ZUQsXW5c5
	 Z+M6XmuhjQday9okada1nIt35GAgRSKQ2tbf/5zyXiitaYob2CAUXjpZ2Mwrhc7xi+/zM
	 SB5k00Mb8JG7ZVy6A5tDCGsY1t3XaYTBXMeZIsjXHXW/zc3cFAN0QoiNJep0jQHgS4+CV
	 VD2Y2FxzQOBGGwoEDjGQV+lNuZnw32XpFL2m1TszPSclIxOJQmQMs4Twq3QwIWhErOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941998;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YiWUR0JgpYo4+GuwRXOr1TNMLbUSToKVVWpmL30o/j8=;
	b=Nc9d5QVvPjX/fjgIry1MMcDmZpukI9m4vs2Z93QAYveC061f2ITjU2Pkg3Y8oO3Yu7up
	 obn77XOB9aW+2qVz3Vj3624NoV3z4rNALUoVOnWMNKuOyRv4AGbKjlMF/isAMuuRgkbRG
	 BTPHc8h6Ur18APpc2PLoOe9QQAAM7xdUN7sHzEqidInjph/whZEhgJiMJCkqu0DUP5051
	 jW/3hCjvbjiFScnT3qvL/Lc5zrcZQ4lZ2uS85zhnpPJydNwRBCJvxZ2kiF4844hVqsqJk
	 9zOlZ68ipR1Wy5jPTJFlKdEJPieg82Gm+vV//JYmdD+tVG9LrmlquQS7ECXYrCcWKmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EaVwWBK7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0222E606A32F
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 18:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EaVwWBK7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7000A1F000C4;
	Tue, 17 Nov 2026 18:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794941997;
	bh=YiWUR0JgpYo4+GuwRXOr1TNMLbUSToKVVWpmL30o/j8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EaVwWBK76tVul2spbc6fDutRwiFOCr1H6SNJNVDgzH4wJlRfkNQHRSFzuloguYBg7
	 dJsNtDo+UuLIoGd2ZL7XMkHk0j1aUxsbkxK8s65n6lF1WgCF9H4r+MaWnZ30tnQNc6
	 1ZxsdEbGmYOCg1JOOBZqYUEqRx3gB7Pup1OVVumCliR6fSoT2Dc1QA6oEvsXgTvrdu
	 INBGesAdAQWTp1Sv9XMPiNif4ctmf9yCyARvPTeCJXxVWAe2MNLLcZrO/Vv6A/yrQa
	 0D/1ysIfduFDiE+KuTCuT0rHWhXTTzoNw9vnVR1jeCS52UB37n+hkHCOpFana+7Xyo
	 ljjXCvVSsTNxw==
Message-ID: <sashiko-outbox-219414@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 12/23] perf dsos: Use read lock fast path in
 dsos__findnew_id()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117184844.99889-13-irogers@google.com>
References: <20261117184844.99889-1-irogers@google.com>
 <20261117184844.99889-13-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 18:59:56 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> In dsos__findnew_id(), try finding the DSO under the read lock first and
> only acquire the write lock when a new DSO must be inserted or an
> existing DSO needs its ID updated (checked via dso__needs_improve_id()).
> Prioritize build IDs over inode fields in dso__needs_improve_id() and
> __dso__improve_id() so an existing DSO with a defined build ID is not
> updated with inode metadata.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117184844.9988=
9-1-irogers@google.com?part=3D12

