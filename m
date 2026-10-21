Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792623626;
	b=AMjTBKJur4WNStwpDuIqJQFLoUUl5CeLJ5SIIMv5NWHmuDylwgJpL07+t/5VKFrAYaYy
	 mSFtVrQWq/YmPFoIUqqa/Px/xPUTBiuAy6YfpykLzFyuIyHticbwl+bxKLgrVlsPri9fF
	 orWfIKxdfI7YwaNd09cJ05gmbA3GUJbRbV3NZc0urB78Q4ZrlHwgXw2HMcVQX4lAJLZh9
	 /qA47xxJLHdzWQ3w5yXNAp0eeV7mVPCSI6jkGh1+F1lLWGFHlc5u7c9iyz7qw9VEkgucH
	 dKYbGajLqRdj1aRb6RnVnpr3jjSPzl3JYGf12HsXCCRP2/G1rXlQCRTq46tZIqqu7pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792623626;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ne1PospU9z3YO+lihxPLYxXKb0mmRAUKLAr9mswvBk8=;
	b=VRlxN8Z1iOT0UZ0Y8ZxunZ66a3EA1sl7Fc+XgYD9c01lbDY6Av7eCa+bZdM7RSZvQ7oT
	 shFD1a1kGP2zJNbhKSi0Ew2935vSk+O0KrtgNLVUrC1aTmTBt1ETXu8K5gKlhn2TggDA7
	 dKKpsEJQa+YqLzwYr/nVDElHr0o+Ei4GabmrFSriWpHXPEab9NHXhX7Xq9Ewi2ywKDCl5
	 WUf5MZ98o5RQqEKH04xV2h5ZN8d07S7jB4fyCdimVOHYMq5wyG/GxRcEZ7OIYRq51g2Yu
	 UMdY8htFYQL4kuk7QU3Ty0hTL+nlcvPx+mQ2mjKy13XEys+VXaykTQWq3BWpubY4g1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HhyYwXFk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B97606A31B
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 23:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HhyYwXFk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFBFB1F000C1;
	Wed, 21 Oct 2026 23:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792623625;
	bh=ne1PospU9z3YO+lihxPLYxXKb0mmRAUKLAr9mswvBk8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HhyYwXFkaCnu86tk9Iq8zLXuzUHAziz1wibfbNIiNZ1W92hp5kRLQeQ9u6DTxY1Es
	 F2S6q5cU3AuQYRKqgyLxBK/gywUoTya9rUW5CzdvifD7rKL/R6ZEvvrG8n71esvjhm
	 59XPznFmV9VsEZcexn+nzGTVBrnSO35dui41QC43ZyxVBWQsipjUyGhfH2pB8YPKqu
	 OhABIkGQPs4gv8dvjYEgeLwQN9dv2+e9lRJc6b6Kibc84x31ulH17nnozNsEev54Hz
	 VWSpNJvYqqFmVH31zygKu1eWxbdEaDnYnm5smZwNX/EU9ZiWAf24lBzrCkNzHv4FFg
	 h/0/y7NxS0NOA==
Message-ID: <sashiko-outbox-180755@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 14/17] perf intel-tpebs: Use DEFINE_MUTEX for
 tpebs_mtx
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021223905.715051-15-irogers@google.com>
References: <20261021171044.155240-1-irogers@google.com>
 <20261021223905.715051-1-irogers@google.com>
 <20261021223905.715051-15-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 23:00:25 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Replace tpebs_mtx_get() and its pthread_once() initialization helper
> tpebs_init() with DEFINE_MUTEX(tpebs_mtx) and static initializers for
> control_fd and ack_fd.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021223905.7150=
51-1-irogers@google.com?part=3D14

