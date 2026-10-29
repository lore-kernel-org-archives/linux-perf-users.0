Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793251009;
	b=KzZvEaOaX82/rLlQ0PTbQgMZlJrOKMxdGmyN8fYski3MPZxCbbt4LkQwmmztM9+HNLrf
	 DRcYPK75jmb4klEKgtRSfTVf02LjjyAEiKTCC0QJq6mAlXP0pyueyg+WPL7dvb2CCASff
	 Yr0SutjTDAe8zohR+VQdwRYn7kjcEbwnfCcJKXG+/aU64L7lhdwdTpU6wxIk7lsmc743h
	 K1gosrWPe1L7W60bUEs9YilTqZ67RqCOgLvOvzkdsD4VQuLY+O3LKRqlyP1rkVuJ0u7vd
	 blKCIB6OD208FlTr/wE3bCE8O5G1bmhHbmQZdCDfBV4wQWAaXfu2zw+f8qvZNn5D0Wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793251009;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gzum/QbaEEeXs0d/wjlKaKVE4cYZ5odRB9nponBVgw4=;
	b=2BWJxBKqCW+X2IpZvq6XAtQ6ixExYeiJZerAPo+2LQw7rbmXw0MALAi7vDzu9NAtPr0/
	 DmADAxMI3kc9HO+bwujpwrx4uMimvmj7NJVXVn1XqKUiUHxXta6XpfFSNVybbMc8pnjo1
	 AbN3UgHE15EsUKgsKUT/IVOJkBMngKiPju9m2k3BjCmmyCqnlSmBITEP5azBY0XFsSRAH
	 IW4HiIOQIQPkbrjw/esYHVoSK/avv3dRKNq+R8LAFLmfvA/UNwpo4lyEoHMMAkP+4gWUL
	 20qcmHmlS6qOkyNc36DO8iBI5cqOPYC9QxJLk+IMUaa02hmRNbI88ct0qhFkWo72Vaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cJwSbsdu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B950606A31A
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 05:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cJwSbsdu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1279A1F01825;
	Thu, 29 Oct 2026 05:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793251009;
	bh=gzum/QbaEEeXs0d/wjlKaKVE4cYZ5odRB9nponBVgw4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cJwSbsdu68GegLiN26UWAvkk+8ObjE18RHKHtFddDD+yCR/eZpGq6tmZX93fzF9vJ
	 Ui9ikQy8XdORQbscoV3cF6QwOtpMQnY7ORzzA7vQ/2V4VjkwhLg2rhX9SBkbrWNzUW
	 aggIL2U+W6XzDIpnerN1lBNs9ZdOt8DgWVsh3n5J9abKKZ53FupxbkAtt8KZbhzt0x
	 YiSsAnCSKTTYXrnffD9WXLHTWCvRzXtLXJhy8QGX4fJhxoAaGLEwSmxg59U3jeBEgx
	 EIHJifBF4m77ICIveI9Rsq56sh9MP2MvixAxjKKEypLABvEbDbIxjfdAqb5qRGM95Q
	 kfuR4DZjkINPQ==
Message-ID: <sashiko-outbox-188748@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v5 16/18] perf/x86/intel: Refill LBR stack for LBR
 counter events in PMI handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261029043914.1395147-17-dapeng1.mi@linux.intel.com>
References: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
 <20261029043914.1395147-17-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 05:16:48 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> When handling an LBR counter event, the raw LBR counters in the reserved
> field of each LBR entry are cleared after the stack is processed and
> reported to userspace. This prevents raw counter data from leaking.
>=20
> However, if multiple events overflow in the same PMI, an LBR counter
> event may not be the first one processed. In that case, the raw LBR
> counters may already have been cleared by the previous LBR event, so the
> later LBR counter event cannot read the correct values.
>=20
> Refill the LBR stack before processing an LBR counter event when multiple
> events are handled in a single PMI. This restores the correct raw LBR
> counter data for the event in this corner case.
>=20
> This situation is rare, the performance impact from extra refill should
> be negligible.
>=20
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Fixes: 33744916196b ("perf/x86/intel: Support branch counters logging")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029043914.1395=
147-1-dapeng1.mi@linux.intel.com?part=3D16

