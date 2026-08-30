Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1817839479C;
	Sun, 30 Aug 2026 14:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788100432; cv=none; b=RRQjTQvjy1295g3FCKUyGaXbIku3tueO5EThzVZeeK2CBrCQ52sSqLMF6JNP2pvD2irT9sRhd1s6wu77QWQRjVHPAOt8Uww253G60kINV+2myd/0H1G/u8c+rwmXvpn0rwWEFNq/LGKqZa4WB5KTGeo6w0fPBsmQHgkv/ND9kLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788100432; c=relaxed/simple;
	bh=PYB37Mg+/Aonkfb28xR3mkcJ5ZgpSleE+IHyj+r2zn0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z2N/zy5cz9p5aWTq2EZmertZMQWSIHgbJZO02ZDcuuuS8bBXZu4NcqXkhuDgcWDTCP4MnacQSa/F12Gg60CmA15OqFKbUCiaU+gE0/wgy0PrBNA37f0NBj11bRgpqBP+JDMa58jc/h43mEFSxbuCVI4L+4cExQ35jKlGwz0KfFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diejuQBl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diejuQBl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5CF1F000E9;
	Sun, 30 Aug 2026 14:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788100431;
	bh=PYB37Mg+/Aonkfb28xR3mkcJ5ZgpSleE+IHyj+r2zn0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=diejuQBlB4j3Mmwakk3p4i6vStCDgCz7WUDD/uyViLj0H8qnbZ6H5BQCcGNsbH9IX
	 Bfm/43ym9iQTvcejw/HbWdPdG3GdrrPpVGPJt2PmLR3Gf0hPI0B1whpYYHnpkqmnuu
	 H4lKeOmTBWF19ATFHGmhG4NIN2DnL1y+jPykg9e+rPaWNTZ3BHT1KVvJYPuaBkcNsz
	 t4b+TWYgcU4l0COIgQXDKx95JFb+m+GcWmg24fJ7WAzwA8HGNQyGq9K3p6xy5fiBwb
	 eNUeEG8EToaWGnFOk+pC0/IBLGlF+t3+YEbZV0KPOhtmyRKgvAEmNBu/ZE7CDGphTL
	 wF3uO9m25E35A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 08/14] x86: hw_breakpoint: Add a kconfig to clarify
 when a breakpoint fires
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <178810009906.64882.2914533660838879286.stgit@devnote2>
References: <178810001186.64882.2161016469449127450.stgit@devnote2>
 <178810009906.64882.2914533660838879286.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 14:33:50 +0000
Message-Id: <20260830143350.CC5CF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Add CONFIG_HAVE_POST_BREAKPOINT_HOOK which indicates the hw_breakpoint
> on that architecture fires after the target memory has been modified.
> This is currently x86 only behavior.
>=20
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178810001186.64882.=
2161016469449127450.stgit@devnote2?part=3D8

