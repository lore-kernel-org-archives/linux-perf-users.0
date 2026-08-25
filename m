Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A9E3CCFB4
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Aug 2026 06:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787640106; cv=none; b=a/aAhsluw1waLlR8vkE68wjtP6TNkqf/u0N8qhdRLu08tHLN9V87ZcMPJpbkGufvhlAxJpMiYlNAOB46eDxOYJHQyjyWXuzCfcBF0QavhryVeMZqZEGyf0o3o7PVRxa2oSCt1+Y4ML8+/kPh56fOdAOFA6oWzMfokwVJdRfbUi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787640106; c=relaxed/simple;
	bh=wyXwAnWMtHun0G8wMGpfWJg4W07d0tetLA/8P0EzqlU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YfxYZpS0v8md8Bjmk1roS8cNpJqL9WJcQqvUnDyFaPpL3sJjCf4w7lVB19l85b0D5de5aXl87TQ3iAvlnegnDs0m/LdErOU1+ndOAHPHurrR5Q9XXlatQ/9SIcl9TP/qjlxMGpmuEHUrRfhFMwIytg/zTv13STJSDhF/LFl7/bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIfhBPTb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIfhBPTb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6E51F000E9;
	Tue, 25 Aug 2026 06:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787640105;
	bh=nkEk0FyKtd/taYHpN90XWSAlyUmZe0PJ3g6SMheeCU4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eIfhBPTbf+MFT7N+gWIZLoN33VCI25laloZedDHHxc1SKpLg2W7OwxnCYCVq/eDoF
	 cAZ+u+6iFBxVS7IOE22stlEl08vdxTni0Qjd4UgXdotveEbeEwQB45YvD3GFnrHprT
	 DTcdjUZLQDY/VebiP/Z6TOawg+epp5aDkkJCdgQKIBnijE+aEB9Yz7eAA1+Il+iPUQ
	 bIqVJZ5uPf3QFF/uNTnBB4H9cxauZUyUCcsmIVew1ZMzn2KbN7fcSWlymf4VBMZtm+
	 K6C1LjShrbwNFluSD1RzEDuierlB8zsZTfYIjG39izwvs2IHV+RAEmvIdSZwQQEHFv
	 SW0htBaxtsxKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf symbol: Do not use debug file as the binary type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260825062345.115073-1-adrian.hunter@intel.com>
References: <20260825062345.115073-1-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 06:41:44 +0000
Message-Id: <20260825064145.3C6E51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch fails to apply the instruction trace fix to kernel mod=
ules, leaving them vulnerable to the exact same decoding error.
--

--- Patch [1]: [PATCH] perf symbol: Do not use debug file as the binary typ=
e ---
commit af2af0a33f456210f477b124b3165ecd7e50b2ad
Author: Adrian Hunter <adrian.hunter@intel.com>

perf symbol: Do not use debug file as the binary type

This commit updates dso__load() to prefer files that contain executed
instructions over debug-only files (like .gnu-debuglink) for the binary
type. It achieves this by explicitly favoring build ID cache files and
system path DSOs over previously discovered debug files.

Closes: https://lore.kernel.org/all/CAGH6UiG=3DRJLqBU3kLu9XJciPyPO1HZkbAPER=
guVUMRuWQgqf=3DA@mail.gmail.com/

> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 94f9c8faeddab..3587ad2431590 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1947,7 +1947,16 @@ int dso__load(struct dso *dso, struct map *map)
>  		if (next_slot) {
>  			ss_pos++;
> =20
> -			if (dso__binary_type(dso) =3D=3D DSO_BINARY_TYPE__NOT_FOUND)
> +			/*
> +			 * The binary type is used to find the file containing
> +			 * the executed instructions, so prefer the types that
> +			 * refer to the actual object over debug-only files such
> +			 * as DSO_BINARY_TYPE__DEBUGLINK.
> +			 */
> +			if (dso__binary_type(dso) =3D=3D DSO_BINARY_TYPE__NOT_FOUND ||
> +			    symtab_type =3D=3D DSO_BINARY_TYPE__BUILD_ID_CACHE ||
> +			    (symtab_type =3D=3D DSO_BINARY_TYPE__SYSTEM_PATH_DSO &&
> +			     dso__binary_type(dso) !=3D DSO_BINARY_TYPE__BUILD_ID_CACHE))

[Severity: Medium]
Does this new condition also need to check for kernel module object types
like DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE?

If a trace contains kernel module execution and the module's debuginfo is
cached in the perf build-id cache, dso__load() might encounter the
debuginfo file first. When the actual kernel module binary is found
later, the check above will fail because it strictly looks for
DSO_BINARY_TYPE__SYSTEM_PATH_DSO.

Could this leave kernel modules vulnerable to the same decoding errors,
where the debuginfo file is retained and produces wrong instructions
during Intel PT decoding?

>  				dso__set_binary_type(dso, symtab_type);
> =20
>  			if (syms_ss && runtime_ss)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825062345.1150=
73-1-adrian.hunter@intel.com?part=3D1
