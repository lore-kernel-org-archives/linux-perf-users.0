Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978B53ACA48
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 06:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627922; cv=none; b=F3inkWYLagxMJEiC4PHb6VwJCvdyCuDgCsFsrmO9lO/Md4b8v4IqWBkbJQH/3eqV4Ly8zdM+EG/mfCtiNjhcU+3t4YFLVhjlhV4x2R75a/HKK0RLdQi4mQujDhA9rige3N+etjtlbOfEI2EZH2l5/COOWu+ubE0oFeBgCd8VQtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627922; c=relaxed/simple;
	bh=g85k1dUf9qv6kjVQ/O02Sk3o4Jrj0khQLVNXhSbPYU4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u8l08FiMArAoDrNZ/BeKf3LJGIvjJWMYQjg1MXl5MDVT9Fk/qZn9Z/uIhW5FXC3dzK9Kj+ErVmR0H+VqRe1JxHO5ruWINtxO38XiOp2Q9D0SSQ6J+mtZ8i43OuNpOyINSobD4n4Qe/WAadSmGDNgZuMgPMJJv11fqTIH/zzGOe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avCUWYvr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avCUWYvr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 542F21F000FF;
	Thu, 17 Sep 2026 06:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789627921;
	bh=g85k1dUf9qv6kjVQ/O02Sk3o4Jrj0khQLVNXhSbPYU4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=avCUWYvrHd5RiNzQMse2NLTTW+NEPIMthOTrV33+LVya0SM4ijKzVbAgBIreVpRs3
	 7/NxmSHtyaScvCdePjl7MBJC4ZeQA1Mo1xZX2ibjZ7iTQvuO1shtQ4Blb1sPbOLRXI
	 B2dXSEGsuTMrUjNhA4sHFP0rXKpq/ADuK68iJaim0t7PiHyA2d6vef+B+QeV7hkUAI
	 7+WqyDs6CR7XHc1a5t0iBRlZDBlxgRdw+CBMCZ29DCAHt/OgNBvwH+sOjKoXN9f6kN
	 oXXuFQRjTL52ZW9+rD2EYO2nCgwAVq6haORR2zRNxGegkaXc51jLx1geteCJLbRz2V
	 hLvuZqxMf0Vag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 11/13] perf test trace_btf_general: Drop
 --max-events=1 and make non-exclusive
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <2116386f185b31e0a0e197d37151d585ddb02019.1789626978.git.irogers@google.com>
References: <cover.1789626977.git.irogers@google.com>
 <2116386f185b31e0a0e197d37151d585ddb02019.1789626978.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 06:52:00 +0000
Message-Id: <20260917065201.542F21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> trace_btf_general.sh used `--max-events=3D1` with `perf trace` on
> commands such as `mv`, `echo`, and `sleep`. When background activity
> occurs or tests run in parallel, `perf trace` can capture an event
> from an unrelated process and exit prematurely before recording the
> target command's syscalls.
>=20
> Drop `--max-events=3D1` and let tracing run until the command completes,
> checking for the expected output with grep (matching trace_btf_enum.sh).
> Remove the (exclusive) tag so the test runs in parallel.
>=20
> Running perf trace in parallel is only safe now that the probe tests no
> longer name their probes "vfs_getname...": perf trace opens everything
> matching a hardcoded "probe:vfs_getname*" wildcard, which used to pin
> those probes and make their cleanup fail with -EBUSY.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789626977.gi=
t.irogers@google.com?part=3D11

