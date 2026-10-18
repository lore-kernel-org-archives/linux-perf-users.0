Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BD3397935
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 14:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792334176; cv=none; b=OyRKHtE2P19w+TCkEpLfYOLWGBp5qmzRQYmKmeIWhNcEHQQU0xNwDuQJdlHoIUKdVdhqQ6huIMzJcMznf9zUwcAWQrlzxIOLRnJEbXzt+645LYcJ3a7I0LrKXqC+5BN6xnnWO6HpIu/fvqMpNdgHFABSYgYUjTiUjk/Z9xhntbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792334176; c=relaxed/simple;
	bh=fUAYll5gdguY3OwgaTGy2Q4lTTAI4gJB2GOYkJY/4XA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=PGbhMS/1ybXhy2/iOItSKbdSSkXoavoRnn560q/wSDCIEdL2j9KHGbluEYPDbBWo+BEzFcycMRTUYxWKcjm7bS3jeKzL9/oyhHA4iJmCVb2fj4hsnLzJoknpcBKI6QnkkoSO5RISww1lCkgFe8a4kGMNFF4SUhfYD7XLeNwoTM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elG4dPfZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elG4dPfZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87A71F000C4;
	Sun, 18 Oct 2026 14:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792334174;
	bh=fUAYll5gdguY3OwgaTGy2Q4lTTAI4gJB2GOYkJY/4XA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=elG4dPfZHOMIaOIYCmo4qfjg7VHMWl/X9nX/s2lhTwkwpTcEfF/gnvlTSyb1f2WRQ
	 ipL0wEgKAwo4mGsUn+Jm39zXxYunPiX3uZ5kfoVHP5wrL/vsfWj1GdImq5Byp0f2A7
	 xciZ5AM2hZ7cNh5eC5qVVY/T6OPPibonEIrqSEjGK0aWKKl+eVRaWeS8RfSNk2L05S
	 U9MRXFVzRakans0u6ZYC13qtrcft6TCApMaU9EHsUZKLvi/JJmge8IAOdcuzxDTxbm
	 ZI/z45gjOEOoGmDSWUFVSAUnjoI96YieITcHYdBA4UqJ4Cm+7YwDZ4CRh+vjjl/TgU
	 ihT9wbTJIX1XA==
Message-ID: <sashiko-outbox-176205@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/5] alpha: add HAVE_PERF_REGS and
 HAVE_PERF_USER_STACK_DUMP support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261018-alpha-perf-regs-v3-v3-4-52be85332c57@gmail.com>
References: <20261018-alpha-perf-regs-v3-v3-0-52be85332c57@gmail.com>
 <20261018-alpha-perf-regs-v3-v3-4-52be85332c57@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 14:36:14 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Let perf sample registers and dump the user stack, which is what the
> perf tool needs for --call-graph dwarf.
>=20
> The register indices follow the hardware numbering, so r0-r30 map
> directly to DWARF register numbers, with pc after them. r9-r15
> are callee-saved and live in switch_stack rather than pt_regs, so they
> cannot be sampled. Without r15 an unwinder cannot recover the CFA of a
> first frame that uses $15 as its frame pointer.
>=20
> sp is not in pt_regs either: for user frames it comes from
> user_stack_pointer(), and for kernel frames (PERF_SAMPLE_REGS_INTR) it
> is the end of the trap frame, as in stacktrace.c.
>=20
> Software events such as context switches and tracepoints hand perf a
> per-CPU pt_regs filled in by perf_fetch_caller_regs() instead of a
> trap frame. It is not on the stack and has no room for sp, so report
> sp as 0 there rather than the address of the per-CPU buffer.
>=20
> Assisted-by: Claude:claude-opus-5-5
> Acked-by: Ian Rogers <irogers@google.com>
> Tested-by: Magnus Lindholm <linmag7@gmail.com>
> Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018-alpha-perf=
-regs-v3-v3-0-52be85332c57@gmail.com?part=3D4

