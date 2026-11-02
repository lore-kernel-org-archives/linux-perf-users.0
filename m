Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793656327;
	b=jil9VC/prWx0SgMP/maKbhIyFfHdOP+hJJzI0NJxoeQqOMJPJw490uVJ3Xafbj2+UIt8
	 EbYZ9G1SaN+9vr4eCO5/KKGOgXj4Vzx+V0OnKPUFMjtN/v0tWbMBxJ4SYDMz8nFHWF/l8
	 LwThPi+SEQ1jWwisPgtCCdyv/2vjDuALb2tHR8VT568J4Lq8rm/5yUqUJhGjRtXGfEb77
	 ITi6xkFWj5sLliIWYAhzrdnTXxuw6W7KQR/Vx73ZGARmMcnopzVEyduEgbujpCh9InTjs
	 hpYnSphPx4rOXYS+ZEZpwqjK6VghG9UmIoyaFNUMoV0MPLN6aGPpWODI09mI1UBmPZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793656327;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bT7zB9Z+wmvjampHPPwvbbjcevceHCv9gpDKzVcYm80=;
	b=svxIEtpDibFkZtzBBtxyGqq5A5fibF8hoMo5E7thE3MIqYhELmYCdSGSLvZ+xSYXTjZi
	 W60ROn7XJlne8dDBuLLfIypPqdjFOuTgrCQM+g1du8T7lDx1talTyJEfltYaqzbTJKMTP
	 /O0tyDU2wDZ6cktBpb6jGgQq7zrQs31VlHeoaZwbFWhBH4esvKH44x9FNCLK3UO+gZpZ3
	 5K0exItagiT+CPEthR6muni+mSsxyCvizJE5t9j1mjWZWcYy85QLuhaVY/ekGtkj5o83g
	 uiBn6bTrcJ2EMi64Rle9H9lq+3DH0vU3Q7NSRge1VfAwpkCqF2I1HLt7tX/WbwTonFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rk1eKbYg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FE1606A327
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 21:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rk1eKbYg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB681F00A16;
	Mon,  2 Nov 2026 21:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793656327;
	bh=bT7zB9Z+wmvjampHPPwvbbjcevceHCv9gpDKzVcYm80=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rk1eKbYgUypGTpfNKfgUZ7ckA+JIzvXCnPiLqERzneZCU3rWqWvByVtBlhFp2Vuy8
	 4GapdYUyVPXMK8p0k3b4KG/lakXlnRtR618dngjQubWYJDNsnIxFQBz5KfgHurY7SP
	 vVAqAFMtdG8JXCj/nE7oSt25+JBs7azyLpZPZ+FrGrtJMV+HTszT35lKn4W7hGSZ1B
	 CnJ6MIV9bZjeh4yzxQ5adF8F5t8+fUjVwRwlNt1irWvrnaJgpDW+d97Eba06YehqIN
	 oDm8wODUEsP5aSJ1wOGoZG5A6yhvWYT2lHNPNBgnuWfzkjxqmLtXcxYLRVILu/ztyj
	 JCwvWh59i0nUw==
Message-ID: <sashiko-outbox-194237@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v13 04/10] perf ftrace: Add basic task
 call stack management
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102214054.911298-5-atomlin@atomlin.com>
References: <20261102214054.911298-1-atomlin@atomlin.com>
 <20261102214054.911298-5-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 21:52:06 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The function_graph tracer records kernel function entries and exits with
> nested indentation. To perform call graph analysis and subsequent inlined
> function reconstruction, userspace must track the active call stack on a
> per-task and per-CPU basis.
>=20
> Introduce basic call stack management for the function graph tracer:
>=20
>     1.  Data structures
>=20
>         Define struct ftrace_stack_frame to track function names and
>         indentation.
>=20
>         Define struct ftrace_task_state with a dynamically resisable call
>         stack array, tracked in a hash table keyed by PID alongside per-C=
PU
>         active task bindings (ftrace_cpu_tasks).
> [ ... ]
>         ftrace_cpu_states__clear().
>=20
> Tested-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102214054.9112=
98-1-atomlin@atomlin.com?part=3D4

