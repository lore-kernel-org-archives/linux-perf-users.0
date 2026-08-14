Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEB425F98A
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Aug 2026 01:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786669724; cv=none; b=sNIzYFd27PaFFetfqO2KfOjcGGgfYWU7itbC7nm4oct+/EPC91M2VgPqQYeBkvS37TOb122IY8H8OClzwhF4WmySV9nmWoBDjQOVmLwYQWzD5RNYGIlFUs8UhDhT0GBrZIs2FnTgpFxiksXxCkHEWMKYls5CaEQ3mqnCOA20JYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786669724; c=relaxed/simple;
	bh=AyOxPgqMTnnegtLjXUHckXVb9G5Np2xnF3908kvxTbM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bMrJPKXy8aWMqUYRzUs5qI7FgdYgf8evbG9UW/GsJmDcWMjySuPsnJc4OSBkb3PBE1uPtjZf2IxT4w3k7BR2qsmrltvcEJ9LmN0NibitLlPKAhPACAY/6MSx2EnJf9ta3vaRzFdtSZf/2z0RGdrEwQXDvu1ArMEpaN4pT7+raic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOxXHSva; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOxXHSva"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97871F000E9;
	Fri, 14 Aug 2026 01:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786669722;
	bh=AyOxPgqMTnnegtLjXUHckXVb9G5Np2xnF3908kvxTbM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TOxXHSvaHJOEBFpx7MT8D3ZIlEB3y+9lEPremCBqdG2QVGh1ITliIvGBTVGTn6weI
	 fssFqCkIA7OidhlAkPBl9lIEHr4BJ6CzprQ1e00zO3o2xKtxG9/8GnxxSGWyOPSJ6K
	 tRjpL8dAiTgmjwoTRM0WAdaqyoplQn+MxGTJYXaItbSvQpI7z5Ky7N0DFWbHNln8Mg
	 s2Zla2jrntqgCl+4JkrWpGFEg0bNb1m3PYwPt1ZkJZvIP1Sy+kAMMNECgtAKw7eyBT
	 jAetXcVPed4DRQVQ1rKf74kSF9SdLGf7W6Djfj1YHMIl7Db89GSODxkYjUtMJHHv1w
	 af/lLIguLNcvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] perf tools top: Add --weight option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260813211109.240689-3-ak@linux.intel.com>
References: <20260813211109.240689-1-ak@linux.intel.com>
 <20260813211109.240689-3-ak@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 01:08:37 +0000
Message-Id: <20260814010842.A97871F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add a -W/--weight option to perf top to collect weights too. Useful with
> follow on patches.
>=20
> Assisted-by: omp:GPT-5.6-Luna
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813211109.2406=
89-1-ak@linux.intel.com?part=3D2

