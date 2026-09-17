Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F05B442B39
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 06:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627912; cv=none; b=VKXJdeNzSwj5HQe3kY8QtYWyvLVDS3Id/5/HD5ObiFMyjAZk8aOas3K3JDvlHOF2xbGxLXMTrXYZMsYE3DWQC7pvw7oMllZ3DmqMPpZfAHgVRR4ZNXM3OtAVc+nvOIobULHxVMd+XZZXjzcIdjV7Hh7qOUIL6qKPWMA8bTXynKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627912; c=relaxed/simple;
	bh=bDhEtxLHmsNgWBRivuTVurk8JbS0nusC7zqGwK4IMgg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=laTOUamNvfWBvwyvlSQuFSflpySmky2tn6AXtqyL+/diouddK738LcDmAkyw39BivWgxiLKDnm1fuplLcKTR4TDwerEG4W5fx8zDccQzYt3mMzS3Eqyv9b1Tbp7jAM9dClZI/iIu4hUMG5R1anefzUFhA3mkvQ/NHvIusIX4J54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HiZOpkz/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiZOpkz/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB0D1F000FF;
	Thu, 17 Sep 2026 06:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789627910;
	bh=5yFQzHVUHp63sF9XamFkd6R/qClozyTqSNfpP9LI83Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HiZOpkz/hX3xXdHwTe6AHoaNUJTJJsnT1ercZuDbT0HdtOXnuy4EQXJTvI5uYSxcG
	 JKJEfjtHv6NWpPBLiBYLByf3jgq+KPChtNt6zpTqyoCSpGv90bjfBMsUswFgdzAjBb
	 ADgwbm5hoGE8Lv5ltri+ZZsNh3JCds/fEi9cYAzTSTTQkTmc08onI0fNbczy/cXVIW
	 MBHgP+/HpgQinHgGesYV4RU2Zgj+Zbbu4iY/GwcYu2pOy752GVfvEp4TaofuVCSMQJ
	 h7y6aJe//7HsBNICR05x5Ci4Hk5r/k2oYxDkaz6fZoHJ6Nnaz3YejHNjJs8/8QAgfh
	 UjMDNbWSMLLxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 03/13] perf trace: Do not set unaugmented BPF program
 on sys_exit map
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <fc961a7169e4c00c91cf543e5d505cc5deded5f6.1789626978.git.irogers@google.com>
References: <cover.1789626977.git.irogers@google.com>
 <fc961a7169e4c00c91cf543e5d505cc5deded5f6.1789626978.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 06:51:50 +0000
Message-Id: <20260917065150.8CB0D1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789626977.gi=
t.irogers@google.com?part=3D3

