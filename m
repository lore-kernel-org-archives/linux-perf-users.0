Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A17234964
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 01:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790644725; cv=none; b=DbuqIgy/vxpp9OWI7AgXMhOYiEkclmGntKk9/z5X6WBdntVLYV3MSO7heptSvfEgV5KxVNXJyfoN7xvEm/VD3ug6zEa0WdzkKPoW2YhZxKygDC0p/ui6o7ykILApNaaZhotC4eBDluFnigq7Zh7ioEbORnWMhIT2tPNNwAROcic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790644725; c=relaxed/simple;
	bh=1d42orxkdLeJChZ/e7kD6a7nuFxchDXZYrt/WhudOmA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rTgv71jNI2nHslmxJNkYr+hMQz9C32Scvl/KzkIYROVoHe+kD298pwCetqHAahdCkh5LLb+bwDCMPTtR/4mC1TiRMGA8dTBbVWF3TGHDH3HV0Whr2mrDTHRRuLeLTTE5dulYAbJpvuQ6Ek+63T4/GJA8XliWBkafaEVlro7HueI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEn0z155; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEn0z155"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38AC91F00899;
	Tue, 29 Sep 2026 01:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790644723;
	bh=1d42orxkdLeJChZ/e7kD6a7nuFxchDXZYrt/WhudOmA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aEn0z155ye6OPIbdIcoi96I1LiSxSxlcN/K+F3nIbS944aPKXA9aaxQD7QkGrb//y
	 1EEdv5TilLrgCrVX7dV/3pex8GyEZQmsljpjltNZMURyxpgrqRd2tavRmYzKHnD3Et
	 /+Wnj3JY7HwRoffZji592wJk44eoDHCcryxeYk1RK7K45BlAIKe1xc2v2pVbnugUNG
	 tqGqgHgFXAVfWqFZaDuMcTL5QGnQnTaaDvJ6fftrb/bM/NL8JpzxMU6ra3UmRQKLUx
	 6jpfWfTEJCxtlrq0f7j6bcEKqcZKr53Uujqzm4Sv5qXcpgu2oc3nFiJ0LTshynkO1f
	 GwnKbs7o2NOuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 8/8] perf tools: Update debuginfo__new() to take DSO
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929011139.53242-9-namhyung@kernel.org>
References: <20260929011139.53242-1-namhyung@kernel.org>
 <20260929011139.53242-9-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 01:18:42 +0000
Message-Id: <20260929011843.38AC91F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> It should be the common case to get debuginfo from existing DSOs.
> Now dso__debuginfo() calls it with its debuginfo type to avoid the
> unnecessary loop to find the location of debug file.
>=20
> Update existing function to debuginfo__from_path() for clarity.
>=20
> Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929011139.5324=
2-1-namhyung@kernel.org?part=3D8

