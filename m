Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D4F38E5ED
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 04:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782878593; cv=none; b=GooH7It3rZf46vZnzZpfDV8WNlLDxDWhs0CkpnUypE4dhDjToTqVwAyDZExJczj5P+MBavs0vWr+18nTEVUOArdYE9xwHgxb784NdSaiJUI3efe2fBBchyefjzIMYUynKOly790owXv9OVd9u+fC/hwRznZquf63+Xq+Q6eSS9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782878593; c=relaxed/simple;
	bh=Bzbh//oNncA42fYgV21nNQ7GuX4D/uAakZe6Ygqs0QY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W1+iy1/QCIFhKPb7SzQ4bQkLife2LuCEfFCd+b+n56H2abXzuCqlq2E7hvRoAo5mQA31hFNxgAap24vMhkV5yrYMCtPzdzaKgyVEI8DG94iyM6rpTcE/BT1UOzbrnzcrHEfe3fzJqlh26MclvKdsm8IU/R6ZPQ6EwAm0hqzAKYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+kuEEeR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+kuEEeR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 197B11F000E9;
	Wed,  1 Jul 2026 04:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782878588;
	bh=hxJEqlQ3eGdIPvgtPmTJmFTENT/Q8RZCRSDZ/kls5Pw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X+kuEEeRkH0sePEgKrSv3JDmFgm8yl8uadfa1N3wpnxS6WCSZD0RBMSmPzb2bqdDI
	 LwmqFEEFaLlZ3JoLQElohzQiYVcBXAIfUqIUIvb5FnGN4UXU0v/UqS9luamqlu4RX0
	 OupSLvUzdick+W0zE7ibXk1DpFXAK9DxEZtVp0H3K31BrJNrsT8ytmBnLOSsMipMza
	 BIjmZfG9UB/GfSV5MTJrTqQUU3qqIUMLVLOXb5Cm3LmTPzeXI9ZN9JVhy51ekeRbK9
	 dUXvHeMtlBv/S9ssUDTOnHYF51vfpai4Kyab4H+sVeF4n5qPAyWde8WUT3QM9B8Cut
	 EfOtT12u3n9aw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/21] perf annotate-arm64: Generalize
 arm64_mov__parse to support more instructions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260701035355.752944-5-wutengda@huaweicloud.com>
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
 <20260701035355.752944-5-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 04:03:07 +0000
Message-Id: <20260701040308.197B11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The parsing logic permanently corrupts the raw instruction strin=
g buffer (`ops->raw`) when restoring the `<` character after extracting a s=
ource symbol name.
--

commit 13742d589ccf5a86dcfd0991f541a8f1d46f7e0f
Author: Tengda Wu <wutengda@huaweicloud.com>

perf annotate-arm64: Generalize arm64_mov__parse to support more instructio=
ns

This commit generalizes arm64_mov__parse() to parse source and target opera=
nds
for a wider variety of arm64 instructions. It utilizes arm64__check_multi_r=
egs()
to identify multiple registers while attempting to preserve parsing behavio=
r for
instructions containing the addr <symbol> suffix.

> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/=
util/annotate-arch/annotate-arm64.c
> index 33080fdca125f..a1667237114a6 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c

[ ... ]

> @@ -14,59 +16,129 @@
>  static int arm64_mov__parse(const struct arch *arch,
>  			    struct ins_operands *ops,
>  			    struct map_symbol *ms __maybe_unused,
>  			    struct disasm_line *dl __maybe_unused)
>  {

[ ... ]

> +	/* Parse a symbol followed by an address, if present */
>  	s =3D strchr(endptr, '<');
>  	if (s =3D=3D NULL)
> -		goto out_free_target;
> -	endptr =3D strchr(s + 1, '>');
> +		return 0;
> +	endptr =3D strrchr(s + 1, '>');
>  	if (endptr =3D=3D NULL)
> -		goto out_free_target;
> +		return 0;
> =20
>  	*endptr =3D '\0';
>  	*s =3D ' ';
> -	ops->target.name =3D strdup(s);
> +	s =3D skip_spaces(++s);
> +	ops->source.name =3D strdup(s);
>  	*s =3D '<';
>  	*endptr =3D '>';

[Severity: Medium]
Does this code overwrite the first character of the symbol name?

Because s is advanced by skip_spaces(++s), s now points to the first charac=
ter
of the symbol name. When *s =3D '<' is executed immediately after, it appea=
rs to
corrupt the ops->raw instruction string buffer instead of restoring the '<'
character at its original position.=20

This could result in a visual glitch in the fallback raw instruction view
where the first character of the symbol name is overwritten (for example,
0x1000 <sym> becomes 0x1000  <ym>).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701035355.7529=
44-1-wutengda@huaweicloud.com?part=3D4
