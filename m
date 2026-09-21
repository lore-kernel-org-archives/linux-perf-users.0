Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34214E0B79
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 16:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790009862; cv=none; b=gu3S8aItVMDpSDTcuSOJW+Kf2k2Pem/b5UlslzohRCbjdilcxMhoJW1+0454RwMM3VQRfHwRmTkaZ5toxHCVzYkmuyLRP3thIN+11hZ56whuOCamweInf4CPp6HC48NQWVf/0NQfULuyysLfh/5H+InP9y+R/ng8rTKzhdTSLWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790009862; c=relaxed/simple;
	bh=2sarrSBAIEqgdnf/fTDFDvLaabIWjXGrYdgtEiL3klU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BL41bGYDG0b/pEDOQ2Jc9kXypkGUbuKiSJr9xOrpUnlT2f9kYcO5MVvUOF3XQr1ANpqkIYGDZz+uf9his94s1H9yngdcmxoVFeHLI5IJRDMMHFrG7CCD65mLzjJogo9/B9nPMtoONRM10ETqpjbsNv94Mq2d49cM9JZvI25Vphk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5Q5C8Vi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5Q5C8Vi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FFEA1F000FF;
	Mon, 21 Sep 2026 16:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790009860;
	bh=2sarrSBAIEqgdnf/fTDFDvLaabIWjXGrYdgtEiL3klU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K5Q5C8ViXZUHwnN5HrUn64tA84OpWocyb+vXQRg5GZfWV80WD8b/pFsn6NTCE8RtE
	 lEDrmWIrEknq61o7BEcILOmgkdkLSLDxPSvLZ09l3eQWgd+4465idp+bbR55UPE9vu
	 RBdbWZswWABwDszGo1+uacY05snp/qFQKWC1Daw3kGOobxqMrUutm4XEZ5K55RBNSD
	 mDPoMPukW5OwCidi7KQpBHQMMCcEtA2Q9hFXw20E2Lgfnxh6cEf1iJy+DeiiJt0sNU
	 RGCMtyU8+2WYlD+Tz1S9/oWHl/5PWHVhqUQkE5Hyo/kHZi5vOZhcTxrLT5ws6e2cIg
	 yiARorx7dDyow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/7] perf annotate-data: Resolve type DIEs in the debug
 file they came from
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260921164813.6727-4-acme@kernel.org>
References: <20260921164813.6727-1-acme@kernel.org>
 <20260921164813.6727-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 16:57:39 +0000
Message-Id: <20260921165740.2FFEA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> 'perf report -s type' hangs, burning all of a CPU with no output, when
> resolving a hist entry on the dwz compressed debug info of libz.so.1
> (zlib-ng): die_collect_vars() saves the dwarf_dieoffset() of the type
> DIE, which is relative to the file it lives in - the dwz alt file for
> the types shared by more than one CU - and update_var_state() resolves
> that offset in the main debug file, where it parses whatever is at that
> offset, here a typedef whose DW_AT_type refers to itself, making the
> type chase spin forever.
>=20
> Record whether the type DIE came from the alt file and resolve the
> offset with die_get_type_die() in that file, with no fallback:
> resolving an alt file offset in the main file is exactly the misparse
> above.
>=20
> Fixes: 06b2ce75386df04b ("perf annotate-data: Maintain variable type info=
")
> Fixes: 55ee3d005d62279d ("perf annotate-data: Add a cache for global vari=
able types")
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921164813.6727=
-1-acme@kernel.org?part=3D3

