Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792623444;
	b=3MBPcD3TB9inwIcKrsxF0AF1MyQmy2IPNTROWk43HNeoU+bF0faciQPzmxw6eVzZvl9I
	 KYtgG1nuTFX739iW+mqxSskxkxxOU29asQ8FSIqtggIX/vUC3/xECzWtMEZ5atWGfDiYv
	 ZK9u0IYDRIBut82XPm5OyuVyhjrfjU1EmAcdZJFsW8et0FdAogdP3FU49kkuAjoDyXTVR
	 80c10SHeIP779CkzYHsHKcrapcE2+swGbtC3HDzrfEgMz/SyX/j2Dw2xyS8SKwh1cavnz
	 y6VhgtiDCZD4VSQqF1PLC1qWSfPBWqsRahMlnjGR7FwZsYj4Xduuuy+HBxxcUDtSMKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792623444;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=c81iqXzDhV9uXQN66lGR7lDAZ/tIS0n7TovXjYRvZWI=;
	b=hRs68zLUX79DBvmshjX31nDrYudJ8QRkPW0gTCnzN6Ay6gBzECKlcIev1i+81cl4X0ZB
	 yc3g4u60WPYlQIOrrJUEJ1OpIEXXMdik4G/HkgWD5Uy8O6M4+XSGWUz79uARMa6fxAPkR
	 H1R5vGlsNtOs2IwFR59cuVMHswoelk3heFHXMtcwTIiQQgyiRXTufGf4c+kWs1Xdaj3we
	 XUQon8gQUpNxayClzxQEwITzy3JNz8IzZZSZu7gkdYG4SxsMGFmZnWP+UHMcvdw1Zcldb
	 N2BHQfmz/lvZfiiu/K8aVSB3GcQnVzRHyVH7astfXPs0LOtsOYYgD9jcLYiNHi5CZOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XojJpg3r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4920606A319
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 22:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XojJpg3r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC351F000C1;
	Wed, 21 Oct 2026 22:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792623443;
	bh=c81iqXzDhV9uXQN66lGR7lDAZ/tIS0n7TovXjYRvZWI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XojJpg3rLPy6Tbi69ZNyJy9nl4IloZ4q243S9y7spAGxGk1gp/xEBSpj2t3U+nH0c
	 6x813yITFVXeC3XE++WntvNjT9Ydoqh/DdSNco2opMTX1ptD59fZp2SZQBuJcN++cM
	 6jqTvH/LyGkcGL9bTq3okbpliUQ2zoPIzMjna4FA0JRRPvzvTsXTe+ocw+FLndinR3
	 WdA5PBadhZ6YlmMylEyExvM+N212mtxcGQPCuua/6RPCo8K7OXP+C4jjQpqPZXV7CQ
	 qzJDU/uPHAahqfdwJnJzBKvx8xUCpeY/2mJTulIPZZkyz8DrC6/o7pwWD9ReCQWntT
	 a9Bj4y/Flxcng==
Message-ID: <sashiko-outbox-180751@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 11/17] perf dso: Expand context analysis annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021223905.715051-12-irogers@google.com>
References: <20261021171044.155240-1-irogers@google.com>
 <20261021223905.715051-1-irogers@google.com>
 <20261021223905.715051-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 22:57:22 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Annotate struct dsos fields with __guarded_by(&lock), annotate dso__data_=
open and
> fd_limit in util/dso.c with __guarded_by(&dso__data_open_lock), and
> tighten __dsos__findnew_id() and __dsos__addnew_id() from shared to
> exclusive lock requirements.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021223905.7150=
51-1-irogers@google.com?part=3D11

