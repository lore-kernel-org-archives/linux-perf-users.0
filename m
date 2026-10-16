Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A7522D7A1
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 00:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792110174; cv=none; b=lPAL0bRdvD1K/hPhgJTjojKg9ObYFz8roF2tK0n+Rcu4YfyzsMoe5N80vtIeDuyyHIvQyUWaolCKEROcuLIwPhP2bXg7T/16Pg9htRxoCjiV4VRhQVCOyNCb0SdY1CrJG3LW4v5VHPHpm0i1dNIPtU3Px2sQH4kYx0Rz8Ets5Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792110174; c=relaxed/simple;
	bh=MJrA/EsU8HfV0Z7QYjvUErqvEvRV1yFx/X3U4LSCFdM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ufWXgND1pworoAAwphFta33utlpTKkU6Urz6cMe++3Tcnv1z/zbVPlIVMJaaThdtDDuuxQyIr4x9obiXjnJ5bK1lFpH4V0Svj/A5Nui1Bug6h0Rr1fczAR7TwjUYqHDs2RjUcxambSx4Z1tcvBBwBMeGeZm9cOtx4k4548Gs0Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLqu8eg6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLqu8eg6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593EE1F000C4;
	Fri, 16 Oct 2026 00:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792110173;
	bh=NTnTZJqXFOrl1Zq5Y3URpVdm7ZYyYDU4rapoqlrCumo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eLqu8eg6nxH6UMTnsBPiVhNN6bjmAO66/WjK8g2Ka/ZEm40c4P4SwMFxdtWqx9DY0
	 zTqUD8MO8qJzl4Cf0Iww+WPHkkQLj7yBt8D8PZRukpHUiS+Bk9lfjc2CbAUW4Kt2tq
	 01te3Oya49djYhqYvOnM27yaFgzYeCCwCL2UVsYZ1fA3A5+YjAohC1kOqOW8mVC42x
	 H9T4kP0EE6HfFXhnqWhY0OPkp3/rYt2hRMm/7Q6r033yKJPfppfQ00jEhKN4Q2nm97
	 f4eMS50gUoBfekwXKNpIBeLAljDjC6SAhKjcAglZ4/M1r9IrW7T+l9VIx2jXHCt2PV
	 eErsphCW7xDEw==
Message-ID: <sashiko-outbox-173513@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/19] perf test attr: Fix record dwarf sample_type
 expectation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016001843.71978-2-acme@kernel.org>
References: <20261016001843.71978-1-acme@kernel.org>
 <20261016001843.71978-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 00:22:52 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Since commit bdd051e24914 ("perf record: Split --data-mmap option"),
> record_opts__parse_callchain() sets record_data_mmap instead of
> record->sample_address for the DWARF unwind mode, so -d/--data and its
> implied PERF_SAMPLE_DATA_SRC are not enabled implicitly anymore.
>=20
> As a result, --call-graph dwarf no longer sets PERF_SAMPLE_ADDR and
> PERF_SAMPLE_DATA_SRC, making the test fail:
>=20
>   expected sample_type=3D45359, got 12583
>=20
> where 45359 (0xb12f) is:
>=20
>   IP|TID|TIME|ADDR|CALLCHAIN|PERIOD|REGS_USER|STACK_USER|DATA_SRC
>=20
> and 12583 (0x3127) is:
>=20
>   IP|TID|TIME|CALLCHAIN|PERIOD|REGS_USER|STACK_USER
>=20
> i.e. the values differ exactly by PERF_SAMPLE_ADDR (0x8) and
> PERF_SAMPLE_DATA_SRC (0x8000).  The mmap_data=3D1 expectation is still
> correct as DWARF now enables record_data_mmap.
>=20
> This went unnoticed until tests/attr.sh stopped ignoring attr.py's
> return value.
>=20
> Fixes: bdd051e249141c79 ("perf record: Split --data-mmap option")
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016001843.7197=
8-1-acme@kernel.org?part=3D1

