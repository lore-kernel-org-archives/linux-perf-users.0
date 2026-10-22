Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792700892;
	b=NVEz2edy2k6Vgh6vFPFWtRZo/S0uqpvmsfwSp8UbGUnXgXa//AJb/uKmZd/SJ+xekisU
	 W8KZNf3Bq1g1qdk/SoOCr8WESNPvhoOOzxvstBai1WWW0CoNjghk8+QHD1Ax1fINz7UkP
	 aYG6fFfHABMWUJ8lfq0dQpHN2T9kMK5ZhXEH7ERdijh+i+H+7GbZuoT0rY678QGGXQ2LU
	 fNjQnrx2NoOClM/LWVZsjuMNgWhiBPPTBWWFvn3GP/NMKfTON850DXToAAlr38C9nd8qL
	 rPOZ5u3vDRsRSHvkzXJeS0Jpx2DLSWACpvCTmvkNEEGeamoJsvAGpyec8W8s06YlEVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792700892;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=g3OuKIY/agcVW8uHITRXCgVIDtkO6gVlCo02L6hgNRA=;
	b=5iMe4s0NZICms5j4MSiSnjqeh+vm1JGTiZ2MqwkfMoCFmS5bFxm5NPh54M4TnN/K2RJa
	 AJvLXb/H+X6xXHardAXZge3He3n84C9XA+8VRr6nKTDEKUmqLqcoPtwc+J8Lun5T8EHBO
	 OPAIoQQcL3x3SnhyOPcRZsc32M7UBz1fkCrTHXzJxV2Gn9WxBEITV7FKyYo+OUsGPciys
	 Vhl+EzKoGMwwsBigJM9E2HCe5daUn+AdJ0HQVuLbvMiC2lfJyk4niRSWAUE0czxGoGweb
	 vkvSUlvQ6In8WvxefCFMVArMwlr6aK/ojGh8q6GF9gdbmW04lPUiFzOjqWvBUL/no5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RAqjDkw4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89803606A31B
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 20:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RAqjDkw4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B071F01828;
	Thu, 22 Oct 2026 20:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792700892;
	bh=g3OuKIY/agcVW8uHITRXCgVIDtkO6gVlCo02L6hgNRA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RAqjDkw4TqtRxxD3a+SKe3ueWuQ+jzpNYmHhf0Q+bzItgWnSea7++OUOo7lhUvvg6
	 1WkBvpz4qMRFl0lVzs/2m3lkApbXBK/hTD06jW1POfErMuBUKPKB+vMxrt1TDMSOIh
	 lksybygLqaGYTY+1kbxVLqa/HetqNuvuK2F/d9lKnuHYQmnTrHFGG3MLK8BrkLb2h0
	 1VaeTb89gh9D9FakpDGwUA5yKZ7tDzC7r7vF2oBg2yBGXY5juZ9lgCs3/vFwz3dVhI
	 cQjvlU+J04oyNP0rRZa1RfoyxSX5reqncozUU6KZdeZMIYlLqB40h2F/qdVvdeL9X4
	 nL/jnR7E2AT2A==
Message-ID: <sashiko-outbox-182003@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 09/19] perf dsos: Ensure DSOs in auxtrace, machine,
 and symbol are in dsos
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022201453.1717523-10-irogers@google.com>
References: <20261021223905.715051-1-irogers@google.com>
 <20261022201453.1717523-1-irogers@google.com>
 <20261022201453.1717523-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 20:28:11 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Place the DSOs created in addr_filter__resolve_syms(),
> machine__process_ksymbol_register(), and maps__split_kallsyms() into a
> dsos collection so that all DSOs that may have data fds opened or be
> referenced by maps belong to a dsos collection.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022201453.1717=
523-1-irogers@google.com?part=3D9

