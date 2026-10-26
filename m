Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793007190;
	b=QN35iU8R+o7Yu1eUt+6MZO9sbNlotfnblOAczZhC7wO3IgwWtxUcSMHcIzzv4hU9hDXX
	 7NvDqw14VP3bD1E2mKmm5UsyLBZFE0uZEVJf2hze40ENtyWp/ca4F62v573XnNMBN+sgX
	 p5LTfZrEfRH+07i6rrocIgF1bjQUEgWeUIvBjiRLBYhubkMvmUJC4h/Bzsk/f0xktWaE2
	 wDoXARLX+6aN1eQqWStKUJDpfVfeZiqJaFJImS4r89GQo3SMPFyPJ8KgGDjHq70cNSlvs
	 aFsl3BzVwMexBXZ7J0eC/MKyx1qY/YI71bffsDdG5OTfYEq4IrQOAo4J1Lb8CwoeWdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007190;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8krTSySpKKyD8XkyHgDrFbCU39HXQPu/Ooc1cjIAZH4=;
	b=j5PPToK4lUXfI88i/7v1N9Pp5YntyVhiyIxBNByT9QHTYHRYCMdcPNQlYx0f+Tqr9dE1
	 /RxhIQLyeCKeYy5l6ozBwLJyRQpcCZkGFjq1tUTQ/JeV1+1Rwoh2hNPIyF4m9E2lwDC3H
	 dimMxGqVmkb6ExYjGiSAZ7R2ZHVXiDXecchFpOrD2feLEK4N6nIljX0E9pmwqiT6JsalX
	 +H6SbJBv/DvKa1Px65g0t3sEVLA9bIfUow0goQQP90ghIfJDoUIsPcdMCH0u+fPAB6+K/
	 JJLTDX6qTK0vSxMC8LLx4czywyZj7XpMKwGo+R9iJ50NanZwqwI30erW4ayhh4S9dpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SquZBbFd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60265606A31A
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 09:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SquZBbFd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C161F1F01825;
	Mon, 26 Oct 2026 09:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793007189;
	bh=8krTSySpKKyD8XkyHgDrFbCU39HXQPu/Ooc1cjIAZH4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SquZBbFdO4N36VWtrNVpB6+zyL0ebDyYFZcXgui2FLOA7WDiIMHPCxsvUbz+QpzLa
	 TyCjBuMUIV5CIovJbRBsT9Z+ZfsZBgEqskTKQ67J1glLhYPn1lZRnpPt9RZJ5A5emB
	 M2qLsNDdCxKHRqHMryIEsylq23PuPz2ecoDFJzboWSbwX4/3oM1BWMgjcwjwFQE2u1
	 0qXCziEeT3M+qpESIo9vS92lDeHlipual0gW4DKfDZtNadwVt1suPX5IFvE7PSmH7k
	 1iZGmYLg9cG2pXgwj3ciZ/EwMehMU/L1M+2eOlK/3mQa6PuIaVlW4JvzhvHZ/sAVNk
	 M6Nqxqbq1mTlg==
Message-ID: <sashiko-outbox-184800@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v12 03/10] perf ftrace: Support
 filtering return address comments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261026025735.546101-4-atomlin@atomlin.com>
References: <20261026025735.546101-1-atomlin@atomlin.com>
 <20261026025735.546101-4-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 09:33:09 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> When tracing with the Linux kernel's function graph tracer, enabling
> funcgraph-retaddr records the return address of each function entry as
> a comment in the trace stream (e.g. /* <-load_elf_phdrs+0x6c/0xb0 */).
> Whilst valuable for tracing execution origins, these trailing comments
> can add considerable visual clutter to the call graph, particularly
> when examining deeply nested call trees or when synthesising higher-level
> abstractions.
>=20
> Introduce support for filtering out return address comments from
> function graph trace output whenever return address display is not
> explicitly requested via --graph-opts retaddr.
>=20
> Key aspects of this implementation:
>=20
>     1.  Return address parsing and filtering
> [ ... ]
>         parsing and string filtering across all supported formats.
>=20
> Tested-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026025735.5461=
01-1-atomlin@atomlin.com?part=3D3

