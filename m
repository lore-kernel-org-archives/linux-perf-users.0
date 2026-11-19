Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795110893;
	b=IMMH/MdysdEgzcF5/S6GVOUog4w1YxKDWhMSlksS/cxMSnFjVTaFTWLd57Agjbfp3aLX
	 TYHqmM+Md56uQUtx9Z1qYr/+N+30aScLmmPvflSS93yIXCyCbBgSwao9upJ1d4Fubs0od
	 59pzd1HIxs3LRf3N6W59V40B2Ie1SV7De/JSvuYip+U7LNQkAgRV4u7nXOObae/k371A6
	 GKLW4ksuP8Yj7RQoq7u6ZFoFU1GoQfo99iteYXsAZRtOtU5/FSFKPe/eJd0Og6QTeYC3r
	 7sMOdVE4GWFkLWwhT5FDTIHMLAvDsLpRQTKudUH2kMLe2L5ZXJh5ksdkMls1+7HrNPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795110893;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gr0eeZEX4gdJ9kjUiI06QreM0H8BjIGWr4pFDCPlVsM=;
	b=GE4ywxxjZk5wYbjd1AD1UnVJ4bZr4+6uPOrAYOLtblFKranOcVXWqfa1iGfYS5yvUVBy
	 jZ7deGPqnzyBU4BmHqbwtbBIobc7/kaeojBcu/eLUWcmmWQBKhXtdkvSpY94qb1kk9Hr2
	 LIj3YQhe+JFgeYW5sma56lleBa/43YcOlhEYI1Dune+oheyLAqw0E2jMW5z9yoXM6RcXM
	 nylwPIPZl2zdz31sfoGQMvGNex1kG6SYudfG1MTcS7yyKaAt1fQPSObhOtE0KZhkdIBpu
	 mWHXpS08S3A7U3XO5SsujUH2pXkMiTZs/R75PTqbFG+rMpNUzRc+XT1wUvHbRJrrNsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HfNbpj6q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8FC606A338
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 17:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HfNbpj6q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6491F00931;
	Thu, 19 Nov 2026 17:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795110893;
	bh=gr0eeZEX4gdJ9kjUiI06QreM0H8BjIGWr4pFDCPlVsM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HfNbpj6qAxJV6OFXNkrz8Ls4DRMVbyImnedFD0N7Zc9OuB1oA5JWTP/Jo/fdLeT/k
	 u5oK9dJZjWgjciiYW7SgygXHmWwZbLBzjsdiP22SKlbdoKO66W18Dypxpme0fcdu4p
	 1Nxg7u3ZyJqaSQLILLlUYh4n9WNbRntdnvDpSGrVRk+CriPBE+tpbJqQFO9SI6Qav+
	 JaXBrZqoHkOmikT2GW7NhmxE2r/hWpPKTlmuBNoLCEfJnHIBzqhVgw5ZYH0Lf2Vc9Q
	 MU3X+yhRJxq4iEaBhEb7wm3AenWiMzSRTxmy2oFG4DznMQ6JBB3OXU86nyKkNHXyhl
	 po1kWPRntL/0A==
Message-ID: <sashiko-outbox-223732@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/7] MIPS: CM: export the symbols needed to access
 the GCRs from a module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119-i6500-cm3-pmu-v3-3-c86410934b51@mobileye.com>
References: <20261119-i6500-cm3-pmu-v3-0-c86410934b51@mobileye.com>
 <20261119-i6500-cm3-pmu-v3-3-c86410934b51@mobileye.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 17:54:52 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Allow modules to use the GCR and CPC accessors from asm/mips-cm.h and
> asm/mips-cpc.h:
>=20
> - mips_gcr_base and mips_cpc_base are the mapped register blocks;
> - the CPS_ACCESSOR macros consult mips_cm_is64 on every 64-bit register
>   access;
> - mips_cm_lock_other() / mips_cm_unlock_other() are the only way to
>   reach the registers of another cluster through the redirect block.
>=20
> This is a prerequisite for building the CM3 PMU driver as a module.
>=20
> Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-i6500-cm3-=
pmu-v3-0-c86410934b51@mobileye.com?part=3D3

