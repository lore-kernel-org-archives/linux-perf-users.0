Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9FB4A6CDA;
	Thu, 17 Sep 2026 23:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789687330; cv=none; b=dmIBiHFXX1XW8X3QGFVa/aNGaoQk/OPuhQR9d4KXUCZ8UD6VIYBWMzZKIhlbsWQTYuNU+v19YfpangowwYunO8L8y5NeWMkz3Jolgfp+n0sPA6HUFH+ISIuIwJuDz6T+kFiqKdQ+Ob5ihCm1h3TBN4iogMDjN35IJ7LYTWMJHJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789687330; c=relaxed/simple;
	bh=9BYofuYdoG02ChNEzExDrydfDWBM2MHN6UA/5FNdHGc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GlM60eep+YmbZj2tl4X8780PCo8f373Km6HRwa0ySD2qeCYHRERrcEgu16fJZ9n4Mzszn5+mVKc20Jvp4K01Zlmy0Lhhqeu5dmbzAoUKbHrP1uDdLHmkimi/a0RPx+p8aTBDT7Y9C4rBntcQwT6jCj/jTB4E1ee8VlEaclJ5sbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5yIDbH1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5yIDbH1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2611F000FF;
	Thu, 17 Sep 2026 23:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789687328;
	bh=yyhbCGPKsPF6zhAYHJ4zMePGvKb+inSdj6+aNdDH5gA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j5yIDbH1z/3TFnTIDyRCczMRahSPVM8/hXqrNsNgx+ajIgtXYKrfNLoNSDzz3m1Ez
	 6amIcIh6wB3AeqG0SnTI+QBGOXz/abDB72os2Kgczi7gxw1QQbAVd0GXr9wU6/tkIs
	 9Pwbz+UYrMmD1cMIxp5U2MWDW3vf1r7kO+tYGTfTUxO0p5uaEEXlGLeZHTy6IUi5hm
	 KryXuIQXfSD5RZzaugI6bqXld5Xj8bsBrvpDlvIXERGOnVe6/+nX4mBV0U1mJkMviL
	 Rk0U4cueh33nFP4tmfDx5hYVFE+5HOh3doTzoTzmV1fuT27mwNpPgOAOip1g92PII1
	 zpcVylKNjbYxQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 07/11] ptwrite uprobes: Add multinop support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260917230127.924985-8-ak@kernel.org>
References: <20260917230127.924985-1-ak@kernel.org>
 <20260917230127.924985-8-ak@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 23:22:08 +0000
Message-Id: <20260917232208.9B2611F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] uprobes: unused ft_off and nft fields in uprobe_ptwrite_arch
--

commit 45ecb87404a0455ddedb4d1415f99bbe867523b6
Author: Andi Kleen <ak@kernel.org>

ptwrite uprobes: Add multinop support

This commit introduces support for a %multinop feature in ptwrite uprobes,
which allows users to opt into patching five one-byte NOPs emitted by GCC.
It updates the ptwrite stub generation and the trace_uprobe parser to
handle this new argument.

> diff --git a/arch/x86/include/asm/uprobes.h b/arch/x86/include/asm/uprobe=
s.h
> index e5a668ba5ad6c..c46b3fe090253 100644
> --- a/arch/x86/include/asm/uprobes.h
> +++ b/arch/x86/include/asm/uprobes.h
[ ... ]
> @@ -49,6 +60,9 @@ struct uprobe_ptwrite_arch {
>  	u8	jmp_off;	/* offset of the final jmp's rel32 field */
>  	u8	ndata;		/* number of u64 data slots */
>  	u8	orig[MAX_UINSN_BYTES];	/* pristine file bytes, before generic analys=
is */
> +	u16	ft_off;		/* fault table offset within the block (0 if none) */
> +	u8	nft;		/* number of fault entries */

[Severity: Low]
Are the ft_off and nft fields necessary? They appear to be completely unused
throughout the entire patch series after being added to struct
uprobe_ptwrite_arch here.

> +	bool	allow_nop_run;	/* accept a five-byte run of 0x90 */
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917230127.9249=
85-2-ak@kernel.org?part=3D7
