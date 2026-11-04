Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818569;
	b=ONGPSyOHY3Q5IX4HOSxfQzq5MpnmYBhWDmc8u73PI+rSXQFMRwvQciSeYUBAiCdX5OAO
	 rYpGuCy4Ow05ISIXjfwk6oouWGV0jXPy4uMZNH57BFIVH39uoX6+/1H8CpGwP1tdVMxRt
	 Jcq5LSayH0YSwr/nJt+V9/1c9cPqOMyJQejqwaH4o5PTUAe1Tg8obh0YkgTcOktgXQV5b
	 pfd7su9UJ7OuWXo0MUAE0OnN9nC53WAtAt02k/v6OqjgVe5GDjIzCJuE4obgRK4R7XQ9F
	 YFDOaRPR9OYLRp0Z+eP4Ue/+vXWxCNVLqfxGSMQgi1K039eMiZEEyHTNMbHZneIq1+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818569;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6h02pjY31iOC20QJUPEB//iRLTBNXxefSzIfbwJ8/Qg=;
	b=gZ0eQY12yV5rGKZhHaH/nwSr/b0Qb2YXWFex8nM/zHh/Rz+cG1rreXr2wJLVlXw6j56i
	 U9tzuOm/y+Zt1CEnlDPlWoGP1qu6Ajhy1DulziZwtLNVhqONXIa1nOw/Em1geBYk+MaQX
	 q0ApRwNOam5GQ66UkS0G72xsgsUjEguTeHIyfNmHDP/6WWU3qfTae73grC4uMOQDv4LOx
	 lYtE6LOdvdIl9oQBFyw9Ll+gLmrvdRaiipDsaFMIcOnYfJIs0afrnzLLHSqOOKFEpSdOF
	 UiFMSuozme+kTItoKux/7znj0FnQOARs57GhhP6Vsu5ErUBSYJgSxTVwQOf5ggVQ0Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U3S+AdGg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E5A606A336
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 18:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U3S+AdGg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9132C1F000C1;
	Wed,  4 Nov 2026 18:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793818568;
	bh=6h02pjY31iOC20QJUPEB//iRLTBNXxefSzIfbwJ8/Qg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U3S+AdGg18d5oQSrwXU3cQduXhG36m4NvAAl7QTFUAkQMCSEpsjm2pd9Xowk1RV1j
	 Gu/q614giPKxJWHxHi/jCHYflJHVARip2I7/cKJ2bCWqO/GilL+XBVJQ8MkPgHyr58
	 QoUV7jOKUUj8+YKLAvLfqZCa7zL2uCOzoJ0bWk+zANS184evLZFLJ+EMv9H3wkYan0
	 /5Yqlz5SJ4YrX512rY3bGacBJJemY0UtityHV52q/L6IPX9fd1o9juaByhejPpOBgB
	 +oHS2Ha04cw23mC8/MJHkl+umpSpFMK5bmdk/77UCUYLzsDRLkiowsSxnxrm2A7RIO
	 jPgUlk7pYXssw==
Message-ID: <sashiko-outbox-197891@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/13] alpha/perf: report the ProfileMe window count
 as the sample weight
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104-alpha-profileme-v6-9-63362e9290a3@gmail.com>
References: <20261104-alpha-profileme-v6-0-63362e9290a3@gmail.com>
 <20261104-alpha-profileme-v6-9-63362e9290a3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 18:56:08 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> What PCTR1 counted during the ProfileMe window, the inum retire delay for
> cycles:p or the window length for instructions:p, is only available in
> the PERF_SAMPLE_RAW data.
>=20
> Report it in var1_dw of the sample weight, which the weight and
> local_weight sort keys read. It is 20 bits, so it fits. As Alpha is
> little-endian, this is also the right value for plain PERF_SAMPLE_WEIGHT,
> which is what perf record -W asks for. Samples that fall back to the
> interrupted PC get no weight, as it belongs to a different instruction.
>=20
> Suggested-by: Ian Rogers <irogers@google.com>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-alpha-prof=
ileme-v6-0-63362e9290a3@gmail.com?part=3D9

