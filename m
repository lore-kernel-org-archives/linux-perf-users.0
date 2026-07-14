Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6FA36E494
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 18:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784054753; cv=none; b=oqAm2ZCkQYpDtk6i6XD2TB4WQkkvaQmEgVosxvVymTVIDLPQYz5OJzQIe2BC/ZTh39d+pTxWDGF4HZI6gpdbt+AwK2vSoH6VIvB6iiDa1TI9ACe/Yg/HLB12ddsQiOFSDQN4k0ujzIyUTQ5b1Fl0K/GVO3/DS+59RuaGelu+eY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784054753; c=relaxed/simple;
	bh=4rIvN6C4IIy0lui+sYGfTiukhWDdfOWg0rPNFNrMMa8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=spsesmR0Sal6NsPK1MzQgYUEcuTHGWaj14zxbpRG4ns5beRldUaWR6jR6mYfgc7aoNXKdyjam+Ef8R0ZOf+fgwgIUwzXdNcNBf95uyUaQQz60eJfgr3S3arVPez8+PIv8w6MXbXffMHql0fr+NGZp1zwvSNlyhhEa04Rh2qOcv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRaPDKry; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRaPDKry"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9EE1F00A3A;
	Tue, 14 Jul 2026 18:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784054752;
	bh=+uRzbD8Rnam9RKqBTx+WY4X5JwQnDRkx15+/e7kQ2is=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XRaPDKryvfwGvNftQJ5IXfP9TQLdqC+hqh96AwmMmie2KQRFVxCkwBUAF43kej2Yo
	 ZlKePCqFAU4DY7cZAz0gFm/2bRg5rCou2r7E3CmDsZRRhBS9K/LgeFs9kWkdnVid7f
	 JfQP4vqSrnclLlXOX4mP1KxLj9h3fei5bZD4x/+Ks2KLIiRWC6qvGoSWk5RwTeOfJV
	 fOtGIaGHm8M5pGebcUYowugk6llY/pSH5A7yuNrX0E01wtz76hBpO8Od8SKn6ABuHQ
	 E6luwBlx7Ettrn5Sf+i2LEY7fmLkEfX/7Goi0PMRDF8I44BK+dWOeUdN2pbY+UvxUK
	 xhjsIB+Rf6EOA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 05/13] mm/kwatch: add watch expression parser and
 dereference engine
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinchao Wang" <wangjinchao600@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260714183107.12463-1-wangjinchao600@gmail.com>
References: <20260714182243.10687-1-wangjinchao600@gmail.com>
 <20260714183107.12463-1-wangjinchao600@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 18:45:51 +0000
Message-Id: <20260714184551.DC9EE1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kwatch_deref_resolve fails to validate intermediate pointers again=
st the kernel-space boundary, leading to potential kernel panics.
--

--- Patch [5]: [RFC PATCH 05/13] mm/kwatch: add watch expression parser and=
 dereference engine ---
commit 2105aab4719c42ad84e86aced2cb286ed992fb63
Author: Jinchao Wang <wangjinchao600@gmail.com>

mm/kwatch: add watch expression parser and dereference engine

This commit introduces the watch expression parser and dereference engine
for KWatch. It provides functions to parse a textual watch expression into
a configuration and resolve the pointer chain dynamically at probe time.

> diff --git a/mm/kwatch/deref.c b/mm/kwatch/deref.c
> new file mode 100644
> index 0000000000000..a93c76139e7cd
> --- /dev/null
> +++ b/mm/kwatch/deref.c
[ ... ]
> +int kwatch_deref_resolve(const struct kwatch_config *cfg, struct pt_regs=
 *regs,
> +			 unsigned long *out_addr, u16 *out_len)
> +{
[ ... ]
> +	/* 2. The Pointer-Chasing FSM */
> +	for (i =3D 0; i < cfg->offset_count; i++) {
> +		addr +=3D cfg->offsets[i];
> +
> +		if (i < cfg->offset_count - 1) {
> +			unsigned long next_addr;
> +
> +			/* Dynamically read the pointer contents at runtime */
> +			if (get_kernel_nofault(next_addr, (unsigned long *)addr))

[Severity: High]
Is it safe to read from addr using get_kernel_nofault() before validating
that it falls within the kernel address space?

If a user configures a watch expression where an intermediate pointer
evaluates to a user-space address, reading it via get_kernel_nofault()
might trigger a hardware protection violation (e.g., SMAP or PAN) on
architectures where copy_from_kernel_nofault() does not internally
validate the address boundary.

Should the boundary check be moved inside the pointer-chasing loop prior
to the get_kernel_nofault() call?

> +				return -EFAULT;
> +
> +			addr =3D next_addr;
> +		}
> +	}
> +
> +	/* Enforce strict Kernel-Space boundary */
> +	if (unlikely(addr < TASK_SIZE_MAX))
> +		return -EINVAL;
> +
> +	*out_addr =3D addr;
> +	*out_len =3D cfg->watch_len;
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714182243.1068=
7-1-wangjinchao600@gmail.com?part=3D5
