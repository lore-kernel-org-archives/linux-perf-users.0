Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5522842252D;
	Thu, 16 Jul 2026 13:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784207003; cv=none; b=J+8n9IkkaIs6qdwNmgAcurl69YpMtPiaY6HJ3gMk2yJy8di+sII1wQwgMql1F3fjQKPfugUY5r2rfu4WydS0VEZD3NXW2OnnX2kULCM5bZJW8Ls6CieqTf4sxXi2P3H41uYgSEe7/k0TpCYE7RkfkI+Qb5Q0djHdYjG5TMcW4dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784207003; c=relaxed/simple;
	bh=5V6RKx3il8R9dbRgBN7AQRTBKl9ciW/r1Sz2KP4hh/0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=msUy5I7oC2x+HaCSBmjjCIkJdlTMnBgQDqGACaJz+iVU0LvWdOysW25ApaI0mnlSR728bYiCBeO+3IoRHsCi/Jq6RVxpND7fHUpN+x6oQaW6Bb9CqzDjoXJY/1ZelRaBs5McV0Qf2BJR7I1IO27N+sZSC4SzlBrbjMFzpBrW/Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LwBwWU+p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwBwWU+p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B9A1F00A3D;
	Thu, 16 Jul 2026 13:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784207002;
	bh=v5y0vFqxwUNvJyLaRlimoeMH/ylRPIB2cdBB7jox2AE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LwBwWU+pqUfmh2adTjOz767paJk1gYCwcpExuqE/QvYlXf+QqfqtnLb225m25pK8J
	 Sun7jYD5SHRN1B/Kqm+Vd3+U+Zu5zpa6bQzW7Ar7CRhtlUhqpoIUOY/35UGOgtPQRH
	 Py8KDcqVB14FUjE9VcDvfMyz/snDdNmEB9qxdj8INdJ5bi2pjF8x6HoeFnSn6NaRwk
	 GoDZnY6QmiHPUNGMMBarmUR70gZtAYu/RqyhVK+M3S0mfh5pZh9xEOjPihklYMGyMW
	 3vunpuAplVEbcuh9ZxHCqU6BkSNuWPLZqQ1y5laqqVKPZ0MgVW9K35d0n6V7Z0fw32
	 0ml8RB8pCmt6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/15] riscv/mm: avoid Svnapot consistency checks in
 ptep_get()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yunhui Cui" <cuiyunhui@bytedance.com>
Cc: linux-perf-users@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <687dadf430c49a840e24976e37ba09f991bc3222.1784201104.git.cuiyunhui@bytedance.com>
References: <cover.1784201104.git.cuiyunhui@bytedance.com>
 <687dadf430c49a840e24976e37ba09f991bc3222.1784201104.git.cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 13:03:21 +0000
Message-Id: <20260716130321.E8B9A1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unbounded `goto retry` loop in `napotpte_ptep_get_lockless()` caus=
es a hard lockup if it interrupts a thread on the same CPU that is concurre=
ntly modifying the NAPOT block.
--

--- Patch [9]: [PATCH v2 09/15] riscv/mm: avoid Svnapot consistency checks =
in ptep_get() ---
commit 6e778d5fb0d9c3254546937eeef1badca713e19a
Author: Yunhui Cui <cuiyunhui@bytedance.com>

riscv/mm: avoid Svnapot consistency checks in ptep_get()

This commit removes range consistency checks from the generic ptep_get() pa=
th,
leaving them only in napotpte_ptep_get_lockless(). It also adds comments
explaining the lockless retry behavior.

> diff --git a/arch/riscv/mm/contpte.c b/arch/riscv/mm/contpte.c
> index 70f9a0668b50c..0f66426b0ecfd 100644
> --- a/arch/riscv/mm/contpte.c
> +++ b/arch/riscv/mm/contpte.c
[ ... ]
> @@ -345,6 +346,12 @@ EXPORT_SYMBOL(napotpte_ptep_get);
> =20
>  pte_t napotpte_ptep_get_lockless(pte_t *orig_ptep)
>  {
> +	/*
> +	 * ptep_get_lockless() must return a self-consistent PTE without the
> +	 * PTL. Recheck that the whole NAPOT range still describes the same
> +	 * mapping, ignoring A/D bits, and retry if a concurrent update tears
> +	 * the range while A/D state is being gathered.
> +	 */
>  	pte_t orig_pte, pte;
>  	pte_t *ptep;
>  	unsigned int i, nr;

[Severity: High]
Could the unbounded retry loop in napotpte_ptep_get_lockless() cause a hard
lockup regression if it interrupts a modifying thread on the same CPU?

If a thread modifying the NAPOT block is preempted by an NMI (such as a PMU
sampling interrupt) exactly in the middle of an update, and the NMI handler
calls ptep_get_lockless():

arch/riscv/mm/contpte.c:napotpte_ptep_get_lockless() {
    ...
retry:
	orig_pte =3D READ_ONCE(*orig_ptep);
	if (!pte_present_napot(orig_pte))
		return orig_pte;

	ptep =3D napot_align_ptep(orig_ptep);

	for (i =3D 0; i < nr; i++, ptep++) {
		pte =3D READ_ONCE(*ptep);

		if (!napotpte_is_consistent(pte, orig_pte))
			goto retry;
    ...
}

Will this partially updated block cause napotpte_is_consistent() to fail and
jump to retry?

Since the modifying thread is suspended on the same CPU, it would never be =
able
to resume and finish the update, resulting in an infinite spin loop.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784201104.gi=
t.cuiyunhui@bytedance.com?part=3D9
