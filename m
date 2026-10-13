Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1749854774
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 00:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791850083; cv=none; b=jrHKn90TglCKp2TdJr1aw/LJy/JdJ5jCmugR2Yw3RF74pOXQc91jtbHcHOCnidfVMT2BY29eNC95lXPV0hZ6um258brBg+v/71nVjnBg4wNCfN2T4uhEdhXxRLToJkkGrTQFH010UMtZqtp8N+PnzG9QKGS/ctXd/+2TsGUUabw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791850083; c=relaxed/simple;
	bh=67qeohyA08vxlnllcjnBTK6cl5RiSiHu1d919SWSd4Q=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=sPgfQtfkooH9sMxvKWg0lgiXOoT/7tJGdx0jvs1eAAJSg67G/MnKLn5xjSV1aakN/WAtUXaQhdimj3ia5OG7luyawovFWq4/MNBXavXSvgMr6C/Z0RvUzqA0zlTqaJheIBdoITN1OtU/zFlCLl2kErvePkFs5aLtzSKm2TIDBYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nErhdLQd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nErhdLQd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A031F0089B;
	Tue, 13 Oct 2026 00:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791850082;
	bh=2kJJ+MfiVigV7RSnvwYMpI+O7p990gxs1y7eu7HSthY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nErhdLQdulhhKRSawNI+LRZeemOTDh+MJ/2q1idwmedq9v5zhPXeznThlxyaXGLmh
	 S5ZjJ2sEUjfK5Y+wObebc2YkCM7zlFzU9A2nWhHbeuiB6YlkN4tL6uT0aKh88E0Df6
	 r5yVhT8OskTBFAuUhVz5/JGPxmt0frl4qyQao2zSv40CKO4Uv0JzRwb7dhbR5NItOk
	 KqyhLnTlE06fYk+fFtw5Um9igri9yExmzRzK8p3bC5M+76SAutz/0S7H/SaX2Nk6P2
	 tjVRduKMafberpwUE8BGPcAM5EoTz4OyCMdkL/AWFtadXJAkH2SvpJ1/yiOk0ReaiA
	 yifOo6wRYBv8g==
Message-ID: <sashiko-outbox-168776@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] perf symbol: Set dso symtab type for libbfd
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261012235938.87912-3-namhyung@kernel.org>
References: <20261012235938.87912-1-namhyung@kernel.org>
 <20261012235938.87912-3-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 00:08:01 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf: missing dso__set_binary_type() initialization for libbfd b=
ypass
--

commit 3d059164c2c17ae3b0ec344af1e8527af000eee5
Author: Namhyung Kim <namhyung@kernel.org>

perf symbol: Set dso symtab type for libbfd

It missed to set the dso symtab type when the symbols are loaded by
libbfd.  When it happens both syms_ss and runtime_ss may not be set
and won't call dso__load_sym().

> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 4878d4292eb85..a90ce714b174b 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1925,6 +1925,7 @@ int dso__load(struct dso *dso, struct map *map)
>  			nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
> =20
>  		if (bfdrc > 0) {
> +			dso__set_symtab_type(dso, symtab_type);

[Severity: Medium]
When dso__load_bfd_symbols() succeeds and we take this early return path, d=
oes
this code also need to set the DSO's binary_type and cross-platform
architecture flags?

By taking this goto out_destroy, the rest of the DSO initialization loop is
bypassed. This leaves the binary_type as DSO_BINARY_TYPE__NOT_FOUND. Later,
when dso__data_fd() attempts to read instruction bytes for perf annotate or
Intel PT decoding, try_to_open_dso() will restrict its search to only
BUILD_ID_CACHE and SYSTEM_PATH_DSO since the actual discovery path wasn't
recorded.

Additionally, bypassing dso__load_sym() means is_64_bit won't be set, which
causes it to incorrectly default to the host perf binary's pointer size. Th=
is
breaks cross-platform analysis of 32-bit files on 64-bit hosts.

>  			ret =3D 1;
>  			goto out_destroy;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012235938.8791=
2-1-namhyung@kernel.org?part=3D3
