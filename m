Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885C93ACA41
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 14:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789742014; cv=none; b=HIbmjdfZkDbS1kIr1escU/b5TjidUtSeeZ6KPMr9bxiTAsuywZ7sLW8EgH2uzytv/WLLw07QFD4M34z4yLDj6WaEpDt0DLqigt+GFGSwNZ3iwASt5rUP4j2gFNQMPl5Qr0/pwQUFngCd6bYsMRD+VUkamdKyGZMnxKXMjz0m/Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789742014; c=relaxed/simple;
	bh=FBqJyZjPiWmyVEh+CtuN/MCWKw7XY+RuI0W5MaMrIhc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uMSZ8q37Gyk5yqxktObsPvj4Y3/4HHLWa+OWZBEotP3s5eIED397AdMilxupcw5YUls8KugrDQSQjpX+tzTcYp0o/yCiG6uXY7F3xMqj2d+Z2Ia4uGCPjCpBSzjTpCtCG8+xV7SO1ixgWfWPMl1nCIKV0J8aDRMv5Xq2Z7XWtew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DViGx6ur; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DViGx6ur"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042701F000FF;
	Fri, 18 Sep 2026 14:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789742013;
	bh=zLLntnCC94xkJnZ4YDJUVg59wgPaDni6RsqAdsaQghU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DViGx6urtPMTpu88tdTNVWHvu+5ye/BSlTun+kIoHdb+mNDIhMOBhm6T616YSKoKh
	 B3YgxcKV8SVBH9qJkenRys6qKVZtELTLPJqhtaVSliR9P8B4mpMHNdwJyFGML4Oa3U
	 f0siZjoV7eFVl0d1E5KQOXNeYcSL14E/7ZmQ0CBOD8Z16ExjtTHwWXn0YZbULzPuMn
	 rzTMUF75+mndDVzzvYb2vsfLWiCUlIGOv9QA5+nZK+8GucN5RHtKkQ2zYIRDJjuqDj
	 wRTqR3mwx/ZNqIEjLCM3VviqeySvHPnB5B4f6zx1Cy6ctl/EFVEVLIiG07mcaJBzM5
	 BYnUQottIE9jg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/16] perf trace: Do not set unaugmented BPF program
 on sys_exit map
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260918140659.2501976-6-irogers@google.com>
References: <cover.1789662556.git.irogers@google.com>
 <20260918140659.2501976-1-irogers@google.com>
 <20260918140659.2501976-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 14:33:32 +0000
Message-Id: <20260918143333.042701F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918140659.2501=
976-1-irogers@google.com?part=3D5

