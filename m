Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793655962;
	b=PAMVwNroFn7PtgVdR6rHLUwyHdO3SPpNSdCOeo5lTh7aoWL24/Nsp+qldkVAw0F/nQz0
	 2TaJ8I/20m2Rcyte8rLSJ0lb9I1bJLQbCv/jqpqgXInccH0Ho2VRxfunBM5Cnp+XwD6lh
	 /QQZRMlotnUhnXDIQAWsTUw0pVUt+lDLze9gBS+xCI3aTFnNMnQBT/7St/HSsQMIZEiR8
	 I4OO/4zLHXdaFJa6IaelvEtNIX7yFA8eMtHvijh9cAaS50w/lwScciMhK8G/xZkQqUOi8
	 bIKPFFZA4ZtfAPJIj94ZaPsm/nDlq6gpY8uRBQ9aTA2Gt6LCcyYPQhLMlr5E/k0C99g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793655962;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wQ/RgBMrbGQzeNhJ4wNlsFAL/j4jnOjM1EZ/fE5mVVE=;
	b=fj2enu3x4Vl9ctUrbFjW/OtLp7Qmp6YYpCxRChQQnziU8QNYDnj1+Q8q3PXqILzNNedb
	 3T/wA8Tot7u3ZLTiaeuLBO3by3ewVqDinRR+Gp8ScSnEJ3NqdFXWCo8rE4WRuuTQi3j0K
	 U3Ezff/ELxY1etOea3vWCKTvRdJjRYWFTn/+Ppo24qFbatFK/ZOKbfq7kVtotK0H4vxro
	 0pLMuKTvlV0ucJgpruQUTCqHMP9Fbsg62hk4kYPhjIKkIy+F50rfM1cgK1/xEz2OQioy3
	 VlDqOahpXM9NQW+QsCpUe6fX/AbYtmpAX39peBVpS5FovjcJQbR4m9GVKJh2C1RbwcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LGrqUDSw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FEA606A327
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 21:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LGrqUDSw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99A61F00A16;
	Mon,  2 Nov 2026 21:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793655962;
	bh=wQ/RgBMrbGQzeNhJ4wNlsFAL/j4jnOjM1EZ/fE5mVVE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LGrqUDSwQgMVn8uuWLxjY9YfUCkaQh4FRFhKOFFlczB4ld5JX20g0fvX27os3wLDj
	 IoiE9K5BWA/XyI7/bQ+Senp2b8piMfGpEU6YZcQ7ATuhNG1cg6piXpvwvWRr3zVATO
	 378Q3U4RdDHTEtoxK/6J+64wt+8i4//qXTAwTx6fsQfkLZ69F2yEZ6A/N1Pq2x4vNU
	 KL0EgTceKNwbAIvR7JD8lKtx9Uscm5wnMH/ZNPU4XaxzyS/dFuhyaKf/bLVdSafEWz
	 FvyzyS6Kptxp+uFC7wosn+8U9SLFmYAMlSMKsyTLvR4V64vsts9emDsUGUe7NfoqKd
	 Jgma8nCB6GEGA==
Message-ID: <sashiko-outbox-194231@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v13 03/10] perf ftrace: Support
 filtering return address comments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102214054.911298-4-atomlin@atomlin.com>
References: <20261102214054.911298-1-atomlin@atomlin.com>
 <20261102214054.911298-4-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 21:46:01 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102214054.9112=
98-1-atomlin@atomlin.com?part=3D3

