Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE665497B69
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 16:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790009785; cv=none; b=pD8UYyK33EUv9uZp7tvw0GJYugqlALfiYb/X3HvmbymJ11E6Glzf7e4VPCiKL4Z6WPpJwvISHkGMQq3qsvD+bXOBoOR33kkBtwXEnsxSM5mt23rilYwxXbxDKEVyqdQB/gULe6969SOQYFGePrG1DMG5JDIlp6uFliKH1ohDRSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790009785; c=relaxed/simple;
	bh=yNq0Wv2/Tss2ELXixIODIVN5fM4uv6DPGfLrUyxuWSU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D2HvgCBTihFhIlYoSoVD9vUpUp0P9qQacaSF0ISQAAW+QZCfzC6EjFgvCU2f4RGH81mFLKubeCL8M5UXY5GtRtG0yL/Aw+WdM8hE/i1MogBeH7Ncr7u1wTUhNoLHDise2CR/fst8qCZO2D2h+PZkC51bUjdrawcQ27ZUKTiIe88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdquDJff; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdquDJff"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE921F000FF;
	Mon, 21 Sep 2026 16:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790009783;
	bh=yNq0Wv2/Tss2ELXixIODIVN5fM4uv6DPGfLrUyxuWSU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jdquDJffKCi/VHFsYFLyQm5YzvQJ/a5VAt17Xk97UnMK9LGoxhwuZryCxj9fnUlPL
	 QYaq+ewo+nZHce3vLOb3fF++Zi4UcAthnNuRMUSemBNcpUFXVbUDs/8lg5BgB41lOS
	 +1vWru6wkAre79rhxJs4YakouuSEYJ5owLkiF7P2yjpHcID50tR6Cai+SfJsC6v0XG
	 p4V9N1+AQ90mERXZNEzCfMUqz+yw8jOsdGBV3XFciNeyHQn1aEGTaJRosg5P2RH3BL
	 6qGvBsnssLnvb/q4L9n7yiup3uoRz4ljz6S/Nvg3GSjiSp0jAM1YfZmDfCLazQmIcb
	 2IDpK+RnH/f5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/7] perf dwarf-aux: Bound the type chases for broken
 debug info
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260921164813.6727-2-acme@kernel.org>
References: <20260921164813.6727-1-acme@kernel.org>
 <20260921164813.6727-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 16:56:22 +0000
Message-Id: <20260921165623.6CE921F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> A DIE that is not what it looks like, e.g. one parsed at an offset that
> is not the start of a DIE, can have a DW_AT_type that refers back to
> itself, making the typedef/qualifier chases in die_get_real_type() and
> die_get_pointer_type() spin forever, and the same for the type name
> recursion in die_get_typename_from_type(); 'perf report -s type' did
> exactly that on the dwz compressed debug info of zlib-ng (libz.so.1).
>=20
> No sane chain of typedefs and qualifiers is 32 DIEs long, so give up on
> the type with a pr_debug instead of hanging.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921164813.6727=
-1-acme@kernel.org?part=3D1

