Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792622999;
	b=4yjzRi/kiMqEpTMayxCAXv3DawtZj0nx1x4cGNY4RP37u1SGpIVHXTfmkvUjzV5rqey4
	 6ux4a+uf3eb+zVTVIrOp5J6yfBT2JBZEZu6kV8GlRc4e/e0yZ8DvmpfgYE7bbnU4IVi36
	 XPydZWqACmcbopx+V877awuYfaG1aa944bKVyinRrepmZN522atHFLazvNmHJnqa5C9Xr
	 8EU7VQincMznTOnPC3eNCdj0ZC4UhacN2Zn1adz5JxqtQmKgGLt2MGu7oHOA5VvFj+QaZ
	 Q8XVPmDYygpOmkOZuQ133+hZNTm6hhkjCJUayUqkw5tjV47PCE6psBFzcgqmPpyhWgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792622999;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KMOvxL5NDz5gyTbSavYG6v5CKDaVF1IgyIzw+xv5mKg=;
	b=t8lQxJQAnCW3tqTtq2kCPWdUyoo/1FefHR3wcytLbT8/tJVl15pamO3CIpvVLSx90Nqs
	 zILwL4CRRguUoleEWtaXeD4+smz3x9Qv5aCDb2ieWtADVC5RyL+HsSuGLam0st6ofQPD7
	 Nudj82u0jx1T9s97/Pumfn6IqG0CvOkWRW2KJXF71uZm9wECrLIfLzz3PvHkJTLxTwpj8
	 0grxOiwyFOhfjHdZHRQ0TpGKPCmuy759/bufxkNuUKY/il3okPtEvgZyIGGA5BLTqodwq
	 D67ws3A8SvpCoExKWODfA0QGbeEXhwEyRUiZTrb1b8ZMwf7vPqW8e2E5ABuCf4FlSww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ivT4Hisz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0052606A319
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 22:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ivT4Hisz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 081D91F000C1;
	Wed, 21 Oct 2026 22:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792622999;
	bh=KMOvxL5NDz5gyTbSavYG6v5CKDaVF1IgyIzw+xv5mKg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ivT4HiszhEaIqqOK/zZqyDX8/YaiTcOGelxxU1NM0I7nKo7SQoE+xhfhNi4ZPIh2r
	 myjjf+CRsH98EGnRGDF1Neq8BKIOBCICM2qE7Rank+HOZT08jClBqqIuTX3H93YqFG
	 YD9H/jb3cpnJ6g4qkhCkgWCpPlg1HyDPe7JzAPz6Dp7U5o7q1P5pg6uOesB4nUuRVy
	 xc1K3qy9GZd8sCxj9VrRdH52ggpWSq2z5UYSUVb52AcKAZ5i15eba8UNNluzQxxmyT
	 Auu1CSmy+KKFcyXLE7S/MBxSRJGNhKha9tswrFwkTxnhiONvpd3OfX5FHAYPmLkHHg
	 ndwyFKOt6+RXw==
Message-ID: <sashiko-outbox-180741@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 02/17] tools headers compiler: Synchronize
 compiler_types.h with the kernel sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021223905.715051-3-irogers@google.com>
References: <20261021171044.155240-1-irogers@google.com>
 <20261021223905.715051-1-irogers@google.com>
 <20261021223905.715051-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 22:49:58 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021223905.7150=
51-1-irogers@google.com?part=3D2

