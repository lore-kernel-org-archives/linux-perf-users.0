Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A013BFACE
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 22:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792189426; cv=none; b=VGBQjJRXTJKGcOvoc9D+DU+7NGADtOBZxpp0NZOU7psS7ZTJlezP8DqOhtK3GGF9uzKv9hgkSo5W01A4HUB1pjCbljDUBe+6LAJYJd9l+/efxMI5JNBE+Vyy5aVOfxtbq0IX3XNXG3a+nRRhpyHT0QzvQZ+ysedtxWgF9Bgo4BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792189426; c=relaxed/simple;
	bh=hBpUt0y80e0+SLh4NP5WlIXsoofCPM1fSXbvz5HYF3g=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Pi0ENIu9oOj//SOv76HCNXlQMVBUx3LvPXlU+rRwcni2kkgOvB03e7NC4yE9xzydUsMaGo866dTX12rmRWFVtG3u/hC4uBk5tTiHPtpjknfMFm3fcO0QXxJudEbe3DtCVYopka5HQ/FjoXeKhyeP+mRadaJfUf4SwWOKYL63rTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GDwkNEtb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDwkNEtb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037F81F000C4;
	Fri, 16 Oct 2026 22:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792189425;
	bh=hBpUt0y80e0+SLh4NP5WlIXsoofCPM1fSXbvz5HYF3g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GDwkNEtbG20ku4265RNTrFyAZzGbfnpfLbhq+rhNYChvFlWb6PnINPEuZ5ldsZX/O
	 QtHiP+r4IdMTQK1S5q3nyo68b9r4TZunGqqkvbo1U6cRxdoWfZQArC8QJ0Bfbsz4tc
	 zPVE70U+K81PtwKXrB9FDV3oiVBa1FBCwsRfL5WkdQqnLVyX/lsJVAV8aDBGYisvDU
	 hWgcOg6Phc9s1VHLtkwMLDvPO6TClQbaFN+1g+8lso/iBwMYbasP5Qbh1S20qN9Dlb
	 GP60lfNdL7qjlBDqcmciuH9ltRPib/uIocYnWhi2KudiNVItNeGKe9KY1h49jtzMvs
	 kJMFdNpIKpqHA==
Message-ID: <sashiko-outbox-175014@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/17] tools headers compiler: Synchronize
 compiler_types.h with the kernel sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016221700.1282659-3-irogers@google.com>
References: <20261016173106.679725-1-irogers@google.com>
 <20261016221700.1282659-1-irogers@google.com>
 <20261016221700.1282659-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 22:23:44 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Synchronize the non-__KERNEL__ sections of
> tools/include/linux/compiler_types.h and
> tools/include/linux/compiler-gcc.h with the kernel sources (including
> ___PASTE/__PASTE, BTF_TYPE_TAG, object-size helpers, asm_goto_output,
> ASM_INPUT_*, asm_inline, __typeof_unqual__/__unqual_scalar_typeof,
> __signed_scalar_typeof, __native_word, compiletime_assert, and the
> __diag pragma helpers required by compiler-context-analysis.h), and
> remove the duplicated definitions from tools/include/linux/compiler.h.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016221700.1282=
659-1-irogers@google.com?part=3D2

