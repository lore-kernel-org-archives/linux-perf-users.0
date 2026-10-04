Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D383539AD3B
	for <linux-perf-users@vger.kernel.org>; Sun,  4 Oct 2026 17:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791135928; cv=none; b=FJtj/gecbacGhTBUoEbhPizEANo0kHZehXA7yGK+405+OIzlpJufuI/Xd3NgBFr5U85iC9Up3yBwXE/b1rEazpzNoNEYnNN94UUTJ3mR0LpOyvf6hyBqJjzEaDt508UOKrEkfzx59DSlJQO5nCI8vfkyYzacZwDh13a5Se9BAK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791135928; c=relaxed/simple;
	bh=s/+eqsCrAi8SDjIji+nRn3E7lBFu/ubKbC9LYgoyBSE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ONkeQvqhkwsvY5EUwWY3idl1gbAOJO60KV9LAmqwYIsAeRb9WoWiXSLaTBx3d+Om0RovmnUA/C1R8a4yKkZ5tnkyEn44kuHesd4Vi2z9tJJ7byW6q59qYB2tqp0qIhxhbfPTRwhapRxl2vhib5115U7dp6adN80Qbn+0JSIuozc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMk4C2wF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMk4C2wF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4111B1F000FF;
	Sun,  4 Oct 2026 17:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791135926;
	bh=NKDOdiI3LcvuGbwaq2gOY8seRHlJUXe5vTOAE2UWcz8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fMk4C2wFxqZy9Eh7ec8L3AquZLOhEio5HMuNrgOTtGX25MpAWgLY70MX3jeIdxabs
	 GAURmNj3xRSFzCYZNBN99Id7LMArEPgYmMWiPwf77tWu8EM7NIB3jzoC+3poKIh7VJ
	 WjdsdRK2PgNPwHn6NYQ+XkkTiUEP+8hLhTEhRYgRN5zlGoav0YngkKWwmYU8sNAWnQ
	 ZOq1pOFnkk4cNgD68CQXk7m5eh7dQ1V3ZEmB2952I++N7dVgkG7z8Njrg9NxfAGdk9
	 an75gd0tB10CxjlrxfErzVwO/QERxFEqvqqhRaV+fSSUuppaQ4e/XDa4mWq+BvqjK8
	 016FfMTBeSkMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] perf/core: add AUX ring accessors for kernel
 consumers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kunwu Chan" <kunwu.chan@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261004173458.837842-3-kunwu.chan@gmail.com>
References: <20261004173458.837842-1-kunwu.chan@gmail.com>
 <20261004173458.837842-3-kunwu.chan@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 17:45:25 +0000
Message-Id: <20261004174526.4111B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] perf: misplaced smp_rmb() in perf_event_aux_tail_set()
--

commit bf06e748dd797d73b38eceb210cb85ac496712d0
Author: Kunwu Chan <kunwu.chan@gmail.com>

perf/core: add AUX ring accessors for kernel consumers

This commit adds kernel-consumer accessors for the published AUX producer h=
ead,
the consumer tail, and copying a possibly wrapped AUX interval. It introduc=
es
these helpers to allow kernel consumers to own and drain the AUX buffer
without relying on the overflow path.

> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index eae28e42346c7..2c6f260fcf91b 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
[ ... ]
> +int perf_event_aux_tail_set(struct perf_event *event, unsigned long tail)
> +{
> +	struct perf_buffer *rb =3D ring_buffer_get(event);
> +	unsigned long advance, aux_size, head, old_tail;
> +	int ret =3D -EINVAL;
> +
> +	if (!rb)
> +		return -ENOENT;
> +
> +	if (!rb_has_kernel_aux(rb)) {
> +		ret =3D -ENOENT;
> +		goto out;
> +	}
> +
> +	aux_size =3D (unsigned long)rb->aux_nr_pages << PAGE_SHIFT;
> +	old_tail =3D READ_ONCE(rb->user_page->aux_tail);
> +	/*
> +	 * Pairs with the producer's AUX-data write barrier in
> +	 * perf_aux_output_end() before it publishes aux_head.
> +	 */
> +	smp_rmb();
> +	head =3D READ_ONCE(rb->user_page->aux_head);

[Severity: Low]
Is this smp_rmb() necessary here? Memory barriers order operations, they do=
 not
accelerate visibility. Since perf_event_aux_tail_set() performs no payload =
data
reads, there is nothing for the smp_rmb() to order against the read of aux_=
head,
rendering the barrier functionally inert.

The comment claims it pairs with the producer's AUX-data write barrier, but
without trailing data reads, this pairing is meaningless. Does this result =
in
unnecessary code complexity and a negligible performance overhead, while
providing no structural safety risk since the subsequent smp_mb() correctly
orders space release?

> +	advance =3D tail - old_tail;
> +
> +	/* Modular distances keep the check valid when a cursor wraps. */
> +	if (head - old_tail <=3D aux_size && advance <=3D head - old_tail) {
> +		/* Order all prior AUX data reads before releasing the space. */
> +		smp_mb();
> +		WRITE_ONCE(rb->user_page->aux_tail, tail);
> +		ret =3D 0;
> +	}
> +
> +out:
> +	ring_buffer_put(rb);
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004173458.8378=
42-1-kunwu.chan@gmail.com?part=3D2
