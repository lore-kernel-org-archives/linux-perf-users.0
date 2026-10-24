Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792878218;
	b=TcFNTJhpJbpvag1yBbr5HA7aueWZ0LyUZVQfVk8HIkPpnt+kn67tyRiEuoqr/e5OmKPJ
	 Pk5EIZi0/F1CH+76T4RLrs75TE3mXi4eluUky5trVLhA7Dr01LWHg9r/wIW2O9U5gDIqH
	 IpH1Jy8wfFYwxcLxDu50xOcGenLA/PpGR+BPNuPqZjeHbGLrh82KSGJxH4k8vOSaYUDt7
	 eByw9P05B1Mcw+X/GSagyxO1epESF6qPvE3+cH58XSyP3GMQsUPu4kn37FI1xdsO5LFgF
	 mdeAbnbzTt/kO15vlj1w52QRon6GTMcrcb2OMdX+X21ZmkYLcXvBukUeMbg+/Dn8h3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792878218;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3vNy5lDyOA+3yUWv9aoF6k9tgLVtBvniDXua5LXf9kg=;
	b=y8iu3AyVjuILW3aATPmCjCBErgV1zohgInv3R5vzutw+CAn1+uxN5Asl1My8D0jTRPiD
	 RZtktKMBTQQEhQa6ScrkFraJk4tOhwdm3OGYN/cubQwNVCuJ/xJbdE+758B+uaZcsZnVQ
	 iQ/FRmGEDd2Rc2KsFjjl3PlzVWNCNiJBGUc7TwXgWw72dRdEdDvYxdW3O1trfSoVLvzXL
	 vkWKXDsd4T0L4NI/n4RYA0BLYtXaRDHcSOcSK2BZgRCG03dFcH3qLp9Z7RWUM6/2HyzC5
	 zL25a9cTDq7LFOjr8BObHVPNWRHpCWcnlceubvFvtwAtyG2igDT5V6wcLBmvwWPeqaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RYWzdbi7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0526E606A330
	for <linux-perf-users@vger.kernel.org>; Sat, 24 Oct 2026 21:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RYWzdbi7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B67B1F031E2;
	Sat, 24 Oct 2026 21:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792878217;
	bh=3vNy5lDyOA+3yUWv9aoF6k9tgLVtBvniDXua5LXf9kg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RYWzdbi7zSZjpEaPIl3HNGIZ0EVUDgLie/r6bBahdLXr5Pcv3yxv4odRHZFd4o6Jy
	 EFoIdOVeuVuEBmhbanrzQcc77L6NLWNJw6wpiAemsY/fGdB74xjtS7WeP4IM2QZCmS
	 nMS/3i4axnIgfPTz+HeqqiXnReeQcpY+iEAAcb8vJpq4ALmRdR19rhV0ETPzqS8BlP
	 yLRM96x9QHdXX+/6G/a4ZnhcVyEqb2/6QhazZ13LvEVx/OCkXoXbmIqfScFIMyr3eI
	 yvf4TOAVuOd3hLPim/XpvkJJr+sKtOg61OSkNKGyWJIGpFiprLS4Mi7Jlc0WBB+ohy
	 C3b5CmF7q22pQ==
Message-ID: <sashiko-outbox-183898@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v10 08/10] perf test: Add test for
 ftrace inline and task stack tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261024212549.450634-9-atomlin@atomlin.com>
References: <20261024212549.450634-1-atomlin@atomlin.com>
 <20261024212549.450634-9-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 21:43:37 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add an automated unit test suite ("Ftrace inline processing") in
> tools/perf/tests/ftrace.c to validate the function graph call stack
> tracking and inlined function reconstruction implementation.
>=20
> The test suite verifies:
>=20
>     1.  DWARF inline symbol resolution
>=20
>         Uses vmlinux_path__find() to locate the kernel image, setting up
>         symbol resolution and validating activate_task inlining within
>         wake_up_new_task at offset 0x1d1.
>=20
>     2.  Inline presentation and return address filtering
>=20
>         Verifies that synthesised inlined entries and exits are
> [ ... ]
>         Verifies that dynamic call stack growth and depth recovery
>         operate cleanly under deep call stacks exceeding the initial
>         FTRACE_MAX_STACK capacity.
>=20
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024212549.4506=
34-1-atomlin@atomlin.com?part=3D8

