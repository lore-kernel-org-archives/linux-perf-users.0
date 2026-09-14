Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9758748AE20;
	Mon, 14 Sep 2026 13:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789391066; cv=none; b=jC9XrRAraiZhEWZebhxAlB056RSo5XmEtcBK17PEkP3Mfsyg6lT5c3Eb8W6InONAGois+7Vjqe5LV75XfKV72mof10dEBnDx3kx7BoxzPoN7DkmhCurBHeUuSUHNIeS2CTf9MEz73d6JAE6qe6IwSkGlQH3Jj+3ft2x5XYAxFEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789391066; c=relaxed/simple;
	bh=tUkNwqqTR7wJugCXfdGmHHMsc9oAiptkyWIVqiLbkok=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eROTqZcWT9C5zpGbbgo6/zfJI8Vgde2MQkN14smEvZ3kfCmZg3xmaCy74foLrstnbw2TR4dul/kBq1WQ9cY34EgB37vSa3M4LOa0SiyCZdzzic35JnB6S2y5EasKWTm797mRhAikjU8mftd5cPpoRTuWLYDbQkHTJ6IVgvqWvPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0mcca+C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0mcca+C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B5D1F000FF;
	Mon, 14 Sep 2026 13:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789391065;
	bh=tUkNwqqTR7wJugCXfdGmHHMsc9oAiptkyWIVqiLbkok=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e0mcca+CSX52wcSJEpsLVEuWbzccXsuIiMfLwvdKS0GTUZ7tjzRMfS3fB6nftGqlG
	 IcZ9feL7hNeNuvFpK4PGiABgpFArImFh5kZj97RYpOhNKD+GBUEC87U1C7Ot31+83L
	 RQbqDI6FWCiehn4ezxeURPVGDUq82PW6uu3PVKKbZ0Cm6U7O/85baL+gKA0LgWm3F1
	 u+k8T3PxaHqRJit5Vg6eWrZLyieUDsG/IYv1m8WWN9Eu5VeB4CB6E8RmiuLNji69m6
	 t4sbQwWyLhTEleqqGOZCEehDQIamgLZW+mFi48Ll0V9QEd09yFp4CXOBnCK6ypetSE
	 k1EjMlIq1nZfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 01/13] x86/mce: Fix hardware debug register
 corruption on task migration
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <178939018815.94750.4070965922818659136.stgit@devnote2>
References: <178939017565.94750.9431053336761330458.stgit@devnote2>
 <178939018815.94750.4070965922818659136.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 13:04:24 +0000
Message-Id: <20260914130425.01B5D1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178939017565.94750.=
9431053336761330458.stgit@devnote2?part=3D1

