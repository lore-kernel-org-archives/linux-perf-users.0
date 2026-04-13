Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B22243387
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 10:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776076520; cv=none; b=A+MyNqTKOgHZ70gZPgevR3Ldg5QwPDa9KQa9GwoDmBSRUkyHIV9R8s1Dm8Xk8pDCq/R5JrgES3K/nR7lb9KpSjhF/b8jJp9o7sFb2t5sexfzs0+M1VYnjTEkDgNXtd4qyexnXcWloSJstZbxZyo83eC4AwNBRqGihe1cJq09I2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776076520; c=relaxed/simple;
	bh=VxeRTwOeE9iTANfzV42xcgg1cY1nHO5xJF5vF051I1M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c+HboRC4E4VwXUQ9Mc1YZt1xStBLOjFyF+gVhRP96K5wCAFf/72YFsL2kLSOJqpops2d175ZSGFBWb3IvG3BaOcSIeG1RioE+nSUvklRYUAyNMux3T4wrLTASMWKCWrq90YYyIPzf3I2w76jnedKT8rfjYgVB8TnLT6dzpYZhjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIEOyX8c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIEOyX8c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96751C2BCAF;
	Mon, 13 Apr 2026 10:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776076519;
	bh=VxeRTwOeE9iTANfzV42xcgg1cY1nHO5xJF5vF051I1M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=HIEOyX8cUN2DRAf2UZ8P6EBp0ZXcm13jXiAi15EPgaFnkxY++zO+1w4QmCaY1BuSy
	 5Ap9EyJNnxo/Z/XzZZD54OLYQvCxjIWH7prhnZCPvgryp69IyZ4eOBJZAHqHBzhpiX
	 aga1IoRT5wGrE4EyHzyi4clGFSMHT3doh8L0fo/GcDXau5eZwQh9VHEQ+MeOd/775v
	 tHOSwgQR8wHijUQcmZvYvUd40d51NhojlegghCMBGKJVPcava9hHs9Js0p4B/I94/a
	 aUhIWe8xDybsdnwD9Jzwd5E8597V6FCBFlMow07Wtx/a/ulCVSJOsBOk7MWKCCrbVP
	 IOzBD1IpF9Zmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf annotate: Use jump__delete when freeing
 LoongArch jumps
Reply-To: sashiko@lists.linux.dev
To: "Rong Bao" <rong.bao@csmantle.top>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260413100412.2313688-1-rong.bao@csmantle.top>
References: <20260413100412.2313688-1-rong.bao@csmantle.top>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Apr 2026 10:35:18 +0000
Message-Id: <20260413103519.96751C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] In `loongarch_call__parse`, missing verification of `strchr` retur=
n value causes a NULL pointer dereference if the objdump string does not co=
ntain '<'.
--

commit aaedf6d99ebecdf735574de2bae5e0ee0fc41c3f
Author: Rong Bao <rong.bao@csmantle.top>

perf annotate: Use jump__delete when freeing LoongArch jumps

This patch initializes the .free field in loongarch_jump_ops to jump__delet=
e.
This prevents disasm_line__free() from falling back to the default cleanup
function for LoongArch jump instructions, which previously led to undefined
behavior and a crash.

> diff --git a/tools/perf/util/annotate-arch/annotate-loongarch.c b/tools/p=
erf/util/annotate-arch/annotate-loongarch.c
> index 950f34e59e5cd..c2addca77320b 100644
> --- a/tools/perf/util/annotate-arch/annotate-loongarch.c
> +++ b/tools/perf/util/annotate-arch/annotate-loongarch.c
> @@ -110,6 +110,7 @@ static int loongarch_jump__parse(const struct arch *a=
rch, struct ins_operands *o
>  }
> =20
>  static const struct ins_ops loongarch_jump_ops =3D {
> +	.free	   =3D jump__delete,
>  	.parse	   =3D loongarch_jump__parse,
>  	.scnprintf =3D jump__scnprintf,
>  	.is_jump   =3D true,

This isn't a regression introduced by this patch, but in this same file,
could loongarch_call__parse() cause a NULL pointer dereference?

If the objdump output represents a call without a symbol and lacks
'<...>', strchr() returns NULL, but name is immediately incremented:

tools/perf/util/annotate-arch/annotate-loongarch.c:loongarch_call__parse() {
	...
	ops->target.addr =3D strtoull(c, &endptr, 16);

	name =3D strchr(endptr, '<');
	name++;

	if (arch->objdump.skip_functions_char &&
	    strchr(name, arch->objdump.skip_functions_char))
		return -1;
	...
}

Would this result in an invalid pointer and cause a crash when passed to
the subsequent strchr() calls?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260413100412.2313=
688-1-rong.bao@csmantle.top?part=3D1
