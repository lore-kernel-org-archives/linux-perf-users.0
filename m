Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008551;
	b=gGFSHRpd/By0FT8EvAawj2T/bobS76A25mwNBBbidsyGY8CBwTDYj9cdXFVmPx83kdey
	 HhB2bY2U8kEJ6uxbyzoanzZtX19KVgTblKU23nw6Wk++LqfzSUX9KHOQzrGvlxrE5oVFE
	 itxy++fOXFj/06cbM9OyF/ijTxDg+eP4Lg5Nhc89tzdZhZzwQWKiBkdw+8ctzfDx+1HE7
	 05Y1SJ8BNXU0lJkm4TX3MqIUnF0A5wGIx7EpRT5zJcvizISuGzL55Wj2/9U7L8IAwBuxt
	 yoDYVts0O1qItmW54QECRenBOQsIgKSYwZYmMlp2054nIgX3xcwpKkT7kPrvlzf3tZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008551;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OTWWLbhgT14Gd5CCgSwNeUXl4VV8LfeJsYgSCULpmaE=;
	b=X8FXDSp3pO6HmuKC8ln4jNtRH3BV9z4YGPv65IL+mwuubZtKzxNL1cs0DSpuw9cgXTnq
	 sYScNuPFoal+sPz7zwW20bGUZUGpOGvQJTfIWMmUZFDOJSZdFyyAwAxN61bfqJsGhTY5H
	 v0RbZ4NLmS0vhKvASYmnPJfaJ9tiT+t3MslxDfVpjQ1uKkgq0LQRffArQRxn98BT6Vvot
	 nAHJX1Qh2mYnyh6Uy7xehlV9XfiDlzaCVc+Dq/JV1GPX7GBMsLsS9WcCOetULnJHFYgX0
	 8B8DEHkyP9latRt2PB31f8Xom+cLhaX7x5o+ScAj+bHzQuafyQx6Zlb92QwWl7+DWgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g+nUn9wl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF81606A31A
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 09:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g+nUn9wl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8531F01825;
	Mon, 26 Oct 2026 09:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793008551;
	bh=OTWWLbhgT14Gd5CCgSwNeUXl4VV8LfeJsYgSCULpmaE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g+nUn9wlPgULH74lbL13umW8NmUi7tQeFbIx5842+HJj+3BwSS0SiH2gPokAp0o7M
	 ZxBdxxFBhKEi332Aa/7UhniyP4u7OPjijJiIn8MS2sOp4xYq6HkF9zuLeOCQgEBb7n
	 uOnA4kDKx9vSJr9i0v7bPlXOwZjt9yv1/iH2jim/korAfugN15xmjueWZiGMCp/4n0
	 VguG5eVJZFrluk/DijQQCgBr9PuwT8Xd9gHK4REeQPbtSIyzYcHWaFUN7HDWilS/PL
	 clGE8RC0aQdmxO9NZPB7QaImWPF/rPyOIaD4GpRA5AF2VhFP/5ZUORycJI/v9qCPB5
	 T3WO/RD8ZJzQQ==
Message-ID: <sashiko-outbox-184852@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v12 06/10] perf ftrace: Support display
 of inlined functions in function graph tracer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261026025735.546101-7-atomlin@atomlin.com>
References: <20261026025735.546101-1-atomlin@atomlin.com>
 <20261026025735.546101-7-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 09:55:50 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026025735.5461=
01-1-atomlin@atomlin.com?part=3D6

