Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA3D3783CC
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 16:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663838; cv=none; b=kpLyl1wjcf9vqc1FC4fkvEfYkE7WkTtbUmMeBOOOMeu8FgkAvv0JrEc01urRe3GHgZp1vdk1On0tL8+Lbpm1twFFhB7h4XFnObgJaxKywTpQDwKtYPMFaus7X7X0buhsDAOiIc8TphRB/iOzcB7cFOvPiOqko0zKDWuUYblDl1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663838; c=relaxed/simple;
	bh=grqvOJo9B9l2tZvb/QYdjcgeBYULd0Q3N4cSeEHxG0E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ls+X02rw/UxAPmv1Ei951aHwJGOvvQ17SeiNfxCZXgoavgXWDWhvbipnV9vdiYltW2ZI7TYkkxj/UmyVlO6IQwXzN9d/BJtwn+MZpZDGyvgafXxvHiK8wcqFm2++7d94owzGo53DEGqHd16Dz6n92TwLMldLBB6Q7uqnQm5/I5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgRWlCWw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgRWlCWw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E561F000FF;
	Thu, 17 Sep 2026 16:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789663836;
	bh=qlZ1fwNwEJKJQV/ttHvqNcmEWszqM5bLkZz9AdoMP5Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JgRWlCWwoswFxryRojDUMhIwvKjYL+KBnWL3AxzCnI1Qx4vLyyWsZRq+UAvtseVZx
	 1z+DETD5Ypa5VXtatHaMxkYCyq6QrdVmCY/l8Y5dWm+nmpmCIov47USucjxYCPedgJ
	 zCuqDtxR/ADgC8IAp0RYBBGTqVd8i8y0nPr1i/eo/XPQsE0IPd3SC4Dt+EVom8Go7b
	 juPFECOISGnftPN7hMyRMMzlDhT2y33I+bK4ljXoyFbQ7ArS2fk1AKxhxSYKiALMXI
	 pBC1mk/1WlbNSfdNkX5qP2sPx0TYxCrqmfP0JbqQHsFl7Henw+fVsZX5TMOSHqHRKm
	 ZF0eSvjLDsKEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/14] perf trace: Skip internal tracepoint fields in
 formatting and beauty map
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <5d3662431a859ffe80de604909f57a460eb8d51b.1789662556.git.irogers@google.com>
References: <cover.1789662556.git.irogers@google.com>
 <5d3662431a859ffe80de604909f57a460eb8d51b.1789662556.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 16:50:36 +0000
Message-Id: <20260917165036.C3E561F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Linux 6.19+ added __data_loc char[] internal fields for string
> arguments in syscalls:sys_enter_<name> tracepoints (e.g.,
> __data_loc_oldname in sys_enter_renameat2). While is_internal_field()
> was added to detect them, several places did not properly account for
> them:
>=20
> 1. In syscall_arg_fmt__init_array(), when an internal field was
>    skipped, the arg pointer was still incremented, causing the
>    subsequent argument formatters to be mismatched.
> 2. In syscall__scnprintf_args(), internal fields were not skipped,
>    causing spurious trailing arguments like ", 0, 16" to be formatted
>    and printed.
> 3. In trace__bpf_sys_enter_beauty_map(), internal fields were not
>    skipped, offsetting beauty array argument indices and breaking string
>    and buffer augmentation.
> [ ... ]
> __augmented_syscalls__ bpf-output evsel, and size arg_fmt after dropping
> the syscall number field.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789662556.gi=
t.irogers@google.com?part=3D3

