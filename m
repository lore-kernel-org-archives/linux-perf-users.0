Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794591482;
	b=ZNq7/DYni0NRn/XfFUZmry4qTwF3g5SYFLc+ROGypzk3w6z2TbiDmMg1uGZzL7TS3bK4
	 Muh/qE1uMSA6xqUojYMpt9//w+kMzNV38OyLcDIxuOAH7Su0bMje7NExXk25ieLcuuhmm
	 uJ5lvBKUbbTXfoJkMBreTKUAYV+s8+5ez12+G7kld6XQ4h+jqzF9jadatRjKcPMDYTwIz
	 0qiu4gxSOvK/3mdTcboeV0Gpx+1+c3gT15IATEcd9+Yg5PyM7vr0hP7o1ZysJNhYdL5R1
	 q+93tMvjlFimu4pJeMIS1u5v9YIyoN1ht4NP6XI6ih522+VOCZIKuQIb+1w1tEL+pLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591482;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QiPNMFFzbs4fSgvxn5vtrUIJ2Dz3n0AdNo59EcA7IOk=;
	b=4EFjnJSf0/Bk/IgSLaZ3Tc1/pjhHhoCERq7ffs56sV0Ck5UjxJYNLjOR+Lo7Zo02v/vi
	 vE7eoSiS1OYgYUu5ig+v39dOEU552idi92wpZFROc2l638wCKTDIsEtQNptM0hHy9UYXU
	 gA4+UrbfYAflJY/2dSq0h8VNzFIN/0AgtyRuteQlDQ5GST4r//MFFubg/s5F5LYPpcCXH
	 JrEB/fnfILzzqG3XoS1jcPvPs0i2M2zuzB4jkpzrG9RBH7rbm/M0TQz0qKCyF6533F6Dr
	 X0EGKlZz/KiKGZSLaZmFiOlVSCx4WYkliJAsOf4OD61D62/r6AHJPMXQcvVDRr3yUzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=glX9SIYk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA44607E046
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 17:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=glX9SIYk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB211F000C5;
	Fri, 13 Nov 2026 17:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794591482;
	bh=QiPNMFFzbs4fSgvxn5vtrUIJ2Dz3n0AdNo59EcA7IOk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=glX9SIYktbSBpBPgzkoWuZ2aAeaHjsCUyFC63gXHizqMnFHPPN1P9pdUoHNmhBb4x
	 SOVbwcDpe1ru5nO/EHyDBqber90jcl8+aIkGujmaQtZWxDfiP+yzYjCOzxM3yONXsY
	 x/Vcgf0eicxuBZKYBy+2v/luEimfdbuDIqb5J2sqHhgAeQ9GM6zHBrrXhx5pbHCYj4
	 l+0lYCswU0eJ2POv4SCzXVeOCtbFvZjgKK8R3xZZEh1Gzr88AXuTKgJIUU50QWAJo0
	 RuInRjATwuzhpPihZaxNuV2dwDNnkJmU1jGQR7dD8Sqj01rdgplZePN8BVMyysBOp9
	 /qu8b8xNYi4sw==
Message-ID: <sashiko-outbox-213335@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 19/23] perf symbol: Optimize symbol sorting with
 natural-run merge sort and binary insertion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113171734.2188066-20-irogers@google.com>
References: <20261110220803.2503416-1-irogers@google.com>
 <20261113171734.2188066-1-irogers@google.com>
 <20261113171734.2188066-20-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:38:02 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> ELF .symtab and .dynsym sections are typically already mostly ordered by
> address in ascending runs, and dynamic symbol resolution
> (dso__insert_symbol()) frequently inserts one or a few symbols into an
> already-sorted DSO symbol table. Invoking full-array qsort() on every
> sort after incremental insertions or across pre-ordered ELF runs spends
> avoidable CPU time in symbol comparisons.
>=20
> Speed up symbol array sorting and out-of-order symbol insertions:
>=20
> - Track the sorted prefix length (@sorted_cnt) in struct symbols and
>   replace full-array qsort() with a natural-run merge sort
>   (symbols__sort_range_with_tmp()) and galloping binary-search merge
>   (symbols__merge_runs()), plus an O(N) in-place binary insertion fast
>   path when <=3D 8 symbols are appended.
> - Insert directly into sorted position in dso__insert_symbol() when
>   symbols->sorted is true so dynamic single-symbol insertions maintain
>   the sorted invariant without triggering full re-sorts.
>=20
> Using 'perf bench internals symbols':
>=20
>   Before:
>     Average DSO load + sort: 6.242 msec (+- 0.057 msec)
>     Average bulk insert + lookup: 1404.150 usec (+- 18.752 usec)
>     Average append + lookup: 40429.750 usec (+- 507.578 usec)
>   After (-7.0% load, -13.9% bulk, -99.6% append):
>     Average DSO load + sort: 5.808 msec (+- 0.047 msec)
>     Average bulk insert + lookup: 1209.250 usec (+- 18.446 usec)
>     Average append + lookup: 152.900 usec (+- 0.736 usec)
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113171734.2188=
066-1-irogers@google.com?part=3D19

