Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794884647;
	b=BrzKhgKsAz0zgBz2/eZ4zj5asW2rTxHthH1TSJH+XIJiHcGLVH8LEeRn38a6690iGBuM
	 adP3uSI20mr7Nx6aagWMByddmyqlYA9p6yOpae4YYsHgHVbVcyiVCYudgz4rZhq7kB/2R
	 NIytkTxsITewcvhMpFoNxPbEYbBC5NKe/9M953R2LKGReDpbSVxuv95ULwyti6hXbHYhK
	 i+7vvgqPvweqeq4GNTYw7iAWiRBzvm/96NUSkWGOcfxi93IAXXA5NIhUwJMvfxAFvsg5Q
	 t4YcWy0z9riBOl8e/wZg8hmYv90NyJy+TR/mCwGwgV5BN8s0idHwL4zzb1o7rKjbK3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794884647;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mBDJghc/FPdPmAPGvQ08LliYpQtNyADjnc1WwsA4WkU=;
	b=cSkwU/bgAk4U2btG66SME+bNAlkcZb0IcB2S5ANDpbN4ZzpgaXOkdbIIgH7085ddl/Y1
	 5mvQ62lHn6y5g6BXqgYjJJn66qk6/OjW1P93EEsNpoZp9TR2/eexgiIqVMZrDhpnT3Gk3
	 JeTzrkgSKchC9t86c2TAO0e7SQDqDmxurm5WtlYbJChvTfewz5vw9nATg2FFNG8fe/8eD
	 3No0xyxjNPssb52fZAfQ3acJVre12TOKFS2tD1u+4N3OUnf0DaAJ5km+KRtHtvONNHlfh
	 vdakC2ea/EIVEndHuC3J2gWsFdfCYKkBngoVE6kyaK5oaRyu3RS3GrW/aA0aAlUVmkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kduhy6ki;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEB6606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 03:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kduhy6ki
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581491F000C4;
	Tue, 17 Nov 2026 03:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794884647;
	bh=mBDJghc/FPdPmAPGvQ08LliYpQtNyADjnc1WwsA4WkU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kduhy6ki4a+Ev/MvAaR+CR37p3KN2HUwVo5CC+OPVisUYAPiDrKNVy6TVoja43kCS
	 rDMqH07hHm4AFVXwPC117bHO/r0WxWqpNPK4VANx4sNwEwSu85NSP5q0y9CjsTT1aj
	 qfVFUiTdIHfw6Hl3ILROSICqDmClX5CAjcnisQGLe1ozhZOSO5BIxHssoObVNYEd9t
	 ISMq9hvKty6IZJQX4eG1eQkgk7eO0ga38LUX0ARsSlTpNFI8fVHeNHi/dMl6Z+fMlr
	 Isd5/8qGnC6PbV1YNIl3H0kSXlVO8W81o6BT9sPQ/W/oO9v2/41oZ2tO3asiBBz0tC
	 9dtfPfPzQwv2Q==
Message-ID: <sashiko-outbox-218116@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/12] perf tests: Fix the Intel PT virtual LBR check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117025305.3958882-11-acme@kernel.org>
References: <20261117025305.3958882-1-acme@kernel.org>
 <20261117025305.3958882-11-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 03:04:06 +0000
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
> The record this check uses writes aux samples, and with the single data
> page the other tests ask for they are lost:
>=20
>   Warning: Processed 29 samples and lost 100.00%
>=20
> so no branches are decoded and the check fails with "Failed with virtual
> lbr".  Record with 4 data pages and 128 auxtrace pages: the same trace
> decodes 64 branches and still fits the mlock budget.
>=20
> Require the python perf module to provide session, not just to be
> importable: a perf whose python bindings are not found can pick up an
> unrelated module and fail with
>=20
>   Error processing events: module 'perf' has no attribute 'session'
>=20
> instead of skipping the subtest.
>=20
> Detected building perf on fedora:44 on the runner with Intel PT hardware,
> where the subtest failed with "Failed with virtual lbr" in the container,
> and with the python error when run as root on the same machine.
>=20
> Fixes: 915d6b14dc0c ("perf test: Migrate Intel PT virtual LBR test to Pyt=
hon API")
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117025305.3958=
882-1-acme@kernel.org?part=3D10

