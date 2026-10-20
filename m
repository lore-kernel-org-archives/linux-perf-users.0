Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792535933;
	b=0HXibACG466k94m3t50DF3QYt5zngWa45pnapMingk3dJ1Pi+Ua1TyRYDTzmORD076Dp
	 TyGZJy88vkijW6SwCslJRfXFjeuhfr86gNKXW9S1FPoeT6j4KuNm1gR1rHmkCo2OJM1Se
	 z7XFnCZA5B9722G1e7gQaW3z0ibYEclBm8XDaTfMqpsWbTIwZgnP2o3beVT/7gk8wOnwS
	 lkYjxuETRSbB4Th48QYyguyxOg5wdRsNFNGIhp007/kM9LKcHbnaXp0Vnqa4tf/VZxvwW
	 8ruSVwLzB4BzsK35oGjXQEFsArGVTwbDF6wyT6JqfcFY56FRDEQhcilWhPtUZpkOrhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792535933;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZcS3/311JAmDYpWUuhVtdklwrOeFh0j+ClJL5PZJe7U=;
	b=U7oQffR1UJ7BP081hMFkE9moLAiCTVFRjhCN64q5NXAj7WIpWc/Zb+nBhTci208qMdVK
	 tQU9t9q9uol1E9KggK019eQ7L+Vy7MJKrWNfHHJue1inWAFBeG/Z86P8gHrZZnn1oR4FJ
	 ig2lUqkZVDoTE6kHhM+1eiGHq4WSsxJ5tBsGYfXPjvnqRtd7UQgwLOMspjEySpyGNmbcn
	 w2kCrRFVKeoZF8Hiql+M8huOyrGgd9y93/WlG3G6IuoZ8zLU1FhPXUVRLTcET/f2x6oLK
	 iK3i29FL4xYddFAswZI+Yqg9yhRUPan2O1D8msnzg0I6mxoc5Ee2kc51dNK5M2CBGTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RZWvKESM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4FE606A31A
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 22:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RZWvKESM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5806D1F000C9;
	Tue, 20 Oct 2026 22:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792535932;
	bh=ZcS3/311JAmDYpWUuhVtdklwrOeFh0j+ClJL5PZJe7U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RZWvKESMAEAJraarlnVk6K2zaHxC3xnXumqZEhkMlkwUy4zRkDc5YuJ7cnXjSaP6c
	 WFVcpZ8RhlbQSBXierb5UD3LNcC+3yn47hYtDp5VeiQVHYfMmpO24uk1FhUs+WVWMP
	 vm3vv6am3e/hDxnAmf4JjVs4EK92KEe6bhUiZi8+FKK6z7svE8UtTXbVBQrJPY8u5H
	 e90FsLDEiU102YmRb0fzxF3I2DkiaAsVmXwJHT8dAH9BZpMu7VnmGLqdT5aOfkW3oE
	 4lzki4A6jWf7FwFuq43giEgSB0s3a2r6IVOK3xgxbiJYZr7v5gzrqAdqKqd/nStI3z
	 TKIcfKVfZhf2A==
Message-ID: <sashiko-outbox-179561@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/8] perf lock contention: Filter events before
 creating lock_stat
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261020205859.1080743-2-irogers@google.com>
References: <20261019220915.3943592-1-irogers@google.com>
 <20261020205859.1080743-1-irogers@google.com>
 <20261020205859.1080743-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 22:38:51 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> In report_lock_contention_begin_event(), lock_stat_findnew() was
> called before checking filters.nr_types (-Y), filters.nr_addrs (-L),
> and match_callstack_filter() (-S).
>=20
> When a filtered-out lock event (such as a mutex contention when
> running with -Y spinlock) shared the same aggregation key as a
> subsequent matching event (for example, contention on the mutex's
> internal wait_lock spinlock from the same caller), the first event
> created the lock_stat entry with the filtered-out lock's flags and the
> second event reused that entry, causing non-spinlock entries to appear
> in -Y spinlock output.
>=20
> Check the type, address, and callstack filters before looking up or
> creating the lock_stat entry.
>=20
> Fixes: b4a7eff93c39 ("perf lock contention: Add -Y/--type-filter option")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020205859.1080=
743-1-irogers@google.com?part=3D1

