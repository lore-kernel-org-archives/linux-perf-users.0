Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794841712;
	b=BMiT/CxdK/T+ge028/L1RGBXboa857FTBTYsccmMfxkdNnWB75BcBC2e0elgf8aj6J7+
	 JC7OA1zgXXJmQAP9cUADg4+8fnH3nhKCbPszsac55+Xh+VD1NZo5j0YjY2/o2wltl5Jy5
	 NCJ2zqXUA4nZMABblTAoLgc3o/kk6w7r6Ew6IBJsXHDIN4hkSTFYPr6JKGeNnS0NB8IRr
	 vtHEgeDvDzcvKNRsmNQfUMQWBzoi5Uxzt+jG4dJ+VvalPTdlhin9eSznnimrhS/ycCgib
	 bwQSGHb8eZ1P6t5DEo2do55YSnFIDNEluv2IZt9RhzZUkBFYkx4gvW934L2viJI/Sjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794841712;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WQB2xIRiDGALmcCFIrmT60e1Vu6trxDSVDW20dXt4ww=;
	b=dHgPNCnB/FO0azWdCKq/rZJg61fAQk1xf/mRjiO86p1e3fAmDL30uu37fCKORDIAlxSn
	 6T+ECHE/mZuU47bFYWWOg7ldZBUeAqowdVi19sfC8Mqu9SO8ncHvOz+LGE+0+Obmd5OuF
	 QTehytUePfDnsbb43OM0gZQSez201DQsHLnzTKFfnOw+SP95oqP/tI8AXz9JipD9N7afm
	 i08NOtojMEvUPPaIiLG3Xqqt3wZqabR7mZYzMEsIqgNnRGXxtPentDEcEgPmZMLUUpLkL
	 OpiL+qLrKf8n5ZJsTA6aTo3fW/DPbvCK2tud6QksyTsQV/1GUZEEiasjKuQ5l5wZrtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ol8oqPhb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96D6606A32C
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 15:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ol8oqPhb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0E11F000C6;
	Mon, 16 Nov 2026 15:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794841712;
	bh=WQB2xIRiDGALmcCFIrmT60e1Vu6trxDSVDW20dXt4ww=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Ol8oqPhb+hrDBlstfmqt1LyJcKZ0ppJJpkGJKJYfUcytSMAWallsb2V7jB5HNK9As
	 0S142EX2GmZVHEIy0AVZYclIOuCt4FyE/DYzt/6wvPu+a6jsak+q1aMBMo10ATVuSl
	 kirxd2VRd0qxlYBnYY8A/VFR55CCKf4+qkXyMSN92ni/cOVaJ5fvn/DfCXaNZyeneK
	 MiAUnYzuiIIv1ydiv4g5toHYpjEcJuHEB0ILHj482aT2HYHhTWEc2GhVEdG4/Kk+rm
	 bXEOsZICU16ftjuvHUGcUxGc64UAmDN6LDby5lbCDwgotUMgCl28MFacUcBwlfQotG
	 tws0y36vhIFTA==
Message-ID: <sashiko-outbox-217233@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 12/12] x86/msr: Simplify some rdmsrq() use cases
Reply-To: sashiko-reviews@lists.linux.dev
To: "Juergen Gross" <jgross@suse.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261116150208.1572254-13-jgross@suse.com>
References: <20261116150208.1572254-1-jgross@suse.com>
 <20261116150208.1572254-13-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 15:08:32 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> After the conversion of rdmsrq() to an inline function some use cases
> can be simplified by dropping an intermediate variable or by
> eliminating the inline function completely.
>=20
> Signed-off-by: Juergen Gross <jgross@suse.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116150208.1572=
254-1-jgross@suse.com?part=3D12

