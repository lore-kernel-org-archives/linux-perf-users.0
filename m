Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792622354;
	b=EcPTogAhcG0wZzeQKlCqfhSlFhX5QEm6ZVMJyRJN+2dUkAruKwXUWu3zhyCQgDJfbaC7
	 PUWvS547sC4aeBU9Wfkwtbq4ZgvrgBYvMODEr9bRzjcCUzIQ9siZktXFuZUZ+23QBjuSi
	 xj6e/A9QgHQ4oB1McsTAnHolwtznlCeMeTZzW5sceGlpW7U94Fx5FOKLBpXgezX1sRnNA
	 aeFzh32gDnxvbD/lZb631Rxmv5KfcuXkdz+kbH0UNiPrFJUd+x+oJfKp+1G+KLMwfCFvs
	 I0C3yz4XcM+naSY18uePWcVVf2p04d6UeLxNbGow4Yv6q/JXaVfoI7nD9VbWst18qAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792622354;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FURglo7MonawRGd5ucF20ENFsFs/UqB62sqGwbZ0SSg=;
	b=wc6vrIb+//aHCgksdjo3+vkxNuCKhubWG2KqzWidEKVgHvyu9GUQxu9zXybSIb4KihYe
	 6flCZ8TP0ETiaBIE4JUP2kkzQgnbVyVUJtTpY7AKztJ+WjX41W9ut9+Au+AYSi3I+0UYS
	 ADPAN++jeVlJRU1v2pHsubeXmS5r7/pg7DavP2z7ty13uFlT1cgtBr5KjHPlLJpaMm3R9
	 jj2DeJjMIYOeUyEGl2JclwdJpAQN60qyvAqibnmQI6OMrzpqk5Navk6llqLWDuhGhM6Cb
	 76O3SY6j41lR8pcFZ3AQIGyCrt7EtcO1jCL/CmLVFHW8yKEAODfH5zbzN6R6hNQtCcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BSIe56k1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D439606A322
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 22:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BSIe56k1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEFEE1F000C2;
	Wed, 21 Oct 2026 22:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792622354;
	bh=FURglo7MonawRGd5ucF20ENFsFs/UqB62sqGwbZ0SSg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BSIe56k1PwJt1nDE9V+CWclusqtvYkltFQzGCb3NNn3/0l+rBjApWCOxyyfI8Pvsj
	 OQ42h0GXray4hkO3ZSmnOrKoqrg2jNPcUhgMwbBdwmHtyO2W/dX5jivgw9qtwcgsqK
	 dGoeFPkozLpLYg2EnDbEMnrx+hPG6GtpTe7hMSBXeujktOGMn15MIqozlDziFFe3Xc
	 ZPKFYzmKaUX7QZu8GPv+XfldlaWcTXmB47MR4Klwd1PENhFqXCD/gZ0DTvk6cwfkvP
	 dKYBLxgLMfh/ITVbfHrE7KuQze5WYU8+ttM3lPmU6aKRMiftPXW3y+0FhQUsFiANhv
	 TVeHEmdeomY2A==
Message-ID: <sashiko-outbox-180727@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/12] tools headers: Sync UAPI linux/fcntl.h with
 the kernel sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021223555.28372-9-acme@kernel.org>
References: <20261021223555.28372-1-acme@kernel.org>
 <20261021223555.28372-9-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 22:39:13 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> To pick up the changes in:
>=20
>   cdf930a00949 ("fs: support FD_FAILFS_ROOT in fchdir()")
>=20
> That don't result in changes to the string tables generated from this hea=
der.
>=20
> This addresses this perf build warning:
>=20
>   Warning: Kernel ABI header differences:
>     diff -u tools/perf/trace/beauty/include/uapi/linux/fcntl.h include/ua=
pi/linux/fcntl.h
>=20
> Please see tools/include/uapi/README for further details.
>=20
> Cc: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021223555.2837=
2-1-acme@kernel.org?part=3D8

