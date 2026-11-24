Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795509161;
	b=J19Ji5FFFSXgFz7yDdgYp/mlBVYjCoisqHopWjyplggrhhp7RLPu5JYOQ6ZShnLySynU
	 3B3p+XBUOt4RU2zw0xd9U7VFN5r/k3cvK8j1dwILJ9WT+zbHIda80vis6jORiUniMEH0a
	 lXs/LLHV+qQsabDtLDmpFdOkerdAlVWI16TPr5IjLMlXuKtqWs8H5B+SX1eH36jP4+27+
	 MQ5kKFkQox8+R4LTelt0svWWDM21AQrckCua8PeSOpfomyji9WNrF333mNHqGwT4OCtIR
	 HCbKzdqCo6cS0vNNBzPP7dVv1bCu9r4ndwx6WxPOITUvbjYv7tI/cuwdGJiub7O5t2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795509161;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1xML+C1n667FB9gH6KWNvcgqcAt+70W05AVHR8T6NxA=;
	b=2lT0HN894bK2yPK6EV1oR9lm/nNQ/dQBds1j3jLzecwSExAewD6boUXyd3jqgKojY2tl
	 iF/EX4NQuZTa60K0cRMbjEzbwrqWXRcAPYo9CnW3JF7dqbNuScOk1ODohD2ZhZYr/Q6y2
	 u+vhM/9TVkv9t3yLsqTd4O6oP72eE3nSCLJFPAejzun398ATU/rks6TKdlDCDzxEx5nnm
	 NrZyWgsLN/Pr7szQatLCE5M8qndft5jzi6zjTUUwiUN8MpdvvFBwdegQUmrjaUDBMdcXr
	 vY3qWcYCp/VdrdMYfVaKuCOccDyOHHZOVASlAxQ5r2LtgZVifc2dWTD9P1maTlGVAIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=neoHX14l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B489606A681
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 08:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=neoHX14l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E49C1F000D2;
	Tue, 24 Nov 2026 08:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795509160;
	bh=1xML+C1n667FB9gH6KWNvcgqcAt+70W05AVHR8T6NxA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=neoHX14lvt9AXJ+/h71Gceq7FKv40uGLi3RqaFBz0VYNk45peXyW1bIpT/WqeZP8i
	 f5kv6hntn/fFeHnH1dQ22A2XiMPI17QFpHKLY1Cku+vo5lB1sYumxUjdPOnkWsjRhR
	 /fxBftZHqfGz6v5ZVV7wNig1M39jNbnNfzlIZTEtCQiYJomP7qRm8DL5pmY4dLD/RN
	 XbdHWl88v7d171h4AOqw+Z1NzyW5ZQNHqcibM3FZfBOvH1pkFmbfgXiqN0HJD2i6mI
	 JZh0yg3jm1PJvJpCwa7Hzc1VoINNOEpIm6ZiRpy0hsz02IczODuAfb+9F5lN6KvVhm
	 XozrrpoN4QnxQ==
Message-ID: <sashiko-outbox-230724@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH stable/linux-6.6.y] perf, bpf: Fix NULL
 event->orig_overflow_handler dereference
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luo Gengkun" <luogengkun@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261124084837.2327711-1-luogengkun@huaweicloud.com>
References: <20261124084837.2327711-1-luogengkun@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 08:32:40 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> We hit the following problem on x86:
>=20
> 	BUG: kernel NULL pointer dereference, address: 0000000000000000
> 	#PF: supervisor instruction fetch in kernel mode
> 	#PF: error_code(0x0010) - not-present page
> 	RIP: 0010:0x0
> 	Call Trace:
> 	 <IRQ>
> 	 bpf_overflow_handler+0xa4/0x120
> 	 __perf_event_overflow+0x11d/0x2f0
> 	 perf_swevent_hrtimer+0x127/0x140
> 	 __hrtimer_run_queues+0x108/0x250
> 	 hrtimer_interrupt+0xfb/0x230
> 	 sysvec_apic_timer_interrupt+0x69/0x90
> 	 </IRQ>
> [ ... ]
>=20
> Fixes: aa6a5f3cb2b2 ("perf, bpf: add perf events core support for BPF_PRO=
G_TYPE_PERF_EVENT programs")
> Cc: stable@vger.kernel.org # 6.6
> Assisted-by: LLM
> Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124084837.2327=
711-1-luogengkun@huaweicloud.com?part=3D1
