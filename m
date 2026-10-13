Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FB1378823
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 08:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791879827; cv=none; b=iEreiuZrNqKJdMdiO14c1DXdseJyhIzhzxaxoI6XOamvLZ+sycIKEbg7eSDI60h9Lz+AQJ9aYKVJ3wCGDmxVWVA/KABO+KIrPVrGc0tpEGBAa35NCMKe+4gkXvLf0xOEKMFJd1VHOqdBGWOh1UxaDx+mFO9jyQYkHUxbQlmjV9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791879827; c=relaxed/simple;
	bh=fAcMBbd51bcHOwBKLc4xecUv4PeZoMB+rndwybCc7/M=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Ha0m8u/tEfuSViuA0AbFn9JTKcw1lS4wEsL4+H8Bzt8ygoT5SXizGat+2Vatd+ilTcgPtT2VOx2rQlAALAFvrK9IEnxDXQ3LKcqejkBS0nyeAGwj+1nE0SKMzo52P4oVviENu8rK9NhtfmSdFOVJzZePFtLVEe9y5WQFK7+7OKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oT04mpqL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oT04mpqL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B161F000FF;
	Tue, 13 Oct 2026 08:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791879825;
	bh=b43DpWIjNb9nYYUi5wnsXjXRUS/49g28vMPfOTz0kmc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oT04mpqLjMeFRO8PoNYuk4rTIP0u6V3ICOJV68IgaOOWPNln9gQRliRPJ9S6Kop2V
	 OK637G+K6FHi+EZjwSu7tmP8yO35ej+u/1pqYK3/qNrFWfGRReEJ/bKhFojcKkuSo+
	 jhHpiB1kKgaXdyRxRLP+LbzK5IJi6SY2bjagGnh81bj5L7GrulS5Yh9j3zuEt2+T5I
	 fhhvAbU+pq2zNh/kuOyTwoBLja3RuUCuM1VzXk+ViG/VYGse6KtdNX+9jqk6n7J1tE
	 IQHfF3pq5DJ18rx+EFj+sJOJ/KGgzxRq2f8cOUcAgs0mYrr90r2Loq3WtCAqq5OZHP
	 +Df0nfjmBpujA==
Message-ID: <sashiko-outbox-169241@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/x86: Don't WARN when the ext_regs_buf allocation
 fails
Reply-To: sashiko-reviews@lists.linux.dev
To: vineash <vineash30640@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <179187920064.3441876.15687522011658301558@gmail.com>
References: <179187920064.3441876.15687522011658301558@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 08:23:45 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> reserve_ext_regs_buffers() wraps the per-CPU ext_regs_buf allocation in
> WARN_ON_ONCE(). The allocator already prints a warning with a stack dump
> when a GFP_KERNEL allocation fails, so the WARN only repeats it, which
> Documentation/process/coding-style.rst asks not to do. The failure is
> also handled: the buffers are freed again, the event is still created,
> and events that ask for SIMD or extended register sampling are rejected
> with -ENOMEM in x86_pmu_hw_config() and event_simd_regs_validate().
>=20
> syzkaller hit this with fault injection on next-20261002. The trigger
> is a plain hardware cycles event opened while no other x86 PMU event
> exists, with the allocation failed:
>=20
>   !per_cpu(ext_regs_buf, cpu)
>   WARNING: arch/x86/events/core.c:441 at reserve_ext_regs_buffers arch/x8=
6/events/core.c:441 [inline]
>   WARNING: arch/x86/events/core.c:441 at x86_reserve_hardware+0x6ff/0x880=
 arch/x86/events/core.c:458
> [ ... ]
> warning.
>=20
> Fixes: b84c96283684 ("perf/x86: Enable XMM register sampling for non-PEBS=
 events")
> Assisted-by: Claude:claude-opus-5-5 syzkaller
> Signed-off-by: vineash <vineash30640@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179187920064.344187=
6.15687522011658301558@gmail.com?part=3D1

