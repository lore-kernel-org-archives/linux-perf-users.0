Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04E52DB7BA
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 05:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776923678; cv=none; b=H9QhvMhMTRj2nnS1fuLKe91kITYBT5ujgEUaZsijMlNNS1yOGChWNKa0Ujy+r816sRvaRRscqlwxAuCCAwA7pV1ZmlHVGjfKmaPIt/XO50G6PyofD6UEcteD/9wUpeCkhGqbskNvXQ0DVWx90UY49Y+fFUcbPiR/9d+CKb6Q3Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776923678; c=relaxed/simple;
	bh=jxgrPFZV4dk6kbnpWv/69+zAIR9BCwGIBhu79kQOgus=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Td8v/fLs9VP8JADvFf7SUQxgQLnlXN6WShvvwJKitJVSFOn8taYnZnraDKmozE9ez+bY4tqMDPfPN46RUw4+jIkLrYgZtHpvHgmg7zPKx6GY7dl+xhZ/5WJ/A6wqbZic2KAfxf3uEc6EAZnNm7d+hlKFBGFrbMqENS6QZ6TIeQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twd8WoeR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twd8WoeR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4599FC2BCB2;
	Thu, 23 Apr 2026 05:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776923678;
	bh=jxgrPFZV4dk6kbnpWv/69+zAIR9BCwGIBhu79kQOgus=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=twd8WoeR6MrGBwpBiSkhFhE9p4qh3DfGDeqk7njEiFHhVq0V6UrvkiN3d+hUxfDJh
	 HQ4yBXOawlNC1NcimOFeXBx5mny3MBkKvQmaOcOUVO78NlWSDSv5zvcI5+3xJguZ39
	 jTViYPZy55/yd5SRNXsMpqcT0Mw7Hhf35bLp+/eD5f7HIQN3jRshMjVNz+FIJuP/RF
	 t7bE41deCJYF5THo9mHxye089Zvof5FSWd5KCRJlrY/GytLktJmbsGYH+HQaMcPwgr
	 U/4XOYAkjSOWCnBSxxRj223+YRrX1Nge4S0H//QBg9PHfTn1VY54mgMkPcHA1drbdx
	 rgC9MQu5M7OyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf annotate: Fix NULL pointer dereference in
  loongarch_call__parse
Reply-To: sashiko@lists.linux.dev
To: "Jianping Liu" <frankljpliu@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260423053102.3717015-1-frankljpliu@gmail.com>
References: <20260423053102.3717015-1-frankljpliu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 05:54:37 +0000
Message-Id: <20260423055438.4599FC2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] The fix correctly prevents a NULL pointer dereference, but impro=
perly aborts instruction parsing by returning `-1`. This strips the `is_cal=
l` attribute and degrades `perf annotate` functionality, whereas it should =
bypass name extraction and resolve the target using the already extracted a=
ddress.
--

commit 807b803f1f78132524dc6117283161821fab508a
Author: Jianping Liu <frankljpliu@gmail.com>

perf annotate: Fix NULL pointer dereference in loongarch_call__parse

This commit prevents a segmentation fault in loongarch_call__parse()
by adding a NULL check for the return value of strchr() when parsing
objdump output. It handles cases where a branch-and-link instruction
lacks a symbol name.

> Add a NULL check for the return value of strchr() before dereferencing
> it, consistent with s390_call__parse() which handles the same case
> correctly.

Does s390_call__parse() actually handle this correctly without regressions?

Returning -1 causes disasm_line__init_ins() to receive a negative return
value and set dl->ins.ops =3D NULL. This makes ins__is_call() evaluate to
false, meaning the instruction completely loses its call semantics in the T=
UI.

> diff --git a/tools/perf/util/annotate-arch/annotate-loongarch.c b/tools/p=
erf/util/annotate-arch/annotate-loongarch.c
> --- a/tools/perf/util/annotate-arch/annotate-loongarch.c
> +++ b/tools/perf/util/annotate-arch/annotate-loongarch.c
> @@ -29,6 +29,9 @@ static int loongarch_call__parse(const struct arch *arc=
h, struct ins_operands *o
>  	ops->target.addr =3D strtoull(c, &endptr, 16);
> =20
>  	name =3D strchr(endptr, '<');
> +	if (name =3D=3D NULL)
> +		return -1;
> +
>  	name++;

Could this code bypass the name extraction and proceed directly to symbol
resolution using the already extracted target address?

Since ops->target.addr is successfully parsed right above this check,
skipping the name parsing and returning 0 instead of aborting with -1 would
preserve the is_call attribute. This would allow the TUI to still draw
branch arrows and navigate the call.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423053102.3717=
015-1-frankljpliu@gmail.com?part=3D1
