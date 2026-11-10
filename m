Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274949;
	b=aqySuThmwKEP+zCjOfoQBRvTGhA6fn0a2VsYudX+m3pvf+vdVE+IJ8gJGsA0/mWXRBAt
	 djlx7Nyp5OSzi55A0kSGnJOaYz1+Aa1HGScWSB7Bvt/rHHY02j2Jw+ZUErVLTCvERtfdk
	 5gzEn1VrmWdIdU5asD42J5B0WC5v9CLDwu57gBzZZo+1a9Aez9Q3zQhtpIk0hK55Jcaz5
	 pA6DpNgOazJIKEgYqUdSiQr+AROOP6fAwYwlsCPLksv7yPHc23YEGDi8QUek8wWQ38ovz
	 BgL/CYK58uN1Y7ATUTHmr7lM+17FqUi3bogYkC5yn4XShaICais9ESZtxcyWANr4kiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274949;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5dd6Y6CPnAcileGiAc/81JwlIUTSp0jG2udkeQwnV6M=;
	b=KMxEKbjV3/IU73C7DhZ0yz5mCG7PVr8EKT6OY9cD831YUvFSqiicaM8PdKxby6Wx8vvH
	 PwdldmqLAG4UEetsKC0igoWoi7er0zsvCYdk2HlKLQXSKJ1wQNYWhbGC0+YeB8y3l4wXi
	 yJh6yTP1VOM10Zic4Oc+fpD9yywVjONsjaJWFe8dyCSFgnG8MypMcS1un6RTSVQhDKqiA
	 +IW7N1ni/Rkj9sVJYy+NOrCcKcx+IpG9TohvmwSLxr9b6kDlVaalXSYUUYnTAmtrELt46
	 3XNLhSzHw7Sxo2TQAlMiKq+RtU8t2wLFKx7nnIhuhD83Cm4994TKNJi5Ahnw+TRrLSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F1XGg9aN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F24B606A933
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 01:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F1XGg9aN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE2EF1F0089F;
	Tue, 10 Nov 2026 01:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274948;
	bh=5dd6Y6CPnAcileGiAc/81JwlIUTSp0jG2udkeQwnV6M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F1XGg9aNx9lwjhnafCoWq5pnhxNLE5TrUI8Sqb8rScwcHGpmcTl2D4IBiNfJOIXG7
	 rSRXIMsfhHdNEfQi1JQSidGif9lwj86iNQ3K6UQNDdv2S+GrKeBHLaX8lBllpdGZUa
	 Nn7JRVTaJuR4XtVt25ogokHcAVbUWpFlR39TI99IMqNMh26XOhhBN8yLvfFXF1Rjsx
	 Malq7BiXmEQmsyegQn2MPZMAwb85FjgTpBm+sHtrWIkOJZt3W6QKr4VynJC3JrwNTy
	 952fDbbDYOhnqrXzxRLhMUMW/Hbp5DtS2Fxnbk2UdXO5hW3//0vVPdF9LbGIav9YeZ
	 WBFQ/zrk6cD4w==
Message-ID: <sashiko-outbox-205980@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 06/10] riscv: ftrace: always preserve s0 in dynamic
 ftrace register frame
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shuai Xue" <xueshuai@linux.alibaba.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261110013750.36800-7-xueshuai@linux.alibaba.com>
References: <20260914092648.51254-1-xueshuai@linux.alibaba.com>
 <20261110013750.36800-1-xueshuai@linux.alibaba.com>
 <20261110013750.36800-7-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 01:42:28 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Wang Han <wanghan@linux.alibaba.com>
>=20
> struct __arch_ftrace_regs declares s0 unconditionally, and both
> ftrace_regs_get_frame_pointer() and ftrace_partial_regs() read it
> unconditionally. But the SAVE_ABI_REGS / RESTORE_ABI_REGS macros in
> mcount-dyn.S only stored s0 under HAVE_FUNCTION_GRAPH_FP_TEST
> (CONFIG_FUNCTION_GRAPH_TRACER && CONFIG_FRAME_POINTER). With
> CONFIG_FRAME_POINTER=3Dn the slot held whatever was on the stack before,
> so any callback going through ftrace_partial_regs() saw a garbage
> regs->s0. RISC-V kernels default to FRAME_POINTER=3Dy, which is why this
> has not bitten in practice.
>=20
> Save and restore s0 unconditionally in the dynamic ftrace ABI register
> frame. This fixes the latent garbage-s0 case, brings the dynamic ftrace
> path in line with the static _mcount path (mcount.S SAVE_ABI_STATE
> already saves s0 unconditionally), and matches the frame layout already
> documented in the comment above SAVE_ABI_REGS. It is also a prerequisite
> for the upcoming reliable unwinder, which reads
> ftrace_regs_get_frame_pointer(fregs) directly.
>=20
> The cost is one extra REG_S/REG_L pair per traced call, negligible
> compared to the overall ftrace cost; the existing FREGS_SIZE_ON_STACK
> already reserved the slot, so no extra stack space is used.
>=20
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Reviewed-by: Martin Kaiser <martin@kaiser.cx>
> Tested-by: Martin Kaiser <martin@kaiser.cx>
> Signed-off-by: Wang Han <wanghan@linux.alibaba.com>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110013750.3680=
0-1-xueshuai@linux.alibaba.com?part=3D6

