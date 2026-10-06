Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF797248867
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Oct 2026 03:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791258553; cv=none; b=SYGrxB18XGNyM6tUSDUd3ZKf/H/BGC7NqfAOqXPWqsjtjsztpQiMakOtvwAEU7VthOPESA4Gbmfmm5vc6rF27INyB5Bd7qfBAEJfMTqsT1Q3szjNjp3tvc268b9aFqSn4ZGP0DBanx7j6dFBDWbUzWN4YChyyAloK3ZJS2N737M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791258553; c=relaxed/simple;
	bh=PFYKzcZOtLw9lNE6tKJkHH84+rRCy2m97L2fkVCy++U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RrpCGRh4rYOSJqxxdxPbcP+0J1dpHEWF3fMcbjOnrSMtX7Pd/Vy+ME4Sb5dx9bxIEDDNvTTFBKqx7VMxXnS6gZLqSvvMxtBvbQSDTGnohoQkPr67gni5zb7CB86WZY5GvEJ3SKgdpWVGL4A5GxFUf6Zkpo3dSeR8eKcT5zovx14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duFSLHTv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duFSLHTv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263661F000FF;
	Tue,  6 Oct 2026 03:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791258552;
	bh=tvd0Aw925VNT82WXsX+HC/OSgwkbH47glgRUBOzReU0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=duFSLHTvDNkVP4lYBtobyVeDpDlWwIWmo0O/qzORbAgi/SSdGv1RrbW+5Ic7OKKD0
	 0NCq/sKUf3ik4eaKA+q7o0cd4a053RwtwC/l0ani7U/ArgdgHxm6nwq/Ke1Vt/0Ut9
	 9P8juktm6dO3q3RRW12aA3t2qJEzHre4VXIpgkGOxU9JLYxH4F/2t9CZ2MHovr7rQn
	 i9clhOQIGBQNLISDaqIP9z7M5GaCwzCOQvMgsmYAu/gyB1nRHgR6Il2LnnRu/U1WzP
	 rNuklMZAxAU36HS6wJi+QHbsCS+QDNwu1xmWgmkMFP5DXuwMxjdL5T7B4iSzEdqY/d
	 BzznxUWhAXkCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/core: Protect put_ctx() wakeup with RCU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Weiming Shi" <bestswngs@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261006034224.3014697-1-bestswngs@gmail.com>
References: <20261006034224.3014697-1-bestswngs@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 03:49:11 +0000
Message-Id: <20261006034912.263661F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> put_ctx() drops a context reference before checking ctx->task in its
> non-final branch. perf_event_open() can break an inherited context
> relationship in find_get_context() while a concurrent close() drops the
> context's final reference, allowing free_ctx() to run before the
> post-decrement read. A reproducer triggers this on an unmodified KASAN
> kernel:
>=20
>   BUG: KASAN: slab-use-after-free in put_ctx+0x213/0x220
>   Read of size 8 at addr ffff88801ef4b480 by task poc/5714
>   CPU: 2 UID: 65534 PID: 5714 Comm: poc
>   Call Trace:
>    ...
>    put_ctx (kernel/events/core.c:1394)
>    find_get_context (kernel/events/core.c:5135)
>    __do_sys_perf_event_open (kernel/events/core.c:14083)
>    do_syscall_64 (arch/x86/entry/syscall_64.c:84)
>    ...
>    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
>=20
> Hold an RCU read-side lock across the decrement and wakeup decision so
> free_ctx() cannot reclaim the context until the access completes.
>=20
> Fixes: 59f3aa4a3ee2 ("perf: Simplify perf_event_free_task() wait")
> Reported-by: <co+8a0b9fcf1e087762@bugs.sh>
> Assisted-by: LLM
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006034224.3014=
697-1-bestswngs@gmail.com?part=3D1

