Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793275398;
	b=a6UGLHQK9SVT8aZbrJmIdOdrJVALaKGCmmpoVTPrusYoFthKETRiv1sKanAHd7Df9DtG
	 ETOIsXZCyeU+EUBfMCA5idwuxFdLy/zfJkkTbKL1FVnBTJ0Lp2nz4jyd+aZc6MshFZCLB
	 b8Yp9/UHo7bXQJ+ijzdA7LAcpH2A+ik/MSyjtm1BDxFM8nIFvM0JRujBOeABbLL89jQe0
	 lr4Ggcg0evfXuVl9XknvRqqevqKzbiKtcxZX83QwHwj2lSN87epqOigFBcgfvF6KtKWDM
	 H0i6hiT0KC162bvwwsrhf2fmT8nwvov1cADd7FbX4bMfJ7i4gcfk2UH+Z6OQFj4CrGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793275398;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=h/DLlE3JBivABHi8Zcaq6entrejcCO59Q17mqBR/D9g=;
	b=j5vxzmWqReHBxweY6xSQ6JMP+B1VPQltIAQFyQ1cg8UupxlejGF7jUM6FyArR5tCHaF2
	 qcUBRuTh2YnYwe5nwmtwUYxDh6dqsbqwGfOwkhDHYgzKISIeGsclpnkekgQf7Z3YuTkT/
	 U5dePMB7tJyENLp3CIC2tagOZyZNIjLmNRR7l3FJYYEDW6uXZKZJdonVE+pLhBYyzCmtn
	 yHP8Y4lNzEsHR/An+veLEgS7IkTtRq18oryWEBWBUHsCO6/G7FzzyKZZb1uZK5mooCcqP
	 jZWNxJn1DTRZx8Akuh2nFlmJkFmtYNaeTFY48y/7Th6YYaTQlmL6Z5Q1qELf07Oupdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HDRfEp9G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FF3606A31C
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 12:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HDRfEp9G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 310671F01825;
	Thu, 29 Oct 2026 12:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793275397;
	bh=h/DLlE3JBivABHi8Zcaq6entrejcCO59Q17mqBR/D9g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HDRfEp9GikTqL2GLYkwensf7gE1HF5yMn84tZXnMrCrvIfpp0h6m/2pwbWdvBS4Dj
	 CK+SLuCqShvrh3k+vfT2XOEjbeK03x64huBQ/Rqd1gX1pwNaXDnzFRF2izHmaY0k+0
	 i69m0bRhix01f3VkbrXZQW6PtlfQPRSxQ/Xi+p0kcO+hTmInXTffdJ+yi2nkr8Vxvw
	 lH5rb4iZfxl0AvffnpruEdXWCGAAXDhomY6IUCTYVORz11AOsiFMp3Qh1kLNHkqq0r
	 Xs1gQf4s8KKzHBCGKb4b4fetayED9Rl0YQWlkx8640AfWmLm483liLVCn9CEzNrs6u
	 l+wNE/DFDod6g==
Message-ID: <sashiko-outbox-189250@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 05/11] riscv: mm: avoid enabling interrupts for
 nofault page faults
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhanpeng Zhang" <zhangzhanpeng.jasper@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261029074853.35467-6-zhangzhanpeng.jasper@bytedance.com>
References: <20261029074853.35467-1-zhangzhanpeng.jasper@bytedance.com>
 <20261029074853.35467-6-zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 12:03:16 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> RISC-V enables interrupts in handle_page_fault() before checking whether
> the fault occurred with fault handling disabled. A nofault access from an
> atomic context can therefore run tracepoints and open an interrupt window
> before reaching the exception-table fixup.
>=20
> Handle an exception-table entry before entering the generic fault path wh=
en
> fault handling is disabled. Also keep interrupts disabled until such a
> fault has been resolved.
>=20
> On 32-bit RISC-V the vmalloc mapping must still be synchronised into the
> current page table before that fixup runs: otherwise a nofault access to a
> not-yet-synced vmalloc address would take the exception-table fixup and
> fail spuriously instead of being resolved. Order the vmalloc
> synchronisation ahead of the nofault fixup. That synchronisation only
> copies an already-established kernel mapping, takes no locks and waits for
> no I/O, so it is safe in the nofault path; if the mapping does not exist =
it
> falls through to the existing no_context() error handling. This early
> return skips the page-fault tracepoints, as before.
>=20
> This makes RISC-V consistent with the expectation that an in-atomic
> nofault access does not enter the normal fault-handling path. It also
> removes one source of re-entry when perf sampling is delivered through an
> SBI Supervisor Software Event (SSE).
>=20
> Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029074853.3546=
7-1-zhangzhanpeng.jasper@bytedance.com?part=3D5

