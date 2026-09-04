Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65763859D3
	for <linux-perf-users@vger.kernel.org>; Fri,  4 Sep 2026 15:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788534249; cv=none; b=TQLDMYWosep77GI/jQHz8l5+Vn015rUIrlBh6tLEDHgP91oRvIz0JZheSnjrSvQ5pPMUD61eNHoAImr5US8oTvDCvV4nPNIAkHazq54258VIO3lHGA6dJmb9eubOI52AzpNNKJzILv7J4PjF2pzngWWSYXgllo6LnUjMJTEx52I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788534249; c=relaxed/simple;
	bh=KOfCWcgbjIg0666VaOKBCnOfPvlgSjV4Co5Aodid9Pg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U5d/CliNHjyzXyS+fYs1tsZ5q7L2rr5B5p3FwsQuX0vLdVSMzPedMP3f280VvyEc6hRNg/+/zMfX2Ap8lUqLoZZiwjVBlp5Qrl7Kh55HUKBcwBW25DGdVaBHomqj7wG9abtBtAKdiCWU1ogJiMAUMoyXM19zol+20q7gIMDyu7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gs9w0yXw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gs9w0yXw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342B61F00A3D;
	Fri,  4 Sep 2026 15:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788534248;
	bh=GP5w5x9dE9S+awmq1oLsCGWRsN7ckTVhdP07MfDh8FI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gs9w0yXwVmnmNAZS8m6ONQMk0FmyQxhvRCOkavZYEGN8ldbxDO//L2EPct/AJgL9u
	 x7ftnpDvxaEzEAlbSoc8O52Gm/7DDDILrNhXQQNomBqqmU0Kqz+Ccp32WWrwsRkroC
	 CFuHcGOIKRI1qvXmzVPTNFSBT1RXD5FbYejjjBU90dFlH1+2pY8nhpi79ndX0SGhRu
	 o1gltKoHoYz7plpGz0sMTClcwf4Wfap2zf7/3K6RrrLKi7y6LKX+2ptiVuHM0CYV8e
	 S//yjemrHlBW/8lPoCuQPnPcq5KjTqHDBiTIgRaQ9Wz+eK4KTVAuM6W79VYG8+4fBD
	 az3znvMaBbWdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] perf jitdump: Byte-swap debug entries via
 unaligned-safe accessors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260904144058.3341-2-acme@kernel.org>
References: <20260904144058.3341-1-acme@kernel.org>
 <20260904144058.3341-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 15:04:07 +0000
Message-Id: <20260904150408.342B61F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> debug_entry records are packed with a variable-length name[] field, so
> entries after the first may start at addresses that are not naturally
> aligned for their u64 addr and int lineno/discrim fields.  On strict
> alignment architectures the byte-swap loop in jit_get_next_entry()
> performed misaligned 64-bit loads and stores through struct member
> access, which is undefined behavior.
>=20
> Use get_unaligned()/put_unaligned() for the byte-swap of each field.
>=20
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Cc: Stephane Eranian <eranian@google.com>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904144058.3341=
-1-acme@kernel.org?part=3D1

