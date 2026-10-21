Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792622534;
	b=0wjO09TB9d1Go0ckPl8xkyM+lhuNPdnT8qt+XHTsxGPxdbdxrfi5g6s7kM5g1NtyncSU
	 +2lPve+9QOhWLIWDknTkeOcv+lWcrnt14y5pBvcTbhIgmtWAFrRRSQtk+nynrCVU1g8/P
	 cA/fM7l31gpfJNK+k0BbZ4TtYKLywJiAYyW790+OEKPTANLXd2puyv/qls5ZKJXIqJ7D7
	 WB+N3mH1khtsmNrqvu7ky5xbX3CRp+o53oGUcnOdZ9XF713FEL0TwpFcov/UuW8OLYTo3
	 bxdKTfh8jjBmvcYofvfEBEqwZQWtgdfIyDwKpGfMfk7MAKYs8/lo9VUC+g3dT0SRHAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792622534;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8SkTswXV53iNAqDEcwpMMmOGdiH6zVQJkScJwAQGxc0=;
	b=o+k3eiBPaRscBduZtSEoS6qSpoSrC7fxcjNByEeGmTLkh0O1c4BAN5FZ3khLxWcoDaXC
	 VdAQ+ckUoI4vAw9ErvGFs7yrZq/z0Gn/n9sFy2hftDlLCNU81vPhjIx84iJky3jS6INTo
	 M23INQQrkuB1k/RJBTR3B+uOtU6QpTwkciCcbs71uRfLMayy6rEus6xHqeuOMVNNihtjU
	 2Cu8YO2LPNTKL8SkS6Dy5Wi50D6cUkx4FEeZAhzv4CPMlF2EYOKSx2IUeOM14bNe4TfGP
	 d+mz8n+BZ/fBh+JWNY2n1fIYUETVadx1MWsQw/Sucl/ITkFhGOSwTxRElqHO/5tmamw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YHtiZagp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A21606A319
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 22:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YHtiZagp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5411F000C1;
	Wed, 21 Oct 2026 22:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792622533;
	bh=8SkTswXV53iNAqDEcwpMMmOGdiH6zVQJkScJwAQGxc0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YHtiZagpNucrMuRVW9hnDnq+blufiMMEsn9uyh2LCIrk4PNwC8pGEBuxDblTTK+Xy
	 xZvv2pITWw19gAkJi+kQ+La5dF3Pg2PsEThYNzlVEqMdVfEg8vZR3PF7NgRwARK/ga
	 rplWK78kACzYeXXxCf+3haOEP2RDdZQqyPc345XdWiu6z1cYtx3HyBlknLxDCJqIQS
	 DPWPQ0RGoLsI1XaFHhQmV7efTZRzKVSsIiK6DjvRbu/Qe3xyRJqr03fBTg6NH1L+1T
	 r2lWqmcHlcH6LWoZeh1l7BJhUFEb/nY1d6AsCyxocZpzyH12wYTe8ZjfHMGhkJ110l
	 sylJGIKbFucNA==
Message-ID: <sashiko-outbox-180732@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/12] tools headers: Sync UAPI linux/fs.h with the
 kernel sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021223555.28372-10-acme@kernel.org>
References: <20261021223555.28372-1-acme@kernel.org>
 <20261021223555.28372-10-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 22:42:12 +0000
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
>   21a62663d473 ("fs: fix typos in comments")
>   338964881982 ("mm/pagemap: add PAGE_IS_ACCESSED for RWP tracking")
>=20
> That don't result in changes to the string tables generated from this hea=
der.
>=20
> This addresses this perf build warning:
>=20
>   Warning: Kernel ABI header differences:
>     diff -u tools/perf/trace/beauty/include/uapi/linux/fs.h include/uapi/=
linux/fs.h
>=20
> Please see tools/include/uapi/README for further details.
>=20
> Cc: Hemanth Selam <hemanth.selam@gmail.com>
> Cc: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021223555.2837=
2-1-acme@kernel.org?part=3D9

