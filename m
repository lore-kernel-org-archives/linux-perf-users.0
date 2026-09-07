Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60F93F1046;
	Mon,  7 Sep 2026 03:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788753444; cv=none; b=qD5YGnB3hsS4NVa/9MwqQUfrFdDx0m2Pf31jFcu3os4bNOY8prYXtgYpjcGRbjC1iG0pgsUve13ENBd/cP6vgfFit+abCfnY8ZjdHNXWtESvKgoJS/50IAKQURq45FEgPLuUhyrma65rrNJJ1jtxH+0HM/R/x7TBKxV9Vl7nix4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788753444; c=relaxed/simple;
	bh=BtkVI2Y8AQU0/w2d83OIHvQsr7/kZhtoCWtkymoxDlc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LHqRnv+gqOUABELE1nhdVAbGJDn6HfsvECfyv3Q/yrSQrv9LwloWaKUy94MPljdAcHIxT1SXOPOqLDQLW+8EWkqzHsYCns92LnOfNonlsJGaZesUJxexU6ov+iG5mIAAmckvYNLVFcjdAR+Hu6gEc6wswx+Ydk64SNagB7OVJVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXMCJta8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXMCJta8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD731F00A3A;
	Mon,  7 Sep 2026 03:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788753443;
	bh=BtkVI2Y8AQU0/w2d83OIHvQsr7/kZhtoCWtkymoxDlc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KXMCJta8umaco2lAvO5bTkuUkFS6XiM0Te6vgfoy3Wy1j6iUnbPErWEolLgKxieZW
	 9MBclqMT8ypuAvWBxZ8Meaky71rLMP9zM92HjG7EuNrqiMbe8xakt6aB5hCr64DBAw
	 PFIEJ4wk6m2wksDIy+bRwt2HixgTN4qxgyp6totE5HPihuzYqkZgHwsWp1pfb8QkAO
	 r0Rwp74qXS83cYAG1KVWjJp68TPy+0avTnWDJ6aM0xuTBlo/rpMj9aGekxJOPERnZO
	 cientiBujPhhZf3lF6a+9h19EAe5em6DZuTZrguP1ITqDY1XaPmZuZ1oxtUViuw8lH
	 ZZm9c2foflbDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 01/12] x86/mce: Fix hardware debug register
 corruption on task migration
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <178875279006.93794.3424002631388906633.stgit@devnote2>
References: <178875277830.93794.14247844688761142429.stgit@devnote2>
 <178875279006.93794.3424002631388906633.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 03:57:22 +0000
Message-Id: <20260907035723.0AD731F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> In exc_machine_check_user(), local_db_save() and local_db_restore() are
> invoked in the outer entry stubs (DEFINE_IDTENTRY_MCE_USER,
> DEFINE_FREDENTRY_MCE, and DEFINE_IDTENTRY_RAW), surrounding
> exc_machine_check_user().
>=20
> However, exc_machine_check_user() calls irqentry_exit_to_user_mode(),
> which handles pending thread work and may schedule() if TIF_NEED_RESCHED
> is set. If the task migrates to another CPU during schedule(),
> local_db_restore() runs on the new CPU with the dr7 state saved from the
> old CPU. This corrupts the new CPU's DR7 hardware debug register and
> leaves the old CPU's DR7 disabled.
> In short, local_db_save() and local_db_restore() pair must be run
> on the same CPU.
>=20
> To fix this, move local_db_save() and local_db_restore() inside
> exc_machine_check_user() and exc_machine_check_kernel(). In
> exc_machine_check_user(), DR7 is saved and restored strictly around
> do_machine_check() to avoid schedule() during migration. In
> exc_machine_check_kernel(), local_db_save() is called at the entry point
> to prevent early memory accesses from triggering nested #DB exceptions,
> and restored on all exits.
>=20
> Fixes: cd840e424f27 ("x86/entry, mce: Disallow #DB during #MC")
> Assisted-by: Antigravity:gemini-3.8-flash
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178875277830.93794.=
14247844688761142429.stgit@devnote2?part=3D1

