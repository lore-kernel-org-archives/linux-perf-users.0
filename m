Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F6F3E1204
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 07:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148166; cv=none; b=TCNDV/M11YqN5oWikrbj19nkQhCOLoDJ/57eWhLa462YjxrSDauXfMgxB4k4ZxQc0A5W46r4Hg38Rvt44iNOMhBuxeBUO+Pk92aSYgT8N4vc44++f3bFZnh/N5yY4rHojrxGbnkfMdrNVLff0reEcwVcPBMb0noTmKUJpew0p5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148166; c=relaxed/simple;
	bh=4e/30Ix9wR3XifsGK20qzklj6I0BnJYQ+uUZRTfD7RE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ArKzbFvsUY4aMamsoNBdyDjTE7K4raHnEdtym0sK+HQDJODWVEfjeVAW+xHyY7C4Csi/mP2Qg7gFsRLi6pvrWojvdr7uxeTlrLyzKuhUHtWAuY0YrEo9HLMtN6S7V3WgtXoQbD908MGQUsL6fhf/N6DOplSIsVcqZRsHHNp9Vh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czNy0O4G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czNy0O4G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6AA1F00893;
	Wed, 23 Sep 2026 07:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790148165;
	bh=qxjYq8g8btDGHKakyRHn/a/tg9Wfg4um78oHWslbJEM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=czNy0O4GepgznoVCHXQCSjTCSPfZKtSNV8I5UlYGf2s8oKWT9Zw3adwnbmYvuxWkO
	 E20XILIUP6W5u9hCbJyjZC/zn3StxXnlbM62P4PcI1LtZMQwtgn04Czuqbm0VFwwP7
	 K51WaWHJVlM+ebBwYkvh0HliT2PF0xcpXeps/rYqGgmxX/clH7RZIcs6ltIfIQATht
	 m80dt7AdlyoPCtS4PGeFKucVre058HjjQZoJFseH6JQhtFJ/M04mwmpMgCEvf7L3NB
	 tp1d0y6CT+zENo+Q2zflE7bw9ggB9iPMHMwXru27AzpwFnlGYoogKBIE8P0HhJvCKc
	 wUkvoRfnp+72A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/23] perf trace: Do not set unaugmented BPF program
 on sys_exit map
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <42dc47785bdb78054500591b193a1cb653ef39b7.1790145937.git.irogers@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <42dc47785bdb78054500591b193a1cb653ef39b7.1790145937.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 07:22:44 +0000
Message-Id: <20260923072245.3C6AA1F00893@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790145937.gi=
t.irogers@google.com?part=3D11

