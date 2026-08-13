Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E4829D26C
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 00:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786582455; cv=none; b=XHoQRqbiaYipRWBnxFm626HTT+XRmBpH9qldtgec82r88hNXCr30ufoaz3bt991TkzRtfm3wqHXuD3rCtapPvTvrILnFCE9+WINcNP4MFCyxP3P8ZtKoxBM1iJAIzCA/Zn6JMi3cNQzRReRUCYLbU3legZKj3PBbl0tfDP+aXOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786582455; c=relaxed/simple;
	bh=oy18cSyLpN+MfWHc241TZNAP+LBc0UoxNWHkuPvh2jM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VZVymM6a1elNuqYxwk9cn9aCwgDj4U/Ns0QtpNmGNt8ds177MTKlWt1soLjlTpsGQikIQzNwCzSxx+uDcbgWVlvMhBCKrpFXVW/RIPOEIZpawCi6kcIywGDYbJ7TfjHEQBm9HeA6I+6qhAGC/Wcuh351QnD3XuzZP4/99mAHbRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3QMZk71; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3QMZk71"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BEBE1F000E9;
	Thu, 13 Aug 2026 00:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786582454;
	bh=tg2iQ/QTvGIs71aCJQ6FcQCIwA6QWlw4HdItBQ+E6j4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h3QMZk71fhyq/vt0Wd0FNtCkf3kf+jJJs5GBGFGLBQ++yBkVrvP5Fg9HhMiz2BWij
	 toYN79R8/uSB+AfKQGzIFZbyDbFanNm57+5Rt88uuhiiqebgsHD5hMqSa1Q9VTnNkX
	 j3egDSzMY1v8QVU08RhIp8ftuzGKK1l2yv0ol8FCcJn2HGgEkfFBw/nKvvZZrf9dth
	 YU+kXkxGYe63IGcbPKW1U7HOw/Zt55OYZcRCGi8fB9Ht3Sx06zVpHMWTApqzs+6Q2d
	 RJ66FLIuDIvEaWnIwk0kdJdSJUve3DrFKesEg6Vuom9tfPOJDl0C4Csx8xcuMRR4qr
	 fi3yJa0hpapuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] perf dso: Guard close() against invalid fd in
 dso__decompress_kmodule_path()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260813004927.16738-3-acme@kernel.org>
References: <20260813004927.16738-1-acme@kernel.org>
 <20260813004927.16738-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 00:54:13 +0000
Message-Id: <20260813005414.2BEBE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> dso__decompress_kmodule_path() unconditionally calls close(fd) on the
> return value of decompress_kmodule().  When decompression fails or the
> DSO is not compressed, decompress_kmodule() returns -1.  close(-1)
> fails with EBADF and clobbers errno, which callers up the chain
> (dso__get_filename =E2=86=92 __open_dso) depend on for error propagation.
>=20
> Guard the close() call with fd >=3D 0 so only valid file descriptors are
> closed.
>=20
> Fixes: 42b3fa670825 ("perf tools: Introduce dso__decompress_kmodule_{fd,p=
ath}")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813004927.1673=
8-1-acme@kernel.org?part=3D2

