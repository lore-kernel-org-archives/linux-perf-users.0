Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793657133;
	b=5RtvxgV/OcR9wGHVHre884914JC+pn+ziXS9YIKMPeYlSsl5anVJ57MyLs24GlPM7Q5/
	 uqaaLLlTNZXZZWpTbbn9H+/KDSHiq4+GxI1WVoFDAt8aYZ0H6qjzbJCmeFrDZshoeSgVg
	 dfX7ziSU9YlFS8CB65Ga8iVxl1IuX16OWUGIrDBgW3o0nRoQz18NSL4haJf9RGtqoJXHv
	 pZKE7GVF4dVBuFiLEZVoCBM79k/CuHDwbiY7za06POBMvq7BWSkgRArM53+x1ZsbvYDFd
	 csHcumxLfR5KIdE55Z9hqNQ3pabhYjmySCOhyFllgBj9hIxvEsxnJD5Qg4c1cGbISaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793657133;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DWcBy19PGjx81o9VY066jzf9d9CV7s7sdZqyPmwPjpE=;
	b=5hs9K0rlkDFN2AtY6rOF+vYFFhiY9qVVKPUSDLhb83X/vRsq+rqrM8nYgRcW/TrOG9Bc
	 MvwM0v7v7hFN7tO3ONZHyIlhD6prFuG+XyOa8MC5EY0ShAzfDZysQzn6x0v0xqupsDDKX
	 iLzzCUMK+hdfu5j38kBz2cwWI+uFf0Crs9qjG6KDBWPrp1RvSGouAj5EDv/SVS+E3i270
	 K8zVY488dB3ETjKNuqvj170lsWHlX8ZVrHJ5/6wh4llTCgR+KJnMMJUw6TIBebHiNQKb0
	 w4EZ/JcSyfaKmJmf2i+2My8xjwjBt1FuzC5Ry37RJJ6IYj033yOIkK1WvZ+ecoTW/gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CXSxY4TC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C38E606A33A
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 22:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CXSxY4TC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4CF71F00A1D;
	Mon,  2 Nov 2026 22:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793657132;
	bh=DWcBy19PGjx81o9VY066jzf9d9CV7s7sdZqyPmwPjpE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CXSxY4TC0CdHjDvgMaUDlYI1fqLOAc7nnDVW9VAJLsjo01ZOHDP3+qL5LnnWflGsv
	 gZdlLzw8IVmHdlL9S0VO0dD8+eshWuHq5Z47ktUmHfxZ0gluit8oBInpSmdHmwAh9n
	 SN60R/MW026c+6KmChqjQ80AGBSrdbFhgh39bHrV5XUNXr3Q4NDmGzBKaohBBleY+3
	 34QwK+9GU92KlRqZU1rbaoeHcMxc5ccE4B236QXSyHrZ4XWJfxG+COKAjliKLC6/C8
	 p9fdNgZtNlhWW0K3XMGcv6sSYROyaAX8ydvcoqDBekb1+exc5R3oNVdVKHLWwWevsc
	 vG22GMZT5Vd1g==
Message-ID: <sashiko-outbox-194247@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v13 06/10] perf ftrace: Support display
 of inlined functions in function graph tracer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102214054.911298-7-atomlin@atomlin.com>
References: <20261102214054.911298-1-atomlin@atomlin.com>
 <20261102214054.911298-7-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 22:05:32 +0000
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
>         tools/perf/Documentation/perf-ftrace.txt.
>=20
> Tested-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102214054.9112=
98-1-atomlin@atomlin.com?part=3D6

