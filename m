Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792878556;
	b=NDToUTLWmrKVMkeLX0yDKTQ+bx6FS/pGiaE4BzqjK4X4ghZzdV7d3TsyK2D/NBb7LKMz
	 gAKpzmyu+eM+rRwzt+rZ+vqdY2ajt4Ipg3++dYVNLTXSOMnmAb+JuVT+4cfIV7bXMb83y
	 hy/4FwKqiO5wmB4o/dfTPStjk12zu8+ZS3k3XXrh21LaKxPfZcLQ1M2pGDI9AA9GyncDi
	 goCsefR31mvonxEXzO3R68yl1OsFQlqMlVXbkl/3wNjpI23Cd8trf4ABIec84oOOYk5ON
	 4HK/K1eKbjFRL10YyWhJwOmSKa4FZpPMOLkYeM8htw5QQnh34hSX9Jq+n/n6YYvyylQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792878556;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XIIESZxY1fVq0tkK8SFYCk5DSC9hDIR38W0IOX9ENcU=;
	b=dvvzyrRTMm7yAvd2HFatQT05P1Je/7Eq+z1z0fZS3j/+eZr1+oAQV6IcSNAtGlwqOANf
	 /ma0sHeT6CZCkQRJjizTujQ3Xdbwqu7k/ld3QVOXQI7wQjxdK0vPyx/zv2JXonWVQP3r6
	 bq0hVJ0RNJmV3vW208phGTQ5Q5J4RNWJd3Ynjj6SEf7uYr9JjjEyPsYORuRbL3gSZjbAU
	 Pvyo79Ea6/PEISjgaIVJjdjwBIuTImWCnHgIlj9C21L3LKuXEkdTv6E4E3NxgYw0H/NFj
	 1i8C1yspllz8UYuwkTUicCEh3H0LQpSsMXFaTJcYky7o3T+gB35LzYgkBNc8ucZuhIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CdgHz0Pj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D85606A31A
	for <linux-perf-users@vger.kernel.org>; Sat, 24 Oct 2026 21:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CdgHz0Pj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34E11F01825;
	Sat, 24 Oct 2026 21:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792878556;
	bh=XIIESZxY1fVq0tkK8SFYCk5DSC9hDIR38W0IOX9ENcU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CdgHz0Pj9FxqK0jY152Mt+iWY31PC0O3G1C3ST6LCKk8FBsjiwTjUTjw6N8KoqX4w
	 zuL8QGuz9IRsS5S9ERZL+DFhuAkQHJDFaiuviYeEl23FP3th1eCWuhOn7xDus+CYzJ
	 ZxiI5BGNIkyIzoxde4u5D7LY5MIHcSx2+n3TyBbUFzXm3P6HBWaAjVjn82PW5Iqc7E
	 XRNuLYW9+oJz5OZ5J5UzVFgAza9PCEUnqOhAzQyeRqhWMJnWcwuENZ0zmph/g5L6a6
	 jSFru6gPuCnx+ftyYgriPOjafmwbo7aLifSafpRO1rYjs/z6oah6Pz6lgXkoEb3SDy
	 tI9W1KPldQBlw==
Message-ID: <sashiko-outbox-183904@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v10 06/10] perf ftrace: Support display
 of inlined functions in function graph tracer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261024212549.450634-7-atomlin@atomlin.com>
References: <20261024212549.450634-1-atomlin@atomlin.com>
 <20261024212549.450634-7-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 21:49:15 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The Linux kernel's function graph tracer operates at the machine
> instruction level via compiler instrumentation
> (-fpatchable-function-entry), recording entry and return events for
> physical function calls. Consequently, functions inlined by the compiler
> are invisible in the resulting call graph, as no discrete call or return
> instructions are emitted for them. While technically expected, this
> omission frequently obscures the logical execution flow when analysing
> kernel subsystems heavily reliant upon inlining.
>=20
> Address this by introducing the --inline option to perf ftrace for the
> function_graph tracer.
>=20
> When the kernel is configured with CONFIG_FUNCTION_GRAPH_RETADDR=3Dy, the
> funcgraph-retaddr trace option records the caller's return address on
> each function entry, manifested in the trace stream as a comment
> [ ... ]
>         Add --inline and -k/--vmlinux options in
>         tools/perf/builtin-ftrace.c and document their usage in
>         tools/perf/Documentation/perf-ftrace.txt.
>=20
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024212549.4506=
34-1-atomlin@atomlin.com?part=3D6

