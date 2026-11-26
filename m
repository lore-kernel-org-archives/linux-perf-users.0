Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795666967;
	b=kZHetb44wVrJAZzyifhblPdTUR/0TRYGO0HmNQ4W57EZ1AmMbkp6/uNJ9F9beSJ6nPSS
	 /RYXibtNCDPpjOXji9Am0FK5eH3BuxILiIA09TdrF+PTeJDz+PWmQLQHsqQR80fyYASMA
	 8J+2OXqaATNWWzfzDdkgTwacD++YbRmpLWjKn8MuvvQacsYARz5wOPOGsQW9kvUWjUX43
	 to4TmDNuL78VhP34mWBoCI3sB7clxb0E6aZ/vUlU5oTlWBNLWwBmonFqBNk+4PgFeurRC
	 +XmGCW6oGYVGsNPXGqCcVppsRisk7CQ7fbnWFeYgRgugSku2Ik7uzrf6D6HGBsgtCtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795666967;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6IX/rxcLNwGhwnLZ277mL3p0ntb17YKkScH+lESAbgg=;
	b=XIjY7Gd/ov4kLI/4/kS7NFkYk98FkauD0jOUsIZQclrP62uKZYv1U/HtgQlchlzPVek7
	 g3MGJcoGyUrL2Ax2Gj5upU9OgVQ+Q9X0Jnl8WeVR4ZLCOtgI1iVBWDncNjvpdRwa38cxW
	 ai0bQFz6sNGNNXUv+7XoOhJ+oXZ5MiQ+mtJqM/Kd7V3iRVRi1XrApnWNVoNEb8BXGonnT
	 9PLDDDWL1GK51AiH7mVtCfaTfrJtTM27gYxxtd48uOVx2yDTsSA5Kbdfsv/IufXsPttLL
	 /1z/1x6luxJxB1K6IPVG8EkUiBGIqfm6Jb5b5qU+09N5hXVhMrxFiGG8iJIaqb6+VlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fgdp0qZC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0E2606A31C;
	Thu, 26 Nov 2026 04:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fgdp0qZC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA93E1F000C4;
	Thu, 26 Nov 2026 04:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795666966;
	bh=6IX/rxcLNwGhwnLZ277mL3p0ntb17YKkScH+lESAbgg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fgdp0qZCEPnStMbKpkYGr7ZA1fngeOlDmigN03hYtqBWXrfCNtI/Gz4wNfj15gMqV
	 kdWO79sZKwKFRmty0cWeK4oWuxWL9mNSlTAjqzlYiwl9j2CmjsXONT1k1EPm3hXj1w
	 HFQbiuoyo3HdeHN3icFc1JHAHnol8qtFqAeLOQrarZg3SroxXjJ2WIdtY6f010kod9
	 6z46a2X1dbKIoeBfeOUSJw9dnp3wGMzwcWvMSEe89TwwJUVIf+9JvkOeUy2eI7mgS4
	 VsXk3jh+vs6TK0iwowiklkUuOMtjCbc9uM1xkfaUiceLvzAZ5CiVkWvkTJL2SXAGyp
	 aQCuHrTYGOfuA==
Message-ID: <sashiko-outbox-234729@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH stable/linux-6.6.y 4/9] perf/bpf: Call BPF handler
 directly, not through overflow machinery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luo Gengkun" <luogengkun@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261126043458.2394658-5-luogengkun@huaweicloud.com>
References: <20261126043458.2394658-1-luogengkun@huaweicloud.com>
 <20261126043458.2394658-5-luogengkun@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 04:22:46 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] perf: missing SLAB_ACCOUNT in perf_event_init() [1]
--

commit 4af8ba4aec15ed1b6050b9027e93e306d86849aa
Author: Kyle Huey <me@kylehuey.com>

perf/bpf: Call BPF handler directly, not through overflow machinery

This commit refactors BPF perf event overflow handling to invoke
bpf_overflow_handler() directly from __perf_event_overflow() instead of
replacing event->overflow_handler, and removes orig_overflow_handler from
struct perf_event.

Link: https://lore.kernel.org/r/20240412015019.7060-5-khuey@kylehuey.com

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 523d9bbc305bd..ba9cbf50773e8 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c

[ ... ]

> @@ -12121,13 +12118,11 @@ perf_event_alloc(struct perf_event_attr *attr, =
int cpu,
>  		overflow_handler =3D parent_event->overflow_handler;
>  		context =3D parent_event->overflow_handler_context;
>  #if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_EVENT_TRACING)
> -		if (overflow_handler =3D=3D bpf_overflow_handler) {
> +		if (parent_event->prog) {
>  			struct bpf_prog *prog =3D parent_event->prog;
> =20
>  			bpf_prog_inc(prog);
>  			event->prog =3D prog;
> -			event->orig_overflow_handler =3D
> -				parent_event->orig_overflow_handler;
>  		}
>  #endif
>  	}

[Severity: High]
This problem wasn't introduced by this patch, but should perf_event_cache
use SLAB_ACCOUNT (or GFP_KERNEL_ACCOUNT in perf_event_alloc()) so that
struct perf_event allocations are charged to the calling process's memory
cgroup [1]?

perf_event_init() creates perf_event_cache with KMEM_CACHE(perf_event,
SLAB_PANIC), and perf_event_alloc() allocates from it with GFP_KERNEL |
__GFP_ZERO.  A containerized task can repeatedly call perf_event_open() to
allocate unaccounted perf_event objects, bypassing its memcg limits and
exhausting host kernel memory.

[1] https://sashiko.dev/#/bug/linux-83d96148-5109-41b8-9975-d17680148a68

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126043458.2394=
658-1-luogengkun@huaweicloud.com?part=3D4
