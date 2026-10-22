Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792635417;
	b=CngquNEPA0g/eau4LclD5VkXqTUSoz/HtNEQx0mb6GE9LkKnLuTsaV/QdiNKf2LxLbpo
	 fV4toR+zOIpY4JZiVnbDobwOUm4l9gyJHMtkGUZY9neR/1u4mGkbXetXoV5CuJFuUBM0J
	 hce7VpzjYsiGKiWxxh1+Y/S3BXhdwlMz8G9u/MXtHMJc3FSvau80BKuIeR4E1vDyhr2jv
	 dE+CVvJVI3Cx2xtW0rEinXxASJMb4R6EsTCNcOZGqnLzQmc+0b9tr+pzDlbpk/sJADsUU
	 opQOqTdZoNlLmdNshXIPp55hcRHVL8Z1UvwkbosbfA/9i9TckZaWUYD3Z4+4KpflRIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792635417;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rZUWkJhgXWYqHAz+iW5GZpRmYts2Zgab7cpsTnrfsc8=;
	b=wQ17HC6MPyUE1pXWOcxB+D8BITgUtQ+5pMurm02+RCkuUCsjS+wdBKqQnqI8aUVvsfTb
	 KCTafXLZCiuFgQJpjcRHuzBMcwpU+Zvgbz8Vwshb5WiMCIAprop/SSUhBkhd+rBF9VypY
	 K6PNpl68+eyuxjAEWQPsxvvaxj8cJZBVKObZtfFTyM7U1AIb8d8pcRfaK5NFAe7DXDh3E
	 opZyWTj/T5Jqq7XC2fs9N1frVI1UHSoY+UVfhJK7wp/1uiYLhlfwSfXZ2aM5Ul2DG+Yp+
	 fxgvqvWmtDcb+A7n0K6hqLP7Rf8fdWZkK0+L7ztTzZNn8Mc/VSGxKgXmJquG2hBI11w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K2d+WB3M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A34606A319
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 02:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K2d+WB3M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B2B1F000C1;
	Thu, 22 Oct 2026 02:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792635417;
	bh=rZUWkJhgXWYqHAz+iW5GZpRmYts2Zgab7cpsTnrfsc8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K2d+WB3M9dJNSsALYwALl4Uw8c4od48Up+eYya+vJlCT9WpIXHoSLwKMwcwQ1YmyD
	 xJcYKRNIRc5KGMQbLAnuDhvD11Po4P7XZmW19g2FVEPkaXAZQwRDpQWWNLwQ6lb6Th
	 8fkKLqVE56ryNBmRuC6Hn8mIj7ZVkmXPlYalt1yYgwDuUKZT2jLpL5F+ld1h3+kYBV
	 DnR7MTGQa6gqdY8w/vVYqksosYpcLxLyXH00pQF8vEehTtdTFH2NEgNeDraqJh0qAR
	 2u19i9pF5FOV4bVvzhJdMJABqPdnvi/PD+BJFHHWz3k+Ryne1kv+Mz7BK0PXaHIWO6
	 sw4ZM2RqBUkkA==
Message-ID: <sashiko-outbox-180862@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 5/9] uprobes: Don't sleep on mmap_lock under
 dup_mmap_sem
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022015712.1297331-6-alexei.starovoitov@gmail.com>
References: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
 <20261022015712.1297331-6-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 02:16:56 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Alexei Starovoitov <ast@kernel.org>
>=20
> register_for_each_vma() takes dup_mmap_sem for writing, collects mms that
> map the file and takes mmap_lock of every mm. fork() takes dup_mmap_sem f=
or
> reading. When mmap_lock of one mm is busy every fork() in the system waits
> for it:
>=20
>   A:       mmap(MAP_POPULATE) -> mmap_read_lock(A)
>   tracer:  percpu_down_write(&dup_mmap_sem), mmap_write_lock(A) sleeps
>   others:  fork() -> percpu_down_read(&dup_mmap_sem) sleeps
>=20
> Only trylock mmap_lock under dup_mmap_sem. Leave mms with busy mmap_lock =
in
> the list, drop dup_mmap_sem and then wait for them.
>=20
> dup_mmap_sem makes sure that mm doesn't fork between build_map_info() and
> [ ... ]
>=20
>  enable uprobe event    105 -> 205   201 -> 481   207 -> 784
>  disable uprobe event   225 -> 294   354 -> 579   407 -> 893
>=20
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022015712.1297=
331-1-alexei.starovoitov@gmail.com?part=3D5

