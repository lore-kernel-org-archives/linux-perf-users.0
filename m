Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792740103;
	b=HFaWvllqohFHggO0m/tS7HcKqVxCDZbocj/QVDz8+npjMXD0+2XpYmGYh8wXeHuGfiF6
	 ZcwLLtX7UsoHF+rRBZdinkoGOSm8mWyhra62CWVSg0DpC3RouNpFIt+1rhfu2eUAELiqL
	 Ct/jcCQ3E/EVDWxJYhhhlHpx4Bnv2ZgG6+Pmr0XG6fd0Q5jS/VbFfmgQpyLr1JdYI75Mv
	 v6PD5gcVYCycBm8IVvX4Cio+vwn82MaIc1Ch8dvulAsFe6QAjcsFz77618QWHyrZXRQyD
	 1kpuhhDtrcJ3cLM41+4YJBzJbkF945RSWhcea8BA/sm9X/oQl1fCkJjuEzzIQFor72A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792740103;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wmtzw6VOOHUvX9qVEN2sGuhPfgk/VxJ6Ot3900iqrQs=;
	b=QOS8sRJB7nBcTDCTu9oiN23iSHzPLAc0cZoWoYF/NpHwNBJgcjXReFegeup/HJVwPLN8
	 VbideelXrC0B1M+h4oSQYKdCRu/Kpa5HjEgSGVpUgaSZ0x8tXktLPUppSE5fc956c3AJ2
	 CJ29jEQZ2ROlZO8ypJAtuqY/kLGtVCD61lpE3rCkYlqCRx0PXeluYmKBnSGl29ELmCtwU
	 YNNgf/Q6whRM472sz08cj+WoESnK0WaaEdi0Dix/3br9L2JMb/7GKKqA+Gp/KrimYpDWJ
	 tx//W9KkOp4VyT5FZOYrqoge04KqgSLv2LfTqpzdKQYVKjqUP2x8KU98L89lB8MkdMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c4751oG5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB41D606A31A
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 07:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c4751oG5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661AA1F01825;
	Fri, 23 Oct 2026 07:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792740102;
	bh=wmtzw6VOOHUvX9qVEN2sGuhPfgk/VxJ6Ot3900iqrQs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c4751oG57er9nYxGfSLoIdUQYyGakPgJ2qkmbzlYxs+5IZtTBaN4/GSfF0g3Sc/Li
	 7LvRvOU+8APa6jby/EGv9sWUj1UdSHw00FW8vQF3b/s8r0BSyJt3Qb2DZOLr9YO1hc
	 q2xbbOX+NGAgmQwvYoG+Iw9QJsPAexlz6336GaxGUaTuvwqma8eqGM/Y7zIL8xnvnj
	 a0t9aAagU1fZp3vo590z0DsVKp33/NlUtrEMT5fsdBRFZJu84Xk5i+NMnyYXPUHS9y
	 zoGiR2RQCv4kA8yjI+he1CoWnbhFZfxX1EcIa3FqrVbJsG4JG3Zy76Q7jyKVQcLUIm
	 UwFmV2U0ir2UA==
Message-ID: <sashiko-outbox-182402@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 03/11] perf tools: Add nsinfo__new_thread() to track
 tid
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261023071141.134149-4-namhyung@kernel.org>
References: <20261023071141.134149-1-namhyung@kernel.org>
 <20261023071141.134149-4-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 07:21:42 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Record the thread ID (tid) in struct nsinfo via nsinfo__new_thread() and
> access /proc/<pid>/task/<tid>/ status and ns/mnt paths instead of only
> /proc/<pid>/.  Also recreate thread->nsinfo when the pid of the thread
> is updated.
>=20
> Assisted-by: LLM
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023071141.1341=
49-1-namhyung@kernel.org?part=3D3

