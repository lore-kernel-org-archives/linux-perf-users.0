Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794259317;
	b=sDPHR2imojQaPkJmcF0jGmeOOkkS+RtSMcVgFSFx6beoPbMzWkDxbeVcc6EueLNz0EVE
	 O2maBvUWpcBvPr5XuEDlOj2t2pVdluPk2V8bzKGVyC3nr+Ys0Ge5Y8uScpnd5nS7ovLoq
	 SOK9AdPE9LdPRYLm5CkXPxmQQcn1l/dUqvmgDeP0h7iN5x6/mVjlA2yW3odXIrP3VPHZw
	 fXoWPwxXyly8u7LeINNl+L8DsUxWDLrE/z4YF/CWiSWYApXZB5ij/hlcTrt5eisTwwh14
	 TzHqZuC3Yin8UPnzymi9+9tCP554lOiDf3NbW/TUUBLVn8Ogtvb6e2BGlnZ4OSzI8HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794259317;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=M2JrmYRyCPAA0BNvK5RkmtZ2D/3LsX18NTFMLOREm5g=;
	b=lDHJ0Cm3ha8ftZAMgctoGhRvQbgjDXcEulNDi1GgKDt26v1Qnc5B3VxLv65gpzgzGoan
	 5LK17X601K/woPxn3L7dv3snETivoaa94+IXK0O+v8wetc29Jgaz7trTo9fiYoWu7nTU2
	 kA6a/7dHVtkFy75ErMuUjR3HgzRy1SJQKAWsjjIE5y1qkOmGcDkB9ViEl739gFcoHzVc1
	 25Dx/hkDb5fir9NpLuVKZftzmYnaeeD8N6vdC9QNM2i9gm8exWQd9AqOZPoosUdebRbN3
	 bt0b+frcwdRBP+DHHO54srNRJDWB8O3yf9Jy9M/EM3tvSx4veW1crpXCRiFB/kqHWQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GcGdpMsZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB3F606A31C
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 21:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GcGdpMsZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 798511F008A1;
	Mon,  9 Nov 2026 21:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794259316;
	bh=M2JrmYRyCPAA0BNvK5RkmtZ2D/3LsX18NTFMLOREm5g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GcGdpMsZYsWBuCF93eaO8q1Juw6179i5zWkE8kxTiqpxui9pH0iFIKwolXB23zJkG
	 v+/jdGt31/fn+aYw3g0mai7YmCWuWDTc0ryTxk88oeAVUyeGs81s2Zt711b6XRnw0V
	 rY1Pm1LaS2EU157rjmmdt8vM1B1WPoDQBC1Gdu7JuEMp54rSkFRffNpUPnaChuXAWE
	 o2Xx5Tm6Hps7CwagWpP8+qtvKZqxsj1VjY3VlSeLHOS0cL6glIMBsrPOgbzoxEvNKw
	 OeRi1/ylRVtuDrUDcsulQaHqf6IuMmAZMMRLficKwBfBnOF9nBdK+PmNkETExEhugt
	 CKLbTrE2tsUjw==
Message-ID: <sashiko-outbox-205664@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 13/20] perf dso: Expand context analysis annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261107044102.1506626-14-irogers@google.com>
References: <20261107044102.1506626-1-irogers@google.com>
 <20261107044102.1506626-14-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 21:21:56 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Annotate struct dsos fields with __guarded_by(&lock), annotate
> dso__data_open and fd_limit in util/dso.c with
> __guarded_by(&dso__data_open_lock), and tighten __dsos__findnew_id() and
> __dsos__addnew_id() from shared to exclusive lock requirements.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107044102.1506=
626-1-irogers@google.com?part=3D13

