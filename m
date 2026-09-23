Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DB747012D
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790154848; cv=none; b=Mi1N/+LtYcBOpZZD5cXj8vvGwkxOrgmVOJim3+cUedIwEqC+bDY8Hy1jqkJsnxQhY9scTof+hzRBW5JJvVGFHf7WWg0/8gaOxWsWW3xpJOrZkLYMx1GWB+RscJzeL5TOR5D/xzts9IlW8FM1zL2mhTE052bB5tMtwtyAW4OszDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790154848; c=relaxed/simple;
	bh=jCM+NsaiFC8DYzZWX5wARc4nw2uioaC4o0IFp1a/9EU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gt9pr51yUiTP4aFWnzHidYxr91+hCWjeFVxCCxVbx19TJlmUX3BOUoTwUZCddOQJBmi2dYSf7arHLsJ07rdnPMf+PMB9EwIcU9mcp1jJhwM7kMiaLomhH80QI/vUHqBnZIdwTmdDI29NVghI94v40ZiciQWxhBRmHkx3+JrBwUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aq9FsqzK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aq9FsqzK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7FD81F00893;
	Wed, 23 Sep 2026 09:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790154846;
	bh=jCM+NsaiFC8DYzZWX5wARc4nw2uioaC4o0IFp1a/9EU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Aq9FsqzKd1nARFsiP+Mp63LvA7un9XD4FDuz9l8EZTnmEFR75PEnvLz8FjBmryyNf
	 6OegQTLNMgn1WqAD4333NXzg8IqMX0iwNTrheFcFlkMMWA5o9ONzn9gaknfk6cziRn
	 yj5uYNdQj/9QuZaiJlEYh2ZWeq+JMEN+g5iccVsghAHQNyq8trKeA0nq52NmB9n1Um
	 QbPMNcqSPLH4gAVnffSkQ4rudaLEGxIhN7I86xb05XEDCs1ZhEEE8wlM71Tfz6XsSJ
	 WC6gZTIhI0k7hlMUQsFLvveEaS90LFzv7sCM1QNtopIQES21XpIkQ09gFNmb07R8Iw
	 VWNkDCK4SPtww==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 2/3] sparc64: Support PERF_SAMPLE_REGS_USER and
 PERF_SAMPLE_STACK_USER
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stian Halseth" <stian@itx.no>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923090429.2026529-3-stian@itx.no>
References: <20260923090429.2026529-1-stian@itx.no>
 <20260923090429.2026529-3-stian@itx.no>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 09:14:06 +0000
Message-Id: <20260923091406.C7FD81F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Select HAVE_PERF_REGS and HAVE_PERF_USER_STACK_DUMP and add the
> perf_regs implementation. The exposed registers mirror struct pt_regs:
> %g1-%g7, %o0-%o7 (named from the user's point of view; pt_regs calls
> them UREG_I*), %tstate, NPC and %y, with the PC in the slot of %g0, as
> mips and loongarch do for their hardwired-zero register. Trap entry
> does not save %g0, so its pt_regs slot holds stale stack contents for
> a trap taken in the kernel and must not be exposed.
>=20
> %o6 is reported as held in the register, i.e. with the 2047 stack bias
> for a 64-bit stack, the same as ptrace and user_stack_pointer(). The
> stack dump starts at the stack's actual address instead, %o6 + 2047
> when test_thread_64bit_stack() says so, so that it begins at the
> sampled frame; the uapi header documents this for consumers.
>=20
> User-mode values of a 32-bit task are truncated to 32 bits as
> genregs32_get() does, since the hardware does not zero-extend them.
> Kernel-mode registers, as seen by PERF_SAMPLE_REGS_INTR, are left
> alone.
>=20
> perf_arch_prepare_ustack() flushes the user register windows so the
> sampled window's %l and %i registers are in the dumped stack, where a
> DWARF unwinder needs them: the CFI of a function after `save` defines
> the CFA in terms of %i6.
>=20
> This makes perf record --call-graph dwarf and eu-stackprof usable on
> sparc64.
>=20
> Signed-off-by: Stian Halseth <stian@itx.no>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923090429.2026=
529-1-stian@itx.no?part=3D2

