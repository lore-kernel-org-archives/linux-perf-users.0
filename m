Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793373854;
	b=r/bua6/5O/WeCFE6lP5tmen+01uds+XTdBJ4/AFxhTYy6WtNGeDleKC6W8h9TN5oHAey
	 xxdfFuxbzeIC16TiUyilgkupwYRRTHL+wI7Pix1oym4lNHeSokTzO7ofKQrPtuEchvo7Z
	 CmMhNhH0feDB5sOMylzxKE8MR9y6QehBLaA+zoUC7AG/wkmQ3BfAIk6zBmTjyz22N92Jx
	 bY1TtwxGtNhlUHjGzm8XjGg8KtB9xNpcrvZAsKVQRPEiINAfDw+PgM+grrcsCHBi4E7mI
	 nHBAkKGb2Sl38rkLTLJHre+08v0XzudE1WfZEG+GokMNWu2+OwixEBCiaOm7x7+l/sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373854;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MkMkdb2JGsS58gR8/PBfiOACNGeLM6SFxY60ML9DC6w=;
	b=C1FsIJz1RfO0CbmDqRh8mO2m+LuXp5BERi4Yb5NsmxADDfOG5O9WpTkDXEsl0B7vPtEg
	 UBJtIIiLcTm3+3RmjS15LRZcdpF/0E8OpBJapVnCPIQttLqsblcqv9iK75XmlWK2Wc1u6
	 UwDlvKlzbfdfmeO6egwmottMyOOLtyEsiY/PtN6CO5hiHXNE6/PHMiDDCeCViFMH8UzbA
	 xrcgWhp08hpgZuCrPkTT68n2Jh14ur3rnwmFPlaBDgyIr0rd4dg1rq4Dp14uG05XkTzS7
	 qOFQDuwJCRKU0pEDjmIxfnZT34M1HeZc4sVbsWqEJI8J9DiX1pSPkgMkbSLNx6cZLcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ke9od7nL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E977E606A32E
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 15:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ke9od7nL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 689341F0093A;
	Fri, 30 Oct 2026 15:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793373853;
	bh=MkMkdb2JGsS58gR8/PBfiOACNGeLM6SFxY60ML9DC6w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ke9od7nLZ+dq1rSprzt0sgvM/izAi0er2t55ft9wAR6O4Q38ParrTg8oKFpwrTl4L
	 aLOQYXd8H31HFws+9UY/buyykSuIulpqQDgMk0r27qw623QeX1czarKIkL0KsCk/vT
	 07sLFpeQ+8HG113W9IJABqPXOuN0opXVMUE/lhb9DmA6csfhUTjeJibgBv7jOFz5qx
	 6FdutOYf9a0AB0InNt+m1uUOkdX3Yfci94cvNHM4r8BCGn38EI/AYsSRMzp85taDLF
	 KeJl523mlDl1n3b5ABh1vTU+LiTdTiTYuE3ey5CnZcv+rfYXfrTMntmLNGmKoUp2f7
	 7ZuP8sbwy/g8g==
Message-ID: <sashiko-outbox-191166@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/14] perf tests: Check CoreSight abort entry and
 exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261030-perf_cs_etm_fix_non_taken-v3-13-7629b52ab047@arm.com>
References: <20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com>
 <20261030-perf_cs_etm_fix_non_taken-v3-13-7629b52ab047@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 15:24:13 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add page_fault_loop to repeatedly discard an anonymous page with
> MADV_DONTNEED and read it again. Each demand fault is resolved without
> signal delivery, so the load must be retried at the same PC.
>=20
> For example, an expected int/iret pair is:
>=20
>   int            5ccadc =3D> ffff800080010c00 insn: 00 00 40 39
>   ...
>   iret ffff800080012284 =3D>           5ccadc insn: e0 03 9f d6
>=20
> The LDRB W0, [X0] at 0x5ccadc faults before completing. After resolving
> the page fault, the kernel returns via ERET to the same PC to retry it.
>=20
> Reviewed-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-perf_cs_et=
m_fix_non_taken-v3-0-7629b52ab047@arm.com?part=3D13

