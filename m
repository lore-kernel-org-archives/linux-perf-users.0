Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E414B4892
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 14:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792333695; cv=none; b=gRFBX2X8d5cKeJXw0sSnaFr1RzQqHmV6EpmcliKCPDj5Uvr07yn6Nf46p9KkbXkzmuWUaMToj6UKIm9DxHGRn30oB3lAsCS55bm6Pf+BCzoiCmnvOU/iKT4lSIxqqVg5aBo7Ug6MW6itdzOCHPzxPmoDNGnrUib6qxsW4914ItY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792333695; c=relaxed/simple;
	bh=SsoCrHczbxX3lzPswP07A9lwBKBXb0e4L4D6C6FbZb8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=VzQItRkITXRFx0hcwqeD7e5eCEO//QeLcLKCEVqwE4ZE91/pq3D7WUVeFJX3RZxe8oMIXgn0V6gFrbAHYQK7p69hZausz+8fV2MeMSG37xSgJRxo7fVFy6hDacesK/VMWpw3Aatitsvxsy+phSch5t9eaomB86y745mOT+7fUQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSLVhVHC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSLVhVHC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98DE61F000C5;
	Sun, 18 Oct 2026 14:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792333693;
	bh=SsoCrHczbxX3lzPswP07A9lwBKBXb0e4L4D6C6FbZb8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SSLVhVHCMWcOYwVeoP8koN6u8BWyvSqDAbRJFwaF0RwK2FFPYaQX2GP1u5qmp70q3
	 KKgHpkZfNguJ+NTjNKYFCZUWbcqGbHknjJquDSnNYVrXF6PZvwO2v98NUspqwg/m19
	 1cxJVmubmOfZLAguKTG9MeqwjgWCy8gFgWBlKBJQuL6Trm5GXPqAZdzB1J+Tr3rOyK
	 ts6VFyeya3CE/QU1a4gkohahuaV4HJE8AoFuvEZkk/GAXM9xMcMnmLN+a8UdE+pI78
	 mxcQTo9NUJNKhNstCwI2BDqSSpUCXMb7EzZ8O92kF30gAiX5fJPCoNndFg8rugdnIv
	 D9e6rMMJGP3LA==
Message-ID: <sashiko-outbox-176198@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/5] alpha: fix stale user_stack_pointer()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261018-alpha-perf-regs-v3-v3-1-52be85332c57@gmail.com>
References: <20261018-alpha-perf-regs-v3-v3-0-52be85332c57@gmail.com>
 <20261018-alpha-perf-regs-v3-v3-1-52be85332c57@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 14:28:13 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> PALcode keeps the user stack pointer in the PCB, not the trap frame, so
> pt_regs->usp is only valid where entry code stores it: entSys,
> do_entArith() and do_entIF(). Interrupts, page faults and unaligned
> traps leave it stale, and ptrace and /proc/<pid>/syscall read it
> through user_stack_pointer().
>=20
> A user-mode pt_regs is at the top of its task's stack, so find the
> thread_info from it and use rdusp() for current or pcb.usp otherwise,
> as KSTK_ESP() and the regset code already do.
>=20
> Fixes: 8a2857bc2b30 ("alpha: enable regset-based ptrace and core dumps")
> Assisted-by: Claude:claude-opus-5-5
> Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
> Tested-by: Magnus Lindholm <linmag7@gmail.com>
> Acked-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018-alpha-perf=
-regs-v3-v3-0-52be85332c57@gmail.com?part=3D1

