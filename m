Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9BB4CC27C
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 13:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788873329; cv=none; b=H4F1JXepZL3h58nkHr/dIoNaDdL7WaNpdlm6E4JksWG2TxESo0ukNNxvDYrJai2tpNVGtL4VHFf9WDeFFyO0Ge+yriWCuLVVuaeYHeIEZwlm4Yfwj2LRCIIHrXUYYi2l5x00HmLqTg9nVtfgp6Y4mWsUTqczDM2f7JstgUnv6bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788873329; c=relaxed/simple;
	bh=3bvdt3SE6dFN6sGuUqlZxek3UdWUJTu08KztEMKUhIg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qW43pY6DHWcNxOl4FOA6Gx4RTlM62GNUjNt3qglk/xHTUJMU+YiwXuRGfyp2EjrD71OZdc5Fw+u5V9/tZdkP2rtFvOIW1+c7pPCVc+gj3VrNtVt3YIEE87M1YCvsKpL1nKCznTxxlw2yK17b7WPwLbup6TGuBYKubH45TDc3DHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfGWKL+A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfGWKL+A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2B81F00A3A;
	Tue,  8 Sep 2026 13:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788873328;
	bh=TbODXt/DI30d5S3f5mveEeBdXz649rTkIyqoraKquFs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YfGWKL+AUBgIDNT+eDlF84dzDQ9zzrMO+eyyFh0mTjn3glxhuSobtlRpaD78FLNJn
	 h5BVjaH+pxF/W82erOI/TqifyuulTJuHoRK0BwJLuNMqshU2oma/WemWgPEo2COva1
	 KW+mWjpiKWHsN0074KabLkf0KyO7vzkGh4011lzxsCwQDy+9OPjT0gbTotP9EX1tO+
	 nYCRKvczt7VMdvQ3Q6iWEghQu64M12mMkwMQRYGmGSLCEfDbkq8cWGnW/AHRPD0h3P
	 1g1igz1gKfsdBR0yco2HCRuK1vfUtFhvA9LmHDyaYdGKjhwlzpkdGSpzXqDzG+Iy8V
	 bqN5/UO8Vvhmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/26] perf annotate: Adapt arch__dwarf_regnum() for
 arm64
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <723d0c1e1261cb5b38af7ed4fda9d26ae2986319.1788872630.git.wutengda@huaweicloud.com>
References: <cover.1788872630.git.wutengda@huaweicloud.com>
 <723d0c1e1261cb5b38af7ed4fda9d26ae2986319.1788872630.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 13:15:27 +0000
Message-Id: <20260908131528.0F2B81F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Currently, arch__dwarf_regnum() assumes that all architectures use a
> register prefix character (e.g., '%' for x86) defined by
> arch->objdump.register_char, and uses it to match register names in
> objdump output. However, this assumption does not hold for arm64,
> where assembly syntax uses bare register names like 'x0', 'w1'
> without any prefix.
>=20
> As a result, arm64 builds may fail to correctly recognize register
> names from objdump disassembly, leading to incomplete or incorrect
> annotation output.
>=20
> To address this:
>=20
> - Make the register prefix check optional, allowing architectures
>   without a prefix character to be parsed correctly.
>=20
> - Extend the delimiter set in strpbrk() to include the closing square
>   bracket ']'. In arm64 assembly, memory operands often use bracketed
>   syntax such as '[x1, #16]' or '[x2]'. Adding ']' ensures clean
>   extraction of register names like 'x2' without trailing characters.
>=20
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788872630.gi=
t.wutengda@huaweicloud.com?part=3D8

