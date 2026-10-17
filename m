Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A357B397921
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 02:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792202457; cv=none; b=JWCydnuvUSqmuAcKdpEKBJxtKxo3hodY7EquIegr4biDpyqBhgXg574Umqu3khxyYTiFhI2vhQg33rP1xj5epeDSP3tttCK68rtQR7UVnEHGzvXnKnM36Hi1z4CGwC+HU8BbJYFsoCllXYJQ+x4nDvhacoBdzeiThi5sD8zjM50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792202457; c=relaxed/simple;
	bh=eHuXXCcbEHRchNxlEmOAY0QJPBDrr6xb2q8TI7xa7Hg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=AHTY2nc49nZt6jGHqVbF8kerkIURVB/5YjIaAxeomgAEY/2gceSkPb8Yu9mUXzmoSEO0L3DXsCj7y1ZGoSMuFJmGe7S2CSCxeZ1AYvVqo+1cewuaCsSvMRILFKuoffQO0s5AtqGVs+QSnVxgGfl7B5OgnGkFKBfD9PF57xJNkO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3853Cbl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3853Cbl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 515691F000C5;
	Sat, 17 Oct 2026 02:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792202455;
	bh=eHuXXCcbEHRchNxlEmOAY0QJPBDrr6xb2q8TI7xa7Hg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k3853Cblw4E83KAdUMgs9rWSTNifXiwQex20ogImz3KlE4NspvKTl8nsr+ZlgFc5b
	 LMoqCclRhroQio8rDsYCT3DWuRuIkIhNF3XH49tk/uT4ETh44Mwi2ajWbGiDcS9yij
	 6EZUa2lqmKJVggYsw4K0Jrf7BYyFL7xybyIpGIt9eCx/+Bu2iUjeVdkeODRTZEYgfU
	 zPLHWT49UXSDoMlFhozZfTpay4cz+VFGJudkt45wKrNcYY3SyX6gLdb9EaQvsuL6Ud
	 z6DRsS8spfkH5G/JUBjoJlMrGnXQ9PPWm0JUaPuU54I2Ncy9OFj1blohw1E/W6UQq5
	 pgL27EnveJrXA==
Message-ID: <sashiko-outbox-175173@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/5] alpha: fix stale user_stack_pointer()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016-alpha-perf-regs-v3-v2-1-17654742226a@gmail.com>
References: <20261016-alpha-perf-regs-v3-v2-0-17654742226a@gmail.com>
 <20261016-alpha-perf-regs-v3-v2-1-17654742226a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 02:00:54 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> PALcode keeps the user stack pointer in the PCB, not the trap frame, so
> pt_regs->usp is only valid where entry code stores it: entSys,
> do_entArith() and do_entIF(). Interrupts, page faults and unaligned
> traps leave it stale, and ptrace and /proc/<pid>/syscall read it
> through user_stack_pointer().
>=20
> A user-mode pt_regs is at the top of its task's stack, so find the
> thread_info from it and use rdusp() for current or pcb.usp otherwise,
> as KSTK_ESP() and the regset code already do.
>=20
> Fixes: 8a2857bc2b30 ("alpha: enable regset-based ptrace and core dumps")
> Assisted-by: Claude:claude-opus-5-5
> Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
> Tested-by: Magnus Lindholm <linmag7@gmail.com>
> Acked-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-alpha-perf=
-regs-v3-v2-0-17654742226a@gmail.com?part=3D1

