Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BA53F210A;
	Tue, 22 Sep 2026 04:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790052063; cv=none; b=kJ+X5Wh/tSsnlzAwPnBlin/XOoJ8xp1/W00bGFGtbehHuFiKcBfMyHxJRXtdNIwynIUlP7lD8Q5vTR7gRNIfI8R0RpUmfMfoEmPm+/c8CDp0Q9xMeQ9yH7cYkAAJ3dxO1q079s4EoxgIGI7u4Re6HYbG2HmoG1AVYRCE1Y6W32o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790052063; c=relaxed/simple;
	bh=FmSGy+0t6SpBtbwhxi4WObOVQEIufJN7LiEfHQuC3MU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a/bsKv2D8d6JGyfxT57TKdCwrD25+mgNTrSbiSfyLxTOSQeGCh1uFtxoSYtnKY8yZ3lzHfZsUtz0DiwRHyu0o3PKjSmoR6OnSbIQFdpMc5k4QaoTDs/vpGvA9Q2oewkoqHQYEt5ZuXQNC3c1Tj35lYbGgxYx3fs2OYPR8F3iaT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ct6Hr7//; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ct6Hr7//"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA051F000FF;
	Tue, 22 Sep 2026 04:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790052060;
	bh=FmSGy+0t6SpBtbwhxi4WObOVQEIufJN7LiEfHQuC3MU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ct6Hr7//JcvUK9/cACmIlFAtNJOGdkesFisS2F29uZYK+c3xasbRB2IX1dkpdOQSH
	 /NPtidPVRypoIY6AlRaqc7932QL36ZDlm974Ep1lMyxE66zBTZ/o0IwI+wK9RJ6ZVW
	 pA4ECQ97/8hJRjh/Ge7YeKFaISFvQ3S4T55f5PVgriHUlfgYDLc1Vo35zUju5uzeec
	 wCxijsxVyeVZKXhMJQ8bK8GHYN4Xc2AzSRI7kQxZZtCAOfaDiz2ti/3CTE5Uro1uZK
	 z9GSX5k/ill8D6mJoYtMc3cScK3PigFnfaKr5rBdWAjPYUDMBm5OEa5O8A9svs8XuD
	 /cUYGtKL/ZTlw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 01/13] x86/mce: Fix hardware debug register
 corruption on task migration
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <179005109564.388919.3937970081044095776.stgit@devnote2>
References: <179005108298.388919.4535333252892590932.stgit@devnote2>
 <179005109564.388919.3937970081044095776.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 04:40:59 +0000
Message-Id: <20260922044100.6CA051F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179005108298.388919=
.4535333252892590932.stgit@devnote2?part=3D1

