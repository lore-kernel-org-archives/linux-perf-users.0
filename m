Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793656302;
	b=L51P0rVGHqyQBR8e6y9YTX2v3/sRU4NbCyj3KYnGQwLgT9qFoNakpVSc5VNJtvQEsOV4
	 hGXCEiPI2seOSW50/qFr3QIwglniPtPqZuzUCq/o3kMpPgWEcWhgEdjIdYYE347jj+aj0
	 n5QJ+zGnqW5OpfK+3ajiZC2y7PySsx0/1GqMRqloHGjakuINwZnaQUcWTyQypU2dQNL1V
	 6Tvuy7j1yCX+jVuwvgBH8mFiXq2UZ8UbkFjLrPglgwWwcX775oDLya883zmuNgeGnPG5z
	 frU3qpc3AojEh7q1WIRoBItz13c7Cqgl1G5bbciIYUGPV5YLwOfd55MrHXSWuKTBSKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793656302;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MD8aC/qH5PUwXJZ6/A3r0oO37gFHlcFzAWBC5GQRpoA=;
	b=iiVzOmLFG4aq7S9Ezwh39V2jxA1bab3p/axXZAOTfDvpOclpWzXXLpSbzkQltd5NvLFI
	 iMdSLd35mGkfb0stg+V1MlYZZqAsH+YC5/Q6xMkbcQLRhiw+5awR2AR11PJ6AgpjUdI5P
	 wqDuuQ1Fj7v1O1CJtSDhze2u2gtTpdF6x8ANtU1E3O6/FuWRznw2KJDJyi1HYdf8sO/Q3
	 qzseFnT2jRWbv3zq4tPE8ZmypO1o+R/84CI7nFAIJThRc9KC1jm4ue67rzWR6Abf3H8Z4
	 DqUIAWaCpoUrUvaJMFJ99pI7zufKHOS4j20xUV2SC2iaF0i+2cLjI2NNIJ7KBIISCHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Z/pvEj3u";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24B9606D825
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 21:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z/pvEj3u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4986C1F00A1F;
	Mon,  2 Nov 2026 21:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793656301;
	bh=MD8aC/qH5PUwXJZ6/A3r0oO37gFHlcFzAWBC5GQRpoA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z/pvEj3uUy7qsG8jz4SOKPS27Q7/be0pJBuLxj1Ytqr9GCLDa4GjZimB688bG4JiC
	 2HvlvZNp3K/21SV6XcZJIX7ICuPZB7ARMeN1xci0JaQi7wMibZtSQZjk80Yed07zdU
	 xHQ4l9dZ7RWZYN6aXW/KnZFfXjiQc894Z6v41dmHhJktAjCiXbQWgAoHcnHqySxvgw
	 kbEdmObHVa/vZOoRdnROoAhcxVnjIb8jUXpLnRv/D+Egs8r0vuJPrPx4y5OEk7K3cg
	 eDKRelnOiZY9l2/ARsZskd7aKRDM6hiFzWoI4UOZ+7j631QG85zd4RALDBVFe8IJ11
	 qqjh16HgkGyUg==
Message-ID: <sashiko-outbox-194236@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v13 02/10] perf ftrace: Optimise
 __cmd_ftrace() stack frame with strbuf streaming
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102214054.911298-3-atomlin@atomlin.com>
References: <20261102214054.911298-1-atomlin@atomlin.com>
 <20261102214054.911298-3-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 21:51:40 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> In __cmd_ftrace(), incoming trace data from trace_pipe was historically
> buffered in a fixed 4096-byte array allocated directly on the stack
> frame. Furthermore, reads were written directly to stdout via fwrite()
> in arbitrary chunk sizes, rather than as discrete, well-delimited
> trace lines.
>=20
> Refactor __cmd_ftrace() to employ dynamic heap allocation for the read
> buffer alongside a dynamic struct strbuf to accumulate streamed
> characters into whole lines. Pre-allocating the strbuf ensures that
> line processing incurs zero heap reallocations during steady-state
> polling, whilst the stack frame of __cmd_ftrace() is reduced by over 96%
> (down to ~160 bytes). Emitting complete lines provides discrete records
> necessary for subsequent call graph parsing and inlined function
> reconstruction.
>=20
> Tested-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102214054.9112=
98-1-atomlin@atomlin.com?part=3D2

