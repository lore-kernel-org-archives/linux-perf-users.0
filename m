Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019696;
	b=ijmp9Qv2drKcjn9Sue7ZDhdOK05rfyy7BYl1Xh8CfrkbYy/9YhUAQEfTuKuDNw06vy76
	 4PR78flW7vyvx4UaQqOjbu5h1xqL7/J3jK49AhVHEFS2dubX1VBJ5yVPce/7MOhXYyXsQ
	 v7iUMUoMjxuTy0vjQoNiw75CChqWwTXPwy3jY+pEsnBjgD0Zaaga3zWIKdEiZYTxJBhU0
	 LxPLCONXI/PbdCw7PMJ2s1QVKKt4cqCYdyeKpxocrjs9EaQryi9muTFz/RbMOf+o8dT8E
	 8y0n0e8tqYtYBLHKYknYyJh8SzIQaSPgF004uEir5e/3WocR5bRqaLyiQmrR/3qdnLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019696;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ni3PFc1n7VFg+ZNu4piVzi6g8IoLbVHsg/I6/7mL1AE=;
	b=d20ye1vZNH5nY4fuszPydJMAuf4W6ciC2FReNBs1E/MYCtTwD2rNUt3Nwli6q8saZTyZ
	 C+RoRRUcq3GVdFhT7+iyJ0eQfyo/L+7+IaQh+tqvQYRyPrUBg77nd0IYUwFjGffStQmbl
	 5aM+FLPCuhKeAksP+ooanoEp+ZJKI0HTq1kCl3CBfGYJOpWc3Ams8vYfzorvZscvaAz94
	 4nNe61sBhcYhGpxQmW9ZTBb7P5YNOTc1wBqeb4ygbQLeMd6OpV3rIQ7Bfkqhj/x97oi/5
	 53TiqsYSCfHcCnnkHBP+OiU3fAi6GQ9dmcHP85fO9zpiqmGJHvKDhWhPyE+EnXl+LtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k2wJLqy7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA5E606A32F
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k2wJLqy7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BCAD1F000C4;
	Wed, 18 Nov 2026 16:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795019695;
	bh=ni3PFc1n7VFg+ZNu4piVzi6g8IoLbVHsg/I6/7mL1AE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k2wJLqy7qApzEYVW3foZAQHDtOys4gflu+FEriKHjzlJKfiDum1K9w+YYDM95dAzG
	 YaE/2krZedy9BgpGOY7g7CKllD43xYvqCR85JioVUy6FJvg09cTT4sg0hb//ShNwJ2
	 5UMjjzrnIkFD0X/fvrm8LoqbRiowKFb1osExjywYlzFnonfEuyINduzBqlnfVBwPsM
	 HSxosWO21QWcOuQNHi+vNfHyyixoLXLWdjq9JHilG/+J2aDPchWjpLqWl7CixvftFM
	 OZjPVs/nauBngaOxmBRch3nMRP1yUEodfkialwd2SdbljLrDyJw8g9Z2ukolGw6Kcb
	 3f4xS8NKkjmsw==
Message-ID: <sashiko-outbox-221500@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/34] perf jit: Add address ranges to DWARF compilation
 units
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118-james-coresight-jit-v1-3-dad4d90747f6@linaro.org>
References: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
 <20261118-james-coresight-jit-v1-3-dad4d90747f6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 16:34:55 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The JIT ELF writer emits a line table and a compilation unit containing
> only DW_AT_stmt_list. LLVM locates the CU by address before looking up a
> source line, but the CU address range isn't written into the DWARF.
> Therefore it can't resolve these files even though GNU addr2line could
> by reading the line table directly. This means that JIT src line lookups
> when LLVM is used.
>=20
> Pass the generated code size to the debug information writer and emit
> DW_AT_low_pc and DW_AT_high_pc address ranges. Also mark the compilation
> unit as childless to match its contents.
>=20
> Add a test which writes JIT debug information at a nonzero runtime load
> address and resolves an ELF-relative address through LLVM.
>=20
> Fixes: c3f8644c21df ("perf report: Support LLVM for addr2line()")
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-james-core=
sight-jit-v1-0-dad4d90747f6@linaro.org?part=3D3

