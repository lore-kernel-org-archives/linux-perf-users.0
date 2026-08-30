Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD552931F4;
	Sun, 30 Aug 2026 14:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788100859; cv=none; b=hGC87jLxIQLZjflFbfq4wY2t5mVpwqKeaGz6Yp12lrlxUVzCG1rbYRZO56zFDGp+6vjY4Bgok8WQ9/H3+ucZyAkJpBQ1SdEAb7hRscHyq7v5X55s/d3EPysFOD0+sZyd/Emoo8XXd1FhyAn11hH1QWVtrUePaNLHt9BNaFh01lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788100859; c=relaxed/simple;
	bh=iVju7wnWO6EiCXfbIXqdD7a+W7EEwhW6kOkpi3zEodo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MdGYTqz1EiCmqJ4aw3be9xKqkH0tSA+L8OZ5ek82ZKoAAIdptb1XE7+3OZdsZAheHl9iCp9CE1WItV6nnGdsSUAbGCCOw6XhJruDy6HajhiEhaMVvCBavCAIzFqLXPU8fTaWEDGOH6IlA7YkftDIUjyaMk15S0d8ExdC8b7f1Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AAGpib0v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AAGpib0v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6391F000E9;
	Sun, 30 Aug 2026 14:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788100857;
	bh=clShHUCuHkddYxb4aEGzDGrBApei6IBQkXi3D/x0ZHc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AAGpib0vrIn/FPxq3AK14bn4R1GO71AhGkFbeSF2uZc8g/E5f9ITo8DL3rh0a58M8
	 zKvHuCFBx8mKTRw5hRR9tYRS/7p4kvTI483hbmQGlShMHwx99WlrqHbeFF8kvy4P61
	 aN3fIA+VVbuuxyBdc1dnFpT1jQ9MHdPC339bRdylT+hRd08enUlkytlUEeWI4Jg6L0
	 4fc9DdkhhrqDvmKsfm/fTngEGdI+nM0ViIgmL9ytKpcYuNaR3ClAgO4LHU+728IYDg
	 j1W0pUSfIK6jJXBRV+Kdya0Ev6YAg4VdY1+HNYwZOlZNmI3V4YchUo7ynheRwLtsRr
	 d6OxPKgnKscnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 06/14] HWBP: Add modify_local_hw_breakpoint_addr()
 API
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <178810007699.64882.3789162690369937099.stgit@devnote2>
References: <178810001186.64882.2161016469449127450.stgit@devnote2>
 <178810007699.64882.3789162690369937099.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 14:40:56 +0000
Message-Id: <20260830144056.EB6391F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Lockless updates to `bp->attr.bp_addr` and `counter_arch_bp(bp)->ad=
dress` lack `WRITE_ONCE()`, constituting a formal data race under the Linux=
 Kernel Memory Model.
--

commit 0c79300d09e43eac52a027f6cb480808e7f3902f
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

HWBP: Add modify_local_hw_breakpoint_addr() API

This commit adds the modify_local_hw_breakpoint_addr() API to update the
watched address of an installed hardware breakpoint on the local CPU without
releasing and reserving its hardware slot.

Link: https://lore.kernel.org/all/f9c49dfa49bdc57ba8c0574bc9981c1e581acf92.=
1785067572.git.wangjinchao600@gmail.com/

> diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
> index 789add0c185a0..124074c3d3bc2 100644
> --- a/kernel/events/hw_breakpoint.c
> +++ b/kernel/events/hw_breakpoint.c
[ ... ]
> +int modify_local_hw_breakpoint_addr(struct perf_event *bp,
> +				    unsigned long addr)
> +{
> +	unsigned long old_addr;
> +	int ret;
> +
> +	lockdep_assert_irqs_disabled();
> +
> +	old_addr =3D bp->attr.bp_addr;
> +	counter_arch_bp(bp)->address =3D addr;
> +	bp->attr.bp_addr =3D addr;

[Severity: Low]
The function intentionally updates bp->attr.bp_addr locklessly so NMI handl=
ers
can observe the new address during the transition. However, without WRITE_O=
NCE()
annotations, does this constitute a formal data race under the Linux Kernel
Memory Model?=20

While a torn store on 32-bit architectures might only overwrite the upper 32
bits with zero (leaving the address functionally intact), could this still
trigger KCSAN warnings when an NMI handler concurrently reads bp->attr.bp_a=
ddr
via perf_bp_event()?

> +
> +	ret =3D arch_modify_local_hw_breakpoint_addr(bp, addr);
> +	if (ret) {
> +		counter_arch_bp(bp)->address =3D old_addr;
> +		bp->attr.bp_addr =3D old_addr;

[Severity: Low]
Similarly, should the rollback path also use WRITE_ONCE() to ensure concurr=
ent
accesses by NMI handlers avoid data race warnings from KCSAN?

> +		return ret;
> +	}
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178810001186.64882.=
2161016469449127450.stgit@devnote2?part=3D6
