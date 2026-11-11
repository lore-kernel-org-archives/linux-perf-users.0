Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794424176;
	b=A8/yg2wFXn4D16gsupdH4CQ40Y5K+YDBo+4Dawcc8+fnNH9cFx5RwrEnb1MeH43lu9/G
	 q6eM89omP2lcWTpxrmxlrjwn/chVfw+nFTNd6BChcu67Pv4GCGDCP7mEMHlep+C2MS97E
	 SvrcaAXOjin+PFlh0n349RSrWDUpkO8nWtvwKE3sAF9Nou7Z2KDmHSQttDVpEi62E/K11
	 4w6fVVfIVO/BwndVtJAr/QagICzHv+iGNixVvyk9+c/ONKmF/DAjft7LNTcWI8HqIspb3
	 D7LBnGGz4MZA9qQY2TuDHaZf8SycvdSxOdDk9TWCeguCxvXb5y/qLLaHD0cWDJW0hmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794424176;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=w4a/moomI//Q4/GJuGoC1Aw07wBXEacguu+beA9ZSWc=;
	b=Xzx8cL1wmbn82t2F4LyvfSMGC+nG9i3FIWRedpUMxbG5H6q9+S0A54oJOBPUGrxNf9m2
	 0TKy67FcPZaQvH7UxdtkrQEyWjf4Izmkj1PVHNA8LxRyZbK+skcJ5nBWDT8gfmNfp4AaE
	 cpjRaI64UJKQqPLo/LD1ucYFimRV92TieRT9y4tvPSY4MEmh/EZK8e5y9rM18QoBFK6Gl
	 r3PhLPp3sDKuIgtb8edprRfC7BGCltz7x9FKUUqecp5Hm+lg/fnXI8y4wy1Kr+hBt15nl
	 ob0vC3dxbB/1qiw/jYDEIBsuncvrKu4y/vKGHPq13Wt1DubudYyuR/Mw17cKYlXveeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aBWx1Dty;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07652606A8BF;
	Wed, 11 Nov 2026 19:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aBWx1Dty
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9341F00A14;
	Wed, 11 Nov 2026 19:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794424175;
	bh=w4a/moomI//Q4/GJuGoC1Aw07wBXEacguu+beA9ZSWc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=aBWx1DtyNh34nv71EemD1KewvqNXjcrW9+fG1Ych9WAkrbPqBd1iu9ZnBdkCF217B
	 2N+Mp0WrpOEaOirmoLBG+9BLsfan5Ib7P/T1e4TnuOWH1C9TL3G5pzvLLWBl4Woli5
	 Xhifkgbn8+ktJEutHD3D/mymx+TOkkZ9Z5uk/bIiLPpTa6Ze93TfAD1FP2KZoCbrU3
	 6YQUD5/iu6CGE8SBFZShBpwIIrVsfALMP9a7kCzEs4+UvLAK0D67cmVg0uFC4pF9lh
	 zCU4LlS/PBegbQB8Tb+3vm2DW/lms8xo9pu/oXMHBL4sJy2DQILCXqsQ8juWkADzGf
	 n5GoKB7YVoOmQ==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 TAKANO Mitsuhiro <takano32@gmail.com>
Cc: Ian Rogers <irogers@google.com>, John Garry <john.garry@linux.dev>, 
 James Clark <james.clark@linaro.org>, Will Deacon <will@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Ilkka Koskinen <ilkka@os.amperecomputing.com>
In-Reply-To: <20261107022145.1713159-1-takano32@gmail.com>
References: <20261107022145.1713159-1-takano32@gmail.com>
Subject: Re: [PATCH v3] perf vendor events arm64 AmpereOneX: Deprecate
 BPU_FLUSH_MEM_FAULT
Message-Id: <179442417490.676192.16502569583148059552.b4-ty@b4>
Date: Wed, 11 Nov 2026 11:09:34 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Sat, 07 Nov 2026 02:21:45 +0000, TAKANO Mitsuhiro wrote:
> AmpereOne named event 0x121 BPU_FLUSH_MEM_FAULT until
> commit 10a149e4b4a9 ("perf vendor events arm64 AmpereOne: Rename
> BPU_FLUSH_MEM_FAULT to GPC_FLUSH_MEM_FAULT") renamed it.  The next patch
> in that series, 16438b652b46, added the AmpereOneX tables with the old
> name in memory.json, so 0x121 carries two names: GPC_FLUSH_MEM_FAULT in
> core-imp-def.json and BPU_FLUSH_MEM_FAULT in memory.json, and the
> default perf list output shows both.  The old name has been in every
> release since v6.8, so removing the name would break anything that
> refers to it.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards
Namhyung


