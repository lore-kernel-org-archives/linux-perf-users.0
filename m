Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D80B36CDE8
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 19:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788205549; cv=none; b=EMOqSnmW548v5Fm3cimVMfr8ljjW+bw32XKpdheTy6UNG4VIpx8G14j/GXoJUSf1oETNvXSC2auwrMphi5PWfnmQ7hfEMDH61eIEOc7BsmcHPHi8BUGUHeJn/XbWe6F82Q6Ib78nDTSxUATx59HZUr2w37sVzZPwYjrhO542tQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788205549; c=relaxed/simple;
	bh=e7L7o793o71wULfyesSoFX4cw8Tjqqpavaz8k2qF0G8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tHOnh6qsXBiuvBLTA7DNzbFsnTr06gnyNvCCIQTudFCJqD6T31Il1NVRH+DNdxSzQtaKkqIA2nUQVWyVhmAqSf4IW20jdOQUjiVzr2WI8DjBfb746rj65XdB4dx+c+d/ixswnzyYj+PNhINH9NMbGfQ/bWwZUlv8N57vMooHlHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFBv9E9p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFBv9E9p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906771F000E9;
	Mon, 31 Aug 2026 19:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788205547;
	bh=mvF1Xkcva/0PE9dJjgXvJOhfWS/HQXlut81KZyP3Spc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cFBv9E9p6Dcqva7BbZ8+WBC9f3+W+e/KKYA0JywQA9gJYS/xLIIypO7YIyuJUZDWx
	 2Zfi31o0O+gvP8hJWue/dm5DdcmVb/Jabdts0c7wa2jzJevgyuh4eHE+sqBW96J/Kz
	 nbuKE+dlVsB0tKW85tf+0lq1SDl3AjH90auTJ4XcgU8jIzxHpxKzBBU3m0+WQTVhSt
	 2tRwUhs8xJVnUZQconeY/kig9T9I894r+Gmfd/9Ie+1Dac8XDrJo4P/AkQeXhU8oyl
	 YIbYZxLRWCFPkN1a+Ig49SGT1gzHjpmPjm0txQM0u6CYgljw1ofcEvggovwNqL6RNM
	 DsWNHLPvpBpNg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC v1 09/19] ptwrite uprobes: Factor file-backed instruction
 reads
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260831150651.1134594-10-ak@kernel.org>
References: <20260831150651.1134594-1-ak@kernel.org>
 <20260831150651.1134594-10-ak@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 19:45:47 +0000
Message-Id: <20260831194547.906771F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] copy_insn() unconditionally returns -EIO for partial reads, breaki=
ng uprobes placed near the end of an executable.
--

commit 357913ae591e42b1fd264a2ff741868c174c2724
Author: Andi Kleen <ak@kernel.org>

ptwrite uprobes: Factor file-backed instruction reads

This commit refactors copy_insn() into a more generic uprobe_copy_from_file=
()
function. The existing copy_insn() is updated to use this generic version,
which is intended to be used by later patches.

> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 23202df2b51ae..20fa16ed85198 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
[ ... ]
> +int uprobe_copy_from_file(struct inode *inode, struct file *file,
> +			  loff_t offset, void *buf, int size)
>  {
[ ... ]
> +	while (copied < size) {
> +		file_size =3D i_size_read(inode);
> +		if (offset >=3D file_size)
>  			break;
>=20
> -		len =3D min_t(int, size, PAGE_SIZE - (offs & ~PAGE_MASK));
> -		err =3D __copy_insn(mapping, filp, insn, len, offs);
> +		len =3D min_t(loff_t, size - copied, file_size - offset);
[ ... ]
> +static int copy_insn(struct uprobe *uprobe, struct file *filp)
> +{
> +	int ret;
> +
> +	ret =3D uprobe_copy_from_file(uprobe->inode, filp, uprobe->offset,
> +				   &uprobe->arch.insn,
> +				   sizeof(uprobe->arch.insn));
> +	return ret < 0 ? ret : ret =3D=3D sizeof(uprobe->arch.insn) ? 0 : -EIO;

[Severity: High]
Does this unconditionally return -EIO for partial reads near the end of the
file?

When registering a uprobe on a target file where the instruction offset is
close to the end of the file (where file_size - offset is smaller than
sizeof(uprobe->arch.insn)), uprobe_copy_from_file() will stop at the file
boundary and return a byte count strictly less than the requested size.

The original copy_insn() loop stopped reading at EOF but still returned 0 as
long as no explicit error occurred, allowing partial reads to succeed.

By enforcing a strict ret =3D=3D sizeof(...) check here, will this fail upr=
obe
registration for valid instructions that happen to reside near the end of s=
mall
binaries or scripts?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831150651.1134=
594-1-ak@kernel.org?part=3D9
