Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793052493;
	b=0S/v4HuqYD05Y6tnickFgXjgyB9+8KYn3T5PJDGeH8Q6J+j1BIzLrr5ybjMd+3JQn9o5
	 IBGnpt1sAUvcXden+oTjtZwzesK2Q9tlV1dZEQQNG8JoEpJgjXQiNShAadKyREbeV+YEw
	 +bqpjnw7rFo6RlTsueqX9FtAxTQWFtRcDf36qVgyUzBT9fxrHTYJWkfcPQLmAy99ngHzP
	 ubfPSb4xaA2hqCS3vthwuAUi0LbR7Mf05stbPNd6LFWlVOidsSRH34TuhRlDTuwkJIj6o
	 lef3AzxZ5Ur7gvJyaw1EANgZU811EDb7ujbPT6JGFc5dcgsUcIIF3J/JAxJpdtiHYMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793052493;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=36rUGv34TVCrdTvk9RRBm6BDNmkpTEES7oJqVsHO+9E=;
	b=R3k6PeQGUXpRVW5rjnPNwmaGykP3pDFe8POe3pK3vZxXZejjVoeLUmpqc1UroGwGeJLm
	 QvCG4NahzWfDWfsiWtIeFCdaRebQtgDNJHI3bL/G4az148XWrApn9sa7LmDcSNAXtmONX
	 X4XtvxbX73YG0uXpjO+ndEWeEN8uGh7PedPF+PkZgrmXYLxasIvvMLolfZln24WYhq1D1
	 O+N6C6bHR8vMeEWAyec0v0+De0UPYQnkEZPBpDbt2JDRdW0+KznWbYsZySs7UmaBFD/Q2
	 bgW+q9q1lzo0/jUinYdct4bSM6uyjdQ1U+YPXlbO5Uyd0hAx/U0CmxA+uT9dafKxQNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iriLOsQl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10766606A31B
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 22:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iriLOsQl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 928631F031E1;
	Mon, 26 Oct 2026 22:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793052492;
	bh=36rUGv34TVCrdTvk9RRBm6BDNmkpTEES7oJqVsHO+9E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iriLOsQlo7CBn2QTMzNcucqLTdHuGC32vhBDSe23Qbl9a2uqjzNZyT+HWQJ/+YVPq
	 20PhepB1emjyVJEkBTApcgTwxx01svLA1BmlfnLphGHNJRrHfGhYosY/aClJEbPZEh
	 aUh0uE7yw4/zLFWIHt4u0PZeN6DRhcNCsMmt14Lx0AOzFhzHCuN6eei4icj2QmFJxe
	 KvKmy9yR23TiteUFsyZpYSbvGa1EivKMagU4curr6+DFPwjzMhWZzhQfKY3J7TYxWK
	 sOllmiqcAwRKU8gsa7eV0M5S3fustkck964hn2Hs0V0pXLb6GhuFP1jDSW74Al8BVA
	 xSHS+h4L8RdKw==
Message-ID: <sashiko-outbox-185782@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 06/10] uaccess: Refuse and warn on user copies when
 current->mm is NULL
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Houghton" <jthoughton@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261026215226.3713941-7-jthoughton@google.com>
References: <20261026215226.3713941-1-jthoughton@google.com>
 <20261026215226.3713941-7-jthoughton@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 22:08:12 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Accessing user memory from a task that has no mm is always a bug. This
> can happen from a kernel thread that is not using kthread_use_mm(), or
> from a task that has already gone through exit_mm() (e.g. when the last
> reference to a file is dropped from task_work at exit). KVM has had
> bugs of exactly this kind, and other drivers may have them too.
>=20
> Such an access does not reliably fail. The user portion of the address
> space belongs to whatever mm happens to be lazily loaded, if any. If
> the access faults, the fault handler refuses to handle it and the copy
> fails, but if the page is already mapped, the copy silently reads or
> writes another task's memory.
>=20
> Add uaccess_should_fail(), which combines the existing
> should_fail_usercopy() fault injection check with a
> WARN_ON_ONCE(!current->mm), and use it in place of every
> should_fail_usercopy() call. The user copy is then refused as if it had
> failed, so no access to user memory takes place.
>=20
> This covers copy_{to,from}_user() on all architectures, including the
> masked user access paths that never call access_ok(), and the
> __copy_{to,from}_user() variants used by KVM's guest memory accessors.
> It also covers __copy_to_user_inatomic() (and so copy_to_user_nofault()),
> the user-backed iov_iter copy routines and strncpy_from_user().
>=20
> Paths that never called should_fail_usercopy() are not covered, e.g.
> __copy_from_user_inatomic(), copy_from_user_nofault(), strnlen_user(),
> get_user()/put_user(), clear_user() and unsafe_*() accesses within
> user_access_begin() sections.
>=20
> Signed-off-by: James Houghton <jthoughton@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026215226.3713=
941-1-jthoughton@google.com?part=3D6

