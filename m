Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550553;
	b=kIZRjvKm3mIDGhExQEb1Y1NZx1vRUOynX+V9ZbFdJo+UdqLY9+mhM7ZB5hd3BzeDIsNc
	 f0Z497Rx/Ipir59bcaVWYU/R/NtFHR8m0UEWkGjEAv5fu88D9mUPIz+rERXyLYE3u4Rxf
	 ERuOAPqCjAUEvcOzj4aXdWNnzwbFMBtKv2cw1pC7mZX/S1hw7+eZASz90y7KmKG3E7opZ
	 Dg2Ys0Q0cKl/+Lofq9vfkOnuvyqLAMPG97CadLbpbRWHmBtq5Y/y1AEn7IhnrcQKns2FX
	 NbL7ld+21DtNtdyItUoWSP/qMRDenfozc6MfQ8N3R8OfNX4R9LTy9rdqxOo8hDslTlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550553;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MrBXikXoDsgqnrwH3iCkGXjYQkI4gJExlYUUvjkuDv8=;
	b=vG5K20WAM+kwSBkKwfNHKh8rwRgdju3JsMmC5dqR56mO8GoFe1r2uSUmoyKs9fTEhESd
	 +SWqPLzOAvw5/nLDvubLc4U6noN5LpId5s720YjLM7JNrMgHJVg0d7ywvG/3PmfHelFnZ
	 4JL/g4MyAIcfG+nwC8O1UMPBn18JXcPjB3VBDWSWh6kP0firRbPm/dAzLCNlhTVflUUoN
	 6TTUOILsyngKNZmxs+Ag83N9/3Gw1DwlpCdPMrEyFN8UHSubIVntoImsP5wpMm1rhd8bl
	 ZNB4hwGjDX5HarkU5LmD7ZieQMOlOjFBysLgSamrBC0O+DLE9mXxF2MoP1swmDmTtMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LEBxmszW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3326D606A319
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 02:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LEBxmszW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C7E1F000C9;
	Wed, 21 Oct 2026 02:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792550552;
	bh=MrBXikXoDsgqnrwH3iCkGXjYQkI4gJExlYUUvjkuDv8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LEBxmszWbJmeRJK6oWH+O+R84uiAnIMq68FxxXld4Yqb+UbylecJF7xSeWXQ44rfa
	 SZBBL+nGgxiDIJ5BLAtStYZI2DQnkvBfoS/oRspyIB61QfyDquopxVHROVoNqgzHEj
	 Z93zMWPZj6DABayV+i4PlbrV4OcXDpsZc16bbkF7SyBR7DbJplKf7+3VEbRSvjwmiw
	 FBaO3O05VP7UKsTBs5jP6ialgsljztlleQF+jnnAL5IYr6W3Pk4MdiWtV7kgjodv18
	 iTvoOQeCf+lrd6x8D+tgy+pwky5VdI30tJg3DhQh1DmXZB+xL2UJ1jrAJ3UBMVdeNu
	 O9UJX13CU6kMQ==
Message-ID: <sashiko-outbox-179710@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v9 4/6] perf ftrace: Support display of
 inlined functions in function graph tracer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021023337.809936-5-atomlin@atomlin.com>
References: <20261021023337.809936-1-atomlin@atomlin.com>
 <20261021023337.809936-5-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 02:42:32 +0000
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
>         toggles, bare closing braces handling, task context-switch
>         isolation and migration, and stack saturation/overflow recovery.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021023337.8099=
36-1-atomlin@atomlin.com?part=3D4

