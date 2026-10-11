Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C5834A78F
	for <linux-perf-users@vger.kernel.org>; Sun, 11 Oct 2026 20:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791750769; cv=none; b=FgxKu+opGxHCQOKsBodi6/+CMJZmTvmwGJsJTyMS+MUUclHpCC83RiAOneJha3r9Pl0wU+6Iu7FkheSgIKWYKItZravczefXrrbOZzs8ZEVwfyvRzDIBViU02bOUE7xiCeqi/7zKnHJJ7wxBdrcKNaGlyz5gtqsEAa/FWj6cbrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791750769; c=relaxed/simple;
	bh=/WJyVKhzPulHx8ZXqEhDmqlz3mUFHUVuDk4tScpPuS8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=EGNwpXkI32am4EBrR0Dxe8pMFx22kTnZMNvHn5ESFUqD6TpCkBvRk26PF9DjmokYRiDZcNN8eL4QWWUbl8PCBnnjNFbHA2atzSJS3o7JPBhgQG6f4Z3dgx2Nfm7NkB2Vj+L1B6XGzQIEKS9AUDdGOOTdOHMAB/CIpuaW++VQ3Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYstI3wF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYstI3wF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B9E1F0089B;
	Sun, 11 Oct 2026 20:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791750768;
	bh=/WJyVKhzPulHx8ZXqEhDmqlz3mUFHUVuDk4tScpPuS8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EYstI3wFNZQrlBhb6bRB3TmxCC+znUASgdu2hTecZ6QbjrWQ/uzFk62oHCCuLaL94
	 TKf/R+b6dapV4c60lcuNXLF9eyYXz4tY3WwXlc8U8iX90oAwnlv+F3F/9bSL0eQBFc
	 aYOXpD7vP/MMeLVhJti084Mp8eRLCUSb7+vELJDUCCoQv2j0zOGOFXJ+5hGezE0frf
	 98cTDyzQ+YtWs9rSQ5Hy8Xiv6fD8p+HLtdv5KdOJnWUXLK3sKd6YJ/HKRVeOV01R78
	 Y2Ki8ZtCydRpMddh4T0wMXnX3rF/F9AbW663r2AFzSqStuQKQeVc0uvPygc3S+53GS
	 2QsxTYfhgcYXg==
Message-ID: <sashiko-outbox-167454@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] alpha: fix stale user_stack_pointer()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261011-alpha-perf-regs-v3-v1-1-eaa625a39712@gmail.com>
References: <20261011-alpha-perf-regs-v3-v1-0-eaa625a39712@gmail.com>
 <20261011-alpha-perf-regs-v3-v1-1-eaa625a39712@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 20:32:47 +0000
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
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011-alpha-perf=
-regs-v3-v1-0-eaa625a39712@gmail.com?part=3D1

