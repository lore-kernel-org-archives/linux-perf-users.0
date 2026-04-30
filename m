Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981913793C3
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Apr 2026 11:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777549709; cv=none; b=pqkyCTf79wui3desmELLRBXZsIys9l/UlxuBaTmqmUVib0nOsFBQjPqaJ6AZpmPxg3x46Hpayi/+MoFMwyQii7MQopgBNZFyQkGbluc6XTgEn8U5HOvLTkCiXBiq7oFmVqSQgBEhQFd+8aU+RhI8hn4httH1afGlVsAhwaDicP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777549709; c=relaxed/simple;
	bh=I/lSCgiJ81MC9a0cgQrJGRpl4H7hqjMsOhsV99BwD2g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZoTvGZHEvqPY48DT4khBfk8UH0TdKyBf9odlKXaUdqDbMmSevdyOr317Za9ofco9oPAYIJo3AjZlGSMt+6BYwCUjCabsrhYyS9cj5IXkWAG51bcVcQyzx9FkAX4xoOgBHbKJFfiPhX5ZE+uPOcbpkjcsfmvKGQHoiaK2q1XOFfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gy9c43hu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gy9c43hu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274ABC2BCB3;
	Thu, 30 Apr 2026 11:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777549709;
	bh=I/lSCgiJ81MC9a0cgQrJGRpl4H7hqjMsOhsV99BwD2g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Gy9c43hu5rS0nL4y8AGGezImCfHXliIxf7aKQmrU0vFPPv1MHZ9v51M0sURs1JHjI
	 qOgnctD6u+LQ2/2G0WckQxgkU+ceVKrwS9QgLSIqN+cGDKww7Bsst/QZ4p7u/GuXqk
	 qr93Zutia/fPfRBHOpm+KmVxmFGc3H75iBy/9UogGZRbe5W+GRoJtstEgyUsBC9s78
	 nSDya6ud68w6wyCpXBjg5lmv3IMgOFm6yVGgCTSgyCqhrfS2SqJ0jORbzNSp+9/B9s
	 Hj5nJYdo7ya6SVBuVOXhj9Iqh0L5TU8lRc/cvB5iiVx0NNkIOLij3foeAvdnWDVaFo
	 KBObF7YHRBcng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] arm64: perf: Skip device memory during user
 callchain unwinding
Reply-To: sashiko@lists.linux.dev
To: "Fredrik Markstrom" <fredrik.markstrom@est.tech>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260430-master-with-pfix-v3-v2-1-bd526ec04a75@est.tech>
References: <20260430-master-with-pfix-v3-v2-1-bd526ec04a75@est.tech>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Apr 2026 11:48:28 +0000
Message-Id: <20260430114829.274ABC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Time-of-Check to Time-of-Use (TOCTOU) race in the lockless device =
memory check leaves a window for a kernel panic.
--

commit ed429c75630a0d1b28e968c7cbc91dc9b7885fe0
Author: Fredrik Markstrom <fredrik.markstrom@est.tech>

arm64: perf: Skip device memory during user callchain unwinding

This commit adds a lockless page table walk to inspect the MAIR
attribute index in leaf PTEs before reading userspace frame pointers
during callchain unwinding. If the PTE indicates device memory, the
frame is skipped to prevent kernel crashes from MMIO reads.

> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrac=
e.c
> index 3ebcf8c53fb04..4a28df9bbe763 100644
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c
[ ... ]
> @@ -524,6 +627,9 @@ unwind_user_frame(struct frame_tail __user *tail, voi=
d *cookie,
>  	if (!access_ok(tail, sizeof(buftail)))
>  		return NULL;
> =20
> +	if (range_is_device_mem((unsigned long)tail, sizeof(buftail)))
> +		return NULL;
> +
>  	pagefault_disable();
>  	err =3D __copy_from_user_inatomic(&buftail, tail, sizeof(buftail));
>  	pagefault_enable();

Does this TOCTOU race still leave a window for a kernel panic?

While the commit message notes this race, a concurrent thread could remap
the target address to device memory between the check in range_is_device_me=
m()
and the read in __copy_from_user_inatomic().

Since arm64 hardware TLB invalidation broadcasts to all CPUs without requir=
ing
software IPI participation, could the racing thread successfully replace the
VMA and update the TLB even if the unwinding CPU has interrupts disabled?

Additionally, when called from process context via ftrace, interrupts are
fully re-enabled after the check, which might allow preemption to widen the
race window significantly.

Could this allow an unprivileged attacker to trigger a synchronous external
abort and cause a local denial of service?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260430-master-wit=
h-pfix-v3-v2-0-bd526ec04a75@est.tech?part=3D1
