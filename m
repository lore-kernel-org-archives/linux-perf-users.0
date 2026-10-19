Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792448393;
	b=gsOvt8ymwgzvvEaBGY3NttCHbDBwcOkIvfPjllZZvLeL24nYQ9Ove5cTjZKPCEbgtbve
	 SocWj6n6aIDcnkgJ/Y+Jxkc4WsFxOBMdf3UnRYDvEyfQ3yN9pCJw6exRVPdamMrT1R/tZ
	 tdPD9rtRyhr1pLID0wUTLiW4ZIWIUZCRP6Xzbou/C1eZ7Zim54PPARq6hFh+tT6pqze6j
	 +PhspyNtbhwB1P/6nZpVMtWKZ0w6xd/dQ8fbwcejhcnl8C50cGDM3WkJ/FKGcVjN6lmJ7
	 HYpslM+5WvYtLACVSMJs1luUVIytbmxeDAY1FQ51cePpM0S/l6VAQV7y8J2DsfoblbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792448393;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xbcD8YF5wVJGvRSjz7d1R0dPWgkvqyhrOVaBPg/Wxbg=;
	b=uRLzdyNrhAT+CaRcduyw0rNE4eLYwZZXLu4qpJ0idZVEdlzaBchIzYh1iKlT6ioycDB/
	 RGZoNOQP4OEb97bf5oxT8OoyJyrlnSvAXKbEJvIeKvVsAHcLbPNZnM1dBOLvfMY4eMR1q
	 wqAHwBRh/swmBe1nmY7Rbj5yh3IhVpTF/jOlMc3adKGopwy0gV7kpMlvYW1cFyqhkHKlw
	 TbveyEc745VgdOtH+TlMRiDrLb3yubxu4lFiV3QhpwnxGPAtby5HJwy3f54n6rzIW55p4
	 kJfaf3A/Cj8FnGfy1YMC1hfIuAwPopBZMmiO/1jguSKz6W6dp3ooIMqFR89YNbbnU5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DXQySmfv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75011606A32A
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 22:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DXQySmfv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4811F000C9;
	Mon, 19 Oct 2026 22:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792448393;
	bh=xbcD8YF5wVJGvRSjz7d1R0dPWgkvqyhrOVaBPg/Wxbg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DXQySmfvDqxMKaO2hLIvzWYBL/SOgc/khLM7VSFWjPDLMZQj8Y178F++kqoaXWTvB
	 2/poLBijGcG5nCin3+JOhBq1YVEIHPeLsHYtwwHQrNJRiK1E2i3TSXcgaim3E6/P3J
	 Ql5tx6961KwBswwRTwZ+MdAJQQAGVFc/v6Y973nddGSBTfmAnSsot5t3namuLtbBB+
	 jyuDsowWLVD4Ti1wCnV0QECly+WRGmBi+xImY5/MMrgtfluelar0yH1TG77GeaiUww
	 c/Xf44lLH+y+eCPWO3+7ddYnmAaV/2RBEElstL8kWMo0RXFwjIu00lvBiTN9bWTAli
	 7VAisvM5ShR3w==
Message-ID: <sashiko-outbox-178310@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 7/7] perf lock contention: Extend BPF lock contention
 to RCU and SRCU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261019220915.3943592-8-irogers@google.com>
References: <20261018053710.2572636-1-irogers@google.com>
 <20261019220915.3943592-1-irogers@google.com>
 <20261019220915.3943592-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 22:19:52 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Extend 'perf lock contention --use-bpf' to track RCU and SRCU
> grace-period and barrier waits:
>=20
> - Attach fentry/fexit programs to synchronize_rcu(),
>   synchronize_rcu_expedited(), synchronize_rcu_tasks(), rcu_barrier(),
>   synchronize_srcu(), synchronize_srcu_expedited(), and srcu_barrier()
>   when available in BTF.
> - Support filtering by lock type ('-Y rcu', '-Y rcu:W', '-Y srcu',
>   '-Y srcu:W') and by lock name ('-L rcu' or specific srcu_struct
>   symbol names).
>=20
> Example usage:
>=20
>   # perf lock con -a -b -Y rcu,srcu -F wait_total,avg_wait -- sleep 1
>      total wait     avg wait         type   caller
>=20
>        35.12 ms      8.78 ms        rcu:W   cleanup_net+0x284
>         7.84 ms      3.92 ms       srcu:W   __fsnotify_parent+0x114
>=20
>   # perf lock con -a -b -l -L rcu -F wait_total,avg_wait -- sleep 1
>      total wait     avg wait            address   symbol
>=20
>        35.12 ms      8.78 ms   ffffffff83754dc0   rcu (rcu)
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019220915.3943=
592-1-irogers@google.com?part=3D7

