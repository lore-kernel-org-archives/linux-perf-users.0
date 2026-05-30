Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D6E1D6BB
	for <linux-perf-users@vger.kernel.org>; Sat, 30 May 2026 00:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780102041; cv=none; b=n16oWDx0Hnm6bNI0Mz1KGyN9G/xfToGLhmT+IrYCrH7FQJWs3kQGB1YRRQdV1K6S+a3cxK75GFMZvV/GmKcN3eq1BfVKiGExKoRxCXrU/UEjO+djfGxj4ARBLAzi4H5NoeMHGhvONP6Tj9UFXwrplTfINhOtk3NugKYvx+to7Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780102041; c=relaxed/simple;
	bh=3j/YF+i7X4N39rlK4vcdt46CD/4X8lvCuSMmtdiYHFE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UXHAJz8F9VN9oNfDFur2eGmykozVDHDuYAcWfqV/LYnakUdzEjAVTttDhXKpynqfuWdu9b9xS6sfAWyg8XfFbpTE8K1V9alm6dkDAOXVSCVYnRQ/D2jM+4hahvAJ629DXBBHvXbVvNZhYXhy4wJJrU8OOGOutCS1XRHrrBuXBmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBopBoyG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBopBoyG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCD91F00899;
	Sat, 30 May 2026 00:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780102040;
	bh=3j/YF+i7X4N39rlK4vcdt46CD/4X8lvCuSMmtdiYHFE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YBopBoyG8amAypT5q9PYCzA+3FA6HGf0DZQRX8Oo8ciMcBiYwzsrpyTxtLfEXBc+j
	 wzx4EmWWVrPMSKhZ7jlN45g6OQIwT4o96EUIlV9g2yf2amEpwl/j0Ah5i84kwWrAIn
	 nnaDbfCqVDEd935DWNONou3RsHjy0BsiCmq167Egvui+F4uFcJc7wrbN6Yrf2CGljN
	 YLGEFS5I4geQhZ3HO3ltqYnGCS4ZE91Zu1zRTErQF9xcBYPR9fiILG82jwAo0S+Izw
	 WR3b17J7iFgd4Wv7fjMLgOwGDD+SS7bfmZ8OG+18zDnb34q4FyDOWwf7QL9zyR/a+U
	 Mmed1pwNYqYDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] AF_ALG: Document that it is *always* slower
Reply-To: sashiko-reviews@lists.linux.dev
To: "Demi Marie Obenour via B4 Relay" <devnull+demiobenour.gmail.com@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260523-af-alg-harden-v1-3-c76755c3a5c5@gmail.com>
References: <20260523-af-alg-harden-v1-3-c76755c3a5c5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 00:47:19 +0000
Message-Id: <20260530004720.1BCD91F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The updated documentation incorrectly claims that AF_ALG no long=
er supports zero-copy and is always slower than userspace implementations.
--

commit f8743e2c044cc9e325ac113d7556afdf2c4c58d9
Author: Demi Marie Obenour <demiobenour@gmail.com>

AF_ALG: Document that it is *always* slower

This commit updates the userspace interface documentation to assert that
AF_ALG is always slower than software cryptography. It modifies the text
to state that zero-copy support has been completely removed from AF_ALG.

> diff --git a/Documentation/crypto/userspace-if.rst b/Documentation/crypto=
/userspace-if.rst
> index b31117d4415dd..ab93300c8e045 100644
> --- a/Documentation/crypto/userspace-if.rst
> +++ b/Documentation/crypto/userspace-if.rst

[ ... ]

> +Nowadays, AF_ALG no longer supports zero-copy or off-CPU accelerators.
> +Therefore, it is *always* slower than an optimized userspace implementat=
ion,
> +even for large messages. The only possible advantage left is that it avo=
ids

[Severity: Medium]
Is this statement entirely accurate? While zero-copy was removed from aead =
and
skcipher, it appears to still be supported and functional for AF_ALG hash
algorithms in crypto/algif_hash.c via extract_iter_to_sg().

Because of this, using splice() with AF_ALG for hashing large files can avo=
id
user-space memory copies and still outperform userspace implementations. Do=
es
this documentation need to be updated to reflect the remaining zero-copy ha=
sh
support?

> +duplicating code between kernel and userspace. However, userspace
> +implementations, especially hardware-accelerated ones, do not need to be=
 large.
> +Just because OpenSSL is huge does not mean that all userspace cryptograp=
hy
> +libraries are.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260523-af-alg-har=
den-v1-0-c76755c3a5c5@gmail.com?part=3D3
