Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E84649EC5E
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 21:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789767309; cv=none; b=hWqk38XrkLFDDzBviBuOXDqwzC0QQ9HYbLkB01morZ7KLs+dSXyN7/SzvXRx/JcmnEEb0xaaoZSRlbX/SwNiHlM+s8FmJdOKY0TmaM7BpXuAA5qwn4jiNrKZBNI+rIUBln7gvoivBrky17oXMeNrUKF+w+TDeGQr7AZX4/WYoTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789767309; c=relaxed/simple;
	bh=t0V4ayqde6mMvDnGDR/vCbypif1tErUeVBn0kAsFV+k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EnS6ZqVmgVubpIqrZ5qRLypIOejWEEYEzXdw42dfPdKYEm0PJZmSBQNRIy+6z+zSDkBSqQNVntPX6SKZ5zk9dr+sIFb6lQo6sePhWHBUt6AuvdL0zb61goQgTpRaAmiVeoLnuR7wk/3+zMdiQy6j8l3z/ahhrxRjRjgnJqddnC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9HUjPlm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9HUjPlm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9571F000FF;
	Fri, 18 Sep 2026 21:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789767308;
	bh=vS8Ze5bCybIK83xq+PWmll+y9h9/Ym5X8/og31y55NE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h9HUjPlmzcL/1Mp6L7V+lOxWTpxju2tivL7oa3osrnFcO0JEiBBZScmZSUwMcxgEz
	 onKoo/f9zT1PJgDaM44h9EI4PWvpAP5dV0kwQ4pXl7xWSM5GaZ0rm+7wKtb/HNMkni
	 7RwQgiGA8stHquXxIc7QB7H12JL1QWQ4OvpysXr8eKj+WORFElhHzp4fFrr1vhSrnT
	 G0Ksu/bIXSlkKJhb1TY3+AZq/ykUBDMbcJdnIO5OgLY/ibYP50zEDBmQotSdUn8qhM
	 F3iijx2jx3jEavFFKxPFdbf4688pRWCl3xY3KARhQI9uDI93dSLDVtemAb01dKZvR9
	 kC6/sTalPR/EA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/18] perf trace: Do not set unaugmented BPF program
 on sys_exit map
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260918211932.2966061-7-irogers@google.com>
References: <20260918140659.2501976-1-irogers@google.com>
 <20260918211932.2966061-1-irogers@google.com>
 <20260918211932.2966061-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 21:35:07 +0000
Message-Id: <20260918213507.DF9571F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> In trace__init_syscalls_bpf_prog_array_maps(), the BPF program array map
> for sys_exit (syscalls_sys_exit) was populated with the result of
> trace__bpf_prog_sys_exit_fd().
>=20
> When a syscall had no specific exit augmenter,
> trace__find_syscall_bpf_prog() fell back to unaugmented_prog
> (syscall_unaugmented). However, syscall_unaugmented is a sys_enter
> program that outputs enter arguments to __augmented_syscalls__.
>=20
> As a consequence, when an unaugmented syscall exited, sys_exit
> tail-called syscall_unaugmented, which interpreted the exit arguments as
> enter arguments and emitted a duplicate, corrupt sys_enter event into
> __augmented_syscalls__ right as the syscall completed.
>=20
> Fix this by:
> 1. Returning NULL from trace__find_syscall_bpf_prog() when looking up exit
>    augmenters and none is found.
> 2. Returning -1 from trace__bpf_prog_sys_exit_fd() when no exit program
>    is present.
> 3. Only updating map_exit_fd when prog_fd >=3D 0.
> 4. Clearing err =3D 0 when trace__bpf_sys_enter_beauty_map() returns
>    non-zero (indicating the syscall has no augmentable pointer arguments)
>    before continuing the loop, so a trailing run of such syscalls (e.g.
>    'perf trace -e close') does not leave err non-zero on return and abort
>    the session.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918211932.2966=
061-1-irogers@google.com?part=3D6

