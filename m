Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793949184;
	b=mEt1AJuAtAjjU59OYBDXv5jnIyfNPid+7JjwA2wKm8v2RPa0eezmV4KTVVMAWQdde4uW
	 X2tZ98vWuWj2KY5O1bDOJQPtVOCmAgKqTC4GnazBW/J7nyWcDCdDGeq/sOsLM45eK/Zkq
	 fV7O3tAY9YAj/7D/CDxoCtn210bKC7El6suLyqjyqS7XwkCzKW89xZwOEynHRyEDla9SW
	 4baeiCC0Pa8JdLhPWQ77noK6Ag5f6SJr+3thk0RnFIzlMNdM1oiPTpu2EQB5Kwy7/AajO
	 yfO7gXMLz/OG4E2EeUC0qR7+Bnyaul/xePeGp786bV76MGOcLGAgPGBk8hh8vH7yaWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793949184;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bbPFvvXbfuwpePSH507awjCd3d3xjVAiRzMxn0V8Vro=;
	b=I8U9E6O9aio7d8X86DyBR5gwUdDLRbsQDPs77wpQ7br/90Bu6aeZX5azn4o1N8tSaNdg
	 yqBejH7K/AnR2I9ZSBWt3qM6WvgnqNbGrI8Ckm2NuFdDWtxP8/w7VgwUmDhnimK4vPQ7r
	 JURBmunosfYx6NvARN2CisAWCiuZkdzkwQsu02BwJBvx/wgeDtq8ZNRXUBKIBp0J8BmfV
	 hI0CKmBIxGfQqLPEQtXWp8c10uaJOVjHbLJsgVl0YcwBA+UR2iZ5fg0TRIuHBxNUSLpT8
	 hYhyvOChlI+YKO7JCb07e93nnpLYUxNyqYaG5cjH3rkf0fd1rBB35mTtYCs3NsCfWbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="VKETvD/X";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E4F606A33B
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 07:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VKETvD/X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722F31F0089F;
	Fri,  6 Nov 2026 07:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793949183;
	bh=bbPFvvXbfuwpePSH507awjCd3d3xjVAiRzMxn0V8Vro=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VKETvD/X/qAxRWKEHsicrHJ7d/kOaKPEth7paElIdtc/cNuLkbBPa/wCNfZWs5qIY
	 C8uUEk8V8sdiLtpWM0HuMIdXaNKLsZj8OdCjL04M2vRyMXq/XBGAkp9SRONbKw8Aen
	 mhjJe2gCV3utw0TeJfiQN+k/45Ged4hEijlzZaSr0sGLqiGVFnRBcCz6wW+xfQiem0
	 29HluD/mVzityiwqJ0kdexX3ywrmE4mV1sHgB/EZM0/46+89VlJifjzmW1Ir/MZ7w+
	 0FrEbOlqKio1gdEVnF7sAPmWUvW2+PnFETKTvtFn3YQ537gCXSTEI79LRZC+lVhxQQ
	 xE2gUnlRUXPSw==
Message-ID: <sashiko-outbox-200976@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 02/20] tools headers compiler: Synchronize
 compiler_types.h with the kernel sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261106070344.329897-3-irogers@google.com>
References: <20261106070344.329897-1-irogers@google.com>
 <20261106070344.329897-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 07:13:03 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Synchronize the non-__KERNEL__ sections of
> tools/include/linux/compiler_types.h and
> tools/include/linux/compiler-gcc.h with the kernel sources (including
> ___PASTE/__PASTE, BTF_TYPE_TAG, object-size helpers, asm_goto_output,
> ASM_INPUT_*, asm_inline, __typeof_unqual__/__unqual_scalar_typeof,
> __signed_scalar_typeof, __native_word, compiletime_assert, and the
> __diag pragma helpers required by compiler-context-analysis.h), and
> remove the duplicated definitions from tools/include/linux/compiler.h.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106070344.3298=
97-1-irogers@google.com?part=3D2

