Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AE8285041
	for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 07:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775978239; cv=none; b=UM5WAvBLk140v7W0XXJXZDlpbCraJypPKHsPJMemaJx8TUhGKJXX/xSmGaqr+ta6kf5545nzsmeAvf1Gxtfy1QZqJlManRUH+vALNjSrP5k1OJpW/gQs4JljSYvLDCX/tFAnOKU4pAdMRSjT5KwcVAkys29bRARRIVUugIJBAcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775978239; c=relaxed/simple;
	bh=5GU+4swrEcqlTUv9EUuVLFuE8isb3JU7mQvQjX0zrC8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jII+/oc/1XAYBxhTXCIHITtggdZSYiAbTQSTNfKrUZbm1N+v4OHWjPBuvCggvGRXt3f6v0gR+imio3VM8K3mFowBc07oDYMFeGnFYDd96fTFiLWUgUDlih9r2Z3MFNytj4zbGrdqZRYln3y3l33gROKWSH4zWEs+6cUWj4lvWFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcnPcv+Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcnPcv+Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B339C19424;
	Sun, 12 Apr 2026 07:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775978239;
	bh=5GU+4swrEcqlTUv9EUuVLFuE8isb3JU7mQvQjX0zrC8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=bcnPcv+ZxUjhMQFMHYCwKTgwE+w3uJocU1HbeaG34BsTcwE9s3Xr1rOCEa87Smd8R
	 J0Un1ZVHoHpQCowInr5jdjtx9bGtSwF1b8K4qigb763/93AIo2aUSaaO/U1NDGv+QX
	 LywV+msY7C7vfiE8M3annbbmlVn3vxbayWKvB7V8LwQgByFh7mRqwt4IYUiP1LlUv8
	 PQwx7KyqUXghRky9qKJLA9R2NXv3zNc4kIFg5YJRhtEXN5futMJXv/y93QKBMV1Uec
	 VUfd82XAo8L5y3hj7Rc/WWnwREwqNqXGJZZpDtKL1s1A/Dr9Ih8s/h0yJmoXpmp564
	 auFPu7sIT9XDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf annotate: Use jump__delete when freeing LoongArch
 jumps
Reply-To: sashiko@lists.linux.dev
To: "Rong Bao" <rong.bao@csmantle.top>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260412062828.1734637-1-rong.bao@csmantle.top>
References: <20260412062828.1734637-1-rong.bao@csmantle.top>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Apr 2026 07:17:18 +0000
Message-Id: <20260412071719.5B339C19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] Missing NULL check in `loongarch_call__parse()` causes a segmentat=
ion fault on malformed or stripped objdump output.
--

commit 031fe3089ac82ebce8ac1cc8c2f144a5b6abd009
Author: Rong Bao <rong.bao@csmantle.top>

perf annotate: Use jump__delete when freeing LoongArch jumps

This commit fixes an invalid free crash in perf annotate for LoongArch by
assigning jump__delete to the .free field in loongarch_jump_ops. This preve=
nts
fields that share the same buffer from being erroneously freed during clean=
up.

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

[ ... ]

While reviewing these changes, I noticed a pre-existing issue in the nearby
loongarch_call__parse() function in the same file:

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

Could this cause a segmentation fault if the tool processes a stripped
binary?

If the objdump output for a call instruction lacks the <symbol> suffix
(for example, bl #0x12345), strchr(endptr, '<') would return NULL.

The subsequent name++ would then produce an invalid pointer, leading to a c=
rash
when it is used in the following strchr() and strdup() calls.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260412062828.1734=
637-1-rong.bao@csmantle.top?part=3D1
