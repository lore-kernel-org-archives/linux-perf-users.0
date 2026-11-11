Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414535;
	b=BsQM3tVP9Ot6pmNnCngDhPVe6SuprjZWHSiBXSXZfgjra7uKXDc7llnLGvl65WVSYAUS
	 AV7cZAW2vgtvAoK7LYgr3QpXiD1aY5HcR6tEH6aWIA+6zUIGjLeJmFYyaH292DV7vQkyd
	 +aBJSAuSmIazB3jgxlZhNYtyo4PCE8t6Q8xNmNOwRDnDu+fNnGDlXvJ/wTDkhQIDieuV8
	 2SpkCxHt7EC8rkbVN2I16Dx/Z6GtI3KZ4e5NXunMA8FeUpLscBGSrdRXW8iT3e7h9xcBj
	 SkpqAqFlrIkR745NCQoCoEKRJSWHQkxh/fwZL3LZMg81UXhKSooYxVsTD1bKeKoKelg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414535;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=O9nuqdjF3eqt3fS22CmLxN7+rxCnSStvo66uCUc6g5c=;
	b=E+P98g3Eh6w+3WjK1kwg0YJn2xDL+zGg6E9WTecYDjpyl/LPyb0lGC0TZHtvPB2x1pyJ
	 WFtaTWmTpAhHLTIuXbL1N8fhrR5WTcXdZ0YI5fOjK7p61SE8uB/bizrdUlNfH0CcqXDBx
	 cia6kQRoaCFubnbdOKMvBfCCCKwnfvhG2Wo3jknYYHDCP8eb9W2LfjeH32DW2yw2WKdk5
	 oNVNqvTSmnzhD/ZI3RRSSLZNNpPPmKFcAuzxfiPQ3Hm/k3bjyNrFqAItjJRfNvPk6zyQN
	 XVnjacMM57wjUwGLp4cEfZuTJQkoxj3t0g038QGKVKnLk7cWPH58SmsOmrntSR/relg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=igcwCGZa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798C1606A32A
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 16:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=igcwCGZa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8181F00A05;
	Wed, 11 Nov 2026 16:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794414535;
	bh=O9nuqdjF3eqt3fS22CmLxN7+rxCnSStvo66uCUc6g5c=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=igcwCGZavkPczLbvkHQGU1x6nYXyEgov9AqGb3blwaJWAfRf0CUB/3SeSCFnWLzxU
	 VHgk+rImlKYpMt6r8Cc/HoZLJyuaiGClBuN+n6kMwsRbp4xfDBX7DCed+7hkZ0wM4u
	 QSx4UcEN+fAT94od/qA8HNOKpud68A0llkKhOuUhNGnVrWAKwY4FwkR4Drk/9uNJBK
	 bI5eHNZNDtIxgvvacI+w5HZbmyIkWO8c/Rupe8m7uDp9pb6ufnD1VCeK0qbiCJoO4u
	 e8GrtlFkD4RsOqIT5sb7zaXPCfNPSyRL7bvDHhsb0PtGDgeW/6tvbEX8z9gQEh1juB
	 It6Il05fYKULA==
Message-ID: <sashiko-outbox-209285@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/3] perf jevents: Make the model argument optional
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261111150920.2383157-3-takano32@gmail.com>
References: <20261111132622.2349165-1-takano32@gmail.com>
 <20261111150920.2383157-1-takano32@gmail.com>
 <20261111150920.2383157-3-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 16:28:54 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The model argument carries a default of "all", but a positional argument
> with a default and no nargs is still required: "jevents.py x86 <dir>" exi=
ts
> with "the following arguments are required: model", and so does any caller
> that only wants the tables for an architecture.
>=20
> Make it nargs=3D'?' so the default is reachable and an omitted model means
> "all".  Builds pass it explicitly, so the generated tables do not change.
>=20
> Fixes: 5a09b1fd1b1f ("perf jevents: Add model list option")
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111150920.2383=
157-1-takano32@gmail.com?part=3D2

